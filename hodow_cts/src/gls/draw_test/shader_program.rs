// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp  (deqp::gls::DrawTestShaderProgram, anonymous-namespace)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `DrawTestShaderProgram` is the one GLSL program every `DrawTest` iteration compiles:
// one `a_<N>` input per `AttributeArray` the test declared, folded into a single
// `coord`/`color` pair the same way regardless of how many attributes or what their
// types are - a position-tagged attribute (`AttributeArray::is_position_attribute`)
// accumulates into `coord`, every other attribute multiplies into `color`. It runs
// identically through `sglr::GLContext` (the GLSL source) and `sglr::ReferenceContext`
// (`shade_vertices`/`shade_fragments` below, which must compute *exactly* the same
// thing the generated GLSL does - that is the whole point of the comparison this file
// exists to drive).
//
// **`generateShaderParams`'s desktop-GL branches (`GLSL_VERSION_430`/`GLSL_VERSION_330`)
// are not ported.** This port's `glu::GlslVersion` is ES-only (`Es100`/`Es300`/`Es310`/
// `Es320` - confirmed by reading `glu::render_context`'s own enum, same narrowing
// `spec.rs`'s own top doc comment already recorded for `DrawTestSpec::Target`/
// `CompatibilityTestType`), so those two upstream branches are unreachable here by
// construction, not by an added check. `ContextType::glsl_version()` (already ported,
// `glu/render_context.rs`) is exactly upstream's `isGLSLVersionSupported(type, ...)`
// chain collapsed to one match: an ES 3.0/3.1/3.2 context all take the "300 es" shader
// text (a `#version 300 es`-headed shader compiles unchanged under a newer ES context -
// the directive names the *shading language* version, not the context's own), so they
// share upstream's own single branch here too.
//
// `calcShaderColorCoord<T>`'s one C++ template over `tcu::Vector<T, 4>` becomes one
// Rust generic over `T: Copy` plus a `to_f32: impl Fn(T) -> f32` conversion closure
// passed in by the caller (`Vector<T, 4>::x()`/`y()`/`z()`/`w()` are already generic
// over any `Copy` `T`, so the only per-type behaviour this needs is the cast upstream
// spells `(float)attribValue.x()` at every call site) - the three call sites in
// `shade_vertices` below pass the identity closure for `f32`, `|x| x as f32` for `i32`
// and `u32`.

use super::attribute_array::AttributeArray;
use super::spec::OutputType;
use crate::glu::shader_util::DataType;
use crate::glu::{ContextType, GlslVersion};
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{
    VertexAttrib, read_vertex_attrib_float, read_vertex_attrib_int, read_vertex_attrib_uint,
};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::string_template::StringTemplate;
use crate::tcu::vector::{IVec4, UVec4, Vec2, Vec3, Vec4, Vector};

/// `DrawTestShaderProgram::mapOutputType`
fn map_output_type(output_type: OutputType) -> GenericVecType {
    if output_type.is_float_type() {
        GenericVecType::Float
    } else if output_type.is_int_type() {
        GenericVecType::Int32
    } else if output_type.is_uint_type() {
        GenericVecType::Uint32
    } else {
        unreachable!("OutputType::Last never appears on a real AttributeArray")
    }
}

/// The per-API-version string table `generateShaderParams` fills in upstream - kept as
/// a plain struct of `&'static str` rather than the `std::map<std::string, std::string>`
/// upstream builds, since every key here is a fixed, known-at-compile-time name.
struct ShaderParams {
    vtx_in: &'static str,
    vtx_out: &'static str,
    frag_in: &'static str,
    frag_color: &'static str,
    vtx_hdr: &'static str,
    frag_hdr: &'static str,
    col_precision: &'static str,
}

/// `DrawTestShaderProgram::generateShaderParams` - see this module's top doc comment
/// for why the desktop-GL branches have no counterpart here.
fn generate_shader_params(context_type: ContextType) -> ShaderParams {
    match context_type.glsl_version() {
        GlslVersion::Es100 => ShaderParams {
            vtx_in: "attribute",
            vtx_out: "varying",
            frag_in: "varying",
            frag_color: "gl_FragColor",
            vtx_hdr: "",
            frag_hdr: "",
            col_precision: "mediump",
        },
        GlslVersion::Es300 | GlslVersion::Es310 | GlslVersion::Es320 => ShaderParams {
            vtx_in: "in",
            vtx_out: "out",
            frag_in: "in",
            frag_color: "dEQP_FragColor",
            vtx_hdr: "#version 300 es\n",
            frag_hdr: "#version 300 es\nlayout(location = 0) out mediump vec4 dEQP_FragColor;\n",
            col_precision: "mediump",
        },
        desktop => unreachable!("{desktop:?}: the desktop branch of this helper is not ported"),
    }
}

/// `DrawTestShaderProgram::genVertexSource`
fn gen_vertex_source(context_type: ContextType, arrays: &[&AttributeArray]) -> String {
    let params = generate_shader_params(context_type);

    let mut tmpl = String::new();
    tmpl.push_str("${VTX_HDR}");

    for (array_ndx, array) in arrays.iter().enumerate() {
        tmpl.push_str(&format!(
            "${{VTX_IN}} highp {} a_{array_ndx};\n",
            array.output_type().to_glsl_type_name()
        ));
    }

    tmpl.push_str(
        "uniform highp float u_coordScale;\n\
         uniform highp float u_colorScale;\n\
         ${VTX_OUT} ${COL_PRECISION} vec4 v_color;\n\
         void main(void)\n\
         {\n\
         \tgl_PointSize = 1.0;\n\
         \thighp vec2 coord = vec2(0.0, 0.0);\n\
         \thighp vec3 color = vec3(1.0, 1.0, 1.0);\n",
    );

    for (array_ndx, array) in arrays.iter().enumerate() {
        if array.is_position_attribute() {
            match array.output_type() {
                OutputType::Float | OutputType::Int | OutputType::Uint => {
                    tmpl.push_str(&format!(
                        "\tcoord += vec2(float(a_{array_ndx}), float(a_{array_ndx}));\n"
                    ));
                }
                OutputType::Vec2 | OutputType::IVec2 | OutputType::UVec2 => {
                    tmpl.push_str(&format!("\tcoord += vec2(a_{array_ndx}.xy);\n"));
                }
                OutputType::Vec3 | OutputType::IVec3 | OutputType::UVec3 => {
                    tmpl.push_str(&format!(
                        "\tcoord += vec2(a_{array_ndx}.xy);\n\tcoord.x += float(a_{array_ndx}.z);\n"
                    ));
                }
                OutputType::Vec4 | OutputType::IVec4 | OutputType::UVec4 => {
                    tmpl.push_str(&format!(
                        "\tcoord += vec2(a_{array_ndx}.xy);\n\tcoord += vec2(a_{array_ndx}.zw);\n"
                    ));
                }
                OutputType::Last => unreachable!("OutputType::Last never appears on a real AttributeArray"),
            }
        } else {
            match array.output_type() {
                OutputType::Float | OutputType::Int | OutputType::Uint => {
                    tmpl.push_str(&format!("\tcolor = color * float(a_{array_ndx});\n"));
                }
                OutputType::Vec2 | OutputType::IVec2 | OutputType::UVec2 => {
                    tmpl.push_str(&format!("\tcolor.rg = color.rg * vec2(a_{array_ndx}.xy);\n"));
                }
                OutputType::Vec3 | OutputType::IVec3 | OutputType::UVec3 => {
                    tmpl.push_str(&format!("\tcolor = color.rgb * vec3(a_{array_ndx}.xyz);\n"));
                }
                OutputType::Vec4 | OutputType::IVec4 | OutputType::UVec4 => {
                    tmpl.push_str(&format!(
                        "\tcolor = color.rgb * vec3(a_{array_ndx}.xyz) * float(a_{array_ndx}.w);\n"
                    ));
                }
                OutputType::Last => unreachable!("OutputType::Last never appears on a real AttributeArray"),
            }
        }
    }

    tmpl.push_str(
        "\tv_color = vec4(u_colorScale * color, 1.0) * 0.5 + vec4(0.5, 0.5, 0.5, 0.5);\n\
         \tgl_Position = vec4(u_coordScale * coord, 1.0, 1.0);\n\
         }\n",
    );

    let param_list = [
        ("VTX_HDR", params.vtx_hdr.to_string()),
        ("VTX_IN", params.vtx_in.to_string()),
        ("VTX_OUT", params.vtx_out.to_string()),
        ("COL_PRECISION", params.col_precision.to_string()),
    ];
    StringTemplate::new(tmpl)
        .specialize(&param_list)
        .expect("DrawTestShaderProgram's own generated vertex template is always well-formed")
}

/// `DrawTestShaderProgram::genFragmentSource`
fn gen_fragment_source(context_type: ContextType) -> String {
    let params = generate_shader_params(context_type);
    let tmpl = "${FRAG_HDR}${FRAG_IN} ${COL_PRECISION} vec4 v_color;\n\
         void main(void)\n\
         {\n\
         \t${FRAG_COLOR} = v_color;\n\
         }\n";
    let param_list = [
        ("FRAG_HDR", params.frag_hdr.to_string()),
        ("FRAG_IN", params.frag_in.to_string()),
        ("COL_PRECISION", params.col_precision.to_string()),
        ("FRAG_COLOR", params.frag_color.to_string()),
    ];
    StringTemplate::new(tmpl)
        .specialize(&param_list)
        .expect("DrawTestShaderProgram's own fragment template is always well-formed")
}

/// `DrawTestShaderProgram::createProgramDeclaration`
fn create_program_declaration(context_type: ContextType, arrays: &[&AttributeArray]) -> pdec::ShaderProgramDeclaration {
    let mut decl = pdec::ShaderProgramDeclaration::new();
    for (array_ndx, array) in arrays.iter().enumerate() {
        let attr_type = map_output_type(array.output_type());
        decl = decl.vertex_attribute(pdec::VertexAttribute::new(format!("a_{array_ndx}"), attr_type));
    }

    decl.vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
        .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
        .vertex_source(gen_vertex_source(context_type, arrays))
        .fragment_source(gen_fragment_source(context_type))
        .uniform(pdec::Uniform::new("u_coordScale", DataType::Float))
        .uniform(pdec::Uniform::new("u_colorScale", DataType::Float))
}

/// `calcShaderColorCoord<T>` - see this module's top doc comment for why one Rust
/// generic plus a conversion closure replaces the C++ template.
fn calc_shader_color_coord<T: Copy>(
    coord: &mut Vec2,
    color: &mut Vec3,
    attrib_value: Vector<T, 4>,
    is_coordinate: bool,
    num_components: i32,
    to_f32: impl Fn(T) -> f32,
) {
    if is_coordinate {
        match num_components {
            1 => {
                let x = to_f32(attrib_value.x());
                coord.m_data[0] += x;
                coord.m_data[1] += x;
            }
            2 => {
                coord.m_data[0] += to_f32(attrib_value.x());
                coord.m_data[1] += to_f32(attrib_value.y());
            }
            3 => {
                coord.m_data[0] += to_f32(attrib_value.x()) + to_f32(attrib_value.z());
                coord.m_data[1] += to_f32(attrib_value.y());
            }
            4 => {
                coord.m_data[0] += to_f32(attrib_value.x()) + to_f32(attrib_value.z());
                coord.m_data[1] += to_f32(attrib_value.y()) + to_f32(attrib_value.w());
            }
            _ => unreachable!("DrawTestSpec::AttributeSpec component count is always 1..=4"),
        }
    } else {
        match num_components {
            1 => {
                let x = to_f32(attrib_value.x());
                color.m_data[0] *= x;
                color.m_data[1] *= x;
                color.m_data[2] *= x;
            }
            2 => {
                color.m_data[0] *= to_f32(attrib_value.x());
                color.m_data[1] *= to_f32(attrib_value.y());
            }
            3 => {
                color.m_data[0] *= to_f32(attrib_value.x());
                color.m_data[1] *= to_f32(attrib_value.y());
                color.m_data[2] *= to_f32(attrib_value.z());
            }
            4 => {
                let w = to_f32(attrib_value.w());
                color.m_data[0] *= to_f32(attrib_value.x()) * w;
                color.m_data[1] *= to_f32(attrib_value.y()) * w;
                color.m_data[2] *= to_f32(attrib_value.z()) * w;
            }
            _ => unreachable!("DrawTestSpec::AttributeSpec component count is always 1..=4"),
        }
    }
}

/// `DrawTestShaderProgram`
pub struct DrawTestShaderProgram {
    base: ShaderProgramBase,
    component_count: Vec<i32>,
    is_coord: Vec<bool>,
    attr_type: Vec<GenericVecType>,
}

impl DrawTestShaderProgram {
    /// `DrawTestShaderProgram::DrawTestShaderProgram`
    pub fn new(context_type: ContextType, arrays: &[&AttributeArray]) -> Self {
        let decl = create_program_declaration(context_type, arrays);
        let base = ShaderProgramBase::new(&decl);

        let component_count = arrays.iter().map(|a| a.output_type().component_count()).collect();
        let is_coord = arrays.iter().map(|a| a.is_position_attribute()).collect();
        let attr_type = arrays.iter().map(|a| map_output_type(a.output_type())).collect();

        Self {
            base,
            component_count,
            is_coord,
            attr_type,
        }
    }
}

impl VertexShader for DrawTestShaderProgram {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    /// `DrawTestShaderProgram::shadeVertices`
    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        let u_coord_scale = self.base.uniform_by_name("u_coordScale").value.as_f32();
        let u_color_scale = self.base.uniform_by_name("u_colorScale").value.as_f32();

        const VARYING_LOC_COLOR: usize = 0;

        for packet in packets.iter_mut() {
            let mut coord = Vec2::new(0.0, 0.0);
            let mut color = Vec3::new(1.0, 1.0, 1.0);

            for (attrib_ndx, &attr_type) in self.attr_type.iter().enumerate() {
                let num_components = self.component_count[attrib_ndx];
                let is_coord = self.is_coord[attrib_ndx];

                match attr_type {
                    GenericVecType::Float => {
                        let mut v = Vec4::splat(0.0);
                        let attrib = &inputs[attrib_ndx];
                        unsafe { read_vertex_attrib_float(&mut v, attrib, packet.instance_ndx, packet.vertex_ndx, 0) };
                        calc_shader_color_coord(&mut coord, &mut color, v, is_coord, num_components, |x| x);
                    }
                    GenericVecType::Int32 => {
                        let mut v = IVec4::new(0, 0, 0, 1);
                        let attrib = &inputs[attrib_ndx];
                        unsafe { read_vertex_attrib_int(&mut v, attrib, packet.instance_ndx, packet.vertex_ndx, 0) };
                        calc_shader_color_coord(&mut coord, &mut color, v, is_coord, num_components, |x| x as f32);
                    }
                    GenericVecType::Uint32 => {
                        let mut v = UVec4::new(0, 0, 0, 1);
                        let attrib = &inputs[attrib_ndx];
                        unsafe { read_vertex_attrib_uint(&mut v, attrib, packet.instance_ndx, packet.vertex_ndx, 0) };
                        calc_shader_color_coord(&mut coord, &mut color, v, is_coord, num_components, |x| x as f32);
                    }
                }
            }

            // Transform position.
            packet.position = Vec4::new(u_coord_scale * coord.x(), u_coord_scale * coord.y(), 1.0, 1.0);
            packet.point_size = 1.0;

            // Pass color to FS.
            let color_out = Vec4::new(
                u_color_scale * color.x(),
                u_color_scale * color.y(),
                u_color_scale * color.z(),
                1.0,
            );
            let color_out = color_out * 0.5 + Vec4::splat(0.5);
            packet.outputs[VARYING_LOC_COLOR] = GenericVec4::from_float(color_out);
        }
    }
}

impl FragmentShader for DrawTestShaderProgram {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    /// `DrawTestShaderProgram::shadeFragments`
    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        const VARYING_LOC_COLOR: i32 = 0;

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                let value = unsafe { read_varying(&packets[packet_ndx], context, VARYING_LOC_COLOR, frag_ndx) };
                let value = GenericVec4::from_float(value);
                unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx as i32, 0, value) };
            }
        }
    }
}

impl ShaderProgram for DrawTestShaderProgram {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::gls::draw_test::spec::{InputType, Storage};
    use crate::glu::render_context::ApiType;
    use crate::sglr::reference_context::ReferenceContext;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn es2() -> ContextType {
        ContextType { api: ApiType::es(2, 0) }
    }

    fn es3() -> ContextType {
        ContextType { api: ApiType::es(3, 0) }
    }

    /// Same three-line helper `attribute_array.rs`'s own tests use (see this module's
    /// top doc comment on why that's duplicated rather than exported).
    fn ctx() -> ReferenceContext {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let color = TextureLevel::new(format, 4, 4, 1).unwrap();
        ReferenceContext::new(16, color, None, 8)
    }

    #[test]
    fn map_output_type_covers_every_scalar_and_vector_kind() {
        assert_eq!(map_output_type(OutputType::Float), GenericVecType::Float);
        assert_eq!(map_output_type(OutputType::Vec3), GenericVecType::Float);
        assert_eq!(map_output_type(OutputType::Int), GenericVecType::Int32);
        assert_eq!(map_output_type(OutputType::IVec4), GenericVecType::Int32);
        assert_eq!(map_output_type(OutputType::Uint), GenericVecType::Uint32);
        assert_eq!(map_output_type(OutputType::UVec2), GenericVecType::Uint32);
    }

    #[test]
    #[should_panic(expected = "never appears on a real AttributeArray")]
    fn map_output_type_panics_on_the_last_sentinel() {
        map_output_type(OutputType::Last);
    }

    #[test]
    fn generate_shader_params_picks_the_legacy_branch_for_an_es2_context() {
        let params = generate_shader_params(es2());
        assert_eq!(params.vtx_in, "attribute");
        assert_eq!(params.frag_color, "gl_FragColor");
        assert_eq!(params.vtx_hdr, "");
    }

    #[test]
    fn generate_shader_params_picks_the_es300_branch_for_an_es3_context() {
        let params = generate_shader_params(es3());
        assert_eq!(params.vtx_in, "in");
        assert_eq!(params.frag_color, "dEQP_FragColor");
        assert_eq!(params.vtx_hdr, "#version 300 es\n");
    }

    #[test]
    fn generate_shader_params_treats_es31_the_same_as_es30() {
        let es31 = ContextType { api: ApiType::es(3, 1) };
        let es30 = generate_shader_params(es3());
        let es31p = generate_shader_params(es31);
        assert_eq!(es30.vtx_hdr, es31p.vtx_hdr);
        assert_eq!(es30.frag_color, es31p.frag_color);
    }

    #[test]
    fn gen_fragment_source_es2_uses_gl_frag_color_and_no_version_header() {
        let src = gen_fragment_source(es2());
        assert!(src.contains("gl_FragColor = v_color;"));
        assert!(!src.contains("#version"));
        assert!(src.contains("varying mediump vec4 v_color;"));
    }

    #[test]
    fn gen_fragment_source_es3_declares_an_explicit_output_and_version_header() {
        let src = gen_fragment_source(es3());
        assert!(src.starts_with("#version 300 es\n"));
        assert!(src.contains("layout(location = 0) out mediump vec4 dEQP_FragColor;"));
        assert!(src.contains("dEQP_FragColor = v_color;"));
    }

    #[test]
    fn calc_shader_color_coord_coordinate_branch_accumulates_xy_for_a_vec2() {
        let mut coord = Vec2::new(1.0, 2.0);
        let mut color = Vec3::new(1.0, 1.0, 1.0);
        let v = Vec4::new(10.0, 20.0, 30.0, 40.0);
        calc_shader_color_coord(&mut coord, &mut color, v, true, 2, |x| x);
        assert_eq!(coord.m_data, [11.0, 22.0]);
        // Color is untouched on the coordinate branch.
        assert_eq!(color.m_data, [1.0, 1.0, 1.0]);
    }

    #[test]
    fn calc_shader_color_coord_coordinate_branch_vec3_folds_z_into_x() {
        let mut coord = Vec2::new(0.0, 0.0);
        let mut color = Vec3::new(1.0, 1.0, 1.0);
        let v = Vec4::new(1.0, 2.0, 3.0, 4.0);
        calc_shader_color_coord(&mut coord, &mut color, v, true, 3, |x| x);
        // coord.x += x (1.0) + z (3.0) = 4.0; coord.y += y (2.0) = 2.0.
        assert_eq!(coord.m_data, [4.0, 2.0]);
    }

    #[test]
    fn calc_shader_color_coord_coordinate_branch_vec4_splits_xy_and_zw() {
        let mut coord = Vec2::new(0.0, 0.0);
        let mut color = Vec3::new(1.0, 1.0, 1.0);
        let v = Vec4::new(1.0, 2.0, 3.0, 4.0);
        calc_shader_color_coord(&mut coord, &mut color, v, true, 4, |x| x);
        // coord.x += x (1.0) + z (3.0) = 4.0; coord.y += y (2.0) + w (4.0) = 6.0.
        assert_eq!(coord.m_data, [4.0, 6.0]);
    }

    #[test]
    fn calc_shader_color_coord_color_branch_float_multiplies_all_three_channels() {
        let mut coord = Vec2::new(0.0, 0.0);
        let mut color = Vec3::new(2.0, 2.0, 2.0);
        let v = Vec4::new(3.0, 0.0, 0.0, 1.0);
        calc_shader_color_coord(&mut coord, &mut color, v, false, 1, |x| x);
        assert_eq!(color.m_data, [6.0, 6.0, 6.0]);
    }

    #[test]
    fn calc_shader_color_coord_color_branch_vec4_multiplies_rgb_by_w_too() {
        let mut coord = Vec2::new(0.0, 0.0);
        let mut color = Vec3::new(1.0, 1.0, 1.0);
        // x=2, y=3, z=4, w=5 -> color = (1*2*5, 1*3*5, 1*4*5) = (10, 15, 20).
        let v = Vec4::new(2.0, 3.0, 4.0, 5.0);
        calc_shader_color_coord(&mut coord, &mut color, v, false, 4, |x| x);
        assert_eq!(color.m_data, [10.0, 15.0, 20.0]);
    }

    #[test]
    fn calc_shader_color_coord_int_closure_converts_before_arithmetic() {
        let mut coord = Vec2::new(0.0, 0.0);
        let mut color = Vec3::new(1.0, 1.0, 1.0);
        let v = IVec4::new(-5, 7, 0, 1);
        calc_shader_color_coord(&mut coord, &mut color, v, true, 2, |x| x as f32);
        assert_eq!(coord.m_data, [-5.0, 7.0]);
    }

    /// `DrawTestShaderProgram::genVertexSource`, hand-expanded in full for one
    /// position attribute (`vec2`) plus one color attribute (`vec3`) under an ES3
    /// context - the exact case this module's own top doc comment's `StringTemplate`
    /// bullet calls for.
    #[test]
    fn gen_vertex_source_expands_one_position_and_one_color_attribute() {
        let mut cx = ctx();
        let mut pos = AttributeArray::new(&mut cx, Storage::User);
        pos.setup_array(
            false,
            0,
            2,
            InputType::Float,
            OutputType::Vec2,
            false,
            0,
            0,
            GenericVec4::zero(),
            true,
            false,
        );
        let mut col = AttributeArray::new(&mut cx, Storage::User);
        col.setup_array(
            false,
            0,
            3,
            InputType::Float,
            OutputType::Vec3,
            false,
            0,
            0,
            GenericVec4::zero(),
            false,
            false,
        );

        let src = gen_vertex_source(es3(), &[&pos, &col]);

        // Header and per-attribute declarations (array index 0 is the position
        // attribute, 1 is the color one, in declaration order).
        assert!(src.starts_with("#version 300 es\n"));
        assert!(src.contains("in highp vec2 a_0;\n"));
        assert!(src.contains("in highp vec3 a_1;\n"));
        assert!(src.contains("uniform highp float u_coordScale;\n"));
        assert!(src.contains("uniform highp float u_colorScale;\n"));
        assert!(src.contains("out mediump vec4 v_color;\n"));

        // Position attribute (Vec2, is_position_attribute): coord += vec2(a_0.xy).
        assert!(src.contains("\tcoord += vec2(a_0.xy);\n"));
        // Color attribute (Vec3, not a position attribute): color = color.rgb * vec3(a_1.xyz).
        assert!(src.contains("\tcolor = color.rgb * vec3(a_1.xyz);\n"));

        // Trailing varying/position assignment, identical regardless of attribute list.
        assert!(src.contains("\tv_color = vec4(u_colorScale * color, 1.0) * 0.5 + vec4(0.5, 0.5, 0.5, 0.5);\n"));
        assert!(src.contains("\tgl_Position = vec4(u_coordScale * coord, 1.0, 1.0);\n}\n"));

        pos.destroy(&mut cx);
        col.destroy(&mut cx);
    }

    #[test]
    fn gen_vertex_source_es2_uses_attribute_varying_keywords_and_no_version_header() {
        let mut cx = ctx();
        let mut pos = AttributeArray::new(&mut cx, Storage::User);
        pos.setup_array(
            false,
            0,
            4,
            InputType::Float,
            OutputType::Vec4,
            false,
            0,
            0,
            GenericVec4::zero(),
            true,
            false,
        );

        let src = gen_vertex_source(es2(), &[&pos]);

        assert!(!src.contains("#version"));
        assert!(src.contains("attribute highp vec4 a_0;\n"));
        assert!(src.contains("varying mediump vec4 v_color;\n"));
        // Vec4 position attribute: both xy and zw folded into coord.
        assert!(src.contains("\tcoord += vec2(a_0.xy);\n\tcoord += vec2(a_0.zw);\n"));

        pos.destroy(&mut cx);
    }
}
