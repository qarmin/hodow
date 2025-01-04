// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateTests.cpp (`createChildren` per pipeline construction type)
//   and framework/vulkan/vkPipelineConstructionUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream hands every case a `GraphicsPipelineWrapper` of the group's
// construction type. The cases here create their pipelines from a `GraphicsPipelineCreateInfo` through `create_graphics_pipeline`,
// which reads the construction type that is ambient while a case runs; `ConstructionCase` makes it so.

use std::cell::Cell;
use std::slice;

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::pipeline_construction::{
    PipelineConstructionType, PipelineParts, check_pipeline_construction_requirements, create_linked_pipeline,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

thread_local! {
    static AMBIENT_CONSTRUCTION: Cell<PipelineConstructionType> = const { Cell::new(PipelineConstructionType::Monolithic) };
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

/// `vkCreateGraphicsPipelines` for one create info, made from graphics pipeline libraries when the running case asks for them.
/// The info must not chain anything: the states the libraries are made of are read off its members.
pub fn create_graphics_pipeline<'a>(
    device: &'a Device,
    info: &vk::GraphicsPipelineCreateInfo,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let construction = AMBIENT_CONSTRUCTION.with(Cell::get);
    if construction == PipelineConstructionType::Monolithic {
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[*info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        return Ok(Unique::new(device, pipelines.0[0]));
    }

    let default_depth_stencil = vk::PipelineDepthStencilStateCreateInfo::default();
    let default_vertex_input = vk::PipelineVertexInputStateCreateInfo::default();
    let default_input_assembly = vk::PipelineInputAssemblyStateCreateInfo::default();
    // SAFETY: the pointers are those of a create info the caller built from live states for this very call.
    let parts = unsafe {
        PipelineParts {
            flags: info.flags,
            layout: info.layout,
            render_pass: info.render_pass,
            subpass: info.subpass,
            stages: slice::from_raw_parts(info.stages, info.stage_count as usize),
            vertex_input: info.vertex_input_state.as_ref().unwrap_or(&default_vertex_input),
            input_assembly: info.input_assembly_state.as_ref().unwrap_or(&default_input_assembly),
            tessellation: info.tessellation_state.as_ref(),
            viewport: &*info.viewport_state,
            rasterization: &*info.rasterization_state,
            multisample: &*info.multisample_state,
            depth_stencil: info.depth_stencil_state.as_ref().unwrap_or(&default_depth_stencil),
            color_blend: info.color_blend_state.as_ref(),
            dynamic: info.dynamic_state.as_ref(),
            rendering: None,
            fragment_shading_rate: None,
        }
    };
    create_linked_pipeline(device, construction, &parts)
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

    fn is_stub(&self) -> bool {
        self.inner.is_stub()
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
    fn iterate(&mut self) -> TestOutcome {
        let _ambient = AmbientConstructionType::enter(self.construction);
        self.inner.iterate()
    }
}

/// A case that checks the support of the one it wraps and then reports NotPorted: what it runs would not be what the group's construction type asks for.
struct NotPortedCase {
    inner: Box<dyn TestCase>,
    reason: &'static str,
}

impl TestCase for NotPortedCase {
    fn name(&self) -> &str {
        self.inner.name()
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.inner.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs()
    }

    fn is_stub(&self) -> bool {
        true
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NotPortedInstance { reason: self.reason })
    }
}

struct NotPortedInstance {
    reason: &'static str,
}

impl TestInstance for NotPortedInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(self.reason.to_string()))
    }
}

/// A group whose cases are registered, for their names, but are not run.
#[allow(dead_code)]
pub fn not_ported(group: TestCaseGroup, reason: &'static str) -> TestCaseGroup {
    group.map_cases(&mut |case| Box::new(NotPortedCase { inner: case, reason }) as Box<dyn TestCase>)
}

/// A group whose cases build their pipelines with the given construction type.
pub fn with_construction_type(group: TestCaseGroup, construction: PipelineConstructionType) -> TestCaseGroup {
    group.map_cases(&mut |case| {
        Box::new(ConstructionCase {
            inner: case,
            construction,
        }) as Box<dyn TestCase>
    })
}
