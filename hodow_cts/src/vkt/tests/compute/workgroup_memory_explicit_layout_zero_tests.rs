// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeWorkgroupMemoryExplicitLayoutTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Intel Corporation
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported so far: the `zero` subgroup, all 2200 of its cases. `alias`, `padding`,
// `size`, `copy_memory` and `zero_ext` each carry their own per-case GLSL table and
// are separate work.
//
// Two things outside this file have to change before the group can actually run:
//
//   * The shaders need SPIR-V 1.4. A `shared` block is the SPIR-V
//     WorkgroupMemoryExplicitLayoutKHR capability, and glslang refuses to emit it
//     below 1.4 ("shared block requires at least SPIR-V 1.4"), but
//     scripts/compile_shaders.py hardcodes `--target-env vulkan1.1`, i.e. SPIR-V
//     1.3. All 550 shaders declared in shaders/manifest/compute_wmel_zero.toml
//     compile cleanly once `--target-env spirv1.4` is also passed.
//   * `vkt::Context` builds its device from the core VkPhysicalDeviceFeatures only,
//     so `workgroupMemoryExplicitLayout`, `shaderInt8` and `shaderFloat16` are never
//     enabled even on a device that advertises them. `check_support` below is a
//     faithful port of `checkSupportWithParams` and, like upstream, only queries the
//     *physical* device - so on this port it will pass a case through to a device
//     that was not built to run it.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::compute_wmel_zero;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

// ---------------------------------------------------------------------------------
// glu::DataType, cut down to the values this group uses
// ---------------------------------------------------------------------------------

/// `glu::DataType`.
///
/// Upstream's `AddZeroTests` walks the whole 143-value enum and filters it through
/// `isTestedZeroElementType` / `isTestedFieldType`; only the values one of those two
/// filters accepts are ported. Deliberately local to this file - the rest of the port
/// has no use for `glu::` and sharing a half-ported enum would invite someone to add
/// a value here that another module's name generation then depends on.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DataType {
    Invalid,
    Float,
    FloatVec4,
    Double,
    DoubleVec4,
    Uint,
    UintVec3,
    UintVec4,
    Bool,
    Uint8,
    Uint8Vec4,
    Uint16,
    Float16,
}

/// The ported values, in upstream enum order.
///
/// The order is what makes the registration order - and so the case order in a result
/// file - identical to upstream's, because both loops below walk their enum in index
/// order and the values that are missing here never pass a filter anyway.
const DATA_TYPES: &[DataType] = &[
    DataType::Invalid,
    DataType::Float,
    DataType::FloatVec4,
    DataType::Double,
    DataType::DoubleVec4,
    DataType::Uint,
    DataType::UintVec3,
    DataType::UintVec4,
    DataType::Bool,
    DataType::Uint8,
    DataType::Uint8Vec4,
    DataType::Uint16,
    DataType::Float16,
];

/// `glu::getDataTypeName`
fn get_data_type_name(data_type: DataType) -> &'static str {
    match data_type {
        DataType::Invalid => "invalid",
        DataType::Float => "float",
        DataType::FloatVec4 => "vec4",
        DataType::Double => "double",
        DataType::DoubleVec4 => "dvec4",
        DataType::Uint => "uint",
        DataType::UintVec3 => "uvec3",
        DataType::UintVec4 => "uvec4",
        DataType::Bool => "bool",
        DataType::Uint8 => "uint8_t",
        DataType::Uint8Vec4 => "u8vec4",
        DataType::Uint16 => "uint16_t",
        DataType::Float16 => "float16_t",
    }
}

/// `glu::isDataTypeIntOrIVec8Bit`. No signed 8-bit type passes either filter, so none
/// is ported and this is always false; kept so `use_type` still reads like upstream.
fn is_data_type_int_or_ivec8bit(_data_type: DataType) -> bool {
    false
}

/// `glu::isDataTypeUintOrUVec8Bit`
fn is_data_type_uint_or_uvec8bit(data_type: DataType) -> bool {
    matches!(data_type, DataType::Uint8 | DataType::Uint8Vec4)
}

/// `glu::isDataTypeIntOrIVec16Bit`. As above: no signed 16-bit type is ported.
fn is_data_type_int_or_ivec16bit(_data_type: DataType) -> bool {
    false
}

/// `glu::isDataTypeUintOrUVec16Bit`
fn is_data_type_uint_or_uvec16bit(data_type: DataType) -> bool {
    matches!(data_type, DataType::Uint16)
}

/// `glu::isDataTypeFloat16OrVec`
fn is_data_type_float16_or_vec(data_type: DataType) -> bool {
    matches!(data_type, DataType::Float16)
}

/// `glu::isDataTypeDoubleOrDVec`
fn is_data_type_double_or_dvec(data_type: DataType) -> bool {
    matches!(data_type, DataType::Double | DataType::DoubleVec4)
}

// `glu::getDataTypeLiteral` has no counterpart here: it only ever fed the GLSL that
// `initPrograms` built, and that expansion now lives in compute_wmel_zero.toml, which
// is the one place a test parameter is allowed to be written down.

// ---------------------------------------------------------------------------------
// checkSupportWithParams
// ---------------------------------------------------------------------------------

/// `CheckSupportParams`
struct CheckSupportParams {
    needs_scalar: bool,
    needs_int8: bool,
    needs_int16: bool,
    needs_int64: bool,
    needs_float16: bool,
    needs_float64: bool,
    compute_pipeline_construction_type: ComputePipelineConstructionType,
}

impl CheckSupportParams {
    /// `CheckSupportParams::useType`
    fn use_type(&mut self, dt: DataType) {
        self.needs_int8 |= is_data_type_int_or_ivec8bit(dt) || is_data_type_uint_or_uvec8bit(dt);
        self.needs_int16 |= is_data_type_int_or_ivec16bit(dt) || is_data_type_uint_or_uvec16bit(dt);
        self.needs_float16 |= is_data_type_float16_or_vec(dt);
        self.needs_float64 |= is_data_type_double_or_dvec(dt);
    }
}

/// `checkSupportWithParams`
///
/// `VK_KHR_spirv_1_4` was promoted to core in Vulkan 1.2, and upstream's
/// `isDeviceFunctionalitySupported` takes that into account against the API version it
/// actually uses. This port asks for instance API 1.1, at which the extension is not
/// core yet, so the plain extension-list check is the same test upstream would make.
fn check_support_with_params(context: &Context<'_>, params: &CheckSupportParams) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_workgroup_memory_explicit_layout")?;
    context.require_device_functionality("VK_KHR_spirv_1_4")?;
    check_shader_object_requirements(params.compute_pipeline_construction_type)?;

    let mut layout_features = vk::PhysicalDeviceWorkgroupMemoryExplicitLayoutFeaturesKHR::default();
    let mut f16_i8_features = vk::PhysicalDeviceShaderFloat16Int8Features {
        next: (&raw mut layout_features).cast(),
        ..Default::default()
    };
    let mut features2 = vk::PhysicalDeviceFeatures2 {
        next: (&raw mut f16_i8_features).cast(),
        ..Default::default()
    };
    unsafe {
        context.get_instance().get_physical_device_features2(context.get_physical_device(), &mut features2);
    }

    if params.needs_scalar && layout_features.workgroup_memory_explicit_layout_scalar_block_layout != vk::TRUE {
        return Err(TestError::NotSupported("workgroupMemoryExplicitLayoutScalarBlockLayout not supported".to_string()));
    }

    if params.needs_int8 {
        if f16_i8_features.shader_int8 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt8 not supported".to_string()));
        }
        if layout_features.workgroup_memory_explicit_layout_8bit_access != vk::TRUE {
            return Err(TestError::NotSupported("workgroupMemoryExplicitLayout8BitAccess not supported".to_string()));
        }
    }

    if params.needs_int16 {
        if features2.features.shader_int16 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt16 not supported".to_string()));
        }
        if layout_features.workgroup_memory_explicit_layout_16bit_access != vk::TRUE {
            return Err(TestError::NotSupported("workgroupMemoryExplicitLayout16BitAccess not supported".to_string()));
        }
    }

    if params.needs_int64 && features2.features.shader_int64 != vk::TRUE {
        return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
    }

    if params.needs_float16 {
        if f16_i8_features.shader_float16 != vk::TRUE {
            return Err(TestError::NotSupported("shaderFloat16 not supported".to_string()));
        }
        if layout_features.workgroup_memory_explicit_layout_16bit_access != vk::TRUE {
            return Err(TestError::NotSupported("workgroupMemoryExplicitLayout16BitAccess not supported".to_string()));
        }
    }

    if params.needs_float64 && features2.features.shader_float64 != vk::TRUE {
        return Err(TestError::NotSupported("shaderFloat64 not supported".to_string()));
    }

    Ok(())
}

// ---------------------------------------------------------------------------------
// runCompute
// ---------------------------------------------------------------------------------

/// `runCompute` - the helper every test in this file dispatches through.
///
/// No pipeline barrier before the host read, exactly as upstream: the wait on the
/// submitted fence plus `invalidateAlloc` is all it does.
fn run_compute(
    context: &Context<'_>,
    workgroup_size: u32,
    compute_pipeline_construction_type: ComputePipelineConstructionType,
    queue: vk::Queue,
    queue_family_index: u32,
) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();

    let size = std::mem::size_of::<u32>() as u64 * u64::from(workgroup_size);

    let buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
    )?;
    let buffer_descriptor = make_descriptor_buffer_info(buffer.get(), 0, size);

    let ptr = buffer.get_allocation().get_host_ptr().cast::<u32>();

    // 0xff everywhere, so a shader that writes nothing cannot pass by accident.
    unsafe { std::ptr::write_bytes(ptr.cast::<u8>(), 0xff, size as usize) };

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(vk)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

    let bind_point = vk::PipelineBindPoint::COMPUTE;
    flush_alloc(vk, buffer.get_allocation())?;

    let mut pipeline = ComputePipelineWrapper::new(vk, compute_pipeline_construction_type, context.get_binary_collection().get("comp")?);
    pipeline.set_descriptor_set_layout(*descriptor_set_layout);
    pipeline.build_pipeline()?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    DescriptorSetUpdateBuilder::new()
        .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer_descriptor)
        .update(vk);

    begin_command_buffer(vk, *cmd_buffer)?;

    unsafe {
        vk.cmd_bind_descriptor_sets(*cmd_buffer, bind_point, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
    }
    pipeline.bind(*cmd_buffer);

    unsafe {
        vk.cmd_dispatch(*cmd_buffer, 1, 1, 1);
    }

    end_command_buffer(vk, *cmd_buffer)?;

    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    invalidate_alloc(vk, buffer.get_allocation())?;
    for i in 0..workgroup_size {
        let expected = i;
        let got = unsafe { *ptr.add(i as usize) };
        if got != expected {
            log::error!("failure at index {i}: expected {expected}, got: {got}");
            return Ok(TestStatus::fail("compute failed"));
        }
    }

    Ok(TestStatus::pass("compute succeeded"))
}

// ---------------------------------------------------------------------------------
// ZeroTest
// ---------------------------------------------------------------------------------

/// One shader from the manifest, shared by the four `_array_1` .. `_array_4` cases of
/// a single (zeroElementType, fieldType[0], fieldType[1]) triple.
///
/// `CaseDef::elements` never reaches upstream's `initPrograms` - it only ever appears
/// in `testName()` - so those four cases genuinely run identical SPIR-V.
pub struct ZeroProgram {
    pub name: &'static str,
    pub zero_element_type: DataType,
    pub field_type_0: DataType,
    pub field_type_1: DataType,
    pub programs: BinaryCollection,
}

/// Every shader `compute_wmel_zero.toml` declares. The types are baked into the GLSL
/// and GLSL cannot select a type at pipeline-creation time, so this cannot collapse
/// any further: 550 shaders for 2200 cases is the floor.
#[rustfmt::skip]
static ZERO_PROGRAMS: &[&ZeroProgram] = &[
    &compute_wmel_zero::UINT_TO_FLOAT,
    &compute_wmel_zero::UINT_TO_VEC4,
    &compute_wmel_zero::UINT_TO_DOUBLE,
    &compute_wmel_zero::UINT_TO_DVEC4,
    &compute_wmel_zero::UINT_TO_UINT,
    &compute_wmel_zero::UINT_TO_UVEC3,
    &compute_wmel_zero::UINT_TO_BOOL,
    &compute_wmel_zero::UINT_TO_UINT8_T,
    &compute_wmel_zero::UINT_TO_UINT16_T,
    &compute_wmel_zero::UINT_TO_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_FLOAT_FLOAT,
    &compute_wmel_zero::UINT_TO_VEC4_FLOAT,
    &compute_wmel_zero::UINT_TO_DOUBLE_FLOAT,
    &compute_wmel_zero::UINT_TO_DVEC4_FLOAT,
    &compute_wmel_zero::UINT_TO_UINT_FLOAT,
    &compute_wmel_zero::UINT_TO_UVEC3_FLOAT,
    &compute_wmel_zero::UINT_TO_BOOL_FLOAT,
    &compute_wmel_zero::UINT_TO_UINT8_T_FLOAT,
    &compute_wmel_zero::UINT_TO_UINT16_T_FLOAT,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_FLOAT,
    &compute_wmel_zero::UINT_TO_FLOAT_VEC4,
    &compute_wmel_zero::UINT_TO_VEC4_VEC4,
    &compute_wmel_zero::UINT_TO_DOUBLE_VEC4,
    &compute_wmel_zero::UINT_TO_DVEC4_VEC4,
    &compute_wmel_zero::UINT_TO_UINT_VEC4,
    &compute_wmel_zero::UINT_TO_UVEC3_VEC4,
    &compute_wmel_zero::UINT_TO_BOOL_VEC4,
    &compute_wmel_zero::UINT_TO_UINT8_T_VEC4,
    &compute_wmel_zero::UINT_TO_UINT16_T_VEC4,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_VEC4,
    &compute_wmel_zero::UINT_TO_FLOAT_DOUBLE,
    &compute_wmel_zero::UINT_TO_VEC4_DOUBLE,
    &compute_wmel_zero::UINT_TO_DOUBLE_DOUBLE,
    &compute_wmel_zero::UINT_TO_DVEC4_DOUBLE,
    &compute_wmel_zero::UINT_TO_UINT_DOUBLE,
    &compute_wmel_zero::UINT_TO_UVEC3_DOUBLE,
    &compute_wmel_zero::UINT_TO_BOOL_DOUBLE,
    &compute_wmel_zero::UINT_TO_UINT8_T_DOUBLE,
    &compute_wmel_zero::UINT_TO_UINT16_T_DOUBLE,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_DOUBLE,
    &compute_wmel_zero::UINT_TO_FLOAT_DVEC4,
    &compute_wmel_zero::UINT_TO_VEC4_DVEC4,
    &compute_wmel_zero::UINT_TO_DOUBLE_DVEC4,
    &compute_wmel_zero::UINT_TO_DVEC4_DVEC4,
    &compute_wmel_zero::UINT_TO_UINT_DVEC4,
    &compute_wmel_zero::UINT_TO_UVEC3_DVEC4,
    &compute_wmel_zero::UINT_TO_BOOL_DVEC4,
    &compute_wmel_zero::UINT_TO_UINT8_T_DVEC4,
    &compute_wmel_zero::UINT_TO_UINT16_T_DVEC4,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_DVEC4,
    &compute_wmel_zero::UINT_TO_FLOAT_UINT,
    &compute_wmel_zero::UINT_TO_VEC4_UINT,
    &compute_wmel_zero::UINT_TO_DOUBLE_UINT,
    &compute_wmel_zero::UINT_TO_DVEC4_UINT,
    &compute_wmel_zero::UINT_TO_UINT_UINT,
    &compute_wmel_zero::UINT_TO_UVEC3_UINT,
    &compute_wmel_zero::UINT_TO_BOOL_UINT,
    &compute_wmel_zero::UINT_TO_UINT8_T_UINT,
    &compute_wmel_zero::UINT_TO_UINT16_T_UINT,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_UINT,
    &compute_wmel_zero::UINT_TO_FLOAT_UVEC3,
    &compute_wmel_zero::UINT_TO_VEC4_UVEC3,
    &compute_wmel_zero::UINT_TO_DOUBLE_UVEC3,
    &compute_wmel_zero::UINT_TO_DVEC4_UVEC3,
    &compute_wmel_zero::UINT_TO_UINT_UVEC3,
    &compute_wmel_zero::UINT_TO_UVEC3_UVEC3,
    &compute_wmel_zero::UINT_TO_BOOL_UVEC3,
    &compute_wmel_zero::UINT_TO_UINT8_T_UVEC3,
    &compute_wmel_zero::UINT_TO_UINT16_T_UVEC3,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_UVEC3,
    &compute_wmel_zero::UINT_TO_FLOAT_BOOL,
    &compute_wmel_zero::UINT_TO_VEC4_BOOL,
    &compute_wmel_zero::UINT_TO_DOUBLE_BOOL,
    &compute_wmel_zero::UINT_TO_DVEC4_BOOL,
    &compute_wmel_zero::UINT_TO_UINT_BOOL,
    &compute_wmel_zero::UINT_TO_UVEC3_BOOL,
    &compute_wmel_zero::UINT_TO_BOOL_BOOL,
    &compute_wmel_zero::UINT_TO_UINT8_T_BOOL,
    &compute_wmel_zero::UINT_TO_UINT16_T_BOOL,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_BOOL,
    &compute_wmel_zero::UINT_TO_FLOAT_UINT8_T,
    &compute_wmel_zero::UINT_TO_VEC4_UINT8_T,
    &compute_wmel_zero::UINT_TO_DOUBLE_UINT8_T,
    &compute_wmel_zero::UINT_TO_DVEC4_UINT8_T,
    &compute_wmel_zero::UINT_TO_UINT_UINT8_T,
    &compute_wmel_zero::UINT_TO_UVEC3_UINT8_T,
    &compute_wmel_zero::UINT_TO_BOOL_UINT8_T,
    &compute_wmel_zero::UINT_TO_UINT8_T_UINT8_T,
    &compute_wmel_zero::UINT_TO_UINT16_T_UINT8_T,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_UINT8_T,
    &compute_wmel_zero::UINT_TO_FLOAT_UINT16_T,
    &compute_wmel_zero::UINT_TO_VEC4_UINT16_T,
    &compute_wmel_zero::UINT_TO_DOUBLE_UINT16_T,
    &compute_wmel_zero::UINT_TO_DVEC4_UINT16_T,
    &compute_wmel_zero::UINT_TO_UINT_UINT16_T,
    &compute_wmel_zero::UINT_TO_UVEC3_UINT16_T,
    &compute_wmel_zero::UINT_TO_BOOL_UINT16_T,
    &compute_wmel_zero::UINT_TO_UINT8_T_UINT16_T,
    &compute_wmel_zero::UINT_TO_UINT16_T_UINT16_T,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_UINT16_T,
    &compute_wmel_zero::UINT_TO_FLOAT_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_VEC4_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_DOUBLE_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_DVEC4_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_UINT_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_UVEC3_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_BOOL_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_UINT8_T_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_UINT16_T_FLOAT16_T,
    &compute_wmel_zero::UINT_TO_FLOAT16_T_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT,
    &compute_wmel_zero::UVEC4_TO_VEC4,
    &compute_wmel_zero::UVEC4_TO_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_DVEC4,
    &compute_wmel_zero::UVEC4_TO_UINT,
    &compute_wmel_zero::UVEC4_TO_UVEC3,
    &compute_wmel_zero::UVEC4_TO_BOOL,
    &compute_wmel_zero::UVEC4_TO_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT_FLOAT,
    &compute_wmel_zero::UVEC4_TO_VEC4_FLOAT,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_FLOAT,
    &compute_wmel_zero::UVEC4_TO_DVEC4_FLOAT,
    &compute_wmel_zero::UVEC4_TO_UINT_FLOAT,
    &compute_wmel_zero::UVEC4_TO_UVEC3_FLOAT,
    &compute_wmel_zero::UVEC4_TO_BOOL_FLOAT,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_FLOAT,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_FLOAT,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_FLOAT,
    &compute_wmel_zero::UVEC4_TO_FLOAT_VEC4,
    &compute_wmel_zero::UVEC4_TO_VEC4_VEC4,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_VEC4,
    &compute_wmel_zero::UVEC4_TO_DVEC4_VEC4,
    &compute_wmel_zero::UVEC4_TO_UINT_VEC4,
    &compute_wmel_zero::UVEC4_TO_UVEC3_VEC4,
    &compute_wmel_zero::UVEC4_TO_BOOL_VEC4,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_VEC4,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_VEC4,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_VEC4,
    &compute_wmel_zero::UVEC4_TO_FLOAT_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_VEC4_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_DVEC4_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_UINT_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_UVEC3_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_BOOL_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_DOUBLE,
    &compute_wmel_zero::UVEC4_TO_FLOAT_DVEC4,
    &compute_wmel_zero::UVEC4_TO_VEC4_DVEC4,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_DVEC4,
    &compute_wmel_zero::UVEC4_TO_DVEC4_DVEC4,
    &compute_wmel_zero::UVEC4_TO_UINT_DVEC4,
    &compute_wmel_zero::UVEC4_TO_UVEC3_DVEC4,
    &compute_wmel_zero::UVEC4_TO_BOOL_DVEC4,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_DVEC4,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_DVEC4,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_DVEC4,
    &compute_wmel_zero::UVEC4_TO_FLOAT_UINT,
    &compute_wmel_zero::UVEC4_TO_VEC4_UINT,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_UINT,
    &compute_wmel_zero::UVEC4_TO_DVEC4_UINT,
    &compute_wmel_zero::UVEC4_TO_UINT_UINT,
    &compute_wmel_zero::UVEC4_TO_UVEC3_UINT,
    &compute_wmel_zero::UVEC4_TO_BOOL_UINT,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_UINT,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_UINT,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_UINT,
    &compute_wmel_zero::UVEC4_TO_FLOAT_UVEC3,
    &compute_wmel_zero::UVEC4_TO_VEC4_UVEC3,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_UVEC3,
    &compute_wmel_zero::UVEC4_TO_DVEC4_UVEC3,
    &compute_wmel_zero::UVEC4_TO_UINT_UVEC3,
    &compute_wmel_zero::UVEC4_TO_UVEC3_UVEC3,
    &compute_wmel_zero::UVEC4_TO_BOOL_UVEC3,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_UVEC3,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_UVEC3,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_UVEC3,
    &compute_wmel_zero::UVEC4_TO_FLOAT_BOOL,
    &compute_wmel_zero::UVEC4_TO_VEC4_BOOL,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_BOOL,
    &compute_wmel_zero::UVEC4_TO_DVEC4_BOOL,
    &compute_wmel_zero::UVEC4_TO_UINT_BOOL,
    &compute_wmel_zero::UVEC4_TO_UVEC3_BOOL,
    &compute_wmel_zero::UVEC4_TO_BOOL_BOOL,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_BOOL,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_BOOL,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_BOOL,
    &compute_wmel_zero::UVEC4_TO_FLOAT_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_VEC4_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_DVEC4_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_UINT_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_UVEC3_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_BOOL_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_UINT8_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_VEC4_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_DVEC4_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_UINT_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_UVEC3_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_BOOL_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_UINT16_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_VEC4_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_DOUBLE_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_DVEC4_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_UINT_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_UVEC3_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_BOOL_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_UINT8_T_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_UINT16_T_FLOAT16_T,
    &compute_wmel_zero::UVEC4_TO_FLOAT16_T_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_VEC4,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_UINT,
    &compute_wmel_zero::UINT8_T_TO_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_BOOL,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_VEC4_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_UINT_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_BOOL_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_FLOAT,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_VEC4,
    &compute_wmel_zero::UINT8_T_TO_VEC4_VEC4,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_VEC4,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_VEC4,
    &compute_wmel_zero::UINT8_T_TO_UINT_VEC4,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_VEC4,
    &compute_wmel_zero::UINT8_T_TO_BOOL_VEC4,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_VEC4,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_VEC4,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_VEC4,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_VEC4_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_UINT_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_BOOL_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_DOUBLE,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_VEC4_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_UINT_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_BOOL_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_DVEC4,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_UINT,
    &compute_wmel_zero::UINT8_T_TO_VEC4_UINT,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_UINT,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_UINT,
    &compute_wmel_zero::UINT8_T_TO_UINT_UINT,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_UINT,
    &compute_wmel_zero::UINT8_T_TO_BOOL_UINT,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_UINT,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_UINT,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_UINT,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_VEC4_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_UINT_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_BOOL_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_UVEC3,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_BOOL,
    &compute_wmel_zero::UINT8_T_TO_VEC4_BOOL,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_BOOL,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_BOOL,
    &compute_wmel_zero::UINT8_T_TO_UINT_BOOL,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_BOOL,
    &compute_wmel_zero::UINT8_T_TO_BOOL_BOOL,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_BOOL,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_BOOL,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_BOOL,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_VEC4_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_UINT_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_BOOL_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_UINT8_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_VEC4_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_UINT_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_BOOL_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_UINT16_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_VEC4_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_DOUBLE_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_DVEC4_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_UINT_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_UVEC3_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_BOOL_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_UINT8_T_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_UINT16_T_FLOAT16_T,
    &compute_wmel_zero::UINT8_T_TO_FLOAT16_T_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_VEC4,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_UINT,
    &compute_wmel_zero::U8VEC4_TO_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_BOOL,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_VEC4_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_UINT_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_BOOL_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_FLOAT,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_VEC4,
    &compute_wmel_zero::U8VEC4_TO_VEC4_VEC4,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_VEC4,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_VEC4,
    &compute_wmel_zero::U8VEC4_TO_UINT_VEC4,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_VEC4,
    &compute_wmel_zero::U8VEC4_TO_BOOL_VEC4,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_VEC4,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_VEC4,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_VEC4,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_VEC4_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_UINT_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_BOOL_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_DOUBLE,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_VEC4_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_UINT_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_BOOL_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_DVEC4,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_UINT,
    &compute_wmel_zero::U8VEC4_TO_VEC4_UINT,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_UINT,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_UINT,
    &compute_wmel_zero::U8VEC4_TO_UINT_UINT,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_UINT,
    &compute_wmel_zero::U8VEC4_TO_BOOL_UINT,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_UINT,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_UINT,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_UINT,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_VEC4_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_UINT_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_BOOL_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_UVEC3,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_BOOL,
    &compute_wmel_zero::U8VEC4_TO_VEC4_BOOL,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_BOOL,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_BOOL,
    &compute_wmel_zero::U8VEC4_TO_UINT_BOOL,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_BOOL,
    &compute_wmel_zero::U8VEC4_TO_BOOL_BOOL,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_BOOL,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_BOOL,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_BOOL,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_VEC4_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_UINT_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_BOOL_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_UINT8_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_VEC4_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_UINT_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_BOOL_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_UINT16_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_VEC4_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_DOUBLE_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_DVEC4_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_UINT_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_UVEC3_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_BOOL_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_UINT8_T_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_UINT16_T_FLOAT16_T,
    &compute_wmel_zero::U8VEC4_TO_FLOAT16_T_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_VEC4,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_UINT,
    &compute_wmel_zero::UINT16_T_TO_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_BOOL,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_VEC4_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_UINT_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_BOOL_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_FLOAT,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_VEC4,
    &compute_wmel_zero::UINT16_T_TO_VEC4_VEC4,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_VEC4,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_VEC4,
    &compute_wmel_zero::UINT16_T_TO_UINT_VEC4,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_VEC4,
    &compute_wmel_zero::UINT16_T_TO_BOOL_VEC4,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_VEC4,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_VEC4,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_VEC4,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_VEC4_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_UINT_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_BOOL_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_DOUBLE,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_VEC4_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_UINT_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_BOOL_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_DVEC4,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_UINT,
    &compute_wmel_zero::UINT16_T_TO_VEC4_UINT,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_UINT,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_UINT,
    &compute_wmel_zero::UINT16_T_TO_UINT_UINT,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_UINT,
    &compute_wmel_zero::UINT16_T_TO_BOOL_UINT,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_UINT,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_UINT,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_UINT,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_VEC4_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_UINT_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_BOOL_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_UVEC3,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_BOOL,
    &compute_wmel_zero::UINT16_T_TO_VEC4_BOOL,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_BOOL,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_BOOL,
    &compute_wmel_zero::UINT16_T_TO_UINT_BOOL,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_BOOL,
    &compute_wmel_zero::UINT16_T_TO_BOOL_BOOL,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_BOOL,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_BOOL,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_BOOL,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_VEC4_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_UINT_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_BOOL_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_UINT8_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_VEC4_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_UINT_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_BOOL_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_UINT16_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_VEC4_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_DOUBLE_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_DVEC4_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_UINT_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_UVEC3_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_BOOL_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_UINT8_T_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_UINT16_T_FLOAT16_T,
    &compute_wmel_zero::UINT16_T_TO_FLOAT16_T_FLOAT16_T,
];

/// The manifest entry whose three types match `case_def`.
fn get_programs(case_def: &CaseDef) -> BinaryCollection {
    ZERO_PROGRAMS
        .iter()
        .find(|p| p.zero_element_type == case_def.zero_element_type && p.field_type_0 == case_def.field_type[0] && p.field_type_1 == case_def.field_type[1])
        .unwrap_or_else(|| panic!("compute_wmel_zero.toml declares no shader for {}", case_def.test_name()))
        .programs
}

/// `ZeroTest::CaseDef`
#[derive(Clone, Copy)]
struct CaseDef {
    zero_element_type: DataType,
    field_type: [DataType; 2],
    elements: u32,
}

impl CaseDef {
    /// `ZeroTest::CaseDef::testName`
    fn test_name(&self) -> String {
        let mut name = get_data_type_name(self.zero_element_type).to_string();
        name += "_array_to";

        for field_type in self.field_type {
            if field_type == DataType::Invalid {
                break;
            }
            name += "_";
            name += get_data_type_name(field_type);
        }
        name += &format!("_array_{}", self.elements);
        name
    }
}

/// `ZeroTest`
pub struct ZeroCase {
    name: String,
    case_def: CaseDef,
    compute_pipeline_construction_type: ComputePipelineConstructionType,
    programs: BinaryCollection,
}

impl ZeroCase {
    fn new(case_def: CaseDef, compute_pipeline_construction_type: ComputePipelineConstructionType) -> Self {
        Self {
            name: case_def.test_name(),
            case_def,
            compute_pipeline_construction_type,
            programs: get_programs(&case_def),
        }
    }
}

impl TestCase for ZeroCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ZeroTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // `deMemset(&p, 0, sizeof(p))`, then the one field that is not a flag.
        let mut p = CheckSupportParams {
            needs_scalar: false,
            needs_int8: false,
            needs_int16: false,
            needs_int64: false,
            needs_float16: false,
            needs_float64: false,
            compute_pipeline_construction_type: self.compute_pipeline_construction_type,
        };

        debug_assert!(!is_data_type_float16_or_vec(self.case_def.zero_element_type));

        p.use_type(self.case_def.zero_element_type);
        p.use_type(self.case_def.field_type[0]);
        p.use_type(self.case_def.field_type[1]);

        check_support_with_params(context, &p)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ZeroInstance {
            context,
            compute_pipeline_construction_type: self.compute_pipeline_construction_type,
        })
    }
}

/// `ZeroTest::Instance`. Upstream derives from `MultiQueueRunnerTestInstance`, which
/// repeats `queuePass` on every compute-capable queue; that is not ported, so this
/// runs once on the universal queue.
struct ZeroInstance<'a> {
    context: &'a Context<'a>,
    compute_pipeline_construction_type: ComputePipelineConstructionType,
}

impl TestInstance for ZeroInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_compute(
            self.context,
            1,
            self.compute_pipeline_construction_type,
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )
    }
}

/// `isTestedZeroElementType`
fn is_tested_zero_element_type(dt: DataType) -> bool {
    // Select only a few interesting types.
    matches!(dt, DataType::Uint | DataType::UintVec4 | DataType::Uint8 | DataType::Uint8Vec4 | DataType::Uint16)
}

/// `isTestedFieldType`
fn is_tested_field_type(dt: DataType) -> bool {
    // Select only a few interesting types.
    matches!(
        dt,
        DataType::Uint
            | DataType::UintVec3
            | DataType::Uint8
            | DataType::Uint16
            | DataType::Float
            | DataType::FloatVec4
            | DataType::Float16
            | DataType::Double
            | DataType::DoubleVec4
            | DataType::Bool
    )
}

/// `AddZeroTests`
fn add_zero_tests(group: &mut TestCaseGroup, compute_pipeline_construction_type: ComputePipelineConstructionType) {
    let mut c = CaseDef {
        zero_element_type: DataType::Invalid,
        field_type: [DataType::Invalid; 2],
        elements: 0,
    };

    for &data_type in DATA_TYPES {
        c.zero_element_type = data_type;

        if is_tested_zero_element_type(c.zero_element_type) {
            let mut idx = [0usize, 0usize];

            while idx[1] < DATA_TYPES.len() && idx[0] < DATA_TYPES.len() {
                c.field_type[0] = DATA_TYPES[idx[0]];
                c.field_type[1] = DATA_TYPES[idx[1]];

                if is_tested_field_type(c.field_type[0]) && (c.field_type[1] == DataType::Invalid || is_tested_field_type(c.field_type[1])) {
                    for elements in 1..=4u32 {
                        c.elements = elements;
                        group.add_child(Box::new(ZeroCase::new(c, compute_pipeline_construction_type)) as Box<dyn TestCase>);
                    }
                }

                idx[0] += 1;
                if idx[0] >= DATA_TYPES.len() {
                    idx[1] += 1;
                    idx[0] = 0;
                }
            }
        }
    }
}

/// The `zero` subgroup of `createWorkgroupMemoryExplicitLayoutTests`.
///
/// Upstream takes the construction type as a parameter and registers the whole
/// subtree once per type; only `COMPUTE_PIPELINE_CONSTRUCTION_TYPE_PIPELINE` is
/// ported, which is the one this port's `compute` group is built for.
pub fn create_zero_tests() -> TestCaseGroup {
    // Manually zero initialize a block and read from another
    let mut zero = TestCaseGroup::new("zero");
    add_zero_tests(&mut zero, ComputePipelineConstructionType::Pipeline);
    zero
}
