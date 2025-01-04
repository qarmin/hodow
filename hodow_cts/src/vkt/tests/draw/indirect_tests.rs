// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawIndirectTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `IndirectDraw`, `IndirectDrawInstanced` (`TestSpec::instanced`) and
// `IndirectDrawCountClampTest` (`TestSpec::count_clamp`) are one instance type with three behaviours.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::draw_indirect::{
    INDIRECT_DRAW, INDIRECT_DRAW_COMPUTE, INDIRECT_DRAW_FIRST_INSTANCE, INDIRECT_DRAW_FIRST_INSTANCE_COMPUTE,
    INDIRECT_DRAW_INSTANCED, INDIRECT_DRAW_INSTANCED_COMPUTE, INDIRECT_DRAW_INSTANCED_FIRST_INSTANCE,
    INDIRECT_DRAW_INSTANCED_FIRST_INSTANCE_COMPUTE,
};
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::mem_util::{MemoryRequirement, OffsetParams, SimpleAllocator, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, make_buffer_create_info, make_buffer_memory_barrier, make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{
    DEFAULT_RENDER_SIZE, DrawTestsBase, GroupParams, ReferenceImageCoordinates, ReferenceImageInstancedCoordinates,
    VertexElementData, create_host_buffer,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const VERTEX_OFFSET: i32 = 13;
const DRAW_COUNT: u32 = 2;
/// `m_indirectCountExtDrawPadding`
const INDIRECT_COUNT_EXT_DRAW_PADDING: u32 = 1;

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawType {
    Sequential,
    Indexed,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum IndirectCountType {
    None,
    BufferLimit,
    ParamLimit,
}

/// `DrawTypedTestSpec`
#[derive(Clone, Copy)]
struct TestSpec {
    group_params: GroupParams,
    topology: vk::PrimitiveTopology,
    draw_type: DrawType,
    require_indirect_first_instance: bool,
    test_first_instance_ndx: bool,
    test_indirect_count_ext: IndirectCountType,
    data_from_compute: bool,
    use_memory_access: bool,
    layer_count: u32,
    bind_index_buffer_offset: vk::DeviceSize,
    index_buffer_alloc_offset: vk::DeviceSize,
    draw_count_is_zero: bool,
    use_multi_draw: bool,
    /// `Some(first instance)` for `IndirectDrawInstanced<FirstInstanceSupported / FirstInstanceNotSupported>`: four instances per command.
    instanced: Option<u32>,
    /// `IndirectDrawCountClampTest`: a count buffer far above the maximum draw count.
    count_clamp: bool,
}

struct IndirectDrawCase {
    name: &'static str,
    spec: TestSpec,
}

impl TestCase for IndirectDrawCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let spec = &self.spec;

        if spec.test_indirect_count_ext != IndirectCountType::None {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }
        if spec.use_multi_draw {
            if context.get_device_features().multi_draw_indirect == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requires VkPhysicalDeviceFeatures::multiDrawIndirect".to_string(),
                ));
            }
            if context.get_device_properties().limits.max_draw_indirect_count < DRAW_COUNT {
                return Err(TestError::NotSupported("maxDrawIndirectCount too low".to_string()));
            }
        }
        if spec.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        if spec.layer_count > 1 {
            let mut features = vk::PhysicalDeviceMultiviewFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.multiview == vk::FALSE {
                return Err(TestError::NotSupported("multiview not supported".to_string()));
            }
        }
        if spec.require_indirect_first_instance
            && context.get_device_features().draw_indirect_first_instance != vk::TRUE
        {
            return Err(TestError::NotSupported(
                "Required 'drawIndirectFirstInstance' feature is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (
            self.spec.instanced,
            self.spec.test_first_instance_ndx,
            self.spec.data_from_compute,
        ) {
            (None, false, false) => INDIRECT_DRAW.programs,
            (None, false, true) => INDIRECT_DRAW_COMPUTE.programs,
            (None, true, false) => INDIRECT_DRAW_FIRST_INSTANCE.programs,
            (None, true, true) => INDIRECT_DRAW_FIRST_INSTANCE_COMPUTE.programs,
            (Some(0), _, false) => INDIRECT_DRAW_INSTANCED.programs,
            (Some(0), _, true) => INDIRECT_DRAW_INSTANCED_COMPUTE.programs,
            (Some(_), _, false) => INDIRECT_DRAW_INSTANCED_FIRST_INSTANCE.programs,
            (Some(_), _, true) => INDIRECT_DRAW_INSTANCED_FIRST_INSTANCE_COMPUTE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IndirectDraw {
            context,
            spec: self.spec,
        })
    }
}

/// `IndirectDraw`
struct IndirectDraw<'a> {
    context: &'a Context<'a>,
    spec: TestSpec,
}

const BLUE: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];

fn vertex(x: f32, y: f32, color: [f32; 4], ref_index: i32) -> VertexElementData {
    VertexElementData::new([x, y, 1.0, 1.0], color, ref_index as u32)
}

/// The positions of the triangles a topology draws, in the order `setVertexBuffer` lists them.
fn topology_positions(topology: vk::PrimitiveTopology) -> Result<&'static [(f32, f32)], TestError> {
    match topology {
        vk::PrimitiveTopology::TRIANGLE_LIST => Ok(&[
            (-0.3, -0.3),
            (-0.3, 0.3),
            (0.3, -0.3),
            (0.3, -0.3),
            (0.3, 0.3),
            (-0.3, 0.3),
        ]),
        vk::PrimitiveTopology::TRIANGLE_STRIP => Ok(&[
            (-0.3, 0.0),
            (0.3, 0.0),
            (-0.3, -0.3),
            (0.3, -0.3),
            (-0.3, 0.3),
            (0.3, 0.3),
            (-0.3, 0.0),
            (0.3, 0.0),
        ]),
        _ => Err(TestError::InternalError("Unknown topology".to_string())),
    }
}

impl IndirectDraw<'_> {
    /// `IndirectDraw::setVertexBuffer`
    fn set_vertex_buffer(&self) -> Result<Vec<VertexElementData>, TestError> {
        let mut data = Vec::new();
        let mut ref_vertex_index = 2;

        if self.spec.draw_type == DrawType::Indexed {
            for _ in 0..VERTEX_OFFSET {
                data.push(vertex(-1.0, 1.0, BLUE, -1));
            }
            ref_vertex_index += VERTEX_OFFSET;
        }

        data.push(vertex(1.0, -1.0, BLUE, -1));
        data.push(vertex(-1.0, 1.0, BLUE, -1));

        let positions = topology_positions(self.spec.topology)?;
        for color in [BLUE, RED] {
            for &(x, y) in positions {
                data.push(vertex(x, y, color, ref_vertex_index));
                ref_vertex_index += 1;
            }
        }

        data.push(vertex(-1.0, 1.0, BLUE, -1));
        Ok(data)
    }

    /// `IndirectDraw::setFirstInstanceVertexBuffer`
    fn set_first_instance_vertex_buffer(&self) -> Result<Vec<VertexElementData>, TestError> {
        let mut data = Vec::new();

        if self.spec.draw_type == DrawType::Indexed {
            for _ in 0..VERTEX_OFFSET {
                data.push(vertex(-1.0, 1.0, BLUE, -1));
            }
        }

        data.push(vertex(1.0, -1.0, BLUE, -1));
        data.push(vertex(-1.0, 1.0, BLUE, -1));

        // Every group of vertices (a triangle, or four vertices of a strip) belongs to instance 1 or 0 alternately.
        let positions = topology_positions(self.spec.topology)?;
        let group_size = if self.spec.topology == vk::PrimitiveTopology::TRIANGLE_LIST {
            3
        } else {
            4
        };
        for color in [BLUE, RED] {
            for (group_ndx, group) in positions.chunks(group_size).enumerate() {
                let ref_instance_index = if group_ndx % 2 == 0 { 1 } else { 0 };
                for &(x, y) in group {
                    data.push(vertex(x, y, color, ref_instance_index));
                }
            }
        }

        data.push(vertex(-1.0, 1.0, BLUE, -1));
        Ok(data)
    }

    /// The indirect commands `iterate` writes, junk between them and padding after them, and their stride.
    fn build_indirect_buffer_contents(&self) -> Result<(Vec<u8>, u32), TestError> {
        let spec = &self.spec;
        // `IndirectDraw` first-instance cases put the first instance in the first command only; `IndirectDrawInstanced` in all of them.
        let instance_count = if spec.instanced.is_some() { 4u32 } else { 1 };
        let first_instance = match spec.instanced {
            Some(first_instance) => first_instance,
            None => u32::from(spec.test_first_instance_ndx),
        };
        let later_first_instance = spec.instanced.unwrap_or(0);
        let (vertex_counts_first, first_vertices): (u32, [u32; 4]) = match spec.topology {
            vk::PrimitiveTopology::TRIANGLE_LIST => (3, [2, 5, 8, 11]),
            vk::PrimitiveTopology::TRIANGLE_STRIP => (4, [2, 6, 10, 14]),
            _ => return Err(TestError::InternalError("impossible".to_string())),
        };
        let count = vertex_counts_first;
        let mut contents = Vec::new();

        fn push<T: Copy>(contents: &mut Vec<u8>, command: &T) {
            let bytes =
                unsafe { std::slice::from_raw_parts((command as *const T).cast::<u8>(), std::mem::size_of::<T>()) };
            contents.extend_from_slice(bytes);
        }

        let stride = match spec.draw_type {
            DrawType::Sequential => {
                let commands = [
                    vk::DrawIndirectCommand {
                        vertex_count: count,
                        instance_count,
                        first_vertex: first_vertices[0],
                        first_instance,
                    },
                    vk::DrawIndirectCommand {
                        vertex_count: -4i32 as u32,
                        instance_count: -2i32 as u32,
                        first_vertex: -11i32 as u32,
                        first_instance: -9i32 as u32,
                    }, // junk (stride)
                    vk::DrawIndirectCommand {
                        vertex_count: count,
                        instance_count,
                        first_vertex: first_vertices[1],
                        first_instance: later_first_instance,
                    },
                    vk::DrawIndirectCommand {
                        vertex_count: count,
                        instance_count,
                        first_vertex: first_vertices[2],
                        first_instance: later_first_instance,
                    },
                    vk::DrawIndirectCommand {
                        vertex_count: count,
                        instance_count,
                        first_vertex: first_vertices[3],
                        first_instance: later_first_instance,
                    },
                ];
                push(&mut contents, &commands[0]);
                push(&mut contents, &commands[1]);
                push(&mut contents, &commands[2]);
                push(&mut contents, &commands[1]);
                if spec.test_indirect_count_ext != IndirectCountType::None {
                    // Add padding data to the buffer to make sure it's large enough.
                    for _ in 0..2 * DRAW_COUNT {
                        push(&mut contents, &commands[3]);
                        push(&mut contents, &commands[1]);
                        push(&mut contents, &commands[4]);
                        push(&mut contents, &commands[1]);
                    }
                }
                2 * std::mem::size_of::<vk::DrawIndirectCommand>() as u32
            }
            DrawType::Indexed => {
                let commands = [
                    vk::DrawIndexedIndirectCommand {
                        index_count: count,
                        instance_count,
                        first_index: first_vertices[0],
                        vertex_offset: VERTEX_OFFSET,
                        first_instance,
                    },
                    vk::DrawIndexedIndirectCommand {
                        index_count: -4i32 as u32,
                        instance_count: -2i32 as u32,
                        first_index: -11i32 as u32,
                        vertex_offset: 9,
                        first_instance: -7i32 as u32,
                    }, // junk (stride)
                    vk::DrawIndexedIndirectCommand {
                        index_count: count,
                        instance_count,
                        first_index: first_vertices[1],
                        vertex_offset: VERTEX_OFFSET,
                        first_instance: later_first_instance,
                    },
                    vk::DrawIndexedIndirectCommand {
                        index_count: count,
                        instance_count,
                        first_index: first_vertices[2],
                        vertex_offset: VERTEX_OFFSET,
                        first_instance: later_first_instance,
                    },
                    vk::DrawIndexedIndirectCommand {
                        index_count: count,
                        instance_count,
                        first_index: first_vertices[3],
                        vertex_offset: VERTEX_OFFSET,
                        first_instance: later_first_instance,
                    },
                ];
                push(&mut contents, &commands[0]);
                push(&mut contents, &commands[1]);
                push(&mut contents, &commands[2]);
                push(&mut contents, &commands[1]);
                if spec.test_indirect_count_ext != IndirectCountType::None {
                    // Add padding data to the buffer to make sure it's large enough.
                    for _ in 0..2 * DRAW_COUNT {
                        push(&mut contents, &commands[3]);
                        push(&mut contents, &commands[1]);
                        push(&mut contents, &commands[4]);
                        push(&mut contents, &commands[1]);
                    }
                }
                2 * std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32
            }
        };
        Ok((contents, stride))
    }
}

/// What `negateDataUsingCompute` creates and the barriers it records.
struct NegateObjects<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    descriptor_set_indirect_buffer: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    descriptor_set_count_buffer: Option<crate::vk::ref_util::UniqueDescriptorSet<'a>>,
    _descriptor_pool: Unique<'a, vk::DescriptorPool>,
    _descriptor_set_layout: Unique<'a, vk::DescriptorSetLayout>,
    _compute_shader_module: Unique<'a, vk::ShaderModule>,
    host_write_barrier: vk::BufferMemoryBarrier,
    indirect_draw_barrier: vk::BufferMemoryBarrier,
}

impl IndirectDraw<'_> {
    fn count_buffer_barrier(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        count_buffer: vk::Buffer,
        count_buffer_size: vk::DeviceSize,
    ) {
        let spec = &self.spec;
        let barrier = make_buffer_memory_barrier(
            if spec.use_memory_access {
                vk::AccessFlags::MEMORY_WRITE
            } else {
                vk::AccessFlags::SHADER_WRITE
            },
            if spec.use_memory_access {
                vk::AccessFlags::MEMORY_READ
            } else {
                vk::AccessFlags::INDIRECT_COMMAND_READ
            },
            count_buffer,
            0,
            count_buffer_size,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::DRAW_INDIRECT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `IndirectDraw::draw`, with the vertex buffer and pipeline already bound.
    #[allow(clippy::too_many_arguments)]
    fn draw(
        &self,
        cmd_buffer: vk::CommandBuffer,
        indirect_buffer: vk::Buffer,
        index_buffer: Option<vk::Buffer>,
        count_buffer: Option<vk::Buffer>,
        offset_in_buffer: vk::DeviceSize,
        offset_in_count_buffer: vk::DeviceSize,
        stride_in_buffer: u32,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let spec = &self.spec;
        let indexed = spec.draw_type == DrawType::Indexed;

        unsafe {
            if indexed {
                device.cmd_bind_index_buffer(
                    cmd_buffer,
                    index_buffer.expect("index buffer"),
                    spec.bind_index_buffer_offset,
                    vk::IndexType::UINT32,
                );
            }

            if spec.use_multi_draw {
                if spec.test_indirect_count_ext != IndirectCountType::None {
                    let max_draw_count = if spec.test_indirect_count_ext == IndirectCountType::BufferLimit {
                        DRAW_COUNT + INDIRECT_COUNT_EXT_DRAW_PADDING
                    } else if spec.draw_count_is_zero {
                        0
                    } else {
                        DRAW_COUNT
                    };
                    let count_buffer = count_buffer.expect("count buffer");
                    if indexed {
                        device.cmd_draw_indexed_indirect_count(
                            cmd_buffer,
                            indirect_buffer,
                            offset_in_buffer,
                            count_buffer,
                            offset_in_count_buffer,
                            max_draw_count,
                            stride_in_buffer,
                        );
                    } else {
                        device.cmd_draw_indirect_count(
                            cmd_buffer,
                            indirect_buffer,
                            offset_in_buffer,
                            count_buffer,
                            offset_in_count_buffer,
                            max_draw_count,
                            stride_in_buffer,
                        );
                    }
                } else {
                    let draw_count = if spec.draw_count_is_zero { 0 } else { DRAW_COUNT };
                    if indexed {
                        device.cmd_draw_indexed_indirect(
                            cmd_buffer,
                            indirect_buffer,
                            offset_in_buffer,
                            draw_count,
                            stride_in_buffer,
                        );
                    } else {
                        device.cmd_draw_indirect(
                            cmd_buffer,
                            indirect_buffer,
                            offset_in_buffer,
                            draw_count,
                            stride_in_buffer,
                        );
                    }
                }
            } else {
                for draw_ndx in 0..DRAW_COUNT {
                    let offset = offset_in_buffer + (draw_ndx * stride_in_buffer) as vk::DeviceSize;
                    if spec.test_indirect_count_ext != IndirectCountType::None {
                        let max_draw_count = if spec.test_indirect_count_ext == IndirectCountType::BufferLimit {
                            DRAW_COUNT + INDIRECT_COUNT_EXT_DRAW_PADDING
                        } else if spec.draw_count_is_zero {
                            0
                        } else {
                            1
                        };
                        let count_buffer = count_buffer.expect("count buffer");
                        if indexed {
                            device.cmd_draw_indexed_indirect_count(
                                cmd_buffer,
                                indirect_buffer,
                                offset,
                                count_buffer,
                                offset_in_count_buffer,
                                max_draw_count,
                                stride_in_buffer,
                            );
                        } else {
                            device.cmd_draw_indirect_count(
                                cmd_buffer,
                                indirect_buffer,
                                offset,
                                count_buffer,
                                offset_in_count_buffer,
                                max_draw_count,
                                stride_in_buffer,
                            );
                        }
                    } else {
                        let draw_count = if spec.draw_count_is_zero { 0 } else { 1 };
                        if indexed {
                            device.cmd_draw_indexed_indirect(cmd_buffer, indirect_buffer, offset, draw_count, 0);
                        } else {
                            device.cmd_draw_indirect(cmd_buffer, indirect_buffer, offset, draw_count, 0);
                        }
                    }
                }
            }
        }
        Ok(())
    }
}

const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
/// `kOOBDrawCount`
const OOB_DRAW_COUNT: u32 = 4096;

impl IndirectDraw<'_> {
    /// `IndirectDrawCountClampTest::setVertexBuffer`
    fn count_clamp_vertex_buffer() -> Vec<VertexElementData> {
        let mut data = Vec::new();
        let mut ref_vertex_index = 2;

        for _ in 0..VERTEX_OFFSET {
            data.push(vertex(-1.0, 1.0, BLUE, -1));
        }
        ref_vertex_index += VERTEX_OFFSET;

        data.push(vertex(1.0, -1.0, BLUE, -1));
        data.push(vertex(-1.0, 1.0, BLUE, -1));

        // VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST
        let quad = |size: f32| {
            [
                (-size, -size),
                (-size, size),
                (size, -size),
                (size, -size),
                (size, size),
                (-size, size),
            ]
        };
        for (color, size) in [(BLUE, 0.3), (GREEN, 0.2), (RED, 0.3), (RED, 0.2)] {
            for (x, y) in quad(size) {
                data.push(vertex(x, y, color, ref_vertex_index));
                ref_vertex_index += 1;
            }
        }

        data.push(vertex(-1.0, 1.0, BLUE, -1));
        data
    }

    /// `IndirectDrawCountClampTest::iterate`
    fn iterate_count_clamp(&self) -> TestOutcome {
        let context = self.context;
        let spec = self.spec;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let data = Self::count_clamp_vertex_buffer();
        let data_len = data.len();
        let base = DrawTestsBase::new(
            context,
            "vert",
            "frag",
            spec.group_params,
            spec.topology,
            spec.layer_count,
            DEFAULT_RENDER_SIZE,
            DEFAULT_RENDER_SIZE,
            data,
        )?;

        let index_vec: Vec<u32> = (0..(data_len - VERTEX_OFFSET as usize) as u32).collect();
        let index_buffer = create_host_buffer(context, &index_vec, vk::BufferUsageFlags::INDEX_BUFFER)?;

        let offset_in_buffer = (1024 * std::mem::size_of::<u32>()) as vk::DeviceSize;
        let draw_commands = [
            vk::DrawIndexedIndirectCommand {
                index_count: 3,
                instance_count: 1,
                first_index: 2,
                vertex_offset: VERTEX_OFFSET,
                first_instance: 0,
            },
            vk::DrawIndexedIndirectCommand {
                index_count: -4i32 as u32,
                instance_count: -2i32 as u32,
                first_index: -11i32 as u32,
                vertex_offset: 9,
                first_instance: -7i32 as u32,
            }, // junk (stride)
            vk::DrawIndexedIndirectCommand {
                index_count: 3,
                instance_count: 1,
                first_index: 5,
                vertex_offset: VERTEX_OFFSET,
                first_instance: 0,
            },
            vk::DrawIndexedIndirectCommand {
                index_count: 3,
                instance_count: 1,
                first_index: 8,
                vertex_offset: VERTEX_OFFSET,
                first_instance: 0,
            },
            vk::DrawIndexedIndirectCommand {
                index_count: 3,
                instance_count: 1,
                first_index: 11,
                vertex_offset: VERTEX_OFFSET,
                first_instance: 0,
            },
        ];
        let mut sequence = vec![0usize, 1, 2, 1];
        // Add padding data to the buffer to make sure it's large enough.
        for _ in 0..2 * DRAW_COUNT {
            sequence.extend_from_slice(&[3, 1, 4, 1]);
        }
        let mut contents = Vec::new();
        for ndx in sequence {
            let bytes = unsafe {
                std::slice::from_raw_parts(
                    (&draw_commands[ndx] as *const vk::DrawIndexedIndirectCommand).cast::<u8>(),
                    std::mem::size_of::<vk::DrawIndexedIndirectCommand>(),
                )
            };
            contents.extend_from_slice(bytes);
        }
        let stride_in_buffer = 2 * std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32;

        let data_size = contents.len() as vk::DeviceSize;
        let indirect_buffer_size = data_size + offset_in_buffer;
        let indirect_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(indirect_buffer_size, vk::BufferUsageFlags::INDIRECT_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let ptr = indirect_buffer.get_allocation().get_host_ptr();
            let junk = [0xEFBE_ADDEu32; 1024];
            std::ptr::copy_nonoverlapping(junk.as_ptr().cast::<u8>(), ptr, offset_in_buffer as usize);
            std::ptr::copy_nonoverlapping(
                contents.as_ptr(),
                ptr.add(offset_in_buffer as usize),
                data_size as usize,
            );
        }
        flush_alloc(device, indirect_buffer.get_allocation())?;

        let count_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let indirect_count_buffer =
            create_host_buffer(context, &[OOB_DRAW_COUNT], vk::BufferUsageFlags::INDIRECT_BUFFER)?;

        let indirect_handle = indirect_buffer.get();
        let index_handle = index_buffer.get();
        let count_handle = indirect_count_buffer.get();
        base.record_commands_hooked(
            |_| {},
            |cmd_buffer| self.count_buffer_barrier(device, cmd_buffer, count_handle, count_buffer_size),
            |cmd_buffer| {
                unsafe {
                    device.cmd_bind_index_buffer(
                        cmd_buffer,
                        index_handle,
                        spec.bind_index_buffer_offset,
                        vk::IndexType::UINT32,
                    );

                    let max_draw_count = DRAW_COUNT * 2;
                    if spec.use_multi_draw {
                        device.cmd_draw_indexed_indirect_count(
                            cmd_buffer,
                            indirect_handle,
                            offset_in_buffer,
                            count_handle,
                            0,
                            max_draw_count,
                            stride_in_buffer,
                        );
                    } else {
                        for draw_ndx in 0..DRAW_COUNT {
                            device.cmd_draw_indexed_indirect_count(
                                cmd_buffer,
                                indirect_handle,
                                offset_in_buffer + (draw_ndx * stride_in_buffer) as vk::DeviceSize,
                                count_handle,
                                0,
                                max_draw_count,
                                stride_in_buffer,
                            );
                        }
                    }
                }
                Ok(())
            },
            |_| {},
        )?;
        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *base.cmd_buffer)?;

        // Validation
        let mut reference_frame = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            base.render_width,
            base.render_height,
            1,
        )?;
        {
            let (frame_width, frame_height) = (base.render_width, base.render_height);
            let outer = ReferenceImageCoordinates::default();
            let inner = ReferenceImageCoordinates {
                left: -0.2,
                right: 0.2,
                top: 0.2,
                bottom: -0.2,
            };
            let mut access = reference_frame.get_access();
            for y in 0..frame_height {
                for x in 0..frame_width {
                    access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
            for y in 0..frame_height {
                let y_coord = (y as f64 / (0.5 * frame_height as f64)) as f32 - 1.0;

                for x in 0..frame_width {
                    let x_coord = (x as f64 / (0.5 * frame_width as f64)) as f32 - 1.0;

                    if f64::from(y_coord) >= outer.bottom
                        && f64::from(y_coord) <= outer.top
                        && f64::from(x_coord) >= outer.left
                        && f64::from(x_coord) <= outer.right
                    {
                        access.set_pixel(BLUE, x, y, 0);
                    }

                    if f64::from(y_coord) >= inner.bottom
                        && f64::from(y_coord) <= inner.top
                        && f64::from(x_coord) >= inner.left
                        && f64::from(x_coord) <= inner.right
                    {
                        access.set_pixel(GREEN, x, y, 0);
                    }
                }
            }
        }
        base.compare_with_target(queue, &reference_frame)
    }
}

impl TestInstance for IndirectDraw<'_> {
    /// `IndirectDraw::iterate`
    fn iterate(&mut self) -> TestOutcome {
        if self.spec.count_clamp {
            return self.iterate_count_clamp();
        }

        let context = self.context;
        let spec = self.spec;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        let data = if spec.test_first_instance_ndx {
            self.set_first_instance_vertex_buffer()?
        } else {
            self.set_vertex_buffer()?
        };
        let data_len = data.len();
        let base = DrawTestsBase::new(
            context,
            "vert",
            "frag",
            spec.group_params,
            spec.topology,
            spec.layer_count,
            DEFAULT_RENDER_SIZE,
            DEFAULT_RENDER_SIZE,
            data,
        )?;

        // The index buffer, bound at an offset in memory and in the buffer.
        let index_buffer = if spec.draw_type == DrawType::Indexed {
            let index_count = data_len - VERTEX_OFFSET as usize;
            let index_vec: Vec<u32> = (0..index_count as u32).collect();
            let buffer_size =
                (index_vec.len() * std::mem::size_of::<u32>()) as vk::DeviceSize + spec.bind_index_buffer_offset;

            let atom_size = context.get_device_properties().limits.non_coherent_atom_size;
            let allocator = SimpleAllocator::with_offset(
                *alloc.memory_properties(),
                OffsetParams {
                    non_coherent_atom_size: atom_size,
                    offset: spec.index_buffer_alloc_offset,
                },
            );
            let buffer = BufferWithMemory::new(
                device,
                &allocator,
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::INDEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                let buffer_start = buffer.get_allocation().get_host_ptr();
                std::ptr::write_bytes(buffer_start, 0xFF, spec.bind_index_buffer_offset as usize);
                std::ptr::copy_nonoverlapping(
                    index_vec.as_ptr().cast::<u8>(),
                    buffer_start.add(spec.bind_index_buffer_offset as usize),
                    index_vec.len() * std::mem::size_of::<u32>(),
                );
            }
            flush_alloc(device, buffer.get_allocation())?;
            Some(buffer)
        } else {
            None
        };

        // The indirect buffer: junk data, then the commands.
        let offset_in_buffer = (1024 * std::mem::size_of::<u32>()) as vk::DeviceSize;
        let (indirect_buffer_contents, stride_in_buffer) = self.build_indirect_buffer_contents()?;
        let data_size = indirect_buffer_contents.len() as vk::DeviceSize;
        let indirect_buffer_size = data_size + offset_in_buffer;
        let mut usage_flags = vk::BufferUsageFlags::INDIRECT_BUFFER;
        if spec.data_from_compute {
            usage_flags |= vk::BufferUsageFlags::STORAGE_BUFFER;
        }

        let indirect_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(indirect_buffer_size, usage_flags),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let ptr = indirect_buffer.get_allocation().get_host_ptr();
            let junk = [0xEFBE_ADDEu32; 1024];
            std::ptr::copy_nonoverlapping(junk.as_ptr().cast::<u8>(), ptr, offset_in_buffer as usize);
            std::ptr::copy_nonoverlapping(
                indirect_buffer_contents.as_ptr(),
                ptr.add(offset_in_buffer as usize),
                data_size as usize,
            );

            if spec.data_from_compute {
                // Negate all the buffer data and let a compute shader restore it to original.
                for i in 0..indirect_buffer_size as usize {
                    *ptr.add(i) = !*ptr.add(i);
                }
            }
        }
        flush_alloc(device, indirect_buffer.get_allocation())?;

        let offset_in_count_buffer = (3 * std::mem::size_of::<f32>()) as vk::DeviceSize;
        let count_buffer_size = offset_in_count_buffer + std::mem::size_of::<u32>() as vk::DeviceSize;

        let indirect_count_buffer = if spec.test_indirect_count_ext != IndirectCountType::None {
            let buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(count_buffer_size, usage_flags),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                let count_buffer_ptr = buffer.get_allocation().get_host_ptr();

                // For IndirectCountType::ParamLimit, the real limit will be set using the call parameter.
                let count = if spec.instanced.is_some() {
                    if spec.use_multi_draw {
                        DRAW_COUNT
                            + if spec.test_indirect_count_ext == IndirectCountType::BufferLimit {
                                0
                            } else {
                                INDIRECT_COUNT_EXT_DRAW_PADDING
                            }
                    } else {
                        1
                    }
                } else if spec.use_multi_draw {
                    if spec.test_indirect_count_ext == IndirectCountType::BufferLimit {
                        if spec.draw_count_is_zero { 0 } else { DRAW_COUNT }
                    } else {
                        DRAW_COUNT + INDIRECT_COUNT_EXT_DRAW_PADDING
                    }
                } else if spec.test_indirect_count_ext == IndirectCountType::BufferLimit {
                    if spec.draw_count_is_zero { 0 } else { 1 }
                } else {
                    DRAW_COUNT + INDIRECT_COUNT_EXT_DRAW_PADDING
                };
                std::ptr::write_bytes(count_buffer_ptr, 0, offset_in_count_buffer as usize);
                count_buffer_ptr
                    .add(offset_in_count_buffer as usize)
                    .cast::<u32>()
                    .write_unaligned(count);

                if spec.data_from_compute {
                    // Negate all the buffer data and let a compute shader restore it to original.
                    for i in 0..count_buffer_size as usize {
                        *count_buffer_ptr.add(i) = !*count_buffer_ptr.add(i);
                    }
                }
            }
            flush_alloc(device, buffer.get_allocation())?;
            Some(buffer)
        } else {
            None
        };

        // `negateDataUsingCompute`'s objects
        let negate = if spec.data_from_compute {
            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .build(device)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;

            // Indirect buffer
            let descriptor_set_indirect_buffer = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
            let buffer_descriptor_info = vk::DescriptorBufferInfo {
                buffer: indirect_buffer.get(),
                offset: 0,
                range: indirect_buffer_size,
            };
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    descriptor_set_indirect_buffer.get(),
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &buffer_descriptor_info,
                )
                .update(device);

            // Indirect count buffer
            let descriptor_set_count_buffer = if let Some(count_buffer) = &indirect_count_buffer {
                let set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
                let buffer_descriptor_info = vk::DescriptorBufferInfo {
                    buffer: count_buffer.get(),
                    offset: 0,
                    range: count_buffer_size,
                };
                DescriptorSetUpdateBuilder::new()
                    .write_single(
                        set.get(),
                        Location::binding(0),
                        vk::DescriptorType::STORAGE_BUFFER,
                        &buffer_descriptor_info,
                    )
                    .update(device);
                Some(set)
            } else {
                None
            };

            let binaries = context.get_binary_collection();
            let compute_shader_module = create_shader_module(device, binaries.get("comp")?)?;
            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*compute_shader_module)
                .name(b"main\0")
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(-1)
                .build();
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            let pipeline = Unique::new(device, pipelines.0[0]);

            let host_write_barrier = make_buffer_memory_barrier(
                if spec.use_memory_access {
                    vk::AccessFlags::MEMORY_WRITE
                } else {
                    vk::AccessFlags::HOST_WRITE
                },
                if spec.use_memory_access {
                    vk::AccessFlags::MEMORY_READ
                } else {
                    vk::AccessFlags::SHADER_READ
                },
                indirect_buffer.get(),
                0,
                indirect_buffer_size,
            );
            let indirect_draw_barrier = make_buffer_memory_barrier(
                if spec.use_memory_access {
                    vk::AccessFlags::MEMORY_WRITE
                } else {
                    vk::AccessFlags::SHADER_WRITE
                },
                if spec.use_memory_access {
                    vk::AccessFlags::MEMORY_READ
                } else {
                    vk::AccessFlags::INDIRECT_COMMAND_READ
                },
                indirect_buffer.get(),
                0,
                indirect_buffer_size,
            );

            Some(NegateObjects {
                pipeline,
                pipeline_layout,
                descriptor_set_indirect_buffer,
                descriptor_set_count_buffer,
                _descriptor_pool: descriptor_pool,
                _descriptor_set_layout: descriptor_set_layout,
                _compute_shader_module: compute_shader_module,
                host_write_barrier,
                indirect_draw_barrier,
            })
        } else {
            None
        };

        let indirect_handle = indirect_buffer.get();
        let index_handle = index_buffer.as_ref().map(|buffer| buffer.get());
        let count_handle = indirect_count_buffer.as_ref().map(|buffer| buffer.get());

        base.record_commands_hooked(
            |cmd_buffer| {
                let Some(negate) = &negate else { return };
                unsafe {
                    device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *negate.pipeline);
                    device.cmd_bind_descriptor_sets(
                        cmd_buffer,
                        vk::PipelineBindPoint::COMPUTE,
                        *negate.pipeline_layout,
                        0,
                        &[negate.descriptor_set_indirect_buffer.get()],
                        &[] as &[u32],
                    );
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[negate.host_write_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                    device.cmd_dispatch(cmd_buffer, 1, 1, 1);
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::DRAW_INDIRECT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[negate.indirect_draw_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );

                    if let Some(descriptor_set_count_buffer) = &negate.descriptor_set_count_buffer {
                        device.cmd_bind_descriptor_sets(
                            cmd_buffer,
                            vk::PipelineBindPoint::COMPUTE,
                            *negate.pipeline_layout,
                            0,
                            &[descriptor_set_count_buffer.get()],
                            &[] as &[u32],
                        );
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::HOST,
                            vk::PipelineStageFlags::COMPUTE_SHADER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[negate.host_write_barrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                        device.cmd_dispatch(cmd_buffer, 1, 1, 1);
                        device.cmd_pipeline_barrier(
                            cmd_buffer,
                            vk::PipelineStageFlags::COMPUTE_SHADER,
                            vk::PipelineStageFlags::DRAW_INDIRECT,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[negate.indirect_draw_barrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                    }
                }
            },
            |cmd_buffer| {
                if let Some(count_handle) = count_handle {
                    self.count_buffer_barrier(device, cmd_buffer, count_handle, count_buffer_size);
                }
            },
            |cmd_buffer| {
                self.draw(
                    cmd_buffer,
                    indirect_handle,
                    index_handle,
                    count_handle,
                    offset_in_buffer,
                    offset_in_count_buffer,
                    stride_in_buffer,
                )
            },
            |_| {},
        )?;
        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *base.cmd_buffer)?;

        // Validation
        let fill = if spec.draw_count_is_zero {
            [0.0, 0.0, 0.0, 1.0]
        } else {
            [0.0, 0.0, 1.0, 1.0]
        };
        let reference_frame = if spec.instanced.is_some() {
            let coords = ReferenceImageInstancedCoordinates::default();
            base.make_rect_reference(
                [0.0, 0.0, 0.0, 1.0],
                fill,
                coords.left,
                coords.right,
                coords.top,
                coords.bottom,
            )?
        } else {
            let coords = ReferenceImageCoordinates::default();
            base.make_rect_reference(
                [0.0, 0.0, 0.0, 1.0],
                fill,
                coords.left,
                coords.right,
                coords.top,
                coords.bottom,
            )?
        };
        base.compare_with_target(queue, &reference_frame)
    }
}

/// One `TestSpec` per case of `DrawIndirectTests::init` for the draw type; the `testSpec` mutations upstream makes
/// between `addChild` calls are the argument lists here.
fn add_cases(group: &mut TestCaseGroup, mut spec: TestSpec, with_count_zero: bool, with_memory_access: bool) {
    let add = |group: &mut TestCaseGroup, name: &'static str, spec: TestSpec| {
        group.add_child(Box::new(IndirectDrawCase { name, spec }) as Box<dyn TestCase>);
    };

    spec.topology = vk::PrimitiveTopology::TRIANGLE_LIST;
    add(group, "triangle_list", spec);
    {
        let mut multi = spec;
        multi.use_multi_draw = true;
        add(group, "triangle_list_multi_draw", multi);
    }

    // Set draw count to 0
    if with_count_zero {
        spec.draw_count_is_zero = true;
        add(group, "triangle_list_count_0", spec);
        {
            let mut multi = spec;
            multi.use_multi_draw = true;
            add(group, "triangle_list_multi_draw_count_0", multi);
        }
        spec.draw_count_is_zero = false;
    }

    spec.topology = vk::PrimitiveTopology::TRIANGLE_STRIP;
    add(group, "triangle_strip", spec);

    // test using V_ACCESS_MEMORY_WRITE/READ_BIT - there is no need to repeat this case for different drawing options
    if with_memory_access {
        spec.use_memory_access = true;
        add(group, "triangle_strip_memory_access", spec);
    }
}

/// `DrawIndirectTests::init`
pub fn create_indirect_draw_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indirect_draw");

    for data_from_compute in [false, true] {
        for (draw_type_ndx, draw_type) in [DrawType::Sequential, DrawType::Indexed].into_iter().enumerate() {
            for bind_index_buffer_offset in [0 as vk::DeviceSize, (std::mem::size_of::<u32>() * 4) as vk::DeviceSize] {
                for index_buffer_alloc_offset in
                    [0 as vk::DeviceSize, (std::mem::size_of::<f32>() * 4) as vk::DeviceSize]
                {
                    let non_zero_bind_index_buffer_offset = bind_index_buffer_offset > 0;
                    let non_zero_alloc_offset = index_buffer_alloc_offset > 0;

                    if non_zero_bind_index_buffer_offset && draw_type != DrawType::Indexed {
                        continue;
                    }
                    if non_zero_alloc_offset && draw_type != DrawType::Indexed {
                        continue;
                    }

                    // reduce number of tests for dynamic rendering cases where secondary command buffer is used
                    if group_params.use_secondary_cmd_buffer
                        && data_from_compute == group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass
                    {
                        continue;
                    }

                    let mut draw_type_str = String::from(if draw_type_ndx == 0 { "sequential" } else { "indexed" });
                    if data_from_compute {
                        draw_type_str.push_str("_data_from_compute");
                    }
                    if non_zero_bind_index_buffer_offset {
                        draw_type_str.push_str(&format!("_bind_offset_{bind_index_buffer_offset}"));
                    }
                    if non_zero_alloc_offset {
                        draw_type_str.push_str(&format!("_alloc_offset_{index_buffer_alloc_offset}"));
                    }

                    let mut draw_type_group = TestCaseGroup::new(draw_type_str);

                    let base_spec = TestSpec {
                        group_params,
                        topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                        draw_type,
                        require_indirect_first_instance: false,
                        test_first_instance_ndx: false,
                        test_indirect_count_ext: IndirectCountType::None,
                        data_from_compute,
                        use_memory_access: false,
                        layer_count: 1,
                        bind_index_buffer_offset,
                        index_buffer_alloc_offset,
                        draw_count_is_zero: false,
                        use_multi_draw: false,
                        instanced: None,
                        count_clamp: false,
                    };
                    let with_count_zero = !data_from_compute
                        && !group_params.use_secondary_cmd_buffer
                        && !non_zero_bind_index_buffer_offset
                        && index_buffer_alloc_offset == 0;
                    let with_memory_access = data_from_compute
                        && draw_type_ndx != 0
                        && !group_params.use_dynamic_rendering
                        && !group_params.use_secondary_cmd_buffer;

                    // Draws geometry
                    let mut indirect_draw_group = TestCaseGroup::new("indirect_draw");
                    add_cases(&mut indirect_draw_group, base_spec, with_count_zero, with_memory_access);

                    // Draws geometry with VK_KHR_draw_indirect_count extension
                    let mut indirect_draw_count_group = TestCaseGroup::new("indirect_draw_count");
                    add_cases(
                        &mut indirect_draw_count_group,
                        TestSpec {
                            test_indirect_count_ext: IndirectCountType::BufferLimit,
                            ..base_spec
                        },
                        with_count_zero,
                        with_memory_access,
                    );

                    // The count limit is the call parameter. Upstream does not repeat the memory access case here.
                    let mut indirect_draw_param_count_group = TestCaseGroup::new("indirect_draw_param_count");
                    add_cases(
                        &mut indirect_draw_param_count_group,
                        TestSpec {
                            test_indirect_count_ext: IndirectCountType::ParamLimit,
                            ..base_spec
                        },
                        with_count_zero,
                        false,
                    );

                    // Multiview: two layers
                    let mut indirect_draw_multiview_group = TestCaseGroup::new("indirect_draw_multiview");
                    {
                        let spec = TestSpec {
                            test_indirect_count_ext: IndirectCountType::BufferLimit,
                            layer_count: 2,
                            ..base_spec
                        };
                        indirect_draw_multiview_group.add_child(Box::new(IndirectDrawCase {
                            name: "triangle_list",
                            spec,
                        }) as Box<dyn TestCase>);
                        let multi = TestSpec {
                            use_multi_draw: true,
                            ..spec
                        };
                        indirect_draw_multiview_group.add_child(Box::new(IndirectDrawCase {
                            name: "triangle_list_multi_draw",
                            spec: multi,
                        }) as Box<dyn TestCase>);
                    }

                    draw_type_group.add_child(indirect_draw_group);
                    draw_type_group.add_child(indirect_draw_count_group);
                    draw_type_group.add_child(indirect_draw_param_count_group);
                    draw_type_group.add_child(indirect_draw_multiview_group);

                    // The same with a vertex shader that compares gl_InstanceIndex against the first instance.
                    let first_instance_spec = TestSpec {
                        require_indirect_first_instance: true,
                        test_first_instance_ndx: true,
                        ..base_spec
                    };
                    let mut indirect_draw_first_instance_group = TestCaseGroup::new("indirect_draw_first_instance");
                    let mut indirect_draw_count_first_instance_group =
                        TestCaseGroup::new("indirect_draw_count_first_instance");
                    let mut indirect_draw_param_count_first_instance_group =
                        TestCaseGroup::new("indirect_draw_param_count_first_instance");
                    for (first_instance_group, count_type) in [
                        (&mut indirect_draw_first_instance_group, IndirectCountType::None),
                        (
                            &mut indirect_draw_count_first_instance_group,
                            IndirectCountType::BufferLimit,
                        ),
                        (
                            &mut indirect_draw_param_count_first_instance_group,
                            IndirectCountType::ParamLimit,
                        ),
                    ] {
                        let spec = TestSpec {
                            test_indirect_count_ext: count_type,
                            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                            ..first_instance_spec
                        };
                        first_instance_group.add_child(Box::new(IndirectDrawCase {
                            name: "triangle_list",
                            spec,
                        }) as Box<dyn TestCase>);
                        let spec = TestSpec {
                            topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                            ..spec
                        };
                        first_instance_group.add_child(Box::new(IndirectDrawCase {
                            name: "triangle_strip",
                            spec,
                        }) as Box<dyn TestCase>);
                    }
                    draw_type_group.add_child(indirect_draw_first_instance_group);
                    draw_type_group.add_child(indirect_draw_count_first_instance_group);
                    draw_type_group.add_child(indirect_draw_param_count_first_instance_group);

                    // `IndirectDrawInstanced`: four instances per command, with and without a first instance.
                    let mut instanced_groups = [
                        (TestCaseGroup::new("indirect_draw_instanced"), IndirectCountType::None),
                        (
                            TestCaseGroup::new("indirect_draw_count_instanced"),
                            IndirectCountType::BufferLimit,
                        ),
                        (
                            TestCaseGroup::new("indirect_draw_param_count_instanced"),
                            IndirectCountType::ParamLimit,
                        ),
                    ];
                    for (instanced_group, count_type) in &mut instanced_groups {
                        for (leaf_name, first_instance, require_first_instance) in
                            [("no_first_instance", 0u32, false), ("first_instance", 2u32, true)]
                        {
                            let mut leaf_group = TestCaseGroup::new(leaf_name);
                            let spec = TestSpec {
                                require_indirect_first_instance: require_first_instance,
                                test_indirect_count_ext: *count_type,
                                topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                                instanced: Some(first_instance),
                                ..base_spec
                            };
                            leaf_group.add_child(Box::new(IndirectDrawCase {
                                name: "triangle_list",
                                spec,
                            }) as Box<dyn TestCase>);
                            leaf_group.add_child(Box::new(IndirectDrawCase {
                                name: "triangle_list_multi_draw",
                                spec: TestSpec {
                                    use_multi_draw: true,
                                    ..spec
                                },
                            }) as Box<dyn TestCase>);
                            let spec = TestSpec {
                                topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                                ..spec
                            };
                            leaf_group.add_child(Box::new(IndirectDrawCase {
                                name: "triangle_strip",
                                spec,
                            }) as Box<dyn TestCase>);
                            instanced_group.add_child(leaf_group);
                        }
                    }
                    for (instanced_group, _) in instanced_groups {
                        draw_type_group.add_child(instanced_group);
                    }

                    group.add_child(draw_type_group);
                }
            }
        }
    }

    // `indexed_draw_count_clamping`
    {
        let mut test_group = TestCaseGroup::new("indexed_draw_count_clamping");
        let spec = TestSpec {
            group_params,
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            draw_type: DrawType::Indexed,
            require_indirect_first_instance: false,
            test_first_instance_ndx: false,
            test_indirect_count_ext: IndirectCountType::BufferLimit,
            data_from_compute: false,
            use_memory_access: false,
            layer_count: 1,
            bind_index_buffer_offset: 0,
            index_buffer_alloc_offset: 0,
            draw_count_is_zero: false,
            use_multi_draw: false,
            instanced: None,
            count_clamp: true,
        };
        test_group.add_child(Box::new(IndirectDrawCase {
            name: "triangle_list",
            spec,
        }) as Box<dyn TestCase>);
        test_group.add_child(Box::new(IndirectDrawCase {
            name: "triangle_list_multi_draw",
            spec: TestSpec {
                use_multi_draw: true,
                ..spec
            },
        }) as Box<dyn TestCase>);
        group.add_child(test_group);
    }
    group
}
