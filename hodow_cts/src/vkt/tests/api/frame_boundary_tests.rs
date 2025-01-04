// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFrameBoundaryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `wsi` group (one case per window system, presenting a swapchain image with a
// `VkFrameBoundaryEXT` chained to `VkPresentInfoKHR`) is ported for `headless` only
// (`wsi/swapchain_tests.rs`, which owns the swapchain device helper); the other platforms stay gated.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrSynchronization2ExtensionDeviceCommands};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::end_command_buffer;
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `ExtensionUse`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ExtensionUse {
    None,
    Sync2,
}

/// `TestType`
#[derive(Clone, Copy)]
enum TestType {
    SingleFrame,
    SingleFrameMultipleSubmissions,
    MultipleFrames,
    MultipleFramesMultipleSubmissions,
    MultipleOverlappingSubmissions,
}

const TEST_TYPES: [(TestType, &str); 5] = [
    (TestType::SingleFrame, "single_frame"),
    (
        TestType::SingleFrameMultipleSubmissions,
        "single_frame_multi_submissions",
    ),
    (TestType::MultipleFrames, "multi_frame"),
    (
        TestType::MultipleFramesMultipleSubmissions,
        "multi_frame_multi_submissions",
    ),
    (
        TestType::MultipleOverlappingSubmissions,
        "multi_frame_overlapping_submissions",
    ),
];

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    extension_use: ExtensionUse,
    test_type: TestType,
}

/// `checkSupport`
fn check_support(context: &Context<'_>, params: TestParams) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_frame_boundary")?;

    if params.extension_use == ExtensionUse::Sync2 {
        context.require_device_functionality("VK_KHR_synchronization2")?;
    }
    Ok(())
}

/// `recordCommands`
fn record_commands(context: &Context<'_>, cmd_buffer: vk::CommandBuffer, image: vk::Image) -> Result<(), TestError> {
    let device = context.get_device();

    // Not ONE_TIME_SUBMIT: the same buffer is submitted several times.
    let begin_info = vk::CommandBufferBeginInfo::builder();
    unsafe { device.begin_command_buffer(cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")?;

    let image_barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::empty())
        .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .old_layout(vk::ImageLayout::UNDEFINED)
        .new_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: vk::REMAINING_MIP_LEVELS,
            base_array_layer: 0,
            layer_count: vk::REMAINING_ARRAY_LAYERS,
        });

    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
    }

    let clear_color = vk::ClearColorValue {
        float32: [1.0, 1.0, 1.0, 1.0],
    };
    let range = vk::ImageSubresourceRange {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    };

    unsafe {
        device.cmd_clear_color_image(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_color,
            &[range],
        )
    };
    end_command_buffer(device, cmd_buffer)
}

/// `submitCommands`
fn submit_commands(
    extension_use: ExtensionUse,
    context: &Context<'_>,
    cmd_buffer: vk::CommandBuffer,
    last_in_frame: bool,
    frame_id: u64,
    images: &[vk::Image],
) -> Result<(), TestError> {
    let device = context.get_device();

    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let mut frame_boundary = vk::FrameBoundaryEXT::builder().frame_id(frame_id);
    if last_in_frame {
        frame_boundary = frame_boundary
            .flags(vk::FrameBoundaryFlagsEXT::FRAME_END)
            .images(images);
    }

    match extension_use {
        ExtensionUse::None => {
            let command_buffers = [cmd_buffer];
            let submit_info = [vk::SubmitInfo::builder()
                .command_buffers(&command_buffers)
                .push_next(&mut frame_boundary)];
            unsafe { device.queue_submit(context.get_universal_queue(), &submit_info, *fence) }
                .vk_check("vkQueueSubmit")?;
        }
        ExtensionUse::Sync2 => {
            let command_buffer_infos = [vk::CommandBufferSubmitInfo::builder()
                .command_buffer(cmd_buffer)
                .device_mask(0)
                .build()];
            let submit_info2 = [vk::SubmitInfo2::builder()
                .command_buffer_infos(&command_buffer_infos)
                .push_next(&mut frame_boundary)];
            if context
                .get_device_extensions()
                .iter()
                .any(|e| e == "VK_KHR_synchronization2")
            {
                unsafe { device.queue_submit2_khr(context.get_universal_queue(), &submit_info2, *fence) }
                    .vk_check("vkQueueSubmit2KHR")?;
            } else {
                unsafe { device.queue_submit2(context.get_universal_queue(), &submit_info2, *fence) }
                    .vk_check("vkQueueSubmit2")?;
            }
        }
    }

    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

/// `testCase`
fn test_case(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let device = context.get_device();

    let image_params = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(vk::Format::R8G8B8A8_UNORM)
        .extent(vk::Extent3D {
            width: 16,
            height: 16,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED);

    let image = Unique::new(
        device,
        unsafe { device.create_image(&image_params, None) }.vk_check("vkCreateImage")?,
    );
    let memory_requirements = unsafe { device.get_image_memory_requirements(*image) };
    let image_allocation =
        context
            .get_default_allocator()
            .allocate(device, memory_requirements, MemoryRequirement::ANY)?;
    unsafe { device.bind_image_memory(*image, image_allocation.get_memory(), 0) }.vk_check("vkBindImageMemory")?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let frame_images = [*image];

    record_commands(context, *cmd_buffer, *image)?;

    let submit = |last_in_frame: bool, frame_id: u64| {
        submit_commands(
            params.extension_use,
            context,
            *cmd_buffer,
            last_in_frame,
            frame_id,
            &frame_images,
        )
    };

    match params.test_type {
        TestType::SingleFrame => {
            submit(true, 1)?;
        }
        TestType::SingleFrameMultipleSubmissions => {
            for i in 0..4 {
                submit(i == 3, 1)?;
            }
        }
        TestType::MultipleFrames => {
            for i in 1..=4 {
                submit(true, i)?;
            }
        }
        TestType::MultipleFramesMultipleSubmissions => {
            for i in 1..=4 {
                submit(false, i)?;
                submit(true, i)?;
            }
        }
        TestType::MultipleOverlappingSubmissions => {
            submit(false, 1)?;
            submit(false, 2)?;
            submit(true, 1)?;
            submit(false, 3)?;
            submit(true, 2)?;
            submit(false, 4)?;
            submit(true, 3)?;
            submit(true, 4)?;
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct FrameBoundaryCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for FrameBoundaryCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support(context, self.params)
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FrameBoundaryInstance {
            context,
            params: self.params,
        })
    }
}

struct FrameBoundaryInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for FrameBoundaryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_case(self.context, self.params)
    }
}

/// `createExecTestCases`
fn create_exec_test_cases(name: &str, extension_use: ExtensionUse) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for (test_type, test_name) in TEST_TYPES {
        group.add_child(Box::new(FrameBoundaryCase {
            name: test_name,
            params: TestParams {
                extension_use,
                test_type,
            },
        }) as Box<dyn TestCase>);
    }
    group
}

/// `createFrameBoundaryTests`
pub fn create_frame_boundary_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("frame_boundary");
    group.add_child(create_exec_test_cases("core", ExtensionUse::None));
    group.add_child(create_exec_test_cases("sync2", ExtensionUse::Sync2));
    let mut headless = Some(crate::vkt::tests::wsi::frame_boundary_headless_case());
    for child in crate::vkt::gated::build_gated_groups_with(
        include_str!("frame_boundary_wsi_cases.txt"),
        &["VK_EXT_frame_boundary", "VK_KHR_swapchain"],
        "the window system",
        &mut |path| if path == "wsi.headless" { headless.take() } else { None },
    ) {
        group.add_child(child);
    }
    group
}
