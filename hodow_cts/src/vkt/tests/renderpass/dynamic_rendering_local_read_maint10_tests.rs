// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingLocalReadMaint10Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The pipelines are monolithic and built without `makeGraphicsPipeline`; the shaders are
// manifest cases (`scripts/gen_local_read_m10_manifest.py`), one per combination of aspects, attachment count, multisample, sample id and
// feedback pattern, found through `local_read_m10_programs::programs_for`. The image comparison log is dropped, and the depth/stencil
// comparison of `tcu::dsThresholdCompare` is a per-pixel loop.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, InstanceV1_1, KhrDynamicRenderingLocalReadExtensionDeviceCommands};

use super::local_read_m10_programs::programs_for;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::random::Random;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, get_depth_copy_format, get_stencil_copy_format, make_buffer_image_copy, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const PC_SIZE: u32 = 16;
const PC_STAGES: vk::ShaderStageFlags = vk::ShaderStageFlags::FRAGMENT;

#[derive(Clone)]
struct TestParams {
    samples: vk::SampleCountFlags,
    att_format: vk::Format,
    feedback: Vec<bool>,
    sample_id: Option<u32>,
    general_layout: bool,
}

#[derive(Clone, Copy)]
struct Aspects {
    color: bool,
    depth: bool,
    stencil: bool,
}

impl TestParams {
    fn is_multi_sample(&self) -> bool {
        self.samples != vk::SampleCountFlags::_1
    }

    fn sample_count(&self) -> u32 {
        self.samples.bits()
    }

    fn aspects(&self) -> Aspects {
        match self.att_format {
            vk::Format::D16_UNORM => Aspects {
                color: false,
                depth: true,
                stencil: false,
            },
            vk::Format::S8_UINT => Aspects {
                color: false,
                depth: false,
                stencil: true,
            },
            vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT => Aspects {
                color: false,
                depth: true,
                stencil: true,
            },
            _ => Aspects {
                color: true,
                depth: false,
                stencil: false,
            },
        }
    }

    fn test_aspect_flags(&self) -> vk::ImageAspectFlags {
        let aspects = self.aspects();
        let mut flags = vk::ImageAspectFlags::empty();
        if aspects.color {
            flags |= vk::ImageAspectFlags::COLOR;
        }
        if aspects.depth {
            flags |= vk::ImageAspectFlags::DEPTH;
        }
        if aspects.stencil {
            flags |= vk::ImageAspectFlags::STENCIL;
        }
        flags
    }

    fn image_usage(&self) -> vk::ImageUsageFlags {
        let mut usage = if self.aspects().color {
            vk::ImageUsageFlags::COLOR_ATTACHMENT
        } else {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        };
        if self.is_multi_sample() {
            usage |= vk::ImageUsageFlags::SAMPLED;
        }
        usage
            | vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
    }

    fn extent(&self) -> vk::Extent3D {
        vk::Extent3D {
            width: 8,
            height: 8,
            depth: 1,
        }
    }

    fn expanded_extent(&self) -> vk::Extent3D {
        let mut extent = self.extent();
        extent.width *= self.sample_count();
        extent
    }

    fn image_create_info(&self) -> vk::ImageCreateInfo {
        vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: self.att_format,
            extent: self.extent(),
            mip_levels: 1,
            array_layers: 1,
            samples: self.samples,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: self.image_usage(),
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn att_count(&self) -> u32 {
        self.feedback.len() as u32
    }

    fn total_att_count(&self) -> u32 {
        let all_concurrent = self.feedback.iter().all(|&loop_| loop_);
        self.att_count() * if all_concurrent { 1 } else { 2 }
    }

    fn total_sample_count(&self) -> u32 {
        let extent = self.expanded_extent();
        extent.width * extent.height * extent.depth
    }

    fn random_seed(&self) -> u32 {
        let mut seed = ((self.att_format.as_raw() as u32) << 24) | (self.sample_count() << 16);
        for (i, &loop_) in self.feedback.iter().enumerate() {
            seed |= u32::from(loop_) << i;
        }
        seed
    }

    fn depth_stencil_input_attachment_offset(&self) -> u32 {
        0
    }

    fn output_att_for_att(&self, att_index: u32) -> u32 {
        if self.feedback[att_index as usize] {
            att_index
        } else {
            att_index + self.att_count()
        }
    }

    fn any_loop(&self) -> bool {
        self.feedback.iter().any(|&loop_| loop_)
    }

    fn program_key(&self) -> String {
        let aspects = self.aspects();
        let kind = match (aspects.color, aspects.depth, aspects.stencil) {
            (true, _, _) => "color",
            (_, true, false) => "d",
            (_, false, true) => "s",
            _ => "ds",
        };
        format!(
            "{kind}_samples_{}_{}{}",
            self.sample_count(),
            feedback_case_name(&self.feedback),
            self.sample_id.map_or(String::new(), |id| format!("_sample_{id}"))
        )
    }
}

fn feedback_case_name(feedback: &[bool]) -> String {
    let mut name = "loop_".to_string();
    for &loop_ in feedback {
        name.push(if loop_ { 'Y' } else { 'N' });
    }
    name
}

fn format_simple_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R8G8B8A8_UNORM => "r8g8b8a8_unorm",
        vk::Format::D16_UNORM => "d16_unorm",
        vk::Format::S8_UINT => "s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d32_sfloat_s8_uint",
    }
}

struct DrlrFeedbackLoopCase {
    name: String,
    params: TestParams,
}

fn drlr_vulkan14_properties(context: &Context<'_>) -> vk::PhysicalDeviceVulkan14Properties {
    let mut properties14 = vk::PhysicalDeviceVulkan14Properties::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties14);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties14
}

impl TestCase for DrlrFeedbackLoopCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DRLRFeedbackLoopCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let p = &self.params;
        context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;
        context.require_device_functionality("VK_KHR_maintenance10")?;

        let aspects = p.aspects();
        if aspects.stencil {
            context.require_device_functionality("VK_EXT_shader_stencil_export")?;
        }

        let pre_14 = context.api_version() < (1, 4, 0);
        let properties14 = if pre_14 {
            None
        } else {
            Some(drlr_vulkan14_properties(context))
        };
        let drlr_depth_stencil = properties14
            .as_ref()
            .is_none_or(|props| props.dynamic_rendering_local_read_depth_stencil_attachments != vk::FALSE);
        let drlr_multisampled = properties14
            .as_ref()
            .is_none_or(|props| props.dynamic_rendering_local_read_multisampled_attachments != vk::FALSE);

        if (aspects.depth || aspects.stencil) && !drlr_depth_stencil {
            return Err(TestError::NotSupported(
                "Reading depth/stencil input attachments in dynamic rendering not supported".to_string(),
            ));
        }

        if p.is_multi_sample() && context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
        }

        if p.is_multi_sample() && !drlr_multisampled {
            return Err(TestError::NotSupported(
                "Reading multisampled input attachments in dynamic rendering not supported".to_string(),
            ));
        }

        let image_info = p.image_create_info();
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                image_info.format,
                image_info.image_type,
                image_info.tiling,
                image_info.usage,
                image_info.flags,
            )
        };
        if matches!(result, Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED)) {
            return Err(TestError::NotSupported(
                "Format does not support the required parameters".to_string(),
            ));
        }
        let format_properties = result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        if !format_properties.sample_counts.contains(image_info.samples) {
            return Err(TestError::NotSupported(
                "Format does not support the required sample count".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        programs_for(&self.params.program_key()).unwrap_or_else(|| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrlrFeedbackLoopInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct DrlrFeedbackLoopInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for DrlrFeedbackLoopInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_feedback_loop(self.context, &self.params)
    }
}

fn ptr_or_null<T>(items: &[T]) -> *const T {
    if items.is_empty() {
        std::ptr::null()
    } else {
        items.as_ptr()
    }
}

fn push_constant_bytes(values: [i32; 4]) -> [u8; 16] {
    let mut bytes = [0u8; 16];
    for (chunk, value) in bytes.chunks_exact_mut(4).zip(values) {
        chunk.copy_from_slice(&value.to_ne_bytes());
    }
    bytes
}

fn write_floats(buffer: &BufferWithMemory<'_>, device: &Device, values: &[f32]) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            values.as_ptr().cast::<u8>(),
            alloc.get_host_ptr(),
            std::mem::size_of_val(values),
        )
    };
    flush_alloc(device, alloc)
}

/// `makeRenderingAttachmentInfo`
fn make_rendering_attachment_info(
    view: vk::ImageView,
    layout: vk::ImageLayout,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
) -> vk::RenderingAttachmentInfo {
    vk::RenderingAttachmentInfo {
        s_type: vk::StructureType::RENDERING_ATTACHMENT_INFO,
        next: std::ptr::null(),
        image_view: view,
        image_layout: layout,
        resolve_mode: vk::ResolveModeFlags::NONE,
        resolve_image_view: vk::ImageView::null(),
        resolve_image_layout: vk::ImageLayout::UNDEFINED,
        load_op,
        store_op,
        clear_value: vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        },
    }
}

/// `fbWritesBarrier`
fn fb_writes_barrier(device: &Device, cmd: vk::CommandBuffer) {
    let src_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
    let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE
        | vk::AccessFlags::COLOR_ATTACHMENT_READ
        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
        | vk::AccessFlags::SHADER_READ
        | vk::AccessFlags::INPUT_ATTACHMENT_READ;
    let src_stage = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
    let dst_stage = src_stage | vk::PipelineStageFlags::FRAGMENT_SHADER;
    let barrier = make_memory_barrier(src_access, dst_access);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::BY_REGION,
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };
}

fn image_barriers(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        )
    };
}

fn write_buffer_descriptor(device: &Device, set: vk::DescriptorSet, binding: u32, buffer: vk::Buffer) {
    let info = vk::DescriptorBufferInfo {
        buffer,
        offset: 0,
        range: vk::WHOLE_SIZE,
    };
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
        image_info: std::ptr::null(),
        buffer_info: &info,
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

fn write_image_descriptor(
    device: &Device,
    set: vk::DescriptorSet,
    binding: u32,
    descriptor_type: vk::DescriptorType,
    sampler: vk::Sampler,
    view: vk::ImageView,
    layout: vk::ImageLayout,
) {
    let info = vk::DescriptorImageInfo {
        sampler,
        image_view: view,
        image_layout: layout,
    };
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type,
        image_info: &info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

struct PipelineSetup<'a> {
    layout: vk::PipelineLayout,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    extent: vk::Extent3D,
    samples: vk::SampleCountFlags,
    aspects: Aspects,
    color_formats: &'a [vk::Format],
    depth_format: vk::Format,
    stencil_format: vk::Format,
    blend_attachment_count: u32,
    input_index_info: Option<vk::RenderingInputAttachmentIndexInfo>,
}

fn make_pipeline<'a>(device: &'a Device, setup: &PipelineSetup<'_>) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(setup.vert)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(setup.frag)
            .name(b"main\0")
            .build(),
    ];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
    let viewports = [viewport(
        0.0,
        0.0,
        setup.extent.width as f32,
        setup.extent.height as f32,
        0.0,
        1.0,
    )];
    let scissors = [rect_2d(setup.extent.width, setup.extent.height)];
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
    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(setup.samples)
        .sample_shading_enable(false);

    let stencil_op_state = vk::StencilOpState {
        fail_op: vk::StencilOp::REPLACE,
        pass_op: vk::StencilOp::REPLACE,
        depth_fail_op: vk::StencilOp::REPLACE,
        compare_op: vk::CompareOp::ALWAYS,
        compare_mask: 0xff,
        write_mask: 0xff,
        reference: 0,
    };
    let mut depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
    if setup.aspects.depth {
        depth_stencil_state = depth_stencil_state
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS);
    }
    if setup.aspects.stencil {
        depth_stencil_state = depth_stencil_state
            .stencil_test_enable(true)
            .front(stencil_op_state)
            .back(stencil_op_state);
    }

    let blend_attachment_states = vec![
        vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build();
        setup.blend_attachment_count as usize
    ];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachment_states);

    let dynamic_states = [vk::DynamicState::SCISSOR];
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
        .view_mask(0)
        .color_attachment_formats(setup.color_formats)
        .depth_attachment_format(setup.depth_format)
        .stencil_attachment_format(setup.stencil_format);

    let mut input_index_info = setup.input_index_info;

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .dynamic_state(&dynamic_state)
        .layout(setup.layout)
        .render_pass(vk::RenderPass::null())
        .subpass(0)
        .base_pipeline_index(0)
        .push_next(&mut rendering_create_info);
    if let Some(input_index_info) = input_index_info.as_mut() {
        info = info.push_next(input_index_info);
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// The resources `DRLRFeedbackLoopInstance::iterate` builds for the multisample case, to expand a multisample image into single-sampled ones
struct CopyResources<'a> {
    set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _pool: Unique<'a, vk::DescriptorPool>,
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    _set_layout: Unique<'a, vk::DescriptorSetLayout>,
    _sampler: Unique<'a, vk::Sampler>,
}

/// `tcu::dsThresholdCompare`, per pixel: the depth within `threshold`, the stencil exactly
fn ds_matches(
    result: &ConstPixelBufferAccess<'_>,
    depth: bool,
    size: [u32; 3],
    threshold: f32,
    expected: &dyn Fn(u32, u32) -> f32,
) -> bool {
    for y in 0..size[1] {
        for x in 0..size[0] {
            let want = expected(x, y);
            let ok = if depth {
                (result.get_pix_depth(x, y, 0) - want).abs() <= threshold
            } else {
                result.get_pix_stencil(x, y, 0) == want as u32
            };
            if !ok {
                return false;
            }
        }
    }
    true
}

/// `DRLRFeedbackLoopInstance::iterate`
#[expect(
    clippy::explicit_counter_loop,
    reason = "mirrors upstream's index, which is also used for the attachment"
)]
fn run_feedback_loop(context: &Context<'_>, params: &TestParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let total_samples = params.total_sample_count();
    let att_count = params.att_count();
    let total_att_count = params.total_att_count();
    let aspects = params.aspects();
    let test_aspects = params.test_aspect_flags();
    let extent = params.extent();
    let expanded_extent = params.expanded_extent();
    let expanded_size = [expanded_extent.width, expanded_extent.height, expanded_extent.depth];
    let img_create_info = params.image_create_info();
    let is_multi_sample = params.is_multi_sample();
    let att_layout = if params.general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::RENDERING_LOCAL_READ
    };
    let sample_layout = if params.general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
    };
    let bind_point = vk::PipelineBindPoint::GRAPHICS;
    let tcu_att_format =
        map_vk_format(params.att_format).ok_or_else(|| TestError::InternalError("no texture format".to_string()))?;
    let depth_copy_format = if aspects.depth {
        get_depth_copy_format(params.att_format)
    } else {
        None
    };
    let stencil_copy_format = if aspects.stencil {
        get_stencil_copy_format(params.att_format)
    } else {
        None
    };

    let pc_range = vk::PushConstantRange {
        stage_flags: PC_STAGES,
        offset: 0,
        size: PC_SIZE,
    };
    let push_constants = push_constant_bytes([
        extent.width as i32,
        extent.height as i32,
        extent.depth as i32,
        params.sample_count() as i32,
    ]);

    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let ds_srr = make_image_subresource_range(test_aspects, 0, 1, 0, 1);
    let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
    let depth_srl = make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1);
    let stencil_srr = make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
    let stencil_srl = make_image_subresource_layers(vk::ImageAspectFlags::STENCIL, 0, 0, 1);

    let mut rnd = Random::new(params.random_seed());

    let mut color_images: Vec<ImageWithMemory<'_>> = Vec::new();
    let mut color_views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
    let mut ds_image: Option<ImageWithMemory<'_>> = None;
    let mut ds_view: Option<Unique<'_, vk::ImageView>> = None;
    let mut depth_view: Option<Unique<'_, vk::ImageView>> = None;
    let mut stencil_view: Option<Unique<'_, vk::ImageView>> = None;

    if aspects.color {
        for _ in 0..total_att_count {
            let image = ImageWithMemory::new(device, allocator, img_create_info, MemoryRequirement::ANY)?;
            color_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                img_create_info.format,
                color_srr,
            )?);
            color_images.push(image);
        }
    } else {
        let image = ImageWithMemory::new(device, allocator, img_create_info, MemoryRequirement::ANY)?;
        ds_view = Some(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            img_create_info.format,
            ds_srr,
        )?);
        if aspects.depth {
            depth_view = Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                img_create_info.format,
                depth_srr,
            )?);
        }
        if aspects.stencil {
            stencil_view = Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                img_create_info.format,
                stencil_srr,
            )?);
        }
        ds_image = Some(image);
    }

    let mut expanded_color_images: Vec<ImageWithMemory<'_>> = Vec::new();
    let mut expanded_color_views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
    let mut expanded_ds_image: Option<ImageWithMemory<'_>> = None;
    let mut expanded_ds_view: Option<Unique<'_, vk::ImageView>> = None;

    if is_multi_sample {
        let mut single_sample_create_info = img_create_info;
        single_sample_create_info.extent = expanded_extent;
        single_sample_create_info.samples = vk::SampleCountFlags::_1;
        single_sample_create_info.usage &= !vk::ImageUsageFlags::SAMPLED;

        if aspects.color {
            for _ in 0..att_count {
                let image = ImageWithMemory::new(device, allocator, single_sample_create_info, MemoryRequirement::ANY)?;
                expanded_color_views.push(make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    single_sample_create_info.format,
                    color_srr,
                )?);
                expanded_color_images.push(image);
            }
        } else {
            let image = ImageWithMemory::new(device, allocator, single_sample_create_info, MemoryRequirement::ANY)?;
            expanded_ds_view = Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                single_sample_create_info.format,
                ds_srr,
            )?);
            expanded_ds_image = Some(image);
        }
    }

    let mut load_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
    let mut load_buffers_data: Vec<Vec<[f32; 4]>> = Vec::new();
    {
        let load_buffer_size = u64::from(total_samples) * 16;
        for _ in 0..att_count {
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(load_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let mut values: Vec<[f32; 4]> = Vec::with_capacity(total_samples as usize);
            for _ in 0..total_samples {
                if aspects.color {
                    let r = rnd.get_float();
                    let g = rnd.get_float();
                    let b = rnd.get_float();
                    values.push([r, g, b, 1.0]);
                } else {
                    let depth = rnd.get_float();
                    let stencil = f32::from(rnd.get_uint8());
                    values.push([depth, stencil, 0.0, 0.0]);
                }
            }
            let flat: Vec<f32> = values.iter().flatten().copied().collect();
            write_floats(&buffer, device, &flat)?;
            load_buffers.push(buffer);
            load_buffers_data.push(values);
        }
    }

    let modifiers_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(32, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    write_floats(&modifiers_buffer, device, &[0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0])?;

    let mut verif_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
    {
        let verif_usage = vk::BufferUsageFlags::TRANSFER_DST;
        let mut push_verif_buffer = |pixel_size: u32| -> Result<(), TestError> {
            verif_buffers.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(u64::from(total_samples) * u64::from(pixel_size), verif_usage),
                MemoryRequirement::HOST_VISIBLE,
            )?);
            Ok(())
        };
        let pixel_size_of = |format: Option<crate::tcu::TextureFormat>| -> Result<u32, TestError> {
            format
                .and_then(|format| format.pixel_size())
                .ok_or_else(|| TestError::InternalError("no copy format".to_string()))
        };
        if aspects.color {
            let pixel_size = pixel_size_of(Some(tcu_att_format))?;
            for _ in 0..att_count {
                push_verif_buffer(pixel_size)?;
            }
        } else {
            if aspects.depth {
                push_verif_buffer(pixel_size_of(depth_copy_format)?)?;
            }
            if aspects.stencil {
                push_verif_buffer(pixel_size_of(stencil_copy_format)?)?;
            }
        }
    }

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_load_shader = create_shader_module(device, binaries.get("frag-load")?)?;
    let frag_copy_shader = if is_multi_sample {
        Some(create_shader_module(device, binaries.get("frag-copy")?)?)
    } else {
        None
    };
    let frag_modify_shader = create_shader_module(device, binaries.get("frag-modify")?)?;
    let frag_grad_shader = create_shader_module(device, binaries.get("frag-grad")?)?;

    let mut color_formats: Vec<vk::Format> = Vec::new();
    let mut rendering_depth_format = vk::Format::UNDEFINED;
    let mut rendering_stencil_format = vk::Format::UNDEFINED;
    if aspects.color {
        color_formats = vec![params.att_format; total_att_count as usize];
    }
    if aspects.depth {
        rendering_depth_format = params.att_format;
    }
    if aspects.stencil {
        rendering_stencil_format = params.att_format;
    }

    let mut depth_input_attachment_index = 0u32;
    let mut stencil_input_attachment_index = 0u32;
    let rendering_input_attachment_index_info = if aspects.depth || aspects.stencil {
        let mut next_ds_input_attachment_index = params.depth_stencil_input_attachment_offset();
        if aspects.depth {
            depth_input_attachment_index = next_ds_input_attachment_index;
            next_ds_input_attachment_index += 1;
        }
        if aspects.stencil {
            stencil_input_attachment_index = next_ds_input_attachment_index;
        }
        Some(vk::RenderingInputAttachmentIndexInfo {
            s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
            next: std::ptr::null(),
            color_attachment_count: 0,
            color_attachment_input_indices: std::ptr::null(),
            depth_input_attachment_index: if aspects.depth {
                &depth_input_attachment_index
            } else {
                std::ptr::null()
            },
            stencil_input_attachment_index: if aspects.stencil {
                &stencil_input_attachment_index
            } else {
                std::ptr::null()
            },
        })
    } else {
        None
    };

    let scissor = rect_2d(extent.width, extent.height);
    let expanded_scissor = rect_2d(expanded_extent.width, expanded_extent.height);

    // Load pipeline and related resources.
    let mut load_set_layout_builder = DescriptorSetLayoutBuilder::new();
    for _ in 0..att_count {
        load_set_layout_builder = load_set_layout_builder
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT);
    }
    let load_set_layout = load_set_layout_builder.build(device)?;
    let load_pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*load_set_layout], &[pc_range])?;
    let load_pipeline = make_pipeline(
        device,
        &PipelineSetup {
            layout: *load_pipeline_layout,
            vert: *vert_shader,
            frag: *frag_load_shader,
            extent,
            samples: params.samples,
            aspects,
            color_formats: &color_formats,
            depth_format: rendering_depth_format,
            stencil_format: rendering_stencil_format,
            blend_attachment_count: total_att_count,
            input_index_info: rendering_input_attachment_index_info,
        },
    )?;
    let load_descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, att_count)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let load_descriptor_set = make_descriptor_set(device, *load_descriptor_pool, *load_set_layout)?;
    for (i, buffer) in load_buffers.iter().enumerate() {
        write_buffer_descriptor(device, load_descriptor_set.get(), i as u32, buffer.get());
    }

    // Modification pipeline and related resources.
    let ds_input_count = u32::from(aspects.depth) + u32::from(aspects.stencil);
    let mut mod_set_layout_builder = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT);
    let mod_input_count = if aspects.color { att_count } else { ds_input_count };
    for _ in 0..mod_input_count {
        mod_set_layout_builder = mod_set_layout_builder
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
    }
    let mod_set_layout = mod_set_layout_builder.build(device)?;
    let mod_pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*mod_set_layout], &[pc_range])?;
    let mod_pipeline = make_pipeline(
        device,
        &PipelineSetup {
            layout: *mod_pipeline_layout,
            vert: *vert_shader,
            frag: *frag_modify_shader,
            extent,
            samples: params.samples,
            aspects,
            color_formats: &color_formats,
            depth_format: rendering_depth_format,
            stencil_format: rendering_stencil_format,
            blend_attachment_count: total_att_count,
            input_index_info: rendering_input_attachment_index_info,
        },
    )?;
    let mod_descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .add_type(vk::DescriptorType::INPUT_ATTACHMENT, mod_input_count)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let mod_descriptor_set = make_descriptor_set(device, *mod_descriptor_pool, *mod_set_layout)?;
    write_buffer_descriptor(device, mod_descriptor_set.get(), 0, modifiers_buffer.get());
    if aspects.color {
        for i in 0..att_count {
            write_image_descriptor(
                device,
                mod_descriptor_set.get(),
                i + 1,
                vk::DescriptorType::INPUT_ATTACHMENT,
                vk::Sampler::null(),
                *color_views[i as usize],
                att_layout,
            );
        }
    } else {
        let mut next_binding = 1u32;
        for view in [&depth_view, &stencil_view].into_iter().flatten() {
            write_image_descriptor(
                device,
                mod_descriptor_set.get(),
                next_binding,
                vk::DescriptorType::INPUT_ATTACHMENT,
                vk::Sampler::null(),
                **view,
                att_layout,
            );
            next_binding += 1;
        }
    }

    // Gradient pipeline.
    let grad_pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;
    let grad_pipeline = make_pipeline(
        device,
        &PipelineSetup {
            layout: *grad_pipeline_layout,
            vert: *vert_shader,
            frag: *frag_grad_shader,
            extent,
            samples: params.samples,
            aspects,
            color_formats: &color_formats,
            depth_format: rendering_depth_format,
            stencil_format: rendering_stencil_format,
            blend_attachment_count: total_att_count,
            input_index_info: rendering_input_attachment_index_info,
        },
    )?;

    // Copy pipeline and related resources, used in the multisample case to transform images to single-sample.
    let copy = if is_multi_sample {
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(0.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let copy_input_count = if aspects.color { att_count } else { ds_input_count };
        let mut set_layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..copy_input_count {
            set_layout_builder = set_layout_builder.add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            );
        }
        let set_layout = set_layout_builder.build(device)?;
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        // This pipeline will not use input attachments, so the input attachment index info stays out of the chain.
        let pipeline = make_pipeline(
            device,
            &PipelineSetup {
                layout: *pipeline_layout,
                vert: *vert_shader,
                frag: **frag_copy_shader
                    .as_ref()
                    .ok_or_else(|| TestError::InternalError("no copy shader".to_string()))?,
                extent: expanded_extent,
                samples: vk::SampleCountFlags::_1,
                aspects,
                color_formats: &color_formats,
                depth_format: rendering_depth_format,
                stencil_format: rendering_stencil_format,
                blend_attachment_count: total_att_count,
                input_index_info: None,
            },
        )?;

        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, copy_input_count)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;

        if aspects.color {
            for i in 0..att_count {
                let result_att_index = params.output_att_for_att(i);
                write_image_descriptor(
                    device,
                    set.get(),
                    i,
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    *sampler,
                    *color_views[result_att_index as usize],
                    sample_layout,
                );
            }
        } else {
            let mut next_binding = 0u32;
            // The depth and the stencil are sampled through views of one aspect each.
            for view in [&depth_view, &stencil_view].into_iter().flatten() {
                write_image_descriptor(
                    device,
                    set.get(),
                    next_binding,
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    *sampler,
                    **view,
                    sample_layout,
                );
                next_binding += 1;
            }
        }

        Some(CopyResources {
            set,
            _pool: pool,
            pipeline,
            pipeline_layout,
            _set_layout: set_layout,
            _sampler: sampler,
        })
    } else {
        None
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    let attachment_stages = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
    let attachment_access = vk::AccessFlags::COLOR_ATTACHMENT_READ
        | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;

    // Move images to the right layout.
    {
        let mut barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
        if aspects.color {
            for image in &color_images {
                barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    attachment_access,
                    vk::ImageLayout::UNDEFINED,
                    att_layout,
                    image.get(),
                    color_srr,
                ));
            }
        } else if let Some(image) = &ds_image {
            barriers.push(make_image_memory_barrier(
                vk::AccessFlags::empty(),
                attachment_access,
                vk::ImageLayout::UNDEFINED,
                att_layout,
                image.get(),
                ds_srr,
            ));
        }
        image_barriers(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            attachment_stages,
            &barriers,
        );
    }

    // In the simultaneous case, the first group of attachments is used both as an input attachment and as a write attachment concurrently,
    // so they need the flag.
    let attachment_flags_info = vk::RenderingAttachmentFlagsInfoKHR {
        s_type: vk::StructureType::RENDERING_ATTACHMENT_FLAGS_INFO_KHR,
        next: std::ptr::null(),
        flags: vk::RenderingAttachmentFlagsKHR::INPUT_ATTACHMENT_FEEDBACK,
    };
    let attachment_flags_ptr: *const std::ffi::c_void = if params.any_loop() {
        (&raw const attachment_flags_info).cast()
    } else {
        std::ptr::null()
    };

    // Prepare the images by loading data onto them with the load pipeline.
    {
        let mut color_att_infos: Vec<vk::RenderingAttachmentInfo> = Vec::new();
        let mut ds_att_infos: Vec<vk::RenderingAttachmentInfo> = Vec::new();

        if aspects.color {
            for view in &color_views {
                color_att_infos.push(make_rendering_attachment_info(
                    **view,
                    att_layout,
                    vk::AttachmentLoadOp::CLEAR,
                    vk::AttachmentStoreOp::STORE,
                ));
            }
            for (i, &loop_) in params.feedback.iter().enumerate() {
                if loop_ {
                    color_att_infos[i].next = attachment_flags_ptr;
                }
            }
        } else if let Some(view) = &ds_view {
            let mut ds_att_info = make_rendering_attachment_info(
                **view,
                att_layout,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
            );
            ds_att_info.next = attachment_flags_ptr;
            ds_att_infos.push(ds_att_info);
        }

        // All the scenarios require the concurrent rendering flag to signal that the attachment flag is explicit about feedback loops.
        let rendering_info = vk::RenderingInfo {
            s_type: vk::StructureType::RENDERING_INFO,
            next: std::ptr::null(),
            flags: vk::RenderingFlags::LOCAL_READ_CONCURRENT_ACCESS_CONTROL_KHR,
            render_area: scissor,
            layer_count: 1,
            view_mask: 0,
            color_attachment_count: color_att_infos.len() as u32,
            color_attachments: ptr_or_null(&color_att_infos),
            depth_attachment: if aspects.depth {
                ptr_or_null(&ds_att_infos)
            } else {
                std::ptr::null()
            },
            stencil_attachment: if aspects.stencil {
                ptr_or_null(&ds_att_infos)
            } else {
                std::ptr::null()
            },
        };

        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);
            if let Some(info) = &rendering_input_attachment_index_info {
                device.cmd_set_rendering_input_attachment_indices_khr(cmd, info);
            }
            device.cmd_bind_pipeline(cmd, bind_point, load_pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                bind_point,
                *load_pipeline_layout,
                0,
                &[load_descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_push_constants(cmd, *load_pipeline_layout, PC_STAGES, 0, &push_constants);
            device.cmd_set_scissor(cmd, 0, &[scissor]);
            device.cmd_draw(cmd, 4, 1, 0, 0);
        }
    }

    // Make sure all attachment writes are ready before the reads.
    fb_writes_barrier(device, cmd);

    // Read and modify the attachments using the modification pipeline.
    unsafe {
        device.cmd_bind_pipeline(cmd, bind_point, mod_pipeline.get());
        device.cmd_bind_descriptor_sets(
            cmd,
            bind_point,
            *mod_pipeline_layout,
            0,
            &[mod_descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_push_constants(cmd, *mod_pipeline_layout, PC_STAGES, 0, &push_constants);
        device.cmd_set_scissor(cmd, 0, &[scissor]);
        device.cmd_draw(cmd, 4, 1, 0, 0);
    }

    // Make sure all attachment writes are ready before subsequent writes.
    fb_writes_barrier(device, cmd);

    // Overwrite part of the framebuffer with a gradient, scissored to the right side.
    {
        let half_width = extent.width / 2;
        let right_side_scissor = vk::Rect2D {
            offset: vk::Offset2D {
                x: half_width as i32,
                y: 0,
            },
            extent: vk::Extent2D {
                width: half_width,
                height: extent.height,
            },
        };
        unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, grad_pipeline.get());
            device.cmd_push_constants(cmd, *grad_pipeline_layout, PC_STAGES, 0, &push_constants);
            device.cmd_set_scissor(cmd, 0, &[right_side_scissor]);
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_rendering(cmd);
        }
    }

    if let Some(copy) = &copy {
        // Expand multisample images to single-sample versions. Prepare attachments to be read.
        {
            let mut barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
            let src_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
            if aspects.color {
                for i in 0..att_count {
                    let result_att_index = params.output_att_for_att(i);
                    barriers.push(make_image_memory_barrier(
                        src_access,
                        vk::AccessFlags::SHADER_READ,
                        att_layout,
                        sample_layout,
                        color_images[result_att_index as usize].get(),
                        color_srr,
                    ));
                }
            } else if let Some(image) = &ds_image {
                barriers.push(make_image_memory_barrier(
                    src_access,
                    vk::AccessFlags::SHADER_READ,
                    att_layout,
                    sample_layout,
                    image.get(),
                    ds_srr,
                ));
            }
            image_barriers(
                device,
                cmd,
                attachment_stages,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                &barriers,
            );
        }

        // Prepare expanded images to be attachments.
        {
            let mut barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
            if aspects.color {
                for image in &expanded_color_images {
                    barriers.push(make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        attachment_access,
                        vk::ImageLayout::UNDEFINED,
                        att_layout,
                        image.get(),
                        color_srr,
                    ));
                }
            } else if let Some(image) = &expanded_ds_image {
                barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    attachment_access,
                    vk::ImageLayout::UNDEFINED,
                    att_layout,
                    image.get(),
                    ds_srr,
                ));
            }
            image_barriers(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                attachment_stages,
                &barriers,
            );
        }

        // Render and expand images. Only attCount images are used for the expanded views, and they are never input attachments.
        {
            let mut color_att_infos: Vec<vk::RenderingAttachmentInfo> = Vec::new();
            let mut ds_att_infos: Vec<vk::RenderingAttachmentInfo> = Vec::new();

            if aspects.color {
                for view in &expanded_color_views {
                    color_att_infos.push(make_rendering_attachment_info(
                        **view,
                        att_layout,
                        vk::AttachmentLoadOp::CLEAR,
                        vk::AttachmentStoreOp::STORE,
                    ));
                }
            } else if let Some(view) = &expanded_ds_view {
                ds_att_infos.push(make_rendering_attachment_info(
                    **view,
                    att_layout,
                    vk::AttachmentLoadOp::CLEAR,
                    vk::AttachmentStoreOp::STORE,
                ));
            }

            let rendering_info = vk::RenderingInfo {
                s_type: vk::StructureType::RENDERING_INFO,
                next: std::ptr::null(),
                flags: vk::RenderingFlags::empty(),
                render_area: expanded_scissor,
                layer_count: 1,
                view_mask: 0,
                color_attachment_count: color_att_infos.len() as u32,
                color_attachments: ptr_or_null(&color_att_infos),
                depth_attachment: if aspects.depth {
                    ptr_or_null(&ds_att_infos)
                } else {
                    std::ptr::null()
                },
                stencil_attachment: if aspects.stencil {
                    ptr_or_null(&ds_att_infos)
                } else {
                    std::ptr::null()
                },
            };

            unsafe {
                device.cmd_begin_rendering(cmd, &rendering_info);
                device.cmd_bind_pipeline(cmd, bind_point, copy.pipeline.get());
                device.cmd_bind_descriptor_sets(
                    cmd,
                    bind_point,
                    *copy.pipeline_layout,
                    0,
                    &[copy.set.get()],
                    &[] as &[u32],
                );
                device.cmd_push_constants(cmd, *copy.pipeline_layout, PC_STAGES, 0, &push_constants);
                device.cmd_set_scissor(cmd, 0, &[expanded_scissor]);
                device.cmd_draw(cmd, 4, 1, 0, 0);
                device.cmd_end_rendering(cmd);
            }
        }
    }

    // Copy attachments to verification buffers.
    {
        let xfer_layout = if params.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };

        let mut verified_images: Vec<vk::Image> = Vec::new();
        if aspects.color {
            for i in 0..att_count {
                verified_images.push(if is_multi_sample {
                    expanded_color_images[i as usize].get()
                } else {
                    color_images[params.output_att_for_att(i) as usize].get()
                });
            }
        } else if let Some(image) = if is_multi_sample { &expanded_ds_image } else { &ds_image } {
            verified_images.push(image.get());
        }

        let mut barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
        let src_access = attachment_access;
        if aspects.color {
            for &image in &verified_images {
                barriers.push(make_image_memory_barrier(
                    src_access,
                    vk::AccessFlags::TRANSFER_READ,
                    att_layout,
                    xfer_layout,
                    image,
                    color_srr,
                ));
            }
        } else {
            barriers.push(make_image_memory_barrier(
                src_access,
                vk::AccessFlags::TRANSFER_READ,
                att_layout,
                xfer_layout,
                verified_images[0],
                ds_srr,
            ));
        }
        image_barriers(
            device,
            cmd,
            attachment_stages,
            vk::PipelineStageFlags::TRANSFER,
            &barriers,
        );

        if aspects.color {
            let copy_region = make_buffer_image_copy(expanded_extent, color_srl);
            for (image, buffer) in verified_images.iter().zip(&verif_buffers) {
                unsafe {
                    device.cmd_copy_image_to_buffer(cmd, *image, xfer_layout, buffer.get(), &[copy_region]);
                }
            }
        } else {
            let depth_copy_region = make_buffer_image_copy(expanded_extent, depth_srl);
            let stencil_copy_region = make_buffer_image_copy(expanded_extent, stencil_srl);
            let mut next_buffer = 0usize;
            if aspects.depth {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        verified_images[0],
                        xfer_layout,
                        verif_buffers[next_buffer].get(),
                        &[depth_copy_region],
                    );
                }
                next_buffer += 1;
            }
            if aspects.stencil {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        verified_images[0],
                        xfer_layout,
                        verif_buffers[next_buffer].get(),
                        &[stencil_copy_region],
                    );
                }
            }
        }

        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // The reference value of the pixel (x, y) of the expanded image for attachment `att`, in the sample block terms of the shaders.
    let half_width = expanded_extent.width / 2;
    let sample_index = |x: u32, y: u32| -> usize {
        let mut sample_idx = y * expanded_extent.width + x;
        if let Some(sample_id) = params.sample_id {
            sample_idx = (sample_idx / params.sample_count()) * params.sample_count() + sample_id;
        }
        sample_idx as usize
    };
    let gradient_value = |x: u32, y: u32| -> f32 {
        let x_coord = (x / params.sample_count()) as f32;
        let y_coord = y as f32;
        let normalized_x = x_coord / extent.width as f32;
        let normalized_y = y_coord / extent.height as f32;
        (normalized_x + normalized_y) / 2.0
    };

    let mut fail = false;

    if aspects.color {
        // Max error for 8-bit unorm subtraction is 2/0xff; the alpha is always 1.0.
        let threshold = 2.0 / 255.0;
        for i in 0..att_count as usize {
            let alloc = verif_buffers[i].get_allocation();
            invalidate_alloc(device, alloc)?;

            let mut reference = TextureLevel::new(
                tcu_att_format,
                expanded_extent.width,
                expanded_extent.height,
                expanded_extent.depth,
            )?;
            {
                let buffer_values = &load_buffers_data[i];
                let mut access = reference.get_access();
                for y in 0..expanded_extent.height {
                    for x in 0..expanded_extent.width {
                        if x < half_width {
                            // The left half is covered by the load buffer data with swapped components (.gbra in the modify shader).
                            let [r, g, b, a] = buffer_values[sample_index(x, y)];
                            access.set_pixel([g, b, r, a], x, y, 0);
                        } else {
                            // The right half is covered by the gradient; all samples in a pixel share the color.
                            let mut color = [0.0, 0.0, 0.0, 1.0];
                            color[i] = gradient_value(x, y);
                            access.set_pixel(color, x, y, 0);
                        }
                    }
                }
            }

            let result_bytes = unsafe {
                std::slice::from_raw_parts(
                    alloc.get_host_ptr().cast_const(),
                    (total_samples * tcu_att_format.pixel_size().unwrap_or(4)) as usize,
                )
            };
            let result = ConstPixelBufferAccess::new(tcu_att_format, expanded_size, result_bytes);
            if !float_threshold_compare(
                &reference.get_const_access(),
                &result,
                [threshold, threshold, threshold, 0.0],
            )
            .ok
            {
                fail = true;
            }
        }
    }

    let mut next_buffer = 0usize;
    if aspects.depth {
        let copy_format =
            depth_copy_format.ok_or_else(|| TestError::InternalError("no depth copy format".to_string()))?;
        let alloc = verif_buffers[next_buffer].get_allocation();
        next_buffer += 1;
        invalidate_alloc(device, alloc)?;
        let result_bytes = unsafe {
            std::slice::from_raw_parts(
                alloc.get_host_ptr().cast_const(),
                (total_samples * copy_format.pixel_size().unwrap_or(4)) as usize,
            )
        };
        let result = ConstPixelBufferAccess::new(copy_format, expanded_size, result_bytes);

        let threshold = match params.att_format {
            // Max error for 16-bit unorm subtraction is 2/0xffff.
            vk::Format::D16_UNORM => 2.0 / 65535.0,
            // Max error for 24-bit unorm subtraction is 2/0xffffff.
            _ => 2.0 / 16_777_215.0,
        };
        let buffer_values = &load_buffers_data[0];
        let expected = |x: u32, y: u32| -> f32 {
            if x < half_width {
                // Complementary depth values, see the modify shader.
                1.0 - buffer_values[sample_index(x, y)][0]
            } else {
                gradient_value(x, y)
            }
        };
        if !ds_matches(&result, true, expanded_size, threshold, &expected) {
            fail = true;
        }
    }

    if aspects.stencil {
        let copy_format =
            stencil_copy_format.ok_or_else(|| TestError::InternalError("no stencil copy format".to_string()))?;
        let alloc = verif_buffers[next_buffer].get_allocation();
        invalidate_alloc(device, alloc)?;
        let result_bytes = unsafe {
            std::slice::from_raw_parts(
                alloc.get_host_ptr().cast_const(),
                (total_samples * copy_format.pixel_size().unwrap_or(1)) as usize,
            )
        };
        let result = ConstPixelBufferAccess::new(copy_format, expanded_size, result_bytes);

        let buffer_values = &load_buffers_data[0];
        let expected = |x: u32, y: u32| -> f32 {
            if x < half_width {
                // Complementary stencil values, see the modify shader.
                (255 - buffer_values[sample_index(x, y)][1] as i32) as f32
            } else {
                (gradient_value(x, y) * 255.0) as i32 as f32
            }
        };
        if !ds_matches(&result, false, expanded_size, 0.0, &expected) {
            fail = true;
        }
    }

    if fail {
        return Err(TestError::Fail(
            "Unexpected results in some color or depth/stencil buffers; check log for details --".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `createDynamicRenderingLocalReadMaint10Tests`
pub fn create_dynamic_rendering_local_read_maint10_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("m10_feedback_loop");

    let feedback_loops: [&[bool]; 6] = [
        &[false],
        &[true],
        &[false, false],
        &[false, true],
        &[true, false],
        &[true, true],
    ];

    for format in [
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::D16_UNORM,
        vk::Format::S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ] {
        for sample_count in [vk::SampleCountFlags::_1, vk::SampleCountFlags::_4] {
            for feedback_case in feedback_loops {
                for sample_id in [-1i32, 0, 1, 2, 3] {
                    for general_layout in [false, true] {
                        if sample_id >= sample_count.bits() as i32
                            || (sample_count == vk::SampleCountFlags::_1 && sample_id != -1)
                        {
                            continue;
                        }

                        let is_depth_stencil = format != vk::Format::R8G8B8A8_UNORM;
                        if is_depth_stencil && (feedback_case.len() != 1 || !feedback_case[0]) {
                            continue;
                        }

                        let params = TestParams {
                            samples: sample_count,
                            att_format: format,
                            feedback: feedback_case.to_vec(),
                            sample_id: (sample_id >= 0).then_some(sample_id as u32),
                            general_layout,
                        };
                        let test_name = format!(
                            "{}_samples_{}_{}{}{}",
                            format_simple_name(format),
                            sample_count.bits(),
                            feedback_case_name(feedback_case),
                            params.sample_id.map_or(String::new(), |id| format!("_sample_{id}")),
                            if general_layout { "_general_layout" } else { "" },
                        );
                        main_group.add_child(Box::new(DrlrFeedbackLoopCase {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    main_group
}
