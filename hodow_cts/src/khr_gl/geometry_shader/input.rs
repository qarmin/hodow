// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderInput.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The four classes of the header are one `Input` with a `Kind`.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const VS_CONTENTS: &str = "${VERSION}\n\n     out  vec2 vs_gs_a;\nflat out ivec4 vs_gs_b;\n\nvoid main()\n{\n    vs_gs_a = vec2 (gl_VertexID, 0);\n    vs_gs_b = ivec4(0,           gl_VertexID, 0, 1);\n}\n";
const GS_CONTENTS_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(triangles)                      in;\nlayout(triangle_strip, max_vertices=3) out;\n\n";
const GS_CONTENTS: &str = "#ifdef USE_UNSIZED_ARRAYS\n         in  vec2 vs_gs_a[];\n    flat in ivec4 vs_gs_b[];\n#else\n         in  vec2 vs_gs_a[3];\n    flat in ivec4 vs_gs_b[3];\n#endif\n\n     out  vec2 gs_fs_a;\nflat out ivec4 gs_fs_b;\n\nvoid main()\n{\n    gl_Position = vec4(-1, -1, 0, 1);\n    gs_fs_a     = vs_gs_a[0];\n    gs_fs_b     = vs_gs_b[0];\n    EmitVertex();\n    \n    gl_Position = vec4(-1, 1, 0, 1);\n    gs_fs_a     = vs_gs_a[1];\n    gs_fs_b     = vs_gs_b[1];\n    EmitVertex();\n    \n    gl_Position = vec4(1, 1, 0, 1);\n    gs_fs_a     = vs_gs_a[2];\n    gs_fs_b     = vs_gs_b[2];\n    EmitVertex();\n    \n    EndPrimitive();\n}\n";
const FS_COLOR: &str = "${VERSION}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 fs_out_color;\n\nvoid main()\n{\n    fs_out_color = vec4(1, 1, 1, 1);\n}\n";

const VS_LENGTH: &str = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, 0, 0, 1);\n}\n";
const GS_LENGTH_PREAMBLE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\n";
const GS_LENGTH_INPUT_POINTS: &str = "layout(points)                     in;\n";
const GS_LENGTH_INPUT_LINES: &str = "layout(lines)                      in;\n";
const GS_LENGTH_INPUT_LINES_ADJACENCY: &str = "layout(lines_adjacency)            in;\n";
const GS_LENGTH_INPUT_TRIANGLES: &str = "layout(triangles)                  in;\n";
const GS_LENGTH_INPUT_TRIANGLES_ADJACENCY: &str = "layout(triangles_adjacency)        in;\n";
const GS_LENGTH_OUTPUT_POINTS: &str = "layout(points, max_vertices=1)     out;\n\n#define N_OUT_VERTICES (1)\n";
const GS_LENGTH_OUTPUT_LINE_STRIP: &str = "layout(line_strip, max_vertices=2) out;\n\n#define N_OUT_VERTICES (2)\n";
const GS_LENGTH_OUTPUT_TRIANGLE_STRIP: &str =
    "layout(triangle_strip, max_vertices=3) out;\n\n#define N_OUT_VERTICES (3)\n";
const GS_LENGTH_MAIN: &str = "\nflat out int in_array_size;\n\nvoid main()\n{\n    for (int n = 0; n < N_OUT_VERTICES; n++)\n    {\n        in_array_size = gl_in.length();\n        EmitVertex();\n    }\n\n    EndPrimitive();\n}\n";
const FS_LENGTH: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n}\n";

const VS_POINT_SIZE: &str = "${VERSION}\n\nvoid main()\n{\n    // See test description for explanation of magic numbers\n    switch (gl_VertexID)\n    {\n        case 0:\n        {\n            gl_Position = vec4(-7.0/8.0, 0, 0, 1);\n\n            break;\n        }\n\n        case 1:\n        {\n            gl_Position = vec4(6.0/8.0, 0, 0, 1);\n\n            break;\n        }\n    }\n\n    gl_PointSize = float(2 * (gl_VertexID + 1));\n}\n";
const GS_POINT_SIZE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GEOMETRY_POINT_SIZE_REQUIRE}\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\nvoid main()\n{\n    gl_Position  = gl_in[0].gl_Position;\n    gl_PointSize = gl_in[0].gl_PointSize * 2.0;\n    EmitVertex();\n    \n    EndPrimitive();\n}\n";
const VS_POSITION: &str =
    "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, gl_VertexID, 0, 1);\n\n}\n";
const GS_POSITION: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GEOMETRY_POINT_SIZE_REQUIRE}\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\nvoid main()\n{\n    // See test description for discussion on the magic numbers\n    gl_Position  = vec4(-1.0 + 4.0/32.0 + gl_in[0].gl_Position.x / 4.0, 0, 0, 1);\n    gl_PointSize = 8.0;\n    EmitVertex();\n\n    EndPrimitive();\n}\n";

const CONTENTS_N_BYTES_EMITTED_PER_VERTEX: usize = 2 * std::mem::size_of::<f32>() + 4 * std::mem::size_of::<i32>();
const CONTENTS_N_EMITTED_PRIMITIVES: usize = 1;
const CONTENTS_N_VERTICES_EMITTED_PER_PRIMITIVE: usize = 3;
const CONTENTS_BUFFER_SIZE: usize =
    CONTENTS_N_BYTES_EMITTED_PER_VERTEX * CONTENTS_N_VERTICES_EMITTED_PER_PRIMITIVE * CONTENTS_N_EMITTED_PRIMITIVES;

const LENGTH_MAX_PRIMITIVE_EMITTED: usize = 6;
const LENGTH_BUFFER_SIZE: usize = std::mem::size_of::<i32>() * LENGTH_MAX_PRIMITIVE_EMITTED;

const POINT_SIZE_TEXTURE_HEIGHT: u32 = 16;
const POINT_SIZE_TEXTURE_PIXEL_SIZE: u32 = 4;
const POINT_SIZE_TEXTURE_WIDTH: u32 = 16;

const POSITION_TEXTURE_HEIGHT: u32 = 64;
const POSITION_TEXTURE_PIXEL_SIZE: u32 = 4;
const POSITION_TEXTURE_WIDTH: u32 = 64;

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Kind {
    GlInArrayContents,
    GlInArrayLength,
    GlPointSizeValue,
    GlPositionValue,
}

/// `GeometryShader_gl_in_ArrayContentsTest`, `..._gl_in_ArrayLengthTest`, `..._gl_PointSize_ValueTest` and `..._gl_Position_ValueTest`
pub(super) struct Input {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

#[derive(Default)]
struct Resources {
    program_ids: Vec<GLuint>,
    shader_ids: Vec<GLuint>,
    buffer_id: GLuint,
    vao_id: GLuint,
    color_texture_id: GLuint,
    framebuffer_id: GLuint,
}

/// `GeometryShader_gl_in_ArrayLengthTest::Case`
struct LengthCase {
    draw_call_mode: GLenum,
    draw_call_n_vertices: i32,
    expected_array_length: i32,
    tf_mode: GLenum,
    input_body_part: &'static str,
    output_body_part: &'static str,
}

impl Input {
    fn require_geometry_shader(base: &TestCaseBase) -> Result<(), TestError> {
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }
        Ok(())
    }

    /// The part of `init` of the two point rendering cases that checks the support and the point size range.
    fn require_point_size_8(context: &Context, base: &TestCaseBase) -> Result<(), TestError> {
        let gl = context.gl();
        Self::require_geometry_shader(base)?;
        if !base.is_geometry_shader_point_size_supported {
            return Err(TestError::NotSupported(
                "Geometry shader point size functionality not supported, skipping".to_string(),
            ));
        }

        let mut point_size_range = [0.0f32; 2];
        let pname = if !context.context_type().api.desktop {
            glw::GL_ALIASED_POINT_SIZE_RANGE
        } else {
            glw::GL_POINT_SIZE_RANGE
        };
        gl!(gl.get_floatv(pname, point_size_range.as_mut_ptr()));

        if 8.0 > point_size_range[1] {
            log::info!(
                "Test requires a minimum maximum point size of 8, implementation reports a maximum of : {}",
                point_size_range[1]
            );
            return Err(TestError::NotSupported("Not supported point size".to_string()));
        }

        if context.context_type().api.desktop {
            gl!(gl.enable(glw::GL_PROGRAM_POINT_SIZE));
        }
        Ok(())
    }

    fn create_shader(gl: &glw::Functions, resources: &mut Resources, shader_type: GLenum) -> GLuint {
        let id = gl!(gl.create_shader(shader_type));
        resources.shader_ids.push(id);
        id
    }

    /// `GeometryShader_gl_in_ArrayContentsTest::initTest`
    fn init_contents(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &mut Resources,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let captured_varyings = [
            CString::new("gs_fs_a").expect("no nul byte"),
            CString::new("gs_fs_b").expect("no nul byte"),
        ];
        let captured_varying_ptrs = [captured_varyings[0].as_ptr(), captured_varyings[1].as_ptr()];

        let program_object_sized_arrays_id = gl!(gl.create_program());
        let program_object_unsized_arrays_id = gl!(gl.create_program());
        resources.program_ids.push(program_object_unsized_arrays_id);
        resources.program_ids.push(program_object_sized_arrays_id);

        let fragment_shader_id = Self::create_shader(gl, resources, glw::GL_FRAGMENT_SHADER);
        let geometry_shader_unsized_arrays_id = Self::create_shader(gl, resources, base.gl_ext_tokens.geometry_shader);
        let geometry_shader_sized_arrays_id = Self::create_shader(gl, resources, base.gl_ext_tokens.geometry_shader);
        let vertex_shader_id = Self::create_shader(gl, resources, glw::GL_VERTEX_SHADER);
        glu::expect_no_error(gl, "Failed to create program")?;

        // Set up transform feedback
        gl!(gl.transform_feedback_varyings(
            program_object_sized_arrays_id,
            2,
            captured_varying_ptrs.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        gl!(gl.transform_feedback_varyings(
            program_object_unsized_arrays_id,
            2,
            captured_varying_ptrs.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));

        // Build programs
        let geometry_shader_unsized_arrays_code = [GS_CONTENTS_PREAMBLE, "#define USE_UNSIZED_ARRAYS\n", GS_CONTENTS];
        let geometry_shader_sized_arrays_code = [GS_CONTENTS_PREAMBLE, GS_CONTENTS];

        let (built, _) = base.build_program(
            context,
            program_object_unsized_arrays_id,
            &[
                ShaderBody::Source(fragment_shader_id, &[FS_COLOR]),
                ShaderBody::Source(geometry_shader_unsized_arrays_id, &geometry_shader_unsized_arrays_code),
                ShaderBody::Source(vertex_shader_id, &[VS_CONTENTS]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create a program from valid vertex/geometry (unsized arrays version)/fragment shaders"
                    .to_string(),
            ));
        }

        let (built, _) = base.build_program(
            context,
            program_object_sized_arrays_id,
            &[
                ShaderBody::Source(fragment_shader_id, &[FS_COLOR]),
                ShaderBody::Source(geometry_shader_sized_arrays_id, &geometry_shader_sized_arrays_code),
                ShaderBody::Source(vertex_shader_id, &[VS_CONTENTS]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create a program from valid vertex/geometry (sized arrays version)/fragment shaders"
                    .to_string(),
            ));
        }

        Self::create_buffer_and_vao(gl, resources, CONTENTS_BUFFER_SIZE)
    }

    /// The buffer and vertex array object tail shared by `initTest` and `init` of the two transform feedback cases.
    fn create_buffer_and_vao(
        gl: &glw::Functions,
        resources: &mut Resources,
        buffer_size: usize,
    ) -> Result<(), TestError> {
        gl!(gl.gen_buffers(1, &mut resources.buffer_id));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.buffer_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            buffer_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Could not create buffer object")?;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Could not create vertex array object")
    }

    /// Maps the first `size` bytes of the transform feedback buffer and hands them to `check`.
    fn map_transform_feedback<T>(
        gl: &glw::Functions,
        size: usize,
        check: impl FnOnce(&[u8]) -> T,
    ) -> Result<T, TestError> {
        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            size as isize,
            glw::GL_MAP_READ_BIT
        ))
        .cast::<u8>();
        glu::expect_no_error(gl, "Could not map the buffer object into process space")?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: `size` bytes were mapped for reading and the mapping lives until the unmap below.
        let value = check(unsafe { std::slice::from_raw_parts(mapped, size) });

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "Error unmapping the buffer object")?;
        Ok(value)
    }

    /// `GeometryShader_gl_in_ArrayContentsTest::iterate`
    fn run_contents(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        Self::require_geometry_shader(base)?;
        self.init_contents(context, base, resources)?;

        let mut reference_data = [0u8; CONTENTS_BUFFER_SIZE];

        // Expected data for vertex: vec2 = {VertexID, 0.0f}, ivec4 = {0, VertexID, 0, 1}
        let ivec4_offset_from_vertex = 2 * std::mem::size_of::<f32>();
        for vertex_id in 0..CONTENTS_N_VERTICES_EMITTED_PER_PRIMITIVE * CONTENTS_N_EMITTED_PRIMITIVES {
            let vertex_offset = vertex_id * CONTENTS_N_BYTES_EMITTED_PER_VERTEX;
            let vec2 = [vertex_id as f32, 0.0f32];
            let ivec4 = [0i32, vertex_id as i32, 0, 1];
            for (i, value) in vec2.iter().enumerate() {
                reference_data[vertex_offset + i * 4..][..4].copy_from_slice(&value.to_ne_bytes());
            }
            for (i, value) in ivec4.iter().enumerate() {
                reference_data[vertex_offset + ivec4_offset_from_vertex + i * 4..][..4]
                    .copy_from_slice(&value.to_ne_bytes());
            }
        }

        // Setup transform feedback
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.buffer_id));

        // Draw the geometry; the unsized arrays program was pushed first
        for po_id in resources.program_ids.clone() {
            gl!(gl.use_program(po_id));
            gl!(gl.begin_transform_feedback(glw::GL_TRIANGLES));
            gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "Error doing a draw call")?;

            let matches = Self::map_transform_feedback(gl, CONTENTS_BUFFER_SIZE, |data| data == reference_data)?;
            if !matches {
                log::info!("Data extracted from transform feedback is invalid.");
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `GeometryShader_gl_in_ArrayLengthTest::init` + `iterate`
    fn run_length(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        Self::require_geometry_shader(base)?;

        let captured_varying = CString::new("in_array_size").expect("no nul byte");
        let captured_varyings = [captured_varying.as_ptr()];

        let tests = [
            LengthCase {
                draw_call_mode: glw::GL_LINES,
                draw_call_n_vertices: 2,
                expected_array_length: 2,
                tf_mode: glw::GL_POINTS,
                input_body_part: GS_LENGTH_INPUT_LINES,
                output_body_part: GS_LENGTH_OUTPUT_POINTS,
            },
            LengthCase {
                draw_call_mode: glw::GL_LINES_ADJACENCY,
                draw_call_n_vertices: 4,
                expected_array_length: 4,
                tf_mode: glw::GL_POINTS,
                input_body_part: GS_LENGTH_INPUT_LINES_ADJACENCY,
                output_body_part: GS_LENGTH_OUTPUT_POINTS,
            },
            LengthCase {
                draw_call_mode: glw::GL_POINTS,
                draw_call_n_vertices: 1,
                expected_array_length: 1,
                tf_mode: glw::GL_POINTS,
                input_body_part: GS_LENGTH_INPUT_POINTS,
                output_body_part: GS_LENGTH_OUTPUT_POINTS,
            },
            LengthCase {
                draw_call_mode: glw::GL_TRIANGLES,
                draw_call_n_vertices: 3,
                expected_array_length: 3,
                tf_mode: glw::GL_POINTS,
                input_body_part: GS_LENGTH_INPUT_TRIANGLES,
                output_body_part: GS_LENGTH_OUTPUT_POINTS,
            },
            LengthCase {
                draw_call_mode: glw::GL_TRIANGLE_STRIP_ADJACENCY,
                draw_call_n_vertices: 6,
                expected_array_length: 6,
                tf_mode: glw::GL_POINTS,
                input_body_part: GS_LENGTH_INPUT_TRIANGLES_ADJACENCY,
                output_body_part: GS_LENGTH_OUTPUT_POINTS,
            },
            LengthCase {
                draw_call_mode: glw::GL_LINES_ADJACENCY,
                draw_call_n_vertices: 4,
                expected_array_length: 4,
                tf_mode: glw::GL_LINES,
                input_body_part: GS_LENGTH_INPUT_LINES_ADJACENCY,
                output_body_part: GS_LENGTH_OUTPUT_LINE_STRIP,
            },
            LengthCase {
                draw_call_mode: glw::GL_TRIANGLE_STRIP_ADJACENCY,
                draw_call_n_vertices: 6,
                expected_array_length: 6,
                tf_mode: glw::GL_TRIANGLES,
                input_body_part: GS_LENGTH_INPUT_TRIANGLES_ADJACENCY,
                output_body_part: GS_LENGTH_OUTPUT_TRIANGLE_STRIP,
            },
        ];

        // Initialize program objects
        for test in &tests {
            let po_id = gl!(gl.create_program());
            resources.program_ids.push(po_id);
            let vs_id = Self::create_shader(gl, resources, glw::GL_VERTEX_SHADER);
            let gs_id = Self::create_shader(gl, resources, base.gl_ext_tokens.geometry_shader);
            let fs_id = Self::create_shader(gl, resources, glw::GL_FRAGMENT_SHADER);
            glu::expect_no_error(gl, "Could not create program object")?;

            let geometry_shader_parts = [
                GS_LENGTH_PREAMBLE,
                test.input_body_part,
                test.output_body_part,
                GS_LENGTH_MAIN,
            ];

            gl!(gl.transform_feedback_varyings(po_id, 1, captured_varyings.as_ptr(), glw::GL_SEPARATE_ATTRIBS));

            let (built, _) = base.build_program(
                context,
                po_id,
                &[
                    ShaderBody::Source(fs_id, &[FS_LENGTH]),
                    ShaderBody::Source(gs_id, &geometry_shader_parts),
                    ShaderBody::Source(vs_id, &[VS_LENGTH]),
                ],
            )?;
            if !built {
                return Err(TestError::Fail(
                    "Could not create program from valid vertex/geometry/fragment shader".to_string(),
                ));
            }
        }

        Self::create_buffer_and_vao(gl, resources, LENGTH_BUFFER_SIZE)?;

        // Setup transform feedback
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.buffer_id));

        // Execute tests
        for (test, &po_id) in tests.iter().zip(resources.program_ids.iter()) {
            gl!(gl.use_program(po_id));

            gl!(gl.begin_transform_feedback(test.tf_mode));
            gl!(gl.draw_arrays(test.draw_call_mode, 0, test.draw_call_n_vertices));
            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "Error doing a draw call")?;

            let result_value = Self::map_transform_feedback(gl, std::mem::size_of::<i32>(), |data| {
                i32::from_ne_bytes([data[0], data[1], data[2], data[3]])
            })?;

            if result_value != test.expected_array_length {
                log::info!(
                    "Expected array length: {} but found: {}",
                    test.expected_array_length,
                    result_value
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `init` of the two point rendering cases after the support checks: program, texture, FBO and VAO.
    fn init_point_rendering(
        context: &Context,
        base: &TestCaseBase,
        resources: &mut Resources,
        vs_code: &str,
        gs_code: &str,
        width: u32,
        height: u32,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        let program_object_id = gl!(gl.create_program());
        resources.program_ids.push(program_object_id);
        let fragment_shader_id = Self::create_shader(gl, resources, glw::GL_FRAGMENT_SHADER);
        let geometry_shader_id = Self::create_shader(gl, resources, base.gl_ext_tokens.geometry_shader);
        let vertex_shader_id = Self::create_shader(gl, resources, glw::GL_VERTEX_SHADER);
        glu::expect_no_error(gl, "Failed to create program")?;

        let (built, _) = base.build_program(
            context,
            program_object_id,
            &[
                ShaderBody::Source(fragment_shader_id, &[FS_COLOR]),
                ShaderBody::Source(geometry_shader_id, &[gs_code]),
                ShaderBody::Source(vertex_shader_id, &[vs_code]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        // Set up texture object and a FBO
        gl!(gl.gen_textures(1, &mut resources.color_texture_id));
        gl!(gl.gen_framebuffers(1, &mut resources.framebuffer_id));
        glu::expect_no_error(gl, "Could not create framebuffer")?;

        if !TestCaseBase::setup_framebuffer_with_texture_as_attachment(
            context,
            resources.framebuffer_id,
            resources.color_texture_id,
            glw::GL_RGBA8,
            width,
            height,
        )? {
            return Err(TestError::Fail("Failed to setup framebuffer".to_string()));
        }

        // Set up a vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Could not create vertex array object")
    }

    /// The render and read back part shared by the two point rendering cases.
    fn render_points(
        context: &Context,
        resources: &Resources,
        count: i32,
        width: u32,
        height: u32,
        pixel_size: u32,
    ) -> Result<Vec<u8>, TestError> {
        let gl = context.gl();
        let mut result_image = vec![0u8; (width * height * pixel_size) as usize];

        gl!(gl.use_program(resources.program_ids[0]));
        glu::expect_no_error(gl, "Failed to use program")?;

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        glu::expect_no_error(gl, "Could not clear the color buffer")?;

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, count));
        glu::expect_no_error(gl, "Call drawArrays() failed")?;

        // Check if the data was modified during the rendering process
        gl!(gl.read_pixels(
            0,
            0,
            width as i32,
            height as i32,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result_image.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "Could not read back pixels from color buffer")?;
        Ok(result_image)
    }

    fn texel(image: &[u8], x: u32, y: u32, width: u32, pixel_size: u32) -> [u8; 4] {
        let offset = (y * width * pixel_size + x * pixel_size) as usize;
        [image[offset], image[offset + 1], image[offset + 2], image[offset + 3]]
    }

    /// `GeometryShader_gl_PointSize_ValueTest::init` + `iterate`
    fn run_point_size(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> TestOutcome {
        let (width, height, pixel_size) = (
            POINT_SIZE_TEXTURE_WIDTH,
            POINT_SIZE_TEXTURE_HEIGHT,
            POINT_SIZE_TEXTURE_PIXEL_SIZE,
        );
        Self::require_point_size_8(context, base)?;
        Self::init_point_rendering(context, base, resources, VS_POINT_SIZE, GS_POINT_SIZE, width, height)?;

        let result_image = Self::render_points(context, resources, 2, width, height, pixel_size)?;

        // 1) pixel at (2, 8) is (255, 255, 255, 255), 2) pixel at (14, 8) is (255, 255, 255, 255), 3) pixel at (6, 8) is (0, 0, 0, 0)
        for (x, y, expected) in [(2, 8, 255u8), (14, 8, 255), (6, 8, 0)] {
            if !TestCaseBase::compare_pixel(
                &result_image,
                x,
                y,
                width,
                height,
                pixel_size,
                expected,
                expected,
                expected,
                expected,
            ) {
                let texel = Self::texel(&result_image, x, y, width, pixel_size);
                log::info!(
                    "Rendered data {:?} is different from reference data [{expected}, {expected}, {expected}, {expected}]!",
                    texel
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `GeometryShader_gl_Position_ValueTest::init` + `iterate`
    fn run_position(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> TestOutcome {
        let (width, height, pixel_size) = (
            POSITION_TEXTURE_WIDTH,
            POSITION_TEXTURE_HEIGHT,
            POSITION_TEXTURE_PIXEL_SIZE,
        );
        Self::require_point_size_8(context, base)?;
        Self::init_point_rendering(context, base, resources, VS_POSITION, GS_POSITION, width, height)?;

        let result_image = Self::render_points(context, resources, 8, width, height, pixel_size)?;

        // The test passes if centers of the rendered points are lit at expected locations.
        for x in (4..width).step_by(8) {
            if !TestCaseBase::compare_pixel(&result_image, x, 32, width, height, pixel_size, 255, 255, 255, 255) {
                let texel = Self::texel(&result_image, x, 32, width, pixel_size);
                log::info!(
                    "Rendered data {:?}is different from reference data [255, 255, 255, 255] !",
                    texel
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Input {
    fn name(&self) -> &str {
        match self.kind {
            Kind::GlInArrayContents => "gl_in_array_contents",
            Kind::GlInArrayLength => "gl_in_array_length",
            Kind::GlPointSizeValue => "gl_pointsize_value",
            Kind::GlPositionValue => "gl_position_value",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let mut resources = Resources::default();
        let outcome = match self.kind {
            Kind::GlInArrayContents => self.run_contents(context, &base, &mut resources),
            Kind::GlInArrayLength => self.run_length(context, &base, &mut resources),
            Kind::GlPointSizeValue => self.run_point_size(context, &base, &mut resources),
            Kind::GlPositionValue => self.run_position(context, &base, &mut resources),
        };

        // deinit: reset state, then delete what was created
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        match self.kind {
            Kind::GlInArrayContents | Kind::GlInArrayLength => {
                gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
                gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
            }
            Kind::GlPointSizeValue | Kind::GlPositionValue => {
                gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
                gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
                if context.context_type().api.desktop {
                    gl!(gl.disable(glw::GL_PROGRAM_POINT_SIZE));
                }
            }
        }
        for &program in &resources.program_ids {
            gl!(gl.delete_program(program));
        }
        for &shader in &resources.shader_ids {
            gl!(gl.delete_shader(shader));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        if resources.buffer_id != 0 {
            gl!(gl.delete_buffers(1, &resources.buffer_id));
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
