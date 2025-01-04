// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateBaseClass.cpp / .hpp
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateTestCaseUtil.hpp
//   (and the `DepthBiasBaseCase` / `DepthStencilBaseCase` copies of it in the RS and DS tests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `DynamicStateBaseClass` is a base class that the concrete tests derive from and finish by calling `initialize()`
// once their vertex data is filled in. Here it is a struct a test's `run` function builds from a `BaseConfig`.
// The RS and DS tests carry their own near copies of it with a depth/stencil attachment and (for DS) two pipelines
// that differ only in their depth/stencil state; `BaseConfig::depth_stencil` and `depth_stencil_states` cover both.
// Only the monolithic, vertex-shader pipelines are ported: the pipeline library and shader object groups and the
// mesh shader variants need machinery the port does not have.

use std::cell::Cell;

use vulkanalia::prelude::v1_0::*;

use super::construction::create_graphics_pipeline;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::util::{default_depth_stencil_state, default_rasterization_state, rect_2d};
use crate::vkt::tests::draw::{initial_transition_color_2d_image, transition_2d_image};
use crate::vkt::{Context, TestCase, TestInstance};

thread_local! {
    static MESH_MODE: Cell<bool> = const { Cell::new(false) };
}

/// Whether the running case draws with `VertexFetch.mesh` instead of the vertex shader (`m_isMesh`).
pub fn mesh_mode() -> bool {
    MESH_MODE.with(Cell::get)
}

/// Runs `f` with the mesh variant mode on or off.
pub fn with_mesh_mode<R>(mesh: bool, f: impl FnOnce() -> R) -> R {
    let previous = MESH_MODE.with(|mode| mode.replace(mesh));
    let result = f();
    MESH_MODE.with(|mode| mode.set(previous));
    result
}

/// The `_mesh` variant of a `StateTestCase` whose run function reads `mesh_mode()` through `DynamicStateBase`.
pub struct MeshStateTestCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
    pub support: fn(&Context<'_>) -> Result<(), TestError>,
    pub run: for<'a> fn(&'a Context<'a>) -> TestOutcome,
}

impl TestCase for MeshStateTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkMeshShaderSupport`, then the case's own.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_mesh_shader")?;
        (self.support)(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshStateTestInstance { context, run: self.run })
    }
}

struct MeshStateTestInstance<'a> {
    context: &'a Context<'a>,
    run: for<'r> fn(&'r Context<'r>) -> TestOutcome,
}

impl TestInstance for MeshStateTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let previous = MESH_MODE.with(|mode| mode.replace(true));
        let outcome = (self.run)(self.context);
        MESH_MODE.with(|mode| mode.set(previous));
        outcome
    }
}

/// The vertex data as a storage buffer the mesh shader reads, with the push constant that names its first vertex.
pub struct MeshSet<'a> {
    // The set is freed back to its pool, so it has to drop first.
    set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _pool: Unique<'a, vk::DescriptorPool>,
    _layout: Unique<'a, vk::DescriptorSetLayout>,
}

pub const WIDTH: u32 = 128;
pub const HEIGHT: u32 = 128;

pub const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `tcu::RGBA::red().toVec()` and its siblings.
pub const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
pub const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
pub const BLUE: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
pub const BLACK: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

/// `DynamicState::PositionColorVertex`
#[repr(C)]
#[derive(Clone, Copy)]
pub struct PositionColorVertex {
    pub position: [f32; 4],
    pub color: [f32; 4],
}

impl PositionColorVertex {
    pub fn new(position: [f32; 4], color: [f32; 4]) -> Self {
        Self { position, color }
    }
}

/// `DynamicState::InstanceFactory`, with the shader map reduced to program names and the instance to a function.
pub struct StateTestCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
    pub support: fn(&Context<'_>) -> Result<(), TestError>,
    pub run: for<'a> fn(&'a Context<'a>) -> TestOutcome,
}

impl TestCase for StateTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        (self.support)(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StateTestInstance { context, run: self.run })
    }
}

struct StateTestInstance<'a> {
    context: &'a Context<'a>,
    run: for<'r> fn(&'r Context<'r>) -> TestOutcome,
}

impl TestInstance for StateTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.run)(self.context)
    }
}

/// `checkNothing`
pub fn check_nothing(_context: &Context<'_>) -> Result<(), TestError> {
    Ok(())
}

pub fn check_wide_lines_support(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_device_features().wide_lines == vk::FALSE {
        return Err(TestError::NotSupported("Feature not supported: wideLines".to_string()));
    }
    Ok(())
}

pub fn check_depth_bias_clamp_support(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_device_features().depth_bias_clamp == vk::FALSE {
        return Err(TestError::NotSupported(
            "Feature not supported: depthBiasClamp".to_string(),
        ));
    }
    Ok(())
}

pub fn check_depth_bounds_support(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_device_features().depth_bounds == vk::FALSE {
        return Err(TestError::NotSupported(
            "Feature not supported: depthBounds".to_string(),
        ));
    }
    Ok(())
}

pub fn check_geometry_and_multi_viewport_support(context: &Context<'_>) -> Result<(), TestError> {
    let features = context.get_device_features();
    if features.geometry_shader == vk::FALSE {
        return Err(TestError::NotSupported(
            "Feature not supported: geometryShader".to_string(),
        ));
    }
    if features.multi_viewport == vk::FALSE {
        return Err(TestError::NotSupported(
            "Feature not supported: multiViewport".to_string(),
        ));
    }
    Ok(())
}

/// The parameters of `setDynamicDepthStencilState`.
#[derive(Clone, Copy)]
pub struct DepthStencilDynamicState {
    pub min_depth_bounds: f32,
    pub max_depth_bounds: f32,
    pub stencil_front_compare_mask: u32,
    pub stencil_front_write_mask: u32,
    pub stencil_front_reference: u32,
    pub stencil_back_compare_mask: u32,
    pub stencil_back_write_mask: u32,
    pub stencil_back_reference: u32,
}

impl Default for DepthStencilDynamicState {
    fn default() -> Self {
        Self {
            min_depth_bounds: 0.0,
            max_depth_bounds: 1.0,
            stencil_front_compare_mask: 0xffff_ffff,
            stencil_front_write_mask: 0xffff_ffff,
            stencil_front_reference: 0,
            stencil_back_compare_mask: 0xffff_ffff,
            stencil_back_write_mask: 0xffff_ffff,
            stencil_back_reference: 0,
        }
    }
}

/// `PipelineCreateInfo::ColorBlendState::Attachment`'s defaults: blending off, SRC_COLOR / DST_COLOR factors.
pub fn default_blend_attachment() -> vk::PipelineColorBlendAttachmentState {
    vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::SRC_COLOR)
        .dst_color_blend_factor(vk::BlendFactor::DST_COLOR)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::SRC_COLOR)
        .dst_alpha_blend_factor(vk::BlendFactor::DST_COLOR)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()
}

/// The depth/stencil attachment next to the colour one.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DepthAttachment {
    None,
    /// The RS and DS bases: a D24_UNORM_S8_UINT (or D32_SFLOAT_S8_UINT) attachment the base clears to zero. The DS base
    /// loads the stencil aspect, the RS one does not care for it.
    DepthStencil {
        stencil_load: bool,
    },
    /// `DepthBoundsTestInstance`: a D16_UNORM attachment the test fills itself and that the pass only reads.
    ReadOnlyD16,
}

/// What a test sets between the base class's constructor and `initialize()`, plus the shaders it passes to the constructor.
pub struct BaseConfig {
    pub vertex_shader: &'static str,
    pub fragment_shader: &'static str,
    pub geometry_shader: Option<&'static str>,
    pub topology: vk::PrimitiveTopology,
    pub data: Vec<PositionColorVertex>,
    pub depth: DepthAttachment,
    pub blend_attachment: vk::PipelineColorBlendAttachmentState,
    /// One pipeline is built per entry (the DS tests use two).
    pub depth_stencil_states: Vec<vk::PipelineDepthStencilStateCreateInfo>,
    /// One more pipeline per entry, after those above, with the first depth/stencil state (`StatePersistenceTestInstance`'s
    /// second pipeline differs from its first by the topology alone).
    pub extra_topologies: Vec<vk::PrimitiveTopology>,
    /// The number of viewports and scissors the pipelines declare, all of them dynamic.
    pub viewport_count: u32,
}

impl BaseConfig {
    pub fn new(
        vertex_shader: &'static str,
        fragment_shader: &'static str,
        topology: vk::PrimitiveTopology,
        data: Vec<PositionColorVertex>,
    ) -> Self {
        Self {
            vertex_shader,
            fragment_shader,
            geometry_shader: None,
            topology,
            data,
            depth: DepthAttachment::None,
            blend_attachment: default_blend_attachment(),
            depth_stencil_states: vec![default_depth_stencil_state()],
            extra_topologies: Vec::new(),
            viewport_count: 1,
        }
    }

    /// The common case: `VertexFetch.vert` / `VertexFetch.frag` over a triangle strip.
    pub fn vertex_fetch(data: Vec<PositionColorVertex>) -> Self {
        Self::new("vert", "frag", vk::PrimitiveTopology::TRIANGLE_STRIP, data)
    }
}

/// `PipelineCreateInfo::DepthStencilState::StencilOpState`, with the compare and write masks and the reference at their defaults.
pub fn stencil_op_state(
    fail_op: vk::StencilOp,
    pass_op: vk::StencilOp,
    depth_fail_op: vk::StencilOp,
    compare_op: vk::CompareOp,
) -> vk::StencilOpState {
    vk::StencilOpState::builder()
        .fail_op(fail_op)
        .pass_op(pass_op)
        .depth_fail_op(depth_fail_op)
        .compare_op(compare_op)
        .compare_mask(0xffff_ffff)
        .write_mask(0xffff_ffff)
        .reference(0)
        .build()
}

/// `PipelineCreateInfo::DepthStencilState`
pub fn depth_stencil_state(
    depth_test: bool,
    depth_write: bool,
    depth_compare_op: vk::CompareOp,
    depth_bounds_test: bool,
    stencil_test: bool,
    front: vk::StencilOpState,
    back: vk::StencilOpState,
) -> vk::PipelineDepthStencilStateCreateInfo {
    vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(depth_test)
        .depth_write_enable(depth_write)
        .depth_compare_op(depth_compare_op)
        .depth_bounds_test_enable(depth_bounds_test)
        .stencil_test_enable(stencil_test)
        .front(front)
        .back(back)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build()
}

/// `PipelineCreateInfo::DynamicState`'s default list.
fn default_dynamic_states() -> [vk::DynamicState; 9] {
    [
        vk::DynamicState::VIEWPORT,
        vk::DynamicState::SCISSOR,
        vk::DynamicState::LINE_WIDTH,
        vk::DynamicState::DEPTH_BIAS,
        vk::DynamicState::BLEND_CONSTANTS,
        vk::DynamicState::DEPTH_BOUNDS,
        vk::DynamicState::STENCIL_COMPARE_MASK,
        vk::DynamicState::STENCIL_WRITE_MASK,
        vk::DynamicState::STENCIL_REFERENCE,
    ]
}

/// `DynamicState::DynamicStateBaseClass` after `initialize`.
pub struct DynamicStateBase<'a> {
    pub context: &'a Context<'a>,
    pub color_attachment_format: vk::Format,
    pub depth_stencil_attachment_format: vk::Format,
    /// Whether `begin_render_pass` clears and transitions the depth/stencil image.
    pub clears_depth_stencil: bool,
    pub data: Vec<PositionColorVertex>,

    pub pipelines: Vec<Unique<'a, vk::Pipeline>>,
    pub framebuffer: Unique<'a, vk::Framebuffer>,
    pub render_pass: Unique<'a, vk::RenderPass>,
    pub cmd_buffer: UniqueCommandBuffer<'a>,
    pub cmd_pool: Unique<'a, vk::CommandPool>,
    pub vertex_buffer: BufferWithMemory<'a>,
    pub mesh_set: Option<MeshSet<'a>>,
    pub color_target_view: Unique<'a, vk::ImageView>,
    pub depth_stencil_view: Option<Unique<'a, vk::ImageView>>,
    pub pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pub color_target_image: ImageWithMemory<'a>,
    pub depth_stencil_image: Option<ImageWithMemory<'a>>,
}

impl<'a> DynamicStateBase<'a> {
    /// `DynamicStateBaseClass::DynamicStateBaseClass` followed by `initialize` with the vertex data a derived class
    /// would have pushed into `m_data` in between.
    pub fn new(context: &'a Context<'a>, config: BaseConfig) -> Result<Self, TestError> {
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let color_attachment_format = COLOR_ATTACHMENT_FORMAT;

        let mut depth_stencil_attachment_format = vk::Format::UNDEFINED;
        if let DepthAttachment::ReadOnlyD16 = config.depth {
            depth_stencil_attachment_format = vk::Format::D16_UNORM;
        }
        if let DepthAttachment::DepthStencil { .. } = config.depth {
            let supported = |format: vk::Format| {
                let properties = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
                properties
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
            };
            if supported(vk::Format::D24_UNORM_S8_UINT) {
                depth_stencil_attachment_format = vk::Format::D24_UNORM_S8_UINT;
            } else if supported(vk::Format::D32_SFLOAT_S8_UINT) {
                depth_stencil_attachment_format = vk::Format::D32_SFLOAT_S8_UINT;
            } else {
                return Err(TestError::NotSupported(
                    "No valid depth stencil attachment available".to_string(),
                ));
            }
        }

        let mesh = mesh_mode();
        let mut mesh_set = None;
        let pipeline_layout = if mesh {
            // The mesh shading pipeline contains a set with the vertex data.
            let layout = crate::vk::builder_util::DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::MESH_EXT)
                .build(device)?;
            let pool = crate::vk::builder_util::DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set = crate::vk::obj_util::make_descriptor_set(device, *pool, *layout)?;
            let set_layouts = [*layout];
            let push_constant_ranges = [vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::MESH_EXT,
                offset: 0,
                size: 4,
            }];
            let info = vk::PipelineLayoutCreateInfo::builder()
                .set_layouts(&set_layouts)
                .push_constant_ranges(&push_constant_ranges);
            let handle = Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
            );
            mesh_set = Some(MeshSet {
                _layout: layout,
                _pool: pool,
                set,
            });
            handle
        } else {
            make_pipeline_layout(device, &[])?
        };

        let extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        };
        let color_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_attachment_format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_target_image = ImageWithMemory::new(device, alloc, color_info, MemoryRequirement::ANY)?;
        let color_target_view = make_image_view(
            device,
            color_target_image.get(),
            vk::ImageViewType::_2D,
            color_attachment_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let has_depth = config.depth != DepthAttachment::None;
        let mut depth_stencil_image = None;
        let mut depth_stencil_view = None;
        if has_depth {
            let depth_stencil_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(depth_stencil_attachment_format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, alloc, depth_stencil_info, MemoryRequirement::ANY)?;
            // ImageViewCreateInfo derives the aspect from the format.
            let view_aspect = if depth_stencil_attachment_format == vk::Format::D16_UNORM {
                vk::ImageAspectFlags::DEPTH
            } else {
                vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
            };
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                depth_stencil_attachment_format,
                make_image_subresource_range(view_aspect, 0, 1, 0, 1),
            )?;
            depth_stencil_image = Some(image);
            depth_stencil_view = Some(view);
        }

        // initRenderPass
        let mut attachment_descriptions = vec![
            vk::AttachmentDescription::builder()
                .format(color_attachment_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::GENERAL)
                .final_layout(vk::ImageLayout::GENERAL)
                .build(),
        ];
        let (stencil_load_op, depth_layout) = match config.depth {
            DepthAttachment::DepthStencil { stencil_load: true } => (
                vk::AttachmentLoadOp::LOAD,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ),
            DepthAttachment::ReadOnlyD16 => (
                vk::AttachmentLoadOp::DONT_CARE,
                vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
            ),
            _ => (
                vk::AttachmentLoadOp::DONT_CARE,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ),
        };
        if has_depth {
            attachment_descriptions.push(
                vk::AttachmentDescription::builder()
                    .format(depth_stencil_attachment_format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(stencil_load_op)
                    .stencil_store_op(vk::AttachmentStoreOp::STORE)
                    .initial_layout(depth_layout)
                    .final_layout(depth_layout)
                    .build(),
            );
        }
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::GENERAL)
            .build()];
        let depth_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(depth_layout)
            .build();
        let mut subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references);
        if has_depth {
            subpass = subpass.depth_stencil_attachment(&depth_reference);
        }
        let subpasses = [subpass.build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // initFramebuffer
        let mut attachments = vec![*color_target_view];
        if let Some(view) = &depth_stencil_view {
            attachments.push(**view);
        }
        let framebuffer = make_framebuffer(device, *render_pass, &attachments, WIDTH, HEIGHT, 1)?;

        // The vertex buffer
        let data_size = std::mem::size_of_val(config.data.as_slice());
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                data_size as vk::DeviceSize,
                if mesh {
                    vk::BufferUsageFlags::STORAGE_BUFFER
                } else {
                    vk::BufferUsageFlags::VERTEX_BUFFER
                },
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                config.data.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                data_size,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;
        if let Some(mesh_set) = &mesh_set {
            let buffer_info =
                crate::vk::obj_util::make_descriptor_buffer_info(vertex_buffer.get(), 0, data_size as vk::DeviceSize);
            crate::vk::builder_util::DescriptorSetUpdateBuilder::new()
                .write_single(
                    *mesh_set.set,
                    crate::vk::builder_util::Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &buffer_info,
                )
                .update(device);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // initPipeline
        let binaries: BinaryCollection = context.get_binary_collection();
        let vertex_module =
            create_shader_module(device, binaries.get(if mesh { "mesh" } else { config.vertex_shader })?)?;
        let fragment_module = create_shader_module(device, binaries.get(config.fragment_shader)?)?;
        let geometry_module = match config.geometry_shader.filter(|_| !mesh) {
            Some(name) => Some(create_shader_module(device, binaries.get(name)?)?),
            None => None,
        };

        let mut stages = vec![
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(if mesh {
                    vk::ShaderStageFlags::MESH_EXT
                } else {
                    vk::ShaderStageFlags::VERTEX
                })
                .module(*vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_module)
                .name(b"main\0")
                .build(),
        ];
        if let Some(module) = &geometry_module {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::GEOMETRY)
                    .module(**module)
                    .name(b"main\0")
                    .build(),
            );
        }

        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: (std::mem::size_of::<f32>() * 8) as u32,
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
                offset: (std::mem::size_of::<f32>() * 4) as u32,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);

        let zero_viewports = vec![
            vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: 0.0,
                height: 0.0,
                min_depth: 0.0,
                max_depth: 0.0
            };
            config.viewport_count as usize
        ];
        let zero_scissors = vec![rect_2d(0, 0); config.viewport_count as usize];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&zero_viewports)
            .scissors(&zero_scissors);

        let rasterization_state = default_rasterization_state();
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend_attachments = [config.blend_attachment];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
        let dynamic_states = default_dynamic_states();
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let mut variants: Vec<(vk::PrimitiveTopology, &vk::PipelineDepthStencilStateCreateInfo)> = config
            .depth_stencil_states
            .iter()
            .map(|state| (config.topology, state))
            .collect();
        variants.extend(
            config
                .extra_topologies
                .iter()
                .map(|&topology| (topology, &config.depth_stencil_states[0])),
        );

        let mut pipelines = Vec::new();
        for (topology, depth_stencil_state) in variants {
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(topology)
                .primitive_restart_enable(false);
            let mut info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&stages)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .multisample_state(&multisample_state)
                .depth_stencil_state(depth_stencil_state)
                .color_blend_state(&color_blend_state)
                .dynamic_state(&dynamic_state)
                .layout(*pipeline_layout)
                .render_pass(*render_pass)
                .subpass(0)
                .base_pipeline_index(0);
            // A pipeline with a mesh shader has no vertex input or input assembly state.
            if !mesh {
                info = info
                    .vertex_input_state(&vertex_input_state)
                    .input_assembly_state(&input_assembly_state);
            }
            pipelines.push(create_graphics_pipeline(device, &info)?);
        }

        Ok(Self {
            context,
            color_attachment_format,
            depth_stencil_attachment_format,
            clears_depth_stencil: matches!(config.depth, DepthAttachment::DepthStencil { .. }),
            data: config.data,
            pipelines,
            framebuffer,
            render_pass,
            cmd_buffer,
            cmd_pool,
            vertex_buffer,
            mesh_set,
            color_target_view,
            depth_stencil_view,
            pipeline_layout,
            color_target_image,
            depth_stencil_image,
        })
    }

    pub fn device(&self) -> &'a Device {
        self.context.get_device()
    }

    pub fn cmd(&self) -> vk::CommandBuffer {
        *self.cmd_buffer
    }

    /// `DynamicStateBaseClass::beginRenderPass`
    pub fn begin_render_pass(&self) -> Result<(), TestError> {
        self.begin_render_pass_with_clear_color(BLACK, false, false)
    }

    /// `DynamicStateBaseClass::beginRenderPassWithClearColor`
    pub fn begin_render_pass_with_clear_color(
        &self,
        clear_color: [f32; 4],
        skip_begin_cmd_buffer: bool,
        previous_transfer: bool,
    ) -> Result<(), TestError> {
        let device = self.device();
        let cmd = self.cmd();
        let clear_value = vk::ClearColorValue { float32: clear_color };
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        if !skip_begin_cmd_buffer {
            begin_command_buffer(device, cmd)?;
        }

        if previous_transfer {
            let transfer_to_transfer = make_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE | vk::AccessFlags::TRANSFER_READ,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[transfer_to_transfer],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        } else {
            initial_transition_color_2d_image(
                device,
                cmd,
                self.color_target_image.get(),
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
        }

        let both_aspects = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
        let cleared_image = if self.clears_depth_stencil {
            self.depth_stencil_image.as_ref()
        } else {
            None
        };
        if let Some(image) = cleared_image {
            transition_2d_image(
                device,
                cmd,
                image.get(),
                both_aspects,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
        }

        unsafe {
            device.cmd_clear_color_image(
                cmd,
                self.color_target_image.get(),
                vk::ImageLayout::GENERAL,
                &clear_value,
                &[color_range],
            )
        };

        let mut dst_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        let mut dst_stage = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
        if let Some(image) = cleared_image {
            let depth_stencil_clear_value = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
            let ranges = [
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
                make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1),
            ];
            unsafe {
                device.cmd_clear_depth_stencil_image(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &depth_stencil_clear_value,
                    &ranges,
                )
            };

            dst_access |=
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
            dst_stage |= vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
        }

        let mem_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, dst_access);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        if let Some(image) = cleared_image {
            transition_2d_image(
                device,
                cmd,
                image.get(),
                both_aspects,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                1,
            );
        }

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.render_pass)
            .framebuffer(*self.framebuffer)
            .render_area(rect_2d(WIDTH, HEIGHT));
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
        Ok(())
    }

    /// `m_pipeline.bind`, for the pipeline at `index`.
    pub fn bind_pipeline(&self, index: usize) {
        unsafe {
            self.device()
                .cmd_bind_pipeline(self.cmd(), vk::PipelineBindPoint::GRAPHICS, *self.pipelines[index])
        };
    }

    /// The `cmdBindVertexBuffers(..., 0, 1, &vertexBuffer, &0)` every draw is preceded by; the mesh variants bind the vertex
    /// data as a descriptor set with the draws instead.
    pub fn bind_vertex_buffer(&self) {
        if self.mesh_set.is_none() {
            unsafe {
                self.device()
                    .cmd_bind_vertex_buffers(self.cmd(), 0, &[self.vertex_buffer.get()], &[0])
            };
        }
    }

    /// `draw` for a line list: the mesh variant of `line_width` has one task per line of the strip, `numVert - 1`.
    pub fn draw_lines(&self, vertex_count: u32, first_vertex: u32) {
        use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;
        match &self.mesh_set {
            None => self.draw(vertex_count, first_vertex),
            Some(mesh_set) => unsafe {
                let device = self.device();
                device.cmd_bind_descriptor_sets(
                    self.cmd(),
                    vk::PipelineBindPoint::GRAPHICS,
                    *self.pipeline_layout,
                    0,
                    &[*mesh_set.set],
                    &[],
                );
                device.cmd_push_constants(
                    self.cmd(),
                    *self.pipeline_layout,
                    vk::ShaderStageFlags::MESH_EXT,
                    0,
                    &first_vertex.to_ne_bytes(),
                );
                device.cmd_draw_mesh_tasks_ext(self.cmd(), vertex_count - 1, 1, 1);
            },
        }
    }

    /// `cmdDraw(count, 1, first, 0)`, or for the mesh variants `pushVertexOffset(first)` and one task per triangle of the strip.
    pub fn draw(&self, vertex_count: u32, first_vertex: u32) {
        use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;
        let device = self.device();
        match &self.mesh_set {
            None => unsafe { device.cmd_draw(self.cmd(), vertex_count, 1, first_vertex, 0) },
            Some(mesh_set) => unsafe {
                device.cmd_bind_descriptor_sets(
                    self.cmd(),
                    vk::PipelineBindPoint::GRAPHICS,
                    *self.pipeline_layout,
                    0,
                    &[*mesh_set.set],
                    &[],
                );
                device.cmd_push_constants(
                    self.cmd(),
                    *self.pipeline_layout,
                    vk::ShaderStageFlags::MESH_EXT,
                    0,
                    &first_vertex.to_ne_bytes(),
                );
                device.cmd_draw_mesh_tasks_ext(self.cmd(), vertex_count - 2, 1, 1);
            },
        }
    }

    /// `setDynamicViewportState(width, height)`
    pub fn set_dynamic_viewport_state(&self, width: u32, height: u32) {
        let viewport = vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: width as f32,
            height: height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        };
        let scissor = rect_2d(width, height);
        unsafe {
            self.device().cmd_set_viewport(self.cmd(), 0, &[viewport]);
            self.device().cmd_set_scissor(self.cmd(), 0, &[scissor]);
        }
    }

    /// `setDynamicViewportState(viewportCount, pViewports, pScissors)`
    pub fn set_dynamic_viewport_state_array(&self, viewports: &[vk::Viewport], scissors: &[vk::Rect2D]) {
        unsafe {
            self.device().cmd_set_viewport(self.cmd(), 0, viewports);
            self.device().cmd_set_scissor(self.cmd(), 0, scissors);
        }
    }

    /// `setDynamicRasterizationState(lineWidth, depthBiasConstantFactor, depthBiasClamp, depthBiasSlopeFactor)`
    pub fn set_dynamic_rasterization_state(
        &self,
        line_width: f32,
        depth_bias_constant_factor: f32,
        depth_bias_clamp: f32,
        depth_bias_slope_factor: f32,
    ) {
        unsafe {
            self.device().cmd_set_line_width(self.cmd(), line_width);
            self.device().cmd_set_depth_bias(
                self.cmd(),
                depth_bias_constant_factor,
                depth_bias_clamp,
                depth_bias_slope_factor,
            );
        }
    }

    /// `setDynamicRasterizationState()` with every default.
    pub fn set_default_dynamic_rasterization_state(&self) {
        self.set_dynamic_rasterization_state(1.0, 0.0, 0.0, 0.0);
    }

    /// `setDynamicBlendState(const1, const2, const3, const4)`
    pub fn set_dynamic_blend_state(&self, constants: [f32; 4]) {
        unsafe { self.device().cmd_set_blend_constants(self.cmd(), constants) };
    }

    /// `setDynamicDepthStencilState`
    pub fn set_dynamic_depth_stencil_state(&self, state: DepthStencilDynamicState) {
        let device = self.device();
        let cmd = self.cmd();
        unsafe {
            device.cmd_set_depth_bounds(cmd, state.min_depth_bounds, state.max_depth_bounds);
            device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::FRONT, state.stencil_front_compare_mask);
            device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::FRONT, state.stencil_front_write_mask);
            device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::FRONT, state.stencil_front_reference);
            device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::BACK, state.stencil_back_compare_mask);
            device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::BACK, state.stencil_back_write_mask);
            device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::BACK, state.stencil_back_reference);
        }
    }

    /// The four calls every test makes after `beginRenderPass()` and before binding the pipeline.
    pub fn set_default_dynamic_states(&self) {
        self.set_dynamic_viewport_state(WIDTH, HEIGHT);
        self.set_default_dynamic_rasterization_state();
        self.set_dynamic_blend_state([0.0; 4]);
        self.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());
    }

    /// `m_renderPass.end`, `endCommandBuffer` and `submitCommandsAndWait`.
    pub fn end_and_submit(&self) -> Result<(), TestError> {
        let device = self.device();
        unsafe { device.cmd_end_render_pass(self.cmd()) };
        end_command_buffer(device, self.cmd())?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), self.cmd())
    }

    /// `Draw::Image::readSurface` for the colour target, which the render pass leaves in GENERAL.
    pub fn read_color_surface(&self) -> Result<TextureLevel, TestError> {
        let bytes = read_rgba8_image(
            self.context,
            self.color_target_image.get(),
            vk::ImageLayout::GENERAL,
            WIDTH,
            HEIGHT,
        )?;
        let mut level = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            WIDTH,
            HEIGHT,
            1,
        )?;
        level.data_mut().copy_from_slice(&bytes);
        Ok(level)
    }

    /// `tcu::fuzzyCompare(log, "Result", "Image comparison result", reference, renderedFrame, 0.05f, COMPARE_LOG_RESULT)` over the
    /// colour target, as the pass/fail every test of this family ends with.
    pub fn verify_against(&self, reference: &TextureLevel) -> TestOutcome {
        let rendered_frame = self.read_color_surface()?;
        if crate::tcu::fuzzy_image_compare::fuzzy_compare_ok(
            &reference.get_const_access(),
            &rendered_frame.get_const_access(),
            0.05,
        ) != Some(true)
        {
            return Ok(TestStatus::fail("Image verification failed"));
        }
        Ok(TestStatus::pass("Image verification passed"))
    }
}

/// The reference frame every test of this family builds: a `WIDTH` x `HEIGHT` level cleared to `clear`, then `pixel` asked
/// for each pixel's normalised device coordinates (`xCoord`, `yCoord`, computed in double as upstream does) and painting
/// the colour it returns, if any.
pub fn build_reference_frame(
    clear: [f32; 4],
    mut pixel: impl FnMut(f32, f32) -> Option<[f32; 4]>,
) -> Result<TextureLevel, TestError> {
    let mut level = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        WIDTH,
        HEIGHT,
        1,
    )?;
    {
        let mut access = level.get_access();
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                access.set_pixel(clear, x, y, 0);
            }
        }
        for y in 0..HEIGHT {
            let y_coord = (f64::from(y) / (0.5 * f64::from(HEIGHT))) as f32 - 1.0;
            for x in 0..WIDTH {
                let x_coord = (f64::from(x) / (0.5 * f64::from(WIDTH))) as f32 - 1.0;
                if let Some(color) = pixel(x_coord, y_coord) {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }
    }
    Ok(level)
}

/// A reference frame built per pixel: a `WIDTH` x `HEIGHT` level where `pixel(x, y)` gives each pixel's colour.
pub fn build_reference_frame_by_pixel(mut pixel: impl FnMut(i32, i32) -> [f32; 4]) -> Result<TextureLevel, TestError> {
    let mut level = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        WIDTH,
        HEIGHT,
        1,
    )?;
    {
        let mut access = level.get_access();
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                access.set_pixel(pixel(x as i32, y as i32), x, y, 0);
            }
        }
    }
    Ok(level)
}

/// `Draw::Image::readSurface` for a colour image of four bytes per texel that is in `layout`: copies mip 0 of layer 0 to a
/// host buffer, puts the image back in `layout` and returns the bytes.
pub fn read_rgba8_image(
    context: &Context<'_>,
    image: vk::Image,
    layout: vk::ImageLayout,
    width: u32,
    height: u32,
) -> Result<Vec<u8>, TestError> {
    read_image_aspect_bytes(
        context,
        image,
        vk::ImageAspectFlags::COLOR,
        vk::ImageAspectFlags::COLOR,
        layout,
        width,
        height,
        4,
    )
}

/// `Draw::Image::readSurface` for one aspect of an image that is in `layout` (`barrier_aspect` is every aspect the format
/// has, `copy_aspect` the one to read): copies mip 0 of layer 0 to a host buffer, puts the image back in `layout` and returns
/// the bytes, `texel_size` of them per texel.
#[allow(clippy::too_many_arguments)]
pub fn read_image_aspect_bytes(
    context: &Context<'_>,
    image: vk::Image,
    barrier_aspect: vk::ImageAspectFlags,
    copy_aspect: vk::ImageAspectFlags,
    layout: vk::ImageLayout,
    width: u32,
    height: u32,
    texel_size: usize,
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let size = (width * height) as usize * texel_size;

    let staging = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let read_cmd_buffer = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;

    let range = make_image_subresource_range(barrier_aspect, 0, 1, 0, 1);
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::MEMORY_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        range,
    );
    let back_to_layout = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_READ,
        vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        layout,
        image,
        range,
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(copy_aspect, 0, 0, 1),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);

    begin_command_buffer(device, *read_cmd_buffer)?;
    unsafe {
        device.cmd_pipeline_barrier(
            *read_cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            *read_cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            staging.get(),
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            *read_cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST | vk::PipelineStageFlags::ALL_COMMANDS,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[back_to_layout],
        );
    }
    end_command_buffer(device, *read_cmd_buffer)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *read_cmd_buffer)?;

    invalidate_alloc(device, staging.get_allocation())?;
    Ok(unsafe { std::slice::from_raw_parts(staging.get_allocation().get_host_ptr(), size) }.to_vec())
}

/// `vk::makeRenderPass(vk, device, colorFormat, depthStencilFormat, loadOperation, finalLayoutColor, finalLayoutDepthStencil)`: a
/// colour and a depth/stencil attachment, both loaded with `load_op` (the stencil aspect too), the subpass leaving them in their
/// optimal attachment layouts.
pub fn make_color_depth_stencil_render_pass<'a>(
    device: &'a Device,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    final_layout_color: vk::ImageLayout,
    final_layout_depth_stencil: vk::ImageLayout,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let loading = load_op == vk::AttachmentLoadOp::LOAD;
    let initial_layout_color = if loading {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::UNDEFINED
    };
    let initial_layout_depth_stencil = if loading {
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::UNDEFINED
    };

    let attachments = [
        vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(initial_layout_color)
            .final_layout(final_layout_color)
            .build(),
        vk::AttachmentDescription::builder()
            .format(depth_stencil_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(load_op)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(initial_layout_depth_stencil)
            .final_layout(final_layout_depth_stencil)
            .build(),
    ];
    let color_reference = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let depth_stencil_reference = vk::AttachmentReference::builder()
        .attachment(1)
        .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_reference)
        .depth_stencil_attachment(&depth_stencil_reference)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}
