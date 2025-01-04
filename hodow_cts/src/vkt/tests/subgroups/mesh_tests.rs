// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp (`makeMeshTest`, `makeMeshPipeline`, `initStdPrograms`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `mesh` groups of the subgroup families: the compute runner of `compute_tests.rs`
// with the test source in the mesh shader, or in a task shader that is paired with a mesh shader that emits nothing, drawn with
// vkCmdDrawMeshTasksEXT into a 1x1 framebuffer without attachments. The shaders are in `shaders/manifest/subgroups_mesh.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::compute_tests::{ComputeLike, Params, check_support_common, field, parse, run_with_required_subgroup_size};
use super::utils::subgroup_properties;
use crate::generated::shaders::subgroups_mesh::ALL_SUBGROUP_MESH_CASE;
use crate::tcu::TestError;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one test case of the mesh group of a subgroup family.
#[derive(Clone, Copy)]
pub struct SubgroupMeshCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

struct SubgroupMeshTestCase {
    name: String,
    spec: &'static str,
    programs: BinaryCollection,
}

fn stage_flag(spec: &str) -> vk::ShaderStageFlags {
    match field(spec, "stage") {
        "mesh" => vk::ShaderStageFlags::MESH_EXT,
        "task" => vk::ShaderStageFlags::TASK_EXT,
        other => panic!("subgroup mesh spec with an unknown stage {other}"),
    }
}

impl TestCase for SubgroupMeshTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stage = stage_flag(self.spec);
        let params = parse(self.spec);
        if let Some(size_control) = &params.size_control {
            // supportedCheckFeatures: the stage checks below come after the size control ones in upstream
            size_control.check_support(context, stage)?;
        } else {
            check_support_common(context, self.spec, &params, stage)?;
        }

        context.require_device_functionality("VK_EXT_mesh_shader")?;

        if stage == vk::ShaderStageFlags::TASK_EXT {
            let mut mesh_features = vk::PhysicalDeviceMeshShaderFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut mesh_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if mesh_features.task_shader == vk::FALSE {
                return Err(TestError::NotSupported("Task shaders not supported".to_string()));
            }
        }

        // supportedCheckShader
        if params.size_control.is_none() && !subgroup_properties(context).supported_stages.intersects(stage) {
            return Err(TestError::NotSupported(
                "Subgroup support is not available for test shader stage(s)".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SubgroupMeshInstance {
            context,
            params: parse(self.spec),
            stage: stage_flag(self.spec),
        })
    }
}

struct SubgroupMeshInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
    stage: vk::ShaderStageFlags,
}

impl TestInstance for SubgroupMeshInstance<'_> {
    /// `test`, mesh branch
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        if let Some(size_control) = &self.params.size_control {
            return size_control.run_mesh(self.context, &self.params, self.stage);
        }
        run_with_required_subgroup_size(self.context, &self.params, ComputeLike::Mesh)
    }
}

/// The cases of the mesh groups of the ported families, as the groups of their path below `subgroups` and the case.
pub fn create_mesh_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_SUBGROUP_MESH_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            segments.remove(0);
            (
                segments,
                Box::new(SubgroupMeshTestCase {
                    name: leaf.to_string(),
                    spec: case.spec,
                    programs: case.programs,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
