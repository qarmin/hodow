// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingUnusedInvalidDescriptorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The tested resources are destroyed by hand
// while a descriptor set still refers to them - that is the whole point of the cases - so
// `Resource` keeps raw handles and `destroy_internals` mirrors upstream's `DestroyInternals`;
// its `Drop` only cleans up whatever an early error left behind.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::dynamic_offset_tests::make_compute_pipeline;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;
const INVALID_FORMAT: vk::Format = vk::Format::R32_UINT;
const EXTENT: (u32, u32) = (32, 32);

#[derive(Clone, Copy, PartialEq, Eq)]
enum ResourceType {
    UniformBuffer,
    StorageBuffer,
    SampledImage,
    CombinedImageSampler,
    StorageImage,
}

impl ResourceType {
    fn require_image(self) -> bool {
        matches!(
            self,
            Self::SampledImage | Self::CombinedImageSampler | Self::StorageImage
        )
    }

    fn require_buffer(self) -> bool {
        !self.require_image()
    }

    fn require_sampler(self) -> bool {
        self == Self::CombinedImageSampler
    }

    fn image_usage(self) -> vk::ImageUsageFlags {
        match self {
            Self::SampledImage | Self::CombinedImageSampler => vk::ImageUsageFlags::SAMPLED,
            Self::StorageImage => vk::ImageUsageFlags::STORAGE,
            _ => vk::ImageUsageFlags::empty(),
        }
    }

    fn buffer_usage(self) -> vk::BufferUsageFlags {
        match self {
            Self::UniformBuffer => vk::BufferUsageFlags::UNIFORM_BUFFER,
            Self::StorageBuffer => vk::BufferUsageFlags::STORAGE_BUFFER,
            _ => vk::BufferUsageFlags::empty(),
        }
    }

    fn descriptor_type(self) -> vk::DescriptorType {
        match self {
            Self::UniformBuffer => vk::DescriptorType::UNIFORM_BUFFER,
            Self::StorageBuffer => vk::DescriptorType::STORAGE_BUFFER,
            Self::SampledImage => vk::DescriptorType::SAMPLED_IMAGE,
            Self::CombinedImageSampler => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            Self::StorageImage => vk::DescriptorType::STORAGE_IMAGE,
        }
    }

    /// `toString`
    fn name(self) -> &'static str {
        match self {
            Self::UniformBuffer => "uniform_buffer",
            Self::StorageBuffer => "storage_buffer",
            Self::SampledImage => "sampled_image",
            Self::CombinedImageSampler => "combined_image_sampler",
            Self::StorageImage => "storage_image",
        }
    }
}

/// `makeComputeRenderTargetCI`
fn make_compute_render_target_ci() -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format: IMAGE_FORMAT,
        extent: vk::Extent3D {
            width: EXTENT.0,
            height: EXTENT.1,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `makeImageCI`
fn make_image_ci(type_: ResourceType, invalid: bool) -> vk::ImageCreateInfo {
    let usage = vk::ImageUsageFlags::TRANSFER_DST | type_.image_usage();
    let mut sample_count = vk::SampleCountFlags::_1;
    let mut format = IMAGE_FORMAT;

    if invalid {
        if type_ == ResourceType::StorageImage {
            // For storage image we use invalid format
            format = INVALID_FORMAT;
        } else {
            // For sampled we use 4x MSAA
            sample_count = vk::SampleCountFlags::_4;
        }
    }

    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: EXTENT.0,
            height: EXTENT.1,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: sample_count,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// The sampler both the universal sampler and a `COMBINED_IMAGE_SAMPLER` resource use.
fn make_sampler_create_info() -> vk::SamplerCreateInfo {
    vk::SamplerCreateInfo {
        s_type: vk::StructureType::SAMPLER_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::SamplerCreateFlags::empty(),
        mag_filter: vk::Filter::NEAREST,
        min_filter: vk::Filter::NEAREST,
        mipmap_mode: vk::SamplerMipmapMode::NEAREST,
        address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        address_mode_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        mip_lod_bias: 0.0,
        anisotropy_enable: vk::FALSE,
        max_anisotropy: 1.0,
        compare_enable: vk::FALSE,
        compare_op: vk::CompareOp::ALWAYS,
        min_lod: 0.0,
        max_lod: 0.0,
        border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
        unnormalized_coordinates: vk::FALSE,
    }
}

/// `Resource`
struct Resource<'a> {
    device: &'a Device,
    type_: ResourceType,
    allocation: Allocation<'a>,
    image: vk::Image,
    image_view: vk::ImageView,
    sampler: vk::Sampler,
    image_info: vk::DescriptorImageInfo,
    buffer: vk::Buffer,
    buffer_info: vk::DescriptorBufferInfo,
}

impl<'a> Resource<'a> {
    fn new(
        type_: ResourceType,
        device: &'a Device,
        allocator: &SimpleAllocator,
        invalid: bool,
    ) -> Result<Self, TestError> {
        // Create resource and resource view of tested type
        if type_.require_image() {
            let image_create_info = make_image_ci(type_, invalid);
            let image = unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?;
            let requirements = unsafe { device.get_image_memory_requirements(image) };
            let allocation = allocator.allocate(device, requirements, MemoryRequirement::ANY)?;

            unsafe { device.bind_image_memory(image, allocation.get_memory(), allocation.get_offset()) }
                .vk_check("vkBindImageMemory")?;

            let mut format = IMAGE_FORMAT;
            if invalid && type_ == ResourceType::StorageImage {
                // For storage image we use invalid format
                format = INVALID_FORMAT;
            }

            let img_view_ci = vk::ImageViewCreateInfo {
                s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::ImageViewCreateFlags::empty(),
                image,
                view_type: vk::ImageViewType::_2D,
                format,
                components: vk::ComponentMapping::default(),
                subresource_range: make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            };
            let image_view = unsafe { device.create_image_view(&img_view_ci, None) }.vk_check("vkCreateImageView")?;

            let sampler = if type_.require_sampler() {
                unsafe { device.create_sampler(&make_sampler_create_info(), None) }.vk_check("vkCreateSampler")?
            } else {
                vk::Sampler::null()
            };

            Ok(Self {
                device,
                type_,
                allocation,
                image,
                image_view,
                sampler,
                image_info: vk::DescriptorImageInfo {
                    sampler,
                    image_view,
                    image_layout: vk::ImageLayout::GENERAL,
                },
                buffer: vk::Buffer::null(),
                buffer_info: vk::DescriptorBufferInfo::default(),
            })
        } else {
            let usage_flags = type_.buffer_usage() | vk::BufferUsageFlags::TRANSFER_DST;

            let buffer_create_info = make_buffer_create_info(4 * std::mem::size_of::<f32>() as u64, usage_flags);
            let buffer = unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?;
            let requirements = unsafe { device.get_buffer_memory_requirements(buffer) };
            let allocation = allocator.allocate(device, requirements, MemoryRequirement::HOST_VISIBLE)?;

            unsafe { device.bind_buffer_memory(buffer, allocation.get_memory(), allocation.get_offset()) }
                .vk_check("vkBindBufferMemory")?;

            Ok(Self {
                device,
                type_,
                allocation,
                image: vk::Image::null(),
                image_view: vk::ImageView::null(),
                sampler: vk::Sampler::null(),
                image_info: vk::DescriptorImageInfo::default(),
                buffer,
                buffer_info: vk::DescriptorBufferInfo {
                    buffer,
                    offset: 0,
                    range: vk::WHOLE_SIZE,
                },
            })
        }
    }

    fn descriptor_type(&self) -> vk::DescriptorType {
        self.type_.descriptor_type()
    }

    fn update(&self, queue: vk::Queue, queue_family_index: u32) -> Result<(), TestError> {
        let vk = self.device;

        if self.type_.require_image() {
            // Create command pool
            let cmd_pool = make_command_pool(vk, queue_family_index)?;

            // Create command buffer
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer.get();

            begin_command_buffer(vk, cmd_buffer)?;

            let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let clear_color_value = vk::ClearColorValue {
                float32: [0.5, 0.5, 0.5, 0.5],
            };

            // preClear barrier
            let pre_clear_img_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.image,
                color_subresource_range,
            );
            // postClear barrier
            let post_clear_img_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                self.image,
                color_subresource_range,
            );
            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_clear_img_barrier],
                );
                vk.cmd_clear_color_image(
                    cmd_buffer,
                    self.image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color_value,
                    &[color_subresource_range],
                );
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_clear_img_barrier],
                );
            }

            end_command_buffer(vk, cmd_buffer)?;
            submit_commands_and_wait(vk, queue, cmd_buffer)?;
        } else {
            let color = [0.5f32; 4];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    color.as_ptr().cast::<u8>(),
                    self.allocation.get_host_ptr(),
                    std::mem::size_of_val(&color),
                )
            };

            flush_alloc(vk, &self.allocation)?;
        }
        Ok(())
    }

    /// `DestroyInternals`
    fn destroy_internals(&mut self) {
        let vk = self.device;
        unsafe {
            if self.type_.require_image() {
                if self.sampler != vk::Sampler::null() {
                    vk.destroy_sampler(self.sampler, None);
                }
                if self.image_view != vk::ImageView::null() {
                    vk.destroy_image_view(self.image_view, None);
                }
                if self.image != vk::Image::null() {
                    vk.destroy_image(self.image, None);
                }
            } else if self.buffer != vk::Buffer::null() {
                vk.destroy_buffer(self.buffer, None);
            }
        }
        // The descriptor infos keep the stale handles on purpose: the sets still refer to them.
        self.sampler = vk::Sampler::null();
        self.image_view = vk::ImageView::null();
        self.image = vk::Image::null();
        self.buffer = vk::Buffer::null();
    }
}

impl Drop for Resource<'_> {
    fn drop(&mut self) {
        self.destroy_internals();
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    type_: ResourceType,
    add_invalid_descriptor: bool,
}

/// The write cases (`UnusedInvalidDescriptorWriteTestCase`) and the copy cases
/// (`InvalidDescriptorCopyTestCase`) share their shaders, support check and queue handling.
struct UnusedInvalidDescriptorCase {
    name: &'static str,
    params: TestParams,
    copy: bool,
    programs: BinaryCollection,
}

/// `commonCheckSupport`
fn common_check_support(context: &Context<'_>, type_: ResourceType) -> Result<(), TestError> {
    let features = context.get_device_features();

    context.require_device_functionality("VK_EXT_descriptor_indexing")?;

    let mut vulkan12_features = vk::PhysicalDeviceVulkan12Features::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan12_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if vulkan12_features.descriptor_binding_partially_bound == vk::FALSE {
        return Err(TestError::NotSupported(
            "Partially bound bindings not supported".to_string(),
        ));
    }

    match type_ {
        ResourceType::UniformBuffer => {
            if features.shader_uniform_buffer_array_dynamic_indexing == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Dynamic indexing not supported for uniform buffers".to_string(),
                ));
            }
        }
        ResourceType::StorageBuffer => {
            if features.shader_storage_buffer_array_dynamic_indexing == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Dynamic indexing not supported for storage buffers".to_string(),
                ));
            }
        }
        ResourceType::SampledImage | ResourceType::CombinedImageSampler => {
            if features.shader_sampled_image_array_dynamic_indexing == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Dynamic indexing not supported for samplers and sampled images".to_string(),
                ));
            }
        }
        ResourceType::StorageImage => {
            if features.shader_storage_image_array_dynamic_indexing == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Dynamic indexing not supported for storage images".to_string(),
                ));
            }
        }
    }
    Ok(())
}

impl TestCase for UnusedInvalidDescriptorCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, self.params.type_)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UnusedInvalidDescriptorInstance {
            context,
            params: self.params,
            copy: self.copy,
        })
    }
}

struct UnusedInvalidDescriptorInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    copy: bool,
}

impl UnusedInvalidDescriptorInstance<'_> {
    /// `MultiQueueRunnerTestInstance(context, COMPUTE_QUEUE)`: the universal queue, plus the
    /// compute-only family's when there is one.
    fn queues(&self) -> Vec<(vk::Queue, u32)> {
        let mut queues = vec![(
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )];
        if let Some((queue, family)) = self.context.get_compute_queue()
            && family != self.context.get_universal_queue_family_index()
        {
            queues.push((queue, family));
        }
        queues
    }

    /// The descriptor set layout of both cases: a storage image, a partially bound array of
    /// three descriptors of the tested type, and a sampler.
    fn create_descriptor_set_layout(&self) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        let vk = self.context.get_device();
        let bindings = [
            vk::DescriptorSetLayoutBinding {
                binding: 0,
                descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 1,
                descriptor_type: self.params.type_.descriptor_type(),
                descriptor_count: 3,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 2,
                descriptor_type: vk::DescriptorType::SAMPLER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
        ];
        let binding_flags = [
            vk::DescriptorBindingFlags::empty(),
            vk::DescriptorBindingFlags::PARTIALLY_BOUND,
            vk::DescriptorBindingFlags::empty(),
        ];
        let mut binding_flags_info =
            vk::DescriptorSetLayoutBindingFlagsCreateInfo::builder().binding_flags(&binding_flags);
        let info = vk::DescriptorSetLayoutCreateInfo::builder()
            .bindings(&bindings)
            .push_next(&mut binding_flags_info);
        Ok(Unique::new(
            vk,
            unsafe { vk.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?,
        ))
    }

    /// A pool for one set of that layout.
    fn create_descriptor_pool(&self) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        let vk = self.context.get_device();
        DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(self.params.type_.descriptor_type(), 3)
            .add_type(vk::DescriptorType::SAMPLER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)
    }

    /// Writes the three always-present bindings plus `array_count` entries of the tested array.
    fn write_descriptors(
        &self,
        set: vk::DescriptorSet,
        compute_rt_info: &vk::DescriptorImageInfo,
        sampler_info: &vk::DescriptorImageInfo,
        resources: &[Resource<'_>],
        array_count: usize,
    ) {
        let vk = self.context.get_device();
        let mut writes = vec![
            vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: set,
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                image_info: compute_rt_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            },
            vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: set,
                dst_binding: 2,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::SAMPLER,
                image_info: sampler_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            },
        ];
        for (element, resource) in resources.iter().enumerate().take(array_count) {
            writes.push(vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: set,
                dst_binding: 1,
                dst_array_element: element as u32,
                descriptor_count: 1,
                descriptor_type: resource.descriptor_type(),
                image_info: if self.params.type_.require_image() {
                    &resource.image_info as *const vk::DescriptorImageInfo
                } else {
                    std::ptr::null()
                },
                buffer_info: if self.params.type_.require_buffer() {
                    &resource.buffer_info as *const vk::DescriptorBufferInfo
                } else {
                    std::ptr::null()
                },
                texel_buffer_view: std::ptr::null(),
            });
        }
        unsafe { vk.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
    }

    /// `queuePass` of both cases; `copy` selects which.
    fn queue_pass(&self, queue: vk::Queue, queue_family_index: u32) -> TestOutcome {
        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let params = self.params;

        // Create compute render target
        let compute_rt = ImageWithMemory::new(vk, allocator, make_compute_render_target_ci(), MemoryRequirement::ANY)?;

        // Create compute render target view
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let compute_rt_view = make_image_view(
            vk,
            compute_rt.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            color_subresource_range,
        )?;
        let compute_rt_write_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *compute_rt_view,
            image_layout: vk::ImageLayout::GENERAL,
        };
        // Buffer to copy rendering result to.
        let results_buffer_size = (4 * std::mem::size_of::<f32>() as u32 * EXTENT.0 * EXTENT.1) as vk::DeviceSize;
        let results_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(results_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create universal sampler
        let universal_sampler = Unique::new(
            vk,
            unsafe { vk.create_sampler(&make_sampler_create_info(), None) }.vk_check("vkCreateSampler")?,
        );

        let sampler_info = vk::DescriptorImageInfo {
            sampler: *universal_sampler,
            image_view: vk::ImageView::null(),
            image_layout: vk::ImageLayout::UNDEFINED,
        };

        // Create tested resources
        let mut tested_resources: Vec<Resource<'_>> = Vec::new();
        if !self.copy {
            for _ in 0..2 {
                tested_resources.push(Resource::new(params.type_, vk, allocator, false)?);
            }
            // Create invalid resource if needed - if shader try to access this resource, it will cause crash
            if params.add_invalid_descriptor && params.type_.require_image() {
                tested_resources.push(Resource::new(params.type_, vk, allocator, true)?);
            }
        } else {
            // Create and update tested resources
            for _ in 0..3 {
                let resource = Resource::new(params.type_, vk, allocator, false)?;
                resource.update(queue, queue_family_index)?;
                tested_resources.push(resource);
            }
        }

        let descriptor_set_layout = self.create_descriptor_set_layout()?;

        // Descriptor set that the shader uses.
        let descriptor_pool;
        let descriptor_set;
        let src_descriptor_pool;
        let src_descriptor_set;
        let used_set: vk::DescriptorSet;

        if !self.copy {
            // Create descriptor set
            descriptor_pool = self.create_descriptor_pool()?;
            descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;
            src_descriptor_pool = None;
            src_descriptor_set = None;

            // Array elements 0 and 1 are valid; the invalid descriptor (index 2) is only written
            // when it exists.
            self.write_descriptors(
                descriptor_set.get(),
                &compute_rt_write_info,
                &sampler_info,
                &tested_resources,
                tested_resources.len(),
            );
            used_set = descriptor_set.get();
        } else {
            // Create src descriptor set
            let pool = self.create_descriptor_pool()?;
            let set = make_descriptor_set(vk, *pool, *descriptor_set_layout)?;
            self.write_descriptors(set.get(), &compute_rt_write_info, &sampler_info, &tested_resources, 3);

            // Create dst descriptor set
            descriptor_pool = self.create_descriptor_pool()?;
            descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

            // Destroy one resource and perform copy
            tested_resources[2].destroy_internals();

            let copies = [
                vk::CopyDescriptorSet {
                    s_type: vk::StructureType::COPY_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    src_set: set.get(),
                    src_binding: 0,
                    src_array_element: 0,
                    dst_set: descriptor_set.get(),
                    dst_binding: 0,
                    dst_array_element: 0,
                    descriptor_count: 1,
                },
                vk::CopyDescriptorSet {
                    s_type: vk::StructureType::COPY_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    src_set: set.get(),
                    src_binding: 2,
                    src_array_element: 0,
                    dst_set: descriptor_set.get(),
                    dst_binding: 2,
                    dst_array_element: 0,
                    descriptor_count: 1,
                },
                vk::CopyDescriptorSet {
                    s_type: vk::StructureType::COPY_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    src_set: set.get(),
                    src_binding: 1,
                    src_array_element: 0,
                    dst_set: descriptor_set.get(),
                    dst_binding: 1,
                    dst_array_element: 0,
                    descriptor_count: 3,
                },
            ];
            unsafe { vk.update_descriptor_sets(&[] as &[vk::WriteDescriptorSet], &copies) };

            used_set = descriptor_set.get();
            src_descriptor_pool = Some(pool);
            src_descriptor_set = Some(set);
        }
        let _ = (&src_descriptor_pool, &src_descriptor_set);

        // Create pipeline
        let compute_module = create_shader_module(vk, self.context.get_binary_collection().get("comp")?)?;

        let push_constant_range = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: 4,
        }];
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_constant_range);
        let pipeline_layout = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let compute_pipeline = make_compute_pipeline(vk, *pipeline_layout, *compute_module)?;

        // Create command pool
        let cmd_pool = make_command_pool(vk, queue_family_index)?;

        // Create command buffer
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        // Update resources (the write case; the copy case updated them when creating them)
        if !self.copy {
            for resource in &tested_resources {
                resource.update(queue, queue_family_index)?;
            }
        }

        // Record command buffer
        begin_command_buffer(vk, cmd_buffer)?;

        // Clear compute render target
        let clear_rt_color_value = vk::ClearColorValue {
            float32: [1.0, 0.0, 0.0, 1.0],
        };

        // preClear barrier
        let pre_clear_rt_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            compute_rt.get(),
            color_subresource_range,
        );
        // preWrite barrier
        let pre_write_rt_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            compute_rt.get(),
            color_subresource_range,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_clear_rt_barrier],
            );
            vk.cmd_clear_color_image(
                cmd_buffer,
                compute_rt.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_rt_color_value,
                &[color_subresource_range],
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_write_rt_barrier],
            );

            // Bind pipeline and descriptor set
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
            vk.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[used_set],
                &[],
            );

            // Push constants
            let index = 0u32;
            vk.cmd_push_constants(
                cmd_buffer,
                *pipeline_layout,
                vk::ShaderStageFlags::COMPUTE,
                0,
                &index.to_ne_bytes(),
            );

            // Dispath
            vk.cmd_dispatch(cmd_buffer, EXTENT.0, EXTENT.1, 1);
        }

        // copy result to results buffer
        copy_image_to_buffer(
            vk,
            cmd_buffer,
            compute_rt.get(),
            results_buffer.get(),
            EXTENT,
            results_buffer_size,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::GENERAL,
        );

        end_command_buffer(vk, cmd_buffer)?;

        // Submit work
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        // Destroying resources
        // (The copy case already destroyed the third one before the copy.)
        let destroy_count = if self.copy { 2 } else { tested_resources.len() };
        for resource in tested_resources.iter_mut().take(destroy_count) {
            resource.destroy_internals();
        }

        // Check result
        invalidate_alloc(vk, results_buffer.get_allocation())?;

        let result_pixels = results_buffer
            .get_allocation()
            .get_host_ptr()
            .cast_const()
            .cast::<f32>();

        // Expected result: every texel (1, 1, 1, 1), compared with a zero threshold.
        let mut ok = true;
        for i in 0..(EXTENT.0 * EXTENT.1 * 4) as usize {
            let value = unsafe { result_pixels.add(i).read_unaligned() };
            if value != 1.0 {
                log::info!(
                    "Queue family {queue_family_index} result comparison: texel component {i} is {value}, expected 1.0"
                );
                ok = false;
                break;
            }
        }
        if !ok {
            return Ok(TestStatus::fail("Failed"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `copyImageToBuffer` for the single 2D color layer these cases read back.
#[allow(clippy::too_many_arguments)]
fn copy_image_to_buffer(
    vk: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: (u32, u32),
    buffer_size: vk::DeviceSize,
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
) {
    let image_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        },
    };
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer,
        0,
        buffer_size,
    );
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
        vk.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[region],
        );
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

impl TestInstance for UnusedInvalidDescriptorInstance<'_> {
    /// `MultiQueueRunnerTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        for (queue, queue_family_index) in self.queues() {
            let status = self.queue_pass(queue, queue_family_index)?;
            if status.code() != TestResult::Pass {
                return Ok(status);
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createUnusedInvalidDescriptorTests`
pub fn create_unused_invalid_descriptor_tests() -> TestCaseGroup {
    use crate::generated::shaders::binding_model_unused_invalid as g;

    let programs_for = |type_: ResourceType| -> BinaryCollection {
        match type_ {
            ResourceType::UniformBuffer => g::UNUSED_INVALID_UNIFORM_BUFFER.programs,
            ResourceType::StorageBuffer => g::UNUSED_INVALID_STORAGE_BUFFER.programs,
            ResourceType::SampledImage => g::UNUSED_INVALID_SAMPLED_IMAGE.programs,
            ResourceType::CombinedImageSampler => g::UNUSED_INVALID_COMBINED_IMAGE_SAMPLER.programs,
            ResourceType::StorageImage => g::UNUSED_INVALID_STORAGE_IMAGE.programs,
        }
    };

    let mut group = TestCaseGroup::new("unused_invalid_descriptor");

    // Descriptor writes
    {
        let mut write = TestCaseGroup::new("write");

        // Unused binding
        {
            let mut unused = TestCaseGroup::new("unused");

            let types = [
                ResourceType::UniformBuffer,
                ResourceType::StorageBuffer,
                ResourceType::SampledImage,
                ResourceType::CombinedImageSampler,
                ResourceType::StorageImage,
            ];

            for type_ in types {
                unused.add_child(Box::new(UnusedInvalidDescriptorCase {
                    name: type_.name(),
                    params: TestParams {
                        type_,
                        add_invalid_descriptor: false,
                    },
                    copy: false,
                    programs: programs_for(type_),
                }) as Box<dyn TestCase>);
            }

            write.add_child(unused);
        }

        // Invalid binding
        {
            let mut invalid = TestCaseGroup::new("invalid");

            let types = [
                ResourceType::SampledImage,
                ResourceType::CombinedImageSampler,
                ResourceType::StorageImage,
            ];

            for type_ in types {
                invalid.add_child(Box::new(UnusedInvalidDescriptorCase {
                    name: type_.name(),
                    params: TestParams {
                        type_,
                        add_invalid_descriptor: true,
                    },
                    copy: false,
                    programs: programs_for(type_),
                }) as Box<dyn TestCase>);
            }

            write.add_child(invalid);
        }

        group.add_child(write);
    }

    // Descriptor copy
    {
        let mut copy = TestCaseGroup::new("copy");

        let types = [
            ResourceType::UniformBuffer,
            ResourceType::StorageBuffer,
            ResourceType::SampledImage,
            ResourceType::CombinedImageSampler,
            ResourceType::StorageImage,
        ];

        for type_ in types {
            copy.add_child(Box::new(UnusedInvalidDescriptorCase {
                name: type_.name(),
                params: TestParams {
                    type_,
                    add_invalid_descriptor: false,
                },
                copy: true,
                programs: programs_for(type_),
            }) as Box<dyn TestCase>);
        }

        group.add_child(copy);
    }

    group
}
