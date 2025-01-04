// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageSizeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case classes (`BasicNonMS`, `BasicMS`, `AdvancedChangeSize`, `AdvancedNonMS`, `AdvancedMS`, `NegativeCompileTime`) are `Subcase`s (see `subcase.rs`); the `<T, STAGE>` template parameters are the `ElemKind` and stage fields. `ImageSizeMachine`'s `GenShader<T>` builds the same GLSL; the shader log dump of `CheckProgram` is a plain log of each attached shader's source and info log.

use super::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult, TestSubcase, output_not_supported};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

type IVec4 = [i32; 4];

/// `vec4`, `ivec4` and `uvec4` as the template argument of the upstream classes.
#[derive(Clone, Copy)]
enum ElemKind {
    Vec4,
    IVec4,
    UVec4,
}

impl ElemKind {
    fn image_type_prefix(self) -> &'static str {
        match self {
            Self::Vec4 => "",
            Self::IVec4 => "i",
            Self::UVec4 => "u",
        }
    }

    fn image_format_postfix(self) -> &'static str {
        match self {
            Self::Vec4 => "f",
            Self::IVec4 => "i",
            Self::UVec4 => "ui",
        }
    }

    fn tex_internal_format(self) -> GLenum {
        match self {
            Self::Vec4 => glw::GL_RGBA32F,
            Self::IVec4 => glw::GL_RGBA32I,
            Self::UVec4 => glw::GL_RGBA32UI,
        }
    }

    fn tex_type(self) -> GLenum {
        match self {
            Self::Vec4 => glw::GL_FLOAT,
            Self::IVec4 => glw::GL_INT,
            Self::UVec4 => glw::GL_UNSIGNED_INT,
        }
    }

    fn tex_format(self) -> GLenum {
        match self {
            Self::Vec4 => glw::GL_RGBA,
            Self::IVec4 | Self::UVec4 => glw::GL_RGBA_INTEGER,
        }
    }
}

fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_integerv(pname, &mut value));
    value
}

fn supported_in_stage(gl: &glw::Functions, stage: i32, required: i32) -> bool {
    let (name, pname) = match stage {
        0 => ("VS", glw::GL_MAX_VERTEX_IMAGE_UNIFORMS),
        1 => ("TCS", glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS),
        2 => ("TES", glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS),
        3 => ("GS", glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS),
        _ => return true,
    };
    let images = get_integer(gl, pname);
    if images >= required {
        return true;
    }
    output_not_supported(&format!(
        "Required {required} {name} image uniforms but only {images} available."
    ));
    false
}

fn supported_samples(gl: &glw::Functions, required: i32) -> bool {
    let samples = get_integer(gl, glw::GL_MAX_IMAGE_SAMPLES);
    if samples >= required {
        return true;
    }
    output_not_supported(&format!(
        "Required {required} image samples but only {samples} available."
    ));
    false
}

/// `ValidateReadBuffer`
fn validate_read_buffer(context: &Context, x: i32, y: i32, w: i32, h: i32, expected: [f32; 4]) -> bool {
    let gl = context.gl();
    let render_target = context.render_target();
    let eps = [
        1.0 / (1u32 << render_target.red_bits) as f32,
        1.0 / (1u32 << render_target.green_bits) as f32,
        1.0 / (1u32 << render_target.blue_bits) as f32,
        1.0 / (1u32 << render_target.alpha_bits) as f32,
    ];
    let mut fb = vec![[0.0f32; 4]; (w * h) as usize];
    gl!(gl.read_pixels(x, y, w, h, glw::GL_RGBA, glw::GL_FLOAT, fb.as_mut_ptr().cast()));
    for yy in 0..h {
        for xx in 0..w {
            let color = fb[(yy * w + xx) as usize];
            if (0..4).any(|c| (color[c] - expected[c]).abs() > eps[c]) {
                log::info!("First bad color: [{},{},{},{}]", color[0], color[1], color[2], color[3]);
                return false;
            }
        }
    }
    true
}

/// `CheckProgram`
fn check_program(gl: &glw::Functions, program: GLuint) -> bool {
    if program == 0 {
        return true;
    }

    let mut status = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    if status == glw::GL_FALSE as GLint {
        let attached_shaders = get_program_value(gl, program, glw::GL_ATTACHED_SHADERS);
        if attached_shaders > 0 {
            let mut shaders = vec![0 as GLuint; attached_shaders as usize];
            gl!(gl.get_attached_shaders(program, attached_shaders, std::ptr::null_mut(), shaders.as_mut_ptr()));
            for &shader in &shaders {
                let mut shader_type: GLint = 0;
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

                let mut length: GLint = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, &mut length));
                if length > 0 {
                    let mut source = vec![0u8; length as usize];
                    gl!(gl.get_shader_source(shader, length, std::ptr::null_mut(), source.as_mut_ptr().cast()));
                    log::info!("{}", String::from_utf8_lossy(&source));
                }
                gl!(gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length));
                if length > 0 {
                    let mut info_log = vec![0u8; length as usize];
                    gl!(gl.get_shader_info_log(shader, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
                    log::info!("{}", String::from_utf8_lossy(&info_log));
                }
            }
        }

        let length = get_program_value(gl, program, glw::GL_INFO_LOG_LENGTH);
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            log::info!("{}", String::from_utf8_lossy(&info_log));
        }
    }
    status == glw::GL_TRUE as GLint
}

fn get_program_value(gl: &glw::Functions, program: GLuint, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_programiv(program, pname, &mut value));
    value
}

const NON_MS_DECLARATIONS: [(i32, &str, &str); 7] = [
    (1, "image2D", "g_image_2d"),
    (2, "image3D", "g_image_3d"),
    (3, "image2D", "g_image_cube"),
    (4, "imageCubeArray", "g_image_cube_array"),
    (5, "image2DRect", "g_image_rect"),
    (6, "image2DArray", "g_image_2d_array"),
    (7, "imageBuffer", "g_image_buffer"),
];

const MS_DECLARATIONS: [(i32, &str, &str); 4] = [
    (1, "image1D", "g_image_1d"),
    (2, "image1DArray", "g_image_1d_array"),
    (3, "image2DMS", "g_image_2dms"),
    (4, "image2DMSArray", "g_image_2dms_array"),
];

/// `ImageSizeMachine::GenShader<T>`
fn gen_shader(kind: ElemKind, stage: i32, ms_and_1d: bool, subroutine: bool) -> String {
    let (prefix, postfix) = (kind.image_type_prefix(), kind.image_format_postfix());
    let mut os = String::from("#version 430 core");
    if stage == 4 {
        // CS
        os.push_str("\n#extension GL_ARB_compute_shader : require");
    }
    os.push_str("\nlayout(binding = 0, rgba32i) writeonly uniform iimage2D g_result;");
    let declarations: &[(i32, &str, &str)] = if ms_and_1d {
        &MS_DECLARATIONS
    } else {
        &NON_MS_DECLARATIONS
    };
    for (binding, image_type, name) in declarations {
        os.push_str(&format!(
            "\nlayout(binding = {binding}, rgba32{postfix}) uniform {prefix}{image_type} {name};"
        ));
    }
    if subroutine {
        os.push_str("\nsubroutine void FuncType(int coord);\nsubroutine uniform FuncType g_func;");
    }
    match stage {
        0 => os.push_str("\nvoid main() {\n  int coord = gl_VertexID;"),
        1 => os.push_str("\nlayout(vertices = 1) out;\nvoid main() {\n  gl_TessLevelInner[0] = 1;\n  gl_TessLevelInner[1] = 1;\n  gl_TessLevelOuter[0] = 1;\n  gl_TessLevelOuter[1] = 1;\n  gl_TessLevelOuter[2] = 1;\n  gl_TessLevelOuter[3] = 1;\n  int coord = gl_PrimitiveID;"),
        2 => os.push_str("\nlayout(quads, point_mode) in;\nvoid main() {\n  int coord = gl_PrimitiveID;"),
        3 => os.push_str("\nlayout(points) in;\nlayout(points, max_vertices = 1) out;\nvoid main() {\n  int coord = gl_PrimitiveIDIn;"),
        4 => os.push_str("\nlayout(local_size_x = 1) in;\nvoid main() {\n  int coord = int(gl_GlobalInvocationID.x);"),
        5 => os.push_str("\nvoid main() {\n  int coord = gl_PrimitiveID;"),
        _ => {}
    }
    if subroutine {
        os.push_str("\n  g_func(coord);\n}\nsubroutine(FuncType) void Func0(int coord) {");
    }
    if !ms_and_1d {
        os.push_str("\n  imageStore(g_result, ivec2(coord, 0), ivec4(imageSize(g_image_2d), 0, 0));\n  imageStore(g_result, ivec2(coord, 1), ivec4(imageSize(g_image_3d), 0));\n  imageStore(g_result, ivec2(coord, 2), ivec4(imageSize(g_image_cube), 0, 0));\n  imageStore(g_result, ivec2(coord, 3), ivec4(imageSize(g_image_cube_array), 0));\n  imageStore(g_result, ivec2(coord, 4), ivec4(imageSize(g_image_rect), 0, 0));\n  imageStore(g_result, ivec2(coord, 5), ivec4(imageSize(g_image_2d_array), 0));\n  imageStore(g_result, ivec2(coord, 6), ivec4(imageSize(g_image_buffer), 0, 0, 0));\n}");
    } else {
        os.push_str("\n  imageStore(g_result, ivec2(coord, 0), ivec4(imageSize(g_image_1d), 0, 0, 0));\n  imageStore(g_result, ivec2(coord, 1), ivec4(imageSize(g_image_1d_array), 0, 0));\n  imageStore(g_result, ivec2(coord, 2), ivec4(imageSize(g_image_2dms), 0, 0));\n  imageStore(g_result, ivec2(coord, 3), ivec4(imageSize(g_image_2dms_array), 0));\n  imageStore(g_result, ivec2(coord, 4), ivec4(0));\n  imageStore(g_result, ivec2(coord, 5), ivec4(0));\n  imageStore(g_result, ivec2(coord, 6), ivec4(0));\n}");
    }
    os
}

const PASSTHROUGH_VS: &str = "#version 430 core\nout gl_PerVertex { vec4 gl_Position; };\nvoid main() { gl_Position = vec4(0.0, 0.0, 0.0, 1.0);}";
const EMPTY_TES: &str = "#version 430 core\nlayout(quads, point_mode) in;\nvoid main() {}";

fn create_shader_program(gl: &glw::Functions, shader_type: GLenum, source: &str) -> GLuint {
    let source = std::ffi::CString::new(source).expect("shader source holds no nul byte");
    let pointer = source.as_ptr();
    gl!(gl.create_shader_programv(shader_type, 1, &pointer))
}

/// `ImageSizeMachine`
struct ImageSizeMachine<'a> {
    gl: &'a glw::Functions,
    pipeline: GLuint,
    program: [GLuint; 3],
    vertex_array: GLuint,
    texture: GLuint,
}

impl<'a> ImageSizeMachine<'a> {
    fn new(gl: &'a glw::Functions) -> Self {
        let mut machine = Self {
            gl,
            pipeline: 0,
            program: [0; 3],
            vertex_array: 0,
            texture: 0,
        };
        gl!(gl.gen_program_pipelines(1, &mut machine.pipeline));
        gl!(gl.gen_vertex_arrays(1, &mut machine.vertex_array));
        gl!(gl.gen_textures(1, &mut machine.texture));
        machine
    }

    fn run(
        &mut self,
        kind: ElemKind,
        stage: i32,
        ms_and_1d: bool,
        expected_result: &[IVec4; 7],
        subroutine: bool,
    ) -> SubcaseResult {
        let gl = self.gl;
        let shader = gen_shader(kind, stage, ms_and_1d, subroutine);
        match stage {
            0 => {
                self.program[0] = create_shader_program(gl, glw::GL_VERTEX_SHADER, &shader);
                gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.program[0]));
            }
            1 => {
                self.program[0] = create_shader_program(gl, glw::GL_VERTEX_SHADER, PASSTHROUGH_VS);
                self.program[1] = create_shader_program(gl, glw::GL_TESS_CONTROL_SHADER, &shader);
                self.program[2] = create_shader_program(gl, glw::GL_TESS_EVALUATION_SHADER, EMPTY_TES);
                gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.program[0]));
                gl!(gl.use_program_stages(self.pipeline, glw::GL_TESS_CONTROL_SHADER_BIT, self.program[1]));
                gl!(gl.use_program_stages(self.pipeline, glw::GL_TESS_EVALUATION_SHADER_BIT, self.program[2]));
            }
            2 => {
                self.program[0] = create_shader_program(gl, glw::GL_VERTEX_SHADER, PASSTHROUGH_VS);
                self.program[1] = create_shader_program(gl, glw::GL_TESS_EVALUATION_SHADER, &shader);
                gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.program[0]));
                gl!(gl.use_program_stages(self.pipeline, glw::GL_TESS_EVALUATION_SHADER_BIT, self.program[1]));
            }
            3 => {
                self.program[0] = create_shader_program(gl, glw::GL_VERTEX_SHADER, PASSTHROUGH_VS);
                self.program[1] = create_shader_program(gl, glw::GL_GEOMETRY_SHADER, &shader);
                gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.program[0]));
                gl!(gl.use_program_stages(self.pipeline, glw::GL_GEOMETRY_SHADER_BIT, self.program[1]));
            }
            4 => {
                self.program[0] = create_shader_program(gl, glw::GL_COMPUTE_SHADER, &shader);
                gl!(gl.use_program_stages(self.pipeline, glw::GL_COMPUTE_SHADER_BIT, self.program[0]));
            }
            5 => {
                self.program[0] = create_shader_program(gl, glw::GL_VERTEX_SHADER, PASSTHROUGH_VS);
                self.program[1] = create_shader_program(gl, glw::GL_FRAGMENT_SHADER, &shader);
                gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.program[0]));
                gl!(gl.use_program_stages(self.pipeline, glw::GL_FRAGMENT_SHADER_BIT, self.program[1]));
            }
            _ => {}
        }

        for program in self.program {
            if !check_program(gl, program) {
                return Ok(ERROR);
            }
        }

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        {
            let data = [[100000i32; 4]; 7];
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32I as GLint,
                1,
                7,
                0,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                data.as_ptr().cast()
            ));
        }
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_image_texture(0, self.texture, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA32I));

        gl!(gl.bind_program_pipeline(self.pipeline));
        gl!(gl.bind_vertex_array(self.vertex_array));
        if stage != 5 {
            gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        }
        if stage == 1 || stage == 2 {
            // TCS or TES
            gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));
            gl!(gl.draw_arrays(glw::GL_PATCHES, 0, 1));
            gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3));
        } else if stage == 4 {
            // CS
            gl!(gl.dispatch_compute(1, 1, 1));
        } else {
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        }
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        {
            let mut data = [[0i32; 4]; 7];
            gl!(gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                data.as_mut_ptr().cast()
            ));
            for (i, (returned, expected)) in data.iter().zip(expected_result).enumerate() {
                if returned != expected {
                    log::info!(
                        "Returned value is: ({} {} {} {}). Expected value is: ({} {} {} {}). Image unit is: {}",
                        returned[0],
                        returned[1],
                        returned[2],
                        returned[3],
                        expected[0],
                        expected[1],
                        expected[2],
                        expected[3],
                        i + 1
                    );
                    return Ok(ERROR);
                }
            }
        }
        Ok(NO_ERROR)
    }
}

impl Drop for ImageSizeMachine<'_> {
    fn drop(&mut self) {
        gl!(self.gl.delete_program_pipelines(1, &self.pipeline));
        for program in self.program {
            gl!(self.gl.delete_program(program));
        }
        gl!(self.gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(self.gl.delete_textures(1, &self.texture));
    }
}

fn bind_target(gl: &glw::Functions, target: GLenum, texture: GLuint) {
    gl!(gl.bind_texture(target, texture));
    if target != glw::GL_TEXTURE_BUFFER {
        gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
    }
}

/// 1.1.x.y BasicNonMS
struct BasicNonMs {
    kind: ElemKind,
    stage: i32,
    texture: [GLuint; 7],
    buffer: GLuint,
}

impl Subcase for BasicNonMs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(7, self.texture.as_mut_ptr()));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_stage(gl, self.stage, 8) {
            return Ok(NOT_SUPPORTED);
        }

        let format = self.kind.tex_internal_format();
        let target: [GLenum; 7] = [
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_3D,
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_RECTANGLE,
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_BUFFER,
        ];
        for i in 0..7 {
            bind_target(gl, target[i], self.texture[i]);
            match i {
                0 => {
                    gl!(gl.tex_storage_2d(target[i], 10, format, 512, 128));
                    gl!(gl.bind_image_texture(1, self.texture[i], 1, glw::FALSE, 0, glw::GL_READ_ONLY, format));
                }
                1 => {
                    gl!(gl.tex_storage_3d(target[i], 3, format, 8, 8, 4));
                    gl!(gl.bind_image_texture(2, self.texture[i], 0, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                2 => {
                    gl!(gl.tex_storage_2d(target[i], 4, format, 16, 16));
                    gl!(gl.bind_image_texture(3, self.texture[i], 0, glw::FALSE, 0, glw::GL_READ_WRITE, format));
                }
                3 => {
                    gl!(gl.tex_storage_3d(target[i], 2, format, 4, 4, 12));
                    gl!(gl.bind_image_texture(4, self.texture[i], 1, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                4 => {
                    gl!(gl.tex_storage_2d(target[i], 1, format, 16, 8));
                    gl!(gl.bind_image_texture(5, self.texture[i], 0, glw::FALSE, 0, glw::GL_READ_ONLY, format));
                }
                5 => {
                    gl!(gl.tex_storage_3d(target[i], 3, format, 127, 39, 12));
                    gl!(gl.bind_image_texture(6, self.texture[i], 2, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                _ => {
                    let data = vec![0u8; 256];
                    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, self.buffer));
                    gl!(gl.buffer_data(glw::GL_TEXTURE_BUFFER, 256, data.as_ptr().cast(), glw::GL_STATIC_DRAW));
                    gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, format, self.buffer));
                    gl!(gl.bind_image_texture(7, self.texture[i], 0, glw::FALSE, 0, glw::GL_READ_ONLY, format));
                }
            }
        }

        let mut machine = ImageSizeMachine::new(gl);
        let res: [IVec4; 7] = [
            [256, 64, 0, 0],
            [8, 8, 4, 0],
            [16, 16, 0, 0],
            [2, 2, 2, 0],
            [16, 8, 0, 0],
            [31, 9, 12, 0],
            [16, 0, 0, 0],
        ];
        machine.run(self.kind, self.stage, false, &res, false)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_textures(7, self.texture.as_ptr()));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// 1.2.x.y BasicMS
struct BasicMs {
    kind: ElemKind,
    stage: i32,
    texture: [GLuint; 4],
}

impl Subcase for BasicMs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().gen_textures(4, self.texture.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_stage(gl, self.stage, 5) {
            return Ok(NOT_SUPPORTED);
        }
        if !supported_samples(gl, 4) {
            return Ok(NOT_SUPPORTED);
        }

        let format = self.kind.tex_internal_format();
        let target: [GLenum; 4] = [
            glw::GL_TEXTURE_1D,
            glw::GL_TEXTURE_1D_ARRAY,
            glw::GL_TEXTURE_2D_MULTISAMPLE,
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        ];
        for i in 0..4 {
            gl!(gl.bind_texture(target[i], self.texture[i]));
            if target[i] == glw::GL_TEXTURE_1D || target[i] == glw::GL_TEXTURE_1D_ARRAY {
                gl!(gl.tex_parameteri(target[i], glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
                gl!(gl.tex_parameteri(target[i], glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
            }
            match i {
                0 => {
                    gl!(gl.tex_storage_1d(target[i], 10, format, 512));
                    gl!(gl.bind_image_texture(1, self.texture[i], 6, glw::FALSE, 0, glw::GL_READ_ONLY, format));
                }
                1 => {
                    gl!(gl.tex_storage_2d(target[i], 3, format, 15, 7));
                    gl!(gl.bind_image_texture(2, self.texture[i], 1, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                2 => {
                    gl!(gl.tex_image_2d_multisample(target[i], 4, format, 17, 19, glw::FALSE));
                    gl!(gl.bind_image_texture(3, self.texture[i], 0, glw::FALSE, 0, glw::GL_READ_WRITE, format));
                }
                _ => {
                    gl!(gl.tex_image_3d_multisample(target[i], 4, format, 64, 32, 5, glw::FALSE));
                    gl!(gl.bind_image_texture(4, self.texture[i], 0, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
            }
        }

        let mut machine = ImageSizeMachine::new(gl);
        let res: [IVec4; 7] = [
            [8, 0, 0, 0],
            [7, 7, 0, 0],
            [17, 19, 0, 0],
            [64, 32, 5, 0],
            [0; 4],
            [0; 4],
            [0; 4],
        ];
        machine.run(self.kind, self.stage, true, &res, false)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_textures(4, self.texture.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// 2.1 AdvancedChangeSize
struct AdvancedChangeSize {
    pipeline: GLuint,
    program: [GLuint; 2],
    vertex_array: GLuint,
    texture: [GLuint; 2],
}

impl Subcase for AdvancedChangeSize {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_program_pipelines(1, &mut self.pipeline));
        self.program = [0; 2];
        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array));
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "#version 430 core\nout gl_PerVertex { vec4 gl_Position; };\nconst vec2 g_position[3] = { vec2(-1, -1), vec2(3, -1), vec2(-1, 3) };\nvoid main() { gl_Position = vec4(g_position[gl_VertexID], 0, 1); }";
        let glsl_fs = "#version 430 core\nlayout(location = 0) out vec4 g_color;\nlayout(binding = 0, rgba8) uniform image2D g_image[2];\nuniform ivec2 g_expected_size[2];\nuniform int g_0 = 0, g_1 = 1;\nvoid main() {\n  vec4 c = vec4(0, 1, 0, 1);\n  if (imageSize(g_image[g_0]).xy != g_expected_size[g_0]) c = vec4(1, 0, 0, 1);\n  if (imageSize(g_image[g_1]).yx != g_expected_size[g_1]) c = vec4(1, 0, 0, 1);\n  g_color = c;\n}";
        self.program[0] = create_shader_program(gl, glw::GL_VERTEX_SHADER, glsl_vs);
        self.program[1] = create_shader_program(gl, glw::GL_FRAGMENT_SHADER, glsl_fs);
        for program in self.program {
            if !check_program(gl, program) {
                return Ok(ERROR);
            }
        }

        gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.program[0]));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_FRAGMENT_SHADER_BIT, self.program[1]));
        gl!(gl.bind_vertex_array(self.vertex_array));
        gl!(gl.bind_program_pipeline(self.pipeline));

        let mut size = [32i32, 128];
        for i in 0..2 {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[i]));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as GLint));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                size[i],
                size[i],
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
            gl!(gl.bind_image_texture(
                i as GLuint,
                self.texture[i],
                0,
                glw::FALSE,
                0,
                glw::GL_READ_ONLY,
                glw::GL_RGBA8
            ));
        }

        let window_width = context.render_target().width;
        let window_height = context.render_target().height;
        for _ in 0..3 {
            let location_0 = gl!(gl.get_uniform_location(self.program[1], c"g_expected_size[0]".as_ptr()));
            gl!(gl.program_uniform_2i(self.program[1], location_0, size[0], size[0]));
            let location_1 = gl!(gl.get_uniform_location(self.program[1], c"g_expected_size[1]".as_ptr()));
            gl!(gl.program_uniform_2i(self.program[1], location_1, size[1], size[1]));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
            {
                let mut fb = vec![[0.0f32; 3]; (window_width * window_height) as usize];
                gl!(gl.read_pixels(
                    0,
                    0,
                    window_width,
                    window_height,
                    glw::GL_RGB,
                    glw::GL_FLOAT,
                    fb.as_mut_ptr().cast()
                ));
                if !validate_read_buffer(context, 0, 0, window_width, window_height, [0.0, 1.0, 0.0, 1.0]) {
                    return Ok(ERROR);
                }
            }
            size[0] /= 2;
            size[1] /= 2;
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[0]));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                size[0],
                size[0],
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[1]));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                size[1],
                size[1],
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program_pipelines(1, &self.pipeline));
        for program in self.program {
            gl!(gl.delete_program(program));
        }
        gl!(gl.delete_vertex_arrays(1, &self.vertex_array));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// 2.2.x.y AdvancedNonMS
struct AdvancedNonMs {
    kind: ElemKind,
    stage: i32,
    texture: [GLuint; 7],
    buffer: GLuint,
}

impl Subcase for AdvancedNonMs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(7, self.texture.as_mut_ptr()));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_stage(gl, self.stage, 8) {
            return Ok(NOT_SUPPORTED);
        }

        let format = self.kind.tex_internal_format();
        let (tex_format, tex_type) = (self.kind.tex_format(), self.kind.tex_type());
        let target: [GLenum; 7] = [
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_3D,
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_RECTANGLE,
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_BUFFER,
        ];
        let image_3d = |target: GLenum, level: GLint, w: i32, h: i32, d: i32| {
            gl!(gl.tex_image_3d(
                target,
                level,
                format as GLint,
                w,
                h,
                d,
                0,
                tex_format,
                tex_type,
                std::ptr::null()
            ));
        };
        for i in 0..7 {
            bind_target(gl, target[i], self.texture[i]);
            match i {
                0 => {
                    image_3d(target[i], 0, 2, 2, 7);
                    image_3d(target[i], 1, 1, 1, 7);
                    gl!(gl.bind_image_texture(1, self.texture[i], 1, glw::FALSE, 3, glw::GL_READ_ONLY, format));
                }
                1 => {
                    image_3d(target[i], 0, 4, 4, 2);
                    image_3d(target[i], 1, 2, 2, 1);
                    image_3d(target[i], 2, 1, 1, 1);
                    gl!(gl.bind_image_texture(2, self.texture[i], 1, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                2 => {
                    image_3d(target[i], 0, 2, 2, 12);
                    image_3d(target[i], 1, 1, 1, 12);
                    gl!(gl.bind_image_texture(3, self.texture[i], 0, glw::FALSE, 1, glw::GL_READ_WRITE, format));
                }
                3 => {
                    image_3d(target[i], 0, 4, 4, 18);
                    image_3d(target[i], 1, 2, 2, 18);
                    image_3d(target[i], 2, 1, 1, 18);
                    gl!(gl.bind_image_texture(4, self.texture[i], 1, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                4 => {
                    gl!(gl.tex_image_2d(
                        target[i],
                        0,
                        format as GLint,
                        123,
                        11,
                        0,
                        tex_format,
                        tex_type,
                        std::ptr::null()
                    ));
                    gl!(gl.bind_image_texture(5, self.texture[i], 0, glw::FALSE, 0, glw::GL_READ_WRITE, format));
                }
                5 => {
                    image_3d(target[i], 0, 13, 7, 4);
                    image_3d(target[i], 1, 6, 3, 4);
                    image_3d(target[i], 2, 3, 1, 4);
                    image_3d(target[i], 3, 1, 1, 4);
                    gl!(gl.bind_image_texture(6, self.texture[i], 1, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                _ => {
                    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, self.buffer));
                    gl!(gl.buffer_data(glw::GL_TEXTURE_BUFFER, 1024, std::ptr::null(), glw::GL_STATIC_DRAW));
                    gl!(gl.tex_buffer_range(glw::GL_TEXTURE_BUFFER, format, self.buffer, 256, 512));
                    gl!(gl.bind_image_texture(7, self.texture[i], 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, format));
                }
            }
        }

        let mut machine = ImageSizeMachine::new(gl);
        let res: [IVec4; 7] = [
            [1, 1, 0, 0],
            [2, 2, 1, 0],
            [2, 2, 0, 0],
            [2, 2, 3, 0],
            [123, 11, 0, 0],
            [6, 3, 4, 0],
            [32, 0, 0, 0],
        ];
        machine.run(self.kind, self.stage, false, &res, true)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_textures(7, self.texture.as_ptr()));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// 2.3.x.y AdvancedMS
struct AdvancedMs {
    kind: ElemKind,
    stage: i32,
    texture: [GLuint; 4],
}

impl Subcase for AdvancedMs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().gen_textures(4, self.texture.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_in_stage(gl, self.stage, 5) {
            return Ok(NOT_SUPPORTED);
        }
        if !supported_samples(gl, 4) {
            return Ok(NOT_SUPPORTED);
        }

        let format = self.kind.tex_internal_format();
        let (tex_format, tex_type) = (self.kind.tex_format(), self.kind.tex_type());
        let target: [GLenum; 4] = [
            glw::GL_TEXTURE_1D,
            glw::GL_TEXTURE_1D_ARRAY,
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        ];
        for i in 0..4 {
            gl!(gl.bind_texture(target[i], self.texture[i]));
            if target[i] == glw::GL_TEXTURE_1D || target[i] == glw::GL_TEXTURE_1D_ARRAY {
                gl!(gl.tex_parameteri(target[i], glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
                gl!(gl.tex_parameteri(target[i], glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
            }
            match i {
                0 => {
                    for (level, width) in [(0, 7), (1, 3), (2, 1)] {
                        gl!(gl.tex_image_1d(
                            target[i],
                            level,
                            format as GLint,
                            width,
                            0,
                            tex_format,
                            tex_type,
                            std::ptr::null()
                        ));
                    }
                    gl!(gl.bind_image_texture(1, self.texture[i], 1, glw::FALSE, 0, glw::GL_READ_ONLY, format));
                }
                1 => {
                    gl!(gl.tex_image_2d(
                        target[i],
                        0,
                        format as GLint,
                        7,
                        15,
                        0,
                        tex_format,
                        tex_type,
                        std::ptr::null()
                    ));
                    gl!(gl.bind_image_texture(2, self.texture[i], 0, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
                2 => {
                    gl!(gl.tex_image_3d_multisample(target[i], 4, format, 7, 9, 3, glw::FALSE));
                    gl!(gl.bind_image_texture(3, self.texture[i], 0, glw::FALSE, 1, glw::GL_READ_WRITE, format));
                }
                _ => {
                    gl!(gl.tex_image_3d_multisample(target[i], 4, format, 64, 32, 5, glw::FALSE));
                    gl!(gl.bind_image_texture(4, self.texture[i], 0, glw::TRUE, 0, glw::GL_READ_ONLY, format));
                }
            }
        }

        let mut machine = ImageSizeMachine::new(gl);
        let res: [IVec4; 7] = [
            [3, 0, 0, 0],
            [7, 15, 0, 0],
            [7, 9, 0, 0],
            [64, 32, 5, 0],
            [0; 4],
            [0; 4],
            [0; 4],
        ];
        machine.run(self.kind, self.stage, true, &res, true)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_textures(4, self.texture.as_ptr()));
        Ok(NO_ERROR)
    }
}

/// 4.1 NegativeCompileTime
struct NegativeCompileTime;

impl NegativeCompileTime {
    fn compile(gl: &glw::Functions, source: &str) -> bool {
        let shader = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        let source = std::ffi::CString::new(source).expect("shader source holds no nul byte");
        let pointer = source.as_ptr();
        gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
        gl!(gl.compile_shader(shader));

        let mut info_log = [0u8; 1024];
        gl!(gl.get_shader_info_log(
            shader,
            info_log.len() as i32,
            std::ptr::null_mut(),
            info_log.as_mut_ptr().cast()
        ));
        let end = info_log.iter().position(|&b| b == 0).unwrap_or(info_log.len());
        log::info!("Shader Info Log:\n{}", String::from_utf8_lossy(&info_log[..end]));

        let mut status = 0;
        gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
        gl!(gl.delete_shader(shader));
        if status == glw::GL_TRUE as GLint {
            log::info!("Compilation should fail.");
            return false;
        }
        true
    }
}

impl Subcase for NegativeCompileTime {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        // '#extension GL_ARB_shader_image_size : require' is missing
        if !Self::compile(
            gl,
            "#version 420 core\nlayout(location = 0) out vec4 g_color;\nlayout(binding = 0, rg16f) uniform image2D g_image;\nuniform ivec2 g_expected_size;\nvoid main() {\n  if (imageSize(g_image) == g_expected_size) g_color = vec4(0, 1, 0, 1);\n  else g_color = vec4(1, 0, 0, 1);\n}",
        ) {
            return Ok(ERROR);
        }
        // imageSize(sampler)
        if !Self::compile(
            gl,
            "#version 430 core\nlayout(location = 0) out vec4 g_color;\nlayout(binding = 0) uniform sampler2D g_sampler;\nuniform ivec2 g_expected_size;\nvoid main() {\n  if (imageSize(g_sampler) == g_expected_size) g_color = vec4(0, 1, 0, 1);\n  else g_color = vec4(1, 0, 0, 1);\n}",
        ) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

fn add_case<F: Fn() -> Box<dyn Subcase> + Send + Sync + 'static>(group: &mut TestCaseGroup, name: String, factory: F) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

/// `ShaderImageSizeTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_image_size");
    let kinds = [
        ("float", ElemKind::Vec4),
        ("int", ElemKind::IVec4),
        ("uint", ElemKind::UVec4),
    ];
    // stage numbers in the order upstream registers them
    let stages = [("vs", 0), ("tcs", 1), ("tes", 2), ("gs", 3), ("fs", 5), ("cs", 4)];

    for (stage_name, stage) in stages {
        for (kind_name, kind) in kinds {
            add_case(&mut group, format!("basic-nonMS-{stage_name}-{kind_name}"), move || {
                Box::new(BasicNonMs {
                    kind,
                    stage,
                    texture: [0; 7],
                    buffer: 0,
                })
            });
        }
    }
    for (stage_name, stage) in stages {
        for (kind_name, kind) in kinds {
            add_case(&mut group, format!("basic-ms-{stage_name}-{kind_name}"), move || {
                Box::new(BasicMs {
                    kind,
                    stage,
                    texture: [0; 4],
                })
            });
        }
    }
    add_case(&mut group, "advanced-changeSize".to_string(), || {
        Box::new(AdvancedChangeSize {
            pipeline: 0,
            program: [0; 2],
            vertex_array: 0,
            texture: [0; 2],
        })
    });
    for (stage_name, stage) in stages {
        for (kind_name, kind) in kinds {
            add_case(
                &mut group,
                format!("advanced-nonMS-{stage_name}-{kind_name}"),
                move || {
                    Box::new(AdvancedNonMs {
                        kind,
                        stage,
                        texture: [0; 7],
                        buffer: 0,
                    })
                },
            );
        }
    }
    for (stage_name, stage) in stages {
        for (kind_name, kind) in kinds {
            add_case(&mut group, format!("advanced-ms-{stage_name}-{kind_name}"), move || {
                Box::new(AdvancedMs {
                    kind,
                    stage,
                    texture: [0; 4],
                })
            });
        }
    }
    add_case(&mut group, "negative-compileTime".to_string(), || {
        Box::new(NegativeCompileTime)
    });

    group
}
