// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp / vktSubgroupsTestsUtils.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device queries, the input data types and `initializeMemory`; the shaders upstream
// builds in `initStdPrograms` are written ahead of time by `scripts/gen_subgroups_compute_manifest.py`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::float::Float16;
use crate::tcu::{Random, TestError};
use crate::vk::mem_util::{Allocation, flush_alloc};
use crate::vkt::Context;

/// `maxSupportedSubgroupSize`
pub const MAX_SUPPORTED_SUBGROUP_SIZE: u32 = 128;

/// The scalar of a `VecType`, spelled as in the `type=` token of a case spec.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Scalar {
    Int8,
    Uint8,
    Int16,
    Uint16,
    Int32,
    Uint32,
    Int64,
    Uint64,
    Float16,
    Float32,
    Float64,
    Bool,
}

impl Scalar {
    pub fn from_token(token: &str) -> Self {
        match token {
            "i8" => Self::Int8,
            "u8" => Self::Uint8,
            "i16" => Self::Int16,
            "u16" => Self::Uint16,
            "i32" => Self::Int32,
            "u32" => Self::Uint32,
            "i64" => Self::Int64,
            "u64" => Self::Uint64,
            "f16" => Self::Float16,
            "f32" => Self::Float32,
            "f64" => Self::Float64,
            "b32" => Self::Bool,
            _ => panic!("subgroup spec with an unknown type {token}"),
        }
    }
}

/// `VecType`
#[derive(Clone, Copy, Debug)]
pub struct VecType {
    pub scalar: Scalar,
    pub components: u32,
}

impl VecType {
    /// `getFormatSizeInBytes(VecType)`: a three component vector is as big as a four component one.
    pub fn size_in_bytes(self) -> u32 {
        let components = if self.components == 3 { 4 } else { self.components };
        let scalar_bytes = match self.scalar {
            Scalar::Int8 | Scalar::Uint8 => 1,
            Scalar::Int16 | Scalar::Uint16 | Scalar::Float16 => 2,
            Scalar::Int32 | Scalar::Uint32 | Scalar::Float32 | Scalar::Bool => 4,
            Scalar::Int64 | Scalar::Uint64 | Scalar::Float64 => 8,
        };
        components * scalar_bytes
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum InitializeType {
    None,
    NonZero,
    Zero,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Layout {
    Std140,
    Std430,
    Packed,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BindingType {
    Ssbo,
    Image,
    Ubo,
}

/// `SSBOData`: one input of a test shader.
#[derive(Clone, Copy, Debug)]
pub struct SsboData {
    pub initialize_type: InitializeType,
    pub layout: Layout,
    pub vec_type: VecType,
    pub num_elements: u64,
    pub binding_type: BindingType,
}

impl SsboData {
    /// One entry of the `inputs=` list of a case spec: `<init>:<layout>:<type>:<components>:<count>[:<binding type>]`.
    pub fn parse(entry: &str) -> Self {
        let parts: Vec<&str> = entry.split(':').collect();
        let initialize_type = match parts[0] {
            "none" => InitializeType::None,
            "nonzero" => InitializeType::NonZero,
            "zero" => InitializeType::Zero,
            other => panic!("subgroup spec with an unknown initialization {other}"),
        };
        let layout = match parts[1] {
            "std140" => Layout::Std140,
            "std430" => Layout::Std430,
            "packed" => Layout::Packed,
            other => panic!("subgroup spec with an unknown layout {other}"),
        };
        let binding_type = match parts.get(5).copied().unwrap_or("ssbo") {
            "ssbo" => BindingType::Ssbo,
            "ubo" => BindingType::Ubo,
            "image" => BindingType::Image,
            other => panic!("subgroup spec with an unknown binding type {other}"),
        };
        Self {
            initialize_type,
            layout,
            vec_type: VecType {
                scalar: Scalar::from_token(parts[2]),
                components: parts[3].parse().expect("component count"),
            },
            num_elements: parts[4].parse().expect("element count"),
            binding_type,
        }
    }

    pub fn is_ubo(&self) -> bool {
        self.binding_type == BindingType::Ubo
    }

    /// `getElementSizeInBytes(VecType, layout)`
    pub fn element_size_in_bytes(&self) -> u64 {
        let bytes = u64::from(self.vec_type.size_in_bytes());
        if self.layout == Layout::Std140 {
            bytes.max(16)
        } else {
            bytes
        }
    }

    pub fn size_in_bytes(&self) -> u64 {
        self.element_size_in_bytes() * self.num_elements
    }
}

/// The three feature structs `isFormatSupportedForDevice` reads, with the extensions that make them valid to ask for.
struct FormatFeatures {
    subgroup_extended_types: bool,
    shader_float16: bool,
    shader_int8: bool,
    storage_buffer_16bit: bool,
    storage_buffer_8bit: bool,
}

fn format_features(context: &Context<'_>) -> FormatFeatures {
    let mut result = FormatFeatures {
        subgroup_extended_types: false,
        shader_float16: false,
        shader_int8: false,
        storage_buffer_16bit: false,
        storage_buffer_8bit: false,
    };

    if context.is_device_functionality_supported("VK_KHR_shader_subgroup_extended_types")
        && context.is_device_functionality_supported("VK_KHR_shader_float16_int8")
    {
        let mut extended_types = vk::PhysicalDeviceShaderSubgroupExtendedTypesFeatures::default();
        let mut float16_int8 = vk::PhysicalDeviceShaderFloat16Int8Features::default();
        let mut storage16 = vk::PhysicalDevice16BitStorageFeatures::default();
        let mut storage8 = vk::PhysicalDevice8BitStorageFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut extended_types)
                .push_next(&mut float16_int8);
            if context.is_device_functionality_supported("VK_KHR_16bit_storage") {
                features2 = features2.push_next(&mut storage16);
            }
            if context.is_device_functionality_supported("VK_KHR_8bit_storage") {
                features2 = features2.push_next(&mut storage8);
            }
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        result.subgroup_extended_types = extended_types.shader_subgroup_extended_types != vk::FALSE;
        result.shader_float16 = float16_int8.shader_float16 != vk::FALSE;
        result.shader_int8 = float16_int8.shader_int8 != vk::FALSE;
        result.storage_buffer_16bit = storage16.storage_buffer_16bit_access != vk::FALSE;
        result.storage_buffer_8bit = storage8.storage_buffer_8bit_access != vk::FALSE;
    }
    result
}

/// `isFormatSupportedForDevice`
pub fn is_format_supported_for_device(context: &Context<'_>, vec_type: VecType) -> Result<bool, TestError> {
    let features = context.get_device_features();
    let extended = format_features(context);

    if vec_type.components > 4 {
        context.require_device_functionality("VK_EXT_shader_long_vector")?;
        let mut long_vector = vk::PhysicalDeviceShaderLongVectorFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut long_vector);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if long_vector.long_vector == vk::FALSE {
            return Err(TestError::NotSupported("longVector not supported".to_string()));
        }
    }

    Ok(match vec_type.scalar {
        Scalar::Float16 => extended.subgroup_extended_types && extended.shader_float16 && extended.storage_buffer_16bit,
        Scalar::Float64 => features.shader_float64 != vk::FALSE,
        Scalar::Int8 | Scalar::Uint8 => {
            extended.subgroup_extended_types && extended.shader_int8 && extended.storage_buffer_8bit
        }
        Scalar::Int16 | Scalar::Uint16 => {
            extended.subgroup_extended_types && features.shader_int16 != vk::FALSE && extended.storage_buffer_16bit
        }
        Scalar::Int64 | Scalar::Uint64 => extended.subgroup_extended_types && features.shader_int64 != vk::FALSE,
        _ => true,
    })
}

/// `context.getSubgroupProperties()`
pub fn subgroup_properties(context: &Context<'_>) -> vk::PhysicalDeviceSubgroupProperties {
    let mut subgroup = vk::PhysicalDeviceSubgroupProperties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    subgroup
}

/// `context.getSubgroupSizeControlProperties()`
pub fn subgroup_size_control_properties(context: &Context<'_>) -> vk::PhysicalDeviceSubgroupSizeControlProperties {
    let mut size_control = vk::PhysicalDeviceSubgroupSizeControlProperties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut size_control);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    size_control
}

/// `context.getSubgroupSizeControlFeatures()`
pub fn subgroup_size_control_features(context: &Context<'_>) -> vk::PhysicalDeviceSubgroupSizeControlFeatures {
    let mut size_control = vk::PhysicalDeviceSubgroupSizeControlFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut size_control);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    size_control
}

/// `isSubgroupSupported`
pub fn is_subgroup_supported(context: &Context<'_>) -> bool {
    context.api_version() >= (1, 1, 0)
}

/// `isSubgroupFeatureSupportedForDevice`
pub fn is_subgroup_feature_supported_for_device(context: &Context<'_>, bit: vk::SubgroupFeatureFlags) -> bool {
    subgroup_properties(context).supported_operations.intersects(bit)
}

/// `is16BitUBOStorageSupported`
pub fn is_16bit_ubo_storage_supported(context: &Context<'_>) -> bool {
    let mut storage16 = vk::PhysicalDevice16BitStorageFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut storage16);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    storage16.uniform_and_storage_buffer_16bit_access != vk::FALSE
}

/// `is8BitUBOStorageSupported`
pub fn is_8bit_ubo_storage_supported(context: &Context<'_>) -> bool {
    let mut storage8 = vk::PhysicalDevice8BitStorageFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut storage8);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    storage8.uniform_and_storage_buffer_8bit_access != vk::FALSE
}

/// `supportedCheckShader`, for a compute stage.
pub fn supported_check_compute_shader(context: &Context<'_>) -> Result<(), TestError> {
    if !subgroup_properties(context)
        .supported_stages
        .intersects(vk::ShaderStageFlags::COMPUTE)
    {
        return Err(TestError::Fail(
            "Compute shader is required to support subgroup operations".to_string(),
        ));
    }
    Ok(())
}

/// `initializeMemory`
pub fn initialize_memory(context: &Context<'_>, alloc: &Allocation<'_>, data: &SsboData) -> Result<(), TestError> {
    let size = data.size_in_bytes() as usize;
    let host = alloc.get_host_ptr();

    if data.initialize_type == InitializeType::NonZero {
        // The base seed of the command line, which defaults to 0.
        let mut rnd = Random::new(0);
        // SAFETY: the buffer was created with `size` bytes and the host pointer maps all of it.
        let bytes = unsafe { std::slice::from_raw_parts_mut(host, size) };

        match data.vec_type.scalar {
            Scalar::Int8 | Scalar::Uint8 => {
                for byte in bytes.iter_mut() {
                    *byte = rnd.get_uint8();
                }
            }
            Scalar::Int16 | Scalar::Uint16 => {
                for chunk in bytes.chunks_exact_mut(2) {
                    chunk.copy_from_slice(&rnd.get_uint16().to_ne_bytes());
                }
            }
            Scalar::Bool => {
                for chunk in bytes.chunks_exact_mut(4) {
                    let r = rnd.get_uint32();
                    chunk.copy_from_slice(&(if r & 1 != 0 { r } else { 0 }).to_ne_bytes());
                }
            }
            Scalar::Int32 | Scalar::Uint32 => {
                for chunk in bytes.chunks_exact_mut(4) {
                    chunk.copy_from_slice(&rnd.get_uint32().to_ne_bytes());
                }
            }
            Scalar::Int64 | Scalar::Uint64 => {
                for chunk in bytes.chunks_exact_mut(8) {
                    chunk.copy_from_slice(&rnd.get_uint64().to_ne_bytes());
                }
            }
            Scalar::Float16 => {
                for chunk in bytes.chunks_exact_mut(2) {
                    chunk.copy_from_slice(&Float16::new(rnd.get_float()).bits().to_ne_bytes());
                }
            }
            Scalar::Float32 => {
                for chunk in bytes.chunks_exact_mut(4) {
                    chunk.copy_from_slice(&rnd.get_float().to_ne_bytes());
                }
            }
            Scalar::Float64 => {
                for chunk in bytes.chunks_exact_mut(8) {
                    chunk.copy_from_slice(&rnd.get_double().to_ne_bytes());
                }
            }
        }
    } else if data.initialize_type == InitializeType::Zero {
        // SAFETY: as above.
        unsafe { std::slice::from_raw_parts_mut(host, size / 4 * 4) }.fill(0);
    }

    if data.initialize_type != InitializeType::None {
        flush_alloc(context.get_device(), alloc)?;
    }
    Ok(())
}

/// `check`: every one of the first `width` verdicts is `reference`.
pub fn check(result: &[u32], width: usize, reference: u32) -> bool {
    result.iter().take(width).all(|&value| value == reference)
}

/// `checkComputeOrMesh`
pub fn check_compute_or_mesh(result: &[u32], num_workgroups: [u32; 3], local_size: [u32; 3], reference: u32) -> bool {
    let global_size_x = num_workgroups[0] * local_size[0];
    let global_size_y = num_workgroups[1] * local_size[1];
    let global_size_z = num_workgroups[2] * local_size[2];
    check(
        result,
        (global_size_x * global_size_y * global_size_z) as usize,
        reference,
    )
}

/// `isSubgroupBroadcastDynamicIdSupported`
pub fn is_subgroup_broadcast_dynamic_id_supported(context: &Context<'_>) -> bool {
    if context.api_version() < (1, 2, 0) {
        return false;
    }
    let mut vulkan12 = vk::PhysicalDeviceVulkan12Features::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan12);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    vulkan12.subgroup_broadcast_dynamic_id != vk::FALSE
}

/// `context.getShaderSubgroupRotateFeatures()`
pub fn subgroup_rotate_features(context: &Context<'_>) -> vk::PhysicalDeviceShaderSubgroupRotateFeatures {
    let mut rotate = vk::PhysicalDeviceShaderSubgroupRotateFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut rotate);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    rotate
}

/// `isSubgroupRotateSpecVersionValid`: the spec version of "VK_KHR_shader_subgroup_rotate" is at least 2.
pub fn is_subgroup_rotate_spec_version_valid(context: &Context<'_>) -> Result<bool, TestError> {
    use std::ffi::CStr;

    use crate::vk::VkResultExt;

    let properties = unsafe {
        context
            .get_instance()
            .enumerate_device_extension_properties(context.get_physical_device(), None)
    }
    .vk_check("vkEnumerateDeviceExtensionProperties")?;
    Ok(!properties.iter().any(|property| {
        let name = unsafe { CStr::from_ptr(property.extension_name.as_ptr()) };
        name.to_bytes() == b"VK_KHR_shader_subgroup_rotate" && property.spec_version < 2
    }))
}

/// The four `check*` functions of the builtin variable tests that read the `uvec4(gl_SubgroupSize, gl_SubgroupInvocationID,
/// gl_NumSubgroups, gl_SubgroupID)` every invocation wrote.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BuiltinVar {
    SubgroupSize,
    SubgroupInvocationId,
    NumSubgroups,
    SubgroupId,
}

impl BuiltinVar {
    pub fn from_token(token: &str) -> Self {
        match token {
            "size" => Self::SubgroupSize,
            "invocation" => Self::SubgroupInvocationId,
            "num" => Self::NumSubgroups,
            "id" => Self::SubgroupId,
            other => panic!("subgroup spec with an unknown builtin {other}"),
        }
    }
}

/// `checkComputeSubgroupSize`, `checkComputeSubgroupInvocationID`, `checkComputeNumSubgroups` and `checkComputeSubgroupID`.
pub fn check_builtin_var(
    builtin: BuiltinVar,
    data: &[u32],
    num_workgroups: [u32; 3],
    local_size: [u32; 3],
    subgroup_size: u32,
) -> bool {
    let global_size_x = num_workgroups[0] * local_size[0];
    let global_size_y = num_workgroups[1] * local_size[1];
    let total_local_size = local_size[0] * local_size[1] * local_size[2];
    let offset_of = |n: [u32; 3], l: [u32; 3]| {
        let x = n[0] * local_size[0] + l[0];
        let y = n[1] * local_size[1] + l[1];
        let z = n[2] * local_size[2] + l[2];
        (global_size_x * (global_size_y * z + y) + x) as usize
    };

    for n_x in 0..num_workgroups[0] {
        for n_y in 0..num_workgroups[1] {
            for n_z in 0..num_workgroups[2] {
                let mut subgroup_invocation_hits = vec![0u32; subgroup_size as usize];
                for l_x in 0..local_size[0] {
                    for l_y in 0..local_size[1] {
                        for l_z in 0..local_size[2] {
                            let offset = offset_of([n_x, n_y, n_z], [l_x, l_y, l_z]);
                            match builtin {
                                BuiltinVar::SubgroupSize => {
                                    if subgroup_size != data[offset * 4] {
                                        return false;
                                    }
                                }
                                BuiltinVar::SubgroupInvocationId => {
                                    let invocation_id = data[offset * 4 + 1];
                                    if invocation_id >= subgroup_size {
                                        return false;
                                    }
                                    subgroup_invocation_hits[invocation_id as usize] += 1;
                                }
                                BuiltinVar::NumSubgroups => {
                                    if data[offset * 4 + 2] > total_local_size {
                                        return false;
                                    }
                                }
                                BuiltinVar::SubgroupId => {
                                    if data[offset * 4 + 3] >= data[offset * 4 + 2] {
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                }
                if builtin == BuiltinVar::SubgroupInvocationId
                    && subgroup_invocation_hits.iter().sum::<u32>() != total_local_size
                {
                    return false;
                }
            }
        }
    }
    true
}

/// `checkVertexPipelineStagesSubgroupSize` and `checkVertexPipelineStagesSubgroupInvocationID`: the pixels of the framebuffer tests hold
/// `uvec4(gl_SubgroupSize, gl_SubgroupInvocationID + 1024, ..)`.
pub fn check_vertex_pipeline_stages_builtin(builtin: BuiltinVar, data: &[u32], width: u32, subgroup_size: u32) -> bool {
    match builtin {
        BuiltinVar::SubgroupSize => (0..width as usize).all(|x| data[x * 4] == subgroup_size),
        BuiltinVar::SubgroupInvocationId => {
            let mut subgroup_invocation_hits = vec![0u32; subgroup_size as usize];
            for x in 0..width as usize {
                let subgroup_invocation_id = data[x * 4 + 1].wrapping_sub(1024);
                if subgroup_invocation_id >= subgroup_size {
                    return false;
                }
                subgroup_invocation_hits[subgroup_invocation_id as usize] += 1;
            }
            subgroup_invocation_hits.iter().sum::<u32>() == width
        }
        BuiltinVar::NumSubgroups | BuiltinVar::SubgroupId => {
            unreachable!("the framebuffer tests only check the first two")
        }
    }
}
