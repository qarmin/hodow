// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateVPTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `vp_state`: the viewport, the scissor and an array of four of each are set dynamically. The `_mesh` variants are not ported.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::dynamic_state_vertex_fetch::{VERTEX_FETCH, VIEWPORT_ARRAY};
use crate::tcu::TestOutcome;
use crate::tcu::pixel::TextureLevel;
use crate::vkt::tests::dynamic_state::base_class::{
    BaseConfig, DepthStencilDynamicState, DynamicStateBase, GREEN, HEIGHT, PositionColorVertex, StateTestCase, WIDTH,
    build_reference_frame, check_geometry_and_multi_viewport_support, check_nothing,
};
use crate::vkt::{Context, TestCase, TestCaseGroup};

fn rect(x: i32, y: i32, width: u32, height: u32) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x, y },
        extent: vk::Extent2D { width, height },
    }
}

/// `ViewportStateBaseCase::initialize`: a green square at +-0.5.
fn viewport_state_base_config() -> BaseConfig {
    BaseConfig::vertex_fetch(vec![
        PositionColorVertex::new([-0.5, 0.5, 1.0, 1.0], GREEN),
        PositionColorVertex::new([0.5, 0.5, 1.0, 1.0], GREEN),
        PositionColorVertex::new([-0.5, -0.5, 1.0, 1.0], GREEN),
        PositionColorVertex::new([0.5, -0.5, 1.0, 1.0], GREEN),
    ])
}

/// `ViewportStateBaseCase::iterate`, with `setDynamicStates` and `buildReferenceFrame` given.
fn viewport_state_run<'a>(
    context: &'a Context<'a>,
    viewport: vk::Viewport,
    scissor: vk::Rect2D,
    build_reference: impl Fn() -> Result<TextureLevel, crate::tcu::TestError>,
) -> TestOutcome {
    let base = DynamicStateBase::new(context, viewport_state_base_config())?;

    base.begin_render_pass()?;

    // set states here
    base.set_dynamic_viewport_state_array(&[viewport], &[scissor]);
    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());

    base.bind_pipeline(0);

    base.bind_vertex_buffer();
    base.draw(base.data.len() as u32, 0);

    base.end_and_submit()?;

    // validation
    let reference_frame = build_reference()?;
    base.verify_against(&reference_frame)
}

/// `ViewportParamTestInstance`
fn viewport_param_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: WIDTH as f32 * 2.0,
        height: HEIGHT as f32 * 2.0,
        min_depth: 0.0,
        max_depth: 0.0,
    };
    let scissor = rect(0, 0, WIDTH, HEIGHT);

    viewport_state_run(context, viewport, scissor, || {
        build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
            if (0.0..=1.0).contains(&x_coord) && (0.0..=1.0).contains(&y_coord) {
                Some([0.0, 1.0, 0.0, 1.0])
            } else {
                None
            }
        })
    })
}

/// `ScissorParamTestInstance`
fn scissor_param_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: WIDTH as f32,
        height: HEIGHT as f32,
        min_depth: 0.0,
        max_depth: 0.0,
    };
    let scissor = rect(0, 0, WIDTH / 2, HEIGHT / 2);

    viewport_state_run(context, viewport, scissor, || {
        build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
            if (-0.5..=0.0).contains(&x_coord) && (-0.5..=0.0).contains(&y_coord) {
                Some([0.0, 1.0, 0.0, 1.0])
            } else {
                None
            }
        })
    })
}

const NUM_VIEWPORTS: usize = 4;

/// `checkMeshAndMultiViewportSupport` without the mesh shader half, which the case checks itself.
fn check_multi_viewport_support(context: &Context<'_>) -> Result<(), crate::tcu::TestError> {
    if context.get_device_features().multi_viewport == vk::FALSE {
        return Err(crate::tcu::TestError::NotSupported(
            "multiViewport not supported".to_string(),
        ));
    }
    Ok(())
}

/// `ViewportArrayTestInstance`
fn viewport_array_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let mut data = Vec::new();
    for i in 0..NUM_VIEWPORTS {
        let z = i as f32 / 3.0;
        data.push(PositionColorVertex::new([-1.0, 1.0, z, 1.0], GREEN));
        data.push(PositionColorVertex::new([1.0, 1.0, z, 1.0], GREEN));
        data.push(PositionColorVertex::new([-1.0, -1.0, z, 1.0], GREEN));
        data.push(PositionColorVertex::new([1.0, -1.0, z, 1.0], GREEN));
    }

    let mut config = BaseConfig::vertex_fetch(data);
    config.geometry_shader = Some("geom");
    config.viewport_count = NUM_VIEWPORTS as u32;
    let base = DynamicStateBase::new(context, config)?;

    base.begin_render_pass()?;

    // set states here
    let half_width = WIDTH as f32 / 2.0;
    let half_height = HEIGHT as f32 / 2.0;
    let quarter_width = (WIDTH / 4) as i32;
    let quarter_height = (HEIGHT / 4) as i32;

    let viewports = [
        vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: half_width,
            height: half_height,
            min_depth: 0.0,
            max_depth: 0.0,
        },
        vk::Viewport {
            x: half_width,
            y: 0.0,
            width: half_width,
            height: half_height,
            min_depth: 0.0,
            max_depth: 0.0,
        },
        vk::Viewport {
            x: half_width,
            y: half_height,
            width: half_width,
            height: half_height,
            min_depth: 0.0,
            max_depth: 0.0,
        },
        vk::Viewport {
            x: 0.0,
            y: half_height,
            width: half_width,
            height: half_height,
            min_depth: 0.0,
            max_depth: 0.0,
        },
    ];

    let scissors = [
        rect(
            quarter_width,
            quarter_height,
            quarter_width as u32,
            quarter_height as u32,
        ),
        rect(
            half_width as i32,
            quarter_height,
            quarter_width as u32,
            quarter_height as u32,
        ),
        rect(
            half_width as i32,
            half_height as i32,
            quarter_width as u32,
            quarter_height as u32,
        ),
        rect(
            quarter_width,
            half_height as i32,
            quarter_width as u32,
            quarter_height as u32,
        ),
    ];

    base.set_dynamic_viewport_state_array(&viewports, &scissors);
    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());

    base.bind_pipeline(0);

    debug_assert!(base.data.len() % NUM_VIEWPORTS == 0);
    let verts_per_viewport = (base.data.len() / NUM_VIEWPORTS) as u32;

    base.bind_vertex_buffer();
    for i in 0..NUM_VIEWPORTS as u32 {
        let first_vertex = i * verts_per_viewport;
        base.draw(verts_per_viewport, first_vertex);
    }

    base.end_and_submit()?;

    // validation
    let reference_frame = build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if (-0.5..=0.5).contains(&x_coord) && (-0.5..=0.5).contains(&y_coord) {
            Some([0.0, 1.0, 0.0, 1.0])
        } else {
            None
        }
    })?;
    base.verify_against(&reference_frame)
}

/// `DynamicStateVPTests`
pub fn create_vp_state_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vp_state");

    group.add_child(Box::new(StateTestCase {
        name: "viewport",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: viewport_param_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "viewport_mesh",
            support: check_nothing,
            run: viewport_param_run,
        }) as Box<dyn TestCase>,
    );
    group.add_child(Box::new(StateTestCase {
        name: "scissor",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: scissor_param_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "scissor_mesh",
            support: check_nothing,
            run: scissor_param_run,
        }) as Box<dyn TestCase>,
    );
    // Multiple viewports and scissors
    group.add_child(Box::new(StateTestCase {
        name: "viewport_array",
        programs: VIEWPORT_ARRAY.programs,
        support: check_geometry_and_multi_viewport_support,
        run: viewport_array_run,
    }) as Box<dyn TestCase>);

    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VIEWPORT_ARRAY_MESH.programs,
            name: "viewport_array_mesh",
            support: check_multi_viewport_support,
            run: viewport_array_run,
        }) as Box<dyn TestCase>,
    );

    group
}
