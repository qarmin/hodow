// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackTests.cpp (`createTransformFeedbackTests`,
//   the `simple_fast_gpl` and `simple_optimized_gpl` groups) and framework/vulkan/vkPipelineConstructionUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream hands the `simple` cases a pipeline construction type; here the two
// vertex-only pipeline helpers of `simple_tests.rs` read the type that is ambient while a case runs, which `ConstructionCase`
// makes so (the same technique as the dynamic rendering `graphics_pipeline_library` group).

use std::cell::Cell;

use crate::tcu::{TestError, TestStatus};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

thread_local! {
    static AMBIENT_CONSTRUCTION: Cell<PipelineConstructionType> = const { Cell::new(PipelineConstructionType::Monolithic) };
}

/// The construction type the pipelines of the running case are made with.
pub(super) fn ambient_construction_type() -> PipelineConstructionType {
    AMBIENT_CONSTRUCTION.with(Cell::get)
}

struct AmbientConstructionType {
    previous: PipelineConstructionType,
}

impl AmbientConstructionType {
    fn enter(construction: PipelineConstructionType) -> Self {
        Self {
            previous: AMBIENT_CONSTRUCTION.with(|ambient| ambient.replace(construction)),
        }
    }
}

impl Drop for AmbientConstructionType {
    fn drop(&mut self) {
        AMBIENT_CONSTRUCTION.with(|ambient| ambient.set(self.previous));
    }
}

struct ConstructionCase {
    inner: Box<dyn TestCase>,
    construction: PipelineConstructionType,
}

impl TestCase for ConstructionCase {
    fn name(&self) -> &str {
        self.inner.name()
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_pipeline_construction_requirements(context, self.construction)?;
        self.inner.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConstructionInstance {
            inner: self.inner.create_instance(context),
            construction: self.construction,
        })
    }
}

struct ConstructionInstance<'a> {
    inner: Box<dyn TestInstance + 'a>,
    construction: PipelineConstructionType,
}

impl TestInstance for ConstructionInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let _ambient = AmbientConstructionType::enter(self.construction);
        self.inner.iterate()
    }
}

/// `simple_fast_gpl` and `simple_optimized_gpl`: the `simple` cases with the pipelines linked from libraries.
pub fn create_library_simple_group(name: &str, construction: PipelineConstructionType) -> TestCaseGroup {
    super::simple_tests::create_simple_group(name).map_cases(&mut |case| {
        Box::new(ConstructionCase {
            inner: case,
            construction,
        }) as Box<dyn TestCase>
    })
}
