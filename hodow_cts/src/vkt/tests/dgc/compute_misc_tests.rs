// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only `execute_many_*`, `many_sequences_*`, `max_pc_range_*`, `multiple_sets*`, `iubs*` and `two_cmd_buffers*` are ported here; the program
// (`increaseValueByIndexPrograms`) is pre-expanded in `shaders/manifest/dgc_compute_misc.toml` (`scripts/gen_dgc_compute_misc_manifest.py`).
// The pipeline layout is the one of the pipeline wrapper, and the preprocess buffer of `execute_many_*` is allocated from the memory
// requirements of the buffer alone.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, ExtDescriptorBufferExtensionDeviceCommands, ExtDeviceGeneratedCommandsExtensionDeviceCommands,
    ExtShaderObjectExtensionDeviceCommands, InstanceV1_1, KhrPushDescriptorExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_compute_misc::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout_with_push_constants,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcComputeSupportType, DgcGenCmdsInfo, DgcMemReqsInfo, ExecutionSetManagerExt,
    IndirectCommandsLayoutBuilderExt, PreprocessBufferExt, check_dgc_ext_compute_support, create_dgc_shader,
    get_generated_commands_memory_requirements_ext, make_preprocess_buffer, preprocess_to_execute_barrier_ext,
};
use crate::vkt::{Context, TestCase, TestInstance};

const TYPICAL_WORKING_GROUP_SIZE: u32 = 64;
const IUB_BLOCK_SIZE: u32 = 128;
const IUB_ITEM_SIZE: u32 = 16;
const IUB_ITEM_COUNT: u32 = IUB_BLOCK_SIZE / IUB_ITEM_SIZE;
const IUB_COUNT: u32 = 2;
const MULTIPLE_SETS_LOCAL_SIZE: u32 = 32;
const MULTIPLE_SETS_ITEM_COUNT: u32 = 1024;
const MULTIPLE_SETS_WORK_GROUP_COUNT: u32 = MULTIPLE_SETS_ITEM_COUNT / MULTIPLE_SETS_LOCAL_SIZE;

#[derive(Clone, Copy)]
enum Variant {
    /// Amount of executes to run, one `vkCmdExecuteGeneratedCommandsEXT` each.
    ManyExecutes {
        dispatch_count: u32,
        compute_queue: bool,
    },
    /// Amount of sequences of a single execute.
    ManySequences {
        dispatch_count: u32,
        compute_queue: bool,
    },
    TwoCmdBuffers {
        use_execution_set: bool,
        compute_queue: bool,
    },
    MaxPushConstantRange(MaxPcParams),
    MultipleSets {
        preprocess: bool,
        compute_queue: bool,
    },
    InlineUniformBlocks {
        use_execution_set: bool,
        split_sets: bool,
        compute_queue: bool,
    },
    ScratchSpace,
    NullSetLayoutsInfo,
    DescriptorBufferPushDescriptor {
        use_execution_set: bool,
    },
}

#[derive(Clone, Copy)]
struct MaxPcParams {
    pc_bytes: u32,
    /// Update the range partly by DGC and partly by external push constants, or all by DGC.
    partial: bool,
    preprocess: bool,
    use_execution_set: bool,
    push_descriptor: bool,
    use_compute_queue: bool,
}

impl MaxPcParams {
    /// Each item is going to be a uint32_t, so given pc_bytes we can calculate the number of items.
    fn item_count(&self) -> u32 {
        self.pc_bytes / std::mem::size_of::<u32>() as u32
    }
}

impl Variant {
    fn pipeline_binds(&self) -> bool {
        matches!(
            self,
            Variant::MultipleSets { .. }
                | Variant::InlineUniformBlocks {
                    use_execution_set: true,
                    ..
                }
                | Variant::TwoCmdBuffers {
                    use_execution_set: true,
                    ..
                }
                | Variant::ScratchSpace
                | Variant::DescriptorBufferPushDescriptor {
                    use_execution_set: true
                }
                | Variant::MaxPushConstantRange(MaxPcParams {
                    use_execution_set: true,
                    ..
                })
        )
    }

    fn compute_queue(&self) -> bool {
        match *self {
            Variant::ManyExecutes { compute_queue, .. }
            | Variant::ManySequences { compute_queue, .. }
            | Variant::TwoCmdBuffers { compute_queue, .. }
            | Variant::MultipleSets { compute_queue, .. }
            | Variant::InlineUniformBlocks { compute_queue, .. } => compute_queue,
            Variant::MaxPushConstantRange(params) => params.use_compute_queue,
            Variant::ScratchSpace => true,
            Variant::NullSetLayoutsInfo | Variant::DescriptorBufferPushDescriptor { .. } => false,
        }
    }
}

struct MiscCase {
    name: String,
    variant: Variant,
}

impl TestCase for MiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `generalCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if let Variant::NullSetLayoutsInfo = self.variant {
            context.require_device_functionality("VK_EXT_shader_object")?;
            return check_dgc_ext_compute_support(context, DgcComputeSupportType::BindShader);
        }
        let support_type = if self.variant.pipeline_binds() {
            DgcComputeSupportType::BindPipeline
        } else {
            DgcComputeSupportType::Basic
        };
        check_dgc_ext_compute_support(context, support_type)?;

        if self.variant.compute_queue() && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("No compute queue available".to_string()));
        }

        if let Variant::DescriptorBufferPushDescriptor { .. } = self.variant {
            context.require_device_functionality("VK_EXT_descriptor_buffer")?;
            context.require_device_functionality("VK_KHR_push_descriptor")?;
            let mut features = vk::PhysicalDeviceDescriptorBufferFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.descriptor_buffer_push_descriptors == vk::FALSE {
                return Err(TestError::NotSupported(
                    "descriptorBufferPushDescriptors not supported".to_string(),
                ));
            }
        }

        if let Variant::InlineUniformBlocks { .. } = self.variant {
            context.require_device_functionality("VK_EXT_inline_uniform_block")?;
        }

        if let Variant::MultipleSets { .. } = self.variant {
            let properties = context.get_device_properties();
            if properties.limits.max_compute_work_group_size[0] < MULTIPLE_SETS_LOCAL_SIZE {
                return Err(TestError::NotSupported(
                    "maxComputeWorkGroupSize below required limit".to_string(),
                ));
            }
            if properties.limits.max_compute_work_group_count[0] < MULTIPLE_SETS_WORK_GROUP_COUNT {
                return Err(TestError::NotSupported(
                    "maxComputeWorkGroupCount below required limit".to_string(),
                ));
            }
        }

        if let Variant::MaxPushConstantRange(params) = self.variant {
            let properties = context.get_device_properties();
            if properties.limits.max_push_constants_size < params.pc_bytes {
                return Err(TestError::NotSupported(
                    "maxPushConstantsSize below required size".to_string(),
                ));
            }

            let dispatch_size = params.item_count();
            if properties.limits.max_compute_work_group_count[0] < dispatch_size {
                return Err(TestError::NotSupported(
                    "maxComputeWorkGroupCount below required limit".to_string(),
                ));
            }

            if params.push_descriptor {
                context.require_device_functionality("VK_KHR_push_descriptor")?;
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = match self.variant {
            Variant::MaxPushConstantRange(params) => format!("misc_max_pc_{}", params.pc_bytes),
            Variant::MultipleSets { .. } => "misc_multiple_sets".to_string(),
            Variant::ScratchSpace => "misc_scratch_space".to_string(),
            Variant::NullSetLayoutsInfo => "misc_null_set_layouts".to_string(),
            Variant::DescriptorBufferPushDescriptor { .. } => "misc_dbpd".to_string(),
            Variant::InlineUniformBlocks { split_sets, .. } => {
                format!("misc_iub_{}", if split_sets { "split" } else { "single" })
            }
            _ => "misc_increase_value_by_index".to_string(),
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscInstance {
            context,
            variant: self.variant,
        })
    }
}

struct MiscInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

/// The output buffer and its descriptor set, shared by the three runs.
struct OutputSetup<'a> {
    output_buffer: BufferWithMemory<'a>,
    set: UniqueDescriptorSet<'a>,
    _pool: Unique<'a, vk::DescriptorPool>,
    set_layout: Unique<'a, vk::DescriptorSetLayout>,
}

fn pc_range() -> vk::PushConstantRange {
    vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::COMPUTE,
        offset: 0,
        size: std::mem::size_of::<u32>() as u32,
    }
}

impl<'a> MiscInstance<'a> {
    fn queue_and_family(&self, compute_queue: bool) -> Result<(vk::Queue, u32), TestError> {
        if compute_queue {
            self.context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))
        } else {
            Ok((
                self.context.get_universal_queue(),
                self.context.get_universal_queue_family_index(),
            ))
        }
    }

    fn make_output_setup(&self, value_count: u32) -> Result<OutputSetup<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let value_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let output_buffer_size = value_size * vk::DeviceSize::from(value_count);

        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, output_buffer_size as usize) };
            flush_alloc(device, alloc)?;
        }

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;

        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(set.get(), Location::binding(0), desc_type, &output_buffer_desc_info)
            .update(device);

        Ok(OutputSetup {
            output_buffer,
            set,
            _pool: pool,
            set_layout,
        })
    }

    fn make_pipeline(
        &self,
        set_layout: vk::DescriptorSetLayout,
        indirect_bindable: bool,
    ) -> Result<ComputePipelineWrapper<'a>, TestError> {
        let mut pipeline = ComputePipelineWrapper::new(
            self.context.get_device(),
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(set_layout);
        pipeline.add_push_constant_range(pc_range());
        if indirect_bindable {
            pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
        }
        pipeline.build_pipeline()?;
        Ok(pipeline)
    }

    /// Every output value ends up being `kTypicalWorkingGroupSize`.
    fn verify(&self, output: &OutputSetup<'_>, count: u32) -> TestOutcome {
        let device = self.context.get_device();
        let alloc = output.output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let mut output_values = vec![u32::MAX; count as usize];
        unsafe {
            std::ptr::copy_nonoverlapping(
                alloc.get_host_ptr().cast::<u32>(),
                output_values.as_mut_ptr(),
                output_values.len(),
            )
        };

        let mut fail = false;
        for (i, &result) in output_values.iter().enumerate() {
            if result != TYPICAL_WORKING_GROUP_SIZE {
                log::error!("Error at execution {i}: expected {TYPICAL_WORKING_GROUP_SIZE} but found {result}");
                fail = true;
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    fn upload_gen_cmds(&self, gen_cmds_data: &[u32]) -> Result<DgcBuffer<'a>, TestError> {
        let device = self.context.get_device();
        let size = std::mem::size_of_val(gen_cmds_data) as vk::DeviceSize;
        let buffer = DgcBuffer::new(
            self.context,
            size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let alloc = buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(gen_cmds_data.as_ptr().cast::<u8>(), alloc.get_host_ptr(), size as usize)
        };
        flush_alloc(device, alloc)?;
        Ok(buffer)
    }

    fn shader_write_to_host_barrier(&self, cmd_buffer: vk::CommandBuffer) {
        let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            self.context.get_device().cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `MaxPushConstantRangeInstance::iterate`
    fn max_push_constant_range_run(&self, params: MaxPcParams) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let item_count = params.item_count();
        let shader_stages = vk::ShaderStageFlags::COMPUTE;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = self.queue_and_family(params.use_compute_queue)?;

        // Expected output buffer values.
        let mut expected_values = vec![0u32; item_count as usize];
        for (i, expected) in expected_values.iter_mut().enumerate() {
            let external = params.partial && i > 0 && i < item_count as usize - 1;
            let base_value = if external { 1_000_000u32 } else { 2_000_000u32 };
            *expected = base_value + i as u32;
        }

        // Prepare output buffer.
        let output_buffer_size = std::mem::size_of_val(expected_values.as_slice()) as vk::DeviceSize;
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, output_buffer_size as usize) };
            flush_alloc(device, alloc)?;
        }

        // Descriptor set layout and pipeline layout.
        let set_layout_flags = if params.push_descriptor {
            vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR
        } else {
            vk::DescriptorSetLayoutCreateFlags::empty()
        };
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, shader_stages)
            .build_with_flags(device, set_layout_flags)?;

        // Prepare descriptor pool and set.
        let buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, vk::WHOLE_SIZE);
        let descriptor = if params.push_descriptor {
            None
        } else {
            let pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                1,
            )?;
            let set = make_descriptor_set(device, *pool, *set_layout)?;
            DescriptorSetUpdateBuilder::new()
                .write_single(set.get(), Location::binding(0), desc_type, &buffer_desc_info)
                .update(device);
            Some((set, pool))
        };

        // Pipeline, normal or DGC.
        let mut pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.add_push_constant_range(vk::PushConstantRange {
            stage_flags: shader_stages,
            offset: 0,
            size: params.pc_bytes,
        });
        if params.use_execution_set {
            pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
        }
        pipeline.build_pipeline()?;
        let pipeline_layout = pipeline.get_pipeline_layout();
        // The normal pipeline of upstream stays null when a DGC pipeline is used.
        let normal_pipeline = if params.use_execution_set {
            vk::Pipeline::null()
        } else {
            pipeline.get_pipeline()
        };

        let ies_manager = if params.use_execution_set {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, pipeline.get_pipeline(), 1)?;
            manager.add_pipeline(0, pipeline.get_pipeline());
            manager.update();
            Some(manager)
        } else {
            None
        };
        let ies = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // DGC Commands layout and buffer.
        let item_size = std::mem::size_of::<u32>() as u32;
        let range = |offset: u32, size: u32| vk::PushConstantRange {
            stage_flags: shader_stages,
            offset,
            size,
        };
        let first_item_range = range(0, item_size);
        let last_item_range = range((item_count - 1) * item_size, item_size);
        let middle_items_range = range(item_size, (item_count - 2) * item_size);

        let cmds_layout_flags = if params.preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, shader_stages, pipeline_layout);
        if params.use_execution_set {
            cmds_layout_builder.add_compute_pipeline_token(0);
        }
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, last_item_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, first_item_range);
        if !params.partial {
            let stream_range = cmds_layout_builder.get_stream_stride();
            cmds_layout_builder.add_push_constant_token(stream_range, middle_items_range);
        }
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut dgc_data: Vec<u32> = Vec::with_capacity((cmds_layout_builder.get_stream_stride() / item_size) as usize);
        if params.use_execution_set {
            dgc_data.push(0);
        }
        dgc_data.push(expected_values[expected_values.len() - 1]);
        dgc_data.push(expected_values[0]);
        if !params.partial {
            dgc_data.extend_from_slice(&expected_values[1..expected_values.len() - 1]);
        }
        dgc_data.extend([item_count, 1, 1]);

        let dgc_buffer = self.upload_gen_cmds(&dgc_data)?;

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(context, ies, cmds_layout.get(), 1, 0, normal_pipeline, 0)?;

        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            ies,
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            1,
            0,
            0,
            normal_pipeline,
        );

        begin_command_buffer(device, cmd_buffer)?;
        match &descriptor {
            None => {
                let push_write = vk::WriteDescriptorSet {
                    dst_set: vk::DescriptorSet::null(),
                    dst_binding: 0,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: desc_type,
                    buffer_info: &buffer_desc_info,
                    ..Default::default()
                };
                unsafe {
                    device.cmd_push_descriptor_set_khr(cmd_buffer, bind_point, pipeline_layout, 0, &[push_write])
                };
            }
            Some((set, _pool)) => unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[set.get()],
                    &[] as &[u32],
                );
            },
        }
        if params.partial {
            let middle_bytes: Vec<u8> = expected_values[1..]
                .iter()
                .take(middle_items_range.size as usize / 4)
                .flat_map(|value| value.to_ne_bytes())
                .collect();
            unsafe {
                device.cmd_push_constants(
                    cmd_buffer,
                    pipeline_layout,
                    shader_stages,
                    middle_items_range.offset,
                    &middle_bytes,
                )
            };
        }
        pipeline.bind(cmd_buffer);
        if params.preprocess {
            unsafe { device.cmd_preprocess_generated_commands_ext(cmd_buffer, cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, cmd_buffer);
        }
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, cmds_info.get()) };
        self.shader_write_to_host_barrier(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify results
        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let mut result_values = vec![0u32; expected_values.len()];
        unsafe {
            std::ptr::copy_nonoverlapping(
                output_alloc.get_host_ptr().cast::<u32>(),
                result_values.as_mut_ptr(),
                result_values.len(),
            )
        };

        let mut result_ok = true;
        for (i, (&result, &expected)) in result_values.iter().zip(&expected_values).enumerate() {
            if result != expected {
                result_ok = false;
                log::error!("Unexpected value at position {i}: found {result} and expected {expected}");
            }
        }

        drop(ies_manager);
        if !result_ok {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `MultipleSetsInstance::iterate`: multiple descriptor sets with IES and compute (RADV had bugs related to this at some point).
    fn multiple_sets_run(&self, preprocess: bool, use_compute_queue: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let shader_stages = vk::ShaderStageFlags::COMPUTE;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = self.queue_and_family(use_compute_queue)?;

        // Input buffer values.
        let input_values: Vec<u32> = (0..MULTIPLE_SETS_ITEM_COUNT).map(|i| 1_000_000 + i).collect();

        // Prepare input and output buffers.
        let buffer_size = std::mem::size_of_val(input_values.as_slice()) as vk::DeviceSize;
        let make_buffer = || {
            BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let input_buffer = make_buffer()?;
        let output_buffer = make_buffer()?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                input_values.as_ptr().cast::<u8>(),
                input_buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            );
            std::ptr::write_bytes(output_buffer.get_allocation().get_host_ptr(), 0, buffer_size as usize);
        }
        flush_alloc(device, input_buffer.get_allocation())?;
        flush_alloc(device, output_buffer.get_allocation())?;

        // Descriptor set layouts and pipeline layout. Same layout for both sets.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, shader_stages)
            .build(device)?;
        let set_count = 2u32;

        // Prepare descriptor pool and sets.
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, set_count).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            set_count,
        )?;
        let mut descriptor_sets = Vec::new();
        for _ in 0..set_count {
            descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, *set_layout)?);
        }

        let buffers = [input_buffer.get(), output_buffer.get()];
        let mut update_builder = DescriptorSetUpdateBuilder::new();
        for (set, buffer) in descriptor_sets.iter().zip(buffers) {
            let buffer_desc_info = make_descriptor_buffer_info(buffer, 0, vk::WHOLE_SIZE);
            update_builder = update_builder.write_single(set.get(), Location::binding(0), desc_type, &buffer_desc_info);
        }
        update_builder.update(device);

        // Pipeline.
        let mut dgc_pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        dgc_pipeline.set_descriptor_set_layout(*set_layout);
        dgc_pipeline.add_descriptor_set_layout(*set_layout);
        dgc_pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
        dgc_pipeline.build_pipeline()?;
        let pipeline_layout = dgc_pipeline.get_pipeline_layout();

        // Rely on the initial value.
        let ies_manager = ExecutionSetManagerExt::new_pipeline(device, dgc_pipeline.get_pipeline(), 1)?;

        // DGC Commands layout and buffer.
        let cmds_layout_flags = if preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, shader_stages, pipeline_layout);
        cmds_layout_builder.add_compute_pipeline_token(0);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let dgc_data: Vec<u32> = vec![0, 1, 1, MULTIPLE_SETS_WORK_GROUP_COUNT];
        let dgc_buffer = self.upload_gen_cmds(&dgc_data)?;

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies_manager.get(),
            cmds_layout.get(),
            1,
            0,
            vk::Pipeline::null(),
            0,
        )?;

        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            ies_manager.get(),
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            1,
            0,
            0,
            vk::Pipeline::null(),
        );

        begin_command_buffer(device, cmd_buffer)?;
        let set_raws: Vec<vk::DescriptorSet> = descriptor_sets.iter().map(UniqueDescriptorSet::get).collect();
        unsafe {
            device.cmd_bind_descriptor_sets(cmd_buffer, bind_point, pipeline_layout, 0, &set_raws, &[] as &[u32]);
        }
        dgc_pipeline.bind(cmd_buffer);
        if preprocess {
            unsafe { device.cmd_preprocess_generated_commands_ext(cmd_buffer, cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, cmd_buffer);
        }
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, preprocess, cmds_info.get()) };
        self.shader_write_to_host_barrier(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify results
        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let mut result_values = vec![0u32; input_values.len()];
        unsafe {
            std::ptr::copy_nonoverlapping(
                output_alloc.get_host_ptr().cast::<u32>(),
                result_values.as_mut_ptr(),
                result_values.len(),
            )
        };

        let mut result_ok = true;
        for (i, (&result, &expected)) in result_values.iter().zip(&input_values).enumerate() {
            if result != expected {
                result_ok = false;
                log::error!("Unexpected value at position {i}: found {result} and expected {expected}");
            }
        }

        if !result_ok {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `IUBUsageInstance::iterate`
    fn iub_usage_run(&self, use_execution_set: bool, split_sets: bool, use_compute_queue: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let shader_stages = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = self.queue_and_family(use_compute_queue)?;

        // Input values in each IUB.
        let mut input_values: Vec<Vec<[u32; 4]>> = Vec::new();
        for i in 0..IUB_COUNT {
            let values = (0..IUB_ITEM_COUNT)
                .map(|j| {
                    let base = ((i + 1) << 16) | (j << 8);
                    [base, base | 1, base | 2, base | 3]
                })
                .collect();
            input_values.push(values);
        }

        // Output buffers.
        let buffer_size = std::mem::size_of_val(input_values[0].as_slice()) as vk::DeviceSize;
        let mut output_buffers = Vec::new();
        for _ in 0..IUB_COUNT {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, buffer_size as usize) };
            flush_alloc(device, buffer.get_allocation())?;
            output_buffers.push(buffer);
        }

        // Descriptor set layouts and pipeline layout. This must match the shaders.
        let make_binding =
            |binding: u32, descriptor_type: vk::DescriptorType, descriptor_count: u32| vk::DescriptorSetLayoutBinding {
                binding,
                descriptor_type,
                descriptor_count,
                stage_flags: shader_stages,
                immutable_samplers: std::ptr::null(),
            };
        let make_set_layout =
            |bindings: &[vk::DescriptorSetLayoutBinding]| -> Result<Unique<'a, vk::DescriptorSetLayout>, TestError> {
                let info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(bindings);
                let layout = unsafe { device.create_descriptor_set_layout(&info, None) }
                    .vk_check("vkCreateDescriptorSetLayout")?;
                Ok(Unique::new(device, layout))
            };
        let iub_bindings = |first_binding: u32| {
            [
                make_binding(first_binding, vk::DescriptorType::INLINE_UNIFORM_BLOCK, IUB_BLOCK_SIZE),
                make_binding(first_binding + 1, vk::DescriptorType::STORAGE_BUFFER, 1),
            ]
        };
        let mut set_layouts = Vec::new();
        if split_sets {
            for _ in 0..IUB_COUNT {
                set_layouts.push(make_set_layout(&iub_bindings(0))?);
            }
        } else {
            let mut bindings = Vec::new();
            for i in 0..IUB_COUNT {
                bindings.extend(iub_bindings(i * 2));
            }
            set_layouts.push(make_set_layout(&bindings)?);
        }

        // Prepare descriptor pool and sets.
        let mut iub_pool_info = vk::DescriptorPoolInlineUniformBlockCreateInfo {
            max_inline_uniform_block_bindings: IUB_COUNT,
            ..Default::default()
        };
        let set_count = set_layouts.len() as u32;
        let pool_sizes = [
            vk::DescriptorPoolSize {
                type_: vk::DescriptorType::INLINE_UNIFORM_BLOCK,
                descriptor_count: IUB_COUNT * IUB_BLOCK_SIZE,
            },
            vk::DescriptorPoolSize {
                type_: vk::DescriptorType::STORAGE_BUFFER,
                descriptor_count: IUB_COUNT,
            },
        ];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(set_count)
            .pool_sizes(&pool_sizes)
            .push_next(&mut iub_pool_info);
        let descriptor_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let mut descriptor_sets = Vec::new();
        for layout in &set_layouts {
            descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, **layout)?);
        }

        {
            let iub_writes: Vec<vk::WriteDescriptorSetInlineUniformBlock> = input_values
                .iter()
                .map(|values| vk::WriteDescriptorSetInlineUniformBlock {
                    data_size: IUB_BLOCK_SIZE,
                    data: values.as_ptr().cast(),
                    ..Default::default()
                })
                .collect();
            let buffer_infos: Vec<vk::DescriptorBufferInfo> = output_buffers
                .iter()
                .map(|buffer| make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE))
                .collect();
            let mut writes: Vec<vk::WriteDescriptorSet> = Vec::new();

            let mut set_index = 0usize;
            let mut binding_index = 0u32;
            for i in 0..IUB_COUNT as usize {
                writes.push(vk::WriteDescriptorSet {
                    next: (&iub_writes[i] as *const vk::WriteDescriptorSetInlineUniformBlock).cast(),
                    dst_set: descriptor_sets[set_index].get(),
                    dst_binding: binding_index,
                    dst_array_element: 0,
                    descriptor_count: IUB_BLOCK_SIZE,
                    descriptor_type: vk::DescriptorType::INLINE_UNIFORM_BLOCK,
                    ..Default::default()
                });
                binding_index += 1;

                writes.push(vk::WriteDescriptorSet {
                    dst_set: descriptor_sets[set_index].get(),
                    dst_binding: binding_index,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                    buffer_info: &buffer_infos[i],
                    ..Default::default()
                });
                binding_index += 1;

                if split_sets {
                    set_index += 1;
                    binding_index = 0;
                }
            }
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // Pipelines.
        let mut pipelines: Vec<ComputePipelineWrapper<'_>> = Vec::new();
        for i in 0..IUB_COUNT {
            let mut pipeline = ComputePipelineWrapper::new(
                device,
                ComputePipelineConstructionType::Pipeline,
                context.get_binary_collection().get(&format!("comp{i}"))?,
            );
            pipeline.set_descriptor_set_layout(*set_layouts[0]);
            for layout in &set_layouts[1..] {
                pipeline.add_descriptor_set_layout(**layout);
            }
            if use_execution_set {
                pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
            }
            pipeline.build_pipeline()?;
            pipelines.push(pipeline);
        }
        let pipeline_layout = pipelines[0].get_pipeline_layout();

        let ies_manager = if use_execution_set {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, pipelines[0].get_pipeline(), IUB_COUNT)?;
            for (i, pipeline) in pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, pipeline.get_pipeline());
            }
            manager.update();
            Some(manager)
        } else {
            None
        };
        let ies = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // DGC Commands layout and buffer.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stages,
            pipeline_layout,
        );
        if use_execution_set {
            cmds_layout_builder.add_compute_pipeline_token(0);
        }
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut dgc_buffers = Vec::new();
        let mut preprocess_buffers = Vec::new();

        if use_execution_set {
            // We can use a single DGC buffer for all sequences.
            let mut dgc_data: Vec<u32> = Vec::new();
            for i in 0..IUB_COUNT {
                dgc_data.push(i); // Pipeline index.
                dgc_data.extend([1, 1, 1]); // Dispatch
            }
            dgc_buffers.push(self.upload_gen_cmds(&dgc_data)?);

            // And a single preprocess buffer.
            preprocess_buffers.push(PreprocessBufferExt::new(
                context,
                ies,
                cmds_layout.get(),
                IUB_COUNT,
                0,
                pipelines[0].get_pipeline(),
                0,
            )?);
        } else {
            // Multiple DGC buffers (but with the same contents)
            let dgc_data: Vec<u32> = vec![1, 1, 1]; // Dispatch.
            for pipeline in &pipelines {
                dgc_buffers.push(self.upload_gen_cmds(&dgc_data)?);
                preprocess_buffers.push(PreprocessBufferExt::new(
                    context,
                    vk::IndirectExecutionSetEXT::null(),
                    cmds_layout.get(),
                    1,
                    0,
                    pipeline.get_pipeline(),
                    0,
                )?);
            }
        }

        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let mut cmd_infos = Vec::new();
        if use_execution_set {
            let dgc_buffer = &dgc_buffers[0];
            let preprocess_buffer = &preprocess_buffers[0];
            cmd_infos.push(DgcGenCmdsInfo::new(
                shader_stages,
                ies,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                IUB_COUNT,
                0,
                0,
                vk::Pipeline::null(),
            ));
        } else {
            for (i, pipeline) in pipelines.iter().enumerate() {
                let dgc_buffer = &dgc_buffers[i];
                let preprocess_buffer = &preprocess_buffers[i];
                cmd_infos.push(DgcGenCmdsInfo::new(
                    shader_stages,
                    vk::IndirectExecutionSetEXT::null(),
                    cmds_layout.get(),
                    dgc_buffer.get_device_address(),
                    dgc_buffer.get_size(),
                    preprocess_buffer.get_device_address(),
                    preprocess_buffer.get_size(),
                    1,
                    0,
                    0,
                    pipeline.get_pipeline(),
                ));
            }
        }

        begin_command_buffer(device, cmd_buffer)?;
        let set_raws: Vec<vk::DescriptorSet> = descriptor_sets.iter().map(UniqueDescriptorSet::get).collect();
        unsafe {
            device.cmd_bind_descriptor_sets(cmd_buffer, bind_point, pipeline_layout, 0, &set_raws, &[] as &[u32]);
        }
        if use_execution_set {
            pipelines[0].bind(cmd_buffer);
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmd_infos[0].get()) };
        } else {
            for (pipeline, info) in pipelines.iter().zip(&cmd_infos) {
                pipeline.bind(cmd_buffer);
                unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, info.get()) };
            }
        }
        self.shader_write_to_host_barrier(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify results
        let mut result_ok = true;
        for i in 0..IUB_COUNT as usize {
            let reverse = i > 0;
            let alloc = output_buffers[i].get_allocation();
            invalidate_alloc(device, alloc)?;
            let mut result_values = vec![[0u32; 4]; IUB_ITEM_COUNT as usize];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    alloc.get_host_ptr().cast::<[u32; 4]>(),
                    result_values.as_mut_ptr(),
                    result_values.len(),
                )
            };

            for j in 0..IUB_ITEM_COUNT as usize {
                let expected_idx = if reverse { IUB_ITEM_COUNT as usize - j - 1 } else { j };
                let result = result_values[j];
                let expected = input_values[i][expected_idx];

                if result != expected {
                    result_ok = false;
                    log::error!(
                        "Unexpected value in output buffer {i} at position {j}: found {result:?} and expected {expected:?}"
                    );
                }
            }
        }

        drop(ies_manager);
        if !result_ok {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `twoCmdBuffersRun`
    fn two_cmd_buffers_run(&self, use_execution_set: bool, compute_queue: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = self.queue_and_family(compute_queue)?;
        let dispatch_count = 4u32;
        let normal_dispatches = 1u32;
        let dgc_dispatches = dispatch_count - normal_dispatches;
        let pc_range = pc_range();

        let output = self.make_output_setup(dispatch_count)?;
        let normal_pipeline = self.make_pipeline(*output.set_layout, false)?;
        let pipeline_layout = normal_pipeline.get_pipeline_layout();
        let dgc_pipeline = if use_execution_set {
            Some(self.make_pipeline(*output.set_layout, true)?)
        } else {
            None
        };

        // Indirect execution set. We do not need to update anything because we only have 1 pipeline.
        let execution_set_manager = match &dgc_pipeline {
            Some(dgc_pipeline) => Some(ExecutionSetManagerExt::new_pipeline(
                device,
                dgc_pipeline.get_pipeline(),
                1,
            )?),
            None => None,
        };

        // Generated commands layout: push constant and dispatch.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            pipeline_layout,
        );
        if use_execution_set {
            let stream_range = cmds_layout_builder.get_stream_stride();
            cmds_layout_builder.add_compute_pipeline_token(stream_range);
        }
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Increase the value index (indicated by the push constant) in each sequence, then dispatch one workgroup.
        let mut gen_cmds_data: Vec<u32> = Vec::new();
        for i in normal_dispatches..dispatch_count {
            if use_execution_set {
                gen_cmds_data.push(0);
            }
            gen_cmds_data.push(i); // PC data.
            gen_cmds_data.extend([1, 1, 1]); // VkDispatchIndirectCommand
        }
        let gen_cmds_buffer = self.upload_gen_cmds(&gen_cmds_data)?;

        // Preprocess buffer.
        let ies = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let preprocess_pipeline = if ies == vk::IndirectExecutionSetEXT::null() {
            normal_pipeline.get_pipeline()
        } else {
            vk::Pipeline::null()
        };
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies,
            cmds_layout.get(),
            dgc_dispatches,
            0,
            preprocess_pipeline,
            0,
        )?;

        // Command pool and buffers.
        let cmd_pool = make_command_pool(device, qf_index)?;
        let normal_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let dgc_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Record normal dispatch and DGC dispatch in separate command buffers, submitting both at the same time.
        let post_dispatch_barrier = make_memory_barrier(
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::HOST_READ,
        );
        let post_dispatch_barrier_cmd = |cmd_buffer: vk::CommandBuffer| unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER | vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[post_dispatch_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        };
        {
            let cmd_buffer = normal_cmd_buffer.get();
            begin_command_buffer(device, cmd_buffer)?;
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[output.set.get()],
                    &[] as &[u32],
                );
            }
            normal_pipeline.bind(cmd_buffer);
            let index_value = 0u32;
            unsafe {
                device.cmd_push_constants(cmd_buffer, pipeline_layout, stage_flags, 0, &index_value.to_ne_bytes());
                device.cmd_dispatch(cmd_buffer, 1, 1, 1);
            }
            post_dispatch_barrier_cmd(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        }
        {
            let cmd_buffer = dgc_cmd_buffer.get();
            begin_command_buffer(device, cmd_buffer)?;
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[output.set.get()],
                    &[] as &[u32],
                );
            }
            // Binds the DGC pipeline when there is one, the normal one otherwise.
            dgc_pipeline.as_ref().unwrap_or(&normal_pipeline).bind(cmd_buffer);
            let cmds_info_pipeline = if dgc_pipeline.is_some() {
                vk::Pipeline::null()
            } else {
                normal_pipeline.get_pipeline()
            };
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                ies,
                cmds_layout.get(),
                gen_cmds_buffer.get_device_address(),
                gen_cmds_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                dgc_dispatches,
                0,
                0,
                cmds_info_pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
            post_dispatch_barrier_cmd(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        }

        {
            let cmd_buffers = [normal_cmd_buffer.get(), dgc_cmd_buffer.get()];
            let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
            let fence =
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
            let result = (|| -> Result<(), TestError> {
                unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;
                unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
                Ok(())
            })();
            unsafe { device.destroy_fence(fence, None) };
            result?;
        }

        drop(execution_set_manager);
        self.verify(&output, dispatch_count)
    }

    /// `manyExecutesRun`
    fn many_executes_run(&self, dispatch_count: u32, compute_queue: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = self.queue_and_family(compute_queue)?;
        let pc_range = pc_range();

        let output = self.make_output_setup(dispatch_count)?;
        let pipeline = self.make_pipeline(*output.set_layout, false)?;
        let pipeline_layout = pipeline.get_pipeline_layout();

        // Generated commands layout: push constant and dispatch.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            pipeline_layout,
        );
        cmds_layout_builder.add_push_constant_token(0, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Increase the value index (indicated by the push constant) in each sequence, then dispatch one workgroup.
        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(4 * dispatch_count as usize);
        for i in 0..dispatch_count {
            gen_cmds_data.push(i); // PC data.
            gen_cmds_data.extend([1, 1, 1]); // VkDispatchIndirectCommand
        }
        let gen_cmds_buffer = self.upload_gen_cmds(&gen_cmds_data)?;

        // Critical for the test: instead of running all these sequences in parallel, we execute one sequence at a time. For the preprocess
        // buffer, we'll use a region of the same large buffer in each execution.
        let preprocess_alignment = 4u64;
        let gen_cmd_mem_reqs_info = DgcMemReqsInfo::new(
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            1,
            0,
            pipeline.get_pipeline(),
        );
        let mut preprocess_buffer_reqs =
            get_generated_commands_memory_requirements_ext(device, gen_cmd_mem_reqs_info.get());

        // Round up to the proper alignment, and multiply by the number of executions.
        let preprocess_buffer_stride =
            preprocess_buffer_reqs.size.div_ceil(preprocess_alignment) * preprocess_alignment;
        preprocess_buffer_reqs.size = preprocess_buffer_stride * vk::DeviceSize::from(dispatch_count);

        let mut preprocess_buffer = None;
        let mut preprocess_buffer_address = 0u64;
        if preprocess_buffer_reqs.size > 0 {
            let (buffer, address) = make_preprocess_buffer(context, preprocess_buffer_reqs.size)?;
            preprocess_buffer = Some(buffer);
            preprocess_buffer_address = address;
        }

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, qf_index)?;
        let main_cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let main_cmd_buffer = main_cmd_buffer_owner.get();

        // Main command buffer contents.
        begin_command_buffer(device, main_cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                main_cmd_buffer,
                bind_point,
                pipeline_layout,
                0,
                &[output.set.get()],
                &[] as &[u32],
            );
        }
        pipeline.bind(main_cmd_buffer);

        // Again, key for the test: run multiple executions instead of a single one.
        let gen_cmds_stride = vk::DeviceSize::from(cmds_layout_builder.get_stream_stride());
        let gen_cmds_address = gen_cmds_buffer.get_device_address();

        for i in 0..vk::DeviceSize::from(dispatch_count) {
            // Specify a per-execution offset in the commands stream and preprocess buffer.
            let gen_cmds_buffer_offset = gen_cmds_stride * i;
            let preprocess_offset = preprocess_buffer_stride * i;
            let indirect_address = gen_cmds_address + gen_cmds_buffer_offset;
            let preprocess_address = preprocess_buffer_address + preprocess_offset;

            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                indirect_address,
                gen_cmds_stride,
                preprocess_address,
                preprocess_buffer_stride,
                1,
                0,
                0,
                pipeline.get_pipeline(),
            );
            unsafe { device.cmd_execute_generated_commands_ext(main_cmd_buffer, false, cmds_info.get()) };
        }
        self.shader_write_to_host_barrier(main_cmd_buffer);
        end_command_buffer(device, main_cmd_buffer)?;
        submit_commands_and_wait(device, queue, main_cmd_buffer)?;

        drop(preprocess_buffer);
        self.verify(&output, dispatch_count)
    }

    /// `ScratchSpaceInstance::iterate`: the large shader of `ScratchSpace.comp.spvasm` needs scratch memory for register spilling.
    fn scratch_space_run(&self) -> TestOutcome {
        const LOCAL_INVOCATIONS: usize = 4;
        const EXPECTED_OUTPUTS: [i32; LOCAL_INVOCATIONS] = [-256, -46, -327, -722];

        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = self.queue_and_family(true)?;
        let buffer_size = (LOCAL_INVOCATIONS * std::mem::size_of::<i32>()) as vk::DeviceSize;

        let make_host_buffer = |values: &[i32]| -> Result<BufferWithMemory<'a>, TestError> {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let alloc = buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(values.as_ptr().cast::<u8>(), alloc.get_host_ptr(), buffer_size as usize)
            };
            flush_alloc(device, alloc)?;
            Ok(buffer)
        };
        let output_buffer = make_host_buffer(&[0i32; LOCAL_INVOCATIONS])?;
        let input_values: Vec<i32> = (0..LOCAL_INVOCATIONS as i32).collect();
        let input_buffer = make_host_buffer(&input_values)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new().add_type(desc_type, 2).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        let input_desc_info = make_descriptor_buffer_info(input_buffer.get(), 0, buffer_size);
        let output_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(set.get(), Location::binding(0), desc_type, &input_desc_info)
            .write_single(set.get(), Location::binding(1), desc_type, &output_desc_info)
            .update(device);

        // DGC pipeline.
        let mut dgc_pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        dgc_pipeline.set_descriptor_set_layout(*set_layout);
        dgc_pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
        dgc_pipeline.build_pipeline()?;
        let pipeline_layout = dgc_pipeline.get_pipeline_layout();

        // Indirect commands layout: pipeline token followed by dispatch.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            pipeline_layout,
        );
        cmds_layout_builder.add_compute_pipeline_token(0);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Pipeline index and VkDispatchIndirectCommand.
        let gen_cmds_data: Vec<u32> = vec![0, 1, 1, 1];
        let gen_cmds_buffer = self.upload_gen_cmds(&gen_cmds_data)?;

        let mut execution_set_manager = ExecutionSetManagerExt::new_pipeline(device, dgc_pipeline.get_pipeline(), 1)?;
        execution_set_manager.add_pipeline(0, dgc_pipeline.get_pipeline());
        execution_set_manager.update();
        let execution_set = execution_set_manager.get();

        let preprocess_buffer =
            PreprocessBufferExt::new(context, execution_set, cmds_layout.get(), 1, 0, vk::Pipeline::null(), 0)?;

        {
            let cmd_pool = make_command_pool(device, qf_index)?;
            let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd_buffer = cmd_buffer_owner.get();

            begin_command_buffer(device, cmd_buffer)?;
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[set.get()],
                    &[] as &[u32],
                );
            }
            dgc_pipeline.bind(cmd_buffer);
            {
                let cmds_info = DgcGenCmdsInfo::new(
                    stage_flags,
                    execution_set,
                    cmds_layout.get(),
                    gen_cmds_buffer.get_device_address(),
                    gen_cmds_buffer.get_size(),
                    preprocess_buffer.get_device_address(),
                    preprocess_buffer.get_size(),
                    1,
                    0,
                    0,
                    vk::Pipeline::null(),
                );
                unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
            }
            self.shader_write_to_host_barrier(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, queue, cmd_buffer)?;
        }

        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let mut output_values = [0i32; LOCAL_INVOCATIONS];
        unsafe {
            std::ptr::copy_nonoverlapping(
                output_alloc.get_host_ptr().cast::<i32>(),
                output_values.as_mut_ptr(),
                LOCAL_INVOCATIONS,
            )
        };

        let mut fail = false;
        for (i, (&reference, &result)) in EXPECTED_OUTPUTS.iter().zip(output_values.iter()).enumerate() {
            if result != reference {
                log::error!(
                    "Unexpected value found in output buffer at position {i}: expected {reference} but found {result}"
                );
                fail = true;
            }
        }
        drop(preprocess_buffer);
        drop(execution_set_manager);

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `nullSetLayoutsInfoRun`: two shader objects selected per sequence by an execution set created without set layout infos.
    fn null_set_layouts_info_run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let value_count = TYPICAL_WORKING_GROUP_SIZE * 2;
        let value_offset = 1000u32;

        let input_values: Vec<u32> = (0..value_count).map(|i| value_offset + i).collect();
        let buffer_size = std::mem::size_of_val(input_values.as_slice()) as vk::DeviceSize;
        let make_buffer = || {
            BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let input_buffer = make_buffer()?;
        {
            let alloc = input_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    input_values.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }
        let output_buffer = make_buffer()?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, buffer_size as usize) };
            flush_alloc(device, alloc)?;
        }

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;
        let pc_range = pc_range();
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let pool = DescriptorPoolBuilder::new().add_type(desc_type, 2).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        let output_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, vk::WHOLE_SIZE);
        let input_desc_info = make_descriptor_buffer_info(input_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(set.get(), Location::binding(0), desc_type, &output_desc_info)
            .write_single(set.get(), Location::binding(1), desc_type, &input_desc_info)
            .update(device);

        let binaries = context.get_binary_collection();
        let shader_set_layouts = [*set_layout];
        let shader_pc_ranges = [pc_range];
        let comp1_shader = create_dgc_shader(
            device,
            stage_flags,
            &binaries.get("comp1")?,
            &shader_set_layouts,
            &shader_pc_ranges,
            false,
            false,
        )?;
        let comp2_shader = create_dgc_shader(
            device,
            stage_flags,
            &binaries.get("comp2")?,
            &shader_set_layouts,
            &shader_pc_ranges,
            false,
            false,
        )?;

        // The key of the test: no set layouts info, the implementation has to fetch it from the shader.
        let mut execution_set_manager =
            ExecutionSetManagerExt::new_shader_null_layouts(device, &[comp1_shader.get()], &[pc_range], 2)?;
        execution_set_manager.add_shader(1, comp2_shader.get());
        execution_set_manager.update();
        let ies = execution_set_manager.get();

        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_compute_shader_object_token(stream_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let sequence_count = 2u32;
        let gen_cmds_data: Vec<u32> = vec![
            0, // Choose comp1.
            0, // Value offset for the first sequence.
            1,
            1,
            1,                          // Dispatch.
            1,                          // Choose comp2.
            TYPICAL_WORKING_GROUP_SIZE, // Value offset for the second sequence.
            1,
            1,
            1,
        ];
        let gen_cmds_buffer = self.upload_gen_cmds(&gen_cmds_data)?;

        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies,
            cmds_layout.get(),
            sequence_count,
            0,
            vk::Pipeline::null(),
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(cmd_buffer, bind_point, *pipeline_layout, 0, &[set.get()], &[] as &[u32]);
            device.cmd_bind_shaders_ext(cmd_buffer, &[vk::ShaderStageFlags::COMPUTE], &[comp1_shader.get()]);
        }
        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                ies,
                cmds_layout.get(),
                gen_cmds_buffer.get_device_address(),
                gen_cmds_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                sequence_count,
                0,
                0,
                vk::Pipeline::null(),
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }
        self.shader_write_to_host_barrier(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;

        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let mut output_values = vec![0u32; value_count as usize];
        unsafe {
            std::ptr::copy_nonoverlapping(
                alloc.get_host_ptr().cast::<u32>(),
                output_values.as_mut_ptr(),
                output_values.len(),
            )
        };

        let mut fail = false;
        for i in 0..value_count {
            let reference = if i < TYPICAL_WORKING_GROUP_SIZE {
                value_offset + i
            } else {
                value_offset + (value_count - 1 - (i - TYPICAL_WORKING_GROUP_SIZE))
            };
            let result = output_values[i as usize];
            if reference != result {
                fail = true;
                log::error!("Unexpected value at index {i}: expected {reference} but found {result}");
            }
        }
        drop(preprocess_buffer);
        drop(execution_set_manager);

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `DBPDInstance::iterate`: DGC with a descriptor buffer pipeline and a push descriptor set.
    fn dbpd_run(&self, use_execution_set: bool) -> TestOutcome {
        const LOCAL_SIZE: u32 = 64;
        const SEQUENCE_COUNT: u32 = 2;
        const ITEM_COUNT: u32 = SEQUENCE_COUNT * LOCAL_SIZE;
        const INITIAL_VALUE_BASE: u32 = 1000;
        const VALUE_OFFSET: u32 = 10000;

        let context = self.context;
        let device = context.get_device();
        let stages = vk::ShaderStageFlags::COMPUTE;
        let descriptor_type = vk::DescriptorType::STORAGE_BUFFER;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let pc_range = pc_range();

        let initial_values: Vec<u32> = (0..ITEM_COUNT).map(|i| INITIAL_VALUE_BASE + i).collect();
        let buffer_size = std::mem::size_of_val(initial_values.as_slice()) as vk::DeviceSize;
        let make_buffer = || {
            BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let input_buffer = make_buffer()?;
        {
            let alloc = input_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    initial_values.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }
        let output_buffer = make_buffer()?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, buffer_size as usize) };
            flush_alloc(device, alloc)?;
        }

        // Without an execution set every sequence uses the same (zero) value offset.
        let value_offsets: [u32; SEQUENCE_COUNT as usize] = [0, if use_execution_set { VALUE_OFFSET } else { 0 }];

        let set_layout_flags = vk::DescriptorSetLayoutCreateFlags::DESCRIPTOR_BUFFER_EXT
            | vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, stages)
            .add_single_binding(descriptor_type, stages)
            .build_with_flags(device, set_layout_flags)?;

        let make_pipeline =
            |value_offset: u32, indirect_bindable: bool| -> Result<ComputePipelineWrapper<'a>, TestError> {
                let mut pipeline = ComputePipelineWrapper::new(
                    device,
                    ComputePipelineConstructionType::Pipeline,
                    context.get_binary_collection().get("comp")?,
                );
                pipeline.set_descriptor_set_layout(*set_layout);
                pipeline.add_push_constant_range(pc_range);
                pipeline.set_specialization_info(
                    vec![vk::SpecializationMapEntry {
                        constant_id: 0,
                        offset: 0,
                        size: std::mem::size_of::<u32>(),
                    }],
                    value_offset.to_ne_bytes().to_vec(),
                );
                let mut flags = vk::PipelineCreateFlags2::DESCRIPTOR_BUFFER_EXT;
                if indirect_bindable {
                    flags |= vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT;
                }
                pipeline.set_pipeline_create_flags2(flags);
                pipeline.build_pipeline()?;
                Ok(pipeline)
            };

        let mut dgc_pipelines: Vec<ComputePipelineWrapper<'a>> = Vec::new();
        let mut normal_pipeline: Option<ComputePipelineWrapper<'a>> = None;
        let mut execution_set_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if use_execution_set {
            for &value_offset in &value_offsets {
                dgc_pipelines.push(make_pipeline(value_offset, true)?);
            }
            let mut manager =
                ExecutionSetManagerExt::new_pipeline(device, dgc_pipelines[0].get_pipeline(), SEQUENCE_COUNT)?;
            for (i, pipeline) in dgc_pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, pipeline.get_pipeline());
            }
            manager.update();
            execution_set_manager = Some(manager);
        } else {
            normal_pipeline = Some(make_pipeline(value_offsets[0], false)?);
        }
        let ies = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let pre_bound = dgc_pipelines.first().or(normal_pipeline.as_ref()).unwrap();
        let pipeline_layout = pre_bound.get_pipeline_layout();
        let preprocess_pipeline = if use_execution_set {
            vk::Pipeline::null()
        } else {
            pre_bound.get_pipeline()
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        begin_command_buffer(device, cmd_buffer)?;

        let mut properties = vk::PhysicalDeviceDescriptorBufferPropertiesEXT::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }

        let mut descriptor_buffer: Option<BufferWithMemory<'a>> = None;
        if properties.bufferless_push_descriptors == vk::FALSE {
            // Illegal to query the size of a push descriptor layout: use the minimum and rely on the memory requirements.
            let pd_buffer_size = properties.descriptor_buffer_offset_alignment;
            let descriptor_buffer_usage = vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
                | vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT
                | vk::BufferUsageFlags::PUSH_DESCRIPTORS_DESCRIPTOR_BUFFER_EXT;
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(pd_buffer_size, descriptor_buffer_usage),
                MemoryRequirement::DEVICE_ADDRESS,
            )?;
            let pd_handle = vk::DescriptorBufferBindingPushDescriptorBufferHandleEXT {
                buffer: buffer.get(),
                ..Default::default()
            };
            let address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
            let binding_info = vk::DescriptorBufferBindingInfoEXT {
                next: (&raw const pd_handle).cast(),
                address: unsafe { device.get_buffer_device_address(&address_info) },
                usage: descriptor_buffer_usage,
                ..Default::default()
            };
            unsafe {
                device.cmd_bind_descriptor_buffers_ext(cmd_buffer, &[binding_info]);
                device.cmd_set_descriptor_buffer_offsets_ext(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[0u32],
                    &[0 as vk::DeviceSize],
                );
            }
            descriptor_buffer = Some(buffer);
        }

        // Push descriptors just push the information instead of writing it into the descriptor buffer.
        let desc_buffer_infos = [
            make_descriptor_buffer_info(input_buffer.get(), 0, buffer_size),
            make_descriptor_buffer_info(output_buffer.get(), 0, buffer_size),
        ];
        let push_writes: Vec<vk::WriteDescriptorSet> = desc_buffer_infos
            .iter()
            .enumerate()
            .map(|(i, info)| vk::WriteDescriptorSet {
                dst_binding: i as u32,
                descriptor_count: 1,
                descriptor_type,
                buffer_info: info,
                ..Default::default()
            })
            .collect();
        unsafe { device.cmd_push_descriptor_set_khr(cmd_buffer, bind_point, pipeline_layout, 0, &push_writes) };

        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stages,
            pipeline_layout,
        );
        if use_execution_set {
            cmds_layout_builder.add_compute_pipeline_token(0);
        }
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_push_constant_token(stream_range, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut gen_cmds_data: Vec<u32> = Vec::new();
        for i in 0..SEQUENCE_COUNT {
            if use_execution_set {
                gen_cmds_data.push(i); // Pipeline index in the execution set.
            }
            gen_cmds_data.push(i * LOCAL_SIZE); // Push constant value.
            gen_cmds_data.extend([1, 1, 1]); // Dispatch size.
        }
        let gen_cmds_buffer = self.upload_gen_cmds(&gen_cmds_data)?;

        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies,
            cmds_layout.get(),
            SEQUENCE_COUNT,
            0,
            preprocess_pipeline,
            0,
        )?;
        let cmds_info = DgcGenCmdsInfo::new(
            stages,
            ies,
            cmds_layout.get(),
            gen_cmds_buffer.get_device_address(),
            gen_cmds_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            SEQUENCE_COUNT,
            0,
            0,
            preprocess_pipeline,
        );

        pre_bound.bind(cmd_buffer);
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        self.shader_write_to_host_barrier(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;

        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let mut output_values = vec![0u32; ITEM_COUNT as usize];
        unsafe {
            std::ptr::copy_nonoverlapping(
                alloc.get_host_ptr().cast::<u32>(),
                output_values.as_mut_ptr(),
                output_values.len(),
            )
        };

        let mut result_ok = true;
        for i in 0..SEQUENCE_COUNT {
            for j in 0..LOCAL_SIZE {
                let index = (i * LOCAL_SIZE + j) as usize;
                let expected = initial_values[index] + value_offsets[i as usize];
                let result = output_values[index];
                if expected != result {
                    log::error!(
                        "Unexpected value in output buffer position {index}: expected {expected} but found {result}"
                    );
                    result_ok = false;
                }
            }
        }
        drop(descriptor_buffer);
        drop(preprocess_buffer);
        drop(execution_set_manager);

        if !result_ok {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `manySequencesRun`
    fn many_sequences_run(&self, dispatch_count: u32, compute_queue: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let stage_flags = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = self.queue_and_family(compute_queue)?;
        let pc_range = pc_range();

        let output = self.make_output_setup(dispatch_count)?;
        let pipeline = self.make_pipeline(*output.set_layout, false)?;
        let pipeline_layout = pipeline.get_pipeline_layout();

        // Generated commands layout: sequence index push constant and dispatch.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            pipeline_layout,
        );
        cmds_layout_builder.add_sequence_index_token(0, pc_range);
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Increase the value index (indicated by the push constant) in each sequence, then dispatch one workgroup.
        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(4 * dispatch_count as usize);
        for _ in 0..dispatch_count {
            gen_cmds_data.push(u32::MAX); // Placeholder value for the sequence index.
            gen_cmds_data.extend([1, 1, 1]); // VkDispatchIndirectCommand
        }
        let gen_cmds_buffer = self.upload_gen_cmds(&gen_cmds_data)?;

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            dispatch_count,
            0,
            pipeline.get_pipeline(),
            0,
        )?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, qf_index)?;
        let main_cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let main_cmd_buffer = main_cmd_buffer_owner.get();

        // Main command buffer contents.
        begin_command_buffer(device, main_cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                main_cmd_buffer,
                bind_point,
                pipeline_layout,
                0,
                &[output.set.get()],
                &[] as &[u32],
            );
        }
        pipeline.bind(main_cmd_buffer);
        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                gen_cmds_buffer.get_device_address(),
                gen_cmds_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                dispatch_count,
                0,
                0,
                pipeline.get_pipeline(),
            );
            unsafe { device.cmd_execute_generated_commands_ext(main_cmd_buffer, false, cmds_info.get()) };
        }
        self.shader_write_to_host_barrier(main_cmd_buffer);
        end_command_buffer(device, main_cmd_buffer)?;
        submit_commands_and_wait(device, queue, main_cmd_buffer)?;

        self.verify(&output, dispatch_count)
    }
}

impl TestInstance for MiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::ManyExecutes {
                dispatch_count,
                compute_queue,
            } => self.many_executes_run(dispatch_count, compute_queue),
            Variant::ManySequences {
                dispatch_count,
                compute_queue,
            } => self.many_sequences_run(dispatch_count, compute_queue),
            Variant::TwoCmdBuffers {
                use_execution_set,
                compute_queue,
            } => self.two_cmd_buffers_run(use_execution_set, compute_queue),
            Variant::MaxPushConstantRange(params) => self.max_push_constant_range_run(params),
            Variant::MultipleSets {
                preprocess,
                compute_queue,
            } => self.multiple_sets_run(preprocess, compute_queue),
            Variant::InlineUniformBlocks {
                use_execution_set,
                split_sets,
                compute_queue,
            } => self.iub_usage_run(use_execution_set, split_sets, compute_queue),
            Variant::ScratchSpace => self.scratch_space_run(),
            Variant::NullSetLayoutsInfo => self.null_set_layouts_info_run(),
            Variant::DescriptorBufferPushDescriptor { use_execution_set } => self.dbpd_run(use_execution_set),
        }
    }
}

/// The parts of `createDGCComputeMiscTestsExt` ported here: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_misc_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    let mut push = |name: String, variant: Variant| {
        cases.push((
            format!("ext.compute.misc.{name}"),
            Box::new(MiscCase { name, variant }) as Box<dyn TestCase>,
        ));
    };

    for execute_count in [64u32, 1024, 8192] {
        for use_compute_queue in [false, true] {
            let queue_variant = if use_compute_queue {
                "_compute_queue"
            } else {
                "_universal_queue"
            };
            push(
                format!("execute_many_{execute_count}{queue_variant}"),
                Variant::ManyExecutes {
                    dispatch_count: execute_count,
                    compute_queue: use_compute_queue,
                },
            );
        }
    }

    for execute_count in [64u32, 1024, 8192, 131072] {
        for use_compute_queue in [false, true] {
            let queue_variant = if use_compute_queue {
                "_compute_queue"
            } else {
                "_universal_queue"
            };
            push(
                format!("many_sequences_{execute_count}{queue_variant}"),
                Variant::ManySequences {
                    dispatch_count: execute_count,
                    compute_queue: use_compute_queue,
                },
            );
        }
    }

    for pc_bytes in [128u32, 256, 4096] {
        for partial in [false, true] {
            for preprocess in [false, true] {
                for use_execution_set in [false, true] {
                    for use_compute_queue in [false, true] {
                        for push_descriptor in [false, true] {
                            let params = MaxPcParams {
                                pc_bytes,
                                partial,
                                preprocess,
                                use_execution_set,
                                push_descriptor,
                                use_compute_queue,
                            };
                            push(
                                format!(
                                    "max_pc_range_{pc_bytes}{}{}{}{}{}",
                                    if partial { "_partial" } else { "_full" },
                                    if preprocess { "_preprocess" } else { "" },
                                    if use_execution_set { "_with_execution_set" } else { "" },
                                    if push_descriptor { "_push_descriptor" } else { "" },
                                    if use_compute_queue { "_cq" } else { "" },
                                ),
                                Variant::MaxPushConstantRange(params),
                            );
                        }
                    }
                }
            }
        }
    }

    for preprocess in [false, true] {
        for use_compute_queue in [false, true] {
            push(
                format!(
                    "multiple_sets{}{}",
                    if preprocess { "_preprocess" } else { "" },
                    if use_compute_queue { "_cq" } else { "" }
                ),
                Variant::MultipleSets {
                    preprocess,
                    compute_queue: use_compute_queue,
                },
            );
        }
    }

    for use_execution_set in [false, true] {
        for split_sets in [false, true] {
            for use_compute_queue in [false, true] {
                push(
                    format!(
                        "iubs{}{}{}",
                        if use_execution_set { "_with_ies" } else { "" },
                        if split_sets { "_multiset" } else { "" },
                        if use_compute_queue { "_cq" } else { "" }
                    ),
                    Variant::InlineUniformBlocks {
                        use_execution_set,
                        split_sets,
                        compute_queue: use_compute_queue,
                    },
                );
            }
        }
    }

    for use_execution_set in [false, true] {
        for use_compute_queue in [false, true] {
            push(
                format!(
                    "two_cmd_buffers{}{}",
                    if use_compute_queue { "_cq" } else { "" },
                    if use_execution_set { "_with_ies" } else { "" }
                ),
                Variant::TwoCmdBuffers {
                    use_execution_set,
                    compute_queue: use_compute_queue,
                },
            );
        }
    }
    for use_execution_set in [false, true] {
        let name = format!(
            "descriptor_buffer_push_descriptor{}",
            if use_execution_set { "_with_ies" } else { "" }
        );
        cases.push((
            format!("ext.compute.misc.{name}"),
            Box::new(MiscCase {
                name,
                variant: Variant::DescriptorBufferPushDescriptor { use_execution_set },
            }) as Box<dyn TestCase>,
        ));
    }
    cases.push((
        "ext.compute.misc.null_set_layouts_info".to_string(),
        Box::new(MiscCase {
            name: "null_set_layouts_info".to_string(),
            variant: Variant::NullSetLayoutsInfo,
        }) as Box<dyn TestCase>,
    ));
    cases.push((
        "ext.compute.misc.scratch_space".to_string(),
        Box::new(MiscCase {
            name: "scratch_space".to_string(),
            variant: Variant::ScratchSpace,
        }) as Box<dyn TestCase>,
    ));
    cases
}
