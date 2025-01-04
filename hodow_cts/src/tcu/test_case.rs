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

/// The metadata every node in the hierarchy has, whatever API it tests.
///
/// Upstream's `tcu::TestNode` knows nothing about Vulkan or GL - the Vulkan module
/// derives `vkt::TestCase` from it and the GLES modules derive their own. The same
/// split is what lets one hierarchy walker, one case-name filter and one report
/// format serve both here, so this trait holds exactly what the framework needs and
/// each API's own case trait supplies it.
pub trait TestNodeInfo {
    /// `TestNode::getName`
    fn name(&self) -> &str;

    /// Whether this case is registered but has no test logic behind it yet.
    fn is_stub(&self) -> bool;
}

/// A node in the test hierarchy. Full case names are the dot-joined path from the
/// root, which is how `dEQP-VK.compute.pipeline.basic.empty_shader` is formed -
/// the same construction upstream uses, so names are directly comparable.
///
/// `C` is the API's own case trait, unsized: `dyn vkt::TestCase` for Vulkan,
/// `dyn glu::TestCase` for GL/GLES.
pub enum TestNode<C: ?Sized> {
    Group(TestCaseGroup<C>),
    Case(Box<C>),
}

impl<C: ?Sized + TestNodeInfo> TestNode<C> {
    pub fn name(&self) -> &str {
        match self {
            Self::Group(g) => &g.name,
            Self::Case(c) => c.name(),
        }
    }
}

/// `tcu::TestCaseGroup`
pub struct TestCaseGroup<C: ?Sized> {
    name: String,
    children: Vec<TestNode<C>>,
}

impl<C: ?Sized> TestCaseGroup<C> {
    pub fn new(name: impl Into<String>) -> Self {
        Self {
            name: name.into(),
            children: Vec::new(),
        }
    }

    /// `TestCaseGroup::addChild`
    pub fn add_child(&mut self, node: impl Into<TestNode<C>>) -> &mut Self {
        self.children.push(node.into());
        self
    }

    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn children(&self) -> &[TestNode<C>] {
        &self.children
    }

    /// The first child group called `name`, for a case a later package adds to a group an earlier one made.
    pub fn group_mut(&mut self, name: &str) -> Option<&mut TestCaseGroup<C>> {
        self.children.iter_mut().find_map(|node| match node {
            TestNode::Group(group) if group.name == name => Some(group),
            _ => None,
        })
    }

    /// Replaces every case of the subtree with what `f` makes of it, keeping the groups and the order.
    pub fn map_cases(self, f: &mut dyn FnMut(Box<C>) -> Box<C>) -> Self {
        let children = self
            .children
            .into_iter()
            .map(|node| match node {
                TestNode::Group(group) => TestNode::Group(group.map_cases(&mut *f)),
                TestNode::Case(case) => TestNode::Case(f(case)),
            })
            .collect();
        Self {
            name: self.name,
            children,
        }
    }
}

impl<C: ?Sized> From<TestCaseGroup<C>> for TestNode<C> {
    fn from(g: TestCaseGroup<C>) -> Self {
        Self::Group(g)
    }
}

impl<C: ?Sized> From<Box<C>> for TestNode<C> {
    fn from(c: Box<C>) -> Self {
        Self::Case(c)
    }
}

/// A flattened `(full name, case)` pair, which is the form the runner and the
/// result file both work in.
pub struct FlatCase<C: ?Sized> {
    pub full_name: String,
    pub case: Box<C>,
}

/// Flattens the hierarchy into fully qualified case names, depth first, preserving
/// registration order - upstream executes cases in exactly this order and the
/// differential comparison is easier to read when both sides agree on it.
pub fn flatten<C: ?Sized + TestNodeInfo>(root: TestCaseGroup<C>) -> Vec<FlatCase<C>> {
    fn walk<C: ?Sized + TestNodeInfo>(prefix: &str, node: TestNode<C>, out: &mut Vec<FlatCase<C>>) {
        match node {
            TestNode::Group(g) => {
                let path = if prefix.is_empty() {
                    g.name.clone()
                } else {
                    format!("{prefix}.{}", g.name)
                };
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
