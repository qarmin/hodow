// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktTestCase.hpp / .cpp (vkt::Context)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's Context also carries the
// resource interface, the pipeline compiler and the VulkanSC machinery; none of that
// is ported, so this is the default-device slice of it.

use std::cell::RefCell;
use std::ffi::{CStr, CString};
use std::rc::Rc;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::SimpleAllocator;
use crate::vk::platform::{Platform, PlatformError};
use crate::vk::programs::BinaryCollection;

/// `vkt::Context` - the default instance, physical device, device, queue and
/// allocator that a test runs against unless it builds its own.
pub struct Context<'a> {
    platform: &'a Platform,
    physical_device: vk::PhysicalDevice,
    device: Device,
    universal_queue: vk::Queue,
    universal_queue_family_index: u32,
    /// `Context::getComputeQueue` / `getTransferQueue`, absent when the device has no
    /// such family. A queue may only be fetched from a family the device was *created*
    /// with, so these are resolved once here rather than on demand in a test.
    compute_queue: Option<(vk::Queue, u32)>,
    transfer_queue: Option<(vk::Queue, u32)>,
    default_allocator: SimpleAllocator,
    device_properties: vk::PhysicalDeviceProperties,
    device_features: vk::PhysicalDeviceFeatures,
    device_extensions: Vec<String>,
    binary_collection: BinaryCollection,
    /// `MultiQueues`' device, built on first use and shared by every case that asks
    /// for it. Upstream caches it in a static for the same reason: creating a device
    /// per case is the dominant cost of a group with thousands of them.
    multi_queue_device: RefCell<Option<Rc<MultiQueueDevice>>>,
}

impl<'a> Context<'a> {
    /// Creates the default device on `physical_device`.
    ///
    /// Upstream picks the queue family with GRAPHICS|COMPUTE for the "universal"
    /// queue; the same choice is made here so a test that assumes both capabilities
    /// on `getUniversalQueue()` behaves identically.
    pub fn new(platform: &'a Platform, physical_device: vk::PhysicalDevice, binary_collection: BinaryCollection) -> Result<Self, TestError> {
        let instance = &platform.instance;

        let queue_families = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
        let universal_queue_family_index = queue_families
            .iter()
            .position(|f| f.queue_flags.contains(vk::QueueFlags::GRAPHICS) && f.queue_flags.contains(vk::QueueFlags::COMPUTE))
            .ok_or_else(|| TestError::NotSupported("no queue family supports both graphics and compute".to_string()))? as u32;

        // `findQueueFamilyIndexWithCapsNoThrow(COMPUTE, excluding GRAPHICS)` and its
        // transfer twin, matching upstream's DefaultDevice exactly - a case that is
        // NotSupported here has to be NotSupported there.
        let compute_queue_family_index = queue_families
            .iter()
            .position(|f| f.queue_flags.contains(vk::QueueFlags::COMPUTE) && !f.queue_flags.contains(vk::QueueFlags::GRAPHICS))
            .map(|i| i as u32);
        let transfer_queue_family_index = queue_families
            .iter()
            .position(|f| f.queue_flags.contains(vk::QueueFlags::TRANSFER) && !f.queue_flags.contains(vk::QueueFlags::GRAPHICS) && !f.queue_flags.contains(vk::QueueFlags::COMPUTE))
            .map(|i| i as u32);

        // Every family a test may later ask a queue from has to be requested here.
        // vkGetDeviceQueue on a family the device was not created with is undefined
        // behaviour, and in practice segfaults rather than returning an error.
        let mut families = vec![universal_queue_family_index];
        for extra in [compute_queue_family_index, transfer_queue_family_index].into_iter().flatten() {
            if !families.contains(&extra) {
                families.push(extra);
            }
        }

        let priorities = [1.0f32];
        let queue_infos: Vec<vk::DeviceQueueCreateInfo> = families
            .iter()
            .map(|&family| vk::DeviceQueueCreateInfo::builder().queue_family_index(family).queue_priorities(&priorities).build())
            .collect();

        let device_features = unsafe { instance.get_physical_device_features(physical_device) };

        let (device, available_extensions) = create_device_with_everything(instance, physical_device, &queue_infos)?;

        let universal_queue = unsafe { device.get_device_queue(universal_queue_family_index, 0) };
        let compute_queue = compute_queue_family_index.map(|i| (unsafe { device.get_device_queue(i, 0) }, i));
        let transfer_queue = transfer_queue_family_index.map(|i| (unsafe { device.get_device_queue(i, 0) }, i));
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        let device_properties = unsafe { instance.get_physical_device_properties(physical_device) };

        Ok(Self {
            platform,
            physical_device,
            device,
            universal_queue,
            universal_queue_family_index,
            compute_queue,
            transfer_queue,
            default_allocator: SimpleAllocator::new(memory_properties),
            device_properties,
            device_features,
            device_extensions: available_extensions,
            binary_collection,
            multi_queue_device: RefCell::new(None),
        })
    }

    /// `MultiQueues` - a second device created with up to two queues from *every*
    /// queue family, for the tests that need to synchronise across queues.
    ///
    /// The default device only requests the universal, compute-only and transfer-only
    /// families with one queue each, and `vkGetDeviceQueue` on a family the device was
    /// not created with is undefined behaviour, so those tests cannot use it.
    ///
    /// Upstream keys its cache on the synchronization type, timeline-semaphore and
    /// maintenance8 flags because it only enables the extensions a case asks for. This
    /// device enables everything the physical device advertises, exactly as
    /// `Context::new` does, so one device covers every key.
    pub fn multi_queue_device(&self) -> Result<Rc<MultiQueueDevice>, TestError> {
        if let Some(existing) = self.multi_queue_device.borrow().as_ref() {
            return Ok(Rc::clone(existing));
        }
        let created = Rc::new(MultiQueueDevice::new(self.platform, self.physical_device)?);
        *self.multi_queue_device.borrow_mut() = Some(Rc::clone(&created));
        Ok(created)
    }

    /// `Context::getDeviceInterface` and `Context::getDevice` collapsed into one,
    /// since `vulkanalia::Device` is both.
    pub fn get_device(&self) -> &Device {
        &self.device
    }

    /// `Context::getInstanceInterface`
    /// The loader, instance and API version the whole run shares. A test that builds
    /// its own instance or device starts from here.
    pub fn get_platform(&self) -> &Platform {
        self.platform
    }

    pub fn get_instance(&self) -> &Instance {
        &self.platform.instance
    }

    /// `Context::getPhysicalDevice`
    pub fn get_physical_device(&self) -> vk::PhysicalDevice {
        self.physical_device
    }

    /// `Context::getUniversalQueue`
    pub fn get_universal_queue(&self) -> vk::Queue {
        self.universal_queue
    }

    /// `Context::getComputeQueue` with its family index, or `None` when the device has
    /// no compute-only family.
    pub fn get_compute_queue(&self) -> Option<(vk::Queue, u32)> {
        self.compute_queue
    }

    /// `Context::getTransferQueue` with its family index.
    pub fn get_transfer_queue(&self) -> Option<(vk::Queue, u32)> {
        self.transfer_queue
    }

    /// `Context::getUniversalQueueFamilyIndex`
    pub fn get_universal_queue_family_index(&self) -> u32 {
        self.universal_queue_family_index
    }

    /// `Context::getDefaultAllocator`
    pub fn get_default_allocator(&self) -> &SimpleAllocator {
        &self.default_allocator
    }

    /// `Context::getDeviceProperties`
    pub fn get_device_properties(&self) -> &vk::PhysicalDeviceProperties {
        &self.device_properties
    }

    /// `Context::getDeviceFeatures`
    pub fn get_device_features(&self) -> &vk::PhysicalDeviceFeatures {
        &self.device_features
    }

    /// `Context::isDeviceFunctionalitySupported` - the same question without the
    /// NotSupported, for the checks that accept any of several extensions.
    pub fn is_device_functionality_supported(&self, extension: &str) -> bool {
        self.require_device_functionality(extension).is_ok()
    }

    /// `Context::requireDeviceFunctionality`
    ///
    /// Upstream throws NotSupportedError here; returning it has the same effect, since
    /// the runner turns it into a NotSupported verdict rather than a failure. A device
    /// that lacks an extension is not a device that failed a test.
    pub fn require_device_functionality(&self, extension: &str) -> Result<(), TestError> {
        if self.device_extensions.iter().any(|e| e == extension) {
            return Ok(());
        }
        // An extension promoted into core need not be advertised any more, and upstream
        // treats that as supported. Without this a 1.2+ driver that dropped the string
        // would get NotSupported here and a real verdict from deqp-vk - a difference
        // that says nothing about the driver.
        if let Some(promoted_in) = promoted_to_core_version(extension)
            && self.device_properties.api_version >= promoted_in
        {
            return Ok(());
        }
        Err(TestError::NotSupported(format!("{extension} is not supported by this implementation")))
    }

    /// `Context::getDeviceExtensions`
    pub fn get_device_extensions(&self) -> &[String] {
        &self.device_extensions
    }

    /// `Context::getBinaryCollection`
    pub fn get_binary_collection(&self) -> BinaryCollection {
        self.binary_collection
    }

    /// Swaps in the shader collection belonging to the case that is about to run.
    /// Upstream rebuilds the whole Context per case; reusing the device across a batch
    /// is what makes batching worthwhile, so only the collection is swapped.
    pub fn set_binary_collection(&mut self, binary_collection: BinaryCollection) {
        self.binary_collection = binary_collection;
    }

    /// Human-readable device name, used in the run header and the result file.
    pub fn device_name(&self) -> String {
        let bytes = &self.device_properties.device_name;
        let end = bytes.iter().position(|&c| c == 0).unwrap_or(bytes.len());
        bytes[..end].iter().map(|&c| c as u8 as char).collect()
    }

    pub fn api_version(&self) -> (u32, u32, u32) {
        let v = self.device_properties.api_version;
        (vk::version_major(v), vk::version_minor(v), vk::version_patch(v))
    }
}

impl Drop for Context<'_> {
    fn drop(&mut self) {
        unsafe {
            // A device that is already lost cannot be waited on; ignore the result so
            // teardown after a device-lost test does not itself become an error.
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

/// The core version an extension was promoted into, for the extensions the ported
/// tests ask for. Kept as an explicit table rather than derived from vk.xml: the list
/// is short, and a wrong entry here silently turns a real verdict into NotSupported.
fn promoted_to_core_version(extension: &str) -> Option<u32> {
    Some(match extension {
        "VK_KHR_spirv_1_4" | "VK_KHR_shader_float16_int8" | "VK_KHR_8bit_storage" | "VK_KHR_16bit_storage" => vk::make_version(1, 2, 0),
        "VK_KHR_separate_depth_stencil_layouts" | "VK_KHR_create_renderpass2" => vk::make_version(1, 2, 0),
        "VK_KHR_zero_initialize_workgroup_memory" | "VK_KHR_shader_terminate_invocation" => vk::make_version(1, 3, 0),
        "VK_KHR_depth_stencil_resolve" => vk::make_version(1, 2, 0),
        "VK_KHR_dynamic_rendering" => vk::make_version(1, 3, 0),
        "VK_KHR_device_group" | "VK_KHR_storage_buffer_storage_class" | "VK_KHR_dedicated_allocation" => vk::make_version(1, 1, 0),
        "VK_KHR_copy_commands2" => vk::make_version(1, 3, 0),
        _ => return None,
    })
}

/// Picks the physical device the run targets. Mirrors `--deqp-vk-device-id`, which is
/// 1-based upstream.
pub fn select_physical_device(platform: &Platform, device_id: usize) -> Result<vk::PhysicalDevice, PlatformError> {
    let devices = platform.physical_devices()?;
    if devices.is_empty() {
        return Err(PlatformError::Unavailable("no Vulkan physical devices".to_string()));
    }
    devices
        .get(device_id.saturating_sub(1))
        .copied()
        .ok_or_else(|| PlatformError::InitError(format!("device id {device_id} out of range (found {})", devices.len())))
}

/// Creates a device with every extension the physical device advertises and the
/// feature structs the ported groups need, which is what upstream's `DefaultDevice`
/// does.
///
/// `checkSupport` queries the *physical device*, so without enabling the feature
/// structs a case whose extension is advertised would be let through and then run
/// against a device where the corresponding feature bit was never turned on - the
/// shader's capability is unenabled, and the verdict becomes meaningless. The chain is
/// queried and then handed straight back to `vkCreateDevice`.
///
/// Returns the device and the extension names it was created with.
fn create_device_with_everything(instance: &Instance, physical_device: vk::PhysicalDevice, queue_infos: &[vk::DeviceQueueCreateInfo]) -> Result<(Device, Vec<String>), TestError> {
    let available_extensions: Vec<String> = unsafe { instance.enumerate_device_extension_properties(physical_device, None) }
        .vk_check("vkEnumerateDeviceExtensionProperties")?
        .iter()
        .map(|e| unsafe { CStr::from_ptr(e.extension_name.as_ptr()) }.to_string_lossy().into_owned())
        .collect();

    // Enabling every available extension is the point here, but the presentation family
    // cannot be: `VK_KHR_swapchain` needs the `VK_KHR_surface` *instance* extension,
    // which a headless run has no reason to ask for, and a dozen more device extensions
    // in turn need swapchain. Enabling any of them without their dependency is invalid
    // (VUID-vkCreateDevice-ppEnabledExtensionNames-01387). Matched by substring rather
    // than by name so a new one does not silently reintroduce the problem - nothing in
    // the suite presents to a surface, so dropping the whole family costs no coverage.
    let presentation_only = |n: &str| n.contains("swapchain") || n.contains("present") || n.contains("display") || n == "VK_EXT_hdr_metadata";
    let extension_names: Vec<CString> = available_extensions
        .iter()
        .filter(|n| !presentation_only(n))
        .filter_map(|n| CString::new(n.as_str()).ok())
        .collect();
    let extension_ptrs: Vec<*const i8> = extension_names.iter().map(|n| n.as_ptr()).collect();

    // No `VkPhysicalDeviceShaderFloat16Int8Features` here: the same chain is used for
    // the query and for vkCreateDevice, and creating with both it and
    // `VkPhysicalDeviceVulkan12Features` is invalid because the two could disagree
    // (VUID-VkDeviceCreateInfo-pNext-02830). The 1.2 struct already carries
    // shaderFloat16/shaderInt8, and nothing here reads the older one.
    let mut vulkan_11_features = vk::PhysicalDeviceVulkan11Features::default();
    let mut vulkan_12_features = vk::PhysicalDeviceVulkan12Features::default();
    let mut zero_init_features = vk::PhysicalDeviceZeroInitializeWorkgroupMemoryFeatures::default();
    let mut wmel_features = vk::PhysicalDeviceWorkgroupMemoryExplicitLayoutFeaturesKHR::default();
    // An extension being enabled does not enable the features it introduces: those have
    // to be asked for by name here. Leaving one out means a test can create the objects
    // its extension defines and then be told, correctly, that the feature is off - which
    // a permissive driver may let pass and a strict one will not.
    let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
    let mut pgq_features = vk::PhysicalDevicePrimitivesGeneratedQueryFeaturesEXT::default();
    let mut color_write_features = vk::PhysicalDeviceColorWriteEnableFeaturesEXT::default();
    // The individual struct rather than `VkPhysicalDeviceVulkan13Features`: chaining
    // both is invalid (VUID-VkDeviceCreateInfo-pNext-06532), and nothing here needs the
    // rest of 1.3. Without it `vkCmdBeginRendering` is used with the feature off.
    let mut dynamic_rendering_features = vk::PhysicalDeviceDynamicRenderingFeatures::default();

    let mut features2 = vk::PhysicalDeviceFeatures2::builder()
        .push_next(&mut vulkan_11_features)
        .push_next(&mut vulkan_12_features)
        .push_next(&mut zero_init_features)
        .push_next(&mut wmel_features)
        .push_next(&mut xfb_features)
        .push_next(&mut pgq_features)
        .push_next(&mut color_write_features)
        .push_next(&mut dynamic_rendering_features);

    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

    // `enabled_features` must stay unset: the core features travel inside the features2
    // chain instead, and Vulkan forbids providing both.
    let info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(queue_infos)
        .enabled_extension_names(&extension_ptrs)
        .push_next(&mut features2);

    let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;
    Ok((device, available_extensions))
}

/// `MultiQueues::QueueData` plus the family index it belongs to.
pub struct QueueFamilyQueues {
    pub family_index: u32,
    pub flags: vk::QueueFlags,
    pub queues: Vec<vk::Queue>,
}

/// `MultiQueues`' logical device: every queue family, up to two queues from each.
pub struct MultiQueueDevice {
    device: Device,
    allocator: SimpleAllocator,
    families: Vec<QueueFamilyQueues>,
}

impl MultiQueueDevice {
    fn new(platform: &Platform, physical_device: vk::PhysicalDevice) -> Result<Self, TestError> {
        let instance = &platform.instance;
        let queue_families = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };

        // `std::min(2u, queueCount)` per family, so a family with two queues can be
        // paired with itself.
        let counts: Vec<u32> = queue_families.iter().map(|f| f.queue_count.min(2)).collect();
        let priorities = [1.0f32, 1.0f32];
        let queue_infos: Vec<vk::DeviceQueueCreateInfo> = counts
            .iter()
            .enumerate()
            .map(|(family, &count)| {
                vk::DeviceQueueCreateInfo::builder()
                    .queue_family_index(family as u32)
                    .queue_priorities(&priorities[..count as usize])
                    .build()
            })
            .collect();

        let (device, _extensions) = create_device_with_everything(instance, physical_device, &queue_infos)?;

        let families = counts
            .iter()
            .enumerate()
            .map(|(family, &count)| QueueFamilyQueues {
                family_index: family as u32,
                flags: queue_families[family].queue_flags,
                queues: (0..count).map(|i| unsafe { device.get_device_queue(family as u32, i) }).collect(),
            })
            .collect();

        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };

        Ok(Self {
            device,
            allocator: SimpleAllocator::new(memory_properties),
            families,
        })
    }

    pub fn device(&self) -> &Device {
        &self.device
    }

    pub fn allocator(&self) -> &SimpleAllocator {
        &self.allocator
    }

    /// `MultiQueues::familyCount` and the per-family data behind it.
    pub fn families(&self) -> &[QueueFamilyQueues] {
        &self.families
    }
}

impl Drop for MultiQueueDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}
