// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_barycentric/vktFragmentShadingBarycentricTests.cpp (the `weights` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Advanced Micro Devices, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are the `WEIGHTS_*` constants of
// `shaders/manifest/fragment_shading_barycentric_weights.toml`; the test fragment shader of `msaa_centroid_qualifier` and
// `msaa_sample_qualifier` is SPIR-V assembly there (`stage = "asm"`), as it is upstream. The pipelines go through `DrawPipelineState`;
// the images are not logged, the comparison keeps `intThresholdCompare` with a threshold of one per channel.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicStateExtensionDeviceCommands, ExtMeshShaderExtensionDeviceCommands};

use super::util::{
    SupportRequirements, TOPOLOGIES, TestSubtype, WEIGHT_TEST_HEIGHT, WEIGHT_TEST_SLOPE, WEIGHT_TEST_WIDTH,
    check_support, copy_image_to_buffer, create_vertex_buffer, is_primitive_topology_line,
    is_primitive_topology_triangle, make_image_create_info, make_render_pass, primitive_topology_cast_to_list,
};
use crate::generated::shaders::fragment_shading_barycentric_weights::{
    WEIGHTS_MESH_LINE_LIST_NOPERSPECTIVE, WEIGHTS_MESH_LINE_LIST_PERSPECTIVE, WEIGHTS_MESH_POINT_LIST_NOPERSPECTIVE,
    WEIGHTS_MESH_POINT_LIST_PERSPECTIVE, WEIGHTS_MESH_TRIANGLE_LIST_NOPERSPECTIVE,
    WEIGHTS_MESH_TRIANGLE_LIST_PERSPECTIVE, WEIGHTS_VERTEX_NOPERSPECTIVE_CENTROID,
    WEIGHTS_VERTEX_NOPERSPECTIVE_CENTROID_QUALIFIER, WEIGHTS_VERTEX_NOPERSPECTIVE_DEFAULT,
    WEIGHTS_VERTEX_NOPERSPECTIVE_OFFSET, WEIGHTS_VERTEX_NOPERSPECTIVE_SAMPLE,
    WEIGHTS_VERTEX_NOPERSPECTIVE_SAMPLE_QUALIFIER, WEIGHTS_VERTEX_PERSPECTIVE_CENTROID,
    WEIGHTS_VERTEX_PERSPECTIVE_CENTROID_QUALIFIER, WEIGHTS_VERTEX_PERSPECTIVE_DEFAULT,
    WEIGHTS_VERTEX_PERSPECTIVE_OFFSET, WEIGHTS_VERTEX_PERSPECTIVE_SAMPLE, WEIGHTS_VERTEX_PERSPECTIVE_SAMPLE_QUALIFIER,
};
use crate::tcu::image_compare::int_threshold_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus, UVec4};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, default_rasterization_state, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy)]
struct WeightParams {
    subtype: TestSubtype,
    topology: vk::PrimitiveTopology,
    perspective: bool,
    provoking_vertex_last: bool,
    rotation: u32,
    dynamic_topology_in_pipeline: bool,
    sample_count: vk::SampleCountFlags,
    use_mesh_shader: bool,
    construction: PipelineConstructionType,
}

impl WeightParams {
    /// `initWeightPrograms`' choice of shader set.
    fn programs(&self) -> BinaryCollection {
        if self.use_mesh_shader {
            let constants = match (self.topology, self.perspective) {
                (vk::PrimitiveTopology::POINT_LIST, true) => &WEIGHTS_MESH_POINT_LIST_PERSPECTIVE,
                (vk::PrimitiveTopology::POINT_LIST, false) => &WEIGHTS_MESH_POINT_LIST_NOPERSPECTIVE,
                (vk::PrimitiveTopology::LINE_LIST, true) => &WEIGHTS_MESH_LINE_LIST_PERSPECTIVE,
                (vk::PrimitiveTopology::LINE_LIST, false) => &WEIGHTS_MESH_LINE_LIST_NOPERSPECTIVE,
                (_, true) => &WEIGHTS_MESH_TRIANGLE_LIST_PERSPECTIVE,
                (_, false) => &WEIGHTS_MESH_TRIANGLE_LIST_NOPERSPECTIVE,
            };
            return constants.programs;
        }

        let constants = match (self.perspective, self.subtype) {
            (true, TestSubtype::MsaaInterpolateAtCentroid) => &WEIGHTS_VERTEX_PERSPECTIVE_CENTROID,
            (true, TestSubtype::MsaaInterpolateAtSample) => &WEIGHTS_VERTEX_PERSPECTIVE_SAMPLE,
            (true, TestSubtype::MsaaInterpolateAtOffset) => &WEIGHTS_VERTEX_PERSPECTIVE_OFFSET,
            (true, TestSubtype::MsaaCentroidQualifier) => &WEIGHTS_VERTEX_PERSPECTIVE_CENTROID_QUALIFIER,
            (true, TestSubtype::MsaaSampleQualifier) => &WEIGHTS_VERTEX_PERSPECTIVE_SAMPLE_QUALIFIER,
            (true, _) => &WEIGHTS_VERTEX_PERSPECTIVE_DEFAULT,
            (false, TestSubtype::MsaaInterpolateAtCentroid) => &WEIGHTS_VERTEX_NOPERSPECTIVE_CENTROID,
            (false, TestSubtype::MsaaInterpolateAtSample) => &WEIGHTS_VERTEX_NOPERSPECTIVE_SAMPLE,
            (false, TestSubtype::MsaaInterpolateAtOffset) => &WEIGHTS_VERTEX_NOPERSPECTIVE_OFFSET,
            (false, TestSubtype::MsaaCentroidQualifier) => &WEIGHTS_VERTEX_NOPERSPECTIVE_CENTROID_QUALIFIER,
            (false, TestSubtype::MsaaSampleQualifier) => &WEIGHTS_VERTEX_NOPERSPECTIVE_SAMPLE_QUALIFIER,
            (false, _) => &WEIGHTS_VERTEX_NOPERSPECTIVE_DEFAULT,
        };
        constants.programs
    }
}

struct WeightCase {
    name: &'static str,
    params: WeightParams,
}

impl TestCase for WeightCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `FragmentShadingBarycentricTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_pipeline_construction_requirements(context, self.params.construction)?;
        check_support(
            context,
            SupportRequirements {
                provoking_vertex_last: self.params.provoking_vertex_last,
                dynamic_topology_in_pipeline: self.params.dynamic_topology_in_pipeline,
                use_mesh_shader: self.params.use_mesh_shader,
                sample_rate_shading: matches!(
                    self.params.subtype,
                    TestSubtype::MsaaInterpolateAtSample | TestSubtype::MsaaInterpolateAtOffset
                ),
                ..Default::default()
            },
        )
    }

    fn programs(&self) -> BinaryCollection {
        self.params.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(WeightInstance {
            context,
            params: self.params,
        })
    }
}

struct WeightInstance<'a> {
    context: &'a Context<'a>,
    params: WeightParams,
}

impl TestInstance for WeightInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        weight_iterate(self.context, &self.params)
    }
}

fn mix(x: [f32; 4], y: [f32; 4], a: f32) -> [f32; 4] {
    std::array::from_fn(|i| x[i] * (1.0 - a) + y[i] * a)
}

fn scale(vertex: [f32; 4], factor: f32) -> [f32; 4] {
    vertex.map(|value| value * factor)
}

/// `FragmentShadingBarycentricWeightTestInstance::generateVertexBuffer` - a position and a colour per vertex.
fn generate_vertex_buffer(topology: vk::PrimitiveTopology) -> Vec<[f32; 4]> {
    let slope = WEIGHT_TEST_SLOPE;
    let width = WEIGHT_TEST_WIDTH as usize;
    let height = WEIGHT_TEST_HEIGHT as usize;
    let left_bot_color = [0.00f32, 0.00, 0.00, 1.0];
    let left_top_color = [1.00f32, 0.00, 0.00, 1.0];
    let right_top_color = [0.00f32, 1.00, 0.00, 1.0];
    let right_bot_color = [0.00f32, 0.00, 1.00, 1.0];
    let none_color = [0.25f32, 0.50, 0.75, 1.0];
    let mut result: Vec<[f32; 4]> = Vec::new();
    let mut add = |vertex: [f32; 4], color: [f32; 4]| {
        result.push(vertex);
        result.push(color);
    };

    match topology {
        vk::PrimitiveTopology::POINT_LIST => {
            for y in 0..height {
                let ky = (0.5 + y as f32) / height as f32;
                let yy = -1.0 + 2.0 * ky;
                let left_color = mix(left_top_color, left_bot_color, ky);
                let right_color = mix(right_top_color, right_bot_color, ky);

                for x in 0..width {
                    let kx = (0.5 + x as f32) / width as f32;
                    let xx = -1.0 + 2.0 * kx;
                    let point_slope = 1.0 + kx * (slope - 1.0);
                    let point = scale([xx, yy, 0.0, 1.0], point_slope);
                    let color = mix(left_color, right_color, kx);

                    add(point, color);
                }
            }
        }
        vk::PrimitiveTopology::LINE_LIST => {
            for y in 0..height {
                let ky = (0.5 + y as f32) / height as f32;
                let yy = -1.0 + 2.0 * ky;
                let left_color = mix(left_top_color, left_bot_color, ky);
                let right_color = mix(right_top_color, right_bot_color, ky);
                let left = [-1.0f32, yy, 0.0, 1.0];
                let right = scale([1.0, yy, 0.0, 1.0], slope);

                add(left, left_color);
                add(right, right_color);
            }
        }
        vk::PrimitiveTopology::LINE_STRIP => {
            for y in 0..height {
                let ky = (0.5 + y as f32) / height as f32;
                let yy = -1.0 + 2.0 * ky;
                let left_color = mix(left_top_color, left_bot_color, ky);
                let right_color = mix(right_top_color, right_bot_color, ky);
                let left = [-2.0f32, yy, 0.0, 1.0];
                let right = scale([2.0, yy, 0.0, 1.0], slope);

                if y % 2 == 0 {
                    add(left, left_color);
                    add(right, right_color);
                } else {
                    add(right, right_color);
                    add(left, left_color);
                }
            }
        }
        vk::PrimitiveTopology::TRIANGLE_LIST => {
            add([-1.0, -1.0, 0.0, 1.0], left_top_color);
            add([-1.0, 1.0, 0.0, 1.0], left_bot_color);
            add(scale([1.0, 1.0, 0.0, 1.0], slope), right_bot_color);

            add(scale([1.0, 1.0, 0.0, 1.0], slope), right_bot_color);
            add(scale([1.0, -1.0, 0.0, 1.0], slope), right_top_color);
            add([-1.0, -1.0, 0.0, 1.0], left_top_color);
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP => {
            add([-1.0, 1.0, 0.0, 1.0], left_bot_color);
            add([-1.0, -1.0, 0.0, 1.0], left_top_color);
            add(scale([1.0, 1.0, 0.0, 1.0], slope), right_bot_color);
            add(scale([1.0, -1.0, 0.0, 1.0], slope), right_top_color);
        }
        vk::PrimitiveTopology::TRIANGLE_FAN => {
            add([-1.0, -1.0, 0.0, 1.0], left_top_color);
            add([-1.0, 1.0, 0.0, 1.0], left_bot_color);
            add(scale([1.0, 1.0, 0.0, 1.0], slope), right_bot_color);
            add(scale([1.0, -1.0, 0.0, 1.0], slope), right_top_color);
        }
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
            for y in 0..height {
                let ky = (0.5 + y as f32) / height as f32;
                let yy = -1.0 + 2.0 * ky;
                let left_color = mix(left_top_color, left_bot_color, ky);
                let right_color = mix(right_top_color, right_bot_color, ky);
                let pre_left = [-2.0f32, yy, 0.0, 1.0];
                let left = [-1.0f32, yy, 0.0, 1.0];
                let right = scale([1.0, yy, 0.0, 1.0], slope);
                let after_right = scale([2.0, yy, 0.0, 1.0], slope);

                add(pre_left, none_color);
                add(left, left_color);
                add(right, right_color);
                add(after_right, none_color);
            }
        }
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
            add([-10.0, -10.0, 0.0, 1.0], none_color);

            for y in 0..height {
                let ky = (0.5 + y as f32) / height as f32;
                let yy = -1.0 + 2.0 * ky;
                let left_color = mix(left_top_color, left_bot_color, ky);
                let right_color = mix(right_top_color, right_bot_color, ky);
                let left = [-2.0f32, yy, 0.0, 1.0];
                let right = scale([2.0, yy, 0.0, 1.0], slope);

                if y % 2 == 0 {
                    add(left, left_color);
                    add(right, right_color);
                } else {
                    add(right, right_color);
                    add(left, left_color);
                }
            }

            add([10.0, 10.0, 0.0, 1.0], none_color);
        }
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
            add([-1.0, 1.0, 0.0, 1.0], left_bot_color);
            add([-3.0, 1.0, 0.0, 1.0], none_color);
            add([-1.0, -1.0, 0.0, 1.0], left_top_color);
            add(scale([1.0, -1.0, 0.0, 1.0], slope), none_color);
            add(scale([1.0, 1.0, 0.0, 1.0], slope), right_bot_color);
            add(scale([1.0, 3.0, 0.0, 1.0], slope), none_color);

            add([-1.0, -1.0, 0.0, 1.0], left_top_color);
            add([-1.0, 1.0, 0.0, 1.0], none_color);
            add(scale([1.0, 1.0, 0.0, 1.0], slope), right_bot_color);
            add(scale([3.0, 1.0, 0.0, 1.0], slope), none_color);
            add(scale([1.0, -1.0, 0.0, 1.0], slope), right_top_color);
            add([-1.0, -3.0, 0.0, 1.0], left_top_color);
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
            add([-1.0, 1.0, 0.0, 1.0], left_bot_color);
            add([-3.0, -1.0, 0.0, 1.0], none_color);
            add([-1.0, -1.0, 0.0, 1.0], left_top_color);
            add(scale([1.0, 3.0, 0.0, 1.0], slope), none_color);
            add(scale([1.0, 1.0, 0.0, 1.0], slope), right_bot_color);
            add([-1.0, -3.0, 0.0, 1.0], none_color);
            add(scale([1.0, -1.0, 0.0, 1.0], slope), right_top_color);
            add(scale([1.0, 3.0, 0.0, 1.0], slope), none_color);
        }
        _ => unreachable!("Unknown topology"),
    }

    result
}

/// `FragmentShadingBarycentricWeightTestInstance::iterate`
fn weight_iterate<'a>(context: &'a Context<'a>, params: &WeightParams) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let width = WEIGHT_TEST_WIDTH;
    let height = WEIGHT_TEST_HEIGHT;
    let pixel_size = 4usize;
    let dynamic_state_topology = params.dynamic_topology_in_pipeline;
    let pipeline_topology = if dynamic_state_topology {
        primitive_topology_cast_to_list(params.topology)
    } else {
        params.topology
    };
    let use_multisampling = params.sample_count != vk::SampleCountFlags::_1;
    let use_mesh_shader = params.use_mesh_shader;
    let teta = (-(params.rotation as f32)).to_radians();
    let mvp: [f32; 16] = [
        teta.cos(),
        -teta.sin(),
        0.0,
        0.0,
        teta.sin(),
        teta.cos(),
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
    ];
    let mvp_bytes: Vec<u8> = mvp.iter().flat_map(|value| value.to_ne_bytes()).collect();
    let tcu_format = map_vk_format(FORMAT).ok_or_else(|| TestError::Fail("Unmapped format".to_string()))?;

    let vertices = generate_vertex_buffer(params.topology);
    let vertex_count = (vertices.len() / 2) as u32;
    let vertex_buffer = create_vertex_buffer(context, &vertices, use_mesh_shader)?;

    let buffer_usage = if use_mesh_shader {
        vk::BufferUsageFlags::UNIFORM_BUFFER | vk::BufferUsageFlags::TRANSFER_DST
    } else {
        vk::BufferUsageFlags::TRANSFER_DST
    };
    let buffer_size = (width as usize * height as usize * pixel_size) as vk::DeviceSize;
    let result_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, buffer_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let reference_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, buffer_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let render_pass = make_render_pass(device, FORMAT, params.sample_count)?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let binaries = context.get_binary_collection();
    let shader_module = create_shader_module(device, binaries.get(if use_mesh_shader { "mesh" } else { "vert" })?)?;

    let image_info = make_image_create_info(FORMAT, width, height, vk::SampleCountFlags::_1);
    let ms_image_info = make_image_create_info(FORMAT, width, height, params.sample_count);
    let image_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue { uint32: [0; 4] },
    }; 2];

    let mesh_descriptors = if use_mesh_shader {
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::MESH_EXT)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        let vertex_buffer_info = vk::DescriptorBufferInfo {
            buffer: vertex_buffer.get(),
            offset: 0,
            range: (vertices.len() * std::mem::size_of::<[f32; 4]>()) as vk::DeviceSize,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &vertex_buffer_info,
            )
            .update(device);
        Some((set_layout, pool, set))
    } else {
        None
    };

    let push_stage = if use_mesh_shader {
        vk::ShaderStageFlags::MESH_EXT
    } else {
        vk::ShaderStageFlags::VERTEX
    };
    let push_constant_ranges = [vk::PushConstantRange {
        stage_flags: push_stage,
        offset: 0,
        size: mvp_bytes.len() as u32,
    }];
    let set_layouts: Vec<vk::DescriptorSetLayout> =
        mesh_descriptors.iter().map(|(set_layout, _, _)| **set_layout).collect();
    let layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&push_constant_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    for ndx in 0..2 {
        let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D, FORMAT, image_srr)?;
        let ms_image = if use_multisampling {
            Some(ImageWithMemory::new(
                device,
                allocator,
                ms_image_info,
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let ms_image_view = match &ms_image {
            Some(ms_image) => Some(make_image_view(
                device,
                ms_image.get(),
                vk::ImageViewType::_2D,
                FORMAT,
                image_srr,
            )?),
            None => None,
        };

        let mut initial_image_barriers = vec![make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            image_srr,
        )];
        let mut attachment_views = vec![*image_view];
        if let (Some(ms_image), Some(ms_image_view)) = (&ms_image, &ms_image_view) {
            initial_image_barriers.push(make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                ms_image.get(),
                image_srr,
            ));
            attachment_views.push(**ms_image_view);
        }

        let framebuffer = make_framebuffer(device, *render_pass, &attachment_views, width, height, 1)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let buffer = if ndx == 0 { &result_buffer } else { &reference_buffer };
        let frag_module = create_shader_module(
            device,
            binaries.get(if ndx == 0 { "frag_test" } else { "frag_reference" })?,
        )?;

        let mut state = DrawPipelineState::new(pipeline_topology).with_full_viewport(width, height);
        if !use_mesh_shader {
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 2 * std::mem::size_of::<[f32; 4]>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![
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
                    offset: std::mem::size_of::<[f32; 4]>() as u32,
                },
            ];
        }
        state.rasterization = default_rasterization_state();
        state.rasterization.cull_mode = vk::CullModeFlags::NONE;
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.rasterization.line_width = 1.0;
        state.construction = params.construction;
        if params.provoking_vertex_last {
            state.provoking_vertex_mode = Some(vk::ProvokingVertexModeEXT::LAST_VERTEX);
        }
        state.samples = params.sample_count;
        state.sample_shading = use_multisampling;
        state.min_sample_shading = 1.0;
        if dynamic_state_topology {
            state.dynamic_states.push(vk::DynamicState::PRIMITIVE_TOPOLOGY);
        }
        let first_stage = if use_mesh_shader {
            vk::ShaderStageFlags::MESH_EXT
        } else {
            vk::ShaderStageFlags::VERTEX
        };
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (first_stage, *shader_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &initial_image_barriers,
            );

            if dynamic_state_topology {
                device.cmd_set_primitive_topology_ext(cmd, params.topology);
            }

            let attachment_count = 1 + usize::from(use_multisampling);
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(width, height))
                .clear_values(&clear_values[..attachment_count]);
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);

            if let Some((_, _, descriptor_set)) = &mesh_descriptors {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
            } else {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            }

            device.cmd_push_constants(cmd, *pipeline_layout, push_stage, 0, &mvp_bytes);

            if use_mesh_shader {
                let group_count = if params.topology == vk::PrimitiveTopology::POINT_LIST {
                    (256, 8, 8)
                } else {
                    (1, 1, 1)
                };
                device.cmd_draw_mesh_tasks_ext(cmd, group_count.0, group_count.1, group_count.2);
            } else {
                device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            }
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(device, cmd, image.get(), buffer.get(), width, height);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, buffer.get_allocation())?;
    }

    let size = [width, height, 1];
    let reference_bytes = unsafe {
        std::slice::from_raw_parts(
            reference_buffer.get_allocation().get_host_ptr().cast_const(),
            buffer_size as usize,
        )
    };
    let result_bytes = unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr().cast_const(),
            buffer_size as usize,
        )
    };
    let reference_image = ConstPixelBufferAccess::new(tcu_format, size, reference_bytes);
    let result_image = ConstPixelBufferAccess::new(tcu_format, size, result_bytes);

    if int_threshold_compare(&reference_image, &result_image, UVec4::from_array([1, 1, 1, 1])).ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// The `weights` child of `createTests`.
pub fn create_weight_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let perspectives = [("perspective", true), ("noperspective", false)];
    let provoking_vertices = [("provoking_first", false), ("provoking_last", true)];
    let rotations = [0u32, 85, 95];
    let msaa_cases: [(&'static str, vk::SampleCountFlags, TestSubtype); 6] = [
        ("single_sample", vk::SampleCountFlags::_1, TestSubtype::Default),
        (
            "msaa_interpolate_at_centroid",
            vk::SampleCountFlags::_4,
            TestSubtype::MsaaInterpolateAtCentroid,
        ),
        (
            "msaa_interpolate_at_sample",
            vk::SampleCountFlags::_4,
            TestSubtype::MsaaInterpolateAtSample,
        ),
        (
            "msaa_interpolate_at_offset",
            vk::SampleCountFlags::_4,
            TestSubtype::MsaaInterpolateAtOffset,
        ),
        (
            "msaa_centroid_qualifier",
            vk::SampleCountFlags::_4,
            TestSubtype::MsaaCentroidQualifier,
        ),
        (
            "msaa_sample_qualifier",
            vk::SampleCountFlags::_4,
            TestSubtype::MsaaSampleQualifier,
        ),
    ];
    let mesh_specs = [("mesh_shader", true), ("vertex_shader", false)];
    let mesh_topologies = [
        vk::PrimitiveTopology::POINT_LIST,
        vk::PrimitiveTopology::LINE_LIST,
        vk::PrimitiveTopology::TRIANGLE_LIST,
    ];

    let mut test_type_group = TestCaseGroup::new("weights");

    for (provoking_name, provoking_vertex_last) in provoking_vertices {
        let mut provoking_vertex_group = TestCaseGroup::new(provoking_name);

        for (topology_in_pipeline_name, topology_in_pipeline) in
            [("pipeline_topology_static", false), ("pipeline_topology_dynamic", true)]
        {
            let mut topology_in_pipeline_group = TestCaseGroup::new(topology_in_pipeline_name);

            if topology_in_pipeline {
                for (msaa_name, samples, subtype) in msaa_cases {
                    let mut msaa_group = TestCaseGroup::new(msaa_name);
                    for (topology, topology_name) in TOPOLOGIES {
                        let mut topology_group = TestCaseGroup::new(topology_name);
                        let testable_topology =
                            is_primitive_topology_line(topology) || is_primitive_topology_triangle(topology);

                        if !testable_topology {
                            continue;
                        }

                        for (perspective_name, perspective) in perspectives {
                            let mut use_perspective_group = TestCaseGroup::new(perspective_name);

                            for (mesh_name, use_mesh_shader) in mesh_specs {
                                if use_mesh_shader && !mesh_topologies.contains(&topology) {
                                    continue;
                                }

                                // A dynamic primitive topology cannot be combined with a mesh shader.
                                if use_mesh_shader && topology_in_pipeline {
                                    continue;
                                }

                                let params = WeightParams {
                                    subtype,
                                    topology,
                                    perspective,
                                    provoking_vertex_last: false,
                                    rotation: 0,
                                    dynamic_topology_in_pipeline: topology_in_pipeline,
                                    sample_count: samples,
                                    use_mesh_shader,
                                    construction,
                                };
                                use_perspective_group.add_child(Box::new(WeightCase {
                                    name: mesh_name,
                                    params,
                                })
                                    as Box<dyn TestCase>);
                            }

                            topology_group.add_child(use_perspective_group);
                        }
                        msaa_group.add_child(topology_group);
                    }
                    topology_in_pipeline_group.add_child(msaa_group);
                }
            } else {
                for rotation in rotations {
                    let rotation_name: &'static str = match rotation {
                        0 => "0",
                        85 => "85",
                        _ => "95",
                    };
                    let mut rotation_group = TestCaseGroup::new(rotation_name);

                    for (topology, topology_name) in TOPOLOGIES {
                        let mut topology_group = TestCaseGroup::new(topology_name);

                        for (perspective_name, perspective) in perspectives {
                            let mut use_perspective_group = TestCaseGroup::new(perspective_name);

                            for (mesh_name, use_mesh_shader) in mesh_specs {
                                if use_mesh_shader && !mesh_topologies.contains(&topology) {
                                    continue;
                                }

                                let params = WeightParams {
                                    subtype: TestSubtype::Default,
                                    topology,
                                    perspective,
                                    provoking_vertex_last,
                                    rotation,
                                    dynamic_topology_in_pipeline: topology_in_pipeline,
                                    sample_count: vk::SampleCountFlags::_1,
                                    use_mesh_shader,
                                    construction,
                                };
                                use_perspective_group.add_child(Box::new(WeightCase {
                                    name: mesh_name,
                                    params,
                                })
                                    as Box<dyn TestCase>);
                            }
                            topology_group.add_child(use_perspective_group);
                        }
                        rotation_group.add_child(topology_group);
                    }

                    topology_in_pipeline_group.add_child(rotation_group);
                }
            }
            provoking_vertex_group.add_child(topology_in_pipeline_group);
        }
        test_type_group.add_child(provoking_vertex_group);
    }

    test_type_group
}
