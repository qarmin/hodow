// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineExtendedDynamicStateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The first slices of the `extended_dynamic_state.<ordering>` groups: the cull mode, front face and rasterizer discard cases
// (`cull_*`, `front_face_*`, `disable_raster`, `enable_raster`) and the colour blend enable and equation ones (`color_blend_enable`, `color_blend_disable`,
// `color_blend_equation_{new,old}_color`) the logic op ones (`logic_op_or`, `logic_op_enable`, `logic_op_disable`, on an unsigned integer attachment) and `color_write_mask_*`, `depth_test_{enable,disable}` and `depth_write_{enable,disable}` `depth_compare_*`, `depth_bounds_test_{enable,disable}` `stencil_test_{enable,disable}`, the `stencil_state_*` operation cases (without the extra pipeline variants), `null_color_blend_att_ptr`, `prim_restart_enable`, `topology_{triangle,line,patch}[_geom]`, `patch_control_points`, `tess_domain_origin_*`, `depth_clamp_{enable,disable}`, `depth_clip_enable_*`, `negative_one_to_one_*`, `provoking_vertex_*`, the `{single,multi}_sample_*` rasterization samples, sample mask and alpha to coverage and one cases, `color_blend_equation_{new,old}_color_dynamic_but_logic_op_*`, `polygon_mode_{point,fill}`, the depth bias enable and disable cases, and the viewport and scissor cases (`2_viewports`, `1_full_viewport`, `2_scissors`, ...) in the eight sequence orderings, with monolithic pipelines, the default vertex generator (a `vec2` position
// with 8 bytes of padding), classic pipelines and one unorm colour attachment. Upstream's `TestConfig` has a static and a dynamic value for every state; only the thirty one states
// of these slices are carried. The depth/stencil attachment is a D32S8 or D24S8 image per iteration, checked for the depth and the zero stencil after the colour. The shaders are in
// shaders/manifest/pipeline_extended_dynamic_state_basic.toml.
// Later slices: conservative rasterization, line stipple and line rasterization mode, depth bias representation, implicit depth clip, sample mask count, sample locations, null state pointers, the dynamic vertex input and stride (padding, extra attributes, instance rate, multiple bindings, float16), viewport swizzle and W scaling, shading rate image, coverage to color enable, dual source and advanced blending, the representative fragment test and sample shading counters, and the `mesh_shader` rerun of the slices that do not need vertex input, tessellation or geometry shaders.
// Not ported: the extra pipeline variants, coverage to color location, coverage modulation and reduction, and `bind_unused_ms`. The shader object construction types run the same cases (`add_extended_dynamic_state_basic_groups_for`) with dynamic rendering, and the static values of a pipeline set after the shaders are bound (`static_as_dynamic`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtColorWriteEnableExtensionDeviceCommands, ExtDepthBiasControlExtensionDeviceCommands,
    ExtExtendedDynamicState2ExtensionDeviceCommands, ExtExtendedDynamicState3ExtensionDeviceCommands,
    ExtExtendedDynamicStateExtensionDeviceCommands, ExtLineRasterizationExtensionDeviceCommands,
    ExtMeshShaderExtensionDeviceCommands, ExtSampleLocationsExtensionDeviceCommands,
    ExtVertexInputDynamicStateExtensionDeviceCommands, InstanceV1_1, NvShadingRateImageExtensionDeviceCommands,
};

use crate::generated::shaders::pipeline_extended_dynamic_state_basic::EXTENDED_DYNAMIC_STATE_BASIC;
use crate::generated::shaders::pipeline_extended_dynamic_state_basic_mesh::EXTENDED_DYNAMIC_STATE_BASIC_MESH;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::DrawPipelineState;
use crate::vkt::tests::mesh_shader::util::check_task_mesh_shader_support_ext;
use crate::vkt::tests::pipeline::pipeline_util::{
    make_color_depth_render_pass, read_color_attachment, read_depth_attachment, read_stencil_attachment,
};
use crate::vkt::tests::pipeline::shader_object_draw::{
    ShaderObjectDraw, end_dynamic_rendering, make_shader_objects_stages,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FRAMEBUFFER_SIZE: u32 = 64;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
/// `kDepthStencilFormats`: the format and the depth threshold of its comparison.
const DEPTH_STENCIL_FORMATS: [(vk::Format, f32); 2] = [
    (vk::Format::D32_SFLOAT_S8_UINT, 0.0),
    (vk::Format::D24_UNORM_S8_UINT, 1.0e-07),
];
const TRIANGLE_COLOR: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

/// The vertex generators of the vertex input cases: `VertexWithPadding` and `VertexWithExtraAttributes`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexGen {
    Padding,
    Extra,
    Padding16,
    Instance,
    Multiple,
}

impl VertexGen {
    fn stride(self) -> u32 {
        match self {
            Self::Padding => 16,
            Self::Extra => 96,
            Self::Padding16 | Self::Instance => 8,
            Self::Multiple => 8,
        }
    }

    /// The strides of the bindings; the first two come from the config, the rest are fixed (`MultipleBindingsVertex`: Zeros, PaddingOnes, Zeros, CoordsData, Zeros, OneZeroPadding).
    fn binding_strides(self, first_two: [u32; 2]) -> Vec<u32> {
        match self {
            Self::Instance => vec![first_two[0], first_two[1]],
            Self::Multiple => vec![first_two[0], first_two[1], 8, 24, 8, 40],
            _ => vec![first_two[0]],
        }
    }

    fn shader_name(self) -> &'static str {
        match self {
            Self::Padding => "vert",
            Self::Extra => "vertExtra",
            Self::Padding16 => "vertPadding16",
            Self::Instance => "vertInstance",
            Self::Multiple => "vertMultiple",
        }
    }

    /// The location, binding, format and offset of each attribute.
    fn attributes(self) -> Vec<(u32, u32, vk::Format, u32)> {
        match self {
            Self::Padding => vec![(0, 0, vk::Format::R32G32_SFLOAT, 0)],
            Self::Padding16 => vec![(0, 0, vk::Format::R16G16_SFLOAT, 0)],
            Self::Extra => vec![
                (0, 0, vk::Format::R32G32_SFLOAT, 0),
                (1, 0, vk::Format::R32G32_SFLOAT, 88),
            ],
            Self::Instance => vec![
                (0, 0, vk::Format::R32G32_SFLOAT, 0),
                (1, 1, vk::Format::R32G32_SFLOAT, 0),
            ],
            Self::Multiple => vec![
                (1, 3, vk::Format::R32G32_SFLOAT, 8),
                (2, 5, vk::Format::R32G32B32A32_SFLOAT, 0),
                (0, 1, vk::Format::R32G32_SFLOAT, 32),
            ],
        }
    }

    /// The binding descriptions with the strides of both bindings; the second binding is only used by the instance rate generator.
    fn bindings(self, strides: [u32; 2]) -> Vec<(u32, u32, vk::VertexInputRate)> {
        match self {
            Self::Instance => vec![
                (0, strides[0], vk::VertexInputRate::VERTEX),
                (1, strides[1], vk::VertexInputRate::INSTANCE),
            ],
            Self::Multiple => {
                let all = self.binding_strides(strides);
                let rates = [
                    vk::VertexInputRate::INSTANCE,
                    vk::VertexInputRate::VERTEX,
                    vk::VertexInputRate::INSTANCE,
                    vk::VertexInputRate::VERTEX,
                    vk::VertexInputRate::INSTANCE,
                    vk::VertexInputRate::VERTEX,
                ];
                (0..6)
                    .map(|binding| (binding as u32, all[binding], rates[binding]))
                    .collect()
            }
            _ => vec![(0, strides[0], vk::VertexInputRate::VERTEX)],
        }
    }

    /// The instance data of the second binding: scale and offset of Y for two instances, each followed by garbage.
    fn instance_data() -> Vec<u8> {
        [0.5f32, -0.5, 0.0, 777.0, 0.5, 0.5, 0.0, 777.0]
            .iter()
            .flat_map(|value| value.to_ne_bytes())
            .collect()
    }

    /// The data of every binding.
    fn buffers(self, coords: &[[f32; 2]]) -> Vec<Vec<u8>> {
        match self {
            Self::Instance => vec![self.vertex_data(coords), Self::instance_data()],
            Self::Multiple => {
                let count = coords.len();
                let mut result = vec![
                    vec![0u8; count * 8],
                    vec![0u8; count * 40],
                    vec![0u8; count * 8],
                    vec![0u8; count * 24],
                    vec![0u8; count * 8],
                    vec![0u8; count * 40],
                ];
                for (index, coord) in coords.iter().enumerate() {
                    result[1][index * 40 + 32..index * 40 + 36].copy_from_slice(&1.0f32.to_ne_bytes());
                    result[1][index * 40 + 36..index * 40 + 40].copy_from_slice(&1.0f32.to_ne_bytes());
                    result[3][index * 24..index * 24 + 4].copy_from_slice(&0.0f32.to_ne_bytes());
                    result[3][index * 24 + 4..index * 24 + 8].copy_from_slice(&3.0f32.to_ne_bytes());
                    result[3][index * 24 + 8..index * 24 + 12].copy_from_slice(&coord[0].to_ne_bytes());
                    result[3][index * 24 + 12..index * 24 + 16].copy_from_slice(&coord[1].to_ne_bytes());
                    result[3][index * 24 + 16..index * 24 + 20].copy_from_slice(&3.0f32.to_ne_bytes());
                    result[5][index * 40..index * 40 + 4].copy_from_slice(&1.0f32.to_ne_bytes());
                    result[5][index * 40 + 4..index * 40 + 8].copy_from_slice(&1.0f32.to_ne_bytes());
                }
                result
            }
            _ => vec![self.vertex_data(coords)],
        }
    }

    /// `createVertexData`: the coordinates, the padding and the ones of `VertexWithExtraAttributes`.
    fn vertex_data(self, coords: &[[f32; 2]]) -> Vec<u8> {
        let mut bytes = vec![0u8; coords.len() * self.stride() as usize];
        for (index, coord) in coords.iter().enumerate() {
            let base = index * self.stride() as usize;
            if self == Self::Instance {
                bytes[base..base + 4].copy_from_slice(&coord[0].to_ne_bytes());
                bytes[base + 4..base + 8].copy_from_slice(&coord[1].to_ne_bytes());
                continue;
            }
            if self == Self::Padding16 {
                bytes[base..base + 2].copy_from_slice(&crate::tcu::pixel::f32_to_f16_bits(coord[0]).to_ne_bytes());
                bytes[base + 2..base + 4].copy_from_slice(&crate::tcu::pixel::f32_to_f16_bits(coord[1]).to_ne_bytes());
                continue;
            }
            bytes[base..base + 4].copy_from_slice(&coord[0].to_ne_bytes());
            bytes[base + 4..base + 8].copy_from_slice(&coord[1].to_ne_bytes());
            if self == Self::Extra {
                bytes[base + 88..base + 92].copy_from_slice(&1.0f32.to_ne_bytes());
                bytes[base + 92..base + 96].copy_from_slice(&1.0f32.to_ne_bytes());
            }
        }
        bytes
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SequenceOrdering {
    CmdBufferStart,
    BeforeDraw,
    BetweenPipelines,
    AfterPipelines,
    BeforeGoodStatic,
    TwoDrawsDynamic,
    TwoDrawsStatic,
    ThreeDrawsDynamic,
}

/// `MeshParams`
#[derive(Clone, Copy)]
struct Mesh {
    color: [f32; 4],
    depth: f32,
    reversed: bool,
    scale_y: f32,
    offset_y: f32,
    strip_scale: f32,
}

impl Mesh {
    fn new(color: [f32; 4], depth: f32) -> Self {
        Self {
            color,
            depth,
            reversed: false,
            scale_y: 1.0,
            offset_y: 0.0,
            strip_scale: 0.0,
        }
    }
}

/// `StencilOpParams`
#[derive(Clone, Copy)]
struct StencilOpParams {
    face_mask: vk::StencilFaceFlags,
    fail_op: vk::StencilOp,
    pass_op: vk::StencilOp,
    depth_fail_op: vk::StencilOp,
    compare_op: vk::CompareOp,
}

/// `kDefaultStencilOpParams`
const DEFAULT_STENCIL_OP_PARAMS: StencilOpParams = StencilOpParams {
    face_mask: vk::StencilFaceFlags::FRONT_AND_BACK,
    fail_op: vk::StencilOp::KEEP,
    pass_op: vk::StencilOp::KEEP,
    depth_fail_op: vk::StencilOp::KEEP,
    compare_op: vk::CompareOp::ALWAYS,
};

/// `StaticAndDynamicPair`
#[derive(Clone)]
struct Pair<T: Clone> {
    static_value: T,
    dynamic_value: Option<T>,
}

impl<T: Clone> Pair<T> {
    fn fixed(value: T) -> Self {
        Self {
            static_value: value,
            dynamic_value: None,
        }
    }

    fn both(static_value: T, dynamic_value: T) -> Self {
        Self {
            static_value,
            dynamic_value: Some(dynamic_value),
        }
    }

    fn swap_values(&mut self) {
        if let Some(dynamic_value) = self.dynamic_value.as_mut() {
            std::mem::swap(&mut self.static_value, dynamic_value);
        }
    }
}

/// `ColorBlendEq`
#[derive(Clone, Copy)]
struct ColorBlendEq {
    src_color: vk::BlendFactor,
    dst_color: vk::BlendFactor,
    color_op: vk::BlendOp,
    src_alpha: vk::BlendFactor,
    dst_alpha: vk::BlendFactor,
    alpha_op: vk::BlendOp,
}

impl ColorBlendEq {
    fn new(
        src_color: vk::BlendFactor,
        dst_color: vk::BlendFactor,
        color_op: vk::BlendOp,
        src_alpha: vk::BlendFactor,
        dst_alpha: vk::BlendFactor,
        alpha_op: vk::BlendOp,
    ) -> Self {
        Self {
            src_color,
            dst_color,
            color_op,
            src_alpha,
            dst_alpha,
            alpha_op,
        }
    }

    /// `isAdvancedBlendOp`: the operations of VK_EXT_blend_operation_advanced.
    fn is_advanced(self) -> bool {
        self.color_op.as_raw() >= 1000148000
    }

    fn to_vk(self) -> vk::ColorBlendEquationEXT {
        vk::ColorBlendEquationEXT {
            src_color_blend_factor: self.src_color,
            dst_color_blend_factor: self.dst_color,
            color_blend_op: self.color_op,
            src_alpha_blend_factor: self.src_alpha,
            dst_alpha_blend_factor: self.dst_alpha,
            alpha_blend_op: self.alpha_op,
        }
    }
}

/// The equation that picks the old colour of the attachment.
fn pick_old_color() -> ColorBlendEq {
    ColorBlendEq::new(
        vk::BlendFactor::ZERO,
        vk::BlendFactor::ONE,
        vk::BlendOp::ADD,
        vk::BlendFactor::ZERO,
        vk::BlendFactor::ONE,
        vk::BlendOp::ADD,
    )
}

/// The equation that picks the colour of the mesh.
fn pick_new_color() -> ColorBlendEq {
    ColorBlendEq::new(
        vk::BlendFactor::ONE,
        vk::BlendFactor::ZERO,
        vk::BlendOp::ADD,
        vk::BlendFactor::ONE,
        vk::BlendFactor::ZERO,
        vk::BlendOp::ADD,
    )
}

#[derive(Clone)]
struct Config {
    ordering: SequenceOrdering,
    cull_mode: Pair<vk::CullModeFlags>,
    front_face: Pair<vk::FrontFace>,
    rasterizer_discard: Pair<bool>,
    color_blend_enable: Pair<bool>,
    color_blend_equation: Pair<ColorBlendEq>,
    logic_op: Pair<vk::LogicOp>,
    logic_op_enable: Pair<bool>,
    color_write_mask: Pair<vk::ColorComponentFlags>,
    depth_test_enable: Pair<bool>,
    depth_write_enable: Pair<bool>,
    depth_compare_op: Pair<vk::CompareOp>,
    depth_bounds_test_enable: Pair<bool>,
    depth_bounds: Pair<(f32, f32)>,
    line_width: Pair<f32>,
    stencil_test_enable: Pair<bool>,
    stencil_ops: Pair<Vec<StencilOpParams>>,
    reference_stencil: u32,
    clear_stencil: u32,
    expected_stencil: u32,
    topology: Pair<vk::PrimitiveTopology>,
    force_geometry_shader: bool,
    use_mesh_shaders: bool,
    null_static_color_blend_attachment_pointer: bool,
    primitive_restart_enable: Pair<bool>,
    line_strips: bool,
    reference_center_strip: Option<([f32; 4], [f32; 4])>,
    rasterization_samples: Pair<vk::SampleCountFlags>,
    sample_mask: Pair<Vec<u32>>,
    alpha_to_coverage: Pair<bool>,
    alpha_to_one: Pair<bool>,
    blend_constants: Pair<[f32; 4]>,
    color_write_enable: Pair<bool>,
    use_color_write_enable: bool,
    patch_control_points: Pair<u32>,
    tess_domain_origin: Pair<vk::TessellationDomainOrigin>,
    provoking_vertex: Pair<Option<bool>>,
    /// The provoking vertex the vertex shader is written for (`ProvokingVertexWithPadding`): true for the last vertex.
    provoking_shader_last: Option<bool>,
    negative_one_to_one: Pair<Option<bool>>,
    depth_clip_enable: Pair<Option<bool>>,
    depth_clamp_enable: Pair<bool>,
    polygon_mode: Pair<vk::PolygonMode>,
    oversized_triangle: bool,
    off_center_triangle: bool,
    vertex_gen: Pair<VertexGen>,
    stride: Pair<u32>,
    instance_stride: Pair<u32>,
    instance_count: u32,
    vertex_data_offset: u64,
    vertex_data_extra_bytes: u64,
    reference_horizontal_split: bool,
    single_vertex: bool,
    repr_frag_test: bool,
    repr_frag_test_enable: Pair<bool>,
    force_atomic_counters: bool,
    sample_shading_enable: bool,
    shading_rate_image: bool,
    shading_rate_image_enable: Pair<bool>,
    viewport_w_scaling: bool,
    viewport_w_scaling_enable: Pair<bool>,
    coverage_to_color_enable: Pair<bool>,
    dual_src_blend: bool,
    viewport_swizzle: bool,
    viewport_swizzles: Pair<Vec<vk::ViewportSwizzleNV>>,
    single_vertex_draw_count: u32,
    sample_locations_enable: Pair<bool>,
    provide_sample_locations_state: bool,
    sample_locations: [f32; 2],
    favor_static_null_pointers: bool,
    force_unorm_color: bool,
    dynamic_sample_mask_count: Option<vk::SampleCountFlags>,
    reference_border_colors: Option<([f32; 4], [f32; 4], [f32; 4])>,
    requires_maintenance11: bool,
    requires_depth_clamp_zero_one: bool,
    depth_bias_repr_info: Option<(vk::DepthBiasRepresentationEXT, bool)>,
    extra_depth_threshold: f32,
    needs_float_depth: bool,
    line_stipple_enable: Pair<bool>,
    line_stipple_params: Pair<Option<(u32, u16)>>,
    vertical_stripes_width: Option<i32>,
    line_raster_mode: vk::LineRasterizationMode,
    line_raster_preference: Pair<Option<vk::LineRasterizationMode>>,
    oblique_line: bool,
    verify_corner: Option<bool>,
    off_center_proportion: [f32; 2],
    reference_top_left_border: bool,
    conservative_mode: Pair<vk::ConservativeRasterizationModeEXT>,
    extra_overestimation: Pair<f32>,
    max_primitive_overestimation_size: Option<f32>,
    depth_bias_enable: Pair<bool>,
    /// `DepthBiasParams`: the constant factor and the clamp.
    depth_bias: Pair<(f32, f32)>,
    viewports: Pair<Vec<vk::Viewport>>,
    scissors: Pair<Vec<vk::Rect2D>>,
    swapped_values: bool,
    clear_depth: f32,
    expected_depth: f32,
    reference_color: [f32; 4],
    /// `MeshParams`: the colour and the depth of each mesh drawn in a framebuffer.
    meshes: Vec<Mesh>,
    clear_color: [f32; 4],
}

impl Config {
    fn new(ordering: SequenceOrdering) -> Self {
        Self {
            ordering,
            cull_mode: Pair::fixed(vk::CullModeFlags::NONE),
            front_face: Pair::fixed(vk::FrontFace::COUNTER_CLOCKWISE),
            rasterizer_discard: Pair::fixed(false),
            color_blend_enable: Pair::fixed(false),
            color_blend_equation: Pair::fixed(pick_new_color()),
            logic_op: Pair::fixed(vk::LogicOp::COPY),
            logic_op_enable: Pair::fixed(false),
            color_write_mask: Pair::fixed(vk::ColorComponentFlags::all()),
            depth_test_enable: Pair::fixed(false),
            depth_write_enable: Pair::fixed(false),
            depth_compare_op: Pair::fixed(vk::CompareOp::NEVER),
            depth_bounds_test_enable: Pair::fixed(false),
            depth_bounds: Pair::fixed((0.0, 1.0)),
            line_width: Pair::fixed(1.0),
            stencil_test_enable: Pair::fixed(false),
            stencil_ops: Pair::fixed(vec![DEFAULT_STENCIL_OP_PARAMS]),
            reference_stencil: 0,
            clear_stencil: 0,
            expected_stencil: 0,
            topology: Pair::fixed(vk::PrimitiveTopology::TRIANGLE_STRIP),
            force_geometry_shader: false,
            use_mesh_shaders: false,
            null_static_color_blend_attachment_pointer: false,
            primitive_restart_enable: Pair::fixed(false),
            line_strips: false,
            reference_center_strip: None,
            rasterization_samples: Pair::fixed(vk::SampleCountFlags::_1),
            sample_mask: Pair::fixed(Vec::new()),
            alpha_to_coverage: Pair::fixed(false),
            alpha_to_one: Pair::fixed(false),
            blend_constants: Pair::fixed([0.0; 4]),
            color_write_enable: Pair::fixed(true),
            use_color_write_enable: false,
            patch_control_points: Pair::fixed(1),
            tess_domain_origin: Pair::fixed(vk::TessellationDomainOrigin::UPPER_LEFT),
            provoking_vertex: Pair::fixed(None),
            provoking_shader_last: None,
            negative_one_to_one: Pair::fixed(None),
            depth_clip_enable: Pair::fixed(None),
            depth_clamp_enable: Pair::fixed(false),
            polygon_mode: Pair::fixed(vk::PolygonMode::FILL),
            oversized_triangle: false,
            off_center_triangle: false,
            vertex_gen: Pair::fixed(VertexGen::Padding),
            stride: Pair::fixed(16),
            instance_stride: Pair::fixed(16),
            instance_count: 1,
            vertex_data_offset: 0,
            vertex_data_extra_bytes: 0,
            reference_horizontal_split: false,
            single_vertex: false,
            repr_frag_test: false,
            repr_frag_test_enable: Pair::fixed(false),
            force_atomic_counters: false,
            sample_shading_enable: false,
            shading_rate_image: false,
            shading_rate_image_enable: Pair::fixed(false),
            viewport_w_scaling: false,
            viewport_w_scaling_enable: Pair::fixed(false),
            coverage_to_color_enable: Pair::fixed(false),
            dual_src_blend: false,
            viewport_swizzle: false,
            viewport_swizzles: Pair::fixed(Vec::new()),
            single_vertex_draw_count: 0,
            sample_locations_enable: Pair::fixed(false),
            provide_sample_locations_state: true,
            sample_locations: [0.5, 0.5],
            favor_static_null_pointers: false,
            force_unorm_color: false,
            dynamic_sample_mask_count: None,
            reference_border_colors: None,
            requires_maintenance11: false,
            requires_depth_clamp_zero_one: false,
            depth_bias_repr_info: None,
            extra_depth_threshold: 0.0,
            needs_float_depth: false,
            line_stipple_enable: Pair::fixed(false),
            line_stipple_params: Pair::fixed(None),
            vertical_stripes_width: None,
            line_raster_mode: vk::LineRasterizationMode::DEFAULT,
            line_raster_preference: Pair::fixed(None),
            oblique_line: false,
            verify_corner: None,
            off_center_proportion: [0.0, 0.0],
            reference_top_left_border: false,
            conservative_mode: Pair::fixed(vk::ConservativeRasterizationModeEXT::DISABLED),
            extra_overestimation: Pair::fixed(0.0),
            max_primitive_overestimation_size: None,
            depth_bias_enable: Pair::fixed(false),
            depth_bias: Pair::fixed((0.0, 0.0)),
            viewports: Pair::fixed(vec![make_viewport(FRAMEBUFFER_SIZE as f32, FRAMEBUFFER_SIZE as f32)]),
            scissors: Pair::fixed(vec![make_rect_2d(0, 0, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE)]),
            swapped_values: false,
            clear_depth: 1.0,
            expected_depth: 1.0,
            reference_color: TRIANGLE_COLOR,
            meshes: vec![Mesh::new(TRIANGLE_COLOR, 0.0)],
            clear_color: CLEAR_COLOR,
        }
    }

    /// `testLogicOp` or `testLogicOpEnable`: the logic op needs an integer colour attachment.
    fn uint_color(&self) -> bool {
        !self.force_unorm_color
            && (self.logic_op.dynamic_value.is_some()
                || self.logic_op_enable.dynamic_value.is_some()
                || self.uses_coverage_to_color())
    }

    /// `useFragShaderAtomics`
    fn uses_frag_atomics(&self) -> bool {
        self.repr_frag_test || self.force_atomic_counters
    }

    fn uses_coverage_to_color(&self) -> bool {
        self.coverage_to_color_enable.static_value || self.coverage_to_color_enable.dynamic_value.is_some()
    }

    fn color_format(&self) -> vk::Format {
        if self.uses_coverage_to_color() {
            vk::Format::R32_UINT
        } else if self.uint_color() {
            vk::Format::R8G8B8A8_UINT
        } else {
            COLOR_FORMAT
        }
    }

    /// `useStaticPipeline`
    fn uses_static_pipeline(&self) -> bool {
        self.bind_static_first() || self.is_reversed() || self.ordering == SequenceOrdering::ThreeDrawsDynamic
    }

    /// `isReversed`: the static pipeline holds the right values.
    fn is_reversed(&self) -> bool {
        matches!(
            self.ordering,
            SequenceOrdering::BeforeGoodStatic | SequenceOrdering::TwoDrawsStatic
        )
    }

    fn bind_static_first(&self) -> bool {
        matches!(
            self.ordering,
            SequenceOrdering::BetweenPipelines | SequenceOrdering::AfterPipelines | SequenceOrdering::TwoDrawsDynamic
        )
    }

    fn num_iterations(&self) -> usize {
        match self.ordering {
            SequenceOrdering::ThreeDrawsDynamic => 3,
            SequenceOrdering::TwoDrawsDynamic | SequenceOrdering::TwoDrawsStatic => 2,
            _ => 1,
        }
    }

    fn swap_values(&mut self) {
        self.cull_mode.swap_values();
        self.front_face.swap_values();
        self.rasterizer_discard.swap_values();
        self.color_blend_enable.swap_values();
        self.color_blend_equation.swap_values();
        self.logic_op.swap_values();
        self.logic_op_enable.swap_values();
        self.color_write_mask.swap_values();
        self.depth_test_enable.swap_values();
        self.depth_write_enable.swap_values();
        self.depth_compare_op.swap_values();
        self.depth_bounds_test_enable.swap_values();
        self.stencil_test_enable.swap_values();
        self.stencil_ops.swap_values();
        self.topology.swap_values();
        self.primitive_restart_enable.swap_values();
        self.rasterization_samples.swap_values();
        self.sample_mask.swap_values();
        self.alpha_to_coverage.swap_values();
        self.alpha_to_one.swap_values();
        self.blend_constants.swap_values();
        self.color_write_enable.swap_values();
        self.patch_control_points.swap_values();
        self.tess_domain_origin.swap_values();
        self.provoking_vertex.swap_values();
        self.negative_one_to_one.swap_values();
        self.depth_clip_enable.swap_values();
        self.conservative_mode.swap_values();
        self.line_stipple_enable.swap_values();
        self.line_stipple_params.swap_values();
        self.line_raster_preference.swap_values();
        self.extra_overestimation.swap_values();
        self.depth_clamp_enable.swap_values();
        self.polygon_mode.swap_values();
        self.depth_bias_enable.swap_values();
        self.depth_bias.swap_values();
        self.depth_bounds.swap_values();
        self.vertex_gen.swap_values();
        self.repr_frag_test_enable.swap_values();
        self.shading_rate_image_enable.swap_values();
        self.viewport_w_scaling_enable.swap_values();
        self.coverage_to_color_enable.swap_values();
        self.viewport_swizzles.swap_values();
        self.stride.swap_values();
        self.instance_stride.swap_values();
        self.sample_locations_enable.swap_values();
        self.line_width.swap_values();
        self.viewports.swap_values();
        self.scissors.swap_values();
        self.swapped_values = !self.swapped_values;
    }

    /// `getActiveViewportVec`
    fn active_viewports(&self) -> &[vk::Viewport] {
        match &self.viewports.dynamic_value {
            Some(dynamic) if !self.swapped_values => dynamic,
            _ => &self.viewports.static_value,
        }
    }

    /// `isMultiViewport`: the draws then go through a geometry shader choosing the viewport.
    fn is_multi_viewport(&self) -> bool {
        self.active_viewports().len() > 1
    }

    /// `getActiveSampleCount`
    fn active_sample_count(&self) -> vk::SampleCountFlags {
        match self.rasterization_samples.dynamic_value {
            Some(dynamic) if !self.swapped_values => dynamic,
            _ => self.rasterization_samples.static_value,
        }
    }

    /// `kUseResolveAtt` and the multisampled depth/stencil: the colour is resolved and the depth and stencil are not checked.
    fn is_multisample(&self) -> bool {
        self.active_sample_count() != vk::SampleCountFlags::_1
    }

    /// `getActiveNegativeOneToOneValue`
    fn active_negative_one_to_one(&self) -> bool {
        let active = match self.negative_one_to_one.dynamic_value {
            Some(dynamic) if !self.swapped_values => dynamic,
            _ => self.negative_one_to_one.static_value,
        };
        active.unwrap_or(false)
    }

    /// `getActiveDepthClipEnable`: depth clipping is enabled unless a state says otherwise.
    fn active_depth_clip_enable(&self) -> bool {
        let active = match self.depth_clip_enable.dynamic_value {
            Some(dynamic) if !self.swapped_values => dynamic,
            _ => self.depth_clip_enable.static_value,
        };
        active.unwrap_or(true)
    }

    /// `needsTessellation`: patches, a dynamic patch control point count or a dynamic domain origin.
    fn needs_tessellation(&self) -> bool {
        self.topology.static_value == vk::PrimitiveTopology::PATCH_LIST
            || self.patch_control_points.dynamic_value.is_some()
            || self.tess_domain_origin.dynamic_value.is_some()
    }

    /// `lineStippleSupportRequired`
    fn line_stipple_support_required(&self) -> bool {
        self.line_stipple_enable.static_value || self.line_stipple_enable.dynamic_value == Some(true)
    }

    /// `lineRasterStruct`
    fn uses_line_raster_struct(&self) -> bool {
        self.line_stipple_enable.dynamic_value.is_some()
            || self.line_stipple_enable.static_value
            || self.line_stipple_params.static_value.is_some()
            || self.line_raster_preference.static_value.is_some()
    }

    /// `conservativeRasterStruct`
    fn uses_conservative_struct(&self) -> bool {
        self.conservative_mode.dynamic_value.is_some()
            || self.conservative_mode.static_value != vk::ConservativeRasterizationModeEXT::DISABLED
            || self.extra_overestimation.dynamic_value.is_some()
            || self.extra_overestimation.static_value >= 0.0 && self.max_primitive_overestimation_size.is_some()
    }

    /// `needsGeometryShader`
    fn needs_geometry_shader(&self) -> bool {
        !self.use_mesh_shaders && (self.is_multi_viewport() || self.force_geometry_shader)
    }

    /// `needsIndexBuffer`
    fn needs_index_buffer(&self) -> bool {
        self.primitive_restart_enable.dynamic_value.is_some()
    }

    fn push_constant_stages(&self) -> vk::ShaderStageFlags {
        if self.use_mesh_shaders {
            return vk::ShaderStageFlags::MESH_EXT | vk::ShaderStageFlags::FRAGMENT;
        }
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        if self.is_multi_viewport() {
            stages | vk::ShaderStageFlags::GEOMETRY
        } else {
            stages
        }
    }

    fn dynamic_states(&self) -> Vec<vk::DynamicState> {
        let mut states = Vec::new();
        if self.cull_mode.dynamic_value.is_some() {
            states.push(vk::DynamicState::CULL_MODE);
        }
        if self.front_face.dynamic_value.is_some() {
            states.push(vk::DynamicState::FRONT_FACE);
        }
        if self.rasterizer_discard.dynamic_value.is_some() {
            states.push(vk::DynamicState::RASTERIZER_DISCARD_ENABLE);
        }
        if self.color_blend_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::COLOR_BLEND_ENABLE_EXT);
        }
        if self.color_blend_equation.dynamic_value.is_some() {
            states.push(if self.color_blend_equation.static_value.is_advanced() {
                vk::DynamicState::COLOR_BLEND_ADVANCED_EXT
            } else {
                vk::DynamicState::COLOR_BLEND_EQUATION_EXT
            });
        }
        if self.logic_op.dynamic_value.is_some() {
            states.push(vk::DynamicState::LOGIC_OP_EXT);
        }
        if self.logic_op_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::LOGIC_OP_ENABLE_EXT);
        }
        if self.color_write_mask.dynamic_value.is_some() {
            states.push(vk::DynamicState::COLOR_WRITE_MASK_EXT);
        }
        if self.depth_test_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_TEST_ENABLE);
        }
        if self.depth_write_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_WRITE_ENABLE);
        }
        if self.depth_compare_op.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_COMPARE_OP);
        }
        if self.depth_bounds_test_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_BOUNDS_TEST_ENABLE);
        }
        if self.stencil_test_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::STENCIL_TEST_ENABLE);
        }
        if self.stencil_ops.dynamic_value.is_some() {
            states.push(vk::DynamicState::STENCIL_OP);
        }
        if self.topology.dynamic_value.is_some() {
            states.push(vk::DynamicState::PRIMITIVE_TOPOLOGY);
        }
        if self.primitive_restart_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::PRIMITIVE_RESTART_ENABLE);
        }
        if self.rasterization_samples.dynamic_value.is_some() {
            states.push(vk::DynamicState::RASTERIZATION_SAMPLES_EXT);
        }
        if self.sample_mask.dynamic_value.is_some() {
            states.push(vk::DynamicState::SAMPLE_MASK_EXT);
        }
        if self.alpha_to_coverage.dynamic_value.is_some() {
            states.push(vk::DynamicState::ALPHA_TO_COVERAGE_ENABLE_EXT);
        }
        if self.alpha_to_one.dynamic_value.is_some() {
            states.push(vk::DynamicState::ALPHA_TO_ONE_ENABLE_EXT);
        }
        if self.blend_constants.dynamic_value.is_some() {
            states.push(vk::DynamicState::BLEND_CONSTANTS);
        }
        if self.color_write_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::COLOR_WRITE_ENABLE_EXT);
        }
        if self.patch_control_points.dynamic_value.is_some() {
            states.push(vk::DynamicState::PATCH_CONTROL_POINTS_EXT);
        }
        if self.tess_domain_origin.dynamic_value.is_some() {
            states.push(vk::DynamicState::TESSELLATION_DOMAIN_ORIGIN_EXT);
        }
        if self.provoking_vertex.dynamic_value.is_some() {
            states.push(vk::DynamicState::PROVOKING_VERTEX_MODE_EXT);
        }
        if self.negative_one_to_one.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_CLIP_NEGATIVE_ONE_TO_ONE_EXT);
        }
        if self.depth_clip_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_CLIP_ENABLE_EXT);
        }
        if self.line_stipple_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::LINE_STIPPLE_ENABLE_EXT);
        }
        if matches!(self.line_raster_preference.dynamic_value, Some(Some(_))) {
            states.push(vk::DynamicState::LINE_RASTERIZATION_MODE_EXT);
        }
        if matches!(self.line_stipple_params.dynamic_value, Some(Some(_))) {
            states.push(vk::DynamicState::LINE_STIPPLE);
        }
        if self.conservative_mode.dynamic_value.is_some() {
            states.push(vk::DynamicState::CONSERVATIVE_RASTERIZATION_MODE_EXT);
        }
        if self.extra_overestimation.dynamic_value.is_some() {
            states.push(vk::DynamicState::EXTRA_PRIMITIVE_OVERESTIMATION_SIZE_EXT);
        }
        if self.depth_clamp_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_CLAMP_ENABLE_EXT);
        }
        if self.polygon_mode.dynamic_value.is_some() {
            states.push(vk::DynamicState::POLYGON_MODE_EXT);
        }
        if self.depth_bias_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_BIAS_ENABLE);
        }
        if self.depth_bias.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_BIAS);
        }
        if self.sample_locations_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::SAMPLE_LOCATIONS_ENABLE_EXT);
        }
        if self.coverage_to_color_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::COVERAGE_TO_COLOR_ENABLE_NV);
        }
        if self.viewport_w_scaling_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::VIEWPORT_W_SCALING_ENABLE_NV);
        }
        if self.shading_rate_image_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::SHADING_RATE_IMAGE_ENABLE_NV);
        }
        if self.repr_frag_test_enable.dynamic_value.is_some() {
            states.push(vk::DynamicState::REPRESENTATIVE_FRAGMENT_TEST_ENABLE_NV);
        }
        if self.viewport_swizzles.dynamic_value.is_some() {
            states.push(vk::DynamicState::VIEWPORT_SWIZZLE_NV);
        }
        if self.vertex_gen.dynamic_value.is_some() {
            states.push(vk::DynamicState::VERTEX_INPUT_EXT);
        }
        if self.stride.dynamic_value.is_some() || self.instance_stride.dynamic_value.is_some() {
            states.push(vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE);
        }
        if self.depth_bounds.dynamic_value.is_some() {
            states.push(vk::DynamicState::DEPTH_BOUNDS);
        }
        if self.line_width.dynamic_value.is_some() {
            states.push(vk::DynamicState::LINE_WIDTH);
        }
        if self.viewports.dynamic_value.is_some() {
            states.push(vk::DynamicState::VIEWPORT_WITH_COUNT);
        }
        if self.scissors.dynamic_value.is_some() {
            states.push(vk::DynamicState::SCISSOR_WITH_COUNT);
        }
        states
    }
}

/// `setDynamicStates`
fn set_dynamic_states(config: &Config, device: &Device, cmd: vk::CommandBuffer) {
    unsafe {
        if let Some(cull_mode) = config.cull_mode.dynamic_value {
            device.cmd_set_cull_mode_ext(cmd, cull_mode);
        }
        if let Some(front_face) = config.front_face.dynamic_value {
            device.cmd_set_front_face_ext(cmd, front_face);
        }
        if let Some(discard) = config.rasterizer_discard.dynamic_value {
            device.cmd_set_rasterizer_discard_enable_ext(cmd, discard);
        }
        if let Some(enable) = config.color_blend_enable.dynamic_value {
            device.cmd_set_color_blend_enable_ext(cmd, 0, &[vk::Bool32::from(enable)]);
        }
        if let Some(equation) = config.color_blend_equation.dynamic_value {
            if config.color_blend_equation.static_value.is_advanced() {
                let advanced = vk::ColorBlendAdvancedEXT {
                    advanced_blend_op: equation.color_op,
                    src_premultiplied: vk::TRUE,
                    dst_premultiplied: vk::TRUE,
                    blend_overlap: vk::BlendOverlapEXT::UNCORRELATED,
                    clamp_results: vk::FALSE,
                };
                device.cmd_set_color_blend_advanced_ext(cmd, 0, &[advanced]);
            } else {
                device.cmd_set_color_blend_equation_ext(cmd, 0, &[equation.to_vk()]);
            }
        }
        if let Some(logic_op) = config.logic_op.dynamic_value {
            device.cmd_set_logic_op_ext(cmd, logic_op);
        }
        if let Some(enable) = config.logic_op_enable.dynamic_value {
            device.cmd_set_logic_op_enable_ext(cmd, enable);
        }
        if let Some(mask) = config.color_write_mask.dynamic_value {
            device.cmd_set_color_write_mask_ext(cmd, 0, &[mask]);
        }
        if let Some(enable) = config.depth_test_enable.dynamic_value {
            device.cmd_set_depth_test_enable_ext(cmd, enable);
        }
        if let Some(enable) = config.depth_write_enable.dynamic_value {
            device.cmd_set_depth_write_enable_ext(cmd, enable);
        }
        if let Some(compare_op) = config.depth_compare_op.dynamic_value {
            device.cmd_set_depth_compare_op_ext(cmd, compare_op);
        }
        if let Some(enable) = config.depth_bounds_test_enable.dynamic_value {
            device.cmd_set_depth_bounds_test_enable_ext(cmd, enable);
        }
        if let Some(enable) = config.stencil_test_enable.dynamic_value {
            device.cmd_set_stencil_test_enable_ext(cmd, enable);
        }
        if let Some(ops) = &config.stencil_ops.dynamic_value {
            for op in ops {
                device.cmd_set_stencil_op_ext(
                    cmd,
                    op.face_mask,
                    op.fail_op,
                    op.pass_op,
                    op.depth_fail_op,
                    op.compare_op,
                );
            }
        }
        if let Some(topology) = config.topology.dynamic_value {
            device.cmd_set_primitive_topology_ext(cmd, topology);
        }
        if let Some(enable) = config.primitive_restart_enable.dynamic_value {
            device.cmd_set_primitive_restart_enable_ext(cmd, enable);
        }
        if let Some(samples) = config.rasterization_samples.dynamic_value {
            device.cmd_set_rasterization_samples_ext(cmd, samples);
        }
        if let Some(sample_mask) = &config.sample_mask.dynamic_value {
            let samples = config
                .dynamic_sample_mask_count
                .unwrap_or_else(|| config.active_sample_count());
            if sample_mask.is_empty() {
                // A null mask: every sample bit is set.
                (device.commands().cmd_set_sample_mask_ext)(cmd, samples, std::ptr::null());
            } else {
                device.cmd_set_sample_mask_ext(cmd, samples, sample_mask.first());
            }
        }
        if let Some(enable) = config.alpha_to_coverage.dynamic_value {
            device.cmd_set_alpha_to_coverage_enable_ext(cmd, enable);
        }
        if let Some(enable) = config.alpha_to_one.dynamic_value {
            device.cmd_set_alpha_to_one_enable_ext(cmd, enable);
        }
        if let Some(blend_constants) = config.blend_constants.dynamic_value {
            device.cmd_set_blend_constants(cmd, blend_constants);
        }
        if let Some(enable) = config.color_write_enable.dynamic_value {
            device.cmd_set_color_write_enable_ext(cmd, &[vk::Bool32::from(enable)]);
        }
        if let Some(points) = config.patch_control_points.dynamic_value {
            device.cmd_set_patch_control_points_ext(cmd, points);
        }
        if let Some(origin) = config.tess_domain_origin.dynamic_value {
            device.cmd_set_tessellation_domain_origin_ext(cmd, origin);
        }
        if let Some(Some(last)) = config.provoking_vertex.dynamic_value {
            let mode = if last {
                vk::ProvokingVertexModeEXT::LAST_VERTEX
            } else {
                vk::ProvokingVertexModeEXT::FIRST_VERTEX
            };
            device.cmd_set_provoking_vertex_mode_ext(cmd, mode);
        }
        if let Some(Some(enable)) = config.negative_one_to_one.dynamic_value {
            device.cmd_set_depth_clip_negative_one_to_one_ext(cmd, enable);
        }
        if let Some(Some(enable)) = config.depth_clip_enable.dynamic_value {
            device.cmd_set_depth_clip_enable_ext(cmd, enable);
        }
        if let Some(enable) = config.line_stipple_enable.dynamic_value {
            device.cmd_set_line_stipple_enable_ext(cmd, enable);
        }
        if let Some(Some(mode)) = config.line_raster_preference.dynamic_value {
            device.cmd_set_line_rasterization_mode_ext(cmd, mode);
        }
        if let Some(Some((factor, pattern))) = config.line_stipple_params.dynamic_value {
            device.cmd_set_line_stipple_ext(cmd, factor, pattern);
        }
        if let Some(mode) = config.conservative_mode.dynamic_value {
            device.cmd_set_conservative_rasterization_mode_ext(cmd, mode);
        }
        if let Some(size) = config.extra_overestimation.dynamic_value {
            device.cmd_set_extra_primitive_overestimation_size_ext(cmd, size);
        }
        if let Some(enable) = config.depth_clamp_enable.dynamic_value {
            device.cmd_set_depth_clamp_enable_ext(cmd, enable);
        }
        if let Some(polygon_mode) = config.polygon_mode.dynamic_value {
            device.cmd_set_polygon_mode_ext(cmd, polygon_mode);
        }
        if let Some(enable) = config.depth_bias_enable.dynamic_value {
            device.cmd_set_depth_bias_enable_ext(cmd, enable);
        }
        if let Some(enable) = config.coverage_to_color_enable.dynamic_value {
            device.cmd_set_coverage_to_color_enable_nv(cmd, enable);
        }
        if let Some(enable) = config.viewport_w_scaling_enable.dynamic_value {
            device.cmd_set_viewport_w_scaling_enable_nv(cmd, enable);
        }
        if let Some(enable) = config.shading_rate_image_enable.dynamic_value {
            device.cmd_set_shading_rate_image_enable_nv(cmd, enable);
        }
        if let Some(enable) = config.repr_frag_test_enable.dynamic_value {
            device.cmd_set_representative_fragment_test_enable_nv(cmd, enable);
        }
        if let Some(swizzles) = &config.viewport_swizzles.dynamic_value {
            device.cmd_set_viewport_swizzle_nv(cmd, 0, swizzles);
        }
        if let Some(generator) = config.vertex_gen.dynamic_value {
            let bindings: Vec<vk::VertexInputBindingDescription2EXT> = generator
                .bindings([config.stride.static_value, config.instance_stride.static_value])
                .into_iter()
                .map(|(binding, stride, input_rate)| {
                    vk::VertexInputBindingDescription2EXT::builder()
                        .binding(binding)
                        .stride(stride)
                        .input_rate(input_rate)
                        .divisor(1)
                        .build()
                })
                .collect();
            let attributes: Vec<vk::VertexInputAttributeDescription2EXT> = generator
                .attributes()
                .into_iter()
                .map(|(location, binding, format, offset)| {
                    vk::VertexInputAttributeDescription2EXT::builder()
                        .location(location)
                        .binding(binding)
                        .format(format)
                        .offset(offset)
                        .build()
                })
                .collect();
            device.cmd_set_vertex_input_ext(cmd, &bindings, &attributes);
        }
        if let Some(enable) = config.sample_locations_enable.dynamic_value {
            device.cmd_set_sample_locations_enable_ext(cmd, enable);
        }
        if let Some((min_depth, max_depth)) = config.depth_bounds.dynamic_value {
            device.cmd_set_depth_bounds(cmd, min_depth, max_depth);
        }
        if let Some(width) = config.line_width.dynamic_value {
            device.cmd_set_line_width(cmd, width);
        }
        if let Some((constant_factor, clamp)) = config.depth_bias.dynamic_value {
            if let (Some((representation, exact)), false) = (config.depth_bias_repr_info, config.is_reversed()) {
                let mut repr_info = vk::DepthBiasRepresentationInfoEXT::builder()
                    .depth_bias_representation(representation)
                    .depth_bias_exact(exact);
                let bias_info = vk::DepthBiasInfoEXT::builder()
                    .depth_bias_constant_factor(constant_factor)
                    .depth_bias_clamp(clamp)
                    .depth_bias_slope_factor(0.0)
                    .push_next(&mut repr_info);
                device.cmd_set_depth_bias2_ext(cmd, &bias_info);
            } else {
                device.cmd_set_depth_bias(cmd, constant_factor, clamp, 0.0);
            }
        }
        if let Some(viewports) = &config.viewports.dynamic_value {
            device.cmd_set_viewport_with_count_ext(cmd, viewports);
        }
        if let Some(scissors) = &config.scissors.dynamic_value {
            device.cmd_set_scissor_with_count_ext(cmd, scissors);
        }
    }
}

/// The config with every state the shader objects need set at the static value (a pipeline has them baked in): the values of
/// `static_value` as the dynamic ones. `dynamic_variant` is the pipeline that has the config's dynamic states, whose own
/// dynamic values are set by the test later, and whose viewport and scissor counts follow the final ones.
fn static_as_dynamic(config: &Config, dynamic_variant: bool) -> Config {
    let mut c = config.clone();
    macro_rules! set_static {
        ($($field:ident),* $(,)?) => {
            $( c.$field.dynamic_value = Some(config.$field.static_value.clone()); )*
        };
    }
    macro_rules! clear {
        ($($field:ident),* $(,)?) => {
            $( c.$field.dynamic_value = None; )*
        };
    }
    set_static!(
        cull_mode,
        front_face,
        rasterizer_discard,
        color_blend_enable,
        color_blend_equation,
        logic_op,
        logic_op_enable,
        color_write_mask,
        depth_test_enable,
        depth_write_enable,
        depth_compare_op,
        depth_bounds_test_enable,
        depth_bounds,
        line_width,
        stencil_test_enable,
        stencil_ops,
        topology,
        primitive_restart_enable,
        rasterization_samples,
        sample_mask,
        alpha_to_coverage,
        alpha_to_one,
        blend_constants,
        depth_clamp_enable,
        polygon_mode,
        depth_bias_enable,
        depth_bias,
        vertex_gen,
        provoking_vertex,
        negative_one_to_one,
        depth_clip_enable,
    );
    if config.use_color_write_enable {
        set_static!(color_write_enable);
    } else {
        clear!(color_write_enable);
    }
    if config.needs_tessellation() {
        set_static!(patch_control_points, tess_domain_origin);
    } else {
        clear!(patch_control_points, tess_domain_origin);
    }
    if config.uses_conservative_struct() {
        set_static!(conservative_mode, extra_overestimation);
    } else {
        clear!(conservative_mode, extra_overestimation);
    }
    if config.uses_line_raster_struct() {
        set_static!(line_stipple_enable, line_raster_preference, line_stipple_params);
    } else {
        clear!(line_stipple_enable, line_raster_preference, line_stipple_params);
    }
    if config.sample_locations_enable.static_value || config.sample_locations_enable.dynamic_value.is_some() {
        set_static!(sample_locations_enable);
    } else {
        clear!(sample_locations_enable);
    }
    if config.viewport_w_scaling {
        set_static!(viewport_w_scaling_enable);
    } else {
        clear!(viewport_w_scaling_enable);
    }
    if config.uses_coverage_to_color() {
        set_static!(coverage_to_color_enable);
    } else {
        clear!(coverage_to_color_enable);
    }
    if config.repr_frag_test {
        set_static!(repr_frag_test_enable);
    } else {
        clear!(repr_frag_test_enable);
    }
    if config.viewport_swizzle {
        set_static!(viewport_swizzles);
    } else {
        clear!(viewport_swizzles);
    }
    clear!(shading_rate_image_enable);

    let (final_viewports, final_scissors) = if dynamic_variant {
        (
            config
                .viewports
                .dynamic_value
                .as_ref()
                .map_or(config.viewports.static_value.len(), Vec::len),
            config
                .scissors
                .dynamic_value
                .as_ref()
                .map_or(config.scissors.static_value.len(), Vec::len),
        )
    } else {
        (config.viewports.static_value.len(), config.scissors.static_value.len())
    };
    let min_count = final_viewports.min(final_scissors);
    c.viewports.dynamic_value = if dynamic_variant && config.viewports.dynamic_value.is_some() {
        None
    } else {
        Some(config.viewports.static_value[..min_count].to_vec())
    };
    c.scissors.dynamic_value = if dynamic_variant && config.scissors.dynamic_value.is_some() {
        None
    } else {
        Some(config.scissors.static_value[..min_count].to_vec())
    };
    c
}

/// What a pipeline's create info says that `set_dynamic_states` has no command for: the stencil reference and masks, and the
/// sample locations.
fn set_extra_static_states(config: &Config, device: &Device, cmd: vk::CommandBuffer) {
    unsafe {
        device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, config.reference_stencil);
        device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xff);
        device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xff);
        if config.sample_locations_enable.static_value || config.sample_locations_enable.dynamic_value.is_some() {
            let sample_location_coords = vec![
                vk::SampleLocationEXT {
                    x: config.sample_locations[0],
                    y: config.sample_locations[1]
                };
                config.active_sample_count().bits() as usize
            ];
            let info = vk::SampleLocationsInfoEXT::builder()
                .sample_locations_per_pixel(config.active_sample_count())
                .sample_location_grid_size(vk::Extent2D { width: 1, height: 1 })
                .sample_locations(&sample_location_coords);
            device.cmd_set_sample_locations_ext(cmd, &info);
        }
    }
}

/// `vkCmdBeginRendering` for what the case's render pass and framebuffer held: the colour image (resolved into
/// `resolve_view` when multisampled) and the depth and stencil image.
#[allow(clippy::too_many_arguments)]
fn begin_rendering(
    device: &Device,
    cmd: vk::CommandBuffer,
    color_view: vk::ImageView,
    resolve_view: Option<vk::ImageView>,
    ds_view: vk::ImageView,
    color_clear: vk::ClearValue,
    ds_clear: vk::ClearValue,
    resolve_mode: vk::ResolveModeFlags,
) {
    let mut color = vk::RenderingAttachmentInfo::builder()
        .image_view(color_view)
        .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(if resolve_view.is_some() {
            vk::AttachmentStoreOp::DONT_CARE
        } else {
            vk::AttachmentStoreOp::STORE
        })
        .clear_value(color_clear);
    if let Some(resolve_view) = resolve_view {
        color = color
            .resolve_mode(resolve_mode)
            .resolve_image_view(resolve_view)
            .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    }
    let color_attachments = [color.build()];
    let depth_stencil = vk::RenderingAttachmentInfo::builder()
        .image_view(ds_view)
        .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(ds_clear)
        .build();
    let rendering_info = vk::RenderingInfo::builder()
        .render_area(make_rect_2d(0, 0, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE))
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments)
        .depth_attachment(&depth_stencil)
        .stencil_attachment(&depth_stencil);
    unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
}

/// `chooseDepthStencilFormat`
fn choose_depth_stencil_format(
    context: &Context<'_>,
    samples: vk::SampleCountFlags,
) -> Result<(vk::Format, f32), TestError> {
    let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    for (format, threshold) in DEPTH_STENCIL_FORMATS {
        let supported = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if supported.is_ok_and(|properties| properties.sample_counts.contains(samples)) {
            return Ok((format, threshold));
        }
    }
    Err(TestError::NotSupported(
        "No suitable depth/stencil format found".to_string(),
    ))
}

/// A render pass with a multisampled colour attachment resolved to a single sampled one, and a multisampled depth/stencil attachment.
fn make_multisample_render_pass(
    device: &Device,
    color_format: vk::Format,
    ds_format: vk::Format,
    samples: vk::SampleCountFlags,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: color_format,
            samples,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::DONT_CARE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        },
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: ds_format,
            samples,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::CLEAR,
            stencil_store_op: vk::AttachmentStoreOp::STORE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        },
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: color_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::DONT_CARE,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        },
    ];
    let color_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let resolve_reference = [vk::AttachmentReference {
        attachment: 2,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let ds_reference = vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_reference)
        .resolve_attachments(&resolve_reference)
        .depth_stencil_attachment(&ds_reference)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `selectLineRasterizationMode`; `DEFAULT` stands for upstream's `NONE`.
fn select_line_raster_mode(
    context: &Context<'_>,
    stipple_required: bool,
    preference: Option<vk::LineRasterizationMode>,
) -> vk::LineRasterizationMode {
    let mut features = vk::PhysicalDeviceLineRasterizationFeatures::default();
    {
        let mut chain = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut chain)
        };
    }
    let wants = |mode| preference.is_none_or(|preferred| preferred == mode);
    if wants(vk::LineRasterizationMode::RECTANGULAR)
        && features.rectangular_lines != vk::FALSE
        && (!stipple_required || features.stippled_rectangular_lines != vk::FALSE)
    {
        vk::LineRasterizationMode::RECTANGULAR
    } else if wants(vk::LineRasterizationMode::BRESENHAM)
        && features.bresenham_lines != vk::FALSE
        && (!stipple_required || features.stippled_bresenham_lines != vk::FALSE)
    {
        vk::LineRasterizationMode::BRESENHAM
    } else if wants(vk::LineRasterizationMode::RECTANGULAR_SMOOTH)
        && features.smooth_lines != vk::FALSE
        && (!stipple_required || features.stippled_smooth_lines != vk::FALSE)
    {
        vk::LineRasterizationMode::RECTANGULAR_SMOOTH
    } else {
        vk::LineRasterizationMode::DEFAULT
    }
}

struct ExtendedDynamicStateCase {
    name: &'static str,
    config: Config,
}

impl TestCase for ExtendedDynamicStateCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.config.use_mesh_shaders {
            check_task_mesh_shader_support_ext(context, false, true)?;
        }
        let mut features1 = vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT::default();
        let mut features3 = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
        {
            let mut chain = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut features1)
                .push_next(&mut features2)
                .push_next(&mut features3);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut chain)
            };
        }
        let config = &self.config;
        if (config.cull_mode.dynamic_value.is_some()
            || config.front_face.dynamic_value.is_some()
            || config.topology.dynamic_value.is_some()
            || config.depth_test_enable.dynamic_value.is_some()
            || config.depth_write_enable.dynamic_value.is_some()
            || config.depth_compare_op.dynamic_value.is_some()
            || config.depth_bounds_test_enable.dynamic_value.is_some()
            || config.stencil_test_enable.dynamic_value.is_some()
            || config.stencil_ops.dynamic_value.is_some()
            || config.viewports.dynamic_value.is_some()
            || config.scissors.dynamic_value.is_some())
            && features1.extended_dynamic_state == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "VK_EXT_extended_dynamic_state not supported".to_string(),
            ));
        }
        if (config.rasterizer_discard.dynamic_value.is_some()
            || config.depth_bias_enable.dynamic_value.is_some()
            || config.primitive_restart_enable.dynamic_value.is_some())
            && features2.extended_dynamic_state2 == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "VK_EXT_extended_dynamic_state2 not supported".to_string(),
            ));
        }
        if config.color_blend_enable.dynamic_value.is_some()
            && features3.extended_dynamic_state3_color_blend_enable == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "extendedDynamicState3ColorBlendEnable not supported".to_string(),
            ));
        }
        if config.rasterization_samples.dynamic_value.is_some()
            && features3.extended_dynamic_state3_rasterization_samples == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "extendedDynamicState3RasterizationSamples not supported".to_string(),
            ));
        }
        if config.sample_mask.dynamic_value.is_some() && features3.extended_dynamic_state3_sample_mask == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState3SampleMask not supported".to_string(),
            ));
        }
        if config.alpha_to_coverage.dynamic_value.is_some()
            && features3.extended_dynamic_state3_alpha_to_coverage_enable == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "extendedDynamicState3AlphaToCoverageEnable not supported".to_string(),
            ));
        }
        if (config.alpha_to_one.static_value || config.alpha_to_one.dynamic_value.is_some())
            && context.get_device_features().alpha_to_one == vk::FALSE
        {
            return Err(TestError::NotSupported("alphaToOne not supported".to_string()));
        }
        if config.alpha_to_one.dynamic_value.is_some()
            && features3.extended_dynamic_state3_alpha_to_one_enable == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "extendedDynamicState3AlphaToOneEnable not supported".to_string(),
            ));
        }
        if config.use_color_write_enable {
            context.require_device_functionality("VK_EXT_color_write_enable")?;
            let mut color_write = vk::PhysicalDeviceColorWriteEnableFeaturesEXT::default();
            {
                let mut chain = vk::PhysicalDeviceFeatures2::builder().push_next(&mut color_write);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut chain)
                };
            }
            if color_write.color_write_enable == vk::FALSE {
                return Err(TestError::NotSupported("colorWriteEnable not supported".to_string()));
            }
        }
        if config.logic_op.dynamic_value.is_some() && features2.extended_dynamic_state2_logic_op == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState2LogicOp is not supported".to_string(),
            ));
        }
        if config.logic_op_enable.dynamic_value.is_some()
            && features3.extended_dynamic_state3_logic_op_enable == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "extendedDynamicState3LogicOpEnable not supported".to_string(),
            ));
        }
        if config.color_write_mask.dynamic_value.is_some()
            && features3.extended_dynamic_state3_color_write_mask == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "extendedDynamicState3ColorWriteMask not supported".to_string(),
            ));
        }
        if config.uint_color() && context.get_device_features().logic_op == vk::FALSE {
            return Err(TestError::NotSupported("logicOp not supported".to_string()));
        }
        if config.color_blend_equation.static_value.is_advanced() {
            context.require_device_functionality("VK_EXT_blend_operation_advanced")?;
            if config.color_blend_equation.dynamic_value.is_some()
                && features3.extended_dynamic_state3_color_blend_advanced == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3ColorBlendAdvanced not supported".to_string(),
                ));
            }
        } else if config.color_blend_equation.dynamic_value.is_some()
            && features3.extended_dynamic_state3_color_blend_equation == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "extendedDynamicState3ColorBlendEquation not supported".to_string(),
            ));
        }
        if (config.depth_bounds_test_enable.static_value || config.depth_bounds_test_enable.dynamic_value.is_some())
            && context.get_device_features().depth_bounds == vk::FALSE
        {
            return Err(TestError::NotSupported("depthBounds not supported".to_string()));
        }
        if config.needs_tessellation() {
            if context.get_device_features().tessellation_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: tessellationShader".to_string(),
                ));
            }
            if config.patch_control_points.dynamic_value.is_some()
                && features2.extended_dynamic_state2_patch_control_points == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState2PatchControlPoints not supported".to_string(),
                ));
            }
            if config.tess_domain_origin.dynamic_value.is_some()
                && features3.extended_dynamic_state3_tessellation_domain_origin == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3TessellationDomainOrigin not supported".to_string(),
                ));
            }
        }
        if config.provoking_vertex.static_value.is_some() || config.provoking_vertex.dynamic_value.is_some() {
            context.require_device_functionality("VK_EXT_provoking_vertex")?;
            let mut provoking = vk::PhysicalDeviceProvokingVertexFeaturesEXT::default();
            {
                let mut chain = vk::PhysicalDeviceFeatures2::builder().push_next(&mut provoking);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut chain)
                };
            }
            if provoking.provoking_vertex_last == vk::FALSE {
                return Err(TestError::NotSupported("provokingVertexLast not supported".to_string()));
            }
            if config.provoking_vertex.dynamic_value.is_some()
                && features3.extended_dynamic_state3_provoking_vertex_mode == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3ProvokingVertexMode not supported".to_string(),
                ));
            }
        }
        if config.negative_one_to_one.static_value.is_some() || config.negative_one_to_one.dynamic_value.is_some() {
            context.require_device_functionality("VK_EXT_depth_clip_control")?;
            if config.negative_one_to_one.dynamic_value.is_some()
                && features3.extended_dynamic_state_3depth_clip_negative_one_to_one == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3DepthClipNegativeOneToOne not supported".to_string(),
                ));
            }
        }
        if let Some((representation, exact)) = config.depth_bias_repr_info {
            context.require_device_functionality("VK_EXT_depth_bias_control")?;
            let mut depth_bias_control = vk::PhysicalDeviceDepthBiasControlFeaturesEXT::default();
            {
                let mut chain = vk::PhysicalDeviceFeatures2::builder().push_next(&mut depth_bias_control);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut chain)
                };
            }
            if exact && depth_bias_control.depth_bias_exact == vk::FALSE {
                return Err(TestError::NotSupported("depthBiasExact not supported".to_string()));
            }
            if representation == vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORCE_UNORM
                && depth_bias_control.least_representable_value_force_unorm_representation == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "leastRepresentableValueForceUnormRepresentation not supported".to_string(),
                ));
            }
            if representation == vk::DepthBiasRepresentationEXT::FLOAT
                && depth_bias_control.float_representation == vk::FALSE
            {
                return Err(TestError::NotSupported("floatRepresentation not supported".to_string()));
            }
        }
        if config
            .line_width
            .dynamic_value
            .unwrap_or(config.line_width.static_value)
            != 1.0
        {
            if context.get_device_features().wide_lines == vk::FALSE {
                return Err(TestError::NotSupported("wideLines not supported".to_string()));
            }
        }
        if config.favor_static_null_pointers
            && config.primitive_restart_enable.dynamic_value.is_some()
            && config.topology.dynamic_value.is_some()
        {
            let mut eds3_properties = vk::PhysicalDeviceExtendedDynamicState3PropertiesEXT::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut eds3_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            if eds3_properties.dynamic_primitive_topology_unrestricted == vk::FALSE {
                return Err(TestError::NotSupported(
                    "dynamicPrimitiveTopologyUnrestricted not supported".to_string(),
                ));
            }
        }
        if config.sample_locations_enable.static_value || config.sample_locations_enable.dynamic_value.is_some() {
            context.require_device_functionality("VK_EXT_sample_locations")?;
            if config.sample_locations_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state3_sample_locations_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3SampleLocationsEnable not supported".to_string(),
                ));
            }
            let mut sample_location_properties = vk::PhysicalDeviceSampleLocationsPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut sample_location_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if !sample_location_properties
                .sample_location_sample_counts
                .contains(config.active_sample_count())
            {
                return Err(TestError::NotSupported(
                    "Sample count not supported for sample locations".to_string(),
                ));
            }
        }
        if config.vertex_gen.dynamic_value.is_some() {
            context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
            if config.vertex_gen.dynamic_value == Some(VertexGen::Padding16) {
                let mut float16_features = vk::PhysicalDeviceShaderFloat16Int8Features::default();
                let mut storage16_features = vk::PhysicalDevice16BitStorageFeatures::default();
                let mut chain = vk::PhysicalDeviceFeatures2::builder()
                    .push_next(&mut float16_features)
                    .push_next(&mut storage16_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut chain)
                };
                if float16_features.shader_float16 == vk::FALSE {
                    return Err(TestError::NotSupported("shaderFloat16 not supported".to_string()));
                }
                if storage16_features.storage_input_output16 == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "storageInputOutput16 not supported".to_string(),
                    ));
                }
            }
            let mut vertex_input_features = vk::PhysicalDeviceVertexInputDynamicStateFeaturesEXT::default();
            let mut chain = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vertex_input_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut chain)
            };
            if vertex_input_features.vertex_input_dynamic_state == vk::FALSE {
                return Err(TestError::NotSupported(
                    "vertexInputDynamicState not supported".to_string(),
                ));
            }
        }
        if config.uses_coverage_to_color() {
            context.require_device_functionality("VK_NV_fragment_coverage_to_color")?;
            if config.coverage_to_color_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state3_coverage_to_color_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3CoverageToColorEnable not supported".to_string(),
                ));
            }
        }
        if config.viewport_w_scaling {
            context.require_device_functionality("VK_NV_clip_space_w_scaling")?;
            if config.viewport_w_scaling_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state3_viewport_w_scaling_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3ViewportWScalingEnable not supported".to_string(),
                ));
            }
        }
        if config.shading_rate_image {
            context.require_device_functionality("VK_NV_shading_rate_image")?;
            if config.shading_rate_image_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state3_shading_rate_image_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3ShadingRateImageEnable not supported".to_string(),
                ));
            }
        }
        if config.repr_frag_test {
            context.require_device_functionality("VK_NV_representative_fragment_test")?;
            if config.repr_frag_test_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state3_representative_fragment_test_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3RepresentativeFragmentTestEnable not supported".to_string(),
                ));
            }
        }
        if config.uses_frag_atomics() && context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        if config.sample_shading_enable && context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
        }
        if config.viewport_swizzle {
            context.require_device_functionality("VK_NV_viewport_swizzle")?;
            if config.viewport_swizzles.dynamic_value.is_some()
                && features3.extended_dynamic_state3_viewport_swizzle == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3ViewportSwizzle not supported".to_string(),
                ));
            }
        }
        if config.dual_src_blend && context.get_device_features().dual_src_blend == vk::FALSE {
            return Err(TestError::NotSupported("dualSrcBlend is not supported".to_string()));
        }
        if config.requires_maintenance11 {
            context.require_device_functionality("VK_KHR_maintenance11")?;
        }
        if config.requires_depth_clamp_zero_one {
            context.require_device_functionality("VK_EXT_depth_clamp_zero_one")?;
        }
        if config.needs_float_depth
            && choose_depth_stencil_format(context, config.active_sample_count())?.0 != vk::Format::D32_SFLOAT_S8_UINT
        {
            return Err(TestError::NotSupported(
                "No depth/stencil format with a floating point depth channel found".to_string(),
            ));
        }
        if config.uses_line_raster_struct() {
            context.require_device_functionality("VK_EXT_line_rasterization")?;
            if config.line_stipple_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state3_line_stipple_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3LineStippleEnable not supported".to_string(),
                ));
            }
            if select_line_raster_mode(
                context,
                config.line_stipple_support_required(),
                config.line_raster_preference.static_value,
            ) == vk::LineRasterizationMode::DEFAULT
            {
                return Err(TestError::NotSupported(
                    "Wanted static line rasterization mode not supported".to_string(),
                ));
            }
            if let Some(Some(dynamic_mode)) = config.line_raster_preference.dynamic_value {
                if select_line_raster_mode(context, config.line_stipple_support_required(), Some(dynamic_mode))
                    == vk::LineRasterizationMode::DEFAULT
                {
                    return Err(TestError::NotSupported(
                        "Wanted dynamic line rasterization mode not supported".to_string(),
                    ));
                }
            }
            if config.line_raster_preference.dynamic_value.is_some()
                && features3.extended_dynamic_state3_line_rasterization_mode == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3LineRasterizationMode not supported".to_string(),
                ));
            }
        }
        if config.uses_conservative_struct() || config.max_primitive_overestimation_size.is_some() {
            context.require_device_functionality("VK_EXT_conservative_rasterization")?;
            if config.conservative_mode.dynamic_value.is_some()
                && features3.extended_dynamic_state3_conservative_rasterization_mode == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3ConservativeRasterizationMode not supported".to_string(),
                ));
            }
            if config.extra_overestimation.dynamic_value.is_some()
                && features3.extended_dynamic_state3_extra_primitive_overestimation_size == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3ExtraPrimitiveOverestimationSize not supported".to_string(),
                ));
            }
            let mut conservative_properties = vk::PhysicalDeviceConservativeRasterizationPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut conservative_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if config
                .conservative_mode
                .dynamic_value
                .unwrap_or(config.conservative_mode.static_value)
                == vk::ConservativeRasterizationModeEXT::UNDERESTIMATE
                && conservative_properties.primitive_underestimation == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "primitiveUnderestimation not supported".to_string(),
                ));
            }
            let extra_size = config
                .extra_overestimation
                .dynamic_value
                .unwrap_or(config.extra_overestimation.static_value);
            if extra_size >= 0.0 && extra_size > conservative_properties.max_extra_primitive_overestimation_size {
                return Err(TestError::NotSupported(format!(
                    "Extra primitive overestimation size ({extra_size}) above maxExtraPrimitiveOverestimationSize"
                )));
            }
            if let Some(max_size) = config.max_primitive_overestimation_size {
                if conservative_properties.primitive_overestimation_size > max_size {
                    return Err(TestError::NotSupported(format!(
                        "primitiveOverestimationSize ({}) too big for this test (max {max_size})",
                        conservative_properties.primitive_overestimation_size
                    )));
                }
            }
        }
        if config.depth_clip_enable.static_value.is_some() || config.depth_clip_enable.dynamic_value.is_some() {
            context.require_device_functionality("VK_EXT_depth_clip_enable")?;
            if config.depth_clip_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state_3depth_clip_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3DepthClipEnable not supported".to_string(),
                ));
            }
        }
        if config.depth_clamp_enable.static_value || config.depth_clamp_enable.dynamic_value.is_some() {
            if config.depth_clamp_enable.dynamic_value.is_some()
                && features3.extended_dynamic_state_3depth_clamp_enable == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3DepthClampEnable not supported".to_string(),
                ));
            }
            if context.get_device_features().depth_clamp == vk::FALSE {
                return Err(TestError::NotSupported("depthClamp not supported".to_string()));
            }
        }
        if config.polygon_mode.dynamic_value.is_some() {
            if features3.extended_dynamic_state3_polygon_mode == vk::FALSE {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3PolygonMode not supported".to_string(),
                ));
            }
            if context.get_device_features().fill_mode_non_solid == vk::FALSE {
                return Err(TestError::NotSupported("fillModeNonSolid not supported".to_string()));
            }
        }
        let uses_clamp = [Some(config.depth_bias.static_value), config.depth_bias.dynamic_value]
            .into_iter()
            .flatten()
            .any(|(_, clamp)| clamp != 0.0);
        if uses_clamp && context.get_device_features().depth_bias_clamp == vk::FALSE {
            return Err(TestError::NotSupported("depthBiasClamp not supported".to_string()));
        }
        // The number of viewports needed and the limits.
        let mut num_viewports = config.viewports.static_value.len();
        if let Some(dynamic) = &config.viewports.dynamic_value {
            num_viewports = num_viewports.max(dynamic.len());
        }
        if num_viewports > 1 {
            let limits = unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties(context.get_physical_device())
            }
            .limits;
            if num_viewports > limits.max_viewports as usize {
                return Err(TestError::NotSupported(format!(
                    "Number of viewports not supported ({num_viewports})"
                )));
            }
        }
        if config.needs_geometry_shader() && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: geometryShader".to_string(),
            ));
        }
        if config.is_multi_viewport() {
            if context.get_device_features().multi_viewport == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: multiViewport".to_string(),
                ));
            }
        }
        choose_depth_stencil_format(context, config.active_sample_count())?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.config.use_mesh_shaders {
            EXTENDED_DYNAMIC_STATE_BASIC_MESH.programs
        } else {
            EXTENDED_DYNAMIC_STATE_BASIC.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExtendedDynamicStateInstance {
            context,
            config: self.config.clone(),
        })
    }
}

struct ExtendedDynamicStateInstance<'a> {
    context: &'a Context<'a>,
    config: Config,
}

struct PipelineSetup<'a> {
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &'a [vk::PipelineShaderStageCreateInfo],
}

/// The pipeline of the config's static values, with the config's dynamic states when `with_dynamic_states`.
fn build_pipeline<'a>(
    device: &'a Device,
    config: &Config,
    setup: &PipelineSetup<'_>,
    with_dynamic_states: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let bindings: Vec<vk::VertexInputBindingDescription> = config
        .vertex_gen
        .static_value
        .bindings([config.stride.static_value, config.instance_stride.static_value])
        .into_iter()
        .map(|(binding, stride, input_rate)| vk::VertexInputBindingDescription {
            binding,
            stride,
            input_rate,
        })
        .collect();
    let attributes: Vec<vk::VertexInputAttributeDescription> = config
        .vertex_gen
        .static_value
        .attributes()
        .into_iter()
        .map(
            |(location, binding, format, offset)| vk::VertexInputAttributeDescription {
                location,
                binding,
                format,
                offset,
            },
        )
        .collect();
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(config.topology.static_value)
        .primitive_restart_enable(config.primitive_restart_enable.static_value);
    let (viewports, scissors): (Vec<vk::Viewport>, Vec<vk::Rect2D>) = if with_dynamic_states {
        // The counts are zero where a dynamic value will provide them; the other state is cut to the smaller of the final counts.
        let final_viewport_count = config
            .viewports
            .dynamic_value
            .as_ref()
            .map_or(config.viewports.static_value.len(), Vec::len);
        let final_scissor_count = config
            .scissors
            .dynamic_value
            .as_ref()
            .map_or(config.scissors.static_value.len(), Vec::len);
        let min_count = final_viewport_count.min(final_scissor_count);
        let viewports = if config.viewports.dynamic_value.is_some() {
            Vec::new()
        } else {
            config.viewports.static_value[..min_count].to_vec()
        };
        let scissors = if config.scissors.dynamic_value.is_some() {
            Vec::new()
        } else {
            config.scissors.static_value[..min_count].to_vec()
        };
        (viewports, scissors)
    } else {
        let min_count = config
            .viewports
            .static_value
            .len()
            .min(config.scissors.static_value.len());
        (
            config.viewports.static_value[..min_count].to_vec(),
            config.scissors.static_value[..min_count].to_vec(),
        )
    };
    let mut depth_clip_control = vk::PipelineViewportDepthClipControlCreateInfoEXT::builder()
        .negative_one_to_one(config.negative_one_to_one.static_value.unwrap_or(false));
    let mut viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    if config.negative_one_to_one.static_value.is_some() {
        viewport_state = viewport_state.push_next(&mut depth_clip_control);
    }
    let w_scalings = vec![
        vk::ViewportWScalingNV {
            xcoeff: -1.0,
            ycoeff: -1.0
        };
        config.viewports.static_value.len().max(1)
    ];
    let mut w_scaling_state = vk::PipelineViewportWScalingStateCreateInfoNV::builder()
        .viewport_w_scaling_enable(config.viewport_w_scaling_enable.static_value)
        .viewport_w_scalings(&w_scalings);
    if config.viewport_w_scaling {
        viewport_state = viewport_state.push_next(&mut w_scaling_state);
    }
    let palette_entries = [vk::ShadingRatePaletteEntryNV::NO_INVOCATIONS];
    let palettes = vec![
        vk::ShadingRatePaletteNV::builder()
            .shading_rate_palette_entries(&palette_entries)
            .build();
        config.viewports.static_value.len().max(1)
    ];
    let mut shading_rate_image_state = vk::PipelineViewportShadingRateImageStateCreateInfoNV::builder()
        .shading_rate_image_enable(config.shading_rate_image_enable.static_value)
        .shading_rate_palettes(&palettes);
    if config.shading_rate_image {
        viewport_state = viewport_state.push_next(&mut shading_rate_image_state);
    }
    let mut swizzle_state = vk::PipelineViewportSwizzleStateCreateInfoNV::builder()
        .viewport_swizzles(&config.viewport_swizzles.static_value);
    if config.viewport_swizzle {
        viewport_state = viewport_state.push_next(&mut swizzle_state);
    }
    let mut depth_clip_state = vk::PipelineRasterizationDepthClipStateCreateInfoEXT::builder()
        .depth_clip_enable(config.depth_clip_enable.static_value.unwrap_or(true));
    let mut rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(config.depth_clamp_enable.static_value)
        .rasterizer_discard_enable(config.rasterizer_discard.static_value)
        .polygon_mode(config.polygon_mode.static_value)
        .cull_mode(config.cull_mode.static_value)
        .front_face(config.front_face.static_value)
        .depth_bias_enable(config.depth_bias_enable.static_value)
        .depth_bias_constant_factor(config.depth_bias.static_value.0)
        .depth_bias_clamp(config.depth_bias.static_value.1)
        .depth_bias_slope_factor(0.0)
        .line_width(config.line_width.static_value);
    if config.depth_clip_enable.static_value.is_some() {
        rasterization = rasterization.push_next(&mut depth_clip_state);
    }
    let mut repr_state = vk::DepthBiasRepresentationInfoEXT::builder();
    if let Some((representation, exact)) = config.depth_bias_repr_info {
        if config.depth_bias.dynamic_value.is_none() || config.is_reversed() {
            repr_state = repr_state
                .depth_bias_representation(representation)
                .depth_bias_exact(exact);
            rasterization = rasterization.push_next(&mut repr_state);
        }
    }
    let mut conservative_state = vk::PipelineRasterizationConservativeStateCreateInfoEXT::builder()
        .conservative_rasterization_mode(config.conservative_mode.static_value)
        .extra_primitive_overestimation_size(config.extra_overestimation.static_value);
    if config.uses_conservative_struct() {
        rasterization = rasterization.push_next(&mut conservative_state);
    }
    let (stipple_factor, stipple_pattern) = config.line_stipple_params.static_value.unwrap_or((0, 0));
    let mut line_state = vk::PipelineRasterizationLineStateCreateInfo::builder()
        .stippled_line_enable(config.line_stipple_enable.static_value)
        .line_rasterization_mode(config.line_raster_mode)
        .line_stipple_factor(stipple_factor)
        .line_stipple_pattern(stipple_pattern);
    if config.uses_line_raster_struct() {
        rasterization = rasterization.push_next(&mut line_state);
    }
    let mut provoking_state = vk::PipelineRasterizationProvokingVertexStateCreateInfoEXT::builder()
        .provoking_vertex_mode(if config.provoking_vertex.static_value == Some(true) {
            vk::ProvokingVertexModeEXT::LAST_VERTEX
        } else {
            vk::ProvokingVertexModeEXT::FIRST_VERTEX
        });
    if config.provoking_vertex.static_value.is_some() {
        rasterization = rasterization.push_next(&mut provoking_state);
    }
    let mut multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(config.rasterization_samples.static_value)
        .alpha_to_coverage_enable(config.alpha_to_coverage.static_value)
        .alpha_to_one_enable(config.alpha_to_one.static_value)
        .sample_shading_enable(config.sample_shading_enable)
        .min_sample_shading(if config.sample_shading_enable { 1.0 } else { 0.0 });
    if !config.sample_mask.static_value.is_empty() {
        multisample = multisample.sample_mask(&config.sample_mask.static_value);
    }
    let sample_location_coords = vec![
        vk::SampleLocationEXT {
            x: config.sample_locations[0],
            y: config.sample_locations[1]
        };
        config.active_sample_count().bits() as usize
    ];
    let mut sample_locations_state = vk::PipelineSampleLocationsStateCreateInfoEXT::builder()
        .sample_locations_enable(config.sample_locations_enable.static_value)
        .sample_locations_info(
            vk::SampleLocationsInfoEXT::builder()
                .sample_locations_per_pixel(config.active_sample_count())
                .sample_location_grid_size(vk::Extent2D { width: 1, height: 1 })
                .sample_locations(&sample_location_coords)
                .build(),
        );
    if (config.sample_locations_enable.static_value || config.sample_locations_enable.dynamic_value.is_some())
        && config.provide_sample_locations_state
    {
        multisample = multisample.push_next(&mut sample_locations_state);
    }
    let mut coverage_to_color_state = vk::PipelineCoverageToColorStateCreateInfoNV::builder()
        .coverage_to_color_enable(config.coverage_to_color_enable.static_value)
        .coverage_to_color_location(0);
    if config.uses_coverage_to_color() {
        multisample = multisample.push_next(&mut coverage_to_color_state);
    }
    let equation = config.color_blend_equation.static_value;
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(config.color_blend_enable.static_value)
        .src_color_blend_factor(equation.src_color)
        .dst_color_blend_factor(equation.dst_color)
        .color_blend_op(equation.color_op)
        .src_alpha_blend_factor(equation.src_alpha)
        .dst_alpha_blend_factor(equation.dst_alpha)
        .alpha_blend_op(equation.alpha_op)
        .color_write_mask(config.color_write_mask.static_value)
        .build()];
    let color_write_values = [vk::Bool32::from(config.color_write_enable.static_value)];
    let mut color_write_info = vk::PipelineColorWriteCreateInfoEXT::builder().color_write_enables(&color_write_values);
    let mut color_blend_builder = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(config.logic_op_enable.static_value)
        .logic_op(config.logic_op.static_value)
        .attachments(&blend_attachments)
        .blend_constants(config.blend_constants.static_value);
    if config.use_color_write_enable {
        color_blend_builder = color_blend_builder.push_next(&mut color_write_info);
    }
    let mut color_blend = color_blend_builder.build();
    // Every sub-state of the attachment being dynamic, the pointer to the static attachment states can be null.
    if config.null_static_color_blend_attachment_pointer && with_dynamic_states {
        color_blend.attachment_count = 1;
        color_blend.attachments = std::ptr::null();
    }
    // The static front and back operations from the static values, with the default ones for a face without them.
    let make_stencil = |op: &StencilOpParams| vk::StencilOpState {
        fail_op: op.fail_op,
        pass_op: op.pass_op,
        depth_fail_op: op.depth_fail_op,
        compare_op: op.compare_op,
        compare_mask: 0xff,
        write_mask: 0xff,
        reference: config.reference_stencil,
    };
    let mut front_stencil = make_stencil(&DEFAULT_STENCIL_OP_PARAMS);
    let mut back_stencil = front_stencil;
    for op in &config.stencil_ops.static_value {
        if op.face_mask.contains(vk::StencilFaceFlags::FRONT) {
            front_stencil = make_stencil(op);
        }
        if op.face_mask.contains(vk::StencilFaceFlags::BACK) {
            back_stencil = make_stencil(op);
        }
    }
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(config.depth_test_enable.static_value)
        .depth_write_enable(config.depth_write_enable.static_value)
        .depth_compare_op(config.depth_compare_op.static_value)
        .depth_bounds_test_enable(config.depth_bounds_test_enable.static_value)
        .stencil_test_enable(config.stencil_test_enable.static_value)
        .front(front_stencil)
        .back(back_stencil)
        .min_depth_bounds(config.depth_bounds.static_value.0)
        .max_depth_bounds(config.depth_bounds.static_value.1);
    let mut domain_origin_state = vk::PipelineTessellationDomainOriginStateCreateInfo::builder()
        .domain_origin(config.tess_domain_origin.static_value);
    let tessellation_state = vk::PipelineTessellationStateCreateInfo::builder()
        .patch_control_points(config.patch_control_points.static_value)
        .push_next(&mut domain_origin_state);
    let dynamic_states = if with_dynamic_states {
        config.dynamic_states()
    } else {
        Vec::new()
    };
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);
    // Null create info pointers where every sub-state of that info is dynamic.
    let nulls = config.favor_static_null_pointers && with_dynamic_states;
    let null_viewport = nulls && config.viewports.dynamic_value.is_some() && config.scissors.dynamic_value.is_some();
    let null_multisample = nulls
        && config.rasterization_samples.dynamic_value.is_some()
        && config.sample_mask.dynamic_value.is_some()
        && config.alpha_to_coverage.dynamic_value.is_some()
        && config.alpha_to_one.dynamic_value.is_some();
    let null_color_blend = nulls
        && config.logic_op_enable.dynamic_value.is_some()
        && config.logic_op.dynamic_value.is_some()
        && config.color_blend_enable.dynamic_value.is_some()
        && config.color_blend_equation.dynamic_value.is_some()
        && config.color_write_mask.dynamic_value.is_some()
        && config.blend_constants.dynamic_value.is_some();
    let null_rasterization = nulls
        && config.depth_clamp_enable.dynamic_value.is_some()
        && config.rasterizer_discard.dynamic_value.is_some()
        && config.polygon_mode.dynamic_value.is_some()
        && config.cull_mode.dynamic_value.is_some()
        && config.front_face.dynamic_value.is_some()
        && config.depth_bias_enable.dynamic_value.is_some()
        && config.depth_bias.dynamic_value.is_some()
        && config.line_width.dynamic_value.is_some();
    let null_depth_stencil = nulls
        && config.depth_test_enable.dynamic_value.is_some()
        && config.depth_write_enable.dynamic_value.is_some()
        && config.depth_compare_op.dynamic_value.is_some()
        && config.depth_bounds_test_enable.dynamic_value.is_some()
        && config.stencil_test_enable.dynamic_value.is_some()
        && config.stencil_ops.dynamic_value.is_some()
        && config.depth_bounds.dynamic_value.is_some();
    let null_input_assembly =
        nulls && config.primitive_restart_enable.dynamic_value.is_some() && config.topology.dynamic_value.is_some();
    let null_tessellation = nulls && config.patch_control_points.dynamic_value.is_some();
    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(setup.stages)
        .dynamic_state(&dynamic_state)
        .layout(setup.layout)
        .render_pass(setup.render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let info = if null_rasterization {
        info
    } else {
        info.rasterization_state(&rasterization)
    };
    let info = if null_depth_stencil {
        info
    } else {
        info.depth_stencil_state(&depth_stencil)
    };
    let mut repr_frag_state = vk::PipelineRepresentativeFragmentTestStateCreateInfoNV::builder()
        .representative_fragment_test_enable(config.repr_frag_test_enable.static_value);
    let info = if config.repr_frag_test {
        info.push_next(&mut repr_frag_state)
    } else {
        info
    };
    let info = if null_viewport {
        info
    } else {
        info.viewport_state(&viewport_state)
    };
    let info = if null_multisample {
        info
    } else {
        info.multisample_state(&multisample)
    };
    let info = if null_color_blend {
        info
    } else {
        info.color_blend_state(&color_blend)
    };
    let info = if config.use_mesh_shaders {
        info
    } else if null_input_assembly {
        info.vertex_input_state(&vertex_input)
    } else {
        info.vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
    };
    let info = if config.needs_tessellation() && !null_tessellation {
        info.tessellation_state(&tessellation_state)
    } else {
        info
    };
    crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
}

fn make_viewport(width: f32, height: f32) -> vk::Viewport {
    vk::Viewport {
        x: 0.0,
        y: 0.0,
        width,
        height,
        min_depth: 0.0,
        max_depth: 1.0,
    }
}

fn viewport_at(x: f32, y: f32, width: f32, height: f32) -> vk::Viewport {
    vk::Viewport {
        x,
        y,
        width,
        height,
        min_depth: 0.0,
        max_depth: 1.0,
    }
}

fn push_constants(mesh: &Mesh, viewport_index: i32, forced_offset: f32) -> Vec<u8> {
    let mut bytes = Vec::with_capacity(44);
    for value in mesh.color {
        bytes.extend(value.to_ne_bytes());
    }
    bytes.extend(mesh.depth.to_ne_bytes()); // depthValue
    bytes.extend(viewport_index.to_ne_bytes()); // viewPortIndex
    bytes.extend(1.0f32.to_ne_bytes()); // scaleX
    bytes.extend(mesh.scale_y.to_ne_bytes()); // scaleY
    bytes.extend(forced_offset.to_ne_bytes()); // offsetX
    bytes.extend((mesh.offset_y + forced_offset).to_ne_bytes()); // offsetY
    bytes.extend(mesh.strip_scale.to_ne_bytes()); // stripScale
    bytes
}

impl TestInstance for ExtendedDynamicStateInstance<'_> {
    /// `ExtendedDynamicStateInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let mut config = self.config.clone();
        let ordering = config.ordering;
        let reversed = config.is_reversed();
        let bind_static_first = config.bind_static_first();
        let iterations = config.num_iterations();

        // Swap static and dynamic values so the static pipeline ends up with the expected ones where it is bound last.
        if reversed {
            config.swap_values();
        }
        config.line_raster_mode = if config.uses_line_raster_struct() {
            select_line_raster_mode(
                context,
                config.line_stipple_support_required(),
                config.line_raster_preference.static_value,
            )
        } else {
            vk::LineRasterizationMode::DEFAULT
        };

        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let size = crate::tcu::IVec2::new(FRAMEBUFFER_SIZE as i32, FRAMEBUFFER_SIZE as i32);
        let color_format = config.color_format();
        let (ds_format, depth_threshold) = choose_depth_stencil_format(context, config.active_sample_count())?;
        let samples = config.active_sample_count();
        let multisample = config.is_multisample();
        let render_pass = if multisample {
            make_multisample_render_pass(device, color_format, ds_format, samples)?
        } else {
            make_color_depth_render_pass(
                device,
                color_format,
                ds_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            )?
        };
        let mut resolve_images = Vec::new();
        let mut resolve_views = Vec::new();
        let mut color_images = Vec::new();
        let mut color_views = Vec::new();
        let mut ds_images = Vec::new();
        let mut ds_views = Vec::new();
        let ds_range =
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
        let mut framebuffers = Vec::new();
        for _ in 0..iterations {
            let mut color_info = make_image_create_info(
                size,
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            );
            color_info.samples = samples;
            let image = ImageWithMemory::new(
                device,
                context.get_default_allocator(),
                color_info,
                MemoryRequirement::ANY,
            )?;
            let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, color_format, color_range)?;
            let mut ds_info = make_image_create_info(
                size,
                ds_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            );
            ds_info.samples = samples;
            let ds_image =
                ImageWithMemory::new(device, context.get_default_allocator(), ds_info, MemoryRequirement::ANY)?;
            let ds_view = make_image_view(device, ds_image.get(), vk::ImageViewType::_2D, ds_format, ds_range)?;
            if multisample {
                let resolve_image = ImageWithMemory::new(
                    device,
                    context.get_default_allocator(),
                    make_image_create_info(
                        size,
                        color_format,
                        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                    ),
                    MemoryRequirement::ANY,
                )?;
                let resolve_view = make_image_view(
                    device,
                    resolve_image.get(),
                    vk::ImageViewType::_2D,
                    color_format,
                    color_range,
                )?;
                framebuffers.push(make_framebuffer(
                    device,
                    *render_pass,
                    &[*view, *ds_view, *resolve_view],
                    FRAMEBUFFER_SIZE,
                    FRAMEBUFFER_SIZE,
                    1,
                )?);
                resolve_views.push(resolve_view);
                resolve_images.push(resolve_image);
            } else {
                framebuffers.push(make_framebuffer(
                    device,
                    *render_pass,
                    &[*view, *ds_view],
                    FRAMEBUFFER_SIZE,
                    FRAMEBUFFER_SIZE,
                    1,
                )?);
            }
            color_views.push(view);
            color_images.push(image);
            ds_views.push(ds_view);
            ds_images.push(ds_image);
        }

        // Vertex buffers: a full-screen triangle strip with 6 vertices and the same strip in reversed order (1, 0, 3, 2, 5, 4).
        // One segmented line per row of pixels, to be read as a list of lines if the restarts are missing; the index buffer restarts the strip.
        let pixel_height = 2.0 / FRAMEBUFFER_SIZE as f32;
        let mut line_vertices: Vec<[f32; 2]> = Vec::new();
        let mut indices: Vec<u32> = Vec::new();
        if config.line_strips {
            for row in 0..FRAMEBUFFER_SIZE {
                let y = pixel_height / 2.0 + pixel_height * row as f32 - 1.0;
                line_vertices.extend([[-1.0, y], [-0.5, y], [0.5, y], [1.0, y]]);
                // The restart in the middle skips the center strip, as if the topology was a line list.
                if config.needs_index_buffer() {
                    indices.extend([4 * row, 4 * row + 1, 0xFFFF_FFFF, 4 * row + 2, 4 * row + 3, 0xFFFF_FFFF]);
                }
            }
        }
        let vertices: Vec<[f32; 2]> = if config.line_strips {
            line_vertices
        } else if config.topology.static_value == vk::PrimitiveTopology::PATCH_LIST {
            // Two triangles making a quad, as patches of three control points.
            vec![
                [-1.0, 1.0],
                [1.0, 1.0],
                [1.0, -1.0],
                [1.0, -1.0],
                [-1.0, -1.0],
                [-1.0, 1.0],
            ]
        } else if config.oblique_line {
            let pixel = 2.0 / FRAMEBUFFER_SIZE as f32;
            vec![[pixel * 7.0 / 16.0 - 1.0, pixel * 12.0 / 16.0 - 1.0], [1.0, 0.0]]
        } else if config.off_center_triangle {
            let hor_offset = 2.0 / FRAMEBUFFER_SIZE as f32 * config.off_center_proportion[0];
            let vert_offset = 2.0 / FRAMEBUFFER_SIZE as f32 * config.off_center_proportion[1];
            vec![
                [-1.0 + hor_offset, -1.0 + vert_offset],
                [-1.0 + hor_offset, 4.0],
                [4.0, -1.0 + vert_offset],
            ]
        } else if config.oversized_triangle {
            vec![[-2.0, -2.0], [-2.0, 6.0], [6.0, -2.0]]
        } else {
            vec![
                [-1.0, -1.0],
                [-1.0, 1.0],
                [0.0, -1.0],
                [0.0, 1.0],
                [1.0, -1.0],
                [1.0, 1.0],
            ]
        };
        let vertices: Vec<[f32; 2]> = if config.single_vertex {
            vertices[..1].to_vec()
        } else {
            vertices
        };
        let reversed_vertices: Vec<[f32; 2]> = if config.single_vertex {
            vertices.clone()
        } else if config.line_strips
            || config.oblique_line
            || config.topology.static_value == vk::PrimitiveTopology::PATCH_LIST
        {
            Vec::new()
        } else if config.oversized_triangle || config.off_center_triangle {
            vec![vertices[0], vertices[2], vertices[1]]
        } else {
            vec![
                vertices[1],
                vertices[0],
                vertices[3],
                vertices[2],
                vertices[5],
                vertices[4],
            ]
        };
        let active_gen = match config.vertex_gen.dynamic_value {
            Some(dynamic) if !config.swapped_values => dynamic,
            _ => config.vertex_gen.static_value,
        };
        let make_vertex_buffers = |data: &[[f32; 2]]| -> Result<Vec<(BufferWithMemory<'_>, u64)>, TestError> {
            let mut buffers = Vec::new();
            for bytes in active_gen.buffers(data) {
                let size = bytes.len() as u64;
                // The padding before and after the data is a repeated 0xDEADBEEF.
                let pattern = 0xDEAD_BEEFu32.to_ne_bytes();
                let mut full: Vec<u8> = (0..config.vertex_data_offset as usize)
                    .map(|index| pattern[index % 4])
                    .collect();
                full.extend_from_slice(&bytes);
                full.extend((0..config.vertex_data_extra_bytes as usize).map(|index| pattern[index % 4]));
                let buffer = BufferWithMemory::new(
                    device,
                    context.get_default_allocator(),
                    make_buffer_create_info(
                        (full.len() as u64).max(16),
                        if config.use_mesh_shaders {
                            vk::BufferUsageFlags::STORAGE_BUFFER
                        } else {
                            vk::BufferUsageFlags::VERTEX_BUFFER
                        },
                    ),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                unsafe {
                    std::ptr::copy_nonoverlapping(full.as_ptr(), buffer.get_allocation().get_host_ptr(), full.len())
                };
                flush_alloc(device, buffer.get_allocation())?;
                buffers.push((buffer, size));
            }
            Ok(buffers)
        };
        let vertex_buffers = make_vertex_buffers(&vertices)?;
        let index_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info((indices.len().max(1) * 4) as u64, vk::BufferUsageFlags::INDEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        if !indices.is_empty() {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indices.as_ptr() as *const u8,
                    index_buffer.get_allocation().get_host_ptr(),
                    indices.len() * 4,
                )
            };
            flush_alloc(device, index_buffer.get_allocation())?;
        }
        let reversed_vertex_buffers = make_vertex_buffers(&reversed_vertices)?;

        // Pipelines.
        let binaries = context.get_binary_collection();
        let vert_name = match config.provoking_shader_last {
            Some(true) => "provokingVertLast",
            Some(false) => "provokingVertFirst",
            None => "vert",
        };
        let vert_program = if config.use_mesh_shaders {
            if config.is_multi_viewport() {
                "meshViewport"
            } else {
                "mesh"
            }
        } else if let Some(generator) = config.vertex_gen.dynamic_value {
            generator.shader_name()
        } else if config.vertex_gen.static_value != VertexGen::Padding {
            config.vertex_gen.static_value.shader_name()
        } else {
            vert_name
        };
        let static_vert_program = config
            .vertex_gen
            .dynamic_value
            .is_some()
            .then(|| config.vertex_gen.static_value.shader_name());
        let frag_program = if config.repr_frag_test {
            "fragAtomicEarly"
        } else if config.force_atomic_counters {
            "fragAtomicSample"
        } else if config.dual_src_blend {
            "fragDual"
        } else if config.uint_color() {
            "fragUint"
        } else if config.provoking_shader_last.is_some() {
            "provokingFrag"
        } else {
            "frag"
        };
        let vert_module = create_shader_module(device, binaries.get(vert_program)?)?;
        let static_vert_module = match static_vert_program {
            Some(program) => Some(create_shader_module(device, binaries.get(program)?)?),
            None => None,
        };
        let frag_module = create_shader_module(device, binaries.get(frag_program)?)?;
        let tess_modules = if config.needs_tessellation() {
            Some((
                create_shader_module(device, binaries.get("tesc")?)?,
                create_shader_module(device, binaries.get("tese")?)?,
            ))
        } else {
            None
        };
        let geom_name = if config.is_multi_viewport() {
            "geom"
        } else if config.line_strips {
            "geomLine"
        } else {
            "geomTriangle"
        };
        let geom_module = if config.needs_geometry_shader() {
            Some(create_shader_module(device, binaries.get(geom_name)?)?)
        } else {
            None
        };
        let first_stage = if config.use_mesh_shaders {
            vk::ShaderStageFlags::MESH_EXT
        } else {
            vk::ShaderStageFlags::VERTEX
        };
        let mut stages = vec![
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(first_stage)
                .module(*vert_module)
                .name(b"main\0")
                .build(),
        ];
        if let Some((tesc_module, tese_module)) = &tess_modules {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_CONTROL)
                    .module(**tesc_module)
                    .name(b"main\0")
                    .build(),
            );
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION)
                    .module(**tese_module)
                    .name(b"main\0")
                    .build(),
            );
        }
        if let Some(geom_module) = &geom_module {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::GEOMETRY)
                    .module(**geom_module)
                    .name(b"main\0")
                    .build(),
            );
        }
        stages.push(
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        );
        let push_stages = config.push_constant_stages();
        let push_range = [vk::PushConstantRange {
            stage_flags: push_stages,
            offset: 0,
            size: 44,
        }];
        let set_bindings = [vk::DescriptorSetLayoutBinding::builder()
            .binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .descriptor_count(1)
            .stage_flags(if config.uses_frag_atomics() {
                vk::ShaderStageFlags::FRAGMENT
            } else {
                vk::ShaderStageFlags::MESH_EXT
            })
            .build()];
        let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&set_bindings);
        let set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let set_layouts = [*set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_range);
        let layout_info = if config.use_mesh_shaders || config.uses_frag_atomics() {
            layout_info.set_layouts(&set_layouts)
        } else {
            layout_info
        };
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let pool_sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 2,
        }];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .max_sets(2)
            .pool_sizes(&pool_sizes);
        let descriptor_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let two_layouts = [*set_layout, *set_layout];
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*descriptor_pool)
            .set_layouts(&two_layouts);
        let descriptor_sets = if config.use_mesh_shaders || config.uses_frag_atomics() {
            unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?
        } else {
            Vec::new()
        };
        if config.use_mesh_shaders {
            for (set, buffer) in descriptor_sets
                .iter()
                .zip([&vertex_buffers[0].0, &reversed_vertex_buffers[0].0])
            {
                let buffer_infos = [vk::DescriptorBufferInfo {
                    buffer: buffer.get(),
                    offset: 0,
                    range: vk::WHOLE_SIZE,
                }];
                let write = vk::WriteDescriptorSet::builder()
                    .dst_set(*set)
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&buffer_infos);
                unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            }
        }
        let counter_buffer = if config.uses_frag_atomics() {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(4, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, 4) };
            flush_alloc(device, buffer.get_allocation())?;
            let buffer_infos = [vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: 4,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_sets[0])
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_infos);
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            Some(buffer)
        } else {
            None
        };
        let setup = PipelineSetup {
            layout: *pipeline_layout,
            render_pass: *render_pass,
            stages: &stages,
        };
        let static_needed =
            config.is_reversed() || bind_static_first || ordering == SequenceOrdering::ThreeDrawsDynamic;
        let eso_set_layouts: &[vk::DescriptorSetLayout] = if config.use_mesh_shaders || config.uses_frag_atomics() {
            &set_layouts
        } else {
            &[]
        };
        let mut common_names = vec![(first_stage, vert_program)];
        let mut static_names = vec![(first_stage, static_vert_program.unwrap_or(vert_program))];
        if config.needs_tessellation() {
            for names in [&mut common_names, &mut static_names] {
                names.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"));
                names.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"));
            }
        }
        if config.needs_geometry_shader() {
            common_names.push((vk::ShaderStageFlags::GEOMETRY, geom_name));
            static_names.push((vk::ShaderStageFlags::GEOMETRY, geom_name));
        }
        common_names.push((vk::ShaderStageFlags::FRAGMENT, frag_program));
        static_names.push((vk::ShaderStageFlags::FRAGMENT, frag_program));
        let graphics_objects = make_shader_objects_stages(context, &common_names, eso_set_layouts, &push_range)?;
        let static_objects = if graphics_objects.is_some() && static_needed {
            make_shader_objects_stages(context, &static_names, eso_set_layouts, &push_range)?
        } else {
            None
        };
        let shader_objects = graphics_objects.is_some();
        let graphics_pipeline = if shader_objects {
            None
        } else {
            Some(build_pipeline(device, &config, &setup, true)?)
        };
        let mut static_stages = stages.clone();
        if let Some(module) = &static_vert_module {
            static_stages[0].module = **module;
        }
        let static_setup = PipelineSetup {
            layout: *pipeline_layout,
            render_pass: *render_pass,
            stages: &static_stages,
        };
        let static_pipeline = if static_needed && !shader_objects {
            Some(build_pipeline(device, &config, &static_setup, false)?)
        } else {
            None
        };
        let mut eso_base_state =
            DrawPipelineState::new(config.topology.static_value).with_full_viewport(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE);
        eso_base_state.bindings = config
            .vertex_gen
            .static_value
            .bindings([config.stride.static_value, config.instance_stride.static_value])
            .into_iter()
            .map(|(binding, stride, input_rate)| vk::VertexInputBindingDescription {
                binding,
                stride,
                input_rate,
            })
            .collect();
        eso_base_state.attributes = config
            .vertex_gen
            .static_value
            .attributes()
            .into_iter()
            .map(
                |(location, binding, format, offset)| vk::VertexInputAttributeDescription {
                    location,
                    binding,
                    format,
                    offset,
                },
            )
            .collect();
        let eso_static_config = static_as_dynamic(&config, false);
        let eso_dynamic_variant_config = static_as_dynamic(&config, true);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let clear_value = if config.uint_color() {
            vk::ClearValue {
                color: vk::ClearColorValue {
                    uint32: config.clear_color.map(|value| value as u32),
                },
            }
        } else {
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: config.clear_color,
                },
            }
        };

        let ds_clear_value = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: config.clear_depth,
                stencil: config.clear_stencil,
            },
        };
        begin_command_buffer(device, cmd)?;
        for iteration in 0..iterations {
            if ordering == SequenceOrdering::CmdBufferStart {
                set_dynamic_states(&config, device, cmd);
            }

            let clear_values = [clear_value, ds_clear_value, clear_value];
            let clear_values = &clear_values[..if multisample { 3 } else { 2 }];
            if shader_objects {
                let mut barriers = vec![
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        color_images[iteration].get(),
                        color_range,
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        ds_images[iteration].get(),
                        ds_range,
                    ),
                ];
                if multisample {
                    barriers.push(make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        resolve_images[iteration].get(),
                        color_range,
                    ));
                }
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &barriers,
                    );
                }
                begin_rendering(
                    device,
                    cmd,
                    *color_views[iteration],
                    multisample.then(|| *resolve_views[iteration]),
                    *ds_views[iteration],
                    clear_value,
                    ds_clear_value,
                    if config.uint_color() {
                        vk::ResolveModeFlags::SAMPLE_ZERO
                    } else {
                        vk::ResolveModeFlags::AVERAGE
                    },
                );
            } else {
                let render_pass_begin = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffers[iteration])
                    .render_area(make_rect_2d(0, 0, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE))
                    .clear_values(clear_values);
                unsafe { device.cmd_begin_render_pass(cmd, &render_pass_begin, vk::SubpassContents::INLINE) };
            }
            if config.uses_frag_atomics() {
                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout,
                        0,
                        &[descriptor_sets[0]],
                        &[],
                    )
                };
            }
            if config.shading_rate_image {
                unsafe { device.cmd_bind_shading_rate_image_nv(cmd, vk::ImageView::null(), vk::ImageLayout::GENERAL) };
            }

            // Shader objects have no baked state: the static values of the pipeline they stand for are set after the bind,
            // and the dynamic ones of a value set before it are set again.
            let apply_shader_objects = |objects: &ShaderObjectDraw<'_>, variant_config: &Config| {
                objects.bind(cmd, &eso_base_state);
                set_dynamic_states(variant_config, device, cmd);
                set_extra_static_states(&config, device, cmd);
            };
            let bind_static = || {
                if let Some(objects) = &static_objects {
                    apply_shader_objects(objects, &eso_static_config);
                } else if let Some(pipeline) = &static_pipeline {
                    unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline) };
                }
            };
            let bind_dynamic = || {
                if let Some(objects) = &graphics_objects {
                    apply_shader_objects(objects, &eso_dynamic_variant_config);
                    if ordering == SequenceOrdering::CmdBufferStart {
                        set_dynamic_states(&config, device, cmd);
                    }
                } else if let Some(pipeline) = &graphics_pipeline {
                    unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline) };
                }
            };

            // Bind a static pipeline first if needed.
            if (bind_static_first && iteration == 0)
                || (iteration == 1 && ordering == SequenceOrdering::ThreeDrawsDynamic)
            {
                bind_static();
            }
            if ordering == SequenceOrdering::BetweenPipelines {
                set_dynamic_states(&config, device, cmd);
            }

            // Bind the dynamic pipeline.
            let two_or_three = matches!(
                ordering,
                SequenceOrdering::TwoDrawsDynamic
                    | SequenceOrdering::TwoDrawsStatic
                    | SequenceOrdering::ThreeDrawsDynamic
            );
            let dynamic_draw = (ordering == SequenceOrdering::TwoDrawsDynamic && iteration > 0)
                || (ordering == SequenceOrdering::TwoDrawsStatic && iteration == 0)
                || (ordering == SequenceOrdering::ThreeDrawsDynamic && (iteration == 0 || iteration > 1));
            if !two_or_three || dynamic_draw {
                bind_dynamic();
            }
            if ordering == SequenceOrdering::BeforeGoodStatic || dynamic_draw {
                set_dynamic_states(&config, device, cmd);
            }

            // Bind a static pipeline last if needed.
            if ordering == SequenceOrdering::BeforeGoodStatic
                || (ordering == SequenceOrdering::TwoDrawsStatic && iteration > 0)
            {
                bind_static();
            }

            // The first dynamic draw of THREE_DRAWS_DYNAMIC is forced off-screen to keep the framebuffer intact.
            let forced_offset = if ordering == SequenceOrdering::ThreeDrawsDynamic && iteration == 0 {
                1_048_576.0
            } else {
                0.0
            };
            for viewport_idx in 0..config.active_viewports().len() {
                for mesh in &config.meshes {
                    unsafe {
                        device.cmd_push_constants(
                            cmd,
                            *pipeline_layout,
                            push_stages,
                            0,
                            &push_constants(mesh, viewport_idx as i32, forced_offset),
                        )
                    };
                    if ordering == SequenceOrdering::BeforeDraw || ordering == SequenceOrdering::AfterPipelines {
                        set_dynamic_states(&config, device, cmd);
                    }
                    let chosen_buffers = if mesh.reversed {
                        &reversed_vertex_buffers
                    } else {
                        &vertex_buffers
                    };
                    if config.use_mesh_shaders {
                        unsafe {
                            device.cmd_bind_descriptor_sets(
                                cmd,
                                vk::PipelineBindPoint::GRAPHICS,
                                *pipeline_layout,
                                0,
                                &[descriptor_sets[usize::from(mesh.reversed)]],
                                &[],
                            );
                            device.cmd_draw_mesh_tasks_ext(
                                cmd,
                                ((if mesh.reversed {
                                    reversed_vertices.len()
                                } else {
                                    vertices.len()
                                }) - 2) as u32,
                                1,
                                1,
                            );
                        }
                        continue;
                    }
                    let bound_buffers: Vec<vk::Buffer> =
                        chosen_buffers.iter().map(|(buffer, _)| buffer.get()).collect();
                    let offsets = vec![config.vertex_data_offset; bound_buffers.len()];
                    if config.stride.dynamic_value.is_some() || config.instance_stride.dynamic_value.is_some() {
                        let sizes: Vec<u64> = chosen_buffers.iter().map(|(_, size)| *size).collect();
                        let strides: Vec<u64> = active_gen
                            .binding_strides([
                                config.stride.dynamic_value.unwrap_or(config.stride.static_value),
                                config
                                    .instance_stride
                                    .dynamic_value
                                    .unwrap_or(config.instance_stride.static_value),
                            ])
                            .into_iter()
                            .map(u64::from)
                            .collect();
                        unsafe {
                            device.cmd_bind_vertex_buffers2_ext(cmd, 0, &bound_buffers, &offsets, &sizes, &strides)
                        };
                    } else {
                        unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &bound_buffers, &offsets) };
                    }
                    if config.needs_index_buffer() {
                        // The first draw of the two and three draw orderings has no primitive restart enabled: it draws without the invalid index, and the draw
                        // with the restarts replaces the result using all the indices.
                        let first_draw_without_restart = (iteration == 0
                            && matches!(
                                ordering,
                                SequenceOrdering::TwoDrawsDynamic | SequenceOrdering::TwoDrawsStatic
                            ))
                            || (iteration == 1 && ordering == SequenceOrdering::ThreeDrawsDynamic);
                        let index_count = if first_draw_without_restart {
                            2
                        } else {
                            indices.len() as u32
                        };
                        unsafe {
                            device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT32);
                            device.cmd_draw_indexed(cmd, index_count, 1, 0, 0, 0);
                        }
                    } else {
                        unsafe {
                            device.cmd_draw(
                                cmd,
                                if config.single_vertex {
                                    config.single_vertex_draw_count
                                } else {
                                    vertices.len() as u32
                                },
                                config.instance_count,
                                0,
                                0,
                            )
                        };
                    }
                }
            }
            if shader_objects {
                end_dynamic_rendering(device, cmd);
            } else {
                end_render_pass(device, cmd);
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        if let Some(counter_buffer) = &counter_buffer {
            crate::vk::mem_util::invalidate_alloc(device, counter_buffer.get_allocation())?;
            let mut counter_bytes = [0u8; 4];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    counter_buffer.get_allocation().get_host_ptr(),
                    counter_bytes.as_mut_ptr(),
                    4,
                )
            };
            let frag_counter = u32::from_ne_bytes(counter_bytes);
            // Only the last two draws count when there are three; the first is off screen.
            let draws: Vec<usize> = match iterations {
                1 => vec![0],
                _ => (iterations - 2..iterations).collect(),
            };
            let pixels = FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE;
            if config.repr_frag_test {
                let min_value: u32 = if iterations == 1 {
                    let enabled = match config.repr_frag_test_enable.dynamic_value {
                        Some(dynamic) if !config.swapped_values => dynamic,
                        _ => config.repr_frag_test_enable.static_value,
                    };
                    if enabled {
                        1
                    } else {
                        pixels * config.rasterization_samples.static_value.bits()
                    }
                } else {
                    draws
                        .iter()
                        .map(|&draw| {
                            let enabled = if draw == iterations - 2 {
                                config.repr_frag_test_enable.static_value
                            } else {
                                config
                                    .repr_frag_test_enable
                                    .dynamic_value
                                    .unwrap_or(config.repr_frag_test_enable.static_value)
                            };
                            if enabled {
                                1
                            } else {
                                pixels * config.rasterization_samples.static_value.bits()
                            }
                        })
                        .sum()
                };
                if frag_counter < min_value {
                    return Ok(TestStatus::fail(format!(
                        "Fragment shader invocation counter lower than expected: found {frag_counter} and expected at least {min_value}"
                    )));
                }
            } else {
                let sample_count: u32 = if iterations == 1 {
                    config.active_sample_count().bits()
                } else {
                    draws
                        .iter()
                        .map(|&draw| {
                            if draw == iterations - 2 {
                                config.rasterization_samples.static_value.bits()
                            } else {
                                config
                                    .rasterization_samples
                                    .dynamic_value
                                    .unwrap_or(config.rasterization_samples.static_value)
                                    .bits()
                            }
                        })
                        .sum()
                };
                let expected = sample_count * pixels;
                if frag_counter != expected {
                    return Ok(TestStatus::fail(format!(
                        "Fragment shader invocation count does not match expected value: found {frag_counter} and expected {expected}"
                    )));
                }
            }
        }

        // Read the last used framebuffer and compare it with the reference colour.
        let result_image = if multisample {
            resolve_images.last()
        } else {
            color_images.last()
        }
        .expect("at least one iteration")
        .get();
        let result = read_color_attachment(
            context,
            result_image,
            color_format,
            (FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let access = result.get_const_access();
        for y in 0..FRAMEBUFFER_SIZE {
            for x in 0..FRAMEBUFFER_SIZE {
                if let Some(partial_alpha) = config.verify_corner {
                    if (x, y) != (0, 0) {
                        continue;
                    }
                    let pixel = access.get_pixel(0, 0, 0);
                    let alpha_match = if partial_alpha {
                        pixel[3] > 0.0 && pixel[3] < 1.0
                    } else {
                        pixel[3] == config.reference_color[3]
                    };
                    if !(alpha_match && (0..3).all(|c| pixel[c] == config.reference_color[c])) {
                        return Ok(TestStatus::fail("Color mismatch; check log for details"));
                    }
                    continue;
                }
                let expected_color = match config.reference_center_strip {
                    _ if config.vertical_stripes_width.is_some() => {
                        if (x as i32 / config.vertical_stripes_width.unwrap_or(1)) % 2 == 0 {
                            TRIANGLE_COLOR
                        } else {
                            CLEAR_COLOR
                        }
                    }
                    _ if config.reference_border_colors.is_some() => {
                        let (left, corner, top) = config.reference_border_colors.unwrap_or_default();
                        match (x, y) {
                            (0, 0) => corner,
                            (0, _) => left,
                            (_, 0) => top,
                            _ => config.reference_color,
                        }
                    }
                    _ if config.reference_horizontal_split => {
                        if y < FRAMEBUFFER_SIZE / 2 {
                            TRIANGLE_COLOR
                        } else {
                            CLEAR_COLOR
                        }
                    }
                    _ if config.reference_top_left_border => {
                        if x == 0 || y == 0 {
                            CLEAR_COLOR
                        } else {
                            TRIANGLE_COLOR
                        }
                    }
                    Some((sides, center)) => {
                        if (FRAMEBUFFER_SIZE / 4..FRAMEBUFFER_SIZE * 3 / 4).contains(&x) {
                            center
                        } else {
                            sides
                        }
                    }
                    None => config.reference_color,
                };
                let mismatch = if config.uint_color() {
                    let pixel = access.get_pixel_uint(x, y, 0);
                    (0..4).any(|c| pixel[c] != expected_color[c] as u32)
                } else {
                    let pixel = access.get_pixel(x, y, 0);
                    (0..4).any(|c| (pixel[c] - expected_color[c]).abs() >= 0.005)
                };
                if mismatch {
                    return Ok(TestStatus::fail("Color mismatch; check log for details"));
                }
            }
        }

        // The depth and stencil aspects of the last framebuffer, which are not checked when multisampled.
        if multisample {
            return Ok(TestStatus::pass("Pass"));
        }
        let last_ds_image = ds_images.last().expect("at least one iteration").get();
        let depth_result = read_depth_attachment(
            context,
            last_ds_image,
            ds_format,
            (FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE),
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        let stencil_result = read_stencil_attachment(
            context,
            last_ds_image,
            ds_format,
            (FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE),
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        let (depth_access, stencil_access) = (depth_result.get_const_access(), stencil_result.get_const_access());
        let (min_depth, max_depth) = (
            config.expected_depth - depth_threshold - config.extra_depth_threshold,
            config.expected_depth + depth_threshold + config.extra_depth_threshold,
        );
        for y in 0..FRAMEBUFFER_SIZE {
            for x in 0..FRAMEBUFFER_SIZE {
                let depth = depth_access.get_pix_depth(x, y, 0);
                if !(min_depth..=max_depth).contains(&depth)
                    || stencil_access.get_pix_stencil(x, y, 0) != config.expected_stencil
                {
                    return Ok(TestStatus::fail(
                        "Incorrect value found in attachments; please check logged images",
                    ));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

fn cases(ordering: SequenceOrdering, use_mesh_shaders: bool) -> Vec<ExtendedDynamicStateCase> {
    let mut cases = Vec::new();
    let mut add = |name: &'static str, mut config: Config| {
        if use_mesh_shaders {
            // No vertex input, input assembly, tessellation, geometry shader or vertex stage provoking state to vary with mesh shaders.
            let incompatible = config.topology.dynamic_value.is_some()
                || config.topology.static_value != vk::PrimitiveTopology::TRIANGLE_STRIP
                || config.patch_control_points.dynamic_value.is_some()
                || config.tess_domain_origin.dynamic_value.is_some()
                || config.primitive_restart_enable.dynamic_value.is_some()
                || config.primitive_restart_enable.static_value
                || config.line_strips
                || config.oblique_line
                || config.force_geometry_shader
                || config.provoking_shader_last.is_some()
                || config.provoking_vertex.dynamic_value.is_some()
                || config.vertex_gen.dynamic_value.is_some()
                || config.dual_src_blend
                || config.uses_frag_atomics()
                || config.stride.dynamic_value.is_some()
                || config.instance_stride.dynamic_value.is_some()
                || config.instance_count != 1
                || config.provoking_vertex.static_value.is_some();
            if incompatible {
                return;
            }
            config.use_mesh_shaders = true;
        }
        cases.push(ExtendedDynamicStateCase { name, config });
    };

    // Cull modes.
    let mut config = Config::new(ordering);
    config.cull_mode = Pair::both(vk::CullModeFlags::FRONT, vk::CullModeFlags::NONE);
    add("cull_none", config);

    let mut config = Config::new(ordering);
    config.cull_mode = Pair::both(vk::CullModeFlags::FRONT_AND_BACK, vk::CullModeFlags::BACK);
    add("cull_back", config);

    let mut config = Config::new(ordering);
    config.meshes[0].reversed = true;
    config.cull_mode = Pair::both(vk::CullModeFlags::BACK, vk::CullModeFlags::FRONT);
    add("cull_front", config);

    let mut config = Config::new(ordering);
    config.cull_mode = Pair::both(vk::CullModeFlags::NONE, vk::CullModeFlags::FRONT_AND_BACK);
    config.reference_color = CLEAR_COLOR;
    add("cull_front_and_back", config);

    // Front face.
    let mut config = Config::new(ordering);
    config.cull_mode = Pair::fixed(vk::CullModeFlags::BACK);
    config.front_face = Pair::both(vk::FrontFace::CLOCKWISE, vk::FrontFace::COUNTER_CLOCKWISE);
    add("front_face_cw", config);

    let mut config = Config::new(ordering);
    config.meshes[0].reversed = true;
    config.cull_mode = Pair::fixed(vk::CullModeFlags::BACK);
    config.front_face = Pair::both(vk::FrontFace::COUNTER_CLOCKWISE, vk::FrontFace::CLOCKWISE);
    add("front_face_ccw", config);

    let mut config = Config::new(ordering);
    config.cull_mode = Pair::fixed(vk::CullModeFlags::BACK);
    config.front_face = Pair::both(vk::FrontFace::COUNTER_CLOCKWISE, vk::FrontFace::CLOCKWISE);
    config.reference_color = CLEAR_COLOR;
    add("front_face_cw_reversed", config);

    let mut config = Config::new(ordering);
    config.meshes[0].reversed = true;
    config.cull_mode = Pair::fixed(vk::CullModeFlags::BACK);
    config.front_face = Pair::both(vk::FrontFace::CLOCKWISE, vk::FrontFace::COUNTER_CLOCKWISE);
    config.reference_color = CLEAR_COLOR;
    add("front_face_ccw_reversed", config);

    // Rasterizer discard.
    let mut config = Config::new(ordering);
    config.rasterizer_discard = Pair::both(false, true);
    config.reference_color = CLEAR_COLOR;
    add("disable_raster", config);

    let mut config = Config::new(ordering);
    config.rasterizer_discard = Pair::both(true, false);
    add("enable_raster", config);

    // Color blend enable: the equation picks the old colour instead of the new one if blending is enabled.
    let mut config = Config::new(ordering);
    config.color_blend_equation = Pair::fixed(pick_old_color());
    config.color_blend_enable = Pair::both(false, true);
    config.reference_color = CLEAR_COLOR;
    add("color_blend_enable", config);

    let mut config = Config::new(ordering);
    config.color_blend_equation = Pair::fixed(pick_old_color());
    config.color_blend_enable = Pair::both(true, false);
    add("color_blend_disable", config);

    // Color blend equation, with blending statically enabled: the static equation picks the old colour, the dynamic one the new colour.
    let mut config = Config::new(ordering);
    config.color_blend_equation = Pair::both(pick_old_color(), pick_new_color());
    config.color_blend_enable = Pair::fixed(true);
    add("color_blend_equation_new_color", config.clone());
    config.color_blend_equation.swap_values();
    config.reference_color = CLEAR_COLOR;
    add("color_blend_equation_old_color", config);

    // Logic op: clear to green, paint in blue, expect cyan due to the logic op.
    const LOGIC_OP_TRIANGLE_COLOR: [f32; 4] = [0.0, 0.0, 255.0, 255.0];
    const GREEN_CLEAR_COLOR: [f32; 4] = [0.0, 255.0, 0.0, 255.0];
    const LOGIC_OP_FINAL_COLOR: [f32; 4] = [0.0, 255.0, 255.0, 255.0];
    let logic_op_config = |config: &mut Config, reference: [f32; 4]| {
        config.meshes[0].color = LOGIC_OP_TRIANGLE_COLOR;
        config.clear_color = GREEN_CLEAR_COLOR;
        config.reference_color = reference;
    };

    let mut config = Config::new(ordering);
    config.logic_op_enable = Pair::fixed(true);
    config.logic_op = Pair::both(vk::LogicOp::CLEAR, vk::LogicOp::OR);
    logic_op_config(&mut config, LOGIC_OP_FINAL_COLOR);
    add("logic_op_or", config);

    let mut config = Config::new(ordering);
    config.logic_op_enable = Pair::both(false, true);
    config.logic_op = Pair::fixed(vk::LogicOp::OR);
    logic_op_config(&mut config, LOGIC_OP_FINAL_COLOR);
    add("logic_op_enable", config);

    let mut config = Config::new(ordering);
    config.logic_op_enable = Pair::both(true, false);
    config.logic_op = Pair::fixed(vk::LogicOp::OR);
    logic_op_config(&mut config, LOGIC_OP_TRIANGLE_COLOR);
    add("logic_op_disable", config);

    // Depth test enable: by default the depth test never passes when enabled.
    let mut config = Config::new(ordering);
    config.depth_test_enable = Pair::both(false, true);
    config.reference_color = CLEAR_COLOR;
    add("depth_test_enable", config);

    let mut config = Config::new(ordering);
    config.depth_test_enable = Pair::both(true, false);
    add("depth_test_disable", config);

    // Depth write enable, with a depth test that passes.
    let mut config = Config::new(ordering);
    config.depth_test_enable = Pair::fixed(true);
    config.depth_compare_op = Pair::fixed(vk::CompareOp::LESS);
    config.clear_depth = 0.5;
    config.meshes[0].depth = 0.25;
    config.depth_write_enable = Pair::both(false, true);
    config.expected_depth = 0.25;
    add("depth_write_enable", config);

    let mut config = Config::new(ordering);
    config.depth_test_enable = Pair::fixed(true);
    config.depth_compare_op = Pair::fixed(vk::CompareOp::LESS);
    config.clear_depth = 0.5;
    config.meshes[0].depth = 0.25;
    config.depth_write_enable = Pair::both(true, false);
    config.expected_depth = 0.5;
    add("depth_write_disable", config);

    // Depth compare op, with the depth test and writes statically enabled and a static op that never passes.
    let compare_base = || {
        let mut config = Config::new(ordering);
        config.depth_test_enable = Pair::fixed(true);
        config.depth_write_enable = Pair::fixed(true);
        config.clear_depth = 0.5;
        config
    };
    const ALTERNATIVE_COLOR: [f32; 4] = [0.0, 0.0, 0.5, 1.0];
    let compare_config = |static_op: vk::CompareOp,
                          dynamic_op: vk::CompareOp,
                          meshes: &[([f32; 4], f32)],
                          expected_depth: f32,
                          reference: [f32; 4]| {
        let mut config = compare_base();
        config.depth_compare_op = Pair::both(static_op, dynamic_op);
        config.meshes = meshes.iter().map(|&(color, depth)| Mesh::new(color, depth)).collect();
        config.expected_depth = expected_depth;
        config.reference_color = reference;
        config
    };
    let never = vk::CompareOp::NEVER;
    let blue = TRIANGLE_COLOR;
    add(
        "depth_compare_never",
        compare_config(vk::CompareOp::ALWAYS, never, &[(blue, 0.25)], 0.5, CLEAR_COLOR),
    );
    add(
        "depth_compare_less",
        compare_config(never, vk::CompareOp::LESS, &[(blue, 0.25)], 0.25, blue),
    );
    add(
        "depth_compare_greater",
        compare_config(never, vk::CompareOp::GREATER, &[(blue, 0.75)], 0.75, blue),
    );
    // Another mesh in front verifies it does not pass the equality test.
    add(
        "depth_compare_equal",
        compare_config(
            never,
            vk::CompareOp::EQUAL,
            &[(ALTERNATIVE_COLOR, 0.5), (blue, 0.25)],
            0.5,
            ALTERNATIVE_COLOR,
        ),
    );
    add(
        "depth_compare_less_equal_less",
        compare_config(never, vk::CompareOp::LESS_OR_EQUAL, &[(blue, 0.25)], 0.25, blue),
    );
    add(
        "depth_compare_less_equal_equal",
        compare_config(never, vk::CompareOp::LESS_OR_EQUAL, &[(blue, 0.5)], 0.5, blue),
    );
    add(
        "depth_compare_less_equal_less_then_equal",
        compare_config(
            never,
            vk::CompareOp::LESS_OR_EQUAL,
            &[(blue, 0.25), (ALTERNATIVE_COLOR, 0.25)],
            0.25,
            ALTERNATIVE_COLOR,
        ),
    );
    add(
        "depth_compare_greater_equal_greater",
        compare_config(never, vk::CompareOp::GREATER_OR_EQUAL, &[(blue, 0.75)], 0.75, blue),
    );
    add(
        "depth_compare_greater_equal_equal",
        compare_config(never, vk::CompareOp::GREATER_OR_EQUAL, &[(blue, 0.5)], 0.5, blue),
    );
    add(
        "depth_compare_greater_equal_greater_then_equal",
        compare_config(
            never,
            vk::CompareOp::GREATER_OR_EQUAL,
            &[(blue, 0.75), (ALTERNATIVE_COLOR, 0.75)],
            0.75,
            ALTERNATIVE_COLOR,
        ),
    );
    // The first mesh is in front, the second behind it passes too, and the third with the same depth does not.
    add(
        "depth_compare_not_equal",
        compare_config(
            never,
            vk::CompareOp::NOT_EQUAL,
            &[(blue, 0.25), (ALTERNATIVE_COLOR, 0.5), (blue, 0.5)],
            0.5,
            ALTERNATIVE_COLOR,
        ),
    );
    add(
        "depth_compare_always_equal",
        compare_config(never, vk::CompareOp::ALWAYS, &[(blue, 0.5)], 0.5, blue),
    );
    add(
        "depth_compare_always_less",
        compare_config(never, vk::CompareOp::ALWAYS, &[(blue, 0.25)], 0.25, blue),
    );
    add(
        "depth_compare_always_greater",
        compare_config(never, vk::CompareOp::ALWAYS, &[(blue, 0.75)], 0.75, blue),
    );

    // Depth bounds test, with the mesh depth outside of the static bounds.
    let mut config = Config::new(ordering);
    config.depth_bounds = Pair::fixed((0.25, 0.75));
    config.depth_bounds_test_enable = Pair::both(false, true);
    config.reference_color = CLEAR_COLOR;
    add("depth_bounds_test_enable", config);

    let mut config = Config::new(ordering);
    config.depth_bounds = Pair::fixed((0.25, 0.75));
    config.depth_bounds_test_enable = Pair::both(true, false);
    add("depth_bounds_test_disable", config);

    // Stencil test enable, with a front face compare op that never passes.
    let mut config = Config::new(ordering);
    config.stencil_test_enable = Pair::both(false, true);
    config.stencil_ops = Pair::fixed(vec![StencilOpParams {
        face_mask: vk::StencilFaceFlags::FRONT,
        compare_op: vk::CompareOp::NEVER,
        ..DEFAULT_STENCIL_OP_PARAMS
    }]);
    config.reference_color = CLEAR_COLOR;
    add("stencil_test_enable", config);

    let mut config = Config::new(ordering);
    config.stencil_test_enable = Pair::both(true, false);
    config.stencil_ops = Pair::fixed(vec![StencilOpParams {
        face_mask: vk::StencilFaceFlags::FRONT,
        compare_op: vk::CompareOp::NEVER,
        ..DEFAULT_STENCIL_OP_PARAMS
    }]);
    add("stencil_test_disable", config);

    // Depth clamp: without clamping, the mesh depth fails the depth test after the viewport transform; with clamping it passes thanks to the viewport.
    let clamp_config = |enable: Pair<bool>, expected_depth: f32, reference: [f32; 4]| {
        let mut config = Config::new(ordering);
        config.meshes[0].depth = 1.5;
        config.clear_depth = 0.625;
        config.depth_test_enable = Pair::fixed(true);
        config.depth_write_enable = Pair::fixed(true);
        config.depth_compare_op = Pair::fixed(vk::CompareOp::LESS);
        config.viewports = Pair::fixed(vec![vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: FRAMEBUFFER_SIZE as f32,
            height: FRAMEBUFFER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 0.5,
        }]);
        config.expected_depth = expected_depth;
        config.depth_clamp_enable = enable;
        config.reference_color = reference;
        config
    };
    add(
        "depth_clamp_enable",
        clamp_config(Pair::both(false, true), 0.5, TRIANGLE_COLOR),
    );
    add(
        "depth_clamp_disable",
        clamp_config(Pair::both(true, false), 0.625, CLEAR_COLOR),
    );

    // Depth clamping changed dynamically without a depth clip state: clipping follows the clamping. Only the orderings that bind the dynamic pipeline once can tell.
    if !matches!(
        ordering,
        SequenceOrdering::BeforeGoodStatic
            | SequenceOrdering::TwoDrawsDynamic
            | SequenceOrdering::TwoDrawsStatic
            | SequenceOrdering::ThreeDrawsDynamic
    ) {
        let implicit_clip_config =
            |clamp: Pair<bool>, depth_clip: Option<bool>, expected_depth: f32, reference: [f32; 4]| {
                let mut config = Config::new(ordering);
                config.requires_maintenance11 = true;
                config.meshes[0].depth = -0.5;
                config.clear_depth = 1.0;
                config.depth_test_enable = Pair::fixed(true);
                config.depth_write_enable = Pair::fixed(true);
                config.depth_compare_op = Pair::fixed(vk::CompareOp::ALWAYS);
                config.viewports = Pair::fixed(vec![vk::Viewport {
                    x: 0.0,
                    y: 0.0,
                    width: FRAMEBUFFER_SIZE as f32,
                    height: FRAMEBUFFER_SIZE as f32,
                    min_depth: 0.5,
                    max_depth: 1.0,
                }]);
                config.expected_depth = expected_depth;
                config.depth_clamp_enable = clamp;
                config.depth_clip_enable = Pair::fixed(depth_clip);
                config.reference_color = reference;
                config
            };
        add(
            "depth_clamp_enable_no_clip",
            implicit_clip_config(Pair::both(false, true), None, 0.5, TRIANGLE_COLOR),
        );
        add(
            "depth_clamp_enable_with_clip",
            implicit_clip_config(Pair::both(false, true), Some(true), 1.0, CLEAR_COLOR),
        );
        add(
            "depth_clamp_disable_with_clip",
            implicit_clip_config(Pair::both(true, false), None, 1.0, CLEAR_COLOR),
        );
        let mut config = implicit_clip_config(Pair::both(true, false), Some(false), 0.25, TRIANGLE_COLOR);
        config.requires_depth_clamp_zero_one = true;
        add("depth_clamp_disable_no_clip", config);
    }

    // All the colour blend sub-states dynamic, with a null pointer for the static attachment states.
    let mut config = Config::new(ordering);
    config.color_blend_equation = Pair::both(pick_old_color(), pick_new_color());
    config.color_blend_enable = Pair::both(false, true);
    config.color_write_mask = Pair::both(vk::ColorComponentFlags::empty(), vk::ColorComponentFlags::all());
    config.null_static_color_blend_attachment_pointer = true;
    add("null_color_blend_att_ptr", config);

    // Dynamically enable primitive restart: the line strips are cut in the middle, leaving the center strip with the clear colour.
    let mut config = Config::new(ordering);
    config.line_strips = true;
    config.topology = Pair::fixed(vk::PrimitiveTopology::LINE_STRIP);
    config.primitive_restart_enable = Pair::both(false, true);
    config.reference_center_strip = Some((TRIANGLE_COLOR, CLEAR_COLOR));
    add("prim_restart_enable", config);

    // Patch control points, with a pipeline of tessellation shaders.
    let mut config = Config::new(ordering);
    config.topology = Pair::fixed(vk::PrimitiveTopology::PATCH_LIST);
    config.patch_control_points = Pair::both(1, 3);
    add("patch_control_points", config);

    // Tessellation domain origin, with a culling that only the right origin lets through.
    let mut config = Config::new(ordering);
    config.topology = Pair::fixed(vk::PrimitiveTopology::PATCH_LIST);
    config.patch_control_points = Pair::fixed(3);
    config.tess_domain_origin = Pair::both(
        vk::TessellationDomainOrigin::UPPER_LEFT,
        vk::TessellationDomainOrigin::LOWER_LEFT,
    );
    config.cull_mode = Pair::fixed(vk::CullModeFlags::BACK);
    add("tess_domain_origin_lower_left", config);

    let mut config = Config::new(ordering);
    config.topology = Pair::fixed(vk::PrimitiveTopology::PATCH_LIST);
    config.patch_control_points = Pair::fixed(3);
    config.tess_domain_origin = Pair::both(
        vk::TessellationDomainOrigin::LOWER_LEFT,
        vk::TessellationDomainOrigin::UPPER_LEFT,
    );
    config.cull_mode = Pair::fixed(vk::CullModeFlags::FRONT);
    add("tess_domain_origin_upper_left", config);

    // Dynamic topology: the static list topologies miss part of the screen the dynamic strips cover.
    for force_geometry_shader in [false, true] {
        let suffix = if force_geometry_shader { "_geom" } else { "" };

        let mut config = Config::new(ordering);
        config.force_geometry_shader = force_geometry_shader;
        config.topology = Pair::both(vk::PrimitiveTopology::PATCH_LIST, vk::PrimitiveTopology::PATCH_LIST);
        config.patch_control_points = Pair::fixed(3);
        let name: &'static str = Box::leak(format!("topology_patch{suffix}").into_boxed_str());
        add(name, config);

        let mut config = Config::new(ordering);
        config.force_geometry_shader = force_geometry_shader;
        config.topology = Pair::both(
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::PrimitiveTopology::TRIANGLE_STRIP,
        );
        let name: &'static str = Box::leak(format!("topology_triangle{suffix}").into_boxed_str());
        add(name, config);

        let mut config = Config::new(ordering);
        config.force_geometry_shader = force_geometry_shader;
        config.line_strips = true;
        config.topology = Pair::both(vk::PrimitiveTopology::LINE_LIST, vk::PrimitiveTopology::LINE_STRIP);
        config.primitive_restart_enable = Pair::fixed(true);
        let name: &'static str = Box::leak(format!("topology_line{suffix}").into_boxed_str());
        add(name, config);
    }

    // Vertex input: the padding layout statically, the layout with extra attributes dynamically; the strides are halved in the static state.
    if ordering != SequenceOrdering::TwoDrawsStatic {
        let mut config = Config::new(ordering);
        config.vertex_gen = Pair::both(VertexGen::Padding, VertexGen::Extra);
        config.stride = Pair::both(VertexGen::Extra.stride() / 2, VertexGen::Extra.stride());
        add("vertex_input", config);
    }
    let mut config = Config::new(ordering);
    config.vertex_gen = Pair::both(VertexGen::Padding, VertexGen::Extra);
    config.stride = Pair::fixed(VertexGen::Extra.stride());
    add("vertex_input_no_dyn_stride", config);

    // The dynamic stride, with a vertex data offset and padding that an implementation reading outside the data would show.
    for (generator, prefix) in [(VertexGen::Padding, "stride"), (VertexGen::Extra, "large_stride")] {
        // The second attribute of the large stride would reach past the halved stride the draw of this ordering binds.
        if generator == VertexGen::Extra && ordering == SequenceOrdering::TwoDrawsStatic {
            continue;
        }
        let stride = generator.stride();
        let stride_config = || {
            let mut config = Config::new(ordering);
            config.vertex_gen = Pair::fixed(generator);
            config.stride = Pair::both(stride / 2, stride);
            config
        };
        let name = |suffix: &str| -> &'static str { Box::leak(format!("{prefix}{suffix}").into_boxed_str()) };
        add(name(""), stride_config());

        let mut config = stride_config();
        config.vertex_data_offset = stride as u64;
        add(name("_with_offset"), config);

        let mut config = stride_config();
        config.vertex_data_offset = stride as u64;
        config.vertex_data_extra_bytes = stride as u64;
        config.reference_horizontal_split = true;
        config.meshes[0].scale_y = 0.5;
        config.meshes[0].offset_y = -0.5;
        add(name("_with_offset_and_padding"), config);
    }

    // Coverage to color: the red channel of an integer attachment becomes the coverage mask.
    for multisample in [false, true] {
        for coverage_to_color in [false, true] {
            let mut config = Config::new(ordering);
            config.oversized_triangle = true;
            config.rasterization_samples = Pair::fixed(if multisample {
                vk::SampleCountFlags::_4
            } else {
                vk::SampleCountFlags::_1
            });
            config.coverage_to_color_enable = Pair::both(!coverage_to_color, coverage_to_color);
            config.meshes[0].color = [48.0, 0.0, 0.0, 1.0];
            let reference_red = if coverage_to_color {
                if multisample { 15.0 } else { 1.0 }
            } else {
                48.0
            };
            config.reference_color = [reference_red, 0.0, 0.0, 1.0];
            let name: &'static str = Box::leak(
                format!(
                    "coverage_to_color_{}_{}",
                    if coverage_to_color { "enable" } else { "disable" },
                    if multisample { "multisample" } else { "single_sample" }
                )
                .into_boxed_str(),
            );
            add(name, config);
        }
    }

    // Dual source blending: the equation picks which of the two fragment outputs is used.
    let dual_equations = [
        (
            ColorBlendEq::new(
                vk::BlendFactor::SRC_COLOR,
                vk::BlendFactor::ZERO,
                vk::BlendOp::ADD,
                vk::BlendFactor::SRC_ALPHA,
                vk::BlendFactor::ZERO,
                vk::BlendOp::ADD,
            ),
            [1.0, 1.0, 1.0, 1.0],
        ),
        (
            ColorBlendEq::new(
                vk::BlendFactor::SRC1_COLOR,
                vk::BlendFactor::ZERO,
                vk::BlendOp::ADD,
                vk::BlendFactor::SRC1_ALPHA,
                vk::BlendFactor::ZERO,
                vk::BlendOp::ADD,
            ),
            TRIANGLE_COLOR,
        ),
    ];
    for dynamic_pick in 0..2 {
        let mut config = Config::new(ordering);
        config.dual_src_blend = true;
        config.color_blend_enable = Pair::fixed(true);
        config.color_blend_equation = Pair::both(dual_equations[1 - dynamic_pick].0, dual_equations[dynamic_pick].0);
        config.reference_color = dual_equations[dynamic_pick].1;
        add(
            if dynamic_pick == 0 {
                "color_blend_dual_index_0"
            } else {
                "color_blend_dual_index_1"
            },
            config,
        );
    }

    // Advanced blend equations: the static one picks the old colour, the dynamic one the new colour.
    let advanced_old = ColorBlendEq::new(
        vk::BlendFactor::ZERO,
        vk::BlendFactor::ONE,
        vk::BlendOp::DARKEN_EXT,
        vk::BlendFactor::ZERO,
        vk::BlendFactor::ONE,
        vk::BlendOp::DARKEN_EXT,
    );
    let advanced_new = ColorBlendEq::new(
        vk::BlendFactor::ONE,
        vk::BlendFactor::ZERO,
        vk::BlendOp::LIGHTEN_EXT,
        vk::BlendFactor::ONE,
        vk::BlendFactor::ZERO,
        vk::BlendOp::LIGHTEN_EXT,
    );
    let mut config = Config::new(ordering);
    config.color_blend_enable = Pair::fixed(true);
    config.color_blend_equation = Pair::both(advanced_old, advanced_new);
    add("color_blend_equation_advanced_new_color", config.clone());
    config.color_blend_equation.swap_values();
    config.reference_color = CLEAR_COLOR;
    add("color_blend_equation_advanced_old_color", config);

    // Viewport W scaling enable: a negative scale moves the triangle off the top left pixel.
    for w_scaling_enable in [false, true] {
        let mut config = Config::new(ordering);
        config.verify_corner = Some(false);
        config.viewport_w_scaling = true;
        config.viewport_w_scaling_enable = Pair::both(!w_scaling_enable, w_scaling_enable);
        config.reference_color = if w_scaling_enable { CLEAR_COLOR } else { TRIANGLE_COLOR };
        add(
            if w_scaling_enable {
                "viewport_w_scaling_enable"
            } else {
                "viewport_w_scaling_disable"
            },
            config,
        );
    }

    // Shading rate image enable: no invocations are made once it is enabled.
    for shading_rate_image_enable in [false, true] {
        let mut config = Config::new(ordering);
        config.shading_rate_image = true;
        config.shading_rate_image_enable = Pair::both(!shading_rate_image_enable, shading_rate_image_enable);
        config.reference_color = if shading_rate_image_enable {
            CLEAR_COLOR
        } else {
            TRIANGLE_COLOR
        };
        add(
            if shading_rate_image_enable {
                "shading_rate_image_enable"
            } else {
                "shading_rate_image_disable"
            },
            config,
        );
    }

    // Representative fragment test: color writes are off, so only the invocation counter tells.
    for repr_frag_test_enable in [false, true] {
        let mut config = Config::new(ordering);
        config.depth_test_enable = Pair::fixed(true);
        config.depth_compare_op = Pair::fixed(vk::CompareOp::LESS);
        config.color_write_mask = Pair::fixed(vk::ColorComponentFlags::empty());
        config.oversized_triangle = true;
        config.reference_color = CLEAR_COLOR;
        config.repr_frag_test = true;
        config.repr_frag_test_enable = Pair::both(!repr_frag_test_enable, repr_frag_test_enable);
        add(
            if repr_frag_test_enable {
                "repr_frag_test_enable"
            } else {
                "repr_frag_test_disable"
            },
            config,
        );
    }

    // Sample shading with a dynamic sample count: every sample runs the fragment shader.
    let mut config = Config::new(ordering);
    config.sample_shading_enable = true;
    config.force_atomic_counters = true;
    config.oversized_triangle = true;
    config.rasterization_samples = Pair::both(vk::SampleCountFlags::_1, vk::SampleCountFlags::_4);
    add("sample_shading_sample_count", config);

    // Viewport swizzle: switching X and Y makes the oversized triangle clockwise.
    let identity_swizzle = vk::ViewportSwizzleNV {
        x: vk::ViewportCoordinateSwizzleNV::POSITIVE_X,
        y: vk::ViewportCoordinateSwizzleNV::POSITIVE_Y,
        z: vk::ViewportCoordinateSwizzleNV::POSITIVE_Z,
        w: vk::ViewportCoordinateSwizzleNV::POSITIVE_W,
    };
    let yx_swizzle = vk::ViewportSwizzleNV {
        x: vk::ViewportCoordinateSwizzleNV::POSITIVE_Y,
        y: vk::ViewportCoordinateSwizzleNV::POSITIVE_X,
        ..identity_swizzle
    };
    let mut config = Config::new(ordering);
    config.viewport_swizzle = true;
    config.oversized_triangle = true;
    config.cull_mode = Pair::fixed(vk::CullModeFlags::BACK);
    config.viewport_swizzles = Pair::both(vec![identity_swizzle], vec![yx_swizzle]);
    config.front_face = Pair::fixed(vk::FrontFace::CLOCKWISE);
    add("viewport_swizzle_yx", config.clone());
    config.viewport_swizzles.swap_values();
    config.front_face = Pair::fixed(vk::FrontFace::COUNTER_CLOCKWISE);
    add("viewport_swizzle_xy", config);

    // The dynamic stride of zero keeps a single vertex's attribute constant over the draw; the strip scale synthesizes the strip from it.
    if !matches!(
        ordering,
        SequenceOrdering::TwoDrawsStatic | SequenceOrdering::TwoDrawsDynamic | SequenceOrdering::ThreeDrawsDynamic
    ) {
        let mut config = Config::new(ordering);
        config.vertex_gen = Pair::fixed(VertexGen::Extra);
        config.stride = Pair::both(VertexGen::Extra.stride(), 0);
        config.vertex_data_offset = 4;
        config.single_vertex = true;
        config.single_vertex_draw_count = 6;
        config.reference_horizontal_split = true;
        config.meshes[0].scale_y = 0.5;
        config.meshes[0].offset_y = -0.5;
        config.meshes[0].strip_scale = 1.0;
        add("zero_stride_with_offset", config);
    }

    // The instance rate stride: the static state halves the stride of the instance data binding. TWO_DRAWS_STATIC would violate the stride VUID.
    if ordering != SequenceOrdering::TwoDrawsStatic {
        let mut config = Config::new(ordering);
        config.vertex_gen = Pair::fixed(VertexGen::Instance);
        config.stride = Pair::fixed(8);
        config.instance_stride = Pair::both(8, 16);
        config.instance_count = 2;
        add("instance_rate_stride", config);
    }

    // Vertex input with six bindings, three of them unused.
    let mut config = Config::new(ordering);
    config.vertex_gen = Pair::both(VertexGen::Extra, VertexGen::Multiple);
    config.stride = Pair::fixed(8);
    config.instance_stride = Pair::fixed(40);
    add("vertex_input_multiple_bindings", config);

    // Vertex input with 16-bit floats.
    let mut config = Config::new(ordering);
    config.vertex_gen = Pair::both(VertexGen::Padding, VertexGen::Padding16);
    config.stride = Pair::fixed(VertexGen::Padding16.stride());
    add("vertex_input_float16", config);

    // Null state pointers: every sub-state of the info is dynamic.
    let null_config = || {
        let mut config = Config::new(ordering);
        config.favor_static_null_pointers = true;
        config
    };
    let mut config = null_config();
    config.line_strips = true;
    config.topology = Pair::both(vk::PrimitiveTopology::LINE_LIST, vk::PrimitiveTopology::LINE_STRIP);
    config.primitive_restart_enable = Pair::both(false, true);
    config.reference_center_strip = Some((TRIANGLE_COLOR, CLEAR_COLOR));
    add("null_input_assembly_state", config);

    let mut config = null_config();
    config.topology = Pair::fixed(vk::PrimitiveTopology::PATCH_LIST);
    config.patch_control_points = Pair::both(1, 3);
    add("null_tessellation_state", config);

    let mut config = null_config();
    let right_rect = make_rect_2d(FRAMEBUFFER_SIZE as i32 / 2, 0, FRAMEBUFFER_SIZE / 2, FRAMEBUFFER_SIZE);
    let left_rect = make_rect_2d(0, 0, FRAMEBUFFER_SIZE / 2, FRAMEBUFFER_SIZE);
    let half = FRAMEBUFFER_SIZE as f32 / 2.0;
    let right_viewport = vk::Viewport {
        x: half,
        y: 0.0,
        width: half,
        height: FRAMEBUFFER_SIZE as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    };
    let left_viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: half,
        height: FRAMEBUFFER_SIZE as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    };
    config.viewports = Pair::both(vec![right_viewport, left_viewport], vec![left_viewport, right_viewport]);
    config.scissors = Pair::both(vec![right_rect, left_rect], vec![left_rect, right_rect]);
    add("null_viewport_state", config);

    let mut config = null_config();
    config.depth_clamp_enable = Pair::both(true, false);
    config.rasterizer_discard = Pair::both(true, false);
    config.polygon_mode = Pair::both(vk::PolygonMode::POINT, vk::PolygonMode::FILL);
    config.cull_mode = Pair::both(vk::CullModeFlags::FRONT_AND_BACK, vk::CullModeFlags::NONE);
    config.front_face = Pair::both(vk::FrontFace::CLOCKWISE, vk::FrontFace::COUNTER_CLOCKWISE);
    config.depth_bias_enable = Pair::both(true, false);
    config.depth_bias = Pair::both((1.0, 1.0), (0.0, 0.0));
    config.line_width = Pair::both(0.0, 1.0);
    add("null_rasterization_state", config);

    let mut config = null_config();
    config.depth_test_enable = Pair::both(true, false);
    config.depth_write_enable = Pair::both(true, false);
    config.depth_compare_op = Pair::both(vk::CompareOp::NEVER, vk::CompareOp::ALWAYS);
    config.depth_bounds_test_enable = Pair::both(true, false);
    config.stencil_test_enable = Pair::both(true, false);
    let stencil_op = |op: vk::StencilOp, compare_op: vk::CompareOp| StencilOpParams {
        face_mask: vk::StencilFaceFlags::FRONT_AND_BACK,
        fail_op: op,
        pass_op: op,
        depth_fail_op: op,
        compare_op,
    };
    config.stencil_ops = Pair::both(
        vec![stencil_op(vk::StencilOp::INVERT, vk::CompareOp::NEVER)],
        vec![stencil_op(vk::StencilOp::KEEP, vk::CompareOp::ALWAYS)],
    );
    config.depth_bounds = Pair::both((1.0, 1.0), (0.0, 0.0));
    add("null_depth_stencil_state", config);

    let mut config = null_config();
    config.rasterization_samples = Pair::both(vk::SampleCountFlags::_4, vk::SampleCountFlags::_1);
    config.sample_mask = Pair::both(vec![0], vec![0xFF]);
    config.alpha_to_coverage = Pair::both(true, false);
    config.alpha_to_one = Pair::both(true, false);
    add("null_multisample_state", config);

    let mut config = null_config();
    config.force_unorm_color = true;
    config.logic_op_enable = Pair::both(true, false);
    config.logic_op = Pair::both(vk::LogicOp::CLEAR, vk::LogicOp::COPY);
    config.color_blend_enable = Pair::both(true, false);
    config.color_blend_equation = Pair::both(
        ColorBlendEq::new(
            vk::BlendFactor::ZERO,
            vk::BlendFactor::ZERO,
            vk::BlendOp::ADD,
            vk::BlendFactor::ZERO,
            vk::BlendFactor::ZERO,
            vk::BlendOp::ADD,
        ),
        ColorBlendEq::new(
            vk::BlendFactor::ONE,
            vk::BlendFactor::ONE,
            vk::BlendOp::ADD,
            vk::BlendFactor::ONE,
            vk::BlendFactor::ONE,
            vk::BlendOp::ADD,
        ),
    );
    config.color_write_mask = Pair::both(vk::ColorComponentFlags::empty(), vk::ColorComponentFlags::all());
    config.blend_constants = Pair::both([1.0; 4], [0.0; 4]);
    add("null_color_blend_state", config);

    // Sample locations enablement, pushed to the bottom right corner to reach the off center triangle.
    let mut config = Config::new(ordering);
    config.rasterization_samples = Pair::fixed(vk::SampleCountFlags::_4);
    config.off_center_triangle = true;
    config.off_center_proportion = [0.90625, 0.90625];
    config.sample_locations = [1.0, 1.0];
    config.sample_locations_enable = Pair::both(false, true);
    add("sample_locations_enable", config.clone());
    config.provide_sample_locations_state = false;
    config.reference_top_left_border = true;
    add("sample_locations_enable_no_create_info", config.clone());
    config.provide_sample_locations_state = true;
    config.sample_locations_enable.swap_values();
    add("sample_locations_disable", config);

    // The dynamic sample mask count must not overwrite the actual sample mask: sample 3 of four uses a Y offset of 0.875 pixels, tried with a 0.75 offset triangle.
    let mut config = Config::new(ordering);
    config.dynamic_sample_mask_count = Some(vk::SampleCountFlags::_4);
    config.sample_mask = Pair::both(vec![0], vec![0xFF]);
    config.off_center_triangle = true;
    config.off_center_proportion = [0.0, 0.75];
    config.reference_border_colors = Some((TRIANGLE_COLOR, CLEAR_COLOR, CLEAR_COLOR));
    add("sample_mask_count", config);

    // The rasterization samples come from the dynamic value even with a larger static count and mask.
    let mut config = Config::new(ordering);
    if !config.uses_static_pipeline() {
        config.rasterization_samples = Pair::both(vk::SampleCountFlags::_64, vk::SampleCountFlags::_4);
        config.sample_mask = Pair::fixed(vec![0xFFFF_FFF0, 0xFFFF_FFFF]);
        config.reference_color = CLEAR_COLOR;
        add("large_static_rasterization_samples_off", config.clone());
        config.sample_mask = Pair::fixed(vec![0xF, 0]);
        config.reference_color = TRIANGLE_COLOR;
        add("large_static_rasterization_samples_on", config);
    }

    // Multisampling: the same checks in single sample and in multisample modes.
    const TRANSPARENT_COLOR: [f32; 4] = [0.0, 0.0, 1.0, 0.0];
    for multisample in [false, true] {
        let active = if multisample {
            vk::SampleCountFlags::_4
        } else {
            vk::SampleCountFlags::_1
        };
        let inactive = if multisample {
            vk::SampleCountFlags::_1
        } else {
            vk::SampleCountFlags::_4
        };
        let prefix = if multisample { "multi_sample_" } else { "single_sample_" };
        let named = |suffix: &str| -> &'static str { Box::leak(format!("{prefix}{suffix}").into_boxed_str()) };

        // Sample count: the static pipeline would be illegal with attachments of the other count.
        let mut config = Config::new(ordering);
        if !config.uses_static_pipeline() {
            config.rasterization_samples = Pair::both(inactive, active);
            add(named("rasterization_samples"), config);
        }

        // Sample mask.
        let mut config = Config::new(ordering);
        config.rasterization_samples = Pair::fixed(active);
        config.sample_mask = Pair::both(vec![0], vec![0xFF]);
        add(named("sample_mask_enable"), config);

        let mut config = Config::new(ordering);
        config.rasterization_samples = Pair::fixed(active);
        config.sample_mask = Pair::both(vec![0], Vec::new());
        add(named("sample_mask_enable_with_null"), config);

        let mut config = Config::new(ordering);
        config.rasterization_samples = Pair::fixed(active);
        config.sample_mask = Pair::both(vec![0xFF], vec![0]);
        config.reference_color = CLEAR_COLOR;
        add(named("sample_mask_disable"), config);

        // Alpha to coverage and alpha to one, with a transparent mesh.
        let mut config = Config::new(ordering);
        config.rasterization_samples = Pair::fixed(active);
        config.meshes[0].color = TRANSPARENT_COLOR;
        config.alpha_to_coverage = Pair::both(false, true);
        config.reference_color = CLEAR_COLOR;
        add(named("alpha_to_coverage_enable"), config);

        let mut config = Config::new(ordering);
        config.rasterization_samples = Pair::fixed(active);
        config.meshes[0].color = TRANSPARENT_COLOR;
        config.alpha_to_coverage = Pair::both(true, false);
        config.reference_color = TRANSPARENT_COLOR;
        add(named("alpha_to_coverage_disable"), config);

        let mut config = Config::new(ordering);
        config.rasterization_samples = Pair::fixed(active);
        config.meshes[0].color = TRANSPARENT_COLOR;
        config.alpha_to_one = Pair::both(false, true);
        config.reference_color = TRIANGLE_COLOR;
        add(named("alpha_to_one_enable"), config);

        let mut config = Config::new(ordering);
        config.rasterization_samples = Pair::fixed(active);
        config.meshes[0].color = TRANSPARENT_COLOR;
        config.alpha_to_one = Pair::both(true, false);
        config.reference_color = TRANSPARENT_COLOR;
        add(named("alpha_to_one_disable"), config);
    }

    // Color blend equation with every other colour blend state dynamic except the logic op.
    for enable_state_value in [false, true] {
        let state = if enable_state_value { "enable" } else { "disable" };
        let mut config = Config::new(ordering);
        config.color_blend_equation = Pair::both(pick_old_color(), pick_new_color());
        config.color_blend_enable = Pair::both(!enable_state_value, enable_state_value);
        config.color_write_mask = Pair::both(vk::ColorComponentFlags::empty(), vk::ColorComponentFlags::all());
        config.blend_constants = Pair::both([1.0; 4], [0.0; 4]);
        config.use_color_write_enable = true;
        config.color_write_enable = Pair::both(false, true);
        let name: &'static str =
            Box::leak(format!("color_blend_equation_new_color_dynamic_but_logic_op_{state}").into_boxed_str());
        add(name, config.clone());
        // The equation picking the clear colour, over a blend that is enabled or not.
        config.color_blend_equation.swap_values();
        config.reference_color = if enable_state_value {
            CLEAR_COLOR
        } else {
            TRIANGLE_COLOR
        };
        let name: &'static str =
            Box::leak(format!("color_blend_equation_old_color_dynamic_but_logic_op_{state}").into_boxed_str());
        add(name, config);
    }

    // Provoking vertex mode, with an oversized triangle whose provoking vertex alone has a color multiplier of one.
    for (static_value, dynamic_value, name) in [
        (None, true, "provoking_vertex_first_to_last_implicit"),
        (Some(false), true, "provoking_vertex_first_to_last_explicit"),
        (Some(true), false, "provoking_vertex_last_to_first"),
    ] {
        if ordering == SequenceOrdering::TwoDrawsStatic && static_value.is_none() {
            continue;
        }
        let mut config = Config::new(ordering);
        config.provoking_vertex = Pair::both(static_value, Some(dynamic_value));
        config.provoking_shader_last = Some(dynamic_value);
        config.oversized_triangle = true;
        add(name, config);
    }

    // Depth clip negative one to one: with a depth test that passes, the depth written differs between the two ranges.
    for (static_value, dynamic_value, name) in [
        (None, true, "negative_one_to_one_false_to_true_implicit"),
        (Some(false), true, "negative_one_to_one_false_to_true_explicit"),
        (Some(true), false, "negative_one_to_one_true_to_false"),
    ] {
        if ordering == SequenceOrdering::TwoDrawsStatic && static_value.is_none() {
            continue;
        }
        let mut config = Config::new(ordering);
        config.negative_one_to_one = Pair::both(static_value, Some(dynamic_value));
        config.depth_test_enable = Pair::fixed(true);
        config.depth_write_enable = Pair::fixed(true);
        config.depth_compare_op = Pair::fixed(vk::CompareOp::LESS);
        config.meshes[0].depth = 0.5;
        config.expected_depth = if config.active_negative_one_to_one() { 0.75 } else { 0.5 };
        add(name, config);
    }

    // Depth clip enable: the depth clip state alone shows whether the mesh, with a depth out of range, was clipped.
    for (static_value, dynamic_value, name) in [
        (None, false, "depth_clip_enable_true_to_false_implicit"),
        (Some(true), false, "depth_clip_enable_true_to_false_explicit"),
        (Some(false), true, "depth_clip_enable_true_to_false"),
    ] {
        // The bad dynamic value may be nothing in TWO_DRAWS_STATIC, which would draw with a pipeline holding the state but never setting it.
        if ordering == SequenceOrdering::TwoDrawsStatic && static_value.is_none() {
            continue;
        }
        let mut config = Config::new(ordering);
        config.depth_clip_enable = Pair::both(static_value, Some(dynamic_value));
        let active = config.active_depth_clip_enable();
        config.meshes[0].depth = -0.5;
        config.expected_depth = config.clear_depth;
        config.reference_color = if active { CLEAR_COLOR } else { TRIANGLE_COLOR };
        add(name, config);
    }

    // Polygon mode, with an oversized triangle.
    let mut config = Config::new(ordering);
    config.polygon_mode = Pair::both(vk::PolygonMode::FILL, vk::PolygonMode::POINT);
    config.oversized_triangle = true;
    config.reference_color = CLEAR_COLOR;
    add("polygon_mode_point", config);

    let mut config = Config::new(ordering);
    config.polygon_mode = Pair::both(vk::PolygonMode::POINT, vk::PolygonMode::FILL);
    config.oversized_triangle = true;
    add("polygon_mode_fill", config);

    // Conservative rasterization mode: the off center triangle misses the border pixels' centers.
    let mut config = Config::new(ordering);
    config.off_center_triangle = true;
    config.off_center_proportion = [0.75, 0.75];
    config.extra_overestimation = Pair::fixed(0.0);
    config.conservative_mode = Pair::both(
        vk::ConservativeRasterizationModeEXT::DISABLED,
        vk::ConservativeRasterizationModeEXT::OVERESTIMATE,
    );
    add("conservative_rasterization_mode_overestimate", config.clone());
    config.conservative_mode.swap_values();
    config.reference_top_left_border = true;
    add("conservative_rasterization_mode_disabled", config);

    let mut config = Config::new(ordering);
    config.off_center_triangle = true;
    config.off_center_proportion = [0.25, 0.25];
    config.extra_overestimation = Pair::fixed(0.0);
    config.conservative_mode = Pair::both(
        vk::ConservativeRasterizationModeEXT::DISABLED,
        vk::ConservativeRasterizationModeEXT::UNDERESTIMATE,
    );
    config.reference_top_left_border = true;
    add("conservative_rasterization_mode_underestimate", config);

    // Extra primitive overestimation size.
    let mut config = Config::new(ordering);
    config.off_center_triangle = true;
    config.off_center_proportion = [1.125, 1.125];
    config.max_primitive_overestimation_size = Some(0.5);
    config.conservative_mode = Pair::fixed(vk::ConservativeRasterizationModeEXT::OVERESTIMATE);
    config.extra_overestimation = Pair::both(0.0, 0.75);
    add("extra_overestimation_size_large", config.clone());
    config.extra_overestimation.swap_values();
    config.reference_top_left_border = true;
    add("extra_overestimation_size_none", config);

    // Depth bias representation info, set together with the dynamic bias.
    let mut config = Config::new(ordering);
    config.depth_test_enable = Pair::fixed(true);
    config.depth_write_enable = Pair::fixed(true);
    config.depth_compare_op = Pair::fixed(vk::CompareOp::ALWAYS);
    config.clear_depth = 0.0;
    config.meshes[0].depth = 0.125;
    config.expected_depth = 0.625;
    config.depth_bias_repr_info = Some((
        vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORCE_UNORM,
        true,
    ));
    config.needs_float_depth = true;
    let min_r = 1.0 / (1u32 << 24) as f64;
    config.depth_bias_enable = Pair::fixed(true);
    config.depth_bias = Pair::both((0.0, 0.0), ((0.5 / min_r) as f32, 0.0));
    config.extra_depth_threshold = min_r as f32;
    add("depth_bias_repr_info", config);

    let mut config = Config::new(ordering);
    config.depth_test_enable = Pair::fixed(true);
    config.depth_write_enable = Pair::fixed(true);
    config.depth_compare_op = Pair::fixed(vk::CompareOp::ALWAYS);
    config.clear_depth = 0.25;
    config.meshes[0].depth = 0.5;
    config.depth_bias_repr_info = Some((vk::DepthBiasRepresentationEXT::FLOAT, false));
    config.depth_bias_enable = Pair::fixed(true);
    config.depth_bias = Pair::both((0.0, 0.0), (0.25, 0.0));
    config.expected_depth = 0.75;
    add("depth_bias_repr_info_float", config);

    // Line stipple enable and parameters, over line strips.
    let mut config = Config::new(ordering);
    config.line_strips = true;
    config.topology = Pair::fixed(vk::PrimitiveTopology::LINE_STRIP);
    config.primitive_restart_enable = Pair::fixed(true);
    config.line_stipple_enable = Pair::both(true, false);
    config.line_stipple_params = Pair::fixed(Some((1, 0x5555)));
    add("line_stipple_disable", config.clone());
    config.line_stipple_enable.swap_values();
    config.vertical_stripes_width = Some(1);
    add("line_stipple_enable", config);

    let mut config = Config::new(ordering);
    config.line_strips = true;
    config.topology = Pair::fixed(vk::PrimitiveTopology::LINE_STRIP);
    config.primitive_restart_enable = Pair::fixed(true);
    config.line_stipple_enable = Pair::fixed(true);
    config.line_stipple_params = Pair::both(Some((1, 0x5555)), Some((2, 0x3333)));
    config.vertical_stripes_width = Some(4);
    add("line_stipple_params", config);

    // Line rasterization mode over an oblique line that covers the center of the top left pixel only in the bresenham mode.
    let oblique_config =
        |static_mode: vk::LineRasterizationMode, dynamic_mode: vk::LineRasterizationMode, partial_alpha: bool| {
            let mut config = Config::new(ordering);
            config.topology = Pair::fixed(vk::PrimitiveTopology::LINE_STRIP);
            config.oblique_line = true;
            config.verify_corner = Some(partial_alpha);
            config.line_stipple_enable = Pair::fixed(false);
            config.line_stipple_params = Pair::fixed(Some((0, 0)));
            config.line_raster_preference = Pair::both(Some(static_mode), Some(dynamic_mode));
            config
        };
    let config = oblique_config(
        vk::LineRasterizationMode::RECTANGULAR,
        vk::LineRasterizationMode::BRESENHAM,
        false,
    );
    add("line_raster_mode_bresenham", config.clone());
    let mut config = config;
    config.line_raster_preference.swap_values();
    config.reference_color = CLEAR_COLOR;
    add("line_raster_mode_rectangular", config);
    let mut config = oblique_config(
        vk::LineRasterizationMode::BRESENHAM,
        vk::LineRasterizationMode::RECTANGULAR_SMOOTH,
        true,
    );
    config.reference_color = TRIANGLE_COLOR;
    add("line_raster_mode_smooth", config);

    // Depth bias enable with static or dynamic depth bias parameters.
    let alternative_depth_bias = (2.0e7f32, 0.25f32);
    for dynamic_bias in [false, true] {
        let suffix = if dynamic_bias { "_dynamic_bias_params" } else { "" };
        let bias_config = |enable: Pair<bool>, expected_depth: f32| {
            let mut config = Config::new(ordering);
            // Enable depth test and write, clear the depth buffer to 0.25 and write 0.5 to it.
            config.depth_test_enable = Pair::fixed(true);
            config.depth_write_enable = Pair::fixed(true);
            config.depth_compare_op = Pair::fixed(vk::CompareOp::ALWAYS);
            config.clear_depth = 0.25;
            config.meshes[0].depth = 0.5;
            config.depth_bias = if dynamic_bias {
                Pair::both((0.0, 0.0), alternative_depth_bias)
            } else {
                Pair::fixed(alternative_depth_bias)
            };
            config.depth_bias_enable = enable;
            config.expected_depth = expected_depth;
            config
        };
        // The depth value is clamped to 0.75 by the depth bias constant factor and clamp.
        let name: &'static str = Box::leak(format!("depth_bias_enable{suffix}").into_boxed_str());
        add(name, bias_config(Pair::both(false, true), 0.75));
        // With the bias disabled the written value remains.
        let name: &'static str = Box::leak(format!("depth_bias_disable{suffix}").into_boxed_str());
        add(name, bias_config(Pair::both(true, false), 0.5));
    }

    // Viewports and scissors.
    let half = (FRAMEBUFFER_SIZE / 2) as f32;
    let half_i = (FRAMEBUFFER_SIZE / 2) as i32;
    let half_u = FRAMEBUFFER_SIZE / 2;
    let full = FRAMEBUFFER_SIZE as f32;
    let left_half_rect = make_rect_2d(0, 0, half_u, FRAMEBUFFER_SIZE);
    let right_half_rect = make_rect_2d(half_i, 0, half_u, FRAMEBUFFER_SIZE);
    let left_viewport = viewport_at(0.0, 0.0, half, full);
    let right_viewport = viewport_at(half, 0.0, half, full);

    // 2 scissors, bad static single viewport.
    let mut config = Config::new(ordering);
    config.scissors = Pair::fixed(vec![left_half_rect, right_half_rect]);
    config.viewports = Pair::both(vec![make_viewport(half, full)], vec![left_viewport, right_viewport]);
    add("2_viewports", config);

    // Bad static reduced viewport.
    let mut config = Config::new(ordering);
    config.viewports = Pair::both(vec![make_viewport(half, full)], vec![make_viewport(full, full)]);
    add("1_full_viewport", config);

    // 2 scissors (left half, right half), 2 reversed static viewports that need fixing (right, left).
    let mut config = Config::new(ordering);
    config.scissors = Pair::fixed(vec![left_half_rect, right_half_rect]);
    config.viewports = Pair::both(vec![right_viewport, left_viewport], vec![left_viewport, right_viewport]);
    add("2_viewports_switch", config);

    // 2 scissors, reversed dynamic viewports that should result in no drawing taking place.
    let mut config = Config::new(ordering);
    config.scissors = Pair::fixed(vec![left_half_rect, right_half_rect]);
    config.viewports = Pair::both(vec![left_viewport, right_viewport], vec![right_viewport, left_viewport]);
    config.reference_color = CLEAR_COLOR;
    add("2_viewports_switch_clean", config);

    // 2 viewports, bad static single scissor.
    let mut config = Config::new(ordering);
    config.viewports = Pair::fixed(vec![left_viewport, right_viewport]);
    config.scissors = Pair::both(
        vec![right_half_rect],
        vec![make_rect_2d(0, 0, half_u, FRAMEBUFFER_SIZE), right_half_rect],
    );
    add("2_scissors", config);

    // 1 viewport, bad static single scissor.
    let mut config = Config::new(ordering);
    config.scissors = Pair::both(
        vec![right_half_rect],
        vec![make_rect_2d(0, 0, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE)],
    );
    add("1_full_scissor", config);

    // 2 viewports, 2 reversed scissors that need fixing.
    let mut config = Config::new(ordering);
    config.viewports = Pair::fixed(vec![left_viewport, right_viewport]);
    config.scissors = Pair::both(
        vec![right_half_rect, make_rect_2d(0, 0, half_u, FRAMEBUFFER_SIZE)],
        vec![make_rect_2d(0, 0, half_u, FRAMEBUFFER_SIZE), right_half_rect],
    );
    add("2_scissors_switch", config);

    // 2 viewports, 2 scissors switched to prevent drawing.
    let mut config = Config::new(ordering);
    config.viewports = Pair::fixed(vec![left_viewport, right_viewport]);
    config.scissors = Pair::both(
        vec![make_rect_2d(0, 0, half_u, FRAMEBUFFER_SIZE), right_half_rect],
        vec![right_half_rect, make_rect_2d(0, 0, half_u, FRAMEBUFFER_SIZE)],
    );
    config.reference_color = CLEAR_COLOR;
    add("2_scissors_switch_clean", config);

    // Stencil operation: many combinations, each with an incompatible static state that only the dynamic operation fixes.
    let stencil_result = |op: vk::StencilOp, stored: u8, reference: u8| -> u8 {
        match op {
            vk::StencilOp::ZERO => 0,
            vk::StencilOp::REPLACE => reference,
            vk::StencilOp::INCREMENT_AND_CLAMP => stored.saturating_add(1),
            vk::StencilOp::DECREMENT_AND_CLAMP => stored.saturating_sub(1),
            vk::StencilOp::INVERT => !stored,
            vk::StencilOp::INCREMENT_AND_WRAP => stored.wrapping_add(1),
            vk::StencilOp::DECREMENT_AND_WRAP => stored.wrapping_sub(1),
            _ => stored,
        }
    };
    let stencil_passes = |op: vk::CompareOp, stored: u8, reference: u8| match op {
        vk::CompareOp::NEVER => false,
        vk::CompareOp::LESS => reference < stored,
        vk::CompareOp::EQUAL => reference == stored,
        vk::CompareOp::LESS_OR_EQUAL => reference <= stored,
        vk::CompareOp::GREATER => reference > stored,
        vk::CompareOp::GREATER_OR_EQUAL => reference >= stored,
        _ => true,
    };
    // `face`: front, both with one call, both with two calls (the placeholder of upstream's MAX_ENUM face).
    for (face_name, face_kind) in [("face_front", 0u32), ("face_both_single", 1), ("face_both_dual", 2)] {
        for (compare_name, compare_op) in [("lt", vk::CompareOp::LESS), ("gt", vk::CompareOp::GREATER)] {
            for (op_name, stencil_op, clear_values, incompatible_op) in [
                (
                    "inc_clamp",
                    vk::StencilOp::INCREMENT_AND_CLAMP,
                    [u8::MAX - 1, u8::MAX],
                    vk::StencilOp::ZERO,
                ),
                (
                    "dec_wrap",
                    vk::StencilOp::DECREMENT_AND_WRAP,
                    [u8::MIN + 1, u8::MIN],
                    vk::StencilOp::KEEP,
                ),
            ] {
                for clear_value in clear_values {
                    for delta in [-1i32, 1] {
                        let reference = i32::from(clear_value) + delta;
                        if !(0..=255).contains(&reference) {
                            continue;
                        }
                        let reference_u8 = reference as u8;
                        let would_pass = stencil_passes(compare_op, clear_value, reference_u8);
                        for depth_fail in [false, true].into_iter().take(if would_pass { 2 } else { 1 }) {
                            let global_pass = would_pass && !depth_fail;
                            let mut config = Config::new(ordering);
                            // No face culling: the front or the back operation applies depending on the mesh.
                            if face_kind != 0 {
                                // Both a front and a back-facing mesh, the first in the top half and the second in the bottom half.
                                let mut top = config.meshes[0];
                                top.scale_y = 0.5;
                                top.offset_y = -0.5;
                                let mut bottom = config.meshes[0];
                                bottom.reversed = true;
                                bottom.scale_y = 0.5;
                                bottom.offset_y = 0.5;
                                config.meshes = vec![top, bottom];
                            }
                            config.stencil_test_enable = Pair::fixed(true);
                            // The operation of this case is the only one giving the right result.
                            let (mut fail_op, mut pass_op, mut depth_fail_op) =
                                (incompatible_op, incompatible_op, incompatible_op);
                            if would_pass {
                                if depth_fail {
                                    depth_fail_op = stencil_op;
                                } else {
                                    pass_op = stencil_op;
                                }
                            } else {
                                fail_op = stencil_op;
                            }
                            let face_mask = if face_kind == 0 {
                                vk::StencilFaceFlags::FRONT
                            } else {
                                vk::StencilFaceFlags::FRONT_AND_BACK
                            };
                            let dynamic = StencilOpParams {
                                face_mask,
                                fail_op,
                                pass_op,
                                depth_fail_op,
                                compare_op,
                            };
                            let static_ops = StencilOpParams {
                                face_mask,
                                fail_op: incompatible_op,
                                pass_op: incompatible_op,
                                depth_fail_op: incompatible_op,
                                compare_op: if global_pass {
                                    vk::CompareOp::NEVER
                                } else {
                                    vk::CompareOp::ALWAYS
                                },
                            };
                            let dynamic_ops = if face_kind == 2 {
                                vec![
                                    StencilOpParams {
                                        face_mask: vk::StencilFaceFlags::FRONT,
                                        ..dynamic
                                    },
                                    StencilOpParams {
                                        face_mask: vk::StencilFaceFlags::BACK,
                                        ..dynamic
                                    },
                                ]
                            } else {
                                vec![dynamic]
                            };
                            config.stencil_ops = Pair::both(vec![static_ops], dynamic_ops);
                            config.clear_stencil = u32::from(clear_value);
                            config.reference_stencil = reference as u32;
                            if depth_fail {
                                // Enable the depth test and make it fail.
                                config.depth_test_enable = Pair::fixed(true);
                                config.clear_depth = 0.5;
                                config.depth_compare_op = Pair::fixed(vk::CompareOp::LESS);
                                for mesh in &mut config.meshes {
                                    mesh.depth = 0.75;
                                }
                            }
                            config.reference_color = if global_pass { TRIANGLE_COLOR } else { CLEAR_COLOR };
                            config.expected_depth = config.clear_depth;
                            config.expected_stencil = u32::from(stencil_result(stencil_op, clear_value, reference_u8));
                            let outcome = if would_pass {
                                if depth_fail { "depthfail" } else { "pass" }
                            } else {
                                "fail"
                            };
                            let name: &'static str = Box::leak(format!("stencil_state_{face_name}_{compare_name}_{op_name}_clear_{clear_value}_ref_{reference}_{outcome}").into_boxed_str());
                            add(name, config);
                        }
                    }
                }
            }
        }
    }

    // Color write mask, over a transparent clear colour with an opaque white mesh.
    const R: vk::ColorComponentFlags = vk::ColorComponentFlags::R;
    const G: vk::ColorComponentFlags = vk::ColorComponentFlags::G;
    const B: vk::ColorComponentFlags = vk::ColorComponentFlags::B;
    const A: vk::ColorComponentFlags = vk::ColorComponentFlags::A;
    const NONE: vk::ColorComponentFlags = vk::ColorComponentFlags::empty();
    let all = R | G | B | A;
    let clear = [0.0f32, 0.0, 0.0, 0.0];
    let white = [1.0f32, 1.0, 1.0, 1.0];
    for (static_mask, dynamic_mask) in [
        (all, R),
        (all, G),
        (all, B),
        (all, A),
        (all, NONE),
        (NONE, R),
        (NONE, G),
        (NONE, B),
        (NONE, A),
        (NONE, all),
    ] {
        let mut config = Config::new(ordering);
        config.clear_color = clear;
        config.meshes[0].color = white;
        config.color_write_mask = Pair::both(static_mask, dynamic_mask);
        // `filterColor`: the mesh colour where the dynamic mask writes, the clear colour elsewhere.
        let components = [R, G, B, A];
        config.reference_color = std::array::from_fn(|c| {
            if dynamic_mask.contains(components[c]) {
                white[c]
            } else {
                clear[c]
            }
        });
        let name: &'static str = Box::leak(
            format!(
                "color_write_mask_{}_to_{}",
                component_codes(static_mask),
                component_codes(dynamic_mask)
            )
            .into_boxed_str(),
        );
        add(name, config);
    }

    cases
}

/// `componentCodes`
fn component_codes(components: vk::ColorComponentFlags) -> String {
    let mut name = String::new();
    for (flag, code) in [
        (vk::ColorComponentFlags::R, "r"),
        (vk::ColorComponentFlags::G, "g"),
        (vk::ColorComponentFlags::B, "b"),
        (vk::ColorComponentFlags::A, "a"),
    ] {
        if components.contains(flag) {
            name.push_str(code);
        }
    }
    if name.is_empty() {
        name.push('0');
    }
    name
}

/// The ordering groups of `extended_dynamic_state`, with the cases of this slice.
pub fn add_extended_dynamic_state_basic_groups(group: &mut TestCaseGroup) {
    add_extended_dynamic_state_basic_groups_for(group, false);
}

/// The shader object types leave out the orderings with two pipelines bound before the state is set, the shading rate image,
/// the null state pointer and the no create info sample locations cases; a depth clamp case also enables the depth clip.
pub fn add_extended_dynamic_state_basic_groups_for(group: &mut TestCaseGroup, shader_object: bool) {
    let orderings = [
        ("cmd_buffer_start", SequenceOrdering::CmdBufferStart),
        ("before_draw", SequenceOrdering::BeforeDraw),
        ("between_pipelines", SequenceOrdering::BetweenPipelines),
        ("after_pipelines", SequenceOrdering::AfterPipelines),
        ("before_good_static", SequenceOrdering::BeforeGoodStatic),
        ("two_draws_dynamic", SequenceOrdering::TwoDrawsDynamic),
        ("two_draws_static", SequenceOrdering::TwoDrawsStatic),
        ("three_draws_dynamic", SequenceOrdering::ThreeDrawsDynamic),
    ];
    let shader_object_cases = |ordering: SequenceOrdering, use_mesh_shaders: bool| -> Vec<ExtendedDynamicStateCase> {
        cases(ordering, use_mesh_shaders)
            .into_iter()
            .filter(|case| {
                !shader_object
                    || !(case.config.favor_static_null_pointers
                        || case.config.null_static_color_blend_attachment_pointer
                        || case.config.shading_rate_image
                        || (case.config.sample_locations_enable.dynamic_value.is_some()
                            && !case.config.provide_sample_locations_state))
            })
            .map(|mut case| {
                if shader_object && case.name == "depth_clamp_disable_with_clip" {
                    case.config.depth_clip_enable.static_value = Some(true);
                }
                case
            })
            .collect()
    };
    for (name, ordering) in orderings {
        if shader_object
            && matches!(
                ordering,
                SequenceOrdering::BetweenPipelines | SequenceOrdering::AfterPipelines
            )
        {
            continue;
        }
        let mut ordering_group = TestCaseGroup::new(name);
        for case in shader_object_cases(ordering, false) {
            ordering_group.add_child(Box::new(case) as Box<dyn TestCase>);
        }
        group.add_child(ordering_group);
    }
    let mut mesh_group = TestCaseGroup::new("mesh_shader");
    for (name, ordering) in orderings {
        if shader_object
            && matches!(
                ordering,
                SequenceOrdering::BetweenPipelines | SequenceOrdering::AfterPipelines
            )
        {
            continue;
        }
        let mut ordering_group = TestCaseGroup::new(name);
        for case in shader_object_cases(ordering, true) {
            ordering_group.add_child(Box::new(case) as Box<dyn TestCase>);
        }
        mesh_group.add_child(ordering_group);
    }
    group.add_child(mesh_group);
}
