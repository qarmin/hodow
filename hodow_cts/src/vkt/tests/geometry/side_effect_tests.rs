// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/geometry/vktGeometryBasicGeometryShaderTests.cpp (`sideEffect*`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A geometry shader that writes an SSBO must run even when it emits nothing (condition false) or only a degenerate primitive
// (two vertices of a triangle strip). The colour buffer must stay at the clear colour and the SSBO must hold 777.
// The shaders are generated into `shaders/manifest/geometry_expander.toml` (`basic__side_effect_with_*`).

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
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
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::geometry::GraphicsPipelineBuilder;
use crate::vkt::tests::geometry::expander::expander_programs;
use crate::vkt::{Context, TestCase, TestInstance};

/// `SideEffectCase`
#[derive(Clone, Copy)]
pub enum SideEffectCase {
    Condition,
    Degenerate,
}

/// The `addFunctionCaseWithPrograms` case of one `SideEffectParams`.
pub struct SideEffectTest {
    name: String,
    programs: BinaryCollection,
    #[allow(dead_code)]
    side_effect_case: SideEffectCase,
}

impl SideEffectTest {
    pub fn new(side_effect_case: SideEffectCase) -> Self {
        let suffix = match side_effect_case {
            SideEffectCase::Condition => "condition",
            SideEffectCase::Degenerate => "degenerate",
        };
        let name = format!("side_effect_with_{suffix}");
        let programs = expander_programs(&format!("basic__{name}"));
        Self {
            name,
            programs,
            side_effect_case,
        }
    }
}

impl TestCase for SideEffectTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `sideEffectSupportCheck`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Feature not supported: geometryShader".to_string(),
            ));
        }
        if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Feature not supported: vertexPipelineStoresAndAtomics".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SideEffectInstance { context })
    }
}

struct SideEffectInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for SideEffectInstance<'_> {
    /// `sideEffectTest`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let extent = (1u32, 1u32);
        let img_format = vk::Format::R8G8B8A8_UNORM;

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(img_format)
            .extent(vk::Extent3D {
                width: extent.0,
                height: extent.1,
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
        let color_sub_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            img_format,
            color_sub_range,
        )?;
        let color_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // struct { uint32_t condition; uint32_t value; }, zeroed: this also sets the condition to zero.
        let ssbo_size = 2 * std::mem::size_of::<u32>();
        let ssbo_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(ssbo_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(ssbo_buffer.get_allocation().get_host_ptr(), 0, ssbo_size) };
        flush_alloc(device, ssbo_buffer.get_allocation())?;

        let binding = [vk::DescriptorSetLayoutBinding::builder()
            .binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::GEOMETRY)
            .build()];
        let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&binding);
        let set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let geom_module = create_shader_module(device, binaries.get("geom")?)?;

        let render_pass = make_render_pass(device, img_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], extent.0, extent.1, 1)?;

        let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [-1.0, 3.0, 0.0, 1.0], [3.0, -1.0, 0.0, 1.0]];
        let vertex_buffer_size = std::mem::size_of_val(&vertices);
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                vertex_buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let pipeline = GraphicsPipelineBuilder::new(extent)
            .set_shader(vk::ShaderStageFlags::VERTEX, *vert_module)
            .set_shader(vk::ShaderStageFlags::GEOMETRY, *geom_module)
            .set_shader(vk::ShaderStageFlags::FRAGMENT, *frag_module)
            .add_vertex_binding(vk::VertexInputBindingDescription {
                binding: 0,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            })
            .add_vertex_attribute(vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            })
            .set_primitive_topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .build(device, *pipeline_layout, *render_pass)?;

        let pool_sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 1,
        }];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(1)
            .pool_sizes(&pool_sizes);
        let descriptor_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let set_layouts = [*set_layout];
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*descriptor_pool)
            .set_layouts(&set_layouts);
        let desc_set =
            unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?[0];
        let buffer_info = [vk::DescriptorBufferInfo {
            buffer: ssbo_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(desc_set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&buffer_info);
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Must be different from the color set in the frag shader.
        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };

        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, extent.0, extent.1),
            clear_color,
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[desc_set],
                &[],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        copy_image_to_buffer(device, cmd, color_image.get(), color_buffer.get(), extent.0, extent.1);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Validate color buffer has not been written to and the SSBO value is as we expect.
        invalidate_alloc(device, ssbo_buffer.get_allocation())?;
        let ssbo_value =
            unsafe { std::ptr::read_unaligned(ssbo_buffer.get_allocation().get_host_ptr().cast::<u32>().add(1)) };
        let expected = 777u32; // Must match geometry shader.
        if ssbo_value != expected {
            return Err(TestError::Fail(format!(
                "Unexpected value found in SSBO: expected {expected} but found {ssbo_value}"
            )));
        }

        invalidate_alloc(device, color_buffer.get_allocation())?;
        let pixel = unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), 4) };
        if pixel != [0, 0, 0, 255] {
            return Err(TestError::Fail("Unexpected results in color buffer".to_string()));
        }

        Ok(TestStatus::pass("Pass"))
    }
}
