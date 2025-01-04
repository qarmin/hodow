// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationLimitsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `LimitsCaseDefinition`, the limit being a function of the device limits.
#[derive(Clone, Copy)]
struct LimitsCaseDefinition {
    limit: fn(&vk::PhysicalDeviceLimits) -> u32,
    /// Implementation must provide at least this value
    minimum: u32,
}

struct LimitsCase {
    name: &'static str,
    case_def: LimitsCaseDefinition,
}

impl TestCase for LimitsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LimitsInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct LimitsInstance<'a> {
    context: &'a Context<'a>,
    case_def: LimitsCaseDefinition,
}

impl TestInstance for LimitsInstance<'_> {
    /// `deviceLimitsTestCase`, with `expectGreaterOrEqual` inline.
    fn iterate(&mut self) -> TestOutcome {
        if self.context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }

        let actual = (self.case_def.limit)(&self.context.get_device_properties().limits);

        if actual >= self.case_def.minimum {
            Ok(TestStatus::pass("OK"))
        } else {
            Ok(TestStatus::fail(format!(
                "Value doesn't meet minimal spec requirements (expected: {}, got: {actual})",
                self.case_def.minimum
            )))
        }
    }
}

/// `createLimitsTests`: these tests correspond roughly to dEQP-GLES31.functional.tessellation.state_query.*
pub fn create_limits_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("limits");

    let cases: [(&'static str, LimitsCaseDefinition); 8] = [
        (
            "max_tessellation_generation_level",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_generation_level,
                minimum: 64,
            },
        ),
        (
            "max_tessellation_patch_size",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_patch_size,
                minimum: 32,
            },
        ),
        (
            "max_tessellation_control_per_vertex_input_components",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_control_per_vertex_input_components,
                minimum: 64,
            },
        ),
        (
            "max_tessellation_control_per_vertex_output_components",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_control_per_vertex_output_components,
                minimum: 64,
            },
        ),
        (
            "max_tessellation_control_per_patch_output_components",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_control_per_patch_output_components,
                minimum: 120,
            },
        ),
        (
            "max_tessellation_control_total_output_components",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_control_total_output_components,
                minimum: 2048,
            },
        ),
        (
            "max_tessellation_evaluation_input_components",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_evaluation_input_components,
                minimum: 64,
            },
        ),
        (
            "max_tessellation_evaluation_output_components",
            LimitsCaseDefinition {
                limit: |limits| limits.max_tessellation_evaluation_output_components,
                minimum: 64,
            },
        ),
    ];

    for (name, case_def) in cases {
        group.add_child(Box::new(LimitsCase { name, case_def }) as Box<dyn TestCase>);
    }
    group
}
