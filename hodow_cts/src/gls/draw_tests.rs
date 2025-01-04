// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDrawTests.cpp
//   modules/gles3/functional/es3fDrawTests.cpp
//   modules/glshared/glsDrawTest.cpp (DrawTest::init / DrawTest::iterate driver loop)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES2.functional.draw` and `dEQP-GLES3.functional.draw` build the same kinds of groups out
// of `gls::draw_test::DrawTest`, with per-API tables (index types, `first` values, random-group
// weights, the ES 3.0 instanced attribute group and `instancing` group), so one module serves
// both and `DrawApi` picks the tables. `DrawCase` is the `tcu::TestCase` driver
// `gls::draw_test::draw_test` leaves out: it builds the real `sglr::GLContext` and a software
// `sglr::ReferenceContext`, and walks every iteration through `DrawTest::draw_iteration` and
// `DrawTest::compare_iteration`, collecting results as `tcu::ResultCollector` does (worst wins).
//
// Narrowings: no `tcu::TestLog`; the reference context is always single sample (upstream asks
// for 4 samples only when the render target is multisampled and a line case is present); the
// `GL_EXT_draw_elements_base_vertex` check is not ported because neither ES 2.0 nor ES 3.0 uses
// a base vertex method.

use crate::gls::draw_test::draw_test::DrawStepOutcome;
use crate::gls::draw_test::spec::{
    AttributeSpec, CompatibilityTestType, DrawMethod, DrawTestSpec, IndexType, InputType, OutputType, Primitive,
    Storage, Usage,
};
use crate::gls::draw_test::{AttributePack, DrawTest};
use crate::gls::reference_context_buffers::create_reference_context;
use crate::glu::{ApiType, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context as SglrContext;
use crate::sglr::gl_context::GLContext;
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::vector::Vec4;
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestResult, TestStatus};

const MAX_RENDER_TARGET_SIZE: i32 = 512;

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DrawApi {
    Es2,
    Es3,
}

impl DrawApi {
    fn api_type(self) -> ApiType {
        match self {
            Self::Es2 => ApiType::es(2, 0),
            Self::Es3 => ApiType::es(3, 0),
        }
    }
}

type Iteration = (DrawTestSpec, Option<String>);

/// `gls::DrawTest` as a registered case: its iterations, run by `iterate`.
struct DrawCase {
    name: String,
    iterations: Vec<Iteration>,
}

fn result_rank(code: TestResult) -> u8 {
    match code {
        TestResult::Pass => 0,
        TestResult::CompatibilityWarning => 1,
        _ => 2,
    }
}

struct Collector {
    worst: TestStatus,
}

impl Collector {
    fn new() -> Self {
        Self {
            worst: TestStatus::pass("Pass"),
        }
    }

    fn add(&mut self, code: TestResult, message: &str) {
        if result_rank(code) > result_rank(self.worst.code()) {
            self.worst = TestStatus::new(code, message);
        }
    }
}

fn compat_message(ctype: CompatibilityTestType) -> Option<&'static str> {
    match ctype {
        CompatibilityTestType::UnalignedOffset => Some("Failed to draw with unaligned buffers."),
        CompatibilityTestType::UnalignedStride => Some("Failed to draw with unaligned stride."),
        CompatibilityTestType::None => None,
    }
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let rt = context.render_target();
        let width = rt.width.min(MAX_RENDER_TARGET_SIZE);
        let height = rt.height.min(MAX_RENDER_TARGET_SIZE);

        let mut test = DrawTest::new(rt.pixel_format(), rt.num_samples);
        for (spec, description) in &self.iterations {
            test.add_iteration(spec.clone(), description.clone());
        }

        let mut gl_ctx = GLContext::new(&context.render_context, (0, 0, width, height));
        let mut rr_ctx = create_reference_context(context, width, height, 0)?;
        let use_vao = false;
        let mut gl_pack = AttributePack::new(&mut gl_ctx, context.context_type(), width, height, use_vao);
        let mut rr_pack = AttributePack::new(&mut rr_ctx, context.context_type(), width, height, use_vao);

        let mut result = Collector::new();
        for spec_ndx in 0..test.spec_count() {
            let spec_compat = test.spec(spec_ndx).is_compatibility_test();

            match test.draw_iteration(spec_ndx, &mut gl_ctx, &mut gl_pack, &mut rr_ctx, &mut rr_pack) {
                Ok(DrawStepOutcome::Ok) => {}
                Ok(DrawStepOutcome::CompatibilityWarning(ctype)) => {
                    if let Some(message) = compat_message(ctype) {
                        result.add(TestResult::CompatibilityWarning, message);
                    }
                }
                Err(message) => {
                    gl_pack.destroy(&mut gl_ctx);
                    rr_pack.destroy(&mut rr_ctx);
                    return Ok(TestStatus::fail(message));
                }
            }

            if !test.compare_iteration(spec_ndx, &gl_pack, &rr_pack) {
                match compat_message(spec_compat) {
                    Some(message) => result.add(TestResult::CompatibilityWarning, message),
                    None => result.add(TestResult::Fail, "Image comparison failed."),
                }
            }
        }

        gl_pack.destroy(&mut gl_ctx);
        rr_pack.destroy(&mut rr_ctx);
        Ok(result.worst)
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestIterationType {
    /// test with 1, 5, and 25 primitives
    DrawCount,
    /// test with 1, 4, and 11 instances
    InstanceCount,
    /// test with index range of [0, 23], [23, 40], and [5, 5]
    IndexRange,
}

/// `addTestIterations`
fn add_test_iterations(iterations: &mut Vec<Iteration>, base_spec: &DrawTestSpec, type_: TestIterationType) {
    let mut spec = base_spec.clone();

    match type_ {
        TestIterationType::DrawCount => {
            spec.primitive_count = 1;
            iterations.push((spec.clone(), Some("draw count = 1".to_string())));
            spec.primitive_count = 5;
            iterations.push((spec.clone(), Some("draw count = 5".to_string())));
            spec.primitive_count = 25;
            iterations.push((spec.clone(), Some("draw count = 25".to_string())));
        }
        TestIterationType::InstanceCount => {
            spec.instance_count = 1;
            iterations.push((spec.clone(), Some("instance count = 1".to_string())));
            spec.instance_count = 4;
            iterations.push((spec.clone(), Some("instance count = 4".to_string())));
            spec.instance_count = 11;
            iterations.push((spec.clone(), Some("instance count = 11".to_string())));
        }
        TestIterationType::IndexRange => {
            spec.index_min = 0;
            spec.index_max = 23;
            iterations.push((spec.clone(), Some("index range = [0, 23]".to_string())));
            spec.index_min = 23;
            spec.index_max = 40;
            iterations.push((spec.clone(), Some("index range = [23, 40]".to_string())));
            // Only makes sense with points
            if spec.primitive == Primitive::Points {
                spec.index_min = 5;
                spec.index_max = 5;
                iterations.push((spec.clone(), Some("index range = [5, 5]".to_string())));
            }
        }
    }
}

#[allow(clippy::too_many_arguments)]
fn array_attrib(
    input_type: InputType,
    output_type: OutputType,
    component_count: i32,
    instance_divisor: i32,
    use_default_attribute: bool,
    additional_position_attribute: bool,
) -> AttributeSpec {
    AttributeSpec {
        input_type,
        output_type,
        storage: Storage::Buffer,
        usage: Usage::StaticDraw,
        component_count,
        offset: 0,
        stride: 0,
        normalize: false,
        instance_divisor,
        use_default_attribute,
        additional_position_attribute,
        ..Default::default()
    }
}

/// The identical eleven-line spec preamble every group repeats.
fn base_spec(
    api: DrawApi,
    primitive: Primitive,
    primitive_count: i32,
    method: DrawMethod,
    index_type: IndexType,
    index_storage: Storage,
) -> DrawTestSpec {
    let mut spec = DrawTestSpec::new(api.api_type());
    spec.primitive = primitive;
    spec.primitive_count = primitive_count;
    spec.draw_method = method;
    spec.index_type = index_type;
    spec.index_pointer_offset = 0;
    spec.index_storage = index_storage;
    spec.first = 0;
    spec.index_min = 0;
    spec.index_max = 0;
    spec.instance_count = 1;
    spec
}

/// `genBasicSpec`
fn gen_basic_spec(api: DrawApi, method: DrawMethod) -> DrawTestSpec {
    let mut spec = base_spec(api, Primitive::Triangles, 5, method, IndexType::Last, Storage::Last);
    spec.attribs
        .push(array_attrib(InputType::Float, OutputType::Vec2, 4, 0, false, false));
    spec.attribs
        .push(array_attrib(InputType::Float, OutputType::Vec2, 2, 0, false, false));
    spec
}

fn draw_case(name: &str, iterations: Vec<Iteration>) -> Box<dyn TestCase> {
    Box::new(DrawCase {
        name: name.to_string(),
        iterations,
    })
}

/// `AttributeGroup`
fn attribute_group(
    api: DrawApi,
    name: &str,
    method: DrawMethod,
    primitive: Primitive,
    index_type: IndexType,
    index_storage: Storage,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    // select test type
    let instanced = method == DrawMethod::DrawArraysInstanced || method == DrawMethod::DrawElementsInstanced;
    let ranged = method == DrawMethod::DrawElementsRanged;
    let test_type = if instanced {
        TestIterationType::InstanceCount
    } else if ranged {
        TestIterationType::IndexRange
    } else {
        TestIterationType::DrawCount
    };
    let initial_count = if api == DrawApi::Es2 { 0 } else { 5 };

    // Single attribute
    {
        let mut spec = base_spec(api, primitive, initial_count, method, index_type, index_storage);
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 2, 0, false, false));

        let mut iterations = Vec::new();
        add_test_iterations(&mut iterations, &spec, test_type);
        group.add_child(draw_case("single_attribute", iterations));
    }

    // Multiple attribute
    {
        let mut spec = base_spec(api, primitive, initial_count, method, index_type, index_storage);
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 4, 0, false, false));
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 2, 0, false, false));

        let mut iterations = Vec::new();
        add_test_iterations(&mut iterations, &spec, test_type);
        group.add_child(draw_case("multiple_attributes", iterations));
    }

    // Multiple attribute, second one divided
    if api == DrawApi::Es3 {
        let mut spec = base_spec(api, primitive, 5, method, index_type, index_storage);
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 4, 0, false, false));
        // Add another position component so the instances wont be drawn on each other
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 2, 1, false, true));
        // Instanced color
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 3, 1, false, false));

        let mut iterations = Vec::new();
        add_test_iterations(&mut iterations, &spec, test_type);
        group.add_child(draw_case("instanced_attributes", iterations));
    }

    // Multiple attribute, second one default
    {
        let mut spec = base_spec(api, primitive, 5, method, index_type, index_storage);
        if api == DrawApi::Es3 {
            // \note addTestIterations is not called for the spec, so we must ensure [indexMin, indexMax] is a good range
            spec.index_max = 20;
        }
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 2, 0, false, false));
        spec.attribs
            .push(array_attrib(InputType::Float, OutputType::Vec2, 0, 0, true, false));

        let iopairs: &[(InputType, OutputType, i32)] = match api {
            DrawApi::Es2 => &[
                (InputType::Float, OutputType::Vec2, 4),
                (InputType::Float, OutputType::Vec4, 2),
            ],
            DrawApi::Es3 => &[
                (InputType::Float, OutputType::Vec2, 4),
                (InputType::Float, OutputType::Vec4, 2),
                (InputType::Int, OutputType::IVec3, 4),
                (InputType::UnsignedInt, OutputType::UVec2, 4),
            ],
        };

        let mut iterations = Vec::new();
        for &(input, output, component_count) in iopairs {
            let desc = format!("{}{} to {}", input.to_str(), component_count, output.to_str());
            spec.attribs[1] = array_attrib(input, output, component_count, 0, true, false);
            iterations.push((spec.clone(), Some(desc)));
        }
        group.add_child(draw_case("default_attribute", iterations));
    }

    group
}

/// `IndexGroup`
fn index_group(api: DrawApi, method: DrawMethod) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indices");

    // (storage, type, aligned, offsets)
    let tests: &[(Storage, IndexType, bool, &[i32])] = match api {
        DrawApi::Es2 => &[
            (Storage::User, IndexType::Byte, true, &[0, 1]),
            (Storage::User, IndexType::Short, true, &[0, 2]),
            (Storage::User, IndexType::Short, false, &[1, 3]),
            (Storage::Buffer, IndexType::Byte, true, &[0, 1]),
            (Storage::Buffer, IndexType::Short, true, &[0, 2]),
        ],
        DrawApi::Es3 => &[
            (Storage::User, IndexType::Byte, true, &[0, 1]),
            (Storage::User, IndexType::Short, true, &[0, 2]),
            (Storage::User, IndexType::Int, true, &[0, 4]),
            (Storage::User, IndexType::Short, false, &[1, 3]),
            (Storage::User, IndexType::Int, false, &[2, 3]),
            (Storage::Buffer, IndexType::Byte, true, &[0, 1]),
            (Storage::Buffer, IndexType::Short, true, &[0, 2]),
            (Storage::Buffer, IndexType::Int, true, &[0, 4]),
        ],
    };

    let mut user_ptr_group = TestCaseGroup::new("user_ptr");
    let mut unaligned_user_ptr_group = TestCaseGroup::new("unaligned_user_ptr");
    let mut buffer_group = TestCaseGroup::new("buffer");

    let mut spec = gen_basic_spec(api, method);

    for &(storage, index_type, aligned, offsets) in tests {
        let name = format!("index_{}", index_type.to_str());
        spec.index_type = index_type;
        spec.index_storage = storage;

        let mut iterations = Vec::new();
        for &offset in offsets {
            spec.index_pointer_offset = offset;
            iterations.push((spec.clone(), Some(format!("offset {offset}"))));
        }

        let case = draw_case(&name, iterations);
        match (storage, aligned) {
            (Storage::User, true) => user_ptr_group.add_child(case),
            (Storage::User, false) => unaligned_user_ptr_group.add_child(case),
            _ => buffer_group.add_child(case),
        };
    }

    group.add_child(user_ptr_group);
    group.add_child(unaligned_user_ptr_group);
    group.add_child(buffer_group);
    group
}

/// `FirstGroup`
fn first_group(api: DrawApi, method: DrawMethod) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("first");

    let firsts: &[i32] = match api {
        DrawApi::Es2 => &[0, 1, 17],
        DrawApi::Es3 => &[1, 3, 17],
    };

    let mut spec = gen_basic_spec(api, method);
    for &first in firsts {
        spec.first = first;
        let mut iterations = Vec::new();
        add_test_iterations(&mut iterations, &spec, TestIterationType::DrawCount);
        group.add_child(draw_case(&format!("first_{first}"), iterations));
    }
    group
}

/// `MethodGroup`
fn method_group(api: DrawApi, method: DrawMethod) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(method.to_str());

    let indexed = method == DrawMethod::DrawElements
        || method == DrawMethod::DrawElementsInstanced
        || method == DrawMethod::DrawElementsRanged;
    let has_first = method == DrawMethod::DrawArrays || method == DrawMethod::DrawArraysInstanced;
    let primitives = [
        Primitive::Points,
        Primitive::Triangles,
        Primitive::TriangleFan,
        Primitive::TriangleStrip,
        Primitive::Lines,
        Primitive::LineStrip,
        Primitive::LineLoop,
    ];

    if has_first {
        group.add_child(first_group(api, method));
    }

    if indexed && method != DrawMethod::DrawElementsRanged {
        group.add_child(index_group(api, method));
    }

    for primitive in primitives {
        group.add_child(attribute_group(
            api,
            primitive.to_str(),
            method,
            primitive,
            IndexType::Short,
            Storage::Buffer,
        ));
    }
    group
}

/// `GridProgram`
struct GridProgram {
    base: ShaderProgramBase,
}

impl GridProgram {
    fn new() -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_offset", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_color", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source(
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in highp vec4 a_offset;\n\
                 in highp vec4 a_color;\n\
                 out mediump vec4 v_color;\n\
                 void main(void)\n\
                 {\n\
                 \x20   gl_Position = a_position + a_offset;\n\
                 \x20   v_color = a_color;\n\
                 }\n"
                .to_string(),
            )
            .fragment_source(
                "#version 300 es\n\
                 layout(location = 0) out mediump vec4 dEQP_FragColor;\n\
                 in mediump vec4 v_color;\n\
                 void main(void)\n\
                 {\n\
                 \x20   dEQP_FragColor = v_color;\n\
                 }\n"
                .to_string(),
            );
        Self {
            base: ShaderProgramBase::new(&decl),
        }
    }
}

impl VertexShader for GridProgram {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut offset = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            // SAFETY: the attributes were bound by the case before the draw call.
            unsafe {
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut offset, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut color, &inputs[2], packet.instance_ndx, packet.vertex_ndx, 0);
            }
            packet.position = Vec4::new(
                position.x() + offset.x(),
                position.y() + offset.y(),
                position.z() + offset.z(),
                position.w() + offset.w(),
            );
            packet.outputs[0] = GenericVec4::from_float(color);
        }
    }
}

impl FragmentShader for GridProgram {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    let value = read_varying(&packets[packet_ndx], context, 0, frag_ndx);
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(value),
                    );
                }
            }
        }
    }
}

impl ShaderProgram for GridProgram {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}

fn vec4_bytes(values: &[[f32; 4]]) -> Vec<u8> {
    values
        .iter()
        .flat_map(|v| v.iter().flat_map(|c| c.to_ne_bytes()))
        .collect()
}

/// `InstancedGridRenderTest`
struct InstancedGridRenderTest {
    name: String,
    grid_side: i32,
    use_indices: bool,
}

impl InstancedGridRenderTest {
    /// `InstancedGridRenderTest::renderTo`
    fn render_to(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let green = [0.0f32, 1.0, 0.0, 1.0];
        let yellow = [1.0f32, 1.0, 0.0, 1.0];

        let program_id = ctx.create_program(Box::new(GridProgram::new()));
        let pos_location = ctx.get_attrib_location(program_id, "a_position") as u32;
        let offset_location = ctx.get_attrib_location(program_id, "a_offset") as u32;
        let color_location = ctx.get_attrib_location(program_id, "a_color") as u32;

        let cell_w = 2.0f32 / self.grid_side as f32;
        let cell_h = 2.0f32 / self.grid_side as f32;
        let vertex_positions: [[f32; 4]; 6] = [
            [0.0, 0.0, 0.0, 1.0],
            [cell_w, 0.0, 0.0, 1.0],
            [0.0, cell_h, 0.0, 1.0],
            [0.0, cell_h, 0.0, 1.0],
            [cell_w, 0.0, 0.0, 1.0],
            [cell_w, cell_h, 0.0, 1.0],
        ];
        let indices: [u16; 6] = [0, 4, 3, 2, 1, 5];

        let mut offsets: Vec<[f32; 4]> = Vec::new();
        for x in 0..self.grid_side {
            for y in 0..self.grid_side {
                offsets.push([x as f32 * cell_w - 1.0, y as f32 * cell_w - 1.0, 0.0, 0.0]);
            }
        }

        let mut colors: Vec<[f32; 4]> = Vec::new();
        for x in 0..self.grid_side {
            for y in 0..self.grid_side {
                colors.push(if (x + y) % 2 == 0 { green } else { yellow });
            }
        }

        let mut position_buf = [0u32; 1];
        let mut offset_buf = [0u32; 1];
        let mut color_buf = [0u32; 1];
        let mut index_buf = [0u32; 1];

        let position_bytes = vec4_bytes(&vertex_positions);
        ctx.gen_buffers(&mut position_buf);
        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, position_buf[0]);
        ctx.buffer_data(
            glw::GL_ARRAY_BUFFER,
            position_bytes.len() as isize,
            Some(&position_bytes),
        );
        ctx.vertex_attrib_pointer(pos_location, 4, glw::GL_FLOAT, false, 0, 0, false);
        ctx.vertex_attrib_divisor(pos_location, 0);
        ctx.enable_vertex_attrib_array(pos_location);

        let offset_bytes = vec4_bytes(&offsets);
        ctx.gen_buffers(&mut offset_buf);
        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, offset_buf[0]);
        ctx.buffer_data(glw::GL_ARRAY_BUFFER, offset_bytes.len() as isize, Some(&offset_bytes));
        ctx.vertex_attrib_pointer(offset_location, 4, glw::GL_FLOAT, false, 0, 0, false);
        ctx.vertex_attrib_divisor(offset_location, 1);
        ctx.enable_vertex_attrib_array(offset_location);

        let color_bytes = vec4_bytes(&colors);
        ctx.gen_buffers(&mut color_buf);
        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, color_buf[0]);
        ctx.buffer_data(glw::GL_ARRAY_BUFFER, color_bytes.len() as isize, Some(&color_bytes));
        ctx.vertex_attrib_pointer(color_location, 4, glw::GL_FLOAT, false, 0, 0, false);
        ctx.vertex_attrib_divisor(color_location, 1);
        ctx.enable_vertex_attrib_array(color_location);

        if self.use_indices {
            let index_bytes: Vec<u8> = indices.iter().flat_map(|i| i.to_ne_bytes()).collect();
            ctx.gen_buffers(&mut index_buf);
            ctx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buf[0]);
            ctx.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                index_bytes.len() as isize,
                Some(&index_bytes),
            );
        }

        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);
        ctx.viewport(0, 0, dst.get_width(), dst.get_height());
        ctx.use_program(program_id);

        if self.use_indices {
            ctx.draw_elements_instanced(
                glw::GL_TRIANGLES,
                6,
                glw::GL_UNSIGNED_SHORT,
                0,
                self.grid_side * self.grid_side,
            );
        } else {
            ctx.draw_arrays_instanced(glw::GL_TRIANGLES, 0, 6, self.grid_side * self.grid_side);
        }

        ctx.use_program(0);

        if self.use_indices {
            ctx.delete_buffers(&index_buf);
        }
        ctx.delete_buffers(&color_buf);
        ctx.delete_buffers(&offset_buf);
        ctx.delete_buffers(&position_buf);
        ctx.delete_program(program_id);
        ctx.finish();

        let (width, height) = (dst.get_width(), dst.get_height());
        ctx.read_pixels(dst, 0, 0, width, height);

        let error = ctx.get_error();
        if error != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!(
                "glGetError returned {}",
                glw::error_name(error)
            )));
        }
        Ok(())
    }

    /// `InstancedGridRenderTest::verifyImage` - the green/yellow pattern is only for clarity; this only
    /// verifies that all instances were drawn, by looking for anything non-green/yellow.
    fn verify_image(image: &Surface) -> bool {
        let color_threshold = 20;
        let mut is_ok = true;

        for y in 0..image.get_height() {
            for x in 0..image.get_width() {
                // Background color might bleed in at the borders with msaa
                if x == 0 || y == 0 || y + 1 == image.get_height() || x + 1 == image.get_width() {
                    continue;
                }

                let pixel: RGBA = image.get_pixel(x, y);
                // Any pixel with !(G ~= 255) or !(B ~= 0) is not a linear combination of green and yellow.
                if (pixel.get_green() - 255).abs() > color_threshold || pixel.get_blue().abs() > color_threshold {
                    is_ok = false;
                }
            }
        }
        is_ok
    }
}

impl TestCase for InstancedGridRenderTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let rt = context.render_target();
        let width = rt.width.min(1024);
        let height = rt.height.min(1024);
        let mut ctx = GLContext::new(&context.render_context, (0, 0, width, height));
        let mut surface = Surface::new(width, height);

        self.render_to(&mut ctx, &mut surface)?;

        if Self::verify_image(&surface) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Incorrect rendering result"))
        }
    }
}

/// `InstancingGroup`
fn instancing_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("instancing");
    let grid_widths = [2, 5, 10, 32, 100];

    // drawArrays
    for &w in &grid_widths {
        group.add_child(Box::new(InstancedGridRenderTest {
            name: format!("draw_arrays_instanced_grid_{w}x{w}"),
            grid_side: w,
            use_indices: false,
        }) as Box<dyn TestCase>);
    }

    // drawElements
    for &w in &grid_widths {
        group.add_child(Box::new(InstancedGridRenderTest {
            name: format!("draw_elements_instanced_grid_{w}x{w}"),
            grid_side: w,
            use_indices: true,
        }) as Box<dyn TestCase>);
    }

    group
}

fn uniform_weights(len: usize) -> Vec<f32> {
    vec![1.0; len]
}

/// `RandomGroup`
#[allow(clippy::field_reassign_with_default)]
fn random_group(api: DrawApi) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("random");
    let es3 = api == DrawApi::Es3;

    let num_attempts = if es3 { 300 } else { 100 };
    let attrib_counts = [1, 2, 5];
    let attrib_weights = [30.0f32, 10.0, 1.0];
    let primitive_counts = [1, 5, 64];
    let primitive_count_weights = [20.0f32, 10.0, 1.0];
    let index_offsets = [0, 7, 13];
    let index_offset_weights = [20.0f32, 20.0, 1.0];
    let firsts = [0, 7, 13];
    let first_weights = [20.0f32, 20.0, 1.0];
    let instance_counts = [1, 2, 16, 17];
    let instance_weights = [20.0f32, 10.0, 5.0, 1.0];
    let index_mins = [0, 1, 3, 8];
    let index_maxs = [4, 8, 128, 257];
    let index_weights = [50.0f32, 50.0, 50.0, 50.0];
    let offsets = [0, 1, 5, 12];
    let offset_weights = [50.0f32, 10.0, 10.0, 10.0];
    let strides = [0, 7, 16, 17];
    let stride_weights = [50.0f32, 10.0, 10.0, 10.0];
    let instance_divisors = [0, 1, 3, 129];
    let instance_divisor_weights = [70.0f32, 30.0, 10.0, 10.0];

    let primitives = [
        Primitive::Points,
        Primitive::Triangles,
        Primitive::TriangleFan,
        Primitive::TriangleStrip,
        Primitive::Lines,
        Primitive::LineStrip,
        Primitive::LineLoop,
    ];
    let primitive_weights = uniform_weights(primitives.len());

    let draw_methods: Vec<DrawMethod> = if es3 {
        vec![
            DrawMethod::DrawArrays,
            DrawMethod::DrawArraysInstanced,
            DrawMethod::DrawElements,
            DrawMethod::DrawElementsRanged,
            DrawMethod::DrawElementsInstanced,
        ]
    } else {
        vec![DrawMethod::DrawArrays, DrawMethod::DrawElements]
    };
    let draw_method_weights = uniform_weights(draw_methods.len());

    let index_types: Vec<IndexType> = if es3 {
        vec![IndexType::Byte, IndexType::Short, IndexType::Int]
    } else {
        vec![IndexType::Byte, IndexType::Short]
    };
    let index_type_weights = uniform_weights(index_types.len());

    let storages = [Storage::User, Storage::Buffer];
    let storage_weights = uniform_weights(storages.len());

    let input_types: Vec<InputType> = if es3 {
        vec![
            InputType::Float,
            InputType::Fixed,
            InputType::Byte,
            InputType::Short,
            InputType::UnsignedByte,
            InputType::UnsignedShort,
            InputType::Int,
            InputType::UnsignedInt,
            InputType::Half,
            InputType::UnsignedInt2_10_10_10,
            InputType::Int2_10_10_10,
        ]
    } else {
        vec![
            InputType::Float,
            InputType::Fixed,
            InputType::Byte,
            InputType::Short,
            InputType::UnsignedByte,
            InputType::UnsignedShort,
        ]
    };
    let input_type_weights = uniform_weights(input_types.len());

    let output_types: Vec<OutputType> = if es3 {
        vec![
            OutputType::Float,
            OutputType::Vec2,
            OutputType::Vec3,
            OutputType::Vec4,
            OutputType::Int,
            OutputType::Uint,
            OutputType::IVec2,
            OutputType::IVec3,
            OutputType::IVec4,
            OutputType::UVec2,
            OutputType::UVec3,
            OutputType::UVec4,
        ]
    } else {
        vec![OutputType::Float, OutputType::Vec2, OutputType::Vec3, OutputType::Vec4]
    };
    let output_type_weights = uniform_weights(output_types.len());

    let usages: Vec<Usage> = if es3 {
        vec![
            Usage::DynamicDraw,
            Usage::StaticDraw,
            Usage::StreamDraw,
            Usage::StreamRead,
            Usage::StreamCopy,
            Usage::StaticRead,
            Usage::StaticCopy,
            Usage::DynamicRead,
            Usage::DynamicCopy,
        ]
    } else {
        vec![Usage::StaticDraw, Usage::DynamicDraw, Usage::StreamDraw]
    };
    let usage_weights = uniform_weights(usages.len());

    let disallowed_cases: &[u32] = if es3 { &[544] } else { &[3153] }; // extremely narrow triangle

    let mut inserted_hashes: std::collections::BTreeSet<u32> = std::collections::BTreeSet::new();
    let mut inserted_count = 0usize;

    for ndx in 0..num_attempts {
        let mut random = Random::new(0xc551393u32.wrapping_add(ndx as u32)); // random does not depend on previous cases

        let attribute_count = *random.choose_weighted(&attrib_counts, &attrib_weights) as usize;

        let mut spec = DrawTestSpec::new(api.api_type());
        spec.primitive = *random.choose_weighted(&primitives, &primitive_weights);
        spec.primitive_count = *random.choose_weighted(&primitive_counts, &primitive_count_weights);
        spec.draw_method = *random.choose_weighted(&draw_methods, &draw_method_weights);
        spec.index_type = *random.choose_weighted(&index_types, &index_type_weights);
        spec.index_pointer_offset = *random.choose_weighted(&index_offsets, &index_offset_weights);
        spec.index_storage = *random.choose_weighted(&storages, &storage_weights);
        spec.first = *random.choose_weighted(&firsts, &first_weights);
        if es3 {
            spec.index_min = *random.choose_weighted(&index_mins, &index_weights);
            spec.index_max = *random.choose_weighted(&index_maxs, &index_weights);
            spec.instance_count = *random.choose_weighted(&instance_counts, &instance_weights);
        } else {
            spec.index_min = 0;
            spec.index_max = 0;
            spec.instance_count = 0;
        }

        // check spec is legal
        if !spec.valid() {
            continue;
        }

        let mut attr_ndx = 0;
        while attr_ndx < attribute_count {
            let mut attrib_spec = AttributeSpec::default();
            attrib_spec.input_type = *random.choose_weighted(&input_types, &input_type_weights);
            attrib_spec.output_type = *random.choose_weighted(&output_types, &output_type_weights);
            attrib_spec.storage = *random.choose_weighted(&storages, &storage_weights);
            attrib_spec.usage = *random.choose_weighted(&usages, &usage_weights);
            attrib_spec.component_count = random.get_int(1, 4);
            attrib_spec.offset = *random.choose_weighted(&offsets, &offset_weights);
            attrib_spec.stride = *random.choose_weighted(&strides, &stride_weights);
            attrib_spec.normalize = random.get_bool();
            if es3 {
                attrib_spec.instance_divisor = *random.choose_weighted(&instance_divisors, &instance_divisor_weights);
            } else {
                attrib_spec.instance_divisor = 0;
            }
            attrib_spec.use_default_attribute = random.get_bool();

            // check spec is legal
            let mut valid = attrib_spec.valid(spec.api_type);

            // we do not want interleaved elements. (Might result in some weird floating point values)
            if attrib_spec.stride != 0
                && attrib_spec.component_count * attrib_spec.input_type.size() > attrib_spec.stride
            {
                valid = false;
            }

            // try again if not valid
            if valid {
                spec.attribs.push(attrib_spec);
                attr_ndx += 1;
            }
        }

        // Do not collapse all vertex positions to a single positions
        if spec.primitive != Primitive::Points {
            spec.attribs[0].instance_divisor = 0;
        }

        // Is render result meaningful?
        {
            // Only one vertex
            if spec.draw_method == DrawMethod::DrawElementsRanged
                && spec.index_min == spec.index_max
                && spec.primitive != Primitive::Points
            {
                continue;
            }
            if spec.attribs[0].use_default_attribute && spec.primitive != Primitive::Points {
                continue;
            }

            // Triangle only on one axis
            if matches!(
                spec.primitive,
                Primitive::Triangles | Primitive::TriangleFan | Primitive::TriangleStrip
            ) {
                if spec.attribs[0].component_count == 1 {
                    continue;
                }
                if matches!(
                    spec.attribs[0].output_type,
                    OutputType::Float | OutputType::Int | OutputType::Uint
                ) {
                    continue;
                }
                if spec.draw_method == DrawMethod::DrawElementsRanged && (spec.index_max - spec.index_min) < 2 {
                    continue;
                }
            }
        }

        // Add case
        {
            let mut hash = spec.hash() as u32;
            for attr in spec.attribs.iter().take(attribute_count) {
                hash = (hash << 2) ^ (attr.hash() as u32);
            }

            let aligned = spec.is_compatibility_test() != CompatibilityTestType::UnalignedOffset
                && spec.is_compatibility_test() != CompatibilityTestType::UnalignedStride;

            if es3 {
                if !inserted_hashes.contains(&hash) {
                    // Only properly aligned and not disallowed cases
                    if aligned && !disallowed_cases.contains(&hash) {
                        group.add_child(draw_case(&inserted_count.to_string(), vec![(spec, None)]));
                    }
                    inserted_hashes.insert(hash);
                    inserted_count += 1;
                }
            } else if !inserted_hashes.contains(&hash) && !disallowed_cases.contains(&hash) {
                // Only aligned cases
                if aligned {
                    group.add_child(draw_case(&inserted_count.to_string(), vec![(spec, None)]));
                }
                inserted_hashes.insert(hash);
                inserted_count += 1;
            }
        }
    }

    group
}

/// `DrawTests::init`
pub fn create_tests(api: DrawApi) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw");

    // Basic
    let basic_methods: &[DrawMethod] = match api {
        DrawApi::Es2 => &[DrawMethod::DrawArrays, DrawMethod::DrawElements],
        DrawApi::Es3 => &[
            DrawMethod::DrawArrays,
            DrawMethod::DrawElements,
            DrawMethod::DrawArraysInstanced,
            DrawMethod::DrawElementsInstanced,
            DrawMethod::DrawElementsRanged,
        ],
    };
    for &method in basic_methods {
        group.add_child(method_group(api, method));
    }

    // extreme instancing
    if api == DrawApi::Es3 {
        group.add_child(instancing_group());
    }

    // Random
    group.add_child(random_group(api));

    group
}
