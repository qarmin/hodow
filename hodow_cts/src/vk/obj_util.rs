// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkObjUtil.hpp / .cpp
//   external/vulkancts/framework/vulkan/vkBarrierUtil.hpp / .cpp
//   external/vulkancts/framework/vulkan/vkBufferWithMemory.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};

/// `vk::makeBufferCreateInfo`
pub fn make_buffer_create_info(size: vk::DeviceSize, usage: vk::BufferUsageFlags) -> vk::BufferCreateInfo {
    vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::BufferCreateFlags::empty(),
        size,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
    }
}

/// `vk::makeDescriptorBufferInfo`
pub fn make_descriptor_buffer_info(buffer: vk::Buffer, offset: vk::DeviceSize, range: vk::DeviceSize) -> vk::DescriptorBufferInfo {
    vk::DescriptorBufferInfo { buffer, offset, range }
}

/// `vk::makeMemoryBarrier`
pub fn make_memory_barrier(src_access_mask: vk::AccessFlags, dst_access_mask: vk::AccessFlags) -> vk::MemoryBarrier {
    vk::MemoryBarrier {
        s_type: vk::StructureType::MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask,
    }
}

/// `vk::makeBufferMemoryBarrier`
pub fn make_buffer_memory_barrier(
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    buffer: vk::Buffer,
    offset: vk::DeviceSize,
    size: vk::DeviceSize,
) -> vk::BufferMemoryBarrier {
    vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset,
        size,
    }
}

/// `vk::makeCommandPool`
pub fn make_command_pool(device: &Device, queue_family_index: u32) -> Result<Unique<'_, vk::CommandPool>, TestError> {
    let info = vk::CommandPoolCreateInfo::builder()
        .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)
        .queue_family_index(queue_family_index);
    let pool = unsafe { device.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?;
    Ok(Unique::new(device, pool))
}

/// `vk::allocateCommandBuffer`
pub fn allocate_command_buffer(device: &Device, pool: vk::CommandPool, level: vk::CommandBufferLevel) -> Result<UniqueCommandBuffer<'_>, TestError> {
    let info = vk::CommandBufferAllocateInfo::builder().command_pool(pool).level(level).command_buffer_count(1);
    let buffers = unsafe { device.allocate_command_buffers(&info) }.vk_check("vkAllocateCommandBuffers")?;
    Ok(UniqueCommandBuffer::new(device, pool, buffers[0]))
}

/// `vk::makeDescriptorSet`
pub fn make_descriptor_set<'a>(device: &'a Device, pool: vk::DescriptorPool, layout: vk::DescriptorSetLayout) -> Result<UniqueDescriptorSet<'a>, TestError> {
    let layouts = [layout];
    let info = vk::DescriptorSetAllocateInfo::builder().descriptor_pool(pool).set_layouts(&layouts);
    let sets = unsafe { device.allocate_descriptor_sets(&info) }.vk_check("vkAllocateDescriptorSets")?;
    Ok(UniqueDescriptorSet::new(device, pool, sets[0]))
}

/// `vk::makeFramebuffer`
pub fn make_framebuffer<'a>(
    device: &'a Device,
    render_pass: vk::RenderPass,
    attachments: &[vk::ImageView],
    width: u32,
    height: u32,
    layers: u32,
) -> Result<Unique<'a, vk::Framebuffer>, TestError> {
    let info = vk::FramebufferCreateInfo::builder()
        .render_pass(render_pass)
        .attachments(attachments)
        .width(width)
        .height(height)
        .layers(layers);
    let framebuffer = unsafe { device.create_framebuffer(&info, None) }.vk_check("vkCreateFramebuffer")?;
    Ok(Unique::new(device, framebuffer))
}

/// `vk::makeRenderPass`, single colour attachment.
///
/// The attachment is cleared on load and stored, and the subpass leaves it in
/// COLOR_ATTACHMENT_OPTIMAL - the shape every ported graphics test needs so far.
pub fn make_render_pass(device: &Device, color_format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    make_render_pass_with_samples(device, color_format, vk::SampleCountFlags::_1)
}

/// The same with a chosen sample count.
pub fn make_render_pass_with_samples(device: &Device, color_format: vk::Format, samples: vk::SampleCountFlags) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(samples)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    let attachments = [attachment];

    let color_ref = vk::AttachmentReference::builder().attachment(0).layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    let color_refs = [color_ref];
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs);
    let subpasses = [subpass];

    let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `vk::makeRenderPass` in its general form: either a colour attachment or a
/// depth/stencil one, with a chosen load op and final layout.
///
/// Upstream's overload takes both formats and uses `VK_FORMAT_UNDEFINED` to mean
/// "no attachment of this kind"; the same convention is kept here so a call site
/// lines up with the C++ it came from.
pub fn make_render_pass_full(
    device: &Device,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    final_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let has_color = color_format != vk::Format::UNDEFINED;
    let format = if has_color { color_format } else { depth_stencil_format };
    let attachment = vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(load_op)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(final_layout);
    let attachments = [attachment];

    let reference = vk::AttachmentReference::builder().attachment(0).layout(final_layout);
    let refs = [reference];
    let subpass = if has_color {
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&refs)
    } else {
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .depth_stencil_attachment(&refs[0])
    };
    let subpasses = [subpass];

    let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `vk::makePipelineLayout`
pub fn make_pipeline_layout<'a>(device: &'a Device, set_layouts: &[vk::DescriptorSetLayout]) -> Result<Unique<'a, vk::PipelineLayout>, TestError> {
    let info = vk::PipelineLayoutCreateInfo::builder().set_layouts(set_layouts);
    let layout = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
    Ok(Unique::new(device, layout))
}

/// `vk::makeGraphicsPipeline`, with upstream's defaults for every state the ported
/// tests do not override.
///
/// Upstream's signature takes five shader modules and a dozen optional state pointers;
/// this takes the two stages and the one state that has ever differed. Widening it is
/// a matter of adding a parameter when a test needs one, rather than carrying twelve
/// `None`s at every call site.
pub fn make_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    vertex_shader_module: vk::ShaderModule,
    fragment_shader_module: vk::ShaderModule,
    render_pass: vk::RenderPass,
    render_size: (u32, u32),
    topology: vk::PrimitiveTopology,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    make_graphics_pipeline_with_samples(
        device,
        pipeline_layout,
        vertex_shader_module,
        fragment_shader_module,
        render_pass,
        render_size,
        topology,
        vk::SampleCountFlags::_1,
    )
}

/// The same with a chosen rasterisation sample count, which the resolve tests need.
#[allow(clippy::too_many_arguments)]
pub fn make_graphics_pipeline_with_samples<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    vertex_shader_module: vk::ShaderModule,
    fragment_shader_module: vk::ShaderModule,
    render_pass: vk::RenderPass,
    render_size: (u32, u32),
    topology: vk::PrimitiveTopology,
    samples: vk::SampleCountFlags,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    make_graphics_pipeline_full(
        device,
        pipeline_layout,
        vertex_shader_module,
        fragment_shader_module,
        render_pass,
        render_size,
        topology,
        samples,
        None,
        1,
        None,
    )
}

/// The full form: a depth/stencil state may be supplied, and the colour-attachment
/// count may be zero for a pass that only writes buffers.
#[allow(clippy::too_many_arguments)]
pub fn make_graphics_pipeline_full<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    vertex_shader_module: vk::ShaderModule,
    fragment_shader_module: vk::ShaderModule,
    render_pass: vk::RenderPass,
    render_size: (u32, u32),
    topology: vk::PrimitiveTopology,
    samples: vk::SampleCountFlags,
    depth_stencil_state: Option<&vk::PipelineDepthStencilStateCreateInfoBuilder>,
    color_attachment_count: usize,
    vertex_attribute: Option<(vk::Format, u32)>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    make_graphics_pipeline_staged(
        device,
        pipeline_layout,
        GraphicsPipelineStages {
            vertex: vertex_shader_module,
            fragment: fragment_shader_module,
            tessellation_control: None,
            tessellation_evaluation: None,
            geometry: None,
        },
        render_pass,
        render_size,
        topology,
        samples,
        depth_stencil_state,
        color_attachment_count,
        vertex_attribute,
    )
}

/// The shader modules a graphics pipeline is built from. Vertex and fragment are
/// always present; the rest are the optional stages a synchronization operation may
/// run its payload in.
#[derive(Clone, Copy)]
pub struct GraphicsPipelineStages {
    pub vertex: vk::ShaderModule,
    pub fragment: vk::ShaderModule,
    pub tessellation_control: Option<vk::ShaderModule>,
    pub tessellation_evaluation: Option<vk::ShaderModule>,
    pub geometry: Option<vk::ShaderModule>,
}

/// `make_graphics_pipeline_full` with the tessellation and geometry stages available.
///
/// A pipeline with tessellation needs a patch-control-point count and a `PATCH_LIST`
/// topology; passing the two tessellation modules is what selects that here, so a
/// caller cannot get one without the other.
#[allow(clippy::too_many_arguments)]
pub fn make_graphics_pipeline_staged<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    modules: GraphicsPipelineStages,
    render_pass: vk::RenderPass,
    render_size: (u32, u32),
    topology: vk::PrimitiveTopology,
    samples: vk::SampleCountFlags,
    depth_stencil_state: Option<&vk::PipelineDepthStencilStateCreateInfoBuilder>,
    color_attachment_count: usize,
    vertex_attribute: Option<(vk::Format, u32)>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(stage)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build()
    };
    let mut stages = vec![
        make_stage(vk::ShaderStageFlags::VERTEX, modules.vertex),
        make_stage(vk::ShaderStageFlags::FRAGMENT, modules.fragment),
    ];
    if let Some(module) = modules.tessellation_control {
        stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, module));
    }
    if let Some(module) = modules.tessellation_evaluation {
        stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, module));
    }
    if let Some(module) = modules.geometry {
        stages.push(make_stage(vk::ShaderStageFlags::GEOMETRY, module));
    }
    let has_tessellation = modules.tessellation_control.is_some() && modules.tessellation_evaluation.is_some();
    let tessellation = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(3);

    // `setVertexInputSingleAttribute` - one binding at location 0, a tcu::Vec4 per
    // vertex unless the caller names a narrower attribute.
    let (attribute_format, attribute_stride) = vertex_attribute.unwrap_or((vk::Format::R32G32B32A32_SFLOAT, std::mem::size_of::<[f32; 4]>() as u32));
    let bindings = [vk::VertexInputBindingDescription::builder()
        .binding(0)
        .stride(attribute_stride)
        .input_rate(vk::VertexInputRate::VERTEX)
        .build()];
    let attributes = [vk::VertexInputAttributeDescription::builder()
        .location(0)
        .binding(0)
        .format(attribute_format)
        .offset(0)
        .build()];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);

    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(topology).primitive_restart_enable(false);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: render_size.0 as f32,
        height: render_size.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: render_size.0,
            height: render_size.1,
        },
    }];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);

    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);

    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(samples)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);

    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .build();
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    // One identical state per colour attachment, as upstream pushes.
    let blend_attachments = vec![
        vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::R | vk::ColorComponentFlags::G | vk::ColorComponentFlags::B | vk::ColorComponentFlags::A)
            .build();
        color_attachment_count
    ];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachments)
        .blend_constants([0.0; 4]);

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(depth_stencil_state.unwrap_or(&depth_stencil))
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);

    if has_tessellation {
        info = info.tessellation_state(&tessellation);
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `vk::BufferWithMemory` - a buffer plus the allocation backing it, bound together.
pub struct BufferWithMemory<'a> {
    buffer: Unique<'a, vk::Buffer>,
    allocation: Allocation<'a>,
}

impl<'a> BufferWithMemory<'a> {
    pub fn new(device: &'a Device, allocator: &SimpleAllocator, buffer_create_info: vk::BufferCreateInfo, requirement: MemoryRequirement) -> Result<Self, TestError> {
        let buffer = unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?;
        let buffer = Unique::new(device, buffer);

        let req = unsafe { device.get_buffer_memory_requirements(*buffer) };
        let allocation = allocator.allocate(device, req, requirement)?;

        unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset()) }.vk_check("vkBindBufferMemory")?;

        Ok(Self { buffer, allocation })
    }

    /// The same, through `VK_KHR_dedicated_allocation`. Upstream expresses the choice
    /// as an `AllocationKind` on the test parameters rather than as a second type.
    pub fn new_dedicated(device: &'a Device, allocator: &SimpleAllocator, buffer_create_info: vk::BufferCreateInfo, requirement: MemoryRequirement) -> Result<Self, TestError> {
        let buffer = unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?;
        let buffer = Unique::new(device, buffer);

        let req = unsafe { device.get_buffer_memory_requirements(*buffer) };
        let allocation = allocator.allocate_dedicated_buffer(device, req, requirement, *buffer)?;

        unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset()) }.vk_check("vkBindBufferMemory")?;

        Ok(Self { buffer, allocation })
    }

    pub fn get(&self) -> vk::Buffer {
        *self.buffer
    }

    /// `BufferWithMemory::getAllocation`
    pub fn get_allocation(&self) -> &Allocation<'a> {
        &self.allocation
    }
}

impl std::ops::Deref for BufferWithMemory<'_> {
    type Target = vk::Buffer;

    fn deref(&self) -> &vk::Buffer {
        &self.buffer
    }
}
