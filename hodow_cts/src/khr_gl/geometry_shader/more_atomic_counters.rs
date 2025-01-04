// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLinking.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `GeometryShaderMoreACsInGSThanSupportedTest` and `GeometryShaderMoreACBsInGSThanSupportedTest` differ only in the queried limit and the binding point, so they are one struct with a `Kind`.

use std::fmt::Write;

use super::{MINIMAL_FS_CODE, MINIMAL_VS_CODE, require_geometry_shader, verdict};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::TestOutcome;

#[derive(Clone, Copy)]
pub enum Kind {
    Counters,
    CounterBuffers,
}

pub struct MoreAtomicCounters {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

impl MoreAtomicCounters {
    fn gs_code(&self, base: &TestCaseBase, context: &Context) -> Result<String, crate::tcu::TestError> {
        let gl = context.gl();
        let (token, message) = match self.kind {
            Kind::Counters => (
                base.gl_ext_tokens.max_geometry_atomic_counters,
                "glGetIntegerv() failed for GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT pname",
            ),
            Kind::CounterBuffers => (
                base.gl_ext_tokens.max_geometry_atomic_counter_buffers,
                "glGetIntegerv() failed for GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT pname",
            ),
        };
        let mut max_value: GLint = 0;
        // SAFETY: the value is written to the live local.
        unsafe { gl.get_integerv(token, &mut max_value) };
        glu::expect_no_error(gl, message)?;

        let mut code = String::from(
            "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\n",
        );
        for n in 0..(max_value + 1) {
            let binding = match self.kind {
                Kind::Counters => 0,
                Kind::CounterBuffers => n,
            };
            let _ = writeln!(code, "layout(binding = {binding}) uniform atomic_uint counter{n};");
        }
        code.push_str("\nvoid main()\n{\n");
        for n in 0..(max_value + 1) {
            let _ = writeln!(
                code,
                "    if ((gl_PrimitiveIDIn % {}) == 0) atomicCounterIncrement(counter{n});",
                n + 1
            );
        }
        code.push_str("\n    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n    EmitVertex();\n}\n");
        Ok(base.specialize_shader(&[code.as_str()]))
    }

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
        let gs_code_specialized = self.gs_code(&base, context)?;
        let vs_code_specialized = base.specialize_shader(&[MINIMAL_VS_CODE]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        let (built, _) = base.build_program(
            context,
            *po_id,
            &[
                ShaderBody::Source(*gs_id, &gs_parts),
                ShaderBody::Source(*vs_id, &vs_parts),
                ShaderBody::Source(*fs_id, &fs_parts),
            ],
        )?;

        let mut result = true;
        if built {
            log::info!("Program object was linked successfully, whereas a failure was expected.");
            result = false;
        }
        verdict(result)
    }
}

impl TestCase for MoreAtomicCounters {
    fn name(&self) -> &str {
        match self.kind {
            Kind::Counters => "more_ACs_in_GS_than_supported",
            Kind::CounterBuffers => "more_ACBs_in_GS_than_supported",
        }
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
