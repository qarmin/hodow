// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream builds the whole group once per pipeline construction type; `monolithic`, `pipeline_library` and `fast_linked_library`
// are ported (the library ones without the compute and transfer cases, as upstream); the four shader object variants are registered and report NotPorted, as a graphics
// pipeline cannot be built from shader objects here. The `_mesh` cases are all there.

pub mod base_class;
pub mod cb_state_tests;
pub mod clear_tests;
pub mod compute_transfer_tests;
pub mod construction;
pub mod discard_tests;
pub mod ds_state_tests;
pub mod general_state_tests;
pub mod inheritance_tests;
pub mod line_width_tests;
pub mod rs_state_tests;
pub mod vp_state_tests;

use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vkt::TestCaseGroup;

/// `createChildren`
fn create_children(construction: PipelineConstructionType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(construction.group_name());

    group.add_child(vp_state_tests::create_vp_state_tests());
    group.add_child(rs_state_tests::create_rs_state_tests());
    group.add_child(cb_state_tests::create_cb_state_tests());
    group.add_child(ds_state_tests::create_ds_state_tests());
    group.add_child(general_state_tests::create_general_state_tests(construction));
    group.add_child(inheritance_tests::create_inheritance_tests());
    group.add_child(clear_tests::create_clear_tests());
    group.add_child(discard_tests::create_discard_tests());
    group.add_child(line_width_tests::create_line_width_tests());
    if construction == PipelineConstructionType::Monolithic {
        group.add_child(compute_transfer_tests::create_dynamic_state_compute_tests());
        return group;
    }

    // Upstream's compute cases call createComputePipeline whatever the construction type, so they run as they are.
    if construction == PipelineConstructionType::ShaderObjectUnlinkedSpirv {
        group.add_child(compute_transfer_tests::create_dynamic_state_compute_tests());
    }

    construction::with_construction_type(group, construction)
}

/// `DynamicState::createTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("dynamic_state");
    group.add_child(create_children(PipelineConstructionType::Monolithic));
    group.add_child(create_children(PipelineConstructionType::LinkTimeOptimizedLibrary));
    group.add_child(create_children(PipelineConstructionType::FastLinkedLibrary));
    group.add_child(create_children(PipelineConstructionType::ShaderObjectUnlinkedSpirv));
    group.add_child(create_children(PipelineConstructionType::ShaderObjectUnlinkedBinary));
    group.add_child(create_children(PipelineConstructionType::ShaderObjectLinkedSpirv));
    group.add_child(create_children(PipelineConstructionType::ShaderObjectLinkedBinary));
    group
}
