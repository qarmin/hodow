// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeShaderBuiltinVarTests.cpp
//   external/vulkancts/modules/vulkan/compute/vktComputeBasicComputeShaderTests.cpp
//     (createBasicDeviceGroupComputeShaderTests, create64bIndexingComputeShaderTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
// Vendored original: hodow_cts/upstream/modules/vulkan/compute/
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Copyright (c) 2016 The Android Open Source Project
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Three upstream groups live in this one file: builtin_var comes from its own upstream
// file, device_group and 64b_indexing are three and five cases at the tail of
// vktComputeBasicComputeShaderTests.cpp. As everywhere else in this directory, the
// structure follows the C++ - same checkSupport / initPrograms (the manifest) /
// iterate split, same order of operations, same names - and MultiQueueRunnerTestInstance
// is not ported, so the cases run on the universal queue only.
//
// Two divergences are worth knowing about before reading:
//
// * device_group. Upstream's ComputeTestInstance builds its own instance with
//   VK_KHR_device_group_creation and its own device with VkDeviceGroupDeviceCreateInfo,
//   so it can spread one dispatch over every physical device in the group. hodow_cts
//   has no custom-device support, so these run on the default device, which is a device
//   group of one. On a single-GPU machine that is the same test; on a multi-GPU one it
//   covers strictly less. `NUM_PHYS_DEVICES` stands in for `m_numPhysDevices` so the
//   loops still line up with the C++.
//
// * 64b_indexing. Every copy_ssbo_64b* case asks for an 8 GB buffer and therefore for
//   VK_EXT_shader_64bit_indexing, so checkSupport ends in NotSupported on every
//   implementation seen so far. The two bounds-checking cases additionally need a
//   device with robustBufferAccess2 enabled (upstream's createRobustDevice), which is
//   again a custom device: they report NotPorted rather than running without it, since
//   unrobust out-of-bounds reads would look exactly like a driver bug. untyped_pointers
//   has no shader at all - upstream writes it in SPIR-V assembly, which the shader
//   manifest cannot express.
//
// Parameters are NOT written here: they come from `generated::shaders`, which
// shaders/manifest/compute_builtin_var.toml generates.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use crate::generated::shaders::compute_builtin_var;
use crate::tcu::{self, IVec3, Random, TestError, TestOutcome, TestStatus, UVec3, multiply_components};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool, make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::{BinaryCollection, ProgramBinary, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};
use crate::{tcu_fail, tcu_not_ported};

// =================================================================================
// dEQP-VK.compute.pipeline.builtin_var.*
// =================================================================================

/// `s_prefixProgramName`
const S_PREFIX_PROGRAM_NAME: &str = "compute_";

/// The slice of `glu::DataType` these tests use. Upstream's `genBuiltinVarSource`
/// switch also handles UINT_VEC2 and UINT_VEC4; no builtin_var case selects them, so
/// they are left out per the on-demand rule for the framework layer.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DataType {
    /// `glu::TYPE_UINT`
    Uint,
    /// `glu::TYPE_UINT_VEC3`
    UintVec3,
}

/// `glu::getDataTypeScalarSize`
fn get_data_type_scalar_size(data_type: DataType) -> i32 {
    match data_type {
        DataType::Uint => 1,
        DataType::UintVec3 => 3,
    }
}

/// Which builtin a case reads, i.e. which `ComputeBuiltinVarCase::computeReference`
/// override applies. Rust has no virtual dispatch on a plain struct, so the six
/// overrides are gathered into `compute_reference` below and selected by this.
#[derive(Clone, Copy)]
pub enum BuiltinVar {
    /// `NumWorkGroupsCase`
    NumWorkGroups,
    /// `WorkGroupSizeCase`
    WorkGroupSize,
    /// `WorkGroupIDCase`
    WorkGroupId,
    /// `LocalInvocationIDCase`
    LocalInvocationId,
    /// `GlobalInvocationIDCase`
    GlobalInvocationId,
    /// `LocalInvocationIndexCase`
    LocalInvocationIndex,
}

/// The six `computeReference` implementations.
fn compute_reference(builtin: BuiltinVar, num_work_groups: UVec3, work_group_size: UVec3, work_group_id: UVec3, local_invocation_id: UVec3) -> UVec3 {
    match builtin {
        BuiltinVar::NumWorkGroups => num_work_groups,
        BuiltinVar::WorkGroupSize => work_group_size,
        BuiltinVar::WorkGroupId => work_group_id,
        BuiltinVar::LocalInvocationId => local_invocation_id,
        BuiltinVar::GlobalInvocationId => uvec3_add(uvec3_mul(work_group_id, work_group_size), local_invocation_id),
        BuiltinVar::LocalInvocationIndex => UVec3::new(
            local_invocation_id.z() * work_group_size.x() * work_group_size.y() + local_invocation_id.y() * work_group_size.x() + local_invocation_id.x(),
            0,
            0,
        ),
    }
}

/// `tcu::Vector::operator*`, which the tcu port does not have yet.
fn uvec3_mul(a: UVec3, b: UVec3) -> UVec3 {
    UVec3::new(a.x() * b.x(), a.y() * b.y(), a.z() * b.z())
}

/// `tcu::Vector::operator+`, which the tcu port does not have yet.
fn uvec3_add(a: UVec3, b: UVec3) -> UVec3 {
    UVec3::new(a.x() + b.x(), a.y() + b.y(), a.z() + b.z())
}

/// `compareNumComponents`
fn compare_num_components(a: UVec3, b: UVec3, num_comps: i32) -> bool {
    debug_assert!(num_comps == 1 || num_comps == 3);
    if num_comps == 3 { a == b } else { a.x() == b.x() }
}

/// `readResultVec`
fn read_result_vec(ptr: *const u32, num_comps: i32) -> UVec3 {
    let mut res = [0u32; 3];
    for (ndx, component) in res.iter_mut().enumerate().take(num_comps as usize) {
        *component = unsafe { *ptr.add(ndx) };
    }
    UVec3::from_array(res)
}

/// `LogComps` - upstream prints one component or three depending on the type.
fn log_comps(v: UVec3, num_comps: i32) -> String {
    debug_assert!(num_comps == 1 || num_comps == 3);
    if num_comps == 3 {
        format!("({}, {}, {})", v.x(), v.y(), v.z())
    } else {
        format!("{}", v.x())
    }
}

/// `SubCase`
#[derive(Clone, Copy)]
pub struct SubCase {
    m_local_size: UVec3,
    m_num_work_groups: UVec3,
}

impl SubCase {
    fn new(local_size: UVec3, num_work_groups: UVec3) -> Self {
        Self {
            m_local_size: local_size,
            m_num_work_groups: num_work_groups,
        }
    }

    fn local_size(&self) -> UVec3 {
        self.m_local_size
    }

    fn num_work_groups(&self) -> UVec3 {
        self.m_num_work_groups
    }
}

/// Declares one of the six `ComputeBuiltinVarCase` subclasses.
///
/// They differ in exactly two things: how many sub-cases they carry, and which
/// `computeReference` they select. The sub-case count is what forces one struct per
/// subclass - it fixes the number of `local_size_<i>` / `num_work_groups_<i>` fields
/// the manifest fills in, and a Rust struct cannot have a variable number of those.
/// `builtin`, `var_type` and `read_by_component` are ordinary per-case parameters and
/// come from the manifest like everything else.
macro_rules! compute_builtin_var_case {
    ($case:ident, $(($local_size:ident, $num_work_groups:ident)),+ $(,)?) => {
        #[derive(Clone, Copy)]
        pub struct $case {
            pub name: &'static str,
            pub builtin: BuiltinVar,
            pub var_type: DataType,
            pub read_by_component: bool,
            $(
                pub $local_size: UVec3,
                pub $num_work_groups: UVec3,
            )+
            pub programs: BinaryCollection,
        }

        impl $case {
            /// The `m_subCases.push_back(...)` list from the upstream constructor.
            fn sub_cases(&self) -> Vec<SubCase> {
                vec![$(SubCase::new(self.$local_size, self.$num_work_groups)),+]
            }
        }

        impl TestCase for $case {
            fn name(&self) -> &str {
                self.name
            }

            fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
                check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
            }

            fn programs(&self) -> BinaryCollection {
                self.programs
            }

            fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
                Box::new(ComputeBuiltinVarInstance {
                    context,
                    sub_cases: self.sub_cases(),
                    builtin_var_case: self.builtin,
                    var_type: self.var_type,
                })
            }
        }
    };
}

compute_builtin_var_case!(
    NumWorkGroupsCase,
    (local_size_0, num_work_groups_0),
    (local_size_1, num_work_groups_1),
    (local_size_2, num_work_groups_2),
    (local_size_3, num_work_groups_3),
    (local_size_4, num_work_groups_4),
    (local_size_5, num_work_groups_5),
);

compute_builtin_var_case!(
    WorkGroupSizeCase,
    (local_size_0, num_work_groups_0),
    (local_size_1, num_work_groups_1),
    (local_size_2, num_work_groups_2),
    (local_size_3, num_work_groups_3),
    (local_size_4, num_work_groups_4),
    (local_size_5, num_work_groups_5),
    (local_size_6, num_work_groups_6),
    (local_size_7, num_work_groups_7),
    (local_size_8, num_work_groups_8),
);

compute_builtin_var_case!(
    WorkGroupIdCase,
    (local_size_0, num_work_groups_0),
    (local_size_1, num_work_groups_1),
    (local_size_2, num_work_groups_2),
    (local_size_3, num_work_groups_3),
    (local_size_4, num_work_groups_4),
    (local_size_5, num_work_groups_5),
);

compute_builtin_var_case!(
    LocalInvocationIdCase,
    (local_size_0, num_work_groups_0),
    (local_size_1, num_work_groups_1),
    (local_size_2, num_work_groups_2),
    (local_size_3, num_work_groups_3),
    (local_size_4, num_work_groups_4),
    (local_size_5, num_work_groups_5),
    (local_size_6, num_work_groups_6),
    (local_size_7, num_work_groups_7),
    (local_size_8, num_work_groups_8),
);

compute_builtin_var_case!(
    GlobalInvocationIdCase,
    (local_size_0, num_work_groups_0),
    (local_size_1, num_work_groups_1),
    (local_size_2, num_work_groups_2),
    (local_size_3, num_work_groups_3),
    (local_size_4, num_work_groups_4),
    (local_size_5, num_work_groups_5),
    (local_size_6, num_work_groups_6),
    (local_size_7, num_work_groups_7),
);

compute_builtin_var_case!(
    LocalInvocationIndexCase,
    (local_size_0, num_work_groups_0),
    (local_size_1, num_work_groups_1),
    (local_size_2, num_work_groups_2),
    (local_size_3, num_work_groups_3),
    (local_size_4, num_work_groups_4),
    (local_size_5, num_work_groups_5),
);

/// `ComputeBuiltinVarInstance`
struct ComputeBuiltinVarInstance<'a> {
    context: &'a Context<'a>,
    sub_cases: Vec<SubCase>,
    builtin_var_case: BuiltinVar,
    var_type: DataType,
}

impl TestInstance for ComputeBuiltinVarInstance<'_> {
    /// `ComputeBuiltinVarInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let m_vki = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        for (sub_case_ndx, sub_case) in self.sub_cases.iter().enumerate() {
            let program_name = format!("{S_PREFIX_PROGRAM_NAME}{sub_case_ndx}");

            let global_size = uvec3_mul(sub_case.local_size(), sub_case.num_work_groups());
            // tcu has no UVec2 yet, and `stride` is only ever indexed, never passed on.
            let stride = [global_size.x() * global_size.y(), global_size.x()];
            let size_of_uniform_buffer = std::mem::size_of_val(&stride) as u64;
            let num_scalars = get_data_type_scalar_size(self.var_type);
            let num_invocations = sub_case.local_size().x()
                * sub_case.local_size().y()
                * sub_case.local_size().z()
                * sub_case.num_work_groups().x()
                * sub_case.num_work_groups().y()
                * sub_case.num_work_groups().z();

            let result_buffer_stride = match self.var_type {
                DataType::Uint => std::mem::size_of::<u32>() as u32,
                DataType::UintVec3 => std::mem::size_of::<tcu::UVec4>() as u32,
            };

            let result_buffer_size = num_invocations * result_buffer_stride;

            // Create result buffer
            let uniform_buffer = BufferWithMemory::new(
                m_vki,
                self.context.get_default_allocator(),
                make_buffer_create_info(size_of_uniform_buffer, vk::BufferUsageFlags::UNIFORM_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let result_buffer = BufferWithMemory::new(
                m_vki,
                self.context.get_default_allocator(),
                make_buffer_create_info(result_buffer_size as u64, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            {
                let alloc = uniform_buffer.get_allocation();
                unsafe { std::ptr::copy_nonoverlapping(stride.as_ptr().cast::<u8>(), alloc.get_host_ptr(), size_of_uniform_buffer as usize) };
                flush_alloc(m_vki, alloc)?;
            }

            // Create descriptorSetLayout
            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .build(m_vki)?;

            let mut pipeline = ComputePipelineWrapper::new(m_vki, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get(&program_name)?);
            pipeline.set_descriptor_set_layout(*descriptor_set_layout);
            pipeline.build_pipeline()?;

            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .build(m_vki, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

            let buffer_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, result_buffer.get(), 0, result_buffer_size as u64);

            let cmd_pool = make_command_pool(m_vki, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(m_vki, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

            // Start recording commands
            begin_command_buffer(m_vki, *cmd_buffer)?;

            pipeline.bind(*cmd_buffer);

            // Create descriptor set
            let descriptor_set = make_descriptor_set(m_vki, *descriptor_pool, *descriptor_set_layout)?;

            let result_descriptor_info = make_descriptor_buffer_info(result_buffer.get(), 0, result_buffer_size as u64);
            let uniform_descriptor_info = make_descriptor_buffer_info(uniform_buffer.get(), 0, size_of_uniform_buffer);

            DescriptorSetUpdateBuilder::new()
                .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::UNIFORM_BUFFER, &uniform_descriptor_info)
                .write_single(*descriptor_set, Location::binding(1), vk::DescriptorType::STORAGE_BUFFER, &result_descriptor_info)
                .update(m_vki);

            unsafe {
                m_vki.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

                m_vki.cmd_dispatch(*cmd_buffer, sub_case.num_work_groups().x(), sub_case.num_work_groups().y(), sub_case.num_work_groups().z());

                m_vki.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            // End recording commands
            end_command_buffer(m_vki, *cmd_buffer)?;

            // Wait for command buffer execution finish
            submit_commands_and_wait(m_vki, queue, *cmd_buffer)?;

            let result_alloc = result_buffer.get_allocation();
            invalidate_alloc(m_vki, result_alloc)?;

            let ptr = result_alloc.get_host_ptr().cast_const();

            let mut num_failed = 0;
            const MAX_LOG_PRINTS: i32 = 10;

            for group_z in 0..sub_case.num_work_groups().z() {
                for group_y in 0..sub_case.num_work_groups().y() {
                    for group_x in 0..sub_case.num_work_groups().x() {
                        for local_z in 0..sub_case.local_size().z() {
                            for local_y in 0..sub_case.local_size().y() {
                                for local_x in 0..sub_case.local_size().x() {
                                    let ref_group_id = UVec3::new(group_x, group_y, group_z);
                                    let ref_local_id = UVec3::new(local_x, local_y, local_z);
                                    let ref_global_id = uvec3_add(uvec3_mul(ref_group_id, sub_case.local_size()), ref_local_id);

                                    let ref_offset = stride[0] * ref_global_id.z() + stride[1] * ref_global_id.y() + ref_global_id.x();

                                    let ref_value = compute_reference(self.builtin_var_case, sub_case.num_work_groups(), sub_case.local_size(), ref_group_id, ref_local_id);

                                    let res_ptr = unsafe { ptr.add((ref_offset * result_buffer_stride) as usize) }.cast::<u32>();
                                    let res_value = read_result_vec(res_ptr, num_scalars);

                                    if !compare_num_components(ref_value, res_value, num_scalars) {
                                        if num_failed < MAX_LOG_PRINTS {
                                            log::error!(
                                                "ERROR: comparison failed at offset {ref_offset}: expected {}, got {}",
                                                log_comps(ref_value, num_scalars),
                                                log_comps(res_value, num_scalars)
                                            );
                                        } else if num_failed == MAX_LOG_PRINTS {
                                            log::error!("...");
                                        }

                                        num_failed += 1;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            log::info!("{} / {num_invocations} values passed", num_invocations - num_failed as u32);

            if num_failed > 0 {
                return Ok(TestStatus::fail("Comparison failed"));
            }
        }
        Ok(TestStatus::pass("Comparison succeeded"))
    }
}

// =================================================================================
// dEQP-VK.compute.pipeline.device_group.*
// =================================================================================

/// `ComputeTestInstance::m_numPhysDevices`, pinned to one.
///
/// Upstream enumerates the physical device groups and splits the dispatch across every
/// device in the selected one. The port runs on the default device, i.e. a group of
/// one - see the divergence note at the top of this file. The loops below are kept in
/// the shape upstream wrote them so a future custom-device path only has to replace
/// this constant.
const NUM_PHYS_DEVICES: u32 = 1;

/// A compute pipeline built with explicit `VkPipelineCreateFlags` /
/// `VkPipelineCreateFlags2CreateInfo`.
///
/// `ComputePipelineWrapper` has no `setPipelineCreateFlags`, and dispatch_base cannot
/// work without `VK_PIPELINE_CREATE_DISPATCH_BASE`. Everything else here is the same
/// sequence `ComputePipelineWrapper::buildPipeline` runs.
struct FlaggedComputePipeline<'a> {
    device: &'a Device,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pipeline: Unique<'a, vk::Pipeline>,
}

impl<'a> FlaggedComputePipeline<'a> {
    fn new(
        device: &'a Device,
        binary: ProgramBinary,
        descriptor_set_layout: vk::DescriptorSetLayout,
        flags: vk::PipelineCreateFlags,
        flags2: Option<vk::PipelineCreateFlags2>,
    ) -> Result<Self, TestError> {
        let set_layouts = [descriptor_set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;
        let pipeline_layout = Unique::new(device, pipeline_layout);

        let shader_module = create_shader_module(device, binary)?;

        let entry_point = b"main\0";
        let stage = vk::PipelineShaderStageCreateInfo {
            s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::PipelineShaderStageCreateFlags::empty(),
            stage: vk::ShaderStageFlags::COMPUTE,
            module: *shader_module,
            name: entry_point.as_ptr().cast(),
            specialization_info: std::ptr::null(),
        };

        let flags2_info = flags2.map(|f| vk::PipelineCreateFlags2CreateInfo {
            s_type: vk::StructureType::PIPELINE_CREATE_FLAGS_2_CREATE_INFO,
            next: std::ptr::null(),
            flags: f,
        });

        let create_info = vk::ComputePipelineCreateInfo {
            s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
            next: flags2_info.as_ref().map_or(std::ptr::null(), |i| std::ptr::from_ref(i).cast()),
            flags,
            stage,
            layout: *pipeline_layout,
            base_pipeline_handle: vk::Pipeline::null(),
            base_pipeline_index: -1,
        };

        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
            .map_err(|e| TestError::InternalError(format!("vkCreateComputePipelines returned {e:?}")))?;

        Ok(Self {
            device,
            pipeline_layout,
            pipeline: Unique::new(device, pipelines.0[0]),
        })
    }

    fn get_pipeline_layout(&self) -> vk::PipelineLayout {
        *self.pipeline_layout
    }

    fn bind(&self, cmd_buffer: vk::CommandBuffer) {
        unsafe { self.device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *self.pipeline) };
    }
}

#[derive(Clone, Copy)]
pub struct DispatchBaseCase {
    pub name: &'static str,
    pub num_values: u32,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub split_size: IVec3,
    pub use_maintenance5: bool,
    pub programs: BinaryCollection,
}

impl TestCase for DispatchBaseCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_device_group")?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;
        if self.use_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DispatchBaseInstance {
            context,
            num_values: self.num_values,
            local_size: self.local_size,
            work_size: self.work_size,
            split_work_size: self.split_size,
            use_maintenance5: self.use_maintenance5,
        })
    }
}

struct DispatchBaseInstance<'a> {
    context: &'a Context<'a>,
    num_values: u32,
    local_size: IVec3,
    work_size: IVec3,
    split_work_size: IVec3,
    use_maintenance5: bool,
}

/// `DispatchBaseTestInstance::isInputVectorValid`
fn is_input_vector_valid(small: IVec3, big: IVec3) -> bool {
    !(((big.x() < small.x()) || (big.y() < small.y()) || (big.z() < small.z())) || ((big.x() % small.x() != 0) || (big.y() % small.y() != 0) || (big.z() % small.z() != 0)))
}

impl TestInstance for DispatchBaseInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // The upstream constructor validates the sizes and throws tcu::TestError, which
        // is a Fail verdict; there is no fallible createInstance here, so it happens on
        // the way into iterate instead.

        // For easy work distribution across physical devices:
        // WorkSize should be a multiple of SplitWorkSize only in the X component
        if (!is_input_vector_valid(self.split_work_size, self.work_size))
            || (self.work_size.x() <= self.split_work_size.x())
            || (self.work_size.y() != self.split_work_size.y())
            || (self.work_size.z() != self.split_work_size.z())
        {
            tcu_fail!("Invalid Input.");
        }

        // For easy work distribution within the same physical device:
        // SplitWorkSize should be a multiple of localSize in Y or Z component
        if (!is_input_vector_valid(self.local_size, self.split_work_size))
            || (self.local_size.x() != self.split_work_size.x())
            || (self.local_size.y() >= self.split_work_size.y())
            || (self.local_size.z() >= self.split_work_size.z())
        {
            tcu_fail!("Invalid Input.");
        }

        if (multiply_components(self.work_size) / multiply_components(self.split_work_size)) < NUM_PHYS_DEVICES as i32 {
            tcu_fail!("Not enough work to distribute across all physical devices.");
        }

        let total_work = (multiply_components(self.work_size) * multiply_components(self.local_size)) as u32;
        if (total_work > self.num_values) || !self.num_values.is_multiple_of(total_work) {
            tcu_fail!("Buffer too small/not aligned to cover all values.");
        }

        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let m_queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();
        let mut total_workload_size = 0u32;

        // Create an uniform and input/output buffer
        let uniform_buf_size = 3u64; // Pass the compute grid size
        let uniform_buffer_size_bytes = std::mem::size_of::<u32>() as u64 * uniform_buf_size;
        let uniform_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(uniform_buffer_size_bytes, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let buffer_size_bytes = std::mem::size_of::<u32>() as u64 * self.num_values as u64;
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the buffers with data
        let mut input_data: Vec<u32> = Vec::with_capacity(self.num_values as usize);

        {
            let buffer_allocation = uniform_buffer.get_allocation();
            let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();
            unsafe {
                *buffer_ptr = self.work_size.x() as u32;
                *buffer_ptr.add(1) = self.work_size.y() as u32;
                *buffer_ptr.add(2) = self.work_size.z() as u32;
            }
            flush_alloc(vk, buffer_allocation)?;
        }

        {
            let mut rnd = Random::new(0x82ce7f);
            let buffer_allocation = buffer.get_allocation();
            let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();
            for i in 0..self.num_values {
                let value = rnd.get_uint32();
                input_data.push(value);
                unsafe { *buffer_ptr.add(i as usize) = value };
            }
            flush_alloc(vk, buffer_allocation)?;
        }

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size_bytes);
        let uniform_buffer_descriptor_info = make_descriptor_buffer_info(uniform_buffer.get(), 0, uniform_buffer_size_bytes);

        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer_descriptor_info)
            .write_single(*descriptor_set, Location::binding(1), vk::DescriptorType::UNIFORM_BUFFER, &uniform_buffer_descriptor_info)
            .update(vk);

        // maintenance5 asks for the same thing through VkPipelineCreateFlags2CreateInfo
        // and clears the old flags word, which is the point of that case.
        let (pipeline_flags, pipeline_flags2) = if self.use_maintenance5 {
            (vk::PipelineCreateFlags::empty(), Some(vk::PipelineCreateFlags2::DISPATCH_BASE))
        } else {
            (vk::PipelineCreateFlags::DISPATCH_BASE, None)
        };

        let pipeline = FlaggedComputePipeline::new(
            vk,
            self.context.get_binary_collection().get("comp")?,
            *descriptor_set_layout,
            pipeline_flags,
            pipeline_flags2,
        )?;

        let host_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::SHADER_READ, buffer.get(), 0, buffer_size_bytes);
        let host_uniform_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::UNIFORM_READ,
            uniform_buffer.get(),
            0,
            uniform_buffer_size_bytes,
        );

        let shader_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, buffer.get(), 0, buffer_size_bytes);

        let cmd_pool = make_command_pool(vk, m_queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands
        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_uniform_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // Split the workload across all physical devices based on m_splitWorkSize.x()
            for phys_dev_idx in 0..NUM_PHYS_DEVICES {
                let base_group_x = phys_dev_idx * self.split_work_size.x() as u32;
                let base_group_y = 0u32;
                let base_group_z = 0u32;

                // Split the workload within the physical device based on m_localSize.y() and m_localSize.z()
                for local_idx_y in 0..(self.split_work_size.y() / self.local_size.y()) {
                    for local_idx_z in 0..(self.split_work_size.z() / self.local_size.z()) {
                        let offset_x = base_group_x;
                        let offset_y = base_group_y + (local_idx_y * self.local_size.y()) as u32;
                        let offset_z = base_group_z + (local_idx_z * self.local_size.z()) as u32;

                        let local_size_x = if phys_dev_idx == (NUM_PHYS_DEVICES - 1) {
                            self.work_size.x() as u32 - base_group_x
                        } else {
                            self.local_size.x() as u32
                        };
                        let local_size_y = self.local_size.y() as u32;
                        let local_size_z = self.local_size.z() as u32;

                        total_workload_size += local_size_x * local_size_y * local_size_z;
                        vk.cmd_dispatch_base(*cmd_buffer, offset_x, offset_y, offset_z, local_size_x, local_size_y, local_size_z);
                    }
                }
            }

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        if total_workload_size != multiply_components(self.work_size) as u32 {
            tcu_fail!("Not covering the entire workload.");
        }

        // Validate the results
        let buffer_allocation = buffer.get_allocation();
        invalidate_alloc(vk, buffer_allocation)?;
        let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();

        for ndx in 0..self.num_values {
            let res = unsafe { *buffer_ptr.add(ndx as usize) };
            let reference = !input_data[ndx as usize];

            if res != reference {
                return Ok(TestStatus::fail(format!("Comparison failed for InOut.values[{ndx}]")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

#[derive(Clone, Copy)]
pub struct DeviceIndexCase {
    pub name: &'static str,
    pub num_values: u32,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub max_device_group_size: u32,
    pub programs: BinaryCollection,
}

impl TestCase for DeviceIndexCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        // The manifest value sizes the uniform block in the shader; it has to stay the
        // header constant, or the block and the buffer stop describing the same thing.
        debug_assert_eq!(self.max_device_group_size as usize, vk::MAX_DEVICE_GROUP_SIZE);
        Box::new(DeviceIndexInstance {
            context,
            num_values: self.num_values,
            work_size: self.work_size,
            max_device_group_size: self.max_device_group_size,
        })
    }
}

struct DeviceIndexInstance<'a> {
    context: &'a Context<'a>,
    num_values: u32,
    work_size: IVec3,
    max_device_group_size: u32,
}

/// A buffer plus the memory backing it, allocated by hand so that
/// `VkMemoryAllocateFlagsInfo` can be chained onto the allocation - `SimpleAllocator`
/// has no way to pass a pNext. Field order matters: the buffer has to be destroyed
/// before the memory it is bound to is freed, and fields drop in declaration order.
struct DeviceMaskBuffer<'a> {
    buffer: Unique<'a, vk::Buffer>,
    _memory: Unique<'a, vk::DeviceMemory>,
}

impl TestInstance for DeviceIndexInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let m_queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();
        let alloc_device_mask = (1u32 << NUM_PHYS_DEVICES) - 1;
        let mut rnd = Random::new(0x82ce7f);

        // Create an uniform and output buffer
        let uniform_buf_size = 4 * (1 + self.max_device_group_size);
        let uniform_buffer_size_bytes = std::mem::size_of::<u32>() as u64 * uniform_buf_size as u64;
        let uniform_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(uniform_buffer_size_bytes, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let buffer_size_bytes = std::mem::size_of::<u32>() as u64 * self.num_values as u64;
        let check_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // create SBO buffer
        let sbo = {
            let sbo_buffer_params = vk::BufferCreateInfo {
                s_type: vk::StructureType::BUFFER_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::BufferCreateFlags::empty(),
                size: buffer_size_bytes,
                usage: vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
                sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 1,
                queue_family_indices: &m_queue_family_index,
            };
            let sbo_buffer = unsafe { vk.create_buffer(&sbo_buffer_params, None) }.vk_check("vkCreateBuffer")?;
            let sbo_buffer = Unique::new(vk, sbo_buffer);

            let mem_reqs = unsafe { vk.get_buffer_memory_requirements(*sbo_buffer) };
            let device_mem_props = unsafe { self.context.get_instance().get_physical_device_memory_properties(self.context.get_physical_device()) };
            let mut memory_type_ndx = 0;
            while memory_type_ndx < device_mem_props.memory_type_count {
                if (mem_reqs.memory_type_bits & (1u32 << memory_type_ndx)) != 0
                    && device_mem_props.memory_types[memory_type_ndx as usize]
                        .property_flags
                        .contains(vk::MemoryPropertyFlags::DEVICE_LOCAL)
                {
                    break;
                }
                memory_type_ndx += 1;
            }
            if memory_type_ndx == device_mem_props.memory_type_count {
                return Err(TestError::NotSupported("No compatible memory type found".to_string()));
            }

            let alloc_device_mask_info = vk::MemoryAllocateFlagsInfo {
                s_type: vk::StructureType::MEMORY_ALLOCATE_FLAGS_INFO,
                next: std::ptr::null(),
                flags: vk::MemoryAllocateFlags::DEVICE_MASK,
                device_mask: alloc_device_mask,
            };

            let alloc_info = vk::MemoryAllocateInfo {
                s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
                next: std::ptr::from_ref(&alloc_device_mask_info).cast(),
                allocation_size: mem_reqs.size,
                memory_type_index: memory_type_ndx,
            };

            let sbo_buffer_memory = unsafe { vk.allocate_memory(&alloc_info, None) }.vk_check("vkAllocateMemory")?;
            let sbo_buffer_memory = Unique::new(vk, sbo_buffer_memory);
            unsafe { vk.bind_buffer_memory(*sbo_buffer, *sbo_buffer_memory, 0) }.vk_check("vkBindBufferMemory")?;

            DeviceMaskBuffer {
                buffer: sbo_buffer,
                _memory: sbo_buffer_memory,
            }
        };

        // Fill the buffers with data
        let mut uniform_input_data: Vec<u32> = vec![0; uniform_buf_size as usize];

        {
            let buffer_allocation = uniform_buffer.get_allocation();
            let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();
            for (i, value) in uniform_input_data.iter_mut().enumerate() {
                // divide to prevent overflow in addition
                *value = rnd.get_uint32() / 10;
                unsafe { *buffer_ptr.add(i) = *value };
            }
            flush_alloc(vk, buffer_allocation)?;
        }

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_descriptor_info = make_descriptor_buffer_info(*sbo.buffer, 0, buffer_size_bytes);
        let uniform_buffer_descriptor_info = make_descriptor_buffer_info(uniform_buffer.get(), 0, uniform_buffer_size_bytes);

        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer_descriptor_info)
            .write_single(*descriptor_set, Location::binding(1), vk::DescriptorType::UNIFORM_BUFFER, &uniform_buffer_descriptor_info)
            .update(vk);

        let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let host_uniform_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::UNIFORM_READ,
            uniform_buffer.get(),
            0,
            uniform_buffer_size_bytes,
        );
        let shader_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::TRANSFER_READ, *sbo.buffer, 0, buffer_size_bytes);

        let cmd_pool = make_command_pool(vk, m_queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Verify multiple device masks
        for phys_dev_mask in 1..(1u32 << NUM_PHYS_DEVICES) {
            // divide to prevent overflow in addition
            let constant_val_per_loop = rnd.get_uint32() / 10;
            {
                let buffer_allocation = uniform_buffer.get_allocation();
                let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();
                unsafe { *buffer_ptr = constant_val_per_loop };
                flush_alloc(vk, buffer_allocation)?;
            }
            begin_command_buffer(vk, *cmd_buffer)?;

            pipeline.bind(*cmd_buffer);
            unsafe {
                vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
                vk.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[host_uniform_write_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );

                vk.cmd_set_device_mask(*cmd_buffer, phys_dev_mask);
                vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);

                vk.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[shader_write_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(vk, *cmd_buffer)?;
            // Upstream passes the device mask through VkDeviceGroupSubmitInfo here. With
            // a group of one the default mask is the same submission, so the shared
            // helper is used unchanged.
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;

            // Validate the results on all physical devices where compute shader was launched
            let src_buffer_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::TRANSFER_READ, *sbo.buffer, 0, buffer_size_bytes);
            let dst_buffer_barrier = make_buffer_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ, check_buffer.get(), 0, buffer_size_bytes);
            let copy_params = vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: buffer_size_bytes,
            };

            for phys_dev_idx in 0..NUM_PHYS_DEVICES {
                if ((1u32 << phys_dev_idx) & phys_dev_mask) == 0 {
                    continue;
                }

                let device_mask = 1u32 << phys_dev_idx;

                begin_command_buffer(vk, *cmd_buffer)?;
                unsafe {
                    vk.cmd_set_device_mask(*cmd_buffer, device_mask);
                    vk.cmd_pipeline_barrier(
                        *cmd_buffer,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[src_buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                    vk.cmd_copy_buffer(*cmd_buffer, *sbo.buffer, check_buffer.get(), &[copy_params]);
                    vk.cmd_pipeline_barrier(
                        *cmd_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[dst_buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }

                end_command_buffer(vk, *cmd_buffer)?;
                submit_commands_and_wait(vk, queue, *cmd_buffer)?;

                let buffer_allocation = check_buffer.get_allocation();
                invalidate_alloc(vk, buffer_allocation)?;
                let buffer_ptr = buffer_allocation.get_host_ptr().cast::<u32>();

                for ndx in 0..self.num_values {
                    let res = unsafe { *buffer_ptr.add(ndx as usize) };
                    let reference = constant_val_per_loop + uniform_input_data[(4 * (phys_dev_idx + 1)) as usize];

                    if res != reference {
                        return Ok(TestStatus::fail(format!(
                            "Comparison failed on physical device {phys_dev_idx} ( deviceMask {device_mask} ) for InOut.values[{ndx}]"
                        )));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// =================================================================================
// dEQP-VK.compute.pipeline.64b_indexing.*
// =================================================================================

/// `Context::getShader64BitIndexingFeaturesEXT`.
///
/// Upstream's Context caches every feature struct and hands back a zeroed one when the
/// extension is absent; this queries on demand and does the same.
fn get_shader_64bit_indexing_features_ext(context: &Context<'_>) -> vk::PhysicalDeviceShader64BitIndexingFeaturesEXT {
    let mut features = vk::PhysicalDeviceShader64BitIndexingFeaturesEXT::default();
    if context.get_device_extensions().iter().any(|e| e == "VK_EXT_shader_64bit_indexing") {
        let mut features2 = vk::PhysicalDeviceFeatures2 {
            next: std::ptr::from_mut(&mut features).cast(),
            ..Default::default()
        };
        unsafe { context.get_instance().get_physical_device_features2(context.get_physical_device(), &mut features2) };
    }
    features
}

/// `VkPhysicalDeviceRobustness2FeaturesEXT` fetched through `getPhysicalDeviceFeatures2`,
/// as upstream's checkSupport does inline.
fn get_robustness2_features_ext(context: &Context<'_>) -> vk::PhysicalDeviceRobustness2FeaturesEXT {
    let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2 {
        next: std::ptr::from_mut(&mut robustness2_features).cast(),
        ..Default::default()
    };
    unsafe { context.get_instance().get_physical_device_features2(context.get_physical_device(), &mut features2) };
    robustness2_features
}

/// `BufferToBufferInvertTest::CopyInvertSSBOCase`, the 64-bit-indexing variants.
///
/// Upstream shares one class with the UBO cases of `basic.*`; only the SSBO branch is
/// needed here, so only that branch is ported - the UBO half already lives in
/// `basic_compute_shader_tests`.
#[derive(Clone, Copy)]
pub struct CopyInvertSsbo64bCase {
    pub name: &'static str,
    pub num_values: u32,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub do_bounds_check: bool,
    pub device_local: bool,
    pub use_64b_execution_mode: bool,
    pub programs: BinaryCollection,
}

impl TestCase for CopyInvertSsbo64bCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;

        if self.num_values > (1u32 << (32 - 4)) && get_shader_64bit_indexing_features_ext(context).shader_64bit_indexing == vk::FALSE {
            return Err(TestError::NotSupported("shader64BitIndexing not supported by this implementation".to_string()));
        }

        if self.do_bounds_check {
            context.require_device_functionality("VK_EXT_robustness2")?;

            if get_robustness2_features_ext(context).robust_buffer_access2 == vk::FALSE {
                return Err(TestError::NotSupported("robustBufferAccess2 not supported by this implementation".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        debug_assert_eq!(self.num_values as i32 % (multiply_components(self.work_size) * multiply_components(self.local_size)), 0);
        Box::new(CopyInvertSsbo64bInstance {
            context,
            num_values: self.num_values,
            work_size: self.work_size,
            do_bounds_check: self.do_bounds_check,
            device_local: self.device_local,
            use_64b_execution_mode: self.use_64b_execution_mode,
        })
    }
}

struct CopyInvertSsbo64bInstance<'a> {
    context: &'a Context<'a>,
    num_values: u32,
    work_size: IVec3,
    do_bounds_check: bool,
    device_local: bool,
    use_64b_execution_mode: bool,
}

impl TestInstance for CopyInvertSsbo64bInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let buffer_size_bytes = std::mem::size_of::<tcu::UVec4>() as u64 * self.num_values as u64;

        // `catch (const vk::OutOfMemoryError&)`: an 8 GB buffer the implementation
        // cannot supply is a "cannot run here", not a failure.
        match self.run(buffer_size_bytes) {
            Err(TestError::ResourceError(_)) if buffer_size_bytes >= (1u64 << 32) => Err(TestError::NotSupported("Out of memory".to_string())),
            other => other,
        }
    }
}

impl CopyInvertSsbo64bInstance<'_> {
    fn run(&self, buffer_size_bytes: u64) -> TestOutcome {
        if self.do_bounds_check {
            // Upstream runs the bounds-checking cases on a device it creates itself with
            // robustBufferAccess2 enabled (createRobustDevice). Running them on a device
            // without it would read undefined data out of bounds, which is indistinguishable
            // from a driver bug, so this is loud instead.
            tcu_not_ported!("createRobustDevice - a custom device with robustBufferAccess2");
        }

        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let allocator = self.context.get_default_allocator();

        // Customize the test based on buffer type
        let input_buffer_usage_flags = vk::BufferUsageFlags::STORAGE_BUFFER;
        let input_buffer_descriptor_type = vk::DescriptorType::STORAGE_BUFFER;
        let random_seed = 0x124fef;

        // Create an input buffer
        let input_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, input_buffer_usage_flags),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the input buffer with data
        let mut input_values: Vec<tcu::UVec4> = Vec::with_capacity(self.num_values as usize);
        {
            let mut rnd = Random::new(random_seed);
            for _ in 0..self.num_values {
                input_values.push(tcu::UVec4::new(rnd.get_uint32(), 0, 0, 0));
            }

            let input_buffer_allocation = input_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    input_values.as_ptr().cast::<u8>(),
                    input_buffer_allocation.get_host_ptr(),
                    std::mem::size_of_val(input_values.as_slice()),
                );
            }
            flush_alloc(vk, input_buffer_allocation)?;
        }

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Create an output buffer
        let output_buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
        let output_buffer_info = make_buffer_create_info(buffer_size_bytes, output_buffer_usage);
        let output_buffer = if self.device_local {
            BufferWithMemory::new(vk, allocator, output_buffer_info, MemoryRequirement::LOCAL)?
        } else {
            BufferWithMemory::new(vk, allocator, output_buffer_info, MemoryRequirement::HOST_VISIBLE)?
        };

        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe { vk.cmd_fill_buffer(*cmd_buffer, output_buffer.get(), 0, buffer_size_bytes, 0xBEBEBEBE) };
        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        let readback_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let readback_buffer_allocation = readback_buffer.get_allocation();

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(input_buffer_descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(input_buffer_descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let input_range = if self.do_bounds_check { buffer_size_bytes * 3 / 4 } else { vk::WHOLE_SIZE };
        let output_range = if self.do_bounds_check { buffer_size_bytes * 7 / 8 } else { vk::WHOLE_SIZE };

        let input_buffer_descriptor_info = make_descriptor_buffer_info(input_buffer.get(), 0, input_range);
        let output_buffer_descriptor_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_range);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), input_buffer_descriptor_type, &input_buffer_descriptor_info)
            .write_single(*descriptor_set, Location::binding(1), vk::DescriptorType::STORAGE_BUFFER, &output_buffer_descriptor_info)
            .update(vk);

        // Perform the computation
        //
        // Without the execution mode in the shader, the 64-bit indexing has to be asked
        // for on the pipeline instead.
        let pipeline_flags2 = if buffer_size_bytes > (1u64 << 32) && !self.use_64b_execution_mode {
            Some(vk::PipelineCreateFlags2::_64_BIT_INDEXING_EXT)
        } else {
            None
        };
        let pipeline = FlaggedComputePipeline::new(
            vk,
            self.context.get_binary_collection().get("comp")?,
            *descriptor_set_layout,
            vk::PipelineCreateFlags::empty(),
            pipeline_flags2,
        )?;

        let host_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::SHADER_READ, input_buffer.get(), 0, buffer_size_bytes);

        let shader_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, output_buffer.get(), 0, buffer_size_bytes);

        let transfer_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ, readback_buffer.get(), 0, buffer_size_bytes);

        // Start recording commands
        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_dispatch(*cmd_buffer, self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results
        let output_buffer_allocation = output_buffer.get_allocation();

        if self.device_local {
            let copy = vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: buffer_size_bytes,
            };
            begin_command_buffer(vk, *cmd_buffer)?;

            unsafe {
                vk.cmd_copy_buffer(*cmd_buffer, output_buffer.get(), readback_buffer.get(), &[copy]);

                vk.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[transfer_write_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(vk, *cmd_buffer)?;

            // Wait for completion
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;

            invalidate_alloc(vk, readback_buffer_allocation)?;
        } else {
            invalidate_alloc(vk, output_buffer_allocation)?;
        }

        let buffer_ptr = if self.device_local {
            readback_buffer_allocation.get_host_ptr()
        } else {
            output_buffer_allocation.get_host_ptr()
        }
        .cast::<tcu::UVec4>();
        let ref_buffer_ptr = input_values.as_slice();

        for ndx in 0..self.num_values {
            let input_in_range = ndx as u64 * (std::mem::size_of::<tcu::UVec4>() as u64) < input_range;
            let output_in_range = ndx as u64 * (std::mem::size_of::<tcu::UVec4>() as u64) < output_range;
            let res = unsafe { (*buffer_ptr.add(ndx as usize)).x() };
            let reference = if output_in_range {
                !(if input_in_range { ref_buffer_ptr[ndx as usize].x() } else { 0 })
            } else {
                0xBEBEBEBE
            };

            if res != reference {
                return Ok(TestStatus::fail(format!("Comparison failed for Output.values[{ndx}]")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

/// `UntypedPointerTest`
#[derive(Clone, Copy)]
pub struct UntypedPointerCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for UntypedPointerCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_shader_untyped_pointers")?;
        context.require_device_functionality("VK_EXT_shader_64bit_indexing")?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UntypedPointerInstance { _context: context })
    }
}

struct UntypedPointerInstance<'a> {
    _context: &'a Context<'a>,
}

impl TestInstance for UntypedPointerInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // The whole test is "does this pipeline build": upstream's initPrograms writes
        // SPIR-V assembly using OpTypeUntypedPointerKHR, which no GLSL can express, so
        // the shader manifest has nothing to compile and there is no binary to build a
        // pipeline from. Reached only on an implementation that has both
        // VK_KHR_shader_untyped_pointers and VK_EXT_shader_64bit_indexing.
        tcu_not_ported!("spirvAsmSources - untyped_pointers is written in SPIR-V assembly, not GLSL");
    }
}

// =================================================================================
// Group construction
// =================================================================================

/// `createComputeShaderBuiltinVarTests` / `ComputeShaderBuiltinVarTests::init`
fn create_compute_shader_builtin_var_tests(construction_type: ComputePipelineConstructionType) -> TestCaseGroup {
    debug_assert_eq!(construction_type, ComputePipelineConstructionType::Pipeline);

    let mut group = TestCaseGroup::new("builtin_var");

    // Builtin variables with vector values should be read whole and by component.
    group.add_child(Box::new(compute_builtin_var::NUM_WORK_GROUPS) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::WORK_GROUP_SIZE) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::WORK_GROUP_ID) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::LOCAL_INVOCATION_ID) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::GLOBAL_INVOCATION_ID) as Box<dyn TestCase>);

    group.add_child(Box::new(compute_builtin_var::NUM_WORK_GROUPS_COMPONENT) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::WORK_GROUP_SIZE_COMPONENT) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::WORK_GROUP_ID_COMPONENT) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::LOCAL_INVOCATION_ID_COMPONENT) as Box<dyn TestCase>);
    group.add_child(Box::new(compute_builtin_var::GLOBAL_INVOCATION_ID_COMPONENT) as Box<dyn TestCase>);

    // Local invocation index is already just a scalar.
    group.add_child(Box::new(compute_builtin_var::LOCAL_INVOCATION_INDEX) as Box<dyn TestCase>);

    group
}

/// `createBasicDeviceGroupComputeShaderTests`
fn create_basic_device_group_compute_shader_tests(construction_type: ComputePipelineConstructionType) -> TestCaseGroup {
    debug_assert_eq!(construction_type, ComputePipelineConstructionType::Pipeline);

    let mut device_group_compute_tests = TestCaseGroup::new("device_group");

    device_group_compute_tests.add_child(Box::new(compute_builtin_var::DISPATCH_BASE) as Box<dyn TestCase>);
    device_group_compute_tests.add_child(Box::new(compute_builtin_var::DISPATCH_BASE_MAINTENANCE5) as Box<dyn TestCase>);
    device_group_compute_tests.add_child(Box::new(compute_builtin_var::DEVICE_INDEX) as Box<dyn TestCase>);

    device_group_compute_tests
}

/// `create64bIndexingComputeShaderTests`
fn create_64b_indexing_compute_shader_tests(construction_type: ComputePipelineConstructionType) -> TestCaseGroup {
    debug_assert_eq!(construction_type, ComputePipelineConstructionType::Pipeline);

    let mut indexing64b = TestCaseGroup::new("64b_indexing");

    // >4GB buffer (512M * 16B = 8GB).
    indexing64b.add_child(Box::new(compute_builtin_var::COPY_SSBO_64B) as Box<dyn TestCase>);
    indexing64b.add_child(Box::new(compute_builtin_var::COPY_SSBO_64B_BOUNDS) as Box<dyn TestCase>);
    indexing64b.add_child(Box::new(compute_builtin_var::COPY_SSBO_64B_BOUNDS_LOCAL) as Box<dyn TestCase>);
    indexing64b.add_child(Box::new(compute_builtin_var::COPY_SSBO_64B_EXECUTION_MODE) as Box<dyn TestCase>);

    indexing64b.add_child(Box::new(compute_builtin_var::UNTYPED_POINTERS) as Box<dyn TestCase>);

    indexing64b
}

/// The three groups this file owns, in the order upstream registers them under
/// `dEQP-VK.compute.pipeline`.
pub fn create_builtin_var_device_group_and_64b_groups() -> Vec<TestCaseGroup> {
    let construction_type = ComputePipelineConstructionType::Pipeline;

    vec![
        create_compute_shader_builtin_var_tests(construction_type),
        create_basic_device_group_compute_shader_tests(construction_type),
        create_64b_indexing_compute_shader_tests(construction_type),
    ]
}
