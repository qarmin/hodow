// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassMultisampleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Only `initTests` is ported so far. `MultisampleRenderPassTestInstance` - which
// renders per-sample into a multisampled attachment, reads every sample back through
// an input attachment and writes it into one single-sampled attachment per sample -
// is not, so every case here is a stub and is excluded from the coverage number.

use vulkanalia::vk;

use crate::tcu::{TestCaseGroup, TestError};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::renderpass::render_pass_tests::RenderPassType;
use crate::vkt::{Context, TestCase, TestInstance};

/// `TestSeparateUsage`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TestSeparateUsage {
    /// Upstream's `(TestSeparateUsage)0u` - the plain case, which tests both aspects.
    None,
    /// `TEST_DEPTH`
    Depth,
    /// `TEST_STENCIL`
    Stencil,
}

/// `TestConfig`
#[derive(Clone, Copy)]
pub struct TestConfig {
    pub format: vk::Format,
    pub sample_count: u32,
    pub render_pass_type: RenderPassType,
    pub separate_stencil_usage: TestSeparateUsage,
    pub extended_flags: bool,
}

struct MultisampleTestCase {
    name: String,
    #[allow(dead_code)]
    config: TestConfig,
}

impl TestCase for MultisampleTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Err(TestError::NotSupported("multisample: instance not implemented yet".into()))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        unreachable!("check_support rejects every case until the instance lands")
    }

    fn is_stub(&self) -> bool {
        true
    }
}

/// `formats`, paired with `formatToName`. The seven depth/stencil formats sit at the
/// end of the same list upstream, so they share the loop below.
const FORMATS: [(vk::Format, &str); 57] = [
    (vk::Format::R5G6B5_UNORM_PACK16, "r5g6b5_unorm_pack16"),
    (vk::Format::R8_UNORM, "r8_unorm"),
    (vk::Format::R8_SNORM, "r8_snorm"),
    (vk::Format::R8_UINT, "r8_uint"),
    (vk::Format::R8_SINT, "r8_sint"),
    (vk::Format::R8G8_UNORM, "r8g8_unorm"),
    (vk::Format::R8G8_SNORM, "r8g8_snorm"),
    (vk::Format::R8G8_UINT, "r8g8_uint"),
    (vk::Format::R8G8_SINT, "r8g8_sint"),
    (vk::Format::A8_UNORM, "a8_unorm"),
    (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
    (vk::Format::R8G8B8A8_SNORM, "r8g8b8a8_snorm"),
    (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
    (vk::Format::R8G8B8A8_SINT, "r8g8b8a8_sint"),
    (vk::Format::R8G8B8A8_SRGB, "r8g8b8a8_srgb"),
    (vk::Format::A8B8G8R8_UNORM_PACK32, "a8b8g8r8_unorm_pack32"),
    (vk::Format::A8B8G8R8_SNORM_PACK32, "a8b8g8r8_snorm_pack32"),
    (vk::Format::A8B8G8R8_UINT_PACK32, "a8b8g8r8_uint_pack32"),
    (vk::Format::A8B8G8R8_SINT_PACK32, "a8b8g8r8_sint_pack32"),
    (vk::Format::A8B8G8R8_SRGB_PACK32, "a8b8g8r8_srgb_pack32"),
    (vk::Format::B8G8R8A8_UNORM, "b8g8r8a8_unorm"),
    (vk::Format::B8G8R8A8_SRGB, "b8g8r8a8_srgb"),
    (vk::Format::A2R10G10B10_UNORM_PACK32, "a2r10g10b10_unorm_pack32"),
    (vk::Format::A2B10G10R10_UNORM_PACK32, "a2b10g10r10_unorm_pack32"),
    (vk::Format::A2B10G10R10_UINT_PACK32, "a2b10g10r10_uint_pack32"),
    (vk::Format::R16_UNORM, "r16_unorm"),
    (vk::Format::R16_SNORM, "r16_snorm"),
    (vk::Format::R16_UINT, "r16_uint"),
    (vk::Format::R16_SINT, "r16_sint"),
    (vk::Format::R16_SFLOAT, "r16_sfloat"),
    (vk::Format::R16G16_UNORM, "r16g16_unorm"),
    (vk::Format::R16G16_SNORM, "r16g16_snorm"),
    (vk::Format::R16G16_UINT, "r16g16_uint"),
    (vk::Format::R16G16_SINT, "r16g16_sint"),
    (vk::Format::R16G16_SFLOAT, "r16g16_sfloat"),
    (vk::Format::R16G16B16A16_UNORM, "r16g16b16a16_unorm"),
    (vk::Format::R16G16B16A16_SNORM, "r16g16b16a16_snorm"),
    (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
    (vk::Format::R16G16B16A16_SINT, "r16g16b16a16_sint"),
    (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
    (vk::Format::R32_UINT, "r32_uint"),
    (vk::Format::R32_SINT, "r32_sint"),
    (vk::Format::R32_SFLOAT, "r32_sfloat"),
    (vk::Format::R32G32_UINT, "r32g32_uint"),
    (vk::Format::R32G32_SINT, "r32g32_sint"),
    (vk::Format::R32G32_SFLOAT, "r32g32_sfloat"),
    (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
    (vk::Format::R32G32B32A32_SINT, "r32g32b32a32_sint"),
    (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
    (vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16, "r10x6g10x6b10x6a10x6_unorm_4pack16"),
    (vk::Format::D16_UNORM, "d16_unorm"),
    (vk::Format::X8_D24_UNORM_PACK32, "x8_d24_unorm_pack32"),
    (vk::Format::D32_SFLOAT, "d32_sfloat"),
    (vk::Format::S8_UINT, "s8_uint"),
    (vk::Format::D16_UNORM_S8_UINT, "d16_unorm_s8_uint"),
    (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
    (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
];

const SAMPLE_COUNTS: [u32; 5] = [2, 4, 8, 16, 32];

/// Whether a format carries both aspects, which is what decides the
/// `VK_EXT_separate_stencil_usage` variants.
fn has_depth_and_stencil(format: vk::Format) -> bool {
    matches!(format, vk::Format::D16_UNORM_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT)
}

/// `initTests`
pub fn create_multisample_tests(render_pass_type: RenderPassType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample");
    let mut ext_group = TestCaseGroup::new("separate_stencil_usage");

    for (format, format_name) in FORMATS {
        let mut format_group = TestCaseGroup::new(format_name);
        let mut ext_format_group = TestCaseGroup::new(format_name);

        for sample_count in SAMPLE_COUNTS {
            let test_name = format!("samples_{sample_count}");
            let test_config = TestConfig {
                format,
                sample_count,
                render_pass_type,
                separate_stencil_usage: TestSeparateUsage::None,
                extended_flags: false,
            };
            format_group.add_child(Box::new(MultisampleTestCase {
                name: test_name.clone(),
                config: test_config,
            }) as Box<dyn TestCase>);

            // create tests for VK_EXT_separate_stencil_usage
            if has_depth_and_stencil(format) {
                let mut sample_group = TestCaseGroup::new(test_name);
                for (name, separate_stencil_usage, extended_flags) in [
                    ("test_depth", TestSeparateUsage::Depth, false),
                    ("test_stencil", TestSeparateUsage::Stencil, false),
                    ("test_stencil_extended_flags", TestSeparateUsage::Stencil, true),
                ] {
                    sample_group.add_child(Box::new(MultisampleTestCase {
                        name: name.to_owned(),
                        config: TestConfig {
                            separate_stencil_usage,
                            extended_flags,
                            ..test_config
                        },
                    }) as Box<dyn TestCase>);
                }
                ext_format_group.add_child(sample_group);
            }
        }

        group.add_child(format_group);
        ext_group.add_child(ext_format_group);
    }

    group.add_child(ext_group);
    group
}
