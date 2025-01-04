// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsSizeControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `compute` cases (shaders from `scripts/gen_subgroups_compute_manifest.py`, the spec field `sc=`) and
// `generic.subgroup_size_properties` run; the names of the graphics, framebuffer, mesh and ray tracing cases are registered gated on
// VK_EXT_subgroup_size_control (NotSupported without, NotPorted with).

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::compute_tests::{ComputeLike, Params, RunOverrides, make_compute_or_mesh_test_with};
use super::utils::{
    is_subgroup_feature_supported_for_device, is_subgroup_supported, subgroup_properties,
    subgroup_size_control_features, subgroup_size_control_properties,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::gated::build_gated_groups_with;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `RequiredSubgroupSizeMode`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum SizeMode {
    None,
    Min,
    Max,
}

/// Which of the two compute shaders of the file the case has: the one that stores `gl_SubgroupSize`, or `initProgramsRequireFull`'s.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum SizeKind {
    Plain,
    RequireFull,
}

/// `CaseDefinition` of the compute cases, written in the spec as `sc=<flag bits>:<min|max|none>:<plain|full>:<requires ballot>:<spirv 1.6>` (flag bit 1 is
/// allow varying subgroup size, bit 2 is require full subgroups).
#[derive(Clone, Copy)]
pub struct SizeControl {
    pub flags: vk::PipelineShaderStageCreateFlags,
    pub mode: SizeMode,
    pub kind: SizeKind,
    pub requires_ballot: bool,
    pub spirv16: bool,
}

/// `getLocalSizes`
fn get_local_sizes(max_work_group_size: [u32; 3], num_work_group_invocations: u32) -> [u32; 3] {
    fn gcd(a: u32, b: u32) -> u32 {
        if b == 0 { a } else { gcd(b, a % b) }
    }
    let local_size_x = gcd(num_work_group_invocations, max_work_group_size[0]);
    let local_size_y = gcd(
        (num_work_group_invocations / local_size_x).max(1),
        max_work_group_size[1],
    );
    let local_size_z = (num_work_group_invocations / (local_size_x * local_size_y)).max(1);
    [local_size_x, local_size_y, local_size_z]
}

impl SizeControl {
    pub fn parse(entry: &str) -> Self {
        let parts: Vec<&str> = entry.split(':').collect();
        let bits: u32 = parts[0].parse().expect("flag bits");
        let mut flags = vk::PipelineShaderStageCreateFlags::empty();
        if bits & 1 != 0 {
            flags |= vk::PipelineShaderStageCreateFlags::ALLOW_VARYING_SUBGROUP_SIZE;
        }
        if bits & 2 != 0 {
            flags |= vk::PipelineShaderStageCreateFlags::REQUIRE_FULL_SUBGROUPS;
        }
        Self {
            flags,
            mode: match parts[1] {
                "min" => SizeMode::Min,
                "max" => SizeMode::Max,
                _ => SizeMode::None,
            },
            kind: if parts[2] == "full" {
                SizeKind::RequireFull
            } else {
                SizeKind::Plain
            },
            requires_ballot: parts[3] == "1",
            spirv16: parts[4] == "1",
        }
    }

    /// `getRequiredSubgroupSizeFromMode`, `None` for the cases that do not set one
    pub fn required_subgroup_size(&self, context: &Context<'_>) -> Option<u32> {
        let properties = subgroup_size_control_properties(context);
        match self.mode {
            SizeMode::None => None,
            SizeMode::Min => Some(properties.min_subgroup_size),
            SizeMode::Max => Some(properties.max_subgroup_size),
        }
    }

    fn has_full_subgroups_flag(&self) -> bool {
        self.flags
            .contains(vk::PipelineShaderStageCreateFlags::REQUIRE_FULL_SUBGROUPS)
    }

    /// `shaderUsesFullSubgroups`
    fn shader_uses_full_subgroups(&self) -> bool {
        self.has_full_subgroups_flag() || self.spirv16
    }

    /// `supportedCheckFeatures` for the compute stage
    pub fn check_support(&self, context: &Context<'_>, stage: vk::ShaderStageFlags) -> Result<(), TestError> {
        if !is_subgroup_supported(context) {
            return Err(TestError::NotSupported(
                "Subgroup operations are not supported".to_string(),
            ));
        }
        context.require_device_functionality("VK_EXT_subgroup_size_control")?;

        if !subgroup_properties(context).supported_stages.intersects(stage) {
            return Err(TestError::NotSupported(
                "Shader stage is required to support subgroup operations!".to_string(),
            ));
        }

        if self.requires_ballot && !is_subgroup_feature_supported_for_device(context, vk::SubgroupFeatureFlags::BALLOT)
        {
            return Err(TestError::NotSupported(
                "Device does not support subgroup ballot operations".to_string(),
            ));
        }

        if self.mode != SizeMode::None || self.flags == vk::PipelineShaderStageCreateFlags::ALLOW_VARYING_SUBGROUP_SIZE
        {
            if subgroup_size_control_features(context).subgroup_size_control == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Device does not support varying subgroup sizes nor required subgroup size".to_string(),
                ));
            }

            if self.mode != SizeMode::None
                && !subgroup_size_control_properties(context)
                    .required_subgroup_size_stages
                    .contains(stage)
            {
                return Err(TestError::NotSupported(
                    "Device does not support setting required subgroup size for the stages selected".to_string(),
                ));
            }
        }

        if self.has_full_subgroups_flag() && subgroup_size_control_features(context).compute_full_subgroups == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Device does not support full subgroups in compute shaders".to_string(),
            ));
        }

        if self.spirv16 && context.api_version() < (1, 3, 0) {
            return Err(TestError::NotSupported(
                "Shader requires SPIR-V version higher than available".to_string(),
            ));
        }
        Ok(())
    }

    /// `test`, `testRequireFullSubgroups` and `testRequireSubgroupSize`, compute branches
    pub(super) fn run_compute(&self, context: &Context<'_>, params: &Params) -> TestOutcome {
        let size_properties = subgroup_size_control_properties(context);
        let limits = context.get_device_properties().limits;
        let device_subgroup_size = subgroup_properties(context).subgroup_size;
        let (min_size, max_size) = (size_properties.min_subgroup_size, size_properties.max_subgroup_size);

        // checkCompute: every invocation stored a subgroup size inside the limits, which is the required one when there is one
        let check_compute = move |required: Option<u32>| {
            move |data: &[u32], num_workgroups: [u32; 3], local_size: [u32; 3], _subgroup_size: u32| {
                let width = (0..3).map(|i| num_workgroups[i] * local_size[i]).product::<u32>() as usize;
                data.iter().take(width).all(|&size| {
                    size <= max_size && size >= min_size && required.is_none_or(|required| size == required)
                })
            }
        };
        // checkComputeRequireFull: the result is uvec4(gl_SubgroupSize, active invocations, gl_NumSubgroups)
        let uses_full = self.shader_uses_full_subgroups();
        let check_require_full = move |required_size: u32, is_required: bool| {
            move |data: &[u32], num_workgroups: [u32; 3], local_size: [u32; 3], _subgroup_size: u32| {
                let width = (0..3).map(|i| num_workgroups[i] * local_size[i]).product::<u32>() as usize;
                let num_subgroups = local_size.iter().product::<u32>() / required_size;
                let exact_subgroup_size = uses_full && is_required;
                (0..width).all(|i| {
                    let (size, active, subgroups) = (data[i * 4], data[i * 4 + 1], data[i * 4 + 2]);
                    size <= max_size
                        && size >= min_size
                        && size == active
                        && !(exact_subgroup_size && size != required_size)
                        && !(exact_subgroup_size && subgroups != num_subgroups)
                })
            }
        };

        let max_work_group_size = limits.max_compute_work_group_size;
        let max_invocations = limits.max_compute_work_group_invocations;
        let stage_flags = self.flags;

        if self.mode == SizeMode::None {
            if self.kind == SizeKind::Plain {
                let local_size = get_local_sizes(max_work_group_size, max_invocations);
                let local_sizes = vec![
                    [1, 1, 1],
                    [32, 4, 1],
                    [32, 1, 4],
                    [1, 32, 4],
                    [1, 4, 32],
                    [4, 1, 32],
                    [4, 32, 1],
                    [device_subgroup_size, 1, 1],
                    [1, device_subgroup_size, 1],
                    [1, 1, device_subgroup_size],
                    [3, 5, 7],
                    [128, 1, 1],
                    [1, 128, 1],
                    [1, 1, 64],
                    local_size,
                    [1, 1, 1], // Isn't used, just here to make double buffering checks easier
                ];
                let check = check_compute(None);
                return make_compute_or_mesh_test_with(
                    context,
                    params,
                    0,
                    ComputeLike::Compute,
                    &RunOverrides {
                        num_workgroups: Some([1, 1, 1]),
                        local_sizes: Some(local_sizes),
                        stage_flags,
                        check: Some(&check),
                    },
                );
            }

            // testRequireFullSubgroups: for full subgroups and allow varying subgroup size, local size X must be a multiple of maxSubgroupSize.
            let local_size = get_local_sizes(max_work_group_size, max_invocations);
            let local_sizes = vec![
                [max_size, 1, 1],
                [max_size, 4, 1],
                [max_size, 1, 4],
                [max_size * 2, 1, 2],
                [max_size * 4, 1, 1],
                local_size,
                [1, 1, 1], // Isn't used, just here to make double buffering checks easier
            ];
            let check = check_require_full(device_subgroup_size, false);
            return make_compute_or_mesh_test_with(
                context,
                params,
                0,
                ComputeLike::Compute,
                &RunOverrides {
                    num_workgroups: Some([1, 1, 1]),
                    local_sizes: Some(local_sizes),
                    stage_flags,
                    check: Some(&check),
                },
            );
        }

        // testRequireSubgroupSize
        let required_subgroup_size = if self.mode == SizeMode::Max { max_size } else { min_size };
        let max_subgroup_limit_size =
            u64::from(required_subgroup_size) * u64::from(size_properties.max_compute_workgroup_subgroups);
        let max_total_local_size = max_subgroup_limit_size.min(u64::from(max_invocations)) as u32;
        let local_size = get_local_sizes(max_work_group_size, max_total_local_size);
        let mut local_sizes = vec![
            local_size,
            [required_subgroup_size, 1, 1],
            [1, required_subgroup_size, 1],
            [1, 1, required_subgroup_size],
            [1, 1, 1], // Isn't used, just here to make double buffering checks easier
        ];
        // If the shader uses full subgroups, use only the first two entries so the local size in X is a multiple of the requested subgroup size.
        if uses_full {
            local_sizes.truncate(3);
        }

        let check_plain = check_compute(Some(required_subgroup_size));
        let check_full = check_require_full(required_subgroup_size, true);
        let check: &dyn Fn(&[u32], [u32; 3], [u32; 3], u32) -> bool =
            if uses_full { &check_full } else { &check_plain };
        make_compute_or_mesh_test_with(
            context,
            params,
            required_subgroup_size,
            ComputeLike::Compute,
            &RunOverrides {
                num_workgroups: Some([1, 1, 1]),
                local_sizes: Some(local_sizes),
                stage_flags,
                check: Some(check),
            },
        )
    }
}

impl SizeControl {
    /// `test` and `testRequireSubgroupSize`, mesh branches: `stage` is the mesh or the task stage
    pub(super) fn run_mesh(&self, context: &Context<'_>, params: &Params, stage: vk::ShaderStageFlags) -> TestOutcome {
        let size_properties = subgroup_size_control_properties(context);
        let device_subgroup_size = subgroup_properties(context).subgroup_size;
        let (min_size, max_size) = (size_properties.min_subgroup_size, size_properties.max_subgroup_size);

        let mut mesh_properties = vk::PhysicalDeviceMeshShaderPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut mesh_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
        let (max_work_group_size, max_invocations) = if stage == vk::ShaderStageFlags::MESH_EXT {
            (
                mesh_properties.max_mesh_work_group_size,
                mesh_properties.max_mesh_work_group_invocations,
            )
        } else {
            (
                mesh_properties.max_task_work_group_size,
                mesh_properties.max_task_work_group_invocations,
            )
        };
        let local_size = get_local_sizes(max_work_group_size, max_invocations);

        let check_compute = move |required: Option<u32>| {
            move |data: &[u32], num_workgroups: [u32; 3], local_size: [u32; 3], _subgroup_size: u32| {
                let width = (0..3).map(|i| num_workgroups[i] * local_size[i]).product::<u32>() as usize;
                data.iter().take(width).all(|&size| {
                    size <= max_size && size >= min_size && required.is_none_or(|required| size == required)
                })
            }
        };

        if self.mode == SizeMode::None {
            let local_sizes = vec![
                [1, 1, 1],
                [32, 4, 1],
                [32, 1, 4],
                [1, 32, 4],
                [1, 4, 32],
                [4, 1, 32],
                [4, 32, 1],
                [device_subgroup_size, 1, 1],
                [1, device_subgroup_size, 1],
                [1, 1, device_subgroup_size],
                [3, 5, 7],
                [128, 1, 1],
                [1, 128, 1],
                [1, 1, 64],
                local_size,
                [1, 1, 1], // Isn't used, just here to make double buffering checks easier
            ];
            let check = check_compute(None);
            return make_compute_or_mesh_test_with(
                context,
                params,
                0,
                ComputeLike::Mesh,
                &RunOverrides {
                    num_workgroups: Some([1, 1, 1]),
                    local_sizes: Some(local_sizes),
                    stage_flags: self.flags,
                    check: Some(&check),
                },
            );
        }

        let required_subgroup_size = if self.mode == SizeMode::Max { max_size } else { min_size };
        let mut local_sizes = vec![
            [required_subgroup_size, 1, 1],
            [1, required_subgroup_size, 1],
            [1, 1, required_subgroup_size],
            local_size,
            [1, 1, 1], // Isn't used, just here to make double buffering checks easier
        ];
        // If the shader uses full subgroups, use only the first two entries so the local size in X is a multiple of the requested subgroup size.
        if self.shader_uses_full_subgroups() {
            local_sizes.truncate(3);
        }
        let check = check_compute(Some(required_subgroup_size));
        make_compute_or_mesh_test_with(
            context,
            params,
            required_subgroup_size,
            ComputeLike::Mesh,
            &RunOverrides {
                num_workgroups: Some([1, 1, 1]),
                local_sizes: Some(local_sizes),
                stage_flags: self.flags,
                check: Some(&check),
            },
        )
    }
}

/// `testSanitySubgroupSizeProperties`, registered with `supportedCheck`
struct SubgroupSizePropertiesCase;

impl TestCase for SubgroupSizePropertiesCase {
    fn name(&self) -> &str {
        "subgroup_size_properties"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !is_subgroup_supported(context) {
            return Err(TestError::NotSupported(
                "Subgroup operations are not supported".to_string(),
            ));
        }
        context.require_device_functionality("VK_EXT_subgroup_size_control")
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SubgroupSizePropertiesInstance { context })
    }
}

struct SubgroupSizePropertiesInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for SubgroupSizePropertiesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let mut size_control = vk::PhysicalDeviceSubgroupSizeControlProperties::default();
        let mut subgroup = vk::PhysicalDeviceSubgroupProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder()
            .push_next(&mut subgroup)
            .push_next(&mut size_control);
        unsafe {
            self.context
                .get_instance()
                .get_physical_device_properties2(self.context.get_physical_device(), &mut properties2)
        };

        if subgroup.subgroup_size > size_control.max_subgroup_size
            || subgroup.subgroup_size < size_control.min_subgroup_size
        {
            return Ok(TestStatus::fail(format!(
                "subgroupSize ({}) is not between maxSubgroupSize ({}) and minSubgroupSize ({})",
                subgroup.subgroup_size, size_control.max_subgroup_size, size_control.min_subgroup_size
            )));
        }
        Ok(TestStatus::pass("OK"))
    }
}

/// The `size_control` group of the subgroups tree: the cases in `real` (by full dotted path) run, the rest of the mustpass names are gated.
pub fn create_size_control_tests(real: &mut HashMap<String, Box<dyn TestCase>>) -> TestCaseGroup {
    real.insert(
        "size_control.generic.subgroup_size_properties".to_string(),
        Box::new(SubgroupSizePropertiesCase),
    );
    build_gated_groups_with(
        include_str!("size_control_cases/cases.txt"),
        &["VK_EXT_subgroup_size_control"],
        "the subgroup size control tests",
        &mut |path| real.remove(path),
    )
    .into_iter()
    .next()
    .expect("the case list has one root group")
}
