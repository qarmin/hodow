// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectBindingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are the `BINDING_*` constants of `shaders/manifest/shader_object_binding.toml`
// (`BINDING_DRAW_<stage>` is the set whose alternative shader of that stage declares an unused output). The `disabled_*` cases run on a
// `SecondDevice` with `geometryShader` or `tessellationShader` switched off. Pixels are compared as `byte / 255`
// against upstream's expected colours with its 1/256 threshold.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands, Handle};

use super::link_tests::{
    RENDER_SIZE, create_color_target, create_color_target_on, read_pixels, record_pre_barrier, record_readback,
};
use super::second_device::SecondDevice;
use super::util::{
    ShaderObject, bind_graphics_shaders, bind_null_rasterization_shaders, bind_shaders_null_pointer, create_shader,
    get_mesh_shader_features, get_shader_binary_data, make_shader, make_shader_create_info,
    remove_unsupported_shader_object_extensions, set_default_shader_object_dynamic_states,
};
use crate::generated::shaders::shader_object_binding::{
    BINDING_BINDINGS_MESH, BINDING_DRAW_FRAG, BINDING_DRAW_GEOM, BINDING_DRAW_NONE, BINDING_DRAW_TESC,
    BINDING_DRAW_TESE, BINDING_DRAW_VERT, BINDING_MESH_SWAP, BINDING_UNBIND,
};
use crate::generated::shaders::shader_object_create::SHADER_OBJECT_BASIC;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::draw::util::{begin_rendering, end_rendering, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    PassthroughGeom,
    Swap,
    Disabled,
    Unbind,
    DrawDispatchDraw,
    DispatchDrawDispatch,
}

#[derive(Clone, Copy)]
struct BindingDrawParams {
    test_type: TestType,
    stage: vk::ShaderStageFlags,
    /// `VK_SHADER_STAGE_ALL` (or any stage without an alternative shader) when no output is left unused
    unused_outputs: vk::ShaderStageFlags,
    binary_stage: vk::ShaderStageFlags,
    set_state_after: bool,
    unbind_with_null_pshaders: bool,
    bind_unsupported: bool,
}

fn handle_of(shader: &Option<ShaderObject<'_>>) -> vk::ShaderEXT {
    shader.as_ref().map_or_else(vk::ShaderEXT::null, ShaderObject::get)
}

fn pixel(pixels: &[u8], i: usize, j: usize) -> [u8; 4] {
    let offset = (j * RENDER_SIZE as usize + i) * 4;
    [
        pixels[offset],
        pixels[offset + 1],
        pixels[offset + 2],
        pixels[offset + 3],
    ]
}

fn pixel_color(pixels: &[u8], i: usize, j: usize) -> [f32; 4] {
    pixel(pixels, i, j).map(|channel| f32::from(channel) / 255.0)
}

fn unused_output_variant(unused_outputs: vk::ShaderStageFlags) -> usize {
    if unused_outputs == vk::ShaderStageFlags::VERTEX {
        1
    } else if unused_outputs == vk::ShaderStageFlags::TESSELLATION_CONTROL {
        2
    } else if unused_outputs == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
        3
    } else if unused_outputs == vk::ShaderStageFlags::GEOMETRY {
        4
    } else if unused_outputs == vk::ShaderStageFlags::FRAGMENT {
        5
    } else {
        0
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// binding draw cases
// ---------------------------------------------------------------------------------------------------------------------

/// `ShaderObjectBindingDrawInstance::createShader` - a shader whose stage may be round-tripped through its binary.
fn create_binding_shader<'a>(
    context: &Context<'_>,
    device: &'a vulkanalia::Device,
    params: &BindingDrawParams,
    stage: vk::ShaderStageFlags,
    name: &str,
    layout: Option<&vk::DescriptorSetLayout>,
) -> Result<ShaderObject<'a>, TestError> {
    let binaries = context.get_binary_collection();
    let features = context.get_device_features();
    let mut create_info = make_shader_create_info(
        stage,
        &binaries.get(name)?,
        features.tessellation_shader != vk::FALSE,
        features.geometry_shader != vk::FALSE,
        layout,
        None,
    );

    if params.binary_stage == stage {
        let shader = create_shader(device, &create_info)?;
        let data = get_shader_binary_data(device, shader.get())?;

        create_info.code_type = vk::ShaderCodeTypeEXT::BINARY;
        create_info.code_size = data.len();
        create_info.code = data.as_ptr().cast();

        return create_shader(device, &create_info);
    }

    create_shader(device, &create_info)
}

fn run_binding_draw(context: &Context<'_>, params: &BindingDrawParams) -> TestOutcome {
    // The disabled cases run on a device with the feature of the stage switched off.
    let second_device = if params.test_type == TestType::Disabled {
        let stage = params.stage;
        Some(SecondDevice::new(context, &[], move |features| {
            if stage == vk::ShaderStageFlags::GEOMETRY {
                features.geometry_shader = vk::FALSE;
            } else if stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
                features.tessellation_shader = vk::FALSE;
            }
        })?)
    } else {
        None
    };
    let device = second_device
        .as_ref()
        .map_or_else(|| context.get_device(), |second| second.device());
    let queue = second_device
        .as_ref()
        .map_or_else(|| context.get_universal_queue(), |second| second.queue());
    let allocator = second_device
        .as_ref()
        .map_or_else(|| context.get_default_allocator(), |second| second.allocator());
    let extensions = remove_unsupported_shader_object_extensions(context)?;

    let tessellation_supported = context.get_device_features().tessellation_shader != vk::FALSE;
    let geometry_supported = context.get_device_features().geometry_shader != vk::FALSE;
    let mesh_features = get_mesh_shader_features(context);
    let task_supported = mesh_features.task_shader != vk::FALSE;
    let mesh_supported = mesh_features.mesh_shader != vk::FALSE;

    let target = create_color_target_on(device, allocator, vk::Format::R8G8B8A8_UNORM)?;

    let buffer_size_bytes = (std::mem::size_of::<u32>() * 16) as u64;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let descriptor_set1 = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
    let descriptor_set2 = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
    let output_buffer1 = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let output_buffer2 = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let compute_pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;

    let buffer_info1 = [vk::DescriptorBufferInfo {
        buffer: output_buffer1.get(),
        offset: 0,
        range: buffer_size_bytes,
    }];
    let buffer_info2 = [vk::DescriptorBufferInfo {
        buffer: output_buffer2.get(),
        offset: 0,
        range: buffer_size_bytes,
    }];
    let writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set1.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&buffer_info1)
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set2.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&buffer_info2)
            .build(),
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    let (vert_name, vert_alt_name) = match (tessellation_supported, geometry_supported) {
        (true, true) => ("vert", "vertAlt"),
        (true, false) => ("vertNoGeom", "vertAltNoGeom"),
        (false, true) => ("vertNoTess", "vertAltNoTess"),
        (false, false) => ("vertNoTessGeom", "vertAltNoTessGeom"),
    };
    let vert_shader = Some(create_binding_shader(
        context,
        device,
        params,
        vk::ShaderStageFlags::VERTEX,
        vert_name,
        None,
    )?);
    let vert_alt_shader = Some(create_binding_shader(
        context,
        device,
        params,
        vk::ShaderStageFlags::VERTEX,
        vert_alt_name,
        None,
    )?);
    let mut tesc_shader = None;
    let mut tese_shader = None;
    let mut tesc_alt_shader = None;
    let mut tese_alt_shader = None;
    if tessellation_supported
        && (params.stage != vk::ShaderStageFlags::TESSELLATION_CONTROL || params.test_type != TestType::Disabled)
    {
        tesc_shader = Some(create_binding_shader(
            context,
            device,
            params,
            vk::ShaderStageFlags::TESSELLATION_CONTROL,
            "tesc",
            None,
        )?);
        tese_shader = Some(create_binding_shader(
            context,
            device,
            params,
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            "tese",
            None,
        )?);
        tesc_alt_shader = Some(create_binding_shader(
            context,
            device,
            params,
            vk::ShaderStageFlags::TESSELLATION_CONTROL,
            "tescAlt",
            None,
        )?);
        tese_alt_shader = Some(create_binding_shader(
            context,
            device,
            params,
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            "teseAlt",
            None,
        )?);
    }
    let mut geom_shader = None;
    let mut geom_alt_shader = None;
    let mut pass_through_geom_shader = None;
    if geometry_supported && (params.stage != vk::ShaderStageFlags::GEOMETRY || params.test_type != TestType::Disabled)
    {
        geom_shader = Some(create_binding_shader(
            context,
            device,
            params,
            vk::ShaderStageFlags::GEOMETRY,
            "geom",
            None,
        )?);
        geom_alt_shader = Some(create_binding_shader(
            context,
            device,
            params,
            vk::ShaderStageFlags::GEOMETRY,
            "geomAlt",
            None,
        )?);
        pass_through_geom_shader = Some(create_binding_shader(
            context,
            device,
            params,
            vk::ShaderStageFlags::GEOMETRY,
            "passThroughGeom",
            None,
        )?);
    }
    let frag_shader = Some(create_binding_shader(
        context,
        device,
        params,
        vk::ShaderStageFlags::FRAGMENT,
        "blendFrag",
        None,
    )?);
    let comp_shader = Some(create_binding_shader(
        context,
        device,
        params,
        vk::ShaderStageFlags::COMPUTE,
        "comp",
        Some(&layout_handle),
    )?);
    let frag_alt_shader = Some(create_binding_shader(
        context,
        device,
        params,
        vk::ShaderStageFlags::FRAGMENT,
        "fragAlt",
        None,
    )?);

    let color_blend_equation = vk::ColorBlendEquationEXT {
        src_color_blend_factor: vk::BlendFactor::ONE,
        dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ONE,
        dst_alpha_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        alpha_blend_op: vk::BlendOp::ADD,
    };
    let set_dynamic_states = |cmd: vk::CommandBuffer| {
        let topology = if tessellation_supported {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_STRIP
        };
        set_default_shader_object_dynamic_states(
            device,
            cmd,
            &extensions,
            topology,
            false,
            false,
            RENDER_SIZE,
            RENDER_SIZE,
        );
        unsafe {
            device.cmd_set_color_blend_enable_ext(cmd, 0, &[vk::TRUE]);
            device.cmd_set_color_blend_equation_ext(cmd, 0, &[color_blend_equation]);
        }
    };
    let bind_all = |cmd: vk::CommandBuffer, geom: vk::ShaderEXT| {
        bind_graphics_shaders(
            device,
            cmd,
            handle_of(&vert_shader),
            handle_of(&tesc_shader),
            handle_of(&tese_shader),
            geom,
            handle_of(&frag_shader),
            task_supported,
            mesh_supported,
        );
    };

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    if !params.set_state_after {
        set_dynamic_states(cmd);
    }

    unsafe {
        device.cmd_set_color_blend_enable_ext(cmd, 0, &[vk::TRUE]);
        device.cmd_set_color_blend_equation_ext(cmd, 0, &[color_blend_equation]);
    }

    if params.test_type != TestType::DispatchDrawDispatch {
        begin_rendering(
            device,
            cmd,
            *target.view,
            rect_2d(RENDER_SIZE, RENDER_SIZE),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 0.0],
                },
            },
            vk::ImageLayout::GENERAL,
            vk::AttachmentLoadOp::CLEAR,
            vk::RenderingFlags::empty(),
            1,
            0,
        );
    }

    let null_shader = [vk::ShaderEXT::null()];

    match params.test_type {
        TestType::PassthroughGeom => {
            bind_all(cmd, handle_of(&pass_through_geom_shader));
            if params.set_state_after {
                set_dynamic_states(cmd);
            }
            unsafe {
                device.cmd_draw(cmd, 4, 1, 0, 0);
                device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::GEOMETRY], &null_shader);
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }
        TestType::Swap => {
            bind_all(cmd, handle_of(&geom_shader));
            if params.set_state_after {
                set_dynamic_states(cmd);
            }
            unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
            let shader = if params.stage == vk::ShaderStageFlags::VERTEX {
                handle_of(&vert_alt_shader)
            } else if params.stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
                handle_of(&tesc_alt_shader)
            } else if params.stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
                handle_of(&tese_alt_shader)
            } else if params.stage == vk::ShaderStageFlags::GEOMETRY {
                handle_of(&geom_alt_shader)
            } else if params.stage == vk::ShaderStageFlags::FRAGMENT {
                handle_of(&frag_alt_shader)
            } else {
                vk::ShaderEXT::null()
            };
            unsafe {
                device.cmd_bind_shaders_ext(cmd, &[params.stage], &[shader]);
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }
        TestType::Disabled => {
            if task_supported {
                unsafe { device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::TASK_EXT], &null_shader) };
            }
            if mesh_supported {
                unsafe { device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::MESH_EXT], &null_shader) };
            }
            if params.stage == vk::ShaderStageFlags::GEOMETRY {
                let stages = [
                    vk::ShaderStageFlags::VERTEX,
                    vk::ShaderStageFlags::TESSELLATION_CONTROL,
                    vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                    vk::ShaderStageFlags::FRAGMENT,
                ];
                let shaders = [
                    handle_of(&vert_shader),
                    handle_of(&tesc_shader),
                    handle_of(&tese_shader),
                    handle_of(&frag_shader),
                ];
                unsafe { device.cmd_bind_shaders_ext(cmd, &stages, &shaders) };
            } else {
                unsafe { device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP) };
                let stages = [
                    vk::ShaderStageFlags::VERTEX,
                    vk::ShaderStageFlags::GEOMETRY,
                    vk::ShaderStageFlags::FRAGMENT,
                ];
                let shaders = [
                    handle_of(&vert_shader),
                    handle_of(&geom_shader),
                    handle_of(&frag_shader),
                ];
                unsafe { device.cmd_bind_shaders_ext(cmd, &stages, &shaders) };
            }
            if params.bind_unsupported {
                unsafe { device.cmd_bind_shaders_ext(cmd, &[params.stage], &null_shader) };
            }
            if params.set_state_after {
                set_dynamic_states(cmd);
            }
            unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
        }
        TestType::Unbind => {
            bind_all(cmd, handle_of(&geom_shader));
            unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
            if params.stage == vk::ShaderStageFlags::GEOMETRY {
                if params.unbind_with_null_pshaders {
                    bind_shaders_null_pointer(device, cmd, &[params.stage]);
                } else {
                    unsafe { device.cmd_bind_shaders_ext(cmd, &[params.stage], &null_shader) };
                }
            } else {
                let stages = [
                    vk::ShaderStageFlags::TESSELLATION_CONTROL,
                    vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                ];
                unsafe { device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP) };
                if params.unbind_with_null_pshaders {
                    bind_shaders_null_pointer(device, cmd, &stages);
                } else {
                    unsafe {
                        device.cmd_bind_shaders_ext(cmd, &stages, &[vk::ShaderEXT::null(), vk::ShaderEXT::null()])
                    };
                }
            }
            unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
        }
        TestType::DrawDispatchDraw => {
            bind_all(cmd, handle_of(&geom_shader));
            if params.set_state_after {
                set_dynamic_states(cmd);
            }
            unsafe {
                device.cmd_draw(cmd, 4, 1, 0, 0);
                device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::COMPUTE], &[handle_of(&comp_shader)]);
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }
        TestType::DispatchDrawDispatch => unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                compute_pipeline_layout.get(),
                0,
                &[descriptor_set1.get()],
                &[] as &[u32],
            );
            device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::COMPUTE], &[handle_of(&comp_shader)]);
            device.cmd_dispatch(cmd, 1, 1, 1);
            bind_all(cmd, handle_of(&geom_shader));
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                compute_pipeline_layout.get(),
                0,
                &[descriptor_set2.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
        },
    }

    if params.test_type != TestType::DispatchDrawDispatch {
        end_rendering(device, cmd);
    }

    record_readback(device, cmd, &target, None);

    if params.test_type == TestType::DispatchDrawDispatch {
        let barriers = [
            make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer1.get(),
                0,
                buffer_size_bytes,
            ),
            make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer2.get(),
                0,
                buffer_size_bytes,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &barriers,
                &[] as &[vk::ImageMemoryBarrier],
            )
        };
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;
    invalidate_alloc(device, target.output_buffer.get_allocation())?;

    let width = RENDER_SIZE as i32;
    let height = RENDER_SIZE as i32;
    let threshold = 1.0 / 256.0;
    let mut x_offset1 = width / 8;
    let mut y_offset1 = height / 8;
    let mut x_offset2 = width / 8;
    let mut y_offset2 = height / 8;
    let mut expected_color1 = [0.75f32; 4];
    let expected_color2 = [0.5f32; 4];
    let black_color = [0.0f32; 4];

    match params.test_type {
        TestType::PassthroughGeom => {
            y_offset1 = height / 4;
            x_offset2 = x_offset1;
            y_offset2 = y_offset1;
        }
        TestType::Swap => {
            if params.stage == vk::ShaderStageFlags::VERTEX {
                x_offset2 = 0;
                y_offset2 = 0;
            } else if params.stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
                x_offset2 = 10;
                y_offset2 = 10;
            } else if params.stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
                x_offset2 = 12;
                y_offset2 = height / 8;
            } else if params.stage == vk::ShaderStageFlags::GEOMETRY {
                x_offset2 = width / 8;
                y_offset2 = 12;
            } else if params.stage == vk::ShaderStageFlags::FRAGMENT {
                expected_color1 = [1.0, 0.0, 0.0, 1.0];
            }
        }
        TestType::Disabled => {
            if params.stage == vk::ShaderStageFlags::GEOMETRY {
                y_offset1 = height / 4;
            } else {
                x_offset1 = width / 4;
            }
            x_offset2 = 16;
            y_offset2 = 16;
        }
        TestType::Unbind => {
            if params.stage == vk::ShaderStageFlags::GEOMETRY {
                x_offset2 = x_offset1;
                y_offset2 = y_offset1 * 2;
            } else {
                x_offset2 = x_offset1 * 2;
                y_offset2 = y_offset1;
            }
        }
        TestType::DrawDispatchDraw => {
            x_offset2 = x_offset1;
            y_offset2 = y_offset1;
        }
        TestType::DispatchDrawDispatch => {}
    }

    if params.test_type == TestType::DispatchDrawDispatch {
        for buffer in [&output_buffer1, &output_buffer2] {
            let allocation = buffer.get_allocation();
            invalidate_alloc(device, allocation)?;

            let values =
                unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), 16) };
            if (0..16).any(|j| values[j] != j as u32) {
                return Ok(TestStatus::fail("Fail"));
            }
        }
        return Ok(TestStatus::pass("Pass"));
    }

    let pixels = read_pixels(&target);
    for j in 0..height {
        for i in 0..width {
            let color = pixel_color(pixels, i as usize, j as usize);

            let first = i >= x_offset1 && i < width - x_offset1 && j >= y_offset1 && j < height - y_offset1;
            let second = i >= x_offset2 && i < width - x_offset2 && j >= y_offset2 && j < height - y_offset2;
            let expected_color = if first && second {
                expected_color1
            } else if first || second {
                expected_color2
            } else {
                black_color
            };

            if (0..4).any(|c| (color[c] - expected_color[c]).abs() > threshold) {
                log::info!("Color at ({i}, {j}) is expected to be ({expected_color:?}), but was ({color:?})");
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectBindingDrawCase {
    name: String,
    params: BindingDrawParams,
}

impl TestCase for ShaderObjectBindingDrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;

        let tessellation_stages = [
            vk::ShaderStageFlags::TESSELLATION_CONTROL,
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
        ];
        if (tessellation_stages.contains(&self.params.stage) || tessellation_stages.contains(&self.params.binary_stage))
            && context.get_device_features().tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }

        if (self.params.stage == vk::ShaderStageFlags::GEOMETRY
            || self.params.binary_stage == vk::ShaderStageFlags::GEOMETRY)
            && context.get_device_features().geometry_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "geometryShader feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match unused_output_variant(self.params.unused_outputs) {
            1 => BINDING_DRAW_VERT.programs,
            2 => BINDING_DRAW_TESC.programs,
            3 => BINDING_DRAW_TESE.programs,
            4 => BINDING_DRAW_GEOM.programs,
            5 => BINDING_DRAW_FRAG.programs,
            _ => BINDING_DRAW_NONE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectBindingDrawInstance {
            context,
            params: self.params,
        })
    }
}

struct ShaderObjectBindingDrawInstance<'a> {
    context: &'a Context<'a>,
    params: BindingDrawParams,
}

impl TestInstance for ShaderObjectBindingDrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_binding_draw(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// bindings
// ---------------------------------------------------------------------------------------------------------------------

fn run_bindings(context: &Context<'_>, use_mesh_shaders: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let mesh_features = get_mesh_shader_features(context);
    let tessellation_supported = context.get_device_features().tessellation_shader != vk::FALSE;
    let geometry_supported = context.get_device_features().geometry_shader != vk::FALSE;
    let binaries = context.get_binary_collection();

    let layout_stages = vk::ShaderStageFlags::COMPUTE
        | if use_mesh_shaders && mesh_features.mesh_shader != vk::FALSE {
            vk::ShaderStageFlags::MESH_EXT
        } else {
            vk::ShaderStageFlags::empty()
        };
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, layout_stages)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;

    let features = *context.get_device_features();
    let make = |stage: vk::ShaderStageFlags, name: &str, layout: Option<&vk::DescriptorSetLayout>| {
        make_shader(device, binaries, stage, name, &features, layout)
    };

    let vert_shader = make(vk::ShaderStageFlags::VERTEX, "vert", None)?;
    let frag_shader = make(vk::ShaderStageFlags::FRAGMENT, "frag", None)?;
    let comp_shader = make(vk::ShaderStageFlags::COMPUTE, "comp", Some(&layout_handle))?;
    let mut tesc_shader = None;
    let mut tese_shader = None;
    let mut geom_shader = None;
    let mut task_shader = None;
    let mut mesh_shader = None;
    if tessellation_supported {
        tesc_shader = Some(make(vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc", None)?);
        tese_shader = Some(make(vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese", None)?);
    }
    if geometry_supported {
        geom_shader = Some(make(vk::ShaderStageFlags::GEOMETRY, "geom", None)?);
    }
    if use_mesh_shaders {
        if mesh_features.task_shader != vk::FALSE {
            task_shader = Some(make(vk::ShaderStageFlags::TASK_EXT, "task", None)?);
        }
        if mesh_features.mesh_shader != vk::FALSE {
            mesh_shader = Some(make(vk::ShaderStageFlags::MESH_EXT, "mesh", Some(&layout_handle))?);
        }
    }

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let stages = [
        vk::ShaderStageFlags::VERTEX,
        vk::ShaderStageFlags::TESSELLATION_CONTROL,
        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
        vk::ShaderStageFlags::GEOMETRY,
        vk::ShaderStageFlags::FRAGMENT,
        vk::ShaderStageFlags::COMPUTE,
        vk::ShaderStageFlags::MESH_EXT,
        vk::ShaderStageFlags::TASK_EXT,
    ];
    let select = |condition: bool, shader: vk::ShaderEXT| if condition { shader } else { vk::ShaderEXT::null() };

    for bind_vert in [true, false] {
        for bind_tesc in [true, false] {
            for bind_tese in [true, false] {
                for bind_geom in [true, false] {
                    for bind_frag in [true, false] {
                        for bind_comp in [true, false] {
                            for bind_task in [true, false] {
                                if bind_vert && bind_task {
                                    continue;
                                }
                                for bind_mesh in [true, false] {
                                    if bind_vert && bind_mesh {
                                        continue;
                                    }
                                    let shaders = [
                                        select(bind_vert, vert_shader.get()),
                                        select(bind_tesc && tessellation_supported, handle_of(&tesc_shader)),
                                        select(bind_tese && tessellation_supported, handle_of(&tese_shader)),
                                        select(bind_geom && geometry_supported, handle_of(&geom_shader)),
                                        select(bind_frag, frag_shader.get()),
                                        select(bind_comp, comp_shader.get()),
                                        select(
                                            bind_mesh && mesh_features.mesh_shader != vk::FALSE,
                                            handle_of(&mesh_shader),
                                        ),
                                        select(
                                            bind_task && mesh_features.task_shader != vk::FALSE,
                                            handle_of(&task_shader),
                                        ),
                                    ];
                                    begin_command_buffer(device, cmd)?;
                                    unsafe { device.cmd_bind_shaders_ext(cmd, &stages, &shaders) };
                                    end_command_buffer(device, cmd)?;
                                    submit_commands_and_wait(device, queue, cmd)?;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    if tessellation_supported
        && geometry_supported
        && mesh_features.task_shader != vk::FALSE
        && mesh_features.mesh_shader != vk::FALSE
    {
        begin_command_buffer(device, cmd)?;
        bind_shaders_null_pointer(device, cmd, &stages);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    Ok(TestStatus::pass("pass"))
}

struct ShaderObjectBindingCase {
    name: &'static str,
    use_mesh_shaders: bool,
}

impl TestCase for ShaderObjectBindingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        if self.use_mesh_shaders {
            context.require_device_functionality("VK_EXT_mesh_shader")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.use_mesh_shaders {
            BINDING_BINDINGS_MESH.programs
        } else {
            SHADER_OBJECT_BASIC.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectBindingInstance {
            context,
            use_mesh_shaders: self.use_mesh_shaders,
        })
    }
}

struct ShaderObjectBindingInstance<'a> {
    context: &'a Context<'a>,
    use_mesh_shaders: bool,
}

impl TestInstance for ShaderObjectBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_bindings(self.context, self.use_mesh_shaders)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// mesh_swap_task / mesh_swap_mesh
// ---------------------------------------------------------------------------------------------------------------------

fn require_task_and_mesh(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_shader_object")?;
    context.require_device_functionality("VK_EXT_mesh_shader")?;
    let features = get_mesh_shader_features(context);
    if features.task_shader == vk::FALSE {
        return Err(TestError::NotSupported("Task shaders not supported".to_string()));
    }
    if features.mesh_shader == vk::FALSE {
        return Err(TestError::NotSupported("Mesh shaders not supported".to_string()));
    }
    Ok(())
}

fn run_mesh_swap(context: &Context<'_>, stage: vk::ShaderStageFlags) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;

    let target = create_color_target(context)?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(
            vk::DescriptorType::STORAGE_BUFFER,
            vk::ShaderStageFlags::TASK_EXT | vk::ShaderStageFlags::MESH_EXT,
        )
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let buffer_size_bytes = (std::mem::size_of::<u32>() * 4) as u64;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let buffer_info = [vk::DescriptorBufferInfo {
        buffer: output_buffer.get(),
        offset: 0,
        range: buffer_size_bytes,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;

    let binaries = context.get_binary_collection();
    let no_tessellation_or_geometry = vk::PhysicalDeviceFeatures::default();
    let make = |shader_stage: vk::ShaderStageFlags, name: &str| {
        make_shader(
            device,
            binaries,
            shader_stage,
            name,
            &no_tessellation_or_geometry,
            Some(&layout_handle),
        )
    };
    let task_shader1 = make(vk::ShaderStageFlags::TASK_EXT, "task1")?;
    let task_shader2 = make(vk::ShaderStageFlags::TASK_EXT, "task2")?;
    let mesh_shader1 = make(vk::ShaderStageFlags::MESH_EXT, "mesh1")?;
    let mesh_shader2 = make(vk::ShaderStageFlags::MESH_EXT, "mesh2")?;
    let frag_shader = make(vk::ShaderStageFlags::FRAGMENT, "frag")?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    };
    let render_area = rect_2d(RENDER_SIZE, RENDER_SIZE);

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    begin_rendering(
        device,
        cmd,
        *target.view,
        render_area,
        clear_value,
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );
    set_default_shader_object_dynamic_states(
        device,
        cmd,
        &extensions,
        vk::PrimitiveTopology::TRIANGLE_LIST,
        true,
        false,
        RENDER_SIZE,
        RENDER_SIZE,
    );
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            pipeline_layout.get(),
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        )
    };

    let mut null_stages = vec![vk::ShaderStageFlags::VERTEX];
    if context.get_device_features().tessellation_shader != vk::FALSE {
        null_stages.push(vk::ShaderStageFlags::TESSELLATION_CONTROL);
        null_stages.push(vk::ShaderStageFlags::TESSELLATION_EVALUATION);
    }
    if context.get_device_features().geometry_shader != vk::FALSE {
        null_stages.push(vk::ShaderStageFlags::GEOMETRY);
    }
    for null_stage in null_stages {
        unsafe { device.cmd_bind_shaders_ext(cmd, &[null_stage], &[vk::ShaderEXT::null()]) };
    }

    let stages = [
        vk::ShaderStageFlags::TASK_EXT,
        vk::ShaderStageFlags::MESH_EXT,
        vk::ShaderStageFlags::FRAGMENT,
    ];
    unsafe {
        device.cmd_bind_shaders_ext(
            cmd,
            &stages,
            &[task_shader1.get(), mesh_shader1.get(), frag_shader.get()],
        );
        device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
    }
    end_rendering(device, cmd);

    let shader_buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::SHADER_WRITE,
        output_buffer.get(),
        0,
        buffer_size_bytes,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[shader_buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    begin_rendering(
        device,
        cmd,
        *target.view,
        render_area,
        clear_value,
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::LOAD,
        vk::RenderingFlags::empty(),
        1,
        0,
    );
    unsafe {
        if stage == vk::ShaderStageFlags::TASK_EXT {
            device.cmd_bind_shaders_ext(cmd, &stages[0..1], &[task_shader2.get()]);
        } else if stage == vk::ShaderStageFlags::MESH_EXT {
            device.cmd_bind_shaders_ext(cmd, &stages[1..2], &[mesh_shader2.get()]);
        }
        device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
    }
    end_rendering(device, cmd);

    let post_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::GENERAL,
        target.image.get(),
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        output_buffer.get(),
        0,
        buffer_size_bytes,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_image_barrier],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let allocation = output_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;
    let values = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), 4) };

    if stage == vk::ShaderStageFlags::TASK_EXT {
        if values != [4, 5, 2, 3] {
            log::info!("Buffer values were expected to be [4, 5, 2, 3], but were{values:?}");
            return Ok(TestStatus::fail("Fail"));
        }
    } else if stage == vk::ShaderStageFlags::MESH_EXT && values != [0, 1, 6, 7] {
        log::info!("Buffer values were expected to be [0, 1, 6, 7], but were{values:?}");
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("pass"))
}

struct MeshShaderObjectBindingCase {
    name: String,
    stage: vk::ShaderStageFlags,
}

impl TestCase for MeshShaderObjectBindingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        require_task_and_mesh(context)
    }

    fn programs(&self) -> BinaryCollection {
        BINDING_MESH_SWAP.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshShaderObjectBindingInstance {
            context,
            stage: self.stage,
        })
    }
}

struct MeshShaderObjectBindingInstance<'a> {
    context: &'a Context<'a>,
    stage: vk::ShaderStageFlags,
}

impl TestInstance for MeshShaderObjectBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_mesh_swap(self.context, self.stage)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// unbind_vtg / unbind_task_mesh / unbind_mesh_draw_vertex
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum UnbindTestType {
    UnbindVtg,
    UnbindTaskMesh,
    UnbindMeshDrawVertex,
}

fn run_unbind(context: &Context<'_>, test_type: UnbindTestType) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let features = *context.get_device_features();
    let mesh_features = get_mesh_shader_features(context);
    let task_supported = mesh_features.task_shader != vk::FALSE;
    let mesh_supported = mesh_features.mesh_shader != vk::FALSE;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let target = create_color_target(context)?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::MESH_EXT)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let buffer_size_bytes = (std::mem::size_of::<u32>() * 4) as u64;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let buffer_info = [vk::DescriptorBufferInfo {
        buffer: output_buffer.get(),
        offset: 0,
        range: buffer_size_bytes,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let mut index_buffer = None;
    if test_type == UnbindTestType::UnbindMeshDrawVertex {
        let indices: [u32; 7] = [0, 1, 2, 3, 0xFFFF_FFFF, 4, 5];
        let index_data_size = (std::mem::size_of::<u32>() * 7) as u64;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(index_data_size, vk::BufferUsageFlags::INDEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let allocation = buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                indices.as_ptr().cast::<u8>(),
                allocation.get_host_ptr(),
                index_data_size as usize,
            )
        };
        flush_alloc(device, allocation)?;
        index_buffer = Some(buffer);
    }

    let pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;

    let binaries = context.get_binary_collection();
    let make = |stage: vk::ShaderStageFlags, name: &str| {
        make_shader(device, binaries, stage, name, &features, Some(&layout_handle))
    };
    let vert_shader = make(vk::ShaderStageFlags::VERTEX, "vert")?;
    let vert_shader2 = make(vk::ShaderStageFlags::VERTEX, "vert_offset")?;
    let tesc_shader = make(vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc")?;
    let tese_shader = make(vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese")?;
    let geom_shader = make(vk::ShaderStageFlags::GEOMETRY, "geom")?;
    let frag_shader = make(vk::ShaderStageFlags::FRAGMENT, "frag_white")?;
    let task_shader = make(vk::ShaderStageFlags::TASK_EXT, "task")?;
    let mesh_shader = make(vk::ShaderStageFlags::MESH_EXT, "mesh")?;
    let frag_shader2 = make(vk::ShaderStageFlags::FRAGMENT, "frag_red")?;

    let vtg_stages = [
        vk::ShaderStageFlags::VERTEX,
        vk::ShaderStageFlags::TESSELLATION_CONTROL,
        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
        vk::ShaderStageFlags::GEOMETRY,
    ];
    let task_mesh_frag_stages = [
        vk::ShaderStageFlags::TASK_EXT,
        vk::ShaderStageFlags::MESH_EXT,
        vk::ShaderStageFlags::FRAGMENT,
    ];

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    unsafe {
        match test_type {
            UnbindTestType::UnbindVtg => {
                set_default_shader_object_dynamic_states(
                    device,
                    cmd,
                    &extensions,
                    vk::PrimitiveTopology::TRIANGLE_LIST,
                    true,
                    false,
                    RENDER_SIZE,
                    RENDER_SIZE,
                );
                bind_graphics_shaders(
                    device,
                    cmd,
                    vert_shader.get(),
                    tesc_shader.get(),
                    tese_shader.get(),
                    geom_shader.get(),
                    frag_shader.get(),
                    task_supported,
                    mesh_supported,
                );
                device.cmd_bind_shaders_ext(cmd, &vtg_stages, &[vk::ShaderEXT::null(); 4]);
                device.cmd_bind_shaders_ext(
                    cmd,
                    &[vk::ShaderStageFlags::TASK_EXT, vk::ShaderStageFlags::MESH_EXT],
                    &[task_shader.get(), mesh_shader.get()],
                );
                device.cmd_bind_shaders_ext(cmd, &vtg_stages, &[vk::ShaderEXT::null(); 4]);
            }
            UnbindTestType::UnbindTaskMesh => {
                set_default_shader_object_dynamic_states(
                    device,
                    cmd,
                    &extensions,
                    vk::PrimitiveTopology::TRIANGLE_STRIP,
                    false,
                    false,
                    RENDER_SIZE,
                    RENDER_SIZE,
                );
                bind_null_rasterization_shaders(device, cmd, &features);
                device.cmd_bind_shaders_ext(
                    cmd,
                    &task_mesh_frag_stages,
                    &[task_shader.get(), mesh_shader.get(), frag_shader.get()],
                );
                device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::TASK_EXT], &[vk::ShaderEXT::null()]);
                device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::MESH_EXT], &[vk::ShaderEXT::null()]);
                device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::VERTEX], &[vert_shader.get()]);
            }
            UnbindTestType::UnbindMeshDrawVertex => {
                set_default_shader_object_dynamic_states(
                    device,
                    cmd,
                    &extensions,
                    vk::PrimitiveTopology::TRIANGLE_LIST,
                    false,
                    false,
                    RENDER_SIZE,
                    RENDER_SIZE,
                );
                device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::LINE_LIST);
                device.cmd_set_primitive_restart_enable_ext(cmd, false);
                bind_null_rasterization_shaders(device, cmd, &features);
                device.cmd_bind_shaders_ext(
                    cmd,
                    &task_mesh_frag_stages,
                    &[task_shader.get(), mesh_shader.get(), frag_shader.get()],
                );
                device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP);
                device.cmd_set_primitive_restart_enable_ext(cmd, true);
            }
        }

        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            pipeline_layout.get(),
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
    }

    begin_rendering(
        device,
        cmd,
        *target.view,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        },
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );
    unsafe {
        match test_type {
            UnbindTestType::UnbindVtg => device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1),
            UnbindTestType::UnbindTaskMesh => device.cmd_draw(cmd, 4, 1, 0, 0),
            UnbindTestType::UnbindMeshDrawVertex => {
                device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
                device.cmd_bind_shaders_ext(cmd, &task_mesh_frag_stages[0..2], &[vk::ShaderEXT::null(); 2]);
                device.cmd_bind_shaders_ext(
                    cmd,
                    &[vk::ShaderStageFlags::VERTEX, vk::ShaderStageFlags::FRAGMENT],
                    &[vert_shader2.get(), frag_shader2.get()],
                );
                let index_buffer = index_buffer.as_ref().expect("created for this test type");
                device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT32);
                device.cmd_draw_indexed(cmd, 7, 1, 0, 0, 0);
            }
        }
    }
    end_rendering(device, cmd);

    record_readback(device, cmd, &target, Some((output_buffer.get(), buffer_size_bytes)));

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;
    invalidate_alloc(device, target.output_buffer.get_allocation())?;

    let pixels = read_pixels(&target);
    let white = [255u8, 255, 255, 255];
    let red = [255u8, 0, 0, 255];
    let black = [0u8, 0, 0, 255];
    let size = RENDER_SIZE as usize;
    let offset = 8;

    let check_buffer = || -> Result<bool, TestError> {
        let allocation = output_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;

        let values = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), 4) };
        if values != [0, 1, 2, 3] {
            log::info!("Buffer values were expected to be [0, 1, 2, 3], but were{values:?}");
            return Ok(false);
        }
        Ok(true)
    };

    let inside = |i: usize, j: usize| i >= offset && i < size - offset && j >= offset && j < size - offset;
    match test_type {
        UnbindTestType::UnbindVtg => {
            for j in 0..size {
                for i in 0..size {
                    let color = pixel(pixels, i, j);
                    if color != white {
                        log::info!("Color at ({i}, {j}) is expected to be (1.0, 1.0, 1.0, 1.0), but was ({color:?})");
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
            if !check_buffer()? {
                return Ok(TestStatus::fail("Fail"));
            }
        }
        UnbindTestType::UnbindTaskMesh => {
            for j in 0..size {
                for i in 0..size {
                    let color = pixel(pixels, i, j);
                    let expected = if inside(i, j) { white } else { black };
                    if color != expected {
                        log::info!("Color at ({i}, {j}) is expected to be ({expected:?}), but was ({color:?})");
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }
        UnbindTestType::UnbindMeshDrawVertex => {
            for j in 0..size {
                for i in 0..size {
                    let color = pixel(pixels, i, j);
                    let expected = if inside(i, j) { red } else { white };
                    if color != expected {
                        log::info!("Color at ({i}, {j}) is expected to be ({expected:?}), but was ({color:?})");
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
            if !check_buffer()? {
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("pass"))
}

struct ShaderObjectUnbindCase {
    name: &'static str,
    test_type: UnbindTestType,
}

impl TestCase for ShaderObjectUnbindCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        require_task_and_mesh(context)
    }

    fn programs(&self) -> BinaryCollection {
        BINDING_UNBIND.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectUnbindInstance {
            context,
            test_type: self.test_type,
        })
    }
}

struct ShaderObjectUnbindInstance<'a> {
    context: &'a Context<'a>,
    test_type: UnbindTestType,
}

impl TestInstance for ShaderObjectUnbindInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_unbind(self.context, self.test_type)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// createShaderObjectBindingTests
// ---------------------------------------------------------------------------------------------------------------------

fn add_draw_case(group: &mut TestCaseGroup, name: String, params: BindingDrawParams) {
    group.add_child(Box::new(ShaderObjectBindingDrawCase { name, params }) as Box<dyn TestCase>);
}

/// `createShaderObjectBindingTests`
pub fn create_shader_object_binding_tests() -> TestCaseGroup {
    let mut binding_group = TestCaseGroup::new("binding");

    let all = vk::ShaderStageFlags::ALL;
    let mut params = BindingDrawParams {
        test_type: TestType::PassthroughGeom,
        stage: vk::ShaderStageFlags::GEOMETRY,
        unused_outputs: vk::ShaderStageFlags::TASK_EXT,
        binary_stage: vk::ShaderStageFlags::TASK_EXT,
        set_state_after: false,
        unbind_with_null_pshaders: false,
        bind_unsupported: false,
    };

    add_draw_case(&mut binding_group, "unbind_passthrough_geom".to_string(), params);

    let stage_tests = [
        (vk::ShaderStageFlags::VERTEX, "vert"),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"),
        (vk::ShaderStageFlags::GEOMETRY, "geom"),
        (vk::ShaderStageFlags::FRAGMENT, "frag"),
    ];
    params.test_type = TestType::Swap;

    for (stage, stage_name) in stage_tests {
        params.stage = stage;
        params.unused_outputs = all;
        params.binary_stage = all;
        params.set_state_after = false;
        add_draw_case(&mut binding_group, format!("swap_{stage_name}"), params);
        for (unused_outputs, unused_name) in stage_tests {
            for (binary_stage, binary_name) in stage_tests {
                for i in 0..2 {
                    params.stage = stage;
                    params.unused_outputs = unused_outputs;
                    params.binary_stage = binary_stage;
                    params.set_state_after = i == 1;
                    let name = format!(
                        "swap_{stage_name}_unused_output_{unused_name}_binary_{binary_name}_{}",
                        if i == 0 { "before" } else { "after" }
                    );
                    add_draw_case(&mut binding_group, name, params);
                }
            }
        }
    }

    params.unused_outputs = all;
    params.binary_stage = all;

    let unbind_stage_tests = [
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"),
        (vk::ShaderStageFlags::GEOMETRY, "geom"),
    ];
    params.test_type = TestType::Unbind;
    params.set_state_after = false;
    for (stage, stage_name) in unbind_stage_tests {
        for i in 0..2 {
            params.stage = stage;
            params.unbind_with_null_pshaders = i == 1;
            let name = format!(
                "unbind_{stage_name}{}",
                if params.unbind_with_null_pshaders {
                    "_null_pshaders"
                } else {
                    "_null_handle"
                }
            );
            add_draw_case(&mut binding_group, name, params);
        }
    }

    for (stage, stage_name) in [
        (vk::ShaderStageFlags::TASK_EXT, "task"),
        (vk::ShaderStageFlags::MESH_EXT, "mesh"),
    ] {
        binding_group.add_child(Box::new(MeshShaderObjectBindingCase {
            name: format!("mesh_swap_{stage_name}"),
            stage,
        }) as Box<dyn TestCase>);
    }

    params.test_type = TestType::Disabled;
    params.stage = vk::ShaderStageFlags::GEOMETRY;
    add_draw_case(&mut binding_group, "disabled_geom".to_string(), params);
    params.stage = vk::ShaderStageFlags::TESSELLATION_CONTROL;
    add_draw_case(&mut binding_group, "disabled_tess".to_string(), params);
    params.stage = vk::ShaderStageFlags::GEOMETRY;
    params.bind_unsupported = true;
    add_draw_case(&mut binding_group, "disabled_geom_bind".to_string(), params);
    params.stage = vk::ShaderStageFlags::TESSELLATION_CONTROL;
    add_draw_case(&mut binding_group, "disabled_tess_bind".to_string(), params);
    params.test_type = TestType::DrawDispatchDraw;
    add_draw_case(&mut binding_group, "draw_dispatch_draw".to_string(), params);
    params.test_type = TestType::DispatchDrawDispatch;
    add_draw_case(&mut binding_group, "dispatch_draw_dispatch".to_string(), params);

    binding_group.add_child(Box::new(ShaderObjectBindingCase {
        name: "bindings",
        use_mesh_shaders: false,
    }) as Box<dyn TestCase>);
    binding_group.add_child(Box::new(ShaderObjectBindingCase {
        name: "bindings_mesh_shaders",
        use_mesh_shaders: true,
    }) as Box<dyn TestCase>);

    binding_group.add_child(Box::new(ShaderObjectUnbindCase {
        name: "unbind_vtg",
        test_type: UnbindTestType::UnbindVtg,
    }) as Box<dyn TestCase>);
    binding_group.add_child(Box::new(ShaderObjectUnbindCase {
        name: "unbind_task_mesh",
        test_type: UnbindTestType::UnbindTaskMesh,
    }) as Box<dyn TestCase>);
    binding_group.add_child(Box::new(ShaderObjectUnbindCase {
        name: "unbind_mesh_draw_vertex",
        test_type: UnbindTestType::UnbindMeshDrawVertex,
    }) as Box<dyn TestCase>);

    binding_group
}
