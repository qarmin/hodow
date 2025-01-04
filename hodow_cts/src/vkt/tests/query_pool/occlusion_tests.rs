// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolOcclusionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Three kinds of case: the basic tests (two slots: an empty capture and a draw), the functional tests
// (three slots: a draw, a partially occluded draw and a fully occluded one, read back by host or by
// vkCmdCopyQueryPoolResults) and the no-attachment tests. The shaders are in
// `shaders/manifest/query_pool_occlusion.toml`.
//
// The `_device_address` variants record vkCmdCopyQueryPoolResultsToMemoryKHR through the hand-written `vk::device_address_commands`
// (vulkanalia has no VK_KHR_device_address_commands). Not ported: the
// attachment-less framebuffer of upstream's `ColorBlendState(1, ...)`, whose single blend attachment is
// dropped for a subpass without colour attachments (a count the specification does not allow).
// Upstream's instance constructors record the command buffers; here iterate does.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::device_address_commands::{
    self, Commands, StridedDeviceAddressRange, buffer_device_address, load_commands,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::{
    initial_transition_color_2d_image, initial_transition_depth_2d_image, transition_2d_image,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares the basic and functional shaders with this: the pair plus the one thing that differs.
pub struct OcclusionProgram {
    pub name: &'static str,
    pub discard_half: bool,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::query_pool_occlusion::{
    OCCLUSION_DISCARD_HALF, OCCLUSION_KEEP_ALL, OCCLUSION_NO_ATTACHMENTS,
};

const WIDTH: u32 = 128;
const HEIGHT: u32 = 128;
const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;

/// `OcclusionQueryResultSize`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ResultSize {
    Bits64,
    Bits32,
}

/// `OcclusionQueryWait`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Wait {
    Queue,
    Query,
    None,
}

/// `OcclusionQueryResultsMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ResultsMode {
    Get,
    GetReset,
    GetCreateReset,
    Copy,
    CopyReset,
}

/// `OcculusionQueryClearOp`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ClearOp {
    Noop,
    Color,
    Depth,
}

/// `OcclusionQueryStride`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Stride {
    ResultSize,
    Zero,
    Max,
}

/// `ClearAttachments`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ClearAttachments {
    None,
    Only,
    WithDraw,
}

/// `AdditionalOp`
#[derive(Clone, Copy, PartialEq, Eq)]
enum AdditionalOp {
    None,
    Blit,
    Resolve,
}

/// `OcclusionQueryTestVector`
#[derive(Clone, Copy)]
struct TestVector {
    query_control_flags: vk::QueryControlFlags,
    query_result_size: ResultSize,
    query_wait: Wait,
    query_results_mode: ResultsMode,
    query_results_stride: vk::DeviceSize,
    query_results_availability: bool,
    primitive_topology: vk::PrimitiveTopology,
    discard_half: bool,
    query_results_dst_offset: bool,
    use_device_address_commands: bool,
    clear_op: ClearOp,
    no_color_attachments: bool,
    stride: Stride,
    clear_attachments: ClearAttachments,
    additional_op: AdditionalOp,
}

impl TestVector {
    /// `baseTestVector`
    fn base() -> Self {
        Self {
            query_control_flags: vk::QueryControlFlags::empty(),
            query_result_size: ResultSize::Bits64,
            query_wait: Wait::Queue,
            query_results_mode: ResultsMode::Get,
            query_results_stride: std::mem::size_of::<u64>() as vk::DeviceSize,
            query_results_availability: false,
            primitive_topology: vk::PrimitiveTopology::POINT_LIST,
            discard_half: false,
            query_results_dst_offset: false,
            use_device_address_commands: false,
            clear_op: ClearOp::Noop,
            no_color_attachments: false,
            stride: Stride::ResultSize,
            clear_attachments: ClearAttachments::None,
            additional_op: AdditionalOp::None,
        }
    }

    fn element_size(&self) -> vk::DeviceSize {
        if self.query_result_size == ResultSize::Bits32 {
            std::mem::size_of::<u32>() as vk::DeviceSize
        } else {
            std::mem::size_of::<u64>() as vk::DeviceSize
        }
    }

    fn is_copy_mode(&self) -> bool {
        matches!(self.query_results_mode, ResultsMode::Copy | ResultsMode::CopyReset)
    }

    fn is_precise(&self) -> bool {
        self.query_control_flags.contains(vk::QueryControlFlags::PRECISE)
    }

    /// `m_queryResultFlags`
    fn query_result_flags(&self) -> vk::QueryResultFlags {
        let mut flags = vk::QueryResultFlags::empty();
        if self.query_wait == Wait::Query && self.query_results_mode != ResultsMode::CopyReset {
            flags |= vk::QueryResultFlags::WAIT;
        }
        if self.query_result_size == ResultSize::Bits64 {
            flags |= vk::QueryResultFlags::_64;
        }
        if self.query_results_availability {
            flags |= vk::QueryResultFlags::WITH_AVAILABILITY;
        }
        flags
    }

    /// `hasSeparateResetCmdBuf`: the reset goes into its own command buffer, submitted and completed before
    /// the host reads, to avoid a race between host query access and device query reset.
    fn has_separate_reset_cmd_buf(&self) -> bool {
        if self.is_copy_mode() {
            // We copy query results on device, so there is no race condition between host and device
            return false;
        }
        if self.query_wait == Wait::Queue {
            // We wait for queue to be complete before accessing query results
            return false;
        }
        true
    }

    /// `hasSeparateCopyCmdBuf`: copying the results has to be a separate submission if the queue is waited on before.
    fn has_separate_copy_cmd_buf(&self) -> bool {
        self.is_copy_mode() && self.query_wait == Wait::Queue
    }
}

fn make_occlusion_query_pool(
    device: &Device,
    num_queries: u32,
    create_reset: bool,
) -> Result<Unique<'_, vk::QueryPool>, TestError> {
    let flags = if create_reset {
        vk::QueryPoolCreateFlags::RESET_KHR
    } else {
        vk::QueryPoolCreateFlags::empty()
    };
    let info = vk::QueryPoolCreateInfo::builder()
        .flags(flags)
        .query_type(vk::QueryType::OCCLUSION)
        .query_count(num_queries);
    Ok(Unique::new(
        device,
        unsafe { device.create_query_pool(&info, None) }.vk_check("vkCreateQueryPool")?,
    ))
}

/// `StateObjects`
struct StateObjects<'a> {
    // Declared so that fields drop in dependency order: users of an object before the object.
    pipeline: Unique<'a, vk::Pipeline>,
    _pipeline_layout: Unique<'a, vk::PipelineLayout>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    _depth_view: Unique<'a, vk::ImageView>,
    _attachment_view: Option<Unique<'a, vk::ImageView>>,
    color_attachment_image: Option<ImageWithMemory<'a>>,
    depth_image: ImageWithMemory<'a>,
    src_image: Option<ImageWithMemory<'a>>,
    dst_image: Option<ImageWithMemory<'a>>,
    vertex_buffer: BufferWithMemory<'a>,
}

fn image_info(format: vk::Format, samples: vk::SampleCountFlags, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

impl<'a> StateObjects<'a> {
    fn new(
        context: &'a Context<'a>,
        num_vertices: u32,
        primitive: vk::PrimitiveTopology,
        no_color_attachments: bool,
        blit: bool,
        resolve: bool,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let depth_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                DEPTH_FORMAT,
                vk::SampleCountFlags::_1,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        // Construct a depth view from depth image
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        let depth_attachment = vk::AttachmentDescription::builder()
            .format(DEPTH_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();

        // Renderpass and Framebuffer
        let (color_attachment_image, attachment_view, render_pass, framebuffer);
        if no_color_attachments {
            let attachments = [depth_attachment];
            let depth_attachment_reference = vk::AttachmentReference::builder()
                .attachment(0)
                .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build();
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .depth_stencil_attachment(&depth_attachment_reference)
                .build()];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
            );
            framebuffer = make_framebuffer(device, *render_pass, &[*depth_view], WIDTH, HEIGHT, 1)?;
            color_attachment_image = None;
            attachment_view = None;
        } else {
            let image = ImageWithMemory::new(
                device,
                allocator,
                image_info(
                    COLOR_ATTACHMENT_FORMAT,
                    vk::SampleCountFlags::_1,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                ),
                MemoryRequirement::ANY,
            )?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                COLOR_ATTACHMENT_FORMAT,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?;

            let attachments = [
                vk::AttachmentDescription::builder()
                    .format(COLOR_ATTACHMENT_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::GENERAL)
                    .final_layout(vk::ImageLayout::GENERAL)
                    .build(),
                depth_attachment,
            ];
            let color_attachment_references = [vk::AttachmentReference::builder()
                .attachment(0)
                .layout(vk::ImageLayout::GENERAL)
                .build()];
            let depth_attachment_reference = vk::AttachmentReference::builder()
                .attachment(1)
                .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build();
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachment_references)
                .depth_stencil_attachment(&depth_attachment_reference)
                .build()];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
            );
            framebuffer = make_framebuffer(device, *render_pass, &[*view, *depth_view], WIDTH, HEIGHT, 1)?;
            color_attachment_image = Some(image);
            attachment_view = Some(view);
        }

        let transfer_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let (src_image, dst_image) = if blit {
            (
                Some(ImageWithMemory::new(
                    device,
                    allocator,
                    image_info(COLOR_ATTACHMENT_FORMAT, vk::SampleCountFlags::_1, transfer_usage),
                    MemoryRequirement::ANY,
                )?),
                Some(ImageWithMemory::new(
                    device,
                    allocator,
                    image_info(COLOR_ATTACHMENT_FORMAT, vk::SampleCountFlags::_1, transfer_usage),
                    MemoryRequirement::ANY,
                )?),
            )
        } else if resolve {
            (
                Some(ImageWithMemory::new(
                    device,
                    allocator,
                    image_info(COLOR_ATTACHMENT_FORMAT, vk::SampleCountFlags::_4, transfer_usage),
                    MemoryRequirement::ANY,
                )?),
                Some(ImageWithMemory::new(
                    device,
                    allocator,
                    image_info(COLOR_ATTACHMENT_FORMAT, vk::SampleCountFlags::_1, transfer_usage),
                    MemoryRequirement::ANY,
                )?),
            )
        } else {
            (None, None)
        };

        // Pipeline
        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let vf_binding_descs = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 4 * std::mem::size_of::<f32>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vf_attribute_descs = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vf_binding_descs)
            .vertex_attribute_descriptions(&vf_attribute_descs);

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vs)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fs)
                .name(b"main\0")
                .build(),
        ];
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(primitive)
            .primitive_restart_enable(false);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let used_blend_attachments: &[vk::PipelineColorBlendAttachmentState] = if no_color_attachments {
            &[]
        } else {
            &color_blend_attachments
        };
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(used_blend_attachments);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: WIDTH as f32,
            height: HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::GREATER_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(true)
            .depth_bias_constant_factor(0.0)
            .depth_bias_clamp(0.0)
            .depth_bias_slope_factor(0.0)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // Vertex buffer
        let vertex_buffer_size = num_vertices as vk::DeviceSize * std::mem::size_of::<[f32; 4]>() as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        Ok(Self {
            pipeline,
            _pipeline_layout: pipeline_layout,
            framebuffer,
            render_pass,
            _depth_view: depth_view,
            _attachment_view: attachment_view,
            color_attachment_image,
            depth_image,
            src_image,
            dst_image,
            vertex_buffer,
        })
    }

    /// `StateObjects::setVertices`
    fn set_vertices(&self, device: &Device, vertices: &[[f32; 4]]) -> Result<(), TestError> {
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                self.vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(vertices),
            )
        };
        flush_alloc(device, self.vertex_buffer.get_allocation())
    }
}

fn render_area() -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: WIDTH,
            height: HEIGHT,
        },
    }
}

/// `beginRenderPass` with two zeroed clear values.
fn begin_render_pass(device: &Device, cmd: vk::CommandBuffer, state_objects: &StateObjects<'_>) {
    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    }; 2];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*state_objects.render_pass)
        .framebuffer(*state_objects.framebuffer)
        .render_area(render_area())
        .clear_values(&clear_values);
    unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
}

fn transition_color_to_transfer_src(device: &Device, cmd: vk::CommandBuffer, state_objects: &StateObjects<'_>) {
    if let Some(image) = &state_objects.color_attachment_image {
        transition_2d_image(
            device,
            cmd,
            image.get(),
            vk::ImageAspectFlags::COLOR,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            1,
        );
    }
}

fn initial_transition_attachments(device: &Device, cmd: vk::CommandBuffer, state_objects: &StateObjects<'_>) {
    if let Some(image) = &state_objects.color_attachment_image {
        initial_transition_color_2d_image(
            device,
            cmd,
            image.get(),
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            1,
        );
    }
    initial_transition_depth_2d_image(
        device,
        cmd,
        state_objects.depth_image.get(),
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
    );
}

fn queue_submit_one(device: &Device, queue: vk::Queue, cmd: vk::CommandBuffer) -> Result<(), TestError> {
    let command_buffers = [cmd];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
    unsafe { device.queue_submit(queue, &[submit_info], vk::Fence::null()) }.vk_check("vkQueueSubmit")
}

fn queue_wait_idle(device: &Device, queue: vk::Queue) -> Result<(), TestError> {
    unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum InstanceKind {
    Basic,
    Full,
}

/// `QueryPoolOcclusionTest<Instance>`
struct QueryPoolOcclusionTest {
    name: String,
    kind: InstanceKind,
    test_vector: TestVector,
}

impl TestCase for QueryPoolOcclusionTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let vector = &self.test_vector;

        if vector.use_device_address_commands {
            context.require_device_functionality(device_address_commands::EXTENSION_NAME)?;
        }

        if vector.is_precise() && context.get_device_features().occlusion_query_precise == vk::FALSE {
            return Err(TestError::NotSupported(
                "Precise occlusion queries are not supported".to_string(),
            ));
        }

        let mut features12 = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features12);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };

        if self.kind == InstanceKind::Basic {
            if vector.query_results_mode == ResultsMode::GetReset {
                // Check VK_EXT_host_query_reset is supported
                context.require_device_functionality("VK_EXT_host_query_reset")?;
                if features12.host_query_reset == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Implementation doesn't support resetting queries from the host".to_string(),
                    ));
                }
            }
            if vector.additional_op == AdditionalOp::Resolve {
                let properties = unsafe {
                    context.get_instance().get_physical_device_image_format_properties(
                        context.get_physical_device(),
                        COLOR_ATTACHMENT_FORMAT,
                        vk::ImageType::_2D,
                        vk::ImageTiling::OPTIMAL,
                        vk::ImageUsageFlags::TRANSFER_SRC,
                        vk::ImageCreateFlags::empty(),
                    )
                };
                match properties {
                    Ok(properties) if properties.sample_counts.contains(vk::SampleCountFlags::_4) => {}
                    _ => {
                        return Err(TestError::NotSupported(
                            "Required sample count not supported".to_string(),
                        ));
                    }
                }
            }
        } else if vector.query_results_mode == ResultsMode::GetCreateReset {
            // Check VK_KHR_maintenance9 is supported
            context.require_device_functionality("VK_KHR_maintenance9")?;
            let mut maintenance9 = vk::PhysicalDeviceMaintenance9FeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut maintenance9);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if maintenance9.maintenance9 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Implementation doesn't support creating reset queries".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.test_vector.discard_half {
            OCCLUSION_DISCARD_HALF.programs
        } else {
            OCCLUSION_KEEP_ALL.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        match self.kind {
            InstanceKind::Basic => Box::new(BasicOcclusionQueryInstance {
                context,
                test_vector: self.test_vector,
            }),
            InstanceKind::Full => Box::new(OcclusionQueryInstance {
                context,
                test_vector: self.test_vector,
            }),
        }
    }
}

// ---------------------------------------------------------------------------------
// BasicOcclusionQueryTestInstance
// ---------------------------------------------------------------------------------

const BASIC_NUM_QUERIES_IN_POOL: u32 = 2;
const BASIC_QUERY_INDEX_CAPTURE_EMPTY: u32 = 0;
const BASIC_QUERY_INDEX_CAPTURE_DRAWCALL: u32 = 1;
const BASIC_NUM_VERTICES_IN_DRAWCALL: u32 = 3;

/// `BasicOcclusionQueryTestInstance`
struct BasicOcclusionQueryInstance<'a> {
    context: &'a Context<'a>,
    test_vector: TestVector,
}

impl BasicOcclusionQueryInstance<'_> {
    /// `clearAttachments`
    fn clear_attachments(&self, cmd: vk::CommandBuffer) {
        let device = self.context.get_device();
        let attachment = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        };
        let rect = vk::ClearRect {
            rect: render_area(),
            base_array_layer: 0,
            layer_count: 1,
        };
        unsafe { device.cmd_clear_attachments(cmd, &[attachment], &[rect]) };
    }
}

impl TestInstance for BasicOcclusionQueryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vector = self.test_vector;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let state_objects = StateObjects::new(
            context,
            BASIC_NUM_VERTICES_IN_DRAWCALL,
            vector.primitive_topology,
            vector.no_color_attachments,
            vector.additional_op == AdditionalOp::Blit,
            vector.additional_op == AdditionalOp::Resolve,
        )?;
        let query_pool = make_occlusion_query_pool(device, BASIC_NUM_QUERIES_IN_POOL, false)?;

        let vertices: [[f32; 4]; 3] = [[0.5, 0.5, 0.0, 1.0], [0.5, 0.0, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0]];
        state_objects.set_vertices(device, &vertices)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let bind_point = vk::PipelineBindPoint::GRAPHICS;

        begin_command_buffer(device, cmd)?;

        if !vector.no_color_attachments
            && let Some(image) = &state_objects.color_attachment_image
        {
            initial_transition_color_2d_image(
                device,
                cmd,
                image.get(),
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                1,
            );
        }

        if vector.additional_op != AdditionalOp::None {
            let (src, dst) = (
                state_objects
                    .src_image
                    .as_ref()
                    .expect("blit and resolve make the images"),
                state_objects
                    .dst_image
                    .as_ref()
                    .expect("blit and resolve make the images"),
            );
            initial_transition_color_2d_image(
                device,
                cmd,
                src.get(),
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::TRANSFER_READ,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
            initial_transition_color_2d_image(
                device,
                cmd,
                dst.get(),
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
        }

        initial_transition_depth_2d_image(
            device,
            cmd,
            state_objects.depth_image.get(),
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        );

        if vector.query_results_mode != ResultsMode::GetReset {
            unsafe { device.cmd_reset_query_pool(cmd, *query_pool, 0, BASIC_NUM_QUERIES_IN_POOL) };
        }

        if vector.additional_op == AdditionalOp::None {
            begin_render_pass(device, cmd, &state_objects);
        }

        unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, *state_objects.pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[state_objects.vertex_buffer.get()], &[0]);

            device.cmd_begin_query(
                cmd,
                *query_pool,
                BASIC_QUERY_INDEX_CAPTURE_EMPTY,
                vector.query_control_flags,
            );
        }

        let color_layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };
        let full_extent = vk::Offset3D {
            x: WIDTH as i32,
            y: HEIGHT as i32,
            z: 1,
        };
        match vector.additional_op {
            AdditionalOp::Blit => {
                let region = vk::ImageBlit {
                    src_subresource: color_layers,
                    src_offsets: [vk::Offset3D { x: 0, y: 0, z: 0 }, full_extent],
                    dst_subresource: color_layers,
                    dst_offsets: [vk::Offset3D { x: 0, y: 0, z: 0 }, full_extent],
                };
                let (src, dst) = (
                    state_objects.src_image.as_ref().expect("blit makes the images"),
                    state_objects.dst_image.as_ref().expect("blit makes the images"),
                );
                unsafe {
                    device.cmd_blit_image(
                        cmd,
                        src.get(),
                        vk::ImageLayout::GENERAL,
                        dst.get(),
                        vk::ImageLayout::GENERAL,
                        &[region],
                        vk::Filter::NEAREST,
                    )
                };
            }
            AdditionalOp::Resolve => {
                let region = vk::ImageResolve {
                    src_subresource: color_layers,
                    src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    dst_subresource: color_layers,
                    dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    extent: vk::Extent3D {
                        width: WIDTH,
                        height: HEIGHT,
                        depth: 1,
                    },
                };
                let (src, dst) = (
                    state_objects.src_image.as_ref().expect("resolve makes the images"),
                    state_objects.dst_image.as_ref().expect("resolve makes the images"),
                );
                unsafe {
                    device.cmd_resolve_image(
                        cmd,
                        src.get(),
                        vk::ImageLayout::GENERAL,
                        dst.get(),
                        vk::ImageLayout::GENERAL,
                        &[region],
                    )
                };
            }
            AdditionalOp::None => {}
        }

        unsafe { device.cmd_end_query(cmd, *query_pool, BASIC_QUERY_INDEX_CAPTURE_EMPTY) };

        if vector.additional_op != AdditionalOp::None {
            begin_render_pass(device, cmd, &state_objects);
        }

        unsafe {
            device.cmd_begin_query(
                cmd,
                *query_pool,
                BASIC_QUERY_INDEX_CAPTURE_DRAWCALL,
                vector.query_control_flags,
            )
        };

        if vector.clear_attachments != ClearAttachments::None {
            self.clear_attachments(cmd);
        }

        if vector.clear_attachments != ClearAttachments::Only {
            unsafe { device.cmd_draw(cmd, BASIC_NUM_VERTICES_IN_DRAWCALL, 1, 0, 0) };
        }

        if vector.clear_attachments == ClearAttachments::WithDraw {
            self.clear_attachments(cmd);
        }

        unsafe {
            device.cmd_end_query(cmd, *query_pool, BASIC_QUERY_INDEX_CAPTURE_DRAWCALL);
            device.cmd_end_render_pass(cmd);
        }

        if !vector.no_color_attachments {
            transition_color_to_transfer_src(device, cmd, &state_objects);
        }

        end_command_buffer(device, cmd)?;

        if vector.query_results_mode == ResultsMode::GetReset {
            unsafe { device.reset_query_pool(*query_pool, 0, BASIC_NUM_QUERIES_IN_POOL) };
        }

        submit_commands_and_wait(device, queue, cmd)?;

        let mut query_results_bytes = [0u8; 16];
        let mut query_result = vk::SuccessCode::NOT_READY;

        let result_flags = vk::QueryResultFlags::_64;
        match vector.stride {
            Stride::ResultSize => {
                query_result = unsafe {
                    device.get_query_pool_results(
                        *query_pool,
                        0,
                        BASIC_NUM_QUERIES_IN_POOL,
                        &mut query_results_bytes,
                        8,
                        result_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
            }
            Stride::Zero | Stride::Max => {
                for i in 0..BASIC_NUM_QUERIES_IN_POOL as usize {
                    // Upstream passes `queryResultsSize` as the data size here, which overshoots the 8 bytes left for the last query.
                    let stride = if vector.stride == Stride::Zero {
                        0
                    } else {
                        u64::MAX / 8 * 8
                    };
                    query_result = unsafe {
                        device.get_query_pool_results(
                            *query_pool,
                            i as u32,
                            1,
                            &mut query_results_bytes[i * 8..i * 8 + 8],
                            stride,
                            result_flags,
                        )
                    }
                    .vk_check("vkGetQueryPoolResults")?;
                }
            }
        }

        if query_result == vk::SuccessCode::NOT_READY {
            return Err(TestError::Fail(
                "Query result not avaliable, but vkWaitIdle() was called.".to_string(),
            ));
        }

        let query_results: [u64; 2] = std::array::from_fn(|index| {
            u64::from_ne_bytes(
                query_results_bytes[index * 8..index * 8 + 8]
                    .try_into()
                    .expect("eight bytes per result"),
            )
        });
        let mut failures = Vec::new();

        for (query_index, &result) in query_results.iter().enumerate() {
            let expected_value = if vector.clear_attachments == ClearAttachments::Only
                || query_index as u32 == BASIC_QUERY_INDEX_CAPTURE_EMPTY
            {
                0
            } else {
                u64::from(BASIC_NUM_VERTICES_IN_DRAWCALL)
            };

            if vector.is_precise() || expected_value == 0 {
                // require precise value
                if result != expected_value {
                    failures.push(format!("vkGetQueryPoolResults returned wrong value of query for index {query_index}, expected {expected_value}, got {}.", query_results[0]));
                }
            } else if result == 0 {
                // require imprecize value > 0
                failures.push(format!("vkGetQueryPoolResults returned wrong value of query for index {query_index}, expected any non-zero value, got {}.", query_results[0]));
            }
        }

        if failures.is_empty() {
            Ok(TestStatus::pass("Query result verification passed"))
        } else {
            Ok(TestStatus::fail(format!(
                "Query result verification failed: {}",
                failures.join(" ")
            )))
        }
    }
}

// ---------------------------------------------------------------------------------
// OcclusionQueryTestInstance
// ---------------------------------------------------------------------------------

const NUM_QUERIES_IN_POOL: usize = 3;
const QUERY_INDEX_CAPTURE_ALL: usize = 0;
const QUERY_INDEX_CAPTURE_PARTIALLY_OCCLUDED: usize = 1;
const QUERY_INDEX_CAPTURE_OCCLUDED: usize = 2;
const NUM_VERTICES_IN_DRAWCALL: u32 = 3;
const NUM_VERTICES_IN_PARTIALLY_OCCLUDED_DRAWCALL: u32 = 3;
const NUM_VERTICES_IN_OCCLUDER_DRAWCALL: u32 = 3;
const NUM_VERTICES: u32 =
    NUM_VERTICES_IN_DRAWCALL + NUM_VERTICES_IN_PARTIALLY_OCCLUDED_DRAWCALL + NUM_VERTICES_IN_OCCLUDER_DRAWCALL;
const START_VERTEX: u32 = 0;
const START_VERTEX_PARTIALLY_OCCLUDED: u32 = START_VERTEX + NUM_VERTICES_IN_DRAWCALL;
const START_VERTEX_OCCLUDER: u32 = START_VERTEX_PARTIALLY_OCCLUDED + NUM_VERTICES_IN_PARTIALLY_OCCLUDED_DRAWCALL;

/// What the constructor of upstream's `OcclusionQueryTestInstance` builds.
struct FullResources<'a> {
    state_objects: StateObjects<'a>,
    query_pool: Unique<'a, vk::QueryPool>,
    query_pool_results_buffer_size: vk::DeviceSize,
    query_pool_results_buffer: Option<BufferWithMemory<'a>>,
    query_pool_results_buffer_device_address: vk::DeviceAddress,
    address_commands: Option<Commands>,
    command_pool: Unique<'a, vk::CommandPool>,
}

/// `OcclusionQueryTestInstance`
struct OcclusionQueryInstance<'a> {
    context: &'a Context<'a>,
    test_vector: TestVector,
}

impl<'a> OcclusionQueryInstance<'a> {
    fn create_resources(&self) -> Result<FullResources<'a>, TestError> {
        let context = self.context;
        let vector = &self.test_vector;
        let device = context.get_device();

        let state_objects = StateObjects::new(
            context,
            NUM_VERTICES,
            vector.primitive_topology,
            vector.no_color_attachments,
            vector.additional_op == AdditionalOp::Blit,
            vector.additional_op == AdditionalOp::Resolve,
        )?;
        let query_pool = make_occlusion_query_pool(
            device,
            NUM_QUERIES_IN_POOL as u32,
            vector.query_results_mode == ResultsMode::GetCreateReset,
        )?;

        let mut query_pool_results_buffer_size = 0;
        let mut query_pool_results_buffer = None;
        let mut query_pool_results_buffer_device_address = 0;
        if vector.is_copy_mode() {
            let num_queries_in_pool = NUM_QUERIES_IN_POOL as u64 + if vector.query_results_dst_offset { 1 } else { 0 };
            let element_size = vector.element_size();
            query_pool_results_buffer_size = if vector.query_results_stride == 0 {
                (element_size + element_size * u64::from(vector.query_results_availability)) * num_queries_in_pool
            } else {
                vector.query_results_stride * num_queries_in_pool
            };

            let (usage, requirement) = if vector.use_device_address_commands {
                (
                    vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
                    MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
                )
            } else {
                (vk::BufferUsageFlags::TRANSFER_DST, MemoryRequirement::HOST_VISIBLE)
            };
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(query_pool_results_buffer_size, usage),
                requirement,
            )?;
            if vector.use_device_address_commands {
                query_pool_results_buffer_device_address = buffer_device_address(device, buffer.get());
            }
            query_pool_results_buffer = Some(buffer);
        }
        let address_commands = if vector.use_device_address_commands {
            Some(load_commands(context)?)
        } else {
            None
        };

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        Ok(FullResources {
            state_objects,
            query_pool,
            query_pool_results_buffer_size,
            query_pool_results_buffer,
            query_pool_results_buffer_device_address,
            address_commands,
            command_pool,
        })
    }

    /// `recordQueryPoolReset`
    fn record_query_pool_reset(&self, res: &FullResources<'a>) -> Result<UniqueCommandBuffer<'a>, TestError> {
        let device = self.context.get_device();
        let cmd_buffer = allocate_command_buffer(device, *res.command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe { device.cmd_reset_query_pool(*cmd_buffer, *res.query_pool, 0, NUM_QUERIES_IN_POOL as u32) };
        end_command_buffer(device, *cmd_buffer)?;
        Ok(cmd_buffer)
    }

    /// `commandClearAttachment`
    fn command_clear_attachment(&self, cmd: vk::CommandBuffer) {
        if self.test_vector.clear_op == ClearOp::Noop {
            return;
        }

        let device = self.context.get_device();
        let clear_color = self.test_vector.clear_op == ClearOp::Color;
        let attachment = vk::ClearAttachment {
            aspect_mask: if clear_color {
                vk::ImageAspectFlags::COLOR
            } else {
                vk::ImageAspectFlags::DEPTH
            },
            color_attachment: if clear_color { 0 } else { 1 },
            clear_value: if clear_color {
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: [0.0; 4] },
                }
            } else {
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
                }
            },
        };
        let rect = vk::ClearRect {
            rect: render_area(),
            base_array_layer: 0,
            layer_count: 1,
        };
        unsafe { device.cmd_clear_attachments(cmd, &[attachment], &[rect]) };
    }

    /// `cmdCopyQueryPoolResults`
    #[allow(clippy::too_many_arguments)]
    fn cmd_copy_query_pool_results(
        &self,
        res: &FullResources<'a>,
        cmd: vk::CommandBuffer,
        query_pool: vk::QueryPool,
        first_query: u32,
        query_count: u32,
        dst_buffer: vk::Buffer,
        dst_offset: vk::DeviceSize,
        stride: vk::DeviceSize,
    ) {
        let device = self.context.get_device();
        if let Some(commands) = &res.address_commands {
            let range = StridedDeviceAddressRange {
                address: res.query_pool_results_buffer_device_address + dst_offset,
                size: res.query_pool_results_buffer_size - dst_offset,
                stride,
            };
            unsafe {
                (commands.copy_query_pool_results_to_memory)(
                    cmd,
                    query_pool,
                    first_query,
                    query_count,
                    &range,
                    0,
                    self.test_vector.query_result_flags(),
                )
            };
            return;
        }
        unsafe {
            device.cmd_copy_query_pool_results(
                cmd,
                query_pool,
                first_query,
                query_count,
                dst_buffer,
                dst_offset,
                stride,
                self.test_vector.query_result_flags(),
            )
        };
    }

    /// The copies `recordRender` and `recordCopyResults` both record, followed by the barrier for the host.
    fn record_copy_results_commands(&self, res: &FullResources<'a>, cmd: vk::CommandBuffer) {
        let device = self.context.get_device();
        let vector = &self.test_vector;
        let buffer = res
            .query_pool_results_buffer
            .as_ref()
            .expect("copy modes make the results buffer")
            .get();
        let dst_offset = if vector.query_results_dst_offset {
            vector.query_results_stride
        } else {
            0
        };

        if vector.query_results_stride != 0 {
            self.cmd_copy_query_pool_results(
                res,
                cmd,
                *res.query_pool,
                0,
                NUM_QUERIES_IN_POOL as u32,
                buffer,
                dst_offset,
                vector.query_results_stride,
            );
        } else {
            let element_size = vector.element_size();
            let stride_size = element_size + element_size * u64::from(vector.query_results_availability);

            for query_index in 0..NUM_QUERIES_IN_POOL {
                self.cmd_copy_query_pool_results(
                    res,
                    cmd,
                    *res.query_pool,
                    query_index as u32,
                    1,
                    buffer,
                    stride_size * query_index as u64,
                    0,
                );
            }
        }

        let barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer,
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `recordRender`
    fn record_render(&self, res: &FullResources<'a>) -> Result<UniqueCommandBuffer<'a>, TestError> {
        let device = self.context.get_device();
        let vector = &self.test_vector;
        let state_objects = &res.state_objects;
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let cmd_buffer = allocate_command_buffer(device, *res.command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let query_pool = *res.query_pool;
        let flags = vector.query_control_flags;

        begin_command_buffer(device, cmd)?;

        initial_transition_attachments(device, cmd, state_objects);

        if !vector.has_separate_reset_cmd_buf()
            && vector.query_results_mode != ResultsMode::GetReset
            && vector.query_results_mode != ResultsMode::GetCreateReset
        {
            unsafe { device.cmd_reset_query_pool(cmd, query_pool, 0, NUM_QUERIES_IN_POOL as u32) };
        }

        begin_render_pass(device, cmd, state_objects);
        unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, *state_objects.pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[state_objects.vertex_buffer.get()], &[0]);

            // Draw un-occluded geometry
            device.cmd_begin_query(cmd, query_pool, QUERY_INDEX_CAPTURE_ALL as u32, flags);
            device.cmd_draw(cmd, NUM_VERTICES_IN_DRAWCALL, 1, START_VERTEX, 0);
        }
        self.command_clear_attachment(cmd);
        unsafe {
            device.cmd_end_query(cmd, query_pool, QUERY_INDEX_CAPTURE_ALL as u32);
            device.cmd_end_render_pass(cmd);
        }

        begin_render_pass(device, cmd, state_objects);
        unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, *state_objects.pipeline);

            // Draw un-occluded geometry
            device.cmd_draw(cmd, NUM_VERTICES_IN_DRAWCALL, 1, START_VERTEX, 0);

            // Partially occlude geometry
            device.cmd_draw(
                cmd,
                NUM_VERTICES_IN_PARTIALLY_OCCLUDED_DRAWCALL,
                1,
                START_VERTEX_PARTIALLY_OCCLUDED,
                0,
            );

            // Draw partially-occluded geometry
            device.cmd_begin_query(cmd, query_pool, QUERY_INDEX_CAPTURE_PARTIALLY_OCCLUDED as u32, flags);
            device.cmd_draw(cmd, NUM_VERTICES_IN_DRAWCALL, 1, START_VERTEX, 0);
        }
        self.command_clear_attachment(cmd);
        unsafe {
            device.cmd_end_query(cmd, query_pool, QUERY_INDEX_CAPTURE_PARTIALLY_OCCLUDED as u32);
            device.cmd_end_render_pass(cmd);
        }

        begin_render_pass(device, cmd, state_objects);
        unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, *state_objects.pipeline);

            // Draw un-occluded geometry
            device.cmd_draw(cmd, NUM_VERTICES_IN_DRAWCALL, 1, START_VERTEX, 0);

            // Partially occlude geometry
            device.cmd_draw(
                cmd,
                NUM_VERTICES_IN_PARTIALLY_OCCLUDED_DRAWCALL,
                1,
                START_VERTEX_PARTIALLY_OCCLUDED,
                0,
            );

            // Occlude geometry
            device.cmd_draw(cmd, NUM_VERTICES_IN_OCCLUDER_DRAWCALL, 1, START_VERTEX_OCCLUDER, 0);

            // Draw occluded geometry
            device.cmd_begin_query(cmd, query_pool, QUERY_INDEX_CAPTURE_OCCLUDED as u32, flags);
            device.cmd_draw(cmd, NUM_VERTICES_IN_DRAWCALL, 1, START_VERTEX, 0);
        }
        self.command_clear_attachment(cmd);
        unsafe {
            device.cmd_end_query(cmd, query_pool, QUERY_INDEX_CAPTURE_OCCLUDED as u32);
            device.cmd_end_render_pass(cmd);
        }

        if vector.query_results_mode == ResultsMode::CopyReset {
            unsafe { device.cmd_reset_query_pool(cmd, query_pool, 0, NUM_QUERIES_IN_POOL as u32) };
        }

        if vector.is_copy_mode() && !vector.has_separate_copy_cmd_buf() {
            self.record_copy_results_commands(res, cmd);
        }

        if !vector.no_color_attachments {
            transition_color_to_transfer_src(device, cmd, state_objects);
        }

        end_command_buffer(device, cmd)?;
        Ok(cmd_buffer)
    }

    /// `recordCopyResults`
    fn record_copy_results(&self, res: &FullResources<'a>) -> Result<UniqueCommandBuffer<'a>, TestError> {
        let device = self.context.get_device();
        let cmd_buffer = allocate_command_buffer(device, *res.command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;
        self.record_copy_results_commands(res, *cmd_buffer);
        end_command_buffer(device, *cmd_buffer)?;
        Ok(cmd_buffer)
    }

    /// Splits `bytes` (one slot of `slot_size` bytes per query) into results and availability words.
    fn parse_results(
        &self,
        bytes: &[u8],
        slot_size: usize,
    ) -> ([u64; NUM_QUERIES_IN_POOL], [u64; NUM_QUERIES_IN_POOL]) {
        let vector = &self.test_vector;
        let element = vector.element_size() as usize;
        let read = |offset: usize| -> u64 {
            if vector.query_result_size == ResultSize::Bits32 {
                u64::from(u32::from_ne_bytes(
                    bytes[offset..offset + 4].try_into().expect("four bytes"),
                ))
            } else {
                u64::from_ne_bytes(bytes[offset..offset + 8].try_into().expect("eight bytes"))
            }
        };

        let mut results = [0u64; NUM_QUERIES_IN_POOL];
        let mut availability = [0u64; NUM_QUERIES_IN_POOL];
        for query_index in 0..NUM_QUERIES_IN_POOL {
            results[query_index] = read(query_index * slot_size);
            if vector.query_results_availability {
                availability[query_index] = read(query_index * slot_size + element);
            }
        }
        (results, availability)
    }

    /// `captureResults`
    fn capture_results(
        &self,
        res: &FullResources<'a>,
    ) -> Result<([u64; NUM_QUERIES_IN_POOL], [u64; NUM_QUERIES_IN_POOL], Option<String>), TestError> {
        let device = self.context.get_device();
        let vector = &self.test_vector;
        let allow_not_ready = vector.query_wait == Wait::None;
        let element_size = vector.element_size();
        let results_size = if vector.query_results_stride == 0 {
            element_size + element_size * u64::from(vector.query_results_availability)
        } else {
            vector.query_results_stride
        } as usize;
        let mut results_buffer = vec![0u8; results_size * NUM_QUERIES_IN_POOL];
        let query_pool = *res.query_pool;
        let result_flags = vector.query_result_flags();

        if matches!(
            vector.query_results_mode,
            ResultsMode::Get | ResultsMode::GetReset | ResultsMode::GetCreateReset
        ) {
            let query_result = unsafe {
                device.get_query_pool_results(
                    query_pool,
                    0,
                    NUM_QUERIES_IN_POOL as u32,
                    &mut results_buffer,
                    vector.query_results_stride,
                    result_flags,
                )
            }
            .vk_check("vkGetQueryPoolResults")?;
            if query_result == vk::SuccessCode::NOT_READY && !allow_not_ready {
                return Err(TestError::Fail(
                    "getQueryPoolResults returned VK_NOT_READY, but results should be already available.".to_string(),
                ));
            }
        } else if vector.is_copy_mode() {
            let buffer = res
                .query_pool_results_buffer
                .as_ref()
                .expect("copy modes make the results buffer");
            let allocation = buffer.get_allocation();
            let index_data = if vector.query_results_dst_offset {
                vector.query_results_stride as usize
            } else {
                0
            };

            invalidate_alloc(device, allocation)?;
            let allocation_data = unsafe {
                std::slice::from_raw_parts(allocation.get_host_ptr(), res.query_pool_results_buffer_size as usize)
            };
            let results_len = results_buffer.len();
            results_buffer.copy_from_slice(&allocation_data[index_data..index_data + results_len]);
        }

        let (results, availability) = self.parse_results(&results_buffer, results_size);

        // The query results are read again after a host reset: the values stay, the availability goes.
        let mut reset_failure = None;
        if vector.query_results_mode == ResultsMode::GetReset {
            unsafe { device.reset_query_pool(query_pool, 0, NUM_QUERIES_IN_POOL as u32) };

            let query_result = unsafe {
                device.get_query_pool_results(
                    query_pool,
                    0,
                    NUM_QUERIES_IN_POOL as u32,
                    &mut results_buffer,
                    vector.query_results_stride,
                    result_flags,
                )
            }
            .vk_check("vkGetQueryPoolResults")?;
            if query_result != vk::SuccessCode::NOT_READY {
                return Err(TestError::Fail(
                    "getQueryPoolResults did not return VK_NOT_READY".to_string(),
                ));
            }

            // From Vulkan spec: if VK_QUERY_RESULT_WAIT_BIT and VK_QUERY_RESULT_PARTIAL_BIT are both not set then no result
            // values are written to pData for queries that are in the unavailable state, but the availability state is
            // still written if VK_QUERY_RESULT_WITH_AVAILABILITY_BIT is set.
            let (results_after, availability_after) = self.parse_results(&results_buffer, results_size);
            for query_index in 0..NUM_QUERIES_IN_POOL {
                if results_after[query_index] != results[query_index] {
                    reset_failure = Some("getQueryPoolResults returned modified values".to_string());
                }
                if vector.query_results_availability && availability_after[query_index] != 0 {
                    reset_failure = Some("resetQueryPool did not disable availability bit".to_string());
                }
            }
        }

        Ok((results, availability, reset_failure))
    }

    /// `validateResults`
    fn validate_results(
        &self,
        results: &[u64; NUM_QUERIES_IN_POOL],
        availability: &[u64; NUM_QUERIES_IN_POOL],
        allow_unavailable: bool,
    ) -> Result<Vec<String>, TestError> {
        let vector = &self.test_vector;
        let mut failures = Vec::new();

        for query_index in 0..NUM_QUERIES_IN_POOL {
            let mut expected_value_min = 0u64;
            let mut expected_value_max = 0u64;

            if vector.query_results_mode == ResultsMode::CopyReset {
                if availability[query_index] != 0 {
                    // In copy-reset mode results should always be unavailable due to the reset command issued before copying results.
                    failures.push(format!("query results availability was nonzero for index {query_index} when resetting the query before copying results"));
                }

                // Not interested in the actual results.
                continue;
            } else if vector.query_results_availability && availability[query_index] == 0 {
                // query result was not available
                if !allow_unavailable {
                    failures.push(format!(
                        "query results availability was 0 for index {query_index}, expected any value greater than 0."
                    ));
                    continue;
                }
            } else if vector.primitive_topology == vk::PrimitiveTopology::POINT_LIST {
                // query is available, so expect proper result values
                match query_index {
                    QUERY_INDEX_CAPTURE_OCCLUDED => {}
                    QUERY_INDEX_CAPTURE_PARTIALLY_OCCLUDED => {
                        expected_value_min = 1;
                        expected_value_max = 1;
                    }
                    _ => {
                        expected_value_min = u64::from(NUM_VERTICES_IN_DRAWCALL);
                        expected_value_max = u64::from(NUM_VERTICES_IN_DRAWCALL);
                    }
                }
            } else if vector.primitive_topology == vk::PrimitiveTopology::TRIANGLE_LIST {
                if query_index != QUERY_INDEX_CAPTURE_OCCLUDED {
                    let prim_width = (WIDTH / 2) as i32;
                    let prim_height = (HEIGHT / 2) as i32;
                    let prim_area = prim_width * prim_height / 2;

                    if vector.discard_half {
                        expected_value_min = (0.95f32 * prim_area as f32 * 0.5) as u64;
                        expected_value_max = (1.05f32 * prim_area as f32 * 0.5) as u64;
                    } else {
                        expected_value_min = (0.97f32 * prim_area as f32) as u64;
                        expected_value_max = (1.03f32 * prim_area as f32) as u64;
                    }
                }
            } else {
                return Err(TestError::Fail("Unsupported primitive topology".to_string()));
            }

            if vector.is_precise() || (expected_value_min == 0 && expected_value_max == 0) {
                // require precise value
                if results[query_index] < expected_value_min || results[query_index] > expected_value_max {
                    failures.push(format!(
                        "wrong value of query for index {query_index}, expected the value minimum of {expected_value_min}, maximum of {expected_value_max} got {}.",
                        results[query_index]
                    ));
                }
            } else if results[query_index] == 0 {
                // require imprecise value greater than 0
                failures.push(format!(
                    "wrong value of query for index {query_index}, expected any non-zero value, got {}.",
                    results[query_index]
                ));
            }
        }
        Ok(failures)
    }
}

impl TestInstance for OcclusionQueryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vector = self.test_vector;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let res = self.create_resources()?;
        let render_command_buffer = self.record_render(&res)?;
        let query_pool_reset_command_buffer = if vector.has_separate_reset_cmd_buf() {
            Some(self.record_query_pool_reset(&res)?)
        } else {
            None
        };
        let copy_results_command_buffer = if vector.has_separate_copy_cmd_buf() {
            Some(self.record_copy_results(&res)?)
        } else {
            None
        };

        let vertices: [[f32; 4]; NUM_VERTICES as usize] = [
            // 1st triangle
            [0.5, 0.5, 0.5, 1.0],
            [0.5, -0.5, 0.5, 1.0],
            [-0.5, 0.5, 0.5, 1.0],
            // 2nd triangle - partially occluding the scene
            [-0.5, -0.5, 1.0, 1.0],
            [0.5, -0.5, 1.0, 1.0],
            [-0.5, 0.5, 1.0, 1.0],
            // 3nd triangle - fully occluding the scene
            [0.5, 0.5, 1.0, 1.0],
            [0.5, -0.5, 1.0, 1.0],
            [-0.5, 0.5, 1.0, 1.0],
        ];
        res.state_objects.set_vertices(device, &vertices)?;

        if let Some(reset) = &query_pool_reset_command_buffer {
            queue_submit_one(device, queue, **reset)?;

            // Trivially wait for reset to complete. This is to ensure the query pool is in reset state before
            // host accesses, so as to not insert any synchronization before capturing the results needed for WAIT_NONE
            // variant of test.
            queue_wait_idle(device, queue)?;
        }

        if !vector.has_separate_reset_cmd_buf() && vector.query_results_mode == ResultsMode::GetReset {
            unsafe { device.reset_query_pool(*res.query_pool, 0, NUM_QUERIES_IN_POOL as u32) };
        }
        queue_submit_one(device, queue, *render_command_buffer)?;

        if vector.query_wait == Wait::Queue {
            queue_wait_idle(device, queue)?;
        }

        if let Some(copy) = &copy_results_command_buffer {
            // In case of WAIT_QUEUE test variant, the previously submitted render command buffer did not
            // contain vkCmdCopyQueryResults, so additional cmd buffer is needed.
            queue_submit_one(device, queue, **copy)?;
        }

        if vector.is_copy_mode() {
            // In case of vkCmdCopyQueryResults is used, test must always wait for it
            // to complete before we can read the result buffer.
            queue_wait_idle(device, queue)?;
        }

        // Allow not ready results only if nobody waited before getting the query results
        let allow_not_ready = vector.query_wait == Wait::None;

        let (query_results, query_availability, reset_failure) = self.capture_results(&res)?;
        if let Some(message) = reset_failure {
            return Err(TestError::Fail(message));
        }

        let failures = self.validate_results(&query_results, &query_availability, allow_not_ready)?;

        if !vector.is_copy_mode() {
            queue_wait_idle(device, queue)?;
        }

        if failures.is_empty() {
            Ok(TestStatus::pass("Query result verification passed"))
        } else {
            Ok(TestStatus::fail(format!(
                "Query result verification failed: {}",
                failures.join(" ")
            )))
        }
    }
}

// ---------------------------------------------------------------------------------
// no attachments
// ---------------------------------------------------------------------------------

/// `NoAttachmentsParams`
#[derive(Clone, Copy)]
struct NoAttachmentsParams {
    multi_sample: bool,
}

impl NoAttachmentsParams {
    fn sample_count(&self) -> vk::SampleCountFlags {
        if self.multi_sample {
            vk::SampleCountFlags::_4
        } else {
            vk::SampleCountFlags::_1
        }
    }
}

/// `noAttachmentsSupport` / `noAttachmentsTest`
struct NoAttachmentsTest {
    name: String,
    params: NoAttachmentsParams,
}

impl TestCase for NoAttachmentsTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().occlusion_query_precise == vk::FALSE {
            return Err(TestError::NotSupported(
                "occlusionQueryPrecise not supported".to_string(),
            ));
        }

        let properties = context.get_device_properties();
        let sample_count = self.params.sample_count();
        if !properties
            .limits
            .framebuffer_no_attachments_sample_counts
            .contains(sample_count)
        {
            return Err(TestError::NotSupported(
                "Required sample count not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        OCCLUSION_NO_ATTACHMENTS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NoAttachmentsInstance {
            context,
            params: self.params,
        })
    }
}

struct NoAttachmentsInstance<'a> {
    context: &'a Context<'a>,
    params: NoAttachmentsParams,
}

impl TestInstance for NoAttachmentsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = vk::Extent3D {
            width: 2,
            height: 2,
            depth: 1,
        };
        let sample_count = self.params.sample_count();

        // Vertices.
        let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [-1.0, 3.0, 0.0, 1.0], [3.0, -1.0, 0.0, 1.0]];

        // Vertex buffer
        let vb_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(vb_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vb_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?; // strictly speaking, not needed.

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[], fb_extent.width, fb_extent.height, 1)?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let full_rect = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: fb_extent.width,
                height: fb_extent.height,
            },
        };
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: fb_extent.width as f32,
            height: fb_extent.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        // Halve framebuffer with the scissor.
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: fb_extent.width / 2,
                height: fb_extent.height,
            },
        }];

        // Default pipeline state with the one vec4 vertex attribute, and extra state whose multisample part is the important one.
        let binding_descs = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 4 * std::mem::size_of::<f32>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attribute_descs = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&binding_descs)
            .vertex_attribute_descriptions(&attribute_descs);
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        ];
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder().line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(sample_count);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder();
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // Query pool.
        let query_pool = make_occlusion_query_pool(device, 1, false)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_reset_query_pool(cmd, *query_pool, 0, 1);
            device.cmd_begin_query(cmd, *query_pool, 0, vk::QueryControlFlags::PRECISE);

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(full_rect);
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
            device.cmd_end_query(cmd, *query_pool, 0);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify query sample count: 2 slots, the query result and the availability bit.
        let mut query_result_bytes = [0u8; 8];
        let result_flags = vk::QueryResultFlags::WAIT | vk::QueryResultFlags::WITH_AVAILABILITY;
        unsafe { device.get_query_pool_results(*query_pool, 0, 1, &mut query_result_bytes, 8, result_flags) }
            .vk_check("vkGetQueryPoolResults")?;
        let query_results: [u32; 2] = std::array::from_fn(|index| {
            u32::from_ne_bytes(
                query_result_bytes[index * 4..index * 4 + 4]
                    .try_into()
                    .expect("four bytes per word"),
            )
        });

        // Availability bit.
        if query_results[1] == 0 {
            return Err(TestError::Fail("Unexpected result in availability bit".to_string()));
        }

        // Half the samples should be covered (see scissor).
        let reference = (fb_extent.width * fb_extent.height * sample_count.bits()) / 2;
        let result = query_results[0];

        if result != reference {
            return Err(TestError::Fail(format!(
                "Unexpected occlusion query results: found {result} but expected {reference}"
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// The tree
// ---------------------------------------------------------------------------------

fn add_full(group: &mut TestCaseGroup, name: String, test_vector: TestVector) {
    group.add_child(Box::new(QueryPoolOcclusionTest {
        name,
        kind: InstanceKind::Full,
        test_vector,
    }) as Box<dyn TestCase>);
}

fn add_basic(group: &mut TestCaseGroup, name: &str, test_vector: TestVector) {
    group.add_child(Box::new(QueryPoolOcclusionTest {
        name: name.to_string(),
        kind: InstanceKind::Basic,
        test_vector,
    }) as Box<dyn TestCase>);
}

/// `QueryPoolOcclusionTests::init`
pub fn create_occlusion_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("occlusion_query");
    let base_test_vector = TestVector::base();

    // Basic tests
    {
        let mut test_vector = base_test_vector;
        test_vector.query_control_flags = vk::QueryControlFlags::empty();
        add_basic(&mut group, "basic_conservative", test_vector);
        test_vector.query_control_flags = vk::QueryControlFlags::PRECISE;
        add_basic(&mut group, "basic_precise", test_vector);
    }

    {
        // STRIDE_RESULT_SIZE is omitted because it is already covered in the basic tests above
        for (stride, name) in [(Stride::Zero, "stride_zero"), (Stride::Max, "stride_max")] {
            let mut test_vector = base_test_vector;
            test_vector.stride = stride;
            add_basic(&mut group, name, test_vector);
        }
    }

    {
        // CLEAR_ATTACHMENTS_NONE is omitted because it is already covered in the basic tests above
        for (clear_attachments, name) in [
            (ClearAttachments::Only, "clear_attachments_only"),
            (ClearAttachments::WithDraw, "clear_attachments_with_draw"),
        ] {
            let mut test_vector = base_test_vector;
            test_vector.query_control_flags = vk::QueryControlFlags::PRECISE;
            test_vector.clear_attachments = clear_attachments;
            add_basic(&mut group, name, test_vector);
        }
    }

    {
        for (additional_op, name) in [(AdditionalOp::Blit, "blit"), (AdditionalOp::Resolve, "resolve")] {
            let mut test_vector = base_test_vector;
            test_vector.query_control_flags = vk::QueryControlFlags::PRECISE;
            test_vector.additional_op = additional_op;
            add_basic(&mut group, name, test_vector);
        }
    }

    // No attachment cases.
    for multi_sample in [false, true] {
        let test_name = format!(
            "no_attachments_{}",
            if multi_sample { "multisample" } else { "single_sample" }
        );
        group.add_child(Box::new(NoAttachmentsTest {
            name: test_name,
            params: NoAttachmentsParams { multi_sample },
        }) as Box<dyn TestCase>);
    }

    // Functional test
    {
        let control_flags = [
            (vk::QueryControlFlags::empty(), "conservative"),
            (vk::QueryControlFlags::PRECISE, "precise"),
        ];
        let primitive_topologies = [
            (vk::PrimitiveTopology::POINT_LIST, "points"),
            (vk::PrimitiveTopology::TRIANGLE_LIST, "triangles"),
        ];
        let result_sizes = [(ResultSize::Bits32, "32"), (ResultSize::Bits64, "64")];
        let waits = [(Wait::Queue, "queue"), (Wait::Query, "query")];
        let results_modes = [
            (ResultsMode::Get, "get"),
            (ResultsMode::GetReset, "get_reset"),
            (ResultsMode::GetCreateReset, "get_create_reset"),
            (ResultsMode::Copy, "copy"),
            (ResultsMode::CopyReset, "copy_reset"),
        ];

        for (control_flag, control_flag_str) in control_flags {
            for (primitive_topology, primitive_topology_str) in primitive_topologies {
                for (result_size, result_size_str) in result_sizes {
                    for (wait, wait_str) in waits {
                        for (results_mode, results_mode_str) in results_modes {
                            if wait == Wait::Query && results_mode == ResultsMode::GetReset {
                                // In RESULTS_MODE_GET_RESET we are going to reset the queries and get the query pool results again
                                // without issueing them, in order to check the availability field. In Vulkan spec it mentions that
                                // vkGetQueryPoolResults may not return in finite time. Because of that, we skip those tests.
                                continue;
                            }

                            for (test_availability, test_availability_str) in [(false, "without"), (true, "with")] {
                                if results_mode == ResultsMode::CopyReset && !test_availability {
                                    // In RESULTS_MODE_COPY_RESET mode we will reset queries and make sure the availability flag is
                                    // set to zero. It does not make sense to run in this mode without obtaining the availability flag.
                                    continue;
                                }

                                for (discard_half, discard_half_str) in [(false, ""), (true, "_discard")] {
                                    let mut test_vector = base_test_vector;
                                    test_vector.query_control_flags = control_flag;
                                    test_vector.query_result_size = result_size;
                                    test_vector.query_wait = wait;
                                    test_vector.query_results_mode = results_mode;
                                    test_vector.query_results_stride = test_vector.element_size();
                                    test_vector.query_results_availability = test_availability;
                                    test_vector.primitive_topology = primitive_topology;
                                    test_vector.discard_half = discard_half;

                                    if test_vector.discard_half
                                        && test_vector.primitive_topology == vk::PrimitiveTopology::POINT_LIST
                                    {
                                        continue; // Discarding half of the pixels in fragment shader doesn't make sense with one-pixel-sized points.
                                    }

                                    if test_vector.query_results_availability {
                                        test_vector.query_results_stride *= 2;
                                    }

                                    let test_name = format!(
                                        "{results_mode_str}_results_{control_flag_str}_size_{result_size_str}_wait_{wait_str}_{test_availability_str}_availability_draw_{primitive_topology_str}{discard_half_str}"
                                    );
                                    add_full(&mut group, test_name, test_vector);
                                }
                            }
                        }

                        // Tests for clear operation within a occulusion query activated.
                        // The query shouldn't count internal driver operations relevant to the clear operations.
                        for (clear_op, clear_op_str) in
                            [(ClearOp::Color, "clear_color"), (ClearOp::Depth, "clear_depth")]
                        {
                            let mut test_vector = base_test_vector;
                            test_vector.query_control_flags = control_flag;
                            test_vector.query_result_size = result_size;
                            test_vector.query_wait = wait;
                            test_vector.query_results_mode = ResultsMode::Get;
                            test_vector.query_results_stride = test_vector.element_size();
                            test_vector.primitive_topology = primitive_topology;
                            test_vector.clear_op = clear_op;

                            let test_name = format!(
                                "get_results_{control_flag_str}_size_{result_size_str}_wait_{wait_str}_without_availability_draw_{primitive_topology_str}_{clear_op_str}"
                            );
                            add_full(&mut group, test_name, test_vector);
                        }

                        // Tests with no color attachments.
                        {
                            let mut test_vector = base_test_vector;
                            test_vector.query_control_flags = control_flag;
                            test_vector.query_result_size = result_size;
                            test_vector.query_wait = wait;
                            test_vector.query_results_mode = ResultsMode::Get;
                            test_vector.query_results_stride = test_vector.element_size();
                            test_vector.primitive_topology = primitive_topology;
                            test_vector.no_color_attachments = true;

                            let test_name = format!(
                                "get_results_{control_flag_str}_size_{result_size_str}_wait_{wait_str}_without_availability_draw_{primitive_topology_str}_no_color_attachments"
                            );
                            add_full(&mut group, test_name, test_vector);
                        }
                    }
                }
            }
        }
    }

    // Test different strides
    {
        let results_modes = [
            (ResultsMode::Get, "get"),
            (ResultsMode::GetReset, "get_reset"),
            (ResultsMode::Copy, "copy"),
            (ResultsMode::CopyReset, "copy_reset"),
        ];

        for (results_mode, results_mode_str) in results_modes {
            for (test_availability, test_availability_str) in [(false, "without"), (true, "with")] {
                if results_mode == ResultsMode::CopyReset && !test_availability {
                    // In RESULTS_MODE_COPY_RESET mode we will reset queries and make sure the availability flag is set to zero. It
                    // does not make sense to run in this mode without obtaining the availability flag.
                    continue;
                }

                for (result_size, result_size_str) in [(ResultSize::Bits32, "32"), (ResultSize::Bits64, "64")] {
                    let result_size_bytes: vk::DeviceSize = if result_size == ResultSize::Bits32 {
                        std::mem::size_of::<u32>() as u64
                    } else {
                        std::mem::size_of::<u64>() as u64
                    };

                    // \todo [2015-12-18 scygan] Ensure only stride values aligned to resultSize are allowed. Otherwise test should be extended.
                    let strides = [
                        0,
                        result_size_bytes,
                        2 * result_size_bytes,
                        3 * result_size_bytes,
                        4 * result_size_bytes,
                        5 * result_size_bytes,
                        13 * result_size_bytes,
                        1024 * result_size_bytes,
                    ];

                    for (copy_query_dst_offset, copy_query_dst_offset_str) in [(true, "_dstoffset"), (false, "")] {
                        for (stride_index, &stride) in strides.iter().enumerate() {
                            let mut test_vector = base_test_vector;
                            test_vector.query_results_mode = results_mode;
                            test_vector.query_result_size = result_size;
                            test_vector.query_results_availability = test_availability;
                            test_vector.query_results_stride = stride;
                            test_vector.query_results_dst_offset = copy_query_dst_offset;

                            let element_size = if test_vector.query_results_availability {
                                result_size_bytes * 2
                            } else {
                                result_size_bytes
                            };

                            if element_size > test_vector.query_results_stride && stride != 0 {
                                continue;
                            }

                            if stride == 0 {
                                // Due to the nature of the test, the dstOffset is tested automatically when stride size is 0.
                                if test_vector.query_results_dst_offset {
                                    continue;
                                }

                                // We are testing only VkCmdCopyQueryPoolResults with stride 0.
                                if test_vector.query_results_mode != ResultsMode::Copy {
                                    continue;
                                }
                            }

                            let test_name = format!(
                                "{results_mode_str}_results_size_{result_size_str}_stride_{stride}_{test_availability_str}_availability{copy_query_dst_offset_str}"
                            );
                            add_full(&mut group, test_name.clone(), test_vector);

                            // Only the copy and copy_reset cases execute vkCmdCopyQueryPoolResultsToMemoryKHR.
                            if matches!(results_mode, ResultsMode::Copy | ResultsMode::CopyReset) {
                                // limit number of repeated tests for device_address_commands
                                if usize::from(test_availability) == usize::from(result_size == ResultSize::Bits64)
                                    && usize::from(!copy_query_dst_offset) == stride_index % 4
                                {
                                    test_vector.use_device_address_commands = true;
                                    add_full(&mut group, format!("{test_name}_device_address"), test_vector);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    group
}
