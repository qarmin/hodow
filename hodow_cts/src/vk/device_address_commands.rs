// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/vulkan/generated/vulkan (the VK_KHR_device_address_commands part of vkDefs.h and the device interface)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written by hand from vk.xml for hodow_cts: vulkanalia 0.35 predates VK_KHR_device_address_commands, so its structures,
// the feature struct and the commands (loaded through vkGetDeviceProcAddr) are declared here. Structure types are the extension's
// (number 319) offsets from 1000318000.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::tcu::TestError;
use crate::vkt::Context;

pub const EXTENSION_NAME: &str = "VK_KHR_device_address_commands";

/// `VkAddressCommandFlagBitsKHR`
pub const ADDRESS_COMMAND_PROTECTED: u32 = 1 << 0;
pub const ADDRESS_COMMAND_FULLY_BOUND: u32 = 1 << 1;
pub const ADDRESS_COMMAND_STORAGE_BUFFER_USAGE: u32 = 1 << 2;
pub const ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE: u32 = 1 << 3;
pub const ADDRESS_COMMAND_TRANSFORM_FEEDBACK_BUFFER_USAGE: u32 = 1 << 4;
pub const ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE: u32 = 1 << 5;

/// `getBufferDeviceAddress`
pub fn buffer_device_address(device: &Device, buffer: vk::Buffer) -> vk::DeviceAddress {
    let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer);
    unsafe { device.get_buffer_device_address(&info) }
}

fn structure_type(offset: i32) -> vk::StructureType {
    vk::StructureType::from_raw(1_000_318_000 + offset)
}

/// `VkDeviceAddressRangeKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct DeviceAddressRange {
    pub address: vk::DeviceAddress,
    pub size: vk::DeviceSize,
}

/// `VkStridedDeviceAddressRangeKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct StridedDeviceAddressRange {
    pub address: vk::DeviceAddress,
    pub size: vk::DeviceSize,
    pub stride: vk::DeviceSize,
}

/// `VkDeviceMemoryCopyKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct DeviceMemoryCopy {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub src_range: DeviceAddressRange,
    pub src_flags: u32,
    pub dst_range: DeviceAddressRange,
    pub dst_flags: u32,
}

impl DeviceMemoryCopy {
    pub fn new(src_range: DeviceAddressRange, dst_range: DeviceAddressRange) -> Self {
        Self {
            s_type: structure_type(0),
            next: std::ptr::null(),
            src_range,
            src_flags: 0,
            dst_range,
            dst_flags: 0,
        }
    }
}

/// `VkCopyDeviceMemoryInfoKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct CopyDeviceMemoryInfo {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub region_count: u32,
    pub regions: *const DeviceMemoryCopy,
}

impl CopyDeviceMemoryInfo {
    /// The regions must outlive the command.
    pub fn new(regions: &[DeviceMemoryCopy]) -> Self {
        Self {
            s_type: structure_type(1),
            next: std::ptr::null(),
            region_count: regions.len() as u32,
            regions: regions.as_ptr(),
        }
    }
}

/// `VkDeviceMemoryImageCopyKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct DeviceMemoryImageCopy {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub address_range: DeviceAddressRange,
    pub address_flags: u32,
    pub address_row_length: u32,
    pub address_image_height: u32,
    pub image_subresource: vk::ImageSubresourceLayers,
    pub image_layout: vk::ImageLayout,
    pub image_offset: vk::Offset3D,
    pub image_extent: vk::Extent3D,
}

impl DeviceMemoryImageCopy {
    /// `address_range` is the memory the copy reads or writes, the rest follows `VkBufferImageCopy2`.
    pub fn new(
        address_range: DeviceAddressRange,
        address_row_length: u32,
        address_image_height: u32,
        image_subresource: vk::ImageSubresourceLayers,
        image_layout: vk::ImageLayout,
        image_offset: vk::Offset3D,
        image_extent: vk::Extent3D,
    ) -> Self {
        Self {
            s_type: structure_type(2),
            next: std::ptr::null(),
            address_range,
            address_flags: 0,
            address_row_length,
            address_image_height,
            image_subresource,
            image_layout,
            image_offset,
            image_extent,
        }
    }
}

/// `VkCopyDeviceMemoryImageInfoKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct CopyDeviceMemoryImageInfo {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub image: vk::Image,
    pub region_count: u32,
    pub regions: *const DeviceMemoryImageCopy,
}

impl CopyDeviceMemoryImageInfo {
    /// The regions must outlive the command.
    pub fn new(image: vk::Image, regions: &[DeviceMemoryImageCopy]) -> Self {
        Self {
            s_type: structure_type(3),
            next: std::ptr::null(),
            image,
            region_count: regions.len() as u32,
            regions: regions.as_ptr(),
        }
    }
}

/// `VkMemoryRangeBarrierKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct MemoryRangeBarrier {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub src_stage_mask: vk::PipelineStageFlags2,
    pub src_access_mask: vk::AccessFlags2,
    pub dst_stage_mask: vk::PipelineStageFlags2,
    pub dst_access_mask: vk::AccessFlags2,
    pub src_queue_family_index: u32,
    pub dst_queue_family_index: u32,
    pub address_range: DeviceAddressRange,
    pub address_flags: u32,
}

impl MemoryRangeBarrier {
    pub fn new(
        src_stage_mask: vk::PipelineStageFlags2,
        src_access_mask: vk::AccessFlags2,
        dst_stage_mask: vk::PipelineStageFlags2,
        dst_access_mask: vk::AccessFlags2,
        address_range: DeviceAddressRange,
    ) -> Self {
        Self {
            s_type: structure_type(5),
            next: std::ptr::null(),
            src_stage_mask,
            src_access_mask,
            dst_stage_mask,
            dst_access_mask,
            src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            address_range,
            address_flags: 0,
        }
    }
}

/// `VkMemoryRangeBarriersInfoKHR`, chained to a `VkDependencyInfo`.
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct MemoryRangeBarriersInfo {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub memory_range_barrier_count: u32,
    pub memory_range_barriers: *const MemoryRangeBarrier,
}

impl MemoryRangeBarriersInfo {
    /// The barriers must outlive the command.
    pub fn new(barriers: &[MemoryRangeBarrier]) -> Self {
        Self {
            s_type: structure_type(4),
            next: std::ptr::null(),
            memory_range_barrier_count: barriers.len() as u32,
            memory_range_barriers: barriers.as_ptr(),
        }
    }
}

/// `VkPhysicalDeviceDeviceAddressCommandsFeaturesKHR`
#[repr(C)]
#[derive(Debug)]
pub struct DeviceAddressCommandsFeatures {
    pub s_type: vk::StructureType,
    pub next: *mut c_void,
    pub device_address_commands: vk::Bool32,
}

impl Default for DeviceAddressCommandsFeatures {
    fn default() -> Self {
        Self {
            s_type: structure_type(6),
            next: std::ptr::null_mut(),
            device_address_commands: vk::FALSE,
        }
    }
}

unsafe impl vk::ExtendsPhysicalDeviceFeatures2 for DeviceAddressCommandsFeatures {}

unsafe impl vk::Cast for DeviceAddressCommandsFeatures {
    type Target = DeviceAddressCommandsFeatures;

    fn into(self) -> Self::Target {
        self
    }
}

/// `VkBindIndexBuffer3InfoKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct BindIndexBuffer3Info {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub address_range: DeviceAddressRange,
    pub address_flags: u32,
    pub index_type: vk::IndexType,
}

impl BindIndexBuffer3Info {
    pub fn new(address_range: DeviceAddressRange, index_type: vk::IndexType) -> Self {
        Self {
            s_type: structure_type(7),
            next: std::ptr::null(),
            address_range,
            address_flags: 0,
            index_type,
        }
    }
}

/// `VkBindVertexBuffer3InfoKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct BindVertexBuffer3Info {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub set_stride: vk::Bool32,
    pub address_range: StridedDeviceAddressRange,
    pub address_flags: u32,
}

impl BindVertexBuffer3Info {
    pub fn new(set_stride: bool, address_range: StridedDeviceAddressRange) -> Self {
        Self {
            s_type: structure_type(8),
            next: std::ptr::null(),
            set_stride: vk::Bool32::from(set_stride),
            address_range,
            address_flags: 0,
        }
    }
}

/// `VkDrawIndirect2InfoKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct DrawIndirect2Info {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub address_range: StridedDeviceAddressRange,
    pub address_flags: u32,
    pub draw_count: u32,
}

impl DrawIndirect2Info {
    pub fn new(address_range: StridedDeviceAddressRange, draw_count: u32) -> Self {
        Self {
            s_type: structure_type(9),
            next: std::ptr::null(),
            address_range,
            address_flags: 0,
            draw_count,
        }
    }
}

/// `VkDrawIndirectCount2InfoKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct DrawIndirectCount2Info {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub address_range: StridedDeviceAddressRange,
    pub address_flags: u32,
    pub count_address_range: DeviceAddressRange,
    pub count_address_flags: u32,
    pub max_draw_count: u32,
}

impl DrawIndirectCount2Info {
    pub fn new(
        address_range: StridedDeviceAddressRange,
        count_address_range: DeviceAddressRange,
        max_draw_count: u32,
    ) -> Self {
        Self {
            s_type: structure_type(10),
            next: std::ptr::null(),
            address_range,
            address_flags: 0,
            count_address_range,
            count_address_flags: 0,
            max_draw_count,
        }
    }
}

/// `VkDispatchIndirect2InfoKHR`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct DispatchIndirect2Info {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub address_range: DeviceAddressRange,
    pub address_flags: u32,
}

impl DispatchIndirect2Info {
    pub fn new(address_range: DeviceAddressRange) -> Self {
        Self {
            s_type: structure_type(11),
            next: std::ptr::null(),
            address_range,
            address_flags: 0,
        }
    }
}

/// `VkConditionalRenderingBeginInfo2EXT`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct ConditionalRenderingBeginInfo2 {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub address_range: DeviceAddressRange,
    pub address_flags: u32,
    pub flags: vk::ConditionalRenderingFlagsEXT,
}

impl ConditionalRenderingBeginInfo2 {
    pub fn new(address_range: DeviceAddressRange, flags: vk::ConditionalRenderingFlagsEXT) -> Self {
        Self {
            s_type: structure_type(12),
            next: std::ptr::null(),
            address_range,
            address_flags: 0,
            flags,
        }
    }
}

/// `VkBindTransformFeedbackBuffer2InfoEXT`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct BindTransformFeedbackBuffer2Info {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub address_range: DeviceAddressRange,
    pub address_flags: u32,
}

impl BindTransformFeedbackBuffer2Info {
    pub fn new(address_range: DeviceAddressRange, address_flags: u32) -> Self {
        Self {
            s_type: structure_type(13),
            next: std::ptr::null(),
            address_range,
            address_flags,
        }
    }
}

type BindTransformFeedbackBuffers2Fn =
    unsafe extern "system" fn(vk::CommandBuffer, u32, u32, *const BindTransformFeedbackBuffer2Info);
type TransformFeedback2Fn =
    unsafe extern "system" fn(vk::CommandBuffer, u32, u32, *const BindTransformFeedbackBuffer2Info);
type DrawIndirectByteCount2Fn =
    unsafe extern "system" fn(vk::CommandBuffer, u32, u32, *const BindTransformFeedbackBuffer2Info, u32, u32);
type CopyMemoryFn = unsafe extern "system" fn(vk::CommandBuffer, *const CopyDeviceMemoryInfo);
type CopyMemoryImageFn = unsafe extern "system" fn(vk::CommandBuffer, *const CopyDeviceMemoryImageInfo);
type UpdateMemoryFn =
    unsafe extern "system" fn(vk::CommandBuffer, *const DeviceAddressRange, u32, vk::DeviceSize, *const c_void);
type FillMemoryFn = unsafe extern "system" fn(vk::CommandBuffer, *const DeviceAddressRange, u32, u32);
type CopyQueryPoolResultsToMemoryFn = unsafe extern "system" fn(
    vk::CommandBuffer,
    vk::QueryPool,
    u32,
    u32,
    *const StridedDeviceAddressRange,
    u32,
    vk::QueryResultFlags,
);
type BindIndexBuffer3Fn = unsafe extern "system" fn(vk::CommandBuffer, *const BindIndexBuffer3Info);
type BindVertexBuffers3Fn = unsafe extern "system" fn(vk::CommandBuffer, u32, u32, *const BindVertexBuffer3Info);
type DrawIndirect2Fn = unsafe extern "system" fn(vk::CommandBuffer, *const DrawIndirect2Info);
type DrawIndirectCount2Fn = unsafe extern "system" fn(vk::CommandBuffer, *const DrawIndirectCount2Info);
type DispatchIndirect2Fn = unsafe extern "system" fn(vk::CommandBuffer, *const DispatchIndirect2Info);
type BeginConditionalRendering2Fn = unsafe extern "system" fn(vk::CommandBuffer, *const ConditionalRenderingBeginInfo2);

/// The entry points of VK_KHR_device_address_commands, loaded with `vkGetDeviceProcAddr`. The ones that belong to another extension
/// as well (conditional rendering, mesh shaders, draw indirect count) are `None` when that extension is not enabled.
pub struct Commands {
    pub copy_memory: CopyMemoryFn,
    pub copy_memory_to_image: CopyMemoryImageFn,
    pub copy_image_to_memory: CopyMemoryImageFn,
    pub update_memory: UpdateMemoryFn,
    pub fill_memory: FillMemoryFn,
    pub copy_query_pool_results_to_memory: CopyQueryPoolResultsToMemoryFn,
    pub bind_index_buffer3: BindIndexBuffer3Fn,
    pub bind_vertex_buffers3: BindVertexBuffers3Fn,
    pub draw_indirect2: DrawIndirect2Fn,
    pub draw_indexed_indirect2: DrawIndirect2Fn,
    pub dispatch_indirect2: DispatchIndirect2Fn,
    pub draw_indirect_count2: Option<DrawIndirectCount2Fn>,
    pub draw_indexed_indirect_count2: Option<DrawIndirectCount2Fn>,
    pub begin_conditional_rendering2: Option<BeginConditionalRendering2Fn>,
    pub draw_mesh_tasks_indirect2: Option<DrawIndirect2Fn>,
    pub draw_mesh_tasks_indirect_count2: Option<DrawIndirectCount2Fn>,
    pub bind_transform_feedback_buffers2: Option<BindTransformFeedbackBuffers2Fn>,
    pub begin_transform_feedback2: Option<TransformFeedback2Fn>,
    pub end_transform_feedback2: Option<TransformFeedback2Fn>,
    pub draw_indirect_byte_count2: Option<DrawIndirectByteCount2Fn>,
}

macro_rules! load_command {
    ($instance:expr, $device:expr, $name:expr, $type:ty) => {{
        let function = unsafe { $instance.get_device_proc_addr($device.handle(), $name) };
        function.map(|function| unsafe { std::mem::transmute::<unsafe extern "system" fn(), $type>(function) })
    }};
}

fn required<T>(function: Option<T>, name: &str) -> Result<T, TestError> {
    function.ok_or_else(|| TestError::Fail(format!("{name} is not exposed by a device with {EXTENSION_NAME}")))
}

impl Commands {
    /// Loads the commands of `device`, which must have been created with the extension.
    pub fn load(instance: &Instance, device: &Device) -> Result<Self, TestError> {
        Ok(Self {
            copy_memory: required(
                load_command!(instance, device, c"vkCmdCopyMemoryKHR", CopyMemoryFn),
                "vkCmdCopyMemoryKHR",
            )?,
            copy_memory_to_image: required(
                load_command!(instance, device, c"vkCmdCopyMemoryToImageKHR", CopyMemoryImageFn),
                "vkCmdCopyMemoryToImageKHR",
            )?,
            copy_image_to_memory: required(
                load_command!(instance, device, c"vkCmdCopyImageToMemoryKHR", CopyMemoryImageFn),
                "vkCmdCopyImageToMemoryKHR",
            )?,
            update_memory: required(
                load_command!(instance, device, c"vkCmdUpdateMemoryKHR", UpdateMemoryFn),
                "vkCmdUpdateMemoryKHR",
            )?,
            fill_memory: required(
                load_command!(instance, device, c"vkCmdFillMemoryKHR", FillMemoryFn),
                "vkCmdFillMemoryKHR",
            )?,
            copy_query_pool_results_to_memory: required(
                load_command!(
                    instance,
                    device,
                    c"vkCmdCopyQueryPoolResultsToMemoryKHR",
                    CopyQueryPoolResultsToMemoryFn
                ),
                "vkCmdCopyQueryPoolResultsToMemoryKHR",
            )?,
            bind_index_buffer3: required(
                load_command!(instance, device, c"vkCmdBindIndexBuffer3KHR", BindIndexBuffer3Fn),
                "vkCmdBindIndexBuffer3KHR",
            )?,
            bind_vertex_buffers3: required(
                load_command!(instance, device, c"vkCmdBindVertexBuffers3KHR", BindVertexBuffers3Fn),
                "vkCmdBindVertexBuffers3KHR",
            )?,
            draw_indirect2: required(
                load_command!(instance, device, c"vkCmdDrawIndirect2KHR", DrawIndirect2Fn),
                "vkCmdDrawIndirect2KHR",
            )?,
            draw_indexed_indirect2: required(
                load_command!(instance, device, c"vkCmdDrawIndexedIndirect2KHR", DrawIndirect2Fn),
                "vkCmdDrawIndexedIndirect2KHR",
            )?,
            dispatch_indirect2: required(
                load_command!(instance, device, c"vkCmdDispatchIndirect2KHR", DispatchIndirect2Fn),
                "vkCmdDispatchIndirect2KHR",
            )?,
            draw_indirect_count2: load_command!(instance, device, c"vkCmdDrawIndirectCount2KHR", DrawIndirectCount2Fn),
            draw_indexed_indirect_count2: load_command!(
                instance,
                device,
                c"vkCmdDrawIndexedIndirectCount2KHR",
                DrawIndirectCount2Fn
            ),
            begin_conditional_rendering2: load_command!(
                instance,
                device,
                c"vkCmdBeginConditionalRendering2EXT",
                BeginConditionalRendering2Fn
            ),
            draw_mesh_tasks_indirect2: load_command!(
                instance,
                device,
                c"vkCmdDrawMeshTasksIndirect2EXT",
                DrawIndirect2Fn
            ),
            draw_mesh_tasks_indirect_count2: load_command!(
                instance,
                device,
                c"vkCmdDrawMeshTasksIndirectCount2EXT",
                DrawIndirectCount2Fn
            ),
            bind_transform_feedback_buffers2: load_command!(
                instance,
                device,
                c"vkCmdBindTransformFeedbackBuffers2EXT",
                BindTransformFeedbackBuffers2Fn
            ),
            begin_transform_feedback2: load_command!(
                instance,
                device,
                c"vkCmdBeginTransformFeedback2EXT",
                TransformFeedback2Fn
            ),
            end_transform_feedback2: load_command!(
                instance,
                device,
                c"vkCmdEndTransformFeedback2EXT",
                TransformFeedback2Fn
            ),
            draw_indirect_byte_count2: load_command!(
                instance,
                device,
                c"vkCmdDrawIndirectByteCount2EXT",
                DrawIndirectByteCount2Fn
            ),
        })
    }
}

/// `checkSupport` of the device address tests: the extension and its `deviceAddressCommands` feature.
pub fn check_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality(EXTENSION_NAME)?;
    let mut features = DeviceAddressCommandsFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if features.device_address_commands == vk::FALSE {
        return Err(TestError::NotSupported(
            "deviceAddressCommands not supported".to_string(),
        ));
    }
    Ok(())
}

/// The commands of the context's device.
pub fn load_commands(context: &Context<'_>) -> Result<Commands, TestError> {
    Commands::load(context.get_instance(), context.get_device())
}
