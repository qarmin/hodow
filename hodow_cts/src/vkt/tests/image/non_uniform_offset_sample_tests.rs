// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageNonUniformOffsetSampleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/image_non_uniform_offset_sample.toml. The result is
// compared texel by texel against the byte the host texture holds (red and green within one level of 255, as the 0.005 threshold of
// `floatThresholdCompare` allows, alpha exactly), instead of through `tcu::floatThresholdCompare`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::image_non_uniform_offset_sample::*;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_framebuffer,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FB_SIZE: u32 = 3;
const TRIANGLE_VERTICES: usize = 3;
const IMG_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const PUSH_CONSTANT_SIZE: u32 = 28;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestFunc {
    Texture,
    TexelFetch,
    TextureLod,
    TextureProj,
    TextureProjLod,
}

/// `hasLodArg`
fn has_lod_arg(func: TestFunc) -> bool {
    match func {
        TestFunc::Texture | TestFunc::TextureProj => false,
        TestFunc::TexelFetch | TestFunc::TextureLod | TestFunc::TextureProjLod => true,
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    test_stage: vk::ShaderStageFlags,
    test_function: TestFunc,
    multi_mip: bool,
}

impl TestParams {
    /// `TestParams::getSeed`
    fn get_seed(&self) -> u32 {
        (self.test_stage.bits() << 16) | ((self.test_function as u32) << 8) | self.multi_mip as u32
    }

    fn is_compute(&self) -> bool {
        self.test_stage == vk::ShaderStageFlags::COMPUTE
    }

    fn is_graphics(&self) -> bool {
        !self.is_compute()
    }
}

struct NonUniformOffsetCase {
    name: String,
    params: TestParams,
}

impl TestCase for NonUniformOffsetCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_maintenance8")
    }

    fn programs(&self) -> BinaryCollection {
        let stage = self.params.test_stage;
        let program = match (stage, self.params.test_function) {
            (vk::ShaderStageFlags::VERTEX, TestFunc::Texture) => &NUO_VERT_TEXTURE,
            (vk::ShaderStageFlags::VERTEX, TestFunc::TexelFetch) => &NUO_VERT_TEXEL_FETCH,
            (vk::ShaderStageFlags::VERTEX, TestFunc::TextureLod) => &NUO_VERT_TEXTURE_LOD,
            (vk::ShaderStageFlags::VERTEX, TestFunc::TextureProj) => &NUO_VERT_TEXTURE_PROJ,
            (vk::ShaderStageFlags::VERTEX, TestFunc::TextureProjLod) => &NUO_VERT_TEXTURE_PROJ_LOD,
            (vk::ShaderStageFlags::FRAGMENT, TestFunc::Texture) => &NUO_FRAG_TEXTURE,
            (vk::ShaderStageFlags::FRAGMENT, TestFunc::TexelFetch) => &NUO_FRAG_TEXEL_FETCH,
            (vk::ShaderStageFlags::FRAGMENT, TestFunc::TextureLod) => &NUO_FRAG_TEXTURE_LOD,
            (vk::ShaderStageFlags::FRAGMENT, TestFunc::TextureProj) => &NUO_FRAG_TEXTURE_PROJ,
            (vk::ShaderStageFlags::FRAGMENT, TestFunc::TextureProjLod) => &NUO_FRAG_TEXTURE_PROJ_LOD,
            (_, TestFunc::TexelFetch) => &NUO_COMP_TEXEL_FETCH,
            (_, TestFunc::TextureLod) => &NUO_COMP_TEXTURE_LOD,
            (_, TestFunc::TextureProjLod) => &NUO_COMP_TEXTURE_PROJ_LOD,
            _ => return BinaryCollection::new(&[]),
        };
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NonUniformOffsetInstance {
            context,
            params: self.params,
        })
    }
}

struct NonUniformOffsetInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// One image barrier in a command buffer of its own stage pair (`cmdPipelineImageMemoryBarrier`).
fn image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

/// `vk::copyImageToBuffer` for a storage image left in GENERAL by a compute shader.
fn copy_general_image_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
) {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        range,
    );
    image_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        vk::PipelineStageFlags::TRANSFER,
        to_transfer,
    );
    let region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_host = crate::vk::obj_util::make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_copy_image_to_buffer(cmd, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]);
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
}

/// `tcu::TextureLevel::setPixel` of a `Vec4` into RGBA8 UNORM.
fn to_unorm8(value: f32) -> u8 {
    (value * 255.0 + 0.5).floor() as u8
}

impl TestInstance for NonUniformOffsetInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let fb_extent = vk::Extent3D {
            width: FB_SIZE,
            height: FB_SIZE,
            depth: 1,
        };
        let pixel_count = (FB_SIZE * FB_SIZE) as usize;
        let mip_levels = if params.multi_mip { 4u32 } else { 1 };
        let last_mip_level = mip_levels - 1;
        let tex_extent = vk::Extent3D {
            width: fb_extent.width << last_mip_level,
            height: fb_extent.height << last_mip_level,
            depth: 1,
        };
        let tex_usage = vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST;
        let fb_usage = vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | if params.is_compute() {
                vk::ImageUsageFlags::STORAGE
            } else {
                vk::ImageUsageFlags::COLOR_ATTACHMENT
            };

        // We need to prepare the texture, the sampler, the framebuffer (or storage image), the output verification buffer and the uniform buffer.
        let texture_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(IMG_FORMAT)
            .extent(tex_extent)
            .mip_levels(mip_levels)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(tex_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let tex_img = ImageWithMemory::new(device, allocator, texture_create_info, MemoryRequirement::ANY)?;
        let tex_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, mip_levels, 0, 1);
        let tex_view = make_image_view(device, tex_img.get(), vk::ImageViewType::_2D, IMG_FORMAT, tex_srr)?;
        let tex_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, last_mip_level, 0, 1);

        // Host version of the texture: texel (x, y) is (x / 2, y / 2, 0.5, 1).
        let float_extent = FB_SIZE as f32;
        let mut host_texture: Vec<[u8; 4]> = Vec::with_capacity(pixel_count);
        for y in 0..FB_SIZE {
            for x in 0..FB_SIZE {
                let r = x as f32 / (float_extent - 1.0);
                let g = y as f32 / (float_extent - 1.0);
                host_texture.push([to_unorm8(r), to_unorm8(g), to_unorm8(0.5), to_unorm8(1.0)]);
            }
        }

        // Copy texture data to a host-visible buffer. This will have to be copied to the proper texture mip level later.
        let tex_buffer_bytes: Vec<u8> = host_texture.iter().flatten().copied().collect();
        let tex_buffer = create_host_buffer(context, &tex_buffer_bytes, vk::BufferUsageFlags::TRANSFER_SRC)?;

        let sampler_create_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(0.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod((mip_levels - 1) as f32)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        // Framebuffer (or storage buffer) image, view and buffer.
        let fb_img = ImageWithBuffer::new(context, FB_SIZE, FB_SIZE, IMG_FORMAT, fb_usage, 4)?;
        let fb_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let mut vertices: Vec<[f32; 4]> = Vec::new();
        let mut vertex_buffer = None;
        if params.is_graphics() {
            if params.test_stage == vk::ShaderStageFlags::FRAGMENT {
                // Full-screen quad as a triangle strip.
                vertices.extend_from_slice(&[
                    [-1.0, -1.0, 0.0, 1.0],
                    [-1.0, 1.0, 0.0, 1.0],
                    [1.0, -1.0, 0.0, 1.0],
                    [1.0, 1.0, 0.0, 1.0],
                ]);
            } else {
                // One triangle per pixel.
                vertices.reserve(pixel_count * TRIANGLE_VERTICES);
                let pixel_width = 2.0 / float_extent;
                let pixel_height = 2.0 / float_extent;
                let hor_margin = pixel_width / 4.0;
                let vert_margin = pixel_height / 4.0;
                for y in 0..FB_SIZE {
                    for x in 0..FB_SIZE {
                        let x_center = (x as f32 + 0.5) / float_extent * 2.0 - 1.0;
                        let y_center = (y as f32 + 0.5) / float_extent * 2.0 - 1.0;
                        vertices.push([x_center - hor_margin, y_center + vert_margin, 0.0, 1.0]);
                        vertices.push([x_center + hor_margin, y_center + vert_margin, 0.0, 1.0]);
                        vertices.push([x_center, y_center - vert_margin, 0.0, 1.0]);
                    }
                }
            }
            vertex_buffer = Some(create_host_buffer(
                context,
                &vertices,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            )?);
        }

        // Prepare pseudorandom offsets. As the default sample coordinates will be 0,0 these offsets will be the ones actually choosing which
        // texel to sample. Note the offsets are stored as ivec4 to avoid std140 confusions, but in reality only the first two components are used.
        let mut offsets: Vec<[i32; 4]> = Vec::with_capacity(pixel_count);
        for y in 0..FB_SIZE as i32 {
            for x in 0..FB_SIZE as i32 {
                offsets.push([x, y, 0, 0]);
            }
        }
        let mut rnd = Random::new(params.get_seed());
        rnd.shuffle(&mut offsets);
        let offsets_buffer = create_host_buffer(context, &offsets, vk::BufferUsageFlags::UNIFORM_BUFFER)?;

        // Push constants: coords, size and lod, as the GLSL block declares them.
        let top_left_x_center = 0.5 / float_extent;
        let top_left_y_center = 0.5 / float_extent;
        let pc_data: [f32; 7] = [
            top_left_x_center,
            top_left_y_center,
            1.0,
            1.0,
            float_extent,
            float_extent,
            last_mip_level as f32,
        ];
        let pc_bytes: Vec<u8> = pc_data.iter().flat_map(|value| value.to_ne_bytes()).collect();

        // Descriptor set.
        let mut pool_builder = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1);
        let mut layout_builder = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, params.test_stage)
            .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, params.test_stage);
        if params.is_compute() {
            pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_IMAGE, 1);
            layout_builder = layout_builder.add_single_binding(vk::DescriptorType::STORAGE_IMAGE, params.test_stage);
        }
        let desc_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set_layout = layout_builder.build(device)?;
        let descriptor_set = make_descriptor_set(device, *desc_pool, *set_layout)?;

        let buffer_info = make_descriptor_buffer_info(offsets_buffer.get(), 0, vk::WHOLE_SIZE);
        let sampler_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *tex_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let output_img_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *fb_img.view,
            image_layout: vk::ImageLayout::GENERAL,
        };
        let mut writes = vec![
            vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: *descriptor_set,
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &buffer_info,
                texel_buffer_view: std::ptr::null(),
            },
            vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: *descriptor_set,
                dst_binding: 1,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                image_info: &sampler_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            },
        ];
        if params.is_compute() {
            writes.push(vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: *descriptor_set,
                dst_binding: 2,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                image_info: &output_img_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            });
        }
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Pipeline.
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: params.test_stage,
            offset: 0,
            size: PUSH_CONSTANT_SIZE,
        }];
        let set_layouts = [*set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let (pipeline, render_pass, framebuffer);
        let mut modules = Vec::new();
        if params.is_compute() {
            let comp_module = create_shader_module(device, binaries.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*comp_module)
                .name(c"main".to_bytes_with_nul());
            let info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout);
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateComputePipelines")?;
            pipeline = Unique::new(device, pipelines.0[0]);
            render_pass = None;
            framebuffer = None;
            modules.push(comp_module);
        } else {
            let vert_module = create_shader_module(device, binaries.get("vert")?)?;
            let frag_module = create_shader_module(device, binaries.get("frag")?)?;
            let pass = make_render_pass(device, IMG_FORMAT)?;
            let fb = make_framebuffer(device, *pass, &[*fb_img.view], FB_SIZE, FB_SIZE, 1)?;
            let topology = if params.test_stage == vk::ShaderStageFlags::VERTEX {
                vk::PrimitiveTopology::TRIANGLE_LIST
            } else {
                vk::PrimitiveTopology::TRIANGLE_STRIP
            };
            let state = DrawPipelineState::new(topology)
                .with_position_input()
                .with_full_viewport(FB_SIZE, FB_SIZE);
            pipeline = create_draw_pipeline(
                device,
                *pipeline_layout,
                *pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?;
            render_pass = Some(pass);
            framebuffer = Some(fb);
            modules.push(vert_module);
            modules.push(frag_module);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer_ptr;

        begin_command_buffer(device, cmd)?;

        let tex_usage_pipeline_stage = match params.test_stage {
            vk::ShaderStageFlags::COMPUTE => vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::ShaderStageFlags::VERTEX => vk::PipelineStageFlags::VERTEX_SHADER,
            _ => vk::PipelineStageFlags::FRAGMENT_SHADER,
        };

        // Different from all texture colors.
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let clear_color_value = vk::ClearColorValue { float32: clear_color };

        if params.is_compute() {
            // For graphics, the framebuffer image will be cleared and transitioned using the render pass.
            // However, for compute we need to clear the storage image and move it to the right layout ourselves.
            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                fb_img.image.get(),
                fb_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                pre_clear_barrier,
            );
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    fb_img.image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color_value,
                    &[fb_srr],
                )
            };
            let post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                fb_img.image.get(),
                fb_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                tex_usage_pipeline_stage,
                post_clear_barrier,
            );
        }

        // Prepare texture: clear the whole image and copy the texture buffer to the appropriate mip level.
        {
            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                tex_img.get(),
                tex_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                pre_clear_barrier,
            );
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    tex_img.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color_value,
                    &[tex_srr],
                )
            };
            let write_wait_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                tex_img.get(),
                tex_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                write_wait_barrier,
            );
            let copy_region = make_buffer_image_copy(fb_extent, tex_srl);
            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd,
                    tex_buffer.get(),
                    tex_img.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[copy_region],
                )
            };
            let post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                tex_img.get(),
                tex_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                tex_usage_pipeline_stage,
                post_clear_barrier,
            );
        }

        // Dispatch work.
        if params.is_compute() {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[] as &[u32],
                );
                device.cmd_push_constants(cmd, *pipeline_layout, params.test_stage, 0, &pc_bytes);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_dispatch(cmd, 1, 1, 1);
            }
        } else {
            let (Some(render_pass), Some(framebuffer), Some(vertex_buffer)) =
                (render_pass.as_ref(), framebuffer.as_ref(), vertex_buffer.as_ref())
            else {
                return Err(TestError::Fail("graphics objects were not created".to_string()));
            };
            begin_render_pass(
                device,
                cmd,
                **render_pass,
                **framebuffer,
                rect_2d(FB_SIZE, FB_SIZE),
                clear_value_color(clear_color),
            );
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[] as &[u32],
                );
                device.cmd_push_constants(cmd, *pipeline_layout, params.test_stage, 0, &pc_bytes);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            }
            end_render_pass(device, cmd);
        }

        // Copy framebuffer to verification buffer.
        if params.is_compute() {
            copy_general_image_to_buffer(device, cmd, fb_img.image.get(), fb_img.buffer.get(), FB_SIZE, FB_SIZE);
        } else {
            copy_image_to_buffer(device, cmd, fb_img.image.get(), fb_img.buffer.get(), FB_SIZE, FB_SIZE);
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Compare the result with a reference image built from the host texture and the offsets.
        let result = fb_img.read_bytes(device)?;
        for y in 0..FB_SIZE as usize {
            for x in 0..FB_SIZE as usize {
                let pixel_idx = y * FB_SIZE as usize + x;
                let offset = offsets[pixel_idx];
                let expected = host_texture[offset[1] as usize * FB_SIZE as usize + offset[0] as usize];
                let actual = &result[pixel_idx * 4..pixel_idx * 4 + 4];
                let rgb_ok = (0..3).all(|c| (actual[c] as i32 - expected[c] as i32).abs() <= 1);
                if !rgb_ok || actual[3] != expected[3] {
                    return Ok(TestStatus::fail(
                        "Unexpected results in color buffer; check log for details --",
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageNonUniformOffsetSampleTests`
pub fn create_image_non_uniform_offset_sample_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("non_uniform_offset_sample");

    let test_stages: [(vk::ShaderStageFlags, &str); 3] = [
        (vk::ShaderStageFlags::VERTEX, "vert"),
        (vk::ShaderStageFlags::FRAGMENT, "frag"),
        (vk::ShaderStageFlags::COMPUTE, "comp"),
    ];
    let test_func_cases: [(TestFunc, &str); 5] = [
        (TestFunc::Texture, "texture"),
        (TestFunc::TexelFetch, "texel_fetch"),
        (TestFunc::TextureLod, "texture_lod"),
        (TestFunc::TextureProj, "texture_proj"),
        (TestFunc::TextureProjLod, "texture_proj_lod"),
    ];
    for (test_func, prefix) in test_func_cases {
        let mut func_group = TestCaseGroup::new(format!("{prefix}_offset"));
        for multi_mip in [false, true] {
            for (stage, stage_name) in test_stages {
                if multi_mip && !has_lod_arg(test_func) {
                    continue;
                }
                // Implicit-LOD sampling requires derivatives, which aren't available in compute shaders without GL_KHR_compute_shader_derivatives.
                if stage == vk::ShaderStageFlags::COMPUTE && !has_lod_arg(test_func) {
                    continue;
                }
                let params = TestParams {
                    test_stage: stage,
                    test_function: test_func,
                    multi_mip,
                };
                let test_name = format!("{}{}", if multi_mip { "multi_mip_" } else { "single_mip_" }, stage_name);
                func_group.add_child(Box::new(NonUniformOffsetCase {
                    name: test_name,
                    params,
                }) as Box<dyn TestCase>);
            }
        }
        main_group.add_child(func_group);
    }

    main_group
}
