// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureMipmapTests.cpp (TextureGatherMinLodTest, TextureGatherMinLodInstance, populateMinLodGatherGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The pipeline is `create_draw_pipeline`, and a minLod of 1.1 (which needs robustness2) runs on a
// `RobustnessDevice` as upstream's own device capabilities ask for. The shaders are `shaders/manifest/texture_min_lod_gather.toml`
// (scripts/gen_min_lod_gather_manifest.py), one set per gathered component.
//
// A texture of three mip levels, each filled with its own nonzero random color, is gathered at its center through a view whose minLod is 0.1 or 1.1:
// with 0.1 the base level is the one gathered from, with 1.1 gathering from the base level needs robustness2 and returns zeros.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::texture_min_lod_gather::{
    MIN_LOD_GATHER_COMPONENT_0, MIN_LOD_GATHER_COMPONENT_1, MIN_LOD_GATHER_COMPONENT_2, MIN_LOD_GATHER_COMPONENT_3,
};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct GatherParams {
    /// Seed for the pseudorandom number generator.
    random_seed: u32,
    /// 0.1 or 1.1
    min_lod: f32,
    /// 0, 1, 2, 3 for the gather operation.
    component: u32,
}

impl GatherParams {
    fn min_lod_integer(&self) -> u32 {
        self.min_lod as u32
    }

    fn needs_robustness2(&self) -> bool {
        self.min_lod >= 1.0
    }
}

struct TextureGatherMinLodCase {
    name: &'static str,
    params: GatherParams,
}

impl TestCase for TextureGatherMinLodCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `TextureGatherMinLodTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_image_view_min_lod")?;

        if self.params.needs_robustness2() {
            if !context.is_device_functionality_supported("VK_KHR_robustness2")
                && !context.is_device_functionality_supported("VK_EXT_robustness2")
            {
                return Err(TestError::NotSupported(
                    "VK_KHR_robustness2 and VK_EXT_robustness2 are not supported".to_string(),
                ));
            }

            let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if robustness2_features.robust_image_access2 == vk::FALSE {
                return Err(TestError::NotSupported("robustImageAccess2 not supported".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.component {
            0 => MIN_LOD_GATHER_COMPONENT_0.programs,
            1 => MIN_LOD_GATHER_COMPONENT_1.programs,
            2 => MIN_LOD_GATHER_COMPONENT_2.programs,
            _ => MIN_LOD_GATHER_COMPONENT_3.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TextureGatherMinLodInstance {
            context,
            params: self.params,
        })
    }
}

struct TextureGatherMinLodInstance<'a> {
    context: &'a Context<'a>,
    params: GatherParams,
}

impl TestInstance for TextureGatherMinLodInstance<'_> {
    /// `TextureGatherMinLodInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;

        // A minLod of 1.1 runs on a device with robustness2 on
        let robust_device = if params.needs_robustness2() {
            Some(RobustnessDevice::new(
                context.get_instance(),
                context.get_physical_device(),
                context.get_universal_queue_family_index(),
                RobustnessFeatures {
                    robust_buffer_access2: true,
                    robust_image_access2: true,
                    ..Default::default()
                },
            )?)
        } else {
            None
        };
        let (device, queue) = match &robust_device {
            Some(robust) => (robust.device(), robust.queue()),
            None => (context.get_device(), context.get_universal_queue()),
        };
        let robust_allocator = robust_device.as_ref().map(|_| {
            SimpleAllocator::new(unsafe {
                context
                    .get_instance()
                    .get_physical_device_memory_properties(context.get_physical_device())
            })
        });
        let allocator = robust_allocator
            .as_ref()
            .unwrap_or_else(|| context.get_default_allocator());

        let image_format = vk::Format::R8G8B8A8_UNORM;
        let color_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let tex_extent = vk::Extent3D {
            width: 8,
            height: 8,
            depth: 1,
        };
        let tex_mip_levels = 3u32;
        let min_lod_u = params.min_lod_integer();

        let make_image = |extent: vk::Extent3D, mip_levels: u32, usage: vk::ImageUsageFlags| {
            ImageWithMemory::new(
                device,
                allocator,
                vk::ImageCreateInfo {
                    s_type: vk::StructureType::IMAGE_CREATE_INFO,
                    next: std::ptr::null(),
                    flags: vk::ImageCreateFlags::empty(),
                    image_type: vk::ImageType::_2D,
                    format: image_format,
                    extent,
                    mip_levels,
                    array_layers: 1,
                    samples: vk::SampleCountFlags::_1,
                    tiling: vk::ImageTiling::OPTIMAL,
                    usage,
                    sharing_mode: vk::SharingMode::EXCLUSIVE,
                    queue_family_index_count: 0,
                    queue_family_indices: std::ptr::null(),
                    initial_layout: vk::ImageLayout::UNDEFINED,
                },
                MemoryRequirement::ANY,
            )
        };

        // Color attachment: a simple 1x1 image.
        let color_buffer = make_image(
            color_extent,
            1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        )?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let color_buffer_view = make_image_view(
            device,
            color_buffer.get(),
            vk::ImageViewType::_2D,
            image_format,
            color_srr,
        )?;

        // Texture: an 8x8 image with several mip levels.
        let texture = make_image(
            tex_extent,
            tex_mip_levels,
            vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        )?;
        let tex_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, tex_mip_levels, 0, 1);

        let mut tex_min_lod_info = vk::ImageViewMinLodCreateInfoEXT::builder().min_lod(params.min_lod);
        let tex_view_info = vk::ImageViewCreateInfo::builder()
            .image(texture.get())
            .view_type(vk::ImageViewType::_2D)
            .format(image_format)
            .components(vk::ComponentMapping {
                r: vk::ComponentSwizzle::R,
                g: vk::ComponentSwizzle::G,
                b: vk::ComponentSwizzle::B,
                a: vk::ComponentSwizzle::A,
            })
            .subresource_range(tex_srr)
            .push_next(&mut tex_min_lod_info);
        let tex_view = Unique::new(
            device,
            unsafe { device.create_image_view(&tex_view_info, None) }.vk_check("vkCreateImageView")?,
        );

        // Verification buffer for the color attachment.
        let verif_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Descriptor set layout, pipeline layout, sampler, descriptor pool and set.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::LINEAR)
            .min_filter(vk::Filter::LINEAR)
            .mipmap_mode(vk::SamplerMipmapMode::LINEAR)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(0.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(tex_mip_levels as f32)
            .border_color(vk::BorderColor::INT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        {
            let combined_sampler_info = vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *tex_view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            };
            let write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                image_info: &combined_sampler_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }

        // Render pass, framebuffer and pipeline.
        let render_pass = make_render_pass(device, image_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer_view],
            color_extent.width,
            color_extent.height,
            1,
        )?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
        state.viewports = vec![viewport(0.0, 0.0, 1.0, 1.0, 0.0, 1.0)];
        state.scissors = vec![rect_2d(1, 1)];
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        // Move the whole texture to TRANSFER_DST_OPTIMAL.
        let pre_clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            texture.get(),
            tex_srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_clear_barrier],
            )
        };

        // Fill each texture mip level with a different pseudorandom nonzero color.
        let mut level_colors: Vec<[f32; 4]> = Vec::new();
        let mut rnd = Random::new(params.random_seed);
        let min_color = 0.004f32; // Slightly above 1/255.
        let max_color = 1.0f32;

        for level in 0..tex_mip_levels {
            let r = rnd.get_float_range(min_color, max_color);
            let g = rnd.get_float_range(min_color, max_color);
            let b = rnd.get_float_range(min_color, max_color);
            let a = rnd.get_float_range(min_color, max_color);
            let level_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, level, 1, 0, 1);

            level_colors.push([r, g, b, a]);
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    texture.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &vk::ClearColorValue { float32: [r, g, b, a] },
                    &[level_range],
                )
            };
        }

        // Move the whole texture to SHADER_READ_ONLY_OPTIMAL
        let post_clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            texture.get(),
            tex_srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_clear_barrier],
            )
        };

        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            rect_2d(1, 1),
            clear_value_color([0.0, 0.0, 0.0, 1.0]),
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
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw(cmd, 3, 1, 0, 0); // This has to match the vertex shader.
        }
        end_render_pass(device, cmd);

        // Copy the color buffer to the verification buffer.
        let post_color_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_buffer.get(),
            color_srr,
        );
        let pre_host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_color_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_buffer.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                verif_buffer.get(),
                &[make_buffer_image_copy(color_extent, color_srl)],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[pre_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify the color buffer.
        invalidate_alloc(device, verif_buffer.get_allocation())?;
        let pixel = unsafe { std::slice::from_raw_parts(verif_buffer.get_allocation().get_host_ptr().cast_const(), 4) };
        let result_color: [f32; 4] = std::array::from_fn(|i| f32::from(pixel[i]) / 255.0);

        let src_level_color = level_colors[min_lod_u as usize];
        let comp_color = src_level_color[params.component as usize];
        // This has to match the fragment shader.
        let expected_color = if params.needs_robustness2() {
            [0.0, 0.0, 0.0, 1.0]
        } else {
            [comp_color, comp_color, comp_color, 1.0]
        };
        let threshold = if params.needs_robustness2() { 0.0 } else { 0.005 }; // 1/255 < 0.005 < 2/255

        let thresholds = [threshold, threshold, threshold, 0.0];
        let diff: [f32; 4] = std::array::from_fn(|i| (result_color[i] - expected_color[i]).abs());
        if !(0..4).all(|i| diff[i] <= thresholds[i]) {
            return Err(TestError::Fail(format!(
                "Unexpected output buffer color: expected {expected_color:?} but found {result_color:?} [diff={diff:?}]"
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `populateMinLodGatherGroup`
pub fn create_min_lod_gather_tests() -> TestCaseGroup {
    let mut min_lod_gather_group = TestCaseGroup::new("min_lod_gather");

    // (the `GatherMinLod` and its name; MINLOD_0_1 is 0, MINLOD_1_1 is 1 in the seed)
    for (min_lod_index, min_lod, name) in [(0u32, 0.1f32, "minlod_0_1"), (1, 1.1, "minlod_1_1")] {
        let mut min_lod_group = TestCaseGroup::new(name);

        for (component, component_name) in [
            (0u32, "component_0"),
            (1, "component_1"),
            (2, "component_2"),
            (3, "component_3"),
        ] {
            let random_seed = (min_lod_index + 1000) * 1000 + (component + 1000);
            min_lod_group.add_child(Box::new(TextureGatherMinLodCase {
                name: component_name,
                params: GatherParams {
                    random_seed,
                    min_lod,
                    component,
                },
            }) as Box<dyn TestCase>);
        }

        min_lod_gather_group.add_child(min_lod_group);
    }

    min_lod_gather_group
}
