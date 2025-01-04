// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/spirv_assembly/instruction/graphics/{early_fragment,early_and_late_fragment,execution_mode}/*.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 Google LLC.
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the two Amber graphics pipelines do is done directly in one command buffer: `my_pipeline` draws `DRAW_RECT 0 0 <size> <size>`
// (a four vertex strip, with the vertex shader's depth of 0.5) into a size x size colour target and a D16 depth buffer cleared to the script's `CLEAR_DEPTH`, with the depth test and write
// on and the script's compare op; `verify_pipeline` samples the depth buffer with texelFetch and paints the second target green where it holds the expected value, and
// every pixel of that target must be (0, 255, 0, 255). The shaders are written by `scripts/gen_spirv_assembly_early_fragment_amber.py`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::early_fragment_cases::EARLY_FRAGMENT_CASES;
use crate::generated::shaders::spirv_assembly_early_fragment::ALL_SHARED_PROGRAM;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_create_info, make_image_subresource_range, make_image_view};
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

const COLOR_FORMAT: vk::Format = vk::Format::B8G8R8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;

/// One Amber script of the `early_fragment` and `early_and_late_fragment` groups
pub struct EarlyFragmentCase {
    pub group: &'static str,
    pub name: &'static str,
    pub key: &'static str,
    pub compare_op: vk::CompareOp,
    pub clear_depth: f32,
    pub early_and_late: bool,
    /// `FRAMEBUFFER_SIZE` of both pipelines
    pub size: u32,
}

struct EarlyFragmentTestCase {
    data: &'static EarlyFragmentCase,
}

impl TestCase for EarlyFragmentTestCase {
    fn name(&self) -> &str {
        self.data.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let properties = unsafe { instance.get_physical_device_format_properties(physical_device, DEPTH_FORMAT) };
        let required = vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT | vk::FormatFeatureFlags::SAMPLED_IMAGE;
        if !properties.optimal_tiling_features.contains(required) {
            return Err(TestError::NotSupported(format!(
                "{DEPTH_FORMAT:?} does not support {required:?}"
            )));
        }
        if self.data.early_and_late {
            context.require_device_functionality("VK_AMD_shader_early_and_late_fragment_tests")?;
            let mut early_late = vk::PhysicalDeviceShaderEarlyAndLateFragmentTestsFeaturesAMD::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut early_late);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if early_late.shader_early_and_late_fragment_tests == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderEarlyAndLateFragmentTests not supported".to_string(),
                ));
            }
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
        Box::new(EarlyFragmentInstance {
            context,
            data: self.data,
        })
    }
}

struct EarlyFragmentInstance<'a> {
    context: &'a Context<'a>,
    data: &'static EarlyFragmentCase,
}

impl TestInstance for EarlyFragmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let size = data.size;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

        let color = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(size as i32, size as i32),
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(device, color.get(), vk::ImageViewType::_2D, COLOR_FORMAT, color_range)?;
        let verify = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(size as i32, size as i32),
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let verify_view = make_image_view(device, verify.get(), vk::ImageViewType::_2D, COLOR_FORMAT, color_range)?;
        let depth_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(DEPTH_FORMAT)
            .extent(vk::Extent3D {
                width: size,
                height: size,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::SAMPLED)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let depth = ImageWithMemory::new(device, allocator, depth_info, MemoryRequirement::ANY)?;
        let depth_view = make_image_view(device, depth.get(), vk::ImageViewType::_2D, DEPTH_FORMAT, depth_range)?;

        // The first pass: a colour and a depth attachment, the depth ending up readable by a shader
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
                format: DEPTH_FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            },
        ];
        let color_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_ref = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_ref)
            .depth_stencil_attachment(&depth_ref)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let views = [*color_view, *depth_view];
        let framebuffer_info = vk::FramebufferCreateInfo::builder()
            .render_pass(*render_pass)
            .attachments(&views)
            .width(size)
            .height(size)
            .layers(1);
        let framebuffer = Unique::new(
            device,
            unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
        );

        let verify_pass = make_render_pass(device, COLOR_FORMAT)?;
        let verify_framebuffer = make_framebuffer(device, *verify_pass, &[*verify_view], size, size, 1)?;

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
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                1,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_descriptor = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *depth_view,
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
            image_info: &image_descriptor,
            buffer_info: std::ptr::null(),
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // DRAW_RECT 0 0 250 250 in Amber's vertex order: bottom left, top left, bottom right, top right
        let positions: [f32; 8] = [-1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, -1.0];
        let position_bytes: Vec<u8> = positions.iter().flat_map(|value| value.to_ne_bytes()).collect();
        let position_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                position_bytes.len() as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                position_bytes.as_ptr(),
                position_buffer.get_allocation().get_host_ptr(),
                position_bytes.len(),
            )
        };
        flush_alloc(device, position_buffer.get_allocation())?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(size, size);
        state.color_attachment_count = 1;
        state.bindings.push(vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        });
        state.attributes.push(vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        });
        let mut verify_state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(size, size);
        verify_state.color_attachment_count = 1;
        verify_state.bindings = state.bindings.clone();
        verify_state.attributes = state.attributes.clone();
        // DEPTH TEST on, WRITE on, COMPARE_OP of the script
        state.depth_stencil.depth_test_enable = vk::TRUE;
        state.depth_stencil.depth_write_enable = vk::TRUE;
        state.depth_stencil.depth_compare_op = data.compare_op;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let verify_vertex_module = create_shader_module(device, binaries.get("verify_vert")?)?;
        let verify_fragment_module = create_shader_module(device, binaries.get("verify_frag")?)?;
        let empty_layout = make_pipeline_layout(device, &[])?;
        let verify_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = create_draw_pipeline(
            device,
            *empty_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;
        let verify_pipeline = create_draw_pipeline(
            device,
            *verify_layout,
            *verify_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *verify_vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *verify_fragment_module),
            ],
            &verify_state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            // CLEAR_COLOR my_pipeline 0 0 0 255, CLEAR_DEPTH my_pipeline <depth>
            let clear_values = [
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0],
                    },
                },
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: data.clear_depth,
                        stencil: 0,
                    },
                },
            ];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(make_rect_2d(0, 0, size, size))
                .clear_values(&clear_values);
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);
            device.cmd_draw(cmd, 4, 1, 0, 0);
            end_render_pass(device, cmd);

            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::SHADER_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // CLEAR_COLOR verify_pipeline 0 0 0 255
            begin_render_pass(
                device,
                cmd,
                *verify_pass,
                *verify_framebuffer,
                make_rect_2d(0, 0, size, size),
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0],
                    },
                },
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *verify_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *verify_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);
            device.cmd_draw(cmd, 4, 1, 0, 0);
            end_render_pass(device, cmd);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_color_attachment(
            context,
            verify.get(),
            COLOR_FORMAT,
            (size, size),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        // EXPECT framebuffer_verify IDX 0 0 SIZE <size> <size> EQ_RGBA 0 255 0 255
        for (ndx, pixel) in result.data().chunks_exact(4).enumerate() {
            if pixel != [0, 255, 0, 255] {
                log::error!(
                    "Probe failed at ({}, {}): expected [0, 255, 0, 255], got {pixel:?}",
                    ndx as u32 % size,
                    ndx as u32 / size
                );
                return Ok(TestStatus::fail("Probe failed"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `early_fragment`, `early_and_late_fragment` and `execution_mode` groups of `spirv_assembly.instruction.graphics`
pub fn create_early_fragment_groups() -> Vec<TestCaseGroup> {
    ["early_and_late_fragment", "early_fragment", "execution_mode"]
        .into_iter()
        .map(|group_name| {
            let mut group = TestCaseGroup::new(group_name);
            for data in EARLY_FRAGMENT_CASES.iter().filter(|data| data.group == group_name) {
                group.add_child(Box::new(EarlyFragmentTestCase { data }) as Box<dyn TestCase>);
            }
            group
        })
        .collect()
}
