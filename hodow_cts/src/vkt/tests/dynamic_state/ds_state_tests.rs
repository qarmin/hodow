// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateDSTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `ds_state`: the depth bounds and the stencil compare mask, write mask and reference are set dynamically. The `_mesh`
// variants draw from `VertexFetch.mesh` through the base class's mesh mode.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TextureFormat};
use crate::vk::cmd_util::begin_command_buffer;
use crate::vk::image_util::{make_buffer_image_copy, make_image_subresource_layers};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::draw::{initial_transition_depth_2d_image, transition_2d_image};
use crate::vkt::tests::dynamic_state::base_class::{
    BLUE, BaseConfig, DepthAttachment, DepthStencilDynamicState, DynamicStateBase, GREEN, HEIGHT, PositionColorVertex,
    StateTestCase, WIDTH, build_reference_frame, check_depth_bounds_support, check_nothing, depth_stencil_state,
    stencil_op_state,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The four vertices of a triangle strip over the rectangle, in the order every test here pushes them: upper left, upper
/// right, lower left, lower right.
fn quad(left: f32, right: f32, top: f32, bottom: f32, z: f32, color: [f32; 4]) -> [PositionColorVertex; 4] {
    [
        PositionColorVertex::new([left, top, z, 1.0], color),
        PositionColorVertex::new([right, top, z, 1.0], color),
        PositionColorVertex::new([left, bottom, z, 1.0], color),
        PositionColorVertex::new([right, bottom, z, 1.0], color),
    ]
}

/// `DepthBoundsParamTestInstance`
fn depth_bounds_param_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let mut data = Vec::new();
    data.extend(quad(-1.0, 0.0, 1.0, -1.0, 0.375, GREEN));
    data.extend(quad(0.0, 1.0, 1.0, -1.0, 0.625, GREEN));
    data.extend(quad(-1.0, 1.0, 1.0, -1.0, 1.0, BLUE));

    let mut config = BaseConfig::vertex_fetch(data);
    config.depth = DepthAttachment::DepthStencil { stencil_load: true };
    let replace = stencil_op_state(
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        vk::CompareOp::ALWAYS,
    );
    config.depth_stencil_states = vec![
        depth_stencil_state(true, true, vk::CompareOp::ALWAYS, false, false, replace, replace),
        // enable depth bounds test
        depth_stencil_state(false, false, vk::CompareOp::NEVER, true, false, replace, replace),
    ];
    let base = DynamicStateBase::new(context, config)?;
    let _device = context.get_device();

    base.begin_render_pass()?;

    // set states here
    base.set_dynamic_viewport_state(WIDTH, HEIGHT);
    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState {
        min_depth_bounds: 0.5,
        max_depth_bounds: 0.75,
        ..Default::default()
    });

    base.bind_vertex_buffer();

    base.bind_pipeline(0);
    base.draw(4, 0);
    base.draw(4, 4);

    base.bind_pipeline(1);
    base.draw(4, 8);

    base.end_and_submit()?;

    // validation
    let reference_frame = build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if (0.0..=1.0).contains(&x_coord) && (-1.0..=1.0).contains(&y_coord) {
            Some(BLUE)
        } else {
            Some(GREEN)
        }
    })?;
    base.verify_against(&reference_frame)
}

const DEPTH_BOUNDS: [f32; 2] = [0.3, 0.9];

/// `DepthBoundsTestInstance`
fn depth_bounds_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();
    let data = vec![
        PositionColorVertex::new([-1.0, 1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, 1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([-1.0, -1.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, -1.0, 1.0, 1.0], GREEN),
    ];
    let mut config = BaseConfig::vertex_fetch(data);
    config.depth = DepthAttachment::ReadOnlyD16;
    // initPipeline: the stencil ops keep, the depth test is off and only the depth bounds test is on
    let stencil_op = stencil_op_state(
        vk::StencilOp::KEEP,
        vk::StencilOp::KEEP,
        vk::StencilOp::KEEP,
        vk::CompareOp::ALWAYS,
    );
    config.depth_stencil_states = vec![depth_stencil_state(
        false,
        false,
        vk::CompareOp::NEVER,
        true,
        false,
        stencil_op,
        stencil_op,
    )];
    let base = DynamicStateBase::new(context, config)?;
    let depth_image = base
        .depth_stencil_image
        .as_ref()
        .expect("a read-only D16 attachment was requested");

    // Prepare depth image
    let mut depth_data = TextureLevel::new(
        TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16),
        WIDTH,
        HEIGHT,
        1,
    )?;
    {
        let mut access = depth_data.get_access();
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                access.set_pix_depth(((y * WIDTH + x % 11) as f32) / 10.0, x, y, 0);
            }
        }
    }

    let data_size = (WIDTH * HEIGHT) as usize * 2;
    let stage_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(data_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            depth_data.data_mut().as_ptr(),
            stage_buffer.get_allocation().get_host_ptr(),
            data_size,
        )
    };
    flush_alloc(device, stage_buffer.get_allocation())?;

    let cmd = base.cmd();
    begin_command_buffer(device, cmd)?;

    initial_transition_depth_2d_image(
        device,
        cmd,
        depth_image.get(),
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::PipelineStageFlags::TRANSFER,
    );

    let buffer_image_copy = make_buffer_image_copy(
        vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
    );
    unsafe {
        device.cmd_copy_buffer_to_image(
            cmd,
            stage_buffer.get(),
            depth_image.get(),
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[buffer_image_copy],
        )
    };

    transition_2d_image(
        device,
        cmd,
        depth_image.get(),
        vk::ImageAspectFlags::DEPTH,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        1,
    );

    base.begin_render_pass_with_clear_color([1.0, 1.0, 1.0, 1.0], true, false)?;

    // Bind states
    base.set_dynamic_viewport_state(WIDTH, HEIGHT);
    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState {
        min_depth_bounds: DEPTH_BOUNDS[0],
        max_depth_bounds: DEPTH_BOUNDS[1],
        ..Default::default()
    });

    base.bind_pipeline(0);

    base.bind_vertex_buffer();
    base.draw(base.data.len() as u32, 0);

    base.end_and_submit()?;

    // Validation
    let depth_access = depth_data.get_const_access();
    let reference_frame = {
        let mut level = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            WIDTH,
            HEIGHT,
            1,
        )?;
        let mut access = level.get_access();
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                access.set_pixel([1.0, 1.0, 1.0, 1.0], x, y, 0);
            }
        }
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                let depth = depth_access.get_pix_depth(x, y, 0);
                if (DEPTH_BOUNDS[0]..=DEPTH_BOUNDS[1]).contains(&depth) {
                    access.set_pixel(GREEN, x, y, 0);
                }
            }
        }
        level
    };
    base.verify_against(&reference_frame)
}

/// `StencilParamsBasicTestInstance`'s pipelines: the first writes the stencil, the second tests it with `compare_op`.
fn stencil_pipelines_config(data: Vec<PositionColorVertex>, second_compare_op: vk::CompareOp) -> BaseConfig {
    let mut config = BaseConfig::vertex_fetch(data);
    config.depth = DepthAttachment::DepthStencil { stencil_load: true };

    let front_state_1 = stencil_op_state(
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        vk::CompareOp::ALWAYS,
    );
    let front_state_2 = stencil_op_state(
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        second_compare_op,
    );

    // enable stencil test
    config.depth_stencil_states = vec![
        depth_stencil_state(
            false,
            false,
            vk::CompareOp::NEVER,
            false,
            true,
            front_state_1,
            front_state_1,
        ),
        depth_stencil_state(
            false,
            false,
            vk::CompareOp::NEVER,
            false,
            true,
            front_state_2,
            front_state_2,
        ),
    ];
    config
}

/// The draws both stencil tests make: pipeline 1 over the first quad with the first state, pipeline 2 over the second quad.
fn stencil_draws(
    base: &DynamicStateBase<'_>,
    first: DepthStencilDynamicState,
    second: DepthStencilDynamicState,
) -> Result<(), TestError> {
    let _device = base.context.get_device();

    base.begin_render_pass()?;

    // set states here
    base.set_dynamic_viewport_state(WIDTH, HEIGHT);
    base.set_default_dynamic_rasterization_state();
    base.set_dynamic_blend_state([0.0; 4]);

    base.bind_vertex_buffer();

    base.bind_pipeline(0);
    base.set_dynamic_depth_stencil_state(first);
    base.draw(4, 0);

    base.bind_pipeline(1);
    base.set_dynamic_depth_stencil_state(second);
    base.draw(4, 4);
    Ok(())
}

/// `StencilParamsBasicTestCase`
struct StencilParamsBasicCase {
    name: &'static str,
    write_mask: u32,
    read_mask: u32,
    expected_value: u32,
    expected_color: [f32; 4],
    mesh: bool,
}

impl TestCase for StencilParamsBasicCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.mesh {
            context.require_device_functionality("VK_EXT_mesh_shader")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.mesh {
            crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs
        } else {
            VERTEX_FETCH.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StencilParamsBasicInstance { context, case: self })
    }
}

/// `StencilParamsBasicTestInstance`
struct StencilParamsBasicInstance<'a> {
    context: &'a Context<'a>,
    case: &'a StencilParamsBasicCase,
}

impl TestInstance for StencilParamsBasicInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        crate::vkt::tests::dynamic_state::base_class::with_mesh_mode(self.case.mesh, || self.run())
    }
}

impl StencilParamsBasicInstance<'_> {
    fn run(&self) -> TestOutcome {
        let case = self.case;
        let mut data = Vec::new();
        data.extend(quad(-1.0, 1.0, 1.0, -1.0, 1.0, GREEN));
        data.extend(quad(-1.0, 1.0, 1.0, -1.0, 1.0, BLUE));

        let base = DynamicStateBase::new(self.context, stencil_pipelines_config(data, vk::CompareOp::EQUAL))?;

        stencil_draws(
            &base,
            DepthStencilDynamicState {
                stencil_front_compare_mask: 0xFF,
                stencil_front_write_mask: case.write_mask,
                stencil_front_reference: 0x0F,
                stencil_back_compare_mask: 0xFF,
                stencil_back_write_mask: case.write_mask,
                stencil_back_reference: 0x0F,
                ..Default::default()
            },
            DepthStencilDynamicState {
                stencil_front_compare_mask: case.read_mask,
                stencil_front_write_mask: 0xFF,
                stencil_front_reference: case.expected_value,
                stencil_back_compare_mask: case.read_mask,
                stencil_back_write_mask: 0xFF,
                stencil_back_reference: case.expected_value,
                ..Default::default()
            },
        )?;

        base.end_and_submit()?;

        // validation
        let reference_frame = build_reference_frame(case.expected_color, |x_coord, y_coord| {
            if (-1.0..=1.0).contains(&x_coord) && (-1.0..=1.0).contains(&y_coord) {
                Some(case.expected_color)
            } else {
                None
            }
        })?;
        base.verify_against(&reference_frame)
    }
}

/// `StencilParamsAdvancedTestInstance`
fn stencil_params_advanced_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let mut data = Vec::new();
    data.extend(quad(-0.5, 0.5, 0.5, -0.5, 1.0, GREEN));
    data.extend(quad(-1.0, 1.0, 1.0, -1.0, 1.0, BLUE));

    let base = DynamicStateBase::new(context, stencil_pipelines_config(data, vk::CompareOp::NOT_EQUAL))?;

    stencil_draws(
        &base,
        DepthStencilDynamicState {
            stencil_front_compare_mask: 0xFF,
            stencil_front_write_mask: 0x0E,
            stencil_front_reference: 0x0F,
            stencil_back_compare_mask: 0xFF,
            stencil_back_write_mask: 0x0E,
            stencil_back_reference: 0x0F,
            ..Default::default()
        },
        DepthStencilDynamicState {
            stencil_front_compare_mask: 0xFF,
            stencil_front_write_mask: 0xFF,
            stencil_front_reference: 0x0E,
            stencil_back_compare_mask: 0xFF,
            stencil_back_write_mask: 0xFF,
            stencil_back_reference: 0x0E,
            ..Default::default()
        },
    )?;

    base.end_and_submit()?;

    // validation
    let reference_frame = build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if (-0.5..=0.5).contains(&x_coord) && (-0.5..=0.5).contains(&y_coord) {
            Some(GREEN)
        } else {
            Some(BLUE)
        }
    })?;
    base.verify_against(&reference_frame)
}

/// `DynamicStateDSTests`
pub fn create_ds_state_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ds_state");

    group.add_child(Box::new(StateTestCase {
        name: "depth_bounds_1",
        programs: VERTEX_FETCH.programs,
        support: check_depth_bounds_support,
        run: depth_bounds_param_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "depth_bounds_1_mesh",
            support: check_depth_bounds_support,
            run: depth_bounds_param_run,
        }) as Box<dyn TestCase>,
    );
    group.add_child(Box::new(StateTestCase {
        name: "depth_bounds_2",
        programs: VERTEX_FETCH.programs,
        support: check_depth_bounds_support,
        run: depth_bounds_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "depth_bounds_2_mesh",
            support: check_depth_bounds_support,
            run: depth_bounds_run,
        }) as Box<dyn TestCase>,
    );
    group.add_child(Box::new(StencilParamsBasicCase {
        name: "stencil_params_basic_1",
        write_mask: 0x0D,
        read_mask: 0x06,
        expected_value: 0x05,
        expected_color: BLUE,
        mesh: false,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(StencilParamsBasicCase {
        name: "stencil_params_basic_1_mesh",
        write_mask: 0x0D,
        read_mask: 0x06,
        expected_value: 0x05,
        expected_color: BLUE,
        mesh: true,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(StencilParamsBasicCase {
        name: "stencil_params_basic_2",
        write_mask: 0x06,
        read_mask: 0x02,
        expected_value: 0x05,
        expected_color: GREEN,
        mesh: false,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(StencilParamsBasicCase {
        name: "stencil_params_basic_2_mesh",
        write_mask: 0x06,
        read_mask: 0x02,
        expected_value: 0x05,
        expected_color: GREEN,
        mesh: true,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(StateTestCase {
        name: "stencil_params_advanced",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: stencil_params_advanced_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "stencil_params_advanced_mesh",
            support: check_nothing,
            run: stencil_params_advanced_run,
        }) as Box<dyn TestCase>,
    );

    group
}
