// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCUtil.cpp
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCUtilCommon.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The helpers of the `VK_NV_device_generated_commands(_compute)` tests of `dgc.nv`: support
// checks, the indirect commands layout builder (compute bind point only), the preprocess buffer, the pipeline metadata pool and the compute
// pipelines made with it.

use std::cell::{Cell, RefCell};
use std::collections::BTreeMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, InstanceV1_1, NvDeviceGeneratedCommandsComputeExtensionDeviceCommands,
    NvDeviceGeneratedCommandsExtensionDeviceCommands,
};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::{Allocation, MemoryRequirement};
use crate::vk::obj_util::make_buffer_create_info;
use crate::vk::ref_util::Unique;
use crate::vkt::Context;

/// `checkDGCSupport`
pub fn check_dgc_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_NV_device_generated_commands")
}

/// `checkDGCComputeSupport`
pub fn check_dgc_compute_support(
    context: &Context<'_>,
    require_pipelines: bool,
    require_capture_replay: bool,
) -> Result<(), TestError> {
    context.require_device_functionality("VK_NV_device_generated_commands_compute")?;

    if require_pipelines || require_capture_replay {
        let mut features = vk::PhysicalDeviceDeviceGeneratedCommandsComputeFeaturesNV::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if require_pipelines && features.device_generated_compute_pipelines == vk::FALSE {
            return Err(TestError::NotSupported(
                "deviceGeneratedComputePipelines not supported".to_string(),
            ));
        }
        if require_capture_replay && features.device_generated_compute_capture_replay == vk::FALSE {
            return Err(TestError::NotSupported(
                "deviceGeneratedComputeCaptureReplay not supported".to_string(),
            ));
        }
    }
    Ok(())
}

/// `getGeneratedCommandsMemoryRequirementsNV` with a bind point, pipeline, layout and sequence count (`makeGeneratedCommandsMemoryRequirementsInfoNV`).
pub fn get_generated_commands_memory_requirements_nv(
    device: &Device,
    bind_point: vk::PipelineBindPoint,
    pipeline: vk::Pipeline,
    cmd_layout: vk::IndirectCommandsLayoutNV,
    max_sequences_count: u32,
) -> vk::MemoryRequirements {
    let info = vk::GeneratedCommandsMemoryRequirementsInfoNV {
        pipeline_bind_point: bind_point,
        pipeline,
        indirect_commands_layout: cmd_layout,
        max_sequences_count,
        ..Default::default()
    };
    let mut mem_reqs = vk::MemoryRequirements2::default();
    unsafe { device.get_generated_commands_memory_requirements_nv(&info, &mut mem_reqs) };
    mem_reqs.memory_requirements
}

/// `getPipelineIndirectMemoryRequirementsNV`
pub fn get_pipeline_indirect_memory_requirements_nv(
    device: &Device,
    create_info: &vk::ComputePipelineCreateInfo,
) -> vk::MemoryRequirements {
    let mut mem_reqs = vk::MemoryRequirements2::default();
    unsafe { device.get_pipeline_indirect_memory_requirements_nv(create_info, &mut mem_reqs) };
    mem_reqs.memory_requirements
}

/// `makePipelineIndirectDeviceAddressInfoNV` and the query itself.
pub fn pipeline_indirect_device_address(device: &Device, pipeline: vk::Pipeline) -> vk::DeviceAddress {
    let info = vk::PipelineIndirectDeviceAddressInfoNV {
        pipeline_bind_point: vk::PipelineBindPoint::COMPUTE,
        pipeline,
        ..Default::default()
    };
    unsafe { device.get_pipeline_indirect_device_address_nv(&info) }
}

/// `preprocessToExecuteBarrier`
pub fn preprocess_to_execute_barrier(device: &Device, cmd_buffer: vk::CommandBuffer) {
    // The NV and EXT flags share their values.
    crate::vkt::tests::dgc::util_ext::preprocess_to_execute_barrier_ext(device, cmd_buffer);
}

/// `metadataUpdateToPreprocessBarrier`
pub fn metadata_update_to_preprocess_barrier(device: &Device, cmd_buffer: vk::CommandBuffer) {
    use vulkanalia::vk::DeviceV1_3;
    let barrier = vk::MemoryBarrier2 {
        src_stage_mask: vk::PipelineStageFlags2::COPY,
        src_access_mask: vk::AccessFlags2::MEMORY_WRITE,
        dst_stage_mask: vk::PipelineStageFlags2::COMMAND_PREPROCESS_EXT,
        dst_access_mask: vk::AccessFlags2::COMMAND_PREPROCESS_READ_EXT,
        ..Default::default()
    };
    let barriers = [barrier];
    let dependency = vk::DependencyInfo::builder().memory_barriers(&barriers);
    unsafe { device.cmd_pipeline_barrier2(cmd_buffer, &dependency) };
}

/// A `VkIndirectCommandsLayoutNV` that is destroyed when dropped.
pub struct IndirectCommandsLayoutNv<'a> {
    device: &'a Device,
    layout: vk::IndirectCommandsLayoutNV,
}

impl IndirectCommandsLayoutNv<'_> {
    pub fn get(&self) -> vk::IndirectCommandsLayoutNV {
        self.layout
    }
}

impl Drop for IndirectCommandsLayoutNv<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_indirect_commands_layout_nv(self.layout, None) };
    }
}

fn is_work_provoking_token(token: vk::IndirectCommandsTokenTypeNV) -> bool {
    token == vk::IndirectCommandsTokenTypeNV::DRAW
        || token == vk::IndirectCommandsTokenTypeNV::DRAW_INDEXED
        || token == vk::IndirectCommandsTokenTypeNV::DRAW_TASKS
        || token == vk::IndirectCommandsTokenTypeNV::DRAW_MESH_TASKS
        || token == vk::IndirectCommandsTokenTypeNV::DISPATCH
}

fn token_data_size(token: &vk::IndirectCommandsLayoutTokenNV) -> u32 {
    if token.token_type == vk::IndirectCommandsTokenTypeNV::PIPELINE {
        std::mem::size_of::<vk::BindPipelineIndirectCommandNV>() as u32
    } else if token.token_type == vk::IndirectCommandsTokenTypeNV::PUSH_CONSTANT {
        token.pushconstant_size
    } else if token.token_type == vk::IndirectCommandsTokenTypeNV::DISPATCH {
        std::mem::size_of::<vk::DispatchIndirectCommand>() as u32
    } else {
        debug_assert!(false, "unsupported token type");
        0
    }
}

/// `IndirectCommandsLayoutBuilder` (the NV one)
pub struct IndirectCommandsLayoutBuilderNv {
    layout_usage_flags: vk::IndirectCommandsLayoutUsageFlagsNV,
    bind_point: vk::PipelineBindPoint,
    tokens: Vec<vk::IndirectCommandsLayoutTokenNV>,
    manual_strides: BTreeMap<u32, u32>,
}

impl IndirectCommandsLayoutBuilderNv {
    pub fn new(flags: vk::IndirectCommandsLayoutUsageFlagsNV, bind_point: vk::PipelineBindPoint) -> Self {
        // We don't support anything else currently.
        debug_assert!(bind_point == vk::PipelineBindPoint::COMPUTE);
        Self {
            layout_usage_flags: flags,
            bind_point,
            tokens: Vec::new(),
            manual_strides: BTreeMap::new(),
        }
    }

    fn simple_token(&mut self, token_type: vk::IndirectCommandsTokenTypeNV, stream: u32, offset: u32) {
        self.tokens.push(vk::IndirectCommandsLayoutTokenNV {
            token_type,
            stream,
            offset,
            ..Default::default()
        });
    }

    pub fn add_push_constant_token(
        &mut self,
        stream: u32,
        offset: u32,
        pipeline_layout: vk::PipelineLayout,
        stage_flags: vk::ShaderStageFlags,
        pc_offset: u32,
        pc_size: u32,
    ) {
        self.tokens.push(vk::IndirectCommandsLayoutTokenNV {
            token_type: vk::IndirectCommandsTokenTypeNV::PUSH_CONSTANT,
            stream,
            offset,
            pushconstant_pipeline_layout: pipeline_layout,
            pushconstant_shader_stage_flags: stage_flags,
            pushconstant_offset: pc_offset,
            pushconstant_size: pc_size,
            ..Default::default()
        });
    }

    pub fn add_pipeline_token(&mut self, stream: u32, offset: u32) {
        self.simple_token(vk::IndirectCommandsTokenTypeNV::PIPELINE, stream, offset);
    }

    pub fn add_dispatch_token(&mut self, stream: u32, offset: u32) {
        self.simple_token(vk::IndirectCommandsTokenTypeNV::DISPATCH, stream, offset);
    }

    /// Stream strides are calculated automatically by default but they can also be set manually with this method.
    pub fn set_stream_stride(&mut self, stream: u32, stride: u32) {
        self.manual_strides.insert(stream, stride);
    }

    /// The highest stream index in the array of tokens plus one.
    pub fn get_stream_count(&self) -> u32 {
        self.tokens.iter().map(|token| token.stream).max().unwrap_or(0) + 1
    }

    /// The calculated range (amount of data so far) for the given stream.
    pub fn get_stream_range(&self, stream: u32) -> u32 {
        self.tokens
            .iter()
            .filter(|token| token.stream == stream)
            .map(|token| token.offset + token_data_size(token))
            .max()
            .unwrap_or(0)
    }

    pub fn build<'a>(&self, device: &'a Device) -> Result<IndirectCommandsLayoutNv<'a>, TestError> {
        // Make sure we only have a work-provoking token and it's the last one in the sequence.
        debug_assert!(!self.tokens.is_empty());
        debug_assert!(is_work_provoking_token(self.tokens.last().expect("tokens").token_type));
        debug_assert_eq!(
            self.tokens
                .iter()
                .filter(|token| is_work_provoking_token(token.token_type))
                .count(),
            1
        );

        // For the stream strides, find, for each stream, the largest sum of offset + data size; manual strides replace the calculated ones.
        let mut strides = vec![0u32; self.get_stream_count() as usize];
        for token in &self.tokens {
            let range = token.offset + token_data_size(token);
            let stride = &mut strides[token.stream as usize];
            *stride = (*stride).max(range);
        }
        for (stream, stride) in &self.manual_strides {
            strides[*stream as usize] = *stride;
        }

        let create_info = vk::IndirectCommandsLayoutCreateInfoNV {
            flags: self.layout_usage_flags,
            pipeline_bind_point: self.bind_point,
            token_count: self.tokens.len() as u32,
            tokens: self.tokens.as_ptr(),
            stream_count: strides.len() as u32,
            stream_strides: strides.as_ptr(),
            ..Default::default()
        };
        let layout = unsafe { device.create_indirect_commands_layout_nv(&create_info, None) }
            .vk_check("vkCreateIndirectCommandsLayoutNV")?;
        Ok(IndirectCommandsLayoutNv { device, layout })
    }
}

fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 { a } else { gcd(b, a % b) }
}

/// `PreprocessBuffer` (the NV one): a buffer sized and aligned for the generated commands of the layout.
pub struct PreprocessBufferNv<'a> {
    buffer: Unique<'a, vk::Buffer>,
    _allocation: Allocation<'a>,
    size: vk::DeviceSize,
}

impl<'a> PreprocessBufferNv<'a> {
    pub fn new(
        context: &'a Context<'a>,
        bind_point: vk::PipelineBindPoint,
        pipeline: vk::Pipeline,
        cmd_layout: vk::IndirectCommandsLayoutNV,
        max_sequences: u32,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let dgc_mem_reqs =
            get_generated_commands_memory_requirements_nv(device, bind_point, pipeline, cmd_layout, max_sequences);

        let create_info = make_buffer_create_info(dgc_mem_reqs.size, vk::BufferUsageFlags::INDIRECT_BUFFER);
        let buffer = unsafe { device.create_buffer(&create_info, None) }.vk_check("vkCreateBuffer")?;
        let buffer = Unique::new(device, buffer);

        let mut mem_reqs = unsafe { device.get_buffer_memory_requirements(*buffer) };
        let alignment = mem_reqs.alignment.max(1);
        let other = dgc_mem_reqs.alignment.max(1);
        mem_reqs.alignment = alignment / gcd(alignment, other) * other;
        mem_reqs.memory_type_bits &= dgc_mem_reqs.memory_type_bits;
        let allocation = context
            .get_default_allocator()
            .allocate(device, mem_reqs, MemoryRequirement::ANY)?;
        unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset()) }
            .vk_check("vkBindBufferMemory")?;
        Ok(Self {
            buffer,
            _allocation: allocation,
            size: mem_reqs.size,
        })
    }

    pub fn get(&self) -> vk::Buffer {
        *self.buffer
    }

    pub fn get_size(&self) -> vk::DeviceSize {
        self.size
    }
}

/// `makeIndirectCommandsStreamNV`
pub fn make_indirect_commands_stream_nv(buffer: vk::Buffer, offset: vk::DeviceSize) -> vk::IndirectCommandsStreamNV {
    vk::IndirectCommandsStreamNV { buffer, offset }
}

/// A `VkGeneratedCommandsInfoNV` over one stream (the tests of the group only use one) and its streams array.
pub struct GeneratedCommandsInfoNv {
    info: vk::GeneratedCommandsInfoNV,
    _streams: Box<[vk::IndirectCommandsStreamNV]>,
}

impl GeneratedCommandsInfoNv {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        bind_point: vk::PipelineBindPoint,
        pipeline: vk::Pipeline,
        cmd_layout: vk::IndirectCommandsLayoutNV,
        streams: &[vk::IndirectCommandsStreamNV],
        sequences_count: u32,
        preprocess_buffer: vk::Buffer,
        preprocess_size: vk::DeviceSize,
        sequences_count_buffer: vk::Buffer,
        sequences_count_offset: vk::DeviceSize,
    ) -> Self {
        let streams: Box<[vk::IndirectCommandsStreamNV]> = streams.to_vec().into_boxed_slice();
        let info = vk::GeneratedCommandsInfoNV {
            pipeline_bind_point: bind_point,
            pipeline,
            indirect_commands_layout: cmd_layout,
            stream_count: streams.len() as u32,
            streams: streams.as_ptr(),
            sequences_count,
            preprocess_buffer,
            preprocess_offset: 0,
            preprocess_size,
            sequences_count_buffer,
            sequences_count_offset,
            sequences_index_buffer: vk::Buffer::null(),
            sequences_index_offset: 0,
            ..Default::default()
        };
        Self {
            info,
            _streams: streams,
        }
    }

    /// The same info with a sequences index buffer.
    pub fn with_sequences_index(mut self, buffer: vk::Buffer, offset: vk::DeviceSize) -> Self {
        self.info.sequences_index_buffer = buffer;
        self.info.sequences_index_offset = offset;
        self
    }

    /// The same info with an offset into the preprocess buffer.
    pub fn with_preprocess_offset(mut self, offset: vk::DeviceSize) -> Self {
        self.info.preprocess_offset = offset;
        self
    }

    pub fn get(&self) -> &vk::GeneratedCommandsInfoNV {
        &self.info
    }
}

/// `beginSecondaryCommandBuffer` without a render pass: a one time submit secondary command buffer.
pub fn begin_plain_secondary_command_buffer(device: &Device, cmd_buffer: vk::CommandBuffer) -> Result<(), TestError> {
    let inheritance = vk::CommandBufferInheritanceInfo {
        occlusion_query_enable: vk::FALSE,
        ..Default::default()
    };
    let info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
        .inheritance_info(&inheritance);
    unsafe { device.begin_command_buffer(cmd_buffer, &info) }.vk_check("vkBeginCommandBuffer")
}

/// `DGCComputePipelineMetaDataPool`: one allocation shared by the metadata of many pipelines.
pub struct DgcComputePipelineMetaDataPool<'a> {
    context: &'a Context<'a>,
    multiplier: u32,
    capture_replay: bool,
    buffer: RefCell<Option<PoolBuffer<'a>>>,
    next_offset: Cell<vk::DeviceSize>,
}

struct PoolBuffer<'a> {
    _buffer: Unique<'a, vk::Buffer>,
    _allocation: Allocation<'a>,
    allocation_size: vk::DeviceSize,
    address: vk::DeviceAddress,
}

#[derive(Clone, Copy, Default)]
pub struct MetaDataLocation {
    pub address: vk::DeviceAddress,
    pub size: vk::DeviceSize,
}

impl<'a> DgcComputePipelineMetaDataPool<'a> {
    pub const DEFAULT_MULTIPLIER: u32 = 1024;

    pub fn new(context: &'a Context<'a>, multiplier: u32, capture_replay: bool) -> Self {
        Self {
            context,
            multiplier,
            capture_replay,
            buffer: RefCell::new(None),
            next_offset: Cell::new(0),
        }
    }

    /// Requests memory for a new pipeline.
    pub fn get_meta_data_location(
        &self,
        create_info: &vk::ComputePipelineCreateInfo,
    ) -> Result<MetaDataLocation, TestError> {
        let device = self.context.get_device();
        let mem_reqs = get_pipeline_indirect_memory_requirements_nv(device, create_info);

        let mut slot = self.buffer.borrow_mut();
        if slot.is_none() {
            let mut allocation_mem_reqs = mem_reqs;
            allocation_mem_reqs.size *= vk::DeviceSize::from(self.multiplier);
            let allocation_size = allocation_mem_reqs.size;
            let buffer_usage = vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
                | vk::BufferUsageFlags::TRANSFER_DST
                | vk::BufferUsageFlags::INDIRECT_BUFFER;
            let buffer_create_info = make_buffer_create_info(allocation_size, buffer_usage);
            let buffer = unsafe { device.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?;
            let buffer = Unique::new(device, buffer);
            let allocator = self.context.get_default_allocator();
            let allocation = if self.capture_replay {
                allocator.allocate_with_flags(
                    device,
                    allocation_mem_reqs,
                    MemoryRequirement::DEVICE_ADDRESS,
                    vk::MemoryAllocateFlags::DEVICE_ADDRESS | vk::MemoryAllocateFlags::DEVICE_ADDRESS_CAPTURE_REPLAY,
                    None,
                )?
            } else {
                allocator.allocate(device, allocation_mem_reqs, MemoryRequirement::DEVICE_ADDRESS)?
            };
            unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset()) }
                .vk_check("vkBindBufferMemory")?;
            let address_info = vk::BufferDeviceAddressInfo::builder().buffer(*buffer);
            let address = unsafe { device.get_buffer_device_address(&address_info) };
            *slot = Some(PoolBuffer {
                _buffer: buffer,
                _allocation: allocation,
                allocation_size,
                address,
            });
        }
        let pool_buffer = slot.as_ref().expect("pool buffer");

        let alignment = mem_reqs.alignment.max(1);
        let data_offset = self.next_offset.get().div_ceil(alignment) * alignment;
        let data_size = mem_reqs.size;
        self.next_offset.set(data_offset + data_size);

        // If this fails we are creating too many pipelines for the pool; increase its multiplier.
        if self.next_offset.get() > pool_buffer.allocation_size {
            return Err(TestError::InternalError(
                "pipeline metadata pool overflow, increase the multiplier".to_string(),
            ));
        }
        Ok(MetaDataLocation {
            address: pool_buffer.address + data_offset,
            size: data_size,
        })
    }
}

/// `DGCComputePipeline`: a compute pipeline made to be used with DGC (always indirect bindable, with its metadata in a pool).
pub struct DgcComputePipeline<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    indirect_device_address: vk::DeviceAddress,
}

impl<'a> DgcComputePipeline<'a> {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        meta_data_pool: &DgcComputePipelineMetaDataPool<'a>,
        device: &'a Device,
        pipeline_flags: vk::PipelineCreateFlags,
        pipeline_layout: vk::PipelineLayout,
        shader_flags: vk::PipelineShaderStageCreateFlags,
        module: vk::ShaderModule,
        specialization_info: Option<&vk::SpecializationInfo>,
        pipeline_device_address_capture_replay: vk::DeviceAddress,
        base_pipeline_handle: vk::Pipeline,
        base_pipeline_index: i32,
        subgroup_size: u32,
    ) -> Result<Self, TestError> {
        let subgroup_size_info = vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
            required_subgroup_size: subgroup_size,
            ..Default::default()
        };

        let mut stage = vk::PipelineShaderStageCreateInfo {
            flags: shader_flags,
            stage: vk::ShaderStageFlags::COMPUTE,
            module,
            name: c"main".as_ptr(),
            specialization_info: specialization_info.map_or(std::ptr::null(), |info| info as *const _),
            ..Default::default()
        };
        if subgroup_size > 0 {
            stage.next = (&subgroup_size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast();
        }

        // Make sure the required flag is always passed.
        let creation_flags = pipeline_flags | vk::PipelineCreateFlags::INDIRECT_BINDABLE_NV;
        let mut create_info = vk::ComputePipelineCreateInfo {
            flags: creation_flags,
            stage,
            layout: pipeline_layout,
            base_pipeline_handle,
            base_pipeline_index,
            ..Default::default()
        };

        let meta_data_location = meta_data_pool.get_meta_data_location(&create_info)?;

        let meta_data_buffer_info = vk::ComputePipelineIndirectBufferInfoNV {
            device_address: meta_data_location.address,
            size: meta_data_location.size,
            pipeline_device_address_capture_replay,
            ..Default::default()
        };
        create_info.next = (&meta_data_buffer_info as *const vk::ComputePipelineIndirectBufferInfoNV).cast();
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let indirect_device_address = pipeline_indirect_device_address(device, *pipeline);
        Ok(Self {
            pipeline,
            indirect_device_address,
        })
    }

    pub fn get(&self) -> vk::Pipeline {
        *self.pipeline
    }

    pub fn get_indirect_device_address(&self) -> vk::DeviceAddress {
        self.indirect_device_address
    }
}

/// `makeComputePipeline` with the required subgroup size of the stage (zero for none): a plain compute pipeline for the tests that also use DGC
/// pipelines.
pub fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
    subgroup_size: u32,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let subgroup_size_info = vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
        required_subgroup_size: subgroup_size,
        ..Default::default()
    };
    let mut stage = vk::PipelineShaderStageCreateInfo {
        stage: vk::ShaderStageFlags::COMPUTE,
        module,
        name: c"main".as_ptr(),
        ..Default::default()
    };
    if subgroup_size > 0 {
        stage.next = (&subgroup_size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast();
    }
    let info = vk::ComputePipelineCreateInfo {
        stage,
        layout,
        base_pipeline_index: -1,
        ..Default::default()
    };
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}
