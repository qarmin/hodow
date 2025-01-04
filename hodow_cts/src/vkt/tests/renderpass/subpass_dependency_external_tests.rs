// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassSubpassDependencyTests.cpp (`ExternalDependencyTestInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `external_subpass` and `implicit_dependencies` of `subpass_dependencies`: a chain of render passes with one colour attachment each. The
// first pass draws four coloured quarters, every following one blurs the previous pass's image (sampled through an immutable sampler),
// alternating horizontally and vertically, and the last image is compared with a CPU blur. What is tested is the external subpass
// dependency, given explicitly (legacy or synchronization2 flavour) or left to the implementation.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

use crate::generated::shaders::renderpass_subpass_dependencies_external::*;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const BLUR_KERNEL: u32 = 12;

fn programs_for(size: u32, pass_count: u32) -> &'static SharedProgram {
    match (size, pass_count) {
        (64, 2) => &EXTERNAL_64_2,
        (64, 3) => &EXTERNAL_64_3,
        (64, 5) => &EXTERNAL_64_5,
        (128, 2) => &EXTERNAL_128_2,
        (128, 3) => &EXTERNAL_128_3,
        (128, 5) => &EXTERNAL_128_5,
        (512, 2) => &EXTERNAL_512_2,
        (512, 3) => &EXTERNAL_512_3,
        (512, 5) => &EXTERNAL_512_5,
        _ => unreachable!("no shader set for this render size and pass count"),
    }
}

/// `ExternalTestConfig`
struct ExternalCase {
    name: String,
    size: u32,
    pass_count: u32,
    /// The dependencies other than the one into the first subpass are left to the implementation.
    implicit: bool,
    sync2: bool,
    group_params: GroupParams,
}

impl TestCase for ExternalCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }
        if self.sync2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        programs_for(self.size, self.pass_count).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExternalInstance { context, case: self })
    }
}

/// One `SubpassDependency` of the test, in the legacy flag types.
struct Dependency {
    src_pass: u32,
    dst_pass: u32,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
}

/// The dependencies of render pass `pass_index`, as `initTests` builds them.
fn dependencies(pass_index: u32, implicit: bool) -> Vec<Dependency> {
    if implicit {
        // The first render pass lets the implementation add all subpass dependencies implicitly. On the following ones only the dependency
        // from external to the first subpass is defined, the one out of subpass 0 is added implicitly.
        if pass_index > 0 {
            return vec![Dependency {
                src_pass: vk::SUBPASS_EXTERNAL,
                dst_pass: 0,
                src_stage_mask: vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                    | vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::empty(),
                dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                    | vk::AccessFlags::SHADER_READ
                    | vk::AccessFlags::SHADER_WRITE,
            }];
        }
        return Vec::new();
    }

    vec![
        Dependency {
            src_pass: vk::SUBPASS_EXTERNAL,
            dst_pass: 0,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_READ
                | vk::AccessFlags::SHADER_WRITE
                | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        },
        Dependency {
            src_pass: 0,
            dst_pass: vk::SUBPASS_EXTERNAL,
            src_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::SHADER_READ
                | vk::AccessFlags::SHADER_WRITE
                | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        },
    ]
}

struct ExternalInstance<'a> {
    context: &'a Context<'a>,
    case: &'a ExternalCase,
}

impl ExternalInstance<'_> {
    /// `createRenderPass` for one of the test's render passes.
    fn create_render_pass(&self, pass_index: u32) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let deps = dependencies(pass_index, self.case.implicit);

        if self.case.group_params.rendering_type == RenderingType::Legacy {
            let attachments = [vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let color_references = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let depth_stencil_reference = vk::AttachmentReference {
                attachment: vk::ATTACHMENT_UNUSED,
                layout: vk::ImageLayout::GENERAL,
            };
            let subpasses = [vk::SubpassDescription {
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                input_attachment_count: 0,
                input_attachments: std::ptr::null(),
                color_attachment_count: 1,
                color_attachments: color_references.as_ptr(),
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: &depth_stencil_reference,
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            }];
            let dependencies: Vec<vk::SubpassDependency> = deps
                .iter()
                .map(|d| vk::SubpassDependency {
                    src_subpass: d.src_pass,
                    dst_subpass: d.dst_pass,
                    src_stage_mask: d.src_stage_mask,
                    dst_stage_mask: d.dst_stage_mask,
                    src_access_mask: d.src_access_mask,
                    dst_access_mask: d.dst_access_mask,
                    dependency_flags: vk::DependencyFlags::empty(),
                })
                .collect();
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
            return Ok(Unique::new(device, render_pass));
        }

        let attachments = [vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: FORMAT,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::DONT_CARE,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let color_references = [vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            aspect_mask: vk::ImageAspectFlags::empty(),
        }];
        let depth_stencil_reference = vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: vk::ATTACHMENT_UNUSED,
            layout: vk::ImageLayout::GENERAL,
            aspect_mask: vk::ImageAspectFlags::empty(),
        };
        let subpasses = [vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: 0,
            input_attachments: std::ptr::null(),
            color_attachment_count: 1,
            color_attachments: color_references.as_ptr(),
            resolve_attachments: std::ptr::null(),
            depth_stencil_attachment: &depth_stencil_reference,
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
        }];
        // The synchronization2 flavour carries the masks in a VkMemoryBarrier2 chained to the dependency.
        let barriers2: Vec<vk::MemoryBarrier2> = deps
            .iter()
            .map(|d| vk::MemoryBarrier2 {
                src_stage_mask: vk::PipelineStageFlags2::from_bits_truncate(u64::from(d.src_stage_mask.bits())),
                src_access_mask: vk::AccessFlags2::from_bits_truncate(u64::from(d.src_access_mask.bits())),
                dst_stage_mask: vk::PipelineStageFlags2::from_bits_truncate(u64::from(d.dst_stage_mask.bits())),
                dst_access_mask: vk::AccessFlags2::from_bits_truncate(u64::from(d.dst_access_mask.bits())),
                ..Default::default()
            })
            .collect();
        let dependencies: Vec<vk::SubpassDependency2> = deps
            .iter()
            .enumerate()
            .map(|(index, d)| {
                if self.case.sync2 {
                    vk::SubpassDependency2 {
                        s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                        next: (&raw const barriers2[index]).cast(),
                        src_subpass: d.src_pass,
                        dst_subpass: d.dst_pass,
                        src_stage_mask: vk::PipelineStageFlags::empty(),
                        dst_stage_mask: vk::PipelineStageFlags::empty(),
                        src_access_mask: vk::AccessFlags::empty(),
                        dst_access_mask: vk::AccessFlags::empty(),
                        dependency_flags: vk::DependencyFlags::empty(),
                        view_offset: 0,
                    }
                } else {
                    vk::SubpassDependency2 {
                        s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                        next: std::ptr::null(),
                        src_subpass: d.src_pass,
                        dst_subpass: d.dst_pass,
                        src_stage_mask: d.src_stage_mask,
                        dst_stage_mask: d.dst_stage_mask,
                        src_access_mask: d.src_access_mask,
                        dst_access_mask: d.dst_access_mask,
                        dependency_flags: vk::DependencyFlags::empty(),
                        view_offset: 0,
                    }
                }
            })
            .collect();
        let info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: 1,
            attachments: attachments.as_ptr(),
            subpass_count: 1,
            subpasses: subpasses.as_ptr(),
            dependency_count: dependencies.len() as u32,
            dependencies: dependencies.as_ptr(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        let render_pass = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        Ok(Unique::new(device, render_pass))
    }

    /// `createRenderPipelines` for one render pass: no vertex input, a full-size viewport, one colour attachment without blending.
    fn create_pipeline(
        &self,
        layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
        vert: vk::ShaderModule,
        frag: vk::ShaderModule,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let size = self.case.size;
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
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: size as f32,
            height: size as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: size,
                height: size,
            },
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
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
            .sample_shading_enable(false)
            .min_sample_shading(1.0);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(
                vk::ColorComponentFlags::R
                    | vk::ColorComponentFlags::G
                    | vk::ColorComponentFlags::B
                    | vk::ColorComponentFlags::A,
            )
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(0);
        crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
    }
}

impl TestInstance for ExternalInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let q_index = context.get_universal_queue_family_index();
        let size = self.case.size;
        let pass_count = self.case.pass_count as usize;
        let mut result_collector = ResultCollector::new("");

        // createAndAllocateImages, createImageViews
        let queue_family_indices = [q_index];
        let mut images = Vec::with_capacity(pass_count);
        let mut image_views = Vec::with_capacity(pass_count);
        for _ in 0..pass_count {
            let image_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(FORMAT)
                .extent(vk::Extent3D {
                    width: size,
                    height: size,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(
                    vk::ImageUsageFlags::COLOR_ATTACHMENT
                        | vk::ImageUsageFlags::SAMPLED
                        | vk::ImageUsageFlags::TRANSFER_SRC,
                )
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .queue_family_indices(&queue_family_indices)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
            image_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                FORMAT,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?);
            images.push(image);
        }

        // createSamplers
        let mut samplers = Vec::with_capacity(pass_count - 1);
        for _ in 0..pass_count - 1 {
            let sampler_info = vk::SamplerCreateInfo::builder()
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
            let sampler = unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?;
            samplers.push(Unique::new(device, sampler));
        }

        let dst_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                (size * size * 4) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // createRenderPasses, createFramebuffers
        let mut render_passes = Vec::with_capacity(pass_count);
        let mut framebuffers = Vec::with_capacity(pass_count);
        for pass_index in 0..pass_count {
            let render_pass = self.create_render_pass(pass_index as u32)?;
            framebuffers.push(make_framebuffer(
                device,
                *render_pass,
                &[*image_views[pass_index]],
                size,
                size,
                1,
            )?);
            render_passes.push(render_pass);
        }

        // createDescriptorSetLayouts (immutable sampler), createDescriptorPools, createDescriptorSets
        let mut set_layouts = Vec::with_capacity(pass_count - 1);
        let mut pools = Vec::with_capacity(pass_count - 1);
        let mut sets = Vec::with_capacity(pass_count - 1);
        for set_index in 0..pass_count - 1 {
            let binding = vk::DescriptorSetLayoutBinding {
                binding: 0,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                immutable_samplers: &*samplers[set_index],
            };
            let layout_info = vk::DescriptorSetLayoutCreateInfo {
                binding_count: 1,
                bindings: &binding,
                ..Default::default()
            };
            let layout = unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?;
            set_layouts.push(Unique::new(device, layout));
            pools.push(
                DescriptorPoolBuilder::new()
                    .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
                    .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
            );
        }
        for set_index in 0..pass_count - 1 {
            let set = make_descriptor_set(device, *pools[set_index], *set_layouts[set_index])?;
            let image_info = vk::DescriptorImageInfo {
                sampler: *samplers[set_index],
                image_view: *image_views[set_index],
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            };
            let write = vk::WriteDescriptorSet {
                dst_set: *set,
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                image_info: &image_info,
                ..Default::default()
            };
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            sets.push(set);
        }

        // createRenderPipelineLayouts, createRenderPipelines
        let binaries = context.get_binary_collection();
        let mut pipeline_layouts = Vec::with_capacity(pass_count);
        let mut pipelines = Vec::with_capacity(pass_count);
        let mut shader_modules = Vec::with_capacity(pass_count * 2);
        for pass_index in 0..pass_count {
            let layouts = if pass_index > 0 {
                vec![*set_layouts[pass_index - 1]]
            } else {
                Vec::new()
            };
            let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&layouts);
            let layout = Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
            );

            let vert = create_shader_module(device, binaries.get(&format!("quad-vert-{pass_index}"))?)?;
            let frag = create_shader_module(device, binaries.get(&format!("quad-frag-{pass_index}"))?)?;
            pipelines.push(self.create_pipeline(*layout, *render_passes[pass_index], *vert, *frag)?);
            pipeline_layouts.push(layout);
            shader_modules.push(vert);
            shader_modules.push(frag);
        }

        let command_pool = make_command_pool(device, q_index)?;
        let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let render_pass2 = self.case.group_params.rendering_type == RenderingType::RenderPass2;

        begin_command_buffer(device, cmd)?;

        for pass_index in 0..pass_count {
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: size,
                    height: size,
                },
            };
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_passes[pass_index])
                .framebuffer(*framebuffers[pass_index])
                .render_area(render_area)
                .build();
            if render_pass2 {
                let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                unsafe { device.cmd_begin_render_pass2_khr(cmd, &begin_info, &subpass_begin_info) };
            } else {
                unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
            }

            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipelines[pass_index]) };

            // Use results from the previous pass as input texture
            if pass_index > 0 {
                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layouts[pass_index],
                        0,
                        &[*sets[pass_index - 1]],
                        &[] as &[u32],
                    )
                };
            }

            unsafe { device.cmd_draw(cmd, 6, 1, 0, 0) };

            if render_pass2 {
                let subpass_end_info = vk::SubpassEndInfo::builder();
                unsafe { device.cmd_end_render_pass2_khr(cmd, &subpass_end_info) };
            } else {
                unsafe { device.cmd_end_render_pass(cmd) };
            }
        }

        // Memory barrier between rendering and copy. The implicit 'end' subpass dependency has BOTTOM_OF_PIPE in its dstStageMask, so no
        // specific stage can be chained to.
        let last_image = images[pass_count - 1].get();
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            last_image,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        // Copy image memory to buffer
        let region = vk::BufferImageCopy {
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
                width: size,
                height: size,
                depth: 1,
            },
        };
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                last_image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                dst_buffer.get(),
                &[region],
            )
        };

        // Memory barrier between copy and host access
        let buffer_barrier = vk::BufferMemoryBarrier {
            src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
            dst_access_mask: vk::AccessFlags::HOST_READ,
            src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            buffer: dst_buffer.get(),
            offset: 0,
            size: vk::WHOLE_SIZE,
            ..Default::default()
        };
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
        invalidate_alloc(device, dst_buffer.get_allocation())?;

        let format =
            map_vk_format(FORMAT).ok_or_else(|| TestError::InternalError("RGBA8 has a texture format".to_string()))?;
        let bytes = unsafe {
            std::slice::from_raw_parts(
                dst_buffer.get_allocation().get_host_ptr() as *const u8,
                (size * size * 4) as usize,
            )
        };
        let access = ConstPixelBufferAccess::new(format, [size, size, 1], bytes);
        let mut texture_a = TextureLevel::new(format, size, size, 1)?;
        let mut texture_b = TextureLevel::new(format, size, size, 1)?;

        for pass_index in 0..pass_count {
            if pass_index == 0 {
                // First pass renders four quads of different color, which will be blurred in the following passes
                let half = (size - 1) / 2;
                let mut texture_access = texture_a.get_access();
                for y in 0..size {
                    for x in 0..size {
                        let color = if x <= half && y <= half {
                            [1.0, 0.0, 0.0, 1.0]
                        } else if x > half && y <= half {
                            [0.0, 1.0, 0.0, 1.0]
                        } else if x <= half && y > half {
                            [0.0, 0.0, 1.0, 1.0]
                        } else {
                            [0.0, 0.0, 0.0, 1.0]
                        };
                        texture_access.set_pixel(color, x, y, 0);
                    }
                }
            } else {
                // Blur previous pass
                let horizontal = pass_index % 2 == 0;
                let source = if horizontal {
                    texture_b.get_const_access()
                } else {
                    texture_a.get_const_access()
                };
                let mut blurred = vec![[0.0f32; 4]; (size * size) as usize];
                for y in 0..size {
                    for x in 0..size {
                        let mut blur_color = [0.0f32; 4];
                        for sample_ndx in 0..BLUR_KERNEL + 1 {
                            let (sx, sy) = if horizontal {
                                (
                                    (x as i32 - (BLUR_KERNEL / 2) as i32 + sample_ndx as i32).clamp(0, size as i32 - 1)
                                        as u32,
                                    y,
                                )
                            } else {
                                (
                                    x,
                                    (y as i32 - (BLUR_KERNEL / 2) as i32 + sample_ndx as i32).clamp(0, size as i32 - 1)
                                        as u32,
                                )
                            };
                            let pixel = source.get_pixel(sx, sy, 0);
                            for c in 0..4 {
                                blur_color[c] += 0.12 * pixel[c];
                            }
                        }
                        blurred[(y * size + x) as usize] = blur_color;
                    }
                }
                let mut destination = if horizontal {
                    texture_a.get_access()
                } else {
                    texture_b.get_access()
                };
                for y in 0..size {
                    for x in 0..size {
                        destination.set_pixel(blurred[(y * size + x) as usize], x, y, 0);
                    }
                }
            }
        }

        let reference = if pass_count % 2 == 0 { &texture_b } else { &texture_a };

        // Allow error of 4 times the minimum presentable difference
        let mantissa_bits = crate::tcu::pixel::get_texture_format_mantissa_bit_depth(format);
        let threshold = [0, 1, 2, 3].map(|c| 4.0 / (((1u32 << mantissa_bits[c]) - 1) as f32));
        if !crate::tcu::image_compare::float_threshold_compare(&reference.get_const_access(), &access, threshold).ok {
            result_collector.fail("Compare failed.");
        }

        Ok(result_collector.to_status())
    }
}

/// The `external_subpass` and `implicit_dependencies` groups of `subpass_dependencies`; only the render pass flavours register them.
pub fn add_external_dependency_tests(group: &mut TestCaseGroup, group_params: GroupParams) {
    if group_params.rendering_type == RenderingType::DynamicRendering {
        return;
    }
    let render_pass_counts = [2u32, 3, 5];

    // Test external subpass dependencies
    let mut external_group = TestCaseGroup::new("external_subpass");
    for size in [64u32, 128, 512] {
        let mut render_size_group = TestCaseGroup::new(format!("render_size_{size}_{size}"));
        for pass_count in render_pass_counts {
            let name = format!("render_passes_{pass_count}");
            render_size_group.add_child(Box::new(ExternalCase {
                name: name.clone(),
                size,
                pass_count,
                implicit: false,
                sync2: false,
                group_params,
            }) as Box<dyn TestCase>);
            if group_params.rendering_type == RenderingType::RenderPass2 {
                render_size_group.add_child(Box::new(ExternalCase {
                    name: format!("{name}_sync_2"),
                    size,
                    pass_count,
                    implicit: false,
                    sync2: true,
                    group_params,
                }) as Box<dyn TestCase>);
            }
        }
        external_group.add_child(render_size_group);
    }
    group.add_child(external_group);

    // Test implicit subpass dependencies
    let mut implicit_group = TestCaseGroup::new("implicit_dependencies");
    for pass_count in render_pass_counts {
        implicit_group.add_child(Box::new(ExternalCase {
            name: format!("render_passes_{pass_count}"),
            size: 128,
            pass_count,
            implicit: true,
            sync2: false,
            group_params,
        }) as Box<dyn TestCase>);
    }
    group.add_child(implicit_group);
}
