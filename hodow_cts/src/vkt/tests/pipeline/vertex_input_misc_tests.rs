// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineVertexInputTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The null state case builds its pipeline
// with an empty vertex input state instead of a NULL pointer, which the dynamic vertex input state makes equivalent.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtExtendedDynamicState2ExtensionDeviceCommands, ExtVertexInputDynamicStateExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::pipeline_vertex_input_misc::{
    NULL_STATE, STRIDE_CHANGE_VERT_FRAG, STRIDE_CHANGE_VERT_GEOM_FRAG, STRIDE_CHANGE_VERT_TESS_FRAG,
    STRIDE_CHANGE_VERT_TESS_GEOM_FRAG, UNBOUND_INPUT, UNBOUND_INPUT_INTEGER, UNUSED_BINDING,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::invalidate_alloc;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const VEC4_SIZE: u32 = 16;

#[derive(Clone, Copy)]
enum Kind {
    /// `StrideChangeParams`: the second bind adds tessellation and/or geometry.
    StrideChange { use_tessellation: bool, use_geometry: bool },
    /// `UnusedBinding::Params`
    UnusedBinding { dynamic_inputs: bool },
    /// `UnboundInput::Params`
    UnboundInput { dynamic_inputs: bool, integer_input: bool },
    /// `NullState::Params`
    NullState { is_rast_discard_dynamic: bool },
}

struct VertexInputMiscCase {
    name: String,
    kind: Kind,
}

impl TestCase for VertexInputMiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `StrideChangeCase::checkSupport` and the `checkSupport` of each `addFunctionCaseWithPrograms` case
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        match self.kind {
            Kind::StrideChange {
                use_tessellation,
                use_geometry,
            } => {
                if use_tessellation && features.tessellation_shader == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Tessellation shaders not supported".to_string(),
                    ));
                }
                if use_geometry && features.geometry_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Geometry shaders not supported".to_string()));
                }
            }
            Kind::UnusedBinding { dynamic_inputs } => {
                if dynamic_inputs {
                    context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
                }
            }
            Kind::UnboundInput { dynamic_inputs, .. } => {
                if dynamic_inputs {
                    context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
                }
                context.require_device_functionality("VK_KHR_maintenance9")?;
            }
            Kind::NullState {
                is_rast_discard_dynamic,
            } => {
                context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
                if is_rast_discard_dynamic {
                    context.require_device_functionality("VK_EXT_extended_dynamic_state2")?;
                }
                if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Vertex pipeline stores and atomics not supported".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::StrideChange {
                use_tessellation: false,
                use_geometry: false,
            } => STRIDE_CHANGE_VERT_FRAG.programs,
            Kind::StrideChange {
                use_tessellation: true,
                use_geometry: false,
            } => STRIDE_CHANGE_VERT_TESS_FRAG.programs,
            Kind::StrideChange {
                use_tessellation: false,
                use_geometry: true,
            } => STRIDE_CHANGE_VERT_GEOM_FRAG.programs,
            Kind::StrideChange {
                use_tessellation: true,
                use_geometry: true,
            } => STRIDE_CHANGE_VERT_TESS_GEOM_FRAG.programs,
            Kind::UnusedBinding { .. } => UNUSED_BINDING.programs,
            Kind::UnboundInput {
                integer_input: false, ..
            } => UNBOUND_INPUT.programs,
            Kind::UnboundInput {
                integer_input: true, ..
            } => UNBOUND_INPUT_INTEGER.programs,
            Kind::NullState { .. } => NULL_STATE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VertexInputMiscInstance {
            context,
            kind: self.kind,
        })
    }
}

struct VertexInputMiscInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for VertexInputMiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::StrideChange {
                use_tessellation,
                use_geometry,
            } => stride_change(self.context, use_tessellation, use_geometry),
            Kind::UnusedBinding { dynamic_inputs } => unused_binding(self.context, dynamic_inputs),
            Kind::UnboundInput {
                dynamic_inputs,
                integer_input: _,
            } => unbound_input(self.context, dynamic_inputs),
            Kind::NullState {
                is_rast_discard_dynamic,
            } => null_state(self.context, is_rast_discard_dynamic),
        }
    }
}

fn vec4_bytes(vertices: &[[f32; 4]]) -> &[u8] {
    unsafe { std::slice::from_raw_parts(vertices.as_ptr().cast::<u8>(), std::mem::size_of_val(vertices)) }
}

/// The vertex input of the dynamic variants: `VkVertexInputBindingDescription2EXT` with divisor 1 for every binding.
fn dynamic_bindings(bindings: &[vk::VertexInputBindingDescription]) -> Vec<vk::VertexInputBindingDescription2EXT> {
    bindings
        .iter()
        .map(|b| vk::VertexInputBindingDescription2EXT {
            binding: b.binding,
            stride: b.stride,
            input_rate: b.input_rate,
            divisor: 1,
            ..Default::default()
        })
        .collect()
}

fn dynamic_attributes(
    attributes: &[vk::VertexInputAttributeDescription],
) -> Vec<vk::VertexInputAttributeDescription2EXT> {
    attributes
        .iter()
        .map(|a| vk::VertexInputAttributeDescription2EXT {
            location: a.location,
            binding: a.binding,
            format: a.format,
            offset: a.offset,
            ..Default::default()
        })
        .collect()
}

/// `floatThresholdCompare` with a zero threshold over colours made of 0 and 1 only.
fn pixels_equal(result: &[u8], expected: &[[u8; 4]]) -> bool {
    expected
        .iter()
        .enumerate()
        .all(|(i, color)| result[i * 4..i * 4 + 4] == color[..])
}

fn color_bytes(color: [f32; 4]) -> [u8; 4] {
    color.map(|c| (c * 255.0).round() as u8)
}

/// `StrideChangeTest::iterate`
fn stride_change<'a>(context: &'a Context<'a>, use_tessellation: bool, use_geometry: bool) -> TestOutcome {
    let device = context.get_device();
    const EXTENT: u32 = 4;
    const TRI_VTX: u32 = 3;
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let geom_color = [0u8, 0, 255, 255];

    let color_buffer = ImageWithBuffer::new(
        context,
        EXTENT,
        EXTENT,
        COLOR_FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;

    // See upstream's description: the second triangle's padding makes the first one again, or a zero-area triangle.
    let vertices: [[f32; 4]; 12] = [
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [-1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ];
    let vertex_buffer = create_host_buffer(context, vec4_bytes(&vertices), vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_color_render_pass(
        device,
        COLOR_FORMAT,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let tesc_module = if use_tessellation {
        Some(create_shader_module(device, binaries.get("tesc")?)?)
    } else {
        None
    };
    let tese_module = if use_tessellation {
        Some(create_shader_module(device, binaries.get("tese")?)?)
    } else {
        None
    };
    let geom_module = if use_geometry {
        Some(create_shader_module(device, binaries.get("geom")?)?)
    } else {
        None
    };
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    // Short stride for the first draw and a long one for the second, which starts at vertex 1 to skip the first triangle's data.
    let vertex_strides = [VEC4_SIZE, VEC4_SIZE * TRI_VTX];
    let first_vertices = [0u32, 1];
    let use_tess = [false, use_tessellation];
    let use_geom = [false, use_geometry];

    let mut pipelines = Vec::new();
    let mut shader_objects = Vec::new();
    let mut states = Vec::new();
    for i in 0..vertex_strides.len() {
        let topology = if use_tess[i] {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let mut state = DrawPipelineState::new(topology).with_full_viewport(EXTENT, EXTENT);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: vertex_strides[i],
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        if use_tess[i] {
            state.patch_control_points = Some(3);
        }

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        let mut stage_names = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
        if use_tess[i] {
            stages.push((
                vk::ShaderStageFlags::TESSELLATION_CONTROL,
                **tesc_module.as_ref().unwrap(),
            ));
            stages.push((
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                **tese_module.as_ref().unwrap(),
            ));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"));
        }
        if use_geom[i] {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geom_module.as_ref().unwrap()));
            stage_names.push((vk::ShaderStageFlags::GEOMETRY, "geom"));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        stage_names.push((vk::ShaderStageFlags::FRAGMENT, "frag"));
        let objects = make_shader_objects_stages(context, &stage_names, &[], &[])?;
        if objects.is_none() {
            pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?);
        }
        shader_objects.push(objects);
        states.push(state);
    }

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let clear_values = [clear_value_color(clear_color)];
    begin_draw(
        device,
        cmd,
        shader_objects[0].as_ref(),
        &states[0],
        None,
        *render_pass,
        *framebuffer,
        rect_2d(EXTENT, EXTENT),
        &clear_values,
        &[(color_buffer.image.get(), *color_buffer.view)],
    );
    unsafe {
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        for (i, first_vertex) in first_vertices.into_iter().enumerate() {
            if let Some(objects) = &shader_objects[i] {
                objects.bind(cmd, &states[i]);
            } else {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipelines[i].get());
            }
            device.cmd_draw(cmd, TRI_VTX, 1, first_vertex, 0);
        }
    }
    end_draw(device, cmd, shader_objects[0].is_some());
    copy_image_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        EXTENT,
        EXTENT,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    let result = color_buffer.read_bytes(device)?;
    if !pixels_equal(result, &[geom_color; (EXTENT * EXTENT) as usize]) {
        return Ok(TestStatus::fail(
            "Unexpected color in result buffer; check log for details",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

/// The four quadrant triangle strips of `UnusedBinding` and `UnboundInput`, ordered as the 2x2 image is read.
const QUADRANT_POSITIONS: [[[f32; 4]; 4]; 4] = [
    [
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 0.0, 0.0, 1.0],
        [0.0, -1.0, 0.0, 1.0],
        [0.0, 0.0, 0.0, 1.0],
    ],
    [
        [0.0, -1.0, 0.0, 1.0],
        [0.0, 0.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 0.0, 0.0, 1.0],
    ],
    [
        [-1.0, 0.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [0.0, 0.0, 0.0, 1.0],
        [0.0, 1.0, 0.0, 1.0],
    ],
    [
        [0.0, 0.0, 0.0, 1.0],
        [0.0, 1.0, 0.0, 1.0],
        [1.0, 0.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ],
];

/// What `UnusedBinding` and `UnboundInput` share: draw the four quadrants from `vertex_data` with one binding.
fn run_quadrant_draw(
    context: &Context<'_>,
    dynamic_inputs: bool,
    vertex_data: &[u8],
    bindings: &[vk::VertexInputBindingDescription],
    attributes: &[vk::VertexInputAttributeDescription],
    clear_color: [f32; 4],
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    const EXTENT: u32 = 2;
    let vertex_buffer = create_host_buffer(context, vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    let color_buffer = ImageWithBuffer::new(
        context,
        EXTENT,
        EXTENT,
        COLOR_FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        4,
    )?;
    let render_pass = make_color_render_pass(
        device,
        COLOR_FORMAT,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(EXTENT, EXTENT);
    if dynamic_inputs {
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_EXT];
    } else {
        state.bindings = bindings.to_vec();
        state.attributes = attributes.to_vec();
    }
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let clear_values = [clear_value_color(clear_color)];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(EXTENT, EXTENT))
        .clear_values(&clear_values);
    let dynamic_binding_descriptions = dynamic_bindings(bindings);
    let dynamic_attribute_descriptions = dynamic_attributes(attributes);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        if dynamic_inputs {
            device.cmd_set_vertex_input_ext(cmd, &dynamic_binding_descriptions, &dynamic_attribute_descriptions);
        }
        // Draw the 4 quadrants.
        for i in 0..4u32 {
            device.cmd_draw(cmd, 4, 1, i * 4, 1);
        }
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        EXTENT,
        EXTENT,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    Ok(color_buffer.read_bytes(device)?.to_vec())
}

/// `UnusedBinding::runTest`
fn unused_binding(context: &Context<'_>, dynamic_inputs: bool) -> TestOutcome {
    let colors = [
        [0.0f32, 0.0, 1.0, 1.0],
        [0.0, 1.0, 1.0, 1.0],
        [1.0, 0.0, 1.0, 1.0],
        [1.0, 1.0, 1.0, 1.0],
    ];

    // Position then colour, interleaved in binding 0.
    let mut vertices: Vec<[f32; 4]> = Vec::with_capacity(32);
    for (quadrant, color) in QUADRANT_POSITIONS.iter().zip(colors) {
        for position in quadrant {
            vertices.push(*position);
            vertices.push(color);
        }
    }

    // Binding 1 is described but never used by any attribute or bound.
    let bindings = [
        vk::VertexInputBindingDescription {
            binding: 0,
            stride: 2 * VEC4_SIZE,
            input_rate: vk::VertexInputRate::VERTEX,
        },
        vk::VertexInputBindingDescription {
            binding: 1,
            stride: VEC4_SIZE,
            input_rate: vk::VertexInputRate::VERTEX,
        },
    ];
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
            offset: VEC4_SIZE,
        },
    ];

    let result = run_quadrant_draw(
        context,
        dynamic_inputs,
        vec4_bytes(&vertices),
        &bindings,
        &attributes,
        [0.0, 0.0, 0.0, 1.0],
    )?;

    let expected = colors.map(color_bytes);
    if !pixels_equal(&result, &expected) {
        return Err(TestError::Fail(
            "Unexpected results in color buffer; check log for details --".to_string(),
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `UnboundInput::runTest`
fn unbound_input(context: &Context<'_>, dynamic_inputs: bool) -> TestOutcome {
    let vertices: Vec<[f32; 4]> = QUADRANT_POSITIONS.iter().flatten().copied().collect();

    // Location 1 (the colour) has no attribute at all, so it reads the default vertex attribute value.
    let bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: VEC4_SIZE,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];

    let result = run_quadrant_draw(
        context,
        dynamic_inputs,
        vec4_bytes(&vertices),
        &bindings,
        &attributes,
        [0.25, 0.5, 0.75, 0.123],
    )?;

    let mut maintenance9 = vk::PhysicalDeviceMaintenance9PropertiesKHR::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance9);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    let alpha = if maintenance9.default_vertex_attribute_value == vk::DefaultVertexAttributeValueKHR::ZERO_ZERO_ZERO_ONE
    {
        255
    } else {
        0
    };

    if !pixels_equal(&result, &[[0, 0, 0, alpha]; 4]) {
        return Err(TestError::Fail(
            "Unexpected results in color buffer; check log for details --".to_string(),
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `NullState::runTest`
fn null_state(context: &Context<'_>, is_rast_discard_dynamic: bool) -> TestOutcome {
    let device = context.get_device();
    const EXTENT: u32 = 2;
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];

    let blue = [0.0f32, 0.0, 1.0, 1.0];
    let vertices: [[f32; 4]; 8] = [
        [-1.0, -1.0, 0.0, 1.0],
        blue,
        [-1.0, 0.0, 0.0, 1.0],
        blue,
        [0.0, -1.0, 0.0, 1.0],
        blue,
        [0.0, 0.0, 0.0, 1.0],
        blue,
    ];
    let num_vertices = 4u32;

    // Upstream sizes the vertex buffer in vertices rather than bytes and the draw never reads from it (rasterization is off).
    let vertex_buffer = create_host_buffer(
        context,
        &vec4_bytes(&vertices)[..num_vertices as usize],
        vk::BufferUsageFlags::VERTEX_BUFFER,
    )?;

    let output_data_size = (num_vertices as usize * std::mem::size_of::<i32>()) as vk::DeviceSize;
    let output_data_buffer = create_host_buffer(
        context,
        &vec![0x7FFF_FFFFi32; num_vertices as usize],
        vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::VERTEX)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, descriptor_set_layout.get())?;
    let descriptor_buffer_info = make_descriptor_buffer_info(output_data_buffer.get(), 0, output_data_size);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &descriptor_buffer_info,
        )
        .update(device);

    let color_buffer = ImageWithBuffer::new(
        context,
        EXTENT,
        EXTENT,
        COLOR_FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        4,
    )?;
    let render_pass = make_color_render_pass(
        device,
        COLOR_FORMAT,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

    let actual_bindings = [
        vk::VertexInputBindingDescription {
            binding: 0,
            stride: 2 * VEC4_SIZE,
            input_rate: vk::VertexInputRate::VERTEX,
        },
        vk::VertexInputBindingDescription {
            binding: 1,
            stride: VEC4_SIZE,
            input_rate: vk::VertexInputRate::VERTEX,
        },
    ];
    let actual_attributes = [
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
            offset: VEC4_SIZE,
        },
    ];

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[descriptor_set_layout.get()])?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(EXTENT, EXTENT);
    state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_EXT];
    if is_rast_discard_dynamic {
        state.dynamic_states.push(vk::DynamicState::RASTERIZER_DISCARD_ENABLE);
    } else {
        state.rasterization.rasterizer_discard_enable = vk::TRUE;
    }
    // Without rasterization discard being dynamic, upstream builds the pipeline without a fragment shader.
    let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
    if is_rast_discard_dynamic {
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
    }
    let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let clear_values = [clear_value_color(clear_color)];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(EXTENT, EXTENT))
        .clear_values(&clear_values);
    let dynamic_binding_descriptions = dynamic_bindings(&actual_bindings);
    let dynamic_attribute_descriptions = dynamic_attributes(&actual_attributes);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_set_vertex_input_ext(cmd, &dynamic_binding_descriptions, &dynamic_attribute_descriptions);
        if is_rast_discard_dynamic {
            device.cmd_set_rasterizer_discard_enable_ext(cmd, true);
        }
        device.cmd_draw(cmd, num_vertices, 1, 0, 1);
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        EXTENT,
        EXTENT,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // The output colour is the clear colour.
    let result = color_buffer.read_bytes(device)?;
    if !pixels_equal(result, &[color_bytes(clear_color); (EXTENT * EXTENT) as usize]) {
        return Err(TestError::Fail(
            "Unexpected results in color buffer; check log for details --".to_string(),
        ));
    }

    // The output data is the vertex index plus one.
    let alloc = output_data_buffer.get_allocation();
    invalidate_alloc(device, alloc)?;
    let output = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast::<i32>(), num_vertices as usize) };
    for (vertex_index, &value) in output.iter().enumerate() {
        if value != vertex_index as i32 + 1 {
            return Err(TestError::Fail("Unexpected results in data buffer".to_string()));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `createMiscVertexInputTests`
pub fn create_vertex_input_misc_tests(shader_object: bool) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("misc");

    for use_tessellation in [false, true] {
        for use_geometry in [false, true] {
            let name = format!(
                "stride_change_vert{}{}_frag",
                if use_tessellation { "_tess" } else { "" },
                if use_geometry { "_geom" } else { "" }
            );
            group.add_child(Box::new(VertexInputMiscCase {
                name,
                kind: Kind::StrideChange {
                    use_tessellation,
                    use_geometry,
                },
            }) as Box<dyn TestCase>);
        }
    }

    if shader_object {
        return group;
    }

    for dynamic in [false, true] {
        let suffix = if dynamic { "_dynamic" } else { "" };
        group.add_child(Box::new(VertexInputMiscCase {
            name: format!("unused_binding{suffix}"),
            kind: Kind::UnusedBinding {
                dynamic_inputs: dynamic,
            },
        }) as Box<dyn TestCase>);
        for integer_input in [false, true] {
            let name = format!("unbound_input{suffix}{}", if integer_input { "_integer" } else { "" });
            group.add_child(Box::new(VertexInputMiscCase {
                name,
                kind: Kind::UnboundInput {
                    dynamic_inputs: dynamic,
                    integer_input,
                },
            }) as Box<dyn TestCase>);
        }
    }

    for is_rast_discard_dynamic in [false, true] {
        let name = format!(
            "null_state_dynamic_input_rast_discard{}",
            if is_rast_discard_dynamic { "_dynamic" } else { "" }
        );
        group.add_child(Box::new(VertexInputMiscCase {
            name,
            kind: Kind::NullState {
                is_rast_discard_dynamic,
            },
        }) as Box<dyn TestCase>);
    }
    group
}
