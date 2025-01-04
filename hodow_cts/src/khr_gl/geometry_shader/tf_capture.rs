// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLinking.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::{CString, c_char};

use super::{MINIMAL_FS_CODE, require_geometry_shader, verdict};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::TestOutcome;

const GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout (points)                   in;\nlayout (points, max_vertices = 1) out;\n\nflat in int vertexID[];\nout vec4 out_gs_1;\n\nvoid main()\n{\n    out_gs_1 = vec4(vertexID[0] * 2, vertexID[0] * 2 + 1, vertexID[0] * 2 + 2, vertexID[0] * 2 + 3);\n    gl_Position = vec4(0, 0, 0, 1);\n    EmitVertex();\n}\n";
const VS_CODE: &str = "${VERSION}\n\nflat out ivec4 out_vs_1;\nflat out int vertexID;\n\nvoid main()\n{\n    vertexID = gl_VertexID;\n    out_vs_1 = ivec4(gl_VertexID, gl_VertexID + 1, gl_VertexID + 2, gl_VertexID + 3);\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";

/// `GeometryShaderTransformFeedbackVertexAndGeometryShaderCaptureTest`
pub struct TfCaptureFromGsAndVsVariables {
    pub ext_params: ExtParameters,
}

impl TfCaptureFromGsAndVsVariables {
    fn run(&self, context: &Context, ids: &mut [GLuint; 4]) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        require_geometry_shader(&base)?;
        let [fs_id, gs_id, po_id, vs_id] = ids;

        // SAFETY: creates a program object.
        *po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call(s) failed.")?;

        let tf_varyings = [
            CString::new("out_vs_1").expect("no NUL in a varying name"),
            CString::new("out_gs_1").expect("no NUL in a varying name"),
        ];
        let tf_varying_pointers: [*const c_char; 2] = [tf_varyings[0].as_ptr(), tf_varyings[1].as_ptr()];
        // SAFETY: two NUL-terminated varying names that outlive the call.
        unsafe { gl.transform_feedback_varyings(*po_id, 2, tf_varying_pointers.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS) };
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call(s) failed.")?;

        // SAFETY: creates shader objects.
        unsafe {
            *fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            *gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            *vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        let fs_code_specialized = base.specialize_shader(&[MINIMAL_FS_CODE]);
        let gs_code_specialized = base.specialize_shader(&[GS_CODE]);
        let vs_code_specialized = base.specialize_shader(&[VS_CODE]);
        let (fs_parts, gs_parts, vs_parts) = (
            [fs_code_specialized.as_str()],
            [gs_code_specialized.as_str()],
            [vs_code_specialized.as_str()],
        );
        let (built, _) = base.build_program(
            context,
            *po_id,
            &[
                ShaderBody::Source(*fs_id, &fs_parts),
                ShaderBody::Source(*gs_id, &gs_parts),
                ShaderBody::Source(*vs_id, &vs_parts),
            ],
        )?;

        let mut result = true;
        if built {
            log::info!("Program object linking successful, whereas a failure was expected.");
            result = false;
        }
        verdict(result)
    }
}

impl TestCase for TfCaptureFromGsAndVsVariables {
    fn name(&self) -> &str {
        "tf_capture_from_gs_and_vs_variables"
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
