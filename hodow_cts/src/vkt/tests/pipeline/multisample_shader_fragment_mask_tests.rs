// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleShaderFragmentMaskTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `checkRequirements` is ported in full; the test body (the FMASK fetch against the
// ordinary texel fetch, SPIR-V assembly shaders using VK_AMD_shader_fragment_mask) is not, so a device that exposes the extension
// ends in NotPorted. Every other device ends in NotSupported, as upstream does.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::pipeline::image_util::{format_case_name, is_int_format, is_uint_format};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

#[derive(Clone, Copy, PartialEq, Eq)]
enum SampleSource {
    Image,
    SubpassInput,
}

struct ShaderFragmentMaskCase {
    name: String,
    color_format: vk::Format,
    num_color_samples: vk::SampleCountFlags,
    sample_source: SampleSource,
}

impl TestCase for ShaderFragmentMaskCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkRequirements`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !context.is_device_functionality_supported("VK_AMD_shader_fragment_mask") {
            return Err(TestError::NotSupported(
                "VK_AMD_shader_fragment_mask not supported".to_string(),
            ));
        }

        let limits = &context.get_device_properties().limits;

        if !limits
            .framebuffer_color_sample_counts
            .intersects(self.num_color_samples)
        {
            return Err(TestError::NotSupported(
                "framebufferColorSampleCounts: sample count not supported".to_string(),
            ));
        }

        if is_int_format(self.color_format) || is_uint_format(self.color_format) {
            if !limits
                .sampled_image_integer_sample_counts
                .intersects(self.num_color_samples)
            {
                return Err(TestError::NotSupported(
                    "sampledImageIntegerSampleCounts: sample count not supported".to_string(),
                ));
            }
        } else if !limits
            .sampled_image_color_sample_counts
            .intersects(self.num_color_samples)
        {
            return Err(TestError::NotSupported(
                "sampledImageColorSampleCounts: sample count not supported".to_string(),
            ));
        }

        if self.sample_source == SampleSource::SubpassInput
            && context.get_device_features().fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics: feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderFragmentMaskInstance)
    }
}

struct ShaderFragmentMaskInstance;

impl TestInstance for ShaderFragmentMaskInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted("VK_AMD_shader_fragment_mask fetches".to_string()))
    }
}

/// `createMultisampleShaderFragmentMaskTests`
pub fn create_multisample_shader_fragment_mask_tests(shader_object: bool) -> TestCaseGroup {
    let color_formats = [vk::Format::R8G8B8A8_UNORM, vk::Format::R32_UINT, vk::Format::R32_SINT];
    let sample_counts = [
        (vk::SampleCountFlags::_2, 2u32),
        (vk::SampleCountFlags::_4, 4),
        (vk::SampleCountFlags::_8, 8),
        (vk::SampleCountFlags::_16, 16),
    ];
    let source_cases = [
        ("image_2d", SampleSource::Image),
        ("image_2d_array", SampleSource::Image),
        ("subpass_input", SampleSource::SubpassInput),
    ];

    let mut root_group = TestCaseGroup::new("shader_fragment_mask");
    for (samples, sample_value) in sample_counts {
        let mut sample_count_group = TestCaseGroup::new(&format!("samples_{sample_value}"));
        for (source_name, sample_source) in source_cases {
            if sample_source == SampleSource::SubpassInput && shader_object {
                continue;
            }
            let mut source_group = TestCaseGroup::new(source_name);
            for color_format in color_formats {
                source_group.add_child(Box::new(ShaderFragmentMaskCase {
                    name: format_case_name(color_format),
                    color_format,
                    num_color_samples: samples,
                    sample_source,
                }) as Box<dyn TestCase>);
            }
            sample_count_group.add_child(source_group);
        }
        root_group.add_child(sample_count_group);
    }
    root_group
}
