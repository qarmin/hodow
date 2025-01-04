// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiGetMemoryCommitment.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The vertex and fragment shaders are in `shaders/manifest/api_memory_commitment.toml`;
// the allocate-only case has none. `rand() % 1000 + 1` becomes a fixed sequence, since the
// sizes only have to vary.

use vulkanalia::prelude::v1_0::*;

use super::case_util::add_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_framebuffer, make_graphics_pipeline, make_pipeline_layout, make_render_pass,
};
// Re-exported so the generated shader module, which imports this module wholesale,
// can name the type its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const VK_MAX_MEMORY_TYPES: usize = 32;

/// `MemoryCommitmentCaseParams`
#[derive(Clone, Copy)]
struct MemoryCommitmentCaseParams {
    #[allow(dead_code)]
    buffer_size: u32,
    buffer_view_size: u32,
    #[allow(dead_code)]
    element_offset: u32,
}

/// `getLazilyAllocatedIndices`
fn get_lazily_allocated_indices(context: &Context<'_>) -> Vec<u32> {
    let property_flag = vk::MemoryPropertyFlags::LAZILY_ALLOCATED;
    let p_memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };

    (0..p_memory_properties.memory_type_count)
        .filter(|&type_index| {
            p_memory_properties.memory_types[type_index as usize]
                .property_flags
                .contains(property_flag)
        })
        .collect()
}

fn check_support_lazily_allocated(context: &Context<'_>) -> Result<(), TestError> {
    // Note we can still fail later if none of lazily allocated memory types can be used with the image below.
    if get_lazily_allocated_indices(context).is_empty() {
        return Err(TestError::NotSupported(
            "Lazily allocated bit is not supported by any memory type".to_string(),
        ));
    }
    Ok(())
}

/// `MemoryCommitmentTestInstance::isDeviceMemoryCommitmentOk`
fn is_device_memory_commitment_ok(
    context: &Context<'_>,
    render_size: u32,
    memory_requirements: vk::MemoryRequirements,
) -> Result<bool, TestError> {
    let property_flag = vk::MemoryPropertyFlags::LAZILY_ALLOCATED;
    let p_memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    // `mapVkFormat(VK_FORMAT_R32_UINT).getPixelSize()`
    let pixel_data_size = (render_size * render_size * 4) as vk::DeviceSize;
    let device = context.get_device();

    for mem_type_ndx in 0..VK_MAX_MEMORY_TYPES {
        if p_memory_properties.memory_types[mem_type_ndx]
            .property_flags
            .contains(property_flag)
        {
            // if supports Lazy allocation
            let mem_alloc_info = vk::MemoryAllocateInfo::builder()
                .allocation_size(pixel_data_size)
                .memory_type_index(mem_type_ndx as u32);
            let memory = Unique::new(
                device,
                unsafe { device.allocate_memory(&mem_alloc_info, None) }.vk_check("vkAllocateMemory")?,
            );
            let p_committed_memory_in_bytes = unsafe { device.get_device_memory_commitment(*memory) };
            if p_committed_memory_in_bytes <= memory_requirements.size {
                return Ok(true);
            }
        }
    }
    Ok(false)
}

/// `MemoryCommitmentTestInstance::iterate`
fn memory_commitment_iterate(context: &Context<'_>, params: MemoryCommitmentCaseParams) -> TestOutcome {
    use crate::generated::shaders::api_memory_commitment::MEMORY_COMMITMENT;

    let render_size = params.buffer_view_size;
    let mem_alloc = context.get_default_allocator();
    let queue_family_index = context.get_universal_queue_family_index();
    let vkd = context.get_device();
    let cmd_pool_info = vk::CommandPoolCreateInfo::builder()
        .flags(vk::CommandPoolCreateFlags::TRANSIENT)
        .queue_family_index(queue_family_index);
    let cmd_pool = Unique::new(
        vkd,
        unsafe { vkd.create_command_pool(&cmd_pool_info, None) }.vk_check("vkCreateCommandPool")?,
    );
    let cmd_buffer = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let queue_family_indices = [queue_family_index];
    let image_params = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(vk::Format::R32_UINT)
        .extent(vk::Extent3D {
            width: 256,
            height: 256,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .queue_family_indices(&queue_family_indices)
        .initial_layout(vk::ImageLayout::UNDEFINED);

    let image = Unique::new(
        vkd,
        unsafe { vkd.create_image(&image_params, None) }.vk_check("vkCreateImage")?,
    );
    let memory_requirements = unsafe { vkd.get_image_memory_requirements(*image) };
    let image_alloc = mem_alloc.allocate(vkd, memory_requirements, MemoryRequirement::LAZILY_ALLOCATED)?;

    unsafe { vkd.bind_image_memory(*image, image_alloc.get_memory(), image_alloc.get_offset()) }
        .vk_check("vkBindImageMemory")?;

    let color_attachment_view = make_image_view(
        vkd,
        *image,
        vk::ImageViewType::_2D,
        vk::Format::R32_UINT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;

    // Create render pass
    let render_pass = make_render_pass(vkd, vk::Format::R32_UINT)?;

    // Create framebuffer
    let framebuffer = make_framebuffer(
        vkd,
        *render_pass,
        &[*color_attachment_view],
        render_size,
        render_size,
        1,
    )?;

    // Create descriptors
    let layout_bindings = [vk::DescriptorSetLayoutBinding::builder()
        .binding(0)
        .descriptor_type(vk::DescriptorType::UNIFORM_TEXEL_BUFFER)
        .descriptor_count(1)
        .stage_flags(vk::ShaderStageFlags::ALL)
        .build()];
    let descriptor_layout_params = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&layout_bindings);
    let descriptor_set_layout = Unique::new(
        vkd,
        unsafe { vkd.create_descriptor_set_layout(&descriptor_layout_params, None) }
            .vk_check("vkCreateDescriptorSetLayout")?,
    );

    // Create pipeline layout
    let pipeline_layout = make_pipeline_layout(vkd, &[*descriptor_set_layout])?;

    // Create shaders
    let vertex_shader_module = create_shader_module(vkd, MEMORY_COMMITMENT.programs.get("vert")?)?;
    let fragment_shader_module = create_shader_module(vkd, MEMORY_COMMITMENT.programs.get("frag")?)?;

    // Create pipeline
    let graphics_pipelines = make_graphics_pipeline(
        vkd,
        *pipeline_layout,
        *vertex_shader_module,
        *fragment_shader_module,
        *render_pass,
        (render_size, render_size),
        vk::PrimitiveTopology::TRIANGLE_LIST,
    )?;

    // getMemoryCommitment
    let mut is_memory_allocation_ok = is_device_memory_commitment_ok(context, render_size, memory_requirements)?;

    let clear_color = [1u32, 1, 1, 1];
    let clear_attachment = vk::ClearAttachment {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        color_attachment: 0,
        clear_value: vk::ClearValue {
            color: vk::ClearColorValue { uint32: clear_color },
        },
    };

    let rect = vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: 256,
            height: 256,
        },
    };

    let clear_rect = vk::ClearRect {
        rect,
        base_array_layer: 0,
        layer_count: 1,
    };

    // beginCommandBuffer
    begin_command_buffer(vkd, *cmd_buffer)?;

    let initial_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        *image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );

    unsafe {
        vkd.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[initial_image_barrier],
        );
    }
    begin_render_pass(
        vkd,
        *cmd_buffer,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, 256, 256),
        vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 1.0, 1.0],
            },
        },
    );
    unsafe {
        vkd.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines);
        // clearAttachments
        vkd.cmd_clear_attachments(*cmd_buffer, &[clear_attachment], &[clear_rect]);
    }
    end_render_pass(vkd, *cmd_buffer);
    end_command_buffer(vkd, *cmd_buffer)?;

    // queueSubmit
    submit_commands_and_wait(vkd, context.get_universal_queue(), *cmd_buffer)?;

    // getMemoryCommitment
    is_memory_allocation_ok =
        is_memory_allocation_ok && is_device_memory_commitment_ok(context, render_size, memory_requirements)?;

    if is_memory_allocation_ok {
        return Ok(TestStatus::pass("Pass"));
    }

    Ok(TestStatus::fail("Fail"))
}

/// `MemoryCommitmentAllocateOnlyTestInstance::iterate`
fn memory_commitment_allocate_only_iterate(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let memory_type_indices = get_lazily_allocated_indices(context);
    let array_length = 10usize;

    // generating random allocation sizes
    let alloc_size: Vec<vk::DeviceSize> = (0..array_length).map(|i| ((i as u64 * 7919 + 13) % 1000) + 1).collect();

    for memory_type_index in memory_type_indices {
        for &size in &alloc_size {
            let mem_alloc_info = vk::MemoryAllocateInfo::builder()
                .allocation_size(size)
                .memory_type_index(memory_type_index);

            let memory = Unique::new(
                device,
                unsafe { device.allocate_memory(&mem_alloc_info, None) }.vk_check("vkAllocateMemory")?,
            );

            let p_committed_memory_in_bytes = unsafe { device.get_device_memory_commitment(*memory) };
            if p_committed_memory_in_bytes != 0 {
                log::info!("Warning: Memory commitment not null before binding.");
            }
            if p_committed_memory_in_bytes > size {
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `MemoryCommitmentTestCase` / `MemoryCommitmentAllocateOnlyTestCase`
struct MemoryCommitmentCase {
    name: &'static str,
    /// `None` is the allocate-only case.
    params: Option<MemoryCommitmentCaseParams>,
}

impl TestCase for MemoryCommitmentCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_lazily_allocated(context)
    }

    fn programs(&self) -> BinaryCollection {
        match self.params {
            Some(_) => crate::generated::shaders::api_memory_commitment::MEMORY_COMMITMENT.programs,
            None => NO_PROGRAMS,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryCommitmentInstance {
            context,
            params: self.params,
        })
    }
}

struct MemoryCommitmentInstance<'a> {
    context: &'a Context<'a>,
    params: Option<MemoryCommitmentCaseParams>,
}

impl TestInstance for MemoryCommitmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.params {
            Some(params) => memory_commitment_iterate(self.context, params),
            None => memory_commitment_allocate_only_iterate(self.context),
        }
    }
}

/// `createMemoryCommitmentTests`
pub fn create_memory_commitment_tests() -> TestCaseGroup {
    let info = MemoryCommitmentCaseParams {
        buffer_size: 2048,
        buffer_view_size: 256,
        element_offset: 0,
    };

    let mut get_memory_commitment_tests = TestCaseGroup::new("get_memory_commitment");

    add_case(
        &mut get_memory_commitment_tests,
        MemoryCommitmentCase {
            name: "memory_commitment",
            params: Some(info),
        },
    );
    add_case(
        &mut get_memory_commitment_tests,
        MemoryCommitmentCase {
            name: "memory_commitment_allocate_only",
            params: None,
        },
    );

    get_memory_commitment_tests
}
