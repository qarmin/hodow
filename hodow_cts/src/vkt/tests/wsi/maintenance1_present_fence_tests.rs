// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiMaintenance1Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `presentFenceTest` for the `headless` platform (one headless surface per swapchain, no native windows) and the groups
// that use it: `present_fence`, `present_modes.*.change_modes*` and `heterogenous`, `deferred_alloc`; the `release_images` group is registered from here too and lives in
// `maintenance1_release_images_tests.rs`. The compatible present modes create info of each swapchain is kept alive for the whole test (upstream leaves a dangling pNext in
// the stored VkSwapchainCreateInfoKHR, which only `bindSingleImageMemory` reads without following it).

use std::collections::HashMap;
use std::ffi::c_void;
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, KhrSwapchainExtensionDeviceCommands};

use super::maintenance1_release_images_tests::add_release_images_cases;
use super::maintenance1_tests::{
    ACQUIRE_IMAGE_TIMEOUT, DEFAULT_WINDOW_SIZE, PRESENT_MODES, Resources, Rng, add_config_case, check_wsi_success,
    color_subresource_range, create_device, create_instance, get_basic_swapchain_parameters,
    get_surface_compatible_present_modes, get_surface_formats, get_surface_present_modes,
    identity_or_current_transform, image_barrier, is_shared_present_mode, maintenance1_check_support,
    query_surface_capabilities2, wait_for_fence,
};
use super::surface_tests::Surface;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vkt::{Context, TestCase};

#[derive(Clone)]
pub(super) struct PresentFenceConfig {
    pub modes: Vec<vk::PresentModeKHR>,
    pub defer_memory_allocation: bool,
    pub bind_image_memory: bool,
    pub change_present_modes: bool,
    pub verify_fence_ordering: bool,
    pub null_handles: bool,
    // Whether the EXT or KHR versions of the extensions should be used, the configs alternate between them
    pub prefer_ext: bool,
}

/// `getIterations`
pub(super) fn get_iterations(
    present_modes: &[vk::PresentModeKHR],
    compatible_present_modes: &[Vec<vk::PresentModeKHR>],
    test_resizes_windows_frequently: bool,
) -> u32 {
    let mut has_fifo = false;
    let all_modes = present_modes.iter().chain(compatible_present_modes.iter().flatten());
    for &mode in all_modes {
        if mode == vk::PresentModeKHR::FIFO || mode == vk::PresentModeKHR::FIFO_RELAXED {
            has_fifo = true;
        }
    }

    // As high as possible while keeping the test time and memory usage reasonable
    if has_fifo {
        return if test_resizes_windows_frequently { 60 } else { 120 };
    }

    let mut iterations = 250;
    if test_resizes_windows_frequently {
        iterations /= 50;
    }
    iterations
}

/// `bindSingleImageMemory`: an image of the swapchain's parameters bound to swapchain image `image_index`
fn bind_single_image_memory(
    device: &Device,
    resources: &mut Resources<'_>,
    swapchain: vk::SwapchainKHR,
    swapchain_info: &vk::SwapchainCreateInfoKHR,
    image_index: u32,
) -> Result<vk::Image, TestError> {
    let image_swapchain_info = vk::ImageSwapchainCreateInfoKHR {
        swapchain,
        ..Default::default()
    };
    let image_info = vk::ImageCreateInfo {
        next: ptr::from_ref(&image_swapchain_info).cast::<c_void>(),
        flags: vk::ImageCreateFlags::empty(),
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
        usage: swapchain_info.image_usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
        ..Default::default()
    };
    let image = unsafe { device.create_image(&image_info, None) }.vk_check("vkCreateImage")?;
    resources.images.push(image);

    let bind_swapchain_info = vk::BindImageMemorySwapchainInfoKHR {
        swapchain,
        image_index,
        ..Default::default()
    };
    let bind_info = vk::BindImageMemoryInfo {
        next: ptr::from_ref(&bind_swapchain_info).cast::<c_void>(),
        image,
        memory: vk::DeviceMemory::null(),
        memory_offset: 0,
        ..Default::default()
    };
    unsafe { device.bind_image_memory2(&[bind_info]) }.vk_check("vkBindImageMemory2")?;
    Ok(image)
}

/// `verifyFenceSignalOrdering`
fn verify_fence_signal_ordering(
    device: &Device,
    fences: &[vk::Fence],
    stride: usize,
    offset: usize,
    last_known_signaled: usize,
    max_index: usize,
    results: &mut ResultCollector,
) -> Result<(), TestError> {
    // Fences must signal in order: unsignaled ones first, then possibly a number of signaled ones
    let mut visited_signaled_fence = false;
    for i in (last_known_signaled + 1..=max_index).rev() {
        let fence = fences[(i - 1) * stride + offset];
        let is_signaled =
            unsafe { device.get_fence_status(fence) }.vk_check("vkGetFenceStatus")? != vk::SuccessCode::NOT_READY;

        results.check(
            is_signaled || !visited_signaled_fence,
            "Encountered unsignaled fence while a later fence is signaled",
        );
        if is_signaled {
            visited_signaled_fence = true;
        }
    }
    Ok(())
}

pub(super) fn check_present_fence_support(context: &Context<'_>, config: &PresentFenceConfig) -> Result<(), TestError> {
    maintenance1_check_support(
        context,
        config.bind_image_memory,
        true,
        config.bind_image_memory,
        config.prefer_ext,
        config.prefer_ext,
    )
}

/// `presentFenceTest`
pub(super) fn present_fence_test(context: &Context<'_>, config: &PresentFenceConfig) -> TestOutcome {
    let mut results = ResultCollector::new("");

    let surface_count = config.modes.len();
    let helper = create_instance(context, config.bind_image_memory, config.prefer_ext)?;
    let instance = &helper.instance;
    let physical_device = helper.physical_device;
    let mut surfaces = Vec::new();
    for _ in 0..surface_count {
        surfaces.push(Surface::headless(instance)?);
    }

    let dev = create_device(
        context,
        instance,
        physical_device,
        surfaces[0].surface,
        true,
        config.bind_image_memory,
        config.prefer_ext,
    )?;
    let device = &dev.device;

    for (surface, mode) in surfaces.iter().zip(&config.modes) {
        if !get_surface_present_modes(instance, physical_device, surface.surface)?.contains(mode) {
            return Err(TestError::NotSupported("Present mode not supported".to_string()));
        }
    }

    let surface_formats = get_surface_formats(instance, physical_device, surfaces[0].surface)?;
    let Some(&surface_format) = surface_formats.first() else {
        return Ok(crate::tcu::TestStatus::fail("No VkSurfaceFormatKHR defined"));
    };

    let is_shared: Vec<bool> = config.modes.iter().map(|&mode| is_shared_present_mode(mode)).collect();

    let mut resources = Resources::new(device);
    let mut swapchain_infos: Vec<vk::SwapchainCreateInfoKHR> = Vec::new();
    let mut swapchain_images: Vec<Vec<vk::Image>> = Vec::new();
    let mut compatible_present_modes: Vec<Vec<vk::PresentModeKHR>> = Vec::new();
    let mut compatible_modes_create_infos: Vec<Box<vk::SwapchainPresentModesCreateInfoKHR>> = Vec::new();

    for i in 0..surface_count {
        let mut shared_capabilities = vk::SharedPresentSurfaceCapabilitiesKHR::default();
        let capabilities = query_surface_capabilities2(
            instance,
            physical_device,
            surfaces[i].surface,
            None,
            if is_shared[i] {
                ptr::from_mut(&mut shared_capabilities).cast::<c_void>()
            } else {
                ptr::null_mut()
            },
        )
        .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
        let transform = identity_or_current_transform(&capabilities);

        if is_shared[i]
            && !shared_capabilities
                .shared_present_supported_usage_flags
                .contains(vk::ImageUsageFlags::TRANSFER_DST)
        {
            return Err(TestError::NotSupported(
                "Transfer dst with shared present mode not supported".to_string(),
            ));
        }

        // VUID-VkSwapchainCreateInfoKHR-presentMode-02839
        let mut image_count = if is_shared[i] {
            1
        } else {
            capabilities.min_image_count + 1
        };
        if !is_shared[i] && capabilities.max_image_count > 0 {
            image_count = image_count.min(capabilities.max_image_count);
        }

        let mut swapchain_info = get_basic_swapchain_parameters(
            surfaces[i].surface,
            surface_format,
            DEFAULT_WINDOW_SIZE,
            config.modes[i],
            transform,
            capabilities.supported_composite_alpha,
            image_count,
            config.defer_memory_allocation,
        );

        if config.change_present_modes {
            compatible_present_modes.push(get_surface_compatible_present_modes(
                instance,
                physical_device,
                surfaces[i].surface,
                config.modes[i],
            )?);
            let create_info = Box::new(vk::SwapchainPresentModesCreateInfoKHR {
                present_mode_count: compatible_present_modes[i].len() as u32,
                present_modes: compatible_present_modes[i].as_ptr(),
                ..Default::default()
            });
            swapchain_info.next = ptr::from_ref(&*create_info).cast::<c_void>();
            compatible_modes_create_infos.push(create_info);
        }

        let swapchain = resources.create_swapchain(&swapchain_info)?;
        swapchain_infos.push(swapchain_info);

        if config.bind_image_memory {
            let image_count = unsafe { device.get_swapchain_images_khr(swapchain) }
                .vk_check("vkGetSwapchainImagesKHR")?
                .len();
            let mut images = vec![vk::Image::null(); image_count];

            // If memory allocation is deferred, bind image memory lazily at acquire time.
            if !config.defer_memory_allocation {
                for (index, image) in images.iter_mut().enumerate() {
                    *image =
                        bind_single_image_memory(device, &mut resources, swapchain, &swapchain_infos[i], index as u32)?;
                }
            }
            swapchain_images.push(images);
        } else {
            swapchain_images
                .push(unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?);
        }
    }

    resources.create_command_pool(dev.queue_family_index)?;

    let iterations = get_iterations(&config.modes, &compatible_present_modes, false) as usize;

    let config_hash = (config.modes[0].as_raw() as u32) << 4
        | (config.defer_memory_allocation as u32) << 28
        | (config.bind_image_memory as u32) << 29
        | (config.change_present_modes as u32) << 30
        | (config.verify_fence_ordering as u32) << 31;
    let mut rng = Rng::new(0x53A4_C8A1 ^ config_hash);

    // Do iterations presents, each with an associated fence.  Destroy the wait semaphores as soon as the corresponding fence signals.
    let mut present_fences = vec![vk::Fence::null(); iterations * surface_count];
    for fence in present_fences.iter_mut() {
        if !config.null_handles || rng.get_u32() % 4 != 0 {
            *fence = resources.create_fence()?;
        }
    }
    let mut acquire_sems = Vec::with_capacity(iterations * surface_count);
    for _ in 0..iterations * surface_count {
        acquire_sems.push(resources.create_semaphore()?);
    }
    let mut present_sems = Vec::with_capacity(iterations);
    for _ in 0..iterations {
        present_sems.push(resources.create_semaphore()?);
    }
    let command_buffers = resources.allocate_command_buffers(iterations)?;

    let range = color_subresource_range();
    let mut next_unfinished_present = vec![0usize; surface_count];

    for i in 0..iterations {
        let present_sem = present_sems[i];
        let mut acquire_sem: Vec<vk::Semaphore> = Vec::new();
        let mut present_fence: Vec<vk::Fence> = Vec::new();
        let mut image_index = vec![0x12345u32; surface_count]; // initialize to junk value
        let command_buffer = command_buffers[i];

        // Acquire an image and clear it
        unsafe { device.begin_command_buffer(command_buffer, &vk::CommandBufferBeginInfo::default()) }
            .vk_check("vkBeginCommandBuffer")?;

        let mut barrier = image_barrier(
            vk::Image::null(),
            vk::AccessFlags::empty(),
            vk::AccessFlags::empty(),
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::UNDEFINED,
        );

        for j in 0..surface_count {
            acquire_sem.push(acquire_sems[i * surface_count + j]);
            present_fence.push(present_fences[i * surface_count + j]);

            if !is_shared[j] || i == 0 {
                let (index, code) = unsafe {
                    device.acquire_next_image_khr(
                        resources.swapchains[j],
                        ACQUIRE_IMAGE_TIMEOUT,
                        *acquire_sem.last().unwrap(),
                        vk::Fence::null(),
                    )
                }
                .vk_check("vkAcquireNextImageKHR")?;
                check_wsi_success(code, "vkAcquireNextImageKHR")?;
                image_index[j] = index;
            } else {
                // Shared present mode always has one image, so index is always 0.
                image_index[j] = 0;
                // Since acquire is skipped, there is no acquire semaphore.
                acquire_sem.pop();
            }

            // If memory allocation is deferred and bind image memory is used, lazily bind image memory now if this is the first time the image is acquired.
            if swapchain_images[j][image_index[j] as usize] == vk::Image::null() {
                debug_assert!(config.bind_image_memory && config.defer_memory_allocation);
                let swapchain = resources.swapchains[j];
                let image =
                    bind_single_image_memory(device, &mut resources, swapchain, &swapchain_infos[j], image_index[j])?;
                swapchain_images[j][image_index[j] as usize] = image;
            }
            let acquired_image = swapchain_images[j][image_index[j] as usize];

            barrier.new_layout = if is_shared[j] {
                vk::ImageLayout::SHARED_PRESENT_KHR
            } else {
                vk::ImageLayout::TRANSFER_DST_OPTIMAL
            };
            barrier.dst_access_mask = vk::AccessFlags::TRANSFER_WRITE;
            barrier.image = acquired_image;

            unsafe {
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                )
            };
        }

        for j in 0..surface_count {
            let step = (i + j * 5) as u32;
            let clear_value = vk::ClearColorValue {
                float32: [
                    (step % 33) as f32 / 32.0,
                    ((step + 7) % 33) as f32 / 32.0,
                    ((step + 17) % 33) as f32 / 32.0,
                    1.0,
                ],
            };
            unsafe {
                device.cmd_clear_color_image(
                    command_buffer,
                    swapchain_images[j][image_index[j] as usize],
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_value,
                    &[range],
                )
            };
        }

        barrier.src_access_mask = vk::AccessFlags::TRANSFER_WRITE;
        barrier.dst_access_mask = vk::AccessFlags::empty();

        for j in 0..surface_count {
            if !is_shared[j] {
                barrier.old_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
                barrier.new_layout = vk::ImageLayout::PRESENT_SRC_KHR;
            } else {
                barrier.old_layout = vk::ImageLayout::SHARED_PRESENT_KHR;
            }
            barrier.image = swapchain_images[j][image_index[j] as usize];

            unsafe {
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                )
            };
        }

        unsafe { device.end_command_buffer(command_buffer) }.vk_check("vkEndCommandBuffer")?;

        // Submit the command buffer
        let wait_stages = vec![vk::PipelineStageFlags::TRANSFER; acquire_sem.len()];
        let command_buffer_slice = [command_buffer];
        let signal_semaphores = [present_sem];
        let submit_info = vk::SubmitInfo::builder()
            .wait_semaphores(&acquire_sem)
            .wait_dst_stage_mask(&wait_stages)
            .command_buffers(&command_buffer_slice)
            .signal_semaphores(&signal_semaphores)
            .build();
        unsafe { device.queue_submit(dev.queue, &[submit_info], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;

        // Present the frame
        let mut result = vec![vk::Result::SUCCESS; surface_count];
        let mut present_fence_info = vk::SwapchainPresentFenceInfoKHR {
            swapchain_count: surface_count as u32,
            fences: present_fence.as_ptr(),
            ..Default::default()
        };
        let mut present_mode_info = vk::SwapchainPresentModeInfoKHR {
            swapchain_count: surface_count as u32,
            ..Default::default()
        };
        let mut present_modes: Vec<vk::PresentModeKHR> = Vec::new();
        if config.change_present_modes && rng.get_u32() % 10 != 0 {
            // Randomly switch modes.  This is randomly not done to test that the driver doens't expect it to be specified every time.
            for compatible in &compatible_present_modes {
                let random_index = rng.get_u32() as usize % compatible.len();
                present_modes.push(compatible[random_index]);
            }
            present_mode_info.present_modes = present_modes.as_ptr();
            present_fence_info.next = ptr::from_ref(&present_mode_info).cast::<c_void>();
        }

        let present_info = vk::PresentInfoKHR {
            next: ptr::from_ref(&present_fence_info).cast::<c_void>(),
            wait_semaphore_count: 1,
            wait_semaphores: &present_sem,
            swapchain_count: surface_count as u32,
            swapchains: resources.swapchains.as_ptr(),
            image_indices: image_index.as_ptr(),
            results: result.as_mut_ptr(),
            ..Default::default()
        };
        let code = unsafe { device.queue_present_khr(dev.queue, &present_info) }.vk_check("vkQueuePresentKHR")?;
        check_wsi_success(code, "vkQueuePresentKHR")?;
        for &swapchain_result in &result {
            if swapchain_result != vk::Result::SUCCESS && swapchain_result != vk::Result::SUBOPTIMAL_KHR {
                return Err(TestError::Fail(format!(
                    "vkQueuePresentKHR result is {swapchain_result:?}"
                )));
            }
        }

        for j in 0..surface_count {
            // Check previous presents; if any is signaled, immediatey destroy its wait semaphore
            while next_unfinished_present[j] < i {
                let unfinished_present = next_unfinished_present[j];
                let fence = present_fences[unfinished_present * surface_count + j];
                if fence == vk::Fence::null() {
                    next_unfinished_present[j] += 1;
                    break;
                }
                if unsafe { device.get_fence_status(fence) }.vk_check("vkGetFenceStatus")? == vk::SuccessCode::NOT_READY
                {
                    break;
                }

                resources.destroy_semaphore(present_sems[unfinished_present]);
                next_unfinished_present[j] += 1;
            }

            if config.verify_fence_ordering {
                verify_fence_signal_ordering(
                    device,
                    &present_fences,
                    surface_count,
                    j,
                    next_unfinished_present[j],
                    iterations,
                    &mut results,
                )?;
            }
        }
    }

    // Wait for outstanding presents and destroy their wait semaphores
    for j in 0..surface_count {
        if config.verify_fence_ordering {
            verify_fence_signal_ordering(
                device,
                &present_fences,
                surface_count,
                j,
                next_unfinished_present[j],
                iterations,
                &mut results,
            )?;
        }

        while next_unfinished_present[j] < iterations {
            let fence = present_fences[next_unfinished_present[j] * surface_count + j];
            if fence != vk::Fence::null() {
                wait_for_fence(device, fence)?;
                resources.destroy_semaphore(present_sems[next_unfinished_present[j]]);
            }
            next_unfinished_present[j] += 1;
        }
    }

    Ok(results.to_status())
}

const PRESENT_FENCE_ROOT: &str = "present_fence";

/// `populatePresentFenceGroup`, `populatePresentModesGroup` (without `query`), `populateDeferredAllocGroup` and `populateReleaseImagesGroup`
pub(super) fn add_present_fence_cases(cases: &mut HashMap<String, Box<dyn TestCase>>, root: &str) {
    fn add(cases: &mut HashMap<String, Box<dyn TestCase>>, path: String, name: &str, config: PresentFenceConfig) {
        add_config_case(
            cases,
            path,
            name,
            config,
            check_present_fence_support,
            present_fence_test,
        );
    }

    let base = |modes: Vec<vk::PresentModeKHR>, prefer_ext: bool| PresentFenceConfig {
        modes,
        defer_memory_allocation: false,
        bind_image_memory: false,
        change_present_modes: false,
        verify_fence_ordering: false,
        null_handles: false,
        prefer_ext,
    };

    // present_fence
    let mut prefer_ext = true;
    for &(mode, mode_name) in &PRESENT_MODES {
        let group = format!("{root}.{PRESENT_FENCE_ROOT}.{mode_name}");
        let mut config = base(vec![mode], prefer_ext);
        add(cases, format!("{group}.basic"), "basic", config.clone());

        config.verify_fence_ordering = true;
        config.prefer_ext = !prefer_ext;
        add(cases, format!("{group}.ordering"), "ordering", config.clone());

        config.verify_fence_ordering = false;
        config.modes = vec![mode; 3];
        config.prefer_ext = prefer_ext;
        add(
            cases,
            format!("{group}.multi_swapchain"),
            "multi_swapchain",
            config.clone(),
        );

        config.verify_fence_ordering = true;
        config.prefer_ext = !prefer_ext;
        add(
            cases,
            format!("{group}.mult_swapchain_ordering"),
            "mult_swapchain_ordering",
            config.clone(),
        );

        config.modes = vec![mode; 5];
        config.verify_fence_ordering = false;
        config.null_handles = true;
        config.prefer_ext = prefer_ext;
        add(cases, format!("{group}.null_handles"), "null_handles", config);

        prefer_ext = !prefer_ext;
    }

    // present_modes: change_modes*, then heterogenous (query is registered with the scaling tests)
    let mut prefer_ext = true;
    for &(mode, mode_name) in &PRESENT_MODES {
        let group = format!("{root}.present_modes.{mode_name}");
        let mut config = base(vec![mode], !prefer_ext);
        config.change_present_modes = true;
        add(cases, format!("{group}.change_modes"), "change_modes", config.clone());

        config.modes = vec![mode; 4];
        config.prefer_ext = prefer_ext;
        add(
            cases,
            format!("{group}.change_modes_multi_swapchain"),
            "change_modes_multi_swapchain",
            config.clone(),
        );

        config.modes = vec![mode; 2];
        config.defer_memory_allocation = true;
        config.prefer_ext = !prefer_ext;
        add(
            cases,
            format!("{group}.change_modes_with_deferred_alloc"),
            "change_modes_with_deferred_alloc",
            config,
        );

        prefer_ext = !prefer_ext;
    }

    for (i, &(mode_i, name_i)) in PRESENT_MODES.iter().enumerate() {
        for (j, &(mode_j, name_j)) in PRESENT_MODES.iter().enumerate() {
            for (k, &(mode_k, name_k)) in PRESENT_MODES.iter().enumerate() {
                // Skip if not actually heterogenous
                if i == j && i == k {
                    continue;
                }
                let name = format!("{name_i}_{name_j}_{name_k}");
                let mut config = base(vec![mode_i, mode_j, mode_k], prefer_ext);
                config.change_present_modes = true;
                add(
                    cases,
                    format!("{root}.present_modes.heterogenous.{name}"),
                    &name,
                    config,
                );
                prefer_ext = !prefer_ext;
            }
        }
    }

    // deferred_alloc
    let mut prefer_ext = true;
    for &(mode, mode_name) in &PRESENT_MODES {
        let group = format!("{root}.deferred_alloc.{mode_name}");
        let mut config = base(vec![mode], prefer_ext);
        config.defer_memory_allocation = true;
        add(cases, format!("{group}.basic"), "basic", config.clone());

        config.bind_image_memory = true;

        // Bind image memory + shared present mode crashing on some drivers for unrelated reasons to VK_EXT_swapchain_maintenance1
        if !is_shared_present_mode(mode) {
            config.prefer_ext = !prefer_ext;
            add(cases, format!("{group}.bind_image"), "bind_image", config.clone());
        }

        config.modes = vec![mode; 2];
        config.prefer_ext = prefer_ext;
        add(
            cases,
            format!("{group}.bind_image_multi_swapchain"),
            "bind_image_multi_swapchain",
            config,
        );

        prefer_ext = !prefer_ext;
    }

    add_release_images_cases(cases, root);
}
