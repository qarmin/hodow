// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawAhbTests.cpp
//   external/vulkancts/modules/vulkan/draw/vktDrawAhbExternalFormatResolveTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Both groups draw into Android hardware buffers, which exist only on Android, so
// the case trees are registered with upstream's support checks and the bodies are not ported: `ahb_external_format_resolve` ends in
// NotSupported ("Android Hardware Buffer not present", as upstream's `AndroidHardwareBufferExternalApi::getInstance()` check) on every
// Linux or Windows device, `ahb` in NotSupported without VK_ANDROID_external_memory_android_hardware_buffer.

use super::base_class::GroupParams;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The formats upstream registers: color or raw, not implementation defined. `RAW_OPAQUE` has no valid `tcu::TextureFormat`.
const FORMATS: [&str; 23] = [
    "AHARDWAREBUFFER_FORMAT_B8G8R8A8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R10G10B10A10_UNORM",
    "AHARDWAREBUFFER_FORMAT_R10G10B10A2_UNORM",
    "AHARDWAREBUFFER_FORMAT_R16G16B16A16_FLOAT",
    "AHARDWAREBUFFER_FORMAT_R16G16_UINT",
    "AHARDWAREBUFFER_FORMAT_R16_UINT",
    "AHARDWAREBUFFER_FORMAT_R5G6B5_UNORM",
    "AHARDWAREBUFFER_FORMAT_R8G8B8A8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R8G8B8X8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R8G8B8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R8_UNORM",
    "AHARDWAREBUFFER_FORMAT_RAW10",
    "AHARDWAREBUFFER_FORMAT_RAW12",
    "AHARDWAREBUFFER_FORMAT_RAW16",
    "AHARDWAREBUFFER_FORMAT_RAW_OPAQUE",
    "AHARDWAREBUFFER_FORMAT_Y16",
    "AHARDWAREBUFFER_FORMAT_Y8",
    "AHARDWAREBUFFER_FORMAT_Y8Cb8Cr8_420",
    "AHARDWAREBUFFER_FORMAT_YCbCr_422_I",
    "AHARDWAREBUFFER_FORMAT_YCbCr_422_SP",
    "AHARDWAREBUFFER_FORMAT_YCbCr_P010",
    "AHARDWAREBUFFER_FORMAT_YCrCb_420_SP",
    "AHARDWAREBUFFER_FORMAT_YV12",
];
const RAW_OPAQUE: &str = "AHARDWAREBUFFER_FORMAT_RAW_OPAQUE";
const PARTIAL_RENDER_AREAS: usize = 10;

#[derive(Clone, Copy)]
enum Kind {
    ExternalFormatResolve,
    Draw,
}

struct AhbCase {
    name: String,
    kind: Kind,
}

impl TestCase for AhbCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            Kind::ExternalFormatResolve => {
                context.require_device_functionality("VK_ANDROID_external_format_resolve")?;
                Err(TestError::NotSupported(
                    "Android Hardware Buffer not present".to_string(),
                ))
            }
            Kind::Draw => {
                context.require_device_functionality("VK_ANDROID_external_memory_android_hardware_buffer")?;
                Err(TestError::NotPorted(
                    "drawing into an Android hardware buffer".to_string(),
                ))
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NotPortedInstance)
    }
}

struct NotPortedInstance;

impl TestInstance for NotPortedInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(
            "drawing into an Android hardware buffer".to_string(),
        ))
    }
}

fn case(name: impl Into<String>, kind: Kind) -> Box<dyn TestCase> {
    Box::new(AhbCase {
        name: name.into(),
        kind,
    })
}

fn render_area_group(format: &str, kind: Kind) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(format);
    group.add_child(case("full_render_area", kind));
    for index in 0..PARTIAL_RENDER_AREAS {
        group.add_child(case(format!("partial_render_area_{index}"), kind));
    }
    group
}

/// `createAhbExternalFormatResolveTests`
pub fn create_ahb_external_format_resolve_tests(group_params: GroupParams) -> TestCaseGroup {
    let kind = Kind::ExternalFormatResolve;
    let mut clear_group = TestCaseGroup::new("clear");
    let mut draw_group = TestCaseGroup::new("draw");
    let mut input_attachment = TestCaseGroup::new("input_attachment");

    for format in FORMATS {
        let has_valid_texture_format = format != RAW_OPAQUE;
        if has_valid_texture_format {
            draw_group.add_child(render_area_group(format, kind));
        }
        if !group_params.use_dynamic_rendering {
            input_attachment.add_child(render_area_group(format, kind));
        }
        let clear_in_this_group = !group_params.use_secondary_cmd_buffer
            || group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass;
        if clear_in_this_group && has_valid_texture_format {
            clear_group.add_child(case(format, kind));
        }
    }

    let mut group = TestCaseGroup::new("ahb_external_format_resolve");
    group.add_child(clear_group);
    group.add_child(draw_group);
    group.add_child(input_attachment);
    group
}

/// `createAhbTests`
pub fn create_ahb_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ahb");
    for name in [
        "triangle_list",
        "triangle_list_layers_3",
        "triangle_list_layers_5",
        "triangle_list_layers_8",
    ] {
        group.add_child(case(name, Kind::Draw));
    }
    group
}
