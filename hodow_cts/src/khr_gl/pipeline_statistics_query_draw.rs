// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cPipelineStatisticsQueryTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The draw-call part of `PipelineStatisticsQueryTestFunctionalBase` (`buildProgram`, `initFBO`, `initVBO`, `initVAO`, `queryCallbackDrawCallHandler`; the members they fill are `DrawState`), the geometry shader helpers of `PipelineStatisticsQueryUtilities` and `PipelineStatisticsQueryTestFunctional3` to `8`.

use std::cell::RefCell;
use std::ffi::c_void;

use super::pipeline_statistics_query_functional::{
    FunctionalState, TestExecutionResult, VerificationType, execute_query, iterate_functional, verify_result_values,
};
use super::pipeline_statistics_query_tests::{check_extension, string_for_enum};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome};

const GL_VERTICES_SUBMITTED_ARB: GLenum = 0x82EE;
const GL_PRIMITIVES_SUBMITTED_ARB: GLenum = 0x82EF;
const GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB: GLenum = 0x82F3;
const GL_FRAGMENT_SHADER_INVOCATIONS_ARB: GLenum = 0x82F4;
const GL_COMPUTE_SHADER_INVOCATIONS_ARB: GLenum = 0x82F5;
const GL_VERTEX_SHADER_INVOCATIONS_ARB: GLenum = 0x82F0;
const GL_TESS_CONTROL_SHADER_PATCHES_ARB: GLenum = 0x82F1;
const GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB: GLenum = 0x82F2;
const GL_CLIPPING_INPUT_PRIMITIVES_ARB: GLenum = 0x82F6;
const GL_CLIPPING_OUTPUT_PRIMITIVES_ARB: GLenum = 0x82F7;

const MINIMAL_FS_CODE: &str = "#version 130\n\nout vec4 result;\n\nvoid main()\n{\n    result = gl_FragCoord;\n}\n";
const MINIMAL_TC_CODE: &str = "#version 400\n\nlayout(vertices = 3) out;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelInner[0]                = 1.0;\n    gl_TessLevelInner[1]                = 2.0;\n    gl_TessLevelOuter[0]                = 3.0;\n    gl_TessLevelOuter[1]                = 4.0;\n    gl_TessLevelOuter[2]                = 5.0;\n    gl_TessLevelOuter[3]                = 6.0;\n}\n";
const MINIMAL_TE_CODE: &str = "#version 400\n\nlayout(triangles) in;\n\nvoid main()\n{\n    gl_Position = gl_TessCoord.xyxy * gl_in[gl_PrimitiveID].gl_Position;\n}\n";
const MINIMAL_CS_CODE: &str = "#version 430\n\nlayout(local_size_x=1, local_size_y = 1, local_size_z = 1) in;\n\nlayout(binding = 0) uniform atomic_uint test_counter;\n\nvoid main()\n{\n    atomicCounterIncrement(test_counter);\n}\n";
const MINIMAL_CS_CODE_ARB: &str = "#version 420 core\n#extension GL_ARB_compute_shader : require\n#extension GL_ARB_shader_atomic_counters : require\n\nlayout(local_size_x=1, local_size_y = 1, local_size_z = 1) in;\n\nlayout(binding = 0) uniform atomic_uint test_counter;\n\nvoid main()\n{\n    atomicCounterIncrement(test_counter);\n}\n";
const MINIMAL_VS_CODE: &str = "#version 130\n\nin vec4 position;\n\nvoid main()\n{\n    gl_Position = position;\n}\n";

/// `PipelineStatisticsQueryUtilities::_draw_call_type`
#[derive(Clone, Copy, PartialEq, Debug)]
enum DrawCallType {
    DrawArrays,
    DrawArraysIndirect,
    DrawArraysInstanced,
    DrawArraysInstancedBaseInstance,
    DrawElements,
    DrawElementsBaseVertex,
    DrawElementsIndirect,
    DrawElementsInstanced,
    DrawElementsInstancedBaseInstance,
    DrawElementsInstancedBaseVertexBaseInstance,
    DrawRangeElements,
    DrawRangeElementsBaseVertex,
}

const DRAW_CALL_TYPES: [DrawCallType; 12] = [
    DrawCallType::DrawArrays,
    DrawCallType::DrawArraysIndirect,
    DrawCallType::DrawArraysInstanced,
    DrawCallType::DrawArraysInstancedBaseInstance,
    DrawCallType::DrawElements,
    DrawCallType::DrawElementsBaseVertex,
    DrawCallType::DrawElementsIndirect,
    DrawCallType::DrawElementsInstanced,
    DrawCallType::DrawElementsInstancedBaseInstance,
    DrawCallType::DrawElementsInstancedBaseVertexBaseInstance,
    DrawCallType::DrawRangeElements,
    DrawCallType::DrawRangeElementsBaseVertex,
];

/// `PipelineStatisticsQueryUtilities::_primitive_type`
#[derive(Clone, Copy, PartialEq, Debug)]
enum PrimitiveType {
    Points,
    LineLoop,
    LineStrip,
    Lines,
    LinesAdjacency,
    Patches,
    TriangleFan,
    TriangleStrip,
    Triangles,
    TrianglesAdjacency,
}

const PRIMITIVE_TYPES: [PrimitiveType; 10] = [
    PrimitiveType::Points,
    PrimitiveType::LineLoop,
    PrimitiveType::LineStrip,
    PrimitiveType::Lines,
    PrimitiveType::LinesAdjacency,
    PrimitiveType::Patches,
    PrimitiveType::TriangleFan,
    PrimitiveType::TriangleStrip,
    PrimitiveType::Triangles,
    PrimitiveType::TrianglesAdjacency,
];

/// `PipelineStatisticsQueryUtilities::getEnumForPrimitiveType`
fn enum_for_primitive_type(primitive_type: PrimitiveType) -> GLenum {
    match primitive_type {
        PrimitiveType::Points => glw::GL_POINTS,
        PrimitiveType::LineLoop => glw::GL_LINE_LOOP,
        PrimitiveType::LineStrip => glw::GL_LINE_STRIP,
        PrimitiveType::Lines => glw::GL_LINES,
        PrimitiveType::LinesAdjacency => glw::GL_LINES_ADJACENCY,
        PrimitiveType::Patches => glw::GL_PATCHES,
        PrimitiveType::TriangleFan => glw::GL_TRIANGLE_FAN,
        PrimitiveType::TriangleStrip => glw::GL_TRIANGLE_STRIP,
        PrimitiveType::Triangles => glw::GL_TRIANGLES,
        PrimitiveType::TrianglesAdjacency => glw::GL_TRIANGLES_ADJACENCY,
    }
}

/// `PipelineStatisticsQueryUtilities::isDrawCallSupported`
fn is_draw_call_supported(draw_call: DrawCallType, gl: &glw::Functions) -> bool {
    match draw_call {
        DrawCallType::DrawArrays => gl.draw_arrays.is_some(),
        DrawCallType::DrawArraysIndirect => gl.draw_arrays_indirect.is_some(),
        DrawCallType::DrawArraysInstanced => gl.draw_arrays_instanced.is_some(),
        DrawCallType::DrawArraysInstancedBaseInstance => gl.draw_arrays_instanced_base_instance.is_some(),
        DrawCallType::DrawElements => gl.draw_elements.is_some(),
        DrawCallType::DrawElementsBaseVertex => gl.draw_elements_base_vertex.is_some(),
        DrawCallType::DrawElementsIndirect => gl.draw_elements_indirect.is_some(),
        DrawCallType::DrawElementsInstanced => gl.draw_elements_instanced.is_some(),
        DrawCallType::DrawElementsInstancedBaseInstance => gl.draw_elements_instanced_base_instance.is_some(),
        DrawCallType::DrawElementsInstancedBaseVertexBaseInstance => {
            gl.draw_elements_instanced_base_vertex_base_instance.is_some()
        }
        DrawCallType::DrawRangeElements => gl.draw_range_elements.is_some(),
        DrawCallType::DrawRangeElementsBaseVertex => gl.draw_range_elements_base_vertex.is_some(),
    }
}

/// `PipelineStatisticsQueryUtilities::isInstancedDrawCall`
fn is_instanced_draw_call(draw_call: DrawCallType) -> bool {
    matches!(
        draw_call,
        DrawCallType::DrawArraysIndirect
            | DrawCallType::DrawArraysInstanced
            | DrawCallType::DrawArraysInstancedBaseInstance
            | DrawCallType::DrawElementsIndirect
            | DrawCallType::DrawElementsInstanced
            | DrawCallType::DrawElementsInstancedBaseInstance
            | DrawCallType::DrawElementsInstancedBaseVertexBaseInstance
    )
}

/// The members of `PipelineStatisticsQueryTestFunctionalBase` that the draw-call tests fill and the draw-call handler reads.
struct DrawState {
    po_id: GLuint,
    vao_id: GLuint,
    vbo_id: GLuint,
    fbo_id: GLuint,
    to_id: GLuint,
    vbo_indirect_arrays_argument_offset: usize,
    vbo_indirect_elements_argument_offset: usize,
    vbo_index_data_offset: usize,
    vbo_n_indices: u32,
    vbo_vertex_data_offset: usize,
    current_draw_call_type: DrawCallType,
    current_primitive_type: PrimitiveType,
    indirect_draw_call_baseinstance_argument: u32,
    indirect_draw_call_basevertex_argument: u32,
    indirect_draw_call_count_argument: u32,
    indirect_draw_call_first_argument: u32,
    indirect_draw_call_firstindex_argument: u32,
    indirect_draw_call_primcount_argument: u32,
    is_primitive_restart_enabled: bool,
}

impl DrawState {
    fn new() -> Self {
        Self {
            po_id: 0,
            vao_id: 0,
            vbo_id: 0,
            fbo_id: 0,
            to_id: 0,
            vbo_indirect_arrays_argument_offset: 0,
            vbo_indirect_elements_argument_offset: 0,
            vbo_index_data_offset: 0,
            vbo_n_indices: 0,
            vbo_vertex_data_offset: 0,
            current_draw_call_type: DrawCallType::DrawArrays,
            current_primitive_type: PrimitiveType::Points,
            indirect_draw_call_baseinstance_argument: 0,
            indirect_draw_call_basevertex_argument: 0,
            indirect_draw_call_count_argument: 0,
            indirect_draw_call_first_argument: 0,
            indirect_draw_call_firstindex_argument: 0,
            indirect_draw_call_primcount_argument: 0,
            is_primitive_restart_enabled: false,
        }
    }

    /// `PipelineStatisticsQueryTestFunctionalBase::buildProgram` for a set of (shader type, body) stages.
    fn build_program(&mut self, gl: &glw::Functions, stages: &[(GLenum, &str)]) -> Result<(), TestError> {
        if self.po_id != 0 {
            // SAFETY: deletes the program created by an earlier call.
            unsafe { gl.delete_program(self.po_id) };
            glu::expect_no_error(gl, "glDeleteProgram() call failed.")?;
            self.po_id = 0;
        }
        let shader_ids: Vec<GLuint> = stages
            .iter()
            .map(|(shader_type, _)| {
                // SAFETY: creates a shader object.
                unsafe { gl.create_shader(*shader_type) }
            })
            .collect();
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;
        // SAFETY: creates a program object.
        self.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        for (shader_id, (_, body)) in shader_ids.iter().zip(stages) {
            let pointer: *const glw::GLchar = body.as_ptr().cast();
            let length = body.len() as GLint;
            // SAFETY: one source string of `length` bytes.
            unsafe { gl.shader_source(*shader_id, 1, &pointer, &length) };
        }
        glu::expect_no_error(gl, "glShaderSource() call(s) failed.")?;

        for shader_id in &shader_ids {
            let mut compile_status: GLint = glw::GL_FALSE as GLint;
            // SAFETY: compiles and queries the shader created above.
            unsafe { gl.compile_shader(*shader_id) };
            glu::expect_no_error(gl, "glCompileShader() call failed.")?;
            // SAFETY: the value is written to the live local.
            unsafe { gl.get_shaderiv(*shader_id, glw::GL_COMPILE_STATUS, &mut compile_status) };
            glu::expect_no_error(gl, "glGetShaderiv() call failed.")?;
            if compile_status == glw::GL_FALSE as GLint {
                return Err(TestError::Fail("Shader compilation failed.".to_string()));
            }
            // SAFETY: attaches the compiled shader to the program created above.
            unsafe { gl.attach_shader(self.po_id, *shader_id) };
            glu::expect_no_error(gl, "glAttachShader() call failed.")?;
        }

        let mut link_status: GLint = glw::GL_FALSE as GLint;
        // SAFETY: links and queries the program created above.
        unsafe { gl.link_program(self.po_id) };
        glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
        // SAFETY: the value is written to the live local.
        unsafe { gl.get_programiv(self.po_id, glw::GL_LINK_STATUS, &mut link_status) };
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
        if link_status == glw::GL_FALSE as GLint {
            return Err(TestError::Fail("Program linking failed.".to_string()));
        }

        for shader_id in shader_ids {
            // SAFETY: deletes a shader created above.
            unsafe { gl.delete_shader(shader_id) };
        }
        glu::expect_no_error(gl, "glDeleteShader() call(s) failed.")
    }

    /// `PipelineStatisticsQueryTestFunctionalBase::initFBO`
    fn init_fbo(&mut self, gl: &glw::Functions) -> Result<(), TestError> {
        const TO_SIZE: glw::GLsizei = 64;
        // SAFETY: the name is written to the live field.
        unsafe { gl.gen_framebuffers(1, &mut self.fbo_id) };
        glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;
        // SAFETY: binds the framebuffer created above.
        unsafe { gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.fbo_id) };
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;
        // SAFETY: the name is written to the live field.
        unsafe { gl.gen_textures(1, &mut self.to_id) };
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;
        // SAFETY: binds and allocates the texture created above.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, self.to_id) };
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, TO_SIZE, TO_SIZE) };
        glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;
        // SAFETY: attaches the texture created above.
        unsafe {
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.to_id,
                0,
            )
        };
        glu::expect_no_error(gl, "glFramebufferTexture2D() call failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.viewport(0, 0, TO_SIZE, TO_SIZE) };
        glu::expect_no_error(gl, "glViewport() call failed.")
    }

    /// `PipelineStatisticsQueryTestFunctionalBase::initVAO`
    fn init_vao(&mut self, gl: &glw::Functions, n_components_per_vertex: GLint) -> Result<(), TestError> {
        if self.vao_id != 0 {
            // SAFETY: deletes the vertex array created by an earlier call.
            unsafe { gl.delete_vertex_arrays(1, &self.vao_id) };
            self.vao_id = 0;
        }
        // SAFETY: the name is written to the live field.
        unsafe { gl.gen_vertex_arrays(1, &mut self.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: binds the vertex array created above.
        unsafe { gl.bind_vertex_array(self.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;
        // SAFETY: the pointer is an offset into the array buffer bound by `initVBO`.
        unsafe {
            gl.vertex_attrib_pointer(
                0,
                n_components_per_vertex,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                self.vbo_vertex_data_offset as *const c_void,
            )
        };
        glu::expect_no_error(gl, "glVertexAttribPointer() call failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.enable_vertex_attrib_array(0) };
        glu::expect_no_error(gl, "glEnableVertexAttribArray() call failed.")?;
        // SAFETY: binds the buffer created by `initVBO`.
        unsafe { gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.vbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call failed.")
    }

    /// `PipelineStatisticsQueryTestFunctionalBase::initVBO`, taking the indirect draw arguments from the `indirect_draw_call_*` members as every caller does.
    fn init_vbo(
        &mut self,
        context: &Context,
        raw_vertex_data: &[f32],
        raw_index_data: &[u32],
    ) -> Result<(), TestError> {
        let gl = context.gl();
        if self.vbo_id != 0 {
            // SAFETY: deletes the buffer created by an earlier call.
            unsafe { gl.delete_buffers(1, &self.vbo_id) };
            self.vbo_id = 0;
        }
        const INDIRECT_ARRAYS_DRAW_CALL_ARGUMENTS_SIZE: usize = 4 * 4;
        const INDIRECT_ELEMENTS_DRAW_CALL_ARGUMENTS_SIZE: usize = 5 * 4;
        let raw_vertex_data_size = std::mem::size_of_val(raw_vertex_data);
        let raw_index_data_size = std::mem::size_of_val(raw_index_data);

        self.vbo_n_indices = (raw_index_data_size / 4) as u32;
        self.vbo_vertex_data_offset = 0;
        self.vbo_index_data_offset = raw_vertex_data_size;
        self.vbo_indirect_arrays_argument_offset = self.vbo_index_data_offset + raw_index_data_size;
        self.vbo_indirect_elements_argument_offset =
            self.vbo_indirect_arrays_argument_offset + INDIRECT_ARRAYS_DRAW_CALL_ARGUMENTS_SIZE;
        self.indirect_draw_call_firstindex_argument = (self.vbo_index_data_offset / 4) as u32;

        let arrays_draw_call_arguments: [u32; 4] = [
            self.indirect_draw_call_count_argument,
            self.indirect_draw_call_primcount_argument,
            self.indirect_draw_call_first_argument,
            self.indirect_draw_call_baseinstance_argument,
        ];
        let elements_draw_call_arguments: [u32; 5] = [
            self.indirect_draw_call_count_argument,
            self.indirect_draw_call_primcount_argument,
            self.indirect_draw_call_firstindex_argument,
            self.indirect_draw_call_basevertex_argument,
            self.indirect_draw_call_baseinstance_argument,
        ];
        let bo_data_size = self.vbo_indirect_elements_argument_offset + INDIRECT_ELEMENTS_DRAW_CALL_ARGUMENTS_SIZE;

        // SAFETY: the name is written to the live field.
        unsafe { gl.gen_buffers(1, &mut self.vbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        // SAFETY: binds the buffer created above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vbo_id) };
        if context.context_type().supports_core(4, 0)
            || context.context_info.is_extension_supported("GL_ARB_draw_indirect")
        {
            // SAFETY: as above.
            unsafe { gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.vbo_id) };
        }
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.vbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call(s) failed.")?;
        // SAFETY: allocates without data.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                bo_data_size as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call failed.")?;
        let uploads: [(usize, usize, *const c_void); 4] = [
            (
                self.vbo_vertex_data_offset,
                raw_vertex_data_size,
                raw_vertex_data.as_ptr().cast(),
            ),
            (
                self.vbo_index_data_offset,
                raw_index_data_size,
                raw_index_data.as_ptr().cast(),
            ),
            (
                self.vbo_indirect_arrays_argument_offset,
                std::mem::size_of_val(&arrays_draw_call_arguments),
                arrays_draw_call_arguments.as_ptr().cast(),
            ),
            (
                self.vbo_indirect_elements_argument_offset,
                std::mem::size_of_val(&elements_draw_call_arguments),
                elements_draw_call_arguments.as_ptr().cast(),
            ),
        ];
        for (offset, size, data) in uploads {
            // SAFETY: each pointer covers `size` bytes of a live array and the range lies inside the allocation above.
            unsafe {
                gl.buffer_sub_data(
                    glw::GL_ARRAY_BUFFER,
                    offset as glw::GLintptr,
                    size as glw::GLsizeiptr,
                    data,
                )
            };
        }
        glu::expect_no_error(gl, "glBufferSubData() call failed.")
    }

    /// `PipelineStatisticsQueryTestFunctionalBase::queryCallbackDrawCallHandler`
    fn draw_call_handler(&self, gl: &glw::Functions) -> Result<(), TestError> {
        let primitive_type = enum_for_primitive_type(self.current_primitive_type);
        let count = self.indirect_draw_call_count_argument as glw::GLsizei;
        let first = self.indirect_draw_call_first_argument as GLint;
        let primcount = self.indirect_draw_call_primcount_argument as glw::GLsizei;
        let baseinstance = self.indirect_draw_call_baseinstance_argument;
        let basevertex = self.indirect_draw_call_basevertex_argument as GLint;
        let index_offset = self.vbo_index_data_offset as *const c_void;
        match self.current_draw_call_type {
            DrawCallType::DrawArrays => {
                // SAFETY: draws from the vertex array set up by `initVAO`.
                unsafe { gl.draw_arrays(primitive_type, first, count) };
                glu::expect_no_error(gl, "glDrawArrays() call failed.")?;
            }
            DrawCallType::DrawArraysIndirect => {
                // SAFETY: the offset addresses the indirect arguments stored by `initVBO`.
                unsafe {
                    gl.draw_arrays_indirect(
                        primitive_type,
                        self.vbo_indirect_arrays_argument_offset as *const c_void,
                    )
                };
                glu::expect_no_error(gl, "glDrawArraysIndirect() call failed.")?;
            }
            DrawCallType::DrawArraysInstanced => {
                // SAFETY: as for `DrawArrays`.
                unsafe { gl.draw_arrays_instanced(primitive_type, first, count, primcount) };
                glu::expect_no_error(gl, "glDrawArraysInstanced() call failed.")?;
            }
            DrawCallType::DrawArraysInstancedBaseInstance => {
                // SAFETY: as for `DrawArrays`.
                unsafe {
                    gl.draw_arrays_instanced_base_instance(primitive_type, first, count, primcount, baseinstance)
                };
            }
            DrawCallType::DrawElements => {
                // SAFETY: the offset addresses the indices stored by `initVBO`.
                unsafe { gl.draw_elements(primitive_type, count, glw::GL_UNSIGNED_INT, index_offset) };
                glu::expect_no_error(gl, "glDrawElements() call failed.")?;
            }
            DrawCallType::DrawElementsBaseVertex => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_base_vertex(primitive_type, count, glw::GL_UNSIGNED_INT, index_offset, basevertex)
                };
                glu::expect_no_error(gl, "glDrawElementsBaseVertex() call failed.")?;
            }
            DrawCallType::DrawElementsIndirect => {
                // SAFETY: the offset addresses the indirect arguments stored by `initVBO`.
                unsafe {
                    gl.draw_elements_indirect(
                        primitive_type,
                        glw::GL_UNSIGNED_INT,
                        self.vbo_indirect_elements_argument_offset as *const c_void,
                    )
                };
                glu::expect_no_error(gl, "glDrawElementsIndirect() call failed.")?;
            }
            DrawCallType::DrawElementsInstanced => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_instanced(primitive_type, count, glw::GL_UNSIGNED_INT, index_offset, primcount)
                };
                glu::expect_no_error(gl, "glDrawElementsInstanced() call failed.")?;
            }
            DrawCallType::DrawElementsInstancedBaseInstance => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_instanced_base_instance(
                        primitive_type,
                        count,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        primcount,
                        baseinstance,
                    )
                };
                glu::expect_no_error(gl, "glDrawElementsInstancedBaseInstance() call failed.")?;
            }
            DrawCallType::DrawElementsInstancedBaseVertexBaseInstance => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_elements_instanced_base_vertex_base_instance(
                        primitive_type,
                        count,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        primcount,
                        basevertex,
                        baseinstance,
                    )
                };
                glu::expect_no_error(gl, "glDrawElementsInstancedBaseVertexBaseInstance() call failed.")?;
            }
            DrawCallType::DrawRangeElements => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_range_elements(
                        primitive_type,
                        0,
                        self.vbo_n_indices,
                        count,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                    )
                };
                glu::expect_no_error(gl, "glDrawRangeElements() call failed.")?;
            }
            DrawCallType::DrawRangeElementsBaseVertex => {
                // SAFETY: as above.
                unsafe {
                    gl.draw_range_elements_base_vertex(
                        primitive_type,
                        0,
                        self.indirect_draw_call_count_argument.wrapping_sub(1),
                        count,
                        glw::GL_UNSIGNED_INT,
                        index_offset,
                        basevertex,
                    )
                };
                glu::expect_no_error(gl, "glDrawRangeElementsBaseVertex() call failed.")?;
            }
        }
        Ok(())
    }

    /// `PipelineStatisticsQueryTestFunctionalBase::deinit` (the part for the members of this struct)
    fn deinit(&mut self, gl: &glw::Functions) {
        // SAFETY: deletes only names created by this struct.
        unsafe {
            if self.po_id != 0 {
                gl.delete_program(self.po_id);
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
            if self.vbo_id != 0 {
                gl.delete_buffers(1, &self.vbo_id);
            }
            if self.fbo_id != 0 {
                gl.delete_framebuffers(1, &self.fbo_id);
            }
            if self.to_id != 0 {
                gl.delete_textures(1, &self.to_id);
            }
        }
        self.fbo_id = 0;
        self.to_id = 0;
        self.po_id = 0;
        self.vao_id = 0;
        self.vbo_id = 0;
    }
}

/// Runs the draw call of the current state inside a query, as `executeQuery(..., queryCallbackDrawCallHandler, this, ...)`.
fn execute_draw_query(
    context: &Context,
    state: &RefCell<DrawState>,
    functional: &FunctionalState,
    query_target: GLenum,
    run_result: &mut TestExecutionResult,
) -> Result<(bool, bool), TestError> {
    let gl = context.gl();
    let mut draw = || state.borrow().draw_call_handler(gl);
    let execution = execute_query(
        context,
        query_target,
        functional.qo_id,
        functional.bo_qo_id,
        Some(&mut draw),
        run_result,
    )?;
    if !execution.ok {
        log::info!(
            "Could not retrieve test run results for query target [{}]",
            string_for_enum(query_target)
        );
    }
    Ok((execution.ok, execution.skipped))
}

fn draw_details(state: &DrawState) -> String {
    format!(
        " (draw call: {:?}, primitive type: {:?}, primitive restart: {})",
        state.current_draw_call_type, state.current_primitive_type, state.is_primitive_restart_enabled
    )
}

/// `PipelineStatisticsQueryTestFunctional3::getExpectedPrimitivesSubmittedQueryResult`
fn expected_primitives_submitted(state: &DrawState) -> Vec<u64> {
    let mut n_input_vertices = u64::from(state.indirect_draw_call_count_argument);
    if state.is_primitive_restart_enabled {
        n_input_vertices -= 1;
    }
    let mut results: Vec<u64> = Vec::new();
    let n = n_input_vertices;
    match state.current_primitive_type {
        PrimitiveType::Points => results.push(n),
        PrimitiveType::LineLoop => {
            if n > 2 {
                results.push(n);
            } else if n > 1 {
                results.push(1);
            } else {
                results.push(0);
            }
        }
        PrimitiveType::TriangleFan | PrimitiveType::TriangleStrip => {
            if n > 2 {
                results.push(n - 2);
            } else {
                results.push(0);
                if n >= 1 {
                    results.push(1);
                }
            }
        }
        PrimitiveType::LineStrip => {
            if n > 1 {
                results.push(n - 1);
            } else {
                results.push(0);
                if n > 0 {
                    results.push(1);
                }
            }
        }
        PrimitiveType::Lines
        | PrimitiveType::LinesAdjacency
        | PrimitiveType::Triangles
        | PrimitiveType::TrianglesAdjacency => {
            let divisor = match state.current_primitive_type {
                PrimitiveType::Lines => 2,
                PrimitiveType::LinesAdjacency => 4,
                PrimitiveType::Triangles => 3,
                _ => 6,
            };
            results.push(n / divisor);
            if n > 0 && n % divisor != 0 {
                results.push(n / divisor + 1);
            }
        }
        PrimitiveType::Patches => unreachable!("patches are skipped by the callers"),
    }
    if is_instanced_draw_call(state.current_draw_call_type) {
        for result in &mut results {
            *result *= u64::from(state.indirect_draw_call_primcount_argument);
        }
    }
    results
}

/// `PipelineStatisticsQueryTestFunctional3::getExpectedVerticesSubmittedQueryResult`
fn expected_vertices_submitted(state: &DrawState) -> Vec<u64> {
    let mut n = u64::from(state.indirect_draw_call_count_argument);
    if state.is_primitive_restart_enabled {
        n -= 1;
    }
    let mut results: Vec<u64> = Vec::new();
    match state.current_primitive_type {
        PrimitiveType::Points
        | PrimitiveType::LineStrip
        | PrimitiveType::TriangleFan
        | PrimitiveType::TriangleStrip => results.push(n),
        PrimitiveType::LineLoop => {
            results.push(n);
            results.push(n + 1);
        }
        PrimitiveType::Lines => {
            results.push(n);
            if n > 0 && n % 2 != 0 {
                results.push(n - 1);
            }
        }
        PrimitiveType::LinesAdjacency | PrimitiveType::TrianglesAdjacency => {
            let divisor = if state.current_primitive_type == PrimitiveType::LinesAdjacency {
                4
            } else {
                6
            };
            results.push(n);
            results.push(n / 2);
            if n > 0 && n % divisor != 0 {
                results.push(n - (n % divisor));
                results.push((n - (n % divisor)) / 2);
            }
        }
        PrimitiveType::Triangles => {
            results.push(n);
            if n > 0 && n % 3 != 0 {
                results.push(n - (n % 3));
            }
        }
        PrimitiveType::Patches => unreachable!("patches are skipped by the callers"),
    }
    if is_instanced_draw_call(state.current_draw_call_type) {
        for result in &mut results {
            *result *= u64::from(state.indirect_draw_call_primcount_argument);
        }
    }
    results
}

/// `PipelineStatisticsQueryTestFunctional3`
struct Functional3;

impl Functional3 {
    fn execute_test(
        context: &Context,
        functional: &FunctionalState,
        draw: &RefCell<DrawState>,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut run_result = TestExecutionResult::default();

        let n_vertex_components = 2;
        let vertex_data: [f32; 16] = [
            -0.1, 0.2, 0.3, 0.1, 0.2, -0.7, 0.5, -0.5, 0.0, 0.0, -0.6, -0.9, -0.3, 0.3, -0.5, -0.5,
        ];
        let index_data: [u32; 7] = [0, 6, 2, 1, 3, 5, 4];
        {
            let mut state = draw.borrow_mut();
            state.indirect_draw_call_baseinstance_argument = 1;
            state.indirect_draw_call_basevertex_argument = 0;
            state.indirect_draw_call_count_argument = index_data.len() as u32;
            state.indirect_draw_call_first_argument = 0;
            state.indirect_draw_call_primcount_argument = 3;
            state.init_vbo(context, &vertex_data, &index_data)?;
            state.init_vao(gl, n_vertex_components)?;
        }

        for is_primitive_restart_enabled in [false, true] {
            draw.borrow_mut().is_primitive_restart_enabled = is_primitive_restart_enabled;
            if (current_query_target == GL_CLIPPING_INPUT_PRIMITIVES_ARB
                || current_query_target == GL_CLIPPING_OUTPUT_PRIMITIVES_ARB)
                && is_primitive_restart_enabled
            {
                continue;
            }
            if !is_primitive_restart_enabled {
                // SAFETY: plain state change.
                unsafe { gl.disable(glw::GL_PRIMITIVE_RESTART) };
                glu::expect_no_error(gl, "glDisable() call failed.")?;
            } else {
                // SAFETY: plain state change.
                unsafe { gl.primitive_restart_index(0) };
                glu::expect_no_error(gl, "glPrimitiveRestartIndex() call failed.")?;
                // SAFETY: plain state change.
                unsafe { gl.enable(glw::GL_PRIMITIVE_RESTART) };
                glu::expect_no_error(gl, "glEnable() call failed.")?;
            }

            for primitive_type in PRIMITIVE_TYPES {
                draw.borrow_mut().current_primitive_type = primitive_type;
                if primitive_type == PrimitiveType::Patches {
                    continue;
                }
                let first_draw_call_type = if is_primitive_restart_enabled { 4 } else { 0 };
                for draw_call_type in &DRAW_CALL_TYPES[first_draw_call_type..] {
                    draw.borrow_mut().current_draw_call_type = *draw_call_type;
                    if !is_draw_call_supported(*draw_call_type, gl) {
                        continue;
                    }
                    let (ok, skipped) =
                        execute_draw_query(context, draw, functional, current_query_target, &mut run_result)?;
                    if !ok {
                        result = false;
                    } else if !skipped {
                        let state = draw.borrow();
                        let verification_type = if current_query_target == GL_CLIPPING_OUTPUT_PRIMITIVES_ARB {
                            VerificationType::EqualOrGreater
                        } else {
                            VerificationType::ExactMatch
                        };
                        let expected_values = if current_query_target == GL_VERTICES_SUBMITTED_ARB {
                            expected_vertices_submitted(&state)
                        } else {
                            expected_primitives_submitted(&state)
                        };
                        result &= verify_result_values(
                            &run_result,
                            &expected_values,
                            functional.bo_qo_id != 0,
                            current_query_target,
                            &draw_details(&state),
                            verification_type,
                        );
                    }
                }
            }
        }
        Ok(result)
    }

    fn should_execute_for_query_target(query_target: GLenum) -> bool {
        query_target == GL_VERTICES_SUBMITTED_ARB
            || query_target == GL_PRIMITIVES_SUBMITTED_ARB
            || query_target == GL_CLIPPING_INPUT_PRIMITIVES_ARB
            || query_target == GL_CLIPPING_OUTPUT_PRIMITIVES_ARB
    }
}

impl TestCase for Functional3 {
    fn name(&self) -> &str {
        "functional_primitives_vertices_submitted_and_clipping_input_output_primitives"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let draw = RefCell::new(DrawState::new());
        iterate_functional(
            context,
            Self::should_execute_for_query_target,
            &mut |_| {
                let mut state = draw.borrow_mut();
                state.build_program(
                    gl,
                    &[
                        (glw::GL_FRAGMENT_SHADER, MINIMAL_FS_CODE),
                        (glw::GL_VERTEX_SHADER, MINIMAL_VS_CODE),
                    ],
                )?;
                // SAFETY: uses the program linked above.
                unsafe { gl.use_program(state.po_id) };
                glu::expect_no_error(gl, "glUseProgram() call failed.")
            },
            &mut |context, functional, target| Self::execute_test(context, functional, &draw, target),
            &mut |_| {
                draw.borrow_mut().deinit(gl);
                // SAFETY: plain state change.
                unsafe { gl.disable(glw::GL_PRIMITIVE_RESTART) };
            },
        )
    }
}

/// `PipelineStatisticsQueryTestFunctional4`
struct Functional4;

impl Functional4 {
    fn execute_test(
        context: &Context,
        functional: &FunctionalState,
        draw: &RefCell<DrawState>,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut run_result = TestExecutionResult::default();

        let n_vertex_components = 2;
        let vertex_data: [f32; 12] = [-0.1, 0.2, 0.3, 0.1, 0.2, -0.7, 0.5, -0.5, 0.0, 0.0, 0.1, 0.2];
        let index_data: [u32; 5] = [4, 3, 2, 1, 0];

        for n_indices in 1..index_data.len() as u32 {
            {
                let mut state = draw.borrow_mut();
                state.indirect_draw_call_baseinstance_argument = 1;
                state.indirect_draw_call_basevertex_argument = 1;
                state.indirect_draw_call_count_argument = n_indices;
                state.indirect_draw_call_first_argument = 0;
                state.indirect_draw_call_primcount_argument = 4;
                state.init_vbo(context, &vertex_data, &index_data)?;
                state.init_vao(gl, n_vertex_components)?;
            }

            for primitive_type in PRIMITIVE_TYPES {
                draw.borrow_mut().current_primitive_type = primitive_type;
                let too_few_indices = match primitive_type {
                    PrimitiveType::Patches | PrimitiveType::LinesAdjacency | PrimitiveType::TrianglesAdjacency => true,
                    PrimitiveType::LineLoop | PrimitiveType::LineStrip | PrimitiveType::Lines => n_indices < 2,
                    PrimitiveType::TriangleFan | PrimitiveType::TriangleStrip | PrimitiveType::Triangles => {
                        n_indices < 3
                    }
                    PrimitiveType::Points => false,
                };
                if too_few_indices {
                    continue;
                }
                for draw_call_type in DRAW_CALL_TYPES {
                    draw.borrow_mut().current_draw_call_type = draw_call_type;
                    if !is_draw_call_supported(draw_call_type, gl) {
                        continue;
                    }
                    let (ok, skipped) =
                        execute_draw_query(context, draw, functional, current_query_target, &mut run_result)?;
                    if !ok {
                        result = false;
                    } else if !skipped {
                        let state = draw.borrow();
                        result &= verify_result_values(
                            &run_result,
                            &[1],
                            functional.bo_qo_id != 0,
                            current_query_target,
                            &draw_details(&state),
                            VerificationType::EqualOrGreater,
                        );
                    }
                }
            }
        }
        Ok(result)
    }

    fn should_execute_for_query_target(query_target: GLenum) -> bool {
        query_target == GL_VERTEX_SHADER_INVOCATIONS_ARB
    }
}

impl TestCase for Functional4 {
    fn name(&self) -> &str {
        "functional_vertex_shader_invocations"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let draw = RefCell::new(DrawState::new());
        iterate_functional(
            context,
            Self::should_execute_for_query_target,
            &mut |_| {
                let mut state = draw.borrow_mut();
                state.build_program(gl, &[(glw::GL_VERTEX_SHADER, MINIMAL_VS_CODE)])?;
                // SAFETY: uses the program linked above.
                unsafe { gl.use_program(state.po_id) };
                glu::expect_no_error(gl, "glUseProgram() call failed.")
            },
            &mut |context, functional, target| Self::execute_test(context, functional, &draw, target),
            &mut |_| draw.borrow_mut().deinit(gl),
        )
    }
}

/// `PipelineStatisticsQueryTestFunctional5`
struct Functional5;

impl Functional5 {
    fn execute_test(
        context: &Context,
        functional: &FunctionalState,
        draw: &RefCell<DrawState>,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut run_result = TestExecutionResult::default();

        // SAFETY: plain state change.
        unsafe { gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3) };
        let n_vertex_components = 2;
        let vertex_data: [f32; 16] = [
            -0.1, 0.2, 0.3, 0.1, 0.2, -0.7, 0.5, -0.5, 0.0, 0.0, -0.6, -0.9, -0.3, 0.3, -0.5, -0.5,
        ];
        let index_data: [u32; 7] = [0, 6, 2, 1, 3, 5, 4];
        {
            let mut state = draw.borrow_mut();
            state.indirect_draw_call_baseinstance_argument = 1;
            state.indirect_draw_call_basevertex_argument = 1;
            state.indirect_draw_call_count_argument = index_data.len() as u32;
            state.indirect_draw_call_first_argument = 0;
            state.indirect_draw_call_primcount_argument = 4;
            state.init_vbo(context, &vertex_data, &index_data)?;
            state.init_vao(gl, n_vertex_components)?;
            state.current_primitive_type = PrimitiveType::Patches;
        }

        for draw_call_type in DRAW_CALL_TYPES {
            draw.borrow_mut().current_draw_call_type = draw_call_type;
            if !is_draw_call_supported(draw_call_type, gl) {
                continue;
            }
            let (ok, skipped) = execute_draw_query(context, draw, functional, current_query_target, &mut run_result)?;
            if !ok {
                result = false;
            } else if !skipped {
                let state = draw.borrow();
                let n_input_vertices = u64::from(state.indirect_draw_call_count_argument);
                let (expected_values, verification_type) = if current_query_target == GL_PRIMITIVES_SUBMITTED_ARB {
                    // Upstream seeds the list with `n / 3` and then lets the patch case append it a second time.
                    let mut expected_values = vec![n_input_vertices / 3, n_input_vertices / 3];
                    if is_instanced_draw_call(state.current_draw_call_type) {
                        for value in &mut expected_values {
                            *value *= u64::from(state.indirect_draw_call_primcount_argument);
                        }
                    }
                    (expected_values, VerificationType::ExactMatch)
                } else {
                    (vec![1], VerificationType::EqualOrGreater)
                };
                result &= verify_result_values(
                    &run_result,
                    &expected_values,
                    functional.bo_qo_id != 0,
                    current_query_target,
                    &draw_details(&state),
                    verification_type,
                );
            }
        }
        Ok(result)
    }

    fn should_execute_for_query_target(query_target: GLenum) -> bool {
        query_target == GL_TESS_CONTROL_SHADER_PATCHES_ARB
            || query_target == GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB
            || query_target == GL_PRIMITIVES_SUBMITTED_ARB
    }
}

impl TestCase for Functional5 {
    fn name(&self) -> &str {
        "functional_tess_queries"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let draw = RefCell::new(DrawState::new());
        iterate_functional(
            context,
            Self::should_execute_for_query_target,
            &mut |context| {
                if !context.context_type().supports_core(4, 0) {
                    return Err(TestError::NotSupported(
                        "OpenGL 4.0+ is required to run this test.".to_string(),
                    ));
                }
                let mut state = draw.borrow_mut();
                state.build_program(
                    gl,
                    &[
                        (glw::GL_FRAGMENT_SHADER, MINIMAL_FS_CODE),
                        (glw::GL_TESS_CONTROL_SHADER, MINIMAL_TC_CODE),
                        (glw::GL_TESS_EVALUATION_SHADER, MINIMAL_TE_CODE),
                        (glw::GL_VERTEX_SHADER, MINIMAL_VS_CODE),
                    ],
                )?;
                // SAFETY: uses the program linked above.
                unsafe { gl.use_program(state.po_id) };
                glu::expect_no_error(gl, "glUseProgram() call failed.")
            },
            &mut |context, functional, target| Self::execute_test(context, functional, &draw, target),
            &mut |_| draw.borrow_mut().deinit(gl),
        )
    }
}

/// `PipelineStatisticsQueryUtilities::_geometry_shader_input`
#[derive(Clone, Copy, PartialEq)]
enum GeometryShaderInput {
    Points,
    Lines,
    LinesAdjacency,
    Triangles,
    TrianglesAdjacency,
}

const GEOMETRY_SHADER_INPUTS: [GeometryShaderInput; 5] = [
    GeometryShaderInput::Points,
    GeometryShaderInput::Lines,
    GeometryShaderInput::LinesAdjacency,
    GeometryShaderInput::Triangles,
    GeometryShaderInput::TrianglesAdjacency,
];

/// `PipelineStatisticsQueryUtilities::_geometry_shader_output`
#[derive(Clone, Copy, PartialEq)]
enum GeometryShaderOutput {
    Points,
    LineStrip,
    TriangleStrip,
}

const GEOMETRY_SHADER_OUTPUTS: [GeometryShaderOutput; 3] = [
    GeometryShaderOutput::Points,
    GeometryShaderOutput::LineStrip,
    GeometryShaderOutput::TriangleStrip,
];

fn glsl_string_for_gs_input(gs_input: GeometryShaderInput) -> &'static str {
    match gs_input {
        GeometryShaderInput::Points => "points",
        GeometryShaderInput::Lines => "lines",
        GeometryShaderInput::LinesAdjacency => "lines_adjacency",
        GeometryShaderInput::Triangles => "triangles",
        GeometryShaderInput::TrianglesAdjacency => "triangles_adjacency",
    }
}

fn glsl_string_for_gs_output(gs_output: GeometryShaderOutput) -> &'static str {
    match gs_output {
        GeometryShaderOutput::Points => "points",
        GeometryShaderOutput::LineStrip => "line_strip",
        GeometryShaderOutput::TriangleStrip => "triangle_strip",
    }
}

fn number_of_vertices_for_gs_input(gs_input: GeometryShaderInput) -> u32 {
    match gs_input {
        GeometryShaderInput::Points => 1,
        GeometryShaderInput::Lines => 2,
        GeometryShaderInput::LinesAdjacency => 4,
        GeometryShaderInput::Triangles => 3,
        GeometryShaderInput::TrianglesAdjacency => 6,
    }
}

fn number_of_vertices_for_gs_output(gs_output: GeometryShaderOutput) -> u32 {
    match gs_output {
        GeometryShaderOutput::LineStrip => 2,
        GeometryShaderOutput::Points => 1,
        GeometryShaderOutput::TriangleStrip => 3,
    }
}

fn primitive_type_from_gs_input(gs_input: GeometryShaderInput) -> PrimitiveType {
    match gs_input {
        GeometryShaderInput::Points => PrimitiveType::Points,
        GeometryShaderInput::Lines => PrimitiveType::Lines,
        GeometryShaderInput::LinesAdjacency => PrimitiveType::LinesAdjacency,
        GeometryShaderInput::Triangles => PrimitiveType::Triangles,
        GeometryShaderInput::TrianglesAdjacency => PrimitiveType::TrianglesAdjacency,
    }
}

/// `PipelineStatisticsQueryUtilities::getNumberOfVerticesForPrimitiveType`
fn number_of_vertices_for_primitive_type(primitive_type: PrimitiveType) -> u32 {
    match primitive_type {
        PrimitiveType::Points => 1,
        PrimitiveType::LineLoop | PrimitiveType::LineStrip | PrimitiveType::Lines => 2,
        PrimitiveType::TriangleFan | PrimitiveType::TriangleStrip | PrimitiveType::Triangles => 3,
        PrimitiveType::LinesAdjacency => 4,
        PrimitiveType::TrianglesAdjacency => 6,
        PrimitiveType::Patches => unreachable!("patches are skipped by the callers"),
    }
}

/// `PipelineStatisticsQueryUtilities::buildGeometryShaderBody`
fn build_geometry_shader_body(
    gs_input: GeometryShaderInput,
    gs_output: GeometryShaderOutput,
    n_primitives_to_emit_in_stream0: u32,
    n_streams: u32,
) -> String {
    let n_vertices_required_for_gs_output = number_of_vertices_for_gs_output(gs_output);
    let n_max_vertices: u32 = (0..n_streams)
        .map(|n_stream| n_vertices_required_for_gs_output * (n_primitives_to_emit_in_stream0 + n_stream))
        .sum();

    let mut body = String::new();
    body.push_str(if n_streams > 1 {
        "#version 400"
    } else {
        "#version 150\n"
    });
    body.push_str(&format!(
        "\nlayout({})                 in;\nlayout({}, max_vertices={n_max_vertices}) out;\n",
        glsl_string_for_gs_input(gs_input),
        glsl_string_for_gs_output(gs_output)
    ));
    if n_streams > 1 {
        body.push('\n');
        for n_stream in 0..n_streams {
            body.push_str(&format!("layout(stream = {n_stream}) out vec4 out_stream{n_stream};\n"));
        }
    }
    body.push_str("\nvoid main()\n{\n");
    for n_stream in 0..n_streams {
        for _ in 0..n_primitives_to_emit_in_stream0 + n_stream {
            for _ in 0..n_vertices_required_for_gs_output {
                body.push_str("    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n");
                if n_streams == 1 {
                    body.push_str("    EmitVertex();\n");
                } else {
                    body.push_str(&format!("    EmitStreamVertex({n_stream});\n"));
                }
            }
            if n_streams == 1 {
                body.push_str("    EndPrimitive();\n");
            } else {
                body.push_str(&format!("    EndStreamPrimitive({n_stream});\n"));
            }
        }
    }
    body.push_str("}\n");
    body
}

/// `PipelineStatisticsQueryTestFunctional6`
struct Functional6;

impl Functional6 {
    const N_PRIMITIVES_EMITTED_BY_GS: u32 = 3;
    const N_STREAMS_EMITTED_BY_GS: u32 = 3;

    fn execute_test(
        context: &Context,
        functional: &FunctionalState,
        draw: &RefCell<DrawState>,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut run_result = TestExecutionResult::default();

        let n_vertex_components = 2;
        let vertex_data: [f32; 12] = [-0.1, 0.2, 0.2, -0.7, 0.5, -0.5, 0.1, -0.2, -0.2, 0.7, -0.5, 0.5];
        let index_data: [u32; 3] = [2, 1, 0];
        {
            let mut state = draw.borrow_mut();
            state.indirect_draw_call_baseinstance_argument = 1;
            state.indirect_draw_call_basevertex_argument = 1;
            state.indirect_draw_call_count_argument = 3;
            state.indirect_draw_call_first_argument = 0;
            state.indirect_draw_call_primcount_argument = 4;
            state.init_vbo(context, &vertex_data, &index_data)?;
            state.init_vao(gl, n_vertex_components)?;
        }

        for gs_input in GEOMETRY_SHADER_INPUTS {
            update_indirect_count_arguments(gl, draw, number_of_vertices_for_gs_input(gs_input))?;
            for gs_output in GEOMETRY_SHADER_OUTPUTS {
                let streams_supported = context.context_type().supports_core(4, 0);
                let n_internal_iterations =
                    if current_query_target == GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB && streams_supported {
                        2
                    } else {
                        1
                    };
                for n_internal_iteration in 0..n_internal_iterations {
                    let gs_body = if n_internal_iteration == 1 {
                        if gs_output != GeometryShaderOutput::Points {
                            continue;
                        }
                        build_geometry_shader_body(
                            gs_input,
                            gs_output,
                            Self::N_PRIMITIVES_EMITTED_BY_GS,
                            Self::N_STREAMS_EMITTED_BY_GS,
                        )
                    } else {
                        build_geometry_shader_body(gs_input, gs_output, Self::N_PRIMITIVES_EMITTED_BY_GS, 1)
                    };
                    {
                        let mut state = draw.borrow_mut();
                        state.build_program(
                            gl,
                            &[
                                (glw::GL_FRAGMENT_SHADER, MINIMAL_FS_CODE),
                                (glw::GL_GEOMETRY_SHADER, gs_body.as_str()),
                                (glw::GL_VERTEX_SHADER, MINIMAL_VS_CODE),
                            ],
                        )?;
                        // SAFETY: uses the program linked above.
                        unsafe { gl.use_program(state.po_id) };
                        glu::expect_no_error(gl, "glUseProgram() call failed.")?;
                        state.current_primitive_type = primitive_type_from_gs_input(gs_input);
                    }
                    for draw_call_type in DRAW_CALL_TYPES {
                        draw.borrow_mut().current_draw_call_type = draw_call_type;
                        if !is_draw_call_supported(draw_call_type, gl) {
                            continue;
                        }
                        let (ok, skipped) =
                            execute_draw_query(context, draw, functional, current_query_target, &mut run_result)?;
                        if !ok {
                            result = false;
                        } else if !skipped {
                            let state = draw.borrow();
                            let (expected_values, verification_type) = if current_query_target
                                == GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB
                            {
                                let mut expected_values = [u64::from(Self::N_PRIMITIVES_EMITTED_BY_GS); 2];
                                if n_internal_iteration == 1 {
                                    for n_stream in 1..Self::N_STREAMS_EMITTED_BY_GS {
                                        expected_values[1] += u64::from(Self::N_PRIMITIVES_EMITTED_BY_GS + n_stream);
                                    }
                                }
                                if is_instanced_draw_call(state.current_draw_call_type) {
                                    for value in &mut expected_values {
                                        *value *= u64::from(state.indirect_draw_call_primcount_argument);
                                    }
                                }
                                (expected_values.to_vec(), VerificationType::ExactMatch)
                            } else {
                                (vec![1], VerificationType::EqualOrGreater)
                            };
                            result &= verify_result_values(
                                &run_result,
                                &expected_values,
                                functional.bo_qo_id != 0,
                                current_query_target,
                                &draw_details(&state),
                                verification_type,
                            );
                        }
                    }
                }
            }
        }
        Ok(result)
    }

    fn should_execute_for_query_target(query_target: GLenum) -> bool {
        query_target == glw::GL_GEOMETRY_SHADER_INVOCATIONS || query_target == GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB
    }
}

/// Writes the new `count` into the first argument of both indirect draw call argument blocks.
fn update_indirect_count_arguments(
    gl: &glw::Functions,
    draw: &RefCell<DrawState>,
    count: u32,
) -> Result<(), TestError> {
    let mut state = draw.borrow_mut();
    state.indirect_draw_call_count_argument = count;
    for offset in [
        state.vbo_indirect_arrays_argument_offset,
        state.vbo_indirect_elements_argument_offset,
    ] {
        // SAFETY: the pointer addresses one `u32` and the range lies inside the buffer allocated by `initVBO`.
        unsafe {
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                offset as glw::GLintptr,
                4,
                std::ptr::from_ref(&count).cast(),
            )
        };
    }
    glu::expect_no_error(gl, "glBufferSubData() call(s) failed.")
}

impl TestCase for Functional6 {
    fn name(&self) -> &str {
        "functional_geometry_shader_queries"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let draw = RefCell::new(DrawState::new());
        iterate_functional(
            context,
            Self::should_execute_for_query_target,
            &mut |context| {
                if !context.context_type().supports_core(3, 2) {
                    return Err(TestError::NotSupported(
                        "OpenGL 3.2+ is required to run this test.".to_string(),
                    ));
                }
                Ok(())
            },
            &mut |context, functional, target| Self::execute_test(context, functional, &draw, target),
            &mut |_| draw.borrow_mut().deinit(gl),
        )
    }
}

/// `PipelineStatisticsQueryTestFunctional7`
struct Functional7;

impl Functional7 {
    fn execute_test(
        context: &Context,
        functional: &FunctionalState,
        draw: &RefCell<DrawState>,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut run_result = TestExecutionResult::default();

        let n_vertex_components = 2;
        let vertex_data: [f32; 16] = [
            0.0, 0.75, -0.75, -0.75, 0.75, -0.75, 0.3, 0.7, -0.4, 0.2, 0.6, -0.3, -0.3, -0.7, 0.0, 0.0,
        ];
        let index_data: [u32; 8] = [0, 2, 1, 3, 4, 5, 6, 7];
        {
            let mut state = draw.borrow_mut();
            state.indirect_draw_call_baseinstance_argument = 1;
            state.indirect_draw_call_basevertex_argument = 1;
            state.indirect_draw_call_count_argument = 3;
            state.indirect_draw_call_first_argument = 0;
            state.indirect_draw_call_primcount_argument = 4;
            state.init_fbo(gl)?;
            state.init_vbo(context, &vertex_data, &index_data)?;
            state.init_vao(gl, n_vertex_components)?;
        }

        for primitive_type in PRIMITIVE_TYPES {
            if primitive_type == PrimitiveType::Patches {
                continue;
            }
            draw.borrow_mut().current_primitive_type = primitive_type;
            update_indirect_count_arguments(gl, draw, number_of_vertices_for_primitive_type(primitive_type))?;
            for draw_call_type in DRAW_CALL_TYPES {
                draw.borrow_mut().current_draw_call_type = draw_call_type;
                if !is_draw_call_supported(draw_call_type, gl) {
                    continue;
                }
                // SAFETY: clears the framebuffer bound by `initFBO`.
                unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT) };
                glu::expect_no_error(gl, "glClear() call failed.")?;
                let (ok, skipped) =
                    execute_draw_query(context, draw, functional, current_query_target, &mut run_result)?;
                if !ok {
                    result = false;
                } else if !skipped {
                    let state = draw.borrow();
                    result &= verify_result_values(
                        &run_result,
                        &[1],
                        functional.bo_qo_id != 0,
                        current_query_target,
                        &draw_details(&state),
                        VerificationType::EqualOrGreater,
                    );
                }
            }
        }
        Ok(result)
    }

    fn should_execute_for_query_target(query_target: GLenum) -> bool {
        query_target == GL_FRAGMENT_SHADER_INVOCATIONS_ARB
    }
}

impl TestCase for Functional7 {
    fn name(&self) -> &str {
        "functional_fragment_shader_invocations"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let draw = RefCell::new(DrawState::new());
        iterate_functional(
            context,
            Self::should_execute_for_query_target,
            &mut |_| {
                let mut state = draw.borrow_mut();
                state.build_program(
                    gl,
                    &[
                        (glw::GL_FRAGMENT_SHADER, MINIMAL_FS_CODE),
                        (glw::GL_VERTEX_SHADER, MINIMAL_VS_CODE),
                    ],
                )?;
                // SAFETY: uses the program linked above.
                unsafe { gl.use_program(state.po_id) };
                glu::expect_no_error(gl, "glUseProgram() call failed.")
            },
            &mut |context, functional, target| Self::execute_test(context, functional, &draw, target),
            &mut |_| draw.borrow_mut().deinit(gl),
        )
    }
}

/// `PipelineStatisticsQueryTestFunctional8`
struct Functional8;

/// What `PipelineStatisticsQueryTestFunctional8::initObjects` creates besides the program.
#[derive(Default)]
struct Functional8Objects {
    po_id: GLuint,
    bo_id: GLuint,
}

impl Functional8 {
    const BO_DISPATCH_COMPUTE_INDIRECT_ARGS_OFFSET: usize = 4;

    fn execute_test(
        context: &Context,
        functional: &FunctionalState,
        current_query_target: GLenum,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut run_result = TestExecutionResult::default();
        for current_iteration in 0..2 {
            let mut dispatch = || -> Result<(), TestError> {
                // SAFETY: dispatches the compute program and the indirect arguments set up by `initObjects`.
                unsafe {
                    if current_iteration == 0 {
                        gl.dispatch_compute(1, 1, 1);
                    } else {
                        gl.dispatch_compute_indirect(Self::BO_DISPATCH_COMPUTE_INDIRECT_ARGS_OFFSET as glw::GLintptr);
                    }
                }
                // SAFETY: plain state query.
                let error_code = unsafe { gl.get_error() };
                if error_code != glw::GL_NO_ERROR {
                    log::info!(
                        "{} call failed with error code [{error_code}].",
                        if current_iteration == 0 {
                            "glDispatchCompute()"
                        } else {
                            "glDispatchComputeIndirect()"
                        }
                    );
                }
                Ok(())
            };
            let execution = execute_query(
                context,
                current_query_target,
                functional.qo_id,
                functional.bo_qo_id,
                Some(&mut dispatch),
                &mut run_result,
            )?;
            if !execution.ok {
                log::info!(
                    "Could not retrieve test run results for query target [{}]",
                    string_for_enum(current_query_target)
                );
                result = false;
            } else if !execution.skipped {
                result &= verify_result_values(
                    &run_result,
                    &[1],
                    functional.bo_qo_id != 0,
                    current_query_target,
                    "",
                    VerificationType::EqualOrGreater,
                );
            }
        }
        Ok(result)
    }

    fn init_objects(context: &Context, objects: &mut Functional8Objects) -> Result<(), TestError> {
        let gl = context.gl();
        let cs_code = if context.context_type().supports_core(4, 3) {
            MINIMAL_CS_CODE
        } else if context.context_info.is_extension_supported("GL_ARB_compute_shader")
            && context
                .context_info
                .is_extension_supported("GL_ARB_shader_atomic_counters")
        {
            MINIMAL_CS_CODE_ARB
        } else {
            return Err(TestError::NotSupported(
                "OpenGL 4.3+ / compute shaders and atomic counters required to run this test.".to_string(),
            ));
        };
        let mut state = DrawState::new();
        let built = state.build_program(gl, &[(glw::GL_COMPUTE_SHADER, cs_code)]);
        objects.po_id = state.po_id;
        built?;
        // SAFETY: uses the program linked above.
        unsafe { gl.use_program(objects.po_id) };
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;

        let atomic_counter_value: u32 = 0;
        let bo_size = 4 * (1 + 3);
        let drawcall_args: [u32; 3] = [1, 1, 1];
        // SAFETY: the name is written to the live field.
        unsafe { gl.gen_buffers(1, &mut objects.bo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        // SAFETY: binds the buffer created above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.bo_id) };
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, objects.bo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, objects.bo_id) };
        glu::expect_no_error(gl, "glBindBufferBase() call failed.")?;
        // SAFETY: allocates without data.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                bo_size as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call failed.")?;
        // SAFETY: each pointer covers the bytes passed and the ranges lie inside the allocation above.
        unsafe {
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                0,
                4,
                std::ptr::from_ref(&atomic_counter_value).cast(),
            );
            gl.buffer_sub_data(
                glw::GL_ARRAY_BUFFER,
                4,
                std::mem::size_of_val(&drawcall_args) as glw::GLsizeiptr,
                drawcall_args.as_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "glBufferSubData() call failed.")
    }

    fn should_execute_for_query_target(query_target: GLenum) -> bool {
        query_target == GL_COMPUTE_SHADER_INVOCATIONS_ARB
    }
}

impl TestCase for Functional8 {
    fn name(&self) -> &str {
        "functional_compute_shader_invocations"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let objects = RefCell::new(Functional8Objects::default());
        iterate_functional(
            context,
            Self::should_execute_for_query_target,
            &mut |context| Self::init_objects(context, &mut objects.borrow_mut()),
            &mut |context, functional, target| Self::execute_test(context, functional, target),
            &mut |_| {
                let mut objects = objects.borrow_mut();
                // SAFETY: deletes only names created by `initObjects`.
                unsafe {
                    if objects.bo_id != 0 {
                        gl.delete_buffers(1, &objects.bo_id);
                    }
                    if objects.po_id != 0 {
                        gl.delete_program(objects.po_id);
                    }
                }
                *objects = Functional8Objects::default();
            },
        )
    }
}

pub(super) fn add_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(Functional3) as Box<dyn TestCase>);
    group.add_child(Box::new(Functional4) as Box<dyn TestCase>);
    group.add_child(Box::new(Functional5) as Box<dyn TestCase>);
    group.add_child(Box::new(Functional6) as Box<dyn TestCase>);
    group.add_child(Box::new(Functional7) as Box<dyn TestCase>);
    group.add_child(Box::new(Functional8) as Box<dyn TestCase>);
}
