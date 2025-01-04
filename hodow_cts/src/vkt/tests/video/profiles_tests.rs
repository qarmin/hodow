// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/video/vktVideoProfilesValidationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `video.profiles.{decode,encode}.*`: for every codec, subsampling, bit depth and codec profile the test queries
// vkGetPhysicalDeviceVideoCapabilitiesKHR, checks the answer against the profile compatibility rules (`validate_profile_codec`), then checks the video formats of the
// profile against vkGetPhysicalDeviceFormatProperties2 and vkGetPhysicalDeviceImageFormatProperties2 and creates a video session for every image and DPB format pair.
// `VideoBaseTestInstance::getDeviceSupportingQueue` is `create_video_device`: a device of its own with one queue of a family for the transfer and one for the decode or
// encode operation (the codec extensions, synchronization2, VK_KHR_video_maintenance1 when the device has it, and the VP9 feature). The output arrays of the
// two vkGetPhysicalDeviceVideo* and queue family queries are filled in through the raw command pointers because the vulkanalia wrappers leave their sType unset.
// The cases are returned keyed by their dotted path so `video::create_tests` can swap them in for the gated names.

use std::any::Any;
use std::collections::{BTreeSet, HashMap};
use std::ffi::{CString, c_void};
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::video::{
    STD_VIDEO_AV1_PROFILE_HIGH, STD_VIDEO_AV1_PROFILE_MAIN, STD_VIDEO_AV1_PROFILE_PROFESSIONAL,
    STD_VIDEO_H264_PROFILE_IDC_BASELINE, STD_VIDEO_H264_PROFILE_IDC_HIGH,
    STD_VIDEO_H264_PROFILE_IDC_HIGH_444_PREDICTIVE, STD_VIDEO_H264_PROFILE_IDC_MAIN,
    STD_VIDEO_H265_PROFILE_IDC_FORMAT_RANGE_EXTENSIONS, STD_VIDEO_H265_PROFILE_IDC_MAIN,
    STD_VIDEO_H265_PROFILE_IDC_MAIN_10, STD_VIDEO_H265_PROFILE_IDC_MAIN_STILL_PICTURE,
    STD_VIDEO_H265_PROFILE_IDC_SCC_EXTENSIONS, STD_VIDEO_VP9_PROFILE_0, STD_VIDEO_VP9_PROFILE_1,
    STD_VIDEO_VP9_PROFILE_2, STD_VIDEO_VP9_PROFILE_3, StdVideoAV1Profile, StdVideoH264ProfileIdc,
    StdVideoH265ProfileIdc, StdVideoVP9Profile,
};
use vulkanalia::vk::{
    DeviceV1_1, InstanceV1_1, KhrVideoQueueExtensionDeviceCommands, KhrVideoQueueExtensionInstanceCommands,
};

use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::ycbcr::conversion_util::get_ycbcr_bit_depth;
use crate::vkt::tests::ycbcr::copy_tests::is_ycbcr_format;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy)]
enum CodecProfile {
    H264Dec {
        profile: StdVideoH264ProfileIdc,
        layout: vk::VideoDecodeH264PictureLayoutFlagsKHR,
    },
    H265Dec(StdVideoH265ProfileIdc),
    Av1Dec {
        profile: StdVideoAV1Profile,
        film_grain: bool,
    },
    Vp9Dec(StdVideoVP9Profile),
    H264Enc(StdVideoH264ProfileIdc),
    H265Enc(StdVideoH265ProfileIdc),
    Av1Enc(StdVideoAV1Profile),
}

/// `TestParams`: the profile of a case; the structures upstream keeps in it are built by `Chain` for the run
#[derive(Clone, Copy)]
struct TestParams {
    codec_profile: CodecProfile,
    codec_operation: vk::VideoCodecOperationFlagsKHR,
    chroma_subsampling: vk::VideoChromaSubsamplingFlagsKHR,
    luma_bit_depth: vk::VideoComponentBitDepthFlagsKHR,
    chroma_bit_depth: vk::VideoComponentBitDepthFlagsKHR,
}

impl TestParams {
    fn is_decode(&self) -> bool {
        matches!(
            self.codec_profile,
            CodecProfile::H264Dec { .. }
                | CodecProfile::H265Dec(_)
                | CodecProfile::Av1Dec { .. }
                | CodecProfile::Vp9Dec(_)
        )
    }

    fn is_encode(&self) -> bool {
        !self.is_decode()
    }
}

/// The structure chains upstream keeps in `TestParams`: profile -> codec profile, capabilities -> decode or encode capabilities -> codec capabilities. Every structure
/// is boxed so the pointers between them survive moving the `Chain`.
struct Chain {
    profile: Box<vk::VideoProfileInfoKHR>,
    video_caps: Box<vk::VideoCapabilitiesKHR>,
    decode_caps: Box<vk::VideoDecodeCapabilitiesKHR>,
    encode_caps: Box<vk::VideoEncodeCapabilitiesKHR>,
    _codec_profile: Box<dyn Any>,
    _codec_caps: Box<dyn Any>,
}

fn boxed<T: Any>(value: T) -> (Box<dyn Any>, *mut c_void) {
    let mut boxed = Box::new(value);
    let pointer = ptr::from_mut(&mut *boxed).cast::<c_void>();
    (boxed, pointer)
}

impl Chain {
    fn new(params: &TestParams) -> Self {
        let (codec_profile, codec_profile_ptr, codec_caps, codec_caps_ptr): (
            Box<dyn Any>,
            *mut c_void,
            Box<dyn Any>,
            *mut c_void,
        ) = match params.codec_profile {
            CodecProfile::H264Dec { profile, layout } => {
                let (p, pp) = boxed(vk::VideoDecodeH264ProfileInfoKHR {
                    std_profile_idc: profile,
                    picture_layout: layout,
                    ..Default::default()
                });
                let (c, cp) = boxed(vk::VideoDecodeH264CapabilitiesKHR::default());
                (p, pp, c, cp)
            }
            CodecProfile::H265Dec(profile) => {
                let (p, pp) = boxed(vk::VideoDecodeH265ProfileInfoKHR {
                    std_profile_idc: profile,
                    ..Default::default()
                });
                let (c, cp) = boxed(vk::VideoDecodeH265CapabilitiesKHR::default());
                (p, pp, c, cp)
            }
            CodecProfile::Av1Dec { profile, film_grain } => {
                let (p, pp) = boxed(vk::VideoDecodeAV1ProfileInfoKHR {
                    std_profile: profile,
                    film_grain_support: film_grain as vk::Bool32,
                    ..Default::default()
                });
                let (c, cp) = boxed(vk::VideoDecodeAV1CapabilitiesKHR::default());
                (p, pp, c, cp)
            }
            CodecProfile::Vp9Dec(profile) => {
                let (p, pp) = boxed(vk::VideoDecodeVP9ProfileInfoKHR {
                    std_profile: profile,
                    ..Default::default()
                });
                let (c, cp) = boxed(vk::VideoDecodeVP9CapabilitiesKHR::default());
                (p, pp, c, cp)
            }
            CodecProfile::H264Enc(profile) => {
                let (p, pp) = boxed(vk::VideoEncodeH264ProfileInfoKHR {
                    std_profile_idc: profile,
                    ..Default::default()
                });
                let (c, cp) = boxed(vk::VideoEncodeH264CapabilitiesKHR::default());
                (p, pp, c, cp)
            }
            CodecProfile::H265Enc(profile) => {
                let (p, pp) = boxed(vk::VideoEncodeH265ProfileInfoKHR {
                    std_profile_idc: profile,
                    ..Default::default()
                });
                let (c, cp) = boxed(vk::VideoEncodeH265CapabilitiesKHR::default());
                (p, pp, c, cp)
            }
            CodecProfile::Av1Enc(profile) => {
                let (p, pp) = boxed(vk::VideoEncodeAV1ProfileInfoKHR {
                    std_profile: profile,
                    ..Default::default()
                });
                let (c, cp) = boxed(vk::VideoEncodeAV1CapabilitiesKHR::default());
                (p, pp, c, cp)
            }
        };

        let profile = Box::new(vk::VideoProfileInfoKHR {
            next: codec_profile_ptr.cast_const(),
            video_codec_operation: params.codec_operation,
            chroma_subsampling: params.chroma_subsampling,
            luma_bit_depth: params.luma_bit_depth,
            chroma_bit_depth: params.chroma_bit_depth,
            ..Default::default()
        });
        let mut decode_caps = Box::new(vk::VideoDecodeCapabilitiesKHR::default());
        let mut encode_caps = Box::new(vk::VideoEncodeCapabilitiesKHR::default());
        let video_caps_next = if params.is_decode() {
            decode_caps.next = codec_caps_ptr;
            ptr::from_mut(&mut *decode_caps).cast::<c_void>()
        } else {
            encode_caps.next = codec_caps_ptr;
            ptr::from_mut(&mut *encode_caps).cast::<c_void>()
        };
        let video_caps = Box::new(vk::VideoCapabilitiesKHR {
            next: video_caps_next,
            ..Default::default()
        });

        Self {
            profile,
            video_caps,
            decode_caps,
            encode_caps,
            _codec_profile: codec_profile,
            _codec_caps: codec_caps,
        }
    }
}

fn component_bit_depth(flags: vk::VideoComponentBitDepthFlagsKHR) -> Result<u32, TestError> {
    if flags == vk::VideoComponentBitDepthFlagsKHR::_8 {
        Ok(8)
    } else if flags == vk::VideoComponentBitDepthFlagsKHR::_10 {
        Ok(10)
    } else if flags == vk::VideoComponentBitDepthFlagsKHR::_12 {
        Ok(12)
    } else {
        Err(TestError::InternalError("unknown component bit depth".to_string()))
    }
}

/// The video device of `VideoBaseTestInstance`
struct VideoDevice {
    device: Device,
    decode_queue_family_index: u32,
    encode_queue_family_index: u32,
}

impl Drop for VideoDevice {
    fn drop(&mut self) {
        unsafe { self.device.destroy_device(None) };
    }
}

/// `VideoDevice::createDeviceSupportingQueue` with `VIDEO_DEVICE_FLAG_REQUIRE_SYNC2_OR_NOT_SUPPORTED`, optionally VP9 decode and video maintenance1
fn create_video_device(context: &Context<'_>, params: &TestParams) -> Result<VideoDevice, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let queue_flags_required = vk::QueueFlags::TRANSFER
        | if params.is_decode() {
            vk::QueueFlags::VIDEO_DECODE_KHR
        } else {
            vk::QueueFlags::VIDEO_ENCODE_KHR
        };
    let require_vp9_decode = params.codec_operation == vk::VideoCodecOperationFlagsKHR::DECODE_VP9;
    let require_maintenance1 = context.is_device_functionality_supported("VK_KHR_video_maintenance1");

    // Queue family properties with the video structures chained, through the raw command so every sType is set
    let mut family_count = 0u32;
    let commands = instance.commands();
    unsafe {
        (commands.get_physical_device_queue_family_properties2)(physical_device, &mut family_count, ptr::null_mut())
    };
    if family_count == 0 {
        return Err(TestError::Fail(
            "Device reports an empty set of queue family properties".to_string(),
        ));
    }
    let mut status_properties = vec![vk::QueueFamilyQueryResultStatusPropertiesKHR::default(); family_count as usize];
    let mut video_properties = vec![vk::QueueFamilyVideoPropertiesKHR::default(); family_count as usize];
    let mut family_properties = vec![vk::QueueFamilyProperties2::default(); family_count as usize];
    for index in 0..family_count as usize {
        video_properties[index].next = ptr::from_mut(&mut status_properties[index]).cast::<c_void>();
        family_properties[index].next = ptr::from_mut(&mut video_properties[index]).cast::<c_void>();
    }
    unsafe {
        (commands.get_physical_device_queue_family_properties2)(
            physical_device,
            &mut family_count,
            family_properties.as_mut_ptr(),
        )
    };

    let queue_priority = [1.0f32];
    let mut queue_family_transfer = None;
    let mut queue_family_decode = None;
    let mut queue_family_encode = None;
    let mut queue_flags_found = vk::QueueFlags::empty();
    let mut queue_infos: Vec<vk::DeviceQueueCreateInfo> = Vec::new();

    for index in 0..family_count as usize {
        let properties = &family_properties[index].queue_family_properties;
        let useful_queue_flags = properties.queue_flags & queue_flags_required & !queue_flags_found;
        if useful_queue_flags.is_empty() {
            continue;
        }

        let mut assigned = false;
        if useful_queue_flags.contains(vk::QueueFlags::TRANSFER) && queue_family_transfer.is_none() {
            queue_family_transfer = Some(index as u32);
            assigned = true;
        }
        if video_properties[index]
            .video_codec_operations
            .intersects(params.codec_operation)
        {
            if useful_queue_flags.contains(vk::QueueFlags::VIDEO_DECODE_KHR) && queue_family_decode.is_none() {
                queue_family_decode = Some(index as u32);
                assigned = true;
            }
            if useful_queue_flags.contains(vk::QueueFlags::VIDEO_ENCODE_KHR) && queue_family_encode.is_none() {
                queue_family_encode = Some(index as u32);
                assigned = true;
            }
        }

        if assigned {
            if properties.queue_count == 0 {
                return Err(TestError::Fail("Video queue returned queueCount is zero".to_string()));
            }
            queue_infos.push(
                vk::DeviceQueueCreateInfo::builder()
                    .queue_family_index(index as u32)
                    .queue_priorities(&queue_priority)
                    .build(),
            );
            queue_flags_found |= useful_queue_flags;
            if queue_flags_found == queue_flags_required {
                break;
            }
        }
    }
    if queue_flags_found != queue_flags_required {
        return Err(TestError::NotSupported(
            "No queue family supports the video operation".to_string(),
        ));
    }

    // addVideoDeviceExtensions
    let mut extensions = vec!["VK_KHR_video_queue"];
    extensions.push(if params.is_decode() {
        "VK_KHR_video_decode_queue"
    } else {
        "VK_KHR_video_encode_queue"
    });
    extensions.push(match params.codec_profile {
        CodecProfile::H264Dec { .. } => "VK_KHR_video_decode_h264",
        CodecProfile::H265Dec(_) => "VK_KHR_video_decode_h265",
        CodecProfile::Av1Dec { .. } => "VK_KHR_video_decode_av1",
        CodecProfile::Vp9Dec(_) => "VK_KHR_video_decode_vp9",
        CodecProfile::H264Enc(_) => "VK_KHR_video_encode_h264",
        CodecProfile::H265Enc(_) => "VK_KHR_video_encode_h265",
        CodecProfile::Av1Enc(_) => "VK_KHR_video_encode_av1",
    });
    if context.api_version() < (1, 3, 0) {
        extensions.push("VK_KHR_synchronization2");
    }
    if require_maintenance1 {
        extensions.push("VK_KHR_video_maintenance1");
    }

    let mut synchronization2_features = vk::PhysicalDeviceSynchronization2Features::default();
    let mut maintenance1_features = vk::PhysicalDeviceVideoMaintenance1FeaturesKHR::default();
    let mut decode_vp9_features = vk::PhysicalDeviceVideoDecodeVP9FeaturesKHR::default();
    // The features chain: synchronization2 -> maintenance1 (if required) -> VP9 (if required)
    decode_vp9_features.next = ptr::null_mut();
    maintenance1_features.next = if require_vp9_decode {
        ptr::from_mut(&mut decode_vp9_features).cast::<c_void>()
    } else {
        ptr::null_mut()
    };
    synchronization2_features.next = if require_maintenance1 {
        ptr::from_mut(&mut maintenance1_features).cast::<c_void>()
    } else if require_vp9_decode {
        ptr::from_mut(&mut decode_vp9_features).cast::<c_void>()
    } else {
        ptr::null_mut()
    };
    let mut features2 = vk::PhysicalDeviceFeatures2 {
        next: ptr::from_mut(&mut synchronization2_features).cast::<c_void>(),
        ..Default::default()
    };
    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
    features2.features.robust_buffer_access = vk::FALSE;

    if synchronization2_features.synchronization2 == vk::FALSE {
        return Err(TestError::NotSupported(
            "synchronization2Features.synchronization2 is required".to_string(),
        ));
    }
    if require_maintenance1 && maintenance1_features.video_maintenance1 == vk::FALSE {
        return Err(TestError::NotSupported(
            "videoMaintenance1 feature is required".to_string(),
        ));
    }
    if require_vp9_decode && decode_vp9_features.video_decode_vp9 == vk::FALSE {
        return Err(TestError::NotSupported(
            "videoDecodeVP9 feature is required".to_string(),
        ));
    }

    let extension_names = extensions
        .iter()
        .map(|extension| CString::new(*extension).map_err(|e| TestError::InternalError(e.to_string())))
        .collect::<Result<Vec<_>, _>>()?;
    let extension_ptrs: Vec<*const std::ffi::c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();
    let info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extension_ptrs)
        .push_next(&mut features2);
    let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;

    Ok(VideoDevice {
        device,
        decode_queue_family_index: queue_family_decode.unwrap_or(vk::QUEUE_FAMILY_IGNORED),
        encode_queue_family_index: queue_family_encode.unwrap_or(vk::QUEUE_FAMILY_IGNORED),
    })
}

/// `validateProfileCodec`: whether the profile of `params` is one the codec allows
fn validate_profile_codec(params: &TestParams) -> Result<bool, TestError> {
    use vk::{VideoChromaSubsamplingFlagsKHR as Chroma, VideoComponentBitDepthFlagsKHR as Depth};

    let mut chroma_subsampling = Chroma::MONOCHROME | Chroma::_420 | Chroma::_422 | Chroma::_444;
    let mut bit_depth = Depth::_8 | Depth::_10 | Depth::_12;
    let mut should_same_bit_depth = false;

    let h264_rules = |profile_idc: StdVideoH264ProfileIdc, chroma: &mut Chroma, depth: &mut Depth| {
        if profile_idc == STD_VIDEO_H264_PROFILE_IDC_BASELINE || profile_idc == STD_VIDEO_H264_PROFILE_IDC_MAIN {
            // These profiles only support 8-bit, 4:2:0
            *chroma = Chroma::_420;
            *depth = Depth::_8;
        } else if profile_idc == STD_VIDEO_H264_PROFILE_IDC_HIGH {
            // only support monochrome/8-bit, 4:2:0
            *chroma = Chroma::MONOCHROME | Chroma::_420;
            *depth = Depth::_8;
        }
    };
    let h265_rules = |profile_idc: StdVideoH265ProfileIdc, chroma: &mut Chroma, depth: &mut Depth| {
        if profile_idc == STD_VIDEO_H265_PROFILE_IDC_MAIN
            || profile_idc == STD_VIDEO_H265_PROFILE_IDC_MAIN_STILL_PICTURE
        {
            // Main profile: 8-bit, 4:2:0 only
            *chroma = Chroma::_420;
            *depth = Depth::_8;
        } else if profile_idc == STD_VIDEO_H265_PROFILE_IDC_MAIN_10 {
            // Main 10 profile: 8/10-bit, 4:2:0 only
            *chroma = Chroma::_420;
            *depth = Depth::_8 | Depth::_10;
        }
    };

    match params.codec_profile {
        CodecProfile::H264Dec { profile, .. } | CodecProfile::H264Enc(profile) => {
            h264_rules(profile, &mut chroma_subsampling, &mut bit_depth)
        }
        CodecProfile::H265Dec(profile) | CodecProfile::H265Enc(profile) => {
            h265_rules(profile, &mut chroma_subsampling, &mut bit_depth)
        }
        CodecProfile::Av1Dec { profile, .. } | CodecProfile::Av1Enc(profile) => {
            if params.chroma_subsampling != Chroma::MONOCHROME && params.luma_bit_depth != params.chroma_bit_depth {
                should_same_bit_depth = true;
            } else if profile == STD_VIDEO_AV1_PROFILE_MAIN {
                // Main profile: 8-bit or 10-bit, monochrome/4:2:0 only
                chroma_subsampling = Chroma::MONOCHROME | Chroma::_420;
                bit_depth = Depth::_8 | Depth::_10;
            } else if profile == STD_VIDEO_AV1_PROFILE_HIGH {
                // High profile: 8-bit or 10-bit, monochrome/4:2:0 or 4:4:4
                chroma_subsampling = Chroma::MONOCHROME | Chroma::_420 | Chroma::_444;
                bit_depth = Depth::_8 | Depth::_10;
            }
        }
        CodecProfile::Vp9Dec(profile) => {
            if params.luma_bit_depth != params.chroma_bit_depth {
                should_same_bit_depth = true;
            } else {
                if profile == STD_VIDEO_VP9_PROFILE_0 || profile == STD_VIDEO_VP9_PROFILE_2 {
                    // Should only support 4:2:0
                    chroma_subsampling = Chroma::_420;
                } else if profile == STD_VIDEO_VP9_PROFILE_1 || profile == STD_VIDEO_VP9_PROFILE_3 {
                    // Should support 4:2:2 or 4:4:4
                    chroma_subsampling = Chroma::_422 | Chroma::_444;
                } else {
                    return Err(TestError::InternalError("unknown vp9 profile".to_string()));
                }

                if profile == STD_VIDEO_VP9_PROFILE_0 || profile == STD_VIDEO_VP9_PROFILE_1 {
                    // 8-bit only
                    bit_depth = Depth::_8;
                } else {
                    // 10-bit or 12-bit (not 8-bit)
                    bit_depth = Depth::_10 | Depth::_12;
                }
            }
        }
    }

    if should_same_bit_depth {
        return Ok(false);
    }
    if !params.chroma_subsampling.intersects(chroma_subsampling) {
        return Ok(false);
    }
    if !params.luma_bit_depth.intersects(bit_depth) || !params.chroma_bit_depth.intersects(bit_depth) {
        return Ok(false);
    }
    Ok(true)
}

/// `VK_STD_VULKAN_VIDEO_CODEC_*_{EXTENSION_NAME,SPEC_VERSION}` of the codec operation (the constants are not in vulkanalia), all of them `VK_MAKE_VIDEO_STD_VERSION(1, 0, 0)`
fn std_header_version(operation: vk::VideoCodecOperationFlagsKHR) -> Option<vk::ExtensionProperties> {
    const VIDEO_STD_VERSION_1_0_0: u32 = 1 << 22;

    let name = if operation == vk::VideoCodecOperationFlagsKHR::DECODE_H264 {
        "VK_STD_vulkan_video_codec_h264_decode"
    } else if operation == vk::VideoCodecOperationFlagsKHR::DECODE_H265 {
        "VK_STD_vulkan_video_codec_h265_decode"
    } else if operation == vk::VideoCodecOperationFlagsKHR::DECODE_AV1 {
        "VK_STD_vulkan_video_codec_av1_decode"
    } else if operation == vk::VideoCodecOperationFlagsKHR::DECODE_VP9 {
        "VK_STD_vulkan_video_codec_vp9_decode"
    } else if operation == vk::VideoCodecOperationFlagsKHR::ENCODE_H264 {
        "VK_STD_vulkan_video_codec_h264_encode"
    } else if operation == vk::VideoCodecOperationFlagsKHR::ENCODE_H265 {
        "VK_STD_vulkan_video_codec_h265_encode"
    } else if operation == vk::VideoCodecOperationFlagsKHR::ENCODE_AV1 {
        "VK_STD_vulkan_video_codec_av1_encode"
    } else {
        return None;
    };
    let mut properties = vk::ExtensionProperties::default();
    let mut extension_name = [0 as std::ffi::c_char; 256];
    for (destination, source) in extension_name.iter_mut().zip(name.bytes()) {
        *destination = source as _;
    }
    properties.extension_name = vk::StringArray::new(extension_name);
    properties.spec_version = VIDEO_STD_VERSION_1_0_0;
    Some(properties)
}

struct ProfilesInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl ProfilesInstance<'_> {
    /// `tryCreateVideoSession`
    fn try_create_video_session(
        &self,
        video_device: &VideoDevice,
        chain: &Chain,
        image_format: vk::Format,
        dpb_format: vk::Format,
    ) -> TestStatus {
        let queue_family_index = if self.params.is_encode() {
            video_device.encode_queue_family_index
        } else {
            video_device.decode_queue_family_index
        };
        let Some(std_header_version) = std_header_version(self.params.codec_operation) else {
            return TestStatus::fail("unsupported codec");
        };
        let create_info = vk::VideoSessionCreateInfoKHR {
            video_profile: &*chain.profile,
            queue_family_index,
            picture_format: image_format,
            max_coded_extent: chain.video_caps.max_coded_extent,
            max_dpb_slots: chain.video_caps.max_dpb_slots,
            max_active_reference_pictures: chain.video_caps.max_active_reference_pictures,
            reference_picture_format: dpb_format,
            std_header_version: &std_header_version,
            ..Default::default()
        };

        match unsafe { video_device.device.create_video_session_khr(&create_info, None) } {
            Ok(video_session) => {
                unsafe { video_device.device.destroy_video_session_khr(video_session, None) };
                TestStatus::pass("OK")
            }
            Err(code) => TestStatus::fail(format!("Failed to create a video session with {code:?}")),
        }
    }

    /// `validateWithFormatProperties`
    fn validate_with_format_properties(
        &self,
        video_format: &vk::VideoFormatPropertiesKHR,
        usage: vk::ImageUsageFlags,
    ) -> TestStatus {
        let context = self.context;
        let mut format_properties2 = vk::FormatProperties2::default();
        unsafe {
            context.get_instance().get_physical_device_format_properties2(
                context.get_physical_device(),
                video_format.format,
                &mut format_properties2,
            )
        };

        let mut features = vk::FormatFeatureFlags::empty();
        if self.params.is_decode() {
            if usage.contains(vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR) {
                features |= vk::FormatFeatureFlags::VIDEO_DECODE_OUTPUT_KHR;
            }
            if usage.contains(vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR) {
                features |= vk::FormatFeatureFlags::VIDEO_DECODE_DPB_KHR;
            }
        } else {
            if usage.contains(vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR) {
                features |= vk::FormatFeatureFlags::VIDEO_ENCODE_INPUT_KHR;
            }
            if usage.contains(vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR) {
                features |= vk::FormatFeatureFlags::VIDEO_ENCODE_DPB_KHR;
            }
        }

        if video_format.image_tiling == vk::ImageTiling::LINEAR {
            if !format_properties2
                .format_properties
                .linear_tiling_features
                .intersects(features)
            {
                return TestStatus::fail("Not aligned with linear features");
            }
        } else if video_format.image_tiling == vk::ImageTiling::OPTIMAL
            && !format_properties2
                .format_properties
                .optimal_tiling_features
                .intersects(features)
        {
            return TestStatus::fail("Not aligned with optimal features");
        }
        TestStatus::pass("OK")
    }

    /// `getDrmFormatModifier`
    fn get_drm_format_modifiers(&self, format: vk::Format) -> Result<Vec<u64>, TestError> {
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut drm_properties = vk::DrmFormatModifierPropertiesList2EXT::default();
        let mut format_properties2 = vk::FormatProperties2 {
            next: ptr::from_mut(&mut drm_properties).cast::<c_void>(),
            ..Default::default()
        };
        unsafe {
            (instance.commands().get_physical_device_format_properties2)(
                physical_device,
                format,
                &mut format_properties2,
            )
        };
        if drm_properties.drm_format_modifier_count == 0 {
            return Err(TestError::NotSupported(format!(
                "No DRM format modifier found for {format:?}"
            )));
        }

        let mut modifiers =
            vec![vk::DrmFormatModifierProperties2EXT::default(); drm_properties.drm_format_modifier_count as usize];
        drm_properties.drm_format_modifier_properties = modifiers.as_mut_ptr();
        unsafe {
            (instance.commands().get_physical_device_format_properties2)(
                physical_device,
                format,
                &mut format_properties2,
            )
        };
        Ok(modifiers.iter().map(|modifier| modifier.drm_format_modifier).collect())
    }

    /// `validateWithImageFormatProperties`
    fn validate_with_image_format_properties(
        &self,
        chain: &Chain,
        video_format: &vk::VideoFormatPropertiesKHR,
        usage: vk::ImageUsageFlags,
    ) -> TestOutcome {
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut required_create_flags = vk::ImageCreateFlags::empty();
        let mut required_usage_flags = vk::ImageUsageFlags::empty();
        if self.params.is_decode() {
            if usage.contains(vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR) {
                required_usage_flags |= vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR;
            }
            if usage.contains(vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR) {
                required_usage_flags |= vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::SAMPLED;
                if is_ycbcr_format(video_format.format) {
                    required_create_flags |=
                        vk::ImageCreateFlags::MUTABLE_FORMAT | vk::ImageCreateFlags::EXTENDED_USAGE;
                }
            }
        } else {
            if usage.contains(vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR) {
                required_usage_flags |= vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR;
            }
            if usage.contains(vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR) {
                required_usage_flags |= vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR | vk::ImageUsageFlags::TRANSFER_DST;
                if is_ycbcr_format(video_format.format) {
                    required_create_flags |=
                        vk::ImageCreateFlags::MUTABLE_FORMAT | vk::ImageCreateFlags::EXTENDED_USAGE;
                }
            }
        }

        let enough_image_create_flags = video_format.image_create_flags.contains(required_create_flags);
        let enough_image_usage_flags = video_format.image_usage_flags.contains(required_usage_flags);

        let mut drm_modifiers = Vec::new();
        let mut count = 1usize;
        let mut found_compatible_modifier = false;

        if video_format.image_tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT {
            drm_modifiers = self.get_drm_format_modifiers(video_format.format)?;
            count = drm_modifiers.len();
            if count == 0 {
                return Ok(TestStatus::fail(
                    "The number of DRM modifier is 0 even though it is exposed to be supported.",
                ));
            }
        }

        for index in 0..count {
            let profile_list = vk::VideoProfileListInfoKHR {
                profile_count: 1,
                profiles: &*chain.profile,
                ..Default::default()
            };
            let image_format_modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT {
                drm_format_modifier: drm_modifiers.get(index).copied().unwrap_or(0),
                next: ptr::from_ref(&profile_list).cast::<c_void>(),
                ..Default::default()
            };
            let view_formats = [video_format.format];
            let image_format_list_info = vk::ImageFormatListCreateInfo {
                view_format_count: 1,
                view_formats: view_formats.as_ptr(),
                next: if drm_modifiers.is_empty() {
                    ptr::from_ref(&profile_list).cast::<c_void>()
                } else {
                    ptr::from_ref(&image_format_modifier_info).cast::<c_void>()
                },
                ..Default::default()
            };
            let image_format_info2 = vk::PhysicalDeviceImageFormatInfo2 {
                next: ptr::from_ref(&image_format_list_info).cast::<c_void>(),
                format: video_format.format,
                type_: video_format.image_type,
                tiling: video_format.image_tiling,
                usage: required_usage_flags,
                flags: required_create_flags,
                ..Default::default()
            };
            let mut image_format_properties2 = vk::ImageFormatProperties2::default();

            if let Err(code) = unsafe {
                instance.get_physical_device_image_format_properties2(
                    physical_device,
                    &image_format_info2,
                    &mut image_format_properties2,
                )
            } {
                // Modifier is not compatible
                if video_format.image_tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT
                    && code == vk::ErrorCode::FORMAT_NOT_SUPPORTED
                {
                    continue;
                }
                return Ok(TestStatus::fail(format!(
                    "Failed query call to vkGetPhysicalDeviceImageFormatPropertiesKHR with {code:?}"
                )));
            }

            // vkGetPhysicalDeviceImageFormatProperties2 succeeds with the required usages, so the queried video format has to list them too
            if !enough_image_usage_flags {
                return Ok(TestStatus::new(
                    TestResult::CompatibilityWarning,
                    "The video format doesn't have enough image usage flags necessary even though it supports via vkGetPhysicalDeviceImageFormatPropertiesKHR",
                ));
            }
            if !enough_image_create_flags {
                return Ok(TestStatus::new(
                    TestResult::CompatibilityWarning,
                    "The video format doesn't have enough image create flags necessary even though it supports via vkGetPhysicalDeviceImageFormatPropertiesKHR",
                ));
            }
            found_compatible_modifier = true;
        }

        if video_format.image_tiling == vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT && !found_compatible_modifier {
            return Ok(TestStatus::fail("No compatible modifier found for the video format"));
        }
        Ok(TestStatus::pass("OK"))
    }

    /// `validateVideoFormatsWithProfile`
    fn validate_video_formats_with_profile(&self, video_device: &VideoDevice, chain: &Chain) -> TestOutcome {
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let separate_dpb_and_output_only = !chain
            .decode_caps
            .flags
            .contains(vk::VideoDecodeCapabilityFlagsKHR::DPB_AND_OUTPUT_COINCIDE);
        let coincide_dpb_and_output_only = !chain
            .decode_caps
            .flags
            .contains(vk::VideoDecodeCapabilityFlagsKHR::DPB_AND_OUTPUT_DISTINCT);
        let dpb_and_output_coincide_usage =
            vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR | vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR;

        let mut usage_flags = Vec::new();
        if self.params.is_decode() {
            usage_flags.push(vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR);
            usage_flags.push(vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR);
            if !separate_dpb_and_output_only {
                usage_flags.push(dpb_and_output_coincide_usage);
            }
        } else {
            usage_flags.push(vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR);
            usage_flags.push(vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR);
        }

        let mut image_formats: Vec<vk::Format> = Vec::new();
        let mut dpb_image_formats: Vec<vk::Format> = Vec::new();

        for usage in usage_flags {
            let profile_list = vk::VideoProfileListInfoKHR {
                profile_count: 1,
                profiles: &*chain.profile,
                ..Default::default()
            };
            let format_info = vk::PhysicalDeviceVideoFormatInfoKHR {
                next: ptr::from_ref(&profile_list).cast::<c_void>(),
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
            if result != vk::Result::SUCCESS {
                return Ok(TestStatus::fail(format!(
                    "Failed query call to vkGetPhysicalDeviceVideoFormatPropertiesKHR with {result:?}"
                )));
            }
            // Return fail if the number of supported formats is 0.
            if format_count == 0 {
                return Ok(TestStatus::fail(
                    "The number of supported formats is 0 even though the profile is exposed to be supported.",
                ));
            }

            let mut formats = vec![vk::VideoFormatPropertiesKHR::default(); format_count as usize];
            let result = unsafe {
                (commands.get_physical_device_video_format_properties_khr)(
                    physical_device,
                    &format_info,
                    &mut format_count,
                    formats.as_mut_ptr(),
                )
            };
            if result != vk::Result::SUCCESS {
                return Ok(TestStatus::fail(format!(
                    "Failed query call to vkGetPhysicalDeviceVideoFormatPropertiesKHR with {result:?}"
                )));
            }
            formats.truncate(format_count as usize);

            for format in &formats {
                // Validate if bit depth is compatible with the queried format.
                if is_ycbcr_format(format.format) {
                    let format_bit_depth = get_ycbcr_bit_depth(format.format);
                    let luma_bit_depth = component_bit_depth(self.params.luma_bit_depth)?;
                    let chroma_bit_depth = component_bit_depth(self.params.chroma_bit_depth)?;
                    if luma_bit_depth != format_bit_depth[0] || chroma_bit_depth != format_bit_depth[1] {
                        return Ok(TestStatus::fail(format!(
                            "The format {:?} ({}, {}) should be compatible with bit depth: ({}, {})",
                            format.format, format_bit_depth[0], format_bit_depth[1], luma_bit_depth, chroma_bit_depth
                        )));
                    }
                }

                // Validate if the queried image usages includes requested image usages.
                if !format.image_usage_flags.intersects(usage) {
                    return Ok(TestStatus::fail(
                        "The queried video format doesn't have any image usage requested",
                    ));
                }

                // Validate if the queried image usage is aligned with the queried video capability.
                if self.params.is_decode()
                    && separate_dpb_and_output_only
                    && format.image_usage_flags.contains(dpb_and_output_coincide_usage)
                {
                    return Ok(TestStatus::fail(
                        "Image Usage should be supported separately for DECODE_DPB and DECODE_DST since the video capability doesn't expose VK_VIDEO_DECODE_CAPABILITY_DPB_AND_OUTPUT_COINCIDE_BIT_KHR. ",
                    ));
                }
                if self.params.is_decode()
                    && coincide_dpb_and_output_only
                    && !format.image_usage_flags.contains(dpb_and_output_coincide_usage)
                {
                    return Ok(TestStatus::fail(
                        "Image Usage should not be supported for DECODE_DPB or DECODE_DST separately since the video capability doesn't expose VK_VIDEO_DECODE_CAPABILITY_DPB_AND_OUTPUT_DISTINCT_BIT_KHR. ",
                    ));
                }

                // Validate if the queried video format is aligned with VkFormatProperties2 from getPhysicalDeviceFormat.
                let status = self.validate_with_format_properties(format, usage);
                if status.code() != TestResult::Pass {
                    return Ok(status);
                }

                // Validate if the queried video format is aligned with VkImageFormatProperties2 from getPhysicalDeviceImageFormat.
                let status = self.validate_with_image_format_properties(chain, format, usage)?;
                if status.code() != TestResult::Pass {
                    return Ok(status);
                }

                if format
                    .image_usage_flags
                    .intersects(vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR | vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR)
                {
                    dpb_image_formats.push(format.format);
                }
                if format
                    .image_usage_flags
                    .intersects(vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR | vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR)
                {
                    image_formats.push(format.format);
                }
            }
        }

        // A set of unique pairs of image and dpb format
        let mut format_set: BTreeSet<(i32, i32)> = BTreeSet::new();
        for image_format in &image_formats {
            for dpb_format in &dpb_image_formats {
                format_set.insert((image_format.as_raw(), dpb_format.as_raw()));
            }
        }
        if format_set.is_empty() {
            return Ok(TestStatus::fail("No supported video formats"));
        }

        for (image_format, dpb_format) in format_set {
            let status = self.try_create_video_session(
                video_device,
                chain,
                vk::Format::from_raw(image_format),
                vk::Format::from_raw(dpb_format),
            );
            if status.code() != TestResult::Pass {
                return Ok(status);
            }
        }
        Ok(TestStatus::pass("OK"))
    }
}

impl TestInstance for ProfilesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let video_device = create_video_device(context, &self.params)?;
        let mut chain = Chain::new(&self.params);

        let result = unsafe {
            context.get_instance().get_physical_device_video_capabilities_khr(
                context.get_physical_device(),
                &chain.profile,
                &mut chain.video_caps,
            )
        };
        let valid_codec = validate_profile_codec(&self.params)?;

        match result {
            Ok(()) if !valid_codec => Ok(TestStatus::fail(
                "Video capability query should return an error when an invalid video profile is specified",
            )),
            Ok(()) => self.validate_video_formats_with_profile(&video_device, &chain),
            Err(vk::ErrorCode::VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR) => Err(TestError::NotSupported(
                "video picture layout not supported".to_string(),
            )),
            Err(vk::ErrorCode::VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR) => Err(TestError::NotSupported(
                "video profile format not supported".to_string(),
            )),
            Err(vk::ErrorCode::VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR) => Err(TestError::NotSupported(
                "video profile operation not supported".to_string(),
            )),
            Err(vk::ErrorCode::VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR) => {
                Err(TestError::NotSupported("video profile codec not supported".to_string()))
            }
            Err(code) => Ok(TestStatus::fail(format!(
                "Failed query call to vkGetPhysicalDeviceVideoCapabilitiesKHR with {code:?}"
            ))),
        }
    }
}

struct ProfilesCase {
    name: String,
    params: TestParams,
}

impl TestCase for ProfilesCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_video_queue")?;

        if context.is_device_functionality_supported("VK_KHR_video_maintenance1") {
            context.require_device_functionality("VK_KHR_video_maintenance1")?;
        }

        let (queue_extension, codec_extension) = match self.params.codec_profile {
            CodecProfile::H264Dec { .. } => ("VK_KHR_video_decode_queue", "VK_KHR_video_decode_h264"),
            CodecProfile::H265Dec(_) => ("VK_KHR_video_decode_queue", "VK_KHR_video_decode_h265"),
            CodecProfile::Av1Dec { .. } => ("VK_KHR_video_decode_queue", "VK_KHR_video_decode_av1"),
            CodecProfile::Vp9Dec(_) => ("VK_KHR_video_decode_queue", "VK_KHR_video_decode_vp9"),
            CodecProfile::H264Enc(_) => ("VK_KHR_video_encode_queue", "VK_KHR_video_encode_h264"),
            CodecProfile::H265Enc(_) => ("VK_KHR_video_encode_queue", "VK_KHR_video_encode_h265"),
            CodecProfile::Av1Enc(_) => ("VK_KHR_video_encode_queue", "VK_KHR_video_encode_av1"),
        };
        context.require_device_functionality(queue_extension)?;
        context.require_device_functionality(codec_extension)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ProfilesInstance {
            context,
            params: self.params,
        })
    }
}

fn h264_profile_name(profile: StdVideoH264ProfileIdc) -> &'static str {
    if profile == STD_VIDEO_H264_PROFILE_IDC_BASELINE {
        "baseline"
    } else if profile == STD_VIDEO_H264_PROFILE_IDC_MAIN {
        "main"
    } else if profile == STD_VIDEO_H264_PROFILE_IDC_HIGH {
        "high"
    } else {
        "high_444_predictive"
    }
}

fn h265_profile_name(profile: StdVideoH265ProfileIdc) -> &'static str {
    if profile == STD_VIDEO_H265_PROFILE_IDC_MAIN {
        "main"
    } else if profile == STD_VIDEO_H265_PROFILE_IDC_MAIN_10 {
        "main_10"
    } else if profile == STD_VIDEO_H265_PROFILE_IDC_MAIN_STILL_PICTURE {
        "main_still_pic"
    } else if profile == STD_VIDEO_H265_PROFILE_IDC_FORMAT_RANGE_EXTENSIONS {
        "format_range_ext"
    } else {
        "scc_ext"
    }
}

fn av1_profile_name(profile: StdVideoAV1Profile) -> &'static str {
    if profile == STD_VIDEO_AV1_PROFILE_MAIN {
        "main"
    } else if profile == STD_VIDEO_AV1_PROFILE_HIGH {
        "high"
    } else {
        "professional"
    }
}

fn vp9_profile_name(profile: StdVideoVP9Profile) -> &'static str {
    if profile == STD_VIDEO_VP9_PROFILE_0 {
        "profile0"
    } else if profile == STD_VIDEO_VP9_PROFILE_1 {
        "profile1"
    } else if profile == STD_VIDEO_VP9_PROFILE_2 {
        "profile2"
    } else {
        "profile3"
    }
}

/// `getTestName`
fn test_name(params: &TestParams) -> String {
    use vk::{VideoChromaSubsamplingFlagsKHR as Chroma, VideoComponentBitDepthFlagsKHR as Depth};

    let mut name = match params.codec_profile {
        CodecProfile::H264Dec { profile, layout } => {
            let layout_name = if layout == vk::VideoDecodeH264PictureLayoutFlagsKHR::PROGRESSIVE {
                "_progressive"
            } else if layout == vk::VideoDecodeH264PictureLayoutFlagsKHR::INTERLACED_INTERLEAVED_LINES {
                "_interlaced_interleaved_lines"
            } else {
                "_interlaced_separate_planes"
            };
            format!("{}{layout_name}", h264_profile_name(profile))
        }
        CodecProfile::H264Enc(profile) => h264_profile_name(profile).to_string(),
        CodecProfile::H265Dec(profile) | CodecProfile::H265Enc(profile) => h265_profile_name(profile).to_string(),
        CodecProfile::Av1Dec { profile, film_grain } => format!(
            "{}{}",
            av1_profile_name(profile),
            if film_grain {
                "_with_filmgrain"
            } else {
                "_without_filmgrain"
            }
        ),
        CodecProfile::Av1Enc(profile) => av1_profile_name(profile).to_string(),
        CodecProfile::Vp9Dec(profile) => vp9_profile_name(profile).to_string(),
    };

    name.push_str(if params.chroma_subsampling == Chroma::MONOCHROME {
        "_monochrome"
    } else if params.chroma_subsampling == Chroma::_420 {
        "_420"
    } else if params.chroma_subsampling == Chroma::_422 {
        "_422"
    } else {
        "_444"
    });
    name.push_str(if params.luma_bit_depth == Depth::_8 {
        "_luma_8bit"
    } else if params.luma_bit_depth == Depth::_10 {
        "_luma_10bit"
    } else {
        "_luma_12bit"
    });
    name.push_str(if params.chroma_bit_depth == Depth::_8 {
        "_chroma_8bit"
    } else if params.chroma_bit_depth == Depth::_10 {
        "_chroma_10bit"
    } else {
        "_chroma_12bit"
    });
    name
}

/// `createVideoProfilesValidationTests`: the cases keyed by their dotted path (`profiles.{decode,encode}.<codec>.<name>`)
pub fn create_profiles_cases() -> HashMap<String, Box<dyn TestCase>> {
    use vk::{
        VideoChromaSubsamplingFlagsKHR as Chroma, VideoCodecOperationFlagsKHR as Codec,
        VideoComponentBitDepthFlagsKHR as Depth,
    };

    const CODECS: [(Codec, &str, &str); 7] = [
        (Codec::DECODE_H264, "decode", "h264"),
        (Codec::DECODE_H265, "decode", "h265"),
        (Codec::DECODE_AV1, "decode", "av1"),
        (Codec::DECODE_VP9, "decode", "vp9"),
        (Codec::ENCODE_H264, "encode", "h264"),
        (Codec::ENCODE_H265, "encode", "h265"),
        (Codec::ENCODE_AV1, "encode", "av1"),
    ];
    let subsampling_flags = [Chroma::MONOCHROME, Chroma::_420, Chroma::_422, Chroma::_444];
    let h264_picture_layouts = [
        vk::VideoDecodeH264PictureLayoutFlagsKHR::PROGRESSIVE,
        vk::VideoDecodeH264PictureLayoutFlagsKHR::INTERLACED_INTERLEAVED_LINES,
        vk::VideoDecodeH264PictureLayoutFlagsKHR::INTERLACED_SEPARATE_PLANES,
    ];
    let h264_profile_idc = [
        STD_VIDEO_H264_PROFILE_IDC_BASELINE,
        STD_VIDEO_H264_PROFILE_IDC_MAIN,
        STD_VIDEO_H264_PROFILE_IDC_HIGH,
        STD_VIDEO_H264_PROFILE_IDC_HIGH_444_PREDICTIVE,
    ];
    let h265_profile_idc = [
        STD_VIDEO_H265_PROFILE_IDC_MAIN,
        STD_VIDEO_H265_PROFILE_IDC_MAIN_10,
        STD_VIDEO_H265_PROFILE_IDC_MAIN_STILL_PICTURE,
        STD_VIDEO_H265_PROFILE_IDC_FORMAT_RANGE_EXTENSIONS,
        STD_VIDEO_H265_PROFILE_IDC_SCC_EXTENSIONS,
    ];
    let av1_profiles = [
        STD_VIDEO_AV1_PROFILE_MAIN,
        STD_VIDEO_AV1_PROFILE_HIGH,
        STD_VIDEO_AV1_PROFILE_PROFESSIONAL,
    ];
    let vp9_profiles = [
        STD_VIDEO_VP9_PROFILE_0,
        STD_VIDEO_VP9_PROFILE_1,
        STD_VIDEO_VP9_PROFILE_2,
        STD_VIDEO_VP9_PROFILE_3,
    ];
    let bit_depth_flags = [Depth::_8, Depth::_10, Depth::_12];

    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for (codec, direction, codec_name) in CODECS {
        for subsampling in subsampling_flags {
            for luma_bit_depth in bit_depth_flags {
                for chroma_bit_depth in bit_depth_flags {
                    // Just ignore the chroma bit depth for monochrome
                    if subsampling == Chroma::MONOCHROME && luma_bit_depth != chroma_bit_depth {
                        continue;
                    }

                    let profiles: Vec<CodecProfile> = if codec == Codec::DECODE_H264 {
                        h264_picture_layouts
                            .iter()
                            .flat_map(|&layout| {
                                h264_profile_idc
                                    .iter()
                                    .map(move |&profile| CodecProfile::H264Dec { profile, layout })
                            })
                            .collect()
                    } else if codec == Codec::DECODE_H265 {
                        h265_profile_idc
                            .iter()
                            .map(|&profile| CodecProfile::H265Dec(profile))
                            .collect()
                    } else if codec == Codec::DECODE_AV1 {
                        [false, true]
                            .iter()
                            .flat_map(|&film_grain| {
                                av1_profiles
                                    .iter()
                                    .map(move |&profile| CodecProfile::Av1Dec { profile, film_grain })
                            })
                            .collect()
                    } else if codec == Codec::DECODE_VP9 {
                        vp9_profiles
                            .iter()
                            .map(|&profile| CodecProfile::Vp9Dec(profile))
                            .collect()
                    } else if codec == Codec::ENCODE_H264 {
                        h264_profile_idc
                            .iter()
                            .map(|&profile| CodecProfile::H264Enc(profile))
                            .collect()
                    } else if codec == Codec::ENCODE_H265 {
                        h265_profile_idc
                            .iter()
                            .map(|&profile| CodecProfile::H265Enc(profile))
                            .collect()
                    } else {
                        av1_profiles
                            .iter()
                            .map(|&profile| CodecProfile::Av1Enc(profile))
                            .collect()
                    };

                    for codec_profile in profiles {
                        let params = TestParams {
                            codec_profile,
                            codec_operation: codec,
                            chroma_subsampling: subsampling,
                            luma_bit_depth,
                            chroma_bit_depth,
                        };
                        let name = test_name(&params);
                        cases.insert(
                            format!("profiles.{direction}.{codec_name}.{name}"),
                            Box::new(ProfilesCase { name, params }),
                        );
                    }
                }
            }
        }
    }
    cases
}
