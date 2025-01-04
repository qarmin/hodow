// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolStatisticsTests.cpp (`QueryPoolStatisticsTests::init`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `init` is three thousand lines that make the same loops once per
// reset type: a group per statistic for a plain run, for `vertex_only`, for `host_query_reset`, `reset_before_copy` and
// `reset_after_copy`, each with `primary`, `secondary` and `secondary_inherited` below it. The loops here are written once per
// statistic and add each case to the groups of every reset type it belongs to. `ResetGroup::groups` is the list of those, and
// the case names come out as the 18741 of the mustpass list's `statistics_query` (checked with a script that runs the same
// loops, `multiple_queries` and `multiple_geom_stats` aside).

use vulkanalia::prelude::v1_0::*;

use super::common::{CommandBufferType, CopyType, ResetType, StrideType};
use super::compute::ComputeStatsCase;
use super::graphic::{ClearOp, GraphicCase, ParametersGraphic, Stage, TessPrimMode};
use crate::vkt::{TestCase, TestCaseGroup};

type Case = Box<dyn TestCase>;

/// `sixRepeats`
const SIX_REPEATS: [u64; 6] = [1, 3, 5, 8, 15, 24];

const TOPOLOGIES: [(vk::PrimitiveTopology, &str); 10] = [
    (vk::PrimitiveTopology::POINT_LIST, "point_list"),
    (vk::PrimitiveTopology::LINE_LIST, "line_list"),
    (vk::PrimitiveTopology::LINE_STRIP, "line_strip"),
    (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
    (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
    (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
    (
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        "line_list_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        "line_strip_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        "triangle_list_with_adjacency",
    ),
    (
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
        "triangle_strip_with_adjacency",
    ),
];
const PATCH_LIST: (vk::PrimitiveTopology, &str) = (vk::PrimitiveTopology::PATCH_LIST, "patch_list");

/// `restartTopologies` and `restartTopologyStr`
const RESTART_TOPOLOGIES: [(vk::PrimitiveTopology, &str); 5] = [
    (vk::PrimitiveTopology::LINE_STRIP, "line_strip_restart"),
    (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip_restart"),
    (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan_restart"),
    (
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        "line_strip_with_adjacency_restart",
    ),
    (
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
        "triangle_strip_with_adjacency_restart",
    ),
];

const CLEAR_OPS: [(ClearOp, &str); 3] = [
    (ClearOp::Noop, ""),
    (ClearOp::Color, "_clear_color"),
    (ClearOp::Depth, "_clear_depth"),
];

/// What the loops over `copyType` and the four `query64Bits`/`dstOffset` combinations produce for one case.
#[derive(Clone, Copy)]
struct Variant {
    copy_type: CopyType,
    query_64_bits: bool,
    dst_offset: bool,
    /// `i` of `for (uint32_t i = 0; i < 4; ++i)`, which the device address cases are picked by.
    index: u32,
}

impl Variant {
    /// `bitPrefix` and `copyTypeStr`
    fn prefix(&self) -> String {
        format!(
            "{}bits_{}{}",
            if self.query_64_bits { "64" } else { "32" },
            if self.dst_offset { "dstoffset_" } else { "" },
            if self.copy_type == CopyType::Cmd {
                "cmdcopyquerypoolresults_"
            } else {
                ""
            }
        )
    }
}

/// `for (copyTypeIdx...) for (i...)` with the `continue` for a destination offset on `vkGetQueryPoolResults`.
fn variants() -> Vec<Variant> {
    let mut result = Vec::new();
    for copy_type in [CopyType::Get, CopyType::Cmd] {
        for i in 0..4u32 {
            let (query_64_bits, dst_offset) = (i & 1 != 0, i & 2 != 0);
            // It makes no sense to use dstOffset with vkGetQueryPoolResults()
            if copy_type == CopyType::Get && dst_offset {
                continue;
            }
            result.push(Variant {
                copy_type,
                query_64_bits,
                dst_offset,
                index: i,
            });
        }
    }
    result
}

/// The groups upstream keeps per reset type.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ResetGroup {
    Normal,
    VertexOnly,
    Host,
    BeforeCopy,
    AfterCopy,
}

impl ResetGroup {
    fn path(self) -> &'static [&'static str] {
        match self {
            Self::Normal => &[],
            Self::VertexOnly => &["vertex_only"],
            Self::Host => &["host_query_reset"],
            Self::BeforeCopy => &["reset_before_copy"],
            Self::AfterCopy => &["reset_after_copy"],
        }
    }

    fn reset_type(self) -> ResetType {
        match self {
            Self::Normal | Self::VertexOnly => ResetType::Normal,
            Self::Host => ResetType::Host,
            Self::BeforeCopy => ResetType::BeforeCopy,
            Self::AfterCopy => ResetType::AfterCopy,
        }
    }

    /// The groups a case with this copy type is added to: a reset after the copy only makes sense for a copy command, and
    /// `vertex_only` only exists for the statistics that have a vertex stage to run on its own.
    fn groups(copy_type: CopyType, with_vertex_only: bool) -> Vec<ResetGroup> {
        let mut groups = vec![Self::Normal];
        if with_vertex_only {
            groups.push(Self::VertexOnly);
        }
        groups.push(Self::Host);
        groups.push(Self::BeforeCopy);
        if copy_type == CopyType::Cmd {
            groups.push(Self::AfterCopy);
        }
        groups
    }
}

enum Node {
    Group(String, Vec<Node>),
    Case(Case),
}

/// The case tree under construction: cases are added by path, and groups come into being in the order they are first used.
struct Tree {
    nodes: Vec<Node>,
}

impl Tree {
    fn insert(nodes: &mut Vec<Node>, path: &[&str], case: Case) {
        match path.split_first() {
            None => nodes.push(Node::Case(case)),
            Some((head, rest)) => {
                let index = match nodes
                    .iter()
                    .position(|n| matches!(n, Node::Group(name, _) if name == head))
                {
                    Some(index) => index,
                    None => {
                        nodes.push(Node::Group((*head).to_string(), Vec::new()));
                        nodes.len() - 1
                    }
                };
                if let Node::Group(_, children) = &mut nodes[index] {
                    Self::insert(children, rest, case);
                }
            }
        }
    }

    /// Makes sure a group exists, so an order upstream gives its groups can be fixed before any case is added.
    fn ensure(nodes: &mut Vec<Node>, path: &[&str]) {
        if let Some((head, rest)) = path.split_first() {
            let index = match nodes
                .iter()
                .position(|n| matches!(n, Node::Group(name, _) if name == head))
            {
                Some(index) => index,
                None => {
                    nodes.push(Node::Group((*head).to_string(), Vec::new()));
                    nodes.len() - 1
                }
            };
            if let Node::Group(_, children) = &mut nodes[index] {
                Self::ensure(children, rest);
            }
        }
    }

    /// Adds `case` to the group of `reset` named `family`, and to `sub` below it.
    fn add(&mut self, reset: ResetGroup, family: &str, sub: Option<&str>, case: impl TestCase + 'static) {
        let mut path: Vec<&str> = reset.path().to_vec();
        path.push(family);
        path.extend(sub);
        Self::insert(&mut self.nodes, &path, Box::new(case));
    }

    fn into_group(name: &str, nodes: Vec<Node>) -> TestCaseGroup {
        let mut group = TestCaseGroup::new(name);
        for node in nodes {
            match node {
                Node::Group(name, children) => {
                    group.add_child(Self::into_group(&name, children));
                }
                Node::Case(case) => {
                    group.add_child(case);
                }
            }
        }
        group
    }
}

fn graphic(name: String, stage: Stage, kind: CommandBufferType, params: ParametersGraphic) -> GraphicCase {
    GraphicCase::new(name, stage, kind, params, &SIX_REPEATS)
}

const KINDS: [(CommandBufferType, &str); 3] = [
    (CommandBufferType::Primary, "primary"),
    (CommandBufferType::Secondary, "secondary"),
    (CommandBufferType::SecondaryInherited, "secondary_inherited"),
];

/// The families `QueryPoolGraphicStatisticsTest` is built over a topology for and that have a `primary`, `secondary` and
/// `secondary_inherited` group each.
struct TopologyFamily {
    name: &'static str,
    stat: vk::QueryPipelineStatisticFlags,
    stage: Stage,
    /// `vertex_only` has this family too.
    with_vertex_only: bool,
    /// `primary` and `secondary` are repeated for `_clear_color` and `_clear_depth`; the fragment shader family clears by
    /// leaving the framebuffer region of each draw alone instead.
    clear_variants: bool,
    /// The clear operation every case of the family has but for the clear variants.
    base_clear: ClearOp,
    /// The cases that restart primitives, which only the primitive counting family has.
    restart: bool,
    device_address: DeviceAddressCase,
}

/// The one case per family that copies through `VK_KHR_device_address_commands`, in the `reset_after_copy` group.
#[derive(Clone, Copy)]
enum DeviceAddressCase {
    None,
    /// A primary case without colour attachments for a topology and the `i` of the variant loop.
    PrimaryNoColor(vk::PrimitiveTopology, u32),
    /// A secondary case for a topology and `i`.
    Secondary(vk::PrimitiveTopology, u32),
}

fn add_topology_family(tree: &mut Tree, family: &TopologyFamily) {
    for variant in variants() {
        for (topology, topology_name) in TOPOLOGIES {
            let prefix = variant.prefix();

            for group in ResetGroup::groups(variant.copy_type, family.with_vertex_only) {
                let params = |clear_op: ClearOp, no_color: bool| {
                    ParametersGraphic::new(
                        family.stat,
                        topology,
                        group.reset_type(),
                        variant.copy_type,
                        variant.query_64_bits,
                    )
                    .vertex_only(group == ResetGroup::VertexOnly)
                    .dst_offset(variant.dst_offset)
                    .clear(clear_op)
                    .no_color(no_color)
                };

                // Tests with no attachments for only primary command to reduce # of test cases.
                tree.add(
                    group,
                    family.name,
                    Some("primary"),
                    graphic(
                        format!("{prefix}{topology_name}_with_no_color_attachments"),
                        family.stage,
                        CommandBufferType::Primary,
                        params(family.base_clear, true),
                    ),
                );

                // Tests for clear operation within a statistics query activated. Nothing for secondary_inherited cases can be done
                // since it violates the specification.
                let base_only = [(family.base_clear, "")];
                let clears: &[(ClearOp, &str)] = if family.clear_variants { &CLEAR_OPS } else { &base_only };
                for (clear_op, clear_str) in clears {
                    tree.add(
                        group,
                        family.name,
                        Some("primary"),
                        graphic(
                            format!("{prefix}{topology_name}{clear_str}"),
                            family.stage,
                            CommandBufferType::Primary,
                            params(*clear_op, false),
                        ),
                    );
                    tree.add(
                        group,
                        family.name,
                        Some("secondary"),
                        graphic(
                            format!("{prefix}{topology_name}{clear_str}"),
                            family.stage,
                            CommandBufferType::Secondary,
                            params(*clear_op, false),
                        ),
                    );
                }

                tree.add(
                    group,
                    family.name,
                    Some("secondary_inherited"),
                    graphic(
                        format!("{prefix}{topology_name}"),
                        family.stage,
                        CommandBufferType::SecondaryInherited,
                        params(family.base_clear, false),
                    ),
                );

                // limit number of tests repeated for device_address_commands
                if group == ResetGroup::AfterCopy {
                    match family.device_address {
                        DeviceAddressCase::PrimaryNoColor(address_topology, index)
                            if address_topology == topology && index == variant.index =>
                        {
                            tree.add(
                                group,
                                family.name,
                                Some("primary"),
                                graphic(
                                    format!("{prefix}{topology_name}_with_no_color_attachments_device_address"),
                                    family.stage,
                                    CommandBufferType::Primary,
                                    params(family.base_clear, true).device_address(true),
                                ),
                            )
                        }
                        DeviceAddressCase::Secondary(address_topology, index)
                            if address_topology == topology && index == variant.index =>
                        {
                            tree.add(
                                group,
                                family.name,
                                Some("secondary"),
                                graphic(
                                    format!("{prefix}{topology_name}_device_address"),
                                    family.stage,
                                    CommandBufferType::Secondary,
                                    params(family.base_clear, false).device_address(true),
                                ),
                            )
                        }
                        _ => {}
                    }
                }

                // VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_PRIMITIVES_BIT + primitive restart
                if family.restart
                    && RESTART_TOPOLOGIES
                        .iter()
                        .any(|(restart_topology, _)| *restart_topology == topology)
                {
                    tree.add(
                        group,
                        family.name,
                        Some("primary"),
                        graphic(
                            format!("{prefix}{topology_name}_with_no_color_attachments_restart"),
                            family.stage,
                            CommandBufferType::Primary,
                            params(ClearOp::Noop, true).restart(true),
                        ),
                    );
                    tree.add(
                        group,
                        family.name,
                        Some("secondary_inherited"),
                        graphic(
                            format!("{prefix}{topology_name}_restart"),
                            family.stage,
                            CommandBufferType::SecondaryInherited,
                            params(ClearOp::Noop, false).restart(true),
                        ),
                    );
                }
            }
        }
    }
}

/// `VK_QUERY_PIPELINE_STATISTIC_COMPUTE_SHADER_INVOCATIONS_BIT`
fn add_compute(tree: &mut Tree) {
    const FAMILY: &str = "compute_shader_invocations";

    for variant in variants() {
        let prefix = variant.prefix();

        for use_compute_queue in [false, true] {
            let cq_suffix = if use_compute_queue { "_cq" } else { "" };

            for (stride_type, stride_str) in [(StrideType::Valid, ""), (StrideType::Zero, "stride_zero_")] {
                if stride_type == StrideType::Zero && variant.copy_type != CopyType::Cmd {
                    continue;
                }
                for (kind, kind_str) in KINDS {
                    tree.add(
                        ResetGroup::Normal,
                        FAMILY,
                        None,
                        ComputeStatsCase::new(
                            format!("{prefix}{stride_str}{kind_str}{cq_suffix}"),
                            kind,
                            ResetType::Normal,
                            variant.copy_type,
                            variant.query_64_bits,
                            use_compute_queue,
                            variant.dst_offset,
                            stride_type,
                            false,
                        ),
                    );
                }
            }

            for (group, reset_type) in [
                (ResetGroup::Host, ResetType::Host),
                (ResetGroup::BeforeCopy, ResetType::BeforeCopy),
            ] {
                for (kind, kind_str) in KINDS {
                    tree.add(
                        group,
                        FAMILY,
                        None,
                        ComputeStatsCase::new(
                            format!("{prefix}{kind_str}{cq_suffix}"),
                            kind,
                            reset_type,
                            variant.copy_type,
                            variant.query_64_bits,
                            use_compute_queue,
                            variant.dst_offset,
                            StrideType::Valid,
                            false,
                        ),
                    );
                }
            }

            if variant.copy_type == CopyType::Cmd {
                // limit number of tests repeated for device_address_commands
                if variant.index == 1 && !use_compute_queue {
                    tree.add(
                        ResetGroup::BeforeCopy,
                        FAMILY,
                        None,
                        ComputeStatsCase::new(
                            format!("{prefix}secondary{cq_suffix}_device_address"),
                            CommandBufferType::Secondary,
                            ResetType::BeforeCopy,
                            variant.copy_type,
                            variant.query_64_bits,
                            use_compute_queue,
                            variant.dst_offset,
                            StrideType::Valid,
                            true,
                        ),
                    );
                }

                for (kind, kind_str) in KINDS {
                    tree.add(
                        ResetGroup::AfterCopy,
                        FAMILY,
                        None,
                        ComputeStatsCase::new(
                            format!("{prefix}{kind_str}{cq_suffix}"),
                            kind,
                            ResetType::AfterCopy,
                            variant.copy_type,
                            variant.query_64_bits,
                            use_compute_queue,
                            variant.dst_offset,
                            StrideType::Valid,
                            false,
                        ),
                    );
                }
            }
        }
    }
}

/// `VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_VERTICES_BIT`: one flat group, the topology fixed to a triangle strip.
fn add_input_assembly_vertices(tree: &mut Tree) {
    const FAMILY: &str = "input_assembly_vertices";
    let stat = vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_VERTICES;

    for variant in variants() {
        let prefix = variant.prefix();

        for group in ResetGroup::groups(variant.copy_type, true) {
            let params = |clear_op: ClearOp, no_color: bool| {
                ParametersGraphic::new(
                    stat,
                    vk::PrimitiveTopology::TRIANGLE_STRIP,
                    group.reset_type(),
                    variant.copy_type,
                    variant.query_64_bits,
                )
                .vertex_only(group == ResetGroup::VertexOnly)
                .dst_offset(variant.dst_offset)
                .clear(clear_op)
                .no_color(no_color)
            };

            // Tests with no attachments for only primary command to reduce # of test cases.
            tree.add(
                group,
                FAMILY,
                None,
                graphic(
                    format!("{prefix}primary_with_no_color_attachments"),
                    Stage::Vertex,
                    CommandBufferType::Primary,
                    params(ClearOp::Noop, true),
                ),
            );

            // limit number of tests repeated for device_address_commands
            if group == ResetGroup::AfterCopy && variant.index == 0 {
                tree.add(
                    group,
                    FAMILY,
                    None,
                    graphic(
                        format!("{prefix}primary_with_no_color_attachments_device_address"),
                        Stage::Vertex,
                        CommandBufferType::Primary,
                        params(ClearOp::Noop, true).device_address(true),
                    ),
                );
            }

            // Tests for clear operation within a statistics query activated. The query shouldn't count internal driver operations
            // relevant to the clear operations.
            for (clear_op, clear_str) in CLEAR_OPS {
                tree.add(
                    group,
                    FAMILY,
                    None,
                    graphic(
                        format!("{prefix}primary{clear_str}"),
                        Stage::Vertex,
                        CommandBufferType::Primary,
                        params(clear_op, false),
                    ),
                );
                tree.add(
                    group,
                    FAMILY,
                    None,
                    graphic(
                        format!("{prefix}secondary{clear_str}"),
                        Stage::Vertex,
                        CommandBufferType::Secondary,
                        params(clear_op, false),
                    ),
                );
            }

            tree.add(
                group,
                FAMILY,
                None,
                graphic(
                    format!("{prefix}secondary_inherited"),
                    Stage::Vertex,
                    CommandBufferType::SecondaryInherited,
                    params(ClearOp::Noop, false),
                ),
            );
        }

        // VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_VERTICES_BIT + primitive restart
        for group in ResetGroup::groups(variant.copy_type, false) {
            for (topology, restart_str) in RESTART_TOPOLOGIES {
                for (kind, kind_str) in KINDS {
                    let params = ParametersGraphic::new(
                        stat,
                        topology,
                        group.reset_type(),
                        variant.copy_type,
                        variant.query_64_bits,
                    )
                    .dst_offset(variant.dst_offset)
                    .restart(true);
                    tree.add(
                        group,
                        FAMILY,
                        None,
                        graphic(format!("{prefix}{kind_str}_{restart_str}"), Stage::Vertex, kind, params),
                    );
                }
            }
        }
    }
}

/// The tessellation cases of `VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_PRIMITIVES_BIT`: patch lists of several sizes and
/// primitive counts, of which only the largest is repeated for every reset type and clear operation.
fn add_input_assembly_primitives_tessellation(tree: &mut Tree) {
    const FAMILY: &str = "input_assembly_primitives";
    const MAX_TESSELLATION_PATCH_SIZE: u32 = 32;
    const TEST_NUM_PRIMITIVES: u32 = 3;
    let last_tess_patch_size = MAX_TESSELLATION_PATCH_SIZE - 4;
    let stat = vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_PRIMITIVES;

    for variant in variants() {
        let prefix = variant.prefix();

        for primitive_cnt in 1..=TEST_NUM_PRIMITIVES {
            let mut tess_patch_size = 1;
            let mut patch_size_cnt = 1;
            while tess_patch_size < MAX_TESSELLATION_PATCH_SIZE {
                let combo = format!("_v{tess_patch_size}_p{primitive_cnt}");
                let params = |group: ResetGroup, clear_op: ClearOp, no_color: bool| {
                    ParametersGraphic::new(
                        stat,
                        PATCH_LIST.0,
                        group.reset_type(),
                        variant.copy_type,
                        variant.query_64_bits,
                    )
                    .dst_offset(variant.dst_offset)
                    .clear(clear_op)
                    .no_color(no_color)
                    .tess(tess_patch_size, primitive_cnt)
                };

                // Tests with no attachments for only primary command to reduce # of test cases.
                tree.add(
                    ResetGroup::Normal,
                    FAMILY,
                    Some("primary"),
                    graphic(
                        format!("{prefix}{}{combo}_with_no_color_attachments", PATCH_LIST.1),
                        Stage::Tess,
                        CommandBufferType::Primary,
                        params(ResetGroup::Normal, ClearOp::Noop, true),
                    ),
                );

                // Following tests will only run for patch size 28 and primitive count 3
                if primitive_cnt == TEST_NUM_PRIMITIVES && tess_patch_size >= last_tess_patch_size {
                    for group in ResetGroup::groups(variant.copy_type, false).into_iter().skip(1) {
                        tree.add(
                            group,
                            FAMILY,
                            Some("primary"),
                            graphic(
                                format!("{prefix}{}{combo}_with_no_color_attachments", PATCH_LIST.1),
                                Stage::Tess,
                                CommandBufferType::Primary,
                                params(group, ClearOp::Noop, true),
                            ),
                        );
                    }

                    for group in ResetGroup::groups(variant.copy_type, false) {
                        for (clear_op, clear_str) in CLEAR_OPS {
                            tree.add(
                                group,
                                FAMILY,
                                Some("primary"),
                                graphic(
                                    format!("{prefix}{}{combo}{clear_str}", PATCH_LIST.1),
                                    Stage::Tess,
                                    CommandBufferType::Primary,
                                    params(group, clear_op, false),
                                ),
                            );
                            tree.add(
                                group,
                                FAMILY,
                                Some("secondary"),
                                graphic(
                                    format!("{prefix}{}{combo}{clear_str}", PATCH_LIST.1),
                                    Stage::Tess,
                                    CommandBufferType::Secondary,
                                    params(group, clear_op, false),
                                ),
                            );
                        }

                        tree.add(
                            group,
                            FAMILY,
                            Some("secondary_inherited"),
                            graphic(
                                format!("{prefix}{}{combo}", PATCH_LIST.1),
                                Stage::Tess,
                                CommandBufferType::SecondaryInherited,
                                params(group, ClearOp::Noop, false),
                            ),
                        );
                    }
                }

                tess_patch_size = patch_size_cnt * 4;
                patch_size_cnt += 1;
            }
        }
    }
}

/// `VK_QUERY_PIPELINE_STATISTIC_CLIPPING_INVOCATIONS_BIT` and `VK_QUERY_PIPELINE_STATISTIC_CLIPPING_PRIMITIVES_BIT`: every case
/// is added for a geometry and a vertex pipeline, or for a tessellation one when the topology is a patch list (`addChilds`).
fn add_clipping(tree: &mut Tree, family: &str, stat: vk::QueryPipelineStatisticFlags, cull_front_and_back: bool) {
    for variant in variants() {
        let prefix = variant.prefix();

        for (topology, topology_name) in TOPOLOGIES.into_iter().chain([PATCH_LIST]) {
            let is_patch = topology == vk::PrimitiveTopology::PATCH_LIST;

            // The pipelines `addChilds` adds a case for, with the suffix of its name.
            let pipelines = |kind: CommandBufferType| -> Vec<(&'static str, Stage)> {
                if !is_patch {
                    vec![("_geometry", Stage::Geometry), ("_vertex", Stage::Vertex)]
                } else if kind == CommandBufferType::Primary {
                    vec![
                        ("_tessellation", Stage::Tess),
                        ("_tessellation_geometry", Stage::TessGeom),
                    ]
                } else {
                    vec![
                        ("_tessellation", Stage::TessGeom),
                        ("_tessellation_geometry", Stage::TessGeom),
                    ]
                }
            };

            for group in ResetGroup::groups(variant.copy_type, false) {
                let base = |clear_op: ClearOp, no_color: bool| {
                    let params = ParametersGraphic::new(
                        stat,
                        topology,
                        group.reset_type(),
                        variant.copy_type,
                        variant.query_64_bits,
                    )
                    .dst_offset(variant.dst_offset)
                    .clear(clear_op)
                    .no_color(no_color);
                    if is_patch {
                        // `addChilds`: the tessellation parameters that are not given
                        params.tess(4, 1)
                    } else {
                        params
                    }
                };

                let add_children = |tree: &mut Tree,
                                    sub: &str,
                                    base_name: String,
                                    kind: CommandBufferType,
                                    params: ParametersGraphic,
                                    group: ResetGroup| {
                    for (suffix, stage) in pipelines(kind) {
                        tree.add(
                            group,
                            family,
                            Some(sub),
                            graphic(format!("{base_name}{suffix}"), stage, kind, params),
                        );
                    }
                };

                add_children(
                    tree,
                    "primary",
                    format!("{prefix}{topology_name}_with_no_color_attachments"),
                    CommandBufferType::Primary,
                    base(ClearOp::Noop, true),
                    group,
                );

                for (clear_op, clear_str) in CLEAR_OPS {
                    add_children(
                        tree,
                        "primary",
                        format!("{prefix}{topology_name}{clear_str}"),
                        CommandBufferType::Primary,
                        base(clear_op, false),
                        group,
                    );
                    add_children(
                        tree,
                        "secondary",
                        format!("{prefix}{topology_name}{clear_str}"),
                        CommandBufferType::Secondary,
                        base(clear_op, false),
                        group,
                    );

                    if cull_front_and_back && group == ResetGroup::Normal {
                        add_children(
                            tree,
                            "cull_front_and_back",
                            format!("{prefix}{topology_name}{clear_str}"),
                            CommandBufferType::Primary,
                            base(clear_op, false).cull_front_and_back(true),
                            group,
                        );
                    }
                }

                add_children(
                    tree,
                    "secondary_inherited",
                    format!("{prefix}{topology_name}"),
                    CommandBufferType::SecondaryInherited,
                    base(ClearOp::Noop, false),
                    group,
                );
            }
        }
    }
}

/// `VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_CONTROL_SHADER_PATCHES_BIT` and
/// `VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_EVALUATION_SHADER_INVOCATIONS_BIT`: flat groups, the secondary variants told apart
/// by their names.
fn add_tessellation(tree: &mut Tree) {
    const PRIM_MODES: [(TessPrimMode, &str); 3] = [
        (TessPrimMode::Triangles, "_triangles"),
        (TessPrimMode::Isolines, "_isolines"),
        (TessPrimMode::Quads, "_quads"),
    ];
    const PATCH_SIZES: [u32; 3] = [3, 2, 4];
    let families = [
        (
            "tes_control_patches",
            vk::QueryPipelineStatisticFlags::TESSELLATION_CONTROL_SHADER_PATCHES,
        ),
        (
            "tes_evaluation_shader_invocations",
            vk::QueryPipelineStatisticFlags::TESSELLATION_EVALUATION_SHADER_INVOCATIONS,
        ),
    ];

    for variant in variants() {
        let prefix = variant.prefix();

        for (family, stat) in families {
            let params = |group: ResetGroup, clear_op: ClearOp, no_color: bool| {
                ParametersGraphic::new(
                    stat,
                    vk::PrimitiveTopology::TRIANGLE_STRIP,
                    group.reset_type(),
                    variant.copy_type,
                    variant.query_64_bits,
                )
                .dst_offset(variant.dst_offset)
                .clear(clear_op)
                .no_color(no_color)
                .tess(0, 1)
            };

            for (mode_ndx, (prim_mode, mode_str)) in PRIM_MODES.into_iter().enumerate() {
                for point_mode in [false, true] {
                    // Skip point mode for isolines to reduce test count
                    if prim_mode == TessPrimMode::Isolines && point_mode {
                        continue;
                    }

                    let tess_mode_str = format!("{mode_str}{}", if point_mode { "_point_mode" } else { "" });
                    let mode_params = ParametersGraphic::new(
                        stat,
                        PATCH_LIST.0,
                        ResetType::Normal,
                        variant.copy_type,
                        variant.query_64_bits,
                    )
                    .dst_offset(variant.dst_offset)
                    .tess(PATCH_SIZES[mode_ndx], 4)
                    .tess_mode(prim_mode, point_mode);
                    tree.add(
                        ResetGroup::Normal,
                        family,
                        None,
                        graphic(
                            format!("{prefix}{family}{tess_mode_str}"),
                            Stage::Tess,
                            CommandBufferType::Primary,
                            mode_params,
                        ),
                    );
                }
            }

            for group in ResetGroup::groups(variant.copy_type, false) {
                // Tests with no attachments for only primary command to reduce # of test cases.
                tree.add(
                    group,
                    family,
                    None,
                    graphic(
                        format!("{prefix}{family}_with_no_color_attachments"),
                        Stage::Tess,
                        CommandBufferType::Primary,
                        params(group, ClearOp::Noop, true),
                    ),
                );

                // limit number of tests repeated for device_address_commands
                if family == "tes_evaluation_shader_invocations" && group == ResetGroup::AfterCopy && variant.index == 0
                {
                    tree.add(
                        group,
                        family,
                        None,
                        graphic(
                            format!("{prefix}{family}_with_no_color_attachments_device_address"),
                            Stage::Tess,
                            CommandBufferType::Primary,
                            params(group, ClearOp::Noop, true).device_address(true),
                        ),
                    );
                }
            }

            for group in ResetGroup::groups(variant.copy_type, false) {
                for (clear_op, clear_str) in CLEAR_OPS {
                    tree.add(
                        group,
                        family,
                        None,
                        graphic(
                            format!("{prefix}{family}{clear_str}"),
                            Stage::Tess,
                            CommandBufferType::Primary,
                            params(group, clear_op, false),
                        ),
                    );
                    tree.add(
                        group,
                        family,
                        None,
                        graphic(
                            format!("{prefix}{family}_secondary{clear_str}"),
                            Stage::Tess,
                            CommandBufferType::Secondary,
                            params(group, clear_op, false),
                        ),
                    );
                }
                tree.add(
                    group,
                    family,
                    None,
                    graphic(
                        format!("{prefix}{family}_secondary_inherited"),
                        Stage::Tess,
                        CommandBufferType::SecondaryInherited,
                        params(group, ClearOp::Noop, false),
                    ),
                );
            }
        }
    }
}

/// `QueryPoolStatisticsTests::init`
pub(super) fn create_tests() -> TestCaseGroup {
    // The order upstream adds the groups to the `statistics_query` group in: one per statistic, then `vertex_only`,
    // `host_query_reset`, `reset_before_copy` and `reset_after_copy` with the same statistics below them.
    const FAMILIES: [&str; 11] = [
        "compute_shader_invocations",
        "input_assembly_vertices",
        "input_assembly_primitives",
        "vertex_shader_invocations",
        "fragment_shader_invocations",
        "geometry_shader_invocations",
        "geometry_shader_primitives",
        "clipping_invocations",
        "clipping_primitives",
        "tes_control_patches",
        "tes_evaluation_shader_invocations",
    ];
    const VERTEX_ONLY_FAMILIES: [&str; 3] = [
        "input_assembly_vertices",
        "input_assembly_primitives",
        "vertex_shader_invocations",
    ];

    let mut tree = Tree { nodes: Vec::new() };
    for family in FAMILIES {
        Tree::ensure(&mut tree.nodes, &[family]);
    }
    for family in VERTEX_ONLY_FAMILIES {
        Tree::ensure(&mut tree.nodes, &["vertex_only", family]);
    }
    for reset in [ResetGroup::Host, ResetGroup::BeforeCopy, ResetGroup::AfterCopy] {
        for family in FAMILIES {
            let mut path = reset.path().to_vec();
            path.push(family);
            Tree::ensure(&mut tree.nodes, &path);
        }
    }

    // `cull_front_and_back` is the last group of `clipping_primitives`, though its cases are added while its siblings are.
    for sub in ["primary", "secondary", "secondary_inherited"] {
        Tree::ensure(&mut tree.nodes, &["clipping_invocations", sub]);
        Tree::ensure(&mut tree.nodes, &["clipping_primitives", sub]);
    }
    Tree::ensure(&mut tree.nodes, &["clipping_primitives", "cull_front_and_back"]);

    add_compute(&mut tree);
    add_input_assembly_vertices(&mut tree);

    add_topology_family(
        &mut tree,
        &TopologyFamily {
            name: "input_assembly_primitives",
            stat: vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_PRIMITIVES,
            stage: Stage::Vertex,
            with_vertex_only: true,
            clear_variants: true,
            base_clear: ClearOp::Noop,
            restart: true,
            device_address: DeviceAddressCase::None,
        },
    );
    add_input_assembly_primitives_tessellation(&mut tree);

    add_topology_family(
        &mut tree,
        &TopologyFamily {
            name: "vertex_shader_invocations",
            stat: vk::QueryPipelineStatisticFlags::VERTEX_SHADER_INVOCATIONS,
            stage: Stage::Vertex,
            with_vertex_only: true,
            clear_variants: true,
            base_clear: ClearOp::Noop,
            restart: false,
            device_address: DeviceAddressCase::PrimaryNoColor(vk::PrimitiveTopology::LINE_STRIP, 1),
        },
    );
    add_topology_family(
        &mut tree,
        &TopologyFamily {
            name: "fragment_shader_invocations",
            stat: vk::QueryPipelineStatisticFlags::FRAGMENT_SHADER_INVOCATIONS,
            stage: Stage::Vertex,
            with_vertex_only: false,
            clear_variants: false,
            base_clear: ClearOp::Skip,
            restart: false,
            device_address: DeviceAddressCase::Secondary(vk::PrimitiveTopology::POINT_LIST, 0),
        },
    );
    for (name, stat) in [
        (
            "geometry_shader_invocations",
            vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_INVOCATIONS,
        ),
        (
            "geometry_shader_primitives",
            vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_PRIMITIVES,
        ),
    ] {
        add_topology_family(
            &mut tree,
            &TopologyFamily {
                name,
                stat,
                stage: Stage::Geometry,
                with_vertex_only: false,
                clear_variants: true,
                base_clear: ClearOp::Noop,
                restart: false,
                device_address: DeviceAddressCase::None,
            },
        );
    }

    add_clipping(
        &mut tree,
        "clipping_invocations",
        vk::QueryPipelineStatisticFlags::CLIPPING_INVOCATIONS,
        false,
    );
    add_clipping(
        &mut tree,
        "clipping_primitives",
        vk::QueryPipelineStatisticFlags::CLIPPING_PRIMITIVES,
        true,
    );
    add_tessellation(&mut tree);

    let mut group = Tree::into_group("statistics_query", tree.nodes);
    for child in super::multiple::create_groups() {
        group.add_child(child);
    }
    group
}
