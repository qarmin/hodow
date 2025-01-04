// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessExtsTests.cpp (OutOfBoundsStrideCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017-2019 The Khronos Group Inc.
// Copyright (c) 2018-2020 NVIDIA Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The vertex buffer size is not a multiple of the vertex binding stride: the last chunk goes partially beyond the end of the buffer, but the
// attribute in it is completely inside. With robustBufferAccess2 the implementation has to consider the attribute in-bounds and use it.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicStateExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::robustness_exts_stride::RX_OUT_OF_BOUNDS_STRIDE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct OutOfBoundsStrideParams {
    pipeline_robustness: bool,
    dynamic_stride: bool,
}

struct OutOfBoundsStrideCase {
    name: String,
    params: OutOfBoundsStrideParams,
}

impl TestCase for OutOfBoundsStrideCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `OutOfBoundsStrideCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // The robustness features are disabled in the default device, so the physical device is asked
        let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
        let mut pipeline_robustness_features = vk::PhysicalDevicePipelineRobustnessFeatures::default();
        let mut eds_features = vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::default();
            let mut chain: Vec<*mut c_void> = Vec::new();
            if context.is_device_functionality_supported("VK_KHR_robustness2")
                || context.is_device_functionality_supported("VK_EXT_robustness2")
            {
                chain.push((&raw mut robustness2_features).cast());
            }
            if context.is_device_functionality_supported("VK_EXT_pipeline_robustness") {
                chain.push((&raw mut pipeline_robustness_features).cast());
            }
            if context.is_device_functionality_supported("VK_EXT_extended_dynamic_state") {
                chain.push((&raw mut eds_features).cast());
            }
            let mut next: *mut c_void = std::ptr::null_mut();
            for &ptr in chain.iter().rev() {
                unsafe { (*ptr.cast::<vk::BaseOutStructure>()).next = next.cast() };
                next = ptr;
            }
            features2.next = next;
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if robustness2_features.robust_buffer_access2 == vk::FALSE {
            return Err(TestError::NotSupported("robustBufferAccess2 not supported".to_string()));
        }

        if self.params.pipeline_robustness && pipeline_robustness_features.pipeline_robustness == vk::FALSE {
            return Err(TestError::NotSupported("pipelineRobustness not supported".to_string()));
        }

        if self.params.dynamic_stride && eds_features.extended_dynamic_state == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        RX_OUT_OF_BOUNDS_STRIDE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OutOfBoundsStrideInstance {
            context,
            params: self.params,
        })
    }
}

struct OutOfBoundsStrideInstance<'a> {
    context: &'a Context<'a>,
    params: OutOfBoundsStrideParams,
}

impl TestInstance for OutOfBoundsStrideInstance<'_> {
    /// `OutOfBoundsStrideInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let features = if self.params.pipeline_robustness {
            RobustnessFeatures {
                pipeline_robustness: true,
                shader_image_int64_atomics: true,
                ..Default::default()
            }
        } else {
            RobustnessFeatures {
                robust_buffer_access2: true,
                robust_image_access2: true,
                shader_image_int64_atomics: true,
                ..Default::default()
            }
        };
        let queue_family_index = context.get_universal_queue_family_index();
        let robust_device = RobustnessDevice::new(
            context.get_instance(),
            context.get_physical_device(),
            queue_family_index,
            features,
        )?;
        let device = robust_device.device();
        let queue = robust_device.queue();
        let allocator = context.get_default_allocator();

        const FB_DIM: u32 = 8;
        let fb_extent = vk::Extent3D {
            width: FB_DIM,
            height: FB_DIM,
            depth: 1,
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let v4_size = 16u32;

        // Color buffer for the test.
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(fb_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_srr,
        )?;
        let color_buffer_size = u64::from(FB_DIM * FB_DIM * 4);
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // We will use points, one point per pixel, but we'll insert a padding after each point.
        // We'll make the last padding out of the buffer, but the point itself will be inside the buffer.
        let point_count = FB_DIM * FB_DIM;
        let mut vertex_buffer_data: Vec<[f32; 4]> = Vec::with_capacity(point_count as usize * 2);
        for y in 0..FB_DIM {
            for x in 0..FB_DIM {
                let x_coord = ((x as f32 + 0.5) / FB_DIM as f32) * 2.0 - 1.0;
                let y_coord = ((y as f32 + 0.5) / FB_DIM as f32) * 2.0 - 1.0;
                vertex_buffer_data.push([x_coord, y_coord, 0.0, 1.0]);
                // Add paddings.
                vertex_buffer_data.push([0.0, 0.0, 0.0, 0.0]);
            }
        }

        // Prepare vertex buffer. Note the size is slightly short and excludes the last padding.
        let vertex_buffer_size = (vertex_buffer_data.len() as u32 * v4_size - v4_size) as u64;
        let vertex_buffer_stride = u64::from(2 * v4_size);
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_buffer_data.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Create the pipeline.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[color_view.get()], FB_DIM, FB_DIM, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Input state, which contains the right stride.
        let binding_description = vk::VertexInputBindingDescription {
            binding: 0,
            stride: v4_size * 2,
            input_rate: vk::VertexInputRate::VERTEX,
        };
        let attribute_description = vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        };
        let binding_descriptions = [binding_description];
        let attribute_descriptions = [attribute_description];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&binding_descriptions)
            .vertex_attribute_descriptions(&attribute_descriptions);

        let dynamic_states: Vec<vk::DynamicState> = if self.params.dynamic_stride {
            vec![vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE]
        } else {
            Vec::new()
        };
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let robustness_info = vk::PipelineRobustnessCreateInfo {
            storage_buffers: vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS_2,
            uniform_buffers: vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS_2,
            vertex_inputs: vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS_2,
            images: vk::PipelineRobustnessImageBehavior::ROBUST_IMAGE_ACCESS_2,
            ..Default::default()
        };

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
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::POINT_LIST)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: FB_DIM as f32,
            height: FB_DIM as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: FB_DIM,
                height: FB_DIM,
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
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        let pipeline_info = vk::GraphicsPipelineCreateInfo {
            s_type: vk::StructureType::GRAPHICS_PIPELINE_CREATE_INFO,
            next: if self.params.pipeline_robustness {
                (&raw const robustness_info).cast()
            } else {
                std::ptr::null()
            },
            flags: vk::PipelineCreateFlags::empty(),
            stage_count: 2,
            stages: stages.as_ptr(),
            vertex_input_state: &raw const *vertex_input_state,
            input_assembly_state: &raw const *input_assembly_state,
            tessellation_state: std::ptr::null(),
            viewport_state: &raw const *viewport_state,
            rasterization_state: &raw const *rasterization_state,
            multisample_state: &raw const *multisample_state,
            depth_stencil_state: std::ptr::null(),
            color_blend_state: &raw const *color_blend_state,
            dynamic_state: &raw const *dynamic_state,
            layout: *pipeline_layout,
            render_pass: *render_pass,
            subpass: 0,
            base_pipeline_handle: vk::Pipeline::null(),
            base_pipeline_index: 0,
        };
        let pipeline = Unique::new(
            device,
            unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateGraphicsPipelines")?
                .0[0],
        );

        // Command pool and buffer.
        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        begin_command_buffer(device, cmd)?;

        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 0.0],
            },
        }];
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: FB_DIM,
                height: FB_DIM,
            },
        };
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(render_area)
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            if self.params.dynamic_stride {
                device.cmd_bind_vertex_buffers2_ext(cmd, 0, &[vertex_buffer.get()], &[0], &[], &[vertex_buffer_stride]);
            } else {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            }
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, point_count, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }

        // Copy image to verification buffer.
        let color_to_transfer = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            color_srr,
        );
        let copy_region = make_buffer_image_copy(fb_extent, color_srl);
        let transfer_to_host = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[color_to_transfer],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[*transfer_to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify color buffer.
        invalidate_alloc(device, color_buffer.get_allocation())?;

        let result = unsafe {
            std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size as usize)
        };
        let ref_color = [0u8, 0, 255, 255]; // Must match frag shader.

        if result.chunks_exact(4).any(|pixel| pixel != ref_color) {
            return Ok(TestStatus::fail(
                "Unexpected results in the color buffer -- check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `misc` group of `createTests` (`robustness2 && !uses64BitIndexing`)
pub fn create_misc_tests(pipeline_robustness: bool) -> TestCaseGroup {
    let mut misc_group = TestCaseGroup::new("misc");

    for dynamic_stride in [false, true] {
        let name_suffix = if dynamic_stride { "_dynamic_stride" } else { "" };
        let params = OutOfBoundsStrideParams {
            pipeline_robustness,
            dynamic_stride,
        };
        misc_group.add_child(Box::new(OutOfBoundsStrideCase {
            name: format!("out_of_bounds_stride{name_suffix}"),
            params,
        }) as Box<dyn TestCase>);
    }

    misc_group
}
