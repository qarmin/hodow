// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcClipDistance.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`m_isContextES` is always false in the roots that register this group), so the ES `EXTENSION`/`PRECISION` specializations are empty and `readBuffer` always maps with `glMapBuffer`. `Utility::Program` is `glu::ShaderProgram` (a failed build is `!is_ok()` where upstream has `program_id == 0`); `Utility::VertexBufferObject<T>` is generic only in its constructor, because the one `useAsShaderInput` caller is the float one (the `GLint` branch is unreachable upstream too). The destructors' `GLU_EXPECT_NO_ERROR` checks are not ported (throwing from a destructor is undefined upstream).

use std::ffi::{CString, c_void};

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestResult, TestStatus};

fn specialization(context: &Context) -> Vec<(&'static str, String)> {
    vec![
        (
            "VERSION",
            context.context_type().glsl_version().declaration().to_string(),
        ),
        ("EXTENSION", String::new()),
        ("PRECISION", String::new()),
    ]
}

fn preprocess_code(source: &str, key: &str, value: &str) -> String {
    source.replace(key, value)
}

fn get_integer(gl: &glw::Functions, pname: glw::GLenum) -> i32 {
    let mut value = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(pname, &mut value) };
    value
}

fn build_program<'gl>(
    gl: &'gl glw::Functions,
    vertex: &str,
    fragment: &str,
    transform_feedback_varyings: &[String],
    expecting_failure: bool,
) -> ShaderProgram<'gl> {
    let mut sources = ProgramSources::vtx_frag(vertex, fragment);
    if !transform_feedback_varyings.is_empty() {
        sources = sources.with_transform_feedback(transform_feedback_varyings, glw::GL_INTERLEAVED_ATTRIBS);
    }
    if expecting_failure {
        ShaderProgram::new_expecting_build_failure(gl, &sources)
    } else {
        ShaderProgram::new(gl, &sources)
    }
}

fn log_program_failure(program: &ShaderProgram<'_>, vertex: &str, fragment: &str) {
    log::info!(
        "Program failed to build.\n Vertex Shader:\n{vertex}\nWith Fragment Shader:\n{fragment}\nWith build log:\n{}\n",
        program.build_failure_summary().unwrap_or_default()
    );
}

// ---------------------------------------------------------------------------------------------
// Utility::Framebuffer / VertexArrayObject / VertexBufferObject
// ---------------------------------------------------------------------------------------------

struct Framebuffer<'gl> {
    gl: &'gl glw::Functions,
    size_x: i32,
    size_y: i32,
    framebuffer_id: glw::GLuint,
    renderbuffer_id: glw::GLuint,
}

impl<'gl> Framebuffer<'gl> {
    fn new(gl: &'gl glw::Functions, size_x: i32, size_y: i32) -> Result<Self, TestError> {
        let mut framebuffer = Self {
            gl,
            size_x,
            size_y,
            framebuffer_id: 0,
            renderbuffer_id: 0,
        };

        // SAFETY: names are written to the fields of `framebuffer`, which deletes them on drop.
        unsafe {
            gl.gen_framebuffers(1, &mut framebuffer.framebuffer_id);
            glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;

            gl.gen_renderbuffers(1, &mut framebuffer.renderbuffer_id);
            glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.framebuffer_id);
            glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;

            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, framebuffer.renderbuffer_id);
            glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;

            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R32F, size_x, size_y);
            glu::expect_no_error(gl, "glRenderbufferStorage call failed.")?;

            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                framebuffer.renderbuffer_id,
            );
            glu::expect_no_error(gl, "glFramebufferRenderbuffer call failed.")?;

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                gl.delete_framebuffers(1, &framebuffer.framebuffer_id);
                framebuffer.framebuffer_id = 0;

                gl.delete_renderbuffers(1, &framebuffer.renderbuffer_id);
                framebuffer.renderbuffer_id = 0;

                glu::expect_no_error(gl, "glDeleteRenderbuffers call failed.")?;
            }
        }

        Ok(framebuffer)
    }

    fn is_valid(&self) -> bool {
        self.framebuffer_id != 0
    }

    fn bind(&self) -> Result<(), TestError> {
        // SAFETY: plain state calls.
        unsafe {
            self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer_id);
            glu::expect_no_error(self.gl, "glBindFramebuffer call failed.")?;

            self.gl.viewport(0, 0, self.size_x, self.size_y);
            glu::expect_no_error(self.gl, "glViewport call failed.")?;
        }
        Ok(())
    }

    fn read_pixels(&self) -> Result<Vec<f32>, TestError> {
        let mut pixels = vec![0.0f32; (self.size_x * self.size_y) as usize];

        if self.size_x > 0 && self.size_y > 0 {
            // SAFETY: the buffer holds size_x * size_y floats, one GL_RED float per pixel.
            unsafe {
                self.gl.read_pixels(
                    0,
                    0,
                    self.size_x,
                    self.size_y,
                    glw::GL_RED,
                    glw::GL_FLOAT,
                    pixels.as_mut_ptr() as *mut c_void,
                );
            }
            glu::expect_no_error(self.gl, "glReadPixels call failed.")?;
        }

        Ok(pixels)
    }

    fn clear(&self) -> Result<(), TestError> {
        if self.is_valid() {
            // SAFETY: plain state calls.
            unsafe {
                self.gl.clear_color(0.0, 0.0, 0.0, 1.0);
                glu::expect_no_error(self.gl, "glClearColor call failed.")?;

                self.gl.clear(glw::GL_COLOR_BUFFER_BIT);
                glu::expect_no_error(self.gl, "glClear call failed.")?;
            }
        }
        Ok(())
    }
}

impl Drop for Framebuffer<'_> {
    fn drop(&mut self) {
        // SAFETY: the names are this object's own and are deleted once.
        unsafe {
            if self.framebuffer_id != 0 {
                self.gl.delete_framebuffers(1, &self.framebuffer_id);
            }
            if self.renderbuffer_id != 0 {
                self.gl.delete_renderbuffers(1, &self.renderbuffer_id);
            }
        }
    }
}

struct VertexArrayObject<'gl> {
    gl: &'gl glw::Functions,
    vertex_array_object_id: glw::GLuint,
    primitive_type: glw::GLenum,
}

impl<'gl> VertexArrayObject<'gl> {
    fn new(gl: &'gl glw::Functions, primitive_type: glw::GLenum) -> Result<Self, TestError> {
        let mut vao = Self {
            gl,
            vertex_array_object_id: 0,
            primitive_type,
        };

        // SAFETY: the name is written to the field of `vao`, which deletes it on drop.
        unsafe {
            gl.gen_vertex_arrays(1, &mut vao.vertex_array_object_id);
            glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;

            gl.bind_vertex_array(vao.vertex_array_object_id);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        }

        Ok(vao)
    }

    fn draw(&self, first: i32, count: i32) -> Result<(), TestError> {
        // SAFETY: a plain draw with the vertex array bound by the constructor.
        unsafe { self.gl.draw_arrays(self.primitive_type, first, count) };
        glu::expect_no_error(self.gl, "glDrawArrays() call failed.")
    }

    fn draw_with_transform_feedback(&self, first: i32, count: i32, discard_rasterizer: bool) -> Result<(), TestError> {
        // SAFETY: plain state calls around the draw.
        unsafe {
            if discard_rasterizer {
                self.gl.enable(glw::GL_RASTERIZER_DISCARD);
                glu::expect_no_error(self.gl, "glEnable call failed.")?;
            }

            self.gl.begin_transform_feedback(glw::GL_POINTS);
            glu::expect_no_error(self.gl, "glBeginTransformFeedback call failed.")?;

            self.draw(first, count)?;

            self.gl.end_transform_feedback();
            glu::expect_no_error(self.gl, "glEndTransformFeedback call failed.")?;

            if discard_rasterizer {
                self.gl.disable(glw::GL_RASTERIZER_DISCARD);
                glu::expect_no_error(self.gl, "glDisbale call failed.")?;
            }
        }
        Ok(())
    }
}

impl Drop for VertexArrayObject<'_> {
    fn drop(&mut self) {
        if self.vertex_array_object_id != 0 {
            // SAFETY: the name is this object's own.
            unsafe { self.gl.delete_vertex_arrays(1, &self.vertex_array_object_id) };
        }
    }
}

struct VertexBufferObject<'gl> {
    gl: &'gl glw::Functions,
    vertex_buffer_object_id: glw::GLuint,
    target: glw::GLenum,
    size: usize,
    enabled_arrays: Vec<glw::GLuint>,
}

impl<'gl> VertexBufferObject<'gl> {
    fn new<T: Copy>(gl: &'gl glw::Functions, target: glw::GLenum, data: &[T]) -> Result<Self, TestError> {
        let mut vbo = Self {
            gl,
            vertex_buffer_object_id: 0,
            target,
            size: 0,
            enabled_arrays: Vec::new(),
        };

        // SAFETY: the name is written to the field of `vbo`, which deletes it on drop.
        unsafe { gl.gen_buffers(1, &mut vbo.vertex_buffer_object_id) };
        glu::expect_no_error(gl, "glGenBuffers call failed.")?;

        if vbo.vertex_buffer_object_id != 0 {
            vbo.size = std::mem::size_of_val(data);
            vbo.bind()?;

            // SAFETY: `size` bytes of `data` are read.
            unsafe {
                gl.buffer_data(
                    target,
                    vbo.size as isize,
                    data.as_ptr() as *const c_void,
                    glw::GL_STATIC_DRAW,
                )
            };
            glu::expect_no_error(gl, "glBufferData call failed.")?;
        }

        Ok(vbo)
    }

    fn bind(&self) -> Result<bool, TestError> {
        if self.vertex_buffer_object_id != 0 {
            // SAFETY: plain binds of this object's buffer.
            unsafe {
                self.gl.bind_buffer(self.target, self.vertex_buffer_object_id);
                glu::expect_no_error(self.gl, "glBindBuffer call failed.")?;

                if self.target == glw::GL_TRANSFORM_FEEDBACK_BUFFER {
                    self.gl
                        .bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.vertex_buffer_object_id);
                    glu::expect_no_error(self.gl, "glBindBufferBase call failed.")?;
                }
            }
            return Ok(true);
        }
        Ok(false)
    }

    /// The `GLfloat` branch of `useAsShaderInput`.
    fn use_as_shader_input(
        &mut self,
        program: &ShaderProgram<'_>,
        input_attribute_name: &str,
        number_of_components: i32,
    ) -> Result<bool, TestError> {
        if program.is_ok() {
            let name = CString::new(input_attribute_name).expect("attribute names have no NUL");
            // SAFETY: `name` is NUL-terminated.
            let location = unsafe { self.gl.get_attrib_location(program.program(), name.as_ptr()) };
            glu::expect_no_error(self.gl, "glGetAttribLocation call failed.")?;

            if location >= 0 {
                // SAFETY: the buffer bound by `bind` is the attribute's source, offset 0.
                unsafe {
                    self.gl.enable_vertex_attrib_array(location as u32);
                    glu::expect_no_error(self.gl, "glEnableVertexAttribArray call failed.")?;

                    self.enabled_arrays.push(location as u32);

                    self.bind()?;

                    self.gl.vertex_attrib_pointer(
                        location as u32,
                        number_of_components,
                        glw::GL_FLOAT,
                        glw::FALSE,
                        0,
                        std::ptr::null(),
                    );
                    glu::expect_no_error(self.gl, "glVertexAttribPointer call failed.")?;
                }
                return Ok(true);
            }
        }
        Ok(false)
    }

    fn read_buffer<T: Copy + Default>(&self) -> Result<Vec<T>, TestError> {
        let mut buffer_data = vec![T::default(); self.size / std::mem::size_of::<T>()];

        self.bind()?;

        // SAFETY: a non-null mapping covers the `size` bytes the buffer was created with, and the copy stays within the vector.
        unsafe {
            let results = self.gl.map_buffer(self.target, glw::GL_READ_ONLY);
            if !results.is_null() {
                std::ptr::copy_nonoverlapping(
                    results as *const u8,
                    buffer_data.as_mut_ptr() as *mut u8,
                    buffer_data.len() * std::mem::size_of::<T>(),
                );
            }
            self.gl.unmap_buffer(self.target);
        }

        Ok(buffer_data)
    }
}

impl Drop for VertexBufferObject<'_> {
    fn drop(&mut self) {
        // SAFETY: the name is this object's own; deleting silently unbinds the buffer.
        unsafe {
            self.gl.delete_buffers(1, &self.vertex_buffer_object_id);
            for &enabled_array in &self.enabled_arrays {
                self.gl.disable_vertex_attrib_array(enabled_array);
            }
        }
    }
}

// ---------------------------------------------------------------------------------------------
// CoverageTest
// ---------------------------------------------------------------------------------------------

const COVERAGE_VS_CASE_0: &str = "${VERSION}\n\
${EXTENSION}\n\
flat out int max_value;\n\
\n\
void main()\n\
{\n\
    max_value   = gl_MaxClipDistances;\n\
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n\
}\n";

const COVERAGE_FS_CASE_0: &str = "${VERSION}\n\
${PRECISION}\n\
out vec4 color;\n\
\n\
void main()\n\
{\n\
    color = vec4(0.0, 0.0, 0.0, 1.0);\n\
}\n";

const COVERAGE_VS_CASE_1: &str = "${VERSION}\n\
\n\
void main()\n\
{\n\
    gl_Position  = vec4(0.0, 0.0, 0.0, 1.0);\n\
}\n";

const COVERAGE_FS_CASE_1: &str = "${VERSION}\n\
${EXTENSION}\n\
${PRECISION}\n\
\n\
out highp vec4 color;\n\
\n\
void main()\n\
{\n\
    color = vec4(float(gl_MaxClipDistances), 0.0, 0.0, 1.0);\n\
}\n";

const COVERAGE_VS_CASE_2: &str = "${VERSION}\n\
${EXTENSION}\n\
\n\
out float gl_ClipDistance[gl_MaxClipDistances];\n\
\n\
void main()\n\
{\n\
    for(int i = 0; i < gl_MaxClipDistances; i++)\n\
    {\n\
        gl_ClipDistance[i] = float(i + 1) / float(gl_MaxClipDistances);\n\
    }\n\
\n\
    gl_Position  = vec4(0.0, 0.0, 0.0, 1.0);\n\
}\n";

const COVERAGE_FS_CASE_2: &str = "${VERSION}\n\
${EXTENSION}\n\
${PRECISION}\n\
\n\
in float gl_ClipDistance[gl_MaxClipDistances];\n\
\n\
out highp vec4 color;\n\
\n\
void main()\n\
{\n\
    for(int i = 0; i < gl_MaxClipDistances; i++)\n\
    {\n\
        if(abs(gl_ClipDistance[i] - float(i + 1) / float(gl_MaxClipDistances)) > 0.0125)\n\
        {\n\
            discard;\n\
        }\n\
    }\n\
\n\
    color = vec4(1.0, 0.0, 0.0, 1.0);\n\
}\n";

/// `CoverageTest::MaxClipDistancesValueTest`; the queried limit goes to `max_clip_distances`.
fn max_clip_distances_value_test(context: &Context, max_clip_distances: &mut i32) -> bool {
    let gl = context.gl();

    *max_clip_distances = get_integer(gl, glw::GL_MAX_CLIP_DISTANCES);

    // SAFETY: no arguments.
    let error_code = unsafe { gl.get_error() };

    if error_code != glw::GL_NO_ERROR {
        log::info!(
            "glGetIntegerv(GL_MAX_CLIP_DISTANCES) returned error code {} instead of GL_NO_ERROR.",
            glw::error_name(error_code)
        );
        return false;
    }

    let mut gl_max_clip_distances_minimum_value = 6;

    if context.context_type().supports_core(3, 1) {
        gl_max_clip_distances_minimum_value = 8;
    }

    if *max_clip_distances < gl_max_clip_distances_minimum_value {
        log::info!(
            "Value of GL_MAX_CLIP_DISTANCES is equal to {} which is less than minimum required ({}).",
            *max_clip_distances,
            gl_max_clip_distances_minimum_value
        );
        return false;
    }

    true
}

/// `CoverageTest::EnableDisableTest`
fn enable_disable_test(gl: &glw::Functions, max_clip_distances: i32) -> bool {
    for i in 0..max_clip_distances {
        // SAFETY: plain capability toggle.
        unsafe { gl.enable(glw::GL_CLIP_DISTANCE0 + i as u32) };

        // SAFETY: no arguments.
        let error_code = unsafe { gl.get_error() };
        if error_code != glw::GL_NO_ERROR {
            log::info!(
                "glEnable(GL_CLIP_DISTANCE{i}) returned error code {} instead of GL_NO_ERROR.",
                glw::error_name(error_code)
            );
            return false;
        }
    }

    for i in 0..max_clip_distances {
        // SAFETY: plain capability toggle.
        unsafe { gl.disable(glw::GL_CLIP_DISTANCE0 + i as u32) };

        // SAFETY: no arguments.
        let error_code = unsafe { gl.get_error() };
        if error_code != glw::GL_NO_ERROR {
            log::info!(
                "glDisable(GL_CLIP_DISTANCE{i}) returned error code {} instead of GL_NO_ERROR.",
                glw::error_name(error_code)
            );
            return false;
        }
    }

    true
}

/// `CoverageTest::MaxClipDistancesValueInVertexShaderTest`
fn max_clip_distances_value_in_vertex_shader_test(
    context: &Context,
    max_clip_distances: i32,
) -> Result<bool, TestError> {
    let gl = context.gl();
    let specialization = specialization(context);

    let vertex_shader = StringTemplate::new(COVERAGE_VS_CASE_0).specialize(&specialization)?;
    let fragment_shader = StringTemplate::new(COVERAGE_FS_CASE_0).specialize(&specialization)?;

    let transform_feedback_varyings = vec!["max_value".to_string()];

    let program = build_program(
        gl,
        &vertex_shader,
        &fragment_shader,
        &transform_feedback_varyings,
        false,
    );

    if !program.is_ok() {
        log_program_failure(&program, &vertex_shader, &fragment_shader);
        return Ok(false);
    }

    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "glUseProgram call failed.")?;

    let vertex_array_object = VertexArrayObject::new(gl, glw::GL_POINTS)?;

    let vertex_buffer_object = VertexBufferObject::new(gl, glw::GL_TRANSFORM_FEEDBACK_BUFFER, &[0i32])?;

    vertex_array_object.draw_with_transform_feedback(0, 1, true)?;

    let results = vertex_buffer_object.read_buffer::<i32>()?;

    if results.is_empty() {
        log::info!("Results reading error.");
        return Ok(false);
    }

    if results[0] != max_clip_distances {
        log::info!(
            "Vertex shader's gl_MaxClipDistances constant has improper value equal to {}but {}is expected. Test failed.",
            results[0],
            max_clip_distances
        );
        return Ok(false);
    }

    Ok(true)
}

/// `CoverageTest::MaxClipDistancesValueInFragmentShaderTest`
fn max_clip_distances_value_in_fragment_shader_test(
    context: &Context,
    max_clip_distances: i32,
) -> Result<bool, TestError> {
    let gl = context.gl();
    let specialization = specialization(context);

    let framebuffer = Framebuffer::new(gl, 1, 1)?;

    if !framebuffer.is_valid() {
        log::info!("Unable to create framebuffer with size [1,1].\n");
        return Ok(false);
    }

    framebuffer.bind()?;
    framebuffer.clear()?;

    let vertex_shader = StringTemplate::new(COVERAGE_VS_CASE_1).specialize(&specialization)?;
    let fragment_shader = StringTemplate::new(COVERAGE_FS_CASE_1).specialize(&specialization)?;

    let program = build_program(gl, &vertex_shader, &fragment_shader, &[], false);

    if !program.is_ok() {
        log_program_failure(&program, &vertex_shader, &fragment_shader);
        return Ok(false);
    }

    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "glUseProgram call failed.")?;

    let vertex_array_object = VertexArrayObject::new(gl, glw::GL_POINTS)?;

    vertex_array_object.draw(0, 1)?;

    let pixels = framebuffer.read_pixels()?;

    if pixels.is_empty() {
        log::info!("ReadPixels error.\n");
        return Ok(false);
    }

    let gl_max_clip_distances_value_in_fragment_shader = pixels[0] as u32;

    if gl_max_clip_distances_value_in_fragment_shader != max_clip_distances as u32 {
        log::info!(
            "Fragment shader's gl_MaxClipDistances constant has improper value equal to {gl_max_clip_distances_value_in_fragment_shader}but {max_clip_distances}is expected. Test failed."
        );
        return Ok(false);
    }

    Ok(true)
}

/// `CoverageTest::ClipDistancesValuePassing`
fn clip_distances_value_passing(context: &Context, max_clip_distances: i32) -> Result<bool, TestError> {
    let gl = context.gl();
    let specialization = specialization(context);

    for i in 0..max_clip_distances {
        // SAFETY: plain capability toggle.
        unsafe { gl.enable(glw::GL_CLIP_DISTANCE0 + i as u32) };
    }

    let framebuffer = Framebuffer::new(gl, 1, 1)?;

    if !framebuffer.is_valid() {
        log::info!("Unable to create framebuffer with size [1,1].\n");
        return Ok(false);
    }

    framebuffer.bind()?;
    framebuffer.clear()?;

    let vertex_shader = StringTemplate::new(COVERAGE_VS_CASE_2).specialize(&specialization)?;
    let fragment_shader = StringTemplate::new(COVERAGE_FS_CASE_2).specialize(&specialization)?;

    let program = build_program(gl, &vertex_shader, &fragment_shader, &[], false);

    if !program.is_ok() {
        log_program_failure(&program, &vertex_shader, &fragment_shader);
        return Ok(false);
    }

    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "glUseProgram call failed.")?;

    let vertex_array_object = VertexArrayObject::new(gl, glw::GL_POINTS)?;

    vertex_array_object.draw(0, 1)?;

    let pixels = framebuffer.read_pixels()?;

    if pixels.is_empty() {
        log::info!("ReadPixels error.\n");
        return Ok(false);
    }

    for i in 0..max_clip_distances {
        // SAFETY: plain capability toggle.
        unsafe { gl.disable(glw::GL_CLIP_DISTANCE0 + i as u32) };
    }

    let results = pixels[0];

    if (f64::from(results) - 1.0).abs() > 0.0125 {
        log::info!("Fragment shader values of gl_Clip_distance does not match vertex shader's output value.");
        return Ok(false);
    }

    Ok(true)
}

/// `CoverageTest::test`
fn coverage_test(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let mut max_clip_distances = 0;

    let mut is_ok = true;

    is_ok = is_ok && max_clip_distances_value_test(context, &mut max_clip_distances);
    is_ok = is_ok && enable_disable_test(gl, max_clip_distances);
    is_ok = is_ok && max_clip_distances_value_in_vertex_shader_test(context, max_clip_distances)?;
    is_ok = is_ok && max_clip_distances_value_in_fragment_shader_test(context, max_clip_distances)?;
    is_ok = is_ok && clip_distances_value_passing(context, max_clip_distances)?;

    Ok(if is_ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

// ---------------------------------------------------------------------------------------------
// FunctionalTest
// ---------------------------------------------------------------------------------------------

const FUNCTIONAL_VS: &str = "${VERSION}\n\
${EXTENSION}\n\
\n\
CLIP_DISTANCE_REDECLARATION\
\n\
CLIP_FUNCTION\
\n\
in vec4 position;\n\
\n\
void main()\n\
{\n\
CLIP_DISTANCE_SETUP\
\n\
    gl_Position  = position;\n\
}\n";

const FUNCTIONAL_FS: &str = "${VERSION}\n\
${PRECISION}\n\
\n\
out highp vec4 color;\n\
\n\
void main()\n\
{\n\
    color = vec4(1.0, 0.0, 0.0, 1.0);\n\
}\n";

const EXPLICIT_REDECLARATION: &str = "out float gl_ClipDistance[CLIP_COUNT];\n";

const DYNAMIC_ARRAY_SETTER: &str = "    for(int i = 0; i < CLIP_COUNT; i++)\n\
    {\n\
        gl_ClipDistance[i] = f(i);\n\
    }\n";

const STATIC_ARRAY_SETTER: &str = "    gl_ClipDistance[CLIP_INDEX] = f(CLIP_INDEX);\n";

const CLIP_FUNCTION: [&str; 4] = [
    "float f(int i)\n\
{\n\
    return 0.0;\n\
}\n",
    "float f(int i)\n\
{\n\
    return 0.25 + 0.75 * (float(i) + 1.0) * (float(gl_VertexID) + 1.0) / (float(CLIP_COUNT) * float(VERTEX_COUNT));\n\
}\n",
    "float f(int i)\n\
{\n\
    return - 0.25 - 0.75 * (float(i) + 1.0) * (float(gl_VertexID) + 1.0) / (float(CLIP_COUNT) * float(VERTEX_COUNT));\n\
}\n",
    "#define PI 3.1415926535897932384626433832795\n\
\n\
float f(int i)\n\
{\n\
    if(i == 0)\n\
    {\n\
        return cos( float(gl_VertexID) * PI / ceil( float(VERTEX_COUNT)/2.0 ) );\n\
    }\n\
\n\
    return 0.25 + 0.75 * (float(i) + 1.0) * (float(gl_VertexID) + 1.0) / (float(CLIP_COUNT) * float(VERTEX_COUNT));\n\
}\n",
];

const PRIMITIVE_TYPES: [glw::GLenum; 3] = [glw::GL_POINTS, glw::GL_LINES, glw::GL_TRIANGLES];
const PRIMITIVE_INDICES: [i32; 3] = [1, 2, 3];

const EXPECTED_INTEGRAL: [f32; 12] = [
    1.0, 1.0, 0.0, 0.0, // for GL_POINTS
    1.0, 1.0, 0.0, 0.5, // for GL_LINES
    0.5, 0.5, 0.0, 0.25, // for GL_TRIANGLES
];

/// `FunctionalTest::prepareShaderCode`
fn prepare_shader_code(
    specialization: &[(&str, String)],
    explicit_redeclaration: bool,
    dynamic_setter: bool,
    clip_count: u32,
    clip_function: usize,
    primitive_type: glw::GLenum,
) -> Result<(String, String), TestError> {
    let mut vertex_shader = FUNCTIONAL_VS.to_string();

    if explicit_redeclaration {
        vertex_shader = preprocess_code(&vertex_shader, "CLIP_DISTANCE_REDECLARATION", EXPLICIT_REDECLARATION);
    } else {
        vertex_shader = preprocess_code(&vertex_shader, "CLIP_DISTANCE_REDECLARATION", "");
    }

    if dynamic_setter {
        vertex_shader = preprocess_code(&vertex_shader, "CLIP_DISTANCE_SETUP", DYNAMIC_ARRAY_SETTER);
    } else {
        let mut static_setters = String::new();

        for i in 0..clip_count {
            static_setters.push_str(&preprocess_code(STATIC_ARRAY_SETTER, "CLIP_INDEX", &i.to_string()));
        }

        vertex_shader = preprocess_code(&vertex_shader, "CLIP_DISTANCE_SETUP", &static_setters);
    }

    vertex_shader = preprocess_code(&vertex_shader, "CLIP_FUNCTION", CLIP_FUNCTION[clip_function]);
    vertex_shader = preprocess_code(&vertex_shader, "CLIP_COUNT", &clip_count.to_string());

    match primitive_type {
        glw::GL_POINTS => vertex_shader = preprocess_code(&vertex_shader, "VERTEX_COUNT", "1"),
        glw::GL_LINES => vertex_shader = preprocess_code(&vertex_shader, "VERTEX_COUNT", "2"),
        glw::GL_TRIANGLES => vertex_shader = preprocess_code(&vertex_shader, "VERTEX_COUNT", "3"),
        _ => {}
    }

    let vertex_shader = StringTemplate::new(vertex_shader).specialize(specialization)?;
    let fragment_shader = StringTemplate::new(FUNCTIONAL_FS).specialize(specialization)?;

    Ok((vertex_shader, fragment_shader))
}

/// `FunctionalTest::prepareGeometry`
fn prepare_geometry<'gl>(
    gl: &'gl glw::Functions,
    primitive_type: glw::GLenum,
) -> Result<VertexBufferObject<'gl>, TestError> {
    let data: Vec<f32> = match primitive_type {
        glw::GL_POINTS => vec![0.0, 0.0, 0.0, 1.0],
        glw::GL_LINES => vec![1.0, 1.0, 0.0, 1.0, -1.0, -1.0, 0.0, 1.0],
        glw::GL_TRIANGLES => vec![-1.0, -1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0],
        _ => {
            return Err(TestError::InternalError(
                "prepareGeometry: unknown primitive type".to_string(),
            ));
        }
    };

    VertexBufferObject::new(gl, glw::GL_ARRAY_BUFFER, &data)
}

/// `glu::getPrimitiveTypeStr` for the three modes this test draws
fn primitive_type_str(primitive_type: glw::GLenum) -> &'static str {
    match primitive_type {
        glw::GL_POINTS => "GL_POINTS",
        glw::GL_LINES => "GL_LINES",
        _ => "GL_TRIANGLES",
    }
}

/// `FunctionalTest::checkResults`
fn check_results(primitive_type: glw::GLenum, clip_function: usize, results: &[f32]) -> bool {
    if results.is_empty() {
        return false;
    }

    let mut integral = 0.0f32;

    let lines = primitive_type == glw::GL_LINES;
    let increment = if lines {
        (results.len() as f32).sqrt() as usize + 1
    } else {
        1
    };
    let base = if lines {
        (results.len() as f32).sqrt() as usize
    } else {
        results.len()
    };

    let mut i_pixels = 0;
    while i_pixels < results.len() {
        integral += results[i_pixels];
        i_pixels += increment;
    }

    integral /= base as f32;

    let i_primitive_type = if primitive_type == glw::GL_POINTS {
        0
    } else if primitive_type == glw::GL_LINES {
        1
    } else {
        2
    };

    if f64::from((EXPECTED_INTEGRAL[i_primitive_type * CLIP_FUNCTION.len() + clip_function] - integral).abs()) > 0.01 {
        return false;
    }

    true
}

/// `FunctionalTest::test`
fn functional_test(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let specialization = specialization(context);

    let max_clip_distances = get_integer(gl, glw::GL_MAX_CLIP_DISTANCES);

    glu::expect_no_error(gl, "glGetIntegerv call failed.")?;

    for i_primitive_type in 0..PRIMITIVE_TYPES.len() {
        let primitive_type = PRIMITIVE_TYPES[i_primitive_type];
        let primitive_indices_count = PRIMITIVE_INDICES[i_primitive_type];

        let framebuffer_size = if primitive_type == glw::GL_POINTS { 1 } else { 32 };

        let framebuffer = Framebuffer::new(gl, framebuffer_size, framebuffer_size)?;

        framebuffer.bind()?;

        // Upstream compares the primitive type index with GL_POINTS (0): the last clip function is left out of the first primitive type only.
        let clip_function_count = CLIP_FUNCTION.len() as u32 - u32::from(i_primitive_type as u32 == glw::GL_POINTS);

        for i_clip_function in 0..clip_function_count as usize {
            for i_redeclaration in 0..2 {
                let redeclaration = i_redeclaration == 1;

                for i_clip_count in 1..=max_clip_distances as u32 {
                    let (vs_code, fs_code) = prepare_shader_code(
                        &specialization,
                        redeclaration,
                        redeclaration,
                        i_clip_count,
                        i_clip_function,
                        primitive_type,
                    )?;

                    let program = build_program(gl, &vs_code, &fs_code, &[], false);

                    if !program.is_ok() {
                        log::info!(
                            "Functional test have failed when building program.\nVertex shader code:\n{vs_code}\nWith Fragment Shader:\n{fs_code}\nWith build log:\n{}\n",
                            program.build_failure_summary().unwrap_or_default()
                        );

                        return Ok(TestStatus::fail("Fail"));
                    }

                    // SAFETY: the program linked.
                    unsafe { gl.use_program(program.program()) };
                    glu::expect_no_error(gl, "glUseProgram call failed.")?;

                    framebuffer.clear()?;

                    // SAFETY: plain capability toggle.
                    unsafe { gl.enable(glw::GL_CLIP_DISTANCE0 + i_clip_count - 1) };

                    let vertex_array_object = VertexArrayObject::new(gl, primitive_type)?;

                    let mut vertex_buffer_object = prepare_geometry(gl, primitive_type)?;

                    if !vertex_buffer_object.use_as_shader_input(&program, "position", 4)? {
                        log::info!("Functional test have failed when enabling vertex attribute array.\n");

                        return Ok(TestStatus::new(TestResult::InternalError, "Error"));
                    }

                    vertex_array_object.draw(0, primitive_indices_count)?;

                    let results = framebuffer.read_pixels()?;

                    if !check_results(primitive_type, i_clip_function, &results) {
                        log::info!(
                            "Functional test have failed when drawing {} {} dynamic redeclaration, when {} GL_CLIP_DISTANCES where enabled and set up using function:\n{}",
                            primitive_type_str(primitive_type),
                            if redeclaration { "with" } else { "without" },
                            i_clip_count,
                            CLIP_FUNCTION[i_clip_function]
                        );

                        return Ok(TestStatus::fail("Fail"));
                    }
                }

                for i_clip_count in 0..max_clip_distances as u32 {
                    // SAFETY: plain capability toggle.
                    unsafe { gl.disable(glw::GL_CLIP_DISTANCE0 + i_clip_count) };
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------
// NegativeTest
// ---------------------------------------------------------------------------------------------

const NEGATIVE_VS_CASE_0: &str = "${VERSION}\n\
${EXTENSION}\n\
\n\
void main()\n\
{\n\
    gl_ClipDistance[0] = 0.0;\n\
    gl_ClipVertex       = vec4(0.0);\n\
    gl_Position         = vec4(1.0);\n\
}\n";

const NEGATIVE_VS_CASE_1: &str = "${VERSION}\n\
${EXTENSION}\n\
\n\
out float gl_ClipDistance[gl_MaxClipDistances + 1];\n\
\n\
void main()\n\
{\n\
    gl_ClipDistance[0] = 0.0;\n\
    gl_Position        = vec4(1.0);\n\
}\n";

const NEGATIVE_VS_CASE_2: &str = "${VERSION}\n\
${EXTENSION}\n\
\n\
in int count;\n\
\n\
void main()\n\
{\n\
    for(int i = 0; i < count; i++)\n\
    {\n\
        gl_ClipDistance[i] = 0.0;\n\
    }\n\
\n\
    gl_Position = vec4(1.0);\n\
}\n";

const NEGATIVE_FS: &str = "${VERSION}\n\
${PRECISION}\n\
\n\
out vec4 color;\n\
\n\
void main()\n\
{\n\
    color = vec4(0.0, 0.0, 0.0, 1.0);\n\
}\n";

fn negative_build_succeeds(context: &Context, vertex_template: &str) -> Result<bool, TestError> {
    let specialization = specialization(context);

    let vertex_shader = StringTemplate::new(vertex_template).specialize(&specialization)?;
    let fragment_shader = StringTemplate::new(NEGATIVE_FS).specialize(&specialization)?;

    let program = build_program(context.gl(), &vertex_shader, &fragment_shader, &[], true);

    Ok(program.is_ok())
}

/// `NegativeTest::testClipVertexBuildingErrors`
fn test_clip_vertex_building_errors(context: &Context) -> Result<bool, TestError> {
    // gl_ClipVertex is only a build error before GL 3.1
    if context.context_type().supports_core(3, 1) {
        return Ok(true);
    }

    if negative_build_succeeds(context, NEGATIVE_VS_CASE_0)? {
        log::info!(
            "Functional test have failed. Building shader which statically writes to both gl_ClipVertex and gl_ClipDistances[] has unexpectedly succeeded."
        );
        return Ok(false);
    }

    Ok(true)
}

/// `NegativeTest::testMaxClipDistancesBuildingErrors`
fn test_max_clip_distances_building_errors(context: &Context) -> Result<bool, TestError> {
    if negative_build_succeeds(context, NEGATIVE_VS_CASE_1)? {
        log::info!(
            "Functional test have failed. Building shader with explicit redeclaration of gl_ClipDistance[] array with size (gl_MaxClipDistances + 1) has unexpectedly succeeded."
        );
        return Ok(false);
    }

    Ok(true)
}

/// `NegativeTest::testClipDistancesRedeclarationBuildingErrors`
fn test_clip_distances_redeclaration_building_errors(context: &Context) -> Result<bool, TestError> {
    if negative_build_succeeds(context, NEGATIVE_VS_CASE_2)? {
        log::info!(
            "Functional test have passed but with warning. Building shader without explicit redeclaration and with variable indexing has unexpectedly succeeded. This is within the bound of the specification (no error is being), but it may lead to errors."
        );
        return Ok(false);
    }

    Ok(true)
}

/// `NegativeTest::test`
fn negative_test(context: &Context) -> TestOutcome {
    let mut is_ok = true;
    let mut may_be_ok = true;

    is_ok = is_ok && test_clip_vertex_building_errors(context)?;
    is_ok = is_ok && test_max_clip_distances_building_errors(context)?;
    may_be_ok = may_be_ok && test_clip_distances_redeclaration_building_errors(context)?;

    Ok(if is_ok {
        if may_be_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::QualityWarning, "Pass with warning")
        }
    } else {
        TestStatus::fail("Fail")
    })
}

// ---------------------------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
enum Kind {
    Coverage,
    Functional,
    Negative,
}

struct ClipDistanceCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for ClipDistanceCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `ClipDistanceTestBase::iterate`'s check, which upstream also throws as NotSupported
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports_core(3, 0) {
            return Err(TestError::NotSupported(
                "GL_ARB_clip_distance is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::Coverage => coverage_test(context),
            Kind::Functional => functional_test(context),
            Kind::Negative => negative_test(context),
        }
    }
}

/// `ClipDistance::Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clip_distance");
    group.add_child(Box::new(ClipDistanceCase {
        name: "coverage",
        kind: Kind::Coverage,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipDistanceCase {
        name: "functional",
        kind: Kind::Functional,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(ClipDistanceCase {
        name: "negative",
        kind: Kind::Negative,
    }) as Box<dyn TestCase>);
    group
}
