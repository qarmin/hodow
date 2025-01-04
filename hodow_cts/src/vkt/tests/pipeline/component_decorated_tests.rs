// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineShaderComponentDecoratedLayoutMatchingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic pipeline construction type exists. The shaders `genCode` builds per case
// are written out by scripts/gen_component_decorated_manifest.py, and a case finds them in the manifest by its test path joined with `__`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_component_decorated::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;
const FRAMEBUFFER_SIZE: u32 = 16;

/// `Types`: what one component slot of a location holds.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Types {
    Scalar,
    Vec2,
    Vec3,
    None,
}

/// `Components::testName`
fn components_test_name(types: &[Types; 4]) -> String {
    let names: Vec<&str> = types
        .iter()
        .filter_map(|ty| match ty {
            Types::Scalar => Some("scalar"),
            Types::Vec2 => Some("vec2"),
            Types::Vec3 => Some("vec3"),
            Types::None => None,
        })
        .collect();
    names.join("_")
}

/// `Flow`: which stages the pipeline has between the vertex and fragment shaders.
#[derive(Clone, Copy)]
struct Flow {
    name: &'static str,
    tessellation: bool,
    geometry: bool,
}

struct ComponentDecoratedCase {
    name: String,
    path_name: String,
    flow: Flow,
    width: u32,
}

impl TestCase for ComponentDecoratedCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ShaderComponentDecoratedIterfaceMatchingTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let features = context.get_device_features();

        let format_props = unsafe { instance.get_physical_device_format_properties(physical_device, FORMAT) };
        let required = vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
        if !format_props.optimal_tiling_features.contains(required) {
            return Err(TestError::NotSupported(
                "Required color image features not supported".to_string(),
            ));
        }

        if self.flow.tessellation && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }

        if self.flow.geometry && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }

        if self.width == 16 {
            let mut features11 = vk::PhysicalDeviceVulkan11Features::default();
            let mut features12 = vk::PhysicalDeviceVulkan12Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut features11)
                .push_next(&mut features12);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if features12.shader_float16 == vk::FALSE || features11.storage_input_output16 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "16-bit floats not supported in shader code".to_string(),
                ));
            }
        }

        if self.width == 64 && features.shader_float64 == vk::FALSE {
            return Err(TestError::NotSupported(
                "Double-precision floats not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.path_name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.path_name))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ComponentDecoratedInstance {
            context,
            flow: self.flow,
        })
    }
}

struct ComponentDecoratedInstance<'a> {
    context: &'a Context<'a>,
    flow: Flow,
}

impl TestInstance for ComponentDecoratedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let size = FRAMEBUFFER_SIZE;

        let color_buffer = ImageWithBuffer::new(
            context,
            size,
            size,
            FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            16,
        )?;
        let render_pass = make_color_render_pass(
            device,
            FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], size, size, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let tesc_module = if self.flow.tessellation {
            Some(create_shader_module(device, binaries.get("tesc")?)?)
        } else {
            None
        };
        let tese_module = if self.flow.tessellation {
            Some(create_shader_module(device, binaries.get("tese")?)?)
        } else {
            None
        };
        let geom_module = if self.flow.geometry {
            Some(create_shader_module(device, binaries.get("geom")?)?)
        } else {
            None
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let (Some(tesc), Some(tese)) = (&tesc_module, &tese_module) {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese));
        }
        if let Some(geom) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geom));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

        let topology = if self.flow.tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let mut state = DrawPipelineState::new(topology)
            .with_position_input()
            .with_full_viewport(size, size);
        state.rasterization.cull_mode = vk::CullModeFlags::NONE;
        state.rasterization.front_face = vk::FrontFace::CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        if self.flow.tessellation {
            state.patch_control_points = Some(3);
        }
        let mut shader_object_stages = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
        if self.flow.tessellation {
            shader_object_stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"));
            shader_object_stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"));
        }
        if self.flow.geometry {
            shader_object_stages.push((vk::ShaderStageFlags::GEOMETRY, "geom"));
        }
        shader_object_stages.push((vk::ShaderStageFlags::FRAGMENT, "frag"));
        let shader_objects = make_shader_objects_stages(context, &shader_object_stages, &[], &[])?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?)
        };

        let vertices: [[f32; 4]; 6] = [
            [-1.0, 1.0, 0.0, 0.0],
            [-1.0, -1.0, 0.0, 0.0],
            [1.0, -1.0, 0.0, 0.0],
            [1.0, -1.0, 0.0, 0.0],
            [1.0, 1.0, 0.0, 0.0],
            [-1.0, 1.0, 0.0, 0.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color([0.5, -1.0, 0.625, 1.0])];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(size, size),
            &clear_values,
            &[(color_buffer.image.get(), *color_buffer.view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            size,
            size,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // `verifyResult`: every pixel is exactly (0.125, 0.25, 0.5, 1.0).
        let reference = [0.125f32, 0.25, 0.5, 1.0];
        let result = color_buffer.read_bytes(device)?;
        for y in 0..size {
            for x in 0..size {
                let offset = ((y * size + x) * 16) as usize;
                let pixel: Vec<f32> = (0..4)
                    .map(|c| f32::from_ne_bytes(result[offset + c * 4..offset + c * 4 + 4].try_into().unwrap()))
                    .collect();
                if pixel != reference {
                    return Ok(TestStatus::fail(format!(
                        "First mismatch at ({x},{y}); Expected: {reference:?}, got: {pixel:?}"
                    )));
                }
            }
        }

        Ok(TestStatus::pass(""))
    }
}

/// `createShaderCompDecorLayoutMatchingTests`
pub fn create_shader_comp_decor_layout_matching_tests() -> TestCaseGroup {
    let mode_names = ["loose_var", "in_block"];
    let widths = [(64u32, "float64"), (32, "float32"), (16, "float16")];
    let component_series: [([Types; 4], &[u32]); 9] = [
        ([Types::Scalar, Types::Scalar, Types::Scalar, Types::Scalar], &[16, 32]),
        ([Types::Scalar, Types::Scalar, Types::Vec2, Types::None], &[16, 32]),
        ([Types::Scalar, Types::Vec2, Types::None, Types::Scalar], &[16, 32]),
        ([Types::Vec2, Types::None, Types::Scalar, Types::Scalar], &[16, 32]),
        ([Types::Scalar, Types::Vec3, Types::None, Types::None], &[16, 32]),
        ([Types::Vec3, Types::None, Types::None, Types::Scalar], &[16, 32]),
        ([Types::Vec2, Types::None, Types::Vec2, Types::None], &[16, 32]),
        ([Types::Scalar, Types::None, Types::Scalar, Types::None], &[64]),
        ([Types::Vec2, Types::None, Types::None, Types::None], &[64]),
    ];
    let flows = [
        Flow {
            name: "vert_frag",
            tessellation: false,
            geometry: false,
        },
        Flow {
            name: "vert_geom_frag",
            tessellation: false,
            geometry: true,
        },
        Flow {
            name: "vert_tesc_tese_frag",
            tessellation: true,
            geometry: false,
        },
        Flow {
            name: "vert_tesc_tese_geom_frag",
            tessellation: true,
            geometry: true,
        },
    ];
    let location_counts = [(0u32, "single_location"), (3, "multiple_locations")];

    let mut group_root = TestCaseGroup::new("shader_layout_component_matching");
    for flow in flows {
        let mut group_flow = TestCaseGroup::new(flow.name);
        for &mode_name in &mode_names {
            let mut group_mode = TestCaseGroup::new(mode_name);
            for &(width, width_name) in &widths {
                let mut group_size = TestCaseGroup::new(width_name);
                for &(_, loc_name) in &location_counts {
                    let mut group_loc_count = TestCaseGroup::new(loc_name);
                    for (components, series_widths) in &component_series {
                        if !series_widths.contains(&width) {
                            continue;
                        }

                        let test_name = components_test_name(components);
                        let path_name = [flow.name, mode_name, width_name, loc_name, &test_name].join("__");
                        let case: Box<dyn TestCase> = Box::new(ComponentDecoratedCase {
                            name: test_name,
                            path_name,
                            flow,
                            width,
                        });
                        group_loc_count.add_child(case);
                    }
                    group_size.add_child(group_loc_count);
                }
                group_mode.add_child(group_size);
            }
            group_flow.add_child(group_mode);
        }
        group_root.add_child(group_flow);
    }

    group_root
}
