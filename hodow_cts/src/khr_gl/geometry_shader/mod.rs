// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderTests.cpp
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderAPI.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. PARTIAL: of the `geometry_shader` group the `api` subgroup (all 16 cases), `clipping`, `nonarray_input`, `output`, `primitive_queries` and `qualifiers` (`clipping.rs`, `nonarray_input.rs`, `output.rs`, `primitive_queries.rs`, `qualifiers.rs`) and seven cases of `linking` are ported (type, qualifier and arrayed-size mismatch, fragcoord redeclaration, location aliasing and compilation failure, which share `LinkingCase`, and more_input_vertices_in_GS_than_available); every other subgroup and case is not ported yet.

mod adjacency;
mod blitting;
mod clipping;
mod constant_variables;
mod incomplete;
mod input;
mod layered_fbo;
mod layered_framebuffer;
mod layered_rendering;
mod layered_rendering_boundary_condition;
mod layered_rendering_fbo_no_attachment;
mod limits;
mod more_atomic_counters;
mod nonarray_input;
mod output;
mod primitive_counter;
mod primitive_queries;
mod program_resource;
mod qualifiers;
mod rendering;
mod rendering_shaders;
mod tf_capture;

use std::ffi::{CString, c_char};

use super::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::glu::{self, Context, TestCase, TestCaseGroup, TestNode};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Geometry shader functionality not supported, skipping";

const MINIMAL_FS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(1.0);\n}\n";
const MINIMAL_VS_CODE: &str =
    "${VERSION}\n\n${OUT_PER_VERTEX_DECL}\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

fn verdict(result: bool) -> TestOutcome {
    Ok(if result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

fn require_geometry_shader(base: &TestCaseBase) -> Result<(), TestError> {
    if !base.is_geometry_shader_extension_supported {
        return Err(TestError::NotSupported(
            GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
        ));
    }
    Ok(())
}

/// `GeometryShaderCreateShaderProgramvTest`
struct CreateShaderProgramv {
    ext_params: ExtParameters,
}

const CREATE_SHADER_PROGRAMV_FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(0.0, 1.0, 0.0, 0.0);\n}\n";
const CREATE_SHADER_PROGRAMV_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                           in;\nlayout (triangle_strip, max_vertices = 4) out;\n\n${OUT_PER_VERTEX_DECL}\nvoid main()\n{\n    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n    EmitVertex();\n\n    gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n    EmitVertex();\n\n    gl_Position = vec4(1.0, -1.0, 0.0, 1.0);\n    EmitVertex();\n\n    gl_Position = vec4(1.0, 1.0, 0.0, 1.0);\n    EmitVertex();\n    EndPrimitive();\n}\n";
const CREATE_SHADER_PROGRAMV_VS_CODE: &str =
    "${VERSION}\n\n${OUT_PER_VERTEX_DECL}\nvoid main()\n{\n    gl_Position = vec4(-10.0, -10.0, -10.0, 0.0);\n}\n";
const TO_WIDTH: usize = 4;
const TO_HEIGHT: usize = 4;

/// The objects `GeometryShaderCreateShaderProgramvTest` creates and `deinit` releases.
#[derive(Default)]
struct CreateShaderProgramvObjects {
    fbo_id: GLuint,
    fs_po_id: GLuint,
    gs_po_id: GLuint,
    pipeline_object_id: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
    vs_po_id: GLuint,
}

impl CreateShaderProgramv {
    /// `GeometryShaderCreateShaderProgramvTest::initFBO`
    fn init_fbo(context: &Context, objects: &mut CreateShaderProgramvObjects) -> Result<(), TestError> {
        let gl = context.gl();
        // SAFETY: names are written to live fields; the other calls use the objects just created.
        unsafe {
            gl.gen_framebuffers(1, &mut objects.fbo_id);
        }
        glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.gen_textures(1, &mut objects.to_id) };
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, objects.to_id) };
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;
        // SAFETY: as above.
        unsafe {
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                TO_WIDTH as glw::GLsizei,
                TO_HEIGHT as glw::GLsizei,
            )
        };
        glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo_id) };
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;
        // SAFETY: as above.
        unsafe {
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                objects.to_id,
                0,
            )
        };
        glu::expect_no_error(gl, "glFramebufferTexture2D() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.viewport(0, 0, TO_WIDTH as glw::GLsizei, TO_HEIGHT as glw::GLsizei) };
        glu::expect_no_error(gl, "glViewport() call failed.")
    }

    /// `GeometryShaderCreateShaderProgramvTest::initPipelineObject`
    fn init_pipeline_object(context: &Context, objects: &mut CreateShaderProgramvObjects) -> Result<(), TestError> {
        let gl = context.gl();
        debug_assert!(objects.fs_po_id != 0 && objects.gs_po_id != 0 && objects.vs_po_id != 0);
        // SAFETY: the name is written to a live field; the stages are programs created by `createShaderProgramv`.
        unsafe { gl.gen_program_pipelines(1, &mut objects.pipeline_object_id) };
        glu::expect_no_error(gl, "glGenProgramPipelines() call failed.")?;
        // SAFETY: as above.
        unsafe {
            gl.use_program_stages(
                objects.pipeline_object_id,
                glw::GL_FRAGMENT_SHADER_BIT,
                objects.fs_po_id,
            );
            gl.use_program_stages(
                objects.pipeline_object_id,
                glw::GL_GEOMETRY_SHADER_BIT,
                objects.gs_po_id,
            );
            gl.use_program_stages(objects.pipeline_object_id, glw::GL_VERTEX_SHADER_BIT, objects.vs_po_id);
        }
        glu::expect_no_error(gl, "glUseProgramStages() call(s) failed.")
    }

    fn create_shader_program(gl: &glw::Functions, shader_type: GLenum, source: &str) -> GLuint {
        let source = CString::new(source).expect("no NUL in a shader source");
        let pointer: *const c_char = source.as_ptr();
        // SAFETY: one NUL-terminated source string that outlives the call.
        unsafe { gl.create_shader_programv(shader_type, 1, &pointer) }
    }

    fn deinit(context: &Context, objects: &mut CreateShaderProgramvObjects) {
        let gl = context.gl();
        // SAFETY: deletes only names this case created.
        unsafe {
            if objects.fbo_id != 0 {
                gl.delete_framebuffers(1, &objects.fbo_id);
            }
            if objects.fs_po_id != 0 {
                gl.delete_program(objects.fs_po_id);
            }
            if objects.gs_po_id != 0 {
                gl.delete_program(objects.gs_po_id);
            }
            if objects.pipeline_object_id != 0 {
                gl.delete_program_pipelines(1, &objects.pipeline_object_id);
            }
            if objects.to_id != 0 {
                gl.delete_textures(1, &objects.to_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_po_id != 0 {
                gl.delete_program(objects.vs_po_id);
            }
        }
        *objects = CreateShaderProgramvObjects::default();
    }

    fn run(&self, context: &Context, objects: &mut CreateShaderProgramvObjects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        Self::init_fbo(context, objects)?;

        let fs_specialized_code = base.specialize_shader(&[CREATE_SHADER_PROGRAMV_FS_CODE]);
        let gs_specialized_code = base.specialize_shader(&[CREATE_SHADER_PROGRAMV_GS_CODE]);
        let vs_specialized_code = base.specialize_shader(&[CREATE_SHADER_PROGRAMV_VS_CODE]);

        // The unspecialized shader still holds its ${...} markers, so it cannot be linked.
        objects.gs_po_id = Self::create_shader_program(gl, glw::GL_GEOMETRY_SHADER, CREATE_SHADER_PROGRAMV_GS_CODE);
        glu::expect_no_error(gl, "glCreateShaderProgramv() call failed.")?;
        if objects.gs_po_id == 0 {
            log::info!("glCreateShaderProgramv() call returned 0.");
            return verdict(false);
        }
        let mut link_status: GLint = glw::GL_TRUE as GLint;
        // SAFETY: the value is written to the live local.
        unsafe { gl.get_programiv(objects.gs_po_id, glw::GL_LINK_STATUS, &mut link_status) };
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
        if link_status != glw::GL_FALSE as GLint {
            log::info!("An invalid shader program was linked successfully.");
            return verdict(false);
        }
        // SAFETY: deletes the program created above.
        unsafe { gl.delete_program(objects.gs_po_id) };
        glu::expect_no_error(gl, "glDeleteProgram() call failed.")?;

        objects.fs_po_id = Self::create_shader_program(gl, glw::GL_FRAGMENT_SHADER, &fs_specialized_code);
        objects.gs_po_id = Self::create_shader_program(gl, glw::GL_GEOMETRY_SHADER, &gs_specialized_code);
        objects.vs_po_id = Self::create_shader_program(gl, glw::GL_VERTEX_SHADER, &vs_specialized_code);
        glu::expect_no_error(gl, "glCreateShaderProgramv() call(s) failed.")?;
        if objects.fs_po_id == 0 || objects.gs_po_id == 0 || objects.vs_po_id == 0 {
            log::info!("At least one glCreateShaderProgramv() call returned 0.");
            return verdict(false);
        }

        for po_id in [objects.fs_po_id, objects.gs_po_id, objects.vs_po_id] {
            // SAFETY: the value is written to the live local.
            unsafe { gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut link_status) };
            glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
            if link_status != glw::GL_TRUE as GLint {
                log::info!("A valid shader program with id [{po_id}] was not linked successfully.");
                return verdict(false);
            }
        }

        // SAFETY: the name is written to a live field.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: binds the vertex array created above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

        Self::init_pipeline_object(context, objects)?;
        // SAFETY: binds the pipeline created above.
        unsafe { gl.bind_program_pipeline(objects.pipeline_object_id) };
        glu::expect_no_error(gl, "glBindProgramPipeline() call failed.")?;

        // SAFETY: draws one point with the pipeline bound above.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        glu::expect_no_error(gl, "glDrawArrays() call failed.")?;

        let mut result_data = [0u8; TO_WIDTH * TO_HEIGHT * 4];
        // SAFETY: the buffer holds the whole TO_WIDTH x TO_HEIGHT RGBA8 region read.
        unsafe {
            gl.read_pixels(
                0,
                0,
                TO_WIDTH as glw::GLsizei,
                TO_HEIGHT as glw::GLsizei,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                result_data.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels() call failed.")?;

        let mut result = true;
        for y in 0..TO_HEIGHT {
            // Upstream starts each row at `4 * y` bytes, not at `4 * y * width`; kept.
            let mut traveller = 4 * y;
            for x in 0..TO_WIDTH {
                if result_data[traveller] != 0
                    || result_data[traveller + 1] != 255
                    || result_data[traveller + 2] != 0
                    || result_data[traveller + 3] != 0
                {
                    log::info!("Invalid result texel found at ({x}, {y}).");
                    result = false;
                }
                traveller += 4;
            }
        }
        verdict(result)
    }
}

impl TestCase for CreateShaderProgramv {
    fn name(&self) -> &str {
        "createShaderProgramv"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut objects = CreateShaderProgramvObjects::default();
        let outcome = self.run(context, &mut objects);
        Self::deinit(context, &mut objects);
        outcome
    }
}

/// `GeometryShaderGetShaderivTest`
struct GetShaderiv {
    ext_params: ExtParameters,
}

impl TestCase for GetShaderiv {
    fn name(&self) -> &str {
        "shader_type"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        // SAFETY: creates a shader object.
        let gs_id = unsafe { gl.create_shader(glw::GL_GEOMETRY_SHADER) };
        let outcome = (|| -> TestOutcome {
            glu::expect_no_error(gl, "glCreateShader() call failed.")?;
            let mut shader_type: GLint = glw::GL_NONE as GLint;
            // SAFETY: the value is written to the live local.
            unsafe { gl.get_shaderiv(gs_id, glw::GL_SHADER_TYPE, &mut shader_type) };
            glu::expect_no_error(gl, "glGetShaderiv() call failed.")?;
            let mut result = true;
            if shader_type as GLenum != base.gl_ext_tokens.geometry_shader {
                log::info!("Invalid shader type [{shader_type}] reported for a Geometry Shader");
                result = false;
            }
            verdict(result)
        })();
        if gs_id != 0 {
            // SAFETY: deletes the shader created above (`deinit`).
            unsafe { gl.delete_shader(gs_id) };
        }
        outcome
    }
}

/// Queries each geometry-shader-only program parameter of `po_id` and expects `GL_INVALID_OPERATION` for every one of them.
fn expect_invalid_operation_for_gs_pnames(context: &Context, base: &TestCaseBase, po_id: GLuint) -> bool {
    let gl = context.gl();
    let pnames = [
        base.gl_ext_tokens.geometry_linked_vertices_out,
        base.gl_ext_tokens.geometry_linked_input_type,
        base.gl_ext_tokens.geometry_linked_output_type,
        base.gl_ext_tokens.geometry_shader_invocations,
    ];
    let mut result = true;
    for pname in pnames {
        let mut rv: GLint = -1;
        // SAFETY: the value is written to the live local.
        unsafe { gl.get_programiv(po_id, pname, &mut rv) };
        // SAFETY: plain state query.
        let error_code = unsafe { gl.get_error() };
        if error_code != glw::GL_INVALID_OPERATION {
            log::info!("No error generated by glGetProgramiv() for pname [{pname}]");
            result = false;
        }
    }
    result
}

/// `GeometryShaderGetProgramivTest`
struct GetProgramiv {
    ext_params: ExtParameters,
}

impl TestCase for GetProgramiv {
    fn name(&self) -> &str {
        "getProgramiv"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        // SAFETY: creates a program object.
        let po_id = unsafe { gl.create_program() };
        let outcome = (|| -> TestOutcome {
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
            verdict(expect_invalid_operation_for_gs_pnames(context, &base, po_id))
        })();
        if po_id != 0 {
            // SAFETY: deletes the program created above (`deinit`).
            unsafe { gl.delete_program(po_id) };
        }
        outcome
    }
}

/// `GeometryShaderGetProgramiv2Test`
struct GetProgramiv2 {
    ext_params: ExtParameters,
}

impl GetProgramiv2 {
    fn run(&self, context: &Context, ids: &mut [GLuint; 3]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        let [fs_id, po_id, vs_id] = ids;
        // SAFETY: creates shader objects and a program object.
        unsafe {
            *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            *vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;
        // SAFETY: as above.
        *po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        let fs_parts = [MINIMAL_FS_CODE];
        let vs_parts = [MINIMAL_VS_CODE];
        if !base
            .build_program(
                context,
                *po_id,
                &[
                    ShaderBody::Source(*fs_id, &fs_parts),
                    ShaderBody::Source(*vs_id, &vs_parts),
                ],
            )?
            .0
        {
            log::info!("Failed to build a minimal test program object");
            return verdict(false);
        }
        verdict(expect_invalid_operation_for_gs_pnames(context, &base, *po_id))
    }
}

impl TestCase for GetProgramiv2 {
    fn name(&self) -> &str {
        "getProgramiv2"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 3];
        let outcome = self.run(context, &mut ids);
        let [fs_id, po_id, vs_id] = ids;
        // SAFETY: deletes only names this case created.
        unsafe {
            if fs_id != 0 {
                gl.delete_shader(fs_id);
            }
            if po_id != 0 {
                gl.delete_program(po_id);
            }
            if vs_id != 0 {
                gl.delete_shader(vs_id);
            }
        }
        outcome
    }
}

const MINIMAL_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n${OUT_PER_VERTEX_DECL}${IN_DATA_DECL}void main()\n{\n${POSITION_WITH_IN_DATA}    EmitVertex();\n}\n";

/// `GeometryShaderGetProgramiv3Test::buildShader`
fn build_shader(gl: &glw::Functions, so_id: GLuint, so_body: &str) -> Result<bool, TestError> {
    let pointer: *const glw::GLchar = so_body.as_ptr().cast();
    let length = so_body.len() as GLint;
    // SAFETY: one source string of `length` bytes.
    unsafe { gl.shader_source(so_id, 1, &pointer, &length) };
    glu::expect_no_error(gl, "glShaderSource() call failed.")?;
    // SAFETY: compiles the shader named by the caller.
    unsafe { gl.compile_shader(so_id) };
    glu::expect_no_error(gl, "glCompileShader() call failed.")?;
    let mut compile_status: GLint = glw::GL_FALSE as GLint;
    // SAFETY: the value is written to the live local.
    unsafe { gl.get_shaderiv(so_id, glw::GL_COMPILE_STATUS, &mut compile_status) };
    glu::expect_no_error(gl, "glGetShaderiv() call failed.")?;
    Ok(compile_status == glw::GL_TRUE as GLint)
}

/// `GeometryShaderGetProgramiv3Test::buildShaderProgram`; the program name goes to `out_spo_id` before the link status is known, as upstream.
fn build_shader_program(
    gl: &glw::Functions,
    out_spo_id: &mut GLuint,
    spo_bits: GLenum,
    spo_body: &str,
) -> Result<bool, TestError> {
    *out_spo_id = CreateShaderProgramv::create_shader_program(gl, spo_bits, spo_body);
    glu::expect_no_error(gl, "glCreateShaderProgramv() call failed.")?;
    let mut link_status: GLint = glw::GL_FALSE as GLint;
    // SAFETY: the value is written to the live local.
    unsafe { gl.get_programiv(*out_spo_id, glw::GL_LINK_STATUS, &mut link_status) };
    glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
    Ok(link_status == glw::GL_TRUE as GLint)
}

/// `GeometryShaderGetProgramiv3Test::getLayoutQualifierForPrimitiveType`
fn layout_qualifier_for_primitive_type(primitive_type: GLenum) -> &'static str {
    match primitive_type {
        glw::GL_LINE_STRIP => "line_strip",
        glw::GL_LINES_ADJACENCY => "lines_adjacency",
        glw::GL_POINTS => "points",
        glw::GL_TRIANGLES => "triangles",
        glw::GL_TRIANGLE_STRIP => "triangle_strip",
        _ => unreachable!("not a geometry shader primitive type"),
    }
}

/// `GeometryShaderGetProgramiv3Test::_run`
struct GetProgramiv3Run {
    input_primitive_type: GLenum,
    invocations: GLint,
    max_vertices: GLint,
    output_primitive_type: GLenum,
}

impl GetProgramiv3Run {
    /// `GeometryShaderGetProgramiv3Test::getGSCode`
    fn gs_code(&self) -> String {
        format!(
            "${{VERSION}}\n${{GEOMETRY_SHADER_REQUIRE}}\n\nlayout({}, invocations = {}) in;\nlayout({}, max_vertices = {}) out;\n\nout gl_PerVertex {{\n    vec4 gl_Position;\n}};\n\nvoid main()\n{{\n    for (int n = 0; n < {}; ++n)\n    {{\n        gl_Position = vec4(n, 0.0, 0.0, 1.0);\n        EmitVertex();\n    }}\n\n    EndPrimitive();\n}}\n",
            layout_qualifier_for_primitive_type(self.input_primitive_type),
            self.invocations,
            layout_qualifier_for_primitive_type(self.output_primitive_type),
            self.max_vertices,
            self.max_vertices
        )
    }
}

/// The objects `GeometryShaderGetProgramiv3Test` creates and `deinit` releases.
#[derive(Default)]
struct GetProgramiv3Objects {
    fs_id: GLuint,
    fs_po_id: GLuint,
    gs_id: GLuint,
    gs_po_id: GLuint,
    pipeline_object_id: GLuint,
    po_id: GLuint,
    vs_id: GLuint,
    vs_po_id: GLuint,
}

/// `GeometryShaderGetProgramiv3Test`
struct GetProgramiv3 {
    ext_params: ExtParameters,
}

impl GetProgramiv3 {
    fn deinit(context: &Context, objects: &mut GetProgramiv3Objects) {
        let gl = context.gl();
        // SAFETY: deletes only names this case created (zero names are skipped, as upstream).
        unsafe {
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
            }
            for shader in [objects.fs_id, objects.gs_id, objects.vs_id] {
                if shader != 0 {
                    gl.delete_shader(shader);
                }
            }
            for program in [objects.fs_po_id, objects.gs_po_id, objects.vs_po_id] {
                if program != 0 {
                    gl.delete_program(program);
                }
            }
            if objects.pipeline_object_id != 0 {
                gl.delete_program_pipelines(1, &objects.pipeline_object_id);
            }
        }
        *objects = GetProgramiv3Objects::default();
    }

    fn query(gl: &glw::Functions, po_id: GLuint, pname: GLenum, what: &str) -> Result<GLint, TestError> {
        let mut value: GLint = 0;
        // SAFETY: the value is written to the live local.
        unsafe { gl.get_programiv(po_id, pname, &mut value) };
        glu::expect_no_error(gl, &format!("glGetProgramiv() call failed for {what} query."))?;
        Ok(value)
    }

    fn run(&self, context: &Context, objects: &mut GetProgramiv3Objects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let mut result = true;

        let minimal_fs_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let minimal_vs_specialized = base.specialize_shader(&[MINIMAL_VS_CODE]);

        // SAFETY: creates shader objects.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;
        if !build_shader(gl, objects.fs_id, &minimal_fs_specialized)?
            || !build_shader(gl, objects.vs_id, &minimal_vs_specialized)?
        {
            log::info!("Either FS or VS failed to build.");
            return verdict(false);
        }

        // SAFETY: creates a program object and attaches the shaders created above.
        objects.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        // SAFETY: as above.
        unsafe {
            gl.attach_shader(objects.po_id, objects.fs_id);
            gl.attach_shader(objects.po_id, objects.gs_id);
            gl.attach_shader(objects.po_id, objects.vs_id);
        }
        glu::expect_no_error(gl, "glAttachShader() call(s) failed.")?;

        if !build_shader_program(
            gl,
            &mut objects.fs_po_id,
            glw::GL_FRAGMENT_SHADER,
            &minimal_fs_specialized,
        )? || !build_shader_program(
            gl,
            &mut objects.vs_po_id,
            glw::GL_VERTEX_SHADER,
            &minimal_vs_specialized,
        )? {
            log::info!("Either FS or VS SPOs failed to build.");
            return verdict(false);
        }

        let runs = [
            GetProgramiv3Run {
                input_primitive_type: glw::GL_LINES_ADJACENCY,
                invocations: 3,
                max_vertices: 16,
                output_primitive_type: glw::GL_POINTS,
            },
            GetProgramiv3Run {
                input_primitive_type: glw::GL_TRIANGLES,
                invocations: 12,
                max_vertices: 37,
                output_primitive_type: glw::GL_LINE_STRIP,
            },
            GetProgramiv3Run {
                input_primitive_type: glw::GL_POINTS,
                invocations: 31,
                max_vertices: 75,
                output_primitive_type: glw::GL_TRIANGLE_STRIP,
            },
        ];
        for should_use_separable_object in [false, true] {
            for current_run in &runs {
                let gs_code_specialized = base.specialize_shader(&[&current_run.gs_code()]);
                if should_use_separable_object {
                    // `deinitSPOs(false)`
                    if objects.gs_po_id != 0 {
                        // SAFETY: deletes the program created by an earlier run.
                        unsafe { gl.delete_program(objects.gs_po_id) };
                        objects.gs_po_id = 0;
                    }
                    if !build_shader_program(gl, &mut objects.gs_po_id, glw::GL_GEOMETRY_SHADER, &gs_code_specialized)?
                    {
                        log::info!("Failed to compile a geometry shader program object");
                        return verdict(false);
                    }
                } else {
                    // SAFETY: unbinds the pipeline.
                    unsafe { gl.bind_program_pipeline(0) };
                    glu::expect_no_error(gl, "glBindProgramPipeline() call failed.")?;
                    if !build_shader(gl, objects.gs_id, &gs_code_specialized)? {
                        log::info!("Failed to compile a geometry shader object.");
                        return verdict(false);
                    }
                    let mut link_status: GLint = glw::GL_FALSE as GLint;
                    // SAFETY: links the program the shaders are attached to.
                    unsafe { gl.link_program(objects.po_id) };
                    glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
                    // SAFETY: the value is written to the live local.
                    unsafe { gl.get_programiv(objects.po_id, glw::GL_LINK_STATUS, &mut link_status) };
                    if link_status == glw::GL_FALSE as GLint {
                        log::info!("Test program object failed to link");
                        return verdict(false);
                    }
                    // SAFETY: uses the program linked above.
                    unsafe { gl.use_program(objects.po_id) };
                    glu::expect_no_error(gl, "glUseProgram() call failed.")?;
                }

                let po_id = if should_use_separable_object {
                    objects.gs_po_id
                } else {
                    objects.po_id
                };
                let linked_vertices_out = Self::query(
                    gl,
                    po_id,
                    base.gl_ext_tokens.geometry_linked_vertices_out,
                    "GL_GEOMETRY_LINKED_VERTICES_OUT_EXT",
                )?;
                let linked_input_type = Self::query(
                    gl,
                    po_id,
                    base.gl_ext_tokens.geometry_linked_input_type,
                    "GL_GEOMETRY_LINKED_INPUT_TYPE_EXT",
                )?;
                let linked_output_type = Self::query(
                    gl,
                    po_id,
                    base.gl_ext_tokens.geometry_linked_output_type,
                    "GL_GEOMETRY_LINKED_OUTPUT_TYPE_EXT",
                )?;
                let shader_invocations = Self::query(
                    gl,
                    po_id,
                    base.gl_ext_tokens.geometry_shader_invocations,
                    "GL_GEOMETRY_LINKED_INPUT_TYPE_EXT",
                )?;

                if current_run.input_primitive_type != linked_input_type as GLenum {
                    log::info!(
                        "GL_GEOMETRY_LINKED_INPUT_TYPE_EXT query value [{linked_input_type}] does not match the test run setting [{}]",
                        current_run.input_primitive_type
                    );
                    result = false;
                }
                if current_run.invocations != shader_invocations {
                    log::info!(
                        "GL_GEOMETRY_SHADER_INVOCATIONS_EXT query value [{shader_invocations}] does not match the test run setting [{}]",
                        current_run.input_primitive_type
                    );
                    result = false;
                }
                if current_run.max_vertices != linked_vertices_out {
                    log::info!(
                        "GL_GEOMETRY_LINKED_VERTICES_OUT query value [{linked_vertices_out}] does not match the test run setting [{}]",
                        current_run.max_vertices
                    );
                    result = false;
                }
                if current_run.output_primitive_type != linked_output_type as GLenum {
                    log::info!(
                        "GL_GEOMETRY_LINKED_OUTPUT_TYPE_EXT query value [{linked_output_type}] does not match the test run setting [{}]",
                        current_run.output_primitive_type
                    );
                    result = false;
                }
            }
        }

        // SAFETY: the name is written to a live field; the stages are the programs built above.
        unsafe { gl.gen_program_pipelines(1, &mut objects.pipeline_object_id) };
        glu::expect_no_error(gl, "glGenProgramPipelines() call failed.")?;
        // SAFETY: as above.
        unsafe {
            gl.use_program_stages(
                objects.pipeline_object_id,
                glw::GL_FRAGMENT_SHADER_BIT,
                objects.fs_po_id,
            );
            gl.use_program_stages(objects.pipeline_object_id, glw::GL_VERTEX_SHADER_BIT, objects.vs_po_id);
        }
        glu::expect_no_error(gl, "glUseProgramStages() call failed.")?;
        let mut gs_spo_id: GLint = 0;
        // SAFETY: the value is written to the live local.
        unsafe {
            gl.get_program_pipelineiv(
                objects.pipeline_object_id,
                base.gl_ext_tokens.geometry_shader,
                &mut gs_spo_id,
            )
        };
        glu::expect_no_error(gl, "glGetProgramPipelineiv() call failed.")?;
        if gs_spo_id != 0 {
            log::info!(
                "Pipeline object reported [{gs_spo_id}] for GL_GEOMETRY_SHADER_EXT query, even though no GS SPO was bound."
            );
            result = false;
        }
        verdict(result)
    }
}

impl TestCase for GetProgramiv3 {
    fn name(&self) -> &str {
        "getProgramiv3"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut objects = GetProgramiv3Objects::default();
        let outcome = self.run(context, &mut objects);
        Self::deinit(context, &mut objects);
        outcome
    }
}

/// `GeometryShaderDrawCallWithFSAndGS`
struct DrawCallWithFsAndGs {
    ext_params: ExtParameters,
}

impl DrawCallWithFsAndGs {
    /// Everything up to the clean-up that upstream's `end:` label runs; `ids` are the fragment shader program, geometry shader program, pipeline object and vertex array.
    fn run(&self, context: &Context, ids: &mut [GLuint; 4]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_po_id, gs_po_id, pipeline_object_id, vao_id] = ids;

        // SAFETY: the name is written to a live slot.
        unsafe { gl.gen_vertex_arrays(1, vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: binds the vertex array created above.
        unsafe { gl.bind_vertex_array(*vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

        let code_fs_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let code_gs_specialized = base.specialize_shader(&[MINIMAL_GS_CODE]);
        *fs_po_id = CreateShaderProgramv::create_shader_program(gl, glw::GL_FRAGMENT_SHADER, &code_fs_specialized);
        *gs_po_id = CreateShaderProgramv::create_shader_program(gl, glw::GL_GEOMETRY_SHADER, &code_gs_specialized);
        glu::expect_no_error(gl, "glCreateShaderProgramv() call(s) failed.")?;

        let mut link_status: GLint = glw::GL_FALSE as GLint;
        // SAFETY: the value is written to the live local.
        unsafe { gl.get_programiv(*fs_po_id, glw::GL_LINK_STATUS, &mut link_status) };
        if link_status != glw::GL_TRUE as GLint {
            log::info!("Minimal fragment shader program failed to link.");
            return verdict(false);
        }
        // SAFETY: as above.
        unsafe { gl.get_programiv(*gs_po_id, glw::GL_LINK_STATUS, &mut link_status) };
        if link_status != glw::GL_TRUE as GLint {
            log::info!("Minimal geometry shader program failed to link.");
            return verdict(false);
        }

        // SAFETY: the name is written to a live slot; the stages are the programs built above.
        unsafe { gl.gen_program_pipelines(1, pipeline_object_id) };
        glu::expect_no_error(gl, "glGenProgramPipelines() call failed.")?;
        // SAFETY: as above.
        unsafe {
            gl.use_program_stages(*pipeline_object_id, glw::GL_FRAGMENT_SHADER_BIT, *fs_po_id);
            gl.use_program_stages(*pipeline_object_id, glw::GL_GEOMETRY_SHADER_BIT, *gs_po_id);
        }
        glu::expect_no_error(gl, "glUseProgramStages() call(s) failed.")?;
        // SAFETY: binds the pipeline created above.
        unsafe { gl.bind_program_pipeline(*pipeline_object_id) };
        glu::expect_no_error(gl, "glBindProgramPipeline() call failed.")?;

        // SAFETY: a draw call that is expected to fail validation: the pipeline has no vertex stage.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        // SAFETY: plain state query.
        let error_code = unsafe { gl.get_error() };
        let mut result = true;
        if error_code != glw::GL_INVALID_OPERATION {
            log::info!(
                "Invalid draw call generated an error code [{error_code}] which is different from the expected GL_INVALID_OPERATION."
            );
            result = false;
        }
        verdict(result)
    }
}

impl TestCase for DrawCallWithFsAndGs {
    fn name(&self) -> &str {
        "fs_gs_draw_call"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 4];
        let outcome = self.run(context, &mut ids);
        let [fs_po_id, gs_po_id, pipeline_object_id, vao_id] = ids;
        // SAFETY: deletes only names this case created.
        unsafe {
            if pipeline_object_id != 0 {
                gl.delete_program_pipelines(1, &pipeline_object_id);
            }
            if gs_po_id != 0 {
                gl.delete_program(gs_po_id);
            }
            if fs_po_id != 0 {
                gl.delete_program(fs_po_id);
            }
            if vao_id != 0 {
                gl.delete_vertex_arrays(1, &vao_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderPiplineProgramObjectWithoutActiveVSProgramTest`
struct PipelineProgramWithoutActiveVs {
    ext_params: ExtParameters,
}

impl PipelineProgramWithoutActiveVs {
    /// `ids` are the fragment shader, fragment program, geometry shader, geometry program, pipeline object and vertex array of upstream's members.
    fn run(&self, context: &Context, ids: &mut [GLuint; 6]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, fs_po_id, gs_id, gs_po_id, ppo_id, vao_id] = ids;

        for po_id in [&mut *fs_po_id, &mut *gs_po_id] {
            // SAFETY: creates a program object and marks it separable.
            *po_id = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.program_parameteri(*po_id, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint) };
            glu::expect_no_error(gl, "glProgramParameteri() call failed.")?;
        }
        // SAFETY: creates shader objects.
        unsafe {
            *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            *gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_parts = [MINIMAL_FS_CODE];
        let gs_parts = [MINIMAL_GS_CODE];
        if !base
            .build_program(context, *fs_po_id, &[ShaderBody::Source(*fs_id, &fs_parts)])?
            .0
        {
            log::info!("Fragment Shader Program object linking failed.");
            return verdict(false);
        }
        if !base
            .build_program(context, *gs_po_id, &[ShaderBody::Source(*gs_id, &gs_parts)])?
            .0
        {
            log::info!("Geometry Shader Program object linking failed.");
            return verdict(false);
        }

        // SAFETY: the name is written to a live slot; the stages are the programs built above.
        unsafe { gl.gen_program_pipelines(1, ppo_id) };
        glu::expect_no_error(gl, "glGenProgramPipelines() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.use_program_stages(*ppo_id, glw::GL_FRAGMENT_SHADER_BIT, *fs_po_id) };
        glu::expect_no_error(gl, "glUseProgramStages() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.use_program_stages(*ppo_id, glw::GL_GEOMETRY_SHADER_BIT, *gs_po_id) };
        glu::expect_no_error(gl, "glUseProgramStages() call failed.")?;
        // SAFETY: the name is written to a live slot.
        unsafe { gl.gen_vertex_arrays(1, vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: binds the vertex array created above.
        unsafe { gl.bind_vertex_array(*vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;
        // SAFETY: binds the pipeline created above.
        unsafe { gl.bind_program_pipeline(*ppo_id) };
        glu::expect_no_error(gl, "glBindProgramPipeline() call failed.")?;

        // SAFETY: a draw call that is expected to fail validation: the pipeline has no vertex stage.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        let mut result = true;
        if error != glw::GL_INVALID_OPERATION {
            result = false;
            log::info!("Error different than GL_INVALID_OPEARATION was generated.");
        }
        verdict(result)
    }
}

impl TestCase for PipelineProgramWithoutActiveVs {
    fn name(&self) -> &str {
        "pipeline_program_without_active_vs"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 6];
        let outcome = self.run(context, &mut ids);
        let [fs_id, fs_po_id, gs_id, gs_po_id, ppo_id, vao_id] = ids;
        // SAFETY: deletes only names this case created.
        unsafe {
            if fs_id != 0 {
                gl.delete_shader(fs_id);
            }
            if fs_po_id != 0 {
                gl.delete_program(fs_po_id);
            }
            if gs_id != 0 {
                gl.delete_shader(gs_id);
            }
            if gs_po_id != 0 {
                gl.delete_program(gs_po_id);
            }
            if ppo_id != 0 {
                gl.delete_program_pipelines(1, &ppo_id);
            }
            if vao_id != 0 {
                gl.delete_vertex_arrays(1, &vao_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderIncompatibleDrawCallModeTest`
struct IncompatibleDrawCallMode {
    ext_params: ExtParameters,
}

/// The geometry shader input layout qualifier of each of the five programs; the shader body is shared.
const INCOMPATIBLE_DRAW_CALL_MODE_INPUT_LAYOUTS: [&str; 5] = [
    "points)                   ",
    "lines)                    ",
    "lines_adjacency)          ",
    "triangles)                ",
    "triangles_adjacency)      ",
];

/// What each program accepts: its index, then the (mode, count) draws that are incompatible with it, in upstream's order.
fn incompatible_draws(po: usize) -> Vec<(GLenum, glw::GLsizei)> {
    let mut draws = Vec::new();
    if po != 0 {
        draws.push((glw::GL_POINTS, 1));
    }
    if po != 1 {
        draws.extend([(glw::GL_LINES, 2), (glw::GL_LINE_LOOP, 2), (glw::GL_LINE_STRIP, 2)]);
    }
    if po != 2 {
        draws.extend([(glw::GL_LINES_ADJACENCY, 4), (glw::GL_LINE_STRIP_ADJACENCY, 4)]);
    }
    if po != 3 {
        draws.extend([
            (glw::GL_TRIANGLES, 3),
            (glw::GL_TRIANGLE_FAN, 3),
            (glw::GL_TRIANGLE_STRIP, 3),
        ]);
    }
    if po != 4 {
        draws.extend([(glw::GL_TRIANGLES_ADJACENCY, 6), (glw::GL_TRIANGLE_STRIP_ADJACENCY, 6)]);
    }
    draws
}

impl IncompatibleDrawCallMode {
    const NUMBER_OF_GS: usize = 5;

    fn gs_code(input_layout: &str) -> String {
        format!(
            "${{VERSION}}\n${{GEOMETRY_SHADER_REQUIRE}}\n\nlayout ({input_layout} in;\nlayout (points, max_vertices = 1) out;\n\n${{IN_PER_VERTEX_DECL_ARRAY}}\nvoid main()\n{{\n    gl_Position = gl_in[0].gl_Position;\n    EmitVertex();\n}}\n"
        )
    }

    /// `ids` holds the fragment shader, the vertex shader and the vertex array; `gs_ids` and `po_ids` the per-program names.
    fn run(
        &self,
        context: &Context,
        ids: &mut [GLuint; 3],
        gs_ids: &mut [GLuint; 5],
        po_ids: &mut [GLuint; 5],
    ) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, vs_id, vao_id] = ids;

        for i in 0..Self::NUMBER_OF_GS {
            // SAFETY: creates a shader object and a program object.
            gs_ids[i] = unsafe { gl.create_shader(glw::GL_GEOMETRY_SHADER) };
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
            // SAFETY: as above.
            po_ids[i] = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;
        }
        // SAFETY: creates shader objects.
        unsafe {
            *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            *vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_parts = [MINIMAL_FS_CODE];
        let vs_parts = [MINIMAL_VS_CODE];
        let mut result = true;
        for (i, input_layout) in INCOMPATIBLE_DRAW_CALL_MODE_INPUT_LAYOUTS.iter().enumerate() {
            let gs_code = Self::gs_code(input_layout);
            let gs_parts = [gs_code.as_str()];
            let built = base
                .build_program(
                    context,
                    po_ids[i],
                    &[
                        ShaderBody::Source(*fs_id, &fs_parts),
                        ShaderBody::Source(gs_ids[i], &gs_parts),
                        ShaderBody::Source(*vs_id, &vs_parts),
                    ],
                )?
                .0;
            if !built {
                log::info!("Program object linking failed for i = [{i}].");
                result = false;
                break;
            }
        }

        if result {
            // SAFETY: the name is written to a live slot.
            unsafe { gl.gen_vertex_arrays(1, vao_id) };
            glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
            // SAFETY: binds the vertex array created above.
            unsafe { gl.bind_vertex_array(*vao_id) };
            glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

            'programs: for (po, po_id) in po_ids.iter().enumerate() {
                // SAFETY: uses a program linked above.
                unsafe { gl.use_program(*po_id) };
                glu::expect_no_error(gl, "glUseProgram() call failed.")?;
                for (mode, count) in incompatible_draws(po) {
                    // SAFETY: a draw call that is expected to fail validation: the mode does not match the geometry shader input.
                    unsafe { gl.draw_arrays(mode, 0, count) };
                    // SAFETY: plain state query.
                    if unsafe { gl.get_error() } != glw::GL_INVALID_OPERATION {
                        result = false;
                        log::info!("Error different than GL_INVALID_OPEARATION was generated.");
                        break 'programs;
                    }
                }
            }
        }
        verdict(result)
    }
}

impl TestCase for IncompatibleDrawCallMode {
    fn name(&self) -> &str {
        "incompatible_draw_call_mode"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 3];
        let mut gs_ids = [0 as GLuint; 5];
        let mut po_ids = [0 as GLuint; 5];
        let outcome = self.run(context, &mut ids, &mut gs_ids, &mut po_ids);
        let [fs_id, vs_id, vao_id] = ids;
        // SAFETY: deletes only names this case created.
        unsafe {
            if fs_id != 0 {
                gl.delete_shader(fs_id);
            }
            for gs_id in gs_ids {
                if gs_id != 0 {
                    gl.delete_shader(gs_id);
                }
            }
            for po_id in po_ids {
                if po_id != 0 {
                    gl.delete_program(po_id);
                }
            }
            if vao_id != 0 {
                gl.delete_vertex_arrays(1, &vao_id);
            }
            if vs_id != 0 {
                gl.delete_shader(vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderInsufficientEmittedVerticesTest`
struct InsufficientEmittedVertices {
    ext_params: ExtParameters,
}

const INSUFFICIENT_EMITTED_VERTICES_FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(1.0, 0.0, 0.0, 0.0);\n}\n";
const GS_LINE_STRIP: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                       in;\nlayout (line_strip, max_vertices = 2) out;\n\n${IN_PER_VERTEX_DECL_ARRAY}\nvoid main()\n{\n    gl_Position    = gl_in[0].gl_Position;\n    gl_Position.zw = vec2(0.0, 1.0);\n    EmitVertex();\n}\n";
const GS_TRIANGLE_STRIP: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                           in;\nlayout (triangle_strip, max_vertices = 3) out;\n\n${IN_PER_VERTEX_DECL_ARRAY}\nvoid main()\n{\n    gl_Position    = gl_in[0].gl_Position;\n    gl_Position.zw = vec2(0.0, 1.0);\n    EmitVertex();\n    gl_Position    = gl_in[0].gl_Position;\n    gl_Position.zw = vec2(0.0, 1.0);\n    EmitVertex();\n}\n";

/// The objects `GeometryShaderInsufficientEmittedVerticesTest` creates and `deinit` releases.
#[derive(Default)]
struct InsufficientEmittedVerticesObjects {
    fbo_id: GLuint,
    fs_id: GLuint,
    gs_ids: [GLuint; 2],
    po_ids: [GLuint; 2],
    texture_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl InsufficientEmittedVertices {
    const NUMBER_OF_GS: usize = 2;
    const NUMBER_OF_COLOR_COMPONENTS: usize = 4;
    const TEXTURE_HEIGHT: usize = 16;
    const TEXTURE_WIDTH: usize = 16;

    fn run(&self, context: &Context, objects: &mut InsufficientEmittedVerticesObjects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        for i in 0..Self::NUMBER_OF_GS {
            // SAFETY: creates a shader object and a program object.
            objects.gs_ids[i] = unsafe { gl.create_shader(glw::GL_GEOMETRY_SHADER) };
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
            // SAFETY: as above.
            objects.po_ids[i] = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;
        }
        // SAFETY: creates shader objects.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_parts = [INSUFFICIENT_EMITTED_VERTICES_FS_CODE];
        let vs_parts = [MINIMAL_VS_CODE];
        let mut result = true;
        for (i, gs_code) in [GS_LINE_STRIP, GS_TRIANGLE_STRIP].iter().enumerate() {
            let gs_parts = [*gs_code];
            let built = base
                .build_program(
                    context,
                    objects.po_ids[i],
                    &[
                        ShaderBody::Source(objects.fs_id, &fs_parts),
                        ShaderBody::Source(objects.gs_ids[i], &gs_parts),
                        ShaderBody::Source(objects.vs_id, &vs_parts),
                    ],
                )?
                .0;
            if !built {
                log::info!("Program object linking failed for i = [{i}].");
                result = false;
                break;
            }
        }

        if result {
            let texture_width = Self::TEXTURE_WIDTH as glw::GLsizei;
            let texture_height = Self::TEXTURE_HEIGHT as glw::GLsizei;
            // SAFETY: the name is written to a live field.
            unsafe { gl.gen_textures(1, &mut objects.texture_id) };
            glu::expect_no_error(gl, "glGenTextures() call failed.")?;
            // SAFETY: binds and allocates the texture created above.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture_id) };
            glu::expect_no_error(gl, "glBindTexture() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, texture_width, texture_height) };
            glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;
            // SAFETY: the name is written to a live field.
            unsafe { gl.gen_framebuffers(1, &mut objects.fbo_id) };
            glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;
            // SAFETY: binds the framebuffer created above and attaches the texture.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo_id) };
            glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;
            // SAFETY: as above.
            unsafe {
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    objects.texture_id,
                    0,
                )
            };
            glu::expect_no_error(gl, "glFramebufferTexture2D() call failed.")?;
            // SAFETY: the name is written to a live field.
            unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
            glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
            // SAFETY: binds the vertex array created above.
            unsafe { gl.bind_vertex_array(objects.vao_id) };
            glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;
            // SAFETY: plain state change.
            unsafe { gl.clear_color(0.0, 1.0, 0.0, 0.0) };
            glu::expect_no_error(gl, "glClearColor() call failed.")?;

            let mut pixels = vec![0u8; Self::TEXTURE_HEIGHT * Self::TEXTURE_WIDTH * Self::NUMBER_OF_COLOR_COMPONENTS];
            for po in 0..Self::NUMBER_OF_GS {
                // SAFETY: uses a program linked above.
                unsafe { gl.use_program(objects.po_ids[po]) };
                glu::expect_no_error(gl, "glUseProgram() call failed.")?;
                // SAFETY: clears the framebuffer bound above.
                unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };
                glu::expect_no_error(gl, "glClear() call failed.")?;
                // SAFETY: draws one point with the program in use.
                unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
                glu::expect_no_error(gl, "glDrawArrays() call failed for GL_POINTS pname.")?;
                // SAFETY: the buffer holds the whole texture_width x texture_height RGBA8 region read.
                unsafe {
                    gl.read_pixels(
                        0,
                        0,
                        texture_width,
                        texture_height,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        pixels.as_mut_ptr().cast(),
                    )
                };
                glu::expect_no_error(gl, "glReadPixels() call failed.")?;
                // The `&&` of upstream's condition is kept: it only trips when every channel differs.
                for pixel in
                    (0..pixels.len() - Self::NUMBER_OF_COLOR_COMPONENTS).step_by(Self::NUMBER_OF_COLOR_COMPONENTS)
                {
                    if pixels[pixel] != 0
                        && pixels[pixel + 1] != 255
                        && pixels[pixel + 2] != 0
                        && pixels[pixel + 3] != 0
                    {
                        result = false;
                        log::info!(
                            "Pixel [{pixel}] has color = [{}, {}, {}, {}] instead of [0, 255, 0, 0].",
                            pixels[pixel],
                            pixels[pixel + 1],
                            pixels[pixel + 2],
                            pixels[pixel + 3]
                        );
                        break;
                    }
                }
            }
        }
        verdict(result)
    }
}

impl TestCase for InsufficientEmittedVertices {
    fn name(&self) -> &str {
        "insufficient_emitted_vertices"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = InsufficientEmittedVerticesObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: restores the clear colour and deletes only names this case created.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
            if objects.fbo_id != 0 {
                gl.delete_framebuffers(1, &objects.fbo_id);
            }
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
            }
            for gs_id in objects.gs_ids {
                if gs_id != 0 {
                    gl.delete_shader(gs_id);
                }
            }
            for po_id in objects.po_ids {
                if po_id != 0 {
                    gl.delete_program(po_id);
                }
            }
            if objects.texture_id != 0 {
                gl.delete_textures(1, &objects.texture_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderMaxImageUniformsTest`
struct MaxImageUniforms {
    ext_params: ExtParameters,
}

/// The objects `GeometryShaderMaxImageUniformsTest` creates and `deinit` releases.
#[derive(Default)]
struct MaxImageUniformsObjects {
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    texture_ids: Vec<GLuint>,
    tfbo_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl MaxImageUniforms {
    /// `GeometryShaderMaxImageUniformsTest::getGSCode`
    fn gs_code(base: &TestCaseBase, max_geometry_image_uniforms: GLint) -> String {
        let mut code = String::from(
            "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\nprecision highp iimage2D;\n\nivec4 counter = ivec4(0);\n\n",
        );
        for n_img in 0..max_geometry_image_uniforms {
            code.push_str(&format!(
                "layout(binding = {n_img}, r32i) uniform iimage2D img{n_img};\n"
            ));
        }
        code.push_str("\nvoid main()\n{\n");
        for n_img in 0..max_geometry_image_uniforms {
            code.push_str(&format!("    counter += imageLoad(img{n_img}, ivec2(0, 0));\n"));
        }
        code.push_str("\n    gl_Position = vec4(float(counter.x), 0.0, 0.0, 1.0);\n    EmitVertex();\n}\n");
        base.specialize_shader(&[&code])
    }

    fn get_integer(gl: &glw::Functions, pname: GLenum, message: &str) -> Result<GLint, TestError> {
        let mut value: GLint = 0;
        // SAFETY: the value is written to the live local.
        unsafe { gl.get_integerv(pname, &mut value) };
        glu::expect_no_error(gl, message)?;
        Ok(value)
    }

    fn run(&self, context: &Context, objects: &mut MaxImageUniformsObjects) -> TestOutcome {
        let gl = context.gl();
        // Bug-15063: only GLSL 4.50 supports opaque types.
        let ext_params = ExtParameters {
            glsl_version: glu::GlslVersion::Glsl450,
            ..self.ext_params
        };
        let base = TestCaseBase::init(context, ext_params);
        require_geometry_shader(&base)?;

        let max_geometry_image_uniforms = Self::get_integer(
            gl,
            base.gl_ext_tokens.max_geometry_image_uniforms,
            "glGetIntegerv() failed for GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT pname",
        )?;
        Self::get_integer(
            gl,
            base.gl_ext_tokens.max_geometry_texture_image_units,
            "glGetIntegerv() failed for GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT pname",
        )?;
        let max_image_units = Self::get_integer(
            gl,
            glw::GL_MAX_IMAGE_UNITS,
            "glGetIntegerv() failed for GL_MAX_IMAGE_UNITS pname",
        )?;

        if max_geometry_image_uniforms <= 0 {
            log::info!(
                "GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT query value [{max_geometry_image_uniforms}] is less than or equal zero. Image uniforms in Geometry Shader are not supported."
            );
            if max_geometry_image_uniforms == 0 {
                return Err(TestError::NotSupported(
                    "GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT is 0".to_string(),
                ));
            }
            return verdict(false);
        }
        if max_image_units < max_geometry_image_uniforms {
            log::info!(
                "GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT query value [{max_geometry_image_uniforms}] is greater than GL_MAX_IMAGE_UNITS query value [{max_image_units}]."
            );
            return verdict(false);
        }

        // SAFETY: creates a program object and shader objects.
        objects.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        // SAFETY: as above.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let gl_position = CString::new("gl_Position").expect("no NUL in a varying name");
        let feedback_varyings: [*const c_char; 1] = [gl_position.as_ptr()];
        // SAFETY: one NUL-terminated varying name that outlives the call.
        unsafe {
            gl.transform_feedback_varyings(
                objects.po_id,
                1,
                feedback_varyings.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS,
            )
        };
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let gs_code_specialized = Self::gs_code(&base, max_geometry_image_uniforms);
        let vs_code_specialized = base.specialize_shader(&[MINIMAL_VS_CODE]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        // The program is built from already specialized code, which `build_program` specializes once more; the text has no markers left.
        if !base
            .build_program(
                context,
                objects.po_id,
                &[
                    ShaderBody::Source(objects.gs_id, &gs_parts),
                    ShaderBody::Source(objects.vs_id, &vs_parts),
                    ShaderBody::Source(objects.fs_id, &fs_parts),
                ],
            )?
            .0
        {
            log::info!("Program object linking failed.");
            return verdict(false);
        }
        // SAFETY: uses the program linked above.
        unsafe { gl.use_program(objects.po_id) };
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;

        objects.texture_ids = vec![0; max_geometry_image_uniforms as usize];
        // SAFETY: the vector holds `max_geometry_image_uniforms` names.
        unsafe { gl.gen_textures(max_geometry_image_uniforms, objects.texture_ids.as_mut_ptr()) };
        glu::expect_no_error(gl, "glGenTextures() call failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1) };
        glu::expect_no_error(gl, "glPixelStorei() call failed for GL_PACK_ALIGNMENT pname.")?;

        for n_img in 0..max_geometry_image_uniforms {
            let texture = objects.texture_ids[n_img as usize];
            let value: GLint = n_img + 1;
            // SAFETY: binds and fills the texture created above; `value` covers the 1x1 R32I texel.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
            glu::expect_no_error(gl, "glBindTexture() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32I, 1, 1) };
            glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;
            // SAFETY: as above.
            unsafe {
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RED_INTEGER,
                    glw::GL_INT,
                    std::ptr::from_ref(&value).cast(),
                )
            };
            glu::expect_no_error(gl, "glTexSubImage2D() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint) };
            glu::expect_no_error(gl, "texParameteri() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint) };
            glu::expect_no_error(gl, "texParameteri() call failed.")?;
            // SAFETY: binds the texture as an image unit.
            unsafe {
                gl.bind_image_texture(
                    n_img as GLuint,
                    texture,
                    0,
                    glw::FALSE,
                    0,
                    glw::GL_READ_ONLY,
                    glw::GL_R32I,
                )
            };
            glu::expect_no_error(gl, "glBindImageTexture() call failed.")?;
        }

        // SAFETY: the names are written to live fields; the other calls use the objects just created.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.gen_buffers(1, &mut objects.tfbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        const FEEDBACK_BYTES: glw::GLsizeiptr = (std::mem::size_of::<glw::GLfloat>() * 4) as glw::GLsizeiptr;
        // SAFETY: allocates without data.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                FEEDBACK_BYTES,
                std::ptr::null(),
                glw::GL_STATIC_READ,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call failed.")?;
        // SAFETY: binds the buffer for transform feedback.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBufferBase() call failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.enable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glEnable() call failed for GL_RASTERIZER_DISCARD pname.")?;
        // SAFETY: a transform feedback pass around one point.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        glu::expect_no_error(gl, "glDrawArrays() call failed for GL_POINTS pname.")?;
        // SAFETY: as above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.disable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glDisable() call failed for GL_RASTERIZER_DISCARD pname.")?;

        // SAFETY: maps the four floats the pass above wrote.
        let ptr = unsafe { gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, FEEDBACK_BYTES, glw::GL_MAP_READ_BIT) }
            .cast::<glw::GLfloat>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if ptr.is_null() {
            return Err(TestError::Fail("glMapBufferRange() call failed.".to_string()));
        }
        // SAFETY: the mapping holds four floats until it is unmapped below.
        let counter = unsafe { (*ptr + 0.5) as GLint };
        // SAFETY: unmaps the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_ARRAY_BUFFER) };
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

        let expected_value = max_geometry_image_uniforms * (max_geometry_image_uniforms + 1) / 2;
        verdict(counter == expected_value)
    }
}

impl TestCase for MaxImageUniforms {
    fn name(&self) -> &str {
        "max_image_uniforms"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = MaxImageUniformsObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: deletes only names this case created.
        unsafe {
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
            }
            if objects.gs_id != 0 {
                gl.delete_shader(objects.gs_id);
            }
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
            }
            if !objects.texture_ids.is_empty() {
                gl.delete_textures(objects.texture_ids.len() as glw::GLsizei, objects.texture_ids.as_ptr());
            }
            if objects.tfbo_id != 0 {
                gl.delete_buffers(1, &objects.tfbo_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
        }
        let reset = glu::expect_no_error(gl, "glPixelStorei() call failed for GL_PACK_ALIGNMENT pname.");
        let status = outcome?;
        reset?;
        Ok(status)
    }
}

/// `GeometryShaderMaxShaderStorageBlocksTest`
struct MaxShaderStorageBlocks {
    ext_params: ExtParameters,
}

/// The objects `GeometryShaderMaxShaderStorageBlocksTest` creates and `deinit` releases.
#[derive(Default)]
struct MaxShaderStorageBlocksObjects {
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    ssbo_id: GLuint,
    tfbo_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl MaxShaderStorageBlocks {
    /// `GeometryShaderMaxShaderStorageBlocksTest::getGSCode`
    fn gs_code(base: &TestCaseBase, max_geometry_shader_storage_blocks: GLint) -> String {
        let mut code = String::from(
            "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\nint counter = 0;\n\n",
        );
        for n_ssb in 0..max_geometry_shader_storage_blocks {
            code.push_str(&format!(
                "layout(binding = {n_ssb}) buffer ssb{n_ssb} \n{{\n    int value;\n}} S_SSB{n_ssb};\n\n"
            ));
        }
        code.push_str("\nvoid main()\n{\n");
        for n_ssb in 0..max_geometry_shader_storage_blocks {
            code.push_str(&format!("    counter += S_SSB{n_ssb}.value++;\n"));
        }
        code.push_str("\n    gl_Position = vec4(float(counter), 0.0, 0.0, 1.0);\n    EmitVertex();\n}\n");
        base.specialize_shader(&[&code])
    }

    fn run(&self, context: &Context, objects: &mut MaxShaderStorageBlocksObjects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        let max_blocks = MaxImageUniforms::get_integer(
            gl,
            base.gl_ext_tokens.max_geometry_shader_storage_blocks,
            "glGetIntegerv() failed for GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_EXT pname",
        )?;
        let max_bindings = MaxImageUniforms::get_integer(
            gl,
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            "glGetIntegerv() failed for GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS pname",
        )?;
        if max_blocks <= 0 {
            log::info!(
                "GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_EXT query value [{max_blocks}] is less than or equal zero. Shader Storage Blocks in Geometry Shader are not supported."
            );
            if max_blocks == 0 {
                return Err(TestError::NotSupported(
                    "GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_EXT is 0".to_string(),
                ));
            }
            return verdict(false);
        }
        if max_bindings < max_blocks {
            log::info!(
                "GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_EXT query value [{max_blocks}] is greater than GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS query value [{max_bindings}]."
            );
            return verdict(false);
        }

        // SAFETY: creates a program object and shader objects.
        objects.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        // SAFETY: as above.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let gl_position = CString::new("gl_Position").expect("no NUL in a varying name");
        let feedback_varyings: [*const c_char; 1] = [gl_position.as_ptr()];
        // SAFETY: one NUL-terminated varying name that outlives the call.
        unsafe {
            gl.transform_feedback_varyings(
                objects.po_id,
                1,
                feedback_varyings.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS,
            )
        };
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let gs_code_specialized = Self::gs_code(&base, max_blocks);
        let vs_code_specialized = base.specialize_shader(&[MINIMAL_VS_CODE]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        if !base
            .build_program(
                context,
                objects.po_id,
                &[
                    ShaderBody::Source(objects.gs_id, &gs_parts),
                    ShaderBody::Source(objects.vs_id, &vs_parts),
                    ShaderBody::Source(objects.fs_id, &fs_parts),
                ],
            )?
            .0
        {
            log::info!("Program object linking failed.");
            return verdict(false);
        }

        let ssbo_alignment = MaxImageUniforms::get_integer(
            gl,
            glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT,
            "glGetIntegerv() call failed.",
        )?;
        const INT_SIZE: GLint = std::mem::size_of::<GLint>() as GLint;
        let int_alignment = ssbo_alignment / INT_SIZE;
        let ssbo_data_size = max_blocks * ssbo_alignment;
        let mut ssbo_data = vec![0 as GLint; ssbo_data_size as usize];
        if ssbo_alignment % INT_SIZE != 0 {
            log::info!(
                "GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT query value [{ssbo_alignment}]divide with remainder by the size of GLint [{INT_SIZE}]"
            );
            return verdict(false);
        }
        for i in 0..max_blocks {
            ssbo_data[(i * int_alignment) as usize] = i + 1;
        }
        // SAFETY: the name is written to a live field; the data covers `ssbo_data_size` bytes.
        unsafe { gl.gen_buffers(1, &mut objects.ssbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, objects.ssbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call failed for GL_SHADER_STORAGE_BUFFER pname.")?;
        // SAFETY: as above.
        unsafe {
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                ssbo_data_size as glw::GLsizeiptr,
                ssbo_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call failed.")?;

        for n_ssb in 0..max_blocks {
            let offset = (n_ssb * ssbo_alignment) as glw::GLintptr;
            // SAFETY: binds a range inside the buffer allocated above.
            unsafe {
                gl.bind_buffer_range(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    n_ssb as GLuint,
                    objects.ssbo_id,
                    offset,
                    INT_SIZE as glw::GLsizeiptr,
                )
            };
            glu::expect_no_error(gl, "bindBufferRange() call failed.")?;
        }

        // SAFETY: the names are written to live fields; the other calls use the objects just created.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.gen_buffers(1, &mut objects.tfbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        const FEEDBACK_BYTES: glw::GLsizeiptr = (std::mem::size_of::<glw::GLfloat>() * 4) as glw::GLsizeiptr;
        let initial_buffer_data = [0.0f32; 4];
        // SAFETY: the data covers the four floats passed.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                FEEDBACK_BYTES,
                initial_buffer_data.as_ptr().cast(),
                glw::GL_STATIC_READ,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call failed.")?;
        // SAFETY: binds the buffer for transform feedback.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBufferBase() call failed.")?;
        // SAFETY: uses the program linked above.
        unsafe { gl.use_program(objects.po_id) };
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.enable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glEnable() call failed for GL_RASTERIZER_DISCARD pname.")?;
        // SAFETY: a transform feedback pass around one point.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        glu::expect_no_error(gl, "glDrawArrays() call failed for GL_POINTS pname.")?;
        // SAFETY: as above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.disable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glDisable() call failed for GL_RASTERIZER_DISCARD pname.")?;

        // SAFETY: maps the four floats the pass above wrote.
        let ptr_tf_data = unsafe { gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, FEEDBACK_BYTES, glw::GL_MAP_READ_BIT) }
            .cast::<glw::GLfloat>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if ptr_tf_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange() call failed.".to_string()));
        }
        // SAFETY: the mapping holds four floats until it is unmapped below.
        let counter = unsafe { (*ptr_tf_data + 0.5) as GLint };
        // SAFETY: unmaps the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_ARRAY_BUFFER) };
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

        let mut result = true;
        // SAFETY: maps `ssbo_data_size` bytes of the shader storage buffer.
        let ptr_ssbo_data = unsafe {
            gl.map_buffer_range(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                ssbo_data_size as glw::GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        }
        .cast::<GLint>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if ptr_ssbo_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange() call failed.".to_string()));
        }
        for i in 0..max_blocks {
            // SAFETY: the index lies inside the `ssbo_data_size / 4` ints mapped.
            let value = unsafe { *ptr_ssbo_data.add((i * int_alignment) as usize) };
            if value != i + 2 {
                result = false;
                log::info!(
                    "Value read from Shader Storage Buffer [{value}] at index [{}]is not equal to expected value [{}]",
                    i * int_alignment,
                    i + 2
                );
                break;
            }
        }
        // SAFETY: unmaps the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER) };
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

        let expected_value = max_blocks * (max_blocks + 1) / 2;
        if counter != expected_value {
            result = false;
        }
        verdict(result)
    }
}

impl TestCase for MaxShaderStorageBlocks {
    fn name(&self) -> &str {
        "max_shader_storage_blocks"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = MaxShaderStorageBlocksObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: deletes only names this case created.
        unsafe {
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
            }
            if objects.gs_id != 0 {
                gl.delete_shader(objects.gs_id);
            }
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
            }
            if objects.ssbo_id != 0 {
                gl.delete_buffers(1, &objects.ssbo_id);
            }
            if objects.tfbo_id != 0 {
                gl.delete_buffers(1, &objects.tfbo_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderMaxAtomicCountersTest`
struct MaxAtomicCounters {
    ext_params: ExtParameters,
}

/// The objects `GeometryShaderMaxAtomicCountersTest` creates and `deinit` releases.
#[derive(Default)]
struct MaxAtomicCountersObjects {
    acbo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl MaxAtomicCounters {
    const VS_CODE: &'static str = "${VERSION}\n\nflat out int vertex_id;\n\nvoid main()\n{\n    vertex_id    = gl_VertexID;\n    gl_Position  = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

    /// `GeometryShaderMaxAtomicCountersTest::getGSCode`
    fn gs_code(base: &TestCaseBase, max_geometry_atomic_counters: GLint) -> String {
        let code = format!(
            "${{VERSION}}\n${{GEOMETRY_SHADER_REQUIRE}}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\nuniform int n_loop_iterations;\nflat in int vertex_id[];\n\nlayout(binding = 0) uniform atomic_uint acs[{max_geometry_atomic_counters}];\n\nvoid main()\n{{\n    for (int counter_id = 1;\n             counter_id <= n_loop_iterations;\n           ++counter_id)\n    {{\n        if ((vertex_id[0] % counter_id) == 0)\n        {{\n            atomicCounterIncrement(acs[counter_id - 1]);\n        }}\n    }}\n\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n    EmitVertex();\n}}\n"
        );
        base.specialize_shader(&[&code])
    }

    fn run(&self, context: &Context, objects: &mut MaxAtomicCountersObjects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        const N_DRAW_CALL_VERTICES: u32 = 4;

        let max_counters = MaxImageUniforms::get_integer(
            gl,
            base.gl_ext_tokens.max_geometry_atomic_counters,
            "glGetIntegerv() failed for GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT pname",
        )?;
        if max_counters <= 0 {
            log::info!(
                "GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT query value [{max_counters}] is less than or equal to zero. Atomic Counters in Geometry Shader are not supported."
            );
            if max_counters == 0 {
                return Err(TestError::NotSupported(
                    "GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT is 0".to_string(),
                ));
            }
            return verdict(false);
        }

        // SAFETY: creates a program object and shader objects.
        objects.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        // SAFETY: as above.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let gs_code_specialized = Self::gs_code(&base, max_counters);
        let vs_code_specialized = base.specialize_shader(&[Self::VS_CODE]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        if !base
            .build_program(
                context,
                objects.po_id,
                &[
                    ShaderBody::Source(objects.gs_id, &gs_parts),
                    ShaderBody::Source(objects.vs_id, &vs_parts),
                    ShaderBody::Source(objects.fs_id, &fs_parts),
                ],
            )?
            .0
        {
            log::info!("Program object linking failed.");
            return verdict(false);
        }

        let acbo_bytes = (std::mem::size_of::<GLuint>() * max_counters as usize) as glw::GLsizeiptr;
        let initial_ac_data = vec![0 as GLuint; max_counters as usize];
        // SAFETY: the name is written to a live field; the data covers `acbo_bytes` bytes.
        unsafe { gl.gen_buffers(1, &mut objects.acbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, objects.acbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call failed for GL_SHADER_STORAGE_BUFFER pname.")?;
        // SAFETY: as above.
        unsafe {
            gl.buffer_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                acbo_bytes,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call failed.")?;
        // SAFETY: as above.
        unsafe {
            gl.buffer_sub_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                0,
                acbo_bytes,
                initial_ac_data.as_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glBufferSubData() call failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, objects.acbo_id) };
        glu::expect_no_error(gl, "bindBufferRange() call failed.")?;
        // SAFETY: the name is written to a live field.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: binds the vertex array created above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

        let uniform_name = CString::new("n_loop_iterations").expect("no NUL in a uniform name");
        // SAFETY: looks a uniform up in the program linked above.
        let n_loop_iterations_uniform_location =
            unsafe { gl.get_uniform_location(objects.po_id, uniform_name.as_ptr()) };
        glu::expect_no_error(gl, "glGetUniformLocation() call failed.")?;
        if n_loop_iterations_uniform_location == -1 {
            return Err(TestError::Fail(
                "n_loop_iterations uniform is considered inactive".to_string(),
            ));
        }
        // SAFETY: uses the program linked above.
        unsafe { gl.use_program(objects.po_id) };
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;
        // SAFETY: sets the uniform located above.
        unsafe { gl.uniform_1i(n_loop_iterations_uniform_location, max_counters) };
        glu::expect_no_error(gl, "glUniform1i() call failed.")?;

        // SAFETY: draws four points with the program in use.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, N_DRAW_CALL_VERTICES as glw::GLsizei) };
        glu::expect_no_error(gl, "glDrawArrays() call failed for GL_POINTS pname.")?;

        // SAFETY: maps the counters the draw call incremented.
        let ptr_acbo_data =
            unsafe { gl.map_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, acbo_bytes, glw::GL_MAP_READ_BIT) }
                .cast::<GLuint>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if ptr_acbo_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange() call failed.".to_string()));
        }
        let mut result = true;
        for n_ac in 0..max_counters {
            let expected_value = (0..N_DRAW_CALL_VERTICES)
                .filter(|n_draw_call_vertex| n_draw_call_vertex % (n_ac as u32 + 1) == 0)
                .count() as GLuint;
            // SAFETY: the index lies inside the `max_counters` counters mapped.
            let value = unsafe { *ptr_acbo_data.add(n_ac as usize) };
            if value != expected_value {
                result = false;
                break;
            }
        }
        // SAFETY: unmaps the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER) };
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;
        verdict(result)
    }
}

impl TestCase for MaxAtomicCounters {
    fn name(&self) -> &str {
        "max_atomic_counters"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = MaxAtomicCountersObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: deletes only names this case created.
        unsafe {
            if objects.acbo_id != 0 {
                gl.delete_buffers(1, &objects.acbo_id);
            }
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
            }
            if objects.gs_id != 0 {
                gl.delete_shader(objects.gs_id);
            }
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderMaxAtomicCounterBuffersTest`
struct MaxAtomicCounterBuffers {
    ext_params: ExtParameters,
}

/// The objects `GeometryShaderMaxAtomicCounterBuffersTest` creates and `deinit` releases.
#[derive(Default)]
struct MaxAtomicCounterBuffersObjects {
    acbo_ids: Vec<GLuint>,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl MaxAtomicCounterBuffers {
    /// `GeometryShaderMaxAtomicCounterBuffersTest::getGSCode`
    fn gs_code(base: &TestCaseBase, max_geometry_atomic_counter_buffers: GLint) -> String {
        let mut code = String::from(
            "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\nflat in int vertex_id[];\n\n",
        );
        for n_ac in 0..max_geometry_atomic_counter_buffers {
            code.push_str(&format!("layout(binding = {n_ac}) uniform atomic_uint ac{n_ac};\n"));
        }
        code.push_str(&format!("\nvoid main()\n{{\n    for(int counter_id = 1; counter_id <= {max_geometry_atomic_counter_buffers}; ++counter_id)\n    {{\n        if((vertex_id[0] % counter_id) == 0)\n        {{\n"));
        for n_ac in 0..max_geometry_atomic_counter_buffers {
            code.push_str(&format!("            atomicCounterIncrement(ac{n_ac});\n"));
        }
        code.push_str("        }\n    }\n\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n    EmitVertex();\n}\n");
        base.specialize_shader(&[&code])
    }

    fn run(&self, context: &Context, objects: &mut MaxAtomicCounterBuffersObjects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        let max_buffers = MaxImageUniforms::get_integer(
            gl,
            base.gl_ext_tokens.max_geometry_atomic_counter_buffers,
            "glGetIntegerv() failed for GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT pname",
        )?;
        let max_bindings = MaxImageUniforms::get_integer(
            gl,
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
            "glGetIntegerv() failed for GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS pname",
        )?;
        if max_buffers <= 0 {
            log::info!(
                "GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT query value [{max_buffers}] is less than or equal to zero. Atomic Counter Buffers are not supported."
            );
            if max_buffers == 0 {
                return Err(TestError::NotSupported(
                    "GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT is 0".to_string(),
                ));
            }
            return verdict(false);
        }
        if max_bindings < max_buffers {
            log::info!(
                "GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT query value [{max_buffers}] is greater than GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS query value [{max_bindings}]."
            );
            return verdict(false);
        }
        let number_of_indices = 128 * max_buffers as GLuint;

        // SAFETY: creates a program object and shader objects.
        objects.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        // SAFETY: as above.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let gs_code_specialized = Self::gs_code(&base, max_buffers);
        let vs_code_specialized = base.specialize_shader(&[MaxAtomicCounters::VS_CODE]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        if !base
            .build_program(
                context,
                objects.po_id,
                &[
                    ShaderBody::Source(objects.gs_id, &gs_parts),
                    ShaderBody::Source(objects.vs_id, &vs_parts),
                    ShaderBody::Source(objects.fs_id, &fs_parts),
                ],
            )?
            .0
        {
            log::info!("Program object linking failed.");
            return verdict(false);
        }

        objects.acbo_ids = vec![0; max_buffers as usize];
        // SAFETY: the vector holds `max_buffers` names.
        unsafe { gl.gen_buffers(max_buffers, objects.acbo_ids.as_mut_ptr()) };
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        let initial_ac_data: GLuint = 0;
        for n_acb in 0..max_buffers {
            let acbo_id = objects.acbo_ids[n_acb as usize];
            // SAFETY: binds and fills a buffer created above; the data is one `GLuint`.
            unsafe { gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, acbo_id) };
            glu::expect_no_error(gl, "glBindBuffer() call failed for GL_SHADER_STORAGE_BUFFER pname.")?;
            // SAFETY: as above.
            unsafe {
                gl.buffer_data(
                    glw::GL_ATOMIC_COUNTER_BUFFER,
                    std::mem::size_of::<GLuint>() as glw::GLsizeiptr,
                    std::ptr::from_ref(&initial_ac_data).cast(),
                    glw::GL_DYNAMIC_COPY,
                )
            };
            glu::expect_no_error(gl, "glBufferData() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, n_acb as GLuint, acbo_id) };
            glu::expect_no_error(gl, "bindBufferRange() call failed.")?;
        }
        // SAFETY: the name is written to a live field.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        // SAFETY: binds the vertex array created above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;
        // SAFETY: uses the program linked above.
        unsafe { gl.use_program(objects.po_id) };
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;
        // SAFETY: draws with the program in use.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, number_of_indices as glw::GLsizei) };
        glu::expect_no_error(gl, "glDrawArrays() call failed for GL_POINTS pname.")?;

        let mut expected_value: GLuint = 0;
        for vertex_id in 0..number_of_indices {
            for atomic_counter_id in 1..=max_buffers as GLuint {
                if vertex_id % atomic_counter_id == 0 {
                    expected_value += 1;
                }
            }
        }

        let mut result = true;
        for n_acb in 0..max_buffers {
            // SAFETY: binds a buffer created above.
            unsafe { gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, objects.acbo_ids[n_acb as usize]) };
            glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
            // SAFETY: maps the one counter of the buffer.
            let ptr_abo_data = unsafe {
                gl.map_buffer_range(
                    glw::GL_ATOMIC_COUNTER_BUFFER,
                    0,
                    std::mem::size_of::<GLuint>() as glw::GLsizeiptr,
                    glw::GL_MAP_READ_BIT,
                )
            }
            .cast::<GLuint>();
            glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
            if ptr_abo_data.is_null() {
                return Err(TestError::Fail("glMapBufferRange() call failed.".to_string()));
            }
            // SAFETY: the mapping holds one counter.
            if unsafe { *ptr_abo_data } != expected_value {
                result = false;
                break;
            }
            // SAFETY: unmaps the buffer mapped above.
            unsafe { gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER) };
            glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;
        }
        verdict(result)
    }
}

impl TestCase for MaxAtomicCounterBuffers {
    fn name(&self) -> &str {
        "max_atomic_counter_buffers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = MaxAtomicCounterBuffersObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: deletes only names this case created.
        unsafe {
            if !objects.acbo_ids.is_empty() {
                gl.delete_buffers(objects.acbo_ids.len() as glw::GLsizei, objects.acbo_ids.as_ptr());
            }
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
            }
            if objects.gs_id != 0 {
                gl.delete_shader(objects.gs_id);
            }
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderPipelineObjectTransformFeedbackVertexAndGeometryShaderCaptureTest`
struct PipelineVsGsCapture {
    ext_params: ExtParameters,
}

const PIPELINE_VS_GS_CAPTURE_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n${IN_PER_VERTEX_DECL_ARRAY}\n${OUT_PER_VERTEX_DECL}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\nflat in int   vertexID[];\nflat in ivec4 out_vs_1[];\n\nout vec4 out_gs_1;\n\nvoid main()\n{\n    out_gs_1 = vec4(vertexID[0] * 2, vertexID[0] * 2 + 1, vertexID[0] * 2 + 2, vertexID[0] * 2 + 3);\n    gl_Position = vec4(0, 0, 0, 1);\n    EmitVertex();\n}\n";
const PIPELINE_VS_GS_CAPTURE_VS_CODE: &str = "${VERSION}\n${OUT_PER_VERTEX_DECL}\n\nflat out ivec4 out_vs_1;\nflat out int vertexID;\n\nvoid main()\n{\n    vertexID = gl_VertexID;\n    out_vs_1 = ivec4(gl_VertexID, gl_VertexID + 1, gl_VertexID + 2, gl_VertexID + 3);\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

/// The objects `GeometryShaderPipelineObjectTransformFeedbackVertexAndGeometryShaderCaptureTest` creates and `deinit` releases.
#[derive(Default)]
struct PipelineVsGsCaptureObjects {
    gs_id: GLuint,
    gs_po_id: GLuint,
    ppo_id: GLuint,
    tfbo_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
    vs_po_id: GLuint,
}

impl PipelineVsGsCapture {
    fn run(&self, context: &Context, objects: &mut PipelineVsGsCaptureObjects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let expected_geom_results: [f32; 4] = [0.0, 1.0, 2.0, 3.0];
        let expected_vertex_results: [GLuint; 4] = [0, 1, 2, 3];
        const EPSILON: f32 = 1e-5;
        const FEEDBACK_BYTES: glw::GLsizeiptr = (std::mem::size_of::<f32>() * 4) as glw::GLsizeiptr;

        for po_id in [&mut objects.gs_po_id, &mut objects.vs_po_id] {
            // SAFETY: creates a program object and marks it separable.
            *po_id = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
            // SAFETY: as above.
            unsafe { gl.program_parameteri(*po_id, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint) };
            glu::expect_no_error(gl, "glProgramParameteri() call failed.")?;
        }
        // SAFETY: creates shader objects.
        unsafe {
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let gs_code_specialized = base.specialize_shader(&[PIPELINE_VS_GS_CAPTURE_GS_CODE]);
        let vs_code_specialized = base.specialize_shader(&[PIPELINE_VS_GS_CAPTURE_VS_CODE]);
        let tf_varyings = [
            CString::new("out_gs_1").expect("no NUL"),
            CString::new("out_vs_1").expect("no NUL"),
        ];
        for (po_id, varying) in [(objects.gs_po_id, &tf_varyings[0]), (objects.vs_po_id, &tf_varyings[1])] {
            let pointer: *const c_char = varying.as_ptr();
            // SAFETY: one NUL-terminated varying name that outlives the call.
            unsafe { gl.transform_feedback_varyings(po_id, 1, &pointer, glw::GL_INTERLEAVED_ATTRIBS) };
            glu::expect_no_error(gl, "glTransformFeedbackVaryings() call(s) failed.")?;
        }

        let (gs_parts, vs_parts) = ([gs_code_specialized.as_str()], [vs_code_specialized.as_str()]);
        if !base
            .build_program(
                context,
                objects.gs_po_id,
                &[ShaderBody::Source(objects.gs_id, &gs_parts)],
            )?
            .0
        {
            log::info!("Geometry Shader Program object linking failed.");
            return verdict(false);
        }
        if !base
            .build_program(
                context,
                objects.vs_po_id,
                &[ShaderBody::Source(objects.vs_id, &vs_parts)],
            )?
            .0
        {
            log::info!("Geometry Shader Program object linking failed.");
            return verdict(false);
        }

        // SAFETY: the name is written to a live field; the stages are the programs built above.
        unsafe { gl.gen_program_pipelines(1, &mut objects.ppo_id) };
        glu::expect_no_error(gl, "glGenProgramPipelines() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.use_program_stages(objects.ppo_id, glw::GL_GEOMETRY_SHADER_BIT, objects.gs_po_id) };
        glu::expect_no_error(gl, "glUseProgramStages() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.use_program_stages(objects.ppo_id, glw::GL_VERTEX_SHADER_BIT, objects.vs_po_id) };
        glu::expect_no_error(gl, "glUseProgramStages() call(s) failed.")?;
        // SAFETY: the name is written to a live field.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call(s) failed.")?;
        // SAFETY: binds the vertex array created above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call(s) failed.")?;
        // SAFETY: the name is written to a live field.
        unsafe { gl.gen_buffers(1, &mut objects.tfbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call(s) failed.")?;
        // SAFETY: binds and allocates the buffer created above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call(s) failed.")?;
        // SAFETY: allocates without data.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                FEEDBACK_BYTES,
                std::ptr::null(),
                glw::GL_STREAM_READ,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call(s) failed.")?;
        // SAFETY: binds the buffer for transform feedback.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBufferBase() call(s) failed.")?;
        // SAFETY: unbinds the program so the pipeline is used.
        unsafe { gl.use_program(0) };
        glu::expect_no_error(gl, "glUseProgram() call(s) failed.")?;
        // SAFETY: binds the pipeline created above.
        unsafe { gl.bind_program_pipeline(objects.ppo_id) };
        glu::expect_no_error(gl, "glBindProgramPipeline() call(s) failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.enable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glEnable() call(s) failed.")?;
        // SAFETY: a transform feedback pass around one point.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        glu::expect_no_error(gl, "glBeginTransformFeedback() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        glu::expect_no_error(gl, "glDrawArrays() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "glEndTransformFeedback() call(s) failed.")?;

        // SAFETY: maps the four floats captured above.
        let ptr_tf_data_f = unsafe {
            gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                FEEDBACK_BYTES,
                glw::GL_MAP_READ_BIT,
            )
        }
        .cast::<f32>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if ptr_tf_data_f.is_null() {
            return Err(TestError::Fail("glMapBufferRange() call failed.".to_string()));
        }
        let mut result = true;
        for (i, expected) in expected_geom_results.iter().enumerate() {
            // SAFETY: the mapping holds four floats.
            if (unsafe { *ptr_tf_data_f.add(i) } - expected).abs() >= EPSILON {
                result = false;
                break;
            }
        }
        // SAFETY: unmaps the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER) };
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;
        if !result {
            return verdict(false);
        }

        // SAFETY: detaches the geometry stage from the pipeline.
        unsafe { gl.use_program_stages(objects.ppo_id, glw::GL_GEOMETRY_SHADER_BIT, 0) };
        glu::expect_no_error(gl, "glUseProgramStages() call(s) failed.")?;
        // SAFETY: a second transform feedback pass, now capturing the vertex stage output.
        unsafe { gl.begin_transform_feedback(glw::GL_POINTS) };
        glu::expect_no_error(gl, "glBeginTransformFeedback() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        glu::expect_no_error(gl, "glDrawArrays() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "glEndTransformFeedback() call(s) failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.disable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glDisable() call(s) failed.")?;

        // SAFETY: maps the four integers captured above.
        let ptr_tf_data_ui = unsafe {
            gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                (std::mem::size_of::<GLuint>() * 4) as glw::GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        }
        .cast::<GLuint>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if ptr_tf_data_ui.is_null() {
            return Err(TestError::Fail("glMapBufferRange() call failed.".to_string()));
        }
        for (i, expected) in expected_vertex_results.iter().enumerate() {
            // SAFETY: the mapping holds four integers.
            if unsafe { *ptr_tf_data_ui.add(i) } != *expected {
                result = false;
                break;
            }
        }
        // SAFETY: unmaps the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER) };
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;
        verdict(result)
    }
}

impl TestCase for PipelineVsGsCapture {
    fn name(&self) -> &str {
        "program_pipeline_vs_gs_capture"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = PipelineVsGsCaptureObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: deletes only names this case created.
        unsafe {
            if objects.gs_id != 0 {
                gl.delete_shader(objects.gs_id);
            }
            if objects.gs_po_id != 0 {
                gl.delete_program(objects.gs_po_id);
            }
            if objects.ppo_id != 0 {
                gl.delete_program_pipelines(1, &objects.ppo_id);
            }
            if objects.tfbo_id != 0 {
                gl.delete_buffers(1, &objects.tfbo_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
            if objects.vs_po_id != 0 {
                gl.delete_program(objects.vs_po_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderDrawPrimitivesDoNotMatchOutputPrimitives`
struct DrawPrimitivesDoNotMatchOutputPrimitives {
    ext_params: ExtParameters,
}

const DRAW_PRIMITIVES_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (lines)                            in;\nlayout (triangle_strip, max_vertices = 3) out;\n\nout vec4 out_gs_1;\n\nvoid main()\n{\n    out_gs_1 = vec4(4.0, 3.0, 2.0, 1.0);\n\n    gl_Position = vec4(0, 0, 0, 1);\n    EmitVertex();\n\n    gl_Position = vec4(1, 0, 0, 1);\n    EmitVertex();\n\n    gl_Position = vec4(1, 1, 0, 1);\n    EmitVertex();\n\n    EndPrimitive();}\n";

/// The objects `GeometryShaderDrawPrimitivesDoNotMatchOutputPrimitives` creates and `deinit` releases.
#[derive(Default)]
struct DrawPrimitivesObjects {
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    tfbo_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl DrawPrimitivesDoNotMatchOutputPrimitives {
    fn run(&self, context: &Context, objects: &mut DrawPrimitivesObjects) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        // SAFETY: creates a program object.
        objects.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        let out_gs_1 = CString::new("out_gs_1").expect("no NUL in a varying name");
        let tf_varyings: [*const c_char; 1] = [out_gs_1.as_ptr()];
        // SAFETY: one NUL-terminated varying name that outlives the call.
        unsafe { gl.transform_feedback_varyings(objects.po_id, 1, tf_varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS) };
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call(s) failed.")?;
        // SAFETY: creates shader objects.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let gs_code_specialized = base.specialize_shader(&[DRAW_PRIMITIVES_GS_CODE]);
        let vs_code_specialized = base.specialize_shader(&[MINIMAL_VS_CODE]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        if !base
            .build_program(
                context,
                objects.po_id,
                &[
                    ShaderBody::Source(objects.fs_id, &fs_parts),
                    ShaderBody::Source(objects.gs_id, &gs_parts),
                    ShaderBody::Source(objects.vs_id, &vs_parts),
                ],
            )?
            .0
        {
            log::info!("Program object linking failed whereas a success was expected.");
            return verdict(false);
        }

        // SAFETY: the names are written to live fields; the other calls use the objects just created.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.gen_buffers(1, &mut objects.tfbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call(s) failed.")?;
        // SAFETY: allocates room for four floats times three triangle vertices.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (std::mem::size_of::<f32>() * 4 * 3) as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_STREAM_READ,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call(s) failed.")?;
        // SAFETY: binds the buffer for transform feedback.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBufferBase() call(s) failed.")?;
        // SAFETY: uses the program linked above.
        unsafe { gl.use_program(objects.po_id) };
        glu::expect_no_error(gl, "glUseProgram() call(s) failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.enable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glEnable() call(s) failed.")?;
        // SAFETY: a transform feedback pass in a mode that does not match the draw call below.
        unsafe { gl.begin_transform_feedback(glw::GL_LINES) };
        glu::expect_no_error(gl, "glBeginTransformFeedback() call(s) failed.")?;
        // SAFETY: a draw call that is expected to fail validation.
        unsafe { gl.draw_arrays(glw::GL_TRIANGLES, 0, 3) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        let mut result = true;
        if error != glw::GL_INVALID_OPERATION {
            result = false;
            log::info!("Error different than GL_INVALID_OPEARATION was generated.");
        }
        // SAFETY: ends the pass begun above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "glEndTransformFeedback() call(s) failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.disable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glDisable() call(s) failed.")?;
        verdict(result)
    }
}

impl TestCase for DrawPrimitivesDoNotMatchOutputPrimitives {
    fn name(&self) -> &str {
        "draw_primitives_do_not_match_output_primitives"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = DrawPrimitivesObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: deletes only names this case created.
        unsafe {
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
            }
            if objects.gs_id != 0 {
                gl.delete_shader(objects.gs_id);
            }
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
            }
            if objects.tfbo_id != 0 {
                gl.delete_buffers(1, &objects.tfbo_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderDrawCallsWhileTFPaused`
struct DrawCallsWhileTfPaused {
    ext_params: ExtParameters,
}

/// The objects `GeometryShaderDrawCallsWhileTFPaused` creates and `deinit` releases.
#[derive(Default)]
struct DrawCallsWhileTfPausedObjects {
    fs_id: GLuint,
    gs_id: GLuint,
    po_ids: [GLuint; 15],
    tfbo_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl DrawCallsWhileTfPaused {
    fn run(&self, context: &Context, objects: &mut DrawCallsWhileTfPausedObjects) -> TestOutcome {
        const GS_INPUTS: [&str; 5] = ["points", "lines", "lines_adjacency", "triangles", "triangles_adjacency"];
        const GS_OUTPUTS: [&str; 3] = ["points", "line_strip", "triangle_strip"];
        const GS_MAX_OUTPUT_VERTICES: [&str; 3] = ["1", "2", "3"];
        const NUMBER_OF_COMBINATIONS: usize = GS_INPUTS.len() * GS_OUTPUTS.len();
        const TF_MODES: [GLenum; 3] = [glw::GL_POINTS, glw::GL_LINES, glw::GL_TRIANGLES];
        const DRAW_CALL_MODES: [GLenum; 5] = [
            glw::GL_POINTS,
            glw::GL_LINES,
            glw::GL_LINES_ADJACENCY,
            glw::GL_TRIANGLES,
            glw::GL_TRIANGLES_ADJACENCY,
        ];

        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;

        let mut gs_codes: Vec<String> = Vec::with_capacity(NUMBER_OF_COMBINATIONS);
        for gs_input in GS_INPUTS {
            for (gs_output, max_vertices) in GS_OUTPUTS.iter().zip(GS_MAX_OUTPUT_VERTICES) {
                gs_codes.push(format!("${{VERSION}}\n${{GEOMETRY_SHADER_REQUIRE}}\n\nlayout ({gs_input}) in;\nlayout ({gs_output}, max_vertices = {max_vertices}) out;\n\nout vec2 out_gs_1;\n\nvoid main()\n{{\n    out_gs_1    = vec2(1.0, 2.0);\n    gl_Position = vec4(0, 0, 0, 1);\n    EmitVertex();\n}}\n"));
            }
        }

        for po_id in &mut objects.po_ids {
            // SAFETY: creates a program object.
            *po_id = unsafe { gl.create_program() };
        }
        glu::expect_no_error(gl, "glCreateProgram() call(s) failed.")?;
        let out_gs_1 = CString::new("out_gs_1").expect("no NUL in a varying name");
        let tf_varyings: [*const c_char; 1] = [out_gs_1.as_ptr()];
        for po_id in objects.po_ids {
            // SAFETY: one NUL-terminated varying name that outlives the call.
            unsafe { gl.transform_feedback_varyings(po_id, 1, tf_varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS) };
        }
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call(s) failed.")?;
        // SAFETY: creates shader objects.
        unsafe {
            objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            objects.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let vs_code_specialized = base.specialize_shader(&[MINIMAL_VS_CODE]);
        let (fs_parts, vs_parts) = ([fs_code_specialized.as_str()], [vs_code_specialized.as_str()]);
        let mut result = true;
        for (i, gs_code) in gs_codes.iter().enumerate() {
            let gs_code_specialized = base.specialize_shader(&[gs_code]);
            let gs_parts = [gs_code_specialized.as_str()];
            if !base
                .build_program(
                    context,
                    objects.po_ids[i],
                    &[
                        ShaderBody::Source(objects.fs_id, &fs_parts),
                        ShaderBody::Source(objects.gs_id, &gs_parts),
                        ShaderBody::Source(objects.vs_id, &vs_parts),
                    ],
                )?
                .0
            {
                log::info!("Program object linking failed whereas a success was expected.");
                result = false;
            }
        }
        if !result {
            return verdict(false);
        }

        // SAFETY: the names are written to live fields; the other calls use the objects just created.
        unsafe { gl.gen_vertex_arrays(1, &mut objects.vao_id) };
        glu::expect_no_error(gl, "glGenVertexArrays() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_vertex_array(objects.vao_id) };
        glu::expect_no_error(gl, "glBindVertexArray() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.gen_buffers(1, &mut objects.tfbo_id) };
        glu::expect_no_error(gl, "glGenBuffers() call(s) failed.")?;
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBuffer() call(s) failed.")?;
        // SAFETY: allocates room for two floats times three vertices.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (std::mem::size_of::<f32>() * 2 * 3) as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_STREAM_READ,
            )
        };
        glu::expect_no_error(gl, "glBufferData() call(s) failed.")?;
        // SAFETY: binds the buffer for transform feedback.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, objects.tfbo_id) };
        glu::expect_no_error(gl, "glBindBufferBase() call(s) failed.")?;
        // SAFETY: plain state change.
        unsafe { gl.enable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glEnable() call(s) failed.")?;

        'tf_modes: for tf_mode in TF_MODES {
            for (j, draw_call_mode) in DRAW_CALL_MODES.iter().enumerate() {
                for k in 0..3 {
                    // SAFETY: uses a program linked above.
                    unsafe { gl.use_program(objects.po_ids[k + 3 * j]) };
                    glu::expect_no_error(gl, "glUseProgram() call(s) failed.")?;
                    // SAFETY: a transform feedback pass that is paused around the draw call.
                    unsafe { gl.begin_transform_feedback(tf_mode) };
                    glu::expect_no_error(gl, "glBeginTransformFeedback() call(s) failed.")?;
                    // SAFETY: as above.
                    unsafe { gl.pause_transform_feedback() };
                    glu::expect_no_error(gl, "glPauseTransformFeedback() call(s) failed.")?;
                    // SAFETY: a draw call while transform feedback is paused, which must not raise an error.
                    unsafe { gl.draw_arrays(*draw_call_mode, 0, 3) };
                    // SAFETY: plain state query.
                    let error_code = unsafe { gl.get_error() };
                    // SAFETY: as above.
                    unsafe { gl.resume_transform_feedback() };
                    glu::expect_no_error(gl, "glResumeTransformFeedback() call(s) failed.")?;
                    // SAFETY: ends the pass begun above.
                    unsafe { gl.end_transform_feedback() };
                    glu::expect_no_error(gl, "glEndTransformFeedback() call(s) failed.")?;
                    if error_code != glw::GL_NO_ERROR {
                        log::info!("glDrawArrays() call generated an error while transform feedback was paused.");
                        result = false;
                        // Upstream's `break` leaves only the innermost loop; its loop conditions then end the other two.
                        break;
                    }
                }
                if !result {
                    break 'tf_modes;
                }
            }
        }
        // SAFETY: plain state change.
        unsafe { gl.disable(glw::GL_RASTERIZER_DISCARD) };
        glu::expect_no_error(gl, "glDisable() call(s) failed.")?;
        verdict(result)
    }
}

impl TestCase for DrawCallsWhileTfPaused {
    fn name(&self) -> &str {
        "draw_calls_while_tf_is_paused"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = DrawCallsWhileTfPausedObjects::default();
        let outcome = self.run(context, &mut objects);
        // SAFETY: deletes only names this case created.
        unsafe {
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
            }
            if objects.gs_id != 0 {
                gl.delete_shader(objects.gs_id);
            }
            for po_id in objects.po_ids {
                if po_id != 0 {
                    gl.delete_program(po_id);
                }
            }
            if objects.tfbo_id != 0 {
                gl.delete_buffers(1, &objects.tfbo_id);
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
            }
        }
        outcome
    }
}

/// What the `linking` cases below expect of the program they build.
#[derive(Clone, Copy)]
enum LinkExpectation {
    /// The program must fail to link while every shader compiles (`vs_gs_variable_type_mismatch`).
    LinkFailsShadersCompile,
    /// Linking succeeds exactly when the context is core 3.0 or later, and every shader compiles (`vs_gs_variable_qualifier_mismatch`).
    LinkSucceedsFromCore30,
    /// The program must not build; the compilation flag is not looked at.
    BuildFails,
    /// The program must not link and a shader must fail to compile (`geometry_shader_compilation_fail`).
    CompilationFails,
}

/// `GeometryShaderVSGSVariableTypeMismatchTest`, `...QualifierMismatchTest`, `...ArrayedVariableSizeMismatchTest`, `GeometryShaderFragCoordRedeclarationTest`,
/// `GeometryShaderLocationAliasingTest` and `GeometryShaderCompilationFailTest`: they differ in the shader sources and in what they expect of the build only.
struct LinkingCase {
    ext_params: ExtParameters,
    name: &'static str,
    gs_code: &'static str,
    vs_code: &'static str,
    expectation: LinkExpectation,
}

impl LinkingCase {
    fn run(&self, context: &Context, ids: &mut [GLuint; 4]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, gs_id, po_id, vs_id] = ids;

        // SAFETY: creates a program object and shader objects.
        *po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        // SAFETY: as above.
        unsafe {
            *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            *gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            *vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let gs_code_specialized = base.specialize_shader(&[self.gs_code]);
        let vs_code_specialized = base.specialize_shader(&[self.vs_code]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        let (built, has_shader_compilation_failed) = base.build_program(
            context,
            *po_id,
            &[
                ShaderBody::Source(*gs_id, &gs_parts),
                ShaderBody::Source(*vs_id, &vs_parts),
                ShaderBody::Source(*fs_id, &fs_parts),
            ],
        )?;

        let mut result = true;
        match self.expectation {
            LinkExpectation::LinkFailsShadersCompile => {
                if built {
                    log::info!("Program object was linked successfully, whereas a failure was expected.");
                    result = false;
                }
                if has_shader_compilation_failed {
                    log::info!("Shader compilation failed unexpectedly.");
                    result = false;
                }
            }
            LinkExpectation::LinkSucceedsFromCore30 => {
                let supports_core_30 = context.context_type().supports_core(3, 0);
                if !built && supports_core_30 {
                    log::info!("Program object linking failed. Success was expected.");
                    result = false;
                }
                if built && !supports_core_30 {
                    log::info!("Program object was linked successfully, whereas a failure was expected.");
                    result = false;
                }
                if has_shader_compilation_failed {
                    log::info!("Shader compilation failed unexpectedly.");
                    result = false;
                }
            }
            LinkExpectation::BuildFails => {
                if built {
                    log::info!("Program object was linked successfully, whereas a failure was expected.");
                    result = false;
                }
            }
            LinkExpectation::CompilationFails => {
                if built {
                    log::info!("Program object was linked successfully, whereas a failure was expected.");
                    result = false;
                }
                if !has_shader_compilation_failed {
                    log::info!("Shader compilation succeeded, whereas a failure was expected.");
                    result = false;
                }
            }
        }
        verdict(result)
    }
}

impl TestCase for LinkingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 4];
        let outcome = self.run(context, &mut ids);
        let [fs_id, gs_id, po_id, vs_id] = ids;
        // SAFETY: deletes only names this case created.
        unsafe {
            if fs_id != 0 {
                gl.delete_shader(fs_id);
            }
            if gs_id != 0 {
                gl.delete_shader(gs_id);
            }
            if po_id != 0 {
                gl.delete_program(po_id);
            }
            if vs_id != 0 {
                gl.delete_shader(vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderMoreInputVerticesThanAvailableTest`
struct MoreInputVerticesThanAvailable {
    ext_params: ExtParameters,
}

impl MoreInputVerticesThanAvailable {
    const NUMBER_OF_GS: usize = 5;
    const GS_CODES: [&'static str; 5] = [
        "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\nvoid main()\n{\n    gl_Position = gl_in[1].gl_Position;\n    EmitVertex();\n}\n",
        "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (lines)                    in;\nlayout (points, max_vertices = 1) out;\n\nvoid main()\n{\n    gl_Position = gl_in[2].gl_Position;\n    EmitVertex();\n}\n",
        "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (lines_adjacency)          in;\nlayout (points, max_vertices = 1) out;\n\nvoid main()\n{\n    gl_Position = gl_in[4].gl_Position;\n    EmitVertex();\n}\n",
        "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (triangles)                in;\nlayout (points, max_vertices = 1) out;\n\nvoid main()\n{\n    gl_Position = gl_in[3].gl_Position;\n    EmitVertex();\n}\n",
        "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (triangles_adjacency)      in;\nlayout (points, max_vertices = 1) out;\n\nvoid main()\n{\n    gl_Position = gl_in[6].gl_Position;\n    EmitVertex();\n}\n",
    ];

    /// `ids` holds the fragment and the vertex shader; `gs_ids` and `po_ids` the per-program names.
    fn run(
        &self,
        context: &Context,
        ids: &mut [GLuint; 2],
        gs_ids: &mut [GLuint; 5],
        po_ids: &mut [GLuint; 5],
    ) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, vs_id] = ids;

        for i in 0..Self::NUMBER_OF_GS {
            // SAFETY: creates a shader object and a program object.
            gs_ids[i] = unsafe { gl.create_shader(glw::GL_GEOMETRY_SHADER) };
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
            // SAFETY: as above.
            po_ids[i] = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;
        }
        // SAFETY: creates shader objects.
        unsafe {
            *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            *vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let vs_code_specialized = base.specialize_shader(&[MINIMAL_VS_CODE]);
        let (fs_parts, vs_parts) = ([fs_code_specialized.as_str()], [vs_code_specialized.as_str()]);
        let mut result = true;
        for (i, gs_code) in Self::GS_CODES.iter().enumerate() {
            let gs_code_specialized = base.specialize_shader(&[gs_code]);
            let gs_parts = [gs_code_specialized.as_str()];
            let built = base
                .build_program(
                    context,
                    po_ids[i],
                    &[
                        ShaderBody::Source(*fs_id, &fs_parts),
                        ShaderBody::Source(gs_ids[i], &gs_parts),
                        ShaderBody::Source(*vs_id, &vs_parts),
                    ],
                )?
                .0;
            if built {
                log::info!("Program object linking successful for i = [{i}], whereas a failure was expected.");
                result = false;
                break;
            }
        }
        verdict(result)
    }
}

impl TestCase for MoreInputVerticesThanAvailable {
    fn name(&self) -> &str {
        "more_input_vertices_in_GS_than_available"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut ids = [0 as GLuint; 2];
        let mut gs_ids = [0 as GLuint; 5];
        let mut po_ids = [0 as GLuint; 5];
        let outcome = self.run(context, &mut ids, &mut gs_ids, &mut po_ids);
        let [fs_id, vs_id] = ids;
        // SAFETY: deletes only names this case created.
        unsafe {
            if fs_id != 0 {
                gl.delete_shader(fs_id);
            }
            for gs_id in gs_ids {
                if gs_id != 0 {
                    gl.delete_shader(gs_id);
                }
            }
            for po_id in po_ids {
                if po_id != 0 {
                    gl.delete_program(po_id);
                }
            }
            if vs_id != 0 {
                gl.delete_shader(vs_id);
            }
        }
        outcome
    }
}

/// `GeometryShaderTests::init` for the `linking` subgroup: the cases ported so far, in upstream's order.
fn linking_group(ext_params: ExtParameters) -> TestCaseGroup {
    let mut linking = TestCaseGroup::new("linking");
    linking.add_child(Box::new(incomplete::IncompleteProgramObjects { ext_params }) as Box<dyn TestCase>);
    linking.add_child(Box::new(incomplete::IncompleteGs { ext_params }) as Box<dyn TestCase>);
    linking.add_child(Box::new(incomplete::InvalidArrayedInputVariables { ext_params }) as Box<dyn TestCase>);
    let cases: [(&'static str, &'static str, &'static str, LinkExpectation); 6] = [
        (
            "vs_gs_variable_type_mismatch",
            concat!(
                "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n",
                "in vec4 test[];\n\nvoid main()\n{\n    gl_Position = test[0];\n    EmitVertex();\n}\n"
            ),
            "${VERSION}\n\nout vec3 test;\n\nvoid main()\n{\n    test = vec3(gl_VertexID);\n}\n",
            LinkExpectation::LinkFailsShadersCompile,
        ),
        (
            "vs_gs_variable_qualifier_mismatch",
            concat!(
                "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n",
                "in flat vec4 test[];\n\nvoid main()\n{\n    gl_Position = test[0];\n    EmitVertex();\n}\n"
            ),
            "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nout vec4 test;\n\nvoid main()\n{\n    test = vec4(gl_VertexID);\n}\n",
            LinkExpectation::LinkSucceedsFromCore30,
        ),
        (
            "vs_gs_arrayed_variable_size_mismatch",
            concat!(
                "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n",
                "in vec4 Color1[];\nin vec4 Color2[2];\nin vec4 Color3[3];\n\nvoid main()\n{\n    gl_Position = Color1[0] + Color2[1] + Color3[2];\n    EmitVertex();\n}\n"
            ),
            "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nout vec4 Color1;\nout vec4 Color2;\nout vec4 Color3;\n\nvoid main()\n{\n    Color1 = vec4(gl_VertexID, 0.0,         0.0,         0.0);\n    Color2 = vec4(0.0,         gl_VertexID, 0.0,         0.0);\n    Color3 = vec4(0.0,         0.0,         gl_VertexID, 0.0);\n}\n",
            LinkExpectation::BuildFails,
        ),
        (
            "fragcoord_redeclaration",
            concat!(
                "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n",
                "in vec4 gl_FragCoord;\n\nvoid main()\n{\n    gl_Position = gl_FragCoord;\n    EmitVertex();\n}\n"
            ),
            MINIMAL_VS_CODE,
            LinkExpectation::BuildFails,
        ),
        (
            "location_aliasing",
            concat!(
                "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n",
                "layout (location = 2) out vec4 test;\nlayout (location = 2) out vec4 test2;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n    test = vec4(1.0, 0.0, 0.0, 1.0);\n    test2 = vec4(1.0, 0.0, 0.0, 1.0);\n    EmitVertex();\n}\n"
            ),
            MINIMAL_VS_CODE,
            LinkExpectation::BuildFails,
        ),
        (
            "geometry_shader_compilation_fail",
            concat!(
                "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n",
                "void main()\n{\n    gl_Position = gl_in[0].gl_Position;\n    mitVertex();\n}\n"
            ),
            MINIMAL_VS_CODE,
            LinkExpectation::CompilationFails,
        ),
    ];
    for (name, gs_code, vs_code, expectation) in cases {
        if name == "geometry_shader_compilation_fail" {
            for kind in [
                more_atomic_counters::Kind::Counters,
                more_atomic_counters::Kind::CounterBuffers,
            ] {
                linking.add_child(
                    Box::new(more_atomic_counters::MoreAtomicCounters { ext_params, kind }) as Box<dyn TestCase>
                );
            }
        }
        linking.add_child(Box::new(LinkingCase {
            ext_params,
            name,
            gs_code,
            vs_code,
            expectation,
        }) as Box<dyn TestCase>);
    }
    linking.add_child(Box::new(MoreInputVerticesThanAvailable { ext_params }) as Box<dyn TestCase>);
    linking.add_child(Box::new(tf_capture::TfCaptureFromGsAndVsVariables { ext_params }) as Box<dyn TestCase>);
    linking
}

/// `GeometryShaderTests::init` - the `api` subgroup, with the cases ported so far in upstream's order.
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("geometry_shader");

    let mut adjacency_group = TestCaseGroup::new("adjacency");
    for (name, mode, indiced) in [
        ("adjacency_non_indiced_lines", adjacency::Mode::Lines, false),
        ("adjacency_indiced_lines", adjacency::Mode::Lines, true),
        ("adjacency_non_indiced_line_strip", adjacency::Mode::LineStrip, false),
        ("adjacency_indiced_line_strip", adjacency::Mode::LineStrip, true),
        ("adjacency_non_indiced_triangles", adjacency::Mode::Triangles, false),
        ("adjacency_indiced_triangles", adjacency::Mode::Triangles, true),
        (
            "adjacency_non_indiced_triangle_strip",
            adjacency::Mode::TriangleStrip,
            false,
        ),
        ("adjacency_indiced_triangle_strip", adjacency::Mode::TriangleStrip, true),
    ] {
        adjacency_group.add_child(Box::new(adjacency::Adjacency {
            ext_params,
            name,
            mode,
            indiced,
        }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(adjacency_group));

    let mut rendering_group = TestCaseGroup::new("rendering");
    let mut rendering_cases = TestCaseGroup::new("rendering");
    for (input, mode) in [
        (rendering::Input::Points, glw::GL_POINTS),
        (rendering::Input::Lines, glw::GL_LINES),
        (rendering::Input::Lines, glw::GL_LINE_STRIP),
        (rendering::Input::Lines, glw::GL_LINE_LOOP),
        (rendering::Input::LinesAdjacency, glw::GL_LINES_ADJACENCY),
        (rendering::Input::LinesAdjacency, glw::GL_LINE_STRIP_ADJACENCY),
        (rendering::Input::Triangles, glw::GL_TRIANGLES),
        (rendering::Input::Triangles, glw::GL_TRIANGLE_FAN),
        (rendering::Input::Triangles, glw::GL_TRIANGLE_STRIP),
        (rendering::Input::TrianglesAdjacency, glw::GL_TRIANGLES_ADJACENCY),
        (rendering::Input::TrianglesAdjacency, glw::GL_TRIANGLE_STRIP_ADJACENCY),
    ] {
        for output in [
            rendering::Output::Points,
            rendering::Output::LineStrip,
            rendering::Output::TriangleStrip,
        ] {
            let name = rendering::Rendering::test_name(input, output, mode).to_string();
            rendering_cases.add_child(Box::new(rendering::Rendering {
                ext_params,
                name,
                input,
                mode,
                output,
            }) as Box<dyn TestCase>);
        }
    }
    rendering_group.add_child(TestNode::Group(rendering_cases));
    group.add_child(TestNode::Group(rendering_group));

    let mut nonarray_input = TestCaseGroup::new("nonarray_input");
    nonarray_input.add_child(Box::new(nonarray_input::NonarrayInput { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(nonarray_input));

    let mut clipping = TestCaseGroup::new("clipping");
    clipping.add_child(Box::new(clipping::Clipping { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(clipping));

    let mut blitting_group = TestCaseGroup::new("blitting");
    for kind in [
        blitting::Kind::LayeredToNonLayered,
        blitting::Kind::NonLayeredToLayered,
        blitting::Kind::LayeredToLayered,
    ] {
        blitting_group.add_child(Box::new(blitting::Blitting { ext_params, kind }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(blitting_group));

    let mut input_group = TestCaseGroup::new("input");
    for kind in [
        input::Kind::GlInArrayContents,
        input::Kind::GlInArrayLength,
        input::Kind::GlPointSizeValue,
        input::Kind::GlPositionValue,
    ] {
        input_group.add_child(Box::new(input::Input { ext_params, kind }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(input_group));

    let mut layered_fbo_group = TestCaseGroup::new("layered_fbo");
    for kind in [
        layered_fbo::Kind::IncompleteLayeredFbo,
        layered_fbo::Kind::IncompleteLayeredAttachments,
        layered_fbo::Kind::FramebufferTextureInvalidTarget,
        layered_fbo::Kind::FramebufferTextureNoFboBoundToTarget,
        layered_fbo::Kind::FramebufferTextureInvalidAttachment,
        layered_fbo::Kind::FramebufferTextureInvalidValue,
        layered_fbo::Kind::FramebufferTextureInvalidLevelNumber,
        layered_fbo::Kind::FramebufferTextureArgumentRefersToBufferTexture,
    ] {
        layered_fbo_group.add_child(Box::new(layered_fbo::LayeredFbo { ext_params, kind }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(layered_fbo_group));

    let mut layered_framebuffer_group = TestCaseGroup::new("layered_framebuffer");
    for kind in [
        layered_framebuffer::Kind::Stencil,
        layered_framebuffer::Kind::Depth,
        layered_framebuffer::Kind::Blending,
        layered_framebuffer::Kind::Clear,
    ] {
        layered_framebuffer_group
            .add_child(Box::new(layered_framebuffer::LayeredFramebuffer { ext_params, kind }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(layered_framebuffer_group));

    let mut layered_rendering_group = TestCaseGroup::new("layered_rendering");
    layered_rendering_group
        .add_child(Box::new(layered_rendering::LayeredRendering { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(layered_rendering_group));

    let mut layered_rendering_boundary_condition_group = TestCaseGroup::new("layered_rendering_boundary_condition");
    for kind in [
        layered_rendering_boundary_condition::Kind::VariousTextures,
        layered_rendering_boundary_condition::Kind::NoGs,
        layered_rendering_boundary_condition::Kind::NoLayerSet,
        layered_rendering_boundary_condition::Kind::NoLayeredFbo,
    ] {
        layered_rendering_boundary_condition_group.add_child(Box::new(
            layered_rendering_boundary_condition::LayeredRenderingBoundaryCondition { ext_params, kind },
        ) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(layered_rendering_boundary_condition_group));

    let mut layered_rendering_fbo_no_attachment_group = TestCaseGroup::new("layered_rendering_fbo_no_attachment");
    layered_rendering_fbo_no_attachment_group.add_child(Box::new(
        layered_rendering_fbo_no_attachment::LayeredRenderingFboNoAttachment { ext_params },
    ) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(layered_rendering_fbo_no_attachment_group));

    let mut constant_variables = TestCaseGroup::new("constant_variables");
    constant_variables.add_child(Box::new(constant_variables::ConstantVariables { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(constant_variables));

    let mut limits_group = TestCaseGroup::new("limits");
    for kind in [
        limits::Kind::MaxUniformComponents,
        limits::Kind::MaxUniformBlocks,
        limits::Kind::MaxInputComponents,
    ] {
        limits_group.add_child(Box::new(limits::Limits { ext_params, kind }) as Box<dyn TestCase>);
    }
    limits_group.add_child(Box::new(limits::OutputComponents {
        ext_params,
        kind: limits::OutputKind::MaxOutputComponents,
    }) as Box<dyn TestCase>);
    limits_group.add_child(Box::new(limits::MaxOutputVertices { ext_params }) as Box<dyn TestCase>);
    limits_group.add_child(Box::new(limits::OutputComponents {
        ext_params,
        kind: limits::OutputKind::MaxOutputComponentsSinglePoint,
    }) as Box<dyn TestCase>);
    limits_group.add_child(Box::new(limits::MaxTextureUnits { ext_params }) as Box<dyn TestCase>);
    limits_group.add_child(Box::new(limits::MaxInvocations { ext_params }) as Box<dyn TestCase>);
    limits_group.add_child(Box::new(limits::CombinedTextureUnits { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(limits_group));

    let mut output_group = TestCaseGroup::new("output");
    for case in output::create_tests(ext_params) {
        output_group.add_child(case);
    }
    group.add_child(TestNode::Group(output_group));

    let mut primitive_counter_group = TestCaseGroup::new("primitive_counter");
    for case in primitive_counter::create_tests(ext_params) {
        primitive_counter_group.add_child(case);
    }
    group.add_child(TestNode::Group(primitive_counter_group));

    let mut primitive_queries_group = TestCaseGroup::new("primitive_queries");
    for primitive in [
        primitive_queries::Primitive::Points,
        primitive_queries::Primitive::Lines,
        primitive_queries::Primitive::Triangles,
    ] {
        primitive_queries_group
            .add_child(Box::new(primitive_queries::PrimitiveQueries { ext_params, primitive }) as Box<dyn TestCase>);
    }
    group.add_child(TestNode::Group(primitive_queries_group));

    let mut program_resource_group = TestCaseGroup::new("program_resource");
    program_resource_group.add_child(Box::new(program_resource::ProgramResource { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(program_resource_group));

    group.add_child(TestNode::Group(linking_group(ext_params)));
    let mut api = TestCaseGroup::new("api");
    api.add_child(Box::new(CreateShaderProgramv { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(GetShaderiv { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(GetProgramiv { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(GetProgramiv2 { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(GetProgramiv3 { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(DrawCallWithFsAndGs { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(MaxImageUniforms { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(MaxShaderStorageBlocks { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(MaxAtomicCounters { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(MaxAtomicCounterBuffers { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(PipelineProgramWithoutActiveVs { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(IncompatibleDrawCallMode { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(InsufficientEmittedVertices { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(PipelineVsGsCapture { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(DrawPrimitivesDoNotMatchOutputPrimitives { ext_params }) as Box<dyn TestCase>);
    api.add_child(Box::new(DrawCallsWhileTfPaused { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(api));

    let mut qualifiers = TestCaseGroup::new("qualifiers");
    qualifiers.add_child(Box::new(qualifiers::FlatInterpolation { ext_params }) as Box<dyn TestCase>);
    group.add_child(TestNode::Group(qualifiers));
    group
}
