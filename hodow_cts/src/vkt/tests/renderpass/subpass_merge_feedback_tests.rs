// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassSubpassMergeFeedbackTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Only a render pass is created, nothing is drawn: the test reads back what the driver
// reports about merging the subpasses through VK_EXT_subpass_merge_feedback.

use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    subpass_count: u32,
    disallow_merge_renderpass: bool,
    disallow_merge_sub_pass1: bool,
}

pub struct SubpassMergeFeedbackTest {
    name: &'static str,
    test_params: TestParams,
}

impl TestCase for SubpassMergeFeedbackTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_create_renderpass2")?;
        context.require_device_functionality("VK_EXT_subpass_merge_feedback")
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SubpassMergeFeedbackInstance {
            context,
            test_params: self.test_params,
        })
    }
}

struct SubpassMergeFeedbackInstance<'a> {
    context: &'a Context<'a>,
    test_params: TestParams,
}

impl TestInstance for SubpassMergeFeedbackInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.create_render_pass_and_verify()
    }
}

impl SubpassMergeFeedbackInstance<'_> {
    /// `createRenderPassAndVerify`
    fn create_render_pass_and_verify(&self) -> TestOutcome {
        let device = self.context.get_device();
        let count = self.test_params.subpass_count as usize;
        let aspect_mask = vk::ImageAspectFlags::COLOR;

        let mut attachment_descriptions: Vec<vk::AttachmentDescription2> = Vec::with_capacity(count);
        let mut result_attachments: Vec<vk::AttachmentReference2> = Vec::with_capacity(count);
        let mut input_attachments: Vec<vk::AttachmentReference2> = Vec::with_capacity(count);
        let mut subpass_merge_controls: Vec<vk::RenderPassCreationControlEXT> = Vec::with_capacity(count);
        let mut subpass_feedback_infos: Vec<vk::RenderPassSubpassFeedbackInfoEXT> = Vec::with_capacity(count);

        for i in 0..self.test_params.subpass_count {
            attachment_descriptions.push(vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: ptr::null(),
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: vk::Format::R8G8B8A8_UNORM,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            });

            result_attachments.push(vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: ptr::null(),
                attachment: i,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                aspect_mask,
            });

            input_attachments.push(vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: ptr::null(),
                attachment: i,
                layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                aspect_mask,
            });

            let disallow_subpass_merge = i == 1 && self.test_params.disallow_merge_sub_pass1;
            subpass_merge_controls.push(vk::RenderPassCreationControlEXT {
                s_type: vk::StructureType::RENDER_PASS_CREATION_CONTROL_EXT,
                next: ptr::null(),
                disallow_merging: disallow_subpass_merge as vk::Bool32,
            });

            // SAFETY: plain-old-data; the description is a zero filled character array.
            let mut feedback_info: vk::RenderPassSubpassFeedbackInfoEXT = unsafe { std::mem::zeroed() };
            feedback_info.subpass_merge_status = vk::SubpassMergeStatusEXT::MERGED;
            feedback_info.post_merge_index = 0;
            subpass_feedback_infos.push(feedback_info);
        }

        // The vectors above are fully built before any pointer into them is taken.
        let subpass_feedback_create_infos: Vec<vk::RenderPassSubpassFeedbackCreateInfoEXT> = (0..count)
            .map(|i| vk::RenderPassSubpassFeedbackCreateInfoEXT {
                s_type: vk::StructureType::RENDER_PASS_SUBPASS_FEEDBACK_CREATE_INFO_EXT,
                next: &subpass_merge_controls[i] as *const _ as *const std::ffi::c_void,
                subpass_feedback: &subpass_feedback_infos[i] as *const _ as *mut vk::RenderPassSubpassFeedbackInfoEXT,
            })
            .collect();

        let subpass_descriptions: Vec<vk::SubpassDescription2> = (0..count)
            .map(|i| vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: &subpass_feedback_create_infos[i] as *const _ as *const std::ffi::c_void,
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: u32::from(i > 0),
                input_attachments: if i > 0 { &input_attachments[i - 1] } else { ptr::null() },
                color_attachment_count: 1,
                color_attachments: &result_attachments[i],
                resolve_attachments: ptr::null(),
                depth_stencil_attachment: ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: ptr::null(),
            })
            .collect();

        let subpass_dependencies: Vec<vk::SubpassDependency2> = (1..self.test_params.subpass_count)
            .map(|i| vk::SubpassDependency2 {
                s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                next: ptr::null(),
                src_subpass: i - 1,
                dst_subpass: i,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
                view_offset: 0,
            })
            .collect();

        let renderpass_control = vk::RenderPassCreationControlEXT {
            s_type: vk::StructureType::RENDER_PASS_CREATION_CONTROL_EXT,
            next: ptr::null(),
            disallow_merging: self.test_params.disallow_merge_renderpass as vk::Bool32,
        };

        // SAFETY: plain-old-data with a single counter.
        let renderpass_feedback_info: vk::RenderPassCreationFeedbackInfoEXT = unsafe { std::mem::zeroed() };

        let renderpass_feedback_create_info = vk::RenderPassCreationFeedbackCreateInfoEXT {
            s_type: vk::StructureType::RENDER_PASS_CREATION_FEEDBACK_CREATE_INFO_EXT,
            next: &renderpass_control as *const _ as *const std::ffi::c_void,
            render_pass_feedback: &renderpass_feedback_info as *const _ as *mut vk::RenderPassCreationFeedbackInfoEXT,
        };

        let render_pass_info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: &renderpass_feedback_create_info as *const _ as *const std::ffi::c_void,
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachment_descriptions.len() as u32,
            attachments: attachment_descriptions.as_ptr(),
            subpass_count: subpass_descriptions.len() as u32,
            subpasses: subpass_descriptions.as_ptr(),
            dependency_count: subpass_dependencies.len() as u32,
            dependencies: if subpass_dependencies.is_empty() {
                ptr::null()
            } else {
                subpass_dependencies.as_ptr()
            },
            correlated_view_mask_count: 0,
            correlated_view_masks: ptr::null(),
        };

        let handle =
            unsafe { device.create_render_pass2_khr(&render_pass_info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        let _render_pass = Unique::new(device, handle);

        // The driver wrote through the const pointers above; read the same memory back volatilely
        // so the compiler cannot assume the zero/MERGED initial values are still there.
        let post_merge_subpass_count =
            unsafe { ptr::read_volatile(&renderpass_feedback_info.post_merge_subpass_count) };
        let status = |i: usize| unsafe { ptr::read_volatile(&subpass_feedback_infos[i].subpass_merge_status) };
        let post_merge_index = |i: usize| unsafe { ptr::read_volatile(&subpass_feedback_infos[i].post_merge_index) };

        let fail = || Ok(TestStatus::fail("Fail"));

        if self.test_params.disallow_merge_renderpass {
            if post_merge_subpass_count != self.test_params.subpass_count {
                return fail();
            }

            for i in 0..count {
                if status(i) != vk::SubpassMergeStatusEXT::DISALLOWED {
                    return fail();
                }

                if i > 0 && post_merge_index(i) == post_merge_index(i - 1) {
                    return fail();
                }
            }
        } else {
            if post_merge_subpass_count > self.test_params.subpass_count {
                return fail();
            }

            if self.test_params.subpass_count == 1 && status(0) != vk::SubpassMergeStatusEXT::NOT_MERGED_SINGLE_SUBPASS
            {
                return fail();
            }

            for i in 1..count {
                if i == 1
                    && self.test_params.disallow_merge_sub_pass1
                    && status(i) != vk::SubpassMergeStatusEXT::DISALLOWED
                {
                    return fail();
                }

                if status(i) == vk::SubpassMergeStatusEXT::MERGED && post_merge_index(i) != post_merge_index(i - 1) {
                    return fail();
                }

                if status(i) != vk::SubpassMergeStatusEXT::MERGED && post_merge_index(i) == post_merge_index(i - 1) {
                    return fail();
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createRenderPassSubpassMergeFeedbackTests`; upstream returns nothing for any rendering type but renderpass2.
pub fn create_subpass_merge_feedback_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("subpass_merge_feedback");
    for (name, subpass_count, disallow_merge_renderpass, disallow_merge_sub_pass1) in [
        ("single_subpass", 1, false, false),
        ("single_subpass_disallow_renderpass_merge", 1, true, false),
        ("three_subpasses", 3, false, false),
        ("three_subpasses_disallow_renderpass_merge", 3, true, false),
        ("three_subpasses_disallow_subpass_merge", 3, false, true),
        ("many_subpasses", 32, false, false),
    ] {
        let test_params = TestParams {
            subpass_count,
            disallow_merge_renderpass,
            disallow_merge_sub_pass1,
        };
        group.add_child(Box::new(SubpassMergeFeedbackTest { name, test_params }) as Box<dyn TestCase>);
    }
    group
}
