// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp (`createDynamicRenderingTests`, the
//   `graphics_pipeline_library` variant) and framework/vulkan/vkPipelineConstructionUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream runs the groups of `addRenderPassTests` again with the pipelines of
// the cases built from graphics pipeline libraries (`PIPELINE_CONSTRUCTION_TYPE_FAST_LINKED_LIBRARY`), by handing every case a
// `GraphicsPipelineWrapper` of that type. The cases here create their pipelines in one place, `create_pipeline`, which reads the
// construction type that is ambient while a case runs; `ConstructionCase` makes it so. Ported for the groups
// `add_dynamic_rendering_core_groups` adds (simple, formats, attachment, attachment_write_mask), not for the groups other modules
// own.

use std::cell::Cell;

use super::*;
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};

thread_local! {
    static AMBIENT_CONSTRUCTION: Cell<PipelineConstructionType> = const { Cell::new(PipelineConstructionType::Monolithic) };
}

/// The construction type the pipelines of the running case are made with.
pub(super) fn ambient_construction_type() -> PipelineConstructionType {
    AMBIENT_CONSTRUCTION.with(Cell::get)
}

/// Makes a construction type ambient on this thread until dropped.
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

/// A case run with the pipelines of a construction type other than monolithic.
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

/// The `graphics_pipeline_library` group of `dynamic_rendering`: the suballocation and dedicated allocation groups of the
/// primary command buffer variant with the pipelines linked from fast linked libraries.
pub fn create_graphics_pipeline_library_group() -> TestCaseGroup {
    let construction = PipelineConstructionType::FastLinkedLibrary;
    let mut group = TestCaseGroup::new("graphics_pipeline_library");

    for (name, allocation_kind) in [
        ("suballocation", AllocationKind::Suballocated),
        ("dedicated_allocation", AllocationKind::Dedicated),
    ] {
        let mut kind_group = TestCaseGroup::new(name);
        super::add_dynamic_rendering_core_groups(&mut kind_group, allocation_kind);
        // The pipelines of this group come from `vk::pipeline_construction::create_graphics_pipeline`, which has its own ambient type.
        if allocation_kind == AllocationKind::Suballocated {
            let params = crate::vkt::tests::renderpass::group_params::GroupParams {
                rendering_type: crate::vkt::tests::renderpass::group_params::RenderingType::DynamicRendering,
                use_secondary_cmd_buffer: false,
                secondary_cmd_buffer_completely_contains_dynamic_renderpass: false,
            };
            kind_group.add_child(crate::vk::pipeline_construction::with_construction_type(
                crate::vkt::tests::renderpass::subpass_dependency_tests::create_subpass_dependency_tests(params),
                construction,
            ));
            use crate::vkt::tests::renderpass::{
                load_store_op_none_tests, low_resolution_z_tests, multisample_resolve_tests,
                unused_attachment_sparse_filling_tests,
            };
            for group in [
                unused_attachment_sparse_filling_tests::create_unused_attachment_sparse_filling_tests(params),
                multisample_resolve_tests::create_multisample_resolve_tests(params),
                low_resolution_z_tests::create_render_pass_low_resolution_z_tests(params),
                load_store_op_none_tests::create_render_pass_load_store_op_none_tests(params),
            ] {
                kind_group.add_child(crate::vk::pipeline_construction::with_construction_type(
                    group,
                    construction,
                ));
            }
        }
        group.add_child(kind_group.map_cases(&mut |case| {
            Box::new(ConstructionCase {
                inner: case,
                construction,
            }) as Box<dyn TestCase>
        }));
    }

    group
}
