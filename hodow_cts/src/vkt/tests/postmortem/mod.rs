// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/postmortem/vktPostmortemTests.cpp
//   external/vulkancts/modules/vulkan/postmortem/vktPostmortemCoreDeviceFaultTests.cpp
//   external/vulkancts/modules/vulkan/postmortem/vktPostmortemShaderAbortTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case trees of `postmortem.device_fault` and `shader_abort` are registered with the
// extension checks upstream starts with; the instances are not ported because vulkanalia 0.35 has no VK_KHR_device_fault,
// VK_KHR_shader_abort or VK_KHR_shader_constant_data, so every case is a stub that reports NotPorted on a driver exposing them.

use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct ExtensionStubCase {
    name: &'static str,
    extensions: &'static [&'static str],
}

impl TestCase for ExtensionStubCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        for extension in self.extensions {
            context.require_device_functionality(extension)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NotPortedInstance { name: self.name })
    }

    fn is_stub(&self) -> bool {
        true
    }
}

struct NotPortedInstance {
    name: &'static str,
}

impl TestInstance for NotPortedInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(format!(
            "{}: the VK_KHR_device_fault / VK_KHR_shader_abort entry points are not in vulkanalia 0.35",
            self.name
        )))
    }
}

const DEVICE_FAULT: &[&str] = &["VK_KHR_device_fault"];
const DEVICE_FAULT_SHADER_ABORT: &[&str] = &["VK_KHR_device_fault", "VK_KHR_shader_abort"];
const SHADER_ABORT: &[&str] = &[
    "VK_KHR_device_fault",
    "VK_KHR_shader_abort",
    "VK_KHR_shader_constant_data",
];

fn stub(name: &'static str, extensions: &'static [&'static str]) -> Box<dyn TestCase> {
    Box::new(ExtensionStubCase { name, extensions })
}

/// `createDeviceFaultTestsKHR`
fn create_device_fault_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("device_fault");

    let mut no_fault = TestCaseGroup::new("no_fault");
    no_fault.add_child(stub("max_fault_property_atleast_one", DEVICE_FAULT));
    no_fault.add_child(stub("counts_query", DEVICE_FAULT));
    no_fault.add_child(stub("very_short_timeout", DEVICE_FAULT));
    no_fault.add_child(stub("vendor_binary_size_query", DEVICE_FAULT));
    root.add_child(no_fault);

    for option in ["base", "waitidle"] {
        let mut group = TestCaseGroup::new(&format!("with_fault_{option}"));
        for name in [
            "blocking_query",
            "zero_report_query",
            "blocking_query_no_more_faults_after_device_lost",
            "blocking_query_more_than_available",
            "drain_query",
            "async_query",
            "vendor_binary_size_query",
            "vendor_binary_data",
            "vendor_binary_not_enough_space",
            "vendor_binary_more_enough_space",
        ] {
            group.add_child(stub(name, DEVICE_FAULT_SHADER_ABORT));
        }
        root.add_child(group);
    }
    root
}

/// `postmortem::createTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("postmortem");
    group.add_child(create_device_fault_tests());
    group
}

/// `postmortem::createShaderAbortTests`
pub fn create_shader_abort_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_abort");
    for name in [
        "basic_termination",
        "empty_message",
        "large_buffer",
        "large_constant",
        "pipeline_cache",
        "pipeline_binary",
        "shader_object",
        "max_message_size",
    ] {
        group.add_child(stub(name, SHADER_ABORT));
    }
    group
}
