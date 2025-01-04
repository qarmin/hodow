// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderConstantVariables.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The twenty-odd copy-pasted query-and-compare blocks of `iterate` are one table of (token, name, minimum), in upstream's order.

use std::ffi::{CString, c_char};

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

const FS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 color;\n\nvoid main()\n{\n   color = vec4(1, 1, 1, 1);\n}\n";
const GS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\nflat out int test_MaxGeometryInputComponents;\nflat out int test_MaxGeometryOutputComponents;\nflat out int test_MaxGeometryTextureImageUnits;\nflat out int test_MaxGeometryOutputVertices;\nflat out int test_MaxGeometryTotalOutputComponents;\nflat out int test_MaxGeometryUniformComponents;\nflat out int test_MaxGeometryAtomicCounters;\nflat out int test_MaxGeometryAtomicCounterBuffers;\nflat out int test_MaxGeometryImageUniforms;\n\nvoid main()\n{\n   test_MaxGeometryInputComponents       = gl_MaxGeometryInputComponents;\n   test_MaxGeometryOutputComponents      = gl_MaxGeometryOutputComponents;\n   test_MaxGeometryTextureImageUnits     = gl_MaxGeometryTextureImageUnits;\n   test_MaxGeometryOutputVertices        = gl_MaxGeometryOutputVertices;\n   test_MaxGeometryTotalOutputComponents = gl_MaxGeometryTotalOutputComponents;\n   test_MaxGeometryUniformComponents     = gl_MaxGeometryUniformComponents;\n   test_MaxGeometryAtomicCounters        = gl_MaxGeometryAtomicCounters;\n   test_MaxGeometryAtomicCounterBuffers  = gl_MaxGeometryAtomicCounterBuffers;\n   test_MaxGeometryImageUniforms         = gl_MaxGeometryImageUniforms;\n\n   EmitVertex();\n   EndPrimitive();\n}\n";
const VS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n}\n";

const FEEDBACK_VARYINGS: [&str; 9] = [
    "test_MaxGeometryInputComponents",
    "test_MaxGeometryOutputComponents",
    "test_MaxGeometryTextureImageUnits",
    "test_MaxGeometryOutputVertices",
    "test_MaxGeometryTotalOutputComponents",
    "test_MaxGeometryUniformComponents",
    "test_MaxGeometryAtomicCounters",
    "test_MaxGeometryAtomicCounterBuffers",
    "test_MaxGeometryImageUniforms",
];

/// `GeometryShaderConstantVariables`
pub(super) struct ConstantVariables {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    fs_id: GLuint,
    gs_id: GLuint,
    vs_id: GLuint,
    po_id: GLuint,
    bo_id: GLuint,
    vao_id: GLuint,
}

fn get_integer(gl: &glw::Functions, pname: GLenum, name: &str) -> Result<GLint, TestError> {
    let mut value: GLint = 0;
    gl!(gl.get_integerv(pname, &mut value));
    glu::expect_no_error(gl, &format!("glGetIntegerv() failed for {name}"))?;
    Ok(value)
}

impl ConstantVariables {
    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        // This test should only run if EXT_geometry_shader is supported
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not create VAO!")?;

        resources.po_id = gl!(gl.create_program());
        let names: Vec<CString> = FEEDBACK_VARYINGS
            .iter()
            .map(|name| CString::new(*name).expect("no nul byte"))
            .collect();
        let pointers: Vec<*const c_char> = names.iter().map(|name| name.as_ptr()).collect();
        gl!(gl.transform_feedback_varyings(
            resources.po_id,
            pointers.len() as GLint,
            pointers.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "Could not set program object for transform feedback")?;

        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[FS_CODE]),
                ShaderBody::Source(resources.gs_id, &[GS_CODE]),
                ShaderBody::Source(resources.vs_id, &[VS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Program could not have been created from a valid vertex/geometry/fragment shader!".to_string(),
            ));
        }

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (std::mem::size_of::<GLint>() * FEEDBACK_VARYINGS.len()) as isize,
            std::ptr::null(),
            glw::GL_STATIC_COPY
        ));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        glu::expect_no_error(gl, "Could not set a buffer object up")?;
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = &base.gl_ext_tokens;
        self.init_test(context, &base, resources)?;

        let n_varyings = FEEDBACK_VARYINGS.len();

        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Could not bind a vertex array object")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "Could not bind a buffer object!")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "Could not bind buffer object to transform feedback binding point.")?;

        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "Could not use program")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "Rendering failed.")?;
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));

        // First, retrieve the ES constant values using the API.
        let queried = [
            (
                tokens.max_geometry_input_components,
                "GL_MAX_GEOMETRY_INPUT_COMPONENTS_EXT",
            ),
            (
                tokens.max_geometry_output_components,
                "GL_MAX_GEOMETRY_OUTPUT_COMPONENTS_EXT",
            ),
            (
                tokens.max_geometry_texture_image_units,
                "GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT",
            ),
            (
                tokens.max_geometry_output_vertices,
                "GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT",
            ),
            (
                tokens.max_geometry_total_output_components,
                "GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT",
            ),
            (
                tokens.max_geometry_uniform_components,
                "GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT",
            ),
            (
                tokens.max_geometry_atomic_counters,
                "GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT",
            ),
            (
                tokens.max_geometry_atomic_counter_buffers,
                "GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT",
            ),
            (tokens.max_geometry_image_uniforms, "GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT"),
        ];
        let mut constant_values = [0 as GLint; 9];
        for (value, (pname, name)) in constant_values.iter_mut().zip(queried) {
            *value = get_integer(gl, pname, name)?;
        }

        let stored_data_ptr = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            (std::mem::size_of::<GLint>() * n_varyings) as isize,
            glw::GL_MAP_READ_BIT
        ))
        .cast::<GLint>();
        glu::expect_no_error(gl, "Could not map buffer object storage")?;
        if stored_data_ptr.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: nine ints were mapped for reading and the mapping lives until the unmap below.
        let stored_data = unsafe { std::slice::from_raw_parts(stored_data_ptr, n_varyings) }.to_vec();

        // Compare the values that were stored by the draw call with values returned by the getter call.
        let mut has_failed = false;
        for id in 0..n_varyings {
            if constant_values[id] != stored_data[id] {
                log::info!(
                    "Values reported for ES constant {} in a shader: {} and via a glGetIntegerv() call: {} do not match.",
                    FEEDBACK_VARYINGS[id],
                    stored_data[id],
                    constant_values[id]
                );
                has_failed = true;
            }
        }
        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));

        // Check whether the reported values are at least of the minimum value described in relevant extension specifications
        let minimums = [
            (
                tokens.max_geometry_atomic_counter_buffers,
                "GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS_EXT",
                0,
            ),
            (
                tokens.max_geometry_atomic_counters,
                "GL_MAX_GEOMETRY_ATOMIC_COUNTERS_EXT",
                0,
            ),
            (
                tokens.max_geometry_image_uniforms,
                "GL_MAX_GEOMETRY_IMAGE_UNIFORMS_EXT",
                0,
            ),
            (
                tokens.max_geometry_texture_image_units,
                "GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT",
                16,
            ),
            (
                tokens.max_geometry_shader_storage_blocks,
                "GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS_EXT",
                0,
            ),
            (
                tokens.max_geometry_uniform_components,
                "GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT",
                1024,
            ),
            (
                tokens.max_geometry_uniform_blocks,
                "GL_MAX_GEOMETRY_UNIFORM_BLOCKS_EXT",
                12,
            ),
            (
                tokens.max_geometry_input_components,
                "GL_MAX_GEOMETRY_INPUT_COMPONENTS_EXT",
                64,
            ),
            (
                tokens.max_geometry_output_components,
                "GL_MAX_GEOMETRY_OUTPUT_COMPONENTS_EXT",
                64,
            ),
            (
                tokens.max_geometry_output_vertices,
                "GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT",
                256,
            ),
            (
                tokens.max_geometry_total_output_components,
                "GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT",
                1024,
            ),
            (
                tokens.max_geometry_shader_invocations,
                "GL_MAX_GEOMETRY_SHADER_INVOCATIONS_EXT",
                32,
            ),
            (tokens.max_framebuffer_layers, "GL_MAX_FRAMEBUFFER_LAYERS_EXT", 256),
        ];
        for (pname, name, minimum) in minimums {
            let int_value = get_integer(gl, pname, name)?;
            if int_value < minimum {
                log::info!(
                    "Reported {name} constant value {int_value} is smaller than required minimum value of {minimum}"
                );
                has_failed = true;
            }
        }

        // Compute minimum value that is acceptable for gl_MaxCombinedGeometryUniformComponents
        let n_max_geometry_uniform_blocks = get_integer(
            gl,
            tokens.max_geometry_uniform_blocks,
            "GL_MAX_GEOMETRY_UNIFORM_BLOCKS_EXT.",
        )?;
        let n_max_geometry_uniform_block_size =
            get_integer(gl, glw::GL_MAX_UNIFORM_BLOCK_SIZE, "GL_MAX_UNIFORM_BLOCK_SIZE.")?;
        let n_max_geometry_uniform_components = get_integer(
            gl,
            tokens.max_geometry_uniform_components,
            "GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT.",
        )?;
        let n_max_combined_geometry_uniform_components =
            n_max_geometry_uniform_blocks.wrapping_mul(n_max_geometry_uniform_block_size) / 4
                + n_max_geometry_uniform_components;

        let int_value = get_integer(
            gl,
            tokens.max_combined_geometry_uniform_components,
            "GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS_EXT.",
        )?;
        if int_value < n_max_combined_geometry_uniform_components {
            log::info!(
                "Reported GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS_EXT constant value {int_value} is smaller than required minimum value of {n_max_combined_geometry_uniform_components}"
            );
            has_failed = true;
        }

        // Make sure value reported for GL_LAYER_PROVOKING_VERTEX_EXT is valid
        let int_value = get_integer(gl, tokens.layer_provoking_vertex, "GL_LAYER_PROVOKING_VERTEX_EXT.")? as GLenum;
        let is_es = !context.context_type().api.desktop;
        // The desktop-only GL_PROVOKING_VERTEX is allowed in Desktop OpenGL, but not in the ES 3.1 extension; upstream's `&&` precedence is kept.
        if (!is_es && int_value != glw::GL_PROVOKING_VERTEX)
            && int_value != tokens.first_vertex_convention
            && int_value != tokens.last_vertex_convention
            && int_value != tokens.undefined_vertex
        {
            log::info!(
                "Reported GL_LAYER_PROVOKING_VERTEX_EXT constant value {int_value} is not among permissible values"
            );
            has_failed = true;
        }

        Ok(if has_failed {
            TestStatus::fail("Fail")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

impl TestCase for ConstantVariables {
    fn name(&self) -> &str {
        "constant_variables"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.vs_id, resources.gs_id, resources.fs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
