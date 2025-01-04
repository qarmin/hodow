// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiNullHandleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `test<Object>` template becomes one function over an enum of object kinds;
// `release` is the same overload set, dispatching on it.
//
// Not ported: the Vulkan SC `#ifdef` branches, which this port does not build.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtShaderObjectExtensionDeviceCommands, Handle, InstanceV1_1};

use super::case_util::add_case;
use super::counting_allocator::CountingAllocator;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

#[derive(Clone, Copy)]
enum Object {
    Buffer,
    BufferView,
    CommandPool,
    DescriptorPool,
    DescriptorSetLayout,
    Device,
    Event,
    Fence,
    Framebuffer,
    Image,
    ImageView,
    Instance,
    Pipeline,
    PipelineCache,
    PipelineLayout,
    QueryPool,
    RenderPass,
    Sampler,
    Semaphore,
    ShaderModule,
    ShaderExt,
    CommandBuffer,
    DescriptorSet,
    DeviceMemory,
}

/// `release(context, nullHandle, pAllocator)` for every kind that is destroyed by one handle.
fn release(context: &Context<'_>, object: Object, allocator: Option<&vk::AllocationCallbacks>) {
    let device = context.get_device();
    unsafe {
        match object {
            Object::Buffer => device.destroy_buffer(vk::Buffer::null(), allocator),
            Object::BufferView => device.destroy_buffer_view(vk::BufferView::null(), allocator),
            Object::CommandPool => device.destroy_command_pool(vk::CommandPool::null(), allocator),
            Object::DescriptorPool => device.destroy_descriptor_pool(vk::DescriptorPool::null(), allocator),
            Object::DescriptorSetLayout => {
                device.destroy_descriptor_set_layout(vk::DescriptorSetLayout::null(), allocator)
            }
            Object::Device => {
                // vulkanalia's `Device::destroy_device` destroys itself; the null handle has to go
                // through the command pointer.
                let allocator_ptr = allocator.map_or(std::ptr::null(), |a| a as *const vk::AllocationCallbacks);
                (device.commands().destroy_device)(vk::Device::null(), allocator_ptr);
            }
            Object::Event => device.destroy_event(vk::Event::null(), allocator),
            Object::Fence => device.destroy_fence(vk::Fence::null(), allocator),
            Object::Framebuffer => device.destroy_framebuffer(vk::Framebuffer::null(), allocator),
            Object::Image => device.destroy_image(vk::Image::null(), allocator),
            Object::ImageView => device.destroy_image_view(vk::ImageView::null(), allocator),
            Object::Instance => {
                let allocator_ptr = allocator.map_or(std::ptr::null(), |a| a as *const vk::AllocationCallbacks);
                (context.get_instance().commands().destroy_instance)(vk::Instance::null(), allocator_ptr);
            }
            Object::Pipeline => device.destroy_pipeline(vk::Pipeline::null(), allocator),
            Object::PipelineCache => device.destroy_pipeline_cache(vk::PipelineCache::null(), allocator),
            Object::PipelineLayout => device.destroy_pipeline_layout(vk::PipelineLayout::null(), allocator),
            Object::QueryPool => device.destroy_query_pool(vk::QueryPool::null(), allocator),
            Object::RenderPass => device.destroy_render_pass(vk::RenderPass::null(), allocator),
            Object::Sampler => device.destroy_sampler(vk::Sampler::null(), allocator),
            Object::Semaphore => device.destroy_semaphore(vk::Semaphore::null(), allocator),
            Object::ShaderModule => device.destroy_shader_module(vk::ShaderModule::null(), allocator),
            Object::ShaderExt => device.destroy_shader_ext(vk::ShaderEXT::null(), allocator),
            Object::DeviceMemory => device.free_memory(vk::DeviceMemory::null(), allocator),
            Object::CommandBuffer | Object::DescriptorSet => {
                unreachable!("freed through a pool, see test_command_buffer/test_descriptor_set")
            }
        }
    }
}

/// `reportStatus`
fn report_status(success: bool) -> TestOutcome {
    if success {
        Ok(TestStatus::pass("OK: no observable change"))
    } else {
        Ok(TestStatus::fail("Implementation allocated/freed the memory"))
    }
}

/// `test<Object>`
fn test(context: &Context<'_>, object: Object) -> TestOutcome {
    // Implementation should silently ignore a delete/free of a NULL handle.
    release(context, object, None);

    let recording_allocator = CountingAllocator::new();
    release(context, object, Some(recording_allocator.callbacks()));
    report_status(recording_allocator.get_num_records() == 0)
}

/// `test<VkCommandBuffer>`
fn test_command_buffer(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();

    let cmd_pool_create_info = vk::CommandPoolCreateInfo::builder()
        .flags(vk::CommandPoolCreateFlags::TRANSIENT)
        .queue_family_index(queue_family_index);

    let null_handles = [vk::CommandBuffer::null(); 3];

    // Default allocator
    {
        let cmd_pool = Unique::new(
            vk,
            unsafe { vk.create_command_pool(&cmd_pool_create_info, None) }.vk_check("vkCreateCommandPool")?,
        );

        unsafe { vk.free_command_buffers(*cmd_pool, &null_handles) };
    }

    // Custom allocator
    {
        let recording_allocator = CountingAllocator::new();
        let cmd_pool = Unique::with_allocator(
            vk,
            unsafe { vk.create_command_pool(&cmd_pool_create_info, Some(recording_allocator.callbacks())) }
                .vk_check("vkCreateCommandPool")?,
            Some(recording_allocator.callbacks()),
        );
        let num_initial_records = recording_allocator.get_num_records();

        unsafe { vk.free_command_buffers(*cmd_pool, &null_handles) };

        report_status(num_initial_records == recording_allocator.get_num_records())
    }
}

/// `test<VkDescriptorSet>`
fn test_descriptor_set(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();

    let pool_sizes = [
        // type, descriptorCount
        vk::DescriptorPoolSize {
            type_: vk::DescriptorType::UNIFORM_BUFFER,
            descriptor_count: 2,
        }, // arbitrary values
        vk::DescriptorPoolSize {
            type_: vk::DescriptorType::SAMPLER,
            descriptor_count: 1,
        },
        vk::DescriptorPoolSize {
            type_: vk::DescriptorType::SAMPLED_IMAGE,
            descriptor_count: 3,
        },
    ];
    let descriptor_pool_create_info = vk::DescriptorPoolCreateInfo::builder()
        .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
        .max_sets(2)
        .pool_sizes(&pool_sizes);

    let null_handles = [vk::DescriptorSet::null(); 3];

    // Default allocator
    {
        let descriptor_pool = Unique::new(
            vk,
            unsafe { vk.create_descriptor_pool(&descriptor_pool_create_info, None) }
                .vk_check("vkCreateDescriptorPool")?,
        );

        unsafe { vk.free_descriptor_sets(*descriptor_pool, &null_handles) }.ok();
    }

    // Custom allocator
    {
        let recording_allocator = CountingAllocator::new();
        let descriptor_pool = Unique::with_allocator(
            vk,
            unsafe { vk.create_descriptor_pool(&descriptor_pool_create_info, Some(recording_allocator.callbacks())) }
                .vk_check("vkCreateDescriptorPool")?,
            Some(recording_allocator.callbacks()),
        );
        let num_initial_records = recording_allocator.get_num_records();

        unsafe { vk.free_descriptor_sets(*descriptor_pool, &null_handles) }.ok();

        report_status(num_initial_records == recording_allocator.get_num_records())
    }
}

/// `checkEventSupport`
fn check_event_support(context: &Context<'_>) -> Result<(), TestError> {
    if context.is_device_functionality_supported("VK_KHR_portability_subset") {
        let mut portability_features = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut portability_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if portability_features.events == vk::FALSE {
            return Err(TestError::NotSupported(
                "VK_KHR_portability_subset: Events are not supported by this implementation".to_string(),
            ));
        }
    }
    Ok(())
}

/// `checkSupportShaderObject`
fn check_support_shader_object(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_shader_object")
}

#[derive(Clone, Copy)]
enum Check {
    None,
    Event,
    ShaderObject,
}

struct NullHandleCase {
    name: &'static str,
    object: Object,
    check: Check,
}

impl TestCase for NullHandleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.check {
            Check::None => Ok(()),
            Check::Event => check_event_support(context),
            Check::ShaderObject => check_support_shader_object(context),
        }
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NullHandleInstance {
            context,
            object: self.object,
        })
    }
}

struct NullHandleInstance<'a> {
    context: &'a Context<'a>,
    object: Object,
}

impl TestInstance for NullHandleInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.object {
            Object::CommandBuffer => test_command_buffer(self.context),
            Object::DescriptorSet => test_descriptor_set(self.context),
            object => test(self.context, object),
        }
    }
}

/// `addTestsToGroup`
fn add_tests_to_group(group: &mut TestCaseGroup) {
    let cases: [(&'static str, Object, Check); 24] = [
        ("destroy_buffer", Object::Buffer, Check::None),
        ("destroy_buffer_view", Object::BufferView, Check::None),
        ("destroy_command_pool", Object::CommandPool, Check::None),
        ("destroy_descriptor_pool", Object::DescriptorPool, Check::None),
        (
            "destroy_descriptor_set_layout",
            Object::DescriptorSetLayout,
            Check::None,
        ),
        ("destroy_device", Object::Device, Check::None),
        ("destroy_event", Object::Event, Check::Event),
        ("destroy_fence", Object::Fence, Check::None),
        ("destroy_framebuffer", Object::Framebuffer, Check::None),
        ("destroy_image", Object::Image, Check::None),
        ("destroy_image_view", Object::ImageView, Check::None),
        ("destroy_instance", Object::Instance, Check::None),
        ("destroy_pipeline", Object::Pipeline, Check::None),
        ("destroy_pipeline_cache", Object::PipelineCache, Check::None),
        ("destroy_pipeline_layout", Object::PipelineLayout, Check::None),
        ("destroy_query_pool", Object::QueryPool, Check::None),
        ("destroy_render_pass", Object::RenderPass, Check::None),
        ("destroy_sampler", Object::Sampler, Check::None),
        ("destroy_semaphore", Object::Semaphore, Check::None),
        ("destroy_shader_module", Object::ShaderModule, Check::None),
        ("destroy_shader_object", Object::ShaderExt, Check::ShaderObject),
        ("free_command_buffers", Object::CommandBuffer, Check::None),
        ("free_descriptor_sets", Object::DescriptorSet, Check::None),
        ("free_memory", Object::DeviceMemory, Check::None),
    ];
    for (name, object, check) in cases {
        add_case(group, NullHandleCase { name, object, check });
    }
}

/// `createNullHandleTests`
pub fn create_null_handle_tests() -> TestCaseGroup {
    // Destroying/freeing a VK_NULL_HANDLE should be silently ignored
    let mut group = TestCaseGroup::new("null_handle");
    add_tests_to_group(&mut group);
    group
}
