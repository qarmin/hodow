// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cComputeShaderTests.cpp
//   external/openglcts/modules/gl/gl4cComputeShaderTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case classes are `Subcase`s (see `subcase.rs`); `ComputeShaderBase`'s helpers are free functions.

use std::ffi::{CStr, CString, c_void};

use super::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult, TestSubcase, output_not_supported};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const GLSL_VER: &str = "#version 430 core\n";

type UVec3 = [u32; 3];
type Vec4 = [f32; 4];
type UVec4 = [u32; 4];

fn product(local_size: UVec3, num_groups: UVec3) -> u32 {
    (0..3).map(|i| local_size[i] * num_groups[i]).product()
}

fn buffer_to_string(buffer: &[u8]) -> String {
    let end = buffer.iter().position(|&byte| byte == 0).unwrap_or(buffer.len());
    String::from_utf8_lossy(&buffer[..end]).into_owned()
}

fn get_program_value(gl: &glw::Functions, program: GLuint, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_programiv(program, pname, &mut value));
    value
}

/// `CheckProgram`
pub(super) fn check_program(gl: &glw::Functions, program: GLuint) -> bool {
    let mut compile_status = glw::GL_TRUE as GLint;
    let status = get_program_value(gl, program, glw::GL_LINK_STATUS);
    if status == glw::GL_FALSE as GLint {
        let attached_shaders = get_program_value(gl, program, glw::GL_ATTACHED_SHADERS);
        if attached_shaders > 0 {
            let mut shaders = vec![0 as GLuint; attached_shaders as usize];
            gl!(gl.get_attached_shaders(program, attached_shaders, std::ptr::null_mut(), shaders.as_mut_ptr()));
            for &shader in &shaders {
                let mut shader_type = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_TYPE, &mut shader_type));
                log::info!(
                    "*** {} Shader ***",
                    match shader_type as GLenum {
                        glw::GL_VERTEX_SHADER => "Vertex",
                        glw::GL_TESS_CONTROL_SHADER => "Tessellation Control",
                        glw::GL_TESS_EVALUATION_SHADER => "Tessellation Evaluation",
                        glw::GL_GEOMETRY_SHADER => "Geometry",
                        glw::GL_FRAGMENT_SHADER => "Fragment",
                        glw::GL_COMPUTE_SHADER => "Compute",
                        _ => "Unknown",
                    }
                );
                let mut result = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut result));
                if result != glw::GL_TRUE as GLint {
                    compile_status = result;
                }
                let mut length = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, &mut length));
                if length > 0 {
                    let mut source = vec![0u8; length as usize];
                    gl!(gl.get_shader_source(shader, length, std::ptr::null_mut(), source.as_mut_ptr().cast()));
                    log::info!("{}", buffer_to_string(&source));
                }
                gl!(gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length));
                if length > 0 {
                    let mut info_log = vec![0u8; length as usize];
                    gl!(gl.get_shader_info_log(shader, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
                    log::info!("{}", buffer_to_string(&info_log));
                }
            }
        }
        let length = get_program_value(gl, program, glw::GL_INFO_LOG_LENGTH);
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            log::info!("{}", buffer_to_string(&info_log));
        }
    }
    if compile_status != glw::GL_TRUE as GLint {
        return false;
    }
    status == glw::GL_TRUE as GLint
}

fn attach_shader_source(gl: &glw::Functions, program: GLuint, shader_type: GLenum, source: &str) {
    let version = CString::new(GLSL_VER).expect("no nul byte");
    let source = CString::new(source).expect("shader source holds no nul byte");
    let sources = [version.as_ptr(), source.as_ptr()];
    let shader = gl!(gl.create_shader(shader_type));
    gl!(gl.attach_shader(program, shader));
    gl!(gl.delete_shader(shader));
    gl!(gl.shader_source(shader, 2, sources.as_ptr(), std::ptr::null()));
    gl!(gl.compile_shader(shader));
}

/// `CreateComputeProgram`
pub(super) fn create_compute_program(gl: &glw::Functions, cs: &str) -> GLuint {
    let program = gl!(gl.create_program());
    if !cs.is_empty() {
        attach_shader_source(gl, program, glw::GL_COMPUTE_SHADER, cs);
    }
    program
}

/// `CreateProgram`
fn create_program(gl: &glw::Functions, vs: &str, fs: &str) -> GLuint {
    let program = gl!(gl.create_program());
    if !vs.is_empty() {
        attach_shader_source(gl, program, glw::GL_VERTEX_SHADER, vs);
    }
    if !fs.is_empty() {
        attach_shader_source(gl, program, glw::GL_FRAGMENT_SHADER, fs);
    }
    program
}

/// A buffer of `size` bytes read back through `glMapBufferRange`, as every case does after the barrier.
fn read_mapped<T: Copy>(gl: &glw::Functions, target: GLenum, count: usize) -> Vec<T> {
    let pointer = gl!(gl.map_buffer_range(
        target,
        0,
        (count * std::mem::size_of::<T>()) as isize,
        glw::GL_MAP_READ_BIT
    ))
    .cast::<T>();
    // SAFETY: `count` elements were mapped for reading, they are copied out before the unmap.
    let data = unsafe { std::slice::from_raw_parts(pointer, count) }.to_vec();
    gl!(gl.unmap_buffer(target));
    data
}

fn dispatch(gl: &glw::Functions, dispatch_buffer: &mut GLuint, num_groups: UVec3, dispatch_indirect: bool) {
    if dispatch_indirect {
        if *dispatch_buffer == 0 {
            gl!(gl.gen_buffers(1, dispatch_buffer));
        }
        gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, *dispatch_buffer));
        gl!(gl.buffer_data(
            glw::GL_DISPATCH_INDIRECT_BUFFER,
            std::mem::size_of_val(&num_groups) as isize,
            num_groups.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.dispatch_compute_indirect(0));
    } else {
        gl!(gl.dispatch_compute(num_groups[0], num_groups[1], num_groups[2]));
    }
}

/// `SimpleCompute`
#[derive(Default)]
struct SimpleCompute {
    program: GLuint,
    buffer: GLuint,
}

impl Subcase for SimpleCompute {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1, local_size_y = 1) in;\nlayout(std430) buffer Output {\n  vec4 data;\n} g_out;\nvoid main() {\n  g_out.data = vec4(1.0, 2.0, 3.0, 4.0);\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        let mut v = [0 as GLint; 3];
        gl!(gl.get_programiv(self.program, glw::GL_COMPUTE_WORK_GROUP_SIZE, v.as_mut_ptr()));
        if v != [1, 1, 1] {
            log::info!(
                "Got {}, {}, {}, expected: 1, 1, 1 in GL_COMPUTE_WORK_GROUP_SIZE check",
                v[0],
                v[1],
                v[2]
            );
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            16,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let data = read_mapped::<Vec4>(gl, glw::GL_SHADER_STORAGE_BUFFER, 1);
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
        Ok(if data[0] == [1.0, 2.0, 3.0, 4.0] {
            NO_ERROR
        } else {
            ERROR
        })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicOneWorkGroup`
#[derive(Default)]
struct BasicOneWorkGroup {
    program: GLuint,
    storage_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl BasicOneWorkGroup {
    fn gen_source(x: i32, y: i32, z: i32, binding: GLuint) -> String {
        format!(
            "\nlayout(local_size_x = {x}, local_size_y = {y}, local_size_z = {z}) in;\nlayout(std430, binding = {binding}) buffer Output {{\n  uvec4 local_id[];\n}} g_out;\nvoid main() {{\n  if (gl_WorkGroupSize == uvec3({x}, {y}, {z}) && gl_WorkGroupID == uvec3(0) &&\n      gl_GlobalInvocationID == gl_LocalInvocationID) {{\n    g_out.local_id[gl_LocalInvocationIndex] = uvec4(gl_LocalInvocationID, 0);\n  }} else {{\n    g_out.local_id[gl_LocalInvocationIndex] = uvec4(0xffff);\n  }}\n}}"
        )
    }

    fn run_iteration(
        &mut self,
        gl: &glw::Functions,
        local_size: [i32; 3],
        binding: GLuint,
        dispatch_indirect: bool,
    ) -> bool {
        let [local_size_x, local_size_y, local_size_z] = local_size;
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size_x, local_size_y, local_size_z, binding));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        let mut v = [0 as GLint; 3];
        gl!(gl.get_programiv(self.program, glw::GL_COMPUTE_WORK_GROUP_SIZE, v.as_mut_ptr()));
        if v != local_size {
            log::info!(
                "GL_COMPUTE_LOCAL_WORK_SIZE is ({} {} {}) should be ({local_size_x} {local_size_y} {local_size_z})",
                v[0],
                v[1],
                v[2]
            );
            return false;
        }

        let size = (local_size_x * local_size_y * local_size_z) as usize;
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, binding, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (16 * size) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, [1, 1, 1], dispatch_indirect);

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let data = read_mapped::<UVec4>(gl, glw::GL_SHADER_STORAGE_BUFFER, size);
        let mut ret = true;
        for z in 0..local_size_z {
            for y in 0..local_size_y {
                for x in 0..local_size_x {
                    let index = (z * local_size_x * local_size_y + y * local_size_x + x) as usize;
                    if data[index] != [x as u32, y as u32, z as u32, 0] {
                        log::info!("Invalid data at offset {index}");
                        ret = false;
                    }
                }
            }
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
        ret
    }
}

impl Subcase for BasicOneWorkGroup {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let iterations = [
            ([16, 1, 1], 0, true),
            ([8, 8, 1], 1, false),
            ([4, 4, 4], 2, true),
            ([1, 2, 3], 3, false),
            ([1024, 1, 1], 3, true),
            ([16, 8, 8], 3, false),
            ([32, 1, 32], 7, true),
        ];
        for (local_size, binding, dispatch_indirect) in iterations {
            if !self.run_iteration(gl, local_size, binding, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicResourceUBO`
#[derive(Default)]
struct BasicResourceUbo {
    program: GLuint,
    storage_buffer: GLuint,
    uniform_buffer: [GLuint; 12],
    dispatch_buffer: GLuint,
}

impl BasicResourceUbo {
    fn gen_source(local_size: UVec3, num_groups: UVec3) -> String {
        let global_size = [
            local_size[0] * num_groups[0],
            local_size[1] * num_groups[1],
            local_size[2] * num_groups[2],
        ];
        let count = global_size[0] * global_size[1] * global_size[2];
        let mut ss = format!(
            "\nlayout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\nconst uvec3 kGlobalSize = uvec3({}, {}, {});\nlayout(std140) uniform InputBuffer {{\n  vec4 data[{count}];\n}} g_in_buffer[12];\nlayout(std430) buffer OutputBuffer {{",
            local_size[0], local_size[1], local_size[2], global_size[0], global_size[1], global_size[2]
        );
        for i in 0..12 {
            ss.push_str(&format!("\n  vec4 data{i}[{count}];"));
        }
        ss.push_str("\n} g_out_buffer;\nvoid main() {\n  const uint global_index = gl_GlobalInvocationID.x +\n                            gl_GlobalInvocationID.y * kGlobalSize.x +\n                            gl_GlobalInvocationID.z * kGlobalSize.x * kGlobalSize.y;");
        for i in 0..12 {
            ss.push_str(&format!(
                "\n  g_out_buffer.data{i}[global_index] = g_in_buffer[{i}].data[global_index];"
            ));
        }
        ss.push_str("\n}");
        ss
    }

    fn run_iteration(
        &mut self,
        gl: &glw::Functions,
        local_size: UVec3,
        num_groups: UVec3,
        dispatch_indirect: bool,
    ) -> bool {
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size, num_groups));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        for i in 0..12 {
            let name = CString::new(format!("InputBuffer[{i}]")).expect("no nul byte");
            let index = gl!(gl.get_uniform_block_index(self.program, name.as_ptr()));
            gl!(gl.uniform_block_binding(self.program, index, i));
            let mut p = 0;
            gl!(gl.get_active_uniform_blockiv(
                self.program,
                index,
                glw::GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER,
                &mut p
            ));
            if p == glw::GL_FALSE as GLint {
                log::info!("UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER should be TRUE.");
                return false;
            }
        }

        let buffer_size = product(local_size, num_groups) as usize;
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (16 * buffer_size * 12) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        if self.uniform_buffer[0] == 0 {
            gl!(gl.gen_buffers(12, self.uniform_buffer.as_mut_ptr()));
        }
        for i in 0..12usize {
            let data: Vec<Vec4> = (0..buffer_size).map(|j| [(i * buffer_size + j) as f32; 4]).collect();
            gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, i as GLuint, self.uniform_buffer[i]));
            gl!(gl.buffer_data(
                glw::GL_UNIFORM_BUFFER,
                (16 * buffer_size) as isize,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            ));
        }
        gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, num_groups, dispatch_indirect);

        let mut data = vec![[0.0f32; 4]; buffer_size * 12];
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (16 * buffer_size * 12) as isize,
            data.as_mut_ptr().cast()
        ));
        let width = local_size[0] * num_groups[0];
        let height = local_size[1] * num_groups[1];
        let depth = local_size[2] * num_groups[2];
        for z in 0..depth {
            for y in 0..height {
                for x in 0..width {
                    let index = (z * width * height + y * width + x) as usize;
                    // upstream's loop over `i` runs once
                    if data[index * 12] != [(index * 12) as f32; 4] {
                        log::info!("Incorrect data at offset {}.", index * 12);
                        return false;
                    }
                }
            }
        }
        true
    }
}

impl Subcase for BasicResourceUbo {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let iterations = [
            ([64, 1, 1], [8, 1, 1], false),
            ([2, 2, 2], [2, 2, 2], true),
            ([2, 4, 2], [2, 4, 1], false),
        ];
        for (local_size, num_groups, dispatch_indirect) in iterations {
            if !self.run_iteration(gl, local_size, num_groups, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(12, self.uniform_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicResourceTexture`
#[derive(Default)]
struct BasicResourceTexture {
    program: GLuint,
    storage_buffer: GLuint,
    texture: [GLuint; 9],
    texture_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl BasicResourceTexture {
    fn gen_source(local_size: UVec3, num_groups: UVec3) -> String {
        let global_size = [
            local_size[0] * num_groups[0],
            local_size[1] * num_groups[1],
            local_size[2] * num_groups[2],
        ];
        let count = global_size[0] * global_size[1] * global_size[2];
        let mut ss = format!(
            "\nlayout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\nconst uvec3 kGlobalSize = uvec3({}, {}, {});\nuniform sampler1D g_sampler0;\nuniform sampler2D g_sampler1;\nuniform sampler3D g_sampler2;\nuniform sampler2DRect g_sampler3;\nuniform sampler1DArray g_sampler4;\nuniform sampler2DArray g_sampler5;\nuniform samplerBuffer g_sampler6;\nuniform sampler2DMS g_sampler7;\nuniform sampler2DMSArray g_sampler8;\nlayout(std430) buffer OutputBuffer {{",
            local_size[0], local_size[1], local_size[2], global_size[0], global_size[1], global_size[2]
        );
        for i in 0..9 {
            ss.push_str(&format!("\n  vec4 data{i}[{count}];"));
        }
        ss.push_str("\n} g_out_buffer;\nvoid main() {\n  const uint global_index = gl_GlobalInvocationID.x +\n                            gl_GlobalInvocationID.y * kGlobalSize.x +\n                            gl_GlobalInvocationID.z * kGlobalSize.x * kGlobalSize.y;\n  g_out_buffer.data0[global_index] = texelFetch(g_sampler0, int(gl_GlobalInvocationID), 0);\n  g_out_buffer.data1[global_index] = texture(g_sampler1, vec2(gl_GlobalInvocationID) / vec2(kGlobalSize));\n  g_out_buffer.data2[global_index] = textureProj(g_sampler2, vec4(vec3(gl_GlobalInvocationID) / vec3(kGlobalSize), 1.0));\n  g_out_buffer.data3[global_index] = textureProjOffset(g_sampler3, vec3(vec2(gl_GlobalInvocationID), 1.0), ivec2(0));\n  g_out_buffer.data4[global_index] = textureLodOffset(g_sampler4, vec2(gl_GlobalInvocationID.x / kGlobalSize.x, gl_GlobalInvocationID.y), 0.0, 0);\n  g_out_buffer.data5[global_index] = texelFetchOffset(g_sampler5, ivec3(gl_GlobalInvocationID), 0, ivec2(0));\n  g_out_buffer.data6[global_index] = texelFetch(g_sampler6, int(global_index));\n  g_out_buffer.data7[global_index] = texelFetch(g_sampler7, ivec2(gl_GlobalInvocationID), 1);\n  g_out_buffer.data8[global_index] = texelFetch(g_sampler8, ivec3(gl_GlobalInvocationID), 2);\n}");
        ss
    }

    fn set_nearest(gl: &glw::Functions, target: GLenum) {
        gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
    }

    fn run_iteration(
        &mut self,
        gl: &glw::Functions,
        local_size: UVec3,
        num_groups: UVec3,
        dispatch_indirect: bool,
    ) -> bool {
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size, num_groups));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        gl!(gl.use_program(self.program));
        for i in 0..9 {
            let name = CString::new(format!("g_sampler{i}")).expect("no nul byte");
            let location = gl!(gl.get_uniform_location(self.program, name.as_ptr()));
            gl!(gl.uniform_1i(location, i));
        }
        gl!(gl.use_program(0));

        let buffer_size = product(local_size, num_groups) as usize;
        let width = (local_size[0] * num_groups[0]) as GLint;
        let height = (local_size[1] * num_groups[1]) as GLint;
        let depth = (local_size[2] * num_groups[2]) as GLint;

        let mut buffer_data = vec![[0.0f32; 4]; buffer_size * 9];
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (16 * buffer_size * 9) as isize,
            buffer_data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        let texture_data = vec![[123.0f32; 4]; buffer_size];
        let pixels: *const c_void = texture_data.as_ptr().cast();
        if self.texture[0] == 0 {
            gl!(gl.gen_textures(9, self.texture.as_mut_ptr()));
        }
        if self.texture_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.texture_buffer));
        }

        let rgba32f = glw::GL_RGBA32F as GLint;
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_1D, self.texture[0]));
        Self::set_nearest(gl, glw::GL_TEXTURE_1D);
        gl!(gl.tex_image_1d(
            glw::GL_TEXTURE_1D,
            0,
            rgba32f,
            width,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            pixels
        ));

        gl!(gl.active_texture(glw::GL_TEXTURE1));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[1]));
        Self::set_nearest(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            rgba32f,
            width,
            height,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            pixels
        ));

        gl!(gl.active_texture(glw::GL_TEXTURE2));
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, self.texture[2]));
        Self::set_nearest(gl, glw::GL_TEXTURE_3D);
        gl!(gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            rgba32f,
            width,
            height,
            depth,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            pixels
        ));

        gl!(gl.active_texture(glw::GL_TEXTURE3));
        gl!(gl.bind_texture(glw::GL_TEXTURE_RECTANGLE, self.texture[3]));
        Self::set_nearest(gl, glw::GL_TEXTURE_RECTANGLE);
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_RECTANGLE,
            0,
            rgba32f,
            width,
            height,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            pixels
        ));

        gl!(gl.active_texture(glw::GL_TEXTURE4));
        gl!(gl.bind_texture(glw::GL_TEXTURE_1D_ARRAY, self.texture[4]));
        Self::set_nearest(gl, glw::GL_TEXTURE_1D_ARRAY);
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_1D_ARRAY,
            0,
            rgba32f,
            width,
            height,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            pixels
        ));

        gl!(gl.active_texture(glw::GL_TEXTURE5));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.texture[5]));
        Self::set_nearest(gl, glw::GL_TEXTURE_2D_ARRAY);
        gl!(gl.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            rgba32f,
            width,
            height,
            depth,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            pixels
        ));

        gl!(gl.active_texture(glw::GL_TEXTURE6));
        gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, self.texture_buffer));
        gl!(gl.buffer_data(
            glw::GL_TEXTURE_BUFFER,
            (buffer_size * 16) as isize,
            pixels,
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture[6]));
        gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA32F, self.texture_buffer));

        gl!(gl.active_texture(glw::GL_TEXTURE7));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, self.texture[7]));
        gl!(gl.tex_image_2d_multisample(
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            4,
            glw::GL_RGBA32F,
            width,
            height,
            glw::FALSE
        ));

        gl!(gl.active_texture(glw::GL_TEXTURE8));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, self.texture[8]));
        gl!(gl.tex_image_3d_multisample(
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
            4,
            glw::GL_RGBA32F,
            width,
            height,
            depth,
            glw::FALSE
        ));

        // clear MS textures
        let mut fbo: GLuint = 0;
        let clear_color = [123.0f32; 4];
        gl!(gl.gen_framebuffers(1, &mut fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
        gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, self.texture[7], 0));
        gl!(gl.clear_bufferfv(glw::GL_COLOR, 0, clear_color.as_ptr()));
        gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, self.texture[8], 0));
        gl!(gl.clear_bufferfv(glw::GL_COLOR, 0, clear_color.as_ptr()));
        gl!(gl.delete_framebuffers(1, &fbo));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, num_groups, dispatch_indirect);

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (16 * buffer_size * 9) as isize,
            buffer_data.as_mut_ptr().cast()
        ));
        for (index, value) in buffer_data.iter().enumerate() {
            if *value != [123.0; 4] {
                log::info!("Incorrect data at index {index}.");
                return false;
            }
        }
        true
    }
}

impl Subcase for BasicResourceTexture {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let iterations = [
            ([4, 4, 4], [8, 1, 1], false),
            ([2, 4, 2], [2, 4, 1], true),
            ([2, 2, 2], [2, 2, 2], false),
        ];
        for (local_size, num_groups, dispatch_indirect) in iterations {
            if !self.run_iteration(gl, local_size, num_groups, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_textures(9, self.texture.as_ptr()));
        gl!(gl.delete_buffers(1, &self.texture_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `ComputeShaderBase::g_color_eps`
fn color_eps(context: &Context) -> Vec4 {
    let render_target = context.render_target();
    let epsilon_zero = 1.0 / (1 << 13) as f32;
    let step = |bits: i32| 1.0 / ((1 << bits) as f32 - 1.0);
    if render_target.red_bits != 0
        && render_target.green_bits != 0
        && render_target.blue_bits != 0
        && render_target.alpha_bits != 0
    {
        [
            step(render_target.red_bits.min(8)) + epsilon_zero,
            step(render_target.green_bits.min(8)) + epsilon_zero,
            step(render_target.blue_bits.min(8)) + epsilon_zero,
            step(render_target.alpha_bits) + epsilon_zero,
        ]
    } else if render_target.red_bits != 0 && render_target.green_bits != 0 && render_target.blue_bits != 0 {
        [
            step(render_target.red_bits) + epsilon_zero,
            step(render_target.green_bits) + epsilon_zero,
            step(render_target.blue_bits) + epsilon_zero,
            1.0 + epsilon_zero,
        ]
    } else {
        [epsilon_zero; 4]
    }
}

/// `ColorEqual`
fn color_equal(c0: Vec4, c1: Vec4, epsilon: Vec4) -> bool {
    (0..4).all(|i| (c0[i] - c1[i]).abs() <= epsilon[i])
}

/// `BasicResourceImage`
#[derive(Default)]
struct BasicResourceImage {
    program: GLuint,
    draw_program: GLuint,
    texture: [GLuint; 2],
    dispatch_buffer: GLuint,
    vertex_array: GLuint,
}

impl BasicResourceImage {
    fn gen_source(local_size: UVec3, num_groups: UVec3) -> String {
        let global_size = [
            local_size[0] * num_groups[0],
            local_size[1] * num_groups[1],
            local_size[2] * num_groups[2],
        ];
        format!(
            "\nlayout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\nlayout(rgba32f) coherent uniform image2D g_image1;\nlayout(rgba32f) uniform image2D g_image2;\nconst uvec3 kGlobalSize = uvec3({}, {}, {});\nvoid main() {{\n  if (gl_GlobalInvocationID.x >= kGlobalSize.x || gl_GlobalInvocationID.y >= kGlobalSize.y) return;\n  vec4 color = vec4(gl_GlobalInvocationID.x + gl_GlobalInvocationID.y) / 255.0;\n  imageStore(g_image1, ivec2(gl_GlobalInvocationID), color);\n  vec4 c = imageLoad(g_image1, ivec2(gl_GlobalInvocationID));\n  imageStore(g_image2, ivec2(gl_GlobalInvocationID), c);\n}}",
            local_size[0], local_size[1], local_size[2], global_size[0], global_size[1], global_size[2]
        )
    }

    fn run_iteration(
        &mut self,
        context: &Context,
        local_size: UVec3,
        num_groups: UVec3,
        dispatch_indirect: bool,
    ) -> bool {
        let gl = context.gl();
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size, num_groups));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        gl!(gl.use_program(self.program));
        let location = gl!(gl.get_uniform_location(self.program, c"g_image1".as_ptr()));
        gl!(gl.uniform_1i(location, 0));
        let location = gl!(gl.get_uniform_location(self.program, c"g_image2".as_ptr()));
        gl!(gl.uniform_1i(location, 1));
        gl!(gl.use_program(0));

        let width = (local_size[0] * num_groups[0]) as GLint;
        let height = (local_size[1] * num_groups[1]) as GLint;
        let depth = (local_size[2] * num_groups[2]) as GLint;
        let size = (width * height * depth) as usize;
        let data = vec![[0.0f32; 4]; size];
        if self.texture[0] == 0 {
            gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        }
        for texture in self.texture {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32F as GLint,
                width,
                height,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                data.as_ptr().cast()
            ));
        }
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
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
            glw::GL_WRITE_ONLY,
            glw::GL_RGBA32F
        ));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, num_groups, dispatch_indirect);

        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[0]));
        gl!(gl.active_texture(glw::GL_TEXTURE1));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[1]));
        gl!(gl.use_program(self.draw_program));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 1));

        let mut display = vec![[0.0f32; 4]; (width * height) as usize];
        gl!(gl.read_pixels(
            0,
            0,
            width,
            height,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            display.as_mut_ptr().cast()
        ));
        let render_target = context.render_target();
        let eps = color_eps(context);
        for y in 0..height {
            for x in 0..width {
                if y >= render_target.height || x >= render_target.width {
                    continue;
                }
                let c = [(y + x) as f32 / 255.0; 4];
                let got = display[(y * width + x) as usize];
                if !color_equal(got, c, eps) {
                    log::info!(
                        "Got {}, {}, {}, {}, expected {}, {}, {}, {} at {x}, {y}",
                        got[0],
                        got[1],
                        got[2],
                        got[3],
                        c[0],
                        c[1],
                        c[2],
                        c[3]
                    );
                    return false;
                }
            }
        }
        true
    }
}

impl Subcase for BasicResourceImage {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "\nout StageData {\n  vec2 texcoord;\n} vs_out;\nconst vec2 g_quad[] = vec2[](vec2(-1, -1), vec2(1, -1), vec2(-1, 1), vec2(1, 1));\nvoid main() {\n  gl_Position = vec4(g_quad[gl_VertexID], 0, 1);\n  vs_out.texcoord = 0.5 + 0.5 * g_quad[gl_VertexID];\n}";
        let glsl_fs = "\nin StageData {\n  vec2 texcoord;\n} fs_in;\nlayout(location = 0) out vec4 o_color;\nuniform sampler2D g_image1;\nuniform sampler2D g_image2;\nvoid main() {\n  vec4 c1 = texture(g_image1, fs_in.texcoord);\n  vec4 c2 = texture(g_image2, fs_in.texcoord);\n  if (c1 == c2) o_color = c1;\n  else o_color = vec4(1, 0, 0, 1);\n}";
        self.draw_program = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.draw_program));
        if !check_program(gl, self.draw_program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.draw_program));
        let location = gl!(gl.get_uniform_location(self.draw_program, c"g_image1".as_ptr()));
        gl!(gl.uniform_1i(location, 0));
        let location = gl!(gl.get_uniform_location(self.draw_program, c"g_image2".as_ptr()));
        gl!(gl.uniform_1i(location, 1));
        gl!(gl.use_program(0));

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));

        if context.render_target().alpha_bits == 0 {
            log::info!("Test requires default framebuffer alpha bits");
            return Ok(NO_ERROR);
        }

        let iterations = [
            ([8, 16, 1], [8, 4, 1], true),
            ([4, 32, 1], [16, 2, 1], false),
            ([16, 4, 1], [4, 16, 1], false),
            ([8, 8, 1], [8, 8, 1], true),
        ];
        for (local_size, num_groups, dispatch_indirect) in iterations {
            if !self.run_iteration(context, local_size, num_groups, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_program(self.draw_program));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        Ok(NO_ERROR)
    }
}

/// `BasicResourceAtomicCounter`
#[derive(Default)]
struct BasicResourceAtomicCounter {
    program: GLuint,
    storage_buffer: GLuint,
    counter_buffer: [GLuint; 2],
    dispatch_buffer: GLuint,
}

impl BasicResourceAtomicCounter {
    fn gen_source(local_size: UVec3, num_groups: UVec3) -> String {
        let count = product(local_size, num_groups);
        format!(
            "\nlayout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\nlayout(std430, binding = 0) buffer Output {{\n  uint inc_data[{count}];\n  uint dec_data[{count}];\n}};\nlayout(binding = 0, offset = 0) uniform atomic_uint g_inc_counter;\nlayout(binding = 1, offset = 0) uniform atomic_uint g_dec_counter;\nvoid main() {{\n  const uint index = atomicCounterIncrement(g_inc_counter);\n  inc_data[index] = index;\n  dec_data[index] = atomicCounterDecrement(g_dec_counter);\n}}",
            local_size[0], local_size[1], local_size[2]
        )
    }

    fn write_counter(gl: &glw::Functions, value: GLuint) {
        let pointer = gl!(gl.map_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_WRITE_ONLY)).cast::<GLuint>();
        // SAFETY: a 4 byte buffer was just allocated and is mapped for writing.
        unsafe { pointer.write(value) };
        gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));
    }

    fn run_iteration(
        &mut self,
        gl: &glw::Functions,
        local_size: UVec3,
        num_groups: UVec3,
        dispatch_indirect: bool,
    ) -> bool {
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size, num_groups));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        let mut p = [0 as GLint; 2];
        gl!(gl.get_active_atomic_counter_bufferiv(
            self.program,
            0,
            glw::GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER,
            &mut p[0]
        ));
        gl!(gl.get_active_atomic_counter_bufferiv(
            self.program,
            1,
            glw::GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER,
            &mut p[1]
        ));
        if p[0] == glw::GL_FALSE as GLint || p[1] == glw::GL_FALSE as GLint {
            log::info!("ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER should be TRUE.");
            return false;
        }

        let size = product(local_size, num_groups);
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * size * 2) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        if self.counter_buffer[0] == 0 {
            gl!(gl.gen_buffers(2, self.counter_buffer.as_mut_ptr()));
        }
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer[0]));
        gl!(gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 4, std::ptr::null(), glw::GL_STREAM_DRAW));
        Self::write_counter(gl, 0);
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 1, self.counter_buffer[1]));
        gl!(gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 4, std::ptr::null(), glw::GL_STREAM_DRAW));
        Self::write_counter(gl, size);
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, num_groups, dispatch_indirect);

        let mut data = vec![0 as GLuint; size as usize];
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (4 * size) as isize,
            data.as_mut_ptr().cast()
        ));
        for (i, &value) in data.iter().enumerate() {
            if value != i as GLuint {
                log::info!("Value at index {i} is {value} should be {i}.");
                return false;
            }
        }

        let mut value: GLuint = 0;
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.counter_buffer[0]));
        gl!(gl.get_buffer_sub_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut value).cast()
        ));
        if value != size {
            log::info!("Final atomic counter value (buffer 0) is {value} should be {size}.");
            return false;
        }
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.counter_buffer[1]));
        gl!(gl.get_buffer_sub_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut value).cast()
        ));
        if value != 0 {
            log::info!("Final atomic counter value (buffer 1) is {value} should be 0.");
            return false;
        }
        true
    }
}

impl Subcase for BasicResourceAtomicCounter {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let iterations = [
            ([4, 3, 2], [2, 3, 4], false),
            ([1, 1, 1], [1, 1, 1], true),
            ([1, 6, 1], [1, 1, 8], false),
            ([4, 1, 2], [10, 3, 4], true),
        ];
        for (local_size, num_groups, dispatch_indirect) in iterations {
            if !self.run_iteration(gl, local_size, num_groups, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.counter_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicResourceSubroutine`
#[derive(Default)]
struct BasicResourceSubroutine {
    program: GLuint,
    atomic_counter_buffer: GLuint,
    storage_buffer: [GLuint; 2],
    buffer: [GLuint; 2],
    texture_buffer: [GLuint; 2],
}

fn upload_uvec4s(gl: &glw::Functions, target: GLenum, buffer: GLuint, first_value: u32, usage: GLenum) {
    let data: Vec<UVec4> = (0..16).map(|i| [i + first_value; 4]).collect();
    gl!(gl.bind_buffer(target, buffer));
    gl!(gl.buffer_data(target, (16 * data.len()) as isize, data.as_ptr().cast(), usage));
}

impl Subcase for BasicResourceSubroutine {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 16) in;\nlayout(binding = 1, std430) buffer Input {\n  uvec4 data[16];\n} g_input;\nlayout(std430, binding = 0) buffer Output {\n  uvec4 g_output[64];\n};\nsubroutine void ComputeType();\nsubroutine uniform ComputeType Compute[4];\nlayout(binding = 0, offset = 0) uniform atomic_uint g_atomic_counter;\nlayout(rgba32ui) readonly uniform uimageBuffer g_image_buffer;\nuniform usamplerBuffer g_sampler_buffer;\nsubroutine(ComputeType)\nvoid Compute0() {\n  const uint index = atomicCounterIncrement(g_atomic_counter);\n  g_output[index] = uvec4(index);\n}\nsubroutine(ComputeType)\nvoid Compute1() {\n  g_output[gl_GlobalInvocationID.x] = g_input.data[gl_LocalInvocationIndex];\n}\nsubroutine(ComputeType)\nvoid Compute2() {\n  g_output[gl_GlobalInvocationID.x] = imageLoad(g_image_buffer, int(gl_LocalInvocationIndex));\n}\nsubroutine(ComputeType)\nvoid Compute3() {\n  g_output[gl_GlobalInvocationID.x] = texelFetch(g_sampler_buffer, int(gl_LocalInvocationIndex));\n}\nvoid main() {\n  Compute[gl_WorkGroupID.x]();\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.storage_buffer.as_mut_ptr()));
        // output buffer
        {
            let data = vec![[0xffffu32; 4]; 64];
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[0]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                16 * 64,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            ));
        }
        // input buffer
        upload_uvec4s(
            gl,
            glw::GL_SHADER_STORAGE_BUFFER,
            self.storage_buffer[1],
            16,
            glw::GL_DYNAMIC_DRAW,
        );
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.gen_buffers(1, &mut self.atomic_counter_buffer));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.atomic_counter_buffer));
        gl!(gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 4, std::ptr::null(), glw::GL_STREAM_DRAW));
        let pointer = gl!(gl.map_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_WRITE_ONLY)).cast::<GLuint>();
        // SAFETY: a 4 byte buffer was just allocated and is mapped for writing.
        unsafe { pointer.write(0) };
        gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));

        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));
        // image buffer
        upload_uvec4s(gl, glw::GL_TEXTURE_BUFFER, self.buffer[0], 32, glw::GL_STATIC_DRAW);
        // texture buffer
        upload_uvec4s(gl, glw::GL_TEXTURE_BUFFER, self.buffer[1], 48, glw::GL_STATIC_DRAW);
        gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));

        gl!(gl.gen_textures(2, self.texture_buffer.as_mut_ptr()));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture_buffer[0]));
        gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA32UI, self.buffer[0]));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture_buffer[1]));
        gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA32UI, self.buffer[1]));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0));

        let names = [c"Compute0", c"Compute1", c"Compute2", c"Compute3"];
        let uniform_names = [c"Compute[0]", c"Compute[1]", c"Compute[2]", c"Compute[3]"];
        let subroutine_indices: Vec<GLuint> = names
            .iter()
            .map(|name| gl!(gl.get_subroutine_index(self.program, glw::GL_COMPUTE_SHADER, name.as_ptr())))
            .collect();
        let locations: Vec<GLint> = uniform_names
            .iter()
            .map(|name| gl!(gl.get_subroutine_uniform_location(self.program, glw::GL_COMPUTE_SHADER, name.as_ptr())))
            .collect();

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[0]));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[1]));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.atomic_counter_buffer));
        gl!(gl.bind_image_texture(
            0,
            self.texture_buffer[0],
            0,
            glw::FALSE,
            0,
            glw::GL_READ_ONLY,
            glw::GL_RGBA32UI
        ));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture_buffer[1]));
        gl!(gl.use_program(self.program));

        let mut indices = [0 as GLuint; 4];
        for (location, index) in locations.iter().zip(&subroutine_indices) {
            indices[*location as usize] = *index;
        }
        gl!(gl.uniform_subroutinesuiv(glw::GL_COMPUTE_SHADER, 4, indices.as_ptr()));

        gl!(gl.dispatch_compute(4, 1, 1));

        let mut data = vec![[0u32; 4]; 64];
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[0]));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 16 * 64, data.as_mut_ptr().cast()));
        for (i, value) in data.iter().enumerate() {
            if *value != [i as u32; 4] {
                log::info!("Invalid value at index {i}.");
                return Ok(ERROR);
            }
        }

        let mut value: GLuint = 0;
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.atomic_counter_buffer));
        gl!(gl.get_buffer_sub_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut value).cast()
        ));
        if value != 16 {
            log::info!("Final atomic counter value is {value} should be 16.");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.atomic_counter_buffer));
        gl!(gl.delete_buffers(2, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(2, self.buffer.as_ptr()));
        gl!(gl.delete_textures(2, self.texture_buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// `BasicResourceUniform`
#[derive(Default)]
struct BasicResourceUniform {
    program: GLuint,
    storage_buffer: GLuint,
}

/// The matrices of `BasicResourceUniform`: uniform name, `glUniformMatrix<code>fv` and the values.
const MATRICES: [(&str, &str, &[f32]); 9] = [
    ("g_4", "2", &[11.0, 12.0, 13.0, 14.0]),
    ("g_5", "2x3", &[15.0, 16.0, 17.0, 18.0, 19.0, 20.0]),
    ("g_6", "2x4", &[21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0]),
    ("g_7", "3x2", &[29.0, 30.0, 31.0, 32.0, 33.0, 34.0]),
    ("g_8", "3", &[35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0]),
    (
        "g_9",
        "3x4",
        &[44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0],
    ),
    ("g_10", "4x2", &[56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0]),
    (
        "g_11",
        "4x3",
        &[63.0, 64.0, 65.0, 66.0, 67.0, 68.0, 69.0, 70.0, 71.0, 27.0, 73.0, 74.0],
    ),
    (
        "g_12",
        "4",
        &[
            75.0, 76.0, 77.0, 78.0, 79.0, 80.0, 81.0, 82.0, 83.0, 84.0, 85.0, 86.0, 87.0, 88.0, 89.0, 90.0,
        ],
    ),
];

impl BasicResourceUniform {
    fn location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
        let name = CString::new(name).expect("no nul byte");
        gl!(gl.get_uniform_location(program, name.as_ptr()))
    }

    /// `glProgramUniformMatrix*fv` when `program` is given, `glUniformMatrix*fv` otherwise.
    fn set_matrix(gl: &glw::Functions, program: Option<GLuint>, location: GLint, code: &str, value: &[f32]) {
        let value = value.as_ptr();
        let f = glw::FALSE;
        match program {
            Some(program) => match code {
                "2" => gl!(gl.program_uniform_matrix_2fv(program, location, 1, f, value)),
                "2x3" => gl!(gl.program_uniform_matrix_2x_3fv(program, location, 1, f, value)),
                "2x4" => gl!(gl.program_uniform_matrix_2x_4fv(program, location, 1, f, value)),
                "3x2" => gl!(gl.program_uniform_matrix_3x_2fv(program, location, 1, f, value)),
                "3" => gl!(gl.program_uniform_matrix_3fv(program, location, 1, f, value)),
                "3x4" => gl!(gl.program_uniform_matrix_3x_4fv(program, location, 1, f, value)),
                "4x2" => gl!(gl.program_uniform_matrix_4x_2fv(program, location, 1, f, value)),
                "4x3" => gl!(gl.program_uniform_matrix_4x_3fv(program, location, 1, f, value)),
                _ => gl!(gl.program_uniform_matrix_4fv(program, location, 1, f, value)),
            },
            None => match code {
                "2" => gl!(gl.uniform_matrix_2fv(location, 1, f, value)),
                "2x3" => gl!(gl.uniform_matrix_2x_3fv(location, 1, f, value)),
                "2x4" => gl!(gl.uniform_matrix_2x_4fv(location, 1, f, value)),
                "3x2" => gl!(gl.uniform_matrix_3x_2fv(location, 1, f, value)),
                "3" => gl!(gl.uniform_matrix_3fv(location, 1, f, value)),
                "3x4" => gl!(gl.uniform_matrix_3x_4fv(location, 1, f, value)),
                "4x2" => gl!(gl.uniform_matrix_4x_2fv(location, 1, f, value)),
                "4x3" => gl!(gl.uniform_matrix_4x_3fv(location, 1, f, value)),
                _ => gl!(gl.uniform_matrix_4fv(location, 1, f, value)),
            },
        }
    }

    fn check_result(gl: &glw::Functions) -> bool {
        let mut data: GLint = 0;
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut data).cast()
        ));
        if data != 1 {
            log::info!("Data is {data} should be 1.");
            return false;
        }
        true
    }
}

impl Subcase for BasicResourceUniform {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nbuffer Result {\n  int g_result;\n};\nuniform float g_0;\nuniform vec2 g_1;\nuniform vec3 g_2;\nuniform vec4 g_3;\nuniform mat2 g_4;\nuniform mat2x3 g_5;\nuniform mat2x4 g_6;\nuniform mat3x2 g_7;\nuniform mat3 g_8;\nuniform mat3x4 g_9;\nuniform mat4x2 g_10;\nuniform mat4x3 g_11;\nuniform mat4 g_12;\nuniform int g_13;\nuniform ivec2 g_14;\nuniform ivec3 g_15;\nuniform ivec4 g_16;\nuniform uint g_17;\nuniform uvec2 g_18;\nuniform uvec3 g_19;\nuniform uvec4 g_20;\n\nvoid main() {\n  g_result = 1;\n\n  if (g_0 != 1.0) g_result = 0;\n  if (g_1 != vec2(2.0, 3.0)) g_result = 0;\n  if (g_2 != vec3(4.0, 5.0, 6.0)) g_result = 0;\n  if (g_3 != vec4(7.0, 8.0, 9.0, 10.0)) g_result = 0;\n\n  if (g_4 != mat2(11.0, 12.0, 13.0, 14.0)) g_result = 0;\n  if (g_5 != mat2x3(15.0, 16.0, 17.0, 18.0, 19.0, 20.0)) g_result = 0;\n  if (g_6 != mat2x4(21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0)) g_result = 0;\n\n  if (g_7 != mat3x2(29.0, 30.0, 31.0, 32.0, 33.0, 34.0)) g_result = 0;\n  if (g_8 != mat3(35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0)) g_result = 0;\n  if (g_9 != mat3x4(44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0)) g_result = 0;\n\n  if (g_10 != mat4x2(56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0)) g_result = 0;\n  if (g_11 != mat4x3(63.0, 64.0, 65.0, 66.0, 67.0, 68.0, 69.0, 70.0, 71.0, 27.0, 73, 74.0)) g_result = 0;\n  if (g_12 != mat4(75.0, 76.0, 77.0, 78.0, 79.0, 80.0, 81.0, 82.0, 83.0, 84.0, 85.0, 86.0, 87.0, 88.0, 89.0, 90.0)) g_result = 0;\n\n  if (g_13 != 91) g_result = 0;\n  if (g_14 != ivec2(92, 93)) g_result = 0;\n  if (g_15 != ivec3(94, 95, 96)) g_result = 0;\n  if (g_16 != ivec4(97, 98, 99, 100)) g_result = 0;\n\n  if (g_17 != 101u) g_result = 0;\n  if (g_18 != uvec2(102u, 103u)) g_result = 0;\n  if (g_19 != uvec3(104u, 105u, 106u)) g_result = 0;\n  if (g_20 != uvec4(107u, 108u, 109u, 110u)) g_result = 0;\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        {
            let data: GLint = 123;
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                4,
                std::ptr::from_ref(&data).cast(),
                glw::GL_STATIC_DRAW
            ));
        }

        let program = self.program;
        let loc = |name: &str| Self::location(gl, program, name);
        gl!(gl.program_uniform_1f(program, loc("g_0"), 1.0));
        gl!(gl.program_uniform_2f(program, loc("g_1"), 2.0, 3.0));
        gl!(gl.program_uniform_3f(program, loc("g_2"), 4.0, 5.0, 6.0));
        gl!(gl.program_uniform_4f(program, loc("g_3"), 7.0, 8.0, 9.0, 10.0));
        for (name, code, value) in MATRICES {
            Self::set_matrix(gl, Some(program), loc(name), code, value);
        }
        gl!(gl.program_uniform_1i(program, loc("g_13"), 91));
        gl!(gl.program_uniform_2i(program, loc("g_14"), 92, 93));
        gl!(gl.program_uniform_3i(program, loc("g_15"), 94, 95, 96));
        gl!(gl.program_uniform_4i(program, loc("g_16"), 97, 98, 99, 100));
        gl!(gl.program_uniform_1ui(program, loc("g_17"), 101));
        gl!(gl.program_uniform_2ui(program, loc("g_18"), 102, 103));
        gl!(gl.program_uniform_3ui(program, loc("g_19"), 104, 105, 106));
        gl!(gl.program_uniform_4ui(program, loc("g_20"), 107, 108, 109, 110));

        gl!(gl.use_program(program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        if !Self::check_result(gl) {
            return Ok(ERROR);
        }

        // re-link program (all uniforms will be set to zero)
        gl!(gl.link_program(program));
        {
            let data: GLint = 123;
            gl!(gl.buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 4, std::ptr::from_ref(&data).cast()));
        }

        gl!(gl.uniform_1f(loc("g_0"), 1.0));
        gl!(gl.uniform_2f(loc("g_1"), 2.0, 3.0));
        gl!(gl.uniform_3f(loc("g_2"), 4.0, 5.0, 6.0));
        gl!(gl.uniform_4f(loc("g_3"), 7.0, 8.0, 9.0, 10.0));
        for (name, code, value) in MATRICES {
            Self::set_matrix(gl, None, loc(name), code, value);
        }
        gl!(gl.uniform_1i(loc("g_13"), 91));
        gl!(gl.uniform_2i(loc("g_14"), 92, 93));
        gl!(gl.uniform_3i(loc("g_15"), 94, 95, 96));
        gl!(gl.uniform_4i(loc("g_16"), 97, 98, 99, 100));
        gl!(gl.uniform_1ui(loc("g_17"), 101));
        gl!(gl.uniform_2ui(loc("g_18"), 102, 103));
        gl!(gl.uniform_3ui(loc("g_19"), 104, 105, 106));
        gl!(gl.uniform_4ui(loc("g_20"), 107, 108, 109, 110));

        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        if !Self::check_result(gl) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `ComputeShaderBase::IndexTo3DCoord`
fn index_to_3d_coord(idx: u32, max_x: u32, max_y: u32) -> UVec3 {
    let x = idx % max_x;
    let idx = idx / max_x;
    let y = idx % max_y;
    let z = idx / max_y;
    [x, y, z]
}

/// `BasicBuiltinVariables`
#[derive(Default)]
struct BasicBuiltinVariables {
    program: GLuint,
    storage_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl BasicBuiltinVariables {
    fn gen_source(local_size: UVec3, num_groups: UVec3) -> String {
        let global_size = [
            local_size[0] * num_groups[0],
            local_size[1] * num_groups[1],
            local_size[2] * num_groups[2],
        ];
        let count = global_size[0] * global_size[1] * global_size[2];
        format!(
            "\nlayout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\nconst uvec3 kGlobalSize = uvec3({}, {}, {});\nlayout(std430) buffer OutputBuffer {{\n  uvec4 num_work_groups[{count}];\n  uvec4 work_group_size[{count}];\n  uvec4 work_group_id[{count}];\n  uvec4 local_invocation_id[{count}];\n  uvec4 global_invocation_id[{count}];\n  uvec4 local_invocation_index[{count}];\n}} g_out_buffer;\nvoid main() {{\n  if ((gl_WorkGroupSize * gl_WorkGroupID + gl_LocalInvocationID) != gl_GlobalInvocationID) return;\n  const uint global_index = gl_GlobalInvocationID.x +\n                            gl_GlobalInvocationID.y * kGlobalSize.x +\n                            gl_GlobalInvocationID.z * kGlobalSize.x * kGlobalSize.y;\n  g_out_buffer.num_work_groups[global_index] = uvec4(gl_NumWorkGroups, 0);\n  g_out_buffer.work_group_size[global_index] = uvec4(gl_WorkGroupSize, 0);\n  g_out_buffer.work_group_id[global_index] = uvec4(gl_WorkGroupID, 0);\n  g_out_buffer.local_invocation_id[global_index] = uvec4(gl_LocalInvocationID, 0);\n  g_out_buffer.global_invocation_id[global_index] = uvec4(gl_GlobalInvocationID, 0);\n  g_out_buffer.local_invocation_index[global_index] = uvec4(gl_LocalInvocationIndex);\n}}",
            local_size[0], local_size[1], local_size[2], global_size[0], global_size[1], global_size[2]
        )
    }

    fn run_iteration(
        &mut self,
        gl: &glw::Functions,
        local_size: UVec3,
        num_groups: UVec3,
        dispatch_indirect: bool,
    ) -> bool {
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size, num_groups));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        let buffer_size = product(local_size, num_groups);
        let mut data = vec![[0u32; 4]; buffer_size as usize * 6];
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (16 * data.len()) as isize,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, num_groups, dispatch_indirect);

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (16 * data.len()) as isize,
            data.as_mut_ptr().cast()
        ));

        let max_x = local_size[0] * num_groups[0];
        let max_y = local_size[1] * num_groups[1];
        let size = buffer_size as usize;
        for index in 0..size {
            if data[index] != [num_groups[0], num_groups[1], num_groups[2], 0] {
                log::info!("gl_NumWorkGroups: Invalid data at index {index}.");
                return false;
            }
        }
        for index in size..2 * size {
            if data[index] != [local_size[0], local_size[1], local_size[2], 0] {
                log::info!("gl_WorkGroupSize: Invalid data at index {index}.");
                return false;
            }
        }
        for index in 2 * size..3 * size {
            let mut expected = index_to_3d_coord((index - 2 * size) as u32, max_x, max_y);
            for axis in 0..3 {
                expected[axis] /= local_size[axis];
            }
            if data[index] != [expected[0], expected[1], expected[2], 0] {
                log::info!("gl_WorkGroupID: Invalid data at index {index}.");
                return false;
            }
        }
        for index in 3 * size..4 * size {
            let mut expected = index_to_3d_coord((index - 3 * size) as u32, max_x, max_y);
            for axis in 0..3 {
                expected[axis] %= local_size[axis];
            }
            if data[index] != [expected[0], expected[1], expected[2], 0] {
                log::info!("gl_LocalInvocationID: Invalid data at index {index}.");
                return false;
            }
        }
        for index in 4 * size..5 * size {
            let expected = index_to_3d_coord((index - 4 * size) as u32, max_x, max_y);
            if data[index] != [expected[0], expected[1], expected[2], 0] {
                log::info!("gl_GlobalInvocationID: Invalid data at index {index}.");
                return false;
            }
        }
        for index in 5 * size..6 * size {
            let coord = index_to_3d_coord((index - 5 * size) as u32, max_x, max_y);
            let expected = (coord[0] % local_size[0])
                + (coord[1] % local_size[1]) * local_size[0]
                + (coord[2] % local_size[2]) * local_size[0] * local_size[1];
            if data[index] != [expected; 4] {
                log::info!("gl_LocalInvocationIndex: Invalid data at index {index}.");
                return false;
            }
        }
        true
    }
}

impl Subcase for BasicBuiltinVariables {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let iterations = [
            ([64, 1, 1], [8, 1, 1], false),
            ([1, 1, 64], [1, 5, 2], true),
            ([1, 1, 4], [2, 2, 2], false),
            ([3, 2, 1], [1, 2, 3], true),
            ([2, 4, 2], [2, 4, 1], false),
            ([2, 4, 7], [2, 1, 4], true),
        ];
        for (local_size, num_groups, dispatch_indirect) in iterations {
            if !self.run_iteration(gl, local_size, num_groups, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicMax`
#[derive(Default)]
struct BasicMax {
    program: GLuint,
    buffer: GLuint,
}

impl BasicMax {
    /// `CheckIndexed`
    fn check_indexed(gl: &glw::Functions, target: GLenum, min_values: [GLint; 3]) -> bool {
        for c in 0..3u32 {
            let mut i: GLint = 0;
            gl!(gl.get_integeri_v(target, c, &mut i));
            if i < min_values[c as usize] {
                log::info!("Is {i} should be at least {}.", min_values[c as usize]);
                return false;
            }
        }
        for c in 0..3u32 {
            let mut i64_value: glw::GLint64 = 0;
            gl!(gl.get_integer_64i_v(target, c, &mut i64_value));
            if i64_value < glw::GLint64::from(min_values[c as usize]) {
                log::info!("Is {i64_value} should be at least {}.", min_values[c as usize]);
                return false;
            }
        }
        for c in 0..3u32 {
            let mut f = 0.0f32;
            gl!(gl.get_floati_v(target, c, &mut f));
            if f < min_values[c as usize] as f32 {
                log::info!("Is {f} should be at least {}.", min_values[c as usize] as f32);
                return false;
            }
        }
        for c in 0..3u32 {
            let mut d = 0.0f64;
            gl!(gl.get_doublei_v(target, c, &mut d));
            if d < f64::from(min_values[c as usize]) {
                log::info!("Is {d} should be at least {}.", f64::from(min_values[c as usize]));
                return false;
            }
        }
        for c in 0..3u32 {
            let mut b: glw::GLboolean = 0;
            gl!(gl.get_booleani_v(target, c, &mut b));
            let expected = u8::from(min_values[c as usize] != 0);
            if b != expected {
                log::info!("Is {b} should be {expected}.");
                return false;
            }
        }
        true
    }

    /// `Check`
    fn check(gl: &glw::Functions, target: GLenum, min_value: GLint) -> bool {
        let mut i: GLint = 0;
        gl!(gl.get_integerv(target, &mut i));
        if i < min_value {
            log::info!("Is {i} should be at least {min_value}.");
            return false;
        }
        let mut i64_value: glw::GLint64 = 0;
        gl!(gl.get_integer_64v(target, &mut i64_value));
        if i64_value < glw::GLint64::from(min_value) {
            log::info!("Is {i64_value} should be at least {}.", glw::GLint64::from(min_value));
            return false;
        }
        let mut f = 0.0f32;
        gl!(gl.get_floatv(target, &mut f));
        if f < min_value as f32 {
            log::info!("Is {f} should be at least {}.", min_value as f32);
            return false;
        }
        let mut d = 0.0f64;
        gl!(gl.get_doublev(target, &mut d));
        if d < f64::from(min_value) {
            log::info!("Is {d} should be at least {}.", f64::from(min_value));
            return false;
        }
        let mut b: glw::GLboolean = 0;
        gl!(gl.get_booleanv(target, &mut b));
        let expected = u8::from(min_value != 0);
        if b != expected {
            log::info!("Is {b} should be {expected}.");
            return false;
        }
        true
    }

    fn set_uniform_1i(gl: &glw::Functions, program: GLuint, name: &CStr, value: GLint) {
        let location = gl!(gl.get_uniform_location(program, name.as_ptr()));
        gl!(gl.uniform_1i(location, value));
    }
}

impl Subcase for BasicMax {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !Self::check_indexed(gl, glw::GL_MAX_COMPUTE_WORK_GROUP_COUNT, [65535, 65535, 65535]) {
            return Ok(ERROR);
        }
        if !Self::check_indexed(gl, glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, [1024, 1024, 64]) {
            return Ok(ERROR);
        }
        let uniform_components = if context.context_type().supports_core(4, 5) {
            1024
        } else {
            512
        };
        let checks = [
            (glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS, 12),
            (glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS, 16),
            (glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS, 8),
            (glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS, 8),
            (glw::GL_MAX_COMPUTE_SHARED_MEMORY_SIZE, 32768),
            (glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS, uniform_components),
            (glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS, 8),
            (glw::GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS, 512),
        ];
        for (target, min_value) in checks {
            if !Self::check(gl, target, min_value) {
                return Ok(ERROR);
            }
        }

        let glsl_cs = "\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  int g_output;\n};\nuniform ivec3 MaxComputeWorkGroupCount;\nuniform ivec3 MaxComputeWorkGroupSize;\nuniform int MaxComputeUniformComponents;\nuniform int MaxComputeTextureImageUnits;\nuniform int MaxComputeImageUniforms;\nuniform int MaxComputeAtomicCounters;\nuniform int MaxComputeAtomicCounterBuffers;\nvoid main() {\n  g_output = 1;\n  if (MaxComputeWorkGroupCount != gl_MaxComputeWorkGroupCount) g_output = 0;\n  if (MaxComputeWorkGroupSize != gl_MaxComputeWorkGroupSize) g_output = 0;\n  if (MaxComputeUniformComponents != gl_MaxComputeUniformComponents) g_output = 0;\n  if (MaxComputeTextureImageUnits != gl_MaxComputeTextureImageUnits) g_output = 0;\n  if (MaxComputeImageUniforms != gl_MaxComputeImageUniforms) g_output = 0;\n  if (MaxComputeAtomicCounters != gl_MaxComputeAtomicCounters) g_output = 0;\n  if (MaxComputeAtomicCounterBuffers != gl_MaxComputeAtomicCounterBuffers) g_output = 0;\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        let mut p = [0 as GLint; 3];
        for (index, value) in p.iter_mut().enumerate() {
            gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_COUNT, index as GLuint, value));
        }
        let location = gl!(gl.get_uniform_location(self.program, c"MaxComputeWorkGroupCount".as_ptr()));
        gl!(gl.uniform_3i(location, p[0], p[1], p[2]));
        for (index, value) in p.iter_mut().enumerate() {
            gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, index as GLuint, value));
        }
        let location = gl!(gl.get_uniform_location(self.program, c"MaxComputeWorkGroupSize".as_ptr()));
        gl!(gl.uniform_3iv(location, 1, p.as_ptr()));
        let single_values = [
            (glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS, c"MaxComputeUniformComponents"),
            (glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS, c"MaxComputeTextureImageUnits"),
            (glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS, c"MaxComputeImageUniforms"),
            (glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS, c"MaxComputeAtomicCounters"),
            (
                glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS,
                c"MaxComputeAtomicCounterBuffers",
            ),
        ];
        for (pname, name) in single_values {
            let value = Self::get_integer(gl, pname);
            Self::set_uniform_1i(gl, self.program, name, value);
        }

        let mut data: GLint = 0xffff;
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            4,
            std::ptr::from_ref(&data).cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut data).cast()
        ));
        Ok(if data == 1 { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

impl BasicMax {
    fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
        let mut value = 0;
        gl!(gl.get_integerv(pname, &mut value));
        value
    }
}

/// `glShaderSource` with several strings
fn shader_source_parts(gl: &glw::Functions, shader: GLuint, parts: &[&str]) {
    let strings: Vec<CString> = parts
        .iter()
        .map(|part| CString::new(*part).expect("shader source holds no nul byte"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = strings.iter().map(|string| string.as_ptr()).collect();
    gl!(gl.shader_source(shader, pointers.len() as i32, pointers.as_ptr(), std::ptr::null()));
}

fn create_compute_shader(gl: &glw::Functions, parts: &[&str]) -> GLuint {
    let shader = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
    shader_source_parts(gl, shader, parts);
    gl!(gl.compile_shader(shader));
    shader
}

/// The SSBO bound at 0 holding a zeroed vec4, dispatch once and read the vec4 back.
fn run_vec4_output(gl: &glw::Functions, buffer: GLuint) -> Vec4 {
    gl!(gl.dispatch_compute(1, 1, 1));
    let mut data = [0.0f32; 4];
    gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer));
    gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
    gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 16, data.as_mut_ptr().cast()));
    data
}

fn create_zeroed_vec4_buffer(gl: &glw::Functions) -> GLuint {
    let mut buffer: GLuint = 0;
    let zero = [0.0f32; 4];
    gl!(gl.gen_buffers(1, &mut buffer));
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer));
    gl!(gl.buffer_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        16,
        zero.as_ptr().cast(),
        glw::GL_DYNAMIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
    buffer
}

/// `BasicBuildMonolithic`
struct BasicBuildMonolithic;

impl Subcase for BasicBuildMonolithic {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let cs1 = [
            "#version 430 core",
            "\nlayout(local_size_x = 1) in;\nvoid Run();\nvoid main() {\n  Run();\n}",
        ];
        let cs2 = "#version 430 core\nlayout(binding = 0, std430) buffer Output {\n  vec4 g_output;\n};\nvec4 CalculateOutput();\nvoid Run() {\n  g_output = CalculateOutput();\n}";
        let cs3 = "#version 430 core\nlayout(local_size_x = 1) in;\nlayout(binding = 0, std430) buffer Output {\n  vec4 g_output;\n};\nvec4 CalculateOutput() {\n  g_output = vec4(0);\n  return vec4(1, 2, 3, 4);\n}";

        let sh1 = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        let mut shader_type = 0;
        gl!(gl.get_shaderiv(sh1, glw::GL_SHADER_TYPE, &mut shader_type));
        if shader_type as GLenum != glw::GL_COMPUTE_SHADER {
            log::info!("SHADER_TYPE should be COMPUTE_SHADER.");
            gl!(gl.delete_shader(sh1));
            // upstream returns `false` from a `long` Run(), which is NO_ERROR
            return Ok(NO_ERROR);
        }
        shader_source_parts(gl, sh1, &cs1);
        gl!(gl.compile_shader(sh1));

        let sh2 = create_compute_shader(gl, &[cs2]);
        let sh3 = create_compute_shader(gl, &[cs3]);

        let program = gl!(gl.create_program());
        gl!(gl.attach_shader(program, sh1));
        gl!(gl.attach_shader(program, sh2));
        gl!(gl.attach_shader(program, sh3));
        gl!(gl.link_program(program));
        gl!(gl.delete_shader(sh1));
        gl!(gl.delete_shader(sh2));
        gl!(gl.delete_shader(sh3));

        let mut res = check_program(gl, program);

        let buffer = create_zeroed_vec4_buffer(gl);
        gl!(gl.use_program(program));
        let data = run_vec4_output(gl, buffer);
        if data != [1.0, 2.0, 3.0, 4.0] {
            log::info!("Invalid value!");
            res = false;
        }

        gl!(gl.delete_buffers(1, &buffer));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        Ok(if res { NO_ERROR } else { ERROR })
    }
}

/// `BasicBuildSeparable`
struct BasicBuildSeparable;

impl Subcase for BasicBuildSeparable {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let cs = [
            "#version 430 core",
            "\nlayout(local_size_x = 1) in;\nvoid Run();\nvoid main() {\n  Run();\n}",
            "\nlayout(binding = 0, std430) buffer Output {\n  vec4 g_output;\n};\nvec4 CalculateOutput();\nvoid Run() {\n  g_output = CalculateOutput();\n}",
            "\nvec4 CalculateOutput() {\n  g_output = vec4(0);\n  return vec4(1, 2, 3, 4);\n}",
        ];
        let strings: Vec<CString> = cs
            .iter()
            .map(|part| CString::new(*part).expect("no nul byte"))
            .collect();
        let pointers: Vec<*const glw::GLchar> = strings.iter().map(|string| string.as_ptr()).collect();
        let program = gl!(gl.create_shader_programv(glw::GL_COMPUTE_SHADER, 4, pointers.as_ptr()));
        let mut res = check_program(gl, program);

        let buffer = create_zeroed_vec4_buffer(gl);
        gl!(gl.use_program(program));
        let data = run_vec4_output(gl, buffer);
        if data != [1.0, 2.0, 3.0, 4.0] {
            log::info!("Invalid value!");
            res = false;
        }

        let zero = [0.0f32; 4];
        gl!(gl.buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 16, zero.as_ptr().cast()));
        let mut pipeline: GLuint = 0;
        gl!(gl.gen_program_pipelines(1, &mut pipeline));
        gl!(gl.use_program_stages(pipeline, glw::GL_COMPUTE_SHADER_BIT, program));
        gl!(gl.use_program(0));
        gl!(gl.bind_program_pipeline(pipeline));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let mut data = [0.0f32; 4];
        gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 16, data.as_mut_ptr().cast()));
        if data != [1.0, 2.0, 3.0, 4.0] {
            log::info!("Invalid value!");
            res = false;
        }

        gl!(gl.delete_program_pipelines(1, &pipeline));
        gl!(gl.delete_buffers(1, &buffer));
        gl!(gl.delete_program(program));
        Ok(if res { NO_ERROR } else { ERROR })
    }
}

/// `BasicSharedSimple`
#[derive(Default)]
struct BasicSharedSimple {
    program: GLuint,
    storage_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl BasicSharedSimple {
    fn run_iteration(&mut self, gl: &glw::Functions, num_groups: u32, dispatch_indirect: bool) -> bool {
        let buffer_size = 256 * num_groups as usize;
        let mut data = vec![0xffffu32; buffer_size];
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * buffer_size) as isize,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, [num_groups, 1, 1], dispatch_indirect);

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (4 * buffer_size) as isize,
            data.as_mut_ptr().cast()
        ));
        for (i, &value) in data.iter().enumerate() {
            if value != 1 {
                log::info!("Data at index {i} is {value} should be 1.");
                return false;
            }
        }
        true
    }
}

impl Subcase for BasicSharedSimple {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 256) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nshared uint g_shared_data[256];\nvoid main() {\n  g_shared_data[gl_LocalInvocationID.x] = gl_LocalInvocationIndex;\n  groupMemoryBarrier();\n  barrier();\n  g_output[gl_GlobalInvocationID.x] = 1;\n  if (gl_LocalInvocationIndex < 255) {\n    const uint res = g_shared_data[gl_LocalInvocationID.x + 1];\n    if (res != (gl_LocalInvocationIndex + 1)) {\n      g_output[gl_GlobalInvocationID.x] = 0;\n    }\n  }\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        for (num_groups, dispatch_indirect) in [(1, false), (8, true), (13, false), (7, true)] {
            if !self.run_iteration(gl, num_groups, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicSharedStruct`
#[derive(Default)]
struct BasicSharedStruct {
    program: GLuint,
    storage_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl BasicSharedStruct {
    fn run_iteration(&mut self, gl: &glw::Functions, dispatch_indirect: bool) -> bool {
        const BUFFER_SIZE: usize = 256;
        let mut data = vec![[0.0f32; 4]; BUFFER_SIZE];
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (16 * BUFFER_SIZE) as isize,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, [1, 1, 1], dispatch_indirect);

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (16 * BUFFER_SIZE) as isize,
            data.as_mut_ptr().cast()
        ));
        for (i, value) in data.iter().enumerate() {
            if *value != [i as f32; 4] {
                log::info!("Invalid data at index {i}.");
                return false;
            }
        }
        true
    }
}

impl Subcase for BasicSharedStruct {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 128) in;\nlayout(std430) buffer Output {\n  vec4 g_output[256];\n};\nstruct SubData {\n  mat2x4 data;\n};\nstruct Data {\n  uint index;\n  vec3 data0;\n  SubData data1;\n};\nshared Data g_shared_data[256];\nshared int g_shared_buf[2];\nvoid main() {\n  if (gl_LocalInvocationID.x == 0) {\n    g_shared_buf[1] = 1;\n    g_shared_buf[1 + gl_LocalInvocationID.x] = 0;\n    g_shared_buf[0] = 128;\n    g_output[0] = vec4(g_shared_buf[1]);\n    g_output[128] = vec4(g_shared_buf[0]);\n    memoryBarrierBuffer();\n  } else {\n    const uint index = gl_LocalInvocationIndex;\n    g_shared_data[index].index = index;\n    g_shared_data[index + 128].index = index + 128;\n    g_shared_data[index].data1.data = mat2x4(0.0);\n    g_shared_data[index + 128].data1.data = mat2x4(0.0);\n    g_output[index] = vec4(g_shared_data[index].index);\n    g_output[index + 128] = vec4(g_shared_data[index + 128].index);\n    memoryBarrierShared();\n  }\n  memoryBarrierAtomicCounter();\n  memoryBarrierImage();\n  memoryBarrier();\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        if !self.run_iteration(gl, false) {
            return Ok(ERROR);
        }
        if !self.run_iteration(gl, true) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicDispatchIndirect`
#[derive(Default)]
struct BasicDispatchIndirect {
    program: GLuint,
    storage_buffer: GLuint,
    dispatch_buffer: [GLuint; 2],
}

impl BasicDispatchIndirect {
    fn run_iteration(&mut self, gl: &glw::Functions, offset: isize, buffer_size: usize) -> bool {
        let mut data = vec![0 as GLuint; buffer_size];
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * buffer_size) as isize,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.dispatch_compute_indirect(offset));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (4 * buffer_size) as isize,
            data.as_mut_ptr().cast()
        ));
        for (i, &value) in data.iter().enumerate() {
            if value != i as GLuint {
                log::info!("Data at index {i} is {value} should be {i}.");
                return false;
            }
        }
        true
    }

    fn check_binding(gl: &glw::Functions, expected: GLuint) -> bool {
        let mut i: GLint = 0;
        gl!(gl.get_integerv(glw::GL_DISPATCH_INDIRECT_BUFFER_BINDING, &mut i));
        if i != expected as GLint {
            return false;
        }
        let mut i64_value: glw::GLint64 = 0;
        gl!(gl.get_integer_64v(glw::GL_DISPATCH_INDIRECT_BUFFER_BINDING, &mut i64_value));
        if i64_value != glw::GLint64::from(expected) {
            return false;
        }
        let mut f = 0.0f32;
        gl!(gl.get_floatv(glw::GL_DISPATCH_INDIRECT_BUFFER_BINDING, &mut f));
        if f != expected as f32 {
            return false;
        }
        let mut d = 0.0f64;
        gl!(gl.get_doublev(glw::GL_DISPATCH_INDIRECT_BUFFER_BINDING, &mut d));
        if d != f64::from(expected) {
            return false;
        }
        let mut b: glw::GLboolean = 0;
        gl!(gl.get_booleanv(glw::GL_DISPATCH_INDIRECT_BUFFER_BINDING, &mut b));
        b == u8::from(expected != 0)
    }

    fn set_global_size(&self, gl: &glw::Functions, x: GLuint, y: GLuint, z: GLuint) {
        let location = gl!(gl.get_uniform_location(self.program, c"g_global_size".as_ptr()));
        gl!(gl.uniform_3ui(location, x, y, z));
    }
}

impl Subcase for BasicDispatchIndirect {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nuniform uvec3 g_global_size;\nvoid main() {\n  const uint global_index = gl_GlobalInvocationID.x +\n                            gl_GlobalInvocationID.y * g_global_size.x +\n                            gl_GlobalInvocationID.z * g_global_size.x * g_global_size.y;\n  if (gl_NumWorkGroups != g_global_size) {\n    g_output[global_index] = 0xffff;\n    return;\n  }\n  g_output[global_index] = global_index;\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        if !Self::check_binding(gl, 0) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(2, self.dispatch_buffer.as_mut_ptr()));
        let data: [GLuint; 8] = [1, 2, 3, 4, 5, 6, 7, 8];
        let data2: [GLuint; 4] = [3, 1, 4, 4];
        gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, self.dispatch_buffer[0]));
        gl!(gl.buffer_data(
            glw::GL_DISPATCH_INDIRECT_BUFFER,
            std::mem::size_of_val(&data) as isize,
            data.as_ptr().cast(),
            glw::GL_STREAM_DRAW
        ));
        if !Self::check_binding(gl, self.dispatch_buffer[0]) {
            return Ok(ERROR);
        }
        gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, self.dispatch_buffer[1]));
        gl!(gl.buffer_data(
            glw::GL_DISPATCH_INDIRECT_BUFFER,
            std::mem::size_of_val(&data2) as isize,
            data2.as_ptr().cast(),
            glw::GL_STREAM_READ
        ));
        if !Self::check_binding(gl, self.dispatch_buffer[1]) {
            return Ok(ERROR);
        }

        gl!(gl.use_program(self.program));
        gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, self.dispatch_buffer[0]));
        self.set_global_size(gl, 1, 2, 3);
        if !self.run_iteration(gl, 0, 6) {
            return Ok(ERROR);
        }
        self.set_global_size(gl, 2, 3, 4);
        if !self.run_iteration(gl, 4, 24) {
            return Ok(ERROR);
        }
        self.set_global_size(gl, 4, 5, 6);
        if !self.run_iteration(gl, 12, 120) {
            return Ok(ERROR);
        }

        gl!(gl.buffer_sub_data(glw::GL_DISPATCH_INDIRECT_BUFFER, 20, 12, data.as_ptr().cast()));
        self.set_global_size(gl, 1, 2, 3);
        if !self.run_iteration(gl, 20, 6) {
            return Ok(ERROR);
        }

        let pointer = gl!(gl.map_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, glw::GL_WRITE_ONLY)).cast::<GLuint>();
        for i in 0..3 {
            // SAFETY: the buffer holds 8 uints and is mapped for writing.
            unsafe { pointer.add(i).write(4) };
        }
        gl!(gl.unmap_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER));
        self.set_global_size(gl, 4, 4, 4);
        if !self.run_iteration(gl, 0, 64) {
            return Ok(ERROR);
        }

        gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, self.dispatch_buffer[1]));
        self.set_global_size(gl, 1, 4, 4);
        if !self.run_iteration(gl, 4, 16) {
            return Ok(ERROR);
        }

        gl!(gl.delete_buffers(2, self.dispatch_buffer.as_ptr()));
        self.dispatch_buffer = [0; 2];
        if !Self::check_binding(gl, 0) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(2, self.dispatch_buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// `BasicWorkGroupSizeIsConst`
#[derive(Default)]
struct BasicWorkGroupSizeIsConst {
    program: GLuint,
    storage_buffer: GLuint,
}

impl Subcase for BasicWorkGroupSizeIsConst {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 2, local_size_y = 3, local_size_z = 4) in;\nlayout(std430, binding = 0) buffer Output {\n  uint g_buffer[22 + gl_WorkGroupSize.x];\n};\nshared uint g_shared[gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z];\nuniform uint g_uniform[gl_WorkGroupSize.z + 20] = { 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 };\nvoid main() {\n  g_shared[gl_LocalInvocationIndex] = 1U;\n  groupMemoryBarrier();\n  barrier();\n  uint sum = 0;\n  for (uint i = 0; i < gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z; ++i) {\n    sum += g_shared[i];\n  }\n  sum += g_uniform[gl_LocalInvocationIndex];\n  g_buffer[gl_LocalInvocationIndex] = sum;\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            24 * 4,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let mut error = NO_ERROR;
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        let data = read_mapped::<GLuint>(gl, glw::GL_SHADER_STORAGE_BUFFER, 24);
        for (i, &value) in data.iter().enumerate() {
            if value != i as GLuint + 25 {
                log::info!("Data at index {i} is {value} should be {}.", i + 25);
                error = ERROR;
            }
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `ValidateReadBuffer`
fn validate_read_buffer(gl: &glw::Functions, eps: Vec4, x: i32, y: i32, w: i32, h: i32, expected: Vec4) -> bool {
    let mut display = vec![[0.0f32; 4]; (w * h) as usize];
    gl!(gl.read_pixels(x, y, w, h, glw::GL_RGBA, glw::GL_FLOAT, display.as_mut_ptr().cast()));
    for j in 0..h {
        for i in 0..w {
            let color = display[(j * w + i) as usize];
            if !color_equal(color, expected, eps) {
                log::info!(
                    "Color at ({}, {}) is [{}, {}, {}, {}] should be [{}, {}, {}, {}].",
                    x + i,
                    y + j,
                    color[0],
                    color[1],
                    color[2],
                    color[3],
                    expected[0],
                    expected[1],
                    expected[2],
                    expected[3]
                );
                return false;
            }
        }
    }
    true
}

/// `ColorEqual` of the three-component overload
fn color_equal_rgb(c0: [f32; 3], c1: [f32; 3], epsilon: Vec4) -> bool {
    (0..3).all(|i| (c0[i] - c1[i]).abs() <= epsilon[i])
}

/// `ValidateReadBufferCenteredQuad`
fn validate_read_buffer_centered_quad(
    gl: &glw::Functions,
    eps: Vec4,
    width: i32,
    height: i32,
    expected: [f32; 3],
) -> bool {
    let mut result = true;
    let mut fb = vec![[0.0f32; 3]; (width * height) as usize];
    gl!(gl.read_pixels(0, 0, width, height, glw::GL_RGB, glw::GL_FLOAT, fb.as_mut_ptr().cast()));

    let startx = ((width as f32 * 0.1) + 1.0) as i32;
    let starty = ((height as f32 * 0.1) + 1.0) as i32;
    let endx = (width as f32 - 2.0 * ((width as f32 * 0.1) + 1.0) - 1.0) as i32;
    let endy = (height as f32 - 2.0 * ((height as f32 * 0.1) + 1.0) - 1.0) as i32;
    for y in starty..endy {
        for x in startx..endx {
            if !color_equal_rgb(fb[(y * width + x) as usize], expected, eps) {
                return false;
            }
        }
    }

    let black = [0.0f32; 3];
    let corners = [
        2 * width + 2,
        2 * width + (width - 3),
        (height - 3) * width + (width - 3),
        (height - 3) * width + 2,
    ];
    for corner in corners {
        if !color_equal_rgb(fb[corner as usize], black, eps) {
            result = false;
        }
    }
    result
}

/// `BuildShaderProgram`
fn build_shader_program(gl: &glw::Functions, shader_type: GLenum, source: &str) -> GLuint {
    let version = CString::new(GLSL_VER).expect("no nul byte");
    let source = CString::new(source).expect("shader source holds no nul byte");
    let sources = [version.as_ptr(), source.as_ptr()];
    gl!(gl.create_shader_programv(shader_type, 2, sources.as_ptr()))
}

/// `BasicSSOComputePipeline`
#[derive(Default)]
struct BasicSsoComputePipeline {
    vsp: GLuint,
    fsp: GLuint,
    csp: GLuint,
    storage_buffer: GLuint,
    vertex_array: GLuint,
    pipeline: GLuint,
}

impl Subcase for BasicSsoComputePipeline {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 4) in;\nlayout(std430) buffer Output {\n  vec4 g_output[4];\n};\nvoid main() {\n  const vec2 quad[4] = { vec2(-1, -1), vec2(1, -1), vec2(-1, 1), vec2(1, 1) };\n  g_output[gl_GlobalInvocationID.x] = vec4(quad[gl_GlobalInvocationID.x], 0, 1);\n}";
        self.csp = create_compute_program(gl, glsl_cs);
        gl!(gl.program_parameteri(self.csp, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint));
        gl!(gl.link_program(self.csp));
        if !check_program(gl, self.csp) {
            return Ok(ERROR);
        }

        let glsl_vs = "\nlayout(location = 0) in vec4 i_position;\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nvoid main() {\n  gl_Position = i_position;\n}";
        self.vsp = build_shader_program(gl, glw::GL_VERTEX_SHADER, glsl_vs);
        if !check_program(gl, self.vsp) {
            return Ok(ERROR);
        }

        let glsl_fs = "\nlayout(location = 0) out vec4 o_color;\nvoid main() {\n  o_color = vec4(0, 1, 0, 1);\n}";
        self.fsp = build_shader_program(gl, glw::GL_FRAGMENT_SHADER, glsl_fs);
        if !check_program(gl, self.fsp) {
            return Ok(ERROR);
        }

        gl!(gl.gen_program_pipelines(1, &mut self.pipeline));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.vsp));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_FRAGMENT_SHADER_BIT, self.fsp));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_COMPUTE_SHADER_BIT, self.csp));

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            16 * 4,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.storage_buffer));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.bind_program_pipeline(self.pipeline));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.memory_barrier(glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let render_target = context.render_target();
        if !validate_read_buffer(
            gl,
            color_eps(context),
            0,
            0,
            render_target.width,
            render_target.height,
            [0.0, 1.0, 0.0, 1.0],
        ) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program(self.fsp));
        gl!(gl.delete_program(self.csp));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_program_pipelines(1, &self.pipeline));
        Ok(NO_ERROR)
    }
}

/// `BasicSSOCase2`
#[derive(Default)]
struct BasicSsoCase2 {
    program_ab: GLuint,
    program_c: GLuint,
    pipeline: GLuint,
    storage_buffer: GLuint,
    vao: GLuint,
}

impl Subcase for BasicSsoCase2 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut res: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS, &mut res));
        if res <= 0 {
            output_not_supported("GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS <= 0");
            return Ok(NO_ERROR);
        }

        let glsl_a = "#version 430 core\nlayout(binding = 1, std430) buffer Input {\n  vec2 g_input[4];\n};\nout StageData {\n  vec3 color;\n} g_vs_out;\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nvoid main() {\n  gl_Position = vec4(g_input[gl_VertexID], 0, 1);\n  g_vs_out.color = vec3(0, 1, 0);\n}";
        let glsl_b = "#version 430 core\nin StageData {\n  vec3 color;\n} g_fs_in;\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = vec4(g_fs_in.color, 1);\n}";
        let glsl_c = "#version 430 core\nlayout(local_size_x = 4) in;\nlayout(binding = 1, std430) buffer Output {\n  vec2 g_output[gl_WorkGroupSize.x];\n};\nvoid main() {\n  if (gl_GlobalInvocationID.x == 0) {\n    g_output[0] = vec2(-0.8, -0.8);\n  } else if (gl_GlobalInvocationID.x == 1) {\n    g_output[1] = vec2(0.8, -0.8);\n  } else if (gl_GlobalInvocationID.x == 2) {\n    g_output[2] = vec2(-0.8, 0.8);\n  } else if (gl_GlobalInvocationID.x == 3) {\n    g_output[3] = vec2(0.8, 0.8);\n  }\n}";

        self.program_ab = gl!(gl.create_program());
        let vertex_shader = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        gl!(gl.attach_shader(self.program_ab, vertex_shader));
        gl!(gl.delete_shader(vertex_shader));
        shader_source_parts(gl, vertex_shader, &[glsl_a]);
        gl!(gl.compile_shader(vertex_shader));
        let fragment_shader = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        gl!(gl.attach_shader(self.program_ab, fragment_shader));
        gl!(gl.delete_shader(fragment_shader));
        shader_source_parts(gl, fragment_shader, &[glsl_b]);
        gl!(gl.compile_shader(fragment_shader));
        gl!(gl.program_parameteri(self.program_ab, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint));
        gl!(gl.link_program(self.program_ab));

        let source_c = CString::new(glsl_c).expect("no nul byte");
        let pointer_c = source_c.as_ptr();
        self.program_c = gl!(gl.create_shader_programv(glw::GL_COMPUTE_SHADER, 1, &pointer_c));

        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_program_pipelines(1, &mut self.pipeline));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_ALL_SHADER_BITS, self.program_ab));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_COMPUTE_SHADER_BIT, self.program_c));

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            8 * 4,
            std::ptr::null(),
            glw::GL_STREAM_DRAW
        ));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.bind_program_pipeline(self.pipeline));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let render_target = context.render_target();
        if render_target.width < 500
            && !validate_read_buffer_centered_quad(
                gl,
                color_eps(context),
                render_target.width,
                render_target.height,
                [0.0, 1.0, 0.0],
            )
        {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program(self.program_ab));
        gl!(gl.delete_program(self.program_c));
        gl!(gl.delete_program_pipelines(1, &self.pipeline));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }
}

/// `BasicSSOCase3`
#[derive(Default)]
struct BasicSsoCase3 {
    program_a: GLuint,
    program_b: GLuint,
    pipeline: GLuint,
    storage_buffer: GLuint,
}

impl BasicSsoCase3 {
    fn validate(gl: &glw::Functions, expected: GLint) -> bool {
        let mut data: GLint = 0;
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut data).cast()
        ));
        if data != expected {
            log::info!("Data is {data} should be {expected}.");
            return false;
        }
        true
    }

    fn dispatch_and_barrier(gl: &glw::Functions) {
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
    }
}

impl Subcase for BasicSsoCase3 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_a = "#version 430 core\nlayout(local_size_x = 1) in;\nlayout(binding = 3, std430) buffer Output {\n  int g_output;\n};\nvoid main() {\n  g_output = 1;\n}";
        let glsl_b = "#version 430 core\nlayout(local_size_x = 1) in;\nlayout(binding = 3, std430) buffer Output {\n  int g_output;\n};\nvoid main() {\n  g_output = 2;\n}";

        // program A
        self.program_a = gl!(gl.create_program());
        let shader = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        gl!(gl.attach_shader(self.program_a, shader));
        gl!(gl.delete_shader(shader));
        shader_source_parts(gl, shader, &[glsl_a]);
        gl!(gl.compile_shader(shader));
        gl!(gl.program_parameteri(self.program_a, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint));
        gl!(gl.link_program(self.program_a));

        let source_b = CString::new(glsl_b).expect("no nul byte");
        let pointer_b = source_b.as_ptr();
        self.program_b = gl!(gl.create_shader_programv(glw::GL_COMPUTE_SHADER, 1, &pointer_b));

        // storage buffer
        {
            let data: GLint = 0;
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 3, self.storage_buffer));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                4,
                std::ptr::from_ref(&data).cast(),
                glw::GL_STREAM_READ
            ));
        }

        gl!(gl.gen_program_pipelines(1, &mut self.pipeline));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_ALL_SHADER_BITS, self.program_b));

        gl!(gl.use_program(self.program_a));
        gl!(gl.bind_program_pipeline(self.pipeline));
        Self::dispatch_and_barrier(gl);
        if !Self::validate(gl, 1) {
            return Ok(ERROR);
        }

        gl!(gl.use_program(0));
        Self::dispatch_and_barrier(gl);
        if !Self::validate(gl, 2) {
            return Ok(ERROR);
        }

        gl!(gl.use_program(self.program_b));
        Self::dispatch_and_barrier(gl);
        if !Self::validate(gl, 2) {
            return Ok(ERROR);
        }

        gl!(gl.use_program(0));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_COMPUTE_SHADER_BIT, self.program_a));
        Self::dispatch_and_barrier(gl);
        if !Self::validate(gl, 1) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program(self.program_a));
        gl!(gl.delete_program(self.program_b));
        gl!(gl.delete_program_pipelines(1, &self.pipeline));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicAtomicCase1`
#[derive(Default)]
struct BasicAtomicCase1 {
    program: GLuint,
    storage_buffer: GLuint,
}

impl Subcase for BasicAtomicCase1 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 8) in;\nlayout(std430, binding = 0) buffer Output {\n  uint g_add_output[8];\n  int g_sub_output[8];\n};\nshared uint g_add_value;\nshared int g_sub_value;\nvoid main() {\n  if (gl_LocalInvocationIndex == 0) {\n    g_add_value = 0u;\n    g_sub_value = 7;\n  }\n  g_add_output[gl_LocalInvocationIndex] = 0u;\n  g_sub_output[gl_LocalInvocationIndex] = 0;\n  groupMemoryBarrier();\n  barrier();\n  g_add_output[gl_LocalInvocationIndex] = atomicAdd(g_add_value, 1u);\n  g_sub_output[gl_LocalInvocationIndex] = atomicAdd(g_sub_value, -1);\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            16 * 4,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let mut data = [0i32; 8];
        for offset in [0, 4 * 8] {
            gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, offset, 4 * 8, data.as_mut_ptr().cast()));
            data.sort_unstable();
            for (i, &value) in data.iter().enumerate() {
                if value != i as i32 {
                    log::info!("Data at index {i} is {value} should be {i}.");
                    return Ok(ERROR);
                }
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// The checks of `BasicAtomicCase2` and `BasicAtomicCase3`: every value must have ended at 7.
fn all_sevens(values: &[u32], label: &str) -> bool {
    for (i, &value) in values.iter().enumerate() {
        if value != 7 {
            log::info!("{label} at index {i} is {value} should be 7.");
            return false;
        }
    }
    true
}

/// `BasicAtomicCase2`
#[derive(Default)]
struct BasicAtomicCase2 {
    program: GLuint,
    storage_buffer: [GLuint; 2],
    dispatch_buffer: GLuint,
}

impl BasicAtomicCase2 {
    fn gen_source(local_size: UVec3, num_groups: UVec3) -> String {
        let global_size = [
            local_size[0] * num_groups[0],
            local_size[1] * num_groups[1],
            local_size[2] * num_groups[2],
        ];
        let count = global_size[0] * global_size[1] * global_size[2];
        format!(
            "\nlayout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\nconst uvec3 kGlobalSize = uvec3({}, {}, {});\nlayout(std430, binding = 0) buffer OutputU {{\n  uint g_uint_out[{count}];\n}};\nlayout(std430, binding = 1) buffer OutputI {{\n  int data[{count}];\n}} g_int_out;\nuniform uint g_uint_value[8] = uint[8](3u, 1u, 2u, 0x1u, 0x3u, 0x1u, 0x2u, 0x7u);\nvoid main() {{\n  const uint global_index = gl_GlobalInvocationID.x +\n                            gl_GlobalInvocationID.y * kGlobalSize.x +\n                            gl_GlobalInvocationID.z * kGlobalSize.x * kGlobalSize.y;\n  atomicExchange(g_uint_out[global_index], g_uint_value[0]);\n  atomicMin(g_uint_out[global_index], g_uint_value[1]);\n  atomicMax(g_uint_out[global_index], g_uint_value[2]);\n  atomicAnd(g_uint_out[global_index], g_uint_value[3]);\n  atomicOr(g_uint_out[global_index], g_uint_value[4]);\n  if (g_uint_value[0] > 0u) {{\n    barrier();\n    atomicXor(g_uint_out[global_index], g_uint_value[5]);\n  }}\n  atomicCompSwap(g_uint_out[global_index], g_uint_value[6], g_uint_value[7]);\n\n  atomicExchange(g_int_out.data[global_index], 3);\n  atomicMin(g_int_out.data[global_index], 1);\n  atomicMax(g_int_out.data[global_index], 2);\n  atomicAnd(g_int_out.data[global_index], 0x1);\n  atomicOr(g_int_out.data[global_index], 0x3);\n  atomicXor(g_int_out.data[global_index], 0x1);\n  atomicCompSwap(g_int_out.data[global_index], 0x2, 0x7);\n}}",
            local_size[0], local_size[1], local_size[2], global_size[0], global_size[1], global_size[2]
        )
    }

    fn run_iteration(
        &mut self,
        gl: &glw::Functions,
        local_size: UVec3,
        num_groups: UVec3,
        dispatch_indirect: bool,
    ) -> bool {
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size, num_groups));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        let buffer_size = product(local_size, num_groups) as usize;
        if self.storage_buffer[0] == 0 {
            gl!(gl.gen_buffers(2, self.storage_buffer.as_mut_ptr()));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[0]));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * buffer_size) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[1]));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * buffer_size) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, num_groups, dispatch_indirect);
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let mut udata = vec![0 as GLuint; buffer_size];
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[0]));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (4 * buffer_size) as isize,
            udata.as_mut_ptr().cast()
        ));
        if !all_sevens(&udata, "uData") {
            return false;
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[1]));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (4 * buffer_size) as isize,
            udata.as_mut_ptr().cast()
        ));
        all_sevens(&udata, "Data")
    }
}

impl Subcase for BasicAtomicCase2 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let iterations = [
            ([64, 1, 1], [8, 1, 1], false),
            ([1, 1, 64], [1, 5, 2], true),
            ([1, 1, 4], [2, 2, 2], false),
            ([3, 2, 1], [1, 2, 3], true),
            ([2, 4, 2], [2, 4, 1], false),
            ([2, 4, 7], [2, 1, 4], true),
        ];
        for (local_size, num_groups, dispatch_indirect) in iterations {
            if !self.run_iteration(gl, local_size, num_groups, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(2, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `BasicAtomicCase3`
#[derive(Default)]
struct BasicAtomicCase3 {
    program: GLuint,
    storage_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl BasicAtomicCase3 {
    fn gen_source(local_size: UVec3) -> String {
        let count = local_size[0] * local_size[1] * local_size[2];
        format!(
            "\nlayout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\nlayout(std430, binding = 0) buffer Output {{\n  uint g_uint_out[{count}];\n  int g_int_out[{count}];\n}};\nshared uint g_shared_uint[{count}];\nshared int g_shared_int[{count}];\nuniform uint g_uint_value[8] = uint[8](3u, 1u, 2u, 0x1u, 0x3u, 0x1u, 0x2u, 0x7u);\nvoid main() {{\n  atomicExchange(g_shared_uint[gl_LocalInvocationIndex], g_uint_value[0]);\n  atomicMin(g_shared_uint[gl_LocalInvocationIndex], g_uint_value[1]);\n  atomicMax(g_shared_uint[gl_LocalInvocationIndex], g_uint_value[2]);\n  atomicAnd(g_shared_uint[gl_LocalInvocationIndex], g_uint_value[3]);\n  atomicOr(g_shared_uint[gl_LocalInvocationIndex], g_uint_value[4]);\n  atomicXor(g_shared_uint[gl_LocalInvocationIndex], g_uint_value[5]);\n  atomicCompSwap(g_shared_uint[gl_LocalInvocationIndex], g_uint_value[6], g_uint_value[7]);\n\n  atomicExchange(g_shared_int[gl_LocalInvocationIndex], 3);\n  atomicMin(g_shared_int[gl_LocalInvocationIndex], 1);\n  atomicMax(g_shared_int[gl_LocalInvocationIndex], 2);\n  atomicAnd(g_shared_int[gl_LocalInvocationIndex], 0x1);\n  if (g_uint_value[1] > 0u) {{\n    atomicOr(g_shared_int[gl_LocalInvocationIndex], 0x3);\n    atomicXor(g_shared_int[gl_LocalInvocationIndex], 0x1);\n    atomicCompSwap(g_shared_int[gl_LocalInvocationIndex], 0x2, 0x7);\n  }}\n\n  g_uint_out[gl_LocalInvocationIndex] = g_shared_uint[gl_LocalInvocationIndex];\n  g_int_out[gl_LocalInvocationIndex] = g_shared_int[gl_LocalInvocationIndex];\n}}",
            local_size[0], local_size[1], local_size[2]
        )
    }

    fn run_iteration(&mut self, gl: &glw::Functions, local_size: UVec3, dispatch_indirect: bool) -> bool {
        if self.program != 0 {
            gl!(gl.delete_program(self.program));
        }
        self.program = create_compute_program(gl, &Self::gen_source(local_size));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return false;
        }

        let buffer_size = (local_size[0] * local_size[1] * local_size[2]) as usize;
        if self.storage_buffer == 0 {
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * buffer_size * 2) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        dispatch(gl, &mut self.dispatch_buffer, [1, 1, 1], dispatch_indirect);
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let mut data = vec![0 as GLuint; buffer_size];
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (4 * buffer_size) as isize,
            data.as_mut_ptr().cast()
        ));
        if !all_sevens(&data, "uData") {
            return false;
        }
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * buffer_size) as isize,
            (4 * buffer_size) as isize,
            data.as_mut_ptr().cast()
        ));
        all_sevens(&data, "iData")
    }
}

impl Subcase for BasicAtomicCase3 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let iterations = [
            ([64, 1, 1], false),
            ([1, 1, 64], true),
            ([1, 1, 4], false),
            ([3, 2, 1], true),
            ([2, 4, 2], false),
            ([2, 4, 7], true),
        ];
        for (local_size, dispatch_indirect) in iterations {
            if !self.run_iteration(gl, local_size, dispatch_indirect) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `AdvancedCopyImage`
#[derive(Default)]
struct AdvancedCopyImage {
    program: GLuint,
    texture: [GLuint; 2],
}

impl Subcase for AdvancedCopyImage {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\n#define TILE_WIDTH 16\n#define TILE_HEIGHT 16\nconst ivec2 kTileSize = ivec2(TILE_WIDTH, TILE_HEIGHT);\n\nlayout(binding = 0, rgba8) uniform image2D g_input_image;\nlayout(binding = 1, rgba8) uniform image2D g_output_image;\n\nlayout(local_size_x=TILE_WIDTH, local_size_y=TILE_HEIGHT) in;\n\nvoid main() {\n  const ivec2 tile_xy = ivec2(gl_WorkGroupID);\n  const ivec2 thread_xy = ivec2(gl_LocalInvocationID);\n  const ivec2 pixel_xy = tile_xy * kTileSize + thread_xy;\n\n  vec4 pixel = imageLoad(g_input_image, pixel_xy);\n  imageStore(g_output_image, pixel_xy, pixel);\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        let in_image = vec![0x0fu8; 64 * 64 * 4];
        let out_image = vec![0x00u8; 64 * 64 * 4];
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        for (texture, image) in self.texture.into_iter().zip([&in_image, &out_image]) {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                64,
                64,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                image.as_ptr().cast()
            ));
        }

        gl!(gl.use_program(self.program));
        gl!(gl.bind_image_texture(0, self.texture[0], 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA8));
        gl!(gl.bind_image_texture(1, self.texture[1], 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA8));
        // 5 is on purpose, to ensure that out of bounds image load and stores have no effect
        gl!(gl.dispatch_compute(5, 4, 1));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));

        let mut data = vec![0u8; 64 * 64 * 4];
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            data.as_mut_ptr().cast()
        ));
        let window_width = context.render_target().width;
        for (i, &value) in data.iter().enumerate() {
            if window_width > 100 && value != 0x0f {
                log::info!("Data at index {i} is {value} should be {}.", 0x0f);
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// `ValidateWindow4Quads`
fn validate_window_4_quads(
    gl: &glw::Functions,
    eps: Vec4,
    lb: [f32; 3],
    rb: [f32; 3],
    rt: [f32; 3],
    lt: [f32; 3],
) -> bool {
    const WIDTH: i32 = 100;
    const HEIGHT: i32 = 100;
    let mut fb = vec![[0.0f32; 3]; (WIDTH * HEIGHT) as usize];
    gl!(gl.read_pixels(0, 0, WIDTH, HEIGHT, glw::GL_RGB, glw::GL_FLOAT, fb.as_mut_ptr().cast()));
    let mut status = true;

    let mut check = |x: i32, y: i32, expected: [f32; 3], label: &str| {
        let color = fb[(y * WIDTH + x) as usize];
        if !color_equal_rgb(color, expected, eps) {
            log::info!("{label} ({x}, {y}): {} {} {}", color[0], color[1], color[2]);
            status = false;
        }
    };
    // left-bottom quad
    for y in 10..HEIGHT / 2 - 10 {
        for x in 10..WIDTH / 2 - 10 {
            check(x, y, lb, "First bad color");
        }
    }
    // right-bottom quad
    for y in 10..HEIGHT / 2 - 10 {
        for x in WIDTH / 2 + 10..WIDTH - 10 {
            check(x, y, rb, "Bad color at");
        }
    }
    // right-top quad
    for y in HEIGHT / 2 + 10..HEIGHT - 10 {
        for x in WIDTH / 2 + 10..WIDTH - 10 {
            check(x, y, rt, "Bad color at");
        }
    }
    // left-top quad
    for y in HEIGHT / 2 + 10..HEIGHT - 10 {
        for x in 10..WIDTH / 2 - 10 {
            check(x, y, lt, "Bad color at");
        }
    }
    // middle horizontal line should be black
    for y in HEIGHT / 2 - 2..HEIGHT / 2 + 2 {
        for x in 0..WIDTH {
            check(x, y, [0.0; 3], "Bad color at");
        }
    }
    // middle vertical line should be black
    for y in 0..HEIGHT {
        for x in WIDTH / 2 - 2..WIDTH / 2 + 2 {
            check(x, y, [0.0; 3], "Bad color at");
        }
    }
    status
}

/// `AdvancedPipelinePreVS`
#[derive(Default)]
struct AdvancedPipelinePreVs {
    program: [GLuint; 2],
    vertex_buffer: GLuint,
    vertex_array: GLuint,
}

impl Subcase for AdvancedPipelinePreVs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 4) in;\nstruct Vertex {\n  vec4 position;\n  vec4 color;\n};\nlayout(binding = 0, std430) buffer VertexBuffer {\n  Vertex g_vertex[];\n};\nuniform float g_scale = 0.8;\nvoid main() {\n  g_vertex[gl_GlobalInvocationID.x].position.xyz *= g_scale;\n  g_vertex[gl_GlobalInvocationID.x].color *= vec4(0, 1, 0, 1);\n}";
        self.program[0] = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program[0]));
        if !check_program(gl, self.program[0]) {
            return Ok(ERROR);
        }

        let glsl_vs = "\nlayout(location = 0) in vec4 g_position;\nlayout(location = 1) in vec4 g_color;\nout StageData {\n  vec4 color;\n} g_vs_out;\nvoid main() {\n  gl_Position = g_position;\n  g_vs_out.color = g_color;\n}";
        let glsl_fs = "\nin StageData {\n  vec4 color;\n} g_fs_in;\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = g_fs_in.color;\n}";
        self.program[1] = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program[1]));
        if !check_program(gl, self.program[1]) {
            return Ok(ERROR);
        }

        // vertex buffer
        {
            let data: [f32; 32] = [
                -1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 0.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0,
            ];
            gl!(gl.gen_buffers(1, &mut self.vertex_buffer));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        }

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 32, std::ptr::null()));
        gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 32, 16usize as *const c_void));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.vertex_buffer));
        gl!(gl.use_program(self.program[0]));
        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.memory_barrier(glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT));
        gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 1));

        let render_target = context.render_target();
        if render_target.width < 500
            && !validate_read_buffer_centered_quad(
                gl,
                color_eps(context),
                render_target.width,
                render_target.height,
                [0.0, 1.0, 0.0],
            )
        {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// `tcu::translationMatrix` as the column-major floats `tcu::Mat4` holds
fn translation_matrix(x: f32, y: f32, z: f32) -> [f32; 16] {
    [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, x, y, z, 1.0]
}

/// `AdvancedPipelineGenDrawCommands`
#[derive(Default)]
struct AdvancedPipelineGenDrawCommands {
    program: [GLuint; 2],
    vertex_buffer: GLuint,
    index_buffer: GLuint,
    vertex_array: GLuint,
    draw_buffer: GLuint,
    object_buffer: GLuint,
}

impl Subcase for AdvancedPipelineGenDrawCommands {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut res: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS, &mut res));
        if res <= 0 {
            output_not_supported("GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS <= 0");
            return Ok(NO_ERROR);
        }

        let glsl_cs = "\nlayout(local_size_x = 4) in;\nstruct DrawCommand {\n  uint count;\n  uint instance_count;\n  uint first_index;\n  int base_vertex;\n  uint base_instance;\n};\nlayout(std430) buffer;\nlayout(binding = 0) readonly buffer ObjectBuffer {\n  mat4 transform[4];\n  uint count[4];\n  uint first_index[4];\n} g_objects;\nlayout(binding = 1) writeonly buffer DrawCommandBuffer {\n  DrawCommand g_command[4];\n};\nbool IsObjectVisible(uint id) {\n  if (g_objects.transform[id][3].x < -1.0 || g_objects.transform[id][3].x > 1.0) return false;\n  if (g_objects.transform[id][3][1] < -1.0 || g_objects.transform[id][3][1] > 1.0) return false;\n  if (g_objects.transform[id][3][2] < -1.0 || g_objects.transform[id][3].z > 1.0) return false;\n  return true;\n}\nvoid main() {\n  uint id = gl_GlobalInvocationID.x;\n  g_command[id].count = 0;\n  g_command[id].instance_count = 0;\n  g_command[id].first_index = 0;\n  g_command[id].base_vertex = 0;\n  g_command[id].base_instance = 0;\n  if (IsObjectVisible(id)) {\n    g_command[id].count = g_objects.count[id];\n    g_command[id].instance_count = 1;\n    g_command[id].first_index = g_objects.first_index[id];\n  }\n}";
        self.program[0] = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program[0]));
        if !check_program(gl, self.program[0]) {
            return Ok(ERROR);
        }

        let glsl_vs = "\nlayout(location = 0) in vec4 g_position;\nlayout(location = 1) in vec3 g_color;\nout StageData {\n  vec3 color;\n} g_vs_out;\nlayout(binding = 0, std430) buffer ObjectBuffer {\n  mat4 transform[4];\n  uint count[4];\n  uint first_index[4];\n} g_objects;\nuniform int g_object_id;\nvoid main() {\n  gl_Position = g_objects.transform[g_object_id] * g_position;\n  g_vs_out.color = g_color;\n}";
        let glsl_fs = "\nin StageData {\n  vec3 color;\n} g_fs_in;\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = vec4(g_fs_in.color, 1);\n}";
        self.program[1] = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program[1]));
        if !check_program(gl, self.program[1]) {
            return Ok(ERROR);
        }

        gl!(gl.viewport(0, 0, 100, 100));

        // object buffer: mat4 transform[4], uint count[4], uint first_index[4]
        {
            let mut data: Vec<u32> = Vec::with_capacity(72);
            for (x, y, z) in [
                (-1.5f32, -0.5f32, 0.0f32),
                (0.5, -0.5, 0.0),
                (-0.5, 0.5, 0.0),
                (0.5, 0.5, 0.0),
            ] {
                data.extend(translation_matrix(x, y, z).map(f32::to_bits));
            }
            data.extend([4, 4, 4, 4]);
            data.extend([0, 4, 8, 12]);
            gl!(gl.gen_buffers(1, &mut self.object_buffer));
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.object_buffer));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (4 * data.len()) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        // vertex buffer
        {
            let colors = [[1.0f32, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0], [1.0, 1.0, 0.0]];
            let corners = [
                [-0.4f32, -0.4, 0.0],
                [0.4, -0.4, 0.0],
                [-0.4, 0.4, 0.0],
                [0.4, 0.4, 0.0],
            ];
            let mut data: Vec<[f32; 3]> = Vec::with_capacity(32);
            for color in colors {
                for corner in corners {
                    data.push(corner);
                    data.push(color);
                }
            }
            gl!(gl.gen_buffers(1, &mut self.vertex_buffer));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (12 * data.len()) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        }
        // index buffer
        {
            let data: [u16; 16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
            gl!(gl.gen_buffers(1, &mut self.index_buffer));
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.index_buffer));
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
        }
        gl!(gl.gen_buffers(1, &mut self.draw_buffer));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.draw_buffer));
        gl!(gl.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            4 * 4 * 5,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, 0));

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
        gl!(gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, 24, std::ptr::null()));
        gl!(gl.vertex_attrib_pointer(1, 3, glw::GL_FLOAT, glw::FALSE, 24, 12usize as *const c_void));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.index_buffer));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.draw_buffer));
        gl!(gl.use_program(self.program[0]));
        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.draw_buffer));
        gl!(gl.memory_barrier(glw::GL_COMMAND_BARRIER_BIT));

        // draw (CPU draw calls dispatch, could be done by the GPU with ARB_multi_draw_indirect)
        let mut offset: usize = 0;
        for i in 0..4 {
            let location = gl!(gl.get_uniform_location(self.program[1], c"g_object_id".as_ptr()));
            gl!(gl.uniform_1i(location, i));
            gl!(gl.draw_elements_indirect(glw::GL_TRIANGLE_STRIP, glw::GL_UNSIGNED_SHORT, offset as *const c_void));
            offset += 5 * 4;
        }

        let render_target = context.render_target();
        if render_target.width >= 100
            && render_target.height >= 100
            && !validate_window_4_quads(
                gl,
                color_eps(context),
                [0.0; 3],
                [0.0, 1.0, 0.0],
                [1.0, 1.0, 0.0],
                [0.0, 0.0, 1.0],
            )
        {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_buffers(1, &self.index_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_buffers(1, &self.draw_buffer));
        gl!(gl.delete_buffers(1, &self.object_buffer));
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        Ok(NO_ERROR)
    }
}

/// `AdvancedPipelinePostFS`
#[derive(Default)]
struct AdvancedPipelinePostFs {
    program: [GLuint; 3],
    render_target: [GLuint; 2],
    framebuffer: GLuint,
    vertex_array: GLuint,
}

impl Subcase for AdvancedPipelinePostFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "\nconst vec2 g_vertex[4] = vec2[4](vec2(0), vec2(-1, -1), vec2(3, -1), vec2(-1, 3));\nvoid main() {\n  gl_Position = vec4(g_vertex[gl_VertexID], 0, 1);\n}";
        let glsl_fs = "\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = vec4(1, 0, 0, 1);\n}";
        self.program[0] = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program[0]));
        if !check_program(gl, self.program[0]) {
            return Ok(ERROR);
        }

        let glsl_cs = "\n#define TILE_WIDTH 16\n#define TILE_HEIGHT 16\nconst ivec2 kTileSize = ivec2(TILE_WIDTH, TILE_HEIGHT);\n\nlayout(binding = 0, rgba32f) uniform image2D g_input_image;\nlayout(binding = 1, rgba32f) uniform image2D g_output_image;\n\nlayout(local_size_x = TILE_WIDTH, local_size_y=TILE_HEIGHT) in;\n\nvoid main() {\n  const ivec2 tile_xy = ivec2(gl_WorkGroupID);\n  const ivec2 thread_xy = ivec2(gl_LocalInvocationID);\n\n  if (thread_xy == ivec2(0)) {\n    const ivec2 pixel_xy = tile_xy * kTileSize;\n    for (int y = 0; y < TILE_HEIGHT; ++y) {\n      for (int x = 0; x < TILE_WIDTH; ++x) {\n        imageStore(g_output_image, pixel_xy + ivec2(x, y), vec4(0, 1, 0, 1));\n      }\n    }\n  }\n}";
        self.program[1] = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program[1]));
        if !check_program(gl, self.program[1]) {
            return Ok(ERROR);
        }

        let glsl_cs2 = "\n#define TILE_WIDTH 32\n#define TILE_HEIGHT 32\nconst ivec2 kTileSize = ivec2(TILE_WIDTH, TILE_HEIGHT);\n\nlayout(binding = 0, rgba32f) uniform image2D g_input_image;\nlayout(binding = 1, rgba32f) uniform image2D g_output_image;\n\nlayout(local_size_x = TILE_WIDTH, local_size_y=TILE_HEIGHT) in;\n\nvec4 Process(vec4 ic) {\n  return ic + vec4(1, 0, 0, 0);\n}\nvoid main() {\n  const ivec2 tile_xy = ivec2(gl_WorkGroupID);\n  const ivec2 thread_xy = ivec2(gl_LocalInvocationID);\n  const ivec2 pixel_xy = tile_xy * kTileSize + thread_xy;\n  vec4 ic = imageLoad(g_input_image, pixel_xy);\n  imageStore(g_output_image, pixel_xy, Process(ic));\n}";
        self.program[2] = create_compute_program(gl, glsl_cs2);
        gl!(gl.link_program(self.program[2]));
        if !check_program(gl, self.program[2]) {
            return Ok(ERROR);
        }

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));

        // init render targets
        {
            let data = vec![[0.0f32; 4]; 128 * 128];
            gl!(gl.gen_textures(2, self.render_target.as_mut_ptr()));
            for texture in self.render_target {
                gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
                gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
                gl!(gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA32F as GLint,
                    128,
                    128,
                    0,
                    glw::GL_RGBA,
                    glw::GL_FLOAT,
                    data.as_ptr().cast()
                ));
            }
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }

        gl!(gl.gen_framebuffers(1, &mut self.framebuffer));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer));
        gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, self.render_target[0], 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer));
        gl!(gl.use_program(self.program[0]));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.viewport(0, 0, 128, 128));
        // draw full-viewport triangle; <first> is 1 so gl_VertexID in the VS will be 1, 2 and 3
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 1, 3));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        gl!(gl.bind_image_texture(
            0,
            self.render_target[0],
            0,
            glw::FALSE,
            0,
            glw::GL_READ_ONLY,
            glw::GL_RGBA32F
        ));
        gl!(gl.bind_image_texture(
            1,
            self.render_target[1],
            0,
            glw::FALSE,
            0,
            glw::GL_WRITE_ONLY,
            glw::GL_RGBA32F
        ));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.dispatch_compute(128 / 16, 128 / 16, 1));

        gl!(gl.bind_image_texture(
            0,
            self.render_target[1],
            0,
            glw::FALSE,
            0,
            glw::GL_READ_ONLY,
            glw::GL_RGBA32F
        ));
        gl!(gl.bind_image_texture(
            1,
            self.render_target[0],
            0,
            glw::FALSE,
            0,
            glw::GL_WRITE_ONLY,
            glw::GL_RGBA32F
        ));
        gl!(gl.use_program(self.program[2]));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.dispatch_compute(128 / 32, 128 / 32, 1));

        // validate render target
        let mut data = vec![[0.0f32; 4]; 128 * 128];
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.render_target[0]));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            data.as_mut_ptr().cast()
        ));
        for (i, value) in data.iter().enumerate() {
            if *value != [1.0, 1.0, 0.0, 1.0] {
                log::info!("Invalid data at index {i}.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_textures(2, self.render_target.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_framebuffers(1, &self.framebuffer));
        Ok(NO_ERROR)
    }
}

/// `AdvancedPipelinePostXFB`
#[derive(Default)]
struct AdvancedPipelinePostXfb {
    program: [GLuint; 2],
    storage_buffer: GLuint,
    xfb_buffer: GLuint,
    vertex_buffer: GLuint,
    vertex_array: GLuint,
}

impl Subcase for AdvancedPipelinePostXfb {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut res: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS, &mut res));
        if res <= 0 {
            output_not_supported("GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS <= 0");
            return Ok(NO_ERROR);
        }

        let glsl_vs = "\nlayout(location = 0) in vec4 g_position;\nlayout(location = 1) in vec4 g_color;\nstruct Vertex {\n  vec4 position;\n  vec4 color;\n};\nout StageData {\n  vec4 color;\n} g_vs_out;\nlayout(binding = 0, std430) buffer StageData {\n  Vertex vertex[];\n} g_vs_buffer;\nvoid main() {\n  gl_Position = g_position;\n  g_vs_out.color = g_color;\n  g_vs_buffer.vertex[gl_VertexID].position = g_position;\n  g_vs_buffer.vertex[gl_VertexID].color = g_color;\n}";
        let glsl_fs = "\nin StageData {\n  vec4 color;\n} g_fs_in;\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = g_fs_in.color;\n}";
        self.program[0] = create_program(gl, glsl_vs, glsl_fs);
        // setup xfb varyings
        {
            let varyings = [c"gl_Position".as_ptr(), c"StageData.color".as_ptr()];
            gl!(gl.transform_feedback_varyings(self.program[0], 2, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        }
        gl!(gl.link_program(self.program[0]));
        if !check_program(gl, self.program[0]) {
            return Ok(ERROR);
        }

        let glsl_cs = "\nlayout(local_size_x = 3) in;\nstruct Vertex {\n  vec4 position;\n  vec4 color;\n};\nlayout(binding = 3, std430) buffer Buffer {\n  Vertex g_vertex[3];\n};\nuniform vec4 g_color1 = vec4(0, 0, 1, 0);\nuniform int g_two = 2;\nvoid UpdateVertex2(int i) {\n  g_vertex[i].color -= vec4(-1, 1, 0, 0);\n}\nvoid main() {\n  switch (gl_GlobalInvocationID.x) {\n    case 0: g_vertex[gl_GlobalInvocationID.x].color += vec4(1, 0, 0, 0); break;\n    case 1: g_vertex[1].color += g_color1; break;\n    case 2: UpdateVertex2(g_two); break;\n    default: return;\n  }\n}";
        self.program[1] = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program[1]));
        if !check_program(gl, self.program[1]) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            3 * 16 * 2,
            std::ptr::null(),
            glw::GL_STATIC_COPY
        ));

        gl!(gl.gen_buffers(1, &mut self.xfb_buffer));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.xfb_buffer));
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            3 * 16 * 2,
            std::ptr::null(),
            glw::GL_STREAM_COPY
        ));

        let in_data: [f32; 24] = [
            -1.0, -1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 3.0, -1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, -1.0, 3.0, 0.0, 1.0,
            0.0, 1.0, 0.0, 1.0,
        ];
        gl!(gl.gen_buffers(1, &mut self.vertex_buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&in_data) as isize,
            in_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 32, std::ptr::null()));
        gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 32, 16usize as *const c_void));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.program[0]));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.begin_transform_feedback(glw::GL_TRIANGLES));
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
        gl!(gl.end_transform_feedback());
        gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT));

        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 3, self.xfb_buffer));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        // validate storage buffer
        {
            let mut data = [0.0f32; 24];
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
            gl!(gl.get_buffer_sub_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                std::mem::size_of_val(&data) as isize,
                data.as_mut_ptr().cast()
            ));
            if data != in_data {
                log::info!("Data in shader storage buffer is incorrect.");
                return Ok(ERROR);
            }
        }
        // validate xfb buffer
        {
            let ref_data: [f32; 24] = [
                -1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 3.0, -1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 1.0, -1.0, 3.0, 0.0, 1.0,
                1.0, 0.0, 0.0, 1.0,
            ];
            let mut data = [0.0f32; 24];
            gl!(gl.get_buffer_sub_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                std::mem::size_of_val(&data) as isize,
                data.as_mut_ptr().cast()
            ));
            if data != ref_data {
                log::info!("Data in xfb buffer is incorrect.");
                return Ok(ERROR);
            }
        }

        let render_target = context.render_target();
        if !validate_read_buffer(
            gl,
            color_eps(context),
            0,
            0,
            render_target.width,
            render_target.height,
            [0.0, 1.0, 0.0, 1.0],
        ) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.xfb_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        Ok(NO_ERROR)
    }
}

/// `AdvancedSharedIndexing`
#[derive(Default)]
struct AdvancedSharedIndexing {
    program: GLuint,
    texture: GLuint,
}

impl Subcase for AdvancedSharedIndexing {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(binding = 3, rgba32f) uniform image2D g_result_image;\nlayout (local_size_x = 4,local_size_y=4 ) in;\nshared vec4 g_shared1[4];\nshared mat4 g_shared2;\nshared struct {\n  float data[4];\n} g_shared3[4];\nshared struct Type { float data[4]; } g_shared4[4];\nshared Type g_shared5[4];\nuniform bool g_true = true;\nuniform float g_values[16] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };\n\nvoid Sync() {\n  groupMemoryBarrier();\n  barrier();\n}\nvoid SetMemory(ivec2 xy, float value) {\n  g_shared1[xy.y][gl_LocalInvocationID.x] = value;\n  g_shared2[xy.y][xy.x] = value;\n  g_shared3[xy[1]].data[xy[0]] = value;\n  g_shared4[xy.y].data[xy[0]] = value;\n  g_shared5[gl_LocalInvocationID.y].data[gl_LocalInvocationID.x] = value;\n}\nbool CheckMemory(ivec2 xy, float expected) {\n  if (g_shared1[xy.y][xy[0]] != expected) return false;\n  if (g_shared2[xy[1]][xy[0]] != expected) return false;\n  if (g_shared3[gl_LocalInvocationID.y].data[gl_LocalInvocationID.x] != expected) return false;\n  if (g_shared4[gl_LocalInvocationID.y].data[xy.x] != expected) return false;\n  if (g_shared5[xy.y].data[xy.x] != expected) return false;\n  return true;\n}\nvoid main() {\n  const ivec2 thread_xy = ivec2(gl_LocalInvocationID);\n  vec4 result = vec4(0, 1, 0, 1);\n\n  SetMemory(thread_xy, g_values[gl_LocalInvocationIndex] * 1.0);\n  Sync();\n  if (!CheckMemory(thread_xy, g_values[gl_LocalInvocationIndex] * 1.0)) result = vec4(1, 0, 0, 1);\n\n  SetMemory(thread_xy, g_values[gl_LocalInvocationIndex] * -1.0);\n  Sync();\n  if (!CheckMemory(thread_xy, g_values[gl_LocalInvocationIndex] * -1.0)) result = vec4(1, 0, 0, 1);\n\n  if (g_true && gl_LocalInvocationID.x < 10) {\n    SetMemory(thread_xy, g_values[gl_LocalInvocationIndex] * 7.0);\n    Sync();\n    if (!CheckMemory(thread_xy, g_values[gl_LocalInvocationIndex] * 7.0)) result = vec4(1, 0, 0, 1);\n  }\n\n  imageStore(g_result_image, thread_xy, result);\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        // init texture
        {
            let data = vec![[0.0f32; 4]; 4 * 4];
            gl!(gl.gen_textures(1, &mut self.texture));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32F as GLint,
                4,
                4,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                data.as_ptr().cast()
            ));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }
        gl!(gl.bind_image_texture(3, self.texture, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA32F));
        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));

        // validate render target
        let mut data = vec![[0.0f32; 4]; 4 * 4];
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            data.as_mut_ptr().cast()
        ));
        for (i, value) in data.iter().enumerate() {
            if *value != [0.0, 1.0, 0.0, 1.0] {
                log::info!("Invalid data at index {i}.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_textures(1, &self.texture));
        Ok(NO_ERROR)
    }
}

/// `AdvancedSharedMax`
#[derive(Default)]
struct AdvancedSharedMax {
    program: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedSharedMax {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1024) in;\nshared struct Type { vec4 v[2]; } g_shared[1024];\nlayout(std430) buffer Output {\n  Type g_output[1024];\n};\n\nvoid main() {\n  const int id = int(gl_GlobalInvocationID.x);\n  g_shared[id].v = vec4[2](vec4(1.0), vec4(1.0));\n  memoryBarrierShared();\n  barrier();\n\n  vec4 sum = vec4(0.0);\n  int sum_count = 0;\n  for (int i = id - 3; i < id + 4; ++i) {\n    if (id >= 0 && id < g_shared.length()) {\n      sum += g_shared[id].v[0];\n      sum += g_shared[id].v[1];\n      sum_count += 2;\n    }\n  }\n  if (any(greaterThan(abs((sum / sum_count) - vec4(1.0)), vec4(0.0000001f)))) return;\n\n  g_output[id] = g_shared[id];\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        // init buffer
        {
            let data = vec![[0.0f32; 4]; 1024 * 2];
            gl!(gl.gen_buffers(1, &mut self.buffer));
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (16 * data.len()) as isize,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY
            ));
        }
        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        // validate buffer
        let mut data = vec![[0.0f32; 4]; 1024 * 2];
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (16 * data.len()) as isize,
            data.as_mut_ptr().cast()
        ));
        for (i, value) in data.iter().enumerate() {
            if *value != [1.0; 4] {
                log::info!("Invalid data at index {i}.");
                return Ok(ERROR);
            }
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

/// A texture buffer object with the buffer holding `data` bound as `internal_format`.
fn upload_texture_buffer(
    gl: &glw::Functions,
    buffer: GLuint,
    texture: GLuint,
    data: &[u8],
    internal_format: GLenum,
    usage: GLenum,
) {
    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, buffer));
    gl!(gl.buffer_data(glw::GL_TEXTURE_BUFFER, data.len() as isize, data.as_ptr().cast(), usage));
    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, texture));
    gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internal_format, buffer));
    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0));
}

fn bytes_of<T: Copy>(values: &[T]) -> &[u8] {
    // SAFETY: only used with plain f32/i32 data; the slice covers exactly the memory of `values`.
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

/// `AdvancedDynamicPaths`
#[derive(Default)]
struct AdvancedDynamicPaths {
    program: GLuint,
    buffer: [GLuint; 4],
    texture: [GLuint; 2],
}

impl Subcase for AdvancedDynamicPaths {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 4) in;\nlayout(std140, binding = 0) buffer Output {\n  vec4 g_output[4];\n};\nuniform isamplerBuffer g_path_buffer;\nuniform vec4[4] g_input0 = vec4[4](vec4(100), vec4(200), vec4(300), vec4(400));\nuniform samplerBuffer g_input1;\nlayout(binding = 1, std430) buffer Input2 {\n  vec4[4] g_input2;\n};\n\nvoid Path2(int id) {\n  g_output[id] = texelFetch(g_input1, int(gl_LocalInvocationIndex));\n}\nvoid main() {\n  const int id = int(gl_GlobalInvocationID.x);\n  const int path = texelFetch(g_path_buffer, id).x;\n\n  if (path == 0) {\n    g_output[id] = g_input0[gl_LocalInvocationID.x];\n    memoryBarrier();\n  } else if (path == 1) {\n    return;\n  } else if (path == 2) {\n    Path2(id);\n    return;\n  } else if (path == 3) {\n    g_output[id] = g_input2[path - 1];\n    memoryBarrierBuffer();\n  }\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(4, self.buffer.as_mut_ptr()));
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));

        // init 'output' buffer
        {
            let data = [[-100.0f32; 4]; 4];
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer[0]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                64,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY
            ));
        }
        // init 'input2' buffer
        {
            let data = [[1.0f32; 4], [2.0; 4], [3.0; 4], [4.0; 4]];
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.buffer[1]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                64,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY
            ));
        }
        // init 'path' buffer
        upload_texture_buffer(
            gl,
            self.buffer[2],
            self.texture[0],
            bytes_of(&[3i32, 2, 1, 0]),
            glw::GL_R32I,
            glw::GL_STATIC_DRAW,
        );
        // init 'input1' buffer
        upload_texture_buffer(
            gl,
            self.buffer[3],
            self.texture[1],
            bytes_of(&[[10.0f32; 4], [20.0; 4], [30.0; 4], [40.0; 4]]),
            glw::GL_RGBA32F,
            glw::GL_STATIC_DRAW,
        );

        gl!(gl.use_program(self.program));
        let location = gl!(gl.get_uniform_location(self.program, c"g_path_buffer".as_ptr()));
        gl!(gl.uniform_1i(location, 0));
        let location = gl!(gl.get_uniform_location(self.program, c"g_input1".as_ptr()));
        gl!(gl.uniform_1i(location, 1));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture[0]));
        gl!(gl.active_texture(glw::GL_TEXTURE1));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture[1]));

        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        // validate 'output' buffer
        let mut data = [[0.0f32; 4]; 4];
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer[0]));
        gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 64, data.as_mut_ptr().cast()));
        let expected = [[3.0f32; 4], [20.0; 4], [-100.0; 4], [400.0; 4]];
        for (i, (value, expected)) in data.iter().zip(&expected).enumerate() {
            if value != expected {
                log::info!("Invalid data at index {i}.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(4, self.buffer.as_ptr()));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// `AdvancedResourcesMax`
#[derive(Default)]
struct AdvancedResourcesMax {
    program: GLuint,
    storage_buffer: [GLuint; 8],
    uniform_buffer: [GLuint; 12],
    atomic_buffer: [GLuint; 8],
    texture_buffer: [GLuint; 16],
    texture: [GLuint; 16],
    image_buffer: [GLuint; 8],
    image: [GLuint; 8],
}

impl AdvancedResourcesMax {
    fn upload_single_uint(gl: &glw::Functions, target: GLenum, buffer: GLuint, value: GLuint, usage: GLenum) {
        gl!(gl.bind_buffer(target, buffer));
        gl!(gl.buffer_data(target, 4, std::ptr::from_ref(&value).cast(), usage));
    }

    fn run_iteration(&mut self, gl: &glw::Functions, index: GLuint) -> bool {
        for i in 0..8usize {
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, self.storage_buffer[i]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                4,
                std::ptr::from_ref(&(i as GLuint + 1)).cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        for i in 0..12usize {
            gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, i as GLuint, self.uniform_buffer[i]));
            gl!(gl.buffer_data(
                glw::GL_UNIFORM_BUFFER,
                4,
                std::ptr::from_ref(&(i as GLuint + 1)).cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        for i in 0..8usize {
            gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, i as GLuint, self.atomic_buffer[i]));
            gl!(gl.buffer_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                4,
                std::ptr::from_ref(&(i as GLuint + 1)).cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        for i in 0..16usize {
            Self::upload_single_uint(
                gl,
                glw::GL_TEXTURE_BUFFER,
                self.texture_buffer[i],
                i as GLuint + 1,
                glw::GL_DYNAMIC_READ,
            );
            gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as GLenum));
            gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture[i]));
            gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32UI, self.texture_buffer[i]));
        }
        for i in 0..8usize {
            Self::upload_single_uint(
                gl,
                glw::GL_TEXTURE_BUFFER,
                self.image_buffer[i],
                i as GLuint + 1,
                glw::GL_DYNAMIC_COPY,
            );
            gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
            gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.image[i]));
            gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32UI, self.image_buffer[i]));
            gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0));
            gl!(gl.bind_image_texture(
                i as GLuint,
                self.image[i],
                0,
                glw::FALSE,
                0,
                glw::GL_READ_ONLY,
                glw::GL_R32UI
            ));
        }

        gl!(gl.use_program(self.program));
        let location = gl!(gl.get_uniform_location(self.program, c"g_index".as_ptr()));
        gl!(gl.uniform_1ui(location, index));
        // uniform array
        {
            let data: Vec<GLuint> = (1..=480).collect();
            let location = gl!(gl.get_uniform_location(self.program, c"g_uniform_def".as_ptr()));
            gl!(gl.uniform_1uiv(location, data.len() as i32, data.as_ptr()));
        }
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let mut result = true;
        // validate buffer
        let mut data: GLuint = 0;
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[index as usize]));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut data).cast()
        ));
        if data != (index + 1) * 6 {
            log::info!("Data is {data} should be {}.", (index + 1) * 6);
            result = false;
        }
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
        result
    }
}

impl Subcase for AdvancedResourcesMax {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let atomic_counters: String = (0..8)
            .map(|i| format!("layout(binding = {i}, offset = 0) uniform atomic_uint g_atomic_counter{i};\n"))
            .collect();
        let atomic_cases: String = (0..8)
            .map(|i| format!("    case {i}: return atomicCounter(g_atomic_counter{i});\n"))
            .collect();
        let glsl_cs = format!(
            "\nlayout(local_size_x = 1) in;\nlayout(std140, binding = 0) buffer ShaderStorageBlock {{\n  uint data;\n}} g_shader_storage[8];\nlayout(std140, binding = 0) uniform UniformBlock {{\n  uint data;\n}} g_uniform[12];\nlayout(binding = 0) uniform usamplerBuffer g_sampler[16];\nlayout(binding = 0, r32ui) uniform uimageBuffer g_image[8];\n{atomic_counters}uniform uint g_uniform_def[480];\nuniform uint g_index = 0u;\n\nuint Add() {{\n  switch (g_index) {{\n{atomic_cases}  }}\n}}\nvoid main() {{\n  g_shader_storage[g_index].data += g_uniform[g_index].data;\n  g_shader_storage[g_index].data += texelFetch(g_sampler[g_index], 0).x;\n  g_shader_storage[g_index].data += imageLoad(g_image[g_index], 0).x;\n  g_shader_storage[g_index].data += Add();\n  g_shader_storage[g_index].data += g_uniform_def[g_index];\n}}"
        );
        self.program = create_compute_program(gl, &glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(8, self.storage_buffer.as_mut_ptr()));
        gl!(gl.gen_buffers(12, self.uniform_buffer.as_mut_ptr()));
        gl!(gl.gen_buffers(8, self.atomic_buffer.as_mut_ptr()));
        gl!(gl.gen_buffers(16, self.texture_buffer.as_mut_ptr()));
        gl!(gl.gen_textures(16, self.texture.as_mut_ptr()));
        gl!(gl.gen_buffers(8, self.image_buffer.as_mut_ptr()));
        gl!(gl.gen_textures(8, self.image.as_mut_ptr()));

        for index in [0, 1, 5] {
            if !self.run_iteration(gl, index) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(8, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(12, self.uniform_buffer.as_ptr()));
        gl!(gl.delete_buffers(8, self.atomic_buffer.as_ptr()));
        gl!(gl.delete_buffers(16, self.texture_buffer.as_ptr()));
        gl!(gl.delete_textures(16, self.texture.as_ptr()));
        gl!(gl.delete_buffers(8, self.image_buffer.as_ptr()));
        gl!(gl.delete_textures(8, self.image.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// `AdvancedFP64Case1`
#[derive(Default)]
struct AdvancedFp64Case1 {
    program: GLuint,
    storage_buffer: [GLuint; 4],
    uniform_buffer: [GLuint; 2],
}

impl Subcase for AdvancedFp64Case1 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 4) in;\nlayout(std140, binding = 0) buffer ShaderStorageBlock {\n  double data;\n} g_shader_storage[4];\nlayout(std140, binding = 0) uniform UniformBlock {\n  double data;\n} g_uniform[2];\nuniform dvec2 g_uniform_def;\n\nvoid main() {\n  if (gl_GlobalInvocationID.x == 0) {\n    g_shader_storage[0].data = floor(g_uniform[0].data + 0.1LF);\n  } else if (gl_GlobalInvocationID.x == 1) {\n    g_shader_storage[1].data = ceil(g_uniform[1].data + 0.2LF);\n  } else if (gl_GlobalInvocationID.x == 2) {\n    g_shader_storage[2].data = min(g_uniform_def[0] + 0.1LF, 1.0LF);\n  } else if (gl_GlobalInvocationID.x == 3) {\n    g_shader_storage[3].data = max(g_uniform_def[0], g_uniform_def.y);\n  }\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(4, self.storage_buffer.as_mut_ptr()));
        for i in 0..4usize {
            let data = (i + 1) as f64;
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, i as GLuint, self.storage_buffer[i]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                8,
                std::ptr::from_ref(&data).cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        gl!(gl.gen_buffers(2, self.uniform_buffer.as_mut_ptr()));
        for i in 0..2usize {
            let data = (i + 1) as f64;
            gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, i as GLuint, self.uniform_buffer[i]));
            gl!(gl.buffer_data(
                glw::GL_UNIFORM_BUFFER,
                8,
                std::ptr::from_ref(&data).cast(),
                glw::GL_STATIC_DRAW
            ));
        }

        gl!(gl.use_program(self.program));
        let location = gl!(gl.get_uniform_location(self.program, c"g_uniform_def".as_ptr()));
        gl!(gl.uniform_2d(location, 1.0, 2.0));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        // validate
        let expected = [1.0f64, 3.0, 1.0, 2.0];
        for (i, expected) in expected.into_iter().enumerate() {
            let mut data = 0.0f64;
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[i]));
            gl!(gl.get_buffer_sub_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                8,
                std::ptr::from_mut(&mut data).cast()
            ));
            if data != expected {
                log::info!("Data at index {i} is {data} should be {expected}.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(4, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(2, self.uniform_buffer.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// `AdvancedFP64Case2`
#[derive(Default)]
struct AdvancedFp64Case2 {
    program: GLuint,
    storage_buffer: GLuint,
}

impl AdvancedFp64Case2 {
    /// `glProgramUniformMatrix*dv` when `program` is given, `glUniformMatrix*dv` otherwise.
    fn set_matrix(gl: &glw::Functions, program: Option<GLuint>, location: GLint, code: &str, value: &[f64]) {
        let value = value.as_ptr();
        let f = glw::FALSE;
        match program {
            Some(program) => match code {
                "2" => gl!(gl.program_uniform_matrix_2dv(program, location, 1, f, value)),
                "2x3" => gl!(gl.program_uniform_matrix_2x_3dv(program, location, 1, f, value)),
                "2x4" => gl!(gl.program_uniform_matrix_2x_4dv(program, location, 1, f, value)),
                "3x2" => gl!(gl.program_uniform_matrix_3x_2dv(program, location, 1, f, value)),
                "3" => gl!(gl.program_uniform_matrix_3dv(program, location, 1, f, value)),
                "3x4" => gl!(gl.program_uniform_matrix_3x_4dv(program, location, 1, f, value)),
                "4x2" => gl!(gl.program_uniform_matrix_4x_2dv(program, location, 1, f, value)),
                "4x3" => gl!(gl.program_uniform_matrix_4x_3dv(program, location, 1, f, value)),
                _ => gl!(gl.program_uniform_matrix_4dv(program, location, 1, f, value)),
            },
            None => match code {
                "2" => gl!(gl.uniform_matrix_2dv(location, 1, f, value)),
                "2x3" => gl!(gl.uniform_matrix_2x_3dv(location, 1, f, value)),
                "2x4" => gl!(gl.uniform_matrix_2x_4dv(location, 1, f, value)),
                "3x2" => gl!(gl.uniform_matrix_3x_2dv(location, 1, f, value)),
                "3" => gl!(gl.uniform_matrix_3dv(location, 1, f, value)),
                "3x4" => gl!(gl.uniform_matrix_3x_4dv(location, 1, f, value)),
                "4x2" => gl!(gl.uniform_matrix_4x_2dv(location, 1, f, value)),
                "4x3" => gl!(gl.uniform_matrix_4x_3dv(location, 1, f, value)),
                _ => gl!(gl.uniform_matrix_4dv(location, 1, f, value)),
            },
        }
    }
}

impl Subcase for AdvancedFp64Case2 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nbuffer Result {\n  int g_result;\n};\nuniform double g_0;\nuniform dvec2 g_1;\nuniform dvec3 g_2;\nuniform dvec4 g_3;\nuniform dmat2 g_4;\nuniform dmat2x3 g_5;\nuniform dmat2x4 g_6;\nuniform dmat3x2 g_7;\nuniform dmat3 g_8;\nuniform dmat3x4 g_9;\nuniform dmat4x2 g_10;\nuniform dmat4x3 g_11;\nuniform dmat4 g_12;\n\nvoid main() {\n  g_result = 1;\n\n  if (g_0 != 1.0LF) g_result = 0;\n  if (g_1 != dvec2(2.0LF, 3.0LF)) g_result = 0;\n  if (g_2 != dvec3(4.0LF, 5.0LF, 6.0LF)) g_result = 0;\n  if (g_3 != dvec4(7.0LF, 8.0LF, 9.0LF, 10.0LF)) g_result = 0;\n\n  if (g_4 != dmat2(11.0LF, 12.0LF, 13.0LF, 14.0LF)) g_result = 0;\n  if (g_5 != dmat2x3(15.0LF, 16.0LF, 17.0LF, 18.0LF, 19.0LF, 20.0LF)) g_result = 0;\n  if (g_6 != dmat2x4(21.0LF, 22.0LF, 23.0LF, 24.0LF, 25.0LF, 26.0LF, 27.0LF, 28.0LF)) g_result = 0;\n\n  if (g_7 != dmat3x2(29.0LF, 30.0LF, 31.0LF, 32.0LF, 33.0LF, 34.0LF)) g_result = 0;\n  if (g_8 != dmat3(35.0LF, 36.0LF, 37.0LF, 38.0LF, 39.0LF, 40.0LF, 41.0LF, 42.0LF, 43.0LF)) g_result = 0;\n  if (g_9 != dmat3x4(44.0LF, 45.0LF, 46.0LF, 47.0LF, 48.0LF, 49.0LF, 50.0LF, 51.0LF, 52.0LF, 53.0LF, 54.0LF, 55.0LF)) g_result = 0;\n\n  if (g_10 != dmat4x2(56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0)) g_result = 0;\n  if (g_11 != dmat4x3(63.0, 64.0, 65.0, 66.0, 67.0, 68.0, 69.0, 70.0, 71.0, 27.0, 73, 74.0)) g_result = 0;\n  if (g_12 != dmat4(75.0, 76.0, 77.0, 78.0, 79.0, 80.0, 81.0, 82.0, 83.0, 84.0, 85.0, 86.0, 87.0, 88.0, 89.0, 90.0)) g_result = 0;\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        {
            let data: GLint = 123;
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                4,
                std::ptr::from_ref(&data).cast(),
                glw::GL_STATIC_DRAW
            ));
        }

        let program = self.program;
        let loc = |name: &str| BasicResourceUniform::location(gl, program, name);
        gl!(gl.program_uniform_1d(program, loc("g_0"), 1.0));
        gl!(gl.program_uniform_2d(program, loc("g_1"), 2.0, 3.0));
        gl!(gl.program_uniform_3d(program, loc("g_2"), 4.0, 5.0, 6.0));
        gl!(gl.program_uniform_4d(program, loc("g_3"), 7.0, 8.0, 9.0, 10.0));
        for (name, code, value) in MATRICES {
            let value: Vec<f64> = value.iter().map(|&v| f64::from(v)).collect();
            Self::set_matrix(gl, Some(program), loc(name), code, &value);
        }

        gl!(gl.use_program(program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        if !BasicResourceUniform::check_result(gl) {
            return Ok(ERROR);
        }

        // re-link program (all uniforms will be set to zero)
        gl!(gl.link_program(program));
        {
            let data: GLint = 123;
            gl!(gl.buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 4, std::ptr::from_ref(&data).cast()));
        }

        gl!(gl.uniform_1d(loc("g_0"), 1.0));
        gl!(gl.uniform_2d(loc("g_1"), 2.0, 3.0));
        gl!(gl.uniform_3d(loc("g_2"), 4.0, 5.0, 6.0));
        gl!(gl.uniform_4d(loc("g_3"), 7.0, 8.0, 9.0, 10.0));
        for (name, code, value) in MATRICES {
            let value: Vec<f64> = value.iter().map(|&v| f64::from(v)).collect();
            Self::set_matrix(gl, None, loc(name), code, &value);
        }

        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        if !BasicResourceUniform::check_result(gl) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `AdvancedFP64Case3`
#[derive(Default)]
struct AdvancedFp64Case3 {
    program: GLuint,
    storage_buffer: GLuint,
}

impl Subcase for AdvancedFp64Case3 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nuniform double[4] g_input;\nuniform int index;\nlayout(std430, binding = 0) buffer Output {\n  double g_output[4];\n};\nsubroutine double MathFunc(double x);\nsubroutine uniform MathFunc g_func[4];\nsubroutine(MathFunc)\ndouble Func0(double x) {\n  return abs(x);\n}\nsubroutine(MathFunc)\ndouble Func1(double x) {\n  return round(x);\n}\nsubroutine(MathFunc)\ndouble Func2(double x) {\n  return sign(x);\n}\nsubroutine(MathFunc)\ndouble Func3(double x) {\n  return fract(x);\n}\nvoid main() {\n  int i = index;\n  g_output[i] = g_func[i](g_input[i]);\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            4 * 8,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));

        let names = [c"Func0", c"Func1", c"Func2", c"Func3"];
        let uniform_names = [c"g_func[0]", c"g_func[1]", c"g_func[2]", c"g_func[3]"];
        let subroutine_indices: Vec<GLuint> = names
            .iter()
            .map(|name| gl!(gl.get_subroutine_index(self.program, glw::GL_COMPUTE_SHADER, name.as_ptr())))
            .collect();
        let locations: Vec<GLint> = uniform_names
            .iter()
            .map(|name| gl!(gl.get_subroutine_uniform_location(self.program, glw::GL_COMPUTE_SHADER, name.as_ptr())))
            .collect();

        gl!(gl.use_program(self.program));
        let mut indices = [0 as GLuint; 4];
        for (location, index) in locations.iter().zip(&subroutine_indices) {
            indices[*location as usize] = *index;
        }
        gl!(gl.uniform_subroutinesuiv(glw::GL_COMPUTE_SHADER, 4, indices.as_ptr()));

        // set uniforms
        {
            let data = [-1.0f64, 2.2, 3.0, 4.1];
            let location = gl!(gl.get_uniform_location(self.program, c"g_input".as_ptr()));
            gl!(gl.uniform_1dv(location, 4, data.as_ptr()));
        }
        for index in 0..4 {
            let location = gl!(gl.get_uniform_location(self.program, c"index".as_ptr()));
            gl!(gl.uniform_1i(location, index));
            gl!(gl.dispatch_compute(1, 1, 1));
        }
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        // validate
        let expected = [1.0f64, 2.0, 1.0, 0.1];
        let mut data = [0.0f64; 4];
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer));
        gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 4 * 8, data.as_mut_ptr().cast()));
        let eps = f64::from(color_eps(context)[0]);
        for (i, (value, expected)) in data.iter().zip(expected).enumerate() {
            if (value - expected).abs() > eps {
                log::info!("Data at index {i} is {value} should be {expected}.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `AdvancedConditionalDispatching`
#[derive(Default)]
struct AdvancedConditionalDispatching {
    program_vsfs: GLuint,
    program_cs: GLuint,
    vertex_array: GLuint,
    query: [GLuint; 2],
    storage_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl AdvancedConditionalDispatching {
    fn read_counter(gl: &glw::Functions) -> GLint {
        let mut data: GLint = 0;
        gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            4,
            std::ptr::from_mut(&mut data).cast()
        ));
        data
    }
}

impl Subcase for AdvancedConditionalDispatching {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "\nuniform float g_depth;\nuniform vec2[3] g_vertex = vec2[3](vec2(-1, -1), vec2(3, -1), vec2(-1, 3));\nvoid main() {\n  gl_Position = vec4(g_vertex[gl_VertexID], g_depth, 1);\n}";
        let glsl_fs = "\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = vec4(0, 1, 0, 1);\n}";
        self.program_vsfs = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program_vsfs));
        if !check_program(gl, self.program_vsfs) {
            return Ok(ERROR);
        }

        let glsl_cs = "\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  int g_output;\n};\nvoid main() {\n  atomicAdd(g_output, 1);\n}";
        self.program_cs = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program_cs));
        if !check_program(gl, self.program_cs) {
            return Ok(ERROR);
        }

        // create storage buffer
        {
            let data: GLint = 0;
            gl!(gl.gen_buffers(1, &mut self.storage_buffer));
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                4,
                std::ptr::from_ref(&data).cast(),
                glw::GL_DYNAMIC_COPY
            ));
        }
        // create dispatch buffer
        {
            let data: [GLuint; 3] = [2, 2, 2];
            gl!(gl.gen_buffers(1, &mut self.dispatch_buffer));
            gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, self.dispatch_buffer));
            gl!(gl.buffer_data(
                glw::GL_DISPATCH_INDIRECT_BUFFER,
                12,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.gen_queries(2, self.query.as_mut_ptr()));

        gl!(gl.enable(glw::GL_DEPTH_TEST));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT));
        gl!(gl.use_program(self.program_vsfs));
        gl!(gl.bind_vertex_array(self.vertex_array));
        let depth_location = gl!(gl.get_uniform_location(self.program_vsfs, c"g_depth".as_ptr()));

        // this draw call will pass depth test
        gl!(gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, self.query[0]));
        gl!(gl.uniform_1f(depth_location, 0.0));
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
        gl!(gl.end_query(glw::GL_ANY_SAMPLES_PASSED));

        // this draw call will NOT pass depth test
        gl!(gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, self.query[1]));
        gl!(gl.uniform_1f(depth_location, 0.5));
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
        gl!(gl.end_query(glw::GL_ANY_SAMPLES_PASSED));

        gl!(gl.disable(glw::GL_DEPTH_TEST));
        gl!(gl.use_program(self.program_cs));

        // these commands should be executed normally
        gl!(gl.begin_conditional_render(self.query[0], glw::GL_QUERY_WAIT));
        gl!(gl.dispatch_compute(2, 2, 2));
        gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT));
        gl!(gl.dispatch_compute_indirect(0));
        gl!(gl.end_conditional_render());

        let data = Self::read_counter(gl);
        if data != 16 {
            log::info!("Data is {data} should be 16.");
            return Ok(ERROR);
        }

        // these commands should be discarded
        gl!(gl.begin_conditional_render(self.query[1], glw::GL_QUERY_WAIT));
        gl!(gl.dispatch_compute(2, 2, 2));
        gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT));
        gl!(gl.dispatch_compute_indirect(0));
        gl!(gl.end_conditional_render());

        let data = Self::read_counter(gl);
        let depth_bits = context.render_target().depth_bits;
        if data != 16 && depth_bits != 0 {
            log::info!("Data is {data} should be 16.");
            return Ok(ERROR);
        } else if data != 32 && depth_bits == 0 {
            log::info!("Data is {data} should be 32.");
            return Ok(ERROR);
        }

        let render_target = context.render_target();
        if !validate_read_buffer(
            gl,
            color_eps(context),
            0,
            0,
            render_target.width,
            render_target.height,
            [0.0, 1.0, 0.0, 1.0],
        ) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program_vsfs));
        gl!(gl.delete_program(self.program_cs));
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_queries(2, self.query.as_ptr()));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

const NO_ACTIVE_PROGRAM_MESSAGE: &str = "INVALID_OPERATION is generated by DispatchCompute or\nDispatchComputeIndirect if there is no active program for the compute\nshader stage.";

fn dispatch_compute_error_is_invalid_operation(gl: &glw::Functions) -> bool {
    gl!(gl.get_error()) == glw::GL_INVALID_OPERATION
}

fn dispatch_compute_indirect_from_new_buffer(gl: &glw::Functions) {
    let mut buffer: GLuint = 0;
    let num_group: [GLuint; 3] = [3, 2, 1];
    gl!(gl.gen_buffers(1, &mut buffer));
    gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, buffer));
    gl!(gl.buffer_data(
        glw::GL_DISPATCH_INDIRECT_BUFFER,
        12,
        num_group.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.dispatch_compute_indirect(0));
    gl!(gl.delete_buffers(1, &buffer));
}

/// `NegativeAPINoActiveProgram`
#[derive(Default)]
struct NegativeApiNoActiveProgram {
    program: GLuint,
}

impl Subcase for NegativeApiNoActiveProgram {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.dispatch_compute(1, 2, 3));
        if !dispatch_compute_error_is_invalid_operation(gl) {
            log::info!("{NO_ACTIVE_PROGRAM_MESSAGE}");
            return Ok(ERROR);
        }

        // indirect dispatch
        dispatch_compute_indirect_from_new_buffer(gl);
        if !dispatch_compute_error_is_invalid_operation(gl) {
            log::info!("{NO_ACTIVE_PROGRAM_MESSAGE}");
            return Ok(ERROR);
        }

        let glsl_vs = "\nlayout(location = 0) in vec4 g_position;\nvoid main() {\n  gl_Position = g_position;\n}";
        let glsl_fs = "\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = vec4(1);\n}";
        self.program = create_program(gl, glsl_vs, glsl_fs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.program));

        gl!(gl.dispatch_compute(1, 2, 3));
        if !dispatch_compute_error_is_invalid_operation(gl) {
            log::info!("{NO_ACTIVE_PROGRAM_MESSAGE}");
            return Ok(ERROR);
        }

        // indirect dispatch
        dispatch_compute_indirect_from_new_buffer(gl);
        if !dispatch_compute_error_is_invalid_operation(gl) {
            log::info!("{NO_ACTIVE_PROGRAM_MESSAGE}");
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

/// `NegativeAPIWorkGroupCount`
#[derive(Default)]
struct NegativeApiWorkGroupCount {
    program: GLuint,
    storage_buffer: GLuint,
}

impl Subcase for NegativeApiWorkGroupCount {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  g_output[gl_GlobalInvocationID.x * gl_GlobalInvocationID.y * gl_GlobalInvocationID.z] = 0;\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            100000,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));

        let mut count = [0 as GLint; 3];
        for (index, value) in count.iter_mut().enumerate() {
            gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_COUNT, index as GLuint, value));
        }
        let [x, y, z] = count;

        gl!(gl.use_program(self.program));
        let dispatches = [
            (x as GLuint + 1, 1, 1),
            (1, y as GLuint + 1, 1),
            (1, 1, z as GLuint + 1),
        ];
        for (groups_x, groups_y, groups_z) in dispatches {
            gl!(gl.dispatch_compute(groups_x, groups_y, groups_z));
            if gl!(gl.get_error()) != glw::GL_INVALID_VALUE {
                log::info!(
                    "INVALID_VALUE is generated by DispatchCompute if any of <num_groups_x>,\n<num_groups_y> or <num_groups_z> is greater than the value of\nMAX_COMPUTE_WORK_GROUP_COUNT for the corresponding dimension."
                );
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `NegativeAPIIndirect`
#[derive(Default)]
struct NegativeApiIndirect {
    program: GLuint,
    storage_buffer: GLuint,
    dispatch_buffer: GLuint,
}

impl Subcase for NegativeApiIndirect {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_cs = "\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  g_output[gl_GlobalInvocationID.x] = 0;\n}";
        self.program = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.storage_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            100000,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));

        let num_groups: [GLuint; 6] = [1; 6];
        gl!(gl.gen_buffers(1, &mut self.dispatch_buffer));
        gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, self.dispatch_buffer));
        gl!(gl.buffer_data(
            glw::GL_DISPATCH_INDIRECT_BUFFER,
            24,
            num_groups.as_ptr().cast(),
            glw::GL_STATIC_COPY
        ));

        gl!(gl.use_program(self.program));
        let invalid_value_message = "INVALID_VALUE is generated by DispatchComputeIndirect if <indirect> is\nless than zero or not a multiple of four.";
        let invalid_operation_message = "INVALID_OPERATION is generated by DispatchComputeIndirect if no buffer is\nbound to DISPATCH_INDIRECT_BUFFER or if the command would source data\nbeyond the end of the bound buffer object.";

        gl!(gl.dispatch_compute_indirect(-2));
        if gl!(gl.get_error()) != glw::GL_INVALID_VALUE {
            log::info!("{invalid_value_message}");
            return Ok(ERROR);
        }
        gl!(gl.dispatch_compute_indirect(3));
        if gl!(gl.get_error()) != glw::GL_INVALID_VALUE {
            log::info!("{invalid_value_message}");
            return Ok(ERROR);
        }
        gl!(gl.dispatch_compute_indirect(16));
        if gl!(gl.get_error()) != glw::GL_INVALID_OPERATION {
            log::info!("{invalid_operation_message}");
            return Ok(ERROR);
        }
        gl!(gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, 0));
        gl!(gl.dispatch_compute_indirect(0));
        if gl!(gl.get_error()) != glw::GL_INVALID_OPERATION {
            log::info!("{invalid_operation_message}");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        gl!(gl.delete_buffers(1, &self.dispatch_buffer));
        Ok(NO_ERROR)
    }
}

/// `NegativeAPIProgram`
#[derive(Default)]
struct NegativeApiProgram {
    program: GLuint,
    storage_buffer: GLuint,
}

impl Subcase for NegativeApiProgram {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "\nlayout(location = 0) in vec4 g_position;\nvoid main() {\n  gl_Position = g_position;\n}";
        let glsl_fs = "\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  g_color = vec4(1);\n}";
        self.program = create_program(gl, glsl_vs, glsl_fs);

        let work_group_size_message = "INVALID_OPERATION is generated by GetProgramiv if <pname> is\nCOMPUTE_LOCAL_WORK_SIZE and either the program has not been linked\nsuccessfully, or has been linked but contains no compute shaders.";
        let mut v = [0 as GLint; 3];
        gl!(gl.get_programiv(self.program, glw::GL_COMPUTE_WORK_GROUP_SIZE, v.as_mut_ptr()));
        if gl!(gl.get_error()) != glw::GL_INVALID_OPERATION {
            log::info!("{work_group_size_message}");
            return Ok(ERROR);
        }

        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        gl!(gl.get_programiv(self.program, glw::GL_COMPUTE_WORK_GROUP_SIZE, v.as_mut_ptr()));
        if gl!(gl.get_error()) != glw::GL_INVALID_OPERATION {
            log::info!("{work_group_size_message}");
            return Ok(ERROR);
        }

        gl!(gl.delete_program(self.program));

        let glsl_cs = "#version 430 core\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  g_output[gl_GlobalInvocationID.x] = 0;\n}";
        self.program = gl!(gl.create_program());
        // upstream compiles the version-less vertex and fragment sources as they are
        for (shader_type, source) in [
            (glw::GL_COMPUTE_SHADER, glsl_cs),
            (glw::GL_VERTEX_SHADER, glsl_vs),
            (glw::GL_FRAGMENT_SHADER, glsl_fs),
        ] {
            let shader = gl!(gl.create_shader(shader_type));
            gl!(gl.attach_shader(self.program, shader));
            gl!(gl.delete_shader(shader));
            shader_source_parts(gl, shader, &[source]);
            gl!(gl.compile_shader(shader));
        }
        gl!(gl.link_program(self.program));
        if get_program_value(gl, self.program, glw::GL_LINK_STATUS) == glw::GL_TRUE as GLint {
            log::info!(
                "LinkProgram will fail if <program> contains a combination of compute and\n non-compute shaders.\n"
            );
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.storage_buffer));
        Ok(NO_ERROR)
    }
}

/// `NegativeGLSLCompileTimeErrors`
struct NegativeGlslCompileTimeErrors;

impl NegativeGlslCompileTimeErrors {
    fn shader1(x: GLint, y: GLint, z: GLint) -> String {
        format!(
            "#version 430 core\nlayout(local_size_x = {x}, local_size_y = {y}, local_size_z = {z}) in;\nlayout(std430) buffer Output {{\n  uint g_output[];\n}};\nvoid main() {{\n  g_output[gl_GlobalInvocationID.x] = 0;\n}}"
        )
    }

    /// Returns whether the compilation failed, as it should.
    fn compile(gl: &glw::Functions, source: &str) -> bool {
        let shader = create_compute_shader(gl, &[source]);
        let mut info_log = [0u8; 1024];
        gl!(gl.get_shader_info_log(
            shader,
            info_log.len() as i32,
            std::ptr::null_mut(),
            info_log.as_mut_ptr().cast()
        ));
        log::info!("Shader Info Log:\n{}", buffer_to_string(&info_log));
        let status = compile_status_of(gl, shader);
        gl!(gl.delete_shader(shader));
        if status == glw::GL_TRUE as GLint {
            log::info!("Compilation should fail.");
            return false;
        }
        true
    }
}

fn compile_status_of(gl: &glw::Functions, shader: GLuint) -> GLint {
    let mut status = 0;
    gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
    status
}

impl Subcase for NegativeGlslCompileTimeErrors {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let sources = [
            // gl_GlobalInvocationID requires "#version 430" or later or GL_ARB_compute_shader extension enabled
            "#version 420 core\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  g_output[gl_GlobalInvocationID.x] = 0;\n}",
            "#version 430 core\nlayout(local_size_x = 1) in;\nlayout(local_size_x = 2) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  g_output[gl_GlobalInvocationID.x] = 0;\n}",
            "#version 430 core\nlayout(local_size_x = 1) in;\nin uint x;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  g_output[gl_GlobalInvocationID.x] = x;\n}",
            "#version 430 core\nlayout(local_size_x = 1) in;\nout uint x;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  g_output[gl_GlobalInvocationID.x] = 0;\n  x = 0;\n}",
        ];
        for source in sources {
            if !Self::compile(gl, source) {
                return Ok(ERROR);
            }
        }

        // upstream queries index 0 for all three components
        let mut max_size: GLint = 0;
        gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 0, &mut max_size));
        let (x, y, z) = (max_size, max_size, max_size);
        for source in [
            Self::shader1(x + 1, 1, 1),
            Self::shader1(1, y + 1, 1),
            Self::shader1(1, 1, z + 1),
        ] {
            if !Self::compile(gl, &source) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

/// `NegativeGLSLLinkTimeErrors`
struct NegativeGlslLinkTimeErrors;

impl NegativeGlslLinkTimeErrors {
    /// Returns whether the link failed, as it should.
    fn link(gl: &glw::Functions, cs0: &str, cs1: &str) -> bool {
        let program = gl!(gl.create_program());
        for (index, source) in [cs0, cs1].into_iter().enumerate() {
            let shader = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
            gl!(gl.attach_shader(program, shader));
            gl!(gl.delete_shader(shader));
            shader_source_parts(gl, shader, &[source]);
            gl!(gl.compile_shader(shader));
            if compile_status_of(gl, shader) == glw::GL_FALSE as GLint {
                gl!(gl.delete_program(program));
                log::info!("CS{index} compilation should be ok.");
                return false;
            }
        }

        gl!(gl.link_program(program));
        let mut info_log = [0u8; 1024];
        gl!(gl.get_program_info_log(
            program,
            info_log.len() as i32,
            std::ptr::null_mut(),
            info_log.as_mut_ptr().cast()
        ));
        log::info!("Program Info Log:\n{}", buffer_to_string(&info_log));
        let status = get_program_value(gl, program, glw::GL_LINK_STATUS);
        gl!(gl.delete_program(program));
        if status == glw::GL_TRUE as GLint {
            log::info!("Link operation should fail.");
            return false;
        }
        true
    }
}

impl Subcase for NegativeGlslLinkTimeErrors {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        // no layout
        if !Self::link(
            gl,
            "#version 430 core\nvoid Run();\nvoid main() {\n  Run();\n}",
            "#version 430 core\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid Run() {\n  g_output[gl_GlobalInvocationID.x] = 0;\n}",
        ) {
            return Ok(ERROR);
        }
        if !Self::link(
            gl,
            "#version 430 core\nlayout(local_size_x = 2) in;\nvoid Run();\nvoid main() {\n  Run();\n}",
            "#version 430 core\nlayout(local_size_x = 1) in;\nlayout(std430) buffer Output {\n  uint g_output[];\n};\nvoid Run() {\n  g_output[gl_GlobalInvocationID.x] = 0;\n}",
        ) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

/// `AdvancedPipelineComputeChain`
#[derive(Default)]
struct AdvancedPipelineComputeChain {
    program: [GLuint; 3],
    storage_buffer: [GLuint; 4],
    counter_buffer: GLuint,
    texture: GLuint,
    fbo: GLuint,
}

impl AdvancedPipelineComputeChain {
    const COMMON: &'static str = "\nstruct S0 {\n  int m0[8];\n};\nstruct S1 {\n  S0 m0[8];\n};\nlayout(binding = 0, std430) buffer Buffer0 {\n  int m0[5];\n  S1 m1[8];\n} g_buffer0;\nlayout(binding = 1, std430) buffer Buffer1 {\n  uint data[8];\n} g_buffer1;\nlayout(binding = 2, std430) buffer Buffer2 {\n  int data[256];\n} g_buffer2;\nlayout(binding = 3, std430) buffer Buffer3 {\n  int data[256];\n} g_buffer3;\nlayout(binding = 4, std430) buffer Buffer4 {\n  mat4 data0;\n  mat4 data1;\n} g_buffer4;\nlayout(binding = 0, rgba32f) uniform image2D g_image0;\nlayout(binding = 1, offset = 8) uniform atomic_uint g_counter[2];";

    fn gen_glsl(p: usize) -> String {
        let mut ss = String::from(Self::COMMON);
        match p {
            0 => ss.push_str("\nlayout(local_size_x = 4, local_size_y = 4, local_size_z = 4) in;\nvoid UpdateBuffer0(uvec3 id, int add_val) {\n  if (id.x < 8 && id.y < 8 && id.z < 8) {\n    g_buffer0.m1[id.z].m0[id.y].m0[id.x] += add_val;\n  }\n}\nuniform int g_add_value = 1;\nuniform uint g_counter_y = 1;\nuniform vec4 g_image_value = vec4(0.125, 0.25, 0.375, 0.5);\nvoid main() {\n  uvec3 id = gl_GlobalInvocationID;\n  UpdateBuffer0(id, 1);\n  UpdateBuffer0(id, g_add_value);\n  if (id == uvec3(1, g_counter_y, 1)) {\n    uint idx = atomicCounterIncrement(g_counter[1]);\n    g_buffer1.data[idx] = idx;\n    idx = atomicCounterIncrement(g_counter[1]);\n    g_buffer1.data[idx] = idx;\n  }\n  if (id.x < 4 && id.y < 4 && id.z == 0) {\n    vec4 v = imageLoad(g_image0, ivec2(id.xy));\n    imageStore(g_image0, ivec2(id.xy), v + g_image_value);\n  }\n  if (id.x < 2 && id.y == 0 && id.z == 0) {\n    g_buffer2.data[id.x] -= int(g_counter_y);\n  }\n}"),
            1 => ss.push_str("\nlayout(local_size_x = 4, local_size_y = 4, local_size_z = 1) in;\nuniform mat4 g_mvp = mat4(1.0, 0.0, 0.0, 0.0,  0.0, 1.0, 0.0, 0.0,  0.0, 0.0, 1.0, 0.0,  10.0, 20.0, 30.0, 1.0);\nvoid main() {\n  if (gl_GlobalInvocationID == uvec3(0)) {\n    g_buffer4.data0 *= g_mvp;\n  }\n  if (gl_WorkGroupID == uvec3(0)) {\n    g_buffer4.data1[gl_LocalInvocationID.y][gl_LocalInvocationID.x] = g_mvp[gl_LocalInvocationID.x][gl_LocalInvocationID.y];\n  }\n}"),
            2 => ss.push_str("\nlayout(local_size_x = 4, local_size_y = 4, local_size_z = 4) in;\nvoid main() {\n}"),
            _ => {}
        }
        ss
    }
}

impl Subcase for AdvancedPipelineComputeChain {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        for i in 0..3 {
            self.program[i] = create_compute_program(gl, &Self::gen_glsl(i));
            gl!(gl.link_program(self.program[i]));
            if !check_program(gl, self.program[i]) {
                return Ok(ERROR);
            }
        }

        gl!(gl.gen_buffers(4, self.storage_buffer.as_mut_ptr()));
        // storage buffer 0
        {
            let data = vec![0i32; 5 + 8 * 8 * 8];
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.storage_buffer[0]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (4 * data.len()) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_COPY
            ));
        }
        // storage buffer 1
        {
            let data = [0 as GLuint; 8];
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.storage_buffer[1]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_COPY
            ));
        }
        // storage buffer 2 & 3
        {
            let data = vec![7 as GLint; 512];
            let half = (4 * data.len() / 2) as isize;
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[2]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                (4 * data.len()) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_COPY
            ));
            gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 2, self.storage_buffer[2], 0, half));
            gl!(gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 3, self.storage_buffer[2], half, half));
        }
        // storage buffer 4: two identity matrices, which is what a default-constructed tcu::Mat4 is
        {
            let identity = translation_matrix(0.0, 0.0, 0.0);
            let mut data = [0.0f32; 32];
            data[..16].copy_from_slice(&identity);
            data[16..].copy_from_slice(&identity);
            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 4, self.storage_buffer[3]));
            gl!(gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                128,
                data.as_ptr().cast(),
                glw::GL_STATIC_COPY
            ));
        }
        // counter buffer
        {
            let data = [0 as GLuint; 4];
            gl!(gl.gen_buffers(1, &mut self.counter_buffer));
            gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 1, self.counter_buffer));
            gl!(gl.buffer_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_COPY
            ));
        }
        // texture
        {
            let data = vec![[0.0f32; 4]; 4 * 4];
            gl!(gl.gen_textures(1, &mut self.texture));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32F as GLint,
                4,
                4,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                data.as_ptr().cast()
            ));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }

        gl!(gl.use_program(self.program[0]));
        gl!(gl.bind_image_texture(0, self.texture, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_RGBA32F));
        gl!(gl.dispatch_compute(2, 2, 2));
        gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT | glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.dispatch_compute(3, 2, 2));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.dispatch_compute(4, 3, 7));
        gl!(gl.memory_barrier(
            glw::GL_BUFFER_UPDATE_BARRIER_BIT
                | glw::GL_TEXTURE_UPDATE_BARRIER_BIT
                | glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT
        ));

        // validate texture
        {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
            gl!(gl.gen_framebuffers(1, &mut self.fbo));
            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
            gl!(gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.texture,
                0
            ));
            let mut color_data = vec![0u8; 4 * 4 * 4];
            gl!(gl.read_pixels(
                0,
                0,
                4,
                4,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                color_data.as_mut_ptr().cast()
            ));
            let eps = color_eps(context);
            for texel in color_data.chunks_exact(4) {
                let value = [texel[0], texel[1], texel[2], texel[3]].map(|byte| (f64::from(byte) / 255.0) as f32);
                if !color_equal(value, [0.25, 0.5, 0.75, 1.0], eps) {
                    log::info!("Invalid data at texture.");
                    return Ok(ERROR);
                }
            }
        }
        // validate storage buffer 0
        {
            let mut data = vec![0i32; 5 + 8 * 8 * 8];
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[0]));
            gl!(gl.get_buffer_sub_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                (4 * data.len()) as isize,
                data.as_mut_ptr().cast()
            ));
            for &value in &data[5..] {
                if value != 4 {
                    log::info!("Data is {value} should be 2.");
                    return Ok(ERROR);
                }
            }
        }
        // validate storage buffer 1
        {
            let mut data = [0 as GLuint; 8];
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[1]));
            gl!(gl.get_buffer_sub_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                std::mem::size_of_val(&data) as isize,
                data.as_mut_ptr().cast()
            ));
            for i in 0..4 {
                if data[i] != i as GLuint {
                    log::info!("Data is {} should be {i}.", data[i]);
                    return Ok(ERROR);
                }
            }
        }
        // validate storage buffer 2 & 3
        {
            let mut data = vec![0 as GLint; 512];
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[2]));
            gl!(gl.get_buffer_sub_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                (4 * data.len()) as isize,
                data.as_mut_ptr().cast()
            ));
            for i in 0..2 {
                if data[i] != 5 {
                    log::info!("Data is: {} should be: 5.", data[i]);
                    return Ok(ERROR);
                }
                if data[i + 256] != 7 {
                    log::info!("Data is: {} should be: 7.", data[i + 256]);
                    return Ok(ERROR);
                }
            }
        }
        // validate storage buffer 4
        {
            let mut data = [0.0f32; 32];
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.storage_buffer[3]));
            gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 128, data.as_mut_ptr().cast()));
            let translation = translation_matrix(10.0, 20.0, 30.0);
            if data[..16] != translation {
                log::info!("Data is incorrect.");
                return Ok(ERROR);
            }
            let mut transposed = [0.0f32; 16];
            for column in 0..4 {
                for row in 0..4 {
                    transposed[column * 4 + row] = translation[row * 4 + column];
                }
            }
            if data[16..] != transposed {
                log::info!("Data is incorrect.");
                return Ok(ERROR);
            }
        }
        // validate counter buffer
        {
            let mut data = [0 as GLuint; 4];
            gl!(gl.get_buffer_sub_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                0,
                std::mem::size_of_val(&data) as isize,
                data.as_mut_ptr().cast()
            ));
            if data[3] != 4 {
                log::info!("Data is: {} should be: 4.", data[3]);
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_buffers(4, self.storage_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_framebuffers(1, &self.fbo));
        Ok(NO_ERROR)
    }
}

fn add_case<F: Fn() -> Box<dyn Subcase> + Send + Sync + 'static>(group: &mut TestCaseGroup, name: &str, factory: F) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

/// `ComputeShaderTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("compute_shader");
    add_case(&mut group, "simple-compute", || Box::new(SimpleCompute::default()));
    add_case(&mut group, "one-work-group", || Box::new(BasicOneWorkGroup::default()));
    add_case(&mut group, "resource-ubo", || Box::new(BasicResourceUbo::default()));
    add_case(&mut group, "resource-texture", || {
        Box::new(BasicResourceTexture::default())
    });
    add_case(&mut group, "resource-image", || Box::new(BasicResourceImage::default()));
    add_case(&mut group, "resource-atomic-counter", || {
        Box::new(BasicResourceAtomicCounter::default())
    });
    add_case(&mut group, "resource-subroutine", || {
        Box::new(BasicResourceSubroutine::default())
    });
    add_case(&mut group, "resource-uniform", || {
        Box::new(BasicResourceUniform::default())
    });
    add_case(&mut group, "built-in-variables", || {
        Box::new(BasicBuiltinVariables::default())
    });
    add_case(&mut group, "max", || Box::new(BasicMax::default()));
    add_case(&mut group, "work-group-size", || {
        Box::new(BasicWorkGroupSizeIsConst::default())
    });
    add_case(&mut group, "build-monolithic", || Box::new(BasicBuildMonolithic));
    add_case(&mut group, "build-separable", || Box::new(BasicBuildSeparable));
    add_case(&mut group, "shared-simple", || Box::new(BasicSharedSimple::default()));
    add_case(&mut group, "shared-struct", || Box::new(BasicSharedStruct::default()));
    add_case(&mut group, "dispatch-indirect", || {
        Box::new(BasicDispatchIndirect::default())
    });
    add_case(&mut group, "sso-compute-pipeline", || {
        Box::new(BasicSsoComputePipeline::default())
    });
    add_case(&mut group, "sso-case2", || Box::new(BasicSsoCase2::default()));
    add_case(&mut group, "sso-case3", || Box::new(BasicSsoCase3::default()));
    add_case(&mut group, "atomic-case1", || Box::new(BasicAtomicCase1::default()));
    add_case(&mut group, "atomic-case2", || Box::new(BasicAtomicCase2::default()));
    add_case(&mut group, "atomic-case3", || Box::new(BasicAtomicCase3::default()));
    add_case(&mut group, "copy-image", || Box::new(AdvancedCopyImage::default()));
    add_case(&mut group, "pipeline-pre-vs", || {
        Box::new(AdvancedPipelinePreVs::default())
    });
    add_case(&mut group, "pipeline-gen-draw-commands", || {
        Box::new(AdvancedPipelineGenDrawCommands::default())
    });
    add_case(&mut group, "pipeline-compute-chain", || {
        Box::new(AdvancedPipelineComputeChain::default())
    });
    add_case(&mut group, "pipeline-post-fs", || {
        Box::new(AdvancedPipelinePostFs::default())
    });
    add_case(&mut group, "pipeline-post-xfb", || {
        Box::new(AdvancedPipelinePostXfb::default())
    });
    add_case(&mut group, "shared-indexing", || {
        Box::new(AdvancedSharedIndexing::default())
    });
    add_case(&mut group, "shared-max", || Box::new(AdvancedSharedMax::default()));
    add_case(
        &mut group,
        "dynamic-paths",
        || Box::new(AdvancedDynamicPaths::default()),
    );
    add_case(
        &mut group,
        "resources-max",
        || Box::new(AdvancedResourcesMax::default()),
    );
    add_case(&mut group, "fp64-case1", || Box::new(AdvancedFp64Case1::default()));
    add_case(&mut group, "fp64-case2", || Box::new(AdvancedFp64Case2::default()));
    add_case(&mut group, "fp64-case3", || Box::new(AdvancedFp64Case3::default()));
    add_case(&mut group, "conditional-dispatching", || {
        Box::new(AdvancedConditionalDispatching::default())
    });
    add_case(&mut group, "api-no-active-program", || {
        Box::new(NegativeApiNoActiveProgram::default())
    });
    add_case(&mut group, "api-work-group-count", || {
        Box::new(NegativeApiWorkGroupCount::default())
    });
    add_case(&mut group, "api-indirect", || Box::new(NegativeApiIndirect::default()));
    add_case(&mut group, "api-program", || Box::new(NegativeApiProgram::default()));
    add_case(&mut group, "glsl-compile-time-errors", || {
        Box::new(NegativeGlslCompileTimeErrors)
    });
    add_case(&mut group, "glsl-link-time-errors", || {
        Box::new(NegativeGlslLinkTimeErrors)
    });
    group
}
