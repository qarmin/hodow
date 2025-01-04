// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cVertexAttribBindingTests.cpp
//   external/openglcts/modules/gl/gl4cVertexAttribBindingTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `Basic*` case is a `Subcase`; the twelve BasicInputCase classes share one `BasicInput` runner and differ only in the setup function (state plus expected transform feedback data) they pass it, the same split upstream has between `BasicInputBase::Run` and the cases' `Run`. Ported so far: basic-usage, basic-input-case1..12, basic-inputI-case1..3, basic-inputL-case1..2, basic-state1..4, advanced-* and negative-* (all 30 cases).

use super::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult, TestSubcase};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};

/// A GL call with a current context and with pointers into live locals or buffers of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

type Vec4 = [f32; 4];
type DVec4 = [f64; 4];

/// `VertexAttribBindingBase::CheckProgram`
fn check_program(gl: &glw::Functions, program: GLuint) -> bool {
    let mut status: GLint = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    if status == glw::GL_FALSE as GLint {
        let mut attached_shaders: GLint = 0;
        gl!(gl.get_programiv(program, glw::GL_ATTACHED_SHADERS, &mut attached_shaders));
        if attached_shaders > 0 {
            let mut shaders = vec![0 as GLuint; attached_shaders as usize];
            gl!(gl.get_attached_shaders(program, attached_shaders, std::ptr::null_mut(), shaders.as_mut_ptr()));
            for &shader in &shaders {
                let mut shader_type: GLint = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_TYPE, &mut shader_type));
                let name = match shader_type as GLenum {
                    glw::GL_VERTEX_SHADER => "Vertex Shader",
                    glw::GL_TESS_CONTROL_SHADER => "Tessellation Control Shader",
                    glw::GL_TESS_EVALUATION_SHADER => "Tessellation Evaluation Shader",
                    glw::GL_GEOMETRY_SHADER => "Geometry Shader",
                    glw::GL_FRAGMENT_SHADER => "Fragment Shader",
                    glw::GL_COMPUTE_SHADER => "Compute Shader",
                    _ => "Unknown Shader",
                };
                log::info!("*** {name} ***");

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

        let mut length: GLint = 0;
        gl!(gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, &mut length));
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            log::info!("{}", String::from_utf8_lossy(&info_log));
        }
    }
    status == glw::GL_TRUE as GLint
}

/// `VertexAttribBindingBase::CheckRectColor` (the Vec3 overload) over the whole window
fn check_window_color(context: &Context, expected: [f32; 3]) -> bool {
    let gl = context.gl();
    let target = context.render_target();
    let (fb_w, fb_h) = (target.width, target.height);
    let eps = [
        1.0 / (1u32 << target.red_bits) as f32,
        1.0 / (1u32 << target.green_bits) as f32,
        1.0 / (1u32 << target.blue_bits) as f32,
    ];

    let mut fb = vec![0f32; (fb_w * fb_h * 3) as usize];
    gl!(gl.read_pixels(0, 0, fb_w, fb_h, glw::GL_RGB, glw::GL_FLOAT, fb.as_mut_ptr().cast()));

    for y in 0..fb_h {
        for x in 0..fb_w {
            let idx = ((y * fb_w + x) * 3) as usize;
            if (0..3).any(|k| (fb[idx + k] - expected[k]).abs() > eps[k]) {
                log::info!(
                    "Incorrect framebuffer color at pixel ({x} {y}). Color is ({} {} {}). Color should be ({} {} {})",
                    fb[idx],
                    fb[idx + 1],
                    fb[idx + 2],
                    expected[0],
                    expected[1],
                    expected[2]
                );
                return false;
            }
        }
    }
    true
}

/// `glBufferData(GL_ARRAY_BUFFER, size, NULL, GL_STATIC_DRAW)`
fn array_buffer_alloc(gl: &glw::Functions, size: isize) {
    gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, size, std::ptr::null(), glw::GL_STATIC_DRAW));
}

/// `glBufferSubData(GL_ARRAY_BUFFER, offset, sizeof(d), d)`
fn array_buffer_sub<T: Copy>(gl: &glw::Functions, offset: isize, data: &[T]) {
    gl!(gl.buffer_sub_data(
        glw::GL_ARRAY_BUFFER,
        offset,
        std::mem::size_of_val(data) as isize,
        data.as_ptr().cast()
    ));
}

/// Builds a vertex-only program that records `varyings` (`glTransformFeedbackVaryings`, interleaved); returns the program and whether it linked.
fn transform_feedback_program(gl: &glw::Functions, glsl_vs: &str, varyings: &[String]) -> (GLuint, bool) {
    let po = gl!(gl.create_program());
    let sh = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
    let source = glsl_vs.as_ptr().cast::<glw::GLchar>();
    let length = glsl_vs.len() as GLint;
    gl!(gl.shader_source(sh, 1, &source, &length));
    gl!(gl.compile_shader(sh));
    gl!(gl.attach_shader(po, sh));
    gl!(gl.delete_shader(sh));

    let c_varyings: Vec<std::ffi::CString> = varyings
        .iter()
        .map(|v| std::ffi::CString::new(v.as_str()).expect("varying names have no NUL"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = c_varyings.iter().map(|v| v.as_ptr()).collect();
    gl!(gl.transform_feedback_varyings(
        po,
        pointers.len() as GLsizei,
        pointers.as_ptr(),
        glw::GL_INTERLEAVED_ATTRIBS
    ));
    gl!(gl.link_program(po));
    let linked = check_program(gl, po);
    (po, linked)
}

/// The zeroed transform feedback buffer all three Basic*Base runners bind
fn bind_zeroed_transform_feedback_buffer(gl: &glw::Functions, xfbo: GLuint, size: usize, usage: GLenum) {
    let zero = vec![0u8; size];
    gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, xfbo));
    gl!(gl.buffer_data(
        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
        size as isize,
        zero.as_ptr().cast(),
        usage
    ));
}

fn varying_names(prefix: &str, count: usize) -> Vec<String> {
    (0..count).map(|i| format!("StageData.{prefix}[{i}]")).collect()
}

// ---------------------------------------------------------------------------------------------------------------------
// 1.1 BasicUsage

#[derive(Default)]
struct BasicUsage {
    vsp: GLuint,
    fsp: GLuint,
    ppo: GLuint,
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicUsage {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.vsp = 0;
        self.fsp = 0;
        gl!(gl.gen_program_pipelines(1, &mut self.ppo));
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_buffers(1, &mut self.vbo));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program(self.fsp));
        gl!(gl.delete_program_pipelines(1, &self.ppo));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "#version 430 core\nlayout(location = 0) in vec4 vs_in_position;\nlayout(location = 1) in vec3 vs_in_color;\nout StageData {\n  vec3 color;\n} vs_out;\nout gl_PerVertex { vec4 gl_Position; };\nvoid main() {\n  gl_Position = vs_in_position;\n  vs_out.color = vs_in_color;\n}\0";
        let glsl_fs = "#version 430 core\nin StageData {\n  vec3 color;\n} fs_in;\nlayout(location = 0) out vec4 fs_out_color;\nvoid main() {\n  fs_out_color = vec4(fs_in.color, 1);\n}\0";

        let vs_ptr = glsl_vs.as_ptr().cast::<glw::GLchar>();
        let fs_ptr = glsl_fs.as_ptr().cast::<glw::GLchar>();
        self.vsp = gl!(gl.create_shader_programv(glw::GL_VERTEX_SHADER, 1, &vs_ptr));
        self.fsp = gl!(gl.create_shader_programv(glw::GL_FRAGMENT_SHADER, 1, &fs_ptr));
        if !check_program(gl, self.vsp) || !check_program(gl, self.fsp) {
            return Ok(ERROR);
        }

        gl!(gl.use_program_stages(self.ppo, glw::GL_VERTEX_SHADER_BIT, self.vsp));
        gl!(gl.use_program_stages(self.ppo, glw::GL_FRAGMENT_SHADER_BIT, self.fsp));

        {
            let data: [f32; 40] = [
                -1.0, -1.0, 0.0, 1.0, 0.0, 1.0, -1.0, 0.0, 1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0,
                -1.0, -1.0, 1.0, 1.0, 0.0, 1.0, -1.0, 1.0, 1.0, 0.0, -1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0,
            ];
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        }

        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.vertex_attrib_format(0, 2, glw::GL_FLOAT, glw::FALSE, 0));
        gl!(gl.vertex_attrib_format(1, 3, glw::GL_FLOAT, glw::FALSE, 8));
        gl!(gl.vertex_attrib_binding(0, 0));
        gl!(gl.vertex_attrib_binding(1, 0));
        gl!(gl.bind_vertex_buffer(0, self.vbo, 0, 20));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.bind_program_pipeline(self.ppo));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        if !check_window_color(context, [0.0, 1.0, 0.0]) {
            return Ok(ERROR);
        }

        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 4, 4));
        if !check_window_color(context, [1.0, 1.0, 0.0]) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// 1.2 BasicInputBase and its twelve cases

/// The object names a BasicInputCase creates in `Setup`
#[derive(Default, Clone, Copy)]
struct Objects {
    vao: GLuint,
    vbo: [GLuint; 2],
}

/// The state `BasicInputBase` hands the cases: what they expect, and how the draw call is made
struct InputSpec {
    expected_data: [Vec4; 64],
    instance_count: GLsizei,
    base_instance: i64,
}

type InputSetup = fn(&glw::Functions, &Objects, &mut InputSpec);

/// `BasicInputCase1..12`: `BasicInputBase` plus the case's own `Run` prefix
struct BasicInput {
    setup: InputSetup,
    po: GLuint,
    xfbo: GLuint,
    objects: Objects,
}

impl BasicInput {
    fn new(setup: InputSetup) -> Self {
        Self {
            setup,
            po: 0,
            xfbo: 0,
            objects: Objects::default(),
        }
    }
}

impl Subcase for BasicInput {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.po = 0;
        gl!(gl.gen_buffers(1, &mut self.xfbo));
        gl!(gl.gen_vertex_arrays(1, &mut self.objects.vao));
        gl!(gl.gen_buffers(2, self.objects.vbo.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.po));
        gl!(gl.delete_buffers(1, &self.xfbo));
        gl!(gl.delete_vertex_arrays(1, &self.objects.vao));
        gl!(gl.delete_buffers(2, self.objects.vbo.as_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut spec = InputSpec {
            expected_data: [[0.0; 4]; 64],
            instance_count: 1,
            base_instance: -1,
        };

        for i in 0..16 {
            gl!(gl.vertex_attrib_4f(i, 0.0, 0.0, 0.0, 0.0));
        }
        (self.setup)(gl, &self.objects, &mut spec);

        // BasicInputBase::Run
        let glsl_vs = "#version 430 core\nlayout(location = 0) in vec4 vs_in_attrib[16];\nout StageData {\n  vec4 attrib[16];\n} vs_out;\nvoid main() {\n  for (int i = 0; i < vs_in_attrib.length(); ++i) {\n    vs_out.attrib[i] = vs_in_attrib[i];\n  }\n}";
        let (po, linked) = transform_feedback_program(gl, glsl_vs, &varying_names("attrib", 16));
        self.po = po;
        if !linked {
            return Ok(ERROR);
        }

        bind_zeroed_transform_feedback_buffer(
            gl,
            self.xfbo,
            std::mem::size_of_val(&spec.expected_data),
            glw::GL_DYNAMIC_DRAW,
        );

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(self.po));
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        if spec.base_instance != -1 {
            gl!(gl.draw_arrays_instanced_base_instance(
                glw::GL_POINTS,
                0,
                2,
                spec.instance_count,
                spec.base_instance as GLuint
            ));
        } else {
            gl!(gl.draw_arrays_instanced(glw::GL_POINTS, 0, 2, spec.instance_count));
        }
        gl!(gl.end_transform_feedback());

        let mut data = [[0f32; 4]; 64];
        gl!(gl.get_buffer_sub_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            std::mem::size_of_val(&data) as isize,
            data.as_mut_ptr().cast()
        ));

        for i in 0..64 {
            if (0..4).any(|k| (spec.expected_data[i][k] - data[i][k]).abs() > 0.01) {
                log::info!(
                    "Data is: {} {} {} {}, data should be: {} {} {} {}, index is: {i}",
                    data[i][0],
                    data[i][1],
                    data[i][2],
                    data[i][3],
                    spec.expected_data[i][0],
                    spec.expected_data[i][1],
                    spec.expected_data[i][2],
                    spec.expected_data[i][3]
                );
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

fn input_case1(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 12 * 2);
    array_buffer_sub(gl, 0, &[1.0f32, 2.0, 3.0]);
    array_buffer_sub(gl, 12, &[4.0f32, 5.0, 6.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 12));
    gl!(gl.vertex_attrib_format(1, 3, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_binding(1, 0));
    gl!(gl.enable_vertex_attrib_array(1));

    spec.expected_data[1] = [1.0, 2.0, 3.0, 1.0];
    spec.expected_data[17] = [4.0, 5.0, 6.0, 1.0];
}

fn input_case2(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 12 * 2);
    array_buffer_sub(gl, 0, &[1.0f32, 2.0, 3.0]);
    array_buffer_sub(gl, 12, &[4.0f32, 5.0, 6.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_binding(1, 0));
    gl!(gl.vertex_attrib_format(0, 2, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(1, 3, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(7, 1, glw::GL_FLOAT, glw::FALSE, 8));
    gl!(gl.vertex_attrib_format(15, 2, glw::GL_FLOAT, glw::FALSE, 4));
    gl!(gl.vertex_attrib_binding(0, 0));
    gl!(gl.vertex_attrib_binding(7, 0));
    gl!(gl.vertex_attrib_binding(15, 0));
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 12));
    for attrib in [0, 1, 7, 15] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }

    spec.expected_data[0] = [1.0, 2.0, 0.0, 1.0];
    spec.expected_data[1] = [1.0, 2.0, 3.0, 1.0];
    spec.expected_data[7] = [3.0, 0.0, 0.0, 1.0];
    spec.expected_data[15] = [2.0, 3.0, 0.0, 1.0];
    spec.expected_data[16] = [4.0, 5.0, 0.0, 1.0];
    spec.expected_data[17] = [4.0, 5.0, 6.0, 1.0];
    spec.expected_data[23] = [6.0, 0.0, 0.0, 1.0];
    spec.expected_data[31] = [5.0, 6.0, 0.0, 1.0];
}

fn input_case3(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 36 * 2);
    array_buffer_sub(gl, 0, &[1u8, 2, 3, 4]);
    array_buffer_sub(gl, 16, &[5.0f32, 6.0, 7.0]);
    array_buffer_sub(gl, 28, &[8.0f32, 9.0]);
    array_buffer_sub(gl, 36, &[10u8, 11, 12, 13]);
    array_buffer_sub(gl, 16 + 36, &[14.0f32, 15.0, 16.0]);
    array_buffer_sub(gl, 28 + 36, &[17.0f32, 18.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.enable_vertex_attrib_array(1));
    gl!(gl.vertex_attrib_format(0, 4, glw::GL_UNSIGNED_BYTE, glw::FALSE, 0));
    gl!(gl.vertex_attrib_binding(1, 3));
    gl!(gl.vertex_attrib_format(1, 3, glw::GL_FLOAT, glw::FALSE, 16));
    gl!(gl.vertex_attrib_binding(2, 3));
    gl!(gl.vertex_attrib_format(2, 2, glw::GL_FLOAT, glw::FALSE, 28));
    gl!(gl.vertex_attrib_binding(0, 3));
    gl!(gl.bind_vertex_buffer(3, o.vbo[0], 0, 36));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.enable_vertex_attrib_array(2));

    spec.expected_data[0] = [1.0, 2.0, 3.0, 4.0];
    spec.expected_data[1] = [5.0, 6.0, 7.0, 1.0];
    spec.expected_data[2] = [8.0, 9.0, 0.0, 1.0];
    spec.expected_data[16] = [10.0, 11.0, 12.0, 13.0];
    spec.expected_data[17] = [14.0, 15.0, 16.0, 1.0];
    spec.expected_data[18] = [17.0, 18.0, 0.0, 1.0];
}

fn input_case4(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 20 * 2);
    array_buffer_sub(gl, 0, &[-127i8, 127, -127, 127]);
    array_buffer_sub(gl, 4, &[1u16, 2, 3, 4]);
    array_buffer_sub(gl, 12, &[5u32, 6]);
    array_buffer_sub(gl, 20, &[127i8, -127, 127, -127]);
    array_buffer_sub(gl, 4 + 20, &[7u16, 8, 9, 10]);
    array_buffer_sub(gl, 12 + 20, &[11u32, 12]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[1]));
    array_buffer_alloc(gl, 24 * 2 + 8);
    array_buffer_sub(gl, 0, &[0.0f64, 100.0, 200.0]);
    array_buffer_sub(gl, 32, &[300.0f64, 400.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_format(0, 4, glw::GL_BYTE, glw::TRUE, 0));
    gl!(gl.vertex_attrib_format(1, 4, glw::GL_UNSIGNED_SHORT, glw::FALSE, 4));
    gl!(gl.vertex_attrib_format(2, 2, glw::GL_UNSIGNED_INT, glw::FALSE, 12));
    gl!(gl.vertex_attrib_format(5, 2, glw::GL_DOUBLE, glw::FALSE, 0));
    gl!(gl.vertex_attrib_binding(0, 0));
    gl!(gl.vertex_attrib_binding(1, 0));
    gl!(gl.vertex_attrib_binding(2, 0));
    gl!(gl.vertex_attrib_binding(5, 6));
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 20));
    gl!(gl.bind_vertex_buffer(6, o.vbo[1], 8, 24));
    for attrib in [0, 1, 2, 5] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }

    spec.expected_data[0] = [-1.0, 1.0, -1.0, 1.0];
    spec.expected_data[1] = [1.0, 2.0, 3.0, 4.0];
    spec.expected_data[2] = [5.0, 6.0, 0.0, 1.0];
    spec.expected_data[5] = [100.0, 200.0, 0.0, 1.0];
    spec.expected_data[16] = [1.0, -1.0, 1.0, -1.0];
    spec.expected_data[17] = [7.0, 8.0, 9.0, 10.0];
    spec.expected_data[18] = [11.0, 12.0, 0.0, 1.0];
    spec.expected_data[21] = [300.0, 400.0, 0.0, 1.0];
}

fn input_case5(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    const STRIDE: isize = 116;
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, STRIDE * 2);
    for (base, vertex) in [(0isize, 0usize), (STRIDE, 1)] {
        if vertex == 0 {
            array_buffer_sub(gl, base, &[0u8, 0xff, 0xff / 2, 0]);
            array_buffer_sub(gl, 4 + base, &[0u16, 0xffff, 0xffff / 2, 0]);
            array_buffer_sub(gl, 12 + base, &[0u32, 0xffffffff, 0xffffffff / 2, 0]);
            array_buffer_sub(gl, 28 + base, &[0i8, -127, 127, 0]);
            array_buffer_sub(gl, 32 + base, &[0i16, -32767, 32767, 0]);
            array_buffer_sub(gl, 40 + base, &[0i32, -2147483647, 2147483647, 0]);
            array_buffer_sub(gl, 56 + base, &[0.0f32, 1.0, 2.0, 0.0]);
            array_buffer_sub(gl, 72 + base, &[0.0f64, 10.0, 20.0, 0.0]);
            array_buffer_sub(gl, 104 + base, &[0u8, 0xff / 4, 0xff / 2, 0xff]);
            array_buffer_sub(gl, 108 + base, &[(1023u32 << 10) | (511 << 20) | (1 << 30)]);
            array_buffer_sub(gl, 112 + base, &[((511u32 << 10) | (255 << 20)) as i32]);
        } else {
            array_buffer_sub(gl, base, &[0xffu8, 0xff, 0xff / 2, 0]);
            array_buffer_sub(gl, 4 + base, &[0xffffu16, 0xffff, 0xffff / 2, 0]);
            array_buffer_sub(gl, 12 + base, &[0xffffffffu32, 0xffffffff, 0xffffffff / 2, 0]);
            array_buffer_sub(gl, 28 + base, &[127i8, -127, 127, 0]);
            array_buffer_sub(gl, 32 + base, &[32767i16, -32767, 32767, 0]);
            array_buffer_sub(gl, 40 + base, &[2147483647i32, -2147483647, 2147483647, 0]);
            array_buffer_sub(gl, 56 + base, &[0.0f32, 3.0, 4.0, 0.0]);
            array_buffer_sub(gl, 72 + base, &[0.0f64, 30.0, 40.0, 0.0]);
            array_buffer_sub(gl, 104 + base, &[0xffu8, 0xff / 2, 0xff / 4, 0]);
            array_buffer_sub(gl, 108 + base, &[(1023u32 << 10) | (511 << 20) | (2u32 << 30)]);
            array_buffer_sub(
                gl,
                112 + base,
                &[((((-511i32) & 0x3ff) as u32) | (511 << 10) | (255 << 20) | (3u32 << 30)) as i32],
            );
        }
    }
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_format(0, 4, glw::GL_UNSIGNED_BYTE, glw::TRUE, 0));
    gl!(gl.vertex_attrib_format(1, 4, glw::GL_UNSIGNED_SHORT, glw::TRUE, 4));
    gl!(gl.vertex_attrib_format(2, 4, glw::GL_UNSIGNED_INT, glw::TRUE, 12));
    gl!(gl.vertex_attrib_format(3, 4, glw::GL_BYTE, glw::TRUE, 28));
    gl!(gl.vertex_attrib_format(4, 4, glw::GL_SHORT, glw::TRUE, 32));
    gl!(gl.vertex_attrib_format(5, 4, glw::GL_INT, glw::TRUE, 40));
    gl!(gl.vertex_attrib_format(6, 4, glw::GL_FLOAT, glw::TRUE, 56));
    gl!(gl.vertex_attrib_format(7, 4, glw::GL_DOUBLE, glw::TRUE, 72));
    gl!(gl.vertex_attrib_format(8, glw::GL_BGRA as GLint, glw::GL_UNSIGNED_BYTE, glw::TRUE, 104));
    gl!(gl.vertex_attrib_format(9, 4, glw::GL_UNSIGNED_INT_2_10_10_10_REV, glw::TRUE, 108));
    gl!(gl.vertex_attrib_format(
        10,
        glw::GL_BGRA as GLint,
        glw::GL_UNSIGNED_INT_2_10_10_10_REV,
        glw::TRUE,
        108
    ));
    gl!(gl.vertex_attrib_format(11, 4, glw::GL_INT_2_10_10_10_REV, glw::TRUE, 112));
    gl!(gl.vertex_attrib_format(12, glw::GL_BGRA as GLint, glw::GL_INT_2_10_10_10_REV, glw::TRUE, 112));
    for i in 0..13 {
        gl!(gl.vertex_attrib_binding(i, 0));
        gl!(gl.enable_vertex_attrib_array(i));
    }
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, STRIDE as GLsizei));

    let e = &mut spec.expected_data;
    e[0] = [0.0, 1.0, 0.5, 0.0];
    e[1] = [0.0, 1.0, 0.5, 0.0];
    e[2] = [0.0, 1.0, 0.5, 0.0];
    e[3] = [0.0, -1.0, 1.0, 0.0];
    e[4] = [0.0, -1.0, 1.0, 0.0];
    e[5] = [0.0, -1.0, 1.0, 0.0];
    e[6] = [0.0, 1.0, 2.0, 0.0];
    e[7] = [0.0, 10.0, 20.0, 0.0];
    e[8] = [0.5, 0.25, 0.0, 1.0];
    e[9] = [0.0, 1.0, 0.5, 0.33];
    e[10] = [0.5, 1.0, 0.0, 0.33];
    e[11] = [0.0, 1.0, 0.5, 0.0];
    e[12] = [0.5, 1.0, 0.0, 0.0];
    e[16] = [1.0, 1.0, 0.5, 0.0];
    e[17] = [1.0, 1.0, 0.5, 0.0];
    e[18] = [1.0, 1.0, 0.5, 0.0];
    e[19] = [1.0, -1.0, 1.0, 0.0];
    e[20] = [1.0, -1.0, 1.0, 0.0];
    e[21] = [1.0, -1.0, 1.0, 0.0];
    e[22] = [0.0, 3.0, 4.0, 0.0];
    e[23] = [0.0, 30.0, 40.0, 0.0];
    e[24] = [0.25, 0.5, 1.0, 0.0];
    e[25] = [0.0, 1.0, 0.5, 0.66];
    e[26] = [0.5, 1.0, 0.0, 0.66];
    e[27] = [-1.0, 1.0, 0.5, -1.0];
    e[28] = [0.5, 1.0, -1.0, -1.0];
}

#[allow(clippy::eq_op)]
fn input_case6(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    const STRIDE: isize = 112;
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, STRIDE * 2);

    array_buffer_sub(gl, 0, &[1u8, 2, 3, 4]);
    array_buffer_sub(gl, 4, &[5u16, 6, 7, 8]);
    array_buffer_sub(gl, 12, &[9u32, 10, 11, 12]);
    array_buffer_sub(gl, 28, &[-1i8, 2, -3, 4]);
    array_buffer_sub(gl, 32, &[-5i16, 6, -7, 8]);
    array_buffer_sub(gl, 40, &[-9i32, 10, -11, 12]);
    array_buffer_sub(gl, 56, &[-13.0f32, 14.0, -15.0, 16.0]);
    array_buffer_sub(gl, 72, &[-18.0f64, 19.0, -20.0, 21.0]);
    array_buffer_sub(gl, 104, &[(11u32 << 10) | (12 << 20) | (2u32 << 30)]);
    array_buffer_sub(
        gl,
        108,
        &[(((0xFFFFFFF5u32 << 10) & (0x3ffu32 << 10)) | (12 << 20) | (1 << 30)) as i32],
    );

    array_buffer_sub(gl, STRIDE, &[22u8, 23, 24, 25]);
    array_buffer_sub(gl, 4 + STRIDE, &[26u16, 27, 28, 29]);
    array_buffer_sub(gl, 12 + STRIDE, &[30u32, 31, 32, 33]);
    array_buffer_sub(gl, 28 + STRIDE, &[-34i8, 35, -36, 37]);
    array_buffer_sub(gl, 32 + STRIDE, &[-38i16, 39, -40, 41]);
    array_buffer_sub(gl, 40 + STRIDE, &[-42i32, 43, -44, 45]);
    array_buffer_sub(gl, 56 + STRIDE, &[-46.0f32, 47.0, -48.0, 49.0]);
    array_buffer_sub(gl, 72 + STRIDE, &[-50.0f64, 51.0, -52.0, 53.0]);
    array_buffer_sub(gl, 104 + STRIDE, &[(11u32 << 10) | (12 << 20) | (1 << 30)]);
    array_buffer_sub(
        gl,
        108 + STRIDE,
        &[(123u32
            | ((0xFFFFFFFDu32 << 10) & (0x3ff << 10))
            | ((0xFFFFFE0Cu32 << 20) & (0x3ff << 20))
            | ((0xFFFFFFFFu32 << 30) & (0x3 << 30))) as i32],
    );
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_format(0, 4, glw::GL_UNSIGNED_BYTE, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(1, 4, glw::GL_UNSIGNED_SHORT, glw::FALSE, 4));
    gl!(gl.vertex_attrib_format(2, 4, glw::GL_UNSIGNED_INT, glw::FALSE, 12));
    gl!(gl.vertex_attrib_format(3, 4, glw::GL_BYTE, glw::FALSE, 28));
    gl!(gl.vertex_attrib_format(4, 4, glw::GL_SHORT, glw::FALSE, 32));
    gl!(gl.vertex_attrib_format(5, 4, glw::GL_INT, glw::FALSE, 40));
    gl!(gl.vertex_attrib_format(6, 4, glw::GL_FLOAT, glw::FALSE, 56));
    gl!(gl.vertex_attrib_format(7, 4, glw::GL_DOUBLE, glw::FALSE, 72));
    gl!(gl.vertex_attrib_format(8, 4, glw::GL_UNSIGNED_INT_2_10_10_10_REV, glw::FALSE, 104));
    gl!(gl.vertex_attrib_format(9, 4, glw::GL_INT_2_10_10_10_REV, glw::FALSE, 108));
    for i in 0..10 {
        gl!(gl.vertex_attrib_binding(i, 0));
        gl!(gl.enable_vertex_attrib_array(i));
    }
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, STRIDE as GLsizei));

    let e = &mut spec.expected_data;
    e[0] = [1.0, 2.0, 3.0, 4.0];
    e[1] = [5.0, 6.0, 7.0, 8.0];
    e[2] = [9.0, 10.0, 11.0, 12.0];
    e[3] = [-1.0, 2.0, -3.0, 4.0];
    e[4] = [-5.0, 6.0, -7.0, 8.0];
    e[5] = [-9.0, 10.0, -11.0, 12.0];
    e[6] = [-13.0, 14.0, -15.0, 16.0];
    e[7] = [-18.0, 19.0, -20.0, 21.0];
    e[8] = [0.0, 11.0, 12.0, 2.0];
    e[9] = [0.0, -11.0, 12.0, 1.0];
    e[16] = [22.0, 23.0, 24.0, 25.0];
    e[17] = [26.0, 27.0, 28.0, 29.0];
    e[18] = [30.0, 31.0, 32.0, 33.0];
    e[19] = [-34.0, 35.0, -36.0, 37.0];
    e[20] = [-38.0, 39.0, -40.0, 41.0];
    e[21] = [-42.0, 43.0, -44.0, 45.0];
    e[22] = [-46.0, 47.0, -48.0, 49.0];
    e[23] = [-50.0, 51.0, -52.0, 53.0];
    e[24] = [0.0, 11.0, 12.0, 1.0];
    e[25] = [123.0, -3.0, -500.0, -1.0];
}

/// BasicInputCase7 and 8 differ only in `base_instance`
fn input_case7_state(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec, with_base_instance: bool) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 6 * 4);
    array_buffer_sub(gl, 0, &[1.0f32, 2.0, 3.0, 4.0, 5.0, 6.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[1]));
    array_buffer_alloc(gl, 10 * 4);
    array_buffer_sub(gl, 0, &[-1.0f32, -2.0, -3.0, -4.0, -5.0, -6.0, -7.0, -8.0, -9.0, -10.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_format(0, 3, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(1, 3, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(2, 1, glw::GL_FLOAT, glw::FALSE, 4));
    gl!(gl.vertex_attrib_format(5, 4, glw::GL_FLOAT, glw::FALSE, 12));
    gl!(gl.vertex_attrib_format(14, 2, glw::GL_FLOAT, glw::FALSE, 8));
    gl!(gl.vertex_attrib_binding(0, 0));
    gl!(gl.vertex_attrib_binding(1, 1));
    gl!(gl.vertex_attrib_binding(2, 1));
    gl!(gl.vertex_attrib_binding(5, 15));
    gl!(gl.vertex_attrib_binding(14, 7));
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 12));
    gl!(gl.bind_vertex_buffer(1, o.vbo[0], 4, 4));
    gl!(gl.bind_vertex_buffer(7, o.vbo[1], 8, 16));
    gl!(gl.bind_vertex_buffer(15, o.vbo[1], 12, 0));
    for attrib in [0, 1, 2, 5, 14] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }

    if with_base_instance {
        spec.base_instance = 0;
    }
    let e = &mut spec.expected_data;
    e[0] = [1.0, 2.0, 3.0, 1.0];
    e[1] = [2.0, 3.0, 4.0, 1.0];
    e[2] = [3.0, 0.0, 0.0, 1.0];
    e[5] = [-7.0, -8.0, -9.0, -10.0];
    e[14] = [-5.0, -6.0, 0.0, 1.0];
    e[16] = [4.0, 5.0, 6.0, 1.0];
    e[17] = [3.0, 4.0, 5.0, 1.0];
    e[18] = [4.0, 0.0, 0.0, 1.0];
    e[21] = [-7.0, -8.0, -9.0, -10.0];
    e[30] = [-9.0, -10.0, 0.0, 1.0];
}

fn input_case7(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    input_case7_state(gl, o, spec, true);
}

fn input_case8(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    input_case7_state(gl, o, spec, false);
}

/// The `0, 16, 32, 48` instance/vertex layout of the divisor cases 9 and 11
fn input_divisor_state(
    gl: &glw::Functions,
    o: &Objects,
    spec: &mut InputSpec,
    rb_binding: GLuint,
    base_instance: Option<i64>,
) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 16 * 3);
    array_buffer_sub(gl, 0, &[1.0f32, 2.0, 3.0, 4.0]);
    array_buffer_sub(gl, 16, &[5.0f32, 6.0, 7.0, 8.0]);
    array_buffer_sub(gl, 32, &[9.0f32, 10.0, 11.0, 12.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[1]));
    array_buffer_alloc(gl, 16 * 3);
    array_buffer_sub(gl, 0, &[10.0f32, 20.0, 30.0, 40.0]);
    array_buffer_sub(gl, 16, &[50.0f32, 60.0, 70.0, 80.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_format(0, 4, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(2, 4, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(4, 2, glw::GL_FLOAT, glw::FALSE, 4));
    gl!(gl.vertex_attrib_binding(0, 0));
    gl!(gl.vertex_attrib_binding(2, 1));
    gl!(gl.vertex_attrib_binding(4, rb_binding));
    for attrib in [0, 2, 4] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 16));
    gl!(gl.bind_vertex_buffer(1, o.vbo[0], 0, 16));
    gl!(gl.bind_vertex_buffer(rb_binding, o.vbo[1], 4, 8));
    gl!(gl.vertex_binding_divisor(1, 1));

    spec.instance_count = 2;
    if let Some(base_instance) = base_instance {
        spec.base_instance = base_instance;
    }
    let e = &mut spec.expected_data;
    e[0] = [1.0, 2.0, 3.0, 4.0];
    e[2] = [1.0, 2.0, 3.0, 4.0];
    e[4] = [30.0, 40.0, 0.0, 1.0];
    e[16] = [5.0, 6.0, 7.0, 8.0];
    e[18] = [1.0, 2.0, 3.0, 4.0];
    e[20] = [50.0, 60.0, 0.0, 1.0];
    e[32] = [1.0, 2.0, 3.0, 4.0];
    e[34] = [5.0, 6.0, 7.0, 8.0];
    e[36] = [30.0, 40.0, 0.0, 1.0];
    e[48] = [5.0, 6.0, 7.0, 8.0];
    e[50] = [5.0, 6.0, 7.0, 8.0];
    e[52] = [50.0, 60.0, 0.0, 1.0];
}

fn input_case9(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    input_divisor_state(gl, o, spec, 3, Some(0));
}

fn input_case10(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 12 * 3);
    array_buffer_sub(gl, 0, &[1.0f32, 2.0, 3.0]);
    array_buffer_sub(gl, 12, &[4.0f32, 5.0, 6.0]);
    array_buffer_sub(gl, 24, &[7.0f32, 8.0, 9.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_format(0, 3, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_format(2, 2, glw::GL_FLOAT, glw::FALSE, 4));
    gl!(gl.vertex_attrib_binding(0, 0));
    gl!(gl.vertex_attrib_binding(2, 3));
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 12));
    gl!(gl.bind_vertex_buffer(3, o.vbo[0], 4, 8));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.enable_vertex_attrib_array(2));
    gl!(gl.vertex_binding_divisor(0, 1));
    gl!(gl.vertex_binding_divisor(3, 0));

    spec.instance_count = 2;
    spec.base_instance = 1;
    let e = &mut spec.expected_data;
    e[0] = [4.0, 5.0, 6.0, 1.0];
    e[2] = [3.0, 4.0, 0.0, 1.0];
    e[16] = [4.0, 5.0, 6.0, 1.0];
    e[18] = [5.0, 6.0, 0.0, 1.0];
    e[32] = [7.0, 8.0, 9.0, 1.0];
    e[34] = [3.0, 4.0, 0.0, 1.0];
    e[48] = [7.0, 8.0, 9.0, 1.0];
    e[50] = [5.0, 6.0, 0.0, 1.0];
}

fn input_case11(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    input_divisor_state(gl, o, spec, 2, None);
}

fn input_case12(gl: &glw::Functions, o: &Objects, spec: &mut InputSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 12 * 2);
    array_buffer_sub(gl, 0, &[1.0f32, 2.0, 3.0]);
    array_buffer_sub(gl, 12, &[4.0f32, 5.0, 6.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    gl!(gl.vertex_attrib_pointer(1, 3, glw::GL_FLOAT, glw::FALSE, 12, std::ptr::null()));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    gl!(gl.vertex_attrib_format(0, 3, glw::GL_FLOAT, glw::FALSE, 0));
    gl!(gl.vertex_attrib_binding(0, 1));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.enable_vertex_attrib_array(1));

    spec.expected_data[0] = [1.0, 2.0, 3.0, 1.0];
    spec.expected_data[1] = [1.0, 2.0, 3.0, 1.0];
    spec.expected_data[16] = [4.0, 5.0, 6.0, 1.0];
    spec.expected_data[17] = [4.0, 5.0, 6.0, 1.0];
}

// ---------------------------------------------------------------------------------------------------------------------
// 1.3 BasicInputIBase and its cases

type IVec4 = [i32; 4];
type UVec4 = [u32; 4];

struct InputISpec {
    expected_datai: [IVec4; 32],
    expected_dataui: [UVec4; 32],
    instance_count: GLsizei,
    base_instance: GLuint,
}

type InputISetup = fn(&glw::Functions, &Objects, &mut InputISpec);

/// `BasicInputICase1..3`
struct BasicInputI {
    setup: InputISetup,
    po: GLuint,
    xfbo: GLuint,
    objects: Objects,
}

impl Subcase for BasicInputI {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.po = 0;
        gl!(gl.gen_buffers(1, &mut self.xfbo));
        gl!(gl.gen_vertex_arrays(1, &mut self.objects.vao));
        gl!(gl.gen_buffers(2, self.objects.vbo.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.po));
        gl!(gl.delete_buffers(1, &self.xfbo));
        gl!(gl.delete_vertex_arrays(1, &self.objects.vao));
        gl!(gl.delete_buffers(2, self.objects.vbo.as_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut spec = InputISpec {
            expected_datai: [[0; 4]; 32],
            expected_dataui: [[0; 4]; 32],
            instance_count: 1,
            base_instance: 0,
        };

        for i in 0..8 {
            gl!(gl.vertex_attrib_i_4i(i, 0, 0, 0, 0));
            gl!(gl.vertex_attrib_i_4ui(i + 8, 0, 0, 0, 0));
        }
        (self.setup)(gl, &self.objects, &mut spec);

        // BasicInputIBase::Run
        let glsl_vs = "#version 430 core\nlayout(location = 0) in ivec4 vs_in_attribi[8];\nlayout(location = 8) in uvec4 vs_in_attribui[8];\nout StageData {\n  ivec4 attribi[8];\n  uvec4 attribui[8];\n} vs_out;\nvoid main() {\n  for (int i = 0; i < vs_in_attribi.length(); ++i) {\n    vs_out.attribi[i] = vs_in_attribi[i];\n  }\n  for (int i = 0; i < vs_in_attribui.length(); ++i) {\n    vs_out.attribui[i] = vs_in_attribui[i];\n  }\n}";
        let mut varyings = varying_names("attribi", 8);
        varyings.extend(varying_names("attribui", 8));
        let (po, linked) = transform_feedback_program(gl, glsl_vs, &varyings);
        self.po = po;
        if !linked {
            return Ok(ERROR);
        }

        bind_zeroed_transform_feedback_buffer(gl, self.xfbo, 64 * 16, glw::GL_DYNAMIC_COPY);

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(self.po));
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        gl!(gl.draw_arrays_instanced_base_instance(glw::GL_POINTS, 0, 2, spec.instance_count, spec.base_instance));
        gl!(gl.end_transform_feedback());

        let mut datai = [[0i32; 4]; 32];
        let mut dataui = [[0u32; 4]; 32];
        for chunk in 0..4 {
            gl!(gl.get_buffer_sub_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                (2 * chunk * 16 * 8) as isize,
                16 * 8,
                datai[chunk * 8..].as_mut_ptr().cast()
            ));
            gl!(gl.get_buffer_sub_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                ((2 * chunk + 1) * 16 * 8) as isize,
                16 * 8,
                dataui[chunk * 8..].as_mut_ptr().cast()
            ));
        }

        for i in 0..32 {
            if spec.expected_datai[i] != datai[i] {
                log::info!(
                    "Datai is: {:?}, datai should be: {:?}, index is: {i}",
                    datai[i],
                    spec.expected_datai[i]
                );
                return Ok(ERROR);
            }
            if spec.expected_dataui[i] != dataui[i] {
                log::info!(
                    "Dataui is: {:?}, dataui should be: {:?}, index is: {i}",
                    dataui[i],
                    spec.expected_dataui[i]
                );
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

fn input_i_case1(gl: &glw::Functions, o: &Objects, spec: &mut InputISpec) {
    const STRIDE: isize = 88;
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, STRIDE * 2);
    array_buffer_sub(gl, 0, &[1i8, -2, 3, -4]);
    array_buffer_sub(gl, 4, &[5i16, -6, 7, -8]);
    array_buffer_sub(gl, 12, &[9i32, -10, 11, -12]);
    array_buffer_sub(gl, 28, &[13u8, 14, 15, 16]);
    array_buffer_sub(gl, 32, &[17u16, 18, 19, 20]);
    array_buffer_sub(gl, 40, &[21u32, 22, 23, 24]);
    array_buffer_sub(gl, 56, &[90i32, -91, 92, -93]);
    array_buffer_sub(gl, 72, &[94u32, 95, 96, 97]);
    array_buffer_sub(gl, STRIDE, &[25i8, -26, 27, -28]);
    array_buffer_sub(gl, 4 + STRIDE, &[29i16, -30, 31, -32]);
    array_buffer_sub(gl, 12 + STRIDE, &[33i32, -34, 35, -36]);
    array_buffer_sub(gl, 28 + STRIDE, &[37u8, 38, 39, 40]);
    array_buffer_sub(gl, 32 + STRIDE, &[41u16, 42, 43, 44]);
    array_buffer_sub(gl, 40 + STRIDE, &[45u32, 46, 47, 48]);
    array_buffer_sub(gl, 56 + STRIDE, &[98i32, -99, 100, -101]);
    array_buffer_sub(gl, 72 + STRIDE, &[102u32, 103, 104, 105]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_i_format(0, 1, glw::GL_BYTE, 0));
    gl!(gl.vertex_attrib_i_format(1, 2, glw::GL_SHORT, 4));
    gl!(gl.vertex_attrib_i_format(2, 3, glw::GL_INT, 12));
    gl!(gl.vertex_attrib_i_format(3, 4, glw::GL_INT, 56));
    gl!(gl.vertex_attrib_i_format(8, 3, glw::GL_UNSIGNED_BYTE, 28));
    gl!(gl.vertex_attrib_i_format(9, 2, glw::GL_UNSIGNED_SHORT, 32));
    gl!(gl.vertex_attrib_i_format(10, 1, glw::GL_UNSIGNED_INT, 40));
    gl!(gl.vertex_attrib_i_format(11, 4, glw::GL_UNSIGNED_INT, 72));
    for attrib in [0, 1, 2, 3, 8, 9, 10, 11] {
        gl!(gl.vertex_attrib_binding(attrib, 0));
    }
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, STRIDE as GLsizei));
    for attrib in [0, 1, 2, 3, 8, 9, 10, 11] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }

    spec.expected_datai[0] = [1, 0, 0, 1];
    spec.expected_datai[1] = [5, -6, 0, 1];
    spec.expected_datai[2] = [9, -10, 11, 1];
    spec.expected_datai[3] = [90, -91, 92, -93];
    spec.expected_dataui[0] = [13, 14, 15, 1];
    spec.expected_dataui[1] = [17, 18, 0, 1];
    spec.expected_dataui[2] = [21, 0, 0, 1];
    spec.expected_dataui[3] = [94, 95, 96, 97];
    spec.expected_datai[8] = [25, 0, 0, 1];
    spec.expected_datai[9] = [29, -30, 0, 1];
    spec.expected_datai[10] = [33, -34, 35, 1];
    spec.expected_datai[11] = [98, -99, 100, -101];
    spec.expected_dataui[8] = [37, 38, 39, 1];
    spec.expected_dataui[9] = [41, 42, 0, 1];
    spec.expected_dataui[10] = [45, 0, 0, 1];
    spec.expected_dataui[11] = [102, 103, 104, 105];
}

fn input_i_case2(gl: &glw::Functions, o: &Objects, spec: &mut InputISpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 12 * 2);
    array_buffer_sub(gl, 0, &[1i32, 2, 3]);
    array_buffer_sub(gl, 12, &[4i32, 5, 6]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[1]));
    array_buffer_alloc(gl, 16);
    array_buffer_sub(gl, 0, &[10u32, 20, 30, 40]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_i_format(0, 3, glw::GL_INT, 0));
    gl!(gl.vertex_attrib_i_format(2, 2, glw::GL_INT, 4));
    gl!(gl.vertex_attrib_i_format(15, 1, glw::GL_UNSIGNED_INT, 0));
    gl!(gl.vertex_attrib_binding(0, 2));
    gl!(gl.vertex_attrib_binding(2, 0));
    gl!(gl.vertex_attrib_binding(15, 7));
    for attrib in [0, 2, 15] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 8));
    gl!(gl.bind_vertex_buffer(2, o.vbo[0], 0, 12));
    gl!(gl.bind_vertex_buffer(7, o.vbo[1], 4, 16));
    gl!(gl.vertex_binding_divisor(0, 1));
    gl!(gl.vertex_binding_divisor(2, 0));
    gl!(gl.vertex_binding_divisor(7, 2));

    spec.instance_count = 2;
    spec.expected_datai[0] = [1, 2, 3, 1];
    spec.expected_datai[2] = [2, 3, 0, 1];
    spec.expected_dataui[7] = [20, 0, 0, 1];
    spec.expected_datai[8] = [4, 5, 6, 1];
    spec.expected_datai[10] = [2, 3, 0, 1];
    spec.expected_dataui[15] = [20, 0, 0, 1];
    spec.expected_datai[16] = [1, 2, 3, 1];
    spec.expected_datai[18] = [4, 5, 0, 1];
    spec.expected_dataui[23] = [20, 0, 0, 1];
    spec.expected_datai[24] = [4, 5, 6, 1];
    spec.expected_datai[26] = [4, 5, 0, 1];
    spec.expected_dataui[31] = [20, 0, 0, 1];
}

fn input_i_case3(gl: &glw::Functions, o: &Objects, spec: &mut InputISpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 12 * 2);
    array_buffer_sub(gl, 0, &[1i32, 2, 3]);
    array_buffer_sub(gl, 12, &[4i32, 5, 6]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    gl!(gl.vertex_attrib_i_pointer(7, 3, glw::GL_INT, 12, std::ptr::null()));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    gl!(gl.vertex_attrib_i_format(0, 2, glw::GL_INT, 4));
    gl!(gl.vertex_attrib_binding(0, 7));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.enable_vertex_attrib_array(7));

    spec.expected_datai[0] = [2, 3, 0, 1];
    spec.expected_datai[7] = [1, 2, 3, 1];
    spec.expected_datai[8] = [5, 6, 0, 1];
    spec.expected_datai[15] = [4, 5, 6, 1];
}

// ---------------------------------------------------------------------------------------------------------------------
// 1.4 BasicInputLBase and its cases

struct InputLSpec {
    expected_data: [DVec4; 32],
    instance_count: GLsizei,
    base_instance: GLuint,
}

type InputLSetup = fn(&glw::Functions, &Objects, &mut InputLSpec);

/// The value `BasicInputLBase` uses for "do not compare this component"
const IGNORED: f64 = 12345.0;

/// `BasicInputLCase1..2`
struct BasicInputL {
    setup: InputLSetup,
    po: GLuint,
    xfbo: GLuint,
    objects: Objects,
}

impl Subcase for BasicInputL {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.po = 0;
        gl!(gl.gen_buffers(1, &mut self.xfbo));
        gl!(gl.gen_vertex_arrays(1, &mut self.objects.vao));
        gl!(gl.gen_buffers(2, self.objects.vbo.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.po));
        gl!(gl.delete_buffers(1, &self.xfbo));
        gl!(gl.delete_vertex_arrays(1, &self.objects.vao));
        gl!(gl.delete_buffers(2, self.objects.vbo.as_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut spec = InputLSpec {
            expected_data: [[0.0; 4]; 32],
            instance_count: 1,
            base_instance: 0,
        };

        for i in 0..8 {
            gl!(gl.vertex_attrib_l_4d(i, 0.0, 0.0, 0.0, 0.0));
        }
        (self.setup)(gl, &self.objects, &mut spec);

        // BasicInputLBase::Run
        let glsl_vs = "#version 430 core\nlayout(location = 0) in dvec4 vs_in_attrib[8];\nout StageData {\n  dvec4 attrib[8];\n} vs_out;\nvoid main() {\n  vs_out.attrib[0] = vs_in_attrib[0];\n  vs_out.attrib[1] = vs_in_attrib[1];\n  vs_out.attrib[2] = vs_in_attrib[2];\n  vs_out.attrib[3] = vs_in_attrib[3];\n  vs_out.attrib[4] = vs_in_attrib[4];\n  vs_out.attrib[5] = vs_in_attrib[5];\n  vs_out.attrib[6] = vs_in_attrib[6];\n  vs_out.attrib[7] = vs_in_attrib[7];\n}";
        let (po, linked) = transform_feedback_program(gl, glsl_vs, &varying_names("attrib", 8));
        self.po = po;
        if !linked {
            return Ok(ERROR);
        }

        bind_zeroed_transform_feedback_buffer(
            gl,
            self.xfbo,
            std::mem::size_of_val(&spec.expected_data),
            glw::GL_DYNAMIC_COPY,
        );

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(self.po));
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        gl!(gl.draw_arrays_instanced_base_instance(glw::GL_POINTS, 0, 2, spec.instance_count, spec.base_instance));
        gl!(gl.end_transform_feedback());

        let mut data = [[0f64; 4]; 32];
        gl!(gl.get_buffer_sub_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            std::mem::size_of_val(&data) as isize,
            data.as_mut_ptr().cast()
        ));

        for i in 0..32 {
            for j in 0..4 {
                if spec.expected_data[i][j] != IGNORED && spec.expected_data[i][j] != data[i][j] {
                    log::info!(
                        "Data is: {:?}, data should be: {:?}, index is: {i}",
                        data[i],
                        spec.expected_data[i]
                    );
                    return Ok(ERROR);
                }
            }
        }
        Ok(NO_ERROR)
    }
}

fn input_l_case1(gl: &glw::Functions, o: &Objects, spec: &mut InputLSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 32 * 3);
    array_buffer_sub(gl, 0, &[1.0f64, 2.0, 3.0, 4.0]);
    array_buffer_sub(gl, 32, &[5.0f64, 6.0, 7.0, 8.0]);
    array_buffer_sub(gl, 64, &[9.0f64, 10.0, 11.0, 12.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_l_format(0, 4, glw::GL_DOUBLE, 0));
    gl!(gl.vertex_attrib_l_format(3, 3, glw::GL_DOUBLE, 8));
    gl!(gl.vertex_attrib_l_format(5, 2, glw::GL_DOUBLE, 0));
    gl!(gl.vertex_attrib_l_format(7, 1, glw::GL_DOUBLE, 24));
    gl!(gl.vertex_attrib_binding(0, 0));
    gl!(gl.vertex_attrib_binding(3, 2));
    gl!(gl.vertex_attrib_binding(5, 0));
    gl!(gl.vertex_attrib_binding(7, 6));
    for attrib in [0, 3, 5, 7] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 32));
    gl!(gl.bind_vertex_buffer(2, o.vbo[0], 0, 16));
    gl!(gl.bind_vertex_buffer(6, o.vbo[0], 16, 0));

    let e = &mut spec.expected_data;
    e[0] = [1.0, 2.0, 3.0, 4.0];
    e[3] = [2.0, 3.0, 4.0, IGNORED];
    e[5] = [1.0, 2.0, IGNORED, IGNORED];
    e[7] = [6.0, IGNORED, IGNORED, IGNORED];
    e[8] = [5.0, 6.0, 7.0, 8.0];
    e[11] = [4.0, 5.0, 6.0, IGNORED];
    e[13] = [5.0, 6.0, IGNORED, IGNORED];
    e[15] = [6.0, IGNORED, IGNORED, IGNORED];
}

fn input_l_case2(gl: &glw::Functions, o: &Objects, spec: &mut InputLSpec) {
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[0]));
    array_buffer_alloc(gl, 32 * 3);
    array_buffer_sub(gl, 0, &[1.0f64, 2.0, 3.0, 4.0]);
    array_buffer_sub(gl, 32, &[5.0f64, 6.0, 7.0, 8.0]);
    array_buffer_sub(gl, 64, &[9.0f64, 10.0, 11.0, 12.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, o.vbo[1]));
    array_buffer_alloc(gl, 32 * 3);
    array_buffer_sub(gl, 0, &[10.0f64, 20.0, 30.0, 40.0]);
    array_buffer_sub(gl, 32, &[50.0f64, 60.0, 70.0, 80.0]);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.bind_vertex_array(o.vao));
    gl!(gl.vertex_attrib_l_format(0, 4, glw::GL_DOUBLE, 0));
    gl!(gl.vertex_attrib_l_format(2, 4, glw::GL_DOUBLE, 0));
    gl!(gl.vertex_attrib_l_format(4, 2, glw::GL_DOUBLE, 8));
    gl!(gl.vertex_attrib_binding(0, 0));
    gl!(gl.vertex_attrib_binding(2, 1));
    gl!(gl.vertex_attrib_binding(4, 2));
    for attrib in [0, 2, 4] {
        gl!(gl.enable_vertex_attrib_array(attrib));
    }
    gl!(gl.bind_vertex_buffer(0, o.vbo[0], 0, 32));
    gl!(gl.bind_vertex_buffer(1, o.vbo[0], 0, 32));
    gl!(gl.bind_vertex_buffer(2, o.vbo[1], 8, 16));
    gl!(gl.vertex_binding_divisor(1, 1));

    spec.instance_count = 2;
    let e = &mut spec.expected_data;
    e[0] = [1.0, 2.0, 3.0, 4.0];
    e[2] = [1.0, 2.0, 3.0, 4.0];
    e[4] = [30.0, 40.0, IGNORED, IGNORED];
    e[8] = [5.0, 6.0, 7.0, 8.0];
    e[10] = [1.0, 2.0, 3.0, 4.0];
    e[12] = [50.0, 60.0, IGNORED, IGNORED];
    e[16] = [1.0, 2.0, 3.0, 4.0];
    e[18] = [5.0, 6.0, 7.0, 8.0];
    e[20] = [30.0, 40.0, IGNORED, IGNORED];
    e[24] = [5.0, 6.0, 7.0, 8.0];
    e[26] = [5.0, 6.0, 7.0, 8.0];
    e[28] = [50.0, 60.0, IGNORED, IGNORED];
}

// ---------------------------------------------------------------------------------------------------------------------
// 1.5 BasicState1..4

/// `glGetVertexAttribiv`
fn get_attrib(gl: &glw::Functions, index: GLuint, pname: GLenum) -> GLint {
    let mut p: GLint = 0;
    gl!(gl.get_vertex_attribiv(index, pname, &mut p));
    p
}

/// `glGetIntegeri_v`
fn get_indexed(gl: &glw::Functions, pname: GLenum, index: GLuint) -> GLint {
    let mut p: GLint = 0;
    gl!(gl.get_integeri_v(pname, index, &mut p));
    p
}

/// `glGetInteger64i_v`
fn get_indexed_64(gl: &glw::Functions, pname: GLenum, index: GLuint) -> i64 {
    let mut p: i64 = 0;
    gl!(gl.get_integer_64i_v(pname, index, &mut p));
    p
}

/// One state query compared with what the case expects; logs the mismatch
fn expect_eq<T: PartialEq + std::fmt::Display>(
    label: &str,
    index: impl std::fmt::Display,
    actual: T,
    expected: T,
) -> bool {
    if actual != expected {
        log::info!("{label}({index}) is {actual} should be {expected}.");
        return false;
    }
    true
}

/// `VertexAttribState`
#[derive(Clone, Copy)]
struct VertexAttribState {
    array_enabled: GLint,
    array_size: GLint,
    array_stride: GLint,
    array_type: GLenum,
    array_normalized: GLint,
    array_integer: GLint,
    array_long: GLint,
    array_divisor: GLint,
    array_pointer: usize,
    array_buffer_binding: GLint,
    binding: GLint,
    relative_offset: GLint,
    index: GLuint,
}

impl VertexAttribState {
    fn new(attribindex: GLuint) -> Self {
        Self {
            array_enabled: 0,
            array_size: 4,
            array_stride: 0,
            array_type: glw::GL_FLOAT,
            array_normalized: 0,
            array_integer: 0,
            array_long: 0,
            array_divisor: 0,
            array_pointer: 0,
            array_buffer_binding: 0,
            binding: attribindex as GLint,
            relative_offset: 0,
            index: attribindex,
        }
    }

    fn state_verify(&self, gl: &glw::Functions) -> bool {
        let i = self.index;
        let mut status = true;

        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_ENABLED",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED),
            self.array_enabled,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_SIZE",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_SIZE),
            self.array_size,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_STRIDE",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE),
            self.array_stride,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_TYPE",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_TYPE),
            self.array_type as GLint,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_NORMALIZED",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED),
            self.array_normalized,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_INTEGER",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER),
            self.array_integer,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_LONG",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_LONG),
            self.array_long,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_DIVISOR",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR),
            self.array_divisor,
        );

        let mut pointer: *mut std::ffi::c_void = std::ptr::null_mut();
        gl!(gl.get_vertex_attrib_pointerv(i, glw::GL_VERTEX_ATTRIB_ARRAY_POINTER, &mut pointer));
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_POINTER",
            i,
            pointer as usize,
            self.array_pointer,
        );

        status &= expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING),
            self.array_buffer_binding,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_BINDING",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_BINDING),
            self.binding,
        );
        status &= expect_eq(
            "GL_VERTEX_ATTRIB_RELATIVE_OFFSET",
            i,
            get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET),
            self.relative_offset,
        );
        status
    }
}

/// `VertexBindingState`
#[derive(Clone, Copy)]
struct VertexBindingState {
    buffer: GLint,
    offset: i64,
    stride: GLint,
    divisor: GLint,
    index: GLuint,
}

impl VertexBindingState {
    fn new(bindingindex: GLuint) -> Self {
        Self {
            buffer: 0,
            offset: 0,
            stride: 16,
            divisor: 0,
            index: bindingindex,
        }
    }

    fn state_verify(&self, gl: &glw::Functions) -> bool {
        let i = self.index;
        let mut status = true;

        status &= expect_eq(
            "GL_VERTEX_BINDING_BUFFER",
            i,
            get_indexed(gl, glw::GL_VERTEX_BINDING_BUFFER, i),
            self.buffer,
        );
        status &= expect_eq(
            "GL_VERTEX_BINDING_OFFSET",
            i,
            get_indexed_64(gl, glw::GL_VERTEX_BINDING_OFFSET, i),
            self.offset,
        );
        status &= expect_eq(
            "GL_VERTEX_BINDING_STRIDE",
            i,
            get_indexed(gl, glw::GL_VERTEX_BINDING_STRIDE, i),
            self.stride,
        );
        status &= expect_eq(
            "GL_VERTEX_BINDING_DIVISOR",
            i,
            get_indexed(gl, glw::GL_VERTEX_BINDING_DIVISOR, i),
            self.divisor,
        );
        status
    }
}

/// `glGetIntegerv` into a local
fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut p: GLint = 0;
    gl!(gl.get_integerv(pname, &mut p));
    p
}

#[derive(Default)]
struct BasicState1 {
    vao: GLuint,
    vbo: [GLuint; 2],
}

impl Subcase for BasicState1 {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_buffers(2, self.vbo.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(2, self.vbo.as_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo[0]));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 1000, std::ptr::null(), glw::GL_DYNAMIC_COPY));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo[1]));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 1000, std::ptr::null(), glw::GL_DYNAMIC_COPY));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);
        if p < 16 {
            log::info!("GL_MAX_VERTEX_ATTRIB_BINDINGS is {p} but must be at least 16.");
            return Ok(ERROR);
        }
        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET);
        if p < 2047 {
            log::info!("GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET is {p} but must be at least 2047.");
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_array(self.vao));

        // check default state
        for i in 0..16u32 {
            if !expect_eq(
                "GL_VERTEX_ATTRIB_BINDING",
                i,
                get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_BINDING),
                i as GLint,
            ) || !expect_eq(
                "GL_VERTEX_ATTRIB_RELATIVE_OFFSET",
                i,
                get_attrib(gl, i, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET),
                0,
            ) || !expect_eq(
                "GL_VERTEX_BINDING_OFFSET",
                i,
                get_indexed_64(gl, glw::GL_VERTEX_BINDING_OFFSET, i),
                0,
            ) || !expect_eq(
                "GL_VERTEX_BINDING_STRIDE",
                i,
                get_indexed(gl, glw::GL_VERTEX_BINDING_STRIDE, i),
                16,
            ) {
                return Ok(ERROR);
            }
        }

        gl!(gl.vertex_attrib_format(0, 2, glw::GL_BYTE, glw::TRUE, 16));
        if !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_SIZE",
            0,
            get_attrib(gl, 0, glw::GL_VERTEX_ATTRIB_ARRAY_SIZE),
            2,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_TYPE",
            0,
            get_attrib(gl, 0, glw::GL_VERTEX_ATTRIB_ARRAY_TYPE),
            glw::GL_BYTE as GLint,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_NORMALIZED",
            0,
            get_attrib(gl, 0, glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED),
            glw::GL_TRUE as GLint,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_RELATIVE_OFFSET",
            0,
            get_attrib(gl, 0, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET),
            16,
        ) {
            return Ok(ERROR);
        }

        gl!(gl.vertex_attrib_i_format(2, 3, glw::GL_INT, 512));
        if !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_SIZE",
            2,
            get_attrib(gl, 2, glw::GL_VERTEX_ATTRIB_ARRAY_SIZE),
            3,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_TYPE",
            2,
            get_attrib(gl, 2, glw::GL_VERTEX_ATTRIB_ARRAY_TYPE),
            glw::GL_INT as GLint,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_RELATIVE_OFFSET",
            2,
            get_attrib(gl, 2, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET),
            512,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_INTEGER",
            2,
            get_attrib(gl, 2, glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER),
            glw::GL_TRUE as GLint,
        ) {
            return Ok(ERROR);
        }

        gl!(gl.vertex_attrib_l_format(15, 1, glw::GL_DOUBLE, 1024));
        if !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_SIZE",
            15,
            get_attrib(gl, 15, glw::GL_VERTEX_ATTRIB_ARRAY_SIZE),
            1,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_TYPE",
            15,
            get_attrib(gl, 15, glw::GL_VERTEX_ATTRIB_ARRAY_TYPE),
            glw::GL_DOUBLE as GLint,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_RELATIVE_OFFSET",
            15,
            get_attrib(gl, 15, glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET),
            1024,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_LONG",
            15,
            get_attrib(gl, 15, glw::GL_VERTEX_ATTRIB_ARRAY_LONG),
            glw::GL_TRUE as GLint,
        ) {
            return Ok(ERROR);
        }

        for (attrib, binding) in [(0, 7), (3, 7), (9, 0), (15, 1), (15, 15)] {
            gl!(gl.vertex_attrib_binding(attrib, binding));
            if get_attrib(gl, attrib, glw::GL_VERTEX_ATTRIB_BINDING) != binding as GLint {
                return Ok(ERROR);
            }
        }

        gl!(gl.bind_vertex_buffer(0, self.vbo[0], 1024, 128));
        if !expect_eq(
            "GL_VERTEX_BINDING_OFFSET",
            0,
            get_indexed_64(gl, glw::GL_VERTEX_BINDING_OFFSET, 0),
            1024,
        ) || !expect_eq(
            "GL_VERTEX_BINDING_STRIDE",
            0,
            get_indexed(gl, glw::GL_VERTEX_BINDING_STRIDE, 0),
            128,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_STRIDE",
            0,
            get_attrib(gl, 0, glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE),
            0,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING",
            0,
            get_attrib(gl, 0, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING),
            0,
        ) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_buffer(15, self.vbo[1], 16, 32));
        if !expect_eq(
            "GL_VERTEX_BINDING_OFFSET",
            15,
            get_indexed_64(gl, glw::GL_VERTEX_BINDING_OFFSET, 15),
            16,
        ) || !expect_eq(
            "GL_VERTEX_BINDING_STRIDE",
            15,
            get_indexed(gl, glw::GL_VERTEX_BINDING_STRIDE, 15),
            32,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_STRIDE",
            15,
            get_attrib(gl, 15, glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE),
            0,
        ) || !expect_eq(
            "GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING",
            15,
            get_attrib(gl, 15, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING),
            self.vbo[1] as GLint,
        ) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct BasicState2 {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicState2 {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_buffers(1, &mut self.vbo));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.bind_vertex_array(self.vao));

        for i in 0..16u32 {
            let mut p: GLint = 0;
            gl!(gl.get_integeri_v(glw::GL_VERTEX_BINDING_DIVISOR, i, &mut p));
            if gl!(gl.get_error()) != glw::GL_NO_ERROR {
                log::info!("glGetIntegeri_v(GL_VERTEX_BINDING_DIVISOR, ...) command generates error.");
                return Ok(ERROR);
            }
            if p != 0 {
                log::info!("GL_VERTEX_BINDING_DIVISOR({i}) is {p} should be 0.");
                return Ok(ERROR);
            }
        }

        gl!(gl.vertex_binding_divisor(1, 2));
        if get_indexed(gl, glw::GL_VERTEX_BINDING_DIVISOR, 1) != 2 {
            log::info!("GL_VERTEX_ATTRIB_ARRAY_DIVISOR(1) is %d should be 2.");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct BasicState3 {
    vao: GLuint,
    vbo: [GLuint; 3],
}

impl Subcase for BasicState3 {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_buffers(3, self.vbo.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(3, self.vbo.as_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut status = true;
        let vbo = self.vbo.map(|name| name as GLint);

        for name in self.vbo {
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, name));
            gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 10000, std::ptr::null(), glw::GL_DYNAMIC_COPY));
        }
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);
        if p < 16 {
            log::info!("GL_MAX_VERTEX_ATTRIB_BINDINGS is %d but must be at least 16.");
            status = false;
        }
        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET);
        if p < 2047 {
            log::info!("GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET is {p} but must be at least 2047.");
            status = false;
        }
        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_STRIDE);
        if p < 2048 {
            log::info!("GL_MAX_VERTEX_ATTRIB_STRIDE is {p} but must be at least 2048.");
            status = false;
        }

        gl!(gl.bind_vertex_array(self.vao));
        let p = get_integer(gl, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING);
        if p != 0 {
            log::info!("GL_ELEMENT_ARRAY_BUFFER_BINDING is {p} should be 0.");
            status = false;
        }

        for i in 0..16 {
            if !VertexAttribState::new(i).state_verify(gl) {
                status = false;
            }
        }
        for i in 0..16 {
            if !VertexBindingState::new(i).state_verify(gl) {
                status = false;
            }
        }
        if !status {
            log::info!("Default state check failed.");
            status = false;
        }

        let mut va0 = VertexAttribState::new(0);
        va0.array_size = 2;
        va0.array_type = glw::GL_BYTE;
        va0.array_normalized = 1;
        va0.relative_offset = 16;
        let mut vb0 = VertexBindingState::new(0);
        gl!(gl.vertex_attrib_format(0, 2, glw::GL_BYTE, glw::TRUE, 16));
        if !va0.state_verify(gl) || !vb0.state_verify(gl) {
            log::info!("glVertexAttribFormat state change check failed.");
            status = false;
        }

        let mut va2 = VertexAttribState::new(2);
        va2.array_size = 3;
        va2.array_type = glw::GL_DOUBLE;
        va2.array_long = 1;
        va2.relative_offset = 512;
        let mut vb2 = VertexBindingState::new(2);
        gl!(gl.vertex_attrib_l_format(2, 3, glw::GL_DOUBLE, 512));
        if !va2.state_verify(gl) || !vb2.state_verify(gl) {
            log::info!("glVertexAttribIFormat state change check failed.");
            status = false;
        }

        va0.array_buffer_binding = vbo[0];
        vb0.buffer = vbo[0];
        vb0.offset = 2048;
        vb0.stride = 128;
        gl!(gl.bind_vertex_buffer(0, self.vbo[0], 2048, 128));
        if !va0.state_verify(gl) || !vb0.state_verify(gl) {
            log::info!("glBindVertexBuffer state change check failed.");
            status = false;
        }

        va2.array_buffer_binding = vbo[2];
        vb2.buffer = vbo[2];
        vb2.offset = 64;
        vb2.stride = 256;
        gl!(gl.bind_vertex_buffer(2, self.vbo[2], 64, 256));
        if !va2.state_verify(gl) || !vb2.state_verify(gl) {
            log::info!("glBindVertexBuffer state change check failed.");
            status = false;
        }

        gl!(gl.vertex_attrib_binding(2, 0));
        va2.binding = 0;
        va2.array_buffer_binding = vbo[0];
        if !va0.state_verify(gl) || !vb0.state_verify(gl) || !va2.state_verify(gl) || !vb2.state_verify(gl) {
            log::info!("glVertexAttribBinding state change check failed.");
            status = false;
        }

        let mut va15 = VertexAttribState::new(15);
        let mut vb15 = VertexBindingState::new(15);
        gl!(gl.vertex_attrib_binding(0, 15));
        va0.binding = 15;
        va0.array_buffer_binding = 0;
        if !va0.state_verify(gl) || !vb0.state_verify(gl) || !va15.state_verify(gl) || !vb15.state_verify(gl) {
            log::info!("glVertexAttribBinding state change check failed.");
            status = false;
        }

        gl!(gl.bind_vertex_buffer(15, self.vbo[1], 16, 32));
        va0.array_buffer_binding = vbo[1];
        va15.array_buffer_binding = vbo[1];
        vb15.buffer = vbo[1];
        vb15.offset = 16;
        vb15.stride = 32;
        if !va0.state_verify(gl) || !vb0.state_verify(gl) || !va15.state_verify(gl) || !vb15.state_verify(gl) {
            log::info!("glBindVertexBuffer state change check failed.");
            status = false;
        }

        gl!(gl.vertex_attrib_l_format(15, 1, glw::GL_DOUBLE, 1024));
        va15.array_size = 1;
        va15.array_long = 1;
        va15.array_type = glw::GL_DOUBLE;
        va15.relative_offset = 1024;
        if !va0.state_verify(gl)
            || !vb0.state_verify(gl)
            || !va2.state_verify(gl)
            || !vb2.state_verify(gl)
            || !va15.state_verify(gl)
            || !vb15.state_verify(gl)
        {
            log::info!("glVertexAttribFormat state change check failed.");
            status = false;
        }

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo[2]));
        gl!(gl.vertex_attrib_pointer(
            0,
            4,
            glw::GL_UNSIGNED_BYTE,
            glw::FALSE,
            8,
            640usize as *const std::ffi::c_void
        ));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        va0.array_size = 4;
        va0.array_type = glw::GL_UNSIGNED_BYTE;
        va0.array_stride = 8;
        va0.array_pointer = 640;
        va0.relative_offset = 0;
        va0.array_normalized = 0;
        va0.binding = 0;
        va0.array_buffer_binding = vbo[2];
        vb0.buffer = vbo[2];
        vb0.offset = 640;
        vb0.stride = 8;
        va2.array_buffer_binding = vbo[2];
        if !va0.state_verify(gl)
            || !vb0.state_verify(gl)
            || !va2.state_verify(gl)
            || !vb2.state_verify(gl)
            || !va15.state_verify(gl)
            || !vb15.state_verify(gl)
        {
            log::info!("glVertexAttribPointer state change check failed.");
            status = false;
        }

        gl!(gl.bind_vertex_buffer(0, self.vbo[1], 80, 24));
        vb0.buffer = vbo[1];
        vb0.offset = 80;
        vb0.stride = 24;
        va2.array_buffer_binding = vbo[1];
        va0.array_buffer_binding = vbo[1];
        if !va0.state_verify(gl)
            || !vb0.state_verify(gl)
            || !va2.state_verify(gl)
            || !vb2.state_verify(gl)
            || !va15.state_verify(gl)
            || !vb15.state_verify(gl)
        {
            log::info!("glBindVertexBuffer state change check failed.");
            status = false;
        }

        Ok(if status { NO_ERROR } else { ERROR })
    }
}

#[derive(Default)]
struct BasicState4 {
    vao: GLuint,
}

impl Subcase for BasicState4 {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().gen_vertex_arrays(1, &mut self.vao));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut status = true;

        gl!(gl.bind_vertex_array(self.vao));

        for i in 0..16u32 {
            let mut va = VertexAttribState::new(i);
            let mut vb = VertexBindingState::new(i);
            gl!(gl.vertex_attrib_divisor(i, i + 7));
            va.array_divisor = (i + 7) as GLint;
            vb.divisor = (i + 7) as GLint;
            if !va.state_verify(gl) || !vb.state_verify(gl) {
                log::info!("glVertexAttribDivisor state change check failed.");
                status = false;
            }
        }

        for i in 0..16u32 {
            let mut va = VertexAttribState::new(i);
            let mut vb = VertexBindingState::new(i);
            gl!(gl.vertex_binding_divisor(i, i));
            va.array_divisor = i as GLint;
            vb.divisor = i as GLint;
            if !va.state_verify(gl) || !vb.state_verify(gl) {
                log::info!("glVertexBindingDivisor state change check failed.");
                status = false;
            }
        }

        gl!(gl.vertex_attrib_binding(2, 5));
        let mut va5 = VertexAttribState::new(5);
        va5.array_divisor = 5;
        let mut vb5 = VertexBindingState::new(5);
        vb5.divisor = 5;
        let mut va2 = VertexAttribState::new(2);
        va2.array_divisor = 5;
        let mut vb2 = VertexBindingState::new(2);
        vb2.divisor = 2;
        va2.binding = 5;
        if !va5.state_verify(gl) || !vb5.state_verify(gl) || !va2.state_verify(gl) || !vb2.state_verify(gl) {
            log::info!("glVertexAttribBinding state change check failed.");
            status = false;
        }

        gl!(gl.vertex_attrib_divisor(2, 23));
        va2.binding = 2;
        va2.array_divisor = 23;
        vb2.divisor = 23;
        if !va5.state_verify(gl) || !vb5.state_verify(gl) || !va2.state_verify(gl) || !vb2.state_verify(gl) {
            log::info!("glVertexAttribDivisor state change check failed.");
            status = false;
        }

        Ok(if status { NO_ERROR } else { ERROR })
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// 2 Advanced

/// `glCreateShaderProgramv` over several NUL-terminated sources
fn create_shader_program(gl: &glw::Functions, shader_type: GLenum, sources: &[&str]) -> GLuint {
    let c_sources: Vec<std::ffi::CString> = sources
        .iter()
        .map(|s| std::ffi::CString::new(*s).expect("shader sources have no NUL"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = c_sources.iter().map(|s| s.as_ptr()).collect();
    gl!(gl.create_shader_programv(shader_type, pointers.len() as GLsizei, pointers.as_ptr()))
}

fn push_f32(bytes: &mut [u8], offset: usize, values: &[f32]) {
    for (i, v) in values.iter().enumerate() {
        bytes[offset + 4 * i..offset + 4 * i + 4].copy_from_slice(&v.to_ne_bytes());
    }
}

fn push_i32(bytes: &mut [u8], offset: usize, values: &[i32]) {
    for (i, v) in values.iter().enumerate() {
        bytes[offset + 4 * i..offset + 4 * i + 4].copy_from_slice(&v.to_ne_bytes());
    }
}

fn push_u32(bytes: &mut [u8], offset: usize, values: &[u32]) {
    for (i, v) in values.iter().enumerate() {
        bytes[offset + 4 * i..offset + 4 * i + 4].copy_from_slice(&v.to_ne_bytes());
    }
}

fn push_f64(bytes: &mut [u8], offset: usize, values: &[f64]) {
    for (i, v) in values.iter().enumerate() {
        bytes[offset + 8 * i..offset + 8 * i + 8].copy_from_slice(&v.to_ne_bytes());
    }
}

/// `glDrawElementsInstancedBaseVertexBaseInstance(GL_TRIANGLE_STRIP, 4, type, offset, 1, base_vertex, base_instance)`
fn draw_strip(gl: &glw::Functions, index_type: GLenum, byte_offset: usize, base_vertex: GLint, base_instance: GLuint) {
    gl!(gl.draw_elements_instanced_base_vertex_base_instance(
        glw::GL_TRIANGLE_STRIP,
        4,
        index_type,
        byte_offset as *const std::ffi::c_void,
        1,
        base_vertex,
        base_instance
    ));
}

#[derive(Default)]
struct AdvancedBindingUpdate {
    vao: [GLuint; 2],
    vbo: [GLuint; 2],
    ebo: [GLuint; 2],
    vsp: GLuint,
    fsp: GLuint,
    ppo: GLuint,
}

impl Subcase for AdvancedBindingUpdate {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_vertex_arrays(2, self.vao.as_mut_ptr()));
        gl!(gl.gen_buffers(2, self.vbo.as_mut_ptr()));
        gl!(gl.gen_buffers(2, self.ebo.as_mut_ptr()));
        self.vsp = 0;
        self.fsp = 0;
        gl!(gl.gen_program_pipelines(1, &mut self.ppo));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_vertex_arrays(2, self.vao.as_ptr()));
        gl!(gl.delete_buffers(2, self.vbo.as_ptr()));
        gl!(gl.delete_buffers(2, self.ebo.as_ptr()));
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program(self.fsp));
        gl!(gl.delete_program_pipelines(1, &self.ppo));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "#version 430 core\nlayout(location = 0) in vec4 vs_in_position;\nlayout(location = 1) in vec2 vs_in_color_rg;\nlayout(location = 2) in float vs_in_color_b;\nlayout(location = 3) in dvec3 vs_in_data0;\nlayout(location = 4) in ivec2 vs_in_data1;\nout StageData {\n  vec2 color_rg;\n  float color_b;\n  dvec3 data0;\n  ivec2 data1;\n} vs_out;\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nvoid main() {\n  vs_out.data1 = vs_in_data1;\n  vs_out.data0 = vs_in_data0;\n  vs_out.color_b = vs_in_color_b;\n  vs_out.color_rg = vs_in_color_rg;\n  gl_Position = vs_in_position;\n}";
        let glsl_fs = "#version 430 core\nin StageData {\n  vec2 color_rg;\n  float color_b;\n  flat dvec3 data0;\n  flat ivec2 data1;\n} fs_in;\nlayout(location = 0) out vec4 fs_out_color;\nuniform dvec3 g_expected_data0;\nuniform ivec2 g_expected_data1;\nvoid main() {\n  fs_out_color = vec4(fs_in.color_rg, fs_in.color_b, 1);\n  if (fs_in.data0 != g_expected_data0) fs_out_color = vec4(1);\n  if (fs_in.data1 != g_expected_data1) fs_out_color = vec4(1);\n}";

        self.vsp = create_shader_program(gl, glw::GL_VERTEX_SHADER, &[glsl_vs]);
        self.fsp = create_shader_program(gl, glw::GL_FRAGMENT_SHADER, &[glsl_fs]);
        if !check_program(gl, self.vsp) || !check_program(gl, self.fsp) {
            return Ok(ERROR);
        }

        gl!(gl.use_program_stages(self.ppo, glw::GL_VERTEX_SHADER_BIT, self.vsp));
        gl!(gl.use_program_stages(self.ppo, glw::GL_FRAGMENT_SHADER_BIT, self.fsp));

        const STRIDE: [usize; 2] = [52, 62];
        const OFFSET: [usize; 2] = [0, 8];

        // vertex positions, then colour_rg, colour_b, data0 and data1 per vertex
        let vertex_sets: [([[f32; 2]; 4], [f32; 2], f32, [f64; 3], [i32; 2]); 2] = [
            (
                [[-1.0, -1.0], [1.0, -1.0], [1.0, 1.0], [-1.0, 1.0]],
                [0.0, 1.0],
                0.0,
                [1.0, 2.0, 3.0],
                [1, 2],
            ),
            (
                [[-1.0, 1.0], [1.0, 1.0], [1.0, -1.0], [-1.0, -1.0]],
                [0.0, 0.0],
                1.0,
                [4.0, 5.0, 6.0],
                [3, 4],
            ),
        ];
        for (n, (positions, color_rg, color_b, data0, data1)) in vertex_sets.iter().enumerate() {
            let mut bytes = vec![0u8; OFFSET[n] + 4 * STRIDE[n]];
            for i in 0..4 {
                let base = OFFSET[n] + i * STRIDE[n];
                push_f32(&mut bytes, base, &positions[i]);
                push_f32(&mut bytes, base + 8, color_rg);
                push_f32(&mut bytes, base + 16, &[*color_b]);
                push_f64(&mut bytes, base + 20, data0);
                push_i32(&mut bytes, base + 44, data1);
            }
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo[n]));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                bytes.len() as isize,
                bytes.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo[0]));
        {
            let data: [u16; 4] = [0, 1, 3, 2];
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo[1]));
        {
            let data: [u32; 4] = [3, 2, 0, 1];
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
        }
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));

        gl!(gl.bind_vertex_array(self.vao[0]));
        gl!(gl.vertex_attrib_format(0, 2, glw::GL_FLOAT, glw::FALSE, 0));
        gl!(gl.vertex_attrib_format(1, 2, glw::GL_FLOAT, glw::FALSE, 8));
        gl!(gl.vertex_attrib_format(2, 1, glw::GL_FLOAT, glw::FALSE, 16));
        gl!(gl.vertex_attrib_l_format(3, 3, glw::GL_DOUBLE, 20));
        gl!(gl.vertex_attrib_i_format(4, 2, glw::GL_INT, 44));
        for i in 0..5 {
            gl!(gl.vertex_attrib_binding(i, 0));
            gl!(gl.enable_vertex_attrib_array(i));
        }

        gl!(gl.bind_vertex_array(self.vao[1]));
        gl!(gl.vertex_attrib_format(0, 2, glw::GL_FLOAT, glw::FALSE, 0));
        gl!(gl.vertex_attrib_format(1, 2, glw::GL_FLOAT, glw::FALSE, 8));
        gl!(gl.vertex_attrib_format(2, 1, glw::GL_FLOAT, glw::FALSE, 16));
        gl!(gl.vertex_attrib_l_format(3, 3, glw::GL_DOUBLE, 20));
        gl!(gl.vertex_attrib_i_format(4, 2, glw::GL_INT, 44));
        for (attrib, binding) in [(0, 1), (1, 8), (2, 1), (3, 1), (4, 8)] {
            gl!(gl.vertex_attrib_binding(attrib, binding));
        }
        for attrib in 0..5 {
            gl!(gl.enable_vertex_attrib_array(attrib));
        }
        gl!(gl.bind_vertex_buffer(1, self.vbo[1], OFFSET[1] as isize, STRIDE[1] as GLsizei));
        gl!(gl.bind_vertex_buffer(8, self.vbo[0], OFFSET[0] as isize, STRIDE[0] as GLsizei));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.ebo[1]));
        gl!(gl.bind_vertex_array(0));

        let set_expected = |data0: [f64; 3], data1: [i32; 2]| {
            let location0 = gl!(gl.get_uniform_location(self.fsp, c"g_expected_data0".as_ptr()));
            gl!(gl.program_uniform_3d(self.fsp, location0, data0[0], data0[1], data0[2]));
            let location1 = gl!(gl.get_uniform_location(self.fsp, c"g_expected_data1".as_ptr()));
            gl!(gl.program_uniform_2i(self.fsp, location1, data1[0], data1[1]));
        };
        let (vbo, ebo, vao) = (self.vbo, self.ebo, self.vao);

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.bind_program_pipeline(self.ppo));
        gl!(gl.bind_vertex_array(vao[0]));
        set_expected([1.0, 2.0, 3.0], [1, 2]);
        gl!(gl.bind_vertex_buffer(0, vbo[0], OFFSET[0] as isize, STRIDE[0] as GLsizei));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo[0]));
        draw_strip(gl, glw::GL_UNSIGNED_SHORT, 0, 0, 0);
        if !check_window_color(context, [0.0, 1.0, 0.0]) {
            return Ok(ERROR);
        }

        set_expected([4.0, 5.0, 6.0], [3, 4]);
        gl!(gl.bind_vertex_buffer(0, vbo[1], OFFSET[1] as isize, STRIDE[1] as GLsizei));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo[1]));
        draw_strip(gl, glw::GL_UNSIGNED_INT, 0, 0, 0);
        if !check_window_color(context, [0.0, 0.0, 1.0]) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_buffer(0, 0, 0, 0));
        set_expected([1.0, 2.0, 3.0], [1, 2]);
        for i in 0..5 {
            gl!(gl.vertex_attrib_binding(i, 15));
        }
        gl!(gl.bind_vertex_buffer(15, vbo[0], OFFSET[0] as isize, STRIDE[0] as GLsizei));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo[0]));
        draw_strip(gl, glw::GL_UNSIGNED_SHORT, 0, 0, 0);
        if !check_window_color(context, [0.0, 1.0, 0.0]) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_buffer(15, 0, 0, 0));
        set_expected([1.0, 2.0, 3.0], [3, 4]);
        gl!(gl.bind_vertex_buffer(7, vbo[0], OFFSET[0] as isize, STRIDE[0] as GLsizei));
        gl!(gl.bind_vertex_buffer(12, vbo[1], OFFSET[1] as isize, STRIDE[1] as GLsizei));
        for (attrib, binding) in [(0, 7), (1, 12), (2, 12), (3, 7), (4, 12)] {
            gl!(gl.vertex_attrib_binding(attrib, binding));
        }
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo[0]));
        draw_strip(gl, glw::GL_UNSIGNED_SHORT, 0, 0, 0);
        if !check_window_color(context, [0.0, 0.0, 1.0]) {
            return Ok(ERROR);
        }

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        let location1 = gl!(gl.get_uniform_location(self.fsp, c"g_expected_data1".as_ptr()));
        gl!(gl.program_uniform_2i(self.fsp, location1, 0, 0));
        gl!(gl.disable_vertex_attrib_array(4));
        gl!(gl.vertex_attrib_i_4i(4, 0, 0, 0, 0));
        draw_strip(gl, glw::GL_UNSIGNED_SHORT, 0, 0, 0);
        if !check_window_color(context, [0.0, 0.0, 1.0]) {
            return Ok(ERROR);
        }

        let location0 = gl!(gl.get_uniform_location(self.fsp, c"g_expected_data0".as_ptr()));
        gl!(gl.program_uniform_3d(self.fsp, location0, 4.0, 5.0, 6.0));
        gl!(gl.program_uniform_2i(self.fsp, location1, 1, 2));
        gl!(gl.bind_vertex_array(vao[1]));
        draw_strip(gl, glw::GL_UNSIGNED_INT, 0, 0, 0);
        if !check_window_color(context, [0.0, 1.0, 1.0]) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

/// Column-major 4x4 translation, the bytes `tcu::Mat4` holds for `Translation(tx, ty, tz)`
fn translation(tx: f32, ty: f32, tz: f32) -> [f32; 16] {
    [
        1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, tx, ty, tz, 1.0,
    ]
}

#[derive(Default)]
struct AdvancedInstancing {
    pipeline: GLuint,
    vsp: GLuint,
    fsp: GLuint,
    vertex_array: [GLuint; 2],
    vertex_buffer: GLuint,
    index_buffer: GLuint,
    object_id_buffer: GLuint,
    transform_texture: GLuint,
    transform_buffer: GLuint,
}

impl Subcase for AdvancedInstancing {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_program_pipelines(1, &mut self.pipeline));
        self.vsp = 0;
        self.fsp = 0;
        gl!(gl.gen_vertex_arrays(2, self.vertex_array.as_mut_ptr()));
        gl!(gl.gen_buffers(1, &mut self.vertex_buffer));
        gl!(gl.gen_buffers(1, &mut self.index_buffer));
        gl!(gl.gen_buffers(1, &mut self.object_id_buffer));
        gl!(gl.gen_buffers(1, &mut self.transform_buffer));
        gl!(gl.gen_textures(1, &mut self.transform_texture));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program_pipelines(1, &self.pipeline));
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program(self.fsp));
        gl!(gl.delete_vertex_arrays(2, self.vertex_array.as_ptr()));
        gl!(gl.delete_buffers(1, &self.vertex_buffer));
        gl!(gl.delete_buffers(1, &self.index_buffer));
        gl!(gl.delete_buffers(1, &self.object_id_buffer));
        gl!(gl.delete_buffers(1, &self.transform_buffer));
        gl!(gl.delete_textures(1, &self.transform_texture));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_ver = "#version 430 core\n";
        let glsl = "\n#if defined(VS_PASS_THROUGH)\nlayout(location = 0) in vec4 vs_in_position;\nlayout(location = 1) in vec3 vs_in_normal;\nlayout(location = 2) in int vs_in_object_id;\nout StageData {\n  float f;\n  vec3 normal;\n  int object_id;\n} vs_out;\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nlayout(binding = 0) uniform samplerBuffer g_transform_buffer;\nmat4 GetTransformMatrix(int id) {\n  return mat4(texelFetch(g_transform_buffer, id * 4),\n              texelFetch(g_transform_buffer, id * 4 + 1),\n              texelFetch(g_transform_buffer, id * 4 + 2),\n              texelFetch(g_transform_buffer, id * 4 + 3));\n}\nvoid main() {\n  gl_Position = GetTransformMatrix(vs_in_object_id) * vs_in_position;\n  vs_out.f = 123.0;\n  vs_out.normal = vs_in_normal;\n  vs_out.object_id = vs_in_object_id;\n}\n#elif defined(FS_SOLID_COLOR)\nin StageData {\n  float f;\n  vec3 normal;\n  flat int object_id;\n} fs_in;\nlayout(location = 0) out vec4 g_color;\nvoid main() {\n  if (fs_in.object_id == 0) g_color = vec4(1, 0, 0, 1);\n  else if (fs_in.object_id == 1) g_color = vec4(0, 1, 0, 1);\n  else if (fs_in.object_id == 2) g_color = vec4(0, 0, 1, 1);\n  else if (fs_in.object_id == 3) g_color = vec4(1, 1, 0, 1);\n}\n#endif";

        self.vsp = create_shader_program(
            gl,
            glw::GL_VERTEX_SHADER,
            &[glsl_ver, "#define VS_PASS_THROUGH\n", glsl],
        );
        self.fsp = create_shader_program(
            gl,
            glw::GL_FRAGMENT_SHADER,
            &[glsl_ver, "#define FS_SOLID_COLOR\n", glsl],
        );
        if !check_program(gl, self.vsp) {
            return Ok(ERROR);
        }
        if !check_program(gl, self.fsp) {
            return Ok(ERROR);
        }

        gl!(gl.use_program_stages(self.pipeline, glw::GL_VERTEX_SHADER_BIT, self.vsp));
        gl!(gl.use_program_stages(self.pipeline, glw::GL_FRAGMENT_SHADER_BIT, self.fsp));

        {
            let data: [f32; 80] = [
                -0.5, -0.5, 1.0, 0.0, 0.0, 1.5, -0.5, 1.0, 0.0, 0.0, -0.5, 1.5, 1.0, 0.0, 0.0, 1.5, 1.5, 1.0, 0.0, 0.0,
                -1.5, -0.5, 0.0, 1.0, 0.0, 0.5, -0.5, 0.0, 1.0, 0.0, -1.5, 1.5, 0.0, 1.0, 0.0, 0.5, 1.5, 0.0, 1.0, 0.0,
                -1.5, -1.5, 0.0, 0.0, 1.0, 0.5, -1.5, 0.0, 0.0, 1.0, -1.5, 0.5, 0.0, 0.0, 1.0, 0.5, 0.5, 0.0, 0.0, 1.0,
                -0.5, -1.5, 1.0, 1.0, 0.0, 1.5, -1.5, 1.0, 1.0, 0.0, -0.5, 0.5, 1.0, 1.0, 0.0, 1.5, 0.5, 1.0, 1.0, 0.0,
            ];
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        }
        {
            let data: [u32; 16] = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3];
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.index_buffer));
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
        }
        {
            let data: [i32; 4] = [0, 1, 2, 3];
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.object_id_buffer));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        }

        gl!(gl.bind_vertex_array(self.vertex_array[0]));
        gl!(gl.vertex_attrib_format(0, 2, glw::GL_FLOAT, glw::FALSE, 0));
        gl!(gl.vertex_attrib_format(1, 3, glw::GL_FLOAT, glw::FALSE, 8));
        gl!(gl.vertex_attrib_i_format(2, 1, glw::GL_INT, 0));
        for attrib in 0..3 {
            gl!(gl.enable_vertex_attrib_array(attrib));
        }
        gl!(gl.vertex_attrib_binding(1, 0));
        gl!(gl.bind_vertex_buffer(0, self.vertex_buffer, 0, 20));
        gl!(gl.bind_vertex_buffer(2, self.object_id_buffer, 0, 4));
        gl!(gl.vertex_binding_divisor(2, 1));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.index_buffer));

        gl!(gl.bind_vertex_array(self.vertex_array[1]));
        gl!(gl.vertex_attrib_format(0, 2, glw::GL_FLOAT, glw::FALSE, 0));
        gl!(gl.vertex_attrib_format(1, 3, glw::GL_FLOAT, glw::FALSE, 0));
        gl!(gl.vertex_attrib_i_format(2, 1, glw::GL_INT, 0));
        for attrib in 0..3 {
            gl!(gl.enable_vertex_attrib_array(attrib));
        }
        gl!(gl.vertex_attrib_binding(2, 13));
        gl!(gl.vertex_attrib_binding(1, 14));
        gl!(gl.vertex_attrib_binding(0, 15));
        gl!(gl.bind_vertex_buffer(15, self.vertex_buffer, 0, 20));
        gl!(gl.bind_vertex_buffer(14, self.vertex_buffer, 8, 20));
        gl!(gl.bind_vertex_buffer(13, self.object_id_buffer, 0, 4));
        gl!(gl.vertex_binding_divisor(13, 1));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.index_buffer));
        gl!(gl.bind_vertex_array(0));

        {
            let mut data = [0f32; 64];
            for (n, (tx, ty)) in [(-0.5f32, -0.5f32), (0.5, -0.5), (0.5, 0.5), (-0.5, 0.5)]
                .into_iter()
                .enumerate()
            {
                data[n * 16..(n + 1) * 16].copy_from_slice(&translation(tx, ty, 0.0));
            }
            gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, self.transform_buffer));
            gl!(gl.buffer_data(
                glw::GL_TEXTURE_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
        }
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.transform_texture));
        gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA32F, self.transform_buffer));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0));

        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.bind_program_pipeline(self.pipeline));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.transform_texture));

        let uint_size = std::mem::size_of::<u32>();
        let steps: [(GLuint, usize, [f32; 3]); 4] = [
            (0, 0, [1.0, 0.0, 0.0]),
            (1, 4, [0.0, 1.0, 0.0]),
            (2, 8, [0.0, 0.0, 1.0]),
            (3, 12, [1.0, 1.0, 0.0]),
        ];

        gl!(gl.bind_vertex_array(self.vertex_array[0]));
        for (base_instance, first_index, color) in steps {
            draw_strip(
                gl,
                glw::GL_UNSIGNED_INT,
                first_index * uint_size,
                first_index as GLint,
                base_instance,
            );
            if !check_window_color(context, color) {
                return Ok(ERROR);
            }
        }

        gl!(gl.bind_vertex_array(self.vertex_array[1]));
        for (base_instance, first_index, color) in [steps[2], steps[0], steps[1], steps[3]] {
            draw_strip(
                gl,
                glw::GL_UNSIGNED_INT,
                first_index * uint_size,
                first_index as GLint,
                base_instance,
            );
            if !check_window_color(context, color) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct AdvancedIterations {
    po: GLuint,
    vao: [GLuint; 2],
    xfo: [GLuint; 2],
    buffer: [GLuint; 2],
}

impl AdvancedIterations {
    /// `AdvancedIterations::RelinkProgram`
    fn relink_program(&self, gl: &glw::Functions, index: GLuint) -> bool {
        gl!(gl.bind_attrib_location(self.po, index, c"vs_in_data".as_ptr()));
        let varyings = [c"StageData.data".as_ptr()];
        gl!(gl.transform_feedback_varyings(self.po, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        gl!(gl.link_program(self.po));
        check_program(gl, self.po)
    }

    fn data_is(&self, gl: &glw::Functions, expected: i32) -> bool {
        let mut data = [0i32; 4];
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.buffer[0]));
        gl!(gl.get_buffer_sub_data(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 16, data.as_mut_ptr().cast()));
        if data != [expected; 4] {
            log::info!(
                "Data is: {} {} {} {}, data should be: {expected} {expected} {expected} {expected}.",
                data[0],
                data[1],
                data[2],
                data[3]
            );
            return false;
        }
        true
    }

    /// Ten draws alternating between the two VAOs and transform feedback objects
    fn ping_pong_draws(&self, gl: &glw::Functions) {
        for i in 0..10 {
            gl!(gl.bind_vertex_array(self.vao[i % 2]));
            gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.xfo[i % 2]));
            gl!(gl.begin_transform_feedback(glw::GL_POINTS));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl!(gl.end_transform_feedback());
        }
    }
}

impl Subcase for AdvancedIterations {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.po = 0;
        gl!(gl.gen_vertex_arrays(2, self.vao.as_mut_ptr()));
        gl!(gl.gen_transform_feedbacks(2, self.xfo.as_mut_ptr()));
        gl!(gl.gen_buffers(2, self.buffer.as_mut_ptr()));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.po));
        gl!(gl.delete_vertex_arrays(2, self.vao.as_ptr()));
        gl!(gl.delete_transform_feedbacks(2, self.xfo.as_ptr()));
        gl!(gl.delete_buffers(2, self.buffer.as_ptr()));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs = "#version 430 core\nin ivec4 vs_in_data;\nout StageData {\n  ivec4 data;\n} vs_out;\nvoid main() {\n  vs_out.data = vs_in_data + 1;\n}";

        self.po = gl!(gl.create_program());
        {
            let sh = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
            let source = glsl_vs.as_ptr().cast::<glw::GLchar>();
            let length = glsl_vs.len() as GLint;
            gl!(gl.shader_source(sh, 1, &source, &length));
            gl!(gl.compile_shader(sh));
            gl!(gl.attach_shader(self.po, sh));
            gl!(gl.delete_shader(sh));
        }
        if !self.relink_program(gl, 1) {
            return Ok(ERROR);
        }

        let zero = [0i32; 4];
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer[0]));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 16, zero.as_ptr().cast(), glw::GL_STATIC_DRAW));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.buffer[1]));
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            16,
            zero.as_ptr().cast(),
            glw::GL_DYNAMIC_READ
        ));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));

        gl!(gl.bind_vertex_array(self.vao[0]));
        gl!(gl.vertex_attrib_i_format(1, 4, glw::GL_INT, 0));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.bind_vertex_buffer(1, self.buffer[0], 0, 16));
        gl!(gl.bind_vertex_array(self.vao[1]));
        gl!(gl.vertex_attrib_i_format(1, 4, glw::GL_INT, 0));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.bind_vertex_buffer(1, self.buffer[1], 0, 16));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.xfo[0]));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer[1]));
        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.xfo[1]));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer[0]));
        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0));

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(self.po));

        self.ping_pong_draws(gl);
        if !self.data_is(gl, 10) {
            return Ok(ERROR);
        }

        if !self.relink_program(gl, 5) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_array(self.vao[0]));
        gl!(gl.disable_vertex_attrib_array(1));
        gl!(gl.bind_vertex_buffer(1, 0, 0, 0));
        gl!(gl.vertex_attrib_i_format(5, 4, glw::GL_INT, 0));
        gl!(gl.enable_vertex_attrib_array(5));
        gl!(gl.bind_vertex_buffer(5, self.buffer[0], 0, 16));
        gl!(gl.bind_vertex_array(self.vao[1]));
        gl!(gl.disable_vertex_attrib_array(1));
        gl!(gl.bind_vertex_buffer(1, 0, 0, 0));
        gl!(gl.vertex_attrib_i_format(5, 4, glw::GL_INT, 0));
        gl!(gl.enable_vertex_attrib_array(5));
        gl!(gl.bind_vertex_buffer(7, self.buffer[1], 0, 16));
        gl!(gl.vertex_attrib_binding(5, 7));
        gl!(gl.bind_vertex_array(0));

        self.ping_pong_draws(gl);
        if !self.data_is(gl, 20) {
            return Ok(ERROR);
        }

        if !self.relink_program(gl, 11) {
            return Ok(ERROR);
        }

        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0));
        gl!(gl.bind_vertex_array(self.vao[0]));
        gl!(gl.disable_vertex_attrib_array(5));
        gl!(gl.bind_vertex_buffer(5, 0, 0, 0));
        gl!(gl.vertex_attrib_i_format(11, 4, glw::GL_INT, 0));
        gl!(gl.enable_vertex_attrib_array(11));
        for i in 0..10 {
            gl!(gl.bind_vertex_buffer(11, self.buffer[i % 2], 0, 16));
            gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.buffer[(i + 1) % 2]));
            gl!(gl.begin_transform_feedback(glw::GL_POINTS));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl!(gl.end_transform_feedback());
        }
        if !self.data_is(gl, 30) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct AdvancedLargeStrideAndOffsetsNewAndLegacyAPI {
    vsp: GLuint,
    ppo: GLuint,
    ssbo: GLuint,
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for AdvancedLargeStrideAndOffsetsNewAndLegacyAPI {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.vsp = 0;
        gl!(gl.gen_program_pipelines(1, &mut self.ppo));
        gl!(gl.gen_buffers(1, &mut self.ssbo));
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_buffers(1, &mut self.vbo));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program_pipelines(1, &self.ppo));
        gl!(gl.delete_buffers(1, &self.ssbo));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();

        // IsSSBOInVSAvailable(2)
        let blocks_vs = get_integer(gl, glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS);
        if blocks_vs < 2 {
            super::subcase::output_not_supported(&format!(
                "Required 2 VS storage blocks but only {blocks_vs} available.\n"
            ));
            return Ok(super::subcase::NOT_SUPPORTED);
        }

        let glsl_vs = "#version 430 core\nlayout(location = 0) in vec2 vs_in_attrib0;\nlayout(location = 4) in ivec2 vs_in_attrib1;\nlayout(location = 8) in uvec2 vs_in_attrib2;\nlayout(location = 15) in float vs_in_attrib3;\nlayout(std430, binding = 1) buffer Output {\n  vec2 attrib0[4];\n  ivec2 attrib1[4];\n  uvec2 attrib2[4];\n  float attrib3[4];\n} g_output;\nvoid main() {\n  g_output.attrib0[2 * gl_InstanceID + gl_VertexID] = vs_in_attrib0;\n  g_output.attrib1[2 * gl_InstanceID + gl_VertexID] = vs_in_attrib1;\n  g_output.attrib2[2 * gl_InstanceID + gl_VertexID] = vs_in_attrib2;\n  g_output.attrib3[2 * gl_InstanceID + gl_VertexID] = vs_in_attrib3;\n}";
        self.vsp = create_shader_program(gl, glw::GL_VERTEX_SHADER, &[glsl_vs]);
        if !check_program(gl, self.vsp) {
            return Ok(ERROR);
        }
        gl!(gl.use_program_stages(self.ppo, glw::GL_VERTEX_SHADER_BIT, self.vsp));

        {
            let mut bytes = vec![0u8; 100000];
            for k in 0..2usize {
                let kf = k as f32;
                push_f32(&mut bytes, 16 + k * 2048, &[1.0 + 2.0 * kf, 2.0 + 2.0 * kf]);
                push_i32(&mut bytes, 128 + k * 2048, &[5 + 2 * k as i32, 6 + 2 * k as i32]);
                push_u32(&mut bytes, 1024 + k * 2048, &[9 + 2 * k as u32, 10 + 2 * k as u32]);
                push_f32(&mut bytes, 2032 + k * 2048, &[13.0 + kf]);
            }
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                bytes.len() as isize,
                bytes.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        }

        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.vertex_attrib_format(0, 2, glw::GL_FLOAT, glw::FALSE, 16));
        gl!(gl.vertex_attrib_i_format(8, 2, glw::GL_UNSIGNED_INT, 1024));
        gl!(gl.vertex_attrib_format(15, 1, glw::GL_FLOAT, glw::FALSE, 2032));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo));
        gl!(gl.vertex_attrib_i_pointer(4, 2, glw::GL_INT, 2048, 128usize as *const std::ffi::c_void));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.vertex_attrib_binding(8, 3));
        gl!(gl.vertex_attrib_binding(15, 3));
        gl!(gl.bind_vertex_buffer(0, self.vbo, 0, 2048));
        gl!(gl.bind_vertex_buffer(3, self.vbo, 0, 2048));
        for attrib in [0, 4, 8, 15] {
            gl!(gl.enable_vertex_attrib_array(attrib));
        }
        gl!(gl.bind_vertex_array(0));

        let data = [0xffu8; (8 + 8 + 8 + 4) * 4];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.ssbo));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            data.len() as isize,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_program_pipeline(self.ppo));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays_instanced(glw::GL_POINTS, 0, 2, 2));

        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.ssbo));
        let mapped = gl!(gl.map_buffer(glw::GL_SHADER_STORAGE_BUFFER, glw::GL_READ_ONLY));
        if mapped.is_null() {
            return Ok(ERROR);
        }
        // SAFETY: the mapping covers the 112 bytes the buffer was allocated with.
        let ptr = unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), data.len()) };
        let f32_at = |offset: usize| f32::from_ne_bytes(ptr[offset..offset + 4].try_into().unwrap());
        let i32_at = |offset: usize| i32::from_ne_bytes(ptr[offset..offset + 4].try_into().unwrap());
        let u32_at = |offset: usize| u32::from_ne_bytes(ptr[offset..offset + 4].try_into().unwrap());

        // instance 0 vertex 0, instance 0 vertex 1, instance 1 vertex 0, instance 1 vertex 1 for each attribute
        for (n, k) in [0usize, 1, 0, 1].into_iter().enumerate() {
            let kf = k as f32;
            if f32_at(8 * n) != 1.0 + 2.0 * kf || f32_at(8 * n + 4) != 2.0 + 2.0 * kf {
                return Ok(ERROR);
            }
            if i32_at(32 + 8 * n) != 5 + 2 * k as i32 || i32_at(32 + 8 * n + 4) != 6 + 2 * k as i32 {
                return Ok(ERROR);
            }
            if u32_at(64 + 8 * n) != 9 + 2 * k as u32 || u32_at(64 + 8 * n + 4) != 10 + 2 * k as u32 {
                return Ok(ERROR);
            }
            if f32_at(96 + 4 * n) != 13.0 + kf {
                return Ok(ERROR);
            }
        }
        gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
        Ok(NO_ERROR)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// 3 Negative

/// `glGetError() == expected`, logging upstream's message when it is not
fn expect_error(gl: &glw::Functions, expected: GLenum, message: &str) -> bool {
    if gl!(gl.get_error()) != expected {
        log::info!("{message}");
        return false;
    }
    true
}

fn expect_one_of_errors(gl: &glw::Functions, message: &str) -> bool {
    let error = gl!(gl.get_error());
    if error != glw::GL_INVALID_OPERATION && error != glw::GL_INVALID_VALUE {
        log::info!("{message}");
        return false;
    }
    true
}

const INVALID_OPERATION: &str = "INVALID_OPERATION should be generated.";
const INVALID_VALUE: &str = "INVALID_VALUE should be generated.";
const INVALID_ENUM: &str = "INVALID_ENUM should be generated.";

#[derive(Default)]
struct NegativeBindVertexBuffer {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for NegativeBindVertexBuffer {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_buffers(1, &mut self.vbo));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 1000, std::ptr::null(), glw::GL_STATIC_DRAW));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.bind_vertex_buffer(0, 1234, 0, 12));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }

        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);
        gl!(gl.bind_vertex_buffer((p + 1) as GLuint, self.vbo, 0, 12));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_buffer(0, self.vbo, -10, 12));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_buffer(0, self.vbo, 0, -12));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_vertex_buffer(0, self.vbo, 0, 12));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct NegativeVertexAttribFormat {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for NegativeVertexAttribFormat {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_buffers(1, &mut self.vbo));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 1000, std::ptr::null(), glw::GL_STATIC_DRAW));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        gl!(gl.bind_vertex_array(self.vao));
        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS);

        gl!(gl.vertex_attrib_format((p + 1) as GLuint, 4, glw::GL_FLOAT, glw::FALSE, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_i_format((p + 2) as GLuint, 4, glw::GL_INT, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_l_format((p + 3) as GLuint, 4, glw::GL_DOUBLE, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.vertex_attrib_format(0, 0, glw::GL_FLOAT, glw::FALSE, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_format(0, 5, glw::GL_FLOAT, glw::FALSE, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_i_format(0, 5, glw::GL_INT, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_l_format(0, 0, glw::GL_DOUBLE, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        // two possible errors here: INVALID_VALUE because GL_BGRA is used in the *IFormat function and INVALID_OPERATION because GL_BGRA is used with GL_INT
        gl!(gl.vertex_attrib_i_format(0, glw::GL_BGRA as GLint, glw::GL_INT, 0));
        if !expect_one_of_errors(gl, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_l_format(0, glw::GL_BGRA as GLint, glw::GL_DOUBLE, 0));
        if !expect_one_of_errors(gl, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.vertex_attrib_format(0, 4, glw::GL_R32F, glw::FALSE, 0));
        if !expect_error(gl, glw::GL_INVALID_ENUM, INVALID_ENUM) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_i_format(0, 4, glw::GL_FLOAT, 0));
        if !expect_error(gl, glw::GL_INVALID_ENUM, INVALID_ENUM) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_l_format(0, 4, glw::GL_INT, 0));
        if !expect_error(gl, glw::GL_INVALID_ENUM, INVALID_ENUM) {
            return Ok(ERROR);
        }

        gl!(gl.vertex_attrib_format(0, glw::GL_BGRA as GLint, glw::GL_FLOAT, glw::TRUE, 0));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_format(0, 3, glw::GL_INT_2_10_10_10_REV, glw::FALSE, 0));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_format(0, glw::GL_BGRA as GLint, glw::GL_UNSIGNED_BYTE, glw::FALSE, 0));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }

        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET);
        gl!(gl.vertex_attrib_format(0, 4, glw::GL_FLOAT, glw::FALSE, (p + 10) as GLuint));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_i_format(0, 4, glw::GL_INT, (p + 10) as GLuint));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_l_format(0, 4, glw::GL_DOUBLE, (p + 10) as GLuint));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_array(0));
        gl!(gl.vertex_attrib_format(0, 4, glw::GL_FLOAT, glw::FALSE, 0));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_i_format(0, 4, glw::GL_INT, 0));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        gl!(gl.vertex_attrib_l_format(0, 4, glw::GL_DOUBLE, 0));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct NegativeVertexAttribBinding {
    vao: GLuint,
}

impl Subcase for NegativeVertexAttribBinding {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().gen_vertex_arrays(1, &mut self.vao));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();

        gl!(gl.bind_vertex_array(self.vao));
        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS);
        gl!(gl.vertex_attrib_binding((p + 1) as GLuint, 0));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS);
        gl!(gl.vertex_attrib_binding(0, (p + 1) as GLuint));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_array(0));
        gl!(gl.vertex_attrib_binding(0, 0));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct NegativeVertexAttribDivisor {
    vao: GLuint,
}

impl Subcase for NegativeVertexAttribDivisor {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().gen_vertex_arrays(1, &mut self.vao));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();

        gl!(gl.bind_vertex_array(self.vao));
        let p = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS);
        gl!(gl.vertex_binding_divisor((p + 1) as GLuint, 1));
        if !expect_error(gl, glw::GL_INVALID_VALUE, INVALID_VALUE) {
            return Ok(ERROR);
        }

        gl!(gl.bind_vertex_array(0));
        gl!(gl.vertex_binding_divisor(0, 1));
        if !expect_error(gl, glw::GL_INVALID_OPERATION, INVALID_OPERATION) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

// ---------------------------------------------------------------------------------------------------------------------

fn add_case(group: &mut TestCaseGroup, name: &str, factory: impl Fn() -> Box<dyn Subcase> + Send + Sync + 'static) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

/// `gl4cts::VertexAttribBindingTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_attrib_binding");

    add_case(&mut group, "basic-usage", || Box::new(BasicUsage::default()));

    let input_cases: [(&str, InputSetup); 12] = [
        ("basic-input-case1", input_case1),
        ("basic-input-case2", input_case2),
        ("basic-input-case3", input_case3),
        ("basic-input-case4", input_case4),
        ("basic-input-case5", input_case5),
        ("basic-input-case6", input_case6),
        ("basic-input-case7", input_case7),
        ("basic-input-case8", input_case8),
        ("basic-input-case9", input_case9),
        ("basic-input-case10", input_case10),
        ("basic-input-case11", input_case11),
        ("basic-input-case12", input_case12),
    ];
    for (name, setup) in input_cases {
        add_case(&mut group, name, move || Box::new(BasicInput::new(setup)));
    }

    let input_i_cases: [(&str, InputISetup); 3] = [
        ("basic-inputI-case1", input_i_case1),
        ("basic-inputI-case2", input_i_case2),
        ("basic-inputI-case3", input_i_case3),
    ];
    for (name, setup) in input_i_cases {
        add_case(&mut group, name, move || {
            Box::new(BasicInputI {
                setup,
                po: 0,
                xfbo: 0,
                objects: Objects::default(),
            })
        });
    }

    let input_l_cases: [(&str, InputLSetup); 2] = [
        ("basic-inputL-case1", input_l_case1),
        ("basic-inputL-case2", input_l_case2),
    ];
    for (name, setup) in input_l_cases {
        add_case(&mut group, name, move || {
            Box::new(BasicInputL {
                setup,
                po: 0,
                xfbo: 0,
                objects: Objects::default(),
            })
        });
    }

    add_case(&mut group, "basic-state1", || Box::new(BasicState1::default()));
    add_case(&mut group, "basic-state2", || Box::new(BasicState2::default()));
    add_case(&mut group, "basic-state3", || Box::new(BasicState3::default()));
    add_case(&mut group, "basic-state4", || Box::new(BasicState4::default()));

    add_case(&mut group, "advanced-bindingUpdate", || {
        Box::new(AdvancedBindingUpdate::default())
    });
    add_case(&mut group, "advanced-instancing", || {
        Box::new(AdvancedInstancing::default())
    });
    add_case(&mut group, "advanced-iterations", || {
        Box::new(AdvancedIterations::default())
    });
    add_case(&mut group, "advanced-largeStrideAndOffsetsNewAndLegacyAPI", || {
        Box::new(AdvancedLargeStrideAndOffsetsNewAndLegacyAPI::default())
    });

    add_case(&mut group, "negative-bindVertexBuffer", || {
        Box::new(NegativeBindVertexBuffer::default())
    });
    add_case(&mut group, "negative-vertexAttribFormat", || {
        Box::new(NegativeVertexAttribFormat::default())
    });
    add_case(&mut group, "negative-vertexAttribBinding", || {
        Box::new(NegativeVertexAttribBinding::default())
    });
    add_case(&mut group, "negative-vertexAttribDivisor", || {
        Box::new(NegativeVertexAttribDivisor::default())
    });

    group
}
