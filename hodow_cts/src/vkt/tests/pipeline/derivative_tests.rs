// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDerivativeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_derivative::DERIVATIVE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::obj_util::make_pipeline_layout;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    ByHandle,
    ByIndex,
}

struct DerivativeCase {
    name: &'static str,
    kind: Kind,
    use_maintenance5: bool,
}

impl TestCase for DerivativeCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.use_maintenance5
            && !context.is_device_functionality_supported("VK_KHR_maintenance5")
            && !context.is_device_functionality_supported("VK_KHR_extended_flags")
        {
            return Err(TestError::NotSupported(
                "Extensions VK_KHR_maintenance5 and VK_KHR_extended_flags not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DERIVATIVE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DerivativeInstance {
            context,
            kind: self.kind,
            use_maintenance5: self.use_maintenance5,
        })
    }
}

struct DerivativeInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    use_maintenance5: bool,
}

/// One `vkCreateComputePipelines` call. `flags2` is the `VkPipelineCreateFlags2CreateInfoKHR` upstream chains in
/// place of `flags` when it tests the maintenance5 way of spelling them.
fn create_compute_pipeline<'a>(
    device: &'a Device,
    stage: vk::PipelineShaderStageCreateInfo,
    layout: vk::PipelineLayout,
    flags: vk::PipelineCreateFlags,
    flags2: Option<vk::PipelineCreateFlags2>,
    base_pipeline_handle: vk::Pipeline,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut flags2_info =
        vk::PipelineCreateFlags2CreateInfo::builder().flags(flags2.unwrap_or_else(vk::PipelineCreateFlags2::empty));
    let mut info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .flags(flags)
        .base_pipeline_handle(base_pipeline_handle)
        .base_pipeline_index(-1);
    if flags2.is_some() {
        info = info.push_next(&mut flags2_info);
    }
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

impl TestInstance for DerivativeInstance<'_> {
    /// `testComputeDerivativeByHandle` and `testComputeDerivativeByIndex`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("comp")?)?;
        let layout = make_pipeline_layout(device, &[])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();

        if self.kind == Kind::ByHandle {
            let (base_flags, base_flags2) = if self.use_maintenance5 {
                (
                    vk::PipelineCreateFlags::empty(),
                    Some(vk::PipelineCreateFlags2::ALLOW_DERIVATIVES),
                )
            } else {
                (vk::PipelineCreateFlags::ALLOW_DERIVATIVES, None)
            };
            let base_pipeline =
                create_compute_pipeline(device, stage, *layout, base_flags, base_flags2, vk::Pipeline::null())?;

            // Create second (identical) pipeline based on first
            let (derived_flags, derived_flags2) = if self.use_maintenance5 {
                (
                    vk::PipelineCreateFlags::empty(),
                    Some(vk::PipelineCreateFlags2::DERIVATIVE),
                )
            } else {
                (vk::PipelineCreateFlags::DERIVATIVE, None)
            };
            let _derived_pipeline =
                create_compute_pipeline(device, stage, *layout, derived_flags, derived_flags2, *base_pipeline)?;
        } else {
            let create_infos = [
                vk::ComputePipelineCreateInfo::builder()
                    .stage(stage)
                    .layout(*layout)
                    .flags(vk::PipelineCreateFlags::ALLOW_DERIVATIVES)
                    .base_pipeline_index(-1)
                    .build(),
                vk::ComputePipelineCreateInfo::builder()
                    .stage(stage)
                    .layout(*layout)
                    .flags(vk::PipelineCreateFlags::DERIVATIVE)
                    .base_pipeline_index(0)
                    .build(),
            ];
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &create_infos, None) }
                .vk_check("vkCreateComputePipelines")?;
            let _pipelines: Vec<Unique<'_, vk::Pipeline>> = pipelines
                .0
                .into_iter()
                .map(|pipeline| Unique::new(device, pipeline))
                .collect();
        }

        // If we got here without crashing, success.
        Ok(TestStatus::pass("OK"))
    }
}

/// `createDerivativeTests`
pub fn create_derivative_tests() -> TestCaseGroup {
    let mut derivative_tests = TestCaseGroup::new("derivative");
    let mut compute_tests = TestCaseGroup::new("compute");

    compute_tests.add_child(Box::new(DerivativeCase {
        name: "derivative_by_handle",
        kind: Kind::ByHandle,
        use_maintenance5: false,
    }) as Box<dyn TestCase>);
    compute_tests.add_child(Box::new(DerivativeCase {
        name: "derivative_by_handle_maintenance5",
        kind: Kind::ByHandle,
        use_maintenance5: true,
    }) as Box<dyn TestCase>);
    compute_tests.add_child(Box::new(DerivativeCase {
        name: "derivative_by_index",
        kind: Kind::ByIndex,
        use_maintenance5: false,
    }) as Box<dyn TestCase>);

    derivative_tests.add_child(compute_tests);
    derivative_tests
}
