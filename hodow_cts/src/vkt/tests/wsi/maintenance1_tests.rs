// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiMaintenance1Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `headless` platform (VK_EXT_headless_surface): the native window of upstream's `TestNativeObjects` does not
// exist, a headless surface has no window so `resizeWindow` only changes the remembered window size. This file holds the shared helpers (instance and device with
// VK_{EXT,KHR}_{surface,swapchain}_maintenance1, surface queries, the `Resources` guard), `scaling.*` and `present_modes.*.query`; `maintenance1_present_fence_tests.rs` has
// `presentFenceTest` and `releaseImagesTest`. `de::Random` is replaced by an xorshift32, so the random choices differ from deqp's but are as reproducible.

use std::collections::HashMap;
use std::ffi::{CString, c_void};
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    KhrGetSurfaceCapabilities2ExtensionInstanceCommands, KhrSurfaceExtensionInstanceCommands,
    KhrSwapchainExtensionDeviceCommands,
};

use super::maintenance1_present_fence_tests::add_present_fence_cases;
use super::surface_tests::Surface;
use super::swapchain_tests::compatible_queue_family_indices;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::api::case_util::{CustomInstance, create_custom_instance, is_instance_extension_available};
use crate::vkt::{Context, TestCase, TestInstance};

pub(super) const PRESENT_MODES: [(vk::PresentModeKHR, &str); 7] = [
    (vk::PresentModeKHR::IMMEDIATE, "immediate"),
    (vk::PresentModeKHR::MAILBOX, "mailbox"),
    (vk::PresentModeKHR::FIFO, "fifo"),
    (vk::PresentModeKHR::FIFO_RELAXED, "fifo_relaxed"),
    (vk::PresentModeKHR::SHARED_DEMAND_REFRESH, "demand"),
    (vk::PresentModeKHR::SHARED_CONTINUOUS_REFRESH, "continuous"),
    (vk::PresentModeKHR::FIFO_LATEST_READY, "fifo_latest_ready"),
];

pub(super) const DEFAULT_WINDOW_SIZE: (u32, u32) = (128, 256);
pub(super) const MAX_FENCE_WAIT_TIMEOUT: u64 = 2_000_000_000;
// VUID-vkAcquireNextImageKHR-surface-07783
pub(super) const ACQUIRE_IMAGE_TIMEOUT: u64 = 10_000_000_000;

pub(super) fn is_shared_present_mode(mode: vk::PresentModeKHR) -> bool {
    mode == vk::PresentModeKHR::SHARED_DEMAND_REFRESH || mode == vk::PresentModeKHR::SHARED_CONTINUOUS_REFRESH
}

/// `addFunctionCase(group, name, checkSupport, testFunc, config)`
pub(super) struct ConfigCase<C> {
    pub name: String,
    pub config: C,
    pub check: fn(&Context<'_>, &C) -> Result<(), TestError>,
    pub test: fn(&Context<'_>, &C) -> TestOutcome,
}

impl<C: Send + Sync + 'static> TestCase for ConfigCase<C> {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        (self.check)(context, &self.config)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConfigInstance {
            context,
            config: &self.config,
            test: self.test,
        })
    }
}

struct ConfigInstance<'a, C> {
    context: &'a Context<'a>,
    config: &'a C,
    test: fn(&Context<'_>, &C) -> TestOutcome,
}

impl<C> TestInstance for ConfigInstance<'_, C> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context, self.config)
    }
}

pub(super) fn add_config_case<C: Send + Sync + 'static>(
    cases: &mut HashMap<String, Box<dyn TestCase>>,
    path: String,
    name: &str,
    config: C,
    check: fn(&Context<'_>, &C) -> Result<(), TestError>,
    test: fn(&Context<'_>, &C) -> TestOutcome,
) {
    cases.insert(
        path,
        Box::new(ConfigCase {
            name: name.to_string(),
            config,
            check,
            test,
        }),
    );
}

/// `chooseExt`
fn choose_ext(supported: &dyn Fn(&str) -> bool, ext: &str, khr: &str, prefer_ext: bool) -> bool {
    let has_ext = supported(ext);
    let has_khr = supported(khr);
    if !has_ext {
        false
    } else if !has_khr {
        true
    } else {
        prefer_ext
    }
}

/// `getRequiredInstanceExtensions` for the headless platform
pub(super) fn instance_extensions(
    context: &Context<'_>,
    require_device_group: bool,
    prefer_ext: bool,
) -> Vec<&'static str> {
    let supported = |extension: &str| is_instance_extension_available(context, extension);
    let mut extensions = vec!["VK_KHR_surface", "VK_EXT_headless_surface"];

    if context.get_platform().api_version < vk::make_version(1, 1, 0) {
        extensions.push("VK_KHR_get_physical_device_properties2");
    }
    if supported("VK_KHR_get_surface_capabilities2") {
        extensions.push("VK_KHR_get_surface_capabilities2");
    }

    let use_ext = choose_ext(
        &supported,
        "VK_EXT_surface_maintenance1",
        "VK_KHR_surface_maintenance1",
        prefer_ext,
    );
    extensions.push(if use_ext {
        "VK_EXT_surface_maintenance1"
    } else {
        "VK_KHR_surface_maintenance1"
    });

    // Both are enabled when the preference was not overridden, so an EXT-only device behind a KHR instance still works
    if prefer_ext == use_ext {
        if prefer_ext && supported("VK_KHR_surface_maintenance1") {
            extensions.push("VK_KHR_surface_maintenance1");
        } else if !prefer_ext && supported("VK_EXT_surface_maintenance1") {
            extensions.push("VK_EXT_surface_maintenance1");
        }
    }

    if require_device_group {
        extensions.push("VK_KHR_device_group_creation");
    }
    extensions
}

/// `getRequiredDeviceExtensions`
pub(super) fn device_extensions(
    context: &Context<'_>,
    require_swapchain_maintenance1: bool,
    bind_image_memory: bool,
    prefer_ext: bool,
) -> Vec<&'static str> {
    let supported = |extension: &str| context.is_device_functionality_supported(extension);
    let mut extensions = vec!["VK_KHR_swapchain"];

    if require_swapchain_maintenance1 {
        let use_ext = choose_ext(
            &supported,
            "VK_EXT_swapchain_maintenance1",
            "VK_KHR_swapchain_maintenance1",
            prefer_ext,
        );
        extensions.push(if use_ext {
            "VK_EXT_swapchain_maintenance1"
        } else {
            "VK_KHR_swapchain_maintenance1"
        });
    }
    if bind_image_memory {
        extensions.push("VK_KHR_device_group");
        if context.get_platform().api_version < vk::make_version(1, 1, 0) {
            extensions.push("VK_KHR_bind_memory2");
        }
    }
    if supported("VK_EXT_present_mode_fifo_latest_ready") {
        extensions.push("VK_EXT_present_mode_fifo_latest_ready");
    } else if supported("VK_KHR_present_mode_fifo_latest_ready") {
        extensions.push("VK_KHR_present_mode_fifo_latest_ready");
    }
    if supported("VK_KHR_shared_presentable_image") {
        extensions.push("VK_KHR_shared_presentable_image");
    }
    extensions
}

/// `commonCheckSupport` for the headless platform
pub(super) fn maintenance1_check_support(
    context: &Context<'_>,
    require_device_group: bool,
    require_swapchain_maintenance1: bool,
    bind_image_memory: bool,
    prefer_ext_for_instance: bool,
    prefer_ext_for_device: bool,
) -> Result<(), TestError> {
    for extension in instance_extensions(context, require_device_group, prefer_ext_for_instance) {
        if !is_instance_extension_available(context, extension) {
            return Err(TestError::NotSupported(format!(
                "{extension} is not supported by this implementation"
            )));
        }
    }
    for extension in device_extensions(
        context,
        require_swapchain_maintenance1,
        bind_image_memory,
        prefer_ext_for_device,
    ) {
        context.require_device_functionality(extension)?;
    }
    Ok(())
}

/// `InstanceHelper`
pub(super) fn create_instance(
    context: &Context<'_>,
    require_device_group: bool,
    prefer_ext: bool,
) -> Result<CustomInstance, TestError> {
    create_custom_instance(context, &instance_extensions(context, require_device_group, prefer_ext))
}

/// `DeviceHelper`
pub(super) struct Maintenance1Device {
    pub device: Device,
    pub queue: vk::Queue,
    pub queue_family_index: u32,
    uses_ext_swapchain_maintenance1: bool,
}

impl Maintenance1Device {
    /// `vkReleaseSwapchainImages{KHR,EXT}`, whichever extension the device enabled
    pub(super) fn release_swapchain_images(&self, info: &vk::ReleaseSwapchainImagesInfoKHR) -> Result<(), TestError> {
        use vulkanalia::vk::{
            ExtSwapchainMaintenance1ExtensionDeviceCommands, KhrSwapchainMaintenance1ExtensionDeviceCommands,
        };

        if self.uses_ext_swapchain_maintenance1 {
            unsafe { self.device.release_swapchain_images_ext(info) }.vk_check("vkReleaseSwapchainImagesEXT")
        } else {
            unsafe { self.device.release_swapchain_images_khr(info) }.vk_check("vkReleaseSwapchainImagesKHR")
        }
    }
}

impl Drop for Maintenance1Device {
    fn drop(&mut self) {
        unsafe { self.device.destroy_device(None) };
    }
}

pub(super) fn create_device(
    context: &Context<'_>,
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
    require_swapchain_maintenance1: bool,
    bind_image_memory: bool,
    prefer_ext: bool,
) -> Result<Maintenance1Device, TestError> {
    let queue_family_index = compatible_queue_family_indices(instance, physical_device, surface)?
        .first()
        .copied()
        .ok_or_else(|| {
            TestError::NotSupported("Device does not support presentation to the given surfaces".to_string())
        })?;

    let extensions = device_extensions(context, require_swapchain_maintenance1, bind_image_memory, prefer_ext);
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

    let mut swapchain_maintenance1_features = vk::PhysicalDeviceSwapchainMaintenance1FeaturesKHR {
        swapchain_maintenance1: vk::TRUE,
        ..Default::default()
    };
    let mut fifo_latest_ready_features = vk::PhysicalDevicePresentModeFifoLatestReadyFeaturesKHR {
        present_mode_fifo_latest_ready: vk::TRUE,
        ..Default::default()
    };
    let has_fifo_latest_ready = extensions
        .iter()
        .any(|extension| extension.ends_with("_present_mode_fifo_latest_ready"));

    let mut info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extension_ptrs);
    if require_swapchain_maintenance1 {
        info = info.push_next(&mut swapchain_maintenance1_features);
    }
    if has_fifo_latest_ready {
        info = info.push_next(&mut fifo_latest_ready_features);
    }

    let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;
    let queue = unsafe { device.get_device_queue(queue_family_index, 0) };
    Ok(Maintenance1Device {
        device,
        queue,
        queue_family_index,
        uses_ext_swapchain_maintenance1: extensions.contains(&"VK_EXT_swapchain_maintenance1"),
    })
}

/// `getPhysicalDeviceSurfaceCapabilities` and the per-present-mode queries: VkSurfaceCapabilities2KHR with an optional VkSurfacePresentModeKHR in the input
/// chain and `out_chain` (a pointer to the structure the caller wants filled, or null) in the output chain
pub(super) fn query_surface_capabilities2(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
    mode: Option<vk::PresentModeKHR>,
    out_chain: *mut c_void,
) -> Result<vk::SurfaceCapabilitiesKHR, vk::ErrorCode> {
    let mut mode_info = vk::SurfacePresentModeKHR {
        present_mode: mode.unwrap_or_default(),
        ..Default::default()
    };
    let info = vk::PhysicalDeviceSurfaceInfo2KHR {
        surface,
        next: if mode.is_some() {
            ptr::from_mut(&mut mode_info).cast_const().cast::<c_void>()
        } else {
            ptr::null()
        },
        ..Default::default()
    };
    let mut capabilities = vk::SurfaceCapabilities2KHR {
        next: out_chain,
        ..Default::default()
    };
    unsafe { instance.get_physical_device_surface_capabilities2_khr(physical_device, &info, &mut capabilities) }?;
    Ok(capabilities.surface_capabilities)
}

/// `getSurfaceScalingCapabilities`
pub(super) fn get_surface_scaling_capabilities(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    mode: vk::PresentModeKHR,
    surface: vk::SurfaceKHR,
) -> Result<vk::SurfacePresentScalingCapabilitiesKHR, TestError> {
    let mut scaling = vk::SurfacePresentScalingCapabilitiesKHR::default();
    query_surface_capabilities2(
        instance,
        physical_device,
        surface,
        Some(mode),
        ptr::from_mut(&mut scaling).cast::<c_void>(),
    )
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
    Ok(scaling)
}

/// `getSurfaceCompatiblePresentModes`
pub(super) fn get_surface_compatible_present_modes(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
    mode: vk::PresentModeKHR,
) -> Result<Vec<vk::PresentModeKHR>, TestError> {
    // Currently there are 6 present modes, 100 should cover all future ones!
    let mut compatible_modes = vec![vk::PresentModeKHR::default(); 100];
    let mut compatibility = vk::SurfacePresentModeCompatibilityKHR {
        present_mode_count: compatible_modes.len() as u32,
        present_modes: compatible_modes.as_mut_ptr(),
        ..Default::default()
    };
    query_surface_capabilities2(
        instance,
        physical_device,
        surface,
        Some(mode),
        ptr::from_mut(&mut compatibility).cast::<c_void>(),
    )
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
    compatible_modes.truncate(compatibility.present_mode_count as usize);
    Ok(compatible_modes)
}

pub(super) fn get_surface_present_modes(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
) -> Result<Vec<vk::PresentModeKHR>, TestError> {
    unsafe { instance.get_physical_device_surface_present_modes_khr(physical_device, surface) }
        .vk_check("vkGetPhysicalDeviceSurfacePresentModesKHR")
}

pub(super) fn get_surface_formats(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
) -> Result<Vec<vk::SurfaceFormatKHR>, TestError> {
    unsafe { instance.get_physical_device_surface_formats_khr(physical_device, surface) }
        .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")
}

/// `pickCompositeAlpha`: the lowest supported bit
fn pick_composite_alpha(supported: vk::CompositeAlphaFlagsKHR) -> vk::CompositeAlphaFlagsKHR {
    let bits = supported.bits();
    if bits == 0 {
        return vk::CompositeAlphaFlagsKHR::OPAQUE;
    }
    vk::CompositeAlphaFlagsKHR::from_bits_truncate(bits.isolate_lowest_one())
}

/// `getBasicSwapchainParameters`
pub(super) fn get_basic_swapchain_parameters(
    surface: vk::SurfaceKHR,
    surface_format: vk::SurfaceFormatKHR,
    desired_size: (u32, u32),
    present_mode: vk::PresentModeKHR,
    transform: vk::SurfaceTransformFlagsKHR,
    supported_composite_alpha: vk::CompositeAlphaFlagsKHR,
    desired_image_count: u32,
    defer_memory_allocation: bool,
) -> vk::SwapchainCreateInfoKHR {
    vk::SwapchainCreateInfoKHR {
        flags: if defer_memory_allocation {
            vk::SwapchainCreateFlagsKHR::DEFERRED_MEMORY_ALLOCATION
        } else {
            vk::SwapchainCreateFlagsKHR::empty()
        },
        surface,
        min_image_count: desired_image_count,
        image_format: surface_format.format,
        image_color_space: surface_format.color_space,
        image_extent: vk::Extent2D {
            width: desired_size.0,
            height: desired_size.1,
        },
        image_array_layers: 1,
        image_usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST,
        image_sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: ptr::null(),
        pre_transform: transform,
        composite_alpha: pick_composite_alpha(supported_composite_alpha),
        present_mode,
        clipped: vk::FALSE,
        old_swapchain: vk::SwapchainKHR::null(),
        ..Default::default()
    }
}

pub(super) fn identity_or_current_transform(capabilities: &vk::SurfaceCapabilitiesKHR) -> vk::SurfaceTransformFlagsKHR {
    if capabilities
        .supported_transforms
        .contains(vk::SurfaceTransformFlagsKHR::IDENTITY)
    {
        vk::SurfaceTransformFlagsKHR::IDENTITY
    } else {
        capabilities.current_transform
    }
}

/// xorshift32 standing in for `de::Random`
pub(super) struct Rng(u32);

impl Rng {
    pub(super) fn new(seed: u32) -> Self {
        Self(if seed == 0 { 0x9E37_79B9 } else { seed })
    }

    pub(super) fn get_u32(&mut self) -> u32 {
        let mut x = self.0;
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        self.0 = x;
        x
    }
}

/// `VK_CHECK(vkd.waitForFences(...))` for one fence
pub(super) fn wait_for_fence(device: &Device, fence: vk::Fence) -> Result<(), TestError> {
    let code = unsafe { device.wait_for_fences(&[fence], true, MAX_FENCE_WAIT_TIMEOUT) }.vk_check("vkWaitForFences")?;
    if code != vk::SuccessCode::SUCCESS {
        return Err(TestError::Fail(format!("vkWaitForFences returned {code:?}")));
    }
    Ok(())
}

/// Everything a test creates on its device, destroyed after a `deviceWaitIdle` in the reverse order of the dependencies (upstream's `Move`s and the catch block that waits idle)
pub(super) struct Resources<'a> {
    device: &'a Device,
    pub swapchains: Vec<vk::SwapchainKHR>,
    pub images: Vec<vk::Image>,
    command_pool: vk::CommandPool,
    semaphores: Vec<vk::Semaphore>,
    fences: Vec<vk::Fence>,
    buffers: Vec<(vk::Buffer, vk::DeviceMemory)>,
    cleanups: Vec<Box<dyn FnOnce(&Device)>>,
}

impl<'a> Resources<'a> {
    pub(super) fn new(device: &'a Device) -> Self {
        Self {
            device,
            swapchains: Vec::new(),
            images: Vec::new(),
            command_pool: vk::CommandPool::null(),
            semaphores: Vec::new(),
            fences: Vec::new(),
            buffers: Vec::new(),
            cleanups: Vec::new(),
        }
    }

    /// Runs `destroy` on drop, newest first and before everything else is destroyed: for the objects `Resources` has no list of (views, framebuffers, pipelines...)
    pub(super) fn push_cleanup(&mut self, destroy: impl FnOnce(&Device) + 'static) {
        self.cleanups.push(Box::new(destroy));
    }

    pub(super) fn command_pool(&self) -> vk::CommandPool {
        self.command_pool
    }

    pub(super) fn create_swapchain(
        &mut self,
        info: &vk::SwapchainCreateInfoKHR,
    ) -> Result<vk::SwapchainKHR, TestError> {
        let swapchain = unsafe { self.device.create_swapchain_khr(info, None) }.vk_check("vkCreateSwapchainKHR")?;
        self.swapchains.push(swapchain);
        Ok(swapchain)
    }

    pub(super) fn create_command_pool(&mut self, queue_family_index: u32) -> Result<(), TestError> {
        let info = vk::CommandPoolCreateInfo::builder()
            .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)
            .queue_family_index(queue_family_index);
        self.command_pool = unsafe { self.device.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?;
        Ok(())
    }

    pub(super) fn allocate_command_buffers(&self, count: usize) -> Result<Vec<vk::CommandBuffer>, TestError> {
        let info = vk::CommandBufferAllocateInfo::builder()
            .command_pool(self.command_pool)
            .level(vk::CommandBufferLevel::PRIMARY)
            .command_buffer_count(count as u32);
        unsafe { self.device.allocate_command_buffers(&info) }.vk_check("vkAllocateCommandBuffers")
    }

    pub(super) fn create_semaphore(&mut self) -> Result<vk::Semaphore, TestError> {
        let semaphore = unsafe { self.device.create_semaphore(&vk::SemaphoreCreateInfo::default(), None) }
            .vk_check("vkCreateSemaphore")?;
        self.semaphores.push(semaphore);
        Ok(semaphore)
    }

    /// Destroys a semaphore the test knows is no longer waited on (`presentSems[i].clear()`)
    pub(super) fn destroy_semaphore(&mut self, semaphore: vk::Semaphore) {
        if let Some(slot) = self.semaphores.iter_mut().find(|slot| **slot == semaphore) {
            unsafe { self.device.destroy_semaphore(*slot, None) };
            *slot = vk::Semaphore::null();
        }
    }

    /// A fence the test created for one step and is done with (`Move<VkFence>` going out of scope)
    pub(super) fn destroy_fence(&mut self, fence: vk::Fence) {
        if let Some(slot) = self.fences.iter_mut().find(|slot| **slot == fence) {
            unsafe { self.device.destroy_fence(*slot, None) };
            *slot = vk::Fence::null();
        }
    }

    pub(super) fn create_fence(&mut self) -> Result<vk::Fence, TestError> {
        let fence =
            unsafe { self.device.create_fence(&vk::FenceCreateInfo::default(), None) }.vk_check("vkCreateFence")?;
        self.fences.push(fence);
        Ok(fence)
    }

    /// `createFence(vkd, device, VK_FENCE_CREATE_SIGNALED_BIT)`
    pub(super) fn create_signaled_fence(&mut self) -> Result<vk::Fence, TestError> {
        let info = vk::FenceCreateInfo::builder().flags(vk::FenceCreateFlags::SIGNALED);
        let fence = unsafe { self.device.create_fence(&info, None) }.vk_check("vkCreateFence")?;
        self.fences.push(fence);
        Ok(fence)
    }

    /// `createBufferAndBindMemory`: a TRANSFER_SRC buffer of `count` copies of `color32`
    pub(super) fn create_host_buffer(
        &mut self,
        instance: &Instance,
        physical_device: vk::PhysicalDevice,
        queue_family_index: u32,
        color32: u32,
        count: u32,
    ) -> Result<vk::Buffer, TestError> {
        let queue_family_indices = [queue_family_index];
        let size = u64::from(count) * 4;
        let info = vk::BufferCreateInfo::builder()
            .size(size)
            .usage(vk::BufferUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .queue_family_indices(&queue_family_indices);
        let buffer = unsafe { self.device.create_buffer(&info, None) }.vk_check("vkCreateBuffer")?;
        self.buffers.push((buffer, vk::DeviceMemory::null()));
        let slot = self.buffers.len() - 1;

        let requirements = unsafe { self.device.get_buffer_memory_requirements(buffer) };
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        let wanted = vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::HOST_COHERENT;
        let memory_type_index = (0..memory_properties.memory_type_count)
            .find(|&i| {
                requirements.memory_type_bits & (1 << i) != 0
                    && memory_properties.memory_types[i as usize]
                        .property_flags
                        .contains(wanted)
            })
            .ok_or_else(|| TestError::NotSupported("no host visible coherent memory type".to_string()))?;
        let allocate_info = vk::MemoryAllocateInfo::builder()
            .allocation_size(requirements.size)
            .memory_type_index(memory_type_index);
        let memory = unsafe { self.device.allocate_memory(&allocate_info, None) }.vk_check("vkAllocateMemory")?;
        self.buffers[slot].1 = memory;
        unsafe { self.device.bind_buffer_memory(buffer, memory, 0) }.vk_check("vkBindBufferMemory")?;

        let mapped =
            unsafe { self.device.map_memory(memory, 0, size, vk::MemoryMapFlags::empty()) }.vk_check("vkMapMemory")?;
        unsafe {
            std::slice::from_raw_parts_mut(mapped.cast::<u32>(), count as usize).fill(color32);
            self.device.unmap_memory(memory);
        }
        Ok(buffer)
    }
}

impl Drop for Resources<'_> {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            while let Some(destroy) = self.cleanups.pop() {
                destroy(self.device);
            }
            self.device.destroy_command_pool(self.command_pool, None);
            for &fence in &self.fences {
                self.device.destroy_fence(fence, None);
            }
            for &semaphore in &self.semaphores {
                self.device.destroy_semaphore(semaphore, None);
            }
            for &(buffer, memory) in &self.buffers {
                self.device.destroy_buffer(buffer, None);
                self.device.free_memory(memory, None);
            }
            for &image in &self.images {
                self.device.destroy_image(image, None);
            }
            for &swapchain in &self.swapchains {
                self.device.destroy_swapchain_khr(swapchain, None);
            }
        }
    }
}

/// `VK_CHECK_WSI` on a present or acquire: a SUBOPTIMAL success is fine, a timeout is not
pub(super) fn check_wsi_success(code: vk::SuccessCode, what: &str) -> Result<(), TestError> {
    match code {
        vk::SuccessCode::SUCCESS | vk::SuccessCode::SUBOPTIMAL_KHR => Ok(()),
        other => Err(TestError::Fail(format!("{what} returned {other:?}"))),
    }
}

/// `copyBufferToImage`
fn copy_buffer_to_image(
    device: &Device,
    command_buffer: vk::CommandBuffer,
    buffer: vk::Buffer,
    image: vk::Image,
    offset: (u32, u32),
    extent: (u32, u32),
) {
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
        image_offset: vk::Offset3D {
            x: offset.0 as i32,
            y: offset.1 as i32,
            z: 0,
        },
        image_extent: vk::Extent3D {
            width: extent.0,
            height: extent.1,
            depth: 1,
        },
    };
    unsafe {
        device.cmd_copy_buffer_to_image(
            command_buffer,
            buffer,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[region],
        )
    };
}

pub(super) fn color_subresource_range() -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    }
}

pub(super) fn image_barrier(
    image: vk::Image,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
) -> vk::ImageMemoryBarrier {
    vk::ImageMemoryBarrier {
        src_access_mask: src_access,
        dst_access_mask: dst_access,
        old_layout,
        new_layout,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        image,
        subresource_range: color_subresource_range(),
        ..Default::default()
    }
}

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------
// present_modes.<mode>.query
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub(super) struct ModeConfig {
    pub mode: vk::PresentModeKHR,
    pub prefer_ext: bool,
}

/// `verifyCompatiblePresentModes`
fn verify_compatible_present_modes(
    supported_modes: &[vk::PresentModeKHR],
    query_mode: vk::PresentModeKHR,
    compatible_modes: &[vk::PresentModeKHR],
    previously_queried: Option<&[vk::PresentModeKHR]>,
) -> Result<(), String> {
    for mode in compatible_modes {
        if !supported_modes.contains(mode) {
            return Err(format!(
                "Returned compatible present mode {mode:?} is not a supported present mode"
            ));
        }
    }

    if !compatible_modes.is_empty() && !compatible_modes.contains(&query_mode) {
        return Err("Returned compatible present modes does not include the mode used in the query".to_string());
    }

    let mut visited: Vec<vk::PresentModeKHR> = Vec::new();
    for &mode in compatible_modes {
        if visited.contains(&mode) {
            return Err(format!(
                "Duplicate mode {mode:?} returned in list of compatible present modes"
            ));
        }
        visited.push(mode);
    }

    if let Some(previous) = previously_queried {
        for mode in previous {
            if !visited.contains(mode) {
                return Err(format!(
                    "Different sets of compatible modes returned on re-query (present mode {mode:?} missing on requery)"
                ));
            }
        }
    }
    Ok(())
}

fn check_present_modes_query_support(context: &Context<'_>, config: &ModeConfig) -> Result<(), TestError> {
    maintenance1_check_support(context, false, false, false, config.prefer_ext, false)
}

/// `presentModesQueryTest`
fn present_modes_query_test(context: &Context<'_>, config: &ModeConfig) -> TestOutcome {
    const INVALID_VALUE: vk::PresentModeKHR = vk::PresentModeKHR::from_raw(0x1234);

    let helper = create_instance(context, false, config.prefer_ext)?;
    let surface = Surface::headless(&helper.instance)?;
    let physical_device = helper.physical_device;
    let _device = create_device(
        context,
        &helper.instance,
        physical_device,
        surface.surface,
        false,
        false,
        false,
    )?;

    let present_modes = get_surface_present_modes(&helper.instance, physical_device, surface.surface)?;
    if !present_modes.contains(&config.mode) {
        return Err(TestError::NotSupported("Present mode not supported".to_string()));
    }

    let mut compatibility = vk::SurfacePresentModeCompatibilityKHR::default();
    let query = |compatibility: &mut vk::SurfacePresentModeCompatibilityKHR| {
        query_surface_capabilities2(
            &helper.instance,
            physical_device,
            surface.surface,
            Some(config.mode),
            ptr::from_mut(compatibility).cast::<c_void>(),
        )
    };

    // Test that querying only the count works.
    query(&mut compatibility).vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;

    // Sometime ICD selected will not support the instance extensions got in enumerateInstanceExtensionProperties
    if compatibility.present_mode_count < 1 {
        return Err(TestError::NotSupported(
            "Empty compatible present mode list, VK_EXT_surface_maintenance1 not supported.".to_string(),
        ));
    }

    let original_count = compatibility.present_mode_count;
    let mut compatible_modes = vec![INVALID_VALUE; original_count as usize];
    compatibility.present_modes = compatible_modes.as_mut_ptr();

    // Check result when count is 0
    compatibility.present_mode_count = 0;
    if query(&mut compatibility).is_err() {
        return Ok(TestStatus::fail("Wrong result when the size is 0"));
    }

    // Check result when count is too small
    compatibility.present_mode_count = original_count - 1;
    if query(&mut compatibility).is_err() {
        return Ok(TestStatus::fail("Wrong result when the size is too small"));
    }

    // Make sure whatever _is_ returned is valid.
    if compatibility.present_mode_count > original_count - 1 {
        return Ok(TestStatus::fail("Re-query returned more results than provided"));
    }

    // Ensure the rest of the array is not overwritten
    if compatible_modes[compatibility.present_mode_count as usize..]
        .iter()
        .any(|&mode| mode != INVALID_VALUE)
    {
        return Ok(TestStatus::fail("Query overwrote beyond returned count"));
    }
    compatible_modes.truncate(compatibility.present_mode_count as usize);
    if let Err(message) = verify_compatible_present_modes(&present_modes, config.mode, &compatible_modes, None) {
        return Ok(TestStatus::fail(message));
    }

    // Check result when count is correct
    compatibility.present_mode_count = original_count;
    let mut compatible_modes2 = vec![INVALID_VALUE; original_count as usize];
    compatibility.present_modes = compatible_modes2.as_mut_ptr();
    query(&mut compatibility).vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;

    if compatibility.present_mode_count != original_count {
        return Ok(TestStatus::fail(
            "Re-query returned different results count than provided",
        ));
    }
    if let Err(message) =
        verify_compatible_present_modes(&present_modes, config.mode, &compatible_modes2, Some(&compatible_modes))
    {
        return Ok(TestStatus::fail(message));
    }

    // Check that querying with a count higher than supported still returns as many results as before.
    compatibility.present_mode_count = original_count * 2;
    let mut compatible_modes3 = vec![INVALID_VALUE; (original_count * 2) as usize];
    compatibility.present_modes = compatible_modes3.as_mut_ptr();
    query(&mut compatibility).vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;

    if compatibility.present_mode_count != original_count {
        return Ok(TestStatus::fail(
            "Re-query returned different results count than provided",
        ));
    }
    if compatible_modes3[compatibility.present_mode_count as usize..]
        .iter()
        .any(|&mode| mode != INVALID_VALUE)
    {
        return Ok(TestStatus::fail("Query overwrote beyond returned count"));
    }
    compatible_modes3.truncate(compatibility.present_mode_count as usize);
    if let Err(message) = verify_compatible_present_modes(
        &present_modes,
        config.mode,
        &compatible_modes3,
        Some(&compatible_modes2),
    ) {
        return Ok(TestStatus::fail(message));
    }

    Ok(TestStatus::pass("Tests ran successfully"))
}

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------
// scaling.*
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum SwapchainWindowSize {
    Identical,
    SwapchainBigger,
    SwapchainSmaller,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SwapchainWindowAspect {
    Identical,
    SwapchainTaller,
    SwapchainWider,
}

#[derive(Clone, Copy)]
struct ScalingConfig {
    mode: vk::PresentModeKHR,
    scaling: vk::PresentScalingFlagsKHR,
    gravity_x: vk::PresentGravityFlagsKHR,
    gravity_y: vk::PresentGravityFlagsKHR,
    size: SwapchainWindowSize,
    aspect: SwapchainWindowAspect,
    // Either have the swapchain be created with a different size, or resize the window after swapchain creation
    resize_window: bool,
    prefer_ext: bool,
}

fn check_scaling_query_support(context: &Context<'_>, config: &ModeConfig) -> Result<(), TestError> {
    maintenance1_check_support(context, false, false, false, config.prefer_ext, false)
}

/// `scalingQueryTest`
fn scaling_query_test(context: &Context<'_>, config: &ModeConfig) -> TestOutcome {
    let helper = create_instance(context, false, config.prefer_ext)?;
    let surface = Surface::headless(&helper.instance)?;
    let physical_device = helper.physical_device;
    let _device = create_device(
        context,
        &helper.instance,
        physical_device,
        surface.surface,
        false,
        false,
        false,
    )?;

    let present_modes = get_surface_present_modes(&helper.instance, physical_device, surface.surface)?;
    if !present_modes.contains(&config.mode) {
        return Err(TestError::NotSupported("Present mode not supported".to_string()));
    }

    let scaling = get_surface_scaling_capabilities(&helper.instance, physical_device, config.mode, surface.surface)?;

    let scaling_flags = vk::PresentScalingFlagsKHR::ONE_TO_ONE
        | vk::PresentScalingFlagsKHR::ASPECT_RATIO_STRETCH
        | vk::PresentScalingFlagsKHR::STRETCH;
    let gravity_flags =
        vk::PresentGravityFlagsKHR::MIN | vk::PresentGravityFlagsKHR::MAX | vk::PresentGravityFlagsKHR::CENTERED;

    if !(scaling.supported_present_scaling & !scaling_flags).is_empty() {
        return Ok(TestStatus::fail("Invalid bits in scaling flags"));
    }
    if !(scaling.supported_present_gravity_x & !gravity_flags).is_empty() {
        return Ok(TestStatus::fail("Invalid bits in gravity flags (x axis)"));
    }
    if !(scaling.supported_present_gravity_y & !gravity_flags).is_empty() {
        return Ok(TestStatus::fail("Invalid bits in gravity flags (y axis)"));
    }

    Ok(TestStatus::pass("Tests ran successfully"))
}

fn check_scaling_query_compatible_modes_support(context: &Context<'_>, config: &ModeConfig) -> Result<(), TestError> {
    maintenance1_check_support(context, false, false, false, config.prefer_ext, config.prefer_ext)
}

/// `scalingQueryCompatibleModesTest`
fn scaling_query_compatible_modes_test(context: &Context<'_>, config: &ModeConfig) -> TestOutcome {
    let helper = create_instance(context, false, config.prefer_ext)?;
    let surface = Surface::headless(&helper.instance)?;
    let physical_device = helper.physical_device;
    let _device = create_device(
        context,
        &helper.instance,
        physical_device,
        surface.surface,
        false,
        false,
        config.prefer_ext,
    )?;

    let present_modes = get_surface_present_modes(&helper.instance, physical_device, surface.surface)?;
    if !present_modes.contains(&config.mode) {
        return Err(TestError::NotSupported("Present mode not supported".to_string()));
    }

    // Query compatible present modes, and scaling capabilities for each mode.  They must all be identical.
    let mut compatibility = vk::SurfacePresentModeCompatibilityKHR::default();
    let query = |compatibility: &mut vk::SurfacePresentModeCompatibilityKHR| {
        query_surface_capabilities2(
            &helper.instance,
            physical_device,
            surface.surface,
            Some(config.mode),
            ptr::from_mut(compatibility).cast::<c_void>(),
        )
    };
    query(&mut compatibility).vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
    let mut compatible_modes = vec![vk::PresentModeKHR::from_raw(0x5678); compatibility.present_mode_count as usize];
    compatibility.present_modes = compatible_modes.as_mut_ptr();
    query(&mut compatibility).vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
    compatible_modes.truncate(compatibility.present_mode_count as usize);

    let mut scaling = Vec::new();
    for &mode in &compatible_modes {
        scaling.push(get_surface_scaling_capabilities(
            &helper.instance,
            physical_device,
            mode,
            surface.surface,
        )?);
    }

    for entry in scaling.iter().skip(1) {
        if entry.supported_present_scaling != scaling[0].supported_present_scaling {
            return Ok(TestStatus::fail(
                "Different scaling flags for compatible present modes is not allowed",
            ));
        }
        if entry.supported_present_gravity_x != scaling[0].supported_present_gravity_x {
            return Ok(TestStatus::fail(
                "Different gravity flags (x axis) for compatible present modes is not allowed",
            ));
        }
        if entry.supported_present_gravity_y != scaling[0].supported_present_gravity_y {
            return Ok(TestStatus::fail(
                "Different gravity flags (y axis) for compatible present modes is not allowed",
            ));
        }
    }

    Ok(TestStatus::pass("Tests ran successfully"))
}

fn check_scaling_support(context: &Context<'_>, config: &ScalingConfig) -> Result<(), TestError> {
    maintenance1_check_support(context, false, true, false, config.prefer_ext, config.prefer_ext)
}

/// `scalingTest`
fn scaling_test(context: &Context<'_>, config: &ScalingConfig) -> TestOutcome {
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

    let capabilities = query_surface_capabilities2(instance, physical_device, surface.surface, None, ptr::null_mut())
        .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;
    let transform = identity_or_current_transform(&capabilities);

    let present_modes = get_surface_present_modes(instance, physical_device, surface.surface)?;
    if !present_modes.contains(&config.mode) {
        return Err(TestError::NotSupported("Present mode not supported".to_string()));
    }

    // Skip if configuration is not supported
    let scaling = get_surface_scaling_capabilities(instance, physical_device, config.mode, surface.surface)?;
    if (scaling.supported_present_scaling & config.scaling).is_empty() {
        return Err(TestError::NotSupported("Scaling mode is not supported".to_string()));
    }
    if config.scaling != vk::PresentScalingFlagsKHR::STRETCH {
        if (scaling.supported_present_gravity_x & config.gravity_x).is_empty() {
            return Err(TestError::NotSupported(
                "Gravity mode is not supported (x axis)".to_string(),
            ));
        }
        if (scaling.supported_present_gravity_y & config.gravity_y).is_empty() {
            return Err(TestError::NotSupported(
                "Gravity mode is not supported (y axis)".to_string(),
            ));
        }
    }

    let is_shared = is_shared_present_mode(config.mode);

    let mut swapchain_size = DEFAULT_WINDOW_SIZE;
    if !config.resize_window {
        match config.size {
            SwapchainWindowSize::SwapchainBigger => {
                swapchain_size.0 *= 2;
                swapchain_size.1 *= 2;
            }
            SwapchainWindowSize::SwapchainSmaller => {
                swapchain_size.0 /= 2;
                swapchain_size.1 /= 2;
            }
            SwapchainWindowSize::Identical => {}
        }
        match config.aspect {
            SwapchainWindowAspect::SwapchainTaller => swapchain_size.1 += swapchain_size.1 / 2,
            SwapchainWindowAspect::SwapchainWider => swapchain_size.0 += swapchain_size.0 / 2,
            SwapchainWindowAspect::Identical => {}
        }
    }

    let mut swapchain_info = get_basic_swapchain_parameters(
        surface.surface,
        surface_format,
        swapchain_size,
        config.mode,
        transform,
        capabilities.supported_composite_alpha,
        capabilities.min_image_count,
        false,
    );
    let scaling_info = vk::SwapchainPresentScalingCreateInfoKHR {
        scaling_behavior: config.scaling,
        present_gravity_x: config.gravity_x,
        present_gravity_y: config.gravity_y,
        ..Default::default()
    };
    swapchain_info.next = ptr::from_ref(&scaling_info).cast::<c_void>();

    let mut resources = Resources::new(device);
    let swapchain = resources.create_swapchain(&swapchain_info)?;
    let swapchain_images = unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;

    resources.create_command_pool(dev.queue_family_index)?;

    const ITERATIONS: usize = 100;

    // Do iterations presents, with a fence associated with the last one.
    let present_fence = resources.create_fence()?;
    let mut acquire_sems = Vec::with_capacity(ITERATIONS);
    let mut present_sems = Vec::with_capacity(ITERATIONS);
    for _ in 0..ITERATIONS {
        acquire_sems.push(resources.create_semaphore()?);
    }
    for _ in 0..ITERATIONS {
        present_sems.push(resources.create_semaphore()?);
    }
    let command_buffers = resources.allocate_command_buffers(ITERATIONS)?;

    let quarter_pixels = swapchain_size.0 * swapchain_size.1 / 4;
    let color = |r: u32, g: u32, b: u32, a: u32| r | g << 8 | b << 16 | a << 24;
    let mut buffers = Vec::new();
    for color32 in [
        color(255, 30, 20, 255),
        color(0, 255, 50, 255),
        color(40, 60, 255, 255),
        color(200, 220, 20, 255),
    ] {
        buffers.push(resources.create_host_buffer(
            instance,
            physical_device,
            dev.queue_family_index,
            color32,
            quarter_pixels,
        )?);
    }
    let (red_buffer, green_buffer, blue_buffer, yellow_buffer) = (buffers[0], buffers[1], buffers[2], buffers[3]);

    for i in 0..ITERATIONS {
        let present_sem = present_sems[i];
        let mut acquire_sem = acquire_sems[i];
        let image_index;

        if !is_shared || i == 0 {
            let (index, code) = unsafe {
                device.acquire_next_image_khr(swapchain, ACQUIRE_IMAGE_TIMEOUT, acquire_sem, vk::Fence::null())
            }
            .vk_check("vkAcquireNextImageKHR")?;
            check_wsi_success(code, "vkAcquireNextImageKHR")?;
            image_index = index;
        } else {
            // Shared present mode always has one image, so index is always 0.
            image_index = 0;
            // Since acquire is skipped, there is no acquire semaphore.
            acquire_sem = vk::Semaphore::null();
        }
        let image = swapchain_images[image_index as usize];
        let command_buffer = command_buffers[i];

        unsafe {
            device
                .begin_command_buffer(command_buffer, &vk::CommandBufferBeginInfo::default())
                .vk_check("vkBeginCommandBuffer")?;

            let to_transfer = image_barrier(
                image,
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            );
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );

            let half = (swapchain_size.0 / 2, swapchain_size.1 / 2);
            copy_buffer_to_image(device, command_buffer, red_buffer, image, (0, 0), half);
            copy_buffer_to_image(
                device,
                command_buffer,
                green_buffer,
                image,
                (half.0, 0),
                (swapchain_size.0 - half.0, half.1),
            );
            copy_buffer_to_image(
                device,
                command_buffer,
                blue_buffer,
                image,
                (0, half.1),
                (half.0, swapchain_size.1 - half.1),
            );
            copy_buffer_to_image(
                device,
                command_buffer,
                yellow_buffer,
                image,
                half,
                (swapchain_size.0 - half.0, swapchain_size.1 - half.1),
            );

            let to_present = image_barrier(
                image,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::empty(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::PRESENT_SRC_KHR,
            );
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_present],
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
        unsafe { device.queue_submit(dev.queue, &[submit_info], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;

        // Present the frame, signal the present fence on the last present.
        let present_fence_info = vk::SwapchainPresentFenceInfoKHR {
            swapchain_count: 1,
            fences: &present_fence,
            ..Default::default()
        };
        let mut result = vk::Result::SUCCESS;
        let present_info = vk::PresentInfoKHR {
            next: if i + 1 == ITERATIONS {
                ptr::from_ref(&present_fence_info).cast::<c_void>()
            } else {
                ptr::null()
            },
            wait_semaphore_count: 1,
            wait_semaphores: &present_sem,
            swapchain_count: 1,
            swapchains: &swapchain,
            image_indices: &image_index,
            results: &mut result,
            ..Default::default()
        };
        let code = unsafe { device.queue_present_khr(dev.queue, &present_info) }.vk_check("vkQueuePresentKHR")?;
        check_wsi_success(code, "vkQueuePresentKHR")?;
        if result != vk::Result::SUCCESS && result != vk::Result::SUBOPTIMAL_KHR {
            return Err(TestError::Fail(format!("vkQueuePresentKHR result[0] is {result:?}")));
        }
    }

    // Wait for all presents before terminating the test (when semaphores are destroyed)
    wait_for_fence(device, present_fence)?;

    Ok(TestStatus::pass("Tests ran successfully"))
}

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------
// registration
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------

fn populate_scaling_tests(cases: &mut HashMap<String, Box<dyn TestCase>>, prefix: &str, resize_window: bool) {
    const SCALING_FLAGS: [(vk::PresentScalingFlagsKHR, &str); 3] = [
        (vk::PresentScalingFlagsKHR::ONE_TO_ONE, "one_to_one"),
        (vk::PresentScalingFlagsKHR::ASPECT_RATIO_STRETCH, "aspect_stretch"),
        (vk::PresentScalingFlagsKHR::STRETCH, "stretch"),
    ];
    const GRAVITY_FLAGS: [(vk::PresentGravityFlagsKHR, &str); 3] = [
        (vk::PresentGravityFlagsKHR::MIN, "min"),
        (vk::PresentGravityFlagsKHR::MAX, "max"),
        (vk::PresentGravityFlagsKHR::CENTERED, "center"),
    ];

    let mut prefer_ext = true;
    for &(mode, mode_name) in &PRESENT_MODES {
        let mode_prefix = format!("{prefix}.{mode_name}");

        let query_config = ModeConfig { mode, prefer_ext };
        add_config_case(
            cases,
            format!("{mode_prefix}.query.basic"),
            "basic",
            query_config,
            check_scaling_query_support,
            scaling_query_test,
        );
        add_config_case(
            cases,
            format!("{mode_prefix}.query.verify_compatible_present_modes"),
            "verify_compatible_present_modes",
            ModeConfig {
                mode,
                prefer_ext: !prefer_ext,
            },
            check_scaling_query_compatible_modes_support,
            scaling_query_compatible_modes_test,
        );

        for &(scaling, scaling_name) in &SCALING_FLAGS {
            let is_stretch = scaling == vk::PresentScalingFlagsKHR::STRETCH;
            let mut sub_test_prefer_ext = prefer_ext;

            for &(gravity_x, gravity_x_name) in &GRAVITY_FLAGS {
                for &(gravity_y, gravity_y_name) in &GRAVITY_FLAGS {
                    // Gravity does not apply to stretch
                    let group = if is_stretch {
                        format!("{mode_prefix}.{scaling_name}")
                    } else {
                        format!("{mode_prefix}.{scaling_name}.{gravity_x_name}_{gravity_y_name}")
                    };

                    let sub_cases: [(&str, SwapchainWindowSize, SwapchainWindowAspect, bool); 9] = [
                        (
                            "same_size_and_aspect",
                            SwapchainWindowSize::Identical,
                            SwapchainWindowAspect::Identical,
                            sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_bigger_same_aspect",
                            SwapchainWindowSize::SwapchainBigger,
                            SwapchainWindowAspect::Identical,
                            !sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_smaller_same_aspect",
                            SwapchainWindowSize::SwapchainSmaller,
                            SwapchainWindowAspect::Identical,
                            sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_taller",
                            SwapchainWindowSize::Identical,
                            SwapchainWindowAspect::SwapchainTaller,
                            !sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_bigger_taller_aspect",
                            SwapchainWindowSize::SwapchainBigger,
                            SwapchainWindowAspect::SwapchainTaller,
                            sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_smaller_taller_aspect",
                            SwapchainWindowSize::SwapchainSmaller,
                            SwapchainWindowAspect::SwapchainTaller,
                            !sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_wider",
                            SwapchainWindowSize::Identical,
                            SwapchainWindowAspect::SwapchainWider,
                            sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_bigger_wider_aspect",
                            SwapchainWindowSize::SwapchainBigger,
                            SwapchainWindowAspect::SwapchainWider,
                            !sub_test_prefer_ext,
                        ),
                        (
                            "swapchain_smaller_wider_aspect",
                            SwapchainWindowSize::SwapchainSmaller,
                            SwapchainWindowAspect::SwapchainWider,
                            sub_test_prefer_ext,
                        ),
                    ];
                    for (name, size, aspect, case_prefer_ext) in sub_cases {
                        add_config_case(
                            cases,
                            format!("{group}.{name}"),
                            name,
                            ScalingConfig {
                                mode,
                                scaling,
                                gravity_x,
                                gravity_y,
                                size,
                                aspect,
                                resize_window,
                                prefer_ext: case_prefer_ext,
                            },
                            check_scaling_support,
                            scaling_test,
                        );
                    }

                    if is_stretch {
                        break;
                    }
                    sub_test_prefer_ext = !sub_test_prefer_ext;
                }

                if is_stretch {
                    break;
                }
            }
        }

        prefer_ext = !prefer_ext;
    }
}

/// `createMaintenance1Tests` for the headless platform, keyed by the dotted path (`headless.maintenance1.<group>...`)
pub fn create_headless_maintenance1_cases() -> HashMap<String, Box<dyn TestCase>> {
    const ROOT: &str = "headless.maintenance1";
    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();

    add_present_fence_cases(&mut cases, ROOT);

    let mut prefer_ext = true;
    for &(mode, mode_name) in &PRESENT_MODES {
        add_config_case(
            &mut cases,
            format!("{ROOT}.present_modes.{mode_name}.query"),
            "query",
            ModeConfig { mode, prefer_ext },
            check_present_modes_query_support,
            present_modes_query_test,
        );
        prefer_ext = !prefer_ext;
    }

    populate_scaling_tests(&mut cases, &format!("{ROOT}.scaling"), false);
    populate_scaling_tests(&mut cases, &format!("{ROOT}.scaling.resize_window"), true);
    cases
}
