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
// Ported so far: padding (182 cases) and size (7). The alias and zero subgroups each
// carry a table of per-case GLSL that has to be transcribed, and copy_memory/zero_ext
// are Amber-driven; those are separate work.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::compute_wmel_padding;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The construction type this group is registered under.
///
/// Upstream threads `computePipelineConstructionType` through every constructor in the
/// file; the entry point here takes no argument, so the one ported type is named once.
const COMPUTE_PIPELINE_CONSTRUCTION_TYPE: ComputePipelineConstructionType = ComputePipelineConstructionType::Pipeline;

/// `glu::DataType`, restricted to the two members `AddPaddingTests` uses.
///
/// The manifest names these by variant (`enum:DataType`), so a typo there is a compile
/// error rather than a silently wrong shared-block member type.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DataType {
    /// `glu::TYPE_UINT`
    Uint,
    /// `glu::TYPE_UINT8`
    Uint8,
}

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
    /// Upstream `deMemset(&p, 0, sizeof(p))`, then assignment of the fields a given
    /// test cares about.
    fn new(compute_pipeline_construction_type: ComputePipelineConstructionType) -> Self {
        Self {
            needs_scalar: false,
            needs_int8: false,
            needs_int16: false,
            needs_int64: false,
            needs_float16: false,
            needs_float64: false,
            compute_pipeline_construction_type,
        }
    }

    /// `CheckSupportParams::useType`
    ///
    /// Upstream runs `isDataTypeIntOrIVec8Bit` / `...16Bit` / `isDataTypeFloat16OrVec`
    /// / `isDataTypeDoubleOrDVec` over the whole `glu::DataType` enum. `AddPaddingTests`
    /// only ever uses `uint` and `uint8_t`, so the 8-bit predicate is the only one that
    /// can fire.
    fn use_type(&mut self, dt: DataType) {
        match dt {
            DataType::Uint => {}
            DataType::Uint8 => self.needs_int8 = true,
        }
    }
}

/// `checkSupportWithParams`
fn check_support_with_params(context: &Context<'_>, params: &CheckSupportParams) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_workgroup_memory_explicit_layout")?;
    context.require_device_functionality("VK_KHR_spirv_1_4")?;
    check_shader_object_requirements(params.compute_pipeline_construction_type)?;

    let mut layout_features = vk::PhysicalDeviceWorkgroupMemoryExplicitLayoutFeaturesKHR::default();
    let mut f16_i8_features = vk::PhysicalDeviceShaderFloat16Int8Features::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    f16_i8_features.next = (&raw mut layout_features).cast();
    features2.next = (&raw mut f16_i8_features).cast();
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

/// `runCompute` - the helper every test in this file dispatches through.
///
/// Deliberately a private copy rather than something shared with the other compute
/// modules: upstream keeps one of these per test file and they drift apart (this one
/// prefills with 0xFF, dispatches 1x1x1 with no pipeline barrier, and expects
/// `ptr[i] == i`), so sharing would mean tracking a union of behaviours that upstream
/// never has to.
fn run_compute(
    context: &Context<'_>,
    workgroup_size: u32,
    compute_pipeline_construction_type: ComputePipelineConstructionType,
    queue: vk::Queue,
    queue_family_index: u32,
) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();

    let size = std::mem::size_of::<u32>() as vk::DeviceSize * vk::DeviceSize::from(workgroup_size);

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

    // 0xFF everywhere, so a shader that never writes cannot pass by accident.
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
// PaddingTest
// ---------------------------------------------------------------------------------

/// One of the 182 `padding.*` cases.
///
/// `PaddingTest::CaseDef` carries parallel `types`/`offsets`/`values` vectors plus an
/// `expected[32]` array. `AddPaddingTests` only ever pushes two members of the same
/// type, so the vectors are flattened to numbered fields here - that is the shape the
/// manifest can express, and it is what the generator fills in. `expected[32]` is not
/// a field at all: it only ever feeds the GLSL, so it is computed in
/// `shaders/src/compute/wmel_padding.comp` from the offsets and values.
#[derive(Clone, Copy)]
pub struct PaddingCase {
    pub name: &'static str,
    pub data_type: DataType,
    pub offset0: u32,
    pub offset1: u32,
    pub value0: u32,
    pub value1: u32,
    pub programs: BinaryCollection,
}

impl PaddingCase {
    /// `PaddingTest::CaseDef::needsScalar`
    fn needs_scalar(&self) -> bool {
        !self.offset0.is_multiple_of(4) || !self.offset1.is_multiple_of(4)
    }
}

impl TestCase for PaddingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let mut p = CheckSupportParams::new(COMPUTE_PIPELINE_CONSTRUCTION_TYPE);

        // Upstream loops over `m_caseDef.types`, which always holds the same type twice.
        p.use_type(self.data_type);
        p.use_type(self.data_type);

        p.needs_scalar = self.needs_scalar();

        check_support_with_params(context, &p)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PaddingInstance { context })
    }
}

struct PaddingInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for PaddingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_compute(
            self.context,
            1,
            COMPUTE_PIPELINE_CONSTRUCTION_TYPE,
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )
    }
}

/// `AddPaddingTests`
///
/// The two upstream loops (`uint` at 4-byte-aligned offsets, then `uint8_t` at
/// arbitrary byte offsets) are expanded in `compute_wmel_padding.toml`, because each
/// case bakes its offsets and its 32 expected words into its own shader. This walks
/// the expansion in the order those loops produce it.
fn add_padding_tests(group: &mut TestCaseGroup) {
    for case in PADDING_CASES {
        group.add_child(Box::new(*case) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// SizeTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct SizeCase {
    pub name: &'static str,
    pub size: u32,
    pub programs: BinaryCollection,
}

impl TestCase for SizeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_workgroup_memory_explicit_layout")?;
        context.require_device_functionality("VK_KHR_spirv_1_4")?;

        if context.get_device_properties().limits.max_compute_shared_memory_size < self.size {
            return Err(TestError::NotSupported("Not enough shared memory supported.".to_string()));
        }

        check_shader_object_requirements(COMPUTE_PIPELINE_CONSTRUCTION_TYPE)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SizeInstance { context })
    }
}

struct SizeInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for SizeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_compute(
            self.context,
            1,
            COMPUTE_PIPELINE_CONSTRUCTION_TYPE,
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )
    }
}

/// `AddSizeTests`
fn add_size_tests(group: &mut TestCaseGroup) {
    for case in SIZE_CASES {
        group.add_child(Box::new(*case) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// createWorkgroupMemoryExplicitLayoutTests
// ---------------------------------------------------------------------------------

/// `createWorkgroupMemoryExplicitLayoutTests`, restricted to the two ported subgroups.
///
/// `alias`, `zero`, `copy_memory` and `zero_ext` are absent rather than
/// present-and-skipped, so a comparison against `deqp-vk` shows them as missing
/// instead of as passing.
pub fn create_padding_and_size_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("workgroup_memory_explicit_layout");

    let mut padding = TestCaseGroup::new("padding");
    add_padding_tests(&mut padding);
    tests.add_child(padding);

    let mut size = TestCaseGroup::new("size");
    add_size_tests(&mut size);
    tests.add_child(size);

    tests
}

// ---------------------------------------------------------------------------------
// The generated cases, in upstream registration order
// ---------------------------------------------------------------------------------
//
// The generator emits one `pub static` per manifest case and no aggregate, so the
// order `AddPaddingTests` and `AddSizeTests` register in is recorded here. Nothing but
// the identifiers appears below: every parameter lives in
// `shaders/manifest/compute_wmel_padding.toml`.

#[rustfmt::skip]
static PADDING_CASES: [&PaddingCase; 182] = [
    &compute_wmel_padding::PADDING_UINT_0_UINT_4,
    &compute_wmel_padding::PADDING_UINT_0_UINT_20,
    &compute_wmel_padding::PADDING_UINT_0_UINT_36,
    &compute_wmel_padding::PADDING_UINT_0_UINT_52,
    &compute_wmel_padding::PADDING_UINT_0_UINT_68,
    &compute_wmel_padding::PADDING_UINT_0_UINT_84,
    &compute_wmel_padding::PADDING_UINT_0_UINT_100,
    &compute_wmel_padding::PADDING_UINT_0_UINT_116,
    &compute_wmel_padding::PADDING_UINT_4_UINT_8,
    &compute_wmel_padding::PADDING_UINT_4_UINT_24,
    &compute_wmel_padding::PADDING_UINT_4_UINT_40,
    &compute_wmel_padding::PADDING_UINT_4_UINT_56,
    &compute_wmel_padding::PADDING_UINT_4_UINT_72,
    &compute_wmel_padding::PADDING_UINT_4_UINT_88,
    &compute_wmel_padding::PADDING_UINT_4_UINT_104,
    &compute_wmel_padding::PADDING_UINT_4_UINT_120,
    &compute_wmel_padding::PADDING_UINT_8_UINT_12,
    &compute_wmel_padding::PADDING_UINT_8_UINT_28,
    &compute_wmel_padding::PADDING_UINT_8_UINT_44,
    &compute_wmel_padding::PADDING_UINT_8_UINT_60,
    &compute_wmel_padding::PADDING_UINT_8_UINT_76,
    &compute_wmel_padding::PADDING_UINT_8_UINT_92,
    &compute_wmel_padding::PADDING_UINT_8_UINT_108,
    &compute_wmel_padding::PADDING_UINT_8_UINT_124,
    &compute_wmel_padding::PADDING_UINT_12_UINT_16,
    &compute_wmel_padding::PADDING_UINT_12_UINT_32,
    &compute_wmel_padding::PADDING_UINT_12_UINT_48,
    &compute_wmel_padding::PADDING_UINT_12_UINT_64,
    &compute_wmel_padding::PADDING_UINT_12_UINT_80,
    &compute_wmel_padding::PADDING_UINT_12_UINT_96,
    &compute_wmel_padding::PADDING_UINT_12_UINT_112,
    &compute_wmel_padding::PADDING_UINT_16_UINT_20,
    &compute_wmel_padding::PADDING_UINT_16_UINT_36,
    &compute_wmel_padding::PADDING_UINT_16_UINT_52,
    &compute_wmel_padding::PADDING_UINT_16_UINT_68,
    &compute_wmel_padding::PADDING_UINT_16_UINT_84,
    &compute_wmel_padding::PADDING_UINT_16_UINT_100,
    &compute_wmel_padding::PADDING_UINT_16_UINT_116,
    &compute_wmel_padding::PADDING_UINT_20_UINT_24,
    &compute_wmel_padding::PADDING_UINT_20_UINT_40,
    &compute_wmel_padding::PADDING_UINT_20_UINT_56,
    &compute_wmel_padding::PADDING_UINT_20_UINT_72,
    &compute_wmel_padding::PADDING_UINT_20_UINT_88,
    &compute_wmel_padding::PADDING_UINT_20_UINT_104,
    &compute_wmel_padding::PADDING_UINT_20_UINT_120,
    &compute_wmel_padding::PADDING_UINT_24_UINT_28,
    &compute_wmel_padding::PADDING_UINT_24_UINT_44,
    &compute_wmel_padding::PADDING_UINT_24_UINT_60,
    &compute_wmel_padding::PADDING_UINT_24_UINT_76,
    &compute_wmel_padding::PADDING_UINT_24_UINT_92,
    &compute_wmel_padding::PADDING_UINT_24_UINT_108,
    &compute_wmel_padding::PADDING_UINT_24_UINT_124,
    &compute_wmel_padding::PADDING_UINT_28_UINT_32,
    &compute_wmel_padding::PADDING_UINT_28_UINT_48,
    &compute_wmel_padding::PADDING_UINT_28_UINT_64,
    &compute_wmel_padding::PADDING_UINT_28_UINT_80,
    &compute_wmel_padding::PADDING_UINT_28_UINT_96,
    &compute_wmel_padding::PADDING_UINT_28_UINT_112,
    &compute_wmel_padding::PADDING_UINT_32_UINT_36,
    &compute_wmel_padding::PADDING_UINT_32_UINT_52,
    &compute_wmel_padding::PADDING_UINT_32_UINT_68,
    &compute_wmel_padding::PADDING_UINT_32_UINT_84,
    &compute_wmel_padding::PADDING_UINT_32_UINT_100,
    &compute_wmel_padding::PADDING_UINT_32_UINT_116,
    &compute_wmel_padding::PADDING_UINT_36_UINT_40,
    &compute_wmel_padding::PADDING_UINT_36_UINT_56,
    &compute_wmel_padding::PADDING_UINT_36_UINT_72,
    &compute_wmel_padding::PADDING_UINT_36_UINT_88,
    &compute_wmel_padding::PADDING_UINT_36_UINT_104,
    &compute_wmel_padding::PADDING_UINT_36_UINT_120,
    &compute_wmel_padding::PADDING_UINT_40_UINT_44,
    &compute_wmel_padding::PADDING_UINT_40_UINT_60,
    &compute_wmel_padding::PADDING_UINT_40_UINT_76,
    &compute_wmel_padding::PADDING_UINT_40_UINT_92,
    &compute_wmel_padding::PADDING_UINT_40_UINT_108,
    &compute_wmel_padding::PADDING_UINT_40_UINT_124,
    &compute_wmel_padding::PADDING_UINT_44_UINT_48,
    &compute_wmel_padding::PADDING_UINT_44_UINT_64,
    &compute_wmel_padding::PADDING_UINT_44_UINT_80,
    &compute_wmel_padding::PADDING_UINT_44_UINT_96,
    &compute_wmel_padding::PADDING_UINT_44_UINT_112,
    &compute_wmel_padding::PADDING_UINT_48_UINT_52,
    &compute_wmel_padding::PADDING_UINT_48_UINT_68,
    &compute_wmel_padding::PADDING_UINT_48_UINT_84,
    &compute_wmel_padding::PADDING_UINT_48_UINT_100,
    &compute_wmel_padding::PADDING_UINT_48_UINT_116,
    &compute_wmel_padding::PADDING_UINT_52_UINT_56,
    &compute_wmel_padding::PADDING_UINT_52_UINT_72,
    &compute_wmel_padding::PADDING_UINT_52_UINT_88,
    &compute_wmel_padding::PADDING_UINT_52_UINT_104,
    &compute_wmel_padding::PADDING_UINT_52_UINT_120,
    &compute_wmel_padding::PADDING_UINT_56_UINT_60,
    &compute_wmel_padding::PADDING_UINT_56_UINT_76,
    &compute_wmel_padding::PADDING_UINT_56_UINT_92,
    &compute_wmel_padding::PADDING_UINT_56_UINT_108,
    &compute_wmel_padding::PADDING_UINT_56_UINT_124,
    &compute_wmel_padding::PADDING_UINT_60_UINT_64,
    &compute_wmel_padding::PADDING_UINT_60_UINT_80,
    &compute_wmel_padding::PADDING_UINT_60_UINT_96,
    &compute_wmel_padding::PADDING_UINT_60_UINT_112,
    &compute_wmel_padding::PADDING_UINT_64_UINT_68,
    &compute_wmel_padding::PADDING_UINT_64_UINT_84,
    &compute_wmel_padding::PADDING_UINT_64_UINT_100,
    &compute_wmel_padding::PADDING_UINT_64_UINT_116,
    &compute_wmel_padding::PADDING_UINT_68_UINT_72,
    &compute_wmel_padding::PADDING_UINT_68_UINT_88,
    &compute_wmel_padding::PADDING_UINT_68_UINT_104,
    &compute_wmel_padding::PADDING_UINT_68_UINT_120,
    &compute_wmel_padding::PADDING_UINT_72_UINT_76,
    &compute_wmel_padding::PADDING_UINT_72_UINT_92,
    &compute_wmel_padding::PADDING_UINT_72_UINT_108,
    &compute_wmel_padding::PADDING_UINT_72_UINT_124,
    &compute_wmel_padding::PADDING_UINT_76_UINT_80,
    &compute_wmel_padding::PADDING_UINT_76_UINT_96,
    &compute_wmel_padding::PADDING_UINT_76_UINT_112,
    &compute_wmel_padding::PADDING_UINT_80_UINT_84,
    &compute_wmel_padding::PADDING_UINT_80_UINT_100,
    &compute_wmel_padding::PADDING_UINT_80_UINT_116,
    &compute_wmel_padding::PADDING_UINT_84_UINT_88,
    &compute_wmel_padding::PADDING_UINT_84_UINT_104,
    &compute_wmel_padding::PADDING_UINT_84_UINT_120,
    &compute_wmel_padding::PADDING_UINT_88_UINT_92,
    &compute_wmel_padding::PADDING_UINT_88_UINT_108,
    &compute_wmel_padding::PADDING_UINT_88_UINT_124,
    &compute_wmel_padding::PADDING_UINT_92_UINT_96,
    &compute_wmel_padding::PADDING_UINT_92_UINT_112,
    &compute_wmel_padding::PADDING_UINT_96_UINT_100,
    &compute_wmel_padding::PADDING_UINT_96_UINT_116,
    &compute_wmel_padding::PADDING_UINT_100_UINT_104,
    &compute_wmel_padding::PADDING_UINT_100_UINT_120,
    &compute_wmel_padding::PADDING_UINT_104_UINT_108,
    &compute_wmel_padding::PADDING_UINT_104_UINT_124,
    &compute_wmel_padding::PADDING_UINT_108_UINT_112,
    &compute_wmel_padding::PADDING_UINT_112_UINT_116,
    &compute_wmel_padding::PADDING_UINT_116_UINT_120,
    &compute_wmel_padding::PADDING_UINT_120_UINT_124,
    &compute_wmel_padding::PADDING_UINT8_T_0_UINT8_T_1,
    &compute_wmel_padding::PADDING_UINT8_T_0_UINT8_T_17,
    &compute_wmel_padding::PADDING_UINT8_T_1_UINT8_T_2,
    &compute_wmel_padding::PADDING_UINT8_T_1_UINT8_T_18,
    &compute_wmel_padding::PADDING_UINT8_T_2_UINT8_T_3,
    &compute_wmel_padding::PADDING_UINT8_T_2_UINT8_T_19,
    &compute_wmel_padding::PADDING_UINT8_T_3_UINT8_T_4,
    &compute_wmel_padding::PADDING_UINT8_T_3_UINT8_T_20,
    &compute_wmel_padding::PADDING_UINT8_T_4_UINT8_T_5,
    &compute_wmel_padding::PADDING_UINT8_T_4_UINT8_T_21,
    &compute_wmel_padding::PADDING_UINT8_T_5_UINT8_T_6,
    &compute_wmel_padding::PADDING_UINT8_T_5_UINT8_T_22,
    &compute_wmel_padding::PADDING_UINT8_T_6_UINT8_T_7,
    &compute_wmel_padding::PADDING_UINT8_T_6_UINT8_T_23,
    &compute_wmel_padding::PADDING_UINT8_T_7_UINT8_T_8,
    &compute_wmel_padding::PADDING_UINT8_T_7_UINT8_T_24,
    &compute_wmel_padding::PADDING_UINT8_T_8_UINT8_T_9,
    &compute_wmel_padding::PADDING_UINT8_T_8_UINT8_T_25,
    &compute_wmel_padding::PADDING_UINT8_T_9_UINT8_T_10,
    &compute_wmel_padding::PADDING_UINT8_T_9_UINT8_T_26,
    &compute_wmel_padding::PADDING_UINT8_T_10_UINT8_T_11,
    &compute_wmel_padding::PADDING_UINT8_T_10_UINT8_T_27,
    &compute_wmel_padding::PADDING_UINT8_T_11_UINT8_T_12,
    &compute_wmel_padding::PADDING_UINT8_T_11_UINT8_T_28,
    &compute_wmel_padding::PADDING_UINT8_T_12_UINT8_T_13,
    &compute_wmel_padding::PADDING_UINT8_T_12_UINT8_T_29,
    &compute_wmel_padding::PADDING_UINT8_T_13_UINT8_T_14,
    &compute_wmel_padding::PADDING_UINT8_T_13_UINT8_T_30,
    &compute_wmel_padding::PADDING_UINT8_T_14_UINT8_T_15,
    &compute_wmel_padding::PADDING_UINT8_T_14_UINT8_T_31,
    &compute_wmel_padding::PADDING_UINT8_T_15_UINT8_T_16,
    &compute_wmel_padding::PADDING_UINT8_T_16_UINT8_T_17,
    &compute_wmel_padding::PADDING_UINT8_T_17_UINT8_T_18,
    &compute_wmel_padding::PADDING_UINT8_T_18_UINT8_T_19,
    &compute_wmel_padding::PADDING_UINT8_T_19_UINT8_T_20,
    &compute_wmel_padding::PADDING_UINT8_T_20_UINT8_T_21,
    &compute_wmel_padding::PADDING_UINT8_T_21_UINT8_T_22,
    &compute_wmel_padding::PADDING_UINT8_T_22_UINT8_T_23,
    &compute_wmel_padding::PADDING_UINT8_T_23_UINT8_T_24,
    &compute_wmel_padding::PADDING_UINT8_T_24_UINT8_T_25,
    &compute_wmel_padding::PADDING_UINT8_T_25_UINT8_T_26,
    &compute_wmel_padding::PADDING_UINT8_T_26_UINT8_T_27,
    &compute_wmel_padding::PADDING_UINT8_T_27_UINT8_T_28,
    &compute_wmel_padding::PADDING_UINT8_T_28_UINT8_T_29,
    &compute_wmel_padding::PADDING_UINT8_T_29_UINT8_T_30,
    &compute_wmel_padding::PADDING_UINT8_T_30_UINT8_T_31,
];

#[rustfmt::skip]
static SIZE_CASES: [&SizeCase; 7] = [
    &compute_wmel_padding::SIZE_8,
    &compute_wmel_padding::SIZE_64,
    &compute_wmel_padding::SIZE_4096,
    &compute_wmel_padding::SIZE_16384,
    &compute_wmel_padding::SIZE_32768,
    &compute_wmel_padding::SIZE_49152,
    &compute_wmel_padding::SIZE_65536,
];
