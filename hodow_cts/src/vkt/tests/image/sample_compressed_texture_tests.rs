// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageSampleCompressedTextureTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021-2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/image_sample_compressed_texture.toml,
// one program set per (BC1/BC3, one/two samplers). A non cubemap image is handled as a cubemap with a single face, which
// records the same commands as upstream's separate non cubemap branches.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::image_sample_compressed_texture::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, make_color_render_pass};
use crate::vkt::tests::synchronization::image_layout_transition_tests::{clear_color_image, copy_image_to_buffer};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const BUFFERSIZE: vk::DeviceSize = 100 * 1024;
const WIDTH: u32 = 80;
const HEIGHT: u32 = 80;
const FACES: u32 = 6;
// BC1 and BC3 both use 4x4x1 blocks
const BLOCK_SIZE: u32 = 4;

/// `getLayerCount`
fn get_layer_count(cubemap: bool) -> u32 {
    if cubemap { FACES } else { 1 }
}

/// `makeImageCreateInfo`
fn make_image_create_info(
    size: [u32; 2],
    format: vk::Format,
    storage_image: bool,
    cubemap: bool,
) -> vk::ImageCreateInfo {
    let mut usage =
        vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST;
    let mut flags = if cubemap {
        vk::ImageCreateFlags::CUBE_COMPATIBLE
    } else {
        vk::ImageCreateFlags::empty()
    };

    if storage_image {
        usage = vk::ImageUsageFlags::STORAGE
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::SAMPLED;
        flags |= vk::ImageCreateFlags::MUTABLE_FORMAT
            | vk::ImageCreateFlags::EXTENDED_USAGE
            | vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE;
    }

    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: size[0],
            height: size[1],
            depth: 1,
        },
        mip_levels: 1,
        array_layers: get_layer_count(cubemap),
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `makeVertexBuffer` + `bindBuffer(HostVisible)`
fn make_vertex_buffer<'a>(device: &'a Device, allocator: &SimpleAllocator) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(BUFFERSIZE, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// `makeSampler`
fn make_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
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
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

/// `Vertex`
#[repr(C)]
#[derive(Clone, Copy)]
struct Vertex {
    position: [f32; 4],
    uv: [f32; 2],
}

fn vertex_binding_description() -> vk::VertexInputBindingDescription {
    vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<Vertex>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }
}

fn vertex_attribute_descriptions() -> Vec<vk::VertexInputAttributeDescription> {
    vec![
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: std::mem::offset_of!(Vertex, position) as u32,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: std::mem::offset_of!(Vertex, uv) as u32,
        },
    ]
}

/// `generateVertices` - the vertices of a full quad and texture coordinates of each vertex
fn generate_vertices() -> Vec<Vertex> {
    vec![
        Vertex {
            position: [-1.0, -1.0, 0.0, 1.0],
            uv: [0.0, 0.0],
        },
        Vertex {
            position: [1.0, -1.0, 0.0, 1.0],
            uv: [1.0, 0.0],
        },
        Vertex {
            position: [-1.0, 1.0, 0.0, 1.0],
            uv: [0.0, 1.0],
        },
        Vertex {
            position: [1.0, -1.0, 0.0, 1.0],
            uv: [1.0, 0.0],
        },
        Vertex {
            position: [1.0, 1.0, 0.0, 1.0],
            uv: [1.0, 1.0],
        },
        Vertex {
            position: [-1.0, 1.0, 0.0, 1.0],
            uv: [0.0, 1.0],
        },
    ]
}

/// What `makeGraphicsPipeline` builds when not told otherwise: triangle list, no culling, counter clockwise front faces.
fn pipeline_state(width: u32, height: u32) -> DrawPipelineState {
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0)
        .build();
    state.bindings = vec![vertex_binding_description()];
    state.attributes = vertex_attribute_descriptions();
    state
}

/// `makeImageView` with a `VkImageViewUsageCreateInfo` chained
fn make_image_view_with_usage<'a>(
    device: &'a Device,
    image: vk::Image,
    format: vk::Format,
    subresource_range: vk::ImageSubresourceRange,
    usage: vk::ImageUsageFlags,
) -> Result<Unique<'a, vk::ImageView>, TestError> {
    let mut usage_info = vk::ImageViewUsageCreateInfo::builder().usage(usage);
    let info = vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(vk::ImageViewType::_2D)
        .format(format)
        .components(vk::ComponentMapping {
            r: vk::ComponentSwizzle::IDENTITY,
            g: vk::ComponentSwizzle::IDENTITY,
            b: vk::ComponentSwizzle::IDENTITY,
            a: vk::ComponentSwizzle::IDENTITY,
        })
        .subresource_range(subresource_range)
        .push_next(&mut usage_info);
    let view = unsafe { device.create_image_view(&info, None) }.vk_check("vkCreateImageView")?;
    Ok(Unique::new(device, view))
}

struct SampleDrawnTextureTest {
    name: &'static str,
    image_format: vk::Format,
    image_view_format: vk::Format,
    two_samplers: bool,
    cubemap: bool,
}

impl TestCase for SampleDrawnTextureTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let usage = vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::SAMPLED
            | vk::ImageUsageFlags::STORAGE;
        let mut flags = vk::ImageCreateFlags::MUTABLE_FORMAT
            | vk::ImageCreateFlags::EXTENDED_USAGE
            | vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE;
        if self.cubemap {
            flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        // VkImageViewUsageCreateInfo has to be able to override the implicit usage derived from the image, and a
        // compressed image has to be creatable with usage only an uncompressed view of its blocks supports.
        if !context.is_device_functionality_supported("VK_KHR_maintenance2") {
            return Err(TestError::NotSupported(
                "Device does not support extended image usage flags nor overriding implicit usage flags".to_string(),
            ));
        }

        let properties = unsafe {
            instance.get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.image_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                flags,
            )
        };
        if matches!(properties, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
            let algorithm_name = if self.image_format == vk::Format::BC3_UNORM_BLOCK {
                "BC3"
            } else {
                "BC1"
            };
            let mut error_msg = algorithm_name.to_string();
            error_msg += if self.cubemap {
                " compressed cubemap images"
            } else {
                " compressed images"
            };
            error_msg += " created with VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT, VK_IMAGE_CREATE_EXTENDED_USAGE_BIT";
            error_msg += " and VK_IMAGE_CREATE_BLOCK_TEXEL_VIEW_COMPATIBLE_BIT flags not supported.";
            return Err(TestError::NotSupported(error_msg));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let bc1 = self.image_format == vk::Format::BC1_RGB_UNORM_BLOCK;
        match (bc1, self.two_samplers) {
            (true, false) => SAMPLE_TEXTURE_BC1.programs,
            (true, true) => SAMPLE_TEXTURE_BC1_TWO_SAMPLERS.programs,
            (false, false) => SAMPLE_TEXTURE_BC3.programs,
            (false, true) => SAMPLE_TEXTURE_BC3_TWO_SAMPLERS.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleDrawnTextureTestInstance {
            context,
            image_format: self.image_format,
            image_view_format: self.image_view_format,
            two_samplers: self.two_samplers,
            cubemap: self.cubemap,
        })
    }
}

struct SampleDrawnTextureTestInstance<'a> {
    context: &'a Context<'a>,
    image_format: vk::Format,
    image_view_format: vk::Format,
    two_samplers: bool,
    cubemap: bool,
}

impl TestInstance for SampleDrawnTextureTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        debug_assert!(
            self.image_format == vk::Format::BC1_RGB_UNORM_BLOCK || self.image_format == vk::Format::BC3_UNORM_BLOCK
        );

        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let image_size = [WIDTH, HEIGHT];
        let render_size = [WIDTH, HEIGHT];

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 6)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 12)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 21)?;

        let rendered_image_format = vk::Format::R8G8B8A8_UNORM;
        let storage_image_view_size = [image_size[0] / BLOCK_SIZE, image_size[1] / BLOCK_SIZE];
        let layer_count = get_layer_count(self.cubemap);
        let faces = layer_count;

        // Create a storage image. The first pipeline fills it and the second pipeline uses it as a sampling source.
        let image_create_info = make_image_create_info(image_size, self.image_format, true, self.cubemap);
        let image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count);
        let storage_image = ImageWithMemory::new(vk, allocator, image_create_info, MemoryRequirement::ANY)?;

        // Create image views and descriptor sets for the first pipeline
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        // Cubemap tests use separate image views for each side of a cubemap.
        let subresource_ranges: Vec<vk::ImageSubresourceRange> = (0..faces)
            .map(|i| make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, i, 1))
            .collect();
        let mut storage_image_views = Vec::new();
        let mut storage_dscr_image_infos = Vec::new();
        let mut storage_dscr_sets = Vec::new();
        for range in &subresource_ranges {
            let view = make_image_view(
                vk,
                *storage_image,
                vk::ImageViewType::_2D,
                self.image_view_format,
                *range,
            )?;
            storage_dscr_image_infos.push(vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *view,
                image_layout: vk::ImageLayout::GENERAL,
            });
            storage_image_views.push(view);
            storage_dscr_sets.push(make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?);
        }
        {
            let writes: Vec<vk::WriteDescriptorSet> = storage_dscr_sets
                .iter()
                .zip(&storage_dscr_image_infos)
                .map(|(set, info)| {
                    vk::WriteDescriptorSet::builder()
                        .dst_set(**set)
                        .dst_binding(0)
                        .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                        .image_info(std::slice::from_ref(info))
                        .build()
                })
                .collect();
            unsafe { vk.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // Create a compute pipeline.
        let compute_shader = create_shader_module(vk, self.context.get_binary_collection().get("comp")?)?;
        let compute_push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        }];
        let compute_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(std::slice::from_ref(&*descriptor_set_layout))
            .push_constant_ranges(&compute_push_constant_ranges);
        let compute_pipeline_layout = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&compute_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_shader)
            .name(b"main\0")
            .build();
        let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*compute_pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let compute_pipeline = Unique::new(
            vk,
            unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        // Create a graphics pipeline and all the necessary components for sampling the storage image

        // The first sampler uses an uncompressed format.
        let sampler = make_sampler(vk)?;

        // The second sampler uses the same format as the image.
        let sampler2 = make_sampler(vk)?;

        // Image views implicitly derive the usage flags from the image. Drop the storage image flag since it's incompatible
        // with the compressed format and unnecessary in sampling.
        let view_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::SAMPLED;

        let graphics_dscr_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_sampler_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &[*sampler2],
            )
            .add_indexed_sampler_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                1,
                &[*sampler],
            )
            .build(vk)?;

        let mut sampler2_image_views = Vec::new();
        let mut sampler_image_views = Vec::new();
        let mut sampler2_dscr_image_infos = Vec::new();
        let mut sampler_dscr_image_infos = Vec::new();
        let mut graphics_dscr_sets = Vec::new();
        for range in &subresource_ranges {
            let view2 = make_image_view_with_usage(vk, *storage_image, self.image_format, *range, view_usage)?;
            sampler2_dscr_image_infos.push(vk::DescriptorImageInfo {
                sampler: *sampler2,
                image_view: *view2,
                image_layout: vk::ImageLayout::GENERAL,
            });
            sampler2_image_views.push(view2);
            graphics_dscr_sets.push(make_descriptor_set(vk, *descriptor_pool, *graphics_dscr_set_layout)?);

            if self.two_samplers {
                let view = make_image_view(
                    vk,
                    *storage_image,
                    vk::ImageViewType::_2D,
                    self.image_view_format,
                    *range,
                )?;
                sampler_dscr_image_infos.push(vk::DescriptorImageInfo {
                    sampler: *sampler,
                    image_view: *view,
                    image_layout: vk::ImageLayout::GENERAL,
                });
                sampler_image_views.push(view);
            }
        }
        {
            let mut writes = Vec::new();
            for (i, set) in graphics_dscr_sets.iter().enumerate() {
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(**set)
                        .dst_binding(0)
                        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                        .image_info(std::slice::from_ref(&sampler2_dscr_image_infos[i]))
                        .build(),
                );
                if self.two_samplers {
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(**set)
                            .dst_binding(1)
                            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                            .image_info(std::slice::from_ref(&sampler_dscr_image_infos[i]))
                            .build(),
                    );
                }
            }
            unsafe { vk.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // Sampled values will be rendered on this image.
        let target_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let target_image_create_info = make_image_create_info(image_size, rendered_image_format, false, false);
        let target_image = ImageWithMemory::new(vk, allocator, target_image_create_info, MemoryRequirement::ANY)?;
        let target_image_view = make_image_view(
            vk,
            *target_image,
            vk::ImageViewType::_2D,
            rendered_image_format,
            target_subresource_range,
        )?;

        // Clear the render target image as black and do a layout transition.
        clear_color_image(
            vk,
            queue,
            queue_family_index,
            *target_image,
            vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 0.0],
            },
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            0,
            1,
        )?;

        let graphics_push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        }];
        let graphics_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(std::slice::from_ref(&*graphics_dscr_set_layout))
            .push_constant_ranges(&graphics_push_constant_ranges);
        let graphics_pipeline_layout = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&graphics_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Vertices for a full quad and texture coordinates for each vertex.
        let vertices = generate_vertices();
        let vertex_count = vertices.len() as u32;
        let vertex_buffer = make_vertex_buffer(vk, allocator)?;
        let vertex_buffer_offset: vk::DeviceSize = 0;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(vertices.as_slice()),
            )
        };
        flush_alloc(vk, vertex_buffer.get_allocation())?;

        let binaries = self.context.get_binary_collection();
        let vertex_shader = create_shader_module(vk, binaries.get("vert")?)?;
        let fragment_shader = create_shader_module(vk, binaries.get("frag")?)?;

        // Create a render pass, a framebuffer, and the second pipeline.
        let render_pass = make_color_render_pass(
            vk,
            rendered_image_format,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(
            vk,
            *render_pass,
            &[*target_image_view],
            render_size[0],
            render_size[1],
            1,
        )?;
        let graphics_pipeline = create_draw_pipeline(
            vk,
            *graphics_pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_shader),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_shader),
            ],
            &pipeline_state(render_size[0], render_size[1]),
        )?;

        // Create a result buffer.
        let result_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(BUFFERSIZE, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        begin_command_buffer(vk, cmd)?;

        // Do a layout transition for the storage image.
        let barrier1 = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            *storage_image,
            image_subresource_range,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier1],
            );
        }

        // Bind the vertices used in the graphics pipeline.
        unsafe { vk.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]) };

        let no_clear = vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        };
        let target_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            *target_image,
            target_subresource_range,
        );
        let target_barrier_cmd = || unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[target_barrier],
            );
        };

        // Fill the storage image and sample it twice.
        for pass in 0..2i32 {
            // If both samplers are enabled, it's not necessary to run the compute shader twice since it already writes
            // the expected values on the first pass. The first sampler uses an uncompressed image format so the result
            // image will contain garbage if the second sampler doesn't work properly.
            if !self.two_samplers || pass == 0 {
                unsafe {
                    vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
                    vk.cmd_push_constants(
                        cmd,
                        *compute_pipeline_layout,
                        vk::ShaderStageFlags::COMPUTE,
                        0,
                        &pass.to_ne_bytes(),
                    );
                }

                // If cubemaps are enabled, loop over six times and bind the next face of the cubemap image on each iteration.
                for set in &storage_dscr_sets {
                    unsafe {
                        vk.cmd_bind_descriptor_sets(
                            cmd,
                            vk::PipelineBindPoint::COMPUTE,
                            *compute_pipeline_layout,
                            0,
                            &[**set],
                            &[],
                        );
                        vk.cmd_dispatch(cmd, storage_image_view_size[0], storage_image_view_size[1], 1);
                    }
                }

                let barrier2 = make_image_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::GENERAL,
                    *storage_image,
                    image_subresource_range,
                );
                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[barrier2],
                    );
                }
            }

            unsafe {
                vk.cmd_push_constants(
                    cmd,
                    *graphics_pipeline_layout,
                    vk::ShaderStageFlags::FRAGMENT,
                    0,
                    &pass.to_ne_bytes(),
                );
                vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            }

            // If cubemaps are enabled, loop over six times and bind the next face of the cubemap image on each iteration.
            for (face, set) in graphics_dscr_sets.iter().enumerate() {
                unsafe {
                    vk.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *graphics_pipeline_layout,
                        0,
                        &[**set],
                        &[],
                    )
                };

                begin_render_pass(
                    vk,
                    cmd,
                    *render_pass,
                    *framebuffer,
                    make_rect_2d(0, 0, image_size[0], image_size[1]),
                    no_clear,
                );
                unsafe { vk.cmd_draw(cmd, vertex_count, 1, 0, 0) };
                end_render_pass(vk, cmd);

                if self.cubemap && face < FACES as usize - 1 {
                    target_barrier_cmd();
                }
            }

            if pass == 0 {
                let barrier3 = make_image_memory_barrier(
                    vk::AccessFlags::SHADER_READ,
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::GENERAL,
                    *storage_image,
                    image_subresource_range,
                );
                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[barrier3],
                    );
                }
                target_barrier_cmd();
            }
        }

        // Copy the sampled values from the target image into the result image.
        copy_image_to_buffer(
            vk,
            cmd,
            *target_image,
            result_buffer.get(),
            (WIDTH, HEIGHT),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        );

        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;

        invalidate_alloc(vk, result_buffer.get_allocation())?;

        let pixel_count = (render_size[0] * render_size[1]) as usize;
        let result_data = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr().cast_const(),
                pixel_count * 4,
            )
        };

        let result = if self.cubemap {
            // The first pass draws pure red on the faces and the second pass redraws them with pure blue.
            // Sampling anywhere should produce colors with a 0.0 red component and > 0.0 blue and alpha components.
            result_data
                .chunks_exact(4)
                .all(|val| val[0] == 0 && val[2] > 0 && val[3] > 0)
        } else {
            // Each test case should render pure blue as the result.
            let expected = [0u8, 0, 255, 255];
            result_data.chunks_exact(4).all(|val| {
                val.iter()
                    .zip(&expected)
                    .all(|(&got, &want)| (f32::from(got) - f32::from(want)).abs() / 255.0 <= 0.01)
            })
        };

        if result {
            Ok(TestStatus::pass("pass"))
        } else {
            Ok(TestStatus::fail("fail"))
        }
    }
}

/// `createImageSampleDrawnTextureTests`
pub fn create_image_sample_drawn_texture_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("sample_texture");

    let bc3 = vk::Format::BC3_UNORM_BLOCK;
    let bc1 = vk::Format::BC1_RGB_UNORM_BLOCK;
    let cases = [
        (
            "128_bit_compressed_format_cubemap",
            bc3,
            vk::Format::R32G32B32A32_UINT,
            false,
            true,
        ),
        (
            "64_bit_compressed_format_cubemap",
            bc1,
            vk::Format::R32G32_UINT,
            false,
            true,
        ),
        (
            "64_bit_compressed_format_two_samplers_cubemap",
            bc1,
            vk::Format::R32G32_UINT,
            true,
            true,
        ),
        (
            "128_bit_compressed_format_two_samplers_cubemap",
            bc3,
            vk::Format::R32G32B32A32_UINT,
            true,
            true,
        ),
        ("64_bit_compressed_format", bc1, vk::Format::R32G32_UINT, false, false),
        (
            "64_bit_compressed_format_two_samplers",
            bc1,
            vk::Format::R32G32_UINT,
            true,
            false,
        ),
        (
            "128_bit_compressed_format",
            bc3,
            vk::Format::R32G32B32A32_UINT,
            false,
            false,
        ),
        (
            "128_bit_compressed_format_two_samplers",
            bc3,
            vk::Format::R32G32B32A32_UINT,
            true,
            false,
        ),
    ];
    for (name, image_format, image_view_format, two_samplers, cubemap) in cases {
        test_group.add_child(Box::new(SampleDrawnTextureTest {
            name,
            image_format,
            image_view_format,
            two_samplers,
            cubemap,
        }) as Box<dyn TestCase>);
    }

    test_group
}
