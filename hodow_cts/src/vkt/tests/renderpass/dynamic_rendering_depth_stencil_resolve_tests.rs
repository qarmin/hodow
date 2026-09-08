// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/renderpass/
// vktDynamicRenderingDepthStencilResolveTests.cpp
//
// The renderpass2 sibling of this test lives in `depth_stencil_resolve_tests.rs`;
// upstream keeps the two in separate files even though they check the same thing,
// because the resolve is requested through `VkRenderingAttachmentInfo` here and
// through `VkSubpassDescriptionDepthStencilResolve` there. The case trees differ too:
// this one has a single image size and no unused-resolve, compatibility or sample-mask
// variants, and adds a push-constant corner case.

use vulkanalia::vk::{self, Handle, HasBuilder};

use crate::tcu::TestError;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::{Unique, VkResultExt};
use crate::vkt::tests::renderpass::group_params::GroupParams;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `VerifyBuffer`
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
    /// Written by `initTests` and never read, exactly as upstream; the instance derives
    /// the aspects it needs from the format instead.
    #[allow(dead_code)]
    pub aspect_flag: vk::ImageAspectFlags,
    pub sample_count: u32,
    pub depth_resolve_mode: vk::ResolveModeFlags,
    pub stencil_resolve_mode: vk::ResolveModeFlags,
    pub verify_buffer: VerifyBuffer,
    pub clear_value: vk::ClearDepthStencilValue,
    pub depth_expected_value: f32,
    pub stencil_expected_value: u8,
    pub separate_depth_stencil_layouts: bool,
    pub group_params: GroupParams,
    pub enable_push_consts: bool,
}

/// The program set every case shares; which shaders it uses is decided at pipeline
/// creation from the aspect under test and whether it is the push-constant case.
pub struct DrDsResolvePrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
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

/// `sampleCountBitFromSampleCount`
fn sample_count_bit(count: u32) -> vk::SampleCountFlags {
    match count {
        1 => vk::SampleCountFlags::_1,
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        16 => vk::SampleCountFlags::_16,
        32 => vk::SampleCountFlags::_32,
        64 => vk::SampleCountFlags::_64,
        other => panic!("Invalid sample count: {other}"),
    }
}

struct DepthStencilResolveTestCase {
    name: String,
    config: TestConfig,
}

impl TestCase for DepthStencilResolveTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        use vulkanalia::vk::{InstanceV1_0, InstanceV1_1};

        let c = &self.config;

        context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;

        if context.get_device_features().sample_rate_shading != vk::TRUE {
            return Err(TestError::NotSupported("sampleRateShading not supported".into()));
        }

        if c.image_layers > 1 && context.get_device_features().geometry_shader != vk::TRUE {
            return Err(TestError::NotSupported("geometryShader not supported".into()));
        }

        if c.separate_depth_stencil_layouts {
            context.require_device_functionality("VK_KHR_separate_depth_stencil_layouts")?;
        }

        let mut ds_resolve_properties = vk::PhysicalDeviceDepthStencilResolveProperties::default();
        let mut device_properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut ds_resolve_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut device_properties)
        };

        let depth_resolve_mode = c.depth_resolve_mode;
        let stencil_resolve_mode = c.stencil_resolve_mode;

        if depth_resolve_mode != vk::ResolveModeFlags::NONE && !ds_resolve_properties.supported_depth_resolve_modes.contains(depth_resolve_mode) {
            return Err(TestError::NotSupported("Depth resolve mode not supported".into()));
        }
        if stencil_resolve_mode != vk::ResolveModeFlags::NONE && !ds_resolve_properties.supported_stencil_resolve_modes.contains(stencil_resolve_mode) {
            return Err(TestError::NotSupported("Stencil resolve mode not supported".into()));
        }

        // Unlike the renderpass2 sibling, this check does not look at which aspects the
        // format has: a depth-only format still needs independentResolveNone to pair a
        // real depth mode with a NONE stencil mode.
        if ds_resolve_properties.independent_resolve_none == vk::TRUE {
            if ds_resolve_properties.independent_resolve != vk::TRUE
                && depth_resolve_mode != stencil_resolve_mode
                && depth_resolve_mode != vk::ResolveModeFlags::NONE
                && stencil_resolve_mode != vk::ResolveModeFlags::NONE
            {
                return Err(TestError::NotSupported("Implementation doesn't support diferent resolve modes".into()));
            }
        } else if ds_resolve_properties.independent_resolve != vk::TRUE && depth_resolve_mode != stencil_resolve_mode {
            return Err(TestError::NotSupported("Implementation doesn't support diferent resolve modes".into()));
        }

        let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let image_format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                c.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format not supported".into()))?;

        // Upstream compares the sample-count *mask* against the sample count as if it
        // were a number; keeping the same comparison keeps the same verdicts.
        if image_format_properties.sample_counts.bits() < c.sample_count {
            return Err(TestError::NotSupported("Sample count not supported".into()));
        }
        if image_format_properties.max_array_layers < c.image_layers {
            return Err(TestError::NotSupported("Layers count not supported".into()));
        }

        if !has_depth(c.format) && !has_stencil(c.format) {
            return Err(TestError::NotSupported("Format can't be used as depth/stencil attachment".into()));
        }

        if image_format_properties.max_extent.width < c.width
            || image_format_properties.max_extent.height < c.height
            || !image_format_properties.sample_counts.contains(sample_count_bit(c.sample_count))
            || image_format_properties.max_array_layers < c.image_layers
        {
            return Err(TestError::NotSupported("Image type not supported".into()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::renderpass_dr_ds_resolve::DR_DS_RESOLVE_PROGRAMS.programs
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

/// `initTests`. 1D and 3D images are absent on purpose: a non-2D image reports only one
/// sample count, and a framebuffer may not take a depth/stencil view out of a 3D image.
pub fn create_dynamic_rendering_depth_stencil_resolve_tests(group_params: GroupParams) -> TestCaseGroup {
    // `imageData`. The group name it carries is unused here - the sample-count group is
    // the top level of this tree, where the renderpass2 sibling has an image-size group
    // above it.
    let width = 32;
    let height = 32;
    let render_area = vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D { width: 32, height: 32 },
    };
    let clear_value = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0x00 };

    let mut group = TestCaseGroup::new("depth_stencil_resolve");

    for (sample_count_ndx, sample_count) in SAMPLE_COUNTS.into_iter().enumerate() {
        let mut sample_group = TestCaseGroup::new(format!("samples_{sample_count}"));

        for format_data in &FORMATS {
            let mut aspect_flags = vk::ImageAspectFlags::empty();
            if format_data.has_depth {
                aspect_flags |= vk::ImageAspectFlags::DEPTH;
            }
            if format_data.has_stencil {
                aspect_flags |= vk::ImageAspectFlags::STENCIL;
            }
            let separate_layouts_loop_count = if format_data.has_depth && format_data.has_stencil { 2 } else { 1 };

            for separate in 0..separate_layouts_loop_count {
                let use_separate_depth_stencil_layouts = separate == 1;
                let group_name = format!("{}{}", format_data.name, if use_separate_depth_stencil_layouts { "_separate_layouts" } else { "" });
                let mut format_group = TestCaseGroup::new(group_name);

                for (depth_ndx, (depth_mode, depth_name)) in RESOLVE_MODES.into_iter().enumerate() {
                    for (stencil_ndx, (stencil_mode, stencil_name)) in RESOLVE_MODES.into_iter().enumerate() {
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

                        let base_name = format!("depth_{depth_name}_stencil_{stencil_name}");

                        let make_config = |verify: VerifyBuffer, image_layers: u32, enable_push_consts: bool| TestConfig {
                            format: format_data.format,
                            width,
                            height,
                            image_layers,
                            view_layers: image_layers,
                            resolve_base_layer: 0,
                            render_area,
                            aspect_flag: aspect_flags,
                            sample_count,
                            depth_resolve_mode: depth_mode,
                            stencil_resolve_mode: stencil_mode,
                            verify_buffer: verify,
                            clear_value,
                            depth_expected_value: if verify == VerifyBuffer::Depth {
                                DEPTH_EXPECTED_VALUE[depth_ndx][sample_count_ndx]
                            } else {
                                0.0
                            },
                            stencil_expected_value: if verify == VerifyBuffer::Depth {
                                0
                            } else {
                                STENCIL_EXPECTED_VALUE[stencil_ndx][sample_count_ndx]
                            },
                            separate_depth_stencil_layouts: use_separate_depth_stencil_layouts,
                            group_params,
                            enable_push_consts,
                        };

                        if format_data.has_depth {
                            format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                name: format!("{base_name}_testing_depth"),
                                config: make_config(VerifyBuffer::Depth, 1, false),
                            }) as Box<dyn crate::vkt::TestCase>);
                        }

                        if format_data.has_stencil {
                            format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                name: format!("{base_name}_testing_stencil"),
                                config: make_config(VerifyBuffer::Stencil, 1, false),
                            }) as Box<dyn crate::vkt::TestCase>);
                        }

                        // Corner case: first depth/stencil resolve with multisampled
                        // layered images and then rendering using push constants.
                        if format_data.has_depth
                            && !format_data.has_stencil
                            && depth_mode == vk::ResolveModeFlags::AVERAGE
                            && stencil_mode == vk::ResolveModeFlags::NONE
                            && !group_params.use_secondary_cmd_buffer
                        {
                            format_group.add_child(Box::new(DepthStencilResolveTestCase {
                                name: format!("{base_name}_testing_pushconsts"),
                                config: make_config(VerifyBuffer::Depth, 2, true),
                            }) as Box<dyn crate::vkt::TestCase>);
                        }
                    }
                }

                sample_group.add_child(format_group);
            }
        }

        group.add_child(sample_group);
    }

    group
}

/// `DepthStencilResolveTest`, plus `DepthStencilPushConstResolveTest`. Upstream makes
/// the second a subclass that overrides `submit` and `iterate`; here the two submit
/// paths are separate methods on one instance, because everything they share is created
/// in `iterate` rather than in a constructor.
struct DepthStencilResolveInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

/// The handles `submit` needs, standing in for the members upstream's constructor fills.
struct Resources {
    command_pool: vk::CommandPool,
    multisample_image: vk::Image,
    multisample_image_view: vk::ImageView,
    singlesample_image: vk::Image,
    singlesample_image_view: vk::ImageView,
    buffer: vk::Buffer,
    render_pipeline_layout: vk::PipelineLayout,
    render_pipeline: vk::Pipeline,
}

/// The extra objects the push-constant corner case adds, kept alive for the submission.
struct PushConstResources<'a> {
    color_image: ImageWithMemory<'a>,
    color_attachment_view: Unique<'a, vk::ImageView>,
    pc_pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pc_pipeline: Unique<'a, vk::Pipeline>,
    output_color_buffer: BufferWithMemory<'a>,
}

const PC_IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const PC_IMAGE_SIZE: u32 = 32;

impl TestInstance for DepthStencilResolveInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::DeviceV1_0;

        let c = self.config;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let command_pool = make_command_pool(device, queue_family_index)?;

        // `createImage`
        let make_image = |sample_count: u32, additional_usage: vk::ImageUsageFlags| -> Result<ImageWithMemory<'_>, TestError> {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(c.format)
                .extent(vk::Extent3D {
                    width: c.width,
                    height: c.height,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(c.image_layers)
                .samples(sample_count_bit(sample_count))
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | additional_usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)
        };

        let multisample_image = make_image(c.sample_count, vk::ImageUsageFlags::TRANSFER_SRC)?;
        let singlesample_image = make_image(1, vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)?;

        // `createImageView`
        let make_view = |image: &ImageWithMemory<'_>, base_array_layer: u32| {
            let range = vk::ImageSubresourceRange {
                aspect_mask: aspect_flags_for_format(c.format),
                base_mip_level: 0,
                level_count: 1,
                base_array_layer,
                layer_count: c.view_layers,
            };
            let view_type = if c.view_layers > 1 { vk::ImageViewType::_2D_ARRAY } else { vk::ImageViewType::_2D };
            make_image_view(device, image.get(), view_type, c.format, range)
        };
        let multisample_image_view = make_view(&multisample_image, 0)?;
        let singlesample_image_view = make_view(&singlesample_image, c.resolve_base_layer)?;

        // `createBuffer`
        let pixel_size = crate::tcu::map_vk_format(c.format)
            .and_then(|f| f.pixel_size())
            .ok_or_else(|| TestError::NotPorted(format!("no pixel size for {:?}", c.format)))?;
        let buffer_size = (c.width * c.height * c.image_layers * pixel_size) as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let render_pipeline_layout = self.create_render_pipeline_layout()?;
        let render_pipeline = self.create_render_pipeline(*render_pipeline_layout)?;

        let resources = Resources {
            command_pool: *command_pool,
            multisample_image: multisample_image.get(),
            multisample_image_view: *multisample_image_view,
            singlesample_image: singlesample_image.get(),
            singlesample_image_view: *singlesample_image_view,
            buffer: buffer.get(),
            render_pipeline_layout: *render_pipeline_layout,
            render_pipeline: *render_pipeline,
        };

        // The push-constant case keeps everything above and adds a colour pass after the
        // resolve; without it none of the objects below are created at all.
        let push_const = if c.enable_push_consts {
            let color_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(PC_IMAGE_FORMAT)
                .extent(vk::Extent3D {
                    width: PC_IMAGE_SIZE,
                    height: PC_IMAGE_SIZE,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let color_image = ImageWithMemory::new(device, allocator, color_info, MemoryRequirement::ANY)?;
            let color_attachment_view = make_image_view(
                device,
                color_image.get(),
                vk::ImageViewType::_2D,
                PC_IMAGE_FORMAT,
                vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                },
            )?;

            let pc_range = vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                offset: 0,
                size: std::mem::size_of::<[f32; 4]>() as u32,
            };
            let pc_pipeline_layout = {
                let info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(std::slice::from_ref(&pc_range));
                let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
                Unique::new(device, handle)
            };
            let pc_pipeline = self.create_push_const_pipeline(*pc_pipeline_layout)?;

            let output_buffer_size = (PC_IMAGE_SIZE * PC_IMAGE_SIZE * 4) as vk::DeviceSize;
            let output_color_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            Some(PushConstResources {
                color_image,
                color_attachment_view,
                pc_pipeline_layout,
                pc_pipeline,
                output_color_buffer,
            })
        } else {
            None
        };

        match &push_const {
            Some(pc) => self.submit_push_consts(queue, &resources, pc)?,
            None => self.submit(queue, &resources)?,
        }

        invalidate_alloc(device, buffer.get_allocation())?;
        let bytes = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), buffer_size as usize) };

        let result = if c.verify_buffer == VerifyBuffer::Depth {
            self.verify_depth(bytes)
        } else {
            self.verify_stencil(bytes)
        };

        let Some(pc) = &push_const else {
            return Ok(if result {
                crate::tcu::TestStatus::pass("Pass")
            } else {
                crate::tcu::TestStatus::fail("Fail")
            });
        };

        if !result {
            return Ok(crate::tcu::TestStatus::fail("Depth buffer test Fail"));
        }

        invalidate_alloc(device, pc.output_color_buffer.get_allocation())?;
        let pixels = unsafe { std::slice::from_raw_parts(pc.output_color_buffer.get_allocation().get_host_ptr(), (PC_IMAGE_SIZE * PC_IMAGE_SIZE * 4) as usize) };
        // `tcu::floatThresholdCompare` against a solid green reference with a zero
        // threshold, which for an 8-bit unorm format is exact equality.
        if pixels.as_chunks::<4>().0.iter().any(|&p| p != [0x00, 0xff, 0x00, 0xff]) {
            return Ok(crate::tcu::TestStatus::fail("Push constant test Fail"));
        }

        Ok(crate::tcu::TestStatus::pass("Pass"))
    }
}

impl DepthStencilResolveInstance<'_> {
    /// `createRenderPipelineLayout`
    fn create_render_pipeline_layout(&self) -> Result<Unique<'_, vk::PipelineLayout>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let push_constant = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 4,
        };
        let ranges: &[vk::PushConstantRange] = if self.config.verify_buffer == VerifyBuffer::Stencil {
            std::slice::from_ref(&push_constant)
        } else {
            &[]
        };

        let info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(ranges);
        let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
        Ok(Unique::new(device, handle))
    }

    /// `createRenderPipeline`
    fn create_render_pipeline(&self, render_pipeline_layout: vk::PipelineLayout) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let testing_stencil = c.verify_buffer == VerifyBuffer::Stencil;
        let binary_collection = self.context.get_binary_collection();

        let vertex_shader_module = create_shader_module(device, binary_collection.get("quad_vert")?)?;
        let fragment_shader_module = create_shader_module(device, binary_collection.get(if testing_stencil { "quad_frag_stencil" } else { "quad_frag_depth" })?)?;
        let geometry_shader_module = (c.image_layers != 1)
            .then(|| binary_collection.get("quad_geom"))
            .transpose()?
            .map(|b| create_shader_module(device, b))
            .transpose()?;

        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let mut stages = vec![stage(vk::ShaderStageFlags::VERTEX, *vertex_shader_module)];
        if let Some(module) = &geometry_shader_module {
            stages.push(stage(vk::ShaderStageFlags::GEOMETRY, **module));
        }
        stages.push(stage(vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module));

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);

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

        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);

        // Sample shading is off: the fragment shaders read gl_SampleID, which is what
        // forces per-sample invocation, and that is why checkSupport asks for
        // sampleRateShading even though nothing here sets sampleShadingEnable.
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(sample_count_bit(c.sample_count))
            .sample_shading_enable(false)
            .min_sample_shading(0.0);

        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::REPLACE,
            pass_op: vk::StencilOp::REPLACE,
            depth_fail_op: vk::StencilOp::REPLACE,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0xFF,
            write_mask: 0xFF,
            reference: 1,
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(testing_stencil)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let dynamic_states = [vk::DynamicState::STENCIL_REFERENCE];
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        // Upstream's `makeGraphicsPipeline` leaves the colour blend state at its default,
        // which declares one attachment; with dynamic rendering and no colour attachment
        // the count has to be zero (VUID-VkGraphicsPipelineCreateInfo-renderPass-06055).
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder();

        let format = c.format;
        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .depth_attachment_format(if has_depth(format) && c.verify_buffer == VerifyBuffer::Depth {
                format
            } else {
                vk::Format::UNDEFINED
            })
            .stencil_attachment_format(if has_stencil(format) && c.verify_buffer != VerifyBuffer::Depth {
                format
            } else {
                vk::Format::UNDEFINED
            });

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(render_pipeline_layout)
            .render_pass(vk::RenderPass::null())
            .subpass(0)
            .push_next(&mut rendering_create_info);
        if testing_stencil {
            info = info.dynamic_state(&dynamic_state);
        }

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// The second pipeline of `DepthStencilPushConstResolveTest`: a full-screen quad
    /// that writes whatever colour the push constant holds.
    fn create_push_const_pipeline(&self, pipeline_layout: vk::PipelineLayout) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let binary_collection = self.context.get_binary_collection();
        let vert_module = create_shader_module(device, binary_collection.get("vert_pc")?)?;
        let frag_module = create_shader_module(device, binary_collection.get("frag_pc")?)?;

        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let stages = [stage(vk::ShaderStageFlags::VERTEX, *vert_module), stage(vk::ShaderStageFlags::FRAGMENT, *frag_module)];

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: PC_IMAGE_SIZE as f32,
            height: PC_IMAGE_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: PC_IMAGE_SIZE,
                height: PC_IMAGE_SIZE,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);

        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);

        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .max_depth_bounds(1.0);

        let attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .color_write_mask(vk::ColorComponentFlags::R | vk::ColorComponentFlags::G | vk::ColorComponentFlags::B | vk::ColorComponentFlags::A)
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&attachments);

        let color_formats = [PC_IMAGE_FORMAT];
        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(vk::Format::UNDEFINED)
            .stencil_attachment_format(vk::Format::UNDEFINED);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(pipeline_layout)
            .render_pass(vk::RenderPass::null())
            .subpass(0)
            .push_next(&mut rendering_create_info);

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `beginSecondaryCommandBuffer`
    fn begin_secondary_command_buffer(&self, cmd_buffer: vk::CommandBuffer, attachment_type: VerifyBuffer, rendering_flags: vk::RenderingFlags) -> Result<(), TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let depth_format = if attachment_type == VerifyBuffer::Depth { c.format } else { vk::Format::UNDEFINED };
        let stencil_format = if attachment_type == VerifyBuffer::Stencil { c.format } else { vk::Format::UNDEFINED };

        let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
            .flags(rendering_flags)
            .view_mask(0)
            .depth_attachment_format(depth_format)
            .stencil_attachment_format(stencil_format)
            .rasterization_samples(sample_count_bit(c.sample_count));
        let inheritance_info = vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

        let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
        if !c.group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
            usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
        }

        let info = vk::CommandBufferBeginInfo::builder().flags(usage_flags).inheritance_info(&inheritance_info);
        unsafe { device.begin_command_buffer(cmd_buffer, &info) }.vk_check("vkBeginCommandBuffer")
    }

    /// The barriers and the resolve-image clear both submit paths start with, plus the
    /// copy to the readback buffer both end with, are shared here rather than repeated.
    fn clear_resolve_image(&self, queue: vk::Queue, r: &Resources) -> Result<(), TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let clear_cmd_buffer = allocate_command_buffer(device, r.command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *clear_cmd_buffer)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *clear_cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[self.pre_clear_barrier(r)],
            );
            device.cmd_clear_depth_stencil_image(
                *clear_cmd_buffer,
                r.singlesample_image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &self.config.clear_value,
                &[self.image_range()],
            );
        }
        end_command_buffer(device, *clear_cmd_buffer)?;
        submit_commands_and_wait(device, queue, *clear_cmd_buffer)
    }

    fn image_range(&self) -> vk::ImageSubresourceRange {
        vk::ImageSubresourceRange {
            aspect_mask: aspect_flags_for_format(self.config.format),
            base_mip_level: 0,
            level_count: vk::REMAINING_MIP_LEVELS,
            base_array_layer: 0,
            layer_count: vk::REMAINING_ARRAY_LAYERS,
        }
    }

    fn pre_clear_barrier(&self, r: &Resources) -> vk::ImageMemoryBarrier {
        vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(r.singlesample_image)
            .subresource_range(self.image_range())
            .build()
    }

    /// `preRenderBarriers`. VUID-vkCmdBeginRendering-pRenderingInfo-09588 is why the
    /// resolve image is moved out of TRANSFER_DST before the rendering starts.
    fn pre_render_barriers(&self, r: &Resources) -> [vk::ImageMemoryBarrier; 2] {
        let range = self.image_range();
        let singlesample = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
            .old_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
            .new_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(r.singlesample_image)
            .subresource_range(range)
            .build();
        let multisample = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(r.multisample_image)
            .subresource_range(range)
            .build();
        [singlesample, multisample]
    }

    /// `VkRenderingAttachmentInfo` for the aspect under test.
    fn rendering_attachment(&self, r: &Resources) -> vk::RenderingAttachmentInfo {
        let c = &self.config;
        vk::RenderingAttachmentInfo::builder()
            .image_view(r.multisample_image_view)
            .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .resolve_mode(if c.verify_buffer == VerifyBuffer::Depth {
                c.depth_resolve_mode
            } else {
                c.stencil_resolve_mode
            })
            .resolve_image_view(r.singlesample_image_view)
            .resolve_image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue { depth_stencil: c.clear_value })
            .build()
    }

    /// The barriers and the image-to-buffer copy that end every submission.
    fn copy_results_to_buffer(&self, cmd_buffer: vk::CommandBuffer, r: &Resources) {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let testing_depth = c.verify_buffer == VerifyBuffer::Depth;
        let aspect = if testing_depth { vk::ImageAspectFlags::DEPTH } else { vk::ImageAspectFlags::STENCIL };

        // A depth/stencil *resolve* is synchronised as a colour attachment write, which
        // is what the spec says even though nothing here has a colour attachment.
        let barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
            .old_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(r.singlesample_image)
            .subresource_range(vk::ImageSubresourceRange {
                aspect_mask: if c.separate_depth_stencil_layouts { aspect } else { aspect_flags_for_format(c.format) },
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: c.view_layers,
            });

        let region = vk::BufferImageCopy::builder()
            .buffer_offset(0)
            .buffer_row_length(0)
            .buffer_image_height(0)
            .image_subresource(vk::ImageSubresourceLayers {
                aspect_mask: aspect,
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

        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(r.buffer)
            .offset(0)
            .size(vk::WHOLE_SIZE);

        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
            device.cmd_copy_image_to_buffer(cmd_buffer, r.singlesample_image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, r.buffer, &[region]);
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `DepthStencilResolveTest::submit`
    fn submit(&self, queue: vk::Queue, r: &Resources) -> Result<(), TestError> {
        use vulkanalia::vk::{DeviceV1_0, DeviceV1_3};

        let c = &self.config;
        let device = self.context.get_device();
        let cmd_buffer = allocate_command_buffer(device, r.command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let pre_render_barriers = self.pre_render_barriers(r);

        self.clear_resolve_image(queue, r)?;

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: c.width, height: c.height },
        };
        let attachment = self.rendering_attachment(r);
        let make_rendering_info = |flags: vk::RenderingFlags| {
            let mut info = vk::RenderingInfo::builder().flags(flags).render_area(render_area).layer_count(c.view_layers).view_mask(0);
            info = if c.verify_buffer == VerifyBuffer::Depth {
                info.depth_attachment(&attachment)
            } else {
                info.stencil_attachment(&attachment)
            };
            info
        };

        let begin_pre_render = |cmd: vk::CommandBuffer| unsafe {
            begin_command_buffer(device, cmd)?;
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &pre_render_barriers,
            );
            Ok::<(), TestError>(())
        };

        let testing_depth = c.verify_buffer == VerifyBuffer::Depth;
        let completely_contains = c.group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass;

        // `Move<VkCommandBuffer> secCmdBuffer` at function scope: it has to outlive the
        // primary submission below, not just the block that records it.
        let sec_cmd_buffer = if c.group_params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(device, r.command_pool, vk::CommandBufferLevel::SECONDARY)?)
        } else {
            None
        };

        if testing_depth {
            if let Some(sec_cmd_buffer) = &sec_cmd_buffer {
                let sec_cmd_buffer = **sec_cmd_buffer;

                // Record secondary command buffer
                if completely_contains {
                    self.begin_secondary_command_buffer(sec_cmd_buffer, VerifyBuffer::Depth, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)?;
                    unsafe { device.cmd_begin_rendering(sec_cmd_buffer, &make_rendering_info(vk::RenderingFlags::empty())) };
                } else {
                    self.begin_secondary_command_buffer(sec_cmd_buffer, VerifyBuffer::Depth, vk::RenderingFlags::empty())?;
                }

                unsafe {
                    device.cmd_bind_pipeline(sec_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, r.render_pipeline);
                    device.cmd_draw(sec_cmd_buffer, 6, 1, 0, 0);
                }

                if completely_contains {
                    unsafe { device.cmd_end_rendering(sec_cmd_buffer) };
                }
                end_command_buffer(device, sec_cmd_buffer)?;

                // Record primary command buffer
                begin_pre_render(*cmd_buffer)?;
                if !completely_contains {
                    unsafe { device.cmd_begin_rendering(*cmd_buffer, &make_rendering_info(vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)) };
                }
                unsafe { device.cmd_execute_commands(*cmd_buffer, &[sec_cmd_buffer]) };
                if !completely_contains {
                    unsafe { device.cmd_end_rendering(*cmd_buffer) };
                }
            } else {
                begin_pre_render(*cmd_buffer)?;
                unsafe {
                    device.cmd_begin_rendering(*cmd_buffer, &make_rendering_info(vk::RenderingFlags::empty()));
                    device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, r.render_pipeline);
                    device.cmd_draw(*cmd_buffer, 6, 1, 0, 0);
                    device.cmd_end_rendering(*cmd_buffer);
                }
            }
        } else {
            begin_pre_render(*cmd_buffer)?;

            // For stencil we can set the reference value for just one sample at a time,
            // so there are as many passes as there are samples; the first half of the
            // samples is initialized with 1 and the second half with 255.
            let half_of_samples = c.sample_count >> 1;
            let draw_target = sec_cmd_buffer.as_deref().copied().unwrap_or(*cmd_buffer);

            for i in 0..c.sample_count {
                if i == 0 {
                    unsafe {
                        device.cmd_pipeline_barrier(
                            *cmd_buffer,
                            vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                            vk::PipelineStageFlags::TOP_OF_PIPE,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                    }

                    if sec_cmd_buffer.is_some() {
                        let flags = if completely_contains {
                            vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                        } else {
                            vk::RenderingFlags::empty()
                        };
                        self.begin_secondary_command_buffer(draw_target, VerifyBuffer::Stencil, flags)?;

                        if completely_contains {
                            unsafe { device.cmd_begin_rendering(draw_target, &make_rendering_info(vk::RenderingFlags::empty())) };
                        } else {
                            unsafe { device.cmd_begin_rendering(*cmd_buffer, &make_rendering_info(vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)) };
                        }
                    } else {
                        unsafe { device.cmd_begin_rendering(*cmd_buffer, &make_rendering_info(vk::RenderingFlags::empty())) };
                    }
                }

                let stencil_reference = 1 + 254 * u32::from(i >= half_of_samples);
                unsafe {
                    device.cmd_bind_pipeline(draw_target, vk::PipelineBindPoint::GRAPHICS, r.render_pipeline);
                    device.cmd_push_constants(draw_target, r.render_pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &i.to_ne_bytes());
                    device.cmd_set_stencil_reference(draw_target, vk::StencilFaceFlags::FRONT_AND_BACK, stencil_reference);
                    device.cmd_draw(draw_target, 6, 1, 0, 0);
                }

                if i == c.sample_count - 1 {
                    match &sec_cmd_buffer {
                        Some(secondary) => {
                            if completely_contains {
                                unsafe { device.cmd_end_rendering(draw_target) };
                            }
                            end_command_buffer(device, **secondary)?;
                            unsafe { device.cmd_execute_commands(*cmd_buffer, &[**secondary]) };
                            if !completely_contains {
                                unsafe { device.cmd_end_rendering(*cmd_buffer) };
                            }
                        }
                        None => unsafe { device.cmd_end_rendering(*cmd_buffer) },
                    }
                }
            }
        }

        self.copy_results_to_buffer(*cmd_buffer, r);

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)
    }

    /// `DepthStencilPushConstResolveTest::submit`
    fn submit_push_consts(&self, queue: vk::Queue, r: &Resources, pc: &PushConstResources<'_>) -> Result<(), TestError> {
        use vulkanalia::vk::{DeviceV1_0, DeviceV1_3};

        let c = &self.config;
        let device = self.context.get_device();
        let cmd_buffer = allocate_command_buffer(device, r.command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let pre_render_barriers = self.pre_render_barriers(r);

        self.clear_resolve_image(queue, r)?;

        let depth_attachment = self.rendering_attachment(r);
        let ds_rendering_info = vk::RenderingInfo::builder()
            .flags(vk::RenderingFlags::empty())
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D { width: c.width, height: c.height },
            })
            .layer_count(c.view_layers)
            .view_mask(0)
            .depth_attachment(&depth_attachment);

        let clear_color = [1.0f32, 0.0, 0.0, 1.0];
        let color_attachment_info = vk::RenderingAttachmentInfo::builder()
            .image_view(*pc.color_attachment_view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .resolve_image_view(vk::ImageView::null())
            .resolve_image_layout(vk::ImageLayout::UNDEFINED)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            })
            .build();
        let color_attachments = [color_attachment_info];
        let pc_rendering_info = vk::RenderingInfo::builder()
            .flags(vk::RenderingFlags::empty())
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: PC_IMAGE_SIZE,
                    height: PC_IMAGE_SIZE,
                },
            })
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_attachments);

        begin_command_buffer(device, *cmd_buffer)?;

        // Bind push constants and do DS resolve
        let push_constants = [0.0f32, 1.0, 0.0, 1.0];
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &pre_render_barriers,
            );
            device.cmd_push_constants(
                *cmd_buffer,
                *pc.pc_pipeline_layout,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                std::slice::from_raw_parts(push_constants.as_ptr().cast::<u8>(), std::mem::size_of_val(&push_constants)),
            );

            device.cmd_begin_rendering(*cmd_buffer, &ds_rendering_info);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, r.render_pipeline);
            device.cmd_draw(*cmd_buffer, 6, 1, 0, 0);
            device.cmd_end_rendering(*cmd_buffer);
        }

        self.copy_results_to_buffer(*cmd_buffer, r);

        // Render for testing push constants
        let out_image_barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::SHADER_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(pc.color_image.get())
            .subresource_range(vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            })
            .build();

        let copy_region = vk::BufferImageCopy::builder()
            .buffer_offset(0)
            .buffer_row_length(0)
            .buffer_image_height(0)
            .image_subresource(vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            })
            .image_offset(vk::Offset3D { x: 0, y: 0, z: 0 })
            .image_extent(vk::Extent3D {
                width: PC_IMAGE_SIZE,
                height: PC_IMAGE_SIZE,
                depth: 1,
            });

        let copy_barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
            .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(pc.color_image.get())
            .subresource_range(vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            })
            .build();

        let host_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(pc.output_color_buffer.get())
            .offset(0)
            .size(vk::WHOLE_SIZE);

        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[out_image_barrier],
            );
            device.cmd_begin_rendering(*cmd_buffer, &pc_rendering_info);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pc.pc_pipeline);
            device.cmd_draw(*cmd_buffer, 6, 1, 0, 0);
            device.cmd_end_rendering(*cmd_buffer);

            // `copyImageToBuffer`
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[copy_barrier],
            );
            device.cmd_copy_image_to_buffer(
                *cmd_buffer,
                pc.color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                pc.output_color_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)
    }

    /// Whether a value at this index falls inside the render area. Everything outside it
    /// was only ever cleared, and must still hold the clear value.
    fn inside_render_area(&self, value_index: u32) -> bool {
        let c = &self.config;
        let layer_size = c.width * c.height;
        let in_layer_index = value_index % layer_size;
        let x = (in_layer_index % c.width) as i32;
        let y = ((in_layer_index - in_layer_index % c.width) / c.width) as i32;
        let x1 = c.render_area.offset.x;
        let y1 = c.render_area.offset.y;
        let x2 = x1 + c.render_area.extent.width as i32;
        let y2 = y1 + c.render_area.extent.height as i32;
        x >= x1 && x < x2 && y >= y1 && y < y2
    }

    /// `verifyDepth`. The buffer holds depth tightly packed, so it is read by hand -
    /// a texture accessor cannot interpret a format that is depth only.
    fn verify_depth(&self, bytes: &[u8]) -> bool {
        let c = &self.config;
        let expected_value = if c.depth_resolve_mode == vk::ResolveModeFlags::NONE {
            c.clear_value.depth
        } else {
            c.depth_expected_value
        };

        let (pixel_step, get_depth_component) = match c.format {
            vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D24_UNORM_S8_UINT => {
                (4usize, (|b: &[u8]| (u32::from_le_bytes([b[0], b[1], b[2], 0])) as f32 / 16777215.0) as fn(&[u8]) -> f32)
            }
            vk::Format::D32_SFLOAT | vk::Format::D32_SFLOAT_S8_UINT => (4usize, (|b: &[u8]| f32::from_le_bytes([b[0], b[1], b[2], b[3]])) as fn(&[u8]) -> f32),
            _ => (2usize, (|b: &[u8]| u16::from_le_bytes([b[0], b[1]]) as f32 / 65535.0) as fn(&[u8]) -> f32),
        };

        const EPSILON: f32 = 0.002;
        let values_count = c.width * c.height * c.view_layers;
        for value_index in 0..values_count {
            let offset = value_index as usize * pixel_step;
            if offset + pixel_step > bytes.len() {
                return false;
            }
            let depth = get_depth_component(&bytes[offset..]);
            let want = if self.inside_render_area(value_index) { expected_value } else { c.clear_value.depth };
            if (depth - want).abs() > EPSILON {
                return false;
            }
        }
        true
    }

    /// `verifyStencil`
    fn verify_stencil(&self, bytes: &[u8]) -> bool {
        let c = &self.config;
        let expected_value = if c.stencil_resolve_mode == vk::ResolveModeFlags::NONE {
            c.clear_value.stencil as u8
        } else {
            c.stencil_expected_value
        };

        let values_count = c.width * c.height * c.view_layers;
        for value_index in 0..values_count {
            let Some(&stencil) = bytes.get(value_index as usize) else {
                return false;
            };
            let want = if self.inside_render_area(value_index) {
                expected_value
            } else {
                c.clear_value.stencil as u8
            };
            if stencil != want {
                return false;
            }
        }
        true
    }
}
