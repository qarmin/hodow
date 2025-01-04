// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassMultisampleResolveTests.cpp (`ResolveTo3DImageTestInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A four sample image is drawn white and resolved into one slice of a 3D image, either by the render pass (through a 2D view of
// that mip level and slice) or by vkCmdResolveImage; the slice the test named has to hold the white, whatever the mip level.
// The shaders are in `shaders/manifest/renderpass_resolve_into_3d_image.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::renderpass_resolve_into_3d_image::RESOLVE_INTO_3D_IMAGE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const IMAGE_SIZE: u32 = 32;
const SAMPLE_COUNT: vk::SampleCountFlags = vk::SampleCountFlags::_4;

/// `ResolveTo3DImageTestParams`
#[derive(Clone, Copy)]
struct ResolveTo3DImageTestParams {
    image_depth: u32,
    resolve_depth: u32,
    mip_levels: u32,
    resolve_mip_level: u32,
    use_cmd_resolve_image: bool,
}

/// `ResolveTo3DImageTestCase`
struct ResolveTo3DImageTestCase {
    name: String,
    params: ResolveTo3DImageTestParams,
}

impl TestCase for ResolveTo3DImageTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_maintenance1")?;

        let image_size = 32u32 << self.params.resolve_mip_level;

        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                FORMAT,
                vk::ImageType::_3D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
                vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE,
            )
        };
        match properties {
            Ok(properties)
                if properties.max_extent.width >= image_size && properties.max_extent.height >= image_size =>
            {
                Ok(())
            }
            _ => Err(TestError::NotSupported(
                "Required image parameters not supported".to_string(),
            )),
        }
    }

    fn programs(&self) -> BinaryCollection {
        RESOLVE_INTO_3D_IMAGE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ResolveTo3DImageTestInstance {
            context,
            params: self.params,
        })
    }
}

/// `ResolveTo3DImageTestInstance`
struct ResolveTo3DImageTestInstance<'a> {
    context: &'a Context<'a>,
    params: ResolveTo3DImageTestParams,
}

impl<'a> ResolveTo3DImageTestInstance<'a> {
    /// `ResolveTo3DImageTestInstance::createRenderPass`, with the framebuffer.
    fn create_render_pass(&self) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let attachment = |samples: vk::SampleCountFlags| {
            vk::AttachmentDescription::builder()
                .format(FORMAT)
                .samples(samples)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()
        };
        let attachments = [attachment(SAMPLE_COUNT), attachment(vk::SampleCountFlags::_1)];
        let color_attachment = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let resolve_attachment = [vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];

        let mut subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment);
        if !self.params.use_cmd_resolve_image {
            subpass = subpass.resolve_attachments(&resolve_attachment);
        }
        let subpasses = [subpass.build()];

        let attachment_count = if self.params.use_cmd_resolve_image { 1 } else { 2 };
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments[..attachment_count])
            .subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// `ResolveTo3DImageTestInstance::createPipeline`
    fn create_pipeline(
        &self,
        pipeline_layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let binaries = self.context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;

        let entry = c"main";
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vertex_shader_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_shader_module)
                .name(entry.to_bytes_with_nul())
                .build(),
        ];

        let color_blend_attachment_state = [vk::PipelineColorBlendAttachmentState::builder()
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: IMAGE_SIZE as f32,
            height: IMAGE_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: IMAGE_SIZE,
                height: IMAGE_SIZE,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(SAMPLE_COUNT);
        let color_blend_state =
            vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachment_state);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .color_blend_state(&color_blend_state)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0);
        let pipeline = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?
            .0[0];
        Ok(Unique::new(device, pipeline))
    }
}

impl TestInstance for ResolveTo3DImageTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        // `context.getMaintenance9Features().maintenance9`
        let maintenance9 = context.is_device_functionality_supported("VK_KHR_maintenance9") && {
            let mut features = vk::PhysicalDeviceMaintenance9FeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            features.maintenance9 != vk::FALSE
        };

        let resolve_image_size = IMAGE_SIZE << params.resolve_mip_level;
        let resolve_image_depth = if params.image_depth == 1 {
            1
        } else {
            params.image_depth << params.resolve_mip_level
        };
        let resolve_barrier_layers = if maintenance9 { params.image_depth } else { 1 };
        let msaa_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let resolve_range = make_image_subresource_range(
            vk::ImageAspectFlags::COLOR,
            params.resolve_mip_level,
            1,
            0,
            resolve_barrier_layers,
        );
        let msaa_subresource_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let resolve_subresource_layers =
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, params.resolve_mip_level, 0, 1);

        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let msaa_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: IMAGE_SIZE,
                height: IMAGE_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(SAMPLE_COUNT)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let msaa_image = ImageWithMemory::new(device, alloc, msaa_image_info, MemoryRequirement::ANY)?;
        let msaa_image_view = make_image_view(device, msaa_image.get(), vk::ImageViewType::_2D, FORMAT, msaa_range)?;

        let resolve_image_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE)
            .image_type(vk::ImageType::_3D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: resolve_image_size,
                height: resolve_image_size,
                depth: resolve_image_depth,
            })
            .mip_levels(params.mip_levels)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let resolve_image = ImageWithMemory::new(device, alloc, resolve_image_info, MemoryRequirement::ANY)?;
        let resolve_view = make_image_view(
            device,
            resolve_image.get(),
            vk::ImageViewType::_2D,
            FORMAT,
            make_image_subresource_range(
                vk::ImageAspectFlags::COLOR,
                params.resolve_mip_level,
                1,
                params.resolve_depth,
                1,
            ),
        )?;

        let layer_size = (IMAGE_SIZE * IMAGE_SIZE * 4) as vk::DeviceSize;
        let buffer_size = layer_size * vk::DeviceSize::from(params.image_depth);
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let render_pass = self.create_render_pass()?;
        let framebuffer_attachments: Vec<vk::ImageView> = if params.use_cmd_resolve_image {
            vec![*msaa_image_view]
        } else {
            vec![*msaa_image_view, *resolve_view]
        };
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &framebuffer_attachments,
            IMAGE_SIZE,
            IMAGE_SIZE,
            1,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = self.create_pipeline(*pipeline_layout, *render_pass)?;
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        if !params.use_cmd_resolve_image {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::empty(),
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                resolve_image.get(),
                resolve_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        }

        {
            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: IMAGE_SIZE,
                        height: IMAGE_SIZE,
                    },
                });
            unsafe {
                device.cmd_begin_render_pass(cmd, &render_pass_begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_draw(cmd, 4, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }
        }

        if params.use_cmd_resolve_image {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    msaa_image.get(),
                    msaa_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    resolve_image.get(),
                    resolve_range,
                ),
            ];
            let resolve_region = vk::ImageResolve {
                src_subresource: msaa_subresource_layers,
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: resolve_subresource_layers,
                dst_offset: vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: params.resolve_depth as i32,
                },
                extent: vk::Extent3D {
                    width: IMAGE_SIZE,
                    height: IMAGE_SIZE,
                    depth: 1,
                },
            };
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resolve_image.get(),
                resolve_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
                device.cmd_resolve_image(
                    cmd,
                    msaa_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    resolve_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[resolve_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        } else {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resolve_image.get(),
                resolve_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        }

        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: IMAGE_SIZE,
                height: IMAGE_SIZE,
                depth: params.image_depth,
            },
            resolve_subresource_layers,
        );
        let result_buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            result_buffer.get(),
            0,
            buffer_size,
        );
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                resolve_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_buffer.get(),
                &[region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[result_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let allocation = result_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;

        let layer_size_bytes = layer_size as usize;
        let result_data = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), buffer_size as usize) };
        let expected_data = vec![255u8; layer_size_bytes];
        let layer = |ndx: u32| &result_data[layer_size_bytes * ndx as usize..layer_size_bytes * (ndx as usize + 1)];

        if layer(params.resolve_depth) != expected_data.as_slice() {
            let resolved_layer = (0..params.image_depth)
                .find(|&layer_ndx| layer(layer_ndx) == expected_data.as_slice())
                .unwrap_or(params.image_depth);

            let mut message = format!(
                "Image was created with extent {resolve_image_size}x{resolve_image_size}x{resolve_image_depth} and {} mip levels\n",
                params.mip_levels
            );
            if params.use_cmd_resolve_image {
                message.push_str(&format!(
                    "vkCmdResolveImage resolved to mip level {} layer {}",
                    params.resolve_mip_level, params.resolve_depth
                ));
            } else {
                message.push_str(&format!(
                    "2D image view was created from mip level {} layer {}",
                    params.resolve_mip_level, params.resolve_depth
                ));
            }
            message.push_str(", but ");
            if resolved_layer == params.image_depth {
                message.push_str("no layer was resolved to.");
            } else {
                message.push_str(&format!("msaa image was resolved to layer {resolved_layer}"));
            }
            return Ok(TestStatus::fail(format!("Fail: {message}")));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `resolve_into_3d_image` group, which only the render pass (not renderpass2 or dynamic rendering) variant has.
pub fn create_resolve_into_3d_image_tests() -> TestCaseGroup {
    // (imageDepth, resolveDepth, mipLevels, resolveMipLevel, name)
    const RESOLVE_TESTS: [(u32, u32, u32, u32, &str); 5] = [
        (3, 1, 1, 0, "3_1_1_0"),
        (8, 7, 1, 0, "8_7_1_0"),
        (1, 0, 4, 1, "1_0_4_1"),
        (1, 0, 8, 7, "1_0_8_7"),
        (4, 2, 4, 2, "4_2_4_2"),
    ];

    let mut resolve_into_3d_group = TestCaseGroup::new("resolve_into_3d_image");

    for use_cmd_resolve_image in [false, true] {
        for (image_depth, resolve_depth, mip_levels, resolve_mip_level, name) in RESOLVE_TESTS {
            let test_name = format!(
                "{}{name}",
                if use_cmd_resolve_image {
                    "cmd_resolve_image_"
                } else {
                    "render_pass_resolve_"
                }
            );
            let params = ResolveTo3DImageTestParams {
                image_depth,
                resolve_depth,
                mip_levels,
                resolve_mip_level,
                use_cmd_resolve_image,
            };
            resolve_into_3d_group.add_child(Box::new(ResolveTo3DImageTestCase {
                name: test_name,
                params,
            }) as Box<dyn TestCase>);
        }
    }

    resolve_into_3d_group
}
