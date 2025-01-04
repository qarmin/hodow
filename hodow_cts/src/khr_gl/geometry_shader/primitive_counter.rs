// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderPrimitiveCounter.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `GeometryShaderPrimitiveCounter` and its `RestartingPrimitive` subclass are one `PrimitiveCounter` with a `restarting` flag; the 18 configurations are one table (the vertex emitting code is built from the list of `gl_in` indices upstream spells out).

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

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 color;\n\nflat in int test_gl_PrimitiveIDIn;\n\nvoid main()\n{\n    color = vec4(1, 1, 1, 1);\n}\n";
const VERTEX_SHADER_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nin vec4 vertex_position;\n\nvoid main()\n{\n    gl_Position = vertex_position;\n}\n";

const ID_FROM_FS_VERTEX_SHADER_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nflat out int vs_vertex_id;\n     in vec4 vertex_position;\n\nvoid main()\n{\n    vs_vertex_id = gl_VertexID;}\n";
const ID_FROM_FS_GEOMETRY_SHADER_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\nflat in int vs_vertex_id[1];\n\nvoid main()\n{\n    int column = vs_vertex_id[0] % 64;\n    int row    = vs_vertex_id[0] / 64;\n\n    gl_PrimitiveID = vs_vertex_id[0];\n    gl_Position    = vec4(-1.0 + float(column+1) / 32.0, -1.0 + float(row + 1) / 32.0, 0, 1);\n    EmitVertex();\n\n    gl_PrimitiveID = vs_vertex_id[0];\n    gl_Position    = vec4(-1.0 + float(column+1) / 32.0, -1.0 + float(row) / 32.0, 0, 1);\n    EmitVertex();\n\n    gl_PrimitiveID = vs_vertex_id[0];\n    gl_Position    = vec4(-1.0 + float(column)   / 32.0, -1.0 + float(row + 1) / 32.0, 0, 1);\n    EmitVertex();\n\n    gl_PrimitiveID = vs_vertex_id[0];\n    gl_Position    = vec4(-1.0 + float(column)/ 32.0, -1.0 + float(row)/ 32.0, 0, 1);\n    EmitVertex();\n\n    EndPrimitive();\n}\n";
const ID_FROM_FS_FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 result;\n\nvoid main()\n{\n    result.x =       float(gl_PrimitiveID % 64)          / 64.0f;\n    result.y = floor(float(gl_PrimitiveID)      / 64.0f) / 64.0f;\n    result.z =       float(gl_PrimitiveID)               / 4096.0f;\n    result.w = ((gl_PrimitiveID % 2) == 0) ? 1.0f : 0.0f;\n}\n";

const N_COMPONENTS: GLuint = 4;
const NUMBER_OF_DRAWN_PRIMITIVES: GLuint = 1024;
const NUMBER_OF_RESTARTS: GLuint = 2;
const N_VARYINGS: GLuint = 1;

struct Configuration {
    name: &'static str,
    draw_mode: GLenum,
    feedback_mode: GLenum,
    layout_in: &'static str,
    layout_out: &'static str,
    number_of_vertices_per_one_output_primitive: GLuint,
    number_of_vertices_per_one_input_primitive: GLuint,
    emitted_gl_in_indices: &'static [usize],
}

static CONFIGURATIONS: [Configuration; 9] = [
    Configuration {
        name: "points_to_points",
        draw_mode: glw::GL_POINTS,
        feedback_mode: glw::GL_POINTS,
        layout_in: "points",
        layout_out: "points",
        number_of_vertices_per_one_output_primitive: 1,
        number_of_vertices_per_one_input_primitive: 1,
        emitted_gl_in_indices: &[0],
    },
    Configuration {
        name: "points_to_line_strip",
        draw_mode: glw::GL_POINTS,
        feedback_mode: glw::GL_LINES,
        layout_in: "points",
        layout_out: "line_strip",
        number_of_vertices_per_one_output_primitive: 2,
        number_of_vertices_per_one_input_primitive: 1,
        emitted_gl_in_indices: &[0, 0],
    },
    Configuration {
        name: "points_to_triangle_strip",
        draw_mode: glw::GL_POINTS,
        feedback_mode: glw::GL_TRIANGLES,
        layout_in: "points",
        layout_out: "triangle_strip",
        number_of_vertices_per_one_output_primitive: 3,
        number_of_vertices_per_one_input_primitive: 1,
        emitted_gl_in_indices: &[0, 0, 0],
    },
    Configuration {
        name: "lines_to_points",
        draw_mode: glw::GL_LINES,
        feedback_mode: glw::GL_POINTS,
        layout_in: "lines",
        layout_out: "points",
        number_of_vertices_per_one_output_primitive: 1,
        number_of_vertices_per_one_input_primitive: 2,
        emitted_gl_in_indices: &[0],
    },
    Configuration {
        name: "lines_to_line_strip",
        draw_mode: glw::GL_LINES,
        feedback_mode: glw::GL_LINES,
        layout_in: "lines",
        layout_out: "line_strip",
        number_of_vertices_per_one_output_primitive: 2,
        number_of_vertices_per_one_input_primitive: 2,
        emitted_gl_in_indices: &[0, 1],
    },
    Configuration {
        name: "lines_to_triangle_strip",
        draw_mode: glw::GL_LINES,
        feedback_mode: glw::GL_TRIANGLES,
        layout_in: "lines",
        layout_out: "triangle_strip",
        number_of_vertices_per_one_output_primitive: 3,
        number_of_vertices_per_one_input_primitive: 2,
        emitted_gl_in_indices: &[0, 1, 0],
    },
    Configuration {
        name: "triangles_to_points",
        draw_mode: glw::GL_TRIANGLES,
        feedback_mode: glw::GL_POINTS,
        layout_in: "triangles",
        layout_out: "points",
        number_of_vertices_per_one_output_primitive: 1,
        number_of_vertices_per_one_input_primitive: 3,
        emitted_gl_in_indices: &[0],
    },
    Configuration {
        name: "triangles_to_line_strip",
        draw_mode: glw::GL_TRIANGLES,
        feedback_mode: glw::GL_LINES,
        layout_in: "triangles",
        layout_out: "line_strip",
        number_of_vertices_per_one_output_primitive: 2,
        number_of_vertices_per_one_input_primitive: 3,
        emitted_gl_in_indices: &[0, 1],
    },
    Configuration {
        name: "triangles_to_triangle_strip",
        draw_mode: glw::GL_TRIANGLES,
        feedback_mode: glw::GL_TRIANGLES,
        layout_in: "triangles",
        layout_out: "triangle_strip",
        number_of_vertices_per_one_output_primitive: 3,
        number_of_vertices_per_one_input_primitive: 3,
        emitted_gl_in_indices: &[0, 1, 2],
    },
];

/// `GeometryShaderPrimitiveCounter` and `GeometryShaderPrimitiveCounterRestartingPrimitive`
pub(super) struct PrimitiveCounter {
    pub ext_params: ExtParameters,
    configuration: &'static Configuration,
    restarting: bool,
    name: String,
}

/// `GeometryShaderPrimitiveIDFromFragmentShader`
pub(super) struct PrimitiveIdFromFragmentShader {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    fragment_shader_id: GLuint,
    geometry_shader_id: GLuint,
    vertex_shader_id: GLuint,
    program_id: GLuint,
    tbo: GLuint,
    vao: GLuint,
    vbo: GLuint,
    bo_id: GLuint,
}

/// Tests 6.1 (plain) and 6.2 (`_rp`, primitive restart) in upstream's order, then 6.3.
pub(super) fn create_tests(ext_params: ExtParameters) -> Vec<Box<dyn TestCase>> {
    let mut tests: Vec<Box<dyn TestCase>> = Vec::new();
    for restarting in [false, true] {
        for configuration in &CONFIGURATIONS {
            let name = if restarting {
                format!("{}_rp", configuration.name)
            } else {
                if configuration.name == "points_to_points" {
                    "point_to_point".to_string()
                } else {
                    configuration.name.to_string()
                }
            };
            tests.push(Box::new(PrimitiveCounter {
                ext_params,
                configuration,
                restarting,
                name,
            }));
        }
    }
    tests.push(Box::new(PrimitiveIdFromFragmentShader { ext_params }));
    tests
}

fn emit_vertex_code(indices: &[usize]) -> String {
    indices
        .iter()
        .map(|index| format!("        test_gl_PrimitiveIDIn = gl_PrimitiveIDIn;\n        gl_Position           = gl_in[{index}].gl_Position;\n        EmitVertex();\n"))
        .collect::<Vec<_>>()
        .join("\n")
}

/// `GetGeometryShaderCode`
fn geometry_shader_code(
    max_vertices: &str,
    layout_in: &str,
    layout_out: &str,
    emit_vertices: &str,
    n_iterations: &str,
) -> String {
    format!(
        "${{VERSION}}\n\n${{GEOMETRY_SHADER_REQUIRE}}\n\nprecision highp float;\n\nlayout({layout_in})                                  in;\nlayout({layout_out}, max_vertices ={max_vertices}) out;\n\nflat out int test_gl_PrimitiveIDIn;\n\nvoid main()\n{{\n    for (int i=0; i<{n_iterations}; i++)\n    {{\n        {emit_vertices}\n        EndPrimitive();\n    }}\n}}\n"
    )
}

struct Prepared {
    n_vertices_per_primitive_in: GLuint,
    max_geometry_output_vertices: GLint,
    size_of_feedback_buffer: GLuint,
}

impl PrimitiveCounter {
    /// `createAndBuildProgramWithFeedback`; returns the adjusted `m_maxGeometryOutputVertices`.
    fn create_and_build_program_with_feedback(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &mut Resources,
    ) -> Result<GLint, TestError> {
        let gl = context.gl();
        let configuration = self.configuration;

        resources.program_id = gl!(gl.create_program());

        let feedback_varyings = [c"test_gl_PrimitiveIDIn".as_ptr()];
        gl!(gl.transform_feedback_varyings(
            resources.program_id,
            N_VARYINGS as GLint,
            feedback_varyings.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "Could not set transform feedback varyings!")?;

        resources.geometry_shader_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.fragment_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.vertex_shader_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() call(s) failed")?;

        // Retrieve GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT pname value and use it as argument for max_vertices layout qualifier of the geometry shader.
        let mut max_geometry_output_vertices: GLint = 0;
        gl!(gl.get_integerv(
            base.gl_ext_tokens.max_geometry_output_vertices,
            &mut max_geometry_output_vertices
        ));
        glu::expect_no_error(gl, "Could not query GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT!")?;

        max_geometry_output_vertices /= (N_COMPONENTS + N_VARYINGS) as GLint;
        let max_vertices_string = max_geometry_output_vertices.to_string();

        // Calculate the possible for loops count in Geometry Shader
        let n_loop_iterations =
            max_geometry_output_vertices / configuration.number_of_vertices_per_one_output_primitive as GLint;

        // adjust the m_maxGeometryOutputVertices to be the number of emitted vertices
        max_geometry_output_vertices =
            n_loop_iterations * configuration.number_of_vertices_per_one_output_primitive as GLint;

        let geometry_shader_code = geometry_shader_code(
            &max_vertices_string,
            configuration.layout_in,
            configuration.layout_out,
            &emit_vertex_code(configuration.emitted_gl_in_indices),
            &n_loop_iterations.to_string(),
        );

        let (built, _) = base.build_program(
            context,
            resources.program_id,
            &[
                ShaderBody::Source(resources.fragment_shader_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(resources.geometry_shader_id, &[geometry_shader_code.as_str()]),
                ShaderBody::Source(resources.vertex_shader_id, &[VERTEX_SHADER_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Program could not have been created sucessfully".to_string(),
            ));
        }
        Ok(max_geometry_output_vertices)
    }

    /// `prepareBufferObjects`
    fn prepare_buffer_objects(
        &self,
        context: &Context,
        resources: &mut Resources,
        max_geometry_output_vertices: GLint,
    ) -> Result<Prepared, TestError> {
        let gl = context.gl();
        let configuration = self.configuration;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao));
        gl!(gl.bind_vertex_array(resources.vao));
        glu::expect_no_error(gl, "Could not create a VAO!")?;

        let size_of_data_array =
            NUMBER_OF_DRAWN_PRIMITIVES * N_COMPONENTS * configuration.number_of_vertices_per_one_input_primitive;

        gl!(gl.gen_buffers(1, &mut resources.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vbo));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (size_of_data_array as usize * std::mem::size_of::<f32>()) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(
            gl,
            "Could not initialize a buffer object to hold data for vertex_position attribute!",
        )?;

        // Set up "vertex_position" vertex attribute array
        let vertex_position_attribute_location =
            gl!(gl.get_attrib_location(resources.program_id, c"vertex_position".as_ptr()));
        glu::expect_no_error(gl, "Could not retrieve vertex_position attribute location!")?;

        gl!(gl.vertex_attrib_pointer(
            vertex_position_attribute_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null()
        ));
        glu::expect_no_error(gl, "glVertexAttribPointer() failed for vertex_position attribute!")?;

        gl!(gl.enable_vertex_attrib_array(vertex_position_attribute_location as GLuint));
        glu::expect_no_error(gl, "glEnableVertexAttribArray() failed for vertex_position attribute!")?;

        // Set up buffer object to hold result transform feedback data
        let size_of_feedback_buffer = (NUMBER_OF_DRAWN_PRIMITIVES as usize
            * max_geometry_output_vertices as usize
            * N_VARYINGS as usize
            * std::mem::size_of::<GLint>()) as GLuint;

        gl!(gl.gen_buffers(1, &mut resources.tbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.tbo));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_feedback_buffer as isize,
            std::ptr::null(),
            glw::GL_STATIC_COPY
        ));
        glu::expect_no_error(gl, "Could not set up a buffer object to hold transform feedback data!")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.tbo));
        glu::expect_no_error(
            gl,
            "Could not bind a buffer object to transform feedback binding point!",
        )?;

        Ok(Prepared {
            n_vertices_per_primitive_in: configuration.number_of_vertices_per_one_input_primitive,
            max_geometry_output_vertices,
            size_of_feedback_buffer,
        })
    }

    /// `drawFunction` of the plain and of the restarting flavour
    fn draw_function(&self, context: &Context) {
        let gl = context.gl();
        let configuration = self.configuration;
        let n_vertices = NUMBER_OF_DRAWN_PRIMITIVES * configuration.number_of_vertices_per_one_input_primitive;
        if self.restarting {
            gl!(gl.draw_elements(
                configuration.draw_mode,
                (n_vertices + NUMBER_OF_RESTARTS) as GLint,
                glw::GL_UNSIGNED_INT,
                std::ptr::null()
            ));
        } else {
            gl!(gl.draw_arrays(configuration.draw_mode, 0, n_vertices as GLint));
        }
    }

    /// `drawAndGetFeedback`
    fn draw_and_get_feedback(
        &self,
        context: &Context,
        resources: &Resources,
        size_of_feedback_buffer: GLuint,
    ) -> Result<Vec<GLint>, TestError> {
        let gl = context.gl();

        gl!(gl.use_program(resources.program_id));
        glu::expect_no_error(gl, "glUseProgram() failed!")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed!")?;

        // Perform transform feedback
        gl!(gl.begin_transform_feedback(self.configuration.feedback_mode));
        self.draw_function(context);
        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "Rendering failed")?;

        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "giDisable(GL_RASTERIZER_DISCARD) failed")?;

        // Fetch the generated data
        let feedback = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            size_of_feedback_buffer as isize,
            glw::GL_MAP_READ_BIT
        ))
        .cast::<GLint>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if feedback.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: size_of_feedback_buffer bytes were mapped for reading and the mapping lives until the unmap below.
        let result = unsafe {
            std::slice::from_raw_parts(
                feedback,
                size_of_feedback_buffer as usize / std::mem::size_of::<GLint>(),
            )
        }
        .to_vec();

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;
        Ok(result)
    }

    /// `checkResult`
    fn check_result(&self, data: &[GLint], max_geometry_output_vertices: GLint) -> bool {
        let mut test_passed = true;
        for n_drawn_primitive in 0..NUMBER_OF_DRAWN_PRIMITIVES {
            let n_emitted_values_per_primitive = max_geometry_output_vertices as u32 * N_VARYINGS;
            for n_value in (n_emitted_values_per_primitive * n_drawn_primitive)
                ..(n_emitted_values_per_primitive * (n_drawn_primitive + 1))
            {
                if data[n_value as usize] as u32 != n_drawn_primitive {
                    log::info!(
                        "Rendered value at index [{}/{}]: {} != {}",
                        n_value,
                        NUMBER_OF_DRAWN_PRIMITIVES * max_geometry_output_vertices as u32 * N_VARYINGS,
                        data[n_value as usize],
                        n_emitted_values_per_primitive
                    );
                    test_passed = false;
                }
            }
        }
        test_passed
    }

    /// `setUpVertexAttributeArrays` of the restarting flavour
    fn set_up_vertex_attribute_arrays(
        &self,
        context: &Context,
        resources: &mut Resources,
        n_vertices_per_primitive_in: GLuint,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let is_es = !context.context_type().api.desktop;

        let n_indices = NUMBER_OF_DRAWN_PRIMITIVES * n_vertices_per_primitive_in + NUMBER_OF_RESTARTS;
        let restart_index: GLuint = if is_es { 0xFFFF_FFFF } else { n_indices };

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "Could not generate a buffer object")?;

        let mut indices = vec![0 as GLuint; n_indices as usize];
        for restart_nr in 0..NUMBER_OF_RESTARTS {
            for i in (n_vertices_per_primitive_in * restart_nr + 1)..n_indices {
                let restart_position = n_vertices_per_primitive_in * (restart_nr + 1) + restart_nr;
                if i < restart_position {
                    indices[i as usize] = i - restart_nr;
                } else if i > restart_position {
                    indices[i as usize] = i - 1 - restart_nr;
                }
            }
            indices[(n_vertices_per_primitive_in * (restart_nr + 1) + restart_nr) as usize] = restart_index;
        }

        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            (std::mem::size_of::<GLuint>() * n_indices as usize) as isize,
            indices.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Could not create element array buffer object")?;

        if !is_es {
            gl!(gl.primitive_restart_index(restart_index));
            glu::expect_no_error(gl, "Could not set primitive restart index")?;
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        let is_es = !context.context_type().api.desktop;

        let max_geometry_output_vertices = self.create_and_build_program_with_feedback(context, &base, resources)?;
        let prepared = self.prepare_buffer_objects(context, resources, max_geometry_output_vertices)?;
        debug_assert_eq!(prepared.max_geometry_output_vertices, max_geometry_output_vertices);

        let restart_token = if is_es {
            glw::GL_PRIMITIVE_RESTART_FIXED_INDEX
        } else {
            glw::GL_PRIMITIVE_RESTART
        };
        if self.restarting {
            gl!(gl.enable(restart_token));
            glu::expect_no_error(gl, "Enabling primitive restart failed")?;
            self.set_up_vertex_attribute_arrays(context, resources, prepared.n_vertices_per_primitive_in)?;
        }

        let feedback_result = self.draw_and_get_feedback(context, resources, prepared.size_of_feedback_buffer)?;

        if self.restarting {
            gl!(gl.disable(restart_token));
            glu::expect_no_error(gl, "Disabling primitive restart failed")?;
        }

        if self.check_result(&feedback_result, prepared.max_geometry_output_vertices) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

impl TestCase for PrimitiveCounter {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        if self.restarting {
            gl!(gl.disable(if context.context_type().api.desktop {
                glw::GL_PRIMITIVE_RESTART
            } else {
                glw::GL_PRIMITIVE_RESTART_FIXED_INDEX
            }));
        }
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        gl!(gl.use_program(0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        if resources.program_id != 0 {
            gl!(gl.delete_program(resources.program_id));
        }
        for shader in [
            resources.vertex_shader_id,
            resources.geometry_shader_id,
            resources.fragment_shader_id,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        for buffer in [resources.vbo, resources.tbo] {
            if buffer != 0 {
                gl!(gl.delete_buffers(1, &buffer));
            }
        }
        if resources.vao != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao));
        }
        outcome
    }
}

const ID_N_DRAWN_VERTICES: GLuint = 4096;
const ID_SQUARE_EDGE_SIZE: GLuint = 16;
const ID_TEXTURE_HEIGHT: GLuint = 1024;
const ID_TEXTURE_N_COMPONENTS: GLuint = 4;
const ID_TEXTURE_N_LEVELS: GLint = 1;
const ID_TEXTURE_WIDTH: GLuint = 1024;

#[derive(Default)]
struct IdResources {
    fbo_id: GLuint,
    fragment_shader_id: GLuint,
    geometry_shader_id: GLuint,
    program_id: GLuint,
    texture_id: GLuint,
    vao_id: GLuint,
    vbo_id: GLuint,
    vertex_shader_id: GLuint,
}

impl PrimitiveIdFromFragmentShader {
    fn run(&self, context: &Context, resources: &mut IdResources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let epsilon = 1.0f32 / 256.0;

        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        resources.program_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        resources.vertex_shader_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.geometry_shader_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.fragment_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        glu::expect_no_error(gl, "glCreateShader() call(s) failed")?;

        let (built, _) = base.build_program(
            context,
            resources.program_id,
            &[
                ShaderBody::Source(resources.fragment_shader_id, &[ID_FROM_FS_FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(resources.geometry_shader_id, &[ID_FROM_FS_GEOMETRY_SHADER_CODE]),
                ShaderBody::Source(resources.vertex_shader_id, &[ID_FROM_FS_VERTEX_SHADER_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Program could not have been created sucessfully".to_string(),
            ));
        }

        // Create and configure a texture object we'll be rendering to
        gl!(gl.gen_textures(1, &mut resources.texture_id));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.texture_id));
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            ID_TEXTURE_N_LEVELS,
            glw::GL_RGBA8,
            ID_TEXTURE_WIDTH as GLint,
            ID_TEXTURE_HEIGHT as GLint
        ));
        glu::expect_no_error(gl, "Error creating a texture object!")?;

        // Create and configure the framebuffer object
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resources.fbo_id));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            resources.texture_id,
            0
        ));
        glu::expect_no_error(gl, "Error configuring framebuffer object!")?;

        // Create and bind a vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error configuring a vertex array object")?;

        // Set up a buffer object we will use to hold vertex_position attribute data
        let size_of_data_array =
            ID_N_DRAWN_VERTICES as usize * ID_TEXTURE_N_COMPONENTS as usize * std::mem::size_of::<f32>();
        gl!(gl.gen_buffers(1, &mut resources.vbo_id));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vbo_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_data_array as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(
            gl,
            "Could not set up a buffer object to hold vertex_position attribute data!",
        )?;

        gl!(gl.viewport(0, 0, ID_TEXTURE_WIDTH as GLint, ID_TEXTURE_HEIGHT as GLint));
        glu::expect_no_error(gl, "glViewport() call failed")?;

        gl!(gl.clear_color(1.0, 1.0, 1.0, 1.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        glu::expect_no_error(gl, "Could not clear the color buffer!")?;

        // Render the test geometry
        gl!(gl.use_program(resources.program_id));
        glu::expect_no_error(gl, "glUseProgram() call failed")?;

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, ID_N_DRAWN_VERTICES as GLint));
        glu::expect_no_error(gl, "Rendering failed!")?;

        // Read the rendered data
        let mut result_buffer = vec![0u8; (ID_TEXTURE_WIDTH * ID_TEXTURE_HEIGHT * ID_TEXTURE_N_COMPONENTS) as usize];

        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resources.fbo_id));
        glu::expect_no_error(gl, "glBindFramebuffer() call failed")?;

        gl!(gl.read_pixels(
            0,
            0,
            ID_TEXTURE_WIDTH as GLint,
            ID_TEXTURE_HEIGHT as GLint,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result_buffer.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "Reading pixels failed!")?;

        // Loop over all pixels and compare the rendered data with reference values
        for y in 0..ID_TEXTURE_HEIGHT {
            let data_row = (y * ID_TEXTURE_WIDTH * ID_TEXTURE_N_COMPONENTS) as usize;

            for x in 0..ID_TEXTURE_WIDTH {
                let column = x / ID_SQUARE_EDGE_SIZE;
                let data = &result_buffer[data_row + (x * ID_TEXTURE_N_COMPONENTS) as usize..];
                let row = y / ID_SQUARE_EDGE_SIZE;
                let primitive_id = column + row * (ID_TEXTURE_WIDTH / ID_SQUARE_EDGE_SIZE);

                let mut rendered_rgba = [0.0f32; 4];
                for (n_channel, rendered) in rendered_rgba.iter_mut().enumerate() {
                    *rendered = f32::from(data[n_channel]) / 255.0;
                }

                let expected_rgba = [
                    (primitive_id % 64) as f32 / 64.0,
                    (primitive_id as f32 / 64.0).floor() / 64.0,
                    primitive_id as f32 / 4096.0,
                    if primitive_id.is_multiple_of(2) { 1.0 } else { 0.0 },
                ];

                if rendered_rgba
                    .iter()
                    .zip(&expected_rgba)
                    .any(|(rendered, expected)| (rendered - expected).abs() > epsilon)
                {
                    log::info!(
                        "Primitive ID: {primitive_id}Rendered dataequal ({}, {}, {}, {}) exceeds allowed epsilon when compared to expected data equal ({}, {}, {}, {}).",
                        rendered_rgba[0],
                        rendered_rgba[1],
                        rendered_rgba[2],
                        rendered_rgba[3],
                        expected_rgba[0],
                        expected_rgba[1],
                        expected_rgba[2],
                        expected_rgba[3]
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for PrimitiveIdFromFragmentShader {
    fn name(&self) -> &str {
        "primitive_id_from_fragment"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = IdResources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        if resources.program_id != 0 {
            gl!(gl.delete_program(resources.program_id));
        }
        for shader in [
            resources.fragment_shader_id,
            resources.geometry_shader_id,
            resources.vertex_shader_id,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.texture_id != 0 {
            gl!(gl.delete_textures(1, &resources.texture_id));
        }
        if resources.fbo_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        if resources.vbo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.vbo_id));
        }
        outcome
    }
}
