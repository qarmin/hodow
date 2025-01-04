// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderClockTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The vertex and fragment stages run through the ShaderExecutor (`gen_shader_executor_programs.py`, `shader_clock_specs`). The compute stage is without `ShaderExecutor`: the shader the executor would build around the spec's source is
// written out by `scripts/gen_shader_clock_manifest.py` (`shaders/manifest/shader_clock.toml`) and run through the compute case of the assembly groups. Every one of the 32
// invocations stores uvec2(1, 0) if its second clock reading was lower than its first, so the whole output is expected to be zero.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::shader_clock::ALL_SHADER_CLOCK_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::shaderexecutor::{
    ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_shader, execute, executor_programs,
};
use crate::vkt::tests::spirv_assembly::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NUM_ELEMENTS: usize = 32;

/// The `rust_type` of the manifest entries: one clock function.
#[derive(Clone, Copy)]
pub struct ShaderClockCase {
    pub name: &'static str,
    pub bits64: u32,
    pub device: u32,
    pub programs: BinaryCollection,
}

fn make_case(case: &ShaderClockCase, leaf: &str) -> Box<dyn TestCase> {
    let mut spec = ComputeShaderSpec {
        num_work_groups: [NUM_ELEMENTS as u32, 1, 1],
        ..Default::default()
    };
    spec.outputs.push(vec![0u8; NUM_ELEMENTS * 8]);
    spec.extensions.push("VK_KHR_shader_clock".to_string());
    if case.bits64 != 0 {
        spec.features.push(RequiredFeature::ShaderInt64);
    }
    spec.features.push(if case.device != 0 {
        RequiredFeature::ShaderDeviceClock
    } else {
        RequiredFeature::ShaderSubgroupClock
    });
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

static CLOCK_SPEC: ShaderSpec = ShaderSpec {
    inputs: &[],
    outputs: &[Symbol::new("out0", ScalarKind::Uint, 2)],
};

/// The `operations` table of `addShaderClockTests`: name, 64 bit result, device scope.
const OPERATIONS: [(&str, bool, bool); 4] = [
    ("clockARB", true, false),
    ("clock2x32ARB", false, false),
    ("clockRealtimeEXT", true, true),
    ("clockRealtime2x32EXT", false, true),
];

/// `ShaderClockCase` of the vertex and fragment stages, which go through the ShaderExecutor.
struct ShaderClockExecutorCase {
    name: &'static str,
    bits64: bool,
    device: bool,
    shader_type: ShaderType,
}

impl TestCase for ShaderClockExecutorCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_shader_clock")?;
        if self.bits64 && context.get_device_features().shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
        }
        let mut features = vk::PhysicalDeviceShaderClockFeaturesKHR::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if self.device && features.shader_device_clock == vk::FALSE {
            return Err(TestError::NotSupported(
                "Shader device clock is not supported".to_string(),
            ));
        }
        if !self.device && features.shader_subgroup_clock == vk::FALSE {
            return Err(TestError::NotSupported(
                "Shader subgroup clock is not supported".to_string(),
            ));
        }
        check_support_shader(context, self.shader_type)
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&format!("shader_clock_{}", self.name), self.shader_type)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderClockExecutorInstance {
            context,
            shader_type: self.shader_type,
        })
    }
}

struct ShaderClockExecutorInstance<'a> {
    context: &'a Context<'a>,
    shader_type: ShaderType,
}

impl TestInstance for ShaderClockExecutorInstance<'_> {
    /// `ShaderClockTestInstance::iterate`: the shader writes a 1 where the clock did not increase, so every byte of the output is expected to be zero.
    fn iterate(&mut self) -> TestOutcome {
        let mut output = vec![0xcdu8; NUM_ELEMENTS * 8];
        execute(
            self.context,
            self.shader_type,
            &CLOCK_SPEC,
            None,
            NUM_ELEMENTS,
            &[],
            &mut [&mut output[..]],
            None,
        )?;
        if output.iter().all(|&byte| byte == 0) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Result comparison failed"))
        }
    }
}

/// `createShaderClockTests`
pub fn create_shader_clock_tests() -> TestCaseGroup {
    let mut compute = TestCaseGroup::new("compute");
    for case in ALL_SHADER_CLOCK_CASE.iter() {
        let leaf = case.name.rsplit('/').next().expect("a case name has a leaf");
        compute.add_child(make_case(case, leaf));
    }
    let mut group = TestCaseGroup::new("shader_clock");
    for (stage_name, shader_type) in [("vertex", ShaderType::Vertex), ("fragment", ShaderType::Fragment)] {
        let mut stage = TestCaseGroup::new(stage_name);
        for (name, bits64, device) in OPERATIONS {
            stage.add_child(Box::new(ShaderClockExecutorCase {
                name,
                bits64,
                device,
                shader_type,
            }) as Box<dyn TestCase>);
        }
        group.add_child(stage);
    }
    group.add_child(compute);
    group
}
