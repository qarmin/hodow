// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsVertexArrayTests.cpp  (ContextShaderProgram, ContextArrayPack)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `ContextArrayPack` owns the `ContextArray`s of one `sglr::Context` and draws them with the
// one generated program. Like `draw_test::AttributePack` it takes the context per call rather
// than keeping a reference, and has an explicit `destroy`. `GLU_EXPECT_NO_ERROR` becomes an
// `Err(String)` from `render` (upstream throws `glu::Error`, which `MultiVertexArrayTest`
// turns into a compatibility warning for unaligned cases).

use super::array::{OutputType, Primitive, Storage};
use super::context_array::ContextArray;
use crate::glu::shader_util::DataType;
use crate::glu::{ContextType, GlslVersion};
use crate::glw;
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
use crate::sglr::context::Context;
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::surface::Surface;
use crate::tcu::vector::{IVec4, UVec4, Vec4};

/// `ContextShaderProgram::mapOutputType`
fn map_output_type(type_: OutputType) -> GenericVecType {
    match type_ {
        OutputType::Float | OutputType::Vec2 | OutputType::Vec3 | OutputType::Vec4 => GenericVecType::Float,
        OutputType::Int | OutputType::IVec2 | OutputType::IVec3 | OutputType::IVec4 => GenericVecType::Int32,
        OutputType::Uint | OutputType::UVec2 | OutputType::UVec3 | OutputType::UVec4 => GenericVecType::Uint32,
    }
}

/// The two strings `genVertexSource`/`genFragmentSource` pick per GLSL version, plus the
/// header they share.
struct ShaderParams {
    vtx_in: &'static str,
    vtx_out: &'static str,
    frag_in: &'static str,
    frag_color: &'static str,
    vtx_hdr: &'static str,
    frag_hdr: &'static str,
}

fn shader_params(context_type: ContextType) -> ShaderParams {
    match context_type.glsl_version() {
        GlslVersion::Es100 => ShaderParams {
            vtx_in: "attribute",
            vtx_out: "varying",
            frag_in: "varying",
            frag_color: "gl_FragColor",
            vtx_hdr: "",
            frag_hdr: "",
        },
        GlslVersion::Es300 | GlslVersion::Es310 | GlslVersion::Es320 => ShaderParams {
            vtx_in: "in",
            vtx_out: "out",
            frag_in: "in",
            frag_color: "dEQP_FragColor",
            vtx_hdr: "#version 300 es\n",
            frag_hdr: "#version 300 es\nlayout(location = 0) out mediump vec4 dEQP_FragColor;\n",
        },
        desktop => unreachable!("{desktop:?}: the desktop branch of this helper is not ported"),
    }
}

/// `ContextShaderProgram::genVertexSource`
fn gen_vertex_source(context_type: ContextType, arrays: &[&ContextArray]) -> String {
    let params = shader_params(context_type);
    let mut src = String::new();

    src.push_str(params.vtx_hdr);

    for array in arrays {
        src.push_str(&format!(
            "{} highp {} a_{};\n",
            params.vtx_in,
            array.output_type().to_str(),
            array.attrib_ndx()
        ));
    }

    src.push_str(&format!(
        "uniform highp float u_coordScale;\n\
         uniform highp float u_colorScale;\n\
         {} mediump vec4 v_color;\n\
         void main(void)\n\
         {{\n\
         \tgl_PointSize = 1.0;\n\
         \thighp vec2 coord = vec2(1.0, 1.0);\n\
         \thighp vec3 color = vec3(1.0, 1.0, 1.0);\n",
        params.vtx_out
    ));

    for array in arrays {
        let ndx = array.attrib_ndx();

        if ndx == 0 {
            match array.output_type() {
                OutputType::Float => src.push_str("\tcoord = vec2(a_0);\n"),
                OutputType::Vec2 => src.push_str("\tcoord = a_0.xy;\n"),
                OutputType::Vec3 => src.push_str("\tcoord = a_0.xy;\n\tcoord.x = coord.x + a_0.z;\n"),
                OutputType::Vec4 => src.push_str("\tcoord = a_0.xy;\n\tcoord += a_0.zw;\n"),
                OutputType::IVec2 | OutputType::UVec2 => src.push_str("\tcoord = vec2(a_0.xy);\n"),
                OutputType::IVec3 | OutputType::UVec3 => {
                    src.push_str("\tcoord = vec2(a_0.xy);\n\tcoord.x = coord.x + float(a_0.z);\n")
                }
                OutputType::IVec4 | OutputType::UVec4 => {
                    src.push_str("\tcoord = vec2(a_0.xy);\n\tcoord += vec2(a_0.zw);\n")
                }
                OutputType::Int | OutputType::Uint => unreachable!("ContextShaderProgram: scalar integer position"),
            }
            continue;
        }

        match array.output_type() {
            OutputType::Float => src.push_str(&format!("\tcolor = color * a_{ndx};\n")),
            OutputType::Vec2 => src.push_str(&format!("\tcolor.rg = color.rg * a_{ndx}.xy;\n")),
            OutputType::Vec3 => src.push_str(&format!("\tcolor = color.rgb * a_{ndx}.xyz;\n")),
            OutputType::Vec4 => src.push_str(&format!("\tcolor = color.rgb * a_{ndx}.xyz * a_{ndx}.w;\n")),
            other => unreachable!("ContextShaderProgram: output type {other:?} used as a colour"),
        }
    }

    src.push_str(
        "\tv_color = vec4(u_colorScale * color, 1.0);\n\
         \tgl_Position = vec4(u_coordScale * coord, 1.0, 1.0);\n\
         }\n",
    );

    src
}

/// `ContextShaderProgram::genFragmentSource`
fn gen_fragment_source(context_type: ContextType) -> String {
    let params = shader_params(context_type);
    format!(
        "{}{} mediump vec4 v_color;\nvoid main(void)\n{{\n\t{} = v_color;\n}}\n",
        params.frag_hdr, params.frag_in, params.frag_color
    )
}

/// `calcShaderColorCoord<T>`, taking the attribute already converted to `float` the way every
/// use of it does (`(float)attribValue.x()`).
fn calc_shader_color_coord(
    coord: &mut [f32; 2],
    color: &mut [f32; 3],
    a: [f32; 4],
    is_coordinate: bool,
    num_components: i32,
) {
    if is_coordinate {
        match num_components {
            1 => *coord = [a[0], a[0]],
            2 => *coord = [a[0], a[1]],
            3 => *coord = [a[0] + a[2], a[1]],
            4 => *coord = [a[0] + a[2], a[1] + a[3]],
            _ => unreachable!("calcShaderColorCoord: component count is always 1..=4"),
        }
    } else {
        match num_components {
            1 => {
                for c in color.iter_mut() {
                    *c *= a[0];
                }
            }
            2 => {
                color[0] *= a[0];
                color[1] *= a[1];
            }
            3 => {
                color[0] *= a[0];
                color[1] *= a[1];
                color[2] *= a[2];
            }
            4 => {
                color[0] = color[0] * a[0] * a[3];
                color[1] = color[1] * a[1] * a[3];
                color[2] = color[2] * a[2] * a[3];
            }
            _ => unreachable!("calcShaderColorCoord: component count is always 1..=4"),
        }
    }
}

/// `ContextShaderProgram`
struct ContextShaderProgram {
    base: ShaderProgramBase,
    component_count: Vec<i32>,
    attr_type: Vec<GenericVecType>,
}

impl ContextShaderProgram {
    fn new(context_type: ContextType, arrays: &[&ContextArray]) -> Self {
        let mut decl = pdec::ShaderProgramDeclaration::new();
        for (array_ndx, array) in arrays.iter().enumerate() {
            decl = decl.vertex_attribute(pdec::VertexAttribute::new(
                format!("a_{array_ndx}"),
                map_output_type(array.output_type()),
            ));
        }
        let decl = decl
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source(gen_vertex_source(context_type, arrays))
            .fragment_source(gen_fragment_source(context_type))
            .uniform(pdec::Uniform::new("u_coordScale", DataType::Float))
            .uniform(pdec::Uniform::new("u_colorScale", DataType::Float));

        Self {
            base: ShaderProgramBase::new(&decl),
            component_count: arrays.iter().map(|a| a.output_type().component_count()).collect(),
            attr_type: arrays.iter().map(|a| map_output_type(a.output_type())).collect(),
        }
    }
}

impl VertexShader for ContextShaderProgram {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        let u_coord_scale = self.base.uniform_by_name("u_coordScale").value.as_f32();
        let u_color_scale = self.base.uniform_by_name("u_colorScale").value.as_f32();

        const VARYING_LOC_COLOR: usize = 0;

        for packet in packets.iter_mut() {
            let mut coord = [1.0f32, 1.0];
            let mut color = [1.0f32, 1.0, 1.0];

            for (attrib_ndx, &attr_type) in self.attr_type.iter().enumerate() {
                let num_components = self.component_count[attrib_ndx];
                let attrib = &inputs[attrib_ndx];

                let value: [f32; 4] = match attr_type {
                    GenericVecType::Float => {
                        let mut v = Vec4::splat(0.0);
                        // SAFETY: the attribute was bound by the case before the draw call.
                        unsafe { read_vertex_attrib_float(&mut v, attrib, packet.instance_ndx, packet.vertex_ndx, 0) };
                        [v.x(), v.y(), v.z(), v.w()]
                    }
                    GenericVecType::Int32 => {
                        let mut v = IVec4::new(0, 0, 0, 1);
                        // SAFETY: as above.
                        unsafe { read_vertex_attrib_int(&mut v, attrib, packet.instance_ndx, packet.vertex_ndx, 0) };
                        [v.x() as f32, v.y() as f32, v.z() as f32, v.w() as f32]
                    }
                    GenericVecType::Uint32 => {
                        let mut v = UVec4::new(0, 0, 0, 1);
                        // SAFETY: as above.
                        unsafe { read_vertex_attrib_uint(&mut v, attrib, packet.instance_ndx, packet.vertex_ndx, 0) };
                        [v.x() as f32, v.y() as f32, v.z() as f32, v.w() as f32]
                    }
                };

                calc_shader_color_coord(&mut coord, &mut color, value, attrib_ndx == 0, num_components);
            }

            // Transform position
            packet.position = Vec4::new(u_coord_scale * coord[0], u_coord_scale * coord[1], 1.0, 1.0);

            // Pass color to FS
            packet.outputs[VARYING_LOC_COLOR] = GenericVec4::from_float(Vec4::new(
                u_color_scale * color[0],
                u_color_scale * color[1],
                u_color_scale * color[2],
                1.0,
            ));
        }
    }
}

impl FragmentShader for ContextShaderProgram {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        const VARYING_LOC_COLOR: i32 = 0;

        if packets.is_empty() {
            return;
        }

        // Triangles are flatshaded
        // SAFETY: the context was set up by the renderer for exactly these packets.
        let color = unsafe { read_varying(&packets[0], context, VARYING_LOC_COLOR, 0) };

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4 {
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, GenericVec4::from_float(color))
                };
            }
        }
    }
}

impl ShaderProgram for ContextShaderProgram {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}

/// `GLU_EXPECT_NO_ERROR`
fn expect_no_error(ctx: &mut dyn Context, message: &str) -> Result<(), String> {
    let error = ctx.get_error();
    if error != glw::GL_NO_ERROR {
        return Err(format!("{message} returned {}", glw::error_name(error)));
    }
    Ok(())
}

/// `ContextArrayPack`
pub struct ContextArrayPack {
    context_type: ContextType,
    arrays: Vec<ContextArray>,
    screen: Surface,
}

impl ContextArrayPack {
    /// `ContextArrayPack::ContextArrayPack` - `render_target_width/height` are the render
    /// target's own size, capped at 512 here as upstream does.
    pub fn new(context_type: ContextType, render_target_width: i32, render_target_height: i32) -> Self {
        Self {
            context_type,
            arrays: Vec::new(),
            screen: Surface::new(render_target_width.min(512), render_target_height.min(512)),
        }
    }

    /// `~ContextArrayPack`
    pub fn destroy(self, ctx: &mut dyn Context) {
        for array in self.arrays {
            array.destroy(ctx);
        }
    }

    /// `ContextArrayPack::getArrayCount`
    pub fn array_count(&self) -> usize {
        self.arrays.len()
    }

    /// `ContextArrayPack::getArray`
    pub fn array_mut(&mut self, i: usize) -> &mut ContextArray {
        &mut self.arrays[i]
    }

    /// `ContextArrayPack::newArray`
    pub fn new_array(&mut self, ctx: &mut dyn Context, storage: Storage) {
        self.arrays.push(ContextArray::new(ctx, storage));
    }

    /// `ContextArrayPack::getSurface`
    pub fn surface(&self) -> &Surface {
        &self.screen
    }

    /// `ContextArrayPack::render`
    #[allow(clippy::too_many_arguments)]
    pub fn render(
        &mut self,
        ctx: &mut dyn Context,
        primitive: Primitive,
        first_vertex: i32,
        vertex_count: i32,
        use_vao: bool,
        coord_scale: f32,
        color_scale: f32,
    ) -> Result<(), String> {
        let (width, height) = (self.screen.get_width(), self.screen.get_height());

        ctx.viewport(0, 0, width, height);
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        let array_refs: Vec<&ContextArray> = self.arrays.iter().collect();
        let program = ctx.create_program(Box::new(ContextShaderProgram::new(self.context_type, &array_refs)));

        ctx.use_program(program);
        expect_no_error(ctx, "glUseProgram()")?;

        let loc = ctx.get_uniform_location(program, "u_coordScale");
        ctx.uniform1f(loc, coord_scale);
        let loc = ctx.get_uniform_location(program, "u_colorScale");
        ctx.uniform1f(loc, color_scale);

        let mut vao_id = [0u32; 1];
        if use_vao {
            ctx.gen_vertex_arrays(&mut vao_id);
            ctx.bind_vertex_array(vao_id[0]);
        }

        for array in &self.arrays {
            if array.is_bound() {
                let name = format!("a_{}", array.attrib_ndx());
                let loc = ctx.get_attrib_location(program, &name) as u32;
                ctx.enable_vertex_attrib_array(loc);
                expect_no_error(ctx, "glEnableVertexAttribArray()")?;

                array.gl_bind(ctx, loc);
            }
        }

        debug_assert_eq!(first_vertex % 6, 0);
        ctx.draw_arrays(primitive.to_gl(), first_vertex, vertex_count - first_vertex);
        expect_no_error(ctx, "glDrawArrays()")?;

        for array in &self.arrays {
            if array.is_bound() {
                let name = format!("a_{}", array.attrib_ndx());
                let loc = ctx.get_attrib_location(program, &name) as u32;

                ctx.disable_vertex_attrib_array(loc);
                expect_no_error(ctx, "glDisableVertexAttribArray()")?;
            }
        }

        if use_vao {
            ctx.delete_vertex_arrays(&vao_id);
        }

        ctx.delete_program(program);
        ctx.use_program(0);
        ctx.read_pixels(&mut self.screen, 0, 0, width, height);
        Ok(())
    }
}
