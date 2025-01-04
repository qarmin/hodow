// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolStatisticsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream has a class per pipeline (`VertexShaderTestInstance`,
// `GeometryShaderTestInstance`, `TessellationShaderTestInstance`, `TessellationGeometryShaderTestInstance`) and per command
// buffer layout (primary, `...Secondary...`, `...SecondaryInherited...`), twelve classes that repeat the same command stream
// with small differences. Here `Stage` is the pipeline and `CommandBufferType` the layout, `GraphicInstance::execute_test`
// records the stream for every pair, `expected_min` holds the four `checkResult` tables and `check_result` the differences
// between how the four classes judge a result (which of them reset a query again after a HOST reset, which compare the image
// and when). The data and shaders of `QueryPoolGraphicStatisticsTest` live in `GraphicCase`; the shaders are in
// `shaders/manifest/query_pool_statistics.toml`, found by `program_key`.

use vulkanalia::prelude::v1_0::*;

use super::common::*;
use super::{ALL_STATISTICS_PROGRAM, StatisticsProgram};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::rgba::RGBA;
use crate::tcu::{TestError, TestOutcome, TestStatus, Vec4, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{default_depth_stencil_state, default_rasterization_state};
use crate::vkt::tests::draw::{
    initial_transition_color_2d_image, initial_transition_depth_2d_image, transition_2d_image,
};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;
const FLOAT_SIZE: u32 = 4;
const DEPTH_VALUES: [f32; 5] = [0.0, 0.25, 0.5, 0.75, 1.0];

/// `ClearOperation`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ClearOp {
    Noop,
    Color,
    Depth,
    Skip,
}

/// `TessPrimitiveMode`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum TessPrimMode {
    Triangles,
    Isolines,
    Quads,
}

/// Which of upstream's four pipeline classes the case runs: `VertexShaderTestInstance`, `GeometryShaderTestInstance`,
/// `TessellationShaderTestInstance` and `TessellationGeometryShaderTestInstance`.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum Stage {
    Vertex,
    Geometry,
    Tess,
    TessGeom,
}

/// `GraphicBasicTestInstance::ParametersGraphic`
#[derive(Clone, Copy, Debug)]
pub(super) struct ParametersGraphic {
    pub generic: GenericParameters,
    pub query_statistic_flags: vk::QueryPipelineStatisticFlags,
    pub primitive_topology: vk::PrimitiveTopology,
    pub vertex_only_pipe: bool,
    pub clear_op: ClearOp,
    pub no_color_attachments: bool,
    pub has_tess: bool,
    pub tess_patch_size: u32,
    pub num_tess_primitives: u32,
    pub prim_mode: TessPrimMode,
    pub point_mode: bool,
    pub primitive_restart: bool,
    pub cull_mode_front_and_back: bool,
}

impl ParametersGraphic {
    /// The constructor's defaults: a pipeline with a fragment shader, no destination offset, the NOOP clear operation, colour
    /// attachments, no tessellation and a valid stride.
    pub(super) fn new(
        query_statistic_flags: vk::QueryPipelineStatisticFlags,
        primitive_topology: vk::PrimitiveTopology,
        reset_type: ResetType,
        copy_type: CopyType,
        query_64_bits: bool,
    ) -> Self {
        Self {
            generic: GenericParameters {
                reset_type,
                copy_type,
                query_64_bits,
                dst_offset: false,
                stride_type: StrideType::Valid,
                use_device_address_commands: false,
            },
            query_statistic_flags,
            primitive_topology,
            vertex_only_pipe: false,
            clear_op: ClearOp::Noop,
            no_color_attachments: false,
            has_tess: false,
            tess_patch_size: 0,
            num_tess_primitives: 1,
            prim_mode: TessPrimMode::Quads,
            point_mode: false,
            primitive_restart: false,
            cull_mode_front_and_back: false,
        }
    }

    pub(super) fn vertex_only(mut self, vertex_only_pipe: bool) -> Self {
        self.vertex_only_pipe = vertex_only_pipe;
        self
    }

    pub(super) fn dst_offset(mut self, dst_offset: bool) -> Self {
        self.generic.dst_offset = dst_offset;
        self
    }

    pub(super) fn clear(mut self, clear_op: ClearOp) -> Self {
        self.clear_op = clear_op;
        self
    }

    pub(super) fn no_color(mut self, no_color_attachments: bool) -> Self {
        self.no_color_attachments = no_color_attachments;
        self
    }

    pub(super) fn tess(mut self, tess_patch_size: u32, num_tess_primitives: u32) -> Self {
        self.has_tess = true;
        self.tess_patch_size = tess_patch_size;
        self.num_tess_primitives = num_tess_primitives;
        self
    }

    pub(super) fn tess_mode(mut self, prim_mode: TessPrimMode, point_mode: bool) -> Self {
        self.prim_mode = prim_mode;
        self.point_mode = point_mode;
        self
    }

    pub(super) fn device_address(mut self, use_device_address_commands: bool) -> Self {
        self.generic.use_device_address_commands = use_device_address_commands;
        self
    }

    pub(super) fn restart(mut self, primitive_restart: bool) -> Self {
        self.primitive_restart = primitive_restart;
        self
    }

    pub(super) fn cull_front_and_back(mut self, cull_mode_front_and_back: bool) -> Self {
        self.cull_mode_front_and_back = cull_mode_front_and_back;
        self
    }

    /// Whether `initPrograms` builds a geometry shader for the query.
    fn has_geometry_program(&self) -> bool {
        self.query_statistic_flags.intersects(
            vk::QueryPipelineStatisticFlags::CLIPPING_INVOCATIONS
                | vk::QueryPipelineStatisticFlags::CLIPPING_PRIMITIVES
                | vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_INVOCATIONS
                | vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_PRIMITIVES,
        )
    }
}

fn topology_name(topology: vk::PrimitiveTopology) -> &'static str {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => "point_list",
        vk::PrimitiveTopology::LINE_LIST => "line_list",
        vk::PrimitiveTopology::LINE_STRIP => "line_strip",
        vk::PrimitiveTopology::TRIANGLE_LIST => "triangle_list",
        vk::PrimitiveTopology::TRIANGLE_STRIP => "triangle_strip",
        vk::PrimitiveTopology::TRIANGLE_FAN => "triangle_fan",
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => "line_list_with_adjacency",
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => "line_strip_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => "triangle_list_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => "triangle_strip_with_adjacency",
        _ => "patch_list",
    }
}

/// The key `scripts/gen_query_pool_statistics_shaders.py` names a program set by: the vertex shader, the tessellation pair, the
/// geometry shader and the fragment shader `initPrograms` builds for these parameters.
fn program_key(params: &ParametersGraphic) -> String {
    let vertex = if params.has_tess && params.tess_patch_size != 0 {
        if params.prim_mode == TessPrimMode::Triangles {
            "t3"
        } else {
            "t4"
        }
    } else if params.clear_op == ClearOp::Skip {
        "vo"
    } else {
        "v"
    };

    let tess = if params.has_tess {
        let (mode, needed) = match params.prim_mode {
            TessPrimMode::Triangles => ("triangles", 3),
            TessPrimMode::Isolines => ("isolines", 2),
            TessPrimMode::Quads => ("quads", 4),
        };
        let kept = if params.tess_patch_size > 0 && params.tess_patch_size < needed {
            params.tess_patch_size
        } else {
            0
        };
        format!("{mode}.{kept}.{}", u32::from(params.point_mode))
    } else {
        "-".to_string()
    };

    let geometry = if params.has_geometry_program() {
        topology_name(params.primitive_topology)
    } else {
        "-"
    };
    let fragment = if params.vertex_only_pipe {
        "-"
    } else if params.no_color_attachments {
        "d"
    } else {
        "c"
    };

    format!("{vertex}|{tess}|{geometry}|{fragment}")
}

/// `GraphicBasicTestInstance::VertexData`
#[derive(Clone, Copy)]
#[repr(C)]
struct VertexData {
    position: [f32; 4],
    color: [f32; 4],
}

fn vec4_array(v: Vec4) -> [f32; 4] {
    [v.x(), v.y(), v.z(), v.w()]
}

/// The constructor of `QueryPoolGraphicStatisticsTest`: the vertices the case draws, the indices when it restarts primitives.
fn build_vertex_data(
    params: &ParametersGraphic,
    block_count: u32,
    width: u32,
    height: u32,
) -> (Vec<VertexData>, Vec<u32>) {
    let mut data: Vec<VertexData> = Vec::new();
    let mut indices: Vec<u32> = Vec::new();

    if params.has_tess && params.tess_patch_size != 0 {
        let blue = vec4_array(RGBA::blue().to_vec());

        for _ in 1..=params.num_tess_primitives {
            for _ in 0..params.tess_patch_size {
                data.push(VertexData {
                    position: [0.0, 0.0, 0.0, 1.0],
                    color: blue,
                });
            }
        }
        return (data, indices);
    }

    use vk::PrimitiveTopology as T;
    let topology = params.primitive_topology;
    let is_points = topology == T::POINT_LIST;
    let is_line_strip_adj = topology == T::LINE_STRIP_WITH_ADJACENCY;
    let is_tri_strip_adj = topology == T::TRIANGLE_STRIP_WITH_ADJACENCY;
    let is_lines = topology == T::LINE_LIST || topology == T::LINE_STRIP || is_line_strip_adj;
    let is_tri_fan = topology == T::TRIANGLE_FAN;
    let quarter_width = (2.0f32 / width as f32) * 0.25;
    let quarter_height = (2.0f32 / height as f32) * 0.25;
    let margin_w = if is_points || is_lines { quarter_width } else { 0.0 };
    let margin_h = if is_points { quarter_height } else { 0.0 };

    // These coordinates will be used with different topologies, so we try to avoid drawing points on the edges.
    let left = -1.0 + margin_w;
    let right = 1.0 - margin_w;
    let center = (left + right) / 2.0;
    let top = -1.0 + margin_h;
    let bottom = -1.0 + 2.0 / block_count as f32 - margin_h;
    let middle = (top + bottom) / 2.0;

    let red = vec4_array(RGBA::red().to_vec());
    let green = vec4_array(RGBA::green().to_vec());
    let blue = vec4_array(RGBA::blue().to_vec());
    let gray = vec4_array(RGBA::gray().to_vec());

    let tri_list = topology == T::TRIANGLE_LIST;
    let vertex = |x: f32, y: f32, color: [f32; 4]| VertexData {
        position: [x, y, 1.0, 1.0],
        color,
    };

    // The four quadrants differ in their colour and in the corners they cover.
    let quadrants = [
        (red, [(left, top), (left, middle), (center, top), (center, middle)]),
        (
            green,
            [(left, middle), (left, bottom), (center, middle), (center, bottom)],
        ),
        (blue, [(center, top), (center, middle), (right, top), (right, middle)]),
        (
            gray,
            [(center, middle), (center, bottom), (right, middle), (right, bottom)],
        ),
    ];

    for (quadrant_ndx, (color, corners)) in quadrants.iter().enumerate() {
        // For line strips with adjacency, everything is drawn with a single draw call, but we add a first and a last adjacency
        // point so the strip looks like the non-adjacency case.
        if quadrant_ndx == 0 && is_line_strip_adj {
            data.push(VertexData {
                position: [-2.0, -2.0, 1.0, 1.0],
                color: red,
            });
        }
        data.push(vertex(corners[0].0, corners[0].1, *color));
        data.push(vertex(corners[1].0, corners[1].1, *color));
        // For triangle fans we'll revert the order of the first 2 vertices in each quadrant so they form a proper fan covering
        // the whole quadrant.
        if is_tri_fan {
            let len = data.len();
            data.swap(len - 1, len - 2);
        }
        data.push(vertex(corners[2].0, corners[2].1, *color));
        if tri_list {
            data.push(vertex(corners[2].0, corners[2].1, *color));
            data.push(vertex(corners[1].0, corners[1].1, *color));
        }
        data.push(vertex(corners[3].0, corners[3].1, *color));
        if quadrant_ndx == 3 && is_line_strip_adj {
            data.push(VertexData {
                position: [2.0, 2.0, 1.0, 1.0],
                color: red,
            });
        }
    }

    if params.primitive_restart {
        let first_vertex = if is_line_strip_adj { 1u32 } else { 0 };
        const RESTART_VAL: u32 = 0xFFFF_FFFF;
        let segment_count = 4u32;
        let vps = 4u32;

        for seg in 0..segment_count {
            let base = first_vertex + seg * vps;

            if is_tri_strip_adj {
                // Schema: [A, V0, A, V1, A, V2, A, V3]
                // If A then neighbor (duplicating V)
                indices.extend([base, base, base + 1, base + 1, base + 2, base + 2, base + 3, base + 3]);
            } else if is_line_strip_adj {
                // Schema: [Adj, V0, V1, Adj]
                indices.extend([base - 1, base, base + 1, base + 2, base + 3, base + 4]);
            } else if is_tri_fan {
                // Invert pivot - drawing as COUNTER_CLOCKWISE
                indices.extend([base + 1, base, base + 3, base + 2]);
            } else {
                indices.extend((0..vps).map(|vx| base + vx));
            }

            if seg < segment_count - 1 {
                indices.push(RESTART_VAL);
            }
        }
    }

    (data, indices)
}

/// `QueryPoolGraphicStatisticsTest<Instance>`
pub(super) struct GraphicCase {
    name: String,
    stage: Stage,
    kind: CommandBufferType,
    params: ParametersGraphic,
    draw_repeats: Vec<u64>,
    data: Vec<VertexData>,
    indices: Vec<u32>,
    block_count: u32,
    width: u32,
    height: u32,
}

impl GraphicCase {
    pub(super) fn new(
        name: String,
        stage: Stage,
        kind: CommandBufferType,
        params: ParametersGraphic,
        draw_repeats: &[u64],
    ) -> Self {
        // For clear-skip, we'll use one framebuffer block for each draw instead of clearing.
        let block_count = if params.clear_op == ClearOp::Skip {
            draw_repeats.iter().sum::<u64>() as u32
        } else {
            1
        };
        let width = WIDTH;
        let height = HEIGHT * block_count;
        let (data, indices) = build_vertex_data(&params, block_count, width, height);

        Self {
            name,
            stage,
            kind,
            params,
            draw_repeats: draw_repeats.to_vec(),
            data,
            indices,
            block_count,
            width,
            height,
        }
    }
}

impl TestCase for GraphicCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, self.params.generic.reset_type == ResetType::Host)?;

        let features = context.get_device_features();

        if matches!(self.stage, Stage::Geometry | Stage::TessGeom) && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader are not supported".to_string()));
        }
        if self.params.has_tess && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Tessellation shader are not supported".to_string(),
            ));
        }
        if self.kind == CommandBufferType::SecondaryInherited && features.inherited_queries == vk::FALSE {
            return Err(TestError::NotSupported(
                "Inherited queries are not supported".to_string(),
            ));
        }

        if self.params.generic.use_device_address_commands {
            context.require_device_functionality("VK_KHR_device_address_commands")?;
            return Err(TestError::NotPorted(
                "vkCmdCopyQueryPoolResultsToMemoryKHR is not bound by vulkanalia".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = program_key(&self.params);
        let program: &'static StatisticsProgram = ALL_STATISTICS_PROGRAM
            .iter()
            .copied()
            .find(|p| p.key == key)
            .unwrap_or_else(|| panic!("the manifest has no program set {key:?}"));
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GraphicInstance { context, case: self })
    }
}

/// The attachments, render pass and framebuffer (`createColorAttachmentAndRenderPass`).
struct Targets<'a> {
    color: Option<(ImageWithMemory<'a>, Unique<'a, vk::ImageView>)>,
    depth: ImageWithMemory<'a>,
    _depth_view: Unique<'a, vk::ImageView>,
    render_pass: Unique<'a, vk::RenderPass>,
    framebuffer: Unique<'a, vk::Framebuffer>,
}

/// `createDepthsBuffer`: the depths a fragment shader without colour attachment writes.
struct DepthsBuffer<'a> {
    _buffer: BufferWithMemory<'a>,
    set: UniqueDescriptorSet<'a>,
    _pool: Unique<'a, vk::DescriptorPool>,
    layout: Unique<'a, vk::DescriptorSetLayout>,
}

struct GraphicInstance<'a> {
    context: &'a Context<'a>,
    case: &'a GraphicCase,
}

impl<'a> GraphicInstance<'a> {
    fn create_targets(&self) -> Result<Targets<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let params = &self.case.params;
        let extent = vk::Extent3D {
            width: self.case.width,
            height: self.case.height,
            depth: 1,
        };

        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        let color = if params.no_color_attachments {
            None
        } else {
            let image = ImageWithMemory::new(
                device,
                alloc,
                image_info(
                    COLOR_FORMAT,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                ),
                MemoryRequirement::ANY,
            )?;
            let view = make_image_view(
                device,
                *image,
                vk::ImageViewType::_2D,
                COLOR_FORMAT,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?;
            Some((image, view))
        };

        let depth = ImageWithMemory::new(
            device,
            alloc,
            image_info(DEPTH_FORMAT, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT),
            MemoryRequirement::ANY,
        )?;
        let depth_view = make_image_view(
            device,
            *depth,
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
        let (render_pass, framebuffer) = if params.no_color_attachments {
            let attachments = [depth_attachment];
            let depth_reference = vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            };
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .depth_stencil_attachment(&depth_reference)
                .build()];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[*depth_view],
                self.case.width,
                self.case.height,
                1,
            )?;
            (render_pass, framebuffer)
        } else {
            let color_attachment = vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build();
            let attachments = [color_attachment, depth_attachment];
            let color_reference = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let depth_reference = vk::AttachmentReference {
                attachment: 1,
                layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            };
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_reference)
                .depth_stencil_attachment(&depth_reference)
                .build()];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let color_view = *color.as_ref().expect("a colour attachment").1;
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[color_view, *depth_view],
                self.case.width,
                self.case.height,
                1,
            )?;
            (render_pass, framebuffer)
        };

        Ok(Targets {
            color,
            depth,
            _depth_view: depth_view,
            render_pass,
            framebuffer,
        })
    }

    fn create_depths_buffer(&self) -> Result<Option<DepthsBuffer<'a>>, TestError> {
        // This is only created for cases with no color attachments.
        if !self.case.params.no_color_attachments {
            return Ok(None);
        }

        let context = self.context;
        let device = context.get_device();
        let size = std::mem::size_of_val(&DEPTH_VALUES) as vk::DeviceSize;

        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let allocation = buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    DEPTH_VALUES.as_ptr().cast::<u8>(),
                    allocation.get_host_ptr(),
                    size as usize,
                )
            };
            flush_alloc(device, allocation)?;
        }

        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let set = make_descriptor_set(device, *pool, *layout)?;

        DescriptorSetUpdateBuilder::new()
            .write_single(
                *set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE),
            )
            .update(device);

        Ok(Some(DepthsBuffer {
            _buffer: buffer,
            _pool: pool,
            layout,
            set,
        }))
    }

    /// The four `createPipeline` functions.
    fn create_pipeline(
        &self,
        targets: &Targets<'a>,
        depths: Option<&DepthsBuffer<'a>>,
    ) -> Result<(Unique<'a, vk::PipelineLayout>, Unique<'a, vk::Pipeline>), TestError> {
        let context = self.context;
        let device = context.get_device();
        let params = &self.case.params;
        let stage = self.case.stage;
        let features = context.get_device_features();
        let binaries = context.get_binary_collection();

        use vk::PrimitiveTopology as T;
        if stage == Stage::Vertex
            && matches!(
                params.primitive_topology,
                T::LINE_LIST_WITH_ADJACENCY
                    | T::LINE_STRIP_WITH_ADJACENCY
                    | T::TRIANGLE_LIST_WITH_ADJACENCY
                    | T::TRIANGLE_STRIP_WITH_ADJACENCY
            )
            && features.geometry_shader == vk::FALSE
        {
            return Err(TestError::NotSupported("Geometry shader are not supported".to_string()));
        }

        // Pipeline
        let vs = create_shader_module(device, binaries.get("vertex")?)?;
        let tessellation = matches!(stage, Stage::Tess | Stage::TessGeom);
        let tc = if tessellation {
            Some(create_shader_module(device, binaries.get("tessellation_control")?)?)
        } else {
            None
        };
        let te = if tessellation {
            Some(create_shader_module(device, binaries.get("tessellation_evaluation")?)?)
        } else {
            None
        };
        let use_geom_point_size = features.shader_tessellation_and_geometry_point_size != vk::FALSE
            && params.primitive_topology == T::POINT_LIST;
        let gs = match stage {
            Stage::Geometry => Some(create_shader_module(
                device,
                binaries.get(if use_geom_point_size {
                    "geometry_point_size"
                } else {
                    "geometry"
                })?,
            )?),
            Stage::TessGeom => Some(create_shader_module(device, binaries.get("geometry")?)?),
            _ => None,
        };
        let fs = if stage == Stage::Vertex && params.vertex_only_pipe {
            None
        } else {
            Some(create_shader_module(device, binaries.get("fragment")?)?)
        };

        let mut stages = vec![
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vs)
                .name(b"main\0")
                .build(),
        ];
        if let (Some(tc), Some(te)) = (&tc, &te) {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_CONTROL)
                    .module(**tc)
                    .name(b"main\0")
                    .build(),
            );
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION)
                    .module(**te)
                    .name(b"main\0")
                    .build(),
            );
        }
        if let Some(gs) = &gs {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::GEOMETRY)
                    .module(**gs)
                    .name(b"main\0")
                    .build(),
            );
        }
        if let Some(fs) = &fs {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(**fs)
                    .name(b"main\0")
                    .build(),
            );
        }

        let mut set_layouts = Vec::new();
        if params.no_color_attachments {
            set_layouts.push(*depths.expect("created for cases with no colour attachment").layout);
        }
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: FLOAT_SIZE,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(if stage == Stage::Vertex && params.clear_op == ClearOp::Skip {
                &push_constant_ranges[..]
            } else {
                &[] as &[vk::PushConstantRange]
            });
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binding_descriptions = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<VertexData>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attribute_descriptions = [
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
                offset: 16,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&binding_descriptions)
            .vertex_attribute_descriptions(&attribute_descriptions);

        let (topology, restart) = if tessellation {
            (T::PATCH_LIST, false)
        } else {
            (
                params.primitive_topology,
                stage == Stage::Vertex && params.primitive_restart,
            )
        };
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(topology)
            .primitive_restart_enable(restart);
        let tessellation_state =
            vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(if params.tess_patch_size != 0 {
                params.tess_patch_size
            } else {
                4
            });

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: self.case.width as f32,
            height: self.case.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, self.case.width, self.case.height)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);

        let mut rasterization_state = default_rasterization_state();
        if matches!(stage, Stage::Vertex | Stage::Geometry) {
            rasterization_state.cull_mode = if params.cull_mode_front_and_back {
                vk::CullModeFlags::FRONT_AND_BACK
            } else {
                vk::CullModeFlags::NONE
            };
        }
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);

        let mut depth_stencil_state = default_depth_stencil_state();
        match stage {
            Stage::Vertex | Stage::TessGeom => {
                depth_stencil_state.depth_test_enable = vk::Bool32::from(params.no_color_attachments);
                depth_stencil_state.depth_write_enable = vk::Bool32::from(params.no_color_attachments);
            }
            Stage::Geometry => {
                if features.depth_bounds != vk::FALSE {
                    depth_stencil_state.depth_test_enable = vk::TRUE;
                    depth_stencil_state.depth_write_enable = vk::TRUE;
                    depth_stencil_state.depth_compare_op = vk::CompareOp::GREATER_OR_EQUAL;
                    depth_stencil_state.depth_bounds_test_enable = vk::TRUE;
                }
            }
            Stage::Tess => {}
        }

        let attachment_states = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state =
            vk::PipelineColorBlendStateCreateInfo::builder().attachments(if params.no_color_attachments {
                &attachment_states[..0]
            } else {
                &attachment_states[..]
            });

        let mut pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*targets.render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        if tessellation {
            pipeline_info = pipeline_info.tessellation_state(&tessellation_state);
        }

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok((pipeline_layout, Unique::new(device, pipelines.0[0])))
    }

    /// `commandClearAttachment`: `CLEAR_NOOP` clears the depth like `CLEAR_DEPTH` does, which is what upstream records.
    fn command_clear_attachment(&self, command_buffer: vk::CommandBuffer) {
        let device = self.context.get_device();
        let clear_color = self.case.params.clear_op == ClearOp::Color;
        let attachment = vk::ClearAttachment {
            aspect_mask: if clear_color {
                vk::ImageAspectFlags::COLOR
            } else {
                vk::ImageAspectFlags::DEPTH
            },
            color_attachment: if clear_color { 0 } else { 1 },
            clear_value: if clear_color {
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 0.0],
                    },
                }
            } else {
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
                }
            },
        };
        let rect = vk::ClearRect {
            rect: make_rect_2d(0, 0, self.case.width, self.case.height),
            base_array_layer: 0,
            layer_count: 1,
        };
        unsafe { device.cmd_clear_attachments(command_buffer, &[attachment], &[rect]) };
    }

    /// The four `draw` functions.
    fn draw(&self, command_buffer: vk::CommandBuffer) {
        let device = self.context.get_device();
        let params = &self.case.params;

        use vk::PrimitiveTopology as T;
        unsafe {
            match self.case.stage {
                Stage::Vertex => {
                    if params.primitive_restart {
                        device.cmd_draw_indexed(command_buffer, self.case.indices.len() as u32, 1, 0, 0, 0);
                        return;
                    }

                    match params.primitive_topology {
                        T::TRIANGLE_FAN | T::TRIANGLE_STRIP => {
                            device.cmd_draw(command_buffer, 4, 1, 0, 0);
                            device.cmd_draw(command_buffer, 4, 1, 4, 1);
                            device.cmd_draw(command_buffer, 4, 1, 8, 2);
                            device.cmd_draw(command_buffer, 4, 1, 12, 3);
                        }
                        _ => device.cmd_draw(command_buffer, self.case.data.len() as u32, 1, 0, 0),
                    }
                }
                Stage::Geometry => match params.primitive_topology {
                    T::TRIANGLE_STRIP => {
                        device.cmd_draw(command_buffer, 3, 1, 0, 1);
                        device.cmd_draw(command_buffer, 3, 1, 4, 1);
                        device.cmd_draw(command_buffer, 3, 1, 8, 2);
                        device.cmd_draw(command_buffer, 3, 1, 12, 3);
                    }
                    T::TRIANGLE_LIST => {
                        device.cmd_draw(command_buffer, 3, 1, 0, 1);
                        device.cmd_draw(command_buffer, 3, 1, 6, 1);
                        device.cmd_draw(command_buffer, 3, 1, 12, 2);
                        device.cmd_draw(command_buffer, 3, 1, 18, 3);
                    }
                    _ => device.cmd_draw(command_buffer, 16, 1, 0, 0),
                },
                Stage::Tess => device.cmd_draw(command_buffer, self.case.data.len() as u32, 1, 0, 0),
                Stage::TessGeom => device.cmd_draw(
                    command_buffer,
                    params.tess_patch_size * params.num_tess_primitives,
                    1,
                    0,
                    0,
                ),
            }
        }
    }

    /// What one query's worth of commands is, wherever they are recorded: the query (unless the primary command buffer holds it
    /// around the render pass), the pipeline and buffers, the draws and for the vertex pipeline the clear.
    #[allow(clippy::too_many_arguments)]
    fn record_query_commands(
        &self,
        command_buffer: vk::CommandBuffer,
        query_pool: vk::QueryPool,
        query_ndx: usize,
        query_in_command_buffer: bool,
        pipeline: vk::Pipeline,
        pipeline_layout: vk::PipelineLayout,
        vertex_buffer: vk::Buffer,
        index_buffer: Option<vk::Buffer>,
        depths: Option<&DepthsBuffer<'_>>,
        current_offset: &mut f32,
    ) {
        let device = self.context.get_device();
        let params = &self.case.params;
        let vertex = self.case.stage == Stage::Vertex;

        unsafe {
            if query_in_command_buffer {
                device.cmd_begin_query(
                    command_buffer,
                    query_pool,
                    query_ndx as u32,
                    vk::QueryControlFlags::empty(),
                );
            }
            device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_bind_vertex_buffers(command_buffer, 0, &[vertex_buffer], &[0]);
            if let (true, Some(index_buffer)) = (vertex && params.primitive_restart, index_buffer) {
                device.cmd_bind_index_buffer(command_buffer, index_buffer, 0, vk::IndexType::UINT32);
            }

            let use_offset_push_constant = vertex && params.clear_op == ClearOp::Skip;
            let offset_step = 2.0f32 / self.case.block_count as f32;

            for _ in 0..self.case.draw_repeats[query_ndx] {
                if use_offset_push_constant {
                    device.cmd_push_constants(
                        command_buffer,
                        pipeline_layout,
                        vk::ShaderStageFlags::VERTEX,
                        0,
                        &current_offset.to_ne_bytes(),
                    );
                    *current_offset += offset_step;
                }
                if let Some(depths) = depths {
                    device.cmd_bind_descriptor_sets(
                        command_buffer,
                        vk::PipelineBindPoint::GRAPHICS,
                        pipeline_layout,
                        0,
                        &[*depths.set],
                        &[],
                    );
                }
                self.draw(command_buffer);
            }

            if query_in_command_buffer {
                if vertex && params.clear_op != ClearOp::Skip {
                    self.command_clear_attachment(command_buffer);
                }
                device.cmd_end_query(command_buffer, query_pool, query_ndx as u32);
            }
        }
    }

    /// The four `executeTest` functions and their secondary variants.
    #[allow(clippy::too_many_arguments)]
    fn execute_test(
        &self,
        targets: &Targets<'a>,
        depths: Option<&DepthsBuffer<'a>>,
        pipeline_layout: vk::PipelineLayout,
        pipeline: vk::Pipeline,
        reset_buffer: &BufferWithMemory<'a>,
        query_pool: vk::QueryPool,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let params = &self.case.params;
        let kind = self.case.kind;
        let query_count = self.case.draw_repeats.len();
        let queue = context.get_universal_queue();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let vertex_bytes = unsafe {
            std::slice::from_raw_parts(
                self.case.data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(self.case.data.as_slice()),
            )
        };
        let vertex_buffer = self.create_host_buffer(vertex_bytes, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let index_buffer = if self.case.stage == Stage::Vertex && params.primitive_restart {
            let index_bytes = unsafe {
                std::slice::from_raw_parts(
                    self.case.indices.as_ptr().cast::<u8>(),
                    std::mem::size_of_val(self.case.indices.as_slice()),
                )
            };
            Some(self.create_host_buffer(index_bytes, vk::BufferUsageFlags::INDEX_BUFFER)?)
        } else {
            None
        };

        let primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let depths_for_draw = depths;
        let mut current_offset = 0.0f32;

        let mut secondaries: Vec<UniqueCommandBuffer<'_>> = Vec::new();
        if kind != CommandBufferType::Primary {
            for ndx in 0..query_count {
                let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
                begin_secondary_command_buffer(
                    device,
                    *secondary,
                    params.query_statistic_flags,
                    *targets.render_pass,
                    *targets.framebuffer,
                    vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE,
                )?;
                self.record_query_commands(
                    *secondary,
                    query_pool,
                    ndx,
                    kind == CommandBufferType::Secondary,
                    pipeline,
                    pipeline_layout,
                    vertex_buffer.get(),
                    index_buffer.as_ref().map(BufferWithMemory::get),
                    depths_for_draw,
                    &mut current_offset,
                );
                end_command_buffer(device, *secondary)?;
                secondaries.push(secondary);
            }
        }

        begin_command_buffer(device, *primary)?;

        let render_pass_clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            },
        ];
        let begin_render_pass = |contents: vk::SubpassContents| {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*targets.render_pass)
                .framebuffer(*targets.framebuffer)
                .render_area(make_rect_2d(0, 0, self.case.width, self.case.height))
                .clear_values(&render_pass_clear_values);
            unsafe { device.cmd_begin_render_pass(*primary, &begin_info, contents) };
        };

        if let Some((image, _)) = &targets.color {
            initial_transition_color_2d_image(
                device,
                *primary,
                **image,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                1,
            );
        }
        initial_transition_depth_2d_image(
            device,
            *primary,
            *targets.depth,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        );

        if params.generic.reset_type != ResetType::Host {
            unsafe { device.cmd_reset_query_pool(*primary, query_pool, 0, query_count as u32) };
        }

        match kind {
            CommandBufferType::Primary => {
                begin_render_pass(vk::SubpassContents::INLINE);
                for ndx in 0..query_count {
                    self.record_query_commands(
                        *primary,
                        query_pool,
                        ndx,
                        true,
                        pipeline,
                        pipeline_layout,
                        vertex_buffer.get(),
                        index_buffer.as_ref().map(BufferWithMemory::get),
                        depths_for_draw,
                        &mut current_offset,
                    );
                }
                unsafe { device.cmd_end_render_pass(*primary) };
            }
            CommandBufferType::Secondary => {
                begin_render_pass(vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
                for secondary in &secondaries {
                    unsafe { device.cmd_execute_commands(*primary, &[**secondary]) };
                }
                unsafe { device.cmd_end_render_pass(*primary) };
            }
            CommandBufferType::SecondaryInherited => {
                for (ndx, secondary) in secondaries.iter().enumerate() {
                    unsafe { device.cmd_begin_query(*primary, query_pool, ndx as u32, vk::QueryControlFlags::empty()) };
                    begin_render_pass(vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
                    unsafe {
                        device.cmd_execute_commands(*primary, &[**secondary]);
                        device.cmd_end_render_pass(*primary);
                        device.cmd_end_query(*primary, query_pool, ndx as u32);
                    }
                }
            }
        }

        record_query_copy(
            device,
            *primary,
            query_pool,
            query_count as u32,
            &params.generic,
            reset_buffer.get(),
        );

        if let Some((image, _)) = &targets.color {
            transition_2d_image(
                device,
                *primary,
                **image,
                vk::ImageAspectFlags::COLOR,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
        }
        end_command_buffer(device, *primary)?;

        if params.generic.reset_type == ResetType::Host {
            host_reset_query_pool(context, query_pool, 0, query_count as u32);
        }

        // Wait for completion
        submit_commands_and_wait(device, queue, *primary)
    }

    /// `creatAndFillVertexBuffer` and `creatAndFillIndexBuffer`: a host visible buffer holding `bytes`, rounded up to the atom size.
    fn create_host_buffer(&self, bytes: &[u8], usage: vk::BufferUsageFlags) -> Result<BufferWithMemory<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let atom_size = context.get_device_properties().limits.non_coherent_atom_size.max(1);
        let size = (bytes.len() as vk::DeviceSize).div_ceil(atom_size) * atom_size;

        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(size, usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let allocation = buffer.get_allocation();
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), allocation.get_host_ptr(), bytes.len()) };
        flush_alloc(device, allocation)?;
        Ok(buffer)
    }

    /// `GraphicBasicTestInstance::checkImage`: what was drawn, against the quadrants or the tessellated quad it should be.
    fn check_image(&self, targets: &Targets<'a>) -> Result<bool, TestError> {
        let params = &self.case.params;
        let Some((image, _)) = &targets.color else {
            return Ok(true);
        };
        let (width, height) = (self.case.width, self.case.height);

        let rendered = read_color_attachment(
            self.context,
            **image,
            COLOR_FORMAT,
            (width, height),
            vk::ImageLayout::GENERAL,
        )?;

        if params.vertex_only_pipe {
            return Ok(true);
        }

        let format = map_vk_format(COLOR_FORMAT)
            .ok_or_else(|| TestError::InternalError("no texture format for the colour attachment".to_string()))?;
        let mut reference = TextureLevel::new(format, width, height, 1)?;
        {
            let mut access = reference.get_access();

            if params.tess_patch_size != 0 {
                let blue = vec4_array(RGBA::blue().to_vec());
                let clear = [0.0f32; 4];
                for y in 0..height {
                    for x in 0..width {
                        let color = match params.prim_mode {
                            // Triangle in top-left corner
                            TessPrimMode::Triangles => {
                                if (x as i64) < (width as i64 - y as i64) - 1 {
                                    blue
                                } else {
                                    clear
                                }
                            }
                            // Fill with a single horizontal line at the bottom
                            TessPrimMode::Isolines => {
                                if y >= height - 1 {
                                    blue
                                } else {
                                    clear
                                }
                            }
                            TessPrimMode::Quads => blue,
                        };
                        access.set_pixel(color, x, y, 0);
                    }
                }
            } else {
                let color_inc = if params.primitive_topology == vk::PrimitiveTopology::TRIANGLE_LIST {
                    6
                } else {
                    4
                };

                for y in 0..height {
                    for x in 0..width {
                        let quadrant = usize::from(x >= width / 2) * 2 + usize::from(y >= height / 2);
                        access.set_pixel(
                            self.case.data[quadrant_to_color_ndx(quadrant, color_inc)].color,
                            x,
                            y,
                            0,
                        );
                    }
                }
            }
        }

        Ok(float_threshold_compare(&reference.get_const_access(), &rendered.get_const_access(), [0.01; 4]).ok)
    }
}

/// The vertex a quadrant takes its colour from: the first vertex of each quadrant's block, in the order the quadrants are
/// stored (top left, bottom left, top right, bottom right).
fn quadrant_to_color_ndx(quadrant: usize, color_inc: usize) -> usize {
    // `quadrant` counts x first: 0 top left, 1 bottom left, 2 top right, 3 bottom right.
    quadrant * color_inc
}

/// The expected minimum of the query, from the four `checkResult` tables.
fn expected_min(stage: Stage, params: &ParametersGraphic) -> u64 {
    use vk::{PrimitiveTopology as T, QueryPipelineStatisticFlags as S};
    let t = params.primitive_topology;
    let stat = params.query_statistic_flags;

    match stage {
        Stage::Vertex => {
            if stat == S::INPUT_ASSEMBLY_VERTICES {
                16
            } else if stat == S::VERTEX_SHADER_INVOCATIONS {
                match t {
                    T::TRIANGLE_LIST => 24,
                    T::LINE_LIST_WITH_ADJACENCY => 8,
                    T::LINE_STRIP_WITH_ADJACENCY => 14,
                    T::TRIANGLE_LIST_WITH_ADJACENCY => 6,
                    T::TRIANGLE_STRIP_WITH_ADJACENCY => 8,
                    _ => 16,
                }
            } else if stat == S::INPUT_ASSEMBLY_PRIMITIVES {
                let line_strip_min = if params.primitive_restart { 12 } else { 15 };
                let line_strip_adj_min = if params.primitive_restart { 12 } else { 13 };
                match t {
                    T::POINT_LIST => 16,
                    T::LINE_LIST => 8,
                    T::LINE_STRIP => line_strip_min,
                    T::TRIANGLE_LIST | T::TRIANGLE_STRIP | T::TRIANGLE_FAN => 8,
                    T::LINE_LIST_WITH_ADJACENCY => 4,
                    T::LINE_STRIP_WITH_ADJACENCY => line_strip_adj_min,
                    T::TRIANGLE_LIST_WITH_ADJACENCY => 2,
                    T::TRIANGLE_STRIP_WITH_ADJACENCY => 6,
                    _ => 0,
                }
            } else if stat == S::FRAGMENT_SHADER_INVOCATIONS {
                match t {
                    T::POINT_LIST => 9,
                    T::LINE_LIST => 192,
                    T::LINE_STRIP => 374,
                    T::TRIANGLE_LIST | T::TRIANGLE_STRIP | T::TRIANGLE_FAN => 4096,
                    T::LINE_LIST_WITH_ADJACENCY => 128,
                    T::LINE_STRIP_WITH_ADJACENCY => 374,
                    T::TRIANGLE_LIST_WITH_ADJACENCY => 992,
                    T::TRIANGLE_STRIP_WITH_ADJACENCY => 2048,
                    _ => 0,
                }
            } else {
                // `CLIPPING_INVOCATIONS_BIT` and `CLIPPING_PRIMITIVES_BIT`
                match t {
                    T::POINT_LIST => 16,
                    T::LINE_LIST => 8,
                    T::LINE_STRIP => 15,
                    T::TRIANGLE_LIST | T::TRIANGLE_STRIP | T::TRIANGLE_FAN => 8,
                    T::LINE_LIST_WITH_ADJACENCY => 4,
                    T::LINE_STRIP_WITH_ADJACENCY => 13,
                    T::TRIANGLE_LIST_WITH_ADJACENCY => 2,
                    T::TRIANGLE_STRIP_WITH_ADJACENCY => 6,
                    _ => 0,
                }
            }
        }
        Stage::Geometry => {
            if stat == S::GEOMETRY_SHADER_INVOCATIONS {
                match t {
                    T::POINT_LIST => 16,
                    T::LINE_LIST => 8,
                    T::LINE_STRIP => 15,
                    T::TRIANGLE_LIST | T::TRIANGLE_STRIP | T::TRIANGLE_FAN => 4,
                    T::LINE_LIST_WITH_ADJACENCY => 4,
                    T::LINE_STRIP_WITH_ADJACENCY => 13,
                    T::TRIANGLE_LIST_WITH_ADJACENCY => 2,
                    T::TRIANGLE_STRIP_WITH_ADJACENCY => 6,
                    _ => 0,
                }
            } else {
                // `GEOMETRY_SHADER_PRIMITIVES_BIT`, `CLIPPING_INVOCATIONS_BIT` and `CLIPPING_PRIMITIVES_BIT`
                match t {
                    T::POINT_LIST => 112,
                    T::LINE_LIST => 32,
                    T::LINE_STRIP => 60,
                    T::TRIANGLE_LIST | T::TRIANGLE_STRIP | T::TRIANGLE_FAN => 8,
                    T::LINE_LIST_WITH_ADJACENCY => 16,
                    T::LINE_STRIP_WITH_ADJACENCY => 52,
                    T::TRIANGLE_LIST_WITH_ADJACENCY => 4,
                    T::TRIANGLE_STRIP_WITH_ADJACENCY => 12,
                    _ => 0,
                }
            }
        }
        Stage::Tess => {
            if stat == S::INPUT_ASSEMBLY_PRIMITIVES {
                u64::from(params.num_tess_primitives)
            } else if stat == S::TESSELLATION_CONTROL_SHADER_PATCHES {
                4
            } else if stat == S::TESSELLATION_EVALUATION_SHADER_INVOCATIONS {
                match params.prim_mode {
                    TessPrimMode::Triangles => 76,
                    TessPrimMode::Isolines => 80,
                    TessPrimMode::Quads => 100,
                }
            } else {
                // `CLIPPING_INVOCATIONS_BIT` and `CLIPPING_PRIMITIVES_BIT`
                match (params.prim_mode, params.point_mode) {
                    (TessPrimMode::Triangles, true) => 15,
                    (TessPrimMode::Triangles, false) => 16,
                    (TessPrimMode::Isolines, true) => 9,
                    (TessPrimMode::Isolines, false) => 12,
                    (TessPrimMode::Quads, true) => 25,
                    (TessPrimMode::Quads, false) => 32,
                }
            }
        }
        Stage::TessGeom => {
            if stat == S::INPUT_ASSEMBLY_PRIMITIVES {
                u64::from(params.num_tess_primitives)
            } else if stat == S::TESSELLATION_CONTROL_SHADER_PATCHES {
                4
            } else if stat == S::TESSELLATION_EVALUATION_SHADER_INVOCATIONS {
                100
            } else {
                64
            }
        }
    }
}

impl<'a> GraphicInstance<'a> {
    /// The four `checkResult` functions.
    #[allow(unused_assignments)]
    fn check_result(
        &self,
        targets: &Targets<'a>,
        query_pool: vk::QueryPool,
        reset_buffer: &BufferWithMemory<'a>,
    ) -> TestOutcome {
        let context = self.context;
        let params = &self.case.params;
        let stage = self.case.stage;
        let repeats = &self.case.draw_repeats;
        let query_count = repeats.len() as u32;
        let expected = expected_min(stage, params);
        let reader = ResultReader {
            context,
            query_pool,
            query_count,
            params: params.generic,
            reset_buffer,
        };

        // The vertex and geometry classes forgive a culled primitive counting nothing.
        let cull_allows_zero = matches!(stage, Stage::Vertex | Stage::Geometry) && params.cull_mode_front_and_back;
        // The geometry and tessellation classes reset the queries again after every HOST result, the others only for one query.
        let always_reset_check = matches!(stage, Stage::Geometry | Stage::Tess);

        // The geometry class reads the image first, and the others once their results are in; it keeps the resource counter of
        // Vulkan SC stable and costs nothing here.
        let image_first = matches!(stage, Stage::Geometry | Stage::Tess);
        let mut image_ok = if image_first {
            Some(self.check_image(targets)?)
        } else {
            None
        };

        let mut error_msg = String::new();

        match params.generic.reset_type {
            ResetType::Normal | ResetType::AfterCopy => {
                let results = reader.read_values()?;

                if results[0] < expected && (!cull_allows_zero || results[0] != 0) {
                    error_msg = format!(
                        "QueryPoolResults incorrect: expected at least {expected} but got {}",
                        results[0]
                    );
                } else if query_count > 1 {
                    let pearson = calculate_pearson_correlation(repeats, &results);
                    if pearson.abs() < 0.8 {
                        error_msg = format!("QueryPoolResults are nonlinear: Pearson {pearson} for {results:?}");
                    }
                }
            }
            ResetType::Host => {
                let mut results = reader.read_values_with_availability()?;

                if results[0].0 < expected || results[0].1 == 0 {
                    error_msg = format!(
                        "QueryPoolResults incorrect: expected at least {expected} with availability 1 but got {} with availability {}",
                        results[0].0, results[0].1
                    );
                } else {
                    if query_count > 1 {
                        let values: Vec<u64> = results.iter().map(|r| r.0).collect();
                        let pearson = calculate_pearson_correlation(repeats, &values);
                        if pearson.abs() < 0.8 {
                            error_msg = format!("QueryPoolResults are nonlinear: Pearson {pearson} for {values:?}");
                        }
                    }
                    if error_msg.is_empty()
                        && (always_reset_check || query_count == 1)
                        && !reader.check_reset_again(&mut results)?
                    {
                        error_msg = "QueryPoolResults incorrect reset".to_string();
                    }
                }
            }
            ResetType::BeforeCopy => {
                // With RESET_TYPE_BEFORE_COPY, we only need to verify the result after the copy include an availability bit set as zero.
                let status = verify_unavailable(context.get_device(), reset_buffer, params.generic.dst_offset)?;
                if matches!(stage, Stage::Geometry | Stage::Tess) {
                    return Ok(status);
                }
                if status.is_fail() {
                    error_msg = status.description().to_string();
                }
            }
        }

        if !error_msg.is_empty() {
            if image_ok.is_none() {
                // Read for the same reason upstream does.
                image_ok = Some(self.check_image(targets)?);
            }
            return Ok(TestStatus::fail(error_msg));
        }

        let image_ok = match image_ok {
            Some(ok) => ok,
            None => self.check_image(targets)?,
        };

        use vk::PrimitiveTopology as T;
        let image_expected_to_match = match stage {
            // Don't need to check the result image when clearing operations are executed.
            Stage::Vertex => {
                params.primitive_topology == T::TRIANGLE_STRIP
                    && params.clear_op == ClearOp::Noop
                    && !params.no_color_attachments
                    && !params.cull_mode_front_and_back
            }
            Stage::Geometry => {
                matches!(params.primitive_topology, T::TRIANGLE_LIST | T::TRIANGLE_STRIP)
                    && !params.cull_mode_front_and_back
            }
            // Skip image verification for point mode tessellation tests
            Stage::Tess => {
                matches!(params.generic.reset_type, ResetType::Normal | ResetType::AfterCopy)
                    && !params.no_color_attachments
                    && !params.point_mode
            }
            Stage::TessGeom => !params.no_color_attachments,
        };

        if image_expected_to_match && !image_ok {
            return Ok(TestStatus::fail(if stage == Stage::Geometry {
                "Result image doesn't match expected image."
            } else {
                "Result image doesn't match expected image"
            }));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for GraphicInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let query_count = self.case.draw_repeats.len() as u32;

        let reset_buffer = create_reset_buffer(context, query_count, self.case.params.generic.dst_offset)?;
        let targets = self.create_targets()?;
        let depths = self.create_depths_buffer()?;
        let (pipeline_layout, pipeline) = self.create_pipeline(&targets, depths.as_ref())?;

        let query_pool = Unique::new(
            device,
            make_query_pool(device, query_count, self.case.params.query_statistic_flags)?,
        );

        self.execute_test(
            &targets,
            depths.as_ref(),
            *pipeline_layout,
            *pipeline,
            &reset_buffer,
            *query_pool,
        )?;
        self.check_result(&targets, *query_pool, &reset_buffer)
    }
}
