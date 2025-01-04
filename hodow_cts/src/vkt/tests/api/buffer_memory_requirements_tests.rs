// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiBufferMemoryRequirementsTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiBufferMemoryRequirementsTestsUtils.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `u::BitsSet` (a `std::set` of `(bit, name...)` tuples ordered by the bit) is a `u32` mask over
// the index of a bit in its table here; the tables are written in ascending bit order, so iterating a mask
// low to high is iterating the set. Everything that decides a group name or the order cases run in
// (`combine`, `updateBufferCreateFlags`) is kept step for step.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const FATE_TRANSFER: u32 = 0x01;
const FATE_STORAGE: u32 = 0x02;
const FATE_OTHER: u32 = 0x04;
const FATE_ACC_STRUCTURE: u32 = 0x08;
const FATE_VIDEO: u32 = 0x10;

/// `AvailableBufferFateBits`, in ascending key order.
const FATE_BITS: [(u32, &str); 5] = [
    (FATE_TRANSFER, "transfer_usage_bits"),
    (FATE_STORAGE, "storage_usage_bits"),
    (FATE_OTHER, "other_usage_bits"),
    (FATE_ACC_STRUCTURE, "acc_struct_usage_bits"),
    (FATE_VIDEO, "video_usage_bits"),
];

/// `AvailableBufferCreateBits`, in ascending key order.
const CREATE_BITS: [(u32, &str); 5] = [
    (0, "no_flags"),
    (0x1, "sparse_binding"),
    (0x2, "sparse_residency"),
    (0x4, "sparse_aliased"),
    (0x8, "protected"),
];
const CREATE_NONE: usize = 0;
const CREATE_BINDING: usize = 1;
const CREATE_RESIDENCY: usize = 2;
const CREATE_ALIASED: usize = 3;
const CREATE_PROTECTED: usize = 4;

const USAGE_TRANSFER_SRC: u32 = 0x1;
const USAGE_TRANSFER_DST: u32 = 0x2;
const USAGE_UNIFORM_TEXEL: u32 = 0x4;
const USAGE_STORAGE_TEXEL: u32 = 0x8;
const USAGE_UNIFORM: u32 = 0x10;
const USAGE_STORAGE: u32 = 0x20;
const USAGE_INDEX: u32 = 0x40;
const USAGE_VERTEX: u32 = 0x80;
const USAGE_INDIRECT: u32 = 0x100;
const USAGE_CONDITIONAL_RENDERING: u32 = 0x200;
const USAGE_SHADER_BINDING_TABLE: u32 = 0x400;
const USAGE_TRANSFORM_FEEDBACK: u32 = 0x800;
const USAGE_TRANSFORM_FEEDBACK_COUNTER: u32 = 0x1000;
const USAGE_VIDEO_DECODE_SRC: u32 = 0x2000;
const USAGE_VIDEO_DECODE_DST: u32 = 0x4000;
const USAGE_VIDEO_ENCODE_DST: u32 = 0x8000;
const USAGE_VIDEO_ENCODE_SRC: u32 = 0x10000;
const USAGE_SHADER_DEVICE_ADDRESS: u32 = 0x20000;
const USAGE_AS_BUILD_INPUT_READ_ONLY: u32 = 0x80000;
const USAGE_AS_STORAGE: u32 = 0x100000;

/// `AvailableBufferUsageBits` as (key, fate), in ascending key order.
const USAGE_BITS: [(u32, u32); 20] = [
    (USAGE_TRANSFER_SRC, FATE_TRANSFER),
    (USAGE_TRANSFER_DST, FATE_TRANSFER),
    (USAGE_UNIFORM_TEXEL, FATE_STORAGE),
    (USAGE_STORAGE_TEXEL, FATE_STORAGE),
    (USAGE_UNIFORM, FATE_STORAGE),
    (USAGE_STORAGE, FATE_STORAGE),
    (USAGE_INDEX, FATE_STORAGE),
    (USAGE_VERTEX, FATE_STORAGE),
    (USAGE_INDIRECT, FATE_OTHER),
    (USAGE_CONDITIONAL_RENDERING, FATE_OTHER),
    (USAGE_SHADER_BINDING_TABLE, FATE_ACC_STRUCTURE),
    (USAGE_TRANSFORM_FEEDBACK, FATE_OTHER),
    (USAGE_TRANSFORM_FEEDBACK_COUNTER, FATE_OTHER),
    (USAGE_VIDEO_DECODE_SRC, FATE_VIDEO),
    (USAGE_VIDEO_DECODE_DST, FATE_VIDEO),
    (USAGE_VIDEO_ENCODE_DST, FATE_VIDEO),
    (USAGE_VIDEO_ENCODE_SRC, FATE_VIDEO),
    (USAGE_SHADER_DEVICE_ADDRESS, FATE_OTHER),
    (USAGE_AS_BUILD_INPUT_READ_ONLY, FATE_ACC_STRUCTURE),
    (USAGE_AS_STORAGE, FATE_ACC_STRUCTURE),
];

/// The two `AvailableExternalMemoryHandleBits` entries whose `Ignored` flag is true (host allocation and
/// host mapped foreign memory); the `no_flags` one is `INTERNALTEST_EXTERNAL_MEMORY_HANDLE_TYPE_NO_BITS`.
const EXT_MEM_HANDLE_HOST_BITS: [u32; 2] = [0x80, 0x100];

const VIDEO_CODEC_ENCODE_H264: u32 = 0x0001_0000;
const VIDEO_CODEC_DECODE_H264: u32 = 0x0000_0001;

/// `BitsSet::operator Flag`
fn flags_of(keys: &[u32], mask: u32) -> u32 {
    let mut flag = 0;
    for (i, key) in keys.iter().enumerate() {
        if mask & (1 << i) != 0 {
            flag |= key;
        }
    }
    flag
}

/// `u::combine` - the set, then every set with one element removed, depth first. `hints` holds the flag value
/// of every set already emitted, so two sets with the same flags (a 0-valued element adds nothing) emit once.
fn combine(keys: &[u32], mask: u32, hints: &mut Vec<u32>, result: &mut Vec<u32>) {
    let flag = flags_of(keys, mask);
    if mask == 0 || hints.contains(&flag) {
        return;
    }
    hints.push(flag);
    result.push(mask);
    for b in 0..mask.count_ones() {
        let mut tmp = mask;
        let mut seen = 0;
        for i in 0..keys.len() {
            if tmp & (1 << i) != 0 {
                if seen == b {
                    tmp &= !(1 << i);
                    break;
                }
                seen += 1;
            }
        }
        combine(keys, tmp, hints, result);
    }
}

/// `bitsToString`
fn bits_to_string(names: &[&str], mask: u32, prefix: &str) -> String {
    let mut s = String::from(prefix);
    let mut at_least_one = false;
    for (i, name) in names.iter().enumerate() {
        if mask & (1 << i) != 0 {
            if at_least_one {
                s.push('_');
            }
            s.push_str(name);
            at_least_one = true;
        }
    }
    s
}

/// `updateBufferCreateFlags`
fn update_buffer_create_flags(flags: &mut Vec<u32>) {
    // VUID-VkBufferCreateInfo-flags-00918 { if sparse residency or sparse aliased include sparse binding }
    for bits in flags.iter_mut() {
        if *bits & (1 << CREATE_RESIDENCY) != 0 || *bits & (1 << CREATE_ALIASED) != 0 {
            *bits |= 1 << CREATE_BINDING;
        }
    }

    // VUID-VkBufferCreateInfo-None-01888 { if sparse residency, sparse aliased or sparse binding then flags must not include protected }
    let disallowed = (1u32 << CREATE_RESIDENCY) | (1 << CREATE_ALIASED) | (1 << CREATE_BINDING);
    for bits in flags.iter_mut() {
        if *bits & (1 << CREATE_PROTECTED) != 0 {
            *bits &= !disallowed;
        }
    }
    flags.retain(|bits| *bits != 0);

    // since 0 is a valid VkBufferCreateFlagBits flag then remove it flags where it exists along with other non-zero flags
    for bits in flags.iter_mut() {
        if *bits & (1 << CREATE_NONE) != 0 && bits.count_ones() > 1 {
            *bits &= !(1 << CREATE_NONE);
        }
    }

    // remove duplicates
    let mut unique: Vec<u32> = Vec::new();
    for bits in flags.iter() {
        if !unique.contains(bits) {
            unique.push(*bits);
        }
    }
    *flags = unique;
}

/// `TestConfig`
#[derive(Clone, Copy)]
struct TestConfig {
    use_method2: bool,
    create_mask: u32,
    fate: u32,
    inc_ext_mem_type_flags: bool,
    // Tests the buffer memory size requirement is less than or equal to the aligned size of the buffer.
    // Requires VK_KHR_maintenance4 extension.
    test_size_requirements: bool,
}

impl TestConfig {
    fn create_flags(&self) -> u32 {
        let keys: Vec<u32> = CREATE_BITS.iter().map(|(k, _)| *k).collect();
        flags_of(&keys, self.create_mask)
    }

    fn is_protected(&self) -> bool {
        self.create_mask & (1 << CREATE_PROTECTED) != 0
    }
}

/// `Context::isBufferDeviceAddressSupported`
fn is_buffer_device_address_supported(context: &Context<'_>) -> bool {
    if context.is_device_functionality_supported("VK_KHR_buffer_device_address")
        || context.is_device_functionality_supported("VK_EXT_buffer_device_address")
    {
        return true;
    }
    if context.api_version() < (1, 2, 0) {
        return false;
    }
    let mut bda = vk::PhysicalDeviceBufferDeviceAddressFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    features2.next = (&raw mut bda).cast();
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    bda.buffer_device_address != vk::FALSE
}

/// `readVideoCodecOperationFlagsKHR`
fn read_video_codec_operation_flags(context: &Context<'_>) -> u32 {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut count = 0u32;
    unsafe {
        (instance.commands().get_physical_device_queue_family_properties2)(
            physical_device,
            &mut count,
            std::ptr::null_mut(),
        );
    }

    let mut video_props = vec![vk::QueueFamilyVideoPropertiesKHR::default(); count as usize];
    let mut props = vec![vk::QueueFamilyProperties2::default(); count as usize];
    for (p, v) in props.iter_mut().zip(video_props.iter_mut()) {
        p.next = (v as *mut vk::QueueFamilyVideoPropertiesKHR).cast::<c_void>();
    }

    unsafe {
        (instance.commands().get_physical_device_queue_family_properties2)(
            physical_device,
            &mut count,
            props.as_mut_ptr(),
        );
    }

    let mut flags = 0u32;
    for v in &video_props {
        flags |= v.video_codec_operations.bits();
    }
    flags
}

/// The usage-flag half of `checkSupport`. Returns the usage flag sets the instance will run, and the notes
/// upstream writes to the log about the ones it dropped.
fn build_usage_flags(context: &Context<'_>, config: &TestConfig) -> (Vec<u32>, Vec<String>) {
    let usage_keys: Vec<u32> = USAGE_BITS.iter().map(|(k, _)| *k).collect();

    // `mergeFlags` into an empty set list takes the new sets as they are.
    let mut usage_flags: Vec<u32> = {
        let mut select_mask = 0u32;
        for (i, (_, fate)) in USAGE_BITS.iter().enumerate() {
            if *fate == config.fate {
                select_mask |= 1 << i;
            }
        }
        let mut hints = Vec::new();
        let mut masks = Vec::new();
        combine(&usage_keys, select_mask, &mut hints, &mut masks);
        masks.iter().map(|m| flags_of(&usage_keys, *m)).collect()
    };

    let mut notes: Vec<String> = Vec::new();
    let mut msgs = [false; 7];

    // VUID-VkBufferCreateInfo-flags-09641
    let protected_allowed_usage: u32 = USAGE_TRANSFER_SRC
        | USAGE_TRANSFER_DST
        | USAGE_UNIFORM_TEXEL
        | USAGE_STORAGE_TEXEL
        | USAGE_UNIFORM
        | USAGE_STORAGE
        | USAGE_SHADER_DEVICE_ADDRESS
        | USAGE_VIDEO_DECODE_SRC
        | USAGE_VIDEO_ENCODE_DST;
    let is_protected = config.is_protected();

    let any = |flags: u32, bits: &[u32]| bits.iter().any(|b| flags & b != 0);

    let video_flags_cache = std::cell::OnceCell::new();

    usage_flags.retain(|&flags| {
        let mut not_supported = false;

        if is_protected && (flags & !protected_allowed_usage) != 0 {
            not_supported = true;
        }

        if any(flags, &[USAGE_AS_BUILD_INPUT_READ_ONLY, USAGE_AS_STORAGE, USAGE_SHADER_BINDING_TABLE])
            && !context.is_device_functionality_supported("VK_KHR_acceleration_structure")
        {
            if !msgs[0] {
                notes.push("VK_KHR_acceleration_structure not supported by device".to_string());
                msgs[0] = true;
            }
            not_supported = true;
        }

        if flags & USAGE_SHADER_DEVICE_ADDRESS != 0 && !is_buffer_device_address_supported(context) {
            if !msgs[1] {
                notes.push("VK_EXT_buffer_device_address not supported by device".to_string());
                msgs[1] = true;
            }
            not_supported = true;
        }

        if any(flags, &[USAGE_VIDEO_DECODE_SRC, USAGE_VIDEO_DECODE_DST, USAGE_VIDEO_ENCODE_SRC, USAGE_VIDEO_ENCODE_DST]) {
            if !context.is_device_functionality_supported("VK_KHR_video_queue") {
                if !msgs[2] {
                    notes.push("VK_KHR_video_queue not supported by device".to_string());
                    msgs[2] = true;
                }
                not_supported = true;
            } else {
                let video_flags = *video_flags_cache.get_or_init(|| read_video_codec_operation_flags(context));

                if any(flags, &[USAGE_VIDEO_ENCODE_SRC, USAGE_VIDEO_ENCODE_DST]) {
                    if !context.is_device_functionality_supported("VK_KHR_video_encode_h264") {
                        if !msgs[3] {
                            notes.push("VK_KHR_video_encode_h264 not supported by device".to_string());
                            msgs[3] = true;
                        }
                        not_supported = true;
                    }
                    if video_flags & VIDEO_CODEC_ENCODE_H264 == 0 {
                        if !msgs[4] {
                            notes.push(
                                "Could not find a queue that supports VK_VIDEO_CODEC_OPERATION_ENCODE_H264_BIT_EXT on device".to_string(),
                            );
                            msgs[4] = true;
                        }
                        not_supported = true;
                    }
                }
                if any(flags, &[USAGE_VIDEO_DECODE_SRC, USAGE_VIDEO_DECODE_DST]) {
                    if !context.is_device_functionality_supported("VK_KHR_video_decode_h264") {
                        if !msgs[5] {
                            notes.push("VK_KHR_video_decode_h264 not supported by device".to_string());
                            msgs[5] = true;
                        }
                        not_supported = true;
                    }
                    if video_flags & VIDEO_CODEC_DECODE_H264 == 0 {
                        if !msgs[6] {
                            notes.push(
                                "Could not find a queue that supports VK_VIDEO_CODEC_OPERATION_DECODE_H264_BIT_KHR on device".to_string(),
                            );
                            msgs[6] = true;
                        }
                        not_supported = true;
                    }
                }
            }
        }

        !not_supported
    });

    // remove duplicates
    let mut unique: Vec<u32> = Vec::new();
    for flags in usage_flags {
        if !unique.contains(&flags) {
            unique.push(flags);
        }
    }

    (unique, notes)
}

/// The external-memory-handle half of `checkSupport`.
fn build_ext_mem_handle_flags(config: &TestConfig) -> Vec<u32> {
    if config.inc_ext_mem_type_flags {
        return vec![0];
    }
    let mut hints = Vec::new();
    let mut masks = Vec::new();
    combine(&EXT_MEM_HANDLE_HOST_BITS, 0b11, &mut hints, &mut masks);
    masks.iter().map(|m| flags_of(&EXT_MEM_HANDLE_HOST_BITS, *m)).collect()
}

/// `MemoryRequirementsTest::checkSupport`
fn check_support(context: &Context<'_>, config: &TestConfig) -> Result<(), TestError> {
    // VK_KHR_get_physical_device_properties2 is core in the 1.1 instance this port always creates.

    if config.use_method2 && context.api_version() < (1, 1, 0) {
        context.require_device_functionality("VK_KHR_get_memory_requirements2")?;
    }

    let mut protected_mem_features = vk::PhysicalDeviceProtectedMemoryFeatures::default();
    let mut ext_features = vk::PhysicalDeviceFeatures2::default();
    ext_features.next = (&raw mut protected_mem_features).cast();
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut ext_features)
    };

    let features = ext_features.features;
    let protected_mem_feature_enabled = protected_mem_features.protected_memory;

    // check the creating bits
    {
        let mut notes: Vec<String> = Vec::new();
        let create_mask = config.create_mask;
        let has = |index: usize| create_mask & (1 << index) != 0;

        if has(CREATE_BINDING) && features.sparse_binding == vk::FALSE {
            notes.push(create_note("VK_BUFFER_CREATE_SPARSE_BINDING_BIT"));
        }
        if has(CREATE_RESIDENCY) && features.sparse_residency_buffer == vk::FALSE {
            notes.push(create_note("VK_BUFFER_CREATE_SPARSE_RESIDENCY_BIT"));
        }
        if has(CREATE_ALIASED) && features.sparse_residency_aliased == vk::FALSE {
            notes.push(create_note("VK_BUFFER_CREATE_SPARSE_ALIASED_BIT"));
        }
        if has(CREATE_PROTECTED) && protected_mem_feature_enabled == vk::FALSE {
            notes.push(create_note("VK_BUFFER_CREATE_PROTECTED_BIT"));
        }
        if !notes.is_empty() {
            for note in &notes {
                log::info!("{note}");
            }
            return Err(TestError::NotSupported(
                "One or more create buffer flags not supported by device (check log for details)".to_string(),
            ));
        }
    }

    // check the usage bits and build instance input
    {
        let (usage_flags, notes) = build_usage_flags(context, config);
        if usage_flags.is_empty() {
            for note in &notes {
                log::info!("{note}");
            }
            return Err(TestError::NotSupported(
                "One or more buffer usage flags not supported by device (check log for details)".to_string(),
            ));
        }
        for note in &notes {
            log::info!("{note}");
        }
    }

    if config.test_size_requirements && !context.is_device_functionality_supported("VK_KHR_maintenance4") {
        return Err(TestError::NotSupported("VK_KHR_maintenance4 not supported".to_string()));
    }

    Ok(())
}

fn create_note(flag_name: &str) -> String {
    format!("Create buffer with {flag_name} not supported by device")
}

/// `DeviceWrapper` - the Context's device, or the protected-memory one `createProtectedDevice` makes.
enum DeviceWrapper<'a> {
    Default(&'a Device),
    // Boxed because a `Device` carries its whole dispatch table.
    Custom(Box<Device>),
}

impl DeviceWrapper<'_> {
    fn get_driver(&self) -> &Device {
        match self {
            Self::Default(d) => d,
            Self::Custom(d) => d,
        }
    }
}

impl Drop for DeviceWrapper<'_> {
    fn drop(&mut self) {
        if let Self::Custom(device) = self {
            unsafe {
                let _ = device.device_wait_idle();
                device.destroy_device(None);
            }
        }
    }
}

/// `createProtectedDevice`
fn create_protected_device<'a>(context: &Context<'_>) -> Result<DeviceWrapper<'a>, TestError> {
    let queue_priority = 1.0f32;

    let protected_memory_features = vk::PhysicalDeviceProtectedMemoryFeatures {
        s_type: vk::StructureType::PHYSICAL_DEVICE_PROTECTED_MEMORY_FEATURES,
        next: std::ptr::null_mut(),
        protected_memory: vk::TRUE,
    };

    let queue_info = vk::DeviceQueueCreateInfo {
        s_type: vk::StructureType::DEVICE_QUEUE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::DeviceQueueCreateFlags::PROTECTED,
        queue_family_index: context.get_universal_queue_family_index(),
        queue_count: 1,
        queue_priorities: &raw const queue_priority,
    };
    let device_info = vk::DeviceCreateInfo {
        s_type: vk::StructureType::DEVICE_CREATE_INFO,
        next: (&raw const protected_memory_features).cast(),
        flags: vk::DeviceCreateFlags::empty(),
        queue_create_info_count: 1,
        queue_create_infos: &raw const queue_info,
        enabled_layer_count: 0,
        enabled_layer_names: std::ptr::null(),
        enabled_extension_count: 0,
        enabled_extension_names: std::ptr::null(),
        enabled_features: std::ptr::null(),
    };

    let device = unsafe {
        context
            .get_instance()
            .create_device(context.get_physical_device(), &device_info, None)
    }
    .vk_check("vkCreateDevice")?;
    Ok(DeviceWrapper::Custom(Box::new(device)))
}

/// `getBufferMemoryRequirements2`
fn get_buffer_memory_requirements2(vkd: &Device, buffer: vk::Buffer) -> vk::MemoryRequirements {
    let mut dedicated_requirements = vk::MemoryDedicatedRequirements::default();

    let mut desired_requirements = vk::MemoryRequirements2::default();
    desired_requirements.next = (&raw mut dedicated_requirements).cast();

    let requirements_info = vk::BufferMemoryRequirementsInfo2 {
        s_type: vk::StructureType::BUFFER_MEMORY_REQUIREMENTS_INFO_2,
        next: std::ptr::null(),
        buffer,
    };

    unsafe { vkd.get_buffer_memory_requirements2(&requirements_info, &mut desired_requirements) };

    desired_requirements.memory_requirements
}

/// `getBufferMemoryRequirements`
fn get_buffer_memory_requirements(vkd: &Device, buffer: vk::Buffer) -> vk::MemoryRequirements {
    unsafe { vkd.get_buffer_memory_requirements(buffer) }
}

/// `deAlign64`
fn align64(value: u64, alignment: u64) -> u64 {
    if alignment == 0 {
        return value;
    }
    value.div_ceil(alignment) * alignment
}

/// One failed (create flags, usage flags, external memory handle flags) combination.
struct FailedSubtest {
    create_flags: u32,
    usage_flags: u32,
    ext_mem_handle_flags: u32,
}

/// `BufferMemoryRequirementsInstance::logFailedSubtests`
fn log_failed_subtests(failed: &[FailedSubtest]) {
    log::info!("Failed subtests");
    for f in failed {
        log::info!(
            "VkBufferCreateFlags: {:?}",
            vk::BufferCreateFlags::from_bits_truncate(f.create_flags)
        );
        log::info!(
            "VkBufferUsageFlags: {:?}",
            vk::BufferUsageFlags::from_bits_truncate(f.usage_flags)
        );
        log::info!(
            "VkExternalMemoryHandleTypeFlags: {:?}",
            vk::ExternalMemoryHandleTypeFlags::from_bits_truncate(f.ext_mem_handle_flags)
        );
    }
}

/// `BufferMemoryRequirementsInstance::iterate`
fn iterate(context: &Context<'_>, config: &TestConfig) -> TestOutcome {
    let queue_family_index = context.get_universal_queue_family_index();

    let mut pass_count = 0u32;
    let mut fail_count = 0u32;
    let mut failed: Vec<FailedSubtest> = Vec::new();

    let device = if config.is_protected() {
        create_protected_device(context)?
    } else {
        DeviceWrapper::Default(context.get_device())
    };
    let vkd = device.get_driver();

    let info_create_flags = config.create_flags();
    let (usage_flags, _) = build_usage_flags(context, config);
    let ext_mem_handle_flags = build_ext_mem_handle_flags(config);

    for &info_usage_flags in &usage_flags {
        for &handle_flags in &ext_mem_handle_flags {
            let mut next: *const c_void = std::ptr::null();

            // chainVkStructure<VkVideoProfileListInfoKHR>
            let mut encode_profile = vk::VideoEncodeH264ProfileInfoKHR::default();
            encode_profile.std_profile_idc = vk::video::STD_VIDEO_H264_PROFILE_IDC_BASELINE;
            let mut decode_profile = vk::VideoDecodeH264ProfileInfoKHR::default();
            decode_profile.std_profile_idc = vk::video::STD_VIDEO_H264_PROFILE_IDC_BASELINE;
            decode_profile.picture_layout = vk::VideoDecodeH264PictureLayoutFlagsKHR::empty();

            let mut video_profiles = [vk::VideoProfileInfoKHR::default(), vk::VideoProfileInfoKHR::default()];
            video_profiles[0].next = (&raw const encode_profile).cast();
            video_profiles[0].video_codec_operation =
                vk::VideoCodecOperationFlagsKHR::from_bits_truncate(VIDEO_CODEC_ENCODE_H264);
            video_profiles[0].chroma_subsampling = vk::VideoChromaSubsamplingFlagsKHR::from_bits_truncate(0x1);
            video_profiles[0].luma_bit_depth = vk::VideoComponentBitDepthFlagsKHR::from_bits_truncate(0x1);
            video_profiles[0].chroma_bit_depth = vk::VideoComponentBitDepthFlagsKHR::from_bits_truncate(0x1);
            video_profiles[1].next = (&raw const decode_profile).cast();
            video_profiles[1].video_codec_operation =
                vk::VideoCodecOperationFlagsKHR::from_bits_truncate(VIDEO_CODEC_DECODE_H264);
            video_profiles[1].chroma_subsampling = vk::VideoChromaSubsamplingFlagsKHR::from_bits_truncate(0x1);
            video_profiles[1].luma_bit_depth = vk::VideoComponentBitDepthFlagsKHR::from_bits_truncate(0x1);
            video_profiles[1].chroma_bit_depth = vk::VideoComponentBitDepthFlagsKHR::from_bits_truncate(0x1);

            let mut profiles = vk::VideoProfileListInfoKHR::default();
            if config.fate == FATE_VIDEO {
                let encode = info_usage_flags & (USAGE_VIDEO_ENCODE_SRC | USAGE_VIDEO_ENCODE_DST) != 0;
                let decode = info_usage_flags & (USAGE_VIDEO_DECODE_SRC | USAGE_VIDEO_DECODE_DST) != 0;
                profiles.next = next;
                if encode && decode {
                    profiles.profile_count = 2;
                    profiles.profiles = video_profiles.as_ptr();
                } else if encode {
                    profiles.profile_count = 1;
                    profiles.profiles = &video_profiles[0];
                } else {
                    profiles.profile_count = 1;
                    profiles.profiles = &video_profiles[1];
                }
                next = (&raw const profiles).cast();
            }

            // chainVkStructure<VkExternalMemoryBufferCreateInfo>
            let mut ext_mem_info = vk::ExternalMemoryBufferCreateInfo::default();
            if config.inc_ext_mem_type_flags {
                ext_mem_info.next = next;
                ext_mem_info.handle_types = vk::ExternalMemoryHandleTypeFlags::from_bits_truncate(handle_flags);
                next = (&raw const ext_mem_info).cast();
            }

            let mut create_info = vk::BufferCreateInfo {
                s_type: vk::StructureType::BUFFER_CREATE_INFO,
                next,
                flags: vk::BufferCreateFlags::from_bits_truncate(info_create_flags),
                size: 4096,
                usage: vk::BufferUsageFlags::from_bits_truncate(info_usage_flags),
                sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 1,
                queue_family_indices: &raw const queue_family_index,
            };

            let get_requirements = |buffer: vk::Buffer| {
                if config.use_method2 {
                    get_buffer_memory_requirements2(vkd, buffer)
                } else {
                    get_buffer_memory_requirements(vkd, buffer)
                }
            };

            if config.test_size_requirements {
                let mut maintenance4_properties = vk::PhysicalDeviceMaintenance4Properties::default();
                let mut physical_device_properties2 = vk::PhysicalDeviceProperties2::default();
                physical_device_properties2.next = (&raw mut maintenance4_properties).cast();
                unsafe {
                    context.get_instance().get_physical_device_properties2(
                        context.get_physical_device(),
                        &mut physical_device_properties2,
                    )
                };

                let max_buffer_size = maintenance4_properties.max_buffer_size;
                assert!(max_buffer_size > 0);
                let mut n = 0u64;

                while (1u64 << n) + 1 < max_buffer_size {
                    create_info.size = (1u64 << n) + 1;

                    // Upstream catches vk::OutOfMemoryError around this block.
                    let buffer = match unsafe { vkd.create_buffer(&create_info, None) } {
                        Ok(buffer) => Unique::new(vkd, buffer),
                        Err(vk::ErrorCode::OUT_OF_HOST_MEMORY | vk::ErrorCode::OUT_OF_DEVICE_MEMORY) => break,
                        Err(code) => return Err(TestError::InternalError(format!("vkCreateBuffer returned {code:?}"))),
                    };

                    let reqs = get_requirements(*buffer);

                    if reqs.size <= align64(create_info.size, reqs.alignment) {
                        pass_count += 1;
                    } else {
                        fail_count += 1;
                        failed.push(FailedSubtest {
                            create_flags: info_create_flags,
                            usage_flags: info_usage_flags,
                            ext_mem_handle_flags: handle_flags,
                        });
                    }

                    n += 1;
                }
            } else {
                let buffer = Unique::new(
                    vkd,
                    unsafe { vkd.create_buffer(&create_info, None) }.vk_check("vkCreateBuffer")?,
                );

                let reqs = get_requirements(*buffer);
                if reqs.memory_type_bits != 0 {
                    pass_count += 1;
                } else {
                    fail_count += 1;
                    failed.push(FailedSubtest {
                        create_flags: info_create_flags,
                        usage_flags: info_usage_flags,
                        ext_mem_handle_flags: handle_flags,
                    });
                }
            }
        }
    }

    if fail_count != 0 {
        log_failed_subtests(&failed);
        return Ok(TestStatus::fail(fail_count.to_string()));
    }

    Ok(TestStatus::pass(pass_count.to_string()))
}

struct MemoryRequirementsCase {
    name: String,
    config: TestConfig,
}

impl TestCase for MemoryRequirementsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support(context, &self.config)
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferMemoryRequirementsInstance {
            context,
            config: self.config,
        })
    }
}

struct BufferMemoryRequirementsInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl TestInstance for BufferMemoryRequirementsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        iterate(self.context, &self.config)
    }
}

/// `createBufferMemoryRequirementsTests`
pub fn create_buffer_memory_requirements_tests() -> TestCaseGroup {
    let ext_mem_type_flags = [(false, "ext_mem_flags_excluded"), (true, "ext_mem_flags_included")];
    let methods = [(false, "method1"), (true, "method2")];

    let create_keys: Vec<u32> = CREATE_BITS.iter().map(|(k, _)| *k).collect();
    let create_names: Vec<&str> = CREATE_BITS.iter().map(|(_, n)| *n).collect();

    let mut create_masks: Vec<u32> = Vec::new();
    {
        let mut hints = Vec::new();
        combine(
            &create_keys,
            (1 << CREATE_BITS.len()) - 1,
            &mut hints,
            &mut create_masks,
        );
        update_buffer_create_flags(&mut create_masks);
    }

    // Upstream builds one single-bit set per fate on purpose, not the cartesian product of them.
    let fate_bits = FATE_BITS;

    let mut group_root = TestCaseGroup::new("buffer_memory_requirements");
    for &create_mask in &create_masks {
        let mut group_create = TestCaseGroup::new(bits_to_string(&create_names, create_mask, "create_"));
        for (include, ext_name) in ext_mem_type_flags {
            let mut group_ext_mem_type_flags = TestCaseGroup::new(ext_name);
            for (method, method_name) in methods {
                let mut group_method = TestCaseGroup::new(method_name);
                for (fate, fate_name) in fate_bits {
                    for test_size_req in [false, true] {
                        let config = TestConfig {
                            use_method2: method,
                            create_mask,
                            fate,
                            inc_ext_mem_type_flags: include,
                            test_size_requirements: test_size_req,
                        };
                        let name = format!("{}{}", if test_size_req { "size_req_" } else { "" }, fate_name);
                        group_method.add_child(Box::new(MemoryRequirementsCase { name, config }) as Box<dyn TestCase>);
                    }
                }
                group_ext_mem_type_flags.add_child(group_method);
            }
            group_create.add_child(group_ext_mem_type_flags);
        }
        group_root.add_child(group_create);
    }

    group_root
}
