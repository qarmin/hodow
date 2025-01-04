// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fInstancedRenderingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// No rasterised reference is needed: each instance draws one full-height vertical bar in a
// flat colour, so `compute_reference` fills the same bars on the host and the comparison is
// `tcu::fuzzyCompare` at 0.05. What the case is actually about is which instance a colour
// came from - `gl_InstanceID`, an attribute divisor, or both at once.

use crate::glu::shader_util::DataType;
use crate::glu::{self, ApiCase, ProgramSources, ShaderProgram, TestCaseGroup, add_api_case};
use crate::glw::{self, GLuint};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::Vec4;
use crate::tcu::{Random, de_string_hash};

const MAX_RENDER_WIDTH: i32 = 128;
const MAX_RENDER_HEIGHT: i32 = 128;
const QUAD_GRID_SIZE: i32 = 127;

/// Attribute divisors for the attributes defining the colour's RGB components.
const ATTRIB_DIVISOR_R: i32 = 3;
const ATTRIB_DIVISOR_G: i32 = 2;
const ATTRIB_DIVISOR_B: i32 = 1;

/// Affects whether a float or a vecN is used in the shader, but only the first component
/// is ever non-zero.
const OFFSET_COMPONENTS: i32 = 3;

/// Scale and bias when converting float to integer, for an integer-typed attribute.
const FLOAT_INT_SCALE: f32 = 100.0;
const FLOAT_INT_BIAS: f32 = -50.0;
const FLOAT_UINT_SCALE: f32 = 100.0;
const FLOAT_UINT_BIAS: f32 = 0.0;

/// `InstancedRenderingCase::DrawFunction`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawFunction {
    DrawArraysInstanced,
    DrawElementsInstanced,
}

/// `InstancedRenderingCase::InstancingType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum InstancingType {
    InstanceId,
    AttribDivisor,
    Mixed,
}

/// `InstancedRenderingCase`'s constructor arguments.
#[derive(Clone, Copy)]
struct CaseSpec {
    function: DrawFunction,
    instancing_type: InstancingType,
    /// Instance attribute type, colour components only; the position offset attribute is
    /// always float or vecN.
    rgb_attr_type: DataType,
    num_instances: i32,
}

/// `VarComp`, upstream's four-byte union - the attribute data is uploaded as raw words
/// whatever the shader reads them as.
fn var_comp(spec: CaseSpec, val: f32) -> u32 {
    let t = spec.rgb_attr_type;
    if t.is_float_or_vec() || t.is_matrix() {
        val.to_bits()
    } else if t.is_int_or_ivec() {
        ((val * FLOAT_INT_SCALE + FLOAT_INT_BIAS) as i32) as u32
    } else if t.is_uint_or_uvec() {
        (val * FLOAT_UINT_SCALE + FLOAT_UINT_BIAS) as u32
    } else {
        panic!("{} is not an attribute type this group declares", t.name())
    }
}

/// The instance-count ceiling upstream spells inline for each colour component.
fn divided_instances(num_instances: i32, divisor: i32) -> i32 {
    num_instances / divisor + if num_instances % divisor == 0 { 0 } else { 1 }
}

/// `InstancedRenderingCase::init`'s vertex shader.
fn vertex_shader_source(spec: CaseSpec) -> String {
    let t = spec.rgb_attr_type;
    let is_float_case = t.is_float_or_vec();
    let is_int_case = t.is_int_or_ivec();
    let is_uint_case = t.is_uint_or_uvec();
    let is_mat_case = t.is_matrix();
    let type_size = t.scalar_size();
    let swizzle_first = if type_size == 1 { "" } else { ".x" };
    let type_name = t.name();

    let float_int_scale_str = format!("({FLOAT_INT_SCALE:.3})");
    let float_int_bias_str = format!("({FLOAT_INT_BIAS:.3})");
    let float_uint_scale_str = format!("({FLOAT_UINT_SCALE:.3})");
    let float_uint_bias_str = format!("({FLOAT_UINT_BIAS:.3})");
    let num_instances_str = format!("{}.0", spec.num_instances);

    let mut instance_attribs = String::new();
    let mut pos_expression = String::new();
    let mut color_r_expression = String::new();
    let mut color_g_expression = String::new();
    let mut color_b_expression = String::new();

    if spec.instancing_type == InstancingType::InstanceId || spec.instancing_type == InstancingType::Mixed {
        pos_expression = format!("a_position + vec4(float(gl_InstanceID) * 2.0 / {num_instances_str}, 0.0, 0.0, 0.0)");
        color_r_expression = format!("float(gl_InstanceID)/{num_instances_str}");

        if spec.instancing_type == InstancingType::InstanceId {
            color_g_expression = format!("float(gl_InstanceID)*2.0/{num_instances_str}");
            color_b_expression = format!("1.0 - float(gl_InstanceID)/{num_instances_str}");
        }
    }

    if spec.instancing_type == InstancingType::AttribDivisor || spec.instancing_type == InstancingType::Mixed {
        if spec.instancing_type == InstancingType::AttribDivisor {
            pos_expression = String::from("a_position + vec4(a_instanceOffset");
            for _ in 0..4 - OFFSET_COMPONENTS {
                pos_expression.push_str(", 0.0");
            }
            pos_expression.push(')');

            color_r_expression = if is_float_case {
                format!("a_instanceR{swizzle_first}")
            } else if is_int_case {
                format!("(float(a_instanceR{swizzle_first}) - {float_int_bias_str}) / {float_int_scale_str}")
            } else if is_uint_case {
                format!("(float(a_instanceR{swizzle_first}) - {float_uint_bias_str}) / {float_uint_scale_str}")
            } else {
                String::from("a_instanceR[0][0]")
            };

            let offset_type = if OFFSET_COMPONENTS == 1 {
                String::from("float")
            } else {
                format!("vec{OFFSET_COMPONENTS}")
            };
            instance_attribs.push_str(&format!("in highp {offset_type} a_instanceOffset;\n"));
            instance_attribs.push_str(&format!("in mediump {type_name} a_instanceR;\n"));
        }

        if is_float_case {
            color_g_expression = format!("a_instanceG{swizzle_first}");
            color_b_expression = format!("a_instanceB{swizzle_first}");
        } else if is_int_case {
            color_g_expression =
                format!("(float(a_instanceG{swizzle_first}) - {float_int_bias_str}) / {float_int_scale_str}");
            color_b_expression =
                format!("(float(a_instanceB{swizzle_first}) - {float_int_bias_str}) / {float_int_scale_str}");
        } else if is_uint_case {
            color_g_expression =
                format!("(float(a_instanceG{swizzle_first}) - {float_uint_bias_str}) / {float_uint_scale_str}");
            color_b_expression =
                format!("(float(a_instanceB{swizzle_first}) - {float_uint_bias_str}) / {float_uint_scale_str}");
        } else {
            assert!(
                is_mat_case,
                "{} is not an attribute type this group declares",
                type_name
            );
            color_g_expression = String::from("a_instanceG[0][0]");
            color_b_expression = String::from("a_instanceB[0][0]");
        }

        instance_attribs.push_str(&format!("in mediump {type_name} a_instanceG;\n"));
        instance_attribs.push_str(&format!("in mediump {type_name} a_instanceB;\n"));
    }

    format!(
        "#version 300 es\n\
         in highp vec4 a_position;\n\
         {instance_attribs}\
         out mediump vec4 v_color;\n\
         \n\
         void main()\n\
         {{\n\
         \x20   gl_Position = {pos_expression};\n\
         \x20   v_color.r = {color_r_expression};\n\
         \x20   v_color.g = {color_g_expression};\n\
         \x20   v_color.b = {color_b_expression};\n\
         \x20   v_color.a = 1.0;\n\
         }}\n"
    )
}

/// `FRAG_SHADER_SOURCE`
const FRAG_SHADER_SOURCE: &str = "#version 300 es\n\
                                  layout(location = 0) out mediump vec4 o_color;\n\
                                  in mediump vec4 v_color;\n\
                                  \n\
                                  void main()\n\
                                  {\n\
                                  \x20   o_color = v_color;\n\
                                  }\n";

/// The vertex and instance data `InstancedRenderingCase::init` builds.
struct CaseData {
    /// X and Y components per vertex.
    grid_vertex_positions: Vec<f32>,
    /// Only used if the function is `DrawElementsInstanced`.
    grid_indices: Vec<u16>,
    instance_offsets: Vec<f32>,
    instance_color_r: Vec<u32>,
    instance_color_g: Vec<u32>,
    instance_color_b: Vec<u32>,
}

/// The vertex-attribute half of `InstancedRenderingCase::init`.
fn build_case_data(spec: CaseSpec) -> CaseData {
    let mut data = CaseData {
        grid_vertex_positions: Vec::new(),
        grid_indices: Vec::new(),
        instance_offsets: Vec::new(),
        instance_color_r: Vec::new(),
        instance_color_g: Vec::new(),
        instance_color_b: Vec::new(),
    };
    let type_size = spec.rgb_attr_type.scalar_size();

    if spec.function == DrawFunction::DrawElementsInstanced {
        // Vertex positions. Positions form a vertical bar of width
        // <screen width>/<number of instances>.
        for y in 0..QUAD_GRID_SIZE + 1 {
            for x in 0..QUAD_GRID_SIZE + 1 {
                let fx = -1.0 + x as f32 / QUAD_GRID_SIZE as f32 * 2.0 / spec.num_instances as f32;
                let fy = -1.0 + y as f32 / QUAD_GRID_SIZE as f32 * 2.0;
                data.grid_vertex_positions.push(fx);
                data.grid_vertex_positions.push(fy);
            }
        }

        for y in 0..QUAD_GRID_SIZE {
            for x in 0..QUAD_GRID_SIZE {
                let ndx00 = (y * (QUAD_GRID_SIZE + 1) + x) as u16;
                let ndx10 = (y * (QUAD_GRID_SIZE + 1) + x + 1) as u16;
                let ndx01 = ((y + 1) * (QUAD_GRID_SIZE + 1) + x) as u16;
                let ndx11 = ((y + 1) * (QUAD_GRID_SIZE + 1) + x + 1) as u16;

                // Lower-left triangle of a quad.
                data.grid_indices.extend_from_slice(&[ndx00, ndx10, ndx01]);
                // Upper-right triangle of a quad.
                data.grid_indices.extend_from_slice(&[ndx11, ndx01, ndx10]);
            }
        }
    } else {
        for y in 0..QUAD_GRID_SIZE {
            for x in 0..QUAD_GRID_SIZE {
                let fx0 = -1.0 + x as f32 / QUAD_GRID_SIZE as f32 * 2.0 / spec.num_instances as f32;
                let fx1 = -1.0 + (x + 1) as f32 / QUAD_GRID_SIZE as f32 * 2.0 / spec.num_instances as f32;
                let fy0 = -1.0 + y as f32 / QUAD_GRID_SIZE as f32 * 2.0;
                let fy1 = -1.0 + (y + 1) as f32 / QUAD_GRID_SIZE as f32 * 2.0;

                // Lower-left triangle, then upper-right triangle.
                data.grid_vertex_positions
                    .extend_from_slice(&[fx0, fy0, fx1, fy0, fx0, fy1]);
                data.grid_vertex_positions
                    .extend_from_slice(&[fx1, fy1, fx0, fy1, fx1, fy0]);
            }
        }
    }

    if spec.instancing_type == InstancingType::AttribDivisor || spec.instancing_type == InstancingType::Mixed {
        if spec.instancing_type == InstancingType::AttribDivisor {
            // Offsets are such that the vertical bars are drawn next to each other.
            for i in 0..spec.num_instances {
                data.instance_offsets.push(i as f32 * 2.0 / spec.num_instances as f32);
                for _ in 0..OFFSET_COMPONENTS - 1 {
                    data.instance_offsets.push(0.0);
                }
            }

            let r_instances = divided_instances(spec.num_instances, ATTRIB_DIVISOR_R);
            for i in 0..r_instances {
                data.instance_color_r
                    .push(var_comp(spec, i as f32 / r_instances as f32));
                for _ in 0..type_size - 1 {
                    data.instance_color_r.push(var_comp(spec, 0.0));
                }
            }
        }

        let g_instances = divided_instances(spec.num_instances, ATTRIB_DIVISOR_G);
        for i in 0..g_instances {
            data.instance_color_g
                .push(var_comp(spec, i as f32 * 2.0 / g_instances as f32));
            for _ in 0..type_size - 1 {
                data.instance_color_g.push(var_comp(spec, 0.0));
            }
        }

        let b_instances = divided_instances(spec.num_instances, ATTRIB_DIVISOR_B);
        for i in 0..b_instances {
            data.instance_color_b
                .push(var_comp(spec, 1.0 - i as f32 / b_instances as f32));
            for _ in 0..type_size - 1 {
                data.instance_color_b.push(var_comp(spec, 0.0));
            }
        }
    }

    data
}

/// `InstancedRenderingCase::setupVarAttribPointer`
///
/// # Safety
/// A current context, and `attr_ptr` alive until the draw that follows.
unsafe fn setup_var_attrib_pointer(
    gl: &glw::Functions,
    spec: CaseSpec,
    attr_ptr: *const u32,
    location: i32,
    divisor: i32,
) {
    let t = spec.rgb_attr_type;
    let type_size = t.scalar_size();
    // A matrix uses as many attribute slots as it has columns.
    let num_slots = if t.is_matrix() { t.matrix_num_columns() } else { 1 };

    // SAFETY: the caller keeps the data alive, and every location came from the program.
    unsafe {
        for slot_ndx in 0..num_slots {
            let cur_loc = (location + slot_ndx) as u32;

            gl.enable_vertex_attrib_array(cur_loc);
            gl.vertex_attrib_divisor(cur_loc, divisor as u32);

            if t.is_float_or_vec() {
                gl.vertex_attrib_pointer(cur_loc, type_size, glw::GL_FLOAT, glw::FALSE, 0, attr_ptr.cast());
            } else if t.is_int_or_ivec() {
                gl.vertex_attrib_i_pointer(cur_loc, type_size, glw::GL_INT, 0, attr_ptr.cast());
            } else if t.is_uint_or_uvec() {
                gl.vertex_attrib_i_pointer(cur_loc, type_size, glw::GL_UNSIGNED_INT, 0, attr_ptr.cast());
            } else {
                // Upstream hands every column slot the same base pointer, and only
                // element [0][0] is read back.
                let num_rows = t.matrix_num_rows();
                let num_cols = t.matrix_num_columns();
                let stride = num_cols * num_rows * std::mem::size_of::<f32>() as i32;
                gl.vertex_attrib_pointer(cur_loc, num_rows, glw::GL_FLOAT, glw::FALSE, stride, attr_ptr.cast());
            }
        }
    }
}

/// `InstancedRenderingCase::setupAndRender`
///
/// # Safety
/// A current context and a linked program whose attributes are the ones named here.
unsafe fn setup_and_render(gl: &glw::Functions, spec: CaseSpec, program: GLuint, data: &CaseData) {
    // SAFETY: every client-side array outlives the draw below.
    unsafe {
        gl.use_program(program);

        // The position attribute is non-instanced.
        let position_loc = gl.get_attrib_location(program, c"a_position".as_ptr()) as u32;
        gl.enable_vertex_attrib_array(position_loc);
        gl.vertex_attrib_pointer(
            position_loc,
            2,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            data.grid_vertex_positions.as_ptr().cast(),
        );

        if spec.instancing_type == InstancingType::AttribDivisor || spec.instancing_type == InstancingType::Mixed {
            if spec.instancing_type == InstancingType::AttribDivisor {
                // The position offset attribute is instanced with a separate offset per
                // instance.
                let offset_loc = gl.get_attrib_location(program, c"a_instanceOffset".as_ptr()) as u32;
                gl.enable_vertex_attrib_array(offset_loc);
                gl.vertex_attrib_divisor(offset_loc, 1);
                gl.vertex_attrib_pointer(
                    offset_loc,
                    OFFSET_COMPONENTS,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    0,
                    data.instance_offsets.as_ptr().cast(),
                );

                let r_loc = gl.get_attrib_location(program, c"a_instanceR".as_ptr());
                setup_var_attrib_pointer(gl, spec, data.instance_color_r.as_ptr(), r_loc, ATTRIB_DIVISOR_R);
            }

            let g_loc = gl.get_attrib_location(program, c"a_instanceG".as_ptr());
            setup_var_attrib_pointer(gl, spec, data.instance_color_g.as_ptr(), g_loc, ATTRIB_DIVISOR_G);

            let b_loc = gl.get_attrib_location(program, c"a_instanceB".as_ptr());
            setup_var_attrib_pointer(gl, spec, data.instance_color_b.as_ptr(), b_loc, ATTRIB_DIVISOR_B);
        }

        if spec.function == DrawFunction::DrawArraysInstanced {
            const NUM_POSITION_COMPONENTS: usize = 2;
            gl.draw_arrays_instanced(
                glw::GL_TRIANGLES,
                0,
                (data.grid_vertex_positions.len() / NUM_POSITION_COMPONENTS) as i32,
                spec.num_instances,
            );
        } else {
            gl.draw_elements_instanced(
                glw::GL_TRIANGLES,
                data.grid_indices.len() as i32,
                glw::GL_UNSIGNED_SHORT,
                data.grid_indices.as_ptr().cast(),
                spec.num_instances,
            );
        }

        gl.use_program(0);
    }
}

/// `InstancedRenderingCase::computeReference` - one flat vertical bar per instance.
fn compute_reference(spec: CaseSpec, dst: &mut Surface) {
    let wid = dst.get_width();
    let hei = dst.get_height();
    let t = spec.rgb_attr_type;

    for instance_ndx in 0..spec.num_instances {
        let x_start = instance_ndx * wid / spec.num_instances;
        let x_end = (instance_ndx + 1) * wid / spec.num_instances;

        // Emulate attribute divisors if that is the case.
        let clr_ndx_r = if spec.instancing_type == InstancingType::AttribDivisor {
            instance_ndx / ATTRIB_DIVISOR_R
        } else {
            instance_ndx
        };
        let divided =
            spec.instancing_type == InstancingType::AttribDivisor || spec.instancing_type == InstancingType::Mixed;
        let clr_ndx_g = if divided {
            instance_ndx / ATTRIB_DIVISOR_G
        } else {
            instance_ndx
        };
        let clr_ndx_b = if divided {
            instance_ndx / ATTRIB_DIVISOR_B
        } else {
            instance_ndx
        };

        let r_instances = if spec.instancing_type == InstancingType::AttribDivisor {
            divided_instances(spec.num_instances, ATTRIB_DIVISOR_R)
        } else {
            spec.num_instances
        };
        let g_instances = if divided {
            divided_instances(spec.num_instances, ATTRIB_DIVISOR_G)
        } else {
            spec.num_instances
        };
        let b_instances = if divided {
            divided_instances(spec.num_instances, ATTRIB_DIVISOR_B)
        } else {
            spec.num_instances
        };

        let mut r = clr_ndx_r as f32 / r_instances as f32;
        let mut g = clr_ndx_g as f32 * 2.0 / g_instances as f32;
        let mut b = 1.0 - clr_ndx_b as f32 / b_instances as f32;

        // Convert to integer and back if the shader inputs are integers.
        if t.is_int_or_ivec() {
            let round =
                |v: f32| (((v * FLOAT_INT_SCALE + FLOAT_INT_BIAS) as i32) as f32 - FLOAT_INT_BIAS) / FLOAT_INT_SCALE;
            r = round(r);
            g = round(g);
            b = round(b);
        } else if t.is_uint_or_uvec() {
            let round = |v: f32| {
                ((((v * FLOAT_UINT_SCALE + FLOAT_UINT_BIAS) as i32) as u32) as f32 - FLOAT_UINT_BIAS) / FLOAT_UINT_SCALE
            };
            r = round(r);
            g = round(g);
            b = round(b);
        }

        for y in 0..hei {
            for x in x_start..x_end {
                dst.set_pixel(x, y, RGBA::from_vec(Vec4::from_array([r, g, b, 1.0])));
            }
        }
    }
}

/// `InstancedRenderingCase::iterate`
fn instanced_rendering_case(case: &mut ApiCase<'_>, spec: CaseSpec, seed: u32) {
    let program = ShaderProgram::new(
        case.gl(),
        &ProgramSources::vtx_frag(vertex_shader_source(spec), FRAG_SHADER_SOURCE),
    );
    if !program.is_ok() {
        case.fail("Failed to compile shader".to_string(), "Failed to compile shader");
        return;
    }

    let data = build_case_data(spec);
    let context = case.context();
    let gl = case.gl();
    let target = context.render_target();
    let width = target.width.min(MAX_RENDER_WIDTH);
    let height = target.height.min(MAX_RENDER_HEIGHT);
    let mut rnd = Random::new(seed);
    let x_offset = rnd.get_int(0, target.width - width);
    let y_offset = rnd.get_int(0, target.height - height);

    let mut reference_img = Surface::new(width, height);
    let mut result_img = Surface::new(width, height);

    // Draw result.
    // SAFETY: a linked program and client-side arrays that outlive the draw.
    unsafe {
        gl.viewport(x_offset, y_offset, width, height);
        setup_and_render(gl, spec, program.program(), &data);
    }

    if let Err(e) = glu::read_pixels(
        &context.render_context,
        x_offset,
        y_offset,
        &mut result_img.get_access(),
    ) {
        case.fail(e.to_string(), "Fail");
        return;
    }

    // Compute reference.
    compute_reference(spec, &mut reference_img);

    // Compare.
    let test_ok =
        fuzzy_compare_ok(&reference_img.get_const_access(), &result_img.get_const_access(), 0.05).unwrap_or(false);
    if !test_ok {
        case.fail("Image comparison failed".to_string(), "Fail");
    }
}

fn add_case(group: &mut TestCaseGroup, name: String, spec: CaseSpec) {
    // `de::Random rnd(deStringHash(getName()))` - the case's own name is its rng seed.
    let seed = de_string_hash(&name);
    add_api_case(group, name, move |case: &mut ApiCase<'_>| {
        instanced_rendering_case(case, spec, seed)
    });
}

/// `InstancedRenderingTests::init`
pub fn create_tests() -> TestCaseGroup {
    /// `instanceCounts`
    const INSTANCE_COUNTS: [i32; 4] = [1, 2, 4, 20];
    /// `s_testTypes`
    const TEST_TYPES: [DataType; 21] = [
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
    const TYPE_TEST_NUM_INSTANCES: i32 = 4;

    let mut group = TestCaseGroup::new("instanced");

    // Cases testing function, instancing method and instance count.
    for (function, function_name) in [
        (DrawFunction::DrawArraysInstanced, "draw_arrays_instanced"),
        (DrawFunction::DrawElementsInstanced, "draw_elements_instanced"),
    ] {
        let mut function_group = TestCaseGroup::new(function_name);

        for (instancing_type, instancing_type_name) in [
            (InstancingType::InstanceId, "instance_id"),
            (InstancingType::AttribDivisor, "attribute_divisor"),
            (InstancingType::Mixed, "mixed"),
        ] {
            let mut instancing_type_group = TestCaseGroup::new(instancing_type_name);

            for num_instances in INSTANCE_COUNTS {
                add_case(
                    &mut instancing_type_group,
                    format!("{num_instances}_instances"),
                    CaseSpec {
                        function,
                        instancing_type,
                        rgb_attr_type: DataType::Float,
                        num_instances,
                    },
                );
            }

            function_group.add_child(instancing_type_group);
        }

        group.add_child(function_group);
    }

    // Data type specific cases.
    {
        let mut types_group = TestCaseGroup::new("types");

        for type_ in TEST_TYPES {
            add_case(
                &mut types_group,
                type_.name().to_string(),
                CaseSpec {
                    function: DrawFunction::DrawArraysInstanced,
                    instancing_type: InstancingType::AttribDivisor,
                    rgb_attr_type: type_,
                    num_instances: TYPE_TEST_NUM_INSTANCES,
                },
            );
        }

        group.add_child(types_group);
    }

    group
}
