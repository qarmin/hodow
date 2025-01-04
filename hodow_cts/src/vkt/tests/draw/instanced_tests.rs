// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawInstancedTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Samsung Electronics Co., Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `_device_address` variants use the hand-written `vk::device_address_commands`
// (vulkanalia has no VK_KHR_device_address_commands).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtVertexInputDynamicStateExtensionDeviceCommands, InstanceV1_1, KhrMaintenance5ExtensionDeviceCommands,
};

use crate::generated::shaders::draw_instanced::INSTANCED;
use crate::rr::defs::IndexType;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState};
use crate::rr::renderer::{
    DrawCommand, DrawIndices, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view,
};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::vector::Vec4;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat, UVec4};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::device_address_commands::{
    self, ADDRESS_COMMAND_FULLY_BOUND, ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE, BindIndexBuffer3Info,
    BindVertexBuffer3Info, Commands, DeviceAddressRange, DrawIndirect2Info, StridedDeviceAddressRange,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::transition_2d_image;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const QUAD_GRID_SIZE: i32 = 8;
const WIDTH: u32 = 128;
const HEIGHT: u32 = 128;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum AttributeDivisor {
    None,
    Ext,
    Khr,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawFunction {
    Draw,
    DrawIndexed,
    DrawIndirect,
    DrawIndexedIndirect,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    function: DrawFunction,
    topology: vk::PrimitiveTopology,
    group_params: GroupParams,
    test_attrib_divisor: AttributeDivisor,
    attrib_divisor: u32,
    test_multiview: bool,
    dynamic_state: bool,
    use_maintenance5_ext: bool,
    use_device_address_commands: bool,
}

impl TestParams {
    fn is_indirect_draw(&self) -> bool {
        self.function == DrawFunction::DrawIndirect || self.function == DrawFunction::DrawIndexedIndirect
    }

    fn is_indexed_draw(&self) -> bool {
        self.function == DrawFunction::DrawIndexed || self.function == DrawFunction::DrawIndexedIndirect
    }
}

/// `VertexPositionAndColor`
#[repr(C)]
#[derive(Clone, Copy)]
pub(super) struct VertexPositionAndColor {
    pub(super) position: [f32; 4],
    pub(super) color: [f32; 4],
}

/// `mapVkPrimitiveTopology`, for the topologies this group draws with.
fn map_vk_primitive_topology(topology: vk::PrimitiveTopology) -> PrimitiveType {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => PrimitiveType::Points,
        vk::PrimitiveTopology::LINE_LIST => PrimitiveType::Lines,
        vk::PrimitiveTopology::LINE_STRIP => PrimitiveType::LineStrip,
        vk::PrimitiveTopology::TRIANGLE_LIST => PrimitiveType::Triangles,
        vk::PrimitiveTopology::TRIANGLE_FAN => PrimitiveType::TriangleFan,
        vk::PrimitiveTopology::TRIANGLE_STRIP => PrimitiveType::TriangleStrip,
        _ => unreachable!("topology is not drawn by the instanced tests"),
    }
}

/// `TestVertShader`
pub(super) struct TestVertShader {
    num_instances: i32,
    first_instance: i32,
    inputs: [VertexInputInfo; 3],
    outputs: [VertexOutputInfo; 1],
}

impl TestVertShader {
    pub(super) fn new(num_instances: i32, first_instance: i32) -> Self {
        Self {
            num_instances,
            first_instance,
            inputs: [
                VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                },
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
            let instance_ndx = packet.instance_ndx + self.first_instance;
            let mut position = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            let mut color2 = Vec4::splat(0.0);
            // SAFETY: the attributes point at the vectors the test keeps alive across the draw.
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
                read_vertex_attrib_float(
                    &mut color2,
                    &inputs[2],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    self.first_instance,
                );
            }
            packet.position = position
                + Vec4::new(
                    (packet.instance_ndx as f64 * 2.0 / self.num_instances as f64) as f32,
                    0.0,
                    0.0,
                    0.0,
                );
            packet.outputs[0] = GenericVec4::from_float(
                color + Vec4::new(instance_ndx as f32 / self.num_instances as f32, 0.0, 0.0, 1.0) + color2,
            );
        }
    }
}

/// `TestFragShader`
pub(super) struct TestFragShader {
    inputs: [FragmentInputInfo; 1],
    outputs: [FragmentOutputInfo; 1],
}

impl TestFragShader {
    pub(super) fn new() -> Self {
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

struct InstancedDrawCase {
    name: String,
    params: TestParams,
}

impl TestCase for InstancedDrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `InstancedDrawCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if params.dynamic_state {
            context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
            let mut features = vk::PhysicalDeviceVertexInputDynamicStateFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.vertex_input_dynamic_state == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Implementation does not support vertexInputDynamicState".to_string(),
                ));
            }
        }

        if params.test_attrib_divisor != AttributeDivisor::None {
            let extension = if params.test_attrib_divisor == AttributeDivisor::Ext {
                "VK_EXT_vertex_attribute_divisor"
            } else {
                "VK_KHR_vertex_attribute_divisor"
            };
            context.require_device_functionality(extension)?;

            let mut features = vk::PhysicalDeviceVertexAttributeDivisorFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };

            if params.attrib_divisor != 1 && features.vertex_attribute_instance_rate_divisor == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Implementation does not support vertexAttributeInstanceRateDivisor".to_string(),
                ));
            }

            if params.attrib_divisor == 0 && features.vertex_attribute_instance_rate_zero_divisor == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Implementation does not support vertexAttributeInstanceRateDivisorZero".to_string(),
                ));
            }

            // VUID-vkCmdDraw-pNext-09461. Only the KHR properties struct carries the member.
            if context.is_device_functionality_supported("VK_KHR_vertex_attribute_divisor")
                || context.get_device_properties().api_version >= vk::make_version(1, 4, 0)
            {
                let mut properties = vk::PhysicalDeviceVertexAttributeDivisorProperties::default();
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
                if properties.supports_non_zero_first_instance == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Implementation does not support supportsNonZeroFirstInstance".to_string(),
                    ));
                }
            }
        }

        if params.test_multiview {
            context.require_device_functionality("VK_KHR_multiview")?;
            let mut features = vk::PhysicalDeviceMultiviewFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.multiview == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Implementation does not support multiview feature".to_string(),
                ));
            }
        }

        if params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if params.topology == vk::PrimitiveTopology::TRIANGLE_FAN
            && context.is_device_functionality_supported("VK_KHR_portability_subset")
        {
            let mut features = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.triangle_fans == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VK_KHR_portability_subset: Triangle fans are not supported by this implementation".to_string(),
                ));
            }
        }

        if params.use_maintenance5_ext {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if params.use_device_address_commands {
            context.require_device_functionality(device_address_commands::EXTENSION_NAME)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        INSTANCED.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InstancedDrawInstance {
            context,
            params: self.params,
        })
    }
}

/// The vertex, index and per-instance data `prepareVertexData` fills in.
struct VertexData {
    data: Vec<VertexPositionAndColor>,
    indexes: Vec<u32>,
    instanced_color: Vec<[f32; 4]>,
}

/// `InstancedDrawInstance::prepareVertexData`
fn prepare_vertex_data(
    function: DrawFunction,
    instance_count: i32,
    first_instance: i32,
    instance_divisor: i32,
) -> VertexData {
    let blue = [0.0f32, 0.0, 1.0, 1.0];
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let grid = QUAD_GRID_SIZE as f32;
    let mut data = Vec::new();
    let mut indexes = Vec::new();
    let mut instanced_color = Vec::new();

    if function == DrawFunction::Draw || function == DrawFunction::DrawIndirect {
        for y in 0..QUAD_GRID_SIZE {
            for x in 0..QUAD_GRID_SIZE {
                let fx0 = -1.0 + (x as f32) / grid * 2.0 / instance_count as f32;
                let fx1 = -1.0 + ((x + 1) as f32) / grid * 2.0 / instance_count as f32;
                let fy0 = -1.0 + (y as f32) / grid * 2.0;
                let fy1 = -1.0 + ((y + 1) as f32) / grid * 2.0;

                // Vertices of a quad's lower-left triangle: (fx0, fy0), (fx1, fy0) and (fx0, fy1)
                data.push(VertexPositionAndColor {
                    position: [fx0, fy0, 1.0, 1.0],
                    color: blue,
                });
                data.push(VertexPositionAndColor {
                    position: [fx1, fy0, 1.0, 1.0],
                    color: blue,
                });
                data.push(VertexPositionAndColor {
                    position: [fx0, fy1, 1.0, 1.0],
                    color: green,
                });

                // Vertices of a quad's upper-right triangle: (fx1, fy1), (fx0, fy1) and (fx1, fy0)
                data.push(VertexPositionAndColor {
                    position: [fx1, fy1, 1.0, 1.0],
                    color: green,
                });
                data.push(VertexPositionAndColor {
                    position: [fx0, fy1, 1.0, 1.0],
                    color: green,
                });
                data.push(VertexPositionAndColor {
                    position: [fx1, fy0, 1.0, 1.0],
                    color: blue,
                });
            }
        }
    } else {
        for y in 0..QUAD_GRID_SIZE + 1 {
            for x in 0..QUAD_GRID_SIZE + 1 {
                let fx = -1.0 + (x as f32) / grid * 2.0 / instance_count as f32;
                let fy = -1.0 + (y as f32) / grid * 2.0;

                data.push(VertexPositionAndColor {
                    position: [fx, fy, 1.0, 1.0],
                    color: if y % 2 != 0 { blue } else { green },
                });
            }
        }

        for y in 0..QUAD_GRID_SIZE {
            for x in 0..QUAD_GRID_SIZE {
                let ndx00 = y * (QUAD_GRID_SIZE + 1) + x;
                let ndx10 = y * (QUAD_GRID_SIZE + 1) + x + 1;
                let ndx01 = (y + 1) * (QUAD_GRID_SIZE + 1) + x;
                let ndx11 = (y + 1) * (QUAD_GRID_SIZE + 1) + x + 1;

                // Lower-left triangle of a quad.
                indexes.push(ndx00 as u32);
                indexes.push(ndx10 as u32);
                indexes.push(ndx01 as u32);

                // Upper-right triangle of a quad.
                indexes.push(ndx11 as u32);
                indexes.push(ndx01 as u32);
                indexes.push(ndx10 as u32);
            }
        }
    }

    let color_count = if instance_divisor == 0 {
        1
    } else {
        (instance_count + first_instance + instance_divisor - 1) / instance_divisor
    };
    for i in 0..instance_count + first_instance {
        instanced_color.push([
            0.0,
            ((1.0 - i as f64 * 1.0 / color_count as f64) as f32) / 2.0,
            0.0,
            1.0,
        ]);
    }

    VertexData {
        data,
        indexes,
        instanced_color,
    }
}

/// The buffers one draw reads from.
struct DrawData {
    vertex_buffer: vk::Buffer,
    instance_buffer: vk::Buffer,
    index_buffer: Option<vk::Buffer>,
    indirect_buffer: Option<vk::Buffer>,
    index_buffer_size: vk::DeviceSize,
    vertex_buffer_size: vk::DeviceSize,
    instance_buffer_size: vk::DeviceSize,
    indirect_buffer_size: vk::DeviceSize,
    vertex_buffer_address: vk::DeviceAddress,
    instance_buffer_address: vk::DeviceAddress,
    index_buffer_address: vk::DeviceAddress,
    indirect_buffer_address: vk::DeviceAddress,
    vertex_count: u32,
    index_count: u32,
    first_instance: u32,
    instance_count: u32,
}

/// `InstancedDrawInstance::preRenderCommands`
pub(super) fn pre_render_commands(device: &Device, cmd_buffer: vk::CommandBuffer, image: vk::Image, num_layers: u32) {
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);

    transition_2d_image(
        device,
        cmd_buffer,
        image,
        vk::ImageAspectFlags::COLOR,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::TRANSFER,
        num_layers,
    );

    let clear_color = vk::ClearColorValue {
        float32: [0.0, 0.0, 0.0, 1.0],
    };
    let mem_barrier = make_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
    );
    unsafe {
        device.cmd_clear_color_image(
            cmd_buffer,
            image,
            vk::ImageLayout::GENERAL,
            &clear_color,
            &[subresource_range],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[mem_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// The single subpass over one GENERAL colour attachment that is loaded, with the multiview masks when asked for.
fn make_instanced_render_pass(device: &Device, multiview: bool) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(COLOR_FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(vk::ImageLayout::GENERAL)
        .final_layout(vk::ImageLayout::GENERAL)
        .build()];
    let color_references = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::GENERAL)
        .build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_references)
        .build()];

    // Bit mask that specifies which view rendering is broadcast to: 0011 = first and second view (layer).
    // The correlation mask lets an implementation render the views concurrently.
    let view_masks = [0x3u32];
    let correlation_masks = [0x3u32];
    let mut multiview_info = vk::RenderPassMultiviewCreateInfo::builder()
        .view_masks(&view_masks)
        .correlation_masks(&correlation_masks);

    let mut info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    if multiview {
        info = info.push_next(&mut multiview_info);
    }
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

struct InstancedDrawInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl InstancedDrawInstance<'_> {
    /// `InstancedDrawInstance::draw`
    fn draw(
        &self,
        cmd_buffer: vk::CommandBuffer,
        pipeline_layout: vk::PipelineLayout,
        pipeline: vk::Pipeline,
        draw_data: &DrawData,
        address_commands: Option<&Commands>,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let params = &self.params;

        let mut use_bind_index_buffer_version = 1;
        let mut use_bind_vertex_buffers_version = 1;
        if params.use_maintenance5_ext {
            use_bind_index_buffer_version = 2;
        } else if params.use_device_address_commands {
            use_bind_index_buffer_version = 3;
            use_bind_vertex_buffers_version = 3;
        }

        unsafe {
            // bind index buffer
            if params.is_indexed_draw() {
                if params.use_device_address_commands {
                    // With some indexed cases test also a mix of the old and the new commands: some device address cases run
                    // vkCmdBindIndexBuffer with vkCmdBindVertexBuffers3 and some vkCmdBindIndexBuffer3 with vkCmdBindVertexBuffers.
                    let mix_match_variant = (params.topology.as_raw() as u32 + params.attrib_divisor) % 3;
                    use_bind_index_buffer_version = if mix_match_variant == 1 { 1 } else { 3 };
                    use_bind_vertex_buffers_version = if mix_match_variant == 2 { 1 } else { 3 };
                }

                let index_buffer = draw_data.index_buffer.expect("index buffer");
                match use_bind_index_buffer_version {
                    1 => device.cmd_bind_index_buffer(cmd_buffer, index_buffer, 0, vk::IndexType::UINT32),
                    2 => device.cmd_bind_index_buffer2_khr(
                        cmd_buffer,
                        index_buffer,
                        0,
                        draw_data.index_buffer_size,
                        vk::IndexType::UINT32,
                    ),
                    _ => {
                        let commands = address_commands.expect("device address commands");
                        let bind_info = BindIndexBuffer3Info::new(
                            DeviceAddressRange {
                                address: draw_data.index_buffer_address,
                                size: draw_data.index_buffer_size,
                            },
                            vk::IndexType::UINT32,
                        );
                        (commands.bind_index_buffer3)(cmd_buffer, &bind_info);
                    }
                }
            }

            // bind vertex buffer
            if use_bind_vertex_buffers_version == 1 {
                device.cmd_bind_vertex_buffers(
                    cmd_buffer,
                    0,
                    &[draw_data.vertex_buffer, draw_data.instance_buffer],
                    &[0, 0],
                );
            } else {
                let commands = address_commands.expect("device address commands");
                // Different valid address flags in some cases to test them.
                let mut address_flags = 0;
                if params.topology == vk::PrimitiveTopology::TRIANGLE_LIST {
                    address_flags |= ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE;
                }
                if params.test_multiview {
                    address_flags |= ADDRESS_COMMAND_FULLY_BOUND;
                }

                // Test setStride.
                let stride = if params.topology.as_raw() < vk::PrimitiveTopology::TRIANGLE_LIST.as_raw() {
                    16
                } else {
                    0
                };

                let mut vertex_buffer3_infos = [
                    BindVertexBuffer3Info::new(
                        false,
                        StridedDeviceAddressRange {
                            address: draw_data.vertex_buffer_address,
                            size: draw_data.vertex_buffer_size,
                            stride: 0,
                        },
                    ),
                    BindVertexBuffer3Info::new(
                        stride != 0,
                        StridedDeviceAddressRange {
                            address: draw_data.instance_buffer_address,
                            size: draw_data.instance_buffer_size,
                            stride,
                        },
                    ),
                ];
                vertex_buffer3_infos[1].address_flags = address_flags;
                (commands.bind_vertex_buffers3)(cmd_buffer, 0, 2, vertex_buffer3_infos.as_ptr());
            }

            let mut push_constants = [0u8; 8];
            push_constants[..4].copy_from_slice(&(draw_data.first_instance as f32).to_ne_bytes());
            push_constants[4..].copy_from_slice(&(draw_data.instance_count as f32).to_ne_bytes());
            device.cmd_push_constants(
                cmd_buffer,
                pipeline_layout,
                vk::ShaderStageFlags::VERTEX,
                0,
                &push_constants,
            );
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);

            if params.dynamic_state {
                let vertex_binding_descriptions = [
                    vk::VertexInputBindingDescription2EXT {
                        binding: 0,
                        stride: std::mem::size_of::<VertexPositionAndColor>() as u32,
                        input_rate: vk::VertexInputRate::VERTEX,
                        divisor: 1,
                        ..Default::default()
                    },
                    vk::VertexInputBindingDescription2EXT {
                        binding: 1,
                        stride: 16,
                        input_rate: vk::VertexInputRate::INSTANCE,
                        divisor: params.attrib_divisor,
                        ..Default::default()
                    },
                ];
                let vertex_attribute_descriptions = [
                    vk::VertexInputAttributeDescription2EXT {
                        location: 0,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                        ..Default::default()
                    },
                    vk::VertexInputAttributeDescription2EXT {
                        location: 1,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 16,
                        ..Default::default()
                    },
                    vk::VertexInputAttributeDescription2EXT {
                        location: 2,
                        binding: 1,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                        ..Default::default()
                    },
                ];
                device.cmd_set_vertex_input_ext(
                    cmd_buffer,
                    &vertex_binding_descriptions,
                    &vertex_attribute_descriptions,
                );
            }

            match params.function {
                DrawFunction::Draw => device.cmd_draw(
                    cmd_buffer,
                    draw_data.vertex_count,
                    draw_data.instance_count,
                    0,
                    draw_data.first_instance,
                ),
                DrawFunction::DrawIndexed => device.cmd_draw_indexed(
                    cmd_buffer,
                    draw_data.index_count,
                    draw_data.instance_count,
                    0,
                    0,
                    draw_data.first_instance,
                ),
                DrawFunction::DrawIndirect => match address_commands {
                    None => device.cmd_draw_indirect(
                        cmd_buffer,
                        draw_data.indirect_buffer.expect("indirect buffer"),
                        0,
                        1,
                        0,
                    ),
                    Some(commands) => {
                        let draw_info = DrawIndirect2Info::new(
                            StridedDeviceAddressRange {
                                address: draw_data.indirect_buffer_address,
                                size: draw_data.indirect_buffer_size,
                                stride: 0,
                            },
                            1,
                        );
                        (commands.draw_indirect2)(cmd_buffer, &draw_info);
                    }
                },
                DrawFunction::DrawIndexedIndirect => match address_commands {
                    None => device.cmd_draw_indexed_indirect(
                        cmd_buffer,
                        draw_data.indirect_buffer.expect("indirect buffer"),
                        0,
                        1,
                        0,
                    ),
                    Some(commands) => {
                        let draw_info = DrawIndirect2Info::new(
                            StridedDeviceAddressRange {
                                address: draw_data.indirect_buffer_address,
                                size: draw_data.indirect_buffer_size,
                                stride: 0,
                            },
                            1,
                        );
                        (commands.draw_indexed_indirect2)(cmd_buffer, &draw_info);
                    }
                },
            }
        }
        Ok(())
    }

    /// The reference rendering `iterate` draws with `rr::Renderer`.
    fn reference_image(
        &self,
        vertex_data: &VertexData,
        instance_count: u32,
        first_instance: u32,
    ) -> Result<TextureLevel, TestError> {
        let params = &self.params;
        let context = self.context;

        let vertices: Vec<[f32; 4]> = vertex_data.data.iter().map(|vertex| vertex.position).collect();
        let colors: Vec<[f32; 4]> = vertex_data.data.iter().map(|vertex| vertex.color).collect();

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

        let vert_shader = TestVertShader::new(instance_count as i32, first_instance as i32);
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

        // The reference renderer treats a divisor of 0 as meaning per-vertex. Use i32::MAX instead; it should work just as well.
        let instance_divisor = if params.test_attrib_divisor != AttributeDivisor::None {
            if params.attrib_divisor == 0 {
                i32::MAX
            } else {
                params.attrib_divisor as i32
            }
        } else {
            1
        };
        let vertex_attribs = [
            VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, vertices.as_ptr().cast::<u8>()),
            VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, colors.as_ptr().cast::<u8>()),
            VertexAttrib::from_pointer(
                VertexAttribType::Float,
                4,
                16,
                instance_divisor,
                vertex_data.instanced_color.as_ptr().cast::<u8>(),
            ),
        ];

        let primitive_type = map_vk_primitive_topology(params.topology);
        let primitives = if params.function == DrawFunction::Draw || params.function == DrawFunction::DrawIndirect {
            PrimitiveList::from_arrays(primitive_type, vertices.len(), 0)
        } else {
            PrimitiveList::from_indices(
                primitive_type,
                vertex_data.indexes.len(),
                DrawIndices::U32(&vertex_data.indexes, 0),
                IndexType::Uint32,
            )
        };
        let command = DrawCommand {
            state: &render_state,
            program: &program,
            vertex_attribs: &vertex_attribs,
            primitives: &primitives,
        };
        renderer.draw_instanced(&command, &mut render_target, instance_count as i32);
        Ok(ref_image)
    }

    /// `Image::readSurface` for one layer of the target, which is still in GENERAL.
    fn read_layer(&self, image: vk::Image, layer: u32, cmd_pool: vk::CommandPool) -> Result<Vec<u8>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let size = (WIDTH * HEIGHT * 4) as usize;

        let staging = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let cmd_buffer = allocate_command_buffer(device, cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, layer, 1),
        );
        let to_transfer = make_memory_barrier(vk::AccessFlags::MEMORY_WRITE, vk::AccessFlags::TRANSFER_READ);
        let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[to_transfer],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_copy_image_to_buffer(
                *cmd_buffer,
                image,
                vk::ImageLayout::GENERAL,
                staging.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        invalidate_alloc(device, staging.get_allocation())?;
        Ok(unsafe { std::slice::from_raw_parts(staging.get_allocation().get_host_ptr(), size) }.to_vec())
    }
}

impl TestInstance for InstancedDrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let num_layers: u32 = if params.test_multiview { 2 } else { 1 };
        let view_mask: u32 = if params.test_multiview { 3 } else { 0 };
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let render_area = rect_2d(WIDTH, HEIGHT);
        let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);

        // `InstancedDrawInstance::InstancedDrawInstance`
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: 8,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(num_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_target_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let view_type = if params.test_multiview {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };
        let color_target_view = make_image_view(
            device,
            color_target_image.get(),
            view_type,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers),
        )?;

        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_instanced_render_pass(device, params.test_multiview)?;
            let framebuffer = make_framebuffer(device, *render_pass, &[*color_target_view], WIDTH, HEIGHT, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let sec_cmd_buffer = if params.group_params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("InstancedDrawVert")?)?;
        let fs = create_shader_module(device, binaries.get("InstancedDrawFrag")?)?;

        let mut state = DrawPipelineState::new(params.topology).with_full_viewport(WIDTH, HEIGHT);
        if !params.dynamic_state {
            state.bindings = vec![
                vk::VertexInputBindingDescription {
                    binding: 0,
                    stride: std::mem::size_of::<VertexPositionAndColor>() as u32,
                    input_rate: vk::VertexInputRate::VERTEX,
                },
                vk::VertexInputBindingDescription {
                    binding: 1,
                    stride: 16,
                    input_rate: vk::VertexInputRate::INSTANCE,
                },
            ];
            state.attributes = vec![
                vk::VertexInputAttributeDescription {
                    location: 0,
                    binding: 0,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 0,
                },
                vk::VertexInputAttributeDescription {
                    location: 1,
                    binding: 0,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 16,
                },
                vk::VertexInputAttributeDescription {
                    location: 2,
                    binding: 1,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 0,
                },
            ];
            if params.test_attrib_divisor != AttributeDivisor::None {
                state.vertex_divisors = vec![vk::VertexInputBindingDivisorDescription {
                    binding: 1,
                    divisor: params.attrib_divisor,
                }];
            }
        } else {
            state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_EXT];
        }
        if dynamic_rendering {
            state.rendering_format = Some(COLOR_FORMAT);
            state.view_mask = view_mask;
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vs),
                (vk::ShaderStageFlags::FRAGMENT, *fs),
            ],
            &state,
        )?;

        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: COLOR_FORMAT,
            image_view: *color_target_view,
            render_area,
            clear_value: clear_value_color([0.0, 0.0, 0.0, 1.0]),
            image_layout: vk::ImageLayout::GENERAL,
            load_op: vk::AttachmentLoadOp::LOAD,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            layer_count: num_layers,
            view_mask,
        };

        // `InstancedDrawInstance::iterate`
        let instance_counts = [0u32, 1, 2, 4, 20];
        let first_instance_indices = [0u32, 1, 3, 4, 20];
        let mut first_instance_indices_count = first_instance_indices.len();
        let mut failed = false;

        // Require 'drawIndirectFirstInstance' feature to run non-zero firstInstance indirect draw tests.
        if params.is_indirect_draw() && context.get_device_features().draw_indirect_first_instance == vk::FALSE {
            first_instance_indices_count = 1;
        }

        let common_usage = if params.use_device_address_commands {
            vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
        } else {
            vk::BufferUsageFlags::empty()
        };
        let address_commands = if params.use_device_address_commands {
            Some(device_address_commands::load_commands(context)?)
        } else {
            None
        };

        for instance_count in instance_counts {
            for &first_instance in &first_instance_indices[..first_instance_indices_count] {
                // Prepare vertex data for at least one instance
                let prepare_count = instance_count.max(1);
                let instance_divisor = if params.test_attrib_divisor != AttributeDivisor::None {
                    params.attrib_divisor as i32
                } else {
                    1
                };
                let vertex_data = prepare_vertex_data(
                    params.function,
                    prepare_count as i32,
                    first_instance as i32,
                    instance_divisor,
                );

                let vertex_buffer = create_host_buffer(
                    context,
                    &vertex_data.data,
                    common_usage | vk::BufferUsageFlags::VERTEX_BUFFER,
                )?;
                let instance_buffer = create_host_buffer(
                    context,
                    &vertex_data.instanced_color,
                    common_usage | vk::BufferUsageFlags::VERTEX_BUFFER,
                )?;
                let index_buffer = if params.is_indexed_draw() {
                    Some(create_host_buffer(
                        context,
                        &vertex_data.indexes,
                        common_usage | vk::BufferUsageFlags::INDEX_BUFFER,
                    )?)
                } else {
                    None
                };
                let indirect_buffer = match params.function {
                    DrawFunction::DrawIndirect => {
                        let commands = [vk::DrawIndirectCommand {
                            vertex_count: vertex_data.data.len() as u32,
                            instance_count,
                            first_vertex: 0,
                            first_instance,
                        }];
                        Some(create_host_buffer(
                            context,
                            &commands,
                            common_usage | vk::BufferUsageFlags::INDIRECT_BUFFER,
                        )?)
                    }
                    DrawFunction::DrawIndexedIndirect => {
                        let commands = [vk::DrawIndexedIndirectCommand {
                            index_count: vertex_data.indexes.len() as u32,
                            instance_count,
                            first_index: 0,
                            vertex_offset: 0,
                            first_instance,
                        }];
                        Some(create_host_buffer(
                            context,
                            &commands,
                            common_usage | vk::BufferUsageFlags::INDIRECT_BUFFER,
                        )?)
                    }
                    _ => None,
                };
                let indirect_buffer_size = match params.function {
                    DrawFunction::DrawIndirect => std::mem::size_of::<vk::DrawIndirectCommand>(),
                    DrawFunction::DrawIndexedIndirect => std::mem::size_of::<vk::DrawIndexedIndirectCommand>(),
                    _ => 0,
                } as vk::DeviceSize;
                let address_of = |buffer: Option<&crate::vk::obj_util::BufferWithMemory<'_>>| match buffer {
                    Some(buffer) if params.use_device_address_commands => {
                        device_address_commands::buffer_device_address(device, buffer.get())
                    }
                    _ => 0,
                };

                let draw_data = DrawData {
                    vertex_buffer: vertex_buffer.get(),
                    instance_buffer: instance_buffer.get(),
                    index_buffer: index_buffer.as_ref().map(|buffer| buffer.get()),
                    indirect_buffer: indirect_buffer.as_ref().map(|buffer| buffer.get()),
                    index_buffer_size: (vertex_data.indexes.len() * std::mem::size_of::<u32>()) as vk::DeviceSize,
                    vertex_buffer_size: std::mem::size_of_val(vertex_data.data.as_slice()) as vk::DeviceSize,
                    instance_buffer_size: std::mem::size_of_val(vertex_data.instanced_color.as_slice())
                        as vk::DeviceSize,
                    indirect_buffer_size,
                    vertex_buffer_address: address_of(Some(&vertex_buffer)),
                    instance_buffer_address: address_of(Some(&instance_buffer)),
                    index_buffer_address: address_of(index_buffer.as_ref()),
                    indirect_buffer_address: address_of(indirect_buffer.as_ref()),
                    vertex_count: vertex_data.data.len() as u32,
                    index_count: vertex_data.indexes.len() as u32,
                    first_instance,
                    instance_count,
                };

                let image = color_target_image.get();
                recorder.record(
                    *cmd_buffer,
                    sec_cmd_buffer.as_ref().map(|buffer| **buffer),
                    |cmd| pre_render_commands(device, cmd, image, num_layers),
                    |cmd| self.draw(cmd, *pipeline_layout, *pipeline, &draw_data, address_commands.as_ref()),
                    |_| {},
                )?;
                submit_commands_and_wait(device, queue, *cmd_buffer)?;

                // Reference rendering
                let ref_image = self.reference_image(&vertex_data, instance_count, first_instance)?;

                for layer in 0..num_layers {
                    let rendered_bytes = self.read_layer(image, layer, *cmd_pool)?;
                    let rendered_frame = ConstPixelBufferAccess::new(tcu_format, [WIDTH, HEIGHT, 1], &rendered_bytes);

                    if params.topology == vk::PrimitiveTopology::POINT_LIST {
                        let ok = int_threshold_position_deviation_compare(
                            &ref_image.get_const_access(),
                            &rendered_frame,
                            UVec4::new(4, 4, 4, 4), // color threshold
                            [1, 1, 0],              // position deviation tolerance
                            true,                   // don't check the pixels at the boundary
                        );
                        if !ok {
                            failed = true;
                        }
                    } else if fuzzy_compare_ok(&ref_image.get_const_access(), &rendered_frame, 0.05) != Some(true) {
                        failed = true;
                    }
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

/// `InstancedTests::InstancedTests`, the `std::ostream` name of `TestParams` included.
pub fn create_instanced_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("instanced");

    let topologies = [
        (vk::PrimitiveTopology::POINT_LIST, "point_list"),
        (vk::PrimitiveTopology::LINE_LIST, "line_list"),
        (vk::PrimitiveTopology::LINE_STRIP, "line_strip"),
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
        (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
        (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
    ];
    let functions = [
        (DrawFunction::Draw, "draw"),
        (DrawFunction::DrawIndexed, "draw_indexed"),
        (DrawFunction::DrawIndirect, "draw_indirect"),
        (DrawFunction::DrawIndexedIndirect, "draw_indexed_indirect"),
    ];
    let attrib_divisors = [AttributeDivisor::None, AttributeDivisor::Ext, AttributeDivisor::Khr];
    let contains_renderpass = u32::from(group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass);

    for dynamic_state in [false, true] {
        // The raw value of the topology enum is the index in this table.
        for (topology_ndx, &(topology, topology_name)) in topologies.iter().enumerate() {
            // reduce number of tests for dynamic rendering cases where secondary command buffer is used
            if group_params.use_secondary_cmd_buffer && (topology_ndx as u32 % 2) == contains_renderpass {
                continue;
            }

            for &(function, function_name) in &functions {
                for &attrib_divisor in &attrib_divisors {
                    for divisor in [0u32, 1, 2, 4, 20] {
                        // reduce number of tests for dynamic rendering cases where secondary command buffer is used
                        if group_params.use_secondary_cmd_buffer && (divisor % 2) == contains_renderpass {
                            continue;
                        }

                        for multiview in [false, true] {
                            // If we don't have VK_EXT_vertex_attribute_divisor or VK_KHR_vertex_attribute_divisor, we only get a divisor or 1.
                            if attrib_divisor == AttributeDivisor::None && divisor != 1 {
                                continue;
                            }

                            // Add multiview tests only when vertex attribute divisor is enabled.
                            if multiview && attrib_divisor != AttributeDivisor::None {
                                continue;
                            }

                            let mut params = TestParams {
                                function,
                                topology,
                                group_params,
                                test_attrib_divisor: attrib_divisor,
                                attrib_divisor: divisor,
                                test_multiview: multiview,
                                dynamic_state,
                                use_maintenance5_ext: false,
                                use_device_address_commands: false,
                            };

                            let mut name = String::new();
                            if dynamic_state {
                                name.push_str("dynamic_state_");
                            }
                            name.push_str(function_name);
                            name.push_str("_vk_primitive_topology_");
                            name.push_str(topology_name);
                            match attrib_divisor {
                                AttributeDivisor::Ext => name.push_str(&format!("_attrib_divisor_{divisor}")),
                                AttributeDivisor::Khr => name.push_str(&format!("_khr_attrib_divisor_{divisor}")),
                                AttributeDivisor::None => {}
                            }
                            if multiview {
                                name.push_str("_multiview");
                            }

                            group.add_child(Box::new(InstancedDrawCase {
                                name: name.clone(),
                                params,
                            }) as Box<dyn TestCase>);

                            // Instanced drawing test using vkCmdBindIndexBuffer2KHR() introduced in VK_KHR_maintenance5
                            if params.is_indexed_draw() {
                                params.use_maintenance5_ext = true;
                                group.add_child(Box::new(InstancedDrawCase {
                                    name: format!("{name}_maintenance_5"),
                                    params,
                                }) as Box<dyn TestCase>);
                            }

                            // Test the device address version of some commands with a reduced number of permutations: for
                            // dynamic state only for the triangle strip topology and no attribute divisor, and only for the
                            // divisors 0 and 1.
                            let dynamic_state_subset = topology == vk::PrimitiveTopology::TRIANGLE_STRIP
                                && attrib_divisor == AttributeDivisor::None;
                            let limit_dynamic_state_tests = !dynamic_state || dynamic_state_subset;
                            if limit_dynamic_state_tests && divisor < 2 {
                                params.use_maintenance5_ext = false;
                                params.use_device_address_commands = true;
                                group.add_child(Box::new(InstancedDrawCase {
                                    name: format!("{name}_device_address"),
                                    params,
                                }) as Box<dyn TestCase>);
                            }
                        }
                    }
                }
            }
        }
    }
    group
}
