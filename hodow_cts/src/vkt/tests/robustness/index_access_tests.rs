// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessIndexAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `*_device_address` cases go through `vk::device_address_commands` (vulkanalia has no
// VK_KHR_device_address_commands). The device `createRobustBufferAccessDevice` makes is `context::RobustnessDevice` (the default device with
// robustBufferAccess2 left on); the pipeline robustness cases use the Context's own device like upstream. The image
// logs are dropped.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, ExtMultiDrawExtensionDeviceCommands, InstanceV1_1, KhrMaintenance5ExtensionDeviceCommands,
};

use crate::generated::shaders::robustness_index_access::{
    BIND_INDEX_BUFFER2, INDEX_ACCESS_VERT_FRAG, INDEX_ACCESS_VERT_GEOM_FRAG, INDEX_ACCESS_VERT_TESS_FRAG,
    INDEX_ACCESS_VERT_TESS_GEOM_FRAG,
};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::device_address_commands::{
    ADDRESS_COMMAND_FULLY_BOUND, ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE,
    ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE, BindIndexBuffer3Info, BindVertexBuffer3Info, Commands,
    CopyDeviceMemoryImageInfo, DeviceAddressRange, DeviceMemoryImageCopy, DrawIndirect2Info, DrawIndirectCount2Info,
    StridedDeviceAddressRange, buffer_device_address, check_support as check_device_address_support,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    DrawIndexed = 0,
    DrawIndexedIndirect,
    DrawIndexedIndirectCount,
    DrawMultiIndexed,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum OoType {
    None,
    Index,
    Size,
    WholeSize,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum UsedStages {
    VertFrag,
    VertGeomFrag,
    VertTessFrag,
    VertTessGeomFrag,
}

#[derive(Clone, Copy)]
struct TestParams {
    mode: TestMode,
    oo_type: OoType,
    leading_count: u32,
    robustness_version: u32,
    use_device_address_commands: bool,
    use_pipeline_robustness: bool,
    use_starting_index_offset: bool,
    /// Used by the EXT_pipeline_robustness cases.
    used_stages: UsedStages,
    index_type: vk::IndexType,
    first_index: u32,
}

impl Default for TestParams {
    fn default() -> Self {
        Self {
            mode: TestMode::DrawIndexed,
            oo_type: OoType::None,
            leading_count: 0,
            robustness_version: 2,
            use_device_address_commands: false,
            use_pipeline_robustness: false,
            use_starting_index_offset: false,
            used_stages: UsedStages::VertFrag,
            index_type: vk::IndexType::UINT32,
            first_index: 0,
        }
    }
}

const TEST_MODES: [(&str, TestMode); 4] = [
    ("draw_indexed", TestMode::DrawIndexed),
    ("draw_indexed_indirect", TestMode::DrawIndexedIndirect),
    ("draw_indexed_indirect_count", TestMode::DrawIndexedIndirectCount),
    ("draw_multi_indexed", TestMode::DrawMultiIndexed),
];

const TYPE_COMBINATIONS: [(vk::IndexType, &str); 2] =
    [(vk::IndexType::UINT8, "uint8"), (vk::IndexType::UINT16, "uint16")];

/// size in bytes of a single index of the specified type
fn get_index_size(index_type: vk::IndexType) -> u32 {
    if index_type == vk::IndexType::UINT8 {
        1
    } else if index_type == vk::IndexType::UINT16 {
        2
    } else {
        4
    }
}

const DRAW_INDEXED_INDIRECT_COMMAND_SIZE: u32 = std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32;
const MULTI_DRAW_INDEXED_INFO_SIZE: u32 = std::mem::size_of::<vk::MultiDrawIndexedInfoEXT>() as u32;

/// The device a case runs on: the robustness one, or the Context's for the pipeline robustness cases.
struct CaseDevice<'a> {
    robust: Option<RobustnessDevice>,
    context: &'a Context<'a>,
}

impl<'a> CaseDevice<'a> {
    fn new(context: &'a Context<'a>, use_robustness_device: bool) -> Result<Self, TestError> {
        let robust = if use_robustness_device {
            Some(RobustnessDevice::new(
                context.get_instance(),
                context.get_physical_device(),
                context.get_universal_queue_family_index(),
                RobustnessFeatures {
                    robust_buffer_access2: true,
                    ..Default::default()
                },
            )?)
        } else {
            None
        };
        Ok(Self { robust, context })
    }

    fn device(&self) -> &Device {
        match &self.robust {
            Some(robust) => robust.device(),
            None => self.context.get_device(),
        }
    }

    fn queue(&self) -> vk::Queue {
        match &self.robust {
            Some(robust) => robust.queue(),
            None => self.context.get_universal_queue(),
        }
    }
}

fn draw_indexed_indirect_command_bytes(command: &vk::DrawIndexedIndirectCommand) -> Vec<u8> {
    let mut bytes = Vec::with_capacity(DRAW_INDEXED_INDIRECT_COMMAND_SIZE as usize);
    bytes.extend_from_slice(&command.index_count.to_ne_bytes());
    bytes.extend_from_slice(&command.instance_count.to_ne_bytes());
    bytes.extend_from_slice(&command.first_index.to_ne_bytes());
    bytes.extend_from_slice(&command.vertex_offset.to_ne_bytes());
    bytes.extend_from_slice(&command.first_instance.to_ne_bytes());
    bytes
}

fn f32_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn host_buffer<'a>(
    device: &'a Device,
    context: &Context<'_>,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    data: Option<&[u8]>,
    device_address: bool,
) -> Result<BufferWithMemory<'a>, TestError> {
    let (usage, requirement) = if device_address {
        (
            usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )
    } else {
        (usage, MemoryRequirement::HOST_VISIBLE)
    };
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, usage),
        requirement,
    )?;
    if let Some(data) = data {
        unsafe { std::ptr::copy_nonoverlapping(data.as_ptr(), buffer.get_allocation().get_host_ptr(), data.len()) };
        flush_alloc(device, buffer.get_allocation())?;
    }
    Ok(buffer)
}

/// The colour attachment both instances render to and read back.
struct ColorTarget<'a> {
    image: ImageWithMemory<'a>,
    view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    srr: vk::ImageSubresourceRange,
}

fn create_color_target<'a>(
    device: &'a Device,
    context: &Context<'_>,
    format: vk::Format,
    size: u32,
) -> Result<ColorTarget<'a>, TestError> {
    let create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: size,
            height: size,
            depth: 1,
        },
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
    let srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        create_info,
        MemoryRequirement::ANY,
    )?;
    let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, format, srr)?;
    Ok(ColorTarget { image, view, srr })
}

fn pipeline_barrier_image(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        )
    };
}

fn copy_image_to_buffer(device: &Device, cmd: vk::CommandBuffer, image: vk::Image, size: u32, buffer: vk::Buffer) {
    let color_sl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: size,
            height: size,
            depth: 1,
        },
        color_sl,
    );
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        )
    };
}

/// `copyImageToMemory`: `vkCmdCopyImageToBuffer`, or `vkCmdCopyImageToMemoryKHR` when the address of the buffer is given.
fn copy_image_to_memory(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    size: u32,
    buffer: vk::Buffer,
    address_copy: Option<(&Commands, DeviceAddressRange)>,
) {
    let Some((commands, address_range)) = address_copy else {
        copy_image_to_buffer(device, cmd, image, size, buffer);
        return;
    };
    let regions = [DeviceMemoryImageCopy::new(
        address_range,
        0,
        0,
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        vk::Offset3D { x: 0, y: 0, z: 0 },
        vk::Extent3D {
            width: size,
            height: size,
            depth: 1,
        },
    )];
    let info = CopyDeviceMemoryImageInfo::new(image, &regions);
    unsafe { (commands.copy_image_to_memory)(cmd, &info) };
}

/// The device addresses and sizes of the buffers a case binds through `VK_KHR_device_address_commands`.
struct AddressedBuffers {
    vertex: DeviceAddressRange,
    index: DeviceAddressRange,
    indirect: DeviceAddressRange,
    indirect_count: DeviceAddressRange,
    output: DeviceAddressRange,
}

fn addressed(device: &Device, buffer: &BufferWithMemory<'_>, size: vk::DeviceSize) -> DeviceAddressRange {
    DeviceAddressRange {
        address: buffer_device_address(device, buffer.get()),
        size,
    }
}

/// The commands that replace the bind and draw calls when `useDeviceAddressCommands` is set.
#[allow(clippy::too_many_arguments)]
fn record_device_address_draw(
    commands: &Commands,
    cmd: vk::CommandBuffer,
    device: &Device,
    params: &TestParams,
    buffers: &AddressedBuffers,
    index_count: u32,
    index_binding_offset: u64,
    index_binding_size: Option<u64>,
    address_flags: u32,
    indirect_stride: u64,
) -> Result<(), TestError> {
    let vertex_info = BindVertexBuffer3Info {
        address_flags,
        ..BindVertexBuffer3Info::new(
            true,
            StridedDeviceAddressRange {
                address: buffers.vertex.address,
                size: buffers.vertex.size,
                stride: 4 * std::mem::size_of::<f32>() as u64,
            },
        )
    };
    unsafe { (commands.bind_vertex_buffers3)(cmd, 0, 1, &vertex_info) };

    let index_info = BindIndexBuffer3Info {
        address_flags,
        ..BindIndexBuffer3Info::new(
            DeviceAddressRange {
                address: buffers.index.address + index_binding_offset,
                size: index_binding_size.unwrap_or(buffers.index.size - index_binding_offset),
            },
            params.index_type,
        )
    };
    unsafe { (commands.bind_index_buffer3)(cmd, &index_info) };

    match params.mode {
        TestMode::DrawIndexed => unsafe { device.cmd_draw_indexed(cmd, index_count, 1, params.first_index, 0, 0) },
        TestMode::DrawIndexedIndirect => {
            let info = DrawIndirect2Info {
                address_flags,
                ..DrawIndirect2Info::new(
                    StridedDeviceAddressRange {
                        address: buffers.indirect.address,
                        size: buffers.indirect.size,
                        stride: indirect_stride,
                    },
                    1,
                )
            };
            unsafe { (commands.draw_indexed_indirect2)(cmd, &info) };
        }
        TestMode::DrawIndexedIndirectCount => {
            let draw_indexed_indirect_count2 = commands.draw_indexed_indirect_count2.ok_or_else(|| {
                TestError::NotSupported("vkCmdDrawIndexedIndirectCount2KHR is not exposed".to_string())
            })?;
            let info = DrawIndirectCount2Info {
                address_flags: 0,
                ..DrawIndirectCount2Info::new(
                    StridedDeviceAddressRange {
                        address: buffers.indirect.address,
                        size: buffers.indirect.size,
                        stride: u64::from(DRAW_INDEXED_INDIRECT_COMMAND_SIZE),
                    },
                    buffers.indirect_count,
                    1,
                )
            };
            unsafe { draw_indexed_indirect_count2(cmd, &info) };
        }
        TestMode::DrawMultiIndexed => {
            return Err(TestError::InternalError(
                "draw_multi_indexed has no device address variant".to_string(),
            ));
        }
    }
    Ok(())
}

// ---------------------------------------------------------------------------------------------------------------------
// DrawIndexedTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn run_draw_indexed(context: &Context<'_>, params: TestParams) -> TestOutcome {
    // when we are testing pipeline robustness we need to use default device (robustBufferAccess should not be enabled)
    let case_device = CaseDevice::new(context, !params.use_pipeline_robustness)?;
    let device = case_device.device();
    let queue_family_index = context.get_universal_queue_family_index();

    let color_format = vk::Format::R8G8B8A8_UNORM;
    let render_size = 16u32;

    let common_usage = vk::BufferUsageFlags::TRANSFER_DST;

    // create vertex buffer with 7 vertices
    let vertices = [
        0.0f32, -0.8, 0.0, 1.0, 0.0, 0.8, 0.0, 1.0, 0.8, -0.8, 0.0, 1.0, 0.8, 0.8, 0.0, 1.0, -0.8, -0.8, 0.0, 1.0,
        -0.8, 0.8, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0,
    ];
    let vertex_bytes = f32_bytes(&vertices);
    let vertex_buffer = host_buffer(
        device,
        context,
        vertex_bytes.len() as vk::DeviceSize,
        vk::BufferUsageFlags::VERTEX_BUFFER | common_usage,
        Some(&vertex_bytes[..]),
        params.use_device_address_commands,
    )?;

    // number of indices that are reachable through the index buffer binding
    // use an odd number of elements so that the buffer size for uint16/uint8
    // index types is not aligned to 4 bytes
    let index_count = 7u32;
    let start_offset = u32::from(params.use_starting_index_offset);

    // prepare index data for index type variants
    let mut index32 = vec![0u32; (start_offset + index_count) as usize];
    let mut index16 = vec![0u16; (start_offset + index_count) as usize];
    let mut index8 = vec![0u8; (start_offset + index_count) as usize];
    for i in 1..index_count {
        index32[(start_offset + i) as usize] = i;
        index16[(start_offset + i) as usize] = i as u16;
        index8[(start_offset + i) as usize] = i as u8;
    }

    // select index data based on index type
    let index_data: Vec<u8> = if params.index_type == vk::IndexType::UINT16 {
        index16.iter().flat_map(|v| v.to_ne_bytes()).collect()
    } else if params.index_type == vk::IndexType::UINT8 {
        index8
    } else {
        index32.iter().flat_map(|v| v.to_ne_bytes()).collect()
    };

    // create index buffer for 7 points
    let index_buffer = host_buffer(
        device,
        context,
        index_data.len() as vk::DeviceSize,
        vk::BufferUsageFlags::INDEX_BUFFER | common_usage,
        Some(&index_data[..]),
        params.use_device_address_commands,
    )?;

    // create indirect buffer
    let draw_indirect_command = vk::DrawIndexedIndirectCommand {
        index_count,
        instance_count: 1,
        first_index: params.first_index,
        vertex_offset: 0,
        first_instance: 0,
    };
    let indirect_data = draw_indexed_indirect_command_bytes(&draw_indirect_command);
    let indirect_buffer = host_buffer(
        device,
        context,
        u64::from(DRAW_INDEXED_INDIRECT_COMMAND_SIZE),
        vk::BufferUsageFlags::INDIRECT_BUFFER | common_usage,
        if matches!(
            params.mode,
            TestMode::DrawIndexedIndirect | TestMode::DrawIndexedIndirectCount
        ) {
            Some(&indirect_data[..])
        } else {
            None
        },
        params.use_device_address_commands,
    )?;

    // create indirect count buffer
    let count_data = 1u32.to_ne_bytes();
    let indirect_count_buffer = host_buffer(
        device,
        context,
        std::mem::size_of::<u32>() as u64,
        vk::BufferUsageFlags::INDIRECT_BUFFER | common_usage,
        if params.mode == TestMode::DrawIndexedIndirectCount {
            Some(&count_data[..])
        } else {
            None
        },
        params.use_device_address_commands,
    )?;

    // create output buffer that will be used to read rendered image
    let output_buffer_size =
        u64::from(render_size * render_size * map_vk_format(color_format).and_then(|f| f.pixel_size()).unwrap_or(4));
    let output_buffer = host_buffer(
        device,
        context,
        output_buffer_size,
        vk::BufferUsageFlags::TRANSFER_SRC | common_usage,
        None,
        params.use_device_address_commands,
    )?;

    let device_address = if params.use_device_address_commands {
        Some((
            Commands::load(context.get_instance(), device)?,
            AddressedBuffers {
                vertex: addressed(device, &vertex_buffer, vertex_bytes.len() as vk::DeviceSize),
                index: addressed(device, &index_buffer, index_data.len() as vk::DeviceSize),
                indirect: addressed(device, &indirect_buffer, u64::from(DRAW_INDEXED_INDIRECT_COMMAND_SIZE)),
                indirect_count: addressed(device, &indirect_count_buffer, std::mem::size_of::<u32>() as u64),
                output: addressed(device, &output_buffer, output_buffer_size),
            },
        ))
    } else {
        None
    };

    let mut pipeline_robustness_info = vk::PipelineRobustnessCreateInfo::default();
    if params.use_pipeline_robustness {
        pipeline_robustness_info.storage_buffers = vk::PipelineRobustnessBufferBehavior::DISABLED;
        pipeline_robustness_info.uniform_buffers = vk::PipelineRobustnessBufferBehavior::DISABLED;
        pipeline_robustness_info.vertex_inputs = if params.robustness_version == 1 {
            vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS
        } else {
            vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS_2
        };
        pipeline_robustness_info.images = vk::PipelineRobustnessImageBehavior::DISABLED;
    }

    // create color buffer
    let color_target = create_color_target(device, context, color_format, render_size)?;

    let render_pass = make_render_pass(device, color_format)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_target.view], render_size, render_size, 1)?;

    // create required shader modules
    let binaries = context.get_binary_collection();
    let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader_module = create_shader_module(device, binaries.get("frag")?)?;
    let mut stages = vec![
        (vk::ShaderStageFlags::VERTEX, *vert_shader_module),
        (vk::ShaderStageFlags::FRAGMENT, *frag_shader_module),
    ];

    let has_geom = matches!(
        params.used_stages,
        UsedStages::VertGeomFrag | UsedStages::VertTessGeomFrag
    );
    let has_tess = matches!(
        params.used_stages,
        UsedStages::VertTessFrag | UsedStages::VertTessGeomFrag
    );

    let geom_shader_module = if has_geom {
        Some(create_shader_module(device, binaries.get("geom")?)?)
    } else {
        None
    };
    if let Some(module) = &geom_shader_module {
        stages.push((vk::ShaderStageFlags::GEOMETRY, **module));
    }
    let tess_shader_modules = if has_tess {
        Some((
            create_shader_module(device, binaries.get("tessc")?)?,
            create_shader_module(device, binaries.get("tesse")?)?,
        ))
    } else {
        None
    };
    if let Some((tessc, tesse)) = &tess_shader_modules {
        stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tessc));
        stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tesse));
    }

    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let mut state = DrawPipelineState::new(if has_tess {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::POINT_LIST
    })
    .with_position_input()
    .with_full_viewport(render_size, render_size);
    state.rasterization.depth_bias_enable = vk::FALSE;
    state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
    state.depth_stencil.depth_compare_op = vk::CompareOp::LESS_OR_EQUAL;
    state.patch_control_points = Some(1);
    if params.use_device_address_commands {
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE];
    }
    if params.use_pipeline_robustness {
        state.pipeline_robustness = Some(pipeline_robustness_info);
    }
    let graphics_pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    // offset is needed for uint8/16 index types - as part of test we dont want them to be aligned to 4 bytes
    let index_buffer_offset_bytes = u64::from(start_offset * get_index_size(params.index_type));

    begin_command_buffer(device, cmd)?;

    // transition colorbuffer layout
    pipeline_barrier_image(
        device,
        cmd,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::FRAGMENT_SHADER,
        make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_target.image.get(),
            color_target.srr,
        ),
    );

    begin_render_pass(
        device,
        cmd,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, render_size, render_size),
        clear_value_color([0.0, 0.0, 0.0, 1.0]),
    );

    unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get()) };

    if let Some((commands, buffers)) = &device_address {
        // use different valid addressFlags in some cases to test them
        let mut address_flags = ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE;
        if params.mode == TestMode::DrawIndexed {
            address_flags |= ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE;
        }
        if params.mode == TestMode::DrawIndexedIndirect {
            address_flags |= ADDRESS_COMMAND_FULLY_BOUND;
        }
        record_device_address_draw(
            commands,
            cmd,
            device,
            &params,
            buffers,
            index_count,
            index_buffer_offset_bytes,
            None,
            address_flags,
            0,
        )?;
    } else {
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd, index_buffer.get(), index_buffer_offset_bytes, params.index_type);

            // we will draw all points at index 0
            match params.mode {
                TestMode::DrawIndexed => device.cmd_draw_indexed(cmd, index_count, 1, params.first_index, 0, 0),
                TestMode::DrawIndexedIndirect => device.cmd_draw_indexed_indirect(cmd, indirect_buffer.get(), 0, 1, 0),
                TestMode::DrawIndexedIndirectCount => device.cmd_draw_indexed_indirect_count(
                    cmd,
                    indirect_buffer.get(),
                    0,
                    indirect_count_buffer.get(),
                    0,
                    1,
                    DRAW_INDEXED_INDIRECT_COMMAND_SIZE,
                ),
                TestMode::DrawMultiIndexed => {
                    let index_info = [
                        vk::MultiDrawIndexedInfoEXT {
                            first_index: params.first_index,
                            index_count: 3,
                            vertex_offset: 0,
                        },
                        vk::MultiDrawIndexedInfoEXT {
                            first_index: params.first_index + 3,
                            index_count: 3,
                            vertex_offset: 0,
                        },
                    ];
                    device.cmd_draw_multi_indexed_ext(cmd, &index_info[..], 1, 0, MULTI_DRAW_INDEXED_INFO_SIZE, None);
                }
            }
        }
    }

    end_render_pass(device, cmd);

    // wait till data is transfered to image
    pipeline_barrier_image(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_target.image.get(),
            color_target.srr,
        ),
    );

    // read back color image
    copy_image_to_memory(
        device,
        cmd,
        color_target.image.get(),
        render_size,
        output_buffer.get(),
        device_address
            .as_ref()
            .map(|(commands, buffers)| (commands, buffers.output)),
    );

    let buffer_barrier = crate::vk::obj_util::make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        output_buffer.get(),
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    end_command_buffer(device, cmd)?;

    submit_commands_and_wait(device, case_device.queue(), cmd)?;

    // for robustBufferAccess (the original feature) OOB access will return undefined value;
    // we can only expect that above drawing will be executed without errors (we can't expect any specific result)
    if params.robustness_version < 2 {
        return Ok(TestStatus::pass("Pass"));
    }

    // get output buffer
    invalidate_alloc(device, output_buffer.get_allocation())?;
    let result_format =
        map_vk_format(color_format).ok_or_else(|| TestError::InternalError("no texture format".to_string()))?;
    let output_data = unsafe {
        std::slice::from_raw_parts(
            output_buffer.get_allocation().get_host_ptr().cast_const(),
            output_buffer_size as usize,
        )
    };
    let output_access = ConstPixelBufferAccess::new(result_format, [render_size, render_size, 1], output_data);

    // for VK_EXT_robustness2 OOB access should return 0 and we can verify
    // that single fragment is drawn in the middle-top part of the image
    let expected_value = [51u32, 255, 127, 255];
    let mut fragment_found = false;

    for x in 0..render_size {
        for y in 0..render_size {
            let pixel = output_access.get_pixel_uint(x, y, 0);

            if (0..4).all(|c| pixel[c].abs_diff(expected_value[c]) < 2) {
                if fragment_found {
                    log::info!(
                        "Expected single fragment with: {:?} color, got more, second at ({}, {})",
                        expected_value,
                        x,
                        y
                    );
                    return Ok(TestStatus::fail("Fail"));
                } else if y < 3 && x > 5 && x < 10 {
                    fragment_found = true;
                } else {
                    log::info!(
                        "Expected fragment in the middle-top of the image, got at: ({}, {})",
                        x,
                        y
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    }

    if fragment_found {
        return Ok(TestStatus::pass("Pass"));
    }
    Ok(TestStatus::fail("Fail"))
}

/// `DrawIndexedTestCase::checkSupport`
fn check_draw_indexed_support(context: &Context<'_>, params: &TestParams) -> Result<(), TestError> {
    if context.is_device_functionality_supported("VK_KHR_portability_subset")
        && context.get_device_features().robust_buffer_access == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "VK_KHR_portability_subset: robustBufferAccess not supported by this implementation".to_string(),
        ));
    }

    if params.mode == TestMode::DrawIndexedIndirectCount {
        context.require_device_functionality("VK_KHR_draw_indirect_count")?;
    }
    if params.mode == TestMode::DrawMultiIndexed {
        context.require_device_functionality("VK_EXT_multi_draw")?;
    }

    if params.robustness_version == 2 {
        if !context.is_device_functionality_supported("VK_KHR_robustness2")
            && !context.is_device_functionality_supported("VK_EXT_robustness2")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_robustness2 and VK_EXT_robustness2 are not supported".to_string(),
            ));
        }

        let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if robustness2_features.robust_buffer_access2 == vk::FALSE {
            return Err(TestError::NotSupported("robustBufferAccess2 not supported".to_string()));
        }
    }

    if params.use_device_address_commands {
        check_device_address_support(context)?;
    }

    if params.use_pipeline_robustness {
        context.require_device_functionality("VK_EXT_pipeline_robustness")?;
    }

    let use_all_stages = params.used_stages == UsedStages::VertTessGeomFrag;
    if (use_all_stages || params.used_stages == UsedStages::VertGeomFrag)
        && context.get_device_features().geometry_shader == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "geometryShader feature not supported".to_string(),
        ));
    }
    if (use_all_stages || params.used_stages == UsedStages::VertTessFrag)
        && context.get_device_features().tessellation_shader == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "tessellationShader feature not supported".to_string(),
        ));
    }

    if params.index_type == vk::IndexType::UINT8 {
        let mut index_type_uint8_features = vk::PhysicalDeviceIndexTypeUint8Features::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut index_type_uint8_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if index_type_uint8_features.index_type_uint8 == vk::FALSE {
            return Err(TestError::NotSupported("indexTypeUint8 not supported".to_string()));
        }
    }
    Ok(())
}

struct DrawIndexedTestCase {
    name: String,
    params: TestParams,
}

impl TestCase for DrawIndexedTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_draw_indexed_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.used_stages {
            UsedStages::VertFrag => INDEX_ACCESS_VERT_FRAG.programs,
            UsedStages::VertGeomFrag => INDEX_ACCESS_VERT_GEOM_FRAG.programs,
            UsedStages::VertTessFrag => INDEX_ACCESS_VERT_TESS_FRAG.programs,
            UsedStages::VertTessGeomFrag => INDEX_ACCESS_VERT_TESS_GEOM_FRAG.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawIndexedInstance {
            context,
            params: self.params,
        })
    }
}

struct DrawIndexedInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for DrawIndexedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_draw_indexed(self.context, self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// BindIndexBuffer2TestCase
// ---------------------------------------------------------------------------------------------------------------------

fn run_bind_index_buffer2(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let case_device = CaseDevice::new(context, true)?;
    let device = case_device.device();
    let queue_family_index = context.get_universal_queue_family_index();

    let color_format = vk::Format::R32G32B32A32_SFLOAT;
    let render_size = 64u32;

    // build vertices data
    let vertices: [[f32; 4]; 12] = [
        // first triangle in 2nd quarter, it should not be drawn
        [-1.0, 0.1, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [-0.1, 0.1, 0.0, 1.0],
        // second triangle in 2nd quarter, it should not be drawn
        [-0.1, 0.1, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [-0.1, 1.0, 0.0, 1.0],
        // first triangle in 3rd quarter, it must be drawn
        [0.0, -1.0, 0.0, 1.0],
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 0.0, 0.0, 1.0],
        // second triangle in 3rd quarter if robustness works as expected, otherwise will be drawn in 1st quarter as well
        [0.0, -1.0, 0.0, 1.0],
        [-1.0, 0.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ];
    let vertex_bytes: Vec<u8> = vertices
        .iter()
        .flatten()
        .flat_map(|value| value.to_ne_bytes())
        .collect();

    let common_usage = vk::BufferUsageFlags::TRANSFER_DST;

    // create vertex buffer
    let vertex_buffer = host_buffer(
        device,
        context,
        vertex_bytes.len() as vk::DeviceSize,
        vk::BufferUsageFlags::VERTEX_BUFFER | common_usage,
        Some(&vertex_bytes[..]),
        params.use_device_address_commands,
    )?;

    let start_offset = u32::from(params.use_starting_index_offset);
    let leading_count = params.leading_count;

    let mut indices = vec![0u32; (start_offset + leading_count * 6 + 6) as usize];
    for j in 0..leading_count {
        for k in 0..6 {
            indices[(start_offset + j * 6 + k) as usize] = k;
        }
    }

    for (offset, index) in indices[(start_offset + leading_count * 6) as usize..]
        .iter_mut()
        .enumerate()
    {
        *index = 6 + offset as u32;
    }

    let index_count = 6u32;
    let index_size = get_index_size(params.index_type);
    let binding_offset = (u64::from(start_offset) + u64::from(leading_count) * 6) * u64::from(index_size);
    let mut index_binding_size = 6 * u64::from(index_size);
    let mut index_buffer_size = indices.len() as u64 * u64::from(index_size);
    match params.oo_type {
        OoType::None => {
            // default values already set
        }
        OoType::Index => {
            // out of range index
            *indices.last_mut().expect("indices are never empty") = 33;
        }
        OoType::Size => {
            index_binding_size = 5 * u64::from(index_size);
        }
        OoType::WholeSize => {
            index_binding_size = vk::WHOLE_SIZE;
            index_buffer_size = (indices.len() as u64 - 1) * u64::from(index_size);
        }
    }

    // serialize the logical indices into the tested index type
    let index_bytes: Vec<u8> = if params.index_type == vk::IndexType::UINT32 {
        indices.iter().flat_map(|v| v.to_ne_bytes()).collect()
    } else if params.index_type == vk::IndexType::UINT8 {
        indices.iter().map(|&v| v as u8).collect()
    } else {
        indices.iter().flat_map(|&v| (v as u16).to_ne_bytes()).collect()
    };

    // create index buffer
    let index_buffer = host_buffer(
        device,
        context,
        index_buffer_size,
        vk::BufferUsageFlags::INDEX_BUFFER | common_usage,
        Some(&index_bytes[..index_buffer_size as usize]),
        params.use_device_address_commands,
    )?;

    // create indirect buffer
    let draw_indirect_command = vk::DrawIndexedIndirectCommand {
        index_count,
        instance_count: 1,
        first_index: params.first_index,
        vertex_offset: 0,
        first_instance: 0,
    };
    let indirect_data = draw_indexed_indirect_command_bytes(&draw_indirect_command);
    let indirect_buffer = host_buffer(
        device,
        context,
        u64::from(DRAW_INDEXED_INDIRECT_COMMAND_SIZE),
        vk::BufferUsageFlags::INDIRECT_BUFFER | common_usage,
        if matches!(
            params.mode,
            TestMode::DrawIndexedIndirect | TestMode::DrawIndexedIndirectCount
        ) {
            Some(&indirect_data[..])
        } else {
            None
        },
        params.use_device_address_commands,
    )?;

    // create indirect count buffer
    let count_data = 1u32.to_ne_bytes();
    let indirect_count_buffer = host_buffer(
        device,
        context,
        std::mem::size_of::<u32>() as u64,
        vk::BufferUsageFlags::INDIRECT_BUFFER | common_usage,
        if params.mode == TestMode::DrawIndexedIndirectCount {
            Some(&count_data[..])
        } else {
            None
        },
        params.use_device_address_commands,
    )?;

    // create output buffer that will be used to read rendered image
    let pixel_size = map_vk_format(color_format)
        .and_then(|f| f.pixel_size())
        .ok_or_else(|| TestError::InternalError("no pixel size".to_string()))?;
    let output_buffer_size = u64::from(render_size * render_size * pixel_size);
    let output_buffer = host_buffer(
        device,
        context,
        output_buffer_size,
        vk::BufferUsageFlags::TRANSFER_SRC | common_usage,
        None,
        params.use_device_address_commands,
    )?;

    let device_address = if params.use_device_address_commands {
        Some((
            Commands::load(context.get_instance(), device)?,
            AddressedBuffers {
                vertex: addressed(device, &vertex_buffer, vertex_bytes.len() as vk::DeviceSize),
                index: addressed(device, &index_buffer, index_buffer_size),
                indirect: addressed(device, &indirect_buffer, u64::from(DRAW_INDEXED_INDIRECT_COMMAND_SIZE)),
                indirect_count: addressed(device, &indirect_count_buffer, std::mem::size_of::<u32>() as u64),
                output: addressed(device, &output_buffer, output_buffer_size),
            },
        ))
    } else {
        None
    };

    // create color buffer
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let color_target = create_color_target(device, context, color_format, render_size)?;

    // create shader modules, renderpass, framebuffer and pipeline
    let binaries = context.get_binary_collection();
    let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader_module = create_shader_module(device, binaries.get("frag")?)?;
    let render_pass = make_render_pass(device, color_format)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_target.view], render_size, render_size, 1)?;
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
        .with_position_input()
        .with_full_viewport(render_size, render_size);
    state.rasterization.depth_bias_enable = vk::FALSE;
    if params.use_device_address_commands {
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE];
    }
    let graphics_pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_shader_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_shader_module),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    // transition colorbuffer layout
    pipeline_barrier_image(
        device,
        cmd,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::FRAGMENT_SHADER,
        make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_target.image.get(),
            color_target.srr,
        ),
    );

    begin_render_pass(
        device,
        cmd,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, render_size, render_size),
        clear_value_color(clear_color),
    );

    unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get()) };

    if let Some((commands, buffers)) = &device_address {
        record_device_address_draw(
            commands,
            cmd,
            device,
            &params,
            buffers,
            index_count,
            binding_offset,
            Some(index_binding_size),
            0,
            u64::from(DRAW_INDEXED_INDIRECT_COMMAND_SIZE),
        )?;
    } else {
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer2_khr(
                cmd,
                index_buffer.get(),
                binding_offset,
                index_binding_size,
                params.index_type,
            );

            // we will draw all points at index 0
            match params.mode {
                TestMode::DrawIndexed => device.cmd_draw_indexed(cmd, index_count, 1, params.first_index, 0, 0),
                TestMode::DrawIndexedIndirect => device.cmd_draw_indexed_indirect(
                    cmd,
                    indirect_buffer.get(),
                    0,
                    1,
                    DRAW_INDEXED_INDIRECT_COMMAND_SIZE,
                ),
                TestMode::DrawIndexedIndirectCount => device.cmd_draw_indexed_indirect_count(
                    cmd,
                    indirect_buffer.get(),
                    0,
                    indirect_count_buffer.get(),
                    0,
                    1,
                    DRAW_INDEXED_INDIRECT_COMMAND_SIZE,
                ),
                TestMode::DrawMultiIndexed => {
                    let index_info = [
                        vk::MultiDrawIndexedInfoEXT {
                            first_index: params.first_index + 3,
                            index_count: 3,
                            vertex_offset: 0,
                        },
                        vk::MultiDrawIndexedInfoEXT {
                            first_index: params.first_index,
                            index_count: 3,
                            vertex_offset: 0,
                        },
                    ];
                    device.cmd_draw_multi_indexed_ext(cmd, &index_info[..], 1, 0, MULTI_DRAW_INDEXED_INFO_SIZE, None);
                }
            }
        }
    }

    end_render_pass(device, cmd);

    // wait till data is transfered to image
    pipeline_barrier_image(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_target.image.get(),
            color_target.srr,
        ),
    );

    // read back color image
    copy_image_to_memory(
        device,
        cmd,
        color_target.image.get(),
        render_size,
        output_buffer.get(),
        device_address
            .as_ref()
            .map(|(commands, buffers)| (commands, buffers.output)),
    );

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, case_device.queue(), cmd)?;

    // get output buffer
    invalidate_alloc(device, output_buffer.get_allocation())?;
    let result_format =
        map_vk_format(color_format).ok_or_else(|| TestError::InternalError("no texture format".to_string()))?;
    let output_data = unsafe {
        std::slice::from_raw_parts(
            output_buffer.get_allocation().get_host_ptr().cast_const(),
            output_buffer_size as usize,
        )
    };
    let result_access = ConstPixelBufferAccess::new(result_format, [render_size, render_size, 1], output_data);

    let is_clear =
        |pixel: [f32; 4]| pixel[0] == clear_color[0] && pixel[1] == clear_color[1] && pixel[2] == clear_color[2];

    // neither one triangle should be drawn in the second quarter, they are omitted by the offset or the firstIndex parameters
    let p11 = result_access.get_pixel(render_size / 8, (5 * render_size) / 8, 0);
    let p12 = result_access.get_pixel((3 * render_size) / 8, (7 * render_size) / 8, 0);
    let c1 = is_clear(p11) && is_clear(p12);

    // small triangle in the third quarter must be drawn always
    let p2 = result_access.get_pixel(render_size / 8, render_size / 8, 0);
    let c2 = p2[0] != clear_color[0] && p2[1] != clear_color[1] && p2[2] != clear_color[2];

    // if robustness works, then the origin of coordinate system will be read in shader instead of a value that an index points (1,1)
    let p3 = result_access.get_pixel((3 * render_size) / 4, (3 * render_size) / 4, 0);
    let c3 = is_clear(p3);

    let verdict = match params.oo_type {
        OoType::None => c1 && c2 && !c3,
        _ => c1 && c2 && c3,
    };

    if verdict {
        return Ok(TestStatus::pass(""));
    }
    Ok(TestStatus::fail(""))
}

struct BindIndexBuffer2TestCase {
    name: String,
    params: TestParams,
}

impl TestCase for BindIndexBuffer2TestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_draw_indexed_support(context, &self.params)?;
        context.require_device_functionality("VK_KHR_maintenance5")
    }

    fn programs(&self) -> BinaryCollection {
        BIND_INDEX_BUFFER2.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BindIndexBuffer2Instance {
            context,
            params: self.params,
        })
    }
}

struct BindIndexBuffer2Instance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for BindIndexBuffer2Instance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_bind_index_buffer2(self.context, self.params)
    }
}

/// `createCmdBindIndexBuffer2Tests`
pub fn create_cmd_bind_index_buffer2_tests() -> TestCaseGroup {
    let out_of_types = [
        ("oo_none", OoType::None),
        ("oo_index", OoType::Index),
        ("oo_size", OoType::Size),
        ("oo_whole_size", OoType::WholeSize),
    ];

    let offsets = [0u32, 100];

    // Test access outside of the buffer with using the vkCmdBindIndexBuffer2 function from VK_KHR_maintenance5.
    let mut g_root = TestCaseGroup::new("bind_index_buffer2");
    for offset in offsets {
        let mut g_offset = TestCaseGroup::new(format!("offset_{offset}"));
        for (mode_name, mode) in TEST_MODES {
            let mut g_mode = TestCaseGroup::new(mode_name);
            for (oo_name, oo_type) in out_of_types {
                let params = TestParams {
                    mode,
                    oo_type,
                    leading_count: offset,
                    ..Default::default()
                };

                g_mode.add_child(Box::new(BindIndexBuffer2TestCase {
                    name: oo_name.to_string(),
                    params,
                }) as Box<dyn TestCase>);

                // skip testing VK_WHOLE_SIZE for device_address_commands, as it is not supported
                if oo_type == OoType::WholeSize {
                    continue;
                }

                // limit number of tests repeated for device_address_commands
                if mode != TestMode::DrawMultiIndexed && offset == 100 {
                    g_mode.add_child(Box::new(BindIndexBuffer2TestCase {
                        name: format!("{oo_name}_device_address"),
                        params: TestParams {
                            use_device_address_commands: true,
                            ..params
                        },
                    }) as Box<dyn TestCase>);
                }
            }
            g_offset.add_child(g_mode);
        }
        g_root.add_child(g_offset);
    }

    let mut g_type = TestCaseGroup::new("type");

    // Test with 8/16-bit index types; uint16/uint8 exercise bindings that end on a boundary
    // aligned to the index size but not to 4 bytes
    for (index_type, type_suffix) in TYPE_COMBINATIONS {
        for (mode_name, mode) in TEST_MODES {
            let params = TestParams {
                oo_type: OoType::Size,
                mode,
                index_type,
                use_starting_index_offset: (mode as u32) % 2 == 0,
                ..Default::default()
            };

            g_type.add_child(Box::new(BindIndexBuffer2TestCase {
                name: format!("{mode_name}_{type_suffix}"),
                params,
            }) as Box<dyn TestCase>);

            if mode != TestMode::DrawMultiIndexed {
                g_type.add_child(Box::new(BindIndexBuffer2TestCase {
                    name: format!("{mode_name}_{type_suffix}_device_address"),
                    params: TestParams {
                        use_device_address_commands: true,
                        ..params
                    },
                }) as Box<dyn TestCase>);
            }
        }
    }

    g_root.add_child(g_type);

    g_root
}

/// `createIndexAccessTests`
pub fn create_index_access_tests() -> TestCaseGroup {
    let all_stage_combinations = [
        (UsedStages::VertFrag, "vert_frag"),
        (UsedStages::VertGeomFrag, "vert_geom_frag"),
        (UsedStages::VertTessFrag, "vert_tess_frag"),
        (UsedStages::VertTessGeomFrag, "vert_tess_geom_frag"),
    ];

    // Test access outside of the buffer for indices
    let mut index_access_tests = TestCaseGroup::new("index_access");

    for (n, mode) in TEST_MODES {
        // First index in index buffer is outside of bounds
        let mut params = TestParams {
            mode,
            robustness_version: 2,
            first_index: u32::MAX - 100,
            ..Default::default()
        };

        let name = format!("{n}_2");
        index_access_tests.add_child(Box::new(DrawIndexedTestCase {
            name: name.clone(),
            params,
        }) as Box<dyn TestCase>);

        if mode != TestMode::DrawMultiIndexed {
            index_access_tests.add_child(Box::new(DrawIndexedTestCase {
                name: format!("{name}_device_address"),
                params: TestParams {
                    use_device_address_commands: true,
                    ..params
                },
            }) as Box<dyn TestCase>);
        }

        // Test oob access for 8-bit and 16-bit indices
        {
            let mut type_params = params;

            // Deliberately use index that is outside of bounds but very close to the end of the buffer;
            // this is to test that the driver does not round up the bound size to a 4-byte boundary
            type_params.first_index = 7;

            for (index_type, postfix) in TYPE_COMBINATIONS {
                type_params.index_type = index_type;
                type_params.use_starting_index_offset = (mode as u32) % 2 == 1;

                index_access_tests.add_child(Box::new(DrawIndexedTestCase {
                    name: format!("{n}_2_{postfix}"),
                    params: type_params,
                }) as Box<dyn TestCase>);

                if mode != TestMode::DrawMultiIndexed {
                    index_access_tests.add_child(Box::new(DrawIndexedTestCase {
                        name: format!("{n}_2_{postfix}_device_address"),
                        params: TestParams {
                            use_device_address_commands: true,
                            ..type_params
                        },
                    }) as Box<dyn TestCase>);
                }
            }
        }

        for robustness_version in [1u32, 2] {
            params.robustness_version = robustness_version;

            // Test EXT_pipeline_robustness with all combinations of used stages and for both robustness versions
            for (used_stages, stages_name) in all_stage_combinations {
                params.used_stages = used_stages;
                params.use_pipeline_robustness = true;
                index_access_tests.add_child(Box::new(DrawIndexedTestCase {
                    name: format!("{n}_pipeline_robustness_{robustness_version}_{stages_name}"),
                    params,
                }) as Box<dyn TestCase>);
            }
        }
    }

    index_access_tests
}
