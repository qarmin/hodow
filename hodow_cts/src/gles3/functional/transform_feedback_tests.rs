// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTransformFeedbackTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `init`/`deinit` fold into the top and
// bottom of `iterate` (a `TestCase` here is immutable and has no init phase), and the
// ten iterations upstream drives by returning CONTINUE are a loop, stopping on the first
// failure exactly as upstream's `isOk && ...` does. `ProgramSpec` owns its struct types
// through `Arc` rather than a `delete` loop; no case in this file actually declares one,
// but the shader generator upstream shares with the struct-carrying variants is kept.

use std::sync::Arc;

use crate::glu::shader_util::{DataType, Precision};
use crate::glu::var_type::{
    StructType, VarType, get_var_type, parse_type_path, parse_variable_name, type_access_name, vector_type_paths,
};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VarTypeComponent};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::random::{de_int32_hash, de_string_hash};
use crate::tcu::rgba::RGBA;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

const VIEWPORT_WIDTH: i32 = 128;
const VIEWPORT_HEIGHT: i32 = 128;
/// `stride*BUFFER_GUARD_MULTIPLIER` bytes are added to the end of tf buffer and used to check for overruns.
const BUFFER_GUARD_MULTIPLIER: i32 = 2;

/// One `uint32_t` of vertex data, which is the unit every stride here is counted in.
const ELEMENT_SIZE: i32 = 4;

/// `TransformFeedback::Interpolation`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Interpolation {
    Smooth,
    Flat,
    Centroid,
}

impl Interpolation {
    /// `getInterpolationName`
    fn name(self) -> &'static str {
        match self {
            Self::Smooth => "smooth",
            Self::Flat => "flat",
            Self::Centroid => "centroid",
        }
    }
}

/// `TransformFeedback::Varying`
#[derive(Clone)]
struct Varying {
    name: String,
    ty: VarType,
    interpolation: Interpolation,
}

/// `TransformFeedback::Attribute`
#[derive(Clone)]
struct Attribute {
    name: String,
    ty: VarType,
    offset: i32,
}

/// `TransformFeedback::Output`
///
/// Upstream keeps `vector<const Attribute*>`; the indices into `m_attributes` say the
/// same thing without borrowing from a vector the same function still appends to.
struct Output {
    name: String,
    ty: VarType,
    buffer_ndx: usize,
    offset: i32,
    inputs: Vec<usize>,
}

/// `TransformFeedback::DrawCall`
#[derive(Clone, Copy)]
struct DrawCall {
    num_elements: i32,
    transform_feedback_enabled: bool,
}

const fn call(num_elements: i32, transform_feedback_enabled: bool) -> DrawCall {
    DrawCall {
        num_elements,
        transform_feedback_enabled,
    }
}

/// `TransformFeedback::ProgramSpec`
#[derive(Default)]
struct ProgramSpec {
    structs: Vec<Arc<StructType>>,
    varyings: Vec<Varying>,
    transform_feedback_varyings: Vec<String>,
}

impl ProgramSpec {
    fn add_varying(&mut self, name: &str, ty: VarType, interp: Interpolation) {
        self.varyings.push(Varying {
            name: name.to_string(),
            ty,
            interpolation: interp,
        });
    }

    fn add_transform_feedback_varying(&mut self, name: &str) {
        self.transform_feedback_varyings.push(name.to_string());
    }

    /// `ProgramSpec::isPointSizeUsed`
    fn is_point_size_used(&self) -> bool {
        self.transform_feedback_varyings
            .iter()
            .any(|name| name == "gl_PointSize")
    }

    fn find_varying(&self, name: &str) -> &Varying {
        self.varyings
            .iter()
            .find(|var| var.name == name)
            .expect("no such varying")
    }
}

/// `isProgramSupported`
fn is_program_supported(gl: &glw::Functions, spec: &ProgramSpec, tf_mode: GLenum) -> bool {
    let get = |name: GLenum| {
        let mut value = 0;
        // SAFETY: every name below returns a single integer.
        unsafe { gl.get_integerv(name, &mut value) };
        value
    };
    let max_vertex_attribs = get(glw::GL_MAX_VERTEX_ATTRIBS);
    let max_tf_interleaved_components = get(glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS);
    let max_tf_separate_attribs = get(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS);
    let max_tf_separate_components = get(glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS);

    // Check vertex attribs.
    let mut total_vertex_attribs = 1 /* a_position */ + i32::from(spec.is_point_size_used());
    for var in &spec.varyings {
        total_vertex_attribs += vector_type_paths(&var.ty).len() as i32;
    }

    if total_vertex_attribs > max_vertex_attribs {
        return false; // Vertex attribute count exceeded.
    }

    // Check varyings.
    let mut total_tf_components = 0;
    let mut total_tf_attribs = 0;
    for name in &spec.transform_feedback_varyings {
        let num_components = match name.as_str() {
            "gl_Position" => 4,
            "gl_PointSize" => 1,
            _ => {
                let varying = spec.find_varying(&parse_variable_name(name));
                let var_path = parse_type_path(name, &varying.ty);
                get_var_type(&varying.ty, &var_path).scalar_size()
            }
        };

        if tf_mode == glw::GL_SEPARATE_ATTRIBS && num_components > max_tf_separate_components {
            return false; // Per-attribute component count exceeded.
        }

        total_tf_components += num_components;
        total_tf_attribs += 1;
    }

    if tf_mode == glw::GL_SEPARATE_ATTRIBS && total_tf_attribs > max_tf_separate_attribs {
        return false;
    }

    if tf_mode == glw::GL_INTERLEAVED_ATTRIBS && total_tf_components > max_tf_interleaved_components {
        return false;
    }

    true
}

/// `getAttributeName`
fn get_attribute_name(varying_name: &str, path: &[VarTypeComponent]) -> String {
    let mut name = format!("a_{}", varying_name.strip_prefix("v_").unwrap_or(varying_name));

    for component in path {
        let (prefix, index) = match component {
            VarTypeComponent::StructMember(index) => ("_m", index),
            VarTypeComponent::ArrayElement(index) => ("_e", index),
            VarTypeComponent::MatrixColumn(index) => ("_c", index),
            VarTypeComponent::VectorComponent(index) => ("_s", index),
        };
        name.push_str(prefix);
        name.push_str(&index.to_string());
    }

    name
}

/// `genShaderSources`
fn gen_shader_sources(spec: &ProgramSpec, point_size_required: bool) -> (String, String) {
    let mut vtx = String::from("#version 300 es\nin highp vec4 a_position;\n");
    let mut frag = String::from(
        "#version 300 es\nlayout(location = 0) out mediump vec4 o_color;\nuniform highp vec4 u_scale;\nuniform highp vec4 u_bias;\n",
    );
    let add_point_size = spec.is_point_size_used();

    if add_point_size {
        vtx.push_str("in highp float a_pointSize;\n");
    }

    // Declare attributes.
    for var in &spec.varyings {
        for path in vector_type_paths(&var.ty) {
            let attrib_type = get_var_type(&var.ty, &path);
            let attrib_name = get_attribute_name(&var.name, &path);
            vtx.push_str(&format!("in {};\n", glu::declare_var(&attrib_type, &attrib_name, 0)));
        }
    }

    // Declare varyings.
    for (inout, str_out) in [("out", &mut vtx), ("in", &mut frag)] {
        // Declare structs that have type name.
        for struct_ptr in &spec.structs {
            if struct_ptr.has_type_name() {
                str_out.push_str(&format!("{};\n", glu::declare_struct(struct_ptr, 0)));
            }
        }

        for var in &spec.varyings {
            str_out.push_str(&format!(
                "{} {} {};\n",
                var.interpolation.name(),
                inout,
                glu::declare_var(&var.ty, &var.name, 0)
            ));
        }
    }

    vtx.push_str("\nvoid main (void)\n{\n\tgl_Position = a_position;\n");
    frag.push_str("\nvoid main (void)\n{\n\thighp vec4 res = vec4(0.0);\n");

    if add_point_size {
        vtx.push_str("\tgl_PointSize = a_pointSize;\n");
    } else if point_size_required {
        vtx.push_str("\tgl_PointSize = 1.0;\n");
    }

    // Generate assignments / usage.
    for var in &spec.varyings {
        for path in vector_type_paths(&var.ty) {
            let sub_type = get_var_type(&var.ty, &path);
            let attrib_name = get_attribute_name(&var.name, &path);
            let access = type_access_name(&var.name, &var.ty, &path);

            // Vertex: assign from attribute.
            vtx.push_str(&format!("\t{access} = {attrib_name};\n"));

            // Fragment: add to res variable.
            let scalar_size = sub_type.basic_type().scalar_size();
            frag.push_str("\tres += ");
            match scalar_size {
                1 => frag.push_str(&format!("vec4({access})")),
                2 => frag.push_str(&format!("vec2({access}).xxyy")),
                3 => frag.push_str(&format!("vec3({access}).xyzx")),
                _ => frag.push_str(&format!("vec4({access})")),
            }
            frag.push_str(";\n");
        }
    }

    frag.push_str("\to_color = res * u_scale + u_bias;\n");
    vtx.push_str("}\n");
    frag.push_str("}\n");

    (vtx, frag)
}

/// `createVertexCaptureProgram`
fn create_vertex_capture_program<'gl>(
    gl: &'gl glw::Functions,
    spec: &ProgramSpec,
    buffer_mode: GLenum,
    primitive_type: GLenum,
) -> ShaderProgram<'gl> {
    let (vert_source, frag_source) = gen_shader_sources(spec, primitive_type == glw::GL_POINTS);

    ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(vert_source, frag_source)
            .with_transform_feedback(&spec.transform_feedback_varyings, buffer_mode),
    )
}

/// `computeInputLayout`
fn compute_input_layout(varyings: &[Varying], use_point_size: bool) -> (Vec<Attribute>, i32) {
    let mut attributes = Vec::new();
    let mut input_stride = 0;

    // Add position.
    attributes.push(Attribute {
        name: "a_position".to_string(),
        ty: VarType::basic(DataType::FloatVec4, Some(Precision::HighP)),
        offset: input_stride,
    });
    input_stride += 4 * ELEMENT_SIZE;

    if use_point_size {
        attributes.push(Attribute {
            name: "a_pointSize".to_string(),
            ty: VarType::basic(DataType::Float, Some(Precision::HighP)),
            offset: input_stride,
        });
        input_stride += ELEMENT_SIZE;
    }

    // Compute attribute vector.
    for var in varyings {
        for path in vector_type_paths(&var.ty) {
            let ty = get_var_type(&var.ty, &path);
            let name = get_attribute_name(&var.name, &path);
            let scalar_size = ty.basic_type().scalar_size();

            attributes.push(Attribute {
                name,
                ty,
                offset: input_stride,
            });
            input_stride += scalar_size * ELEMENT_SIZE;
        }
    }

    (attributes, input_stride)
}

fn find_attribute(attributes: &[Attribute], name: &str) -> usize {
    attributes
        .iter()
        .position(|attrib| attrib.name == name)
        .expect("no such attribute")
}

/// `computeTransformFeedbackOutputs`
fn compute_transform_feedback_outputs(
    attributes: &[Attribute],
    varyings: &[Varying],
    transform_feedback_varyings: &[String],
    buffer_mode: GLenum,
) -> Vec<Output> {
    let mut outputs = Vec::with_capacity(transform_feedback_varyings.len());
    let mut accumulated_size = 0;

    for (var_ndx, name) in transform_feedback_varyings.iter().enumerate() {
        let separate = buffer_mode == glw::GL_SEPARATE_ATTRIBS;
        let buffer_ndx = if separate { var_ndx } else { 0 };
        let offset = if separate { 0 } else { accumulated_size };

        let (ty, inputs) = match name.as_str() {
            "gl_Position" => {
                let pos_in = find_attribute(attributes, "a_position");
                (attributes[pos_in].ty.clone(), vec![pos_in])
            }
            "gl_PointSize" => {
                let size_in = find_attribute(attributes, "a_pointSize");
                (attributes[size_in].ty.clone(), vec![size_in])
            }
            _ => {
                let var_name = parse_variable_name(name);
                let varying = varyings
                    .iter()
                    .find(|var| var.name == var_name)
                    .expect("no such varying");
                let var_path = parse_type_path(name, &varying.ty);
                let ty = get_var_type(&varying.ty, &var_path);

                // Add all vectorized attributes as inputs.
                let inputs = vector_type_paths(&ty)
                    .into_iter()
                    .map(|leaf_path| {
                        let mut full_path = var_path.clone();
                        full_path.extend_from_slice(&leaf_path);
                        find_attribute(attributes, &get_attribute_name(&var_name, &full_path))
                    })
                    .collect();

                (ty, inputs)
            }
        };

        accumulated_size += ty.scalar_size() * ELEMENT_SIZE;
        outputs.push(Output {
            name: name.clone(),
            ty,
            buffer_ndx,
            offset,
            inputs,
        });
    }

    outputs
}

/// `signExtend`
fn sign_extend(value: u32, num_bits: u32) -> u32 {
    if num_bits == 32 || (value & (1 << (num_bits - 1))) == 0 {
        value
    } else {
        value | !((1u32 << num_bits) - 1)
    }
}

/// `genAttributeData`
fn gen_attribute_data(attrib: &Attribute, base: &mut [u8], stride: i32, num_elements: i32, rnd: &mut Random) {
    let basic_type = attrib.ty.basic_type();
    let is_float = basic_type.is_float_or_vec();
    let is_int = basic_type.is_int_or_ivec();
    let is_uint = basic_type.is_uint_or_uvec();
    let precision = attrib.ty.precision().expect("an attribute always carries a precision");
    let num_comps = basic_type.scalar_size();

    for elem_ndx in 0..num_elements {
        for comp_ndx in 0..num_comps {
            let offset = (attrib.offset + elem_ndx * stride + comp_ndx * ELEMENT_SIZE) as usize;
            let word = if is_float {
                let value = match precision {
                    Precision::LowP => 0.0 + 0.25 * rnd.get_int(0, 4) as f32,
                    Precision::MediumP => rnd.get_float_range(-1e3, 1e3),
                    Precision::HighP => rnd.get_float_range(-1e5, 1e5),
                };
                value.to_bits()
            } else if is_int {
                match precision {
                    Precision::LowP => sign_extend(rnd.get_uint32() & 0xff, 8),
                    Precision::MediumP => sign_extend(rnd.get_uint32() & 0xffff, 16),
                    Precision::HighP => rnd.get_uint32(),
                }
            } else {
                debug_assert!(is_uint);
                match precision {
                    Precision::LowP => rnd.get_uint32() & 0xff,
                    Precision::MediumP => rnd.get_uint32() & 0xffff,
                    Precision::HighP => rnd.get_uint32(),
                }
            };
            base[offset..offset + 4].copy_from_slice(&word.to_ne_bytes());
        }
    }
}

/// `genInputData`
fn gen_input_data(attributes: &[Attribute], num_inputs: i32, input_stride: i32, base: &mut [u8], rnd: &mut Random) {
    let write_f32 = |base: &mut [u8], offset: usize, value: f32| {
        base[offset..offset + 4].copy_from_slice(&value.to_ne_bytes());
    };

    // Random positions.
    let position_offset = attributes[find_attribute(attributes, "a_position")].offset;
    for ndx in 0..num_inputs {
        let ptr = (position_offset + input_stride * ndx) as usize;
        write_f32(base, ptr, rnd.get_float_range(-1.2, 1.2));
        write_f32(base, ptr + 4, rnd.get_float_range(-1.2, 1.2));
        write_f32(base, ptr + 8, rnd.get_float_range(-1.2, 1.2));
        write_f32(base, ptr + 12, rnd.get_float_range(0.1, 2.0));
    }

    // Point size.
    if let Some(point_size) = attributes.iter().find(|attrib| attrib.name == "a_pointSize") {
        for ndx in 0..num_inputs {
            let ptr = (point_size.offset + input_stride * ndx) as usize;
            write_f32(base, ptr, rnd.get_float_range(1.0, 8.0));
        }
    }

    // Random data for rest of components.
    for attrib in attributes {
        if attrib.name == "a_position" || attrib.name == "a_pointSize" {
            continue;
        }
        gen_attribute_data(attrib, base, input_stride, num_inputs, rnd);
    }
}

/// `getTransformFeedbackOutputCount`
fn get_transform_feedback_output_count(primitive_type: GLenum, num_elements: i32) -> i32 {
    match primitive_type {
        glw::GL_TRIANGLES => num_elements - num_elements % 3,
        glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_FAN => (num_elements - 2).max(0) * 3,
        glw::GL_LINES => num_elements - num_elements % 2,
        glw::GL_LINE_STRIP => (num_elements - 1).max(0) * 2,
        glw::GL_LINE_LOOP => {
            if num_elements > 1 {
                num_elements * 2
            } else {
                0
            }
        }
        glw::GL_POINTS => num_elements,
        _ => 0,
    }
}

/// `getTransformFeedbackPrimitiveCount`
fn get_transform_feedback_primitive_count(primitive_type: GLenum, num_elements: i32) -> i32 {
    match primitive_type {
        glw::GL_TRIANGLES => num_elements / 3,
        glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_FAN => (num_elements - 2).max(0),
        glw::GL_LINES => num_elements / 2,
        glw::GL_LINE_STRIP => (num_elements - 1).max(0),
        glw::GL_LINE_LOOP => {
            if num_elements > 1 {
                num_elements
            } else {
                0
            }
        }
        glw::GL_POINTS => num_elements,
        _ => 0,
    }
}

/// `getTransformFeedbackPrimitiveMode`
fn get_transform_feedback_primitive_mode(primitive_type: GLenum) -> GLenum {
    match primitive_type {
        glw::GL_TRIANGLES | glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_FAN => glw::GL_TRIANGLES,
        glw::GL_LINES | glw::GL_LINE_LOOP | glw::GL_LINE_STRIP => glw::GL_LINES,
        _ => glw::GL_POINTS,
    }
}

/// `getAttributeIndex`
fn get_attribute_index(primitive_type: GLenum, num_inputs: i32, out_ndx: i32) -> i32 {
    match primitive_type {
        glw::GL_TRIANGLE_STRIP => {
            let tri_ndx = out_ndx / 3;
            let vtx_ndx = out_ndx % 3;
            if tri_ndx % 2 != 0 && vtx_ndx < 2 {
                tri_ndx + 1 - vtx_ndx
            } else {
                tri_ndx + vtx_ndx
            }
        }
        glw::GL_TRIANGLE_FAN => {
            if out_ndx % 3 != 0 {
                out_ndx / 3 + out_ndx % 3
            } else {
                0
            }
        }
        glw::GL_LINE_STRIP => out_ndx / 2 + out_ndx % 2,
        glw::GL_LINE_LOOP => {
            let in_ndx = out_ndx / 2 + out_ndx % 2;
            if in_ndx < num_inputs { in_ndx } else { 0 }
        }
        // GL_TRIANGLES, GL_LINES and GL_POINTS are all one-to-one.
        _ => out_ndx,
    }
}

fn read_u32(bytes: &[u8], offset: usize) -> u32 {
    u32::from_ne_bytes(bytes[offset..offset + 4].try_into().expect("four bytes"))
}

/// `compareTransformFeedbackOutput`
#[allow(clippy::too_many_arguments)]
fn compare_transform_feedback_output(
    primitive_type: GLenum,
    output: &Output,
    attributes: &[Attribute],
    num_inputs: i32,
    in_base: &[u8],
    in_base_offset: usize,
    in_stride: i32,
    out_base: &[u8],
    out_base_offset: usize,
    out_stride: i32,
) -> Result<(), String> {
    let mut out_offset = output.offset;

    for attrib_ndx in &output.inputs {
        let attribute = &attributes[*attrib_ndx];
        let ty = attribute.ty.basic_type();
        let num_components = ty.scalar_size();
        let precision = attribute
            .ty
            .precision()
            .expect("an attribute always carries a precision");
        let scalar_type = ty.scalar_type();
        let num_outputs = get_transform_feedback_output_count(primitive_type, num_inputs);

        for out_ndx in 0..num_outputs {
            let in_ndx = get_attribute_index(primitive_type, num_inputs, out_ndx);

            for comp_ndx in 0..num_components {
                let in_at = in_base_offset + (in_stride * in_ndx + attribute.offset + comp_ndx * ELEMENT_SIZE) as usize;
                let out_at = out_base_offset + (out_stride * out_ndx + out_offset + comp_ndx * ELEMENT_SIZE) as usize;
                let in_val = read_u32(in_base, in_at);
                let out_val = read_u32(out_base, out_at);

                let is_equal = if scalar_type == DataType::Float {
                    // ULP comparison is used for highp and mediump. Lowp uses threshold-comparison.
                    match precision {
                        Precision::HighP => (in_val as i32 - out_val as i32).abs() < 2,
                        Precision::MediumP => (in_val as i32 - out_val as i32).abs() < 2 + (1 << 13),
                        Precision::LowP => (f32::from_bits(in_val) - f32::from_bits(out_val)).abs() < 0.1,
                    }
                } else {
                    in_val == out_val // Bit-exact match required for integer types.
                };

                if !is_equal {
                    return Err(format!(
                        "Mismatch in {} ({}), output = {out_ndx}, input = {in_ndx}, component = {comp_ndx}",
                        output.name, attribute.name
                    ));
                }
            }
        }

        out_offset += num_components * ELEMENT_SIZE;
    }

    Ok(())
}

/// `computeTransformFeedbackPrimitiveCount`
fn compute_transform_feedback_primitive_count(primitive_type: GLenum, calls: &[DrawCall]) -> i32 {
    calls
        .iter()
        .filter(|call| call.transform_feedback_enabled)
        .map(|call| get_transform_feedback_primitive_count(primitive_type, call.num_elements))
        .sum()
}

/// `writeBufferGuard`
fn write_buffer_guard(gl: &glw::Functions, target: GLenum, buffer_size: i32, guard_size: i32) -> Result<(), TestError> {
    // SAFETY: the range is inside the store just allocated, and a driver that refuses
    // the map answers null.
    unsafe {
        let ptr = gl.map_buffer_range(target, buffer_size as isize, guard_size as isize, glw::GL_MAP_WRITE_BIT);
        if !ptr.is_null() {
            std::ptr::write_bytes(ptr.cast::<u8>(), 0xcd, guard_size as usize);
        }
        gl.unmap_buffer(target);
    }
    glu::expect_no_error(gl, "guardband write")
}

/// `verifyGuard`
fn verify_guard(bytes: &[u8]) -> bool {
    bytes.iter().all(|byte| *byte == 0xcd)
}

/// `TransformFeedbackCase::iterate`'s `s_iterations`
const ITERATIONS: [&[DrawCall]; 10] = [
    &[call(1, true)],
    &[call(2, true)],
    &[call(3, true)],
    &[call(4, true)],
    &[call(123, true)],
    &[call(64, true), call(64, false), call(64, true)],
    &[
        call(13, true),
        call(5, true),
        call(17, false),
        call(3, true),
        call(7, false),
    ],
    &[call(123, false), call(123, true)],
    &[
        call(65, true),
        call(135, false),
        call(74, true),
        call(16, false),
        call(226, false),
        call(9, true),
        call(174, false),
    ],
    &[
        call(217, true),
        call(171, true),
        call(147, true),
        call(152, false),
        call(55, true),
    ],
];

/// Which of upstream's `TransformFeedbackCase` subclasses builds this case's spec.
#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseKind {
    /// `PositionCase`
    Position,
    /// `PointSizeCase`
    PointSize,
    /// `BasicTypeCase`
    BasicType(DataType, Precision, Interpolation),
    /// `BasicArrayCase`
    BasicArray(DataType, Precision, Interpolation),
    /// `ArrayElementCase`
    ArrayElement(DataType, Precision, Interpolation),
    /// `RandomCase` - the bool is upstream's `m_elementCapture`.
    Random(u32, bool),
}

/// `TransformFeedbackCase` and its six subclasses.
struct TransformFeedbackCase {
    name: String,
    buffer_mode: GLenum,
    primitive_type: GLenum,
    kind: CaseKind,
}

impl TransformFeedbackCase {
    /// Each subclass's constructor body, plus `RandomCase::init`.
    fn build_spec(&self) -> ProgramSpec {
        let mut spec = ProgramSpec::default();

        match self.kind {
            CaseKind::Position => spec.add_transform_feedback_varying("gl_Position"),
            CaseKind::PointSize => spec.add_transform_feedback_varying("gl_PointSize"),
            CaseKind::BasicType(ty, precision, interp) => {
                spec.add_varying("v_varA", VarType::basic(ty, Some(precision)), interp);
                spec.add_varying("v_varB", VarType::basic(ty, Some(precision)), interp);
                spec.add_transform_feedback_varying("v_varA");
                spec.add_transform_feedback_varying("v_varB");
            }
            CaseKind::BasicArray(ty, precision, interp) => {
                // \note For matrix types we need to use reduced array sizes or otherwise we will exceed maximum attribute (16)
                //       or transform feedback component count (64).
                //       On separate attribs mode maximum component count per varying is 4.
                let (size_a, size_b) = if ty.is_matrix() || self.buffer_mode == glw::GL_SEPARATE_ATTRIBS {
                    (1, 2)
                } else {
                    (3, 4)
                };
                spec.add_varying(
                    "v_varA",
                    VarType::array(VarType::basic(ty, Some(precision)), size_a),
                    interp,
                );
                spec.add_varying(
                    "v_varB",
                    VarType::array(VarType::basic(ty, Some(precision)), size_b),
                    interp,
                );
                spec.add_transform_feedback_varying("v_varA");
                spec.add_transform_feedback_varying("v_varB");
            }
            CaseKind::ArrayElement(ty, precision, interp) => {
                spec.add_varying("v_varA", VarType::array(VarType::basic(ty, Some(precision)), 3), interp);
                spec.add_varying("v_varB", VarType::array(VarType::basic(ty, Some(precision)), 4), interp);
                spec.add_transform_feedback_varying("v_varA[1]");
                spec.add_transform_feedback_varying("v_varB[0]");
                spec.add_transform_feedback_varying("v_varB[3]");
            }
            CaseKind::Random(seed, element_capture) => self.build_random_spec(&mut spec, seed, element_capture),
        }

        spec
    }

    /// `RandomCase::init`
    fn build_random_spec(&self, spec: &mut ProgramSpec, seed: u32, element_capture: bool) {
        // \note Hard-coded indices and hackery are used when indexing this, beware.
        const TYPE_CANDIDATES: [DataType; 21] = [
            DataType::Float,
            DataType::FloatVec2,
            DataType::FloatVec3,
            DataType::FloatVec4,
            DataType::Int,
            DataType::IntVec2,
            DataType::IntVec3,
            DataType::IntVec4,
            DataType::Uint,
            DataType::UintVec2,
            DataType::UintVec3,
            DataType::UintVec4,
            DataType::FloatMat2,
            DataType::FloatMat2x3,
            DataType::FloatMat2x4,
            DataType::FloatMat3x2,
            DataType::FloatMat3,
            DataType::FloatMat3x4,
            DataType::FloatMat4x2,
            DataType::FloatMat4x3,
            DataType::FloatMat4,
        ];
        const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];
        const INTERP_MODES: [Interpolation; 3] = [Interpolation::Flat, Interpolation::Smooth, Interpolation::Centroid];

        let max_attribute_vectors = 16;
        let is_separate_mode = self.buffer_mode == glw::GL_SEPARATE_ATTRIBS;
        let max_transform_feedback_vars = if is_separate_mode { 4 } else { max_attribute_vectors };
        let array_weight = 0.3;
        let position_weight = 0.7;
        let point_size_weight = 0.1;
        let capture_full_array_weight = 0.5;

        let mut rnd = Random::new(seed);
        let use_position = rnd.get_float() < position_weight;
        let use_point_size = rnd.get_float() < point_size_weight;
        let num_attrib_vectors_to_use =
            rnd.get_int(1, max_attribute_vectors - 1 /*position*/ - i32::from(use_point_size));

        let mut num_attribute_vectors = 0;
        let mut var_ndx = 0;

        // Generate varyings.
        while num_attribute_vectors < num_attrib_vectors_to_use {
            let max_vecs = if is_separate_mode {
                2 /*at most 2*mat2*/
                    .min(num_attrib_vectors_to_use - num_attribute_vectors)
            } else {
                num_attrib_vectors_to_use - num_attribute_vectors
            };
            let end = if max_vecs >= 4 {
                21
            } else if max_vecs >= 3 {
                18
            } else if max_vecs >= 2 {
                if is_separate_mode { 13 } else { 15 }
            } else {
                12
            };

            let ty = *rnd.choose(&TYPE_CANDIDATES[..end]);
            let precision = *rnd.choose(&PRECISIONS);
            let interp = if ty.scalar_type() == DataType::Float {
                *rnd.choose(&INTERP_MODES)
            } else {
                Interpolation::Flat
            };
            let num_vecs = if ty.is_matrix() { ty.matrix_num_columns() } else { 1 };
            let num_comps = ty.scalar_size();
            let max_array_len = 1.max(if is_separate_mode {
                4 / num_comps
            } else {
                max_vecs / num_vecs
            });
            let use_array = rnd.get_float() < array_weight;
            let array_len = if use_array { rnd.get_int(1, max_array_len) } else { 1 };
            let name = format!("v_var{var_ndx}");

            if use_array {
                spec.add_varying(
                    &name,
                    VarType::array(VarType::basic(ty, Some(precision)), array_len),
                    interp,
                );
            } else {
                spec.add_varying(&name, VarType::basic(ty, Some(precision)), interp);
            }

            num_attribute_vectors += array_len * num_vecs;
            var_ndx += 1;
        }

        // Generate transform feedback candidate set.
        let mut tf_candidates: Vec<String> = Vec::new();

        if use_position {
            tf_candidates.push("gl_Position".to_string());
        }
        if use_point_size {
            tf_candidates.push("gl_PointSize".to_string());
        }

        for ndx in 0..var_ndx as usize {
            let var = &spec.varyings[ndx];

            if var.ty.is_array_type() {
                let capture_full = if element_capture {
                    rnd.get_float() < capture_full_array_weight
                } else {
                    true
                };

                if capture_full {
                    tf_candidates.push(var.name.clone());
                } else {
                    for elem_ndx in 0..var.ty.array_size() {
                        tf_candidates.push(format!("{}[{elem_ndx}]", var.name));
                    }
                }
            } else {
                tf_candidates.push(var.name.clone());
            }
        }

        // Pick random selection.
        let num_tf_varyings = tf_candidates.len().min(max_transform_feedback_vars as usize);
        let mut tf_varyings = rnd.choose_n(&tf_candidates, num_tf_varyings);
        rnd.shuffle(&mut tf_varyings);

        for var in &tf_varyings {
            spec.add_transform_feedback_varying(var);
        }
    }

    /// `hasArraysInTFVaryings`
    fn has_arrays_in_tf_varyings(spec: &ProgramSpec) -> bool {
        spec.transform_feedback_varyings.iter().any(|tf_var| {
            let var_name = parse_variable_name(tf_var);
            if var_name == "gl_Position" || var_name == "gl_PointSize" {
                return false;
            }
            spec.find_varying(&var_name).ty.is_array_type()
        })
    }

    /// `TransformFeedbackCase::runTest`
    #[allow(clippy::too_many_lines)]
    fn run_test(
        &self,
        context: &Context,
        state: &CaseState<'_>,
        calls: &[DrawCall],
        seed: u32,
    ) -> Result<Vec<String>, TestError> {
        let gl = context.gl();
        let mut rnd = Random::new(seed);
        let render_target = context.render_target();
        let viewport_w = VIEWPORT_WIDTH.min(render_target.width);
        let viewport_h = VIEWPORT_HEIGHT.min(render_target.height);
        let viewport_x = rnd.get_int(0, render_target.width - viewport_w);
        let viewport_y = rnd.get_int(0, render_target.height - viewport_h);
        let mut frame_with_tf = Surface::new(viewport_w, viewport_h);
        let mut frame_without_tf = Surface::new(viewport_w, viewport_h);
        let primitive_query = glu::objects::Query::new(gl);
        let mut failures: Vec<String> = Vec::new();

        // Compute totals.
        let num_inputs: i32 = calls.iter().map(|call| call.num_elements).sum();
        let num_outputs: i32 = calls
            .iter()
            .map(|call| {
                if call.transform_feedback_enabled {
                    get_transform_feedback_output_count(self.primitive_type, call.num_elements)
                } else {
                    0
                }
            })
            .sum();

        // Input data.
        let mut input_data = vec![0u8; (state.input_stride * num_inputs) as usize];
        gen_input_data(
            &state.attributes,
            num_inputs,
            state.input_stride,
            &mut input_data,
            &mut rnd,
        );

        // SAFETY: every buffer/program name below is one this case owns, and every
        // pointer handed to GL is into `input_data`, which outlives the draws.
        unsafe {
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.transform_feedback.get());
            glu::expect_no_error(gl, "glBindTransformFeedback()")?;

            // Allocate storage for transform feedback output buffers and bind to targets.
            for (buf_ndx, buffer) in state.output_buffers.iter().enumerate() {
                let stride = state.buffer_strides[buf_ndx];
                let size = stride * num_outputs;
                let guard_size = stride * BUFFER_GUARD_MULTIPLIER;

                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buffer.get());
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    (size + guard_size) as isize,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_READ,
                );
                write_buffer_guard(gl, glw::GL_TRANSFORM_FEEDBACK_BUFFER, size, guard_size)?;

                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf_ndx as GLuint, buffer.get());

                glu::expect_no_error(gl, "transform feedback buffer setup")?;
            }

            // Setup attributes.
            for attrib in &state.attributes {
                let name = std::ffi::CString::new(attrib.name.as_str()).expect("attribute name holds a nul byte");
                let loc = gl.get_attrib_location(state.program.program(), name.as_ptr());
                let scalar_type = attrib.ty.basic_type().scalar_type();
                let num_components = attrib.ty.basic_type().scalar_size();
                let ptr = input_data.as_ptr().add(attrib.offset as usize).cast();

                if loc >= 0 {
                    gl.enable_vertex_attrib_array(loc as GLuint);

                    match scalar_type {
                        DataType::Float => {
                            gl.vertex_attrib_pointer(
                                loc as GLuint,
                                num_components,
                                glw::GL_FLOAT,
                                glw::FALSE,
                                state.input_stride,
                                ptr,
                            );
                        }
                        DataType::Int => gl.vertex_attrib_i_pointer(
                            loc as GLuint,
                            num_components,
                            glw::GL_INT,
                            state.input_stride,
                            ptr,
                        ),
                        DataType::Uint => {
                            gl.vertex_attrib_i_pointer(
                                loc as GLuint,
                                num_components,
                                glw::GL_UNSIGNED_INT,
                                state.input_stride,
                                ptr,
                            );
                        }
                        _ => {}
                    }
                }
            }

            // Setup viewport.
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);

            // Setup program.
            gl.use_program(state.program.program());

            let scale = [0.01f32; 4];
            let bias = [0.5f32; 4];
            gl.uniform_4fv(
                gl.get_uniform_location(state.program.program(), c"u_scale".as_ptr()),
                1,
                scale.as_ptr(),
            );
            gl.uniform_4fv(
                gl.get_uniform_location(state.program.program(), c"u_bias".as_ptr()),
                1,
                bias.as_ptr(),
            );

            // Enable query.
            gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, primitive_query.get());
            glu::expect_no_error(gl, "glBeginQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN)")?;

            // Draw.
            {
                let mut offset = 0;
                let mut tf_enabled = true;

                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.begin_transform_feedback(get_transform_feedback_primitive_mode(self.primitive_type));

                for call in calls {
                    // Pause or resume transform feedback if necessary.
                    if call.transform_feedback_enabled != tf_enabled {
                        if call.transform_feedback_enabled {
                            gl.resume_transform_feedback();
                        } else {
                            gl.pause_transform_feedback();
                        }
                        tf_enabled = call.transform_feedback_enabled;
                    }

                    gl.draw_arrays(self.primitive_type, offset, call.num_elements);
                    offset += call.num_elements;
                }

                // Resume feedback before finishing it.
                if !tf_enabled {
                    gl.resume_transform_feedback();
                }

                gl.end_transform_feedback();
                glu::expect_no_error(gl, "render")?;
            }

            gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
            glu::expect_no_error(gl, "glEndQuery(GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN)")?;

            // Compare result buffers.
            for (buffer_ndx, buffer) in state.output_buffers.iter().enumerate() {
                let stride = state.buffer_strides[buffer_ndx];
                let size = stride * num_outputs;
                let guard_size = stride * BUFFER_GUARD_MULTIPLIER;

                // Bind buffer for reading.
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buffer.get());
                let buf_ptr = gl.map_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    (size + guard_size) as isize,
                    glw::GL_MAP_READ_BIT,
                );
                glu::expect_no_error(gl, "mapping buffer")?;
                if buf_ptr.is_null() {
                    return Err(TestError::Fail("glMapBufferRange returned NULL".to_string()));
                }
                let mapped = std::slice::from_raw_parts(buf_ptr.cast::<u8>(), (size + guard_size) as usize);

                // Verify all output variables that are written to this buffer.
                for out in state
                    .transform_feedback_outputs
                    .iter()
                    .filter(|out| out.buffer_ndx == buffer_ndx)
                {
                    let mut input_offset = 0;
                    let mut output_offset = 0;

                    // Process all draw calls and check ones with transform feedback enabled.
                    for call in calls {
                        if call.transform_feedback_enabled
                            && let Err(message) = compare_transform_feedback_output(
                                self.primitive_type,
                                out,
                                &state.attributes,
                                call.num_elements,
                                &input_data,
                                (input_offset * state.input_stride) as usize,
                                state.input_stride,
                                mapped,
                                (output_offset * stride) as usize,
                                stride,
                            )
                        {
                            failures.push(message);
                            break;
                        }

                        input_offset += call.num_elements;
                        output_offset += if call.transform_feedback_enabled {
                            get_transform_feedback_output_count(self.primitive_type, call.num_elements)
                        } else {
                            0
                        };
                    }
                }

                // Verify guardband.
                if !verify_guard(&mapped[size as usize..]) {
                    failures.push("Transform feedback buffer overrun detected".to_string());
                }

                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            }

            // Check status after mapping buffers.
            {
                let must_be_ready = !state.output_buffers.is_empty(); // Mapping buffer forces synchronization.
                let expected_count = compute_transform_feedback_primitive_count(self.primitive_type, calls);
                let mut available = glw::GL_FALSE;
                let mut num_primitives = 0;

                gl.get_query_objectuiv(primitive_query.get(), glw::GL_QUERY_RESULT_AVAILABLE, &mut available);
                gl.get_query_objectuiv(primitive_query.get(), glw::GL_QUERY_RESULT, &mut num_primitives);
                glu::expect_no_error(gl, "glGetQueryObjectuiv()")?;

                if !must_be_ready && available == glw::GL_FALSE {
                    failures.push(
                        "GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN result not available after mapping buffers"
                            .to_string(),
                    );
                }

                if num_primitives as i32 != expected_count {
                    failures.push(format!(
                        "GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = {num_primitives}, expected {expected_count}"
                    ));
                }
            }

            // Clear transform feedback state.
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
            for buf_ndx in 0..state.output_buffers.len() {
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buf_ndx as GLuint, 0);
            }
        }

        // Read back rendered image.
        glu::read_pixels(
            &context.render_context,
            viewport_x,
            viewport_y,
            &mut frame_with_tf.get_access(),
        )?;

        // Render without transform feedback.
        // SAFETY: as above; the same program and client arrays are still bound.
        unsafe {
            let mut offset = 0;
            gl.clear(glw::GL_COLOR_BUFFER_BIT);

            for call in calls {
                gl.draw_arrays(self.primitive_type, offset, call.num_elements);
                offset += call.num_elements;
            }
        }
        glu::expect_no_error(gl, "render")?;
        glu::read_pixels(
            &context.render_context,
            viewport_x,
            viewport_y,
            &mut frame_without_tf.get_access(),
        )?;

        // Compare images with and without transform feedback.
        if !pixel_threshold_compare(&frame_without_tf, &frame_with_tf, RGBA::new(1, 1, 1, 1)).ok {
            failures.push("Rendering result comparison between TF enabled and TF disabled failed".to_string());
        }

        // The attribute arrays point into `input_data`, which goes away with this call.
        // SAFETY: as above.
        unsafe {
            for attrib in &state.attributes {
                let name = std::ffi::CString::new(attrib.name.as_str()).expect("attribute name holds a nul byte");
                let loc = gl.get_attrib_location(state.program.program(), name.as_ptr());
                if loc >= 0 {
                    gl.disable_vertex_attrib_array(loc as GLuint);
                }
            }
        }

        Ok(failures)
    }
}

/// Everything `TransformFeedbackCase::init` derives and `runTest` reads back.
struct CaseState<'gl> {
    program: ShaderProgram<'gl>,
    transform_feedback: glu::objects::TransformFeedback<'gl>,
    output_buffers: Vec<glu::objects::Buffer<'gl>>,
    attributes: Vec<Attribute>,
    transform_feedback_outputs: Vec<Output>,
    buffer_strides: Vec<i32>,
    input_stride: i32,
}

impl TestCase for TransformFeedbackCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let spec = self.build_spec();

        // `TransformFeedbackCase::init`
        let program = create_vertex_capture_program(gl, &spec, self.buffer_mode, self.primitive_type);
        if !program.is_ok() {
            let link_fail = program.shader_info.iter().all(|(_, info)| info.ok) && !program.program_info.ok;

            if link_fail {
                if !is_program_supported(gl, &spec, self.buffer_mode) {
                    return Err(TestError::NotSupported("Implementation limits execeeded".to_string()));
                } else if Self::has_arrays_in_tf_varyings(&spec) {
                    return Err(TestError::NotSupported(
                        "Capturing arrays is not supported (undefined in specification)".to_string(),
                    ));
                }
                return Err(TestError::Fail("Link failed".to_string()));
            }
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        // Compute input specification.
        let (attributes, input_stride) = compute_input_layout(&spec.varyings, spec.is_point_size_used());

        // Build list of varyings used in transform feedback.
        let transform_feedback_outputs = compute_transform_feedback_outputs(
            &attributes,
            &spec.varyings,
            &spec.transform_feedback_varyings,
            self.buffer_mode,
        );
        debug_assert!(!transform_feedback_outputs.is_empty());

        // Buffer strides.
        let buffer_strides: Vec<i32> = if self.buffer_mode == glw::GL_SEPARATE_ATTRIBS {
            transform_feedback_outputs
                .iter()
                .map(|out| out.ty.scalar_size() * ELEMENT_SIZE)
                .collect()
        } else {
            vec![
                transform_feedback_outputs
                    .iter()
                    .map(|out| out.ty.scalar_size() * ELEMENT_SIZE)
                    .sum(),
            ]
        };

        let output_buffers: Vec<_> = buffer_strides.iter().map(|_| glu::objects::Buffer::new(gl)).collect();
        let transform_feedback = glu::objects::TransformFeedback::new(gl);
        glu::expect_no_error(gl, "init")?;

        let state = CaseState {
            program,
            transform_feedback,
            output_buffers,
            attributes,
            transform_feedback_outputs,
            buffer_strides,
            input_stride,
        };

        // `TransformFeedbackCase::iterate`, whose CONTINUE/STOP loop stops on the first
        // failing iteration.
        for (iter_ndx, calls) in ITERATIONS.iter().enumerate() {
            let seed = de_string_hash(&self.name) ^ de_int32_hash(iter_ndx as i32);
            let failures = self.run_test(context, &state, calls, seed)?;

            if !failures.is_empty() {
                return Ok(TestStatus::fail(format!(
                    "Result comparison failed (iteration {}): {}",
                    iter_ndx + 1,
                    failures.join("; ")
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `basicTypes` table the `basic_types`, `array` and `array_element` groups share.
const BASIC_TYPES: [DataType; 21] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::FloatMat2,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
    DataType::FloatMat4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Uint,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
];

const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];
const BUFFER_MODES: [(&str, GLenum); 2] = [
    ("separate", glw::GL_SEPARATE_ATTRIBS),
    ("interleaved", glw::GL_INTERLEAVED_ATTRIBS),
];
/// The three GLES 3 supports; upstream keeps the strip/fan/loop entries commented out.
const PRIMITIVE_TYPES: [(&str, GLenum); 3] = [
    ("points", glw::GL_POINTS),
    ("lines", glw::GL_LINES),
    ("triangles", glw::GL_TRIANGLES),
];
const INTERP_MODES: [(&str, Interpolation); 3] = [
    ("smooth", Interpolation::Smooth),
    ("flat", Interpolation::Flat),
    ("centroid", Interpolation::Centroid),
];

fn add_case(group: &mut TestCaseGroup, name: String, buffer_mode: GLenum, primitive_type: GLenum, kind: CaseKind) {
    group.add_child(Box::new(TransformFeedbackCase {
        name,
        buffer_mode,
        primitive_type,
        kind,
    }) as Box<dyn TestCase>);
}

/// The `basic_types`/`array`/`array_element` groups, which differ only in which
/// `CaseKind` they build.
fn add_typed_group(
    parent: &mut TestCaseGroup,
    name: &str,
    make_kind: fn(DataType, Precision, Interpolation) -> CaseKind,
) {
    let mut group = TestCaseGroup::new(name);

    for (mode_name, buffer_mode) in BUFFER_MODES {
        let mut mode_group = TestCaseGroup::new(mode_name);

        for (primitive_name, primitive_type) in PRIMITIVE_TYPES {
            let mut primitive_group = TestCaseGroup::new(primitive_name);

            for ty in BASIC_TYPES {
                let is_float = ty.scalar_type() == DataType::Float;

                for precision in PRECISIONS {
                    let case_name = format!("{}_{}", precision.name(), ty.name());
                    let interp = if is_float {
                        Interpolation::Smooth
                    } else {
                        Interpolation::Flat
                    };
                    add_case(
                        &mut primitive_group,
                        case_name,
                        buffer_mode,
                        primitive_type,
                        make_kind(ty, precision, interp),
                    );
                }
            }

            mode_group.add_child(primitive_group);
        }

        group.add_child(mode_group);
    }

    parent.add_child(group);
}

/// The `random` and `random_full_array_capture` groups.
fn add_random_group(parent: &mut TestCaseGroup, name: &str, element_capture: bool) {
    let mut group = TestCaseGroup::new(name);

    for (mode_name, buffer_mode) in BUFFER_MODES {
        let mut mode_group = TestCaseGroup::new(mode_name);

        for (primitive_name, primitive_type) in PRIMITIVE_TYPES {
            let mut primitive_group = TestCaseGroup::new(primitive_name);

            for ndx in 0..10 {
                let seed =
                    de_int32_hash(buffer_mode as i32) ^ de_int32_hash(primitive_type as i32) ^ de_int32_hash(ndx);
                add_case(
                    &mut primitive_group,
                    (ndx + 1).to_string(),
                    buffer_mode,
                    primitive_type,
                    CaseKind::Random(seed, element_capture),
                );
            }

            mode_group.add_child(primitive_group);
        }

        group.add_child(mode_group);
    }

    parent.add_child(group);
}

/// `TransformFeedbackTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback");

    // .position
    {
        let mut position_group = TestCaseGroup::new("position");
        for (primitive_name, primitive_type) in PRIMITIVE_TYPES {
            for (mode_name, buffer_mode) in BUFFER_MODES {
                add_case(
                    &mut position_group,
                    format!("{primitive_name}_{mode_name}"),
                    buffer_mode,
                    primitive_type,
                    CaseKind::Position,
                );
            }
        }
        group.add_child(position_group);
    }

    // .point_size
    {
        let mut point_size_group = TestCaseGroup::new("point_size");
        for (primitive_name, primitive_type) in PRIMITIVE_TYPES {
            for (mode_name, buffer_mode) in BUFFER_MODES {
                add_case(
                    &mut point_size_group,
                    format!("{primitive_name}_{mode_name}"),
                    buffer_mode,
                    primitive_type,
                    CaseKind::PointSize,
                );
            }
        }
        group.add_child(point_size_group);
    }

    add_typed_group(&mut group, "basic_types", CaseKind::BasicType);
    add_typed_group(&mut group, "array", CaseKind::BasicArray);
    add_typed_group(&mut group, "array_element", CaseKind::ArrayElement);

    // .interpolation
    {
        let mut interpolation_group = TestCaseGroup::new("interpolation");
        for (interp_name, interp) in INTERP_MODES {
            let mut mode_group = TestCaseGroup::new(interp_name);

            for precision in PRECISIONS {
                for (primitive_name, primitive_type) in PRIMITIVE_TYPES {
                    for (mode_name, buffer_mode) in BUFFER_MODES {
                        add_case(
                            &mut mode_group,
                            format!("{}_vec4_{primitive_name}_{mode_name}", precision.name()),
                            buffer_mode,
                            primitive_type,
                            CaseKind::BasicType(DataType::FloatVec4, precision, interp),
                        );
                    }
                }
            }

            interpolation_group.add_child(mode_group);
        }
        group.add_child(interpolation_group);
    }

    add_random_group(&mut group, "random", true);
    add_random_group(&mut group, "random_full_array_capture", false);

    group
}
