// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageExtendedUsageBitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `addFunctionCase` with a templated function becomes one case type
// carrying which of the three property queries it runs; no shaders.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::texture::{ChannelOrder, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::compressed_formats::is_compressed_format;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::api::object_tests::format_name;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `VK_CORE_FORMAT_LAST`
const VK_CORE_FORMAT_LAST: i32 = 185;

/// The pairs of compressed formats `isCompatibleCompressedFormat` maps onto each other (the upstream map holds both
/// directions of each pair).
const COMPATIBLE_COMPRESSED_PAIRS: &[(vk::Format, vk::Format)] = &[
    (vk::Format::BC1_RGB_UNORM_BLOCK, vk::Format::BC1_RGB_SRGB_BLOCK),
    (vk::Format::BC1_RGBA_UNORM_BLOCK, vk::Format::BC1_RGBA_SRGB_BLOCK),
    (vk::Format::BC2_UNORM_BLOCK, vk::Format::BC2_SRGB_BLOCK),
    (vk::Format::BC3_UNORM_BLOCK, vk::Format::BC3_SRGB_BLOCK),
    (vk::Format::BC4_UNORM_BLOCK, vk::Format::BC4_SNORM_BLOCK),
    (vk::Format::BC5_UNORM_BLOCK, vk::Format::BC5_SNORM_BLOCK),
    (vk::Format::BC7_UNORM_BLOCK, vk::Format::BC7_SRGB_BLOCK),
    (vk::Format::ETC2_R8G8B8_UNORM_BLOCK, vk::Format::ETC2_R8G8B8_SRGB_BLOCK),
    (
        vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK,
    ),
    (
        vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK,
        vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK,
    ),
    (vk::Format::EAC_R11_UNORM_BLOCK, vk::Format::EAC_R11_SNORM_BLOCK),
    (vk::Format::EAC_R11G11_UNORM_BLOCK, vk::Format::EAC_R11G11_SNORM_BLOCK),
    (vk::Format::ASTC_4X4_UNORM_BLOCK, vk::Format::ASTC_4X4_SRGB_BLOCK),
    (vk::Format::ASTC_5X4_UNORM_BLOCK, vk::Format::ASTC_5X4_SRGB_BLOCK),
    (vk::Format::ASTC_5X5_UNORM_BLOCK, vk::Format::ASTC_5X5_SRGB_BLOCK),
    (vk::Format::ASTC_6X5_UNORM_BLOCK, vk::Format::ASTC_6X5_SRGB_BLOCK),
    (vk::Format::ASTC_6X6_UNORM_BLOCK, vk::Format::ASTC_6X6_SRGB_BLOCK),
    (vk::Format::ASTC_8X5_UNORM_BLOCK, vk::Format::ASTC_8X5_SRGB_BLOCK),
    (vk::Format::ASTC_8X6_UNORM_BLOCK, vk::Format::ASTC_8X6_SRGB_BLOCK),
    (vk::Format::ASTC_8X8_UNORM_BLOCK, vk::Format::ASTC_8X8_SRGB_BLOCK),
    (vk::Format::ASTC_10X5_UNORM_BLOCK, vk::Format::ASTC_10X5_SRGB_BLOCK),
    (vk::Format::ASTC_10X6_UNORM_BLOCK, vk::Format::ASTC_10X6_SRGB_BLOCK),
    (vk::Format::ASTC_10X8_UNORM_BLOCK, vk::Format::ASTC_10X8_SRGB_BLOCK),
    (vk::Format::ASTC_10X10_UNORM_BLOCK, vk::Format::ASTC_10X10_SRGB_BLOCK),
    (vk::Format::ASTC_12X10_UNORM_BLOCK, vk::Format::ASTC_12X10_SRGB_BLOCK),
    (vk::Format::ASTC_12X12_UNORM_BLOCK, vk::Format::ASTC_12X12_SRGB_BLOCK),
];

/// `isCompatibleCompressedFormat`
fn is_compatible_compressed_format(format0: vk::Format, format1: vk::Format) -> bool {
    COMPATIBLE_COMPRESSED_PAIRS
        .iter()
        .any(|&(a, b)| (a == format0 && b == format1) || (a == format1 && b == format0))
}

/// `isDepthStencilFormat`
fn is_depth_stencil_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| matches!(f.order, ChannelOrder::D | ChannelOrder::S | ChannelOrder::DS))
}

/// `mapVkFormat(format).getPixelSize()`, for the uncompressed colour formats this is asked about.
fn pixel_size(format: vk::Format) -> Option<u32> {
    map_vk_format(format).and_then(|f| f.pixel_size())
}

/// `isCompatibleFormat`
fn is_compatible_format(format0: vk::Format, format1: vk::Format) -> bool {
    if format0 == format1 {
        return true;
    }

    // Uncompressed colour formats are compatible with each other if they occupy the same number of bits per texel block
    if !is_depth_stencil_format(format0)
        && !is_compressed_format(format0)
        && !is_depth_stencil_format(format1)
        && !is_compressed_format(format1)
        && let (Some(size0), Some(size1)) = (pixel_size(format0), pixel_size(format1))
        && size0 == size1
    {
        return true;
    }

    is_compressed_format(format0) && is_compressed_format(format1) && is_compatible_compressed_format(format0, format1)
}

/// Which of the three `PhysicalDeviceImageFormatProperties*` classes a case runs.
#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryKind {
    /// `vkGetPhysicalDeviceImageFormatProperties`
    Properties,
    /// `vkGetPhysicalDeviceImageFormatProperties2`
    Properties2,
    /// `vkGetPhysicalDeviceImageFormatProperties2` with a `VkImageFormatListCreateInfo` naming the view format
    FormatList,
}

fn get_physical_device_image_format_properties(
    context: &Context<'_>,
    kind: QueryKind,
    view_format: vk::Format,
    tiling: vk::ImageTiling,
    usage: vk::ImageUsageFlags,
    flags: vk::ImageCreateFlags,
) -> Result<(), vk::ErrorCode> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    match kind {
        QueryKind::Properties => unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                view_format,
                vk::ImageType::_2D,
                tiling,
                usage,
                flags,
            )
        }
        .map(|_| ()),
        QueryKind::Properties2 => {
            let mut format_properties2 = vk::ImageFormatProperties2::default();
            let image_format_info2 = vk::PhysicalDeviceImageFormatInfo2::builder()
                .format(view_format)
                .type_(vk::ImageType::_2D)
                .tiling(tiling)
                .usage(usage)
                .flags(flags);
            unsafe {
                instance.get_physical_device_image_format_properties2(
                    physical_device,
                    &image_format_info2,
                    &mut format_properties2,
                )
            }
        }
        QueryKind::FormatList => {
            let view_formats = [view_format];
            let mut image_format_list = vk::ImageFormatListCreateInfo::builder().view_formats(&view_formats);
            let mut format_properties2 = vk::ImageFormatProperties2::default();
            let image_format_info2 = vk::PhysicalDeviceImageFormatInfo2::builder()
                .format(view_format)
                .type_(vk::ImageType::_2D)
                .tiling(tiling)
                .usage(usage)
                .flags(flags)
                .push_next(&mut image_format_list);
            unsafe {
                instance.get_physical_device_image_format_properties2(
                    physical_device,
                    &image_format_info2,
                    &mut format_properties2,
                )
            }
        }
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    image_format: vk::Format,
    usage: vk::ImageUsageFlags,
    tiling: vk::ImageTiling,
}

struct ExtendedUsageBitCase {
    name: String,
    kind: QueryKind,
    params: TestParams,
}

impl TestCase for ExtendedUsageBitCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;
        context.require_device_functionality("VK_KHR_maintenance2")?;

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), params.image_format)
        };

        if params.tiling == vk::ImageTiling::OPTIMAL && format_properties.optimal_tiling_features.is_empty() {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        if params.tiling == vk::ImageTiling::LINEAR && format_properties.linear_tiling_features.is_empty() {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        let usage = params.usage;
        if usage.intersects(
            vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR
                | vk::ImageUsageFlags::VIDEO_DECODE_SRC_KHR
                | vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR,
        ) {
            context.require_device_functionality("VK_KHR_video_decode_queue")?;
        }

        if usage.intersects(
            vk::ImageUsageFlags::VIDEO_ENCODE_DST_KHR
                | vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR
                | vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR,
        ) {
            context.require_device_functionality("VK_KHR_video_encode_queue")?;
        }

        if usage.contains(vk::ImageUsageFlags::FRAGMENT_DENSITY_MAP_EXT) {
            context.require_device_functionality("VK_EXT_fragment_density_map")?;
        }

        if usage.contains(vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR) {
            context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
        }

        if usage.contains(vk::ImageUsageFlags::INVOCATION_MASK_HUAWEI) {
            context.require_device_functionality("VK_HUAWEI_invocation_mask")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExtendedUsageBitInstance {
            context,
            kind: self.kind,
            params: self.params,
        })
    }
}

struct ExtendedUsageBitInstance<'a> {
    context: &'a Context<'a>,
    kind: QueryKind,
    params: TestParams,
}

impl TestInstance for ExtendedUsageBitInstance<'_> {
    /// `testExtendedUsageBitCompatiblity`
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let mut expected: Result<(), vk::ErrorCode> = Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED);

        let mut view_format = vk::Format::from_raw(vk::Format::UNDEFINED.as_raw() + 1);
        while view_format.as_raw() < VK_CORE_FORMAT_LAST {
            if is_compatible_format(view_format, params.image_format)
                && get_physical_device_image_format_properties(
                    self.context,
                    self.kind,
                    view_format,
                    params.tiling,
                    params.usage,
                    vk::ImageCreateFlags::empty(),
                ) == Ok(())
            {
                expected = Ok(());
                break;
            }
            view_format = vk::Format::from_raw(view_format.as_raw() + 1);
        }

        // No compatible view format supports the tested usage
        if view_format.as_raw() == VK_CORE_FORMAT_LAST {
            return Err(TestError::NotSupported(
                "Usage is not supported by any compatible format".to_string(),
            ));
        }

        let res = get_physical_device_image_format_properties(
            self.context,
            self.kind,
            params.image_format,
            params.tiling,
            params.usage,
            vk::ImageCreateFlags::EXTENDED_USAGE | vk::ImageCreateFlags::MUTABLE_FORMAT,
        );

        if res != expected {
            return Ok(TestStatus::fail(format!("Fail: view format {view_format:?}")));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageExtendedUsageBitTests`
pub fn create_image_extended_usage_bit_tests() -> TestCaseGroup {
    let mut image_extended_usage_bit_tests = TestCaseGroup::new("extended_usage_bit_compatibility");
    let mut get_physical_device_image_format_properties_tests = TestCaseGroup::new("image_format_properties");
    let mut get_physical_device_image_format_properties2_tests = TestCaseGroup::new("image_format_properties2");
    let mut get_physical_device_image_format_list_tests = TestCaseGroup::new("image_format_list");

    // The name is `de::toLower(usageName.substr(15))`, i.e. the flag name without `VK_IMAGE_USAGE_`
    let usages: [(vk::ImageUsageFlags, &str); 17] = [
        (vk::ImageUsageFlags::TRANSFER_SRC, "transfer_src_bit"),
        (vk::ImageUsageFlags::TRANSFER_DST, "transfer_dst_bit"),
        (vk::ImageUsageFlags::SAMPLED, "sampled_bit"),
        (vk::ImageUsageFlags::STORAGE, "storage_bit"),
        (vk::ImageUsageFlags::COLOR_ATTACHMENT, "color_attachment_bit"),
        (
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            "depth_stencil_attachment_bit",
        ),
        (vk::ImageUsageFlags::TRANSIENT_ATTACHMENT, "transient_attachment_bit"),
        (vk::ImageUsageFlags::INPUT_ATTACHMENT, "input_attachment_bit"),
        (vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR, "video_decode_dst_bit_khr"),
        (vk::ImageUsageFlags::VIDEO_DECODE_SRC_KHR, "video_decode_src_bit_khr"),
        (vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR, "video_decode_dpb_bit_khr"),
        (
            vk::ImageUsageFlags::FRAGMENT_DENSITY_MAP_EXT,
            "fragment_density_map_bit_ext",
        ),
        (
            vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
            "fragment_shading_rate_attachment_bit_khr",
        ),
        (vk::ImageUsageFlags::VIDEO_ENCODE_DST_KHR, "video_encode_dst_bit_khr"),
        (vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR, "video_encode_src_bit_khr"),
        (vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR, "video_encode_dpb_bit_khr"),
        (
            vk::ImageUsageFlags::INVOCATION_MASK_HUAWEI,
            "invocation_mask_bit_huawei",
        ),
    ];
    // `VK_IMAGE_USAGE_SHADING_RATE_IMAGE_BIT_NV` is the same bit as the fragment shading rate attachment one
    let nv_shading_rate_image = (
        vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
        "shading_rate_image_bit_nv",
    );

    let tiling = [
        (vk::ImageTiling::LINEAR, "linear"),
        (vk::ImageTiling::OPTIMAL, "optimal"),
    ];

    for raw_format in (vk::Format::UNDEFINED.as_raw() + 1)..VK_CORE_FORMAT_LAST {
        let image_format = vk::Format::from_raw(raw_format);
        for (tiling_value, tiling_name) in tiling {
            for (usage, usage_name) in usages.iter().copied().chain(std::iter::once(nv_shading_rate_image)) {
                let params = TestParams {
                    image_format,
                    usage,
                    tiling: tiling_value,
                };
                let name = format!("{}_{}_{}", format_name(image_format), tiling_name, usage_name);
                // Checks usage bit format compatibility among compatible image view formats
                get_physical_device_image_format_properties_tests.add_child(Box::new(ExtendedUsageBitCase {
                    name: name.clone(),
                    kind: QueryKind::Properties,
                    params,
                }) as Box<dyn TestCase>);
                get_physical_device_image_format_properties2_tests.add_child(Box::new(ExtendedUsageBitCase {
                    name: name.clone(),
                    kind: QueryKind::Properties2,
                    params,
                }) as Box<dyn TestCase>);
                get_physical_device_image_format_list_tests.add_child(Box::new(ExtendedUsageBitCase {
                    name,
                    kind: QueryKind::FormatList,
                    params,
                }) as Box<dyn TestCase>);
            }
        }
    }

    image_extended_usage_bit_tests.add_child(get_physical_device_image_format_properties_tests);
    image_extended_usage_bit_tests.add_child(get_physical_device_image_format_properties2_tests);
    image_extended_usage_bit_tests.add_child(get_physical_device_image_format_list_tests);
    image_extended_usage_bit_tests
}
