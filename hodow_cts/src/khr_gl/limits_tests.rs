// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cLimitsTests.{hpp,cpp}
//   external/openglcts/modules/common/glcLimitTest.{hpp,inl}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The C++ `LimitCase<DataType>` template and its specializations are one case over a `LimitValue` enum. The rows of the table are extracted from the C++ by `scripts/gen_khr_limits_table.py`. `max_fragment_interpolation_offset` has its boundary adjusted in `iterate` instead of the constructor (the tree here exists before any context does).

use std::ffi::c_void;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const GLSL_VERSION: &str = "450";

/// The value of a limit, whatever its type: the `DataType` template parameter of `LimitCase`.
#[derive(Clone, Copy, Debug, PartialEq)]
enum LimitValue {
    Int(i32),
    Int64(i64),
    Uint64(u64),
    Float(f32),
    IVec3([i32; 3]),
}

impl LimitValue {
    /// `getGLSLDataType`
    fn glsl_data_type(self) -> &'static str {
        match self {
            Self::Float(_) => "float",
            Self::IVec3(_) => "ivec3",
            _ => "int",
        }
    }

    /// `isEqual`
    fn is_equal(self, other: Self) -> bool {
        match (self, other) {
            (Self::IVec3(a), Self::IVec3(b)) => a.iter().zip(b).all(|(a, b)| *a == b),
            (a, b) => a == b,
        }
    }

    /// `isGreater`; for `ivec3` upstream's `boolAll(greaterThan(a, b))`.
    fn is_greater(self, other: Self) -> bool {
        match (self, other) {
            (Self::Int(a), Self::Int(b)) => a > b,
            (Self::Int64(a), Self::Int64(b)) => a > b,
            (Self::Uint64(a), Self::Uint64(b)) => a > b,
            (Self::Float(a), Self::Float(b)) => a > b,
            (Self::IVec3(a), Self::IVec3(b)) => a.iter().zip(b).all(|(a, b)| *a > b),
            _ => unreachable!("a limit and its boundary have the same type"),
        }
    }

    /// `isSmaller`; for `ivec3` upstream's `boolAll(lessThan(a, b))`.
    fn is_smaller(self, other: Self) -> bool {
        match (self, other) {
            (Self::Int(a), Self::Int(b)) => a < b,
            (Self::Int64(a), Self::Int64(b)) => a < b,
            (Self::Uint64(a), Self::Uint64(b)) => a < b,
            (Self::Float(a), Self::Float(b)) => a < b,
            (Self::IVec3(a), Self::IVec3(b)) => a.iter().zip(b).all(|(a, b)| *a < b),
            _ => unreachable!("a limit and its boundary have the same type"),
        }
    }

    /// `sizeof(DataType)`
    fn size(self) -> usize {
        match self {
            Self::Int(_) | Self::Float(_) => 4,
            Self::Int64(_) | Self::Uint64(_) => 8,
            Self::IVec3(_) => 12,
        }
    }

    /// The value of this type read from the first bytes of `bytes`.
    fn read(self, bytes: &[u8]) -> Self {
        let word = |index: usize| -> [u8; 4] { bytes[index * 4..index * 4 + 4].try_into().expect("four bytes") };
        match self {
            Self::Int(_) => Self::Int(i32::from_ne_bytes(word(0))),
            Self::Float(_) => Self::Float(f32::from_ne_bytes(word(0))),
            Self::Int64(_) => Self::Int64(i64::from_ne_bytes(bytes[..8].try_into().expect("eight bytes"))),
            Self::Uint64(_) => Self::Uint64(u64::from_ne_bytes(bytes[..8].try_into().expect("eight bytes"))),
            Self::IVec3(_) => Self::IVec3([
                i32::from_ne_bytes(word(0)),
                i32::from_ne_bytes(word(1)),
                i32::from_ne_bytes(word(2)),
            ]),
        }
    }

    /// `getLimitValue`, for the type of `self`.
    fn query(self, gl: &glw::Functions, token: u32) -> Result<Self, TestError> {
        Ok(match self {
            Self::Int(_) => {
                let mut value: GLint = -1;
                gl_call!(gl, "glGetIntegerv", gl.get_integerv(token, &mut value));
                Self::Int(value)
            }
            Self::Int64(_) => {
                let mut value: i64 = -1;
                gl_call!(gl, "glGetInteger64v", gl.get_integer_64v(token, &mut value));
                Self::Int64(value)
            }
            Self::Uint64(_) => {
                let mut value: i64 = -1;
                gl_call!(gl, "glGetInteger64v", gl.get_integer_64v(token, &mut value));
                Self::Uint64(value as u64)
            }
            Self::Float(_) => {
                let mut value: f32 = -1.0;
                gl_call!(gl, "glGetFloatv", gl.get_floatv(token, &mut value));
                Self::Float(value)
            }
            Self::IVec3(_) => {
                let mut value = [-1i32; 3];
                for (index, lane) in value.iter_mut().enumerate() {
                    // SAFETY: each index is queried into its own element of a 3-element array.
                    unsafe { gl.get_integeri_v(token, index as GLuint, lane) };
                }
                glu::expect_no_error(gl, "glGetIntegeri_v")?;
                Self::IVec3(value)
            }
        })
    }
}

/// `LimitCase<DataType>`
struct LimitCase {
    case_name: &'static str,
    limit_token: u32,
    /// min/max value
    limit_boundary: LimitValue,
    is_boundary_maximum: bool,
    glsl_builtin: &'static str,
}

impl LimitCase {
    /// `adjustBoundaryForMaxFragmentInterpolationOffset`: that limit depends on `GL_FRAGMENT_INTERPOLATION_OFFSET_BITS`.
    fn adjusted_boundary(&self, gl: &glw::Functions) -> Result<LimitValue, TestError> {
        match self.limit_boundary {
            LimitValue::Float(boundary) if self.limit_token == glw::GL_MAX_FRAGMENT_INTERPOLATION_OFFSET => {
                let mut fragment_interpolation_offset_bits: f32 = 0.0;
                gl_call!(
                    gl,
                    "glGetIntegerv",
                    gl.get_floatv(
                        glw::GL_FRAGMENT_INTERPOLATION_OFFSET_BITS,
                        &mut fragment_interpolation_offset_bits
                    )
                );

                let ulp = 1.0 / 2.0f32.powf(fragment_interpolation_offset_bits);
                Ok(LimitValue::Float(boundary - ulp))
            }
            boundary => Ok(boundary),
        }
    }

    /// `isWithinBoundary`
    fn is_within_boundary(&self, boundary: LimitValue, value: LimitValue, is_builtin: bool) -> bool {
        let what = if is_builtin { "Builtin" } else { "Limit" };

        if self.is_boundary_maximum {
            // value should be smaller or equal to boundary
            if value.is_greater(boundary) {
                log::warn!("{what} value is: {value:?} when it should not be greater than {boundary:?}");
                return false;
            }
        } else if value.is_smaller(boundary) {
            // value should be greater or equal to boundary
            log::warn!("{what} value is: {value:?}when it should not be smaller than {boundary:?}");
            return false;
        }

        true
    }

    /// `createShader`
    fn create_shader(&self) -> String {
        format!(
            "#version {GLSL_VERSION}\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout(std430) buffer Output {{\n{} data; }} g_out;void main() {{ g_out.data = {}; }}",
            self.limit_boundary.glsl_data_type(),
            self.glsl_builtin
        )
    }
}

impl TestCase for LimitCase {
    fn name(&self) -> &str {
        self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let boundary = self.adjusted_boundary(gl)?;
        let mut limit_value = boundary;

        // check if limit was specified
        if self.limit_token != 0 {
            // check if limit is not smaller or greater then boundary defined in specification
            limit_value = boundary.query(gl, self.limit_token)?;
            if !self.is_within_boundary(boundary, limit_value, false) {
                return Ok(TestStatus::fail("Fail"));
            }

            // if glsl builtin wasn't defined then test already passed
            if self.glsl_builtin.is_empty() {
                return Ok(TestStatus::pass("Pass"));
            }
        }

        // create compute shader to check glsl builtin
        let program = ShaderProgram::new(gl, &ProgramSources::compute(self.create_shader()));
        if !program.is_ok() {
            log::warn!("{}", program.build_failure_summary().unwrap_or_default());
            return Ok(TestStatus::fail("Fail"));
        }

        // SAFETY: a linked compute program.
        unsafe { gl.use_program(program.program()) };

        let size = boundary.size();
        let mut buffer: GLuint = 0;
        // SAFETY: one buffer name, then an allocation of `size` bytes with no initial data.
        unsafe {
            gl.gen_buffers(1, &mut buffer);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                size as isize,
                std::ptr::null::<c_void>(),
                glw::GL_DYNAMIC_DRAW,
            );
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);

            gl.dispatch_compute(1, 1, 1);

            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
            gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT);
        }

        // SAFETY: the mapped range is exactly the buffer allocated above, copied out before the unmap.
        let builtin_bytes = unsafe {
            let mapped = gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, size as isize, glw::GL_MAP_READ_BIT);
            let bytes = if mapped.is_null() {
                None
            } else {
                Some(std::slice::from_raw_parts(mapped.cast::<u8>(), size).to_vec())
            };
            gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
            gl.delete_buffers(1, &buffer);
            bytes
        };
        let builtin_bytes =
            builtin_bytes.ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
        let builtin_value = boundary.read(&builtin_bytes);

        if self.limit_token != 0 {
            // limit token was specified - compare builtin to it
            if limit_value.is_equal(builtin_value) {
                Ok(TestStatus::pass("Pass"))
            } else {
                log::warn!(
                    "Shader builtin has value: {builtin_value:?} which is different from the value of corresponding limit: {limit_value:?}"
                );
                Ok(TestStatus::fail("Fail"))
            }
        } else if self.is_within_boundary(boundary, builtin_value, true) {
            // limit token was not specified - compare builtin to the boundary
            Ok(TestStatus::pass("Pass"))
        } else {
            log::warn!("Shader builtin value is: {builtin_value:?} which is outside of specified boundary.");
            Ok(TestStatus::fail("Fail"))
        }
    }
}

fn limit(
    case_name: &'static str,
    limit_token: u32,
    limit_boundary: LimitValue,
    is_boundary_maximum: bool,
    glsl_builtin: &'static str,
) -> Box<dyn TestCase> {
    Box::new(LimitCase {
        case_name,
        limit_token,
        limit_boundary,
        is_boundary_maximum,
        glsl_builtin,
    })
}

/// `LimitsTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("limits");

    let cases: Vec<Box<dyn TestCase>> = vec![
        limit(
            "max_clip_distances",
            glw::GL_MAX_CLIP_DISTANCES,
            LimitValue::Int(8),
            false,
            "gl_MaxClipDistances",
        ),
        limit(
            "max_cull_distances",
            glw::GL_MAX_CULL_DISTANCES,
            LimitValue::Int(8),
            false,
            "gl_MaxCullDistances",
        ),
        limit(
            "max_combined_clip_and_cull_distances",
            glw::GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES,
            LimitValue::Int(8),
            false,
            "gl_MaxCombinedClipAndCullDistances",
        ),
        limit(
            "max_3d_texture_size",
            glw::GL_MAX_3D_TEXTURE_SIZE,
            LimitValue::Int(2048),
            false,
            "",
        ),
        limit(
            "max_texture_size",
            glw::GL_MAX_TEXTURE_SIZE,
            LimitValue::Int(16384),
            false,
            "",
        ),
        limit(
            "max_array_texture_layers",
            glw::GL_MAX_ARRAY_TEXTURE_LAYERS,
            LimitValue::Int(2048),
            false,
            "",
        ),
        limit(
            "max_cube_map_texture_size",
            glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE,
            LimitValue::Int(16384),
            false,
            "",
        ),
        limit(
            "max_renderbuffer_size",
            glw::GL_MAX_RENDERBUFFER_SIZE,
            LimitValue::Int(16384),
            false,
            "",
        ),
        limit(
            "max_viewports",
            glw::GL_MAX_VIEWPORTS,
            LimitValue::Int(16),
            false,
            "gl_MaxViewports",
        ),
        limit(
            "max_elements_indices",
            glw::GL_MAX_ELEMENTS_INDICES,
            LimitValue::Int(0),
            false,
            "",
        ),
        limit(
            "max_elements_vertices",
            glw::GL_MAX_ELEMENTS_VERTICES,
            LimitValue::Int(0),
            false,
            "",
        ),
        limit(
            "max_vertex_attrib_relative_offset",
            glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET,
            LimitValue::Int(2047),
            false,
            "",
        ),
        limit(
            "max_vertex_attrib_bindings",
            glw::GL_MAX_VERTEX_ATTRIB_BINDINGS,
            LimitValue::Int(16),
            false,
            "",
        ),
        limit(
            "max_vertex_attrib_stride",
            glw::GL_MAX_VERTEX_ATTRIB_STRIDE,
            LimitValue::Int(2048),
            false,
            "",
        ),
        limit(
            "max_texture_buffer_size",
            glw::GL_MAX_TEXTURE_BUFFER_SIZE,
            LimitValue::Int(65536),
            false,
            "",
        ),
        limit(
            "max_rectangle_texture_size",
            glw::GL_MAX_RECTANGLE_TEXTURE_SIZE,
            LimitValue::Int(16384),
            false,
            "",
        ),
        limit(
            "min_map_buffer_alignment",
            glw::GL_MIN_MAP_BUFFER_ALIGNMENT,
            LimitValue::Int(64),
            false,
            "",
        ),
        limit(
            "max_vertex_attribs",
            glw::GL_MAX_VERTEX_ATTRIBS,
            LimitValue::Int(16),
            false,
            "gl_MaxVertexAttribs",
        ),
        limit(
            "max_vertex_uniform_components",
            glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS,
            LimitValue::Int(1024),
            false,
            "gl_MaxVertexUniformComponents",
        ),
        limit(
            "max_vertex_uniform_vectors",
            glw::GL_MAX_VERTEX_UNIFORM_VECTORS,
            LimitValue::Int(256),
            false,
            "gl_MaxVertexUniformVectors",
        ),
        limit(
            "max_vertex_uniform_blocks",
            glw::GL_MAX_VERTEX_UNIFORM_BLOCKS,
            LimitValue::Int(14),
            false,
            "",
        ),
        limit(
            "max_vertex_output_components",
            glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS,
            LimitValue::Int(64),
            false,
            "gl_MaxVertexOutputComponents",
        ),
        limit(
            "max_vertex_texture_image_units",
            glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
            LimitValue::Int(16),
            false,
            "gl_MaxVertexTextureImageUnits",
        ),
        limit(
            "max_vertex_atomic_counter_buffers",
            glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS,
            LimitValue::Int(0),
            false,
            "gl_MaxVertexAtomicCounterBuffers",
        ),
        limit(
            "max_vertex_atomic_counters",
            glw::GL_MAX_VERTEX_ATOMIC_COUNTERS,
            LimitValue::Int(0),
            false,
            "gl_MaxVertexAtomicCounters",
        ),
        limit(
            "max_vertex_shader_storage_blocks",
            glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS,
            LimitValue::Int(0),
            false,
            "",
        ),
        limit(
            "max_tess_gen_level",
            glw::GL_MAX_TESS_GEN_LEVEL,
            LimitValue::Int(64),
            false,
            "gl_MaxTessGenLevel",
        ),
        limit(
            "max_patch_vertices",
            glw::GL_MAX_PATCH_VERTICES,
            LimitValue::Int(32),
            false,
            "gl_MaxPatchVertices",
        ),
        limit(
            "max_tess_control_uniform_components",
            glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS,
            LimitValue::Int(1024),
            false,
            "gl_MaxTessControlUniformComponents",
        ),
        limit(
            "max_tess_control_texture_image_units",
            glw::GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS,
            LimitValue::Int(16),
            false,
            "gl_MaxTessControlTextureImageUnits",
        ),
        limit(
            "max_tess_control_output_components",
            glw::GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS,
            LimitValue::Int(128),
            false,
            "gl_MaxTessControlOutputComponents",
        ),
        limit(
            "max_tess_patch_components",
            glw::GL_MAX_TESS_PATCH_COMPONENTS,
            LimitValue::Int(120),
            false,
            "gl_MaxTessPatchComponents",
        ),
        limit(
            "max_tess_control_total_output_components",
            glw::GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS,
            LimitValue::Int(4096),
            false,
            "gl_MaxTessControlTotalOutputComponents",
        ),
        limit(
            "max_tess_control_input_components",
            glw::GL_MAX_TESS_CONTROL_INPUT_COMPONENTS,
            LimitValue::Int(128),
            false,
            "gl_MaxTessControlInputComponents",
        ),
        limit(
            "max_tess_control_uniform_blocks",
            glw::GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS,
            LimitValue::Int(14),
            false,
            "",
        ),
        limit(
            "max_tess_control_atomic_counter_buffers",
            glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS,
            LimitValue::Int(0),
            false,
            "gl_MaxTessControlAtomicCounterBuffers",
        ),
        limit(
            "max_tess_control_atomic_counters",
            glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS,
            LimitValue::Int(0),
            false,
            "gl_MaxTessControlAtomicCounters",
        ),
        limit(
            "max_tess_control_shader_storage_blocks",
            glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS,
            LimitValue::Int(0),
            false,
            "",
        ),
        limit(
            "max_tess_evaluation_uniform_components",
            glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS,
            LimitValue::Int(1024),
            false,
            "gl_MaxTessEvaluationUniformComponents",
        ),
        limit(
            "max_tess_evaluation_texture_image_units",
            glw::GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS,
            LimitValue::Int(16),
            false,
            "gl_MaxTessEvaluationTextureImageUnits",
        ),
        limit(
            "max_tess_evaluation_output_components",
            glw::GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS,
            LimitValue::Int(128),
            false,
            "gl_MaxTessEvaluationOutputComponents",
        ),
        limit(
            "max_tess_evaluation_input_components",
            glw::GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS,
            LimitValue::Int(128),
            false,
            "gl_MaxTessEvaluationInputComponents",
        ),
        limit(
            "max_tess_evaluation_uniform_blocks",
            glw::GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS,
            LimitValue::Int(14),
            false,
            "",
        ),
        limit(
            "max_tess_evaluation_atomic_counter_buffers",
            glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS,
            LimitValue::Int(0),
            false,
            "gl_MaxTessEvaluationAtomicCounterBuffers",
        ),
        limit(
            "max_tess_evaluation_atomic_counters",
            glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS,
            LimitValue::Int(0),
            false,
            "gl_MaxTessEvaluationAtomicCounters",
        ),
        limit(
            "max_tess_evaluation_shader_storage_blocks",
            glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS,
            LimitValue::Int(0),
            false,
            "",
        ),
        limit(
            "max_geometry_uniform_components",
            glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS,
            LimitValue::Int(1024),
            false,
            "gl_MaxGeometryUniformComponents",
        ),
        limit(
            "max_geometry_uniform_blocks",
            glw::GL_MAX_GEOMETRY_UNIFORM_BLOCKS,
            LimitValue::Int(14),
            false,
            "",
        ),
        limit(
            "max_geometry_input_components",
            glw::GL_MAX_GEOMETRY_INPUT_COMPONENTS,
            LimitValue::Int(64),
            false,
            "gl_MaxGeometryInputComponents",
        ),
        limit(
            "max_geometry_output_components",
            glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS,
            LimitValue::Int(128),
            false,
            "gl_MaxGeometryOutputComponents",
        ),
        limit(
            "max_geometry_output_vertices",
            glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES,
            LimitValue::Int(256),
            false,
            "gl_MaxGeometryOutputVertices",
        ),
        limit(
            "max_geometry_total_output_components",
            glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS,
            LimitValue::Int(1024),
            false,
            "gl_MaxGeometryTotalOutputComponents",
        ),
        limit(
            "max_geometry_texture_image_units",
            glw::GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS,
            LimitValue::Int(16),
            false,
            "gl_MaxGeometryTextureImageUnits",
        ),
        limit(
            "max_geometry_shader_invocations",
            glw::GL_MAX_GEOMETRY_SHADER_INVOCATIONS,
            LimitValue::Int(32),
            false,
            "",
        ),
        limit(
            "max_vertex_streams",
            glw::GL_MAX_VERTEX_STREAMS,
            LimitValue::Int(4),
            false,
            "",
        ),
        limit(
            "max_geometry_atomic_counter_buffers",
            glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS,
            LimitValue::Int(0),
            false,
            "gl_MaxGeometryAtomicCounterBuffers",
        ),
        limit(
            "max_geometry_atomic_counters",
            glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS,
            LimitValue::Int(0),
            false,
            "gl_MaxGeometryAtomicCounters",
        ),
        limit(
            "max_geometry_shader_storage_blocks",
            glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS,
            LimitValue::Int(0),
            false,
            "",
        ),
        limit(
            "max_fragment_uniform_components",
            glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
            LimitValue::Int(1024),
            false,
            "gl_MaxFragmentUniformComponents",
        ),
        limit(
            "max_fragment_uniform_vectors",
            glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS,
            LimitValue::Int(256),
            false,
            "gl_MaxFragmentUniformVectors",
        ),
        limit(
            "max_fragment_uniform_blocks",
            glw::GL_MAX_FRAGMENT_UNIFORM_BLOCKS,
            LimitValue::Int(14),
            false,
            "",
        ),
        limit(
            "max_fragment_input_components",
            glw::GL_MAX_FRAGMENT_INPUT_COMPONENTS,
            LimitValue::Int(128),
            false,
            "gl_MaxFragmentInputComponents",
        ),
        limit(
            "max_texture_image_units",
            glw::GL_MAX_TEXTURE_IMAGE_UNITS,
            LimitValue::Int(16),
            false,
            "gl_MaxTextureImageUnits",
        ),
        limit(
            "min_program_texture_gather_offset",
            glw::GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET,
            LimitValue::Int(-8),
            true,
            "",
        ),
        limit(
            "max_program_texture_gather_offset",
            glw::GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET,
            LimitValue::Int(7),
            false,
            "",
        ),
        limit(
            "max_fragment_atomic_counter_buffers",
            glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS,
            LimitValue::Int(1),
            false,
            "gl_MaxFragmentAtomicCounterBuffers",
        ),
        limit(
            "max_fragment_atomic_counters",
            glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS,
            LimitValue::Int(8),
            false,
            "gl_MaxFragmentAtomicCounters",
        ),
        limit(
            "max_fragment_shader_storage_blocks",
            glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS,
            LimitValue::Int(8),
            false,
            "",
        ),
        limit(
            "max_compute_work_group_invocations",
            glw::GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS,
            LimitValue::Int(1024),
            false,
            "",
        ),
        limit(
            "max_compute_uniform_blocks",
            glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS,
            LimitValue::Int(14),
            false,
            "",
        ),
        limit(
            "max_compute_texture_image_units",
            glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS,
            LimitValue::Int(16),
            false,
            "gl_MaxComputeTextureImageUnits",
        ),
        limit(
            "max_compute_atomic_counter_buffers",
            glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS,
            LimitValue::Int(8),
            false,
            "gl_MaxComputeAtomicCounterBuffers",
        ),
        limit(
            "max_compute_atomic_counters",
            glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS,
            LimitValue::Int(8),
            false,
            "gl_MaxComputeAtomicCounters",
        ),
        limit(
            "max_compute_shared_memory_size",
            glw::GL_MAX_COMPUTE_SHARED_MEMORY_SIZE,
            LimitValue::Int(32768),
            false,
            "",
        ),
        limit(
            "max_compute_uniform_components",
            glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS,
            LimitValue::Int(1024),
            false,
            "gl_MaxComputeUniformComponents",
        ),
        limit(
            "max_compute_image_uniforms",
            glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS,
            LimitValue::Int(8),
            false,
            "gl_MaxComputeImageUniforms",
        ),
        limit(
            "max_combined_compute_uniform_components",
            glw::GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS,
            LimitValue::Int(0),
            false,
            "",
        ),
        limit(
            "max_compute_shader_storage_blocks",
            glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS,
            LimitValue::Int(8),
            false,
            "",
        ),
        limit(
            "min_program_texel_offset",
            glw::GL_MIN_PROGRAM_TEXEL_OFFSET,
            LimitValue::Int(-8),
            true,
            "gl_MinProgramTexelOffset",
        ),
        limit(
            "max_program_texel_offset",
            glw::GL_MAX_PROGRAM_TEXEL_OFFSET,
            LimitValue::Int(7),
            false,
            "gl_MaxProgramTexelOffset",
        ),
        limit(
            "max_uniform_buffer_bindings",
            glw::GL_MAX_UNIFORM_BUFFER_BINDINGS,
            LimitValue::Int(84),
            false,
            "",
        ),
        limit(
            "max_uniform_block_size",
            glw::GL_MAX_UNIFORM_BLOCK_SIZE,
            LimitValue::Int(16384),
            false,
            "",
        ),
        limit(
            "max_combined_uniform_blocks",
            glw::GL_MAX_COMBINED_UNIFORM_BLOCKS,
            LimitValue::Int(70),
            false,
            "",
        ),
        limit(
            "max_varying_components",
            glw::GL_MAX_VARYING_COMPONENTS,
            LimitValue::Int(60),
            false,
            "gl_MaxVaryingComponents",
        ),
        limit(
            "max_varying_vectors",
            glw::GL_MAX_VARYING_VECTORS,
            LimitValue::Int(15),
            false,
            "gl_MaxVaryingVectors",
        ),
        limit(
            "max_combined_texture_image_units",
            glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
            LimitValue::Int(80),
            false,
            "gl_MaxCombinedTextureImageUnits",
        ),
        limit(
            "max_subroutines",
            glw::GL_MAX_SUBROUTINES,
            LimitValue::Int(256),
            false,
            "",
        ),
        limit(
            "max_subroutine_uniform_locations",
            glw::GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS,
            LimitValue::Int(1024),
            false,
            "",
        ),
        limit(
            "max_uniform_locations",
            glw::GL_MAX_UNIFORM_LOCATIONS,
            LimitValue::Int(1024),
            false,
            "",
        ),
        limit(
            "max_atomic_counter_buffer_bindings",
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_atomic_counter_buffer_size",
            glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE,
            LimitValue::Int(32),
            false,
            "gl_MaxAtomicCounterBufferSize",
        ),
        limit(
            "max_combined_atomic_counter_buffers",
            glw::GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS,
            LimitValue::Int(1),
            false,
            "gl_MaxCombinedAtomicCounterBuffers",
        ),
        limit(
            "max_combined_atomic_counters",
            glw::GL_MAX_COMBINED_ATOMIC_COUNTERS,
            LimitValue::Int(8),
            false,
            "gl_MaxCombinedAtomicCounters",
        ),
        limit(
            "max_shader_storage_buffer_bindings",
            glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
            LimitValue::Int(8),
            false,
            "",
        ),
        limit(
            "max_combined_shader_storage_blocks",
            glw::GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS,
            LimitValue::Int(8),
            false,
            "",
        ),
        limit(
            "max_image_units",
            glw::GL_MAX_IMAGE_UNITS,
            LimitValue::Int(8),
            false,
            "gl_MaxImageUnits",
        ),
        limit(
            "max_combined_shader_output_resources",
            glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES,
            LimitValue::Int(8),
            false,
            "gl_MaxCombinedShaderOutputResources",
        ),
        limit(
            "max_image_samples",
            glw::GL_MAX_IMAGE_SAMPLES,
            LimitValue::Int(0),
            false,
            "gl_MaxImageSamples",
        ),
        limit(
            "max_vertex_image_uniforms",
            glw::GL_MAX_VERTEX_IMAGE_UNIFORMS,
            LimitValue::Int(0),
            false,
            "gl_MaxVertexImageUniforms",
        ),
        limit(
            "max_tess_control_image_uniforms",
            glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS,
            LimitValue::Int(0),
            false,
            "gl_MaxTessControlImageUniforms",
        ),
        limit(
            "max_tess_evaluation_image_uniforms",
            glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS,
            LimitValue::Int(0),
            false,
            "gl_MaxTessEvaluationImageUniforms",
        ),
        limit(
            "max_geometry_image_uniforms",
            glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS,
            LimitValue::Int(0),
            false,
            "gl_MaxGeometryImageUniforms",
        ),
        limit(
            "max_fragment_image_uniforms",
            glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS,
            LimitValue::Int(8),
            false,
            "gl_MaxFragmentImageUniforms",
        ),
        limit(
            "max_combined_image_uniforms",
            glw::GL_MAX_COMBINED_IMAGE_UNIFORMS,
            LimitValue::Int(8),
            false,
            "gl_MaxCombinedImageUniforms",
        ),
        limit(
            "max_combined_vertex_uniform_components",
            glw::GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS,
            LimitValue::Int(58368),
            false,
            "",
        ),
        limit(
            "max_combined_geometry_uniform_components",
            glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS,
            LimitValue::Int(58368),
            false,
            "",
        ),
        limit(
            "max_combined_tess_control_uniform_components",
            glw::GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS,
            LimitValue::Int(58368),
            false,
            "",
        ),
        limit(
            "max_combined_tess_evaluation_uniform_components",
            glw::GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS,
            LimitValue::Int(58368),
            false,
            "",
        ),
        limit(
            "max_combined_fragment_uniform_components",
            glw::GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS,
            LimitValue::Int(58368),
            false,
            "",
        ),
        limit(
            "max_debug_message_length",
            glw::GL_MAX_DEBUG_MESSAGE_LENGTH,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_debug_logged_messages",
            glw::GL_MAX_DEBUG_LOGGED_MESSAGES,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_debug_group_stack_depth",
            glw::GL_MAX_DEBUG_GROUP_STACK_DEPTH,
            LimitValue::Int(64),
            false,
            "",
        ),
        limit(
            "max_label_length",
            glw::GL_MAX_LABEL_LENGTH,
            LimitValue::Int(256),
            false,
            "",
        ),
        limit(
            "max_framebuffer_width",
            glw::GL_MAX_FRAMEBUFFER_WIDTH,
            LimitValue::Int(16384),
            false,
            "",
        ),
        limit(
            "max_framebuffer_height",
            glw::GL_MAX_FRAMEBUFFER_HEIGHT,
            LimitValue::Int(16384),
            false,
            "",
        ),
        limit(
            "max_framebuffer_layers",
            glw::GL_MAX_FRAMEBUFFER_LAYERS,
            LimitValue::Int(2048),
            false,
            "",
        ),
        limit(
            "max_framebuffer_samples",
            glw::GL_MAX_FRAMEBUFFER_SAMPLES,
            LimitValue::Int(4),
            false,
            "",
        ),
        limit(
            "max_sample_mask_words",
            glw::GL_MAX_SAMPLE_MASK_WORDS,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_samples",
            glw::GL_MAX_SAMPLES,
            LimitValue::Int(4),
            false,
            "gl_MaxSamples",
        ),
        limit(
            "max_color_texture_samples",
            glw::GL_MAX_COLOR_TEXTURE_SAMPLES,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_depth_texture_samples",
            glw::GL_MAX_DEPTH_TEXTURE_SAMPLES,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_integer_samples",
            glw::GL_MAX_INTEGER_SAMPLES,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_draw_buffers",
            glw::GL_MAX_DRAW_BUFFERS,
            LimitValue::Int(8),
            false,
            "gl_MaxDrawBuffers",
        ),
        limit(
            "max_dual_source_draw_buffers",
            glw::GL_MAX_DUAL_SOURCE_DRAW_BUFFERS,
            LimitValue::Int(1),
            false,
            "",
        ),
        limit(
            "max_color_attachments",
            glw::GL_MAX_COLOR_ATTACHMENTS,
            LimitValue::Int(8),
            false,
            "",
        ),
        limit(
            "max_transform_feedback_interleaved_components",
            glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
            LimitValue::Int(64),
            false,
            "gl_MaxTransformFeedbackInterleavedComponents",
        ),
        limit(
            "max_transform_feedback_separate_attribs",
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
            LimitValue::Int(4),
            false,
            "",
        ),
        limit(
            "max_transform_feedback_separate_components",
            glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
            LimitValue::Int(4),
            false,
            "",
        ),
        limit(
            "max_transform_feedback_buffers",
            glw::GL_MAX_TRANSFORM_FEEDBACK_BUFFERS,
            LimitValue::Int(4),
            false,
            "gl_MaxTransformFeedbackBuffers",
        ),
        limit(
            "max_atomic_counter_bindings",
            0,
            LimitValue::Int(4),
            false,
            "gl_MaxAtomicCounterBindings",
        ),
        limit(
            "max_combined_image_units_and_fragment_outputs",
            0,
            LimitValue::Int(4),
            false,
            "gl_MaxCombinedImageUnitsAndFragmentOutputs",
        ),
        limit(
            "max_geometry_varying_components",
            0,
            LimitValue::Int(4),
            false,
            "gl_MaxGeometryVaryingComponents",
        ),
        limit(
            "max_shader_storage_block_size",
            glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE,
            LimitValue::Int64(134217728),
            false,
            "",
        ),
        limit(
            "max_element_index",
            glw::GL_MAX_ELEMENT_INDEX,
            LimitValue::Int64(4294967295),
            false,
            "",
        ),
        limit(
            "max_server_wait_timeout",
            glw::GL_MAX_SERVER_WAIT_TIMEOUT,
            LimitValue::Uint64(0),
            false,
            "",
        ),
        limit(
            "max_texture_lod_bias",
            glw::GL_MAX_TEXTURE_LOD_BIAS,
            LimitValue::Float(2.0),
            false,
            "",
        ),
        limit(
            "min_fragment_interpolation_offset",
            glw::GL_MIN_FRAGMENT_INTERPOLATION_OFFSET,
            LimitValue::Float(-0.5),
            true,
            "",
        ),
        limit(
            "max_fragment_interpolation_offset",
            glw::GL_MAX_FRAGMENT_INTERPOLATION_OFFSET,
            LimitValue::Float(0.5),
            false,
            "",
        ),
        limit(
            "max_compute_work_group_count",
            glw::GL_MAX_COMPUTE_WORK_GROUP_COUNT,
            LimitValue::IVec3([65535, 65535, 65535]),
            false,
            "gl_MaxComputeWorkGroupCount",
        ),
        limit(
            "max_compute_work_group_size",
            glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE,
            LimitValue::IVec3([1024, 1024, 64]),
            false,
            "gl_MaxComputeWorkGroupSize",
        ),
    ];

    for case in cases {
        group.add_child(case);
    }
    group
}
