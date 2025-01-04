// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/video/vktVideoCapabilitiesTests.cpp (`createVideoCapabilitiesTests`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `video.capabilities.{none,extended_flags}.*`: every case has upstream's `checkSupport`, so a device without the
// extensions ends in NotSupported as under deqp-vk. The bodies of `queue_support_query`, of the `*_capabilities_query` and intra refresh cases (`capabilities_query_tests.rs`, the same with
// or without extended flags) and of the `*_video_format_support_query` cases without extended flags are ported (`VideoQueueQueryTestInstance`,
// `VideoFormatPropertiesQueryTestInstance`, the profile being the 4:2:0 8-bit `Chain` of `formats_tests.rs`). The remaining ones - the feedback2 cases
// (VK_KHR_video_encode_feedback2 is not in vulkanalia 0.35) and the format queries with extended flags (VkImageUsageFlags2CreateInfoKHR is not either) - run
// `check_support` and then report NotPorted. The cases are returned keyed by their dotted path so `video::create_tests` can swap them in for the gated names.

use std::collections::HashMap;
use std::ffi::c_void;
use std::ptr;

use vulkanalia::prelude::v1_0::*;

use super::capabilities_query_tests::{capabilities_query, intra_refresh_capabilities_query};
use super::formats_tests::{Chain, TestParams};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    QueueSupport,
    /// `<codec>_{decode_dst,decode_dpb,encode_src,encode_dpb}_video_format_support_query`
    FormatSupport(vk::ImageUsageFlags),
    CapabilitiesQuery,
    IntraRefreshCapabilitiesQuery,
    Feedback2CapabilitiesQuery,
}

#[derive(Clone, Copy)]
struct CaseDef {
    kind: Kind,
    codec: vk::VideoCodecOperationFlagsKHR,
    extended_flags: bool,
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

struct CapabilitiesCase {
    name: String,
    case_def: CaseDef,
}

impl TestCase for CapabilitiesCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `VideoCapabilitiesQueryTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let case_def = self.case_def;
        context.require_device_functionality("VK_KHR_video_queue")?;

        if context.is_device_functionality_supported("VK_KHR_video_maintenance2") {
            context.require_device_functionality("VK_KHR_video_maintenance2")?;
        }

        if case_def.kind != Kind::QueueSupport {
            context.require_device_functionality(codec_extension(case_def.codec))?;
        }
        match case_def.kind {
            Kind::IntraRefreshCapabilitiesQuery => {
                context.require_device_functionality("VK_KHR_video_encode_intra_refresh")?
            }
            Kind::Feedback2CapabilitiesQuery => {
                context.require_device_functionality("VK_KHR_video_encode_feedback2")?
            }
            _ => {}
        }

        if case_def.extended_flags {
            context.require_device_functionality("VK_KHR_extended_flags")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn is_stub(&self) -> bool {
        !matches!(
            (self.case_def.kind, self.case_def.extended_flags),
            (Kind::QueueSupport, _)
                | (Kind::FormatSupport(_), false)
                | (Kind::CapabilitiesQuery, _)
                | (Kind::IntraRefreshCapabilitiesQuery, _)
        )
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CapabilitiesInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct CapabilitiesInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDef,
}

impl CapabilitiesInstance<'_> {
    /// `VideoQueueQueryTestInstance::iterate`
    fn queue_support_query(&self) -> TestOutcome {
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let commands = instance.commands();

        let mut family_count = 0u32;
        unsafe {
            (commands.get_physical_device_queue_family_properties2)(physical_device, &mut family_count, ptr::null_mut())
        };
        if family_count == 0 {
            return Err(TestError::Fail(
                "Device reports an empty set of queue family properties".to_string(),
            ));
        }

        let mut video_properties = vec![vk::QueueFamilyVideoPropertiesKHR::default(); family_count as usize];
        let mut family_properties = vec![vk::QueueFamilyProperties2::default(); family_count as usize];
        for index in 0..family_count as usize {
            family_properties[index].next = ptr::from_mut(&mut video_properties[index]).cast::<c_void>();
        }
        let requested_count = family_count;
        unsafe {
            (commands.get_physical_device_queue_family_properties2)(
                physical_device,
                &mut family_count,
                family_properties.as_mut_ptr(),
            )
        };
        if family_count != requested_count {
            return Err(TestError::Fail(
                "Device returns less queue families than initially reported".to_string(),
            ));
        }

        let encode_operations = vk::VideoCodecOperationFlagsKHR::ENCODE_H264
            | vk::VideoCodecOperationFlagsKHR::ENCODE_H265
            | vk::VideoCodecOperationFlagsKHR::ENCODE_AV1;
        let decode_operations = vk::VideoCodecOperationFlagsKHR::DECODE_H264
            | vk::VideoCodecOperationFlagsKHR::DECODE_H265
            | vk::VideoCodecOperationFlagsKHR::DECODE_AV1
            | vk::VideoCodecOperationFlagsKHR::DECODE_VP9;

        let mut encode_pass = false;
        let mut decode_pass = false;
        for index in 0..family_count as usize {
            let queue_count = family_properties[index].queue_family_properties.queue_count;
            let queue_flags = family_properties[index].queue_family_properties.queue_flags;
            let queue_video_codec_operations = video_properties[index].video_codec_operations;

            if queue_flags.contains(vk::QueueFlags::VIDEO_ENCODE_KHR) {
                if !queue_video_codec_operations.intersects(encode_operations) {
                    return Err(TestError::Fail("Invalid codec operations for encode queue".to_string()));
                }
                if queue_count == 0 {
                    return Err(TestError::Fail(
                        "Video encode queue returned queueCount is zero".to_string(),
                    ));
                }
                encode_pass = true;
            }

            if queue_flags.contains(vk::QueueFlags::VIDEO_DECODE_KHR) {
                if !queue_video_codec_operations.intersects(decode_operations) {
                    return Err(TestError::Fail("Invalid codec operations for decode queue".to_string()));
                }
                if queue_count == 0 {
                    return Err(TestError::Fail(
                        "Video decode queue returned queueCount is zero".to_string(),
                    ));
                }
                decode_pass = true;
            }
        }

        if !context.is_device_functionality_supported("VK_KHR_video_encode_queue") {
            encode_pass = false;
        }
        if !context.is_device_functionality_supported("VK_KHR_video_decode_queue") {
            decode_pass = false;
        }

        Ok(if encode_pass || decode_pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Neither encode, nor decode is available")
        })
    }

    /// `VideoFormatPropertiesQueryTestInstance::iterate` without extended flags
    fn format_support_query(&self, image_usage_flags: vk::ImageUsageFlags) -> TestOutcome {
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let commands = instance.commands();

        let chain = Chain::new(&TestParams {
            format: vk::Format::UNDEFINED,
            codec: self.case_def.codec,
            usage: image_usage_flags,
            chroma_subsampling: vk::VideoChromaSubsamplingFlagsKHR::_420,
            bit_depth: vk::VideoComponentBitDepthFlagsKHR::_8,
        });
        let video_format_info = vk::PhysicalDeviceVideoFormatInfoKHR {
            next: ptr::from_ref(&*chain.profile_list).cast::<c_void>(),
            image_usage: image_usage_flags,
            ..Default::default()
        };
        let image_usage_flags_dpb =
            vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR | vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR;
        let image_usage_dpb = video_format_info.image_usage.intersects(image_usage_flags_dpb);

        let mut count = 0u32;
        let result = unsafe {
            (commands.get_physical_device_video_format_properties_khr)(
                physical_device,
                &video_format_info,
                &mut count,
                ptr::null_mut(),
            )
        };
        if result != vk::Result::SUCCESS {
            return Ok(TestStatus::fail(format!(
                "Failed query call to vkGetPhysicalDeviceVideoFormatPropertiesKHR with {result:?}"
            )));
        }
        if count == 0 {
            return Ok(TestStatus::fail(
                "vkGetPhysicalDeviceVideoFormatPropertiesKHR reports 0 formats",
            ));
        }

        let unwritten = vk::VideoFormatPropertiesKHR {
            format: vk::Format::from_raw(i32::MAX),
            image_type: vk::ImageType::_2D,
            image_tiling: vk::ImageTiling::OPTIMAL,
            image_usage_flags: image_usage_flags_dpb,
            ..Default::default()
        };
        let mut video_format_properties = vec![unwritten; count as usize];
        let requested_count = count;
        let result = unsafe {
            (commands.get_physical_device_video_format_properties_khr)(
                physical_device,
                &video_format_info,
                &mut count,
                video_format_properties.as_mut_ptr(),
            )
        };
        if result != vk::Result::SUCCESS {
            return Ok(TestStatus::fail(format!(
                "Failed query data call to vkGetPhysicalDeviceVideoFormatPropertiesKHR with {result:?}"
            )));
        }
        if count == 0 {
            return Ok(TestStatus::fail(
                "vkGetPhysicalDeviceVideoFormatPropertiesKHR reports 0 formats supported for chosen encding/decoding",
            ));
        }
        if count != requested_count {
            return Ok(TestStatus::fail("Number of formats returned is less than reported."));
        }

        let mut test_result = false;
        for video_format_property in &video_format_properties {
            if video_format_property.format == vk::Format::from_raw(i32::MAX) {
                return Ok(TestStatus::fail("Format is not written"));
            }

            if video_format_property.format == vk::Format::UNDEFINED {
                if !image_usage_dpb {
                    return Err(TestError::Fail(
                        "VK_FORMAT_UNDEFINED is allowed only for DPB image usage".to_string(),
                    ));
                }
                if video_format_properties.len() != 1 {
                    return Err(TestError::Fail(
                        "VK_FORMAT_UNDEFINED must be the only format returned for opaque DPB".to_string(),
                    ));
                }
                test_result = true;
                break;
            }

            if video_format_property.format == vk::Format::G8_B8_R8_3PLANE_420_UNORM
                || video_format_property.format == vk::Format::G8_B8R8_2PLANE_420_UNORM
            {
                test_result = true;
                break;
            }
        }

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestInstance for CapabilitiesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let case_def = self.case_def;
        match case_def.kind {
            Kind::QueueSupport => self.queue_support_query(),
            Kind::FormatSupport(usage) if !case_def.extended_flags => self.format_support_query(usage),
            Kind::CapabilitiesQuery => capabilities_query(self.context, case_def.codec),
            Kind::IntraRefreshCapabilitiesQuery => intra_refresh_capabilities_query(self.context, case_def.codec),
            _ => Err(TestError::NotPorted(
                "VK_KHR_video_encode_feedback2 (not in vulkanalia 0.35), or VkImageUsageFlags2CreateInfoKHR for the format queries with extended flags"
                    .to_string(),
            )),
        }
    }
}

/// `createVideoCapabilitiesTests`: the cases keyed by their dotted path (`capabilities.{none,extended_flags}.<name>`)
pub fn create_capabilities_cases() -> HashMap<String, Box<dyn TestCase>> {
    use vk::VideoCodecOperationFlagsKHR as Codec;

    // (name of the codec, decode, encode)
    let codecs: [(&str, Option<Codec>, Option<Codec>); 4] = [
        ("h264", Some(Codec::DECODE_H264), Some(Codec::ENCODE_H264)),
        ("h265", Some(Codec::DECODE_H265), Some(Codec::ENCODE_H265)),
        ("av1", Some(Codec::DECODE_AV1), Some(Codec::ENCODE_AV1)),
        ("vp9", Some(Codec::DECODE_VP9), None),
    ];

    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for (group, extended_flags) in [("none", false), ("extended_flags", true)] {
        let mut add = |name: String, kind: Kind, codec: Codec| {
            cases.insert(
                format!("capabilities.{group}.{name}"),
                Box::new(CapabilitiesCase {
                    name,
                    case_def: CaseDef {
                        kind,
                        codec,
                        extended_flags,
                    },
                }),
            );
        };

        add("queue_support_query".to_string(), Kind::QueueSupport, Codec::NONE);
        for (codec_name, decode, encode) in codecs {
            if let Some(codec) = decode {
                add(
                    format!("{codec_name}_decode_dst_video_format_support_query"),
                    Kind::FormatSupport(vk::ImageUsageFlags::VIDEO_DECODE_DST_KHR),
                    codec,
                );
                add(
                    format!("{codec_name}_decode_dpb_video_format_support_query"),
                    Kind::FormatSupport(vk::ImageUsageFlags::VIDEO_DECODE_DPB_KHR),
                    codec,
                );
                add(
                    format!("{codec_name}_decode_capabilities_query"),
                    Kind::CapabilitiesQuery,
                    codec,
                );
            }
            if let Some(codec) = encode {
                add(
                    format!("{codec_name}_encode_src_video_format_support_query"),
                    Kind::FormatSupport(vk::ImageUsageFlags::VIDEO_ENCODE_SRC_KHR),
                    codec,
                );
                add(
                    format!("{codec_name}_encode_dpb_video_format_support_query"),
                    Kind::FormatSupport(vk::ImageUsageFlags::VIDEO_ENCODE_DPB_KHR),
                    codec,
                );
                add(
                    format!("{codec_name}_encode_capabilities_query"),
                    Kind::CapabilitiesQuery,
                    codec,
                );
                add(
                    format!("{codec_name}_encode_intra_refresh_capabilities_query"),
                    Kind::IntraRefreshCapabilitiesQuery,
                    codec,
                );
                add(
                    format!("{codec_name}_encode_feedback2_capabilities_query"),
                    Kind::Feedback2CapabilitiesQuery,
                    codec,
                );
            }
        }
    }
    cases
}
