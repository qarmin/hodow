// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `createRobustBufferAccessDevice` is not ported: the Context's device is
// created with every feature the physical device reports (robustBufferAccess and scalarBlockLayout included), so the tests
// run on it and require the feature in `checkSupport`.
//
// Helpers shared by the robustness tests: value checks over host-visible buffer contents and the two pre-recorded
// environments (one draw, one dispatch) a test submits.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtDescriptorHeapExtensionDeviceCommands};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_framebuffer, make_render_pass,
};
use crate::vk::programs::create_shader_module;
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::Context;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};

/// `areEqual`
pub fn are_equal(a: f32, b: f32) -> bool {
    (a - b).abs() <= 0.001
}

/// `isValueZero`
pub fn is_value_zero(value: &[u8]) -> bool {
    value.iter().all(|&byte| byte == 0)
}

/// `isValueWithinBuffer` - `buffer` is the whole allocation, so a value read past the end of the buffer object that the
/// driver took from its neighbouring memory still counts.
pub fn is_value_within_buffer(buffer: &[u8], value: &[u8]) -> bool {
    if buffer.len() < value.len() {
        return false;
    }
    if value.is_empty() {
        return true;
    }

    buffer.windows(value.len()).any(|window| window == value)
}

/// `isValueWithinBufferOrZero`
pub fn is_value_within_buffer_or_zero(buffer: &[u8], value: &[u8]) -> bool {
    is_value_within_buffer(buffer, value) || is_value_zero(value)
}

/// `isUintFormat`, for the formats the robustness tests use.
pub fn is_uint_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::R32_UINT
            | vk::Format::R64_UINT
            | vk::Format::R32G32_UINT
            | vk::Format::R32G32B32_UINT
            | vk::Format::R32G32B32A32_UINT
    )
}

/// `isIntFormat`, for the formats the robustness tests use.
pub fn is_int_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::R32_SINT
            | vk::Format::R64_SINT
            | vk::Format::R32G32_SINT
            | vk::Format::R32G32B32_SINT
            | vk::Format::R32G32B32A32_SINT
    )
}

/// `isFloatFormat`, for the formats the robustness tests use.
pub fn is_float_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::R32_SFLOAT
            | vk::Format::R32G32_SFLOAT
            | vk::Format::R32G32B32_SFLOAT
            | vk::Format::R32G32B32A32_SFLOAT
    )
}

/// `tcu::getNumUsedChannels(mapVkFormat(format).order)` for the formats the robustness tests feed to the vertex input.
pub fn num_used_channels(format: vk::Format) -> u32 {
    match format {
        vk::Format::R32_UINT
        | vk::Format::R32_SINT
        | vk::Format::R32_SFLOAT
        | vk::Format::R64_UINT
        | vk::Format::R64_SINT => 1,
        vk::Format::R32G32_UINT | vk::Format::R32G32_SINT | vk::Format::R32G32_SFLOAT => 2,
        vk::Format::R32G32B32_UINT | vk::Format::R32G32B32_SINT | vk::Format::R32G32B32_SFLOAT => 3,
        _ => 4,
    }
}

/// `tcu::getPixelSize(mapVkFormat(format))` for the same formats.
pub fn pixel_size(format: vk::Format) -> u32 {
    match format {
        vk::Format::R64_UINT | vk::Format::R64_SINT => 8,
        vk::Format::A2B10G10R10_UNORM_PACK32 => 4,
        _ => num_used_channels(format) * 4,
    }
}

fn is_r64_format(format: vk::Format) -> bool {
    format == vk::Format::R64_UINT || format == vk::Format::R64_SINT
}

fn read_u32(bytes: &[u8], index: usize) -> u32 {
    u32::from_ne_bytes(bytes[index * 4..index * 4 + 4].try_into().expect("four bytes"))
}

fn read_u64(bytes: &[u8], index: usize) -> u64 {
    u64::from_ne_bytes(bytes[index * 8..index * 8 + 8].try_into().expect("eight bytes"))
}

/// `verifyOutOfBoundsVec4` - an out of bounds vec4 read is `(0, 0, 0, x)` with x being 0, 1 or, for integers, the maximum.
pub fn verify_out_of_bounds_vec4(vec: &[u8], buffer_format: vk::Format) -> bool {
    // A vec4 read that starts too close to the end of the allocation has nothing to compare.
    let needed = if buffer_format == vk::Format::A2B10G10R10_UNORM_PACK32 {
        4
    } else if is_r64_format(buffer_format) {
        32
    } else {
        16
    };
    if vec.len() < needed {
        return false;
    }

    if is_uint_format(buffer_format) {
        if buffer_format == vk::Format::R64_UINT {
            let values: Vec<u64> = (0..4).map(|i| read_u64(vec, i)).collect();
            return values[0] == 0
                && values[1] == 0
                && values[2] == 0
                && (values[3] == 0 || values[3] == 1 || values[3] == u64::MAX);
        }
        let values: Vec<u32> = (0..4).map(|i| read_u32(vec, i)).collect();
        values[0] == 0
            && values[1] == 0
            && values[2] == 0
            && (values[3] == 0 || values[3] == 1 || values[3] == u32::MAX)
    } else if is_int_format(buffer_format) {
        if buffer_format == vk::Format::R64_SINT {
            let values: Vec<i64> = (0..4).map(|i| read_u64(vec, i) as i64).collect();
            return values[0] == 0
                && values[1] == 0
                && values[2] == 0
                && (values[3] == 0 || values[3] == 1 || values[3] == i64::MAX);
        }
        let values: Vec<i32> = (0..4).map(|i| read_u32(vec, i) as i32).collect();
        values[0] == 0
            && values[1] == 0
            && values[2] == 0
            && (values[3] == 0 || values[3] == 1 || values[3] == i32::MAX)
    } else if is_float_format(buffer_format) {
        let data: Vec<f32> = (0..4).map(|i| f32::from_bits(read_u32(vec, i))).collect();
        are_equal(data[0], 0.0)
            && are_equal(data[1], 0.0)
            && are_equal(data[2], 0.0)
            && (are_equal(data[3], 0.0) || are_equal(data[3], 1.0))
    } else if buffer_format == vk::Format::A2B10G10R10_UNORM_PACK32 {
        read_u32(vec, 0) == 0xc000_0000
    } else {
        debug_assert!(false, "unexpected format");
        false
    }
}

/// `populateBufferWithTestValues` - a sequence of 32-bit values.
pub fn populate_buffer_with_test_values(buffer: &mut [u8], format: vk::Format) {
    for scalar_ndx in 0..buffer.len() / 4 {
        // Do not use 0 or 1.
        let value_index = (2 + scalar_ndx) as u32;

        let value: u32 = if is_uint_format(format) {
            value_index
        } else if is_int_format(format) {
            (-(value_index as i32)) as u32
        } else if is_float_format(format) {
            (value_index as f32).to_bits()
        } else if format == vk::Format::A2B10G10R10_UNORM_PACK32 {
            let r = value_index & ((2u32 << 10) - 1);
            let g = (value_index + 1) & ((2u32 << 10) - 1);
            let b = (value_index + 2) & ((2u32 << 10) - 1);
            let a = value_index & ((2u32 << 2) - 1);

            (a << 30) | (b << 20) | (g << 10) | r
        } else {
            debug_assert!(false, "unexpected format");
            0
        };

        buffer[scalar_ndx * 4..scalar_ndx * 4 + 4].copy_from_slice(&value.to_ne_bytes());
    }
}

/// `logValue`
pub fn log_value(log_msg: &mut String, value: &[u8], value_format: vk::Format, value_size: usize) {
    use std::fmt::Write;

    // A range of 1 or 3 bytes leaves less than a scalar to print; C++ reads the allocation's padding there.
    let mut padded = [0u8; 4];
    let copied = value.len().min(4);
    padded[..copied].copy_from_slice(&value[..copied]);

    if is_uint_format(value_format) {
        let _ = write!(log_msg, "{}", read_u32(&padded, 0));
    } else if is_int_format(value_format) {
        let _ = write!(log_msg, "{}", read_u32(&padded, 0) as i32);
    } else if is_float_format(value_format) {
        let _ = write!(log_msg, "{}", f32::from_bits(read_u32(&padded, 0)));
    } else {
        for byte in &value[..value_size] {
            let _ = write!(log_msg, " {byte:x}");
        }
    }
}

/// A host-visible buffer with the size of the whole allocation behind it, which is what out of bounds accesses may land in.
pub struct HostBuffer<'a> {
    pub buffer: BufferWithMemory<'a>,
    pub size: vk::DeviceSize,
    pub alloc_size: vk::DeviceSize,
}

impl<'a> HostBuffer<'a> {
    pub fn new(context: &'a Context<'a>, size: vk::DeviceSize, usage: vk::BufferUsageFlags) -> Result<Self, TestError> {
        Self::new_on(context.get_device(), context, size, usage)
    }

    /// `new` on a device other than the Context's, such as a `RobustnessDevice`'s.
    pub fn new_on(
        device: &'a Device,
        context: &Context<'_>,
        size: vk::DeviceSize,
        usage: vk::BufferUsageFlags,
    ) -> Result<Self, TestError> {
        Self::new_on_with_requirement(device, context, size, usage, MemoryRequirement::HOST_VISIBLE)
    }

    /// `new_on` with `GetHostVisibleRequirement(includeDeviceAddress)`: the memory of a buffer whose address is taken needs the device address flag.
    pub fn new_on_for_heap(
        device: &'a Device,
        context: &Context<'_>,
        size: vk::DeviceSize,
        usage: vk::BufferUsageFlags,
        test_descriptor_heaps: bool,
    ) -> Result<Self, TestError> {
        let requirement = if test_descriptor_heaps {
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::HOST_VISIBLE
        };
        let usage = if test_descriptor_heaps {
            usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
        } else {
            usage
        };
        Self::new_on_with_requirement(device, context, size, usage, requirement)
    }

    /// The buffer `VkBufferUsageFlags2CreateInfo` makes a resource heap of: no `usage` of its own, descriptor heap and device address in the 64-bit flags.
    pub fn new_resource_heap(
        device: &'a Device,
        context: &Context<'_>,
        size: vk::DeviceSize,
    ) -> Result<Self, TestError> {
        Self::new_with_usage2(device, context, size, vk::BufferUsageFlags2::DESCRIPTOR_HEAP_EXT)
    }

    /// A host-visible buffer with a device address whose usage is given as `VkBufferUsageFlags2` (the device address bit is added).
    pub fn new_with_usage2(
        device: &'a Device,
        context: &Context<'_>,
        size: vk::DeviceSize,
        usage: vk::BufferUsageFlags2,
    ) -> Result<Self, TestError> {
        let flags2 = vk::BufferUsageFlags2CreateInfo {
            usage: usage | vk::BufferUsageFlags2::SHADER_DEVICE_ADDRESS,
            ..Default::default()
        };
        let mut create_info = make_buffer_create_info(size, vk::BufferUsageFlags::empty());
        create_info.next = (&flags2 as *const vk::BufferUsageFlags2CreateInfo).cast();
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            create_info,
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )?;
        let alloc_size = unsafe { device.get_buffer_memory_requirements(buffer.get()) }.size;
        Ok(Self {
            buffer,
            size,
            alloc_size,
        })
    }

    fn new_on_with_requirement(
        device: &'a Device,
        context: &Context<'_>,
        size: vk::DeviceSize,
        usage: vk::BufferUsageFlags,
        requirement: MemoryRequirement,
    ) -> Result<Self, TestError> {
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(size, usage),
            requirement,
        )?;
        let alloc_size = unsafe { device.get_buffer_memory_requirements(buffer.get()) }.size;
        Ok(Self {
            buffer,
            size,
            alloc_size,
        })
    }

    pub fn get(&self) -> vk::Buffer {
        self.buffer.get()
    }

    /// `getBufferDeviceAddress`
    pub fn device_address(&self, device: &Device) -> vk::DeviceAddress {
        let info = vk::BufferDeviceAddressInfo::builder().buffer(self.buffer.get());
        unsafe { device.get_buffer_device_address(&info) }
    }

    pub fn bytes(&self) -> &[u8] {
        unsafe { std::slice::from_raw_parts(self.buffer.get_allocation().get_host_ptr(), self.alloc_size as usize) }
    }

    pub fn with_bytes_mut(&self, write: impl FnOnce(&mut [u8])) {
        write(unsafe {
            std::slice::from_raw_parts_mut(self.buffer.get_allocation().get_host_ptr(), self.alloc_size as usize)
        });
    }

    pub fn flush(&self, device: &Device) -> Result<(), TestError> {
        flush_alloc(device, self.buffer.get_allocation())
    }
}

/// `DescriptorHeapEnvironmentParams` - the shader mappings of a pipeline that reads its resources from the heap and the heap to bind.
pub struct DescriptorHeapEnvironmentParams {
    pub mappings: Vec<vk::DescriptorSetAndBindingMappingEXT>,
    pub resource_heap: vk::BindHeapInfoEXT,
}

/// A pipeline with the heap flag and the stage mappings for it chains these two structures.
fn heap_mapping_info(params: &DescriptorHeapEnvironmentParams) -> vk::ShaderDescriptorSetAndBindingMappingInfoEXT {
    vk::ShaderDescriptorSetAndBindingMappingInfoEXT {
        mapping_count: params.mappings.len() as u32,
        mappings: params.mappings.as_ptr(),
        ..Default::default()
    }
}

/// `TestEnvironment` - the command pool and command buffer of a pre-recorded submission.
pub struct TestEnvironment<'a> {
    command_buffer: UniqueCommandBuffer<'a>,
    // After the command buffer: its drop frees it back to this pool.
    _command_pool: Unique<'a, vk::CommandPool>,
}

impl<'a> TestEnvironment<'a> {
    fn new_on(device: &'a Device, context: &Context<'_>) -> Result<Self, TestError> {
        let pool_info = vk::CommandPoolCreateInfo::builder()
            .flags(vk::CommandPoolCreateFlags::TRANSIENT)
            .queue_family_index(context.get_universal_queue_family_index());
        let command_pool = Unique::new(
            device,
            unsafe { device.create_command_pool(&pool_info, None) }.vk_check("vkCreateCommandPool")?,
        );
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        Ok(Self {
            _command_pool: command_pool,
            command_buffer,
        })
    }

    /// `TestEnvironment::getCommandBuffer`
    pub fn get_command_buffer(&self) -> vk::CommandBuffer {
        *self.command_buffer
    }
}

/// `GraphicsEnvironment::DrawConfig`
pub struct DrawConfig {
    pub vertex_buffers: Vec<vk::Buffer>,
    pub vertex_count: u32,
    pub instance_count: u32,
    pub index_buffer: vk::Buffer,
    pub index_count: u32,
}

/// `PipelineRobustnessCreateInfo` as the environments chain it: robust buffer access for storage and uniform buffers, and for
/// the vertex input when `vertex_inputs` is set, image robustness off.
fn pipeline_robustness_info(vertex_inputs: vk::PipelineRobustnessBufferBehavior) -> vk::PipelineRobustnessCreateInfo {
    vk::PipelineRobustnessCreateInfo {
        storage_buffers: vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS,
        uniform_buffers: vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS,
        vertex_inputs,
        images: vk::PipelineRobustnessImageBehavior::DISABLED,
        ..Default::default()
    }
}

/// `GraphicsEnvironment` - one draw into a 16x16 colour target, recorded once.
pub struct GraphicsEnvironment<'a> {
    base: TestEnvironment<'a>,
    _color_image: ImageWithMemory<'a>,
    _color_attachment_view: Unique<'a, vk::ImageView>,
    _render_pass: Unique<'a, vk::RenderPass>,
    _framebuffer: Unique<'a, vk::Framebuffer>,
    _pipeline_layout: Option<Unique<'a, vk::PipelineLayout>>,
    _graphics_pipeline: Unique<'a, vk::Pipeline>,
}

impl<'a> GraphicsEnvironment<'a> {
    const RENDER_SIZE: u32 = 16;
    const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

    pub fn new(
        context: &'a Context<'a>,
        descriptor_set_layout: vk::DescriptorSetLayout,
        descriptor_set: vk::DescriptorSet,
        vertex_bindings: &[vk::VertexInputBindingDescription],
        vertex_attributes: &[vk::VertexInputAttributeDescription],
        draw_config: &DrawConfig,
        test_pipeline_robustness: bool,
    ) -> Result<Self, TestError> {
        Self::new_on(
            context.get_device(),
            context,
            descriptor_set_layout,
            descriptor_set,
            vertex_bindings,
            vertex_attributes,
            draw_config,
            test_pipeline_robustness,
        )
    }

    /// `new` on a device other than the Context's, such as a `RobustnessDevice`'s; the queue family is the Context's universal one.
    #[allow(clippy::too_many_arguments)]
    pub fn new_on(
        device: &'a Device,
        context: &Context<'_>,
        descriptor_set_layout: vk::DescriptorSetLayout,
        descriptor_set: vk::DescriptorSet,
        vertex_bindings: &[vk::VertexInputBindingDescription],
        vertex_attributes: &[vk::VertexInputAttributeDescription],
        draw_config: &DrawConfig,
        test_pipeline_robustness: bool,
    ) -> Result<Self, TestError> {
        Self::new_on_with_heap(
            device,
            context,
            descriptor_set_layout,
            descriptor_set,
            vertex_bindings,
            vertex_attributes,
            draw_config,
            test_pipeline_robustness,
            None,
        )
    }

    /// `new_on` with `descriptorHeapParams`: the pipeline has no layout and reads its resources from the bound heap.
    #[allow(clippy::too_many_arguments)]
    pub fn new_on_with_heap(
        device: &'a Device,
        context: &Context<'_>,
        descriptor_set_layout: vk::DescriptorSetLayout,
        descriptor_set: vk::DescriptorSet,
        vertex_bindings: &[vk::VertexInputBindingDescription],
        vertex_attributes: &[vk::VertexInputAttributeDescription],
        draw_config: &DrawConfig,
        test_pipeline_robustness: bool,
        descriptor_heap_params: Option<&DescriptorHeapEnvironmentParams>,
    ) -> Result<Self, TestError> {
        let base = TestEnvironment::new_on(device, context)?;
        let render_size = Self::RENDER_SIZE;

        // Create color image and view
        let color_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(Self::COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: render_size,
                height: render_size,
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
        let color_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            color_image_info,
            MemoryRequirement::ANY,
        )?;
        let color_srr = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let color_attachment_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            Self::COLOR_FORMAT,
            color_srr,
        )?;

        // Create render pass and framebuffer
        let render_pass = make_render_pass(device, Self::COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view],
            render_size,
            render_size,
            1,
        )?;

        // Create pipeline layout
        let pipeline_layout = if descriptor_heap_params.is_none() {
            let set_layouts = [descriptor_set_layout];
            let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
            Some(Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
            ))
        } else {
            None
        };

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vertex")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("fragment")?)?;

        // Create pipeline
        let mut pipeline_state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(render_size, render_size);
        pipeline_state.bindings = vertex_bindings.to_vec();
        pipeline_state.attributes = vertex_attributes.to_vec();
        pipeline_state.rasterization.depth_bias_enable = vk::FALSE;
        pipeline_state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        pipeline_state.depth_stencil.depth_compare_op = vk::CompareOp::LESS_OR_EQUAL;
        if test_pipeline_robustness {
            pipeline_state.pipeline_robustness = Some(pipeline_robustness_info(
                vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS,
            ));
        }

        if let Some(heap_params) = descriptor_heap_params {
            pipeline_state.create_flags2 = Some(vk::PipelineCreateFlags2::DESCRIPTOR_HEAP_EXT);
            pipeline_state.descriptor_heap_mappings = Some(heap_params.mappings.clone());
        }

        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
        ];
        let graphics_pipeline = create_draw_pipeline(
            device,
            pipeline_layout
                .as_ref()
                .map_or(vk::PipelineLayout::null(), |layout| **layout),
            *render_pass,
            &stages,
            &pipeline_state,
        )?;

        // Record commands
        {
            let cmd = base.get_command_buffer();
            let image_layout_barrier = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(color_image.get())
                .subresource_range(color_srr)
                .build();

            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_layout_barrier],
                );
            }

            begin_render_pass(
                device,
                cmd,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, render_size, render_size),
                clear_value_color([0.0; 4]),
            );
            {
                let vertex_buffer_offsets = vec![0u64; draw_config.vertex_buffers.len()];

                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
                    if let Some(heap_params) = descriptor_heap_params {
                        device.cmd_bind_resource_heap_ext(cmd, &heap_params.resource_heap);
                    } else {
                        device.cmd_bind_descriptor_sets(
                            cmd,
                            vk::PipelineBindPoint::GRAPHICS,
                            **pipeline_layout.as_ref().expect("a layout without a heap"),
                            0,
                            &[descriptor_set],
                            &[] as &[u32],
                        );
                    }
                    device.cmd_bind_vertex_buffers(cmd, 0, &draw_config.vertex_buffers, &vertex_buffer_offsets);

                    if draw_config.index_buffer == vk::Buffer::null() || draw_config.index_count == 0 {
                        device.cmd_draw(cmd, draw_config.vertex_count, draw_config.instance_count, 0, 0);
                    } else {
                        device.cmd_bind_index_buffer(cmd, draw_config.index_buffer, 0, vk::IndexType::UINT32);
                        device.cmd_draw_indexed(cmd, draw_config.index_count, draw_config.instance_count, 0, 0, 0);
                    }
                }
            }
            end_render_pass(device, cmd);
            end_command_buffer(device, cmd)?;
        }

        Ok(Self {
            base,
            _color_image: color_image,
            _color_attachment_view: color_attachment_view,
            _render_pass: render_pass,
            _framebuffer: framebuffer,
            _pipeline_layout: pipeline_layout,
            _graphics_pipeline: graphics_pipeline,
        })
    }

    pub fn get_command_buffer(&self) -> vk::CommandBuffer {
        self.base.get_command_buffer()
    }
}

/// `ComputeEnvironment` - one 32x32x1 dispatch followed by a shader write to host read barrier, recorded once.
pub struct ComputeEnvironment<'a> {
    base: TestEnvironment<'a>,
    _pipeline_layout: Option<Unique<'a, vk::PipelineLayout>>,
    _compute_pipeline: Unique<'a, vk::Pipeline>,
}

impl<'a> ComputeEnvironment<'a> {
    pub fn new(
        context: &'a Context<'a>,
        descriptor_set_layout: vk::DescriptorSetLayout,
        descriptor_set: vk::DescriptorSet,
        test_pipeline_robustness: bool,
    ) -> Result<Self, TestError> {
        Self::new_on(
            context.get_device(),
            context,
            descriptor_set_layout,
            descriptor_set,
            test_pipeline_robustness,
        )
    }

    /// `new` on a device other than the Context's, such as a `RobustnessDevice`'s; the queue family is the Context's universal one.
    pub fn new_on(
        device: &'a Device,
        context: &Context<'_>,
        descriptor_set_layout: vk::DescriptorSetLayout,
        descriptor_set: vk::DescriptorSet,
        test_pipeline_robustness: bool,
    ) -> Result<Self, TestError> {
        Self::new_on_with_heap(
            device,
            context,
            descriptor_set_layout,
            descriptor_set,
            test_pipeline_robustness,
            None,
        )
    }

    /// `new_on` with `descriptorHeapParams`: the pipeline has no layout and reads its resources from the bound heap.
    pub fn new_on_with_heap(
        device: &'a Device,
        context: &Context<'_>,
        descriptor_set_layout: vk::DescriptorSetLayout,
        descriptor_set: vk::DescriptorSet,
        test_pipeline_robustness: bool,
        descriptor_heap_params: Option<&DescriptorHeapEnvironmentParams>,
    ) -> Result<Self, TestError> {
        let base = TestEnvironment::new_on(device, context)?;

        // Create pipeline layout
        let pipeline_layout = if descriptor_heap_params.is_none() {
            let set_layouts = [descriptor_set_layout];
            let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
            Some(Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
            ))
        } else {
            None
        };

        // Create compute pipeline
        let compute_shader_module = create_shader_module(device, context.get_binary_collection().get("compute")?)?;
        let mut stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_shader_module)
            .name(b"main\0")
            .build();
        let mappings = descriptor_heap_params.map(heap_mapping_info);
        if let Some(mappings) = &mappings {
            stage.next = (mappings as *const vk::ShaderDescriptorSetAndBindingMappingInfoEXT).cast();
        }

        let mut robustness_info = pipeline_robustness_info(vk::PipelineRobustnessBufferBehavior::DISABLED);
        let mut pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(
                pipeline_layout
                    .as_ref()
                    .map_or(vk::PipelineLayout::null(), |layout| **layout),
            )
            .base_pipeline_index(0);
        if test_pipeline_robustness {
            pipeline_info = pipeline_info.push_next(&mut robustness_info);
        }
        let mut pipeline_info = pipeline_info.build();
        let flags2_info = vk::PipelineCreateFlags2CreateInfo {
            next: pipeline_info.next,
            flags: vk::PipelineCreateFlags2::DESCRIPTOR_HEAP_EXT,
            ..Default::default()
        };
        if descriptor_heap_params.is_some() {
            pipeline_info.next = (&flags2_info as *const vk::PipelineCreateFlags2CreateInfo).cast();
        }
        let compute_pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        // Record commands
        {
            let cmd = base.get_command_buffer();
            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
                if let Some(heap_params) = descriptor_heap_params {
                    device.cmd_bind_resource_heap_ext(cmd, &heap_params.resource_heap);
                } else {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::COMPUTE,
                        **pipeline_layout.as_ref().expect("a layout without a heap"),
                        0,
                        &[descriptor_set],
                        &[] as &[u32],
                    );
                }
                device.cmd_dispatch(cmd, 32, 32, 1);

                let barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .build();
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, cmd)?;
        }

        Ok(Self {
            base,
            _pipeline_layout: pipeline_layout,
            _compute_pipeline: compute_pipeline,
        })
    }

    pub fn get_command_buffer(&self) -> vk::CommandBuffer {
        self.base.get_command_buffer()
    }
}
