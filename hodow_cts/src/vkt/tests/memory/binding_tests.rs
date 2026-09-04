// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryBindingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
// Vendored original: hodow_cts/upstream/modules/vulkan/memory/
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The structure follows the upstream file closely on purpose: the same helper
// functions in the same order, the same `checkSupport` / `iterate` split, the same
// variable names and the same sequence of Vulkan calls. Two things could not be
// carried over one-to-one:
//
//  * Upstream selects the target type and the dedicated/suballocated variant with
//    template parameters (`MemoryBindingInstance<VkBuffer, true>`) and provides one
//    explicit specialisation per combination. Rust has no specialisation, so the
//    choice is a runtime enum and each upstream specialisation body becomes one match
//    arm / one method with the same name suffix.
//  * C++ destroys locals in reverse declaration order, so upstream frees a
//    VkDeviceMemory while the buffer or image bound to it is still alive. That is
//    legal Vulkan but has crashed drivers on teardown here before, so everything a
//    binding pairs up is held in a struct instead: Rust drops struct *fields* in
//    declaration order, which is what pins "handle dies before its memory" down,
//    including on the `?` early-return paths.
//
// These cases use no shaders at all.

use std::ffi::{CString, c_void};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, ExtPageableDeviceLocalMemoryExtensionDeviceCommands, InstanceV1_1};
use vulkanalia::{Device, ResultExt};

use crate::tcu::{self, TestError, TestOutcome, TestStatus};
use crate::tcu_throw_not_supported;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::allocate_command_buffer;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `ConstDedicatedInfo`
type ConstDedicatedInfo = vk::MemoryDedicatedAllocateInfo;

/// `MemoryRegionsList`
type MemoryRegionsList<'a> = Vec<Unique<'a, vk::DeviceMemory>>;

/// `BindBufferMemoryInfosList`
type BindBufferMemoryInfosList = Vec<vk::BindBufferMemoryInfo>;

/// `BindImageMemoryInfosList`
type BindImageMemoryInfosList = Vec<vk::BindImageMemoryInfo>;

/// `BindMemoryStatusList`
type BindMemoryStatusList = Vec<vk::BindMemoryStatusKHR>;

/// `MemoryMappingRAII`
struct MemoryMappingRAII<'a> {
    vk: &'a Device,
    memory: vk::DeviceMemory,
    host_ptr: *mut u8,
}

impl<'a> MemoryMappingRAII<'a> {
    fn new(device_interface: &'a Device, device_memory: vk::DeviceMemory, offset: vk::DeviceSize, size: vk::DeviceSize, flags: vk::MemoryMapFlags) -> Result<Self, TestError> {
        let host_ptr = unsafe { device_interface.map_memory(device_memory, offset, size, flags) }.vk_check("vkMapMemory")?;
        Ok(Self {
            vk: device_interface,
            memory: device_memory,
            host_ptr: host_ptr.cast::<u8>(),
        })
    }

    fn ptr(&self) -> *mut u8 {
        self.host_ptr
    }

    fn flush(&self) -> Result<(), TestError> {
        let range = self.make_memory_range(0, vk::WHOLE_SIZE);
        unsafe { self.vk.flush_mapped_memory_ranges(&[range]) }.vk_check("vkFlushMappedMemoryRanges")
    }

    fn invalidate(&self) -> Result<(), TestError> {
        let range = self.make_memory_range(0, vk::WHOLE_SIZE);
        unsafe { self.vk.invalidate_mapped_memory_ranges(&[range]) }.vk_check("vkInvalidateMappedMemoryRanges")
    }

    fn make_memory_range(&self, offset: vk::DeviceSize, size: vk::DeviceSize) -> vk::MappedMemoryRange {
        vk::MappedMemoryRange {
            s_type: vk::StructureType::MAPPED_MEMORY_RANGE,
            next: std::ptr::null(),
            memory: self.memory,
            offset,
            size,
        }
    }
}

impl Drop for MemoryMappingRAII<'_> {
    fn drop(&mut self) {
        unsafe { self.vk.unmap_memory(self.memory) };
        self.host_ptr = std::ptr::null_mut();
    }
}

/// `SimpleRandomGenerator`
struct SimpleRandomGenerator {
    value: u32,
}

impl SimpleRandomGenerator {
    fn new(seed: u32) -> Self {
        Self { value: seed }
    }

    fn get_next(&mut self) -> u32 {
        self.value = self.value.wrapping_add(1);
        self.value ^= self.value << 21;
        self.value ^= self.value >> 15;
        self.value ^= self.value << 4;
        self.value
    }
}

/// `PriorityMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum PriorityMode {
    /// `PRIORITY_MODE_DEFAULT`
    Default,
    /// `PRIORITY_MODE_STATIC`
    Static,
    /// `PRIORITY_MODE_DYNAMIC`
    Dynamic,
}

impl PriorityMode {
    /// `PriorityMode(i % 3)` - the group builder walks the enum by value.
    fn from_index(index: u32) -> Self {
        match index {
            0 => Self::Default,
            1 => Self::Static,
            _ => Self::Dynamic,
        }
    }
}

/// The `TTarget` template parameter of `MemoryBindingInstance` / the `createMemory`
/// specialisations.
#[derive(Clone, Copy, PartialEq, Eq)]
enum TargetType {
    /// `VkBuffer`
    Buffer,
    /// `VkImage`
    Image,
}

/// `BindingCaseParameters`
#[derive(Clone, Copy)]
struct BindingCaseParameters {
    flags: vk::BufferCreateFlags,
    usage: vk::BufferUsageFlags,
    sharing: vk::SharingMode,
    buffer_size: vk::DeviceSize,
    image_size: vk::Extent3D,
    targets_count: u32,
    image_create_flags: vk::ImageCreateFlags,
    priority_mode: PriorityMode,
    check_individual_result: bool,
    overallocation_factor: f64,
}

/// `makeBindingCaseParameters(targetsCount, width, height, ...)` - the image overload.
fn make_binding_case_parameters_image(
    targets_count: u32,
    width: u32,
    height: u32,
    image_create_flags: vk::ImageCreateFlags,
    priority_mode: PriorityMode,
    check_individual_result: bool,
    overallocation_factor: f64,
) -> BindingCaseParameters {
    let mut params = BindingCaseParameters {
        flags: vk::BufferCreateFlags::empty(),
        usage: vk::BufferUsageFlags::empty(),
        // deMemset(&params, 0, ...) - VK_SHARING_MODE_EXCLUSIVE is 0.
        sharing: vk::SharingMode::EXCLUSIVE,
        buffer_size: 0,
        image_size: vk::Extent3D { width: 0, height: 0, depth: 0 },
        targets_count: 0,
        image_create_flags: vk::ImageCreateFlags::empty(),
        priority_mode: PriorityMode::Default,
        check_individual_result: false,
        overallocation_factor: 0.0,
    };
    params.image_size.width = width;
    params.image_size.height = height;
    params.image_size.depth = 1;
    params.buffer_size = u64::from(params.image_size.width) * u64::from(params.image_size.height) * u64::from(params.image_size.depth) * std::mem::size_of::<u32>() as u64;
    params.usage = vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
    params.targets_count = targets_count;
    params.image_create_flags = image_create_flags;
    params.priority_mode = priority_mode;
    params.check_individual_result = check_individual_result;
    params.overallocation_factor = overallocation_factor;
    params
}

/// `makeBindingCaseParameters(targetsCount, usage, sharing, bufferSize, ...)` - the buffer overload.
#[allow(clippy::too_many_arguments)]
fn make_binding_case_parameters_buffer(
    targets_count: u32,
    usage: vk::BufferUsageFlags,
    sharing: vk::SharingMode,
    buffer_size: vk::DeviceSize,
    image_create_flags: vk::ImageCreateFlags,
    priority_mode: PriorityMode,
    check_individual_result: bool,
    overallocation_factor: f64,
) -> BindingCaseParameters {
    BindingCaseParameters {
        flags: vk::BufferCreateFlags::empty(),
        usage,
        sharing,
        buffer_size,
        image_size: vk::Extent3D { width: 0, height: 0, depth: 0 },
        targets_count,
        image_create_flags,
        priority_mode,
        check_individual_result,
        overallocation_factor,
    }
}

/// `makeImageCreateInfo`
fn make_image_create_info(params: &BindingCaseParameters) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: params.image_create_flags,
        image_type: vk::ImageType::_2D,
        format: vk::Format::R8G8B8A8_UINT,
        extent: params.image_size,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::LINEAR,
        usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `makeBufferCreateInfo`
///
/// `queue_family_index` is borrowed rather than taken by value: the returned struct
/// points at it, exactly like upstream's `&queueFamilyIndex`, so it has to outlive
/// the `vkCreateBuffer` call the result is passed to.
fn make_buffer_create_info(params: &BindingCaseParameters, queue_family_index: &u32) -> vk::BufferCreateInfo {
    vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags: params.flags,
        size: params.buffer_size,
        usage: params.usage,
        sharing_mode: params.sharing,
        queue_family_index_count: 1,
        queue_family_indices: queue_family_index,
    }
}

/// `makeMemoryAllocateInfo(memReqs, next)`
fn make_memory_allocate_info(mem_reqs: &vk::MemoryRequirements, next: *const c_void) -> vk::MemoryAllocateInfo {
    let heap_type_index = mem_reqs.memory_type_bits.trailing_zeros();
    vk::MemoryAllocateInfo {
        s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
        next,
        allocation_size: mem_reqs.size,
        memory_type_index: heap_type_index,
    }
}

/// `MemoryHostVisibility`
#[derive(Clone, Copy, PartialEq, Eq)]
#[allow(dead_code)] // MemoryAny is upstream's other option; no case in this file asks for it.
enum MemoryHostVisibility {
    /// `MemoryAny`
    MemoryAny,
    /// `MemoryHostVisible`
    MemoryHostVisible,
}

/// `selectMatchingMemoryType`
fn select_matching_memory_type(ctx: &Context<'_>, mem_reqs: &vk::MemoryRequirements, memory_visibility: MemoryHostVisibility) -> u32 {
    let vk_physical_device = ctx.get_physical_device();
    let vk_instance = ctx.get_instance();

    let memory_properties = unsafe { vk_instance.get_physical_device_memory_properties(vk_physical_device) };
    if memory_visibility == MemoryHostVisibility::MemoryHostVisible {
        for type_ndx in 0..memory_properties.memory_type_count {
            let is_in_allowed = (mem_reqs.memory_type_bits & (1u32 << type_ndx)) != 0;
            let has_right_properties = memory_properties.memory_types[type_ndx as usize]
                .property_flags
                .contains(vk::MemoryPropertyFlags::HOST_VISIBLE);
            if is_in_allowed && has_right_properties {
                return type_ndx;
            }
        }
    }
    mem_reqs.memory_type_bits.trailing_zeros()
}

/// `makeMemoryAllocateInfo(ctx, memReqs, memoryVisibility)`
fn make_memory_allocate_info_visibility(ctx: &Context<'_>, mem_reqs: &vk::MemoryRequirements, memory_visibility: MemoryHostVisibility) -> vk::MemoryAllocateInfo {
    let heap_type_index = select_matching_memory_type(ctx, mem_reqs, memory_visibility);
    vk::MemoryAllocateInfo {
        s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
        next: std::ptr::null(),
        allocation_size: mem_reqs.size,
        memory_type_index: heap_type_index,
    }
}

/// `makeDedicatedAllocationInfo(VkBuffer)`
fn make_dedicated_allocation_info_buffer(buffer: vk::Buffer) -> ConstDedicatedInfo {
    ConstDedicatedInfo {
        s_type: vk::StructureType::MEMORY_DEDICATED_ALLOCATE_INFO,
        next: std::ptr::null(),
        image: vk::Image::null(),
        buffer,
    }
}

/// `makeDedicatedAllocationInfo(VkImage)`
fn make_dedicated_allocation_info_image(image: vk::Image) -> ConstDedicatedInfo {
    ConstDedicatedInfo {
        s_type: vk::StructureType::MEMORY_DEDICATED_ALLOCATE_INFO,
        next: std::ptr::null(),
        image,
        buffer: vk::Buffer::null(),
    }
}

/// `makeBufferMemoryBindingInfo`
fn make_buffer_memory_binding_info(buffer: vk::Buffer, memory: vk::DeviceMemory, next: *const c_void) -> vk::BindBufferMemoryInfo {
    vk::BindBufferMemoryInfo {
        s_type: vk::StructureType::BIND_BUFFER_MEMORY_INFO,
        next,
        buffer,
        memory,
        memory_offset: 0,
    }
}

/// `makeImageMemoryBindingInfo`
fn make_image_memory_binding_info(image: vk::Image, memory: vk::DeviceMemory, next: *const c_void) -> vk::BindImageMemoryInfo {
    vk::BindImageMemoryInfo {
        s_type: vk::StructureType::BIND_IMAGE_MEMORY_INFO,
        next,
        image,
        memory,
        memory_offset: 0,
    }
}

/// `makeMemoryPriorityAllocateInfo`
fn make_memory_priority_allocate_info(next: *const c_void, priority: f32) -> vk::MemoryPriorityAllocateInfoEXT {
    vk::MemoryPriorityAllocateInfoEXT {
        s_type: vk::StructureType::MEMORY_PRIORITY_ALLOCATE_INFO_EXT,
        next,
        priority,
    }
}

/// `makeBindMemoryStatus`
fn make_bind_memory_status(p_result: *mut vk::Result) -> vk::BindMemoryStatusKHR {
    vk::BindMemoryStatusKHR {
        s_type: vk::StructureType::BIND_MEMORY_STATUS,
        next: std::ptr::null(),
        result: p_result,
    }
}

/// `TransferDirection`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TransferDirection {
    /// `TransferToResource`
    TransferToResource,
    /// `TransferFromResource`
    TransferFromResource,
}

/// `makeMemoryBarrierInfo(VkBuffer, ...)`
fn make_memory_barrier_info_buffer(buffer: vk::Buffer, size: vk::DeviceSize, direction: TransferDirection) -> vk::BufferMemoryBarrier {
    let from_res = direction == TransferDirection::TransferFromResource;
    let src_mask = if from_res { vk::AccessFlags::HOST_WRITE } else { vk::AccessFlags::TRANSFER_WRITE };
    let dst_mask = if from_res { vk::AccessFlags::TRANSFER_READ } else { vk::AccessFlags::HOST_READ };
    vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: src_mask,
        dst_access_mask: dst_mask,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset: 0,
        size,
    }
}

/// `makeMemoryBarrierInfo(VkImage, ...)`
fn make_memory_barrier_info_image(
    image: vk::Image,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
) -> vk::ImageMemoryBarrier {
    let aspect = vk::ImageAspectFlags::COLOR;
    vk::ImageMemoryBarrier {
        s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: src_access,
        dst_access_mask: dst_access,
        old_layout,
        new_layout,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        image,
        subresource_range: vk::ImageSubresourceRange {
            aspect_mask: aspect,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        },
    }
}

/// `vk::createCommandPool(vk, device, VK_COMMAND_POOL_CREATE_TRANSIENT_BIT, ...)`
///
/// `vk::obj_util::make_command_pool` asks for RESET_COMMAND_BUFFER instead, so the
/// pool is built here to keep upstream's flags.
fn create_command_pool(vk: &Device, queue_family_index: u32) -> Result<Unique<'_, vk::CommandPool>, TestError> {
    let info = vk::CommandPoolCreateInfo::builder()
        .flags(vk::CommandPoolCreateFlags::TRANSIENT)
        .queue_family_index(queue_family_index);
    let pool = unsafe { vk.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?;
    Ok(Unique::new(vk, pool))
}

/// `vk::copyImageToBuffer` from vkImageUtil, with the defaults the call site below
/// leaves out (`numLayers = 1`, colour aspect, `srcStageMask = ALL_COMMANDS`).
fn copy_image_to_buffer(
    vk: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: (i32, i32),
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
) {
    let transfer_layout = if old_layout == vk::ImageLayout::GENERAL {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };

    let image_barrier = vk::ImageMemoryBarrier {
        s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask: vk::AccessFlags::TRANSFER_READ,
        old_layout,
        new_layout: transfer_layout,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        image,
        subresource_range: vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        },
    };

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
    }

    let subresource = vk::ImageSubresourceLayers {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        mip_level: 0,
        base_array_layer: 0,
        layer_count: 1,
    };

    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: subresource,
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: size.0 as u32,
            height: size.1 as u32,
            depth: 1,
        },
    };

    unsafe { vk.cmd_copy_image_to_buffer(cmd_buffer, image, transfer_layout, buffer, &[region]) };

    let buffer_barrier = vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
        dst_access_mask: vk::AccessFlags::HOST_READ,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset: 0,
        size: vk::WHOLE_SIZE,
    };

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `BuffersList` / `ImagesList` - the `std::vector<de::SharedPtr<Move<TTarget>>>` that
/// upstream's template parameter picks between.
enum TargetsList<'a> {
    Buffers(Vec<Unique<'a, vk::Buffer>>),
    Images(Vec<Unique<'a, vk::Image>>),
}

impl TargetsList<'_> {
    fn len(&self) -> usize {
        match self {
            Self::Buffers(targets) => targets.len(),
            Self::Images(targets) => targets.len(),
        }
    }

    /// `**targets[i]`
    fn get(&self, i: usize) -> Target {
        match self {
            Self::Buffers(targets) => Target::Buffer(targets[i].get()),
            Self::Images(targets) => Target::Image(targets[i].get()),
        }
    }
}

/// One `**targets[i]`, whichever kind it is.
#[derive(Clone, Copy)]
enum Target {
    Buffer(vk::Buffer),
    Image(vk::Image),
}

/// `targets` and `memory` from upstream's `iterate`, held together.
///
/// Rust drops struct fields in declaration order, so listing the targets first is what
/// guarantees every buffer/image is destroyed before the VkDeviceMemory it is bound
/// to. `targets` holds one list for `MemoryBindingInstance` and two for
/// `AliasedMemoryBindingInstance`, matching `targets[2]` upstream.
struct BoundResources<'a> {
    targets: Vec<TargetsList<'a>>,
    memory: MemoryRegionsList<'a>,
}

/// `createBuffer`'s two out-parameters, held together for the same reason as
/// `BoundResources`.
struct BufferAndMemory<'a> {
    buffer: Unique<'a, vk::Buffer>,
    memory: Unique<'a, vk::DeviceMemory>,
}

/// `BaseTestInstance`
struct BaseTestInstance<'a> {
    m_context: &'a Context<'a>,
    m_params: BindingCaseParameters,
    m_target: TargetType,
    m_dedicated: bool,
    /// `m_logicalDevice` - `None` means the Context's device is used, as upstream's
    /// `DeviceWrapper` does when it is not asked for a custom one.
    m_logical_device: Option<Device>,
    m_logical_device_queue: vk::Queue,
}

impl<'a> BaseTestInstance<'a> {
    fn new(ctx: &'a Context<'a>, params: BindingCaseParameters, target: TargetType, dedicated: bool) -> Self {
        Self {
            m_context: ctx,
            m_params: params,
            m_target: target,
            m_dedicated: dedicated,
            m_logical_device: None,
            m_logical_device_queue: vk::Queue::null(),
        }
    }

    /// The body of upstream's `BaseTestInstance` constructor.
    ///
    /// It is not a constructor here because it can fail and `createInstance` has
    /// nowhere to report that: `Ok(Some(status))` is the verdict to return right away,
    /// which is what the two `TCU_FAIL`s become.
    ///
    /// Upstream builds a custom device only for PRIORITY_MODE_DYNAMIC, because its
    /// DefaultDevice already enables every feature the physical device reports. This
    /// port's Context enables a fixed set of feature structs instead, so the
    /// maintenance6 cases need one too - a VkBindMemoryStatus in a bind pNext chain
    /// requires the maintenance6 feature to be *enabled*, not merely supported.
    fn init(&mut self) -> Result<Option<TestStatus>, TestError> {
        if self.m_params.priority_mode == PriorityMode::Dynamic || self.m_params.check_individual_result {
            let instance_driver = self.m_context.get_instance();
            let queue_priority = 1.0f32;

            let mut pageable_device_local_memory_feature = vk::PhysicalDevicePageableDeviceLocalMemoryFeaturesEXT {
                s_type: vk::StructureType::PHYSICAL_DEVICE_PAGEABLE_DEVICE_LOCAL_MEMORY_FEATURES_EXT,
                next: std::ptr::null_mut(),
                pageable_device_local_memory: vk::FALSE,
            };

            let mut maintenance6_feature = vk::PhysicalDeviceMaintenance6FeaturesKHR {
                s_type: vk::StructureType::PHYSICAL_DEVICE_MAINTENANCE_6_FEATURES,
                next: std::ptr::null_mut(),
                maintenance6: vk::FALSE,
            };
            if self.m_params.check_individual_result {
                pageable_device_local_memory_feature.next = std::ptr::from_mut(&mut maintenance6_feature).cast();
            }

            let features = vk::PhysicalDeviceFeatures::default();

            // Upstream always chains the pageable struct; here it is only chained for
            // the dynamic mode, since the other modes create their custom device for
            // maintenance6 alone and must not ask for an extension they never enable.
            let features_head: *mut c_void = if self.m_params.priority_mode == PriorityMode::Dynamic {
                std::ptr::from_mut(&mut pageable_device_local_memory_feature).cast()
            } else {
                std::ptr::from_mut(&mut maintenance6_feature).cast()
            };

            let mut features2 = vk::PhysicalDeviceFeatures2 {
                s_type: vk::StructureType::PHYSICAL_DEVICE_FEATURES_2,
                next: features_head,
                features,
            };

            unsafe { instance_driver.get_physical_device_features2(self.m_context.get_physical_device(), &mut features2) };

            if self.m_params.priority_mode == PriorityMode::Dynamic && pageable_device_local_memory_feature.pageable_device_local_memory == vk::FALSE {
                return Ok(Some(TestStatus::fail(
                    "pageableDeviceLocalMemory feature not supported but VK_EXT_pageable_device_local_memory advertised",
                )));
            }

            if self.m_params.check_individual_result && maintenance6_feature.maintenance6 == vk::FALSE {
                return Ok(Some(TestStatus::fail("maintenance6 feature not supported but VK_KHR_maintenance6 advertised")));
            }

            pageable_device_local_memory_feature.pageable_device_local_memory = vk::TRUE;

            // Re-derive the chain head after that write: the pointer taken before it no
            // longer covers the new value, and vkCreateDevice below is the only reader.
            features2.next = if self.m_params.priority_mode == PriorityMode::Dynamic {
                std::ptr::from_mut(&mut pageable_device_local_memory_feature).cast()
            } else {
                std::ptr::from_mut(&mut maintenance6_feature).cast()
            };

            let mut device_extensions: Vec<CString> = Vec::new();
            if self.m_params.priority_mode != PriorityMode::Default {
                device_extensions.push(CString::new("VK_EXT_memory_priority").expect("no interior NUL"));
            }
            if self.m_params.priority_mode == PriorityMode::Dynamic {
                device_extensions.push(CString::new("VK_EXT_pageable_device_local_memory").expect("no interior NUL"));
            }
            if self.m_params.check_individual_result {
                device_extensions.push(CString::new("VK_KHR_maintenance6").expect("no interior NUL"));
            }
            let extension_ptrs: Vec<*const i8> = device_extensions.iter().map(|name| name.as_ptr()).collect();

            let queue_priorities = [queue_priority];
            // Upstream hardcodes queue family 0 here but then reads the queue back from
            // the universal family; the universal family is the one the queue below has
            // to come from, so it is used for both.
            let queue_info = vk::DeviceQueueCreateInfo {
                s_type: vk::StructureType::DEVICE_QUEUE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::DeviceQueueCreateFlags::empty(),
                queue_family_index: self.m_context.get_universal_queue_family_index(),
                queue_count: 1,
                queue_priorities: queue_priorities.as_ptr(),
            };
            let queue_infos = [queue_info];

            let device_info = vk::DeviceCreateInfo {
                s_type: vk::StructureType::DEVICE_CREATE_INFO,
                next: std::ptr::from_ref(&features2).cast(),
                flags: vk::DeviceCreateFlags::empty(),
                queue_create_info_count: 1,
                queue_create_infos: queue_infos.as_ptr(),
                enabled_layer_count: 0,
                enabled_layer_names: std::ptr::null(),
                enabled_extension_count: extension_ptrs.len() as u32,
                enabled_extension_names: if extension_ptrs.is_empty() { std::ptr::null() } else { extension_ptrs.as_ptr() },
                enabled_features: std::ptr::null(),
            };

            let device = unsafe { instance_driver.create_device(self.m_context.get_physical_device(), &device_info, None) }.vk_check("vkCreateDevice")?;
            self.m_logical_device = Some(device);
        }

        let queue = unsafe { self.get_device_interface().get_device_queue(self.m_context.get_universal_queue_family_index(), 0) };
        self.m_logical_device_queue = queue;
        Ok(None)
    }

    /// `BaseTestInstance::getPhysicalDevice`
    fn get_physical_device(&self) -> vk::PhysicalDevice {
        self.m_context.get_physical_device()
    }

    /// `BaseTestInstance::getInstanceInterface`
    fn get_instance_interface(&self) -> &Instance {
        self.m_context.get_instance()
    }

    /// `BaseTestInstance::getDevice` and `getDeviceInterface` collapsed into one,
    /// since `vulkanalia::Device` is both.
    fn get_device_interface(&self) -> &Device {
        match &self.m_logical_device {
            Some(device) => device,
            None => self.m_context.get_device(),
        }
    }

    /// `BaseTestInstance::getUniversalQueue`
    fn get_universal_queue(&self) -> vk::Queue {
        self.m_logical_device_queue
    }

    /// `BaseTestInstance::createBindingTargets<TTarget>`
    fn create_binding_targets(&self) -> Result<TargetsList<'_>, TestError> {
        match self.m_target {
            TargetType::Buffer => {
                let count = self.m_params.targets_count;
                let vk = self.get_device_interface();

                let mut targets: Vec<Unique<'_, vk::Buffer>> = Vec::with_capacity(count as usize);
                for _i in 0..count {
                    let queue_family_index = self.m_context.get_universal_queue_family_index();
                    let buffer_params = make_buffer_create_info(&self.m_params, &queue_family_index);
                    let buffer = unsafe { vk.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
                    targets.push(Unique::new(vk, buffer));
                }
                Ok(TargetsList::Buffers(targets))
            }
            TargetType::Image => {
                let count = self.m_params.targets_count;
                let vk = self.get_device_interface();

                let mut targets: Vec<Unique<'_, vk::Image>> = Vec::with_capacity(count as usize);
                for _i in 0..count {
                    let image_params = make_image_create_info(&self.m_params);
                    let image = unsafe { vk.create_image(&image_params, None) }.vk_check("vkCreateImage")?;
                    targets.push(Unique::new(vk, image));
                }
                Ok(TargetsList::Images(targets))
            }
        }
    }

    /// `BaseTestInstance::createMemory<TTarget, TDedicated>`
    fn create_memory(&self, targets: &TargetsList<'_>) -> Result<MemoryRegionsList<'_>, TestError> {
        match (targets, self.m_dedicated) {
            (TargetsList::Buffers(_), false) => self.create_memory_buffer(targets),
            (TargetsList::Images(_), false) => self.create_memory_image(targets),
            (TargetsList::Buffers(_), true) => self.create_memory_buffer_dedicated(targets),
            (TargetsList::Images(_), true) => self.create_memory_image_dedicated(targets),
        }
    }

    /// `BaseTestInstance::createMemory<VkBuffer, false>`
    fn create_memory_buffer(&self, targets: &TargetsList<'_>) -> Result<MemoryRegionsList<'_>, TestError> {
        let count = targets.len() as u32;
        let vk = self.get_device_interface();

        let mut memory: MemoryRegionsList<'_> = Vec::with_capacity(count as usize);
        for i in 0..count {
            let Target::Buffer(buffer) = targets.get(i as usize) else { unreachable!() };
            let mem_reqs = unsafe { vk.get_buffer_memory_requirements(buffer) };

            let priority = make_memory_priority_allocate_info(std::ptr::null(), (i as f32) / (count as f32));
            let mem_alloc = make_memory_allocate_info(
                &mem_reqs,
                if self.m_params.priority_mode == PriorityMode::Static {
                    std::ptr::from_ref(&priority).cast()
                } else {
                    std::ptr::null()
                },
            );

            let raw_memory = unsafe { vk.allocate_memory(&mem_alloc, None) }.vk_check("vkAllocateMemory")?;

            if self.m_params.priority_mode == PriorityMode::Dynamic {
                unsafe { vk.set_device_memory_priority_ext(raw_memory, priority.priority) };
            }

            memory.push(Unique::new(vk, raw_memory));
        }
        Ok(memory)
    }

    /// `BaseTestInstance::createMemory<VkImage, false>`
    fn create_memory_image(&self, targets: &TargetsList<'_>) -> Result<MemoryRegionsList<'_>, TestError> {
        let count = targets.len() as u32;
        let vk = self.get_device_interface();

        let mut memory: MemoryRegionsList<'_> = Vec::with_capacity(count as usize);
        for i in 0..count {
            let Target::Image(image) = targets.get(i as usize) else { unreachable!() };
            let mem_reqs = unsafe { vk.get_image_memory_requirements(image) };

            let priority = make_memory_priority_allocate_info(std::ptr::null(), (i as f32) / (count as f32));
            let mem_alloc = make_memory_allocate_info(
                &mem_reqs,
                if self.m_params.priority_mode == PriorityMode::Static {
                    std::ptr::from_ref(&priority).cast()
                } else {
                    std::ptr::null()
                },
            );

            let raw_memory = unsafe { vk.allocate_memory(&mem_alloc, None) }.vk_check("vkAllocateMemory")?;

            if self.m_params.priority_mode == PriorityMode::Dynamic {
                unsafe { vk.set_device_memory_priority_ext(raw_memory, priority.priority) };
            }

            memory.push(Unique::new(vk, raw_memory));
        }
        Ok(memory)
    }

    /// `BaseTestInstance::createMemory<VkBuffer, true>`
    fn create_memory_buffer_dedicated(&self, targets: &TargetsList<'_>) -> Result<MemoryRegionsList<'_>, TestError> {
        let count = targets.len() as u32;
        let vk = self.get_device_interface();

        let mut memory: MemoryRegionsList<'_> = Vec::with_capacity(count as usize);
        for i in 0..count {
            let Target::Buffer(buffer) = targets.get(i as usize) else { unreachable!() };
            let mem_reqs = unsafe { vk.get_buffer_memory_requirements(buffer) };

            let dedicated_allocation_info = make_dedicated_allocation_info_buffer(buffer);
            let priority = make_memory_priority_allocate_info(std::ptr::from_ref(&dedicated_allocation_info).cast(), (i as f32) / (count as f32));
            let mem_alloc = make_memory_allocate_info(
                &mem_reqs,
                if self.m_params.priority_mode == PriorityMode::Static {
                    std::ptr::from_ref(&priority).cast()
                } else {
                    std::ptr::from_ref(&dedicated_allocation_info).cast()
                },
            );

            let raw_memory = unsafe { vk.allocate_memory(&mem_alloc, None) }.vk_check("vkAllocateMemory")?;

            if self.m_params.priority_mode == PriorityMode::Dynamic {
                unsafe { vk.set_device_memory_priority_ext(raw_memory, priority.priority) };
            }

            memory.push(Unique::new(vk, raw_memory));
        }
        Ok(memory)
    }

    /// `BaseTestInstance::createMemory<VkImage, true>`
    fn create_memory_image_dedicated(&self, targets: &TargetsList<'_>) -> Result<MemoryRegionsList<'_>, TestError> {
        let count = targets.len() as u32;
        let vk = self.get_device_interface();

        let mut memory: MemoryRegionsList<'_> = Vec::with_capacity(count as usize);
        for i in 0..count {
            let Target::Image(image) = targets.get(i as usize) else { unreachable!() };
            let mut mem_reqs = unsafe { vk.get_image_memory_requirements(image) };
            if self.m_params.overallocation_factor > 1.0 {
                mem_reqs.size = (mem_reqs.size as f64 * self.m_params.overallocation_factor) as vk::DeviceSize;
            }

            let dedicated_allocation_info = make_dedicated_allocation_info_image(image);

            let priority = make_memory_priority_allocate_info(std::ptr::from_ref(&dedicated_allocation_info).cast(), (i as f32) / (count as f32));
            // Upstream tests `m_params.priorityMode` for truthiness here, not for
            // PRIORITY_MODE_STATIC as the other three specialisations do, so the
            // dynamic mode gets the priority struct chained in as well. Kept as is.
            let mem_alloc = make_memory_allocate_info(
                &mem_reqs,
                if self.m_params.priority_mode != PriorityMode::Default {
                    std::ptr::from_ref(&priority).cast()
                } else {
                    std::ptr::from_ref(&dedicated_allocation_info).cast()
                },
            );

            let raw_memory = unsafe { vk.allocate_memory(&mem_alloc, None) }.vk_check("vkAllocateMemory")?;

            if self.m_params.priority_mode == PriorityMode::Dynamic {
                unsafe { vk.set_device_memory_priority_ext(raw_memory, priority.priority) };
            }

            memory.push(Unique::new(vk, raw_memory));
        }
        Ok(memory)
    }

    /// `BaseTestInstance::makeBinding<TTarget>`
    fn make_binding(&self, targets: &TargetsList<'_>, memory: &MemoryRegionsList<'_>) -> Result<(), TestError> {
        match targets {
            TargetsList::Buffers(_) => self.make_binding_buffer(targets, memory),
            TargetsList::Images(_) => self.make_binding_image(targets, memory),
        }
    }

    /// `BaseTestInstance::makeBinding<VkBuffer>`
    fn make_binding_buffer(&self, targets: &TargetsList<'_>, memory: &MemoryRegionsList<'_>) -> Result<(), TestError> {
        let count = targets.len() as u32;
        let vk = self.get_device_interface();
        let mut bind_memory_infos: BindBufferMemoryInfosList = Vec::new();
        let mut bind_results: Vec<vk::Result> = Vec::new();
        let mut bind_memory_status: BindMemoryStatusList = Vec::new();

        if self.m_params.check_individual_result {
            // Upstream fills bindResults and bindMemoryStatus in one loop and relies on
            // the reserve() above it to keep the pointers it takes valid; filling the
            // results first and only then pointing at them removes that dependency.
            bind_results.resize(count as usize, vk::Result::ERROR_UNKNOWN);
            let bind_results_ptr = bind_results.as_mut_ptr();
            for i in 0..count {
                bind_memory_status.push(make_bind_memory_status(unsafe { bind_results_ptr.add(i as usize) }));
            }
        }

        for i in 0..count {
            let Target::Buffer(buffer) = targets.get(i as usize) else { unreachable!() };
            let bind_memory_info = make_buffer_memory_binding_info(
                buffer,
                memory[i as usize].get(),
                if self.m_params.check_individual_result {
                    std::ptr::from_ref(&bind_memory_status[i as usize]).cast()
                } else {
                    std::ptr::null()
                },
            );
            bind_memory_infos.push(bind_memory_info);
        }

        unsafe { vk.bind_buffer_memory2(&bind_memory_infos) }.vk_check("vkBindBufferMemory2")?;

        if self.m_params.check_individual_result {
            for i in 0..count {
                unsafe { *bind_memory_status[i as usize].result }.result().vk_check("vkBindBufferMemory2 status")?;
            }
        }
        Ok(())
    }

    /// `BaseTestInstance::makeBinding<VkImage>`
    fn make_binding_image(&self, targets: &TargetsList<'_>, memory: &MemoryRegionsList<'_>) -> Result<(), TestError> {
        let count = targets.len() as u32;
        let vk = self.get_device_interface();
        let mut bind_memory_infos: BindImageMemoryInfosList = Vec::new();
        let mut bind_results: Vec<vk::Result> = Vec::new();
        let mut bind_memory_status: BindMemoryStatusList = Vec::new();

        if self.m_params.check_individual_result {
            bind_results.resize(count as usize, vk::Result::ERROR_UNKNOWN);
            let bind_results_ptr = bind_results.as_mut_ptr();
            for i in 0..count {
                bind_memory_status.push(make_bind_memory_status(unsafe { bind_results_ptr.add(i as usize) }));
            }
        }

        for i in 0..count {
            let Target::Image(image) = targets.get(i as usize) else { unreachable!() };
            let bind_memory_info = make_image_memory_binding_info(
                image,
                memory[i as usize].get(),
                if self.m_params.check_individual_result {
                    std::ptr::from_ref(&bind_memory_status[i as usize]).cast()
                } else {
                    std::ptr::null()
                },
            );
            bind_memory_infos.push(bind_memory_info);
        }

        unsafe { vk.bind_image_memory2(&bind_memory_infos) }.vk_check("vkBindImageMemory2")?;

        if self.m_params.check_individual_result {
            for i in 0..count {
                unsafe { *bind_memory_status[i as usize].result }.result().vk_check("vkBindImageMemory2 status")?;
            }
        }
        Ok(())
    }

    /// `BaseTestInstance::fillUpResource<TTarget>`
    fn fill_up_resource(&self, source: vk::Buffer, target: Target) -> Result<(), TestError> {
        match target {
            Target::Buffer(target) => self.fill_up_resource_buffer(source, target),
            Target::Image(target) => self.fill_up_resource_image(source, target),
        }
    }

    /// `BaseTestInstance::fillUpResource<VkBuffer>`
    fn fill_up_resource_buffer(&self, source: vk::Buffer, target: vk::Buffer) -> Result<(), TestError> {
        let vk = self.get_device_interface();
        let queue = self.get_universal_queue();

        let src_buffer_barrier = make_memory_barrier_info_buffer(source, self.m_params.buffer_size, TransferDirection::TransferFromResource);
        let dst_buffer_barrier = make_memory_barrier_info_buffer(target, self.m_params.buffer_size, TransferDirection::TransferToResource);

        let command_pool = create_command_pool(vk, self.m_context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(vk, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let buffer_copy = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: self.m_params.buffer_size,
        };

        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[src_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_copy_buffer(*cmd_buffer, source, target, &[buffer_copy]);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[dst_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer)?;

        submit_commands_and_wait(vk, queue, *cmd_buffer)
    }

    /// `BaseTestInstance::fillUpResource<VkImage>`
    fn fill_up_resource_image(&self, source: vk::Buffer, target: vk::Image) -> Result<(), TestError> {
        let vk = self.get_device_interface();
        let queue = self.get_universal_queue();

        let src_buffer_barrier = make_memory_barrier_info_buffer(source, self.m_params.buffer_size, TransferDirection::TransferFromResource);
        let pre_image_barrier = make_memory_barrier_info_image(
            target,
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        );
        let dst_image_barrier = make_memory_barrier_info_image(
            target,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        );

        let command_pool = create_command_pool(vk, self.m_context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(vk, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: self.m_params.image_size.width,
            buffer_image_height: self.m_params.image_size.height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: self.m_params.image_size,
        };

        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[src_buffer_barrier],
                &[pre_image_barrier],
            );
            vk.cmd_copy_buffer_to_image(*cmd_buffer, source, target, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &[copy_region]);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[dst_image_barrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer)?;

        submit_commands_and_wait(vk, queue, *cmd_buffer)
    }

    /// `BaseTestInstance::readUpResource`
    fn read_up_resource(&self, source: Target, target: vk::Buffer) -> Result<(), TestError> {
        match source {
            // readUpResource(Move<VkBuffer>&, Move<VkBuffer>&) forwards to fillUpResource.
            Target::Buffer(source) => self.fill_up_resource_buffer(source, target),
            Target::Image(source) => self.read_up_resource_image(source, target),
        }
    }

    /// `BaseTestInstance::readUpResource<VkImage>`
    fn read_up_resource_image(&self, source: vk::Image, target: vk::Buffer) -> Result<(), TestError> {
        let vk = self.get_device_interface();
        let queue = self.get_universal_queue();

        let command_pool = create_command_pool(vk, self.m_context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(vk, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vk, *cmd_buffer)?;
        copy_image_to_buffer(
            vk,
            *cmd_buffer,
            source,
            target,
            (self.m_params.image_size.width as i32, self.m_params.image_size.height as i32),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        );
        end_command_buffer(vk, *cmd_buffer)?;

        submit_commands_and_wait(vk, queue, *cmd_buffer)
    }

    /// `BaseTestInstance::layoutTransitionResource`
    fn layout_transition_resource(&self, target: Target) -> Result<(), TestError> {
        let target = match target {
            // layoutTransitionResource(Move<VkBuffer>&) is DE_UNREF(target).
            Target::Buffer(_) => return Ok(()),
            Target::Image(target) => target,
        };

        let vk = self.get_device_interface();
        let queue = self.get_universal_queue();

        let pre_image_barrier = make_memory_barrier_info_image(
            target,
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        );

        let command_pool = create_command_pool(vk, self.m_context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(vk, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_image_barrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer)?;

        submit_commands_and_wait(vk, queue, *cmd_buffer)
    }

    /// `BaseTestInstance::createBuffer`
    fn create_buffer(&self) -> Result<(BufferAndMemory<'_>, vk::DeviceSize), TestError> {
        let vk = self.get_device_interface();
        let queue_family_index = self.m_context.get_universal_queue_family_index();
        let buffer_params = make_buffer_create_info(&self.m_params, &queue_family_index);

        let buffer = unsafe { vk.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
        let buffer = Unique::new(vk, buffer);
        let mem_reqs = unsafe { vk.get_buffer_memory_requirements(buffer.get()) };
        let memory_size = mem_reqs.size;

        let mem_alloc = make_memory_allocate_info_visibility(self.m_context, &mem_reqs, MemoryHostVisibility::MemoryHostVisible);

        let raw_memory = unsafe { vk.allocate_memory(&mem_alloc, None) }.vk_check("vkAllocateMemory")?;
        let memory = Unique::new(vk, raw_memory);
        unsafe { vk.bind_buffer_memory(buffer.get(), memory.get(), 0) }.vk_check("vkBindBufferMemory")?;

        Ok((BufferAndMemory { buffer, memory }, memory_size))
    }

    /// `BaseTestInstance::pushData`
    fn push_data(&self, memory: vk::DeviceMemory, data_seed: u32, size: vk::DeviceSize) -> Result<(), TestError> {
        let vk = self.get_device_interface();
        let host_memory = MemoryMappingRAII::new(vk, memory, 0, size, vk::MemoryMapFlags::empty())?;
        let host_buffer = host_memory.ptr();
        let mut random = SimpleRandomGenerator::new(data_seed);

        for i in 0..size {
            unsafe { *host_buffer.add(i as usize) = (random.get_next() & 0xFF) as u8 };
        }
        host_memory.flush()
    }

    /// `BaseTestInstance::checkData`
    fn check_data(&self, memory: vk::DeviceMemory, data_seed: u32, size: vk::DeviceSize) -> Result<bool, TestError> {
        let vk = self.get_device_interface();
        let host_memory = MemoryMappingRAII::new(vk, memory, 0, size, vk::MemoryMapFlags::empty())?;
        let host_buffer = host_memory.ptr();
        let mut random = SimpleRandomGenerator::new(data_seed);

        host_memory.invalidate()?;

        for i in 0..self.m_params.buffer_size {
            if unsafe { *host_buffer.add(i as usize) } != (random.get_next() & 0xFF) as u8 {
                return Ok(false);
            }
        }
        Ok(true)
    }
}

impl Drop for BaseTestInstance<'_> {
    fn drop(&mut self) {
        // Every object allocated from the custom device is a local of `iterate`, so it
        // is already gone by the time this runs.
        if let Some(device) = self.m_logical_device.take() {
            unsafe {
                let _ = device.device_wait_idle();
                device.destroy_device(None);
            }
        }
    }
}

/// `MemoryBindingInstance<TTarget, TDedicated>`
struct MemoryBindingInstance<'a> {
    base: BaseTestInstance<'a>,
}

impl TestInstance for MemoryBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if let Some(status) = self.base.init()? {
            return Ok(status);
        }

        let vk_instance = self.base.get_instance_interface();
        let vk_physical_device = self.base.get_physical_device();
        let _properties = unsafe { vk_instance.get_physical_device_properties(vk_physical_device) };

        let targets = vec![self.base.create_binding_targets()?];
        let memory = self.base.create_memory(&targets[0])?;
        let resources = BoundResources { targets, memory };
        self.base.make_binding(&resources.targets[0], &resources.memory)?;

        let (src, src_memory_size) = self.base.create_buffer()?;
        self.base.push_data(src.memory.get(), 1, src_memory_size)?;

        let (dst, dst_memory_size) = self.base.create_buffer()?;

        let mut passed = true;
        for i in 0..self.base.m_params.targets_count {
            self.base.fill_up_resource(src.buffer.get(), resources.targets[0].get(i as usize))?;
            self.base.read_up_resource(resources.targets[0].get(i as usize), dst.buffer.get())?;
            passed = self.base.check_data(dst.memory.get(), 1, dst_memory_size)? && passed;
        }

        Ok(if passed { TestStatus::pass("Pass") } else { TestStatus::fail("Failed") })
    }
}

/// `AliasedMemoryBindingInstance<TTarget, TDedicated>`
struct AliasedMemoryBindingInstance<'a> {
    base: BaseTestInstance<'a>,
}

impl TestInstance for AliasedMemoryBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if let Some(status) = self.base.init()? {
            return Ok(status);
        }

        let vk_instance = self.base.get_instance_interface();
        let vk_physical_device = self.base.get_physical_device();
        let _properties = unsafe { vk_instance.get_physical_device_properties(vk_physical_device) };

        let mut targets: Vec<TargetsList<'_>> = Vec::new();
        for _i in 0..2 {
            targets.push(self.base.create_binding_targets()?);
        }
        let memory = self.base.create_memory(&targets[0])?;
        let resources = BoundResources { targets, memory };
        for i in 0..2 {
            self.base.make_binding(&resources.targets[i], &resources.memory)?;
        }

        let (src, src_memory_size) = self.base.create_buffer()?;
        self.base.push_data(src.memory.get(), 2, src_memory_size)?;

        let (dst, dst_memory_size) = self.base.create_buffer()?;

        let mut passed = true;
        for i in 0..self.base.m_params.targets_count {
            // Do a layout transition on alias 1 before we transition and write to alias 0
            self.base.layout_transition_resource(resources.targets[1].get(i as usize))?;
            self.base.fill_up_resource(src.buffer.get(), resources.targets[0].get(i as usize))?;
            self.base.read_up_resource(resources.targets[1].get(i as usize), dst.buffer.get())?;
            passed = self.base.check_data(dst.memory.get(), 2, dst_memory_size)? && passed;
        }

        Ok(if passed { TestStatus::pass("Pass") } else { TestStatus::fail("Failed") })
    }
}

/// `Context::isDeviceFunctionalitySupported`
fn is_device_functionality_supported(ctx: &Context<'_>, extension: &str) -> bool {
    ctx.get_device_extensions().iter().any(|e| e == extension)
}

/// `Context::getMemoryPriorityFeaturesEXT`
///
/// Upstream caches the whole feature chain on the Context; it is queried on demand
/// here, and left zeroed when the extension is absent, since a feature struct for an
/// unsupported extension must not be chained into vkGetPhysicalDeviceFeatures2.
fn get_memory_priority_features_ext(ctx: &Context<'_>) -> vk::PhysicalDeviceMemoryPriorityFeaturesEXT {
    let mut memory_priority_features = vk::PhysicalDeviceMemoryPriorityFeaturesEXT::default();
    if !is_device_functionality_supported(ctx, "VK_EXT_memory_priority") {
        return memory_priority_features;
    }

    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut memory_priority_features);
    unsafe { ctx.get_instance().get_physical_device_features2(ctx.get_physical_device(), &mut features2) };

    memory_priority_features
}

/// `Context::requireDeviceFunctionality("VK_KHR_bind_memory2")`
///
/// The Context's promotion table does not list VK_KHR_bind_memory2, and a Vulkan 1.1
/// driver need not still advertise an extension it has absorbed into core, so core 1.1
/// is accepted here the way upstream's requireDeviceFunctionality does.
fn require_bind_memory2(ctx: &Context<'_>) -> Result<(), TestError> {
    if ctx.get_device_properties().api_version >= vk::make_version(1, 1, 0) {
        return Ok(());
    }
    ctx.require_device_functionality("VK_KHR_bind_memory2")
}

/// `MemoryBindingTest<TInstance>`
struct MemoryBindingTest {
    name: String,
    m_params: BindingCaseParameters,
    target: TargetType,
    dedicated: bool,
    /// `TInstance` - `AliasedMemoryBindingInstance` when set, `MemoryBindingInstance`
    /// otherwise.
    aliased: bool,
}

impl TestCase for MemoryBindingTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, ctx: &Context<'_>) -> Result<(), TestError> {
        require_bind_memory2(ctx)?;

        if self.m_params.priority_mode != PriorityMode::Default && get_memory_priority_features_ext(ctx).memory_priority == vk::FALSE {
            tcu_throw_not_supported!("VK_EXT_memory_priority Not supported");
        }
        if self.m_params.priority_mode == PriorityMode::Dynamic && !is_device_functionality_supported(ctx, "VK_EXT_pageable_device_local_memory") {
            tcu_throw_not_supported!("VK_EXT_pageable_device_local_memory Not supported");
        }
        if self.m_params.check_individual_result {
            ctx.require_device_functionality("VK_KHR_maintenance6")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let base = BaseTestInstance::new(context, self.m_params, self.target, self.dedicated);
        if self.aliased {
            Box::new(AliasedMemoryBindingInstance { base })
        } else {
            Box::new(MemoryBindingInstance { base })
        }
    }
}

/// `createMemoryBindingTests`
pub fn create_memory_binding_tests() -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("binding");
    // Maintenance6 memory binding tests.
    let mut maint6 = tcu::TestCaseGroup::new("maintenance6");

    let iterations = 6;

    for i in 0..iterations {
        let priority_mode = PriorityMode::from_index(i % 3);
        let check_individual_bind_results = i / 3 != 0;

        // Basic memory binding tests.
        let mut regular = tcu::TestCaseGroup::new("regular");
        // Memory binding tests with aliasing of two resources.
        let mut aliasing = tcu::TestCaseGroup::new("aliasing");

        let mut regular_suballocated = tcu::TestCaseGroup::new("suballocated");
        let mut regular_dedicated = tcu::TestCaseGroup::new("dedicated");

        let mut aliasing_suballocated = tcu::TestCaseGroup::new("suballocated");

        let mut overallocated = tcu::TestCaseGroup::new("overallocated");

        let allocation_sizes: [vk::DeviceSize; 5] = [33, 257, 4087, 8095, 1024 * 1024 + 1];

        let overalloc_factors: [f64; 3] = [1.5, 2.3, 3.0];

        for size_ndx in 0..allocation_sizes.len() {
            let buffer_size = allocation_sizes[size_ndx];
            let params = make_binding_case_parameters_buffer(
                10,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
                vk::SharingMode::EXCLUSIVE,
                buffer_size,
                vk::ImageCreateFlags::empty(),
                priority_mode,
                check_individual_bind_results,
                1.0,
            );
            let aliasparams = make_binding_case_parameters_buffer(
                10,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
                vk::SharingMode::EXCLUSIVE,
                buffer_size,
                vk::ImageCreateFlags::ALIAS,
                priority_mode,
                check_individual_bind_results,
                1.0,
            );
            let overallocparams = make_binding_case_parameters_buffer(
                10,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
                vk::SharingMode::EXCLUSIVE,
                buffer_size,
                vk::ImageCreateFlags::empty(),
                priority_mode,
                check_individual_bind_results,
                overalloc_factors[(allocation_sizes[size_ndx] % overalloc_factors.len() as u64) as usize],
            );

            let test_name = format!("buffer_{buffer_size}");
            regular_suballocated.add_child(Box::new(MemoryBindingTest {
                name: test_name.clone(),
                m_params: params,
                target: TargetType::Buffer,
                dedicated: false,
                aliased: false,
            }) as Box<dyn TestCase>);
            regular_dedicated.add_child(Box::new(MemoryBindingTest {
                name: test_name.clone(),
                m_params: params,
                target: TargetType::Buffer,
                dedicated: true,
                aliased: false,
            }) as Box<dyn TestCase>);
            aliasing_suballocated.add_child(Box::new(MemoryBindingTest {
                name: test_name.clone(),
                m_params: aliasparams,
                target: TargetType::Buffer,
                dedicated: false,
                aliased: true,
            }) as Box<dyn TestCase>);
            overallocated.add_child(Box::new(MemoryBindingTest {
                name: test_name,
                m_params: overallocparams,
                target: TargetType::Buffer,
                dedicated: true,
                aliased: false,
            }) as Box<dyn TestCase>);
        }

        let image_sizes: [u32; 3] = [8, 33, 257];

        for width_ndx in 0..image_sizes.len() {
            for height_ndx in 0..image_sizes.len() {
                let width = image_sizes[width_ndx];
                let height = image_sizes[height_ndx];
                let regularparams = make_binding_case_parameters_image(10, width, height, vk::ImageCreateFlags::empty(), priority_mode, check_individual_bind_results, 1.0);
                let aliasparams = make_binding_case_parameters_image(10, width, height, vk::ImageCreateFlags::ALIAS, priority_mode, check_individual_bind_results, 1.0);
                let overallocparams = make_binding_case_parameters_image(
                    10,
                    width,
                    height,
                    vk::ImageCreateFlags::empty(),
                    priority_mode,
                    check_individual_bind_results,
                    overalloc_factors[(width_ndx * image_sizes.len() + height_ndx) % overalloc_factors.len()],
                );

                let test_name = format!("image_{width}_{height}");
                regular_suballocated.add_child(Box::new(MemoryBindingTest {
                    name: test_name.clone(),
                    m_params: regularparams,
                    target: TargetType::Image,
                    dedicated: false,
                    aliased: false,
                }) as Box<dyn TestCase>);
                regular_dedicated.add_child(Box::new(MemoryBindingTest {
                    name: test_name.clone(),
                    m_params: regularparams,
                    target: TargetType::Image,
                    dedicated: true,
                    aliased: false,
                }) as Box<dyn TestCase>);
                aliasing_suballocated.add_child(Box::new(MemoryBindingTest {
                    name: test_name.clone(),
                    m_params: aliasparams,
                    target: TargetType::Image,
                    dedicated: false,
                    aliased: true,
                }) as Box<dyn TestCase>);
                overallocated.add_child(Box::new(MemoryBindingTest {
                    name: test_name,
                    m_params: overallocparams,
                    target: TargetType::Image,
                    dedicated: true,
                    aliased: false,
                }) as Box<dyn TestCase>);
            }
        }

        regular.add_child(regular_suballocated);
        regular.add_child(regular_dedicated);
        regular.add_child(overallocated);

        aliasing.add_child(aliasing_suballocated);

        let parent = if check_individual_bind_results { &mut maint6 } else { &mut group };
        if priority_mode != PriorityMode::Default {
            // Using VK_EXT_pageable_device_local_memory / VK_EXT_memory_priority.
            let mut priority = tcu::TestCaseGroup::new(if priority_mode == PriorityMode::Dynamic { "priority_dynamic" } else { "priority" });
            priority.add_child(regular);
            priority.add_child(aliasing);
            parent.add_child(priority);
        } else {
            parent.add_child(regular);
            parent.add_child(aliasing);
        }
    }
    group.add_child(maint6);
    group
}
