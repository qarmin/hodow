// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ShaderImageLoadStoreBase` is this module's free functions (each takes the `Context` or `glw::Functions` the C++ class reaches through `m_context`); `Format<T>`/`Type<T>`/`TypePrefix<T>`/`ImageType<T>` are the `Texel` trait; log messages go through `log::info!`. Written without compiling.

#![allow(dead_code)]

use std::ffi::CString;

use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::output_not_supported;

pub(super) type Vec4 = [f32; 4];
pub(super) type IVec4 = [i32; 4];
pub(super) type UVec4 = [u32; 4];

fn images_in(gl: &glw::Functions, pname: GLenum, required: i32, stage: &str) -> bool {
    let images = get_integer(gl, pname);
    if images >= required {
        return true;
    }
    output_not_supported(&format!(
        "Required {required} {stage} image uniforms but only {images} available.\n"
    ));
    false
}

/// `SupportedInVS`
pub(super) fn supported_in_vs(gl: &glw::Functions, required: i32) -> bool {
    images_in(gl, glw::GL_MAX_VERTEX_IMAGE_UNIFORMS, required, "VS")
}

/// `SupportedInTCS`
pub(super) fn supported_in_tcs(gl: &glw::Functions, required: i32) -> bool {
    images_in(gl, glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS, required, "TCS")
}

/// `SupportedInTES`
pub(super) fn supported_in_tes(gl: &glw::Functions, required: i32) -> bool {
    images_in(gl, glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS, required, "TES")
}

/// `SupportedInGS`
pub(super) fn supported_in_gs(gl: &glw::Functions, required: i32) -> bool {
    images_in(gl, glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS, required, "GS")
}

/// `SupportedInGeomStages`
pub(super) fn supported_in_geom_stages(gl: &glw::Functions, required: i32) -> bool {
    supported_in_vs(gl, required)
        && supported_in_tcs(gl, required)
        && supported_in_tes(gl, required)
        && supported_in_gs(gl, required)
}

/// `SupportedInStage`
pub(super) fn supported_in_stage(gl: &glw::Functions, stage: i32, required: i32) -> bool {
    match stage {
        0 => supported_in_vs(gl, required),
        1 => supported_in_tcs(gl, required),
        2 => supported_in_tes(gl, required),
        3 => supported_in_gs(gl, required),
        _ => true,
    }
}

/// `SupportedSamples`
pub(super) fn supported_samples(gl: &glw::Functions, required: i32) -> bool {
    let samples = get_integer(gl, glw::GL_MAX_IMAGE_SAMPLES);
    if samples >= required {
        return true;
    }
    output_not_supported(&format!(
        "Required {required} image samples but only {samples} available.\n"
    ));
    false
}

pub(super) fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_integerv(pname, &mut value));
    value
}

/// `getWindowWidth()`, `getWindowHeight()`
pub(super) fn window_size(context: &Context) -> (GLint, GLint) {
    let target = context.render_target();
    (target.width, target.height)
}

/// `scaleDimensionsToMemory` with `tcu::Platform::getMemoryLimits`' defaults (256 MiB system, 128 MiB device local memory), which is what the Linux platforms use.
pub(super) fn scale_dimensions_to_memory(
    (width, height): (GLint, GLint),
    dev_layers: i64,
    sys_layers: i64,
    dev_bpp: i64,
    sys_bpp: i64,
) -> (GLint, GLint) {
    let sys_space: i64 = 256 * 1024 * 1024;
    let dev_space: i64 = 128 * 1024 * 1024;

    let pixels_per_layer = i64::from(width) * i64::from(height);
    let sys_required = pixels_per_layer * sys_bpp * sys_layers;
    let dev_required = pixels_per_layer * dev_bpp * dev_layers;
    if sys_required <= sys_space && dev_required <= dev_space {
        return (width, height);
    }

    let scale = (sys_space as f64 / sys_required as f64)
        .sqrt()
        .min((dev_space as f64 / dev_required as f64).sqrt());
    let new_width = (f64::from(width) * scale) as GLint;
    let new_height = (f64::from(height) * scale) as GLint;
    log::info!("Reducing surface dimensions to fit in memory, from {width}x{height} to {new_width}x{new_height}.");
    (new_width, new_height)
}

/// `glViewport(0, 0, getWindowWidth(), getWindowHeight())`
pub(super) fn restore_viewport(context: &Context) {
    let (width, height) = window_size(context);
    gl!(context.gl().viewport(0, 0, width, height));
}

/// `ColorEqual`
pub(super) fn color_equal(c0: &Vec4, c1: &Vec4, epsilon: &Vec4) -> bool {
    (0..4).all(|i| (c0[i] - c1[i]).abs() <= epsilon[i])
}

/// `IsEqual(vec4, vec4)`
pub(super) fn is_equal(a: &Vec4, b: &Vec4) -> bool {
    a == b
}

fn to_string<T: std::fmt::Display>(v: &[T; 4]) -> String {
    format!("[{},{},{},{}]", v[0], v[1], v[2], v[3])
}

/// `ValidateReadBuffer`: reports the first bad colour only.
pub(super) fn validate_read_buffer(context: &Context, x: i32, y: i32, w: i32, h: i32, expected: &Vec4) -> bool {
    let gl = context.gl();
    let target = context.render_target();
    let eps = [
        1.0 / (1u32 << target.red_bits) as f32,
        1.0 / (1u32 << target.green_bits) as f32,
        1.0 / (1u32 << target.blue_bits) as f32,
        1.0 / (1u32 << target.alpha_bits) as f32,
    ];

    let mut fb = vec![[0.0f32; 4]; (w * h) as usize];
    gl!(gl.read_pixels(x, y, w, h, glw::GL_RGBA, glw::GL_FLOAT, fb.as_mut_ptr().cast()));

    for pixel in &fb {
        if !color_equal(pixel, expected, &eps) {
            log::info!("First bad color: {}", to_string(pixel));
            return false;
        }
    }
    true
}

/// `ValidateReadBuffer(0, 0, getWindowWidth(), getWindowHeight(), expected)`
pub(super) fn validate_window(context: &Context, expected: &Vec4) -> bool {
    let (width, height) = window_size(context);
    validate_read_buffer(context, 0, 0, width, height, expected)
}

fn shader_source(gl: &glw::Functions, shader: GLuint, source: &str) {
    let source = CString::new(source).expect("shader sources hold no NUL");
    let pointer = source.as_ptr();
    gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
}

/// `CompileShader`
pub(super) fn compile_shader(gl: &glw::Functions, shader: GLuint) -> bool {
    gl!(gl.compile_shader(shader));
    let mut status: GLint = 0;
    gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
    if status == glw::GL_FALSE as GLint {
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

/// `LinkProgram`
pub(super) fn link_program(gl: &glw::Functions, program: GLuint) -> bool {
    gl!(gl.link_program(program));
    let mut status: GLint = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    if status == glw::GL_FALSE as GLint {
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

/// `BuildProgram(vs, tcs, tes, gs, fs, &result)`: each stage is a complete source (with its own `#version`); `result` is set to false on a compile or link failure and the program is returned as it is.
pub(super) fn build_program_5(
    gl: &glw::Functions,
    src_vs: Option<&str>,
    src_tcs: Option<&str>,
    src_tes: Option<&str>,
    src_gs: Option<&str>,
    src_fs: Option<&str>,
    result: Option<&mut bool>,
) -> GLuint {
    let program = gl!(gl.create_program());
    let stages = [
        (glw::GL_VERTEX_SHADER, src_vs),
        (glw::GL_TESS_CONTROL_SHADER, src_tcs),
        (glw::GL_TESS_EVALUATION_SHADER, src_tes),
        (glw::GL_GEOMETRY_SHADER, src_gs),
        (glw::GL_FRAGMENT_SHADER, src_fs),
    ];
    let mut failed = false;
    'build: {
        for (shader_type, source) in stages {
            let Some(source) = source else { continue };
            let shader = gl!(gl.create_shader(shader_type));
            gl!(gl.attach_shader(program, shader));
            gl!(gl.delete_shader(shader));
            shader_source(gl, shader, source);
            if !compile_shader(gl, shader) {
                log::info!("{source}");
                failed = true;
                break 'build;
            }
        }
        if !link_program(gl, program) {
            for (_, source) in stages {
                if let Some(source) = source {
                    log::info!("{source}");
                }
            }
            failed = true;
        }
    }
    if failed && let Some(result) = result {
        *result = false;
    }
    program
}

/// `BuildProgram(vs, NULL, NULL, NULL, fs)`
pub(super) fn build_program(gl: &glw::Functions, src_vs: Option<&str>, src_fs: Option<&str>) -> GLuint {
    build_program_5(gl, src_vs, None, None, None, src_fs, None)
}

/// `BuildShaderProgram`
pub(super) fn build_shader_program(gl: &glw::Functions, shader_type: GLenum, src: &str) -> GLuint {
    let source = CString::new(src).expect("shader sources hold no NUL");
    let pointer = source.as_ptr();
    let program = gl!(gl.create_shader_programv(shader_type, 1, &pointer));
    let mut status: GLint = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    if status == glw::GL_FALSE as GLint {
        let mut log = [0u8; 1024];
        gl!(gl.get_program_info_log(
            program,
            log.len() as glw::GLsizei,
            std::ptr::null_mut(),
            log.as_mut_ptr().cast()
        ));
        let end = log.iter().position(|&byte| byte == 0).unwrap_or(log.len());
        log::info!("Program Info Log:\n{}\n{src}", String::from_utf8_lossy(&log[..end]));
    }
    program
}

/// `CreateFullViewportQuad`: interleaved (vertex, color0 (green), color1 (blue), color2 (red)); `ebo` is created when asked for.
pub(super) fn create_full_viewport_quad(
    gl: &glw::Functions,
    vao: &mut GLuint,
    vbo: &mut GLuint,
    ebo: Option<&mut GLuint>,
) {
    let v: [f32; 44] = [
        -1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0,
        0.0, -1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0,
        0.0,
    ];
    gl!(gl.gen_buffers(1, vbo));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vbo));
    gl!(gl.buffer_data(
        glw::GL_ARRAY_BUFFER,
        std::mem::size_of_val(&v) as isize,
        v.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    let has_ebo = ebo.is_some();
    let mut ebo_name = 0;
    if let Some(ebo) = ebo {
        let index_data: [u16; 4] = [0, 1, 2, 3];
        gl!(gl.gen_buffers(1, ebo));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, *ebo));
        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            2 * 4,
            index_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
        ebo_name = *ebo;
    }

    gl!(gl.gen_vertex_arrays(1, vao));
    gl!(gl.bind_vertex_array(*vao));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vbo));
    gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 4 * 11, std::ptr::null()));
    gl!(gl.vertex_attrib_pointer(
        1,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        4 * 11,
        (4 * 2) as *const std::ffi::c_void
    ));
    gl!(gl.vertex_attrib_pointer(
        2,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        4 * 11,
        (4 * 5) as *const std::ffi::c_void
    ));
    gl!(gl.vertex_attrib_pointer(
        3,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        4 * 11,
        (4 * 8) as *const std::ffi::c_void
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    for index in 0..4 {
        gl!(gl.enable_vertex_attrib_array(index));
    }
    if has_ebo {
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo_name));
    }
    gl!(gl.bind_vertex_array(0));
}

/// `FormatEnumToString`
pub(super) fn format_enum_to_string(e: GLenum) -> &'static str {
    match e {
        glw::GL_RGBA32F => "rgba32f",
        glw::GL_RGBA16F => "rgba16f",
        glw::GL_RG32F => "rg32f",
        glw::GL_RG16F => "rg16f",
        glw::GL_R11F_G11F_B10F => "r11f_g11f_b10f",
        glw::GL_R32F => "r32f",
        glw::GL_R16F => "r16f",

        glw::GL_RGBA32UI => "rgba32ui",
        glw::GL_RGBA16UI => "rgba16ui",
        glw::GL_RGB10_A2UI => "rgb10_a2ui",
        glw::GL_RGBA8UI => "rgba8ui",
        glw::GL_RG32UI => "rg32ui",
        glw::GL_RG16UI => "rg16ui",
        glw::GL_RG8UI => "rg8ui",
        glw::GL_R32UI => "r32ui",
        glw::GL_R16UI => "r16ui",
        glw::GL_R8UI => "r8ui",

        glw::GL_RGBA32I => "rgba32i",
        glw::GL_RGBA16I => "rgba16i",
        glw::GL_RGBA8I => "rgba8i",
        glw::GL_RG32I => "rg32i",
        glw::GL_RG16I => "rg16i",
        glw::GL_RG8I => "rg8i",
        glw::GL_R32I => "r32i",
        glw::GL_R16I => "r16i",
        glw::GL_R8I => "r8i",

        glw::GL_RGBA16 => "rgba16",
        glw::GL_RGB10_A2 => "rgb10_a2",
        glw::GL_RGBA8 => "rgba8",
        glw::GL_RG16 => "rg16",
        glw::GL_RG8 => "rg8",
        glw::GL_R16 => "r16",
        glw::GL_R8 => "r8",

        glw::GL_RGBA16_SNORM => "rgba16_snorm",
        glw::GL_RGBA8_SNORM => "rgba8_snorm",
        glw::GL_RG16_SNORM => "rg16_snorm",
        glw::GL_RG8_SNORM => "rg8_snorm",
        glw::GL_R16_SNORM => "r16_snorm",
        glw::GL_R8_SNORM => "r8_snorm",
        _ => "",
    }
}

/// `StageName`
pub(super) fn stage_name(stage: i32) -> &'static str {
    match stage {
        0 => "Vertex Shader",
        1 => "Tessellation Control Shader",
        2 => "Tessellation Evaluation Shader",
        3 => "Geometry Shader",
        4 => "Compute Shader",
        _ => "",
    }
}

/// `EnumToString`
pub(super) fn enum_to_string(e: GLenum) -> &'static str {
    match e {
        glw::GL_TEXTURE_1D => "GL_TEXTURE_1D",
        glw::GL_TEXTURE_2D => "GL_TEXTURE_2D",
        glw::GL_TEXTURE_3D => "GL_TEXTURE_3D",
        glw::GL_TEXTURE_RECTANGLE => "GL_TEXTURE_RECTANGLE",
        glw::GL_TEXTURE_CUBE_MAP => "GL_TEXTURE_CUBE_MAP",
        glw::GL_TEXTURE_1D_ARRAY => "GL_TEXTURE_1D_ARRAY",
        glw::GL_TEXTURE_2D_ARRAY => "GL_TEXTURE_2D_ARRAY",
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => "GL_TEXTURE_CUBE_MAP_ARRAY",
        _ => "",
    }
}

/// `CheckUniform`: `index` is the uniform's index in the program.
pub(super) fn check_uniform(
    gl: &glw::Functions,
    program: GLuint,
    name: &str,
    index: GLuint,
    size: GLint,
    type_: GLenum,
) -> bool {
    let mut name_gl = [0u8; 32];
    let mut length_gl: glw::GLsizei = 0;
    let mut size_gl: GLint = 0;
    let mut type_gl: GLenum = 0;
    gl!(gl.get_active_uniform(
        program,
        index,
        name_gl.len() as glw::GLsizei,
        &mut length_gl,
        &mut size_gl,
        &mut type_gl,
        name_gl.as_mut_ptr().cast()
    ));
    let end = name_gl.iter().position(|&byte| byte == 0).unwrap_or(name_gl.len());
    let name_gl = String::from_utf8_lossy(&name_gl[..end]).into_owned();

    if name_gl != name {
        log::info!("Uniform name is {name_gl} should be {name}");
        return false;
    }
    if length_gl != name.len() as glw::GLsizei {
        log::info!("Uniform length is {length_gl} should be {name}({name_gl})");
        return false;
    }
    if size_gl != size {
        log::info!("Uniform size is {size_gl} should be {size}({name_gl})");
        return false;
    }
    if type_gl != type_ {
        log::info!("Uniform type is {type_gl} should be {type_}({name_gl})");
        return false;
    }
    true
}

/// `CheckMax`
pub(super) fn check_max(gl: &glw::Functions, pname: GLenum, min_value: GLint) -> bool {
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
    if (f as GLint) < min_value {
        return false;
    }
    let mut d: glw::GLdouble = 0.0;
    gl!(gl.get_doublev(pname, &mut d));
    if (d as GLint) < min_value {
        return false;
    }
    let mut i64_value: glw::GLint64 = 0;
    gl!(gl.get_integer_64v(pname, &mut i64_value));
    (i64_value as GLint) >= min_value
}

/// `CheckBinding`
pub(super) fn check_binding(
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
    let mut b: glw::GLboolean = 0;
    let expected_bool = |value: GLint| if value != 0 { glw::TRUE } else { glw::FALSE };

    // (pname, name, expected value)
    let checks: [(GLenum, &str, GLint); 6] = [
        (glw::GL_IMAGE_BINDING_NAME, "GL_IMAGE_BINDING_NAME", texture as GLint),
        (glw::GL_IMAGE_BINDING_LEVEL, "GL_IMAGE_BINDING_LEVEL", level),
        (
            glw::GL_IMAGE_BINDING_LAYERED,
            "GL_IMAGE_BINDING_LAYERED",
            layered as GLint,
        ),
        (glw::GL_IMAGE_BINDING_LAYER, "GL_IMAGE_BINDING_LAYER", layer),
        (glw::GL_IMAGE_BINDING_ACCESS, "GL_IMAGE_BINDING_ACCESS", access as GLint),
        (glw::GL_IMAGE_BINDING_FORMAT, "GL_IMAGE_BINDING_FORMAT", format as GLint),
    ];
    for (pname, name, expected) in checks {
        gl!(gl.get_integeri_v(pname, unit, &mut i));
        if i != expected {
            log::info!("{name} is {i} should be {expected}");
            return false;
        }
        gl!(gl.get_booleani_v(pname, unit, &mut b));
        if b != expected_bool(i) {
            log::info!("{name} (as boolean) is {b} should be {}", expected_bool(i));
            return false;
        }
    }
    true
}

/// The three texel types the typed cases are instantiated with (`vec4`, `ivec4`, `uvec4`): `Format<T>`, `Type<T>`, `TypePrefix<T>`, `ImageType<T>`, `ClearBuffer` and the formats' `Equal`.
pub(super) trait Texel: Copy + Default + PartialEq + std::fmt::Display {
    fn format() -> GLenum;
    fn type_() -> GLenum;
    fn type_prefix() -> &'static str;
    fn image_type(target: GLenum) -> GLenum;
    fn clear_buffer(gl: &glw::Functions, buffer: GLenum, drawbuffer: GLint, color: &[Self; 4]);
    fn equal(a: &[Self; 4], b: &[Self; 4], internalformat: GLenum) -> bool;
}

/// `ImageType<T>`: the row of the image sampler type table for `target`.
fn image_type_of(target: GLenum, row: [GLenum; 11]) -> GLenum {
    let index = match target {
        glw::GL_TEXTURE_1D => 0,
        glw::GL_TEXTURE_2D => 1,
        glw::GL_TEXTURE_3D => 2,
        glw::GL_TEXTURE_RECTANGLE => 3,
        glw::GL_TEXTURE_CUBE_MAP => 4,
        glw::GL_TEXTURE_BUFFER => 5,
        glw::GL_TEXTURE_1D_ARRAY => 6,
        glw::GL_TEXTURE_2D_ARRAY => 7,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => 8,
        glw::GL_TEXTURE_2D_MULTISAMPLE => 9,
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => 10,
        _ => return 0,
    };
    row[index]
}

impl Texel for f32 {
    fn format() -> GLenum {
        glw::GL_RGBA
    }
    fn type_() -> GLenum {
        glw::GL_FLOAT
    }
    fn type_prefix() -> &'static str {
        ""
    }
    fn image_type(target: GLenum) -> GLenum {
        image_type_of(
            target,
            [
                glw::GL_IMAGE_1D,
                glw::GL_IMAGE_2D,
                glw::GL_IMAGE_3D,
                glw::GL_IMAGE_2D_RECT,
                glw::GL_IMAGE_CUBE,
                glw::GL_IMAGE_BUFFER,
                glw::GL_IMAGE_1D_ARRAY,
                glw::GL_IMAGE_2D_ARRAY,
                glw::GL_IMAGE_CUBE_MAP_ARRAY,
                glw::GL_IMAGE_2D_MULTISAMPLE,
                glw::GL_IMAGE_2D_MULTISAMPLE_ARRAY,
            ],
        )
    }
    fn clear_buffer(gl: &glw::Functions, buffer: GLenum, drawbuffer: GLint, color: &[Self; 4]) {
        gl!(gl.clear_bufferfv(buffer, drawbuffer, color.as_ptr()));
    }
    fn equal(a: &[Self; 4], b: &[Self; 4], internalformat: GLenum) -> bool {
        if matches!(
            internalformat,
            glw::GL_RGBA16_SNORM | glw::GL_RG16_SNORM | glw::GL_R16_SNORM
        ) {
            return color_equal(a, b, &[0.0001; 4]);
        }
        if matches!(
            internalformat,
            glw::GL_RGBA8_SNORM | glw::GL_RG8_SNORM | glw::GL_R8_SNORM
        ) {
            return color_equal(a, b, &[0.01; 4]);
        }
        a == b
    }
}

impl Texel for i32 {
    fn format() -> GLenum {
        glw::GL_RGBA_INTEGER
    }
    fn type_() -> GLenum {
        glw::GL_INT
    }
    fn type_prefix() -> &'static str {
        "i"
    }
    fn image_type(target: GLenum) -> GLenum {
        image_type_of(
            target,
            [
                glw::GL_INT_IMAGE_1D,
                glw::GL_INT_IMAGE_2D,
                glw::GL_INT_IMAGE_3D,
                glw::GL_INT_IMAGE_2D_RECT,
                glw::GL_INT_IMAGE_CUBE,
                glw::GL_INT_IMAGE_BUFFER,
                glw::GL_INT_IMAGE_1D_ARRAY,
                glw::GL_INT_IMAGE_2D_ARRAY,
                glw::GL_INT_IMAGE_CUBE_MAP_ARRAY,
                glw::GL_INT_IMAGE_2D_MULTISAMPLE,
                glw::GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY,
            ],
        )
    }
    fn clear_buffer(gl: &glw::Functions, buffer: GLenum, drawbuffer: GLint, color: &[Self; 4]) {
        gl!(gl.clear_bufferiv(buffer, drawbuffer, color.as_ptr()));
    }
    fn equal(a: &[Self; 4], b: &[Self; 4], _internalformat: GLenum) -> bool {
        a == b
    }
}

impl Texel for u32 {
    fn format() -> GLenum {
        glw::GL_RGBA_INTEGER
    }
    fn type_() -> GLenum {
        glw::GL_UNSIGNED_INT
    }
    fn type_prefix() -> &'static str {
        "u"
    }
    fn image_type(target: GLenum) -> GLenum {
        image_type_of(
            target,
            [
                glw::GL_UNSIGNED_INT_IMAGE_1D,
                glw::GL_UNSIGNED_INT_IMAGE_2D,
                glw::GL_UNSIGNED_INT_IMAGE_3D,
                glw::GL_UNSIGNED_INT_IMAGE_2D_RECT,
                glw::GL_UNSIGNED_INT_IMAGE_CUBE,
                glw::GL_UNSIGNED_INT_IMAGE_BUFFER,
                glw::GL_UNSIGNED_INT_IMAGE_1D_ARRAY,
                glw::GL_UNSIGNED_INT_IMAGE_2D_ARRAY,
                glw::GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY,
                glw::GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE,
                glw::GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY,
            ],
        )
    }
    fn clear_buffer(gl: &glw::Functions, buffer: GLenum, drawbuffer: GLint, color: &[Self; 4]) {
        gl!(gl.clear_bufferuiv(buffer, drawbuffer, color.as_ptr()));
    }
    fn equal(a: &[Self; 4], b: &[Self; 4], _internalformat: GLenum) -> bool {
        a == b
    }
}

/// `glGetUniformLocation` by name.
pub(super) fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("uniform names hold no NUL");
    gl!(gl.get_uniform_location(program, name.as_ptr()))
}
