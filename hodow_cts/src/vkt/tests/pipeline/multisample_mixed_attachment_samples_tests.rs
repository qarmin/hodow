// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleMixedAttachmentSamplesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree and the two `checkRequirements` are ported (the NV framebuffer mixed
// samples combination query and the fragment shading rate lookup are not: a device with only VK_NV_framebuffer_mixed_samples ends in
// NotPorted at checkSupport). The test bodies (the per-sample verification with a compute shader and the shader built-ins check) are
// not, so a device with VK_AMD_mixed_attachment_samples ends in NotPorted; every other device ends in NotSupported, as upstream does.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::pipeline::image_util::format_case_name;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `SampleCase`: color and depth/stencil sample counts (and the coverage count, their maximum).
#[derive(Clone, Copy)]
struct SampleCounts {
    color: u32,
    depth_stencil: u32,
}

impl SampleCounts {
    fn coverage(self) -> u32 {
        self.color.max(self.depth_stencil)
    }
}

fn sample_flags(count: u32) -> vk::SampleCountFlags {
    vk::SampleCountFlags::from_bits_truncate(count)
}

struct MixedAttachmentSamplesCase {
    name: String,
    per_subpass: Vec<SampleCounts>,
    use_programmable_sample_locations: bool,
    shader_builtins: bool,
    use_fragment_shading_rate: bool,
}

impl TestCase for MixedAttachmentSamplesCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `VerifySamples::checkRequirements` and `ShaderBuiltins::checkRequirements`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let amd_mixed_samples = context.is_device_functionality_supported("VK_AMD_mixed_attachment_samples");
        let nv_mixed_samples = context.is_device_functionality_supported("VK_NV_framebuffer_mixed_samples")
            && context.is_device_functionality_supported("VK_NV_coverage_reduction_mode");

        if !amd_mixed_samples && !nv_mixed_samples {
            return Err(TestError::NotSupported(
                "VK_AMD_mixed_attachment_samples and VK_NV_framebuffer_mixed_samples with VK_NV_coverage_reduction_mode are not supported"
                    .to_string(),
            ));
        }

        if !self.shader_builtins && self.use_programmable_sample_locations {
            context.require_device_functionality("VK_EXT_sample_locations")?;
        }

        let limits = &context.get_device_properties().limits;
        for samples in &self.per_subpass {
            let color = sample_flags(samples.color);
            let depth_stencil = sample_flags(samples.depth_stencil);

            if !limits.framebuffer_color_sample_counts.intersects(color) {
                return Err(TestError::NotSupported(
                    "framebufferColorSampleCounts: sample count not supported".to_string(),
                ));
            }
            if !limits.framebuffer_depth_sample_counts.intersects(depth_stencil) {
                return Err(TestError::NotSupported(
                    "framebufferDepthSampleCounts: sample count not supported".to_string(),
                ));
            }
            if !limits.framebuffer_stencil_sample_counts.intersects(depth_stencil) {
                return Err(TestError::NotSupported(
                    "framebufferStencilSampleCounts: sample count not supported".to_string(),
                ));
            }
            if !limits.sampled_image_color_sample_counts.intersects(color) {
                return Err(TestError::NotSupported(
                    "sampledImageColorSampleCounts: sample count not supported".to_string(),
                ));
            }
            if !limits.sampled_image_depth_sample_counts.intersects(depth_stencil) {
                return Err(TestError::NotSupported(
                    "sampledImageDepthSampleCounts: sample count not supported".to_string(),
                ));
            }
            if !limits.sampled_image_stencil_sample_counts.intersects(depth_stencil) {
                return Err(TestError::NotSupported(
                    "sampledImageStencilSampleCounts: sample count not supported".to_string(),
                ));
            }

            // This is required to output geometry that is covering a specific sample.
            let require_standard_sample_locations = !self.shader_builtins && !self.use_programmable_sample_locations;
            if require_standard_sample_locations && limits.standard_sample_locations == vk::FALSE {
                return Err(TestError::NotSupported(
                    "standardSampleLocations: not supported".to_string(),
                ));
            }
        }

        if !amd_mixed_samples {
            return Err(TestError::NotPorted(
                "the VK_NV_framebuffer_mixed_samples combination query".to_string(),
            ));
        }

        if self.use_fragment_shading_rate {
            context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
        }

        if self.shader_builtins
            && self.per_subpass[0].color != 1
            && context.get_device_features().sample_rate_shading == vk::FALSE
        {
            return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MixedAttachmentSamplesInstance)
    }
}

struct MixedAttachmentSamplesInstance;

impl TestInstance for MixedAttachmentSamplesInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(
            "VK_AMD_mixed_attachment_samples verification".to_string(),
        ))
    }
}

fn sample_count_group_name(samples: SampleCounts) -> String {
    format!(
        "coverage_{}_color_{}_depth_stencil_{}",
        samples.coverage(),
        samples.color,
        samples.depth_stencil
    )
}

/// `createMultisampleMixedAttachmentSamplesTests`
pub fn create_multisample_mixed_attachment_samples_tests(use_fragment_shading_rate: bool) -> TestCaseGroup {
    let color_format = vk::Format::R8G8B8A8_UNORM;
    let depth_stencil_formats = [
        vk::Format::D16_UNORM,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
        vk::Format::S8_UINT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];
    let depth_stencil_reduced_formats = [
        vk::Format::D16_UNORM,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];

    let pairs = |list: &[(u32, u32)]| -> Vec<SampleCounts> {
        list.iter()
            .map(|&(color, depth_stencil)| SampleCounts { color, depth_stencil })
            .collect()
    };

    let single_pass_cases = pairs(&[
        (1, 2),
        (1, 4),
        (1, 8),
        (1, 16),
        (2, 4),
        (2, 8),
        (2, 16),
        (4, 8),
        (4, 16),
        (8, 16),
    ]);

    let subpass_cases: Vec<(&str, Vec<SampleCounts>)> = vec![
        ("multi_subpass_decrease_color_4", pairs(&[(2, 4), (1, 4)])),
        ("multi_subpass_decrease_color_8", pairs(&[(4, 8), (2, 8), (1, 8)])),
        ("multi_subpass_decrease_coverage_4", pairs(&[(2, 4), (1, 2)])),
        ("multi_subpass_decrease_coverage_8", pairs(&[(4, 8), (2, 4), (1, 2)])),
        ("multi_subpass_increase_color_4", pairs(&[(1, 4), (2, 4)])),
        ("multi_subpass_increase_color_8", pairs(&[(1, 8), (2, 8), (4, 8)])),
        ("multi_subpass_increase_coverage_4", pairs(&[(1, 2), (2, 4)])),
        ("multi_subpass_increase_coverage_8", pairs(&[(1, 2), (2, 4), (4, 8)])),
    ];

    let case = |name: String,
                per_subpass: Vec<SampleCounts>,
                use_programmable_sample_locations: bool,
                shader_builtins: bool| {
        Box::new(MixedAttachmentSamplesCase {
            name,
            per_subpass,
            use_programmable_sample_locations,
            shader_builtins,
            use_fragment_shading_rate,
        }) as Box<dyn TestCase>
    };
    let format_name = |depth_stencil_format: vk::Format| {
        format!(
            "{}_{}",
            format_case_name(color_format),
            format_case_name(depth_stencil_format)
        )
    };

    let mut root_group = TestCaseGroup::new("mixed_attachment_samples");

    let mut standard_locations_group = TestCaseGroup::new("verify_standard_locations");
    let mut programmable_locations_group = TestCaseGroup::new("verify_programmable_locations");
    for (programmable, locations_group) in [
        (false, &mut standard_locations_group),
        (true, &mut programmable_locations_group),
    ] {
        for samples in &single_pass_cases {
            let mut sample_case_group = TestCaseGroup::new(&sample_count_group_name(*samples));
            for depth_stencil_format in depth_stencil_formats {
                sample_case_group.add_child(case(
                    format_name(depth_stencil_format),
                    vec![*samples],
                    programmable,
                    false,
                ));
            }
            locations_group.add_child(sample_case_group);
        }

        for (case_name, per_subpass) in &subpass_cases {
            let mut sample_case_group = TestCaseGroup::new(*case_name);
            for depth_stencil_format in depth_stencil_reduced_formats {
                sample_case_group.add_child(case(
                    format_name(depth_stencil_format),
                    per_subpass.clone(),
                    programmable,
                    false,
                ));
            }
            locations_group.add_child(sample_case_group);
        }
    }
    root_group.add_child(standard_locations_group);
    root_group.add_child(programmable_locations_group);

    if !use_fragment_shading_rate {
        let mut builtins_group = TestCaseGroup::new("shader_builtins");
        for samples in &single_pass_cases {
            let mut sample_case_group = TestCaseGroup::new(&sample_count_group_name(*samples));
            for depth_stencil_format in depth_stencil_reduced_formats {
                sample_case_group.add_child(case(format_name(depth_stencil_format), vec![*samples], false, true));
            }
            builtins_group.add_child(sample_case_group);
        }
        root_group.add_child(builtins_group);
    }

    root_group
}
