// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawNonLineTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Drawing things that are not lines twice, once without and once with a VkPipelineRasterizationLineStateCreateInfo
// chained into the rasterization state: the two images must be identical.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::draw_non_line::NON_LINE;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{ChannelOrder, ChannelType, Random, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexTopology {
    Triangles = 0,
    Lines,
    Points,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum GeometryOutput {
    None = 0, // No geometry shader
    Triangles,
    Lines,
    Points,
}

/// `toPrimitiveTopology`
fn to_primitive_topology(topology: VertexTopology) -> vk::PrimitiveTopology {
    match topology {
        VertexTopology::Triangles => vk::PrimitiveTopology::TRIANGLE_LIST,
        VertexTopology::Lines => vk::PrimitiveTopology::LINE_LIST,
        VertexTopology::Points => vk::PrimitiveTopology::POINT_LIST,
    }
}

#[derive(Clone, Copy)]
struct Params {
    vertex_topology: VertexTopology,
    geometry_output: GeometryOutput,
    polygon_mode: vk::PolygonMode,
    line_rasterization_mode: vk::LineRasterizationMode,
}

impl Params {
    fn use_geometry_shader(&self) -> bool {
        self.geometry_output != GeometryOutput::None
    }

    fn get_vertex_output_length(&self) -> u32 {
        match self.vertex_topology {
            VertexTopology::Triangles => 3,
            VertexTopology::Lines => 2,
            VertexTopology::Points => 1,
        }
    }

    /// The name `initPrograms`' geometry shader has in the manifest - it depends on the input and the output only.
    fn geometry_program_name(&self) -> &'static str {
        match (self.vertex_topology, self.geometry_output) {
            (VertexTopology::Triangles, GeometryOutput::Triangles) => "geom_triangles_triangles",
            (VertexTopology::Triangles, GeometryOutput::Points) => "geom_triangles_points",
            (VertexTopology::Lines, GeometryOutput::Triangles) => "geom_lines_triangles",
            (VertexTopology::Lines, GeometryOutput::Points) => "geom_lines_points",
            (VertexTopology::Points, GeometryOutput::Triangles) => "geom_points_triangles",
            (VertexTopology::Points, GeometryOutput::Points) => "geom_points_points",
            _ => unreachable!("no geometry shader for this combination"),
        }
    }

    fn get_random_seed(&self) -> u32 {
        // We exclude the line rasterization mode on purpose.
        (1u32 << 24)
            | ((self.vertex_topology as u32) << 16)
            | ((self.geometry_output as u32) << 8)
            | self.polygon_mode.as_raw() as u32
    }
}

struct NonLineDrawCase {
    name: String,
    params: Params,
}

impl TestCase for NonLineDrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let features = context.get_device_features();

        if params.use_geometry_shader() && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: geometryShader".to_string(),
            ));
        }

        let mut line_raster_features = vk::PhysicalDeviceLineRasterizationFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut line_raster_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };

        let required_feature = match params.line_rasterization_mode {
            vk::LineRasterizationMode::RECTANGULAR => line_raster_features.rectangular_lines,
            vk::LineRasterizationMode::BRESENHAM => line_raster_features.bresenham_lines,
            vk::LineRasterizationMode::RECTANGULAR_SMOOTH => line_raster_features.smooth_lines,
            _ => unreachable!("line rasterization mode not used by the test"),
        };

        if required_feature == vk::FALSE {
            return Err(TestError::NotSupported("Required line type not supported".to_string()));
        }

        if params.polygon_mode != vk::PolygonMode::FILL && features.fill_mode_non_solid == vk::FALSE {
            return Err(TestError::NotSupported(
                "Required polygon mode not supported".to_string(),
            ));
        }

        if params.use_geometry_shader() && features.shader_tessellation_and_geometry_point_size == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: shaderTessellationAndGeometryPointSize".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NON_LINE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NonLineDrawInstance {
            context,
            params: self.params,
        })
    }
}

struct NonLineDrawInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for NonLineDrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = (32u32, 32u32);
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let threshold = [0.0f32; 4]; // We expect rasterization to produce the same result in both cases.
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let iterations = 2usize;
        let vert_out_len = params.get_vertex_output_length();
        let quadrant_vtx = 6u32;

        // Color buffers with verification buffer.
        let mut color_buffers = Vec::new();
        for _ in 0..iterations {
            color_buffers.push(ImageWithBuffer::new(
                context,
                fb_extent.0,
                fb_extent.1,
                fb_format,
                fb_usage,
                4,
            )?);
        }

        // Generate vertices per quadrant, grouping colors by primitive.
        let color_catalogue = [
            [0.0f32, 0.0, 1.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let quadrant_offsets = [[-1.0f32, -1.0], [0.0, -1.0], [-1.0, 0.0], [0.0, 0.0]];

        let mut rnd = Random::new(params.get_random_seed());
        let mut vertices: Vec<[f32; 8]> = Vec::with_capacity(quadrant_offsets.len() * quadrant_vtx as usize);

        let mut current_color = clear_color;
        for q_offset in quadrant_offsets {
            for i in 0..quadrant_vtx {
                // Switch color when starting new pritimive.
                if i % vert_out_len == 0 {
                    current_color = color_catalogue[rnd.get_int(0, color_catalogue.len() as i32 - 1) as usize];
                }

                let x = rnd.get_float();
                let y = rnd.get_float();
                let position = [x + q_offset[0], y + q_offset[1], 0.0, 1.0];

                vertices.push([
                    position[0],
                    position[1],
                    position[2],
                    position[3],
                    current_color[0],
                    current_color[1],
                    current_color[2],
                    current_color[3],
                ]);
            }
        }

        // Vertex buffer
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let render_pass = make_render_pass(device, fb_format)?;

        let mut framebuffers = Vec::new();
        for color_buffer in &color_buffers {
            framebuffers.push(make_framebuffer(
                device,
                *render_pass,
                &[*color_buffer.view],
                fb_extent.0,
                fb_extent.1,
                1,
            )?);
        }

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let geom_module = if params.use_geometry_shader() {
            Some(create_shader_module(
                device,
                binaries.get(params.geometry_program_name())?,
            )?)
        } else {
            None
        };
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut pipelines = Vec::new();
        for i in 0..iterations {
            let mut state = DrawPipelineState::new(to_primitive_topology(params.vertex_topology))
                .with_full_viewport(fb_extent.0, fb_extent.1);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 32,
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
                    offset: 16,
                },
            ];
            state.rasterization.polygon_mode = params.polygon_mode;
            state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
            state.rasterization.depth_bias_enable = vk::FALSE;
            // Critical for the test: draw first without line drawing parameters, draw second with line drawing params.
            if i > 0 {
                state.line_rasterization_mode = Some(params.line_rasterization_mode);
            }

            let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
            if let Some(geom) = &geom_module {
                stages.push((vk::ShaderStageFlags::GEOMETRY, **geom));
            }
            stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
            pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_holder = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_holder;

        begin_command_buffer(device, cmd_buffer)?;
        for i in 0..iterations {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_pass,
                *framebuffers[i],
                rect_2d(fb_extent.0, fb_extent.1),
                clear_value_color(clear_color),
            );
            unsafe {
                device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipelines[i]);
                device.cmd_draw(cmd_buffer, vertices.len() as u32, 1, 0, 0);
            }
            end_render_pass(device, cmd_buffer);
        }
        for color_buffer in &color_buffers {
            copy_image_to_buffer(
                device,
                cmd_buffer,
                color_buffer.image.get(),
                color_buffer.buffer.get(),
                fb_extent.0,
                fb_extent.1,
            );
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify the result of both draws is identical.
        let reference_access = ConstPixelBufferAccess::new(
            tcu_format,
            [fb_extent.0, fb_extent.1, 1],
            color_buffers[0].read_bytes(device)?,
        );
        let result_access = ConstPixelBufferAccess::new(
            tcu_format,
            [fb_extent.0, fb_extent.1, 1],
            color_buffers[1].read_bytes(device)?,
        );

        if !float_threshold_compare(&reference_access, &result_access, threshold).ok {
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDrawNonLineTests`
pub fn create_draw_non_line_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("non_line_with_params");

    let vertex_topology_cases = [
        (VertexTopology::Triangles, "vtx_triangles"),
        (VertexTopology::Lines, "vtx_lines"),
        (VertexTopology::Points, "vtx_points"),
    ];
    let geometry_output_cases = [
        (GeometryOutput::None, ""),
        (GeometryOutput::Triangles, "_geom_triangles"),
        (GeometryOutput::Lines, "_geom_lines"),
        (GeometryOutput::Points, "_geom_points"),
    ];
    let polygon_mode_cases = [
        (vk::PolygonMode::FILL, "_mode_fill"),
        (vk::PolygonMode::LINE, "_mode_line"),
        (vk::PolygonMode::POINT, "_mode_point"),
    ];
    let line_raster_mode_cases = [
        (vk::LineRasterizationMode::RECTANGULAR, "_line_raster_rect"),
        (vk::LineRasterizationMode::BRESENHAM, "_line_raster_bresenham"),
        (vk::LineRasterizationMode::RECTANGULAR_SMOOTH, "_line_raster_smooth"),
    ];

    for (vertex_topology, vertex_topology_name) in vertex_topology_cases {
        for (geometry_output, geometry_suffix) in geometry_output_cases {
            for (polygon_mode, polygon_suffix) in polygon_mode_cases {
                for (line_raster_mode, line_suffix) in line_raster_mode_cases {
                    let produces_lines = geometry_output == GeometryOutput::Lines
                        || (geometry_output == GeometryOutput::None && vertex_topology == VertexTopology::Lines);
                    let produces_triangles = geometry_output == GeometryOutput::Triangles
                        || (geometry_output == GeometryOutput::None && vertex_topology == VertexTopology::Triangles);

                    // These cases rasterize lines, so we must skip because rendering may be different depending on the line rasterization parameters.
                    if produces_lines || (produces_triangles && polygon_mode == vk::PolygonMode::LINE) {
                        break;
                    }

                    let params = Params {
                        vertex_topology,
                        geometry_output,
                        polygon_mode,
                        line_rasterization_mode: line_raster_mode,
                    };
                    let test_name = format!("{vertex_topology_name}{geometry_suffix}{polygon_suffix}{line_suffix}");
                    main_group.add_child(Box::new(NonLineDrawCase {
                        name: test_name,
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }
    main_group
}
