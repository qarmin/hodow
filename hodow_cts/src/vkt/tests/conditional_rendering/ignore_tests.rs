// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalIgnoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `trace_rays*` cases run through
// `vk::ray_tracing_util`. `clear_color_*` runs on the dedicated compute queue when the device has
// one, as upstream's `MultiQueueRunnerTestInstance` does for its compute queues, but only on that one.
//
// Everything here checks that an operation which conditional rendering does not affect (a clear or a copy outside a
// render pass, push constants, binds) happens whatever the condition says.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtConditionalRenderingExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands, InstanceV1_1,
    KhrRayTracingMaintenance1ExtensionDeviceCommands, KhrRayTracingPipelineExtensionDeviceCommands,
};

use crate::generated::shaders::conditional_rendering_ignore::{
    IGNORE_GRAPHICS_BIND, IGNORE_PUSH_CONSTANT, IGNORE_RAY_TRACING,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::pipeline_construction::PipelineConstructionType;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ray_tracing_util::{RayTracingPipelineBuilder, create_shader_binding_table, shader_group_sizes};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::conditional_rendering::test_util::{
    ConditionalData, TESTS_DATA, begin_conditional_rendering, create_conditional_rendering_buffer,
};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{ShaderObjectDraw, begin_draw, end_draw};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const EXTENT: u32 = 2;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const SRC_COLOR_BYTES: [u8; 4] = [0, 0, 255, 255];

/// `commonCheckSupport`
fn common_check_support(context: &Context<'_>, data: &ConditionalData) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_conditional_rendering")?;

    if data.condition_inherited {
        let mut conditional_features = vk::PhysicalDeviceConditionalRenderingFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut conditional_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if conditional_features.inherited_conditional_rendering == vk::FALSE {
            return Err(TestError::NotSupported(
                "Device does not support inherited conditional rendering".to_string(),
            ));
        }
    }

    if data.secondary_command_buffer_nested {
        context.require_device_functionality("VK_EXT_nested_command_buffer")?;
        let mut nested_features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut nested_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if nested_features.nested_command_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "nestedCommandBuffer is not supported".to_string(),
            ));
        }
    }
    Ok(())
}

/// `generalConditionalRenderingCheckSupport`
fn general_check_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_conditional_rendering")
}

/// `GeneralCmdParams::getDisableValue`
fn disable_value(inverted: bool) -> u32 {
    u32::from(inverted)
}

fn cr_flags(inverted: bool) -> vk::ConditionalRenderingFlagsEXT {
    if inverted {
        vk::ConditionalRenderingFlagsEXT::INVERTED
    } else {
        vk::ConditionalRenderingFlagsEXT::empty()
    }
}

/// The conditional rendering buffer of the general tests: one word holding the value that disables the commands.
fn create_cr_buffer<'a>(context: &'a Context<'a>, inverted: bool) -> Result<BufferWithMemory<'a>, TestError> {
    create_host_buffer(
        context,
        &[disable_value(inverted)],
        vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT,
    )
}

fn begin_cr(device: &Device, cmd_buffer: vk::CommandBuffer, cr_buffer: &BufferWithMemory<'_>, inverted: bool) {
    let begin = vk::ConditionalRenderingBeginInfoEXT::builder()
        .buffer(cr_buffer.get())
        .offset(0)
        .flags(cr_flags(inverted));
    unsafe { device.cmd_begin_conditional_rendering_ext(cmd_buffer, &begin) };
}

fn end_cr(device: &Device, cmd_buffer: vk::CommandBuffer) {
    unsafe { device.cmd_end_conditional_rendering_ext(cmd_buffer) };
}

/// `cmdPipelineMemoryBarrier` over `makeMemoryBarrier`
fn memory_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
) {
    let barrier = make_memory_barrier(src_access, dst_access);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };
}

/// Moves images from UNDEFINED to GENERAL for transfer writes.
fn to_general(device: &Device, cmd_buffer: vk::CommandBuffer, images: &[(vk::Image, vk::ImageSubresourceRange)]) {
    let barriers: Vec<vk::ImageMemoryBarrier> = images
        .iter()
        .map(|&(image, range)| {
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                image,
                range,
            )
        })
        .collect();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &barriers,
        );
    }
}

fn create_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: EXTENT,
            height: EXTENT,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

fn create_transfer_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    samples: vk::SampleCountFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    create_image(
        context,
        format,
        samples,
        vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
    )
}

fn create_readback_buffer<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

fn buffer_bytes<'a>(device: &Device, buffer: &'a BufferWithMemory<'_>, size: usize) -> Result<&'a [u8], TestError> {
    invalidate_alloc(device, buffer.get_allocation())?;
    Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), size) })
}

fn color_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn color_layers() -> vk::ImageSubresourceLayers {
    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1)
}

fn extent_3d() -> vk::Extent3D {
    vk::Extent3D {
        width: EXTENT,
        height: EXTENT,
        depth: 1,
    }
}

/// The copy of an image in GENERAL layout to a buffer, with the barriers before it and the one that makes it readable.
fn copy_general_image_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    layers: vk::ImageSubresourceLayers,
) {
    memory_barrier(
        device,
        cmd_buffer,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::TRANSFER,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
    );
    let region = make_buffer_image_copy(extent_3d(), layers);
    unsafe { device.cmd_copy_image_to_buffer(cmd_buffer, image, vk::ImageLayout::GENERAL, buffer, &[region]) };
    memory_barrier(
        device,
        cmd_buffer,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::HOST,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
    );
}

fn expect_src_color(result: &[u8], what: &str) -> TestOutcome {
    let expected: Vec<u8> = std::iter::repeat_n(SRC_COLOR_BYTES, (EXTENT * EXTENT) as usize)
        .flatten()
        .collect();
    if result != expected.as_slice() {
        return Ok(TestStatus::fail(format!(
            "Unexpected results in {what}; expected {expected:?} but found {result:?}"
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------------------------------
// clear_color_<data> and clear_depth_<data>
// ---------------------------------------------------------------------------------------------------------------------

/// `ConditionalIgnoreClearColorTestInstance::queuePass` and `ConditionalIgnoreClearDepthTestInstance::iterate`: the
/// same test over a colour or a depth image.
fn clear_ignore_pass(
    context: &Context<'_>,
    data: &ConditionalData,
    queue: vk::Queue,
    queue_family_index: u32,
    depth: bool,
) -> TestOutcome {
    let device = context.get_device();
    let format = if depth { vk::Format::D16_UNORM } else { COLOR_FORMAT };
    let aspect = if depth {
        vk::ImageAspectFlags::DEPTH
    } else {
        vk::ImageAspectFlags::COLOR
    };
    let range = make_image_subresource_range(aspect, 0, 1, 0, 1);
    let attachment_usage = if depth {
        vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
    } else {
        vk::ImageUsageFlags::COLOR_ATTACHMENT
    };
    let usage = attachment_usage | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

    // create the image, a view of it and a buffer to read the output
    let attachment = create_image(context, format, vk::SampleCountFlags::_1, usage)?;
    let _attachment_view = make_image_view(device, attachment.get(), vk::ImageViewType::_2D, format, range)?;
    let texel_size = if depth { 2 } else { 4 };
    let out_buffer_size = texel_size * (EXTENT * EXTENT) as usize;
    let out_buffer = create_readback_buffer(
        context,
        out_buffer_size as vk::DeviceSize,
        vk::BufferUsageFlags::TRANSFER_DST,
    )?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let command_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let command_buffer2 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
    let command_buffer3 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    let conditional_buffer = create_conditional_rendering_buffer(context, data, queue, queue_family_index)?;
    // prepare command buffers
    let use_secondary_cmd_buffer = data.condition_inherited || data.condition_in_secondary_command_buffer;

    let mut conditional_rendering_inheritance_info = vk::CommandBufferInheritanceConditionalRenderingInfoEXT::builder()
        .conditional_rendering_enable(data.condition_inherited);
    let inheritance_info =
        vk::CommandBufferInheritanceInfo::builder().push_next(&mut conditional_rendering_inheritance_info);
    let command_buffer_begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
        .inheritance_info(&inheritance_info);

    let clear = |cmd: vk::CommandBuffer, wrong: bool| unsafe {
        if depth {
            let value = vk::ClearDepthStencilValue {
                depth: if wrong { 1.0 } else { 0.0 },
                stencil: 0,
            };
            device.cmd_clear_depth_stencil_image(cmd, attachment.get(), vk::ImageLayout::GENERAL, &value, &[range]);
        } else {
            let value = vk::ClearColorValue {
                float32: [if wrong { 1.0 } else { 0.0 }, 0.0, 0.0, 1.0],
            };
            device.cmd_clear_color_image(cmd, attachment.get(), vk::ImageLayout::GENERAL, &value, &[range]);
        }
    };

    begin_command_buffer(device, *command_buffer)?;
    // transition the image
    to_general(device, *command_buffer, &[(attachment.get(), range)]);

    // clear to the incorrect value
    clear(*command_buffer, true);

    memory_barrier(
        device,
        *command_buffer,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::TRANSFER,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_WRITE,
    );

    // do all combinations of clears
    if use_secondary_cmd_buffer {
        if data.secondary_command_buffer_nested {
            unsafe { device.begin_command_buffer(*command_buffer3, &command_buffer_begin_info) }
                .vk_check("vkBeginCommandBuffer")?;
        }

        unsafe { device.begin_command_buffer(*command_buffer2, &command_buffer_begin_info) }
            .vk_check("vkBeginCommandBuffer")?;
        let condition_cmd = if data.condition_in_secondary_command_buffer {
            *command_buffer2
        } else {
            *command_buffer
        };
        begin_conditional_rendering(device, condition_cmd, &conditional_buffer, data);

        // clear to the correct value
        clear(*command_buffer2, false);

        unsafe { device.cmd_end_conditional_rendering_ext(condition_cmd) };

        end_command_buffer(device, *command_buffer2)?;
        if data.secondary_command_buffer_nested {
            unsafe { device.cmd_execute_commands(*command_buffer3, &[*command_buffer2]) };
            end_command_buffer(device, *command_buffer3)?;
            unsafe { device.cmd_execute_commands(*command_buffer, &[*command_buffer3]) };
        } else {
            unsafe { device.cmd_execute_commands(*command_buffer, &[*command_buffer2]) };
        }
    } else {
        begin_conditional_rendering(device, *command_buffer, &conditional_buffer, data);

        // clear to the correct value
        clear(*command_buffer, false);

        unsafe { device.cmd_end_conditional_rendering_ext(*command_buffer) };
    }
    copy_general_image_to_buffer(
        device,
        *command_buffer,
        attachment.get(),
        out_buffer.get(),
        make_image_subresource_layers(aspect, 0, 0, 1),
    );

    end_command_buffer(device, *command_buffer)?;
    submit_commands_and_wait(device, queue, *command_buffer)?;

    let result = buffer_bytes(device, &out_buffer, out_buffer_size)?;

    // the clear should happen in every case
    if depth {
        if result.iter().any(|&byte| byte != 0) {
            return Ok(TestStatus::fail(
                "Depth image verification failed, check log for details",
            ));
        }
    } else if result.chunks_exact(4).any(|pixel| pixel != [0, 0, 0, 255]) {
        return Ok(TestStatus::fail(
            "Color image verification failed, check log for details",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------------------------------
// the general commands
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum GeneralCmd {
    PushConstant,
    UpdateBuffer,
    FillBuffer,
    ResolveImage,
    BlitImage,
    CopyImage,
    CopyImageToBuffer,
    ClearColorImage,
    ClearDepthStencilImage,
    CopyBufferToImage,
    CopyBuffer,
    BindDescriptorSets,
    BindIndexBuffer,
    BindPipeline,
    BindShaders,
    BindVertexBuffers,
    TraceRays,
    TraceRaysIndirect,
    TraceRaysIndirect2,
}

const GENERAL_CMDS: [(GeneralCmd, &str); 19] = [
    (GeneralCmd::PushConstant, "push_constant"),
    (GeneralCmd::UpdateBuffer, "update_buffer"),
    (GeneralCmd::FillBuffer, "fill_buffer"),
    (GeneralCmd::ResolveImage, "resolve_image"),
    (GeneralCmd::BlitImage, "blit_image"),
    (GeneralCmd::CopyImage, "copy_image"),
    (GeneralCmd::CopyImageToBuffer, "copy_image_to_buffer"),
    (GeneralCmd::ClearColorImage, "clear_color_image"),
    (GeneralCmd::ClearDepthStencilImage, "clear_depth_stencil_image"),
    (GeneralCmd::CopyBufferToImage, "copy_buffer_to_image"),
    (GeneralCmd::CopyBuffer, "copy_buffer"),
    (GeneralCmd::BindDescriptorSets, "bind_descriptor_sets"),
    (GeneralCmd::BindIndexBuffer, "bind_index_buffer"),
    (GeneralCmd::BindPipeline, "bind_pipeline"),
    (GeneralCmd::BindShaders, "bind_shaders"),
    (GeneralCmd::BindVertexBuffers, "bind_vertex_buffers"),
    (GeneralCmd::TraceRays, "trace_rays"),
    (GeneralCmd::TraceRaysIndirect, "trace_rays_indirect"),
    (GeneralCmd::TraceRaysIndirect2, "trace_rays_indirect2"),
];

/// `rayTracingCheckSupport`
fn ray_tracing_check_support(context: &Context<'_>, cmd: GeneralCmd) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_ray_tracing_pipeline")?;
    if cmd == GeneralCmd::TraceRaysIndirect2 {
        context.require_device_functionality("VK_KHR_ray_tracing_maintenance1")?;
    }
    let mut features = vk::PhysicalDeviceRayTracingPipelineFeaturesKHR::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if features.ray_tracing_pipeline == vk::FALSE {
        return Err(TestError::NotSupported(
            "rayTracingPipeline feature is not supported".to_string(),
        ));
    }
    Ok(())
}

/// `rayTracingTest`: the ray generation shader writes a 1 whatever the condition says, through the direct and the two indirect trace commands.
fn ray_tracing_test(context: &Context<'_>, inverted: bool, rt_cmd: GeneralCmd) -> TestOutcome {
    let device = context.get_device();
    let desc_type = vk::DescriptorType::STORAGE_BUFFER;
    let shader_stage = vk::ShaderStageFlags::RAYGEN_KHR;
    let bind_point = vk::PipelineBindPoint::RAY_TRACING_KHR;

    // Pipeline.
    let rgen_shader = create_shader_module(device, context.get_binary_collection().get("rgen")?)?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(desc_type, shader_stage)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
    let mut builder = RayTracingPipelineBuilder::new();
    builder.add_shader(shader_stage, *rgen_shader, 0);
    let pipeline = builder.create_pipeline(device, *pipeline_layout)?;

    // Ray generation SBT.
    let (handle_size, base_alignment) = shader_group_sizes(context.get_instance(), context.get_physical_device());
    let (_sbt, rgen_region) = create_shader_binding_table(
        device,
        context.get_default_allocator(),
        *pipeline,
        handle_size,
        base_alignment,
        0,
        1,
    )?;
    let no_region = vk::StridedDeviceAddressRegionKHR {
        device_address: 0,
        stride: 0,
        size: 0,
    };

    // Output buffer, descriptor pool and set.
    let out_buffer = create_host_buffer(context, &[0u32], vk::BufferUsageFlags::STORAGE_BUFFER)?;
    let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
        device,
        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
        1,
    )?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
    let out_buffer_desc_info = make_descriptor_buffer_info(out_buffer.get(), 0, vk::WHOLE_SIZE);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            desc_type,
            &out_buffer_desc_info,
        )
        .update(device);

    // Conditional rendering buffer.
    let cr_buffer = create_cr_buffer(context, inverted)?;

    // Indirect command buffer.
    let indirect_usage = vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
    let indirect_buffer = match rt_cmd {
        GeneralCmd::TraceRaysIndirect => Some(create_host_buffer(context, &[1u32, 1, 1], indirect_usage)?),
        GeneralCmd::TraceRaysIndirect2 => {
            // VkTraceRaysIndirectCommand2KHR: the three regions without the stride of the ray generation one, then the dimensions, padded to 8 bytes.
            let mut data: Vec<u8> = Vec::with_capacity(104);
            for value in [
                rgen_region.device_address,
                rgen_region.size,
                no_region.device_address,
                no_region.size,
                no_region.stride,
                no_region.device_address,
                no_region.size,
                no_region.stride,
                no_region.device_address,
                no_region.size,
                no_region.stride,
            ] {
                data.extend(value.to_ne_bytes());
            }
            for value in [1u32, 1, 1] {
                data.extend(value.to_ne_bytes());
            }
            data.extend([0u8; 4]);
            Some(create_host_buffer(context, &data, indirect_usage)?)
        }
        _ => None,
    };
    let indirect_address = indirect_buffer
        .as_ref()
        .map_or(0, |buffer| buffer_device_address(device, buffer.get()));

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            bind_point,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(cmd, bind_point, pipeline.get());
    }
    begin_cr(device, cmd, &cr_buffer, inverted);
    unsafe {
        match rt_cmd {
            GeneralCmd::TraceRays => {
                device.cmd_trace_rays_khr(cmd, &rgen_region, &no_region, &no_region, &no_region, 1, 1, 1)
            }
            GeneralCmd::TraceRaysIndirect => device.cmd_trace_rays_indirect_khr(
                cmd,
                &rgen_region,
                &no_region,
                &no_region,
                &no_region,
                indirect_address,
            ),
            _ => device.cmd_trace_rays_indirect2_khr(cmd, indirect_address),
        }
    }
    end_cr(device, cmd);
    memory_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::RAY_TRACING_SHADER_KHR,
        vk::PipelineStageFlags::HOST,
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    let bytes = buffer_bytes(device, &out_buffer, std::mem::size_of::<u32>())?;
    let result = u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]);
    if result != 1 {
        return Ok(TestStatus::fail(format!(
            "Unexpected result found in output buffer: expected 1 but found {result}"
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `pushConstantTest`
fn push_constant_test(context: &Context<'_>, inverted: bool) -> TestOutcome {
    let device = context.get_device();
    let shader_stage = vk::ShaderStageFlags::COMPUTE;
    let bind_point = vk::PipelineBindPoint::COMPUTE;

    let out_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
    let out_buffer = create_host_buffer(context, &[0u32], vk::BufferUsageFlags::STORAGE_BUFFER)?;
    let cr_buffer = create_cr_buffer(context, inverted)?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, shader_stage)
        .build(device)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

    let out_buffer_desc_info = make_descriptor_buffer_info(out_buffer.get(), 0, vk::WHOLE_SIZE);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &out_buffer_desc_info,
        )
        .update(device);

    let pc_size = 2 * std::mem::size_of::<u32>() as u32;
    let pc_range = [vk::PushConstantRange {
        stage_flags: shader_stage,
        offset: 0,
        size: pc_size,
    }];
    let set_layouts = [*set_layout];
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&pc_range);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let comp_shader = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(shader_stage)
        .module(*comp_shader)
        .name(b"main\0")
        .build();
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    let pipeline = Unique::new(device, pipelines.0[0]);

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let initial_values: [u32; 2] = [3, 7]; // Start with different values.
    let initial_bytes: Vec<u8> = initial_values.iter().flat_map(|v| v.to_ne_bytes()).collect();
    unsafe { device.cmd_push_constants(cmd, *pipeline_layout, shader_stage, 0, &initial_bytes) };
    begin_cr(device, cmd, &cr_buffer, inverted);
    // Overwrite second value so it's the same as the first one.
    unsafe {
        device.cmd_push_constants(
            cmd,
            *pipeline_layout,
            shader_stage,
            std::mem::size_of::<u32>() as u32,
            &initial_values[0].to_ne_bytes(),
        )
    };
    end_cr(device, cmd);
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            bind_point,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
        device.cmd_dispatch(cmd, 1, 1, 1);
    }
    // Sync host reads.
    memory_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        vk::PipelineStageFlags::HOST,
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // Make sure the output buffer contains a 1.
    let bytes = buffer_bytes(device, &out_buffer, out_buffer_size as usize)?;
    let result = u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]);
    if result != 1 {
        return Ok(TestStatus::fail(format!(
            "Unexpected value in output buffer: expected 1 but found {result}"
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `updateBufferTest` and `fillBufferTest`
fn update_or_fill_buffer_test(context: &Context<'_>, inverted: bool, fill: bool) -> TestOutcome {
    let device = context.get_device();
    let initial_values: [u32; 2] = [3, 7];
    let buffer = create_host_buffer(context, &initial_values, vk::BufferUsageFlags::TRANSFER_DST)?;
    let cr_buffer = create_cr_buffer(context, inverted)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    begin_cr(device, cmd, &cr_buffer, inverted);
    // Overwrite second value so it's the same as the first one.
    let uint_size = std::mem::size_of::<u32>() as vk::DeviceSize;
    unsafe {
        if fill {
            device.cmd_fill_buffer(cmd, buffer.get(), uint_size, uint_size, initial_values[0]);
        } else {
            device.cmd_update_buffer(cmd, buffer.get(), uint_size, &initial_values[0].to_ne_bytes());
        }
    }
    end_cr(device, cmd);
    // Sync host reads.
    memory_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        vk::PipelineStageFlags::HOST,
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // Make sure the output buffer contains two equal values.
    let bytes = buffer_bytes(device, &buffer, 8)?;
    let result = [
        u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]),
        u32::from_ne_bytes([bytes[4], bytes[5], bytes[6], bytes[7]]),
    ];
    let expected = [initial_values[0], initial_values[0]];
    if result != expected {
        return Ok(TestStatus::fail(format!(
            "Unexpected value in output buffer: expected {expected:?} but found {result:?}"
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ImageToImageOp {
    Resolve,
    Blit,
    Copy,
}

/// `resolveImageTest`, `blitImageTest` and `copyImageTest`
fn image_to_image_test(context: &Context<'_>, inverted: bool, op: ImageToImageOp) -> TestOutcome {
    let device = context.get_device();
    let color_srr = color_range();
    let color_srl = color_layers();
    let src_color = [0.0f32, 0.0, 1.0, 1.0];
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];

    let src_samples = if op == ImageToImageOp::Resolve {
        vk::SampleCountFlags::_4
    } else {
        vk::SampleCountFlags::_1
    };
    let src_image = create_transfer_image(context, COLOR_FORMAT, src_samples)?;
    let dst_image = create_transfer_image(context, COLOR_FORMAT, vk::SampleCountFlags::_1)?;

    let buffer_size = (EXTENT * EXTENT * 4) as usize;
    let buffer = create_readback_buffer(
        context,
        buffer_size as vk::DeviceSize,
        vk::BufferUsageFlags::TRANSFER_DST,
    )?;
    let cr_buffer = create_cr_buffer(context, inverted)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    // Move both images to the general layout.
    to_general(
        device,
        cmd,
        &[(src_image.get(), color_srr), (dst_image.get(), color_srr)],
    );

    // Clear source image with the src color and the destination image with the clear color.
    unsafe {
        device.cmd_clear_color_image(
            cmd,
            src_image.get(),
            vk::ImageLayout::GENERAL,
            &vk::ClearColorValue { float32: src_color },
            &[color_srr],
        );
        device.cmd_clear_color_image(
            cmd,
            dst_image.get(),
            vk::ImageLayout::GENERAL,
            &vk::ClearColorValue { float32: clear_color },
            &[color_srr],
        );
    }

    begin_cr(device, cmd, &cr_buffer, inverted);
    {
        // Wait for the clear.
        memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE,
        );

        let offset = vk::Offset3D { x: 0, y: 0, z: 0 };
        unsafe {
            match op {
                ImageToImageOp::Resolve => {
                    let region = vk::ImageResolve {
                        src_subresource: color_srl,
                        src_offset: offset,
                        dst_subresource: color_srl,
                        dst_offset: offset,
                        extent: extent_3d(),
                    };
                    device.cmd_resolve_image(
                        cmd,
                        src_image.get(),
                        vk::ImageLayout::GENERAL,
                        dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &[region],
                    );
                }
                ImageToImageOp::Blit => {
                    let blit_offsets = [
                        offset,
                        vk::Offset3D {
                            x: EXTENT as i32,
                            y: EXTENT as i32,
                            z: 1,
                        },
                    ];
                    let region = vk::ImageBlit {
                        src_subresource: color_srl,
                        src_offsets: blit_offsets,
                        dst_subresource: color_srl,
                        dst_offsets: blit_offsets,
                    };
                    device.cmd_blit_image(
                        cmd,
                        src_image.get(),
                        vk::ImageLayout::GENERAL,
                        dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &[region],
                        vk::Filter::NEAREST,
                    );
                }
                ImageToImageOp::Copy => {
                    let region = vk::ImageCopy {
                        src_subresource: color_srl,
                        src_offset: offset,
                        dst_subresource: color_srl,
                        dst_offset: offset,
                        extent: extent_3d(),
                    };
                    device.cmd_copy_image(
                        cmd,
                        src_image.get(),
                        vk::ImageLayout::GENERAL,
                        dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &[region],
                    );
                }
            }
        }
    }
    end_cr(device, cmd);

    // Copy dst image to the buffer.
    copy_general_image_to_buffer(device, cmd, dst_image.get(), buffer.get(), color_srl);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    expect_src_color(buffer_bytes(device, &buffer, buffer_size)?, "output buffer")
}

/// `copyImageToBufferTest`, `clearColorImageTest` and `clearDepthStencilImageTest`: the operation under the condition is
/// the one named, the rest is setup and readback.
fn single_image_test(context: &Context<'_>, inverted: bool, cmd_kind: GeneralCmd) -> TestOutcome {
    let device = context.get_device();
    let depth = cmd_kind == GeneralCmd::ClearDepthStencilImage;
    let format = if depth { vk::Format::D16_UNORM } else { COLOR_FORMAT };
    let aspect = if depth {
        vk::ImageAspectFlags::DEPTH
    } else {
        vk::ImageAspectFlags::COLOR
    };
    let srr = make_image_subresource_range(aspect, 0, 1, 0, 1);
    let srl = make_image_subresource_layers(aspect, 0, 0, 1);
    let src_color = [0.0f32, 0.0, 1.0, 1.0];

    let src_image = create_transfer_image(context, format, vk::SampleCountFlags::_1)?;
    let buffer_size = (EXTENT * EXTENT) as usize * if depth { 2 } else { 4 };
    let buffer = create_readback_buffer(
        context,
        buffer_size as vk::DeviceSize,
        vk::BufferUsageFlags::TRANSFER_DST,
    )?;
    let cr_buffer = create_cr_buffer(context, inverted)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    // Move image to the general layout.
    to_general(device, cmd, &[(src_image.get(), srr)]);

    if cmd_kind == GeneralCmd::ClearColorImage {
        begin_cr(device, cmd, &cr_buffer, inverted);
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                src_image.get(),
                vk::ImageLayout::GENERAL,
                &vk::ClearColorValue { float32: src_color },
                &[srr],
            )
        };
        end_cr(device, cmd);
    } else if cmd_kind == GeneralCmd::ClearDepthStencilImage {
        begin_cr(device, cmd, &cr_buffer, inverted);
        let value = vk::ClearDepthStencilValue { depth: 1.0, stencil: 1 };
        unsafe { device.cmd_clear_depth_stencil_image(cmd, src_image.get(), vk::ImageLayout::GENERAL, &value, &[srr]) };
        end_cr(device, cmd);
    } else {
        // Clear src image with the src color.
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                src_image.get(),
                vk::ImageLayout::GENERAL,
                &vk::ClearColorValue { float32: src_color },
                &[srr],
            )
        };
    }

    // Copy the image to the buffer, with the condition active around the copy for `copy_image_to_buffer`.
    memory_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::TRANSFER,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
    );
    let region = make_buffer_image_copy(extent_3d(), srl);
    if cmd_kind == GeneralCmd::CopyImageToBuffer {
        begin_cr(device, cmd, &cr_buffer, inverted);
    }
    unsafe { device.cmd_copy_image_to_buffer(cmd, src_image.get(), vk::ImageLayout::GENERAL, buffer.get(), &[region]) };
    if cmd_kind == GeneralCmd::CopyImageToBuffer {
        end_cr(device, cmd);
    }
    memory_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::HOST,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
    );

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    let result = buffer_bytes(device, &buffer, buffer_size)?;
    if depth {
        // `tcu::dsThresholdCompare` with a threshold of 1.0, which every pair of depth values within [0, 1] satisfies.
        for texel in result.chunks_exact(2) {
            let value = u16::from_ne_bytes([texel[0], texel[1]]) as f32 / 65535.0;
            if (value - 1.0).abs() > 1.0 {
                return Ok(TestStatus::fail(
                    "Unexpected results in output buffer; check log for details --",
                ));
            }
        }
        return Ok(TestStatus::pass("Pass"));
    }
    expect_src_color(result, "output buffer")
}

/// `copyBufferToImageTest` and `copyBufferTest`
fn buffer_copy_test(context: &Context<'_>, inverted: bool, to_image: bool) -> TestOutcome {
    let device = context.get_device();
    let buffer_size = (EXTENT * EXTENT * 4) as usize;
    let src_pixels: Vec<u8> = std::iter::repeat_n(SRC_COLOR_BYTES, (EXTENT * EXTENT) as usize)
        .flatten()
        .collect();

    let src_buffer = create_host_buffer(
        context,
        &src_pixels,
        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
    )?;
    let dst_buffer = create_readback_buffer(
        context,
        buffer_size as vk::DeviceSize,
        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
    )?;
    let cr_buffer = create_cr_buffer(context, inverted)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    if to_image {
        let src_image = create_transfer_image(context, COLOR_FORMAT, vk::SampleCountFlags::_1)?;
        let color_srr = color_range();

        // Move image to the general layout.
        to_general(device, cmd, &[(src_image.get(), color_srr)]);

        // Copy buffer to image.
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: color_layers(),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: extent_3d(),
        };
        begin_cr(device, cmd, &cr_buffer, inverted);
        unsafe {
            device.cmd_copy_buffer_to_image(
                cmd,
                src_buffer.get(),
                src_image.get(),
                vk::ImageLayout::GENERAL,
                &[region],
            )
        };
        end_cr(device, cmd);

        // Copy dst image to the buffer.
        copy_general_image_to_buffer(device, cmd, src_image.get(), dst_buffer.get(), color_layers());

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    } else {
        // Copy buffers.
        let region = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: buffer_size as vk::DeviceSize,
        };
        begin_cr(device, cmd, &cr_buffer, inverted);
        unsafe { device.cmd_copy_buffer(cmd, src_buffer.get(), dst_buffer.get(), &[region]) };
        end_cr(device, cmd);

        // Sync with host reads.
        memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    }

    expect_src_color(buffer_bytes(device, &dst_buffer, buffer_size)?, "output buffer")
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum GraphicsBindType {
    DescriptorSets,
    IndexBuffer,
    Pipeline,
    Shaders,
    VertexBuffer,
}

/// `graphicsBindTest`
fn graphics_bind_test<'a>(context: &'a Context<'a>, inverted: bool, bind_type: GraphicsBindType) -> TestOutcome {
    let device = context.get_device();

    // Color buffers.
    let good_colors: [[f32; 4]; 2] = [[0.0, 0.0, 1.0, 1.0], [0.0, 1.0, 1.0, 1.0]];
    let bad_colors: [[f32; 4]; 2] = [[1.0, 0.0, 1.0, 1.0], [1.0, 1.0, 1.0, 1.0]];
    let colors_buffer_size = std::mem::size_of_val(&good_colors) as vk::DeviceSize;
    let good_colors_buffer = create_host_buffer(context, &good_colors, vk::BufferUsageFlags::STORAGE_BUFFER)?;
    let bad_colors_buffer = create_host_buffer(context, &bad_colors, vk::BufferUsageFlags::STORAGE_BUFFER)?;

    // Vertex buffers.
    let good_vertices: [[f32; 4]; 4] = [
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ];
    let bad_vertices = [[0.0f32, 0.0, 0.0, 1.0]; 4];
    let good_vertex_buffer = create_host_buffer(context, &good_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    let bad_vertex_buffer = create_host_buffer(context, &bad_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Index buffers.
    let bad_indices = [0u32; 4];
    let good_indices: [u32; 4] = [0, 1, 2, 3];
    let good_index_buffer = create_host_buffer(context, &good_indices, vk::BufferUsageFlags::INDEX_BUFFER)?;
    let bad_index_buffer = create_host_buffer(context, &bad_indices, vk::BufferUsageFlags::INDEX_BUFFER)?;

    // Shaders.
    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shaders = [
        create_shader_module(device, binaries.get("frag0")?)?,
        create_shader_module(device, binaries.get("frag1")?)?,
    ];

    // Descriptors.
    let desc_type = vk::DescriptorType::STORAGE_BUFFER;
    let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 2).build(
        device,
        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
        2,
    )?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(desc_type, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
    let good_descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
    let bad_descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

    let good_desc_buffer_info = make_descriptor_buffer_info(good_colors_buffer.get(), 0, colors_buffer_size);
    let bad_desc_buffer_info = make_descriptor_buffer_info(bad_colors_buffer.get(), 0, colors_buffer_size);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            good_descriptor_set.get(),
            Location::binding(0),
            desc_type,
            &good_desc_buffer_info,
        )
        .write_single(
            bad_descriptor_set.get(),
            Location::binding(0),
            desc_type,
            &bad_desc_buffer_info,
        )
        .update(device);

    // Render pass and framebuffer.
    let attachment = ImageWithBuffer::new(
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
    let framebuffer = make_framebuffer(device, *render_pass, &[*attachment.view], EXTENT, EXTENT, 1)?;

    // Pipelines.
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .with_position_input()
        .with_full_viewport(EXTENT, EXTENT);
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0)
        .build();
    let shader_objects: Vec<ShaderObjectDraw<'_>> = if bind_type == GraphicsBindType::Shaders {
        let binaries = context.get_binary_collection();
        let mut objects = Vec::new();
        for frag_name in ["frag0", "frag1"] {
            objects.push(ShaderObjectDraw::new(
                context,
                PipelineConstructionType::ShaderObjectUnlinkedSpirv,
                binaries.get("vert")?,
                Some(binaries.get(frag_name)?),
                &[*set_layout],
                &[],
            )?);
        }
        objects
    } else {
        Vec::new()
    };
    let mut pipelines = Vec::new();
    for frag_shader in frag_shaders.iter().filter(|_| bind_type != GraphicsBindType::Shaders) {
        pipelines.push(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, **frag_shader),
            ],
            &state,
        )?);
    }

    // Conditional rendering buffer.
    let cr_buffer = create_cr_buffer(context, inverted)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let bind_point = vk::PipelineBindPoint::GRAPHICS;

    begin_command_buffer(device, cmd)?;
    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
    if bind_type == GraphicsBindType::Shaders {
        begin_draw(
            device,
            cmd,
            Some(&shader_objects[0]),
            &state,
            None,
            *render_pass,
            *framebuffer,
            rect_2d(EXTENT, EXTENT),
            &clear_values,
            &[(attachment.image.get(), *attachment.view)],
        );
    } else {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(EXTENT, EXTENT))
            .clear_values(&clear_values);
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
    }

    // Fixed block.
    unsafe {
        let initial_set = if bind_type == GraphicsBindType::DescriptorSets {
            bad_descriptor_set.get()
        } else {
            good_descriptor_set.get()
        };
        device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &[initial_set], &[] as &[u32]);

        let initial_index_buffer = if bind_type == GraphicsBindType::IndexBuffer {
            bad_index_buffer.get()
        } else {
            good_index_buffer.get()
        };
        device.cmd_bind_index_buffer(cmd, initial_index_buffer, 0, vk::IndexType::UINT32);

        let initial_vertex_buffer = if bind_type == GraphicsBindType::VertexBuffer {
            bad_vertex_buffer.get()
        } else {
            good_vertex_buffer.get()
        };
        device.cmd_bind_vertex_buffers(cmd, 0, &[initial_vertex_buffer], &[0]);

        if bind_type != GraphicsBindType::Shaders {
            device.cmd_bind_pipeline(cmd, bind_point, pipelines[0].get());
        }
    }

    // Conditional rendering block.
    begin_cr(device, cmd, &cr_buffer, inverted);
    unsafe {
        match bind_type {
            GraphicsBindType::DescriptorSets => device.cmd_bind_descriptor_sets(
                cmd,
                bind_point,
                *pipeline_layout,
                0,
                &[good_descriptor_set.get()],
                &[] as &[u32],
            ),
            GraphicsBindType::IndexBuffer => {
                device.cmd_bind_index_buffer(cmd, good_index_buffer.get(), 0, vk::IndexType::UINT32)
            }
            GraphicsBindType::Pipeline => device.cmd_bind_pipeline(cmd, bind_point, pipelines[1].get()),
            GraphicsBindType::Shaders => device.cmd_bind_shaders_ext(
                cmd,
                &[vk::ShaderStageFlags::FRAGMENT],
                &[shader_objects[1].fragment_handle()],
            ),
            GraphicsBindType::VertexBuffer => device.cmd_bind_vertex_buffers(cmd, 0, &[good_vertex_buffer.get()], &[0]),
        }
    }
    end_cr(device, cmd);

    // Draw, finish and copy image.
    unsafe {
        device.cmd_draw(cmd, good_vertices.len() as u32, 1, 0, 0);
    }
    end_draw(device, cmd, bind_type == GraphicsBindType::Shaders);
    copy_image_to_buffer(
        device,
        cmd,
        attachment.image.get(),
        attachment.buffer.get(),
        EXTENT,
        EXTENT,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    let frag_shader_switch = matches!(bind_type, GraphicsBindType::Pipeline | GraphicsBindType::Shaders);
    let expected_color = if frag_shader_switch {
        good_colors[1]
    } else {
        good_colors[0]
    };
    let expected: Vec<u8> = std::iter::repeat_n(
        expected_color.map(|c| (c * 255.0).round() as u8),
        (EXTENT * EXTENT) as usize,
    )
    .flatten()
    .collect();

    let result = attachment.read_bytes(device)?;
    if result != expected.as_slice() {
        return Ok(TestStatus::fail(format!(
            "Unexpected results in color buffer; expected {expected:?} but found {result:?}"
        )));
    }
    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------------------------------
// the cases
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
enum IgnoreKind {
    ClearColor(ConditionalData),
    ClearDepth(ConditionalData),
    General(GeneralCmd, bool),
}

struct IgnoreCase {
    name: String,
    kind: IgnoreKind,
}

impl TestCase for IgnoreCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match &self.kind {
            IgnoreKind::ClearColor(data) | IgnoreKind::ClearDepth(data) => common_check_support(context, data),
            IgnoreKind::General(cmd, _) => {
                general_check_support(context)?;
                if *cmd == GeneralCmd::BindShaders {
                    context.require_device_functionality("VK_EXT_shader_object")?;
                }
                if matches!(
                    cmd,
                    GeneralCmd::TraceRays | GeneralCmd::TraceRaysIndirect | GeneralCmd::TraceRaysIndirect2
                ) {
                    ray_tracing_check_support(context, *cmd)?;
                }
                Ok(())
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            IgnoreKind::General(GeneralCmd::PushConstant, _) => IGNORE_PUSH_CONSTANT.programs,
            IgnoreKind::General(
                GeneralCmd::BindDescriptorSets
                | GeneralCmd::BindIndexBuffer
                | GeneralCmd::BindPipeline
                | GeneralCmd::BindShaders
                | GeneralCmd::BindVertexBuffers,
                _,
            ) => IGNORE_GRAPHICS_BIND.programs,
            IgnoreKind::General(
                GeneralCmd::TraceRays | GeneralCmd::TraceRaysIndirect | GeneralCmd::TraceRaysIndirect2,
                _,
            ) => IGNORE_RAY_TRACING.programs,
            _ => NO_PROGRAMS,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IgnoreInstance {
            context,
            kind: self.kind,
        })
    }
}

struct IgnoreInstance<'a> {
    context: &'a Context<'a>,
    kind: IgnoreKind,
}

impl TestInstance for IgnoreInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        match self.kind {
            IgnoreKind::ClearColor(data) => {
                // `MultiQueueRunnerTestInstance` with `COMPUTE_QUEUE`
                let (queue, family_index) = context.get_compute_queue().unwrap_or((
                    context.get_universal_queue(),
                    context.get_universal_queue_family_index(),
                ));
                clear_ignore_pass(context, &data, queue, family_index, false)
            }
            IgnoreKind::ClearDepth(data) => clear_ignore_pass(
                context,
                &data,
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
                true,
            ),
            IgnoreKind::General(cmd, inverted) => match cmd {
                GeneralCmd::PushConstant => push_constant_test(context, inverted),
                GeneralCmd::UpdateBuffer => update_or_fill_buffer_test(context, inverted, false),
                GeneralCmd::FillBuffer => update_or_fill_buffer_test(context, inverted, true),
                GeneralCmd::ResolveImage => image_to_image_test(context, inverted, ImageToImageOp::Resolve),
                GeneralCmd::BlitImage => image_to_image_test(context, inverted, ImageToImageOp::Blit),
                GeneralCmd::CopyImage => image_to_image_test(context, inverted, ImageToImageOp::Copy),
                GeneralCmd::CopyImageToBuffer | GeneralCmd::ClearColorImage | GeneralCmd::ClearDepthStencilImage => {
                    single_image_test(context, inverted, cmd)
                }
                GeneralCmd::CopyBufferToImage => buffer_copy_test(context, inverted, true),
                GeneralCmd::CopyBuffer => buffer_copy_test(context, inverted, false),
                GeneralCmd::BindDescriptorSets => {
                    graphics_bind_test(context, inverted, GraphicsBindType::DescriptorSets)
                }
                GeneralCmd::BindIndexBuffer => graphics_bind_test(context, inverted, GraphicsBindType::IndexBuffer),
                GeneralCmd::BindPipeline => graphics_bind_test(context, inverted, GraphicsBindType::Pipeline),
                GeneralCmd::BindShaders => graphics_bind_test(context, inverted, GraphicsBindType::Shaders),
                GeneralCmd::BindVertexBuffers => graphics_bind_test(context, inverted, GraphicsBindType::VertexBuffer),
                GeneralCmd::TraceRays | GeneralCmd::TraceRaysIndirect | GeneralCmd::TraceRaysIndirect2 => {
                    ray_tracing_test(context, inverted, cmd)
                }
            },
        }
    }
}

/// `ConditionalIgnoreTests::init`
pub fn create_conditional_ignore_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("conditional_ignore");

    for condition_data in TESTS_DATA.iter() {
        if condition_data.clear_in_render_pass {
            continue;
        }

        // tests that some clear operations always happen
        group.add_child(Box::new(IgnoreCase {
            name: format!("clear_color_{}", condition_data.to_name()),
            kind: IgnoreKind::ClearColor(*condition_data),
        }) as Box<dyn TestCase>);

        // tests that some clear operations always happen
        group.add_child(Box::new(IgnoreCase {
            name: format!("clear_depth_{}", condition_data.to_name()),
            kind: IgnoreKind::ClearDepth(*condition_data),
        }) as Box<dyn TestCase>);
    }

    for inverted in [false, true] {
        let suffix = if inverted { "_inverted" } else { "" };
        for (cmd, name) in GENERAL_CMDS {
            group.add_child(Box::new(IgnoreCase {
                name: format!("{name}{suffix}"),
                kind: IgnoreKind::General(cmd, inverted),
            }) as Box<dyn TestCase>);
        }
    }

    group
}
