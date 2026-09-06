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
// `RENDERING_TYPE_DYNAMIC_RENDERING` is not registered by this port's tree, so the
// dynamic-rendering half of the upstream instance (`iterateInternalDynamicRendering`,
// the rendering-attachment-location plumbing) is left out rather than written blind.

use vulkanalia::vk::{self, HasBuilder};

use crate::tcu::pixel::{
    ConstPixelBufferAccess, TextureLevel, get_texture_format_bit_depth, get_texture_format_info, get_texture_format_mantissa_bit_depth, has_depth_component, has_stencil_component,
    linear_to_srgb,
};
use crate::tcu::texture::{ChannelOrder, TextureChannelClass};
use crate::tcu::{TestCaseGroup, TestError, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool, make_descriptor_set, make_framebuffer,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::renderpass::render_pass_tests::RenderPassType;
use crate::vkt::{Context, TestCase, TestInstance};

/// `MAX_COLOR_ATTACHMENT_COUNT`
const MAX_COLOR_ATTACHMENT_COUNT: u32 = 4;

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
    /// `formatToName(format)`. Not upstream state: it names the fragment shader that
    /// upstream builds inline in `Programs::init`, which this port compiles ahead of
    /// time - one per colour format.
    pub format_name: &'static str,
    pub sample_count: u32,
    pub render_pass_type: RenderPassType,
    pub separate_stencil_usage: TestSeparateUsage,
    pub extended_flags: bool,
}

/// The program set every case shares. Which of its shaders a case uses follows from
/// the format and the sample count, exactly as upstream's `initPrograms` decides it.
pub struct MsPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

struct MultisampleTestCase {
    name: String,
    config: TestConfig,
}

impl TestCase for MultisampleTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let c = &self.config;

        if c.render_pass_type == RenderPassType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }

        if c.separate_stencil_usage != TestSeparateUsage::None {
            context.require_device_functionality("VK_EXT_separate_stencil_usage")?;
            // requireInstanceFunctionality("VK_KHR_get_physical_device_properties2"):
            // core since Vulkan 1.1, which this port already requires.
        }

        if c.format == vk::Format::A8_UNORM {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if c.extended_flags {
            context.require_device_functionality("VK_KHR_extended_flags")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::renderpass_ms::MS_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleRenderPassTestInstance { context, config: self.config })
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
                format_name,
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

// ---------------------------------------------------------------------------------
// `MultisampleRenderPassTestInstance`
// ---------------------------------------------------------------------------------

/// `sampleCountBitFromomSampleCount` (upstream's spelling)
fn sample_count_bit_from_sample_count(count: u32) -> vk::SampleCountFlags {
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

/// `getImageAspectFlags`
fn get_image_aspect_flags(vk_format: vk::Format) -> vk::ImageAspectFlags {
    let format = map_vk_format(vk_format).expect("multisample formats all map");
    let has_depth = has_depth_component(format.order);
    let has_stencil = has_stencil_component(format.order);

    if has_depth || has_stencil {
        let mut aspect = vk::ImageAspectFlags::empty();
        if has_depth {
            aspect |= vk::ImageAspectFlags::DEPTH;
        }
        if has_stencil {
            aspect |= vk::ImageAspectFlags::STENCIL;
        }
        aspect
    } else {
        vk::ImageAspectFlags::COLOR
    }
}

/// `getSrcImageUsage`
fn get_src_image_usage(vk_format: vk::Format) -> vk::ImageUsageFlags {
    let format = map_vk_format(vk_format).expect("multisample formats all map");
    if has_depth_component(format.order) || has_stencil_component(format.order) {
        vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT
    } else {
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT
    }
}

/// `getDstFormat`
fn get_dst_format(vk_format: vk::Format, separate_stencil_usage: TestSeparateUsage) -> vk::Format {
    let format = map_vk_format(vk_format).expect("multisample formats all map");
    let has_depth = has_depth_component(format.order);
    let has_stencil = has_stencil_component(format.order);

    if has_depth && has_stencil && separate_stencil_usage == TestSeparateUsage::None {
        vk::Format::R32G32_SFLOAT
    } else if has_depth || has_stencil {
        vk::Format::R32_SFLOAT
    } else {
        vk_format
    }
}

/// `deDivRoundUp32(sampleCount, MAX_COLOR_ATTACHMENT_COUNT)`
fn split_subpass_count(sample_count: u32) -> u32 {
    sample_count.div_ceil(MAX_COLOR_ATTACHMENT_COUNT)
}

struct MultisampleRenderPassTestInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

/// `m_width` / `m_height`
const WIDTH: u32 = 32;
const HEIGHT: u32 = 32;

impl MultisampleRenderPassTestInstance<'_> {
    fn src_format(&self) -> vk::Format {
        self.config.format
    }

    fn dst_format(&self) -> vk::Format {
        get_dst_format(self.config.format, self.config.separate_stencil_usage)
    }

    fn is_depth_format(&self) -> bool {
        has_depth_component(map_vk_format(self.src_format()).expect("multisample formats all map").order)
    }

    fn is_stencil_format(&self) -> bool {
        has_stencil_component(map_vk_format(self.src_format()).expect("multisample formats all map").order)
    }

    fn is_depth_stencil_format(&self) -> bool {
        self.is_depth_format() || self.is_stencil_format()
    }

    /// `testDepth` / `testStencil` in `Programs::init` and `verifyResult`
    fn test_depth(&self) -> bool {
        match self.config.separate_stencil_usage {
            TestSeparateUsage::None => self.is_depth_format(),
            other => other == TestSeparateUsage::Depth,
        }
    }

    fn test_stencil(&self) -> bool {
        match self.config.separate_stencil_usage {
            TestSeparateUsage::None => self.is_stencil_format(),
            other => other == TestSeparateUsage::Stencil,
        }
    }

    /// `createImage` - the free function with the support checks, plus the
    /// `VK_EXT_separate_stencil_usage` query the depth/stencil variants add.
    fn create_image(
        &self,
        vk_format: vk::Format,
        sample_count_bit: vk::SampleCountFlags,
        usage: vk::ImageUsageFlags,
        width: u32,
        height: u32,
        separate_stencil_usage: TestSeparateUsage,
    ) -> Result<ImageWithMemory<'_>, TestError> {
        use vulkanalia::vk::InstanceV1_0;

        let instance = self.context.get_instance();
        let physical_device = self.context.get_physical_device();
        let format = map_vk_format(vk_format).expect("multisample formats all map");
        let image_type = vk::ImageType::_2D;
        let image_tiling = vk::ImageTiling::OPTIMAL;
        let format_properties = unsafe { instance.get_physical_device_format_properties(physical_device, vk_format) };
        let image_format_properties =
            match unsafe { instance.get_physical_device_image_format_properties(physical_device, vk_format, image_type, image_tiling, usage, vk::ImageCreateFlags::empty()) } {
                Ok(properties) => properties,
                Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => return Err(TestError::NotSupported("Image format not supported".into())),
                Err(error) => return Err(TestError::InternalError(format!("vkGetPhysicalDeviceImageFormatProperties: {error}"))),
            };
        let depth_usage = if separate_stencil_usage == TestSeparateUsage::Depth {
            usage
        } else {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        };
        let stencil_usage = if separate_stencil_usage == TestSeparateUsage::Stencil {
            usage
        } else {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        };
        let image_extent = vk::Extent3D { width, height, depth: 1 };

        if (has_depth_component(format.order) || has_stencil_component(format.order))
            && !format_properties.optimal_tiling_features.contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Err(TestError::NotSupported("Format can't be used as depth stencil attachment".into()));
        }

        if !(has_depth_component(format.order) || has_stencil_component(format.order))
            && !format_properties.optimal_tiling_features.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
        {
            return Err(TestError::NotSupported("Format can't be used as color attachment".into()));
        }

        if image_format_properties.max_extent.width < image_extent.width
            || image_format_properties.max_extent.height < image_extent.height
            || !image_format_properties.sample_counts.contains(sample_count_bit)
        {
            return Err(TestError::NotSupported("Image type not supported".into()));
        }

        let stencil_usage_info = vk::ImageStencilUsageCreateInfo {
            s_type: vk::StructureType::IMAGE_STENCIL_USAGE_CREATE_INFO,
            next: std::ptr::null(),
            stencil_usage,
        };

        if separate_stencil_usage != TestSeparateUsage::None {
            let format_info2 = vk::PhysicalDeviceImageFormatInfo2 {
                s_type: vk::StructureType::PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2,
                next: (&raw const stencil_usage_info).cast(),
                format: vk_format,
                type_: image_type,
                tiling: image_tiling,
                usage: depth_usage,
                flags: vk::ImageCreateFlags::empty(),
            };
            let mut ext_properties = vk::ImageFormatProperties2 {
                s_type: vk::StructureType::IMAGE_FORMAT_PROPERTIES_2,
                next: std::ptr::null_mut(),
                image_format_properties: vk::ImageFormatProperties::default(),
            };
            let result = unsafe { (instance.commands().get_physical_device_image_format_properties2)(physical_device, &raw const format_info2, &raw mut ext_properties) };

            if result == vk::Result::ERROR_FORMAT_NOT_SUPPORTED
                || ext_properties.image_format_properties.max_extent.width < image_extent.width
                || ext_properties.image_format_properties.max_extent.height < image_extent.height
                || !ext_properties.image_format_properties.sample_counts.contains(sample_count_bit)
            {
                return Err(TestError::NotSupported("Image format not supported".into()));
            }
        }

        let mut image_usage = usage;
        if separate_stencil_usage != TestSeparateUsage::None {
            image_usage = depth_usage | vk::ImageUsageFlags::INPUT_ATTACHMENT;
        }

        let mut info = vk::ImageCreateInfo::builder()
            .image_type(image_type)
            .format(vk_format)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(sample_count_bit)
            .tiling(image_tiling)
            .usage(image_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        if separate_stencil_usage != TestSeparateUsage::None {
            info.next = (&raw const stencil_usage_info).cast();
        }

        ImageWithMemory::new(self.context.get_device(), self.context.get_default_allocator(), info, MemoryRequirement::ANY)
    }

    /// `createImageAttachmentView`
    fn create_image_attachment_view(&self, image: vk::Image, format: vk::Format, aspect: vk::ImageAspectFlags) -> Result<Unique<'_, vk::ImageView>, TestError> {
        let range = vk::ImageSubresourceRange {
            aspect_mask: aspect,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        make_image_view(self.context.get_device(), image, vk::ImageViewType::_2D, format, range)
    }

    /// `createSrcPrimaryInputImageView`
    fn create_src_primary_input_image_view(&self, image: vk::Image, format: vk::Format, aspect: vk::ImageAspectFlags) -> Result<Unique<'_, vk::ImageView>, TestError> {
        let primary_depth_stencil_aspect = if self.config.separate_stencil_usage == TestSeparateUsage::Stencil {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        };
        let aspect = if aspect == vk::ImageAspectFlags::STENCIL | vk::ImageAspectFlags::DEPTH {
            primary_depth_stencil_aspect
        } else {
            aspect
        };
        self.create_image_attachment_view(image, format, aspect)
    }

    /// `createSrcSecondaryInputImageView` - only a combined depth/stencil format
    /// without a separate-usage flag needs the second, stencil-only view.
    fn create_src_secondary_input_image_view(&self, image: vk::Image, format: vk::Format, aspect: vk::ImageAspectFlags) -> Result<Option<Unique<'_, vk::ImageView>>, TestError> {
        if aspect == vk::ImageAspectFlags::STENCIL | vk::ImageAspectFlags::DEPTH && self.config.separate_stencil_usage == TestSeparateUsage::None {
            Ok(Some(self.create_image_attachment_view(image, format, vk::ImageAspectFlags::STENCIL)?))
        } else {
            Ok(None)
        }
    }

    /// `createBuffer`
    fn create_buffer(&self) -> Result<BufferWithMemory<'_>, TestError> {
        let pixel_size = vk::DeviceSize::from(map_vk_format(self.dst_format()).and_then(|f| f.pixel_size()).expect("the dst formats all map"));
        let info = make_buffer_create_info(
            vk::DeviceSize::from(WIDTH * HEIGHT) * pixel_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        );
        BufferWithMemory::new(self.context.get_device(), self.context.get_default_allocator(), info, MemoryRequirement::HOST_VISIBLE)
    }

    /// `createRenderPass` for both traits, plus `createRenderPassSwitch`.
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let samples = sample_count_bit_from_sample_count(c.sample_count);
        let split_subpass_count = split_subpass_count(c.sample_count);
        let is_depth_stencil_format = self.is_depth_stencil_format();
        let input_aspect = match c.separate_stencil_usage {
            TestSeparateUsage::Depth => vk::ImageAspectFlags::DEPTH,
            TestSeparateUsage::Stencil => vk::ImageAspectFlags::STENCIL,
            TestSeparateUsage::None => get_image_aspect_flags(self.src_format()),
        };
        let mut dst_attachment_refs: Vec<Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>> = vec![Vec::new(); split_subpass_count as usize];
        let mut dst_resolve_attachment_refs: Vec<Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>> = vec![Vec::new(); split_subpass_count as usize];
        let mut attachments: Vec<vk::AttachmentDescription> = Vec::new();
        let src_attachment_ref = (
            0u32,
            if is_depth_stencil_format {
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
            } else {
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
            },
            vk::ImageAspectFlags::empty(),
        );
        let src_attachment_input_ref = (
            0u32,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            if c.render_pass_type == RenderPassType::RenderPass2 {
                input_aspect
            } else {
                vk::ImageAspectFlags::empty()
            },
        );

        attachments.push(vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: self.src_format(),
            samples,
            load_op: vk::AttachmentLoadOp::DONT_CARE,
            store_op: vk::AttachmentStoreOp::DONT_CARE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::GENERAL,
        });

        for split_subpass_index in 0..split_subpass_count {
            for _ in 0..MAX_COLOR_ATTACHMENT_COUNT.min(c.sample_count - split_subpass_index * MAX_COLOR_ATTACHMENT_COUNT) {
                // Multisample color attachment
                dst_attachment_refs[split_subpass_index as usize].push((attachments.len() as u32, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, vk::ImageAspectFlags::empty()));
                attachments.push(vk::AttachmentDescription {
                    flags: vk::AttachmentDescriptionFlags::empty(),
                    format: self.dst_format(),
                    samples,
                    load_op: vk::AttachmentLoadOp::DONT_CARE,
                    store_op: vk::AttachmentStoreOp::DONT_CARE,
                    stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                    stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                    initial_layout: vk::ImageLayout::UNDEFINED,
                    final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                });

                // Resolve attachment
                dst_resolve_attachment_refs[split_subpass_index as usize].push((
                    attachments.len() as u32,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageAspectFlags::empty(),
                ));
                attachments.push(vk::AttachmentDescription {
                    flags: vk::AttachmentDescriptionFlags::empty(),
                    format: self.dst_format(),
                    samples: vk::SampleCountFlags::_1,
                    load_op: vk::AttachmentLoadOp::DONT_CARE,
                    store_op: vk::AttachmentStoreOp::STORE,
                    stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                    stencil_store_op: vk::AttachmentStoreOp::STORE,
                    initial_layout: vk::ImageLayout::UNDEFINED,
                    final_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                });
            }
        }

        // Subpass 0 renders into the multisampled source attachment, then one subpass
        // per group of up to four samples reads it back and splits it out.
        let src_stage_mask = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
        let src_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
        let mut dependency_pairs: Vec<(u32, u32)> = (0..split_subpass_count).map(|index| (0, index + 1)).collect();
        // the last subpass must synchronize with all prior subpasses
        dependency_pairs.extend((0..split_subpass_count.saturating_sub(1)).map(|index| (index + 1, split_subpass_count)));

        let handle = if c.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

            let attachments2: Vec<vk::AttachmentDescription2> = attachments.iter().map(to_attachment_description2).collect();
            let src_ref2 = to_attachment_reference2(&src_attachment_ref);
            let src_input_ref2 = to_attachment_reference2(&src_attachment_input_ref);
            let dst_refs2: Vec<Vec<vk::AttachmentReference2>> = dst_attachment_refs.iter().map(|refs| refs.iter().map(to_attachment_reference2).collect()).collect();
            let dst_resolve_refs2: Vec<Vec<vk::AttachmentReference2>> =
                dst_resolve_attachment_refs.iter().map(|refs| refs.iter().map(to_attachment_reference2).collect()).collect();

            let mut subpasses = vec![{
                let builder = vk::SubpassDescription2::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS).view_mask(0);
                if is_depth_stencil_format {
                    builder.depth_stencil_attachment(&src_ref2).build()
                } else {
                    builder.color_attachments(std::slice::from_ref(&src_ref2)).build()
                }
            }];
            for index in 0..split_subpass_count as usize {
                subpasses.push(
                    vk::SubpassDescription2::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .view_mask(0)
                        .input_attachments(std::slice::from_ref(&src_input_ref2))
                        .color_attachments(&dst_refs2[index])
                        .resolve_attachments(&dst_resolve_refs2[index])
                        .build(),
                );
            }
            let dependencies: Vec<vk::SubpassDependency2> = dependency_pairs
                .iter()
                .map(|&(src, dst)| {
                    vk::SubpassDependency2::builder()
                        .src_subpass(src)
                        .dst_subpass(dst)
                        .src_stage_mask(src_stage_mask)
                        .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                        .src_access_mask(src_access_mask)
                        .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                        .dependency_flags(vk::DependencyFlags::BY_REGION)
                        .view_offset(0)
                        .build()
                })
                .collect();
            let info = vk::RenderPassCreateInfo2::builder()
                .attachments(&attachments2)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?
        } else {
            let src_ref = to_attachment_reference(&src_attachment_ref);
            let src_input_ref = to_attachment_reference(&src_attachment_input_ref);
            let dst_refs: Vec<Vec<vk::AttachmentReference>> = dst_attachment_refs.iter().map(|refs| refs.iter().map(to_attachment_reference).collect()).collect();
            let dst_resolve_refs: Vec<Vec<vk::AttachmentReference>> = dst_resolve_attachment_refs.iter().map(|refs| refs.iter().map(to_attachment_reference).collect()).collect();

            let mut subpasses = vec![{
                let builder = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
                if is_depth_stencil_format {
                    builder.depth_stencil_attachment(&src_ref).build()
                } else {
                    builder.color_attachments(std::slice::from_ref(&src_ref)).build()
                }
            }];
            for index in 0..split_subpass_count as usize {
                subpasses.push(
                    vk::SubpassDescription::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .input_attachments(std::slice::from_ref(&src_input_ref))
                        .color_attachments(&dst_refs[index])
                        .resolve_attachments(&dst_resolve_refs[index])
                        .build(),
                );
            }
            let dependencies: Vec<vk::SubpassDependency> = dependency_pairs
                .iter()
                .map(|&(src, dst)| {
                    vk::SubpassDependency::builder()
                        .src_subpass(src)
                        .dst_subpass(dst)
                        .src_stage_mask(src_stage_mask)
                        .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                        .src_access_mask(src_access_mask)
                        .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                        .dependency_flags(vk::DependencyFlags::BY_REGION)
                        .build()
                })
                .collect();
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?
        };

        Ok(Unique::new(device, handle))
    }

    /// `createSplitDescriptorSetLayout`
    fn create_split_descriptor_set_layout(&self) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let bindings: Vec<vk::DescriptorSetLayoutBinding> = (0..if self.is_depth_format() && self.is_stencil_format() { 2 } else { 1 })
            .map(|binding| vk::DescriptorSetLayoutBinding {
                binding,
                descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                immutable_samplers: std::ptr::null(),
            })
            .collect();
        let info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let handle = unsafe { device.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?;
        Ok(Unique::new(device, handle))
    }

    /// `createSplitDescriptorPool`
    fn create_split_descriptor_pool(&self) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::INPUT_ATTACHMENT,
            descriptor_count: 2,
        }];
        let info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(2)
            .pool_sizes(&sizes);
        let handle = unsafe { device.create_descriptor_pool(&info, None) }.vk_check("vkCreateDescriptorPool")?;
        Ok(Unique::new(device, handle))
    }

    /// `createSplitDescriptorSet`
    fn create_split_descriptor_set<'b>(
        &'b self,
        pool: vk::DescriptorPool,
        layout: vk::DescriptorSetLayout,
        primary_image_view: vk::ImageView,
        secondary_image_view: Option<vk::ImageView>,
    ) -> Result<UniqueDescriptorSet<'b>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let descriptor_set = make_descriptor_set(device, pool, layout)?;

        let image_infos = [
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::default(),
                image_view: primary_image_view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            },
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::default(),
                image_view: secondary_image_view.unwrap_or_default(),
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            },
        ];
        let writes: Vec<vk::WriteDescriptorSet> = (0..if secondary_image_view.is_some() { 2 } else { 1 })
            .map(|index| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(index as u32)
                    .dst_array_element(0)
                    .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                    .image_info(std::slice::from_ref(&image_infos[index]))
                    .build()
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        Ok(descriptor_set)
    }

    /// `createRenderPipeline`
    fn create_render_pipeline(
        &self,
        render_pass: vk::RenderPass,
        pipeline_layout: vk::PipelineLayout,
        vert: vk::ShaderModule,
        frag: vk::ShaderModule,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let is_depth_stencil_format = self.is_depth_stencil_format();
        let color_attachment_count = u32::from(!is_depth_stencil_format);

        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let stages = [stage(vk::ShaderStageFlags::VERTEX, vert), stage(vk::ShaderStageFlags::FRAGMENT, frag)];

        // Disable blending
        let attachment_blend_states = vec![DISABLED_BLEND_STATE; color_attachment_count as usize];

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [viewport()];
        let scissors = [scissor()];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);
        let rasterization = default_rasterization_state();
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(sample_count_bit_from_sample_count(c.sample_count));
        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::INCREMENT_AND_WRAP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: !0u32,
            write_mask: !0u32,
            reference: 0xFF / (c.sample_count + 1),
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(true)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        // A depth/stencil case has no colour attachment at all, so it passes no blend
        // states rather than a disabled one.
        let blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&attachment_blend_states);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&blend_state)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `createSplitPipelines`
    fn create_split_pipelines(
        &self,
        render_pass: vk::RenderPass,
        pipeline_layout: vk::PipelineLayout,
        vert: vk::ShaderModule,
        frag: vk::ShaderModule,
    ) -> Result<Vec<Unique<'_, vk::Pipeline>>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let split_subpass_count = split_subpass_count(c.sample_count);
        let color_attachment_count = MAX_COLOR_ATTACHMENT_COUNT.min(c.sample_count);

        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let stages = [stage(vk::ShaderStageFlags::VERTEX, vert), stage(vk::ShaderStageFlags::FRAGMENT, frag)];

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [viewport()];
        let scissors = [scissor()];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);
        let rasterization = default_rasterization_state();
        let depth_stencil_state = default_depth_stencil_state();
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(sample_count_bit_from_sample_count(c.sample_count));
        // Disable blending
        let attachment_blend_states = vec![DISABLED_BLEND_STATE; color_attachment_count as usize];
        let blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&attachment_blend_states);

        (0..split_subpass_count)
            .map(|index| {
                let info = vk::GraphicsPipelineCreateInfo::builder()
                    .stages(&stages)
                    .vertex_input_state(&vertex_input_state)
                    .input_assembly_state(&input_assembly)
                    .viewport_state(&viewport_state)
                    .rasterization_state(&rasterization)
                    .multisample_state(&multisample_state)
                    .depth_stencil_state(&depth_stencil_state)
                    .color_blend_state(&blend_state)
                    .layout(pipeline_layout)
                    .render_pass(render_pass)
                    .subpass(index + 1);
                let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
                Ok(Unique::new(device, pipelines.0[0]))
            })
            .collect()
    }

    /// `drawFirstSubpass`
    fn draw_first_subpass(&self, command_buffer: vk::CommandBuffer, pipeline: vk::Pipeline, pipeline_layout: vk::PipelineLayout) {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        unsafe { device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline) };
        for sample_ndx in 0..self.config.sample_count {
            unsafe {
                device.cmd_push_constants(command_buffer, pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &sample_ndx.to_ne_bytes());
                device.cmd_draw(command_buffer, 6, 1, 0, 0);
            }
        }
    }

    /// `drawNextSubpass`
    fn draw_next_subpass(
        &self,
        command_buffer: vk::CommandBuffer,
        pipeline: vk::Pipeline,
        pipeline_layout: vk::PipelineLayout,
        descriptor_set: vk::DescriptorSet,
        split_pipeline_ndx: u32,
    ) {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        unsafe {
            device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_bind_descriptor_sets(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_layout, 0, &[descriptor_set], &[]);
            device.cmd_push_constants(command_buffer, pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &split_pipeline_ndx.to_ne_bytes());
            device.cmd_draw(command_buffer, 6, 1, 0, 0);
        }
    }

    /// `postRenderCommands` - upstream's `copyImageToBuffer` per single-sampled image.
    fn post_render_commands(&self, command_buffer: vk::CommandBuffer, images: &[ImageWithMemory<'_>], buffers: &[BufferWithMemory<'_>]) {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };

        for (image, buffer) in images.iter().zip(buffers) {
            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.get(),
                subresource_range,
            );
            let region = make_buffer_image_copy(
                vk::Extent3D {
                    width: WIDTH,
                    height: HEIGHT,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            let buffer_barrier = make_buffer_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ, buffer.get(), 0, vk::WHOLE_SIZE);
            unsafe {
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
                device.cmd_copy_image_to_buffer(command_buffer, image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer.get(), &[region]);
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
    }
}

/// The blend state upstream builds inline to disable blending.
const DISABLED_BLEND_STATE: vk::PipelineColorBlendAttachmentState = vk::PipelineColorBlendAttachmentState {
    blend_enable: vk::FALSE,
    src_color_blend_factor: vk::BlendFactor::SRC_ALPHA,
    dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
    color_blend_op: vk::BlendOp::ADD,
    src_alpha_blend_factor: vk::BlendFactor::ONE,
    dst_alpha_blend_factor: vk::BlendFactor::ONE,
    alpha_blend_op: vk::BlendOp::ADD,
    color_write_mask: vk::ColorComponentFlags::R
        .union(vk::ColorComponentFlags::G)
        .union(vk::ColorComponentFlags::B)
        .union(vk::ColorComponentFlags::A),
};

fn viewport() -> vk::Viewport {
    vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: WIDTH as f32,
        height: HEIGHT as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }
}

fn scissor() -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D { width: WIDTH, height: HEIGHT },
    }
}

/// `GraphicsPipelineWrapper::setDefaultRasterizationState`
fn default_rasterization_state() -> vk::PipelineRasterizationStateCreateInfoBuilder<'static> {
    vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0)
}

/// `GraphicsPipelineWrapper::setDefaultDepthStencilState`
fn default_depth_stencil_state() -> vk::PipelineDepthStencilStateCreateInfoBuilder {
    vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .max_depth_bounds(1.0)
}

/// `AttachmentDescription1` -> `AttachmentDescription2`, and the same for references -
/// the two render-pass traits differ only in which struct they fill in.
fn to_attachment_description2(a: &vk::AttachmentDescription) -> vk::AttachmentDescription2 {
    vk::AttachmentDescription2::builder()
        .flags(a.flags)
        .format(a.format)
        .samples(a.samples)
        .load_op(a.load_op)
        .store_op(a.store_op)
        .stencil_load_op(a.stencil_load_op)
        .stencil_store_op(a.stencil_store_op)
        .initial_layout(a.initial_layout)
        .final_layout(a.final_layout)
        .build()
}

fn to_attachment_reference(&(attachment, layout, _): &(u32, vk::ImageLayout, vk::ImageAspectFlags)) -> vk::AttachmentReference {
    vk::AttachmentReference { attachment, layout }
}

fn to_attachment_reference2(&(attachment, layout, aspect_mask): &(u32, vk::ImageLayout, vk::ImageAspectFlags)) -> vk::AttachmentReference2 {
    vk::AttachmentReference2::builder().attachment(attachment).layout(layout).aspect_mask(aspect_mask).build()
}

/// `tcu::floatThresholdCompare`
fn float_threshold_compare(reference: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>, threshold: [f32; 4]) -> bool {
    for y in 0..HEIGHT {
        for x in 0..WIDTH {
            let a = reference.get_pixel(x, y, 0);
            let b = result.get_pixel(x, y, 0);
            // NaN must fail, so the comparison is written the way `tcu` writes it
            #[allow(clippy::neg_cmp_op_on_partial_ord)]
            if (0..4).any(|i| !((a[i] - b[i]).abs() <= threshold[i])) {
                return false;
            }
        }
    }
    true
}

/// `tcu::intThresholdCompare`. Upstream subtracts the two pixels as `int`; the
/// difference is taken in `i64` here, which only differs for a threshold big enough
/// to make a wrapped difference pass - and every caller below passes zero.
fn int_threshold_compare(reference: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>, threshold: [u32; 4]) -> bool {
    for y in 0..HEIGHT {
        for x in 0..WIDTH {
            let a = reference.get_pixel_int(x, y, 0);
            let b = result.get_pixel_int(x, y, 0);
            if (0..4).any(|i| (i64::from(a[i]) - i64::from(b[i])).unsigned_abs() > u64::from(threshold[i])) {
                return false;
            }
        }
    }
    true
}

/// `tcu::floatUlpThresholdCompare` - the difference of the two float bit patterns.
fn float_ulp_threshold_compare(reference: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>, threshold: [u32; 4]) -> bool {
    for y in 0..HEIGHT {
        for x in 0..WIDTH {
            let a = reference.get_pixel(x, y, 0);
            let b = result.get_pixel(x, y, 0);
            if (0..4).any(|i| (i64::from(a[i].to_bits()) - i64::from(b[i].to_bits())).unsigned_abs() > u64::from(threshold[i])) {
                return false;
            }
        }
    }
    true
}

impl MultisampleRenderPassTestInstance<'_> {
    /// `verifyResult`
    fn verify_result(&self, buffers: &[BufferWithMemory<'_>]) -> Result<TestStatus, TestError> {
        let c = &self.config;
        let device = self.context.get_device();
        let format = map_vk_format(self.dst_format()).expect("the dst formats all map");
        let pixel_size = format.pixel_size().expect("the dst formats all map") as usize;
        let verify_depth = self.test_depth();
        let verify_stencil = self.test_stencil();
        let mut failure: Option<String> = None;

        for sample_ndx in 0..c.sample_count {
            let allocation = buffers[sample_ndx as usize].get_allocation();
            invalidate_alloc(device, allocation)?;

            let bytes = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), WIDTH as usize * HEIGHT as usize * pixel_size) };
            let access = ConstPixelBufferAccess::new(format, [WIDTH, HEIGHT, 1], bytes);
            let mut reference = TextureLevel::new(format, WIDTH, HEIGHT, 1)?;

            let ok = if verify_depth || verify_stencil {
                {
                    let mut reference = reference.get_access();
                    if verify_depth {
                        for y in 0..HEIGHT {
                            for x in 0..WIDTH {
                                let x1 = x ^ sample_ndx;
                                let y1 = y ^ sample_ndx;
                                let range = 1.0f32;
                                let mut depth = 0.0f32;
                                let mut divider = 2u32;

                                // \note Limited to ten bits since the target is 32x32, so there are 10 input bits
                                for bit_ndx in 0..10u32 {
                                    let src = if bit_ndx.is_multiple_of(2) { x1 } else { y1 };
                                    depth += (range / divider as f32) * if src & (0x1u32 << (bit_ndx / 2)) == 0 { 0.0 } else { 1.0 };
                                    divider *= 2;
                                }

                                reference.set_pixel([depth, 0.0, 0.0, 0.0], x, y, 0);
                            }
                        }
                    }
                    if verify_stencil {
                        for y in 0..HEIGHT {
                            for x in 0..WIDTH {
                                let stencil = sample_ndx + 1;

                                if verify_depth {
                                    let src = reference.as_const().get_pixel(x, y, 0);
                                    reference.set_pixel([src[0], stencil as f32, 0.0, 0.0], x, y, 0);
                                } else {
                                    reference.set_pixel([stencil as f32, 0.0, 0.0, 0.0], x, y, 0);
                                }
                            }
                        }
                    }
                }
                let threshold = [if verify_depth { 1.0 / 1024.0 } else { 0.0 }, 0.0, 0.0, 0.0];
                float_threshold_compare(&reference.get_const_access(), &access, threshold)
            } else {
                match format.channel_class() {
                    TextureChannelClass::UnsignedInteger => {
                        let bits = get_texture_format_bit_depth(format).map(|v| v as u32);
                        let range = bits.map(|b| 1u32 << b.min(31));
                        let component_count = format.order.num_used_channels();
                        {
                            let mut reference = reference.get_access();
                            for y in 0..HEIGHT {
                                for x in 0..WIDTH {
                                    let mut color = [0u32; 4];
                                    spread_bits(bits, component_count, x ^ sample_ndx, y ^ sample_ndx, |comp_ndx, divider, bit| {
                                        color[comp_ndx] += (range[comp_ndx] / divider) * u32::from(bit);
                                    });
                                    let _ = reference.set_pixel_int(color.map(|v| v as i32), x, y, 0);
                                }
                            }
                        }
                        int_threshold_compare(&reference.get_const_access(), &access, [0; 4])
                    }

                    TextureChannelClass::SignedInteger => {
                        let bits = get_texture_format_bit_depth(format).map(|v| v as u32);
                        let range = bits.map(|b| (1u32 << b.min(30)) as i32);
                        let component_count = format.order.num_used_channels();
                        {
                            let mut reference = reference.get_access();
                            for y in 0..HEIGHT {
                                for x in 0..WIDTH {
                                    let mut color = [0i32; 4];
                                    spread_bits(bits, component_count, x ^ sample_ndx, y ^ sample_ndx, |comp_ndx, divider, bit| {
                                        color[comp_ndx] += (range[comp_ndx] / divider as i32) * i32::from(bit);
                                    });
                                    let _ = reference.set_pixel_int(color, x, y, 0);
                                }
                            }
                        }
                        int_threshold_compare(&reference.get_const_access(), &access, [0; 4])
                    }

                    channel_class => {
                        let info = get_texture_format_info(format);
                        let bits = get_texture_format_bit_depth(format).map(|v| v as u32);
                        let min_value = info.value_min.map(|v| v.max(-65536.0));
                        let range: [f32; 4] = std::array::from_fn(|i| info.value_max[i].min(65536.0) - min_value[i]);
                        // `isAlphaOnlyFormat(m_dstFormat)`
                        let is_alpha_only = format.order == ChannelOrder::A;
                        let component_count = if is_alpha_only { 4 } else { format.order.num_used_channels() };
                        {
                            let mut reference = reference.get_access();
                            for y in 0..HEIGHT {
                                for x in 0..WIDTH {
                                    let mut color = min_value;
                                    spread_bits(bits, component_count, x ^ sample_ndx, y ^ sample_ndx, |comp_ndx, divider, bit| {
                                        color[comp_ndx] += (range[comp_ndx] / divider as f32) * if bit { 1.0 } else { 0.0 };
                                    });
                                    if format.order.is_srgb() {
                                        reference.set_pixel(linear_to_srgb(color), x, y, 0);
                                    } else {
                                        reference.set_pixel(color, x, y, 0);
                                    }
                                }
                            }
                        }
                        let mantissa_bits = get_texture_format_mantissa_bit_depth(format).map(|v| v as u32);
                        if channel_class == TextureChannelClass::FloatingPoint {
                            // Convert target format ulps to float ulps and allow 64ulp differences
                            let threshold = mantissa_bits.map(|b| 64u32 * (1u32 << (23 - b)));
                            float_ulp_threshold_compare(&reference.get_const_access(), &access, threshold)
                        } else {
                            // Allow error of 4 times the minimum presentable difference
                            let threshold = mantissa_bits.map(|b| 4.0 * 1.0 / ((1u32 << b) - 1) as f32);
                            float_threshold_compare(&reference.get_const_access(), &access, threshold)
                        }
                    }
                }
            };

            if !ok && failure.is_none() {
                failure = Some(format!("Compare failed for sample {sample_ndx}"));
            }
        }

        Ok(match failure {
            Some(message) => TestStatus::fail(message),
            None => TestStatus::pass("Pass"),
        })
    }
}

/// The `while (nextSrcBit < de::min(bitSize, 10u))` loop `verifyResult` runs once per
/// channel class. `emit` receives the component, the divider and the source bit.
fn spread_bits(bits: [u32; 4], component_count: u32, x1: u32, y1: u32, mut emit: impl FnMut(usize, u32, bool)) {
    let bit_size: u32 = bits.iter().sum();
    let mut dst_bits_used = [0u32; 4];
    let mut next_src_bit = 0u32;
    let mut divider = 2u32;

    // \note Limited to ten bits since the target is 32x32, so there are 10 input bits
    while next_src_bit < bit_size.min(10) {
        for comp_ndx in 0..component_count as usize {
            // upstream's `>` rather than `>=`; it decides how the bits are laid out
            if dst_bits_used[comp_ndx] > bits[comp_ndx] {
                continue;
            }
            let src = if next_src_bit.is_multiple_of(2) { x1 } else { y1 };
            emit(comp_ndx, divider, src & (0x1u32 << (next_src_bit / 2)) != 0);
            next_src_bit += 1;
            dst_bits_used[comp_ndx] += 1;
        }
        divider *= 2;
    }
}

impl TestInstance for MultisampleRenderPassTestInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::DeviceV1_0;

        let c = self.config;
        let device = self.context.get_device();

        if c.extended_flags {
            return Err(TestError::NotPorted(
                "VkImageStencilUsage2CreateInfoKHR is not in this port's Vulkan bindings; no driver here advertises VK_KHR_extended_flags".into(),
            ));
        }

        let src_format = self.src_format();
        let dst_format = self.dst_format();
        let src_image_aspect = get_image_aspect_flags(src_format);
        let src_image_usage = get_src_image_usage(src_format);
        let push_constant_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 4,
        };

        let src_image = self.create_image(
            src_format,
            sample_count_bit_from_sample_count(c.sample_count),
            src_image_usage,
            WIDTH,
            HEIGHT,
            c.separate_stencil_usage,
        )?;
        // VUID-VkFramebufferCreateInfo-pAttachments-00879
        let src_image_view = self.create_image_attachment_view(
            src_image.get(),
            src_format,
            match c.separate_stencil_usage {
                TestSeparateUsage::Depth => vk::ImageAspectFlags::DEPTH,
                TestSeparateUsage::Stencil => vk::ImageAspectFlags::STENCIL,
                TestSeparateUsage::None => src_image_aspect,
            },
        )?;
        let src_primary_input_image_view = self.create_src_primary_input_image_view(src_image.get(), src_format, src_image_aspect)?;
        let src_secondary_input_image_view = self.create_src_secondary_input_image_view(src_image.get(), src_format, src_image_aspect)?;

        let dst_multisample_images = (0..c.sample_count)
            .map(|_| {
                self.create_image(
                    dst_format,
                    sample_count_bit_from_sample_count(c.sample_count),
                    vk::ImageUsageFlags::COLOR_ATTACHMENT,
                    WIDTH,
                    HEIGHT,
                    TestSeparateUsage::None,
                )
            })
            .collect::<Result<Vec<_>, _>>()?;
        let dst_multisample_image_views = dst_multisample_images
            .iter()
            .map(|image| self.create_image_attachment_view(image.get(), dst_format, vk::ImageAspectFlags::COLOR))
            .collect::<Result<Vec<_>, _>>()?;

        let dst_singlesample_images = (0..c.sample_count)
            .map(|_| {
                self.create_image(
                    dst_format,
                    vk::SampleCountFlags::_1,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                    WIDTH,
                    HEIGHT,
                    TestSeparateUsage::None,
                )
            })
            .collect::<Result<Vec<_>, _>>()?;
        let dst_singlesample_image_views = dst_singlesample_images
            .iter()
            .map(|image| self.create_image_attachment_view(image.get(), dst_format, vk::ImageAspectFlags::COLOR))
            .collect::<Result<Vec<_>, _>>()?;

        let dst_buffers = (0..c.sample_count).map(|_| self.create_buffer()).collect::<Result<Vec<_>, _>>()?;

        let render_pass = self.create_render_pass()?;
        let framebuffer = {
            let mut attachments = Vec::with_capacity(1 + 2 * c.sample_count as usize);
            attachments.push(*src_image_view);
            for (ms, ss) in dst_multisample_image_views.iter().zip(&dst_singlesample_image_views) {
                attachments.push(**ms);
                attachments.push(**ss);
            }
            make_framebuffer(device, *render_pass, &attachments, WIDTH, HEIGHT, 1)?
        };

        let render_pipeline_layout = {
            let info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(std::slice::from_ref(&push_constant_range));
            let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
            Unique::new(device, handle)
        };

        let split_descriptor_set_layout = self.create_split_descriptor_set_layout()?;
        let split_pipeline_layout = {
            let set_layouts = [*split_descriptor_set_layout];
            let info = vk::PipelineLayoutCreateInfo::builder()
                .set_layouts(&set_layouts)
                .push_constant_ranges(std::slice::from_ref(&push_constant_range));
            let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
            Unique::new(device, handle)
        };
        let split_descriptor_pool = self.create_split_descriptor_pool()?;
        let split_descriptor_set = self.create_split_descriptor_set(
            *split_descriptor_pool,
            *split_descriptor_set_layout,
            *src_primary_input_image_view,
            src_secondary_input_image_view.as_deref().copied(),
        )?;

        let programs = self.context.get_binary_collection();
        let vert = create_shader_module(device, programs.get("quad_vert")?)?;
        let frag_name = if self.test_depth() {
            "quad_frag_depth".to_owned()
        } else if self.test_stencil() {
            "quad_frag_stencil".to_owned()
        } else {
            format!("quad_frag_{}", c.format_name)
        };
        let frag = create_shader_module(device, programs.get(&frag_name)?)?;
        let split_frag_name = {
            let attachment_count = MAX_COLOR_ATTACHMENT_COUNT.min(c.sample_count);
            if self.is_depth_stencil_format() {
                let kind = match (self.test_depth(), self.test_stencil()) {
                    (true, true) => "depth_stencil",
                    (true, false) => "depth",
                    _ => "stencil",
                };
                format!("quad_split_frag_{kind}_{attachment_count}")
            } else {
                let kind = match map_vk_format(src_format).expect("multisample formats all map").channel_class() {
                    TextureChannelClass::UnsignedInteger => "u",
                    TextureChannelClass::SignedInteger => "i",
                    _ => "f",
                };
                format!("quad_split_frag_{kind}_{attachment_count}")
            }
        };
        let split_frag = create_shader_module(device, programs.get(&split_frag_name)?)?;

        let render_pipeline = self.create_render_pipeline(*render_pass, *render_pipeline_layout, *vert, *frag)?;
        let split_pipelines = self.create_split_pipelines(*render_pass, *split_pipeline_layout, *vert, *split_frag)?;

        let command_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;

        // `iterateInternal`
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *command_buffer)?;

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D { width: WIDTH, height: HEIGHT },
            });
        let render_pass2 = c.render_pass_type == RenderPassType::RenderPass2;

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(*command_buffer, &begin_info, &subpass_begin_info) };
        } else {
            unsafe { device.cmd_begin_render_pass(*command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }

        // Stencil needs to be cleared if it exists.
        if self.is_stencil_format() {
            let clear_attachment = vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::STENCIL,
                color_attachment: 0,
                clear_value: vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
                },
            };
            let clear_rect = vk::ClearRect {
                rect: vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D { width: WIDTH, height: HEIGHT },
                },
                base_array_layer: 0,
                layer_count: 1,
            };
            unsafe { device.cmd_clear_attachments(*command_buffer, &[clear_attachment], &[clear_rect]) };
        }

        self.draw_first_subpass(*command_buffer, *render_pipeline, *render_pipeline_layout);

        for (split_pipeline_ndx, pipeline) in split_pipelines.iter().enumerate() {
            if render_pass2 {
                use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
                let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                let subpass_end_info = vk::SubpassEndInfo::builder();
                unsafe { device.cmd_next_subpass2_khr(*command_buffer, &subpass_begin_info, &subpass_end_info) };
            } else {
                unsafe { device.cmd_next_subpass(*command_buffer, vk::SubpassContents::INLINE) };
            }
            self.draw_next_subpass(*command_buffer, **pipeline, *split_pipeline_layout, *split_descriptor_set, split_pipeline_ndx as u32);
        }

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(*command_buffer, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(*command_buffer) };
        }

        self.post_render_commands(*command_buffer, &dst_singlesample_images, &dst_buffers);

        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), *command_buffer)?;

        self.verify_result(&dst_buffers)
    }
}
