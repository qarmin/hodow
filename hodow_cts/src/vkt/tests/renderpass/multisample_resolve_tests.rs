// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/renderpass/
// vktRenderPassMultisampleResolveTests.cpp

use vulkanalia::vk;

use crate::tcu::TestCaseGroup;
use crate::vkt::tests::renderpass::render_pass_tests::RenderPassType;

/// `TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TestType {
    Resolve,
    MaxAttachments,
    Compatibility,
}

/// `TestConfig`
#[derive(Clone, Copy)]
pub struct TestConfig {
    pub test_type: TestType,
    pub format: vk::Format,
    pub sample_count: u32,
    pub layer_count: u32,
    pub base_layer: u32,
    pub attachment_count: u32,
    pub width: u32,
    pub height: u32,
    pub render_pass_type: RenderPassType,
    /// `TestConfig2::resolveLevel` - the mip level the resolve target is taken at.
    /// `None` is the plain `TestConfig` the other two instances take.
    pub resolve_level: Option<u32>,
}

/// The program set every case shares. Which of its shaders a case uses follows from
/// the layer count, the channel class and the attachment count, so one collection
/// covers the whole group.
pub struct MsResolvePrograms {
    pub name: &'static str,
    pub programs: crate::vk::programs::BinaryCollection,
}

struct MultisampleResolveTestCase {
    name: String,
    #[allow(dead_code)]
    config: TestConfig,
}

impl crate::vkt::TestCase for MultisampleResolveTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &crate::vkt::Context<'_>) -> Result<(), crate::tcu::TestError> {
        Err(crate::tcu::TestError::NotSupported("multisample_resolve: instance not implemented yet".into()))
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        crate::vk::programs::BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a crate::vkt::Context<'a>) -> Box<dyn crate::vkt::TestInstance + 'a> {
        unreachable!("check_support rejects every case until the instance lands")
    }

    fn is_stub(&self) -> bool {
        true
    }
}

/// `formats`, paired with `formatToName`.
const FORMATS: [(vk::Format, &str); 50] = [
    (vk::Format::R5G6B5_UNORM_PACK16, "r5g6b5_unorm_pack16"),
    (vk::Format::R8_UNORM, "r8_unorm"),
    (vk::Format::R8_SNORM, "r8_snorm"),
    (vk::Format::R8_UINT, "r8_uint"),
    (vk::Format::R8_SINT, "r8_sint"),
    (vk::Format::A8_UNORM, "a8_unorm"),
    (vk::Format::R8G8_UNORM, "r8g8_unorm"),
    (vk::Format::R8G8_SNORM, "r8g8_snorm"),
    (vk::Format::R8G8_UINT, "r8g8_uint"),
    (vk::Format::R8G8_SINT, "r8g8_sint"),
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
];

const SAMPLE_COUNTS: [u32; 3] = [2, 4, 8];
const LAYER_COUNTS: [u32; 3] = [1, 3, 6];
const RESOLVE_LEVELS: [u32; 3] = [2, 3, 4];

/// `initTests`. Single-layer cases sit directly under `multisample_resolve`; the
/// layered ones get a `layers_N` level of their own.
pub fn create_multisample_resolve_tests(render_pass_type: RenderPassType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample_resolve");

    for layer_count in LAYER_COUNTS {
        let mut layer_group = TestCaseGroup::new(format!("layers_{layer_count}"));

        for (format, format_name) in FORMATS {
            let mut format_group = TestCaseGroup::new(format_name);

            for sample_count in SAMPLE_COUNTS {
                // Skip this test as it is rather slow
                if layer_count == 6 && sample_count == 8 {
                    continue;
                }

                let test_name = format!("samples_{sample_count}");
                let test_config = TestConfig {
                    test_type: TestType::Resolve,
                    format,
                    sample_count,
                    layer_count,
                    base_layer: 0,
                    attachment_count: 4,
                    width: 32,
                    height: 32,
                    render_pass_type,
                    resolve_level: None,
                };

                let mut add = |name: String, config: TestConfig| {
                    format_group.add_child(Box::new(MultisampleResolveTestCase { name, config }) as Box<dyn crate::vkt::TestCase>);
                };

                add(test_name.clone(), test_config);
                add(format!("{test_name}_baseLayer1"), TestConfig { base_layer: 1, ..test_config });
                for resolve_level in RESOLVE_LEVELS {
                    add(
                        format!("{test_name}_resolve_level_{resolve_level}"),
                        TestConfig {
                            resolve_level: Some(resolve_level),
                            ..test_config
                        },
                    );
                }

                // `MaxAttachmenstsRenderPassTest` is meant to test extreme cases where
                // applications might consume all available on-chip memory. The maximal
                // attachment count is not known when the shaders are built, so every
                // power-of-two count up to the limit gets its own case.
                if layer_count == 1 {
                    for power in 2..5 {
                        let attachment_count = 1 << power;
                        add(
                            format!("max_attachments_{attachment_count}_{test_name}"),
                            TestConfig {
                                test_type: TestType::MaxAttachments,
                                attachment_count,
                                ..test_config
                            },
                        );
                    }

                    add(
                        format!("compatibility_{test_name}"),
                        TestConfig {
                            test_type: TestType::Compatibility,
                            attachment_count: 1,
                            ..test_config
                        },
                    );
                }
            }

            if layer_count == 1 {
                group.add_child(format_group);
            } else {
                layer_group.add_child(format_group);
            }
        }

        if layer_count != 1 {
            group.add_child(layer_group);
        }
    }

    group
}
