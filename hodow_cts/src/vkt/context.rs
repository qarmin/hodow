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

use std::ffi::{CStr, CString};

use vulkanalia::prelude::v1_0::*;

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
    default_allocator: SimpleAllocator,
    device_properties: vk::PhysicalDeviceProperties,
    device_features: vk::PhysicalDeviceFeatures,
    device_extensions: Vec<String>,
    binary_collection: BinaryCollection,
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

        let priorities = [1.0f32];
        let queue_info = vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(universal_queue_family_index)
            .queue_priorities(&priorities);

        let device_features = unsafe { instance.get_physical_device_features(physical_device) };

        // Enable every extension the physical device advertises, which is what
        // upstream's DefaultDevice does. Tests declare what they need through
        // `require_device_functionality`; enabling the union here means a test does not
        // have to also arrange for its extension to be turned on, and it keeps one
        // device for the whole batch instead of one per extension set.
        let available_extensions: Vec<String> = unsafe { instance.enumerate_device_extension_properties(physical_device, None) }
            .vk_check("vkEnumerateDeviceExtensionProperties")?
            .iter()
            .map(|e| unsafe { CStr::from_ptr(e.extension_name.as_ptr()) }.to_string_lossy().into_owned())
            .collect();

        let extension_names: Vec<CString> = available_extensions.iter().filter_map(|n| CString::new(n.as_str()).ok()).collect();
        let extension_ptrs: Vec<*const i8> = extension_names.iter().map(|n| n.as_ptr()).collect();

        let queue_infos = [queue_info];
        let info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&extension_ptrs)
            .enabled_features(&device_features);

        let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;

        let universal_queue = unsafe { device.get_device_queue(universal_queue_family_index, 0) };
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        let device_properties = unsafe { instance.get_physical_device_properties(physical_device) };

        Ok(Self {
            platform,
            physical_device,
            device,
            universal_queue,
            universal_queue_family_index,
            default_allocator: SimpleAllocator::new(memory_properties),
            device_properties,
            device_features,
            device_extensions: available_extensions,
            binary_collection,
        })
    }

    /// `Context::getDeviceInterface` and `Context::getDevice` collapsed into one,
    /// since `vulkanalia::Device` is both.
    pub fn get_device(&self) -> &Device {
        &self.device
    }

    /// `Context::getInstanceInterface`
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

    /// `Context::requireDeviceFunctionality`
    ///
    /// Upstream throws NotSupportedError here; returning it has the same effect, since
    /// the runner turns it into a NotSupported verdict rather than a failure. A device
    /// that lacks an extension is not a device that failed a test.
    pub fn require_device_functionality(&self, extension: &str) -> Result<(), TestError> {
        if self.device_extensions.iter().any(|e| e == extension) {
            Ok(())
        } else {
            Err(TestError::NotSupported(format!("{extension} is not supported by this implementation")))
        }
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
