// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/amber/vktAmberGraphicsFuzzTests.cpp (the graphicsfuzz Amber scripts under data/vulkan/amber/graphicsfuzz)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber graphics pipeline does for these scripts is done directly: a B8G8R8A8_UNORM
// colour attachment of the script's `FRAMEBUFFER_SIZE`, cleared to its `CLEAR_COLOR`, one draw of the whole framebuffer (`DRAW_RECT POS 0 0 SIZE`
// is two triangles over the full clip space, which the vertex shader of the manifest writes out from the vertex index), uniform and storage buffers
// bound in descriptor set 0, and the rectangles of `EXPECT ... EQ_RGBA` compared with the pixels read back.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::graphicsfuzz::ALL_GRAPHICS_FUZZ_CASE;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::B8G8R8A8_UNORM;
const TEXTURE_SIZE: u32 = 256;

/// The `rust_type` of the manifest entries: one Amber script.
#[derive(Clone, Copy)]
pub struct GraphicsFuzzCase {
    pub name: &'static str,
    /// One entry per graphics pipeline of the script, separated by `|`: `width,height,r,g,b,a/buffers/push`, the clear colour in 0..=255,
    /// A pass with a grid has a fourth part, `XxY` cells. `binding:u|s|t:hex` entries separated by `;`, a uniform (`u`) or storage (`s`) buffer with its contents, or the texture (`t`, no contents), and the hex of the push constants. Pass 0 uses the program `frag`,
    /// pass N the program `frag_N`.
    pub passes: &'static str,
    /// `pass,x,y,w,h,r,g,b,a,alpha_probed` entries separated by `;`.
    pub expects: &'static str,
    /// `pass,pass,tolerance` entries separated by `;`: `EXPECT a EQ_HISTOGRAM_EMD_BUFFER b TOLERANCE t`.
    pub histograms: &'static str,
    /// The device extensions the script asks for, separated by `,`; `PROP:FloatControlsProperties.<member>` asks for a device property.
    pub features: &'static str,
    pub programs: BinaryCollection,
}

struct BufferBinding {
    binding: u32,
    storage: bool,
    /// The 256 by 256 texture the scripts draw first (`texgen_pipeline`), bound as a combined image sampler with the default sampler.
    texture: bool,
    data: Vec<u8>,
}

struct Pass {
    width: u32,
    height: u32,
    clear: [f32; 4],
    buffers: Vec<BufferBinding>,
    push: Vec<u8>,
    /// `DRAW_GRID ... CELLS x y` with a vertex shader of its own (the program `vert_<pass>`) that reads a vec4 position at location 0.
    grid: Option<(u32, u32)>,
}

fn decode_hex(hex: &str) -> Vec<u8> {
    (0..hex.len() / 2)
        .map(|ndx| u8::from_str_radix(&hex[ndx * 2..ndx * 2 + 2], 16).expect("hex digits"))
        .collect()
}

fn parse_buffers(entries: &str) -> Vec<BufferBinding> {
    entries
        .split(';')
        .filter(|entry| !entry.is_empty())
        .map(|entry| {
            let mut parts = entry.split(':');
            let binding = parts.next().expect("a binding").parse().expect("a binding number");
            let kind = parts.next().expect("a kind");
            let data = decode_hex(parts.next().expect("hex data"));
            BufferBinding {
                binding,
                storage: kind == "s",
                texture: kind == "t",
                data,
            }
        })
        .collect()
}

fn parse_passes(passes: &str) -> Vec<Pass> {
    passes
        .split('|')
        .map(|pass| {
            let mut parts = pass.split('/');
            let header = parts.next().expect("a pass header");
            let buffers = parts.next().expect("the buffers of a pass");
            let push = decode_hex(parts.next().expect("the push constants of a pass"));
            let grid = parts.next().map(|cells| {
                let (x, y) = cells.split_once('x').expect("cells as XxY");
                (x.parse().expect("a cell count"), y.parse().expect("a cell count"))
            });
            let values: Vec<f32> = header
                .split(',')
                .map(|value| value.parse().expect("a pass number"))
                .collect();
            Pass {
                width: values[0] as u32,
                height: values[1] as u32,
                clear: [
                    values[2] / 255.0,
                    values[3] / 255.0,
                    values[4] / 255.0,
                    values[5] / 255.0,
                ],
                buffers: parse_buffers(buffers),
                push,
                grid,
            }
        })
        .collect()
}

/// The per-channel histograms of two frames compared as an earth mover's distance: the running difference of the normalised cumulative counts,
/// summed over the 256 bins and divided by their number, the largest over the four channels.
fn histogram_distance(a: &[u8], b: &[u8]) -> f64 {
    let pixels = (a.len() / 4) as f64;
    (0..4)
        .map(|channel| {
            let mut histogram_a = [0u32; 256];
            let mut histogram_b = [0u32; 256];
            for ndx in 0..a.len() / 4 {
                histogram_a[a[ndx * 4 + channel] as usize] += 1;
                histogram_b[b[ndx * 4 + channel] as usize] += 1;
            }
            let mut running = 0.0f64;
            let mut distance = 0.0f64;
            for bin in 0..256 {
                running += (f64::from(histogram_a[bin]) - f64::from(histogram_b[bin])) / pixels;
                distance += running.abs();
            }
            distance / 256.0
        })
        .fold(0.0, f64::max)
}

impl TestCase for GraphicsFuzzCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        for token in self.features.split(',').filter(|token| !token.is_empty()) {
            match token.strip_prefix("PROP:") {
                Some("FloatControlsProperties.shaderSignedZeroInfNanPreserveFloat32") => {
                    let mut float_controls = vk::PhysicalDeviceFloatControlsProperties::default();
                    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut float_controls);
                    unsafe {
                        context
                            .get_instance()
                            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                    };
                    if float_controls.shader_signed_zero_inf_nan_preserve_float32 == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "shaderSignedZeroInfNanPreserveFloat32 not supported".to_string(),
                        ));
                    }
                }
                Some(property) => return Err(TestError::InternalError(format!("unknown device property {property}"))),
                None => context.require_device_functionality(token)?,
            }
        }
        if parse_passes(self.passes)
            .iter()
            .any(|pass| pass.buffers.iter().any(|buffer| buffer.storage))
            && context.get_device_features().fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GraphicsFuzzInstance { context, case: *self })
    }
}

struct GraphicsFuzzInstance<'a> {
    context: &'a Context<'a>,
    case: GraphicsFuzzCase,
}

/// One graphics pipeline of the script: a clear, one draw of the whole framebuffer, and the colour attachment read back as bytes (blue, green, red, alpha).
fn render(context: &Context<'_>, pass: &Pass, vert_name: &str, frag_name: &str) -> Result<Vec<u8>, TestError> {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let alloc = context.get_default_allocator();
    let (width, height) = (pass.width, pass.height);

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let image_extent = vk::Extent3D {
        width,
        height,
        depth: 1,
    };
    let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(image_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(vk, alloc, image_info, MemoryRequirement::ANY)?;
    let color_image_view = make_image_view(
        vk,
        *color_image,
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_subresource_range,
    )?;

    let render_pass = make_render_pass(vk, COLOR_FORMAT)?;
    let framebuffer = make_framebuffer(vk, *render_pass, &[*color_image_view], width, height, 1)?;

    // The uniform and storage buffers of the script, in descriptor set 0.
    let bindings = &pass.buffers;
    let mut buffers = Vec::new();
    for binding in bindings {
        if binding.texture {
            buffers.push(None);
            continue;
        }
        let usage = if binding.storage {
            vk::BufferUsageFlags::STORAGE_BUFFER
        } else {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        };
        let buffer = BufferWithMemory::new(
            vk,
            alloc,
            make_buffer_create_info(binding.data.len() as vk::DeviceSize, usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                binding.data.as_ptr(),
                buffer.get_allocation().get_host_ptr(),
                binding.data.len(),
            )
        };
        flush_alloc(vk, buffer.get_allocation())?;
        buffers.push(Some(buffer));
    }
    let descriptor_type = |binding: &BufferBinding| {
        if binding.texture {
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER
        } else if binding.storage {
            vk::DescriptorType::STORAGE_BUFFER
        } else {
            vk::DescriptorType::UNIFORM_BUFFER
        }
    };

    // `texgen_pipeline` of the scripts: pixel (x, y) is (x, x ^ y, y, 255) as red, green, blue and alpha, which is what its fragment shader writes.
    let texture = if bindings.iter().any(|binding| binding.texture) {
        let extent = IVec2::new(TEXTURE_SIZE as i32, TEXTURE_SIZE as i32);
        let mut texels = Vec::with_capacity((TEXTURE_SIZE * TEXTURE_SIZE * 4) as usize);
        for y in 0..TEXTURE_SIZE {
            for x in 0..TEXTURE_SIZE {
                texels.extend([y as u8, (x ^ y) as u8, x as u8, 255]);
            }
        }
        let staging = BufferWithMemory::new(
            vk,
            alloc,
            make_buffer_create_info(texels.len() as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(texels.as_ptr(), staging.get_allocation().get_host_ptr(), texels.len())
        };
        flush_alloc(vk, staging.get_allocation())?;

        let image = ImageWithMemory::new(
            vk,
            alloc,
            make_image_create_info(
                extent,
                COLOR_FORMAT,
                vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let view = make_image_view(
            vk,
            *image,
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .min_lod(0.0)
            .max_lod(1.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            vk,
            unsafe { vk.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let upload_cmd = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *image,
            color_subresource_range,
        );
        let to_shader = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            *image,
            color_subresource_range,
        );
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: TEXTURE_SIZE,
                height: TEXTURE_SIZE,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let begin_info = vk::CommandBufferBeginInfo::builder();
        unsafe {
            vk.begin_command_buffer(*upload_cmd, &begin_info)
                .vk_check("vkBeginCommandBuffer")?;
            vk.cmd_pipeline_barrier(
                *upload_cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            vk.cmd_copy_buffer_to_image(
                *upload_cmd,
                staging.get(),
                *image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[region],
            );
            vk.cmd_pipeline_barrier(
                *upload_cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_shader],
            );
        }
        end_command_buffer(vk, *upload_cmd)?;
        submit_commands_and_wait(vk, queue, *upload_cmd)?;
        Some((image, view, sampler))
    } else {
        None
    };

    // A script without buffers has no set at all: a descriptor pool needs at least one size.
    let descriptors = if bindings.is_empty() {
        None
    } else {
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        let mut pool_builder = DescriptorPoolBuilder::new();
        for binding in bindings {
            layout_builder = layout_builder.add_indexed_binding(
                descriptor_type(binding),
                vk::ShaderStageFlags::ALL_GRAPHICS,
                binding.binding,
                1,
            );
            pool_builder = pool_builder.add_type(descriptor_type(binding), 1);
        }
        let descriptor_set_layout = layout_builder.build(vk)?;
        let descriptor_pool = pool_builder.build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let mut update = DescriptorSetUpdateBuilder::new();
        for (binding, buffer) in bindings.iter().zip(&buffers) {
            let Some(buffer) = buffer else { continue };
            let info = make_descriptor_buffer_info(buffer.get(), 0, binding.data.len() as vk::DeviceSize);
            update = update.write_single(
                *descriptor_set,
                Location::binding(binding.binding),
                descriptor_type(binding),
                &info,
            );
        }
        update.update(vk);
        if let Some((_, view, sampler)) = &texture {
            let image_info = vk::DescriptorImageInfo {
                sampler: **sampler,
                image_view: **view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            };
            for binding in bindings.iter().filter(|binding| binding.texture) {
                let write = vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: *descriptor_set,
                    dst_binding: binding.binding,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    image_info: std::ptr::from_ref(&image_info),
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: std::ptr::null(),
                };
                unsafe { vk.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            }
        }
        // Dropped in this order: the set before its pool before the layout.
        Some((descriptor_set, descriptor_pool, descriptor_set_layout))
    };

    let set_layouts: Vec<vk::DescriptorSetLayout> = descriptors.iter().map(|(_, _, layout)| **layout).collect();
    let push_constant_ranges = if pass.push.is_empty() {
        Vec::new()
    } else {
        vec![vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: pass.push.len() as u32,
        }]
    };
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&push_constant_ranges);
    let pipeline_layout = Unique::new(
        vk,
        unsafe { vk.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(vk, binaries.get(vert_name)?)?;
    let frag_module = create_shader_module(vk, binaries.get(frag_name)?)?;
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

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: width as f32,
        height: height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, width, height)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    // DRAW_GRID: two triangles per cell over the whole of clip space, positions as (x, y, 0, 1).
    let mut grid_vertices: Vec<[f32; 4]> = Vec::new();
    if let Some((cells_x, cells_y)) = pass.grid {
        for cell_y in 0..cells_y {
            for cell_x in 0..cells_x {
                let (x0, x1) = (
                    -1.0 + 2.0 * cell_x as f32 / cells_x as f32,
                    -1.0 + 2.0 * (cell_x + 1) as f32 / cells_x as f32,
                );
                let (y0, y1) = (
                    -1.0 + 2.0 * cell_y as f32 / cells_y as f32,
                    -1.0 + 2.0 * (cell_y + 1) as f32 / cells_y as f32,
                );
                grid_vertices.extend([
                    [x0, y0, 0.0, 1.0],
                    [x1, y0, 0.0, 1.0],
                    [x0, y1, 0.0, 1.0],
                    [x1, y0, 0.0, 1.0],
                    [x1, y1, 0.0, 1.0],
                    [x0, y1, 0.0, 1.0],
                ]);
            }
        }
    }
    let vertex_buffer = if grid_vertices.is_empty() {
        None
    } else {
        let byte_size = grid_vertices.len() * std::mem::size_of::<[f32; 4]>();
        let buffer = BufferWithMemory::new(
            vk,
            alloc,
            make_buffer_create_info(byte_size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                grid_vertices.as_ptr().cast::<u8>(),
                buffer.get_allocation().get_host_ptr(),
                byte_size,
            )
        };
        flush_alloc(vk, buffer.get_allocation())?;
        Some(buffer)
    };
    let vertex_bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: 16,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let vertex_attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let mut vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    if vertex_buffer.is_some() {
        vertex_input_state = vertex_input_state
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
    }
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false);
    let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);

    let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .color_blend_state(&color_blend_state)
        .layout(*pipeline_layout)
        .render_pass(*render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipelines = unsafe { vk.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    let pipeline = Unique::new(vk, pipelines.0[0]);

    let output_buffer = BufferWithMemory::new(
        vk,
        alloc,
        make_buffer_create_info(
            width as vk::DeviceSize * height as vk::DeviceSize * 4,
            vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let clear = pass.clear;

    let begin_info = vk::CommandBufferBeginInfo::builder();
    unsafe { vk.begin_command_buffer(*cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
    unsafe {
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [clear[0], clear[1], clear[2], clear[3]],
            },
        }];
        let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, width, height))
            .clear_values(&clear_values);
        vk.cmd_begin_render_pass(*cmd_buffer, &render_pass_begin_info, vk::SubpassContents::INLINE);
        vk.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        if let Some((descriptor_set, _, _)) = &descriptors {
            vk.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[**descriptor_set],
                &[] as &[u32],
            );
        }
        if !pass.push.is_empty() {
            vk.cmd_push_constants(
                *cmd_buffer,
                *pipeline_layout,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &pass.push,
            );
        }
        if let Some(vertex_buffer) = &vertex_buffer {
            vk.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
        }
        vk.cmd_draw(
            *cmd_buffer,
            if vertex_buffer.is_some() {
                grid_vertices.len() as u32
            } else {
                6
            },
            1,
            0,
            0,
        );
        vk.cmd_end_render_pass(*cmd_buffer);

        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            *color_image,
            color_subresource_range,
        );
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );

        let copy_region = make_buffer_image_copy(
            image_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        vk.cmd_copy_image_to_buffer(
            *cmd_buffer,
            *color_image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            output_buffer.get(),
            &[copy_region],
        );

        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, queue, *cmd_buffer)?;
    invalidate_alloc(vk, output_buffer.get_allocation())?;

    let pixels = unsafe {
        std::slice::from_raw_parts(
            output_buffer.get_allocation().get_host_ptr().cast_const(),
            (width * height * 4) as usize,
        )
    }
    .to_vec();
    Ok(pixels)
}

impl TestInstance for GraphicsFuzzInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let passes = parse_passes(self.case.passes);
        let mut frames = Vec::new();
        for (number, pass) in passes.iter().enumerate() {
            let frag_name = if number == 0 {
                "frag".to_string()
            } else {
                format!("frag_{number}")
            };
            let vert_name = if pass.grid.is_some() {
                format!("vert_{number}")
            } else {
                "vert".to_string()
            };
            frames.push(render(self.context, pass, &vert_name, &frag_name)?);
        }

        for expect in self.case.expects.split(';').filter(|expect| !expect.is_empty()) {
            let values: Vec<u32> = expect
                .split(',')
                .map(|value| value.parse().expect("an expectation value"))
                .collect();
            let (number, x0, y0, w, h) = (values[0] as usize, values[1], values[2], values[3], values[4]);
            // An EQ_RGB probe has no alpha value and no alpha flag, so it is nine values long where an EQ_RGBA one is ten.
            let probe_alpha = values.len() > 9 && values[9] != 0;
            let colour = [
                values[5] as u8,
                values[6] as u8,
                values[7] as u8,
                if probe_alpha { values[8] as u8 } else { 0 },
            ];
            let width = passes[number].width;
            for y in y0..y0 + h {
                for x in x0..x0 + w {
                    let offset = ((y * width + x) * 4) as usize;
                    // B8G8R8A8: the bytes are blue, green, red, alpha.
                    let pixel = [
                        frames[number][offset + 2],
                        frames[number][offset + 1],
                        frames[number][offset],
                        frames[number][offset + 3],
                    ];
                    let channels = if probe_alpha { 4 } else { 3 };
                    if (0..channels).any(|channel| pixel[channel].abs_diff(colour[channel]) > 1) {
                        return Ok(TestStatus::fail(format!(
                            "Probe failed at ({x}, {y}): expected {:?}, found {:?}",
                            &colour[..channels],
                            &pixel[..channels]
                        )));
                    }
                }
            }
        }

        for histogram in self
            .case
            .histograms
            .split(';')
            .filter(|histogram| !histogram.is_empty())
        {
            let mut parts = histogram.split(',');
            let a: usize = parts.next().expect("a pass").parse().expect("a pass number");
            let b: usize = parts.next().expect("a pass").parse().expect("a pass number");
            let tolerance: f64 = parts.next().expect("a tolerance").parse().expect("a tolerance");
            let distance = histogram_distance(&frames[a], &frames[b]);
            if distance > tolerance {
                return Ok(TestStatus::fail(format!(
                    "Histogram distance {distance} of the frames of pipelines {a} and {b} is above {tolerance}"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The cases of the manifest as the `graphicsfuzz` group, in the order of upstream's list.
pub fn create_graphicsfuzz_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("graphicsfuzz");
    for case in ALL_GRAPHICS_FUZZ_CASE.iter() {
        group.add_child(Box::new(**case) as Box<dyn TestCase>);
    }
    // The compute scripts go through the compute case of the assembly groups, which is what converts them.
    for case in crate::vkt::tests::spirv_assembly::amber_tests::create_graphicsfuzz_compute_cases() {
        group.add_child(case);
    }
    for case in super::compute_tests::create_graphicsfuzz_compute_cases() {
        group.add_child(case);
    }
    group
}
