// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_ies_vtx.toml`
// (`scripts/gen_dgc_ies_vtx_manifest.py`). The pipelines are made by `build_draw_pipeline_with_input` of the draw tests (four vertex
// bindings), the shader objects by `create_dgc_shader`.
//
// Here: `ies_increase_vtx_bindings_*` of `dgc.ext.graphics.misc` (IESInputBindingsInstance): four sequences, each of which switches to a
// pipeline (or vertex shader) that reads one more vertex binding than the previous one, optionally with the vertex buffers bound by tokens.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_ies_vtx::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout_with_push_constants, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, DrawPipeline, ExtraState, PipelineOptions, StageModules, bind_shader_object_state,
    bind_shaders_with_nulls, build_draw_pipeline_with_input, copy_image_to_buffer, float_threshold_compare,
    push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, create_dgc_shader,
};
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, end_rendering};
use crate::vkt::tests::shader_object::util::ShaderObject;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const PIPELINE_COUNT: u32 = 4;
const VERTEX_COUNT: u32 = 4;
const VERTEX_BUFFER_COUNT: usize = 4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum ConstructionType {
    Monolithic,
    FastLinked,
    LinkTimeOptimized,
    ShaderObjectUnlinkedSpirv,
}

impl ConstructionType {
    fn pipeline_construction(self) -> Construction {
        match self {
            ConstructionType::Monolithic | ConstructionType::ShaderObjectUnlinkedSpirv => Construction::Monolithic,
            ConstructionType::FastLinked => Construction::FastLinked,
            ConstructionType::LinkTimeOptimized => Construction::LinkTimeOptimized,
        }
    }

    fn is_shader_object(self) -> bool {
        self == ConstructionType::ShaderObjectUnlinkedSpirv
    }
}

#[derive(Clone, Copy)]
struct Params {
    construction_type: ConstructionType,
    indirect_vertex_buffers: bool,
    reverse_color_order: bool,
}

impl Params {
    /// The binding numbers for red, green and blue.
    fn color_bindings(&self) -> [u32; 3] {
        if self.reverse_color_order { [3, 2, 1] } else { [1, 2, 3] }
    }
}

struct IesInputBindingsCase {
    name: String,
    params: Params,
}

impl TestCase for IesInputBindingsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let use_shader_objects = self.params.construction_type.is_shader_object();
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        if use_shader_objects {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }
        if matches!(
            self.params.construction_type,
            ConstructionType::FastLinked | ConstructionType::LinkTimeOptimized
        ) {
            context.require_device_functionality("VK_EXT_graphics_pipeline_library")?;
        }
        if self.params.indirect_vertex_buffers && context.api_version() < (1, 3, 0) {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }

        let bind_stages_pipeline = if use_shader_objects {
            vk::ShaderStageFlags::empty()
        } else {
            stages
        };
        let bind_stages_shader_object = if use_shader_objects {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_stages_pipeline,
            bind_stages_shader_object,
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = if self.params.reverse_color_order {
            "ies_vtx_reversed"
        } else {
            "ies_vtx_normal"
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IesInputBindingsInstance {
            context,
            params: self.params,
        })
    }
}

struct IesInputBindingsInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// `makeVertexBuffer`: a host visible vertex buffer holding `data`, with a device address when the buffers are bound by tokens.
fn make_vertex_buffer<'a>(
    context: &'a Context<'a>,
    data: &[u8],
    indirect: bool,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let usage = vk::BufferUsageFlags::VERTEX_BUFFER
        | if indirect {
            vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
        } else {
            vk::BufferUsageFlags::empty()
        };
    let requirement = if indirect {
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
    } else {
        MemoryRequirement::HOST_VISIBLE
    };
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(data.len() as vk::DeviceSize, usage),
        requirement,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer was created with `data.len()` bytes.
        unsafe { std::ptr::copy_nonoverlapping(data.as_ptr(), alloc.get_host_ptr(), data.len()) };
        flush_alloc(device, alloc)?;
    }
    Ok(buffer)
}

fn floats_to_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

impl TestInstance for IesInputBindingsInstance<'_> {
    /// `IESInputBindingsInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = (2u32, 2u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let use_shader_objects = params.construction_type.is_shader_object();

        // Color buffer, render pass and framebuffer.
        let color_buffer = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, color_format, color_usage, 4)?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent.0, fb_extent.1, 1)?;

        // Push constants.
        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: std::mem::size_of::<Vec4>() as u32,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;

        // Vertex input.
        let color_locations = params.color_bindings();
        let [red_location, green_location, blue_location] = color_locations;
        let binding_numbers = [0, red_location, green_location, blue_location];
        let binding_strides = [std::mem::size_of::<Vec4>() as u32, 4, 4, 4];
        let attribute_formats = [
            vk::Format::R32G32B32A32_SFLOAT,
            vk::Format::R32_SFLOAT,
            vk::Format::R32_SFLOAT,
            vk::Format::R32_SFLOAT,
        ];
        let input_bindings: Vec<vk::VertexInputBindingDescription> = (0..VERTEX_BUFFER_COUNT)
            .map(|i| {
                vk::VertexInputBindingDescription::builder()
                    .binding(binding_numbers[i])
                    .stride(binding_strides[i])
                    .input_rate(vk::VertexInputRate::VERTEX)
                    .build()
            })
            .collect();
        let input_attributes: Vec<vk::VertexInputAttributeDescription> = (0..VERTEX_BUFFER_COUNT)
            .map(|i| {
                vk::VertexInputAttributeDescription::builder()
                    .location(binding_numbers[i])
                    .binding(binding_numbers[i])
                    .format(attribute_formats[i])
                    .offset(0)
                    .build()
            })
            .collect();
        let input_bindings_2: Vec<vk::VertexInputBindingDescription2EXT> = (0..VERTEX_BUFFER_COUNT)
            .map(|i| vk::VertexInputBindingDescription2EXT {
                binding: binding_numbers[i],
                stride: binding_strides[i],
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            })
            .collect();
        let input_attributes_2: Vec<vk::VertexInputAttributeDescription2EXT> = (0..VERTEX_BUFFER_COUNT)
            .map(|i| vk::VertexInputAttributeDescription2EXT {
                location: binding_numbers[i],
                binding: binding_numbers[i],
                format: attribute_formats[i],
                offset: 0,
                ..Default::default()
            })
            .collect();

        // Shaders.
        let binaries = context.get_binary_collection();
        let vert_name = |i: u32| format!("vert{i}");
        let mut vert_modules = Vec::new();
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let mut vert_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut frag_shader: Option<ShaderObject<'_>> = None;
        if use_shader_objects {
            for i in 0..PIPELINE_COUNT {
                vert_shaders.push(create_dgc_shader(
                    device,
                    vk::ShaderStageFlags::VERTEX,
                    &binaries.get(&vert_name(i))?,
                    &[],
                    &[pc_range],
                    false,
                    false,
                )?);
            }
            frag_shader = Some(create_dgc_shader(
                device,
                vk::ShaderStageFlags::FRAGMENT,
                &binaries.get("frag")?,
                &[],
                &[pc_range],
                false,
                false,
            )?);
        } else {
            for i in 0..PIPELINE_COUNT {
                vert_modules.push(create_shader_module(device, binaries.get(&vert_name(i))?)?);
            }
        }

        // Pipelines.
        let mut pipelines: Vec<DrawPipeline<'_>> = Vec::new();
        if !use_shader_objects {
            for vert_module in &vert_modules {
                pipelines.push(build_draw_pipeline_with_input(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    &StageModules {
                        vert: **vert_module,
                        tesc: None,
                        tese: None,
                        geom: None,
                        frag: *frag_module,
                    },
                    &PipelineOptions {
                        extent: fb_extent,
                        topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                        patch_control_points: 0,
                        dynamic_stride: params.indirect_vertex_buffers,
                        dynamic_patch_control_points: false,
                        no_vertex_input: false,
                        extra_attribute: false,
                        indirect_bindable: true,
                        construction: params.construction_type.pipeline_construction(),
                        depth_test: false,
                        rendering: None,
                    },
                    Some((&input_bindings[..], &input_attributes[..])),
                    ExtraState::default(),
                )?);
            }
        }

        // Indirect execution set.
        let mut ies_manager = if use_shader_objects {
            // We will be using PIPELINE_COUNT vertex shaders, 1 fragment shader, no set layouts and the vertex shaders have push constants.
            // In the IES we store the fragment shader first, followed by vertex shaders.
            let frag_handle = frag_shader
                .as_ref()
                .map(ShaderObject::get)
                .unwrap_or(vk::ShaderEXT::null());
            let no_layouts: Vec<vk::DescriptorSetLayout> = Vec::new();
            let stage_infos = [(frag_handle, no_layouts.clone()), (vert_shaders[0].get(), no_layouts)];
            let max_shader_count = PIPELINE_COUNT + 1;
            let mut manager = ExecutionSetManagerExt::new_shader(device, &stage_infos, &[pc_range], max_shader_count)?;
            // Overwrite vertex shaders only. Leave the fragment shader alone in position 0.
            for (i, shader) in vert_shaders.iter().enumerate() {
                manager.add_shader(i as u32 + 1, shader.get());
            }
            manager
        } else {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], PIPELINE_COUNT)?;
            // Overwrite all pipelines in the set.
            for (i, pipeline) in pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager
        };
        ies_manager.update();
        let indirect_execution_set = ies_manager.get();

        // Vertex data and vertex buffers. A triangle strip from 0..1 will be offset in each quadrant with push constants.
        let vtx_positions: [Vec4; 4] = [
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let position_bytes: Vec<u8> = vtx_positions
            .iter()
            .flat_map(|vertex| floats_to_bytes(vertex))
            .collect();
        let ones = floats_to_bytes(&[1.0; 4]);
        // Separate bad values for when the binding is unused.
        let bad_values = floats_to_bytes(&[0.0; 4]);

        let vtx_buffers = [
            make_vertex_buffer(context, &position_bytes, params.indirect_vertex_buffers)?,
            make_vertex_buffer(context, &ones, params.indirect_vertex_buffers)?,
            make_vertex_buffer(context, &ones, params.indirect_vertex_buffers)?,
            make_vertex_buffer(context, &ones, params.indirect_vertex_buffers)?,
        ];
        let vtx_buffer_sizes = [
            position_bytes.len() as u32,
            ones.len() as u32,
            ones.len() as u32,
            ones.len() as u32,
        ];

        let mut device_addresses: Vec<vk::DeviceAddress> = Vec::new();
        let mut bad_vertex_buffer: Option<BufferWithMemory<'_>> = None;
        let mut bad_vertex_buffer_address: vk::DeviceAddress = 0;
        if params.indirect_vertex_buffers {
            for buffer in &vtx_buffers {
                device_addresses.push(buffer_device_address(device, buffer.get()));
            }
            let bad = make_vertex_buffer(context, &bad_values, true)?;
            bad_vertex_buffer_address = buffer_device_address(device, bad.get());
            bad_vertex_buffer = Some(bad);
        }

        // Offsets for push constants. This will determine the quadrant order: which quadrant gets which color. Proceed one row at a time
        // from top to bottom, and in each row from left to right.
        let offsets: [Vec4; 4] = [
            [-1.0, -1.0, 0.0, 0.0],
            [0.0, -1.0, 0.0, 0.0],
            [-1.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
        ];

        // Indirect commands layout.
        let set_type = if use_shader_objects {
            vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
        } else {
            vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
        };
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stages,
            *pipeline_layout,
        );
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_execution_set_token(offset, set_type, shader_stages);
        if params.indirect_vertex_buffers {
            for i in 0..VERTEX_BUFFER_COUNT {
                // We may be reversing the order of the bindings here.
                let binding_number = if i == 0 { 0 } else { color_locations[i - 1] };
                let offset = cmds_layout_builder.get_stream_range();
                cmds_layout_builder.add_vertex_buffer_token(offset, binding_number);
            }
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Prepare base data for the bind commands. The buffer addresses will be overwritten later for each sequence. The first one will
        // always be used, so we don't have to care about the bad vertex buffer being too small for this entry (size and stride is bigger
        // in this one).
        let mut vertex_bind_cmds: Vec<vk::BindVertexBufferIndirectCommandEXT> = Vec::new();
        if params.indirect_vertex_buffers {
            for i in 0..VERTEX_BUFFER_COUNT {
                vertex_bind_cmds.push(vk::BindVertexBufferIndirectCommandEXT {
                    buffer_address: bad_vertex_buffer_address,
                    size: vtx_buffer_sizes[i],
                    stride: binding_strides[i],
                });
            }
        }

        // DGC buffer.
        let draw_cmd = vk::DrawIndirectCommand {
            vertex_count: VERTEX_COUNT,
            instance_count: 1,
            first_vertex: 0,
            first_instance: 0,
        };
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..PIPELINE_COUNT as usize {
            if use_shader_objects {
                dgc_data.push(i as u32 + 1); // Vertex shader index for sequence i.
                dgc_data.push(0); // Fragment shader index is constant.
            } else {
                dgc_data.push(i as u32); // Pipeline index.
            }
            if params.indirect_vertex_buffers {
                // Prepare bind commands.
                for j in 0..=i {
                    vertex_bind_cmds[j].buffer_address = device_addresses[j];
                }
                for j in (i + 1)..VERTEX_BUFFER_COUNT {
                    vertex_bind_cmds[j].buffer_address = bad_vertex_buffer_address;
                }
                // Push them to the buffer.
                for cmd in &vertex_bind_cmds {
                    push_back_element(&mut dgc_data, cmd);
                }
            }
            push_back_element(&mut dgc_data, &offsets[i]); // Push constants.
            push_back_element(&mut dgc_data, &draw_cmd); // Draw command.
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            indirect_execution_set,
            cmds_layout.get(),
            PIPELINE_COUNT,
            0,
            vk::Pipeline::null(),
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        begin_command_buffer(device, cmd_buffer)?;

        let clear_color = [0.0f32; 4]; // Different from other colors due to the alpha value.
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: clear_color },
        };
        let render_area = make_rect_2d(0, 0, fb_extent.0, fb_extent.1);
        if use_shader_objects {
            // The render pass wrapper of shader objects: a transition and dynamic rendering clearing the image.
            let to_attachment = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_attachment],
                )
            };
            begin_rendering(
                device,
                cmd_buffer,
                *color_buffer.view,
                render_area,
                clear_value,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
        } else {
            begin_render_pass(device, cmd_buffer, *render_pass, *framebuffer, render_area, clear_value);
        }

        if !params.indirect_vertex_buffers {
            // We may be reversing the order of the bindings here.
            let actual_handles: Vec<vk::Buffer> = (0..VERTEX_BUFFER_COUNT)
                .map(|i| {
                    let binding_number = if i == 0 { 0 } else { color_locations[i - 1] as usize };
                    vtx_buffers[binding_number].get()
                })
                .collect();
            let vtx_buffer_offsets = [0 as vk::DeviceSize; VERTEX_BUFFER_COUNT];
            unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &actual_handles, &vtx_buffer_offsets) };
        }

        // Initial shader state.
        if use_shader_objects {
            let frag_handle = frag_shader
                .as_ref()
                .map(ShaderObject::get)
                .unwrap_or(vk::ShaderEXT::null());
            bind_shaders_with_nulls(
                context,
                cmd_buffer,
                &[
                    (vk::ShaderStageFlags::VERTEX, vert_shaders[0].get()),
                    (vk::ShaderStageFlags::FRAGMENT, frag_handle),
                ],
            );
            bind_shader_object_state(
                context,
                cmd_buffer,
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                0,
                fb_extent,
                Some((&input_bindings_2[..], &input_attributes_2[..])),
            );
        } else {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[0]) };
        }

        {
            let cmds_info = DgcGenCmdsInfo::new(
                shader_stages,
                indirect_execution_set,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                PIPELINE_COUNT,
                0,
                0,
                vk::Pipeline::null(),
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }

        if use_shader_objects {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent.0,
            fb_extent.1,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;
        drop(bad_vertex_buffer);

        // Result verification.
        let result = color_buffer.read_bytes(device)?;
        let reference: [Vec4; 4] = [
            [0.0, 0.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
        ];
        let threshold = [0.0f32; 4];
        if !float_threshold_compare(result, &reference, threshold) {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `ies_increase_vtx_bindings_*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_ies_vtx_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let construction_types = [
        (ConstructionType::Monolithic, "monolithic"),
        (ConstructionType::FastLinked, "fast_lib"),
        (ConstructionType::LinkTimeOptimized, "optimized_lib"),
        (ConstructionType::ShaderObjectUnlinkedSpirv, "unlinked_spirv"),
    ];
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (construction_type, suffix) in construction_types {
        for indirect_vertex_buffers in [false, true] {
            for reverse_color_order in [false, true] {
                let name = format!(
                    "ies_increase_vtx_bindings_{suffix}{}{}",
                    if indirect_vertex_buffers {
                        "_indirect_vtx_binds"
                    } else {
                        ""
                    },
                    if reverse_color_order { "_with_holes" } else { "" },
                );
                cases.push((
                    format!("ext.graphics.misc.{name}"),
                    Box::new(IesInputBindingsCase {
                        name,
                        params: Params {
                            construction_type,
                            indirect_vertex_buffers,
                            reverse_color_order,
                        },
                    }),
                ));
            }
        }
    }
    cases
}
