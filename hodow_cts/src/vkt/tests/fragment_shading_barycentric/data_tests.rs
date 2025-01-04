// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_barycentric/vktFragmentShadingBarycentricTests.cpp (the `data` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Advanced Micro Devices, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The GLSL `initDataPrograms` builds with `StringTemplate`s is under
// `shaders/src/fragment_shading_barycentric/data/` and what it computes into its `attributes` map is the `derived` table of each case
// in `shaders/manifest/fragment_shading_barycentric_data.toml` (written by `scripts/gen_barycentric_manifest.py`). A case name is its
// test path with the groups joined by `__`, which is how the tree below looks the programs up. On a failure upstream logs the mask
// of every pixel; here the verdict is all there is.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;

use super::util::{
    DATA_TEST_HEIGHT, DATA_TEST_WIDTH, SupportRequirements, TOPOLOGIES, TestSubtype, check_support,
    copy_image_to_buffer, create_vertex_buffer, fragment_shader_barycentric_properties, make_image_create_info,
    make_render_pass,
};
use crate::generated::shaders::fragment_shading_barycentric_data::ALL_BARY_DATA_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
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
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, default_rasterization_state, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R32G32B32A32_UINT;

/// The `rust_type` of the manifest entries: one test case of `data`.
#[derive(Clone, Copy)]
pub struct BaryDataPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ScalarKind {
    Float,
    Double,
    Int,
    Uint,
}

/// The `dataTypes` table of `createTests`, with what `glu::getDataTypeScalarSize` and the type predicates answer.
const DATA_TYPES: [(&str, u32, ScalarKind); 16] = [
    ("float", 1, ScalarKind::Float),
    ("vec2", 2, ScalarKind::Float),
    ("vec3", 3, ScalarKind::Float),
    ("vec4", 4, ScalarKind::Float),
    ("double", 1, ScalarKind::Double),
    ("dvec2", 2, ScalarKind::Double),
    ("dvec3", 3, ScalarKind::Double),
    ("dvec4", 4, ScalarKind::Double),
    ("int", 1, ScalarKind::Int),
    ("ivec2", 2, ScalarKind::Int),
    ("ivec3", 3, ScalarKind::Int),
    ("ivec4", 4, ScalarKind::Int),
    ("uint", 1, ScalarKind::Uint),
    ("uvec2", 2, ScalarKind::Uint),
    ("uvec3", 3, ScalarKind::Uint),
    ("uvec4", 4, ScalarKind::Uint),
];

#[derive(Clone, Copy)]
struct DataParams {
    subtype: TestSubtype,
    topology: vk::PrimitiveTopology,
    dynamic_indexing: bool,
    /// 0: the value itself, 1: a struct, 2 and more: an array.
    aggregate: u32,
    scalar_size: u32,
    double: bool,
    provoking_vertex_last: bool,
    test_with_interpolation: bool,
    test_with_flat_interpolation: bool,
    clip_vertices: bool,
    use_mesh_shader: bool,
    construction: PipelineConstructionType,
}

impl DataParams {
    /// `getComponentCount` - three items are always checked: "Reads of per-vertex values for missing vertices, such as the third vertex of a
    /// line primitive, will return zero."
    fn component_count(&self) -> u32 {
        self.scalar_size * self.aggregate.max(1) * 3
    }
}

struct DataCase {
    name: String,
    params: DataParams,
    programs: BinaryCollection,
}

impl TestCase for DataCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `FragmentShadingBarycentricTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        check_pipeline_construction_requirements(context, params.construction)?;
        check_support(
            context,
            SupportRequirements {
                provoking_vertex_last: params.provoking_vertex_last,
                use_mesh_shader: params.use_mesh_shader,
                double: params.double,
                tessellation: matches!(params.subtype, TestSubtype::TessShader | TestSubtype::TessGeomShader),
                geometry: matches!(
                    params.subtype,
                    TestSubtype::GeometryShader | TestSubtype::TessGeomShader
                ),
                ..Default::default()
            },
        )
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DataInstance {
            context,
            params: self.params,
        })
    }
}

struct DataInstance<'a> {
    context: &'a Context<'a>,
    params: DataParams,
}

impl TestInstance for DataInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        data_iterate(self.context, &self.params)
    }
}

/// `FragmentShadingBarycentricDataTestInstance::generateVertexBuffer`
fn generate_vertex_buffer(params: &DataParams) -> Vec<[f32; 4]> {
    let width = DATA_TEST_WIDTH as usize;
    let height = DATA_TEST_HEIGHT as usize;
    let mut result: Vec<[f32; 4]> = Vec::new();
    let row = |y: usize| -1.0 + 2.0 * ((0.5 + y as f32) / height as f32);

    match params.topology {
        vk::PrimitiveTopology::POINT_LIST => {
            for y in 0..height {
                let yy = row(y);
                for x in 0..width {
                    let xx = -1.0 + 2.0 * ((0.5 + x as f32) / width as f32);
                    result.push([xx, yy, 0.0, 1.0]);
                }
            }
        }
        vk::PrimitiveTopology::LINE_LIST => {
            for y in 0..height {
                let yy = row(y);
                result.push([-1.0, yy, 0.0, 1.0]);
                result.push([1.0, yy, 0.0, 1.0]);
            }
        }
        vk::PrimitiveTopology::LINE_STRIP => {
            for y in 0..height {
                let yy = -1.0 + 2.0 * (0.5 + y as f32) / height as f32;

                if y % 2 == 0 {
                    result.push([-2.0, yy, 0.0, 1.0]);
                    result.push([2.0, yy, 0.0, 1.0]);
                } else {
                    result.push([2.0, yy, 0.0, 1.0]);
                    result.push([-2.0, yy, 0.0, 1.0]);
                }
            }
        }
        vk::PrimitiveTopology::PATCH_LIST | vk::PrimitiveTopology::TRIANGLE_LIST => {
            result.push([-1.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, 1.0, 0.0, 1.0]);

            result.push([1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, -1.0, 0.0, 1.0]);
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP => {
            result.push([-1.0, 1.0, 0.0, 1.0]);
            result.push([-1.0, -1.0, 0.0, 1.0]);
            result.push([1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, -1.0, 0.0, 1.0]);
        }
        vk::PrimitiveTopology::TRIANGLE_FAN => {
            result.push([-1.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, -1.0, 0.0, 1.0]);
        }
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
            for y in 0..height {
                let yy = row(y);
                result.push([-2.0, yy, 0.0, 1.0]);
                result.push([-1.0, yy, 0.0, 1.0]);
                result.push([1.0, yy, 0.0, 1.0]);
                result.push([2.0, yy, 0.0, 1.0]);
            }
        }
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
            result.push([-10.0, -10.0, 0.0, 1.0]);

            for y in 0..height {
                let yy = row(y);

                if y % 2 == 0 {
                    result.push([-2.0, yy, 0.0, 1.0]);
                    result.push([2.0, yy, 0.0, 1.0]);
                } else {
                    result.push([2.0, yy, 0.0, 1.0]);
                    result.push([-2.0, yy, 0.0, 1.0]);
                }
            }

            result.push([10.0, 10.0, 0.0, 1.0]);
        }
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
            result.push([-1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, 3.0, 0.0, 1.0]);
            result.push([1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, -1.0, 0.0, 1.0]);
            result.push([-3.0, -1.0, 0.0, 1.0]);

            result.push([-1.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, 1.0, 0.0, 1.0]);
            result.push([3.0, 1.0, 0.0, 1.0]);
            result.push([1.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, -3.0, 0.0, 1.0]);
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
            result.push([-1.0, 1.0, 0.0, 1.0]);
            result.push([1.0, 3.0, 0.0, 1.0]);
            result.push([1.0, 1.0, 0.0, 1.0]);
            result.push([-3.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, -1.0, 0.0, 1.0]);
            result.push([3.0, 1.0, 0.0, 1.0]);
            result.push([1.0, -1.0, 0.0, 1.0]);
            result.push([-1.0, -3.0, 0.0, 1.0]);
        }
        _ => unreachable!("Unknown topology"),
    }

    if params.clip_vertices {
        for vertex in &mut result {
            vertex[1] *= 2.0;
        }
    }

    result
}

/// `FragmentShadingBarycentricDataTestInstance::verify` - no pixel may differ from the expected mask.
fn verify(params: &DataParams, result_bytes: &[u8]) -> bool {
    let components = params.component_count();
    let expected_per_vertex = (1u32 << components) - 1;
    let expected_interpolated = (1u32 << (components / 3)) - 1;
    let expected_flat = (1u32 << (components / 3)) - 1;
    let expected = if params.subtype == TestSubtype::PerVertexCorrectness {
        [10u32; 4]
    } else {
        [
            expected_per_vertex,
            if params.test_with_interpolation {
                expected_interpolated
            } else {
                0
            },
            if params.test_with_flat_interpolation {
                expected_flat
            } else {
                0
            },
            0,
        ]
    };

    let pixel_count = (DATA_TEST_WIDTH * DATA_TEST_HEIGHT) as usize;
    let failures = result_bytes[..pixel_count * 16]
        .chunks_exact(16)
        .filter(|pixel| {
            let retrieved: [u32; 4] =
                std::array::from_fn(|i| u32::from_ne_bytes(pixel[i * 4..i * 4 + 4].try_into().expect("four bytes")));
            retrieved != expected
        })
        .count();

    failures == 0
}

/// `FragmentShadingBarycentricDataTestInstance::getProvokingVertexLast`
fn get_provoking_vertex_last(context: &Context<'_>, params: &DataParams) -> bool {
    if params.provoking_vertex_last
        && params.topology == vk::PrimitiveTopology::TRIANGLE_STRIP
        && fragment_shader_barycentric_properties(context).tri_strip_vertex_order_independent_of_provoking_vertex
            != vk::FALSE
    {
        return false;
    }

    params.provoking_vertex_last
}

/// `FragmentShadingBarycentricDataTestInstance::iterate`
fn data_iterate<'a>(context: &'a Context<'a>, params: &DataParams) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let pixel_size = 16usize;
    let width = DATA_TEST_WIDTH;
    let height = DATA_TEST_HEIGHT;
    let use_mesh_shader = params.use_mesh_shader;
    let provoking_vertex_last = get_provoking_vertex_last(context, params);
    let has_tess = matches!(params.subtype, TestSubtype::TessShader | TestSubtype::TessGeomShader);
    let has_geom = matches!(
        params.subtype,
        TestSubtype::GeometryShader | TestSubtype::TessGeomShader
    );

    let vertices = generate_vertex_buffer(params);
    let vertex_count = vertices.len() as u32;
    let vertex_buffer = create_vertex_buffer(context, &vertices, use_mesh_shader)?;

    let image = ImageWithMemory::new(
        device,
        allocator,
        make_image_create_info(FORMAT, width, height, vk::SampleCountFlags::_1),
        MemoryRequirement::ANY,
    )?;
    let image_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D, FORMAT, image_srr)?;

    let result_usage = if use_mesh_shader {
        vk::BufferUsageFlags::UNIFORM_BUFFER | vk::BufferUsageFlags::TRANSFER_DST
    } else {
        vk::BufferUsageFlags::TRANSFER_DST
    };
    let result_buffer_size = (width as usize * height as usize * pixel_size) as vk::DeviceSize;
    let result_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(result_buffer_size, result_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let shader_suffix = if provoking_vertex_last == params.provoking_vertex_last {
        ""
    } else {
        "-forced"
    };
    let binaries = context.get_binary_collection();
    let module = create_shader_module(
        device,
        binaries.get(&format!(
            "{}{shader_suffix}",
            if use_mesh_shader { "mesh" } else { "vert" }
        ))?,
    )?;
    let tess_ctrl_module = if has_tess {
        Some(create_shader_module(
            device,
            binaries.get(&format!("tess_ctrl{shader_suffix}"))?,
        )?)
    } else {
        None
    };
    let tess_eval_module = if has_tess {
        Some(create_shader_module(
            device,
            binaries.get(&format!("tess_eval{shader_suffix}"))?,
        )?)
    } else {
        None
    };
    let geometry_module = if has_geom {
        Some(create_shader_module(
            device,
            binaries.get(&format!("geom{shader_suffix}"))?,
        )?)
    } else {
        None
    };
    let frag_module = create_shader_module(device, binaries.get(&format!("frag{shader_suffix}"))?)?;

    let render_pass = make_render_pass(device, FORMAT, vk::SampleCountFlags::_1)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*image_view], width, height, 1)?;

    let push_constants: [u32; 3] = [0, 1, 2];
    let push_constant_bytes: Vec<u8> = push_constants.iter().flat_map(|value| value.to_ne_bytes()).collect();
    let push_constant_ranges = [vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::FRAGMENT,
        offset: 0,
        size: push_constant_bytes.len() as u32,
    }];

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

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

    let set_layouts: Vec<vk::DescriptorSetLayout> =
        mesh_descriptors.iter().map(|(set_layout, _, _)| **set_layout).collect();
    let mut layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
    if params.dynamic_indexing {
        layout_info = layout_info.push_constant_ranges(&push_constant_ranges);
    }
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let mut state = DrawPipelineState::new(params.topology).with_full_viewport(width, height);
    if !use_mesh_shader {
        state = state.with_position_input();
    }
    state.rasterization = default_rasterization_state();
    state.rasterization.cull_mode = vk::CullModeFlags::NONE;
    state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
    state.rasterization.depth_bias_enable = vk::FALSE;
    state.rasterization.line_width = 1.0;
    state.construction = params.construction;
    if provoking_vertex_last {
        state.provoking_vertex_mode = Some(vk::ProvokingVertexModeEXT::LAST_VERTEX);
    }
    if has_tess {
        state.patch_control_points = Some(3);
    }
    let mut stages: Vec<(vk::ShaderStageFlags, vk::ShaderModule)> = vec![(
        if use_mesh_shader {
            vk::ShaderStageFlags::MESH_EXT
        } else {
            vk::ShaderStageFlags::VERTEX
        },
        *module,
    )];
    if let (Some(tess_ctrl_module), Some(tess_eval_module)) = (&tess_ctrl_module, &tess_eval_module) {
        stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tess_ctrl_module));
        stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tess_eval_module));
    }
    if let Some(geometry_module) = &geometry_module {
        stages.push((vk::ShaderStageFlags::GEOMETRY, **geometry_module));
    }
    stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
    let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

    let group_count = if params.topology == vk::PrimitiveTopology::POINT_LIST {
        (4, 4, 4)
    } else {
        (1, 1, 1)
    };

    begin_command_buffer(device, cmd)?;
    unsafe {
        let initial_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            image.get(),
            image_srr,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[initial_barrier],
        );

        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue { uint32: [0, 0, 0, 1] },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(width, height))
            .clear_values(&clear_values);
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

        if params.dynamic_indexing {
            device.cmd_push_constants(
                cmd,
                *pipeline_layout,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &push_constant_bytes,
            );
        }

        if use_mesh_shader {
            device.cmd_draw_mesh_tasks_ext(cmd, group_count.0, group_count.1, group_count.2);
        } else {
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(device, cmd, image.get(), result_buffer.get(), width, height);
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, result_buffer.get_allocation())?;
    let result_bytes = unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr().cast_const(),
            result_buffer_size as usize,
        )
    };

    if verify(params, result_bytes) {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

fn data_params(topology: vk::PrimitiveTopology, aggregate: u32, data_type: (&str, u32, ScalarKind)) -> DataParams {
    DataParams {
        subtype: TestSubtype::Default,
        topology,
        dynamic_indexing: false,
        aggregate,
        scalar_size: data_type.1,
        double: data_type.2 == ScalarKind::Double,
        provoking_vertex_last: false,
        test_with_interpolation: false,
        test_with_flat_interpolation: false,
        clip_vertices: false,
        use_mesh_shader: false,
        construction: PipelineConstructionType::Monolithic,
    }
}

fn aggregate_name(aggregate: u32) -> &'static str {
    match aggregate {
        0 => "type",
        1 => "struct",
        _ => "array2",
    }
}

fn find_programs(programs: &HashMap<&'static str, BinaryCollection>, name: &str) -> BinaryCollection {
    *programs
        .get(name)
        .unwrap_or_else(|| panic!("the manifest has no case {name}"))
}

/// The `data` child of `createTests`.
pub fn create_data_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let programs: HashMap<&'static str, BinaryCollection> = ALL_BARY_DATA_PROGRAMS
        .iter()
        .map(|entry| (entry.name, entry.programs))
        .collect();
    let provoking_vertices = [("provoking_first", false), ("provoking_last", true)];
    let dynamic_indexings = [("static", false), ("dynamic", true)];
    let clip_vertices_specs = [("no_clip", false), ("clip", true)];
    let interpolation_types = [
        ("per_vertex", false, false),
        ("per_vertex_interp", true, false),
        ("per_vertex_flat", false, true),
    ];
    let use_mesh_shader_specs = [("mesh_shader", true), ("vertex_shader", false)];

    let mut test_type_group = TestCaseGroup::new("data");

    for (provoking_name, provoking_vertex_last) in provoking_vertices {
        let mut provoking_vertex_group = TestCaseGroup::new(provoking_name);

        for (dynamic_name, dynamic_indexing) in dynamic_indexings {
            let mut dynamic_indexing_group = TestCaseGroup::new(dynamic_name);

            for (topology, topology_name) in TOPOLOGIES {
                let mut topology_group = TestCaseGroup::new(topology_name);

                for (clip_name, clip_vertices) in clip_vertices_specs {
                    let mut clip_vertices_group = TestCaseGroup::new(clip_name);

                    if clip_vertices && topology != vk::PrimitiveTopology::TRIANGLE_LIST {
                        continue;
                    }

                    for aggregate in 0..3u32 {
                        let mut aggregate_group = TestCaseGroup::new(aggregate_name(aggregate));

                        for data_type in DATA_TYPES {
                            let mut data_type_group = TestCaseGroup::new(data_type.0);

                            for (interpolation_name, with_interpolation, with_flat_interpolation) in interpolation_types
                            {
                                let mut interpolation_type_group = TestCaseGroup::new(interpolation_name);

                                if with_interpolation && data_type.2 != ScalarKind::Float {
                                    // Integer and double inputs must be qualified as flat, they cannot be interpolated.
                                    continue;
                                }

                                for (mesh_name, use_mesh_shader) in use_mesh_shader_specs {
                                    if use_mesh_shader
                                        && !matches!(
                                            topology,
                                            vk::PrimitiveTopology::POINT_LIST
                                                | vk::PrimitiveTopology::LINE_LIST
                                                | vk::PrimitiveTopology::TRIANGLE_LIST
                                        )
                                    {
                                        continue;
                                    }

                                    let params = DataParams {
                                        dynamic_indexing,
                                        provoking_vertex_last,
                                        test_with_interpolation: with_interpolation,
                                        test_with_flat_interpolation: with_flat_interpolation,
                                        clip_vertices,
                                        use_mesh_shader,
                                        construction,
                                        ..data_params(topology, aggregate, data_type)
                                    };
                                    let path = [
                                        provoking_name,
                                        dynamic_name,
                                        topology_name,
                                        clip_name,
                                        aggregate_name(aggregate),
                                        data_type.0,
                                        interpolation_name,
                                        mesh_name,
                                    ]
                                    .join("__");
                                    let case_programs = find_programs(&programs, &path);
                                    interpolation_type_group.add_child(Box::new(DataCase {
                                        name: mesh_name.to_string(),
                                        params,
                                        programs: case_programs,
                                    })
                                        as Box<dyn TestCase>);
                                }

                                data_type_group.add_child(interpolation_type_group);
                            }
                            aggregate_group.add_child(data_type_group);
                        }

                        clip_vertices_group.add_child(aggregate_group);
                    }
                    topology_group.add_child(clip_vertices_group);
                }

                dynamic_indexing_group.add_child(topology_group);
            }

            provoking_vertex_group.add_child(dynamic_indexing_group);
        }

        test_type_group.add_child(provoking_vertex_group);
    }

    {
        let mut misc_group = TestCaseGroup::new("misc");
        let params = DataParams {
            subtype: TestSubtype::PerVertexCorrectness,
            scalar_size: 2,
            construction,
            ..data_params(vk::PrimitiveTopology::TRIANGLE_LIST, 0, ("vec2", 2, ScalarKind::Float))
        };
        misc_group.add_child(Box::new(DataCase {
            name: "pervertex_correctness".to_string(),
            params,
            programs: find_programs(&programs, "misc__pervertex_correctness"),
        }) as Box<dyn TestCase>);
        test_type_group.add_child(misc_group);
    }

    {
        let mut shader_combos_group = TestCaseGroup::new("shader_combos");
        let combos = [
            (
                TestSubtype::TessShader,
                "with_tess_shader",
                vk::PrimitiveTopology::PATCH_LIST,
            ),
            (
                TestSubtype::GeometryShader,
                "with_geom_shader",
                vk::PrimitiveTopology::TRIANGLE_LIST,
            ),
            (
                TestSubtype::TessGeomShader,
                "with_tess_geom_shader",
                vk::PrimitiveTopology::PATCH_LIST,
            ),
        ];
        for (subtype, combo_name, topology) in combos {
            let mut combo_group = TestCaseGroup::new(combo_name);

            for aggregate in 0..3u32 {
                let mut aggregate_group = TestCaseGroup::new(aggregate_name(aggregate));

                for data_type in DATA_TYPES {
                    let params = DataParams {
                        subtype,
                        construction,
                        ..data_params(topology, aggregate, data_type)
                    };
                    let path = ["shader_combos", combo_name, aggregate_name(aggregate), data_type.0].join("__");
                    aggregate_group.add_child(Box::new(DataCase {
                        name: data_type.0.to_string(),
                        params,
                        programs: find_programs(&programs, &path),
                    }) as Box<dyn TestCase>);
                }
                combo_group.add_child(aggregate_group);
            }
            shader_combos_group.add_child(combo_group);
        }
        test_type_group.add_child(shader_combos_group);
    }

    test_type_group
}
