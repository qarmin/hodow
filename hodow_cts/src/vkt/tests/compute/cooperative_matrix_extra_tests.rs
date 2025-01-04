// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeCooperativeMatrixTests.cpp (64b_indexing, maintenance1)
//   external/vulkancts/modules/vulkan/compute/vktComputeCooperativeMatrixOpConstantNullTests.cpp (op_constant_null)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 NVIDIA Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the case trees and the support checks are ported (see cooperative_matrix_tests.rs); the bodies
// end in NotPorted and every case reports `is_stub`. `op_constant_null` upstream also checks its dynamic configuration list, which is not read here:
// with the static list (the default) the count is never zero.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::cooperative_matrix_tests::{cooperative_matrix2_features, maintenance1_feature};
use crate::tcu::{TestError, TestOutcome};
use crate::vk::compute_pipeline::ComputePipelineConstructionType;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
enum Kind {
    OpConstantNull,
    Indexing64b { tensor_layout: bool },
    Properties2,
}

struct ExtraCase {
    name: &'static str,
    kind: Kind,
}

const NOT_PORTED: &str = "the cooperative matrix test body";

impl TestCase for ExtraCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            Kind::OpConstantNull => {
                let mut features = vk::PhysicalDeviceCooperativeMatrixFeaturesKHR::default();
                if context.is_device_functionality_supported("VK_KHR_cooperative_matrix") {
                    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
                    unsafe {
                        context
                            .get_instance()
                            .get_physical_device_features2(context.get_physical_device(), &mut features2)
                    };
                }
                if features.cooperative_matrix == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "cooperativeMatrix is not supported".to_string(),
                    ));
                }
            }
            Kind::Indexing64b { tensor_layout } => {
                if !super::cooperative_matrix_tests::raw_feature(
                    context,
                    "VK_EXT_shader_64bit_indexing",
                    1000627000,
                    24,
                    0,
                ) {
                    return Err(TestError::NotSupported(
                        "shader64BitIndexing not supported by this implementation".to_string(),
                    ));
                }
                if tensor_layout {
                    context.require_device_functionality("VK_NV_cooperative_matrix2")?;
                    if cooperative_matrix2_features(context).cooperative_matrix_tensor_addressing == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "cooperativeMatrixTensorAddressing not supported".to_string(),
                        ));
                    }
                }
            }
            Kind::Properties2 => {
                context.require_device_functionality("VK_EXT_cooperative_matrix_maintenance1")?;
                if !maintenance1_feature(context, 0) {
                    return Err(TestError::NotSupported(
                        "cooperativeMatrixProperties2 not supported".to_string(),
                    ));
                }
            }
        }
        Err(TestError::NotPorted(NOT_PORTED.to_string()))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NotPortedInstance)
    }

    fn is_stub(&self) -> bool {
        true
    }
}

struct NotPortedInstance;

impl TestInstance for NotPortedInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(NOT_PORTED.to_string()))
    }
}

/// `op_constant_null`, `64b_indexing` and `maintenance1` of `createCooperativeMatrixTests`, in upstream's order
pub fn create_extra_groups(_construction_type: ComputePipelineConstructionType) -> Vec<TestCaseGroup> {
    let mut groups = Vec::new();

    let mut null_group = TestCaseGroup::new("op_constant_null");
    for name in ["null_a", "null_b", "null_c", "null_r"] {
        null_group.add_child(Box::new(ExtraCase {
            name,
            kind: Kind::OpConstantNull,
        }) as Box<dyn TestCase>);
    }
    groups.push(null_group);

    let mut group64 = TestCaseGroup::new("64b_indexing");
    for (name, tensor_layout) in [
        ("coopmat_64b_rowmajor", false),
        ("coopmat_64b_rowmajor_mediumoffset", false),
        ("coopmat_64b_rowmajor_largeoffset", false),
        ("coopmat_64b_tensorlayout", true),
        ("coopmat_64b_tensorlayout_mediumoffset", true),
        ("coopmat_64b_tensorlayout_largeoffset", true),
    ] {
        group64.add_child(Box::new(ExtraCase {
            name,
            kind: Kind::Indexing64b { tensor_layout },
        }) as Box<dyn TestCase>);
    }
    groups.push(group64);

    let mut maint1 = TestCaseGroup::new("maintenance1");
    maint1.add_child(Box::new(ExtraCase {
        name: "required_type_combinations",
        kind: Kind::Properties2,
    }) as Box<dyn TestCase>);
    groups.push(maint1);

    groups
}
