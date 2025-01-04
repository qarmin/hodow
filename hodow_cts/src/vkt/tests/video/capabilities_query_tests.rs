// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/video/vktVideoCapabilitiesTests.cpp (`VideoCapabilitiesQuery*TestInstance`, `VideoCapabilitiesIntraRefresh*TestInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The video capabilities are queried twice, the output structures filled with 0x00 and with 0xFF, and the two answers have
// to agree and be valid. `VALIDATE_FIELD_EQUAL` is `same_fields!` over the fields upstream names, never the whole structure (a field a driver does not know stays at its filler).
// The std header version is checked by name only: the header version the CTS was built with is not known here. The feedback2 cases are not ported (VK_KHR_video_encode_feedback2
// is not in vulkanalia 0.35).

use std::any::Any;
use std::ffi::{CStr, c_void};
use std::mem::MaybeUninit;
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::video::{
    STD_VIDEO_AV1_PROFILE_MAIN, STD_VIDEO_H264_PROFILE_IDC_BASELINE, STD_VIDEO_H265_PROFILE_IDC_MAIN,
    STD_VIDEO_VP9_PROFILE_0,
};

use crate::tcu::{TestOutcome, TestStatus};
use crate::vkt::Context;

type Check = Result<(), String>;

fn ensure(condition: bool, message: &str) -> Check {
    if condition { Ok(()) } else { Err(message.to_string()) }
}

macro_rules! same_fields {
    ($first:expr, $second:expr, $what:literal; $($field:ident),+ $(,)?) => {{
        $(
            if $first.$field != $second.$field {
                return Err(format!("{}: {} differs between two queries", $what, stringify!($field)));
            }
        )+
    }};
}

/// A capabilities structure that is a link in the `pNext` chain of `VkVideoCapabilitiesKHR`.
trait Link: Copy {
    const S_TYPE: vk::StructureType;
    fn link(&mut self, next: *mut c_void);
}

macro_rules! link {
    ($($ty:ty => $s_type:ident),+ $(,)?) => {$(
        impl Link for $ty {
            const S_TYPE: vk::StructureType = vk::StructureType::$s_type;
            fn link(&mut self, next: *mut c_void) {
                self.s_type = Self::S_TYPE;
                self.next = next;
            }
        }
    )+};
}

link! {
    vk::VideoCapabilitiesKHR => VIDEO_CAPABILITIES_KHR,
    vk::VideoDecodeCapabilitiesKHR => VIDEO_DECODE_CAPABILITIES_KHR,
    vk::VideoEncodeCapabilitiesKHR => VIDEO_ENCODE_CAPABILITIES_KHR,
    vk::VideoEncodeIntraRefreshCapabilitiesKHR => VIDEO_ENCODE_INTRA_REFRESH_CAPABILITIES_KHR,
    vk::VideoDecodeH264CapabilitiesKHR => VIDEO_DECODE_H264_CAPABILITIES_KHR,
    vk::VideoDecodeH265CapabilitiesKHR => VIDEO_DECODE_H265_CAPABILITIES_KHR,
    vk::VideoDecodeAV1CapabilitiesKHR => VIDEO_DECODE_AV1_CAPABILITIES_KHR,
    vk::VideoDecodeVP9CapabilitiesKHR => VIDEO_DECODE_VP9_CAPABILITIES_KHR,
    vk::VideoEncodeH264CapabilitiesKHR => VIDEO_ENCODE_H264_CAPABILITIES_KHR,
    vk::VideoEncodeH265CapabilitiesKHR => VIDEO_ENCODE_H265_CAPABILITIES_KHR,
    vk::VideoEncodeAV1CapabilitiesKHR => VIDEO_ENCODE_AV1_CAPABILITIES_KHR,
}

/// `deMemset(&value, filling, sizeof(value))`
fn filled<T>(filling: u8) -> T {
    let mut value = MaybeUninit::<T>::uninit();
    unsafe {
        ptr::write_bytes(value.as_mut_ptr(), filling, 1);
        value.assume_init()
    }
}

/// The video profile of the capabilities tests: 4:2:0, 8 bit, with the codec profile (and for decoding the default usage hints) chained.
struct Profile {
    profile: Box<vk::VideoProfileInfoKHR>,
    _chain: Vec<Box<dyn Any>>,
}

fn boxed<T: Any>(value: T) -> (Box<dyn Any>, *const c_void) {
    let boxed = Box::new(value);
    let pointer = ptr::from_ref(&*boxed).cast::<c_void>();
    (boxed, pointer)
}

fn make_profile(codec: vk::VideoCodecOperationFlagsKHR) -> Profile {
    use vk::VideoCodecOperationFlagsKHR as Codec;

    let (codec_profile, codec_profile_ptr) = if codec == Codec::DECODE_H264 {
        boxed(vk::VideoDecodeH264ProfileInfoKHR {
            std_profile_idc: STD_VIDEO_H264_PROFILE_IDC_BASELINE,
            picture_layout: vk::VideoDecodeH264PictureLayoutFlagsKHR::PROGRESSIVE,
            ..Default::default()
        })
    } else if codec == Codec::DECODE_H265 {
        boxed(vk::VideoDecodeH265ProfileInfoKHR {
            std_profile_idc: STD_VIDEO_H265_PROFILE_IDC_MAIN,
            ..Default::default()
        })
    } else if codec == Codec::DECODE_AV1 {
        boxed(vk::VideoDecodeAV1ProfileInfoKHR {
            std_profile: STD_VIDEO_AV1_PROFILE_MAIN,
            film_grain_support: vk::FALSE,
            ..Default::default()
        })
    } else if codec == Codec::DECODE_VP9 {
        boxed(vk::VideoDecodeVP9ProfileInfoKHR {
            std_profile: STD_VIDEO_VP9_PROFILE_0,
            ..Default::default()
        })
    } else if codec == Codec::ENCODE_H264 {
        boxed(vk::VideoEncodeH264ProfileInfoKHR {
            std_profile_idc: STD_VIDEO_H264_PROFILE_IDC_BASELINE,
            ..Default::default()
        })
    } else if codec == Codec::ENCODE_H265 {
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

    let mut chain = vec![codec_profile];
    let profile_next = if codec.contains(Codec::DECODE_H264)
        || codec.contains(Codec::DECODE_H265)
        || codec.contains(Codec::DECODE_AV1)
        || codec.contains(Codec::DECODE_VP9)
    {
        let (usage, usage_ptr) = boxed(vk::VideoDecodeUsageInfoKHR {
            next: codec_profile_ptr,
            video_usage_hints: vk::VideoDecodeUsageFlagsKHR::DEFAULT,
            ..Default::default()
        });
        chain.push(usage);
        usage_ptr
    } else {
        codec_profile_ptr
    };

    Profile {
        profile: Box::new(vk::VideoProfileInfoKHR {
            next: profile_next,
            video_codec_operation: codec,
            chroma_subsampling: vk::VideoChromaSubsamplingFlagsKHR::_420,
            luma_bit_depth: vk::VideoComponentBitDepthFlagsKHR::_8,
            chroma_bit_depth: vk::VideoComponentBitDepthFlagsKHR::_8,
            ..Default::default()
        }),
        _chain: chain,
    }
}

fn is_decode(codec: vk::VideoCodecOperationFlagsKHR) -> bool {
    use vk::VideoCodecOperationFlagsKHR as Codec;
    codec == Codec::DECODE_H264
        || codec == Codec::DECODE_H265
        || codec == Codec::DECODE_AV1
        || codec == Codec::DECODE_VP9
}

/// `getVideoExtensionProperties(codec)`, the name of the std header extension
fn std_header_name(codec: vk::VideoCodecOperationFlagsKHR) -> &'static str {
    use vk::VideoCodecOperationFlagsKHR as Codec;

    if codec == Codec::DECODE_H264 {
        "VK_STD_vulkan_video_codec_h264_decode"
    } else if codec == Codec::DECODE_H265 {
        "VK_STD_vulkan_video_codec_h265_decode"
    } else if codec == Codec::DECODE_AV1 {
        "VK_STD_vulkan_video_codec_av1_decode"
    } else if codec == Codec::DECODE_VP9 {
        "VK_STD_vulkan_video_codec_vp9_decode"
    } else if codec == Codec::ENCODE_H264 {
        "VK_STD_vulkan_video_codec_h264_encode"
    } else if codec == Codec::ENCODE_H265 {
        "VK_STD_vulkan_video_codec_h265_encode"
    } else {
        "VK_STD_vulkan_video_codec_av1_encode"
    }
}

/// `validateExtensionProperties`, the name part: both names have to be NUL terminated within the array and equal up to it.
fn validate_extension_name(properties: &vk::ExtensionProperties, expected: &str) -> Check {
    let bytes: Vec<u8> = properties.extension_name.iter().map(|&c| c as u8).collect();
    let name = CStr::from_bytes_until_nul(&bytes)
        .map_err(|_| "Non-zero terminated string extensionProperties.extensionName".to_string())?;
    ensure(
        name.to_bytes() == expected.as_bytes(),
        "Unequal extensionProperties.extensionName",
    )
}

/// `validateVideoCapabilities`
fn validate_video_capabilities(first: &vk::VideoCapabilitiesKHR, second: &vk::VideoCapabilitiesKHR) -> Check {
    same_fields!(first, second, "videoCapabilitiesKHR"; s_type, flags, min_bitstream_buffer_offset_alignment,
        min_bitstream_buffer_size_alignment, picture_access_granularity, min_coded_extent, max_coded_extent,
        max_dpb_slots, max_active_reference_pictures);
    let first_name: Vec<u8> = first
        .std_header_version
        .extension_name
        .iter()
        .map(|&c| c as u8)
        .collect();
    let second_name: Vec<u8> = second
        .std_header_version
        .extension_name
        .iter()
        .map(|&c| c as u8)
        .collect();
    ensure(
        first.std_header_version.spec_version == second.std_header_version.spec_version
            && CStr::from_bytes_until_nul(&first_name).ok() == CStr::from_bytes_until_nul(&second_name).ok(),
        "Unequal stdHeaderVersion",
    )?;

    let known = vk::VideoCapabilityFlagsKHR::PROTECTED_CONTENT | vk::VideoCapabilityFlagsKHR::SEPARATE_REFERENCE_IMAGES;
    ensure(
        (first.flags.bits() & !known.bits()) == 0,
        "Undeclared videoCapabilitiesKHR.flags returned",
    )?;
    ensure(
        first.min_bitstream_buffer_offset_alignment.is_power_of_two(),
        "Expected to be Power-Of-Two: videoCapabilitiesKHR.minBitstreamBufferOffsetAlignment",
    )?;
    ensure(
        first.min_bitstream_buffer_size_alignment.is_power_of_two(),
        "Expected to be Power-Of-Two: videoCapabilitiesKHR.minBitstreamBufferSizeAlignment",
    )?;
    ensure(
        first.picture_access_granularity.width != 0,
        "Expected to be non-zero: videoCapabilitiesKHR.pictureAccessGranularity.width",
    )?;
    ensure(
        first.picture_access_granularity.height != 0,
        "Expected to be non-zero: videoCapabilitiesKHR.pictureAccessGranularity.height",
    )?;
    ensure(
        first.min_coded_extent.width != 0 && first.min_coded_extent.height != 0,
        "Invalid videoCapabilitiesKHR.minCodedExtent",
    )?;
    ensure(
        first.max_coded_extent.width >= first.min_coded_extent.width,
        "Invalid videoCapabilitiesKHR.maxCodedExtent.width",
    )?;
    ensure(
        first.max_coded_extent.height >= first.min_coded_extent.height,
        "Invalid videoCapabilitiesKHR.maxCodedExtent.height",
    )?;
    ensure(first.max_dpb_slots != 0, "Invalid videoCapabilitiesKHR.maxDpbSlots")?;
    ensure(
        first.max_active_reference_pictures != 0,
        "Invalid videoCapabilitiesKHR.maxActiveReferencePictures",
    )
}

/// `validateVideoDecodeCapabilities`
fn validate_video_decode_capabilities(
    first: &vk::VideoDecodeCapabilitiesKHR,
    second: &vk::VideoDecodeCapabilitiesKHR,
) -> Check {
    same_fields!(first, second, "videoDecodeCapabilitiesKHR"; s_type, flags);
    let known = vk::VideoDecodeCapabilityFlagsKHR::DPB_AND_OUTPUT_COINCIDE
        | vk::VideoDecodeCapabilityFlagsKHR::DPB_AND_OUTPUT_DISTINCT;
    ensure(
        (first.flags.bits() & !known.bits()) == 0,
        "Undefined videoDecodeCapabilitiesKHR.flags",
    )
}

/// `validateVideoEncodeCapabilities`
fn validate_video_encode_capabilities(
    context: &Context<'_>,
    first: &vk::VideoEncodeCapabilitiesKHR,
    second: &vk::VideoEncodeCapabilitiesKHR,
) -> Check {
    same_fields!(first, second, "videoEncodeCapabilitiesKHR"; s_type, flags, rate_control_modes, max_rate_control_layers,
        max_quality_levels, encode_input_picture_granularity, supported_encode_feedback_flags);

    let known = vk::VideoEncodeCapabilityFlagsKHR::PRECEDING_EXTERNALLY_ENCODED_BYTES
        | vk::VideoEncodeCapabilityFlagsKHR::INSUFFICIENT_BITSTREAM_BUFFER_RANGE_DETECTION
        | vk::VideoEncodeCapabilityFlagsKHR::QUANTIZATION_DELTA_MAP
        | vk::VideoEncodeCapabilityFlagsKHR::EMPHASIS_MAP;
    ensure(
        (first.flags.bits() & !known.bits()) == 0,
        "Undeclared VkVideoEncodeCapabilitiesKHR.flags returned",
    )?;

    // VK_KHR_video_encode_feedback2 adds feedback flags above bit 2, which vulkanalia 0.35 has no names for: any further bit is accepted when it is exposed.
    let video_maintenance2 = context.is_device_functionality_supported("VK_KHR_video_maintenance2");
    let video_encode_feedback2 = context.is_device_functionality_supported("VK_KHR_video_encode_feedback2");
    let base_feedback = vk::VideoEncodeFeedbackFlagsKHR::BITSTREAM_BUFFER_OFFSET
        | vk::VideoEncodeFeedbackFlagsKHR::BITSTREAM_BYTES_WRITTEN
        | vk::VideoEncodeFeedbackFlagsKHR::BITSTREAM_HAS_OVERRIDES;
    let all_feedback_bits = if video_encode_feedback2 {
        u32::MAX
    } else {
        base_feedback.bits()
    };
    ensure(
        (first.supported_encode_feedback_flags.bits() & !all_feedback_bits) == 0,
        "Unknown VkVideoEncodeCapabilitiesKHR.supportedEncodeFeedbackFlags returned",
    )?;
    ensure(
        first
            .supported_encode_feedback_flags
            .contains(vk::VideoEncodeFeedbackFlagsKHR::BITSTREAM_BUFFER_OFFSET),
        "VK_VIDEO_ENCODE_FEEDBACK_BITSTREAM_BUFFER_OFFSET_BIT_KHR must be supported",
    )?;
    ensure(
        first
            .supported_encode_feedback_flags
            .contains(vk::VideoEncodeFeedbackFlagsKHR::BITSTREAM_BYTES_WRITTEN),
        "VK_VIDEO_ENCODE_FEEDBACK_BITSTREAM_BYTES_WRITTEN_BIT_KHR must be supported",
    )?;
    ensure(
        first.max_rate_control_layers != 0,
        "videoEncodeCapabilitiesKHR.maxRateControlLayers is zero. Implementations must report at least 1.",
    )?;
    ensure(
        first.max_quality_levels != 0,
        "videoEncodeCapabilitiesKHR.maxQualityLevels is zero. Implementations must report at least 1.",
    )?;
    if video_maintenance2 {
        ensure(
            first
                .rate_control_modes
                .contains(vk::VideoEncodeRateControlModeFlagsKHR::DISABLED),
            "videoEncodeCapabilitiesKHR.rateControlModes doesn't contain VK_VIDEO_ENCODE_RATE_CONTROL_MODE_DISABLED_BIT_KHR but VK_KHR_video_maintenance2 is supported",
        )?;
    }
    Ok(())
}

/// `vkGetPhysicalDeviceVideoCapabilitiesKHR`
fn query_capabilities(context: &Context<'_>, profile: &Profile, capabilities: &mut vk::VideoCapabilitiesKHR) -> Check {
    let result = unsafe {
        (context
            .get_instance()
            .commands()
            .get_physical_device_video_capabilities_khr)(
            context.get_physical_device(), &*profile.profile, capabilities
        )
    };
    ensure(
        result == vk::Result::SUCCESS,
        &format!("Failed query call to vkGetPhysicalDeviceVideoCapabilitiesKHR with {result:?}"),
    )
}

fn outcome(result: Check) -> TestOutcome {
    Ok(match result {
        Ok(()) => TestStatus::pass("Pass"),
        Err(message) => TestStatus::fail(message),
    })
}

/// `VideoCapabilitiesQuery{H264,H265,AV1,VP9}DecodeTestInstance::iterate`
fn decode_query<C: Link>(
    context: &Context<'_>,
    codec: vk::VideoCodecOperationFlagsKHR,
    validate_codec: impl Fn(&C, &C) -> Check,
) -> Check {
    let profile = make_profile(codec);
    let mut base: [vk::VideoCapabilitiesKHR; 2] = [filled(0x00), filled(0xFF)];
    let mut decode: [vk::VideoDecodeCapabilitiesKHR; 2] = [filled(0x00), filled(0xFF)];
    let mut codec_caps: [C; 2] = [filled(0x00), filled(0xFF)];

    for ndx in 0..2 {
        codec_caps[ndx].link(ptr::null_mut());
        decode[ndx].link(ptr::from_mut(&mut codec_caps[ndx]).cast());
        base[ndx].link(ptr::from_mut(&mut decode[ndx]).cast());
        query_capabilities(context, &profile, &mut base[ndx])
            .map_err(|message| format!("{message} at iteration {ndx}"))?;
    }

    validate_video_capabilities(&base[0], &base[1])?;
    validate_extension_name(&base[0].std_header_version, std_header_name(codec))?;
    validate_video_decode_capabilities(&decode[0], &decode[1])?;
    validate_codec(&codec_caps[0], &codec_caps[1])
}

/// `VideoCapabilitiesQuery{H264,H265,AV1}EncodeTestInstance::iterate`, the intra refresh capabilities chained after the codec ones
fn encode_query<C: Link>(
    context: &Context<'_>,
    codec: vk::VideoCodecOperationFlagsKHR,
    validate_codec: impl Fn(&C, &C, &vk::VideoEncodeIntraRefreshCapabilitiesKHR) -> Check,
) -> Check {
    let profile = make_profile(codec);
    let mut base: [vk::VideoCapabilitiesKHR; 2] = [filled(0x00), filled(0xFF)];
    let mut encode: [vk::VideoEncodeCapabilitiesKHR; 2] = [filled(0x00), filled(0xFF)];
    let mut codec_caps: [C; 2] = [filled(0x00), filled(0xFF)];
    let mut intra_refresh: [vk::VideoEncodeIntraRefreshCapabilitiesKHR; 2] = [filled(0x00), filled(0xFF)];

    for ndx in 0..2 {
        intra_refresh[ndx].link(ptr::null_mut());
        codec_caps[ndx].link(ptr::from_mut(&mut intra_refresh[ndx]).cast());
        encode[ndx].link(ptr::from_mut(&mut codec_caps[ndx]).cast());
        base[ndx].link(ptr::from_mut(&mut encode[ndx]).cast());
        query_capabilities(context, &profile, &mut base[ndx])
            .map_err(|message| format!("{message} at iteration {ndx}"))?;
    }

    validate_video_capabilities(&base[0], &base[1])?;
    validate_video_encode_capabilities(context, &encode[0], &encode[1])?;
    validate_extension_name(&base[0].std_header_version, std_header_name(codec))?;
    validate_codec(&codec_caps[0], &codec_caps[1], &intra_refresh[0])
}

/// `VideoCapabilitiesIntraRefresh*EncodeTestInstance::iterate`: one query with the codec and intra refresh capabilities chained, then the intra refresh rules
fn intra_refresh_query<C: Link>(
    context: &Context<'_>,
    codec: vk::VideoCodecOperationFlagsKHR,
    has_reference: impl Fn(&C) -> bool,
    reference_message: &str,
    max_partitions: impl Fn(&C) -> u32,
) -> Check {
    let profile = make_profile(codec);
    let mut base: vk::VideoCapabilitiesKHR = filled(0x00);
    let mut encode: vk::VideoEncodeCapabilitiesKHR = filled(0x00);
    let mut codec_caps: C = filled(0x00);
    let mut intra_refresh: vk::VideoEncodeIntraRefreshCapabilitiesKHR = filled(0x00);

    intra_refresh.link(ptr::null_mut());
    codec_caps.link(ptr::from_mut(&mut intra_refresh).cast());
    encode.link(ptr::from_mut(&mut codec_caps).cast());
    base.link(ptr::from_mut(&mut encode).cast());
    query_capabilities(context, &profile, &mut base)?;

    // 1. Implementations must support using at least one reference frame.
    ensure(has_reference(&codec_caps), reference_message)?;
    validate_intra_refresh_capabilities(&intra_refresh, max_partitions(&codec_caps))
}

/// `validateIntraRefreshCapabilities`
fn validate_intra_refresh_capabilities(
    capabilities: &vk::VideoEncodeIntraRefreshCapabilitiesKHR,
    max_picture_partitions: u32,
) -> Check {
    use vk::VideoEncodeIntraRefreshModeFlagsKHR as Mode;

    let modes = capabilities.intra_refresh_modes;
    // 2. At least one bit set and no bits outside the defined modes.
    ensure(!modes.is_empty(), "At least one intra-refresh mode must be supported")?;
    let all_modes = Mode::PER_PICTURE_PARTITION | Mode::BLOCK_BASED | Mode::BLOCK_ROW_BASED | Mode::BLOCK_COLUMN_BASED;
    ensure(
        (modes.bits() & !all_modes.bits()) == 0,
        "Intra-refresh modes capability has invalid bits set",
    )?;
    // 3. Row or column based modes need the any-block based mode.
    if modes.intersects(Mode::BLOCK_ROW_BASED) || modes.intersects(Mode::BLOCK_COLUMN_BASED) {
        ensure(
            modes.contains(Mode::BLOCK_BASED),
            "If either row or column based intra-refresh mode is supported, then any-block based mode should also be supported",
        )?;
    }
    // 4. Per picture partition as the only mode: the cycle duration is bounded by the picture partitions.
    if modes == Mode::PER_PICTURE_PARTITION {
        ensure(
            capabilities.max_intra_refresh_cycle_duration <= max_picture_partitions,
            "Intra-refresh per-picture partition mode requires capability `maxIntraRefreshCycleDuration` be less than or equal to codec's max picture partitions",
        )?;
    }
    // 5. and 6.
    ensure(
        capabilities.max_intra_refresh_cycle_duration >= 2,
        "Intra-refresh `maxIntraRefreshCycleDuration` capability must be greater than or equal to 2",
    )?;
    ensure(
        capabilities.max_intra_refresh_active_reference_pictures >= 1,
        "Intra-refresh `maxIntraRefreshActiveReferencePictures` capability must be greater than or equal to 1",
    )
}

fn validate_h264_decode(
    first: &vk::VideoDecodeH264CapabilitiesKHR,
    second: &vk::VideoDecodeH264CapabilitiesKHR,
) -> Check {
    same_fields!(first, second, "VkVideoDecodeH264CapabilitiesKHR"; s_type, max_level_idc, field_offset_granularity);
    Ok(())
}

fn validate_h265_decode(
    first: &vk::VideoDecodeH265CapabilitiesKHR,
    second: &vk::VideoDecodeH265CapabilitiesKHR,
) -> Check {
    same_fields!(first, second, "VkVideoDecodeH265CapabilitiesKHR"; s_type, max_level_idc);
    Ok(())
}

fn validate_av1_decode(first: &vk::VideoDecodeAV1CapabilitiesKHR, second: &vk::VideoDecodeAV1CapabilitiesKHR) -> Check {
    same_fields!(first, second, "VkVideoDecodeAV1CapabilitiesKHR"; s_type, max_level);
    Ok(())
}

fn validate_vp9_decode(first: &vk::VideoDecodeVP9CapabilitiesKHR, second: &vk::VideoDecodeVP9CapabilitiesKHR) -> Check {
    same_fields!(first, second, "VkVideoDecodeVP9CapabilitiesKHR"; s_type, max_level);
    Ok(())
}

fn validate_h264_encode(
    first: &vk::VideoEncodeH264CapabilitiesKHR,
    second: &vk::VideoEncodeH264CapabilitiesKHR,
    intra_refresh: &vk::VideoEncodeIntraRefreshCapabilitiesKHR,
) -> Check {
    use vk::VideoEncodeH264CapabilityFlagsKHR as Flags;

    let known = Flags::HRD_COMPLIANCE
        | Flags::PREDICTION_WEIGHT_TABLE_GENERATED
        | Flags::ROW_UNALIGNED_SLICE
        | Flags::DIFFERENT_SLICE_TYPE
        | Flags::B_FRAME_IN_L0_LIST
        | Flags::B_FRAME_IN_L1_LIST
        | Flags::PER_PICTURE_TYPE_MIN_MAX_QP
        | Flags::PER_SLICE_CONSTANT_QP
        | Flags::GENERATE_PREFIX_NALU
        | Flags::MB_QP_DIFF_WRAPAROUND
        | Flags::B_PICTURE_INTRA_REFRESH;
    same_fields!(first, second, "VkVideoEncodeH264CapabilitiesKHR"; s_type, flags, max_level_idc, max_slice_count,
        max_p_picture_l0_reference_count, max_b_picture_l0_reference_count, max_l1_reference_count,
        max_temporal_layer_count, expect_dyadic_temporal_layer_pattern, min_qp, max_qp, prefers_gop_remaining_frames,
        requires_gop_remaining_frames);

    ensure(!first.flags.is_empty(), "videoCapabilitiesKHR.flags must not be 0")?;
    ensure(
        (first.flags.bits() & !known.bits()) == 0,
        "Undefined videoCapabilitiesKHR.flags",
    )?;
    // With B_PICTURE_INTRA_REFRESH at least one intra-refresh mode must be supported.
    ensure(
        !(first.flags.contains(Flags::B_PICTURE_INTRA_REFRESH) && intra_refresh.intra_refresh_modes.is_empty()),
        "H.264 capabilities have B_PICTURE_INTRA_REFRESH bit set but no intra refresh mode is supported",
    )
}

fn validate_h265_encode(
    first: &vk::VideoEncodeH265CapabilitiesKHR,
    second: &vk::VideoEncodeH265CapabilitiesKHR,
    intra_refresh: &vk::VideoEncodeIntraRefreshCapabilitiesKHR,
) -> Check {
    use vk::{
        VideoEncodeH265CapabilityFlagsKHR as Flags, VideoEncodeH265CtbSizeFlagsKHR as Ctb,
        VideoEncodeH265TransformBlockSizeFlagsKHR as Transform,
    };

    let known = Flags::HRD_COMPLIANCE
        | Flags::PREDICTION_WEIGHT_TABLE_GENERATED
        | Flags::ROW_UNALIGNED_SLICE_SEGMENT
        | Flags::DIFFERENT_SLICE_SEGMENT_TYPE
        | Flags::B_FRAME_IN_L0_LIST
        | Flags::B_FRAME_IN_L1_LIST
        | Flags::PER_PICTURE_TYPE_MIN_MAX_QP
        | Flags::PER_SLICE_SEGMENT_CONSTANT_QP
        | Flags::MULTIPLE_TILES_PER_SLICE_SEGMENT
        | Flags::MULTIPLE_SLICE_SEGMENTS_PER_TILE
        | Flags::CU_QP_DIFF_WRAPAROUND
        | Flags::B_PICTURE_INTRA_REFRESH;
    let ctb_sizes = Ctb::_16 | Ctb::_32 | Ctb::_64;
    let transform_block_sizes = Transform::_4 | Transform::_8 | Transform::_16 | Transform::_32;
    same_fields!(first, second, "VkVideoEncodeH265CapabilitiesKHR"; s_type, flags, max_level_idc, max_slice_segment_count,
        max_tiles, max_p_picture_l0_reference_count, max_b_picture_l0_reference_count, max_l1_reference_count,
        max_sub_layer_count, expect_dyadic_temporal_sub_layer_pattern, min_qp, max_qp, prefers_gop_remaining_frames,
        requires_gop_remaining_frames);

    ensure(!first.flags.is_empty(), "videoCapabilitiesKHR.flags must not be 0")?;
    ensure(
        (first.flags.bits() & !known.bits()) == 0,
        "Undefined videoCapabilitiesKHR.flags",
    )?;
    ensure(!first.ctb_sizes.is_empty(), "Invalid videoCapabilitiesKHR.ctbSizes")?;
    ensure(
        (first.ctb_sizes.bits() & !ctb_sizes.bits()) == 0,
        "Undefined videoCapabilitiesKHR.ctbSizeFlags",
    )?;
    ensure(
        !first.transform_block_sizes.is_empty(),
        "Invalid videoCapabilitiesKHR.transformBlockSizes",
    )?;
    ensure(
        (first.transform_block_sizes.bits() & !transform_block_sizes.bits()) == 0,
        "Undefined videoCapabilitiesKHR.transformBlockSizes",
    )?;
    ensure(
        !(first.flags.contains(Flags::B_PICTURE_INTRA_REFRESH) && intra_refresh.intra_refresh_modes.is_empty()),
        "H.265 capabilities have B_PICTURE_INTRA_REFRESH bit set but no intra refresh mode is supported",
    )
}

fn validate_av1_encode(
    first: &vk::VideoEncodeAV1CapabilitiesKHR,
    second: &vk::VideoEncodeAV1CapabilitiesKHR,
    intra_refresh: &vk::VideoEncodeIntraRefreshCapabilitiesKHR,
) -> Check {
    use vk::{VideoEncodeAV1CapabilityFlagsKHR as Flags, VideoEncodeAV1SuperblockSizeFlagsKHR as Superblock};

    let known = Flags::VIDEO_ENCODE_AV1_CAPABILITY_PER_RATE_CONTROL_GROUP_MIN_MAX_Q_INDEX
        | Flags::VIDEO_ENCODE_AV1_CAPABILITY_GENERATE_OBU_EXTENSION_HEADER
        | Flags::VIDEO_ENCODE_AV1_CAPABILITY_PRIMARY_REFERENCE_CDF_ONLY
        | Flags::VIDEO_ENCODE_AV1_CAPABILITY_FRAME_SIZE_OVERRIDE
        | Flags::VIDEO_ENCODE_AV1_CAPABILITY_MOTION_VECTOR_SCALING;
    let superblock_sizes =
        Superblock::VIDEO_ENCODE_AV1_SUPERBLOCK_SIZE_64 | Superblock::VIDEO_ENCODE_AV1_SUPERBLOCK_SIZE_128;
    same_fields!(first, second, "VkVideoEncodeAV1CapabilitiesKHR"; max_single_reference_count, single_reference_name_mask,
        max_unidirectional_compound_reference_count, max_unidirectional_compound_group1_reference_count,
        unidirectional_compound_reference_name_mask, max_bidirectional_compound_reference_count,
        max_bidirectional_compound_group1_reference_count, max_bidirectional_compound_group2_reference_count,
        bidirectional_compound_reference_name_mask, max_temporal_layer_count, max_spatial_layer_count,
        max_operating_points, min_q_index, max_q_index, prefers_gop_remaining_frames, requires_gop_remaining_frames);

    ensure(
        !first.superblock_sizes.is_empty(),
        "Invalid videoCapabilitiesKHR.superblockSizes",
    )?;
    ensure(
        (first.flags.bits() & !known.bits()) == 0,
        "Undefined videoCapabilitiesKHR.flags",
    )?;
    ensure(
        (first.superblock_sizes.bits() & !superblock_sizes.bits()) == 0,
        "Undefined videoCapabilitiesKHR.superblockSizes",
    )?;
    ensure(
        !(first
            .flags
            .contains(Flags::VIDEO_ENCODE_AV1_CAPABILITY_COMPOUND_PREDICTION_INTRA_REFRESH)
            && intra_refresh.intra_refresh_modes.is_empty()),
        "AV1 capabilities have COMPOUND_PREDICTION_INTRA_REFRESH bit set but no intra refresh mode is supported",
    )
}

/// `<codec>_{decode,encode}_capabilities_query`
pub(super) fn capabilities_query(context: &Context<'_>, codec: vk::VideoCodecOperationFlagsKHR) -> TestOutcome {
    use vk::VideoCodecOperationFlagsKHR as Codec;

    debug_assert!(is_decode(codec) || codec.intersects(Codec::ENCODE_H264 | Codec::ENCODE_H265 | Codec::ENCODE_AV1));
    outcome(if codec == Codec::DECODE_H264 {
        decode_query(context, codec, validate_h264_decode)
    } else if codec == Codec::DECODE_H265 {
        decode_query(context, codec, validate_h265_decode)
    } else if codec == Codec::DECODE_AV1 {
        decode_query(context, codec, validate_av1_decode)
    } else if codec == Codec::DECODE_VP9 {
        decode_query(context, codec, validate_vp9_decode)
    } else if codec == Codec::ENCODE_H264 {
        encode_query(context, codec, validate_h264_encode)
    } else if codec == Codec::ENCODE_H265 {
        encode_query(context, codec, validate_h265_encode)
    } else {
        encode_query(context, codec, validate_av1_encode)
    })
}

/// `<codec>_encode_intra_refresh_capabilities_query`
pub(super) fn intra_refresh_capabilities_query(
    context: &Context<'_>,
    codec: vk::VideoCodecOperationFlagsKHR,
) -> TestOutcome {
    use vk::VideoCodecOperationFlagsKHR as Codec;

    outcome(if codec == Codec::ENCODE_H264 {
        intra_refresh_query(
            context,
            codec,
            |caps: &vk::VideoEncodeH264CapabilitiesKHR| {
                caps.max_p_picture_l0_reference_count != 0 || caps.max_b_picture_l0_reference_count != 0
            },
            "No P or B frames supported",
            |caps| caps.max_slice_count,
        )
    } else if codec == Codec::ENCODE_H265 {
        intra_refresh_query(
            context,
            codec,
            |caps: &vk::VideoEncodeH265CapabilitiesKHR| {
                caps.max_p_picture_l0_reference_count != 0 || caps.max_b_picture_l0_reference_count != 0
            },
            "No P or B frames supported",
            |caps| caps.max_slice_segment_count,
        )
    } else {
        intra_refresh_query(
            context,
            codec,
            |caps: &vk::VideoEncodeAV1CapabilitiesKHR| {
                caps.max_single_reference_count != 0
                    || caps.max_unidirectional_compound_reference_count != 0
                    || caps.max_bidirectional_compound_reference_count != 0
            },
            "Not enough reference slots",
            |caps| caps.max_tiles.width * caps.max_tiles.height,
        )
    })
}
