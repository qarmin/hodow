// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDepthTests.cpp / es2fStencilTests.cpp (DepthShader, StencilShader)
//   modules/gles3/functional/es3fDepthTests.cpp / es3fStencilTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `DepthShader` and `StencilShader` are the same program - a position attribute and one
// `u_color` uniform written to every fragment - in ES 2.0 and ES 3.0 dialects; `StencilShader`
// additionally declares an unused vertex-to-fragment varying, kept behind `with_varying`.

use crate::gls::fragment_op_util::QuadRendererGlslVersion;
use crate::glu::shader_util::DataType;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context;
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::vector::Vec4;

pub struct UniformColorShader {
    base: ShaderProgramBase,
}

impl UniformColorShader {
    pub fn new(glsl: QuadRendererGlslVersion, with_varying: bool) -> Self {
        let (vertex_source, fragment_source) = match glsl {
            QuadRendererGlslVersion::Es100 => (
                "attribute highp vec4 a_position;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 }\n",
                "uniform mediump vec4 u_color;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_FragColor = u_color;\n\
                 }\n",
            ),
            QuadRendererGlslVersion::Es300 => (
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 }\n",
                "#version 300 es\n\
                 uniform highp vec4 u_color;\n\
                 layout(location = 0) out mediump vec4 o_color;\n\
                 void main (void)\n\
                 {\n\
                 \x20   o_color = u_color;\n\
                 }\n",
            ),
        };

        let mut decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float));
        if with_varying {
            decl = decl.vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float));
        }
        let decl = decl
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
            .vertex_source(vertex_source.to_string())
            .fragment_source(fragment_source.to_string());

        Self {
            base: ShaderProgramBase::new(&decl),
        }
    }
}

/// `DepthShader::setColor` / `StencilShader::setColor`
pub fn set_color(ctx: &mut dyn Context, program_id: u32, color: [f32; 4]) {
    ctx.use_program(program_id);
    let loc = ctx.get_uniform_location(program_id, "u_color");
    ctx.uniform4fv(loc, 1, &color);
}

impl VertexShader for UniformColorShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            // SAFETY: the attribute was bound by the case before the draw call.
            unsafe { read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0) };
            packet.position = position;
        }
    }
}

impl FragmentShader for UniformColorShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let c = self.base.uniform_by_name("u_color").value.as_f32_vec4();
        let color = GenericVec4::from_float(Vec4::new(c[0], c[1], c[2], c[3]));

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4 {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, color) };
            }
        }
    }
}

impl ShaderProgram for UniformColorShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}
