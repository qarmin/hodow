// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderProgramResource.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader code parts are joined by the same four-way choice upstream makes in initTest.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const COMMON_SHADER_CODE_DEFINITIONS_BODY: &str = "// uniforms\nuniform mat4 uni_model_view_projection; // not referenced in GS\nuniform vec4 uni_colors_white;          // referenced in GS\n\n// uniforms blocks\nuniform Matrices\n{\n    mat4 model;\n    mat4 view;\n    mat4 projection;\n} uni_matrices; // not referenced at all\n\nuniform Colors\n{\n    vec4 red;\n    vec4 green;\n    vec4 blue;\n} uni_colors; // referenced in GS\n\n";
const COMMON_SHADER_CODE_DEFINITIONS_ATOMIC_COUNTER_BODY: &str = "// atomic counter buffers\nlayout (binding = 0) uniform atomic_uint uni_atom_horizontal; // not referenced in GS\nlayout (binding = 1) uniform atomic_uint uni_atom_vertical;   // referenced in GS\n\n";
const COMMON_SHADER_CODE_DEFINITIONS_SSBO_BODY: &str = "// ssbos\nbuffer Positions\n{\n    vec4 position[4]; // referenced in GS\n} storage_positions;  // referenced in GS\n\nbuffer Ids\n{\n    int ids[4]; // not referenced in GS\n} storage_ids;  // not referenced in GS\n\n";

const VERTEX_SHADER_CODE_PREAMBLE: &str = "${VERSION}\n\nprecision highp float;\n\n// uniforms included here\n";
const VERTEX_SHADER_CODE_BODY: &str = "// attributes\nin vec4 vs_in_position; // not referenced in GS\nin vec4 vs_in_color;    // not referenced in GS\n\n// output\nout vec4 vs_out_color; // referenced in GS\n\nvoid main()\n{\n    gl_Position  = uni_model_view_projection * vs_in_position;\n    vs_out_color = vs_in_color;\n";
const VERTEX_SHADER_CODE_ATOMIC_COUNTER_BODY: &str = "    // write atomic counters\n    if (0.0 <= gl_Position.x)\n    {\n        atomicCounterIncrement(uni_atom_vertical);\n    }\n\n    if (0.0 <= gl_Position.y)\n    {\n        atomicCounterIncrement(uni_atom_horizontal);\n    }\n";
const VERTEX_SHADER_CODE_SSBO_BODY: &str = "    // write shader storage buffers\n    storage_positions.position[gl_VertexID] = gl_Position;\n    storage_ids.ids[gl_VertexID]            = gl_VertexID;\n";

const GEOMETRY_SHADER_CODE_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout (points)                           in;\nlayout (triangle_strip, max_vertices = 6) out;\n\n// uniforms included here\n";
const GEOMETRY_SHADER_CODE_BODY: &str = "// input from vs + gl_Position\nin vec4 vs_out_color[1];\n\nout vec4 gs_out_color;\n\nvoid main()\n{\n    // access uniform\n    gl_Position = vec4(0, 0, 0, 0);\n    gs_out_color = uni_colors_white;\n    EmitVertex();\n\n    // access uniform block\n    gl_Position = gl_in[0].gl_Position + vec4(-0.1, 0.1, 0, 0);\n    gs_out_color = vs_out_color[0] + uni_colors.red;\n    EmitVertex();\n\n    gl_Position = gl_in[0].gl_Position + vec4(-0.1, -0.1, 0, 0);\n    gs_out_color = vs_out_color[0] + uni_colors.green;\n    EmitVertex();\n\n    gl_Position = gl_in[0].gl_Position + vec4(0.1, -0.1, 0, 0);\n    gs_out_color = vs_out_color[0] + uni_colors.blue;\n    EmitVertex();\n";
const GEOMETRY_SHADER_CODE_ATOMIC_COUNTER_BODY: &str = "    // access atomic counter\n    gl_Position = vec4(0, 0, 0, 0);\n    uint  counter = atomicCounter(uni_atom_vertical);\n    gs_out_color     = vec4(counter / 255u);\n    EmitVertex();\n";
const GEOMETRY_SHADER_CODE_SSBO_BODY: &str = "    // access shader storage buffers\n    gl_Position = storage_positions.position[0] + vec4(0.1, 0.1, 0, 0);\n    gs_out_color     = vec4(1.0);\n    EmitVertex();\n";

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\nprecision highp float;\n\n// input from gs\nin vec4 gs_out_color;\nlayout(location = 0) out vec4 fs_out_color;\n\nvoid main()\n{\n    fs_out_color = gs_out_color;\n}\n\n";

/// `GeometryShaderProgramResourceTest`
pub(super) struct ProgramResource {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    fs_id: GLuint,
    gs_id: GLuint,
    vs_id: GLuint,
    po_id: GLuint,
}

impl ProgramResource {
    /// `checkIfResourceAtIndexIsReferenced`
    fn check_if_resource_at_index_is_referenced(
        context: &Context,
        resources: &Resources,
        interface: GLenum,
        index: GLuint,
    ) -> bool {
        let gl = context.gl();
        let mut params: [GLint; 1] = [0];
        let props: [GLenum; 1] = [glw::GL_REFERENCED_BY_GEOMETRY_SHADER];
        gl!(gl.get_program_resourceiv(
            resources.po_id,
            interface,
            index,
            1,
            props.as_ptr(),
            1,
            std::ptr::null_mut(),
            params.as_mut_ptr()
        ));
        params[0] == 1
    }

    /// `checkIfResourceIsReferenced`
    fn check_if_resource_is_referenced(
        context: &Context,
        resources: &Resources,
        interface: GLenum,
        name: &str,
    ) -> bool {
        let gl = context.gl();
        let c_name = CString::new(name).expect("no nul byte");
        let index = gl!(gl.get_program_resource_index(resources.po_id, interface, c_name.as_ptr()));
        if index == glw::GL_INVALID_INDEX {
            return false;
        }
        Self::check_if_resource_at_index_is_referenced(context, resources, interface, index)
    }

    fn get_integer(context: &Context, pname: GLenum) -> GLint {
        let mut value: GLint = 0;
        gl!(context.gl().get_integerv(pname, &mut value));
        value
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        // initTest
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        let max_vs_atomic_counters = Self::get_integer(context, glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS);
        let max_gs_atomic_counters = Self::get_integer(context, base.gl_ext_tokens.max_geometry_atomic_counter_buffers);
        let atomic_counters_supported = max_vs_atomic_counters >= 2 && max_gs_atomic_counters >= 1;

        let max_vs_storage_blocks = Self::get_integer(context, glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS);
        let max_gs_storage_blocks = Self::get_integer(context, base.gl_ext_tokens.max_geometry_shader_storage_blocks);
        let ssbos_supported = max_vs_storage_blocks >= 2 && max_gs_storage_blocks >= 1;

        let mut vertex_shader_code_parts: Vec<&str> =
            vec![VERTEX_SHADER_CODE_PREAMBLE, COMMON_SHADER_CODE_DEFINITIONS_BODY];
        let mut geometry_shader_code_parts: Vec<&str> =
            vec![GEOMETRY_SHADER_CODE_PREAMBLE, COMMON_SHADER_CODE_DEFINITIONS_BODY];
        if atomic_counters_supported {
            vertex_shader_code_parts.push(COMMON_SHADER_CODE_DEFINITIONS_ATOMIC_COUNTER_BODY);
            geometry_shader_code_parts.push(COMMON_SHADER_CODE_DEFINITIONS_ATOMIC_COUNTER_BODY);
        }
        if ssbos_supported {
            vertex_shader_code_parts.push(COMMON_SHADER_CODE_DEFINITIONS_SSBO_BODY);
            geometry_shader_code_parts.push(COMMON_SHADER_CODE_DEFINITIONS_SSBO_BODY);
        }
        vertex_shader_code_parts.push(VERTEX_SHADER_CODE_BODY);
        geometry_shader_code_parts.push(GEOMETRY_SHADER_CODE_BODY);
        if atomic_counters_supported {
            vertex_shader_code_parts.push(VERTEX_SHADER_CODE_ATOMIC_COUNTER_BODY);
            geometry_shader_code_parts.push(GEOMETRY_SHADER_CODE_ATOMIC_COUNTER_BODY);
        }
        if ssbos_supported {
            vertex_shader_code_parts.push(VERTEX_SHADER_CODE_SSBO_BODY);
            geometry_shader_code_parts.push(GEOMETRY_SHADER_CODE_SSBO_BODY);
        }
        vertex_shader_code_parts.push("}\n");
        geometry_shader_code_parts.push("}\n");

        // Create shader objects
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));

        // Create program object
        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "Could not create program object")?;

        // Build program object
        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(resources.gs_id, &geometry_shader_code_parts),
                ShaderBody::Source(resources.vs_id, &vertex_shader_code_parts),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        let mut result = true;

        let mut is_ids_ids_buffer_variable_referenced = false;
        let mut is_positions_position_buffer_variable_referenced = false;
        let mut is_storage_ids_shader_storage_block_referenced = false;
        let mut is_storage_positions_shader_storage_block_referenced = false;
        let mut is_uni_atom_horizontal_uniform_referenced = false;
        let mut is_uni_atom_vertical_uniform_referenced = false;

        // Check whether uniform variables are referenced
        let is_uni_model_view_projection_uniform_referenced =
            Self::check_if_resource_is_referenced(context, resources, glw::GL_UNIFORM, "uni_model_view_projection");
        let is_uni_colors_white_uniform_referenced =
            Self::check_if_resource_is_referenced(context, resources, glw::GL_UNIFORM, "uni_colors_white");

        // For: uniform Matrices {} uni_matrices; uniform block name is: Matrices
        let is_uni_matrices_uniform_referenced =
            Self::check_if_resource_is_referenced(context, resources, glw::GL_UNIFORM_BLOCK, "Matrices");
        let is_uni_colors_uniform_referenced =
            Self::check_if_resource_is_referenced(context, resources, glw::GL_UNIFORM_BLOCK, "Colors");

        // For: buffer Positions {} storage_positions; storage block name is: Positions
        if ssbos_supported {
            is_storage_positions_shader_storage_block_referenced =
                Self::check_if_resource_is_referenced(context, resources, glw::GL_SHADER_STORAGE_BLOCK, "Positions");
            is_storage_ids_shader_storage_block_referenced =
                Self::check_if_resource_is_referenced(context, resources, glw::GL_SHADER_STORAGE_BLOCK, "Ids");
            is_positions_position_buffer_variable_referenced = Self::check_if_resource_is_referenced(
                context,
                resources,
                glw::GL_BUFFER_VARIABLE,
                "Positions.position",
            );
            is_ids_ids_buffer_variable_referenced =
                Self::check_if_resource_is_referenced(context, resources, glw::GL_BUFFER_VARIABLE, "Ids.ids");
        }

        // Check whether input attributes are referenced
        let is_vs_in_position_program_input_referenced =
            Self::check_if_resource_is_referenced(context, resources, glw::GL_PROGRAM_INPUT, "vs_in_position");
        let is_vs_in_color_program_input_referenced =
            Self::check_if_resource_is_referenced(context, resources, glw::GL_PROGRAM_INPUT, "vs_in_color");

        // Check whether output attributes are referenced
        let is_gl_fs_out_color_program_output_referenced =
            Self::check_if_resource_is_referenced(context, resources, glw::GL_PROGRAM_OUTPUT, "fs_out_color");

        // Active atomic counter buffers do not have an associated name string, so go through the uniforms' buffer indices.
        if atomic_counters_supported {
            let horizontal = CString::new("uni_atom_horizontal").expect("no nul byte");
            let vertical = CString::new("uni_atom_vertical").expect("no nul byte");
            let atom_horizontal_uniform_indx =
                gl!(gl.get_program_resource_index(resources.po_id, glw::GL_UNIFORM, horizontal.as_ptr()));
            let atom_vertical_uniform_indx =
                gl!(gl.get_program_resource_index(resources.po_id, glw::GL_UNIFORM, vertical.as_ptr()));

            let mut params: [GLint; 1] = [0];
            let props: [GLenum; 1] = [glw::GL_ATOMIC_COUNTER_BUFFER_INDEX];

            gl!(gl.get_program_resourceiv(
                resources.po_id,
                glw::GL_UNIFORM,
                atom_horizontal_uniform_indx,
                1,
                props.as_ptr(),
                1,
                std::ptr::null_mut(),
                params.as_mut_ptr()
            ));
            let atom_horizontal_uniform_buffer_indx = params[0] as GLuint;

            gl!(gl.get_program_resourceiv(
                resources.po_id,
                glw::GL_UNIFORM,
                atom_vertical_uniform_indx,
                1,
                props.as_ptr(),
                1,
                std::ptr::null_mut(),
                params.as_mut_ptr()
            ));
            let atom_vertical_uniform_buffer_indx = params[0] as GLuint;

            is_uni_atom_horizontal_uniform_referenced = Self::check_if_resource_at_index_is_referenced(
                context,
                resources,
                glw::GL_ATOMIC_COUNTER_BUFFER,
                atom_horizontal_uniform_buffer_indx,
            );
            is_uni_atom_vertical_uniform_referenced = Self::check_if_resource_at_index_is_referenced(
                context,
                resources,
                glw::GL_ATOMIC_COUNTER_BUFFER,
                atom_vertical_uniform_buffer_indx,
            );
        }

        let mut wrong = |what: &str| {
            log::info!("Wrong value of property GL_REFERENCED_BY_GEOMETRY_SHADER_EXT for {what}");
            result = false;
        };

        // Verify results: referenced properties
        if !is_uni_colors_white_uniform_referenced {
            wrong("GL_UNIFORM");
        }
        if !is_uni_colors_uniform_referenced {
            wrong("GL_UNIFORM_BLOCK");
        }
        if !is_uni_atom_vertical_uniform_referenced && atomic_counters_supported {
            wrong("GL_ATOMIC_COUNTER_BUFFER");
        }
        if is_uni_atom_horizontal_uniform_referenced && atomic_counters_supported {
            wrong("GL_ATOMIC_COUNTER_BUFFER");
        }
        if !is_storage_positions_shader_storage_block_referenced && ssbos_supported {
            wrong("GL_SHADER_STORAGE_BLOCK");
        }
        if is_storage_ids_shader_storage_block_referenced && ssbos_supported {
            wrong("GL_SHADER_STORAGE_BLOCK");
        }
        if !is_positions_position_buffer_variable_referenced && ssbos_supported {
            wrong("GL_BUFFER_VARIABLE");
        }
        if is_ids_ids_buffer_variable_referenced && ssbos_supported {
            wrong("GL_BUFFER_VARIABLE");
        }

        // Verify results: properties that are not referenced
        if is_uni_model_view_projection_uniform_referenced {
            wrong("GL_UNIFORM");
        }
        if is_uni_matrices_uniform_referenced {
            wrong("GL_UNIFORM_BLOCK");
        }
        if is_vs_in_position_program_input_referenced {
            wrong("GL_PROGRAM_INPUT");
        }
        if is_vs_in_color_program_input_referenced {
            wrong("GL_PROGRAM_INPUT");
        }
        if is_gl_fs_out_color_program_output_referenced {
            wrong("GL_PROGRAM_OUTPUT");
        }

        if result {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

impl TestCase for ProgramResource {
    fn name(&self) -> &str {
        "program_resource"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.vs_id, resources.gs_id, resources.fs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        outcome
    }
}
