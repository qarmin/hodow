// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawSimpleTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `SimpleDrawInstanced` is the same instance with `instanced` set,
// and the recording of the three rendering modes is `DrawTestsBase::record_and_submit`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_simple::{SIMPLE_DRAW, SIMPLE_DRAW_INSTANCED};
use crate::tcu::{RGBA, TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::draw::base_class::{
    DrawTestsBase, GroupParams, ReferenceImageCoordinates, ReferenceImageInstancedCoordinates, VertexElementData,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct TestSpec {
    topology: vk::PrimitiveTopology,
    group_params: GroupParams,
    instanced: bool,
}

struct SimpleDrawCase {
    name: &'static str,
    spec: TestSpec,
}

impl TestCase for SimpleDrawCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.spec.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.spec.instanced {
            SIMPLE_DRAW_INSTANCED.programs
        } else {
            SIMPLE_DRAW.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SimpleDraw {
            context,
            spec: self.spec,
        })
    }
}

/// `SimpleDraw` / `SimpleDrawInstanced`
struct SimpleDraw<'a> {
    context: &'a Context<'a>,
    spec: TestSpec,
}

/// `SimpleDraw::SimpleDraw`'s vertex data.
fn build_vertex_data(topology: vk::PrimitiveTopology) -> Result<Vec<VertexElementData>, TestError> {
    let blue = RGBA::blue().to_vec().m_data;
    let mut data = vec![
        VertexElementData::new([1.0, -1.0, 1.0, 1.0], blue, -1i32 as u32),
        VertexElementData::new([-1.0, 1.0, 1.0, 1.0], blue, -1i32 as u32),
    ];

    let mut ref_vertex_index = 2u32;
    let mut push = |data: &mut Vec<VertexElementData>, x: f32, y: f32| {
        data.push(VertexElementData::new([x, y, 1.0, 1.0], blue, ref_vertex_index));
        ref_vertex_index += 1;
    };

    match topology {
        vk::PrimitiveTopology::TRIANGLE_LIST => {
            push(&mut data, -0.3, -0.3);
            push(&mut data, -0.3, 0.3);
            push(&mut data, 0.3, -0.3);
            push(&mut data, 0.3, -0.3);
            push(&mut data, 0.3, 0.3);
            push(&mut data, -0.3, 0.3);
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP => {
            push(&mut data, -0.3, -0.3);
            push(&mut data, -0.3, 0.3);
            push(&mut data, 0.3, -0.3);
            push(&mut data, 0.3, 0.3);
            push(&mut data, -0.3, 0.3);
        }
        _ => return Err(TestError::InternalError("Topology not implemented".to_string())),
    }

    data.push(VertexElementData::new([-1.0, 1.0, 1.0, 1.0], blue, -1i32 as u32));
    Ok(data)
}

impl SimpleDraw<'_> {
    /// `SimpleDraw::draw`
    fn draw(&self, cmd_buffer: vk::CommandBuffer, instance_count: u32, first_instance: u32) -> Result<(), TestError> {
        let device = self.context.get_device();
        match self.spec.topology {
            vk::PrimitiveTopology::TRIANGLE_LIST => unsafe {
                device.cmd_draw(cmd_buffer, 6, instance_count, 2, first_instance)
            },
            vk::PrimitiveTopology::TRIANGLE_STRIP => unsafe {
                device.cmd_draw(cmd_buffer, 4, instance_count, 2, first_instance)
            },
            _ => return Err(TestError::InternalError("Topology not implemented".to_string())),
        }
        Ok(())
    }
}

impl TestInstance for SimpleDraw<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let queue = context.get_universal_queue();

        let data = build_vertex_data(self.spec.topology)?;
        let base = DrawTestsBase::new_default(
            context,
            "vert",
            "frag",
            self.spec.group_params,
            self.spec.topology,
            data,
        )?;

        if self.spec.instanced {
            base.record_and_submit(queue, |cmd_buffer| self.draw(cmd_buffer, 4, 2))?;

            // Validation
            let coords = ReferenceImageInstancedCoordinates::default();
            let reference = base.make_rect_reference(
                [0.0, 0.0, 0.0, 1.0],
                [0.0, 0.0, 1.0, 1.0],
                coords.left,
                coords.right,
                coords.top,
                coords.bottom,
            )?;
            Ok(base.compare_with_target(queue, &reference)?)
        } else {
            base.record_and_submit(queue, |cmd_buffer| self.draw(cmd_buffer, 1, 0))?;

            // Validation
            let coords = ReferenceImageCoordinates::default();
            let reference = base.make_rect_reference(
                [0.0, 0.0, 0.0, 1.0],
                [0.0, 0.0, 1.0, 1.0],
                coords.left,
                coords.right,
                coords.top,
                coords.bottom,
            )?;
            Ok(base.compare_with_target(queue, &reference)?)
        }
    }
}

/// `SimpleDrawTests::init`
pub fn create_simple_draw_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("simple_draw");

    for (name, topology, instanced) in [
        ("simple_draw_triangle_list", vk::PrimitiveTopology::TRIANGLE_LIST, false),
        (
            "simple_draw_triangle_strip",
            vk::PrimitiveTopology::TRIANGLE_STRIP,
            false,
        ),
        (
            "simple_draw_instanced_triangle_list",
            vk::PrimitiveTopology::TRIANGLE_LIST,
            true,
        ),
        (
            "simple_draw_instanced_triangle_strip",
            vk::PrimitiveTopology::TRIANGLE_STRIP,
            true,
        ),
    ] {
        group.add_child(Box::new(SimpleDrawCase {
            name,
            spec: TestSpec {
                topology,
                group_params,
                instanced,
            },
        }) as Box<dyn TestCase>);
    }
    group
}
