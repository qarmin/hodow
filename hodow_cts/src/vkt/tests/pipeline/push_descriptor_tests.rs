// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelinePushDescriptorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream creates a private instance and device with `VK_KHR_push_descriptor` enabled for
// every case; here the cases run on `Context`'s device, which enables every supported extension, so `VK_KHR_push_descriptor` (and
// `VK_KHR_maintenance5`/`6` where a case uses them) is only required. The graphics cases are monolithic only: upstream repeats them
// for graphics pipeline libraries and shader objects. The shaders are in `shaders/manifest/pipeline_push_descriptor.toml`.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_1, KhrDescriptorUpdateTemplateExtensionDeviceCommands, KhrMaintenance6ExtensionDeviceCommands,
    KhrPushDescriptorExtensionDeviceCommands,
};

use crate::generated::shaders::pipeline_push_descriptor::*;
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::RenderState;
use crate::rr::renderer::Program;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::vector::UVec4;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba, default_clear_value, read_color_attachment,
};
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZEOF_VEC4: vk::DeviceSize = 16;

const DEFAULT_TEST_COLORS: [[f32; 4]; 2] = [[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0]];

/// `TestParams`, without the pipeline construction type (every case is monolithic).
#[derive(Clone, Copy)]
struct TestParams {
    descriptor_type: vk::DescriptorType,
    binding: u32,
    /// Number of draw or dispatch calls
    num_calls: u32,
    use_maintenance5: bool,
    use_maintenance6: bool,
}

/// `commonCheckSupported`
fn common_check_supported(context: &Context<'_>, params: &TestParams) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_push_descriptor")?;
    if params.use_maintenance5 {
        context.require_device_functionality("VK_KHR_maintenance5")?;
    }
    if params.use_maintenance6 {
        context.require_device_functionality("VK_KHR_maintenance6")?;
    }
    Ok(())
}

/// `calcItemSize`
fn calc_item_size(context: &Context<'_>, num_elements: u32) -> vk::DeviceSize {
    fn gcd(a: u64, b: u64) -> u64 {
        if b == 0 { a } else { gcd(b, a % b) }
    }

    let min_alignment = context
        .get_device_properties()
        .limits
        .min_storage_buffer_offset_alignment
        .max(1);
    let lcm = min_alignment / gcd(min_alignment, SIZEOF_VEC4) * SIZEOF_VEC4;
    (SIZEOF_VEC4 * u64::from(num_elements)).div_ceil(lcm) * lcm
}

/// `createQuads`
fn create_quads(num_quads: u32, size: f32) -> Vec<Vertex4Rgba> {
    let mut vertices = Vec::new();

    for quad_ndx in 0..num_quads {
        let x_offset = -0.5 + quad_ndx as f32;
        let color = [0.0f32; 4];
        let lower_left_vertex = Vertex4Rgba {
            position: [-size + x_offset, -size, 0.0, 1.0],
            color,
        };
        let lower_right_vertex = Vertex4Rgba {
            position: [size + x_offset, -size, 0.0, 1.0],
            color,
        };
        let upper_left_vertex = Vertex4Rgba {
            position: [-size + x_offset, size, 0.0, 1.0],
            color,
        };
        let upper_right_vertex = Vertex4Rgba {
            position: [size + x_offset, size, 0.0, 1.0],
            color,
        };

        vertices.push(lower_left_vertex);
        vertices.push(lower_right_vertex);
        vertices.push(upper_left_vertex);
        vertices.push(upper_left_vertex);
        vertices.push(lower_right_vertex);
        vertices.push(upper_right_vertex);
    }

    vertices
}

fn is_uniform(descriptor_type: vk::DescriptorType) -> bool {
    descriptor_type == vk::DescriptorType::UNIFORM_BUFFER
}

fn buffer_usage(descriptor_type: vk::DescriptorType) -> vk::BufferUsageFlags {
    if is_uniform(descriptor_type) {
        vk::BufferUsageFlags::UNIFORM_BUFFER
    } else {
        vk::BufferUsageFlags::STORAGE_BUFFER
    }
}

/// One host-visible buffer of `size` bytes; with maintenance5 the usage is given through `VkBufferUsageFlags2CreateInfoKHR`.
fn create_buffer<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    use_maintenance5: bool,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();

    if use_maintenance5 {
        let mut buffer_usage_flags2 = vk::BufferUsageFlags2CreateInfo::builder()
            .usage(vk::BufferUsageFlags2::from_bits_truncate(u64::from(usage.bits())));
        let info = vk::BufferCreateInfo::builder()
            .size(size)
            .usage(vk::BufferUsageFlags::empty())
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .push_next(&mut buffer_usage_flags2)
            .build();
        BufferWithMemory::new(device, alloc, info, MemoryRequirement::HOST_VISIBLE)
    } else {
        BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(size, usage),
            MemoryRequirement::HOST_VISIBLE,
        )
    }
}

fn write_host_bytes(device: &Device, buffer: &BufferWithMemory<'_>, bytes: &[u8]) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), alloc.get_host_ptr(), bytes.len()) };
    flush_alloc(device, alloc)
}

fn color_bytes(color: [f32; 4]) -> [u8; 16] {
    let mut bytes = [0u8; 16];
    for (i, value) in color.iter().enumerate() {
        bytes[i * 4..i * 4 + 4].copy_from_slice(&value.to_ne_bytes());
    }
    bytes
}

/// A push descriptor update template, destroyed when it goes out of scope.
struct UpdateTemplate<'a> {
    device: &'a Device,
    handle: vk::DescriptorUpdateTemplate,
    use_khr: bool,
}

impl Drop for UpdateTemplate<'_> {
    fn drop(&mut self) {
        unsafe {
            if self.use_khr {
                self.device.destroy_descriptor_update_template_khr(self.handle, None);
            } else {
                self.device.destroy_descriptor_update_template(self.handle, None);
            }
        }
    }
}

/// `createDescriptorUpdateTemplate` for a push descriptor template of compute set 0.
fn create_update_template<'a>(
    context: &'a Context<'a>,
    entries: &[vk::DescriptorUpdateTemplateEntry],
    set_layout: vk::DescriptorSetLayout,
    pipeline_layout: vk::PipelineLayout,
) -> Result<UpdateTemplate<'a>, TestError> {
    let device = context.get_device();
    let info = vk::DescriptorUpdateTemplateCreateInfo::builder()
        .descriptor_update_entries(entries)
        .template_type(vk::DescriptorUpdateTemplateType::PUSH_DESCRIPTORS)
        .descriptor_set_layout(set_layout)
        .pipeline_bind_point(vk::PipelineBindPoint::COMPUTE)
        .pipeline_layout(pipeline_layout)
        .set(0);

    let use_khr = context
        .get_device_extensions()
        .iter()
        .any(|e| e == "VK_KHR_descriptor_update_template");
    let handle = unsafe {
        if use_khr {
            device.create_descriptor_update_template_khr(&info, None)
        } else {
            device.create_descriptor_update_template(&info, None)
        }
    }
    .vk_check("vkCreateDescriptorUpdateTemplate")?;
    Ok(UpdateTemplate {
        device,
        handle,
        use_khr,
    })
}

fn buffer_graphics_programs(descriptor_type: vk::DescriptorType, binding: u32) -> BinaryCollection {
    match (is_uniform(descriptor_type), binding) {
        (true, 0) => PD_BUFFER_GRAPHICS_UNIFORM_BINDING0.programs,
        (true, 1) => PD_BUFFER_GRAPHICS_UNIFORM_BINDING1.programs,
        (true, 3) => PD_BUFFER_GRAPHICS_UNIFORM_BINDING3.programs,
        (false, 0) => PD_BUFFER_GRAPHICS_STORAGE_BINDING0.programs,
        (false, 1) => PD_BUFFER_GRAPHICS_STORAGE_BINDING1.programs,
        (false, 3) => PD_BUFFER_GRAPHICS_STORAGE_BINDING3.programs,
        _ => BinaryCollection::new(&[]),
    }
}

fn buffer_compute_programs(descriptor_type: vk::DescriptorType, binding: u32) -> BinaryCollection {
    match (is_uniform(descriptor_type), binding) {
        (true, 0) => PD_BUFFER_COMPUTE_UNIFORM_BINDING0.programs,
        (true, 1) => PD_BUFFER_COMPUTE_UNIFORM_BINDING1.programs,
        (true, 3) => PD_BUFFER_COMPUTE_UNIFORM_BINDING3.programs,
        (false, 0) => PD_BUFFER_COMPUTE_STORAGE_BINDING0.programs,
        (false, 1) => PD_BUFFER_COMPUTE_STORAGE_BINDING1.programs,
        (false, 3) => PD_BUFFER_COMPUTE_STORAGE_BINDING3.programs,
        _ => BinaryCollection::new(&[]),
    }
}

/// `PushDescriptorBufferGraphicsTest`
struct PushDescriptorBufferGraphicsTest {
    name: String,
    params: TestParams,
}

impl TestCase for PushDescriptorBufferGraphicsTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        buffer_graphics_programs(self.params.descriptor_type, self.params.binding)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorBufferGraphicsInstance {
            context,
            params: self.params,
        })
    }
}

struct PushDescriptorBufferGraphicsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for PushDescriptorBufferGraphicsInstance<'_> {
    /// `PushDescriptorBufferGraphicsTestInstance::init`, `iterate` and `verifyImage`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();

        let render_size = (32u32, 32u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let mut vertices = create_quads(params.num_calls, 0.25);

        // Create color image
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
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
        let color_image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;

        // Create color attachment view
        let color_attachment_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // Create render pass and framebuffer
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view],
            render_size.0,
            render_size.1,
            1,
        )?;

        // Create pipeline layout with the push descriptor set layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(params.descriptor_type, vk::ShaderStageFlags::VERTEX, params.binding, 1)
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create buffers. One color value in each buffer.
        let mut buffers = Vec::new();
        for color in DEFAULT_TEST_COLORS {
            let buffer = create_buffer(
                context,
                SIZEOF_VEC4,
                buffer_usage(params.descriptor_type),
                params.use_maintenance5,
            )?;
            write_host_bytes(device, &buffer, &color_bytes(color))?;
            buffers.push(buffer);
        }

        // Create shaders
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;

        // Create pipeline
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(render_size.0, render_size.1);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<Vertex4Rgba>() as u32,
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
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[*descriptor_set_layout], &[])?;
        let graphics_pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
                ],
                &state,
            )?)
        };

        // Create vertex buffer
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            graphics_pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, render_size.0, render_size.1),
            &[default_clear_value(color_format)],
            &[(color_image.get(), *color_attachment_view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        }

        // Draw quads. Switch input buffer which contains the quad color for each draw call.
        for quad_ndx in 0..params.num_calls {
            let descriptor_buffer_info = [vk::DescriptorBufferInfo {
                buffer: buffers[quad_ndx as usize].get(),
                offset: 0,
                range: SIZEOF_VEC4,
            }];
            let write_descriptor_set = vk::WriteDescriptorSet::builder()
                .dst_binding(params.binding)
                .dst_array_element(0)
                .descriptor_type(params.descriptor_type)
                .buffer_info(&descriptor_buffer_info)
                .build();

            unsafe {
                device.cmd_push_descriptor_set_khr(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[write_descriptor_set],
                );
                device.cmd_draw(cmd, 6, 1, 6 * quad_ndx, 0);
            }
        }

        end_draw(device, cmd, shader_objects.is_some());
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify the image
        let tcu_color_format = map_vk_format(color_format).expect("RGBA8 has a texture format");
        let vertex_shader = ColorVertexShader::new();
        let fragment_shader = ColorFragmentShader::new(tcu_color_format, None, false);
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut ref_renderer = ReferenceRenderer::new(render_size.0, render_size.1, tcu_color_format, None)?;

        // Render reference image
        for quad_idx in 0..params.num_calls as usize {
            for vertex_idx in 0..6 {
                vertices[quad_idx * 6 + vertex_idx].color = DEFAULT_TEST_COLORS[quad_idx];
            }
        }
        let render_state = RenderState::new(
            ref_renderer.get_viewport_state(),
            context.get_device_properties().limits.sub_pixel_precision_bits as i32,
        );
        ref_renderer.draw(&program, &render_state, PrimitiveType::Triangles, &vertices);

        // Compare result with reference image
        let result = read_color_attachment(
            context,
            color_image.get(),
            color_format,
            render_size,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let compare_ok = int_threshold_position_deviation_compare(
            &ref_renderer.get_access(),
            &result.get_const_access(),
            UVec4::new(2, 2, 2, 2),
            [1, 1, 0],
            true,
        );

        if compare_ok {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }
}

/// `PushDescriptorBufferComputeTest`
struct PushDescriptorBufferComputeTest {
    name: String,
    params: TestParams,
}

impl TestCase for PushDescriptorBufferComputeTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        buffer_compute_programs(self.params.descriptor_type, self.params.binding)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorBufferComputeInstance {
            context,
            params: self.params,
        })
    }
}

struct PushDescriptorBufferComputeInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for PushDescriptorBufferComputeInstance<'_> {
    /// `PushDescriptorBufferComputeTestInstance::init`, `iterate` and `verifyOutput`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let item_size = calc_item_size(context, 1);

        // Create pipeline layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(params.descriptor_type, vk::ShaderStageFlags::COMPUTE, params.binding, 1)
            .add_indexed_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::COMPUTE,
                params.binding + 1,
                1,
            )
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Fill the test colors table
        let first = DEFAULT_TEST_COLORS[0];
        let last = DEFAULT_TEST_COLORS[DEFAULT_TEST_COLORS.len() - 1];
        let mut test_colors = vec![[0.0f32; 4]; params.num_calls as usize];
        for (color_idx, test_color) in test_colors.iter_mut().enumerate() {
            if color_idx < DEFAULT_TEST_COLORS.len() {
                *test_color = DEFAULT_TEST_COLORS[color_idx];
            } else {
                let mix = color_idx as f32 / (params.num_calls - 1) as f32;

                // interpolate between first and last color, require these colors to be different
                for channel in 0..4 {
                    test_color[channel] = first[channel] * mix + last[channel] * (1.0 - mix);
                }
            }
        }

        // Create buffers. One color value in each buffer.
        let mut buffers = Vec::new();
        for color in &test_colors {
            let buffer = create_buffer(context, SIZEOF_VEC4, buffer_usage(params.descriptor_type), false)?;
            write_host_bytes(device, &buffer, &color_bytes(*color))?;
            buffers.push(buffer);
        }

        // Create output buffer
        let output_buffer = create_buffer(
            context,
            item_size * u64::from(params.num_calls),
            vk::BufferUsageFlags::STORAGE_BUFFER,
            false,
        )?;

        // Create shader and pipeline
        let compute_shader_module = create_shader_module(device, context.get_binary_collection().get("compute")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_shader_module)
            .name(c"main".to_bytes_with_nul());
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, pipelines.0[0]);

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        // Dispatch: Each dispatch switches the input buffer.
        // Output buffer is exposed as a vec4 sized window.
        for dispatch_ndx in 0..params.num_calls {
            let descriptor_buffer_info_ubo = [vk::DescriptorBufferInfo {
                buffer: buffers[dispatch_ndx as usize].get(),
                offset: 0,
                range: SIZEOF_VEC4,
            }];
            let descriptor_buffer_info_output = [vk::DescriptorBufferInfo {
                buffer: output_buffer.get(),
                offset: item_size * u64::from(dispatch_ndx),
                range: SIZEOF_VEC4,
            }];

            let write_descriptor_sets = [
                vk::WriteDescriptorSet::builder()
                    .dst_binding(params.binding)
                    .dst_array_element(0)
                    .descriptor_type(params.descriptor_type)
                    .buffer_info(&descriptor_buffer_info_ubo)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_binding(params.binding + 1)
                    .dst_array_element(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&descriptor_buffer_info_output)
                    .build(),
            ];

            let barrier = [vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build()];
            unsafe {
                device.cmd_push_descriptor_set_khr(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &write_descriptor_sets,
                );
                device.cmd_dispatch(cmd, 1, 1, 1);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &barrier,
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify result
        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let buffer_ptr = output_alloc.get_host_ptr();
        for (i, test_color) in test_colors.iter().enumerate() {
            let mut actual = [0u8; 16];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    buffer_ptr.add(i * item_size as usize),
                    actual.as_mut_ptr(),
                    actual.len(),
                )
            };
            if actual != color_bytes(*test_color) {
                return Err(TestError::Fail(format!("Output mismatch at output item {i}")));
            }
        }

        Ok(TestStatus::pass("Output matches expected values"))
    }
}

/// `PushDescriptorIncrementalUpdatesComputeTest`
struct PushDescriptorIncrementalUpdatesComputeTest {
    name: String,
    params: TestParams,
    with_template: bool,
    commands2: bool,
}

impl TestCase for PushDescriptorIncrementalUpdatesComputeTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)?;
        if self.with_template {
            context.require_device_functionality("VK_KHR_descriptor_update_template")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        PD_INCREMENTAL_UPDATES.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorIncrementalUpdatesComputeInstance {
            context,
            with_template: self.with_template,
            commands2: self.commands2,
        })
    }
}

struct PushDescriptorIncrementalUpdatesComputeInstance<'a> {
    context: &'a Context<'a>,
    with_template: bool,
    commands2: bool,
}

impl TestInstance for PushDescriptorIncrementalUpdatesComputeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let with_template = self.with_template;
        let commands2 = self.commands2;

        let buffer_size = 16u32;

        let bindings_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE, 1, 1)
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*bindings_layout])?;

        let compute_shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_shader_module)
            .name(c"main".to_bytes_with_nul());
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let data_size = (std::mem::size_of::<u32>() * 4 * buffer_size as usize) as vk::DeviceSize;
        let ubo_buffer1 = create_buffer(context, data_size, vk::BufferUsageFlags::UNIFORM_BUFFER, false)?;
        let ubo_buffer2 = create_buffer(context, data_size, vk::BufferUsageFlags::UNIFORM_BUFFER, false)?;
        let ssbo_buffer1 = create_buffer(context, data_size, vk::BufferUsageFlags::STORAGE_BUFFER, false)?;
        let ssbo_buffer2 = create_buffer(context, data_size, vk::BufferUsageFlags::STORAGE_BUFFER, false)?;

        let mut ubo_data1 = vec![0u32; 4 * buffer_size as usize];
        let mut ubo_data2 = vec![0u32; 4 * buffer_size as usize];
        for i in 0..buffer_size {
            ubo_data1[(i * 4) as usize] = i + 1;
            ubo_data2[(i * 4) as usize] = 100 + i;
        }
        let as_bytes = |data: &[u32]| -> Vec<u8> { data.iter().flat_map(|value| value.to_ne_bytes()).collect() };
        write_host_bytes(device, &ubo_buffer1, &as_bytes(&ubo_data1))?;
        write_host_bytes(device, &ubo_buffer2, &as_bytes(&ubo_data2))?;
        write_host_bytes(device, &ssbo_buffer1, &vec![0u8; data_size as usize])?;
        write_host_bytes(device, &ssbo_buffer2, &vec![0u8; data_size as usize])?;

        let ubo_info1 = vk::DescriptorBufferInfo {
            buffer: ubo_buffer1.get(),
            offset: 0,
            range: data_size,
        };
        let ubo_info2 = vk::DescriptorBufferInfo {
            buffer: ubo_buffer2.get(),
            offset: 0,
            range: data_size,
        };
        let ssbo_info1 = vk::DescriptorBufferInfo {
            buffer: ssbo_buffer1.get(),
            offset: 0,
            range: data_size,
        };
        let ssbo_info2 = vk::DescriptorBufferInfo {
            buffer: ssbo_buffer2.get(),
            offset: 0,
            range: data_size,
        };

        let ubo_infos1 = [ubo_info1];
        let ubo_infos2 = [ubo_info2];
        let ssbo_infos1 = [ssbo_info1];
        let ssbo_infos2 = [ssbo_info2];
        let descriptor_writes = [
            vk::WriteDescriptorSet::builder()
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                .buffer_info(&ubo_infos1)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_binding(1)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&ssbo_infos1)
                .build(),
        ];
        let descriptor_write2 = [vk::WriteDescriptorSet::builder()
            .dst_binding(1)
            .dst_array_element(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&ssbo_infos2)
            .build()];
        let descriptor_write3 = [vk::WriteDescriptorSet::builder()
            .dst_binding(0)
            .dst_array_element(0)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
            .buffer_info(&ubo_infos2)
            .build()];

        let info_size = std::mem::size_of::<vk::DescriptorBufferInfo>();
        let update_entries = [
            vk::DescriptorUpdateTemplateEntry::builder()
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_count(1)
                .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                .offset(0)
                .stride(info_size)
                .build(),
            vk::DescriptorUpdateTemplateEntry::builder()
                .dst_binding(1)
                .dst_array_element(0)
                .descriptor_count(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .offset(info_size)
                .stride(info_size)
                .build(),
        ];

        let (template1, template2, template3) = if with_template {
            (
                Some(create_update_template(
                    context,
                    &update_entries,
                    *bindings_layout,
                    *pipeline_layout,
                )?),
                Some(create_update_template(
                    context,
                    &update_entries[1..2],
                    *bindings_layout,
                    *pipeline_layout,
                )?),
                Some(create_update_template(
                    context,
                    &update_entries[0..1],
                    *bindings_layout,
                    *pipeline_layout,
                )?),
            )
        } else {
            (None, None, None)
        };

        // The two pushes of a step: with the writes, or through the template and its data.
        let push_writes = |writes: &[vk::WriteDescriptorSet]| unsafe {
            if commands2 {
                let info = vk::PushDescriptorSetInfo {
                    stage_flags: vk::ShaderStageFlags::COMPUTE,
                    layout: *pipeline_layout,
                    set: 0,
                    descriptor_write_count: writes.len() as u32,
                    descriptor_writes: writes.as_ptr(),
                    ..Default::default()
                };
                KhrMaintenance6ExtensionDeviceCommands::cmd_push_descriptor_set2_khr(device, cmd, &info);
            } else {
                device.cmd_push_descriptor_set_khr(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline_layout, 0, writes);
            }
        };
        let push_template = |template: &UpdateTemplate<'_>, data: *const c_void| unsafe {
            if commands2 {
                let info = vk::PushDescriptorSetWithTemplateInfo {
                    descriptor_update_template: template.handle,
                    layout: *pipeline_layout,
                    set: 0,
                    data,
                    ..Default::default()
                };
                KhrMaintenance6ExtensionDeviceCommands::cmd_push_descriptor_set_with_template2_khr(device, cmd, &info);
            } else {
                KhrPushDescriptorExtensionDeviceCommands::cmd_push_descriptor_set_with_template_khr(
                    device,
                    cmd,
                    template.handle,
                    *pipeline_layout,
                    0,
                    data,
                );
            }
        };

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        if let Some(template) = &template1 {
            let data = [ubo_info1, ssbo_info1];
            push_template(template, data.as_ptr().cast::<c_void>());
        } else {
            push_writes(&descriptor_writes);
        }
        unsafe { device.cmd_dispatch(cmd, buffer_size, 1, 1) };

        if let Some(template) = &template2 {
            let data = [ssbo_info2, ssbo_info2];
            push_template(template, data.as_ptr().cast::<c_void>());
        } else {
            push_writes(&descriptor_write2);
        }
        unsafe { device.cmd_dispatch(cmd, buffer_size, 1, 1) };

        let memory_barrier = make_memory_barrier(
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        if let Some(template) = &template3 {
            push_template(template, std::ptr::from_ref(&ubo_info2).cast::<c_void>());
        } else {
            push_writes(&descriptor_write3);
        }
        unsafe { device.cmd_dispatch(cmd, buffer_size, 1, 1) };

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, ssbo_buffer1.get_allocation())?;
        invalidate_alloc(device, ssbo_buffer2.get_allocation())?;
        let read_words = |buffer: &BufferWithMemory<'_>| -> Vec<u32> {
            (0..buffer_size as usize)
                .map(|i| unsafe {
                    buffer
                        .get_allocation()
                        .get_host_ptr()
                        .cast::<u32>()
                        .add(i)
                        .read_unaligned()
                })
                .collect()
        };
        let ssbo_data1 = read_words(&ssbo_buffer1);
        let ssbo_data2 = read_words(&ssbo_buffer2);

        for i in 0..buffer_size as usize {
            if ssbo_data1[i] != ubo_data1[i * 4] || ssbo_data2[i] != ubo_data2[i * 4] + ubo_data1[i * 4] {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `Vertex4Tex4`
#[derive(Clone, Copy)]
#[repr(C)]
struct Vertex4Tex4 {
    position: [f32; 4],
    tex_coord: [f32; 4],
}

/// `createTexQuads`
fn create_tex_quads(num_quads: u32, size: f32) -> Vec<Vertex4Tex4> {
    let mut vertices = Vec::new();

    for quad_ndx in 0..num_quads {
        let x_offset = -0.5 + quad_ndx as f32;
        let lower_left_vertex = Vertex4Tex4 {
            position: [-size + x_offset, -size, 0.0, 1.0],
            tex_coord: [-0.2, -0.2, 0.0, 0.0],
        };
        let lower_right_vertex = Vertex4Tex4 {
            position: [size + x_offset, -size, 0.0, 1.0],
            tex_coord: [1.2, -0.2, 0.0, 0.0],
        };
        let upper_left_vertex = Vertex4Tex4 {
            position: [-size + x_offset, size, 0.0, 1.0],
            tex_coord: [-0.2, 1.2, 0.0, 0.0],
        };
        let upper_right_vertex = Vertex4Tex4 {
            position: [size + x_offset, size, 0.0, 1.0],
            tex_coord: [1.2, 1.2, 0.0, 0.0],
        };

        vertices.push(lower_left_vertex);
        vertices.push(lower_right_vertex);
        vertices.push(upper_left_vertex);
        vertices.push(upper_left_vertex);
        vertices.push(lower_right_vertex);
        vertices.push(upper_right_vertex);
    }

    vertices
}

const RENDER_SIZE: (u32, u32) = (32, 32);
const TEXTURE_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// The graphics pipeline state of every case that draws quads: one binding of 32-byte vertices, position and colour/texture coordinate.
fn quad_pipeline_state(stride: u32) -> DrawPipelineState {
    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(RENDER_SIZE.0, RENDER_SIZE.1);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride,
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
    state
}

/// The color image the quads are drawn into, with its view.
fn create_color_target<'a>(
    context: &'a Context<'a>,
) -> Result<(ImageWithMemory<'a>, Unique<'a, vk::ImageView>), TestError> {
    let device = context.get_device();
    let image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: RENDER_SIZE.0,
            height: RENDER_SIZE.1,
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
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        image_info,
        MemoryRequirement::ANY,
    )?;
    let view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    Ok((image, view))
}

/// The reference rendering of `quads` against what `color_image` holds.
fn compare_with_reference(context: &Context<'_>, color_image: vk::Image, quads: &[Vertex4Rgba]) -> TestOutcome {
    let tcu_color_format = map_vk_format(COLOR_FORMAT).expect("RGBA8 has a texture format");
    let vertex_shader = ColorVertexShader::new();
    let fragment_shader = ColorFragmentShader::new(tcu_color_format, None, false);
    let program = Program {
        vertex_shader: &vertex_shader,
        fragment_shader: &fragment_shader,
        geometry_shader: None,
    };
    let mut ref_renderer = ReferenceRenderer::new(RENDER_SIZE.0, RENDER_SIZE.1, tcu_color_format, None)?;

    let render_state = RenderState::new(
        ref_renderer.get_viewport_state(),
        context.get_device_properties().limits.sub_pixel_precision_bits as i32,
    );
    ref_renderer.draw(&program, &render_state, PrimitiveType::Triangles, quads);

    let result = read_color_attachment(
        context,
        color_image,
        COLOR_FORMAT,
        RENDER_SIZE,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let compare_ok = int_threshold_position_deviation_compare(
        &ref_renderer.get_access(),
        &result.get_const_access(),
        UVec4::new(2, 2, 2, 2),
        [1, 1, 0],
        true,
    );

    if compare_ok {
        Ok(TestStatus::pass("Result image matches reference"))
    } else {
        Ok(TestStatus::fail("Image mismatch"))
    }
}

/// `createQuads` with every vertex of quad `i` coloured `colors[i]`.
fn colored_quads(num_quads: u32, size: f32, colors: &[[f32; 4]]) -> Vec<Vertex4Rgba> {
    let mut quads = create_quads(num_quads, size);
    for quad_idx in 0..num_quads as usize {
        for vertex_idx in 0..6 {
            quads[quad_idx * 6 + vertex_idx].color = colors[quad_idx];
        }
    }
    quads
}

struct ClearedTextures<'a> {
    _images: Vec<ImageWithMemory<'a>>,
    views: Vec<Unique<'a, vk::ImageView>>,
}

/// The two textures of the image and input attachment cases: texture 0 cleared to green and texture 1 to red, in `new_layout`.
fn create_cleared_textures<'a>(
    context: &'a Context<'a>,
    usage: vk::ImageUsageFlags,
    new_layout: vk::ImageLayout,
    dst_access: vk::AccessFlags,
    dst_stage: vk::PipelineStageFlags,
) -> Result<ClearedTextures<'a>, TestError> {
    let device = context.get_device();
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let mut images = Vec::new();
    let mut views = Vec::new();

    for tex_idx in 0..2 {
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: TEXTURE_SIZE,
                height: TEXTURE_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            range,
        )?);

        // Clear the texture
        let clear_color = if tex_idx == 0 {
            [0.0f32, 1.0, 0.0, 1.0]
        } else {
            [1.0f32, 0.0, 0.0, 1.0]
        };
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let pre_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image.get(),
            range,
        );
        let post_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            dst_access,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            new_layout,
            image.get(),
            range,
        );

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_image_barrier],
            );
            device.cmd_clear_color_image(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &vk::ClearColorValue { float32: clear_color },
                &[range],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_image_barrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        images.push(image);
    }

    Ok(ClearedTextures { _images: images, views })
}

/// One sampler with a white and one with a black border colour, to have a visible effect on switching the sampler.
fn create_border_sampler(device: &Device, border_color: vk::BorderColor) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_BORDER)
        .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_BORDER)
        .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_BORDER)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(0.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::NEVER)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(border_color)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

fn is_image_type(descriptor_type: vk::DescriptorType) -> bool {
    matches!(
        descriptor_type,
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER
            | vk::DescriptorType::SAMPLER
            | vk::DescriptorType::SAMPLED_IMAGE
            | vk::DescriptorType::STORAGE_IMAGE
    )
}

/// The descriptors (type and binding) of the image cases' set layout, in the order upstream adds them.
fn image_layout_bindings(descriptor_type: vk::DescriptorType, binding: u32) -> Vec<(vk::DescriptorType, u32)> {
    match descriptor_type {
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER => vec![(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, binding)],
        vk::DescriptorType::SAMPLER => vec![
            (vk::DescriptorType::SAMPLER, binding),
            (vk::DescriptorType::SAMPLED_IMAGE, binding + 1),
        ],
        vk::DescriptorType::SAMPLED_IMAGE => vec![
            (vk::DescriptorType::SAMPLER, binding + 1),
            (vk::DescriptorType::SAMPLED_IMAGE, binding),
        ],
        _ => vec![(vk::DescriptorType::STORAGE_IMAGE, binding)],
    }
}

/// The samplers and image views the first and second call use.
fn pick_samplers_and_views(
    descriptor_type: vk::DescriptorType,
    white: vk::Sampler,
    black: vk::Sampler,
    views: &[vk::ImageView],
) -> ([vk::Sampler; 2], [vk::ImageView; 2]) {
    // Vary the sampler between the calls only for a sampler and a combined image sampler, the image view for everything but a sampler.
    let second_sampler = if matches!(
        descriptor_type,
        vk::DescriptorType::SAMPLER | vk::DescriptorType::COMBINED_IMAGE_SAMPLER
    ) {
        black
    } else {
        white
    };
    let second_view = if matches!(
        descriptor_type,
        vk::DescriptorType::SAMPLED_IMAGE
            | vk::DescriptorType::COMBINED_IMAGE_SAMPLER
            | vk::DescriptorType::STORAGE_IMAGE
    ) {
        views[1]
    } else {
        views[0]
    };
    ([white, second_sampler], [views[0], second_view])
}

/// The descriptor writes of one call: the descriptor itself and, for a sampler or a sampled image, its counterpart.
fn image_descriptor_writes(
    descriptor_type: vk::DescriptorType,
    binding: u32,
    image_info: &[vk::DescriptorImageInfo; 1],
) -> Vec<vk::WriteDescriptorSet> {
    let write = |dst_binding: u32, ty: vk::DescriptorType| {
        vk::WriteDescriptorSet::builder()
            .dst_binding(dst_binding)
            .dst_array_element(0)
            .descriptor_type(ty)
            .image_info(image_info)
            .build()
    };

    let mut writes = vec![write(binding, descriptor_type)];
    if descriptor_type == vk::DescriptorType::SAMPLER {
        // Sampler also needs an image.
        writes.push(write(binding + 1, vk::DescriptorType::SAMPLED_IMAGE));
    } else if descriptor_type == vk::DescriptorType::SAMPLED_IMAGE {
        // Image also needs a sampler.
        writes.push(write(binding + 1, vk::DescriptorType::SAMPLER));
    }
    writes
}

fn image_graphics_programs(descriptor_type: vk::DescriptorType, binding: u32) -> BinaryCollection {
    match (descriptor_type, binding) {
        (vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 0) => PD_IMAGE_GRAPHICS_COMBINED_BINDING0.programs,
        (vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1) => PD_IMAGE_GRAPHICS_COMBINED_BINDING1.programs,
        (vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 3) => PD_IMAGE_GRAPHICS_COMBINED_BINDING3.programs,
        (vk::DescriptorType::SAMPLER, 0) => PD_IMAGE_GRAPHICS_SAMPLER_BINDING0.programs,
        (vk::DescriptorType::SAMPLER, 1) => PD_IMAGE_GRAPHICS_SAMPLER_BINDING1.programs,
        (vk::DescriptorType::SAMPLER, 3) => PD_IMAGE_GRAPHICS_SAMPLER_BINDING3.programs,
        (vk::DescriptorType::SAMPLED_IMAGE, 0) => PD_IMAGE_GRAPHICS_SAMPLED_IMAGE_BINDING0.programs,
        (vk::DescriptorType::SAMPLED_IMAGE, 1) => PD_IMAGE_GRAPHICS_SAMPLED_IMAGE_BINDING1.programs,
        (vk::DescriptorType::SAMPLED_IMAGE, 3) => PD_IMAGE_GRAPHICS_SAMPLED_IMAGE_BINDING3.programs,
        (vk::DescriptorType::STORAGE_IMAGE, 0) => PD_IMAGE_GRAPHICS_STORAGE_BINDING0.programs,
        (vk::DescriptorType::STORAGE_IMAGE, 1) => PD_IMAGE_GRAPHICS_STORAGE_BINDING1.programs,
        (vk::DescriptorType::STORAGE_IMAGE, 3) => PD_IMAGE_GRAPHICS_STORAGE_BINDING3.programs,
        _ => BinaryCollection::new(&[]),
    }
}

fn image_compute_programs(descriptor_type: vk::DescriptorType, binding: u32) -> BinaryCollection {
    match (descriptor_type, binding) {
        (vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 0) => PD_IMAGE_COMPUTE_COMBINED_BINDING0.programs,
        (vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1) => PD_IMAGE_COMPUTE_COMBINED_BINDING1.programs,
        (vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 3) => PD_IMAGE_COMPUTE_COMBINED_BINDING3.programs,
        (vk::DescriptorType::SAMPLER, 0) => PD_IMAGE_COMPUTE_SAMPLER_BINDING0.programs,
        (vk::DescriptorType::SAMPLER, 1) => PD_IMAGE_COMPUTE_SAMPLER_BINDING1.programs,
        (vk::DescriptorType::SAMPLER, 3) => PD_IMAGE_COMPUTE_SAMPLER_BINDING3.programs,
        (vk::DescriptorType::SAMPLED_IMAGE, 0) => PD_IMAGE_COMPUTE_SAMPLED_IMAGE_BINDING0.programs,
        (vk::DescriptorType::SAMPLED_IMAGE, 1) => PD_IMAGE_COMPUTE_SAMPLED_IMAGE_BINDING1.programs,
        (vk::DescriptorType::SAMPLED_IMAGE, 3) => PD_IMAGE_COMPUTE_SAMPLED_IMAGE_BINDING3.programs,
        (vk::DescriptorType::STORAGE_IMAGE, 0) => PD_IMAGE_COMPUTE_STORAGE_BINDING0.programs,
        (vk::DescriptorType::STORAGE_IMAGE, 1) => PD_IMAGE_COMPUTE_STORAGE_BINDING1.programs,
        (vk::DescriptorType::STORAGE_IMAGE, 3) => PD_IMAGE_COMPUTE_STORAGE_BINDING3.programs,
        _ => BinaryCollection::new(&[]),
    }
}

/// `PushDescriptorImageGraphicsTest`
struct PushDescriptorImageGraphicsTest {
    name: String,
    params: TestParams,
}

impl TestCase for PushDescriptorImageGraphicsTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        image_graphics_programs(self.params.descriptor_type, self.params.binding)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorImageGraphicsInstance {
            context,
            params: self.params,
        })
    }
}

struct PushDescriptorImageGraphicsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for PushDescriptorImageGraphicsInstance<'_> {
    /// `PushDescriptorImageGraphicsTestInstance::init`, `iterate` and `verifyImage`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let vertices = create_tex_quads(params.num_calls, 0.25);

        let (color_image, color_attachment_view) = create_color_target(context)?;

        // Create the textures, cleared to green and red
        let is_storage = params.descriptor_type == vk::DescriptorType::STORAGE_IMAGE;
        let texture_usage = if is_storage {
            vk::ImageUsageFlags::STORAGE
        } else {
            vk::ImageUsageFlags::SAMPLED
        };
        let texture_image_layout = if is_storage {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        };
        let textures = create_cleared_textures(
            context,
            texture_usage,
            texture_image_layout,
            vk::AccessFlags::SHADER_READ,
            vk::PipelineStageFlags::ALL_GRAPHICS,
        )?;

        let white_border_sampler = create_border_sampler(device, vk::BorderColor::FLOAT_OPAQUE_WHITE)?;
        let black_border_sampler = create_border_sampler(device, vk::BorderColor::FLOAT_OPAQUE_BLACK)?;

        // Create render pass and framebuffer
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view],
            RENDER_SIZE.0,
            RENDER_SIZE.1,
            1,
        )?;

        // Create the push descriptor set layout and the pipeline layout
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for (descriptor_type, binding) in image_layout_bindings(params.descriptor_type, params.binding) {
            layout_builder =
                layout_builder.add_indexed_binding(descriptor_type, vk::ShaderStageFlags::FRAGMENT, binding, 1);
        }
        let descriptor_set_layout =
            layout_builder.build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create shaders and pipeline
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;
        let state = quad_pipeline_state(std::mem::size_of::<Vertex4Tex4>() as u32);
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[*descriptor_set_layout], &[])?;
        let graphics_pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
                ],
                &state,
            )?)
        };

        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            graphics_pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, RENDER_SIZE.0, RENDER_SIZE.1),
            &[default_clear_value(COLOR_FORMAT)],
            &[(color_image.get(), *color_attachment_view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        }

        // Draw quads. Switch sampler or image view depending on the test.
        let view_handles: Vec<vk::ImageView> = textures.views.iter().map(|view| **view).collect();
        let (samplers, image_views) = pick_samplers_and_views(
            params.descriptor_type,
            *white_border_sampler,
            *black_border_sampler,
            &view_handles,
        );
        for quad_ndx in 0..params.num_calls as usize {
            let descriptor_image_info = [vk::DescriptorImageInfo {
                sampler: samplers[quad_ndx],
                image_view: image_views[quad_ndx],
                image_layout: texture_image_layout,
            }];
            let write_descriptor_sets =
                image_descriptor_writes(params.descriptor_type, params.binding, &descriptor_image_info);

            unsafe {
                device.cmd_push_descriptor_set_khr(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &write_descriptor_sets,
                );
                device.cmd_draw(cmd, 6, 1, 6 * quad_ndx as u32, 0);
            }
        }

        end_draw(device, cmd, shader_objects.is_some());
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify the image: the colours of the quad and of its border
        let ref_quads_outer = create_quads(params.num_calls, 0.25);
        let ref_quads_inner = create_quads(params.num_calls, 0.25 * 0.8);
        let has_border = !is_storage;
        let mut outer_color = [[0.0f32; 4]; 2];
        let mut inner_color = [[0.0f32; 4]; 2];

        if has_border {
            outer_color[0] = [1.0, 1.0, 1.0, 1.0];
            inner_color[0] = [0.0, 1.0, 0.0, 1.0];
            outer_color[1] = if params.descriptor_type == vk::DescriptorType::SAMPLED_IMAGE {
                [1.0, 1.0, 1.0, 1.0]
            } else {
                [0.0, 0.0, 0.0, 1.0]
            };
            inner_color[1] = if params.descriptor_type == vk::DescriptorType::SAMPLER {
                [0.0, 1.0, 0.0, 1.0]
            } else {
                [1.0, 0.0, 0.0, 1.0]
            };
        } else {
            outer_color[0] = [0.0, 1.0, 0.0, 1.0];
            outer_color[1] = [1.0, 0.0, 0.0, 1.0];
        }

        let mut ref_quads_outer = ref_quads_outer;
        let mut ref_quads_inner = ref_quads_inner;
        for quad_idx in 0..params.num_calls as usize {
            for vertex_idx in 0..6 {
                let idx = quad_idx * 6 + vertex_idx;
                ref_quads_outer[idx].color = outer_color[quad_idx];
                ref_quads_inner[idx].color = inner_color[quad_idx];
            }
        }
        if has_border {
            ref_quads_outer.extend_from_slice(&ref_quads_inner);
        }

        compare_with_reference(context, color_image.get(), &ref_quads_outer)
    }
}

/// `PushDescriptorImageComputeTest`
struct PushDescriptorImageComputeTest {
    name: String,
    params: TestParams,
}

impl TestCase for PushDescriptorImageComputeTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        image_compute_programs(self.params.descriptor_type, self.params.binding)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorImageComputeInstance {
            context,
            params: self.params,
        })
    }
}

struct PushDescriptorImageComputeInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for PushDescriptorImageComputeInstance<'_> {
    /// `PushDescriptorImageComputeTestInstance::init`, `iterate` and `verifyOutput`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let item_size = calc_item_size(context, 2);
        let block_size = SIZEOF_VEC4 * 2;

        // Create the textures, cleared to green and red
        let is_storage = params.descriptor_type == vk::DescriptorType::STORAGE_IMAGE;
        let texture_usage = if is_storage {
            vk::ImageUsageFlags::STORAGE
        } else {
            vk::ImageUsageFlags::SAMPLED
        };
        let texture_image_layout = if is_storage {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        };
        let textures = create_cleared_textures(
            context,
            texture_usage,
            texture_image_layout,
            vk::AccessFlags::SHADER_READ,
            vk::PipelineStageFlags::COMPUTE_SHADER,
        )?;

        let white_border_sampler = create_border_sampler(device, vk::BorderColor::FLOAT_OPAQUE_WHITE)?;
        let black_border_sampler = create_border_sampler(device, vk::BorderColor::FLOAT_OPAQUE_BLACK)?;

        // Create the push descriptor set layout, with the output buffer after the image descriptors, and the pipeline layout
        let output_buffer_binding = match params.descriptor_type {
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER | vk::DescriptorType::STORAGE_IMAGE => params.binding + 1,
            _ => params.binding + 2,
        };
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for (descriptor_type, binding) in image_layout_bindings(params.descriptor_type, params.binding) {
            layout_builder =
                layout_builder.add_indexed_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE, binding, 1);
        }
        layout_builder = layout_builder.add_indexed_binding(
            vk::DescriptorType::STORAGE_BUFFER,
            vk::ShaderStageFlags::COMPUTE,
            output_buffer_binding,
            1,
        );
        let descriptor_set_layout =
            layout_builder.build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create output buffer
        debug_assert!(params.num_calls <= 2);
        let output_buffer = create_buffer(context, item_size * 2, vk::BufferUsageFlags::STORAGE_BUFFER, false)?;

        // Create shader and pipeline
        let compute_shader_module = create_shader_module(device, context.get_binary_collection().get("compute")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_shader_module)
            .name(c"main".to_bytes_with_nul());
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, pipelines.0[0]);

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        // Dispatch: Each dispatch switches the input image.
        // Output buffer is exposed as a 2 x vec4 sized window.
        let view_handles: Vec<vk::ImageView> = textures.views.iter().map(|view| **view).collect();
        let (samplers, image_views) = pick_samplers_and_views(
            params.descriptor_type,
            *white_border_sampler,
            *black_border_sampler,
            &view_handles,
        );
        for dispatch_ndx in 0..params.num_calls as usize {
            let descriptor_image_info = [vk::DescriptorImageInfo {
                sampler: samplers[dispatch_ndx],
                image_view: image_views[dispatch_ndx],
                image_layout: texture_image_layout,
            }];
            let mut write_descriptor_sets =
                image_descriptor_writes(params.descriptor_type, params.binding, &descriptor_image_info);

            // Write output buffer descriptor set
            let descriptor_buffer_info_output = [vk::DescriptorBufferInfo {
                buffer: output_buffer.get(),
                offset: item_size * dispatch_ndx as u64,
                range: block_size,
            }];
            write_descriptor_sets.push(
                vk::WriteDescriptorSet::builder()
                    .dst_binding(output_buffer_binding)
                    .dst_array_element(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&descriptor_buffer_info_output)
                    .build(),
            );

            let barrier = [vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build()];
            unsafe {
                device.cmd_push_descriptor_set_khr(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &write_descriptor_sets,
                );
                device.cmd_dispatch(cmd, 1, 1, 1);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &barrier,
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify the output: 8 floats (2 vec4s) per dispatch
        const FLOATS_PER_DISPATCH: usize = 8;
        let reference: [f32; 2 * FLOATS_PER_DISPATCH] = match params.descriptor_type {
            // Dispatch 1: inner & outer = green; dispatch 2: inner & outer = red
            vk::DescriptorType::STORAGE_IMAGE => [
                0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0,
            ],
            // Dispatch 1: inner = green, outer = white; dispatch 2: inner = red, outer = black
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER => [
                0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0,
            ],
            // Dispatch 1: inner = green, outer = white; dispatch 2: inner = green, outer = black
            vk::DescriptorType::SAMPLER => [
                0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0,
            ],
            // Dispatch 1: inner = green, outer = white; dispatch 2: inner = red, outer = white
            _ => [
                0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0,
            ],
        };

        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let buffer_data_ptr = output_alloc.get_host_ptr();
        for dispatch_ndx in 0..params.num_calls as usize {
            let ref_idx = FLOATS_PER_DISPATCH * dispatch_ndx;
            let buffer_offset = item_size as usize * dispatch_ndx; // Each dispatch uses item_size bytes in the buffer to meet alignment reqs.

            let mut expected = [0u8; 4 * FLOATS_PER_DISPATCH];
            for (i, value) in reference[ref_idx..ref_idx + FLOATS_PER_DISPATCH].iter().enumerate() {
                expected[i * 4..i * 4 + 4].copy_from_slice(&value.to_ne_bytes());
            }
            let mut actual = [0u8; 4 * FLOATS_PER_DISPATCH];
            unsafe {
                std::ptr::copy_nonoverlapping(buffer_data_ptr.add(buffer_offset), actual.as_mut_ptr(), actual.len())
            };

            if actual != expected {
                return Ok(TestStatus::fail("Output mismatch"));
            }
        }

        Ok(TestStatus::pass("Output matches expected values"))
    }
}

fn is_uniform_texel(descriptor_type: vk::DescriptorType) -> bool {
    descriptor_type == vk::DescriptorType::UNIFORM_TEXEL_BUFFER
}

fn texel_buffer_usage(descriptor_type: vk::DescriptorType) -> vk::BufferUsageFlags {
    if is_uniform_texel(descriptor_type) {
        vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
    } else {
        vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
    }
}

fn texel_graphics_programs(descriptor_type: vk::DescriptorType, binding: u32) -> BinaryCollection {
    match (is_uniform_texel(descriptor_type), binding) {
        (true, 0) => PD_TEXEL_GRAPHICS_UNIFORM_BINDING0.programs,
        (true, 1) => PD_TEXEL_GRAPHICS_UNIFORM_BINDING1.programs,
        (true, 3) => PD_TEXEL_GRAPHICS_UNIFORM_BINDING3.programs,
        (false, 0) => PD_TEXEL_GRAPHICS_STORAGE_BINDING0.programs,
        (false, 1) => PD_TEXEL_GRAPHICS_STORAGE_BINDING1.programs,
        (false, 3) => PD_TEXEL_GRAPHICS_STORAGE_BINDING3.programs,
        _ => BinaryCollection::new(&[]),
    }
}

fn texel_compute_programs(descriptor_type: vk::DescriptorType, binding: u32) -> BinaryCollection {
    match (is_uniform_texel(descriptor_type), binding) {
        (true, 0) => PD_TEXEL_COMPUTE_UNIFORM_BINDING0.programs,
        (true, 1) => PD_TEXEL_COMPUTE_UNIFORM_BINDING1.programs,
        (true, 3) => PD_TEXEL_COMPUTE_UNIFORM_BINDING3.programs,
        (false, 0) => PD_TEXEL_COMPUTE_STORAGE_BINDING0.programs,
        (false, 1) => PD_TEXEL_COMPUTE_STORAGE_BINDING1.programs,
        (false, 3) => PD_TEXEL_COMPUTE_STORAGE_BINDING3.programs,
        _ => BinaryCollection::new(&[]),
    }
}

/// The two texel buffers holding the test colours, and their `VK_FORMAT_R32G32B32A32_SFLOAT` views.
fn create_texel_buffers<'a>(
    context: &'a Context<'a>,
    params: &TestParams,
) -> Result<(Vec<BufferWithMemory<'a>>, Vec<Unique<'a, vk::BufferView>>), TestError> {
    let device = context.get_device();
    let mut buffers = Vec::new();
    for color in DEFAULT_TEST_COLORS {
        let buffer = create_buffer(
            context,
            SIZEOF_VEC4,
            texel_buffer_usage(params.descriptor_type),
            params.use_maintenance5,
        )?;
        write_host_bytes(device, &buffer, &color_bytes(color))?;
        buffers.push(buffer);
    }

    let mut buffer_views = Vec::new();
    for buffer in &buffers {
        let info = vk::BufferViewCreateInfo::builder()
            .buffer(buffer.get())
            .format(vk::Format::R32G32B32A32_SFLOAT)
            .offset(0)
            .range(vk::WHOLE_SIZE);
        let view = unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?;
        buffer_views.push(Unique::new(device, view));
    }

    Ok((buffers, buffer_views))
}

/// `PushDescriptorTexelBufferGraphicsTest`
struct PushDescriptorTexelBufferGraphicsTest {
    name: String,
    params: TestParams,
}

impl TestCase for PushDescriptorTexelBufferGraphicsTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        texel_graphics_programs(self.params.descriptor_type, self.params.binding)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorTexelBufferGraphicsInstance {
            context,
            params: self.params,
        })
    }
}

struct PushDescriptorTexelBufferGraphicsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for PushDescriptorTexelBufferGraphicsInstance<'_> {
    /// `PushDescriptorTexelBufferGraphicsTestInstance::init`, `iterate` and `verifyImage`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let vertices = create_quads(params.num_calls, 0.25);

        let (color_image, color_attachment_view) = create_color_target(context)?;

        // Create buffers and buffer views
        let (_buffers, buffer_views) = create_texel_buffers(context, &params)?;

        // Create render pass and framebuffer
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view],
            RENDER_SIZE.0,
            RENDER_SIZE.1,
            1,
        )?;

        // Create the push descriptor set layout and the pipeline layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                params.descriptor_type,
                vk::ShaderStageFlags::FRAGMENT,
                params.binding,
                1,
            )
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create shaders and pipeline
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;
        let state = quad_pipeline_state(std::mem::size_of::<Vertex4Rgba>() as u32);
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[*descriptor_set_layout], &[])?;
        let graphics_pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
                ],
                &state,
            )?)
        };

        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            graphics_pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, RENDER_SIZE.0, RENDER_SIZE.1),
            &[default_clear_value(COLOR_FORMAT)],
            &[(color_image.get(), *color_attachment_view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        }

        // Draw quads. Switch buffer view between draws.
        for quad_ndx in 0..params.num_calls as usize {
            let texel_buffer_views = [*buffer_views[quad_ndx]];
            let write_descriptor_set = vk::WriteDescriptorSet::builder()
                .dst_binding(params.binding)
                .dst_array_element(0)
                .descriptor_type(params.descriptor_type)
                .texel_buffer_view(&texel_buffer_views)
                .build();

            unsafe {
                device.cmd_push_descriptor_set_khr(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[write_descriptor_set],
                );
                device.cmd_draw(cmd, 6, 1, 6 * quad_ndx as u32, 0);
            }
        }

        end_draw(device, cmd, shader_objects.is_some());
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        compare_with_reference(
            context,
            color_image.get(),
            &colored_quads(params.num_calls, 0.25, &DEFAULT_TEST_COLORS),
        )
    }
}

/// `PushDescriptorTexelBufferComputeTest`
struct PushDescriptorTexelBufferComputeTest {
    name: String,
    params: TestParams,
}

impl TestCase for PushDescriptorTexelBufferComputeTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        texel_compute_programs(self.params.descriptor_type, self.params.binding)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorTexelBufferComputeInstance {
            context,
            params: self.params,
        })
    }
}

struct PushDescriptorTexelBufferComputeInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for PushDescriptorTexelBufferComputeInstance<'_> {
    /// `PushDescriptorTexelBufferComputeTestInstance::init`, `iterate` and `verifyOutput`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let item_size = calc_item_size(context, 1);

        // Create buffers and buffer views
        let (_buffers, buffer_views) = create_texel_buffers(
            context,
            &TestParams {
                use_maintenance5: false,
                ..params
            },
        )?;

        // Create the push descriptor set layout and the pipeline layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(params.descriptor_type, vk::ShaderStageFlags::COMPUTE, params.binding, 1)
            .add_indexed_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::COMPUTE,
                params.binding + 1,
                1,
            )
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create output buffer
        debug_assert!(params.num_calls <= 2);
        let output_buffer = create_buffer(
            context,
            item_size * u64::from(params.num_calls),
            vk::BufferUsageFlags::STORAGE_BUFFER,
            false,
        )?;

        // Create shader and pipeline
        let compute_shader_module = create_shader_module(device, context.get_binary_collection().get("compute")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_shader_module)
            .name(c"main".to_bytes_with_nul());
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, pipelines.0[0]);

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        // Dispatch: Each dispatch switches the input buffer view.
        // Output buffer is exposed as a vec4 sized window.
        for dispatch_ndx in 0..params.num_calls as usize {
            let texel_buffer_views = [*buffer_views[dispatch_ndx]];
            let descriptor_buffer_info_output = [vk::DescriptorBufferInfo {
                buffer: output_buffer.get(),
                offset: item_size * dispatch_ndx as u64,
                range: SIZEOF_VEC4,
            }];
            let write_descriptor_sets = [
                vk::WriteDescriptorSet::builder()
                    .dst_binding(params.binding)
                    .dst_array_element(0)
                    .descriptor_type(params.descriptor_type)
                    .texel_buffer_view(&texel_buffer_views)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_binding(params.binding + 1)
                    .dst_array_element(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&descriptor_buffer_info_output)
                    .build(),
            ];

            let barrier = [vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build()];
            unsafe {
                device.cmd_push_descriptor_set_khr(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &write_descriptor_sets,
                );
                device.cmd_dispatch(cmd, 1, 1, 1);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &barrier,
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify result
        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let buffer_ptr = output_alloc.get_host_ptr();
        for i in 0..params.num_calls as usize {
            let mut buffer_color = [0u8; 16];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    buffer_ptr.add(i * item_size as usize),
                    buffer_color.as_mut_ptr(),
                    buffer_color.len(),
                )
            };

            if buffer_color != color_bytes(DEFAULT_TEST_COLORS[i]) {
                return Err(TestError::Fail(format!(
                    "Output mismatch at item {i}: expected {:?}",
                    DEFAULT_TEST_COLORS[i]
                )));
            }
        }

        Ok(TestStatus::pass("Output matches expected values"))
    }
}

fn input_attachment_programs(binding: u32) -> BinaryCollection {
    match binding {
        0 => PD_INPUT_ATTACHMENT_BINDING0.programs,
        1 => PD_INPUT_ATTACHMENT_BINDING1.programs,
        3 => PD_INPUT_ATTACHMENT_BINDING3.programs,
        _ => BinaryCollection::new(&[]),
    }
}

/// `PushDescriptorInputAttachmentGraphicsTest`
struct PushDescriptorInputAttachmentGraphicsTest {
    name: String,
    params: TestParams,
}

impl TestCase for PushDescriptorInputAttachmentGraphicsTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_supported(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        input_attachment_programs(self.params.binding)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushDescriptorInputAttachmentGraphicsInstance {
            context,
            params: self.params,
        })
    }
}

struct PushDescriptorInputAttachmentGraphicsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for PushDescriptorInputAttachmentGraphicsInstance<'_> {
    /// `PushDescriptorInputAttachmentGraphicsTestInstance::init`, `iterate` and `verifyImage`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let vertices = create_tex_quads(params.num_calls, 0.25);

        let (color_image, color_attachment_view) = create_color_target(context)?;

        // Create the input images, cleared to green and red
        let input_images = create_cleared_textures(
            context,
            vk::ImageUsageFlags::INPUT_ATTACHMENT,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            vk::AccessFlags::INPUT_ATTACHMENT_READ,
            vk::PipelineStageFlags::ALL_GRAPHICS,
        )?;

        // Create render passes and framebuffers
        let mut render_passes = Vec::new();
        let mut framebuffers = Vec::new();
        for render_pass_idx in 0..2 {
            // The first pass clears the output image, and the second one draws on top of the first pass.
            let load_ops = [vk::AttachmentLoadOp::CLEAR, vk::AttachmentLoadOp::LOAD];
            let initial_layouts = [vk::ImageLayout::UNDEFINED, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL];

            let attachment_descriptions = [
                // Result attachment
                vk::AttachmentDescription::builder()
                    .format(COLOR_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(load_ops[render_pass_idx])
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(initial_layouts[render_pass_idx])
                    .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .build(),
                // Input attachment
                vk::AttachmentDescription::builder()
                    .format(COLOR_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
                    .final_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
                    .build(),
            ];

            let result_attachment_refs = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let input_attachment_refs = [vk::AttachmentReference {
                attachment: 1,
                layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let subpass_descriptions = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .input_attachments(&input_attachment_refs)
                .color_attachments(&result_attachment_refs)
                .build()];
            let subpass_dependencies = [vk::SubpassDependency {
                src_subpass: vk::SUBPASS_EXTERNAL,
                dst_subpass: 0,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ | vk::AccessFlags::SHADER_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            }];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descriptions)
                .subpasses(&subpass_descriptions)
                .dependencies(&subpass_dependencies);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );

            let attachment_bind_infos = [*color_attachment_view, *input_images.views[render_pass_idx]];
            framebuffers.push(make_framebuffer(
                device,
                *render_pass,
                &attachment_bind_infos,
                RENDER_SIZE.0,
                RENDER_SIZE.1,
                1,
            )?);
            render_passes.push(render_pass);
        }

        // Create the push descriptor set layout and the pipeline layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::INPUT_ATTACHMENT,
                vk::ShaderStageFlags::FRAGMENT,
                params.binding,
                1,
            )
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create shaders and one pipeline per render pass
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;
        let state = quad_pipeline_state(std::mem::size_of::<Vertex4Tex4>() as u32);
        let mut graphics_pipelines = Vec::new();
        for render_pass in &render_passes {
            graphics_pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                **render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
                ],
                &state,
            )?);
        }

        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        for quad_ndx in 0..params.num_calls as usize {
            begin_render_pass(
                device,
                cmd,
                *render_passes[quad_ndx],
                *framebuffers[quad_ndx],
                make_rect_2d(0, 0, RENDER_SIZE.0, RENDER_SIZE.1),
                default_clear_value(COLOR_FORMAT),
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[quad_ndx]);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            }

            let descriptor_image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *input_images.views[quad_ndx],
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let write_descriptor_set = vk::WriteDescriptorSet::builder()
                .dst_binding(params.binding)
                .dst_array_element(0)
                .descriptor_type(params.descriptor_type)
                .image_info(&descriptor_image_info)
                .build();

            unsafe {
                device.cmd_push_descriptor_set_khr(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[write_descriptor_set],
                );
                device.cmd_draw(cmd, 6, 1, 6 * quad_ndx as u32, 0);
            }

            end_render_pass(device, cmd);
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        compare_with_reference(
            context,
            color_image.get(),
            &colored_quads(params.num_calls, 0.25, &[[0.0, 1.0, 0.0, 1.0], [1.0, 0.0, 0.0, 1.0]]),
        )
    }
}

/// `createPushDescriptorTests` for the monolithic and library construction types.
pub fn create_push_descriptor_tests() -> TestCaseGroup {
    create_push_descriptor_tests_for(false)
}

/// `createPushDescriptorTests`; the shader object types have the graphics group without the input attachment cases,
/// the maintenance5 cases and the compute group.
pub fn create_push_descriptor_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut push_descriptor_tests = TestCaseGroup::new("push_descriptor");
    let mut graphics_tests = TestCaseGroup::new("graphics");
    let mut compute_tests = TestCaseGroup::new("compute");

    let descriptor_types = [
        vk::DescriptorType::UNIFORM_BUFFER,
        vk::DescriptorType::STORAGE_BUFFER,
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
        vk::DescriptorType::SAMPLER,
        vk::DescriptorType::SAMPLED_IMAGE,
        vk::DescriptorType::STORAGE_IMAGE,
        vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
        vk::DescriptorType::STORAGE_TEXEL_BUFFER,
        vk::DescriptorType::INPUT_ATTACHMENT,
    ];
    // (binding, numCalls) as upstream's table lists them for every descriptor type; the storage buffer has one more entry
    let binding_and_calls = [(0, 1), (0, 2), (1, 2), (3, 2)];

    for descriptor_type in descriptor_types {
        let mut table: Vec<(u32, u32)> = binding_and_calls.to_vec();
        if descriptor_type == vk::DescriptorType::STORAGE_BUFFER {
            table.push((1, 128));
        }

        for (binding, num_calls) in table {
            let params = TestParams {
                descriptor_type,
                binding,
                num_calls,
                use_maintenance5: false,
                use_maintenance6: false,
            };
            let mut test_name = format!("binding{binding}_numcalls{num_calls}");
            test_name += match descriptor_type {
                vk::DescriptorType::UNIFORM_BUFFER => "_uniform_buffer",
                vk::DescriptorType::STORAGE_BUFFER => "_storage_buffer",
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER => "_combined_image_sampler",
                vk::DescriptorType::SAMPLED_IMAGE => "_sampled_image",
                vk::DescriptorType::SAMPLER => "_sampler",
                vk::DescriptorType::STORAGE_IMAGE => "_storage_image",
                vk::DescriptorType::UNIFORM_TEXEL_BUFFER => "_uniform_texel_buffer",
                vk::DescriptorType::STORAGE_TEXEL_BUFFER => "_storage_texel_buffer",
                _ => "_input_attachment",
            };

            match descriptor_type {
                vk::DescriptorType::UNIFORM_BUFFER | vk::DescriptorType::STORAGE_BUFFER => {
                    if num_calls <= 2 {
                        graphics_tests.add_child(Box::new(PushDescriptorBufferGraphicsTest {
                            name: test_name.clone(),
                            params,
                        }) as Box<dyn TestCase>);
                    }
                    if !shader_object {
                        compute_tests.add_child(Box::new(PushDescriptorBufferComputeTest {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
                ty if is_image_type(ty) => {
                    graphics_tests.add_child(Box::new(PushDescriptorImageGraphicsTest {
                        name: test_name.clone(),
                        params,
                    }) as Box<dyn TestCase>);
                    if !shader_object {
                        compute_tests.add_child(Box::new(PushDescriptorImageComputeTest {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
                vk::DescriptorType::UNIFORM_TEXEL_BUFFER | vk::DescriptorType::STORAGE_TEXEL_BUFFER => {
                    graphics_tests.add_child(Box::new(PushDescriptorTexelBufferGraphicsTest {
                        name: test_name.clone(),
                        params,
                    }) as Box<dyn TestCase>);
                    if !shader_object {
                        compute_tests.add_child(Box::new(PushDescriptorTexelBufferComputeTest {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
                _ if shader_object => {}
                _ => {
                    graphics_tests.add_child(Box::new(PushDescriptorInputAttachmentGraphicsTest {
                        name: test_name,
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }

    if shader_object {
        push_descriptor_tests.add_child(graphics_tests);
        return push_descriptor_tests;
    }

    let mut test_params = TestParams {
        descriptor_type: vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
        binding: 0,
        num_calls: 1,
        use_maintenance5: true,
        use_maintenance6: false,
    };
    graphics_tests.add_child(Box::new(PushDescriptorTexelBufferGraphicsTest {
        name: "maintenance5_uniform_texel_buffer".to_string(),
        params: test_params,
    }) as Box<dyn TestCase>);
    test_params.descriptor_type = vk::DescriptorType::STORAGE_TEXEL_BUFFER;
    graphics_tests.add_child(Box::new(PushDescriptorTexelBufferGraphicsTest {
        name: "maintenance5_storage_texel_buffer".to_string(),
        params: test_params,
    }) as Box<dyn TestCase>);
    test_params.descriptor_type = vk::DescriptorType::UNIFORM_BUFFER;
    graphics_tests.add_child(Box::new(PushDescriptorBufferGraphicsTest {
        name: "maintenance5_uniform_buffer".to_string(),
        params: test_params,
    }) as Box<dyn TestCase>);

    for i in 0..4 {
        let use_template = i % 2 == 1;
        let commands2 = i / 2 == 1;
        let mut name = "incremental_updates".to_string();
        if use_template {
            name += "_template";
        }
        if commands2 {
            name += "_2";
        }
        let incremental_update_params = TestParams {
            descriptor_type: vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
            binding: 0,
            num_calls: 3,
            use_maintenance5: false,
            use_maintenance6: commands2,
        };
        compute_tests.add_child(Box::new(PushDescriptorIncrementalUpdatesComputeTest {
            name,
            params: incremental_update_params,
            with_template: use_template,
            commands2,
        }) as Box<dyn TestCase>);
    }

    push_descriptor_tests.add_child(graphics_tests);
    push_descriptor_tests.add_child(compute_tests);
    push_descriptor_tests
}
