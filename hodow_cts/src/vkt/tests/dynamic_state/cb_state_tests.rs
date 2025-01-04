// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateCBTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `cb_state`: the blend constants are set dynamically. The `blend_constants_mesh` variant is not ported.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH;
use crate::tcu::TestOutcome;
use crate::vkt::tests::dynamic_state::base_class::{
    BaseConfig, DepthStencilDynamicState, DynamicStateBase, GREEN, HEIGHT, PositionColorVertex, StateTestCase, WIDTH,
    build_reference_frame, check_nothing,
};
use crate::vkt::{Context, TestCase, TestCaseGroup};

/// `BlendConstantsTestInstance`
fn blend_constants_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let data = vec![
        PositionColorVertex::new([-1.0, 1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, 1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([-1.0, -1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, -1.0, 1.0, 1.0], GREEN),
    ];

    // initPipeline: blending with the constant colour and alpha as the destination factors
    let mut config = BaseConfig::vertex_fetch(data);
    config.blend_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(true)
        .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
        .dst_color_blend_factor(vk::BlendFactor::CONSTANT_COLOR)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::SRC_ALPHA)
        .dst_alpha_blend_factor(vk::BlendFactor::CONSTANT_ALPHA)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build();
    let base = DynamicStateBase::new(context, config)?;

    base.begin_render_pass_with_clear_color([1.0, 1.0, 1.0, 1.0], false, false)?;

    base.bind_pipeline(0);

    // bind states here
    base.set_dynamic_viewport_state(WIDTH, HEIGHT);
    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());
    base.set_dynamic_blend_state([0.33, 0.1, 0.66, 0.5]);

    base.bind_vertex_buffer();
    base.draw(base.data.len() as u32, 0);

    base.end_and_submit()?;

    // validation
    let reference_frame = build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if (-1.0..=1.0).contains(&y_coord) && (-1.0..=1.0).contains(&x_coord) {
            Some([0.33, 1.0, 0.66, 1.0])
        } else {
            None
        }
    })?;
    base.verify_against(&reference_frame)
}

/// `DynamicStateCBTests`
pub fn create_cb_state_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("cb_state");

    // Check if blend constants are working properly
    group.add_child(Box::new(StateTestCase {
        name: "blend_constants",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: blend_constants_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "blend_constants_mesh",
            support: check_nothing,
            run: blend_constants_run,
        }) as Box<dyn TestCase>,
    );

    group
}
