// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmComputeShaderDerivativesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of every case (compute, mesh and task variants) is composed by
// `scripts/gen_spirv_assembly_compute_shader_derivatives_manifest.py` the way `initPrograms` does and written to
// `shaders/manifest/spirv_assembly_compute_shader_derivatives.toml`; the enum parameters of upstream's `ComputeShaderDerivativeTestParams` are
// carried there as numbers (the order of the C++ enums). The swapped values of `getHorizontallySwappedValues` and its two siblings are computed from
// what they tabulate (checked against the tables by the generator's `--verify-tables`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::spirv_assembly_compute_shader_derivatives::ALL_COMPUTE_SHADER_DERIVATIVES_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{clear_value_color, rect_2d, viewport};
use crate::vkt::tests::mesh_shader::util::mesh_shader_features;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one test case of `compute_shader_derivatives`.
#[derive(Clone, Copy)]
pub struct ComputeShaderDerivativesCase {
    pub name: &'static str,
    pub wg_x: u32,
    pub wg_y: u32,
    pub wg_z: u32,
    pub test_type: u32,
    pub variant: u32,
    pub feature: u32,
    pub quad_op: u32,
    pub quad_ndx: u32,
    pub data_type: u32,
    pub mip_lvl: u32,
    pub shader_type: u32,
    pub use_local_invocation_index: bool,
    pub programs: BinaryCollection,
}

const EXTENT: vk::Extent3D = vk::Extent3D {
    width: 32,
    height: 64,
    depth: 1,
};
const SAMPLED_EXTENT_2D: vk::Extent3D = vk::Extent3D {
    width: 4,
    height: 4,
    depth: 1,
};
const SAMPLED_EXTENT_1D: vk::Extent3D = vk::Extent3D {
    width: 16,
    height: 1,
    depth: 1,
};
const RENDER_TARGET_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const SAMPLED_FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;
const MIP_LEVEL_COUNT: u32 = 2;
const CLR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const CLR_COLORS: [[f32; 4]; 2] = [[0.5, 0.5, 0.5, 0.5], [1.0, 1.0, 1.0, 1.0]];

fn compare_floats(a: f32, b: f32, threshold: f32) -> bool {
    (a - b).abs() <= threshold
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    DerivativeValue,
    VerifyNdx,
    QuadOperations,
    LodSample,
    LodQuery,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DataType {
    Float32,
    Vec2Float32,
    Vec3Float32,
    Vec4Float32,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DerivativeFeature {
    Linear,
    Quads,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DerivativeVariant {
    Normal,
    Fine,
    Coarse,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum QuadOp {
    Broadcast,
    Swap,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    Compute,
    Mesh,
    Task,
}

struct Params {
    num_workgroup: [u32; 3],
    test_type: TestType,
    variant: DerivativeVariant,
    feature: DerivativeFeature,
    quad_op: QuadOp,
    quad_ndx: u32,
    shader_type: ShaderType,
    data_type: DataType,
    mip_lvl: u32,
}

impl Params {
    fn from_case(case: &ComputeShaderDerivativesCase) -> Self {
        Self {
            num_workgroup: [case.wg_x, case.wg_y, case.wg_z],
            test_type: match case.test_type {
                0 => TestType::DerivativeValue,
                1 => TestType::VerifyNdx,
                2 => TestType::QuadOperations,
                3 => TestType::LodSample,
                _ => TestType::LodQuery,
            },
            variant: match case.variant {
                0 => DerivativeVariant::Normal,
                1 => DerivativeVariant::Fine,
                _ => DerivativeVariant::Coarse,
            },
            feature: if case.feature == 0 {
                DerivativeFeature::Linear
            } else {
                DerivativeFeature::Quads
            },
            quad_op: if case.quad_op == 0 {
                QuadOp::Broadcast
            } else {
                QuadOp::Swap
            },
            quad_ndx: case.quad_ndx,
            shader_type: match case.shader_type {
                0 => ShaderType::Compute,
                1 => ShaderType::Mesh,
                _ => ShaderType::Task,
            },
            data_type: match case.data_type {
                0 => DataType::Float32,
                1 => DataType::Vec2Float32,
                2 => DataType::Vec3Float32,
                _ => DataType::Vec4Float32,
            },
            mip_lvl: case.mip_lvl,
        }
    }

    fn total_invocations(&self) -> u32 {
        self.num_workgroup[0] * self.num_workgroup[1] * self.num_workgroup[2]
    }
}

fn shader_type_name(shader_type: ShaderType) -> &'static str {
    match shader_type {
        ShaderType::Compute => "compute",
        ShaderType::Mesh => "mesh",
        ShaderType::Task => "task",
    }
}

/// `getDataAlignedSizeInBytes`
fn data_aligned_size_in_bytes(data_type: DataType) -> u32 {
    match data_type {
        DataType::Float32 => 4,
        DataType::Vec2Float32 => 8,
        DataType::Vec3Float32 | DataType::Vec4Float32 => 16,
    }
}

/// `getDataAlignedComponentCount`
fn data_aligned_component_count(data_type: DataType) -> u32 {
    match data_type {
        DataType::Float32 => 1,
        DataType::Vec2Float32 => 2,
        DataType::Vec3Float32 | DataType::Vec4Float32 => 4,
    }
}

/// `getImageType`
fn image_type(feature: DerivativeFeature) -> vk::ImageType {
    match feature {
        DerivativeFeature::Linear => vk::ImageType::_1D,
        DerivativeFeature::Quads => vk::ImageType::_2D,
    }
}

/// `getImageViewType`
fn image_view_type(feature: DerivativeFeature) -> vk::ImageViewType {
    match feature {
        DerivativeFeature::Linear => vk::ImageViewType::_1D,
        DerivativeFeature::Quads => vk::ImageViewType::_2D,
    }
}

/// `getImageExtent`
fn image_extent(feature: DerivativeFeature) -> vk::Extent3D {
    match feature {
        DerivativeFeature::Linear => SAMPLED_EXTENT_1D,
        DerivativeFeature::Quads => SAMPLED_EXTENT_2D,
    }
}

/// `calculateBufferSize`
fn calculate_buffer_size(test_type: TestType, num_workgroup: [u32; 3], data_type: DataType) -> u32 {
    let invocations = num_workgroup[0] * num_workgroup[1] * num_workgroup[2];
    if test_type == TestType::VerifyNdx {
        invocations * 4
    } else {
        invocations * data_aligned_size_in_bytes(data_type)
    }
}

/// `getShaderStageFlagBits`
fn shader_stage_flag_bits(shader_type: ShaderType) -> vk::ShaderStageFlags {
    match shader_type {
        ShaderType::Compute => vk::ShaderStageFlags::COMPUTE,
        ShaderType::Mesh => vk::ShaderStageFlags::MESH_EXT,
        ShaderType::Task => vk::ShaderStageFlags::TASK_EXT,
    }
}

/// `getPipelineStageFlagBits`
fn pipeline_stage_flag_bits(shader_type: ShaderType) -> vk::PipelineStageFlags {
    match shader_type {
        ShaderType::Compute => vk::PipelineStageFlags::COMPUTE_SHADER,
        ShaderType::Mesh => vk::PipelineStageFlags::MESH_SHADER_EXT,
        ShaderType::Task => vk::PipelineStageFlags::TASK_SHADER_EXT,
    }
}

/// What `getHorizontallySwappedValues`, `getVerticallySwappedValues` and `getDiagonallySwappedValues` tabulate, by `swap` 0, 1 and 2: the test
/// value of the lane a quad swap reads, per component, zero in the padding of a vec3. The quads tables are for a workgroup four wide.
fn swapped_values(swap: u32, elem_count: usize, data_type: DataType, feature: DerivativeFeature) -> Vec<f32> {
    let components = data_aligned_component_count(data_type) as usize;
    (0..elem_count)
        .map(|ndx| {
            if data_type == DataType::Vec3Float32 && (ndx + 1) % 4 == 0 {
                return 0.0;
            }
            let lane = (ndx / components) as u32;
            match feature {
                DerivativeFeature::Linear => 10.0 * ((lane & 3) ^ (swap + 1)) as f32,
                DerivativeFeature::Quads => {
                    let (swap_x, swap_y) = [(1, 0), (0, 1), (1, 1)][swap as usize];
                    let (x, y) = (lane % 4, lane / 4);
                    10.0 * ((x ^ swap_x) & 1) as f32 + 20.0 * ((y ^ swap_y) & 1) as f32
                }
            }
        })
        .collect()
}

/// `fine` variant, linear workgroup: the `expX`, `expY` and `expF` the first part of `checkResult` fills.
fn fine_linear_expected(data_type: DataType, ndx: u32) -> (f32, f32, f32) {
    let n1 = ndx + 1;
    match data_type {
        DataType::Float32 => {
            let exp_x = if n1 % 4 == 1 || n1 % 4 == 2 { 10.0 } else { 50.0 };
            let exp_y = if n1 % 2 == 1 { 40.0 } else { 80.0 };
            let exp_f = if n1 % 4 == 1 {
                50.0
            } else if n1 % 4 == 0 {
                130.0
            } else {
                90.0
            };
            (exp_x, exp_y, exp_f)
        }
        DataType::Vec2Float32 => {
            let exp_x = if n1 % 8 > 0 && n1 % 8 < 5 { 10.0 } else { 50.0 };
            let exp_y = if n1 % 4 == 1 || n1 % 4 == 2 { 40.0 } else { 80.0 };
            let exp_f = if n1 % 8 > 0 && n1 % 8 < 3 {
                50.0
            } else if n1 % 8 == 0 || n1 % 8 == 7 {
                130.0
            } else {
                90.0
            };
            (exp_x, exp_y, exp_f)
        }
        DataType::Vec3Float32 => {
            let mut exp_x = if n1 % 16 < 8 { 10.0 } else { 50.0 };
            let mut exp_y = if n1 % 8 < 4 { 40.0 } else { 80.0 };
            let mut exp_f = if n1 % 16 < 4 {
                50.0
            } else if n1 % 16 > 12 {
                130.0
            } else {
                90.0
            };
            if n1 % 4 == 0 {
                exp_x = 0.0;
                exp_y = 0.0;
                exp_f = 0.0;
            }
            (exp_x, exp_y, exp_f)
        }
        DataType::Vec4Float32 => {
            let exp_x = if n1 % 16 <= 8 && n1 % 16 != 0 { 10.0 } else { 50.0 };
            let exp_y = if n1 % 8 <= 4 && n1 % 8 != 0 { 40.0 } else { 80.0 };
            let exp_f = if n1 % 16 <= 4 && n1 % 16 != 0 {
                50.0
            } else if n1 % 16 > 4 && n1 % 16 <= 12 {
                90.0
            } else {
                130.0
            };
            (exp_x, exp_y, exp_f)
        }
    }
}

fn read_f32s(allocation: &crate::vk::mem_util::Allocation<'_>, count: usize) -> Vec<f32> {
    unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<f32>(), count) }.to_vec()
}

fn read_u32s(allocation: &crate::vk::mem_util::Allocation<'_>, count: usize) -> Vec<u32> {
    unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), count) }.to_vec()
}

fn compare_exact(name: &str, expected: &[f32], got: &[f32]) -> bool {
    let mut matches = true;
    for (ndx, (exp, out)) in expected.iter().zip(got).enumerate() {
        if exp != out {
            matches = false;
            log::error!("{name} got: {out} expected: {exp} at position {ndx}");
        }
    }
    matches
}

/// `ComputeShaderDerivativeInstance::checkResult`
fn check_result(params: &Params, buffers: &[BufferWithMemory<'_>]) -> bool {
    let mut output_matches = true;

    match params.test_type {
        TestType::DerivativeValue => {
            let elem_count = (params.total_invocations() * data_aligned_component_count(params.data_type)) as usize;

            let mut exp_x = vec![0.0f32; elem_count];
            let mut exp_y = vec![0.0f32; elem_count];
            let mut exp_f = vec![0.0f32; elem_count];

            let fine_linear = params.variant == DerivativeVariant::Fine && params.feature == DerivativeFeature::Linear;
            for ndx in 0..elem_count {
                if fine_linear {
                    let (x, y, f) = fine_linear_expected(params.data_type, ndx as u32);
                    exp_x[ndx] = x;
                    exp_y[ndx] = y;
                    exp_f[ndx] = f;
                } else {
                    exp_x[ndx] = 10.0;
                    exp_y[ndx] = 20.0;
                    exp_f[ndx] = 30.0;

                    if (ndx + 1) % 4 == 0 && params.data_type == DataType::Vec3Float32 {
                        exp_x[ndx] = 0.0;
                        exp_y[ndx] = 0.0;
                        exp_f[ndx] = 0.0;
                    }
                }
            }

            let out_x = read_f32s(buffers[0].get_allocation(), elem_count);
            let out_y = read_f32s(buffers[1].get_allocation(), elem_count);
            let out_f = read_f32s(buffers[2].get_allocation(), elem_count);

            output_matches &= compare_exact("OutputBufferX", &exp_x, &out_x);
            output_matches &= compare_exact("OutputBufferY", &exp_y, &out_y);
            output_matches &= compare_exact("OutputBufferF", &exp_f, &out_f);
        }
        TestType::VerifyNdx => {
            let elem_count = params.total_invocations() as usize;
            let width = params.num_workgroup[0];

            let mut exp_i = vec![0u32; elem_count];
            if params.feature == DerivativeFeature::Linear {
                for (ndx, exp) in exp_i.iter_mut().enumerate() {
                    *exp = ndx as u32 % 4;
                }
            }

            if params.feature == DerivativeFeature::Quads {
                for ndy in 0..params.num_workgroup[1] {
                    let odd = ndy % 2 == 0;
                    for ndx in 0..width {
                        let linear_ndx = (ndy * width + ndx) as usize;
                        exp_i[linear_ndx] = if odd { ndx % 2 } else { 2 + (ndx % 2) };
                    }
                }
            }

            let out_s = read_u32s(buffers[0].get_allocation(), elem_count);
            let out_i = read_u32s(buffers[1].get_allocation(), elem_count);

            for ndx in 0..elem_count {
                if exp_i[ndx] != out_i[ndx] {
                    output_matches = false;
                    log::error!(
                        "gl_SubgroupInvocationID got: {} expected: {} at position {}",
                        out_i[ndx],
                        exp_i[ndx],
                        ndx
                    );
                }
            }

            for ndy in 0..params.num_workgroup[1] {
                for ndx in 0..width {
                    let linear_ndx = (ndy * width + ndx) as usize;
                    let elem0_ndx = if params.feature == DerivativeFeature::Linear {
                        linear_ndx & !3
                    } else {
                        ((ndy & !1) * width + (ndx & !1)) as usize
                    };

                    if out_s[linear_ndx] != out_s[elem0_ndx] {
                        output_matches = false;
                        log::error!(
                            "Element ({}, {}) is subgroup {} but element 0 of the quad is subgroup {}",
                            ndx,
                            ndy,
                            out_s[linear_ndx],
                            out_s[elem0_ndx]
                        );
                    }
                }
            }
        }
        TestType::QuadOperations => {
            let elem_count = (params.total_invocations() * data_aligned_component_count(params.data_type)) as usize;

            let exp0 = if params.quad_op == QuadOp::Broadcast {
                (0..elem_count)
                    .map(|ndx| {
                        if (ndx + 1) % 4 == 0 && params.data_type == DataType::Vec3Float32 {
                            0.0
                        } else {
                            10.0 * params.quad_ndx as f32
                        }
                    })
                    .collect()
            } else {
                swapped_values(params.quad_ndx, elem_count, params.data_type, params.feature)
            };

            let out0 = read_f32s(buffers[0].get_allocation(), elem_count);
            output_matches &= compare_exact("OutputBufferX", &exp0, &out0);
        }
        TestType::LodSample => {
            let elem_count =
                (params.total_invocations() * data_aligned_component_count(DataType::Vec4Float32)) as usize;

            let mut exp0 = vec![0.0f32; elem_count];
            for ndx in (0..elem_count).step_by(4) {
                exp0[ndx..ndx + 4].copy_from_slice(&CLR_COLORS[params.mip_lvl as usize]);
            }

            let out0 = read_f32s(buffers[0].get_allocation(), elem_count);
            output_matches &= compare_exact("OutputBuffer", &exp0, &out0);
        }
        TestType::LodQuery => {
            let elem_count =
                (params.total_invocations() * data_aligned_component_count(DataType::Vec2Float32)) as usize;

            let (lod_min, lod_max): (f32, f32) = if params.feature == DerivativeFeature::Linear {
                if params.mip_lvl == 0 {
                    (0.3561, 0.8561)
                } else {
                    (0.6781, 1.1781)
                }
            } else if params.mip_lvl == 0 {
                (-0.6439, 0.8561)
            } else {
                (0.6781, 2.1781)
            };

            let lod_threshold = 0.015f32 + (lod_max - lod_min) / 2.0;

            let exp0: Vec<f32> = (0..elem_count)
                .map(|ndx| {
                    if ndx % 2 == 0 {
                        params.mip_lvl as f32
                    } else {
                        (lod_min + lod_max) / 2.0
                    }
                })
                .collect();

            let out0 = read_f32s(buffers[0].get_allocation(), elem_count);

            for ndx in 0..elem_count {
                if ndx % 2 == 0 {
                    if exp0[ndx] != out0[ndx] {
                        output_matches = false;
                        log::error!(
                            "OutputBuffer got: {} expected: {} at position {}",
                            out0[ndx],
                            exp0[ndx],
                            ndx
                        );
                    }
                } else if !compare_floats(exp0[ndx], out0[ndx], lod_threshold) {
                    output_matches = false;
                    log::error!(
                        "OutputBuffer got: {} expected range from: {} to {} at position {}",
                        out0[ndx],
                        exp0[ndx] - lod_threshold,
                        exp0[ndx] + lod_threshold,
                        ndx
                    );
                }
            }
        }
    }

    output_matches
}

struct ComputeShaderDerivativeCase {
    name: String,
    params: Params,
    programs: BinaryCollection,
}

impl TestCase for ComputeShaderDerivativeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ComputeShaderDerivativeCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        context.require_device_functionality("VK_KHR_compute_shader_derivatives")?;

        let mut derivatives_features = vk::PhysicalDeviceComputeShaderDerivativesFeaturesKHR::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut derivatives_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if params.feature == DerivativeFeature::Linear {
            if derivatives_features.compute_derivative_group_linear == vk::FALSE {
                return Err(TestError::NotSupported(
                    "computeDerivativeGroupLinear feature is not supported".to_string(),
                ));
            }
        } else if derivatives_features.compute_derivative_group_quads == vk::FALSE {
            return Err(TestError::NotSupported(
                "computeDerivativeGroupQuads feature is not supported".to_string(),
            ));
        }

        if params.shader_type != ShaderType::Compute {
            let mut derivative_props = vk::PhysicalDeviceComputeShaderDerivativesPropertiesKHR::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut derivative_props);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }

            if derivative_props.mesh_and_task_shader_derivatives == vk::FALSE {
                return Err(TestError::NotSupported(
                    "derivative operations in mesh and task shader are not supported".to_string(),
                ));
            }

            context.require_device_functionality("VK_EXT_mesh_shader")?;

            let mesh_feature = mesh_shader_features(context);

            if params.shader_type == ShaderType::Mesh {
                if mesh_feature.mesh_shader == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "mesh shader feature is not supported".to_string(),
                    ));
                }
            } else if params.shader_type == ShaderType::Task {
                if mesh_feature.mesh_shader == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "mesh shader feature is not supported".to_string(),
                    ));
                }

                if mesh_feature.task_shader == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "task shader feature is not supported".to_string(),
                    ));
                }
            }
        }

        if params.test_type == TestType::VerifyNdx || params.test_type == TestType::QuadOperations {
            if context.api_version() < (1, 1, 0) {
                return Err(TestError::NotSupported("Profile not supported".to_string()));
            }

            let mut subgroup_props = vk::PhysicalDeviceSubgroupProperties::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_props);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }

            if !subgroup_props
                .supported_operations
                .contains(vk::SubgroupFeatureFlags::BASIC)
            {
                return Err(TestError::NotSupported(
                    "basic subgroup operations are not supported".to_string(),
                ));
            }

            if params.test_type == TestType::QuadOperations
                && !subgroup_props
                    .supported_operations
                    .contains(vk::SubgroupFeatureFlags::QUAD)
            {
                return Err(TestError::NotSupported("quad operations are not supported".to_string()));
            }

            if !subgroup_props
                .supported_stages
                .contains(shader_stage_flag_bits(params.shader_type))
            {
                return Err(TestError::NotSupported(format!(
                    "requested subgroup operations are not supported in {} stage",
                    shader_type_name(params.shader_type)
                )));
            }

            if params.test_type == TestType::VerifyNdx && params.num_workgroup[0] % subgroup_props.subgroup_size != 0 {
                return Err(TestError::NotSupported(format!(
                    "workgroup X dimension ({}) is not a multiple of subgroupSize ({})",
                    params.num_workgroup[0], subgroup_props.subgroup_size
                )));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ComputeShaderDerivativeInstance {
            context,
            params: &self.params,
        })
    }
}

struct ComputeShaderDerivativeInstance<'a> {
    context: &'a Context<'a>,
    params: &'a Params,
}

impl ComputeShaderDerivativeInstance<'_> {
    /// `createComputePipeline`
    fn create_compute_pipeline(
        &self,
        layout: vk::PipelineLayout,
        module: vk::ShaderModule,
        force_full_subgroup: bool,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let subgroup_flags = if force_full_subgroup {
            vk::PipelineShaderStageCreateFlags::REQUIRE_FULL_SUBGROUPS
        } else {
            vk::PipelineShaderStageCreateFlags::empty()
        };

        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .flags(subgroup_flags)
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(layout)
            .base_pipeline_index(0)
            .build();

        Ok(Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        ))
    }

    /// `createGraphicsPipeline`
    #[allow(clippy::too_many_arguments)]
    fn create_graphics_pipeline(
        &self,
        layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
        viewport: vk::Viewport,
        scissor: vk::Rect2D,
        fragment_module: vk::ShaderModule,
        task_module: vk::ShaderModule,
        mesh_module: vk::ShaderModule,
        force_full_subgroup: bool,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let subgroup_flags = if force_full_subgroup {
            vk::PipelineShaderStageCreateFlags::REQUIRE_FULL_SUBGROUPS
        } else {
            vk::PipelineShaderStageCreateFlags::empty()
        };

        let mut stage_infos = Vec::new();
        if fragment_module != vk::ShaderModule::null() {
            stage_infos.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(fragment_module)
                    .name(b"main\0")
                    .build(),
            );
        }
        if task_module != vk::ShaderModule::null() {
            stage_infos.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .flags(subgroup_flags)
                    .stage(vk::ShaderStageFlags::TASK_EXT)
                    .module(task_module)
                    .name(b"main\0")
                    .build(),
            );
        }
        if mesh_module != vk::ShaderModule::null() {
            stage_infos.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .flags(subgroup_flags)
                    .stage(vk::ShaderStageFlags::MESH_EXT)
                    .module(mesh_module)
                    .name(b"main\0")
                    .build(),
            );
        }

        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
        let viewports = [viewport];
        let scissors = [scissor];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .sample_shading_enable(false)
            .min_sample_shading(1.0)
            .alpha_to_coverage_enable(false)
            .alpha_to_one_enable(false);
        let stencil_op_state = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::KEEP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::NEVER,
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(false)
            .depth_write_enable(false)
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&color_blend_attachments)
            .blend_constants([0.0; 4]);

        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stage_infos)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(0)
            .base_pipeline_index(0)
            .build();

        Ok(Unique::new(
            device,
            unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateGraphicsPipelines")?
                .0[0],
        ))
    }
}

impl TestInstance for ComputeShaderDerivativeInstance<'_> {
    /// `ComputeShaderDerivativeInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_index = context.get_universal_queue_family_index();
        let pipeline_stage = pipeline_stage_flag_bits(params.shader_type);

        let cmd_pool = make_command_pool(device, queue_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let buffer_size = calculate_buffer_size(params.test_type, params.num_workgroup, params.data_type);
        let mut buffers = Vec::with_capacity(4);
        for _ in 0..4 {
            buffers.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    vk::DeviceSize::from(buffer_size),
                    vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }
        let buffer_infos: Vec<vk::DescriptorBufferInfo> = buffers
            .iter()
            .map(|buffer| vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            })
            .collect();

        let sampled_image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: image_type(params.feature),
            format: SAMPLED_FORMAT,
            extent: image_extent(params.feature),
            mip_levels: MIP_LEVEL_COUNT,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let sampled_image = ImageWithMemory::new(device, allocator, sampled_image_info, MemoryRequirement::ANY)?;
        let sampled_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, MIP_LEVEL_COUNT, 0, 1);
        let sampled_view = make_image_view(
            device,
            sampled_image.get(),
            image_view_type(params.feature),
            SAMPLED_FORMAT,
            sampled_srr,
        )?;

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(1.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let image_sampler_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *sampled_view,
            image_layout: vk::ImageLayout::READ_ONLY_OPTIMAL,
        };

        let stage_flags = shader_stage_flag_bits(params.shader_type);
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..4 {
            layout_builder = layout_builder.add_single_binding(vk::DescriptorType::STORAGE_BUFFER, stage_flags);
        }
        layout_builder = layout_builder.add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, stage_flags);
        let descriptor_set_layout = layout_builder.build(device)?;
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 4)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let mut writes: Vec<vk::WriteDescriptorSet> = buffer_infos
            .iter()
            .enumerate()
            .map(|(binding, info)| vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: binding as u32,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: std::ptr::from_ref(info),
                texel_buffer_view: std::ptr::null(),
            })
            .collect();
        writes.push(vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 4,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            image_info: std::ptr::from_ref(&image_sampler_info),
            buffer_info: std::ptr::null(),
            texel_buffer_view: std::ptr::null(),
        });
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let binaries = context.get_binary_collection();
        let force_full_subgroup = params.test_type == TestType::VerifyNdx;

        let compute_module;
        let fragment_module;
        let mesh_module;
        let task_module;
        let render_target;
        let render_target_view;
        let render_pass;
        let framebuffer;
        let pipeline;
        let render_area = rect_2d(EXTENT.width, EXTENT.height);
        let is_compute = params.shader_type == ShaderType::Compute;

        if is_compute {
            compute_module = Some(create_shader_module(device, binaries.get("compute")?)?);
            fragment_module = None;
            mesh_module = None;
            task_module = None;
            render_target = None;
            render_target_view = None;
            render_pass = None;
            framebuffer = None;
            pipeline = self.create_compute_pipeline(
                *pipeline_layout,
                **compute_module.as_ref().expect("the compute module was just made"),
                force_full_subgroup,
            )?;
        } else {
            compute_module = None;
            let render_target_info = vk::ImageCreateInfo {
                s_type: vk::StructureType::IMAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::ImageCreateFlags::empty(),
                image_type: vk::ImageType::_2D,
                format: RENDER_TARGET_FORMAT,
                extent: EXTENT,
                mip_levels: 1,
                array_layers: 1,
                samples: vk::SampleCountFlags::_1,
                tiling: vk::ImageTiling::OPTIMAL,
                usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
                sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 0,
                queue_family_indices: std::ptr::null(),
                initial_layout: vk::ImageLayout::UNDEFINED,
            };
            let target = ImageWithMemory::new(device, allocator, render_target_info, MemoryRequirement::ANY)?;
            let target_view = make_image_view(
                device,
                target.get(),
                vk::ImageViewType::_2D,
                RENDER_TARGET_FORMAT,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?;
            let pass = make_render_pass(device, RENDER_TARGET_FORMAT)?;
            let fb = make_framebuffer(device, *pass, &[*target_view], EXTENT.width, EXTENT.height, 1)?;

            fragment_module = Some(create_shader_module(device, binaries.get("fragment")?)?);
            mesh_module = Some(create_shader_module(device, binaries.get("mesh")?)?);
            task_module = if params.shader_type == ShaderType::Task {
                Some(create_shader_module(device, binaries.get("task")?)?)
            } else {
                None
            };
            pipeline = self.create_graphics_pipeline(
                *pipeline_layout,
                *pass,
                viewport(0.0, 0.0, EXTENT.width as f32, EXTENT.height as f32, 0.0, 1.0),
                render_area,
                **fragment_module.as_ref().expect("the fragment module was just made"),
                task_module.as_ref().map_or(vk::ShaderModule::null(), |module| **module),
                **mesh_module.as_ref().expect("the mesh module was just made"),
                force_full_subgroup,
            )?;
            render_target = Some(target);
            render_target_view = Some(target_view);
            render_pass = Some(pass);
            framebuffer = Some(fb);
        }

        let buf_barrier = |src: vk::AccessFlags, dst: vk::AccessFlags, buffer: vk::Buffer| {
            vk::BufferMemoryBarrier::builder()
                .src_access_mask(src)
                .dst_access_mask(dst)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(buffer)
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build()
        };

        begin_command_buffer(device, cmd)?;
        unsafe {
            for buffer in &buffers {
                let pre_clear = buf_barrier(vk::AccessFlags::empty(), vk::AccessFlags::TRANSFER_WRITE, buffer.get());
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[pre_clear],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                device.cmd_fill_buffer(cmd, buffer.get(), 0, vk::WHOLE_SIZE, 0);
                let post_clear = buf_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::SHADER_WRITE,
                    buffer.get(),
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    pipeline_stage,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[post_clear],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            let pre_clear_image = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                sampled_image.get(),
                sampled_srr,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_clear_image],
            );
            for (mip, color) in CLR_COLORS.iter().enumerate() {
                let clear_color = vk::ClearColorValue { float32: *color };
                let mip_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, mip as u32, 1, 0, 1);
                device.cmd_clear_color_image(
                    cmd,
                    sampled_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color,
                    &[mip_srr],
                );
            }
            let post_clear_image = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                sampled_image.get(),
                sampled_srr,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                pipeline_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_clear_image],
            );

            if is_compute {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd, 1, 1, 1);
            } else {
                begin_render_pass(
                    device,
                    cmd,
                    **render_pass.as_ref().expect("a graphics case has a render pass"),
                    **framebuffer.as_ref().expect("a graphics case has a framebuffer"),
                    render_area,
                    clear_value_color(CLR_COLOR),
                );
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
                end_render_pass(device, cmd);
            }

            for buffer in &buffers {
                let to_host = buf_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer.get());
                device.cmd_pipeline_barrier(
                    cmd,
                    pipeline_stage,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[to_host],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        for buffer in &buffers {
            invalidate_alloc(device, buffer.get_allocation())?;
        }
        let _ = (
            &render_target,
            &render_target_view,
            &compute_module,
            &fragment_module,
            &mesh_module,
            &task_module,
        );

        if check_result(params, &buffers) {
            Ok(TestStatus::pass("Passed"))
        } else {
            Ok(TestStatus::fail("Failed"))
        }
    }
}

/// `createComputeShaderDerivativesTests` as the groups of its path below `compute` and the test case.
pub fn create_compute_shader_derivatives_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_COMPUTE_SHADER_DERIVATIVES_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            let test_case: Box<dyn TestCase> = Box::new(ComputeShaderDerivativeCase {
                name: leaf.to_string(),
                params: Params::from_case(case),
                programs: case.programs,
            });
            (segments, test_case)
        })
        .collect()
}
