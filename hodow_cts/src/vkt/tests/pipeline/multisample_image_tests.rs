// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleImageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only: upstream's derived pipelines (one per layer,
// `ALLOW_DERIVATIVES` / `DERIVATIVE_BIT`) are created independently here. The images and log sections of upstream are not
// produced.
//
// Ported groups of `multisample`: `sampled_image`, `3d`, `storage_image`, `standardsampleposition` and `samples_mapping_order`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_multisample_image::ALL_SHARED_PROGRAM;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::pipeline_util::Vertex4Rgba;
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_draw, begin_dynamic_rendering, end_draw, end_dynamic_rendering, make_shader_objects,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SAMPLE_COUNTS: [vk::SampleCountFlags; 6] = [
    vk::SampleCountFlags::_2,
    vk::SampleCountFlags::_4,
    vk::SampleCountFlags::_8,
    vk::SampleCountFlags::_16,
    vk::SampleCountFlags::_32,
    vk::SampleCountFlags::_64,
];

fn num_samples_of(samples: vk::SampleCountFlags) -> u32 {
    samples.bits()
}

/// What the tests need to know about their four colour formats.
#[derive(Clone, Copy)]
struct FormatInfo {
    #[allow(dead_code)]
    components: u32,
    is_uint: bool,
    is_sint: bool,
    pixel_size: u32,
    /// `getFormatString`
    name: &'static str,
}

fn format_info(format: vk::Format) -> FormatInfo {
    match format {
        vk::Format::R8G8B8A8_UNORM => FormatInfo {
            components: 4,
            is_uint: false,
            is_sint: false,
            pixel_size: 4,
            name: "r8g8b8a8_unorm",
        },
        vk::Format::R32_UINT => FormatInfo {
            components: 1,
            is_uint: true,
            is_sint: false,
            pixel_size: 4,
            name: "r32_uint",
        },
        vk::Format::R16G16_SINT => FormatInfo {
            components: 2,
            is_uint: false,
            is_sint: true,
            pixel_size: 4,
            name: "r16g16_sint",
        },
        vk::Format::R32G32B32A32_SFLOAT => FormatInfo {
            components: 4,
            is_uint: false,
            is_sint: false,
            pixel_size: 16,
            name: "r32g32b32a32_sfloat",
        },
        _ => unreachable!("not a format of these tests"),
    }
}

/// `getClearValue`
fn get_clear_value(format: vk::Format) -> vk::ClearValue {
    let info = format_info(format);
    if info.is_uint || info.is_sint {
        vk::ClearValue {
            color: vk::ClearColorValue {
                uint32: [16, 32, 64, 96],
            },
        }
    } else {
        vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 1.0, 1.0],
            },
        }
    }
}

/// `getPrimitiveColor`
fn get_primitive_color() -> [f32; 4] {
    [1.0, 0.0, 0.0, 1.0]
}

/// `sampleIndexToColor`
fn sample_index_to_color(index: u32) -> [f32; 4] {
    let mut res = [0.0f32, 0.0, 0.0, 1.0];

    if index & 0x01 != 0 {
        res[0] += 0.5;
    }
    if index & 0x02 != 0 {
        res[1] += 0.5;
    }
    if index & 0x04 != 0 {
        res[2] += 0.5;
    }

    if index & 0x08 != 0 {
        res[0] += 0.5;
    }
    if index & 0x10 != 0 {
        res[1] += 0.5;
    }
    if index & 0x20 != 0 {
        res[2] += 0.5;
    }

    res
}

/// `getStandardSampleLocations`
fn get_standard_sample_locations(samples: u32) -> Result<&'static [f32], TestError> {
    static LOCATIONS_1: [f32; 2] = [0.5, 0.5];
    static LOCATIONS_2: [f32; 4] = [0.75, 0.75, 0.25, 0.25];
    static LOCATIONS_4: [f32; 8] = [0.375, 0.125, 0.875, 0.375, 0.125, 0.625, 0.625, 0.875];
    static LOCATIONS_8: [f32; 16] = [
        0.5625, 0.3125, 0.4375, 0.6875, 0.8125, 0.5625, 0.3125, 0.1875, 0.1875, 0.8125, 0.0625, 0.4375, 0.6875, 0.9375,
        0.9375, 0.0625,
    ];
    static LOCATIONS_16: [f32; 32] = [
        0.5625, 0.5625, 0.4375, 0.3125, 0.3125, 0.625, 0.75, 0.4375, 0.1875, 0.375, 0.625, 0.8125, 0.8125, 0.6875,
        0.6875, 0.1875, 0.375, 0.875, 0.5, 0.0625, 0.25, 0.125, 0.125, 0.75, 0.0, 0.5, 0.9375, 0.25, 0.875, 0.9375,
        0.0625, 0.0,
    ];

    match samples {
        1 => Ok(&LOCATIONS_1),
        2 => Ok(&LOCATIONS_2),
        4 => Ok(&LOCATIONS_4),
        8 => Ok(&LOCATIONS_8),
        16 => Ok(&LOCATIONS_16),
        _ => Err(TestError::InternalError(
            "Unknown multisample bit configuration requested".to_string(),
        )),
    }
}

/// `genTriangleVertices` - a flat-colored shape with sharp angles to make antialiasing visible.
fn gen_triangle_vertices() -> Vec<Vertex4Rgba> {
    vec![
        Vertex4Rgba {
            position: [-1.0, 0.0, 0.0, 1.0],
            color: get_primitive_color(),
        },
        Vertex4Rgba {
            position: [0.8, 0.2, 0.0, 1.0],
            color: get_primitive_color(),
        },
        Vertex4Rgba {
            position: [0.8, -0.2, 0.0, 1.0],
            color: get_primitive_color(),
        },
    ]
}

/// `genPerSampleTriangleVertices` - a flat-colored shapes plotted at standard sample points.
fn gen_per_sample_triangle_vertices(samples: u32) -> Result<Vec<Vertex4Rgba>, TestError> {
    let coordinates = get_standard_sample_locations(samples)?;
    let triangle_size = 1.0f32 / (samples as f32 * 2.0);
    let mut res = Vec::new();

    for i in 0..samples as usize {
        let color = sample_index_to_color(i as u32);
        let (x, y) = (coordinates[i * 2] * 2.0 - 1.0, coordinates[i * 2 + 1] * 2.0 - 1.0);
        res.push(Vertex4Rgba {
            position: [0.0 + x, -triangle_size + y, 0.0, 1.0],
            color,
        });
        res.push(Vertex4Rgba {
            position: [-triangle_size + x, triangle_size + y, 0.0, 1.0],
            color,
        });
        res.push(Vertex4Rgba {
            position: [triangle_size + x, triangle_size + y, 0.0, 1.0],
            color,
        });
    }
    Ok(res)
}

/// `genFullQuadVertices` - a full-viewport quad. Use with TRIANGLE_STRIP topology.
fn gen_full_quad_vertices() -> Vec<Vertex4Rgba> {
    let unused = [0.0f32; 4]; // unused
    vec![
        Vertex4Rgba {
            position: [-1.0, -1.0, 0.0, 1.0],
            color: unused,
        },
        Vertex4Rgba {
            position: [-1.0, 1.0, 0.0, 1.0],
            color: unused,
        },
        Vertex4Rgba {
            position: [1.0, -1.0, 0.0, 1.0],
            color: unused,
        },
        Vertex4Rgba {
            position: [1.0, 1.0, 0.0, 1.0],
            color: unused,
        },
    ]
}

/// `makeImage` - a 2D image with `num_layers` layers.
fn make_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    size: (u32, u32),
    num_layers: u32,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(num_layers)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// `makeSampler` - the simplest sampler.
fn make_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::ALWAYS)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

/// `makeColorSubresourceRange`
fn make_color_subresource_range(base_array_layer: u32, layer_count: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, base_array_layer, layer_count)
}

/// `checkImageFormatRequirements`
fn check_image_format_requirements(
    context: &Context<'_>,
    sample_count: vk::SampleCountFlags,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<(), TestError> {
    if usage.contains(vk::ImageUsageFlags::STORAGE)
        && context.get_device_features().shader_storage_image_multisample == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "Multisampled storage images are not supported".to_string(),
        ));
    }

    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };
    if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
        return Err(TestError::NotSupported("Image format is not supported".to_string()));
    }
    let properties = result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;

    if !properties.sample_counts.contains(sample_count) {
        return Err(TestError::NotSupported(
            "Requested sample count is not supported".to_string(),
        ));
    }
    Ok(())
}

/// The test case parameters of the 2D groups.
#[derive(Clone, Copy)]
struct CaseDef {
    render_size: (u32, u32),
    num_layers: u32,
    color_format: vk::Format,
    num_samples: vk::SampleCountFlags,
    color_samples: bool,
}

/// `renderMultisampledImage` - synchronously render to a multisampled color image, one subpass per layer.
fn render_multisampled_image<'a>(
    context: &'a Context<'a>,
    case_def: &CaseDef,
    color_image: vk::Image,
) -> Result<(), TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let num_layers = case_def.num_layers;
    let (width, height) = case_def.render_size;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // Create an image view (attachment) for each layer of the image
    let mut color_attachments = Vec::new();
    for i in 0..num_layers {
        color_attachments.push(make_image_view(
            device,
            color_image,
            vk::ImageViewType::_2D,
            case_def.color_format,
            make_color_subresource_range(i, 1),
        )?);
    }
    let attachment_handles: Vec<vk::ImageView> = color_attachments.iter().map(|view| **view).collect();

    // Vertex buffer
    let vertices = if case_def.color_samples {
        gen_per_sample_triangle_vertices(num_samples_of(case_def.num_samples))?
    } else {
        gen_triangle_vertices()
    };
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

    // Make a render pass with one subpass per color attachment and one attachment per image layer.
    let render_pass = {
        let attachment = vk::AttachmentDescription::builder()
            .format(case_def.color_format)
            .samples(case_def.num_samples)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build();
        let attachment_descriptions = vec![attachment; num_layers as usize];

        // Create a subpass for each attachment (each attachement is a layer of an arrayed image).
        let color_attachment_references: Vec<[vk::AttachmentReference; 1]> = (0..num_layers)
            .map(|i| {
                [vk::AttachmentReference {
                    attachment: i,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                }]
            })
            .collect();
        let subpasses: Vec<vk::SubpassDescription> = color_attachment_references
            .iter()
            .map(|reference| {
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(reference)
                    .build()
            })
            .collect();

        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        Unique::new(device, render_pass)
    };
    let framebuffer = make_framebuffer(device, *render_pass, &attachment_handles, width, height, 1)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    // One pipeline per subpass
    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;
    let mut pipelines = Vec::new();
    let mut layer_states = Vec::new();
    for subpass_ndx in 0..num_layers {
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<Vertex4Rgba>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.samples = case_def.num_samples;
        state.subpass = subpass_ndx;
        state.color_blend_attachments = vec![vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::ONE,
            dst_color_blend_factor: vk::BlendFactor::ZERO,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ONE,
            dst_alpha_blend_factor: vk::BlendFactor::ZERO,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::all(),
        }];
        if shader_objects.is_none() {
            pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vertex_module),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
                ],
                &state,
            )?);
        }
        layer_states.push(state);
    }

    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;

    let clear_values = vec![get_clear_value(case_def.color_format); num_layers as usize];
    if let Some(objects) = &shader_objects {
        // Every subpass is a rendering of its own to the view of one layer.
        let to_attachment = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_image,
            make_color_subresource_range(0, num_layers),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_attachment],
            );
        }
        for layer_ndx in 0..num_layers as usize {
            begin_dynamic_rendering(
                device,
                cmd,
                rect_2d(width, height),
                &[RenderingAttachment {
                    view: attachment_handles[layer_ndx],
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    clear_value: clear_values[layer_ndx],
                }],
                None,
                None,
            );
            objects.bind(cmd, &layer_states[layer_ndx]);
            unsafe {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            }
            end_dynamic_rendering(device, cmd);
        }
    } else {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(width, height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            for layer_ndx in 0..num_layers as usize {
                if layer_ndx != 0 {
                    device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
                }

                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipelines[layer_ndx]);
                device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            }

            device.cmd_end_render_pass(cmd);
        }
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)
}

/// Step 2 of the sampled image and standard sample position tests: sample the multisampled texture with `texelFetch` in a fragment
/// shader that writes a status into a checksum image of `checksum_format`; the contents of that image.
fn run_sample_pass<'a>(
    context: &'a Context<'a>,
    case_def: &CaseDef,
    color_image: vk::Image,
    checksum_format: vk::Format,
    checksum_pixel_size: u32,
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let (width, height) = case_def.render_size;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // Color image view
    let color_image_view_type = if case_def.num_layers == 1 {
        vk::ImageViewType::_2D
    } else {
        vk::ImageViewType::_2D_ARRAY
    };
    let color_image_view = make_image_view(
        device,
        color_image,
        color_image_view_type,
        case_def.color_format,
        make_color_subresource_range(0, case_def.num_layers),
    )?;
    let color_sampler = make_sampler(device)?;

    // Checksum image
    let checksum_image = make_image(
        context,
        checksum_format,
        case_def.render_size,
        1,
        vk::SampleCountFlags::_1,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
    )?;
    let checksum_image_view = make_image_view(
        device,
        checksum_image.get(),
        vk::ImageViewType::_2D,
        checksum_format,
        make_color_subresource_range(0, 1),
    )?;

    // Checksum buffer (for host reading)
    let checksum_buffer_size = u64::from(width) * u64::from(height) * u64::from(checksum_pixel_size);
    let checksum_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(checksum_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::write_bytes(
            checksum_buffer.get_allocation().get_host_ptr(),
            0,
            checksum_buffer_size as usize,
        )
    };
    flush_alloc(device, checksum_buffer.get_allocation())?;

    // Vertex buffer
    let vertices = gen_full_quad_vertices();
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Descriptors
    // \note OpImageFetch doesn't use a sampler, but in GLSL texelFetch needs a sampler2D which translates to a combined image sampler in Vulkan.
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_indexed_sampler_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::FRAGMENT,
            0,
            &[*color_sampler],
        )
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let image_descriptor_info = [vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: *color_image_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
        .image_info(&image_descriptor_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("sample_vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("sample_frag")?)?;
    let render_pass = make_render_pass(device, checksum_format)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*checksum_image_view], width, height, 1)?;
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(width, height);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<Vertex4Rgba>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 16,
        },
    ];
    state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
    state.rasterization.depth_bias_enable = vk::FALSE;
    let shader_objects = make_shader_objects(
        context,
        "sample_vert",
        Some("sample_frag"),
        &[*descriptor_set_layout],
        &[],
    )?;
    let pipeline = if shader_objects.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?)
    };

    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;

    // Prepare for sampling in the fragment shader
    let barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::SHADER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        color_image,
        make_color_subresource_range(0, case_def.num_layers),
    );
    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue { uint32: [0; 4] },
    }];
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
    begin_draw(
        device,
        cmd,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| pipeline.get()),
        *render_pass,
        *framebuffer,
        rect_2d(width, height),
        &clear_values,
        &[(checksum_image.get(), *checksum_image_view)],
    );
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
    }
    end_draw(device, cmd, shader_objects.is_some());

    copy_image_to_buffer(device, cmd, checksum_image.get(), checksum_buffer.get(), width, height);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, checksum_buffer.get_allocation())?;
    Ok(unsafe {
        std::slice::from_raw_parts(
            checksum_buffer.get_allocation().get_host_ptr(),
            checksum_buffer_size as usize,
        )
    }
    .to_vec())
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    SampledImage,
    StorageImage,
    StandardSamplePosition,
    SamplesMappingOrder,
}

struct MultisampleImageCase {
    name: String,
    /// The name of the case in the shader manifest.
    program_set: String,
    kind: Kind,
    case_def: CaseDef,
}

impl TestCase for MultisampleImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let case_def = &self.case_def;

        match self.kind {
            Kind::SampledImage => {
                let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED;
                check_image_format_requirements(
                    context,
                    case_def.num_samples,
                    case_def.color_format,
                    color_image_usage,
                )?;
            }
            Kind::StorageImage => {
                let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::STORAGE;
                check_image_format_requirements(
                    context,
                    case_def.num_samples,
                    case_def.color_format,
                    color_image_usage,
                )?;
            }
            Kind::StandardSamplePosition => {
                let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED;
                check_image_format_requirements(
                    context,
                    case_def.num_samples,
                    case_def.color_format,
                    color_image_usage,
                )?;

                if context.get_device_properties().limits.standard_sample_locations == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Device does not support standard sample locations.".to_string(),
                    ));
                }

                if case_def.num_samples == vk::SampleCountFlags::_32
                    || case_def.num_samples == vk::SampleCountFlags::_64
                {
                    return Err(TestError::InternalError(
                        "Standard does not define sample positions for 32x or 64x multisample modes".to_string(),
                    ));
                }
            }
            Kind::SamplesMappingOrder => {
                let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED;
                check_image_format_requirements(
                    context,
                    case_def.num_samples,
                    case_def.color_format,
                    color_image_usage,
                )?;

                if context.get_device_features().shader_storage_image_multisample == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Device does not support shaderStorageImageMultisample.".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.program_set)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.program_set))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleImageInstance {
            context,
            kind: self.kind,
            case_def: self.case_def,
        })
    }
}

struct MultisampleImageInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    case_def: CaseDef,
}

impl<'a> MultisampleImageInstance<'a> {
    /// `SampledImage::test`
    fn test_sampled_image(&self) -> TestOutcome {
        let context = self.context;
        let case_def = &self.case_def;
        let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED;

        // Multisampled color image
        let color_image = make_image(
            context,
            case_def.color_format,
            case_def.render_size,
            case_def.num_layers,
            case_def.num_samples,
            color_image_usage,
        )?;

        // Step 1: Render to texture
        render_multisampled_image(context, case_def, color_image.get())?;

        // Step 2: Sample texture
        let checksum = run_sample_pass(context, case_def, color_image.get(), vk::Format::R8G8_UINT, 2)?;

        // Verify result
        let num_expected_checksum = num_samples_of(case_def.num_samples) * case_def.num_layers;
        let mut multiple_colors_per_texel_found = false;

        for texel in checksum.chunks_exact(2) {
            let clear_color_count = u32::from(texel[0]);
            let primitive_color_count = u32::from(texel[1]);

            if (clear_color_count + primitive_color_count) != num_expected_checksum {
                return Ok(TestStatus::fail("Some samples have incorrect color"));
            }

            if clear_color_count > 0 && primitive_color_count > 0 {
                multiple_colors_per_texel_found = true;
            }
        }

        // For a multisampled image, we are expecting some texels to have samples of both clear color and primitive color
        if !multiple_colors_per_texel_found {
            return Ok(TestStatus::fail(
                "Could not find texels with samples of both clear color and primitive color",
            ));
        }

        Ok(TestStatus::pass("OK"))
    }

    /// `StandardSamplePosition::test`
    fn test_standard_sample_position(&self) -> TestOutcome {
        let context = self.context;
        let case_def = &self.case_def;
        let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED;

        // Multisampled color image
        let color_image = make_image(
            context,
            case_def.color_format,
            case_def.render_size,
            case_def.num_layers,
            case_def.num_samples,
            color_image_usage,
        )?;

        // Step 1: Render to texture
        render_multisampled_image(context, case_def, color_image.get())?;

        // Step 2: Sample texture
        let checksum = run_sample_pass(context, case_def, color_image.get(), vk::Format::R8_UINT, 1)?;

        // Verify result
        let result = u32::from(checksum[0]);
        if result != 0 {
            return Ok(TestStatus::fail(format!(
                "{result} multisamples have unexpected color."
            )));
        }

        Ok(TestStatus::pass("OK"))
    }

    /// `StorageImage::renderAndResolve` - render a MS image, optionally process it with a compute shader, resolve it and copy the
    /// result to a host-visible buffer of `resolve_buffer_size` bytes.
    fn render_and_resolve(
        &self,
        resolve_buffer: &BufferWithMemory<'_>,
        use_compute_pass: bool,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let case_def = &self.case_def;
        let (width, height) = case_def.render_size;
        let num_layers = case_def.num_layers;
        let format = case_def.color_format;

        // Multisampled color image
        let color_image = make_image(
            context,
            format,
            case_def.render_size,
            num_layers,
            case_def.num_samples,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::STORAGE
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        )?;
        let resolve_image = make_image(
            context,
            format,
            case_def.render_size,
            num_layers,
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Working image barrier, we change it based on which rendering stages were executed so far.
        let mut src_access_mask;
        let mut old_layout;

        // Pass 1: Render an image
        render_multisampled_image(context, case_def, color_image.get())?;
        src_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        old_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;

        // Pass 2: Compute shader
        if use_compute_pass {
            // Descriptors
            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
                .build(device)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

            let color_image_view = make_image_view(
                device,
                color_image.get(),
                if num_layers == 1 {
                    vk::ImageViewType::_2D
                } else {
                    vk::ImageViewType::_2D_ARRAY
                },
                format,
                make_color_subresource_range(0, num_layers),
            )?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
            let descriptor_image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *color_image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&descriptor_image_info)
                .build();
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let binaries = context.get_binary_collection();
            let shader_module = create_shader_module(device, binaries.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*shader_module)
                .name(b"main\0")
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_handle(vk::Pipeline::null())
                .base_pipeline_index(0);
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            let pipeline = Unique::new(device, pipelines.0[0]);

            begin_command_buffer(device, cmd)?;

            // Image layout for load/stores
            let dst_access_mask = vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE;
            let barrier = make_image_memory_barrier(
                src_access_mask,
                dst_access_mask,
                old_layout,
                vk::ImageLayout::GENERAL,
                color_image.get(),
                make_color_subresource_range(0, num_layers),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
            src_access_mask = dst_access_mask;
            old_layout = vk::ImageLayout::GENERAL;

            // Dispatch
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd, width, height, num_layers);
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Resolve and verify the image
        begin_command_buffer(device, cmd)?;

        // Prepare for resolve
        {
            let dst_access_mask = vk::AccessFlags::TRANSFER_READ;
            let barriers = [
                make_image_memory_barrier(
                    src_access_mask,
                    dst_access_mask,
                    old_layout,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_image.get(),
                    make_color_subresource_range(0, num_layers),
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    resolve_image.get(),
                    make_color_subresource_range(0, num_layers),
                ),
            ];

            let src_stage_mask = if src_access_mask == vk::AccessFlags::COLOR_ATTACHMENT_WRITE {
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            } else {
                vk::PipelineStageFlags::COMPUTE_SHADER
            };

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    src_stage_mask,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
            }
        }

        // Resolve the image
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: num_layers,
        };
        let resolve_region = vk::ImageResolve {
            src_subresource: layers,
            src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            dst_subresource: layers,
            dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            extent: vk::Extent3D {
                width,
                height,
                depth: 1,
            },
        };
        unsafe {
            device.cmd_resolve_image(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resolve_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[resolve_region],
            );

            // `copyImageToBuffer` of all the layers, from TRANSFER_DST_OPTIMAL
            let to_transfer_src = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resolve_image.get(),
                make_color_subresource_range(0, num_layers),
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer_src],
            );
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: layers,
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width,
                    height,
                    depth: 1,
                },
            };
            device.cmd_copy_image_to_buffer(
                cmd,
                resolve_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resolve_buffer.get(),
                &[copy_region],
            );
            let to_host = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)
    }

    /// `StorageImage::test`
    fn test_storage_image(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let case_def = &self.case_def;
        let info = format_info(case_def.color_format);
        let (width, height) = case_def.render_size;

        // Host-readable buffers
        let resolve_buffer_size =
            u64::from(width) * u64::from(height) * u64::from(case_def.num_layers) * u64::from(info.pixel_size);
        let make_buffer = || -> Result<BufferWithMemory<'a>, TestError> {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(resolve_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, resolve_buffer_size as usize) };
            flush_alloc(device, buffer.get_allocation())?;
            Ok(buffer)
        };
        let resolve_image_one_buffer = make_buffer()?;
        let resolve_image_two_buffer = make_buffer()?;

        // Render: repeat the same rendering twice to avoid non-essential API calls and layout transitions (e.g. copy).
        self.render_and_resolve(&resolve_image_one_buffer, false)?; // Pass 1: render a basic multisampled image
        self.render_and_resolve(&resolve_image_two_buffer, true)?; // Pass 2: the same but altered with a compute shader

        // Verify
        invalidate_alloc(device, resolve_image_one_buffer.get_allocation())?;
        invalidate_alloc(device, resolve_image_two_buffer.get_allocation())?;

        let tcu_format = map_vk_format(case_def.color_format).expect("the formats of these tests have texture formats");
        let one_bytes = unsafe {
            std::slice::from_raw_parts(
                resolve_image_one_buffer.get_allocation().get_host_ptr(),
                resolve_buffer_size as usize,
            )
        };
        let two_bytes = unsafe {
            std::slice::from_raw_parts(
                resolve_image_two_buffer.get_allocation().get_host_ptr(),
                resolve_buffer_size as usize,
            )
        };
        let layered_image_one =
            ConstPixelBufferAccess::new(tcu_format, [width, height, case_def.num_layers], one_bytes);
        let layered_image_two =
            ConstPixelBufferAccess::new(tcu_format, [width, height, case_def.num_layers], two_bytes);

        // Check all layers
        if !self.compare_images(&layered_image_one, &layered_image_two) {
            return Ok(TestStatus::fail("Rendered images are not correct"));
        }

        Ok(TestStatus::pass("OK"))
    }

    /// `StorageImage::compareImages` - exact image compare, but allow for some error when color format is integer.
    fn compare_images(
        &self,
        layered_reference_image: &ConstPixelBufferAccess<'_>,
        layered_actual_image: &ConstPixelBufferAccess<'_>,
    ) -> bool {
        let case_def = &self.case_def;
        let (width, height) = case_def.render_size;
        let info = format_info(case_def.color_format);
        let is_any_int_format = info.is_uint || info.is_sint;

        // There should be no mismatched pixels for non-integer formats. Otherwise we may get a wrong color in a location where sample coverage isn't exactly 0 or 1
        let bad_pixel_tolerance = if is_any_int_format { 2 * width } else { 0 };
        let mut good_layers = 0;

        for layer_ndx in 0..case_def.num_layers {
            let mut num_bad_pixels = 0;

            for y in 0..height {
                for x in 0..width {
                    let good = if is_any_int_format
                        && layered_reference_image.get_pixel_int(x, y, layer_ndx)
                            == layered_actual_image.get_pixel_int(x, y, layer_ndx)
                    {
                        true
                    } else {
                        layered_reference_image.get_pixel(x, y, layer_ndx)
                            == layered_actual_image.get_pixel(x, y, layer_ndx)
                    };

                    if !good {
                        num_bad_pixels += 1;
                    }
                }
            }

            if num_bad_pixels <= bad_pixel_tolerance {
                good_layers += 1;
            }
        }

        good_layers == case_def.num_layers
    }

    /// `SamplesMappingOrder::test`
    fn test_samples_mapping_order(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let case_def = &self.case_def;
        let (w, h) = case_def.render_size;
        let format = case_def.color_format;
        let samples = case_def.num_samples;

        // create multisampled image for color attachment
        let image = make_image(
            context,
            format,
            case_def.render_size,
            1,
            samples,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED,
        )?;
        let image_view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            format,
            make_color_subresource_range(0, 1),
        )?;

        // create renderpass
        let attachments = [vk::AttachmentDescription::builder()
            .format(format)
            .samples(samples)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::GENERAL)
            .build()];
        let color_attachment = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::GENERAL,
        }];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        let render_pass = Unique::new(device, render_pass);

        // create framebuffer
        let framebuffer = make_framebuffer(device, *render_pass, &[*image_view], w, h, 1)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let graphics_pipeline_layout = make_pipeline_layout(device, &[])?;

        // create ssbo buffer used in compute shader for partial verification
        let ssbo_size = u64::from(w) * u64::from(h) * std::mem::size_of::<f32>() as u64;
        let ssbo_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                ssbo_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // create graphics pipeline
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(w, h);
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.samples = samples;
        state.min_sample_shading = 1.0;
        state.sample_mask = Some(0xFF);
        state.color_blend_attachments = vec![vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::ZERO,
            dst_color_blend_factor: vk::BlendFactor::ZERO,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ZERO,
            dst_alpha_blend_factor: vk::BlendFactor::ZERO,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::all(),
        }];
        let graphics_pipeline = create_draw_pipeline(
            device,
            *graphics_pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // create descriptor set
        let compute_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::SAMPLED_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let compute_descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::SAMPLED_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let compute_descriptor_set =
            make_descriptor_set(device, *compute_descriptor_pool, *compute_descriptor_set_layout)?;
        let image_descriptor_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let buffer_descriptor_info = [vk::DescriptorBufferInfo {
            buffer: ssbo_buffer.get(),
            offset: 0,
            range: ssbo_size,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(compute_descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::SAMPLED_IMAGE)
                .image_info(&image_descriptor_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(compute_descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_descriptor_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // create compute pipeline
        let compute_pipeline_layout = make_pipeline_layout(device, &[*compute_descriptor_set_layout])?;
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
            .name(b"main\0")
            .build();
        let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*compute_pipeline_layout)
            .base_pipeline_handle(vk::Pipeline::null())
            .base_pipeline_index(0);
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(w, h));
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(cmd);

            // wait for multisampled image
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::SHADER_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // read each sample using compute shader
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *compute_pipeline_layout,
                0,
                &[compute_descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
            device.cmd_dispatch(cmd, 1, 1, 1);

            // wait for ssbo
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // get ssbo buffer
        invalidate_alloc(device, ssbo_buffer.get_allocation())?;
        let data: Vec<f32> = (0..(w * h) as usize)
            .map(|i| unsafe {
                std::ptr::read_unaligned(ssbo_buffer.get_allocation().get_host_ptr().cast::<f32>().add(i))
            })
            .collect();

        // in compute shader for each fragment we calculated value that is based on order of the samples;
        // here we need to check if same value was calculated for all fragments
        let epsilon = 0.001f32;
        for (i, value) in data.iter().enumerate().skip(1) {
            if (data[0] - value).abs() > epsilon {
                return Ok(TestStatus::fail(i.to_string()));
            }
        }

        Ok(TestStatus::pass("OK"))
    }
}

impl TestInstance for MultisampleImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::SampledImage => self.test_sampled_image(),
            Kind::StorageImage => self.test_storage_image(),
            Kind::StandardSamplePosition => self.test_standard_sample_position(),
            Kind::SamplesMappingOrder => self.test_samples_mapping_order(),
        }
    }
}

/// `Image3d` - render to a multisampled 2D image and resolve it to a 3D image.
struct Multisample3dCase {
    name: String,
    render_size: (u32, u32, u32),
    num_samples: vk::SampleCountFlags,
}

impl TestCase for Multisample3dCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let color_format = vk::Format::R8G8B8A8_UNORM;

        {
            let result = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    color_format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    color_image_usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
                return Err(TestError::NotSupported("Image format is not supported".to_string()));
            }
            let properties = result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;

            if !properties.sample_counts.contains(self.num_samples) {
                return Err(TestError::NotSupported(
                    "Requested sample count is not supported".to_string(),
                ));
            }
        }

        {
            let result = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    color_format,
                    vk::ImageType::_3D,
                    vk::ImageTiling::OPTIMAL,
                    color_image_usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
                return Err(TestError::NotSupported("Image format is not supported".to_string()));
            }
            result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "image3d")
            .expect("the shader manifest has the image3d case")
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Multisample3dInstance {
            context,
            render_size: self.render_size,
            num_samples: self.num_samples,
        })
    }
}

struct Multisample3dInstance<'a> {
    context: &'a Context<'a>,
    render_size: (u32, u32, u32),
    num_samples: vk::SampleCountFlags,
}

impl TestInstance for Multisample3dInstance<'_> {
    /// `Image3d::test`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let color_format = vk::Format::R8G8B8A8_UNORM;

        let (width, height, depth) = self.render_size;
        let samples = self.num_samples;
        let ms_image_extent = vk::Extent3D {
            width,
            height,
            depth: 1,
        };
        let src_clear_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        let dst_clear_color = [0.0f32, 1.0, 0.0, 1.0];
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Create a multisampled image of type 2D
        let src_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(ms_image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(samples)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let multisampled_image = ImageWithMemory::new(device, alloc, src_image_info, MemoryRequirement::ANY)?;

        // Create a normal image of type 3D
        let dst_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_3D)
            .format(color_format)
            .extent(vk::Extent3D { width, height, depth })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let dst_3d_image = ImageWithMemory::new(device, alloc, dst_image_info, MemoryRequirement::ANY)?;

        // Create vertex buffer
        let a = [-1.0f32, -1.0, 0.0, 1.0];
        let b = [1.0f32, -1.0, 0.0, 1.0];
        let c = [1.0f32, 1.0, 0.0, 1.0];
        let d = [-1.0f32, 1.0, 0.0, 1.0];
        let vertices: Vec<[f32; 4]> = vec![a, c, b, a, c, d];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Initialize samples
        let num_samples = num_samples_of(samples);
        let mut sample_vals: Vec<Vec<[f32; 4]>> = vec![vec![[0.0; 4]; num_samples as usize]; (width * height) as usize];
        for y in 0..height {
            for x in 0..width {
                let pixel_index = (y * width + x) as usize;

                for s in 0..num_samples {
                    let r = (x + s) as f32 / (width + num_samples) as f32;
                    let g = (y + s) as f32 / (height + num_samples) as f32;
                    let blue = if num_samples > 1 {
                        s as f32 / (num_samples - 1) as f32
                    } else {
                        0.0
                    };
                    let alpha = 1.0f32;

                    sample_vals[pixel_index][s as usize] = [r, g, blue, alpha];
                }
            }
        }

        // Push constants
        let push_constant_data: [i32; 3] = [width as i32, height as i32, num_samples as i32];
        let push_constant_bytes: Vec<u8> = push_constant_data
            .iter()
            .flat_map(|value| value.to_ne_bytes())
            .collect();
        let push_constant_size = push_constant_bytes.len() as u32;

        // Shader modules
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Render pass
        let attachments = [vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(samples)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_ref)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        let render_pass = Unique::new(device, render_pass);

        // Framebuffer
        let ms_image_view = make_image_view(
            device,
            multisampled_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range,
        )?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*ms_image_view],
            ms_image_extent.width,
            ms_image_extent.height,
            ms_image_extent.depth,
        )?;

        // Pipeline
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: push_constant_size,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout =
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;
        let pipeline_layout = Unique::new(device, pipeline_layout);

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.samples = samples;
        let graphics_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // Command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Execute upload commands
        {
            begin_command_buffer(device, cmd)?;

            let clear_values = [src_clear_color];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(width, height))
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout,
                    vk::ShaderStageFlags::FRAGMENT,
                    0,
                    &push_constant_bytes,
                );
                device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Multisampled 2D image has been rendered
        // Now, resolve multisampled 2D to a 3D image

        // Resolve region - full
        let color_subresource_layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };
        let resolve_region_offset = vk::Offset3D { x: 0, y: 0, z: 0 };

        let resolve_region = vk::ImageResolve {
            src_subresource: color_subresource_layers,
            src_offset: resolve_region_offset,
            dst_subresource: color_subresource_layers,
            dst_offset: resolve_region_offset,
            extent: ms_image_extent,
        };

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: color_subresource_layers,
            image_offset: resolve_region_offset,
            image_extent: vk::Extent3D { width, height, depth },
        };

        // Output buffer
        let pixel_size = 4u32;
        let result_buffer_size = u64::from(pixel_size) * u64::from(width) * u64::from(height) * u64::from(depth);
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(result_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let src_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            multisampled_image.get(),
            color_subresource_range,
        );
        let dst_image_barrier1 = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            dst_3d_image.get(),
            color_subresource_range,
        );
        let dst_image_barrier2 = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            dst_3d_image.get(),
            color_subresource_range,
        );
        let dst_image_barrier3 = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            dst_3d_image.get(),
            color_subresource_range,
        );
        let result_buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            result_buffer.get(),
            0,
            result_buffer_size,
        );

        // Execute resolve commands
        {
            begin_command_buffer(device, cmd)?;

            let no_memory_barriers = &[] as &[vk::MemoryBarrier];
            let no_buffer_barriers = &[] as &[vk::BufferMemoryBarrier];
            let dst_clear_value = vk::ClearColorValue {
                float32: dst_clear_color,
            };
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    no_memory_barriers,
                    no_buffer_barriers,
                    &[src_image_barrier],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    no_memory_barriers,
                    no_buffer_barriers,
                    &[dst_image_barrier1],
                );

                device.cmd_clear_color_image(
                    cmd,
                    dst_3d_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &dst_clear_value,
                    &[color_subresource_range],
                );

                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    no_memory_barriers,
                    no_buffer_barriers,
                    &[dst_image_barrier3],
                );

                device.cmd_resolve_image(
                    cmd,
                    multisampled_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    dst_3d_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[resolve_region],
                );

                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    no_memory_barriers,
                    no_buffer_barriers,
                    &[dst_image_barrier2],
                );

                device.cmd_copy_image_to_buffer(
                    cmd,
                    dst_3d_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    result_buffer.get(),
                    &[copy_region],
                );

                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    no_memory_barriers,
                    &[result_buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Get results
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let result_bytes = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr(),
                result_buffer_size as usize,
            )
        };
        let tcu_format = map_vk_format(color_format).expect("RGBA8 has a texture format");
        let result_pixels = ConstPixelBufferAccess::new(tcu_format, [width, height, depth], result_bytes);

        // Verification: reference images against each depth slices of the 3d image
        for slice_ndx in 0..depth {
            for y in 0..height {
                for x in 0..width {
                    // The first slice is the average resolve of the samples, the others still have the clear color.
                    let reference = if slice_ndx == 0 {
                        let pixel_samples = &sample_vals[(y * width + x) as usize];
                        let mut sum = [0.0f32; 4];
                        for sample in pixel_samples {
                            for (channel, value) in sum.iter_mut().zip(sample) {
                                *channel += value;
                            }
                        }
                        sum.map(|channel| channel / num_samples as f32)
                    } else {
                        dst_clear_color
                    };
                    let result = result_pixels.get_pixel(x, y, slice_ndx);

                    if (0..4).any(|channel| (reference[channel] - result[channel]).abs() > 0.01) {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `getSizeLayerString`
fn size_layer_string(size: (u32, u32), num_layers: u32) -> String {
    format!("{}x{}_{}", size.0, size.1, num_layers)
}

/// `addTestCasesWithFunctions`
fn add_test_cases_with_functions(group: &mut TestCaseGroup, kind: Kind, program_prefix: &str) {
    let sizes = [(64u32, 64u32), (79, 31)];
    let num_layers = [1u32, 4];
    let formats = [
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R32_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
    ];

    for size in sizes {
        for layers in num_layers {
            let mut size_layer_group = TestCaseGroup::new(size_layer_string(size, layers));

            for format in formats {
                let info = format_info(format);
                let mut format_group = TestCaseGroup::new(info.name);

                for samples in SAMPLE_COUNTS {
                    let n = num_samples_of(samples);
                    let case_def = CaseDef {
                        render_size: size,
                        num_layers: layers,
                        color_format: format,
                        num_samples: samples,
                        color_samples: false,
                    };
                    format_group.add_child(Box::new(MultisampleImageCase {
                        name: format!("samples_{n}"),
                        program_set: format!("{program_prefix}_{}_l{layers}_s{n}", info.name),
                        kind,
                        case_def,
                    }) as Box<dyn TestCase>);
                }

                size_layer_group.add_child(format_group);
            }

            group.add_child(size_layer_group);
        }
    }
}

/// The multisample image groups of `createMultisampleTests`, added to the `multisample` group.
pub fn add_multisample_image_tests(multisample_tests: &mut TestCaseGroup) {
    add_multisample_image_tests_for(multisample_tests, false);
}

/// `add_multisample_image_tests`; the shader object types have no `3d` and `samples_mapping_order` groups.
pub fn add_multisample_image_tests_for(multisample_tests: &mut TestCaseGroup, shader_object: bool) {
    // Render to a multisampled image and sample from it in a fragment shader.
    let mut sampled_image_group = TestCaseGroup::new("sampled_image");
    add_test_cases_with_functions(&mut sampled_image_group, Kind::SampledImage, "sampled");
    multisample_tests.add_child(sampled_image_group);

    // Render to a multisampled image and resolve it to a 3D image
    if !shader_object {
        let mut group_3d = TestCaseGroup::new("3d");
        let size = (64u32, 64u32, 8u32);
        let mut size_layer_group = TestCaseGroup::new(format!("{}x{}x{}_{}", size.0, size.1, size.2, 1));
        let mut format_group = TestCaseGroup::new("r8g8b8a8_unorm");

        for samples in SAMPLE_COUNTS {
            format_group.add_child(Box::new(Multisample3dCase {
                name: format!("samples_{}", num_samples_of(samples)),
                render_size: size,
                num_samples: samples,
            }) as Box<dyn TestCase>);
        }

        size_layer_group.add_child(format_group);
        group_3d.add_child(size_layer_group);
        multisample_tests.add_child(group_3d);
    }

    // Render to a multisampled image and access it with load/stores in a compute shader.
    let mut storage_image_group = TestCaseGroup::new("storage_image");
    add_test_cases_with_functions(&mut storage_image_group, Kind::StorageImage, "storage");
    multisample_tests.add_child(storage_image_group);

    // Render to a multisampled image and verify standard multisample positions.
    {
        let mut group = TestCaseGroup::new("standardsampleposition");

        for format in [vk::Format::R8G8B8A8_UNORM, vk::Format::R32G32B32A32_SFLOAT] {
            let info = format_info(format);
            let mut format_group = TestCaseGroup::new(info.name);

            for samples in SAMPLE_COUNTS {
                let n = num_samples_of(samples);
                let case_def = CaseDef {
                    render_size: (1, 1),
                    num_layers: 1,
                    color_format: format,
                    num_samples: samples,
                    color_samples: true,
                };
                format_group.add_child(Box::new(MultisampleImageCase {
                    name: format!("samples_{n}"),
                    program_set: format!("position_{}_s{n}", info.name),
                    kind: Kind::StandardSamplePosition,
                    case_def,
                }) as Box<dyn TestCase>);
            }

            group.add_child(format_group);
        }

        multisample_tests.add_child(group);
    }

    // Render to a multisampled image and verify if all samples are mapped in order
    if !shader_object {
        let mut group = TestCaseGroup::new("samples_mapping_order");

        for samples in SAMPLE_COUNTS {
            let n = num_samples_of(samples);
            let case_def = CaseDef {
                render_size: (16, 16),
                num_layers: 1,
                color_format: vk::Format::R8G8B8A8_UNORM,
                num_samples: samples,
                color_samples: true,
            };
            group.add_child(Box::new(MultisampleImageCase {
                name: format!("samples_{n}"),
                program_set: format!("mapping_order_s{n}"),
                kind: Kind::SamplesMappingOrder,
                case_def,
            }) as Box<dyn TestCase>);
        }

        multisample_tests.add_child(group);
    }
}
