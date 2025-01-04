// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalDrawAndClearTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `_device_address` draw cases (`VK_KHR_device_address_commands`,
// `vkCmdBeginConditionalRendering2EXT`) call the command through `vk::device_address_commands`. The class
// hierarchy of upstream becomes plain helper functions, and the reference images are compared as bytes/floats rather
// than through `tcu::floatThresholdCompare`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtConditionalRenderingExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::conditional_rendering_draw_clear::{
    DRAW_CLEAR_DRAW, DRAW_CLEAR_UPDATE_DISCARD, DRAW_CLEAR_UPDATE_NO_DISCARD,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::device_address_commands::{
    self, ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE, ConditionalRenderingBeginInfo2, DeviceAddressRange,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 256;
const HEIGHT: u32 = 256;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D32_SFLOAT;
const FLOAT_THRESHOLD: f32 = 0.01;
const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `ConditionalBufferMemory`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ConditionalBufferMemory {
    Local,
    Host,
}

/// `ClearTestParams`
#[derive(Clone, Copy)]
struct ClearTestParams {
    discard: bool,
    invert: bool,
    test_depth: bool,
    partial_clear: bool,
    use_offset: bool,
    clear_attachment_twice: bool,
    memory_type: ConditionalBufferMemory,
}

/// `TogglePredicateMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TogglePredicateMode {
    Fill,
    Copy,
    None,
}

/// `DrawTestParams`
#[derive(Clone, Copy)]
struct DrawTestParams {
    /// Controls the setting of the predicate for conditional rendering. Initial state, may be toggled later depending
    /// on the `toggle_predicate` setting.
    discard: bool,
    invert: bool,
    use_offset: bool,
    use_maintenance5: bool,
    /// `m_useDeviceAddressCommands`: the conditional rendering starts with `vkCmdBeginConditionalRendering2EXT`.
    use_device_address_commands: bool,
    /// Bits 0..3 control BEFORE which of the 4 draw calls the vkCmdBeginConditionalRenderingEXT call is executed. Least
    /// significant bit corresponds to the first draw call.
    begin_sequence_bits: u32,
    /// Bits 0..3 control AFTER which of the 4 draw calls the vkCmdEndConditionalRenderingEXT call is executed.
    end_sequence_bits: u32,
    /// Used for reference image preparation.
    result_bits: u32,
    /// If true, toggle the predicate setting before rendering.
    toggle_predicate: bool,
    /// Method of the predicate toggling
    toggle_mode: TogglePredicateMode,
    /// Type of memory used for conditional rendering buffer
    memory_type: ConditionalBufferMemory,
}

/// `UpdateBufferWithDrawTestParams`
#[derive(Clone, Copy)]
struct UpdateBufferWithDrawTestParams {
    test_params: bool,
    memory_type: ConditionalBufferMemory,
}

/// `clearColorTestGrid` and `clearDepthTestGrid`: per memory type, the discard/invert combinations over (partial, offset).
fn clear_test_grid(test_depth: bool) -> Vec<ClearTestParams> {
    let mut grid = Vec::new();
    for memory_type in [ConditionalBufferMemory::Host, ConditionalBufferMemory::Local] {
        for (partial_clear, use_offset) in [(false, false), (true, false), (true, true)] {
            for (discard, invert) in [(false, false), (true, false), (false, true), (true, true)] {
                grid.push(ClearTestParams {
                    discard,
                    invert,
                    test_depth,
                    partial_clear,
                    use_offset,
                    clear_attachment_twice: false,
                    memory_type,
                });
            }
        }
        if !test_depth {
            grid.push(ClearTestParams {
                discard: true,
                invert: true,
                test_depth,
                partial_clear: false,
                use_offset: true,
                clear_attachment_twice: false,
                memory_type,
            });
        }
    }
    grid
}

/// `clearColorTwiceGrid` and `clearDepthTwiceGrid`
fn clear_twice_grid(test_depth: bool) -> Vec<ClearTestParams> {
    let mut grid = Vec::new();
    for memory_type in [ConditionalBufferMemory::Host, ConditionalBufferMemory::Local] {
        for (discard, invert) in [(false, false), (true, false), (false, true), (true, true)] {
            grid.push(ClearTestParams {
                discard,
                invert,
                test_depth,
                partial_clear: false,
                use_offset: false,
                clear_attachment_twice: true,
                memory_type,
            });
        }
        for discard in [false, true] {
            grid.push(ClearTestParams {
                discard,
                invert: true,
                test_depth,
                partial_clear: true,
                use_offset: true,
                clear_attachment_twice: true,
                memory_type,
            });
        }
    }
    grid
}

/// `drawTestGrid`
fn draw_test_grid() -> Vec<DrawTestParams> {
    use TogglePredicateMode::{Copy, Fill, None};

    // discard, invert, use_offset, begin bits, end bits, result bits, toggle, mode
    let entries: [(bool, bool, bool, u32, u32, u32, bool, TogglePredicateMode); 15] = [
        (false, false, false, 0b0001, 0b1000, 0b1111, false, None),
        (true, false, false, 0b0001, 0b1000, 0b0000, false, None),
        (true, false, false, 0b0001, 0b0001, 0b1110, false, None),
        (true, false, false, 0b1111, 0b1111, 0b0000, false, None),
        (true, false, false, 0b0010, 0b0010, 0b1101, false, None),
        (true, true, false, 0b1010, 0b1010, 0b0101, false, None),
        (false, true, true, 0b1010, 0b1010, 0b1111, false, None),
        (true, true, true, 0b0010, 0b1000, 0b0001, false, None),
        (true, true, true, 0b1001, 0b1001, 0b0110, false, None),
        (true, true, true, 0b0010, 0b1000, 0b1111, true, Fill),
        (true, true, true, 0b1001, 0b1001, 0b1111, true, Fill),
        (false, true, true, 0b1001, 0b1001, 0b0110, true, Fill),
        (true, true, true, 0b0010, 0b1000, 0b1111, true, Copy),
        (true, true, true, 0b1001, 0b1001, 0b1111, true, Copy),
        (false, true, true, 0b1001, 0b1001, 0b0110, true, Copy),
    ];

    let mut grid = Vec::new();
    for memory_type in [ConditionalBufferMemory::Host, ConditionalBufferMemory::Local] {
        for &(
            discard,
            invert,
            use_offset,
            begin_sequence_bits,
            end_sequence_bits,
            result_bits,
            toggle_predicate,
            toggle_mode,
        ) in &entries
        {
            grid.push(DrawTestParams {
                discard,
                invert,
                use_offset,
                use_maintenance5: false,
                use_device_address_commands: false,
                begin_sequence_bits,
                end_sequence_bits,
                result_bits,
                toggle_predicate,
                toggle_mode,
                memory_type,
            });
        }
    }
    grid
}

fn memory_name(memory_type: ConditionalBufferMemory) -> &'static str {
    if memory_type == ConditionalBufferMemory::Host {
        "host_memory"
    } else {
        "local_memory"
    }
}

/// `generateClearTestName`
fn generate_clear_test_name(params: &ClearTestParams) -> String {
    let mut name = if params.discard { "discard_" } else { "no_discard_" }.to_string();
    name += if params.invert { "invert_" } else { "no_invert_" };
    name += if params.partial_clear { "partial_" } else { "full_" };
    name += if params.use_offset { "offset_" } else { "no_offset_" };
    name += memory_name(params.memory_type);
    name
}

/// `generateDrawTestName`
fn generate_draw_test_name(ndx: usize, params: &DrawTestParams) -> String {
    format!("case_{ndx}_{}", memory_name(params.memory_type))
}

/// `generateUpdateBufferWithDrawTestName`
fn generate_update_buffer_with_draw_test_name(params: &UpdateBufferWithDrawTestParams) -> String {
    format!(
        "update_with_rendering_{}{}",
        if params.test_params { "discard_" } else { "no_discard_" },
        memory_name(params.memory_type)
    )
}

fn is_bit_set(src: u32, ndx: u32) -> bool {
    (src >> ndx) & 1 != 0
}

/// `checkSupport`
fn check_support_ext(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_conditional_rendering")
}

/// `checkFan`
fn check_fan(context: &Context<'_>) -> Result<(), TestError> {
    check_support_ext(context)?;

    if context.is_device_functionality_supported("VK_KHR_portability_subset") {
        let mut features = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if features.triangle_fans == vk::FALSE {
            return Err(TestError::NotSupported(
                "VK_KHR_portability_subset: Triangle fans are not supported by this implementation".to_string(),
            ));
        }
    }
    Ok(())
}

/// The conditional rendering buffer `createInitBufferWithPredicate` leaves in `m_conditionalRenderingBuffer`.
struct PredicateBuffer<'a> {
    buffer: BufferWithMemory<'a>,
    /// `m_conditionalRenderingBufferOffset`
    offset: vk::DeviceSize,
}

/// A buffer create info with `VkBufferUsageFlags2CreateInfo` chained instead of the usage, for the maintenance5 case.
fn create_predicate_buffer_memory<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    maintenance5: bool,
    requirement: MemoryRequirement,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let usage2 = vk::BufferUsageFlags2CreateInfo {
        s_type: vk::StructureType::BUFFER_USAGE_FLAGS_2_CREATE_INFO,
        next: std::ptr::null(),
        usage: vk::BufferUsageFlags2::from_bits_truncate(u64::from(usage.bits())),
    };
    let mut info = make_buffer_create_info(size, usage);
    if maintenance5 {
        info.next = std::ptr::addr_of!(usage2).cast();
        info.usage = vk::BufferUsageFlags::empty();
    }
    BufferWithMemory::new(device, context.get_default_allocator(), info, requirement)
}

/// `ConditionalRenderingBaseTestInstance::createInitBufferWithPredicate`
fn create_init_buffer_with_predicate<'a>(
    context: &'a Context<'a>,
    memory_type: ConditionalBufferMemory,
    discard: bool,
    invert: bool,
    offset_multiplier: u32,
    extra_usage: vk::BufferUsageFlags,
    maintenance5: bool,
) -> Result<PredicateBuffer<'a>, TestError> {
    let device = context.get_device();
    let offset = (std::mem::size_of::<u32>() as u32 * offset_multiplier) as vk::DeviceSize;

    let data_size = std::mem::size_of::<u32>() as vk::DeviceSize + offset;
    let predicate: u32 = if discard { u32::from(invert) } else { u32::from(!invert) };
    let usage = (if memory_type == ConditionalBufferMemory::Host {
        vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT
    } else {
        vk::BufferUsageFlags::TRANSFER_SRC
    }) | extra_usage;

    let use_device_address = extra_usage.contains(vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS);
    let host_requirement = if use_device_address {
        MemoryRequirement::DEVICE_ADDRESS | MemoryRequirement::HOST_VISIBLE
    } else {
        MemoryRequirement::HOST_VISIBLE
    };
    let buffer = create_predicate_buffer_memory(context, data_size, usage, maintenance5, host_requirement)?;

    unsafe {
        std::ptr::copy_nonoverlapping(
            predicate.to_ne_bytes().as_ptr(),
            buffer.get_allocation().get_host_ptr().add(offset as usize),
            std::mem::size_of::<u32>(),
        )
    };
    flush_alloc(device, buffer.get_allocation())?;

    if memory_type == ConditionalBufferMemory::Host {
        return Ok(PredicateBuffer { buffer, offset });
    }

    let local_usage =
        vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT | vk::BufferUsageFlags::TRANSFER_DST | extra_usage;
    let local_requirement = if use_device_address {
        MemoryRequirement::DEVICE_ADDRESS | MemoryRequirement::LOCAL
    } else {
        MemoryRequirement::LOCAL
    };
    let local_buffer =
        create_predicate_buffer_memory(context, data_size, local_usage, maintenance5, local_requirement)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer)?;
    let copy_info = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: data_size,
    };
    unsafe { device.cmd_copy_buffer(*cmd_buffer, buffer.get(), local_buffer.get(), &[copy_info]) };
    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

    Ok(PredicateBuffer {
        buffer: local_buffer,
        offset,
    })
}

fn create_target_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
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

/// `createRenderPass`; the update test adds a dependency from the vertex shader write to the conditional rendering read.
fn create_render_pass(
    device: &Device,
    format: vk::Format,
    layout: vk::ImageLayout,
    with_dependency: bool,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let is_depth = format == DEPTH_FORMAT;
    let attachment_layout = if is_depth {
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    };
    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(attachment_layout)
        .final_layout(attachment_layout)
        .build()];
    let reference = [vk::AttachmentReference { attachment: 0, layout }];
    let subpass = if is_depth {
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .depth_stencil_attachment(&reference[0])
            .build()
    } else {
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&reference)
            .build()
    };
    let subpasses = [subpass];
    let dependencies = [vk::SubpassDependency {
        src_subpass: 0,
        dst_subpass: 0,
        src_stage_mask: vk::PipelineStageFlags::VERTEX_SHADER,
        dst_stage_mask: vk::PipelineStageFlags::CONDITIONAL_RENDERING_EXT,
        src_access_mask: vk::AccessFlags::SHADER_WRITE,
        dst_access_mask: vk::AccessFlags::CONDITIONAL_RENDERING_READ_EXT,
        dependency_flags: vk::DependencyFlags::empty(),
    }];
    let mut info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    if with_dependency {
        info = info.dependencies(&dependencies);
    }
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `imageMemoryBarrier`
#[allow(clippy::too_many_arguments)]
fn image_memory_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    image_aspect_flags: vk::ImageAspectFlags,
) {
    let image_barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(src_access_mask)
        .dst_access_mask(dst_access_mask)
        .old_layout(old_layout)
        .new_layout(new_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(make_image_subresource_range(image_aspect_flags, 0, 1, 0, 1))
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage_mask,
            dst_stage_mask,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
    }
}

/// `bufferMemoryBarrier`
fn buffer_memory_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    buffer: vk::Buffer,
    offset: vk::DeviceSize,
    size: vk::DeviceSize,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
) {
    let buffer_barrier = vk::BufferMemoryBarrier::builder()
        .src_access_mask(src_access_mask)
        .dst_access_mask(dst_access_mask)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .buffer(buffer)
        .offset(offset)
        .size(size)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage_mask,
            dst_stage_mask,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `clearWithClearColorImage` and `clearWithClearDepthStencilImage`, on an image in TRANSFER_DST_OPTIMAL.
fn clear_target_image(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    test_depth: bool,
    color: [f32; 4],
    depth: f32,
) {
    unsafe {
        if test_depth {
            let value = vk::ClearDepthStencilValue { depth, stencil: 0 };
            device.cmd_clear_depth_stencil_image(
                cmd_buffer,
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &value,
                &[make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1)],
            );
        } else {
            let value = vk::ClearColorValue { float32: color };
            device.cmd_clear_color_image(
                cmd_buffer,
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &value,
                &[make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)],
            );
        }
    }
}

/// `clearColorWithClearAttachments` and `clearDepthWithClearAttachments`
fn clear_with_clear_attachments(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    test_depth: bool,
    color: [f32; 4],
    depth: f32,
    partial: bool,
) {
    let clear_attachment = if test_depth {
        vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::DEPTH,
            color_attachment: 0,
            clear_value: vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth, stencil: 0 },
            },
        }
    } else {
        vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: vk::ClearValue {
                color: vk::ClearColorValue { float32: color },
            },
        }
    };
    let mut render_area = vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: WIDTH,
            height: HEIGHT,
        },
    };

    if partial {
        render_area.offset.x = (WIDTH / 2) as i32;
        render_area.offset.y = (HEIGHT / 2) as i32;
        render_area.extent.width = WIDTH / 2;
        render_area.extent.height = HEIGHT / 2;
    }

    let clear_rect = vk::ClearRect {
        rect: render_area,
        base_array_layer: 0,
        layer_count: 1,
    };
    unsafe { device.cmd_clear_attachments(cmd_buffer, &[clear_attachment], &[clear_rect]) };
}

/// `copyResultImageToBuffer` followed by the barrier that makes the buffer readable on the host.
fn copy_result_image_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    aspect: vk::ImageAspectFlags,
    image: vk::Image,
    result_buffer: vk::Buffer,
) {
    let region_all = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: vk::ImageSubresourceLayers {
            aspect_mask: aspect,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        },
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        },
    };
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            result_buffer,
            &[region_all],
        )
    };
    buffer_memory_barrier(
        device,
        cmd_buffer,
        result_buffer,
        0,
        vk::WHOLE_SIZE,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::HOST,
    );
}

fn create_result_buffer<'a>(context: &'a Context<'a>) -> Result<BufferWithMemory<'a>, TestError> {
    let size = (WIDTH * HEIGHT * 4) as vk::DeviceSize;
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )
}

fn read_result_bytes<'a>(device: &Device, result_buffer: &'a BufferWithMemory<'_>) -> Result<&'a [u8], TestError> {
    invalidate_alloc(device, result_buffer.get_allocation())?;
    Ok(unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr(),
            (WIDTH * HEIGHT * 4) as usize,
        )
    })
}

/// Compares an RGBA8 result against per-pixel expected colours with `tcu::floatThresholdCompare`'s 0.01 threshold.
fn colors_match(result: &[u8], expected: impl Fn(u32, u32) -> [f32; 4]) -> bool {
    (0..HEIGHT).all(|y| {
        (0..WIDTH).all(|x| {
            let pixel = &result[((y * WIDTH + x) * 4) as usize..][..4];
            let expected = expected(x, y);
            (0..4).all(|c| (pixel[c] as f32 / 255.0 - expected[c]).abs() <= FLOAT_THRESHOLD)
        })
    })
}

/// Compares a D32_SFLOAT result against per-pixel expected depths.
fn depths_match(result: &[u8], expected: impl Fn(u32, u32) -> f32) -> bool {
    (0..HEIGHT).all(|y| {
        (0..WIDTH).all(|x| {
            let offset = ((y * WIDTH + x) * 4) as usize;
            let depth = f32::from_ne_bytes([
                result[offset],
                result[offset + 1],
                result[offset + 2],
                result[offset + 3],
            ]);
            (depth - expected(x, y)).abs() <= FLOAT_THRESHOLD
        })
    })
}

// ---------------------------------------------------------------------------------------------------------------------
// clear.color.* and clear.depth.*
// ---------------------------------------------------------------------------------------------------------------------

struct ClearAttachmentsCase {
    name: String,
    params: ClearTestParams,
}

impl TestCase for ClearAttachmentsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_ext(context)
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ClearAttachmentsInstance {
            context,
            params: self.params,
        })
    }
}

struct ClearAttachmentsInstance<'a> {
    context: &'a Context<'a>,
    params: ClearTestParams,
}

impl TestInstance for ClearAttachmentsInstance<'_> {
    /// `ConditionalRenderingClearAttachmentsTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let test_depth = params.test_depth;

        let clear_color_initial = [0.0f32, 0.0, 1.0, 1.0];
        let clear_color_middle = [1.0f32, 0.0, 0.0, 1.0];
        let clear_color_final = [0.0f32, 1.0, 0.0, 1.0];
        let clear_depth_value_initial = 0.4f32;
        let clear_depth_value_middle = 0.6f32;
        let clear_depth_value_final = 0.9f32;

        let offset_multiplier = if params.use_offset { 3 } else { 0 };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let predicate = create_init_buffer_with_predicate(
            context,
            params.memory_type,
            params.discard,
            params.invert,
            offset_multiplier,
            vk::BufferUsageFlags::empty(),
            false,
        )?;
        let target_image = if test_depth {
            create_target_image(context, DEPTH_FORMAT, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)?
        } else {
            create_target_image(context, COLOR_FORMAT, vk::ImageUsageFlags::COLOR_ATTACHMENT)?
        };
        let aspect = if test_depth {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::COLOR
        };
        let target_view = make_image_view(
            device,
            target_image.get(),
            vk::ImageViewType::_2D,
            if test_depth { DEPTH_FORMAT } else { COLOR_FORMAT },
            make_image_subresource_range(aspect, 0, 1, 0, 1),
        )?;
        let result_buffer = create_result_buffer(context)?;

        let cmd_buffer_primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer_primary;

        let attachment_layout = if test_depth {
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };
        let render_pass = create_render_pass(
            device,
            if test_depth { DEPTH_FORMAT } else { COLOR_FORMAT },
            attachment_layout,
            false,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target_view], WIDTH, HEIGHT, 1)?;

        let flags = if params.invert {
            vk::ConditionalRenderingFlagsEXT::INVERTED
        } else {
            vk::ConditionalRenderingFlagsEXT::empty()
        };
        let conditional_rendering_begin_info = vk::ConditionalRenderingBeginInfoEXT::builder()
            .buffer(predicate.buffer.get())
            .offset((std::mem::size_of::<u32>() as u32 * offset_multiplier) as u64)
            .flags(flags);

        begin_command_buffer(device, cmd)?;

        image_memory_barrier(
            device,
            cmd,
            target_image.get(),
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            aspect,
        );

        clear_target_image(
            device,
            cmd,
            target_image.get(),
            test_depth,
            clear_color_initial,
            clear_depth_value_initial,
        );

        image_memory_barrier(
            device,
            cmd,
            target_image.get(),
            vk::AccessFlags::TRANSFER_WRITE,
            if test_depth {
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            } else {
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            },
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            attachment_layout,
            vk::PipelineStageFlags::TRANSFER,
            if test_depth {
                vk::PipelineStageFlags::ALL_GRAPHICS
            } else {
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            },
            aspect,
        );

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(WIDTH, HEIGHT));
        if params.clear_attachment_twice {
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

            clear_with_clear_attachments(
                device,
                cmd,
                test_depth,
                clear_color_middle,
                clear_depth_value_middle,
                params.partial_clear,
            );

            unsafe { device.cmd_begin_conditional_rendering_ext(cmd, &conditional_rendering_begin_info) };

            clear_with_clear_attachments(
                device,
                cmd,
                test_depth,
                clear_color_final,
                clear_depth_value_final,
                params.partial_clear,
            );

            unsafe {
                device.cmd_end_conditional_rendering_ext(cmd);
                device.cmd_end_render_pass(cmd);
            }
        } else {
            unsafe {
                device.cmd_begin_conditional_rendering_ext(cmd, &conditional_rendering_begin_info);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            }

            clear_with_clear_attachments(
                device,
                cmd,
                test_depth,
                clear_color_final,
                clear_depth_value_final,
                params.partial_clear,
            );

            unsafe {
                device.cmd_end_render_pass(cmd);
                device.cmd_end_conditional_rendering_ext(cmd);
            }
        }

        image_memory_barrier(
            device,
            cmd,
            target_image.get(),
            if test_depth {
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            } else {
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            },
            vk::AccessFlags::TRANSFER_READ,
            attachment_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            if test_depth {
                vk::PipelineStageFlags::ALL_GRAPHICS
            } else {
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            },
            vk::PipelineStageFlags::TRANSFER,
            aspect,
        );

        copy_result_image_to_buffer(device, cmd, aspect, target_image.get(), result_buffer.get());

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_result_bytes(device, &result_buffer)?;

        // What the clear leaves in the area it covers.
        let covered_color = if params.discard {
            if params.clear_attachment_twice {
                clear_color_middle
            } else {
                clear_color_initial
            }
        } else {
            clear_color_final
        };
        let covered_depth = if params.discard {
            if params.clear_attachment_twice {
                clear_depth_value_middle
            } else {
                clear_depth_value_initial
            }
        } else {
            clear_depth_value_final
        };
        let covered = |x: u32, y: u32| !params.partial_clear || (x >= WIDTH / 2 && y >= HEIGHT / 2);

        let matches = if test_depth {
            depths_match(result, |x, y| {
                if covered(x, y) {
                    covered_depth
                } else {
                    clear_depth_value_initial
                }
            })
        } else {
            colors_match(result, |x, y| {
                if covered(x, y) {
                    covered_color
                } else {
                    clear_color_initial
                }
            })
        };

        Ok(if matches {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// draw.*
// ---------------------------------------------------------------------------------------------------------------------

/// The 256x256 colour target, the pipeline objects and the descriptor set that both draw tests render with.
struct DrawObjects<'a> {
    result_buffer: BufferWithMemory<'a>,
    // Fields drop in order: framebuffer before render pass, view before image.
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    #[allow(dead_code)]
    target_view: Unique<'a, vk::ImageView>,
    target_image: ImageWithMemory<'a>,
}

impl<'a> DrawObjects<'a> {
    fn new(context: &'a Context<'a>, with_dependency: bool) -> Result<Self, TestError> {
        let device = context.get_device();
        let result_buffer = create_result_buffer(context)?;
        let target_image = create_target_image(context, COLOR_FORMAT, vk::ImageUsageFlags::COLOR_ATTACHMENT)?;
        let target_view = make_image_view(
            device,
            target_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let render_pass = create_render_pass(
            device,
            COLOR_FORMAT,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            with_dependency,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target_view], WIDTH, HEIGHT, 1)?;
        Ok(Self {
            result_buffer,
            framebuffer,
            render_pass,
            target_view,
            target_image,
        })
    }
}

/// Clears the colour target to `clear_color` and leaves it in COLOR_ATTACHMENT_OPTIMAL.
fn clear_color_target(device: &Device, cmd: vk::CommandBuffer, image: vk::Image, clear_color: [f32; 4]) {
    image_memory_barrier(
        device,
        cmd,
        image,
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::TRANSFER,
        vk::ImageAspectFlags::COLOR,
    );

    clear_target_image(device, cmd, image, false, clear_color, 0.0);

    image_memory_barrier(
        device,
        cmd,
        image,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::ImageAspectFlags::COLOR,
    );
}

/// The end of both draw tests: colour target to the result buffer.
fn read_back_color_target(device: &Device, cmd: vk::CommandBuffer, objects: &DrawObjects<'_>) {
    image_memory_barrier(
        device,
        cmd,
        objects.target_image.get(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        vk::ImageAspectFlags::COLOR,
    );

    copy_result_image_to_buffer(
        device,
        cmd,
        vk::ImageAspectFlags::COLOR,
        objects.target_image.get(),
        objects.result_buffer.get(),
    );
}

/// The vertex buffer `createVertexBuffer` fills: the four corners of a fan covering the target.
fn create_vertex_buffer<'a>(context: &'a Context<'a>) -> Result<BufferWithMemory<'a>, TestError> {
    let triangle_data: [f32; 16] = [
        -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0,
    ];
    create_host_buffer(context, &triangle_data, vk::BufferUsageFlags::STORAGE_BUFFER)
}

/// `createPipeline`: a triangle fan with no vertex input.
fn create_fan_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_FAN).with_full_viewport(WIDTH, HEIGHT);
    create_draw_pipeline(
        device,
        layout,
        render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, fragment_module),
        ],
        &state,
    )
}

struct DrawCase {
    name: String,
    params: DrawTestParams,
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_fan(context)?;
        if self.params.use_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        if self.params.use_device_address_commands {
            device_address_commands::check_support(context)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DRAW_CLEAR_DRAW.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawInstance {
            context,
            params: self.params,
        })
    }
}

struct DrawInstance<'a> {
    context: &'a Context<'a>,
    params: DrawTestParams,
}

impl TestInstance for DrawInstance<'_> {
    /// `ConditionalRenderingDrawTestInstance::iterate`
    ///
    /// Executes 4 draw calls, each can be drawn with or without conditional rendering. Each draw call renders to the
    /// different part of an image - this is achieved by using push constant and 'discard' in the fragment shader. This
    /// way it is possible to tell which of the rendering command were discarded by the conditional rendering mechanism.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();

        let clear_color_initial = [0.0f32, 0.0, 1.0, 1.0];
        let offset_multiplier = if params.use_offset { 3 } else { 0 };

        let mut buffer_usage_extra_flags = if params.toggle_predicate {
            vk::BufferUsageFlags::TRANSFER_DST
        } else {
            vk::BufferUsageFlags::empty()
        };
        if params.use_device_address_commands {
            buffer_usage_extra_flags |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let predicate = create_init_buffer_with_predicate(
            context,
            params.memory_type,
            params.discard,
            params.invert,
            offset_multiplier,
            buffer_usage_extra_flags,
            params.use_maintenance5,
        )?;

        let predicate_for_copy = if params.toggle_mode == TogglePredicateMode::Copy {
            // we need another buffer to copy from, with toggled predicate value
            Some(create_init_buffer_with_predicate(
                context,
                params.memory_type,
                !params.discard,
                params.invert,
                offset_multiplier,
                vk::BufferUsageFlags::TRANSFER_SRC,
                false,
            )?)
        } else {
            None
        };

        let objects = DrawObjects::new(context, false)?;
        let vertex_buffer = create_vertex_buffer(context)?;

        let cmd_buffer_primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer_primary;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        // `createPipelineLayout`: the area select index is a 16 byte push constant of the fragment stage.
        let push_constant_range = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 16,
        }];
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_constant_range);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // `createAndUpdateDescriptorSet`
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_info = vk::DescriptorBufferInfo {
            buffer: vertex_buffer.get(),
            offset: 0,
            range: (std::mem::size_of::<f32>() * 16) as u64,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_info,
            )
            .update(device);

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("position_only.vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("only_color_out.frag")?)?;

        let pipeline = create_fan_pipeline(
            device,
            *pipeline_layout,
            *objects.render_pass,
            *vertex_shader_module,
            *fragment_shader_module,
        )?;

        let flags = if params.invert {
            vk::ConditionalRenderingFlagsEXT::INVERTED
        } else {
            vk::ConditionalRenderingFlagsEXT::empty()
        };
        let conditional_rendering_begin_info = vk::ConditionalRenderingBeginInfoEXT::builder()
            .buffer(predicate.buffer.get())
            .offset((std::mem::size_of::<u32>() as u32 * offset_multiplier) as u64)
            .flags(flags);
        let address_commands = if params.use_device_address_commands {
            Some(device_address_commands::load_commands(context)?)
        } else {
            None
        };
        let conditional_rendering_begin_info2 = ConditionalRenderingBeginInfo2 {
            address_flags: ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE,
            ..ConditionalRenderingBeginInfo2::new(
                DeviceAddressRange {
                    address: if params.use_device_address_commands {
                        device_address_commands::buffer_device_address(device, predicate.buffer.get())
                            + predicate.offset
                    } else {
                        0
                    },
                    size: std::mem::size_of::<u32>() as vk::DeviceSize,
                },
                flags,
            )
        };

        begin_command_buffer(device, cmd)?;

        clear_color_target(device, cmd, objects.target_image.get(), clear_color_initial);

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
        }

        if params.toggle_predicate {
            if params.toggle_mode == TogglePredicateMode::Fill {
                let discard = !params.discard;
                let new_predicate: u32 = if discard {
                    u32::from(params.invert)
                } else {
                    u32::from(!params.invert)
                };
                unsafe {
                    device.cmd_fill_buffer(
                        cmd,
                        predicate.buffer.get(),
                        predicate.offset,
                        std::mem::size_of::<u32>() as u64,
                        new_predicate,
                    )
                };
                buffer_memory_barrier(
                    device,
                    cmd,
                    predicate.buffer.get(),
                    predicate.offset,
                    std::mem::size_of::<u32>() as u64,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::CONDITIONAL_RENDERING_READ_EXT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::CONDITIONAL_RENDERING_EXT,
                );
            }
            if let Some(predicate_for_copy) = &predicate_for_copy {
                let region = vk::BufferCopy {
                    src_offset: predicate.offset,
                    dst_offset: predicate.offset,
                    size: std::mem::size_of::<u32>() as u64,
                };
                unsafe {
                    device.cmd_copy_buffer(cmd, predicate_for_copy.buffer.get(), predicate.buffer.get(), &[region])
                };
                buffer_memory_barrier(
                    device,
                    cmd,
                    predicate.buffer.get(),
                    predicate.offset,
                    std::mem::size_of::<u32>() as u64,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::CONDITIONAL_RENDERING_READ_EXT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::CONDITIONAL_RENDERING_EXT,
                );
            }
        }

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*objects.render_pass)
            .framebuffer(*objects.framebuffer)
            .render_area(rect_2d(WIDTH, HEIGHT));
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

        let mut data: [i32; 4] = [-1, -1, -1, -1];

        for draw_ndx in 0..4u32 {
            data[0] = draw_ndx as i32;
            let data_bytes: Vec<u8> = data.iter().flat_map(|value| value.to_ne_bytes()).collect();
            unsafe { device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &data_bytes) };

            if is_bit_set(params.begin_sequence_bits, draw_ndx) {
                match &address_commands {
                    None => unsafe {
                        device.cmd_begin_conditional_rendering_ext(cmd, &conditional_rendering_begin_info)
                    },
                    Some(commands) => {
                        let begin_conditional_rendering2 = commands.begin_conditional_rendering2.ok_or_else(|| {
                            TestError::NotSupported("vkCmdBeginConditionalRendering2EXT is not exposed".to_string())
                        })?;
                        unsafe { begin_conditional_rendering2(cmd, &conditional_rendering_begin_info2) };
                    }
                }
            }

            unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };

            if is_bit_set(params.end_sequence_bits, draw_ndx) {
                unsafe { device.cmd_end_conditional_rendering_ext(cmd) };
            }
        }

        unsafe { device.cmd_end_render_pass(cmd) };

        read_back_color_target(device, cmd, &objects);

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_result_bytes(device, &objects.result_buffer)?;

        // `prepareReferenceImage`
        let step = HEIGHT / 4;
        let matches = colors_match(result, |_, y| {
            let band = (y / step).min(3);
            if is_bit_set(params.result_bits, band) {
                [0.0, 1.0, 0.0, 1.0]
            } else {
                clear_color_initial
            }
        });

        Ok(if matches {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

struct UpdateBufferWithDrawCase {
    name: String,
    params: UpdateBufferWithDrawTestParams,
}

impl TestCase for UpdateBufferWithDrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkFanAndVertexStores`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_fan(context)?;

        if context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Vertex pipeline stores and atomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.test_params {
            DRAW_CLEAR_UPDATE_DISCARD.programs
        } else {
            DRAW_CLEAR_UPDATE_NO_DISCARD.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UpdateBufferWithDrawInstance {
            context,
            params: self.params,
        })
    }
}

struct UpdateBufferWithDrawInstance<'a> {
    context: &'a Context<'a>,
    params: UpdateBufferWithDrawTestParams,
}

impl TestInstance for UpdateBufferWithDrawInstance<'_> {
    /// `ConditionalRenderingUpdateBufferWithDrawTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();

        let clear_color_initial = [0.0f32, 0.0, 1.0, 1.0];

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let predicate = create_init_buffer_with_predicate(
            context,
            params.memory_type,
            params.test_params,
            true,
            0,
            vk::BufferUsageFlags::STORAGE_BUFFER,
            false,
        )?;

        let objects = DrawObjects::new(context, true)?;
        let vertex_buffer = create_vertex_buffer(context)?;

        let cmd_buffer_primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer_primary;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;

        // `createPipelineLayout` of the base class: one set, no push constants.
        let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // `createAndUpdateDescriptorSets`: the same set layout is used for both sets.
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_info = vk::DescriptorBufferInfo {
            buffer: vertex_buffer.get(),
            offset: 0,
            range: (std::mem::size_of::<f32>() * 16) as u64,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_info,
            )
            .update(device);

        let descriptor_set_update = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_info_update = vk::DescriptorBufferInfo {
            buffer: predicate.buffer.get(),
            offset: 0,
            range: std::mem::size_of::<u32>() as u64,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set_update.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_info_update,
            )
            .update(device);

        let binaries = context.get_binary_collection();
        let vertex_shader_module_draw = create_shader_module(device, binaries.get("position_only.vert")?)?;
        let fragment_shader_module_draw = create_shader_module(device, binaries.get("only_color_out.frag")?)?;
        let vertex_shader_module_update = create_shader_module(device, binaries.get("update.vert")?)?;
        let fragment_shader_module_discard = create_shader_module(device, binaries.get("discard.frag")?)?;

        // `createPipelines`
        let pipeline_draw = create_fan_pipeline(
            device,
            *pipeline_layout,
            *objects.render_pass,
            *vertex_shader_module_draw,
            *fragment_shader_module_draw,
        )?;
        let pipeline_update = create_fan_pipeline(
            device,
            *pipeline_layout,
            *objects.render_pass,
            *vertex_shader_module_update,
            *fragment_shader_module_discard,
        )?;

        let conditional_rendering_begin_info = vk::ConditionalRenderingBeginInfoEXT::builder()
            .buffer(predicate.buffer.get())
            .offset(0)
            .flags(vk::ConditionalRenderingFlagsEXT::INVERTED);

        begin_command_buffer(device, cmd)?;

        clear_color_target(device, cmd, objects.target_image.get(), clear_color_initial);

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*objects.render_pass)
            .framebuffer(*objects.framebuffer)
            .render_area(rect_2d(WIDTH, HEIGHT));
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_update);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set_update.get()],
                &[] as &[u32],
            );

            device.cmd_draw(cmd, 4, 1, 0, 0);

            device.cmd_end_render_pass(cmd);
        }

        buffer_memory_barrier(
            device,
            cmd,
            predicate.buffer.get(),
            predicate.offset,
            std::mem::size_of::<u32>() as u64,
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::CONDITIONAL_RENDERING_READ_EXT,
            vk::PipelineStageFlags::VERTEX_SHADER,
            vk::PipelineStageFlags::CONDITIONAL_RENDERING_EXT,
        );

        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_draw);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );

            device.cmd_begin_conditional_rendering_ext(cmd, &conditional_rendering_begin_info);
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_conditional_rendering_ext(cmd);

            device.cmd_end_render_pass(cmd);
        }

        read_back_color_target(device, cmd, &objects);

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let result = read_result_bytes(device, &objects.result_buffer)?;

        let expected = if params.test_params {
            [0.0f32, 1.0, 0.0, 1.0]
        } else {
            clear_color_initial
        };
        Ok(if colors_match(result, |_, _| expected) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ConditionalRenderingDrawAndClearTests::init`
pub fn create_conditional_draw_and_clear_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw_clear");
    let mut clear = TestCaseGroup::new("clear");
    let mut color = TestCaseGroup::new("color");
    let mut depth = TestCaseGroup::new("depth");
    let mut draw = TestCaseGroup::new("draw");

    for params in clear_test_grid(false) {
        color.add_child(Box::new(ClearAttachmentsCase {
            name: generate_clear_test_name(&params),
            params,
        }) as Box<dyn TestCase>);
    }

    for params in clear_test_grid(true) {
        depth.add_child(Box::new(ClearAttachmentsCase {
            name: generate_clear_test_name(&params),
            params,
        }) as Box<dyn TestCase>);
    }

    for params in clear_twice_grid(false) {
        color.add_child(Box::new(ClearAttachmentsCase {
            name: format!("clear_attachment_twice_{}", generate_clear_test_name(&params)),
            params,
        }) as Box<dyn TestCase>);
    }

    for params in clear_twice_grid(true) {
        depth.add_child(Box::new(ClearAttachmentsCase {
            name: format!("clear_attachment_twice_{}", generate_clear_test_name(&params)),
            params,
        }) as Box<dyn TestCase>);
    }

    let draw_grid = draw_test_grid();
    for (test_ndx, params) in draw_grid.iter().enumerate() {
        draw.add_child(Box::new(DrawCase {
            name: generate_draw_test_name(test_ndx, params),
            params: *params,
        }) as Box<dyn TestCase>);
    }

    let mut maintenance5_test_params = draw_grid[5];
    maintenance5_test_params.use_maintenance5 = true;
    draw.add_child(Box::new(DrawCase {
        name: "maintenance5".to_string(),
        params: maintenance5_test_params,
    }) as Box<dyn TestCase>);

    // Test the interaction with VK_KHR_device_address_commands.
    for (test_ndx, params) in draw_grid.iter().enumerate() {
        let params = DrawTestParams {
            use_device_address_commands: true,
            ..*params
        };
        draw.add_child(Box::new(DrawCase {
            name: format!("{}_device_address", generate_draw_test_name(test_ndx, &params)),
            params,
        }) as Box<dyn TestCase>);
    }

    for memory_type in [ConditionalBufferMemory::Host, ConditionalBufferMemory::Local] {
        for test_params in [true, false] {
            let params = UpdateBufferWithDrawTestParams {
                test_params,
                memory_type,
            };
            draw.add_child(Box::new(UpdateBufferWithDrawCase {
                name: generate_update_buffer_with_draw_test_name(&params),
                params,
            }) as Box<dyn TestCase>);
        }
    }

    clear.add_child(color);
    clear.add_child(depth);
    group.add_child(clear);
    group.add_child(draw);
    group
}
