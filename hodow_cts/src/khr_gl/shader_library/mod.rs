// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderLibraryCase.cpp / .hpp   (deqp::sl::ShaderCase)
//   external/openglcts/modules/common/glcShaderLibrary.cpp / .hpp       (deqp::ShaderLibrary, ShaderLibraryGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// This is the Khronos copy of the shader-library runner, NOT `gls::shader_library`: the ES one is the newer `glu::sl` implementation and the two share about a third of their lines. This
// one is the older `ShaderCase` with value blocks, `_vertex`/`_fragment` expansion of `both` sources, and `attribute`/`varying` interfaces below GLSL 3.30. The `.test` files are parsed
// ahead of time by `scripts/gen_khr_shader_library.py` into `src/generated/khr_shader_library/`, so the parser has no counterpart here.
//
// Shader sources are bytes: one upstream source contains a stray 0xA4 that is not UTF-8. Template substitution works on the bytes read as Latin-1 characters and turns them back
// afterwards, which round-trips every byte.

use crate::glu::shader_util::DataType;
use crate::glu::{
    self, Context, GlslVersion, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, TestNode,
};
use crate::glw::{self, GLint};
use crate::tcu::{Random, StringTemplate, Surface, TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

/// `ShaderCase::Value::StorageType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Storage {
    Uniform,
    Input,
    Output,
}

/// `ShaderCase::Value::Element` - the union upstream stores, one variant per half of it. A bool is an `Int`.
#[derive(Clone, Copy, Debug)]
pub enum Element {
    Float(f32),
    Int(i32),
}

impl Element {
    fn float32(self) -> f32 {
        match self {
            Self::Float(v) => v,
            Self::Int(v) => f32::from_bits(v as u32),
        }
    }

    fn int32(self) -> i32 {
        match self {
            Self::Int(v) => v,
            Self::Float(v) => v.to_bits() as i32,
        }
    }
}

/// `ShaderCase::Value`
#[derive(Clone, Copy, Debug)]
pub struct Value {
    pub storage: Storage,
    pub name: &'static str,
    pub data_type: DataType,
    /// Number of elements in the array (1 for a single value).
    pub array_length: i32,
    /// Scalar values, `data_type.scalar_size() * array_length` of them.
    pub elements: &'static [Element],
}

/// `ShaderCase::ValueBlock`
#[derive(Clone, Copy, Debug)]
pub struct ValueBlock {
    /// Combined array length of each value (lengths must be same, or one).
    pub array_length: i32,
    pub values: &'static [Value],
}

/// `ShaderCase::ExpectResult`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ExpectResult {
    Pass,
    CompileFail,
    LinkFail,
}

/// `ShaderCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum CaseType {
    Complete,
    VertexOnly,
    FragmentOnly,
}

/// What the generated code describes for one case; the arguments of upstream's `ShaderCase` constructor.
#[derive(Clone, Copy, Debug)]
pub struct CaseSpec {
    pub expect_result: ExpectResult,
    pub target_version: GlslVersion,
    pub value_blocks: &'static [ValueBlock],
    pub vertex_source: Option<&'static [u8]>,
    pub fragment_source: Option<&'static [u8]>,
}

pub struct Case {
    pub name: &'static str,
    pub spec: CaseSpec,
}

pub struct Group {
    pub name: &'static str,
    pub children: &'static [Node],
}

pub enum Node {
    Group(&'static Group),
    Case(&'static Case),
}

/// `ShaderLibraryGroup::init` - the file's top-level nodes become the group's children.
pub fn create_group(name: &str, root: &'static Group) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for child in root.children {
        group.add_child(create_node(child));
    }
    group
}

fn create_node(node: &'static Node) -> TestNode {
    match node {
        Node::Group(g) => TestNode::Group(create_group(g.name, g)),
        Node::Case(c) => TestNode::Case(Box::new(ShaderCase::new(c.name, c.spec))),
    }
}

const VIEWPORT_WIDTH: i32 = 128;
const VIEWPORT_HEIGHT: i32 = 128;

/// `usesShaderInoutQualifiers` - this copy's own, which is false for 1.00 ES and 1.30 to 1.50 and true for everything else, 3.00 ES included.
fn uses_shader_inout_qualifiers(version: GlslVersion) -> bool {
    !matches!(
        version,
        GlslVersion::Es100 | GlslVersion::Glsl130 | GlslVersion::Glsl140 | GlslVersion::Glsl150
    )
}

fn latin1_string(bytes: &[u8]) -> String {
    bytes.iter().map(|&b| b as char).collect()
}

fn latin1_bytes(text: &str) -> Vec<u8> {
    text.chars().map(|c| c as u8).collect()
}

/// `glu::getDataTypeFloatScalars`
fn float_scalars(data_type: DataType) -> DataType {
    match data_type.scalar_size() {
        1 => DataType::Float,
        2 => DataType::FloatVec2,
        3 => DataType::FloatVec3,
        4 => DataType::FloatVec4,
        _ => data_type,
    }
}

/// `deqp::sl::ShaderCase`
pub struct ShaderCase {
    name: &'static str,
    case_type: CaseType,
    expect_result: ExpectResult,
    value_blocks: &'static [ValueBlock],
    vertex_source: Vec<u8>,
    fragment_source: Vec<u8>,
}

const EMPTY_BLOCK: ValueBlock = ValueBlock {
    array_length: 0,
    values: &[],
};

impl ShaderCase {
    /// `ShaderCase::ShaderCase`
    pub fn new(name: &'static str, spec: CaseSpec) -> Self {
        // If no value blocks given, use an empty one.
        let value_blocks: &'static [ValueBlock] = if spec.value_blocks.is_empty() {
            &[EMPTY_BLOCK]
        } else {
            spec.value_blocks
        };
        // Use first value block to specialize shaders.
        let value_block = &value_blocks[0];
        let version = spec.target_version;

        let (case_type, vertex_source, fragment_source) = match (spec.vertex_source, spec.fragment_source) {
            (Some(vertex), Some(fragment)) => {
                let (vertex, fragment) = specialize_shaders(version, vertex, fragment, value_block);
                (CaseType::Complete, vertex, fragment)
            }
            (Some(vertex), None) => (
                CaseType::VertexOnly,
                specialize_vertex_shader(version, vertex, value_block),
                gen_fragment_shader(version, value_block),
            ),
            (None, Some(fragment)) => (
                CaseType::FragmentOnly,
                gen_vertex_shader(version, value_block),
                specialize_fragment_shader(version, fragment, value_block),
            ),
            (None, None) => unreachable!("a shader-library case has at least one source"),
        };

        Self {
            name,
            case_type,
            expect_result: spec.expect_result,
            value_blocks,
            vertex_source,
            fragment_source,
        }
    }
}

/// `StringTemplate(src).specialize(params)` over a source held as bytes.
fn specialize(src: &[u8], params: &[(&str, String)]) -> Vec<u8> {
    let specialized = StringTemplate::new(latin1_string(src))
        .specialize(params)
        .unwrap_or_else(|e| panic!("shader template: {e}"));
    latin1_bytes(&specialized)
}

/// `setUniformValue`
fn set_uniform_value(
    context: &Context,
    program: glw::GLuint,
    name: &str,
    val: &Value,
    array_ndx: usize,
) -> Result<(), TestError> {
    use DataType::*;

    let gl = context.gl();
    let scalar_size = val.data_type.scalar_size() as usize;
    let c_name = std::ffi::CString::new(name).expect("a uniform name has no interior NUL");
    // SAFETY: a NUL-terminated name and a program this case built.
    let loc = unsafe { gl.get_uniform_location(program, c_name.as_ptr()) };
    if loc == -1 {
        return Err(TestError::Fail("uniform location not found".to_string()));
    }

    let elem_ndx = if val.array_length == 1 {
        0
    } else {
        array_ndx * scalar_size
    };
    let floats: Vec<f32> = (0..scalar_size).map(|n| val.elements[elem_ndx + n].float32()).collect();
    let ints: Vec<GLint> = (0..scalar_size).map(|n| val.elements[elem_ndx + n].int32()).collect();

    // SAFETY: each call is given exactly `scalar_size` scalars, which is what the uniform's own type holds.
    unsafe {
        let f = floats.as_ptr();
        let i = ints.as_ptr();
        match val.data_type {
            Float => gl.uniform_1fv(loc, 1, f),
            FloatVec2 => gl.uniform_2fv(loc, 1, f),
            FloatVec3 => gl.uniform_3fv(loc, 1, f),
            FloatVec4 => gl.uniform_4fv(loc, 1, f),
            FloatMat2 => gl.uniform_matrix_2fv(loc, 1, glw::FALSE, f),
            FloatMat3 => gl.uniform_matrix_3fv(loc, 1, glw::FALSE, f),
            FloatMat4 => gl.uniform_matrix_4fv(loc, 1, glw::FALSE, f),
            Int | Bool => gl.uniform_1iv(loc, 1, i),
            IntVec2 | BoolVec2 => gl.uniform_2iv(loc, 1, i),
            IntVec3 | BoolVec3 => gl.uniform_3iv(loc, 1, i),
            IntVec4 | BoolVec4 => gl.uniform_4iv(loc, 1, i),
            Uint => gl.uniform_1uiv(loc, 1, i.cast()),
            UintVec2 => gl.uniform_2uiv(loc, 1, i.cast()),
            UintVec3 => gl.uniform_3uiv(loc, 1, i.cast()),
            UintVec4 => gl.uniform_4uiv(loc, 1, i.cast()),
            FloatMat2x3 => gl.uniform_matrix_2x_3fv(loc, 1, glw::FALSE, f),
            FloatMat2x4 => gl.uniform_matrix_2x_4fv(loc, 1, glw::FALSE, f),
            FloatMat3x2 => gl.uniform_matrix_3x_2fv(loc, 1, glw::FALSE, f),
            FloatMat3x4 => gl.uniform_matrix_3x_4fv(loc, 1, glw::FALSE, f),
            FloatMat4x2 => gl.uniform_matrix_4x_2fv(loc, 1, glw::FALSE, f),
            FloatMat4x3 => gl.uniform_matrix_4x_3fv(loc, 1, glw::FALSE, f),
            other => unreachable!("no uniform setter for {other:?}"),
        }
    }
    Ok(())
}

/// `ShaderCase::checkPixels`
fn check_pixels(surface: &Surface, min_x: i32, max_x: i32, min_y: i32, max_y: i32) -> bool {
    debug_assert!(max_x > min_x && max_y > min_y);

    let mut all_white = true;
    let mut all_black = true;
    let mut any_unexpected = false;

    for y in min_y..=max_y {
        for x in min_x..=max_x {
            let pixel = surface.get_pixel(x, y);
            // Note: we really do not want to involve alpha in the check comparison.
            let is_white = pixel.get_red() == 255 && pixel.get_green() == 255 && pixel.get_blue() == 255;
            let is_black = pixel.get_red() == 0 && pixel.get_green() == 0 && pixel.get_blue() == 0;

            all_white = all_white && is_white;
            all_black = all_black && is_black;
            any_unexpected = any_unexpected || (!is_white && !is_black);
        }
    }

    if !all_white {
        if any_unexpected {
            log::info!("WARNING: expecting all rendered pixels to be white or black, but got other colors as well!");
        } else if !all_black {
            log::info!("WARNING: got inconsistent results over the image, when all pixels should be the same color!");
        }
        return false;
    }
    true
}

impl TestCase for ShaderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        self.execute(context)
    }
}

impl ShaderCase {
    /// `ShaderCase::execute` and `iterate`
    fn execute(&self, context: &Context) -> TestOutcome {
        const NUM_VERTICES_PER_DRAW: i32 = 4;
        const QUAD_SIZE: f32 = 1.0;
        #[rustfmt::skip]
        const POSITIONS: [f32; 16] = [
            -QUAD_SIZE, -QUAD_SIZE, 0.0, 1.0,
            -QUAD_SIZE,  QUAD_SIZE, 0.0, 1.0,
             QUAD_SIZE, -QUAD_SIZE, 0.0, 1.0,
             QUAD_SIZE,  QUAD_SIZE, 0.0, 1.0,
        ];
        const INDICES: [u16; 6] = [0, 1, 2, 1, 3, 2];

        let gl = context.gl();

        // Compute viewport.
        let render_target = context.render_target();
        let mut rnd = Random::new(de_string_hash(self.name));
        let width = render_target.width.min(VIEWPORT_WIDTH);
        let height = render_target.height.min(VIEWPORT_HEIGHT);
        let viewport_x = rnd.get_int(0, render_target.width - width);
        let viewport_y = rnd.get_int(0, render_target.height - height);

        glu::expect_no_error(gl, "ShaderCase::execute(): start")?;

        // Setup viewport.
        // SAFETY: a viewport inside the render target.
        unsafe { gl.viewport(viewport_x, viewport_y, width, height) };

        // Setup program.
        let sources = ProgramSources::default()
            .with_bytes(ShaderType::Vertex, self.vertex_source.clone())
            .with_bytes(ShaderType::Fragment, self.fragment_source.clone());
        let program = ShaderProgram::new_reporting_build_failure(gl, &sources);

        // Check that compile/link results are what we expect.
        let shader_ok = |shader_type: ShaderType| {
            program
                .shader_info
                .iter()
                .find(|(ty, _)| *ty == shader_type)
                .is_some_and(|(_, info)| info.ok)
        };
        let vertex_ok = shader_ok(ShaderType::Vertex);
        let fragment_ok = shader_ok(ShaderType::Fragment);
        let link_ok = program.program_info.ok;

        let fail_reason: Option<&str> = match self.expect_result {
            ExpectResult::Pass => {
                if !vertex_ok || !fragment_ok {
                    Some("expected shaders to compile and link properly, but failed to compile.")
                } else if !link_ok {
                    Some("expected shaders to compile and link properly, but failed to link.")
                } else {
                    None
                }
            }
            ExpectResult::CompileFail => {
                if vertex_ok && fragment_ok && !link_ok {
                    Some("expected compilation to fail, but both shaders compiled and link failed.")
                } else if vertex_ok && fragment_ok {
                    Some("expected compilation to fail, but both shaders compiled correctly.")
                } else {
                    None
                }
            }
            ExpectResult::LinkFail => {
                if !vertex_ok || !fragment_ok {
                    Some("expected linking to fail, but unable to compile.")
                } else if link_ok {
                    Some("expected linking to fail, but passed.")
                } else {
                    None
                }
            }
        };

        if let Some(reason) = fail_reason {
            log::info!("ERROR: {reason}");

            // If implementation parses shader at link time, report it as quality warning.
            if self.expect_result == ExpectResult::CompileFail && vertex_ok && fragment_ok && !link_ok {
                return Ok(TestStatus::new(TestResult::QualityWarning, reason));
            }
            return Ok(TestStatus::fail(reason));
        }

        // Return if compile/link expected to fail.
        if self.expect_result != ExpectResult::Pass {
            return Ok(TestStatus::pass("Pass"));
        }

        // Start using program.
        let program_id = program.program();
        // SAFETY: a program this case built.
        unsafe { gl.use_program(program_id) };
        glu::expect_no_error(gl, "glUseProgram()")?;

        // Fetch location for positions positions.
        let position_name = std::ffi::CString::new("dEQP_Position").expect("no interior NUL");
        // SAFETY: a NUL-terminated name and a program this case built.
        let position_loc = unsafe { gl.get_attrib_location(program_id, position_name.as_ptr()) };
        if position_loc == -1 {
            return Err(TestError::Fail(
                "no location found for attribute 'dEQP_Position'".to_string(),
            ));
        }

        // Iterate all value blocks.
        for (block_ndx, value_block) in self.value_blocks.iter().enumerate() {
            // Iterate all array sub-cases.
            for array_ndx in 0..value_block.array_length as usize {
                let mut attrib_values: Vec<Vec<f32>> = Vec::new();
                // The attribute arrays borrow from `attrib_values`, so collect the data first and bind afterwards.
                let mut bindings: Vec<(i32, i32, usize)> = Vec::new(); // (location, components, index into attrib_values) for plain attributes
                let mut matrix_bindings: Vec<(i32, i32, i32, usize)> = Vec::new(); // (location, columns, rows, index)

                // Collect VA pointer for inputs and set uniform values for outputs (refs).
                for val in value_block.values {
                    let data_type = val.data_type;
                    let scalar_size = data_type.scalar_size() as usize;

                    glu::expect_no_error(gl, "before set uniforms")?;

                    match val.storage {
                        Storage::Input => {
                            // Replicate values four times.
                            let mut scalars = vec![0.0f32; NUM_VERTICES_PER_DRAW as usize * scalar_size];
                            for rep_ndx in 0..NUM_VERTICES_PER_DRAW as usize {
                                for ndx in 0..scalar_size {
                                    let element = val.elements[array_ndx * scalar_size + ndx];
                                    scalars[rep_ndx * scalar_size + ndx] =
                                        if data_type.is_float_or_vec() || data_type.is_matrix() {
                                            element.float32()
                                        } else {
                                            element.int32() as f32
                                        };
                                }
                            }

                            // Attribute name prefix.
                            // \\todo [2010-05-27 petri] Should latter condition only apply for vertex cases (or actually non-fragment cases)?
                            let attrib_prefix = if self.case_type == CaseType::FragmentOnly
                                || data_type.scalar_type() != DataType::Float
                            {
                                "a_"
                            } else {
                                ""
                            };

                            // Input always given as attribute.
                            let attrib_name = format!("{attrib_prefix}{}", val.name);
                            let c_attrib_name = std::ffi::CString::new(attrib_name.as_str()).expect("no interior NUL");
                            // SAFETY: a NUL-terminated name and a program this case built.
                            let attrib_loc = unsafe { gl.get_attrib_location(program_id, c_attrib_name.as_ptr()) };
                            if attrib_loc == -1 {
                                log::info!("Warning: no location found for attribute '{attrib_name}'");
                                // Upstream `continue`s after having taken the attribute slot, which only matters to its own indexing.
                                continue;
                            }

                            attrib_values.push(scalars);
                            let index = attrib_values.len() - 1;
                            if data_type.is_matrix() {
                                matrix_bindings.push((
                                    attrib_loc,
                                    data_type.matrix_num_columns(),
                                    data_type.matrix_num_rows(),
                                    index,
                                ));
                            } else {
                                bindings.push((attrib_loc, scalar_size as i32, index));
                            }

                            glu::expect_no_error(gl, "set vertex attrib array")?;
                        }
                        Storage::Output => {
                            // Set reference value.
                            set_uniform_value(context, program_id, &format!("ref_{}", val.name), val, array_ndx)?;
                            glu::expect_no_error(gl, "set reference uniforms")?;
                        }
                        Storage::Uniform => {
                            set_uniform_value(context, program_id, val.name, val, array_ndx)?;
                            glu::expect_no_error(gl, "set uniforms")?;
                        }
                    }
                }

                let mut vertex_arrays = vec![glu::va::float_at(
                    position_loc as u32,
                    4,
                    NUM_VERTICES_PER_DRAW,
                    0,
                    &POSITIONS,
                )];
                for &(location, components, index) in &bindings {
                    vertex_arrays.push(glu::va::float_at(
                        location as u32,
                        components,
                        NUM_VERTICES_PER_DRAW,
                        0,
                        &attrib_values[index],
                    ));
                }
                for &(location, columns, rows, index) in &matrix_bindings {
                    let scalar_size = columns * rows;
                    for i in 0..columns {
                        vertex_arrays.push(glu::va::float_at(
                            (location + i) as u32,
                            rows,
                            NUM_VERTICES_PER_DRAW,
                            scalar_size * size_of::<f32>() as i32,
                            &attrib_values[index][(i * rows) as usize..],
                        ));
                    }
                }

                // Clear.
                // SAFETY: plain state setting.
                unsafe {
                    gl.clear_color(0.0, 0.0, 0.0, 1.0);
                    gl.clear(glw::GL_COLOR_BUFFER_BIT);
                }
                glu::expect_no_error(gl, "clear buffer")?;

                // Draw.
                glu::draw(
                    &context.render_context,
                    program.program(),
                    &vertex_arrays,
                    &glu::pr::triangles(&INDICES),
                )?;
                glu::expect_no_error(gl, "draw")?;

                // Read back results.
                let mut surface = Surface::new(width, height);
                glu::read_pixels(
                    &context.render_context,
                    viewport_x,
                    viewport_y,
                    &mut surface.get_access(),
                )?;
                glu::expect_no_error(gl, "read pixels")?;

                let w = POSITIONS[3];
                let min_y = (((-QUAD_SIZE / w) * 0.5 + 0.5) * height as f32 + 1.0).ceil() as i32;
                let max_y = (((QUAD_SIZE / w) * 0.5 + 0.5) * height as f32 - 0.5).floor() as i32;
                let min_x = (((-QUAD_SIZE / w) * 0.5 + 0.5) * width as f32 + 1.0).ceil() as i32;
                let max_x = (((QUAD_SIZE / w) * 0.5 + 0.5) * width as f32 - 0.5).floor() as i32;

                if !check_pixels(&surface, min_x, max_x, min_y, max_y) {
                    log::info!(
                        "INCORRECT RESULT for (value block {} of {}, sub-case {} of {}):",
                        block_ndx + 1,
                        self.value_blocks.len(),
                        array_ndx + 1,
                        value_block.array_length
                    );
                    log::info!("Failing shader input/output values:");
                    dump_values(value_block, array_ndx);

                    // SAFETY: plain state setting.
                    unsafe { gl.use_program(0) };
                    return Ok(TestStatus::fail("Image comparison failed"));
                }
            }
        }

        // SAFETY: plain state setting.
        unsafe { gl.use_program(0) };
        glu::expect_no_error(gl, "ShaderCase::execute(): end")?;
        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderCase::genVertexShader` - a matching vertex shader for a `both` case, when the fragment shader is being tested: an attribute and a varying for each input.
fn gen_vertex_shader(version: GlslVersion, value_block: &ValueBlock) -> Vec<u8> {
    let uses_inout = uses_shader_inout_qualifiers(version);
    let vtx_in = if uses_inout { "in" } else { "attribute" };
    let vtx_out = if uses_inout { "out" } else { "varying" };

    let mut res = String::new();
    res.push_str(version.declaration());
    res.push('\n');

    // Declarations (position + attribute/varying for each input).
    res.push_str("precision highp float;\n");
    res.push_str("precision highp int;\n");
    res.push('\n');
    res.push_str(&format!("{vtx_in} highp vec4 dEQP_Position;\n"));
    for val in value_block.values.iter().filter(|v| v.storage == Storage::Input) {
        let type_str = float_scalars(val.data_type).name();
        res.push_str(&format!("{vtx_in} {type_str} a_{};\n", val.name));
        if val.data_type.scalar_type() == DataType::Float {
            res.push_str(&format!("{vtx_out} {type_str} {};\n", val.name));
        } else {
            res.push_str(&format!("{vtx_out} {type_str} v_{};\n", val.name));
        }
    }
    res.push('\n');

    // Main function: gl_Position = dEQP_Position; for each input write the attribute directly to the varying.
    res.push_str("void main()\n");
    res.push_str("{\n");
    res.push_str("    gl_Position = dEQP_Position;\n");
    for val in value_block.values.iter().filter(|v| v.storage == Storage::Input) {
        let name = val.name;
        if val.data_type.scalar_type() == DataType::Float {
            res.push_str(&format!("    {name} = a_{name};\n"));
        } else {
            res.push_str(&format!("    v_{name} = a_{name};\n"));
        }
    }
    res.push_str("}\n");
    res.into_bytes()
}

/// `genCompareFunctions`
fn gen_compare_functions(stream: &mut String, value_block: &ValueBlock, use_float_types: bool) {
    use DataType::*;

    let found = |ty: DataType| {
        value_block
            .values
            .iter()
            .any(|v| v.storage == Storage::Output && v.data_type == ty)
    };

    if use_float_types {
        for (ty, line) in [
            (Bool, "bool isOk (float a, bool b) { return ((a > 0.5) == b); }\n"),
            (
                BoolVec2,
                "bool isOk (vec2 a, bvec2 b) { return (greaterThan(a, vec2(0.5)) == b); }\n",
            ),
            (
                BoolVec3,
                "bool isOk (vec3 a, bvec3 b) { return (greaterThan(a, vec3(0.5)) == b); }\n",
            ),
            (
                BoolVec4,
                "bool isOk (vec4 a, bvec4 b) { return (greaterThan(a, vec4(0.5)) == b); }\n",
            ),
            (
                Int,
                "bool isOk (float a, int b)  { float atemp = a+0.5; return (float(b) <= atemp && atemp <= float(b+1)); }\n",
            ),
            (
                IntVec2,
                "bool isOk (vec2 a, ivec2 b) { return (ivec2(floor(a + 0.5)) == b); }\n",
            ),
            (
                IntVec3,
                "bool isOk (vec3 a, ivec3 b) { return (ivec3(floor(a + 0.5)) == b); }\n",
            ),
            (
                IntVec4,
                "bool isOk (vec4 a, ivec4 b) { return (ivec4(floor(a + 0.5)) == b); }\n",
            ),
            (
                Uint,
                "bool isOk (float a, uint b) { float atemp = a+0.5; return (float(b) <= atemp && atemp <= float(b+1)); }\n",
            ),
            (
                UintVec2,
                "bool isOk (vec2 a, uvec2 b) { return (uvec2(floor(a + 0.5)) == b); }\n",
            ),
            (
                UintVec3,
                "bool isOk (vec3 a, uvec3 b) { return (uvec3(floor(a + 0.5)) == b); }\n",
            ),
            (
                UintVec4,
                "bool isOk (vec4 a, uvec4 b) { return (uvec4(floor(a + 0.5)) == b); }\n",
            ),
        ] {
            if found(ty) {
                stream.push_str(line);
            }
        }
    } else {
        for (ty, line) in [
            (Bool, "bool isOk (bool a, bool b)   { return (a == b); }\n"),
            (BoolVec2, "bool isOk (bvec2 a, bvec2 b) { return (a == b); }\n"),
            (BoolVec3, "bool isOk (bvec3 a, bvec3 b) { return (a == b); }\n"),
            (BoolVec4, "bool isOk (bvec4 a, bvec4 b) { return (a == b); }\n"),
            (Int, "bool isOk (int a, int b)     { return (a == b); }\n"),
            (IntVec2, "bool isOk (ivec2 a, ivec2 b) { return (a == b); }\n"),
            (IntVec3, "bool isOk (ivec3 a, ivec3 b) { return (a == b); }\n"),
            (IntVec4, "bool isOk (ivec4 a, ivec4 b) { return (a == b); }\n"),
            (Uint, "bool isOk (uint a, uint b)   { return (a == b); }\n"),
            (UintVec2, "bool isOk (uvec2 a, uvec2 b) { return (a == b); }\n"),
            (UintVec3, "bool isOk (uvec3 a, uvec3 b) { return (a == b); }\n"),
            (UintVec4, "bool isOk (uvec4 a, uvec4 b) { return (a == b); }\n"),
        ] {
            if found(ty) {
                stream.push_str(line);
            }
        }
    }

    for (ty, line) in [
        (
            Float,
            "bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }\n",
        ),
        (
            FloatVec2,
            "bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n",
        ),
        (
            FloatVec3,
            "bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n",
        ),
        (
            FloatVec4,
            "bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }\n",
        ),
        (
            FloatMat2,
            "bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }\n",
        ),
        (
            FloatMat2x3,
            "bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }\n",
        ),
        (
            FloatMat2x4,
            "bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }\n",
        ),
        (
            FloatMat3x2,
            "bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }\n",
        ),
        (
            FloatMat3,
            "bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }\n",
        ),
        (
            FloatMat3x4,
            "bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }\n",
        ),
        (
            FloatMat4x2,
            "bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }\n",
        ),
        (
            FloatMat4x3,
            "bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }\n",
        ),
        (
            FloatMat4,
            "bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }\n",
        ),
    ] {
        if found(ty) {
            stream.push_str(line);
        }
    }
}

/// `genCompareOp`
fn gen_compare_op(output: &mut String, dst_vec4_var: &str, value_block: &ValueBlock, non_float_name_prefix: &str) {
    let mut is_first_output = true;

    for val in value_block.values.iter().filter(|v| v.storage == Storage::Output) {
        let value_name = val.name;

        // Prefix.
        if is_first_output {
            output.push_str("bool RES = ");
            is_first_output = false;
        } else {
            output.push_str("RES = RES && ");
        }

        // Generate actual comparison.
        if val.data_type.scalar_type() == DataType::Float {
            output.push_str(&format!("isOk({value_name}, ref_{value_name}, 0.05);\n"));
        } else {
            output.push_str(&format!(
                "isOk({non_float_name_prefix}{value_name}, ref_{value_name});\n"
            ));
        }
        // \\note Uniforms are already declared in shader.
    }

    if is_first_output {
        output.push_str(&format!("{dst_vec4_var} = vec4(1.0);\n")); // \\todo [petri] Should we give warning if not expect-failure case?
    } else {
        output.push_str(&format!("{dst_vec4_var} = vec4(RES, RES, RES, 1.0);\n"));
    }
}

/// `ShaderCase::genFragmentShader`
fn gen_fragment_shader(version: GlslVersion, value_block: &ValueBlock) -> Vec<u8> {
    let uses_inout = uses_shader_inout_qualifiers(version);
    let custom_color_out = uses_inout;
    let frag_in = if uses_inout { "in" } else { "varying" };

    let mut shader = String::new();
    shader.push_str(version.declaration());
    shader.push('\n');

    shader.push_str("precision mediump float;\n");
    shader.push_str("precision mediump int;\n");
    shader.push('\n');

    if custom_color_out {
        shader.push_str("layout(location = 0) out mediump vec4 dEQP_FragColor;\n");
        shader.push('\n');
    }

    gen_compare_functions(&mut shader, value_block, true);
    shader.push('\n');

    // Declarations (varying, reference for each output).
    for val in value_block.values {
        let float_type_str = float_scalars(val.data_type).name();
        let ref_type_str = val.data_type.name();

        if val.storage == Storage::Output {
            if val.data_type.scalar_type() == DataType::Float {
                shader.push_str(&format!("{frag_in} {float_type_str} {};\n", val.name));
            } else {
                shader.push_str(&format!("{frag_in} {float_type_str} v_{};\n", val.name));
            }
            shader.push_str(&format!("uniform {ref_type_str} ref_{};\n", val.name));
        }
    }

    shader.push('\n');
    shader.push_str("void main()\n");
    shader.push_str("{\n");

    shader.push(' ');
    gen_compare_op(
        &mut shader,
        if custom_color_out {
            "dEQP_FragColor"
        } else {
            "gl_FragColor"
        },
        value_block,
        "v_",
    );

    shader.push_str("}\n");
    shader.into_bytes()
}

/// `ShaderCase::specializeVertexShader` - for the vertex shader test case.
fn specialize_vertex_shader(version: GlslVersion, src: &[u8], value_block: &ValueBlock) -> Vec<u8> {
    let mut decl = String::new();
    let mut setup = String::new();
    let mut output = String::new();
    let uses_inout = uses_shader_inout_qualifiers(version);
    let vtx_in = if uses_inout { "in" } else { "attribute" };
    let vtx_out = if uses_inout { "out" } else { "varying" };

    // Output (write out position).
    output.push_str("gl_Position = dEQP_Position;\n");

    // Declarations (position + attribute for each input, varying for each output).
    decl.push_str(&format!("{vtx_in} highp vec4 dEQP_Position;\n"));
    for val in value_block.values {
        let value_name = val.name;
        let float_type_str = float_scalars(val.data_type).name();
        let ref_type_str = val.data_type.name();

        match val.storage {
            Storage::Input => {
                if val.data_type.scalar_type() == DataType::Float {
                    decl.push_str(&format!("{vtx_in} {float_type_str} {value_name};\n"));
                } else {
                    decl.push_str(&format!("{vtx_in} {float_type_str} a_{value_name};\n"));
                    setup.push_str(&format!(
                        "{ref_type_str} {value_name} = {ref_type_str}(a_{value_name});\n"
                    ));
                }
            }
            Storage::Output => {
                if val.data_type.scalar_type() == DataType::Float {
                    decl.push_str(&format!("{vtx_out} {float_type_str} {value_name};\n"));
                } else {
                    decl.push_str(&format!("{vtx_out} {float_type_str} v_{value_name};\n"));
                    decl.push_str(&format!("{ref_type_str} {value_name};\n"));

                    output.push_str(&format!("v_{value_name} = {float_type_str}({value_name});\n"));
                }
            }
            Storage::Uniform => {}
        }
    }

    // Shader specialization.
    specialize(
        src,
        &[
            ("DECLARATIONS", decl),
            ("SETUP", setup),
            ("OUTPUT", output),
            ("POSITION_FRAG_COLOR", "gl_Position".to_string()),
        ],
    )
}

/// `ShaderCase::specializeFragmentShader` - for the fragment shader test case.
fn specialize_fragment_shader(version: GlslVersion, src: &[u8], value_block: &ValueBlock) -> Vec<u8> {
    let mut decl = String::new();
    let mut setup = String::new();
    let mut output = String::new();

    let uses_inout = uses_shader_inout_qualifiers(version);
    let custom_color_out = uses_inout;
    let frag_in = if uses_inout { "in" } else { "varying" };
    let frag_color = if custom_color_out {
        "dEQP_FragColor"
    } else {
        "gl_FragColor"
    };

    gen_compare_functions(&mut decl, value_block, false);
    gen_compare_op(&mut output, frag_color, value_block, "");

    if custom_color_out {
        decl.push_str("layout(location = 0) out mediump vec4 dEQP_FragColor;\n");
    }

    for val in value_block.values {
        let value_name = val.name;
        let float_type_str = float_scalars(val.data_type).name();
        let ref_type_str = val.data_type.name();

        match val.storage {
            Storage::Input => {
                if val.data_type.scalar_type() == DataType::Float {
                    decl.push_str(&format!("{frag_in} {float_type_str} {value_name};\n"));
                } else {
                    decl.push_str(&format!("{frag_in} {float_type_str} v_{value_name};\n"));
                    // \\todo [petri] bit of a hack to avoid errors in chop() due to varying interpolation
                    let offset = if val.data_type.is_int_or_ivec() {
                        " * 1.0025"
                    } else {
                        ""
                    };
                    setup.push_str(&format!(
                        "{ref_type_str} {value_name} = {ref_type_str}(v_{value_name}{offset});\n"
                    ));
                }
            }
            Storage::Output => {
                decl.push_str(&format!("uniform {ref_type_str} ref_{value_name};\n"));
                decl.push_str(&format!("{ref_type_str} {value_name};\n"));
            }
            Storage::Uniform => {}
        }
    }

    // \\todo [2010-04-01 petri] Check all outputs.

    // Shader specialization.
    specialize(
        src,
        &[
            ("DECLARATIONS", decl),
            ("SETUP", setup),
            ("OUTPUT", output),
            ("POSITION_FRAG_COLOR", frag_color.to_string()),
        ],
    )
}

/// `ShaderCase::specializeShaders`
fn specialize_shaders(
    version: GlslVersion,
    vertex_source: &[u8],
    fragment_source: &[u8],
    value_block: &ValueBlock,
) -> (Vec<u8>, Vec<u8>) {
    let uses_inout = uses_shader_inout_qualifiers(version);
    let custom_color_out = uses_inout;

    // Vertex shader specialization.
    let out_vertex = {
        let mut decl = String::new();
        let mut setup = String::new();
        let vtx_in = if uses_inout { "in" } else { "attribute" };

        decl.push_str(&format!("{vtx_in} highp vec4 dEQP_Position;\n"));

        for val in value_block.values {
            let type_str = val.data_type.name();

            if val.storage == Storage::Input {
                if val.data_type.scalar_type() == DataType::Float {
                    decl.push_str(&format!("{vtx_in} {type_str} {};\n", val.name));
                } else {
                    let float_type_str = float_scalars(val.data_type).name();
                    decl.push_str(&format!("{vtx_in} {float_type_str} a_{};\n", val.name));
                    setup.push_str(&format!("{type_str} {} = {type_str}(a_{});\n", val.name, val.name));
                }
            } else if val.storage == Storage::Uniform && !val.name.contains('.') {
                decl.push_str(&format!("uniform {type_str} {};\n", val.name));
            }
        }

        specialize(
            vertex_source,
            &[
                ("VERTEX_DECLARATIONS", decl),
                ("VERTEX_SETUP", setup),
                ("VERTEX_OUTPUT", "gl_Position = dEQP_Position;\n".to_string()),
            ],
        )
    };

    // Fragment shader specialization.
    let out_fragment = {
        let mut decl = String::new();
        let mut output = String::new();
        let frag_color = if custom_color_out {
            "dEQP_FragColor"
        } else {
            "gl_FragColor"
        };

        gen_compare_functions(&mut decl, value_block, false);
        gen_compare_op(&mut output, frag_color, value_block, "");

        if custom_color_out {
            decl.push_str("layout(location = 0) out mediump vec4 dEQP_FragColor;\n");
        }

        for val in value_block.values {
            let value_name = val.name;
            let ref_type_str = val.data_type.name();

            if val.storage == Storage::Output {
                decl.push_str(&format!("uniform {ref_type_str} ref_{value_name};\n"));
                decl.push_str(&format!("{ref_type_str} {value_name};\n"));
            } else if val.storage == Storage::Uniform && !value_name.contains('.') {
                decl.push_str(&format!("uniform {ref_type_str} {value_name};\n"));
            }
        }

        specialize(
            fragment_source,
            &[
                ("FRAGMENT_DECLARATIONS", decl),
                ("FRAGMENT_OUTPUT", output),
                ("FRAG_COLOR", frag_color.to_string()),
            ],
        )
    };

    (out_vertex, out_fragment)
}

/// `ShaderCase::dumpValues`
fn dump_values(value_block: &ValueBlock, array_ndx: usize) {
    for val in value_block.values {
        let data_type = val.data_type;
        let scalar_size = data_type.scalar_size() as usize;
        let mut result = String::from("    ");

        match val.storage {
            Storage::Input => result.push_str("input "),
            Storage::Uniform => result.push_str("uniform "),
            Storage::Output => result.push_str("expected "),
        }

        result.push_str(&format!("{} {}:", data_type.name(), val.name));

        if data_type.is_scalar() {
            result.push(' ');
        }
        if data_type.is_vector() {
            result.push_str(" [ ");
        } else if data_type.is_matrix() {
            result.push('\n');
        }

        if data_type.is_scalar_or_vector() {
            for scalar_ndx in 0..scalar_size {
                let elem_ndx = if val.array_length == 1 { 0 } else { array_ndx };
                let element = val.elements[elem_ndx * scalar_size + scalar_ndx];
                if scalar_ndx != 0 {
                    result.push_str(", ");
                }

                if data_type.is_float_or_vec() {
                    result.push_str(&element.float32().to_string());
                } else if data_type.is_int_or_ivec() || data_type.is_uint_or_uvec() {
                    result.push_str(&element.int32().to_string());
                } else if data_type.is_bool_or_bvec() {
                    result.push_str(if element.int32() != 0 { "true" } else { "false" });
                }
            }
        } else if data_type.is_matrix() {
            let num_rows = data_type.matrix_num_rows() as usize;
            let num_cols = data_type.matrix_num_columns() as usize;
            for row_ndx in 0..num_rows {
                result.push_str("       [ ");
                for col_ndx in 0..num_cols {
                    let elem_ndx = if val.array_length == 1 { 0 } else { array_ndx };
                    let v = val.elements[elem_ndx * scalar_size + row_ndx * num_cols + col_ndx].float32();
                    result.push_str(&format!("{}{v}", if col_ndx == 0 { "" } else { ", " }));
                }
                result.push_str(" ]\n");
            }
        }

        if data_type.is_scalar() {
            result.push('\n');
        } else if data_type.is_vector() {
            result.push_str(" ]\n");
        }

        log::info!("{result}");
    }
}
