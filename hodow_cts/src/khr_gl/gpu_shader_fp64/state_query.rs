// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test4)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The six `_stage_data` members are an array in upstream's stage order (cs, fs, gs, tc, te, vs), the pointer lists of `generateUniformValues` and the uniform/value pair tables are functions over the stage's `Data`, and the object clean-up is `Drop`. The shader bodies are generated (scripts/gen_khr_fp64_state_query_shaders.py). Upstream quirk kept: the "array[1].struct_*" entries of the program interface query table read the location of `uniform_structure_arrays[0]`.

use std::ffi::{CString, c_char};

use super::state_query_shaders::{CS_BODY, FS_BODY, GS_BODY, TC_BODY, TE_BODY, VS_BODY};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const CS: usize = 0;
const FS: usize = 1;
const GS: usize = 2;
const TC: usize = 3;
const TE: usize = 4;
const VS: usize = 5;

const NONCS_STAGES: [usize; 5] = [FS, GS, TC, TE, VS];
const NONCS_PREFIXES: [&str; 5] = ["fs_", "gs_", "tc_", "te_", "vs_"];

/// `_data`
#[derive(Clone)]
struct Data {
    uniform_double: f64,
    uniform_double_arr: [f64; 2],
    uniform_dvec2: [f64; 2],
    uniform_dvec2_arr: [f64; 4],
    uniform_dvec3: [f64; 3],
    uniform_dvec3_arr: [f64; 6],
    uniform_dvec4: [f64; 4],
    uniform_dvec4_arr: [f64; 8],
    uniform_location_double: GLint,
    uniform_location_double_arr: [GLint; 2],
    uniform_location_dvec2: GLint,
    uniform_location_dvec2_arr: [GLint; 2],
    uniform_location_dvec3: GLint,
    uniform_location_dvec3_arr: [GLint; 2],
    uniform_location_dvec4: GLint,
    uniform_location_dvec4_arr: [GLint; 2],
}

impl Default for Data {
    /// `_data::_data`: all locations -1, all values 0
    fn default() -> Self {
        Self {
            uniform_double: 0.0,
            uniform_double_arr: [0.0; 2],
            uniform_dvec2: [0.0; 2],
            uniform_dvec2_arr: [0.0; 4],
            uniform_dvec3: [0.0; 3],
            uniform_dvec3_arr: [0.0; 6],
            uniform_dvec4: [0.0; 4],
            uniform_dvec4_arr: [0.0; 8],
            uniform_location_double: -1,
            uniform_location_double_arr: [-1; 2],
            uniform_location_dvec2: -1,
            uniform_location_dvec2_arr: [-1; 2],
            uniform_location_dvec3: -1,
            uniform_location_dvec3_arr: [-1; 2],
            uniform_location_dvec4: -1,
            uniform_location_dvec4_arr: [-1; 2],
        }
    }
}

impl Data {
    /// The values `generateUniformValues` assigns to a structure array element, in upstream's order.
    fn structure_values_mut(&mut self) -> Vec<&mut f64> {
        let mut values: Vec<&mut f64> = vec![&mut self.uniform_double];
        values.extend(self.uniform_double_arr.iter_mut());
        values.extend(self.uniform_dvec2.iter_mut());
        values.extend(self.uniform_dvec3.iter_mut());
        values.extend(self.uniform_dvec4.iter_mut());
        values
    }

    /// The values `generateUniformValues` assigns to the plain uniforms, in upstream's order.
    fn uniform_values_mut(&mut self) -> Vec<&mut f64> {
        let mut values: Vec<&mut f64> = vec![&mut self.uniform_double];
        values.extend(self.uniform_double_arr.iter_mut());
        values.extend(self.uniform_dvec2.iter_mut());
        values.extend(self.uniform_dvec2_arr.iter_mut());
        values.extend(self.uniform_dvec3.iter_mut());
        values.extend(self.uniform_dvec3_arr.iter_mut());
        values.extend(self.uniform_dvec4.iter_mut());
        values.extend(self.uniform_dvec4_arr.iter_mut());
        values
    }
}

/// `_stage_data`
#[derive(Clone, Default)]
struct StageData {
    uniform_structure_arrays: [Data; 2],
    uniforms: Data,
}

/// `uniform_value_pair`s of one component count for one stage: double, double_arr[0], double_arr[1] and the two structure array elements.
fn uniform_value_pairs(stage: &StageData, n_type: usize) -> [(GLint, &[f64]); 5] {
    let uniforms = &stage.uniforms;
    let [first, second] = &stage.uniform_structure_arrays;
    match n_type {
        0 => [
            (
                uniforms.uniform_location_double,
                std::slice::from_ref(&uniforms.uniform_double),
            ),
            (
                uniforms.uniform_location_double_arr[0],
                &uniforms.uniform_double_arr[0..1],
            ),
            (
                uniforms.uniform_location_double_arr[1],
                &uniforms.uniform_double_arr[1..2],
            ),
            (
                first.uniform_location_double,
                std::slice::from_ref(&first.uniform_double),
            ),
            (
                second.uniform_location_double,
                std::slice::from_ref(&second.uniform_double),
            ),
        ],
        1 => [
            (uniforms.uniform_location_dvec2, &uniforms.uniform_dvec2[..]),
            (
                uniforms.uniform_location_dvec2_arr[0],
                &uniforms.uniform_dvec2_arr[0..2],
            ),
            (
                uniforms.uniform_location_dvec2_arr[1],
                &uniforms.uniform_dvec2_arr[2..4],
            ),
            (first.uniform_location_dvec2, &first.uniform_dvec2[..]),
            (second.uniform_location_dvec2, &second.uniform_dvec2[..]),
        ],
        2 => [
            (uniforms.uniform_location_dvec3, &uniforms.uniform_dvec3[..]),
            (
                uniforms.uniform_location_dvec3_arr[0],
                &uniforms.uniform_dvec3_arr[0..3],
            ),
            (
                uniforms.uniform_location_dvec3_arr[1],
                &uniforms.uniform_dvec3_arr[3..6],
            ),
            (first.uniform_location_dvec3, &first.uniform_dvec3[..]),
            (second.uniform_location_dvec3, &second.uniform_dvec3[..]),
        ],
        _ => [
            (uniforms.uniform_location_dvec4, &uniforms.uniform_dvec4[..]),
            (
                uniforms.uniform_location_dvec4_arr[0],
                &uniforms.uniform_dvec4_arr[0..4],
            ),
            (
                uniforms.uniform_location_dvec4_arr[1],
                &uniforms.uniform_dvec4_arr[4..8],
            ),
            (first.uniform_location_dvec4, &first.uniform_dvec4[..]),
            (second.uniform_location_dvec4, &second.uniform_dvec4[..]),
        ],
    }
}

/// The objects and data of `GPUShaderFP64Test4`; `deinit` is `Drop`.
struct State<'a> {
    gl: &'a glw::Functions,
    shader_ids: [GLuint; 6],
    po_cs_id: GLuint,
    po_noncs_id: GLuint,
    data: [StageData; 6],
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        for id in self.shader_ids {
            if id != 0 {
                gl!(gl.delete_shader(id));
            }
        }
        for id in [self.po_cs_id, self.po_noncs_id] {
            if id != 0 {
                gl!(gl.delete_program(id));
            }
        }
    }
}

impl<'a> State<'a> {
    /// `initProgramObjects`
    fn init_program_objects(context: &'a Context) -> Result<Self, TestError> {
        let gl = context.gl();
        let mut state = Self {
            gl,
            shader_ids: [0; 6],
            po_cs_id: 0,
            po_noncs_id: 0,
            data: Default::default(),
        };

        // Compute shader support and GL 4.2 required
        if context.context_info.is_extension_supported("GL_ARB_compute_shader")
            && context.context_type().supports_core(4, 2)
        {
            state.shader_ids[CS] = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        }
        state.shader_ids[FS] = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        state.shader_ids[GS] = gl!(gl.create_shader(glw::GL_GEOMETRY_SHADER));
        state.shader_ids[TC] = gl!(gl.create_shader(glw::GL_TESS_CONTROL_SHADER));
        state.shader_ids[TE] = gl!(gl.create_shader(glw::GL_TESS_EVALUATION_SHADER));
        state.shader_ids[VS] = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader")?;

        if state.shader_ids[CS] != 0 {
            state.po_cs_id = gl!(gl.create_program());
        }
        state.po_noncs_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram")?;

        let bodies = [CS_BODY, FS_BODY, GS_BODY, TC_BODY, TE_BODY, VS_BODY];
        for (id, body) in state.shader_ids.iter().zip(bodies) {
            // m_cs_id is initialized only if compute shaders are supported
            if *id == 0 {
                continue;
            }
            let source = CString::new(body).expect("shader source holds no nul byte");
            let sources = [source.as_ptr()];
            gl_call!(
                gl,
                "glShaderSource",
                gl.shader_source(*id, 1, sources.as_ptr(), std::ptr::null())
            );
        }

        for (stage, &so_id) in state.shader_ids.iter().enumerate() {
            let mut compile_status: GLint = glw::GL_FALSE as GLint;

            // Skip compute shader if not supported
            if so_id == 0 {
                continue;
            }

            gl_call!(gl, "glCompileShader", gl.compile_shader(so_id));
            gl_call!(
                gl,
                "glGetShaderiv",
                gl.get_shaderiv(so_id, glw::GL_COMPILE_STATUS, &mut compile_status)
            );
            if compile_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail("Shader compilation failed".to_string()));
            }

            let po_id = if stage == CS { state.po_cs_id } else { state.po_noncs_id };
            gl_call!(gl, "glAttachShader", gl.attach_shader(po_id, so_id));
        }

        for po_id in [state.po_cs_id, state.po_noncs_id] {
            let mut link_status: GLint = glw::GL_FALSE as GLint;

            // Skip compute shader program if not supported
            if po_id == 0 {
                continue;
            }

            gl_call!(gl, "glLinkProgram", gl.link_program(po_id));
            gl_call!(
                gl,
                "glGetProgramiv",
                gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut link_status)
            );
            if link_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail("Program linking failed".to_string()));
            }
        }

        for (po_id, stages, prefixes) in [
            (state.po_cs_id, &[CS][..], &["cs_"][..]),
            (state.po_noncs_id, &NONCS_STAGES[..], &NONCS_PREFIXES[..]),
        ] {
            // Skip compute shader program if not supported
            if po_id == 0 {
                continue;
            }

            for (&stage, prefix) in stages.iter().zip(prefixes) {
                state.retrieve_uniform_locations(po_id, stage, prefix)?;
            }
        }

        Ok(state)
    }

    /// The location queries of `initProgramObjects`, for one stage's uniform prefix
    fn retrieve_uniform_locations(&mut self, po_id: GLuint, stage: usize, prefix: &str) -> Result<(), TestError> {
        let gl = self.gl;
        let locate = |name: String| -> Result<GLint, TestError> {
            let name = CString::new(format!("{prefix}{name}")).expect("no nul byte");
            let location = gl!(gl.get_uniform_location(po_id, name.as_ptr()));
            glu::expect_no_error(gl, "glGetUniformLocation")?;
            Ok(location)
        };
        let stage_data = &mut self.data[stage];

        let uniforms = &mut stage_data.uniforms;
        uniforms.uniform_location_double = locate("double".to_string())?;
        uniforms.uniform_location_double_arr[0] = locate("double_arr[0]".to_string())?;
        uniforms.uniform_location_double_arr[1] = locate("double_arr[1]".to_string())?;
        uniforms.uniform_location_dvec2 = locate("dvec2".to_string())?;
        uniforms.uniform_location_dvec2_arr[0] = locate("dvec2_arr[0]".to_string())?;
        uniforms.uniform_location_dvec2_arr[1] = locate("dvec2_arr[1]".to_string())?;
        uniforms.uniform_location_dvec3 = locate("dvec3".to_string())?;
        uniforms.uniform_location_dvec3_arr[0] = locate("dvec3_arr[0]".to_string())?;
        uniforms.uniform_location_dvec3_arr[1] = locate("dvec3_arr[1]".to_string())?;
        uniforms.uniform_location_dvec4 = locate("dvec4".to_string())?;
        uniforms.uniform_location_dvec4_arr[0] = locate("dvec4_arr[0]".to_string())?;
        uniforms.uniform_location_dvec4_arr[1] = locate("dvec4_arr[1]".to_string())?;

        for (index, structure) in stage_data.uniform_structure_arrays.iter_mut().enumerate() {
            structure.uniform_location_double = locate(format!("array[{index}].struct_double"))?;
            structure.uniform_location_dvec2 = locate(format!("array[{index}].struct_dvec2"))?;
            structure.uniform_location_dvec3 = locate(format!("array[{index}].struct_dvec3"))?;
            structure.uniform_location_dvec4 = locate(format!("array[{index}].struct_dvec4"))?;
        }

        let uniforms = &stage_data.uniforms;
        let [first, second] = &stage_data.uniform_structure_arrays;
        let all_locations = [
            uniforms.uniform_location_double,
            uniforms.uniform_location_double_arr[0],
            uniforms.uniform_location_double_arr[1],
            uniforms.uniform_location_dvec2,
            uniforms.uniform_location_dvec2_arr[0],
            uniforms.uniform_location_dvec2_arr[1],
            uniforms.uniform_location_dvec3,
            uniforms.uniform_location_dvec3_arr[0],
            uniforms.uniform_location_dvec3_arr[1],
            uniforms.uniform_location_dvec4,
            uniforms.uniform_location_dvec4_arr[0],
            uniforms.uniform_location_dvec4_arr[1],
            first.uniform_location_double,
            first.uniform_location_dvec2,
            first.uniform_location_dvec3,
            first.uniform_location_dvec4,
            second.uniform_location_double,
            second.uniform_location_dvec2,
            second.uniform_location_dvec3,
            second.uniform_location_dvec4,
        ];
        if all_locations.contains(&-1) {
            return Err(TestError::Fail(
                "At least one uniform is considered inactive which is invalid.".to_string(),
            ));
        }

        if uniforms.uniform_location_double_arr[1] != uniforms.uniform_location_double_arr[0] + 1
            || uniforms.uniform_location_dvec2_arr[1] != uniforms.uniform_location_dvec2_arr[0] + 1
            || uniforms.uniform_location_dvec3_arr[1] != uniforms.uniform_location_dvec3_arr[0] + 1
            || uniforms.uniform_location_dvec4_arr[1] != uniforms.uniform_location_dvec4_arr[0] + 1
        {
            log::info!(
                "Uniform locations: double_arr[0]:{} double_arr[1]:{} dvec2_arr[0]:{} dvec2_arr[1]:{} dvec3_arr[0]:{} dvec3_arr[1]:{} dvec4_arr[0]:{} dvec4_arr[1]:{}",
                uniforms.uniform_location_double_arr[0],
                uniforms.uniform_location_double_arr[1],
                uniforms.uniform_location_dvec2_arr[0],
                uniforms.uniform_location_dvec2_arr[1],
                uniforms.uniform_location_dvec3_arr[0],
                uniforms.uniform_location_dvec3_arr[1],
                uniforms.uniform_location_dvec4_arr[0],
                uniforms.uniform_location_dvec4_arr[1]
            );
            return Err(TestError::Fail(
                "Double-precision uniform array item locations are invalid.".to_string(),
            ));
        }
        Ok(())
    }

    /// `generateUniformValues`: no GL calls
    fn generate_uniform_values(&mut self) {
        let mut seed: i32 = 16762362;

        for stage in &mut self.data {
            let [first, second] = &mut stage.uniform_structure_arrays;
            let mut pointers = first.structure_values_mut();
            pointers.extend(second.structure_values_mut());
            pointers.extend(stage.uniforms.uniform_values_mut());

            for pointer in pointers {
                // Use magic numbers to generate a set of double-precision floating-point numbers.
                *pointer = f64::from(seed % 1732) / 125.7 * if seed % 2 == 0 { 1.0 } else { -1.0 };
                seed += 751;
            }
        }
    }

    /// `initUniformValues`
    fn init_uniform_values(&self) -> Result<(), TestError> {
        let gl = self.gl;

        for (po_id, stages) in [(self.po_cs_id, &[CS][..]), (self.po_noncs_id, &NONCS_STAGES[..])] {
            // Skip compute shader program if not supported
            if po_id == 0 {
                continue;
            }

            gl_call!(gl, "glUseProgram", gl.use_program(po_id));

            for &stage in stages {
                let stage_ptr = &self.data[stage];
                let uniforms = &stage_ptr.uniforms;
                let [first, second] = &stage_ptr.uniform_structure_arrays;

                gl_call!(
                    gl,
                    "glUniform1d",
                    gl.uniform_1d(uniforms.uniform_location_double, uniforms.uniform_double)
                );
                gl_call!(
                    gl,
                    "glUniform1d",
                    gl.uniform_1d(uniforms.uniform_location_double_arr[0], uniforms.uniform_double_arr[0])
                );
                gl_call!(
                    gl,
                    "glUniform1d",
                    gl.uniform_1d(uniforms.uniform_location_double_arr[1], uniforms.uniform_double_arr[1])
                );
                gl_call!(
                    gl,
                    "glUniform1d",
                    gl.uniform_1d(first.uniform_location_double, first.uniform_double)
                );
                gl_call!(
                    gl,
                    "glUniform1d",
                    gl.uniform_1d(second.uniform_location_double, second.uniform_double)
                );

                gl_call!(
                    gl,
                    "glUniform2dv",
                    gl.uniform_2dv(uniforms.uniform_location_dvec2, 1, uniforms.uniform_dvec2.as_ptr())
                );
                gl_call!(
                    gl,
                    "glUniform2dv",
                    gl.uniform_2dv(
                        uniforms.uniform_location_dvec2_arr[0],
                        1,
                        uniforms.uniform_dvec2_arr[0..].as_ptr()
                    )
                );
                gl_call!(
                    gl,
                    "glUniform2dv",
                    gl.uniform_2dv(
                        uniforms.uniform_location_dvec2_arr[1],
                        1,
                        uniforms.uniform_dvec2_arr[2..].as_ptr()
                    )
                );
                gl_call!(
                    gl,
                    "glUniform2dv",
                    gl.uniform_2dv(first.uniform_location_dvec2, 1, first.uniform_dvec2.as_ptr())
                );
                gl_call!(
                    gl,
                    "glUniform2dv",
                    gl.uniform_2dv(second.uniform_location_dvec2, 1, second.uniform_dvec2.as_ptr())
                );

                gl_call!(
                    gl,
                    "glUniform3dv",
                    gl.uniform_3dv(uniforms.uniform_location_dvec3, 1, uniforms.uniform_dvec3.as_ptr())
                );
                gl_call!(
                    gl,
                    "glUniform3dv",
                    gl.uniform_3dv(
                        uniforms.uniform_location_dvec3_arr[0],
                        1,
                        uniforms.uniform_dvec3_arr[0..].as_ptr()
                    )
                );
                gl_call!(
                    gl,
                    "glUniform3dv",
                    gl.uniform_3dv(
                        uniforms.uniform_location_dvec3_arr[1],
                        1,
                        uniforms.uniform_dvec3_arr[3..].as_ptr()
                    )
                );
                gl_call!(
                    gl,
                    "glUniform3dv",
                    gl.uniform_3dv(first.uniform_location_dvec3, 1, first.uniform_dvec3.as_ptr())
                );
                gl_call!(
                    gl,
                    "glUniform3dv",
                    gl.uniform_3dv(second.uniform_location_dvec3, 1, second.uniform_dvec3.as_ptr())
                );

                gl_call!(
                    gl,
                    "glUniform4dv",
                    gl.uniform_4dv(uniforms.uniform_location_dvec4, 1, uniforms.uniform_dvec4.as_ptr())
                );
                gl_call!(
                    gl,
                    "glUniform4dv",
                    gl.uniform_4dv(
                        uniforms.uniform_location_dvec4_arr[0],
                        1,
                        uniforms.uniform_dvec4_arr[0..].as_ptr()
                    )
                );
                gl_call!(
                    gl,
                    "glUniform4dv",
                    gl.uniform_4dv(
                        uniforms.uniform_location_dvec4_arr[1],
                        1,
                        uniforms.uniform_dvec4_arr[4..].as_ptr()
                    )
                );
                gl_call!(
                    gl,
                    "glUniform4dv",
                    gl.uniform_4dv(first.uniform_location_dvec4, 1, first.uniform_dvec4.as_ptr())
                );
                gl_call!(
                    gl,
                    "glUniform4dv",
                    gl.uniform_4dv(second.uniform_location_dvec4, 1, second.uniform_dvec4.as_ptr())
                );
            }
        }
        Ok(())
    }

    /// `verifyProgramInterfaceQuerySupport`
    fn verify_program_interface_query_support(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;

        for (po_id, stages, prefixes) in [
            (self.po_cs_id, &[CS][..], &["cs_"][..]),
            (self.po_noncs_id, &NONCS_STAGES[..], &NONCS_PREFIXES[..]),
        ] {
            // Skip compute shader program if not supported
            if po_id == 0 {
                continue;
            }

            let mut max_uniform_name_length: GLint = 0;
            gl_call!(
                gl,
                "glGetProgramInterfaceiv",
                gl.get_program_interfaceiv(
                    po_id,
                    glw::GL_UNIFORM,
                    glw::GL_MAX_NAME_LENGTH,
                    &mut max_uniform_name_length
                )
            );

            let mut uniform_name_buffer = vec![0u8; max_uniform_name_length.max(0) as usize];

            for (&stage, stage_prefix) in stages.iter().zip(prefixes) {
                let stage_ptr = &self.data[stage];
                let uniforms = &stage_ptr.uniforms;
                let structures = &stage_ptr.uniform_structure_arrays;

                // (expected array size, name, expected type, location)
                let items: [(GLint, String, GLenum, GLint); 16] = [
                    (
                        1,
                        "double".to_string(),
                        glw::GL_DOUBLE,
                        uniforms.uniform_location_double,
                    ),
                    (
                        2,
                        "double_arr[0]".to_string(),
                        glw::GL_DOUBLE,
                        uniforms.uniform_location_double_arr[0],
                    ),
                    (
                        1,
                        "dvec2".to_string(),
                        glw::GL_DOUBLE_VEC2,
                        uniforms.uniform_location_dvec2,
                    ),
                    (
                        2,
                        "dvec2_arr[0]".to_string(),
                        glw::GL_DOUBLE_VEC2,
                        uniforms.uniform_location_dvec2_arr[0],
                    ),
                    (
                        1,
                        "dvec3".to_string(),
                        glw::GL_DOUBLE_VEC3,
                        uniforms.uniform_location_dvec3,
                    ),
                    (
                        2,
                        "dvec3_arr[0]".to_string(),
                        glw::GL_DOUBLE_VEC3,
                        uniforms.uniform_location_dvec3_arr[0],
                    ),
                    (
                        1,
                        "dvec4".to_string(),
                        glw::GL_DOUBLE_VEC4,
                        uniforms.uniform_location_dvec4,
                    ),
                    (
                        2,
                        "dvec4_arr[0]".to_string(),
                        glw::GL_DOUBLE_VEC4,
                        uniforms.uniform_location_dvec4_arr[0],
                    ),
                    (
                        1,
                        "array[0].struct_double".to_string(),
                        glw::GL_DOUBLE,
                        structures[0].uniform_location_double,
                    ),
                    (
                        1,
                        "array[0].struct_dvec2".to_string(),
                        glw::GL_DOUBLE_VEC2,
                        structures[0].uniform_location_dvec2,
                    ),
                    (
                        1,
                        "array[0].struct_dvec3".to_string(),
                        glw::GL_DOUBLE_VEC3,
                        structures[0].uniform_location_dvec3,
                    ),
                    (
                        1,
                        "array[0].struct_dvec4".to_string(),
                        glw::GL_DOUBLE_VEC4,
                        structures[0].uniform_location_dvec4,
                    ),
                    (
                        1,
                        "array[1].struct_double".to_string(),
                        glw::GL_DOUBLE,
                        structures[0].uniform_location_double,
                    ),
                    (
                        1,
                        "array[1].struct_dvec2".to_string(),
                        glw::GL_DOUBLE_VEC2,
                        structures[0].uniform_location_dvec2,
                    ),
                    (
                        1,
                        "array[1].struct_dvec3".to_string(),
                        glw::GL_DOUBLE_VEC3,
                        structures[0].uniform_location_dvec3,
                    ),
                    (
                        1,
                        "array[1].struct_dvec4".to_string(),
                        glw::GL_DOUBLE_VEC4,
                        structures[0].uniform_location_dvec4,
                    ),
                ];

                let properties: [GLenum; 2] = [glw::GL_ARRAY_SIZE, glw::GL_TYPE];

                for (expected_array_size, name, expected_type, _location) in items {
                    let name = format!("{stage_prefix}{name}");
                    let mut n_written_items: GLint = 0;
                    let mut retrieved_name_length: GLint = 0;
                    let mut temp_buffer: [GLint; 2] = [0, glw::GL_NONE as GLint];

                    let c_name = CString::new(name.as_str()).expect("no nul byte");
                    let resource_index = gl!(gl.get_program_resource_index(po_id, glw::GL_UNIFORM, c_name.as_ptr()));
                    glu::expect_no_error(gl, "glGetProgramResourceIndex")?;

                    uniform_name_buffer.fill(0);
                    gl_call!(
                        gl,
                        "glGetProgramResourceName",
                        gl.get_program_resource_name(
                            po_id,
                            glw::GL_UNIFORM,
                            resource_index,
                            max_uniform_name_length,
                            &mut retrieved_name_length,
                            uniform_name_buffer.as_mut_ptr().cast::<c_char>()
                        )
                    );

                    let retrieved_length = retrieved_name_length.max(0) as usize;
                    if name.len() != retrieved_length
                        || uniform_name_buffer.get(..retrieved_length) != Some(name.as_bytes())
                    {
                        let reported = String::from_utf8_lossy(&uniform_name_buffer)
                            .trim_end_matches('\0')
                            .to_string();
                        log::info!(
                            "Invalid uniform name was reported at index [{resource_index}]: expected:[{name}], reported:[{reported}]"
                        );
                        result = false;
                        continue;
                    }

                    gl_call!(
                        gl,
                        "glGetProgramResourceiv",
                        gl.get_program_resourceiv(
                            po_id,
                            glw::GL_UNIFORM,
                            resource_index,
                            properties.len() as i32,
                            properties.as_ptr(),
                            temp_buffer.len() as i32,
                            &mut n_written_items,
                            temp_buffer.as_mut_ptr()
                        )
                    );

                    if n_written_items != properties.len() as GLint {
                        return Err(TestError::Fail(
                            "Invalid amount of items were reported by glGetProgramResourceiv() call.".to_string(),
                        ));
                    }

                    let retrieved_array_size = temp_buffer[0];
                    let retrieved_type = temp_buffer[1] as GLenum;

                    if retrieved_array_size != expected_array_size {
                        log::info!(
                            "Invalid array size reported for uniform [{name}]: expected:[{expected_array_size}], reported:[{retrieved_array_size}]"
                        );
                        result = false;
                    }

                    if retrieved_type != expected_type {
                        log::info!(
                            "Invalid type reported for uniform [{name}]: expected:[{expected_type}], reported:[{retrieved_type}]"
                        );
                        result = false;
                    }
                }
            }
        }

        Ok(result)
    }

    /// `verifyUniformValues`
    fn verify_uniform_values(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;
        let epsilon = f64::from(1e-5f32);

        for (po_id, stages) in [(self.po_noncs_id, &NONCS_STAGES[..]), (self.po_cs_id, &[CS][..])] {
            // Skip compute shader program if not supported
            if po_id == 0 {
                continue;
            }

            for &stage in stages {
                let stage_ptr = &self.data[stage];

                let mut returned_double_data = [0f64; 4];
                let mut returned_float_data = [0f32; 4];
                let mut returned_int_data = [0 as GLint; 4];
                let mut returned_uint_data = [0 as GLuint; 4];

                for n_type in 0..4 {
                    let n_components_used = n_type + 1;

                    for (uniform_location, uniform_value) in uniform_value_pairs(stage_ptr, n_type) {
                        gl_call!(
                            gl,
                            "glGetUniformdv",
                            gl.get_uniformdv(po_id, uniform_location, returned_double_data.as_mut_ptr())
                        );
                        gl_call!(
                            gl,
                            "glGetUniformfv",
                            gl.get_uniformfv(po_id, uniform_location, returned_float_data.as_mut_ptr())
                        );
                        gl_call!(
                            gl,
                            "glGetUniformiv",
                            gl.get_uniformiv(po_id, uniform_location, returned_int_data.as_mut_ptr())
                        );
                        gl_call!(
                            gl,
                            "glGetUniformuiv",
                            gl.get_uniformuiv(po_id, uniform_location, returned_uint_data.as_mut_ptr())
                        );

                        for n_component in 0..n_components_used {
                            let expected = uniform_value[n_component];

                            if (returned_double_data[n_component] - expected).abs() > epsilon {
                                log::info!(
                                    "Invalid uniform value reported by glGetUniformdv() for uniform location [{uniform_location}] and component [{n_component}]: retrieved:[{}], expected:[{expected}]",
                                    returned_double_data[n_component]
                                );
                                result = false;
                            }

                            if (f64::from(returned_float_data[n_component]) - expected).abs() > epsilon {
                                log::info!(
                                    "Invalid uniform value reported by glGetUniformfv() for uniform location [{uniform_location}] and component [{n_component}]: retrieved:[{}], expected:[{expected}]",
                                    returned_float_data[n_component]
                                );
                                result = false;
                            }

                            let rounded = (expected as f32 + 0.5).floor();
                            let rounded_uniform_value_sint = rounded as i32;
                            let rounded_uniform_value_uint = if expected > 0.0 { rounded as u32 } else { 0 };

                            if returned_int_data[n_component] != rounded_uniform_value_sint {
                                log::info!(
                                    "Invalid uniform value reported by glGetUniformiv() for uniform location [{uniform_location}] and component [{n_component}]: retrieved:[{}], expected:[{rounded_uniform_value_sint}]",
                                    returned_int_data[n_component]
                                );
                                result = false;
                            }

                            if returned_uint_data[n_component] != rounded_uniform_value_uint {
                                log::info!(
                                    "Invalid uniform value reported by glGetUniformuiv() for uniform location [{uniform_location}] and component [{n_component}]: retrieved:[{}], expected:[{rounded_uniform_value_uint}]",
                                    returned_uint_data[n_component]
                                );
                                result = false;
                            }
                        }
                    }
                }
            }
        }

        Ok(result)
    }
}

/// `GPUShaderFP64Test4`
pub(super) struct StateQuery;

impl TestCase for StateQuery {
    fn name(&self) -> &str {
        "state_query"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut has_test_passed = true;

        // This test does not verify GL_ARB_gpu_shader_fp64 support on purpose
        let mut state = State::init_program_objects(context)?;
        state.generate_uniform_values();
        state.init_uniform_values()?;

        has_test_passed &= state.verify_uniform_values()?;

        if context
            .context_info
            .is_extension_supported("GL_ARB_program_interface_query")
        {
            has_test_passed &= state.verify_program_interface_query_support()?;
        }

        Ok(if has_test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
