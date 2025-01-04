// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderDrawParametersTests.cpp
//   external/openglcts/modules/gl/gl4cShaderDrawParametersTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ShaderDrawParametersTestBase` and its eleven drawing subclasses are one case type driven by `Draw`: `initChild`'s expected result points are the const tables below (extracted from the C++ by script), its indirect command buffers are `Indirect`, and `drawCommand` is `draw_command`. The support checks upstream throws from `init` and `initChild` are `check_support`. The array indirect-count case uploads four commands' worth of bytes from a three-command array upstream (it reads past the array); the fourth command is zero here, and the parameter buffer's count clamps the draw to three commands either way.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const SDP_COMPUTE_EXTENSION_CHECK: &str = "#version 450 core\n\n#extension GL_ARB_shader_draw_parameters : require\n\n#ifndef GL_ARB_shader_draw_parameters\n  #error GL_ARB_shader_draw_parameters not defined\n#else\n  #if (GL_ARB_shader_draw_parameters != 1)\n    #error GL_ARB_shader_draw_parameters wrong value\n  #endif\n#endif // GL_ARB_shader_draw_parameters\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nvoid main()\n{\n}\n";

const SDP_VERT_SHADER: &str = "${VERSION}\n\n${DRAW_PARAMETERS_EXTENSION}\n\nin vec3 vertex;\nout vec3 color;\n\nvoid main()\n{\n    float hOffset = float(${GL_BASE_VERTEX}) / 5.0;\n    float vOffset = float(${GL_BASE_INSTANCE}) / 5.0;\n    color = vec3(0.0);\n    if (${GL_DRAW_ID} % 3 == 0) color.r = 1;\n    else if (${GL_DRAW_ID} % 3 == 1) color.g = 1;\n    else if (${GL_DRAW_ID} % 3 == 2) color.b = 1;\n    gl_Position = vec4(vertex + vec3(hOffset, vOffset, 0), 1);\n}\n";

const SDP_FRAG_SHADER: &str = "${VERSION}\n\n${DRAW_PARAMETERS_EXTENSION}\n\nin vec3 color;\nout vec4 fragColor;\n\nvoid main()\n{\n    fragColor = vec4(color, 1.0);\n}\n";

const VERTICES: [f32; 18] = [
    -1.0, -1.0, 0.0, -1.0, -0.8, 0.0, -0.9, -1.0, 0.0, -0.9, -0.8, 0.0, -0.8, -1.0, 0.0, -0.8, -0.8, 0.0,
];
const ELEMENTS: [u16; 6] = [0, 1, 2, 3, 4, 5];

const DRAW_ARRAYS_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
];

const DRAW_ELEMENTS_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
];

const DRAW_ARRAYS_INDIRECT_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
];

const DRAW_ELEMENTS_INDIRECT_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
];

const DRAW_ARRAYS_INSTANCED_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
];

const DRAW_ELEMENTS_INSTANCED_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
];

const MULTI_DRAW_ARRAYS_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 1.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 0.0, 1.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
];

const MULTI_DRAW_ELEMENTS_POINTS: [[f32; 5]; 4] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 1.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 1.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
];

const MULTI_DRAW_ARRAYS_INDIRECT_POINTS: [[f32; 5]; 8] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 0.0, 1.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 1.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -0.8f32 + 0.05, 0.0, 0.0, 1.0],
    [-1.0f32 + 0.05, -0.8f32 + 0.15, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -0.8f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -0.8f32 + 0.15, 0.0, 0.0, 0.0],
];

const MULTI_DRAW_ELEMENTS_INDIRECT_POINTS: [[f32; 5]; 12] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -0.8f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -0.8f32 + 0.15, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -0.8f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -0.8f32 + 0.15, 0.0, 1.0, 0.0],
    [-0.8f32 + 0.05, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-0.8f32 + 0.05, -1.0f32 + 0.15, 0.0, 0.0, 1.0],
    [-0.8f32 + 0.15, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-0.8f32 + 0.15, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
];

const MULTI_DRAW_ARRAYS_INDIRECT_COUNT_POINTS: [[f32; 5]; 12] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -0.8f32 + 0.05, 0.0, 1.0, 0.0],
    [-1.0f32 + 0.05, -0.8f32 + 0.15, 0.0, 1.0, 0.0],
    [-1.0f32 + 0.15, -0.8f32 + 0.05, 0.0, 1.0, 0.0],
    [-1.0f32 + 0.15, -0.8f32 + 0.15, 0.0, 1.0, 0.0],
    [-1.0f32 + 0.05, -0.6f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -0.6f32 + 0.15, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -0.6f32 + 0.05, 0.0, 0.0, 1.0],
    [-1.0f32 + 0.15, -0.6f32 + 0.15, 0.0, 0.0, 1.0],
];

const MULTI_DRAW_ELEMENTS_INDIRECT_COUNT_POINTS: [[f32; 5]; 8] = [
    [-1.0f32 + 0.05, -1.0f32 + 0.05, 1.0, 0.0, 0.0],
    [-1.0f32 + 0.05, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.05, 0.0, 0.0, 0.0],
    [-1.0f32 + 0.15, -1.0f32 + 0.15, 0.0, 0.0, 0.0],
    [-0.8f32 + 0.05, -0.8f32 + 0.05, 0.0, 0.0, 0.0],
    [-0.8f32 + 0.05, -0.8f32 + 0.15, 0.0, 1.0, 1.0],
    [-0.8f32 + 0.15, -0.8f32 + 0.05, 0.0, 0.0, 1.0],
    [-0.8f32 + 0.15, -0.8f32 + 0.15, 0.0, 0.0, 0.0],
];

const DRAW_ARRAYS_INDIRECT_COMMANDS: [[u32; 4]; 1] = [[5, 1, 0, 0]];
const DRAW_ELEMENTS_INDIRECT_COMMANDS: [[u32; 5]; 1] = [[5, 1, 1, 0, 0]];
const MULTI_DRAW_ARRAYS_INDIRECT_COMMANDS: [[u32; 4]; 3] = [[5, 1, 1, 0], [4, 1, 0, 0], [3, 1, 0, 1]];
const MULTI_DRAW_ELEMENTS_INDIRECT_COMMANDS: [[u32; 5]; 3] = [[4, 1, 0, 0, 0], [3, 1, 3, 0, 1], [3, 1, 0, 1, 0]];
const MULTI_DRAW_ARRAYS_INDIRECT_COUNT_COMMANDS: [[u32; 4]; 4] =
    [[5, 1, 1, 0], [6, 1, 0, 1], [4, 1, 2, 2], [0, 0, 0, 0]];
const MULTI_DRAW_ELEMENTS_INDIRECT_COUNT_COMMANDS: [[u32; 5]; 3] = [[3, 1, 0, 0, 0], [3, 1, 0, 1, 1], [4, 1, 0, 1, 1]];
const COUNT_PARAMETERS: [u16; 3] = [1, 1, 1];

/// `SDPDrawArraysIndirectCommand` or `SDPDrawElementsIndirectCommand` array
enum Indirect {
    None,
    Arrays(&'static [[u32; 4]]),
    Elements(&'static [[u32; 5]]),
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Draw {
    Arrays,
    Elements,
    ArraysIndirect,
    ElementsIndirect,
    ArraysInstanced,
    ElementsInstanced,
    MultiArrays,
    MultiElements,
    MultiArraysIndirect,
    MultiElementsIndirect,
    MultiArraysIndirectCount,
    MultiElementsIndirectCount,
}

impl Draw {
    fn uses_count(self) -> bool {
        matches!(self, Self::MultiArraysIndirectCount | Self::MultiElementsIndirectCount)
    }
}

struct DrawCase {
    name: &'static str,
    draw: Draw,
    /// `m_resultPoints`: x, y, red, green, blue
    points: &'static [[f32; 5]],
    indirect: Indirect,
}

/// `ShaderDrawParametersTestBase::draw`'s program, drawing and `drawCommand`
fn draw_command(gl: &glw::Functions, draw: Draw) -> Res<()> {
    const MODE: GLenum = glw::GL_TRIANGLE_STRIP;
    const USHORT: GLenum = glw::GL_UNSIGNED_SHORT;
    let offset = |bytes: usize| bytes as *const std::ffi::c_void;
    match draw {
        Draw::Arrays => gl_call!(gl, "glDrawArrays", gl.draw_arrays(MODE, 1, 4)),
        Draw::Elements => gl_call!(
            gl,
            "glDrawElements",
            gl.draw_elements(MODE, 4, USHORT, offset(2 * std::mem::size_of::<u16>()))
        ),
        Draw::ArraysIndirect => gl_call!(
            gl,
            "glDrawArraysIndirect",
            gl.draw_arrays_indirect(MODE, std::ptr::null())
        ),
        Draw::ElementsIndirect => gl_call!(
            gl,
            "glDrawElementsIndirect",
            gl.draw_elements_indirect(MODE, USHORT, std::ptr::null())
        ),
        Draw::ArraysInstanced => gl_call!(gl, "glDrawArraysInstanced", gl.draw_arrays_instanced(MODE, 2, 4, 2)),
        Draw::ElementsInstanced => gl_call!(
            gl,
            "glDrawElementsInstanced",
            gl.draw_elements_instanced(MODE, 6, USHORT, std::ptr::null(), 3)
        ),
        Draw::MultiArrays => {
            let first = [0i32, 1];
            let count = [4i32, 4];
            gl_call!(
                gl,
                "glMultiDrawArrays",
                gl.multi_draw_arrays(MODE, first.as_ptr(), count.as_ptr(), 2)
            );
        }
        Draw::MultiElements => {
            let count = [5i32, 4];
            let indices = [offset(std::mem::size_of::<u16>()), offset(std::mem::size_of::<u16>())];
            gl_call!(
                gl,
                "glMultiDrawElements",
                gl.multi_draw_elements(MODE, count.as_ptr(), USHORT, indices.as_ptr(), 2)
            );
        }
        Draw::MultiArraysIndirect => gl_call!(
            gl,
            "glMultiDrawArraysIndirect",
            gl.multi_draw_arrays_indirect(MODE, std::ptr::null(), 3, 16)
        ),
        Draw::MultiElementsIndirect => gl_call!(
            gl,
            "glMultiDrawElementsIndirect",
            gl.multi_draw_elements_indirect(MODE, USHORT, std::ptr::null(), 3, 20)
        ),
        Draw::MultiArraysIndirectCount => gl_call!(
            gl,
            "glMultiDrawArraysIndirect",
            gl.multi_draw_arrays_indirect_count(MODE, std::ptr::null(), 0, 3, 16)
        ),
        Draw::MultiElementsIndirectCount => gl_call!(
            gl,
            "glMultiDrawElementsIndirect",
            gl.multi_draw_elements_indirect_count(MODE, USHORT, std::ptr::null(), 0, 3, 20)
        ),
    }
    Ok(())
}

impl DrawCase {
    /// `ShaderDrawParametersTestBase::draw`
    fn draw(&self, context: &Context) -> Res<bool> {
        let gl = context.gl();

        let specialization: Vec<(&str, String)> = if context.context_type().supports_core(4, 6) {
            vec![
                ("VERSION", "#version 460".to_string()),
                ("DRAW_PARAMETERS_EXTENSION", String::new()),
                ("GL_BASE_VERTEX", "gl_BaseVertex".to_string()),
                ("GL_BASE_INSTANCE", "gl_BaseInstance".to_string()),
                ("GL_DRAW_ID", "gl_DrawID".to_string()),
            ]
        } else {
            vec![
                ("VERSION", "#version 450".to_string()),
                (
                    "DRAW_PARAMETERS_EXTENSION",
                    "#extension GL_ARB_shader_draw_parameters : enable".to_string(),
                ),
                ("GL_BASE_VERTEX", "gl_BaseVertexARB".to_string()),
                ("GL_BASE_INSTANCE", "gl_BaseInstanceARB".to_string()),
                ("GL_DRAW_ID", "gl_DrawIDARB".to_string()),
            ]
        };
        let vs = StringTemplate::new(SDP_VERT_SHADER).specialize(&specialization)?;
        let fs = StringTemplate::new(SDP_FRAG_SHADER).specialize(&specialization)?;

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs, fs));
        if !program.is_ok() {
            log::info!(
                "Shader build failed.\n{}",
                program.build_failure_summary().unwrap_or_default()
            );
            return Ok(false);
        }

        gl_call!(gl, "glUseProgram", gl.use_program(program.program()));
        // SAFETY: a current context.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.enable(glw::GL_BLEND);
            gl.blend_func(glw::GL_ONE, glw::GL_ONE);
        }

        gl_call!(gl, "glEnableVertexAttribArray", gl.enable_vertex_attrib_array(0));
        gl_call!(
            gl,
            "glVertexAttribPointer",
            gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
        );

        draw_command(gl, self.draw)?;

        gl_call!(gl, "glDisableVertexAttribArray", gl.disable_vertex_attrib_array(0));
        // SAFETY: a current context.
        unsafe { gl.disable(glw::GL_BLEND) };
        Ok(true)
    }

    /// `ShaderDrawParametersTestBase::verify`
    fn verify(&self, context: &Context) -> bool {
        let gl = context.gl();
        let render_target = context.render_target();
        let (width, height) = (render_target.width, render_target.height);

        let mut pixels = vec![0u8; (width * height * 3) as usize];
        // SAFETY: the buffer holds a whole RGB image of the render target's size.
        unsafe {
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
            gl.read_pixels(
                0,
                0,
                width,
                height,
                glw::GL_RGB,
                glw::GL_UNSIGNED_BYTE,
                pixels.as_mut_ptr().cast(),
            );
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
        }

        for [point_x, point_y, point_red, point_green, point_blue] in self.points {
            let x = (((point_x + 1.0) / 2.0) * width as f32) as i32;
            let y = (((point_y + 1.0) / 2.0) * height as f32) as i32;
            let red = (point_red * 255.0) as i32;
            let green = (point_green * 255.0) as i32;
            let blue = (point_blue * 255.0) as i32;
            let index = ((x + y * width) * 3) as usize;

            if i32::from(pixels[index]) != red
                || i32::from(pixels[index + 1]) != green
                || i32::from(pixels[index + 2]) != blue
            {
                log::info!(
                    "Verification failed ({x}/{y})\nExpected point: ({red},{green},{blue})\nResult point: ({},{},{})\n",
                    pixels[index],
                    pixels[index + 1],
                    pixels[index + 2]
                );
                return false;
            }
        }
        true
    }
}

fn shader_draw_parameters_supported(context: &Context) -> bool {
    context.context_type().supports_core(4, 6)
        || context
            .context_info
            .is_extension_supported("GL_ARB_shader_draw_parameters")
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `ShaderDrawParametersTestBase::init` and the count cases' `initChild`
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !shader_draw_parameters_supported(context) {
            return Err(TestError::NotSupported(
                "shader_draw_parameters functionality not supported".to_string(),
            ));
        }
        if self.draw.uses_count()
            && !(context.context_type().supports_core(4, 6)
                || context
                    .context_info
                    .is_extension_supported("GL_ARB_indirect_parameters"))
        {
            return Err(TestError::NotSupported(
                "indirect_parameters functionality not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // initChild: the indirect command buffer, and for the count cases the parameter buffer
        let draw_indirect_buffer = glu::Buffer::new(gl);
        let parameter_buffer = glu::Buffer::new(gl);
        let commands: Vec<u8> = match &self.indirect {
            Indirect::None => Vec::new(),
            Indirect::Arrays(commands) => commands.iter().flatten().flat_map(|v| v.to_ne_bytes()).collect(),
            Indirect::Elements(commands) => commands.iter().flatten().flat_map(|v| v.to_ne_bytes()).collect(),
        };
        if !commands.is_empty() {
            glu::expect_no_error(gl, "glGenBuffers")?;
            gl_call!(
                gl,
                "glBindBuffer",
                gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, draw_indirect_buffer.get())
            );
            gl_call!(
                gl,
                "glBufferData",
                gl.buffer_data(
                    glw::GL_DRAW_INDIRECT_BUFFER,
                    commands.len() as isize,
                    commands.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                )
            );
        }
        if self.draw.uses_count() {
            glu::expect_no_error(gl, "glGenBuffers")?;
            gl_call!(
                gl,
                "glBindBuffer",
                gl.bind_buffer(glw::GL_PARAMETER_BUFFER_ARB, parameter_buffer.get())
            );
            gl_call!(
                gl,
                "glBufferData",
                gl.buffer_data(
                    glw::GL_PARAMETER_BUFFER_ARB,
                    std::mem::size_of_val(&COUNT_PARAMETERS) as isize,
                    COUNT_PARAMETERS.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                )
            );
        }

        // Generate vertex array object
        let vao = glu::VertexArray::new(gl);
        glu::expect_no_error(gl, "glGenVertexArrays")?;
        gl_call!(gl, "glBindVertexArray", gl.bind_vertex_array(vao.get()));

        // Setup vertex array buffer
        let array_buffer = glu::Buffer::new(gl);
        glu::expect_no_error(gl, "glGenBuffers")?;
        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buffer.get())
        );
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&VERTICES) as isize,
                VERTICES.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        // Setup element array buffer
        let element_buffer = glu::Buffer::new(gl);
        glu::expect_no_error(gl, "glGenBuffers")?;
        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buffer.get())
        );
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&ELEMENTS) as isize,
                ELEMENTS.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        Ok(if self.draw(context)? && self.verify(context) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ShaderDrawParametersExtensionTestCase`
struct ExtensionCase;

impl TestCase for ExtensionCase {
    fn name(&self) -> &str {
        "ShaderDrawParametersExtension"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context
            .context_info
            .is_extension_supported("GL_ARB_shader_draw_parameters")
        {
            return Err(TestError::NotSupported("Not Supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let program = ShaderProgram::new(
            context.gl(),
            &ProgramSources::default().with(ShaderType::Compute, SDP_COMPUTE_EXTENSION_CHECK),
        );
        if !program.is_ok() {
            log::info!(
                "Checking shader preprocessor directives failed. Source:\n{SDP_COMPUTE_EXTENSION_CHECK}InfoLog:\n{}\n",
                program.build_failure_summary().unwrap_or_default()
            );
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderDrawParametersTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_draw_parameters_tests");
    group.add_child(Box::new(ExtensionCase) as Box<dyn TestCase>);

    let cases = [
        DrawCase {
            name: "ShaderDrawArraysParameters",
            draw: Draw::Arrays,
            points: &DRAW_ARRAYS_POINTS,
            indirect: Indirect::None,
        },
        DrawCase {
            name: "ShaderDrawElementsParameters",
            draw: Draw::Elements,
            points: &DRAW_ELEMENTS_POINTS,
            indirect: Indirect::None,
        },
        DrawCase {
            name: "ShaderDrawArraysIndirectParameters",
            draw: Draw::ArraysIndirect,
            points: &DRAW_ARRAYS_INDIRECT_POINTS,
            indirect: Indirect::Arrays(&DRAW_ARRAYS_INDIRECT_COMMANDS),
        },
        DrawCase {
            name: "ShaderDrawElementsIndirectParameters",
            draw: Draw::ElementsIndirect,
            points: &DRAW_ELEMENTS_INDIRECT_POINTS,
            indirect: Indirect::Elements(&DRAW_ELEMENTS_INDIRECT_COMMANDS),
        },
        DrawCase {
            name: "ShaderDrawArraysInstancedParameters",
            draw: Draw::ArraysInstanced,
            points: &DRAW_ARRAYS_INSTANCED_POINTS,
            indirect: Indirect::None,
        },
        DrawCase {
            name: "ShaderDrawElementsInstancedParameters",
            draw: Draw::ElementsInstanced,
            points: &DRAW_ELEMENTS_INSTANCED_POINTS,
            indirect: Indirect::None,
        },
        DrawCase {
            name: "ShaderMultiDrawArraysParameters",
            draw: Draw::MultiArrays,
            points: &MULTI_DRAW_ARRAYS_POINTS,
            indirect: Indirect::None,
        },
        DrawCase {
            name: "ShaderMultiDrawElementsParameters",
            draw: Draw::MultiElements,
            points: &MULTI_DRAW_ELEMENTS_POINTS,
            indirect: Indirect::None,
        },
        DrawCase {
            name: "ShaderMultiDrawArraysIndirectParameters",
            draw: Draw::MultiArraysIndirect,
            points: &MULTI_DRAW_ARRAYS_INDIRECT_POINTS,
            indirect: Indirect::Arrays(&MULTI_DRAW_ARRAYS_INDIRECT_COMMANDS),
        },
        DrawCase {
            name: "ShaderMultiDrawElementsIndirectParameters",
            draw: Draw::MultiElementsIndirect,
            points: &MULTI_DRAW_ELEMENTS_INDIRECT_POINTS,
            indirect: Indirect::Elements(&MULTI_DRAW_ELEMENTS_INDIRECT_COMMANDS),
        },
        DrawCase {
            name: "MultiDrawArraysIndirectCountParameters",
            draw: Draw::MultiArraysIndirectCount,
            points: &MULTI_DRAW_ARRAYS_INDIRECT_COUNT_POINTS,
            indirect: Indirect::Arrays(&MULTI_DRAW_ARRAYS_INDIRECT_COUNT_COMMANDS),
        },
        DrawCase {
            name: "MultiDrawElementIndirectCountParameters",
            draw: Draw::MultiElementsIndirectCount,
            points: &MULTI_DRAW_ELEMENTS_INDIRECT_COUNT_POINTS,
            indirect: Indirect::Elements(&MULTI_DRAW_ELEMENTS_INDIRECT_COUNT_COMMANDS),
        },
    ];
    for case in cases {
        group.add_child(Box::new(case) as Box<dyn TestCase>);
    }
    group
}
