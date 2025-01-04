// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderPropertyTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are the fixed text of each case, pre-expanded in the manifest by
// tmp/gen_mesh_property.py; what depends on the device goes in through specialization constants applied to every stage, as upstream does.
//
// Pushes each mesh shading limit (payload, shared memory, output size, components, vertices, primitives, layers, view count) to its
// maximum on the device and checks the results arrive, plus a check of the limits against the specification's minimums.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::mesh_shader_property::{
    PROPERTY_MAX_MESH_OUTPUT_COMPONENTS, PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_256,
    PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_512, PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_1024,
    PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_2048, PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_PRIMITIVE_NO_VIEW_INDEX,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_MESH_AND_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_VERTEX_NO_VIEW_INDEX,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_MESH_AND_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_PRIMITIVE_NO_VIEW_INDEX,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_MESH_AND_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_VERTEX_NO_VIEW_INDEX,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_MESH_AND_FRAG,
    PROPERTY_MAX_MESH_OUTPUT_VERTICES_256, PROPERTY_MAX_MESH_OUTPUT_VERTICES_512,
    PROPERTY_MAX_MESH_OUTPUT_VERTICES_1024, PROPERTY_MAX_MESH_OUTPUT_VERTICES_2048, PROPERTY_MAX_OUTPUT_LAYERS,
    PROPERTY_MAX_VIEW_INDEX, PROPERTY_MESH_BOTH, PROPERTY_MESH_PAYLOAD, PROPERTY_MESH_SHARED, PROPERTY_TASK_BOTH,
    PROPERTY_TASK_PAYLOAD, PROPERTY_TASK_SHARED,
};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
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
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::api::case_util::add_function_case;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::mesh_shader::util::{
    check_task_mesh_shader_support_ext, mesh_shader_features, mesh_shader_properties,
};
use crate::vkt::tests::pipeline::pipeline_util::make_color_depth_render_pass;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The render pass of every case that draws to a colour attachment of `format`, multiview over `layer_count` layers when asked.
fn make_custom_render_pass(
    device: &Device,
    layer_count: u32,
    format: vk::Format,
    multiview: bool,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    debug_assert!(layer_count > 0);

    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
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

    // The mask of a 32 view case is every bit (a shift by 32 would be undefined in the C++).
    let view_mask = if layer_count >= 32 {
        u32::MAX
    } else {
        (1u32 << layer_count) - 1
    };
    let view_masks = [view_mask];
    let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder()
        .view_masks(&view_masks)
        .correlation_masks(&view_masks);
    let mut info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    if multiview {
        info = info.push_next(&mut multiview_create_info);
    }
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// The colour image, view and verification buffer every colour case allocates.
struct ColorAttachment<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
    verification: BufferWithMemory<'a>,
    srr: vk::ImageSubresourceRange,
    srl: vk::ImageSubresourceLayers,
    extent: vk::Extent3D,
    #[allow(dead_code)]
    layers: u32,
    verification_size: usize,
}

fn create_color_attachment<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    extent: vk::Extent3D,
    layers: u32,
    pixel_size: u32,
) -> Result<ColorAttachment<'a>, TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(extent)
        .mip_levels(1)
        .array_layers(layers)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)?;
    let srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers);
    let srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layers);
    let view_type = if layers > 1 {
        vk::ImageViewType::_2D_ARRAY
    } else {
        vk::ImageViewType::_2D
    };
    let view = make_image_view(device, image.get(), view_type, format, srr)?;

    let verification_size = (pixel_size * extent.width * extent.height * layers) as usize;
    let verification = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(verification_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::write_bytes(verification.get_allocation().get_host_ptr(), 0, verification_size) };
    flush_alloc(device, verification.get_allocation())?;

    Ok(ColorAttachment {
        image,
        view,
        verification,
        srr,
        srl,
        extent,
        layers,
        verification_size,
    })
}

impl ColorAttachment<'_> {
    /// The transfer of the attachment to the verification buffer, recorded after the render pass.
    fn record_copy_to_verification(&self, device: &Device, cmd: vk::CommandBuffer) {
        let pre_transfer_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            self.image.get(),
            self.srr,
        );
        let copy_region = make_buffer_image_copy(self.extent, self.srl);
        let post_transfer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_transfer_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                self.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.verification.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[post_transfer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// The verification buffer after the device wrote it.
    fn read(&self, device: &Device) -> Result<&[u8], TestError> {
        invalidate_alloc(device, self.verification.get_allocation())?;
        Ok(unsafe {
            std::slice::from_raw_parts(
                self.verification.get_allocation().get_host_ptr().cast_const(),
                self.verification_size,
            )
        })
    }
}

fn begin_render_pass_cmd(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    area: vk::Rect2D,
    clear_values: &[vk::ClearValue],
) {
    let info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(area)
        .clear_values(clear_values);
    unsafe { device.cmd_begin_render_pass(cmd, &info, vk::SubpassContents::INLINE) };
}

fn clear_uint() -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { uint32: [0; 4] },
    }
}

fn clear_float(color: [f32; 4]) -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { float32: color },
    }
}

/// A pipeline of `stages` with the given specialization constants (applied to every stage) and colour attachment count.
fn create_mesh_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &[(vk::ShaderStageFlags, vk::ShaderModule)],
    extent: (u32, u32),
    color_attachment_count: u32,
    spec_values: &[u32],
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(extent.0, extent.1);
    state.color_attachment_count = color_attachment_count;
    state.all_stages_specialization_values = spec_values.to_vec();
    create_draw_pipeline(device, layout, render_pass, stages, &state)
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Payload and shared memory sizes (task and mesh variants)
// ---------------------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum PayLoadShMemSizeType {
    Payload,
    SharedMemory,
    Both,
}

impl PayLoadShMemSizeType {
    fn has_payload(self) -> bool {
        self != PayLoadShMemSizeType::SharedMemory
    }

    #[allow(dead_code)]
    fn has_shared_memory(self) -> bool {
        self != PayLoadShMemSizeType::Payload
    }
}

const ELEMENT_SIZE: u32 = 4;
const LOCAL_INVOCATIONS: u32 = 128;

/// The element counts of the part of the limits a case pushes to the maximum: shared by both variants once the three maximums
/// (payload, shared memory, total) are known. Divides them as evenly as possible, getting them as close as possible to the total.
fn split_elements(
    test_type: PayLoadShMemSizeType,
    max_payload_elements: u32,
    max_sh_mem_elements: u32,
    max_total_elements: u32,
) -> (u32, u32) {
    match test_type {
        PayLoadShMemSizeType::Payload => (max_total_elements.min(max_payload_elements), 0),
        PayLoadShMemSizeType::SharedMemory => (0, max_total_elements.min(max_sh_mem_elements)),
        PayLoadShMemSizeType::Both => {
            let (min_val, max_val, payload_is_min) = if max_payload_elements < max_sh_mem_elements {
                (max_payload_elements, max_sh_mem_elements, true)
            } else {
                (max_sh_mem_elements, max_payload_elements, false)
            };

            let min_elements = min_val.min(max_total_elements / 2);
            let max_elements = (max_total_elements - min_elements).min(max_val);
            if payload_is_min {
                (min_elements, max_elements)
            } else {
                (max_elements, min_elements)
            }
        }
    }
}

struct TaskPayloadShMemSizeCase {
    name: String,
    test_type: PayLoadShMemSizeType,
}

impl TestCase for TaskPayloadShMemSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TaskPayloadShMemSizeCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, true, true)?;

        let mesh_properties = mesh_shader_properties(context);
        let min_size = LOCAL_INVOCATIONS * ELEMENT_SIZE;

        // Note: the min required values for these properties in the spec would pass these checks.
        if mesh_properties.max_task_payload_size < min_size {
            return Err(TestError::Fail("Invalid maxTaskPayloadSize".to_string()));
        }
        if mesh_properties.max_task_shared_memory_size < min_size {
            return Err(TestError::Fail("Invalid maxTaskSharedMemorySize".to_string()));
        }
        if mesh_properties.max_task_payload_and_shared_memory_size < min_size {
            return Err(TestError::Fail("Invalid maxTaskPayloadAndSharedMemorySize".to_string()));
        }
        if mesh_properties.max_mesh_payload_and_shared_memory_size < min_size {
            return Err(TestError::Fail("Invalid maxMeshPayloadAndSharedMemorySize".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.test_type {
            PayLoadShMemSizeType::Payload => PROPERTY_TASK_PAYLOAD.programs,
            PayLoadShMemSizeType::SharedMemory => PROPERTY_TASK_SHARED.programs,
            PayLoadShMemSizeType::Both => PROPERTY_TASK_BOTH.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        // `getParamsFromContext`
        let mesh_properties = mesh_shader_properties(context);
        let max_mesh_payload_size = mesh_properties
            .max_mesh_payload_and_output_memory_size
            .min(mesh_properties.max_mesh_payload_and_shared_memory_size);
        let max_payload_elements =
            (mesh_properties.max_task_payload_size / ELEMENT_SIZE).min(max_mesh_payload_size / ELEMENT_SIZE);
        let max_sh_mem_elements = mesh_properties.max_task_shared_memory_size / ELEMENT_SIZE;
        let max_total_elements = mesh_properties.max_task_payload_and_shared_memory_size / ELEMENT_SIZE;

        let (payload_elements, shared_memory_elements) = split_elements(
            self.test_type,
            max_payload_elements,
            max_sh_mem_elements,
            max_total_elements,
        );
        Box::new(PayloadShMemSizeInstance {
            context,
            spec_constants: vec![payload_elements, shared_memory_elements],
        })
    }
}

struct MeshPayloadShMemSizeCase {
    name: String,
    test_type: PayLoadShMemSizeType,
}

impl TestCase for MeshPayloadShMemSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MeshPayloadShMemSizeCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let require_task = self.test_type.has_payload();

        check_task_mesh_shader_support_ext(context, require_task, true)?;

        let mesh_properties = mesh_shader_properties(context);
        let min_size = LOCAL_INVOCATIONS * ELEMENT_SIZE;

        // Note: the min required values for these properties in the spec would pass these checks.
        if require_task {
            if mesh_properties.max_task_payload_size < min_size {
                return Err(TestError::Fail("Invalid maxTaskPayloadSize".to_string()));
            }
            if mesh_properties.max_task_payload_and_shared_memory_size < min_size {
                return Err(TestError::Fail("Invalid maxTaskPayloadAndSharedMemorySize".to_string()));
            }
        }

        if mesh_properties.max_mesh_shared_memory_size < min_size {
            return Err(TestError::Fail("Invalid maxMeshSharedMemorySize".to_string()));
        }
        if mesh_properties.max_mesh_payload_and_shared_memory_size < min_size {
            return Err(TestError::Fail("Invalid maxMeshPayloadAndSharedMemorySize".to_string()));
        }
        if mesh_properties.max_mesh_payload_and_output_memory_size < min_size {
            return Err(TestError::Fail("Invalid maxMeshPayloadAndOutputMemorySize".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.test_type {
            PayLoadShMemSizeType::Payload => PROPERTY_MESH_PAYLOAD.programs,
            PayLoadShMemSizeType::SharedMemory => PROPERTY_MESH_SHARED.programs,
            PayLoadShMemSizeType::Both => PROPERTY_MESH_BOTH.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        // `getParamsFromContext`
        let mesh_properties = mesh_shader_properties(context);
        let max_task_payload_size = mesh_properties
            .max_task_payload_and_shared_memory_size
            .min(mesh_properties.max_task_payload_size);
        let max_mesh_payload_size = mesh_properties
            .max_mesh_payload_and_output_memory_size
            .min(mesh_properties.max_mesh_payload_and_shared_memory_size);
        let max_payload_elements = max_task_payload_size.min(max_mesh_payload_size) / ELEMENT_SIZE;
        let max_sh_mem_elements = mesh_properties.max_mesh_shared_memory_size / ELEMENT_SIZE;
        let max_total_elements = mesh_properties.max_mesh_payload_and_shared_memory_size / ELEMENT_SIZE;

        let (payload_elements, shared_memory_elements) = split_elements(
            self.test_type,
            max_payload_elements,
            max_sh_mem_elements,
            max_total_elements,
        );
        Box::new(PayloadShMemSizeInstance {
            context,
            spec_constants: vec![payload_elements, shared_memory_elements],
        })
    }
}

struct PayloadShMemSizeInstance<'a> {
    context: &'a Context<'a>,
    spec_constants: Vec<u32>,
}

impl TestInstance for PayloadShMemSizeInstance<'_> {
    /// `PayloadShMemSizeInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let framebuffer_extent = (1u32, 1u32);
        let pipeline_bind_point = vk::PipelineBindPoint::GRAPHICS;

        let results_buffer_size = (std::mem::size_of::<u32>() * 2) as vk::DeviceSize;
        let results_buffer_desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let results_buffer_stages = vk::ShaderStageFlags::TASK_EXT | vk::ShaderStageFlags::MESH_EXT;
        let results_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(results_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let results_alloc = results_buffer.get_allocation();
        unsafe { std::ptr::write_bytes(results_alloc.get_host_ptr(), 0, results_buffer_size as usize) };
        flush_alloc(device, results_alloc)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(results_buffer_desc_type, results_buffer_stages)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(results_buffer_desc_type, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        let results_buffer_desc_info = make_descriptor_buffer_info(results_buffer.get(), 0, results_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                results_buffer_desc_type,
                &results_buffer_desc_info,
            )
            .update(device);

        let binaries = context.get_binary_collection();
        let has_task = binaries.contains("task");
        let task_shader = if has_task {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;

        // `makeCustomRenderPass`: no attachments and a task to mesh dependency on shader writes.
        let subpasses = [vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)];
        let dependencies = [vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 0,
            src_stage_mask: vk::PipelineStageFlags::TASK_SHADER_EXT,
            dst_stage_mask: vk::PipelineStageFlags::MESH_SHADER_EXT,
            src_access_mask: vk::AccessFlags::SHADER_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_WRITE,
            dependency_flags: vk::DependencyFlags::empty(),
        }];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[], framebuffer_extent.0, framebuffer_extent.1, 1)?;

        let mut stages = Vec::new();
        if let Some(task) = &task_shader {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_shader));
        let pipeline = create_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            framebuffer_extent,
            0,
            &self.spec_constants,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass_cmd(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, framebuffer_extent.0, framebuffer_extent.1),
            &[],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, pipeline_bind_point, pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                pipeline_bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            device.cmd_end_render_pass(cmd);
            let write_to_host = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::MESH_SHADER_EXT | vk::PipelineStageFlags::TASK_SHADER_EXT,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[write_to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, results_alloc)?;
        let result = unsafe { std::slice::from_raw_parts(results_alloc.get_host_ptr().cast_const(), 8) };
        let shared_ok = u32::from_ne_bytes(result[0..4].try_into().expect("four bytes"));
        let payload_ok = u32::from_ne_bytes(result[4..8].try_into().expect("four bytes"));

        if shared_ok != 1 {
            return Err(TestError::Fail(format!("Unexpected shared memory result: {shared_ok}")));
        }

        if payload_ok != 1 {
            return Err(TestError::Fail(format!("Unexpected payload result: {payload_ok}")));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Max view index and max output layers
// ---------------------------------------------------------------------------------------------------------------------------------

/// Checks every layer of an R32_UINT verification buffer holds `layer + 1`.
fn verify_layer_values(result: &[u8], layer_count: u32, pixels_per_layer: u32) -> Result<(), TestError> {
    for z in 0..layer_count {
        for pixel in 0..pixels_per_layer {
            let offset = ((z * pixels_per_layer + pixel) * 4) as usize;
            let value = u32::from_ne_bytes(result[offset..offset + 4].try_into().expect("four bytes"));
            if value != z + 1 {
                return Err(TestError::Fail(format!(
                    "Unexpected pixel value at layer {z}: pixel {pixel} is {value} while expecting {}",
                    z + 1
                )));
            }
        }
    }
    Ok(())
}

struct MaxViewIndexCase {
    name: String,
}

const MAX_VIEWS: u32 = 32;

impl TestCase for MaxViewIndexCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MaxViewIndexCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, false, true)?;

        let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut multiview_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if multiview_features.multiview == vk::FALSE {
            return Err(TestError::NotSupported("Multiview not supported".to_string()));
        }

        if mesh_shader_features(context).multiview_mesh_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Multiview not supported for mesh shaders".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        PROPERTY_MAX_VIEW_INDEX.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaxViewIndexInstance { context })
    }
}

struct MaxViewIndexInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MaxViewIndexInstance<'_> {
    /// `MaxViewIndexInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let mesh_properties = mesh_shader_properties(context);
        let num_views = mesh_properties.max_mesh_multiview_view_count.min(MAX_VIEWS);
        let color_format = vk::Format::R32_UINT;
        let fb_extent = vk::Extent3D {
            width: 8,
            height: 8,
            depth: 1,
        };

        let color = create_color_attachment(context, color_format, fb_extent, num_views, 4)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let render_pass = make_custom_render_pass(device, num_views, color_format, true)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color.view],
            fb_extent.width,
            fb_extent.height,
            1,
        )?;

        let binaries = context.get_binary_collection();
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = create_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::MESH_EXT, *mesh_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            (fb_extent.width, fb_extent.height),
            1,
            &[],
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass_cmd(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent.width, fb_extent.height),
            &[clear_uint()],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            device.cmd_end_render_pass(cmd);
        }
        color.record_copy_to_verification(device, cmd);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        verify_layer_values(color.read(device)?, num_views, fb_extent.width * fb_extent.height)?;

        // QualityWarning if needed.
        if mesh_properties.max_mesh_multiview_view_count > MAX_VIEWS {
            return Ok(TestStatus::new(
                TestResult::QualityWarning,
                format!("Test passed but maxMeshMultiviewViewCount greater than {MAX_VIEWS}"),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct MaxOutputLayersCase {
    name: String,
}

impl TestCase for MaxOutputLayersCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, false, true)
    }

    fn programs(&self) -> BinaryCollection {
        PROPERTY_MAX_OUTPUT_LAYERS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaxOutputLayersInstance { context })
    }
}

struct MaxOutputLayersInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MaxOutputLayersInstance<'_> {
    /// `MaxOutputLayersInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let fb_format = vk::Format::R32_UINT;
        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

        // Find out how many layers we can actually use.
        let properties = context.get_device_properties();
        let mesh_properties = mesh_shader_properties(context);
        let format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                fb_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        let layer_count = properties
            .limits
            .max_framebuffer_layers
            .min(mesh_properties.max_mesh_output_layers)
            .min(format_properties.max_array_layers)
            .min(mesh_properties.max_mesh_work_group_count[0]);

        log::info!("Using {layer_count} layers");

        let fb_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let color = create_color_attachment(context, fb_format, fb_extent, layer_count, 4)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let render_pass = make_custom_render_pass(device, 1, fb_format, false)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color.view],
            fb_extent.width,
            fb_extent.height,
            layer_count,
        )?;

        let binaries = context.get_binary_collection();
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = create_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::MESH_EXT, *mesh_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            (1, 1),
            1,
            &[],
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass_cmd(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, 1, 1),
            &[clear_uint()],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw_mesh_tasks_ext(cmd, layer_count, 1, 1);
            device.cmd_end_render_pass(cmd);
        }
        color.record_copy_to_verification(device, cmd);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        verify_layer_values(color.read(device)?, layer_count, 1)?;

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Max mesh output primitives and vertices
// ---------------------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum MaxPrimVertType {
    Primitives,
    Vertices,
}

struct MaxMeshOutputPrimVertCase {
    name: String,
    test_type: MaxPrimVertType,
    item_count: u32,
}

impl TestCase for MaxMeshOutputPrimVertCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MaxMeshOutputPrimVertCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, false, true)?;
        if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: fragmentStoresAndAtomics".to_string(),
            ));
        }

        // Note when testing vertices, due to our usage of points as the primitive type, we are also limited by the number of primitives.
        let is_vertices = self.test_type == MaxPrimVertType::Vertices;
        let mesh_properties = mesh_shader_properties(context);
        let item_limit = if is_vertices {
            mesh_properties
                .max_mesh_output_vertices
                .min(mesh_properties.max_mesh_output_primitives)
        } else {
            mesh_properties.max_mesh_output_primitives
        };

        if self.item_count > item_limit {
            return Err(TestError::NotSupported(
                "Implementation does not support the given amount of items".to_string(),
            ));
        }

        // Check memory limits just in case. Per vertex: gl_Position and gl_PointSize.
        let per_vertex_bytes = 16 + 4u32;
        let total_bytes = if is_vertices {
            // No per-primitive data in this variant.
            let actual_vertices = self
                .item_count
                .div_ceil(mesh_properties.mesh_output_per_vertex_granularity)
                * mesh_properties.mesh_output_per_vertex_granularity;
            per_vertex_bytes * actual_vertices
        } else {
            // Single vertex, but using gl_PrimitiveID in each primitive.
            let per_primitive_bytes = 4u32;
            let actual_vertices = mesh_properties.mesh_output_per_vertex_granularity;
            let actual_primitives = self
                .item_count
                .div_ceil(mesh_properties.mesh_output_per_primitive_granularity)
                * mesh_properties.mesh_output_per_primitive_granularity;
            per_vertex_bytes * actual_vertices + per_primitive_bytes * actual_primitives
        };

        if total_bytes > mesh_properties.max_mesh_output_memory_size {
            return Err(TestError::NotSupported(
                "Not enough output memory for this test".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.test_type, self.item_count) {
            (MaxPrimVertType::Primitives, 256) => PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_256.programs,
            (MaxPrimVertType::Primitives, 512) => PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_512.programs,
            (MaxPrimVertType::Primitives, 1024) => PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_1024.programs,
            (MaxPrimVertType::Primitives, _) => PROPERTY_MAX_MESH_OUTPUT_PRIMITIVES_2048.programs,
            (MaxPrimVertType::Vertices, 256) => PROPERTY_MAX_MESH_OUTPUT_VERTICES_256.programs,
            (MaxPrimVertType::Vertices, 512) => PROPERTY_MAX_MESH_OUTPUT_VERTICES_512.programs,
            (MaxPrimVertType::Vertices, 1024) => PROPERTY_MAX_MESH_OUTPUT_VERTICES_1024.programs,
            (MaxPrimVertType::Vertices, _) => PROPERTY_MAX_MESH_OUTPUT_VERTICES_2048.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let fb_width = if self.test_type == MaxPrimVertType::Primitives {
            1
        } else {
            self.item_count
        };
        Box::new(MaxMeshOutputPrimVertInstance {
            context,
            shader_primitives: self.item_count,
            fb_width,
        })
    }
}

struct MaxMeshOutputPrimVertInstance<'a> {
    context: &'a Context<'a>,
    shader_primitives: u32,
    fb_width: u32,
}

impl TestInstance for MaxMeshOutputPrimVertInstance<'_> {
    /// `MaxMeshOutputPrimVertInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let fb_extent = (self.fb_width, 1u32);
        let bind_point = vk::PipelineBindPoint::GRAPHICS;

        let ssbo_size = (std::mem::size_of::<u32>() as u32 * self.shader_primitives) as vk::DeviceSize;
        let ssbo_desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let ssbo = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let ssbo_alloc = ssbo.get_allocation();
        let ssbo_desc_info = make_descriptor_buffer_info(ssbo.get(), 0, ssbo_size);

        // Zero-out SSBO.
        unsafe { std::ptr::write_bytes(ssbo_alloc.get_host_ptr(), 0, ssbo_size as usize) };
        flush_alloc(device, ssbo_alloc)?;

        // Descriptor set layout, pool, set and set update.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(ssbo_desc_type, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(ssbo_desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                ssbo_desc_type,
                &ssbo_desc_info,
            )
            .update(device);

        // Pipeline layout, render pass and pipeline.
        let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;
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
        let framebuffer = make_framebuffer(device, *render_pass, &[], fb_extent.0, fb_extent.1, 1)?;

        let binaries = context.get_binary_collection();
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = create_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::MESH_EXT, *mesh_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            fb_extent,
            0,
            &[],
        )?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass_cmd(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
            &[],
        );
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, bind_point, pipeline.get());
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            device.cmd_end_render_pass(cmd);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, ssbo_alloc)?;
        let output = unsafe { std::slice::from_raw_parts(ssbo_alloc.get_host_ptr().cast_const(), ssbo_size as usize) };

        // Verify output SSBO.
        let mut pass = true;
        for (i, flag) in output.chunks_exact(4).enumerate() {
            let flag = u32::from_ne_bytes(flag.try_into().expect("four bytes"));
            if flag != 1 {
                log::info!("Primitive ID {i} flag != 1: {flag}");
                pass = false;
            }
        }

        if !pass {
            return Err(TestError::Fail("Check log for details".to_string()));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Max mesh output components
// ---------------------------------------------------------------------------------------------------------------------------------

struct MaxMeshOutputComponentsCase {
    name: String,
}

impl TestCase for MaxMeshOutputComponentsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, false, true)
    }

    fn programs(&self) -> BinaryCollection {
        PROPERTY_MAX_MESH_OUTPUT_COMPONENTS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        // `getParamsFromContext`: each location can handle up to 4 32-bit components (uvec4), and gl_Position uses one location.
        let location_components = 4u32;
        let used_locations = 1u32;
        let max_locations =
            mesh_shader_properties(context).max_mesh_output_components / location_components - used_locations;
        Box::new(MaxMeshOutputComponentsInstance {
            context,
            spec_constants: vec![max_locations],
        })
    }
}

struct MaxMeshOutputComponentsInstance<'a> {
    context: &'a Context<'a>,
    spec_constants: Vec<u32>,
}

impl TestInstance for MaxMeshOutputComponentsInstance<'_> {
    /// `MaxMeshOutputComponentsInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let fb_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };

        let color = create_color_attachment(context, color_format, fb_extent, 1, 4)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let render_pass = make_custom_render_pass(device, 1, color_format, false)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color.view], 1, 1, 1)?;

        let binaries = context.get_binary_collection();
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = create_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::MESH_EXT, *mesh_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            (1, 1),
            1,
            &self.spec_constants,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass_cmd(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, 1, 1),
            &[clear_float([0.0, 0.0, 0.0, 1.0])],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            device.cmd_end_render_pass(cmd);
        }
        color.record_copy_to_verification(device, cmd);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = color.read(device)?;
        log::info!("maxLocations value: {}", self.spec_constants[0]);
        if result != [0u8, 0, 255, 255] {
            return Err(TestError::Fail("Check log for details".to_string()));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Max mesh output size
// ---------------------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum LocationType {
    PerVertex,
    PerPrimitive,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ViewIndexType {
    NoViewIndex,
    ViewIndexFrag,
    ViewIndexBoth,
}

#[derive(Clone, Copy)]
struct MaxMeshOutputParams {
    use_payload: bool,
    location_type: LocationType,
    view_index_type: ViewIndexType,
}

impl MaxMeshOutputParams {
    fn is_multi_view(&self) -> bool {
        self.view_index_type != ViewIndexType::NoViewIndex
    }

    fn view_index_in_mesh(&self) -> bool {
        self.view_index_type == ViewIndexType::ViewIndexBoth
    }
}

/// Small-ish numbers allow for more fine-grained control in the amount of memory, but it can't be too small or we hit the locations limit.
const MAX_POINTS: u32 = 96;
/// For the multiView case.
const NUM_VIEWS: u32 = 2;

struct MaxMeshOutputSizeCase {
    name: String,
    params: MaxMeshOutputParams,
}

impl TestCase for MaxMeshOutputSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MaxMeshOutputSizeCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, self.params.use_payload, true)?;

        if self.params.is_multi_view() {
            let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut multiview_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if multiview_features.multiview == vk::FALSE {
                return Err(TestError::NotSupported("Multiview not supported".to_string()));
            }

            if mesh_shader_features(context).multiview_mesh_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Multiview not supported for mesh shaders".to_string(),
                ));
            }

            if mesh_shader_properties(context).max_mesh_multiview_view_count < NUM_VIEWS {
                return Err(TestError::NotSupported("maxMeshMultiviewViewCount too low".to_string()));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        match (params.use_payload, params.location_type, params.view_index_type) {
            (false, LocationType::PerPrimitive, ViewIndexType::NoViewIndex) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_PRIMITIVE_NO_VIEW_INDEX.programs
            }
            (false, LocationType::PerPrimitive, ViewIndexType::ViewIndexFrag) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_FRAG.programs
            }
            (false, LocationType::PerPrimitive, ViewIndexType::ViewIndexBoth) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_MESH_AND_FRAG.programs
            }
            (false, LocationType::PerVertex, ViewIndexType::NoViewIndex) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_VERTEX_NO_VIEW_INDEX.programs
            }
            (false, LocationType::PerVertex, ViewIndexType::ViewIndexFrag) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_FRAG.programs
            }
            (false, LocationType::PerVertex, ViewIndexType::ViewIndexBoth) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITHOUT_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_MESH_AND_FRAG.programs
            }
            (true, LocationType::PerPrimitive, ViewIndexType::NoViewIndex) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_PRIMITIVE_NO_VIEW_INDEX.programs
            }
            (true, LocationType::PerPrimitive, ViewIndexType::ViewIndexFrag) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_FRAG.programs
            }
            (true, LocationType::PerPrimitive, ViewIndexType::ViewIndexBoth) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_PRIMITIVE_VIEW_INDEX_IN_MESH_AND_FRAG.programs
            }
            (true, LocationType::PerVertex, ViewIndexType::NoViewIndex) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_VERTEX_NO_VIEW_INDEX.programs
            }
            (true, LocationType::PerVertex, ViewIndexType::ViewIndexFrag) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_FRAG.programs
            }
            (true, LocationType::PerVertex, ViewIndexType::ViewIndexBoth) => {
                PROPERTY_MAX_MESH_OUTPUT_SIZE_WITH_PAYLOAD_PER_VERTEX_VIEW_INDEX_IN_MESH_AND_FRAG.programs
            }
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        // `getParamsFromContext`
        let params = &self.params;
        let mesh_properties = mesh_shader_properties(context);
        let max_out_size = mesh_properties
            .max_mesh_output_memory_size
            .min(mesh_properties.max_mesh_payload_and_output_memory_size);
        let max_mesh_payload_size = mesh_properties
            .max_mesh_payload_and_shared_memory_size
            .min(mesh_properties.max_mesh_payload_and_output_memory_size);
        let max_task_payload_size = mesh_properties
            .max_task_payload_size
            .min(mesh_properties.max_task_payload_and_shared_memory_size);
        let max_payload_size = max_mesh_payload_size.min(max_task_payload_size);
        let num_view_factor = if params.view_index_in_mesh() { NUM_VIEWS } else { 1 };

        let (payload_size, out_size) = if params.use_payload {
            let total_max = max_out_size + max_payload_size;

            if total_max <= mesh_properties.max_mesh_payload_and_output_memory_size {
                (max_payload_size, max_out_size)
            } else {
                (
                    max_payload_size,
                    mesh_properties.max_mesh_payload_and_output_memory_size - max_payload_size,
                )
            }
        } else {
            (0, max_out_size)
        };

        // This uses the equation in "Mesh Shader Output" spec section. Note per-vertex data already has gl_Position and gl_PointSize.
        // Also note gl_PointSize uses 1 effective location (4 scalar components) despite being a float.
        let uvec4_size = 16u32;
        let uvec4_comp = 4u32;
        let granularity = if params.location_type == LocationType::PerPrimitive {
            mesh_properties.mesh_output_per_primitive_granularity
        } else {
            mesh_properties.mesh_output_per_vertex_granularity
        };
        let actual_points = MAX_POINTS.div_ceil(granularity) * granularity;
        let size_multiplier = actual_points * uvec4_size;
        let builtin_data_size = (16 + 16) * actual_points;
        let locations_data_size = (out_size - builtin_data_size) / num_view_factor;
        // gl_Position and gl_PointSize use 1 location each.
        let max_total_locations = mesh_properties.max_mesh_output_components / uvec4_comp - 2;
        let location_count = (locations_data_size / size_multiplier).min(max_total_locations);

        let payload_elements = payload_size / 4;

        {
            let actual_output_size = builtin_data_size + location_count * size_multiplier * num_view_factor;

            log::info!("Payload elements: {payload_elements}");
            log::info!("Location count: {location_count}");
            log::info!(
                "Max mesh payload and output size (bytes): {}",
                mesh_properties.max_mesh_payload_and_output_memory_size
            );
            log::info!("Max output size (bytes): {max_out_size}");
            log::info!("Payload size (bytes): {payload_size}");
            log::info!("Output data size (bytes): {actual_output_size}");
            log::info!("Output + payload size (bytes): {}", payload_size + actual_output_size);
        }

        let num_views = if params.is_multi_view() { NUM_VIEWS } else { 1 };
        Box::new(MaxMeshOutputSizeInstance {
            context,
            spec_constants: vec![payload_elements, location_count],
            num_views,
        })
    }
}

struct MaxMeshOutputSizeInstance<'a> {
    context: &'a Context<'a>,
    spec_constants: Vec<u32>,
    num_views: u32,
}

impl TestInstance for MaxMeshOutputSizeInstance<'_> {
    /// `MaxMeshOutputSizeInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let fb_extent = vk::Extent3D {
            width: MAX_POINTS,
            height: 1,
            depth: 1,
        };

        let color = create_color_attachment(context, color_format, fb_extent, self.num_views, 4)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let render_pass = make_custom_render_pass(device, self.num_views, color_format, self.num_views > 1)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color.view],
            fb_extent.width,
            fb_extent.height,
            1,
        )?;

        let binaries = context.get_binary_collection();
        let has_task = binaries.contains("task");
        let task_module = if has_task {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut stages = Vec::new();
        if let Some(task) = &task_module {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        let pipeline = create_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            (fb_extent.width, fb_extent.height),
            1,
            &self.spec_constants,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass_cmd(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent.width, fb_extent.height),
            &[clear_float([0.0, 0.0, 0.0, 1.0])],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            device.cmd_end_render_pass(cmd);
        }
        color.record_copy_to_verification(device, cmd);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Every layer is (z, 0, 1, 1), exactly.
        let result = color.read(device)?;
        let layer_size = (fb_extent.width * fb_extent.height * 4) as usize;
        for z in 0..self.num_views as usize {
            let expected = [(z * 255) as u8, 0, 255, 255];
            if !result[z * layer_size..(z + 1) * layer_size]
                .chunks_exact(4)
                .all(|pixel| pixel == expected)
            {
                return Err(TestError::Fail("Check log for details".to_string()));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------------------
// Limits
// ---------------------------------------------------------------------------------------------------------------------------------

fn limits_check_support(context: &Context<'_>) -> Result<(), TestError> {
    check_task_mesh_shader_support_ext(context, false, true)
}

/// `limitsRun`
fn limits_run(context: &Context<'_>) -> TestOutcome {
    let features = mesh_shader_features(context);
    let props = mesh_shader_properties(context);

    let mut fail = false;

    let mut check_limit = |name: &str, value: u32, min_val: u32, max_val: u32| {
        if value < min_val {
            log::info!("Property {name} has value {value} below the minimum of {min_val}");
            fail = true;
        }

        if value > max_val {
            log::info!("Property {name} has value {value} above the maximum of {max_val}");
            fail = true;
        }
    };

    if features.task_shader != vk::FALSE {
        check_limit(
            "maxTaskWorkGroupTotalCount",
            props.max_task_work_group_total_count,
            1 << 22,
            u32::MAX,
        );
        check_limit(
            "maxTaskWorkGroupCount[0]",
            props.max_task_work_group_count[0],
            65535,
            u32::MAX,
        );
        check_limit(
            "maxTaskWorkGroupCount[1]",
            props.max_task_work_group_count[1],
            65535,
            u32::MAX,
        );
        check_limit(
            "maxTaskWorkGroupCount[2]",
            props.max_task_work_group_count[2],
            65535,
            u32::MAX,
        );
        check_limit(
            "maxTaskWorkGroupInvocations",
            props.max_task_work_group_invocations,
            128,
            u32::MAX,
        );
        check_limit(
            "maxTaskWorkGroupSize[0]",
            props.max_task_work_group_size[0],
            128,
            u32::MAX,
        );
        check_limit(
            "maxTaskWorkGroupSize[1]",
            props.max_task_work_group_size[1],
            128,
            u32::MAX,
        );
        check_limit(
            "maxTaskWorkGroupSize[2]",
            props.max_task_work_group_size[2],
            128,
            u32::MAX,
        );
        check_limit("maxTaskPayloadSize", props.max_task_payload_size, 16384, u32::MAX);
        check_limit(
            "maxTaskSharedMemorySize",
            props.max_task_shared_memory_size,
            32768,
            u32::MAX,
        );
        check_limit(
            "maxTaskPayloadAndSharedMemorySize",
            props.max_task_payload_and_shared_memory_size,
            32768,
            u32::MAX,
        );
    }

    if features.mesh_shader != vk::FALSE {
        check_limit(
            "maxMeshWorkGroupTotalCount",
            props.max_mesh_work_group_total_count,
            1 << 22,
            u32::MAX,
        );
        check_limit(
            "maxMeshWorkGroupCount[0]",
            props.max_mesh_work_group_count[0],
            65535,
            u32::MAX,
        );
        check_limit(
            "maxMeshWorkGroupCount[1]",
            props.max_mesh_work_group_count[1],
            65535,
            u32::MAX,
        );
        check_limit(
            "maxMeshWorkGroupCount[2]",
            props.max_mesh_work_group_count[2],
            65535,
            u32::MAX,
        );
        check_limit(
            "maxMeshWorkGroupInvocations",
            props.max_mesh_work_group_invocations,
            128,
            u32::MAX,
        );
        check_limit(
            "maxMeshWorkGroupSize[0]",
            props.max_mesh_work_group_size[0],
            128,
            u32::MAX,
        );
        check_limit(
            "maxMeshWorkGroupSize[1]",
            props.max_mesh_work_group_size[1],
            128,
            u32::MAX,
        );
        check_limit(
            "maxMeshWorkGroupSize[2]",
            props.max_mesh_work_group_size[2],
            128,
            u32::MAX,
        );
        check_limit(
            "maxMeshSharedMemorySize",
            props.max_mesh_shared_memory_size,
            28672,
            u32::MAX,
        );
        check_limit(
            "maxMeshPayloadAndSharedMemorySize",
            props.max_mesh_payload_and_shared_memory_size,
            28672,
            u32::MAX,
        );
        check_limit(
            "maxMeshOutputMemorySize",
            props.max_mesh_output_memory_size,
            32768,
            u32::MAX,
        );
        check_limit(
            "maxMeshPayloadAndOutputMemorySize",
            props.max_mesh_payload_and_output_memory_size,
            48128,
            u32::MAX,
        );
        check_limit(
            "maxMeshOutputComponents",
            props.max_mesh_output_components,
            128,
            u32::MAX,
        );
        check_limit("maxMeshOutputVertices", props.max_mesh_output_vertices, 256, u32::MAX);
        check_limit(
            "maxMeshOutputPrimitives",
            props.max_mesh_output_primitives,
            256,
            u32::MAX,
        );
        check_limit("maxMeshOutputLayers", props.max_mesh_output_layers, 8, u32::MAX);

        check_limit(
            "meshOutputPerVertexGranularity",
            props.mesh_output_per_vertex_granularity,
            0,
            32,
        );
        check_limit(
            "meshOutputPerPrimitiveGranularity",
            props.mesh_output_per_primitive_granularity,
            0,
            32,
        );
    }

    if fail {
        return Err(TestError::Fail(
            "Some properties failed the limits test; check log for details --".to_string(),
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `createMeshShaderPropertyTestsEXT`
pub fn create_mesh_shader_property_tests_ext() -> TestCaseGroup {
    // Tests checking mesh shading properties.
    let mut main_group = TestCaseGroup::new("properties");

    add_function_case(&mut main_group, "limits", limits_check_support, limits_run);

    for (test_type, name) in [
        (PayLoadShMemSizeType::Payload, "task_payload_size"),
        (PayLoadShMemSizeType::SharedMemory, "task_shared_memory_size"),
        (PayLoadShMemSizeType::Both, "task_payload_and_shared_memory_size"),
    ] {
        main_group.add_child(Box::new(TaskPayloadShMemSizeCase {
            name: name.to_string(),
            test_type,
        }) as Box<dyn TestCase>);
    }

    main_group.add_child(Box::new(MaxViewIndexCase {
        name: "max_view_index".to_string(),
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(MaxOutputLayersCase {
        name: "max_output_layers".to_string(),
    }) as Box<dyn TestCase>);

    for (test_type, prefix) in [
        (MaxPrimVertType::Primitives, "max_mesh_output_primitives_"),
        (MaxPrimVertType::Vertices, "max_mesh_output_vertices_"),
    ] {
        for item_count in [256u32, 512, 1024, 2048] {
            main_group.add_child(Box::new(MaxMeshOutputPrimVertCase {
                name: format!("{prefix}{item_count}"),
                test_type,
                item_count,
            }) as Box<dyn TestCase>);
        }
    }

    main_group.add_child(Box::new(MaxMeshOutputComponentsCase {
        name: "max_mesh_output_components".to_string(),
    }) as Box<dyn TestCase>);

    // No actual property for the first one, combines the two properties involving payload size.
    for (test_type, name) in [
        (PayLoadShMemSizeType::Payload, "mesh_payload_size"),
        (PayLoadShMemSizeType::SharedMemory, "mesh_shared_memory_size"),
        (PayLoadShMemSizeType::Both, "mesh_payload_and_shared_memory_size"),
    ] {
        main_group.add_child(Box::new(MeshPayloadShMemSizeCase {
            name: name.to_string(),
            test_type,
        }) as Box<dyn TestCase>);
    }

    for (use_payload, payload_suffix) in [(false, "_without_payload"), (true, "_with_payload")] {
        for (location_type, location_suffix) in [
            (LocationType::PerPrimitive, "_per_primitive"),
            (LocationType::PerVertex, "_per_vertex"),
        ] {
            for (view_index_type, multiview_suffix) in [
                (ViewIndexType::NoViewIndex, "_no_view_index"),
                (ViewIndexType::ViewIndexFrag, "_view_index_in_frag"),
                (ViewIndexType::ViewIndexBoth, "_view_index_in_mesh_and_frag"),
            ] {
                let name = format!("max_mesh_output_size{payload_suffix}{location_suffix}{multiview_suffix}");
                main_group.add_child(Box::new(MaxMeshOutputSizeCase {
                    name,
                    params: MaxMeshOutputParams {
                        use_payload,
                        location_type,
                        view_index_type,
                    },
                }) as Box<dyn TestCase>);
            }
        }
    }

    main_group
}
