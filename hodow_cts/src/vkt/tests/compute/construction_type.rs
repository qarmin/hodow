// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeTests.cpp (`createTests`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream hands the `ComputePipelineConstructionType` to every case
// constructor and registers the subtree once per type. The cases here are built from the statics of the shader manifests and
// build their pipelines through `ComputePipelineWrapper`, so the subtree of `shader_object_spirv` and `shader_object_binary` is
// the same cases wrapped in `ConstructionTypeCase`, which makes the type ambient for the wrappers they create.

use crate::tcu::{TestError, TestOutcome};
use crate::vk::compute_pipeline::{AmbientConstructionType, ComputePipelineConstructionType};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// A case of the compute subtree that runs with the given construction type.
pub struct ConstructionTypeCase {
    inner: Box<dyn TestCase>,
    construction_type: ComputePipelineConstructionType,
}

impl ConstructionTypeCase {
    pub fn wrap(inner: Box<dyn TestCase>, construction_type: ComputePipelineConstructionType) -> Box<dyn TestCase> {
        Box::new(Self {
            inner,
            construction_type,
        })
    }
}

impl TestCase for ConstructionTypeCase {
    fn name(&self) -> &str {
        self.inner.name()
    }

    /// `checkShaderObjectRequirements`, then the case's own checks under the same construction type.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.construction_type != ComputePipelineConstructionType::Pipeline {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }
        let _ambient = AmbientConstructionType::enter(self.construction_type);
        self.inner.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let _ambient = AmbientConstructionType::enter(self.construction_type);
        Box::new(ConstructionTypeInstance {
            inner: self.inner.create_instance(context),
            construction_type: self.construction_type,
        })
    }

    fn is_stub(&self) -> bool {
        self.inner.is_stub()
    }
}

struct ConstructionTypeInstance<'a> {
    inner: Box<dyn TestInstance + 'a>,
    construction_type: ComputePipelineConstructionType,
}

impl TestInstance for ConstructionTypeInstance<'_> {
    /// A case that never went through `ComputePipelineWrapper` ran as a pipeline whatever group it is in, which must not pass as a shader-object run.
    fn iterate(&mut self) -> TestOutcome {
        let ambient = AmbientConstructionType::enter(self.construction_type);
        let outcome = self.inner.iterate();
        let created = ambient.wrappers_created();
        drop(ambient);

        match outcome {
            Ok(status) if created == 0 && self.construction_type != ComputePipelineConstructionType::Pipeline => {
                Err(TestError::NotPorted(format!(
                    "{:?} for a case that builds its pipeline outside ComputePipelineWrapper (it ran as {status:?})",
                    self.construction_type
                )))
            }
            other => other,
        }
    }
}
