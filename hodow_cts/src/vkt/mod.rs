// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktTestCase.hpp (vkt::TestCase, vkt::TestInstance)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod context;
pub mod tests;

pub use context::Context;

use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;

/// `vkt::TestCase` - the build-time half of a test.
///
/// The two-phase split is kept from upstream: `check_support` and the shader set are
/// known without a device having run anything, which is what lets the runner report
/// NotSupported without executing, and lets a shader-compilation problem be told
/// apart from an execution problem.
pub trait TestCase: Send + Sync {
    /// `TestNode::getName`
    fn name(&self) -> &str;

    /// `TestCase::checkSupport`. Returning `TestError::NotSupported` is the port's
    /// equivalent of `TCU_THROW(NotSupportedError, ...)`.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError>;

    /// `TestCase::initPrograms`, resolved ahead of time.
    ///
    /// Upstream emits GLSL here and glslang compiles it during the run. The SPIR-V is
    /// compiled by `scripts/compile_shaders.py` instead, so this hands back the
    /// already-built collection that the generator emitted for this case.
    fn programs(&self) -> BinaryCollection;

    /// `TestCase::createInstance`
    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a>;

    /// Whether this case is registered but has no instance behind it yet.
    ///
    /// A case tree is worth landing before the test logic - it is the error-prone part
    /// and can be checked against upstream on its own - but a registered case that
    /// runs nothing must not be counted as coverage. Overriding this is what keeps
    /// `cts-coverage` honest; the default is that a case really runs.
    fn is_stub(&self) -> bool {
        false
    }
}

/// `vkt::TestInstance` - the run-time half.
pub trait TestInstance {
    /// `TestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome;
}
