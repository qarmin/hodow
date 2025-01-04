// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineAttachmentFeedbackLoopLayoutTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The tests are not ported yet (they need the image sampling instance split out of
// `ImageSamplingInstance`): the case tree is registered with upstream's first support check (VK_EXT_attachment_feedback_loop_layout) and the
// bodies are not ported, so a device without the extension ends in NotSupported as under deqp-vk and one with it in NotPorted. The names are the
// mustpass list of the pinned revision (`attachment_feedback_loop_layout_cases/<construction>.txt`).

use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

/// `createAttachmentFeedbackLoopLayoutTests`, names only
pub fn create_attachment_feedback_loop_layout_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let names = match construction {
        PipelineConstructionType::Monolithic => include_str!("attachment_feedback_loop_layout_cases/monolithic.txt"),
        PipelineConstructionType::LinkTimeOptimizedLibrary => {
            include_str!("attachment_feedback_loop_layout_cases/pipeline_library.txt")
        }
        PipelineConstructionType::FastLinkedLibrary => {
            include_str!("attachment_feedback_loop_layout_cases/fast_linked_library.txt")
        }
        PipelineConstructionType::ShaderObjectUnlinkedSpirv => {
            include_str!("attachment_feedback_loop_layout_cases/shader_object_unlinked_spirv.txt")
        }
        PipelineConstructionType::ShaderObjectUnlinkedBinary => {
            include_str!("attachment_feedback_loop_layout_cases/shader_object_unlinked_binary.txt")
        }
        PipelineConstructionType::ShaderObjectLinkedSpirv => {
            include_str!("attachment_feedback_loop_layout_cases/shader_object_linked_spirv.txt")
        }
        PipelineConstructionType::ShaderObjectLinkedBinary => {
            include_str!("attachment_feedback_loop_layout_cases/shader_object_linked_binary.txt")
        }
    };
    let mut group = TestCaseGroup::new("attachment_feedback_loop_layout");
    for child in build_gated_groups(
        names,
        &["VK_EXT_attachment_feedback_loop_layout"],
        "the attachment feedback loop layout tests",
    ) {
        group.add_child(child);
    }
    group
}
