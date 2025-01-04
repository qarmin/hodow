// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcViewportArrayTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop core only. `DrawTestBase::iterate` and its helpers are `run`; the subclasses ported so far differ from each other only in `Kind`.

use super::VIEWPORT_ARRAY_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const DEPTH: GLuint = 16;
const HEIGHT: GLuint = 128;
const WIDTH: GLuint = 128;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum Kind {
    DrawMultipleLayers,
    Scissor,
    ScissorZeroDimension,
    ScissorClear,
    DrawToSingleLayerWithMultipleViewports,
    DynamicViewportIndex,
    ViewportIndexSubroutine,
    DrawMulitpleViewportsWithSingleInvocation,
    DepthRange,
    DepthRangeDepthTest,
    ProvokingVertex,
}

#[derive(Clone, Copy, PartialEq)]
enum TestType {
    Viewport,
    Scissor,
    DepthRange,
    Provoking,
}

const R32F_WIDTH: GLuint = 16;
const R32F_HEIGHT: GLuint = 2;
const R32IX4_DEPTH: GLuint = 4;

/// The `DrawTestBase` subclasses: `DrawMultipleLayers`, `Scissor`, `ScissorZeroDimension`, `ScissorClear`, `DrawToSingleLayerWithMultipleViewports`,
/// `DynamicViewportIndex`, `DrawMulitpleViewportsWithSingleInvocation`, `DepthRange`, `DepthRangeDepthTest` and `ProvokingVertex`
pub(super) struct DrawCase {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

/// The GL objects of one `DrawTestBase::iterate`; `Utils::program`, `vertexArray`, `framebuffer` and `texture` free theirs in destructors.
struct Objects<'a> {
    gl: &'a glw::Functions,
    program: GLuint,
    vao: GLuint,
    framebuffer: GLuint,
    texture: GLuint,
    depth_texture: GLuint,
}

impl Drop for Objects<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes only objects this struct generated; zero ids are skipped.
        unsafe {
            if self.framebuffer != 0 {
                self.gl.delete_framebuffers(1, &self.framebuffer);
            }
            if self.texture != 0 {
                self.gl.delete_textures(1, &self.texture);
            }
            if self.depth_texture != 0 {
                self.gl.delete_textures(1, &self.depth_texture);
            }
            if self.vao != 0 {
                self.gl.delete_vertex_arrays(1, &self.vao);
            }
            if self.program != 0 {
                self.gl.delete_program(self.program);
            }
        }
    }
}

const FRAGMENT_SHADER: &str = "${VERSION}\n\
\n\
flat in  int gs_fs_color;\n\
     out int fs_out_color;\n\
\n\
void main()\n\
{\n\
    fs_out_color = gs_fs_color;\n\
}\n\
\n";

const GEOMETRY_SHADER: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 16)         in;\n\
layout(triangle_strip, max_vertices = 4) out;\n\
\n\
flat out int gs_fs_color;\n\
\n\
void main()\n\
{\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Layer         = gl_InvocationID;\n\
    gl_Position  = vec4(-1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Layer         = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Layer         = gl_InvocationID;\n\
    gl_Position  = vec4(1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Layer         = gl_InvocationID;\n\
    gl_Position  = vec4(1, 1, 0, 1);\n\
    EmitVertex();\n\
}\n\
\n";

const VERTEX_SHADER: &str = "${VERSION}\n\
\n\
void main()\n\
{\n\
    /* empty */;\n\
}\n\
\n";

const GEOMETRY_SHADER_SINGLE_LAYER: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 16)         in;\n\
layout(triangle_strip, max_vertices = 4) out;\n\
\n\
flat out int gs_fs_color;\n\
\n\
void main()\n\
{\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = gl_InvocationID;\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, 1, 0, 1);\n\
    EmitVertex();\n\
}\n\
\n";

const GEOMETRY_SHADER_DYNAMIC_INDEX: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 1)          in;\n\
layout(triangle_strip, max_vertices = 4) out;\n\
\n\
uniform int uni_index;\n\
\n\
flat out int gs_fs_color;\n\
\n\
void main()\n\
{\n\
    gs_fs_color      = uni_index;\n\
    gl_ViewportIndex = uni_index;\n\
    gl_Position  = vec4(-1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = uni_index;\n\
    gl_ViewportIndex = uni_index;\n\
    gl_Position  = vec4(-1, 1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = uni_index;\n\
    gl_ViewportIndex = uni_index;\n\
    gl_Position  = vec4(1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = uni_index;\n\
    gl_ViewportIndex = uni_index;\n\
    gl_Position  = vec4(1, 1, 0, 1);\n\
    EmitVertex();\n\
}\n\
\n";

const GEOMETRY_SHADER_SUBROUTINE: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 1)          in;\n\
layout(triangle_strip, max_vertices = 4) out;\n\
\n\
flat out int gs_fs_color;\n\
\n\
subroutine void indexSetter(void);\n\
\n\
subroutine(indexSetter) void four()\n\
{\n\
    gs_fs_color      = 4;\n\
    gl_ViewportIndex = 4;\n\
}\n\
\n\
subroutine(indexSetter) void five()\n\
{\n\
    gs_fs_color      = 5;\n\
    gl_ViewportIndex = 5;\n\
}\n\
\n\
subroutine uniform indexSetter routine;\n\
\n\
void main()\n\
{\n\
    routine();\n\
    gl_Position  = vec4(-1, -1, 0, 1);\n\
    EmitVertex();\n\
    routine();\n\
    gl_Position  = vec4(-1, 1, 0, 1);\n\
    EmitVertex();\n\
    routine();\n\
    gl_Position  = vec4(1, -1, 0, 1);\n\
    EmitVertex();\n\
    routine();\n\
    gl_Position  = vec4(1, 1, 0, 1);\n\
    EmitVertex();\n\
}\n\
\n";

const GEOMETRY_SHADER_SINGLE_INVOCATION: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 1)           in;\n\
layout(triangle_strip, max_vertices = 64) out;\n\
\n\
flat out int gs_fs_color;\n\
\n\
void routine(int index)\n\
{\n\
    gs_fs_color      = index;\n\
    gl_ViewportIndex = index;\n\
    gl_Position  = vec4(-1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = index;\n\
    gl_ViewportIndex = index;\n\
    gl_Position  = vec4(-1, 1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = index;\n\
    gl_ViewportIndex = index;\n\
    gl_Position  = vec4(1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = index;\n\
    gl_ViewportIndex = index;\n\
    gl_Position  = vec4(1, 1, 0, 1);\n\
    EmitVertex();\n\
    EndPrimitive();\n\
}\n\
\n\
void main()\n\
{\n\
    for(int i = 0; i < 16; ++i)\n\
    {\n\
        routine(i);\n\
    }\n\
}\n\
\n";

const FRAGMENT_SHADER_DEPTH: &str = "${VERSION}\n\
\n\
out float fs_out_color;\n\
\n\
void main()\n\
{\n\
    fs_out_color = gl_FragCoord.z;\n\
}\n\
\n";

const GEOMETRY_SHADER_DEPTH_RANGE: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 16)         in;\n\
layout(triangle_strip, max_vertices = 8) out;\n\
\n\
void main()\n\
{\n\
    const float top_z    = 1.0;\n\
    const float bottom_z = -1.0;\n\
\n\
    /* Bottom */\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, -1, bottom_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 0, bottom_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, -1, bottom_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, 0, bottom_z, 1);\n\
    EmitVertex();\n\
    EndPrimitive();\n\
\n\
    /* Top */\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 0, top_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 1, top_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, 0, top_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, 1, top_z, 1);\n\
    EmitVertex();\n\
    EndPrimitive();\n\
}\n\
\n";

/// Differs from the `DepthRange` one only by the missing first `EndPrimitive`
const GEOMETRY_SHADER_DEPTH_RANGE_DEPTH_TEST: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 16)         in;\n\
layout(triangle_strip, max_vertices = 8) out;\n\
\n\
void main()\n\
{\n\
    const float top_z    = 1.0;\n\
    const float bottom_z = -1.0;\n\
\n\
    /* Bottom */\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, -1, bottom_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 0, bottom_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, -1, bottom_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, 0, bottom_z, 1);\n\
    EmitVertex();\n\
\n\
    /* Top */\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 0, top_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(-1, 1, top_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, 0, top_z, 1);\n\
    EmitVertex();\n\
    gl_ViewportIndex = gl_InvocationID;\n\
    gl_Position  = vec4(1, 1, top_z, 1);\n\
    EmitVertex();\n\
    EndPrimitive();\n\
}\n\
\n";

const GEOMETRY_SHADER_PROVOKING: &str = "${VERSION}\n\
\n\
${GEOMETRY_SHADER_ENABLE}\n\
${VIEWPORT_ARRAY_ENABLE}\n\
\n\
layout(points, invocations = 1)          in;\n\
layout(triangle_strip, max_vertices = 6) out;\n\
\n\
flat out int gs_fs_color;\n\
\n\
void main()\n\
{\n\
    /* Left-bottom half */\n\
    gs_fs_color      = 1;\n\
    gl_ViewportIndex = 0;\n\
    gl_Layer         = 0;\n\
    gl_Position  = vec4(-1, -1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = 1;\n\
    gl_ViewportIndex = 1;\n\
    gl_Layer         = 1;\n\
    gl_Position  = vec4(-1, 1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = 1;\n\
    gl_ViewportIndex = 2;\n\
    gl_Layer         = 2;\n\
    gl_Position  = vec4(1, -1, 0, 1);\n\
    EmitVertex();\n\
    EndPrimitive();\n\
\n\
    /* Right-top half */\n\
    gs_fs_color      = 1;\n\
    gl_ViewportIndex = 0;\n\
    gl_Layer         = 0;\n\
    gl_Position  = vec4(-1, 1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = 1;\n\
    gl_ViewportIndex = 1;\n\
    gl_Layer         = 1;\n\
    gl_Position  = vec4(1, 1, 0, 1);\n\
    EmitVertex();\n\
    gs_fs_color      = 1;\n\
    gl_ViewportIndex = 2;\n\
    gl_Layer         = 2;\n\
    gl_Position  = vec4(1, -1, 0, 1);\n\
    EmitVertex();\n\
    EndPrimitive();\n\
}\n\
\n";

/// `DrawTestBase::checkRegionR32I` (the overload with width and height)
fn check_region_r32i(
    x: GLuint,
    y: GLuint,
    width: GLuint,
    height: GLuint,
    expected_value: GLint,
    data: &[GLint],
) -> bool {
    let offset = y * height * WIDTH + x * width;

    for line in 0..height {
        let line_offset = offset + line * WIDTH;

        for texel in 0..width {
            let value = data[(line_offset + texel) as usize];

            if expected_value != value {
                log::info!("Invalid result. Region ({x}x{y}). Expected: {expected_value} got {value}");
                return false;
            }
        }
    }

    true
}

/// `DrawTestBase::checkRegionR32I` (the 4x4 regions overload)
fn check_region_r32i_4x4(x: GLuint, y: GLuint, expected_value: GLint, data: &[GLint]) -> bool {
    check_region_r32i(x, y, WIDTH / 4, HEIGHT / 4, expected_value, data)
}

impl DrawCase {
    fn test_type(&self) -> TestType {
        match self.kind {
            Kind::DrawMultipleLayers
            | Kind::DrawToSingleLayerWithMultipleViewports
            | Kind::DynamicViewportIndex
            | Kind::ViewportIndexSubroutine
            | Kind::DrawMulitpleViewportsWithSingleInvocation => TestType::Viewport,
            Kind::Scissor | Kind::ScissorZeroDimension | Kind::ScissorClear => TestType::Scissor,
            Kind::DepthRange | Kind::DepthRangeDepthTest => TestType::DepthRange,
            Kind::ProvokingVertex => TestType::Provoking,
        }
    }

    /// `DrawTestBase::iterate`'s switch over the test type
    fn n_iterations(&self) -> u32 {
        match self.test_type() {
            TestType::Viewport | TestType::Scissor => 3,
            TestType::DepthRange | TestType::Provoking => 2,
        }
    }

    fn is_depth_range(&self) -> bool {
        matches!(self.kind, Kind::DepthRange | Kind::DepthRangeDepthTest)
    }

    fn fragment_shader(&self) -> &'static str {
        if self.is_depth_range() {
            FRAGMENT_SHADER_DEPTH
        } else {
            FRAGMENT_SHADER
        }
    }

    /// Layer count of the array texture, `DrawTestBase::m_depth` or `m_r32ix4_depth`
    fn array_depth(&self) -> GLuint {
        if self.kind == Kind::ProvokingVertex {
            R32IX4_DEPTH
        } else {
            DEPTH
        }
    }

    /// The classes ported first draw to the R32I array texture, the others to a plain texture
    fn is_array(&self) -> bool {
        !matches!(
            self.kind,
            Kind::DrawToSingleLayerWithMultipleViewports
                | Kind::DynamicViewportIndex
                | Kind::ViewportIndexSubroutine
                | Kind::DrawMulitpleViewportsWithSingleInvocation
                | Kind::DepthRange
                | Kind::DepthRangeDepthTest
        )
    }

    fn geometry_shader(&self) -> &'static str {
        match self.kind {
            Kind::DrawToSingleLayerWithMultipleViewports => GEOMETRY_SHADER_SINGLE_LAYER,
            Kind::DynamicViewportIndex => GEOMETRY_SHADER_DYNAMIC_INDEX,
            Kind::ViewportIndexSubroutine => GEOMETRY_SHADER_SUBROUTINE,
            Kind::DrawMulitpleViewportsWithSingleInvocation => GEOMETRY_SHADER_SINGLE_INVOCATION,
            Kind::DepthRange => GEOMETRY_SHADER_DEPTH_RANGE,
            Kind::DepthRangeDepthTest => GEOMETRY_SHADER_DEPTH_RANGE_DEPTH_TEST,
            Kind::ProvokingVertex => GEOMETRY_SHADER_PROVOKING,
            _ => GEOMETRY_SHADER,
        }
    }

    /// `DrawTestBase::getDrawCallsNumber`
    fn draw_calls_number(&self) -> GLuint {
        match self.kind {
            Kind::DynamicViewportIndex => 16,
            Kind::ViewportIndexSubroutine => 2,
            Kind::DepthRangeDepthTest => 18,
            _ => 1,
        }
    }

    /// `ViewportIndexSubroutine::prepareUniforms`
    fn prepare_uniforms_subroutine(
        gl: &glw::Functions,
        objects: &Objects<'_>,
        draw_call_index: GLuint,
    ) -> Result<(), TestError> {
        let subroutine_name = if draw_call_index == 0 { c"four" } else { c"five" };

        // SAFETY: the program was linked and is in use; the names are NUL terminated.
        let (location, index) = unsafe {
            (
                gl.get_subroutine_uniform_location(objects.program, glw::GL_GEOMETRY_SHADER, c"routine".as_ptr()),
                gl.get_subroutine_index(objects.program, glw::GL_GEOMETRY_SHADER, subroutine_name.as_ptr()),
            )
        };

        if location != 0 {
            return Err(TestError::Fail(
                "Something wrong, subroutine uniform location is not 0. Mistake in geometry shader?".to_string(),
            ));
        }

        // SAFETY: points at one index, matching the one subroutine uniform.
        unsafe { gl.uniform_subroutinesuiv(glw::GL_GEOMETRY_SHADER, 1, &index) };
        glu::expect_no_error(gl, "UniformSubroutinesuiv")
    }

    /// `ViewportIndexSubroutine::setupViewports`
    fn setup_viewports_subroutine(gl: &glw::Functions, iteration_index: u32) -> Result<(), TestError> {
        let data: [f32; 8] = [0.0, 0.0, 64.0, 128.0, 64.0, 0.0, 64.0, 128.0];

        // SAFETY: plain state change.
        unsafe { gl.viewport(0, 0, WIDTH as i32, HEIGHT as i32) };
        glu::expect_no_error(gl, "Viewport")?;

        match iteration_index {
            0 => {
                // SAFETY: two viewports of 4 floats.
                unsafe { gl.viewport_arrayv(4, 2, data.as_ptr()) };
                glu::expect_no_error(gl, "ViewportArrayv")
            }
            1 => {
                // SAFETY: plain state changes.
                unsafe {
                    gl.viewport_indexedf(4, data[0], data[1], data[2], data[3]);
                    glu::expect_no_error(gl, "ViewportIndexedf")?;

                    gl.viewport_indexedf(5, data[4], data[5], data[6], data[7]);
                }
                glu::expect_no_error(gl, "ViewportIndexedf")
            }
            2 => {
                // SAFETY: each points at 4 floats of `data`.
                unsafe {
                    gl.viewport_indexedfv(4, data[0..].as_ptr());
                    glu::expect_no_error(gl, "ViewportIndexedfv")?;

                    gl.viewport_indexedfv(5, data[4..].as_ptr());
                }
                glu::expect_no_error(gl, "ViewportIndexedfv")
            }
            _ => Err(TestError::Fail("Invalid value".to_string())),
        }
    }

    /// `ViewportIndexSubroutine::checkResults`: left is 4, right is either -1 or 5
    fn check_results_subroutine(
        &self,
        gl: &glw::Functions,
        objects: &Objects<'_>,
        draw_call_index: GLuint,
    ) -> Result<bool, TestError> {
        let texture_data = self.read_texture(gl, objects)?;
        let expected_left = 4;
        let expected_right = if draw_call_index == 1 { 5 } else { -1 };

        for y in 0..4 {
            for x in 0..2 {
                if !check_region_r32i_4x4(x, y, expected_left, &texture_data) {
                    return Ok(false);
                }
            }
        }

        for y in 0..4 {
            for x in 2..4 {
                if !check_region_r32i_4x4(x, y, expected_right, &texture_data) {
                    return Ok(false);
                }
            }
        }

        Ok(true)
    }

    /// `DynamicViewportIndex::prepareUniforms`
    fn prepare_uniforms(
        &self,
        gl: &glw::Functions,
        objects: &Objects<'_>,
        draw_call_index: GLuint,
    ) -> Result<(), TestError> {
        if self.kind == Kind::ViewportIndexSubroutine {
            return Self::prepare_uniforms_subroutine(gl, objects, draw_call_index);
        }
        if self.kind != Kind::DynamicViewportIndex {
            return Ok(());
        }

        // SAFETY: the program was linked and is in use.
        unsafe {
            let location = gl.get_uniform_location(objects.program, c"uni_index".as_ptr());
            gl.uniform_1i(location, draw_call_index as GLint);
        }
        glu::expect_no_error(gl, "Uniform1i")
    }

    /// `DrawTestBase::prepareTextureR32I` and `prepareTextureArrayR32I` through `Utils::texture::create` and `update`
    fn prepare_texture(&self, gl: &glw::Functions, objects: &mut Objects<'_>) -> Result<(), TestError> {
        if self.is_depth_range() {
            Self::prepare_texture_r32f(gl, objects)?;
            if self.kind == Kind::DepthRangeDepthTest {
                Self::prepare_texture_d32f(gl, objects)?;
            }
            return Ok(());
        }
        if !self.is_array() {
            return Self::prepare_texture_r32i(gl, objects);
        }
        let depth = self.array_depth();
        let data = vec![-1 as GLint; (WIDTH * HEIGHT * depth) as usize];

        // SAFETY: a texture of WIDTH x HEIGHT x DEPTH R32I is allocated and `data` holds exactly that many ints.
        unsafe {
            gl.gen_textures(1, &mut objects.texture);
            glu::expect_no_error(gl, "GenTextures")?;

            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_storage_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                1,
                glw::GL_R32I,
                WIDTH as i32,
                HEIGHT as i32,
                depth as i32,
            );
            glu::expect_no_error(gl, "TexStorage3D")?;

            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_sub_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                0,
                0,
                0,
                WIDTH as i32,
                HEIGHT as i32,
                depth as i32,
                glw::GL_RED_INTEGER,
                glw::GL_INT,
                data.as_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "TexStorage2D")
    }

    /// `DrawTestBase::prepareTextureR32F`
    fn prepare_texture_r32f(gl: &glw::Functions, objects: &mut Objects<'_>) -> Result<(), TestError> {
        let data = vec![-1.0f32; (R32F_WIDTH * R32F_HEIGHT) as usize];

        // SAFETY: a texture of R32F_WIDTH x R32F_HEIGHT R32F is allocated and `data` holds exactly that many floats.
        unsafe {
            gl.gen_textures(1, &mut objects.texture);
            glu::expect_no_error(gl, "GenTextures")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_R32F,
                R32F_WIDTH as i32,
                R32F_HEIGHT as i32,
            );
            glu::expect_no_error(gl, "TexStorage2D")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                R32F_WIDTH as i32,
                R32F_HEIGHT as i32,
                glw::GL_RED,
                glw::GL_FLOAT,
                data.as_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "TexStorage2D")
    }

    /// `DrawTestBase::prepareTextureD32F`
    fn prepare_texture_d32f(gl: &glw::Functions, objects: &mut Objects<'_>) -> Result<(), TestError> {
        let data = vec![-1.0f32; (WIDTH * HEIGHT) as usize];

        // SAFETY: a texture of WIDTH x HEIGHT D32F is allocated and `data` holds exactly that many floats.
        unsafe {
            gl.gen_textures(1, &mut objects.depth_texture);
            glu::expect_no_error(gl, "GenTextures")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, objects.depth_texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_DEPTH_COMPONENT32F,
                WIDTH as i32,
                HEIGHT as i32,
            );
            glu::expect_no_error(gl, "TexStorage2D")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, objects.depth_texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                WIDTH as i32,
                HEIGHT as i32,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                data.as_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "TexStorage2D")
    }

    /// `DrawTestBase::prepareTextureR32I`
    fn prepare_texture_r32i(gl: &glw::Functions, objects: &mut Objects<'_>) -> Result<(), TestError> {
        let data = vec![-1 as GLint; (WIDTH * HEIGHT) as usize];

        // SAFETY: a texture of WIDTH x HEIGHT R32I is allocated and `data` holds exactly that many ints.
        unsafe {
            gl.gen_textures(1, &mut objects.texture);
            glu::expect_no_error(gl, "GenTextures")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32I, WIDTH as i32, HEIGHT as i32);
            glu::expect_no_error(gl, "TexStorage2D")?;

            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                WIDTH as i32,
                HEIGHT as i32,
                glw::GL_RED_INTEGER,
                glw::GL_INT,
                data.as_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "TexStorage2D")
    }

    /// `DrawTestBase::setupFramebuffer` through `Utils::framebuffer::attachTexture`
    fn setup_framebuffer(&self, gl: &glw::Functions, objects: &mut Objects<'_>) -> Result<(), TestError> {
        // SAFETY: generates and binds a framebuffer, attaches the texture created by `prepare_texture`.
        unsafe {
            gl.gen_framebuffers(1, &mut objects.framebuffer);
            glu::expect_no_error(gl, "GenFramebuffers")?;

            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, objects.framebuffer);
            glu::expect_no_error(gl, "BindFramebuffer")?;

            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, objects.texture, 0);
            glu::expect_no_error(gl, "FramebufferTexture")?;

            gl.viewport(0, 0, WIDTH as i32, HEIGHT as i32);
            glu::expect_no_error(gl, "Viewport")?;

            if self.kind == Kind::DepthRangeDepthTest {
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, objects.framebuffer);
                glu::expect_no_error(gl, "BindFramebuffer")?;

                gl.framebuffer_texture(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    objects.depth_texture,
                    0,
                );
                glu::expect_no_error(gl, "FramebufferTexture")?;

                gl.viewport(0, 0, WIDTH as i32, HEIGHT as i32);
                glu::expect_no_error(gl, "Viewport")?;
            }

            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, objects.framebuffer);
        }
        glu::expect_no_error(gl, "BindFramebuffer")
    }

    /// `Utils::texture::get` for an array texture, desktop path
    fn read_texture(&self, gl: &glw::Functions, objects: &Objects<'_>) -> Result<Vec<GLint>, TestError> {
        let (target, depth) = if self.is_array() {
            (glw::GL_TEXTURE_2D_ARRAY, self.array_depth())
        } else {
            (glw::GL_TEXTURE_2D, 1)
        };
        let mut texture_data = vec![0 as GLint; (WIDTH * HEIGHT * depth) as usize];

        // SAFETY: the texture holds WIDTH x HEIGHT x depth ints of R32I and the buffer has that size.
        unsafe {
            gl.bind_texture(target, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.get_tex_image(
                target,
                0,
                glw::GL_RED_INTEGER,
                glw::GL_INT,
                texture_data.as_mut_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "GetTexImage")?;

        Ok(texture_data)
    }

    /// `DrawTestBase::setup4x4Scissor`
    fn setup_4x4_scissor(gl: &glw::Functions, method: u32, set_zeros: bool) -> Result<(), TestError> {
        for i in 0..16 {
            // SAFETY: plain state change.
            unsafe { gl.enablei(glw::GL_SCISSOR_TEST, i) };
            glu::expect_no_error(gl, "Enablei")?;
        }

        let mut data = [0 as GLint; 16 * 4];
        let width = (WIDTH / 4) as GLint;
        let height = (HEIGHT / 4) as GLint;
        let mut index = 0;

        for y in 0..4 {
            for x in 0..4 {
                data[index * 4] = x * width;
                data[index * 4 + 1] = y * height;
                if !set_zeros {
                    data[index * 4 + 2] = width;
                    data[index * 4 + 3] = height;
                } else {
                    data[index * 4 + 2] = 0;
                    data[index * 4 + 3] = 0;
                }

                index += 1;
            }
        }

        match method {
            0 => {
                // SAFETY: 16 boxes of 4 ints.
                unsafe { gl.scissor_arrayv(0, 16, data.as_ptr()) };
                glu::expect_no_error(gl, "ScissorArrayv")?;
            }
            1 => {
                for i in 0..16usize {
                    // SAFETY: plain state change.
                    unsafe {
                        gl.scissor_indexed(
                            i as GLuint,
                            data[i * 4],
                            data[i * 4 + 1],
                            data[i * 4 + 2],
                            data[i * 4 + 3],
                        )
                    };
                    glu::expect_no_error(gl, "ScissorIndexed")?;
                }
            }
            2 => {
                for i in 0..16usize {
                    // SAFETY: points at 4 ints of `data`.
                    unsafe { gl.scissor_indexedv(i as GLuint, data[i * 4..].as_ptr()) };
                    glu::expect_no_error(gl, "ScissorIndexedv")?;
                }
            }
            _ => return Err(TestError::Fail("Invalid enum".to_string())),
        }

        Ok(())
    }

    /// `DrawTestBase::setupViewports`; `ScissorZeroDimension::setupViewports` differs by `set_zeros`
    fn setup_viewports(&self, test_type: TestType, iteration_index: u32, gl: &glw::Functions) -> Result<(), TestError> {
        if iteration_index > 2 {
            return Err(TestError::Fail("Invalid value".to_string()));
        }
        match test_type {
            TestType::Viewport if self.kind == Kind::ViewportIndexSubroutine => {
                Self::setup_viewports_subroutine(gl, iteration_index)
            }
            TestType::Viewport => Self::setup_4x4_viewport(gl, iteration_index),
            TestType::Scissor => Self::setup_4x4_scissor(gl, iteration_index, self.kind == Kind::ScissorZeroDimension),
            TestType::DepthRange => {
                Self::setup_16x2_depths(gl, iteration_index)?;

                if self.kind == Kind::DepthRangeDepthTest {
                    // SAFETY: plain state change.
                    unsafe { gl.enable(glw::GL_DEPTH_TEST) };
                    glu::expect_no_error(gl, "Enable")?;
                }
                Ok(())
            }
            TestType::Provoking => Self::setup_2x2_viewport(gl, iteration_index),
        }
    }

    /// `DrawTestBase::setup16x2Depths` (core path); method 0 is DEPTHRANGEARRAYV, 1 DEPTHRANGEINDEXED
    fn setup_16x2_depths(gl: &glw::Functions, method: u32) -> Result<(), TestError> {
        const STEP: f64 = 1.0 / 16.0;

        let mut depth_data = [0.0f64; 16 * 2];
        let mut viewport_data = [0.0f32; 16 * 4];

        for i in 0..16usize {
            let near = STEP * i as f64;

            depth_data[i * 2] = near;
            depth_data[i * 2 + 1] = 1.0 - near;

            viewport_data[i * 4] = i as f32;
            viewport_data[i * 4 + 1] = 0.0;
            viewport_data[i * 4 + 2] = 1.0;
            viewport_data[i * 4 + 3] = 2.0;
        }

        // SAFETY: 16 viewports of 4 floats.
        unsafe { gl.viewport_arrayv(0, 16, viewport_data.as_ptr()) };
        glu::expect_no_error(gl, "ViewportArrayv")?;

        match method {
            1 => {
                for i in 0..16usize {
                    // SAFETY: plain state change.
                    unsafe { gl.depth_range_indexed(i as GLuint, depth_data[i * 2], depth_data[i * 2 + 1]) };
                    glu::expect_no_error(gl, "DepthRangeIndexed")?;
                }
            }
            0 => {
                // SAFETY: 16 ranges of 2 doubles.
                unsafe { gl.depth_range_arrayv(0, 16, depth_data.as_ptr()) };
                glu::expect_no_error(gl, "DepthRangeArray")?;
            }
            _ => return Err(TestError::Fail("Invalid enum".to_string())),
        }

        Ok(())
    }

    /// `DrawTestBase::setup2x2Viewport` (core path); provoking 0 is FIRST, 1 LAST
    fn setup_2x2_viewport(gl: &glw::Functions, provoking: u32) -> Result<(), TestError> {
        let mut data = [0.0f32; 4 * 4];
        let width = (WIDTH / 2) as f32;
        let height = (HEIGHT / 2) as f32;
        let mut index = 0;

        for y in 0..2 {
            for x in 0..2 {
                data[index * 4] = x as f32 * width;
                data[index * 4 + 1] = y as f32 * height;
                data[index * 4 + 2] = width;
                data[index * 4 + 3] = height;

                index += 1;
            }
        }

        // SAFETY: 4 viewports of 4 floats.
        unsafe { gl.viewport_arrayv(0, 4, data.as_ptr()) };
        glu::expect_no_error(gl, "ViewportArrayv")?;

        let mode = match provoking {
            0 => glw::GL_FIRST_VERTEX_CONVENTION,
            1 => glw::GL_LAST_VERTEX_CONVENTION,
            _ => return Err(TestError::Fail("Invalid enum".to_string())),
        };

        // SAFETY: plain state change.
        unsafe { gl.provoking_vertex(mode) };
        glu::expect_no_error(gl, "ProvokingVertex")
    }

    /// `Utils::texture::get` for the R32F texture
    fn read_texture_r32f(&self, gl: &glw::Functions, objects: &Objects<'_>) -> Result<Vec<f32>, TestError> {
        let mut texture_data = vec![0.0f32; (R32F_WIDTH * R32F_HEIGHT) as usize];

        // SAFETY: the texture holds R32F_WIDTH x R32F_HEIGHT floats and the buffer has that size.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, objects.texture);
            glu::expect_no_error(gl, "BindTexture")?;

            gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RED,
                glw::GL_FLOAT,
                texture_data.as_mut_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "GetTexImage")?;

        Ok(texture_data)
    }

    /// `DepthRange::checkResults`
    fn check_results_depth_range(&self, gl: &glw::Functions, objects: &Objects<'_>) -> Result<bool, TestError> {
        const STEP: f32 = 1.0 / 16.0;

        let texture_data = self.read_texture_r32f(gl, objects)?;

        for i in 0..16usize {
            let expected_near = STEP * i as f32;
            let expected_far = 1.0 - expected_near;

            // Bottom row should contain near values, top one should contain far values
            let near = texture_data[i];
            let far = texture_data[i + 16];

            if expected_near != near || expected_far != far {
                log::info!("Invalid values at {i} expected [{expected_near}, {expected_far}] got [{near}, {far}]");
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `DepthRangeDepthTest::checkResults`
    fn check_results_depth_test(
        &self,
        gl: &glw::Functions,
        objects: &Objects<'_>,
        draw_call_index: GLuint,
    ) -> Result<bool, TestError> {
        const STEP: f32 = 1.0 / 16.0;

        let depth_value = STEP * draw_call_index as f32;
        let texture_data = self.read_texture_r32f(gl, objects)?;

        for i in 0..16usize {
            let near = texture_data[i];
            let far = texture_data[i + 16];

            if depth_value <= near || depth_value <= far {
                log::info!("Invalid values at {i} depth value {depth_value} got [{near}, {far}]");
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `ProvokingVertex::checkResults`
    fn check_results_provoking(&self, gl: &glw::Functions, objects: &Objects<'_>) -> Result<bool, TestError> {
        let layer_size = (WIDTH * HEIGHT) as usize;

        let mut layer_mode: GLint = 0;
        let mut viewport_mode: GLint = 0;
        // SAFETY: each query writes one int.
        unsafe {
            gl.get_integerv(glw::GL_LAYER_PROVOKING_VERTEX, &mut layer_mode);
            glu::expect_no_error(gl, "GetIntegerv")?;
            gl.get_integerv(glw::GL_VIEWPORT_INDEX_PROVOKING_VERTEX, &mut viewport_mode);
        }
        glu::expect_no_error(gl, "GetIntegerv")?;

        let layer_mode = layer_mode as u32;
        let viewport_mode = viewport_mode as u32;

        if layer_mode == glw::GL_UNDEFINED_VERTEX || viewport_mode == glw::GL_UNDEFINED_VERTEX {
            // Results are undefined, therefore it does not make sense to verify them
            return Ok(true);
        }

        let texture_data = self.read_texture(gl, objects)?;

        let mut provoking: GLint = 0;
        // SAFETY: writes one int.
        unsafe { gl.get_integerv(glw::GL_PROVOKING_VERTEX, &mut provoking) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let provoking = provoking as u32;

        let first = |mode: u32| {
            mode == glw::GL_FIRST_VERTEX_CONVENTION
                || (mode == glw::GL_PROVOKING_VERTEX && provoking == glw::GL_FIRST_VERTEX_CONVENTION)
        };
        let expected_layer: GLuint = if first(layer_mode) { 0 } else { 2 };
        let expected_viewport: GLuint = if first(viewport_mode) { 0 } else { 2 };

        for layer in 0..R32IX4_DEPTH {
            let layer_data = &texture_data[layer as usize * layer_size..];
            let mut viewport: GLuint = 0;

            for y in 0..2 {
                for x in 0..2 {
                    // If layer and viewport are expected ones, than result shall be 1, otherwise -1.
                    let expected_value = if expected_viewport == viewport && expected_layer == layer {
                        1
                    } else {
                        -1
                    };

                    if !check_region_r32i(x, y, WIDTH / 2, HEIGHT / 2, expected_value, layer_data) {
                        return Ok(false);
                    }

                    viewport += 1;
                }
            }
        }

        Ok(true)
    }

    /// `DrawTestBase::setup4x4Viewport`
    fn setup_4x4_viewport(gl: &glw::Functions, method: u32) -> Result<(), TestError> {
        let mut data = [0.0f32; 16 * 4];
        let width = (WIDTH / 4) as f32;
        let height = (HEIGHT / 4) as f32;
        let mut index = 0;

        for y in 0..4 {
            for x in 0..4 {
                data[index * 4] = x as f32 * width;
                data[index * 4 + 1] = y as f32 * height;
                data[index * 4 + 2] = width;
                data[index * 4 + 3] = height;

                index += 1;
            }
        }

        match method {
            0 => {
                // SAFETY: 16 viewports of 4 floats.
                unsafe { gl.viewport_arrayv(0, 16, data.as_ptr()) };
                glu::expect_no_error(gl, "ViewportArrayv")?;
            }
            1 => {
                for i in 0..16usize {
                    // SAFETY: plain state change.
                    unsafe {
                        gl.viewport_indexedf(
                            i as GLuint,
                            data[i * 4],
                            data[i * 4 + 1],
                            data[i * 4 + 2],
                            data[i * 4 + 3],
                        )
                    };
                    glu::expect_no_error(gl, "ViewportIndexedf")?;
                }
            }
            2 => {
                for i in 0..16usize {
                    // SAFETY: points at 4 floats of `data`.
                    unsafe { gl.viewport_indexedfv(i as GLuint, data[i * 4..].as_ptr()) };
                    glu::expect_no_error(gl, "ViewportIndexedfv")?;
                }
            }
            _ => return Err(TestError::Fail("Invalid enum".to_string())),
        }

        Ok(())
    }

    /// `checkResults` of the four classes
    fn check_results(
        &self,
        gl: &glw::Functions,
        objects: &Objects<'_>,
        draw_call_index: GLuint,
    ) -> Result<bool, TestError> {
        match self.kind {
            Kind::DepthRange => return self.check_results_depth_range(gl, objects),
            Kind::DepthRangeDepthTest => return self.check_results_depth_test(gl, objects, draw_call_index),
            Kind::ProvokingVertex => return self.check_results_provoking(gl, objects),
            Kind::ViewportIndexSubroutine => return self.check_results_subroutine(gl, objects, draw_call_index),
            _ => {}
        }

        let layer_size = (WIDTH * HEIGHT) as usize;
        let texture_data = self.read_texture(gl, objects)?;

        if !self.is_array() {
            let mut index: GLuint = 0;

            for y in 0..4 {
                for x in 0..4 {
                    let expected_value = if self.kind == Kind::DynamicViewportIndex && index > draw_call_index {
                        -1
                    } else {
                        index as GLint
                    };

                    if !check_region_r32i_4x4(x, y, expected_value, &texture_data) {
                        return Ok(false);
                    }

                    index += 1;
                }
            }

            return Ok(true);
        }

        // 16 layers
        for layer in 0..DEPTH {
            let mut index = 0;
            let layer_data = &texture_data[layer as usize * layer_size..];

            for y in 0..4 {
                for x in 0..4 {
                    let expected_value = match self.kind {
                        Kind::DrawMultipleLayers | Kind::Scissor if index == layer => index as GLint,
                        Kind::ScissorClear if x == 0 && y == 0 => 0,
                        _ => -1,
                    };

                    if !check_region_r32i_4x4(x, y, expected_value, layer_data) {
                        return Ok(false);
                    }

                    index += 1;
                }
            }
        }

        Ok(true)
    }
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        match self.kind {
            Kind::DrawMultipleLayers => "draw_multiple_layers",
            Kind::Scissor => "scissor",
            Kind::ScissorZeroDimension => "scissor_zero_dimension",
            Kind::ScissorClear => "scissor_clear",
            Kind::DrawToSingleLayerWithMultipleViewports => "draw_to_single_layer_with_multiple_viewports",
            Kind::DynamicViewportIndex => "dynamic_viewport_index",
            Kind::ViewportIndexSubroutine => "viewport_index_subroutine",
            Kind::DrawMulitpleViewportsWithSingleInvocation => "draw_mulitple_viewports_with_single_invocation",
            Kind::DepthRange => "depth_range",
            Kind::DepthRangeDepthTest => "depth_range_depth_test",
            Kind::ProvokingVertex => "provoking_vertex",
        }
    }

    /// `DrawTestBase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_viewport_array_supported {
            return Err(TestError::NotSupported(VIEWPORT_ARRAY_NOT_SUPPORTED.to_string()));
        }

        let mut test_result = true;
        let test_type = self.test_type();
        let n_iterations = self.n_iterations();
        let is_clear_test = self.kind == Kind::ScissorClear;

        let mut objects = Objects {
            gl,
            program: 0,
            vao: 0,
            framebuffer: 0,
            texture: 0,
            depth_texture: 0,
        };

        // SAFETY: creates a program and three shader objects; the shaders are deleted once attached.
        let (fs, gs, vs) = unsafe {
            objects.program = gl.create_program();
            (
                gl.create_shader(glw::GL_FRAGMENT_SHADER),
                gl.create_shader(glw::GL_GEOMETRY_SHADER),
                gl.create_shader(glw::GL_VERTEX_SHADER),
            )
        };
        let built = base.build_program(
            context,
            objects.program,
            &[
                ShaderBody::Source(fs, &[self.fragment_shader()]),
                ShaderBody::Source(gs, &[self.geometry_shader()]),
                ShaderBody::Source(vs, &[VERTEX_SHADER]),
            ],
        );
        // SAFETY: flags the shaders for deletion with the program.
        unsafe {
            gl.delete_shader(fs);
            gl.delete_shader(gs);
            gl.delete_shader(vs);
        }
        if !built?.0 {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        // SAFETY: the program linked above.
        unsafe { gl.use_program(objects.program) };
        glu::expect_no_error(gl, "UseProgram")?;

        // SAFETY: generates and binds a vertex array.
        unsafe {
            gl.gen_vertex_arrays(1, &mut objects.vao);
            gl.bind_vertex_array(objects.vao);
        }
        glu::expect_no_error(gl, "VertexArray")?;

        'iterations: for i in 0..n_iterations {
            // Fresh texture and framebuffer per iteration, as the C++ locals.
            // SAFETY: frees the previous iteration's objects before they are regenerated.
            unsafe {
                if objects.framebuffer != 0 {
                    gl.delete_framebuffers(1, &objects.framebuffer);
                    objects.framebuffer = 0;
                }
                if objects.texture != 0 {
                    gl.delete_textures(1, &objects.texture);
                    objects.texture = 0;
                }
                if objects.depth_texture != 0 {
                    gl.delete_textures(1, &objects.depth_texture);
                    objects.depth_texture = 0;
                }
            }

            self.prepare_texture(gl, &mut objects)?;
            self.setup_framebuffer(gl, &mut objects)?;
            self.setup_viewports(test_type, i, gl)?;

            if !is_clear_test {
                for draw_call in 0..self.draw_calls_number() {
                    self.prepare_uniforms(gl, &objects, draw_call)?;

                    if self.kind == Kind::DepthRangeDepthTest {
                        const STEP: f32 = 1.0 / 16.0;
                        let depth_value = STEP * draw_call as f32;

                        // SAFETY: plain state changes.
                        unsafe { gl.clear_depth(depth_value as f64) };
                        glu::expect_no_error(gl, "ClearDepth")?;

                        // SAFETY: plain state change.
                        unsafe { gl.clear(glw::GL_DEPTH_BUFFER_BIT) };
                        glu::expect_no_error(gl, "Clear")?;
                    }

                    // SAFETY: draws one point with the program and vertex array bound above.
                    unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
                    glu::expect_no_error(gl, "DrawArrays")?;

                    if !self.check_results(gl, &objects, draw_call)? {
                        test_result = false;
                        break 'iterations;
                    }
                }
            } else {
                // SAFETY: plain state changes.
                unsafe {
                    gl.clear_color(0.0, 0.0, 0.0, 0.0);
                    glu::expect_no_error(gl, "ClearColor")?;

                    gl.clear(glw::GL_COLOR_BUFFER_BIT);
                }
                glu::expect_no_error(gl, "Clear")?;

                if !self.check_results(gl, &objects, 0)? {
                    test_result = false;
                    break;
                }
            }
        }

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
