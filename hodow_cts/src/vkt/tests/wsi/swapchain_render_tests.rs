// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiSwapchainTests.cpp (`basicRenderTest`, `multiSwapchainRenderTest`)
//   external/vulkancts/framework/vulkan/vkWsiUtil.cpp (`WsiTriangleRenderer`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `headless.swapchain.render.{basic,basic2,2swapchains,2swapchains2,10swapchains,10swapchains2}`: a rotating triangle is
// drawn into the images of one or several swapchains of headless surfaces (`basic` and `basic2` are the one swapchain case of the multi swapchain loop: 600 frames
// with a present per frame, upstream's `basicRenderTest`; the others accumulate one frame per swapchain and present them together). `FrameStreamObjects` is
// replaced by rotating fences, semaphores and command buffers per swapchain. The `*2` cases acquire with vkAcquireNextImage2KHR (VK_KHR_device_group). The
// `device_group` cases stay gated. `headless.swapchain.modify.resize` (`resizeSwapchainTest`) renders 60 frames into each of three swapchains of sizes 128, 256 and 512 square clamped to the surface limits, each created with the previous one as oldSwapchain. The `WsiTriangleRenderer` is `Renderer` (the explicit layout transitions variant is not needed here). Programs `tri-vert` and
// `tri-frag` come from `shaders/manifest/wsi_swapchain_render.toml`. The cases are returned keyed by their dotted path so `wsi::create_tests` can swap them in for
// the gated names.

use std::collections::HashMap;
use std::ffi::c_void;
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrSwapchainExtensionDeviceCommands;

use super::maintenance1_tests::{
    Resources, check_wsi_success, create_device, device_extensions, get_basic_swapchain_parameters,
};
use super::surface_tests::{Surface, common_check_support, instance_helper};
use super::swapchain_tests::compatible_queue_family_indices;
use crate::generated::shaders::wsi_swapchain_render::SWAPCHAIN_RENDER;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_render_pass, end_render_pass, make_rect_2d};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, make_buffer_create_info, make_framebuffer, make_graphics_pipeline,
    make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::api::case_util::is_instance_extension_available;
use crate::vkt::{Context, TestCase, TestInstance};

const DESIRED_SIZE: (u32, u32) = (256, 256);

/// `WsiTriangleRenderer` with `explicitLayoutTransitions` false
struct Renderer<'a> {
    device: &'a Device,
    render_size: (u32, u32),
    render_pass: Unique<'a, vk::RenderPass>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pipeline: Unique<'a, vk::Pipeline>,
    vertex_buffer: BufferWithMemory<'a>,
    _attachment_views: Vec<Unique<'a, vk::ImageView>>,
    framebuffers: Vec<Unique<'a, vk::Framebuffer>>,
    swapchain_images: Vec<vk::Image>,
    attachment_layouts: Vec<vk::ImageLayout>,
}

impl<'a> Renderer<'a> {
    fn new(
        context: &'a Context<'a>,
        device: &'a Device,
        swapchain_images: &[vk::Image],
        framebuffer_format: vk::Format,
        render_size: (u32, u32),
    ) -> Result<Self, TestError> {
        // createRenderPass
        let attachment = vk::AttachmentDescription::builder()
            .format(framebuffer_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::PRESENT_SRC_KHR);
        let attachments = [attachment];
        let color_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)];
        let dependencies = [
            vk::SubpassDependency {
                src_subpass: vk::SUBPASS_EXTERNAL,
                dst_subpass: 0,
                src_stage_mask: vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                src_access_mask: vk::AccessFlags::MEMORY_READ,
                dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            },
            vk::SubpassDependency {
                src_subpass: 0,
                dst_subpass: vk::SUBPASS_EXTERNAL,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::MEMORY_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            },
        ];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // createPipelineLayout, createPipeline
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: 4,
        }];
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &push_constant_ranges)?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("tri-vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("tri-frag")?)?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *vertex_module,
            *fragment_module,
            *render_pass,
            render_size,
            vk::PrimitiveTopology::TRIANGLE_LIST,
        )?;

        // The vertex buffer
        let vertices: [[f32; 4]; 3] = [[-0.5, -0.5, 0.0, 1.0], [0.5, -0.5, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0]];
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of_val(&vertices) as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertices),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // The attachment views and framebuffers
        let mut attachment_views = Vec::with_capacity(swapchain_images.len());
        let mut framebuffers = Vec::with_capacity(swapchain_images.len());
        for &image in swapchain_images {
            let view_info = vk::ImageViewCreateInfo::builder()
                .image(image)
                .view_type(vk::ImageViewType::_2D)
                .format(framebuffer_format)
                .components(vk::ComponentMapping::default())
                .subresource_range(vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                });
            let view = Unique::new(
                device,
                unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
            );
            framebuffers.push(make_framebuffer(
                device,
                *render_pass,
                &[*view],
                render_size.0,
                render_size.1,
                1,
            )?);
            attachment_views.push(view);
        }

        Ok(Self {
            device,
            render_size,
            render_pass,
            pipeline_layout,
            pipeline,
            vertex_buffer,
            _attachment_views: attachment_views,
            framebuffers,
            swapchain_images: swapchain_images.to_vec(),
            attachment_layouts: vec![vk::ImageLayout::UNDEFINED; swapchain_images.len()],
        })
    }

    /// `recordFrame`
    fn record_frame(
        &mut self,
        command_buffer: vk::CommandBuffer,
        image_ndx: usize,
        frame_ndx: u32,
    ) -> Result<(), TestError> {
        let device = self.device;
        unsafe { device.begin_command_buffer(command_buffer, &vk::CommandBufferBeginInfo::default()) }
            .vk_check("vkBeginCommandBuffer")?;

        if self.attachment_layouts[image_ndx] == vk::ImageLayout::UNDEFINED {
            let barrier = vk::ImageMemoryBarrier {
                old_layout: self.attachment_layouts[image_ndx],
                new_layout: vk::ImageLayout::PRESENT_SRC_KHR,
                src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                image: self.swapchain_images[image_ndx],
                subresource_range: vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                ..Default::default()
            };
            unsafe {
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                )
            };
            self.attachment_layouts[image_ndx] = vk::ImageLayout::PRESENT_SRC_KHR;
        }

        begin_render_pass(
            device,
            command_buffer,
            *self.render_pass,
            *self.framebuffers[image_ndx],
            make_rect_2d(0, 0, self.render_size.0, self.render_size.1),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.125, 0.25, 0.75, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, *self.pipeline);
            device.cmd_bind_vertex_buffers(command_buffer, 0, &[self.vertex_buffer.get()], &[0]);
            device.cmd_push_constants(
                command_buffer,
                *self.pipeline_layout,
                vk::ShaderStageFlags::VERTEX,
                0,
                &frame_ndx.to_ne_bytes(),
            );
            device.cmd_draw(command_buffer, 3, 1, 0, 0);
        }
        end_render_pass(device, command_buffer);

        unsafe { device.end_command_buffer(command_buffer) }.vk_check("vkEndCommandBuffer")
    }
}

/// The rotating objects of one swapchain (`FrameStreamObjects`)
struct FrameStream {
    fences: Vec<vk::Fence>,
    image_ready_semaphores: Vec<vk::Semaphore>,
    render_complete_semaphores: Vec<vk::Semaphore>,
    command_buffers: Vec<vk::CommandBuffer>,
    counter: usize,
}

fn create_frame_stream(resources: &mut Resources<'_>, max_queued_frames: usize) -> Result<FrameStream, TestError> {
    let mut stream = FrameStream {
        fences: Vec::new(),
        image_ready_semaphores: Vec::new(),
        render_complete_semaphores: Vec::new(),
        command_buffers: resources.allocate_command_buffers(max_queued_frames)?,
        counter: 0,
    };
    for _ in 0..max_queued_frames {
        stream.fences.push(resources.create_signaled_fence()?);
        stream.render_complete_semaphores.push(resources.create_semaphore()?);
    }
    // maxQueuedFrames + 1 image ready semaphores: one is passed together with the fence that meters the rendering
    for _ in 0..=max_queued_frames {
        stream.image_ready_semaphores.push(resources.create_semaphore()?);
    }
    Ok(stream)
}

struct RenderCase {
    name: &'static str,
    swapchain_count: usize,
    use_acquire2: bool,
    /// `basicRenderTest` (a present per frame, 600 frames) or `multiSwapchainRenderTest` (3 seconds of frames per swapchain, presented together)
    multi: bool,
}

impl TestCase for RenderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context)?;
        context.require_device_functionality("VK_KHR_swapchain")
    }

    fn programs(&self) -> BinaryCollection {
        SWAPCHAIN_RENDER.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RenderInstance {
            context,
            swapchain_count: self.swapchain_count,
            use_acquire2: self.use_acquire2,
            multi: self.multi,
        })
    }
}

struct RenderInstance<'a> {
    context: &'a Context<'a>,
    swapchain_count: usize,
    use_acquire2: bool,
    multi: bool,
}

impl RenderInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let count = self.swapchain_count;

        if self.use_acquire2 && !context.is_device_functionality_supported("VK_KHR_device_group") {
            return Err(TestError::NotSupported(
                "Required extension is not supported".to_string(),
            ));
        }

        let helper = instance_helper(context, &[])?;
        let instance = &helper.instance;
        let physical_device = helper.physical_device;
        let mut surfaces = Vec::with_capacity(count);
        for _ in 0..count {
            surfaces.push(Surface::headless(instance)?);
        }

        // A device compatible with all surfaces (headless surfaces share their support)
        let dev = create_device(
            context,
            instance,
            physical_device,
            surfaces[0].surface,
            false,
            self.use_acquire2,
            false,
        )?;
        let device = &dev.device;

        let mut resources = Resources::new(device);
        let mut swapchain_infos = Vec::with_capacity(count);
        let mut swapchains = Vec::with_capacity(count);
        let mut swapchain_images: Vec<Vec<vk::Image>> = Vec::with_capacity(count);
        for surface in &surfaces {
            let info =
                get_basic_swapchain_parameters_for_render(instance, physical_device, surface.surface, DESIRED_SIZE)?;
            let swapchain = resources.create_swapchain(&info)?;
            swapchain_images
                .push(unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?);
            swapchain_infos.push(info);
            swapchains.push(swapchain);
        }

        let mut renderers = Vec::with_capacity(count);
        for index in 0..count {
            renderers.push(Renderer::new(
                context,
                device,
                &swapchain_images[index],
                swapchain_infos[index].image_format,
                (
                    swapchain_infos[index].image_extent.width,
                    swapchain_infos[index].image_extent.height,
                ),
            )?);
        }

        resources.create_command_pool(dev.queue_family_index)?;
        let max_queued_frames = swapchain_images[0].len() * 2;
        let mut streams = Vec::with_capacity(count);
        for _ in 0..count {
            streams.push(create_frame_stream(&mut resources, max_queued_frames)?);
        }

        let num_frames_to_render = if self.multi { 60 * 3 * count } else { 60 * 10 };
        let mut accumulated_semaphores: Vec<vk::Semaphore> = Vec::new();
        let mut accumulated_swapchains: Vec<vk::SwapchainKHR> = Vec::new();
        let mut accumulated_indices: Vec<u32> = Vec::new();

        for frame_ndx in 0..num_frames_to_render {
            let swapchain_index = frame_ndx % count;
            let stream = &mut streams[swapchain_index];
            let counter = stream.counter;
            stream.counter += 1;
            let fence = stream.fences[counter % stream.fences.len()];
            let image_ready_semaphore = stream.image_ready_semaphores[counter % stream.image_ready_semaphores.len()];
            let render_complete_semaphore =
                stream.render_complete_semaphores[counter % stream.render_complete_semaphores.len()];
            let command_buffer = stream.command_buffers[counter % stream.command_buffers.len()];

            unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
            unsafe { device.reset_fences(&[fence]) }.vk_check("vkResetFences")?;

            let (image_ndx, acquire_code) = if self.use_acquire2 {
                let acquire_info = vk::AcquireNextImageInfoKHR {
                    swapchain: swapchains[swapchain_index],
                    timeout: u64::MAX,
                    semaphore: image_ready_semaphore,
                    fence: vk::Fence::null(),
                    device_mask: 1,
                    ..Default::default()
                };
                unsafe { device.acquire_next_image2_khr(&acquire_info) }.vk_check("vkAcquireNextImage2KHR")?
            } else {
                unsafe {
                    device.acquire_next_image_khr(
                        swapchains[swapchain_index],
                        u64::MAX,
                        image_ready_semaphore,
                        vk::Fence::null(),
                    )
                }
                .vk_check("vkAcquireNextImageKHR")?
            };
            check_wsi_success(acquire_code, "vkAcquireNextImage")?;
            if image_ndx as usize >= swapchain_images[swapchain_index].len() {
                return Err(TestError::Fail("acquired image index out of range".to_string()));
            }

            renderers[swapchain_index].record_frame(command_buffer, image_ndx as usize, frame_ndx as u32)?;

            let wait_semaphores = [image_ready_semaphore];
            let wait_stages = [vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT];
            let command_buffers = [command_buffer];
            let signal_semaphores = [render_complete_semaphore];
            let submit_info = vk::SubmitInfo::builder()
                .wait_semaphores(&wait_semaphores)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(&command_buffers)
                .signal_semaphores(&signal_semaphores)
                .build();
            unsafe { device.queue_submit(dev.queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;

            // Save present information for the current frame, present when one frame per swapchain has been accumulated
            accumulated_semaphores.push(render_complete_semaphore);
            accumulated_swapchains.push(swapchains[swapchain_index]);
            accumulated_indices.push(image_ndx);

            if accumulated_semaphores.len() == count {
                let mut results = vec![vk::Result::ERROR_DEVICE_LOST; count];
                let present_info = vk::PresentInfoKHR {
                    next: ptr::null::<c_void>(),
                    wait_semaphore_count: accumulated_semaphores.len() as u32,
                    wait_semaphores: accumulated_semaphores.as_ptr(),
                    swapchain_count: accumulated_swapchains.len() as u32,
                    swapchains: accumulated_swapchains.as_ptr(),
                    image_indices: accumulated_indices.as_ptr(),
                    results: results.as_mut_ptr(),
                    ..Default::default()
                };
                let code =
                    unsafe { device.queue_present_khr(dev.queue, &present_info) }.vk_check("vkQueuePresentKHR")?;
                check_wsi_success(code, "vkQueuePresentKHR")?;
                for result in &results {
                    if *result != vk::Result::SUCCESS && *result != vk::Result::SUBOPTIMAL_KHR {
                        return Err(TestError::Fail(format!("vkQueuePresentKHR result is {result:?}")));
                    }
                }
                accumulated_semaphores.clear();
                accumulated_swapchains.clear();
                accumulated_indices.clear();
            }
        }

        unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
        // Renderers hold objects of the device that `Resources` destroys last; drop them first
        drop(renderers);
        Ok(TestStatus::pass("Rendering tests succeeded"))
    }
}

impl TestInstance for RenderInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `getBasicSwapchainParameters(wsiType, vki, physicalDevice, surface, desiredSize, 2)` of vktWsiSwapchainTests.cpp for the headless platform
fn get_basic_swapchain_parameters_for_render(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
    desired_size: (u32, u32),
) -> Result<vk::SwapchainCreateInfoKHR, TestError> {
    use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

    let capabilities = unsafe { instance.get_physical_device_surface_capabilities_khr(physical_device, surface) }
        .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
    let formats = unsafe { instance.get_physical_device_surface_formats_khr(physical_device, surface) }
        .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
    let format = *formats
        .first()
        .ok_or_else(|| TestError::Fail("the surface reports no formats".to_string()))?;
    let max_image_count = if capabilities.max_image_count > 0 {
        capabilities.max_image_count
    } else {
        capabilities.min_image_count + 2
    };
    let mut info = get_basic_swapchain_parameters(
        surface,
        format,
        desired_size,
        vk::PresentModeKHR::FIFO,
        if capabilities
            .supported_transforms
            .contains(vk::SurfaceTransformFlagsKHR::IDENTITY)
        {
            vk::SurfaceTransformFlagsKHR::IDENTITY
        } else {
            capabilities.current_transform
        },
        vk::CompositeAlphaFlagsKHR::OPAQUE,
        2u32.max(capabilities.min_image_count).min(max_image_count),
        false,
    );
    info.image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT;
    Ok(info)
}

/// `getSwapchainSizeSequence`
fn get_swapchain_size_sequence(capabilities: &vk::SurfaceCapabilitiesKHR, default_size: (u32, u32)) -> Vec<(u32, u32)> {
    [
        (default_size.0 / 2, default_size.1 / 2),
        default_size,
        (default_size.0 * 2, default_size.1 * 2),
    ]
    .into_iter()
    .map(|(width, height)| {
        (
            width.clamp(
                capabilities.min_image_extent.width,
                capabilities
                    .max_image_extent
                    .width
                    .max(capabilities.min_image_extent.width),
            ),
            height.clamp(
                capabilities.min_image_extent.height,
                capabilities
                    .max_image_extent
                    .height
                    .max(capabilities.min_image_extent.height),
            ),
        )
    })
    .collect()
}

/// `resizeSwapchainTest`
struct ResizeCase;

impl TestCase for ResizeCase {
    fn name(&self) -> &str {
        "resize"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context)?;
        context.require_device_functionality("VK_KHR_swapchain")
    }

    fn programs(&self) -> BinaryCollection {
        SWAPCHAIN_RENDER.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ResizeInstance { context })
    }
}

struct ResizeInstance<'a> {
    context: &'a Context<'a>,
}

impl ResizeInstance<'_> {
    fn run(&self) -> TestOutcome {
        use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

        let context = self.context;
        let helper = instance_helper(context, &[])?;
        let instance = &helper.instance;
        let physical_device = helper.physical_device;
        let surface = Surface::headless(instance)?;
        let dev = create_device(context, instance, physical_device, surface.surface, false, false, false)?;
        let device = &dev.device;
        let capabilities =
            unsafe { instance.get_physical_device_surface_capabilities_khr(physical_device, surface.surface) }
                .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
        let sizes = get_swapchain_size_sequence(&capabilities, DESIRED_SIZE);

        let mut resources = Resources::new(device);
        resources.create_command_pool(dev.queue_family_index)?;
        let mut prev_swapchain = vk::SwapchainKHR::null();

        for size in sizes {
            let mut info = get_basic_swapchain_parameters_for_render(instance, physical_device, surface.surface, size)?;
            info.old_swapchain = prev_swapchain;
            let swapchain = resources.create_swapchain(&info)?;
            let images = unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;
            let mut renderer = Renderer::new(
                context,
                device,
                &images,
                info.image_format,
                (info.image_extent.width, info.image_extent.height),
            )?;
            let max_queued_frames = images.len() * 2;
            let mut stream = create_frame_stream(&mut resources, max_queued_frames)?;

            for frame_ndx in 0..60u32 {
                let counter = stream.counter;
                stream.counter += 1;
                let fence = stream.fences[counter % stream.fences.len()];
                let image_ready_semaphore =
                    stream.image_ready_semaphores[counter % stream.image_ready_semaphores.len()];
                let render_complete_semaphore =
                    stream.render_complete_semaphores[counter % stream.render_complete_semaphores.len()];
                let command_buffer = stream.command_buffers[counter % stream.command_buffers.len()];

                unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
                unsafe { device.reset_fences(&[fence]) }.vk_check("vkResetFences")?;

                let (image_ndx, acquire_code) = unsafe {
                    device.acquire_next_image_khr(swapchain, u64::MAX, image_ready_semaphore, vk::Fence::null())
                }
                .vk_check("vkAcquireNextImageKHR")?;
                check_wsi_success(acquire_code, "vkAcquireNextImage")?;
                if image_ndx as usize >= images.len() {
                    return Err(TestError::Fail("acquired image index out of range".to_string()));
                }

                renderer.record_frame(command_buffer, image_ndx as usize, frame_ndx)?;

                let wait_semaphores = [image_ready_semaphore];
                let wait_stages = [vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT];
                let command_buffers = [command_buffer];
                let signal_semaphores = [render_complete_semaphore];
                let submit_info = vk::SubmitInfo::builder()
                    .wait_semaphores(&wait_semaphores)
                    .wait_dst_stage_mask(&wait_stages)
                    .command_buffers(&command_buffers)
                    .signal_semaphores(&signal_semaphores)
                    .build();
                unsafe { device.queue_submit(dev.queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;

                let swapchains = [swapchain];
                let image_indices = [image_ndx];
                let present_info = vk::PresentInfoKHR::builder()
                    .wait_semaphores(&signal_semaphores)
                    .swapchains(&swapchains)
                    .image_indices(&image_indices);
                let code =
                    unsafe { device.queue_present_khr(dev.queue, &present_info) }.vk_check("vkQueuePresentKHR")?;
                check_wsi_success(code, "vkQueuePresentKHR")?;
            }

            unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
            drop(renderer);
            prev_swapchain = swapchain;
        }

        Ok(TestStatus::pass("Resizing tests succeeded"))
    }
}

impl TestInstance for ResizeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `ImageSwapchainCreateInfoParams`
struct ImageSwapchainCase {
    name: &'static str,
    concurrent: bool,
}

impl TestCase for ImageSwapchainCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkImageSwapchainCreateSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context)?;
        for extension in ["VK_KHR_device_group_creation"] {
            if !is_instance_extension_available(context, extension) {
                return Err(TestError::NotSupported(format!(
                    "{extension} is not supported by this implementation"
                )));
            }
        }
        context.require_device_functionality("VK_KHR_bind_memory2")?;
        context.require_device_functionality("VK_KHR_swapchain")
    }

    fn programs(&self) -> BinaryCollection {
        SWAPCHAIN_RENDER.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageSwapchainInstance {
            context,
            concurrent: self.concurrent,
        })
    }
}

struct ImageSwapchainInstance<'a> {
    context: &'a Context<'a>,
    concurrent: bool,
}

impl ImageSwapchainInstance<'_> {
    /// `testImageSwapchainCreateInfo`
    fn run(&self) -> TestOutcome {
        use vulkanalia::prelude::v1_1::DeviceV1_1;

        let context = self.context;
        let desired_size = (256u32, 256u32);
        let helper = instance_helper(context, &["VK_KHR_device_group_creation"])?;
        let instance = &helper.instance;
        let physical_device = helper.physical_device;
        let surface = Surface::headless(instance)?;

        // DeviceHelper with requestSecondQueue: a second family (compute only, else transfer only) next to the presentation family
        let queue_family_index = compatible_queue_family_indices(instance, physical_device, surface.surface)?
            .first()
            .copied()
            .ok_or_else(|| {
                TestError::NotSupported("Device does not support presentation to the given surfaces".to_string())
            })?;
        let second_queue_family_index = context
            .get_compute_queue()
            .or_else(|| context.get_transfer_queue())
            .map(|(_, index)| index)
            .ok_or_else(|| TestError::NotSupported("Required queueFamilyIndex is not supported".to_string()))?;

        let extensions = device_extensions(context, false, true, false);
        let extension_names = extensions
            .iter()
            .map(|extension| std::ffi::CString::new(*extension).map_err(|e| TestError::InternalError(e.to_string())))
            .collect::<Result<Vec<_>, _>>()?;
        let extension_ptrs: Vec<*const std::ffi::c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();
        let queue_priorities = [1.0f32];
        let mut queue_infos = vec![
            vk::DeviceQueueCreateInfo::builder()
                .queue_family_index(queue_family_index)
                .queue_priorities(&queue_priorities)
                .build(),
        ];
        if second_queue_family_index != queue_family_index {
            queue_infos.push(
                vk::DeviceQueueCreateInfo::builder()
                    .queue_family_index(second_queue_family_index)
                    .queue_priorities(&queue_priorities)
                    .build(),
            );
        }
        let device_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&extension_ptrs);
        let device =
            unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?;
        let queue = unsafe { device.get_device_queue(queue_family_index, 0) };

        let queue_family_indices = [queue_family_index, second_queue_family_index];
        let (sharing_mode, queue_family_index_count, queue_family_indices_ptr) = if self.concurrent {
            (vk::SharingMode::CONCURRENT, 2u32, queue_family_indices.as_ptr())
        } else {
            (vk::SharingMode::EXCLUSIVE, 0u32, ptr::null())
        };

        let mut swapchain_info =
            get_basic_swapchain_parameters_for_render(instance, physical_device, surface.surface, desired_size)?;
        swapchain_info.image_sharing_mode = sharing_mode;
        swapchain_info.queue_family_index_count = queue_family_index_count;
        swapchain_info.queue_family_indices = queue_family_indices_ptr;

        let mut resources = Resources::new(&device);
        let swapchain = resources.create_swapchain(&swapchain_info)?;
        let num_images = unsafe { device.get_swapchain_images_khr(swapchain) }
            .vk_check("vkGetSwapchainImagesKHR")?
            .len();
        if num_images == 0 {
            return Ok(TestStatus::pass("Pass"));
        }

        let image_swapchain_info = vk::ImageSwapchainCreateInfoKHR {
            swapchain,
            ..Default::default()
        };
        let image_info = vk::ImageCreateInfo {
            next: ptr::from_ref(&image_swapchain_info).cast::<c_void>(),
            image_type: vk::ImageType::_2D,
            format: swapchain_info.image_format,
            extent: vk::Extent3D {
                width: swapchain_info.image_extent.width,
                height: swapchain_info.image_extent.height,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
            sharing_mode,
            queue_family_index_count,
            queue_family_indices: queue_family_indices_ptr,
            initial_layout: vk::ImageLayout::UNDEFINED,
            ..Default::default()
        };

        let mut images = Vec::with_capacity(num_images);
        let mut bind_swapchain_infos = Vec::with_capacity(num_images);
        for index in 0..num_images {
            let image = unsafe { device.create_image(&image_info, None) }.vk_check("vkCreateImage")?;
            resources.push_cleanup(move |device| unsafe { device.destroy_image(image, None) });
            images.push(image);
            bind_swapchain_infos.push(vk::BindImageMemorySwapchainInfoKHR {
                swapchain,
                image_index: index as u32,
                ..Default::default()
            });
        }
        // The memory is VK_NULL_HANDLE because the swapchain info in the chain supplies it
        let bind_infos: Vec<vk::BindImageMemoryInfo> = images
            .iter()
            .zip(&bind_swapchain_infos)
            .map(|(&image, swapchain_info)| vk::BindImageMemoryInfo {
                next: ptr::from_ref(swapchain_info).cast::<c_void>(),
                image,
                memory: vk::DeviceMemory::null(),
                memory_offset: 0,
                ..Default::default()
            })
            .collect();
        unsafe { device.bind_image_memory2(&bind_infos) }.vk_check("vkBindImageMemory2")?;

        let renderer_result = (|| -> TestOutcome {
            let mut renderer = Renderer::new(
                context,
                &device,
                &images,
                swapchain_info.image_format,
                (swapchain_info.image_extent.width, swapchain_info.image_extent.height),
            )?;

            resources.create_command_pool(queue_family_index)?;
            let max_queued_frames = images.len() * 2;
            let stream = create_frame_stream(&mut resources, max_queued_frames)?;

            for frame_ndx in 0..60u32 {
                let counter = frame_ndx as usize;
                let fence = stream.fences[counter % stream.fences.len()];
                let image_ready_semaphore =
                    stream.image_ready_semaphores[counter % stream.image_ready_semaphores.len()];
                let render_complete_semaphore =
                    stream.render_complete_semaphores[counter % stream.render_complete_semaphores.len()];
                let command_buffer = stream.command_buffers[counter % stream.command_buffers.len()];

                unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
                unsafe { device.reset_fences(&[fence]) }.vk_check("vkResetFences")?;

                let acquire_info = vk::AcquireNextImageInfoKHR {
                    swapchain,
                    timeout: u64::MAX,
                    semaphore: image_ready_semaphore,
                    fence: vk::Fence::null(),
                    device_mask: 1,
                    ..Default::default()
                };
                let (image_ndx, acquire_code) =
                    unsafe { device.acquire_next_image2_khr(&acquire_info) }.vk_check("vkAcquireNextImage2KHR")?;
                check_wsi_success(acquire_code, "vkAcquireNextImage2KHR")?;
                if image_ndx as usize >= images.len() {
                    return Err(TestError::Fail("acquired image index out of range".to_string()));
                }

                renderer.record_frame(command_buffer, image_ndx as usize, frame_ndx)?;

                let wait_semaphores = [image_ready_semaphore];
                let wait_stages = [vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT];
                let command_buffers = [command_buffer];
                let signal_semaphores = [render_complete_semaphore];
                let submit_info = vk::SubmitInfo::builder()
                    .wait_semaphores(&wait_semaphores)
                    .wait_dst_stage_mask(&wait_stages)
                    .command_buffers(&command_buffers)
                    .signal_semaphores(&signal_semaphores)
                    .build();
                unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;

                let swapchains = [swapchain];
                let image_indices = [image_ndx];
                let present_info = vk::PresentInfoKHR::builder()
                    .wait_semaphores(&signal_semaphores)
                    .swapchains(&swapchains)
                    .image_indices(&image_indices);
                let code = unsafe { device.queue_present_khr(queue, &present_info) }.vk_check("vkQueuePresentKHR")?;
                check_wsi_success(code, "vkQueuePresentKHR")?;
            }

            unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
            Ok(TestStatus::pass("Pass"))
        })();
        if renderer_result.is_err() {
            let _ = unsafe { device.device_wait_idle() };
        }
        drop(resources);
        unsafe { device.destroy_device(None) };
        renderer_result
    }
}

impl TestInstance for ImageSwapchainInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// The `headless.swapchain.render.*` cases keyed by their dotted path
pub fn create_headless_render_cases() -> HashMap<String, Box<dyn TestCase>> {
    let cases = [
        ("basic", 1, false, false),
        ("basic2", 1, true, false),
        ("2swapchains", 2, false, true),
        ("2swapchains2", 2, true, true),
        ("10swapchains", 10, false, true),
        ("10swapchains2", 10, true, true),
    ];
    cases
        .into_iter()
        .map(|(name, swapchain_count, use_acquire2, multi)| {
            (
                format!("headless.swapchain.render.{name}"),
                Box::new(RenderCase {
                    name,
                    swapchain_count,
                    use_acquire2,
                    multi,
                }) as Box<dyn TestCase>,
            )
        })
        .chain(std::iter::once((
            "headless.swapchain.modify.resize".to_string(),
            Box::new(ResizeCase) as Box<dyn TestCase>,
        )))
        .chain(
            [
                ("image_swapchain_create_info", false),
                ("image_swapchain_create_info_concurrent", true),
            ]
            .into_iter()
            .map(|(name, concurrent)| {
                (
                    format!("headless.swapchain.create.{name}"),
                    Box::new(ImageSwapchainCase { name, concurrent }) as Box<dyn TestCase>,
                )
            }),
        )
        .collect()
}
