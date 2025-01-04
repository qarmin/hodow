// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleTests.cpp (VariableRateTestCase, the `variable_rate` and
//   `mixed_count` groups)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only and no fragment shading rate. The log of the
// buffer contents (`LOG_BUFFER_CONTENTS`, compiled out upstream) is dropped.
//
// Subpasses that use no attachments are given sample counts of their own. A render pass with one empty subpass per count
// (the reference, with a subpass dependent sample count) has to cover exactly the samples that one render pass with a single
// subpass does when the pipelines of the counts are drawn in turn (the output), over an empty or non-empty framebuffer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::pipeline_variable_rate::VARIABLE_RATE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{end_dynamic_rendering, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 256;
const HEIGHT: u32 = 256;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

const SAMPLE_COUNTS: [vk::SampleCountFlags; 7] = [
    vk::SampleCountFlags::_1,
    vk::SampleCountFlags::_2,
    vk::SampleCountFlags::_4,
    vk::SampleCountFlags::_8,
    vk::SampleCountFlags::_16,
    vk::SampleCountFlags::_32,
    vk::SampleCountFlags::_64,
];

/// `VariableRateTestCase::TestParams`, without the construction type and fragment shading rate
#[derive(Clone)]
struct VariableRateParams {
    /// Empty framebuffer or not.
    non_empty_framebuffer: bool,
    /// If not empty, framebuffer sample count.
    fb_count: vk::SampleCountFlags,
    /// If not empty, create unused attachment or not.
    unused_attachment: bool,
    /// Counts for the different subpasses.
    subpass_counts: Vec<vk::SampleCountFlags>,
}

/// `VariableRateTestCase`
struct VariableRateCase {
    name: String,
    params: VariableRateParams,
}

impl TestCase for VariableRateCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `VariableRateTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();

        // When using multiple subpasses, require variableMultisampleRate.
        if self.params.subpass_counts.len() > 1 && features.variable_multisample_rate == vk::FALSE {
            return Err(TestError::NotSupported(
                "Variable multisample rate not supported".to_string(),
            ));
        }

        // Check if sampleRateShading is supported.
        if features.sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "Sample rate shading is not supported".to_string(),
            ));
        }

        // Make sure all subpass sample counts are supported.
        let supported_counts = context
            .get_device_properties()
            .limits
            .framebuffer_no_attachments_sample_counts;
        for &count in &self.params.subpass_counts {
            if !supported_counts.contains(count) {
                return Err(TestError::NotSupported(
                    "Sample count combination not supported".to_string(),
                ));
            }
        }

        if self.params.non_empty_framebuffer {
            // Check the framebuffer sample count is supported.
            let format_properties = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    COLOR_FORMAT,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT,
                    vk::ImageCreateFlags::empty(),
                )
            }
            .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
            if !format_properties.sample_counts.contains(self.params.fb_count) {
                return Err(TestError::NotSupported(format!(
                    "Sample count of {} not supported for color attachment",
                    self.params.fb_count.bits()
                )));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        VARIABLE_RATE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VariableRateInstance {
            context,
            params: &self.params,
        })
    }
}

struct VariableRateInstance<'a> {
    context: &'a Context<'a>,
    params: &'a VariableRateParams,
}

impl TestInstance for VariableRateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        iterate_variable_rate(self.context, self.params)
    }
}

/// `VariableRateTestCase::PushConstants`
#[repr(C)]
#[derive(Clone, Copy)]
struct PushConstants {
    width: i32,
    height: i32,
    samples: i32,
}

fn push_constant_bytes(push_constants: &PushConstants) -> Vec<u8> {
    [push_constants.width, push_constants.height, push_constants.samples]
        .iter()
        .flat_map(|value| value.to_ne_bytes())
        .collect()
}

/// `zeroOutAndFlush`
fn zero_out_and_flush(device: &Device, buffer: &BufferWithMemory<'_>, size: vk::DeviceSize) -> Result<(), TestError> {
    unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, size as usize) };
    flush_alloc(device, buffer.get_allocation())
}

/// A pass over `subpass_count` empty subpasses, the first of which uses a single unused colour attachment reference when `unused_attachment`.
fn create_render_pass<'a>(
    device: &'a Device,
    attachment: Option<&vk::AttachmentDescription>,
    subpass_count: usize,
    unused_attachment: bool,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    // Unused attachment reference.
    let unused_attachment_reference = [vk::AttachmentReference {
        attachment: vk::ATTACHMENT_UNUSED,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];

    let subpass = if unused_attachment {
        // Subpass with unused attachment.
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&unused_attachment_reference)
            .build()
    } else {
        // Subpass with no attachments.
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .build()
    };
    let subpasses = vec![subpass; subpass_count];
    let attachments: Vec<vk::AttachmentDescription> = attachment.copied().into_iter().collect();

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

fn create_framebuffer<'a>(
    device: &'a Device,
    render_pass: vk::RenderPass,
    views: &[vk::ImageView],
) -> Result<Unique<'a, vk::Framebuffer>, TestError> {
    let info = vk::FramebufferCreateInfo::builder()
        .render_pass(render_pass)
        .attachments(views)
        .width(WIDTH)
        .height(HEIGHT)
        .layers(1);
    Ok(Unique::new(
        device,
        unsafe { device.create_framebuffer(&info, None) }.vk_check("vkCreateFramebuffer")?,
    ))
}

/// `VariableRateTestInstance::iterate`
fn iterate_variable_rate<'a>(context: &'a Context<'a>, params: &VariableRateParams) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();

    // Create reference and output buffers.
    let mut reference_buffers = Vec::new();
    let mut output_buffers = Vec::new();
    let mut buffer_sizes = Vec::new();
    for &count in &params.subpass_counts {
        let size = (WIDTH * HEIGHT * count.bits()) as usize * std::mem::size_of::<i32>();
        buffer_sizes.push(size as vk::DeviceSize);
        reference_buffers.push(BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?);
        output_buffers.push(BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?);
    }

    // Descriptor set layout.
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;

    // Pipeline layout.
    let push_constant_range = vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::FRAGMENT,
        offset: 0,
        size: std::mem::size_of::<PushConstants>() as u32,
    };
    let set_layouts = [*descriptor_set_layout];
    let push_constant_ranges = [push_constant_range];
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&push_constant_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &set_layouts, &push_constant_ranges)?;

    // Renderpass with multiple subpasses.
    let render_pass_multiple_passes = create_render_pass(device, None, params.subpass_counts.len(), false)?;

    // Render pass with single subpass.
    let color_attachment_description = vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format: COLOR_FORMAT,
        samples: params.fb_count,
        load_op: vk::AttachmentLoadOp::DONT_CARE,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };
    let unused_attachment_subpass = params.non_empty_framebuffer && params.unused_attachment;
    let render_pass_single_subpass = create_render_pass(
        device,
        if params.non_empty_framebuffer {
            Some(&color_attachment_description)
        } else {
            None
        },
        1,
        unused_attachment_subpass,
    )?;

    // Framebuffer for multiple-subpasses render pass.
    let framebuffer_multiple_passes = create_framebuffer(device, *render_pass_multiple_passes, &[])?;

    // Framebuffer for single-subpass render pass.
    let mut image = None;
    let mut image_view = None;
    let mut views = Vec::new();
    if params.non_empty_framebuffer {
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(params.fb_count)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let created = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let view = make_image_view(
            device,
            created.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        views.push(*view);
        image = Some(created);
        image_view = Some(view);
    }
    let framebuffer_single_subpass = create_framebuffer(device, *render_pass_single_subpass, &views)?;

    // Shader modules.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    // Vertices, input state and assembly.
    let vertices: [[f32; 2]; 3] = [[-0.987, -0.964], [0.982, -0.977], [0.005, 0.891]];

    let pipeline_state = |samples: vk::SampleCountFlags, subpass: u32, color_attachment_count: u32| {
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(WIDTH, HEIGHT);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 2]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        state.samples = samples;
        state.subpass = subpass;
        state.color_attachment_count = color_attachment_count;
        state
    };
    let stages = [
        (vk::ShaderStageFlags::VERTEX, *vert_module),
        (vk::ShaderStageFlags::FRAGMENT, *frag_module),
    ];

    // Graphics pipelines to create output buffers.
    let mut output_pipelines = Vec::new();
    let mut output_states = Vec::new();
    for &samples in &params.subpass_counts {
        let state = pipeline_state(samples, 0, u32::from(unused_attachment_subpass));
        if shader_objects.is_none() {
            output_pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass_single_subpass,
                &stages,
                &state,
            )?);
        }
        output_states.push(state);
    }

    // Graphics pipelines with variable rate but using several subpasses.
    let mut reference_pipelines = Vec::new();
    let mut reference_states = Vec::new();
    for (i, &samples) in params.subpass_counts.iter().enumerate() {
        let state = pipeline_state(samples, i as u32, 0);
        if shader_objects.is_none() {
            reference_pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass_multiple_passes,
                &stages,
                &state,
            )?);
        }
        reference_states.push(state);
    }

    // Prepare vertex, reference and output buffers.
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    for i in 0..reference_buffers.len() {
        zero_out_and_flush(device, &reference_buffers[i], buffer_sizes[i])?;
        zero_out_and_flush(device, &output_buffers[i], buffer_sizes[i])?;
    }

    // Prepare descriptor sets.
    let total_sets = (reference_buffers.len() * 2) as u32;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, total_sets)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, total_sets)?;

    let mut reference_sets = Vec::new();
    let mut output_sets = Vec::new();
    for _ in 0..reference_buffers.len() {
        reference_sets.push(make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?);
    }
    for _ in 0..output_buffers.len() {
        output_sets.push(make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?);
    }

    let mut update_builder = DescriptorSetUpdateBuilder::new();
    for (i, set) in reference_sets.iter().enumerate() {
        let descriptor_buffer_info = vk::DescriptorBufferInfo {
            buffer: reference_buffers[i].get(),
            offset: 0,
            range: buffer_sizes[i],
        };
        update_builder = update_builder.write_single(
            set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &descriptor_buffer_info,
        );
    }
    for (i, set) in output_sets.iter().enumerate() {
        let descriptor_buffer_info = vk::DescriptorBufferInfo {
            buffer: output_buffers[i].get(),
            offset: 0,
            range: buffer_sizes[i],
        };
        update_builder = update_builder.write_single(
            set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &descriptor_buffer_info,
        );
    }
    update_builder.update(device);

    // Prepare command pool.
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let storage_buffer_dev_to_host_barrier = |buffer: vk::Buffer| vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: vk::AccessFlags::SHADER_WRITE,
        dst_access_mask: vk::AccessFlags::HOST_READ,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset: 0,
        size: vk::WHOLE_SIZE,
    };

    // Record command buffer.
    let render_area = rect_2d(WIDTH, HEIGHT);
    let mut push_constants = PushConstants {
        width: WIDTH as i32,
        height: HEIGHT as i32,
        samples: 0,
    };

    begin_command_buffer(device, cmd)?;

    let begin_info = |render_pass: vk::RenderPass, framebuffer: vk::Framebuffer| {
        vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(render_area)
            .build()
    };
    let barrier_buffers = |buffers: &[BufferWithMemory<'_>]| {
        for buffer in buffers {
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[storage_buffer_dev_to_host_barrier(buffer.get())],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
    };

    // Every subpass of the render passes has no attachments (or the one unused attachment reference), so shader objects draw each
    // in a rendering of its own.
    let begin_rendering = |unused_attachment: bool| {
        let unused = [vk::RenderingAttachmentInfo::builder()
            .image_view(vk::ImageView::null())
            .image_layout(vk::ImageLayout::UNDEFINED)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .build()];
        let colors: &[vk::RenderingAttachmentInfo] = if unused_attachment { &unused } else { &[] };
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(render_area)
            .layer_count(1)
            .color_attachments(colors);
        unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
    };
    let draw = |set: vk::DescriptorSet, push_constants: &PushConstants| unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[set],
            &[] as &[u32],
        );
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_push_constants(
            cmd,
            *pipeline_layout,
            push_constant_range.stage_flags,
            push_constant_range.offset,
            &push_constant_bytes(push_constants),
        );
        device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
    };

    // Render output buffers.
    if let Some(shader_objects) = &shader_objects {
        for i in 0..output_buffers.len() {
            push_constants.samples = params.subpass_counts[i].bits() as i32;
            begin_rendering(unused_attachment_subpass);
            shader_objects.bind(cmd, &output_states[i]);
            draw(output_sets[i].get(), &push_constants);
            end_dynamic_rendering(device, cmd);
        }
    } else {
        unsafe {
            device.cmd_begin_render_pass(
                cmd,
                &begin_info(*render_pass_single_subpass, *framebuffer_single_subpass),
                vk::SubpassContents::INLINE,
            )
        };
        for i in 0..output_buffers.len() {
            push_constants.samples = params.subpass_counts[i].bits() as i32;
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *output_pipelines[i]) };
            draw(output_sets[i].get(), &push_constants);
        }
        unsafe { device.cmd_end_render_pass(cmd) };
    }
    barrier_buffers(&output_buffers);

    // Render reference buffers.
    if let Some(shader_objects) = &shader_objects {
        for i in 0..reference_buffers.len() {
            push_constants.samples = params.subpass_counts[i].bits() as i32;
            begin_rendering(false);
            shader_objects.bind(cmd, &reference_states[i]);
            draw(reference_sets[i].get(), &push_constants);
            end_dynamic_rendering(device, cmd);
        }
    } else {
        unsafe {
            device.cmd_begin_render_pass(
                cmd,
                &begin_info(*render_pass_multiple_passes, *framebuffer_multiple_passes),
                vk::SubpassContents::INLINE,
            )
        };
        for i in 0..reference_buffers.len() {
            if i > 0 {
                unsafe { device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE) };
            }
            push_constants.samples = params.subpass_counts[i].bits() as i32;
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *reference_pipelines[i]) };
            draw(reference_sets[i].get(), &push_constants);
        }
        unsafe { device.cmd_end_render_pass(cmd) };
    }
    barrier_buffers(&reference_buffers);

    end_command_buffer(device, cmd)?;

    // Run all pipelines.
    submit_commands_and_wait(device, queue, cmd)?;

    // Invalidate reference allocs.
    for buffer in &reference_buffers {
        invalidate_alloc(device, buffer.get_allocation())?;
    }

    for (i, buffer) in output_buffers.iter().enumerate() {
        invalidate_alloc(device, buffer.get_allocation())?;

        let size = buffer_sizes[i] as usize;
        let output = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), size) };
        let reference = unsafe {
            std::slice::from_raw_parts(reference_buffers[i].get_allocation().get_host_ptr().cast_const(), size)
        };
        if output != reference {
            return Ok(TestStatus::fail(format!("Buffer mismatch in output buffer {i}")));
        }
    }

    drop((image, image_view));
    Ok(TestStatus::pass("Pass"))
}

/// `combinations`: every sequence of `requested_size` elements.
fn combinations(elements: &[vk::SampleCountFlags], requested_size: usize) -> Vec<Vec<vk::SampleCountFlags>> {
    fn recursive(
        elements: &[vk::SampleCountFlags],
        requested_size: usize,
        solutions: &mut Vec<Vec<vk::SampleCountFlags>>,
        partial: &mut Vec<vk::SampleCountFlags>,
    ) {
        if partial.len() == requested_size {
            solutions.push(partial.clone());
        } else {
            for &elem in elements {
                partial.push(elem);
                recursive(elements, requested_size, solutions, partial);
                partial.pop();
            }
        }
    }

    let mut solutions = Vec::new();
    recursive(elements, requested_size, &mut solutions, &mut Vec::new());
    solutions
}

/// Check sample counts actually vary between some of the subpasses.
fn has_varying_counts(counts: &[vk::SampleCountFlags]) -> bool {
    counts.iter().any(|count| *count != counts[0])
}

fn join_counts(counts: &[vk::SampleCountFlags]) -> String {
    counts
        .iter()
        .map(|count| count.bits().to_string())
        .collect::<Vec<_>>()
        .join("_")
}

fn add_case(group: &mut TestCaseGroup, name: String, params: VariableRateParams) {
    group.add_child(Box::new(VariableRateCase { name, params }) as Box<dyn TestCase>);
}

/// The `variable_rate` and `mixed_count` children of upstream's `multisample` group (monolithic, without fragment shading rate).
pub(super) fn add_variable_rate_tests(multisample_tests: &mut TestCaseGroup) {
    let unused_attachment_flags = [false, true];

    // Tests for multisample variable rate in subpasses
    {
        let mut variable_rate_group = TestCaseGroup::new("variable_rate");

        // 2 and 3 subpasses should be good enough.
        // Basic cases.
        for size in [2usize, 3] {
            for comb in combinations(&SAMPLE_COUNTS, size) {
                if !has_varying_counts(&comb) {
                    continue;
                }

                let params = VariableRateParams {
                    non_empty_framebuffer: false,
                    fb_count: vk::SampleCountFlags::_1,
                    unused_attachment: false,
                    subpass_counts: comb.clone(),
                };
                add_case(&mut variable_rate_group, join_counts(&comb), params);
            }
        }

        // Cases with non-empty framebuffers: only 2 subpasses to avoid a large number of combinations.
        // Use one more sample count for the framebuffer attachment. It will be taken from the last item.
        for mut comb in combinations(&SAMPLE_COUNTS, 2 + 1) {
            // Framebuffer sample count.
            let fb_count = comb.pop().expect("a framebuffer count");

            if !has_varying_counts(&comb) {
                continue;
            }

            for flag in unused_attachment_flags {
                let mut name = format!("{}_fb_{}", join_counts(&comb), fb_count.bits());
                if flag {
                    name += "_unused";
                }

                let params = VariableRateParams {
                    non_empty_framebuffer: true,
                    fb_count,
                    unused_attachment: flag,
                    subpass_counts: comb.clone(),
                };
                add_case(&mut variable_rate_group, name, params);
            }
        }

        multisample_tests.add_child(variable_rate_group);
    }

    // Tests for mixed sample count in empty subpass and framebuffer
    {
        let mut mixed_count_group = TestCaseGroup::new("mixed_count");

        for comb in combinations(&SAMPLE_COUNTS, 2) {
            // Check different sample count.
            let (fb_count, empty_count) = (comb[0], comb[1]);

            if fb_count == empty_count {
                continue;
            }

            for flag in unused_attachment_flags {
                let name_suffix = if flag { "unused" } else { "" };
                let name = format!(
                    "{}_{}{}{}",
                    fb_count.bits(),
                    empty_count.bits(),
                    if name_suffix.is_empty() { "" } else { "_" },
                    name_suffix
                );

                let params = VariableRateParams {
                    non_empty_framebuffer: true,
                    fb_count,
                    unused_attachment: flag,
                    subpass_counts: vec![empty_count],
                };
                add_case(&mut mixed_count_group, name, params);
            }
        }

        multisample_tests.add_child(mixed_count_group);
    }
}
