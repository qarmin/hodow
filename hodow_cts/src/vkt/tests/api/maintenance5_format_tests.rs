// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiPhysicalDeviceFormatPropertiesMaint5Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The queries go through the command pointers, with the output structures pre-filled with
// 0xFF as upstream does: the wrappers vulkanalia offers hand back uninitialised memory
// when the driver writes nothing, and "nothing was written" is exactly what is tested.

use std::mem::MaybeUninit;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const VK_FORMAT_MAX_ENUM: i32 = 0x7FFF_FFFF;
const VK_IMAGE_USAGE_FLAG_BITS_MAX_ENUM: u32 = 0x7FFF_FFFF;

/// `FuncIDs`; the two flag bits upstream packs into the value are `has_format`/`has_flags`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum FuncId {
    DeviceFormatProps,
    DeviceFormatPropsSecond,
    DeviceImageFormatProps,
    DeviceImageFormatPropsSecond,
    DeviceSparseImageFormatProps,
    DeviceSparseImageFormatPropsSecond,
}

impl FuncId {
    fn has_format_param(self) -> bool {
        true
    }

    fn has_flags_param(self) -> bool {
        !matches!(self, Self::DeviceFormatProps | Self::DeviceFormatPropsSecond)
    }
}

/// `makeInvalidVulkanStructure`'s memset; the caller sets `sType`/`pNext` after.
///
/// # Safety
/// `T` must be a plain-data Vulkan structure for which every bit pattern is representable.
unsafe fn filled_with_ff<T>() -> T {
    let mut value = MaybeUninit::<T>::uninit();
    unsafe {
        std::ptr::write_bytes(value.as_mut_ptr(), 0xFF, 1);
        value.assume_init()
    }
}

fn invalid_format_properties2() -> vk::FormatProperties2 {
    let mut s: vk::FormatProperties2 = unsafe { filled_with_ff() };
    s.s_type = vk::StructureType::FORMAT_PROPERTIES_2;
    s.next = std::ptr::null_mut();
    s
}

fn invalid_image_format_properties2() -> vk::ImageFormatProperties2 {
    let mut s: vk::ImageFormatProperties2 = unsafe { filled_with_ff() };
    s.s_type = vk::StructureType::IMAGE_FORMAT_PROPERTIES_2;
    s.next = std::ptr::null_mut();
    s
}

/// `operator==(VkFormatProperties, VkFormatProperties)`
fn format_properties_equal(l: &vk::FormatProperties, r: &vk::FormatProperties) -> bool {
    l.buffer_features == r.buffer_features
        && l.linear_tiling_features == r.linear_tiling_features
        && l.optimal_tiling_features == r.optimal_tiling_features
}

/// `operator==(VkImageFormatProperties, VkImageFormatProperties)`
fn image_format_properties_equal(l: &vk::ImageFormatProperties, r: &vk::ImageFormatProperties) -> bool {
    l.max_mip_levels == r.max_mip_levels
        && l.max_array_layers == r.max_array_layers
        && l.sample_counts == r.sample_counts
        && l.max_resource_size == r.max_resource_size
}

fn usage_from_bits(bits: u32) -> vk::ImageUsageFlags {
    // bitflags 1.x has no `from_bits_retain`; the type is a plain integer with no invalid values.
    unsafe { vk::ImageUsageFlags::from_bits_unchecked(bits) }
}

fn verdict(res: vk::Result, verdicts: &[bool]) -> TestOutcome {
    if res == vk::Result::ERROR_FORMAT_NOT_SUPPORTED && verdicts.iter().all(|&x| x) {
        Ok(TestStatus::pass(""))
    } else {
        Ok(TestStatus::fail(""))
    }
}

/// `UnsupportedParametersMaintenance5FormatInstance::iterate`
fn unsupported_format(context: &Context<'_>, func_id: FuncId) -> TestOutcome {
    let dev = context.get_physical_device();
    let commands = context.get_instance().commands();
    let mut res = vk::Result::ERROR_FORMAT_NOT_SUPPORTED;
    let usage = vk::ImageUsageFlags::STORAGE;
    let image_type = vk::ImageType::_2D;
    let tiling = vk::ImageTiling::OPTIMAL;
    let create_flags = vk::ImageCreateFlags::empty();
    let sampling = vk::SampleCountFlags::_1;
    let invalid_props = invalid_format_properties2().format_properties;
    let empty_props = vk::FormatProperties::default();
    let invalid_img_props = invalid_image_format_properties2().image_format_properties;
    let empty_img_props = vk::ImageFormatProperties::default();

    let mut image_format_info = vk::PhysicalDeviceImageFormatInfo2 {
        format: vk::Format::UNDEFINED,
        type_: image_type,
        tiling,
        usage,
        flags: create_flags,
        ..Default::default()
    };

    let mut sparse_format_info = vk::PhysicalDeviceSparseImageFormatInfo2 {
        format: vk::Format::UNDEFINED,
        type_: image_type,
        samples: sampling,
        usage,
        tiling,
        ..Default::default()
    };

    const N: usize = 5;
    let mut verdicts = [false; N];

    assert!(func_id.has_format_param());

    for (i, verdict_slot) in verdicts.iter_mut().enumerate() {
        let format = vk::Format::from_raw(VK_FORMAT_MAX_ENUM - i as i32);

        match func_id {
            FuncId::DeviceFormatProps => {
                let mut props2 = invalid_format_properties2();
                unsafe { (commands.get_physical_device_format_properties)(dev, format, &mut props2.format_properties) };
                let props1 = props2.format_properties;
                *verdict_slot =
                    format_properties_equal(&empty_props, &props1) || format_properties_equal(&invalid_props, &props1);
            }

            FuncId::DeviceFormatPropsSecond => {
                let mut props2 = invalid_format_properties2();
                unsafe { (commands.get_physical_device_format_properties2)(dev, format, &mut props2) };
                let props1 = props2.format_properties;
                *verdict_slot =
                    format_properties_equal(&empty_props, &props1) || format_properties_equal(&invalid_props, &props1);
            }

            FuncId::DeviceImageFormatProps => {
                let mut image_props2 = invalid_image_format_properties2();
                res = unsafe {
                    (commands.get_physical_device_image_format_properties)(
                        dev,
                        format,
                        image_type,
                        tiling,
                        usage,
                        create_flags,
                        &mut image_props2.image_format_properties,
                    )
                };
                let image_props1 = image_props2.image_format_properties;
                *verdict_slot = image_format_properties_equal(&empty_img_props, &image_props1)
                    || image_format_properties_equal(&invalid_img_props, &image_props1);
            }

            FuncId::DeviceImageFormatPropsSecond => {
                let mut image_props2 = invalid_image_format_properties2();
                image_format_info.format = format;
                res = unsafe {
                    (commands.get_physical_device_image_format_properties2)(dev, &image_format_info, &mut image_props2)
                };
                let image_props1 = image_props2.image_format_properties;
                *verdict_slot = image_format_properties_equal(&empty_img_props, &image_props1)
                    || image_format_properties_equal(&invalid_img_props, &image_props1);
            }

            FuncId::DeviceSparseImageFormatProps => {
                let mut props_count: u32 = 0;
                unsafe {
                    (commands.get_physical_device_sparse_image_format_properties)(
                        dev,
                        format,
                        image_type,
                        sampling,
                        usage,
                        tiling,
                        &mut props_count,
                        std::ptr::null_mut(),
                    )
                };
                *verdict_slot = props_count == 0;
            }

            FuncId::DeviceSparseImageFormatPropsSecond => {
                let mut props_count: u32 = 0;
                sparse_format_info.format = format;
                unsafe {
                    (commands.get_physical_device_sparse_image_format_properties2)(
                        dev,
                        &sparse_format_info,
                        &mut props_count,
                        std::ptr::null_mut(),
                    )
                };
                *verdict_slot = props_count == 0;
            }
        }
    }

    verdict(res, &verdicts)
}

/// `UnsupportedParametersMaintenance5FlagsInstance::iterate`
fn unsupported_flags(context: &Context<'_>, func_id: FuncId) -> TestOutcome {
    let dev = context.get_physical_device();
    let commands = context.get_instance().commands();
    let mut res = vk::Result::ERROR_FORMAT_NOT_SUPPORTED;
    let format = vk::Format::R8G8B8A8_UNORM;
    let image_type = vk::ImageType::_2D;
    let tiling = vk::ImageTiling::OPTIMAL;
    let create_flags = vk::ImageCreateFlags::empty();
    let sampling = vk::SampleCountFlags::_1;
    let invalid_img_props = invalid_image_format_properties2().image_format_properties;
    let empty_img_props = vk::ImageFormatProperties::default();

    let mut image_format_info = vk::PhysicalDeviceImageFormatInfo2 {
        format,
        type_: image_type,
        tiling,
        usage: usage_from_bits(VK_IMAGE_USAGE_FLAG_BITS_MAX_ENUM),
        flags: create_flags,
        ..Default::default()
    };

    let mut sparse_format_info = vk::PhysicalDeviceSparseImageFormatInfo2 {
        format,
        type_: image_type,
        samples: sampling,
        usage: usage_from_bits(VK_IMAGE_USAGE_FLAG_BITS_MAX_ENUM),
        tiling,
        ..Default::default()
    };

    const N: usize = 5;
    let mut verdicts = [false; N];

    assert!(func_id.has_flags_param());

    for (i, verdict_slot) in verdicts.iter_mut().enumerate() {
        let usage = usage_from_bits(VK_IMAGE_USAGE_FLAG_BITS_MAX_ENUM - i as u32);

        match func_id {
            FuncId::DeviceImageFormatProps => {
                let mut image_props2 = invalid_image_format_properties2();
                res = unsafe {
                    (commands.get_physical_device_image_format_properties)(
                        dev,
                        format,
                        image_type,
                        tiling,
                        usage,
                        create_flags,
                        &mut image_props2.image_format_properties,
                    )
                };
                let image_props1 = image_props2.image_format_properties;
                *verdict_slot = image_format_properties_equal(&empty_img_props, &image_props1)
                    || image_format_properties_equal(&invalid_img_props, &image_props1);
            }

            FuncId::DeviceImageFormatPropsSecond => {
                let mut image_props2 = invalid_image_format_properties2();
                image_format_info.usage = usage;
                res = unsafe {
                    (commands.get_physical_device_image_format_properties2)(dev, &image_format_info, &mut image_props2)
                };
                let image_props1 = image_props2.image_format_properties;
                *verdict_slot = image_format_properties_equal(&empty_img_props, &image_props1)
                    || image_format_properties_equal(&invalid_img_props, &image_props1);
            }

            FuncId::DeviceSparseImageFormatProps => {
                let mut props_count: u32 = 0;
                unsafe {
                    (commands.get_physical_device_sparse_image_format_properties)(
                        dev,
                        format,
                        image_type,
                        sampling,
                        usage,
                        tiling,
                        &mut props_count,
                        std::ptr::null_mut(),
                    )
                };
                // Some of the Implementations ignore wrong flags, so at this point we consider the test passed.
                *verdict_slot = true;
            }

            FuncId::DeviceSparseImageFormatPropsSecond => {
                let mut props_count: u32 = 0;
                sparse_format_info.usage = usage;
                unsafe {
                    (commands.get_physical_device_sparse_image_format_properties2)(
                        dev,
                        &sparse_format_info,
                        &mut props_count,
                        std::ptr::null_mut(),
                    )
                };
                // Some of the Implementations ignore wrong formats, so at this point we consider the test passed.
                *verdict_slot = true;
            }

            FuncId::DeviceFormatProps | FuncId::DeviceFormatPropsSecond => unreachable!("no flags parameter"),
        }
    }

    verdict(res, &verdicts)
}

/// `UnsupportedParametersMaintenance5TestCase`
struct UnsupportedParametersMaintenance5Case {
    name: &'static str,
    func_id: FuncId,
    test_format_or_flags: bool,
}

impl TestCase for UnsupportedParametersMaintenance5Case {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_maintenance5")?;

        let mut maintenance5_features = vk::PhysicalDeviceMaintenance5Features::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut maintenance5_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if maintenance5_features.maintenance5 != vk::TRUE {
            return Err(TestError::NotSupported(
                "Maintenance5 feature is not supported by this implementation".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UnsupportedParametersMaintenance5Instance {
            context,
            func_id: self.func_id,
            test_format_or_flags: self.test_format_or_flags,
        })
    }
}

struct UnsupportedParametersMaintenance5Instance<'a> {
    context: &'a Context<'a>,
    func_id: FuncId,
    test_format_or_flags: bool,
}

impl TestInstance for UnsupportedParametersMaintenance5Instance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.test_format_or_flags {
            unsupported_format(self.context, self.func_id)
        } else {
            unsupported_flags(self.context, self.func_id)
        }
    }
}

/// `createMaintenance5Tests`
pub fn create_maintenance5_tests() -> TestCaseGroup {
    let funcs: [(&'static str, FuncId); 6] = [
        ("device_format_props", FuncId::DeviceFormatProps),
        ("device_format_props2", FuncId::DeviceFormatPropsSecond),
        ("image_format_props", FuncId::DeviceImageFormatProps),
        ("image_format_props2", FuncId::DeviceImageFormatPropsSecond),
        ("sparse_image_format_props", FuncId::DeviceSparseImageFormatProps),
        ("sparse_image_format_props2", FuncId::DeviceSparseImageFormatPropsSecond),
    ];
    // Checks vkGetPhysicalDevice*FormatProperties* API functions
    let mut g_root = TestCaseGroup::new("maintenance5");
    let mut g_format = TestCaseGroup::new("format");
    let mut g_flags = TestCaseGroup::new("flags");
    for (name, func_id) in funcs {
        if func_id.has_format_param() {
            add_case(
                &mut g_format,
                UnsupportedParametersMaintenance5Case {
                    name,
                    func_id,
                    test_format_or_flags: true,
                },
            );
        }
        if func_id.has_flags_param() {
            add_case(
                &mut g_flags,
                UnsupportedParametersMaintenance5Case {
                    name,
                    func_id,
                    test_format_or_flags: false,
                },
            );
        }
    }
    g_root.add_child(g_format);
    g_root.add_child(g_flags);
    g_root
}
