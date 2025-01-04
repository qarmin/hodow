// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fDrawElementsBaseVertexTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2017 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Everything except `builtin_variable` goes through `gls::DrawTest` via
// `draw_test_case::DrawTestCase`, which has the narrowings that file states.
// `VertexIDCase` runs both of its upstream iterations (client-side indices, then an
// element array buffer) in one `iterate`; upstream's `GL_CHECK` throws are `?`.
//
// `u_colors` is uploaded with a count of 8: upstream passes `DE_LENGTH_OF_ARRAY(colors)`
// (32 floats) as the number of vec4s, which GL clamps to the 8-element uniform array.

use std::mem::size_of_val;

use crate::gles31::functional::draw_test_case::DrawTestCase;
use crate::gls::draw_test::spec::{
    AttributeSpec, DrawMethod, DrawTestSpec, IndexType, InputType, OutputType, Primitive, Storage, Usage,
};
use crate::glu::{self, ApiType, Buffer, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

/// `TestIterationType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestIterationType {
    DrawCount,
    InstanceCount,
}

/// `addRangeElementsToSpec`
fn add_range_elements_to_spec(spec: &mut DrawTestSpec) {
    if spec.draw_method == DrawMethod::DrawElementsRangedBaseVertex {
        spec.index_min = 0;
        spec.index_max = spec.primitive.element_count(spec.primitive_count as usize) as i32;
    }
}

/// `addTestIterations`
fn add_test_iterations(test: &mut DrawTestCase, spec: &mut DrawTestSpec, iteration_type: TestIterationType) {
    match iteration_type {
        TestIterationType::DrawCount => {
            for count in [1, 5, 25] {
                spec.primitive_count = count;
                add_range_elements_to_spec(spec);
                test.add_iteration(spec.clone(), &format!("draw count = {count}"));
            }
        }
        TestIterationType::InstanceCount => {
            for count in [1, 4, 11] {
                spec.instance_count = count;
                add_range_elements_to_spec(spec);
                test.add_iteration(spec.clone(), &format!("instance count = {count}"));
            }
        }
    }
}

fn float_vec2_attribute(component_count: i32) -> AttributeSpec {
    AttributeSpec {
        input_type: InputType::Float,
        output_type: OutputType::Vec2,
        storage: Storage::Buffer,
        usage: Usage::StaticDraw,
        component_count,
        offset: 0,
        stride: 0,
        normalize: false,
        instance_divisor: 0,
        use_default_attribute: false,
        ..Default::default()
    }
}

/// The spec fields `AttributeGroup::init` and `genBasicSpec` both start from.
fn base_spec(method: DrawMethod, primitive: Primitive, index_type: IndexType, index_storage: Storage) -> DrawTestSpec {
    let mut spec = DrawTestSpec::new(ApiType::es(3, 1));
    spec.primitive = primitive;
    spec.primitive_count = 5;
    spec.draw_method = method;
    spec.index_type = index_type;
    spec.index_pointer_offset = 0;
    spec.index_storage = index_storage;
    spec.first = 0;
    spec.index_min = 0;
    spec.index_max = 0;
    spec.instance_count = 1;
    spec.indirect_offset = 0;
    spec
}

/// `genBasicSpec`
fn gen_basic_spec(method: DrawMethod) -> DrawTestSpec {
    let mut spec = base_spec(method, Primitive::Triangles, IndexType::Last, Storage::Last);

    spec.attribs.push(float_vec2_attribute(4));
    spec.attribs.push(float_vec2_attribute(2));

    add_range_elements_to_spec(&mut spec);
    spec
}

const VIEWPORT_WIDTH: i32 = 64;
const VIEWPORT_HEIGHT: i32 = 64;

/// `VertexIDCase`
struct VertexIdCase {
    method: DrawMethod,
}

impl VertexIdCase {
    /// `VertexIDCase::draw`
    fn draw(&self, gl: &glw::Functions, indices: *const std::ffi::c_void, base_vertex: GLint) {
        const DRAW_COUNT: i32 = 6;

        // SAFETY: `indices` is either null with an element array buffer bound, or points at
        // `DRAW_COUNT` unsigned shorts that outlive the call.
        unsafe {
            match self.method {
                DrawMethod::DrawElementsBaseVertex => {
                    gl.draw_elements_base_vertex(
                        glw::GL_TRIANGLES,
                        DRAW_COUNT,
                        glw::GL_UNSIGNED_SHORT,
                        indices,
                        base_vertex,
                    );
                }
                DrawMethod::DrawElementsRangedBaseVertex => {
                    let mut max_elements_vertices: GLint = 0;
                    gl.get_integerv(glw::GL_MAX_ELEMENTS_VERTICES, &mut max_elements_vertices);
                    gl.draw_range_elements_base_vertex(
                        glw::GL_TRIANGLES,
                        0,
                        max_elements_vertices as GLuint,
                        DRAW_COUNT,
                        glw::GL_UNSIGNED_SHORT,
                        indices,
                        base_vertex,
                    );
                }
                DrawMethod::DrawElementsInstancedBaseVertex => {
                    gl.draw_elements_instanced_base_vertex(
                        glw::GL_TRIANGLES,
                        DRAW_COUNT,
                        glw::GL_UNSIGNED_SHORT,
                        indices,
                        1,
                        base_vertex,
                    );
                }
                other => panic!("draw method {} not supported", other.to_str()),
            }
        }
    }

    /// `VertexIDCase::verifyImage`
    fn verify_image(image: &Surface) -> bool {
        let color_threshold = 0;
        let mut is_ok = true;

        for y in 0..image.get_height() {
            for x in 0..image.get_width() {
                let pixel = image.get_pixel(x, y);

                // Ignore pixels not drawn with basevertex
                if x < image.get_width() / 4
                    || x > image.get_width() * 3 / 4
                    || y < image.get_height() / 4
                    || y > image.get_height() * 3 / 4
                {
                    continue;
                }

                // Any pixel with !(B ~= 255) is faulty
                if (pixel.get_blue() - 255).abs() > color_threshold {
                    is_ok = false;
                }
            }
        }

        is_ok
    }
}

impl TestCase for VertexIdCase {
    fn name(&self) -> &str {
        "vertex_id"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports(3, 2)
            && !context
                .context_info
                .is_extension_supported("GL_EXT_draw_elements_base_vertex")
        {
            return Err(TestError::NotSupported(
                "GL_EXT_draw_elements_base_vertex is not supported.".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        self.check_support(context)?;

        let gl = context.gl();
        let sources = ProgramSources::default()
            .with(
                ShaderType::Vertex,
                "#version 310 es\n\
                 in highp vec4 a_position;\n\
                 out mediump vec4 v_color;\n\
                 uniform highp vec4 u_colors[8];\n\
                 void main (void)\n\
                 {\n\
                 \tgl_Position = a_position;\n\
                 \tv_color = u_colors[gl_VertexID];\n\
                 }\n",
            )
            .with(
                ShaderType::Fragment,
                "#version 310 es\n\
                 in mediump vec4 v_color;\n\
                 layout(location = 0) out mediump vec4 o_color;\n\
                 void main (void)\n\
                 {\n\
                 \to_color = v_color;\n\
                 }\n",
            );
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile shader program".to_string()));
        }

        // SAFETY: a linked program of this case's own.
        unsafe { gl.use_program(program.program()) };

        let coordinates_buffer = Buffer::new(gl);
        let elements_buffer = Buffer::new(gl);

        let base_vertex = 4;
        // SAFETY: NUL-terminated names against the program just linked.
        let (coord_location, color_location) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as GLuint,
                gl.get_uniform_location(program.program(), c"u_colors[0]".as_ptr()),
            )
        };

        #[rustfmt::skip]
        let coords: [f32; 16] = [
            // full viewport quad
            -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
            // half viewport quad centred
            -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5,
        ];

        let indices: [u16; 6] = [0, 1, 2, 2, 3, 0];

        #[rustfmt::skip]
        let colors: [f32; 32] = [
            0.0, 0.0, 0.0, 1.0,
            0.5, 1.0, 0.5, 1.0,
            0.0, 0.5, 1.0, 1.0,
            0.0, 1.0, 0.0, 1.0,

            0.0, 0.0, 1.0, 1.0, // blue
            0.0, 0.0, 1.0, 1.0, // blue
            0.0, 0.0, 1.0, 1.0, // blue
            0.0, 0.0, 1.0, 1.0, // blue
        ];

        let mut results = Vec::new();

        for iteration in 0..2 {
            let mut surface = Surface::new(VIEWPORT_WIDTH, VIEWPORT_HEIGHT);

            // SAFETY: plain state setting, uploads of arrays that outlive each call, and
            // buffer names this case generated.
            unsafe {
                gl.viewport(0, 0, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
                gl.clear_color(1.0, 1.0, 1.0, 1.0); // white
                gl.clear(glw::GL_COLOR_BUFFER_BIT);

                gl.uniform_4fv(color_location, 8, colors.as_ptr());

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, coordinates_buffer.get());
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    size_of_val(&coords) as GLsizeiptr,
                    coords.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );

                gl.enable_vertex_attrib_array(coord_location);
                gl.vertex_attrib_pointer(coord_location, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            }
            glu::expect_no_error(gl, "vertex setup")?;

            if iteration == 0 {
                // Indices in client-side array
                self.draw(gl, indices.as_ptr().cast(), base_vertex);
            } else {
                // Indices in element array buffer
                // SAFETY: as above.
                unsafe {
                    gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, elements_buffer.get());
                    gl.buffer_data(
                        glw::GL_ELEMENT_ARRAY_BUFFER,
                        size_of_val(&indices) as GLsizeiptr,
                        indices.as_ptr().cast(),
                        glw::GL_STATIC_DRAW,
                    );
                }
                self.draw(gl, std::ptr::null(), base_vertex);
            }
            glu::expect_no_error(gl, "draw")?;

            glu::read_pixels(&context.render_context, 0, 0, &mut surface.get_access())?;
            results.push(Self::verify_image(&surface));

            // SAFETY: unbinding the buffers bound above.
            unsafe {
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            }
        }

        if results.iter().all(|ok| *ok) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Result image invalid"))
        }
    }
}

/// `BuiltInVariableGroup`
fn built_in_variable_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    group.add_child(Box::new(VertexIdCase { method }) as Box<dyn TestCase>);
    group
}

/// `IndexGroup`
fn index_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    struct IndexTest {
        index_type: IndexType,
        offsets: &'static [i32],
    }

    let tests = [
        IndexTest {
            index_type: IndexType::Byte,
            offsets: &[0, 1],
        },
        IndexTest {
            index_type: IndexType::Short,
            offsets: &[0, 2],
        },
        IndexTest {
            index_type: IndexType::Int,
            offsets: &[0, 4],
        },
    ];

    let mut group = TestCaseGroup::new(name);
    let mut spec = gen_basic_spec(method);

    spec.index_storage = Storage::Buffer;

    for index_test in &tests {
        let test_name = format!("index_{}", index_test.index_type.to_str());
        let mut test = DrawTestCase::new(test_name);

        spec.index_type = index_test.index_type;

        for &offset in index_test.offsets {
            let iteration_desc = format!("first vertex {}", offset / index_test.index_type.size());
            spec.index_pointer_offset = offset;
            test.add_iteration(spec.clone(), &iteration_desc);
        }

        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    group
}

/// `BaseVertexGroup`
fn base_vertex_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    struct IndexTest {
        positive_base: bool,
        index_type: IndexType,
        base_vertex: [i32; 2],
    }

    let tests = [
        IndexTest {
            positive_base: true,
            index_type: IndexType::Byte,
            base_vertex: [1, 2],
        },
        IndexTest {
            positive_base: true,
            index_type: IndexType::Short,
            base_vertex: [1, 2],
        },
        IndexTest {
            positive_base: true,
            index_type: IndexType::Int,
            base_vertex: [1, 2],
        },
        IndexTest {
            positive_base: false,
            index_type: IndexType::Byte,
            base_vertex: [-1, -2],
        },
        IndexTest {
            positive_base: false,
            index_type: IndexType::Short,
            base_vertex: [-1, -2],
        },
        IndexTest {
            positive_base: false,
            index_type: IndexType::Int,
            base_vertex: [-1, -2],
        },
    ];

    let mut group = TestCaseGroup::new(name);
    let mut spec = gen_basic_spec(method);

    spec.index_storage = Storage::Buffer;

    for index_test in &tests {
        let test_name = format!(
            "index_{}{}",
            if index_test.positive_base { "" } else { "neg_" },
            index_test.index_type.to_str()
        );
        let mut test = DrawTestCase::new(test_name);

        spec.index_type = index_test.index_type;

        for base_vertex in index_test.base_vertex {
            let iteration_desc = format!("base vertex {base_vertex}");
            spec.base_vertex = base_vertex;
            // spec.indexMin + spec.baseVertex can not be a negative value
            if spec.index_min + spec.base_vertex < 0 {
                spec.index_max -= spec.index_min + spec.base_vertex;
                spec.index_min -= spec.index_min + spec.base_vertex;
            }
            test.add_iteration(spec.clone(), &iteration_desc);
        }

        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    group
}

/// `AttributeGroup`
fn attribute_group(
    name: &str,
    method: DrawMethod,
    primitive: Primitive,
    index_type: IndexType,
    index_storage: Storage,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    // Single attribute
    {
        let mut test = DrawTestCase::new("single_attribute");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(2));

        add_test_iterations(&mut test, &mut spec, TestIterationType::DrawCount);
        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    // Multiple attribute
    {
        let mut test = DrawTestCase::new("multiple_attributes");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(4));
        spec.attribs.push(float_vec2_attribute(2));

        add_test_iterations(&mut test, &mut spec, TestIterationType::DrawCount);
        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    // Multiple attribute, second one divided
    {
        let mut test = DrawTestCase::new("instanced_attributes");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(4));

        // Add another position component so the instances wont be drawn on each other
        spec.attribs.push(AttributeSpec {
            instance_divisor: 1,
            additional_position_attribute: true,
            ..float_vec2_attribute(2)
        });

        // Instanced color
        spec.attribs.push(AttributeSpec {
            instance_divisor: 1,
            ..float_vec2_attribute(3)
        });

        add_test_iterations(&mut test, &mut spec, TestIterationType::InstanceCount);
        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    // Multiple attribute, second one default
    {
        let mut test = DrawTestCase::new("default_attribute");
        let mut spec = base_spec(method, primitive, index_type, index_storage);

        spec.attribs.push(float_vec2_attribute(2));
        spec.attribs.push(float_vec2_attribute(2));

        struct IoPair {
            input: InputType,
            output: OutputType,
            component_count: i32,
        }

        let io_pairs = [
            IoPair {
                input: InputType::Float,
                output: OutputType::Vec2,
                component_count: 4,
            },
            IoPair {
                input: InputType::Float,
                output: OutputType::Vec4,
                component_count: 2,
            },
            IoPair {
                input: InputType::Int,
                output: OutputType::IVec3,
                component_count: 4,
            },
            IoPair {
                input: InputType::UnsignedInt,
                output: OutputType::UVec2,
                component_count: 4,
            },
        ];

        for io_pair in &io_pairs {
            let desc = format!(
                "{}{} to {}",
                io_pair.input.to_str(),
                io_pair.component_count,
                io_pair.output.to_str()
            );

            spec.attribs[1] = AttributeSpec {
                input_type: io_pair.input,
                output_type: io_pair.output,
                storage: Storage::Buffer,
                usage: Usage::StaticDraw,
                component_count: io_pair.component_count,
                offset: 0,
                stride: 0,
                normalize: false,
                instance_divisor: 0,
                use_default_attribute: true,
                ..Default::default()
            };

            test.add_iteration(spec.clone(), &desc);
        }

        group.add_child(Box::new(test) as Box<dyn TestCase>);
    }

    group
}

/// `MethodGroup`
fn method_group(name: &str, method: DrawMethod) -> TestCaseGroup {
    let indexed = matches!(
        method,
        DrawMethod::DrawElementsBaseVertex
            | DrawMethod::DrawElementsRangedBaseVertex
            | DrawMethod::DrawElementsInstancedBaseVertex
    );

    const PRIMITIVES: [Primitive; 7] = [
        Primitive::Points,
        Primitive::Triangles,
        Primitive::TriangleFan,
        Primitive::TriangleStrip,
        Primitive::Lines,
        Primitive::LineStrip,
        Primitive::LineLoop,
    ];

    let mut group = TestCaseGroup::new(name);

    if indexed {
        // Index-tests
        group.add_child(index_group("indices", method));
        group.add_child(base_vertex_group("base_vertex", method));
        group.add_child(built_in_variable_group("builtin_variable", method));
    }

    for primitive in PRIMITIVES {
        group.add_child(attribute_group(
            primitive.to_str(),
            method,
            primitive,
            IndexType::Short,
            Storage::Buffer,
        ));
    }

    group
}

/// `DrawElementsBaseVertexTests::init`
pub fn create_tests() -> TestCaseGroup {
    const BASIC_METHODS: [DrawMethod; 3] = [
        DrawMethod::DrawElementsBaseVertex,
        DrawMethod::DrawElementsRangedBaseVertex,
        DrawMethod::DrawElementsInstancedBaseVertex,
    ];

    let mut group = TestCaseGroup::new("draw_base_vertex");

    for method in BASIC_METHODS {
        group.add_child(method_group(method.to_str(), method));
    }

    group
}
