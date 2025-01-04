// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawIndexedTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `DrawIndexed`, `DrawInstancedIndexed` and
// `DrawIndexedMaintenance6` are one instance type with a `Kind`; the recording of the three rendering
// modes is `DrawTestsBase::record_and_submit`. The two classes that upstream records inline (without a
// secondary command buffer) get group parameters with the secondary command buffer switched off.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, ExtMultiDrawExtensionDeviceCommands, InstanceV1_1, KhrMaintenance5ExtensionDeviceCommands,
};

use crate::generated::shaders::draw_indexed::{BLUE_POINTS, INDEXED_COUNT};
use crate::generated::shaders::draw_simple::{SIMPLE_DRAW, SIMPLE_DRAW_INSTANCED};
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
use crate::tcu::image_compare::{
    float_threshold_compare, int_threshold_compare, int_threshold_position_deviation_compare,
};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::vector::Vec4;
use crate::tcu::{ChannelOrder, ChannelType, Random, TestError, TestOutcome, TestStatus, TextureFormat, UVec4};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, OffsetParams, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::base_class::{
    DrawTestsBase, GroupParams, ReferenceImageCoordinates, ReferenceImageInstancedCoordinates, VertexElementData,
    VertexInput, create_host_buffer,
};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const VERTEX_OFFSET_DEFAULT: i32 = 13;
const VERTEX_OFFSET_MINUS_ONE: i32 = -1;
const VERTEX_OFFSET_NEGATIVE: i32 = -13;

/// `IndexBindOffset::POSITIVE`: must be aligned to the index data type size.
const INDEX_BIND_OFFSET_POSITIVE: vk::DeviceSize = 16;
/// `MemoryBindOffset::POSITIVE`: rounded up to the alignment requirement.
const MEMORY_BIND_OFFSET_POSITIVE: vk::DeviceSize = 16;

const RENDER_WIDTH_SMALLEST: u32 = 1;
const RENDER_HEIGHT_SMALLEST: u32 = 1;
const RENDER_WIDTH_DEFAULT: u32 = 256;
const RENDER_HEIGHT_DEFAULT: u32 = 256;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    NonMaintenance6,
    Maintenance6Indexed,
    Maintenance6IndexedIndirect,
    Maintenance6IndexedIndirectCount,
    Maintenance6MultiIndexedExt,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    DrawIndexed,
    DrawInstancedIndexed,
    DrawIndexedMaintenance6,
}

/// `TestSpec2`
#[derive(Clone, Copy)]
struct TestSpec {
    group_params: GroupParams,
    topology: vk::PrimitiveTopology,
    vertex_offset: i32,
    bind_index_buffer_offset: vk::DeviceSize,
    memory_bind_offset: vk::DeviceSize,
    test_type: TestType,
    use_maintenance5_ext: bool,
    null_descriptor: bool,
    bind_index_buffer2: bool,
    test_draw_count: bool,
}

struct DrawIndexedCase {
    name: String,
    kind: Kind,
    spec: TestSpec,
}

impl TestCase for DrawIndexedCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport(Context&, TestSpec2)`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let spec = &self.spec;

        if spec.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if spec.test_type != TestType::NonMaintenance6 {
            context.require_device_functionality("VK_KHR_maintenance6")?;

            if spec.null_descriptor {
                let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };

                if robustness2_features.null_descriptor == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "robustness2 nullDescriptor is not supported".to_string(),
                    ));
                }
            }

            if spec.bind_index_buffer2 {
                context.require_device_functionality("VK_KHR_maintenance5")?;
            }

            if spec.test_type == TestType::Maintenance6MultiIndexedExt {
                context.require_device_functionality("VK_EXT_multi_draw")?;
            }

            if spec.test_type == TestType::Maintenance6IndexedIndirectCount {
                context.require_device_functionality("VK_KHR_draw_indirect_count")?;
            }

            if spec.test_draw_count && context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "fragmentStoresAndAtomics is not supported".to_string(),
                ));
            }
        }

        if spec.use_maintenance5_ext {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::DrawIndexed => SIMPLE_DRAW.programs,
            Kind::DrawInstancedIndexed => SIMPLE_DRAW_INSTANCED.programs,
            Kind::DrawIndexedMaintenance6 => {
                if self.spec.test_draw_count {
                    INDEXED_COUNT.programs
                } else {
                    SIMPLE_DRAW.programs
                }
            }
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawIndexedInstance {
            context,
            kind: self.kind,
            spec: self.spec,
        })
    }
}

/// `DrawIndexed`, `DrawInstancedIndexed` and `DrawIndexedMaintenance6`
struct DrawIndexedInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    spec: TestSpec,
}

/// `PassthruVertShader`
struct PassthruVertShader {
    inputs: [VertexInputInfo; 2],
    outputs: [VertexOutputInfo; 1],
}

impl PassthruVertShader {
    fn new() -> Self {
        Self {
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

impl VertexShader for PassthruVertShader {
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
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut color, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
            }
            packet.position = position;
            packet.outputs[0] = GenericVec4::from_float(color);
        }
    }
}

/// `PassthruFragShader`
struct PassthruFragShader {
    inputs: [FragmentInputInfo; 1],
    outputs: [FragmentOutputInfo; 1],
}

impl PassthruFragShader {
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

impl FragmentShader for PassthruFragShader {
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

impl DrawIndexedInstance<'_> {
    /// The vertex data `DrawIndexed::DrawIndexed` pushes into `m_data`.
    fn build_vertex_data(&self) -> Vec<VertexElementData> {
        let blue = [0.0f32, 0.0, 1.0, 1.0];
        let mut data = Vec::new();

        // This works for both positive and negative vertex offsets.
        for _ in 0..self.spec.vertex_offset.max(0) {
            data.push(VertexElementData::new([-1.0, 1.0, 1.0, 1.0], blue, -1i32 as u32));
        }

        let mut vertex_index = self.spec.vertex_offset.max(0);
        let mut push = |data: &mut Vec<VertexElementData>, x: f32, y: f32| {
            data.push(VertexElementData::new([x, y, 1.0, 1.0], blue, vertex_index as u32));
            vertex_index += 1;
        };

        push(&mut data, -0.3, 0.3);
        push(&mut data, -1.0, 1.0);
        push(&mut data, -0.3, -0.3);
        push(&mut data, 1.0, -1.0);
        push(&mut data, -0.3, -0.3);
        push(&mut data, 0.3, 0.3);
        push(&mut data, 0.3, -0.3);
        push(&mut data, 0.3, 0.3);

        data.push(VertexElementData::new([-1.0, 1.0, 1.0, 1.0], blue, -1i32 as u32));
        data
    }

    /// The index data `DrawIndexed::DrawIndexed` builds for `TEST_TYPE_NON_MAINTENANCE_6`.
    fn build_indexes(&self) -> Result<Vec<u32>, TestError> {
        if self.spec.test_type != TestType::NonMaintenance6 {
            return Ok(Vec::new());
        }

        // When using a positive vertex offset, the strategy is:
        // - Storing vertices with that offset in the vertex buffer.
        // - Using indices normally as if they were stored at the start of the buffer.
        //
        // When using a negative vertex offset, the strategy is:
        // - Store vertices at the start of the vertex buffer.
        // - Increase indices by abs(offset) so when substracting it, it results in the regular positions.
        let index_offset = if self.spec.vertex_offset < 0 {
            (-self.spec.vertex_offset) as u32
        } else {
            0
        };

        let base: [u32; 8] = match self.spec.topology {
            vk::PrimitiveTopology::TRIANGLE_LIST => [0, 0, 2, 0, 6, 6, 0, 7],
            vk::PrimitiveTopology::TRIANGLE_STRIP => [0, 0, 2, 0, 6, 5, 0, 7],
            _ => return Err(TestError::InternalError("Topology not implemented".to_string())),
        };
        Ok(base.iter().map(|index| index + index_offset).collect())
    }

    /// `DrawIndexed::cmdBindIndexBufferImpl`
    fn cmd_bind_index_buffer_impl(
        &self,
        cmd_buffer: vk::CommandBuffer,
        index_buffer: vk::Buffer,
        offset: vk::DeviceSize,
        size: vk::DeviceSize,
        index_type: vk::IndexType,
    ) {
        let device = self.context.get_device();
        unsafe {
            if self.spec.use_maintenance5_ext {
                device.cmd_bind_index_buffer2_khr(cmd_buffer, index_buffer, offset, size, index_type);
            } else {
                device.cmd_bind_index_buffer(cmd_buffer, index_buffer, offset, index_type);
            }
        }
    }

    /// `DrawIndexed::iterate` and `DrawInstancedIndexed::iterate`
    fn iterate_indexed(&self) -> TestOutcome {
        let context = self.context;
        let spec = self.spec;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let instanced = self.kind == Kind::DrawInstancedIndexed;

        // Upstream's instanced variant records one primary command buffer whatever the group.
        let group_params = if instanced {
            GroupParams {
                use_secondary_cmd_buffer: false,
                nested_secondary_cmd_buffer: false,
                ..spec.group_params
            }
        } else {
            spec.group_params
        };
        let base = DrawTestsBase::new(
            context,
            "vert",
            "frag",
            group_params,
            spec.topology,
            1,
            RENDER_WIDTH_DEFAULT,
            RENDER_HEIGHT_DEFAULT,
            self.build_vertex_data(),
        )?;
        let indexes = self.build_indexes()?;

        let atom_size = context.get_device_properties().limits.non_coherent_atom_size;
        let allocator = SimpleAllocator::with_offset(
            *context.get_default_allocator().memory_properties(),
            OffsetParams {
                non_coherent_atom_size: atom_size,
                offset: spec.memory_bind_offset,
            },
        );
        let data_size = std::mem::size_of_val(indexes.as_slice()) as vk::DeviceSize;
        let buffer_size = data_size + spec.bind_index_buffer_offset;

        let index_buffer = BufferWithMemory::new(
            device,
            &allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::INDEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let ptr = index_buffer.get_allocation().get_host_ptr();
            std::ptr::write_bytes(ptr, 0xFF, spec.bind_index_buffer_offset as usize);
            std::ptr::copy_nonoverlapping(
                indexes.as_ptr().cast::<u8>(),
                ptr.add(spec.bind_index_buffer_offset as usize),
                data_size as usize,
            );
        }
        flush_alloc(device, index_buffer.get_allocation())?;

        base.record_and_submit(queue, |cmd_buffer| {
            self.cmd_bind_index_buffer_impl(
                cmd_buffer,
                index_buffer.get(),
                spec.bind_index_buffer_offset,
                data_size,
                vk::IndexType::UINT32,
            );
            unsafe {
                if !instanced {
                    device.cmd_draw_indexed(cmd_buffer, 6, 1, 2, spec.vertex_offset, 0);
                } else {
                    match spec.topology {
                        vk::PrimitiveTopology::TRIANGLE_LIST => {
                            device.cmd_draw_indexed(cmd_buffer, 6, 4, 2, spec.vertex_offset, 2)
                        }
                        vk::PrimitiveTopology::TRIANGLE_STRIP => {
                            device.cmd_draw_indexed(cmd_buffer, 4, 4, 2, spec.vertex_offset, 2)
                        }
                        _ => return Err(TestError::InternalError("Topology not implemented".to_string())),
                    }
                }
            }
            Ok(())
        })?;

        // Validation
        let reference = if instanced {
            let coords = ReferenceImageInstancedCoordinates::default();
            base.make_rect_reference(
                [0.0, 0.0, 0.0, 1.0],
                [0.0, 0.0, 1.0, 1.0],
                coords.left,
                coords.right,
                coords.top,
                coords.bottom,
            )?
        } else {
            let coords = ReferenceImageCoordinates::default();
            base.make_rect_reference(
                [0.0, 0.0, 0.0, 1.0],
                [0.0, 0.0, 1.0, 1.0],
                coords.left,
                coords.right,
                coords.top,
                coords.bottom,
            )?
        };
        base.compare_with_target(queue, &reference)
    }

    /// `DrawIndexedMaintenance6::iterate`
    fn iterate_maintenance6(&self) -> TestOutcome {
        let context = self.context;
        let spec = self.spec;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;

        let (render_width, render_height) = if spec.test_draw_count {
            (RENDER_WIDTH_SMALLEST, RENDER_HEIGHT_SMALLEST)
        } else {
            (RENDER_WIDTH_DEFAULT, RENDER_HEIGHT_DEFAULT)
        };
        let group_params = GroupParams {
            use_secondary_cmd_buffer: false,
            nested_secondary_cmd_buffer: false,
            ..spec.group_params
        };
        let data = self.build_vertex_data();
        let input = if spec.test_draw_count {
            VertexInput::Custom {
                bindings: Vec::new(),
                attributes: Vec::new(),
            }
        } else {
            VertexInput::Elements(data.clone())
        };
        let set_layouts = if spec.test_draw_count {
            vec![*set_layout]
        } else {
            Vec::new()
        };
        let base = DrawTestsBase::new_with_set_layouts(
            context,
            "vert",
            "frag",
            group_params,
            spec.topology,
            1,
            render_width,
            render_height,
            input,
            &set_layouts,
        )?;

        let index_count: u32 = if spec.null_descriptor { 3 } else { 0 };

        let draw_params = [vk::DrawIndexedIndirectCommand {
            index_count,
            instance_count: 1,
            first_index: 0,
            vertex_offset: 0,
            first_instance: 0,
        }];
        let draw_params_buffer = create_host_buffer(context, &draw_params, vk::BufferUsageFlags::INDIRECT_BUFFER)?;
        let count_buffer = create_host_buffer(context, &[1u32], vk::BufferUsageFlags::INDIRECT_BUFFER)?;

        // Output SSBO
        let ssbo_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let ssbo_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(ssbo_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::write_bytes(
                ssbo_buffer.get_allocation().get_host_ptr(),
                0,
                ssbo_buffer_size as usize,
            )
        };
        flush_alloc(device, ssbo_buffer.get_allocation())?;

        // Descriptor pool and set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let ssbo_write_info = vk::DescriptorBufferInfo {
            buffer: ssbo_buffer.get(),
            offset: 0,
            range: ssbo_buffer_size,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &ssbo_write_info,
            )
            .update(device);

        base.record_and_submit_with_post(
            queue,
            |cmd_buffer| {
                unsafe {
                    if spec.bind_index_buffer2 {
                        device.cmd_bind_index_buffer2_khr(cmd_buffer, vk::Buffer::null(), 0, 0, vk::IndexType::UINT32);
                    } else {
                        device.cmd_bind_index_buffer(cmd_buffer, vk::Buffer::null(), 0, vk::IndexType::UINT32);
                    }

                    if spec.test_draw_count {
                        device.cmd_bind_descriptor_sets(
                            cmd_buffer,
                            vk::PipelineBindPoint::GRAPHICS,
                            *base.pipeline_layout,
                            0,
                            &[descriptor_set.get()],
                            &[] as &[u32],
                        );
                    }

                    match spec.test_type {
                        TestType::Maintenance6Indexed => device.cmd_draw_indexed(cmd_buffer, index_count, 1, 0, 0, 0),
                        TestType::Maintenance6IndexedIndirect => device.cmd_draw_indexed_indirect(
                            cmd_buffer,
                            draw_params_buffer.get(),
                            0,
                            1,
                            std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32,
                        ),
                        TestType::Maintenance6IndexedIndirectCount => device.cmd_draw_indexed_indirect_count(
                            cmd_buffer,
                            draw_params_buffer.get(),
                            0,
                            count_buffer.get(),
                            0,
                            1,
                            std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32,
                        ),
                        TestType::Maintenance6MultiIndexedExt => {
                            let index_info = [vk::MultiDrawIndexedInfoEXT {
                                first_index: 0,
                                index_count,
                                vertex_offset: 0,
                            }];
                            let vertex_offset = 0i32;
                            device.cmd_draw_multi_indexed_ext(
                                cmd_buffer,
                                &index_info,
                                1,
                                0,
                                std::mem::size_of::<vk::MultiDrawIndexedInfoEXT>() as u32,
                                Some(&vertex_offset),
                            );
                        }
                        TestType::NonMaintenance6 => {
                            return Err(TestError::InternalError("Unknown test type".to_string()));
                        }
                    }
                }
                Ok(())
            },
            |cmd_buffer| {
                let ssbo_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::ALL_GRAPHICS,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[ssbo_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            },
        )?;

        // Validation
        let mut ref_image = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            render_width,
            render_height,
            1,
        )?;
        {
            let mut access = ref_image.get_access();
            for y in 0..render_height {
                for x in 0..render_width {
                    access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
        }

        if spec.null_descriptor {
            let mut vertices: Vec<[f32; 4]> = Vec::new();
            let mut colors: Vec<[f32; 4]> = Vec::new();

            // Draw just the first point
            if spec.test_draw_count {
                vertices.push([0.5, 0.5, 1.0, 1.0]);
                colors.push([0.0, 0.0, 1.0, 1.0]);
            } else {
                vertices.push(data[0].position);
                colors.push(data[0].color);
            }

            let vert_shader = PassthruVertShader::new();
            let frag_shader = PassthruFragShader::new();
            let program = Program {
                vertex_shader: &vert_shader,
                fragment_shader: &frag_shader,
                geometry_shader: None,
            };
            let mut render_target = RenderTarget::new(as_multisample_view(ref_image.get_access()), None, None);
            let render_state = RenderState::new(
                ViewportState::from_target_size(render_width as i32, render_height as i32),
                context.get_device_properties().limits.sub_pixel_precision_bits as i32,
            );
            let renderer = Renderer::new();

            let vertex_attribs = [
                VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, vertices.as_ptr().cast::<u8>()),
                VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, colors.as_ptr().cast::<u8>()),
            ];
            let primitives = PrimitiveList::from_arrays(PrimitiveType::Points, vertices.len(), 0);
            let command = DrawCommand {
                state: &render_state,
                program: &program,
                vertex_attribs: &vertex_attribs,
                primitives: &primitives,
            };
            renderer.draw(&command, &mut render_target);
        }

        let rendered_frame = base.read_color_surface(queue, vk::ImageLayout::GENERAL)?;

        let mut passed = true;
        if spec.test_draw_count {
            if !int_threshold_compare(
                &ref_image.get_const_access(),
                &rendered_frame.get_const_access(),
                UVec4::new(0, 0, 0, 0),
            )
            .ok
            {
                passed = false;
            }

            if passed {
                // Get stored counters.
                invalidate_alloc(device, ssbo_buffer.get_allocation())?;
                let ssbo_counter =
                    unsafe { std::ptr::read_unaligned(ssbo_buffer.get_allocation().get_host_ptr().cast::<u32>()) };

                let expected_counter = index_count;
                if ssbo_counter != expected_counter {
                    passed = false;
                }
            }
        } else if !int_threshold_position_deviation_compare(
            &ref_image.get_const_access(),
            &rendered_frame.get_const_access(),
            UVec4::new(4, 4, 4, 4), // color threshold
            [1, 1, 0],              // position deviation tolerance
            true,                   // don't check the pixels at the boundary
        ) {
            passed = false;
        }

        Ok(if passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestInstance for DrawIndexedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::DrawIndexed | Kind::DrawInstancedIndexed => self.iterate_indexed(),
            Kind::DrawIndexedMaintenance6 => self.iterate_maintenance6(),
        }
    }
}

// Pseudorandom 8-bit index multi-draws. The goal of these tests is trying different variations of the following
// pattern:
//
// * vkCmdBindIndexBuffer(8-bit indices)
// * vkCmdDrawIndexed()
// * vkCmdBindIndexBuffer(8-bit indices)
// * vkCmdDrawIndexed()
//
// The mechanism uses a large framebuffer and draws one point over each pixel. To use multiple draws, the total number
// of pixels is divided into 8 blocks of pseudorandom size. Sometimes the blocks are sorted in increasing size order and
// sometimes they're left as-is. For each block we also pseudorandomly decide if we will use a new command buffer or
// reuse the last one.
#[derive(Clone, Copy)]
struct Multibind8BitParams {
    case_index: u32,
    sort_sizes: bool,
}

struct Multibind8BitCase {
    name: String,
    params: Multibind8BitParams,
}

fn check_index_type_uint8(context: &Context<'_>) -> Result<(), TestError> {
    let mut index8_features = vk::PhysicalDeviceIndexTypeUint8Features::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut index8_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if index8_features.index_type_uint8 == vk::FALSE {
        return Err(TestError::NotSupported("indexTypeUint8 not supported".to_string()));
    }
    Ok(())
}

impl TestCase for Multibind8BitCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_index_type_uint8(context)
    }

    fn programs(&self) -> BinaryCollection {
        BLUE_POINTS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Multibind8BitInstance {
            context,
            params: self.params,
        })
    }
}

struct Multibind8BitInstance<'a> {
    context: &'a Context<'a>,
    params: Multibind8BitParams,
}

/// The 16x16 grid of point positions both the multibind and the update-before-draw tests draw.
fn grid_vertices(extent: u32) -> Vec<[f32; 4]> {
    let float_extent = extent as f32;
    let mut vertices = Vec::with_capacity((extent * extent) as usize);
    for y in 0..extent {
        for x in 0..extent {
            let x_coord = (x as f32 + 0.5) / float_extent * 2.0 - 1.0;
            let y_coord = (y as f32 + 0.5) / float_extent * 2.0 - 1.0;
            vertices.push([x_coord, y_coord, 0.0, 1.0]);
        }
    }
    vertices
}

const MULTIBIND_REPLICA_FACTOR: u32 = 512; // If repeating indices.
const MULTIBIND_BLOCK_COUNT: u32 = 8; // How many blocks we aim to have.
const MULTIBIND_PIECE_SIZE: u32 = 4; // We want to make index buffer sizes multiples of 4-bytes.

#[derive(Clone, Copy)]
struct DrawInfo {
    first_piece: u32,
    draw_pieces: u32,
    new_cmd_buffer: bool,
    /// Repeat each index multiple times or not.
    repeat: bool,
}

impl DrawInfo {
    fn first_index(&self) -> u32 {
        self.first_piece * MULTIBIND_PIECE_SIZE
    }

    fn index_count(&self) -> u32 {
        self.draw_pieces * MULTIBIND_PIECE_SIZE
    }

    /// How many times to repeat each index in the buffer.
    fn repetitions(&self) -> u32 {
        if self.repeat { MULTIBIND_REPLICA_FACTOR } else { 1 }
    }

    /// How many indices to store in the buffer.
    fn buffer_index_count(&self) -> u32 {
        self.index_count() * self.repetitions()
    }
}

/// The lambda `makeNewCmdbuffer`: a new command buffer, its semaphore, both begun and returned.
fn make_new_cmd_buffer<'a>(
    device: &'a Device,
    cmd_pool: vk::CommandPool,
    cmd_buffers: &mut Vec<UniqueCommandBuffer<'a>>,
    cmd_semaphores: &mut Vec<Unique<'a, vk::Semaphore>>,
) -> Result<vk::CommandBuffer, TestError> {
    let semaphore =
        unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?;
    cmd_semaphores.push(Unique::new(device, semaphore));
    cmd_buffers.push(allocate_command_buffer(
        device,
        cmd_pool,
        vk::CommandBufferLevel::PRIMARY,
    )?);
    let cmd_buffer = **cmd_buffers.last().expect("just pushed");
    begin_command_buffer(device, cmd_buffer)?;
    Ok(cmd_buffer)
}

impl TestInstance for Multibind8BitInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let seed = (1768315279u32 & 0xffffff00u32) + ((params.sort_sizes as u32) << 7) + params.case_index;
        let mut rng = Random::new(seed);

        const EXTENT: u32 = 16;
        let format = vk::Format::R8G8B8A8_UNORM;
        let usage = vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let point_count = EXTENT * EXTENT;

        debug_assert!(point_count - 1 <= u32::from(u8::MAX));

        let color_buffer = ImageWithBuffer::new(context, EXTENT, EXTENT, format, usage, 4)?;

        // Vertex buffer.
        let vertices = grid_vertices(EXTENT);
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let piece_count = point_count / MULTIBIND_PIECE_SIZE;
        let mut draw_infos: Vec<DrawInfo> = Vec::with_capacity(MULTIBIND_BLOCK_COUNT as usize);

        // Lets pseudorandomly choose how many pieces in each block.
        let mut prev_pieces = 0u32;
        let mut remaining_pieces = piece_count;

        for block_ndx in 0..MULTIBIND_BLOCK_COUNT {
            let remaining_blocks = MULTIBIND_BLOCK_COUNT - block_ndx - 1; // After the current one.
            let min_pieces = 1;
            let max_pieces = (remaining_pieces - remaining_blocks) as i32; // Leave at least 1 piece for each remaining block.
            let draw_pieces = if block_ndx == MULTIBIND_BLOCK_COUNT - 1 {
                remaining_pieces
            } else {
                rng.get_int(min_pieces, max_pieces) as u32
            };
            let new_cmd_buffer = rng.get_bool();
            let repeat = rng.get_int(1, 4) == 1;
            draw_infos.push(DrawInfo {
                first_piece: prev_pieces,
                draw_pieces,
                new_cmd_buffer,
                repeat,
            });

            prev_pieces += draw_pieces;
            remaining_pieces -= draw_pieces;
        }

        if params.sort_sizes {
            draw_infos.sort_by_key(|info| info.draw_pieces);
        }

        // Index buffers.
        let mut index_buffers: Vec<BufferWithMemory<'_>> = Vec::with_capacity(MULTIBIND_BLOCK_COUNT as usize);
        for draw_info in &draw_infos {
            let mut indices: Vec<u8> = Vec::with_capacity(draw_info.buffer_index_count() as usize);
            for i in draw_info.first_index()..draw_info.first_index() + draw_info.index_count() {
                for _ in 0..draw_info.repetitions() {
                    indices.push(i as u8);
                }
            }
            index_buffers.push(create_host_buffer(
                context,
                &indices,
                vk::BufferUsageFlags::INDEX_BUFFER,
            )?);
        }

        // Render pass that loads and stores the attachment.
        let render_pass = make_color_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;
        let render_area = rect_2d(EXTENT, EXTENT);

        // Graphics pipeline.
        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST)
            .with_position_input()
            .with_full_viewport(EXTENT, EXTENT);
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let mut cmd_semaphores: Vec<Unique<'_, vk::Semaphore>> = Vec::new();
        let mut cmd_buffers: Vec<UniqueCommandBuffer<'_>> = Vec::new();

        // The lambda that starts a new render pass and binds the vertex buffer and the pipeline for it.
        let start_render_pass = |cmd_buffer: vk::CommandBuffer| {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                render_area,
                clear_value_color([0.0, 0.0, 0.0, 1.0]),
            );
            unsafe {
                device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            }
        };

        let mut cmd_buffer = make_new_cmd_buffer(device, *cmd_pool, &mut cmd_buffers, &mut cmd_semaphores)?;

        // Clear color buffer to black.
        {
            let color_srr =
                crate::vk::image_util::make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let pre_clear_barrier = crate::vk::image_util::make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                color_buffer.image.get(),
                color_srr,
            );
            let post_clear_barrier = crate::vk::image_util::make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.image.get(),
                color_srr,
            );
            let clear_color = vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            };
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_clear_barrier],
                );
                device.cmd_clear_color_image(
                    cmd_buffer,
                    color_buffer.image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color,
                    &[color_srr],
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_clear_barrier],
                );
            }
        }

        start_render_pass(cmd_buffer);

        for (draw_idx, draw_info) in draw_infos.iter().enumerate() {
            if draw_info.new_cmd_buffer {
                end_render_pass(device, cmd_buffer);
                end_command_buffer(device, cmd_buffer)?;

                cmd_buffer = make_new_cmd_buffer(device, *cmd_pool, &mut cmd_buffers, &mut cmd_semaphores)?;

                let draw_barrier = make_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[draw_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
                start_render_pass(cmd_buffer);
            }

            // Bind the new index buffer and draw.
            unsafe {
                device.cmd_bind_index_buffer(cmd_buffer, index_buffers[draw_idx].get(), 0, vk::IndexType::UINT8);
                // Note first index is zero because we use separate index buffers for each call.
                device.cmd_draw_indexed(cmd_buffer, draw_info.buffer_index_count(), 1, 0, 0, 0);
            }
        }

        end_render_pass(device, cmd_buffer);

        // Copy color buffer to verification buffer before finishing.
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            EXTENT,
            EXTENT,
        );

        end_command_buffer(device, cmd_buffer)?;

        let cmd_handles: Vec<vk::CommandBuffer> = cmd_buffers.iter().map(|buffer| **buffer).collect();
        let semaphore_handles: Vec<vk::Semaphore> = cmd_semaphores.iter().map(|semaphore| **semaphore).collect();
        let wait_stages = [vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT];
        let mut submit_infos: Vec<vk::SubmitInfo> = Vec::with_capacity(cmd_handles.len());

        for cmd_idx in 0..cmd_handles.len() {
            let has_previous = cmd_idx > 0;

            // Each command buffer waits for the previous one to finish at the color attachment output stage.
            let mut submit_info = vk::SubmitInfo::builder()
                .command_buffers(&cmd_handles[cmd_idx..cmd_idx + 1])
                .signal_semaphores(&semaphore_handles[cmd_idx..cmd_idx + 1]);
            if has_previous {
                submit_info = submit_info
                    .wait_semaphores(&semaphore_handles[cmd_idx - 1..cmd_idx])
                    .wait_dst_stage_mask(&wait_stages);
            }
            submit_infos.push(submit_info.build());
        }

        let fence = Unique::new(
            device,
            unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        );
        unsafe { device.queue_submit(queue, &submit_infos, *fence) }.vk_check("vkQueueSubmit")?;
        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

        // Prepare reference image (all blue color, see frag shader).
        let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut ref_level = TextureLevel::new(tcu_format, EXTENT, EXTENT, 1)?;
        {
            let mut reference = ref_level.get_access();
            for y in 0..EXTENT {
                for x in 0..EXTENT {
                    reference.set_pixel([0.0, 0.0, 1.0, 1.0], x, y, 0);
                }
            }
        }

        let result = ConstPixelBufferAccess::new(tcu_format, [EXTENT, EXTENT, 1], color_buffer.read_bytes(device)?);

        if !float_threshold_compare(&ref_level.get_const_access(), &result, [0.0; 4]).ok {
            return Err(TestError::Fail(
                "Unexpected contents in color buffer; check log for details --".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// Update before draw: test that updating the index buffer before drawing works.
// * vkCmdBindIndexBuffer
// * Transfer op (could be compute too) that updates the index buffer contents.
// * Barrier.
// * vkCmdDrawIndexed in a render pass
//
// The tests will use different index types, and a 16x16 FB covered with 256 points.
struct UpdateBeforeDrawCase {
    name: String,
    index_type: vk::IndexType,
}

impl TestCase for UpdateBeforeDrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.index_type == vk::IndexType::UINT8 {
            check_index_type_uint8(context)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BLUE_POINTS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UpdateBeforeDrawInstance {
            context,
            index_type: self.index_type,
        })
    }
}

struct UpdateBeforeDrawInstance<'a> {
    context: &'a Context<'a>,
    index_type: vk::IndexType,
}

impl TestInstance for UpdateBeforeDrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        const EXTENT: u32 = 16;
        let format = vk::Format::R8G8B8A8_UNORM;
        let usage = vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let point_count = EXTENT * EXTENT;

        debug_assert!(point_count - 1 <= u32::from(u8::MAX));

        let color_buffer = ImageWithBuffer::new(context, EXTENT, EXTENT, format, usage, 4)?;

        // Vertex buffer.
        let vertices = grid_vertices(EXTENT);
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Staging buffer: we will generate the actual indices here.
        let mut staging_buffer_bytes: Vec<u8> = Vec::new();
        if self.index_type == vk::IndexType::UINT8 {
            staging_buffer_bytes.extend((0..point_count).map(|i| i as u8));
        } else if self.index_type == vk::IndexType::UINT16 {
            for i in 0..point_count {
                staging_buffer_bytes.extend_from_slice(&(i as u16).to_ne_bytes());
            }
        } else if self.index_type == vk::IndexType::UINT32 {
            for i in 0..point_count {
                staging_buffer_bytes.extend_from_slice(&i.to_ne_bytes());
            }
        } else {
            return Err(TestError::InternalError("Unexpected index type".to_string()));
        }

        let staging_buffer_size = staging_buffer_bytes.len() as vk::DeviceSize;
        let staging_buffer = create_host_buffer(context, &staging_buffer_bytes, vk::BufferUsageFlags::TRANSFER_SRC)?;

        // Index buffer: contents will be filled later with a copy from the staging buffer.
        let index_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                staging_buffer_size,
                vk::BufferUsageFlags::INDEX_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;

        // Render pass that clears and stores the attachment.
        let render_pass = make_color_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;
        let render_area = rect_2d(EXTENT, EXTENT);

        // Graphics pipeline.
        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST)
            .with_position_input()
            .with_full_viewport(EXTENT, EXTENT);
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?;

        // Command pool with buffer, run stuff.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(*cmd_buffer, index_buffer.get(), 0, self.index_type);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

            // After the index buffer is bound, fill its contents from the staging buffer.
            let copy_region = vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: staging_buffer_size,
            };
            device.cmd_copy_buffer(*cmd_buffer, staging_buffer.get(), index_buffer.get(), &[copy_region]);

            // Insert a barrier so the transfer happens before reading indices.
            let xfer_to_draw = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::INDEX_READ);
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::VERTEX_INPUT,
                vk::DependencyFlags::empty(),
                &[xfer_to_draw],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        // Render pass and draw.
        begin_render_pass(
            device,
            *cmd_buffer,
            *render_pass,
            *framebuffer,
            render_area,
            clear_value_color([0.0, 0.0, 0.0, 1.0]),
        );
        unsafe { device.cmd_draw_indexed(*cmd_buffer, point_count, 1, 0, 0, 0) };
        end_render_pass(device, *cmd_buffer);

        copy_image_to_buffer(
            device,
            *cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            EXTENT,
            EXTENT,
        );

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let result = ConstPixelBufferAccess::new(tcu_format, [EXTENT, EXTENT, 1], color_buffer.read_bytes(device)?);

        // Prepare reference image (all blue color, see frag shader).
        let mut ref_level = TextureLevel::new(tcu_format, EXTENT, EXTENT, 1)?;
        {
            let mut reference = ref_level.get_access();
            for y in 0..EXTENT {
                for x in 0..EXTENT {
                    reference.set_pixel([0.0, 0.0, 1.0, 1.0], x, y, 0);
                }
            }
        }

        if !float_threshold_compare(&ref_level.get_const_access(), &result, [0.0; 4]).ok {
            return Err(TestError::Fail(
                "Unexpected contents in color buffer; check log for details --".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `DrawIndexedTests::init(bool useMaintenance5Ext)`
fn init(group: &mut TestCaseGroup, group_params: GroupParams, use_maintenance5_ext: bool) {
    let maintenance5_ext_name_suffix = if use_maintenance5_ext { "_maintenance_5" } else { "" };

    let topology_cases = [
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
        (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
    ];
    let offset_cases = [
        (VERTEX_OFFSET_DEFAULT, ""),
        (VERTEX_OFFSET_MINUS_ONE, "_offset_minus_one"),
        (VERTEX_OFFSET_NEGATIVE, "_offset_negative_large"),
    ];
    let index_bind_offset_cases = [(0, ""), (INDEX_BIND_OFFSET_POSITIVE, "_with_bind_offset")];
    let memory_bind_offset_cases = [(0, ""), (MEMORY_BIND_OFFSET_POSITIVE, "_with_alloc_offset")];

    for (offset, offset_suffix) in offset_cases {
        for (index_bind_offset, index_bind_offset_suffix) in index_bind_offset_cases {
            for (memory_bind_offset, memory_bind_offset_suffix) in memory_bind_offset_cases {
                for (topology, topology_suffix) in topology_cases {
                    let spec = TestSpec {
                        group_params,
                        topology,
                        vertex_offset: offset,
                        bind_index_buffer_offset: index_bind_offset,
                        memory_bind_offset,
                        test_type: TestType::NonMaintenance6,
                        use_maintenance5_ext,
                        null_descriptor: false,
                        bind_index_buffer2: false,
                        test_draw_count: false,
                    };

                    let test_name = format!(
                        "draw_indexed_{topology_suffix}{offset_suffix}{index_bind_offset_suffix}{memory_bind_offset_suffix}{maintenance5_ext_name_suffix}"
                    );
                    group.add_child(Box::new(DrawIndexedCase {
                        name: test_name,
                        kind: Kind::DrawIndexed,
                        spec,
                    }) as Box<dyn TestCase>);

                    let test_name = format!(
                        "draw_instanced_indexed_{topology_suffix}{offset_suffix}{index_bind_offset_suffix}{memory_bind_offset_suffix}{maintenance5_ext_name_suffix}"
                    );
                    group.add_child(Box::new(DrawIndexedCase {
                        name: test_name,
                        kind: Kind::DrawInstancedIndexed,
                        spec,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }

    let maintenance6_cases = [
        (TestType::Maintenance6Indexed, ""),
        (TestType::Maintenance6IndexedIndirect, "_indirect"),
        (TestType::Maintenance6IndexedIndirectCount, "_indirect_count"),
        (TestType::Maintenance6MultiIndexedExt, "_multi"),
    ];

    for (test_type, name_suffix) in maintenance6_cases {
        for m5 in [false, true] {
            for null in [false, true] {
                for test_draw_count in [false, true] {
                    let m5_suffix = if m5 { "_bindindexbuffer2" } else { "" };
                    let null_suffix = if null { "_nulldescriptor" } else { "" };
                    let draw_count_suffix = if test_draw_count { "_count" } else { "" };

                    let test_name = format!(
                        "draw_indexed{draw_count_suffix}{name_suffix}{m5_suffix}{null_suffix}{maintenance5_ext_name_suffix}_maintenance6"
                    );

                    let spec = TestSpec {
                        group_params,
                        topology: vk::PrimitiveTopology::POINT_LIST,
                        vertex_offset: 0,
                        bind_index_buffer_offset: 0,
                        memory_bind_offset: 0,
                        test_type,
                        use_maintenance5_ext,
                        null_descriptor: null,
                        bind_index_buffer2: m5,
                        test_draw_count,
                    };
                    group.add_child(Box::new(DrawIndexedCase {
                        name: test_name,
                        kind: Kind::DrawIndexedMaintenance6,
                        spec,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }

    if !group_params.use_dynamic_rendering && !group_params.use_secondary_cmd_buffer && !use_maintenance5_ext {
        for sort_sizes in [false, true] {
            let case_count = 20u32;
            for case_index in 0..case_count {
                let params = Multibind8BitParams { case_index, sort_sizes };
                let test_name = format!(
                    "multibind_8bit_case_{case_index}{}",
                    if sort_sizes { "_sorted" } else { "" }
                );
                group.add_child(Box::new(Multibind8BitCase {
                    name: test_name,
                    params,
                }) as Box<dyn TestCase>);
            }
        }

        for (index_type, name) in [
            (vk::IndexType::UINT32, "32"),
            (vk::IndexType::UINT16, "16"),
            (vk::IndexType::UINT8, "8"),
        ] {
            let test_name = format!("update_index_buffer_before_draw_{name}");
            group.add_child(Box::new(UpdateBeforeDrawCase {
                name: test_name,
                index_type,
            }) as Box<dyn TestCase>);
        }
    }
}

/// `DrawIndexedTests::init`
pub fn create_indexed_draw_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indexed_draw");
    init(&mut group, group_params, false);
    init(&mut group, group_params, true);
    group
}
