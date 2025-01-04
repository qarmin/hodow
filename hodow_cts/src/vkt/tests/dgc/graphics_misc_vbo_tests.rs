// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_misc.toml`
// (`scripts/gen_dgc_graphics_misc_manifest.py`, case `vbo_update`). The pipeline has four vertex bindings with dynamic strides, so it is
// not made by `build_draw_pipeline`.
//
// Here: `vbo_update_*` of `dgc.ext.graphics.misc` (VBOUpdateInstance): four 2x2 sequences, each of which rebinds the vertex buffers of
// the varying bindings (position, red, green, blue) with a vertex buffer token and draws a triangle strip over one pixel.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtExtendedDynamicStateExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_graphics_misc::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout_with_push_constants, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{copy_image_to_buffer, float_threshold_compare, push_back_element};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt, check_dgc_ext_support,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const BINDING_COUNT: usize = 4;
const POSITION: usize = 0;
const RED_COLOR: usize = 1;
const GREEN_COLOR: usize = 2;
const BLUE_COLOR: usize = 3;
const MIN_PADDING_ITEMS: i32 = 0;
const MAX_PADDING_ITEMS: i32 = 3;

#[derive(Clone, Copy)]
struct Params {
    vary_binding: [bool; BINDING_COUNT],
}

impl Params {
    fn seed(&self) -> u32 {
        1234000
            | (u32::from(self.vary_binding[POSITION]) << 3)
            | (u32::from(self.vary_binding[RED_COLOR]) << 2)
            | (u32::from(self.vary_binding[GREEN_COLOR]) << 1)
            | u32::from(self.vary_binding[BLUE_COLOR])
    }

    fn variation_string(&self) -> String {
        self.vary_binding
            .iter()
            .map(|&vary| if vary { '1' } else { '0' })
            .collect()
    }
}

struct VboUpdateCase {
    name: String,
    params: Params,
}

impl TestCase for VboUpdateCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        check_dgc_ext_support(
            context,
            shader_stages,
            vk::ShaderStageFlags::empty(),
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        // For the dynamic stride (core in 1.3).
        if context.api_version() >= (1, 3, 0) {
            return Ok(());
        }
        context.require_device_functionality("VK_EXT_extended_dynamic_state")
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "vbo_update")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VboUpdateInstance {
            context,
            params: self.params,
        })
    }
}

struct VboUpdateInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

struct BufferInfo<'a> {
    buffer: BufferWithMemory<'a>,
    size: u32,
    stride: u32,
}

/// A zeroed vertex buffer (with device address) holding `items` at `stride` byte intervals.
fn make_strided_buffer<'a>(
    context: &'a Context<'a>,
    rnd: &mut Random,
    item_bytes: &[Vec<u8>],
) -> Result<BufferInfo<'a>, TestError> {
    let device = context.get_device();
    let item_size = item_bytes[0].len() as u32;
    let data_size = item_size * item_bytes.len() as u32;
    let padding_items = rnd.get_int(MIN_PADDING_ITEMS, MAX_PADDING_ITEMS) as u32; // Per vertex.
    let total_items = padding_items + 1; // Per vertex.
    let size = total_items * data_size;
    let stride = size / item_bytes.len() as u32;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            vk::DeviceSize::from(size),
            vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer holds `size` bytes, and every item ends before `size`.
        unsafe {
            let data_ptr = alloc.get_host_ptr();
            std::ptr::write_bytes(data_ptr, 0, size as usize);
            for (j, item) in item_bytes.iter().enumerate() {
                std::ptr::copy_nonoverlapping(item.as_ptr(), data_ptr.add(stride as usize * j), item.len());
            }
        }
        flush_alloc(device, alloc)?;
    }
    Ok(BufferInfo { buffer, size, stride })
}

fn vec4_bytes(value: &Vec4) -> Vec<u8> {
    value.iter().flat_map(|component| component.to_ne_bytes()).collect()
}

/// `vkCmdBindVertexBuffers2` for one binding, from core 1.3 or VK_EXT_extended_dynamic_state.
fn bind_vertex_buffers2(
    context: &Context<'_>,
    cmd_buffer: vk::CommandBuffer,
    first_binding: u32,
    buffer: vk::Buffer,
    size: vk::DeviceSize,
    stride: vk::DeviceSize,
) {
    let device = context.get_device();
    let (major, minor, _) = context.api_version();
    unsafe {
        if (major, minor) >= (1, 3) {
            device.cmd_bind_vertex_buffers2(cmd_buffer, first_binding, &[buffer], &[0], &[size], &[stride]);
        } else {
            ExtExtendedDynamicStateExtensionDeviceCommands::cmd_bind_vertex_buffers2_ext(
                device,
                cmd_buffer,
                first_binding,
                &[buffer],
                &[0],
                &[size],
                &[stride],
            );
        }
    }
}

fn make_vbo_update_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    extent: u32,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vert)
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(frag)
            .name(entry.to_bytes_with_nul())
            .build(),
    ];

    // Note strides will be dynamic.
    let binding_sizes = [16u32, 4, 4, 4];
    let bindings: Vec<vk::VertexInputBindingDescription> = binding_sizes
        .iter()
        .enumerate()
        .map(|(binding, &stride)| {
            vk::VertexInputBindingDescription::builder()
                .binding(binding as u32)
                .stride(stride)
                .input_rate(vk::VertexInputRate::VERTEX)
                .build()
        })
        .collect();
    let attributes: Vec<vk::VertexInputAttributeDescription> = (0..BINDING_COUNT as u32)
        .map(|location| {
            vk::VertexInputAttributeDescription::builder()
                .location(location)
                .binding(location)
                .format(if location == 0 {
                    vk::Format::R32G32B32A32_SFLOAT
                } else {
                    vk::Format::R32_SFLOAT
                })
                .offset(0)
                .build()
        })
        .collect();
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: extent as f32,
        height: extent as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, extent, extent)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
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
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(
            vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A,
        )
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .attachments(&blend_attachments)
        .blend_constants([0.0; 4]);
    let dynamic_states = [vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE];
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .dynamic_state(&dynamic_state)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0)
        .build();
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

impl TestInstance for VboUpdateInstance<'_> {
    /// `VBOUpdateInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = 2u32;
        let pixel_count = fb_extent * fb_extent;
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let clear_color: Vec4 = [0.0; 4];

        // General triangle strip. Offsets will be used with it so it covers the 4 framebuffer pixels.
        let vertices: [Vec4; 4] = [
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];

        // Offsets to move the strip around and cover different pixels.
        let strip_offsets: [Vec4; 4] = [
            [-1.0, -1.0, 0.0, 0.0],
            [0.0, -1.0, 0.0, 0.0],
            [-1.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
        ];

        // Color values for each vertex in each sequence (pixel).
        let color_values: [[f32; 4]; 4] = [
            [0.00, 0.00, 0.00, 0.00],
            [0.50, 0.50, 0.50, 0.50],
            [0.75, 0.75, 0.75, 0.75],
            [1.00, 1.00, 1.00, 1.00],
        ];

        let mut rnd = Random::new(params.seed());

        let mut all_buffers: Vec<Vec<BufferInfo<'_>>> = Vec::new();
        {
            let mut position_buffers = Vec::new();
            for offset in &strip_offsets {
                // Create the actual vertices for the strip in each pixel by applying an offset to each position.
                let items: Vec<Vec<u8>> = vertices
                    .iter()
                    .map(|vertex| {
                        let moved: Vec4 = [
                            vertex[0] + offset[0],
                            vertex[1] + offset[1],
                            vertex[2] + offset[2],
                            vertex[3] + offset[3],
                        ];
                        vec4_bytes(&moved)
                    })
                    .collect();
                position_buffers.push(make_strided_buffer(context, &mut rnd, &items)?);
            }
            all_buffers.push(position_buffers);
        }
        for _color in 0..3 {
            let mut color_buffers = Vec::new();
            for vertex_values in &color_values {
                let items: Vec<Vec<u8>> = vertex_values.iter().map(|value| value.to_ne_bytes().to_vec()).collect();
                color_buffers.push(make_strided_buffer(context, &mut rnd, &items)?);
            }
            all_buffers.push(color_buffers);
        }

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;

        // Commands layout.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stages,
            *pipeline_layout,
        );
        for idx in 0..BINDING_COUNT {
            if params.vary_binding[idx] {
                let offset = cmds_layout_builder.get_stream_range();
                cmds_layout_builder.add_vertex_buffer_token(offset, idx as u32);
            }
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC data.
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..pixel_count as usize {
            for idx in 0..BINDING_COUNT {
                if params.vary_binding[idx] {
                    let buffer = &all_buffers[idx][i];
                    let cmd = vk::BindVertexBufferIndirectCommandEXT {
                        buffer_address: buffer_device_address(device, buffer.buffer.get()),
                        size: buffer.size,
                        stride: buffer.stride,
                    };
                    push_back_element(&mut dgc_data, &cmd);
                }
            }
            let draw_cmd = vk::DrawIndirectCommand {
                vertex_count: vertices.len() as u32,
                instance_count: 1,
                first_vertex: 0,
                first_instance: 0,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Framebuffer.
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        // Create pipeline.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = make_vbo_update_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            fb_extent,
        )?;

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            pixel_count,
            0,
            *pipeline,
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent, fb_extent),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
        );
        for idx in 0..BINDING_COUNT {
            if !params.vary_binding[idx] {
                // This input doesn't change: we bind the first buffer.
                let vtx_buffer = &all_buffers[idx][0];
                bind_vertex_buffers2(
                    context,
                    cmd_buffer,
                    idx as u32,
                    vtx_buffer.buffer.get(),
                    vk::DeviceSize::from(vtx_buffer.size),
                    vk::DeviceSize::from(vtx_buffer.stride),
                );
            }
        }
        unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline) };
        {
            let cmds_info = DgcGenCmdsInfo::new(
                shader_stages,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                pixel_count,
                0,
                0,
                *pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent,
            fb_extent,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let result = color_buffer.read_bytes(device)?;

        let mut reference = vec![clear_color; pixel_count as usize];
        for y in 0..fb_extent {
            for x in 0..fb_extent {
                let pixel_idx = (y * fb_extent + x) as usize;
                let vary_position = params.vary_binding[POSITION];

                if pixel_idx > 0 && !vary_position {
                    // We will not draw over this pixel if the triangle strip doesn't move.
                    continue;
                }

                // If a component doesn't vary, we always get the first color value for it.
                // If it varies and the triangle strip moves, each pixel gets its own color according to the pixel index.
                // If it varies and the triangle strip doesn't move, the colored pixel gets the last color value used.
                let varying_color_idx = if vary_position {
                    pixel_idx
                } else {
                    pixel_count as usize - 1
                };
                let component = |binding: usize| {
                    if params.vary_binding[binding] {
                        color_values[varying_color_idx][0]
                    } else {
                        color_values[0][0]
                    }
                };
                reference[pixel_idx] = [component(RED_COLOR), component(GREEN_COLOR), component(BLUE_COLOR), 1.0];
            }
        }

        let color_threshold = 0.005f32; // 1/255 < 0.005 < 2/255
        if !float_threshold_compare(
            result,
            &reference,
            [color_threshold, color_threshold, color_threshold, 0.0],
        ) {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `vbo_update_*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_vbo_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut all_params: Vec<Params> = Vec::new();
    for idx in 0..BINDING_COUNT {
        let mut params = Params {
            vary_binding: [false; BINDING_COUNT],
        };
        params.vary_binding[idx] = true;
        all_params.push(params);
    }
    all_params.push(Params {
        vary_binding: [true; BINDING_COUNT],
    });

    all_params
        .into_iter()
        .map(|params| {
            let name = format!("vbo_update_{}", params.variation_string());
            (
                format!("ext.graphics.misc.{name}"),
                Box::new(VboUpdateCase { name, params }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
