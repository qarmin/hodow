// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsRandomShaderProgram.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// sglr-rsg adaptation: an `sglr::ShaderProgram` whose GLSL source is a generated `rsg` vertex +
// fragment shader pair and whose reference path interprets the same shaders.
//
// Deviations from upstream, all forced by the rsg port's shape:
//  - Upstream has one `rsg::ExecutionContext` for both stages. `VariableId` is a bare index into the
//    `VariableManager` that allocated it, and each shader has its own, so the two stages here get an
//    execution context and a manager each (`ShaderExec`). Data only ever crosses stages through the
//    rr packets, as upstream's does too, so nothing is lost; uniforms are refreshed into both
//    contexts by name.
//  - The unified uniform list is by name (`compute_unified_uniforms`), for the same reason.
//  - The executed state sits behind `Rc<RefCell<..>>` because `shade_vertices`/`shade_fragments` are
//    `&self` while `rsg::Shader::execute` needs `&mut`. `duplicate` hands out a second program over the
//    same state, standing in for upstream's one `RandomShaderProgram*` given to two contexts.
//  - The `NameAllocator` a `VariableManager` borrows and the (always empty, no textures here) sampler
//    maps are leaked per program: a manager that outlives its generator needs a `'static` borrow.

use std::cell::{Ref, RefCell};
use std::collections::HashSet;
use std::rc::Rc;

use crate::glu::shader_util::DataType;
use crate::rr::fragment_packet::{FragmentPacket, NUM_FRAGMENTS_PER_PACKET};
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::rsg::execution_context::{EXEC_VEC_WIDTH, ExecutionContext};
use crate::rsg::name_allocator::NameAllocator;
use crate::rsg::samplers::{Sampler2DMap, SamplerCubeMap};
use crate::rsg::shader::{Shader, ShaderInput};
use crate::rsg::utils::compute_random_value;
use crate::rsg::variable_manager::{VariableId, VariableManager};
use crate::rsg::variable_type::{Type, VariableType};
use crate::rsg::variable_value::{ValueAccess, ValueRange, ValueStorage};
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, UniformValue, pdec};
use crate::tcu::TestError;
use crate::tcu::random::Random;
use crate::tcu::vector::Vec4;

/// One entry of `rsg::computeUnifiedUniforms`: a uniform both stages may declare, keyed by name.
pub struct UnifiedUniform {
    pub name: String,
    pub value_range: ValueRange,
}

impl UnifiedUniform {
    pub fn get_type(&self) -> &VariableType {
        self.value_range.get_type()
    }
}

/// `rsg::computeUnifiedUniforms` - vertex uniforms first, then the fragment uniforms whose name was not seen yet.
pub fn compute_unified_uniforms(vertex_shader: &Shader, fragment_shader: &Shader) -> Vec<UnifiedUniform> {
    let mut seen: HashSet<String> = HashSet::new();
    let mut uniforms = Vec::new();

    for shader in [vertex_shader, fragment_shader] {
        for uniform in shader.get_uniforms() {
            if seen.insert(uniform.get_name().to_string()) {
                uniforms.push(UnifiedUniform {
                    name: uniform.get_name().to_string(),
                    value_range: ValueRange::from_access(&uniform.get_value_range()),
                });
            }
        }
    }

    uniforms
}

/// A `rsg::VariableValue` for a unified uniform (the variable itself is not needed, only its name and type).
pub struct UniformAssignment {
    pub name: String,
    pub type_: VariableType,
    pub storage: ValueStorage,
}

/// `rsg::computeUniformValues`
pub fn compute_uniform_values(rnd: &mut Random, uniforms: &[UnifiedUniform]) -> Vec<UniformAssignment> {
    uniforms
        .iter()
        .map(|uniform| {
            let type_ = uniform.get_type().clone();
            let mut storage = ValueStorage::with_type(1, &type_);
            compute_random_value(rnd, storage.get_value(&type_), &uniform.value_range.as_const_access());
            UniformAssignment {
                name: uniform.name.clone(),
                type_,
                storage,
            }
        })
        .collect()
}

fn map_to_generic_vec_type(var_type: &VariableType) -> GenericVecType {
    if var_type.is_float_or_vec() {
        GenericVecType::Float
    } else if var_type.is_int_or_vec() {
        GenericVecType::Int32
    } else {
        panic!("RandomShaderProgram: vertex attribute type is neither float nor int")
    }
}

fn map_to_basic_type(var_type: &VariableType) -> DataType {
    if var_type.is_float_or_vec() || var_type.is_int_or_vec() || var_type.is_bool_or_vec() {
        let num_comps = var_type.num_elements();
        assert!(
            (1..=4).contains(&num_comps),
            "RandomShaderProgram: uniform with {num_comps} components"
        );
        let ndx = (num_comps - 1) as usize;

        if var_type.is_float_or_vec() {
            [
                DataType::Float,
                DataType::FloatVec2,
                DataType::FloatVec3,
                DataType::FloatVec4,
            ][ndx]
        } else if var_type.is_int_or_vec() {
            [DataType::Int, DataType::IntVec2, DataType::IntVec3, DataType::IntVec4][ndx]
        } else {
            [
                DataType::Bool,
                DataType::BoolVec2,
                DataType::BoolVec3,
                DataType::BoolVec4,
            ][ndx]
        }
    } else if var_type.base_type() == Type::Sampler2D {
        DataType::Sampler2D
    } else if var_type.base_type() == Type::SamplerCube {
        DataType::SamplerCube
    } else {
        panic!("RandomShaderProgram: unsupported uniform type")
    }
}

fn generate_program_declaration(
    vertex_shader: &Shader,
    fragment_shader: &Shader,
    unified_uniforms: &[UnifiedUniform],
) -> pdec::ShaderProgramDeclaration {
    let mut decl = pdec::ShaderProgramDeclaration::new()
        .vertex_source(vertex_shader.get_source().to_string())
        .fragment_source(fragment_shader.get_source().to_string());

    for vertex_input in vertex_shader.get_inputs() {
        let type_ = vertex_input.get_value_range().get_type().clone();
        decl = decl.vertex_attribute(pdec::VertexAttribute::new(
            vertex_input.get_name().to_string(),
            map_to_generic_vec_type(&type_),
        ));
    }

    for fragment_input in fragment_shader.get_inputs() {
        let type_ = fragment_input.get_value_range().get_type().clone();
        decl = decl.vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(map_to_generic_vec_type(&type_)));
    }

    for uniform in unified_uniforms {
        decl = decl.uniform(pdec::Uniform::new(
            uniform.name.clone(),
            map_to_basic_type(uniform.get_type()),
        ));
    }

    decl.fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
}

/// One stage: the generated shader, the manager its `VariableId`s resolve against, and its execution state.
struct ShaderExec {
    shader: Shader,
    vars: VariableManager<'static>,
    ctx: ExecutionContext<'static>,
}

impl ShaderExec {
    fn new(mut shader: Shader) -> Self {
        let name_allocator: &'static mut NameAllocator = Box::leak(Box::new(NameAllocator::new()));
        let samplers_2d: &'static Sampler2DMap<'static> = Box::leak(Box::new(Sampler2DMap::new()));
        let samplers_cube: &'static SamplerCubeMap<'static> = Box::leak(Box::new(SamplerCubeMap::new()));
        let vars = VariableManager::from_variables(name_allocator, shader.take_variables());
        let ctx = ExecutionContext::new(samplers_2d, samplers_cube);
        Self { shader, vars, ctx }
    }

    fn find_output_by_name(&self, name: &str) -> Option<VariableId> {
        self.shader
            .get_outputs(&self.vars)
            .into_iter()
            .find(|&id| self.vars.get_variable(id).get_name() == name)
    }

    fn find_output_by_location(&self, location: i32) -> Option<VariableId> {
        self.shader.get_outputs(&self.vars).into_iter().find(|&id| {
            let variable = self.vars.get_variable(id);
            variable.has_layout_location() && variable.get_layout_location() == location
        })
    }

    fn variable_type(&self, id: VariableId) -> VariableType {
        self.vars.get_variable(id).get_type().clone()
    }

    /// `RandomShaderProgram::refreshUniforms` for the uniforms this stage declares.
    fn refresh_uniforms(&mut self, base: &ShaderProgramBase) {
        let uniforms: Vec<(VariableId, String, VariableType)> = self
            .shader
            .get_uniforms()
            .iter()
            .map(|u| {
                (
                    u.get_variable(),
                    u.get_name().to_string(),
                    u.get_value_range().get_type().clone(),
                )
            })
            .collect();

        for (id, name, type_) in uniforms {
            let Some(slot) = base.uniforms().iter().find(|slot| slot.name == name) else {
                continue;
            };

            let mut tmp = ValueStorage::with_type(1, &type_);
            write_uniform_value(tmp.get_value(&type_), &slot.value);
            let src = tmp.get_value_const(&type_).value();
            self.ctx.get_value(id, &type_).assign_from(&src);
        }
    }
}

/// Writes a `UniformSlot` value into a stride-1 rsg value of the matching shape.
fn write_uniform_value(mut access: ValueAccess<'_>, value: &UniformValue) {
    let floats: Option<Vec<f32>> = match value {
        UniformValue::F32(v) => Some(vec![*v]),
        UniformValue::F32Vec2(v) => Some(v.to_vec()),
        UniformValue::F32Vec3(v) => Some(v.to_vec()),
        UniformValue::F32Vec4(v) => Some(v.to_vec()),
        _ => None,
    };
    let ints: Option<Vec<i32>> = match value {
        UniformValue::I32(v) => Some(vec![*v]),
        UniformValue::I32Vec2(v) => Some(v.to_vec()),
        UniformValue::I32Vec3(v) => Some(v.to_vec()),
        UniformValue::I32Vec4(v) => Some(v.to_vec()),
        _ => None,
    };

    match access.get_type().base_type() {
        Type::Float => {
            for (ndx, &v) in floats.iter().flatten().enumerate() {
                access.component(ndx as i32).set_float(v);
            }
        }
        Type::Int | Type::Sampler2D | Type::SamplerCube => {
            for (ndx, &v) in ints.iter().flatten().enumerate() {
                access.component(ndx as i32).set_int(v);
            }
        }
        Type::Bool => {
            for (ndx, &v) in ints.iter().flatten().enumerate() {
                access.component(ndx as i32).set_bool(v != 0);
            }
        }
        _ => panic!("RandomShaderProgram: unsupported uniform type"),
    }
}

struct SharedState {
    vertex: ShaderExec,
    fragment: ShaderExec,
    position_var: VariableId,
    /// Other vertex outputs in the order they are passed to the fragment shader.
    vertex_outputs: Vec<VariableId>,
    frag_color_var: VariableId,
}

/// `gls::RandomShaderProgram`
pub struct RandomShaderProgram {
    base: ShaderProgramBase,
    state: Rc<RefCell<SharedState>>,
}

impl RandomShaderProgram {
    /// Takes the shader pair by value (see the top note); `unified_uniforms` is `compute_unified_uniforms`' result.
    pub fn new(
        vertex_shader: Shader,
        fragment_shader: Shader,
        unified_uniforms: &[UnifiedUniform],
    ) -> Result<Self, TestError> {
        let base = ShaderProgramBase::new(&generate_program_declaration(
            &vertex_shader,
            &fragment_shader,
            unified_uniforms,
        ));
        let vertex = ShaderExec::new(vertex_shader);
        let fragment = ShaderExec::new(fragment_shader);

        let internal = |what: &str| TestError::InternalError(format!("RandomShaderProgram: {what}"));

        let position_var = vertex
            .find_output_by_name("gl_Position")
            .ok_or_else(|| internal("no gl_Position output"))?;
        let position_type = vertex.variable_type(position_var);
        if position_type.base_type() != Type::Float || position_type.num_elements() != 4 {
            return Err(internal("gl_Position is not a vec4"));
        }

        let frag_color_var = fragment
            .find_output_by_location(0)
            .ok_or_else(|| internal("no fragment output at location 0"))?;
        let frag_color_type = fragment.variable_type(frag_color_var);
        if frag_color_type.base_type() != Type::Float || frag_color_type.num_elements() != 4 {
            return Err(internal("fragment colour output is not a vec4"));
        }

        let mut vertex_outputs = Vec::new();
        for fragment_input in fragment.shader.get_inputs() {
            let output = vertex
                .find_output_by_name(fragment_input.get_name())
                .ok_or_else(|| internal("fragment input without a matching vertex output"))?;
            vertex_outputs.push(output);
        }

        Ok(Self {
            base,
            state: Rc::new(RefCell::new(SharedState {
                vertex,
                fragment,
                position_var,
                vertex_outputs,
                frag_color_var,
            })),
        })
    }

    /// A second program over the same shaders, for the second `sglr::Context` (upstream hands one pointer to both).
    pub fn duplicate(&self) -> Self {
        Self {
            base: self.base.clone(),
            state: Rc::clone(&self.state),
        }
    }

    /// `m_vertexShader.getInputs()` - must not be held across a draw, which borrows the state mutably.
    pub fn vertex_inputs(&self) -> Ref<'_, [ShaderInput]> {
        Ref::map(self.state.borrow(), |state| state.vertex.shader.get_inputs())
    }
}

impl VertexShader for RandomShaderProgram {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        let mut guard = self.state.borrow_mut();
        let state = &mut *guard;
        let position_var = state.position_var;
        let vertex = &mut state.vertex;

        vertex.refresh_uniforms(&self.base);

        let attribs: Vec<(VariableId, VariableType)> = vertex
            .shader
            .get_inputs()
            .iter()
            .map(|input| (input.get_variable(), input.get_value_range().get_type().clone()))
            .collect();
        let position_type = vertex.variable_type(position_var);
        let output_vars: Vec<(VariableId, VariableType)> = state
            .vertex_outputs
            .iter()
            .map(|&id| (id, vertex.variable_type(id)))
            .collect();

        let num_packets = packets.len();
        let mut packet_offset = 0;

        while packet_offset < num_packets {
            let num_to_execute = (num_packets - packet_offset).min(EXEC_VEC_WIDTH);

            // Fetch attributes.
            for (attrib_ndx, (id, type_)) in attribs.iter().enumerate() {
                let num_components = type_.num_elements();
                debug_assert!(type_.is_float_or_vec() && (1..=4).contains(&num_components));
                let mut access = vertex.ctx.get_value(*id, type_);

                for ndx in 0..num_to_execute {
                    let packet = &packets[ndx + packet_offset];
                    let mut attrib_value = Vec4::splat(0.0);
                    // SAFETY: the attribute was bound by the case before the draw call.
                    unsafe {
                        read_vertex_attrib_float(
                            &mut attrib_value,
                            &inputs[attrib_ndx],
                            packet.instance_ndx,
                            packet.vertex_ndx,
                            0,
                        )
                    };

                    for c in 0..num_components {
                        access.component(c).set_float_at(ndx, attrib_value[c as usize]);
                    }
                }
            }

            vertex.shader.execute(&vertex.vars, &mut vertex.ctx);

            // Store position.
            {
                let access = vertex.ctx.get_value(position_var, &position_type).into_const();

                for ndx in 0..num_to_execute {
                    let packet = &mut packets[ndx + packet_offset];
                    packet.position = Vec4::new(
                        access.component(0).as_float_at(ndx),
                        access.component(1).as_float_at(ndx),
                        access.component(2).as_float_at(ndx),
                        access.component(3).as_float_at(ndx),
                    );
                }
            }

            // Other varyings.
            for (var_ndx, (id, type_)) in output_vars.iter().enumerate() {
                let num_components = type_.num_elements();
                debug_assert!(type_.is_float_or_vec() && (1..=4).contains(&num_components));
                let access = vertex.ctx.get_value(*id, type_).into_const();

                for ndx in 0..num_to_execute {
                    let packet = &mut packets[ndx + packet_offset];
                    let mut dst = Vec4::splat(0.0);
                    for c in 0..num_components {
                        dst[c as usize] = access.component(c).as_float_at(ndx);
                    }
                    packet.outputs[var_ndx] = GenericVec4::from_float(dst);
                }
            }

            packet_offset += num_to_execute;
        }
    }
}

impl FragmentShader for RandomShaderProgram {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let mut guard = self.state.borrow_mut();
        let state = &mut *guard;
        let frag_color_var = state.frag_color_var;
        let fragment = &mut state.fragment;

        fragment.refresh_uniforms(&self.base);

        let varyings: Vec<(VariableId, VariableType)> = fragment
            .shader
            .get_inputs()
            .iter()
            .map(|input| (input.get_variable(), input.get_value_range().get_type().clone()))
            .collect();
        let frag_color_type = fragment.variable_type(frag_color_var);

        let num_packets = packets.len();
        let max_packets_per_exec = EXEC_VEC_WIDTH / NUM_FRAGMENTS_PER_PACKET;
        let mut packet_offset = 0;

        while packet_offset < num_packets {
            let num_packets_to_execute = (num_packets - packet_offset).min(max_packets_per_exec);

            // Interpolate varyings.
            for (var_ndx, (id, type_)) in varyings.iter().enumerate() {
                let num_components = type_.num_elements();
                debug_assert!(type_.is_float_or_vec() && (1..=4).contains(&num_components));
                let mut access = fragment.ctx.get_value(*id, type_);

                for packet_ndx in 0..num_packets_to_execute {
                    let packet = &packets[packet_offset + packet_ndx];

                    for frag_ndx in 0..NUM_FRAGMENTS_PER_PACKET {
                        // SAFETY: the context was set up by the renderer for exactly these packets.
                        let var_value = unsafe { read_varying(packet, context, var_ndx as i32, frag_ndx) };
                        let dst_ndx = packet_ndx * NUM_FRAGMENTS_PER_PACKET + frag_ndx;

                        for c in 0..num_components {
                            access.component(c).set_float_at(dst_ndx, var_value[c as usize]);
                        }
                    }
                }
            }

            fragment.shader.execute(&fragment.vars, &mut fragment.ctx);

            // Store color.
            let frag_color = fragment.ctx.get_value(frag_color_var, &frag_color_type).into_const();
            for packet_ndx in 0..num_packets_to_execute {
                for frag_ndx in 0..NUM_FRAGMENTS_PER_PACKET {
                    let src_ndx = packet_ndx * NUM_FRAGMENTS_PER_PACKET + frag_ndx;
                    let color = Vec4::new(
                        frag_color.component(0).as_float_at(src_ndx),
                        frag_color.component(1).as_float_at(src_ndx),
                        frag_color.component(2).as_float_at(src_ndx),
                        frag_color.component(3).as_float_at(src_ndx),
                    );

                    // SAFETY: the context was set up by the renderer for exactly these packets.
                    unsafe {
                        write_fragment_output(
                            context,
                            (packet_offset + packet_ndx) as i32,
                            frag_ndx as i32,
                            0,
                            GenericVec4::from_float(color),
                        )
                    };
                }
            }

            packet_offset += num_packets_to_execute;
        }
    }
}

impl ShaderProgram for RandomShaderProgram {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}
