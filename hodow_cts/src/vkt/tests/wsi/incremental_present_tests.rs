// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiIncrementalPresentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `headless` platform (SWAPCHAIN_EXTENT_SETS_WINDOW_SIZE, so only `scale_none`). Upstream's `iterate` renders one
// frame per call and recreates the swapchain when it reports VK_ERROR_OUT_OF_DATE_KHR; a headless surface never does, so every swapchain configuration is rendered for
// `FRAME_COUNT` frames in one `iterate` and an out of date swapchain fails the case. Programs `quad-vert` / `quad-frag` come from `shaders/manifest/wsi_incremental_present.toml`.

use std::collections::HashMap;
use std::ffi::{CString, c_void};
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrSwapchainExtensionDeviceCommands;

use super::maintenance1_tests::{ACQUIRE_IMAGE_TIMEOUT, PRESENT_MODES, Resources, check_wsi_success};
use super::surface_tests::Surface;
use super::swapchain_tests::compatible_queue_family_indices;
use crate::generated::shaders::wsi_incremental_present::INCREMENTAL_PRESENT;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_render_pass, end_render_pass, make_rect_2d};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::api::case_util::{CustomInstance, create_custom_instance, is_instance_extension_available};
use crate::vkt::{Context, TestCase, TestInstance};

const FRAME_COUNT: usize = 60 * 5;
const FENCE_COUNT: usize = 6;

#[derive(Clone, Copy)]
struct TestConfig {
    use_incremental_present: bool,
    present_mode: vk::PresentModeKHR,
    transform: vk::SurfaceTransformFlagsKHR,
    alpha: vk::CompositeAlphaFlagsKHR,
}

struct IncrementalPresentCase {
    name: &'static str,
    config: TestConfig,
}

impl TestCase for IncrementalPresentCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_swapchain")?;
        if self.config.use_incremental_present {
            context.require_device_functionality("VK_KHR_incremental_present")?;
        }
        for extension in ["VK_KHR_surface", "VK_EXT_headless_surface"] {
            if !is_instance_extension_available(context, extension) {
                return Err(TestError::NotSupported(format!(
                    "{extension} is not supported by this implementation"
                )));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        INCREMENTAL_PRESENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IncrementalPresentInstance {
            context,
            config: self.config,
        })
    }
}

struct IncrementalPresentInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

/// `getRenderFrameRect`
fn get_render_frame_rect(frame_ndx: usize, image_width: u32, image_height: u32) -> vk::Rect2D {
    let frame = frame_ndx as u32;
    let x = if frame_ndx == 0 {
        0
    } else {
        (frame % image_width).min(image_width - 1)
    };
    let y = if frame_ndx == 0 {
        0
    } else {
        (frame % image_height).min(image_height - 1)
    };
    let width = if frame_ndx == 0 {
        image_width
    } else {
        1 + (frame % 100.min(image_width / 3)).min(image_width - x - 1)
    };
    let height = if frame_ndx == 0 {
        image_height
    } else {
        1 + (frame % 100.min(image_height / 3)).min(image_height - y - 1)
    };
    make_rect_2d(x as i32, y as i32, width, height)
}

/// `getUpdatedRects`
fn get_updated_rects(first_frame_ndx: usize, last_frame_ndx: usize, width: u32, height: u32) -> Vec<vk::RectLayerKHR> {
    (first_frame_ndx..=last_frame_ndx)
        .map(|frame_ndx| {
            let rect = get_render_frame_rect(frame_ndx, width, height);
            vk::RectLayerKHR {
                offset: rect.offset,
                extent: rect.extent,
                layer: 0,
            }
        })
        .collect()
}

/// `cmdRenderFrame`
fn cmd_render_frame(
    device: &Device,
    command_buffer: vk::CommandBuffer,
    pipeline_layout: vk::PipelineLayout,
    pipeline: vk::Pipeline,
    frame_ndx: usize,
    image_width: u32,
    image_height: u32,
) {
    let mask = frame_ndx as u32;

    if frame_ndx == 0 {
        let scissor = make_rect_2d(0, 0, image_width, image_height);
        unsafe { device.cmd_set_scissor(command_buffer, 0, &[scissor]) };
        let attachment = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.25, 0.50, 0.75, 1.00],
                },
            },
        };
        let rect = vk::ClearRect {
            rect: scissor,
            base_array_layer: 0,
            layer_count: 1,
        };
        unsafe { device.cmd_clear_attachments(command_buffer, &[attachment], &[rect]) };
    }

    let scissor = get_render_frame_rect(frame_ndx, image_width, image_height);
    unsafe {
        device.cmd_set_scissor(command_buffer, 0, &[scissor]);
        device.cmd_push_constants(
            command_buffer,
            pipeline_layout,
            vk::ShaderStageFlags::FRAGMENT,
            0,
            &mask.to_ne_bytes(),
        );
        device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
        device.cmd_draw(command_buffer, 6, 1, 0, 0);
    }
}

/// `selectRepresentativeFormats`: one SRGB_NONLINEAR and one extended color space format
fn select_representative_formats(formats: &[vk::SurfaceFormatKHR]) -> Vec<vk::SurfaceFormatKHR> {
    let mut result = Vec::new();

    if let Some(format) = formats
        .iter()
        .find(|format| format.color_space == vk::ColorSpaceKHR::SRGB_NONLINEAR)
    {
        result.push(*format);
    }
    if let Some(format) = formats
        .iter()
        .find(|format| format.color_space != vk::ColorSpaceKHR::SRGB_NONLINEAR)
    {
        result.push(*format);
    }

    // If no formats matched use whatever is available
    if result.is_empty() && !formats.is_empty() {
        result.push(formats[0]);
    }
    result
}

/// `generateSwapchainConfigs` for `SCALING_NONE`
fn generate_swapchain_configs(
    surface: vk::SurfaceKHR,
    queue_family_index: &u32,
    properties: &vk::SurfaceCapabilitiesKHR,
    formats: &[vk::SurfaceFormatKHR],
    present_modes: &[vk::PresentModeKHR],
    config: &TestConfig,
) -> Result<Vec<vk::SwapchainCreateInfoKHR>, TestError> {
    let current_width = if properties.current_extent.width != 0xFFFF_FFFF {
        properties.current_extent.width
    } else {
        1024.min(
            properties.min_image_extent.width
                + (properties.max_image_extent.width - properties.min_image_extent.width) / 2,
        )
    };
    let current_height = if properties.current_extent.height != 0xFFFF_FFFF {
        properties.current_extent.height
    } else {
        1024.min(
            properties.min_image_extent.height
                + (properties.max_image_extent.height - properties.min_image_extent.height) / 2,
        )
    };

    let image_size = vk::Extent2D {
        width: current_width,
        height: current_height,
    };
    let unused_size = vk::Extent2D {
        width: 31.max(properties.min_image_extent.width),
        height: 31.max(properties.min_image_extent.height),
    };

    if !present_modes.contains(&config.present_mode) {
        return Err(TestError::NotSupported("Present mode not supported".to_string()));
    }
    if !properties.supported_transforms.contains(config.transform) {
        return Err(TestError::NotSupported("Transform not supported".to_string()));
    }
    if !properties.supported_composite_alpha.contains(config.alpha) {
        return Err(TestError::NotSupported("Composite alpha not supported".to_string()));
    }

    let mut create_infos = Vec::new();
    for format in select_representative_formats(formats) {
        let create_info = |image_extent: vk::Extent2D| vk::SwapchainCreateInfoKHR {
            surface,
            min_image_count: properties.min_image_count,
            image_format: format.format,
            image_color_space: format.color_space,
            image_extent,
            image_array_layers: 1,
            image_usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
            image_sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 1,
            queue_family_indices: queue_family_index,
            pre_transform: config.transform,
            composite_alpha: config.alpha,
            present_mode: config.present_mode,
            clipped: vk::FALSE,
            old_swapchain: vk::SwapchainKHR::null(),
            ..Default::default()
        };

        create_infos.push(create_info(image_size));
        // add an extra unused swapchain
        create_infos.push(create_info(unused_size));
    }
    Ok(create_infos)
}

fn create_incremental_present_instance(context: &Context<'_>) -> Result<CustomInstance, TestError> {
    let mut extensions = vec!["VK_KHR_surface", "VK_EXT_headless_surface"];
    // VUID-VkSwapchainCreateInfoKHR-imageColorSpace-parameter
    if is_instance_extension_available(context, "VK_EXT_swapchain_colorspace") {
        extensions.push("VK_EXT_swapchain_colorspace");
    }
    create_custom_instance(context, &extensions)
}

struct DeviceGuard(Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

/// `createDeviceWithWsi`
fn create_device_with_wsi(
    context: &Context<'_>,
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_family_index: u32,
    requires_incremental_present: bool,
) -> Result<DeviceGuard, TestError> {
    let mut extensions = vec!["VK_KHR_swapchain"];
    if requires_incremental_present {
        extensions.push("VK_KHR_incremental_present");
    }
    let has_fifo_latest_ready = context.is_device_functionality_supported("VK_EXT_present_mode_fifo_latest_ready");
    if has_fifo_latest_ready {
        extensions.push("VK_EXT_present_mode_fifo_latest_ready");
    }
    let extension_names = extensions
        .iter()
        .map(|extension| CString::new(*extension).map_err(|e| TestError::InternalError(e.to_string())))
        .collect::<Result<Vec<_>, _>>()?;
    let extension_ptrs: Vec<*const std::ffi::c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();

    let queue_priorities = [1.0f32];
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priorities)
        .build()];
    let mut fifo_latest_ready_features = vk::PhysicalDevicePresentModeFifoLatestReadyFeaturesKHR {
        present_mode_fifo_latest_ready: vk::TRUE,
        ..Default::default()
    };
    let mut info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extension_ptrs);
    if has_fifo_latest_ready {
        info = info.push_next(&mut fifo_latest_ready_features);
    }
    let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;
    Ok(DeviceGuard(device))
}

fn wait_forever(device: &Device, fence: vk::Fence) -> Result<(), TestError> {
    unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

impl IncrementalPresentInstance<'_> {
    /// One swapchain configuration: `initSwapchainResources`, `FRAME_COUNT` x `render`, `deinitSwapchainResources`
    #[allow(clippy::too_many_arguments)]
    fn run_config(
        &self,
        device: &Device,
        queue: vk::Queue,
        queue_family_index: u32,
        swapchain_info: &vk::SwapchainCreateInfoKHR,
        vertex_module: vk::ShaderModule,
        fragment_module: vk::ShaderModule,
        pipeline_layout: vk::PipelineLayout,
    ) -> Result<(), TestError> {
        let width = swapchain_info.image_extent.width;
        let height = swapchain_info.image_extent.height;
        let image_format = swapchain_info.image_format;

        let mut resources = Resources::new(device);
        let swapchain = resources.create_swapchain(swapchain_info)?;
        let swapchain_images =
            unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;
        let image_count = swapchain_images.len();
        resources.create_command_pool(queue_family_index)?;

        let mut image_next_frames = vec![0usize; image_count];
        let mut is_first = vec![true; image_count];

        // createRenderPass: the attachment is loaded and left in PRESENT_SRC_KHR
        let attachment = vk::AttachmentDescription::builder()
            .format(image_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::PRESENT_SRC_KHR);
        let attachments = [attachment];
        let color_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        resources.push_cleanup(move |device| unsafe { device.destroy_render_pass(render_pass, None) });

        // createPipeline: scissor is dynamic
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vertex_module)
                .name(b"main\0"),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(fragment_module)
                .name(b"main\0"),
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: width as f32,
            height: height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, width, height)];
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
            .blend_enable(false)];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
        // VUID-vkCmdDraw-None-08608
        let dynamic_states = [vk::DynamicState::SCISSOR];
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .color_blend_state(&color_blend_state)
            .dynamic_state(&dynamic_state)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0)
            .build();
        let pipeline = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?
            .0[0];
        resources.push_cleanup(move |device| unsafe { device.destroy_pipeline(pipeline, None) });

        let mut framebuffers = Vec::with_capacity(image_count);
        for &image in &swapchain_images {
            let view_info = vk::ImageViewCreateInfo::builder()
                .image(image)
                .view_type(vk::ImageViewType::_2D)
                .format(image_format)
                .components(vk::ComponentMapping::default())
                .subresource_range(vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                });
            let view = unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?;
            resources.push_cleanup(move |device| unsafe { device.destroy_image_view(view, None) });

            let views = [view];
            let framebuffer_info = vk::FramebufferCreateInfo::builder()
                .render_pass(render_pass)
                .attachments(&views)
                .width(width)
                .height(height)
                .layers(1);
            let framebuffer =
                unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?;
            resources.push_cleanup(move |device| unsafe { device.destroy_framebuffer(framebuffer, None) });
            framebuffers.push(framebuffer);
        }

        let mut free_acquire_semaphore = resources.create_semaphore()?;
        let mut free_render_semaphore = resources.create_semaphore()?;
        let mut acquire_semaphores = Vec::with_capacity(image_count);
        let mut render_semaphores = Vec::with_capacity(image_count);
        for _ in 0..image_count {
            acquire_semaphores.push(resources.create_semaphore()?);
        }
        for _ in 0..image_count {
            render_semaphores.push(resources.create_semaphore()?);
        }
        let mut fences = Vec::with_capacity(FENCE_COUNT);
        for _ in 0..FENCE_COUNT {
            fences.push(resources.create_fence()?);
        }
        let mut command_buffers = [vk::CommandBuffer::null(); FENCE_COUNT];

        for frame_ndx in 0..FRAME_COUNT {
            let fence = fences[frame_ndx % FENCE_COUNT];

            // Throttle execution
            if frame_ndx >= FENCE_COUNT {
                wait_forever(device, fence)?;
                unsafe { device.reset_fences(&[fence]) }.vk_check("vkResetFences")?;
                let old = command_buffers[frame_ndx % FENCE_COUNT];
                unsafe { device.free_command_buffers(resources.command_pool(), &[old]) };
                command_buffers[frame_ndx % FENCE_COUNT] = vk::CommandBuffer::null();
            }

            let current_acquire_semaphore = free_acquire_semaphore;
            let current_render_semaphore = free_render_semaphore;

            // Acquire next image
            let (image_index, code) = unsafe {
                device.acquire_next_image_khr(
                    swapchain,
                    ACQUIRE_IMAGE_TIMEOUT,
                    current_acquire_semaphore,
                    vk::Fence::null(),
                )
            }
            .vk_check("vkAcquireNextImageKHR")?;
            check_wsi_success(code, "vkAcquireNextImageKHR")?;
            let image_ndx = image_index as usize;

            // Create command buffer
            let image_next_frame = image_next_frames[image_ndx];
            let command_buffer = resources.allocate_command_buffers(1)?[0];
            command_buffers[frame_ndx % FENCE_COUNT] = command_buffer;
            unsafe {
                device
                    .begin_command_buffer(command_buffer, &vk::CommandBufferBeginInfo::default())
                    .vk_check("vkBeginCommandBuffer")?;

                let barrier = vk::ImageMemoryBarrier {
                    old_layout: if is_first[image_ndx] {
                        vk::ImageLayout::UNDEFINED
                    } else {
                        vk::ImageLayout::PRESENT_SRC_KHR
                    },
                    new_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                    dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                    image: swapchain_images[image_ndx],
                    subresource_range: vk::ImageSubresourceRange {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        base_mip_level: 0,
                        level_count: 1,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                    ..Default::default()
                };
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::BOTTOM_OF_PIPE | vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }

            begin_render_pass(
                device,
                command_buffer,
                render_pass,
                framebuffers[image_ndx],
                make_rect_2d(0, 0, width, height),
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.25, 0.5, 0.75, 1.0],
                    },
                },
            );
            for frame in image_next_frame..=frame_ndx {
                cmd_render_frame(device, command_buffer, pipeline_layout, pipeline, frame, width, height);
            }
            end_render_pass(device, command_buffer);
            unsafe { device.end_command_buffer(command_buffer) }.vk_check("vkEndCommandBuffer")?;

            image_next_frames[image_ndx] = frame_ndx + 1;
            is_first[image_ndx] = false;

            // Submit command buffer
            let wait_semaphores = [current_acquire_semaphore];
            let wait_stages = [vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT];
            let command_buffer_slice = [command_buffer];
            let signal_semaphores = [current_render_semaphore];
            let submit_info = vk::SubmitInfo::builder()
                .wait_semaphores(&wait_semaphores)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(&command_buffer_slice)
                .signal_semaphores(&signal_semaphores)
                .build();
            unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;

            // Present frame
            let mut result = vk::Result::SUCCESS;
            let rects = get_updated_rects(image_next_frame, frame_ndx, width, height);
            let region = vk::PresentRegionKHR {
                rectangle_count: rects.len() as u32,
                rectangles: if rects.is_empty() { ptr::null() } else { rects.as_ptr() },
            };
            let region_info = vk::PresentRegionsKHR {
                swapchain_count: 1,
                regions: &region,
                ..Default::default()
            };
            let present_info = vk::PresentInfoKHR {
                next: if self.config.use_incremental_present {
                    ptr::from_ref(&region_info).cast::<c_void>()
                } else {
                    ptr::null()
                },
                wait_semaphore_count: 1,
                wait_semaphores: &current_render_semaphore,
                swapchain_count: 1,
                swapchains: &swapchain,
                image_indices: &image_index,
                results: &mut result,
                ..Default::default()
            };
            let code = unsafe { device.queue_present_khr(queue, &present_info) }.vk_check("vkQueuePresentKHR")?;
            check_wsi_success(code, "vkQueuePresentKHR")?;
            if result != vk::Result::SUCCESS && result != vk::Result::SUBOPTIMAL_KHR {
                return Err(TestError::Fail(format!("vkQueuePresentKHR result is {result:?}")));
            }

            // VUID-vkAcquireNextImageKHR-semaphore-01779
            unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;

            free_acquire_semaphore = acquire_semaphores[image_ndx];
            acquire_semaphores[image_ndx] = current_acquire_semaphore;
            free_render_semaphore = render_semaphores[image_ndx];
            render_semaphores[image_ndx] = current_render_semaphore;
        }
        Ok(())
    }

    fn run(&self) -> TestOutcome {
        use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

        let context = self.context;
        let mut results = ResultCollector::new("");
        let helper = create_incremental_present_instance(context)?;
        let instance = &helper.instance;
        let physical_device = helper.physical_device;
        let surface = Surface::headless(instance)?;

        let queue_family_index = *compatible_queue_family_indices(instance, physical_device, surface.surface)?
            .first()
            .ok_or_else(|| {
                TestError::NotSupported("Device does not support presentation to the given surfaces".to_string())
            })?;
        let device_guard = create_device_with_wsi(
            context,
            instance,
            physical_device,
            queue_family_index,
            self.config.use_incremental_present,
        )?;
        let device = &device_guard.0;
        let queue = unsafe { device.get_device_queue(queue_family_index, 0) };

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("quad-vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("quad-frag")?)?;

        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 4,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout =
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;

        let properties =
            unsafe { instance.get_physical_device_surface_capabilities_khr(physical_device, surface.surface) }
                .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
        let formats = unsafe { instance.get_physical_device_surface_formats_khr(physical_device, surface.surface) }
            .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
        let present_modes =
            unsafe { instance.get_physical_device_surface_present_modes_khr(physical_device, surface.surface) }
                .vk_check("vkGetPhysicalDeviceSurfacePresentModesKHR")?;

        let configs = generate_swapchain_configs(
            surface.surface,
            &queue_family_index,
            &properties,
            &formats,
            &present_modes,
            &self.config,
        );
        let outcome = configs.and_then(|configs| {
            for swapchain_info in &configs {
                log::info!("Swapchain: {swapchain_info:?}");
                if let Err(error) = self.run_config(
                    device,
                    queue,
                    queue_family_index,
                    swapchain_info,
                    *vertex_module,
                    *fragment_module,
                    pipeline_layout,
                ) {
                    match error {
                        TestError::Fail(message) => results.fail(message),
                        other => return Err(other),
                    }
                }
            }
            Ok(())
        });

        unsafe {
            let _ = device.device_wait_idle();
            device.destroy_pipeline_layout(pipeline_layout, None);
        }
        outcome?;
        Ok(results.to_status())
    }
}

impl TestInstance for IncrementalPresentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `createIncrementalPresentTests` for the headless platform: only `scale_none`
pub fn create_headless_incremental_present_cases() -> HashMap<String, Box<dyn TestCase>> {
    const MODES: [vk::PresentModeKHR; 5] = [
        vk::PresentModeKHR::IMMEDIATE,
        vk::PresentModeKHR::MAILBOX,
        vk::PresentModeKHR::FIFO,
        vk::PresentModeKHR::FIFO_RELAXED,
        vk::PresentModeKHR::FIFO_LATEST_READY,
    ];
    const TRANSFORMS: [(vk::SurfaceTransformFlagsKHR, &str); 9] = [
        (vk::SurfaceTransformFlagsKHR::IDENTITY, "identity"),
        (vk::SurfaceTransformFlagsKHR::ROTATE_90, "rotate_90"),
        (vk::SurfaceTransformFlagsKHR::ROTATE_180, "rotate_180"),
        (vk::SurfaceTransformFlagsKHR::ROTATE_270, "rotate_270"),
        (vk::SurfaceTransformFlagsKHR::HORIZONTAL_MIRROR, "horizontal_mirror"),
        (
            vk::SurfaceTransformFlagsKHR::HORIZONTAL_MIRROR_ROTATE_90,
            "horizontal_mirror_rotate_90",
        ),
        (
            vk::SurfaceTransformFlagsKHR::HORIZONTAL_MIRROR_ROTATE_180,
            "horizontal_mirror_rotate_180",
        ),
        (
            vk::SurfaceTransformFlagsKHR::HORIZONTAL_MIRROR_ROTATE_270,
            "horizontal_mirror_rotate_270",
        ),
        (vk::SurfaceTransformFlagsKHR::INHERIT, "inherit"),
    ];
    const ALPHAS: [(vk::CompositeAlphaFlagsKHR, &str); 4] = [
        (vk::CompositeAlphaFlagsKHR::OPAQUE, "opaque"),
        (vk::CompositeAlphaFlagsKHR::PRE_MULTIPLIED, "pre_multiplied"),
        (vk::CompositeAlphaFlagsKHR::POST_MULTIPLIED, "post_multiplied"),
        (vk::CompositeAlphaFlagsKHR::INHERIT, "inherit"),
    ];
    let mode_names: Vec<&str> = PRESENT_MODES.iter().map(|&(_, name)| name).collect();
    let mode_name = |mode: vk::PresentModeKHR| {
        PRESENT_MODES
            .iter()
            .position(|&(candidate, _)| candidate == mode)
            .map(|index| mode_names[index])
            .unwrap_or("unknown")
    };

    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for mode in MODES {
        for (transform, transform_name) in TRANSFORMS {
            for (alpha, alpha_name) in ALPHAS {
                for (name, use_incremental_present) in [("reference", false), ("incremental_present", true)] {
                    cases.insert(
                        format!(
                            "headless.incremental_present.scale_none.{}.{transform_name}.{alpha_name}.{name}",
                            mode_name(mode)
                        ),
                        Box::new(IncrementalPresentCase {
                            name,
                            config: TestConfig {
                                use_incremental_present,
                                present_mode: mode,
                                transform,
                                alpha,
                            },
                        }),
                    );
                }
            }
        }
    }
    cases
}
