// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fGeometryShaderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Ported here: `input` (basic_primitive 10 + triangle_strip_adjacency 13), `conversion` (6),
// `emit` (23) and `varying` (5) - the groups driven through `GeometryShaderRenderTest`.
//
// Narrowing: upstream's reference is `rr`'s geometry stage running the test's own
// `shadePrimitives`; `rr` here has no geometry stage and `sglr::pdec` no geometry declaration.
// The geometry shader's work is emulated on the host instead: the input primitives are assembled
// with `rr::primitive_assembler` (the same vertex order the GL geometry input uses), the
// emulated `shadePrimitives` produces the emitted strips, and the strips are drawn into an
// `sglr::ReferenceContext` as plain points/lines/triangles through a passthrough colour
// shader. The GL side is a real vertex+geometry+fragment program through `glu` and raw GL
// rather than `sglr::GLContext`. Comparison (3x3 neighbourhood at 20 per channel, or fuzzy
// 0.02 on a multisampled target) is the upstream one. Upstream's three iterations (data, render,
// compare) are one body. The whole non-layered part of `basic` and `instanced` is ported.

use super::geometry_shading_tests::{
    COMMON_FRAGMENT_SOURCE, COMMON_VERTEX_SOURCE, EXPAND_GEOMETRY_BODY, check_support, expander_output_vertices,
    input_type_to_glsl_string, specialize_shader,
};
use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::glu::{
    self, ApiCase, Buffer, ProgramSources, ShaderProgram, ShaderType, TestCaseGroup, Texture, VertexArray, add_api_case,
};
use crate::glw::{self, GLenum};
use crate::rr::defs::ProvokingVertex;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_assembler::{
    assemble_line_loop, assemble_line_strip, assemble_line_strip_adjacency, assemble_lines, assemble_lines_adjacency,
    assemble_points, assemble_triangle_fan, assemble_triangle_strip, assemble_triangle_strip_adjacency,
    assemble_triangles, assemble_triangles_adjacency,
};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::shader_program::{ShaderProgram as SglrShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::Surface;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::vector::Vec4;

const TEST_CANVAS_SIZE: i32 = 256;

type V4 = [f32; 4];

fn add(a: V4, b: V4) -> V4 {
    std::array::from_fn(|i| a[i] + b[i])
}

fn scale(a: V4, s: f32) -> V4 {
    std::array::from_fn(|i| a[i] * s)
}

fn swizzle(a: V4, ndx: [usize; 4]) -> V4 {
    std::array::from_fn(|i| a[ndx[i]])
}

// ---------------------------------------------------------------------------------------
// Reference passthrough shader
// ---------------------------------------------------------------------------------------

/// The reference's vertex+fragment stage: position and colour in, the colour out unchanged.
struct PassthroughShader {
    base: ShaderProgramBase,
    use_point_size: bool,
}

impl PassthroughShader {
    /// `use_point_size` adds a third attribute, `a_pointSize`, whose x is the point size.
    fn new(use_point_size: bool) -> Self {
        let mut decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_color", GenericVecType::Float));
        if use_point_size {
            decl = decl.vertex_attribute(pdec::VertexAttribute::new("a_pointSize", GenericVecType::Float));
        }
        let decl = decl
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source("#version 310 es\nin highp vec4 a_position;\nin highp vec4 a_color;\nout highp vec4 v_color;\nvoid main (void)\n{\n\tgl_Position = a_position;\n\tv_color = a_color;\n}\n".to_string())
            .fragment_source("#version 310 es\nlayout(location = 0) out mediump vec4 o_color;\nin mediump vec4 v_color;\nvoid main (void)\n{\n\to_color = v_color;\n}\n".to_string());
        Self {
            base: ShaderProgramBase::new(&decl),
            use_point_size,
        }
    }
}

impl VertexShader for PassthroughShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            // SAFETY: the attributes were bound by the case before the draw call.
            unsafe {
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut color, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
            }
            packet.position = position;
            packet.point_size = 1.0;
            if self.use_point_size {
                let mut point_size = Vec4::splat(0.0);
                // SAFETY: as above.
                unsafe {
                    read_vertex_attrib_float(&mut point_size, &inputs[2], packet.instance_ndx, packet.vertex_ndx, 0)
                };
                packet.point_size = point_size.x();
            }
            packet.outputs[0] = GenericVec4::from_float(color);
        }
    }
}

impl FragmentShader for PassthroughShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4 {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    let color = read_varying(&packets[packet_ndx], context, 0, frag_ndx);
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(color),
                    );
                }
            }
        }
    }
}

impl SglrShaderProgram for PassthroughShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}

// ---------------------------------------------------------------------------------------
// Host-side geometry stage
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct Vertex {
    position: V4,
    color: V4,
    point_size: f32,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum OutputType {
    Points,
    LineStrip,
    TriangleStrip,
}

impl OutputType {
    fn from_gl(output: GLenum) -> Self {
        match output {
            glw::GL_POINTS => OutputType::Points,
            glw::GL_LINE_STRIP => OutputType::LineStrip,
            glw::GL_TRIANGLE_STRIP => OutputType::TriangleStrip,
            other => panic!("unexpected geometry shader output type {other:#x}"),
        }
    }

    fn glsl(self) -> &'static str {
        match self {
            OutputType::Points => "points",
            OutputType::LineStrip => "line_strip",
            OutputType::TriangleStrip => "triangle_strip",
        }
    }
}

/// `sglr::rr_util::mapGLGeometryShaderInputType`, as the GL enum of the shader's input type.
fn map_geometry_input_type(primitive: GLenum) -> GLenum {
    match primitive {
        glw::GL_POINTS => glw::GL_POINTS,
        glw::GL_LINES | glw::GL_LINE_LOOP | glw::GL_LINE_STRIP => glw::GL_LINES,
        glw::GL_LINES_ADJACENCY | glw::GL_LINE_STRIP_ADJACENCY => glw::GL_LINES_ADJACENCY,
        glw::GL_TRIANGLES | glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_FAN => glw::GL_TRIANGLES,
        glw::GL_TRIANGLES_ADJACENCY | glw::GL_TRIANGLE_STRIP_ADJACENCY => glw::GL_TRIANGLES_ADJACENCY,
        other => panic!("unexpected primitive type {other:#x}"),
    }
}

/// The vertex indices of every input primitive of a `glDrawArrays(primitive, 0, count)`, in
/// the order the geometry shader's `gl_in[]` sees them.
fn assemble_input_primitives(primitive: GLenum, count: usize) -> Vec<Vec<usize>> {
    let vertices: Vec<usize> = (0..count).collect();
    let provoking = ProvokingVertex::First;

    match primitive {
        glw::GL_POINTS => {
            let mut out = Vec::new();
            assemble_points(&mut out, &vertices, provoking);
            out.iter().map(|p| vec![p.v0]).collect()
        }
        glw::GL_LINES | glw::GL_LINE_LOOP | glw::GL_LINE_STRIP => {
            let mut out = Vec::new();
            match primitive {
                glw::GL_LINES => assemble_lines(&mut out, &vertices, provoking),
                glw::GL_LINE_LOOP => assemble_line_loop(&mut out, &vertices, provoking),
                _ => assemble_line_strip(&mut out, &vertices, provoking),
            }
            out.iter().map(|l| vec![l.v0, l.v1]).collect()
        }
        glw::GL_TRIANGLES | glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_FAN => {
            let mut out = Vec::new();
            match primitive {
                glw::GL_TRIANGLES => assemble_triangles(&mut out, &vertices, provoking),
                glw::GL_TRIANGLE_STRIP => assemble_triangle_strip(&mut out, &vertices, provoking),
                _ => assemble_triangle_fan(&mut out, &vertices, provoking),
            }
            out.iter().map(|t| vec![t.v0, t.v1, t.v2]).collect()
        }
        glw::GL_LINES_ADJACENCY | glw::GL_LINE_STRIP_ADJACENCY => {
            let mut out = Vec::new();
            if primitive == glw::GL_LINES_ADJACENCY {
                assemble_lines_adjacency(&mut out, &vertices, provoking);
            } else {
                assemble_line_strip_adjacency(&mut out, &vertices, provoking);
            }
            out.iter().map(|l| vec![l.v0, l.v1, l.v2, l.v3]).collect()
        }
        glw::GL_TRIANGLES_ADJACENCY | glw::GL_TRIANGLE_STRIP_ADJACENCY => {
            let mut out = Vec::new();
            if primitive == glw::GL_TRIANGLES_ADJACENCY {
                assemble_triangles_adjacency(&mut out, &vertices, provoking);
            } else {
                assemble_triangle_strip_adjacency(&mut out, &vertices, provoking);
            }
            out.iter().map(|t| vec![t.v0, t.v1, t.v2, t.v3, t.v4, t.v5]).collect()
        }
        other => panic!("unexpected primitive type {other:#x}"),
    }
}

/// `rr::GeometryEmitter`'s `EmitVertex`/`EndPrimitive`.
#[derive(Default)]
struct Emitter {
    strips: Vec<Vec<Vertex>>,
    current: Vec<Vertex>,
}

impl Emitter {
    fn emit_vertex(&mut self, position: V4, color: V4) {
        self.emit_vertex_sized(position, 1.0, color);
    }

    fn emit_vertex_sized(&mut self, position: V4, point_size: f32, color: V4) {
        self.current.push(Vertex {
            position,
            color,
            point_size,
        });
    }

    fn end_primitive(&mut self) {
        if !self.current.is_empty() {
            self.strips.push(std::mem::take(&mut self.current));
        }
    }

    /// The end of the shader invocation closes the open primitive.
    fn finish(mut self) -> Vec<Vec<Vertex>> {
        self.end_primitive();
        self.strips
    }
}

/// `VertexExpanderShader::shadePrimitives`
fn emulate_expander(input_primitives: GLenum, positions: &[V4], colors: &[V4]) -> Vec<Vec<Vertex>> {
    let offsets: [V4; 3] = [
        [-0.07, -0.01, 0.0, 0.0],
        [0.03, -0.03, 0.0, 0.0],
        [-0.01, 0.08, 0.0, 0.0],
    ];
    let mut emitter = Emitter::default();

    for (primitive_id, vertices) in assemble_input_primitives(input_primitives, positions.len())
        .iter()
        .enumerate()
    {
        let yoffset = scale([0.02, 0.1, 0.0, 0.0], primitive_id as f32);

        for &v in vertices {
            for offset in offsets {
                emitter.emit_vertex(add(add(positions[v], offset), yoffset), colors[v]);
            }
            emitter.end_primitive();
        }
    }
    emitter.finish()
}

/// `VertexEmitterShader::shadePrimitives`
fn emulate_emitter(
    emit_a: i32,
    end_a: i32,
    emit_b: i32,
    end_b: i32,
    positions: &[V4],
    colors: &[V4],
) -> Vec<Vec<Vertex>> {
    let offsets: [V4; 6] = [
        [-0.5, 0.5, 0.0, 0.0],
        [0.0, 0.1, 0.0, 0.0],
        [0.5, 0.5, 0.0, 0.0],
        [0.7, -0.2, 0.0, 0.0],
        [0.2, 0.2, 0.0, 0.0],
        [0.4, -0.3, 0.0, 0.0],
    ];
    let mut emitter = Emitter::default();

    for ndx in 0..positions.len() {
        for i in 0..emit_a {
            emitter.emit_vertex(add(positions[ndx], offsets[i as usize]), colors[ndx]);
        }
        for _ in 0..end_a {
            emitter.end_primitive();
        }
        for i in 0..emit_b {
            emitter.emit_vertex(add(positions[ndx], offsets[(emit_a + i) as usize]), colors[ndx]);
        }
        for _ in 0..end_b {
            emitter.end_primitive();
        }
    }
    emitter.finish()
}

/// `VertexVaryingShader::shadePrimitives`, with the vertex and fragment varying maths folded in.
fn emulate_varying(vertex_out: i32, geometry_out: i32, positions: &[V4], colors: &[V4]) -> Vec<Vec<Vertex>> {
    let vertex_offset: V4 = [-0.2, -0.2, 0.0, 0.0];
    let red: V4 = [1.0, 0.0, 0.0, 1.0];

    // The fragment colour for a given geometry-stage input colour.
    let fragment_color = |input_color: V4| -> V4 {
        match geometry_out {
            0 => red,
            1 => input_color,
            _ => add(
                scale(input_color, 0.5),
                swizzle(scale(swizzle(input_color, [1, 0, 2, 3]), 0.5), [1, 0, 2, 3]),
            ),
        }
    };

    let mut emitter = Emitter::default();

    if vertex_out == -1 {
        let corners: [V4; 3] = [[0.0, 0.0, 0.0, 1.0], [1.0, 0.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0]];
        for _ in 0..assemble_input_primitives(glw::GL_TRIANGLES, positions.len()).len() {
            for corner in corners {
                emitter.emit_vertex(add(corner, vertex_offset), fragment_color(red));
            }
            emitter.end_primitive();
        }
    } else {
        for vertices in assemble_input_primitives(glw::GL_TRIANGLES, positions.len()) {
            for v in vertices {
                let color = colors[v];
                let input_color = match vertex_out {
                    0 => red,
                    1 => color,
                    _ => {
                        let v_geom_0 = scale(color, 0.5);
                        let v_geom_1 = scale(swizzle(color, [2, 1, 0, 3]), 0.5);
                        add(scale(v_geom_0, 0.5), scale(swizzle(v_geom_1, [2, 1, 0, 3]), 0.5))
                    }
                };
                emitter.emit_vertex(add(positions[v], vertex_offset), fragment_color(input_color));
            }
            emitter.end_primitive();
        }
    }
    emitter.finish()
}

// ---------------------------------------------------------------------------------------
// The case
// ---------------------------------------------------------------------------------------

/// `GeometryShaderRenderTest::preRender`
#[derive(Clone, Copy)]
enum PreRender {
    None,
    /// `glUniform4iv(u_emitCount)`
    EmitCountUniform([i32; 4]),
    /// A 4x1 RGBA8 texture on unit 0 behind `u_sampler`: one channel set per texel.
    Texture,
}

struct RenderSpec {
    input_primitives: GLenum,
    output_type: OutputType,
    vertex_source: String,
    geometry_source: String,
    fragment_source: String,
    positions: Vec<V4>,
    colors: Vec<V4>,
    strips: Vec<Vec<Vertex>>,
    /// `m_dataAttributeName` - the attribute the colour/data array is bound to.
    data_attribute: String,
    /// `FLAG_USE_INDICES | FLAG_USE_RESTART_INDEX`: draw these 16-bit indices with fixed-index restart.
    restart_indices: Option<Vec<u16>>,
    /// The reference reads each emitted vertex's point size from an extra attribute.
    use_point_size: bool,
    /// `FLAG_DRAW_INSTANCED`: draw this many instances, the data attribute advancing per instance.
    instances: Option<i32>,
    pre_render: PreRender,
}

/// The emitted strips as separate points, lines or triangles, in emission order.
fn flatten_strips(output_type: OutputType, strips: &[Vec<Vertex>]) -> (GLenum, Vec<V4>, Vec<V4>, Vec<V4>) {
    let mut positions = Vec::new();
    let mut colors = Vec::new();
    let mut point_sizes = Vec::new();
    let mut push = |v: &Vertex| {
        positions.push(v.position);
        colors.push(v.color);
        point_sizes.push([v.point_size, 0.0, 0.0, 1.0]);
    };

    let mode = match output_type {
        OutputType::Points => {
            strips.iter().flatten().for_each(&mut push);
            glw::GL_POINTS
        }
        OutputType::LineStrip => {
            for strip in strips {
                for pair in strip.windows(2) {
                    push(&pair[0]);
                    push(&pair[1]);
                }
            }
            glw::GL_LINES
        }
        OutputType::TriangleStrip => {
            for strip in strips {
                for (k, tri) in strip.windows(3).enumerate() {
                    if k % 2 == 0 {
                        push(&tri[0]);
                        push(&tri[1]);
                    } else {
                        push(&tri[1]);
                        push(&tri[0]);
                    }
                    push(&tri[2]);
                }
            }
            glw::GL_TRIANGLES
        }
    };
    (mode, positions, colors, point_sizes)
}

/// `GeometryShaderRenderTest::compare`. `Some(reason)` is a failure.
fn compare_results(reference: &Surface, result: &Surface, num_samples: i32) -> Option<String> {
    if num_samples > 1 {
        let ok = fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), 0.02).unwrap_or(false);
        return (!ok).then(|| "Image comparison failed (fuzzy)".to_string());
    }

    let threshold = 20;
    let mut failed = 0;
    for x in 1..TEST_CANVAS_SIZE - 1 {
        for y in 1..TEST_CANVAS_SIZE - 1 {
            let ref_color = reference.get_pixel(x, y);
            let mut found = false;

            for dx in -1..=1 {
                for dy in -1..=1 {
                    let test_color = result.get_pixel(x + dx, y + dy);
                    let max_diff = (test_color.get_red() - ref_color.get_red())
                        .abs()
                        .max((test_color.get_green() - ref_color.get_green()).abs())
                        .max((test_color.get_blue() - ref_color.get_blue()).abs());
                    if max_diff <= threshold {
                        found = true;
                    }
                }
            }
            if !found {
                failed += 1;
            }
        }
    }
    (failed > 0).then(|| format!("Image comparison failed: {failed} pixels have no similar neighbour"))
}

/// `GeometryShaderRenderTest::init` + `iterate` + `renderWithContext`.
fn render_case(case: &mut ApiCase<'_>, spec: &RenderSpec) {
    let context = case.context();
    let gl = case.gl();

    if !check_support(context) {
        case.not_supported("Tests require GL_EXT_geometry_shader extension or higher context version.");
        return;
    }

    let render_target = context.render_target();
    if render_target.width < TEST_CANVAS_SIZE || render_target.height < TEST_CANVAS_SIZE {
        case.not_supported(format!(
            "Render target size must be at least {TEST_CANVAS_SIZE}x{TEST_CANVAS_SIZE}"
        ));
        return;
    }

    // GL result.
    let mut gl_result = Surface::new(TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
    {
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, specialize_shader(&spec.vertex_source, context))
            .with(ShaderType::Geometry, specialize_shader(&spec.geometry_source, context))
            .with(ShaderType::Fragment, specialize_shader(&spec.fragment_source, context));
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            case.fail("Program compilation failed".to_string(), "Program compilation failed");
            return;
        }
        let program_id = program.program();

        let vao = VertexArray::new(gl);
        let position_buffer = Buffer::new(gl);
        let color_buffer = Buffer::new(gl);
        let index_buffer = Buffer::new(gl);
        let pre_render_texture = Texture::new(gl);
        let mut pre_render_error: Option<&str> = None;
        let data_attribute =
            std::ffi::CString::new(spec.data_attribute.as_str()).expect("attribute names contain no NUL");
        // SAFETY: names this case owns; the host arrays outlive the upload.
        unsafe {
            gl.bind_vertex_array(vao.get());

            let attr_pos_loc = gl.get_attrib_location(program_id, c"a_position".as_ptr());
            let attr_col_loc = gl.get_attrib_location(program_id, data_attribute.as_ptr());

            if attr_pos_loc != -1 {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, position_buffer.get());
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    std::mem::size_of_val(spec.positions.as_slice()) as isize,
                    spec.positions.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
                gl.vertex_attrib_pointer(attr_pos_loc as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                gl.enable_vertex_attrib_array(attr_pos_loc as u32);
            }
            if attr_col_loc != -1 {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, color_buffer.get());
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    std::mem::size_of_val(spec.colors.as_slice()) as isize,
                    spec.colors.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
                gl.vertex_attrib_pointer(attr_col_loc as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                gl.enable_vertex_attrib_array(attr_col_loc as u32);
                if spec.instances.is_some() {
                    gl.vertex_attrib_divisor(attr_col_loc as u32, 1);
                }
            }

            if let Some(indices) = &spec.restart_indices {
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buffer.get());
                gl.buffer_data(
                    glw::GL_ELEMENT_ARRAY_BUFFER,
                    std::mem::size_of_val(indices.as_slice()) as isize,
                    indices.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
            }

            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.viewport(0, 0, TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
            gl.use_program(program_id);
            match spec.pre_render {
                PreRender::None => {}
                PreRender::EmitCountUniform(emit_count) => {
                    let location = gl.get_uniform_location(program_id, c"u_emitCount".as_ptr());
                    if location == -1 {
                        pre_render_error = Some("uniform location of u_emitCount was -1.");
                    } else {
                        gl.uniform_4iv(location, 1, emit_count.as_ptr());
                    }
                }
                PreRender::Texture => {
                    let data: [u8; 16] = [255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255];
                    let location = gl.get_uniform_location(program_id, c"u_sampler".as_ptr());
                    if location == -1 {
                        pre_render_error = Some("uniform location of u_sampler was -1.");
                    } else {
                        gl.uniform_1i(location, 0);
                        gl.active_texture(glw::GL_TEXTURE0);
                        gl.bind_texture(glw::GL_TEXTURE_2D, pre_render_texture.get());
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_2D,
                            0,
                            glw::GL_RGBA8 as i32,
                            4,
                            1,
                            0,
                            glw::GL_RGBA,
                            glw::GL_UNSIGNED_BYTE,
                            data.as_ptr().cast(),
                        );
                        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
                        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
                    }
                }
            }
            if let Some(indices) = &spec.restart_indices {
                gl.enable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX);
                gl.draw_elements(
                    spec.input_primitives,
                    indices.len() as i32,
                    glw::GL_UNSIGNED_SHORT,
                    std::ptr::null(),
                );
                gl.disable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX);
            } else if let Some(num_instances) = spec.instances {
                gl.draw_arrays_instanced(spec.input_primitives, 0, spec.positions.len() as i32, num_instances);
            } else {
                gl.draw_arrays(spec.input_primitives, 0, spec.positions.len() as i32);
            }
            gl.use_program(0);
            gl.bind_vertex_array(0);
        }
        if let Some(reason) = pre_render_error {
            case.fail(reason.to_string(), reason);
            return;
        }
        case.expect_no_error("GL render");

        if let Err(e) = glu::read_pixels(&context.render_context, 0, 0, &mut gl_result.get_access()) {
            case.fail(e.to_string(), "glReadPixels() failed");
            return;
        }
    }

    // Reference result.
    let mut ref_result = Surface::new(TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
    {
        let mut ref_ctx = match create_reference_context_rgb8(
            context,
            TEST_CANVAS_SIZE,
            TEST_CANVAS_SIZE,
            render_target.depth_bits,
        ) {
            Ok(ctx) => ctx,
            Err(e) => {
                case.fail(e.to_string(), "Reference context creation failed");
                return;
            }
        };

        let program_id = ref_ctx.create_shader_program(Box::new(PassthroughShader::new(spec.use_point_size)));
        let (mode, positions, colors, point_sizes) = flatten_strips(spec.output_type, &spec.strips);

        ref_ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ref_ctx.clear(glw::GL_COLOR_BUFFER_BIT);
        ref_ctx.viewport(0, 0, TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
        ref_ctx.use_program(program_id);

        if !positions.is_empty() {
            let position_loc = ref_ctx.get_attrib_location(program_id, "a_position") as u32;
            let color_loc = ref_ctx.get_attrib_location(program_id, "a_color") as u32;

            ref_ctx.enable_vertex_attrib_array(position_loc);
            ref_ctx.vertex_attrib_pointer(
                position_loc,
                4,
                glw::GL_FLOAT,
                false,
                0,
                positions.as_ptr() as usize,
                true,
            );
            ref_ctx.enable_vertex_attrib_array(color_loc);
            ref_ctx.vertex_attrib_pointer(color_loc, 4, glw::GL_FLOAT, false, 0, colors.as_ptr() as usize, true);
            if spec.use_point_size {
                let point_size_loc = ref_ctx.get_attrib_location(program_id, "a_pointSize") as u32;
                ref_ctx.enable_vertex_attrib_array(point_size_loc);
                ref_ctx.vertex_attrib_pointer(
                    point_size_loc,
                    4,
                    glw::GL_FLOAT,
                    false,
                    0,
                    point_sizes.as_ptr() as usize,
                    true,
                );
                ref_ctx.draw_arrays(mode, 0, positions.len() as i32);
                ref_ctx.disable_vertex_attrib_array(point_size_loc);
            } else {
                ref_ctx.draw_arrays(mode, 0, positions.len() as i32);
            }
            ref_ctx.disable_vertex_attrib_array(position_loc);
            ref_ctx.disable_vertex_attrib_array(color_loc);
        }

        ref_ctx.use_program(0);
        ref_ctx.finish();
        ref_ctx.read_pixels(&mut ref_result, 0, 0, TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
        let error = ref_ctx.get_error();
        if error != glw::GL_NO_ERROR {
            case.fail(
                format!("reference context error 0x{error:04X}"),
                "Reference context error",
            );
            return;
        }
    }

    if let Some(reason) = compare_results(&ref_result, &gl_result, render_target.num_samples) {
        case.fail(reason, "Image comparison failed");
    }
}

fn add_render_case(group: &mut TestCaseGroup, name: impl Into<String>, spec: RenderSpec) {
    add_api_case(group, name, move |case: &mut ApiCase<'_>| render_case(case, &spec));
}

// ---------------------------------------------------------------------------------------
// GeometryExpanderRenderTest / TriangleStripAdjacencyVertexCountTest
// ---------------------------------------------------------------------------------------

/// `GeometryShaderRenderTest::genVertexAttribData`'s 1x2 grid in triangle strip adjacency order.
fn grid_vertex_data() -> (Vec<V4>, Vec<V4>) {
    let scale_f = 0.3f32;
    let offset: V4 = [-0.5, -0.2, 0.0, 1.0];
    let raw: [[f32; 2]; 12] = [
        [0.0, 0.0],
        [-1.0, -1.0],
        [0.0, -1.0],
        [1.0, 1.0],
        [1.0, 0.0],
        [0.0, -2.0],
        [1.0, -1.0],
        [2.0, 1.0],
        [2.0, 0.0],
        [1.0, -2.0],
        [2.0, -1.0],
        [3.0, 0.0],
    ];

    let positions = raw
        .iter()
        .map(|p| add([p[0] * scale_f, p[1] * scale_f, 0.0, 0.0], offset))
        .collect();
    // Red and white
    let colors = (0..12)
        .map(|i| {
            if i % 2 == 0 {
                [1.0, 1.0, 1.0, 1.0]
            } else {
                [1.0, 0.0, 0.0, 1.0]
            }
        })
        .collect();
    (positions, colors)
}

/// `GeometryExpanderRenderTest` with `numDrawVertices` of the grid.
fn expander_spec(input_primitives: GLenum, output_primitives: GLenum, num_draw_vertices: usize) -> RenderSpec {
    let (mut positions, mut colors) = grid_vertex_data();
    positions.truncate(num_draw_vertices);
    colors.truncate(num_draw_vertices);

    let input_type = map_geometry_input_type(input_primitives);
    let output_type = OutputType::from_gl(output_primitives);

    let mut geometry_source = String::from("${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}");
    geometry_source.push_str(&format!("layout({}) in;\n", input_type_to_glsl_string(input_type)));
    geometry_source.push_str(&format!(
        "layout({}, max_vertices = {}) out;",
        output_type.glsl(),
        expander_output_vertices(input_type)
    ));
    geometry_source.push('\n');
    geometry_source.push_str(EXPAND_GEOMETRY_BODY);

    let strips = emulate_expander(input_primitives, &positions, &colors);
    RenderSpec {
        input_primitives,
        output_type,
        vertex_source: COMMON_VERTEX_SOURCE.to_string(),
        geometry_source,
        fragment_source: COMMON_FRAGMENT_SOURCE.to_string(),
        positions,
        colors,
        strips,
        data_attribute: "a_color".to_string(),
        restart_indices: None,
        use_point_size: false,
        instances: None,
        pre_render: PreRender::None,
    }
}

fn input_group() -> TestCaseGroup {
    // name, input primitive, output primitive
    const INPUT_PRIMITIVES: [(&str, GLenum, GLenum); 10] = [
        ("points", glw::GL_POINTS, glw::GL_POINTS),
        ("lines", glw::GL_LINES, glw::GL_LINE_STRIP),
        ("line_loop", glw::GL_LINE_LOOP, glw::GL_LINE_STRIP),
        ("line_strip", glw::GL_LINE_STRIP, glw::GL_LINE_STRIP),
        ("triangles", glw::GL_TRIANGLES, glw::GL_TRIANGLE_STRIP),
        ("triangle_strip", glw::GL_TRIANGLE_STRIP, glw::GL_TRIANGLE_STRIP),
        ("triangle_fan", glw::GL_TRIANGLE_FAN, glw::GL_TRIANGLE_STRIP),
        ("lines_adjacency", glw::GL_LINES_ADJACENCY, glw::GL_LINE_STRIP),
        ("line_strip_adjacency", glw::GL_LINE_STRIP_ADJACENCY, glw::GL_LINE_STRIP),
        (
            "triangles_adjacency",
            glw::GL_TRIANGLES_ADJACENCY,
            glw::GL_TRIANGLE_STRIP,
        ),
    ];

    let mut group = TestCaseGroup::new("input");

    let mut basic_primitive_group = TestCaseGroup::new("basic_primitive");
    for (name, input, output) in INPUT_PRIMITIVES {
        add_render_case(&mut basic_primitive_group, name, expander_spec(input, output, 12));
    }

    // triangle strip adjacency with different vtx counts
    let mut tri_strip_adjacency_group = TestCaseGroup::new("triangle_strip_adjacency");
    for vtx_count in 0..=12usize {
        add_render_case(
            &mut tri_strip_adjacency_group,
            format!("vertex_count_{vtx_count}"),
            expander_spec(glw::GL_TRIANGLE_STRIP_ADJACENCY, glw::GL_TRIANGLE_STRIP, vtx_count),
        );
    }

    group.add_child(basic_primitive_group);
    group.add_child(tri_strip_adjacency_group);
    group
}

fn conversion_group() -> TestCaseGroup {
    const CONVERSION_PRIMITIVES: [(&str, GLenum, GLenum); 6] = [
        ("triangles_to_points", glw::GL_TRIANGLES, glw::GL_POINTS),
        ("lines_to_points", glw::GL_LINES, glw::GL_POINTS),
        ("points_to_lines", glw::GL_POINTS, glw::GL_LINE_STRIP),
        ("triangles_to_lines", glw::GL_TRIANGLES, glw::GL_LINE_STRIP),
        ("points_to_triangles", glw::GL_POINTS, glw::GL_TRIANGLE_STRIP),
        ("lines_to_triangles", glw::GL_LINES, glw::GL_TRIANGLE_STRIP),
    ];

    let mut group = TestCaseGroup::new("conversion");
    for (name, input, output) in CONVERSION_PRIMITIVES {
        add_render_case(&mut group, name, expander_spec(input, output, 12));
    }
    group
}

// ---------------------------------------------------------------------------------------
// EmitTest
// ---------------------------------------------------------------------------------------

/// `VertexEmitterShader::genGeometrySource`
fn emitter_geometry_source(emit_a: i32, end_a: i32, emit_b: i32, end_b: i32, output_type: OutputType) -> String {
    let mut s = String::from("${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}");
    s.push_str("layout(points) in;\n");
    s.push_str(&format!(
        "layout({}, max_vertices = {}) out;",
        output_type.glsl(),
        emit_a + emit_b
    ));
    s.push('\n');

    s.push_str(
        "in highp vec4 v_geom_FragColor[];\n\
         out highp vec4 v_frag_FragColor;\n\
         \n\
         void main (void)\n\
         {\n\
         \x20   const highp vec4 position0 = vec4(-0.5,  0.5, 0.0, 0.0);\n\
         \x20   const highp vec4 position1 = vec4( 0.0,  0.1, 0.0, 0.0);\n\
         \x20   const highp vec4 position2 = vec4( 0.5,  0.5, 0.0, 0.0);\n\
         \x20   const highp vec4 position3 = vec4( 0.7, -0.2, 0.0, 0.0);\n\
         \x20   const highp vec4 position4 = vec4( 0.2,  0.2, 0.0, 0.0);\n\
         \x20   const highp vec4 position5 = vec4( 0.4, -0.3, 0.0, 0.0);\n\
         \n",
    );

    let emit = |s: &mut String, position: i32| {
        s.push_str(&format!(
            "    gl_Position = gl_in[0].gl_Position + position{position};\n\
             \x20   gl_PrimitiveID = gl_PrimitiveIDIn;\n\
             \x20   v_frag_FragColor = v_geom_FragColor[0];\n\
             \x20   EmitVertex();\n\
             \n"
        ));
    };

    for i in 0..emit_a {
        emit(&mut s, i);
    }
    for _ in 0..end_a {
        s.push_str("    EndPrimitive();\n");
    }
    for i in 0..emit_b {
        emit(&mut s, emit_a + i);
    }
    for _ in 0..end_b {
        s.push_str("    EndPrimitive();\n");
    }

    s.push_str("}\n");
    s
}

fn emit_group() -> TestCaseGroup {
    // output type, emitCountA, endCountA, emitCountB, endCountB, name
    const EMIT_TESTS: [(GLenum, i32, i32, i32, i32, &str); 23] = [
        (glw::GL_POINTS, 0, 0, 0, 0, "points"),
        (glw::GL_POINTS, 0, 1, 0, 0, "points"),
        (glw::GL_POINTS, 1, 1, 0, 0, "points"),
        (glw::GL_POINTS, 0, 2, 0, 0, "points"),
        (glw::GL_POINTS, 1, 2, 0, 0, "points"),
        (glw::GL_LINE_STRIP, 0, 0, 0, 0, "line_strip"),
        (glw::GL_LINE_STRIP, 0, 1, 0, 0, "line_strip"),
        (glw::GL_LINE_STRIP, 1, 1, 0, 0, "line_strip"),
        (glw::GL_LINE_STRIP, 2, 1, 0, 0, "line_strip"),
        (glw::GL_LINE_STRIP, 0, 2, 0, 0, "line_strip"),
        (glw::GL_LINE_STRIP, 1, 2, 0, 0, "line_strip"),
        (glw::GL_LINE_STRIP, 2, 2, 0, 0, "line_strip"),
        (glw::GL_LINE_STRIP, 2, 2, 2, 0, "line_strip"),
        (glw::GL_TRIANGLE_STRIP, 0, 0, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 0, 1, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 1, 1, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 2, 1, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 3, 1, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 0, 2, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 1, 2, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 2, 2, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 3, 2, 0, 0, "triangle_strip"),
        (glw::GL_TRIANGLE_STRIP, 3, 2, 3, 0, "triangle_strip"),
    ];

    let mut group = TestCaseGroup::new("emit");
    for (output, emit_a, end_a, emit_b, end_b, type_name) in EMIT_TESTS {
        let mut name = format!("{type_name}_emit_{emit_a}_end_{end_a}");
        if emit_b != 0 {
            name.push_str(&format!("_emit_{emit_b}_end_{end_b}"));
        }

        let output_type = OutputType::from_gl(output);
        let positions = vec![[0.0, 0.0, 0.0, 1.0]];
        let colors = vec![[1.0, 1.0, 1.0, 1.0]];
        let strips = emulate_emitter(emit_a, end_a, emit_b, end_b, &positions, &colors);

        add_render_case(
            &mut group,
            name,
            RenderSpec {
                input_primitives: glw::GL_POINTS,
                output_type,
                vertex_source: COMMON_VERTEX_SOURCE.to_string(),
                geometry_source: emitter_geometry_source(emit_a, end_a, emit_b, end_b, output_type),
                fragment_source: COMMON_FRAGMENT_SOURCE.to_string(),
                positions,
                colors,
                strips,
                data_attribute: "a_color".to_string(),
                restart_indices: None,
                use_point_size: false,
                instances: None,
                pre_render: PreRender::None,
            },
        );
    }
    group
}

// ---------------------------------------------------------------------------------------
// VaryingTest
// ---------------------------------------------------------------------------------------

/// `VertexVaryingShader::genProgramDeclaration`'s three GLSL sources, unspecialized.
fn varying_sources(vertex_out: i32, geometry_out: i32) -> (String, String, String) {
    let mut vertex = String::from("${GLSL_VERSION_DECL}\nin highp vec4 a_position;\nin highp vec4 a_color;\n");
    if vertex_out == -1 {
        vertex.push_str("void main (void)\n{\n}\n");
    } else {
        for i in 0..vertex_out {
            vertex.push_str(&format!("out highp vec4 v_geom_{i};\n"));
        }
        vertex.push_str("void main (void)\n{\n\tgl_Position = a_position;\n\tgl_PointSize = 1.0;\n");
        match vertex_out {
            0 => {}
            1 => vertex.push_str("\tv_geom_0 = a_color;\n"),
            _ => {
                vertex.push_str("\tv_geom_0 = a_color * 0.5;\n");
                vertex.push_str("\tv_geom_1 = a_color.zyxw * 0.5;\n");
            }
        }
        vertex.push_str("}\n");
    }

    let mut fragment = String::from("${GLSL_VERSION_DECL}\nlayout(location = 0) out mediump vec4 fragColor;\n");
    for i in 0..geometry_out {
        fragment.push_str(&format!("in mediump vec4 v_frag_{i};\n"));
    }
    fragment.push_str("void main (void)\n{\n");
    match geometry_out {
        0 => fragment.push_str("\tfragColor = vec4(1.0, 0.0, 0.0, 1.0);\n"),
        1 => fragment.push_str("\tfragColor = v_frag_0;\n"),
        _ => fragment.push_str("\tfragColor = v_frag_0 + v_frag_1.yxzw;\n"),
    }
    fragment.push_str("}\n");

    let mut geometry = String::from(
        "${GLSL_VERSION_DECL}\n\
         ${GLSL_EXT_GEOMETRY_SHADER}\
         layout(triangles) in;\n\
         layout(triangle_strip, max_vertices = 3) out;\n",
    );
    for i in 0..vertex_out {
        geometry.push_str(&format!("in highp vec4 v_geom_{i}[];\n"));
    }
    for i in 0..geometry_out {
        geometry.push_str(&format!("out highp vec4 v_frag_{i};\n"));
    }
    geometry.push_str(
        "void main (void)\n{\n\thighp vec4 offset = vec4(-0.2, -0.2, 0.0, 0.0);\n\thighp vec4 inputColor;\n\n",
    );
    for vertex_ndx in 0..3 {
        if vertex_out == -1 {
            let xy = match vertex_ndx {
                0 => "0.0, 0.0",
                1 => "1.0, 0.0",
                _ => "1.0, 1.0",
            };
            geometry.push_str(&format!(
                "\tinputColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
                 \tgl_Position = vec4({xy}, 0.0, 1.0) + offset;\n\
                 \tgl_PrimitiveID = gl_PrimitiveIDIn;\n"
            ));
        } else {
            match vertex_out {
                0 => geometry.push_str("\tinputColor = vec4(1.0, 0.0, 0.0, 1.0);\n"),
                1 => geometry.push_str(&format!("\tinputColor = v_geom_0[{vertex_ndx}];\n")),
                _ => geometry.push_str(&format!(
                    "\tinputColor = v_geom_0[{vertex_ndx}] * 0.5 + v_geom_1[{vertex_ndx}].zyxw * 0.5;\n"
                )),
            }
            geometry.push_str(&format!(
                "\tgl_Position = gl_in[{vertex_ndx}].gl_Position + offset;\n\
                 \tgl_PrimitiveID = gl_PrimitiveIDIn;\n"
            ));
        }
        match geometry_out {
            0 => {}
            1 => geometry.push_str("\tv_frag_0 = inputColor;\n"),
            _ => {
                geometry.push_str("\tv_frag_0 = inputColor * 0.5;\n");
                geometry.push_str("\tv_frag_1 = inputColor.yxzw * 0.5;\n");
            }
        }
        geometry.push_str("\tEmitVertex();\n\n");
    }
    geometry.push_str("\tEndPrimitive();\n}\n");

    (vertex, geometry, fragment)
}

fn varying_group() -> TestCaseGroup {
    // vertexOutputs, geometryOutputs, name
    const VARYING_TESTS: [(i32, i32, &str); 5] = [
        (-1, 1, "vertex_no_op_geometry_out_1"),
        (0, 1, "vertex_out_0_geometry_out_1"),
        (0, 2, "vertex_out_0_geometry_out_2"),
        (1, 0, "vertex_out_1_geometry_out_0"),
        (1, 2, "vertex_out_1_geometry_out_2"),
    ];

    let mut group = TestCaseGroup::new("varying");
    for (vertex_out, geometry_out, name) in VARYING_TESTS {
        // `VaryingTest::genVertexAttribData`
        let positions: Vec<V4> = vec![[0.5, 0.0, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0], [0.1, 0.0, 0.0, 1.0]];
        let colors: Vec<V4> = vec![[0.7, 0.4, 0.6, 1.0], [0.9, 0.2, 0.5, 1.0], [0.1, 0.8, 0.3, 1.0]];

        let (vertex_source, geometry_source, fragment_source) = varying_sources(vertex_out, geometry_out);
        let strips = emulate_varying(vertex_out, geometry_out, &positions, &colors);

        add_render_case(
            &mut group,
            name,
            RenderSpec {
                input_primitives: glw::GL_TRIANGLES,
                output_type: OutputType::TriangleStrip,
                vertex_source,
                geometry_source,
                fragment_source,
                positions,
                colors,
                strips,
                data_attribute: "a_color".to_string(),
                restart_indices: None,
                use_point_size: false,
                instances: None,
                pre_render: PreRender::None,
            },
        );
    }
    group
}

// ---------------------------------------------------------------------------------------
// OutputCountCase
// ---------------------------------------------------------------------------------------

/// `OutputCountShader::genGeometrySource`
fn output_count_geometry_source(pattern: &[i32]) -> String {
    let max_emit_count = *pattern.iter().max().expect("pattern is not empty");
    let mut s = String::from("${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}");
    s.push_str("layout(points) in;\n");
    s.push_str(&format!("layout(triangle_strip, max_vertices = {max_emit_count}) out;"));
    s.push('\n');
    s.push_str(&format!(
        "in highp vec4 v_geom_FragColor[];\n\
         out highp vec4 v_frag_FragColor;\n\
         \n\
         void main (void)\n\
         {{\n\
         \x20   const highp float rowHeight = 2.0 / float({});\n\
         \x20   const highp float colWidth = 2.0 / float({max_emit_count});\n\
         \n",
        pattern.len()
    ));

    s.push_str("    highp int emitCount = ");
    for (ndx, count) in pattern[..pattern.len() - 1].iter().enumerate() {
        s.push_str(&format!("(gl_PrimitiveIDIn == {ndx}) ? ({count}) : ("));
    }
    s.push_str(&pattern[pattern.len() - 1].to_string());
    if pattern.len() != 1 {
        s.push(')');
    }
    s.push_str(";\n");
    s.push_str(
        "    for (highp int ndx = 0; ndx < emitCount / 2; ndx++)\n\
         \x20   {\n\
         \x20       gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, 0.0, 0.0, 0.0);\n\
         \x20       v_frag_FragColor = v_geom_FragColor[0];\n\
         \x20       EmitVertex();\n\
         \n\
         \x20       gl_Position = gl_in[0].gl_Position + vec4(float(ndx) * 2.0 * colWidth, rowHeight, 0.0, 0.0);\n\
         \x20       v_frag_FragColor = v_geom_FragColor[0];\n\
         \x20       EmitVertex();\n\
         \x20   }\n\
         }\n",
    );
    s
}

/// `OutputCountShader::shadePrimitives` over `OutputCountCase::genVertexAttribData`'s points.
fn output_count_spec(pattern: &[i32]) -> RenderSpec {
    let primitive_count = pattern.len();
    let max_emit_count = *pattern.iter().max().expect("pattern is not empty");

    let positions: Vec<V4> = (0..primitive_count)
        .map(|ndx| [-1.0, ndx as f32 / primitive_count as f32 * 2.0 - 1.0, 0.0, 1.0])
        .collect();
    let colors: Vec<V4> = (0..primitive_count)
        .map(|ndx| {
            if ndx % 2 == 0 {
                [1.0, 1.0, 1.0, 1.0]
            } else {
                [1.0, 0.0, 0.0, 1.0]
            }
        })
        .collect();

    let row_height = 2.0 / primitive_count as f32;
    let col_width = 2.0 / max_emit_count as f32;
    let mut emitter = Emitter::default();
    for ndx in 0..primitive_count {
        for i in 0..pattern[ndx] / 2 {
            emitter.emit_vertex(
                add(positions[ndx], [2.0 * i as f32 * col_width, 0.0, 0.0, 0.0]),
                colors[ndx],
            );
            emitter.emit_vertex(
                add(positions[ndx], [2.0 * i as f32 * col_width, row_height, 0.0, 0.0]),
                colors[ndx],
            );
        }
        emitter.end_primitive();
    }

    RenderSpec {
        input_primitives: glw::GL_POINTS,
        output_type: OutputType::TriangleStrip,
        vertex_source: COMMON_VERTEX_SOURCE.to_string(),
        geometry_source: output_count_geometry_source(pattern),
        fragment_source: COMMON_FRAGMENT_SOURCE.to_string(),
        positions,
        colors,
        strips: emitter.finish(),
        data_attribute: "a_color".to_string(),
        restart_indices: None,
        use_point_size: false,
        instances: None,
        pre_render: PreRender::None,
    }
}

/// `OutputCountCase::init` + the render. A pattern of `[-1]` is the "max vertices" case.
fn output_count_case(case: &mut ApiCase<'_>, pattern: &[i32]) {
    let mut pattern = pattern.to_vec();
    let components_per_vertex = 4 + 4; // vec4 pos, vec4 color
    let test_vertices = *pattern.iter().max().expect("pattern is not empty");

    // check the extension before querying anything
    if !check_support(case.context()) {
        case.not_supported("Tests require GL_EXT_geometry_shader extension or higher context version.");
        return;
    }

    let max_vertices = case.get_int(glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES);
    let max_components = case.get_int(glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS);
    log::debug!("GL_MAX_GEOMETRY_OUTPUT_VERTICES = {max_vertices}");
    log::debug!("GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = {max_components}");

    if test_vertices == -1 {
        // "max vertices"-case
        pattern[0] = max_vertices.min(max_components / components_per_vertex);
        // make sure size is dividable by 2, as OutputShader requires
        pattern[0] &= !1;
        if pattern[0] == 0 {
            case.fail("Pattern size is invalid.".to_string(), "Pattern size is invalid.");
            return;
        }
    } else {
        if test_vertices > max_vertices {
            case.not_supported(format!("{test_vertices} output vertices required."));
            return;
        }
        if test_vertices * components_per_vertex > max_components {
            case.not_supported(format!(
                "{} output components required.",
                test_vertices * components_per_vertex
            ));
            return;
        }
    }

    render_case(case, &output_count_spec(&pattern));
}

// ---------------------------------------------------------------------------------------
// BuiltinVariableRenderTest
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum VariableTest {
    PointSize,
    PrimitiveIdIn,
    PrimitiveId,
}

impl VariableTest {
    /// `BuiltinVariableShader::getTestAttributeName`
    fn attribute_name(self) -> &'static str {
        match self {
            VariableTest::PointSize => "a_pointSize",
            VariableTest::PrimitiveIdIn => "",
            VariableTest::PrimitiveId => "a_primitiveID",
        }
    }
}

/// `BuiltinVariableShader::genVertexSource`
fn builtin_vertex_source(test: VariableTest) -> String {
    let mut buf = String::from("${GLSL_VERSION_DECL}\nin highp vec4 a_position;\n");
    match test {
        VariableTest::PointSize => buf.push_str("in highp vec4 a_pointSize;\nout highp vec4 v_geom_pointSize;\n"),
        VariableTest::PrimitiveId => buf.push_str("in highp vec4 a_primitiveID;\nout highp vec4 v_geom_primitiveID;\n"),
        VariableTest::PrimitiveIdIn => {}
    }
    buf.push_str("void main (void)\n{\n    gl_Position = a_position;\n    gl_PointSize = 1.0;\n");
    match test {
        VariableTest::PointSize => buf.push_str("    v_geom_pointSize = a_pointSize;\n"),
        VariableTest::PrimitiveId => buf.push_str("    v_geom_primitiveID = a_primitiveID;\n"),
        VariableTest::PrimitiveIdIn => {}
    }
    buf.push_str("}\n");
    buf
}

/// `BuiltinVariableShader::genGeometrySource`
fn builtin_geometry_source(test: VariableTest) -> String {
    let mut buf = String::from("${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}");
    if test == VariableTest::PointSize {
        buf.push_str("#extension GL_EXT_geometry_point_size : require\n");
    }
    buf.push_str("layout(points) in;\n");
    if test == VariableTest::PointSize {
        buf.push_str("layout(points, max_vertices = 1) out;\n");
    } else {
        buf.push_str("layout(triangle_strip, max_vertices = 3) out;\n");
    }
    match test {
        VariableTest::PointSize => buf.push_str("in highp vec4 v_geom_pointSize[];\n"),
        VariableTest::PrimitiveId => buf.push_str("in highp vec4 v_geom_primitiveID[];\n"),
        VariableTest::PrimitiveIdIn => {}
    }
    if test != VariableTest::PrimitiveId {
        buf.push_str("out highp vec4 v_frag_FragColor;\n");
    }
    buf.push_str("\nvoid main (void)\n{\n");
    match test {
        VariableTest::PointSize => buf.push_str(
            "    gl_Position = gl_in[0].gl_Position;\n\
             \x20   gl_PointSize = v_geom_pointSize[0].x + 1.0;\n\
             \x20   v_frag_FragColor = vec4(1.0, 1.0, 1.0, 1.0);\n\
             \x20   EmitVertex();\n",
        ),
        VariableTest::PrimitiveIdIn => buf.push_str(
            "    const highp vec4 red = vec4(1.0, 0.0, 0.0, 1.0);\n\
             \x20   const highp vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   const highp vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);\n\
             \x20   const highp vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n\
             \x20   const highp vec4 colors[4] = vec4[4](red, green, blue, yellow);\n\
             \n\
             \x20   gl_Position = gl_in[0].gl_Position + vec4(0.05, 0.0, 0.0, 0.0);\n\
             \x20   v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];\n\
             \x20   EmitVertex();\n\
             \n\
             \x20   gl_Position = gl_in[0].gl_Position - vec4(0.05, 0.0, 0.0, 0.0);\n\
             \x20   v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];\n\
             \x20   EmitVertex();\n\
             \n\
             \x20   gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.05, 0.0, 0.0);\n\
             \x20   v_frag_FragColor = colors[gl_PrimitiveIDIn % 4];\n\
             \x20   EmitVertex();\n",
        ),
        VariableTest::PrimitiveId => buf.push_str(
            "    gl_Position = gl_in[0].gl_Position + vec4(0.05, 0.0, 0.0, 0.0);\n\
             \x20   gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;\n\
             \x20   EmitVertex();\n\
             \n\
             \x20   gl_Position = gl_in[0].gl_Position - vec4(0.05, 0.0, 0.0, 0.0);\n\
             \x20   gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;\n\
             \x20   EmitVertex();\n\
             \n\
             \x20   gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.05, 0.0, 0.0);\n\
             \x20   gl_PrimitiveID = int(floor(v_geom_primitiveID[0].x)) + 3;\n\
             \x20   EmitVertex();\n\
             \n",
        ),
    }
    buf.push_str("}\n");
    buf
}

/// `BuiltinVariableShader::genFragmentSource`
fn builtin_fragment_source(test: VariableTest) -> String {
    match test {
        VariableTest::PointSize | VariableTest::PrimitiveIdIn => COMMON_FRAGMENT_SOURCE.to_string(),
        VariableTest::PrimitiveId => "${GLSL_VERSION_DECL}\n\
             ${GLSL_EXT_GEOMETRY_SHADER}\
             layout(location = 0) out mediump vec4 fragColor;\n\
             void main (void)\n\
             {\n\
             \x20   const mediump vec4 red = vec4(1.0, 0.0, 0.0, 1.0);\n\
             \x20   const mediump vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   const mediump vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);\n\
             \x20   const mediump vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n\
             \x20   const mediump vec4 colors[4] = vec4[4](yellow, red, green, blue);\n\
             \x20   fragColor = colors[gl_PrimitiveID % 4];\n\
             }\n"
        .to_string(),
    }
}

/// `BuiltinVariableRenderTest::genVertexAttribData` and `BuiltinVariableShader::shadePrimitives`.
fn builtin_spec(test: VariableTest, use_restart: bool) -> RenderSpec {
    let red: V4 = [1.0, 0.0, 0.0, 1.0];
    let green: V4 = [0.0, 1.0, 0.0, 1.0];
    let blue: V4 = [0.0, 0.0, 1.0, 1.0];
    let yellow: V4 = [1.0, 1.0, 0.0, 1.0];

    let positions: Vec<V4> = vec![
        [0.5, 0.0, 0.0, 1.0],
        [0.0, 0.5, 0.0, 1.0],
        [-0.7, -0.1, 0.0, 1.0],
        [-0.1, -0.7, 0.0, 1.0],
    ];
    let data: Vec<V4> = vec![
        [0.0, 0.0, 0.0, 0.0],
        [1.0, 0.0, 0.0, 0.0],
        [2.0, 0.0, 0.0, 0.0],
        [3.0, 0.0, 0.0, 0.0],
    ];
    // Only used by the primitive ID restart test: the restart index is not a vertex.
    let restart_indices: Vec<u16> = vec![3, 2, 0xFFFF, 1];

    let draw_order: Vec<usize> = if use_restart { vec![3, 2, 1] } else { vec![0, 1, 2, 3] };

    let id_in_colors = [red, green, blue, yellow];
    let id_colors = [yellow, red, green, blue];

    let mut emitter = Emitter::default();
    for (primitive_id, &v) in draw_order.iter().enumerate() {
        let position = positions[v];
        match test {
            VariableTest::PointSize => {
                emitter.emit_vertex_sized(position, data[v][0] + 1.0, [1.0, 1.0, 1.0, 1.0]);
            }
            VariableTest::PrimitiveIdIn => {
                let color = id_in_colors[primitive_id % 4];
                emitter.emit_vertex(add(position, [0.05, 0.0, 0.0, 0.0]), color);
                emitter.emit_vertex(add(position, [-0.05, 0.0, 0.0, 0.0]), color);
                emitter.emit_vertex(add(position, [0.0, 0.05, 0.0, 0.0]), color);
            }
            VariableTest::PrimitiveId => {
                let id = data[v][0].floor() as i32 + 3;
                let color = id_colors[(id % 4) as usize];
                emitter.emit_vertex(add(position, [0.05, 0.0, 0.0, 0.0]), color);
                emitter.emit_vertex(add(position, [-0.05, 0.0, 0.0, 0.0]), color);
                emitter.emit_vertex(add(position, [0.0, 0.05, 0.0, 0.0]), color);
            }
        }
        emitter.end_primitive();
    }

    RenderSpec {
        input_primitives: glw::GL_POINTS,
        output_type: if test == VariableTest::PointSize {
            OutputType::Points
        } else {
            OutputType::TriangleStrip
        },
        vertex_source: builtin_vertex_source(test),
        geometry_source: builtin_geometry_source(test),
        fragment_source: builtin_fragment_source(test),
        positions,
        colors: data,
        strips: emitter.finish(),
        data_attribute: test.attribute_name().to_string(),
        restart_indices: use_restart.then_some(restart_indices),
        use_point_size: test == VariableTest::PointSize,
        instances: None,
        pre_render: PreRender::None,
    }
}

/// `BuiltinVariableRenderTest::init`'s requirements, then the render.
fn builtin_variable_case(case: &mut ApiCase<'_>, test: VariableTest, use_restart: bool) {
    if test == VariableTest::PointSize {
        let context = case.context();
        let gl = case.gl();
        let required_point_size = 5.0f32;
        let mut range = [1.0f32, 1.0];

        if !context
            .context_info
            .is_extension_supported("GL_EXT_geometry_point_size")
        {
            case.not_supported("Tests require GL_EXT_geometry_point_size extension.");
            return;
        }

        // SAFETY: two floats of output for the range query.
        unsafe { gl.get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, range.as_mut_ptr()) };
        if range[1] < required_point_size {
            case.not_supported(format!("Test case requires point size {required_point_size}"));
            return;
        }
    }

    render_case(case, &builtin_spec(test, use_restart));
}

// ---------------------------------------------------------------------------------------
// GeometryInvocationCase / DrawInstancedGeometryInstancedCase
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum InvocationOutput {
    Fixed,
    Different,
}

/// `InvocationCountShader::genGeometrySource`
fn invocation_geometry_source(num_invocations: i32, test_case: InvocationOutput) -> String {
    let max_vertices = match test_case {
        InvocationOutput::Fixed => 3,
        InvocationOutput::Different => 2 + num_invocations,
    };
    let mut buf = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{GLSL_EXT_GEOMETRY_SHADER}}\
         layout(points, invocations = {num_invocations}) in;\n\
         layout(triangle_strip, max_vertices = {max_vertices}) out;\n\
         \n\
         in highp vec4 v_geom_FragColor[];\n\
         out highp vec4 v_frag_FragColor;\n\
         \n\
         void main ()\n\
         {{\n\
         \x20   highp float l_angle = float(gl_InvocationID) / float({num_invocations}) * 5.5;\n\
         \x20   highp float l_radius = 0.6;\n\
         \n"
    );
    match test_case {
        InvocationOutput::Fixed => buf.push_str(
            "    v_frag_FragColor = vec4(1.0, 1.0, 0.0, 1.0) * v_geom_FragColor[0];\n\
             \x20   gl_Position = gl_in[0].gl_Position + vec4(cos(l_angle) * (l_radius - 0.1), sin(l_angle) * (l_radius - 0.1), 0.0, 0.0);\n\
             \x20   EmitVertex();\n\
             \n\
             \x20   v_frag_FragColor = vec4(1.0, 0.0, 0.0, 1.0) * v_geom_FragColor[0];\n\
             \x20   gl_Position = gl_in[0].gl_Position + vec4(cos(l_angle+0.1) * l_radius, sin(l_angle+0.1) * l_radius, 0.0, 0.0);\n\
             \x20   EmitVertex();\n\
             \n\
             \x20   v_frag_FragColor = vec4(1.0, 0.0, 0.0, 1.0) * v_geom_FragColor[0];\n\
             \x20   gl_Position = gl_in[0].gl_Position + vec4(cos(l_angle-0.1) * l_radius, sin(l_angle-0.1) * l_radius, 0.0, 0.0);\n\
             \x20   EmitVertex();\n",
        ),
        InvocationOutput::Different => buf.push_str(
            "    highp vec4 l_color = vec4(float(gl_InvocationID % 2), (((gl_InvocationID / 2) % 2) == 0) ? (1.0) : (0.0), 1.0, 1.0);\n\
             \x20   highp vec4 basePosition = gl_in[0].gl_Position + vec4(cos(l_angle) * l_radius, sin(l_angle) * l_radius, 0.0, 0.0);\n\
             \x20   mediump int numNgonVtx = gl_InvocationID + 3;\n\
             \n\
             \x20   for (int ndx = 0; ndx + 1 < numNgonVtx; ndx += 2)\n\
             \x20   {\n\
             \x20       highp float sub_angle = (float(ndx) + 1.0) / float(numNgonVtx) * 3.141;\n\
             \n\
             \x20       v_frag_FragColor = l_color;\n\
             \x20       gl_Position = basePosition + vec4(cos(sub_angle) * 0.1, sin(sub_angle) * 0.1, 0.0, 0.0);\n\
             \x20       EmitVertex();\n\
             \n\
             \x20       v_frag_FragColor = l_color;\n\
             \x20       gl_Position = basePosition + vec4(cos(sub_angle) * 0.1, sin(sub_angle) * -0.1, 0.0, 0.0);\n\
             \x20       EmitVertex();\n\
             \x20   }\n\
             \x20   if ((numNgonVtx % 2) == 1)\n\
             \x20   {\n\
             \x20       v_frag_FragColor = l_color;\n\
             \x20       gl_Position = basePosition + vec4(-0.1, 0.0, 0.0, 0.0);\n\
             \x20       EmitVertex();\n\
             \x20   }\n",
        ),
    }
    buf.push_str("}\n");
    buf
}

/// `InvocationCountShader::shadePrimitives`, every invocation of every input point in turn.
fn invocation_spec(num_invocations: i32, test_case: InvocationOutput) -> RenderSpec {
    // `GeometryInvocationCase::genVertexAttribData`
    let positions: Vec<V4> = vec![[0.0, -0.3, 0.0, 1.0], [0.2, 0.3, 0.0, 1.0]];
    let colors: Vec<V4> = vec![[1.0, 1.0, 1.0, 1.0], [0.8, 0.8, 0.8, 1.0]];

    let mut emitter = Emitter::default();
    for ndx in 0..positions.len() {
        for invocation_id in 0..num_invocations {
            let l_angle = invocation_id as f32 / num_invocations as f32 * 5.5;
            let l_radius = 0.6f32;

            match test_case {
                InvocationOutput::Fixed => {
                    let position0 = add(
                        positions[ndx],
                        [
                            l_angle.cos() * (l_radius - 0.1),
                            l_angle.sin() * (l_radius - 0.1),
                            0.0,
                            0.0,
                        ],
                    );
                    let position1 = add(
                        positions[ndx],
                        [
                            (l_angle + 0.1).cos() * l_radius,
                            (l_angle + 0.1).sin() * l_radius,
                            0.0,
                            0.0,
                        ],
                    );
                    let position2 = add(
                        positions[ndx],
                        [
                            (l_angle - 0.1).cos() * l_radius,
                            (l_angle - 0.1).sin() * l_radius,
                            0.0,
                            0.0,
                        ],
                    );
                    let tip_color: V4 = std::array::from_fn(|c| [1.0, 1.0, 0.0, 1.0][c] * colors[ndx][c]);
                    let base_color: V4 = std::array::from_fn(|c| [1.0, 0.0, 0.0, 1.0][c] * colors[ndx][c]);
                    emitter.emit_vertex(position0, tip_color);
                    emitter.emit_vertex(position1, base_color);
                    emitter.emit_vertex(position2, base_color);
                    emitter.end_primitive();
                }
                InvocationOutput::Different => {
                    let color: V4 = [
                        (invocation_id % 2) as f32,
                        if (invocation_id / 2) % 2 == 0 { 1.0 } else { 0.0 },
                        1.0,
                        1.0,
                    ];
                    let base_position = add(
                        positions[ndx],
                        [l_angle.cos() * l_radius, l_angle.sin() * l_radius, 0.0, 0.0],
                    );
                    let num_ngon_vtx = invocation_id + 3;

                    let mut i = 0;
                    while i + 1 < num_ngon_vtx {
                        let sub_angle = (i as f32 + 1.0) / num_ngon_vtx as f32 * 3.141;
                        emitter.emit_vertex(
                            add(base_position, [sub_angle.cos() * 0.1, sub_angle.sin() * 0.1, 0.0, 0.0]),
                            color,
                        );
                        emitter.emit_vertex(
                            add(base_position, [sub_angle.cos() * 0.1, sub_angle.sin() * -0.1, 0.0, 0.0]),
                            color,
                        );
                        i += 2;
                    }
                    if num_ngon_vtx % 2 == 1 {
                        emitter.emit_vertex(add(base_position, [-0.1, 0.0, 0.0, 0.0]), color);
                    }
                    emitter.end_primitive();
                }
            }
        }
    }

    RenderSpec {
        input_primitives: glw::GL_POINTS,
        output_type: OutputType::TriangleStrip,
        vertex_source: COMMON_VERTEX_SOURCE.to_string(),
        geometry_source: invocation_geometry_source(num_invocations, test_case),
        fragment_source: COMMON_FRAGMENT_SOURCE.to_string(),
        positions,
        colors,
        strips: emitter.finish(),
        data_attribute: "a_color".to_string(),
        restart_indices: None,
        use_point_size: false,
        instances: None,
        pre_render: PreRender::None,
    }
}

/// `GeometryInvocationCase::init`; `num_invocations == -1` is the "max" case.
fn geometry_invocation_case(case: &mut ApiCase<'_>, num_invocations: i32, test_case: InvocationOutput) {
    // requirements
    if !check_support(case.context()) {
        case.not_supported("Tests require GL_EXT_geometry_shader extension or higher context version.");
        return;
    }

    let max_geometry_shader_invocations = case.get_int(glw::GL_MAX_GEOMETRY_SHADER_INVOCATIONS);
    case.expect_no_error("getIntegerv(GL_MAX_GEOMETRY_SHADER_INVOCATIONS)");
    let max_components = case.get_int(glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS);
    case.expect_no_error("getIntegerv(GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS)");
    log::debug!("GL_MAX_GEOMETRY_SHADER_INVOCATIONS = {max_geometry_shader_invocations}");

    // set target num invocations
    let num_invocations = if num_invocations == -1 {
        max_geometry_shader_invocations
    } else if max_geometry_shader_invocations < num_invocations {
        case.not_supported("Test requires larger GL_MAX_GEOMETRY_SHADER_INVOCATIONS");
        return;
    } else {
        num_invocations
    };

    if test_case == InvocationOutput::Different {
        let max_emit_count = num_invocations + 2;
        let num_components = 8; // pos + color
        if max_emit_count * num_components > max_components {
            case.not_supported("Test requires larger GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS");
            return;
        }
    }

    render_case(case, &invocation_spec(num_invocations, test_case));
}

/// `InstancedExpansionShader` + `DrawInstancedGeometryInstancedCase::genVertexAttribData`.
fn draw_instanced_spec(num_instances: i32, num_invocations: i32) -> RenderSpec {
    let positions: Vec<V4> = vec![[0.0, 0.0, 0.0, 1.0]];
    let offsets: Vec<V4> = vec![
        [0.5, 0.0, 0.0, 0.0],
        [0.0, 0.5, 0.0, 0.0],
        [-0.7, -0.1, 0.0, 0.0],
        [-0.1, -0.7, 0.0, 0.0],
        [-0.8, -0.7, 0.0, 0.0],
        [-0.9, 0.6, 0.0, 0.0],
        [-0.8, 0.3, 0.0, 0.0],
        [-0.1, 0.1, 0.0, 0.0],
    ];

    let white: V4 = [1.0, 1.0, 1.0, 1.0];
    let mut emitter = Emitter::default();
    for instance in 0..num_instances as usize {
        let base_position = add(positions[0], offsets[instance]);
        for invocation_id in 0..num_invocations {
            let phase = invocation_id as f32 / num_invocations as f32 * 6.3;
            let center_position = add(base_position, scale([phase.cos(), phase.sin(), 0.0, 0.0], 0.1));
            emitter.emit_vertex(add(center_position, [0.0, -0.1, 0.0, 0.0]), white);
            emitter.emit_vertex(add(center_position, [-0.05, 0.0, 0.0, 0.0]), white);
            emitter.emit_vertex(add(center_position, [0.05, 0.0, 0.0, 0.0]), white);
            emitter.end_primitive();
        }
    }

    let vertex_source = "${GLSL_VERSION_DECL}\n\
         in highp vec4 a_position;\n\
         in highp vec4 a_offset;\n\
         void main (void)\n\
         {\n\
         \x20   gl_Position = a_position + a_offset;\n\
         }\n"
    .to_string();
    let fragment_source = "${GLSL_VERSION_DECL}\n\
         layout(location = 0) out mediump vec4 fragColor;\n\
         void main (void)\n\
         {\n\
         \x20   fragColor = vec4(1.0, 1.0, 1.0, 1.0);\n\
         }\n"
    .to_string();
    let geometry_source = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{GLSL_EXT_GEOMETRY_SHADER}}\
         layout(points,invocations={num_invocations}) in;\n\
         layout(triangle_strip, max_vertices = 3) out;\n\
         \n\
         void main (void)\n\
         {{\n\
         \x20   highp vec4 basePosition = gl_in[0].gl_Position;\n\
         \x20   highp float phase = float(gl_InvocationID) / float({num_invocations}) * 6.3;\n\
         \x20   highp vec4 centerPosition = basePosition + 0.1 * vec4(cos(phase), sin(phase), 0.0, 0.0);\n\
         \n\
         \x20   gl_Position = centerPosition + vec4( 0.00, -0.1, 0.0, 0.0);\n\
         \x20   EmitVertex();\n\
         \x20   gl_Position = centerPosition + vec4(-0.05,  0.0, 0.0, 0.0);\n\
         \x20   EmitVertex();\n\
         \x20   gl_Position = centerPosition + vec4( 0.05,  0.0, 0.0, 0.0);\n\
         \x20   EmitVertex();\n\
         }}\n"
    );

    RenderSpec {
        input_primitives: glw::GL_POINTS,
        output_type: OutputType::TriangleStrip,
        vertex_source,
        geometry_source,
        fragment_source,
        positions,
        colors: offsets,
        strips: emitter.finish(),
        data_attribute: "a_offset".to_string(),
        restart_indices: None,
        use_point_size: false,
        instances: Some(num_instances),
        pre_render: PreRender::None,
    }
}

/// The non-layered part of `GeometryShaderTests::init`'s `instanced` group that precedes the
/// layered cases (`geometry_*_invocations`, `geometry_output_different_*_invocations`).
pub fn add_invocation_cases(group: &mut TestCaseGroup) {
    const INVOCATION_CASES: [(&str, i32); 5] = [("1", 1), ("2", 2), ("8", 8), ("32", 32), ("max", -1)];

    // same amount of content to all invocations
    for (name, num_invocations) in INVOCATION_CASES {
        add_api_case(
            group,
            format!("geometry_{name}_invocations"),
            move |case: &mut ApiCase<'_>| geometry_invocation_case(case, num_invocations, InvocationOutput::Fixed),
        );
    }

    // different amount of content to each invocation
    for (name, num_invocations) in INVOCATION_CASES {
        if num_invocations != 1 {
            add_api_case(
                group,
                format!("geometry_output_different_{name}_invocations"),
                move |case: &mut ApiCase<'_>| {
                    geometry_invocation_case(case, num_invocations, InvocationOutput::Different)
                },
            );
        }
    }
}

/// The `draw_N_instances_geometry_M_invocations` cases, which come last in `instanced`.
pub fn add_draw_instanced_cases(group: &mut TestCaseGroup) {
    const NUM_DRAW_INSTANCES: [i32; 3] = [2, 4, 8];
    const NUM_DRAW_INVOCATIONS: [i32; 2] = [2, 8];

    for num_instances in NUM_DRAW_INSTANCES {
        for num_invocations in NUM_DRAW_INVOCATIONS {
            let name = format!("draw_{num_instances}_instances_geometry_{num_invocations}_invocations");
            add_render_case(group, name, draw_instanced_spec(num_instances, num_invocations));
        }
    }
}

// ---------------------------------------------------------------------------------------
// VaryingOutputCountCase
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum VaryingSource {
    Attribute,
    Uniform,
    Texture,
}

/// `VaryingOutputCountShader::EMIT_COUNT_VERTEX_0..3`
const EMIT_COUNT_VERTEX: [i32; 4] = [6, 0, -1, 10];

impl VaryingSource {
    /// `VaryingOutputCountShader::getAttributeName`
    fn attribute_name(self) -> &'static str {
        match self {
            VaryingSource::Attribute => "a_emitCount",
            VaryingSource::Uniform | VaryingSource::Texture => "a_vertexNdx",
        }
    }
}

/// `VaryingOutputCountShader::genVertexSource`
fn varying_output_vertex_source(test: VaryingSource) -> String {
    let mut buf = String::from("${GLSL_VERSION_DECL}\nin highp vec4 a_position;\n");
    match test {
        VaryingSource::Attribute => buf.push_str("in highp vec4 a_emitCount;\nout highp vec4 v_geom_emitCount;\n"),
        _ => buf.push_str("in highp vec4 a_vertexNdx;\nout highp vec4 v_geom_vertexNdx;\n"),
    }
    buf.push_str("void main (void)\n{\n    gl_Position = a_position;\n");
    match test {
        VaryingSource::Attribute => buf.push_str("    v_geom_emitCount = a_emitCount;\n"),
        _ => buf.push_str("    v_geom_vertexNdx = a_vertexNdx;\n"),
    }
    buf.push_str("}\n");
    buf
}

/// `VaryingOutputCountShader::genGeometrySource`
fn varying_output_geometry_source(test: VaryingSource, max_emit_count: i32, instanced: bool) -> String {
    let emit = |ndx: usize| {
        if EMIT_COUNT_VERTEX[ndx] == -1 {
            max_emit_count
        } else {
            EMIT_COUNT_VERTEX[ndx]
        }
    };

    let mut buf = String::from("${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout(points");
    if instanced {
        buf.push_str(",invocations=4");
    }
    buf.push_str(&format!(
        ") in;\nlayout(triangle_strip, max_vertices = {max_emit_count}) out;\n"
    ));
    match test {
        VaryingSource::Attribute => buf.push_str("in highp vec4 v_geom_emitCount[];\n"),
        VaryingSource::Uniform => buf.push_str("in highp vec4 v_geom_vertexNdx[];\nuniform highp ivec4 u_emitCount;\n"),
        VaryingSource::Texture => {
            buf.push_str("in highp vec4 v_geom_vertexNdx[];\nuniform highp sampler2D u_sampler;\n")
        }
    }
    buf.push_str("out highp vec4 v_frag_FragColor;\n\nvoid main (void)\n{\n");

    // emit count
    match test {
        VaryingSource::Attribute => {
            buf.push_str("    highp vec4 attrEmitCounts = v_geom_emitCount[0];\n");
            buf.push_str(&format!(
                "    mediump int emitCount = int(attrEmitCounts[{}]);\n",
                if instanced { "gl_InvocationID" } else { "0" }
            ));
        }
        VaryingSource::Uniform => {
            buf.push_str(&format!(
                "    mediump int primitiveNdx = {};\n",
                if instanced {
                    "gl_InvocationID"
                } else {
                    "int(v_geom_vertexNdx[0].x)"
                }
            ));
            buf.push_str("    mediump int emitCount = u_emitCount[primitiveNdx];\n");
        }
        VaryingSource::Texture => {
            buf.push_str(&format!(
                "    highp float primitiveNdx = {};\n",
                if instanced {
                    "float(gl_InvocationID)"
                } else {
                    "v_geom_vertexNdx[0].x"
                }
            ));
            buf.push_str("    highp vec2 texCoord = vec2(1.0 / 8.0 + primitiveNdx / 4.0, 0.5);\n");
            buf.push_str("    highp vec4 texColor = texture(u_sampler, texCoord);\n");
            buf.push_str("    mediump int emitCount = 0;\n");
            for (ndx, channel) in ["x", "y", "z", "w"].iter().enumerate() {
                buf.push_str(&format!(
                    "    if (texColor.{channel} > 0.0)\n        emitCount += {};\n",
                    emit(ndx)
                ));
            }
        }
    }

    // color
    match test {
        VaryingSource::Attribute => {
            // We don't want color to be compile time constant
            buf.push_str("    highp vec4 color = vec4((emitCount < 10) ? (0.0) : (1.0), (emitCount > 10) ? (0.0) : (1.0), 1.0, 1.0);\n");
        }
        _ => buf.push_str(
            "\n\
             \x20   const highp vec4 red = vec4(1.0, 0.0, 0.0, 1.0);\n\
             \x20   const highp vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \x20   const highp vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);\n\
             \x20   const highp vec4 yellow = vec4(1.0, 1.0, 0.0, 1.0);\n\
             \x20   const highp vec4 colors[4] = vec4[4](red, green, blue, yellow);\n\
             \x20   highp vec4 color = colors[int(primitiveNdx)];\n",
        ),
    }

    buf.push_str("\n    highp vec4 basePos = ");
    if instanced {
        buf.push_str(
            "gl_in[0].gl_Position + 0.5 * vec4(cos(float(gl_InvocationID)), sin(float(gl_InvocationID)), 0.0, 0.0)",
        );
    } else {
        buf.push_str("gl_in[0].gl_Position");
    }
    buf.push_str(
        ";\n\
         \x20   for (mediump int i = 0; i < emitCount / 2; i++)\n\
         \x20   {\n\
         \x20       highp float angle = (float(i) + 0.5) / float(emitCount / 2) * 3.142;\n\
         \x20       gl_Position = basePos + vec4(cos(angle),  sin(angle), 0.0, 0.0) * 0.15;\n\
         \x20       v_frag_FragColor = color;\n\
         \x20       EmitVertex();\n\
         \x20       gl_Position = basePos + vec4(cos(angle), -sin(angle), 0.0, 0.0) * 0.15;\n\
         \x20       v_frag_FragColor = color;\n\
         \x20       EmitVertex();\n\
         \x20   }}\n",
    );
    buf
}

/// `VaryingOutputCountShader::shadePrimitives` over `VaryingOutputCountCase::genVertexAttribData`.
fn varying_output_count_spec(test: VaryingSource, instanced: bool, max_emit_count: i32) -> RenderSpec {
    let red: V4 = [1.0, 0.0, 0.0, 1.0];
    let green: V4 = [0.0, 1.0, 0.0, 1.0];
    let blue: V4 = [0.0, 0.0, 1.0, 1.0];
    let yellow: V4 = [1.0, 1.0, 0.0, 1.0];
    let colors = [red, green, blue, yellow];

    let emit_counts: [i32; 4] = std::array::from_fn(|ndx| {
        if EMIT_COUNT_VERTEX[ndx] == -1 {
            max_emit_count
        } else {
            EMIT_COUNT_VERTEX[ndx]
        }
    });
    let uniform_emit_count: [i32; 4] = [6, 0, max_emit_count, 10];

    let (positions, attributes): (Vec<V4>, Vec<V4>) = if !instanced {
        let positions = vec![
            [0.5, 0.0, 0.0, 1.0],
            [0.0, 0.5, 0.0, 1.0],
            [-0.7, -0.1, 0.0, 1.0],
            [-0.1, -0.7, 0.0, 1.0],
        ];
        let attributes = if test == VaryingSource::Attribute {
            (0..4).map(|ndx| [emit_counts[ndx] as f32, 0.0, 0.0, 0.0]).collect()
        } else {
            (0..4).map(|ndx| [ndx as f32, 0.0, 0.0, 0.0]).collect()
        };
        (positions, attributes)
    } else {
        let attribute = if test == VaryingSource::Attribute {
            [
                emit_counts[0] as f32,
                emit_counts[1] as f32,
                emit_counts[2] as f32,
                emit_counts[3] as f32,
            ]
        } else {
            [0.0; 4]
        };
        (vec![[0.0, 0.0, 0.0, 1.0]], vec![attribute])
    };

    // One (vertex, invocation) pair after another.
    let invocations = if instanced { 4 } else { 1 };
    let mut emitter = Emitter::default();
    for vertex_ndx in 0..positions.len() {
        for invocation_id in 0..invocations {
            let attr = attributes[vertex_ndx];
            let (emit_count, color): (i32, V4) = match test {
                VaryingSource::Attribute => {
                    let emit_count = attr[if instanced { invocation_id as usize } else { 0 }] as i32;
                    (
                        emit_count,
                        [
                            if emit_count < 10 { 0.0 } else { 1.0 },
                            if emit_count > 10 { 0.0 } else { 1.0 },
                            1.0,
                            1.0,
                        ],
                    )
                }
                VaryingSource::Uniform => {
                    let primitive_ndx = if instanced {
                        invocation_id as usize
                    } else {
                        attr[0] as usize
                    };
                    (uniform_emit_count[primitive_ndx], colors[primitive_ndx])
                }
                VaryingSource::Texture => {
                    let primitive_ndx = if instanced {
                        invocation_id as usize
                    } else {
                        attr[0] as usize
                    };
                    // the texel at primitive_ndx has only channel primitive_ndx set
                    (emit_counts[primitive_ndx], colors[primitive_ndx])
                }
            };

            let base_position = if instanced {
                add(
                    positions[vertex_ndx],
                    scale(
                        [(invocation_id as f32).cos(), (invocation_id as f32).sin(), 0.0, 0.0],
                        0.5,
                    ),
                )
            } else {
                positions[vertex_ndx]
            };
            for ndx in 0..emit_count / 2 {
                let angle = (ndx as f32 + 0.5) / (emit_count / 2) as f32 * 3.142;
                emitter.emit_vertex(
                    add(base_position, scale([angle.cos(), angle.sin(), 0.0, 0.0], 0.15)),
                    color,
                );
                emitter.emit_vertex(
                    add(base_position, scale([angle.cos(), -angle.sin(), 0.0, 0.0], 0.15)),
                    color,
                );
            }
            emitter.end_primitive();
        }
    }

    RenderSpec {
        input_primitives: glw::GL_POINTS,
        output_type: OutputType::TriangleStrip,
        vertex_source: varying_output_vertex_source(test),
        geometry_source: varying_output_geometry_source(test, max_emit_count, instanced),
        fragment_source: COMMON_FRAGMENT_SOURCE.to_string(),
        positions,
        colors: attributes,
        strips: emitter.finish(),
        data_attribute: test.attribute_name().to_string(),
        restart_indices: None,
        use_point_size: false,
        instances: None,
        pre_render: match test {
            VaryingSource::Attribute => PreRender::None,
            VaryingSource::Uniform => PreRender::EmitCountUniform(uniform_emit_count),
            VaryingSource::Texture => PreRender::Texture,
        },
    }
}

/// `VaryingOutputCountCase::init`
fn varying_output_count_case(case: &mut ApiCase<'_>, test: VaryingSource, instanced: bool) {
    // Check requirements
    if !check_support(case.context()) {
        case.not_supported("Tests require GL_EXT_geometry_shader extension or higher context version.");
        return;
    }

    if test == VaryingSource::Texture {
        let max_textures = case.get_int(glw::GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS);
        log::debug!("GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = {max_textures}");
        if max_textures < 1 {
            case.not_supported("Geometry shader texture units required");
            return;
        }
    }

    // Get max emit count
    let components_per_vertex = 4 + 4; // vec4 pos, vec4 color
    let max_vertices = case.get_int(glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES);
    let max_components = case.get_int(glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS);
    if max_vertices < 256 {
        case.fail(
            "MAX_GEOMETRY_OUTPUT_VERTICES was less than minimum required (256)".to_string(),
            "MAX_GEOMETRY_OUTPUT_VERTICES was less than minimum required (256)",
        );
        return;
    }
    if max_components < 1024 {
        case.fail(
            "MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS was less than minimum required (1024)".to_string(),
            "MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS was less than minimum required (1024)",
        );
        return;
    }
    let max_emit_count = max_vertices.min(max_components / components_per_vertex);

    render_case(case, &varying_output_count_spec(test, instanced, max_emit_count));
}

/// `basic`'s three `output_vary_by_*` cases.
fn add_varying_output_count_basic(group: &mut TestCaseGroup) {
    add_api_case(group, "output_vary_by_attribute", |case: &mut ApiCase<'_>| {
        varying_output_count_case(case, VaryingSource::Attribute, false)
    });
    add_api_case(group, "output_vary_by_uniform", |case: &mut ApiCase<'_>| {
        varying_output_count_case(case, VaryingSource::Uniform, false)
    });
    add_api_case(group, "output_vary_by_texture", |case: &mut ApiCase<'_>| {
        varying_output_count_case(case, VaryingSource::Texture, false)
    });
}

/// `instanced`'s three `invocation_output_vary_by_*` cases.
pub fn add_invocation_varying_output_count_cases(group: &mut TestCaseGroup) {
    add_api_case(
        group,
        "invocation_output_vary_by_attribute",
        |case: &mut ApiCase<'_>| varying_output_count_case(case, VaryingSource::Attribute, true),
    );
    add_api_case(group, "invocation_output_vary_by_uniform", |case: &mut ApiCase<'_>| {
        varying_output_count_case(case, VaryingSource::Uniform, true)
    });
    add_api_case(group, "invocation_output_vary_by_texture", |case: &mut ApiCase<'_>| {
        varying_output_count_case(case, VaryingSource::Texture, true)
    });
}

fn basic_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("basic");
    let patterns: [(&str, &[i32]); 8] = [
        ("output_10", &[10]),
        ("output_128", &[128]),
        ("output_256", &[256]),
        ("output_max", &[-1]),
        ("output_10_and_100", &[10, 100]),
        ("output_100_and_10", &[100, 10]),
        ("output_0_and_128", &[0, 128]),
        ("output_128_and_0", &[128, 0]),
    ];
    for (name, pattern) in patterns {
        let pattern = pattern.to_vec();
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            output_count_case(case, &pattern)
        });
    }

    add_varying_output_count_basic(&mut group);
    add_api_case(&mut group, "point_size", |case: &mut ApiCase<'_>| {
        builtin_variable_case(case, VariableTest::PointSize, false)
    });
    add_api_case(&mut group, "primitive_id_in", |case: &mut ApiCase<'_>| {
        builtin_variable_case(case, VariableTest::PrimitiveIdIn, false)
    });
    add_api_case(&mut group, "primitive_id_in_restarted", |case: &mut ApiCase<'_>| {
        builtin_variable_case(case, VariableTest::PrimitiveIdIn, true)
    });
    add_api_case(&mut group, "primitive_id", |case: &mut ApiCase<'_>| {
        builtin_variable_case(case, VariableTest::PrimitiveId, false)
    });
    group
}

/// The groups of `GeometryShaderTests::init` that render through `GeometryShaderRenderTest`,
/// in upstream's order: `basic` (output count, varying output count and builtin variable cases), `input`, `conversion`, `emit`, `varying`.
pub fn create_render_groups() -> Vec<TestCaseGroup> {
    vec![
        basic_group(),
        input_group(),
        conversion_group(),
        emit_group(),
        varying_group(),
    ]
}
