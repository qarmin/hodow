// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkRayTracingUtil.cpp (BottomLevelAccelerationStructure / TopLevelAccelerationStructure, the triangle case)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written by hand for hodow_cts. Only what `makeDefaultAccelerationStructure` of the mutable descriptor tests needs: a bottom level structure of one
// triangle and a top level structure of one instance of it, built on the device with traditional memory.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, KhrAccelerationStructureExtensionDeviceCommands};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier,
};

/// The largest `minAccelerationStructureScratchOffsetAlignment` the specification allows.
const SCRATCH_ALIGNMENT: u64 = 256;
/// `VK_GEOMETRY_INSTANCE_TRIANGLE_FACING_CULL_DISABLE_BIT_KHR`
const INSTANCE_TRIANGLE_FACING_CULL_DISABLE: u32 = 1;

fn buffer_address(device: &Device, buffer: vk::Buffer) -> vk::DeviceAddress {
    let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer);
    unsafe { device.get_buffer_device_address(&info) }
}

fn address_const(address: vk::DeviceAddress) -> vk::DeviceOrHostAddressConstKHR {
    vk::DeviceOrHostAddressConstKHR {
        device_address: address,
    }
}

fn host_visible_address_buffer<'a>(
    device: &'a Device,
    alloc: &SimpleAllocator,
    bytes: &[u8],
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(
            bytes.len() as vk::DeviceSize,
            usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// One built structure and the buffer that backs it.
struct Built<'a> {
    handle: vk::AccelerationStructureKHR,
    _storage: BufferWithMemory<'a>,
}

/// Sizes, creates and records the build of the structure `geometry` describes into `cmd`; the scratch buffer is returned to be kept until the build ran.
fn record_build<'a>(
    device: &'a Device,
    alloc: &SimpleAllocator,
    cmd: vk::CommandBuffer,
    as_type: vk::AccelerationStructureTypeKHR,
    geometry: &vk::AccelerationStructureGeometryKHR,
    primitive_count: u32,
) -> Result<(Built<'a>, BufferWithMemory<'a>), TestError> {
    let mut build_info = vk::AccelerationStructureBuildGeometryInfoKHR {
        type_: as_type,
        flags: vk::BuildAccelerationStructureFlagsKHR::empty(),
        mode: vk::BuildAccelerationStructureModeKHR::BUILD,
        geometry_count: 1,
        geometries: geometry,
        ..Default::default()
    };
    let mut sizes = vk::AccelerationStructureBuildSizesInfoKHR::default();
    unsafe {
        device.get_acceleration_structure_build_sizes_khr(
            vk::AccelerationStructureBuildTypeKHR::DEVICE,
            &build_info,
            &[primitive_count],
            &mut sizes,
        )
    };

    let storage = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(
            sizes.acceleration_structure_size,
            vk::BufferUsageFlags::ACCELERATION_STRUCTURE_STORAGE_KHR | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::ANY | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    let create_info = vk::AccelerationStructureCreateInfoKHR {
        buffer: storage.get(),
        offset: 0,
        size: sizes.acceleration_structure_size,
        type_: as_type,
        ..Default::default()
    };
    let handle = unsafe { device.create_acceleration_structure_khr(&create_info, None) }
        .vk_check("vkCreateAccelerationStructureKHR")?;
    let built = Built {
        handle,
        _storage: storage,
    };

    let scratch = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(
            sizes.build_scratch_size + SCRATCH_ALIGNMENT,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::ANY | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    let scratch_address = buffer_address(device, scratch.get()).next_multiple_of(SCRATCH_ALIGNMENT);
    build_info.dst_acceleration_structure = built.handle;
    build_info.scratch_data = vk::DeviceOrHostAddressKHR {
        device_address: scratch_address,
    };

    let range = vk::AccelerationStructureBuildRangeInfoKHR {
        primitive_count,
        primitive_offset: 0,
        first_vertex: 0,
        transform_offset: 0,
    };
    unsafe { device.cmd_build_acceleration_structures_khr(cmd, &[build_info], &[&[range][..]]) };
    Ok((built, scratch))
}

/// A top level structure with one instance of a bottom level structure with one triangle (or one box when not `triangles`) around `(offset_x, 0)` at depth 5.
pub struct TriangleAccelerationStructure<'a> {
    device: &'a Device,
    tlas: Built<'a>,
    blas: Built<'a>,
    _buffers: Vec<BufferWithMemory<'a>>,
}

impl<'a> TriangleAccelerationStructure<'a> {
    /// `makeDefaultAccelerationStructure`, built and waited for on `queue`.
    pub fn new(
        device: &'a Device,
        alloc: &SimpleAllocator,
        queue_family_index: u32,
        queue: vk::Queue,
        offset_x: u16,
        triangles: bool,
    ) -> Result<Self, TestError> {
        let middle_x = f32::from(offset_x);
        let (left_x, right_x, top_y, bottom_y, depth) = (middle_x - 0.5, middle_x + 0.5, 0.5f32, -0.5f32, 5.0f32);
        let build_input_usage = vk::BufferUsageFlags::ACCELERATION_STRUCTURE_BUILD_INPUT_READ_ONLY_KHR;
        let (vertices, geometry_type): (Vec<f32>, _) = if triangles {
            (
                vec![
                    middle_x, top_y, depth, right_x, bottom_y, depth, left_x, bottom_y, depth,
                ],
                vk::GeometryTypeKHR::TRIANGLES,
            )
        } else {
            (
                vec![left_x, bottom_y, depth, right_x, top_y, depth],
                vk::GeometryTypeKHR::AABBS,
            )
        };
        let vertex_bytes: Vec<u8> = vertices.iter().flat_map(|v| v.to_ne_bytes()).collect();
        let vertex_buffer = host_visible_address_buffer(device, alloc, &vertex_bytes, build_input_usage)?;
        let vertex_address = buffer_address(device, vertex_buffer.get());

        let blas_geometry = if triangles {
            let triangles = vk::AccelerationStructureGeometryTrianglesDataKHR {
                vertex_format: vk::Format::R32G32B32_SFLOAT,
                vertex_data: address_const(vertex_address),
                vertex_stride: 12,
                max_vertex: 2,
                index_type: vk::IndexType::NONE_KHR,
                ..Default::default()
            };
            vk::AccelerationStructureGeometryKHR {
                geometry_type,
                geometry: vk::AccelerationStructureGeometryDataKHR { triangles },
                flags: vk::GeometryFlagsKHR::NO_DUPLICATE_ANY_HIT_INVOCATION,
                ..Default::default()
            }
        } else {
            let aabbs = vk::AccelerationStructureGeometryAabbsDataKHR {
                data: address_const(vertex_address),
                stride: 24,
                ..Default::default()
            };
            vk::AccelerationStructureGeometryKHR {
                geometry_type,
                geometry: vk::AccelerationStructureGeometryDataKHR { aabbs },
                flags: vk::GeometryFlagsKHR::NO_DUPLICATE_ANY_HIT_INVOCATION,
                ..Default::default()
            }
        };

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        let (blas, blas_scratch) = record_build(
            device,
            alloc,
            cmd,
            vk::AccelerationStructureTypeKHR::BOTTOM_LEVEL,
            &blas_geometry,
            1,
        )?;
        let barrier = make_memory_barrier(
            vk::AccessFlags::ACCELERATION_STRUCTURE_WRITE_KHR,
            vk::AccessFlags::ACCELERATION_STRUCTURE_READ_KHR,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
                vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        // VkAccelerationStructureInstanceKHR: an identity 3x4 transform, customIndex 0 with mask 0xFF, sbt offset 0 with the instance flags, the bottom level address.
        let blas_address = unsafe {
            device.get_acceleration_structure_device_address_khr(&vk::AccelerationStructureDeviceAddressInfoKHR {
                acceleration_structure: blas.handle,
                ..Default::default()
            })
        };
        let mut instance = Vec::with_capacity(64);
        for value in [1.0f32, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0] {
            instance.extend(value.to_ne_bytes());
        }
        instance.extend((0xFFu32 << 24).to_ne_bytes());
        let instance_flags = if triangles {
            INSTANCE_TRIANGLE_FACING_CULL_DISABLE
        } else {
            0
        };
        instance.extend((instance_flags << 24).to_ne_bytes());
        instance.extend(blas_address.to_ne_bytes());
        let instance_buffer = host_visible_address_buffer(
            device,
            alloc,
            &instance,
            vk::BufferUsageFlags::ACCELERATION_STRUCTURE_BUILD_INPUT_READ_ONLY_KHR,
        )?;

        let instances = vk::AccelerationStructureGeometryInstancesDataKHR {
            array_of_pointers: vk::FALSE,
            data: address_const(buffer_address(device, instance_buffer.get())),
            ..Default::default()
        };
        let tlas_geometry = vk::AccelerationStructureGeometryKHR {
            geometry_type: vk::GeometryTypeKHR::INSTANCES,
            geometry: vk::AccelerationStructureGeometryDataKHR { instances },
            flags: vk::GeometryFlagsKHR::empty(),
            ..Default::default()
        };
        let (tlas, tlas_scratch) = record_build(
            device,
            alloc,
            cmd,
            vk::AccelerationStructureTypeKHR::TOP_LEVEL,
            &tlas_geometry,
            1,
        )?;

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        Ok(Self {
            device,
            tlas,
            blas,
            _buffers: vec![vertex_buffer, instance_buffer, blas_scratch, tlas_scratch],
        })
    }

    /// The handle of the top level structure; the address stays valid as long as `self` does, for `VkWriteDescriptorSetAccelerationStructureKHR`.
    pub fn tlas(&self) -> &vk::AccelerationStructureKHR {
        &self.tlas.handle
    }
}

impl Drop for TriangleAccelerationStructure<'_> {
    fn drop(&mut self) {
        unsafe {
            self.device.destroy_acceleration_structure_khr(self.tlas.handle, None);
            self.device.destroy_acceleration_structure_khr(self.blas.handle, None);
        }
    }
}

/// A structure created and sized but not yet built: `create` and `build` of upstream's `BottomLevelAccelerationStructure` / `TopLevelAccelerationStructure` apart.
struct PendingBuild<'a> {
    as_type: vk::AccelerationStructureTypeKHR,
    // Boxed because the build info points at it.
    geometry: Box<vk::AccelerationStructureGeometryKHR>,
    primitive_count: u32,
    built: Built<'a>,
    scratch: BufferWithMemory<'a>,
    scratch_address: vk::DeviceAddress,
}

impl<'a> PendingBuild<'a> {
    fn create(
        device: &'a Device,
        alloc: &SimpleAllocator,
        as_type: vk::AccelerationStructureTypeKHR,
        geometry: vk::AccelerationStructureGeometryKHR,
        primitive_count: u32,
    ) -> Result<Self, TestError> {
        let geometry = Box::new(geometry);
        let build_info = vk::AccelerationStructureBuildGeometryInfoKHR {
            type_: as_type,
            flags: vk::BuildAccelerationStructureFlagsKHR::empty(),
            mode: vk::BuildAccelerationStructureModeKHR::BUILD,
            geometry_count: 1,
            geometries: &*geometry,
            ..Default::default()
        };
        let mut sizes = vk::AccelerationStructureBuildSizesInfoKHR::default();
        unsafe {
            device.get_acceleration_structure_build_sizes_khr(
                vk::AccelerationStructureBuildTypeKHR::DEVICE,
                &build_info,
                &[primitive_count],
                &mut sizes,
            )
        };

        let storage = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                sizes.acceleration_structure_size,
                vk::BufferUsageFlags::ACCELERATION_STRUCTURE_STORAGE_KHR | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            ),
            MemoryRequirement::ANY | MemoryRequirement::DEVICE_ADDRESS,
        )?;
        let create_info = vk::AccelerationStructureCreateInfoKHR {
            buffer: storage.get(),
            offset: 0,
            size: sizes.acceleration_structure_size,
            type_: as_type,
            ..Default::default()
        };
        let handle = unsafe { device.create_acceleration_structure_khr(&create_info, None) }
            .vk_check("vkCreateAccelerationStructureKHR")?;
        let built = Built {
            handle,
            _storage: storage,
        };

        let scratch = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                sizes.build_scratch_size + SCRATCH_ALIGNMENT,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            ),
            MemoryRequirement::ANY | MemoryRequirement::DEVICE_ADDRESS,
        )?;
        let scratch_address = buffer_address(device, scratch.get()).next_multiple_of(SCRATCH_ALIGNMENT);
        Ok(Self {
            as_type,
            geometry,
            primitive_count,
            built,
            scratch,
            scratch_address,
        })
    }

    fn record(&self, device: &Device, cmd: vk::CommandBuffer) {
        let build_info = vk::AccelerationStructureBuildGeometryInfoKHR {
            type_: self.as_type,
            flags: vk::BuildAccelerationStructureFlagsKHR::empty(),
            mode: vk::BuildAccelerationStructureModeKHR::BUILD,
            geometry_count: 1,
            geometries: &*self.geometry,
            dst_acceleration_structure: self.built.handle,
            scratch_data: vk::DeviceOrHostAddressKHR {
                device_address: self.scratch_address,
            },
            ..Default::default()
        };
        let range = vk::AccelerationStructureBuildRangeInfoKHR {
            primitive_count: self.primitive_count,
            primitive_offset: 0,
            first_vertex: 0,
            transform_offset: 0,
        };
        unsafe { device.cmd_build_acceleration_structures_khr(cmd, &[build_info], &[&[range][..]]) };
    }
}

/// A top level structure with one instance of a bottom level structure of the given triangles (or one box), created first and built into a command buffer later:
/// `create` and `build` of upstream's structures, as the descriptor update tests use them.
pub struct DeferredAccelerationStructure<'a> {
    device: &'a Device,
    blas: PendingBuild<'a>,
    tlas: PendingBuild<'a>,
    _buffers: Vec<BufferWithMemory<'a>>,
}

impl<'a> DeferredAccelerationStructure<'a> {
    /// `addGeometry(geometryData, triangles)` of one bottom level structure and `addInstance` of it in a top level one; nothing is recorded yet.
    pub fn create(
        device: &'a Device,
        alloc: &SimpleAllocator,
        geometry_data: &[[f32; 3]],
        triangles: bool,
    ) -> Result<Self, TestError> {
        let vertex_bytes: Vec<u8> = geometry_data.iter().flatten().flat_map(|v| v.to_ne_bytes()).collect();
        let vertex_buffer = host_visible_address_buffer(
            device,
            alloc,
            &vertex_bytes,
            vk::BufferUsageFlags::ACCELERATION_STRUCTURE_BUILD_INPUT_READ_ONLY_KHR,
        )?;
        let vertex_address = buffer_address(device, vertex_buffer.get());

        let (blas_geometry, primitive_count) = if triangles {
            let triangles = vk::AccelerationStructureGeometryTrianglesDataKHR {
                vertex_format: vk::Format::R32G32B32_SFLOAT,
                vertex_data: address_const(vertex_address),
                vertex_stride: 12,
                max_vertex: geometry_data.len() as u32 - 1,
                index_type: vk::IndexType::NONE_KHR,
                ..Default::default()
            };
            (
                vk::AccelerationStructureGeometryKHR {
                    geometry_type: vk::GeometryTypeKHR::TRIANGLES,
                    geometry: vk::AccelerationStructureGeometryDataKHR { triangles },
                    flags: vk::GeometryFlagsKHR::empty(),
                    ..Default::default()
                },
                geometry_data.len() as u32 / 3,
            )
        } else {
            let aabbs = vk::AccelerationStructureGeometryAabbsDataKHR {
                data: address_const(vertex_address),
                stride: 24,
                ..Default::default()
            };
            (
                vk::AccelerationStructureGeometryKHR {
                    geometry_type: vk::GeometryTypeKHR::AABBS,
                    geometry: vk::AccelerationStructureGeometryDataKHR { aabbs },
                    flags: vk::GeometryFlagsKHR::empty(),
                    ..Default::default()
                },
                geometry_data.len() as u32 / 2,
            )
        };
        let blas = PendingBuild::create(
            device,
            alloc,
            vk::AccelerationStructureTypeKHR::BOTTOM_LEVEL,
            blas_geometry,
            primitive_count,
        )?;

        let blas_address = unsafe {
            device.get_acceleration_structure_device_address_khr(&vk::AccelerationStructureDeviceAddressInfoKHR {
                acceleration_structure: blas.built.handle,
                ..Default::default()
            })
        };
        let mut instance = Vec::with_capacity(64);
        for value in [1.0f32, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0] {
            instance.extend(value.to_ne_bytes());
        }
        instance.extend((0xFFu32 << 24).to_ne_bytes());
        instance.extend((INSTANCE_TRIANGLE_FACING_CULL_DISABLE << 24).to_ne_bytes());
        instance.extend(blas_address.to_ne_bytes());
        let instance_buffer = host_visible_address_buffer(
            device,
            alloc,
            &instance,
            vk::BufferUsageFlags::ACCELERATION_STRUCTURE_BUILD_INPUT_READ_ONLY_KHR,
        )?;
        let instances = vk::AccelerationStructureGeometryInstancesDataKHR {
            array_of_pointers: vk::FALSE,
            data: address_const(buffer_address(device, instance_buffer.get())),
            ..Default::default()
        };
        let tlas_geometry = vk::AccelerationStructureGeometryKHR {
            geometry_type: vk::GeometryTypeKHR::INSTANCES,
            geometry: vk::AccelerationStructureGeometryDataKHR { instances },
            flags: vk::GeometryFlagsKHR::empty(),
            ..Default::default()
        };
        let tlas = PendingBuild::create(
            device,
            alloc,
            vk::AccelerationStructureTypeKHR::TOP_LEVEL,
            tlas_geometry,
            1,
        )?;

        Ok(Self {
            device,
            blas,
            tlas,
            _buffers: vec![vertex_buffer, instance_buffer],
        })
    }

    /// `build` of the bottom level structure, a barrier, `build` of the top level one.
    pub fn record_build(&self, cmd: vk::CommandBuffer) {
        self.blas.record(self.device, cmd);
        let barrier = make_memory_barrier(
            vk::AccessFlags::ACCELERATION_STRUCTURE_WRITE_KHR,
            vk::AccessFlags::ACCELERATION_STRUCTURE_READ_KHR,
        );
        unsafe {
            self.device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
                vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        self.tlas.record(self.device, cmd);
    }

    /// `getPtr` of the top level structure; the address stays valid as long as `self` does.
    pub fn tlas(&self) -> &vk::AccelerationStructureKHR {
        &self.tlas.built.handle
    }
}

impl Drop for DeferredAccelerationStructure<'_> {
    fn drop(&mut self) {
        unsafe {
            self.device
                .destroy_acceleration_structure_khr(self.tlas.built.handle, None);
            self.device
                .destroy_acceleration_structure_khr(self.blas.built.handle, None);
        }
    }
}
