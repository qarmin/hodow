// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test8)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The argument list tree of `getArgumentListsForVariableType` is a vector of (type, components used, parent) nodes walked breadth first.

use std::collections::VecDeque;

use super::shader_stages::ShaderStages;
use super::types::{ALL_TYPES, DoubleType, MATRIX_TYPES, SCALAR_TYPES};
use crate::glu::{Context, TestCase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

type ArgumentList = Vec<DoubleType>;

struct TreeNode {
    parent: Option<usize>,
    n_components_used: i32,
    type_: DoubleType,
    children: Vec<usize>,
}

/// `getArgumentListsForVariableType`: every list of constructor arguments that can initialize a variable of `variable_type`.
fn argument_lists_for_variable_type(variable_type: DoubleType) -> Vec<ArgumentList> {
    let n_total_components = variable_type.components() as i32;

    // Each node carries a counter that tells how many components have already been assigned. Nodes that eat up all components are leaves.
    let mut nodes = vec![TreeNode {
        parent: None,
        n_components_used: 0,
        type_: variable_type,
        children: Vec::new(),
    }];
    let mut queue: VecDeque<usize> = VecDeque::from([0]);
    while let Some(current) = queue.pop_front() {
        let n_components_remaining = n_total_components - nodes[current].n_components_used;
        let current_is_matrix = nodes[current].type_.is_matrix();

        // Matrix variable types can be defined by a combination of non-matrix variable types OR a single matrix variable type.
        if current_is_matrix {
            for matrix_type in MATRIX_TYPES {
                // GLSL says we must not use more than one constructor argument if the only argument is a matrix type, so the node counts as using all components.
                nodes.push(TreeNode {
                    parent: Some(current),
                    n_components_used: n_total_components,
                    type_: matrix_type,
                    children: Vec::new(),
                });
                let new_node = nodes.len() - 1;
                nodes[current].children.push(new_node);
            }
        }

        if !current_is_matrix {
            for scalar_type in SCALAR_TYPES {
                let n_new_argument_components = scalar_type.components() as i32;

                // Only use the scalar type if we don't exceed the amount of components we can define for requested type.
                if n_new_argument_components <= n_components_remaining {
                    let used = n_new_argument_components + nodes[current].n_components_used;
                    nodes.push(TreeNode {
                        parent: Some(current),
                        n_components_used: used,
                        type_: scalar_type,
                        children: Vec::new(),
                    });
                    let new_node = nodes.len() - 1;
                    nodes[current].children.push(new_node);
                    queue.push_back(new_node);
                }
            }
        }
    }

    // Leaf nodes in breadth first order, each leaf's path up to the root is an argument list.
    let mut leaf_nodes: Vec<usize> = Vec::new();
    let mut queue: VecDeque<usize> = VecDeque::from([0]);
    while let Some(current) = queue.pop_front() {
        if nodes[current].children.is_empty() {
            leaf_nodes.push(current);
        } else {
            queue.extend(nodes[current].children.iter().copied());
        }
    }

    leaf_nodes
        .into_iter()
        .map(|leaf| {
            let mut argument_list = ArgumentList::new();
            let mut current = Some(leaf);
            while let Some(index) = current {
                if nodes[index].parent.is_some() {
                    argument_list.insert(0, nodes[index].type_);
                }
                current = nodes[index].parent;
            }
            argument_list
        })
        .collect()
}

/// `getGeneralBody`
fn general_body(type_: DoubleType, argument_list: &ArgumentList) -> String {
    let mut result = format!("{} src = {}(", type_.name, type_.name);
    for (index, argument) in argument_list.iter().enumerate() {
        let n_components = argument.components();
        if index != 0 {
            result.push_str(", ");
        }
        result.push_str(&format!("{}(", argument.name));
        for n_component in 0..n_components {
            result.push_str(&format!("{}", f64::from(n_component + 1)));
            if n_component != n_components - 1 {
                result.push_str(", ");
            }
        }
        result.push(')');
    }
    result.push_str(");\n");
    result
}

/// The bodies in the order of `STAGE_NAMES`
fn shader_bodies(type_: DoubleType, argument_list: &ArgumentList) -> [String; 6] {
    let general = general_body(type_, argument_list);
    [
        format!(
            "#version 420\n#extension GL_ARB_compute_shader          : require\n\nlayout(local_size_x = 1) in;\n\nvoid main()\n{{\n{general}}}\n"
        ),
        format!("#version 420\n\nvoid main()\n{{\n{general}}}\n\n"),
        format!(
            "#version 420\n\nlayout(points)                 in;\nlayout(max_vertices=1, points) out;\n\nvoid main()\n{{\n{general}}}\n\n"
        ),
        format!("#version 420\n\nlayout(vertices=4) out;\n\nvoid main()\n{{\n{general}}}\n\n"),
        format!("#version 420\n\nlayout(isolines) in;\n\nvoid main()\n{{\n{general}}}\n\n"),
        format!("#version 420\n\nvoid main()\n{{\n{general}}}\n\n"),
    ]
}

/// `GPUShaderFP64Test8`
pub(super) struct ValidConstructors;

impl ValidConstructors {
    fn run(context: &Context, stages: &ShaderStages) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut has_test_passed = true;

        for variable_type in ALL_TYPES {
            // Construct a set of argument lists valid for the variable type considered
            for argument_list in argument_lists_for_variable_type(variable_type) {
                let bodies = shader_bodies(variable_type, &argument_list);

                stages.set_sources(gl, &bodies)?;
                // See if the shader compiles.
                has_test_passed &= stages.execute_iteration(gl, &bodies, true)?;
            }
        }
        Ok(has_test_passed)
    }
}

impl TestCase for ValidConstructors {
    fn name(&self) -> &str {
        "valid_constructors"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported.".to_string(),
            ));
        }

        let mut stages = ShaderStages::new(context)?;
        let result = Self::run(context, &stages);
        stages.delete(context.gl());

        Ok(if result? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
