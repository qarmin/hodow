// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuTestCase.hpp / .cpp  (tcu::TestNode, tcu::TestCaseGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::vkt::TestCase;

/// A node in the test hierarchy. Full case names are the dot-joined path from the
/// root, which is how `dEQP-VK.compute.pipeline.basic.empty_shader` is formed -
/// the same construction upstream uses, so names are directly comparable.
pub enum TestNode {
    Group(TestCaseGroup),
    Case(Box<dyn TestCase>),
}

impl TestNode {
    pub fn name(&self) -> &str {
        match self {
            Self::Group(g) => &g.name,
            Self::Case(c) => c.name(),
        }
    }
}

/// `tcu::TestCaseGroup`
pub struct TestCaseGroup {
    name: String,
    children: Vec<TestNode>,
}

impl TestCaseGroup {
    pub fn new(name: impl Into<String>) -> Self {
        Self {
            name: name.into(),
            children: Vec::new(),
        }
    }

    /// `TestCaseGroup::addChild`
    pub fn add_child(&mut self, node: impl Into<TestNode>) -> &mut Self {
        self.children.push(node.into());
        self
    }

    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn children(&self) -> &[TestNode] {
        &self.children
    }
}

impl From<TestCaseGroup> for TestNode {
    fn from(g: TestCaseGroup) -> Self {
        Self::Group(g)
    }
}

impl From<Box<dyn TestCase>> for TestNode {
    fn from(c: Box<dyn TestCase>) -> Self {
        Self::Case(c)
    }
}

/// A flattened `(full name, case)` pair, which is the form the runner and the
/// result file both work in.
pub struct FlatCase {
    pub full_name: String,
    pub case: Box<dyn TestCase>,
}

/// Flattens the hierarchy into fully qualified case names, depth first, preserving
/// registration order - upstream executes cases in exactly this order and the
/// differential comparison is easier to read when both sides agree on it.
pub fn flatten(root: TestCaseGroup) -> Vec<FlatCase> {
    fn walk(prefix: &str, node: TestNode, out: &mut Vec<FlatCase>) {
        match node {
            TestNode::Group(g) => {
                let path = if prefix.is_empty() { g.name.clone() } else { format!("{prefix}.{}", g.name) };
                for child in g.children {
                    walk(&path, child, out);
                }
            }
            TestNode::Case(c) => {
                let full_name = format!("{prefix}.{}", c.name());
                out.push(FlatCase { full_name, case: c });
            }
        }
    }

    let mut out = Vec::new();
    walk("", TestNode::Group(root), &mut out);
    out
}
