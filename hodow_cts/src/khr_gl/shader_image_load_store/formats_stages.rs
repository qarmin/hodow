// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (BasicAllFormatsStoreGeometryStages, BasicAllFormatsLoadGeometryStages, BasicAllFormatsLoadStoreComputeStage)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `Write<T>`/`Read<T>` templates are generic over `Texel` and the rows of `Run` are `formats::format_cases`. Written without compiling.

use super::base::*;
use super::formats::{FormatCase, format_cases, vec_to_glsl};
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};

fn nearest(gl: &glw::Functions, target: GLenum) {
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
}

/// The four geometry-stage shaders of the store case, one image each: (name suffix, stage specific head, coordinate expression).
const STAGE_COORDS: [&str; 4] = ["gl_VertexID", "gl_PrimitiveID", "gl_PrimitiveID", "gl_PrimitiveIDIn"];

/// `GenVS`/`GenTCS`/`GenTES`/`GenGS` of BasicAllFormatsStoreGeometryStages
fn gen_store_stage<T: Texel>(stage: usize, internalformat: GLenum, value: &[T; 4]) -> String {
    let prefix = T::type_prefix();
    let format = format_enum_to_string(internalformat);
    let value = vec_to_glsl(value);
    let coord = STAGE_COORDS[stage];
    let head = match stage {
        0 => String::new(),
        1 => "layout(vertices = 1) out;\n".to_string(),
        2 => "layout(triangles, point_mode) in;\n".to_string(),
        _ => "layout(points) in;\nlayout(points, max_vertices = 1) out;\n".to_string(),
    };
    let tess_levels = if stage == 1 {
        "  gl_TessLevelInner[0] = 1;\n  gl_TessLevelInner[1] = 1;\n  gl_TessLevelOuter[0] = 1;\n  gl_TessLevelOuter[1] = 1;\n  gl_TessLevelOuter[2] = 1;\n  gl_TessLevelOuter[3] = 1;\n"
    } else {
        ""
    };
    format!(
        "#version 420 core\n{head}layout({format}) writeonly uniform {prefix}image2DArray g_image{stage};\nvoid main() {{\n{tess_levels}  ivec3 coord = ivec3({coord}, 0, 0);\n  imageStore(g_image{stage}, coord, {prefix}vec4{value});\n}}"
    )
}

/// `GenVS`/`GenTCS`/`GenTES`/`GenGS` of BasicAllFormatsLoadGeometryStages
fn gen_load_stage<T: Texel>(stage: usize, internalformat: GLenum, expected_value: &[T; 4]) -> String {
    let prefix = T::type_prefix();
    let format = format_enum_to_string(internalformat);
    let expected = vec_to_glsl(expected_value);
    let coord = STAGE_COORDS[stage];
    let head = match stage {
        0 => String::new(),
        1 => "layout(vertices = 1) out;\n".to_string(),
        2 => "layout(triangles, point_mode) in;\n".to_string(),
        _ => "layout(points) in;\nlayout(points, max_vertices = 1) out;\n".to_string(),
    };
    let tess_levels = if stage == 1 {
        "  gl_TessLevelInner[0] = 1;\n  gl_TessLevelInner[1] = 1;\n  gl_TessLevelOuter[0] = 1;\n  gl_TessLevelOuter[1] = 1;\n  gl_TessLevelOuter[2] = 1;\n  gl_TessLevelOuter[3] = 1;\n"
    } else {
        ""
    };
    format!(
        "#version 420 core\n{head}layout({format}) readonly uniform {prefix}image2DArray g_image{stage};\nlayout(rgba32f) writeonly uniform image2D g_image{stage}_result;\nvoid main() {{\n{tess_levels}  ivec3 coord = ivec3({coord}, 0, 0);\n  {prefix}vec4 v = imageLoad(g_image{stage}, coord);\n  if (v != {prefix}vec4{expected}) imageStore(g_image{stage}_result, coord.xy, vec4(1.0, 0.0, 0.0, 1.0));\n  else imageStore(g_image{stage}_result, coord.xy, vec4(0.0, 1.0, 0.0, 1.0));\n}}"
    )
}

/// `Write<T>` of BasicAllFormatsStoreGeometryStages
fn write_stages<T: Texel>(
    gl: &glw::Functions,
    vao: GLuint,
    internalformat: GLenum,
    write_value: &[T; 4],
    expected_value: &[T; 4],
) -> bool {
    let sources: Vec<String> = (0..4)
        .map(|stage| gen_store_stage(stage, internalformat, write_value))
        .collect();
    let program = build_program_5(
        gl,
        Some(&sources[0]),
        Some(&sources[1]),
        Some(&sources[2]),
        Some(&sources[3]),
        None,
        None,
    );
    const K_SIZE: i32 = 1;
    let mut data = vec![[T::default(); 4]; (K_SIZE * K_SIZE) as usize];
    let mut texture = [0 as GLuint; 4];
    gl!(gl.gen_textures(4, texture.as_mut_ptr()));
    for name in texture {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, name));
        nearest(gl, glw::GL_TEXTURE_2D_ARRAY);
        gl!(gl.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            internalformat as GLint,
            K_SIZE,
            K_SIZE,
            1,
            0,
            T::format(),
            T::type_(),
            data.as_ptr().cast()
        ));
    }
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

    gl!(gl.use_program(program));
    for i in 0..4 {
        gl!(gl.uniform_1i(uniform_location(gl, program, &format!("g_image{i}")), i));
    }
    for (i, name) in texture.into_iter().enumerate() {
        gl!(gl.bind_image_texture(i as GLuint, name, 0, glw::TRUE, 0, glw::GL_WRITE_ONLY, internalformat));
    }

    gl!(gl.bind_vertex_array(vao));
    gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));
    gl!(gl.draw_arrays(glw::GL_PATCHES, 0, 1));
    gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3));

    for (i, name) in texture.into_iter().enumerate() {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, name));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            T::format(),
            T::type_(),
            data.as_mut_ptr().cast()
        ));
        if !T::equal(&data[0], expected_value, internalformat) {
            gl!(gl.delete_textures(4, texture.as_ptr()));
            gl!(gl.use_program(0));
            gl!(gl.delete_program(program));
            log::info!(
                "Value is: {}. Value should be: {}. Format is: {}. Stage is: {}",
                vec_to_glsl(&data[0]),
                vec_to_glsl(expected_value),
                format_enum_to_string(internalformat),
                stage_name(i as i32)
            );
            return false;
        }
    }
    gl!(gl.delete_textures(4, texture.as_ptr()));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    true
}

/// `Read<T>` of BasicAllFormatsLoadGeometryStages
fn read_stages<T: Texel>(
    context: &Context,
    vao: GLuint,
    internalformat: GLenum,
    value: &[T; 4],
    expected_value: &[T; 4],
) -> bool {
    let gl = context.gl();
    let sources: Vec<String> = (0..4)
        .map(|stage| gen_load_stage(stage, internalformat, expected_value))
        .collect();
    let program = build_program_5(
        gl,
        Some(&sources[0]),
        Some(&sources[1]),
        Some(&sources[2]),
        Some(&sources[3]),
        None,
        None,
    );
    const K_SIZE: i32 = 1;
    let data = vec![*value; (K_SIZE * K_SIZE) as usize];
    let mut texture = [0 as GLuint; 8];
    gl!(gl.gen_textures(8, texture.as_mut_ptr()));
    for name in &texture[..4] {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, *name));
        nearest(gl, glw::GL_TEXTURE_2D_ARRAY);
        gl!(gl.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            internalformat as GLint,
            K_SIZE,
            K_SIZE,
            1,
            0,
            T::format(),
            T::type_(),
            data.as_ptr().cast()
        ));
    }
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

    let zero = [0.0f32; 4];
    for name in &texture[4..] {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, *name));
        nearest(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA32F as GLint,
            K_SIZE,
            K_SIZE,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            zero.as_ptr().cast()
        ));
    }
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

    gl!(gl.use_program(program));
    for i in 0..4 {
        gl!(gl.uniform_1i(uniform_location(gl, program, &format!("g_image{i}")), i));
    }
    for i in 0..4 {
        gl!(gl.uniform_1i(uniform_location(gl, program, &format!("g_image{i}_result")), i + 4));
    }
    for i in 0..4 {
        gl!(gl.bind_image_texture(
            i as GLuint,
            texture[i],
            0,
            glw::TRUE,
            0,
            glw::GL_READ_ONLY,
            internalformat
        ));
    }
    for i in 4..8 {
        gl!(gl.bind_image_texture(
            i as GLuint,
            texture[i],
            0,
            glw::FALSE,
            0,
            glw::GL_WRITE_ONLY,
            glw::GL_RGBA32F
        ));
    }

    gl!(gl.bind_vertex_array(vao));
    gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));
    gl!(gl.draw_arrays(glw::GL_PATCHES, 0, 1));
    gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3));

    let target = context.render_target();
    let eps = [
        1.0 / (1u32 << target.red_bits) as f32,
        1.0 / (1u32 << target.green_bits) as f32,
        1.0 / (1u32 << target.blue_bits) as f32,
        1.0 / (1u32 << target.alpha_bits) as f32,
    ];
    for i in 0..4 {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture[i + 4]));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        let mut result = [0.0f32; 4];
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            result.as_mut_ptr().cast()
        ));
        if !color_equal(&result, &[0.0, 1.0, 0.0, 1.0], &eps) {
            gl!(gl.delete_textures(8, texture.as_ptr()));
            gl!(gl.use_program(0));
            gl!(gl.delete_program(program));
            log::info!(
                "Bad load value. Format is: {}. Stage is: {}",
                format_enum_to_string(internalformat),
                stage_name(i as i32)
            );
            return false;
        }
    }
    gl!(gl.delete_textures(8, texture.as_ptr()));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    true
}

/// 1.2.3 BasicAllFormatsStoreGeometryStages
#[derive(Default)]
pub(super) struct BasicAllFormatsStoreGeometryStages {
    vao: GLuint,
}

impl Subcase for BasicAllFormatsStoreGeometryStages {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().gen_vertex_arrays(1, &mut self.vao));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_geom_stages(gl, 1) {
            return Ok(NOT_SUPPORTED);
        }
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        for case in format_cases() {
            let ok = match &case {
                FormatCase::Float(format, value, expected) => {
                    write_stages::<f32>(gl, self.vao, *format, value, expected)
                }
                FormatCase::Int(format, value, expected) => write_stages::<i32>(gl, self.vao, *format, value, expected),
                FormatCase::Uint(format, value, expected) => {
                    write_stages::<u32>(gl, self.vao, *format, value, expected)
                }
            };
            if !ok {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }
}

/// 1.2.4 BasicAllFormatsLoadGeometryStages
#[derive(Default)]
pub(super) struct BasicAllFormatsLoadGeometryStages {
    vao: GLuint,
}

impl Subcase for BasicAllFormatsLoadGeometryStages {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().gen_vertex_arrays(1, &mut self.vao));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_geom_stages(gl, 2) {
            return Ok(NOT_SUPPORTED);
        }
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        for case in format_cases() {
            let ok = match &case {
                FormatCase::Float(format, value, expected) => {
                    read_stages::<f32>(context, self.vao, *format, value, expected)
                }
                FormatCase::Int(format, value, expected) => {
                    read_stages::<i32>(context, self.vao, *format, value, expected)
                }
                FormatCase::Uint(format, value, expected) => {
                    read_stages::<u32>(context, self.vao, *format, value, expected)
                }
            };
            if !ok {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }
}

/// `GenCS<T>` of BasicAllFormatsLoadStoreComputeStage
fn gen_cs<T: Texel>(internalformat: GLenum) -> String {
    let prefix = T::type_prefix();
    let format = format_enum_to_string(internalformat);
    format!(
        "#version 420 core\n#extension GL_ARB_compute_shader : require\nlayout(local_size_x = 1) in;\nlayout({format}) readonly uniform {prefix}image2D g_image_read;\nlayout({format}) writeonly uniform {prefix}image2D g_image_write;\nvoid main() {{\n  ivec2 coord = ivec2(int(gl_GlobalInvocationID.x), 0);\n  {prefix}vec4 v = imageLoad(g_image_read, coord);\n  imageStore(g_image_write, coord, v);\n}}"
    )
}

/// `Read<T>` of BasicAllFormatsLoadStoreComputeStage
fn read_compute<T: Texel>(
    gl: &glw::Functions,
    internalformat: GLenum,
    value: &[T; 4],
    expected_value: &[T; 4],
) -> bool {
    let source = std::ffi::CString::new(gen_cs::<T>(internalformat)).expect("shader sources hold no NUL");
    let pointer = source.as_ptr();
    let shader = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
    gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
    gl!(gl.compile_shader(shader));
    let program = gl!(gl.create_program());
    gl!(gl.attach_shader(program, shader));
    gl!(gl.link_program(program));
    gl!(gl.delete_shader(shader));

    const K_SIZE: i32 = 1;
    let mut data = vec![*value; (K_SIZE * K_SIZE) as usize];
    let mut texture = [0 as GLuint; 2];
    gl!(gl.gen_textures(2, texture.as_mut_ptr()));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture[0]));
    nearest(gl, glw::GL_TEXTURE_2D);
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        internalformat as GLint,
        K_SIZE,
        K_SIZE,
        0,
        T::format(),
        T::type_(),
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture[1]));
    nearest(gl, glw::GL_TEXTURE_2D);
    let zero = [0.0f32; 4];
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        internalformat as GLint,
        K_SIZE,
        K_SIZE,
        0,
        T::format(),
        T::type_(),
        zero.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

    gl!(gl.use_program(program));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_read"), 0));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_write"), 1));
    gl!(gl.bind_image_texture(0, texture[0], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));
    gl!(gl.bind_image_texture(1, texture[1], 0, glw::TRUE, 0, glw::GL_WRITE_ONLY, internalformat));
    gl!(gl.dispatch_compute(1, 1, 1));

    for name in texture {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, name));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        gl!(gl.get_tex_image(glw::GL_TEXTURE_2D, 0, T::format(), T::type_(), data.as_mut_ptr().cast()));
        if !T::equal(&data[0], expected_value, internalformat) {
            gl!(gl.delete_textures(2, texture.as_ptr()));
            gl!(gl.use_program(0));
            gl!(gl.delete_program(program));
            log::info!(
                "Value is: {}. Value should be: {}. Format is: {}",
                vec_to_glsl(&data[0]),
                vec_to_glsl(expected_value),
                format_enum_to_string(internalformat)
            );
            return false;
        }
    }
    gl!(gl.delete_textures(2, texture.as_ptr()));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    true
}

/// 1.2.5 BasicAllFormatsLoadStoreComputeStage
#[derive(Default)]
pub(super) struct BasicAllFormatsLoadStoreComputeStage;

impl Subcase for BasicAllFormatsLoadStoreComputeStage {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !context.context_info.is_extension_supported("GL_ARB_compute_shader") {
            log::info!("GL_ARB_compute_shader not supported, skipping test");
            return Ok(NOT_SUPPORTED);
        }
        for case in format_cases() {
            let ok = match &case {
                FormatCase::Float(format, value, expected) => read_compute::<f32>(gl, *format, value, expected),
                FormatCase::Int(format, value, expected) => read_compute::<i32>(gl, *format, value, expected),
                FormatCase::Uint(format, value, expected) => read_compute::<u32>(gl, *format, value, expected),
            };
            if !ok {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}
