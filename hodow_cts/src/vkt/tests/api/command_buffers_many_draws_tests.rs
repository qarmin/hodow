// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp (`ManyDrawsCase`, `ManyDrawsInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/api_command_buffers.toml. The mismatch images upstream logs are not.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::api_command_buffers::MANY_DRAWS;
use crate::tcu::random::Random;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UINT;

#[repr(C)]
#[derive(Clone, Copy)]
struct ManyDrawsVertex {
    coords: [f32; 2],
    color: [u8; 4],
}

#[derive(Clone, Copy)]
struct ManyDrawsParams {
    level: vk::CommandBufferLevel,
    width: u32,
    height: u32,
    seed: u32,
}

/// `getSupportedDepthStencilFormat`
fn get_supported_depth_stencil_format(context: &Context<'_>) -> Result<vk::Format, TestError> {
    let requirements = vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
    for format in [vk::Format::D24_UNORM_S8_UINT, vk::Format::D32_SFLOAT_S8_UINT] {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties.optimal_tiling_features.contains(requirements) {
            return Ok(format);
        }
    }
    Err(TestError::NotSupported(
        "No suitable depth/stencil format support".to_string(),
    ))
}

struct VertexBuffers<'a> {
    staging: BufferWithMemory<'a>,
    vertex: BufferWithMemory<'a>,
}

/// `ManyDrawsAllocatedData`
struct AllocatedData<'a> {
    front: VertexBuffers<'a>,
    back: VertexBuffers<'a>,
    color_attachment: ImageWithMemory<'a>,
    ds_attachment: ImageWithMemory<'a>,
    color_check_buffer: BufferWithMemory<'a>,
    stencil_check_buffer: BufferWithMemory<'a>,
}

impl<'a> AllocatedData<'a> {
    fn num_pixels(params: &ManyDrawsParams) -> u32 {
        params.width * params.height
    }

    fn num_vertices(params: &ManyDrawsParams) -> u32 {
        Self::num_pixels(params) * 3
    }

    fn vertex_buffer_size(params: &ManyDrawsParams) -> u64 {
        u64::from(Self::num_vertices(params)) * std::mem::size_of::<ManyDrawsVertex>() as u64
    }

    fn make_vertex_buffers(context: &'a Context<'a>, size: u64) -> Result<VertexBuffers<'a>, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        Ok(VertexBuffers {
            staging: BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_SRC),
                MemoryRequirement::HOST_VISIBLE,
            )?,
            vertex: BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    size,
                    vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::VERTEX_BUFFER,
                ),
                MemoryRequirement::ANY,
            )?,
        })
    }

    fn new(context: &'a Context<'a>, params: &ManyDrawsParams, ds_format: vk::Format) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let num_pixels = u64::from(Self::num_pixels(params));
        let vertex_buffer_size = Self::vertex_buffer_size(params);
        let size = IVec2::new(params.width as i32, params.height as i32);

        let front = Self::make_vertex_buffers(context, vertex_buffer_size)?;
        let back = Self::make_vertex_buffers(context, vertex_buffer_size)?;
        let color_attachment = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let ds_attachment = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
                ds_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_check_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(num_pixels * 4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let stencil_check_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(num_pixels, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        Ok(Self {
            front,
            back,
            color_attachment,
            ds_attachment,
            color_check_buffer,
            stencil_check_buffer,
        })
    }
}

fn copy_and_flush(
    device: &Device,
    buffer: &BufferWithMemory<'_>,
    vertices: &[ManyDrawsVertex],
) -> Result<(), TestError> {
    let allocation = buffer.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            vertices.as_ptr() as *const u8,
            allocation.get_host_ptr(),
            std::mem::size_of_val(vertices),
        )
    };
    flush_alloc(device, allocation)
}

/// `makeRenderPass(vkd, device, colorFormat, dsFormat)`
fn make_color_ds_render_pass(device: &Device, ds_format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: COLOR_FORMAT,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        },
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: ds_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::CLEAR,
            stencil_store_op: vk::AttachmentStoreOp::STORE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        },
    ];
    let color_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let ds_reference = vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_reference)
        .depth_stencil_attachment(&ds_reference)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

fn run(context: &Context<'_>, params: ManyDrawsParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let q_index = context.get_universal_queue_family_index();

    let ds_format = get_supported_depth_stencil_format(context)?;
    let vertex_buffer_size = AllocatedData::vertex_buffer_size(&params);
    let num_pixels = AllocatedData::num_pixels(&params);
    let num_vertices = AllocatedData::num_vertices(&params);
    let alpha_value = u8::MAX;
    let pixel_width = 2.0 / params.width as f32;
    let pixel_width_half = pixel_width / 2.0;
    let pixel_height = 2.0 / params.height as f32;
    let use_secondary = params.level == vk::CommandBufferLevel::SECONDARY;

    let test_data = AllocatedData::new(context, &params, ds_format)?;

    let mut rnd = Random::new(params.seed);
    let colors: Vec<[u8; 4]> = (0..num_pixels)
        .map(|_| [rnd.get_uint8(), rnd.get_uint8(), rnd.get_uint8(), alpha_value])
        .collect();

    // One triangle per pixel, front and back; the back ones use the colours in reverse order.
    let mut front_vector = Vec::with_capacity(num_vertices as usize);
    let mut back_vector = Vec::with_capacity(num_vertices as usize);
    for y in 0..params.height {
        for x in 0..params.width {
            let x_left = x as f32 * pixel_width - 1.0;
            let x_mid = x_left + pixel_width_half;
            let x_right = x_left + pixel_width;
            let y_top = y as f32 * pixel_height - 1.0;
            let y_bottom = y_top + pixel_height;

            let color_idx = (y * params.width + x) as usize;
            let front_color = colors[color_idx];
            let back_color = colors[colors.len() - 1 - color_idx];
            let triangle = [[x_left, y_top], [x_right, y_top], [x_mid, y_bottom]];
            for coords in triangle {
                front_vector.push(ManyDrawsVertex {
                    coords,
                    color: front_color,
                });
                back_vector.push(ManyDrawsVertex {
                    coords,
                    color: back_color,
                });
            }
        }
    }
    copy_and_flush(device, &test_data.front.staging, &front_vector)?;
    copy_and_flush(device, &test_data.back.staging, &back_vector)?;

    let color_resource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_attachment_view = make_image_view(
        device,
        test_data.color_attachment.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_resource_range,
    )?;
    let ds_resource_range =
        make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
    let ds_attachment_view = make_image_view(
        device,
        test_data.ds_attachment.get(),
        vk::ImageViewType::_2D,
        ds_format,
        ds_resource_range,
    )?;

    let render_pass = make_color_ds_render_pass(device, ds_format)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_attachment_view, *ds_attachment_view],
        params.width,
        params.height,
        1,
    )?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<ManyDrawsVertex>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let attributes = [
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: std::mem::offset_of!(ManyDrawsVertex, coords) as u32,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R8G8B8A8_UINT,
            offset: std::mem::offset_of!(ManyDrawsVertex, color) as u32,
        },
    ];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);

    // The stencil buffer starts at 0: the front draws pass the test and increment it to 1, the back draws fail it and still increment it to 2.
    let stencil_op_state = vk::StencilOpState {
        fail_op: vk::StencilOp::INCREMENT_AND_CLAMP,
        pass_op: vk::StencilOp::INCREMENT_AND_CLAMP,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::EQUAL,
        compare_mask: 0xff,
        write_mask: 0xff,
        reference: 0,
    };
    let ds_state = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::NEVER)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(true)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(*vert_module)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(*frag_module)
            .name(b"main\0")
            .build(),
    ];
    let input_assembly =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: params.width as f32,
        height: params.height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, params.width, params.height)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachments);
    let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&ds_state)
        .color_blend_state(&color_blend)
        .layout(*pipeline_layout)
        .render_pass(*render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipeline = crate::vk::pipeline_construction::create_graphics_pipeline(device, &pipeline_info)?;

    let cmd_pool = make_command_pool(device, q_index)?;
    let sec_cmd_pool = make_command_pool(device, q_index)?;
    let primary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let primary = *primary_cmd_buffer;
    let begin_info = vk::CommandBufferBeginInfo::builder();
    unsafe { device.begin_command_buffer(primary, &begin_info) }.vk_check("vkBeginCommandBuffer")?;

    let clear_values = [
        vk::ClearValue {
            color: vk::ClearColorValue { uint32: [0, 0, 0, 0] },
        },
        vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
        },
    ];

    // Copy the staging buffers to the vertex buffers, then change the depth/stencil layout.
    let copy_region = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: vertex_buffer_size,
    };
    let vertex_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::VERTEX_ATTRIBUTE_READ);
    let ds_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        test_data.ds_attachment.get(),
        ds_resource_range,
    );
    unsafe {
        device.cmd_copy_buffer(
            primary,
            test_data.front.staging.get(),
            test_data.front.vertex.get(),
            &[copy_region],
        );
        device.cmd_copy_buffer(
            primary,
            test_data.back.staging.get(),
            test_data.back.vertex.get(),
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            primary,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::VERTEX_INPUT,
            vk::DependencyFlags::empty(),
            &[vertex_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        device.cmd_pipeline_barrier(
            primary,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[ds_barrier],
        );
    }
    let render_pass_begin = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(scissors[0])
        .clear_values(&clear_values);
    let contents = if use_secondary {
        vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
    } else {
        vk::SubpassContents::INLINE
    };
    unsafe { device.cmd_begin_render_pass(primary, &render_pass_begin, contents) };

    let secondary_cmd_buffer;
    let draws_cmd_buffer = if use_secondary {
        secondary_cmd_buffer = allocate_command_buffer(device, *sec_cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
            .render_pass(*render_pass)
            .subpass(0)
            .framebuffer(*framebuffer);
        let secondary_begin = vk::CommandBufferBeginInfo::builder()
            .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE | vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
            .inheritance_info(&inheritance_info);
        unsafe { device.begin_command_buffer(*secondary_cmd_buffer, &secondary_begin) }
            .vk_check("vkBeginCommandBuffer")?;
        *secondary_cmd_buffer
    } else {
        primary
    };

    unsafe {
        device.cmd_bind_pipeline(draws_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        // Triangles in front.
        device.cmd_bind_vertex_buffers(draws_cmd_buffer, 0, &[test_data.front.vertex.get()], &[0]);
        for i in 0..num_pixels {
            device.cmd_draw(draws_cmd_buffer, 3, 1, i * 3, 0);
        }
        // Triangles in the "back": no effect, because of the stencil test.
        device.cmd_bind_vertex_buffers(draws_cmd_buffer, 0, &[test_data.back.vertex.get()], &[0]);
        for i in 0..num_pixels {
            device.cmd_draw(draws_cmd_buffer, 3, 1, i * 3, 0);
        }
    }
    if use_secondary {
        end_command_buffer(device, draws_cmd_buffer)?;
        unsafe { device.cmd_execute_commands(primary, &[draws_cmd_buffer]) };
    }
    unsafe { device.cmd_end_render_pass(primary) };

    // Copy the colour and stencil aspects to the verification buffers.
    let extent = vk::Extent3D {
        width: params.width,
        height: params.height,
        depth: 1,
    };
    let color_attachment_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        test_data.color_attachment.get(),
        color_resource_range,
    );
    let color_copy_region = make_buffer_image_copy(
        extent,
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let stencil_attachment_barrier = make_image_memory_barrier(
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        test_data.ds_attachment.get(),
        ds_resource_range,
    );
    let stencil_copy_region = make_buffer_image_copy(
        extent,
        make_image_subresource_layers(vk::ImageAspectFlags::STENCIL, 0, 0, 1),
    );
    let verification_buffers_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            primary,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[color_attachment_barrier],
        );
        device.cmd_copy_image_to_buffer(
            primary,
            test_data.color_attachment.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            test_data.color_check_buffer.get(),
            &[color_copy_region],
        );
        device.cmd_pipeline_barrier(
            primary,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[stencil_attachment_barrier],
        );
        device.cmd_copy_image_to_buffer(
            primary,
            test_data.ds_attachment.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            test_data.stencil_check_buffer.get(),
            &[stencil_copy_region],
        );
        device.cmd_pipeline_barrier(
            primary,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[verification_buffers_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, primary)?;
    submit_commands_and_wait(device, queue, primary)?;

    invalidate_alloc(device, test_data.color_check_buffer.get_allocation())?;
    invalidate_alloc(device, test_data.stencil_check_buffer.get_allocation())?;
    let color_data = unsafe {
        std::slice::from_raw_parts(
            test_data.color_check_buffer.get_allocation().get_host_ptr() as *const u8,
            num_pixels as usize * 4,
        )
    };
    let stencil_data = unsafe {
        std::slice::from_raw_parts(
            test_data.stencil_check_buffer.get_allocation().get_host_ptr() as *const u8,
            num_pixels as usize,
        )
    };

    let expected_stencil = 2u8;
    let mut color_fail = false;
    let mut stencil_fail = false;
    for i in 0..num_pixels as usize {
        if color_data[i * 4..i * 4 + 4] != colors[i] {
            color_fail = true;
        }
        if stencil_data[i] != expected_stencil {
            stencil_fail = true;
        }
    }
    if color_fail || stencil_fail {
        return Ok(TestStatus::fail(
            "Mismatched output and reference color or stencil; please check test log --",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

struct ManyDrawsCase {
    name: &'static str,
    params: ManyDrawsParams,
}

impl TestCase for ManyDrawsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let ds_format = get_supported_depth_stencil_format(context)?;
        match AllocatedData::new(context, &self.params, ds_format) {
            Ok(_) => Ok(()),
            Err(TestError::OutOfHostMemory(_) | TestError::ResourceError(_)) => Err(TestError::NotSupported(
                "Not enough memory to run this test".to_string(),
            )),
            Err(error) => Err(error),
        }
    }

    fn programs(&self) -> BinaryCollection {
        MANY_DRAWS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ManyDrawsInstance {
            context,
            params: self.params,
        })
    }
}

struct ManyDrawsInstance<'a> {
    context: &'a Context<'a>,
    params: ManyDrawsParams,
}

impl TestInstance for ManyDrawsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run(self.context, self.params)
    }
}

/// The `record_many_draws_*` cases of `createCommandBuffersTests`.
pub fn add_many_draws_tests(group: &mut TestCaseGroup) {
    let mut seed = 1_614_182_419u32;
    let mut next_seed = || {
        let value = seed;
        seed += 1;
        value
    };
    for (name, level, width, height) in [
        ("record_many_draws_primary_1", vk::CommandBufferLevel::PRIMARY, 128, 128),
        (
            "record_many_draws_secondary_1",
            vk::CommandBufferLevel::SECONDARY,
            128,
            128,
        ),
        ("record_many_draws_primary_2", vk::CommandBufferLevel::PRIMARY, 512, 256),
        (
            "record_many_draws_secondary_2",
            vk::CommandBufferLevel::SECONDARY,
            512,
            256,
        ),
    ] {
        group.add_child(Box::new(ManyDrawsCase {
            name,
            params: ManyDrawsParams {
                level,
                width,
                height,
                seed: next_seed(),
            },
        }) as Box<dyn TestCase>);
    }
}
