// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/video/vktVideoCapabilitiesTests.cpp (`createVideoFormatsTests`, namespace `formats`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `video.formats.*`: for a codec, image usage, format, chroma subsampling and bit depth the video format properties of
// the profile must list the format, and vkGetPhysicalDeviceImageFormatProperties2 and the format features must agree with that listing. `VkVideoCoreProfile` is
// `Chain` (profile -> codec profile, plus the profile list chained into the video format query). A format with no texture format of this port is left out of the
// tree instead of panicking while it is built. The cases are returned keyed by their dotted path so `video::create_tests` can swap them in for the gated names.

use std::collections::HashMap;
use std::ffi::c_void;
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;
use vulkanalia::vk::video::{
    STD_VIDEO_AV1_PROFILE_MAIN, STD_VIDEO_H264_PROFILE_IDC_MAIN, STD_VIDEO_H265_PROFILE_IDC_MAIN,
    STD_VIDEO_VP9_PROFILE_0,
};

use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::ycbcr::conversion_util::{get_ycbcr_bit_depth, is_x_chroma_subsampled, is_y_chroma_subsampled};
use crate::vkt::tests::ycbcr::copy_tests::is_ycbcr_format;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy)]
pub(super) struct TestParams {
    pub(super) format: vk::Format,
    pub(super) codec: vk::VideoCodecOperationFlagsKHR,
    pub(super) usage: vk::ImageUsageFlags,
    pub(super) chroma_subsampling: vk::VideoChromaSubsamplingFlagsKHR,
    pub(super) bit_depth: vk::VideoComponentBitDepthFlagsKHR,
}

/// `VkVideoCoreProfile`: the profile with its codec profile and the profile list over it; every structure is boxed so the pointers survive moves
pub(super) struct Chain {
    pub(super) profile: Box<vk::VideoProfileInfoKHR>,
    pub(super) profile_list: Box<vk::VideoProfileListInfoKHR>,
    _codec_profile: Box<dyn std::any::Any>,
}

impl Chain {
    pub(super) fn new(params: &TestParams) -> Self {
        use vk::VideoCodecOperationFlagsKHR as Codec;

        fn boxed<T: std::any::Any>(value: T) -> (Box<dyn std::any::Any>, *const c_void) {
            let boxed = Box::new(value);
            let pointer = ptr::from_ref(&*boxed).cast::<c_void>();
            (boxed, pointer)
        }

        let (codec_profile, codec_profile_ptr) = if params.codec == Codec::DECODE_H264 {
            boxed(vk::VideoDecodeH264ProfileInfoKHR {
                std_profile_idc: STD_VIDEO_H264_PROFILE_IDC_MAIN,
                ..Default::default()
            })
        } else if params.codec == Codec::DECODE_H265 {
            boxed(vk::VideoDecodeH265ProfileInfoKHR {
                std_profile_idc: STD_VIDEO_H265_PROFILE_IDC_MAIN,
                ..Default::default()
            })
        } else if params.codec == Codec::DECODE_AV1 {
            boxed(vk::VideoDecodeAV1ProfileInfoKHR {
                std_profile: STD_VIDEO_AV1_PROFILE_MAIN,
                film_grain_support: vk::FALSE,
                ..Default::default()
            })
        } else if params.codec == Codec::DECODE_VP9 {
            boxed(vk::VideoDecodeVP9ProfileInfoKHR {
                std_profile: STD_VIDEO_VP9_PROFILE_0,
                ..Default::default()
            })
        } else if params.codec == Codec::ENCODE_H264 {
            boxed(vk::VideoEncodeH264ProfileInfoKHR {
                std_profile_idc: STD_VIDEO_H264_PROFILE_IDC_MAIN,
                ..Default::default()
            })
        } else if params.codec == Codec::ENCODE_H265 {
            boxed(vk::VideoEncodeH265ProfileInfoKHR {
                std_profile_idc: STD_VIDEO_H265_PROFILE_IDC_MAIN,
                ..Default::default()
            })
        } else {
            boxed(vk::VideoEncodeAV1ProfileInfoKHR {
                std_profile: STD_VIDEO_AV1_PROFILE_MAIN,
                ..Default::default()
            })
        };

        let profile = Box::new(vk::VideoProfileInfoKHR {
            next: codec_profile_ptr,
            video_codec_operation: params.codec,
            chroma_subsampling: params.chroma_subsampling,
            luma_bit_depth: params.bit_depth,
            chroma_bit_depth: params.bit_depth,
            ..Default::default()
        });
        let profile_list = Box::new(vk::VideoProfileListInfoKHR {
            profile_count: 1,
            profiles: &*profile,
            ..Default::default()
        });
        Self {
            profile,
            profile_list,
            _codec_profile: codec_profile,
        }
    }
}

fn codec_extension(codec: vk::VideoCodecOperationFlagsKHR) -> &'static str {
    use vk::VideoCodecOperationFlagsKHR as Codec;

    if codec == Codec::DECODE_H264 {
        "VK_KHR_video_decode_h264"
    } else if codec == Codec::DECODE_H265 {
        "VK_KHR_video_decode_h265"
    } else if codec == Codec::DECODE_AV1 {
        "VK_KHR_video_decode_av1"
    } else if codec == Codec::DECODE_VP9 {
        "VK_KHR_video_decode_vp9"
    } else if codec == Codec::ENCODE_H264 {
        "VK_KHR_video_encode_h264"
    } else if codec == Codec::ENCODE_H265 {
        "VK_KHR_video_encode_h265"
    } else {
        "VK_KHR_video_encode_av1"
    }
}

/// `getFormatSimpleName`: the format name without `VK_FORMAT_`, lower case
fn format_simple_name(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

/// `getTestName`
fn test_name(params: &TestParams) -> String {
    use vk::{VideoChromaSubsamplingFlagsKHR as Chroma, VideoCodecOperationFlagsKHR as Codec};

    let codec = if params.codec == Codec::DECODE_H264 {
        "decode_h264"
    } else if params.codec == Codec::DECODE_H265 {
        "decode_h265"
    } else if params.codec == Codec::DECODE_AV1 {
        "decode_av1"
    } else if params.codec == Codec::DECODE_VP9 {
        "decode_vp9"
    } else if params.codec == Codec::ENCODE_H264 {
        "encode_h264"
    } else if params.codec == Codec::ENCODE_H265 {
        "encode_h265"
    } else {
        "encode_av1"
    };
    let usage = if params.usage == vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR {
        "_decode_dst"
    } else if params.usage == vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR {
        "_decode_dpb"
    } else if params.usage == vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR {
        "_encode_src"
    } else {
        "_encode_dpb"
    };
    let subsampling = if params.chroma_subsampling == Chroma::MONOCHROME {
        "_monochrome"
    } else if params.chroma_subsampling == Chroma::_420 {
        "_420"
    } else if params.chroma_subsampling == Chroma::_422 {
        "_422"
    } else {
        "_444"
    };
    let bit_depth = if params.bit_depth == vk::VideoComponentBitDepthFlagsKHR::_8 {
        "_8bit"
    } else if params.bit_depth == vk::VideoComponentBitDepthFlagsKHR::_10 {
        "_10bit"
    } else {
        "_12bit"
    };
    format!(
        "{codec}_{}{usage}{subsampling}{bit_depth}",
        format_simple_name(params.format)
    )
}

/// `kUsageToFeatureMap`
fn usage_to_feature(usage: vk::ImageUsageFlags) -> vk::FormatFeatureFlags {
    if usage == vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR {
        vk::FormatFeatureFlags::VIDEO_DECODE_OUTPUT_KHR
    } else if usage == vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR {
        vk::FormatFeatureFlags::VIDEO_DECODE_DPB_KHR
    } else if usage == vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR {
        vk::FormatFeatureFlags::VIDEO_ENCODE_INPUT_KHR
    } else {
        vk::FormatFeatureFlags::VIDEO_ENCODE_DPB_KHR
    }
}

/// `getDrmFormatModifier`: empty when the format has none
fn get_drm_format_modifiers(context: &Context<'_>, format: vk::Format) -> Vec<u64> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut drm_properties = vk::DrmFormatModifierPropertiesList2EXT::default();
    let mut format_properties2 = vk::FormatProperties2 {
        next: ptr::from_mut(&mut drm_properties).cast::<c_void>(),
        ..Default::default()
    };
    unsafe {
        (instance.commands().get_physical_device_format_properties2)(physical_device, format, &mut format_properties2)
    };
    if drm_properties.drm_format_modifier_count == 0 {
        return Vec::new();
    }

    let mut modifiers =
        vec![vk::DrmFormatModifierProperties2EXT::default(); drm_properties.drm_format_modifier_count as usize];
    drm_properties.drm_format_modifier_properties = modifiers.as_mut_ptr();
    unsafe {
        (instance.commands().get_physical_device_format_properties2)(physical_device, format, &mut format_properties2)
    };
    modifiers.iter().map(|modifier| modifier.drm_format_modifier).collect()
}

/// `getVideoFormatProperties`: the formats of the profile for `usage`, NotSupported for the "profile is not supported" results
fn get_video_format_properties(
    context: &Context<'_>,
    chain: &Chain,
    usage: vk::ImageUsageFlags,
) -> Result<Result<Vec<vk::VideoFormatPropertiesKHR>, TestStatus>, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let format_info = vk::PhysicalDeviceVideoFormatInfoKHR {
        next: ptr::from_ref(&*chain.profile_list).cast::<c_void>(),
        image_usage: usage,
        ..Default::default()
    };

    let commands = instance.commands();
    let mut format_count = 0u32;
    let result = unsafe {
        (commands.get_physical_device_video_format_properties_khr)(
            physical_device,
            &format_info,
            &mut format_count,
            ptr::null_mut(),
        )
    };
    match result {
        vk::Result::ERROR_OUT_OF_HOST_MEMORY | vk::Result::ERROR_OUT_OF_DEVICE_MEMORY => {
            return Ok(Err(TestStatus::fail("out of memory error")));
        }
        vk::Result::ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR => {
            return Err(TestError::NotSupported("image usage not supported".to_string()));
        }
        vk::Result::ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR => {
            return Err(TestError::NotSupported("profile operation not supported".to_string()));
        }
        vk::Result::ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR => {
            return Err(TestError::NotSupported("profile format not supported".to_string()));
        }
        vk::Result::ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR => {
            return Err(TestError::NotSupported("picture layout not supported".to_string()));
        }
        vk::Result::ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR => {
            return Err(TestError::NotSupported("codec not supported".to_string()));
        }
        vk::Result::INCOMPLETE => return Ok(Err(TestStatus::fail("invalid incomplete return code"))),
        vk::Result::SUCCESS => {}
        other => {
            return Ok(Err(TestStatus::fail(format!(
                "invalid return code for getPhysicalDeviceVideoFormatPropertiesKHR: {other:?}"
            ))));
        }
    }

    if format_count == 0 {
        return Err(TestError::InternalError(
            "vkGetPhysicalDeviceVideoFormatPropertiesKHR returned VK_SUCCESS with zero formats".to_string(),
        ));
    }

    let mut items = vec![vk::VideoFormatPropertiesKHR::default(); format_count as usize];
    let result = unsafe {
        (commands.get_physical_device_video_format_properties_khr)(
            physical_device,
            &format_info,
            &mut format_count,
            items.as_mut_ptr(),
        )
    };
    if result != vk::Result::SUCCESS {
        return Ok(Err(TestStatus::fail(format!(
            "invalid return code for getPhysicalDeviceVideoFormatPropertiesKHR: {result:?}"
        ))));
    }
    items.truncate(format_count as usize);
    Ok(Ok(items))
}

struct FormatsCase {
    name: String,
    params: TestParams,
}

impl TestCase for FormatsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_video_queue")?;
        context.require_device_functionality(codec_extension(self.params.codec))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FormatsInstance {
            context,
            params: self.params,
        })
    }
}

struct FormatsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for FormatsInstance<'_> {
    /// `formats::test`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let chain = Chain::new(&params);

        let mut format_properties2 = vk::FormatProperties2::default();
        unsafe {
            instance.get_physical_device_format_properties2(physical_device, params.format, &mut format_properties2)
        };
        let usage = params.usage;
        let features = usage_to_feature(usage);

        let video_format_properties = match get_video_format_properties(context, &chain, usage)? {
            Ok(items) => items,
            Err(status) => return Ok(status),
        };

        let mut found_matching_format = false;
        for format_property in &video_format_properties {
            if format_property.format != params.format || !format_property.image_usage_flags.intersects(usage) {
                continue;
            }
            found_matching_format = true;

            let mut count = 1usize;
            let mut drm_modifiers = Vec::new();
            let mut found_compatible_modifier = false;

            if format_property.image_tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT {
                drm_modifiers = get_drm_format_modifiers(context, params.format);
                count = drm_modifiers.len();
                if count == 0 {
                    continue;
                }
            }

            for index in 0..count {
                let image_format_modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT {
                    drm_format_modifier: drm_modifiers.get(index).copied().unwrap_or(0),
                    next: ptr::from_ref(&*chain.profile_list).cast::<c_void>(),
                    ..Default::default()
                };
                let view_formats = [format_property.format];
                let image_format_list_info = vk::ImageFormatListCreateInfo {
                    view_format_count: 1,
                    view_formats: view_formats.as_ptr(),
                    next: if drm_modifiers.is_empty() {
                        ptr::from_ref(&*chain.profile_list).cast::<c_void>()
                    } else {
                        ptr::from_ref(&image_format_modifier_info).cast::<c_void>()
                    },
                    ..Default::default()
                };
                let image_format_info2 = vk::PhysicalDeviceImageFormatInfo2 {
                    next: ptr::from_ref(&image_format_list_info).cast::<c_void>(),
                    format: format_property.format,
                    type_: format_property.image_type,
                    tiling: format_property.image_tiling,
                    usage: format_property.image_usage_flags,
                    flags: format_property.image_create_flags,
                    ..Default::default()
                };
                let mut image_format_properties2 = vk::ImageFormatProperties2::default();
                let result = unsafe {
                    instance.get_physical_device_image_format_properties2(
                        physical_device,
                        &image_format_info2,
                        &mut image_format_properties2,
                    )
                };

                if let Err(code) = result {
                    // Modifier is not compatible
                    if format_property.image_tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT
                        && code == vk::ErrorCode::FORMAT_NOT_SUPPORTED
                    {
                        continue;
                    }
                    return Ok(TestStatus::fail(
                        "inconsistent return values from getPhysicalDeviceImageFormatProperties2 and getPhysicalDeviceVideoFormatPropertiesKHR",
                    ));
                }
                if format_property.image_tiling == vk::ImageTiling::LINEAR
                    && !format_properties2
                        .format_properties
                        .linear_tiling_features
                        .intersects(features)
                {
                    return Ok(TestStatus::fail("bad linear features"));
                }
                if format_property.image_tiling == vk::ImageTiling::OPTIMAL
                    && !format_properties2
                        .format_properties
                        .optimal_tiling_features
                        .intersects(features)
                {
                    return Ok(TestStatus::fail("bad optimal features"));
                }
                found_compatible_modifier = true;
            }

            if format_property.image_tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT && !found_compatible_modifier {
                return Ok(TestStatus::fail("no compatible modifier found"));
            }
        }

        if !found_matching_format {
            return Err(TestError::NotSupported(format!(
                "no video format properties for {:?}",
                params.format
            )));
        }
        Ok(TestStatus::pass("OK"))
    }
}

/// `createVideoFormatsTests`: the cases keyed by their dotted path (`formats.<name>`)
pub fn create_formats_cases() -> HashMap<String, Box<dyn TestCase>> {
    use vk::{
        VideoChromaSubsamplingFlagsKHR as Chroma, VideoCodecOperationFlagsKHR as Codec,
        VideoComponentBitDepthFlagsKHR as Depth,
    };

    const CODECS: [Codec; 7] = [
        Codec::DECODE_H264,
        Codec::DECODE_H265,
        Codec::DECODE_AV1,
        Codec::DECODE_VP9,
        Codec::ENCODE_H264,
        Codec::ENCODE_H265,
        Codec::ENCODE_AV1,
    ];
    const FORMATS: [vk::Format; 62] = [
        vk::Format::R8_UNORM,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8B8_UNORM,
        vk::Format::B8G8R8_UNORM,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SRGB,
        vk::Format::B8G8R8A8_SNORM,
        vk::Format::B8G8R8A8_USCALED,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A2R10G10B10_UNORM_PACK32,
        vk::Format::R16_UNORM,
        vk::Format::R16G16_UNORM,
        vk::Format::R16G16B16_UNORM,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R32_UINT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32B32_UINT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R64_UINT,
        vk::Format::R64G64_UINT,
        vk::Format::R64G64B64_UINT,
        vk::Format::R64G64B64A64_UINT,
        vk::Format::G8B8G8R8_422_UNORM,
        vk::Format::G8_B8_R8_3PLANE_420_UNORM,
        vk::Format::G8_B8R8_2PLANE_420_UNORM,
        vk::Format::G8_B8_R8_3PLANE_422_UNORM,
        vk::Format::G8_B8R8_2PLANE_422_UNORM,
        vk::Format::G8_B8_R8_3PLANE_444_UNORM,
        vk::Format::R10X6_UNORM_PACK16,
        vk::Format::R10X6G10X6_UNORM_2PACK16,
        vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16,
        vk::Format::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16,
        vk::Format::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16,
        vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16,
        vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16,
        vk::Format::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16,
        vk::Format::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16,
        vk::Format::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16,
        vk::Format::R12X4_UNORM_PACK16,
        vk::Format::R12X4G12X4_UNORM_2PACK16,
        vk::Format::R12X4G12X4B12X4A12X4_UNORM_4PACK16,
        vk::Format::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16,
        vk::Format::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16,
        vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16,
        vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16,
        vk::Format::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16,
        vk::Format::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16,
        vk::Format::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16,
        vk::Format::G16B16G16R16_422_UNORM,
        vk::Format::B16G16R16G16_422_UNORM,
        vk::Format::G16_B16_R16_3PLANE_420_UNORM,
        vk::Format::G16_B16R16_2PLANE_420_UNORM,
        vk::Format::G16_B16_R16_3PLANE_422_UNORM,
        vk::Format::G16_B16R16_2PLANE_422_UNORM,
        vk::Format::G16_B16_R16_3PLANE_444_UNORM,
        vk::Format::G8_B8R8_2PLANE_444_UNORM,
        vk::Format::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16,
        vk::Format::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16,
        vk::Format::G16_B16R16_2PLANE_444_UNORM,
        vk::Format::A4R4G4B4_UNORM_PACK16,
        vk::Format::A4B4G4R4_UNORM_PACK16,
    ];
    const USAGES: [vk::ImageUsageFlags; 4] = [
        vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR,
        vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR,
        vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR,
        vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR,
    ];
    let subsampling_flags = [Chroma::MONOCHROME, Chroma::_420, Chroma::_422, Chroma::_444];
    let bit_depths = [(Depth::_8, 8u32), (Depth::_10, 10), (Depth::_12, 12)];

    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for codec in CODECS {
        for usage in USAGES {
            for format in FORMATS {
                for subsampling in subsampling_flags {
                    for (bit_depth, bit_depth_as_int) in bit_depths {
                        if !is_ycbcr_format(format) {
                            // In order to reduce the number of tests, only multiplanar formats are checked for anything other than ENCODE_SRC resources,
                            // since it's very unlikely other formats could be supported for those resources.
                            if usage != vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR {
                                continue;
                            }
                            if subsampling != Chroma::MONOCHROME {
                                continue;
                            }
                            // `get_ycbcr_bit_depth` needs a texture format for these
                            if map_vk_format(format).is_none() {
                                continue;
                            }
                        }

                        if bit_depth_as_int != get_ycbcr_bit_depth(format)[0] {
                            continue;
                        }

                        let x_subsampled = is_x_chroma_subsampled(format);
                        let y_subsampled = is_y_chroma_subsampled(format);
                        if (subsampling == Chroma::_420 && (!x_subsampled || !y_subsampled))
                            || (subsampling == Chroma::_422 && (!x_subsampled || y_subsampled))
                            || (subsampling == Chroma::_444 && (x_subsampled || y_subsampled))
                        {
                            continue;
                        }

                        let params = TestParams {
                            format,
                            codec,
                            usage,
                            chroma_subsampling: subsampling,
                            bit_depth,
                        };
                        let name = test_name(&params);
                        cases.insert(format!("formats.{name}"), Box::new(FormatsCase { name, params }));
                    }
                }
            }
        }
    }
    cases
}
