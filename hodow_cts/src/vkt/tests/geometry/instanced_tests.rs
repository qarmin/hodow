// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/geometry/vktGeometryInstancedRenderingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `instanced`: instanced points drawn through a geometry shader that emits one quad per invocation. The geometry shader
// carries the number of invocations in its text, so each count has its own program set
// (`scripts/gen_geometry_programs.py`, `shaders/manifest/geometry_instanced.toml`).

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::geometry_instanced::{
    INSTANCED_1, INSTANCED_2, INSTANCED_8, INSTANCED_32, INSTANCED_64, INSTANCED_127,
};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::random::Random;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::geometry::GraphicsPipelineBuilder;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 128;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    num_draw_instances: i32,
    num_invocations: i32,
}

/// The programs of the geometry shader with the given number of invocations.
fn programs_for(num_invocations: i32) -> BinaryCollection {
    match num_invocations {
        1 => INSTANCED_1.programs,
        2 => INSTANCED_2.programs,
        8 => INSTANCED_8.programs,
        32 => INSTANCED_32.programs,
        64 => INSTANCED_64.programs,
        _ => INSTANCED_127.programs,
    }
}

/// `draw`: one point per instance, read from a per-instance vertex attribute, through the geometry shader.
fn draw<'a>(
    context: &'a Context<'a>,
    color_buffer: vk::Buffer,
    num_draw_instances: i32,
    per_instance_attribute: &[[f32; 4]],
) -> Result<(), TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let render_size = (RENDER_SIZE, RENDER_SIZE);

    let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: render_size.0,
            height: render_size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(device, alloc, color_image_info, MemoryRequirement::ANY)?;
    let color_attachment = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_subresource_range,
    )?;

    let vertex_buffer_size = std::mem::size_of_val(per_instance_attribute);
    let vertex_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(
            vertex_buffer_size as vk::DeviceSize,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let geometry_module = create_shader_module(device, binaries.get("geom")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_attachment],
        render_size.0,
        render_size.1,
        1,
    )?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let pipeline = GraphicsPipelineBuilder::new(render_size)
        .set_shader(vk::ShaderStageFlags::VERTEX, *vertex_module)
        .set_shader(vk::ShaderStageFlags::GEOMETRY, *geometry_module)
        .set_shader(vk::ShaderStageFlags::FRAGMENT, *fragment_module)
        .add_vertex_binding(vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::INSTANCE,
        })
        .add_vertex_attribute(vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        })
        .set_primitive_topology(vk::PrimitiveTopology::POINT_LIST)
        .build(device, *pipeline_layout, *render_pass)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    // Initialize vertex data
    unsafe {
        std::ptr::copy_nonoverlapping(
            per_instance_attribute.as_ptr().cast::<u8>(),
            vertex_buffer.get_allocation().get_host_ptr(),
            vertex_buffer_size,
        )
    };
    flush_alloc(device, vertex_buffer.get_allocation())?;

    begin_command_buffer(device, cmd)?;

    begin_render_pass(
        device,
        cmd,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, render_size.0, render_size.1),
        vk::ClearValue {
            color: vk::ClearColorValue { float32: CLEAR_COLOR },
        },
    );

    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_draw(cmd, 1, num_draw_instances as u32, 0, 0);
    }
    end_render_pass(device, cmd);

    copy_image_to_buffer(
        device,
        cmd,
        color_image.get(),
        color_buffer,
        render_size.0,
        render_size.1,
    );

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)
}

/// `generatePerInstancePosition`
fn generate_per_instance_position(num_instances: i32) -> Vec<[f32; 4]> {
    let mut rng = Random::new(1234);
    let mut positions = Vec::new();

    for _ in 0..num_instances {
        let flip_x = if rng.get_bool() { 1.0f32 } else { -1.0 };
        let flip_y = if rng.get_bool() { 1.0f32 } else { -1.0 };
        let x = flip_x * rng.get_float_range(0.1, 0.9); // x mustn't be 0.0, because we are using sign() in the shader
        let y = flip_y * rng.get_float_range(0.0, 0.7);

        positions.push([x, y, 0.0, 1.0]);
    }

    positions
}

/// `deFloatSign`
fn float_sign(x: f32) -> f32 {
    if x == 0.0 {
        0.0
    } else if x > 0.0 {
        1.0
    } else {
        -1.0
    }
}

/// `deRoundFloatToInt32`
fn round_float_to_int32(x: f32) -> i32 {
    (x + 0.5) as i32
}

/// `getSubregion` followed by `tcu::clear`: fills a rectangle of an image, given in NDC coordinates (i.e. [-1, 1] range),
/// with a colour. The rectangle is cropped in either dimension to be inside the bounds of the image.
fn clear_subregion(image: &mut TextureLevel, x: f32, y: f32, size: f32, color: [f32; 4]) {
    let mut access = image.get_access();
    let [width, height, _] = access.size();
    let w = width as f32;
    let h = height as f32;
    let x1 = w * (x + 1.0) * 0.5;
    let y1 = h * (y + 1.0) * 0.5;
    let sx = w * size * 0.5;
    let sy = h * size * 0.5;
    let x2 = x1 + sx;
    let y2 = y1 + sy;

    // Round and clamp only after all of the above.
    let ix1 = round_float_to_int32(x1).max(0);
    let ix2 = round_float_to_int32(x2).min(width as i32);
    let iy1 = round_float_to_int32(y1).max(0);
    let iy2 = round_float_to_int32(y2).min(height as i32);

    for py in iy1..iy2 {
        for px in ix1..ix2 {
            access.set_pixel(color, px as u32, py as u32, 0);
        }
    }
}

/// `generateReferenceImage`: must be in sync with the geometry shader code.
fn generate_reference_image(
    clear_color: [f32; 4],
    per_instance_position: &[[f32; 4]],
    num_invocations: i32,
) -> Result<TextureLevel, TestError> {
    let mut image = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        RENDER_SIZE,
        RENDER_SIZE,
        1,
    )?;
    {
        let mut access = image.get_access();
        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                access.set_pixel(clear_color, x, y, 0);
            }
        }
    }

    for position in per_instance_position {
        for invocation_ndx in 0..num_invocations {
            let x = position[0];
            let y = position[1];
            let modifier = if num_invocations > 1 {
                invocation_ndx as f32 / (num_invocations - 1) as f32
            } else {
                0.0
            };
            let color = [x.abs(), y.abs(), 0.2 + 0.8 * modifier, 1.0];
            let size = 0.05 + 0.03 * modifier;
            let dx = (float_sign(-x) - x) / num_invocations as f32;
            let x_offset = invocation_ndx as f32 * dx;
            let y_offset = 0.3 * (12.0 * modifier).sin();

            clear_subregion(&mut image, x + x_offset - size, y + y_offset - size, size + size, color);
        }
    }
    Ok(image)
}

/// `test`
fn test<'a>(context: &'a Context<'a>, params: TestParams) -> TestOutcome {
    let device = context.get_device();
    let color_buffer_size = (RENDER_SIZE * RENDER_SIZE * 4) as usize;
    let color_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(color_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let per_instance_position = generate_per_instance_position(params.num_draw_instances);

    // zeroBuffer
    unsafe { std::ptr::write_bytes(color_buffer.get_allocation().get_host_ptr(), 0, color_buffer_size) };
    flush_alloc(device, color_buffer.get_allocation())?;
    draw(
        context,
        color_buffer.get(),
        params.num_draw_instances,
        &per_instance_position,
    )?;

    // Compare result
    invalidate_alloc(device, color_buffer.get_allocation())?;
    let mut result = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        RENDER_SIZE,
        RENDER_SIZE,
        1,
    )?;
    let bytes = unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size) };
    result.data_mut().copy_from_slice(bytes);

    let reference = generate_reference_image(CLEAR_COLOR, &per_instance_position, params.num_invocations)?;

    if fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), 0.01) != Some(true) {
        return Ok(TestStatus::fail("Rendered image is incorrect"));
    }
    Ok(TestStatus::pass("OK"))
}

/// `addFunctionCaseWithPrograms(group, name, checkSupport, initPrograms, test, params)`
struct InstancedCase {
    name: String,
    params: TestParams,
}

impl TestCase for InstancedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Feature not supported: geometryShader".to_string(),
            ));
        }

        if context.get_device_properties().limits.max_geometry_shader_invocations < self.params.num_invocations as u32 {
            return Err(TestError::NotSupported(format!(
                "Unsupported limit: maxGeometryShaderInvocations < {}",
                self.params.num_invocations
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        programs_for(self.params.num_invocations)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InstancedInstance {
            context,
            params: self.params,
        })
    }
}

struct InstancedInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for InstancedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test(self.context, self.params)
    }
}

/// `createInstancedRenderingTests`
///
/// \note CTS requires shaders to be known ahead of time (some platforms use precompiled shaders), so we can't query a limit
///       at runtime and generate a shader based on that. This applies to number of GS invocations which can't be injected
///       into the shader.
pub fn create_instanced_rendering_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("instanced");

    let draw_instance_cases = [1, 2, 4, 8];
    let invocation_cases = [
        1, 2, 8, 32, // required by the Vulkan spec
        64, 127, // larger than the minimum, but perhaps some implementations support it, so we'll try
    ];

    for num_draw_instances in draw_instance_cases {
        for num_invocations in invocation_cases {
            let case_name = format!("draw_{num_draw_instances}_instances_{num_invocations}_geometry_invocations");
            group.add_child(Box::new(InstancedCase {
                name: case_name,
                params: TestParams {
                    num_draw_instances,
                    num_invocations,
                },
            }) as Box<dyn TestCase>);
        }
    }

    group
}
