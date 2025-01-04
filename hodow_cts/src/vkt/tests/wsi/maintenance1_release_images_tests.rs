// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiMaintenance1Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `releaseImagesTest` for the `headless` platform: a headless surface never reports VK_ERROR_OUT_OF_DATE_KHR and has no
// window, so the window resizes only consume the random numbers upstream draws for them and the recreate-swapchain paths are ported but not expected to run. Retired
// swapchains stay alive until the end of the test (the `Resources` guard) instead of being destroyed when replaced. `de::Random::shuffle` is a Fisher-Yates over the same xorshift32.

use std::collections::HashMap;
use std::ffi::c_void;
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrSwapchainExtensionDeviceCommands;

use super::maintenance1_present_fence_tests::get_iterations;
use super::maintenance1_tests::{
    ACQUIRE_IMAGE_TIMEOUT, DEFAULT_WINDOW_SIZE, PRESENT_MODES, Resources, Rng, add_config_case, check_wsi_success,
    color_subresource_range, create_device, create_instance, get_basic_swapchain_parameters, get_surface_formats,
    get_surface_present_modes, get_surface_scaling_capabilities, identity_or_current_transform, image_barrier,
    is_shared_present_mode, maintenance1_check_support, query_surface_capabilities2, wait_for_fence,
};
use super::surface_tests::Surface;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vkt::{Context, TestCase};

#[derive(Clone, Copy, PartialEq, Eq)]
enum ResizeWindow {
    No,
    BeforeAcquire,
    BeforePresent,
}

#[derive(Clone, Copy)]
struct ReleaseImagesConfig {
    mode: vk::PresentModeKHR,
    scaling: vk::PresentScalingFlagsKHR,
    resize_window: ResizeWindow,
    release_before_present: bool,
    release_before_retire: bool,
    prefer_ext: bool,
}

fn check_release_images_support(context: &Context<'_>, config: &ReleaseImagesConfig) -> Result<(), TestError> {
    if config.mode == vk::PresentModeKHR::FIFO_LATEST_READY
        && !context.is_device_functionality_supported("VK_EXT_present_mode_fifo_latest_ready")
    {
        context.require_device_functionality("VK_KHR_present_mode_fifo_latest_ready")?;
    }

    maintenance1_check_support(context, false, true, false, config.prefer_ext, config.prefer_ext)
}

/// `vkAcquireNextImageKHR` followed, on success, by a wait for and a reset of `fence`; the raw result is returned so the caller can see OUT_OF_DATE
fn acquire_and_wait(
    device: &Device,
    swapchain: vk::SwapchainKHR,
    semaphore: vk::Semaphore,
    fence: vk::Fence,
) -> Result<Result<(u32, vk::SuccessCode), vk::ErrorCode>, TestError> {
    let result = unsafe { device.acquire_next_image_khr(swapchain, ACQUIRE_IMAGE_TIMEOUT, semaphore, fence) };
    if let Ok((_, code)) = result
        && (code == vk::SuccessCode::SUCCESS || code == vk::SuccessCode::SUBOPTIMAL_KHR)
    {
        wait_for_fence(device, fence)?;
        unsafe { device.reset_fences(&[fence]) }.vk_check("vkResetFences")?;
    }
    Ok(result)
}

/// Replaces `swapchain` by a new one created from `info` (with the old one as `oldSwapchain`), and re-reads its images
fn recreate_swapchain(
    device: &Device,
    resources: &mut Resources<'_>,
    info: &mut vk::SwapchainCreateInfoKHR,
    swapchain: &mut vk::SwapchainKHR,
    images: &mut Vec<vk::Image>,
) -> Result<(), TestError> {
    info.old_swapchain = *swapchain;
    *swapchain = resources.create_swapchain(info)?;

    let previous_image_count = images.len();
    *images = unsafe { device.get_swapchain_images_khr(*swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;
    if previous_image_count != images.len() {
        return Err(TestError::InternalError(
            "Unexpected change in number of swapchain images when recreated during window resize".to_string(),
        ));
    }
    Ok(())
}

/// `releaseImagesTest`
fn release_images_test(context: &Context<'_>, config: &ReleaseImagesConfig) -> TestOutcome {
    let helper = create_instance(context, false, config.prefer_ext)?;
    let surface = Surface::headless(&helper.instance)?;
    let instance = &helper.instance;
    let physical_device = helper.physical_device;
    let dev = create_device(
        context,
        instance,
        physical_device,
        surface.surface,
        true,
        false,
        config.prefer_ext,
    )?;
    let device = &dev.device;

    let surface_formats = get_surface_formats(instance, physical_device, surface.surface)?;
    let Some(&surface_format) = surface_formats.first() else {
        return Ok(TestStatus::fail("No VkSurfaceFormatKHR defined"));
    };

    if !get_surface_present_modes(instance, physical_device, surface.surface)?.contains(&config.mode) {
        return Err(TestError::NotSupported("Present mode not supported".to_string()));
    }

    let capabilities = query_surface_capabilities2(
        instance,
        physical_device,
        surface.surface,
        Some(config.mode),
        ptr::null_mut(),
    )
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
    let transform = identity_or_current_transform(&capabilities);

    if !config.scaling.is_empty() {
        // Skip if configuration is not supported
        let scaling = get_surface_scaling_capabilities(instance, physical_device, config.mode, surface.surface)?;
        if (scaling.supported_present_scaling & config.scaling).is_empty() {
            return Err(TestError::NotSupported("Scaling mode is not supported".to_string()));
        }
    }

    let is_shared = is_shared_present_mode(config.mode);
    if is_shared && (capabilities.min_image_count != 1 || capabilities.max_image_count != 1) {
        return Ok(TestStatus::fail(
            "min and max image count for shared present modes must be 1",
        ));
    }

    let mut image_count = capabilities.min_image_count + 10;
    if capabilities.max_image_count > 0 {
        image_count = image_count.min(capabilities.max_image_count);
    }

    let mut swapchain_info = get_basic_swapchain_parameters(
        surface.surface,
        surface_format,
        DEFAULT_WINDOW_SIZE,
        config.mode,
        transform,
        capabilities.supported_composite_alpha,
        image_count,
        false,
    );
    let scaling_info = vk::SwapchainPresentScalingCreateInfoKHR {
        scaling_behavior: config.scaling,
        ..Default::default()
    };
    swapchain_info.next = ptr::from_ref(&scaling_info).cast::<c_void>();

    let mut resources = Resources::new(device);
    let mut swapchain = resources.create_swapchain(&swapchain_info)?;
    let mut swapchain_images =
        unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;

    resources.create_command_pool(dev.queue_family_index)?;

    let iterations = get_iterations(&[config.mode], &[], config.resize_window != ResizeWindow::No) as usize;

    // Do iterations presents, with a fence associated with the last one.
    let present_fence = resources.create_fence()?;
    let mut acquire_sems = Vec::with_capacity(iterations);
    let mut present_sems = Vec::with_capacity(iterations);
    for _ in 0..iterations {
        acquire_sems.push(resources.create_semaphore()?);
    }
    for _ in 0..iterations {
        present_sems.push(resources.create_semaphore()?);
    }
    let command_buffers = resources.allocate_command_buffers(iterations)?;

    let range = color_subresource_range();

    let config_hash = (config.mode.as_raw() as u32) << 4
        | (config.scaling.bits()) << 24
        | (config.resize_window as u32) << 28
        | (config.release_before_present as u32) << 30
        | (config.release_before_retire as u32) << 31;
    let mut rng = Rng::new(0x53A4_C8A1 ^ config_hash);

    let mut need_shared_present_acquire = true;

    for i in 0..iterations {
        // Decide on how many acquires to do, and whether a presentation is to be done.  Presentation is always done for the last iteration, to facilitate clean up (by adding a present fence).
        let max_allowed_acquires = (swapchain_images.len() as u32).saturating_sub(capabilities.min_image_count) + 1;
        let acquire_count = (rng.get_u32() % max_allowed_acquires + 1) as usize;
        let do_present = i + 1 == iterations || rng.get_u32() % 10 != 0;
        let do_resize = config.resize_window != ResizeWindow::No && rng.get_u32() % 10 != 0;
        let present_index = if do_present {
            rng.get_u32() as usize % acquire_count
        } else {
            acquire_count
        };

        // Resize the window if requested: a headless surface has no window, only the random numbers are drawn
        if do_resize && config.resize_window == ResizeWindow::BeforeAcquire {
            rng.get_u32();
            rng.get_u32();
        }

        // Acquire N times
        let present_sem = present_sems[i];
        let mut acquire_sem = acquire_sems[i];
        let mut acquired_indices = vec![0x12345u32; acquire_count];
        let mut acquire_fences = Vec::with_capacity(acquire_count);
        // VUID-vkAcquireNextImageKHR-fence-10066
        for _ in 0..acquire_count {
            acquire_fences.push(resources.create_fence()?);
        }

        let first_semaphore = if present_index == 0 {
            acquire_sem
        } else {
            vk::Semaphore::null()
        };
        let mut result: Result<(u32, vk::SuccessCode), vk::ErrorCode> = Ok((0, vk::SuccessCode::SUCCESS));
        if !is_shared || need_shared_present_acquire {
            result = acquire_and_wait(device, swapchain, first_semaphore, acquire_fences[0])?;
        }

        // If out of date, recreate the swapchain and reacquire.
        if result == Err(vk::ErrorCode::OUT_OF_DATE_KHR) {
            if config.scaling.is_empty() {
                swapchain_info.image_extent = vk::Extent2D {
                    width: DEFAULT_WINDOW_SIZE.0,
                    height: DEFAULT_WINDOW_SIZE.1,
                };
            }
            recreate_swapchain(
                device,
                &mut resources,
                &mut swapchain_info,
                &mut swapchain,
                &mut swapchain_images,
            )?;
            result = acquire_and_wait(device, swapchain, first_semaphore, acquire_fences[0])?;
        }

        let (first_index, first_code) = result.vk_check("vkAcquireNextImageKHR")?;
        check_wsi_success(first_code, "vkAcquireNextImageKHR")?;
        acquired_indices[0] = first_index;

        if is_shared && !need_shared_present_acquire {
            // Shared present mode always has one image, so index is always 0.
            acquired_indices[0] = 0;
            // Since acquire is skipped, there is no acquire semaphore.
            acquire_sem = vk::Semaphore::null();
        }
        need_shared_present_acquire = false;

        // In shared present mode, no additional acquire is done
        debug_assert!(!is_shared || acquire_count == 1);
        for j in 1..acquire_count {
            let (index, code) = acquire_and_wait(
                device,
                swapchain,
                if present_index == j {
                    acquire_sem
                } else {
                    vk::Semaphore::null()
                },
                acquire_fences[j],
            )?
            .vk_check("vkAcquireNextImageKHR")?;
            check_wsi_success(code, "vkAcquireNextImageKHR")?;
            acquired_indices[j] = index;
        }

        // Construct a list of image indices to be released.  That is every index except the one being presented, if any.
        let mut release_indices = acquired_indices.clone();
        if do_present {
            release_indices.remove(present_index);
        }
        let image_release_size = release_indices.len();

        // Randomize the indices to be released.
        for k in (1..release_indices.len()).rev() {
            let swap_with = rng.get_u32() as usize % (k + 1);
            release_indices.swap(k, swap_with);
        }

        if do_resize && config.resize_window == ResizeWindow::BeforePresent {
            rng.get_u32();
            rng.get_u32();
        }

        // VUID-VkReleaseSwapchainImagesInfoKHR-pImageIndices-07786
        let mut completion_fence = vk::Fence::null();
        if image_release_size > 0 && do_present {
            completion_fence = resources.create_fence()?;
        }

        if do_present {
            let command_buffer = command_buffers[i];
            let image = swapchain_images[acquired_indices[present_index] as usize];
            unsafe {
                device
                    .begin_command_buffer(command_buffer, &vk::CommandBufferBeginInfo::default())
                    .vk_check("vkBeginCommandBuffer")?;

                let mut barrier = image_barrier(
                    image,
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::empty(),
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                );
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );

                let step = i as u32;
                let clear_value = vk::ClearColorValue {
                    float32: [
                        (step % 33) as f32 / 32.0,
                        ((step + 7) % 33) as f32 / 32.0,
                        ((step + 17) % 33) as f32 / 32.0,
                        1.0,
                    ],
                };
                device.cmd_clear_color_image(
                    command_buffer,
                    image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_value,
                    &[range],
                );

                barrier.old_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
                barrier.new_layout = vk::ImageLayout::PRESENT_SRC_KHR;
                barrier.src_access_mask = vk::AccessFlags::TRANSFER_WRITE;
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
                device
                    .end_command_buffer(command_buffer)
                    .vk_check("vkEndCommandBuffer")?;
            }

            // Submit the command buffer
            let wait_semaphores: &[vk::Semaphore] = if acquire_sem == vk::Semaphore::null() {
                &[]
            } else {
                std::slice::from_ref(&acquire_sem)
            };
            let wait_stages = [vk::PipelineStageFlags::TRANSFER];
            let command_buffer_slice = [command_buffer];
            let signal_semaphores = [present_sem];
            let submit_info = vk::SubmitInfo::builder()
                .wait_semaphores(wait_semaphores)
                .wait_dst_stage_mask(&wait_stages[..wait_semaphores.len()])
                .command_buffers(&command_buffer_slice)
                .signal_semaphores(&signal_semaphores)
                .build();
            unsafe { device.queue_submit(dev.queue, &[submit_info], completion_fence) }.vk_check("vkQueueSubmit")?;
        }

        let release_info = vk::ReleaseSwapchainImagesInfoKHR {
            swapchain,
            image_index_count: image_release_size as u32,
            image_indices: release_indices.as_ptr(),
            ..Default::default()
        };
        let wait_for_completion = |completion_fence: vk::Fence| -> Result<(), TestError> {
            if completion_fence != vk::Fence::null() {
                wait_for_fence(device, completion_fence)?;
            }
            Ok(())
        };

        // If asked to release before present, do so now.
        let mut images_released = false;
        if config.release_before_present && image_release_size > 0 {
            wait_for_completion(completion_fence)?;
            dev.release_swapchain_images(&release_info)?;
            images_released = true;
            // Since the image was released, it should be acquired again in shared present mode.
            need_shared_present_acquire = true;
        }

        // Present the frame
        if do_present {
            // Signal the present fence on the last present.
            let present_fence_info = vk::SwapchainPresentFenceInfoKHR {
                swapchain_count: 1,
                fences: &present_fence,
                ..Default::default()
            };
            let mut present_result = vk::Result::SUCCESS;
            let present_info = vk::PresentInfoKHR {
                next: if i + 1 == iterations {
                    ptr::from_ref(&present_fence_info).cast::<c_void>()
                } else {
                    ptr::null()
                },
                wait_semaphore_count: 1,
                wait_semaphores: &present_sem,
                swapchain_count: 1,
                swapchains: &swapchain,
                image_indices: &acquired_indices[present_index],
                results: &mut present_result,
                ..Default::default()
            };
            let aggregate_result = unsafe { device.queue_present_khr(dev.queue, &present_info) };
            if aggregate_result == Err(vk::ErrorCode::OUT_OF_DATE_KHR)
                || present_result == vk::Result::ERROR_OUT_OF_DATE_KHR
            {
                // If OUT_OF_DATE is returned from present, recreate the swapchain and release images to the retired swapchain.
                if !images_released && config.release_before_retire && image_release_size > 0 {
                    wait_for_completion(completion_fence)?;
                    dev.release_swapchain_images(&release_info)?;
                    images_released = true;
                }

                if config.scaling.is_empty() {
                    let current =
                        query_surface_capabilities2(instance, physical_device, surface.surface, None, ptr::null_mut())
                            .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
                    swapchain_info.image_extent = current.min_image_extent;
                }

                let retired = swapchain;
                recreate_swapchain(
                    device,
                    &mut resources,
                    &mut swapchain_info,
                    &mut swapchain,
                    &mut swapchain_images,
                )?;

                if !images_released && !config.release_before_retire && image_release_size > 0 {
                    wait_for_completion(completion_fence)?;
                    // Release the images to the retired swapchain before it is destroyed
                    let retired_release_info = vk::ReleaseSwapchainImagesInfoKHR {
                        swapchain: retired,
                        ..release_info
                    };
                    dev.release_swapchain_images(&retired_release_info)?;
                    images_released = true;
                }

                // The swapchain is recreated, so acquire needs to be done again.
                need_shared_present_acquire = true;
            } else {
                let code = aggregate_result.vk_check("vkQueuePresentKHR")?;
                check_wsi_success(code, "vkQueuePresentKHR")?;
                if present_result != vk::Result::SUCCESS && present_result != vk::Result::SUBOPTIMAL_KHR {
                    return Err(TestError::Fail(format!(
                        "vkQueuePresentKHR result is {present_result:?}"
                    )));
                }
            }
        }

        // If asked to release after present, do it now.
        if !images_released && image_release_size > 0 {
            wait_for_completion(completion_fence)?;
            dev.release_swapchain_images(&release_info)?;
            // Since the image was released, it should be acquired again in shared present mode.
            need_shared_present_acquire = true;
        }

        for fence in acquire_fences {
            resources.destroy_fence(fence);
        }
        if completion_fence != vk::Fence::null() {
            resources.destroy_fence(completion_fence);
        }
    }

    // Wait for all presents before terminating the test (when semaphores are destroyed)
    wait_for_fence(device, present_fence)?;

    Ok(TestStatus::pass("Tests ran successfully"))
}

/// `populateReleaseImagesGroup`
pub(super) fn add_release_images_cases(cases: &mut HashMap<String, Box<dyn TestCase>>, root: &str) {
    const SCALING_FLAGS: [(vk::PresentScalingFlagsKHR, &str); 2] = [
        (vk::PresentScalingFlagsKHR::empty(), "no_scaling"),
        (vk::PresentScalingFlagsKHR::STRETCH, "stretch"),
    ];

    let mut prefer_ext = true;
    for &(mode, mode_name) in &PRESENT_MODES {
        let mut sub_test_prefer_ext = prefer_ext;
        for &(scaling, scaling_name) in &SCALING_FLAGS {
            let group = format!("{root}.release_images.{mode_name}.{scaling_name}");
            let mut config = ReleaseImagesConfig {
                mode,
                scaling,
                resize_window: ResizeWindow::No,
                release_before_present: false,
                release_before_retire: false,
                prefer_ext: sub_test_prefer_ext,
            };
            let mut add = |name: &str, config: ReleaseImagesConfig| {
                add_config_case(
                    cases,
                    format!("{group}.{name}"),
                    name,
                    config,
                    check_release_images_support,
                    release_images_test,
                );
            };

            add("basic", config);

            config.release_before_present = true;
            config.prefer_ext = !sub_test_prefer_ext;
            add("release_before_present", config);

            config.release_before_present = false;
            config.resize_window = ResizeWindow::BeforeAcquire;
            config.prefer_ext = sub_test_prefer_ext;
            add("resize_window", config);

            config.resize_window = ResizeWindow::BeforePresent;
            config.prefer_ext = !sub_test_prefer_ext;
            add("resize_window_after_acquire", config);

            config.release_before_retire = true;
            config.prefer_ext = sub_test_prefer_ext;
            add("resize_window_after_acquire_release_before_retire", config);

            sub_test_prefer_ext = !sub_test_prefer_ext;
        }
        prefer_ext = !prefer_ext;
    }
}
