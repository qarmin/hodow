// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/renderpass/
// vktRenderPassDepthStencilResolveTests.cpp

use vulkanalia::vk::{self, HasBuilder};

use crate::tcu::TestError;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_buffer_image_copy, make_image_subresource_layers, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer, make_memory_barrier};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::{Unique, VkResultExt};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

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

/// The program set every case shares; which shaders it uses is decided at pipeline
/// creation from three independent parameters.
pub struct DsResolvePrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

struct DepthStencilResolveTestCase {
    name: String,
    config: TestConfig,
}

impl TestConfig {
    /// `resolveFormat` - the compatibility cases resolve into a different but
    /// size-compatible format.
    fn resolve_format(&self) -> vk::Format {
        self.compatible_format.unwrap_or(self.format)
    }

    /// `resolveAspectFlags`
    fn resolve_aspect_flags(&self) -> vk::ImageAspectFlags {
        aspect_flags_for_format(self.resolve_format())
    }

    /// `m_numRenderPasses` - stencil can only take one reference value per pass, so
    /// giving each sample its own value means one pass per sample.
    fn num_render_passes(&self) -> u32 {
        if self.verify_buffer == VerifyBuffer::Depth || !self.sample_mask {
            1
        } else {
            self.sample_count
        }
    }
}

/// `aspectFlagsForFormat`
fn aspect_flags_for_format(format: vk::Format) -> vk::ImageAspectFlags {
    let mut flags = vk::ImageAspectFlags::empty();
    if has_depth(format) {
        flags |= vk::ImageAspectFlags::DEPTH;
    }
    if has_stencil(format) {
        flags |= vk::ImageAspectFlags::STENCIL;
    }
    flags
}

fn has_depth(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::D16_UNORM
            | vk::Format::X8_D24_UNORM_PACK32
            | vk::Format::D32_SFLOAT
            | vk::Format::D16_UNORM_S8_UINT
            | vk::Format::D24_UNORM_S8_UINT
            | vk::Format::D32_SFLOAT_S8_UINT
    )
}

fn has_stencil(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::S8_UINT | vk::Format::D16_UNORM_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT
    )
}

fn sample_count_bit(count: u32) -> vk::SampleCountFlags {
    match count {
        1 => vk::SampleCountFlags::_1,
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        16 => vk::SampleCountFlags::_16,
        32 => vk::SampleCountFlags::_32,
        64 => vk::SampleCountFlags::_64,
        other => panic!("not a sample count: {other}"),
    }
}

impl TestCase for DepthStencilResolveTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        use vulkanalia::vk::{InstanceV1_0, InstanceV1_1};

        let c = &self.config;

        if context.get_device_features().sample_rate_shading != vk::TRUE {
            return Err(TestError::NotSupported("sampleRateShading not supported".into()));
        }
        context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;

        if c.image_layers > 1 && context.get_device_features().geometry_shader != vk::TRUE {
            return Err(TestError::NotSupported("geometryShader not supported".into()));
        }

        if c.separate_depth_stencil_layouts {
            context.require_device_functionality("VK_KHR_separate_depth_stencil_layouts")?;
        }

        let mut resolve_props = vk::PhysicalDeviceDepthStencilResolveProperties::default();
        let mut props = vk::PhysicalDeviceProperties2::builder().push_next(&mut resolve_props);
        unsafe { context.get_instance().get_physical_device_properties2(context.get_physical_device(), &mut props) };

        if c.depth_resolve_mode != vk::ResolveModeFlags::NONE && !resolve_props.supported_depth_resolve_modes.contains(c.depth_resolve_mode) {
            return Err(TestError::NotSupported("Depth resolve mode not supported".into()));
        }
        if c.stencil_resolve_mode != vk::ResolveModeFlags::NONE && !resolve_props.supported_stencil_resolve_modes.contains(c.stencil_resolve_mode) {
            return Err(TestError::NotSupported("Stencil resolve mode not supported".into()));
        }

        // A format with both aspects resolving them differently needs the driver to say
        // it can; matching modes always work.
        if has_depth(c.format) && has_stencil(c.format) && c.depth_resolve_mode != c.stencil_resolve_mode {
            let one_is_none = c.depth_resolve_mode == vk::ResolveModeFlags::NONE || c.stencil_resolve_mode == vk::ResolveModeFlags::NONE;
            if one_is_none && resolve_props.independent_resolve_none != vk::TRUE {
                return Err(TestError::NotSupported("independentResolveNone not supported".into()));
            }
            if !one_is_none && resolve_props.independent_resolve != vk::TRUE {
                return Err(TestError::NotSupported("independentResolve not supported".into()));
            }
        }

        let image_format_properties = |format: vk::Format, usage: vk::ImageUsageFlags| unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };

        if let Some(compatible) = c.compatible_format {
            let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | if c.unused_resolve {
                    vk::ImageUsageFlags::TRANSFER_DST
                } else {
                    vk::ImageUsageFlags::empty()
                };
            if image_format_properties(compatible, usage).is_err() {
                return Err(TestError::NotSupported("Alternative image format for compatibility test not supported".into()));
            }
        }

        let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC;
        let props = image_format_properties(c.format, usage).map_err(|_| TestError::NotSupported("Format not supported".into()))?;

        if !props.sample_counts.contains(sample_count_bit(c.sample_count)) {
            return Err(TestError::NotSupported("Sample count not supported".into()));
        }
        if props.max_array_layers < c.image_layers {
            return Err(TestError::NotSupported("Layers count not supported".into()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::renderpass_ds_resolve::DS_RESOLVE_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthStencilResolveInstance { context, config: self.config })
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

    // The misc cases are a separate upstream test class and do not vary over the tree below.
    let mut misc_group = TestCaseGroup::new("misc");
    for (name, test_type) in [
        ("properties", MiscTestType::Properties),
        ("resolve_stencil_aspect_that_is_not_present", MiscTestType::ResolveStencilAspectThatIsNotPresent),
        ("resolve_depth_aspect_that_is_not_present", MiscTestType::ResolveDepthAspectThatIsNotPresent),
    ] {
        misc_group.add_child(Box::new(MiscTestCase { name, test_type }) as Box<dyn crate::vkt::TestCase>);
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
                                    if let Some(compatible) =
                                        alternative_format(format_data.format).filter(|_| sample_count_ndx == 0 && image_data_ndx == 0 && depth_mode != vk::ResolveModeFlags::NONE)
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
                            resolve_base_layer: 0,
                            render_area: data.render_area,
                            aspect_flags,
                            sample_count,
                            // Only the aspect under test varies its mode here; the other one is
                            // pinned to SAMPLE_ZERO so independentResolve is never demanded.
                            depth_resolve_mode: if verify == VerifyBuffer::Depth { mode } else { vk::ResolveModeFlags::SAMPLE_ZERO },
                            stencil_resolve_mode: if verify == VerifyBuffer::Depth { vk::ResolveModeFlags::SAMPLE_ZERO } else { mode },
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

/// `DepthStencilResolveTest`
struct DepthStencilResolveInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl DepthStencilResolveInstance<'_> {
    /// `createRenderPass`. Every pass but the last loads what the previous one stored
    /// and leaves the images in the attachment layout; only the last one resolves.
    fn create_render_pass(&self, format: vk::Format, render_pass_no: u32) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::DeviceV1_2;

        let c = &self.config;
        let device = self.context.get_device();
        let samples = sample_count_bit(c.sample_count);
        let last = render_pass_no == c.num_render_passes() - 1;

        // With separate layouts each aspect gets its own, and the one not under test is
        // left GENERAL because nothing reads it.
        let (layout, stencil_layout) = if c.separate_depth_stencil_layouts {
            if c.verify_buffer == VerifyBuffer::Depth {
                (vk::ImageLayout::DEPTH_ATTACHMENT_OPTIMAL, vk::ImageLayout::GENERAL)
            } else {
                (vk::ImageLayout::GENERAL, vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL)
            }
        } else {
            (vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        };
        let (final_layout, stencil_final_layout) = if last {
            (vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
        } else {
            (layout, stencil_layout)
        };

        let first = render_pass_no == 0;
        let load_op = if first { vk::AttachmentLoadOp::CLEAR } else { vk::AttachmentLoadOp::LOAD };
        let store_op = if c.num_render_passes() > 1 {
            vk::AttachmentStoreOp::STORE
        } else {
            vk::AttachmentStoreOp::DONT_CARE
        };

        let mut ms_stencil_layout = vk::AttachmentDescriptionStencilLayout::builder()
            .stencil_initial_layout(if first { vk::ImageLayout::UNDEFINED } else { stencil_layout })
            .stencil_final_layout(stencil_final_layout);
        let mut multisample_attachment = vk::AttachmentDescription2::builder()
            .format(c.format)
            .samples(samples)
            .load_op(load_op)
            .store_op(store_op)
            .stencil_load_op(load_op)
            .stencil_store_op(store_op)
            .initial_layout(if first { vk::ImageLayout::UNDEFINED } else { layout })
            .final_layout(final_layout);
        if c.separate_depth_stencil_layouts {
            multisample_attachment = multisample_attachment.push_next(&mut ms_stencil_layout);
        }

        let single_initial = if c.unused_resolve {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        } else {
            vk::ImageLayout::UNDEFINED
        };
        let (single_initial, single_stencil_initial) = if first { (single_initial, single_initial) } else { (layout, stencil_layout) };

        let mut ss_stencil_layout = vk::AttachmentDescriptionStencilLayout::builder()
            .stencil_initial_layout(single_stencil_initial)
            .stencil_final_layout(stencil_final_layout);
        let mut singlesample_attachment = vk::AttachmentDescription2::builder()
            .format(format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(single_initial)
            .final_layout(final_layout);
        if c.separate_depth_stencil_layouts {
            singlesample_attachment = singlesample_attachment.push_next(&mut ss_stencil_layout);
        }

        let attachments = [multisample_attachment.build(), singlesample_attachment.build()];

        let mut ms_ref_stencil = vk::AttachmentReferenceStencilLayout::builder().stencil_layout(stencil_layout);
        let mut multisample_ref = vk::AttachmentReference2::builder().attachment(0).layout(layout).aspect_mask(c.aspect_flags);
        if c.separate_depth_stencil_layouts {
            multisample_ref = multisample_ref.push_next(&mut ms_ref_stencil);
        }
        let multisample_ref = multisample_ref.build();

        let mut ss_ref_stencil = vk::AttachmentReferenceStencilLayout::builder().stencil_layout(stencil_layout);
        let mut singlesample_ref = vk::AttachmentReference2::builder()
            // An unused resolve, or any pass before the last, names no attachment.
            .attachment(if c.unused_resolve || !last { vk::ATTACHMENT_UNUSED } else { 1 })
            .layout(layout)
            .aspect_mask(aspect_flags_for_format(format));
        if c.separate_depth_stencil_layouts {
            singlesample_ref = singlesample_ref.push_next(&mut ss_ref_stencil);
        }
        let singlesample_ref = singlesample_ref.build();

        let mut resolve_description = vk::SubpassDescriptionDepthStencilResolve::builder()
            .depth_resolve_mode(c.depth_resolve_mode)
            .stencil_resolve_mode(c.stencil_resolve_mode)
            .depth_stencil_resolve_attachment(&singlesample_ref);

        let mut subpass = vk::SubpassDescription2::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .view_mask(0)
            .depth_stencil_attachment(&multisample_ref);
        if last {
            subpass = subpass.push_next(&mut resolve_description);
        }
        let subpasses = [subpass.build()];

        let info = vk::RenderPassCreateInfo2::builder().attachments(&attachments).subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass2(&info, None) }.vk_check("vkCreateRenderPass2")?;
        Ok(Unique::new(device, handle))
    }
}

impl TestInstance for DepthStencilResolveInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::DeviceV1_0;

        let c = self.config;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let resolve_format = c.resolve_format();
        let testing_depth = c.verify_buffer == VerifyBuffer::Depth;

        let make_image = |format: vk::Format, sample_count: u32, extra_usage: vk::ImageUsageFlags| -> Result<ImageWithMemory<'_>, TestError> {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: c.width,
                    height: c.height,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(c.image_layers)
                .samples(sample_count_bit(sample_count))
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | extra_usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)
        };

        let multisample_image = make_image(c.format, c.sample_count, vk::ImageUsageFlags::empty())?;
        let singlesample_image = make_image(
            resolve_format,
            1,
            if c.unused_resolve {
                vk::ImageUsageFlags::TRANSFER_DST
            } else {
                vk::ImageUsageFlags::empty()
            },
        )?;

        let make_view = |image: &ImageWithMemory<'_>, format: vk::Format, base_layer: u32| {
            let range = vk::ImageSubresourceRange {
                aspect_mask: aspect_flags_for_format(format),
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: base_layer,
                layer_count: c.view_layers,
            };
            let view_type = if c.view_layers > 1 { vk::ImageViewType::_2D_ARRAY } else { vk::ImageViewType::_2D };
            make_image_view(device, image.get(), view_type, format, range)
        };
        let multisample_view = make_view(&multisample_image, c.format, 0)?;
        let singlesample_view = make_view(&singlesample_image, resolve_format, c.resolve_base_layer)?;

        let num_render_passes = c.num_render_passes();
        let mut render_passes = Vec::with_capacity(num_render_passes as usize);
        for pass in 0..num_render_passes {
            render_passes.push(self.create_render_pass(c.format, pass)?);
        }
        // `createRenderPassCompatible`: the compatibility cases render through a pass that
        // declares the resolve attachment with the *original* format while the framebuffer
        // is built against one declaring the size-compatible format the view actually has.
        let render_pass_compatible = c.compatible_format.map(|f| self.create_render_pass(f, 0)).transpose()?;
        let framebuffer_render_pass = render_pass_compatible.as_ref().unwrap_or(&render_passes[0]);

        let framebuffer = make_framebuffer(
            device,
            **framebuffer_render_pass,
            &[*multisample_view, *singlesample_view],
            c.width,
            c.height,
            c.view_layers,
        )?;

        // The stencil path pushes the sample index it is drawing for.
        let push_constant_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        };
        let pipeline_layout = {
            let info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(std::slice::from_ref(&push_constant_range));
            let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
            Unique::new(device, handle)
        };

        let programs = self.context.get_binary_collection();
        let vert = create_shader_module(device, programs.get("quad_vert")?)?;
        let geom = (c.image_layers > 1)
            .then(|| programs.get("quad_geom"))
            .transpose()?
            .map(|b| create_shader_module(device, b))
            .transpose()?;
        let frag_name = if testing_depth {
            "quad_frag_depth"
        } else if c.sample_mask {
            "quad_frag_stencil_sample_mask"
        } else {
            "quad_frag_stencil"
        };
        let frag = create_shader_module(device, programs.get(frag_name)?)?;

        let mut pipelines = Vec::with_capacity(num_render_passes as usize);
        for pass in 0..num_render_passes {
            pipelines.push(self.create_render_pipeline(*render_passes[pass as usize], pass, *pipeline_layout, *vert, geom.as_deref().copied(), *frag)?);
        }

        let buffer_size = (c.width * c.height * c.view_layers) as vk::DeviceSize * pixel_step(resolve_format, testing_depth) as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        self.submit(
            queue,
            queue_family_index,
            &render_passes,
            render_pass_compatible.as_deref().copied(),
            &pipelines,
            *pipeline_layout,
            *framebuffer,
            singlesample_image.get(),
            multisample_image.get(),
            buffer.get(),
            testing_depth,
        )?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let bytes = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), buffer_size as usize) };

        let ok = if testing_depth {
            self.verify_depth(bytes, resolve_format)
        } else {
            self.verify_stencil(bytes)
        };

        if ok {
            Ok(crate::tcu::TestStatus::pass("Pass"))
        } else {
            Ok(crate::tcu::TestStatus::fail("Fail"))
        }
    }
}

/// The bytes one value occupies in the readback buffer.
fn pixel_step(format: vk::Format, testing_depth: bool) -> u32 {
    if !testing_depth {
        return 1;
    }
    match format {
        vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => 2,
        _ => 4,
    }
}

impl DepthStencilResolveInstance<'_> {
    /// `createRenderPipeline`. Depth writes go through gl_FragDepth at sample rate, so
    /// each sample can be given a different value; stencil takes a dynamic reference
    /// because only one value can be written per pass.
    #[allow(clippy::too_many_arguments)]
    fn create_render_pipeline(
        &self,
        render_pass: vk::RenderPass,
        render_pass_no: u32,
        pipeline_layout: vk::PipelineLayout,
        vert: vk::ShaderModule,
        geom: Option<vk::ShaderModule>,
        frag: vk::ShaderModule,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let testing_depth = c.verify_buffer == VerifyBuffer::Depth;

        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let mut stages = vec![stage(vk::ShaderStageFlags::VERTEX, vert)];
        if let Some(module) = geom {
            stages.push(stage(vk::ShaderStageFlags::GEOMETRY, module));
        }
        stages.push(stage(vk::ShaderStageFlags::FRAGMENT, frag));

        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: c.width as f32,
            height: c.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [c.render_area];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);

        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);

        // One pass per sample, each writing only its own sample.
        let sample_mask = [if render_pass_no < 32 { 1u32 << render_pass_no } else { 0 }, 0];
        let mut multisample = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(sample_count_bit(c.sample_count))
            .sample_shading_enable(true)
            .min_sample_shading(1.0);
        if c.sample_mask {
            multisample = multisample.sample_mask(&sample_mask);
        }

        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::REPLACE,
            pass_op: vk::StencilOp::REPLACE,
            depth_fail_op: vk::StencilOp::REPLACE,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0xFF,
            write_mask: 0xFF,
            reference: 0,
        };
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .stencil_test_enable(!testing_depth)
            .front(stencil_op)
            .back(stencil_op)
            .max_depth_bounds(1.0);

        let dynamic_states = [vk::DynamicState::STENCIL_REFERENCE];
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder();

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0);
        if !testing_depth {
            info = info.dynamic_state(&dynamic_state);
        }

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `submit`
    #[allow(clippy::too_many_arguments)]
    fn submit(
        &self,
        queue: vk::Queue,
        queue_family_index: u32,
        render_passes: &[Unique<'_, vk::RenderPass>],
        render_pass_compatible: Option<vk::RenderPass>,
        pipelines: &[Unique<'_, vk::Pipeline>],
        pipeline_layout: vk::PipelineLayout,
        framebuffer: vk::Framebuffer,
        singlesample_image: vk::Image,
        multisample_image: vk::Image,
        buffer: vk::Buffer,
        testing_depth: bool,
    ) -> Result<(), TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let command_pool = make_command_pool(device, queue_family_index)?;

        // An unused resolve attachment is never written by the render pass, so it has
        // to be cleared beforehand or it holds nothing in particular.
        if c.unused_resolve {
            let cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
            let range = vk::ImageSubresourceRange {
                aspect_mask: c.resolve_aspect_flags(),
                base_mip_level: 0,
                level_count: vk::REMAINING_MIP_LEVELS,
                base_array_layer: 0,
                layer_count: vk::REMAINING_ARRAY_LAYERS,
            };
            let barrier = |src: vk::AccessFlags, dst: vk::AccessFlags, old: vk::ImageLayout, new: vk::ImageLayout| {
                vk::ImageMemoryBarrier::builder()
                    .src_access_mask(src)
                    .dst_access_mask(dst)
                    .old_layout(old)
                    .new_layout(new)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .image(singlesample_image)
                    .subresource_range(range)
                    .build()
            };
            begin_command_buffer(device, *cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    )],
                );
                device.cmd_clear_depth_stencil_image(*cmd, singlesample_image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &c.clear_value, &[range]);
                device.cmd_pipeline_barrier(
                    *cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::empty(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    )],
                );
            }
            end_command_buffer(device, *cmd)?;
            submit_commands_and_wait(device, queue, *cmd)?;
        }

        let cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        let clear_values = [vk::ClearValue { depth_stencil: c.clear_value }, vk::ClearValue { depth_stencil: c.clear_value }];
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: c.width, height: c.height },
        };

        if testing_depth {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass_compatible.unwrap_or(*render_passes[0]))
                .framebuffer(framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            let subpass_end = vk::SubpassEndInfo::builder();
            unsafe {
                use vulkanalia::vk::DeviceV1_2;
                device.cmd_begin_render_pass2(*cmd, &begin_info, &subpass_begin);
                device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipelines[0]);
                device.cmd_draw(*cmd, 6, 1, 0, 0);
                device.cmd_end_render_pass2(*cmd, &subpass_end);
            }
        } else {
            // Stencil takes one reference value per pass, so every sample needs its own
            // pass; the first half of the samples get 1 and the second half 255, which
            // is what makes min and max distinguishable.
            let half = c.sample_count >> 1;
            for i in 0..c.sample_count {
                let opens_pass = i == 0 || c.sample_mask;
                if opens_pass {
                    if i > 0 {
                        let barrier = vk::ImageMemoryBarrier::builder()
                            .src_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                            .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ)
                            .old_layout(if c.separate_depth_stencil_layouts {
                                vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL
                            } else {
                                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
                            })
                            .new_layout(if c.separate_depth_stencil_layouts {
                                vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL
                            } else {
                                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
                            })
                            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                            .image(multisample_image)
                            .subresource_range(vk::ImageSubresourceRange {
                                aspect_mask: if c.separate_depth_stencil_layouts {
                                    vk::ImageAspectFlags::STENCIL
                                } else {
                                    aspect_flags_for_format(c.format)
                                },
                                base_mip_level: 0,
                                level_count: 1,
                                base_array_layer: 0,
                                layer_count: c.view_layers,
                            });
                        unsafe {
                            device.cmd_pipeline_barrier(
                                *cmd,
                                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                                vk::DependencyFlags::empty(),
                                &[] as &[vk::MemoryBarrier],
                                &[] as &[vk::BufferMemoryBarrier],
                                &[barrier],
                            );
                        }
                    }

                    let begin_info = vk::RenderPassBeginInfo::builder()
                        .render_pass(render_pass_compatible.unwrap_or(*render_passes[if c.sample_mask { i as usize } else { 0 }]))
                        .framebuffer(framebuffer)
                        .render_area(render_area)
                        .clear_values(&clear_values);
                    let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                    unsafe {
                        use vulkanalia::vk::DeviceV1_2;
                        device.cmd_begin_render_pass2(*cmd, &begin_info, &subpass_begin);
                    }
                }

                let stencil_reference = 1 + 254 * u32::from(i >= half);
                unsafe {
                    device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipelines[if c.sample_mask { i as usize } else { 0 }]);
                    device.cmd_push_constants(*cmd, pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &i.to_ne_bytes());
                    device.cmd_set_stencil_reference(*cmd, vk::StencilFaceFlags::FRONT_AND_BACK, stencil_reference);
                    device.cmd_draw(*cmd, 6, 1, 0, 0);
                }

                if i == c.sample_count - 1 || c.sample_mask {
                    let subpass_end = vk::SubpassEndInfo::builder();
                    unsafe {
                        use vulkanalia::vk::DeviceV1_2;
                        device.cmd_end_render_pass2(*cmd, &subpass_end);
                    }
                }
            }
        }

        // A depth/stencil *resolve* is synchronised as a colour attachment write, which
        // is what the spec says even though nothing here has a colour attachment.
        let barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
            .old_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(singlesample_image)
            .subresource_range(vk::ImageSubresourceRange {
                aspect_mask: if c.separate_depth_stencil_layouts {
                    if testing_depth { vk::ImageAspectFlags::DEPTH } else { vk::ImageAspectFlags::STENCIL }
                } else {
                    c.resolve_aspect_flags()
                },
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: c.view_layers,
            });
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let region = vk::BufferImageCopy::builder()
                .buffer_offset(0)
                .buffer_row_length(0)
                .buffer_image_height(0)
                .image_subresource(vk::ImageSubresourceLayers {
                    aspect_mask: if testing_depth { vk::ImageAspectFlags::DEPTH } else { vk::ImageAspectFlags::STENCIL },
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: c.view_layers,
                })
                .image_offset(vk::Offset3D { x: 0, y: 0, z: 0 })
                .image_extent(vk::Extent3D {
                    width: c.width,
                    height: c.height,
                    depth: 1,
                });
            device.cmd_copy_image_to_buffer(*cmd, singlesample_image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]);
        }

        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, queue, *cmd)?;
        Ok(())
    }
}

impl DepthStencilResolveInstance<'_> {
    /// Whether a value at this index falls inside the render area. Everything outside it
    /// was only ever cleared, and must still hold the clear value.
    fn inside_render_area(&self, value_index: u32) -> bool {
        let c = &self.config;
        let layer_size = c.width * c.height;
        let in_layer = value_index % layer_size;
        let x = (in_layer % c.width) as i32;
        let y = ((in_layer - in_layer % c.width) / c.width) as i32;
        let x1 = c.render_area.offset.x;
        let y1 = c.render_area.offset.y;
        let x2 = x1 + c.render_area.extent.width as i32;
        let y2 = y1 + c.render_area.extent.height as i32;
        x >= x1 && x < x2 && y >= y1 && y < y2
    }

    /// `verifyDepth`. The buffer holds depth tightly packed, so it is read by hand -
    /// a texture accessor cannot interpret a format that is depth only.
    fn verify_depth(&self, bytes: &[u8], format: vk::Format) -> bool {
        let c = &self.config;
        let expected = if c.depth_resolve_mode == vk::ResolveModeFlags::NONE || c.unused_resolve {
            c.clear_value.depth
        } else {
            c.depth_expected_value
        };

        let (step, get) = match format {
            vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D24_UNORM_S8_UINT => {
                (4usize, (|b: &[u8]| (u32::from_le_bytes([b[0], b[1], b[2], 0])) as f32 / 16777215.0) as fn(&[u8]) -> f32)
            }
            vk::Format::D32_SFLOAT | vk::Format::D32_SFLOAT_S8_UINT => (4usize, (|b: &[u8]| f32::from_le_bytes([b[0], b[1], b[2], b[3]])) as fn(&[u8]) -> f32),
            _ => (2usize, (|b: &[u8]| u16::from_le_bytes([b[0], b[1]]) as f32 / 65535.0) as fn(&[u8]) -> f32),
        };

        const EPSILON: f32 = 0.002;
        let values_count = c.width * c.height * c.view_layers;
        for value_index in 0..values_count {
            let offset = value_index as usize * step;
            if offset + step > bytes.len() {
                return false;
            }
            let depth = get(&bytes[offset..]);
            let want = if self.inside_render_area(value_index) { expected } else { c.clear_value.depth };
            if (depth - want).abs() > EPSILON {
                return false;
            }
        }
        true
    }

    /// `verifyStencil`
    fn verify_stencil(&self, bytes: &[u8]) -> bool {
        let c = &self.config;
        let expected = if c.stencil_resolve_mode == vk::ResolveModeFlags::NONE || c.unused_resolve {
            c.clear_value.stencil as u8
        } else {
            c.stencil_expected_value
        };

        let values_count = c.width * c.height * c.view_layers;
        for value_index in 0..values_count {
            let Some(&stencil) = bytes.get(value_index as usize) else {
                return false;
            };
            let want = if self.inside_render_area(value_index) { expected } else { c.clear_value.stencil as u8 };
            if stencil != want {
                return false;
            }
        }
        true
    }
}

/// `MiscTestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum MiscTestType {
    Properties,
    ResolveStencilAspectThatIsNotPresent,
    ResolveDepthAspectThatIsNotPresent,
}

/// `MiscTestCase`
struct MiscTestCase {
    name: &'static str,
    test_type: MiscTestType,
}

/// The format features both non-present-aspect cases need out of the format they pick.
const MISC_FORMAT_REQUIREMENTS: vk::FormatFeatureFlags =
    vk::FormatFeatureFlags::from_bits_truncate(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT.bits() | vk::FormatFeatureFlags::TRANSFER_SRC.bits());

impl TestCase for MiscTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `MiscTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        use vulkanalia::vk::InstanceV1_0;

        context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;

        let optimal_features = |format: vk::Format| unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
                .optimal_tiling_features
        };

        match self.test_type {
            MiscTestType::ResolveStencilAspectThatIsNotPresent => {
                // Resolving stencil deliberately uses a depth-only format.
                if !optimal_features(vk::Format::D16_UNORM).contains(MISC_FORMAT_REQUIREMENTS) || !optimal_features(vk::Format::D32_SFLOAT).contains(MISC_FORMAT_REQUIREMENTS) {
                    return Err(TestError::NotSupported("Required depth format properties not supported".into()));
                }
            }
            MiscTestType::ResolveDepthAspectThatIsNotPresent => {
                // Resolving depth deliberately uses a stencil-only format.
                if !optimal_features(vk::Format::S8_UINT).contains(MISC_FORMAT_REQUIREMENTS) {
                    return Err(TestError::NotSupported("Required stencil format properties not supported".into()));
                }
            }
            MiscTestType::Properties => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::renderpass_ds_resolve::DS_RESOLVE_MISC_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        match self.test_type {
            MiscTestType::Properties => Box::new(PropertiesInstance { context }),
            test_type => Box::new(ResolveNonPresentAspectInstance { context, test_type }),
        }
    }
}

/// `PropertiesTestInstance`
struct PropertiesInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for PropertiesInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::InstanceV1_1;

        let mut dsr_properties = vk::PhysicalDeviceDepthStencilResolveProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut dsr_properties);
        unsafe {
            self.context
                .get_instance()
                .get_physical_device_properties2(self.context.get_physical_device(), &mut properties2)
        };

        if !dsr_properties.supported_depth_resolve_modes.contains(vk::ResolveModeFlags::SAMPLE_ZERO) {
            return Ok(crate::tcu::TestStatus::fail(
                "supportedDepthResolveModes does not include VK_RESOLVE_MODE_SAMPLE_ZERO_BIT_KHR",
            ));
        }
        if !dsr_properties.supported_stencil_resolve_modes.contains(vk::ResolveModeFlags::SAMPLE_ZERO) {
            return Ok(crate::tcu::TestStatus::fail(
                "supportedStencilResolveModes does not include VK_RESOLVE_MODE_SAMPLE_ZERO_BIT_KHR",
            ));
        }
        if dsr_properties.supported_stencil_resolve_modes.contains(vk::ResolveModeFlags::AVERAGE) {
            return Ok(crate::tcu::TestStatus::fail(
                "supportedStencilResolveModes includes forbidden VK_RESOLVE_MODE_AVERAGE_BIT_KHR",
            ));
        }
        if dsr_properties.independent_resolve == vk::TRUE && dsr_properties.independent_resolve_none != vk::TRUE {
            return Ok(crate::tcu::TestStatus::fail("independentResolve supported but independentResolveNone not supported"));
        }
        Ok(crate::tcu::TestStatus::pass("Pass"))
    }
}

/// `ResolveNonPresentAspectTestInstance`. Naming a resolve mode for an aspect the format
/// does not have must be ignored, not crash and not disturb the aspect that is there.
struct ResolveNonPresentAspectInstance<'a> {
    context: &'a Context<'a>,
    test_type: MiscTestType,
}

const MISC_RENDER_SIZE: u32 = 16;

impl ResolveNonPresentAspectInstance<'_> {
    /// `createDepthPass`
    fn create_depth_pass(
        &self,
        enable_depth_stencil_write: bool,
        format: vk::Format,
        image_aspect: vk::ImageAspectFlags,
        depth_resolve_mode: vk::ResolveModeFlags,
        stencil_resolve_mode: vk::ResolveModeFlags,
    ) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::DeviceV1_2;

        let device = self.context.get_device();

        let multisample_ref = vk::AttachmentReference2::builder()
            .attachment(0)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .aspect_mask(image_aspect)
            .build();
        let singlesample_ref = vk::AttachmentReference2::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .aspect_mask(image_aspect)
            .build();

        let mut resolve_description = vk::SubpassDescriptionDepthStencilResolve::builder()
            .depth_resolve_mode(depth_resolve_mode)
            .stencil_resolve_mode(stencil_resolve_mode)
            .depth_stencil_resolve_attachment(&singlesample_ref);
        let subpass = vk::SubpassDescription2::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .depth_stencil_attachment(&multisample_ref)
            .push_next(&mut resolve_description)
            .build();
        let subpasses = [subpass];

        // Without depth/stencil writes the pass only has to resolve what the previous one left.
        let (ms_load_op, ms_initial_layout, ms_final_layout, ss_load_op) = if enable_depth_stencil_write {
            (
                vk::AttachmentLoadOp::CLEAR,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
            )
        } else {
            (
                vk::AttachmentLoadOp::LOAD,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AttachmentLoadOp::DONT_CARE,
            )
        };

        let attachments = [
            vk::AttachmentDescription2::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_4)
                .load_op(ms_load_op)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(ms_load_op)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(ms_initial_layout)
                .final_layout(ms_final_layout)
                .build(),
            vk::AttachmentDescription2::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(ss_load_op)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(ss_load_op)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .build(),
        ];

        let info = vk::RenderPassCreateInfo2::builder().attachments(&attachments).subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass2(&info, None) }.vk_check("vkCreateRenderPass2")?;
        Ok(Unique::new(device, handle))
    }

    #[allow(clippy::too_many_arguments)]
    fn create_pipeline(
        &self,
        pipeline_layout: vk::PipelineLayout,
        vert: vk::ShaderModule,
        frag: vk::ShaderModule,
        render_pass: vk::RenderPass,
        depth_test_enable: bool,
        depth_write_enable: bool,
        stencil_test_enable: bool,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let stages = [stage(vk::ShaderStageFlags::VERTEX, vert), stage(vk::ShaderStageFlags::FRAGMENT, frag)];

        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: MISC_RENDER_SIZE as f32,
            height: MISC_RENDER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [rect(0, 0, MISC_RENDER_SIZE, MISC_RENDER_SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);

        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);

        let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_4)
            .min_sample_shading(1.0);

        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::INCREMENT_AND_CLAMP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0xFF,
            write_mask: 0xFF,
            reference: 0,
        };
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(depth_test_enable)
            .depth_write_enable(depth_write_enable)
            .depth_compare_op(vk::CompareOp::GREATER)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(stencil_test_enable)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder();

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0);

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }
}

impl TestInstance for ResolveNonPresentAspectInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::{DeviceV1_0, DeviceV1_2, InstanceV1_0};

        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let try_resolving_stencil = self.test_type == MiscTestType::ResolveStencilAspectThatIsNotPresent;
        let extent = vk::Extent3D {
            width: MISC_RENDER_SIZE,
            height: MISC_RENDER_SIZE,
            depth: 1,
        };

        // Resolving the aspect that is not there is asked for with SAMPLE_ZERO, which
        // every implementation supports for the aspect that is.
        let used_resolve_mode = vk::ResolveModeFlags::SAMPLE_ZERO;
        let image_aspect = if try_resolving_stencil {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::STENCIL
        };

        let test_format = if try_resolving_stencil {
            let d16_features = unsafe {
                self.context
                    .get_instance()
                    .get_physical_device_format_properties(self.context.get_physical_device(), vk::Format::D16_UNORM)
                    .optimal_tiling_features
            };
            if d16_features.contains(MISC_FORMAT_REQUIREMENTS) {
                vk::Format::D16_UNORM
            } else {
                vk::Format::D32_SFLOAT
            }
        } else {
            vk::Format::S8_UINT
        };
        let pixel_size = match test_format {
            vk::Format::S8_UINT => 1usize,
            vk::Format::D16_UNORM => 2,
            _ => 4,
        };

        let srr = vk::ImageSubresourceRange {
            aspect_mask: image_aspect,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };

        let image_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let make_image = |samples: vk::SampleCountFlags| {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(test_format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(image_usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)
        };

        let multisampled_image = make_image(vk::SampleCountFlags::_4)?;
        let multisampled_view = make_image_view(device, multisampled_image.get(), vk::ImageViewType::_2D, test_format, srr)?;

        // `ImageWithBuffer` - a single-sampled image and the host-visible buffer it is read back into.
        let buffer_size = (MISC_RENDER_SIZE * MISC_RENDER_SIZE) as vk::DeviceSize * pixel_size as vk::DeviceSize;
        let make_image_with_buffer = || -> Result<(ImageWithMemory<'_>, Unique<'_, vk::ImageView>, BufferWithMemory<'_>), TestError> {
            let image = make_image(vk::SampleCountFlags::_1)?;
            let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, test_format, srr)?;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            Ok((image, view, buffer))
        };
        let (image_a, view_a, buffer_a) = make_image_with_buffer()?;
        let (image_b, view_b, buffer_b) = make_image_with_buffer()?;

        let programs = self.context.get_binary_collection();
        let vert = create_shader_module(device, programs.get("vert")?)?;
        let frag = create_shader_module(device, programs.get("frag")?)?;
        let pipeline_layout = {
            let info = vk::PipelineLayoutCreateInfo::builder();
            let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
            Unique::new(device, handle)
        };

        let render_pass_a = self.create_depth_pass(true, test_format, image_aspect, used_resolve_mode, used_resolve_mode)?;
        let framebuffer_a = make_framebuffer(device, *render_pass_a, &[*multisampled_view, *view_a], MISC_RENDER_SIZE, MISC_RENDER_SIZE, 1)?;
        let pipeline_a = self.create_pipeline(
            *pipeline_layout,
            *vert,
            *frag,
            *render_pass_a,
            try_resolving_stencil,
            try_resolving_stencil,
            !try_resolving_stencil,
        )?;

        // The second pass only resolves what the first one left in the multisample image.
        let render_pass_b = self.create_depth_pass(false, test_format, image_aspect, used_resolve_mode, used_resolve_mode)?;
        let framebuffer_b = make_framebuffer(device, *render_pass_b, &[*multisampled_view, *view_b], MISC_RENDER_SIZE, MISC_RENDER_SIZE, 1)?;
        let pipeline_b = self.create_pipeline(*pipeline_layout, *vert, *frag, *render_pass_b, try_resolving_stencil, false, !try_resolving_stencil)?;

        let command_pool = make_command_pool(device, queue_family_index)?;
        let cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        let render_area = rect(0, 0, MISC_RENDER_SIZE, MISC_RENDER_SIZE);
        let clear_values = [vk::ClearValue { depth_stencil: clear(0.0, 1) }, vk::ClearValue { depth_stencil: clear(0.2, 2) }];
        let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
        let subpass_end = vk::SubpassEndInfo::builder();

        unsafe {
            let begin_a = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass_a)
                .framebuffer(*framebuffer_a)
                .render_area(render_area)
                .clear_values(&clear_values);
            device.cmd_begin_render_pass2(*cmd, &begin_a, &subpass_begin);
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_a);
            device.cmd_draw(*cmd, 3, 1, 0, 0);
            device.cmd_end_render_pass2(*cmd, &subpass_end);

            let inbetween = make_memory_barrier(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE, vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ);
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[inbetween],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            let begin_b = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass_b)
                .framebuffer(*framebuffer_b)
                .render_area(render_area);
            device.cmd_begin_render_pass2(*cmd, &begin_b, &subpass_begin);
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_b);
            device.cmd_draw(*cmd, 3, 1, 0, 0);
            device.cmd_end_render_pass2(*cmd, &subpass_end);

            let before_copy = make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[before_copy],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            let region = make_buffer_image_copy(extent, make_image_subresource_layers(image_aspect, 0, 0, 1));
            device.cmd_copy_image_to_buffer(*cmd, image_a.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer_a.get(), &[region]);
            device.cmd_copy_image_to_buffer(*cmd, image_b.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer_b.get(), &[region]);
        }

        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, queue, *cmd)?;

        invalidate_alloc(device, buffer_a.get_allocation())?;
        invalidate_alloc(device, buffer_b.get_allocation())?;
        let bytes_a = unsafe { std::slice::from_raw_parts(buffer_a.get_allocation().get_host_ptr(), buffer_size as usize) };
        let bytes_b = unsafe { std::slice::from_raw_parts(buffer_b.get_allocation().get_host_ptr(), buffer_size as usize) };

        // The triangle only covers the lower-left half, so only the four bottom-left
        // fragments are known to have been rendered to.
        let sample_positions = || (0..2u32).flat_map(|x| (MISC_RENDER_SIZE - 2..MISC_RENDER_SIZE).map(move |y| (x, y)));

        if try_resolving_stencil {
            const EXPECTED: f32 = 0.60;
            const EPSILON: f32 = 0.02;
            let get_depth = |bytes: &[u8], x: u32, y: u32| {
                let offset = (y * MISC_RENDER_SIZE + x) as usize * pixel_size;
                let b = &bytes[offset..];
                if test_format == vk::Format::D16_UNORM {
                    u16::from_le_bytes([b[0], b[1]]) as f32 / 65535.0
                } else {
                    f32::from_le_bytes([b[0], b[1], b[2], b[3]])
                }
            };
            for (x, y) in sample_positions() {
                if (get_depth(bytes_a, x, y) - EXPECTED).abs() > EPSILON {
                    return Ok(crate::tcu::TestStatus::fail("Wrong value after resolving non-existing stencil aspect in renderpassA"));
                }
                if (get_depth(bytes_b, x, y) - EXPECTED).abs() > EPSILON {
                    return Ok(crate::tcu::TestStatus::fail("Wrong value after resolving depth in renderpassB"));
                }
            }
        } else {
            for (x, y) in sample_positions() {
                let offset = (y * MISC_RENDER_SIZE + x) as usize;
                if bytes_a[offset] != 2 {
                    return Ok(crate::tcu::TestStatus::fail("Wrong value after resolving non-existing depth aspect in renderpassA"));
                }
                if bytes_b[offset] != 3 {
                    return Ok(crate::tcu::TestStatus::fail("Wrong value after resolving stencil in renderpassB"));
                }
            }
        }

        Ok(crate::tcu::TestStatus::pass("Pass"))
    }
}
