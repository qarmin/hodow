// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/texture/texel_buffer/uniform/{packed,snorm,srgb}/*.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber graphics pipeline does for these scripts is done directly: a B8G8R8A8_UNORM colour attachment
// of the script's `FRAMEBUFFER_SIZE` cleared to its `CLEAR_COLOR`, one draw of the two triangles that cover `DRAW_RECT`, a uniform texel buffer of the
// script's data at binding 0 (and, in the `srgb` scripts, a combined image sampler of the same data at binding 0 with the texel buffer at binding 1), and
// the `EXPECT framebuffer` lines. The scripts are read by `scripts/gen_texel_buffer_amber.py`, which writes the shaders (`shaders/manifest/texture_texel_buffer.toml`)
// and `texel_buffer_cases.rs`.

use vulkanalia::prelude::v1_0::*;

use super::texel_buffer_cases::TEXEL_BUFFER_CASES;
use crate::generated::shaders::texture_texel_buffer::ALL_SHARED_PROGRAM;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `EXPECT framebuffer IDX x y SIZE w h EQ_RGBA r g b a [TOLERANCE t]`
pub struct Expectation {
    pub x: u32,
    pub y: u32,
    pub width: u32,
    pub height: u32,
    pub rgba: [u8; 4],
    pub tolerance: u8,
}

/// One Amber script of `texture.texel_buffer.uniform`
pub struct TexelBufferCase {
    pub group: &'static str,
    pub name: &'static str,
    pub key: &'static str,
    pub format: vk::Format,
    pub data: &'static [u8],
    pub size: (u32, u32),
    pub clear: [u8; 4],
    pub rect: (u32, u32, u32, u32),
    /// The `srgb` scripts: the same data also as a texture, compared with the texel buffer in the shader
    pub reference_texture: bool,
    pub expectations: &'static [Expectation],
}

const FRAMEBUFFER_FORMAT: vk::Format = vk::Format::B8G8R8A8_UNORM;

struct TexelBufferTestCase {
    data: &'static TexelBufferCase,
}

impl TestCase for TexelBufferTestCase {
    fn name(&self) -> &str {
        self.data.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.data.format)
        };
        if !properties
            .buffer_features
            .contains(vk::FormatFeatureFlags::UNIFORM_TEXEL_BUFFER)
        {
            return Err(TestError::NotSupported(format!(
                "{:?} is not supported as a uniform texel buffer",
                self.data.format
            )));
        }
        if self.data.reference_texture
            && !properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE)
        {
            return Err(TestError::NotSupported(format!(
                "{:?} is not supported as a sampled image",
                self.data.format
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.data.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TexelBufferInstance {
            context,
            data: self.data,
        })
    }
}

struct TexelBufferInstance<'a> {
    context: &'a Context<'a>,
    data: &'static TexelBufferCase,
}

fn host_buffer_with<'a>(
    context: &'a Context<'_>,
    bytes: &[u8],
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(bytes.len().max(1) as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(context.get_device(), buffer.get_allocation())?;
    Ok(buffer)
}

fn float_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

impl TestInstance for TexelBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let (width, height) = data.size;

        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(width as i32, height as i32),
                FRAMEBUFFER_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            FRAMEBUFFER_FORMAT,
            color_range,
        )?;
        let render_pass = make_render_pass(device, FRAMEBUFFER_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], width, height, 1)?;

        // The texel buffer, binding 0 or (with the reference texture) binding 1
        let texel_buffer = host_buffer_with(context, data.data, vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER)?;
        let view_info = vk::BufferViewCreateInfo::builder()
            .buffer(texel_buffer.get())
            .format(data.format)
            .offset(0)
            .range(vk::WHOLE_SIZE);
        let buffer_view = Unique::new(
            device,
            unsafe { device.create_buffer_view(&view_info, None) }.vk_check("vkCreateBufferView")?,
        );

        // The reference texture of the srgb scripts: width x height texels of the same data, one sampler of nearest filtering and repeat addressing
        let mut texture = None;
        if data.reference_texture {
            let texel_size = map_vk_format(data.format)
                .and_then(|format| format.pixel_size())
                .map_or(data.data.len() / (width * height) as usize, |size| size as usize);
            let mut bytes = data.data.to_vec();
            bytes.resize(texel_size * (width * height) as usize, 0);

            let image = ImageWithMemory::new(
                device,
                allocator,
                make_image_create_info(
                    IVec2::new(width as i32, height as i32),
                    data.format,
                    vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::ANY,
            )?;
            let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, data.format, color_range)?;
            let staging = host_buffer_with(context, &bytes, vk::BufferUsageFlags::TRANSFER_SRC)?;

            let upload_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let upload_buffer = allocate_command_buffer(device, *upload_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *upload_buffer;
            begin_command_buffer(device, cmd)?;
            unsafe {
                let to_transfer = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image.get(),
                    color_range,
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
                let copy = vk::BufferImageCopy {
                    buffer_offset: 0,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level: 0,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width,
                        height,
                        depth: 1,
                    },
                };
                device.cmd_copy_buffer_to_image(
                    cmd,
                    staging.get(),
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[copy],
                );
                let to_shader = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    image.get(),
                    color_range,
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_shader],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

            let sampler_info = vk::SamplerCreateInfo::builder()
                .mag_filter(vk::Filter::NEAREST)
                .min_filter(vk::Filter::NEAREST)
                .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
                .address_mode_u(vk::SamplerAddressMode::REPEAT)
                .address_mode_v(vk::SamplerAddressMode::REPEAT)
                .address_mode_w(vk::SamplerAddressMode::REPEAT)
                .max_lod(0.0);
            let sampler = Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            );
            texture = Some((sampler, view, image, staging));
        }

        // Descriptors
        let texel_binding = if data.reference_texture { 1 } else { 0 };
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        let mut pool_builder = DescriptorPoolBuilder::new();
        if data.reference_texture {
            layout_builder = layout_builder.add_indexed_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::ALL,
                0,
                1,
            );
            pool_builder = pool_builder.add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1);
        }
        layout_builder = layout_builder.add_indexed_binding(
            vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
            vk::ShaderStageFlags::ALL,
            texel_binding,
            1,
        );
        pool_builder = pool_builder.add_type(vk::DescriptorType::UNIFORM_TEXEL_BUFFER, 1);
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let texel_views = [*buffer_view];
        let mut writes = vec![vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: texel_binding,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: std::ptr::null(),
            texel_buffer_view: texel_views.as_ptr(),
        }];
        let image_infos = texture
            .iter()
            .map(|(sampler, view, _, _)| vk::DescriptorImageInfo {
                sampler: **sampler,
                image_view: **view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            })
            .collect::<Vec<_>>();
        if let Some(image_info) = image_infos.first() {
            writes.push(vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                image_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            });
        }
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // The two triangles that cover DRAW_RECT, in framebuffer coordinates mapped to NDC (y grows downwards in both)
        let (rect_x, rect_y, rect_width, rect_height) = data.rect;
        let ndc_x = |x: u32| 2.0 * x as f32 / width as f32 - 1.0;
        let ndc_y = |y: u32| 2.0 * y as f32 / height as f32 - 1.0;
        let (x0, y0, x1, y1) = (
            ndc_x(rect_x),
            ndc_y(rect_y),
            ndc_x(rect_x + rect_width),
            ndc_y(rect_y + rect_height),
        );
        let positions = [x0, y0, x1, y0, x0, y1, x1, y0, x1, y1, x0, y1];
        let position_buffer = host_buffer_with(context, &float_bytes(&positions), vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let texcoords = [0.0f32, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0];
        let texcoord_buffer = host_buffer_with(context, &float_bytes(&texcoords), vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
        state.color_attachment_count = 1;
        let attribute_count = if data.reference_texture { 2 } else { 1 };
        for location in 0..attribute_count {
            state.bindings.push(vk::VertexInputBindingDescription {
                binding: location,
                stride: 8,
                input_rate: vk::VertexInputRate::VERTEX,
            });
            state.attributes.push(vk::VertexInputAttributeDescription {
                location,
                binding: location,
                format: vk::Format::R32G32_SFLOAT,
                offset: 0,
            });
        }

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let clear = data.clear.map(|channel| f32::from(channel) / 255.0);
        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, width, height),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            let buffers = [position_buffer.get(), texcoord_buffer.get()];
            device.cmd_bind_vertex_buffers(
                cmd,
                0,
                &buffers[..attribute_count as usize],
                &[0, 0][..attribute_count as usize],
            );
            device.cmd_draw(cmd, 6, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_color_attachment(
            context,
            color_image.get(),
            FRAMEBUFFER_FORMAT,
            (width, height),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let pixels = result.data();
        for expectation in data.expectations {
            for y in expectation.y..expectation.y + expectation.height {
                for x in expectation.x..expectation.x + expectation.width {
                    let offset = ((y * width + x) * 4) as usize;
                    // The framebuffer is B8G8R8A8: the bytes are blue, green, red, alpha
                    let actual = [
                        pixels[offset + 2],
                        pixels[offset + 1],
                        pixels[offset],
                        pixels[offset + 3],
                    ];
                    if actual
                        .iter()
                        .zip(expectation.rgba)
                        .any(|(a, e)| a.abs_diff(e) > expectation.tolerance)
                    {
                        log::error!(
                            "Probe failed at ({x}, {y}): expected {:?}, got {actual:?} (tolerance {})",
                            expectation.rgba,
                            expectation.tolerance
                        );
                        return Ok(TestStatus::fail("Probe failed"));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `dEQP-VK.texture.texel_buffer`
pub fn create_texel_buffer_tests() -> TestCaseGroup {
    let mut uniform = TestCaseGroup::new("uniform");
    for group_name in ["packed", "snorm", "srgb"] {
        let mut group = TestCaseGroup::new(group_name);
        for data in TEXEL_BUFFER_CASES.iter().filter(|data| data.group == group_name) {
            group.add_child(Box::new(TexelBufferTestCase { data }) as Box<dyn TestCase>);
        }
        uniform.add_child(group);
    }
    let mut group = TestCaseGroup::new("texel_buffer");
    group.add_child(uniform);
    group
}
