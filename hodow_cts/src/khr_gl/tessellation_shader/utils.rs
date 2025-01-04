// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderUtils.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The helper class holds the context and the parent case's `TestCaseBase` by reference and releases its objects in `Drop` (upstream: destructor).

use std::ffi::CString;

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{LogType, ShaderBody, TestCaseBase};
use crate::tcu::TestError;

/// `_tessellation_levels`
#[derive(Clone, Copy, Default, Debug)]
pub(super) struct TessellationLevels {
    pub inner: [f32; 2],
    pub outer: [f32; 4],
}

/// `_tessellation_level_set_filter`
pub(super) const LEVEL_SET_FILTER_ALL_COMBINATIONS: u32 = 0x1;
pub(super) const LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES: u32 = 0x2;
pub(super) const LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE: u32 = 0x4;
pub(super) const LEVEL_SET_FILTER_EXCLUDE_NEGATIVE_BASE_VALUE: u32 = 0x8;

/// `_tessellation_primitive_mode`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum PrimitiveMode {
    Isolines,
    Triangles,
    Quads,
}

impl PrimitiveMode {
    pub const ALL: [PrimitiveMode; 3] = [PrimitiveMode::Isolines, PrimitiveMode::Triangles, PrimitiveMode::Quads];
}

/// `_tessellation_shader_vertex_ordering`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum VertexOrdering {
    Ccw,
    Cw,
    Default,
}

/// `_tessellation_shader_vertex_spacing`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum VertexSpacing {
    Equal,
    FractionalEven,
    FractionalOdd,
    Default,
}

impl VertexSpacing {
    pub const ALL: [VertexSpacing; 4] = [
        VertexSpacing::Equal,
        VertexSpacing::FractionalEven,
        VertexSpacing::FractionalOdd,
        VertexSpacing::Default,
    ];
}

/// `_tessellation_test_type`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum TestType {
    TcsTes,
    Tes,
}

/// `TessellationShaderUtils::getESTokenForPrimitiveMode`
pub(super) fn get_es_token_for_primitive_mode(primitive_mode: PrimitiveMode) -> &'static str {
    match primitive_mode {
        PrimitiveMode::Isolines => "isolines",
        PrimitiveMode::Quads => "quads",
        PrimitiveMode::Triangles => "triangles",
    }
}

/// `TessellationShaderUtils::getESTokenForVertexOrderingMode`
pub(super) fn get_es_token_for_vertex_ordering_mode(vertex_ordering: VertexOrdering) -> &'static str {
    match vertex_ordering {
        VertexOrdering::Ccw => "ccw",
        VertexOrdering::Cw => "cw",
        VertexOrdering::Default => "",
    }
}

/// `TessellationShaderUtils::getESTokenForVertexSpacingMode`
pub(super) fn get_es_token_for_vertex_spacing_mode(vertex_spacing: VertexSpacing) -> &'static str {
    match vertex_spacing {
        VertexSpacing::Default => "",
        VertexSpacing::Equal => "equal_spacing",
        VertexSpacing::FractionalEven => "fractional_even_spacing",
        VertexSpacing::FractionalOdd => "fractional_odd_spacing",
    }
}

/// `TessellationShaderUtils::getGenericTCCode`
pub(super) fn get_generic_tc_code(n_patch_vertices: u32, should_use_gl_invocation_id_indexed_input: bool) -> String {
    let tc_body_false = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = MAX_VERTICES) out;\n\nuniform vec2 inner_tess_level;\nuniform vec4 outer_tess_level;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[0].gl_Position;\n\n    gl_TessLevelInner[0] = inner_tess_level.x;\n    gl_TessLevelInner[1] = inner_tess_level.y;\n    gl_TessLevelOuter[0] = outer_tess_level.x;\n    gl_TessLevelOuter[1] = outer_tess_level.y;\n    gl_TessLevelOuter[2] = outer_tess_level.z;\n    gl_TessLevelOuter[3] = outer_tess_level.w;\n}\n";
    let tc_body_true = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = MAX_VERTICES) out;\n\nuniform vec2 inner_tess_level;\nuniform vec4 outer_tess_level;\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\n    gl_TessLevelInner[0] = inner_tess_level.x;\n    gl_TessLevelInner[1] = inner_tess_level.y;\n    gl_TessLevelOuter[0] = outer_tess_level.x;\n    gl_TessLevelOuter[1] = outer_tess_level.y;\n    gl_TessLevelOuter[2] = outer_tess_level.z;\n    gl_TessLevelOuter[3] = outer_tess_level.w;\n}\n";

    let body = if should_use_gl_invocation_id_indexed_input {
        tc_body_true
    } else {
        tc_body_false
    };
    body.replace("MAX_VERTICES", &n_patch_vertices.to_string())
}

/// `TessellationShaderUtils::getGenericTECode`
pub(super) fn get_generic_te_code(
    vertex_spacing: VertexSpacing,
    primitive_mode: PrimitiveMode,
    vertex_ordering: VertexOrdering,
    point_mode: bool,
) -> String {
    let te_body = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (TESSELLATOR_PRIMITIVE_MODE VERTEX_SPACING_MODE VERTEX_ORDERING POINT_MODE) in;\n\nout vec3 result_uvw;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n    result_uvw  = gl_TessCoord;\n}\n";

    let primitive_mode_string = get_es_token_for_primitive_mode(primitive_mode);

    // The default token is empty, and the shader would not compile without the comma in front of a non-empty one.
    let vertex_ordering_string = if vertex_ordering == VertexOrdering::Default {
        get_es_token_for_vertex_ordering_mode(vertex_ordering).to_string()
    } else {
        format!(", {}", get_es_token_for_vertex_ordering_mode(vertex_ordering))
    };
    let vertex_spacing_mode_string = if vertex_spacing == VertexSpacing::Default {
        get_es_token_for_vertex_spacing_mode(vertex_spacing).to_string()
    } else {
        format!(", {}", get_es_token_for_vertex_spacing_mode(vertex_spacing))
    };

    te_body
        .replace("TESSELLATOR_PRIMITIVE_MODE", primitive_mode_string)
        .replace("VERTEX_ORDERING", &vertex_ordering_string)
        .replace("VERTEX_SPACING_MODE", &vertex_spacing_mode_string)
        .replace("POINT_MODE", if point_mode { ", point_mode" } else { "" })
}

/// `TessellationShaderUtils::getPatchVerticesForPrimitiveMode`
pub(super) fn get_patch_vertices_for_primitive_mode(primitive_mode: PrimitiveMode) -> GLint {
    match primitive_mode {
        PrimitiveMode::Isolines => 4,
        PrimitiveMode::Quads => 4,
        PrimitiveMode::Triangles => 3,
    }
}

/// `TessellationShaderUtils::getTFModeForPrimitiveMode`
pub(super) fn get_tf_mode_for_primitive_mode(primitive_mode: PrimitiveMode, is_point_mode: bool) -> GLenum {
    if is_point_mode {
        return glw::GL_POINTS;
    }
    match primitive_mode {
        PrimitiveMode::Isolines => glw::GL_LINES,
        PrimitiveMode::Quads => glw::GL_TRIANGLES,
        PrimitiveMode::Triangles => glw::GL_TRIANGLES,
    }
}

/// `TessellationShaderUtils::convertBarycentricCoordinatesToCartesian`: a triangle basis of (0.5, 0), (1, 1), (0, 1).
pub(super) fn convert_barycentric_coordinates_to_cartesian(barycentric_coordinates: &[f32]) -> [f32; 2] {
    let triangle_vertex1_cartesian = [0.5_f32, 0.0];
    let triangle_vertex2_cartesian = [1.0_f32, 1.0];
    let triangle_vertex3_cartesian = [0.0_f32, 1.0];

    [
        (f64::from(barycentric_coordinates[0]) * f64::from(triangle_vertex1_cartesian[0])
            + f64::from(barycentric_coordinates[1]) * f64::from(triangle_vertex2_cartesian[0])
            + f64::from(barycentric_coordinates[2]) * f64::from(triangle_vertex3_cartesian[0])) as f32,
        barycentric_coordinates[0] * triangle_vertex1_cartesian[1]
            + barycentric_coordinates[1] * triangle_vertex2_cartesian[1]
            + barycentric_coordinates[2] * triangle_vertex3_cartesian[1],
    ]
}

/// `TessellationShaderUtils::convertCartesianCoordinatesToBarycentric`
pub(super) fn convert_cartesian_coordinates_to_barycentric(cartesian_coordinates: &[f32]) -> [f32; 3] {
    let (x1, x2, x3) = (0.5_f32, 1.0_f32, 0.0_f32);
    let (y1, y2, y3) = (0.0_f32, 1.0_f32, 1.0_f32);

    let b0 = ((y2 - y3) * (cartesian_coordinates[0] - x3) + (x3 - x2) * (cartesian_coordinates[1] - y3))
        / ((y2 - y3) * (x1 - x3) + (x3 - x2) * (y1 - y3));
    let b1 = ((y3 - y1) * (cartesian_coordinates[0] - x3) + (x1 - x3) * (cartesian_coordinates[1] - y3))
        / ((y2 - y3) * (x1 - x3) + (x3 - x2) * (y1 - y3));
    [b0, b1, 1.0 - b0 - b1]
}

/// `TessellationShaderUtils::getTessellationLevelAfterVertexSpacing`: returns (clamped, clamped and rounded).
pub(super) fn get_tessellation_level_after_vertex_spacing(
    vertex_spacing: VertexSpacing,
    mut level: f32,
    gl_max_tess_gen_level_value: GLint,
) -> (f32, f32) {
    match vertex_spacing {
        VertexSpacing::Default | VertexSpacing::Equal => {
            if level < 1.0 {
                level = 1.0;
            } else if level > gl_max_tess_gen_level_value as f32 {
                level = gl_max_tess_gen_level_value as f32;
            }
            let clamped = level;
            // Round *up* to nearest integer
            level = (level.ceil() + 0.5) as i32 as f32;
            (clamped, level)
        }
        VertexSpacing::FractionalEven => {
            if level < 2.0 {
                level = 2.0;
            } else if level > gl_max_tess_gen_level_value as f32 {
                level = gl_max_tess_gen_level_value as f32;
            }
            let clamped = level;
            // Round *up* to nearest *even* integer
            let mut level_temp = (level.ceil() + 0.5) as i32;
            if level_temp % 2 != 0 {
                level_temp += 1;
            }
            (clamped, level_temp as f32)
        }
        VertexSpacing::FractionalOdd => {
            if level < 1.0 {
                level = 1.0;
            } else if level > (gl_max_tess_gen_level_value - 1) as f32 {
                level = (gl_max_tess_gen_level_value - 1) as f32;
            }
            let clamped = level;
            // Round to *up* nearest *odd* integer
            let mut level_temp = (level.ceil() + 0.5) as i32;
            if level_temp % 2 != 1 {
                level_temp += 1;
            }
            (clamped, level_temp as f32)
        }
    }
}

/// `TessellationShaderUtils::getTessellationLevelSetForPrimitiveMode`
pub(super) fn get_tessellation_level_set_for_primitive_mode(
    primitive_mode: PrimitiveMode,
    gl_max_tess_gen_level_value: GLint,
    filter: u32,
) -> Vec<TessellationLevels> {
    // As a starter value, use a tessellation level that is different for each primitive mode.
    let n_min_patch_vertices = get_patch_vertices_for_primitive_mode(primitive_mode);

    let mut n_half_max_patch_vertices_mul_min = gl_max_tess_gen_level_value / 2;
    let mut n_max_patch_vertices_mul_min = gl_max_tess_gen_level_value;

    if n_half_max_patch_vertices_mul_min % n_min_patch_vertices != 0 {
        // Round to nearest mul-of-min integer
        n_half_max_patch_vertices_mul_min +=
            n_min_patch_vertices - (gl_max_tess_gen_level_value / 2) % n_min_patch_vertices;
    }
    if n_max_patch_vertices_mul_min % n_min_patch_vertices != 0 {
        // Round to previous nearest mul-of-min integer
        n_max_patch_vertices_mul_min -= gl_max_tess_gen_level_value % n_min_patch_vertices;
    }

    let mut result = Vec::new();

    if filter & LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE != 0 {
        let item_1 = TessellationLevels {
            inner: [n_min_patch_vertices as f32, (n_min_patch_vertices + 1) as f32],
            outer: [
                (n_min_patch_vertices + 3) as f32,
                (n_min_patch_vertices + 2) as f32,
                (n_min_patch_vertices + 1) as f32,
                n_min_patch_vertices as f32,
            ],
        };
        let item_2 = TessellationLevels {
            inner: [
                n_half_max_patch_vertices_mul_min as f32,
                (n_half_max_patch_vertices_mul_min - 1) as f32,
            ],
            outer: [
                (n_half_max_patch_vertices_mul_min - 3) as f32,
                (n_half_max_patch_vertices_mul_min - 2) as f32,
                (n_half_max_patch_vertices_mul_min - 1) as f32,
                n_half_max_patch_vertices_mul_min as f32,
            ],
        };
        let item_3 = TessellationLevels {
            inner: [
                (n_max_patch_vertices_mul_min - 1) as f32,
                (n_max_patch_vertices_mul_min - 2) as f32,
            ],
            outer: [
                (n_max_patch_vertices_mul_min - 3) as f32,
                (n_max_patch_vertices_mul_min - 4) as f32,
                (n_max_patch_vertices_mul_min - 5) as f32,
                (n_max_patch_vertices_mul_min - 6) as f32,
            ],
        };
        result.push(item_1);
        result.push(item_2);
        result.push(item_3);
    } else {
        let base_values = [-1, 1, n_half_max_patch_vertices_mul_min, n_max_patch_vertices_mul_min];
        let n_base_values = base_values.len();

        let n_relevant_inner_tess_levels = match primitive_mode {
            PrimitiveMode::Isolines => 0,
            PrimitiveMode::Quads => 2,
            PrimitiveMode::Triangles => 1,
        };
        let n_relevant_outer_tess_levels = match primitive_mode {
            PrimitiveMode::Isolines => 2,
            PrimitiveMode::Quads => 4,
            PrimitiveMode::Triangles => 3,
        };
        let count = |relevant: i32, level_index: i32| if relevant > level_index { n_base_values } else { 1 };

        for n_inner0 in 0..count(n_relevant_inner_tess_levels, 0) {
            let inner0_value = base_values[n_inner0];
            for n_inner1 in 0..count(n_relevant_inner_tess_levels, 1) {
                let inner1_value = base_values[n_inner1];
                for n_outer0 in 0..count(n_relevant_outer_tess_levels, 0) {
                    let outer0_value = base_values[n_outer0];
                    for n_outer1 in 0..count(n_relevant_outer_tess_levels, 1) {
                        let outer1_value = base_values[n_outer1];
                        for n_outer2 in 0..count(n_relevant_outer_tess_levels, 2) {
                            let outer2_value = base_values[n_outer2];
                            for n_outer3 in 0..count(n_relevant_outer_tess_levels, 3) {
                                let outer3_value = base_values[n_outer3];

                                // Negative outer levels would cause no tessellation coordinates to be generated.
                                if (n_relevant_outer_tess_levels > 0 && outer0_value < 0)
                                    || (n_relevant_outer_tess_levels > 1 && outer1_value < 0)
                                    || (n_relevant_outer_tess_levels > 2 && outer2_value < 0)
                                    || (n_relevant_outer_tess_levels > 3 && outer3_value < 0)
                                {
                                    continue;
                                }

                                if filter & LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES != 0
                                    && ((n_relevant_inner_tess_levels > 1 && inner0_value == inner1_value)
                                        || (n_relevant_outer_tess_levels > 1 && outer0_value == outer1_value)
                                        || (n_relevant_outer_tess_levels > 2 && outer1_value == outer2_value)
                                        || (n_relevant_outer_tess_levels > 3 && outer2_value == outer3_value))
                                {
                                    continue;
                                }

                                if filter & LEVEL_SET_FILTER_EXCLUDE_NEGATIVE_BASE_VALUE != 0
                                    && ((n_relevant_inner_tess_levels > 0 && inner0_value < 0)
                                        || (n_relevant_inner_tess_levels > 1 && inner1_value < 0)
                                        || (n_relevant_outer_tess_levels > 0 && outer0_value < 0)
                                        || (n_relevant_outer_tess_levels > 1 && outer1_value < 0)
                                        || (n_relevant_outer_tess_levels > 2 && outer2_value < 0)
                                        || (n_relevant_outer_tess_levels > 3 && outer3_value < 0))
                                {
                                    continue;
                                }

                                result.push(TessellationLevels {
                                    inner: [inner0_value as f32, inner1_value as f32],
                                    outer: [
                                        outer0_value as f32,
                                        outer1_value as f32,
                                        outer2_value as f32,
                                        outer3_value as f32,
                                    ],
                                });
                            }
                        }
                    }
                }
            }
        }
    }

    result
}

/// `TessellationShaderUtils::isOuterEdgeVertex`
pub(super) fn is_outer_edge_vertex(primitive_mode: PrimitiveMode, tessellated_vertex_data: &[f32]) -> bool {
    let epsilon = 1e-5_f32;
    let d = tessellated_vertex_data;
    match primitive_mode {
        PrimitiveMode::Triangles => {
            let on_edge = d[0].abs() < epsilon
                || (d[0] - 1.0).abs() < epsilon
                || d[1].abs() < epsilon
                || (d[1] - 1.0).abs() < epsilon
                || d[2].abs() < epsilon
                || (d[2] - 1.0).abs() < epsilon;
            // Make sure vertex is inside the triangle
            on_edge && (0.0..=1.0).contains(&d[0]) && (0.0..=1.0).contains(&d[1]) && (0.0..=1.0).contains(&d[2])
        }
        PrimitiveMode::Quads => {
            d[0].abs() < epsilon || (d[0] - 1.0).abs() < epsilon || d[1].abs() < epsilon || (d[1] - 1.0).abs() < epsilon
        }
        PrimitiveMode::Isolines => panic!("Unrecognized primitive mode"),
    }
}

/// `TessellationShaderUtils::isTriangleDefined`: whether the nine floats of `vertex_data` are the same triangle as `triangle_vertex_data`, in any vertex order.
pub(super) fn is_triangle_defined(triangle_vertex_data: &[f32], vertex_data: &[f32]) -> bool {
    let epsilon = 1e-5_f32;
    let t = triangle_vertex_data;
    let found = |v: usize| {
        (0..3).any(|k| {
            (t[k * 3] - vertex_data[v * 3]).abs() < epsilon
                && (t[k * 3 + 1] - vertex_data[v * 3 + 1]).abs() < epsilon
                && (t[k * 3 + 2] - vertex_data[v * 3 + 2]).abs() < epsilon
        })
    };
    found(0) && found(1) && found(2)
}

/// `TessellationShaderUtils::_tessellation_vertex_counter_program`
struct VertexCounterProgram<'a> {
    gl: &'a glw::Functions,
    data: Vec<u8>,
    n_data_vertices: u32,
    po_id: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
    is_point_mode_enabled: bool,
    n_patch_vertices: GLint,
    primitive_mode: PrimitiveMode,
}

impl Drop for VertexCounterProgram<'_> {
    fn drop(&mut self) {
        // SAFETY: names this program created on the current context.
        unsafe {
            if self.po_id != 0 {
                self.gl.delete_program(self.po_id);
            }
            if self.tc_id != 0 {
                self.gl.delete_shader(self.tc_id);
            }
            if self.te_id != 0 {
                self.gl.delete_shader(self.te_id);
            }
        }
    }
}

/// `glcts::TessellationShaderUtils`
pub(super) struct Utils<'a> {
    context: &'a Context,
    base: &'a TestCaseBase,
    bo_id: GLuint,
    fs_id: GLuint,
    qo_pg_id: GLuint,
    vs_id: GLuint,
}

impl<'a> Utils<'a> {
    /// `TessellationShaderUtils::TessellationShaderUtils` + `init`
    pub fn new(context: &'a Context, base: &'a TestCaseBase) -> Result<Self, TestError> {
        let mut utils = Self {
            context,
            base,
            bo_id: 0,
            fs_id: 0,
            qo_pg_id: 0,
            vs_id: 0,
        };
        utils.init()?;
        Ok(utils)
    }

    fn init(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        if !self.base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl!(gl.gen_buffers(1, &mut self.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        gl!(gl.gen_queries(1, &mut self.qo_pg_id));
        glu::expect_no_error(gl, "glGenQueries() failed")?;

        self.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        self.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        let fs_body = "${VERSION}\n\nvoid main()\n{\n}\n";
        let vs_body = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

        self.shader_source_specialized(self.fs_id, fs_body);
        self.shader_source_specialized(self.vs_id, vs_body);
        glu::expect_no_error(gl, "glShaderSource() failed")?;

        self.compile_shaders(&[self.fs_id, self.vs_id], true)
    }

    fn shader_source_specialized(&self, shader: GLuint, body: &str) {
        let gl = self.context.gl();
        let merged = self.base.specialize_shader(&[body]);
        let pointer = merged.as_ptr().cast::<glw::GLchar>();
        let length = merged.len() as GLint;
        gl!(gl.shader_source(shader, 1, &pointer, &length));
    }

    /// `compileShaders`
    pub fn compile_shaders(&self, shaders: &[GLuint], should_succeed: bool) -> Result<(), TestError> {
        let gl = self.context.gl();
        for &shader in shaders {
            if shader == 0 {
                continue;
            }
            let mut compile_status = glw::GL_FALSE as GLint;

            gl!(gl.compile_shader(shader));
            glu::expect_no_error(gl, "glCompileShader() failed")?;

            gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
            glu::expect_no_error(gl, "glGetShaderiv() failed")?;

            if should_succeed && compile_status != glw::GL_TRUE as GLint {
                let info_log = self.base.get_info_log(self.context, LogType::Shader, shader)?;
                let shader_source = self.base.get_shader_source(self.context, shader)?;
                log::info!("Compilation failure:\n\n{info_log}\n\nSource:\n\n{shader_source}\n\n");
                return Err(TestError::Fail("Shader compilation failed".to_string()));
            } else if !should_succeed && compile_status == glw::GL_TRUE as GLint {
                let shader_source = self.base.get_shader_source(self.context, shader)?;
                log::info!("Compilation failure expected.\nSource:\n\n{shader_source}\n\n");
                return Err(TestError::Fail(
                    "Shader compiled successfully, even though it was expected to fail.".to_string(),
                ));
            }
        }
        Ok(())
    }

    /// `captureTessellationData`
    fn capture_tessellation_data(&self, program: &mut VertexCounterProgram<'_>) -> Result<(), TestError> {
        let gl = self.context.gl();
        let tokens = self.base.gl_ext_tokens;

        let mut current_po_id: GLint = 0;
        gl!(gl.get_integerv(glw::GL_CURRENT_PROGRAM, &mut current_po_id));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_CURRENT_PROGRAM pname")?;

        let mut current_patch_vertices: GLint = 0;
        gl!(gl.get_integerv(glw::GL_PATCH_VERTICES, &mut current_patch_vertices));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_PATCH_VERTICES_EXT pname")?;

        gl!(gl.use_program(program.po_id));
        glu::expect_no_error(gl, "glUseProgram() failed")?;

        gl!(gl.begin_query(tokens.primitives_generated, self.qo_pg_id));
        glu::expect_no_error(
            gl,
            "glBeginQuery() called for target GL_PRIMITIVES_GENERATED_EXT failed",
        )?;

        let is_rasterization_disabled = gl!(gl.is_enabled(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glIsEnabled(GL_RASTERIZER_DISCARD) failed")?;

        if is_rasterization_disabled != 0 {
            gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
            glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed")?;
        }

        gl!(gl.patch_parameteri(tokens.patch_vertices, program.n_patch_vertices));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed")?;

        gl!(gl.draw_arrays(tokens.patches, 0, program.n_patch_vertices));
        glu::expect_no_error(gl, "glDrawArrays() failed")?;

        let mut query_value: GLuint = 0;
        gl!(gl.end_query(tokens.primitives_generated));
        glu::expect_no_error(gl, "glEndQuery(GL_PRIMITIVES_GENERATED_EXT) failed")?;

        gl!(gl.get_query_objectuiv(self.qo_pg_id, glw::GL_QUERY_RESULT, &mut query_value));
        glu::expect_no_error(gl, "glGetQueryiv() failed")?;

        program.n_data_vertices = query_value;

        if !program.is_point_mode_enabled {
            if program.primitive_mode == PrimitiveMode::Quads || program.primitive_mode == PrimitiveMode::Triangles {
                program.n_data_vertices *= 3;
            } else {
                program.n_data_vertices *= 2;
            }
        }

        if program.n_data_vertices != 0 {
            let bo_size = (std::mem::size_of::<f32>() * 3 * program.n_data_vertices as usize) as GLint;

            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id));
            glu::expect_no_error(gl, "glBindBuffer() failed")?;

            gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id));
            glu::expect_no_error(gl, "glBindBufferBase() failed")?;

            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;

            let tf_mode = get_tf_mode_for_primitive_mode(program.primitive_mode, program.is_point_mode_enabled);

            gl!(gl.begin_transform_feedback(tf_mode));
            glu::expect_no_error(gl, "glBeginTransformFeedback() failed")?;

            gl!(gl.draw_arrays(tokens.patches, 0, program.n_patch_vertices));
            glu::expect_no_error(gl, "glDrawArrays() failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

            let xfb_data = gl!(gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                bo_size as isize,
                glw::GL_MAP_READ_BIT
            ));
            glu::expect_no_error(gl, "glMapBufferRange() failed")?;
            if xfb_data.is_null() {
                return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
            }

            // SAFETY: `bo_size` bytes were mapped for reading and the mapping lives until the unmap below.
            program.data = unsafe { std::slice::from_raw_parts(xfb_data.cast::<u8>(), bo_size as usize) }.to_vec();

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "glUnmapBuffer() failed")?;
        }

        if is_rasterization_disabled == 0 {
            gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
            glu::expect_no_error(gl, "glDisable(GL_RASTERIZER_DISCARD) failed")?;
        }

        gl!(gl.use_program(current_po_id as GLuint));
        glu::expect_no_error(gl, "glUseProgram() failed")?;

        gl!(gl.patch_parameteri(tokens.patch_vertices, current_patch_vertices));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed")?;
        Ok(())
    }

    /// `initTessellationVertexCounterProgram`
    fn init_tessellation_vertex_counter_program(
        &self,
        inner_tess_level: &[f32],
        outer_tess_level: &[f32],
        n_patch_vertices: GLint,
        vertex_spacing: VertexSpacing,
        primitive_mode: PrimitiveMode,
        is_point_mode_enabled: bool,
    ) -> Result<VertexCounterProgram<'a>, TestError> {
        let gl = self.context.gl();
        let tokens = self.base.gl_ext_tokens;

        let mut program = VertexCounterProgram {
            gl,
            data: Vec::new(),
            n_data_vertices: 0,
            po_id: 0,
            tc_id: 0,
            te_id: 0,
            is_point_mode_enabled,
            n_patch_vertices,
            primitive_mode,
        };

        program.tc_id = gl!(gl.create_shader(tokens.tess_control_shader));
        program.te_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "Could not create TC/TE shader objects")?;

        program.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "Could not create a program object")?;

        // CCW ordering does not affect the amount of primitives generated by the tessellator.
        let tc_code = get_generic_tc_code(n_patch_vertices as u32, false);
        let te_code = get_generic_te_code(
            vertex_spacing,
            primitive_mode,
            VertexOrdering::Ccw,
            is_point_mode_enabled,
        );

        let varying = CString::new("result_uvw").expect("no nul byte");
        let varyings = [varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(program.po_id, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;

        let (build_success, _) = self.base.build_program(
            self.context,
            program.po_id,
            &[
                ShaderBody::Compiled(self.fs_id),
                ShaderBody::Source(program.tc_id, &[tc_code.as_str()]),
                ShaderBody::Source(program.te_id, &[te_code.as_str()]),
                ShaderBody::Compiled(self.vs_id),
            ],
        )?;
        if !build_success {
            return Err(TestError::Fail("Compilation and/or linking failed".to_string()));
        }

        let inner_name = CString::new("inner_tess_level").expect("no nul byte");
        let outer_name = CString::new("outer_tess_level").expect("no nul byte");
        let inner_tess_level_uniform_location = gl!(gl.get_uniform_location(program.po_id, inner_name.as_ptr()));
        let outer_tess_level_uniform_location = gl!(gl.get_uniform_location(program.po_id, outer_name.as_ptr()));

        gl!(gl.use_program(program.po_id));
        glu::expect_no_error(gl, "glUseProgram() call failed")?;

        gl!(gl.uniform_2fv(inner_tess_level_uniform_location, 1, inner_tess_level.as_ptr()));
        glu::expect_no_error(gl, "glUniform2fv() call failed")?;

        gl!(gl.uniform_4fv(outer_tess_level_uniform_location, 1, outer_tess_level.as_ptr()));
        glu::expect_no_error(gl, "glUniform4fv() call failed")?;

        self.capture_tessellation_data(&mut program)?;
        Ok(program)
    }

    /// `getAmountOfVerticesGeneratedByTessellator`
    pub fn get_amount_of_vertices_generated_by_tessellator(
        &self,
        primitive_mode: PrimitiveMode,
        inner_tessellation_level: &[f32],
        outer_tessellation_level: &[f32],
        vertex_spacing: VertexSpacing,
        is_point_mode_enabled: bool,
    ) -> Result<u32, TestError> {
        let test_n_patch_vertices = 1;
        let test_program = self.init_tessellation_vertex_counter_program(
            inner_tessellation_level,
            outer_tessellation_level,
            test_n_patch_vertices,
            vertex_spacing,
            primitive_mode,
            is_point_mode_enabled,
        )?;
        Ok(test_program.n_data_vertices)
    }

    /// `getDataGeneratedByTessellator`
    pub fn get_data_generated_by_tessellator(
        &self,
        inner: &[f32],
        point_mode: bool,
        primitive_mode: PrimitiveMode,
        _vertex_ordering: VertexOrdering,
        vertex_spacing: VertexSpacing,
        outer: &[f32],
    ) -> Result<Vec<u8>, TestError> {
        let test_n_patch_vertices = get_patch_vertices_for_primitive_mode(primitive_mode);
        let mut test_program = self.init_tessellation_vertex_counter_program(
            inner,
            outer,
            test_n_patch_vertices,
            vertex_spacing,
            primitive_mode,
            point_mode,
        )?;
        Ok(std::mem::take(&mut test_program.data))
    }
}

impl Drop for Utils<'_> {
    /// `deinit`
    fn drop(&mut self) {
        if !self.base.is_tessellation_shader_supported {
            return;
        }
        let gl = self.context.gl();
        // SAFETY: names this helper created, and state resets on the current context.
        unsafe {
            if self.bo_id != 0 {
                gl.delete_buffers(1, &self.bo_id);
            }
            if self.fs_id != 0 {
                gl.delete_shader(self.fs_id);
            }
            if self.qo_pg_id != 0 {
                gl.delete_queries(1, &self.qo_pg_id);
            }
            if self.vs_id != 0 {
                gl.delete_shader(self.vs_id);
            }
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0);
            gl.disable(glw::GL_RASTERIZER_DISCARD);
            gl.patch_parameteri(self.base.gl_ext_tokens.patch_vertices, 3);
        }
    }
}

/// The bytes a transform feedback capture returns, as the floats they hold.
pub(super) fn bytes_to_floats(bytes: &[u8]) -> Vec<f32> {
    bytes
        .chunks_exact(4)
        .map(|chunk| f32::from_ne_bytes(chunk.try_into().expect("four bytes")))
        .collect()
}
