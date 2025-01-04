// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectRenderingTests.cpp (`chooseDevice`)
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectBindingTests.cpp (`createDevice`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A second device next to the context's one, with the shader object and dynamic rendering features, every
// extension-only feature structure of its extensions chained as queried, and the core features of the context's device after a caller's edit. Upstream rebuilds
// the chain structure by structure from the context's feature getters; the queried chain is the same set for the extensions the context enables.

use std::ffi::{CString, c_char, c_void};

use vulkanalia::Device;
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::binary_tests::DeviceGuard;
use super::util::remove_unsupported_shader_object_extensions;
use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::SimpleAllocator;
use crate::vkt::Context;
use crate::vkt::tests::api::feature_struct_list::{FEATURE_STRUCTS, FeatureStruct};

struct QueriedStruct {
    spec: &'static FeatureStruct,
    words: Vec<u64>,
}

/// A device of its own with its queue and allocator; destroyed when dropped.
pub struct SecondDevice {
    guard: DeviceGuard,
    queue: vk::Queue,
    allocator: SimpleAllocator,
    extensions: Vec<String>,
}

fn is_presentation_only(name: &str) -> bool {
    name.contains("swapchain") || name.contains("present") || name.contains("display") || name == "VK_EXT_hdr_metadata"
}

impl SecondDevice {
    /// `excluded_extensions` are left out of the device, and so are the feature structures only they enable; `edit_features` changes the core features.
    #[expect(
        clippy::suspicious_map,
        reason = "counts the queried structures as upstream does to touch every one"
    )]
    pub fn new(
        context: &Context<'_>,
        excluded_extensions: &[&str],
        edit_features: impl FnOnce(&mut vk::PhysicalDeviceFeatures),
    ) -> Result<Self, TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let queue_family_index = context.get_universal_queue_family_index();

        let mut extensions = remove_unsupported_shader_object_extensions(context)?;
        extensions.retain(|name| !is_presentation_only(name) && !excluded_extensions.contains(&name.as_str()));

        let mut structs: Vec<QueriedStruct> = Vec::new();
        for spec in FEATURE_STRUCTS {
            if spec.api_version.is_some()
                || spec.struct_name == "VkPhysicalDeviceShaderObjectFeaturesEXT"
                || !spec
                    .extensions
                    .iter()
                    .any(|wanted| extensions.iter().any(|have| have == wanted))
            {
                continue;
            }
            let mut words = vec![0u64; spec.size.div_ceil(8)];
            unsafe { std::ptr::write_unaligned(words.as_mut_ptr().cast::<u8>().cast::<i32>(), spec.s_type) };
            let mut features2 = vk::PhysicalDeviceFeatures2 {
                next: words.as_mut_ptr().cast::<c_void>(),
                ..Default::default()
            };
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            structs.push(QueriedStruct { spec, words });
        }
        let _ = structs.iter().map(|queried| queried.spec.name).count();

        let mut head: *mut c_void = std::ptr::null_mut();
        for queried in &mut structs {
            unsafe { *queried.words.as_mut_ptr().cast::<u8>().add(8).cast::<*mut c_void>() = head };
            head = queried.words.as_mut_ptr().cast::<c_void>();
        }

        let mut shader_object_features = vk::PhysicalDeviceShaderObjectFeaturesEXT {
            shader_object: vk::TRUE,
            next: head,
            ..Default::default()
        };
        let mut dynamic_rendering_features = vk::PhysicalDeviceDynamicRenderingFeatures {
            dynamic_rendering: vk::TRUE,
            next: (&raw mut shader_object_features).cast::<c_void>(),
            ..Default::default()
        };
        let mut core = *context.get_device_features();
        edit_features(&mut core);
        let mut features2 = vk::PhysicalDeviceFeatures2 {
            features: core,
            next: (&raw mut dynamic_rendering_features).cast::<c_void>(),
            ..Default::default()
        };

        let names: Vec<CString> = extensions
            .iter()
            .filter_map(|name| CString::new(name.as_str()).ok())
            .collect();
        let name_pointers: Vec<*const c_char> = names.iter().map(|name| name.as_ptr()).collect();
        let queue_priority = [1.0f32];
        let queue_infos = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(queue_family_index)
            .queue_priorities(&queue_priority)
            .build()];
        let device_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&name_pointers)
            .push_next(&mut features2);
        let device =
            unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?;
        let queue = unsafe { device.get_device_queue(queue_family_index, 0) };
        let allocator =
            SimpleAllocator::new(unsafe { instance.get_physical_device_memory_properties(physical_device) });
        Ok(Self {
            guard: DeviceGuard(device),
            queue,
            allocator,
            extensions,
        })
    }

    pub fn device(&self) -> &Device {
        &self.guard.0
    }

    pub fn queue(&self) -> vk::Queue {
        self.queue
    }

    pub fn allocator(&self) -> &SimpleAllocator {
        &self.allocator
    }

    /// The extensions the device was created with.
    pub fn extensions(&self) -> &[String] {
        &self.extensions
    }
}
