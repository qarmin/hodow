// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the compute stage of the families listed in
// `scripts/gen_subgroups_compute_manifest.py` is ported so far, in the compute, graphics, framebuffer and mesh variants; the ray tracing stages are not.

pub mod compute_tests;
pub mod framebuffer_tests;
pub mod graphics_tests;
pub mod mesh_tests;
pub mod multiple_dispatches_tests;
pub mod quad_control_tests;
pub mod size_control_tests;
pub mod uniform_control_flow_cases;
pub mod uniform_control_flow_tests;
pub mod uniform_descriptor_indexing_tests;
pub mod utils;

use std::collections::HashMap;

use crate::vkt::{TestCase, TestCaseGroup};

enum Node {
    Group(String, Vec<Node>),
    Case(Box<dyn TestCase>),
}

fn insert(children: &mut Vec<Node>, path: &[&str], case: Box<dyn TestCase>) {
    let Some((first, rest)) = path.split_first() else {
        children.push(Node::Case(case));
        return;
    };

    let index = children
        .iter()
        .rposition(|node| matches!(node, Node::Group(name, _) if name == first))
        .unwrap_or_else(|| {
            children.push(Node::Group(first.to_string(), Vec::new()));
            children.len() - 1
        });

    if let Node::Group(_, grandchildren) = &mut children[index] {
        insert(grandchildren, rest, case);
    }
}

fn build_group(name: &str, nodes: Vec<Node>) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for node in nodes {
        match node {
            Node::Group(child_name, children) => {
                group.add_child(build_group(&child_name, children));
            }
            Node::Case(case) => {
                group.add_child(case);
            }
        }
    }
    group
}

/// `createSubgroupsTests` - the `subgroups` group, as far as it is ported.
pub fn create_tests() -> TestCaseGroup {
    let mut tree: Vec<Node> = Vec::new();
    // The size_control cases that run replace the gated names of their group, which `size_control_tests` builds
    let mut size_control: HashMap<String, Box<dyn TestCase>> = HashMap::new();

    let cases = compute_tests::create_compute_cases()
        .into_iter()
        .chain(graphics_tests::create_graphics_cases())
        .chain(framebuffer_tests::create_framebuffer_cases())
        .chain(mesh_tests::create_mesh_cases());
    for (groups, case) in cases {
        if groups.first() == Some(&"size_control") {
            size_control.insert(format!("{}.{}", groups.join("."), case.name()), case);
        } else {
            insert(&mut tree, &groups, case);
        }
    }

    let mut group = TestCaseGroup::new("subgroups");
    for node in tree {
        if let Node::Group(name, children) = node {
            group.add_child(build_group(&name, children));
        }
    }
    group.add_child(size_control_tests::create_size_control_tests(&mut size_control));
    group.add_child(uniform_control_flow_tests::create_uniform_control_flow_tests());
    group.add_child(quad_control_tests::create_quad_control_tests());
    group.add_child(uniform_descriptor_indexing_tests::create_uniform_descriptor_indexing_tests());
    group.add_child(multiple_dispatches_tests::create_multiple_dispatches_tests());
    group
}
