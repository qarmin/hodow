// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageSampleDrawnCubeFaceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/image_sample_drawn_cube_face.toml.
// The result is read straight from the readback buffer rather than through the `tcu::copy` into a `TextureLevel` upstream
// logs as an image.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::image_sample_drawn_cube_face::SAMPLE_CUBEMAP_PROGRAMS;
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

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `makeImageCreateInfo`
fn make_image_create_info(size: [u32; 3], format: vk::Format, cubemap: bool) -> vk::ImageCreateInfo {
    let usage = vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::INPUT_ATTACHMENT
        | vk::ImageUsageFlags::SAMPLED;
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: if cubemap {
            vk::ImageCreateFlags::CUBE_COMPATIBLE
        } else {
            vk::ImageCreateFlags::empty()
        },
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: size[0],
            height: size[1],
            depth: 1,
        },
        mip_levels: 1,
        array_layers: if cubemap { 6 } else { 1 },
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
        make_buffer_create_info(1024, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// `makeSampler`
fn make_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::LINEAR)
        .min_filter(vk::Filter::LINEAR)
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

/// `genFullQuadVertices` - draw a quad covering the whole framebuffer
fn gen_full_quad_vertices() -> Vec<[f32; 4]> {
    vec![
        [-1.0, -1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
    ]
}

/// `Vertex`
#[repr(C)]
#[derive(Clone, Copy)]
struct Vertex {
    vertices: [f32; 4],
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
            offset: std::mem::offset_of!(Vertex, vertices) as u32,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: std::mem::offset_of!(Vertex, uv) as u32,
        },
    ]
}

/// `genTextureCoordinates`
fn gen_texture_coordinates() -> Vec<Vertex> {
    vec![
        Vertex {
            vertices: [-1.0, -1.0, 0.0, 1.0],
            uv: [0.0, 0.0],
        },
        Vertex {
            vertices: [1.0, -1.0, 0.0, 1.0],
            uv: [1.0, 0.0],
        },
        Vertex {
            vertices: [-1.0, 1.0, 0.0, 1.0],
            uv: [0.0, 1.0],
        },
        Vertex {
            vertices: [1.0, -1.0, 0.0, 1.0],
            uv: [1.0, 0.0],
        },
        Vertex {
            vertices: [1.0, 1.0, 0.0, 1.0],
            uv: [1.0, 1.0],
        },
        Vertex {
            vertices: [-1.0, 1.0, 0.0, 1.0],
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
    state
}

struct SampleDrawnCubeFaceTest {
    size: [u32; 2],
    format: vk::Format,
}

impl TestCase for SampleDrawnCubeFaceTest {
    fn name(&self) -> &str {
        "write_face_0"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SAMPLE_CUBEMAP_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleDrawnCubeFaceTestInstance {
            context,
            size: self.size,
            format: self.format,
        })
    }
}

struct SampleDrawnCubeFaceTestInstance<'a> {
    context: &'a Context<'a>,
    size: [u32; 2],
    format: vk::Format,
}

impl TestInstance for SampleDrawnCubeFaceTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        debug_assert!(self.format == vk::Format::R8G8B8A8_UNORM);

        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let buffer_size: vk::DeviceSize = 1024;

        let layer_start = 0u32;
        let layer_count = 6u32;
        let level_count = 1u32;

        let image_size = [self.size[0], self.size[1], layer_count];
        let render_size = self.size;
        let _render_area = make_rect_2d(0, 0, self.size[0], self.size[1]);

        let vertices = gen_full_quad_vertices();
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

        // Create a cubemap image
        let cubemap_subresource_range =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, level_count, layer_start, layer_count);
        let cubemap_image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(image_size, self.format, true),
            MemoryRequirement::ANY,
        )?;
        let cubemap_image_view = make_image_view(
            vk,
            cubemap_image.get(),
            vk::ImageViewType::CUBE,
            self.format,
            cubemap_subresource_range,
        )?;

        // Create a sampler for the cubemap and bind it
        let sampled_image_view = make_image_view(
            vk,
            cubemap_image.get(),
            vk::ImageViewType::CUBE,
            self.format,
            cubemap_subresource_range,
        )?;
        let cubemap_sampler = make_sampler(vk)?;
        let descriptor_image_info = [vk::DescriptorImageInfo {
            sampler: *cubemap_sampler,
            image_view: *sampled_image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_sampler_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &[*cubemap_sampler],
            )
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(&descriptor_image_info)
            .build();
        unsafe { vk.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // Generate texture coordinates for the sampler
        let uv_coordinates = gen_texture_coordinates();
        let uv_buffer = make_vertex_buffer(vk, allocator)?;
        let uv_buffer_offset: vk::DeviceSize = 0;

        unsafe {
            std::ptr::copy_nonoverlapping(
                uv_coordinates.as_ptr().cast::<u8>(),
                uv_buffer.get_allocation().get_host_ptr(),
                uv_coordinates.len() * std::mem::size_of::<Vertex>(),
            )
        };
        flush_alloc(vk, uv_buffer.get_allocation())?;

        // Sampled values will be written to this image
        let target_subresource_range =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, level_count, layer_start, 1);
        let target_image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(image_size, self.format, false),
            MemoryRequirement::ANY,
        )?;
        let target_image_view = make_image_view(
            vk,
            target_image.get(),
            vk::ImageViewType::_2D,
            self.format,
            target_subresource_range,
        )?;

        // We use a push constant to hold count for how many times the shader has written to the cubemap
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        }];

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Create two graphic pipelines. One for writing to the cubemap and the other for sampling it
        let render_pass1 = make_color_render_pass(
            vk,
            self.format,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;

        let framebuffer1 = make_framebuffer(
            vk,
            *render_pass1,
            &[*cubemap_image_view],
            render_size[0],
            render_size[1],
            1,
        )?;

        let binaries = self.context.get_binary_collection();
        let vertex_module1 = create_shader_module(vk, binaries.get("vert1")?)?;
        let fragment_module1 = create_shader_module(vk, binaries.get("frag1")?)?;

        let pipeline_layout1_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout1 = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&pipeline_layout1_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let mut state1 = pipeline_state(render_size[0], render_size[1]);
        state1.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state1.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let graphics_pipeline1 = create_draw_pipeline(
            vk,
            *pipeline_layout1,
            *render_pass1,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module1),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module1),
            ],
            &state1,
        )?;

        let render_pass2 = make_color_render_pass(
            vk,
            self.format,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;

        let framebuffer2 = make_framebuffer(
            vk,
            *render_pass2,
            &[*target_image_view],
            render_size[0],
            render_size[1],
            1,
        )?;

        let vertex_module2 = create_shader_module(vk, binaries.get("vert2")?)?;
        let fragment_module2 = create_shader_module(vk, binaries.get("frag2")?)?;

        let pipeline_layout2_info =
            vk::PipelineLayoutCreateInfo::builder().set_layouts(std::slice::from_ref(&*descriptor_set_layout));
        let pipeline_layout2 = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&pipeline_layout2_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let mut state2 = pipeline_state(render_size[0], render_size[1]);
        state2.bindings = vec![vertex_binding_description()];
        state2.attributes = vertex_attribute_descriptions();
        let graphics_pipeline2 = create_draw_pipeline(
            vk,
            *pipeline_layout2,
            *render_pass2,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module2),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module2),
            ],
            &state2,
        )?;

        // The values sampled in the second pipeline will be copied to this buffer
        let result_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Clear the cubemap faces and the target image as black
        let clear_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        };

        clear_color_image(
            vk,
            queue,
            queue_family_index,
            cubemap_image.get(),
            clear_color,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            0,
            layer_count,
        )?;

        clear_color_image(
            vk,
            queue,
            queue_family_index,
            target_image.get(),
            clear_color,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            0,
            1,
        )?;

        // Run the shaders twice
        begin_command_buffer(vk, cmd)?;

        unsafe {
            vk.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout2,
                0,
                &[*descriptor_set],
                &[],
            )
        };

        let no_clear = vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        };

        for pass in 0..2i32 {
            // Draw on the first cube map face
            unsafe {
                vk.cmd_push_constants(
                    cmd,
                    *pipeline_layout1,
                    vk::ShaderStageFlags::FRAGMENT,
                    0,
                    &pass.to_ne_bytes(),
                );
                vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline1);
                vk.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
            }

            begin_render_pass(
                vk,
                cmd,
                *render_pass1,
                *framebuffer1,
                make_rect_2d(0, 0, image_size[0], image_size[1]),
                no_clear,
            );
            unsafe { vk.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0) };
            end_render_pass(vk, cmd);

            {
                let barrier = make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    cubemap_image.get(),
                    cubemap_subresource_range,
                );
                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[barrier],
                    );
                }
            }

            // Sample the four faces around the first face
            unsafe {
                vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline2);
                vk.cmd_bind_vertex_buffers(cmd, 0, &[uv_buffer.get()], &[uv_buffer_offset]);
            }

            begin_render_pass(
                vk,
                cmd,
                *render_pass2,
                *framebuffer2,
                make_rect_2d(0, 0, image_size[0], image_size[1]),
                no_clear,
            );
            unsafe { vk.cmd_draw(cmd, 6, 1, 0, 0) };
            end_render_pass(vk, cmd);

            if pass == 0 {
                let barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    cubemap_image.get(),
                    cubemap_subresource_range,
                );
                let barrier2 = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    target_image.get(),
                    target_subresource_range,
                );
                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[barrier],
                    );
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[barrier2],
                    );
                }
            }
        }

        // Read the result buffer data
        copy_image_to_buffer(
            vk,
            cmd,
            target_image.get(),
            result_buffer.get(),
            (self.size[0], self.size[1]),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        );

        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;

        invalidate_alloc(vk, result_buffer.get_allocation())?;

        let pixel_size = 4usize;
        let result_data = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr().cast_const(),
                render_size[0] as usize * render_size[1] as usize * pixel_size,
            )
        };

        let mut result = true;

        // The first run writes pure red and the second pure blue hence the value of the red component should be 0.0
        // and the value in the green channel > 0.0
        for y in 0..render_size[1] as usize {
            let offset = (y * render_size[0] as usize + (render_size[0] as usize - 1)) * pixel_size;
            let val = [
                result_data[offset],
                result_data[offset + 1],
                result_data[offset + 2],
                result_data[offset + 3],
            ];
            if !(val[0] == 0 && val[1] > 0) {
                result = false;
            }
        }

        if result {
            Ok(TestStatus::pass("pass"))
        } else {
            Ok(TestStatus::fail("fail"))
        }
    }
}

/// `createImageSampleDrawnCubeFaceTests`
pub fn create_image_sample_drawn_cube_face_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("sample_cubemap");

    test_group.add_child(Box::new(SampleDrawnCubeFaceTest {
        size: [8, 8],
        format: FORMAT,
    }) as Box<dyn TestCase>);

    test_group
}
