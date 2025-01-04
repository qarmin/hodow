// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMaxVaryingsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. Upstream assembles its shaders as SPIR-V text and quotes
// the GLSL they came from; the manifest compiles that GLSL instead (the SPIR-V version, 1.3, is the toolchain's default here).
//
// Writes the most varyings a stage can output (or the fragment shader can take) as an array whose size is a specialization
// constant, and checks the fragment shader read back every value.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_max_varyings::{
    MAX_VARYINGS_GEOMETRY_OUT, MAX_VARYINGS_TESS_EVAL_OUT, MAX_VARYINGS_VERTEX_OUT,
};
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
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages_specialized};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;
const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Vertex,
    TessEval,
    Geometry,
    Fragment,
}

impl Stage {
    /// `getShaderStageName`
    fn name(self) -> &'static str {
        match self {
            Stage::Vertex => "vertex",
            Stage::TessEval => "tess_eval",
            Stage::Geometry => "geometry",
            Stage::Fragment => "fragment",
        }
    }
}

/// `MaxVaryingsParam`
#[derive(Clone, Copy)]
struct MaxVaryingsParam {
    output_stage: Stage,
    input_stage: Stage,
    stage_to_stress_io: Stage,
}

struct MaxVaryingsCase {
    name: String,
    param: MaxVaryingsParam,
}

/// `getMaxIOComponents`
fn get_max_io_components(input: bool, stage: Stage, limits: &vk::PhysicalDeviceLimits) -> i32 {
    match stage {
        Stage::Vertex => {
            debug_assert!(!input);
            (limits.max_vertex_output_components / 4) as i32 - 1
        }
        Stage::TessEval => {
            if input {
                (limits.max_tessellation_evaluation_input_components / 4) as i32
            } else {
                (limits.max_tessellation_evaluation_output_components / 4) as i32 - 1
            }
        }
        Stage::Geometry => {
            if input {
                (limits.max_geometry_input_components / 4) as i32
            } else {
                (limits.max_geometry_output_components / 4) as i32 - 1
            }
        }
        Stage::Fragment => {
            debug_assert!(input);
            (limits.max_fragment_input_components / 4) as i32
        }
    }
}

impl TestCase for MaxVaryingsCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `supportedCheck`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let param = self.param;
        let features = context.get_device_features();
        let limits = &context.get_device_properties().limits;

        let uses_tessellation = param.input_stage == Stage::TessEval || param.output_stage == Stage::TessEval;
        if uses_tessellation && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Device does not support tessellation shaders".to_string(),
            ));
        }

        if (param.input_stage == Stage::Geometry || param.output_stage == Stage::Geometry)
            && features.geometry_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Device does not support geometry shaders".to_string(),
            ));
        }

        // Throw unsupported if the data sizes do not allow the case to be tested.
        let fragment_inputs = limits.max_fragment_input_components;
        let output_components = |stage: Stage| match stage {
            Stage::Vertex => limits.max_vertex_output_components,
            Stage::TessEval => limits.max_tessellation_evaluation_output_components,
            Stage::Geometry => limits.max_geometry_output_components,
            Stage::Fragment => unreachable!("the fragment stage has no outputs here"),
        };
        let stage_label = |stage: Stage| match stage {
            Stage::Vertex => "VS",
            Stage::TessEval => "TES",
            Stage::Geometry => "GS",
            Stage::Fragment => "FS",
        };

        if param.stage_to_stress_io != Stage::Fragment {
            let outputs = output_components(param.stage_to_stress_io);
            if param.input_stage == Stage::Fragment && fragment_inputs < outputs.saturating_sub(4) {
                return Err(TestError::NotSupported(format!(
                    "Device supports smaller number of FS inputs ({fragment_inputs}) than {} outputs ({outputs} - 4 built-ins)",
                    stage_label(param.stage_to_stress_io)
                )));
            }
        } else {
            debug_assert!(param.input_stage == Stage::Fragment);
            let outputs = output_components(param.output_stage);
            if outputs.saturating_sub(4) < fragment_inputs {
                return Err(TestError::NotSupported(format!(
                    "Device supports smaller number of {} outputs ({outputs} - 4 built-ins) than FS inputs ({fragment_inputs})",
                    stage_label(param.output_stage)
                )));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.param.output_stage {
            Stage::Vertex => MAX_VARYINGS_VERTEX_OUT.programs,
            Stage::TessEval => MAX_VARYINGS_TESS_EVAL_OUT.programs,
            _ => MAX_VARYINGS_GEOMETRY_OUT.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaxVaryingsInstance {
            context,
            param: self.param,
        })
    }
}

struct MaxVaryingsInstance<'a> {
    context: &'a Context<'a>,
    param: MaxVaryingsParam,
}

impl TestInstance for MaxVaryingsInstance<'_> {
    /// `test`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let param = self.param;
        let device = context.get_device();
        let limits = &context.get_device_properties().limits;

        let color_image = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            IMAGE_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        let vertices: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let max_output = get_max_io_components(false, param.output_stage, limits);
        let max_input = get_max_io_components(true, param.input_stage, limits);
        let data = max_output.min(max_input);
        debug_assert!(data != 0);

        log::info!(
            "Testing {} input components for stage {}",
            data * 4,
            param.stage_to_stress_io.name()
        );

        let render_pass = make_color_render_pass(
            device,
            IMAGE_FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_image.view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let uses_tessellation = param.input_stage == Stage::TessEval || param.output_stage == Stage::TessEval;
        let uses_geometry = param.input_stage == Stage::Geometry || param.output_stage == Stage::Geometry;
        let tess_modules = if uses_tessellation {
            Some((
                create_shader_module(device, binaries.get("tcs")?)?,
                create_shader_module(device, binaries.get("tes")?)?,
            ))
        } else {
            None
        };
        let geom_module = if uses_geometry {
            Some(create_shader_module(device, binaries.get("geom")?)?)
        } else {
            None
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        let mut stage_names = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
        if let Some((tcs, tes)) = &tess_modules {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tcs));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tes));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tcs"));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tes"));
        }
        if let Some(geom) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geom));
            stage_names.push((vk::ShaderStageFlags::GEOMETRY, "geom"));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        stage_names.push((vk::ShaderStageFlags::FRAGMENT, "frag"));

        let topology = if uses_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let mut state = DrawPipelineState::new(topology).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
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
        state.all_stages_specialization_u32 = Some(data as u32);
        if uses_tessellation {
            state.patch_control_points = Some(3);
        }
        let specialization_entry = [vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 0,
            size: std::mem::size_of::<u32>(),
        }];
        let specialization_data = (data as u32).to_ne_bytes();
        let shader_objects = make_shader_objects_stages_specialized(
            context,
            &stage_names,
            &[],
            &[],
            Some((&specialization_entry, &specialization_data)),
        )?;
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

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(RENDER_SIZE, RENDER_SIZE),
            &clear_values,
            &[(color_image.image.get(), *color_image.view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());
        copy_image_to_buffer(
            device,
            cmd,
            color_image.image.get(),
            color_image.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // The whole image is green, within the 0.02 threshold upstream compares with.
        let result = color_image.read_bytes(device)?;
        let max_diff = (0.02f32 * 255.0) as i32;
        let expected = [0i32, 255, 0, 255];
        let correct = result.chunks_exact(4).all(|pixel| {
            pixel
                .iter()
                .zip(expected)
                .all(|(&value, want)| (value as i32 - want).abs() <= max_diff)
        });
        if !correct {
            return Ok(TestStatus::fail("Rendered image is not correct"));
        }

        Ok(TestStatus::pass("OK"))
    }
}

/// `generateTestName`
fn generate_test_name(param: MaxVaryingsParam) -> String {
    format!(
        "test_{}_io_between_{}_{}",
        param.stage_to_stress_io.name(),
        param.output_stage.name(),
        param.input_stage.name()
    )
}

/// `createMaxVaryingsTests` for `PIPELINE_CONSTRUCTION_TYPE_MONOLITHIC`.
pub fn create_max_varyings_tests() -> TestCaseGroup {
    let tests = [
        (Stage::Vertex, Stage::Vertex),
        (Stage::Vertex, Stage::Fragment),
        (Stage::TessEval, Stage::TessEval),
        (Stage::TessEval, Stage::Fragment),
        (Stage::Geometry, Stage::Geometry),
        (Stage::Geometry, Stage::Fragment),
    ];

    let mut group = TestCaseGroup::new("max_varyings");
    for (output_stage, stage_to_stress_io) in tests {
        let param = MaxVaryingsParam {
            output_stage,
            input_stage: Stage::Fragment,
            stage_to_stress_io,
        };
        group.add_child(Box::new(MaxVaryingsCase {
            name: generate_test_name(param),
            param,
        }) as Box<dyn TestCase>);
    }
    group
}
