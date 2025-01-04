// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/geometry/vktGeometryInputGeometryShaderTests.cpp (`createInputGeometryShaderTests`)
//   external/vulkancts/modules/vulkan/geometry/vktGeometryVaryingGeometryShaderTests.cpp (`createVaryingGeometryShaderTests`)
//   external/vulkancts/modules/vulkan/geometry/vktGeometryEmitGeometryShaderTests.cpp (`createEmitGeometryShaderTests`)
//   external/vulkancts/modules/vulkan/geometry/vktGeometryBasicGeometryShaderTests.cpp (`createBasicGeometryShaderTests`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The group builders of the tests whose instances are in `expander.rs`. Each case is `ExpanderCase::new(<case name>,
// <generated program set name>, <kind>)`; the program sets are `<group>__<subgroup>__<case>` in `geometry_expander.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::vkt::tests::geometry::expander::{ExpanderCase, ExpanderKind, VaryingSource};
use crate::vkt::tests::geometry::side_effect_tests::{SideEffectCase, SideEffectTest};
use crate::vkt::{TestCase, TestCaseGroup};

fn boxed(case: impl TestCase + 'static) -> Box<dyn TestCase> {
    Box::new(case)
}

/// `createInputGeometryShaderTests`
pub fn create_input_geometry_shader_tests() -> TestCaseGroup {
    let mut input_primitive_group = TestCaseGroup::new("input");
    let mut basic_primitive_group = TestCaseGroup::new("basic_primitive");
    let mut tri_strip_adjacency_group = TestCaseGroup::new("triangle_strip_adjacency");
    let mut conversion_primitive_group = TestCaseGroup::new("conversion");

    let input_primitives = [
        (vk::PrimitiveTopology::POINT_LIST, "points"),
        (vk::PrimitiveTopology::LINE_LIST, "lines"),
        (vk::PrimitiveTopology::LINE_STRIP, "line_strip"),
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangles"),
        (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
        (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
        (vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY, "lines_adjacency"),
        (vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY, "line_strip_adjacency"),
        (
            vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
            "triangles_adjacency",
        ),
    ];

    // more basic types
    for (primitive_type, name) in input_primitives {
        let programs = format!("input__basic_primitive__{name}");
        basic_primitive_group.add_child(boxed(ExpanderCase::new(
            name,
            &programs,
            ExpanderKind::Input {
                primitive_type,
                num_draw_vertices: None,
            },
        )));
    }

    // triangle strip adjacency with different vertex counts
    for vertex_count in 0..=12 {
        let name = format!("vertex_count_{vertex_count}");
        let programs = format!("input__triangle_strip_adjacency__{name}");
        tri_strip_adjacency_group.add_child(boxed(ExpanderCase::new(
            &name,
            &programs,
            ExpanderKind::Input {
                primitive_type: vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
                num_draw_vertices: Some(vertex_count),
            },
        )));
    }

    // different type conversions
    let conversion_primitives = [
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangles_to_points"),
        (vk::PrimitiveTopology::LINE_LIST, "lines_to_points"),
        (vk::PrimitiveTopology::POINT_LIST, "points_to_lines"),
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangles_to_lines"),
        (vk::PrimitiveTopology::POINT_LIST, "points_to_triangles"),
        (vk::PrimitiveTopology::LINE_LIST, "lines_to_triangles"),
    ];
    for (primitive_type, name) in conversion_primitives {
        let programs = format!("input__conversion__{name}");
        conversion_primitive_group.add_child(boxed(ExpanderCase::new(
            name,
            &programs,
            ExpanderKind::Input {
                primitive_type,
                num_draw_vertices: None,
            },
        )));
    }

    input_primitive_group.add_child(basic_primitive_group);
    input_primitive_group.add_child(tri_strip_adjacency_group);
    input_primitive_group.add_child(conversion_primitive_group);
    input_primitive_group
}

/// `createVaryingGeometryShaderTests`
pub fn create_varying_geometry_shader_tests() -> TestCaseGroup {
    let mut varying_group = TestCaseGroup::new("varying");

    let varying_tests = [
        "vertex_no_op_geometry_out_1",
        "vertex_out_0_geometry_out_1",
        "vertex_out_0_geometry_out_2",
        "vertex_out_1_geometry_out_0",
        "vertex_out_1_geometry_out_2",
    ];
    for name in varying_tests {
        varying_group.add_child(boxed(ExpanderCase::new(
            name,
            &format!("varying__{name}"),
            ExpanderKind::Varying,
        )));
    }

    varying_group
}

/// `createEmitGeometryShaderTests`
pub fn create_emit_geometry_shader_tests() -> TestCaseGroup {
    let mut emit_group = TestCaseGroup::new("emit");

    // The names `EmitTestSpec` builds from `<primitive>_emit_<A>_end_<A>[_emit_<B>_end_<B>]`.
    let emit_tests = [
        "points_emit_0_end_0",
        "points_emit_0_end_1",
        "points_emit_1_end_1",
        "points_emit_0_end_2",
        "points_emit_1_end_2",
        "line_strip_emit_0_end_0",
        "line_strip_emit_0_end_1",
        "line_strip_emit_1_end_1",
        "line_strip_emit_2_end_1",
        "line_strip_emit_0_end_2",
        "line_strip_emit_1_end_2",
        "line_strip_emit_2_end_2",
        "line_strip_emit_2_end_2_emit_2_end_0",
        "triangle_strip_emit_0_end_0",
        "triangle_strip_emit_0_end_1",
        "triangle_strip_emit_1_end_1",
        "triangle_strip_emit_2_end_1",
        "triangle_strip_emit_3_end_1",
        "triangle_strip_emit_0_end_2",
        "triangle_strip_emit_1_end_2",
        "triangle_strip_emit_2_end_2",
        "triangle_strip_emit_3_end_2",
        "triangle_strip_emit_3_end_2_emit_3_end_0",
    ];
    for name in emit_tests {
        emit_group.add_child(boxed(ExpanderCase::new(
            name,
            &format!("emit__{name}"),
            ExpanderKind::Emit,
        )));
    }

    emit_group
}

/// `createBasicGeometryShaderTests`
pub fn create_basic_geometry_shader_tests() -> TestCaseGroup {
    let mut basic_group = TestCaseGroup::new("basic");

    // Output N vertices, and N, M vertices in two invocations (the instance only needs how many invocations there are)
    let output_tests = [
        ("output_10", 1),
        ("output_128", 1),
        ("output_10_and_100", 2),
        ("output_100_and_10", 2),
        ("output_0_and_128", 2),
        ("output_128_and_0", 2),
    ];
    for (name, primitive_count) in output_tests {
        basic_group.add_child(boxed(ExpanderCase::new(
            name,
            &format!("basic__{name}"),
            ExpanderKind::OutputCount { primitive_count },
        )));
    }

    // Output varying number of vertices
    let varying_tests = [
        ("output_vary_by_attribute", VaryingSource::ReadAttribute, false),
        ("output_vary_by_uniform", VaryingSource::ReadUniform, false),
        ("output_vary_by_texture", VaryingSource::ReadTexture, false),
        (
            "output_vary_by_attribute_instancing",
            VaryingSource::ReadAttribute,
            true,
        ),
        ("output_vary_by_uniform_instancing", VaryingSource::ReadUniform, true),
        ("output_vary_by_texture_instancing", VaryingSource::ReadTexture, true),
    ];
    for (name, test, instanced) in varying_tests {
        basic_group.add_child(boxed(ExpanderCase::new(
            name,
            &format!("basic__{name}"),
            ExpanderKind::VaryingOutputCount { test, instanced },
        )));
    }

    for side_effect_case in [SideEffectCase::Condition, SideEffectCase::Degenerate] {
        basic_group.add_child(boxed(SideEffectTest::new(side_effect_case)));
    }

    basic_group
}
