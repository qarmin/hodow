// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cSeparateShaderObjsTests.cpp  (StateInteractionCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `tcu::Surface` of upstream is an RGBA8 byte buffer read with glReadPixels; `isContextTypeES` is false here (desktop GL), so the ES-only `glDisableVertexAttribArray` is dropped and mismatched interfaces must validate.

use std::ffi::CString;

use super::{
    create_shader_programv, fail, generate_basic_fragment_src, generate_basic_vertex_src, get_error, get_program,
    get_program_pipeline,
};
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, pr, va};
use crate::glw::{self, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `StateInteractionCase`
pub(super) struct StateInteractionCase {
    pub(super) glsl_version: GlslVersion,
}

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const POSITION: [f32; 16] = [
    -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, -1.0, 1.0,
];

/// `logProgramInfoLog`
fn log_program_info_log(gl: &glw::Functions, program: GLuint) -> Result<(), TestError> {
    let value = get_program(gl, program, glw::GL_INFO_LOG_LENGTH);
    let mut info_log_buf = vec![0u8; value.max(0) as usize + 1];
    let mut length: GLsizei = 0;

    // SAFETY: the buffer holds INFO_LOG_LENGTH + 1 bytes and a buffer size of 0 is passed, as upstream does.
    unsafe { gl.get_program_info_log(program, 0, &mut length, info_log_buf.as_mut_ptr().cast()) };
    glu::expect_no_error(gl, "GetProgramInfoLog failed")?;

    let end = info_log_buf
        .iter()
        .position(|&byte| byte == 0)
        .unwrap_or(info_log_buf.len());
    log::info!("Program Log:\n{}", String::from_utf8_lossy(&info_log_buf[..end]));

    Ok(())
}

/// `checkCSProg`: the program from glCreateShaderProgramv exists and linked as expected.
fn check_cs_prog(gl: &glw::Functions, program: GLuint, expected_link: GLint) -> Result<bool, TestError> {
    let mut linked = glw::GL_FALSE as GLint;

    if program != 0 {
        linked = get_program(gl, program, glw::GL_LINK_STATUS);

        if expected_link != 0 && linked == 0 {
            log_program_info_log(gl, program)?;
        }
    }

    Ok(program != 0 && linked == expected_link)
}

/// `generateVarLinkVertexShaderSrc`
fn generate_var_link_vertex_shader_src(glsl_version: GlslVersion, num_outputs: i32) -> String {
    let mut vtx_src = format!("{}\n", glsl_version.declaration());

    if glsl_version >= GlslVersion::Glsl410 {
        vtx_src.push_str("out gl_PerVertex {\n  vec4 gl_Position;\n};\n");
    }

    vtx_src.push_str("in highp vec4 a_position;\n");
    vtx_src.push_str("uniform highp vec4 u_color;\n");

    // all these cases fall through
    if num_outputs >= 5 {
        vtx_src.push_str("layout(location = 3) out vec4 o_val5;\n");
    }
    if num_outputs >= 4 {
        vtx_src.push_str("flat out uvec4 val4;\n");
    }
    if num_outputs >= 3 {
        vtx_src.push_str("flat out ivec2 val3;\n");
    }
    if num_outputs >= 2 {
        vtx_src.push_str("out vec3 val2[2];\n");
    }
    if num_outputs >= 1 {
        vtx_src.push_str("out vec4 val1;\n");
    }
    vtx_src.push_str("out float val0;\n");

    vtx_src.push_str("void main (void)\n");
    vtx_src.push_str("{\n");
    vtx_src.push_str("   gl_Position = a_position;\n");

    // The color uniform is passed in the last declared output variable
    vtx_src.push_str(match num_outputs {
        5 => "    o_val5 = u_color;\n",
        4 => "    val4 = uvec4(u_color);\n",
        3 => "    val3 = ivec2(u_color);\n",
        2 => "    val2[0] = vec3(u_color);\n",
        1 => "    val1 = u_color;\n",
        _ => "    val0 = u_color.x;\n",
    });

    vtx_src.push_str("}\n");
    vtx_src
}

/// `generateVarLinkFragmentShaderSrc`
fn generate_var_link_fragment_shader_src(glsl_version: GlslVersion, num_inputs: i32) -> String {
    let mut frag_src = format!("{}\n", glsl_version.declaration());
    frag_src.push_str("precision highp float;\n");
    frag_src.push_str("precision highp int;\n");

    // all these cases fall through
    if num_inputs >= 5 {
        frag_src.push_str("layout(location = 3) in vec4 i_val5;\n");
    }
    if num_inputs >= 4 {
        frag_src.push_str("flat in uvec4 val4;\n");
    }
    if num_inputs >= 3 {
        frag_src.push_str("flat in ivec2 val3;\n");
    }
    if num_inputs >= 2 {
        frag_src.push_str("in vec3 val2[2];\n");
    }
    if num_inputs >= 1 {
        frag_src.push_str("in vec4 val1;\n");
    }
    frag_src.push_str("in float val0;\n");

    frag_src.push_str("layout(location = 0) out mediump vec4 o_color;\n");
    frag_src.push_str("void main (void)\n");
    frag_src.push_str("{\n");

    frag_src.push_str(match num_inputs {
        5 => "    o_color = i_val5;\n",
        4 => "    o_color = vec4(val4);\n",
        3 => "    o_color = vec4(val3, 1.0, 1.0);\n",
        2 => "    o_color = vec4(val2[0], 1.0);\n",
        1 => "    o_color = vec4(val1);\n",
        _ => "    o_color = vec4(val0, val0, val0, 1.0);\n",
    });

    frag_src.push_str("}\n");
    frag_src
}

/// `checkSurface`: the surface read back from the framebuffer is filled with the expected colour.
fn check_surface(gl: &glw::Functions, width: GLint, height: GLint, expected_color: [u8; 4]) -> bool {
    let mut surface = vec![0u8; width as usize * height as usize * 4];

    // SAFETY: the buffer holds width * height RGBA8 pixels; the pack alignment is 4 by default so rows are tight.
    unsafe {
        gl.read_pixels(
            0,
            0,
            width,
            height,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            surface.as_mut_ptr().cast(),
        )
    };

    surface.chunks_exact(4).all(|pixel| pixel == expected_color)
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("uniform names have no NUL");
    // SAFETY: the name is a live NUL-terminated string.
    unsafe { gl.get_uniform_location(program, name.as_ptr()) }
}

/// Draws the quad with the indices bound in the current vertex array (`drawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, NULL)`).
fn draw_quad_elements(gl: &glw::Functions) {
    // SAFETY: the vertex array bound by the caller has the index buffer of QUAD_INDICES.
    unsafe {
        gl.draw_elements(
            glw::GL_TRIANGLES,
            QUAD_INDICES.len() as GLsizei,
            glw::GL_UNSIGNED_SHORT,
            std::ptr::null(),
        )
    };
}

/// Sets `u_color`-like uniform of a separable program through glProgramUniform4f.
fn program_uniform_color(gl: &glw::Functions, program: GLuint, name: &str, color: [f32; 4]) {
    // SAFETY: plain state call.
    unsafe {
        gl.program_uniform_4f(
            program,
            uniform_location(gl, program, name),
            color[0],
            color[1],
            color[2],
            color[3],
        )
    };
}

impl TestCase for StateInteractionCase {
    fn name(&self) -> &str {
        "StateInteraction"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let viewport_w = 16.min(render_target.width);
        let viewport_h = 16.min(render_target.height);

        log::info!("Begin:StateInteractionCase iterate");

        // SAFETY: plain state calls.
        unsafe {
            gl.viewport(0, 0, viewport_w, viewport_h);
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        // Check the precedence of glUseProgram over glBindProgramPipeline: the program bound with glUseProgram draws green, the programs bound with glBindProgramPipeline render blue.
        let vtx = generate_basic_vertex_src(self.glsl_version);
        let mut frag = generate_basic_fragment_src(self.glsl_version);

        let prog_vf = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vtx.clone(), frag.clone()));
        // SAFETY: plain state calls; the program linked.
        unsafe { gl.use_program(prog_vf.program()) };

        // Output green in the fragment shader
        // SAFETY: the location comes from the program in use.
        unsafe { gl.uniform_4f(uniform_location(gl, prog_vf.program(), "u_color"), 0.0, 1.0, 0.0, 1.0) };

        // Create and bind a pipeline with a different fragment shader
        let mut pipeline: GLuint = 0;
        // SAFETY: one name of output is given.
        unsafe { gl.gen_program_pipelines(1, &mut pipeline) };

        // Use a different uniform name in another fragment shader
        let frag2 = frag.replace("u_color", "u_clrPB");

        let mut program_a = create_shader_programv(gl, glw::GL_VERTEX_SHADER, 1, &[&vtx]);
        if !check_cs_prog(gl, program_a, glw::GL_TRUE as GLint)? {
            return fail("CreateShaderProgramv failed for vertex shader");
        }

        let mut program_b = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, 1, &[&frag2]);
        if !check_cs_prog(gl, program_b, glw::GL_TRUE as GLint)? {
            return fail("CreateShaderProgramv failed for fragment shader");
        }

        // Program B outputs blue.
        program_uniform_color(gl, program_b, "u_clrPB", [0.0, 0.0, 1.0, 1.0]);

        // SAFETY: plain state calls.
        unsafe {
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_a);
            gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_b);
            gl.bind_program_pipeline(pipeline);
        }

        // Draw a quad with glu::draw
        let pos_array = va::float("a_position", 4, 4, 0, &POSITION);
        glu::draw(
            &context.render_context,
            prog_vf.program(),
            &[pos_array],
            &pr::triangles(&QUAD_INDICES),
        )?;
        glu::expect_no_error(gl, "StateInteraction glu::draw failure")?;

        // useProgram takes precedence and the buffer should be green
        if !check_surface(gl, viewport_w, viewport_h, [0, 255, 0, 255]) {
            return fail("StateInteraction failed; surface should be green");
        }

        // The position attribute locations may be different.
        let name = CString::new("a_position").expect("no NUL");

        // Set up a vertex array object
        let mut vao: GLuint = 0;
        let mut index_buf: GLuint = 0;
        let mut vertex_buf: GLuint = 0;
        // SAFETY: names are generated into live locals; the data pointers address the constant arrays with the sizes passed.
        unsafe {
            gl.gen_vertex_arrays(1, &mut vao);
            gl.bind_vertex_array(vao);

            gl.gen_buffers(1, &mut index_buf);
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buf);
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&QUAD_INDICES) as isize,
                QUAD_INDICES.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.gen_buffers(1, &mut vertex_buf);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_buf);
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&POSITION) as isize,
                POSITION.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            let pos_loc = gl.get_attrib_location(program_a, name.as_ptr()) as GLuint;
            gl.vertex_attrib_pointer(pos_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            gl.enable_vertex_attrib_array(pos_loc);

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        }
        glu::expect_no_error(gl, "VAO setup failure")?;

        // bindProgramPipeline without a program installed by useProgram. Rerender the quad; glu::draw is not used because it takes the program as a parameter and sets state.
        // SAFETY: plain state calls.
        unsafe {
            gl.use_program(0);
            gl.bind_program_pipeline(pipeline);
        }
        draw_quad_elements(gl);
        glu::expect_no_error(gl, "DrawElements failure")?;

        // bindProgramPipeline will render blue
        if !check_surface(gl, viewport_w, viewport_h, [0, 0, 255, 255]) {
            return fail("StateInteraction failed; surface should be blue");
        }

        // Test rendering with no program bound. Rendering is undefined but shouldn't produce an error.
        // SAFETY: plain state calls.
        unsafe {
            gl.use_program(0);
            gl.bind_program_pipeline(0);
        }
        draw_quad_elements(gl);
        glu::expect_no_error(gl, "DrawElements failure")?;

        // Render call with missing pipeline stages should not generate an error
        // SAFETY: plain state calls.
        unsafe {
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, 0);
            gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_b);
            gl.bind_program_pipeline(pipeline);
        }
        draw_quad_elements(gl);
        glu::expect_no_error(gl, "DrawElements failure")?;

        // SAFETY: plain state calls.
        unsafe {
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_a);
            gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, 0);
        }
        draw_quad_elements(gl);
        glu::expect_no_error(gl, "DrawElements failure")?;

        // Missing program for fragment shader
        // SAFETY: plain state call.
        unsafe {
            gl.use_program_stages(
                pipeline,
                glw::GL_VERTEX_SHADER_BIT | glw::GL_FRAGMENT_SHADER_BIT,
                program_a,
            )
        };
        draw_quad_elements(gl);
        glu::expect_no_error(gl, "DrawElements failure")?;

        // Separable program with both vertex and fragment shaders attached to only one stage
        // SAFETY: plain state calls.
        unsafe {
            gl.program_parameteri(prog_vf.program(), glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint);
            gl.link_program(prog_vf.program());
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, prog_vf.program());
        }
        draw_quad_elements(gl);
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("DrawElements failed");
        }

        // SAFETY: plain state call.
        unsafe { gl.validate_program_pipeline(pipeline) };
        if get_program_pipeline(gl, pipeline, glw::GL_VALIDATE_STATUS) != 0 {
            return fail("Program pipeline validation failed");
        }

        // attached to just the fragment shader; call validateProgramPipeline before rendering this time
        // SAFETY: plain state calls.
        unsafe {
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, 0);
            gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, prog_vf.program());
            gl.validate_program_pipeline(pipeline);
        }
        if get_program_pipeline(gl, pipeline, glw::GL_VALIDATE_STATUS) != 0 {
            return fail("Program pipeline validation failed");
        }

        draw_quad_elements(gl);
        if get_error(gl) != glw::GL_INVALID_OPERATION {
            return fail("DrawElements failed");
        }

        // Program deletion
        // SAFETY: plain state calls.
        unsafe {
            gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_a);
            gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_b);
        }

        // Program B renders red this time
        program_uniform_color(gl, program_b, "u_clrPB", [1.0, 0.0, 0.0, 1.0]);

        // SAFETY: plain state call.
        unsafe { gl.delete_program(program_b) };
        draw_quad_elements(gl);

        // expect red
        if !check_surface(gl, viewport_w, viewport_h, [255, 0, 0, 255]) {
            return fail("StateInteraction failed; surface should be red");
        }

        // Attach new shader
        program_b = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, 1, &[&frag2]);
        if !check_cs_prog(gl, program_b, glw::GL_TRUE as GLint)? {
            return fail("CreateShaderProgramv failed for fragment shader");
        }

        // Render green
        program_uniform_color(gl, program_b, "u_clrPB", [0.0, 1.0, 0.0, 1.0]);
        // SAFETY: plain state call.
        unsafe { gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_b) };

        // new shader; the first fragment shader, with the u_color uniform
        // SAFETY: plain object creation.
        let vshader = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
        set_shader_source(gl, vshader, &frag);
        // SAFETY: plain state call.
        unsafe { gl.compile_shader(vshader) };
        debug_assert!(get_shader(gl, vshader, glw::GL_COMPILE_STATUS) == glw::GL_TRUE as GLint);
        // SAFETY: plain state call.
        unsafe { gl.attach_shader(program_b, vshader) };

        // changing shader shouldn't affect link_status
        if get_program(gl, program_b, glw::GL_LINK_STATUS) != 1 {
            return fail("Shader attachment shouldn't affect link status");
        }

        draw_quad_elements(gl);
        glu::expect_no_error(gl, "DrawElements failure")?;

        // expect green
        if !check_surface(gl, viewport_w, viewport_h, [0, 255, 0, 255]) {
            return fail("StateInteraction failed; surface should be green");
        }

        // Negative Case: Unsuccessfully linked program should not affect current program; render white
        program_uniform_color(gl, program_b, "u_clrPB", [1.0, 1.0, 1.0, 1.0]);

        let no_main = frag.replacen("main", "niaM", 1);
        set_shader_source(gl, vshader, &no_main);
        // SAFETY: plain state calls.
        unsafe { gl.compile_shader(vshader) };
        let _ = get_shader(gl, vshader, glw::GL_COMPILE_STATUS);
        // SAFETY: plain state calls.
        unsafe {
            gl.attach_shader(program_b, vshader);
            gl.link_program(program_b);
        }
        let _ = get_error(gl);

        // link_status should be false
        if get_program(gl, program_b, glw::GL_LINK_STATUS) != 0 {
            return fail("StateInteraction failed; link failure");
        }

        draw_quad_elements(gl);

        // expect white
        if !check_surface(gl, viewport_w, viewport_h, [255, 255, 255, 255]) {
            return fail("StateInteraction failed; surface should be white");
        }

        // SAFETY: plain object deletion.
        unsafe {
            gl.delete_program(program_a);
            gl.delete_program(program_b);
        }

        // Shader interface matching inputs/outputs
        let max_vars = 6;
        for num_inputs in 0..max_vars {
            for num_outputs in 0..max_vars {
                let vtx = generate_var_link_vertex_shader_src(self.glsl_version, num_outputs);
                frag = generate_var_link_fragment_shader_src(self.glsl_version, num_inputs);

                program_a = create_shader_programv(gl, glw::GL_VERTEX_SHADER, 1, &[&vtx]);
                if !check_cs_prog(gl, program_a, glw::GL_TRUE as GLint)? {
                    return fail("CreateShaderProgramv failed for vertex shader");
                }

                program_b = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, 1, &[&frag]);
                if !check_cs_prog(gl, program_b, glw::GL_TRUE as GLint)? {
                    return fail("CreateShaderProgramv failed for fragment shader");
                }

                // SAFETY: plain state calls.
                unsafe {
                    gl.use_program_stages(pipeline, glw::GL_VERTEX_SHADER_BIT, program_a);
                    gl.use_program_stages(pipeline, glw::GL_FRAGMENT_SHADER_BIT, program_b);
                }
                glu::expect_no_error(gl, "UseProgramStages failure")?;

                // SAFETY: plain state call.
                unsafe { gl.validate_program_pipeline(pipeline) };
                let value = get_program_pipeline(gl, pipeline, glw::GL_VALIDATE_STATUS) as GLint;

                // Matched input and output variables should render
                if num_inputs == num_outputs {
                    if value != 1 {
                        log::info!(
                            "Matched input and output variables should validate successfully.\nVertex Shader:\n{vtx}Fragment Shader:\n{frag}"
                        );

                        return fail("StateInteraction failed");
                    }

                    // SAFETY: plain state call.
                    unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };

                    // white
                    program_uniform_color(gl, program_a, "u_color", [1.0, 1.0, 1.0, 1.0]);
                    draw_quad_elements(gl);
                    glu::expect_no_error(gl, "DrawElements failure")?;

                    // expect white
                    if !check_surface(gl, viewport_w, viewport_h, [255, 255, 255, 255]) {
                        return fail("StateInteraction failed; surface should be white");
                    }
                } else if value == 0 {
                    // Mismatched input and output variables: for OpenGL contexts, validation should succeed.
                    log::info!(
                        "Mismatched input and output variables; validation should succeed.\nVertex Shader:\n{vtx}Fragment Shader:\n{frag}"
                    );

                    return fail("StateInteraction failed");
                }

                // SAFETY: plain object deletion.
                unsafe {
                    gl.delete_program(program_a);
                    gl.delete_program(program_b);
                }
            }
        }

        // SAFETY: plain object deletion; every name was generated above.
        unsafe {
            gl.bind_program_pipeline(0);
            gl.bind_vertex_array(0);
            gl.delete_program_pipelines(1, &pipeline);
            gl.delete_shader(vshader);
            gl.delete_vertex_arrays(1, &vao);
            gl.delete_buffers(1, &index_buf);
            gl.delete_buffers(1, &vertex_buf);
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `glShaderSource` of a single string.
fn set_shader_source(gl: &glw::Functions, shader: GLuint, source: &str) {
    let source = CString::new(source).expect("shader sources have no NUL");
    let pointer = source.as_ptr();
    // SAFETY: one live NUL-terminated string is passed with a null length array.
    unsafe { gl.shader_source(shader, 1, &pointer, std::ptr::null()) };
}

/// `glGetShaderiv` of one pname.
fn get_shader(gl: &glw::Functions, shader: GLuint, pname: glw::GLenum) -> GLint {
    let mut value: GLint = 0;
    // SAFETY: one integer of output is given.
    unsafe { gl.get_shaderiv(shader, pname, &mut value) };
    value
}
