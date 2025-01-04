// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLimits.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported here: `GeometryShaderLimitsTransformFeedbackBase` and its three classes (`GeometryShaderMaxUniformComponentsTest`, `GeometryShaderMaxUniformBlocksTest`, `GeometryShaderMaxInputComponentsTest`) as one `Limits` with a `Kind`, `GeometryShaderMaxOutputVerticesTest` as `MaxOutputVertices`, and `GeometryShaderLimitsRenderingBase` with `GeometryShaderMaxOutputComponentsTest` / `GeometryShaderMaxOutputComponentsSinglePointTest` as `OutputComponents`, `GeometryShaderMaxTextureUnitsTest` as `MaxTextureUnits` and `GeometryShaderMaxCombinedTextureUnitsTest` as `CombinedTextureUnits` and `GeometryShaderMaxInvocationsTest` as `MaxInvocations`, which makes the group complete. On a desktop context the point size range is `GL_POINT_SIZE_RANGE` and `GL_PROGRAM_POINT_SIZE` is enabled around the run. The virtual `getShaderParts`/`prepareProgramInput`/`verifyResult`/`clean` are `match`es on the kind. `deinit` also disables RASTERIZER_DISCARD, which upstream leaves enabled.

use std::ffi::{CString, c_char, c_void};

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const VS_CODE: &str =
    "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, 0, 0, 1);\n}\n";
const FS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\nprecision mediump float;\nout vec4 fs_out_color;\nvoid main()\n{\n    fs_out_color = vec4(1, 1, 1, 1);\n}\n";

const COMPONENTS_GS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\n// definition of NUMBER_OF_UNIFORMS goes here\n";
const COMPONENTS_GS_NUMBER_OF_UNIFORMS: &str = "#define NUMBER_OF_UNIFORMS ";
const COMPONENTS_GS_BODY: &str = "u\n\nuniform ivec4 uni_array[NUMBER_OF_UNIFORMS];\n\nflat out uint gs_out_sum;\n\nvoid main()\n{\n    gs_out_sum = 0u;\n\n    for (uint i = 0u; i < NUMBER_OF_UNIFORMS; ++i)\n    {\n        gs_out_sum += uint(uni_array[i].x);\n        gs_out_sum += uint(uni_array[i].y);\n        gs_out_sum += uint(uni_array[i].z);\n        gs_out_sum += uint(uni_array[i].w);\n    }\n    EmitVertex();\n    \n    EndPrimitive();\n}\n";

const BLOCKS_GS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\n// definition of NUMBER_OF_UNIFORMS goes here\n";
const BLOCKS_GS_NUMBER_OF_UNIFORM_BLOCKS: &str = "#define NUMBER_OF_UNIFORM_BLOCKS ";
const BLOCKS_GS_BODY_BEGIN: &str = "u\n\nlayout(binding = 0) uniform UniformBlock\n{\n    int entry;\n} uni_block_array[NUMBER_OF_UNIFORM_BLOCKS];\n\nflat out int gs_out_sum;\n\nvoid main()\n{\n    gs_out_sum = 0;\n\n";
const BLOCKS_GS_BODY_END: &str = "\n    EmitVertex();\n\n    EndPrimitive();\n}\n";

const INPUT_VS_PREAMBLE: &str =
    "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\n// definition of NUMBER_OF_GEOMETRY_INPUT_VECTORS\n";
const INPUT_NUMBER_OF_VECTORS: &str = "#define NUMBER_OF_GEOMETRY_INPUT_VECTORS ";
const INPUT_VS_BODY: &str = "u\n\nout Vertex\n{   flat out ivec4 vs_gs_out[NUMBER_OF_GEOMETRY_INPUT_VECTORS];\n};\n\nvoid main()\n{\n   int index = 1;\n\n   for (uint i = 0u; i < NUMBER_OF_GEOMETRY_INPUT_VECTORS; ++i)\n   {\n       vs_gs_out[i] = ivec4(index, index + 1, index + 2, index + 3);\n       index       += 4;\n   }\n}\n";
const INPUT_GS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\n// definition of NUMBER_OF_GEOMETRY_INPUT_VECTORS goes here\n";
const INPUT_GS_BODY: &str = "u\n\nin Vertex\n{\n    flat in ivec4 vs_gs_out[NUMBER_OF_GEOMETRY_INPUT_VECTORS];\n} vertex[1];\n\nflat out int gs_out_sum;\n\nvoid main()\n{\n    gs_out_sum = 0;\n\n    for (uint i = 0u; i < NUMBER_OF_GEOMETRY_INPUT_VECTORS; ++i)\n    {\n        gs_out_sum += vertex[0].vs_gs_out[i].x;\n        gs_out_sum += vertex[0].vs_gs_out[i].y;\n        gs_out_sum += vertex[0].vs_gs_out[i].z;\n        gs_out_sum += vertex[0].vs_gs_out[i].w;\n    }\n    EmitVertex();\n    \n    EndPrimitive();\n}\n";

const CAPTURED_VARYING_NAME: &str = "gs_out_sum";
const BUFFER_SIZE: usize = size_of::<GLint>();

#[derive(Clone, Copy)]
pub(super) enum Kind {
    MaxUniformComponents,
    MaxUniformBlocks,
    MaxInputComponents,
}

/// `GeometryShaderMaxUniformComponentsTest`, `GeometryShaderMaxUniformBlocksTest` and `GeometryShaderMaxInputComponentsTest`
pub(super) struct Limits {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

#[derive(Default)]
struct Resources {
    fs_id: GLuint,
    gs_id: GLuint,
    vs_id: GLuint,
    po_id: GLuint,
    bo_id: GLuint,
    vao_id: GLuint,
    uniform_block_buffers: Vec<GLuint>,
}

impl Limits {
    /// `GeometryShaderLimitsTransformFeedbackBase::iterate`
    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = &base.gl_ext_tokens;

        // initTest
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // getShaderParts
        let mut limit: GLint = 0;
        let (fragment_parts, geometry_parts, vertex_parts): (Vec<String>, Vec<String>, Vec<String>) = match self.kind {
            Kind::MaxUniformComponents => {
                gl!(gl.get_integerv(tokens.max_geometry_uniform_components, &mut limit));
                let max_uniform_vectors = limit / 4;
                (
                    vec![FS_CODE.to_string()],
                    vec![
                        COMPONENTS_GS_PREAMBLE.to_string(),
                        COMPONENTS_GS_NUMBER_OF_UNIFORMS.to_string(),
                        max_uniform_vectors.to_string(),
                        COMPONENTS_GS_BODY.to_string(),
                    ],
                    vec![VS_CODE.to_string()],
                )
            }
            Kind::MaxUniformBlocks => {
                gl!(gl.get_integerv(tokens.max_geometry_uniform_blocks, &mut limit));
                let access: String = (0..limit)
                    .map(|uniform_block_nr| format!("    gs_out_sum += uni_block_array[{uniform_block_nr}].entry;\n"))
                    .collect();
                (
                    vec![FS_CODE.to_string()],
                    vec![
                        BLOCKS_GS_PREAMBLE.to_string(),
                        BLOCKS_GS_NUMBER_OF_UNIFORM_BLOCKS.to_string(),
                        limit.to_string(),
                        BLOCKS_GS_BODY_BEGIN.to_string(),
                        access,
                        BLOCKS_GS_BODY_END.to_string(),
                    ],
                    vec![VS_CODE.to_string()],
                )
            }
            Kind::MaxInputComponents => {
                gl!(gl.get_integerv(tokens.max_geometry_input_components, &mut limit));
                let max_input_vectors = limit / 4;
                (
                    vec![FS_CODE.to_string()],
                    vec![
                        INPUT_GS_PREAMBLE.to_string(),
                        INPUT_NUMBER_OF_VECTORS.to_string(),
                        max_input_vectors.to_string(),
                        INPUT_GS_BODY.to_string(),
                    ],
                    vec![
                        INPUT_VS_PREAMBLE.to_string(),
                        INPUT_NUMBER_OF_VECTORS.to_string(),
                        max_input_vectors.to_string(),
                        INPUT_VS_BODY.to_string(),
                    ],
                )
            }
        };

        resources.po_id = gl!(gl.create_program());
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(tokens.geometry_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "Could not create program and shader objects")?;

        let varying_name = CString::new(CAPTURED_VARYING_NAME).expect("no nul byte");
        let varying_names: [*const c_char; 1] = [varying_name.as_ptr()];
        gl!(gl.transform_feedback_varyings(resources.po_id, 1, varying_names.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));

        let fragment_refs: Vec<&str> = fragment_parts.iter().map(String::as_str).collect();
        let geometry_refs: Vec<&str> = geometry_parts.iter().map(String::as_str).collect();
        let vertex_refs: Vec<&str> = vertex_parts.iter().map(String::as_str).collect();
        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &fragment_refs),
                ShaderBody::Source(resources.gs_id, &geometry_refs),
                ShaderBody::Source(resources.vs_id, &vertex_refs),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            BUFFER_SIZE as isize,
            std::ptr::null(),
            glw::GL_STATIC_COPY
        ));
        glu::expect_no_error(gl, "Could not set up the transform feedback buffer")?;

        // iterate
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        gl!(gl.use_program(resources.po_id));

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        {
            self.prepare_program_input(context, resources, limit)?;
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        }
        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "Rendering failed")?;

        let transform_feedback_data = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            BUFFER_SIZE as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "glMapBufferRange failed")?;
        if transform_feedback_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange returned NULL".to_string()));
        }
        // SAFETY: the mapping covers the one integer the buffer was sized for.
        let extracted = unsafe { transform_feedback_data.cast::<GLint>().read_unaligned() };

        // verifyResult
        let expected = ((1 + limit) * limit) / 2;
        let result = extracted == expected;
        if !result {
            log::info!("Wrong result! Expected: {expected} Extracted: {extracted}");
        }

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));

        self.clean(context, resources);

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }

    /// `prepareProgramInput`
    fn prepare_program_input(
        &self,
        context: &Context,
        resources: &mut Resources,
        limit: GLint,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        match self.kind {
            Kind::MaxUniformComponents => {
                let uniform_location = gl!(gl.get_uniform_location(resources.po_id, c"uni_array".as_ptr()));
                if uniform_location == -1 {
                    return Err(TestError::Fail("Invalid uniform location".to_string()));
                }

                let uniform_data: Vec<GLint> = (0..limit).map(|i| i + 1).collect();
                gl!(gl.uniform_4iv(uniform_location, limit / 4, uniform_data.as_ptr()));
            }
            Kind::MaxUniformBlocks => {
                for i in 0..limit {
                    let mut buffer_object_id: GLuint = 0;
                    gl!(gl.gen_buffers(1, &mut buffer_object_id));
                    resources.uniform_block_buffers.push(buffer_object_id);
                    gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buffer_object_id));

                    let data: GLint = i + 1;
                    gl!(gl.buffer_data(
                        glw::GL_UNIFORM_BUFFER,
                        size_of::<GLint>() as isize,
                        (&data as *const GLint).cast::<c_void>(),
                        glw::GL_STATIC_DRAW
                    ));
                    gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, i as GLuint, buffer_object_id));
                }
            }
            Kind::MaxInputComponents => {}
        }
        Ok(())
    }

    /// `clean`
    fn clean(&self, context: &Context, resources: &mut Resources) {
        let gl = context.gl();

        if let Kind::MaxUniformBlocks = self.kind {
            gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0));
            for (i, buffer_object_id) in resources.uniform_block_buffers.drain(..).enumerate() {
                gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, i as GLuint, 0));
                gl!(gl.delete_buffers(1, &buffer_object_id));
            }
        }
    }
}

impl TestCase for Limits {
    fn name(&self) -> &str {
        match self.kind {
            Kind::MaxUniformComponents => "max_uniform_components",
            Kind::MaxUniformBlocks => "max_uniform_blocks",
            Kind::MaxInputComponents => "max_input_components",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        self.clean(context, &mut resources);
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
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

const OUTPUT_VERTICES_VS_CODE: &str =
    "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, 0, 0, 1);\n}\n";
const OUTPUT_VERTICES_GS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\n// definition of NUMBER_OF_POINTS goes here\n#define NUMBER_OF_POINTS ";
const OUTPUT_VERTICES_GS_BODY: &str = "u\n\nlayout(points)                                in;\nlayout(points, max_vertices=NUMBER_OF_POINTS) out;\n\nvoid main()\n{\n    int index = 0;\n\n    for (uint point = 0u; point < NUMBER_OF_POINTS; ++point)\n    {\n        EmitVertex();\n        EndPrimitive();\n    }\n\n}\n";
const OUTPUT_VERTICES_FS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 fs_out;\n\nvoid main()\n{\n    fs_out = vec4(1, 1, 1, 1);\n}\n";

/// `GeometryShaderMaxOutputVerticesTest`
pub(super) struct MaxOutputVertices {
    pub ext_params: ExtParameters,
}

impl TestCase for MaxOutputVertices {
    fn name(&self) -> &str {
        "max_output_vertices"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        let mut max_output_vertices: GLint = 0;
        gl!(gl.get_integerv(
            base.gl_ext_tokens.max_geometry_output_vertices,
            &mut max_output_vertices
        ));

        let valid_output_vertices_string = max_output_vertices.to_string();
        let invalid_output_vertices_string = (max_output_vertices + 1).to_string();

        let geometry_shader_valid_parts = [
            OUTPUT_VERTICES_GS_PREAMBLE,
            valid_output_vertices_string.as_str(),
            OUTPUT_VERTICES_GS_BODY,
        ];
        let geometry_shader_invalid_parts = [
            OUTPUT_VERTICES_GS_PREAMBLE,
            invalid_output_vertices_string.as_str(),
            OUTPUT_VERTICES_GS_BODY,
        ];

        let does_valid_build = base.does_program_build(
            context,
            &[OUTPUT_VERTICES_FS_CODE],
            &geometry_shader_valid_parts,
            &[OUTPUT_VERTICES_VS_CODE],
        )?;
        let does_invalid_build = base.does_program_build(
            context,
            &[OUTPUT_VERTICES_FS_CODE],
            &geometry_shader_invalid_parts,
            &[OUTPUT_VERTICES_VS_CODE],
        )?;

        if does_valid_build && !does_invalid_build {
            return Ok(TestStatus::pass("Pass"));
        }

        if !does_valid_build {
            log::info!("Failed to build valid program! GS::max_vertices set to MAX_GEOMETRY_OUTPUT_VERTICES.\n");
        }
        if does_invalid_build {
            log::info!(
                "Build of invalid program was successful! GS::max_vertices set to MAX_GEOMETRY_OUTPUT_VERTICES + 1.\n"
            );
        }
        Ok(TestStatus::fail("Fail"))
    }
}

const POINT_SIZE: GLuint = 2;
const TEXTURE_PIXEL_SIZE: usize = 4 * size_of::<GLint>();

const OUT_VS_CODE: &str =
    "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, 0, 0, 1);\n}\n";
const OUT_GS_PREAMBLE_MULTIPLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GEOMETRY_POINT_SIZE_ENABLE}\n\n// definition of NUMBER_OF_POINTS goes here\n";
const OUT_GS_NUMBER_OF_POINTS: &str = "#define NUMBER_OF_POINTS ";
const OUT_GS_LAYOUT: &str =
    "u\n\nlayout(points)                                in;\nlayout(points, max_vertices=NUMBER_OF_POINTS) out;\n\n";
const OUT_GS_BODY_BEGIN_MULTIPLE: &str = "\nvoid main()\n{\n    int index = 1;\n\n    for (uint point = 0u; point < NUMBER_OF_POINTS; ++point)\n    {\n        // gs_fs_out assignments go here\n";
const OUT_GS_BODY_END_MULTIPLE: &str = "\n        gl_PointSize = 2.0;\n        gl_Position = vec4(-1.0 + ((2.0 / float(NUMBER_OF_POINTS)) * float(point)) + (1.0 / float(NUMBER_OF_POINTS)), 0.0, 0.0, 1.0);\n\n        EmitVertex();\n        EndPrimitive();\n    }\n}\n";
const OUT_GS_PREAMBLE_SINGLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GEOMETRY_POINT_SIZE_ENABLE}\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\n";
const OUT_GS_BODY_BEGIN_SINGLE: &str = "\nvoid main()\n{\n    int index = 1;\n\n    // gs_fs_out assignments go here\n";
const OUT_GS_BODY_END_SINGLE: &str = "\n    gl_PointSize = 2.0;\n    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n\n    EmitVertex();\n    EndPrimitive();\n}\n";
const OUT_DEFINITIONS: &str = "// definitions of gs_fs_out_ varyings go here\n";
const OUT_GS_ASSIGNMENT: &str = " = ivec4(index++, index++, index++, index++);\n";
const OUT_FS_PREAMBLE_MULTIPLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\nprecision highp int;\n\n";
const OUT_FS_PREAMBLE_SINGLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\n";
const OUT_FS_BODY_BEGIN: &str =
    "\nlayout(location = 0) out int fs_out;\n\nvoid main()\n{\n    int sum = 0;\n\n    // sum calculation go here\n";
const OUT_FS_BODY_END: &str = "\n    fs_out = sum;\n}\n";

#[derive(Clone, Copy, PartialEq)]
pub(super) enum OutputKind {
    MaxOutputComponents,
    MaxOutputComponentsSinglePoint,
}

/// `GeometryShaderLimitsRenderingBase` with `GeometryShaderMaxOutputComponentsTest` and `GeometryShaderMaxOutputComponentsSinglePointTest`
pub(super) struct OutputComponents {
    pub ext_params: ExtParameters,
    pub kind: OutputKind,
}

#[derive(Default)]
struct RenderingResources {
    fs_id: GLuint,
    gs_id: GLuint,
    vs_id: GLuint,
    po_id: GLuint,
    framebuffer_id: GLuint,
    color_texture_id: GLuint,
    vao_id: GLuint,
}

impl OutputComponents {
    fn run(&self, context: &Context, resources: &mut RenderingResources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = &base.gl_ext_tokens;
        let multiple = self.kind == OutputKind::MaxOutputComponents;

        // initTest
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }
        if !base.is_gpu_shader5_supported {
            return Err(TestError::NotSupported(
                "GPU shader5 functionality not supported, skipping".to_string(),
            ));
        }

        let mut point_size_range = [0.0f32; 2];
        gl!(gl.get_floatv(glw::GL_POINT_SIZE_RANGE, point_size_range.as_mut_ptr()));

        // getRequiredPointSize
        if !base.is_geometry_shader_point_size_supported {
            return Err(TestError::NotSupported(
                "Geometry shader point size functionality not supported, skipping".to_string(),
            ));
        }
        let required_point_size = POINT_SIZE as f32;
        if required_point_size > point_size_range[1] {
            log::info!(
                "Test requires a minimum maximum point size of: {required_point_size}, implementation reports a maximum of : {}",
                point_size_range[1]
            );
            return Err(TestError::NotSupported(
                "Required point size is not supported".to_string(),
            ));
        }

        gl!(gl.enable(glw::GL_PROGRAM_POINT_SIZE));

        // getShaderParts
        let mut max_total_output_components: GLint = 0;
        let mut max_output_components: GLint = 0;
        gl!(gl.get_integerv(
            tokens.max_geometry_total_output_components,
            &mut max_total_output_components
        ));
        gl!(gl.get_integerv(tokens.max_geometry_output_components, &mut max_output_components));
        let n_output_points = if multiple {
            max_total_output_components / max_output_components
        } else {
            1
        };
        let max_output_vectors = max_output_components / 4;
        // 2 vectors are reserved for gl_Position and gl_PointSize
        let n_available_vectors = max_output_vectors - 2;
        let texture_width = if multiple {
            POINT_SIZE * n_output_points as GLuint
        } else {
            POINT_SIZE
        };
        let texture_height = POINT_SIZE;

        let mut fragment_shader_code = String::from(if multiple {
            OUT_FS_PREAMBLE_MULTIPLE
        } else {
            OUT_FS_PREAMBLE_SINGLE
        });
        fragment_shader_code.push_str(OUT_DEFINITIONS);
        for i in 0..n_available_vectors {
            fragment_shader_code.push_str(&format!("flat in ivec4 gs_fs_out_{i};\n"));
        }
        fragment_shader_code.push_str(OUT_FS_BODY_BEGIN);
        for i in 0..n_available_vectors {
            fragment_shader_code.push_str(&format!(
                "    sum += gs_fs_out_{i}.x + gs_fs_out_{i}.y + gs_fs_out_{i}.z + gs_fs_out_{i}.w;\n"
            ));
        }
        fragment_shader_code.push_str(OUT_FS_BODY_END);

        let mut geometry_shader_code = String::new();
        if multiple {
            geometry_shader_code.push_str(OUT_GS_PREAMBLE_MULTIPLE);
            geometry_shader_code.push_str(OUT_GS_NUMBER_OF_POINTS);
            geometry_shader_code.push_str(&n_output_points.to_string());
            geometry_shader_code.push_str(OUT_GS_LAYOUT);
        } else {
            geometry_shader_code.push_str(OUT_GS_PREAMBLE_SINGLE);
        }
        geometry_shader_code.push_str(OUT_DEFINITIONS);
        for i in 0..n_available_vectors {
            geometry_shader_code.push_str(&format!("flat out ivec4 gs_fs_out_{i};\n"));
        }
        geometry_shader_code.push_str(if multiple {
            OUT_GS_BODY_BEGIN_MULTIPLE
        } else {
            OUT_GS_BODY_BEGIN_SINGLE
        });
        for i in 0..n_available_vectors {
            let indent = if multiple { "        " } else { "    " };
            geometry_shader_code.push_str(&format!("{indent}gs_fs_out_{i}{OUT_GS_ASSIGNMENT}"));
        }
        geometry_shader_code.push_str(if multiple {
            OUT_GS_BODY_END_MULTIPLE
        } else {
            OUT_GS_BODY_END_SINGLE
        });

        resources.po_id = gl!(gl.create_program());
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(tokens.geometry_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "Could not create program and shader objects")?;

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[fragment_shader_code.as_str()]),
                ShaderBody::Source(resources.gs_id, &[geometry_shader_code.as_str()]),
                ShaderBody::Source(resources.vs_id, &[OUT_VS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));

        // getFramebufferDetails
        let texture_format = glw::GL_R32I;
        let texture_read_format = glw::GL_RGBA_INTEGER;
        let texture_read_type = glw::GL_INT;

        gl!(gl.gen_textures(1, &mut resources.color_texture_id));
        gl!(gl.gen_framebuffers(1, &mut resources.framebuffer_id));
        if !TestCaseBase::setup_framebuffer_with_texture_as_attachment(
            context,
            resources.framebuffer_id,
            resources.color_texture_id,
            texture_format,
            texture_width,
            texture_height,
        )? {
            return Err(TestError::Fail("Failed to setup framebuffer".to_string()));
        }

        // iterate
        let mut result_image = vec![0u8; texture_width as usize * texture_height as usize * TEXTURE_PIXEL_SIZE];

        gl!(gl.use_program(resources.po_id));

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));

        gl!(gl.read_pixels(
            0,
            0,
            texture_width as i32,
            texture_height as i32,
            texture_read_format,
            texture_read_type,
            result_image.as_mut_ptr().cast::<c_void>()
        ));

        // verifyResult
        let line_size = texture_width as usize * TEXTURE_PIXEL_SIZE;
        let n_components_per_point = n_available_vectors * 4;
        let texel_value = |texel_offset: usize| {
            GLint::from_ne_bytes(
                result_image[texel_offset..texel_offset + size_of::<GLint>()]
                    .try_into()
                    .expect("four bytes"),
            )
        };

        let mut result = true;
        'points: for point in 0..n_output_points {
            let first_value = point * n_components_per_point + 1;
            let last_value = (point + 1) * n_components_per_point;
            let expected_value = ((first_value + last_value) * n_components_per_point) / 2;
            let point_offset = point as usize * TEXTURE_PIXEL_SIZE * POINT_SIZE as usize;

            for y in 0..POINT_SIZE as usize {
                let first_texel_offset = y * line_size + point_offset;

                for x in 0..POINT_SIZE as usize {
                    let texel_offset = first_texel_offset + x * TEXTURE_PIXEL_SIZE;
                    let extracted = texel_value(texel_offset);

                    if extracted != expected_value {
                        if multiple {
                            log::info!(
                                "Wrong result! Expected: {expected_value} Extracted: {extracted} Point: {point} X: {x} Y: {y}"
                            );
                        } else {
                            log::info!(
                                "Wrong result! Expected: {expected_value} Extracted: {extracted}  X: {x} Y: {y}"
                            );
                        }
                        result = false;
                        break 'points;
                    }
                }
            }
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for OutputComponents {
    fn name(&self) -> &str {
        match self.kind {
            OutputKind::MaxOutputComponents => "max_output_components",
            OutputKind::MaxOutputComponentsSinglePoint => "max_output_components_single_point",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = RenderingResources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.disable(glw::GL_PROGRAM_POINT_SIZE));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.framebuffer_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.framebuffer_id));
        }
        if resources.color_texture_id != 0 {
            gl!(gl.delete_textures(1, &resources.color_texture_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}

const TEXTURE_UNITS_VS_PREAMBLE: &str =
    "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\n#define NUMBER_OF_POINTS ";
const TEXTURE_UNITS_VS_BODY: &str = "u\n\nflat out int vs_gs_vertex_id;\n\nvoid main()\n{\n    gl_Position     = vec4(-1.0 + ((2.0 / float(NUMBER_OF_POINTS)) * float(gl_VertexID)) + (1.0 / float(NUMBER_OF_POINTS)), 0, 0, 1.0);\n    vs_gs_vertex_id = gl_VertexID;\n}\n";
const TEXTURE_UNITS_GS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GEOMETRY_POINT_SIZE_ENABLE}\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\n#define NUMBER_OF_POINTS ";
const TEXTURE_UNITS_GS_BODY: &str = "u\n\n// NUMBER_OF_POINTS == NUMBER_OF_SAMPLERS\n     uniform lowp isampler2D gs_texture[NUMBER_OF_POINTS];\nflat in      int        vs_gs_vertex_id[1];\nflat out     int        gs_fs_color;\n\nvoid main()\n{\n    float half_of_edge = (1.0 / float(NUMBER_OF_POINTS));\n    int   color        = 0;\n\n    for (uint i = 0u; i <= uint(vs_gs_vertex_id[0]); ++i)\n    {\n        color += texture(gs_texture[i], vec2(0.0, 0.0)).r;\n    }\n\n    gl_Position = gl_in[0].gl_Position + vec4(-half_of_edge,  1.0, 0, 0);\n    gs_fs_color = color;\n    EmitVertex();\n\n    gl_Position = gl_in[0].gl_Position + vec4( half_of_edge,  1.0, 0, 0);\n    gs_fs_color = color;\n    EmitVertex();\n\n    gl_Position = gl_in[0].gl_Position + vec4(-half_of_edge, -1.0, 0, 0);\n    gs_fs_color = color;\n    EmitVertex();\n\n    gl_Position = gl_in[0].gl_Position + vec4( half_of_edge, -1.0, 0, 0);\n    gs_fs_color = color;\n    EmitVertex();\n    EndPrimitive();\n}\n";
const TEXTURE_UNITS_FS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nflat                 in  int gs_fs_color;\nlayout(location = 0) out int fs_out_color;\n\nvoid main()\n{\n    fs_out_color = gs_fs_color;\n}\n";

/// `GeometryShaderMaxTextureUnitsTest`
pub(super) struct MaxTextureUnits {
    pub ext_params: ExtParameters,
}

impl MaxTextureUnits {
    fn run(
        &self,
        context: &Context,
        resources: &mut RenderingResources,
        textures: &mut Vec<(GLuint, GLint)>,
    ) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = &base.gl_ext_tokens;

        // initTest
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }
        if !base.is_gpu_shader5_supported {
            return Err(TestError::NotSupported(
                "GPU shader5 functionality not supported, skipping".to_string(),
            ));
        }

        let mut point_size_range = [0.0f32; 2];
        gl!(gl.get_floatv(glw::GL_POINT_SIZE_RANGE, point_size_range.as_mut_ptr()));

        // getRequiredPointSize
        if !base.is_geometry_shader_point_size_supported {
            return Err(TestError::NotSupported(
                "Geometry shader point size functionality not supported, skipping".to_string(),
            ));
        }
        let required_point_size = POINT_SIZE as f32;
        if required_point_size > point_size_range[1] {
            log::info!(
                "Test requires a minimum maximum point size of: {required_point_size}, implementation reports a maximum of : {}",
                point_size_range[1]
            );
            return Err(TestError::NotSupported(
                "Required point size is not supported".to_string(),
            ));
        }

        gl!(gl.enable(glw::GL_PROGRAM_POINT_SIZE));

        // getShaderParts
        let mut max_texture_units: GLint = 0;
        gl!(gl.get_integerv(tokens.max_geometry_texture_image_units, &mut max_texture_units));
        let texture_width = max_texture_units as GLuint * POINT_SIZE;
        let texture_height = POINT_SIZE;
        let max_texture_units_string = max_texture_units.to_string();

        resources.po_id = gl!(gl.create_program());
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(tokens.geometry_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "Could not create program and shader objects")?;

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[TEXTURE_UNITS_FS_CODE]),
                ShaderBody::Source(
                    resources.gs_id,
                    &[
                        TEXTURE_UNITS_GS_PREAMBLE,
                        max_texture_units_string.as_str(),
                        TEXTURE_UNITS_GS_BODY,
                    ],
                ),
                ShaderBody::Source(
                    resources.vs_id,
                    &[
                        TEXTURE_UNITS_VS_PREAMBLE,
                        max_texture_units_string.as_str(),
                        TEXTURE_UNITS_VS_BODY,
                    ],
                ),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));

        gl!(gl.gen_textures(1, &mut resources.color_texture_id));
        gl!(gl.gen_framebuffers(1, &mut resources.framebuffer_id));
        if !TestCaseBase::setup_framebuffer_with_texture_as_attachment(
            context,
            resources.framebuffer_id,
            resources.color_texture_id,
            glw::GL_R32I,
            texture_width,
            texture_height,
        )? {
            return Err(TestError::Fail("Failed to setup framebuffer".to_string()));
        }

        // iterate
        let mut result_image = vec![0u8; texture_width as usize * texture_height as usize * TEXTURE_PIXEL_SIZE];

        gl!(gl.use_program(resources.po_id));

        // prepareProgramInput
        for i in 0..max_texture_units {
            let data: GLint = i * 2 + 1;
            let mut texture_id: GLuint = 0;
            gl!(gl.gen_textures(1, &mut texture_id));
            textures.push((texture_id, data));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_R32I as GLint,
                1,
                1,
                0,
                glw::GL_RED_INTEGER,
                glw::GL_INT,
                (&data as *const GLint).cast::<c_void>()
            ));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        }

        for i in 0..max_texture_units {
            let name = CString::new(format!("gs_texture[{i}]")).expect("no nul byte");
            let gs_texture_location = gl!(gl.get_uniform_location(resources.po_id, name.as_ptr()));
            if gs_texture_location == -1 || gl!(gl.get_error()) != glw::GL_NO_ERROR {
                return Err(TestError::Fail("Failed to get uniform isampler2D location".to_string()));
            }

            gl!(gl.uniform_1i(gs_texture_location, i));
            if gl!(gl.get_error()) != glw::GL_NO_ERROR {
                log::info!("Failed to set uniform at location: {gs_texture_location} to value: {i}");
                return Err(TestError::Fail("Failed to get uniform isampler2D location".to_string()));
            }
        }

        for (i, (texture_id, _)) in textures.iter().enumerate() {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, *texture_id));
        }

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, max_texture_units));

        gl!(gl.read_pixels(
            0,
            0,
            texture_width as i32,
            texture_height as i32,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            result_image.as_mut_ptr().cast::<c_void>()
        ));

        // verifyResult
        let line_size = texture_width as usize * TEXTURE_PIXEL_SIZE;
        let texel_value = |texel_offset: usize| {
            GLint::from_ne_bytes(
                result_image[texel_offset..texel_offset + size_of::<GLint>()]
                    .try_into()
                    .expect("four bytes"),
            )
        };

        let mut result = true;
        'points: for point in 0..max_texture_units {
            let first_value = textures[0].1;
            let last_value = textures[point as usize].1;
            let expected_value = ((first_value + last_value) * (point + 1)) / 2;
            let point_offset = point as usize * TEXTURE_PIXEL_SIZE * POINT_SIZE as usize;

            for y in 0..POINT_SIZE as usize {
                let first_texel_offset = y * line_size + point_offset;

                for x in 0..POINT_SIZE as usize {
                    let extracted = texel_value(first_texel_offset + x * TEXTURE_PIXEL_SIZE);

                    if extracted != expected_value {
                        log::info!(
                            "Wrong result! Expected: {expected_value} Extracted: {extracted} Point: {point} X: {x} Y: {y}"
                        );
                        result = false;
                        break 'points;
                    }
                }
            }
        }

        // clean
        for i in 0..max_texture_units {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        for (texture_id, _) in textures.drain(..) {
            gl!(gl.delete_textures(1, &texture_id));
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for MaxTextureUnits {
    fn name(&self) -> &str {
        "max_texture_units"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = RenderingResources::default();
        let mut textures: Vec<(GLuint, GLint)> = Vec::new();
        let outcome = self.run(context, &mut resources, &mut textures);

        // deinit
        for (texture_id, _) in textures.drain(..) {
            gl!(gl.delete_textures(1, &texture_id));
        }
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.disable(glw::GL_PROGRAM_POINT_SIZE));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.framebuffer_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.framebuffer_id));
        }
        if resources.color_texture_id != 0 {
            gl!(gl.delete_textures(1, &resources.color_texture_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}

const COMBINED_VS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GPU_SHADER5_ENABLE}\n\nprecision highp float;\n\n#define NUMBER_OF_POINTS ";
const COMBINED_VS_BODY: &str = "u\n\n// NUMBER_OF_POINTS == NUMBER_OF_SAMPLERS\n     uniform highp usampler2D sampler[NUMBER_OF_POINTS];flat out     int        vs_gs_vertex_id;\nflat out     uint       vs_gs_sum;\n\nvoid main()\n{\n    uint sum = 0u;\n\n    for (uint i = 0u; i < uint(gl_VertexID); ++i)\n    {\n        sum += texture(sampler[i], vec2(0.0, 0.0)).r;\n    }\n\n    gl_Position     = vec4(-1.0 + ((2.0 / float(NUMBER_OF_POINTS)) * float(gl_VertexID)) + (1.0 / float(NUMBER_OF_POINTS)), 0, 0, 1.0);\n    vs_gs_vertex_id = gl_VertexID;\n    vs_gs_sum       = sum;\n}\n";
const COMBINED_GS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GPU_SHADER5_ENABLE}\n\nprecision highp float;\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\n#define NUMBER_OF_POINTS ";
const COMBINED_GS_BODY: &str = "u\n\n// NUMBER_OF_POINTS == NUMBER_OF_SAMPLERS\n     uniform highp usampler2D sampler[NUMBER_OF_POINTS];\nflat in      int        vs_gs_vertex_id[1];\nflat in      uint       vs_gs_sum      [1];\nflat out     int        gs_fs_vertex_id;\nflat out     uint       gs_fs_vertex_sum;\nflat out     uint       gs_fs_geometry_sum;\n\nvoid main()\n{\n    uint sum = 0u;\n\n    for (uint i = 0u; i < uint(vs_gs_vertex_id[0]); ++i)\n    {\n        sum += texture(sampler[i], vec2(0.0, 0.0)).r;\n    }\n\n    gl_Position        = gl_in[0].gl_Position;\n    gs_fs_vertex_id    = vs_gs_vertex_id[0];\n    gs_fs_vertex_sum   = vs_gs_sum      [0];\n    gs_fs_geometry_sum = sum;\n    EmitVertex();\n    EndPrimitive();\n}\n";
const COMBINED_FS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GPU_SHADER5_ENABLE}\n\nprecision highp float;\n\n// NUMBER_OF_POINTS == NUMBER_OF_SAMPLERS\n#define NUMBER_OF_POINTS ";
const COMBINED_FS_BODY: &str = "u\n\n                     uniform highp usampler2D sampler[NUMBER_OF_POINTS];\nflat                 in      int        gs_fs_vertex_id;\nflat                 in      uint       gs_fs_vertex_sum;\nflat                 in      uint       gs_fs_geometry_sum;\nlayout(location = 0) out     uint       fs_out_color;\n\nvoid main()\n{\n    uint sum = 0u;\n\n    for (uint i = 0u; i < uint(gs_fs_vertex_id); ++i)\n    {\n        sum += texture(sampler[i], vec2(0.0, 0.0)).r;\n    }\n    fs_out_color = sum + gs_fs_vertex_sum + gs_fs_geometry_sum;\n}\n";

/// `GeometryShaderMaxCombinedTextureUnitsTest`
pub(super) struct CombinedTextureUnits {
    pub ext_params: ExtParameters,
}

impl CombinedTextureUnits {
    fn run(
        &self,
        context: &Context,
        resources: &mut RenderingResources,
        textures: &mut Vec<(GLuint, GLuint)>,
    ) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = &base.gl_ext_tokens;
        let point_size: GLuint = 1;

        // initTest
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }
        if !base.is_gpu_shader5_supported {
            return Err(TestError::NotSupported(
                "GPU shader5 functionality not supported, skipping".to_string(),
            ));
        }

        let mut point_size_range = [0.0f32; 2];
        gl!(gl.get_floatv(glw::GL_POINT_SIZE_RANGE, point_size_range.as_mut_ptr()));

        // getRequiredPointSize
        let required_point_size = point_size as f32;
        if required_point_size > point_size_range[1] {
            log::info!(
                "Test requires a minimum maximum point size of: {required_point_size}, implementation reports a maximum of : {}",
                point_size_range[1]
            );
            return Err(TestError::NotSupported(
                "Required point size is not supported".to_string(),
            ));
        }

        gl!(gl.enable(glw::GL_PROGRAM_POINT_SIZE));

        // getShaderParts
        let mut max_combined_texture_units: GLint = 0;
        let mut max_vertex_texture_units: GLint = 0;
        let mut max_geometry_texture_units: GLint = 0;
        let mut max_fragment_texture_units: GLint = 0;
        gl!(gl.get_integerv(
            glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
            &mut max_combined_texture_units
        ));
        gl!(gl.get_integerv(glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, &mut max_vertex_texture_units));
        gl!(gl.get_integerv(tokens.max_geometry_texture_image_units, &mut max_geometry_texture_units));
        gl!(gl.get_integerv(glw::GL_MAX_TEXTURE_IMAGE_UNITS, &mut max_fragment_texture_units));

        let n_texture_units = max_vertex_texture_units.max(max_geometry_texture_units.max(max_fragment_texture_units));
        let n_vertex_texture_units = 1i32.max((max_combined_texture_units - 2).min(max_vertex_texture_units));
        let n_fragment_texture_units =
            1i32.max((max_combined_texture_units - n_vertex_texture_units - 1).min(max_fragment_texture_units));
        let n_geometry_texture_units = 1i32.max(
            (max_combined_texture_units - n_vertex_texture_units - n_fragment_texture_units)
                .min(max_geometry_texture_units),
        );
        let min_texture_units = n_vertex_texture_units.min(n_fragment_texture_units.min(n_geometry_texture_units));
        let texture_width = n_texture_units as GLuint * point_size;
        let texture_height = point_size;

        let n_fragment_texture_units_string = n_fragment_texture_units.to_string();
        let n_geometry_texture_units_string = n_geometry_texture_units.to_string();
        let n_vertex_texture_units_string = n_vertex_texture_units.to_string();

        resources.po_id = gl!(gl.create_program());
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(tokens.geometry_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "Could not create program and shader objects")?;

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(
                    resources.fs_id,
                    &[
                        COMBINED_FS_PREAMBLE,
                        n_fragment_texture_units_string.as_str(),
                        COMBINED_FS_BODY,
                    ],
                ),
                ShaderBody::Source(
                    resources.gs_id,
                    &[
                        COMBINED_GS_PREAMBLE,
                        n_geometry_texture_units_string.as_str(),
                        COMBINED_GS_BODY,
                    ],
                ),
                ShaderBody::Source(
                    resources.vs_id,
                    &[
                        COMBINED_VS_PREAMBLE,
                        n_vertex_texture_units_string.as_str(),
                        COMBINED_VS_BODY,
                    ],
                ),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));

        gl!(gl.gen_textures(1, &mut resources.color_texture_id));
        gl!(gl.gen_framebuffers(1, &mut resources.framebuffer_id));
        if !TestCaseBase::setup_framebuffer_with_texture_as_attachment(
            context,
            resources.framebuffer_id,
            resources.color_texture_id,
            glw::GL_R32UI,
            texture_width,
            texture_height,
        )? {
            return Err(TestError::Fail("Failed to setup framebuffer".to_string()));
        }

        // iterate
        let mut result_image = vec![0u8; texture_width as usize * texture_height as usize * TEXTURE_PIXEL_SIZE];

        gl!(gl.use_program(resources.po_id));

        // prepareProgramInput
        for i in 0..n_texture_units {
            let data: GLuint = i as GLuint % 16;
            let mut texture_id: GLuint = 0;
            gl!(gl.gen_textures(1, &mut texture_id));
            textures.push((texture_id, data));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_R32UI as GLint,
                1,
                1,
                0,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                (&data as *const GLuint).cast::<c_void>()
            ));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        }

        for i in 0..n_texture_units {
            let name = CString::new(format!("sampler[{i}]")).expect("no nul byte");
            let sampler_location = gl!(gl.get_uniform_location(resources.po_id, name.as_ptr()));
            if sampler_location == -1 || gl!(gl.get_error()) != glw::GL_NO_ERROR {
                return Err(TestError::Fail("Failed to get uniform usampler2D location".to_string()));
            }

            gl!(gl.uniform_1i(sampler_location, i));
            if gl!(gl.get_error()) != glw::GL_NO_ERROR {
                log::info!("Failed to set uniform at location: {sampler_location} to value: {i}");
                return Err(TestError::Fail("Failed to get uniform isampler2D location".to_string()));
            }
        }

        for (i, (texture_id, _)) in textures.iter().enumerate() {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, *texture_id));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        }

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, min_texture_units));

        gl!(gl.read_pixels(
            0,
            0,
            texture_width as i32,
            texture_height as i32,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
            result_image.as_mut_ptr().cast::<c_void>()
        ));

        // verifyResult
        let line_size = texture_width as usize * TEXTURE_PIXEL_SIZE;
        let texel_value = |texel_offset: usize| {
            GLint::from_ne_bytes(
                result_image[texel_offset..texel_offset + size_of::<GLint>()]
                    .try_into()
                    .expect("four bytes"),
            )
        };

        let mut result = true;
        'points: for point in 0..n_texture_units {
            let last_vertex_index = (point as usize).min(n_vertex_texture_units as usize);

            // Upstream sums the same range for the vertex, geometry and fragment stage.
            let sum: GLint = textures[..last_vertex_index]
                .iter()
                .map(|texture| texture.1 as GLint)
                .sum();
            let expected_value = sum + sum + sum;
            let point_offset = point as usize * TEXTURE_PIXEL_SIZE * point_size as usize;

            for y in 0..point_size as usize {
                let first_texel_offset = y * line_size + point_offset;

                for x in 0..point_size as usize {
                    let extracted = texel_value(first_texel_offset + x * TEXTURE_PIXEL_SIZE);

                    if extracted != expected_value {
                        log::info!(
                            "Wrong result! Expected: {expected_value} Extracted: {extracted} Point: {point} X: {x} Y: {y}"
                        );
                        result = false;
                        break 'points;
                    }
                }
            }
        }

        // clean
        for i in 0..n_texture_units {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }
        for (texture_id, _) in textures.drain(..) {
            gl!(gl.delete_textures(1, &texture_id));
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for CombinedTextureUnits {
    fn name(&self) -> &str {
        "max_combined_texture_units"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = RenderingResources::default();
        let mut textures: Vec<(GLuint, GLuint)> = Vec::new();
        let outcome = self.run(context, &mut resources, &mut textures);

        // deinit
        for (texture_id, _) in textures.drain(..) {
            gl!(gl.delete_textures(1, &texture_id));
        }
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.disable(glw::GL_PROGRAM_POINT_SIZE));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.framebuffer_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.framebuffer_id));
        }
        if resources.color_texture_id != 0 {
            gl!(gl.delete_textures(1, &resources.color_texture_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}

const INVOCATIONS_TRIANGLE_EDGE_LENGTH: GLuint = 9;
const INVOCATIONS_TEXTURE_HEIGHT: GLuint = INVOCATIONS_TRIANGLE_EDGE_LENGTH;
const INVOCATIONS_TEXTURE_PIXEL_SIZE: GLuint = 4;

const INVOCATIONS_FS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 fs_out_color;\n\nvoid main()\n{\n    fs_out_color = vec4(0.0, 1.0, 0.0, 0.0);\n}\n";
const INVOCATIONS_VS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, 0, 0, 1);\n}\n";
const INVOCATIONS_GS_PREAMBLE: &str =
    "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\n#define GEOMETRY_SHADER_INVOCATIONS ";
const INVOCATIONS_GS_LAYOUT: &str = "u\n\nlayout(points) in;\nlayout(triangle_strip, max_vertices = 3) out;\n";
const INVOCATIONS_GS_LAYOUT_INVOCATIONS: &str = "layout(invocations = GEOMETRY_SHADER_INVOCATIONS) in;\n";
const INVOCATIONS_GS_BODY: &str = "\nvoid main()\n{\n    float dx = (2.0 / float(GEOMETRY_SHADER_INVOCATIONS));\n    \n    gl_Position = vec4(-1.0 + (dx * float(gl_InvocationID)),      -1.001, 0.0, 1.0);\n    EmitVertex();\n    \n    gl_Position = vec4(-1.0 + (dx * float(gl_InvocationID)),       1.001, 0.0, 1.0);\n    EmitVertex();\n    \n    gl_Position = vec4(-1.0 + (dx * float(gl_InvocationID + 1)),   1.001, 0.0, 1.0);\n    EmitVertex();\n}\n";

#[derive(Default)]
struct InvocationsResources {
    multiple_po_id: GLuint,
    multiple_fs_id: GLuint,
    multiple_gs_id: GLuint,
    multiple_vs_id: GLuint,
    single_po_id: GLuint,
    single_fs_id: GLuint,
    single_gs_id: GLuint,
    single_vs_id: GLuint,
    vao_id: GLuint,
    color_texture_id: GLuint,
    framebuffer_id: GLuint,
}

/// `GeometryShaderMaxInvocationsTest`
pub(super) struct MaxInvocations {
    pub ext_params: ExtParameters,
}

impl MaxInvocations {
    /// The two checks `verifyResultOf{Multiple,Single}InvocationsPass` repeat for every triangle: its center has `center_color` and the bottom-right corner of its cell is background.
    fn verify_triangle(
        result_image: &[u8],
        texture_width: GLuint,
        i: GLuint,
        center_color: [u8; 4],
        max_geometry_shader_invocations: GLint,
    ) -> bool {
        let edge = INVOCATIONS_TRIANGLE_EDGE_LENGTH;
        let x1 = edge * i;
        let x2 = edge * i;
        let x3 = edge * (i + 1) - 1;
        let y1 = 0;
        let y2 = edge - 1;
        let y3 = edge - 1;
        let center_x = (x1 + x2 + x3) / 3;
        let center_y = (y1 + y2 + y3) / 3;

        let is_pixel_valid = TestCaseBase::compare_pixel(
            result_image,
            center_x,
            center_y,
            texture_width,
            INVOCATIONS_TEXTURE_HEIGHT,
            INVOCATIONS_TEXTURE_PIXEL_SIZE,
            center_color[0],
            center_color[1],
            center_color[2],
            center_color[3],
        );
        if !is_pixel_valid {
            log::info!(
                "Invalid pixel at [{center_x};{center_y}]! Triangle index: {i} from range <0:{max_geometry_shader_invocations})."
            );
            return false;
        }

        let x4 = edge * (i + 1) - 1;
        let y4 = edge - 1;
        let is_pixel_valid = TestCaseBase::compare_pixel(
            result_image,
            x4,
            y4,
            texture_width,
            INVOCATIONS_TEXTURE_HEIGHT,
            INVOCATIONS_TEXTURE_PIXEL_SIZE,
            255,
            0,
            0,
            0,
        );
        if !is_pixel_valid {
            log::info!(
                "Invalid pixel at [{x4};{y4}]! Background for index: {i} from range <0:{max_geometry_shader_invocations})."
            );
            return false;
        }
        true
    }

    fn run(&self, context: &Context, resources: &mut InvocationsResources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = &base.gl_ext_tokens;

        // initTest
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        let mut max_geometry_shader_invocations: GLint = 0;
        gl!(gl.get_integerv(
            tokens.max_geometry_shader_invocations,
            &mut max_geometry_shader_invocations
        ));
        let invocations_string = max_geometry_shader_invocations.to_string();

        resources.multiple_po_id = gl!(gl.create_program());
        resources.multiple_fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.multiple_gs_id = gl!(gl.create_shader(tokens.geometry_shader));
        resources.multiple_vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));

        resources.single_po_id = gl!(gl.create_program());
        resources.single_fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.single_gs_id = gl!(gl.create_shader(tokens.geometry_shader));
        resources.single_vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "Could not create program and shader objects")?;

        let (built, _) = base.build_program(
            context,
            resources.multiple_po_id,
            &[
                ShaderBody::Source(resources.multiple_fs_id, &[INVOCATIONS_FS_CODE]),
                ShaderBody::Source(
                    resources.multiple_gs_id,
                    &[
                        INVOCATIONS_GS_PREAMBLE,
                        invocations_string.as_str(),
                        INVOCATIONS_GS_LAYOUT,
                        INVOCATIONS_GS_LAYOUT_INVOCATIONS,
                        INVOCATIONS_GS_BODY,
                    ],
                ),
                ShaderBody::Source(resources.multiple_vs_id, &[INVOCATIONS_VS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        let (built, _) = base.build_program(
            context,
            resources.single_po_id,
            &[
                ShaderBody::Source(resources.single_fs_id, &[INVOCATIONS_FS_CODE]),
                ShaderBody::Source(
                    resources.single_gs_id,
                    &[
                        INVOCATIONS_GS_PREAMBLE,
                        invocations_string.as_str(),
                        INVOCATIONS_GS_LAYOUT,
                        INVOCATIONS_GS_BODY,
                    ],
                ),
                ShaderBody::Source(resources.single_vs_id, &[INVOCATIONS_VS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        gl!(gl.gen_textures(1, &mut resources.color_texture_id));
        gl!(gl.gen_framebuffers(1, &mut resources.framebuffer_id));

        let texture_width = INVOCATIONS_TRIANGLE_EDGE_LENGTH * max_geometry_shader_invocations as GLuint;
        if !TestCaseBase::setup_framebuffer_with_texture_as_attachment(
            context,
            resources.framebuffer_id,
            resources.color_texture_id,
            glw::GL_RGBA8,
            texture_width,
            INVOCATIONS_TEXTURE_HEIGHT,
        )? {
            return Err(TestError::Fail("Failed to setup framebuffer".to_string()));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));

        // iterate
        let mut result_image =
            vec![0u8; (texture_width * INVOCATIONS_TEXTURE_HEIGHT * INVOCATIONS_TEXTURE_PIXEL_SIZE) as usize];

        gl!(gl.use_program(resources.multiple_po_id));
        gl!(gl.clear_color(255.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        gl!(gl.read_pixels(
            0,
            0,
            texture_width as i32,
            INVOCATIONS_TEXTURE_HEIGHT as i32,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result_image.as_mut_ptr().cast::<c_void>()
        ));

        // verifyResultOfMultipleInvocationsPass
        let result_of_multiple_invocations_pass = (0..max_geometry_shader_invocations as GLuint).all(|i| {
            Self::verify_triangle(
                &result_image,
                texture_width,
                i,
                [0, 255, 0, 0],
                max_geometry_shader_invocations,
            )
        });

        gl!(gl.use_program(resources.single_po_id));
        gl!(gl.clear_color(255.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        gl!(gl.read_pixels(
            0,
            0,
            texture_width as i32,
            INVOCATIONS_TEXTURE_HEIGHT as i32,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result_image.as_mut_ptr().cast::<c_void>()
        ));

        // verifyResultOfSingleInvocationPass: only the first invocation draws
        let result_of_single_invocation_pass = Self::verify_triangle(
            &result_image,
            texture_width,
            0,
            [0, 255, 0, 0],
            max_geometry_shader_invocations,
        ) && (1..max_geometry_shader_invocations as GLuint).all(|i| {
            Self::verify_triangle(
                &result_image,
                texture_width,
                i,
                [255, 0, 0, 0],
                max_geometry_shader_invocations,
            )
        });

        Ok(
            if result_of_multiple_invocations_pass && result_of_single_invocation_pass {
                TestStatus::pass("Pass")
            } else {
                TestStatus::fail("Fail")
            },
        )
    }
}

impl TestCase for MaxInvocations {
    fn name(&self) -> &str {
        "max_invocations"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = InvocationsResources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        for program in [resources.multiple_po_id, resources.single_po_id] {
            if program != 0 {
                gl!(gl.delete_program(program));
            }
        }
        for shader in [
            resources.multiple_fs_id,
            resources.multiple_gs_id,
            resources.multiple_vs_id,
            resources.single_fs_id,
            resources.single_gs_id,
            resources.single_vs_id,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        if resources.color_texture_id != 0 {
            gl!(gl.delete_textures(1, &resources.color_texture_id));
        }
        if resources.framebuffer_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.framebuffer_id));
        }
        outcome
    }
}
