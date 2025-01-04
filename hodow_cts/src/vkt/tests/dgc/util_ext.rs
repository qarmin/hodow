// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCUtilExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Pipelines only (no shader objects, no execution set manager yet), the tokens that carry no data
// beyond a push constant range (no vertex/index buffer or execution set tokens yet). The preprocess buffer is allocated from the memory
// requirements of the buffer alone: upstream also intersects them with the ones of the generated commands.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtDeviceGeneratedCommandsExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info, make_memory_barrier};
use crate::vkt::Context;

pub const EXTENSION_NAME: &str = "VK_EXT_device_generated_commands";

/// `getDeviceGeneratedCommandsPropertiesEXT`
pub fn device_generated_commands_properties(
    context: &Context<'_>,
) -> vk::PhysicalDeviceDeviceGeneratedCommandsPropertiesEXT {
    let mut dgc_properties = vk::PhysicalDeviceDeviceGeneratedCommandsPropertiesEXT::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut dgc_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    dgc_properties
}

/// `checkDGCExtSupport`
pub fn check_dgc_ext_support(
    context: &Context<'_>,
    stages: vk::ShaderStageFlags,
    bind_stages_pipeline: vk::ShaderStageFlags,
    bind_stages_shader_object: vk::ShaderStageFlags,
    input_mode_flags: vk::IndirectCommandsInputModeFlagsEXT,
    transform_feedback: bool,
) -> Result<(), TestError> {
    context.require_device_functionality(EXTENSION_NAME)?;

    let dgc_properties = device_generated_commands_properties(context);
    if (dgc_properties.supported_indirect_commands_shader_stages & stages) != stages {
        return Err(TestError::NotSupported("Required DGC stages not supported".to_string()));
    }
    if (dgc_properties.supported_indirect_commands_shader_stages_pipeline_binding & bind_stages_pipeline)
        != bind_stages_pipeline
    {
        return Err(TestError::NotSupported(
            "Required DGC pipeline bind stages not supported".to_string(),
        ));
    }
    if (dgc_properties.supported_indirect_commands_shader_stages_shader_binding & bind_stages_shader_object)
        != bind_stages_shader_object
    {
        return Err(TestError::NotSupported(
            "Required DGC shader object bind stages not supported".to_string(),
        ));
    }
    if (dgc_properties.supported_indirect_commands_input_modes & input_mode_flags) != input_mode_flags {
        return Err(TestError::NotSupported(
            "Required DGC index buffer input modes not supported".to_string(),
        ));
    }
    if transform_feedback && dgc_properties.device_generated_commands_transform_feedback == vk::FALSE {
        return Err(TestError::NotSupported(
            "DGC transform feedback not supported".to_string(),
        ));
    }
    Ok(())
}

/// `DGCComputeSupportType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DgcComputeSupportType {
    Basic,
    BindPipeline,
    BindShader,
}

/// `checkDGCExtComputeSupport`
pub fn check_dgc_ext_compute_support(
    context: &Context<'_>,
    support_type: DgcComputeSupportType,
) -> Result<(), TestError> {
    let stages = vk::ShaderStageFlags::COMPUTE;
    let bind_stages_pipeline = if support_type == DgcComputeSupportType::BindPipeline {
        stages
    } else {
        vk::ShaderStageFlags::empty()
    };
    let bind_stages_shader_object = if support_type == DgcComputeSupportType::BindShader {
        stages
    } else {
        vk::ShaderStageFlags::empty()
    };
    check_dgc_ext_support(
        context,
        stages,
        bind_stages_pipeline,
        bind_stages_shader_object,
        vk::IndirectCommandsInputModeFlagsEXT::empty(),
        false,
    )
}

/// `preprocessToExecuteBarrierExt`
pub fn preprocess_to_execute_barrier_ext(device: &Device, cmd_buffer: vk::CommandBuffer) {
    let pre_execution_barrier = make_memory_barrier(
        vk::AccessFlags::COMMAND_PREPROCESS_WRITE_EXT,
        vk::AccessFlags::INDIRECT_COMMAND_READ,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::COMMAND_PREPROCESS_EXT,
            vk::PipelineStageFlags::DRAW_INDIRECT,
            vk::DependencyFlags::empty(),
            &[pre_execution_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// The `VkIndirectCommandsLayoutEXT` of `IndirectCommandsLayoutBuilderExt::build`, destroyed when dropped.
pub struct IndirectCommandsLayoutExt<'a> {
    device: &'a Device,
    handle: vk::IndirectCommandsLayoutEXT,
}

impl IndirectCommandsLayoutExt<'_> {
    pub fn get(&self) -> vk::IndirectCommandsLayoutEXT {
        self.handle
    }
}

impl Drop for IndirectCommandsLayoutExt<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_indirect_commands_layout_ext(self.handle, None) };
    }
}

struct InternalToken {
    type_: vk::IndirectCommandsTokenTypeEXT,
    offset: u32,
    push_constant: Option<Box<vk::IndirectCommandsPushConstantTokenEXT>>,
    execution_set: Option<Box<vk::IndirectCommandsExecutionSetTokenEXT>>,
    vertex_buffer: Option<Box<vk::IndirectCommandsVertexBufferTokenEXT>>,
    index_buffer: Option<Box<vk::IndirectCommandsIndexBufferTokenEXT>>,
}

impl InternalToken {
    fn as_vk_token(&self) -> vk::IndirectCommandsLayoutTokenEXT {
        let mut data = vk::IndirectCommandsTokenDataEXT::default();
        if let Some(push_constant) = &self.push_constant {
            data.push_constant = &**push_constant;
        }
        if let Some(execution_set) = &self.execution_set {
            data.execution_set = &**execution_set;
        }
        if let Some(vertex_buffer) = &self.vertex_buffer {
            data.vertex_buffer = &**vertex_buffer;
        }
        if let Some(index_buffer) = &self.index_buffer {
            data.index_buffer = &**index_buffer;
        }
        vk::IndirectCommandsLayoutTokenEXT {
            type_: self.type_,
            data,
            offset: self.offset,
            ..Default::default()
        }
    }

    fn is_work_provoking(&self) -> bool {
        !matches!(
            self.type_,
            vk::IndirectCommandsTokenTypeEXT::EXECUTION_SET
                | vk::IndirectCommandsTokenTypeEXT::PUSH_CONSTANT
                | vk::IndirectCommandsTokenTypeEXT::SEQUENCE_INDEX
                | vk::IndirectCommandsTokenTypeEXT::PUSH_DATA
                | vk::IndirectCommandsTokenTypeEXT::PUSH_DATA_SEQUENCE_INDEX
                | vk::IndirectCommandsTokenTypeEXT::INDEX_BUFFER
                | vk::IndirectCommandsTokenTypeEXT::VERTEX_BUFFER
        )
    }

    /// `tokenDataSize`
    fn data_size(&self) -> u32 {
        const U32_SIZE: u32 = 4;
        match self.type_ {
            // When using pipelines, we only need 1 index. When using shader objects, we need one index per stage indicated in the token.
            vk::IndirectCommandsTokenTypeEXT::EXECUTION_SET => {
                let index_count = match &self.execution_set {
                    Some(execution_set)
                        if execution_set.type_ == vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS =>
                    {
                        execution_set.shader_stages.bits().count_ones()
                    }
                    _ => 1,
                };
                U32_SIZE * index_count
            }
            vk::IndirectCommandsTokenTypeEXT::PUSH_CONSTANT
            | vk::IndirectCommandsTokenTypeEXT::SEQUENCE_INDEX
            | vk::IndirectCommandsTokenTypeEXT::PUSH_DATA
            | vk::IndirectCommandsTokenTypeEXT::PUSH_DATA_SEQUENCE_INDEX => self
                .push_constant
                .as_ref()
                .map_or(0, |push_constant| push_constant.update_range.size),
            vk::IndirectCommandsTokenTypeEXT::INDEX_BUFFER => {
                std::mem::size_of::<vk::BindIndexBufferIndirectCommandEXT>() as u32
            }
            vk::IndirectCommandsTokenTypeEXT::VERTEX_BUFFER => {
                std::mem::size_of::<vk::BindVertexBufferIndirectCommandEXT>() as u32
            }
            vk::IndirectCommandsTokenTypeEXT::DRAW_INDEXED => {
                std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32
            }
            vk::IndirectCommandsTokenTypeEXT::DRAW => std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
            vk::IndirectCommandsTokenTypeEXT::DRAW_INDEXED_COUNT
            | vk::IndirectCommandsTokenTypeEXT::DRAW_COUNT
            | vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS_COUNT_NV
            | vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS_COUNT => {
                std::mem::size_of::<vk::DrawIndirectCountIndirectCommandEXT>() as u32
            }
            vk::IndirectCommandsTokenTypeEXT::DISPATCH => std::mem::size_of::<vk::DispatchIndirectCommand>() as u32,
            vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS_NV => {
                std::mem::size_of::<vk::DrawMeshTasksIndirectCommandNV>() as u32
            }
            vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS => {
                std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32
            }
            _ => 0,
        }
    }
}

/// `IndirectCommandsLayoutBuilderExt`
pub struct IndirectCommandsLayoutBuilderExt {
    layout_usage_flags: vk::IndirectCommandsLayoutUsageFlagsEXT,
    shader_stages: vk::ShaderStageFlags,
    pipeline_layout: vk::PipelineLayout,
    tokens: Vec<InternalToken>,
    manual_stride: Option<u32>,
    layout_create_info: *const vk::PipelineLayoutCreateInfo,
}

impl IndirectCommandsLayoutBuilderExt {
    pub fn new(
        usage_flags: vk::IndirectCommandsLayoutUsageFlagsEXT,
        stage_flags: vk::ShaderStageFlags,
        pipeline_layout: vk::PipelineLayout,
    ) -> Self {
        Self {
            layout_usage_flags: usage_flags,
            shader_stages: stage_flags,
            pipeline_layout,
            tokens: Vec::new(),
            manual_stride: None,
            layout_create_info: std::ptr::null(),
        }
    }

    /// The `pPipelineLayout` parameter of the C++ constructor (`dynamicGeneratedPipelineLayout`): the layout handle given to `new` must then
    /// be null, and the structure with what it points to must outlive the call to `build`.
    pub fn set_pipeline_layout_create_info(&mut self, create_info: &vk::PipelineLayoutCreateInfo) {
        self.layout_create_info = create_info;
    }

    pub fn add_simple_token(&mut self, offset: u32, token_type: vk::IndirectCommandsTokenTypeEXT) {
        self.tokens.push(InternalToken {
            type_: token_type,
            offset,
            push_constant: None,
            execution_set: None,
            vertex_buffer: None,
            index_buffer: None,
        });
    }

    pub fn add_execution_set_token(
        &mut self,
        offset: u32,
        set_type: vk::IndirectExecutionSetInfoTypeEXT,
        stages: vk::ShaderStageFlags,
    ) {
        self.tokens.push(InternalToken {
            type_: vk::IndirectCommandsTokenTypeEXT::EXECUTION_SET,
            offset,
            push_constant: None,
            execution_set: Some(Box::new(vk::IndirectCommandsExecutionSetTokenEXT {
                type_: set_type,
                shader_stages: stages,
            })),
            vertex_buffer: None,
            index_buffer: None,
        });
    }

    pub fn add_compute_pipeline_token(&mut self, offset: u32) {
        self.add_execution_set_token(
            offset,
            vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
            vk::ShaderStageFlags::COMPUTE,
        );
    }

    pub fn add_compute_shader_object_token(&mut self, offset: u32) {
        self.add_execution_set_token(
            offset,
            vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS,
            vk::ShaderStageFlags::COMPUTE,
        );
    }

    fn add_push_constant_like_token(
        &mut self,
        offset: u32,
        token_type: vk::IndirectCommandsTokenTypeEXT,
        pc_range: vk::PushConstantRange,
    ) {
        self.tokens.push(InternalToken {
            type_: token_type,
            offset,
            push_constant: Some(Box::new(vk::IndirectCommandsPushConstantTokenEXT {
                update_range: pc_range,
            })),
            execution_set: None,
            vertex_buffer: None,
            index_buffer: None,
        });
    }

    pub fn add_push_constant_token(&mut self, offset: u32, pc_range: vk::PushConstantRange) {
        self.add_push_constant_like_token(offset, vk::IndirectCommandsTokenTypeEXT::PUSH_CONSTANT, pc_range);
    }

    pub fn add_push_data_token(&mut self, offset: u32, pc_range: vk::PushConstantRange) {
        self.add_push_constant_like_token(offset, vk::IndirectCommandsTokenTypeEXT::PUSH_DATA, pc_range);
    }

    pub fn add_sequence_index_token(&mut self, offset: u32, pc_range: vk::PushConstantRange) {
        debug_assert_eq!(pc_range.size, 4);
        self.add_push_constant_like_token(offset, vk::IndirectCommandsTokenTypeEXT::SEQUENCE_INDEX, pc_range);
    }

    pub fn add_push_data_sequence_index_token(&mut self, offset: u32, pc_range: vk::PushConstantRange) {
        debug_assert_eq!(pc_range.size, 4);
        self.add_push_constant_like_token(
            offset,
            vk::IndirectCommandsTokenTypeEXT::PUSH_DATA_SEQUENCE_INDEX,
            pc_range,
        );
    }

    pub fn add_vertex_buffer_token(&mut self, offset: u32, binding_number: u32) {
        self.tokens.push(InternalToken {
            type_: vk::IndirectCommandsTokenTypeEXT::VERTEX_BUFFER,
            offset,
            push_constant: None,
            execution_set: None,
            vertex_buffer: Some(Box::new(vk::IndirectCommandsVertexBufferTokenEXT {
                vertex_binding_unit: binding_number,
            })),
            index_buffer: None,
        });
    }

    pub fn add_index_buffer_token(&mut self, offset: u32, mode: vk::IndirectCommandsInputModeFlagsEXT) {
        self.tokens.push(InternalToken {
            type_: vk::IndirectCommandsTokenTypeEXT::INDEX_BUFFER,
            offset,
            push_constant: None,
            execution_set: None,
            vertex_buffer: None,
            index_buffer: Some(Box::new(vk::IndirectCommandsIndexBufferTokenEXT { mode })),
        });
    }

    pub fn add_draw_indexed_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW_INDEXED);
    }

    pub fn add_draw_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW);
    }

    pub fn add_draw_indexed_count_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW_INDEXED_COUNT);
    }

    pub fn add_draw_count_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW_COUNT);
    }

    pub fn add_dispatch_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DISPATCH);
    }

    pub fn add_draw_mesh_tasks_nv_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS_NV);
    }

    pub fn add_draw_mesh_tasks_count_nv_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS_COUNT_NV);
    }

    pub fn add_draw_mesh_tasks_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS);
    }

    pub fn add_draw_mesh_tasks_count_token(&mut self, offset: u32) {
        self.add_simple_token(offset, vk::IndirectCommandsTokenTypeEXT::DRAW_MESH_TASKS_COUNT);
    }

    pub fn set_stream_stride(&mut self, stride: u32) {
        self.manual_stride = Some(stride);
    }

    pub fn get_stream_stride(&self) -> u32 {
        self.manual_stride.unwrap_or_else(|| self.get_stream_range())
    }

    pub fn get_stream_range(&self) -> u32 {
        self.tokens
            .iter()
            .map(|token| token.offset + token.data_size())
            .max()
            .unwrap_or(0)
    }

    /// `build`
    pub fn build<'a>(&self, device: &'a Device) -> Result<IndirectCommandsLayoutExt<'a>, TestError> {
        // Make sure we only have a work-provoking token and it's the last one in the sequence.
        debug_assert!(self.tokens.last().is_some_and(InternalToken::is_work_provoking));
        debug_assert_eq!(self.tokens.iter().filter(|token| token.is_work_provoking()).count(), 1);

        let vk_tokens: Vec<vk::IndirectCommandsLayoutTokenEXT> =
            self.tokens.iter().map(InternalToken::as_vk_token).collect();

        let create_info = vk::IndirectCommandsLayoutCreateInfoEXT {
            next: self.layout_create_info.cast(),
            flags: self.layout_usage_flags,
            shader_stages: self.shader_stages,
            indirect_stride: self.get_stream_stride(),
            pipeline_layout: self.pipeline_layout,
            token_count: vk_tokens.len() as u32,
            tokens: vk_tokens.as_ptr(),
            ..Default::default()
        };
        let handle = unsafe { device.create_indirect_commands_layout_ext(&create_info, None) }
            .vk_check("vkCreateIndirectCommandsLayoutEXT")?;
        Ok(IndirectCommandsLayoutExt { device, handle })
    }
}

/// The pipeline info `DGCMemReqsInfo` and `DGCGenCmdsInfo` chain behind their structure when no execution set is used.
fn pipeline_info(pipeline: vk::Pipeline) -> Box<vk::GeneratedCommandsPipelineInfoEXT> {
    Box::new(vk::GeneratedCommandsPipelineInfoEXT {
        pipeline,
        ..Default::default()
    })
}

/// The `VkGeneratedCommandsShaderInfoEXT` chained when shader objects are used without an execution set, with the handles it points to.
struct ShaderChain {
    _shaders: Box<[vk::ShaderEXT]>,
    info: Box<vk::GeneratedCommandsShaderInfoEXT>,
}

impl ShaderChain {
    fn new(shaders: &[vk::ShaderEXT]) -> Self {
        let shaders: Box<[vk::ShaderEXT]> = shaders.into();
        let info = Box::new(vk::GeneratedCommandsShaderInfoEXT {
            shader_count: shaders.len() as u32,
            shaders: shaders.as_ptr(),
            ..Default::default()
        });
        Self {
            _shaders: shaders,
            info,
        }
    }
}

/// `DGCMemReqsInfo`
pub struct DgcMemReqsInfo {
    mem_reqs: vk::GeneratedCommandsMemoryRequirementsInfoEXT,
    _pipeline_info: Option<Box<vk::GeneratedCommandsPipelineInfoEXT>>,
    _shader_chain: Option<ShaderChain>,
}

impl DgcMemReqsInfo {
    pub fn new(
        ies: vk::IndirectExecutionSetEXT,
        cmds_layout: vk::IndirectCommandsLayoutEXT,
        max_seq_count: u32,
        max_draw_count: u32,
        pipeline: vk::Pipeline,
    ) -> Self {
        let pipeline_info = (ies == vk::IndirectExecutionSetEXT::null() && pipeline != vk::Pipeline::null())
            .then(|| pipeline_info(pipeline));
        let mut mem_reqs = vk::GeneratedCommandsMemoryRequirementsInfoEXT {
            indirect_execution_set: ies,
            indirect_commands_layout: cmds_layout,
            max_sequence_count: max_seq_count,
            max_draw_count,
            ..Default::default()
        };
        if let Some(info) = &pipeline_info {
            mem_reqs.next = (&**info as *const vk::GeneratedCommandsPipelineInfoEXT).cast();
        }
        Self {
            mem_reqs,
            _pipeline_info: pipeline_info,
            _shader_chain: None,
        }
    }

    /// The same with shader objects instead of a pipeline (used when there is no execution set).
    pub fn new_with_shaders(
        ies: vk::IndirectExecutionSetEXT,
        cmds_layout: vk::IndirectCommandsLayoutEXT,
        max_seq_count: u32,
        max_draw_count: u32,
        shaders: &[vk::ShaderEXT],
    ) -> Self {
        let mut result = Self::new(ies, cmds_layout, max_seq_count, max_draw_count, vk::Pipeline::null());
        if ies == vk::IndirectExecutionSetEXT::null() && !shaders.is_empty() {
            let chain = ShaderChain::new(shaders);
            result.mem_reqs.next = (&*chain.info as *const vk::GeneratedCommandsShaderInfoEXT).cast();
            result._shader_chain = Some(chain);
        }
        result
    }

    pub fn set_max_sequence_count(&mut self, max_sequence_count: u32) {
        self.mem_reqs.max_sequence_count = max_sequence_count;
    }

    pub fn set_commands_layout(&mut self, layout: vk::IndirectCommandsLayoutEXT) {
        self.mem_reqs.indirect_commands_layout = layout;
    }

    pub fn get(&self) -> &vk::GeneratedCommandsMemoryRequirementsInfoEXT {
        &self.mem_reqs
    }
}

/// `DGCGenCmdsInfo`
pub struct DgcGenCmdsInfo {
    gen_cmds_info: vk::GeneratedCommandsInfoEXT,
    _pipeline_info: Option<Box<vk::GeneratedCommandsPipelineInfoEXT>>,
    _shader_chain: Option<ShaderChain>,
}

impl DgcGenCmdsInfo {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        shader_stages: vk::ShaderStageFlags,
        ies: vk::IndirectExecutionSetEXT,
        indirect_commands_layout: vk::IndirectCommandsLayoutEXT,
        indirect_address: vk::DeviceAddress,
        indirect_address_size: vk::DeviceSize,
        preprocess_address: vk::DeviceAddress,
        preprocess_size: vk::DeviceSize,
        max_sequence_count: u32,
        sequence_count_address: vk::DeviceAddress,
        max_draw_count: u32,
        pipeline: vk::Pipeline,
    ) -> Self {
        let pipeline_info = (ies == vk::IndirectExecutionSetEXT::null() && pipeline != vk::Pipeline::null())
            .then(|| pipeline_info(pipeline));
        let mut gen_cmds_info = vk::GeneratedCommandsInfoEXT {
            shader_stages,
            indirect_execution_set: ies,
            indirect_commands_layout,
            indirect_address,
            indirect_address_size,
            preprocess_address,
            preprocess_size,
            max_sequence_count,
            sequence_count_address,
            max_draw_count,
            ..Default::default()
        };
        if let Some(info) = &pipeline_info {
            gen_cmds_info.next = (&**info as *const vk::GeneratedCommandsPipelineInfoEXT).cast();
        }
        Self {
            gen_cmds_info,
            _pipeline_info: pipeline_info,
            _shader_chain: None,
        }
    }

    /// The same with shader objects instead of a pipeline (used when there is no execution set).
    #[allow(clippy::too_many_arguments)]
    pub fn new_with_shaders(
        shader_stages: vk::ShaderStageFlags,
        ies: vk::IndirectExecutionSetEXT,
        indirect_commands_layout: vk::IndirectCommandsLayoutEXT,
        indirect_address: vk::DeviceAddress,
        indirect_address_size: vk::DeviceSize,
        preprocess_address: vk::DeviceAddress,
        preprocess_size: vk::DeviceSize,
        max_sequence_count: u32,
        sequence_count_address: vk::DeviceAddress,
        max_draw_count: u32,
        shaders: &[vk::ShaderEXT],
    ) -> Self {
        let mut result = Self::new(
            shader_stages,
            ies,
            indirect_commands_layout,
            indirect_address,
            indirect_address_size,
            preprocess_address,
            preprocess_size,
            max_sequence_count,
            sequence_count_address,
            max_draw_count,
            vk::Pipeline::null(),
        );
        if ies == vk::IndirectExecutionSetEXT::null() && !shaders.is_empty() {
            let chain = ShaderChain::new(shaders);
            result.gen_cmds_info.next = (&*chain.info as *const vk::GeneratedCommandsShaderInfoEXT).cast();
            result._shader_chain = Some(chain);
        }
        result
    }

    pub fn get(&self) -> &vk::GeneratedCommandsInfoEXT {
        &self.gen_cmds_info
    }
}

/// `getGeneratedCommandsMemoryRequirementsExt`
pub fn get_generated_commands_memory_requirements_ext(
    device: &Device,
    info: &vk::GeneratedCommandsMemoryRequirementsInfoEXT,
) -> vk::MemoryRequirements {
    let mut mem_reqs = vk::MemoryRequirements2::default();
    unsafe { device.get_generated_commands_memory_requirements_ext(info, &mut mem_reqs) };
    mem_reqs.memory_requirements
}

/// `PreprocessBufferExt`
pub struct PreprocessBufferExt<'a> {
    offset: vk::DeviceSize,
    buffer: Option<BufferWithMemory<'a>>,
    size: vk::DeviceSize,
    device_address: vk::DeviceAddress,
}

impl<'a> PreprocessBufferExt<'a> {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        context: &'a Context<'a>,
        indirect_execution_set: vk::IndirectExecutionSetEXT,
        indirect_commands_layout: vk::IndirectCommandsLayoutEXT,
        max_sequence_count: u32,
        max_draw_count: u32,
        pipeline: vk::Pipeline,
        offset: vk::DeviceSize,
    ) -> Result<Self, TestError> {
        Self::new_with_shaders(
            context,
            indirect_execution_set,
            indirect_commands_layout,
            max_sequence_count,
            max_draw_count,
            pipeline,
            &[],
            offset,
        )
    }

    /// The same with the shader objects of a draw without an execution set (`shadersVecPtr` of the C++ constructor).
    #[allow(clippy::too_many_arguments)]
    pub fn new_with_shaders(
        context: &'a Context<'a>,
        indirect_execution_set: vk::IndirectExecutionSetEXT,
        indirect_commands_layout: vk::IndirectCommandsLayoutEXT,
        max_sequence_count: u32,
        max_draw_count: u32,
        pipeline: vk::Pipeline,
        shaders: &[vk::ShaderEXT],
        offset: vk::DeviceSize,
    ) -> Result<Self, TestError> {
        Self::new_with_shaders_on(
            context.get_device(),
            context,
            indirect_execution_set,
            indirect_commands_layout,
            max_sequence_count,
            max_draw_count,
            pipeline,
            shaders,
            offset,
        )
    }

    /// `new_with_shaders` on a device other than the Context's, such as a `RobustnessDevice`'s.
    #[allow(clippy::too_many_arguments)]
    pub fn new_with_shaders_on(
        device: &'a Device,
        context: &Context<'_>,
        indirect_execution_set: vk::IndirectExecutionSetEXT,
        indirect_commands_layout: vk::IndirectCommandsLayoutEXT,
        max_sequence_count: u32,
        max_draw_count: u32,
        pipeline: vk::Pipeline,
        shaders: &[vk::ShaderEXT],
        offset: vk::DeviceSize,
    ) -> Result<Self, TestError> {
        let gen_cmd_mem_reqs_info = if shaders.is_empty() {
            DgcMemReqsInfo::new(
                indirect_execution_set,
                indirect_commands_layout,
                max_sequence_count,
                max_draw_count,
                pipeline,
            )
        } else {
            DgcMemReqsInfo::new_with_shaders(
                indirect_execution_set,
                indirect_commands_layout,
                max_sequence_count,
                max_draw_count,
                shaders,
            )
        };
        let orig_mem_reqs = get_generated_commands_memory_requirements_ext(device, gen_cmd_mem_reqs_info.get());

        // Save the original required size. This is used by getSize() and others.
        let size = orig_mem_reqs.size;

        // Align the requested offset to a multiple of the required alignment.
        let mut offset = offset;
        if offset > 0 {
            offset = offset.div_ceil(orig_mem_reqs.alignment) * orig_mem_reqs.alignment;
        }

        let mut result = Self {
            offset,
            buffer: None,
            size,
            device_address: 0,
        };
        if result.needed() {
            // Calculate total buffer size based on the requested size and offset.
            let preprocess_size = size + offset;
            let usage_flags2 = vk::BufferUsageFlags2CreateInfo {
                usage: vk::BufferUsageFlags2::SHADER_DEVICE_ADDRESS | vk::BufferUsageFlags2::PREPROCESS_BUFFER_EXT,
                ..Default::default()
            };
            let mut create_info = make_buffer_create_info(preprocess_size, vk::BufferUsageFlags::empty());
            create_info.next = (&usage_flags2 as *const vk::BufferUsageFlags2CreateInfo).cast();
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                create_info,
                MemoryRequirement::DEVICE_ADDRESS,
            )?;

            let device_address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
            // Take the offset into account when calculating the base device address.
            result.device_address = unsafe { device.get_buffer_device_address(&device_address_info) } + offset;
            result.buffer = Some(buffer);
        }
        Ok(result)
    }

    pub fn get(&self) -> vk::Buffer {
        self.buffer.as_ref().map_or(vk::Buffer::null(), BufferWithMemory::get)
    }

    pub fn get_device_address(&self) -> vk::DeviceAddress {
        self.device_address
    }

    pub fn get_size(&self) -> vk::DeviceSize {
        self.size
    }

    pub fn get_offset(&self) -> vk::DeviceSize {
        self.offset
    }

    pub fn needed(&self) -> bool {
        self.size > 0
    }
}

/// `ExecutionSetManager` for pipelines (`makeExecutionSetManagerPipeline`)
pub struct ExecutionSetManagerExt<'a> {
    device: &'a Device,
    execution_set: vk::IndirectExecutionSetEXT,
    pipeline_writes: Vec<vk::WriteIndirectExecutionSetPipelineEXT>,
    shader_writes: Vec<vk::WriteIndirectExecutionSetShaderEXT>,
}

impl<'a> ExecutionSetManagerExt<'a> {
    pub fn new_pipeline(
        device: &'a Device,
        initial_pipeline: vk::Pipeline,
        max_pipeline_count: u32,
    ) -> Result<Self, TestError> {
        let pipeline_info = vk::IndirectExecutionSetPipelineInfoEXT {
            initial_pipeline,
            max_pipeline_count,
            ..Default::default()
        };
        let mut info = vk::IndirectExecutionSetInfoEXT::default();
        info.pipeline_info = &pipeline_info;
        let create_info = vk::IndirectExecutionSetCreateInfoEXT {
            type_: vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
            info,
            ..Default::default()
        };
        let execution_set = unsafe { device.create_indirect_execution_set_ext(&create_info, None) }
            .vk_check("vkCreateIndirectExecutionSetEXT")?;
        Ok(Self {
            device,
            execution_set,
            pipeline_writes: Vec::new(),
            shader_writes: Vec::new(),
        })
    }

    /// `makeExecutionSetManagerShader`: the set layouts of every initial shader, one list per shader.
    pub fn new_shader(
        device: &'a Device,
        stage_infos: &[(vk::ShaderEXT, Vec<vk::DescriptorSetLayout>)],
        pc_ranges: &[vk::PushConstantRange],
        max_shader_count: u32,
    ) -> Result<Self, TestError> {
        let shaders: Vec<vk::ShaderEXT> = stage_infos.iter().map(|(shader, _)| *shader).collect();
        let layout_infos: Vec<vk::IndirectExecutionSetShaderLayoutInfoEXT> = stage_infos
            .iter()
            .map(|(_, layouts)| vk::IndirectExecutionSetShaderLayoutInfoEXT {
                set_layout_count: layouts.len() as u32,
                set_layouts: layouts.as_ptr(),
                ..Default::default()
            })
            .collect();
        let shader_info = vk::IndirectExecutionSetShaderInfoEXT {
            shader_count: shaders.len() as u32,
            initial_shaders: shaders.as_ptr(),
            set_layout_infos: layout_infos.as_ptr(),
            max_shader_count,
            push_constant_range_count: pc_ranges.len() as u32,
            push_constant_ranges: pc_ranges.as_ptr(),
            ..Default::default()
        };
        let mut info = vk::IndirectExecutionSetInfoEXT::default();
        info.shader_info = &shader_info;
        let create_info = vk::IndirectExecutionSetCreateInfoEXT {
            type_: vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS,
            info,
            ..Default::default()
        };
        let execution_set = unsafe { device.create_indirect_execution_set_ext(&create_info, None) }
            .vk_check("vkCreateIndirectExecutionSetEXT")?;
        Ok(Self {
            device,
            execution_set,
            pipeline_writes: Vec::new(),
            shader_writes: Vec::new(),
        })
    }

    /// `VkIndirectExecutionSetShaderInfoEXT` with a null `pSetLayoutInfos` (null_set_layouts_info): the implementation has to take the layouts from the shaders.
    pub fn new_shader_null_layouts(
        device: &'a Device,
        initial_shaders: &[vk::ShaderEXT],
        pc_ranges: &[vk::PushConstantRange],
        max_shader_count: u32,
    ) -> Result<Self, TestError> {
        let shader_info = vk::IndirectExecutionSetShaderInfoEXT {
            shader_count: initial_shaders.len() as u32,
            initial_shaders: initial_shaders.as_ptr(),
            set_layout_infos: std::ptr::null(),
            max_shader_count,
            push_constant_range_count: pc_ranges.len() as u32,
            push_constant_ranges: pc_ranges.as_ptr(),
            ..Default::default()
        };
        let mut info = vk::IndirectExecutionSetInfoEXT::default();
        info.shader_info = &shader_info;
        let create_info = vk::IndirectExecutionSetCreateInfoEXT {
            type_: vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS,
            info,
            ..Default::default()
        };
        let execution_set = unsafe { device.create_indirect_execution_set_ext(&create_info, None) }
            .vk_check("vkCreateIndirectExecutionSetEXT")?;
        Ok(Self {
            device,
            execution_set,
            pipeline_writes: Vec::new(),
            shader_writes: Vec::new(),
        })
    }

    pub fn add_shader(&mut self, index: u32, shader: vk::ShaderEXT) {
        // Avoid duplicating indices, which is illegal as per some VUs.
        if let Some(write) = self.shader_writes.iter().find(|write| write.index == index) {
            debug_assert!(write.shader == shader);
            return;
        }
        self.shader_writes.push(vk::WriteIndirectExecutionSetShaderEXT {
            index,
            shader,
            ..Default::default()
        });
    }

    pub fn add_pipeline(&mut self, index: u32, pipeline: vk::Pipeline) {
        // Avoid duplicating indices, which is illegal as per some VUs.
        if let Some(write) = self.pipeline_writes.iter().find(|write| write.index == index) {
            debug_assert!(write.pipeline == pipeline);
            return;
        }
        self.pipeline_writes.push(vk::WriteIndirectExecutionSetPipelineEXT {
            index,
            pipeline,
            ..Default::default()
        });
    }

    pub fn update(&mut self) {
        if !self.shader_writes.is_empty() {
            unsafe {
                self.device
                    .update_indirect_execution_set_shader_ext(self.execution_set, &self.shader_writes)
            };
            self.shader_writes.clear();
        }
        if !self.pipeline_writes.is_empty() {
            unsafe {
                self.device
                    .update_indirect_execution_set_pipeline_ext(self.execution_set, &self.pipeline_writes)
            };
            self.pipeline_writes.clear();
        }
    }

    pub fn get(&self) -> vk::IndirectExecutionSetEXT {
        self.execution_set
    }
}

impl Drop for ExecutionSetManagerExt<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_indirect_execution_set_ext(self.execution_set, None) };
    }
}

/// `DGCBuffer`: a buffer that can hold indirect commands (host-visible unless asked otherwise)
pub struct DgcBuffer<'a> {
    size: vk::DeviceSize,
    buffer: BufferWithMemory<'a>,
    address: vk::DeviceAddress,
}

impl<'a> DgcBuffer<'a> {
    pub fn new(
        context: &'a Context<'a>,
        size: vk::DeviceSize,
        extra_usage_flags: vk::BufferUsageFlags,
        extra_mem_reqs: MemoryRequirement,
    ) -> Result<Self, TestError> {
        Self::new_on(context.get_device(), context, size, extra_usage_flags, extra_mem_reqs)
    }

    /// `new` on a device other than the Context's, such as a `RobustnessDevice`'s.
    pub fn new_on(
        device: &'a Device,
        context: &Context<'_>,
        size: vk::DeviceSize,
        extra_usage_flags: vk::BufferUsageFlags,
        extra_mem_reqs: MemoryRequirement,
    ) -> Result<Self, TestError> {
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                size,
                extra_usage_flags | vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            ),
            MemoryRequirement::DEVICE_ADDRESS | extra_mem_reqs,
        )?;
        let device_address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
        let address = unsafe { device.get_buffer_device_address(&device_address_info) };
        Ok(Self { size, buffer, address })
    }

    pub fn get(&self) -> vk::Buffer {
        self.buffer.get()
    }

    pub fn get_allocation(&self) -> &crate::vk::mem_util::Allocation<'a> {
        self.buffer.get_allocation()
    }

    pub fn get_device_address(&self) -> vk::DeviceAddress {
        self.address
    }

    pub fn get_size(&self) -> vk::DeviceSize {
        self.size
    }
}

/// A buffer for the preprocessing of `size` bytes (`PreprocessBufferExt` for sizes the caller computed), with its device address.
pub fn make_preprocess_buffer<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
) -> Result<(BufferWithMemory<'a>, vk::DeviceAddress), TestError> {
    let device = context.get_device();
    let usage_flags2 = vk::BufferUsageFlags2CreateInfo {
        usage: vk::BufferUsageFlags2::SHADER_DEVICE_ADDRESS | vk::BufferUsageFlags2::PREPROCESS_BUFFER_EXT,
        ..Default::default()
    };
    let mut create_info = make_buffer_create_info(size, vk::BufferUsageFlags::empty());
    create_info.next = (&usage_flags2 as *const vk::BufferUsageFlags2CreateInfo).cast();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        create_info,
        MemoryRequirement::DEVICE_ADDRESS,
    )?;
    let device_address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
    let address = unsafe { device.get_buffer_device_address(&device_address_info) };
    Ok((buffer, address))
}

/// `IndexBufferViewD3D12`: the index buffer token data of `VK_INDIRECT_COMMANDS_INPUT_MODE_DXGI_INDEX_BUFFER_EXT`
#[repr(C)]
#[derive(Clone, Copy)]
pub struct IndexBufferViewD3D12 {
    pub buffer_address: u64,
    pub size: u32,
    pub index_type: i32,
}

impl IndexBufferViewD3D12 {
    pub fn new(address: vk::DeviceAddress, size: u32, index_type: vk::IndexType) -> Self {
        // DXGI_FORMAT_R32_UINT = 42, DXGI_FORMAT_R16_UINT = 57
        let dx_format = match index_type {
            vk::IndexType::UINT32 => 42,
            vk::IndexType::UINT16 => 57,
            _ => 0,
        };
        Self {
            buffer_address: address,
            size,
            index_type: dx_format,
        }
    }
}

/// `submitAndWaitWithPreprocess`: the optional preprocess command buffer is submitted first and signals a semaphore the execution
/// command buffer waits on at DRAW_INDIRECT.
pub fn submit_and_wait_with_preprocess(
    device: &Device,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
    preprocess_cmd_buffer: vk::CommandBuffer,
) -> Result<(), TestError> {
    let has_preprocess = preprocess_cmd_buffer != vk::CommandBuffer::null();

    let semaphore = if has_preprocess {
        Some(
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        )
    } else {
        None
    };
    let fence = match unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence") {
        Ok(fence) => fence,
        Err(error) => {
            if let Some(semaphore) = semaphore {
                unsafe { device.destroy_semaphore(semaphore, None) };
            }
            return Err(error);
        }
    };

    let result = (|| -> Result<(), TestError> {
        let signal_wait_semaphores: Vec<vk::Semaphore> = semaphore.into_iter().collect();
        let wait_stages: Vec<vk::PipelineStageFlags> = signal_wait_semaphores
            .iter()
            .map(|_| vk::PipelineStageFlags::DRAW_INDIRECT)
            .collect();
        let preprocess_cmd_buffers = [preprocess_cmd_buffer];
        let cmd_buffers = [cmd_buffer];

        let mut submit_infos = Vec::with_capacity(2);
        if has_preprocess {
            submit_infos.push(
                vk::SubmitInfo::builder()
                    .command_buffers(&preprocess_cmd_buffers)
                    .signal_semaphores(&signal_wait_semaphores),
            );
        }
        submit_infos.push(
            vk::SubmitInfo::builder()
                .wait_semaphores(&signal_wait_semaphores)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(&cmd_buffers),
        );

        unsafe { device.queue_submit(queue, &submit_infos, fence) }.vk_check("vkQueueSubmit")?;
        unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        Ok(())
    })();

    unsafe { device.destroy_fence(fence, None) };
    if let Some(semaphore) = semaphore {
        unsafe { device.destroy_semaphore(semaphore, None) };
    }
    result
}

/// `DGCShaderExt`: a SPIR-V shader object with the mandatory INDIRECT_BINDABLE flag, `main` as entry point and the next stages that
/// follow from the device features.
pub fn create_dgc_shader<'a>(
    device: &'a Device,
    stage: vk::ShaderStageFlags,
    binary: &crate::vk::programs::ProgramBinary,
    set_layouts: &[vk::DescriptorSetLayout],
    push_constant_ranges: &[vk::PushConstantRange],
    tessellation_feature: bool,
    geometry_feature: bool,
) -> Result<crate::vkt::tests::shader_object::util::ShaderObject<'a>, TestError> {
    use crate::vkt::tests::shader_object::util::{create_shader, get_shader_object_next_stages, shader_create_info};

    let create_info = shader_create_info(
        vk::ShaderCreateFlagsEXT::INDIRECT_BINDABLE,
        stage,
        get_shader_object_next_stages(stage, tessellation_feature, geometry_feature),
        vk::ShaderCodeTypeEXT::SPIRV,
        std::mem::size_of_val(binary.spirv),
        binary.spirv.as_ptr().cast(),
        set_layouts,
        push_constant_ranges,
    );
    create_shader(device, &create_info)
}
