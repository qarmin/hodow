// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderSyncTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders each case reads or writes the resource from are pre-expanded in the manifest
// by tmp/gen_mesh_sync.py (which replays upstream's case loops) and found by the case's test value, which is unique per case.
//
// Writes a value to a buffer or image from one stage and reads it from another (host, transfer, task, mesh and fragment shaders) with
// each kind of barrier, then checks the value arrived. Also checks a compute to task barrier across secondary command buffers.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_sync::{
    SYNC_BARRIER_ACROSS_SECONDARY, SYNC_V1628510124, SYNC_V1628510125, SYNC_V1628510126, SYNC_V1628510127,
    SYNC_V1628510128, SYNC_V1628510129, SYNC_V1628510130, SYNC_V1628510131, SYNC_V1628510132, SYNC_V1628510133,
    SYNC_V1628510134, SYNC_V1628510135, SYNC_V1628510136, SYNC_V1628510137, SYNC_V1628510138, SYNC_V1628510139,
    SYNC_V1628510140, SYNC_V1628510141, SYNC_V1628510142, SYNC_V1628510143, SYNC_V1628510144, SYNC_V1628510145,
    SYNC_V1628510146, SYNC_V1628510147, SYNC_V1628510148, SYNC_V1628510149, SYNC_V1628510150, SYNC_V1628510151,
    SYNC_V1628510152, SYNC_V1628510153, SYNC_V1628510154, SYNC_V1628510155, SYNC_V1628510156, SYNC_V1628510157,
    SYNC_V1628510158, SYNC_V1628510159, SYNC_V1628510160, SYNC_V1628510161, SYNC_V1628510162, SYNC_V1628510163,
    SYNC_V1628510164, SYNC_V1628510165, SYNC_V1628510166, SYNC_V1628510167, SYNC_V1628510168, SYNC_V1628510169,
    SYNC_V1628510170, SYNC_V1628510171, SYNC_V1628510172, SYNC_V1628510173, SYNC_V1628510174, SYNC_V1628510175,
    SYNC_V1628510176, SYNC_V1628510177, SYNC_V1628510178, SYNC_V1628510179, SYNC_V1628510180, SYNC_V1628510181,
    SYNC_V1628510182, SYNC_V1628510183, SYNC_V1628510184, SYNC_V1628510185, SYNC_V1628510186, SYNC_V1628510187,
    SYNC_V1628510188, SYNC_V1628510189, SYNC_V1628510190, SYNC_V1628510191, SYNC_V1628510192, SYNC_V1628510193,
    SYNC_V1628510194, SYNC_V1628510195, SYNC_V1628510196, SYNC_V1628510197, SYNC_V1628510198, SYNC_V1628510199,
    SYNC_V1628510200, SYNC_V1628510201, SYNC_V1628510202, SYNC_V1628510203,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_secondary_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::mesh_shader::util::check_task_mesh_shader_support_ext;
use crate::vkt::tests::pipeline::pipeline_util::make_color_depth_render_pass;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Stages that will be used in these tests. Shader stages sorted in pipeline order.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Host = 0,
    Transfer,
    Task,
    Mesh,
    Frag,
}

impl Stage {
    fn name(self) -> &'static str {
        match self {
            Stage::Host => "host",
            Stage::Transfer => "transfer",
            Stage::Task => "task",
            Stage::Mesh => "mesh",
            Stage::Frag => "frag",
        }
    }
}

fn is_shader_stage(stage: Stage) -> bool {
    matches!(stage, Stage::Task | Stage::Mesh | Stage::Frag)
}

fn stage_to_flags(stage: Stage) -> vk::PipelineStageFlags {
    match stage {
        Stage::Host => vk::PipelineStageFlags::HOST,
        Stage::Transfer => vk::PipelineStageFlags::TRANSFER,
        Stage::Task => vk::PipelineStageFlags::TASK_SHADER_EXT,
        Stage::Mesh => vk::PipelineStageFlags::MESH_SHADER_EXT,
        Stage::Frag => vk::PipelineStageFlags::FRAGMENT_SHADER,
    }
}

const IMAGE_FORMAT: vk::Format = vk::Format::R32_UINT;
const IMAGE_EXTENT: vk::Extent3D = vk::Extent3D {
    width: 1,
    height: 1,
    depth: 1,
};

/// Types of resources we will use.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ResourceType {
    UniformBuffer,
    StorageBuffer,
    StorageImage,
    SampledImage,
}

fn resource_type_to_descriptor(res_type: ResourceType) -> vk::DescriptorType {
    match res_type {
        ResourceType::UniformBuffer => vk::DescriptorType::UNIFORM_BUFFER,
        ResourceType::StorageBuffer => vk::DescriptorType::STORAGE_BUFFER,
        ResourceType::StorageImage => vk::DescriptorType::STORAGE_IMAGE,
        ResourceType::SampledImage => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
    }
}

/// Will the test use a specific barrier or a general memory barrier?
#[derive(Clone, Copy, PartialEq, Eq)]
enum BarrierType {
    General,
    Specific,
    Dependency,
}

/// Types of writes we will use.
#[derive(Clone, Copy, PartialEq, Eq)]
enum WriteAccess {
    HostWrite,
    TransferWrite,
    ShaderWrite,
}

fn write_access_to_flags(access: WriteAccess) -> vk::AccessFlags {
    match access {
        WriteAccess::HostWrite => vk::AccessFlags::HOST_WRITE,
        WriteAccess::TransferWrite => vk::AccessFlags::TRANSFER_WRITE,
        WriteAccess::ShaderWrite => vk::AccessFlags::SHADER_WRITE,
    }
}

/// Types of reads we will use.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ReadAccess {
    HostRead,
    TransferRead,
    ShaderRead,
    UniformRead,
}

fn read_access_to_flags(access: ReadAccess) -> vk::AccessFlags {
    match access {
        ReadAccess::HostRead => vk::AccessFlags::HOST_READ,
        ReadAccess::TransferRead => vk::AccessFlags::TRANSFER_READ,
        ReadAccess::ShaderRead => vk::AccessFlags::SHADER_READ,
        ReadAccess::UniformRead => vk::AccessFlags::UNIFORM_READ,
    }
}

// Auxiliary functions to verify certain combinations are possible.

/// Check if the writing stage can use the specified write access.
fn can_write_from_stage_as_access(write_stage: Stage, access: WriteAccess) -> bool {
    match write_stage {
        Stage::Host => access == WriteAccess::HostWrite,
        Stage::Transfer => access == WriteAccess::TransferWrite,
        Stage::Task | Stage::Mesh | Stage::Frag => access == WriteAccess::ShaderWrite,
    }
}

/// Check if the reading stage can use the specified read access.
fn can_read_from_stage_as_access(read_stage: Stage, access: ReadAccess) -> bool {
    match read_stage {
        Stage::Host => access == ReadAccess::HostRead,
        Stage::Transfer => access == ReadAccess::TransferRead,
        Stage::Task | Stage::Mesh | Stage::Frag => {
            access == ReadAccess::ShaderRead || access == ReadAccess::UniformRead
        }
    }
}

/// Check if reading the given resource type is possible with the given type of read access.
fn can_read_resource_as_access(res_type: ResourceType, access: ReadAccess) -> bool {
    if access == ReadAccess::UniformRead {
        return res_type == ResourceType::UniformBuffer;
    }
    true
}

/// Check if writing to the given resource type is possible with the given type of write access.
fn can_write_resource_as_access(res_type: ResourceType, access: WriteAccess) -> bool {
    if res_type == ResourceType::UniformBuffer {
        return access != WriteAccess::ShaderWrite;
    }
    true
}

/// Check if the given stage can write to the given resource type.
fn can_write_to(stage: Stage, res_type: ResourceType) -> bool {
    match stage {
        Stage::Host => res_type == ResourceType::UniformBuffer || res_type == ResourceType::StorageBuffer,
        Stage::Transfer => true,
        Stage::Task | Stage::Mesh | Stage::Frag => {
            res_type == ResourceType::StorageBuffer || res_type == ResourceType::StorageImage
        }
    }
}

/// Check if the given stage can read from the given resource type.
fn can_read_from(stage: Stage, res_type: ResourceType) -> bool {
    match stage {
        Stage::Host => res_type == ResourceType::UniformBuffer || res_type == ResourceType::StorageBuffer,
        Stage::Transfer | Stage::Task | Stage::Mesh | Stage::Frag => true,
    }
}

/// Will we need an auxiliar buffer for any case?
fn needs_auxiliar_buffer(from_stage: Stage, to_stage: Stage) -> bool {
    from_stage == Stage::Transfer || to_stage == Stage::Transfer
}

/// Will the final value be stored in the auxiliar destination buffer?
fn value_in_auxiliar_dest_buffer(to_stage: Stage) -> bool {
    to_stage == Stage::Transfer
}

/// Will the final value be stored in the resource buffer itself?
fn value_in_resource_buffer(to_stage: Stage) -> bool {
    to_stage == Stage::Host
}

/// Will the final value be stored in the color buffer?
fn value_in_color_buffer(to_stage: Stage) -> bool {
    !value_in_auxiliar_dest_buffer(to_stage) && !value_in_resource_buffer(to_stage)
}

/// Image usage flags for the image resource.
fn resource_image_usage_flags(resource_type: ResourceType) -> vk::ImageUsageFlags {
    let mut flags = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    match resource_type {
        ResourceType::StorageImage => flags |= vk::ImageUsageFlags::STORAGE,
        ResourceType::SampledImage => flags |= vk::ImageUsageFlags::SAMPLED,
        _ => debug_assert!(false),
    }
    flags
}

/// Buffer usage flags for the buffer resource.
fn resource_buffer_usage_flags(resource_type: ResourceType) -> vk::BufferUsageFlags {
    let mut flags = vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
    match resource_type {
        ResourceType::UniformBuffer => flags |= vk::BufferUsageFlags::UNIFORM_BUFFER,
        ResourceType::StorageBuffer => flags |= vk::BufferUsageFlags::STORAGE_BUFFER,
        _ => debug_assert!(false),
    }
    flags
}

/// Returns true if both the write and read stages are shader stages.
fn from_shader_to_shader(from_stage: Stage, to_stage: Stage) -> bool {
    is_shader_stage(from_stage) && is_shader_stage(to_stage)
}

/// Supposing we'll use two subpasses, decide the stages of a subpass based on the mandatory stages and the one we're interested in.
fn subpass_stages(wanted_stage: Stage, last_subpass: bool) -> Vec<Stage> {
    let mut stages = vec![wanted_stage];
    if !stages.contains(&Stage::Mesh) {
        stages.push(Stage::Mesh); // This one is mandatory.
    }
    if last_subpass && !stages.contains(&Stage::Frag) {
        stages.push(Stage::Frag); // In the last subpass we always need a fragment shader (passthrough).
    }
    stages
}

#[derive(Clone, Copy)]
struct TestParams {
    from_stage: Stage,
    to_stage: Stage,
    resource_type: ResourceType,
    barrier_type: BarrierType,
    write_access: WriteAccess,
    read_access: ReadAccess,
    test_value: u32,
}

impl TestParams {
    fn reads_or_writes_in(&self, stage: Stage) -> bool {
        debug_assert!(self.from_stage != self.to_stage);
        self.from_stage == stage || self.to_stage == stage
    }

    fn needs_task(&self) -> bool {
        self.reads_or_writes_in(Stage::Task)
    }

    fn get_resource_shader_stages(&self) -> vk::ShaderStageFlags {
        let mut flags = vk::ShaderStageFlags::empty();

        if self.from_stage == Stage::Task || self.to_stage == Stage::Task {
            flags |= vk::ShaderStageFlags::TASK_EXT;
        }
        if self.from_stage == Stage::Mesh || self.to_stage == Stage::Mesh {
            flags |= vk::ShaderStageFlags::MESH_EXT;
        }
        if self.from_stage == Stage::Frag || self.to_stage == Stage::Frag {
            flags |= vk::ShaderStageFlags::FRAGMENT;
        }

        // We assume at least something must be done either on the task or mesh shaders for the tests to be interesting.
        debug_assert!(flags.intersects(vk::ShaderStageFlags::TASK_EXT | vk::ShaderStageFlags::MESH_EXT));
        flags
    }

    /// We'll prefer to keep the image in the general layout if it will be written to from a shader stage or if the barrier is going to be a generic memory barrier.
    fn prefer_general_layout(&self) -> bool {
        is_shader_stage(self.from_stage)
            || self.barrier_type == BarrierType::General
            || self.resource_type == ResourceType::StorageImage
    }

    /// We need two pipelines if both the writing and reading stage are shaders, and either:
    /// - The writing stage comes after the reading stage in the pipeline.
    /// - The barrier to use is not a dependency.
    fn needs_two_pipelines(&self) -> bool {
        from_shader_to_shader(self.from_stage, self.to_stage)
            && (self.from_stage as i32 >= self.to_stage as i32 || self.barrier_type != BarrierType::Dependency)
    }

    /// We need to use generic barriers when using subpass self-dependencies (single subpass and pipeline).
    fn subpass_self_dependency(&self) -> bool {
        from_shader_to_shader(self.from_stage, self.to_stage)
            && self.barrier_type == BarrierType::Dependency
            && !self.needs_two_pipelines()
    }
}

struct MeshShaderSyncCase {
    name: String,
    params: TestParams,
}

impl TestCase for MeshShaderSyncCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MeshShaderSyncCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, self.params.needs_task(), true)?;

        if self.params.write_access == WriteAccess::ShaderWrite
            && self.params.from_stage == Stage::Frag
            && context.get_device_features().fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: fragmentStoresAndAtomics".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.test_value {
            1628510124u32 => SYNC_V1628510124.programs,
            1628510125u32 => SYNC_V1628510125.programs,
            1628510126u32 => SYNC_V1628510126.programs,
            1628510127u32 => SYNC_V1628510127.programs,
            1628510128u32 => SYNC_V1628510128.programs,
            1628510129u32 => SYNC_V1628510129.programs,
            1628510130u32 => SYNC_V1628510130.programs,
            1628510131u32 => SYNC_V1628510131.programs,
            1628510132u32 => SYNC_V1628510132.programs,
            1628510133u32 => SYNC_V1628510133.programs,
            1628510134u32 => SYNC_V1628510134.programs,
            1628510135u32 => SYNC_V1628510135.programs,
            1628510136u32 => SYNC_V1628510136.programs,
            1628510137u32 => SYNC_V1628510137.programs,
            1628510138u32 => SYNC_V1628510138.programs,
            1628510139u32 => SYNC_V1628510139.programs,
            1628510140u32 => SYNC_V1628510140.programs,
            1628510141u32 => SYNC_V1628510141.programs,
            1628510142u32 => SYNC_V1628510142.programs,
            1628510143u32 => SYNC_V1628510143.programs,
            1628510144u32 => SYNC_V1628510144.programs,
            1628510145u32 => SYNC_V1628510145.programs,
            1628510146u32 => SYNC_V1628510146.programs,
            1628510147u32 => SYNC_V1628510147.programs,
            1628510148u32 => SYNC_V1628510148.programs,
            1628510149u32 => SYNC_V1628510149.programs,
            1628510150u32 => SYNC_V1628510150.programs,
            1628510151u32 => SYNC_V1628510151.programs,
            1628510152u32 => SYNC_V1628510152.programs,
            1628510153u32 => SYNC_V1628510153.programs,
            1628510154u32 => SYNC_V1628510154.programs,
            1628510155u32 => SYNC_V1628510155.programs,
            1628510156u32 => SYNC_V1628510156.programs,
            1628510157u32 => SYNC_V1628510157.programs,
            1628510158u32 => SYNC_V1628510158.programs,
            1628510159u32 => SYNC_V1628510159.programs,
            1628510160u32 => SYNC_V1628510160.programs,
            1628510161u32 => SYNC_V1628510161.programs,
            1628510162u32 => SYNC_V1628510162.programs,
            1628510163u32 => SYNC_V1628510163.programs,
            1628510164u32 => SYNC_V1628510164.programs,
            1628510165u32 => SYNC_V1628510165.programs,
            1628510166u32 => SYNC_V1628510166.programs,
            1628510167u32 => SYNC_V1628510167.programs,
            1628510168u32 => SYNC_V1628510168.programs,
            1628510169u32 => SYNC_V1628510169.programs,
            1628510170u32 => SYNC_V1628510170.programs,
            1628510171u32 => SYNC_V1628510171.programs,
            1628510172u32 => SYNC_V1628510172.programs,
            1628510173u32 => SYNC_V1628510173.programs,
            1628510174u32 => SYNC_V1628510174.programs,
            1628510175u32 => SYNC_V1628510175.programs,
            1628510176u32 => SYNC_V1628510176.programs,
            1628510177u32 => SYNC_V1628510177.programs,
            1628510178u32 => SYNC_V1628510178.programs,
            1628510179u32 => SYNC_V1628510179.programs,
            1628510180u32 => SYNC_V1628510180.programs,
            1628510181u32 => SYNC_V1628510181.programs,
            1628510182u32 => SYNC_V1628510182.programs,
            1628510183u32 => SYNC_V1628510183.programs,
            1628510184u32 => SYNC_V1628510184.programs,
            1628510185u32 => SYNC_V1628510185.programs,
            1628510186u32 => SYNC_V1628510186.programs,
            1628510187u32 => SYNC_V1628510187.programs,
            1628510188u32 => SYNC_V1628510188.programs,
            1628510189u32 => SYNC_V1628510189.programs,
            1628510190u32 => SYNC_V1628510190.programs,
            1628510191u32 => SYNC_V1628510191.programs,
            1628510192u32 => SYNC_V1628510192.programs,
            1628510193u32 => SYNC_V1628510193.programs,
            1628510194u32 => SYNC_V1628510194.programs,
            1628510195u32 => SYNC_V1628510195.programs,
            1628510196u32 => SYNC_V1628510196.programs,
            1628510197u32 => SYNC_V1628510197.programs,
            1628510198u32 => SYNC_V1628510198.programs,
            1628510199u32 => SYNC_V1628510199.programs,
            1628510200u32 => SYNC_V1628510200.programs,
            1628510201u32 => SYNC_V1628510201.programs,
            1628510202u32 => SYNC_V1628510202.programs,
            1628510203u32 => SYNC_V1628510203.programs,
            _ => unreachable!("every case has a program set"),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshShaderSyncInstance {
            context,
            params: self.params,
        })
    }
}

struct MeshShaderSyncInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `createCustomRenderPasses`: one or two render passes with the right dependencies depending on the test parameters.
fn create_custom_render_passes<'a>(
    device: &'a Device,
    color_format: vk::Format,
    params: &TestParams,
) -> Result<Vec<Unique<'a, vk::RenderPass>>, TestError> {
    let mut render_passes = Vec::new();
    let use_dependencies = params.barrier_type == BarrierType::Dependency;
    let two_pipelines = params.needs_two_pipelines();
    let two_subpasses = two_pipelines && use_dependencies;
    let pipeline_count = if two_pipelines { 2u32 } else { 1 };
    let subpass_count = if two_subpasses { 2usize } else { 1 };
    let render_pass_count = if two_pipelines && !two_subpasses { 2 } else { 1 };

    let mut initial_layout = vk::ImageLayout::UNDEFINED;
    let final_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;

    let color_refs = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];

    // One or two identical subpasses.
    let subpass_descs: Vec<vk::SubpassDescriptionBuilder<'_>> = (0..subpass_count)
        .map(|_| {
            vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_refs)
        })
        .collect();

    let mut dependencies = Vec::new();
    if from_shader_to_shader(params.from_stage, params.to_stage) && use_dependencies {
        dependencies.push(vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: pipeline_count - 1,
            src_stage_mask: stage_to_flags(params.from_stage),
            dst_stage_mask: stage_to_flags(params.to_stage),
            src_access_mask: write_access_to_flags(params.write_access),
            dst_access_mask: read_access_to_flags(params.read_access),
            dependency_flags: vk::DependencyFlags::empty(),
        });
    }

    for render_pass_idx in 0..render_pass_count {
        if render_pass_idx > 0 {
            initial_layout = final_layout;
        }
        let attachments = [vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(initial_layout)
            .final_layout(final_layout)];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpass_descs)
            .dependencies(&dependencies);
        render_passes.push(Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        ));
    }

    Ok(render_passes)
}

/// One of the pipelines of a case: task (optional), mesh and fragment (optional) stages over one colour attachment.
fn build_sync_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    extent: vk::Extent3D,
    render_pass: vk::RenderPass,
    subpass: u32,
    task: Option<vk::ShaderModule>,
    mesh: vk::ShaderModule,
    frag: Option<vk::ShaderModule>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut stages = Vec::new();
    if let Some(task) = task {
        stages.push((vk::ShaderStageFlags::TASK_EXT, task));
    }
    stages.push((vk::ShaderStageFlags::MESH_EXT, mesh));
    if let Some(frag) = frag {
        stages.push((vk::ShaderStageFlags::FRAGMENT, frag));
    }
    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(extent.width, extent.height);
    state.subpass = subpass;
    create_draw_pipeline(device, layout, render_pass, &stages, &state)
}

fn clear_value_uint() -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { uint32: [0; 4] },
    }
}

impl TestInstance for MeshShaderSyncInstance<'_> {
    /// `MeshShaderSyncInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let image_format = IMAGE_FORMAT;
        let image_extent = IMAGE_EXTENT;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let descriptor_type = resource_type_to_descriptor(params.resource_type);
        let resource_stages = params.get_resource_shader_stages();
        let use_general_layout = params.prefer_general_layout();

        let write_access_flags = write_access_to_flags(params.write_access);
        let read_access_flags = read_access_to_flags(params.read_access);
        let from_stage_flags = stage_to_flags(params.from_stage);
        let to_stage_flags = stage_to_flags(params.to_stage);

        // Prepare color buffer.
        let color_buffer_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(image_format)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_buffer = ImageWithMemory::new(device, alloc, color_buffer_create_info, MemoryRequirement::ANY)?;
        let color_buffer_view = make_image_view(
            device,
            color_buffer.get(),
            vk::ImageViewType::_2D,
            image_format,
            color_srr,
        )?;

        // Main resource.
        let image_descriptor_layout = if use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        };
        let mut current_layout = vk::ImageLayout::UNDEFINED;

        let use_image_resource = matches!(
            params.resource_type,
            ResourceType::StorageImage | ResourceType::SampledImage
        );
        let use_buffer_resource = !use_image_resource;

        let image_resource = if use_image_resource {
            let resource_create_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(image_format)
                .extent(image_extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(resource_image_usage_flags(params.resource_type))
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            Some(ImageWithMemory::new(
                device,
                alloc,
                resource_create_info,
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let image_resource_view = match &image_resource {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                image_format,
                color_srr,
            )?),
            None => None,
        };
        let buffer_resource = if use_buffer_resource {
            Some(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(buffer_size, resource_buffer_usage_flags(params.resource_type)),
                MemoryRequirement::HOST_VISIBLE,
            )?)
        } else {
            None
        };

        let sampler = if descriptor_type == vk::DescriptorType::COMBINED_IMAGE_SAMPLER {
            let sampler_create_info = vk::SamplerCreateInfo::builder()
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
                .compare_op(vk::CompareOp::NEVER)
                .min_lod(0.0)
                .max_lod(0.0)
                .border_color(vk::BorderColor::INT_TRANSPARENT_BLACK)
                .unnormalized_coordinates(false);
            Some(Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
            ))
        } else {
            None
        };

        // Auxiliary host-coherent buffer for some cases. Being host-coherent lets us avoid extra barriers that would "pollute" synchronization tests.
        let host_coherent_buffer = if needs_auxiliar_buffer(params.from_stage, params.to_stage) {
            Some(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(
                    buffer_size,
                    vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
            )?)
        } else {
            None
        };

        // Descriptor pool, set layout and set.
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, resource_stages)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        // Update descriptor set.
        match descriptor_type {
            vk::DescriptorType::UNIFORM_BUFFER | vk::DescriptorType::STORAGE_BUFFER => {
                let buffer_info = make_descriptor_buffer_info(
                    buffer_resource.as_ref().expect("buffer resource").get(),
                    0,
                    buffer_size,
                );
                DescriptorSetUpdateBuilder::new()
                    .write_single(
                        descriptor_set.get(),
                        Location::binding(0),
                        descriptor_type,
                        &buffer_info,
                    )
                    .update(device);
            }
            _ => {
                let image_info = [vk::DescriptorImageInfo {
                    sampler: sampler.as_ref().map_or(vk::Sampler::null(), |sampler| sampler.get()),
                    image_view: image_resource_view.as_ref().expect("image resource view").get(),
                    image_layout: image_descriptor_layout,
                }];
                let write = vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(descriptor_type)
                    .image_info(&image_info);
                unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            }
        }

        // Render passes and framebuffers.
        let render_passes = create_custom_render_passes(device, image_format, &params)?;
        let multi_render_pass = render_passes.len() > 1;
        debug_assert!(!render_passes.is_empty());

        let mut framebuffers = Vec::with_capacity(render_passes.len());
        for render_pass in &render_passes {
            framebuffers.push(make_framebuffer(
                device,
                **render_pass,
                &[*color_buffer_view],
                image_extent.width,
                image_extent.height,
                1,
            )?);
        }

        // Pipeline layout.
        let pc_size = 8u32;
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: resource_stages,
            offset: 0,
            size: pc_size,
        }];
        let set_layouts = [set_layout.get()];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Shader modules, pipelines and pipeline layouts.
        let two_pipelines = params.needs_two_pipelines();
        let self_deps = params.subpass_self_dependency();

        // Both at the same time does not make sense.
        debug_assert!(!(two_pipelines && self_deps));

        let pipeline_count = if two_pipelines { 2usize } else { 1 };
        let draw_count = if self_deps { 2usize } else { 1 };
        let iteration_count = pipeline_count.max(draw_count);

        let binaries = context.get_binary_collection();
        let task_shader = if params.needs_task() {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let task_passthrough_shader = create_shader_module(device, binaries.get("taskPassthrough")?)?;
        let frag_passthrough_shader = create_shader_module(device, binaries.get("fragPassthrough")?)?;
        let mesh_passthrough_shader = create_shader_module(device, binaries.get("meshPassthrough")?)?;
        let mesh_passthrough_with_task_shader = create_shader_module(device, binaries.get("meshPassthroughWithTask")?)?;

        let mut pipelines = Vec::with_capacity(pipeline_count);

        if pipeline_count == 1 {
            pipelines.push(build_sync_pipeline(
                device,
                *pipeline_layout,
                image_extent,
                *render_passes[0],
                0,
                task_shader.as_ref().map(|shader| **shader),
                *mesh_shader,
                Some(*frag_shader),
            )?);
        } else {
            // Mandatory stages in each pipeline: the first pipeline will contain the "from" stage (write) and the second one the "to" stage (read).
            let mandatory_stages = [params.from_stage, params.to_stage];

            // One pipeline per mandatory stage.
            for pipeline_idx in 0..pipeline_count {
                let stage = mandatory_stages[pipeline_idx];

                let last_subpass = pipeline_idx == pipeline_count - 1;
                let pipeline_stages = subpass_stages(stage, last_subpass);
                let has_task_shader = pipeline_stages.contains(&Stage::Task);
                let has_frag_shader = pipeline_stages.contains(&Stage::Frag);

                // Decide which shaders to use for this one.
                let task_module = if has_task_shader {
                    Some(if stage == Stage::Task {
                        **task_shader.as_ref().expect("the task shader")
                    } else {
                        *task_passthrough_shader
                    })
                } else {
                    None
                };

                let mesh_module = if stage == Stage::Mesh {
                    *mesh_shader
                } else if has_task_shader {
                    *mesh_passthrough_with_task_shader
                } else {
                    *mesh_passthrough_shader
                };

                let frag_module = if has_frag_shader {
                    Some(if stage == Stage::Frag {
                        *frag_shader
                    } else {
                        *frag_passthrough_shader
                    })
                } else {
                    None
                };

                // When using multiple render passes, the subpass is always zero. When using a single render pass, each pipeline is prepared for one subpass.
                let render_pass = if multi_render_pass {
                    *render_passes[pipeline_idx]
                } else {
                    *render_passes[0]
                };
                let subpass = if multi_render_pass { 0 } else { pipeline_idx as u32 };

                pipelines.push(build_sync_pipeline(
                    device,
                    *pipeline_layout,
                    image_extent,
                    render_pass,
                    subpass,
                    task_module,
                    mesh_module,
                    frag_module,
                )?);
            }
        }

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;

        let memory_barrier_cmd =
            |src: vk::PipelineStageFlags, dst: vk::PipelineStageFlags, barrier: vk::MemoryBarrier| unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    src,
                    dst,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            };
        let buffer_barrier_cmd =
            |src: vk::PipelineStageFlags, dst: vk::PipelineStageFlags, barrier: vk::BufferMemoryBarrier| unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    src,
                    dst,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            };
        let image_barrier_cmd =
            |src: vk::PipelineStageFlags, dst: vk::PipelineStageFlags, barrier: vk::ImageMemoryBarrier| unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    src,
                    dst,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            };

        begin_command_buffer(device, cmd_buffer)?;

        if params.from_stage == Stage::Host {
            // Prepare buffer from host when the source stage is the host.
            debug_assert!(use_buffer_resource);

            let resource_buffer_alloc = buffer_resource.as_ref().expect("buffer resource").get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    params.test_value.to_ne_bytes().as_ptr(),
                    resource_buffer_alloc.get_host_ptr(),
                    4,
                )
            };
            flush_alloc(device, resource_buffer_alloc)?;
        } else if params.from_stage == Stage::Transfer {
            // Put value in host-coherent buffer and transfer it to the resource buffer or image.
            let host_coherent = host_coherent_buffer.as_ref().expect("auxiliar buffer");
            unsafe {
                std::ptr::copy_nonoverlapping(
                    params.test_value.to_ne_bytes().as_ptr(),
                    host_coherent.get_allocation().get_host_ptr(),
                    4,
                )
            };
            memory_barrier_cmd(
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                make_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::TRANSFER_READ),
            );

            if use_buffer_resource {
                let copy_region = vk::BufferCopy {
                    src_offset: 0,
                    dst_offset: 0,
                    size: buffer_size,
                };
                unsafe {
                    device.cmd_copy_buffer(
                        cmd_buffer,
                        host_coherent.get(),
                        buffer_resource.as_ref().expect("buffer resource").get(),
                        &[copy_region],
                    )
                };
            } else {
                // Move image to the right layout for transfer.
                let image = image_resource.as_ref().expect("image resource").get();
                let new_layout = if use_general_layout {
                    vk::ImageLayout::GENERAL
                } else {
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL
                };
                if new_layout != current_layout {
                    let pre_copy_barrier = make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        current_layout,
                        new_layout,
                        image,
                        color_srr,
                    );
                    image_barrier_cmd(
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        vk::PipelineStageFlags::TRANSFER,
                        pre_copy_barrier,
                    );
                    current_layout = new_layout;
                }
                let copy_region = make_buffer_image_copy(image_extent, color_srl);
                unsafe {
                    device.cmd_copy_buffer_to_image(
                        cmd_buffer,
                        host_coherent.get(),
                        image,
                        current_layout,
                        &[copy_region],
                    )
                };
            }
        } else if is_shader_stage(params.from_stage) {
            // The image or buffer will be written to from shaders. Images need to be in the right layout.
            if use_image_resource {
                let new_layout = vk::ImageLayout::GENERAL;
                if new_layout != current_layout {
                    let pre_write_barrier = make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                        current_layout,
                        new_layout,
                        image_resource.as_ref().expect("image resource").get(),
                        color_srr,
                    );
                    image_barrier_cmd(vk::PipelineStageFlags::TOP_OF_PIPE, from_stage_flags, pre_write_barrier);
                    current_layout = new_layout;
                }
            }
        } else {
            debug_assert!(false);
        }

        // If the resource is going to be read from shaders and written from a non-shader stage, we'll insert the main barrier before running the pipeline.
        if is_shader_stage(params.to_stage) && !is_shader_stage(params.from_stage) {
            if params.barrier_type == BarrierType::General {
                memory_barrier_cmd(
                    from_stage_flags,
                    to_stage_flags,
                    make_memory_barrier(write_access_flags, read_access_flags),
                );
            } else if params.barrier_type == BarrierType::Specific {
                if use_buffer_resource {
                    let buffer_barrier = make_buffer_memory_barrier(
                        write_access_flags,
                        read_access_flags,
                        buffer_resource.as_ref().expect("buffer resource").get(),
                        0,
                        buffer_size,
                    );
                    buffer_barrier_cmd(from_stage_flags, to_stage_flags, buffer_barrier);
                } else {
                    let new_layout = if use_general_layout {
                        vk::ImageLayout::GENERAL
                    } else {
                        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
                    };
                    let image_barrier = make_image_memory_barrier(
                        write_access_flags,
                        read_access_flags,
                        current_layout,
                        new_layout,
                        image_resource.as_ref().expect("image resource").get(),
                        color_srr,
                    );
                    image_barrier_cmd(from_stage_flags, to_stage_flags, image_barrier);
                    current_layout = new_layout;
                }
            }
            // For subpass dependencies, they have already been included in the render pass or loop below.
        }

        // Run the pipeline.
        let scissor = make_rect_2d(0, 0, image_extent.width, image_extent.height);
        let clear_values = [clear_value_uint()];
        let begin_render_pass = |render_pass: vk::RenderPass, framebuffer: vk::Framebuffer| {
            let info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass)
                .framebuffer(framebuffer)
                .render_area(scissor)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd_buffer, &info, vk::SubpassContents::INLINE) };
        };

        if !multi_render_pass {
            begin_render_pass(*render_passes[0], *framebuffers[0]);
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        for iteration_idx in 0..iteration_count {
            if iteration_idx > 0 && !multi_render_pass && two_pipelines {
                unsafe { device.cmd_next_subpass(cmd_buffer, vk::SubpassContents::INLINE) };
            }

            if multi_render_pass {
                begin_render_pass(*render_passes[iteration_idx], *framebuffers[iteration_idx]);
            }

            if two_pipelines || iteration_idx == 0 {
                unsafe {
                    device.cmd_bind_pipeline(
                        cmd_buffer,
                        vk::PipelineBindPoint::GRAPHICS,
                        pipelines[iteration_idx].get(),
                    )
                };
            }

            // First draw writes, second draw reads when using self-dependencies. Otherwise reads and writes freely according to the pipeline shaders.
            let (write_val, read_val) = if self_deps {
                (1 - iteration_idx as u32, iteration_idx as u32)
            } else {
                (1u32, 1u32)
            };
            let pc_bytes: Vec<u8> = [write_val, read_val].iter().flat_map(|v| v.to_ne_bytes()).collect();
            unsafe {
                device.cmd_push_constants(cmd_buffer, *pipeline_layout, resource_stages, 0, &pc_bytes);
                device.cmd_draw_mesh_tasks_ext(cmd_buffer, 1, 1, 1);
            }

            if multi_render_pass {
                unsafe { device.cmd_end_render_pass(cmd_buffer) };
            }

            // If there are self-dependencies or multiple render passes, synchronize resource between draw calls.
            if (multi_render_pass || self_deps) && iteration_idx == 0 {
                // In the case of self-dependencies, the barrier type is BarrierType::Dependency and we'll insert a general barrier because:
                //    * VUID-vkCmdPipelineBarrier-bufferMemoryBarrierCount-01178 forbids using buffer barriers inside render passes.
                //    * VUID-vkCmdPipelineBarrier-image-04073 forbids using image memory barriers inside render passes with resources that are not attachments.
                if params.barrier_type == BarrierType::General || params.barrier_type == BarrierType::Dependency {
                    memory_barrier_cmd(
                        from_stage_flags,
                        to_stage_flags,
                        make_memory_barrier(write_access_flags, read_access_flags),
                    );
                } else if params.barrier_type == BarrierType::Specific {
                    if use_buffer_resource {
                        let buffer_barrier = make_buffer_memory_barrier(
                            write_access_flags,
                            read_access_flags,
                            buffer_resource.as_ref().expect("buffer resource").get(),
                            0,
                            buffer_size,
                        );
                        buffer_barrier_cmd(from_stage_flags, to_stage_flags, buffer_barrier);
                    } else {
                        // Note: the image will only be read from shader stages or from the transfer stage.
                        debug_assert!(use_general_layout);
                        let new_layout = vk::ImageLayout::GENERAL;
                        let image_barrier = make_image_memory_barrier(
                            write_access_flags,
                            read_access_flags,
                            current_layout,
                            new_layout,
                            image_resource.as_ref().expect("image resource").get(),
                            color_srr,
                        );
                        image_barrier_cmd(from_stage_flags, to_stage_flags, image_barrier);
                        current_layout = new_layout;
                    }
                }

                if multi_render_pass {
                    // Sync color attachment writes.
                    let color_writes_barrier = make_memory_barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    );
                    memory_barrier_cmd(
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        color_writes_barrier,
                    );
                }
            }
        }

        if !multi_render_pass {
            unsafe { device.cmd_end_render_pass(cmd_buffer) };
        }

        // If the resource was written to from shaders and will be read from a non-shader stage, insert the main barrier after running the pipeline.
        if is_shader_stage(params.from_stage) && !is_shader_stage(params.to_stage) {
            if params.barrier_type == BarrierType::General {
                memory_barrier_cmd(
                    from_stage_flags,
                    to_stage_flags,
                    make_memory_barrier(write_access_flags, read_access_flags),
                );
            } else if params.barrier_type == BarrierType::Specific {
                if use_buffer_resource {
                    let buffer_barrier = make_buffer_memory_barrier(
                        write_access_flags,
                        read_access_flags,
                        buffer_resource.as_ref().expect("buffer resource").get(),
                        0,
                        buffer_size,
                    );
                    buffer_barrier_cmd(from_stage_flags, to_stage_flags, buffer_barrier);
                } else {
                    // Note: the image will only be read from shader stages or from the transfer stage.
                    let new_layout = if use_general_layout {
                        vk::ImageLayout::GENERAL
                    } else {
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
                    };
                    let image_barrier = make_image_memory_barrier(
                        write_access_flags,
                        read_access_flags,
                        current_layout,
                        new_layout,
                        image_resource.as_ref().expect("image resource").get(),
                        color_srr,
                    );
                    image_barrier_cmd(from_stage_flags, to_stage_flags, image_barrier);
                    current_layout = new_layout;
                }
            }
            // For subpass dependencies, they have already been included in the render pass and loop.
        }

        // Read resource from the destination stage if needed. A host destination needs nothing: the value is in the host-visible resource buffer.
        if params.to_stage == Stage::Transfer {
            // Copy value from resource to host-coherent buffer to be verified later.
            let host_coherent = host_coherent_buffer.as_ref().expect("auxiliar buffer");
            if use_buffer_resource {
                let copy_region = vk::BufferCopy {
                    src_offset: 0,
                    dst_offset: 0,
                    size: buffer_size,
                };
                unsafe {
                    device.cmd_copy_buffer(
                        cmd_buffer,
                        buffer_resource.as_ref().expect("buffer resource").get(),
                        host_coherent.get(),
                        &[copy_region],
                    )
                };
            } else {
                let copy_region = make_buffer_image_copy(image_extent, color_srl);
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd_buffer,
                        image_resource.as_ref().expect("image resource").get(),
                        current_layout,
                        host_coherent.get(),
                        &[copy_region],
                    )
                };
            }

            memory_barrier_cmd(
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ),
            );
        }

        // If the output value will be available in the color buffer, take the chance to transfer its contents to a host-coherent buffer.
        let color_verification_buffer = if value_in_color_buffer(params.to_stage) {
            let buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(
                    buffer_size,
                    vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
            )?;

            let color_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                color_srr,
            );
            image_barrier_cmd(
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                color_barrier,
            );

            let copy_region = make_buffer_image_copy(image_extent, color_srl);
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd_buffer,
                    color_buffer.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[copy_region],
                )
            };

            memory_barrier_cmd(
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ),
            );
            Some(buffer)
        } else {
            None
        };

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let read_u32 = |ptr: *const u8| {
            u32::from_ne_bytes(
                unsafe { std::slice::from_raw_parts(ptr, 4) }
                    .try_into()
                    .expect("four bytes"),
            )
        };

        // Verify output resources as needed.
        if value_in_auxiliar_dest_buffer(params.to_stage) {
            let buffer_value = read_u32(
                host_coherent_buffer
                    .as_ref()
                    .expect("auxiliar buffer")
                    .get_allocation()
                    .get_host_ptr(),
            );

            if buffer_value != params.test_value {
                return Err(TestError::Fail(format!(
                    "Unexpected value in auxiliar host-coherent buffer: found {buffer_value} and expected {}",
                    params.test_value
                )));
            }
        }

        if value_in_resource_buffer(params.to_stage) {
            let resource_buffer_alloc = buffer_resource.as_ref().expect("buffer resource").get_allocation();
            invalidate_alloc(device, resource_buffer_alloc)?;
            let buffer_value = read_u32(resource_buffer_alloc.get_host_ptr());

            if buffer_value != params.test_value {
                return Err(TestError::Fail(format!(
                    "Unexpected value in resource buffer: found {buffer_value} and expected {}",
                    params.test_value
                )));
            }
        }

        if value_in_color_buffer(params.to_stage) {
            let buffer_value = read_u32(
                color_verification_buffer
                    .as_ref()
                    .expect("color verification buffer")
                    .get_allocation()
                    .get_host_ptr(),
            );

            if buffer_value != params.test_value {
                return Err(TestError::Fail(format!(
                    "Unexpected value in color verification buffer: found {buffer_value} and expected {}",
                    params.test_value
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// Specific test to check a barrier that crosses secondary command buffers and goes from compute to task.
struct BarrierAcrossSecondaryCase {
    name: String,
}

const BARRIER_LOCAL_SIZE: u32 = 128;
const BARRIER_NUM_WORK_GROUPS: u32 = 16384;

impl TestCase for BarrierAcrossSecondaryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, true, true)
    }

    fn programs(&self) -> BinaryCollection {
        SYNC_BARRIER_ACROSS_SECONDARY.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BarrierAcrossSecondaryInstance { context })
    }
}

struct BarrierAcrossSecondaryInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for BarrierAcrossSecondaryInstance<'_> {
    /// `BarrierAcrossSecondaryInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let binding_stages = vk::ShaderStageFlags::COMPUTE | vk::ShaderStageFlags::TASK_EXT;
        let extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };

        // Output and verification buffers, both zeroed.
        let output_buffer_size = (BARRIER_LOCAL_SIZE * BARRIER_NUM_WORK_GROUPS) as usize * std::mem::size_of::<u32>();
        let zeroes = vec![0u8; output_buffer_size];
        let output_buffer = create_host_buffer(context, &zeroes, vk::BufferUsageFlags::STORAGE_BUFFER)?;
        let verification_buffer = create_host_buffer(context, &zeroes, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Descriptor set layout, pipeline layout, pool and set.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, binding_stages)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, binding_stages)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        // Update descriptor set.
        let output_buffer_desc_info =
            make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size as vk::DeviceSize);
        let verification_buffer_desc_info =
            make_descriptor_buffer_info(verification_buffer.get(), 0, output_buffer_size as vk::DeviceSize);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &output_buffer_desc_info,
            )
            .write_single(
                descriptor_set.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &verification_buffer_desc_info,
            )
            .update(device);

        // Graphics pipeline auxiliary data: a render pass without attachments.
        let render_pass = make_color_depth_render_pass(
            device,
            vk::Format::UNDEFINED,
            vk::Format::UNDEFINED,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[], extent.width, extent.height, 1)?;

        // Create pipelines.
        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;
        let task_module = create_shader_module(device, binaries.get("task")?)?;
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;

        let comp_stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
            .name(b"main\0");
        let compute_info = vk::ComputePipelineCreateInfo::builder()
            .stage(comp_stage)
            .layout(*pipeline_layout);
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(extent.width, extent.height);
        state.color_attachment_count = 0;
        let mesh_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::TASK_EXT, *task_module),
                (vk::ShaderStageFlags::MESH_EXT, *mesh_module),
            ],
            &state,
        )?;

        // Command pool and command buffers.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let primary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let comp_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let mesh_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        // Use compute pipeline and record barrier to task shader.
        {
            let cmd = *comp_cmd_buffer;
            let comp_to_task_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::SHADER_READ);

            let begin_info = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT);
            unsafe {
                device
                    .begin_command_buffer(cmd, &begin_info)
                    .vk_check("vkBeginCommandBuffer")?;
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, compute_pipeline.get());
                device.cmd_dispatch(cmd, BARRIER_NUM_WORK_GROUPS, 1, 1);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TASK_SHADER_EXT,
                    vk::DependencyFlags::empty(),
                    &[comp_to_task_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, cmd)?;
        }

        // Use mesh pipeline.
        {
            let cmd = *mesh_cmd_buffer;

            begin_secondary_command_buffer(device, cmd, *render_pass, 0, *framebuffer)?;
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, mesh_pipeline.get());
                device.cmd_draw_mesh_tasks_ext(cmd, BARRIER_NUM_WORK_GROUPS, 1, 1);
            }
            end_command_buffer(device, cmd)?;
        }

        // Use both secondary command buffers, with a barrier to the host at the end.
        {
            let cmd = *primary_cmd_buffer;
            let task_to_host_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);

            begin_command_buffer(device, cmd)?;
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(make_rect_2d(0, 0, extent.width, extent.height));
            unsafe {
                device.cmd_execute_commands(cmd, &[*comp_cmd_buffer]);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
                device.cmd_execute_commands(cmd, &[*mesh_cmd_buffer]);
                device.cmd_end_render_pass(cmd);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TASK_SHADER_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[task_to_host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Verify buffer contents.
        let verification_alloc = verification_buffer.get_allocation();
        invalidate_alloc(device, verification_alloc)?;
        let result =
            unsafe { std::slice::from_raw_parts(verification_alloc.get_host_ptr().cast_const(), output_buffer_size) };

        if !result
            .chunks_exact(4)
            .all(|value| u32::from_ne_bytes(value.try_into().expect("four bytes")) == 1)
        {
            return Err(TestError::Fail(
                "Unexpected values found in verification buffer".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderSyncTestsEXT`
pub fn create_mesh_shader_sync_tests_ext() -> TestCaseGroup {
    let stage_combinations = [
        // Combinations where the source and destination stages involve mesh shaders.
        (Stage::Host, Stage::Task),
        (Stage::Host, Stage::Mesh),
        (Stage::Transfer, Stage::Task),
        (Stage::Transfer, Stage::Mesh),
        (Stage::Task, Stage::Mesh),
        (Stage::Task, Stage::Frag),
        (Stage::Task, Stage::Transfer),
        (Stage::Task, Stage::Host),
        (Stage::Mesh, Stage::Frag),
        (Stage::Mesh, Stage::Transfer),
        (Stage::Mesh, Stage::Host),
        // These require two pipelines.
        (Stage::Mesh, Stage::Task),
        (Stage::Frag, Stage::Task),
        (Stage::Frag, Stage::Mesh),
    ];

    let resource_types = [
        (ResourceType::UniformBuffer, "uniform_buffer"),
        (ResourceType::StorageBuffer, "storage_buffer"),
        (ResourceType::StorageImage, "storage_image"),
        (ResourceType::SampledImage, "sampled_image"),
    ];

    let barrier_types = [
        (BarrierType::General, "memory_barrier"),
        (BarrierType::Specific, "specific_barrier"),
        (BarrierType::Dependency, "subpass_dependency"),
    ];

    let write_accesses = [
        (WriteAccess::HostWrite, "host_write"),
        (WriteAccess::TransferWrite, "transfer_write"),
        (WriteAccess::ShaderWrite, "shader_write"),
    ];

    let read_accesses = [
        (ReadAccess::HostRead, "host_read"),
        (ReadAccess::TransferRead, "transfer_read"),
        (ReadAccess::ShaderRead, "shader_read"),
        (ReadAccess::UniformRead, "uniform_read"),
    ];

    let mut test_value = 1_628_510_124u32;

    let mut main_group = TestCaseGroup::new("synchronization");

    for (from_stage, to_stage) in stage_combinations {
        let mut combination_group = TestCaseGroup::new(format!("{}_to_{}", from_stage.name(), to_stage.name()));

        for (resource_type, resource_name) in resource_types {
            if !can_write_to(from_stage, resource_type) {
                continue;
            }

            if !can_read_from(to_stage, resource_type) {
                continue;
            }

            let mut resource_group = TestCaseGroup::new(resource_name);

            for (barrier_type, barrier_name) in barrier_types {
                let shader_to_shader = from_shader_to_shader(from_stage, to_stage);
                let barrier_is_dependency = barrier_type == BarrierType::Dependency;

                // Subpass dependencies can only be used in shader to shader situations.
                if barrier_is_dependency && !shader_to_shader {
                    continue;
                }

                let mut barrier_group = TestCaseGroup::new(barrier_name);

                for (write_access, write_name) in write_accesses {
                    for (read_access, read_name) in read_accesses {
                        if !can_read_resource_as_access(resource_type, read_access) {
                            continue;
                        }
                        if !can_write_resource_as_access(resource_type, write_access) {
                            continue;
                        }
                        if !can_read_from_stage_as_access(to_stage, read_access) {
                            continue;
                        }
                        if !can_write_from_stage_as_access(from_stage, write_access) {
                            continue;
                        }

                        let params = TestParams {
                            from_stage,
                            to_stage,
                            resource_type,
                            barrier_type,
                            write_access,
                            read_access,
                            test_value,
                        };
                        test_value += 1;

                        barrier_group.add_child(Box::new(MeshShaderSyncCase {
                            name: format!("{write_name}_{read_name}"),
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }

                resource_group.add_child(barrier_group);
            }

            combination_group.add_child(resource_group);
        }

        main_group.add_child(combination_group);
    }

    {
        // Additional synchronization tests.
        let mut other_group = TestCaseGroup::new("other");

        // Check synchronizing compute to task across secondary command buffer boundaries.
        other_group.add_child(Box::new(BarrierAcrossSecondaryCase {
            name: "barrier_across_secondary".to_string(),
        }) as Box<dyn TestCase>);

        main_group.add_child(other_group);
    }

    main_group
}
