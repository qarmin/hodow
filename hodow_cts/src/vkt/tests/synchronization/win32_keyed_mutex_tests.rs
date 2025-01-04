// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationWin32KeyedMutexTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree is upstream's: every write and read operation pair over the resources of
// `s_resourcesWin32KeyedMutex`, once for the NT and once for the KMT handle type (images) or the KMT one (buffers). Everything that runs
// is behind `DE_OS == DE_OS_WIN32` upstream, and `checkSupport` already throws NotSupported for `VK_KHR_external_memory_win32` on any other
// platform, which is the verdict these cases have here. A device that does advertise the extensions gets NotPorted, since the two-instance
// test body is not ported.

use vulkanalia::prelude::v1_0::*;

use super::operation::{
    READ_OPS, ResourceDescription, ResourceType, WRITE_OPS, buffer_resource, get_resource_name, image_resource,
};
use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `s_resourcesWin32KeyedMutex`
static RESOURCES_WIN32_KEYED_MUTEX: &[ResourceDescription] = &[
    // 16 KiB (min max UBO range)
    buffer_resource(0x4000),
    // 256 KiB
    buffer_resource(0x40000),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R8_UNORM,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R16_UINT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R8G8B8A8_UNORM,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R16G16B16A16_UINT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
];

/// `Win32KeyedMutexTestCase`
struct Win32KeyedMutexTestCase {
    name: String,
}

impl TestCase for Win32KeyedMutexTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_external_memory_win32")?;
        context.require_device_functionality("VK_KHR_win32_keyed_mutex")?;
        Err(TestError::NotPorted(
            "the two instance test body of win32_keyed_mutex".to_string(),
        ))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NotPortedInstance)
    }
}

struct NotPortedInstance;

impl TestInstance for NotPortedInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(
            "the two instance test body of win32_keyed_mutex".to_string(),
        ))
    }
}

/// `createWin32KeyedMutexTest`
pub fn create_win32_keyed_mutex_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("win32_keyed_mutex");

    // (handle type of a buffer exists, handle type of an image exists, name suffix): DX11 has no buffers with an NT handle.
    let cases: [(bool, bool, &str); 2] = [(false, true, "_nt"), (true, true, "_kmt")];

    for &write_op in WRITE_OPS {
        for &read_op in READ_OPS {
            let mut op_group = TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
            let mut empty = true;

            for resource in RESOURCES_WIN32_KEYED_MUTEX {
                for &(buffer_handle, image_handle, suffix) in &cases {
                    if resource.kind == ResourceType::Buffer && !buffer_handle {
                        continue;
                    }
                    if resource.kind == ResourceType::Image && !image_handle {
                        continue;
                    }

                    if write_op.supports_resource(resource) && read_op.supports_resource(resource) {
                        op_group.add_child(Box::new(Win32KeyedMutexTestCase {
                            name: format!("{}{suffix}", get_resource_name(resource)),
                        }) as Box<dyn TestCase>);
                        empty = false;
                    }
                }
            }

            if !empty {
                group.add_child(op_group);
            }
        }
    }

    group
}
