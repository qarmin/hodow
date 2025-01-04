// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureConversionTests.cpp (populateSnormClampTests)
//   external/vulkancts/data/vulkan/amber/texture/conversion/snorm_clamp/*.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, the thirteen amber scripts as one test over a table. Each script samples a one texel 1D texture holding the
// smallest SNORM value in every component and draws a 32x32 rect: the fragment shader writes green when the first N components are exactly -1.0 (the
// shader is in the `texture_swizzle` manifest, scripts/gen_texture_swizzle_manifest.py). The rect is drawn as two triangles of a vertex buffer, amber's
// `PASSTHROUGH` vertex shader and `DRAW_RECT`.

use vulkanalia::prelude::v1_0::*;

use super::test_util::{
    Program, QUAD_POSITIONS, RenderRequest, SamplerParams, ShaderParameters, TexKind, render_quad_2d,
};
use crate::generated::shaders::texture_swizzle::{
    TSW_2D_FLOAT_RGBA32F, TSW_SNORM_CLAMP_1, TSW_SNORM_CLAMP_2, TSW_SNORM_CLAMP_3, TSW_SNORM_CLAMP_4,
};
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, SamplerType, TextureType, compute_quad_tex_coord_2d, compute_texture_lookup_diff_2d,
    sample_texture_2d,
};
use crate::tcu::pixel::{
    CompareMode, ConstPixelBufferAccess, FilterMode, PixelBufferAccess, Sampler, WrapMode, get_texture_format_bit_depth,
};
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::texture_2d::Texture2D as RefTexture2D;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::image_util::create_test_texture;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FRAMEBUFFER_SIZE: u32 = 32;

/// What the script fills the texel with: the smallest value in every component, or the packed word for a packed format
#[derive(Clone, Copy)]
enum Fill {
    I8,
    I16,
    Packed(u32),
}

#[derive(Clone, Copy)]
struct SnormClampParameters {
    name: &'static str,
    format: vk::Format,
    /// the components the fragment shader checks
    components: usize,
    /// the components the format stores
    stored: usize,
    fill: Fill,
}

const fn case(
    name: &'static str,
    format: vk::Format,
    components: usize,
    stored: usize,
    fill: Fill,
) -> SnormClampParameters {
    SnormClampParameters {
        name,
        format,
        components,
        stored,
        fill,
    }
}

const CASES: &[SnormClampParameters] = &[
    case(
        "a2b10g10r10_snorm_pack32",
        vk::Format::A2B10G10R10_SNORM_PACK32,
        4,
        1,
        Fill::Packed(2_684_879_360),
    ),
    case(
        "a2r10g10b10_snorm_pack32",
        vk::Format::A2R10G10B10_SNORM_PACK32,
        4,
        1,
        Fill::Packed(2_684_879_360),
    ),
    case(
        "a8b8g8r8_snorm_pack32",
        vk::Format::A8B8G8R8_SNORM_PACK32,
        4,
        1,
        Fill::Packed(2_155_905_152),
    ),
    case("b8g8r8a8_snorm", vk::Format::B8G8R8A8_SNORM, 4, 4, Fill::I8),
    case("b8g8r8_snorm", vk::Format::B8G8R8_SNORM, 3, 3, Fill::I8),
    case("r16g16b16a16_snorm", vk::Format::R16G16B16A16_SNORM, 4, 4, Fill::I16),
    case("r16g16b16_snorm", vk::Format::R16G16B16_SNORM, 3, 3, Fill::I16),
    case("r16g16_snorm", vk::Format::R16G16_SNORM, 2, 2, Fill::I16),
    case("r16_snorm", vk::Format::R16_SNORM, 1, 1, Fill::I16),
    case("r8g8b8a8_snorm", vk::Format::R8G8B8A8_SNORM, 4, 4, Fill::I8),
    case("r8g8b8_snorm", vk::Format::R8G8B8_SNORM, 3, 3, Fill::I8),
    case("r8g8_snorm", vk::Format::R8G8_SNORM, 2, 2, Fill::I8),
    case("r8_snorm", vk::Format::R8_SNORM, 1, 1, Fill::I8),
];

impl SnormClampParameters {
    fn texel_bytes(&self) -> Vec<u8> {
        match self.fill {
            Fill::I8 => vec![0x80; self.stored],
            Fill::I16 => (0..self.stored).flat_map(|_| i16::MIN.to_le_bytes()).collect(),
            Fill::Packed(word) => word.to_le_bytes().to_vec(),
        }
    }
}

struct SnormClampCase {
    params: SnormClampParameters,
}

impl TestCase for SnormClampCase {
    fn name(&self) -> &str {
        self.params.name
    }

    /// The image requirement of the script: a 1D image of the format that can be sampled and transferred
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let usage =
            vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED;
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.params.format,
                vk::ImageType::_1D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        match properties {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => Err(TestError::NotSupported(format!(
                "Format not supported: {:?}",
                self.params.format
            ))),
            other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties").map(|_| ()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.components {
            1 => TSW_SNORM_CLAMP_1.programs,
            2 => TSW_SNORM_CLAMP_2.programs,
            3 => TSW_SNORM_CLAMP_3.programs,
            _ => TSW_SNORM_CLAMP_4.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SnormClampInstance {
            context,
            params: self.params,
        })
    }
}

struct SnormClampInstance<'a> {
    context: &'a Context<'a>,
    params: SnormClampParameters,
}

impl TestInstance for SnormClampInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let binaries = context.get_binary_collection();

        // The one texel texture, uploaded through a staging buffer
        let texel = params.texel_bytes();
        let texture_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_1D)
            .format(params.format)
            .extent(vk::Extent3D {
                width: 1,
                height: 1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let texture_image = ImageWithMemory::new(device, allocator, texture_info, MemoryRequirement::ANY)?;
        let texture_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let texture_view = make_image_view(
            device,
            texture_image.get(),
            vk::ImageViewType::_1D,
            params.format,
            texture_range,
        )?;
        let staging = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(texel.len() as u64, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(texel.as_ptr(), staging.get_allocation().get_host_ptr(), texel.len()) };
        flush_alloc(device, staging.get_allocation())?;

        let command_pool = make_command_pool(device, queue_family_index)?;
        {
            let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *command_buffer;
            begin_command_buffer(device, cmd)?;
            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                texture_image.get(),
                texture_range,
            );
            let to_sampled = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                texture_image.get(),
                texture_range,
            );
            let region = make_buffer_image_copy(
                vk::Extent3D {
                    width: 1,
                    height: 1,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
                device.cmd_copy_buffer_to_image(
                    cmd,
                    staging.get(),
                    texture_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_sampled],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Amber's default sampler: nearest filtering, repeat addressing
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .max_anisotropy(1.0)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(1.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let image_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *texture_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(std::slice::from_ref(&image_info))
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        // The framebuffer
        let color_format = vk::Format::B8G8R8A8_UNORM;
        let color_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk::Extent3D {
                width: FRAMEBUFFER_SIZE,
                height: FRAMEBUFFER_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, color_info, MemoryRequirement::ANY)?;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_range,
        )?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view],
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
            1,
        )?;
        let result_size = u64::from(FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE * 4);
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // DRAW_RECT over the whole framebuffer: two triangles in normalized device coordinates
        let rect: [f32; 24] = [
            -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0,
            1.0, 1.0, 0.0, 1.0,
        ];
        let rect_bytes: Vec<u8> = rect.iter().flat_map(|value| value.to_ne_bytes()).collect();
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(rect_bytes.len() as u64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                rect_bytes.as_ptr(),
                vertex_buffer.get_allocation().get_host_ptr(),
                rect_bytes.len(),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
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
        state.viewports = vec![vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: FRAMEBUFFER_SIZE as f32,
            height: FRAMEBUFFER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        state.scissors = vec![make_rect_2d(0, 0, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE)];
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;
        let initialize_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_image.get(),
            color_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[initialize_barrier],
            );
        }
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE),
            clear_value_color([0.0, 0.0, 0.0, 0.0]),
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*set],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, 6, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        copy_image_to_buffer(
            device,
            cmd,
            color_image.get(),
            result_buffer.get(),
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // EXPECT framebuffer IDX 0 0 SIZE 32 32 EQ_RGBA 0 255 0 255 (the framebuffer is B8G8R8A8)
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let pixels =
            unsafe { std::slice::from_raw_parts(result_buffer.get_allocation().get_host_ptr(), result_size as usize) };
        let wrong = pixels
            .chunks_exact(4)
            .filter(|pixel| *pixel != [0u8, 255, 0, 255])
            .count();
        if wrong != 0 {
            log::info!("{wrong} pixels are not green");
            return Ok(TestStatus::fail("Probe failed"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `SnormLinearClampInstance::lim`
fn lim(format: TextureFormat, channel: usize) -> i32 {
    let bits = get_texture_format_bit_depth(format)[channel];
    if bits != 0 { -((1i32 << (bits - 1)) - 1) } else { -1 }
}

/// `getNumUsedChannels`
fn used_channels(order: ChannelOrder) -> usize {
    match order {
        ChannelOrder::R
        | ChannelOrder::A
        | ChannelOrder::I
        | ChannelOrder::L
        | ChannelOrder::sR
        | ChannelOrder::D
        | ChannelOrder::S => 1,
        ChannelOrder::RG | ChannelOrder::RA | ChannelOrder::LA | ChannelOrder::sRG => 2,
        ChannelOrder::RGB | ChannelOrder::BGR | ChannelOrder::sRGB | ChannelOrder::sBGR => 3,
        _ => 4,
    }
}

#[derive(Clone, Copy)]
struct SnormLinearParameters {
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    name: &'static str,
    format: vk::Format,
    width: u32,
    height: u32,
    use_compute: bool,
}

struct SnormLinearCase {
    name: String,
    params: SnormLinearParameters,
}

impl TestCase for SnormLinearCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.params.format)
        };
        if !properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR)
        {
            return Err(TestError::NotSupported(
                "Linear filtering for this image format is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        TSW_2D_FLOAT_RGBA32F.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SnormLinearInstance {
            context,
            params: self.params,
        })
    }
}

struct SnormLinearInstance<'a> {
    context: &'a Context<'a>,
    params: SnormLinearParameters,
}

impl TestInstance for SnormLinearInstance<'_> {
    /// `SnormLinearClampInstance`'s constructor, `iterate` and `verifyPixels`
    fn iterate(&mut self) -> TestOutcome {
        const TEXTURE_WIDTH: u32 = 7;
        const TEXTURE_HEIGHT: u32 = 7;
        let context = self.context;
        let params = self.params;
        let in_format = map_vk_format(params.format)
            .ok_or_else(|| TestError::NotPorted(format!("no texture format for {:?}", params.format)))?;
        let result_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);

        // computeColorDistance
        let distance = ((-lim(in_format, 0)) as f32 / 127.0).floor() as i32;
        let cd = [distance; 4];
        let a = [
            lim(in_format, 0),
            lim(in_format, 1) + cd[1] * 2,
            lim(in_format, 2),
            lim(in_format, 3) + cd[3] * 2,
        ];
        let b = [
            lim(in_format, 0) + cd[0] * 2,
            lim(in_format, 1),
            lim(in_format, 2) + cd[2] * 2,
            lim(in_format, 3),
        ];
        let c = [
            lim(in_format, 0) + cd[0],
            lim(in_format, 1) + cd[1],
            lim(in_format, 2) + cd[2],
            lim(in_format, 3) + cd[3],
        ];
        let d = [
            lim(in_format, 0),
            lim(in_format, 1),
            lim(in_format, 2),
            lim(in_format, 3),
        ];
        let data = [
            a, b, c, d, c, b, a, b, a, c, d, c, a, b, c, c, c, d, c, c, c, d, d, d, c, d, d, d, c, c, c, d, c, c, c, b,
            a, c, d, c, a, b, a, b, c, d, c, b, a,
        ];

        let mut hw_texture = create_test_texture(
            params.format,
            vk::ImageViewType::_2D,
            [TEXTURE_WIDTH as i32, TEXTURE_HEIGHT as i32, 1],
            1,
        )?;
        let mut sw_texture = RefTexture2D::new(in_format, TEXTURE_WIDTH, TEXTURE_HEIGHT);
        sw_texture.alloc_level(0);
        for y in 0..TEXTURE_HEIGHT {
            for x in 0..TEXTURE_WIDTH {
                let color = data[(y * TEXTURE_WIDTH + x) as usize];
                let _ = sw_texture.level_mut(0).set_pixel_int(color, x, y, 0);
                let _ = hw_texture.get_level_mut(0, 0).set_pixel_int(color, x, y, 0);
            }
        }

        // Setup sampler params.
        let tcu_sampler = Sampler {
            wrap_s: WrapMode::Repeat,
            wrap_t: WrapMode::Repeat,
            wrap_r: WrapMode::Repeat,
            filter: FilterMode::Linear,
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        };
        let mut sampler_params = ReferenceParams::new(TextureType::Texture2D, tcu_sampler, LodMode::Exact);
        sampler_params.mag_filter = Some(FilterMode::Linear);
        sampler_params.base.sampler_type = SamplerType::Float;

        // Compute texture coordinates.
        let tex_coord = compute_quad_tex_coord_2d(crate::tcu::Vec2::new(0.0, 0.0), crate::tcu::Vec2::new(1.0, 1.0));

        // Perform online rendering with Vulkan.
        let sampler = SamplerParams {
            wrap_u: vk::SamplerAddressMode::REPEAT,
            wrap_v: vk::SamplerAddressMode::REPEAT,
            wrap_w: vk::SamplerAddressMode::REPEAT,
            min_filter: vk::Filter::LINEAR,
            mag_filter: vk::Filter::LINEAR,
            mipmap_mode: vk::SamplerMipmapMode::NEAREST,
            min_lod: 0.0,
            max_lod: 0.25,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };
        let request = RenderRequest {
            texture: &hw_texture,
            format: params.format,
            aspect_mask: vk::ImageAspectFlags::COLOR,
            component_mapping: vk::ComponentMapping {
                r: vk::ComponentSwizzle::R,
                g: vk::ComponentSwizzle::G,
                b: vk::ComponentSwizzle::B,
                a: vk::ComponentSwizzle::A,
            },
            use_compute: params.use_compute,
            sparse: false,
            width: params.width,
            height: params.height,
            tex_width: TEXTURE_WIDTH,
            tex_height: TEXTURE_HEIGHT,
            tex_depth: 1,
            kind: TexKind::D2,
            sampler,
            tex_coord: &tex_coord,
            positions: QUAD_POSITIONS,
            view_levels: None,
            view_min_lod: None,
            output_format: vk::Format::R32G32B32A32_SFLOAT,
            program: Program::Float2D,
            parameters: ShaderParameters {
                bias: 0.0,
                reference: 0.0,
                color_scale: [1.0; 4],
                color_bias: [0.0; 4],
                lod: 0,
            },
        };
        let rendered = render_quad_2d(context, &request, context.get_binary_collection())?;

        // Perform offline rendering with the software renderer.
        let (width, height) = (params.width, params.height);
        let mut reference_data = vec![0u8; (width * height * 16) as usize];
        let level0 = sw_texture.level(0);
        {
            let mut reference = PixelBufferAccess::new(result_format, [width, height, 1], &mut reference_data);
            sample_texture_2d(&mut reference, &[level0], tex_coord, &sampler_params);
        }

        // verifyPixels
        let used = used_channels(in_format.order);
        let lookup_precision = LookupPrecision {
            uvw_bits: [5, 5, 0],
            coord_bits: [20, 20, 0],
            color_mask: [used >= 1, used >= 2, used >= 3, used >= 4],
            color_threshold: std::array::from_fn(|ndx| 0.9 / cd[ndx] as f32),
            ..LookupPrecision::default()
        };
        let lod_precision = LodPrecision {
            derivate_bits: 18,
            lod_bits: 5,
        };
        let mut error_mask_data = vec![0u8; (width * height * 16) as usize];
        let num_failed_pixels = {
            let result_access = ConstPixelBufferAccess::new(result_format, [width, height, 1], &rendered);
            let reference_access = ConstPixelBufferAccess::new(result_format, [width, height, 1], &reference_data);
            let mut error_mask = PixelBufferAccess::new(result_format, [width, height, 1], &mut error_mask_data);
            compute_texture_lookup_diff_2d(
                &result_access,
                &reference_access,
                &mut error_mask,
                &[sw_texture.level(0)],
                tex_coord,
                &sampler_params,
                &lookup_precision,
                &lod_precision,
            )
        };
        if num_failed_pixels != 0 {
            log::info!(
                "ERROR: Result verification failed, got {num_failed_pixels} invalid pixels! ({}% of {} pixels)",
                (num_failed_pixels * 100) as f32 / (width * height) as f32,
                width * height
            );
        }
        let out_of_range = rendered
            .chunks_exact(4)
            .map(|bytes| f32::from_le_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]))
            .filter(|value| !(-1.0..=1.0).contains(value))
            .count();
        if out_of_range != 0 {
            log::info!("ERROR: Found {out_of_range} components out of range [-1.0f, +1.0f].");
        }
        Ok(if num_failed_pixels == 0 && out_of_range == 0 {
            TestStatus::pass("")
        } else {
            TestStatus::fail("Pixels verification failed")
        })
    }
}

/// `populateSnormLinearClampTests`
fn create_snorm_linear_clamp_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("snorm_clamp_linear");
    let mut size_multiplier = 20;
    for &SnormClampParameters { name, format, .. } in CASES {
        let (width, height) = (7 * size_multiplier, 7 * size_multiplier);
        let mut params = SnormLinearParameters {
            name,
            format,
            width,
            height,
            use_compute: false,
        };
        group.add_child(Box::new(SnormLinearCase {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>);

        // Compute case.
        params.use_compute = true;
        group.add_child(Box::new(SnormLinearCase {
            name: format!("{name}_compute"),
            params,
        }) as Box<dyn TestCase>);
        size_multiplier += 2;
    }
    group
}

/// `populateSnormClampTests`, below `conversion`
pub fn create_conversion_tests() -> TestCaseGroup {
    let mut snorm_clamp = TestCaseGroup::new("snorm_clamp");
    for &params in CASES {
        snorm_clamp.add_child(Box::new(SnormClampCase { params }) as Box<dyn TestCase>);
    }
    let mut conversion = TestCaseGroup::new("conversion");
    conversion.add_child(snorm_clamp);
    conversion.add_child(create_snorm_linear_clamp_tests());
    conversion.add_child(super::misc_amber_tests::create_ufloat_negative_values_group());
    conversion
}
