// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineColorWriteEnableTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream creates one render pass per framebuffer; one render pass
// is shared by every framebuffer here, they are compatible. Colour and depth are read back in the submission that
// draws, instead of one submission per `readColorAttachment`. No error mask images are logged.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtColorWriteEnableExtensionDeviceCommands;

use crate::generated::shaders::pipeline_color_write_enable::{
    COLOR_WRITE_ENABLE, COLOR_WRITE_ENABLE_MAXA_3, COLOR_WRITE_ENABLE_MAXA_4, COLOR_WRITE_ENABLE_MAXA_5,
};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{ChannelOrder, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, clear_value_color, create_draw_pipeline, default_depth_stencil_state,
    default_rasterization_state, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_draw, begin_dynamic_rendering, end_draw, make_shader_objects,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FRAMEBUFFER_WIDTH: u32 = 64;
const FRAMEBUFFER_HEIGHT: u32 = 64;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const COLOR_THRESHOLD: f32 = 0.005; // 1/255 < 0.005 < 2/255.
const NUM_COLOR_ATTACHMENTS: u32 = 3;
const DEPTH_STENCIL_FORMATS: [vk::Format; 2] = [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT];

const DEFAULT_TRIANGLE_COLOR: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
const DEFAULT_CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

#[derive(Clone, Copy, PartialEq, Eq)]
enum SequenceOrdering {
    /// Set state at the start of the command buffer.
    CmdBufferStart,
    /// After binding dynamic pipeline and just before drawing.
    BeforeDraw,
    /// After a static state pipeline has been bound but before the dynamic state pipeline has been bound.
    BetweenPipelines,
    /// After a static state pipeline and a second dynamic state pipeline have been bound.
    AfterPipelines,
    /// Before a static state pipeline with the correct values has been bound.
    BeforeGoodStatic,
    /// Bind bad static pipeline and draw, followed by binding correct dynamic pipeline and drawing again.
    TwoDrawsDynamic,
    /// Bind bad dynamic pipeline and draw, followed by binding correct static pipeline and drawing again.
    TwoDrawsStatic,
}

/// `TestConfig`, with the construction type left out: only monolithic pipelines are built. The mesh scale and offset
/// are always 1 and 0, as in every case upstream creates.
#[derive(Clone)]
struct TestConfig {
    sequence_ordering: SequenceOrdering,
    mesh_color: [f32; 4],
    mesh_depth: f32,
    clear_color_value: [f32; 4],
    clear_depth_value: f32,
    channel_mask: [bool; 4],
    expected_color: Vec<[f32; 4]>,
    expected_depth: f32,
    /// `colorWriteEnableConfig.staticValue`
    color_write_enable_static: Vec<vk::Bool32>,
    /// `colorWriteEnableConfig.dynamicValue`
    color_write_enable_dynamic: Option<Vec<vk::Bool32>>,
}

impl TestConfig {
    fn new(sequence_ordering: SequenceOrdering) -> Self {
        Self {
            sequence_ordering,
            mesh_color: DEFAULT_TRIANGLE_COLOR,
            mesh_depth: 0.0,
            clear_color_value: DEFAULT_CLEAR_COLOR,
            clear_depth_value: 1.0,
            channel_mask: [true; 4],
            expected_color: vec![DEFAULT_TRIANGLE_COLOR; NUM_COLOR_ATTACHMENTS as usize],
            expected_depth: 1.0,
            color_write_enable_static: vec![vk::TRUE],
            color_write_enable_dynamic: None,
        }
    }

    /// True if the static and dynamic values are to be used exchanged, which makes the static part of the pipeline
    /// have the actual expected values.
    fn is_reversed(&self) -> bool {
        self.sequence_ordering == SequenceOrdering::BeforeGoodStatic
            || self.sequence_ordering == SequenceOrdering::TwoDrawsStatic
    }

    fn num_iterations(&self) -> u32 {
        match self.sequence_ordering {
            SequenceOrdering::TwoDrawsDynamic | SequenceOrdering::TwoDrawsStatic => 2,
            _ => 1,
        }
    }
}

struct ColorWriteEnableTest {
    name: String,
    config: TestConfig,
}

impl TestCase for ColorWriteEnableTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ColorWriteEnableTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // This is always required.
        context.require_device_functionality("VK_EXT_color_write_enable")?;

        // Check color image format support (depth/stencil will be chosen at runtime).
        let color_features = vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
        let color_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), COLOR_FORMAT)
        };

        if !color_properties.optimal_tiling_features.contains(color_features) {
            return Err(TestError::NotSupported(
                "Required color image features not supported".to_string(),
            ));
        }

        // Not Supported because the transfer feature is not mandatory.
        if choose_depth_stencil_format(context).is_none() {
            return Err(TestError::NotSupported(
                "Required depth/stencil image features not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        COLOR_WRITE_ENABLE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ColorWriteEnableInstance {
            context,
            config: self.config.clone(),
        })
    }
}

/// The first of `DEPTH_STENCIL_FORMATS` that can be a depth/stencil attachment and a transfer source.
fn choose_depth_stencil_format(context: &Context<'_>) -> Option<vk::Format> {
    let ds_features = vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
    DEPTH_STENCIL_FORMATS.into_iter().find(|&format| {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        properties.optimal_tiling_features.contains(ds_features)
    })
}

struct ColorWriteEnableInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

fn create_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    width: u32,
    height: u32,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width,
            height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

fn create_readback_buffer<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// The depth aspect of a combined depth/stencil image left in DEPTH_STENCIL_ATTACHMENT_OPTIMAL, copied to `buffer`.
fn copy_depth_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

fn depth_clear_value(depth: f32) -> vk::ClearValue {
    vk::ClearValue {
        depth_stencil: vk::ClearDepthStencilValue { depth, stencil: 0 },
    }
}

/// `setDynamicStates`
fn set_dynamic_states(config: &TestConfig, device: &Device, cmd_buffer: vk::CommandBuffer) {
    if let Some(color_write_enables) = &config.color_write_enable_dynamic {
        unsafe { device.cmd_set_color_write_enable_ext(cmd_buffer, color_write_enables) };
    }
}

fn depth_attachment_value(format: vk::Format, texel: u32) -> f32 {
    if format == vk::Format::D32_SFLOAT_S8_UINT {
        f32::from_bits(texel)
    } else {
        (texel & 0x00FF_FFFF) as f32 / 16_777_215.0
    }
}

impl ColorWriteEnableInstance<'_> {
    fn color_blend_attachment(&self) -> vk::PipelineColorBlendAttachmentState {
        let mask = self.config.channel_mask;
        let mut color_write_mask = vk::ColorComponentFlags::empty();
        if mask[0] {
            color_write_mask |= vk::ColorComponentFlags::R;
        }
        if mask[1] {
            color_write_mask |= vk::ColorComponentFlags::G;
        }
        if mask[2] {
            color_write_mask |= vk::ColorComponentFlags::B;
        }
        if mask[3] {
            color_write_mask |= vk::ColorComponentFlags::A;
        }
        vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(color_write_mask)
            .build()
    }
}

impl TestInstance for ColorWriteEnableInstance<'_> {
    /// `ColorWriteEnableInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let config = &self.config;

        let reversed = config.is_reversed();
        let num_iterations = config.num_iterations();
        let sequence_ordering = config.sequence_ordering;
        let k_num = NUM_COLOR_ATTACHMENTS as usize;

        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let ds_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

        // Choose depth/stencil format.
        let ds_format = choose_depth_stencil_format(context).ok_or_else(|| {
            TestError::NotSupported("Required depth/stencil image features not supported".to_string())
        })?;

        // Swap static and dynamic values in the test configuration so the static pipeline ends up with the expected
        // values for cases where we will bind the static pipeline last before drawing.
        let (color_write_enable_static, color_write_enable_dynamic) =
            match (&config.color_write_enable_dynamic, reversed) {
                (Some(dynamic), true) => (dynamic.clone(), Some(config.color_write_enable_static.clone())),
                (dynamic, _) => (config.color_write_enable_static.clone(), dynamic.clone()),
            };
        let effective = TestConfig {
            color_write_enable_static: color_write_enable_static.clone(),
            color_write_enable_dynamic: color_write_enable_dynamic.clone(),
            ..config.clone()
        };

        // Create color and depth/stencil images.
        let mut color_images = Vec::new();
        for _ in 0..(num_iterations * NUM_COLOR_ATTACHMENTS) {
            color_images.push(create_image(
                context,
                COLOR_FORMAT,
                FRAMEBUFFER_WIDTH,
                FRAMEBUFFER_HEIGHT,
                color_usage,
            )?);
        }
        let mut ds_images = Vec::new();
        for _ in 0..num_iterations {
            ds_images.push(create_image(
                context,
                ds_format,
                FRAMEBUFFER_WIDTH,
                FRAMEBUFFER_HEIGHT,
                ds_usage,
            )?);
        }

        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let ds_subresource_range =
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);

        let mut color_image_views = Vec::new();
        for image in &color_images {
            color_image_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                COLOR_FORMAT,
                color_subresource_range,
            )?);
        }
        let mut ds_image_views = Vec::new();
        for image in &ds_images {
            ds_image_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                ds_format,
                ds_subresource_range,
            )?);
        }

        // Vertex buffer.
        // Full-screen triangle fan with 6 vertices.
        //
        // 4        3        2
        //  +-------+-------+
        //  |X      X      X|
        //  | X     X     X |
        //  |  X    X    X  |
        //  |   X   X   X   |
        //  |    X  X  X    |
        //  |     X X X     |
        //  |      XXX      |
        //  +-------+-------+
        // 5        0        1
        let vertices: [f32; 12] = [0.0, 1.0, 1.0, 1.0, 1.0, -1.0, 0.0, -1.0, -1.0, -1.0, -1.0, 1.0];
        let vert_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Descriptor set layout.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new().build(device)?;

        // Pipeline layout.
        let push_constant_stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let push_constant_range = [vk::PushConstantRange {
            stage_flags: push_constant_stage_flags,
            offset: 0,
            size: 9 * 4,
        }];
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_constant_range);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Render pass with single subpass.
        let color_attachment_reference: Vec<vk::AttachmentReference> = (0..NUM_COLOR_ATTACHMENTS)
            .map(|i| vk::AttachmentReference {
                attachment: i,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            })
            .collect();
        let ds_attachment_reference = vk::AttachmentReference {
            attachment: NUM_COLOR_ATTACHMENTS,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpass_description = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_reference)
            .depth_stencil_attachment(&ds_attachment_reference)
            .build()];

        let mut attachment_descriptions: Vec<vk::AttachmentDescription> = (0..k_num)
            .map(|_| {
                vk::AttachmentDescription::builder()
                    .format(COLOR_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .build()
            })
            .collect();
        attachment_descriptions.push(
            vk::AttachmentDescription::builder()
                .format(ds_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        );
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpass_description);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // Framebuffers.
        let mut framebuffers = Vec::new();
        for img_idx in 0..ds_image_views.len() {
            let mut attachments: Vec<vk::ImageView> =
                (0..k_num).map(|i| *color_image_views[img_idx * k_num + i]).collect();
            attachments.push(*ds_image_views[img_idx]);
            framebuffers.push(make_framebuffer(
                device,
                *render_pass,
                &attachments,
                FRAMEBUFFER_WIDTH,
                FRAMEBUFFER_HEIGHT,
                1,
            )?);
        }

        // Shader modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];

        // Pipeline state shared by the static and the dynamic pipeline.
        let make_state = |dynamic: bool| {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_FAN)
                .with_full_viewport(FRAMEBUFFER_WIDTH, FRAMEBUFFER_HEIGHT);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 8,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32_SFLOAT,
                offset: 0,
            }];
            state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                .line_width(1.0)
                .build();
            let stencil = vk::StencilOpState::builder()
                .fail_op(vk::StencilOp::KEEP)
                .pass_op(vk::StencilOp::KEEP)
                .depth_fail_op(vk::StencilOp::KEEP)
                .compare_op(vk::CompareOp::ALWAYS)
                .compare_mask(0xFF)
                .write_mask(0xFF)
                .reference(0)
                .build();
            state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
                .depth_test_enable(true)
                .depth_write_enable(true)
                .depth_compare_op(vk::CompareOp::LESS)
                .front(stencil)
                .back(stencil)
                .min_depth_bounds(0.0)
                .max_depth_bounds(1.0)
                .build();
            state.color_blend_attachments = vec![self.color_blend_attachment(); k_num];
            state.color_write_enables = Some(color_write_enable_static.clone());
            if dynamic {
                state.dynamic_states = vec![vk::DynamicState::COLOR_WRITE_ENABLE_EXT];
            }
            state
        };

        let bind_static_first = matches!(
            sequence_ordering,
            SequenceOrdering::BetweenPipelines | SequenceOrdering::AfterPipelines | SequenceOrdering::TwoDrawsDynamic
        );
        let use_static_pipeline = bind_static_first || reversed;

        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &set_layouts, &push_constant_range)?;
        let static_state = make_state(false);
        let mut dynamic_state = make_state(color_write_enable_dynamic.is_some());
        if color_write_enable_dynamic.is_some() {
            dynamic_state.color_write_enables = None;
        }

        // Create static pipeline when needed.
        let static_pipeline = if use_static_pipeline && shader_objects.is_none() {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &make_state(false),
            )?)
        } else {
            None
        };

        // Create dynamic pipeline.
        let graphics_pipeline = if shader_objects.is_none() {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &make_state(color_write_enable_dynamic.is_some()),
            )?)
        } else {
            None
        };

        // Command buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;

        // Clear values.
        let mut clear_values = vec![clear_value_color(config.clear_color_value); k_num];
        clear_values.push(depth_clear_value(config.clear_depth_value));

        // Record command buffer.
        begin_command_buffer(device, cmd_buffer)?;

        for iteration in 0..num_iterations {
            // Maybe set dynamic state here.
            if sequence_ordering == SequenceOrdering::CmdBufferStart {
                set_dynamic_states(&effective, device, cmd_buffer);
            }

            // Begin render pass.
            if shader_objects.is_some() {
                let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
                let mut barriers: Vec<vk::ImageMemoryBarrier> = (0..k_num)
                    .map(|i| {
                        make_image_memory_barrier(
                            vk::AccessFlags::empty(),
                            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                            vk::ImageLayout::UNDEFINED,
                            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                            color_images[iteration as usize * k_num + i].get(),
                            color_range,
                        )
                    })
                    .collect();
                barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    ds_images[iteration as usize].get(),
                    ds_subresource_range,
                ));
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &barriers,
                    );
                }
                let color_attachments: Vec<RenderingAttachment> = (0..k_num)
                    .map(|i| RenderingAttachment {
                        view: *color_image_views[iteration as usize * k_num + i],
                        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        clear_value: clear_values[i],
                    })
                    .collect();
                let ds_attachment = RenderingAttachment {
                    view: *ds_image_views[iteration as usize],
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    clear_value: clear_values[k_num],
                };
                begin_dynamic_rendering(
                    device,
                    cmd_buffer,
                    rect_2d(FRAMEBUFFER_WIDTH, FRAMEBUFFER_HEIGHT),
                    &color_attachments,
                    Some(ds_attachment),
                    Some(ds_attachment),
                );
            } else {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffers[iteration as usize])
                    .render_area(rect_2d(FRAMEBUFFER_WIDTH, FRAMEBUFFER_HEIGHT))
                    .clear_values(&clear_values);
                unsafe { device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            }

            let bind_static = || {
                if let Some(objects) = shader_objects.as_ref() {
                    objects.bind(cmd_buffer, &static_state);
                } else if let Some(pipeline) = &static_pipeline {
                    unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline.get()) };
                }
            };
            let bind_dynamic = || {
                if let Some(objects) = shader_objects.as_ref() {
                    objects.bind(cmd_buffer, &dynamic_state);
                    // Binding shader objects sets default dynamic state, so a value set at the start must be set again.
                    if sequence_ordering == SequenceOrdering::CmdBufferStart {
                        set_dynamic_states(&effective, device, cmd_buffer);
                    }
                } else if let Some(pipeline) = &graphics_pipeline {
                    unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline.get()) };
                }
            };

            // Bind a static pipeline first if needed.
            if bind_static_first && iteration == 0 {
                bind_static();
            }

            // Maybe set dynamic state here.
            if sequence_ordering == SequenceOrdering::BetweenPipelines {
                set_dynamic_states(&effective, device, cmd_buffer);
            }

            // Bind dynamic pipeline.
            if (sequence_ordering != SequenceOrdering::TwoDrawsDynamic
                && sequence_ordering != SequenceOrdering::TwoDrawsStatic)
                || (sequence_ordering == SequenceOrdering::TwoDrawsDynamic && iteration > 0)
                || (sequence_ordering == SequenceOrdering::TwoDrawsStatic && iteration == 0)
            {
                bind_dynamic();
            }

            if sequence_ordering == SequenceOrdering::BeforeGoodStatic
                || (sequence_ordering == SequenceOrdering::TwoDrawsDynamic && iteration > 0)
                || (sequence_ordering == SequenceOrdering::TwoDrawsStatic && iteration == 0)
            {
                set_dynamic_states(&effective, device, cmd_buffer);
            }

            // Bind a static pipeline last if needed.
            if (sequence_ordering == SequenceOrdering::BeforeGoodStatic
                || (sequence_ordering == SequenceOrdering::TwoDrawsStatic && iteration > 0))
                && use_static_pipeline
            {
                bind_static();
            }

            // Push constants.
            let push_constants: [f32; 9] = [
                config.mesh_color[0],
                config.mesh_color[1],
                config.mesh_color[2],
                config.mesh_color[3],
                config.mesh_depth, // meshDepth
                1.0,               // scaleX
                1.0,               // scaleY
                0.0,               // offsetX
                0.0,               // offsetY
            ];
            let push_bytes: Vec<u8> = push_constants.iter().flat_map(|f| f.to_ne_bytes()).collect();
            unsafe {
                device.cmd_push_constants(cmd_buffer, *pipeline_layout, push_constant_stage_flags, 0, &push_bytes)
            };

            // Maybe set dynamic state here.
            if sequence_ordering == SequenceOrdering::BeforeDraw
                || sequence_ordering == SequenceOrdering::AfterPipelines
            {
                set_dynamic_states(&effective, device, cmd_buffer);
            }

            // Bind vertex buffer and draw.
            unsafe {
                device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vert_buffer.get()], &[0]);
                device.cmd_draw(cmd_buffer, 6, 1, 0, 0);
            }
            end_draw(device, cmd_buffer, shader_objects.is_some());
        }

        // Read result image aspects from the last used framebuffer.
        let color_buffer_size = (FRAMEBUFFER_WIDTH * FRAMEBUFFER_HEIGHT * 4) as vk::DeviceSize;
        let first_last_color = color_images.len() - k_num;
        let mut color_buffers = Vec::new();
        for attachment_index in 0..k_num {
            let buffer = create_readback_buffer(context, color_buffer_size)?;
            copy_image_to_buffer(
                device,
                cmd_buffer,
                color_images[first_last_color + attachment_index].get(),
                buffer.get(),
                FRAMEBUFFER_WIDTH,
                FRAMEBUFFER_HEIGHT,
            );
            color_buffers.push(buffer);
        }
        let depth_buffer = create_readback_buffer(context, color_buffer_size)?;
        copy_depth_to_buffer(
            device,
            cmd_buffer,
            ds_images[ds_images.len() - 1].get(),
            depth_buffer.get(),
            FRAMEBUFFER_WIDTH,
            FRAMEBUFFER_HEIGHT,
        );

        end_command_buffer(device, cmd_buffer)?;

        // Submit commands.
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Check expected values.
        let pixel_count = (FRAMEBUFFER_WIDTH * FRAMEBUFFER_HEIGHT) as usize;
        let mut color_match_all = true;
        for (attachment_index, buffer) in color_buffers.iter().enumerate() {
            invalidate_alloc(device, buffer.get_allocation())?;
            let bytes = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), pixel_count * 4) };
            let expected = config.expected_color[attachment_index];

            let color_match = bytes
                .chunks_exact(4)
                .all(|pixel| (0..4).all(|c| (pixel[c] as f32 / 255.0 - expected[c]).abs() < COLOR_THRESHOLD));
            if !color_match {
                color_match_all = false;
            }
        }

        invalidate_alloc(device, depth_buffer.get_allocation())?;
        let depth_bytes =
            unsafe { std::slice::from_raw_parts(depth_buffer.get_allocation().get_host_ptr(), pixel_count * 4) };
        let min_depth = config.expected_depth - 1.0e-07;
        let max_depth = config.expected_depth + 1.0e-07;
        let depth_match = depth_bytes.chunks_exact(4).all(|texel| {
            let depth = depth_attachment_value(ds_format, u32::from_ne_bytes([texel[0], texel[1], texel[2], texel[3]]));
            (min_depth..=max_depth).contains(&depth)
        });

        if !(color_match_all && depth_match) {
            return Ok(TestStatus::fail(
                "Incorrect value found in attachments; please check logged images",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `MaskVector`
fn mask_vector<T: Copy>(
    value_if_mask_is_false: &[T],
    value_if_mask_is_true: &[T],
    mask: &[bool],
    inverse: bool,
) -> Vec<T> {
    mask.iter()
        .enumerate()
        .map(|(i, &m)| {
            let m = if inverse { !m } else { m };
            if m {
                value_if_mask_is_true[i]
            } else {
                value_if_mask_is_false[i]
            }
        })
        .collect()
}

/// `ApplyChannelMask`
fn apply_channel_mask(mesh_colors: &mut [[f32; 4]], channel_mask: [bool; 4], clear_color: [f32; 4]) {
    for attachment_color in mesh_colors {
        for c in 0..4 {
            if !channel_mask[c] {
                attachment_color[c] = clear_color[c];
            }
        }
    }
}

/// The part of `AddSingleTestCaseStatic` and `AddSingleTestCaseDynamic` that does not depend on whether the value
/// is static or dynamic.
fn base_config(ordering: SequenceOrdering, mask: &[bool], channel_mask: [bool; 4], inverse: bool) -> TestConfig {
    let mut config = TestConfig::new(ordering);

    // Enable writes and expect the mesh color, or disable writes and expect the clear color.
    config.clear_color_value = [0.25, 0.5, 0.75, 0.5];
    config.mesh_color = [1.0, 0.75, 0.5, 0.25];
    config.channel_mask = channel_mask;

    let mut mesh_colors_per_attachment = vec![config.mesh_color; NUM_COLOR_ATTACHMENTS as usize];
    for i in 1..NUM_COLOR_ATTACHMENTS as usize {
        mesh_colors_per_attachment[i] = mesh_colors_per_attachment[i - 1].map(|c| c * 0.5);
    }

    let clear_colors_per_attachment = vec![config.clear_color_value; NUM_COLOR_ATTACHMENTS as usize];

    apply_channel_mask(&mut mesh_colors_per_attachment, channel_mask, config.clear_color_value);

    config.expected_color = mask_vector(&clear_colors_per_attachment, &mesh_colors_per_attachment, mask, inverse);

    // Depth should always be written even when color is not
    config.clear_depth_value = 0.5;
    config.mesh_depth = 0.25;
    config.expected_depth = 0.25;
    config
}

/// `AddSingleTestCaseStatic`
fn add_single_test_case_static(
    name: &str,
    mask: &[bool],
    channel_mask: [bool; 4],
    inverse: bool,
    ordering_group: &mut TestCaseGroup,
) {
    let mut config = base_config(SequenceOrdering::CmdBufferStart, mask, channel_mask, inverse);

    let all_vk_false = vec![vk::FALSE; NUM_COLOR_ATTACHMENTS as usize];
    let all_vk_true = vec![vk::TRUE; NUM_COLOR_ATTACHMENTS as usize];
    config.color_write_enable_static = mask_vector(&all_vk_false, &all_vk_true, mask, inverse);

    ordering_group.add_child(Box::new(ColorWriteEnableTest {
        name: name.to_string(),
        config,
    }) as Box<dyn TestCase>);
}

/// `AddSingleTestCaseDynamic`
fn add_single_test_case_dynamic(
    name: &str,
    mask: &[bool],
    channel_mask: [bool; 4],
    inverse: bool,
    ordering_group: &mut TestCaseGroup,
    ordering: SequenceOrdering,
) {
    let mut config = base_config(ordering, mask, channel_mask, inverse);

    let all_vk_false = vec![vk::FALSE; NUM_COLOR_ATTACHMENTS as usize];
    let all_vk_true = vec![vk::TRUE; NUM_COLOR_ATTACHMENTS as usize];
    config.color_write_enable_static = if inverse {
        all_vk_true.clone()
    } else {
        all_vk_false.clone()
    };
    config.color_write_enable_dynamic = Some(mask_vector(&all_vk_false, &all_vk_true, mask, inverse));

    ordering_group.add_child(Box::new(ColorWriteEnableTest {
        name: name.to_string(),
        config,
    }) as Box<dyn TestCase>);
}

/// `createColorWriteEnableTests`
pub fn create_color_write_enable_tests() -> TestCaseGroup {
    create_color_write_enable_tests_for(false)
}

/// The shader object types leave out the orderings that need two pipelines bound before the state is set.
pub fn create_color_write_enable_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut color_write_enable_group = TestCaseGroup::new("color_write_enable");

    let n = NUM_COLOR_ATTACHMENTS as usize;
    let mask_all = vec![true; n];
    let mut mask_first = vec![false; n];
    mask_first[0] = true;
    let mut mask_second = vec![false; n];
    mask_second[1] = true;
    let mut mask_last = vec![false; n];
    mask_last[n - 1] = true;
    let mut mask_first_and_second = vec![false; n];
    mask_first_and_second[0] = true;
    mask_first_and_second[1] = true;
    let mut mask_second_and_last = vec![false; n];
    mask_second_and_last[1] = true;
    mask_second_and_last[n - 1] = true;

    // Test cases for channel enables
    let channel_cases: [([bool; 4], &str); 6] = [
        ([true, true, true, true], "all_channels"),
        ([true, false, false, false], "red_channel"),
        ([false, true, false, false], "green_channel"),
        ([false, false, true, false], "blue_channel"),
        ([false, false, false, true], "alpha_channel"),
        ([false, false, false, false], "no_channels"),
    ];

    // Test cases for the dynamic state
    let ordering_cases = [
        // Dynamic state set after command buffer start
        (SequenceOrdering::CmdBufferStart, "cmd_buffer_start"),
        // Dynamic state set just before drawing
        (SequenceOrdering::BeforeDraw, "before_draw"),
        // Dynamic after a pipeline with static states has been bound and before a pipeline with dynamic states has been bound
        (SequenceOrdering::BetweenPipelines, "between_pipelines"),
        // Dynamic state set after both a static-state pipeline and a second dynamic-state pipeline have been bound
        (SequenceOrdering::AfterPipelines, "after_pipelines"),
        // Dynamic state set after a dynamic pipeline has been bound and before a second static-state pipeline with the right values has been bound
        (SequenceOrdering::BeforeGoodStatic, "before_good_static"),
        // Bind bad static pipeline and draw, followed by binding correct dynamic pipeline and drawing again
        (SequenceOrdering::TwoDrawsDynamic, "two_draws_dynamic"),
        // Bind bad dynamic pipeline and draw, followed by binding correct static pipeline and drawing again
        (SequenceOrdering::TwoDrawsStatic, "two_draws_static"),
    ];

    let mask_cases: [(&str, &Vec<bool>); 6] = [
        ("all", &mask_all),
        ("first", &mask_first),
        ("second", &mask_second),
        ("last", &mask_last),
        ("first_and_second", &mask_first_and_second),
        ("second_and_last", &mask_second_and_last),
    ];

    for (enabled_channels, channel_name) in channel_cases {
        let mut channel_group = TestCaseGroup::new(channel_name);

        for (ordering, ordering_name) in ordering_cases {
            if shader_object
                && matches!(
                    ordering,
                    SequenceOrdering::BetweenPipelines | SequenceOrdering::AfterPipelines
                )
            {
                continue;
            }
            let mut ordering_group = TestCaseGroup::new(ordering_name);

            // Dynamically enable writes to the given color attachments, then dynamically disable them.
            for (prefix, inverse) in [("enable", false), ("disable", true)] {
                for (mask_name, mask) in &mask_cases {
                    add_single_test_case_dynamic(
                        &format!("{prefix}_{mask_name}"),
                        mask,
                        enabled_channels,
                        inverse,
                        &mut ordering_group,
                        ordering,
                    );
                }
            }

            channel_group.add_child(ordering_group);
        }

        // Test cases for the static state
        // Note that the dynamic state test cases above also test pipelines with static state (when ordering is BEFORE_GOOD_STATIC and TWO_DRAWS_STATIC).
        // However they all bind a pipeline with the static state AFTER binding a pipeline with the dynamic state.
        // The only case missing, then, is static state alone without any dynamic pipelines in the same render pass or command buffer.
        let mut static_ordering_group = TestCaseGroup::new("static");

        for (prefix, inverse) in [("enable", false), ("disable", true)] {
            for (mask_name, mask) in &mask_cases {
                add_single_test_case_static(
                    &format!("{prefix}_{mask_name}"),
                    mask,
                    enabled_channels,
                    inverse,
                    &mut static_ordering_group,
                );
            }
        }

        channel_group.add_child(static_ordering_group);
        color_write_enable_group.add_child(channel_group);
    }

    color_write_enable_group
}

// ---------------------------------------------------------------------------------------------------------------------
// ColorWriteEnable2Test: dEQP-VK.pipeline.monolithic.color_write_enable_maxa.*
// ---------------------------------------------------------------------------------------------------------------------

/// `TestParams`
#[derive(Clone, Copy)]
struct Params2 {
    width: u32,
    height: u32,
    attachment_count: u32,
    attachment_more: u32,
    set_cwe_before_pl_bind: bool,
}

struct ColorWriteEnable2Test {
    name: String,
    params: Params2,
}

/// `TestParams::selectOptimalBlendableFormat`
fn select_optimal_blendable_format(context: &Context<'_>) -> Option<vk::Format> {
    let flags = vk::FormatFeatureFlags::TRANSFER_SRC
        | vk::FormatFeatureFlags::COLOR_ATTACHMENT
        | vk::FormatFeatureFlags::COLOR_ATTACHMENT_BLEND;
    for raw in (1..=vk::Format::R64G64B64A64_SFLOAT.as_raw()).rev() {
        let format = vk::Format::from_raw(raw);
        let matches = map_vk_format(format).is_some_and(|tcu_format| {
            tcu_format.order == ChannelOrder::RGBA || tcu_format.order == ChannelOrder::sRGBA
        });
        if !matches {
            continue;
        }
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties.optimal_tiling_features.contains(flags) {
            return Some(format);
        }
    }
    None
}

impl TestCase for ColorWriteEnable2Test {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ColorWriteEnable2Test::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_color_write_enable")?;

        let params = &self.params;
        let max_color_attachments = context.get_device_properties().limits.max_color_attachments;
        if params.attachment_count + params.attachment_more > max_color_attachments {
            let what = if params.attachment_more != 0 {
                format!(
                    "Sum of color attachments ({} + {})",
                    params.attachment_count, params.attachment_more
                )
            } else {
                format!("Color attachment count of {}", params.attachment_count)
            };
            return Err(TestError::NotSupported(format!(
                "{what} exceeds maximum number of color attachments supported by device which is {max_color_attachments}"
            )));
        }

        if select_optimal_blendable_format(context).is_none() {
            return Err(TestError::NotSupported(
                "Required color image features not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.attachment_count {
            3 => COLOR_WRITE_ENABLE_MAXA_3.programs,
            4 => COLOR_WRITE_ENABLE_MAXA_4.programs,
            _ => COLOR_WRITE_ENABLE_MAXA_5.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ColorWriteEnable2Instance {
            context,
            params: self.params,
        })
    }
}

struct ColorWriteEnable2Instance<'a> {
    context: &'a Context<'a>,
    params: Params2,
}

/// `ColorWriteEnable2Instance::Framebuffer`; the fields drop in the order the objects depend on each other.
struct Framebuffer2<'a> {
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    _views: Vec<Unique<'a, vk::ImageView>>,
    images: Vec<ImageWithMemory<'a>>,
}

impl ColorWriteEnable2Instance<'_> {
    /// `createRenderPass` and `createFramebuffer`
    fn create_framebuffer(
        &self,
        format: vk::Format,
        color_attachment_count: u32,
    ) -> Result<Framebuffer2<'_>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let image_subresource = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let mut images = Vec::new();
        let mut views = Vec::new();
        for _ in 0..color_attachment_count {
            let image = create_image(context, format, self.params.width, self.params.height, image_usage)?;
            views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                format,
                image_subresource,
            )?);
            images.push(image);
        }

        let attachment_descriptions: Vec<vk::AttachmentDescription> = (0..color_attachment_count)
            .map(|_| {
                vk::AttachmentDescription::builder()
                    .format(format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .build()
            })
            .collect();
        let color_attachment_reference: Vec<vk::AttachmentReference> = (0..color_attachment_count)
            .map(|i| vk::AttachmentReference {
                attachment: i,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            })
            .collect();
        let subpass_description = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpass_description);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let view_handles: Vec<vk::ImageView> = views.iter().map(|v| v.get()).collect();
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &view_handles,
            self.params.width,
            self.params.height,
            1,
        )?;

        Ok(Framebuffer2 {
            framebuffer,
            render_pass,
            _views: views,
            images,
        })
    }
}

impl TestInstance for ColorWriteEnable2Instance<'_> {
    /// `ColorWriteEnable2Instance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let attachment_count = params.attachment_count;
        let format = select_optimal_blendable_format(context)
            .ok_or_else(|| TestError::NotSupported("Required color image features not supported".to_string()))?;
        let tcu_format = map_vk_format(format)
            .ok_or_else(|| TestError::InternalError("no tcu format for the chosen colour format".to_string()))?;
        let texel_size = tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::InternalError("no pixel size for the chosen colour format".to_string()))?
            as usize;

        let blend_comp = 0.5f32;
        let background = [0.75f32; 4];
        let clear_values = vec![clear_value_color(background); attachment_count as usize];

        // `createVerrtexBuffer`
        let quad: [f32; 24] = [
            -1.0, -1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 0.0, -1.0, 1.0, 0.0, 0.0, -1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 0.0,
            1.0, 1.0, 0.0, 0.0,
        ];
        let vertex_buffer = create_host_buffer(context, &quad, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let mut write_enables = vec![vk::TRUE; (attachment_count + params.attachment_more) as usize];
        for i in 0..attachment_count as usize {
            write_enables[i] = if i % 2 != 0 { vk::TRUE } else { vk::FALSE };
        }

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];

        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;
        let mut framebuffers = Vec::new();
        let mut pipelines: Vec<(Option<Unique<'_, vk::Pipeline>>, bool)> = Vec::new();
        let mut states = Vec::new();
        for i in 0..attachment_count {
            framebuffers.push(self.create_framebuffer(format, i + 1)?);

            let dynamic_color_write_enable = (attachment_count - i) % 2 == 1;

            // build dynamics and statics pipelines alternately in reverse order
            let color_attachment_count = (i + 1) as usize;
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_full_viewport(params.width, params.height);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            }];
            state.rasterization = default_rasterization_state();
            state.depth_stencil = default_depth_stencil_state();

            state.color_blend_attachments = (0..color_attachment_count)
                .map(|a| {
                    let all = vk::ColorComponentFlags::R
                        | vk::ColorComponentFlags::G
                        | vk::ColorComponentFlags::B
                        | vk::ColorComponentFlags::A;
                    let color_write_mask = match a % 4 {
                        0 => all & !vk::ColorComponentFlags::R,
                        1 => all & !vk::ColorComponentFlags::G,
                        2 => all & !vk::ColorComponentFlags::B,
                        _ => all & !vk::ColorComponentFlags::A,
                    };
                    vk::PipelineColorBlendAttachmentState::builder()
                        .blend_enable(write_enables[a] != vk::FALSE)
                        .src_color_blend_factor(vk::BlendFactor::CONSTANT_COLOR)
                        .dst_color_blend_factor(vk::BlendFactor::ZERO)
                        .color_blend_op(vk::BlendOp::ADD)
                        .src_alpha_blend_factor(vk::BlendFactor::CONSTANT_ALPHA)
                        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
                        .alpha_blend_op(vk::BlendOp::ADD)
                        .color_write_mask(color_write_mask)
                        .build()
                })
                .collect();
            state.blend_constants = [blend_comp; 4];

            let cwe_allowed = dynamic_color_write_enable;
            if cwe_allowed && shader_objects.is_none() {
                state.dynamic_states = vec![vk::DynamicState::COLOR_WRITE_ENABLE_EXT];
            } else {
                state.color_write_enables = Some(write_enables[..color_attachment_count].to_vec());
            }

            let pipeline = if shader_objects.is_none() {
                Some(create_draw_pipeline(
                    device,
                    *pipeline_layout,
                    *framebuffers[i as usize].render_pass,
                    &stages,
                    &state,
                )?)
            } else {
                None
            };
            pipelines.push((pipeline, cwe_allowed));
            states.push(state);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buff = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buff;

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]) };

        for a in 0..attachment_count as usize {
            let (pipeline, is_dynamic_cwe) = &pipelines[a];
            let set_cwe = || {
                if *is_dynamic_cwe {
                    unsafe { device.cmd_set_color_write_enable_ext(cmd, &write_enables) };
                }
            };

            if let Some(shader_objects) = &shader_objects {
                let colors: Vec<(vk::Image, vk::ImageView)> = framebuffers[a]
                    .images
                    .iter()
                    .zip(&framebuffers[a]._views)
                    .map(|(image, view)| (image.get(), view.get()))
                    .collect();
                begin_draw(
                    device,
                    cmd,
                    Some(shader_objects),
                    &states[a],
                    None,
                    *framebuffers[a].render_pass,
                    *framebuffers[a].framebuffer,
                    rect_2d(params.width, params.height),
                    &clear_values,
                    &colors,
                );
                set_cwe();
                unsafe { device.cmd_draw(cmd, 6, 1, 0, (a + 1) as u32) };
                end_draw(device, cmd, true);
                continue;
            }

            let pipeline = pipeline.as_ref().expect("pipeline");
            let bind_pipeline =
                || unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get()) };

            if params.set_cwe_before_pl_bind {
                set_cwe();
                bind_pipeline();
            } else {
                bind_pipeline();
                set_cwe();
            }

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*framebuffers[a].render_pass)
                .framebuffer(*framebuffers[a].framebuffer)
                .render_area(rect_2d(params.width, params.height))
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_draw(cmd, 6, 1, 0, (a + 1) as u32);
                device.cmd_end_render_pass(cmd);
            }
        }

        // `readColorAttachment` of every attachment of every framebuffer, in the same submission.
        let buffer_size = (params.width * params.height) as usize * texel_size;
        let mut readbacks = Vec::new();
        for (i, framebuffer) in framebuffers.iter().enumerate() {
            for (a, image) in framebuffer.images.iter().enumerate() {
                let buffer = create_readback_buffer(context, buffer_size as vk::DeviceSize)?;
                copy_image_to_buffer(device, cmd, image.get(), buffer.get(), params.width, params.height);
                readbacks.push((i as u32, a as u32, buffer));
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let mut final_status = TestStatus::pass("");
        for (i, a, buffer) in &readbacks {
            invalidate_alloc(device, buffer.get_allocation())?;
            let bytes = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), buffer_size) };
            let access = ConstPixelBufferAccess::new(tcu_format, [params.width, params.height, 1], bytes);
            let status = self.verify_attachment(*a, i + 1, &access, &write_enables, background, blend_comp);
            if status.is_fail() {
                final_status = status;
            }
        }

        Ok(final_status)
    }
}

impl ColorWriteEnable2Instance<'_> {
    /// `ColorWriteEnable2Instance::verifyAttachment`
    fn verify_attachment(
        &self,
        attachment_index: u32,
        attachment_count: u32,
        attachment_content: &ConstPixelBufferAccess<'_>,
        color_write_enables: &[vk::Bool32],
        background: [f32; 4],
        blend_comp: f32,
    ) -> TestStatus {
        let source = 0.5f32.powf((attachment_count - attachment_index) as f32);
        let expected: [f32; 4] = if color_write_enables[attachment_index as usize] != vk::FALSE {
            let mut color = [source * blend_comp; 4];
            color[(attachment_index % 4) as usize] = background[(attachment_index % 4) as usize];
            color
        } else {
            background
        };

        for y in 0..self.params.height {
            for x in 0..self.params.width {
                let result = attachment_content.get_pixel(x, y, 0);
                if !(0..4).all(|c| (result[c] - expected[c]).abs() < COLOR_THRESHOLD) {
                    return TestStatus::fail(format!(
                        "Unexpected output value found at position ({x}, {y}): expected\n{expected:?} but got\n{result:?})"
                    ));
                }
            }
        }

        TestStatus::pass("")
    }
}

/// `createColorWriteEnable2Tests`
pub fn create_color_write_enable2_tests() -> TestCaseGroup {
    let attachment_counts = [3u32, 4, 5];
    let attachment_mores = [0u32, 1, 2, 3];
    let set_cwe_moments = [(true, "cwe_before_bind"), (false, "cwe_after_bind")];

    let mut root_group = TestCaseGroup::new("color_write_enable_maxa");

    for (set_cwe_before_pl_bind, moment_name) in set_cwe_moments {
        // A moment when cmdSetColorWriteEnableEXT() is called
        let mut set_cwe_group = TestCaseGroup::new(moment_name);

        for attachment_count in attachment_counts {
            for attachment_more in attachment_mores {
                let title = format!("attachments{attachment_count}_more{attachment_more}");
                let params = Params2 {
                    width: 32,
                    height: 32,
                    attachment_count,
                    attachment_more,
                    set_cwe_before_pl_bind,
                };
                set_cwe_group.add_child(Box::new(ColorWriteEnable2Test { name: title, params }) as Box<dyn TestCase>);
            }
        }
        root_group.add_child(set_cwe_group);
    }
    root_group
}
