// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingMutableTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Tests for VK_VALVE_mutable_descriptor_type and VK_EXT_mutable_descriptor_type. The GLSL of every case is built from its descriptor set by
// scripts/mutable_cases.py (a transliteration of `MutableTypesTest::initPrograms`); `shader_key` names the program set of a case.
// Acceleration structures are built by `vk::accel_struct` and read with ray queries; the ray tracing stages run through `vk::ray_tracing_util`.
// The tests run on the context's device, which enables the mutable descriptor type feature, instead of upstream's
// singleton device.

use std::collections::BTreeSet;
use std::ffi::c_void;
use std::sync::Arc;

use vulkanalia::Device;
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1, KhrRayTracingPipelineExtensionDeviceCommands};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::accel_struct::TriangleAccelerationStructure;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, ProgramBinary, create_shader_module};
use crate::vk::ray_tracing_util::{RayTracingPipelineBuilder, create_shader_binding_table, shader_group_sizes};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::binding_model::mutable_programs::PROGRAM_TABLE;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

type DT = vk::DescriptorType;

const SAMPLER: DT = DT::SAMPLER;
const COMBINED_IMAGE_SAMPLER: DT = DT::COMBINED_IMAGE_SAMPLER;
const SAMPLED_IMAGE: DT = DT::SAMPLED_IMAGE;
const STORAGE_IMAGE: DT = DT::STORAGE_IMAGE;
const UNIFORM_TEXEL_BUFFER: DT = DT::UNIFORM_TEXEL_BUFFER;
const STORAGE_TEXEL_BUFFER: DT = DT::STORAGE_TEXEL_BUFFER;
const UNIFORM_BUFFER: DT = DT::UNIFORM_BUFFER;
const STORAGE_BUFFER: DT = DT::STORAGE_BUFFER;
const INPUT_ATTACHMENT: DT = DT::INPUT_ATTACHMENT;
const ACCELERATION_STRUCTURE: DT = DT::ACCELERATION_STRUCTURE_KHR;
const MUTABLE: DT = DT::MUTABLE_EXT;

/// `DescriptorTypeFlagBits` order, which `toDescriptorTypeVector` walks.
const FLAG_ORDER: [DT; 11] = [
    SAMPLER,
    COMBINED_IMAGE_SAMPLER,
    SAMPLED_IMAGE,
    STORAGE_IMAGE,
    UNIFORM_TEXEL_BUFFER,
    STORAGE_TEXEL_BUFFER,
    UNIFORM_BUFFER,
    STORAGE_BUFFER,
    INPUT_ATTACHMENT,
    ACCELERATION_STRUCTURE,
    MUTABLE,
];

/// `getMandatoryMutableTypes`
const MANDATORY_TYPES: [DT; 6] = [
    SAMPLED_IMAGE,
    STORAGE_IMAGE,
    UNIFORM_TEXEL_BUFFER,
    STORAGE_TEXEL_BUFFER,
    UNIFORM_BUFFER,
    STORAGE_BUFFER,
];

/// `basicDescriptorTypes`
const BASIC_DESCRIPTOR_TYPES: [DT; 10] = [
    SAMPLER,
    COMBINED_IMAGE_SAMPLER,
    SAMPLED_IMAGE,
    STORAGE_IMAGE,
    UNIFORM_TEXEL_BUFFER,
    STORAGE_TEXEL_BUFFER,
    UNIFORM_BUFFER,
    STORAGE_BUFFER,
    INPUT_ATTACHMENT,
    ACCELERATION_STRUCTURE,
];

fn to_descriptor_type_flags(types: &[DT]) -> u32 {
    let mut result = 0u32;
    for t in types {
        let bit = FLAG_ORDER
            .iter()
            .position(|o| o == t)
            .expect("descriptor type not usable in a mutable binding");
        result |= 1 << bit;
    }
    result
}

fn to_descriptor_type_vector(bitfield: u32) -> Vec<DT> {
    FLAG_ORDER
        .iter()
        .enumerate()
        .filter(|(bit, _)| bitfield & (1 << bit) != 0)
        .map(|(_, t)| *t)
        .collect()
}

/// `descriptorTypeStr`
fn descriptor_type_str(t: DT) -> &'static str {
    match t {
        SAMPLER => "sampler",
        COMBINED_IMAGE_SAMPLER => "combined_image_sampler",
        SAMPLED_IMAGE => "sampled_image",
        STORAGE_IMAGE => "storage_image",
        UNIFORM_TEXEL_BUFFER => "uniform_texel_buffer",
        STORAGE_TEXEL_BUFFER => "storage_texel_buffer",
        UNIFORM_BUFFER => "uniform_buffer",
        STORAGE_BUFFER => "storage_buffer",
        INPUT_ATTACHMENT => "input_attachment",
        ACCELERATION_STRUCTURE => "acceleration_structure_khr",
        _ => unreachable!("no group is named after this descriptor type"),
    }
}

/// `getDescriptorNumericValue`: 0x5aIIBBDD
fn get_descriptor_numeric_value(iteration: u32, binding_idx: u32, descriptor_idx: u32) -> u32 {
    0x5a00_0000 | ((iteration & 0xFF) << 16) | ((binding_idx & 0xFF) << 8) | (descriptor_idx & 0xFF)
}

/// `getExpectedOutputBufferValue`
const EXPECTED_OUTPUT_BUFFER_VALUE: u32 = 2;
/// `getExternalSampledImageValue`
const EXTERNAL_SAMPLED_IMAGE_VALUE: u32 = 0x4132_2314;
/// `getStoredValueMask`
const STORED_VALUE_MASK: u32 = 0xFF00_0000;

/// `getDescriptorImageFormat`
const DESCRIPTOR_IMAGE_FORMAT: vk::Format = vk::Format::R32_UINT;

/// `getDefaultExtent`
fn default_extent() -> vk::Extent3D {
    vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    }
}

fn k_shader_access() -> vk::AccessFlags {
    vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE
}

/// `SourceSetStrategy`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SourceSetStrategy {
    Mutable,
    NonMutable,
    NoSource,
}

/// `PoolMutableStrategy`
#[derive(Clone, Copy, PartialEq, Eq)]
enum PoolMutableStrategy {
    KeepTypes,
    ExpandTypes,
    NoTypes,
    KeepNoMutableTypes,
}

/// `UpdateType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum UpdateType {
    Write,
    Copy,
}

/// `SourceSetType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SourceSetType {
    Normal,
    HostOnly,
    NoSource,
}

/// `UpdateMoment`
#[derive(Clone, Copy, PartialEq, Eq)]
enum UpdateMoment {
    Normal,
    UpdateAfterBind,
}

/// `TestingStage`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestingStage {
    Compute,
    Vertex,
    TessEval,
    TessControl,
    Geometry,
    Fragment,
    RayGen,
    Intersection,
    AnyHit,
    ClosestHit,
    Miss,
    Callable,
}

/// `ArrayAccessType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ArrayAccessType {
    Constant,
    PushConstant,
    NoArray,
}

fn is_ray_tracing_stage(stage: TestingStage) -> bool {
    matches!(
        stage,
        TestingStage::RayGen
            | TestingStage::Intersection
            | TestingStage::AnyHit
            | TestingStage::ClosestHit
            | TestingStage::Miss
            | TestingStage::Callable
    )
}

fn is_vertex_stage(stage: TestingStage) -> bool {
    matches!(
        stage,
        TestingStage::Vertex | TestingStage::TessControl | TestingStage::TessEval | TestingStage::Geometry
    )
}

fn stage_name(stage: TestingStage) -> &'static str {
    match stage {
        TestingStage::Compute => "comp",
        TestingStage::Vertex => "vert",
        TestingStage::TessControl => "tesc",
        TestingStage::TessEval => "tese",
        TestingStage::Geometry => "geom",
        TestingStage::Fragment => "frag",
        TestingStage::RayGen => "rgen",
        TestingStage::Intersection => "isec",
        TestingStage::AnyHit => "ahit",
        TestingStage::ClosestHit => "chit",
        TestingStage::Miss => "miss",
        TestingStage::Callable => "call",
    }
}

/// `ResourceType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ResourceType {
    Sampler,
    Image,
    CombinedImageSampler,
    Buffer,
    BufferView,
    AccelerationStructure,
}

/// `toResourceType`
fn to_resource_type(t: DT) -> ResourceType {
    match t {
        SAMPLER => ResourceType::Sampler,
        COMBINED_IMAGE_SAMPLER => ResourceType::CombinedImageSampler,
        SAMPLED_IMAGE | STORAGE_IMAGE | INPUT_ATTACHMENT => ResourceType::Image,
        UNIFORM_TEXEL_BUFFER | STORAGE_TEXEL_BUFFER => ResourceType::BufferView,
        UNIFORM_BUFFER | STORAGE_BUFFER => ResourceType::Buffer,
        ACCELERATION_STRUCTURE => ResourceType::AccelerationStructure,
        _ => unreachable!("no resource backs this descriptor type"),
    }
}

/// `isShaderWritable`
fn is_shader_writable(t: DT) -> bool {
    t == STORAGE_BUFFER || t == STORAGE_IMAGE || t == STORAGE_TEXEL_BUFFER
}

/// `WriteInfo`
enum WriteInfo {
    Image(vk::DescriptorImageInfo),
    Buffer(vk::DescriptorBufferInfo),
    BufferView(vk::BufferView),
    AccelerationStructure(vk::WriteDescriptorSetAccelerationStructureKHR),
}

/// `makeDefaultSampler`
fn make_default_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::REPEAT)
        .address_mode_v(vk::SamplerAddressMode::REPEAT)
        .address_mode_w(vk::SamplerAddressMode::REPEAT)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::ALWAYS)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::INT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

/// `makeDefaultImage`
fn make_default_image<'a>(device: &'a Device, alloc: &SimpleAllocator) -> Result<ImageWithMemory<'a>, TestError> {
    let usage = vk::ImageUsageFlags::SAMPLED
        | vk::ImageUsageFlags::STORAGE
        | vk::ImageUsageFlags::INPUT_ATTACHMENT
        | vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST;
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(DESCRIPTOR_IMAGE_FORMAT)
        .extent(default_extent())
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)
}

/// `makeDefaultImageView`
fn make_default_image_view(device: &Device, image: vk::Image) -> Result<Unique<'_, vk::ImageView>, TestError> {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    make_image_view(device, image, vk::ImageViewType::_2D, DESCRIPTOR_IMAGE_FORMAT, range)
}

/// `makeDefaultBuffer`
fn make_default_buffer<'a>(
    device: &'a Device,
    alloc: &SimpleAllocator,
    num_elements: u32,
) -> Result<BufferWithMemory<'a>, TestError> {
    let usage = vk::BufferUsageFlags::UNIFORM_BUFFER
        | vk::BufferUsageFlags::STORAGE_BUFFER
        | vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
        | vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
        | vk::BufferUsageFlags::TRANSFER_SRC
        | vk::BufferUsageFlags::TRANSFER_DST;
    let size = (std::mem::size_of::<u32>() * num_elements as usize) as vk::DeviceSize;
    BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// `makeDefaultBufferView`
fn make_default_buffer_view(device: &Device, buffer: vk::Buffer) -> Result<Unique<'_, vk::BufferView>, TestError> {
    let info = vk::BufferViewCreateInfo::builder()
        .buffer(buffer)
        .format(DESCRIPTOR_IMAGE_FORMAT)
        .offset(0)
        .range(std::mem::size_of::<u32>() as vk::DeviceSize);
    let view = unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?;
    Ok(Unique::new(device, view))
}

/// `Resource` - what backs one descriptor.
struct Resource<'a> {
    descriptor_type: DT,
    resource_type: ResourceType,
    sampler: Option<Unique<'a, vk::Sampler>>,
    image_with_memory: Option<ImageWithMemory<'a>>,
    image_view: Option<Unique<'a, vk::ImageView>>,
    buffer_with_memory: Option<BufferWithMemory<'a>>,
    buffer_view: Option<Unique<'a, vk::BufferView>>,
    acceleration_structure: Option<TriangleAccelerationStructure<'a>>,
    initial_value: u32,
}

impl<'a> Resource<'a> {
    fn new(
        descriptor_type: DT,
        device: &'a Device,
        alloc: &SimpleAllocator,
        q_index: u32,
        queue: vk::Queue,
        use_aabbs: bool,
        initial_value: u32,
        num_elements: u32,
    ) -> Result<Self, TestError> {
        let resource_type = to_resource_type(descriptor_type);
        if num_elements != 1 {
            assert!(resource_type == ResourceType::Buffer);
        }

        let mut resource = Self {
            descriptor_type,
            resource_type,
            sampler: None,
            image_with_memory: None,
            image_view: None,
            buffer_with_memory: None,
            buffer_view: None,
            acceleration_structure: None,
            initial_value,
        };

        match resource_type {
            ResourceType::Sampler => resource.sampler = Some(make_default_sampler(device)?),
            ResourceType::Image => {
                let image = make_default_image(device, alloc)?;
                resource.image_view = Some(make_default_image_view(device, image.get())?);
                resource.image_with_memory = Some(image);
            }
            ResourceType::CombinedImageSampler => {
                resource.sampler = Some(make_default_sampler(device)?);
                let image = make_default_image(device, alloc)?;
                resource.image_view = Some(make_default_image_view(device, image.get())?);
                resource.image_with_memory = Some(image);
            }
            ResourceType::Buffer => {
                resource.buffer_with_memory = Some(make_default_buffer(device, alloc, num_elements)?)
            }
            ResourceType::BufferView => {
                let buffer = make_default_buffer(device, alloc, 1)?;
                resource.buffer_view = Some(make_default_buffer_view(device, buffer.get())?);
                resource.buffer_with_memory = Some(buffer);
            }
            ResourceType::AccelerationStructure => {
                // getAccelerationStructureOffsetX: the lowest 16 bits of the value
                resource.acceleration_structure = Some(TriangleAccelerationStructure::new(
                    device,
                    alloc,
                    q_index,
                    queue,
                    initial_value as u16,
                    !use_aabbs,
                )?);
            }
        }

        if resource.image_with_memory.is_some() || resource.buffer_with_memory.is_some() {
            let cmd_pool = make_command_pool(device, q_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;

            if let Some(image) = &resource.image_with_memory {
                let buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
                let staging_buffer = BufferWithMemory::new(
                    device,
                    alloc,
                    make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                let buffer_alloc = staging_buffer.get_allocation();
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        initial_value.to_ne_bytes().as_ptr(),
                        buffer_alloc.get_host_ptr(),
                        std::mem::size_of::<u32>(),
                    )
                };
                flush_alloc(device, buffer_alloc)?;

                begin_command_buffer(device, cmd)?;

                let copy_region = make_buffer_image_copy(
                    default_extent(),
                    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                );
                let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

                let pre_transfer_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image.get(),
                    subresource_range,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[pre_transfer_barrier],
                    );
                    device.cmd_copy_buffer_to_image(
                        cmd,
                        staging_buffer.get(),
                        image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[copy_region],
                    );
                }

                let post_transfer_barrier = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    k_shader_access(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    image.get(),
                    subresource_range,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::ALL_COMMANDS,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[post_transfer_barrier],
                    );
                }

                end_command_buffer(device, cmd)?;
                submit_commands_and_wait(device, queue, cmd)?;
            }

            if let Some(buffer) = &resource.buffer_with_memory {
                let buffer_alloc = buffer.get_allocation();
                let values = vec![initial_value; num_elements as usize];
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        values.as_ptr() as *const u8,
                        buffer_alloc.get_host_ptr(),
                        values.len() * std::mem::size_of::<u32>(),
                    )
                };
                flush_alloc(device, buffer_alloc)?;

                begin_command_buffer(device, cmd)?;
                let host_to_shader_barrier = make_memory_barrier(vk::AccessFlags::HOST_WRITE, k_shader_access());
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::ALL_COMMANDS,
                        vk::DependencyFlags::empty(),
                        &[host_to_shader_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
                end_command_buffer(device, cmd)?;
                submit_commands_and_wait(device, queue, cmd)?;
            }
        }

        Ok(resource)
    }

    /// `makeWriteInfo`
    fn make_write_info(&self) -> WriteInfo {
        let sampler = || self.sampler.as_ref().map_or(vk::Sampler::null(), |s| s.get());
        let view = || self.image_view.as_ref().map_or(vk::ImageView::null(), |v| v.get());
        match self.resource_type {
            ResourceType::Sampler => WriteInfo::Image(vk::DescriptorImageInfo {
                sampler: sampler(),
                image_view: vk::ImageView::null(),
                image_layout: vk::ImageLayout::UNDEFINED,
            }),
            ResourceType::Image => WriteInfo::Image(vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: view(),
                image_layout: vk::ImageLayout::GENERAL,
            }),
            ResourceType::CombinedImageSampler => WriteInfo::Image(vk::DescriptorImageInfo {
                sampler: sampler(),
                image_view: view(),
                image_layout: vk::ImageLayout::GENERAL,
            }),
            ResourceType::Buffer => {
                let buffer = self
                    .buffer_with_memory
                    .as_ref()
                    .expect("buffer resource without a buffer")
                    .get();
                WriteInfo::Buffer(vk::DescriptorBufferInfo {
                    buffer,
                    offset: 0,
                    range: std::mem::size_of::<u32>() as vk::DeviceSize,
                })
            }
            ResourceType::BufferView => WriteInfo::BufferView(
                self.buffer_view
                    .as_ref()
                    .expect("buffer view resource without a view")
                    .get(),
            ),
            ResourceType::AccelerationStructure => {
                let structure = self
                    .acceleration_structure
                    .as_ref()
                    .expect("acceleration structure resource without a structure");
                WriteInfo::AccelerationStructure(vk::WriteDescriptorSetAccelerationStructureKHR {
                    acceleration_structure_count: 1,
                    acceleration_structures: structure.tlas(),
                    ..Default::default()
                })
            }
        }
    }

    /// `getStoredValue`
    fn get_stored_value(
        &self,
        device: &Device,
        alloc: &SimpleAllocator,
        q_index: u32,
        queue: vk::Queue,
        position: u32,
    ) -> Result<Option<u32>, TestError> {
        if position != 0 {
            assert!(self.buffer_with_memory.is_some());
        }

        let cmd_pool = make_command_pool(device, q_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        if let Some(image) = &self.image_with_memory {
            let staging_buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(
                    std::mem::size_of::<u32>() as vk::DeviceSize,
                    vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let buffer_alloc = staging_buffer.get_allocation();

            begin_command_buffer(device, cmd)?;

            let color_resource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let pre_transfer_barrier = make_image_memory_barrier(
                k_shader_access(),
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.get(),
                color_resource_range,
            );
            let copy_region = make_buffer_image_copy(
                default_extent(),
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            let post_transfer_barrier =
                make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_transfer_barrier],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    staging_buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[post_transfer_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;

            invalidate_alloc(device, buffer_alloc)?;
            let result = unsafe { std::ptr::read_unaligned(buffer_alloc.get_host_ptr() as *const u32) };
            return Ok(Some(result));
        }

        if let Some(buffer) = &self.buffer_with_memory {
            let buffer_alloc = buffer.get_allocation();

            begin_command_buffer(device, cmd)?;
            let shader_to_host_barrier = make_memory_barrier(k_shader_access(), vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[shader_to_host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;

            invalidate_alloc(device, buffer_alloc)?;
            let result =
                unsafe { std::ptr::read_unaligned((buffer_alloc.get_host_ptr() as *const u32).add(position as usize)) };
            return Ok(Some(result));
        }

        Ok(None)
    }
}

/// `SingleBinding`
#[derive(Clone)]
struct SingleBinding {
    ty: DT,
    mutable_types_vec: Vec<DT>,
}

impl SingleBinding {
    fn new(ty: DT, mutable_types: Vec<DT>) -> Self {
        if ty != MUTABLE {
            assert!(mutable_types.is_empty());
        } else {
            assert!(!mutable_types.is_empty());
        }
        Self {
            ty,
            mutable_types_vec: mutable_types,
        }
    }

    fn plain(ty: DT) -> Self {
        Self::new(ty, Vec::new())
    }

    fn max_types(&self) -> u32 {
        if self.ty != MUTABLE {
            1
        } else {
            self.mutable_types_vec.len() as u32
        }
    }

    fn used_types(&self) -> Vec<DT> {
        if self.ty != MUTABLE {
            vec![self.ty]
        } else {
            self.mutable_types_vec.clone()
        }
    }

    fn types_at_iteration(&self, iteration: u32) -> Vec<DT> {
        let types = self.used_types();
        vec![types[iteration as usize % types.len()]]
    }

    fn type_at_iteration(&self, iteration: u32) -> DT {
        self.types_at_iteration(iteration)[0]
    }

    fn to_mutable(&self) -> SingleBinding {
        if self.ty == MUTABLE {
            let flags = to_descriptor_type_flags(&self.mutable_types_vec);
            return SingleBinding::new(self.ty, to_descriptor_type_vector(flags));
        }
        let flags = to_descriptor_type_flags(&MANDATORY_TYPES) | to_descriptor_type_flags(&[self.ty]);
        SingleBinding::new(MUTABLE, to_descriptor_type_vector(flags))
    }

    fn to_non_mutable(&self, iteration: u32) -> SingleBinding {
        SingleBinding::plain(self.type_at_iteration(iteration))
    }
}

/// `SingleBinding` and `ArrayBinding` behind `BindingInterface`.
#[derive(Clone)]
enum Binding {
    Single(SingleBinding),
    Array {
        unbounded: bool,
        bindings: Vec<SingleBinding>,
    },
}

impl Binding {
    fn new_array(unbounded: bool, bindings: Vec<SingleBinding>) -> Self {
        assert!(!bindings.is_empty());
        let basic: BTreeSet<DT> = bindings.iter().map(|b| b.ty).collect();
        let used: BTreeSet<u32> = bindings
            .iter()
            .map(|b| to_descriptor_type_flags(&b.used_types()))
            .collect();
        assert!(basic.len() == 1 && used.len() == 1);
        Binding::Array { unbounded, bindings }
    }

    fn max_types(&self) -> u32 {
        match self {
            Binding::Single(s) => s.max_types(),
            Binding::Array { bindings, .. } => bindings
                .iter()
                .map(|b| b.used_types().len() as u32)
                .max()
                .expect("array binding is never empty"),
        }
    }

    fn types_at_iteration(&self, iteration: u32) -> Vec<DT> {
        match self {
            Binding::Single(s) => s.types_at_iteration(iteration),
            Binding::Array { bindings, .. } => bindings.iter().map(|b| b.type_at_iteration(iteration)).collect(),
        }
    }

    fn main_type(&self) -> DT {
        match self {
            Binding::Single(s) => s.ty,
            Binding::Array { bindings, .. } => bindings[0].ty,
        }
    }

    fn mutable_types(&self) -> Vec<DT> {
        match self {
            Binding::Single(s) => s.mutable_types_vec.clone(),
            Binding::Array { bindings, .. } => bindings[0].mutable_types_vec.clone(),
        }
    }

    fn size(&self) -> usize {
        match self {
            Binding::Single(_) => 1,
            Binding::Array { bindings, .. } => bindings.len(),
        }
    }

    fn is_array(&self) -> bool {
        matches!(self, Binding::Array { .. })
    }

    fn is_unbounded(&self) -> bool {
        matches!(self, Binding::Array { unbounded: true, .. })
    }

    fn needs_aliasing(&self, iteration: u32) -> bool {
        let types: BTreeSet<DT> = self.types_at_iteration(iteration).into_iter().collect();
        types.len() > 1
    }

    fn needs_aliasing_up_to(&self, num_iterations: u32) -> bool {
        (0..num_iterations).any(|iter| self.needs_aliasing(iter))
    }

    fn to_mutable(&self) -> Binding {
        match self {
            Binding::Single(s) => Binding::Single(s.to_mutable()),
            Binding::Array { unbounded, bindings } => {
                let first = bindings[0].to_mutable();
                Binding::new_array(*unbounded, vec![first; bindings.len()])
            }
        }
    }

    fn to_non_mutable(&self, iteration: u32) -> Binding {
        match self {
            Binding::Single(s) => Binding::Single(s.to_non_mutable(iteration)),
            Binding::Array { unbounded, bindings } => {
                assert!(!self.needs_aliasing(iteration));
                let first = SingleBinding::plain(bindings[0].type_at_iteration(iteration));
                Binding::new_array(*unbounded, vec![first; bindings.len()])
            }
        }
    }

    /// `createResources`
    fn create_resources<'a>(
        &self,
        device: &'a Device,
        alloc: &SimpleAllocator,
        q_index: u32,
        queue: vk::Queue,
        iteration: u32,
        use_aabbs: bool,
        base_value: u32,
    ) -> Result<Vec<Resource<'a>>, TestError> {
        let mut resources = Vec::new();
        match self {
            Binding::Single(s) => resources.push(Resource::new(
                s.type_at_iteration(iteration),
                device,
                alloc,
                q_index,
                queue,
                use_aabbs,
                base_value,
                1,
            )?),
            Binding::Array { bindings, .. } => {
                for (i, b) in bindings.iter().enumerate() {
                    resources.push(Resource::new(
                        b.type_at_iteration(iteration),
                        device,
                        alloc,
                        q_index,
                        queue,
                        use_aabbs,
                        base_value + i as u32,
                        1,
                    )?);
                }
            }
        }
        Ok(resources)
    }
}

/// `DescriptorSet` - a set of bindings and the operations the test performs on it.
struct DescriptorSetModel {
    bindings: Vec<Binding>,
}

/// `DescriptorSetLayoutResult`
enum LayoutResult<'a> {
    Supported,
    Unsupported,
    Layout(Unique<'a, vk::DescriptorSetLayout>),
}

impl DescriptorSetModel {
    fn new(bindings: Vec<Binding>) -> Self {
        assert!(!bindings.is_empty());
        Self { bindings }
    }

    fn num_bindings(&self) -> usize {
        self.bindings.len()
    }

    /// Maximum number of descriptor types used by any binding in the set.
    fn max_types(&self) -> u32 {
        self.bindings
            .iter()
            .map(|b| b.max_types())
            .max()
            .expect("descriptor set is never empty")
    }

    /// `genSourceSet`
    fn gen_source_set(&self, strategy: SourceSetStrategy, iteration: u32) -> DescriptorSetModel {
        let new_bindings = self
            .bindings
            .iter()
            .map(|b| {
                if strategy == SourceSetStrategy::Mutable {
                    b.to_mutable()
                } else {
                    b.to_non_mutable(iteration)
                }
            })
            .collect();
        DescriptorSetModel::new(new_bindings)
    }

    /// `makeDescriptorPool`
    fn make_descriptor_pool<'a>(
        &self,
        device: &'a Device,
        strategy: PoolMutableStrategy,
        flags: vk::DescriptorPoolCreateFlags,
    ) -> Result<Unique<'a, vk::DescriptorPool>, TestError> {
        let mut pool_sizes: Vec<vk::DescriptorPoolSize> = Vec::with_capacity(self.num_bindings());
        let mut mutable_types_vec: Vec<Vec<DT>> = Vec::with_capacity(self.num_bindings());
        let mut mutable_type_lists: Vec<vk::MutableDescriptorTypeListEXT> = Vec::with_capacity(self.num_bindings());
        let mut mutable_descriptor_before = false;
        let mut count_non_mut_desc_after_mut_desc = 0u32;

        for b in &self.bindings {
            let main_type = b.main_type();
            pool_sizes.push(vk::DescriptorPoolSize {
                type_: main_type,
                descriptor_count: b.size() as u32,
            });

            match strategy {
                PoolMutableStrategy::KeepTypes
                | PoolMutableStrategy::ExpandTypes
                | PoolMutableStrategy::KeepNoMutableTypes => {
                    if main_type == MUTABLE {
                        if strategy == PoolMutableStrategy::KeepNoMutableTypes {
                            mutable_descriptor_before = true;
                            count_non_mut_desc_after_mut_desc = 0;
                            continue;
                        } else if strategy == PoolMutableStrategy::KeepTypes {
                            mutable_types_vec.push(b.mutable_types());
                        } else {
                            let mandatory = to_descriptor_type_flags(&MANDATORY_TYPES);
                            mutable_types_vec.push(to_descriptor_type_vector(
                                mandatory | to_descriptor_type_flags(&b.mutable_types()),
                            ));
                        }

                        let last = mutable_types_vec.last().expect("just pushed");
                        mutable_type_lists.push(vk::MutableDescriptorTypeListEXT {
                            descriptor_type_count: last.len() as u32,
                            descriptor_types: last.as_ptr(),
                        });
                        assert!(!mutable_descriptor_before || strategy != PoolMutableStrategy::KeepNoMutableTypes);
                    } else {
                        mutable_type_lists.push(vk::MutableDescriptorTypeListEXT {
                            descriptor_type_count: 0,
                            descriptor_types: std::ptr::null(),
                        });
                        count_non_mut_desc_after_mut_desc += 1;
                    }
                }
                PoolMutableStrategy::NoTypes => {}
            }
        }

        if strategy == PoolMutableStrategy::KeepNoMutableTypes {
            assert!(mutable_descriptor_before && count_non_mut_desc_after_mut_desc == 0);
        }

        let mut mutable_info = vk::MutableDescriptorTypeCreateInfoEXT::default();
        let mut pool_create_info = vk::DescriptorPoolCreateInfo {
            flags,
            max_sets: 1,
            pool_size_count: pool_sizes.len() as u32,
            pool_sizes: pool_sizes.as_ptr(),
            ..Default::default()
        };

        if matches!(
            strategy,
            PoolMutableStrategy::KeepTypes | PoolMutableStrategy::ExpandTypes
        ) || (strategy == PoolMutableStrategy::KeepNoMutableTypes
            && mutable_descriptor_before
            && count_non_mut_desc_after_mut_desc == 0)
        {
            mutable_info.mutable_descriptor_type_list_count = mutable_type_lists.len() as u32;
            mutable_info.mutable_descriptor_type_lists = mutable_type_lists.as_ptr();
            pool_create_info.next = &mutable_info as *const _ as *const c_void;
        }

        let pool =
            unsafe { device.create_descriptor_pool(&pool_create_info, None) }.vk_check("vkCreateDescriptorPool")?;
        Ok(Unique::new(device, pool))
    }

    /// `makeOrCheckDescriptorSetLayout`
    fn make_or_check_descriptor_set_layout<'a>(
        &self,
        check_only: bool,
        device: &'a Device,
        stage_flags: vk::ShaderStageFlags,
        create_flags: vk::DescriptorSetLayoutCreateFlags,
    ) -> Result<LayoutResult<'a>, TestError> {
        let num_iterations = self.max_types();
        let binding_count = self.num_bindings();
        let mut bindings_vec: Vec<vk::DescriptorSetLayoutBinding> = Vec::with_capacity(binding_count);
        let mut mutable_types_vec: Vec<Vec<DT>> = Vec::with_capacity(binding_count);
        let mut mutable_type_lists: Vec<vk::MutableDescriptorTypeListEXT> = Vec::with_capacity(binding_count);

        for (binding_idx, binding) in self.bindings.iter().enumerate() {
            bindings_vec.push(vk::DescriptorSetLayoutBinding {
                binding: binding_idx as u32,
                descriptor_type: binding.main_type(),
                descriptor_count: binding.size() as u32,
                stage_flags,
                immutable_samplers: std::ptr::null(),
            });

            mutable_types_vec.push(binding.mutable_types());
            let last = mutable_types_vec.last().expect("just pushed");
            mutable_type_lists.push(vk::MutableDescriptorTypeListEXT {
                descriptor_type_count: last.len() as u32,
                descriptor_types: if last.is_empty() {
                    std::ptr::null()
                } else {
                    last.as_ptr()
                },
            });
        }

        let update_after_bind = create_flags.contains(vk::DescriptorSetLayoutCreateFlags::UPDATE_AFTER_BIND_POOL);
        let mut last_is_unbounded = false;
        let mut aliasing_needed = false;
        let mut binding_needs_aliasing = vec![false; self.bindings.len()];

        for (binding_idx, binding) in self.bindings.iter().enumerate() {
            if binding_idx < self.bindings.len() - 1 {
                assert!(!binding.is_unbounded());
            } else {
                last_is_unbounded = binding.is_unbounded();
            }

            if binding.needs_aliasing_up_to(num_iterations) {
                binding_needs_aliasing[binding_idx] = true;
                aliasing_needed = true;
            }
        }

        let mut binding_flags_vec: Vec<vk::DescriptorBindingFlags> = Vec::new();
        let mut flags_create_info = vk::DescriptorSetLayoutBindingFlagsCreateInfo::default();
        let has_flags_info = update_after_bind || last_is_unbounded || aliasing_needed;

        if has_flags_info {
            let base = if update_after_bind {
                vk::DescriptorBindingFlags::UPDATE_AFTER_BIND
            } else {
                vk::DescriptorBindingFlags::empty()
            };
            binding_flags_vec = vec![base; bindings_vec.len()];
            if last_is_unbounded {
                *binding_flags_vec.last_mut().expect("never empty") |=
                    vk::DescriptorBindingFlags::VARIABLE_DESCRIPTOR_COUNT;
            }
            for (binding_idx, needs) in binding_needs_aliasing.iter().enumerate() {
                if *needs {
                    binding_flags_vec[binding_idx] |= vk::DescriptorBindingFlags::PARTIALLY_BOUND;
                }
            }
            flags_create_info.binding_count = binding_flags_vec.len() as u32;
            flags_create_info.binding_flags = binding_flags_vec.as_ptr();
        }

        let create_info_mutable = vk::MutableDescriptorTypeCreateInfoEXT {
            next: if has_flags_info {
                &flags_create_info as *const _ as *const c_void
            } else {
                std::ptr::null()
            },
            mutable_descriptor_type_list_count: mutable_type_lists.len() as u32,
            mutable_descriptor_type_lists: mutable_type_lists.as_ptr(),
            ..Default::default()
        };

        let layout_create_info = vk::DescriptorSetLayoutCreateInfo {
            next: &create_info_mutable as *const _ as *const c_void,
            flags: create_flags,
            binding_count: bindings_vec.len() as u32,
            bindings: bindings_vec.as_ptr(),
            ..Default::default()
        };

        if check_only {
            let mut support = vk::DescriptorSetLayoutSupport::default();
            unsafe { device.get_descriptor_set_layout_support(&layout_create_info, &mut support) };
            Ok(if support.supported == vk::TRUE {
                LayoutResult::Supported
            } else {
                LayoutResult::Unsupported
            })
        } else {
            let layout = unsafe { device.create_descriptor_set_layout(&layout_create_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?;
            Ok(LayoutResult::Layout(Unique::new(device, layout)))
        }
    }

    fn make_descriptor_set_layout<'a>(
        &self,
        device: &'a Device,
        stage_flags: vk::ShaderStageFlags,
        create_flags: vk::DescriptorSetLayoutCreateFlags,
    ) -> Result<Unique<'a, vk::DescriptorSetLayout>, TestError> {
        match self.make_or_check_descriptor_set_layout(false, device, stage_flags, create_flags)? {
            LayoutResult::Layout(layout) => Ok(layout),
            _ => unreachable!("a layout was asked for"),
        }
    }

    fn check_descriptor_set_layout(
        &self,
        device: &Device,
        stage_flags: vk::ShaderStageFlags,
        create_flags: vk::DescriptorSetLayoutCreateFlags,
    ) -> Result<bool, TestError> {
        Ok(matches!(
            self.make_or_check_descriptor_set_layout(true, device, stage_flags, create_flags)?,
            LayoutResult::Supported
        ))
    }

    fn num_descriptors(&self) -> usize {
        self.bindings.iter().map(|b| b.size()).sum()
    }

    /// `createResources`
    fn create_resources<'a>(
        &self,
        device: &'a Device,
        alloc: &SimpleAllocator,
        q_index: u32,
        queue: vk::Queue,
        iteration: u32,
        use_aabbs: bool,
    ) -> Result<Vec<Resource<'a>>, TestError> {
        let mut result = Vec::with_capacity(self.num_descriptors());
        for (binding_idx, binding) in self.bindings.iter().enumerate() {
            result.extend(binding.create_resources(
                device,
                alloc,
                q_index,
                queue,
                iteration,
                use_aabbs,
                get_descriptor_numeric_value(iteration, binding_idx as u32, 0),
            )?);
        }
        Ok(result)
    }

    /// `updateDescriptorSet`
    fn update_descriptor_set(
        &self,
        device: &Device,
        set: vk::DescriptorSet,
        iteration: u32,
        resources: &[Resource<'_>],
    ) {
        let num_resources = resources.len();
        assert_eq!(self.num_descriptors(), num_resources);

        let mut descriptor_writes: Vec<vk::WriteDescriptorSet> = Vec::with_capacity(num_resources);
        // Writes point into these, so their storage must never move.
        let mut image_info_vec: Vec<vk::DescriptorImageInfo> = Vec::with_capacity(num_resources);
        let mut buffer_info_vec: Vec<vk::DescriptorBufferInfo> = Vec::with_capacity(num_resources);
        let mut buffer_view_vec: Vec<vk::BufferView> = Vec::with_capacity(num_resources);
        let mut as_write_vec: Vec<vk::WriteDescriptorSetAccelerationStructureKHR> = Vec::with_capacity(num_resources);
        let mut resource_idx = 0usize;

        for (binding_idx, binding) in self.bindings.iter().enumerate() {
            let descriptor_types = binding.types_at_iteration(iteration);

            for descriptor_idx in 0..binding.size() {
                let resource = &resources[resource_idx];
                let descriptor_type = descriptor_types[descriptor_idx];
                assert!(resource.descriptor_type == descriptor_type);

                let write_info = resource.make_write_info();
                match &write_info {
                    WriteInfo::Image(info) => image_info_vec.push(*info),
                    WriteInfo::Buffer(info) => buffer_info_vec.push(*info),
                    WriteInfo::BufferView(view) => buffer_view_vec.push(*view),
                    WriteInfo::AccelerationStructure(info) => as_write_vec.push(*info),
                }

                // Add a new VkWriteDescriptorSet struct or extend the last one with more info. This helps exercise different implementation code paths.
                let mut extended = false;
                if let Some(last) = descriptor_writes.last_mut() {
                    if descriptor_idx > 0
                        && last.dst_set == set
                        && last.dst_binding == binding_idx as u32
                        && (last.dst_array_element + last.descriptor_count) == descriptor_idx as u32
                        && last.descriptor_type == descriptor_type
                        && !matches!(write_info, WriteInfo::AccelerationStructure(_))
                    {
                        last.descriptor_count += 1;
                        extended = true;
                    }
                }

                if !extended {
                    descriptor_writes.push(vk::WriteDescriptorSet {
                        next: if matches!(write_info, WriteInfo::AccelerationStructure(_)) {
                            as_write_vec.last().map_or(std::ptr::null(), |i| {
                                (i as *const vk::WriteDescriptorSetAccelerationStructureKHR).cast::<c_void>()
                            })
                        } else {
                            std::ptr::null()
                        },
                        dst_set: set,
                        dst_binding: binding_idx as u32,
                        dst_array_element: descriptor_idx as u32,
                        descriptor_count: 1,
                        descriptor_type,
                        image_info: if matches!(write_info, WriteInfo::Image(_)) {
                            image_info_vec.last().map_or(std::ptr::null(), |i| i as *const _)
                        } else {
                            std::ptr::null()
                        },
                        buffer_info: if matches!(write_info, WriteInfo::Buffer(_)) {
                            buffer_info_vec.last().map_or(std::ptr::null(), |i| i as *const _)
                        } else {
                            std::ptr::null()
                        },
                        texel_buffer_view: if matches!(write_info, WriteInfo::BufferView(_)) {
                            buffer_view_vec.last().map_or(std::ptr::null(), |i| i as *const _)
                        } else {
                            std::ptr::null()
                        },
                        ..Default::default()
                    });
                }

                resource_idx += 1;
            }
        }

        unsafe { device.update_descriptor_sets(&descriptor_writes, &[] as &[vk::CopyDescriptorSet]) };
    }

    /// `copyDescriptorSet`
    fn copy_descriptor_set(&self, device: &Device, src_set: vk::DescriptorSet, dst_set: vk::DescriptorSet) {
        let copies: Vec<vk::CopyDescriptorSet> = self
            .bindings
            .iter()
            .enumerate()
            .map(|(binding_idx, binding)| vk::CopyDescriptorSet {
                src_set,
                src_binding: binding_idx as u32,
                src_array_element: 0,
                dst_set,
                dst_binding: binding_idx as u32,
                dst_array_element: 0,
                descriptor_count: binding.size() as u32,
                ..Default::default()
            })
            .collect();
        unsafe { device.update_descriptor_sets(&[] as &[vk::WriteDescriptorSet], &copies) };
    }

    fn needs_aliasing(&self, iteration: u32) -> bool {
        self.bindings.iter().any(|b| b.needs_aliasing(iteration))
    }

    fn needs_any_aliasing(&self) -> bool {
        (0..self.max_types()).any(|iteration| self.needs_aliasing(iteration))
    }

    fn last_binding_is_unbounded(&self) -> bool {
        self.bindings.last().is_some_and(|b| b.is_unbounded())
    }

    fn get_variable_descriptor_count(&self) -> Option<u32> {
        if self.last_binding_is_unbounded() {
            Some(self.bindings.last().expect("checked above").size() as u32)
        } else {
            None
        }
    }

    fn contains_type_at_iteration(&self, descriptor_type: DT, iteration: u32) -> bool {
        self.bindings
            .iter()
            .any(|b| b.types_at_iteration(iteration).contains(&descriptor_type))
    }

    fn has_arrays(&self) -> bool {
        self.bindings.iter().any(|b| b.is_array())
    }

    /// `containsAnyDescriptorType`
    fn contains_any_descriptor_type(&self, descriptor_type: DT) -> bool {
        (0..self.max_types()).any(|iter| self.contains_type_at_iteration(descriptor_type, iter))
    }

    fn needs_external_image(&self) -> bool {
        self.contains_any_descriptor_type(SAMPLER)
    }

    fn needs_external_sampler(&self) -> bool {
        self.contains_any_descriptor_type(SAMPLED_IMAGE)
    }

    fn uses_input_attachments(&self) -> bool {
        self.contains_any_descriptor_type(INPUT_ATTACHMENT)
    }

    fn uses_acceleration_structures(&self) -> bool {
        self.contains_any_descriptor_type(ACCELERATION_STRUCTURE)
    }

    /// `getUsedDescriptorTypes`
    fn used_descriptor_types(&self, num_iterations: u32, predicate: fn(&Binding) -> bool) -> BTreeSet<DT> {
        let mut used = BTreeSet::new();
        for binding in self.bindings.iter().filter(|b| predicate(b)) {
            for iter in 0..num_iterations {
                used.extend(binding.types_at_iteration(iter));
            }
        }
        used
    }
}

/// `TestParams`
#[derive(Clone)]
struct TestParams {
    descriptor_set: Arc<DescriptorSetModel>,
    set_key: String,
    update_type: UpdateType,
    source_set_strategy: SourceSetStrategy,
    source_set_type: SourceSetType,
    pool_mutable_strategy: PoolMutableStrategy,
    update_moment: UpdateMoment,
    array_access_type: ArrayAccessType,
    testing_stage: TestingStage,
}

impl TestParams {
    fn stage_flags(&self) -> vk::ShaderStageFlags {
        match self.testing_stage {
            TestingStage::Compute => vk::ShaderStageFlags::COMPUTE,
            TestingStage::Vertex => vk::ShaderStageFlags::VERTEX,
            TestingStage::TessEval => vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            TestingStage::TessControl => vk::ShaderStageFlags::TESSELLATION_CONTROL,
            TestingStage::Geometry => vk::ShaderStageFlags::GEOMETRY,
            TestingStage::Fragment => vk::ShaderStageFlags::FRAGMENT,
            TestingStage::RayGen => vk::ShaderStageFlags::RAYGEN_KHR,
            TestingStage::Intersection => vk::ShaderStageFlags::INTERSECTION_KHR,
            TestingStage::AnyHit => vk::ShaderStageFlags::ANY_HIT_KHR,
            TestingStage::ClosestHit => vk::ShaderStageFlags::CLOSEST_HIT_KHR,
            TestingStage::Miss => vk::ShaderStageFlags::MISS_KHR,
            TestingStage::Callable => vk::ShaderStageFlags::CALLABLE_KHR,
        }
    }

    fn layout_create_flags(&self, is_source_set: bool) -> vk::DescriptorSetLayoutCreateFlags {
        let mut flags = vk::DescriptorSetLayoutCreateFlags::empty();
        if (!is_source_set || self.source_set_type != SourceSetType::HostOnly)
            && self.update_moment == UpdateMoment::UpdateAfterBind
        {
            flags |= vk::DescriptorSetLayoutCreateFlags::UPDATE_AFTER_BIND_POOL;
        }
        if is_source_set && self.source_set_type == SourceSetType::HostOnly {
            flags |= vk::DescriptorSetLayoutCreateFlags::HOST_ONLY_POOL_EXT;
        }
        flags
    }

    fn src_layout_create_flags(&self) -> vk::DescriptorSetLayoutCreateFlags {
        self.layout_create_flags(true)
    }

    fn dst_layout_create_flags(&self) -> vk::DescriptorSetLayoutCreateFlags {
        self.layout_create_flags(false)
    }

    fn pool_create_flags(&self, is_source_set: bool) -> vk::DescriptorPoolCreateFlags {
        let mut flags = vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET;
        if (!is_source_set || self.source_set_type != SourceSetType::HostOnly)
            && self.update_moment == UpdateMoment::UpdateAfterBind
        {
            flags |= vk::DescriptorPoolCreateFlags::UPDATE_AFTER_BIND;
        }
        if is_source_set && self.source_set_type == SourceSetType::HostOnly {
            flags |= vk::DescriptorPoolCreateFlags::HOST_ONLY_EXT;
        }
        flags
    }

    fn src_pool_create_flags(&self) -> vk::DescriptorPoolCreateFlags {
        self.pool_create_flags(true)
    }

    fn dst_pool_create_flags(&self) -> vk::DescriptorPoolCreateFlags {
        self.pool_create_flags(false)
    }

    fn bind_point(&self) -> vk::PipelineBindPoint {
        if self.testing_stage == TestingStage::Compute {
            vk::PipelineBindPoint::COMPUTE
        } else if is_ray_tracing_stage(self.testing_stage) {
            vk::PipelineBindPoint::RAY_TRACING_KHR
        } else {
            vk::PipelineBindPoint::GRAPHICS
        }
    }

    fn uses_push_constants(&self) -> bool {
        self.array_access_type == ArrayAccessType::PushConstant
    }

    /// Every case has its program set now: the ray tracing stages run through `vk::ray_tracing_util`.
    fn is_stub(&self) -> bool {
        false
    }

    /// `<set key>.<stage>.<pc|nopc>`, as scripts/gen_mutable_manifest.py writes it.
    fn shader_key(&self) -> String {
        format!(
            "{}.{}.{}",
            self.set_key,
            stage_name(self.testing_stage),
            if self.uses_push_constants() { "pc" } else { "nopc" }
        )
    }
}

fn shader_name(iteration: u32) -> String {
    format!("iteration-{iteration}")
}

/// `MutableTypesTest`
struct MutableTypesTest {
    name: String,
    params: TestParams,
}

impl MutableTypesTest {
    fn new(name: impl Into<String>, params: TestParams) -> Self {
        Self {
            name: name.into(),
            params,
        }
    }
}

fn acceleration_structure_features(context: &Context<'_>) -> vk::PhysicalDeviceAccelerationStructureFeaturesKHR {
    let mut features = vk::PhysicalDeviceAccelerationStructureFeaturesKHR::default();
    if context.is_device_functionality_supported("VK_KHR_acceleration_structure") {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

fn ray_tracing_pipeline_features(context: &Context<'_>) -> vk::PhysicalDeviceRayTracingPipelineFeaturesKHR {
    let mut features = vk::PhysicalDeviceRayTracingPipelineFeaturesKHR::default();
    if context.is_device_functionality_supported("VK_KHR_ray_tracing_pipeline") {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

fn ray_query_features(context: &Context<'_>) -> vk::PhysicalDeviceRayQueryFeaturesKHR {
    let mut features = vk::PhysicalDeviceRayQueryFeaturesKHR::default();
    if context.is_device_functionality_supported("VK_KHR_ray_query") {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

fn require_partially_bound(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_descriptor_indexing")?;
    if descriptor_indexing_features(context).descriptor_binding_partially_bound == vk::FALSE {
        return Err(TestError::NotSupported(
            "Partially bound bindings not supported".to_string(),
        ));
    }
    Ok(())
}

fn require_variable_descriptor_count(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_descriptor_indexing")?;
    if descriptor_indexing_features(context).descriptor_binding_variable_descriptor_count == vk::FALSE {
        return Err(TestError::NotSupported(
            "Variable descriptor count not supported".to_string(),
        ));
    }
    Ok(())
}

fn descriptor_indexing_features(context: &Context<'_>) -> vk::PhysicalDeviceDescriptorIndexingFeatures {
    let mut indexing_features = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    indexing_features
}

impl TestCase for MutableTypesTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        if !context.is_device_functionality_supported("VK_VALVE_mutable_descriptor_type")
            && !context.is_device_functionality_supported("VK_EXT_mutable_descriptor_type")
        {
            return Err(TestError::NotSupported(
                "VK_VALVE_mutable_descriptor_type or VK_EXT_mutable_descriptor_type is not supported".to_string(),
            ));
        }

        let mut mutable_descriptor_type = vk::PhysicalDeviceMutableDescriptorTypeFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut mutable_descriptor_type);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if mutable_descriptor_type.mutable_descriptor_type == vk::FALSE {
            return Err(TestError::NotSupported(
                "mutableDescriptorType feature is not supported".to_string(),
            ));
        }

        if params.is_stub() {
            return Ok(());
        }

        if is_ray_tracing_stage(params.testing_stage) {
            context.require_device_functionality("VK_KHR_acceleration_structure")?;
            context.require_device_functionality("VK_KHR_ray_tracing_pipeline")?;
            if ray_tracing_pipeline_features(context).ray_tracing_pipeline == vk::FALSE {
                return Err(TestError::NotSupported(
                    "rayTracingPipeline feature is not supported".to_string(),
                ));
            }
        }

        // Ray queries are used to verify acceleration structure descriptors.
        if params.descriptor_set.uses_acceleration_structures() {
            context.require_device_functionality("VK_KHR_acceleration_structure")?;
            context.require_device_functionality("VK_KHR_ray_query")?;
            if acceleration_structure_features(context).acceleration_structure == vk::FALSE {
                return Err(TestError::NotSupported(
                    "accelerationStructure feature is not supported".to_string(),
                ));
            }
            if ray_query_features(context).ray_query == vk::FALSE {
                return Err(TestError::NotSupported("rayQuery feature is not supported".to_string()));
            }
        }

        let num_iterations = params.descriptor_set.max_types();

        if params.descriptor_set.last_binding_is_unbounded() {
            require_variable_descriptor_count(context)?;
        }

        for iter in 0..num_iterations {
            if params.descriptor_set.needs_aliasing(iter) {
                require_partially_bound(context)?;
                break;
            }
        }

        if params.update_moment == UpdateMoment::UpdateAfterBind {
            let used_descriptor_types = params.descriptor_set.used_descriptor_types(num_iterations, |_| true);
            let indexing_features = descriptor_indexing_features(context);

            for desc_type in used_descriptor_types {
                match desc_type {
                    UNIFORM_BUFFER | DT::UNIFORM_BUFFER_DYNAMIC => {
                        if indexing_features.descriptor_binding_uniform_buffer_update_after_bind == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Update-after-bind not supported for uniform buffers".to_string(),
                            ));
                        }
                    }
                    SAMPLER | COMBINED_IMAGE_SAMPLER | SAMPLED_IMAGE => {
                        if indexing_features.descriptor_binding_sampled_image_update_after_bind == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Update-after-bind not supported for samplers and sampled images".to_string(),
                            ));
                        }
                    }
                    STORAGE_IMAGE => {
                        if indexing_features.descriptor_binding_storage_image_update_after_bind == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Update-after-bind not supported for storage images".to_string(),
                            ));
                        }
                    }
                    STORAGE_BUFFER | DT::STORAGE_BUFFER_DYNAMIC => {
                        if indexing_features.descriptor_binding_storage_buffer_update_after_bind == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Update-after-bind not supported for storage buffers".to_string(),
                            ));
                        }
                    }
                    UNIFORM_TEXEL_BUFFER => {
                        if indexing_features.descriptor_binding_uniform_texel_buffer_update_after_bind == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Update-after-bind not supported for uniform texel buffers".to_string(),
                            ));
                        }
                    }
                    STORAGE_TEXEL_BUFFER => {
                        if indexing_features.descriptor_binding_storage_texel_buffer_update_after_bind == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Update-after-bind not supported for storage texel buffers".to_string(),
                            ));
                        }
                    }
                    ACCELERATION_STRUCTURE => {
                        context.require_device_functionality("VK_KHR_acceleration_structure")?;
                        if acceleration_structure_features(context)
                            .descriptor_binding_acceleration_structure_update_after_bind
                            == vk::FALSE
                        {
                            return Err(TestError::NotSupported(
                                "Update-after-bind not supported for acceleration structures".to_string(),
                            ));
                        }
                    }
                    INPUT_ATTACHMENT => {
                        return Err(TestError::InternalError(
                            "Tests do not support update-after-bind with input attachments".to_string(),
                        ));
                    }
                    MUTABLE => {
                        return Err(TestError::InternalError(
                            "Found VK_DESCRIPTOR_TYPE_MUTABLE_EXT in list of used descriptor types".to_string(),
                        ));
                    }
                    other => {
                        return Err(TestError::InternalError(format!(
                            "Unexpected descriptor type found in list of used descriptor types: {other:?}"
                        )));
                    }
                }
            }
        }

        if params.array_access_type == ArrayAccessType::PushConstant {
            let used_descriptor_types = params
                .descriptor_set
                .used_descriptor_types(num_iterations, |b| b.is_array());
            let features = context.get_device_features();
            let descriptor_indexing_supported = context.is_device_functionality_supported("VK_EXT_descriptor_indexing");
            let indexing_features = descriptor_indexing_features(context);

            for desc_type in used_descriptor_types {
                match desc_type {
                    UNIFORM_BUFFER | DT::UNIFORM_BUFFER_DYNAMIC => {
                        if features.shader_uniform_buffer_array_dynamic_indexing == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Dynamic indexing not supported for uniform buffers".to_string(),
                            ));
                        }
                    }
                    SAMPLER | COMBINED_IMAGE_SAMPLER | SAMPLED_IMAGE => {
                        if features.shader_sampled_image_array_dynamic_indexing == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Dynamic indexing not supported for samplers and sampled images".to_string(),
                            ));
                        }
                    }
                    STORAGE_IMAGE => {
                        if features.shader_storage_image_array_dynamic_indexing == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Dynamic indexing not supported for storage images".to_string(),
                            ));
                        }
                    }
                    STORAGE_BUFFER | DT::STORAGE_BUFFER_DYNAMIC => {
                        if features.shader_storage_buffer_array_dynamic_indexing == vk::FALSE {
                            return Err(TestError::NotSupported(
                                "Dynamic indexing not supported for storage buffers".to_string(),
                            ));
                        }
                    }
                    UNIFORM_TEXEL_BUFFER => {
                        if !descriptor_indexing_supported
                            || indexing_features.shader_uniform_texel_buffer_array_dynamic_indexing == vk::FALSE
                        {
                            return Err(TestError::NotSupported(
                                "Dynamic indexing not supported for uniform texel buffers".to_string(),
                            ));
                        }
                    }
                    STORAGE_TEXEL_BUFFER => {
                        if !descriptor_indexing_supported
                            || indexing_features.shader_storage_texel_buffer_array_dynamic_indexing == vk::FALSE
                        {
                            return Err(TestError::NotSupported(
                                "Dynamic indexing not supported for storage texel buffers".to_string(),
                            ));
                        }
                    }
                    ACCELERATION_STRUCTURE => {
                        context.require_device_functionality("VK_KHR_acceleration_structure")?;
                    }
                    INPUT_ATTACHMENT => {
                        if !descriptor_indexing_supported
                            || indexing_features.shader_input_attachment_array_dynamic_indexing == vk::FALSE
                        {
                            return Err(TestError::NotSupported(
                                "Dynamic indexing not supported for input attachments".to_string(),
                            ));
                        }
                    }
                    MUTABLE => {
                        return Err(TestError::InternalError(
                            "Found VK_DESCRIPTOR_TYPE_MUTABLE_EXT in list of used array descriptor types".to_string(),
                        ));
                    }
                    other => {
                        return Err(TestError::InternalError(format!(
                            "Unexpected descriptor type found in list of used descriptor types: {other:?}"
                        )));
                    }
                }
            }
        }

        // Check layout support.
        {
            let device = context.get_device();
            let stage_flags = params.stage_flags();

            if !params.descriptor_set.check_descriptor_set_layout(
                device,
                stage_flags,
                params.dst_layout_create_flags(),
            )? {
                return Err(TestError::NotSupported(
                    "Required descriptor set layout not supported".to_string(),
                ));
            }

            if params.update_type == UpdateType::Copy {
                let layout_create_flags = params.src_layout_create_flags();
                if !params
                    .descriptor_set
                    .check_descriptor_set_layout(device, stage_flags, layout_create_flags)?
                {
                    return Err(TestError::NotSupported(
                        "Required descriptor set layout for source set not supported".to_string(),
                    ));
                }

                for iter in 0..num_iterations {
                    let src_set = params.descriptor_set.gen_source_set(params.source_set_strategy, iter);
                    if !src_set.check_descriptor_set_layout(device, stage_flags, layout_create_flags)? {
                        return Err(TestError::NotSupported(format!(
                            "Descriptor set layout for source set at iteration {iter} not supported"
                        )));
                    }
                }
            }
        }

        // Check supported stores and stages.
        let vertex_stage = is_vertex_stage(params.testing_stage);
        let fragment_stage = params.testing_stage == TestingStage::Fragment;
        let geometry_stage = params.testing_stage == TestingStage::Geometry;
        let tessellation = matches!(params.testing_stage, TestingStage::TessControl | TestingStage::TessEval);

        let features = context.get_device_features();
        if vertex_stage && features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Vertex pipeline stores and atomics not supported".to_string(),
            ));
        }
        if fragment_stage && features.fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Fragment shader stores and atomics not supported".to_string(),
            ));
        }
        if geometry_stage && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        if tessellation && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Tessellation shaders not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.is_stub() {
            return BinaryCollection::new(&[] as &'static [ProgramBinary]);
        }
        let key = self.params.shader_key();
        match PROGRAM_TABLE.binary_search_by(|(k, _)| (*k).cmp(key.as_str())) {
            Ok(index) => PROGRAM_TABLE[index].1.programs,
            Err(_) => BinaryCollection::new(&[] as &'static [ProgramBinary]),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MutableTypesInstance {
            context,
            params: self.params.clone(),
        })
    }

    fn is_stub(&self) -> bool {
        self.params.is_stub()
    }
}

/// `Step`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Step {
    Update,
    Bind,
}

/// `buildRenderPass`: input attachments only.
fn build_render_pass<'a>(
    device: &'a Device,
    resources: &[Resource<'_>],
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let mut attachment_descriptions: Vec<vk::AttachmentDescription> = Vec::new();
    let mut attachment_references: Vec<vk::AttachmentReference> = Vec::new();

    for resource in resources {
        if resource.descriptor_type == INPUT_ATTACHMENT {
            let next_index = attachment_descriptions.len() as u32;
            attachment_descriptions.push(vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: DESCRIPTOR_IMAGE_FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::LOAD,
                store_op: vk::AttachmentStoreOp::DONT_CARE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::GENERAL,
                final_layout: vk::ImageLayout::GENERAL,
            });
            attachment_references.push(vk::AttachmentReference {
                attachment: next_index,
                layout: vk::ImageLayout::GENERAL,
            });
        }
    }

    let subpass_description = vk::SubpassDescription {
        flags: vk::SubpassDescriptionFlags::empty(),
        pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
        input_attachment_count: attachment_references.len() as u32,
        input_attachments: attachment_references.as_ptr(),
        color_attachment_count: 0,
        color_attachments: std::ptr::null(),
        resolve_attachments: std::ptr::null(),
        depth_stencil_attachment: std::ptr::null(),
        preserve_attachment_count: 0,
        preserve_attachments: std::ptr::null(),
    };

    let subpasses = [subpass_description];
    let render_pass_create_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    let render_pass =
        unsafe { device.create_render_pass(&render_pass_create_info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `buildGraphicsPipeline`
#[allow(clippy::too_many_arguments)]
fn build_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    vert_module: Option<vk::ShaderModule>,
    tesc_module: Option<vk::ShaderModule>,
    tese_module: Option<vk::ShaderModule>,
    geom_module: Option<vk::ShaderModule>,
    frag_module: Option<vk::ShaderModule>,
    render_pass: vk::RenderPass,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let extent = default_extent();
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: extent.width as f32,
        height: extent.height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: extent.width,
            height: extent.height,
        },
    }];
    let has_tess = tesc_module.is_some() || tese_module.is_some();
    let topology = if has_tess {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_LIST
    };

    let entry = c"main";
    let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(stage)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build()
    };
    let mut stages = Vec::new();
    if let Some(module) = vert_module {
        stages.push(make_stage(vk::ShaderStageFlags::VERTEX, module));
    }
    if let Some(module) = tesc_module {
        stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, module));
    }
    if let Some(module) = tese_module {
        stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, module));
    }
    if let Some(module) = geom_module {
        stages.push(make_stage(vk::ShaderStageFlags::GEOMETRY, module));
    }
    if let Some(module) = frag_module {
        stages.push(make_stage(vk::ShaderStageFlags::FRAGMENT, module));
    }

    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);
    let tessellation_state =
        vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(if has_tess { 3 } else { 0 });
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(frag_module.is_none())
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder();

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);
    if has_tess {
        info = info.tessellation_state(&tessellation_state);
    }

    crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
}

/// `buildFramebuffer`
fn build_framebuffer<'a>(
    device: &'a Device,
    render_pass: vk::RenderPass,
    resources: &[Resource<'_>],
) -> Result<Unique<'a, vk::Framebuffer>, TestError> {
    let extent = default_extent();
    let input_attachments: Vec<vk::ImageView> = resources
        .iter()
        .filter(|r| r.descriptor_type == INPUT_ATTACHMENT)
        .map(|r| {
            r.image_view
                .as_ref()
                .expect("input attachment resource without a view")
                .get()
        })
        .collect();
    let info = vk::FramebufferCreateInfo::builder()
        .render_pass(render_pass)
        .attachments(&input_attachments)
        .width(extent.width)
        .height(extent.height)
        .layers(extent.depth);
    let framebuffer = unsafe { device.create_framebuffer(&info, None) }.vk_check("vkCreateFramebuffer")?;
    Ok(Unique::new(device, framebuffer))
}

/// `makeDescriptorSet` with the variable descriptor count chained when the last binding is unbounded.
fn allocate_descriptor_set<'a>(
    device: &'a Device,
    pool: vk::DescriptorPool,
    layout: vk::DescriptorSetLayout,
    variable_count: Option<u32>,
) -> Result<UniqueDescriptorSet<'a>, TestError> {
    let layouts = [layout];
    let counts = [variable_count.unwrap_or(0)];
    let mut count_info = vk::DescriptorSetVariableDescriptorCountAllocateInfo::builder().descriptor_counts(&counts);
    let mut info = vk::DescriptorSetAllocateInfo::builder()
        .descriptor_pool(pool)
        .set_layouts(&layouts);
    if variable_count.is_some() {
        info = info.push_next(&mut count_info);
    }
    let sets = unsafe { device.allocate_descriptor_sets(&info) }.vk_check("vkAllocateDescriptorSets")?;
    Ok(UniqueDescriptorSet::new(device, pool, sets[0]))
}

/// `MutableTypesInstance`
struct MutableTypesInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for MutableTypesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.params.is_stub() {
            return Err(TestError::NotPorted("this case has no program set".to_string()));
        }

        let context = self.context;
        let device = context.get_device();
        let q_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        let param_set = &self.params.descriptor_set;
        let num_iterations = param_set.max_types();
        let use_external_image = param_set.needs_external_image();
        let use_external_sampler = param_set.needs_external_sampler();
        let stage_flags = self.params.stage_flags();
        let src_set_needed = self.params.update_type == UpdateType::Copy;
        let update_after_bind = self.params.update_moment == UpdateMoment::UpdateAfterBind;
        let bind_point = self.params.bind_point();
        let testing_stage = self.params.testing_stage;
        let ray_tracing = is_ray_tracing_stage(testing_stage);
        let use_aabbs = testing_stage == TestingStage::Intersection;

        // Resources for each iteration.
        let mut all_resources: Vec<Vec<Resource<'_>>> = Vec::with_capacity(num_iterations as usize);

        let cmd_pool = make_command_pool(device, q_index)?;

        // Descriptor pool and set for the active (dst) descriptor set.
        let dst_pool = param_set.make_descriptor_pool(
            device,
            self.params.pool_mutable_strategy,
            self.params.dst_pool_create_flags(),
        )?;
        let dst_layout =
            param_set.make_descriptor_set_layout(device, stage_flags, self.params.dst_layout_create_flags())?;
        let dst_set = allocate_descriptor_set(
            device,
            *dst_pool,
            *dst_layout,
            param_set.get_variable_descriptor_count(),
        )?;

        // Source pool and set (optional).
        let src_pool_flags = self.params.src_pool_create_flags();
        let src_layout_flags = self.params.src_layout_create_flags();
        let mut src_pool: Option<Unique<'_, vk::DescriptorPool>> = None;
        let mut src_layout: Option<Unique<'_, vk::DescriptorSetLayout>> = None;
        let mut src_set: Option<UniqueDescriptorSet<'_>> = None;

        // Extra set for external resources and output buffer.
        let mut extra_resources: Vec<Resource<'_>> = Vec::new();
        extra_resources.push(Resource::new(
            STORAGE_BUFFER,
            device,
            alloc,
            q_index,
            queue,
            use_aabbs,
            0,
            num_iterations,
        )?);
        if use_external_image {
            extra_resources.push(Resource::new(
                SAMPLED_IMAGE,
                device,
                alloc,
                q_index,
                queue,
                use_aabbs,
                EXTERNAL_SAMPLED_IMAGE_VALUE,
                1,
            )?);
        }
        if use_external_sampler {
            extra_resources.push(Resource::new(SAMPLER, device, alloc, q_index, queue, use_aabbs, 0, 1)?);
        }
        if ray_tracing {
            extra_resources.push(Resource::new(
                ACCELERATION_STRUCTURE,
                device,
                alloc,
                q_index,
                queue,
                use_aabbs,
                0,
                1,
            )?);
        }

        let mut pool_builder = DescriptorPoolBuilder::new().add_type(STORAGE_BUFFER, 1);
        if use_external_image {
            pool_builder = pool_builder.add_type(SAMPLED_IMAGE, 1);
        }
        if use_external_sampler {
            pool_builder = pool_builder.add_type(SAMPLER, 1);
        }
        if ray_tracing {
            pool_builder = pool_builder.add_type(ACCELERATION_STRUCTURE, 1);
        }
        let extra_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let mut layout_builder = DescriptorSetLayoutBuilder::new().add_single_binding(STORAGE_BUFFER, stage_flags);
        if use_external_image {
            layout_builder = layout_builder.add_single_binding(SAMPLED_IMAGE, stage_flags);
        }
        if use_external_sampler {
            layout_builder = layout_builder.add_single_binding(SAMPLER, stage_flags);
        }
        if ray_tracing {
            // The extra acceleration structure is used from the ray generation shader only.
            layout_builder =
                layout_builder.add_single_binding(ACCELERATION_STRUCTURE, vk::ShaderStageFlags::RAYGEN_KHR);
        }
        let extra_layout = layout_builder.build(device)?;

        let extra_set = allocate_descriptor_set(device, *extra_pool, *extra_layout, None)?;

        // Update extra set.
        {
            let output_buffer_size = (std::mem::size_of::<u32>() * num_iterations as usize) as vk::DeviceSize;
            let mut binding_count = 0usize;
            let buffer_infos = [vk::DescriptorBufferInfo {
                buffer: extra_resources[binding_count]
                    .buffer_with_memory
                    .as_ref()
                    .expect("output buffer")
                    .get(),
                offset: 0,
                range: output_buffer_size,
            }];
            binding_count += 1;
            let mut writes = vec![vk::WriteDescriptorSet {
                dst_set: *extra_set,
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: STORAGE_BUFFER,
                buffer_info: buffer_infos.as_ptr(),
                ..Default::default()
            }];
            let mut image_infos: Vec<vk::DescriptorImageInfo> = Vec::with_capacity(2);
            let mut dst_binding = 1u32;
            if use_external_image {
                image_infos.push(vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: extra_resources[binding_count]
                        .image_view
                        .as_ref()
                        .expect("external image view")
                        .get(),
                    image_layout: vk::ImageLayout::GENERAL,
                });
                binding_count += 1;
                writes.push(vk::WriteDescriptorSet {
                    dst_set: *extra_set,
                    dst_binding,
                    descriptor_count: 1,
                    descriptor_type: SAMPLED_IMAGE,
                    image_info: image_infos.last().map_or(std::ptr::null(), |i| i as *const _),
                    ..Default::default()
                });
                dst_binding += 1;
            }
            if use_external_sampler {
                image_infos.push(vk::DescriptorImageInfo {
                    sampler: extra_resources[binding_count]
                        .sampler
                        .as_ref()
                        .expect("external sampler")
                        .get(),
                    image_view: vk::ImageView::null(),
                    image_layout: vk::ImageLayout::GENERAL,
                });
                writes.push(vk::WriteDescriptorSet {
                    dst_set: *extra_set,
                    dst_binding,
                    descriptor_count: 1,
                    descriptor_type: SAMPLER,
                    image_info: image_infos.last().map_or(std::ptr::null(), |i| i as *const _),
                    ..Default::default()
                });
                binding_count += 1;
                dst_binding += 1;
            }
            let mut as_writes: Vec<vk::WriteDescriptorSetAccelerationStructureKHR> = Vec::with_capacity(1);
            if ray_tracing {
                let structure = extra_resources[binding_count]
                    .acceleration_structure
                    .as_ref()
                    .expect("extra acceleration structure");
                as_writes.push(vk::WriteDescriptorSetAccelerationStructureKHR {
                    acceleration_structure_count: 1,
                    acceleration_structures: structure.tlas(),
                    ..Default::default()
                });
                writes.push(vk::WriteDescriptorSet {
                    next: (&as_writes[0] as *const vk::WriteDescriptorSetAccelerationStructureKHR).cast::<c_void>(),
                    dst_set: *extra_set,
                    dst_binding,
                    descriptor_count: 1,
                    descriptor_type: ACCELERATION_STRUCTURE,
                    ..Default::default()
                });
            }
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // Push constants.
        let zero = 0u32;
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        };

        let binaries = context.get_binary_collection();
        let mut vert_passthrough = None;
        let mut tese_passthrough = None;
        let mut tesc_passthrough = None;

        if matches!(
            testing_stage,
            TestingStage::Fragment | TestingStage::Geometry | TestingStage::TessControl | TestingStage::TessEval
        ) {
            vert_passthrough = Some(create_shader_module(device, binaries.get("vert")?)?);
        }
        if testing_stage == TestingStage::TessControl {
            tese_passthrough = Some(create_shader_module(device, binaries.get("tese")?)?);
        }
        if testing_stage == TestingStage::TessEval {
            tesc_passthrough = Some(create_shader_module(device, binaries.get("tesc")?)?);
        }
        let mut rgen_passthrough = None;
        let mut miss_passthrough = None;
        if ray_tracing && testing_stage != TestingStage::RayGen {
            rgen_passthrough = Some(create_shader_module(device, binaries.get("rgen")?)?);
        }
        if testing_stage == TestingStage::Intersection {
            miss_passthrough = Some(create_shader_module(device, binaries.get("miss")?)?);
        }
        let sbt_sizes = if ray_tracing {
            shader_group_sizes(context.get_instance(), context.get_physical_device())
        } else {
            (0, 1)
        };

        for iteration in 0..num_iterations {
            // Generate source set for the current iteration.
            if src_set_needed {
                // Free previous descriptor set before rebuilding the pool.
                src_set = None;
                let src_model = param_set.gen_source_set(self.params.source_set_strategy, iteration);
                src_pool =
                    Some(src_model.make_descriptor_pool(device, self.params.pool_mutable_strategy, src_pool_flags)?);
                src_layout = Some(src_model.make_descriptor_set_layout(device, stage_flags, src_layout_flags)?);
                src_set = Some(allocate_descriptor_set(
                    device,
                    **src_pool.as_ref().expect("just created"),
                    **src_layout.as_ref().expect("just created"),
                    src_model.get_variable_descriptor_count(),
                )?);
            }

            // Set layouts and sets used in the pipeline.
            let set_layouts = [*dst_layout, *extra_layout];
            let used_sets = [*dst_set, *extra_set];

            // Create resources.
            all_resources.push(param_set.create_resources(device, alloc, q_index, queue, iteration, use_aabbs)?);
            let resources = all_resources.last().expect("just pushed");

            // Make pipeline for the current iteration.
            let pc_ranges = [pc_range];
            let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
                .set_layouts(&set_layouts)
                .push_constant_ranges(&pc_ranges);
            let pipeline_layout = Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }
                    .vk_check("vkCreatePipelineLayout")?,
            );
            let shader_module = create_shader_module(device, binaries.get(&shader_name(iteration))?)?;

            let pipeline: Unique<'_, vk::Pipeline>;
            let mut sbt_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
            let no_region = vk::StridedDeviceAddressRegionKHR {
                device_address: 0,
                stride: 0,
                size: 0,
            };
            let (mut raygen_region, mut miss_region, mut hit_region, mut callable_region) =
                (no_region, no_region, no_region, no_region);
            let (mut hit_group, mut miss_group, mut call_group) = (0usize, 0usize, 0usize);
            let mut render_pass: Option<Unique<'_, vk::RenderPass>> = None;
            let mut framebuffer: Option<Unique<'_, vk::Framebuffer>> = None;

            if bind_point == vk::PipelineBindPoint::COMPUTE {
                let stage = vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::COMPUTE)
                    .module(*shader_module)
                    .name(b"main\0")
                    .build();
                let info = vk::ComputePipelineCreateInfo::builder()
                    .stage(stage)
                    .layout(*pipeline_layout)
                    .base_pipeline_index(0);
                let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                    .vk_check("vkCreateComputePipelines")?;
                pipeline = Unique::new(device, pipelines.0[0]);
            } else if bind_point == vk::PipelineBindPoint::RAY_TRACING_KHR {
                let mut builder = RayTracingPipelineBuilder::new();
                let rgen_module = match &rgen_passthrough {
                    Some(module) => **module,
                    None => *shader_module,
                };
                builder.add_shader(vk::ShaderStageFlags::RAYGEN_KHR, rgen_module, 0);
                match testing_stage {
                    TestingStage::RayGen => {}
                    TestingStage::Intersection => {
                        hit_group = 1;
                        miss_group = 2;
                        builder.add_shader(vk::ShaderStageFlags::INTERSECTION_KHR, *shader_module, hit_group);
                        builder.add_shader(
                            vk::ShaderStageFlags::MISS_KHR,
                            **miss_passthrough.as_ref().expect("passthrough miss shader"),
                            miss_group,
                        );
                    }
                    TestingStage::AnyHit => {
                        hit_group = 1;
                        builder.add_shader(vk::ShaderStageFlags::ANY_HIT_KHR, *shader_module, hit_group);
                    }
                    TestingStage::ClosestHit => {
                        hit_group = 1;
                        builder.add_shader(vk::ShaderStageFlags::CLOSEST_HIT_KHR, *shader_module, hit_group);
                    }
                    TestingStage::Miss => {
                        miss_group = 1;
                        builder.add_shader(vk::ShaderStageFlags::MISS_KHR, *shader_module, miss_group);
                    }
                    TestingStage::Callable => {
                        call_group = 1;
                        builder.add_shader(vk::ShaderStageFlags::CALLABLE_KHR, *shader_module, call_group);
                    }
                    _ => unreachable!("only ray tracing stages build ray tracing pipelines"),
                }
                pipeline = builder.create_pipeline(device, *pipeline_layout)?;

                let (handle_size, base_alignment) = sbt_sizes;
                let mut make_region = |group: usize| -> Result<vk::StridedDeviceAddressRegionKHR, TestError> {
                    let (buffer, region) = create_shader_binding_table(
                        device,
                        alloc,
                        *pipeline,
                        handle_size,
                        base_alignment,
                        group as u32,
                        1,
                    )?;
                    sbt_buffers.push(buffer);
                    Ok(region)
                };
                raygen_region = make_region(0)?;
                if miss_group > 0 {
                    miss_region = make_region(miss_group)?;
                }
                if hit_group > 0 {
                    hit_region = make_region(hit_group)?;
                }
                if call_group > 0 {
                    callable_region = make_region(call_group)?;
                }
            } else {
                let mut vert_module = None;
                let mut tese_module = None;
                let mut tesc_module = None;
                let mut geom_module = None;
                let mut frag_module = None;

                match testing_stage {
                    TestingStage::Vertex => vert_module = Some(*shader_module),
                    TestingStage::Fragment => {
                        vert_module = vert_passthrough.as_ref().map(|m| **m);
                        frag_module = Some(*shader_module);
                    }
                    TestingStage::Geometry => {
                        vert_module = vert_passthrough.as_ref().map(|m| **m);
                        geom_module = Some(*shader_module);
                    }
                    TestingStage::TessControl => {
                        vert_module = vert_passthrough.as_ref().map(|m| **m);
                        tese_module = tese_passthrough.as_ref().map(|m| **m);
                        tesc_module = Some(*shader_module);
                    }
                    TestingStage::TessEval => {
                        vert_module = vert_passthrough.as_ref().map(|m| **m);
                        tesc_module = tesc_passthrough.as_ref().map(|m| **m);
                        tese_module = Some(*shader_module);
                    }
                    _ => unreachable!("ray tracing and compute stages do not build graphics pipelines"),
                }

                let pass = build_render_pass(device, resources)?;
                pipeline = build_graphics_pipeline(
                    device,
                    *pipeline_layout,
                    vert_module,
                    tesc_module,
                    tese_module,
                    geom_module,
                    frag_module,
                    *pass,
                )?;
                framebuffer = Some(build_framebuffer(device, *pass, resources)?);
                render_pass = Some(pass);
            }

            // Command buffer for the current iteration.
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;

            begin_command_buffer(device, cmd)?;

            let steps = [
                if update_after_bind { Step::Bind } else { Step::Update },
                if update_after_bind { Step::Update } else { Step::Bind },
            ];

            for step in steps {
                if step == Step::Bind {
                    unsafe {
                        device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
                        device.cmd_bind_descriptor_sets(
                            cmd,
                            bind_point,
                            *pipeline_layout,
                            0,
                            &used_sets,
                            &[] as &[u32],
                        );
                    }
                } else if src_set_needed {
                    // These operations go through the original set, not the source set: its mutable type lists are not in iteration order.
                    let src = src_set.as_ref().expect("source set exists when copying");
                    param_set.update_descriptor_set(device, **src, iteration, resources);
                    param_set.copy_descriptor_set(device, **src, *dst_set);
                } else {
                    param_set.update_descriptor_set(device, *dst_set, iteration, resources);
                }
            }

            // Run shader.
            unsafe { device.cmd_push_constants(cmd, *pipeline_layout, stage_flags, 0, &zero.to_ne_bytes()) };

            if bind_point == vk::PipelineBindPoint::COMPUTE {
                unsafe { device.cmd_dispatch(cmd, 1, 1, 1) };
            } else if bind_point == vk::PipelineBindPoint::RAY_TRACING_KHR {
                unsafe {
                    device.cmd_trace_rays_khr(
                        cmd,
                        &raygen_region,
                        &miss_region,
                        &hit_region,
                        &callable_region,
                        1,
                        1,
                        1,
                    )
                };
            } else {
                let extent = default_extent();
                let render_area = vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: extent.width,
                        height: extent.height,
                    },
                };
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(**render_pass.as_ref().expect("graphics case has a render pass"))
                    .framebuffer(**framebuffer.as_ref().expect("graphics case has a framebuffer"))
                    .render_area(render_area);
                unsafe {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_draw(cmd, 3, 1, 0, 0);
                    device.cmd_end_render_pass(cmd);
                }
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;

            // Verify output buffer.
            {
                let output_buffer_val = extra_resources[0]
                    .get_stored_value(device, alloc, q_index, queue, iteration)?
                    .expect("the output buffer has a stored value");
                if output_buffer_val != EXPECTED_OUTPUT_BUFFER_VALUE {
                    return Ok(TestStatus::fail(format!(
                        "Iteration {iteration}: unexpected value found in output buffer (expected {EXPECTED_OUTPUT_BUFFER_VALUE} and found {output_buffer_val})"
                    )));
                }
            }

            // Verify descriptor writes.
            {
                let mut resources_offset = 0usize;
                for (binding_idx, binding) in param_set.bindings.iter().enumerate() {
                    let binding_types = binding.types_at_iteration(iteration);

                    for (descriptor_idx, descriptor_type) in binding_types.iter().enumerate() {
                        if !is_shader_writable(*descriptor_type) {
                            continue;
                        }

                        let resource = &resources[resources_offset + descriptor_idx];
                        let initial_value = resource.initial_value;
                        let stored_value = resource
                            .get_stored_value(device, alloc, q_index, queue, 0)?
                            .expect("a writable resource has a stored value");
                        let expected_value = initial_value | STORED_VALUE_MASK;
                        if expected_value != stored_value {
                            return Ok(TestStatus::fail(format!(
                                "Iteration {iteration}: descriptor at binding {binding_idx} index {descriptor_idx} with type {descriptor_type:?} contains unexpected value {stored_value:x} (expected {expected_value:x})"
                            )));
                        }
                    }

                    resources_offset += binding_types.len();
                }
            }
        }

        let _ = (&src_layout, &src_pool);
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMutableTestVariants`
fn create_mutable_test_variants(
    parent_group: &mut TestCaseGroup,
    set_key: &str,
    descriptor_set: &Arc<DescriptorSetModel>,
    stages_to_test: &[TestingStage],
) {
    let update_types = [(UpdateType::Write, "update_write"), (UpdateType::Copy, "update_copy")];
    let source_strategies = [
        (SourceSetStrategy::Mutable, "mutable_source"),
        (SourceSetStrategy::NonMutable, "nonmutable_source"),
        (SourceSetStrategy::NoSource, "no_source"),
    ];
    let source_types = [
        (SourceSetType::Normal, "normal_source"),
        (SourceSetType::HostOnly, "host_only_source"),
        (SourceSetType::NoSource, "no_source"),
    ];
    let pool_strategies = [
        (PoolMutableStrategy::KeepTypes, "pool_same_types"),
        (PoolMutableStrategy::NoTypes, "pool_no_types"),
        (PoolMutableStrategy::ExpandTypes, "pool_expand_types"),
    ];
    let update_moments = [
        (UpdateMoment::Normal, "pre_update"),
        (UpdateMoment::UpdateAfterBind, "update_after_bind"),
    ];
    let array_access_types = [
        (ArrayAccessType::Constant, "index_constant"),
        (ArrayAccessType::PushConstant, "index_push_constant"),
        (ArrayAccessType::NoArray, "no_array"),
    ];

    let has_arrays = descriptor_set.has_arrays();
    let has_input_attachments = descriptor_set.uses_input_attachments();

    for (update_type, ut_name) in update_types {
        let mut update_group = TestCaseGroup::new(ut_name);

        for (src_strategy, src_strategy_name) in source_strategies {
            // Skip combinations that make no sense.
            if update_type == UpdateType::Write && src_strategy != SourceSetStrategy::NoSource {
                continue;
            }
            if update_type == UpdateType::Copy && src_strategy == SourceSetStrategy::NoSource {
                continue;
            }
            if src_strategy == SourceSetStrategy::NonMutable && descriptor_set.needs_any_aliasing() {
                continue;
            }

            let mut src_strategy_group = TestCaseGroup::new(src_strategy_name);

            for (src_type, src_type_name) in source_types {
                if update_type == UpdateType::Write && src_type != SourceSetType::NoSource {
                    continue;
                }
                if update_type == UpdateType::Copy && src_type == SourceSetType::NoSource {
                    continue;
                }

                let mut src_type_group = TestCaseGroup::new(src_type_name);

                for (pool_strategy, pool_strategy_name) in pool_strategies {
                    let mut pool_strategy_group = TestCaseGroup::new(pool_strategy_name);

                    for (moment, moment_name) in update_moments {
                        if moment == UpdateMoment::UpdateAfterBind && has_input_attachments {
                            continue;
                        }

                        let mut moment_group = TestCaseGroup::new(moment_name);

                        for (access_type, access_type_name) in array_access_types {
                            if has_arrays && access_type == ArrayAccessType::NoArray {
                                continue;
                            }
                            if !has_arrays && access_type != ArrayAccessType::NoArray {
                                continue;
                            }

                            let mut access_type_group = TestCaseGroup::new(access_type_name);

                            for &test_stage in stages_to_test {
                                if has_input_attachments && test_stage != TestingStage::Fragment {
                                    continue;
                                }

                                let params = TestParams {
                                    descriptor_set: descriptor_set.clone(),
                                    set_key: set_key.to_string(),
                                    update_type,
                                    source_set_strategy: src_strategy,
                                    source_set_type: src_type,
                                    pool_mutable_strategy: pool_strategy,
                                    update_moment: moment,
                                    array_access_type: access_type,
                                    testing_stage: test_stage,
                                };

                                access_type_group
                                    .add_child(Box::new(MutableTypesTest::new(stage_name(test_stage), params))
                                        as Box<dyn TestCase>);
                            }

                            moment_group.add_child(access_type_group);
                        }

                        pool_strategy_group.add_child(moment_group);
                    }

                    src_type_group.add_child(pool_strategy_group);
                }

                src_strategy_group.add_child(src_type_group);
            }

            update_group.add_child(src_strategy_group);
        }

        parent_group.add_child(update_group);
    }
}

fn rotated(types: &[DT], by: usize) -> Vec<DT> {
    let mut v = types.to_vec();
    v.rotate_left(by);
    v
}

fn single(ty: DT, mutable_types: &[DT]) -> Binding {
    Binding::Single(SingleBinding::new(ty, mutable_types.to_vec()))
}

/// `createDescriptorMutableTests`
pub fn create_descriptor_mutable_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("mutable_descriptor");

    let all_stages = [
        TestingStage::Compute,
        TestingStage::Vertex,
        TestingStage::TessControl,
        TestingStage::TessEval,
        TestingStage::Geometry,
        TestingStage::Fragment,
        TestingStage::RayGen,
        TestingStage::Intersection,
        TestingStage::AnyHit,
        TestingStage::ClosestHit,
        TestingStage::Miss,
        TestingStage::Callable,
    ];
    let reduced_stages = [
        TestingStage::Compute,
        TestingStage::Vertex,
        TestingStage::Fragment,
        TestingStage::RayGen,
    ];
    let compute_only = [TestingStage::Compute];

    // Basic tests with a single mutable descriptor.
    {
        let mut single_cases = TestCaseGroup::new("single");

        for descriptor_type in BASIC_DESCRIPTOR_TYPES {
            let set_ptr = Arc::new(DescriptorSetModel::new(vec![single(MUTABLE, &[descriptor_type])]));
            let mut sub_group = TestCaseGroup::new(descriptor_type_str(descriptor_type));
            create_mutable_test_variants(
                &mut sub_group,
                &format!("single.{}", descriptor_type_str(descriptor_type)),
                &set_ptr,
                &all_stages,
            );
            single_cases.add_child(sub_group);
        }

        // Case with a single descriptor that iterates several types.
        {
            let set_ptr = Arc::new(DescriptorSetModel::new(vec![single(MUTABLE, &MANDATORY_TYPES)]));
            let mut sub_group = TestCaseGroup::new("all_mandatory");
            create_mutable_test_variants(&mut sub_group, "single.all_mandatory", &set_ptr, &reduced_stages);
            single_cases.add_child(sub_group);
        }

        // Cases that try to verify switching from any descriptor type to any other is possible.
        {
            let mut sub_group = TestCaseGroup::new("switches");

            for initial in BASIC_DESCRIPTOR_TYPES {
                for final_type in BASIC_DESCRIPTOR_TYPES {
                    if initial == final_type {
                        continue;
                    }

                    let set_ptr = Arc::new(DescriptorSetModel::new(vec![single(MUTABLE, &[initial, final_type])]));
                    let group_name = format!("{}_{}", descriptor_type_str(initial), descriptor_type_str(final_type));
                    let mut combination_group = TestCaseGroup::new(group_name.clone());
                    create_mutable_test_variants(
                        &mut combination_group,
                        &format!("single.switches.{group_name}"),
                        &set_ptr,
                        &reduced_stages,
                    );
                    sub_group.add_child(combination_group);
                }
            }

            single_cases.add_child(sub_group);
        }

        main_group.add_child(single_cases);
    }

    // Cases with a single non-mutable descriptor. This provides some basic checks to verify copying to non-mutable bindings works.
    {
        let mut single_non_mutable_group = TestCaseGroup::new("single_nonmutable");

        for descriptor_type in BASIC_DESCRIPTOR_TYPES {
            let descriptor_set = Arc::new(DescriptorSetModel::new(vec![Binding::Single(SingleBinding::plain(
                descriptor_type,
            ))]));
            let mut desc_group = TestCaseGroup::new(descriptor_type_str(descriptor_type));
            create_mutable_test_variants(
                &mut desc_group,
                &format!("single_nonmutable.{}", descriptor_type_str(descriptor_type)),
                &descriptor_set,
                &reduced_stages,
            );
            single_non_mutable_group.add_child(desc_group);
        }

        main_group.add_child(single_non_mutable_group);
    }

    let unbounded_cases = [(false, "constant_size"), (true, "unbounded")];
    let aliasing_cases = [(false, "noaliasing"), (true, "aliasing")];
    // oneArrayOnly, mixNonMutable, groupName
    let array_count_groups = [
        (true, false, "one_array"),
        (false, false, "multiple_arrays"),
        (false, true, "multiple_arrays_mixed"),
    ];

    for (one_array_only, mix_non_mutable, group_name) in array_count_groups {
        let mut array_group = TestCaseGroup::new(group_name);

        for (unbounded_case, unbounded_name) in unbounded_cases {
            let mut unbounded_group = TestCaseGroup::new(unbounded_name);

            for (aliasing_case, aliasing_name) in aliasing_cases {
                let mut aliasing_group = TestCaseGroup::new(aliasing_name);
                let mut set_bindings: Vec<Binding> = Vec::new();

                // Prepare descriptors for this test variant.
                for mandatory_types_rotation in 0..MANDATORY_TYPES.len() {
                    let is_last_binding = one_array_only || mandatory_types_rotation == MANDATORY_TYPES.len() - 1;
                    let is_unbounded = unbounded_case && is_last_binding;

                    // Create a rotation of the mandatory types for each mutable array binding.
                    let mandatory_types_vector = rotated(&MANDATORY_TYPES, mandatory_types_rotation);

                    let array_bindings: Vec<SingleBinding> = if aliasing_case {
                        // With aliasing, the descriptor types rotate in each descriptor.
                        (0..mandatory_types_vector.len())
                            .map(|type_idx| SingleBinding::new(MUTABLE, rotated(&mandatory_types_vector, type_idx)))
                            .collect()
                    } else {
                        // Without aliasing, all descriptors use the same type at the same time.
                        vec![SingleBinding::new(MUTABLE, mandatory_types_vector.clone()); mandatory_types_vector.len()]
                    };

                    set_bindings.push(Binding::new_array(is_unbounded, array_bindings));

                    if mix_non_mutable && !is_unbounded {
                        // Create a non-mutable array binding interleaved with the other ones.
                        let non_mutable_binding = SingleBinding::plain(MANDATORY_TYPES[mandatory_types_rotation]);
                        set_bindings.push(Binding::new_array(
                            false,
                            vec![non_mutable_binding; MANDATORY_TYPES.len()],
                        ));
                    }

                    if one_array_only {
                        break;
                    }
                }

                let descriptor_set = Arc::new(DescriptorSetModel::new(set_bindings));
                create_mutable_test_variants(
                    &mut aliasing_group,
                    &format!("{group_name}.{unbounded_name}.{aliasing_name}"),
                    &descriptor_set,
                    &compute_only,
                );

                unbounded_group.add_child(aliasing_group);
            }

            array_group.add_child(unbounded_group);
        }

        main_group.add_child(array_group);
    }

    // Cases with a single mutable binding followed by an array of mutable bindings. The array will use a single type beyond the mandatory ones.
    {
        let mut single_and_array_group = TestCaseGroup::new("single_and_array");

        for descriptor_type in BASIC_DESCRIPTOR_TYPES {
            // Input attachments will not use arrays.
            if descriptor_type == INPUT_ATTACHMENT {
                continue;
            }
            if MANDATORY_TYPES.contains(&descriptor_type) {
                continue;
            }

            let mut desc_type_group = TestCaseGroup::new(descriptor_type_str(descriptor_type));

            for (aliasing_case, aliasing_name) in aliasing_cases {
                let mut aliasing_group = TestCaseGroup::new(aliasing_name);

                // Add single type beyond the mandatory ones.
                let mut array_binding_desc_types = MANDATORY_TYPES.to_vec();
                array_binding_desc_types.push(descriptor_type);

                // Single mutable descriptor as the first binding.
                let mut set_bindings = vec![single(MUTABLE, &array_binding_desc_types)];

                // Descriptor array as the second binding.
                let array_bindings: Vec<SingleBinding> = if aliasing_case {
                    (0..array_binding_desc_types.len())
                        .map(|type_idx| SingleBinding::new(MUTABLE, rotated(&array_binding_desc_types, type_idx)))
                        .collect()
                } else {
                    vec![SingleBinding::new(MUTABLE, array_binding_desc_types.clone()); array_binding_desc_types.len()]
                };
                set_bindings.push(Binding::new_array(false, array_bindings));

                let descriptor_set = Arc::new(DescriptorSetModel::new(set_bindings));
                create_mutable_test_variants(
                    &mut aliasing_group,
                    &format!(
                        "single_and_array.{}.{aliasing_name}",
                        descriptor_type_str(descriptor_type)
                    ),
                    &descriptor_set,
                    &compute_only,
                );

                desc_type_group.add_child(aliasing_group);
            }

            single_and_array_group.add_child(desc_type_group);
        }

        main_group.add_child(single_and_array_group);
    }

    // Cases with several mutable non-array bindings.
    {
        let mut multiple_group = TestCaseGroup::new("multiple");
        let mut mutable_only_group = TestCaseGroup::new("mutable_only");
        let mut mixed_group = TestCaseGroup::new("mixed");

        // Each descriptor will have a different type in every iteration, like in the one_array aliasing case.
        for mixed in [false, true] {
            let mut set_bindings: Vec<Binding> = Vec::new();

            for type_idx in 0..MANDATORY_TYPES.len() {
                let rotated_types = rotated(&MANDATORY_TYPES, type_idx);
                set_bindings.push(single(MUTABLE, &rotated_types));

                // Additional non-mutable binding interleaved with the mutable ones.
                if mixed {
                    set_bindings.push(Binding::Single(SingleBinding::plain(rotated_types[0])));
                }
            }
            let descriptor_set = Arc::new(DescriptorSetModel::new(set_bindings));

            if mixed {
                create_mutable_test_variants(&mut mixed_group, "multiple.mixed", &descriptor_set, &compute_only);
            } else {
                create_mutable_test_variants(
                    &mut mutable_only_group,
                    "multiple.mutable_only",
                    &descriptor_set,
                    &compute_only,
                );
            }
        }

        multiple_group.add_child(mutable_only_group);
        multiple_group.add_child(mixed_group);
        main_group.add_child(multiple_group);
    }

    // Corner cases
    {
        let mut misc_group = TestCaseGroup::new("misc");

        let mutable_types = [STORAGE_BUFFER];
        let max_non_mutable_descs = 2u32;
        let max_mutable_descs = 2u32;

        for num_non_mut_descs in 0..=max_non_mutable_descs {
            for num_mut_descs in 1..=max_mutable_descs {
                let mut set_bindings: Vec<Binding> = Vec::new();

                for _ in 0..num_non_mut_descs {
                    set_bindings.push(Binding::Single(SingleBinding::plain(UNIFORM_BUFFER)));
                }

                // mutable descriptors are kept at end to make them out-of-range
                for _ in 0..num_mut_descs {
                    set_bindings.push(single(MUTABLE, &mutable_types));
                }

                let params = TestParams {
                    descriptor_set: Arc::new(DescriptorSetModel::new(set_bindings)),
                    set_key: format!("misc.out_of_range_{num_non_mut_descs}{num_mut_descs}"),
                    update_type: UpdateType::Write,
                    source_set_strategy: SourceSetStrategy::Mutable,
                    source_set_type: SourceSetType::Normal,
                    pool_mutable_strategy: PoolMutableStrategy::KeepNoMutableTypes,
                    update_moment: UpdateMoment::Normal,
                    array_access_type: ArrayAccessType::Constant,
                    testing_stage: TestingStage::Compute,
                };

                // mutable descriptor type out-of-range
                misc_group.add_child(Box::new(MutableTypesTest::new(
                    format!("mutable_type_out_of_range_{num_non_mut_descs}{num_mut_descs}"),
                    params,
                )) as Box<dyn TestCase>);
            }
        }

        main_group.add_child(misc_group);
    }

    main_group
}
