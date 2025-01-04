// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawIndirectInstancedTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_indirect_instanced::INDIRECT_INSTANCED;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState};
use crate::rr::renderer::{DrawCommand, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::vector::Vec4;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::draw::base_class::{DrawTestsBase, GroupParams, VertexInput, create_host_buffer};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 128;
const HEIGHT: u32 = 128;
const QUAD_GRID_SIZE: u32 = 8;

#[derive(Clone, Copy)]
struct TestParams {
    group_params: GroupParams,
    draw_count: u32,
}

/// `TestVertShader`
struct TestVertShader {
    first_instance: i32,
    inputs: [VertexInputInfo; 2],
    outputs: [VertexOutputInfo; 1],
}

impl TestVertShader {
    fn new(first_instance: i32) -> Self {
        Self {
            first_instance,
            inputs: [
                VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                },
                VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                },
            ],
            outputs: [VertexOutputInfo {
                type_: Some(GenericVecType::Float),
                flatshade: false,
            }],
        }
    }
}

impl VertexShader for TestVertShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        &self.outputs
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            // SAFETY: both attributes point at the vectors the test keeps alive across the draw.
            unsafe {
                read_vertex_attrib_float(
                    &mut position,
                    &inputs[0],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    self.first_instance,
                );
                read_vertex_attrib_float(
                    &mut color,
                    &inputs[1],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    self.first_instance,
                );
            }
            packet.position = position;
            packet.outputs[0] = GenericVec4::from_float(color);
        }
    }
}

/// `TestFragShader`
struct TestFragShader {
    inputs: [FragmentInputInfo; 1],
    outputs: [FragmentOutputInfo; 1],
}

impl TestFragShader {
    fn new() -> Self {
        Self {
            inputs: [FragmentInputInfo {
                type_: Some(GenericVecType::Float),
                flatshade: false,
            }],
            outputs: [FragmentOutputInfo {
                type_: Some(GenericVecType::Float),
            }],
        }
    }
}

impl FragmentShader for TestFragShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        &self.outputs
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
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

struct DrawIndirectInstancedCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for DrawIndirectInstancedCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `DrawIndirectInstancedCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().draw_indirect_first_instance == vk::FALSE {
            return Err(TestError::NotSupported(
                "drawIndirectFirstInstance feature not supported by the device".to_string(),
            ));
        }

        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if self.params.draw_count > 1 {
            if context.get_device_features().multi_draw_indirect == vk::FALSE {
                return Err(TestError::NotSupported(
                    "multiDrawIndirect feature not supported by the device".to_string(),
                ));
            }

            if context.get_device_properties().limits.max_draw_indirect_count < self.params.draw_count {
                return Err(TestError::NotSupported("maxDrawIndirectCount too low".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        INDIRECT_INSTANCED.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawIndirectInstancedInstance {
            context,
            params: self.params,
        })
    }
}

/// `DrawIndirectInstancedInstance`. Its pipeline, target and command buffers are the base class's here,
/// with the two-binding vertex input this test declares.
struct DrawIndirectInstancedInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `DrawIndirectInstancedInstance::prepareVertexData`
fn prepare_vertex_data(instance_count: i32, first_instance: i32) -> (Vec<[f32; 4]>, Vec<[f32; 4]>) {
    let mut vertex_position = Vec::new();
    let mut instanced_color = Vec::new();

    for y in 0..QUAD_GRID_SIZE {
        for x in 0..QUAD_GRID_SIZE {
            let grid = QUAD_GRID_SIZE as f32;
            let fx0 = -1.0 + (x as f32) / grid * 2.0 / instance_count as f32;
            let fx1 = -1.0 + ((x + 1) as f32) / grid * 2.0 / instance_count as f32;
            let fy0 = -1.0 + (y as f32) / grid * 2.0;
            let fy1 = -1.0 + ((y + 1) as f32) / grid * 2.0;

            // Vertices of a quad's lower-left triangle: (fx0, fy0), (fx1, fy0) and (fx0, fy1)
            vertex_position.push([fx0, fy0, 1.0, 1.0]);
            vertex_position.push([fx1, fy0, 1.0, 1.0]);
            vertex_position.push([fx0, fy1, 1.0, 1.0]);
        }
    }

    for i in 0..instance_count + first_instance {
        instanced_color.push([i as f32 / (instance_count + first_instance) as f32, 0.0, 0.0, 1.0]);
    }
    (vertex_position, instanced_color)
}

impl TestInstance for DrawIndirectInstancedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let mut failed = false;

        let base = DrawTestsBase::new_with_input(
            context,
            "vert",
            "frag",
            self.params.group_params,
            vk::PrimitiveTopology::TRIANGLE_LIST,
            1,
            WIDTH,
            HEIGHT,
            VertexInput::Custom {
                bindings: vec![
                    vk::VertexInputBindingDescription {
                        binding: 0,
                        stride: 16,
                        input_rate: vk::VertexInputRate::VERTEX,
                    },
                    vk::VertexInputBindingDescription {
                        binding: 1,
                        stride: 16,
                        input_rate: vk::VertexInputRate::INSTANCE,
                    },
                ],
                attributes: vec![
                    vk::VertexInputAttributeDescription {
                        location: 0,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                    },
                    vk::VertexInputAttributeDescription {
                        location: 1,
                        binding: 1,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                    },
                ],
            },
        )?;

        let instance_counts = [0u32, 1, 2, 4, 20];
        let first_instance_indices = [1u32, 3, 4, 20];

        for instance_count in instance_counts {
            for first_instance in first_instance_indices {
                let draw_count = self.params.draw_count;
                let prepare_count = (first_instance + instance_count * draw_count).max(1);

                let (vertex_position, instanced_color) =
                    prepare_vertex_data(prepare_count as i32, first_instance as i32);
                let vertex_count = vertex_position.len() as u32 / draw_count;

                let draw_commands: Vec<vk::DrawIndirectCommand> = (0..draw_count)
                    .map(|i| vk::DrawIndirectCommand {
                        vertex_count,
                        instance_count,
                        first_vertex: vertex_count * i,
                        first_instance,
                    })
                    .collect();

                let vertex_buffer = create_host_buffer(context, &vertex_position, vk::BufferUsageFlags::VERTEX_BUFFER)?;
                let instanced_vertex_buffer =
                    create_host_buffer(context, &instanced_color, vk::BufferUsageFlags::VERTEX_BUFFER)?;
                let indirect_buffer =
                    create_host_buffer(context, &draw_commands, vk::BufferUsageFlags::INDIRECT_BUFFER)?;

                base.record_and_submit(queue, |cmd_buffer| {
                    // `DrawIndirectInstancedInstance::draw`; the pipeline is bound by `record_and_submit`.
                    unsafe {
                        device.cmd_bind_vertex_buffers(
                            cmd_buffer,
                            0,
                            &[vertex_buffer.get(), instanced_vertex_buffer.get()],
                            &[0, 0],
                        );
                        device.cmd_draw_indirect(
                            cmd_buffer,
                            indirect_buffer.get(),
                            0,
                            draw_count,
                            std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
                        );
                    }
                    Ok(())
                })?;

                // Reference rendering
                let mut ref_image = TextureLevel::new(
                    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
                    WIDTH,
                    HEIGHT,
                    1,
                )?;
                {
                    let mut access = ref_image.get_access();
                    for y in 0..HEIGHT {
                        for x in 0..WIDTH {
                            access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
                        }
                    }
                }

                {
                    let vert_shader = TestVertShader::new(first_instance as i32);
                    let frag_shader = TestFragShader::new();
                    let program = Program {
                        vertex_shader: &vert_shader,
                        fragment_shader: &frag_shader,
                        geometry_shader: None,
                    };
                    let mut render_target = RenderTarget::new(as_multisample_view(ref_image.get_access()), None, None);
                    let render_state = RenderState::new(
                        ViewportState::from_target_size(WIDTH as i32, HEIGHT as i32),
                        context.get_device_properties().limits.sub_pixel_precision_bits as i32,
                    );
                    let renderer = Renderer::new();

                    let vertex_attribs = [
                        VertexAttrib::from_pointer(
                            VertexAttribType::Float,
                            4,
                            16,
                            0,
                            vertex_position.as_ptr().cast::<u8>(),
                        ),
                        VertexAttrib::from_pointer(
                            VertexAttribType::Float,
                            4,
                            16,
                            1,
                            instanced_color.as_ptr().cast::<u8>(),
                        ),
                    ];

                    let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, vertex_position.len(), 0);
                    let command = DrawCommand {
                        state: &render_state,
                        program: &program,
                        vertex_attribs: &vertex_attribs,
                        primitives: &primitives,
                    };
                    renderer.draw_instanced(&command, &mut render_target, instance_count as i32);
                }

                let rendered_frame = base.read_color_surface(queue, vk::ImageLayout::GENERAL)?;

                if fuzzy_compare_ok(&ref_image.get_const_access(), &rendered_frame.get_const_access(), 0.05)
                    != Some(true)
                {
                    failed = true;
                }
            }
        }

        Ok(if failed {
            TestStatus::fail("Fail")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

/// `createIndirectInstancedTests`
pub fn create_indirect_instanced_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indirect_instanced");

    for (draw_count, name) in [(1, "1"), (2, "2"), (4, "4"), (16, "16")] {
        group.add_child(Box::new(DrawIndirectInstancedCase {
            name,
            params: TestParams {
                group_params,
                draw_count,
            },
        }) as Box<dyn TestCase>);
    }
    group
}
