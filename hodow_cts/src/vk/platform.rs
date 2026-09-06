// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkPlatform.hpp / .cpp
//   external/vulkancts/framework/vulkan/vkDeviceUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CStr;

use vulkanalia::loader::{LIBRARY, LibloadingLoader};
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{EntryV1_1, ExtDebugUtilsExtensionInstanceCommands};

/// The minimum instance API version hodow_cts needs at all.
pub const MINIMUM_API_VERSION: u32 = vk::make_version(1, 1, 0);

/// The highest version these bindings know about. Asking for more than the loader
/// supports fails instance creation, and asking for less means the loader never
/// resolves the newer core entry points - `vkCmdBeginRendering` and friends then come
/// back null and vulkanalia installs a stub that aborts the process when called.
pub const MAXIMUM_API_VERSION: u32 = vk::make_version(1, 4, 0);

const VALIDATION_LAYER: &[u8] = b"VK_LAYER_KHRONOS_validation\0";

#[derive(Debug)]
pub enum PlatformError {
    /// No Vulkan loader on the system, or no ICD behind it. This is a clean "cannot
    /// run here" state, deliberately distinct from a driver that is present and
    /// broken - reporting it as a failure would be a false accusation.
    Unavailable(String),
    /// The loader and an ICD exist, but something failed while bringing Vulkan up.
    InitError(String),
}

impl std::fmt::Display for PlatformError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Unavailable(m) => write!(f, "Vulkan unavailable: {m}"),
            Self::InitError(m) => write!(f, "Vulkan init error: {m}"),
        }
    }
}

impl std::error::Error for PlatformError {}

/// `vk::PlatformInterface` plus the instance - the objects that outlive every test in
/// a batch.
pub struct Platform {
    pub entry: Entry,
    pub instance: Instance,
    /// `Context::getUsedApiVersion` - what the instance was created at, which is the
    /// loader's version clamped to what these bindings know.
    pub api_version: u32,
    debug_messenger: Option<vk::DebugUtilsMessengerEXT>,
}

impl Platform {
    /// Brings up the loader and creates the instance.
    ///
    /// `validation` turns on VK_LAYER_KHRONOS_validation and VK_EXT_debug_utils. It is
    /// off by default because the layer changes driver behaviour, so a run with it on
    /// is not a conformance run - it is a tool for finding misuse in this port.
    pub fn new(validation: bool) -> Result<Self, PlatformError> {
        let loader = unsafe { LibloadingLoader::new(LIBRARY) }.map_err(|e| PlatformError::Unavailable(format!("could not load {LIBRARY}: {e}")))?;
        let entry = unsafe { Entry::new(loader) }.map_err(|e| PlatformError::Unavailable(format!("no Vulkan entry point: {e}")))?;

        // Upstream calls vkEnumerateInstanceVersion and runs at the highest version
        // available (vktTestCase.cpp getMaximumFrameworkVulkanVersion); hardcoding 1.1
        // here meant a 1.3 driver never exposed its 1.3 core commands.
        let loader_version = unsafe { entry.enumerate_instance_version() }.unwrap_or(MINIMUM_API_VERSION);
        let api_version = loader_version.clamp(MINIMUM_API_VERSION, MAXIMUM_API_VERSION);

        let app_info = vk::ApplicationInfo::builder()
            .application_name(b"hodow_cts\0")
            .application_version(vk::make_version(0, 1, 0))
            .engine_name(b"hodow_cts\0")
            .engine_version(vk::make_version(0, 1, 0))
            .api_version(api_version);

        let mut layers: Vec<*const i8> = Vec::new();
        let mut extensions: Vec<*const i8> = Vec::new();

        if validation {
            let available: Vec<_> =
                unsafe { entry.enumerate_instance_layer_properties() }.map_err(|e| PlatformError::InitError(format!("vkEnumerateInstanceLayerProperties: {e}")))?;
            let wanted = CStr::from_bytes_with_nul(VALIDATION_LAYER).unwrap();
            let has_layer = available.iter().any(|l| unsafe { CStr::from_ptr(l.layer_name.as_ptr()) } == wanted);
            if !has_layer {
                return Err(PlatformError::InitError(
                    "--validation requested but VK_LAYER_KHRONOS_validation is not installed".to_string(),
                ));
            }
            layers.push(VALIDATION_LAYER.as_ptr().cast());
            extensions.push(vk::EXT_DEBUG_UTILS_EXTENSION.name.as_ptr());
        }

        let info = vk::InstanceCreateInfo::builder()
            .application_info(&app_info)
            .enabled_layer_names(&layers)
            .enabled_extension_names(&extensions);

        let instance = unsafe { entry.create_instance(&info, None) }.map_err(|e| {
            if e == vk::ErrorCode::INCOMPATIBLE_DRIVER {
                PlatformError::Unavailable("no Vulkan driver (ICD) found - see the \"Running without a GPU\" section of the README".to_string())
            } else {
                PlatformError::InitError(format!("vkCreateInstance: {e}"))
            }
        })?;

        let debug_messenger = if validation { Some(create_debug_messenger(&instance)?) } else { None };

        Ok(Self {
            entry,
            instance,
            api_version,
            debug_messenger,
        })
    }

    /// `vk::enumeratePhysicalDevices`
    pub fn physical_devices(&self) -> Result<Vec<vk::PhysicalDevice>, PlatformError> {
        unsafe { self.instance.enumerate_physical_devices() }.map_err(|e| PlatformError::InitError(format!("vkEnumeratePhysicalDevices: {e}")))
    }
}

impl Drop for Platform {
    fn drop(&mut self) {
        unsafe {
            if let Some(m) = self.debug_messenger {
                self.instance.destroy_debug_utils_messenger_ext(m, None);
            }
            self.instance.destroy_instance(None);
        }
    }
}

/// Counts every validation message so a test can be failed when any were produced.
/// A message means this port misused the API; without it, that misuse shows up as a
/// driver-shaped failure.
pub static VALIDATION_MESSAGES: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);

extern "system" fn debug_callback(
    severity: vk::DebugUtilsMessageSeverityFlagsEXT,
    message_type: vk::DebugUtilsMessageTypeFlagsEXT,
    data: *const vk::DebugUtilsMessengerCallbackDataEXT,
    _user: *mut std::ffi::c_void,
) -> vk::Bool32 {
    let data = unsafe { &*data };
    let message = unsafe { CStr::from_ptr(data.message) }.to_string_lossy();

    // A performance warning is advice, not a spec violation - "vertex attribute not
    // consumed by vertex shader" is one the quadrant shaders legitimately produce, and
    // counting those as failures buries the messages that mean something. Still logged,
    // just not fatal.
    let performance_only = message_type.contains(vk::DebugUtilsMessageTypeFlagsEXT::PERFORMANCE)
        && !message_type.contains(vk::DebugUtilsMessageTypeFlagsEXT::VALIDATION);

    if !performance_only
        && (severity.contains(vk::DebugUtilsMessageSeverityFlagsEXT::ERROR) || severity.contains(vk::DebugUtilsMessageSeverityFlagsEXT::WARNING))
    {
        VALIDATION_MESSAGES.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        log::error!("validation: {message}");
    } else {
        log::debug!("validation: {message}");
    }

    vk::FALSE
}

fn create_debug_messenger(instance: &Instance) -> Result<vk::DebugUtilsMessengerEXT, PlatformError> {
    let info = vk::DebugUtilsMessengerCreateInfoEXT::builder()
        .message_severity(vk::DebugUtilsMessageSeverityFlagsEXT::ERROR | vk::DebugUtilsMessageSeverityFlagsEXT::WARNING | vk::DebugUtilsMessageSeverityFlagsEXT::INFO)
        .message_type(vk::DebugUtilsMessageTypeFlagsEXT::GENERAL | vk::DebugUtilsMessageTypeFlagsEXT::VALIDATION | vk::DebugUtilsMessageTypeFlagsEXT::PERFORMANCE)
        .user_callback(Some(debug_callback));

    unsafe { instance.create_debug_utils_messenger_ext(&info, None) }.map_err(|e| PlatformError::InitError(format!("vkCreateDebugUtilsMessengerEXT: {e}")))
}
