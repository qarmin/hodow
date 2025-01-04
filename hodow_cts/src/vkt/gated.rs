// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   the mustpass case lists of the pinned revision (`external/vulkancts/mustpass/main/vk-default/*.txt`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written for hodow_cts. A case tree registered from the mustpass names, every case gated on the extensions the upstream test needs: NotSupported
// without them, NotPorted with them. It lives in the base crate because groups of every Vulkan crate use it.

use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// A case whose body is not ported and which needs vendor extensions: NotSupported without them, NotPorted with them
struct GatedCase {
    name: String,
    extensions: &'static [&'static str],
    what: &'static str,
}

impl TestCase for GatedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        for extension in self.extensions {
            context.require_device_functionality(extension)?;
        }
        Err(TestError::NotPorted(self.what.to_string()))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NotPortedInstance(self.what))
    }

    fn is_stub(&self) -> bool {
        true
    }
}

struct NotPortedInstance(&'static str);

impl TestInstance for NotPortedInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(self.0.to_string()))
    }
}

struct Node {
    name: String,
    children: Vec<Node>,
}

fn insert(children: &mut Vec<Node>, path: &[&str]) {
    let Some((head, rest)) = path.split_first() else {
        return;
    };
    if rest.is_empty() {
        children.push(Node {
            name: (*head).to_string(),
            children: Vec::new(),
        });
        return;
    }
    let index = match children
        .iter()
        .rposition(|node| node.name == *head && !node.children.is_empty())
    {
        Some(index) => index,
        None => {
            children.push(Node {
                name: (*head).to_string(),
                children: Vec::new(),
            });
            children.len() - 1
        }
    };
    insert(&mut children[index].children, rest);
}

fn build_group(
    node: Node,
    path: &str,
    extensions: &'static [&'static str],
    what: &'static str,
    real: &mut dyn FnMut(&str) -> Option<Box<dyn TestCase>>,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(node.name.clone());
    for child in node.children {
        let child_path = if path.is_empty() {
            child.name.clone()
        } else {
            format!("{path}.{}", child.name)
        };
        if child.children.is_empty() {
            let case = real(&child_path).unwrap_or_else(|| {
                Box::new(GatedCase {
                    name: child.name,
                    extensions,
                    what,
                }) as Box<dyn TestCase>
            });
            group.add_child(case);
        } else {
            group.add_child(build_group(child, &child_path, extensions, what, real));
        }
    }
    group
}

/// The groups of the dotted case paths in `names` (one per line), every case gated on `extensions`
pub fn build_gated_groups(names: &str, extensions: &'static [&'static str], what: &'static str) -> Vec<TestCaseGroup> {
    build_gated_groups_with(names, extensions, what, &mut |_| None)
}

/// As `build_gated_groups`, where `real` supplies the case of a full dotted path that is ported (it takes it out of its own table); the rest stay gated.
pub fn build_gated_groups_with(
    names: &str,
    extensions: &'static [&'static str],
    what: &'static str,
    real: &mut dyn FnMut(&str) -> Option<Box<dyn TestCase>>,
) -> Vec<TestCaseGroup> {
    let mut roots = Vec::new();
    for line in names.lines() {
        let path: Vec<&str> = line.split('.').collect();
        insert(&mut roots, &path);
    }
    roots
        .into_iter()
        .map(|root| {
            let path = root.name.clone();
            build_group(root, &path, extensions, what, real)
        })
        .collect()
}
