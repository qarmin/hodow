// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectBinaryTests.cpp (`ShaderObjectDeviceFeaturesBinaryInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A shader object's binary must not depend on which device features are enabled: the case
// creates a shader on the default device, then a device for every subset of the feature structures (and core features) its index selects and
// the same shader on it, and the binaries must be equal. Upstream walks the generated `vkDeviceFeaturesForShaderObject.inl`; this walks the
// extension-only structures of `api::feature_struct_list` as raw bytes (the structures promoted to core are covered by the core feature
// flags chained for every device, as the default device does), each queried from the physical device and chained as queried.

use std::ffi::{CString, c_char, c_void};

use vulkanalia::Device;
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::binary_tests::{DeviceGuard, check_stage_features, create_test_shader};
use super::util::get_shader_binary_data;
use crate::generated::shaders::shader_object_create::SHADER_OBJECT_BASIC;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::api::feature_struct_list::{FEATURE_STRUCTS, FeatureStruct};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const CORE_FEATURES_COUNT: usize = 50;
// There are too many features to test every combination, so they are grouped.
const STEP1: usize = 10;
const STEP2: usize = 30;

/// A feature structure of the physical device as queried: raw bytes, 8 byte aligned.
struct QueriedStruct {
    spec: &'static FeatureStruct,
    words: Vec<u64>,
}

impl QueriedStruct {
    fn next_ptr(&mut self) -> *mut *mut c_void {
        unsafe { self.words.as_mut_ptr().cast::<u8>().add(8).cast::<*mut c_void>() }
    }
}

fn is_presentation_only(name: &str) -> bool {
    name.contains("swapchain") || name.contains("present") || name.contains("display") || name == "VK_EXT_hdr_metadata"
}

/// Every extension-only feature structure the physical device exposes, queried one at a time.
fn query_feature_structs(context: &Context<'_>) -> Vec<QueriedStruct> {
    let extensions = context.get_device_extensions();
    let mut queried = Vec::new();
    for spec in FEATURE_STRUCTS {
        if spec.api_version.is_some()
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
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        queried.push(QueriedStruct { spec, words });
    }
    queried
}

/// `ShaderObjectDeviceFeaturesBinaryInstance::iterate`
fn run_device_features(context: &Context<'_>, stage: vk::ShaderStageFlags, linked: bool, index: u32) -> TestOutcome {
    let device = context.get_device();
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let binaries = context.get_binary_collection();
    let features = *context.get_device_features();

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let layout = if stage == vk::ShaderStageFlags::COMPUTE {
        Some(*descriptor_set_layout)
    } else {
        None
    };
    let shader = create_test_shader(device, &binaries, &features, layout, linked, stage)?;
    let data = get_shader_binary_data(device, shader.get())?;

    let queried_core = unsafe { instance.get_physical_device_features(physical_device) };
    let mut structs = query_feature_structs(context);

    // These features depend on other features being enabled
    for queried in &mut structs {
        if queried.spec.struct_name == "VkPhysicalDeviceMeshShaderFeaturesEXT" {
            for (field_index, field) in queried.spec.fields.iter().enumerate() {
                if *field == "multiviewMeshShader" || *field == "primitiveFragmentShadingRateMeshShader" {
                    unsafe {
                        std::ptr::write_unaligned(
                            queried
                                .words
                                .as_mut_ptr()
                                .cast::<u8>()
                                .add(16 + 4 * field_index)
                                .cast::<u32>(),
                            0,
                        )
                    };
                }
            }
        }
    }

    let extension_names: Vec<CString> = context
        .get_device_extensions()
        .iter()
        .filter(|name| !is_presentation_only(name))
        .filter_map(|name| CString::new(name.as_str()).ok())
        .collect();
    let extension_ptrs: Vec<*const c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();

    let p_next_features_count = structs.len();
    let count2 = 1usize << (p_next_features_count / STEP2);

    for i in 0..count2 {
        // Reset features
        let mut test_features = queried_core;
        {
            let core = (&raw mut test_features).cast::<vk::Bool32>();
            for j in 0..CORE_FEATURES_COUNT {
                if (index as usize >> (j / STEP1)) & 1 == 0 {
                    unsafe { core.add(j).write(vk::FALSE) };
                }
            }
        }
        // Geometry and tessellation features must not be modified
        test_features.tessellation_shader = features.tessellation_shader;
        test_features.geometry_shader = features.geometry_shader;

        let mut p_next: *mut c_void = std::ptr::null_mut();
        for (j, queried) in structs.iter_mut().enumerate() {
            if (i >> (j / STEP2)) & 1 == 1 {
                unsafe { *queried.next_ptr() = p_next };
                p_next = queried.words.as_mut_ptr().cast::<c_void>();
            }
        }

        let mut shader_object_features = vk::PhysicalDeviceShaderObjectFeaturesEXT {
            shader_object: vk::TRUE,
            next: p_next,
            ..Default::default()
        };
        let mut features2 = vk::PhysicalDeviceFeatures2 {
            features: test_features,
            next: (&raw mut shader_object_features).cast::<c_void>(),
            ..Default::default()
        };

        let queue_priority = [1.0f32];
        let queue_infos = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(queue_family_index)
            .queue_priorities(&queue_priority)
            .build()];
        let device_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&extension_ptrs)
            .push_next(&mut features2);
        let other_device = DeviceGuard(
            unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?,
        );
        let other_device: &Device = &other_device.0;

        let other_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(other_device)?;
        let other_layout = if stage == vk::ShaderStageFlags::COMPUTE {
            Some(*other_descriptor_set_layout)
        } else {
            None
        };
        let other_shader = create_test_shader(other_device, &binaries, &features, other_layout, linked, stage)?;
        let other_data = get_shader_binary_data(other_device, other_shader.get())?;

        if data.len() != other_data.len() {
            return Ok(TestStatus::fail("Size not matching"));
        }
        if data != other_data {
            return Ok(TestStatus::fail("Data not matching"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `ShaderObjectDeviceFeaturesBinaryCase`
struct ShaderObjectDeviceFeaturesBinaryCase {
    name: String,
    linked: bool,
    stage: vk::ShaderStageFlags,
    index: u32,
}

impl TestCase for ShaderObjectDeviceFeaturesBinaryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_stage_features(context, self.stage)
    }

    fn programs(&self) -> BinaryCollection {
        SHADER_OBJECT_BASIC.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectDeviceFeaturesBinaryInstance {
            context,
            linked: self.linked,
            stage: self.stage,
            index: self.index,
        })
    }
}

struct ShaderObjectDeviceFeaturesBinaryInstance<'a> {
    context: &'a Context<'a>,
    linked: bool,
    stage: vk::ShaderStageFlags,
    index: u32,
}

impl TestInstance for ShaderObjectDeviceFeaturesBinaryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_device_features(self.context, self.stage, self.linked, self.index)
    }
}

/// The `device_features` group of `createShaderObjectBinaryTests`.
pub fn create_device_features_tests() -> TestCaseGroup {
    let stage_tests = [
        (vk::ShaderStageFlags::VERTEX, "vert"),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"),
        (vk::ShaderStageFlags::GEOMETRY, "geom"),
        (vk::ShaderStageFlags::FRAGMENT, "frag"),
        (vk::ShaderStageFlags::COMPUTE, "comp"),
    ];

    let mut device_features_group = TestCaseGroup::new("device_features");
    for (stage, stage_name) in stage_tests {
        let mut stage_group = TestCaseGroup::new(stage_name);
        for linked in [false, true] {
            if linked && stage == vk::ShaderStageFlags::COMPUTE {
                continue;
            }

            let mut linked_group = TestCaseGroup::new(if linked { "linked" } else { "unlinked" });
            for i in 0..32u32 {
                linked_group.add_child(Box::new(ShaderObjectDeviceFeaturesBinaryCase {
                    name: i.to_string(),
                    linked,
                    stage,
                    index: i,
                }) as Box<dyn TestCase>);
            }
            stage_group.add_child(linked_group);
        }
        device_features_group.add_child(stage_group);
    }
    device_features_group
}
