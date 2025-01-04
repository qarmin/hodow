// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderMiscTestsEXT.cpp (namespace VertexState)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Like upstream, the pipeline is created without any dynamic state and the dynamic state
// commands are recorded anyway: the test checks that a mesh pipeline does not care about vertex input state.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtExtendedDynamicState2ExtensionDeviceCommands, ExtExtendedDynamicStateExtensionDeviceCommands,
    ExtMeshShaderExtensionDeviceCommands, ExtVertexInputDynamicStateExtensionDeviceCommands,
};

use crate::generated::shaders::mesh_shader_misc::MISC_VERTEX_STATE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_framebuffer,
    make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::mesh_shader::util::check_task_mesh_shader_support_ext;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `VertexState::Params`
#[derive(Clone, Copy, PartialEq, Eq)]
struct Params {
    bind_vbo: bool,
    bind_ibo: bool,
    dynamic_vertex_input: bool,
    dynamic_prim_restart: bool,
    dynamic_topology: bool,
}

struct VertexStateCase {
    name: String,
    params: Params,
}

impl TestCase for VertexStateCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `VertexState::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, false, true)?;

        if self.params.dynamic_vertex_input {
            context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
        }

        if self.params.dynamic_prim_restart {
            context.require_device_functionality("VK_EXT_extended_dynamic_state2")?;
        }

        if self.params.dynamic_topology {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MISC_VERTEX_STATE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VertexStateInstance {
            context,
            params: self.params,
        })
    }
}

struct VertexStateInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for VertexStateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        iterate(self.context, &self.params)
    }
}

/// `VertexState::iterate`
fn iterate(context: &Context<'_>, params: &Params) -> TestOutcome {
    let device = context.get_device();
    const EXTENT: u32 = 1;
    let geom_color = [0u8, 0, 255, 255];
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];

    let color_buffer = ImageWithBuffer::new(
        context,
        EXTENT,
        EXTENT,
        COLOR_FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
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

    let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [-1.0, 3.0, 0.0, 1.0], [3.0, -1.0, 0.0, 1.0]];
    let actual_vertex_buffer = create_host_buffer(
        context,
        &vertices,
        vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;

    let indices: [u32; 3] = [0, 1, 2];
    let actual_index_buffer = create_host_buffer(
        context,
        &indices,
        vk::BufferUsageFlags::INDEX_BUFFER | vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;

    let fake_vertex_buffer = create_host_buffer(
        context,
        &[[0.0f32; 4]; 3],
        vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;
    let fake_index_buffer = create_host_buffer(
        context,
        &[0u32; 3],
        vk::BufferUsageFlags::INDEX_BUFFER | vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;

    let binaries = context.get_binary_collection();
    let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let vertex_buffer_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
    let index_buffer_size = std::mem::size_of_val(&indices) as vk::DeviceSize;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::MESH_EXT)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::MESH_EXT)
        .build(device)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

    let vertex_buffer_desc_info = make_descriptor_buffer_info(actual_vertex_buffer.get(), 0, vertex_buffer_size);
    let index_buffer_desc_info = make_descriptor_buffer_info(actual_index_buffer.get(), 0, index_buffer_size);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &vertex_buffer_desc_info,
        )
        .write_single(
            descriptor_set.get(),
            Location::binding(1),
            vk::DescriptorType::STORAGE_BUFFER,
            &index_buffer_desc_info,
        )
        .update(device);

    let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(EXTENT, EXTENT);
    state.rasterization.depth_bias_enable = vk::FALSE;
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::MESH_EXT, *mesh_shader),
            (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
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
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        if params.bind_vbo {
            device.cmd_bind_vertex_buffers(cmd, 0, &[fake_vertex_buffer.get()], &[0]);
        }
        if params.bind_ibo {
            device.cmd_bind_index_buffer(cmd, fake_index_buffer.get(), 0, vk::IndexType::UINT32);
        }
        if params.dynamic_vertex_input {
            let vtx_binding = vk::VertexInputBindingDescription2EXT {
                binding: 0,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 0,
                ..Default::default()
            };
            let vtx_attrib = vk::VertexInputAttributeDescription2EXT {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
                ..Default::default()
            };
            device.cmd_set_vertex_input_ext(cmd, &[vtx_binding], &[vtx_attrib]);
        }
        if params.dynamic_prim_restart {
            device.cmd_set_primitive_restart_enable_ext(cmd, true);
        }
        if params.dynamic_topology {
            device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP);
        }
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
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

    let result = color_buffer.read_bytes(device)?;
    if result[..4] != geom_color {
        return Err(TestError::Fail(
            "Unexpected results in color buffer; check log for details --".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// The `vertex_state*` cases of `createMeshShaderMiscTestsEXT`.
pub fn add_vertex_state_cases(group: &mut TestCaseGroup) {
    let default_params = Params {
        bind_vbo: false,
        bind_ibo: false,
        dynamic_vertex_input: false,
        dynamic_prim_restart: false,
        dynamic_topology: false,
    };

    for bind_vbo in [false, true] {
        for bind_ibo in [false, true] {
            for dynamic_vertex_input in [false, true] {
                for dynamic_prim_restart in [false, true] {
                    for dynamic_topology in [false, true] {
                        // Upstream passes bindIBO for both buffer flags, so bindVBO only reaches the name.
                        let params = Params {
                            bind_vbo: bind_ibo,
                            bind_ibo,
                            dynamic_vertex_input,
                            dynamic_prim_restart,
                            dynamic_topology,
                        };
                        if params == default_params {
                            continue;
                        }

                        let name = format!(
                            "vertex_state{}{}{}{}{}",
                            if bind_vbo { "_bind_vbo" } else { "" },
                            if bind_ibo { "_bind_ibo" } else { "" },
                            if dynamic_vertex_input { "_dynamic_vtx_input" } else { "" },
                            if dynamic_prim_restart {
                                "_dynamic_prim_restart"
                            } else {
                                ""
                            },
                            if dynamic_topology { "_dynamic_topo" } else { "" },
                        );
                        let case: Box<dyn TestCase> = Box::new(VertexStateCase { name, params });
                        group.add_child(case);
                    }
                }
            }
        }
    }
}
