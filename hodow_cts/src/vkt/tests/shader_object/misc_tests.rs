// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are the `MISC_*` constants of `shaders/manifest/shader_object_misc.toml`.
// Ported: the `on/off` blend and vertex input groups, `unused_variable`, `tessellation_modes`, `tess_patch_non_match` and `push_const`;
// the `state` group is in `misc_state_tests.rs`. Upstream's `unused_variable`
// sets the link flag after the shaders were created, so it has no effect there and none here. Pixels are compared as bytes (a colour of 1.0
// is 255, 0.5 is 127.5 within upstream's 1/256 threshold).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtColorWriteEnableExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands, Handle,
};

use super::link_tests::{
    RENDER_SIZE, create_color_target, create_color_target_with_format, read_pixels, record_pre_barrier, record_readback,
};
use super::util::{
    ShaderObject, bind_graphics_shaders, create_shader, create_shaders_raw, get_mesh_shader_features, make_shader,
    make_shader_create_info, remove_unsupported_shader_object_extensions, set_default_shader_object_dynamic_states,
};
use crate::generated::shaders::shader_object_misc::{
    MISC_BLEND, MISC_MODES_1_EQUAL, MISC_MODES_1_EVEN, MISC_MODES_1_ODD, MISC_MODES_2_EQUAL, MISC_MODES_2_EVEN,
    MISC_MODES_2_ODD, MISC_PUSH_CONST_17_37, MISC_PUSH_CONST_17_37_ALL, MISC_PUSH_CONST_17_64, MISC_PUSH_CONST_36_37,
    MISC_PUSH_CONST_36_37_ALL, MISC_PUSH_CONST_57_64_ALL, MISC_PUSH_CONST_63_64, MISC_PUSH_CONST_63_64_ALL,
    MISC_TESS_PATCH_NON_MATCH, MISC_UNUSED_GEOM_BUILTIN, MISC_UNUSED_GEOM_OUTPUT, MISC_UNUSED_TESC_BUILTIN,
    MISC_UNUSED_TESC_OUTPUT, MISC_UNUSED_TESE_BUILTIN, MISC_UNUSED_TESE_OUTPUT, MISC_UNUSED_VERT_BUILTIN,
    MISC_UNUSED_VERT_OUTPUT,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::draw::util::{begin_rendering, end_rendering, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// A shader of `stage` from the test's binaries that carries `push_range` and no descriptor set layout.
fn make_push_shader<'a>(
    device: &'a Device,
    binaries: BinaryCollection,
    stage: vk::ShaderStageFlags,
    name: &str,
    tessellation: bool,
    geometry: bool,
    push_range: &vk::PushConstantRange,
) -> Result<ShaderObject<'a>, TestError> {
    create_shader(
        device,
        &make_shader_create_info(
            stage,
            &binaries.get(name)?,
            tessellation,
            geometry,
            None,
            Some(push_range),
        ),
    )
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

fn clear_value(color: [f32; 4]) -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { float32: color },
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// misc.<blend>.<blend>.<before/after>.<null/non_null>.<stride>.<set/destroyed>
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct BlendParams {
    blend_enabled: [bool; 2],
    vertex_input_before: bool,
    vertex_buffers_null_stride: bool,
    stride: u32,
    destroy_descriptor_set_layout: bool,
}

fn set_vertex_input(device: &Device, cmd: vk::CommandBuffer, stride: u64) {
    let binding = vk::VertexInputBindingDescription2EXT::builder()
        .binding(0)
        .stride(stride as u32)
        .input_rate(vk::VertexInputRate::VERTEX)
        .divisor(1)
        .build();
    let attribute = vk::VertexInputAttributeDescription2EXT::builder()
        .location(0)
        .binding(0)
        .format(vk::Format::R32G32B32A32_SFLOAT)
        .offset(0)
        .build();
    unsafe { device.cmd_set_vertex_input_ext(cmd, &[binding], &[attribute]) };
}

fn run_blend(context: &Context<'_>, params: &BlendParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let features = *context.get_device_features();
    let mesh_features = get_mesh_shader_features(context);

    const ATTACHMENT_COUNT: usize = 2;
    let targets = [create_color_target(context)?, create_color_target(context)?];

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let buffer_size_bytes = std::mem::size_of::<[f32; 4]>() as u64;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
    let input_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let buffer_info = [vk::DescriptorBufferInfo {
        buffer: input_buffer.get(),
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

    let input_allocation = input_buffer.get_allocation();
    unsafe { std::slice::from_raw_parts_mut(input_allocation.get_host_ptr().cast::<f32>(), 4) }.fill(0.5);
    flush_alloc(device, input_allocation)?;

    let binaries = context.get_binary_collection();
    let vert_shader = make_shader(
        device,
        binaries,
        vk::ShaderStageFlags::VERTEX,
        "inputVert",
        &features,
        Some(&layout_handle),
    )?;
    let frag_shader = make_shader(
        device,
        binaries,
        vk::ShaderStageFlags::FRAGMENT,
        "multiFrag",
        &features,
        Some(&layout_handle),
    )?;

    let vertex_buffer_size = 1024u64;
    let vertex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let vertex_allocation = vertex_buffer.get_allocation();
    let vertex_data = unsafe {
        std::slice::from_raw_parts_mut(
            vertex_allocation.get_host_ptr().cast::<f32>(),
            vertex_buffer_size as usize / 4,
        )
    };
    vertex_data.fill(0.0);
    let stride_floats = params.stride as usize / std::mem::size_of::<f32>();
    for i in 0..4usize {
        vertex_data[i * stride_floats] = (i & 1) as f32;
        vertex_data[i * stride_floats + 1] = ((i >> 1) & 1) as f32;
        vertex_data[i * stride_floats + 2] = 0.0;
        vertex_data[i * stride_floats + 3] = 1.0;
    }
    flush_alloc(device, vertex_allocation)?;

    begin_command_buffer(device, cmd)?;
    for target in &targets {
        record_pre_barrier(device, cmd, target.image.get());
    }

    let color_attachments: Vec<vk::RenderingAttachmentInfo> = targets
        .iter()
        .map(|target| {
            vk::RenderingAttachmentInfo::builder()
                .image_view(*target.view)
                .image_layout(vk::ImageLayout::GENERAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_value([0.0, 0.0, 0.0, 0.0]))
                .build()
        })
        .collect();
    let rendering_info = vk::RenderingInfo::builder()
        .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments);

    if params.destroy_descriptor_set_layout {
        drop(descriptor_set_layout);
    }

    unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
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

    let color_blend_equation = vk::ColorBlendEquationEXT {
        src_color_blend_factor: vk::BlendFactor::ONE,
        dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ONE,
        dst_alpha_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
        alpha_blend_op: vk::BlendOp::ADD,
    };
    let color_write_mask = vk::ColorComponentFlags::R
        | vk::ColorComponentFlags::G
        | vk::ColorComponentFlags::B
        | vk::ColorComponentFlags::A;
    for i in 0..ATTACHMENT_COUNT {
        unsafe {
            device.cmd_set_color_blend_enable_ext(
                cmd,
                i as u32,
                &[if params.blend_enabled[i] { vk::TRUE } else { vk::FALSE }],
            );
            if params.blend_enabled[i] {
                device.cmd_set_color_blend_equation_ext(cmd, i as u32, &[color_blend_equation]);
            }
            device.cmd_set_color_write_mask_ext(cmd, i as u32, &[color_write_mask]);
        }
    }

    let max_color_attachments = unsafe {
        context
            .get_instance()
            .get_physical_device_properties(context.get_physical_device())
    }
    .limits
    .max_color_attachments;
    let color_write_enables: Vec<vk::Bool32> = (0..max_color_attachments)
        .map(|i| {
            if (i as usize) < ATTACHMENT_COUNT {
                vk::TRUE
            } else {
                vk::FALSE
            }
        })
        .collect();
    unsafe { device.cmd_set_color_write_enable_ext(cmd, &color_write_enables) };

    if params.vertex_input_before {
        set_vertex_input(
            device,
            cmd,
            if params.vertex_buffers_null_stride {
                u64::from(params.stride)
            } else {
                100
            },
        );
    }

    let buffer = vertex_buffer.get();
    let stride = u64::from(params.stride);
    unsafe {
        if params.vertex_buffers_null_stride {
            (device.commands().cmd_bind_vertex_buffers2_ext)(
                cmd,
                0,
                1,
                &buffer,
                &0,
                &vertex_buffer_size,
                std::ptr::null(),
            );
        } else {
            device.cmd_bind_vertex_buffers2_ext(cmd, 0, &[buffer], &[0], &[vertex_buffer_size], &[stride]);
        }
    }
    if !params.vertex_input_before {
        set_vertex_input(device, cmd, stride);
    }

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

    let null = vk::ShaderEXT::null();
    bind_graphics_shaders(
        device,
        cmd,
        vert_shader.get(),
        null,
        null,
        null,
        frag_shader.get(),
        mesh_features.task_shader != vk::FALSE,
        mesh_features.mesh_shader != vk::FALSE,
    );

    unsafe {
        device.cmd_draw(cmd, 4, 1, 0, 0);
        device.cmd_draw(cmd, 4, 1, 0, 0);
    }
    end_rendering(device, cmd);

    for target in &targets {
        record_readback(device, cmd, target, None);
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let size = RENDER_SIZE as usize;
    let threshold = 1.0 / 256.0;
    let x_offset = size / 8;
    let y_offset = size / 8;
    for (k, target) in targets.iter().enumerate() {
        invalidate_alloc(device, target.output_buffer.get_allocation())?;
        let pixels = read_pixels(target);

        for j in 0..size {
            for i in 0..size {
                let color = pixel(pixels, i, j).map(|channel| f32::from(channel) / 255.0);
                let expected = if i >= x_offset && i < size - x_offset && j >= y_offset && j < size - y_offset {
                    if params.blend_enabled[k] { 0.75 } else { 0.5 }
                } else {
                    0.0
                };
                if color.iter().any(|&channel| (channel - expected).abs() > threshold) {
                    log::info!("Color at ({i}, {j}) was {color:?}, but expected color was {expected}");
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectMiscCase {
    name: &'static str,
    params: BlendParams,
}

impl TestCase for ShaderObjectMiscCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")
    }

    fn programs(&self) -> BinaryCollection {
        MISC_BLEND.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectMiscInstance {
            context,
            params: self.params,
        })
    }
}

struct ShaderObjectMiscInstance<'a> {
    context: &'a Context<'a>,
    params: BlendParams,
}

impl TestInstance for ShaderObjectMiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_blend(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// misc.unused_variable
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct UnusedBuiltinParams {
    linked: bool,
    stage: vk::ShaderStageFlags,
    builtin: bool,
}

fn run_unused_builtin(context: &Context<'_>, params: &UnusedBuiltinParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let features = *context.get_device_features();
    let mesh_features = get_mesh_shader_features(context);

    let target = create_color_target(context)?;

    let binaries = context.get_binary_collection();
    let stages = [
        (vk::ShaderStageFlags::VERTEX, "vert"),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"),
        (vk::ShaderStageFlags::GEOMETRY, "geom"),
        (vk::ShaderStageFlags::FRAGMENT, "frag"),
    ];
    let mut create_infos = Vec::new();
    for (stage, name) in stages {
        create_infos.push(make_shader_create_info(
            stage,
            &binaries.get(name)?,
            features.tessellation_shader != vk::FALSE,
            features.geometry_shader != vk::FALSE,
            None,
            None,
        ));
    }

    let mut handles = [vk::ShaderEXT::null(); 5];
    create_shaders_raw(device, &create_infos, &mut handles);

    if params.linked {
        for info in &mut create_infos {
            info.flags |= vk::ShaderCreateFlagsEXT::LINK_STAGE;
        }
    }
    let owned_shaders: Vec<ShaderObject<'_>> = handles
        .iter()
        .map(|&handle| ShaderObject::new(device, handle))
        .collect();

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    begin_rendering(
        device,
        cmd,
        *target.view,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        clear_value([0.0, 0.0, 0.0, 0.0]),
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );

    bind_graphics_shaders(
        device,
        cmd,
        handles[0],
        handles[1],
        handles[2],
        handles[3],
        handles[4],
        mesh_features.task_shader != vk::FALSE,
        mesh_features.mesh_shader != vk::FALSE,
    );
    set_default_shader_object_dynamic_states(
        device,
        cmd,
        &extensions,
        vk::PrimitiveTopology::PATCH_LIST,
        false,
        false,
        RENDER_SIZE,
        RENDER_SIZE,
    );

    unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };

    end_rendering(device, cmd);
    record_readback(device, cmd, &target, None);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    drop(owned_shaders);

    invalidate_alloc(device, target.output_buffer.get_allocation())?;

    let pixels = read_pixels(&target);
    let size = RENDER_SIZE as usize;
    let x_offset = 4;
    let y_offset = 4;
    for j in 0..size {
        for i in 0..size {
            let color = pixel(pixels, i, j);
            let inside = i >= x_offset && i < size - x_offset && j >= y_offset && j < size - y_offset;
            let expected = if inside { [255u8, 255, 255, 255] } else { [0u8, 0, 0, 0] };
            if color != expected {
                log::info!("Color at ({i}, {j}) is expected to be ({expected:?}), but was ({color:?})");
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectUnusedBuiltinCase {
    name: &'static str,
    params: UnusedBuiltinParams,
}

impl TestCase for ShaderObjectUnusedBuiltinCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature not supported".to_string(),
            ));
        }
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let stage = self.params.stage;
        let program = if stage == vk::ShaderStageFlags::VERTEX {
            if self.params.builtin {
                &MISC_UNUSED_VERT_BUILTIN
            } else {
                &MISC_UNUSED_VERT_OUTPUT
            }
        } else if stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
            if self.params.builtin {
                &MISC_UNUSED_TESC_BUILTIN
            } else {
                &MISC_UNUSED_TESC_OUTPUT
            }
        } else if stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
            if self.params.builtin {
                &MISC_UNUSED_TESE_BUILTIN
            } else {
                &MISC_UNUSED_TESE_OUTPUT
            }
        } else if self.params.builtin {
            &MISC_UNUSED_GEOM_BUILTIN
        } else {
            &MISC_UNUSED_GEOM_OUTPUT
        };
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectUnusedBuiltinInstance {
            context,
            params: self.params,
        })
    }
}

struct ShaderObjectUnusedBuiltinInstance<'a> {
    context: &'a Context<'a>,
    params: UnusedBuiltinParams,
}

impl TestInstance for ShaderObjectUnusedBuiltinInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_unused_builtin(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// misc.tessellation_modes
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum TessellationSpacing {
    Equal,
    Even,
    Odd,
}

#[derive(Clone, Copy)]
struct TessellationModesParams {
    subdivision: u32,
    spacing: TessellationSpacing,
}

fn run_tessellation_modes(context: &Context<'_>, params: &TessellationModesParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let features = *context.get_device_features();
    let mesh_features = get_mesh_shader_features(context);

    let target = create_color_target(context)?;

    let binaries = context.get_binary_collection();
    let vert_shader = make_shader(device, binaries, vk::ShaderStageFlags::VERTEX, "vert", &features, None)?;
    let tesc_shader = make_shader(
        device,
        binaries,
        vk::ShaderStageFlags::TESSELLATION_CONTROL,
        "tesc",
        &features,
        None,
    )?;
    let tese_shader = make_shader(
        device,
        binaries,
        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
        "tese",
        &features,
        None,
    )?;
    let frag_shader = make_shader(
        device,
        binaries,
        vk::ShaderStageFlags::FRAGMENT,
        "frag",
        &features,
        None,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    begin_rendering(
        device,
        cmd,
        *target.view,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        clear_value([0.0, 0.0, 0.0, 0.0]),
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );

    bind_graphics_shaders(
        device,
        cmd,
        vert_shader.get(),
        tesc_shader.get(),
        tese_shader.get(),
        vk::ShaderEXT::null(),
        frag_shader.get(),
        mesh_features.task_shader != vk::FALSE,
        mesh_features.mesh_shader != vk::FALSE,
    );
    set_default_shader_object_dynamic_states(
        device,
        cmd,
        &extensions,
        vk::PrimitiveTopology::PATCH_LIST,
        false,
        false,
        RENDER_SIZE,
        RENDER_SIZE,
    );
    unsafe {
        device.cmd_set_polygon_mode_ext(cmd, vk::PolygonMode::LINE);
        device.cmd_draw(cmd, 4, 1, 0, 0);
    }
    end_rendering(device, cmd);
    record_readback(device, cmd, &target, None);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, target.output_buffer.get_allocation())?;

    let table: &[[u8; 17]; 17] = match (params.subdivision, params.spacing) {
        (1, TessellationSpacing::Equal | TessellationSpacing::Odd) => &EQUAL1,
        (1, TessellationSpacing::Even) | (2, TessellationSpacing::Equal | TessellationSpacing::Even) => &EVEN1,
        _ => &ODD2,
    };

    let pixels = read_pixels(&target);
    let size = RENDER_SIZE as usize;
    for j in 0..size {
        for i in 0..size {
            let color = pixel(pixels, i, j);
            let inside = (7..24).contains(&i) && (7..24).contains(&j) && table[j - 7][i - 7] != 0;
            let expected = if inside { [255u8, 255, 255, 255] } else { [0u8, 0, 0, 0] };
            if color != expected {
                log::info!("Color at ({i}, {j}) is expected to be ({expected:?}), but was ({color:?})");
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectTessellationModesCase {
    name: &'static str,
    params: TessellationModesParams,
}

impl TestCase for ShaderObjectTessellationModesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program = match (self.params.subdivision, self.params.spacing) {
            (1, TessellationSpacing::Equal) => &MISC_MODES_1_EQUAL,
            (1, TessellationSpacing::Even) => &MISC_MODES_1_EVEN,
            (1, TessellationSpacing::Odd) => &MISC_MODES_1_ODD,
            (_, TessellationSpacing::Equal) => &MISC_MODES_2_EQUAL,
            (_, TessellationSpacing::Even) => &MISC_MODES_2_EVEN,
            (_, TessellationSpacing::Odd) => &MISC_MODES_2_ODD,
        };
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectTessellationModesInstance {
            context,
            params: self.params,
        })
    }
}

struct ShaderObjectTessellationModesInstance<'a> {
    context: &'a Context<'a>,
    params: TessellationModesParams,
}

impl TestInstance for ShaderObjectTessellationModesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_tessellation_modes(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// misc.tess_patch_non_match
// ---------------------------------------------------------------------------------------------------------------------

fn run_tess_patch_non_match(context: &Context<'_>, reverse: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let mesh_features = get_mesh_shader_features(context);

    let color_format = vk::Format::R8G8B8A8_UNORM;
    let extent = vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    };
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format: color_format,
        extent,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
    let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, color_format, color_srr)?;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let binaries = context.get_binary_collection();
    let pc_size = std::mem::size_of::<[f32; 4]>() as u32;
    let pc_stages = vk::ShaderStageFlags::TESSELLATION_CONTROL;
    let pc_range = vk::PushConstantRange {
        stage_flags: pc_stages,
        offset: 0,
        size: pc_size,
    };
    let ranges = [pc_range];
    let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&ranges);
    let pipeline_layout = crate::vk::ref_util::Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let make = |stage: vk::ShaderStageFlags, name: &str| {
        make_push_shader(device, binaries, stage, name, true, false, &pc_range)
    };
    let vert_shader = make(vk::ShaderStageFlags::VERTEX, "vert")?;
    let tesc0_shader = make(vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc0")?;
    let tesc1_shader = make(vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc1")?;
    let tese_shader = make(vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese")?;
    let frag_shader = make(vk::ShaderStageFlags::FRAGMENT, "frag")?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let geom_color: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
    let mut tesc_shaders = [tesc0_shader.get(), tesc1_shader.get()];
    if reverse {
        tesc_shaders.swap(0, 1);
    }

    begin_command_buffer(device, cmd)?;
    {
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            image.get(),
            color_srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            )
        };
    }

    begin_rendering(
        device,
        cmd,
        *view,
        rect_2d(1, 1),
        clear_value([0.0, 0.0, 0.0, 1.0]),
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );
    bind_graphics_shaders(
        device,
        cmd,
        vert_shader.get(),
        tesc_shaders[0],
        tese_shader.get(),
        vk::ShaderEXT::null(),
        frag_shader.get(),
        mesh_features.task_shader != vk::FALSE,
        mesh_features.mesh_shader != vk::FALSE,
    );
    set_default_shader_object_dynamic_states(
        device,
        cmd,
        &extensions,
        vk::PrimitiveTopology::PATCH_LIST,
        false,
        false,
        1,
        1,
    );

    let push_bytes: Vec<u8> = geom_color.iter().flat_map(|value| value.to_ne_bytes()).collect();
    unsafe {
        // The first draw is a no-op with the clear colour
        device.cmd_push_constants(cmd, pipeline_layout.get(), pc_stages, 0, &push_bytes);
        device.cmd_draw(cmd, 4, 1, 0, 0);

        // The second draw is the good one, with the geometry colour
        device.cmd_push_constants(cmd, pipeline_layout.get(), pc_stages, 0, &push_bytes);
        device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::TESSELLATION_CONTROL], &tesc_shaders[1..2]);
        device.cmd_draw(cmd, 4, 1, 0, 0);
    }
    end_rendering(device, cmd);

    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image.get(),
        color_srr,
    );
    let copy_region = make_buffer_image_copy(
        extent,
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_host = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        output_buffer.get(),
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            image.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            output_buffer.get(),
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[to_host],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let allocation = output_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;
    let result = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const(), 4) };
    if result != [0, 0, 255, 255] {
        return Ok(TestStatus::fail(
            "Unexpected results in color buffer; check log for details --",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

struct TessPatchNonMatchCase {
    name: &'static str,
    reverse: bool,
}

impl TestCase for TessPatchNonMatchCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MISC_TESS_PATCH_NON_MATCH.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TessPatchNonMatchInstance {
            context,
            reverse: self.reverse,
        })
    }
}

struct TessPatchNonMatchInstance<'a> {
    context: &'a Context<'a>,
    reverse: bool,
}

impl TestInstance for TessPatchNonMatchInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_tess_patch_non_match(self.context, self.reverse)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// misc.push_const
// ---------------------------------------------------------------------------------------------------------------------

fn run_push_const(context: &Context<'_>, push_offset: u32, push_count: u32, all_bytes_in_layout: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let extensions = context.get_device_extensions();
    let features = *context.get_device_features();
    let mesh_features = get_mesh_shader_features(context);

    let (r, g, b, a) = (17u32, 49u32, 111u32, 255u32);
    let zero = 0u32.to_ne_bytes();
    let in_color = (a << 24) | (b << 16) | (g << 8) | r;
    let out_color = (r << 24) | (g << 16) | (b << 8) | a;

    let offset = std::mem::size_of::<u32>() as u32 * push_offset;
    let push_range = if all_bytes_in_layout {
        vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: push_count * std::mem::size_of::<u32>() as u32,
        }
    } else {
        vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset,
            size: std::mem::size_of::<u32>() as u32,
        }
    };

    let target = create_color_target_with_format(context, vk::Format::R8G8B8A8_UINT)?;

    let binaries = context.get_binary_collection();
    let make = |stage: vk::ShaderStageFlags, name: &str| {
        make_push_shader(
            device,
            binaries,
            stage,
            name,
            features.tessellation_shader != vk::FALSE,
            features.geometry_shader != vk::FALSE,
            &push_range,
        )
    };
    let vert_shader = make(vk::ShaderStageFlags::VERTEX, "vert")?;
    let frag_shader = make(vk::ShaderStageFlags::FRAGMENT, "frag")?;

    let ranges = [push_range];
    let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&ranges);
    let pipeline_layout = crate::vk::ref_util::Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    unsafe {
        if all_bytes_in_layout {
            for i in 0..push_count {
                device.cmd_push_constants(
                    cmd,
                    pipeline_layout.get(),
                    vk::ShaderStageFlags::FRAGMENT,
                    i * std::mem::size_of::<u32>() as u32,
                    &zero,
                );
            }
        }
        device.cmd_push_constants(
            cmd,
            pipeline_layout.get(),
            vk::ShaderStageFlags::FRAGMENT,
            offset,
            &in_color.to_ne_bytes(),
        );
    }
    let null = vk::ShaderEXT::null();
    bind_graphics_shaders(
        device,
        cmd,
        vert_shader.get(),
        null,
        null,
        null,
        frag_shader.get(),
        mesh_features.task_shader != vk::FALSE,
        mesh_features.mesh_shader != vk::FALSE,
    );

    set_default_shader_object_dynamic_states(
        device,
        cmd,
        extensions,
        vk::PrimitiveTopology::TRIANGLE_STRIP,
        false,
        false,
        RENDER_SIZE,
        RENDER_SIZE,
    );

    begin_rendering(
        device,
        cmd,
        *target.view,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        clear_value([0.0, 0.0, 0.0, 1.0]),
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );
    unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
    end_rendering(device, cmd);

    record_readback(device, cmd, &target, None);
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, target.output_buffer.get_allocation())?;
    let pixels = read_pixels(&target);
    let fail = pixels
        .chunks_exact(4)
        .any(|texel| u32::from_ne_bytes([texel[0], texel[1], texel[2], texel[3]]) != out_color);

    if fail {
        let first = u32::from_ne_bytes([pixels[0], pixels[1], pixels[2], pixels[3]]);
        log::info!("Push constant value mismatch: expected {out_color}, got {first}");
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectPushConstCase {
    name: &'static str,
    push_offset: u32,
    push_count: u32,
    all_bytes_in_layout: bool,
}

impl TestCase for ShaderObjectPushConstCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        context.require_device_functionality("VK_KHR_8bit_storage")
    }

    fn programs(&self) -> BinaryCollection {
        let program = match (self.push_offset, self.push_count, self.all_bytes_in_layout) {
            (57, 64, true) => &MISC_PUSH_CONST_57_64_ALL,
            (63, 64, true) => &MISC_PUSH_CONST_63_64_ALL,
            (17, 64, false) => &MISC_PUSH_CONST_17_64,
            (63, 64, false) => &MISC_PUSH_CONST_63_64,
            (17, 37, true) => &MISC_PUSH_CONST_17_37_ALL,
            (36, 37, true) => &MISC_PUSH_CONST_36_37_ALL,
            (17, 37, false) => &MISC_PUSH_CONST_17_37,
            _ => &MISC_PUSH_CONST_36_37,
        };
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectPushConstInstance {
            context,
            push_offset: self.push_offset,
            push_count: self.push_count,
            all_bytes_in_layout: self.all_bytes_in_layout,
        })
    }
}

struct ShaderObjectPushConstInstance<'a> {
    context: &'a Context<'a>,
    push_offset: u32,
    push_count: u32,
    all_bytes_in_layout: bool,
}

impl TestInstance for ShaderObjectPushConstInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_push_const(
            self.context,
            self.push_offset,
            self.push_count,
            self.all_bytes_in_layout,
        )
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// createShaderObjectMiscTests
// ---------------------------------------------------------------------------------------------------------------------

/// `createShaderObjectMiscTests`
pub fn create_shader_object_misc_tests() -> TestCaseGroup {
    let mut misc_group = TestCaseGroup::new("misc");

    let stride_tests = [(16u32, "16"), (32, "32"), (48, "48"), (40, "40")];

    for i in 0..2 {
        let blend1 = i == 0;
        let mut blend1_group = TestCaseGroup::new(if blend1 { "on" } else { "off" });
        for j in 0..2 {
            let blend2 = j == 0;
            let mut blend2_group = TestCaseGroup::new(if blend2 { "on" } else { "off" });
            for k in 0..2 {
                let vertex_input_before = k == 0;
                let mut vertex_input_before_group =
                    TestCaseGroup::new(if vertex_input_before { "before" } else { "after" });
                for l in 0..2 {
                    let vertex_buffers_null_stride = l == 0;
                    let mut null_stride_group =
                        TestCaseGroup::new(if vertex_buffers_null_stride { "null" } else { "non_null" });
                    for (stride, stride_name) in stride_tests {
                        let mut stride_group = TestCaseGroup::new(stride_name);
                        for m in 0..2 {
                            let destroy_descriptor_set_layout = m == 1;
                            let name = if destroy_descriptor_set_layout {
                                "set"
                            } else {
                                "destroyed"
                            };

                            let params = BlendParams {
                                blend_enabled: [blend1, blend2],
                                vertex_input_before,
                                vertex_buffers_null_stride,
                                stride,
                                destroy_descriptor_set_layout,
                            };
                            stride_group
                                .add_child(Box::new(ShaderObjectMiscCase { name, params }) as Box<dyn TestCase>);
                        }
                        null_stride_group.add_child(stride_group);
                    }
                    vertex_input_before_group.add_child(null_stride_group);
                }
                blend2_group.add_child(vertex_input_before_group);
            }
            blend1_group.add_child(blend2_group);
        }
        misc_group.add_child(blend1_group);
    }

    misc_group.add_child(super::misc_state_tests::create_state_group());

    let shader_stage_tests = [
        (vk::ShaderStageFlags::VERTEX, "vert"),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"),
        (vk::ShaderStageFlags::GEOMETRY, "geom"),
    ];

    let mut unused_variable_group = TestCaseGroup::new("unused_variable");
    for (linked, linked_name) in [(false, "unlinked"), (true, "linked")] {
        let mut linked_group = TestCaseGroup::new(linked_name);
        for (builtin, type_name) in [(false, "output"), (true, "builtin")] {
            let mut type_group = TestCaseGroup::new(type_name);
            for (stage, stage_name) in shader_stage_tests {
                type_group.add_child(Box::new(ShaderObjectUnusedBuiltinCase {
                    name: stage_name,
                    params: UnusedBuiltinParams { linked, stage, builtin },
                }) as Box<dyn TestCase>);
            }
            linked_group.add_child(type_group);
        }
        unused_variable_group.add_child(linked_group);
    }
    misc_group.add_child(unused_variable_group);

    let mut tessellation_modes_group = TestCaseGroup::new("tessellation_modes");
    for (subdivision, subdivision_name) in [(1u32, "one"), (2, "two")] {
        let mut subdivision_group = TestCaseGroup::new(subdivision_name);
        for (spacing, spacing_name) in [
            (TessellationSpacing::Equal, "equal"),
            (TessellationSpacing::Even, "even"),
            (TessellationSpacing::Odd, "odd"),
        ] {
            subdivision_group.add_child(Box::new(ShaderObjectTessellationModesCase {
                name: spacing_name,
                params: TessellationModesParams { subdivision, spacing },
            }) as Box<dyn TestCase>);
        }
        tessellation_modes_group.add_child(subdivision_group);
    }
    misc_group.add_child(tessellation_modes_group);

    let mut tess_patch_non_match_group = TestCaseGroup::new("tess_patch_non_match");
    for (reverse, name) in [(false, "standard"), (true, "reverse")] {
        tess_patch_non_match_group.add_child(Box::new(TessPatchNonMatchCase { name, reverse }) as Box<dyn TestCase>);
    }
    misc_group.add_child(tess_patch_non_match_group);

    let mut push_const_group = TestCaseGroup::new("push_const");
    let push_const_tests = [
        ("57_64_all", 57, 64, true),
        ("63_64_all", 63, 64, true),
        ("17_64", 17, 64, false),
        ("63_64", 63, 64, false),
        ("17_37_all", 17, 37, true),
        ("36_37_all", 36, 37, true),
        ("17_37", 17, 37, false),
        ("36_37", 36, 37, false),
    ];
    for (name, push_offset, push_count, all_bytes_in_layout) in push_const_tests {
        push_const_group.add_child(Box::new(ShaderObjectPushConstCase {
            name,
            push_offset,
            push_count,
            all_bytes_in_layout,
        }) as Box<dyn TestCase>);
    }
    misc_group.add_child(push_const_group);

    misc_group
}

const EQUAL1: [[u8; 17]; 17] = [
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
];

const EVEN1: [[u8; 17]; 17] = [
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1],
    [1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
];

const ODD2: [[u8; 17]; 17] = [
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1],
    [1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1],
    [1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1],
    [1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1],
    [1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1],
    [1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1],
    [1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1],
    [1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
];
