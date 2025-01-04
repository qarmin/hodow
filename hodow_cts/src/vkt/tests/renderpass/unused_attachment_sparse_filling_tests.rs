// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassUnusedAttachmentSparseFillingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The fragment shader depends on the shuffle `generateInputAttachmentParams` makes,
// so the manifest holds one program set per (rendering kind, attachment count); the shuffle below has to stay in step with the one
// the shaders were written from. Monolithic pipelines only.
//
// Tests sparse input attachments in VkSubpassDescription::pInputAttachments: X input attachments spread randomly over an array of
// 2X references, each read by the fragment shader and counted into a storage image.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::renderpass_unused_attachment_sparse_filling::{
    SPARSE_FILL_DYN_1, SPARSE_FILL_DYN_3, SPARSE_FILL_DYN_7, SPARSE_FILL_DYN_15, SPARSE_FILL_DYN_31,
    SPARSE_FILL_DYN_63, SPARSE_FILL_DYN_127, SPARSE_FILL_RP_1, SPARSE_FILL_RP_3, SPARSE_FILL_RP_7, SPARSE_FILL_RP_15,
    SPARSE_FILL_RP_31, SPARSE_FILL_RP_63, SPARSE_FILL_RP_127,
};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::random::Random;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{rect_2d, viewport};
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 8;
const DEFAULT_SEED: u32 = 31;
/// `VK_ATTACHMENT_UNUSED`
const ATTACHMENT_UNUSED: u32 = u32::MAX;

#[derive(Clone, Copy)]
struct TestParams {
    group_params: GroupParams,
    active_input_attachment_count: u32,
}

#[repr(C)]
#[derive(Clone, Copy)]
struct Vertex {
    position: [f32; 4],
    uv: [f32; 4],
}

/// `createFullscreenTriangle`
fn create_fullscreen_triangle() -> Vec<Vertex> {
    (0..3u32)
        .map(|i| {
            let x = ((i << 1) & 2) as f32;
            let y = (i & 2) as f32;
            Vertex {
                position: [x * 2.0 - 1.0, y * 2.0 - 1.0, 0.0, 1.0],
                uv: [x, y, 0.0, 0.0],
            }
        })
        .collect()
}

/// `generateInputAttachmentParams`; returns the attachment indices and the descriptor bindings.
fn generate_input_attachment_params(
    rendering_type: RenderingType,
    active_attachment_count: u32,
    all_attachment_count: u32,
) -> (Vec<u32>, Vec<u32>) {
    let mut attachment_indices = vec![ATTACHMENT_UNUSED; all_attachment_count as usize];
    let mut descriptor_bindings = vec![ATTACHMENT_UNUSED; active_attachment_count as usize + 1];

    let mut random = Random::new(DEFAULT_SEED);

    // there is diference in test logic for dynamic rendering cases where attachment indices
    // needed to be from range <0; 2 * activeAttachmentCount - 1> where for renderpass cases
    // attachment indices had to be from range <0; activeAttachmentCount - 1>
    if rendering_type == RenderingType::DynamicRendering {
        // fill all indices and shuffle them
        for (i, index) in attachment_indices.iter_mut().enumerate() {
            *index = i as u32;
        }
        random.shuffle(&mut attachment_indices);

        // set every other attachment as unused
        for i in (0..attachment_indices.len()).step_by(2) {
            attachment_indices[i] = ATTACHMENT_UNUSED;
        }

        // shuffle once again
        random.shuffle(&mut attachment_indices);

        let mut last_binding = 1;
        for index in &attachment_indices {
            if *index != ATTACHMENT_UNUSED {
                descriptor_bindings[last_binding] = *index;
                last_binding += 1;
            }
        }
    } else {
        // fill half of indices
        for (i, index) in attachment_indices
            .iter_mut()
            .take(active_attachment_count as usize)
            .enumerate()
        {
            *index = i as u32;
        }

        // shuffle values with remaining unused indices
        random.shuffle(&mut attachment_indices);

        let mut last_binding = 1;
        for (i, index) in attachment_indices.iter().enumerate() {
            if *index != ATTACHMENT_UNUSED {
                descriptor_bindings[last_binding] = i as u32;
                last_binding += 1;
            }
        }
    }
    (attachment_indices, descriptor_bindings)
}

/// `chooseInputImageLayout`
fn choose_input_image_layout(group_params: &GroupParams) -> vk::ImageLayout {
    if group_params.rendering_type == RenderingType::DynamicRendering {
        // use general layout for local reads for some tests
        if group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
            return vk::ImageLayout::GENERAL;
        }
        return vk::ImageLayout::RENDERING_LOCAL_READ;
    }
    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
}

/// `beginSecondaryCmdBuffer`; the input attachment indices (when given) are chained on the inheritance info itself, where the spec says they extend it, not behind the rendering info as upstream does.
fn begin_secondary_cmd_buffer(
    device: &Device,
    sec_cmd_buffer: vk::CommandBuffer,
    color_attachment_formats: &[vk::Format],
    additional_input_indices: Option<&[u32]>,
    usage_flags: vk::CommandBufferUsageFlags,
) -> Result<(), TestError> {
    let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
        .flags(vk::RenderingFlags::empty())
        .view_mask(0)
        .color_attachment_formats(color_attachment_formats)
        .depth_attachment_format(vk::Format::UNDEFINED)
        .stencil_attachment_format(vk::Format::UNDEFINED)
        .rasterization_samples(vk::SampleCountFlags::_1);
    let mut input_attachment_index_info = vk::RenderingInputAttachmentIndexInfo::builder()
        .color_attachment_input_indices(additional_input_indices.unwrap_or(&[]));
    let mut inheritance_info = vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
    if additional_input_indices.is_some() {
        inheritance_info = inheritance_info.push_next(&mut input_attachment_index_info);
    }
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(usage_flags | vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
        .inheritance_info(&inheritance_info);
    unsafe { device.begin_command_buffer(sec_cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")
}

fn program_for(dynamic: bool, count: u32) -> BinaryCollection {
    match (dynamic, count) {
        (false, 1) => SPARSE_FILL_RP_1.programs,
        (false, 3) => SPARSE_FILL_RP_3.programs,
        (false, 7) => SPARSE_FILL_RP_7.programs,
        (false, 15) => SPARSE_FILL_RP_15.programs,
        (false, 31) => SPARSE_FILL_RP_31.programs,
        (false, 63) => SPARSE_FILL_RP_63.programs,
        (false, 127) => SPARSE_FILL_RP_127.programs,
        (true, 1) => SPARSE_FILL_DYN_1.programs,
        (true, 3) => SPARSE_FILL_DYN_3.programs,
        (true, 7) => SPARSE_FILL_DYN_7.programs,
        (true, 15) => SPARSE_FILL_DYN_15.programs,
        (true, 31) => SPARSE_FILL_DYN_31.programs,
        (true, 63) => SPARSE_FILL_DYN_63.programs,
        (true, 127) => SPARSE_FILL_DYN_127.programs,
        _ => unreachable!("the group registers only the counts the manifest has"),
    }
}

struct InputAttachmentSparseFillingTest {
    name: String,
    params: TestParams,
}

impl TestCase for InputAttachmentSparseFillingTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let limits = &context.get_device_properties().limits;
        let count = self.params.active_input_attachment_count;

        match self.params.group_params.rendering_type {
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2")?,
            RenderingType::DynamicRendering => {
                context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;
                if 2 * count > limits.max_color_attachments {
                    return Err(TestError::NotSupported(
                        "Required number of color attachments not supported.".to_string(),
                    ));
                }
            }
            RenderingType::Legacy => {}
        }

        if 2 * count > limits.max_per_stage_descriptor_input_attachments {
            return Err(TestError::NotSupported(
                "Input attachment count including unused elements exceeds maxPerStageDescriptorInputAttachments"
                    .to_string(),
            ));
        }

        if 2 * count > limits.max_per_stage_resources {
            return Err(TestError::NotSupported(
                "Input attachment count including unused elements exceeds maxPerStageResources".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        program_for(
            self.params.group_params.rendering_type == RenderingType::DynamicRendering,
            self.params.active_input_attachment_count,
        )
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InputAttachmentSparseFillingInstance {
            context,
            params: self.params,
        })
    }
}

struct InputAttachmentSparseFillingInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// Everything the record functions read, built once per `iterate`.
struct Resources<'a> {
    input_images: Vec<ImageWithMemory<'a>>,
    input_image_views: Vec<Unique<'a, vk::ImageView>>,
    input_image_read_layout: vk::ImageLayout,
    output_image: ImageWithMemory<'a>,
    output_buffer: BufferWithMemory<'a>,
    vertex_buffer: BufferWithMemory<'a>,
    vertex_count: u32,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    pipeline_layout: vk::PipelineLayout,
    pipeline: vk::Pipeline,
}

impl TestInstance for InputAttachmentSparseFillingInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let p = self.params;
        let rendering_type = p.group_params.rendering_type;
        let dynamic_rendering = rendering_type == RenderingType::DynamicRendering;
        let count = p.active_input_attachment_count;
        let render_size = vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        };
        let color_range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let vertices = create_fullscreen_triangle();
        let input_image_read_layout = choose_input_image_layout(&p.group_params);

        // Create input attachment images with image views
        let mut input_usage = vk::ImageUsageFlags::INPUT_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST;
        if dynamic_rendering {
            input_usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
        }
        let input_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(vk::Format::R8G8B8A8_UNORM)
            .extent(render_size)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(input_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let mut input_images = Vec::new();
        let mut input_image_views = Vec::new();
        for _ in 0..count {
            let image = ImageWithMemory::new(device, allocator, input_image_info, MemoryRequirement::ANY)?;
            input_image_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                vk::Format::R8G8B8A8_UNORM,
                color_range,
            )?);
            input_images.push(image);
        }

        let output_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(vk::Format::R32G32_UINT)
            .extent(render_size)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let output_image = ImageWithMemory::new(device, allocator, output_image_info, MemoryRequirement::ANY)?;
        let output_image_view = make_image_view(
            device,
            output_image.get(),
            vk::ImageViewType::_2D,
            vk::Format::R32G32_UINT,
            color_range,
        )?;

        let output_pixel_size = map_vk_format(vk::Format::R32G32_UINT)
            .and_then(|f| f.pixel_size())
            .ok_or_else(|| TestError::NotPorted("pixel size of R32G32_UINT".to_string()))?
            as u64;
        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                RENDER_SIZE as u64 * RENDER_SIZE as u64 * output_pixel_size,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create render pass
        let render_pass = match rendering_type {
            RenderingType::Legacy | RenderingType::RenderPass2 => Some(self.create_render_pass()?),
            RenderingType::DynamicRendering => None,
        };
        let raw_render_pass = render_pass
            .as_ref()
            .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);

        let mut descriptor_image_infos = vec![
            vk::DescriptorImageInfo::builder()
                .sampler(vk::Sampler::null())
                .image_view(*output_image_view)
                .image_layout(vk::ImageLayout::GENERAL)
                .build(),
        ];
        let mut framebuffer_image_views = Vec::new();
        for view in &input_image_views {
            framebuffer_image_views.push(**view);
            descriptor_image_infos.push(
                vk::DescriptorImageInfo::builder()
                    .sampler(vk::Sampler::null())
                    .image_view(**view)
                    .image_layout(input_image_read_layout)
                    .build(),
            );
        }

        // Create framebuffer if renderpass handle is valid
        let framebuffer = render_pass
            .as_ref()
            .map(|render_pass| {
                make_framebuffer(
                    device,
                    **render_pass,
                    &framebuffer_image_views,
                    RENDER_SIZE,
                    RENDER_SIZE,
                    1,
                )
            })
            .transpose()?;

        // Create pipeline layout
        let mut layout_builder = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT);
        for _ in 0..count {
            layout_builder =
                layout_builder.add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Update descriptor set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, count)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let mut writes = vec![
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&descriptor_image_infos[0..1])
                .build(),
        ];
        for i in 1..descriptor_image_infos.len() {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(i as u32)
                    .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                    .image_info(&descriptor_image_infos[i..i + 1])
                    .build(),
            );
        }
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let program = program_for(dynamic_rendering, count);
        let vertex_module = create_shader_module(device, program.get("vertex")?)?;
        let fragment_module = create_shader_module(device, program.get("fragment")?)?;

        // Create pipelines
        let pipeline = self.create_pipeline(*pipeline_layout, raw_render_pass, *vertex_module, *fragment_module)?;

        // Create vertex buffer
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let resources = Resources {
            input_images,
            input_image_views,
            input_image_read_layout,
            output_image,
            output_buffer,
            vertex_buffer,
            vertex_count: vertices.len() as u32,
            descriptor_set,
            pipeline_layout: *pipeline_layout,
            pipeline: *pipeline,
        };

        // Create command buffer
        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let _secondary = match rendering_type {
            RenderingType::Legacy | RenderingType::RenderPass2 => {
                let framebuffer = framebuffer
                    .as_ref()
                    .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);
                self.create_command_buffer(&resources, *command_buffer, raw_render_pass, framebuffer)?;
                None
            }
            RenderingType::DynamicRendering => {
                self.create_command_buffer_dynamic_rendering(&resources, *command_pool, *command_buffer)?
            }
        };

        submit_commands_and_wait(device, queue, *command_buffer)?;

        self.verify_image(&resources)
    }
}

impl InputAttachmentSparseFillingInstance<'_> {
    /// `createRenderPass<...>`
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let p = self.params;
        let rendering_type = p.group_params.rendering_type;
        let (attachment_indices, _) = generate_input_attachment_params(
            rendering_type,
            p.active_input_attachment_count,
            2 * p.active_input_attachment_count,
        );

        let attachment_descriptions = vec![
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: vk::Format::R8G8B8A8_UNORM,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::LOAD,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::GENERAL,
                final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            };
            p.active_input_attachment_count as usize
        ];

        if rendering_type == RenderingType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

            let attachments2: Vec<vk::AttachmentDescription2> = attachment_descriptions
                .iter()
                .map(|a| vk::AttachmentDescription2 {
                    s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                    next: std::ptr::null(),
                    flags: a.flags,
                    format: a.format,
                    samples: a.samples,
                    load_op: a.load_op,
                    store_op: a.store_op,
                    stencil_load_op: a.stencil_load_op,
                    stencil_store_op: a.stencil_store_op,
                    initial_layout: a.initial_layout,
                    final_layout: a.final_layout,
                })
                .collect();
            let refs2: Vec<vk::AttachmentReference2> = attachment_indices
                .iter()
                .map(|&attachment| vk::AttachmentReference2 {
                    s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                    next: std::ptr::null(),
                    attachment,
                    layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                })
                .collect();
            let subpass = vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: refs2.len() as u32,
                input_attachments: refs2.as_ptr(),
                color_attachment_count: 0,
                color_attachments: std::ptr::null(),
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: std::ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            };
            let dependency = vk::SubpassDependency2 {
                s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                next: std::ptr::null(),
                src_subpass: 0,
                dst_subpass: vk::SUBPASS_EXTERNAL,
                src_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                dst_stage_mask: vk::PipelineStageFlags::DRAW_INDIRECT,
                src_access_mask: vk::AccessFlags::SHADER_WRITE,
                dst_access_mask: vk::AccessFlags::INDIRECT_COMMAND_READ,
                dependency_flags: vk::DependencyFlags::empty(),
                view_offset: 0,
            };
            let info = vk::RenderPassCreateInfo2 {
                s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                next: std::ptr::null(),
                flags: vk::RenderPassCreateFlags::empty(),
                attachment_count: attachments2.len() as u32,
                attachments: attachments2.as_ptr(),
                subpass_count: 1,
                subpasses: &subpass,
                dependency_count: 1,
                dependencies: &dependency,
                correlated_view_mask_count: 0,
                correlated_view_masks: std::ptr::null(),
            };
            let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
            return Ok(Unique::new(device, handle));
        }

        let refs: Vec<vk::AttachmentReference> = attachment_indices
            .iter()
            .map(|&attachment| vk::AttachmentReference {
                attachment,
                layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            })
            .collect();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .input_attachments(&refs)
            .build()];
        let dependencies = [vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: vk::SUBPASS_EXTERNAL,
            src_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
            dst_stage_mask: vk::PipelineStageFlags::DRAW_INDIRECT,
            src_access_mask: vk::AccessFlags::SHADER_WRITE,
            dst_access_mask: vk::AccessFlags::INDIRECT_COMMAND_READ,
            dependency_flags: vk::DependencyFlags::empty(),
        }];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// The `GraphicsPipelineWrapper` setup of the constructor, monolithic.
    fn create_pipeline(
        &self,
        layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
        vertex_module: vk::ShaderModule,
        fragment_module: vk::ShaderModule,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use std::mem::offset_of;

        let device = self.context.get_device();
        let p = self.params;
        let dynamic_rendering = render_pass == vk::RenderPass::null();

        let binding = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<Vertex>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: offset_of!(Vertex, uv) as u32,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&binding)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);

        let viewports = [viewport(0.0, 0.0, RENDER_SIZE as f32, RENDER_SIZE as f32, 0.0, 1.0)];
        let scissors = [rect_2d(RENDER_SIZE, RENDER_SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();

        let color_attachments_count = (if dynamic_rendering {
            2 * p.active_input_attachment_count
        } else {
            1
        }) as usize;
        let color_blend_attachment_states = vec![
            vk::PipelineColorBlendAttachmentState::builder()
                .color_write_mask(vk::ColorComponentFlags::all())
                .build();
            color_attachments_count
        ];
        let color_blend_state =
            vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachment_states);

        let (input_attachments, _) = generate_input_attachment_params(
            p.group_params.rendering_type,
            p.active_input_attachment_count,
            2 * p.active_input_attachment_count,
        );
        let color_attachment_formats: Vec<vk::Format> = (0..color_attachments_count)
            .map(|index| {
                if dynamic_rendering && input_attachments[index] != ATTACHMENT_UNUSED {
                    vk::Format::R8G8B8A8_UNORM
                } else {
                    vk::Format::UNDEFINED
                }
            })
            .collect();
        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_attachment_formats)
            .depth_attachment_format(vk::Format::UNDEFINED)
            .stencil_attachment_format(vk::Format::UNDEFINED);
        let mut rendering_input_attachment_index_info =
            vk::RenderingInputAttachmentIndexInfo::builder().color_attachment_input_indices(&input_attachments);

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(fragment_module)
                .name(b"main\0")
                .build(),
        ];
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        if dynamic_rendering {
            info = info
                .push_next(&mut rendering_create_info)
                .push_next(&mut rendering_input_attachment_index_info);
        }

        crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
    }

    /// `createCommandBuffer<RenderpassSubpass>`
    fn create_command_buffer(
        &self,
        resources: &Resources<'_>,
        cmd: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        begin_command_buffer(device, cmd)?;

        self.pre_render_commands(resources, cmd);

        // Render pass does not use clear values - input images were prepared beforehand
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .build();
        let render_pass2 = self.params.group_params.rendering_type == RenderingType::RenderPass2;
        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(cmd, &begin_info, &subpass_begin_info) };
        } else {
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
        }

        self.draw_commands(resources, cmd);

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(cmd, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(cmd) };
        }

        self.post_render_commands(resources, cmd);

        end_command_buffer(device, cmd)
    }

    /// `createCommandBufferDynamicRendering`. Returns the secondary command buffer, which has to outlive the submission.
    fn create_command_buffer_dynamic_rendering(
        &self,
        resources: &Resources<'_>,
        command_pool: vk::CommandPool,
        cmd: vk::CommandBuffer,
    ) -> Result<Option<UniqueCommandBuffer<'_>>, TestError> {
        use vulkanalia::vk::{DeviceV1_3, KhrDynamicRenderingLocalReadExtensionDeviceCommands};

        let device = self.context.get_device();
        let p = self.params;

        let (input_attachments, _) = generate_input_attachment_params(
            p.group_params.rendering_type,
            p.active_input_attachment_count,
            2 * p.active_input_attachment_count,
        );
        let rendering_input_attachment_index_info =
            vk::RenderingInputAttachmentIndexInfo::builder().color_attachment_input_indices(&input_attachments);

        let color_attachment_count = 2 * p.active_input_attachment_count as usize;
        let mut color_attachment_formats = vec![vk::Format::UNDEFINED; color_attachment_count];
        let mut color_attachments = vec![
            vk::RenderingAttachmentInfo::builder()
                .image_view(vk::ImageView::null())
                .image_layout(resources.input_image_read_layout)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .resolve_image_view(vk::ImageView::null())
                .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(vk::ClearValue {
                    color: vk::ClearColorValue { uint32: [0, 0, 0, 0] }
                })
                .build();
            color_attachment_count
        ];
        let mut image_view_index = 0;
        for (index, input_attachment) in input_attachments.iter().enumerate() {
            if *input_attachment == ATTACHMENT_UNUSED {
                continue;
            }
            color_attachments[index].image_view = *resources.input_image_views[image_view_index];
            color_attachment_formats[index] = vk::Format::R8G8B8A8_UNORM;
            image_view_index += 1;
        }

        let make_rendering_info = |flags: vk::RenderingFlags| {
            vk::RenderingInfo::builder()
                .flags(flags)
                .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments)
        };

        let mut secondary = None;
        if p.group_params
            .secondary_cmd_buffer_completely_contains_dynamic_renderpass
        {
            let sec_cmd = allocate_command_buffer(device, command_pool, vk::CommandBufferLevel::SECONDARY)?;

            // record secondary command buffer
            begin_secondary_cmd_buffer(
                device,
                *sec_cmd,
                &color_attachment_formats,
                None,
                vk::CommandBufferUsageFlags::empty(),
            )?;
            unsafe {
                device.cmd_begin_rendering(*sec_cmd, &make_rendering_info(vk::RenderingFlags::empty()));
                device.cmd_set_rendering_input_attachment_indices_khr(*sec_cmd, &rendering_input_attachment_index_info);
            }
            self.draw_commands(resources, *sec_cmd);
            unsafe { device.cmd_end_rendering(*sec_cmd) };
            end_command_buffer(device, *sec_cmd)?;

            // record primary command buffer
            begin_command_buffer(device, cmd)?;
            self.pre_render_commands(resources, cmd);
            unsafe { device.cmd_execute_commands(cmd, &[*sec_cmd]) };
            self.post_render_commands(resources, cmd);
            end_command_buffer(device, cmd)?;
            secondary = Some(sec_cmd);
        } else if p.group_params.use_secondary_cmd_buffer {
            let sec_cmd = allocate_command_buffer(device, command_pool, vk::CommandBufferLevel::SECONDARY)?;

            // record secondary command buffer
            begin_secondary_cmd_buffer(
                device,
                *sec_cmd,
                &color_attachment_formats,
                Some(input_attachments.as_slice()),
                vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE,
            )?;
            self.draw_commands(resources, *sec_cmd);
            end_command_buffer(device, *sec_cmd)?;

            // record primary command buffer
            begin_command_buffer(device, cmd)?;
            self.pre_render_commands(resources, cmd);
            unsafe {
                device.cmd_begin_rendering(
                    cmd,
                    &make_rendering_info(vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS),
                );
                device.cmd_set_rendering_input_attachment_indices_khr(cmd, &rendering_input_attachment_index_info);
                device.cmd_execute_commands(cmd, &[*sec_cmd]);
                device.cmd_end_rendering(cmd);
            }
            self.post_render_commands(resources, cmd);
            end_command_buffer(device, cmd)?;
            secondary = Some(sec_cmd);
        } else {
            begin_command_buffer(device, cmd)?;
            self.pre_render_commands(resources, cmd);
            unsafe {
                device.cmd_begin_rendering(cmd, &make_rendering_info(vk::RenderingFlags::empty()));
                device.cmd_set_rendering_input_attachment_indices_khr(cmd, &rendering_input_attachment_index_info);
            }
            self.draw_commands(resources, cmd);
            unsafe { device.cmd_end_rendering(cmd) };
            self.post_render_commands(resources, cmd);
            end_command_buffer(device, cmd)?;
        }
        Ok(secondary)
    }

    /// `preRenderCommands`
    fn pre_render_commands(&self, resources: &Resources<'_>, cmd: vk::CommandBuffer) {
        let device = self.context.get_device();
        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let barrier = |src_stage: vk::PipelineStageFlags,
                       dst_stage: vk::PipelineStageFlags,
                       image_barrier: vk::ImageMemoryBarrier| unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
        };
        let output_image = resources.output_image.get();

        // clear output image (rg16ui) to (0,0), set image layout to GENERAL
        barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                output_image,
                range,
            ),
        );
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                output_image,
                vk::ImageLayout::GENERAL,
                &vk::ClearColorValue { uint32: [0, 0, 0, 0] },
                &[range],
            )
        };
        barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                output_image,
                range,
            ),
        );

        let input_image_layout = if self.params.group_params.rendering_type == RenderingType::DynamicRendering {
            resources.input_image_read_layout
        } else {
            vk::ImageLayout::GENERAL
        };

        // clear all input attachments (rgba8) to (1,1,1,1), set image layout to GENERAL or LOCAL_READ
        for input_image in &resources.input_images {
            let image = input_image.get();
            barrier(
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::MEMORY_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    image,
                    range,
                ),
            );
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    image,
                    vk::ImageLayout::GENERAL,
                    &vk::ClearColorValue {
                        float32: [1.0, 1.0, 1.0, 1.0],
                    },
                    &[range],
                )
            };
            barrier(
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    vk::ImageLayout::GENERAL,
                    input_image_layout,
                    image,
                    range,
                ),
            );
        }
    }

    /// `drawCommands`
    fn draw_commands(&self, resources: &Resources<'_>, cmd: vk::CommandBuffer) {
        let device = self.context.get_device();
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, resources.pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                resources.pipeline_layout,
                0,
                &[resources.descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[resources.vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, resources.vertex_count, 1, 0, 0);
        }
    }

    /// `postRenderCommands`, i.e. `copyImageToBuffer` from SHADER_WRITE in the GENERAL layout.
    fn post_render_commands(&self, resources: &Resources<'_>, cmd: vk::CommandBuffer) {
        let device = self.context.get_device();
        let image = resources.output_image.get();
        let buffer = resources.output_buffer.get();
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            image,
            vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            },
        );
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            },
        };
        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(buffer)
            .offset(0)
            .size(vk::WHOLE_SIZE)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            device.cmd_copy_image_to_buffer(cmd, image, vk::ImageLayout::GENERAL, buffer, &[region]);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `verifyImage`
    fn verify_image(&self, resources: &Resources<'_>) -> Result<TestStatus, TestError> {
        let device = self.context.get_device();
        invalidate_alloc(device, resources.output_buffer.get_allocation())?;

        let format = map_vk_format(vk::Format::R32G32_UINT)
            .ok_or_else(|| TestError::NotPorted("tcu format of R32G32_UINT".to_string()))?;
        let size = RENDER_SIZE as usize * RENDER_SIZE as usize * 8;
        let data = unsafe { std::slice::from_raw_parts(resources.output_buffer.get_allocation().get_host_ptr(), size) };
        let result_access = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], data);

        // Check the unused image data hasn't changed.
        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                let color = result_access.get_pixel_uint(x, y, 0);
                if color[0] != self.params.active_input_attachment_count {
                    return Ok(TestStatus::fail("Wrong attachment count"));
                }
                if color[1] != self.params.active_input_attachment_count {
                    return Ok(TestStatus::fail("Wrong active attachment count"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createRenderPassUnusedAttachmentSparseFillingTests`
pub fn create_unused_attachment_sparse_filling_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("attachment_sparse_filling");

    for active_input_attachment_count in [1u32, 3, 7, 15, 31, 63, 127] {
        group.add_child(Box::new(InputAttachmentSparseFillingTest {
            name: format!("input_attachment_{active_input_attachment_count}"),
            params: TestParams {
                group_params,
                active_input_attachment_count,
            },
        }) as Box<dyn TestCase>);
    }

    group
}
