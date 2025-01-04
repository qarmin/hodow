// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderSyncTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders each case reads or writes the resource from are written out in the
// manifest by scripts/gen_mesh_shader_nv_sync.py (which replays upstream's case loops) and found by the case's test value, which is
// unique per case.
//
// The VK_NV_mesh_shader form of sync_tests.rs: writes a value to a buffer or image from one stage and reads it from another (host,
// transfer, task, mesh and fragment shaders) with each kind of barrier, then checks the value arrived. Unlike the EXT tests there is a
// single pipeline: a shader to shader case draws twice and uses a subpass self-dependency with a generic barrier between the draws.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::NvMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_nv_sync::ALL_NV_SYNC_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_memory_barrier,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::mesh_shader::util::check_task_mesh_shader_support_nv;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries: the program set of the case with this test value.
#[derive(Clone, Copy)]
pub struct NvSyncPrograms {
    pub name: &'static str,
    pub test_value: u32,
    pub programs: BinaryCollection,
}

/// Stages that will be used in these tests.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Host,
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
        Stage::Task | Stage::Mesh => res_type == ResourceType::StorageBuffer || res_type == ResourceType::StorageImage,
        Stage::Frag => unreachable!("no test writes from the fragment shader"),
    }
}

/// Check if the given stage can read from the given resource type.
fn can_read_from(stage: Stage, res_type: ResourceType) -> bool {
    match stage {
        Stage::Host => res_type == ResourceType::UniformBuffer || res_type == ResourceType::StorageBuffer,
        Stage::Transfer | Stage::Task | Stage::Mesh | Stage::Frag => true,
    }
}

/// Will we need to store the test value in an auxiliar buffer to be read?
fn needs_auxiliar_source_buffer(from_stage: Stage) -> bool {
    from_stage == Stage::Transfer
}

/// Will we need to store the read operation result into an auxiliar buffer to be checked?
fn needs_auxiliar_dest_buffer(to_stage: Stage) -> bool {
    to_stage == Stage::Transfer
}

/// Needs any auxiliar buffer for any case?
fn needs_auxiliar_buffer(from_stage: Stage, to_stage: Stage) -> bool {
    needs_auxiliar_source_buffer(from_stage) || needs_auxiliar_dest_buffer(to_stage)
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

/// Is the resource written to and read from a shader stage?
fn read_and_write_from_shaders(from_stage: Stage, to_stage: Stage) -> bool {
    is_shader_stage(from_stage) && is_shader_stage(to_stage)
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

    /// A subpass dependency is needed if both the source and destination stages are shader stages.
    fn needs_subpass_dependency(&self) -> bool {
        read_and_write_from_shaders(self.from_stage, self.to_stage)
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
        check_task_mesh_shader_support_nv(context, self.params.needs_task(), true)?;

        if self.params.write_access == WriteAccess::ShaderWrite
            && context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: vertexPipelineStoresAndAtomics".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_NV_SYNC_PROGRAMS
            .iter()
            .find(|p| p.test_value == self.params.test_value)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
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

// General description behind these tests.
//
//    From                To
// ==============================
//    HOST                TASK            Prepare buffer from host. Only valid for uniform and storage buffers. Read value from task into td.value. Verify color buffer.
//    HOST                MESH            Same situation. Read value from mesh into primitiveValue[0]. Verify color buffer.
//    TRANSFER            TASK            Prepare auxiliary host-coherent source buffer from host. Copy buffer to buffer or buffer to image. Read from task into td.value. Verify color buffer.
//    TRANSFER            MESH            Same initial steps. Read from mesh into primitiveValue[0]. Verify color buffer.
//    TASK                MESH            Write value to buffer or image from task shader. Only valid for storage buffers and images. Read from mesh into primitiveValue[0]. Verify color buffer.
//    TASK                FRAG            Same write procedure and restrictions. Read from frag into outColor. Verify color buffer.
//    TASK                TRANSFER        Same write procedure and restrictions. Prepare auxiliary host-coherent read buffer and copy buffer to buffer or image to buffer. Verify auxiliary buffer.
//    TASK                HOST            Due to From/To restrictions, only valid for storage buffers. Same write procedure. Read and verify buffer directly.
//    MESH                FRAG            Same as task to frag but the write instructions need to be in the mesh shader.
//    MESH                TRANSFER        Same as task to transfer but the write instructions need to be in the mesh shader.
//    MESH                HOST            Same as task to host but the write instructions need to be in the mesh shader.

/// `createCustomRenderPass`
fn create_custom_render_pass<'a>(
    device: &'a Device,
    color_format: vk::Format,
    params: &TestParams,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];

    let color_refs = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)];

    // When both stages are shader stages, the dependency will be expressed as a subpass dependency.
    let mut dependencies = Vec::new();
    if params.needs_subpass_dependency() {
        dependencies.push(vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 0,
            src_stage_mask: stage_to_flags(params.from_stage),
            dst_stage_mask: stage_to_flags(params.to_stage),
            src_access_mask: write_access_to_flags(params.write_access),
            dst_access_mask: read_access_to_flags(params.read_access),
            dependency_flags: vk::DependencyFlags::empty(),
        });
    }

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses)
        .dependencies(&dependencies);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
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
        let needs_two_draw_calls = params.needs_subpass_dependency();

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

        // Shader modules.
        let binaries = context.get_binary_collection();
        let task_shader = if params.needs_task() {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        // Pipeline layout, render pass, framebuffer.
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
        let render_pass = create_custom_render_pass(device, image_format, &params)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer_view],
            image_extent.width,
            image_extent.height,
            1,
        )?;

        // Pipeline.
        let mut stages = Vec::new();
        if let Some(task) = &task_shader {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_shader));
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_shader));
        let state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(image_extent.width, image_extent.height);
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

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
        } else if params.from_stage == Stage::Task || params.from_stage == Stage::Mesh {
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

        // If the resource is going to be read from shaders, we'll insert the main barrier before running the pipeline.
        if is_shader_stage(params.to_stage) && !needs_two_draw_calls {
            if params.barrier_type == BarrierType::General {
                memory_barrier_cmd(
                    from_stage_flags,
                    to_stage_flags,
                    make_memory_barrier(write_access_flags, read_access_flags),
                );
            } else if use_buffer_resource {
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

        if needs_two_draw_calls && use_image_resource {
            // Transition image to the general layout before writing to it. When we need two draw calls (because the image will be
            // written to and read from a shader stage), the layout will always be general.
            let new_layout = vk::ImageLayout::GENERAL;
            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                write_access_flags,
                current_layout,
                new_layout,
                image_resource.as_ref().expect("image resource").get(),
                color_srr,
            );
            image_barrier_cmd(vk::PipelineStageFlags::TOP_OF_PIPE, from_stage_flags, image_barrier);
            current_layout = new_layout;
        }

        // Run the pipeline.
        let scissor = make_rect_2d(0, 0, image_extent.width, image_extent.height);
        let clear_values = [clear_value_uint()];
        let render_pass_begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(scissor)
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd_buffer, &render_pass_begin, vk::SubpassContents::INLINE);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        }

        let push_constants = |write_val: u32, read_val: u32| {
            let pc_bytes: Vec<u8> = [write_val, read_val].iter().flat_map(|v| v.to_ne_bytes()).collect();
            unsafe {
                device.cmd_push_constants(cmd_buffer, *pipeline_layout, resource_stages, 0, &pc_bytes);
                device.cmd_draw_mesh_tasks_nv(cmd_buffer, 1, 0);
            }
        };

        if needs_two_draw_calls {
            // The first draw call will write to the resource and the second one will read from the resource.
            push_constants(1, 0);

            // Use a barrier between both draw calls. The barrier must be generic because:
            //    * VUID-vkCmdPipelineBarrier-bufferMemoryBarrierCount-01178 forbids using buffer barriers inside render passes.
            //    * VUID-vkCmdPipelineBarrier-image-04073 forbids using image memory barriers inside render passes with resources that are not attachments.
            debug_assert!(params.barrier_type == BarrierType::General);
            memory_barrier_cmd(
                from_stage_flags,
                to_stage_flags,
                make_memory_barrier(write_access_flags, read_access_flags),
            );

            push_constants(0, 1);
        } else {
            push_constants(1, 1);
        }
        unsafe { device.cmd_end_render_pass(cmd_buffer) };

        // If the resource was written to from the shaders, insert the main barrier after running the pipeline.
        if is_shader_stage(params.from_stage) && !needs_two_draw_calls {
            if params.barrier_type == BarrierType::General {
                memory_barrier_cmd(
                    from_stage_flags,
                    to_stage_flags,
                    make_memory_barrier(write_access_flags, read_access_flags),
                );
            } else if use_buffer_resource {
                let buffer_barrier = make_buffer_memory_barrier(
                    write_access_flags,
                    read_access_flags,
                    buffer_resource.as_ref().expect("buffer resource").get(),
                    0,
                    buffer_size,
                );
                buffer_barrier_cmd(from_stage_flags, to_stage_flags, buffer_barrier);
            } else {
                // Note: the image will only be read from shader stages (which is covered by the subpass dependency) or from the transfer stage.
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
            // For subpass dependencies, they have already been included in the render pass.
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

/// `createMeshShaderSyncTests`
pub fn create_mesh_shader_sync_tests() -> TestCaseGroup {
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
                // See note above about VUID-vkCmdPipelineBarrier-bufferMemoryBarrierCount-01178 and VUID-vkCmdPipelineBarrier-image-04073.
                if read_and_write_from_shaders(from_stage, to_stage) && barrier_type == BarrierType::Specific {
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

                        let access_case_name = format!("{write_name}_{read_name}");

                        let test_params = TestParams {
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
                            name: access_case_name,
                            params: test_params,
                        }) as Box<dyn TestCase>);
                    }
                }

                resource_group.add_child(barrier_group);
            }

            combination_group.add_child(resource_group);
        }

        main_group.add_child(combination_group);
    }

    main_group
}
