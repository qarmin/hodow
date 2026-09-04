// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeZeroInitializeWorkgroupMemoryTests.cpp
//   external/vulkancts/data/vulkan/amber/compute/zero_initialize_workgroup_memory/*.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Google LLC.
// Copyright (c) 2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The three table-driven subgroups of that file - `types` (AddTypeTests, 75 cases),
// `composites` (AddCompositeTests, 11) and `shared_memory_blocks` (AddSharedMemoryTests,
// 7). The rest of the same upstream file is in zero_initialize_workgroup_memory_tests.rs;
// `run_compute` is deliberately duplicated here rather than imported from there, so the
// two modules stay independent while both are being worked on.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{self, TestError, TestOutcome, TestStatus, UVec3};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// The extension every case in this group needs.
const EXTENSION: &str = "VK_KHR_zero_initialize_workgroup_memory";

/// `runCompute` - the helper every test in this file dispatches through.
#[allow(clippy::too_many_arguments)]
fn run_compute(context: &Context<'_>, buffer_size: u32, num_wgx: u32, num_wgy: u32, num_wgz: u32, spec_values: &[u32], increment: u32) -> TestOutcome {
    let vk = context.get_device();
    let device_queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();

    let size = buffer_size as u64;
    let buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let buffer_descriptor = make_descriptor_buffer_info(buffer.get(), 0, size);

    // Prefill with 0xff when checking for zeroes, so a shader that writes nothing
    // cannot pass by accident; with 0 when the shader accumulates instead.
    let ptr = buffer.get_allocation().get_host_ptr();
    unsafe { std::ptr::write_bytes(ptr, if increment != 0 { 0 } else { 0xff }, size as usize) };

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(vk)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

    let entries: Vec<vk::SpecializationMapEntry> = spec_values
        .iter()
        .enumerate()
        .map(|(i, _)| vk::SpecializationMapEntry {
            constant_id: i as u32,
            offset: (std::mem::size_of::<u32>() * i) as u32,
            size: std::mem::size_of::<u32>(),
        })
        .collect();
    let spec_bytes: Vec<u8> = spec_values.iter().flat_map(|v| v.to_ne_bytes()).collect();

    flush_alloc(vk, buffer.get_allocation())?;

    let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, context.get_binary_collection().get("comp")?);
    pipeline.set_descriptor_set_layout(*descriptor_set_layout);
    pipeline.set_specialization_info(entries, spec_bytes);
    pipeline.build_pipeline()?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    DescriptorSetUpdateBuilder::new()
        .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer_descriptor)
        .update(vk);

    begin_command_buffer(vk, *cmd_buffer)?;
    unsafe {
        vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
    }
    pipeline.bind(*cmd_buffer);
    unsafe {
        vk.cmd_dispatch(*cmd_buffer, num_wgx, num_wgy, num_wgz);

        let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, device_queue, *cmd_buffer)?;

    invalidate_alloc(vk, buffer.get_allocation())?;

    let values = buffer.get_allocation().get_host_ptr().cast::<u32>();
    let count = size as usize / std::mem::size_of::<u32>();
    for i in 0..count {
        let expected = if increment != 0 { num_wgx * num_wgy * num_wgz } else { 0 };
        let got = unsafe { *values.add(i) };
        if got != expected {
            log::error!("failure at index {i}: expected {expected}, got: {got}");
            return Ok(TestStatus::fail("compute failed"));
        }
    }

    Ok(TestStatus::pass("compute succeeded"))
}

/// The `VkPhysicalDeviceShaderFloat16Int8Features` query both `TypeTest::checkSupport`
/// and `CompositeTest::checkSupport` open with. Upstream writes the block out twice;
/// it is one function here because it is raw-pointer chaining, not test logic.
fn get_features(context: &Context<'_>) -> (vk::PhysicalDeviceFeatures, vk::PhysicalDeviceShaderFloat16Int8Features) {
    let mut f16_i8_features = vk::PhysicalDeviceShaderFloat16Int8Features {
        s_type: vk::StructureType::PHYSICAL_DEVICE_SHADER_FLOAT16_INT8_FEATURES,
        next: std::ptr::null_mut(),
        shader_float16: vk::FALSE,
        shader_int8: vk::FALSE,
    };

    let mut features2 = vk::PhysicalDeviceFeatures2 {
        s_type: vk::StructureType::PHYSICAL_DEVICE_FEATURES_2,
        next: std::ptr::addr_of_mut!(f16_i8_features).cast(),
        features: vk::PhysicalDeviceFeatures::default(),
    };
    unsafe {
        context.get_instance().get_physical_device_features2(context.get_physical_device(), &mut features2);
    }

    (features2.features, f16_i8_features)
}

// ---------------------------------------------------------------------------------
// TypeTest
// ---------------------------------------------------------------------------------

/// `TypeCaseDef` plus its shader. `name` is the type name: upstream registers each case
/// under `caseDef.typeName`, and `checkSupport` matches on that same string.
#[derive(Clone, Copy)]
pub struct TypeCase {
    pub name: &'static str,
    pub type_size: u32,
    pub num_elements: u32,
    pub num_rows: u32,
    pub num_variables: u32,
    pub programs: BinaryCollection,
}

impl TestCase for TypeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality(EXTENSION)?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;

        let (features, f16_i8_features) = get_features(context);

        if matches!(
            self.name,
            "float16_t"
                | "f16vec2"
                | "f16vec3"
                | "f16vec4"
                | "f16mat2x2"
                | "f16mat2x3"
                | "f16mat2x4"
                | "f16mat3x2"
                | "f16mat3x3"
                | "f16mat3x4"
                | "f16mat4x2"
                | "f16mat4x3"
                | "f16mat4x4"
        ) && f16_i8_features.shader_float16 != vk::TRUE
        {
            return Err(TestError::NotSupported("shaderFloat16 not supported".to_string()));
        }

        if matches!(
            self.name,
            "float64_t"
                | "f64vec2"
                | "f64vec3"
                | "f64vec4"
                | "f64mat2x2"
                | "f64mat2x3"
                | "f64mat2x4"
                | "f64mat3x2"
                | "f64mat3x3"
                | "f64mat3x4"
                | "f64mat4x2"
                | "f64mat4x3"
                | "f64mat4x4"
        ) && features.shader_float64 != vk::TRUE
        {
            return Err(TestError::NotSupported("shaderFloat64 not supported".to_string()));
        }

        if matches!(self.name, "int8_t" | "i8vec2" | "i8vec3" | "i8vec4" | "uint8_t" | "u8vec2" | "u8vec3" | "u8vec4") && f16_i8_features.shader_int8 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt8 not supported".to_string()));
        }

        if matches!(self.name, "int16_t" | "i16vec2" | "i16vec3" | "i16vec4" | "uint16_t" | "u16vec2" | "u16vec3" | "u16vec4") && features.shader_int16 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt16 not supported".to_string()));
        }

        if matches!(self.name, "int64_t" | "i64vec2" | "i64vec3" | "i64vec4" | "uint64_t" | "u64vec2" | "u64vec3" | "u64vec4") && features.shader_int64 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TypeTestInstance { context, case_def: *self })
    }
}

struct TypeTestInstance<'a> {
    context: &'a Context<'a>,
    case_def: TypeCase,
}

impl TestInstance for TypeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let var_bytes = self.case_def.num_elements * self.case_def.num_rows * std::mem::size_of::<u32>() as u32;
        run_compute(self.context, var_bytes * self.case_def.num_variables, 1, 1, 1, &[], 0)
    }
}

/// `AddTypeTests`
///
/// The upstream `cases` table, and the `deRandom` draw that fills in `numVariables`,
/// both live in the manifest - the shader is built from them, so they cannot be
/// re-derived here without the two disagreeing. What is left is the registration, in
/// the same order.
fn add_type_tests(group: &mut tcu::TestCaseGroup) {
    use crate::generated::shaders::compute_zero_initialize_types::*;

    for case in [
        TYPES_BOOL,
        TYPES_BVEC2,
        TYPES_BVEC3,
        TYPES_BVEC4,
        TYPES_UINT32_T,
        TYPES_UVEC2,
        TYPES_UVEC3,
        TYPES_UVEC4,
        TYPES_INT32_T,
        TYPES_IVEC2,
        TYPES_IVEC3,
        TYPES_IVEC4,
        TYPES_UINT8_T,
        TYPES_U8VEC2,
        TYPES_U8VEC3,
        TYPES_U8VEC4,
        TYPES_INT8_T,
        TYPES_I8VEC2,
        TYPES_I8VEC3,
        TYPES_I8VEC4,
        TYPES_UINT16_T,
        TYPES_U16VEC2,
        TYPES_U16VEC3,
        TYPES_U16VEC4,
        TYPES_INT16_T,
        TYPES_I16VEC2,
        TYPES_I16VEC3,
        TYPES_I16VEC4,
        TYPES_UINT64_T,
        TYPES_U64VEC2,
        TYPES_U64VEC3,
        TYPES_U64VEC4,
        TYPES_INT64_T,
        TYPES_I64VEC2,
        TYPES_I64VEC3,
        TYPES_I64VEC4,
        TYPES_FLOAT32_T,
        TYPES_F32VEC2,
        TYPES_F32VEC3,
        TYPES_F32VEC4,
        TYPES_F32MAT2X2,
        TYPES_F32MAT2X3,
        TYPES_F32MAT2X4,
        TYPES_F32MAT3X2,
        TYPES_F32MAT3X3,
        TYPES_F32MAT3X4,
        TYPES_F32MAT4X2,
        TYPES_F32MAT4X3,
        TYPES_F32MAT4X4,
        TYPES_FLOAT16_T,
        TYPES_F16VEC2,
        TYPES_F16VEC3,
        TYPES_F16VEC4,
        TYPES_F16MAT2X2,
        TYPES_F16MAT2X3,
        TYPES_F16MAT2X4,
        TYPES_F16MAT3X2,
        TYPES_F16MAT3X3,
        TYPES_F16MAT3X4,
        TYPES_F16MAT4X2,
        TYPES_F16MAT4X3,
        TYPES_F16MAT4X4,
        TYPES_FLOAT64_T,
        TYPES_F64VEC2,
        TYPES_F64VEC3,
        TYPES_F64VEC4,
        TYPES_F64MAT2X2,
        TYPES_F64MAT2X3,
        TYPES_F64MAT2X4,
        TYPES_F64MAT3X2,
        TYPES_F64MAT3X3,
        TYPES_F64MAT3X4,
        TYPES_F64MAT4X2,
        TYPES_F64MAT4X3,
        TYPES_F64MAT4X4,
    ] {
        group.add_child(Box::new(case) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// CompositeTest
// ---------------------------------------------------------------------------------

/// `CompositeCaseDef` plus its shader.
///
/// `specValues` is a `std::vector<uint32_t>` upstream. The shader generator has no
/// list-of-u32 parameter type, so the manifest carries a count and five slots and the
/// instance passes `spec_values[..num_spec_values]` on; the five is the longest vector
/// in the upstream table.
#[derive(Clone, Copy)]
pub struct CompositeCase {
    pub name: &'static str,
    pub index: u32,
    pub elements: u32,
    pub num_spec_values: u32,
    pub spec_value0: u32,
    pub spec_value1: u32,
    pub spec_value2: u32,
    pub spec_value3: u32,
    pub spec_value4: u32,
    pub programs: BinaryCollection,
}

impl TestCase for CompositeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality(EXTENSION)?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;

        let (features, f16_i8_features) = get_features(context);

        let needs_float16 = (self.index & 0x1) != 0;
        let needs_float64 = (self.index & 0x2) != 0;
        let needs_int8 = (self.index & 0x4) != 0;
        let needs_int16 = (self.index & 0x8) != 0;
        let needs_int64 = (self.index & 0x10) != 0;

        if needs_float16 && f16_i8_features.shader_float16 != vk::TRUE {
            return Err(TestError::NotSupported("shaderFloat16 not supported".to_string()));
        }
        if needs_float64 && features.shader_float64 != vk::TRUE {
            return Err(TestError::NotSupported("shaderFloat64 not supported".to_string()));
        }
        if needs_int8 && f16_i8_features.shader_int8 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt8 not supported".to_string()));
        }
        if needs_int16 && features.shader_int16 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt16 not supported".to_string()));
        }
        if needs_int64 && features.shader_int64 != vk::TRUE {
            return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CompositeTestInstance { context, case_def: *self })
    }
}

struct CompositeTestInstance<'a> {
    context: &'a Context<'a>,
    case_def: CompositeCase,
}

impl TestInstance for CompositeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let buffer_size = std::mem::size_of::<u32>() as u32 * self.case_def.elements;
        let spec_values = [
            self.case_def.spec_value0,
            self.case_def.spec_value1,
            self.case_def.spec_value2,
            self.case_def.spec_value3,
            self.case_def.spec_value4,
        ];
        run_compute(self.context, buffer_size, 1, 1, 1, &spec_values[..self.case_def.num_spec_values as usize], 0)
    }
}

/// `AddCompositeTests`
///
/// The GLSL each case injects (`typeDefinition` / `assignment`) is in the manifest,
/// which is what the case name - the table index, as `de::toString(i)` produces - is
/// really an index into.
fn add_composite_tests(group: &mut tcu::TestCaseGroup) {
    use crate::generated::shaders::compute_zero_initialize_types::*;

    for case in [
        COMPOSITES_0,
        COMPOSITES_1,
        COMPOSITES_2,
        COMPOSITES_3,
        COMPOSITES_4,
        COMPOSITES_5,
        COMPOSITES_6,
        COMPOSITES_7,
        COMPOSITES_8,
        COMPOSITES_9,
        COMPOSITES_10,
    ] {
        group.add_child(Box::new(case) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// AddSharedMemoryTests
// ---------------------------------------------------------------------------------

/// One of the seven Amber scripts under
/// `data/vulkan/amber/compute/zero_initialize_workgroup_memory/`.
///
/// There is no Amber here, so the script is transcribed: its GLSL is the shader, and
/// its `BUFFER result_buffer ... FILL 99` / `BUFFER reference_buffer ... FILL 1` /
/// `EXPECT result_buffer EQ_BUFFER reference_buffer` become the fill and the check.
#[derive(Clone, Copy)]
pub struct SharedMemoryBlockCase {
    pub name: &'static str,
    pub local_size: UVec3,
    pub buffer_elements: u32,
    pub fill_value: u32,
    pub reference_value: u32,
    pub programs: BinaryCollection,
}

impl TestCase for SharedMemoryBlockCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // `requirements` in AddSharedMemoryTests, handed to createAmberTestCase. Amber
        // cases carry no pipeline-construction requirement: upstream only registers the
        // group at all when the construction type is not a shader object.
        context.require_device_functionality(EXTENSION)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SharedMemoryBlockInstance { context, case_def: *self })
    }
}

struct SharedMemoryBlockInstance<'a> {
    context: &'a Context<'a>,
    case_def: SharedMemoryBlockCase,
}

impl TestInstance for SharedMemoryBlockInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let device_queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        let count = self.case_def.buffer_elements as usize;
        let size = (count * std::mem::size_of::<u32>()) as u64;
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer_descriptor = make_descriptor_buffer_info(buffer.get(), 0, size);

        // `BUFFER result_buffer DATA_TYPE uint32 SIZE 128 FILL 99` - a per-element fill,
        // not a byte pattern, so a shader that writes nothing reads back as 99.
        let ptr = buffer.get_allocation().get_host_ptr().cast::<u32>();
        for i in 0..count {
            unsafe { *ptr.add(i) = self.case_def.fill_value };
        }

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        flush_alloc(vk, buffer.get_allocation())?;

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer_descriptor)
            .update(vk);

        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
        }
        pipeline.bind(*cmd_buffer);
        unsafe {
            // `RUN pipeline 1 1 1`
            vk.cmd_dispatch(*cmd_buffer, 1, 1, 1);

            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer)?;
        submit_commands_and_wait(vk, device_queue, *cmd_buffer)?;

        invalidate_alloc(vk, buffer.get_allocation())?;

        // `EXPECT result_buffer EQ_BUFFER reference_buffer`
        for i in 0..count {
            let expected = self.case_def.reference_value;
            let got = unsafe { *ptr.add(i) };
            if got != expected {
                log::error!("failure at index {i}: expected {expected}, got: {got}");
                return Ok(TestStatus::fail("compute failed"));
            }
        }

        Ok(TestStatus::pass("compute succeeded"))
    }
}

/// `AddSharedMemoryTests`
fn add_shared_memory_tests(group: &mut tcu::TestCaseGroup) {
    use crate::generated::shaders::compute_zero_initialize_types::*;

    for case in [
        SHARED_MEMORY_BLOCKS_WORKGROUP_SIZE_128,
        SHARED_MEMORY_BLOCKS_WORKGROUP_SIZE_8X8X2,
        SHARED_MEMORY_BLOCKS_WORKGROUP_SIZE_8X2X8,
        SHARED_MEMORY_BLOCKS_WORKGROUP_SIZE_2X8X8,
        SHARED_MEMORY_BLOCKS_WORKGROUP_SIZE_8X4X4,
        SHARED_MEMORY_BLOCKS_WORKGROUP_SIZE_4X8X4,
        SHARED_MEMORY_BLOCKS_WORKGROUP_SIZE_4X4X8,
    ] {
        group.add_child(Box::new(case) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// Group construction
// ---------------------------------------------------------------------------------

/// The `types`, `composites` and `shared_memory_blocks` children of
/// `createZeroInitializeWorkgroupMemoryTests`, in the order it adds them. The caller
/// hangs them off the `zero_initialize_workgroup_memory` group; `types` and
/// `composites` go before `max_workgroups` there, `shared_memory_blocks` last.
pub fn create_types_composites_and_blocks_groups() -> Vec<tcu::TestCaseGroup> {
    let mut type_group = tcu::TestCaseGroup::new("types");
    add_type_tests(&mut type_group);

    let mut composite_group = tcu::TestCaseGroup::new("composites");
    add_composite_tests(&mut composite_group);

    let mut subgroup_invocation_group = tcu::TestCaseGroup::new("shared_memory_blocks");
    add_shared_memory_tests(&mut subgroup_invocation_group);

    vec![type_group, composite_group, subgroup_invocation_group]
}
