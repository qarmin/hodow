// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/renderpass/
// vktRenderPassDepthStencilResolveTests.cpp

use vulkanalia::vk;

use crate::tcu::TestCaseGroup;

/// Which aspect a case reads back and checks. Upstream registers a separate case per
/// aspect even though one render pass resolves both, because the expected value differs.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum VerifyBuffer {
    Depth,
    Stencil,
}

/// `TestConfig`
#[derive(Clone, Copy)]
pub struct TestConfig {
    pub format: vk::Format,
    pub width: u32,
    pub height: u32,
    pub image_layers: u32,
    pub view_layers: u32,
    pub resolve_base_layer: u32,
    pub render_area: vk::Rect2D,
    pub aspect_flags: vk::ImageAspectFlags,
    pub sample_count: u32,
    pub depth_resolve_mode: vk::ResolveModeFlags,
    pub stencil_resolve_mode: vk::ResolveModeFlags,
    pub verify_buffer: VerifyBuffer,
    pub clear_value: vk::ClearDepthStencilValue,
    pub depth_expected_value: f32,
    pub stencil_expected_value: u8,
    pub separate_depth_stencil_layouts: bool,
    pub unused_resolve: bool,
    pub compatible_format: Option<vk::Format>,
    pub sample_mask: bool,
}

/// `DepthCompatibilityManager` - the depth-only format each combined format may be
/// resolved into.
fn alternative_format(format: vk::Format) -> Option<vk::Format> {
    match format {
        vk::Format::D32_SFLOAT_S8_UINT => Some(vk::Format::D32_SFLOAT),
        vk::Format::D16_UNORM_S8_UINT => Some(vk::Format::D16_UNORM),
        vk::Format::D24_UNORM_S8_UINT => Some(vk::Format::X8_D24_UNORM_PACK32),
        _ => None,
    }
}

struct DepthStencilResolveTestCase {
    name: String,
    #[allow(dead_code)]
    config: TestConfig,
}

impl crate::vkt::TestCase for DepthStencilResolveTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &crate::vkt::Context<'_>) -> Result<(), crate::tcu::TestError> {
        Err(crate::tcu::TestError::NotSupported("depth_stencil_resolve: instance not implemented yet".into()))
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        crate::vk::programs::BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a crate::vkt::Context<'a>) -> Box<dyn crate::vkt::TestInstance + 'a> {
        unreachable!("check_support rejects every case until the instance lands")
    }
}

struct FormatData {
    format: vk::Format,
    name: &'static str,
    has_depth: bool,
    has_stencil: bool,
}

const FORMATS: [FormatData; 7] = [
    FormatData {
        format: vk::Format::D16_UNORM,
        name: "d16_unorm",
        has_depth: true,
        has_stencil: false,
    },
    FormatData {
        format: vk::Format::X8_D24_UNORM_PACK32,
        name: "x8_d24_unorm_pack32",
        has_depth: true,
        has_stencil: false,
    },
    FormatData {
        format: vk::Format::D32_SFLOAT,
        name: "d32_sfloat",
        has_depth: true,
        has_stencil: false,
    },
    FormatData {
        format: vk::Format::S8_UINT,
        name: "s8_uint",
        has_depth: false,
        has_stencil: true,
    },
    FormatData {
        format: vk::Format::D16_UNORM_S8_UINT,
        name: "d16_unorm_s8_uint",
        has_depth: true,
        has_stencil: true,
    },
    FormatData {
        format: vk::Format::D24_UNORM_S8_UINT,
        name: "d24_unorm_s8_uint",
        has_depth: true,
        has_stencil: true,
    },
    FormatData {
        format: vk::Format::D32_SFLOAT_S8_UINT,
        name: "d32_sfloat_s8_uint",
        has_depth: true,
        has_stencil: true,
    },
];

const RESOLVE_MODES: [(vk::ResolveModeFlags, &str); 5] = [
    (vk::ResolveModeFlags::NONE, "none"),
    (vk::ResolveModeFlags::SAMPLE_ZERO, "zero"),
    (vk::ResolveModeFlags::AVERAGE, "average"),
    (vk::ResolveModeFlags::MIN, "min"),
    (vk::ResolveModeFlags::MAX, "max"),
];

const SAMPLE_COUNTS: [u32; 6] = [2, 4, 8, 16, 32, 64];

/// The value each resolve mode is expected to produce, indexed by mode then by sample
/// count. The geometry is fixed, so these are constants rather than something the test
/// computes.
const DEPTH_EXPECTED_VALUE: [[f32; 6]; 5] = [
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    [0.04, 0.04, 0.04, 0.04, 0.04, 0.04],
    [0.03, 0.135, 0.135, 0.135, 0.135, 0.135],
    [0.02, 0.02, 0.02, 0.02, 0.02, 0.02],
    [0.04, 0.32, 0.32, 0.32, 0.32, 0.32],
];

const STENCIL_EXPECTED_VALUE: [[u8; 6]; 5] = [
    [0, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 1],
    [255, 255, 255, 255, 255, 255],
];

struct ImageTestData {
    group_name: &'static str,
    width: u32,
    height: u32,
    image_layers: u32,
    render_area: vk::Rect2D,
    clear_value: vk::ClearDepthStencilValue,
}

fn rect(x: i32, y: i32, w: u32, h: u32) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x, y },
        extent: vk::Extent2D { width: w, height: h },
    }
}

fn clear(depth: f32, stencil: u32) -> vk::ClearDepthStencilValue {
    vk::ClearDepthStencilValue { depth, stencil }
}

/// `initTests`. 1D and 3D images are absent on purpose: a non-2D image reports only one
/// sample count, and a framebuffer may not take a depth/stencil view out of a 3D image.
pub fn create_tests() -> TestCaseGroup {
    let images_test_data = [
        ImageTestData {
            group_name: "image_2d_32_32",
            width: 32,
            height: 32,
            image_layers: 1,
            render_area: rect(0, 0, 32, 32),
            clear_value: clear(0.000, 0x00),
        },
        ImageTestData {
            group_name: "image_2d_8_32",
            width: 8,
            height: 32,
            image_layers: 1,
            render_area: rect(1, 1, 6, 30),
            clear_value: clear(0.123, 0x01),
        },
        ImageTestData {
            group_name: "image_2d_49_13",
            width: 49,
            height: 13,
            image_layers: 1,
            render_area: rect(10, 5, 20, 8),
            clear_value: clear(1.000, 0x05),
        },
        ImageTestData {
            group_name: "image_2d_5_1",
            width: 5,
            height: 1,
            image_layers: 1,
            render_area: rect(0, 0, 5, 1),
            clear_value: clear(0.500, 0x00),
        },
        ImageTestData {
            group_name: "image_2d_17_1",
            width: 17,
            height: 1,
            image_layers: 1,
            render_area: rect(1, 0, 15, 1),
            clear_value: clear(0.789, 0xfa),
        },
    ];

    let mut group = TestCaseGroup::new("depth_stencil_resolve");

    // The misc cases do not vary over the tree below.
    let mut misc_group = TestCaseGroup::new("misc");
    for name in ["properties", "resolve_stencil_aspect_that_is_not_present", "resolve_depth_aspect_that_is_not_present"] {
        misc_group.add_child(Box::new(DepthStencilResolveTestCase {
            name: name.to_string(),
            config: misc_placeholder_config(),
        }) as Box<dyn crate::vkt::TestCase>);
    }
    group.add_child(misc_group);

    for (image_data_ndx, image_data) in images_test_data.iter().enumerate() {
        let mut image_group = TestCaseGroup::new(image_data.group_name);

        for (sample_count_ndx, sample_count) in SAMPLE_COUNTS.into_iter().enumerate() {
            let mut sample_group = TestCaseGroup::new(format!("samples_{sample_count}"));

            for format_data in &FORMATS {
                let aspect_flags = aspect_of(format_data);
                let separate_layouts_loop_count = if format_data.has_depth && format_data.has_stencil { 2 } else { 1 };

                for separate in 0..separate_layouts_loop_count {
                    let use_separate = separate == 1;
                    let group_name = format!("{}{}", format_data.name, if use_separate { "_separate_layouts" } else { "" });
                    let mut format_group = TestCaseGroup::new(group_name);

                    for (depth_ndx, (depth_mode, depth_name)) in RESOLVE_MODES.into_iter().enumerate() {
                        for (stencil_ndx, (stencil_mode, stencil_name)) in RESOLVE_MODES.into_iter().enumerate() {
                            for unused_resolve in [false, true] {
                                // There is no average resolve mode for stencil.
                                if stencil_mode == vk::ResolveModeFlags::AVERAGE {
                                    continue;
                                }
                                // A resolve attachment that is present must resolve something.
                                if depth_mode == vk::ResolveModeFlags::NONE && stencil_mode == vk::ResolveModeFlags::NONE {
                                    continue;
                                }
                                // An absent aspect either resolves as NONE or matches the other.
                                if !format_data.has_depth && depth_mode != vk::ResolveModeFlags::NONE && depth_mode != stencil_mode {
                                    continue;
                                }
                                if !format_data.has_stencil && stencil_mode != vk::ResolveModeFlags::NONE && depth_mode != stencil_mode {
                                    continue;
                                }

                                let base_name = format!("depth_{depth_name}_stencil_{stencil_name}{}", if unused_resolve { "_unused_resolve" } else { "" });

                                let make_config = |verify: VerifyBuffer, compatible_format: Option<vk::Format>| TestConfig {
                                    format: format_data.format,
                                    width: image_data.width,
                                    height: image_data.height,
                                    image_layers: 1,
                                    view_layers: 1,
                                    resolve_base_layer: 0,
                                    render_area: image_data.render_area,
                                    aspect_flags,
                                    sample_count,
                                    depth_resolve_mode: depth_mode,
                                    stencil_resolve_mode: stencil_mode,
                                    verify_buffer: verify,
                                    clear_value: image_data.clear_value,
                                    depth_expected_value: DEPTH_EXPECTED_VALUE[depth_ndx][sample_count_ndx],
                                    stencil_expected_value: STENCIL_EXPECTED_VALUE[stencil_ndx][sample_count_ndx],
                                    separate_depth_stencil_layouts: use_separate,
                                    unused_resolve,
                                    compatible_format,
                                    sample_mask: false,
                                };

                                if format_data.has_depth {
                                    let name = format!("{base_name}_testing_depth");
                                    format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                        name: name.clone(),
                                        config: make_config(VerifyBuffer::Depth, None),
                                    }) as Box<dyn crate::vkt::TestCase>);

                                    // The format-compatibility variant is registered once, for the
                                    // smallest sample count and the first image size only.
                                    if let Some(compatible) = alternative_format(format_data.format)
                                        .filter(|_| sample_count_ndx == 0 && image_data_ndx == 0 && depth_mode != vk::ResolveModeFlags::NONE)
                                    {
                                        format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                            name: format!("compatibility_{name}"),
                                            config: make_config(VerifyBuffer::Depth, Some(compatible)),
                                        }) as Box<dyn crate::vkt::TestCase>);
                                    }
                                }

                                if format_data.has_stencil {
                                    let name = format!("{base_name}_testing_stencil");
                                    format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                        name: name.clone(),
                                        config: make_config(VerifyBuffer::Stencil, None),
                                    }) as Box<dyn crate::vkt::TestCase>);

                                    // Rendering one pass per sample, so each sample of the
                                    // stencil buffer holds a different value; only meaningful
                                    // when depth takes sample zero.
                                    if depth_mode == vk::ResolveModeFlags::SAMPLE_ZERO {
                                        let mut config = make_config(VerifyBuffer::Stencil, None);
                                        config.sample_mask = true;
                                        format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                            name: format!("{name}_samplemask"),
                                            config,
                                        }) as Box<dyn crate::vkt::TestCase>);
                                    }

                                    // Every format with both aspects has a depth aspect whose
                                    // size is incompatible with anything else, so the only
                                    // alternative left for the stencil case is S8_UINT.
                                    if sample_count_ndx == 0 && image_data_ndx == 0 && format_data.has_depth && stencil_mode != vk::ResolveModeFlags::NONE {
                                        format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                            name: format!("compatibility_{name}"),
                                            config: make_config(VerifyBuffer::Stencil, Some(vk::Format::S8_UINT)),
                                        }) as Box<dyn crate::vkt::TestCase>);
                                    }
                                }
                            }
                        }
                    }

                    sample_group.add_child(format_group);
                }
            }

            image_group.add_child(sample_group);
        }

        group.add_child(image_group);
    }

    group.add_child(create_layered_tests());
    group
}

fn aspect_of(format_data: &FormatData) -> vk::ImageAspectFlags {
    let mut flags = vk::ImageAspectFlags::empty();
    if format_data.has_depth {
        flags |= vk::ImageAspectFlags::DEPTH;
    }
    if format_data.has_stencil {
        flags |= vk::ImageAspectFlags::STENCIL;
    }
    flags
}

fn misc_placeholder_config() -> TestConfig {
    TestConfig {
        format: vk::Format::D32_SFLOAT_S8_UINT,
        width: 32,
        height: 32,
        image_layers: 1,
        view_layers: 1,
        resolve_base_layer: 0,
        render_area: rect(0, 0, 32, 32),
        aspect_flags: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
        sample_count: 4,
        depth_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
        stencil_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
        verify_buffer: VerifyBuffer::Depth,
        clear_value: clear(0.0, 0),
        depth_expected_value: 0.0,
        stencil_expected_value: 0,
        separate_depth_stencil_layouts: false,
        unused_resolve: false,
        compatible_format: None,
        sample_mask: false,
    }
}

/// The layered case renders to layers 4-6 and resolves into layers 1-3, so it checks
/// both that every layer resolves and that a framebuffer may start above layer zero.
/// Only one resolve mode axis is varied here rather than the full cross product.
fn create_layered_tests() -> TestCaseGroup {
    let data = ImageTestData {
        group_name: "image_2d_16_64_6",
        width: 16,
        height: 64,
        image_layers: 6,
        render_area: rect(10, 10, 6, 54),
        clear_value: clear(1.0, 0x0),
    };

    let mut image_group = TestCaseGroup::new(data.group_name);

    for (sample_count_ndx, sample_count) in SAMPLE_COUNTS.into_iter().enumerate() {
        let mut sample_group = TestCaseGroup::new(format!("samples_{sample_count}"));

        for format_data in &FORMATS {
            let aspect_flags = aspect_of(format_data);
            let separate_layouts_loop_count = if format_data.has_depth && format_data.has_stencil { 2 } else { 1 };

            for separate in 0..separate_layouts_loop_count {
                let use_separate = separate == 1;
                let group_name = format!("{}{}", format_data.name, if use_separate { "_separate_layouts" } else { "" });
                let mut format_group = TestCaseGroup::new(group_name);

                for (mode_ndx, (mode, mode_name)) in RESOLVE_MODES.into_iter().enumerate() {
                    for unused_resolve in [false, true] {
                        if !format_data.has_stencil && mode == vk::ResolveModeFlags::NONE {
                            continue;
                        }
                        if !format_data.has_depth && mode == vk::ResolveModeFlags::NONE {
                            continue;
                        }

                        let unused_suffix = if unused_resolve { "_unused_resolve" } else { "" };

                        let make_config = |verify: VerifyBuffer| TestConfig {
                            format: format_data.format,
                            width: data.width,
                            height: data.height,
                            image_layers: data.image_layers,
                            view_layers: 3,
                            resolve_base_layer: 1,
                            render_area: data.render_area,
                            aspect_flags,
                            sample_count,
                            depth_resolve_mode: mode,
                            stencil_resolve_mode: if mode == vk::ResolveModeFlags::AVERAGE {
                                vk::ResolveModeFlags::SAMPLE_ZERO
                            } else {
                                mode
                            },
                            verify_buffer: verify,
                            clear_value: data.clear_value,
                            depth_expected_value: DEPTH_EXPECTED_VALUE[mode_ndx][sample_count_ndx],
                            stencil_expected_value: STENCIL_EXPECTED_VALUE[mode_ndx][sample_count_ndx],
                            separate_depth_stencil_layouts: use_separate,
                            unused_resolve,
                            compatible_format: None,
                            sample_mask: false,
                        };

                        if format_data.has_depth {
                            format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                name: format!("depth_{mode_name}{unused_suffix}"),
                                config: make_config(VerifyBuffer::Depth),
                            }) as Box<dyn crate::vkt::TestCase>);
                        }
                        if format_data.has_stencil && mode != vk::ResolveModeFlags::AVERAGE {
                            format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                name: format!("stencil_{mode_name}{unused_suffix}"),
                                config: make_config(VerifyBuffer::Stencil),
                            }) as Box<dyn crate::vkt::TestCase>);
                        }
                    }
                }

                sample_group.add_child(format_group);
            }
        }

        image_group.add_child(sample_group);
    }

    image_group
}
