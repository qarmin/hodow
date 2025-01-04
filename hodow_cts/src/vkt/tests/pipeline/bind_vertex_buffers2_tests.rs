// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineBindVertexBuffers2Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `robustness2` cases of the `maintenance5` group need a device created with robustBufferAccess2 enabled, which the
// shared device never has; they are registered so the case list matches upstream and report NotPorted where the
// features are present.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicStateExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_bind_vertex_buffers2::{
    ALL_BIND_VERTEX_BUFFERS2_PROGRAMS, BIND_BUFFERS2_COUNT_1, BIND_BUFFERS2_COUNT_2, BIND_BUFFERS2_COUNT_3,
    BIND_BUFFERS2_COUNT_4,
};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FLOAT_SIZE: u32 = std::mem::size_of::<f32>() as u32;

/// The `rust_type` of the maintenance5 manifest entries: one vertex shader per buffer count.
#[derive(Clone, Copy)]
pub struct BindVertexBuffers2Programs {
    pub name: &'static str,
    pub count: u32,
    pub programs: BinaryCollection,
}

/// `TestParams`: strides and offsets in floats.
#[derive(Clone, Copy)]
struct TestParams {
    color_stride: u32,
    vertex_stride: u32,
    color_offset: u32,
    vertex_offset: u32,
}

/// `colors` of `BindBuffers2Instance::iterate`.
const COLORS: [[f32; 4]; 4] = [
    [0.21, 0.41, 0.61, 0.81],
    [0.22, 0.42, 0.62, 0.82],
    [0.23, 0.43, 0.63, 0.83],
    [0.24, 0.44, 0.64, 0.84],
];

/// `vertices` of `BindBuffers2Instance::iterate`.
const VERTICES: [[f32; 4]; 4] = [
    [0.0, 0.0, 0.0, 0.0],
    [0.0, 1.0, 0.0, 0.0],
    [1.0, 0.0, 0.0, 0.0],
    [1.0, 1.0, 0.0, 0.0],
];

/// The leading offset, then four vec4 values each followed by padding up to `stride` floats.
fn build_attribute_data(values: &[[f32; 4]; 4], offset: u32, stride: u32) -> Vec<f32> {
    let mut data = vec![0.0f32; offset as usize];
    for value in values {
        data.extend_from_slice(value);
        data.extend(std::iter::repeat_n(0.0, (4..stride).count()));
    }
    data
}

/// `makeBufferForImage`'s verification: the whole image is read back as `R32G32B32A32_SFLOAT`.
fn read_pixel(bytes: &[u8], width: u32, x: u32, y: u32) -> [f32; 4] {
    let start = ((y * width + x) * 16) as usize;
    std::array::from_fn(|c| {
        f32::from_ne_bytes([
            bytes[start + c * 4],
            bytes[start + c * 4 + 1],
            bytes[start + c * 4 + 2],
            bytes[start + c * 4 + 3],
        ])
    })
}

/// A vertex buffer holding `data` from byte 0, with `extra_size` more bytes behind it (`colorDataSize + offsets[i]`).
fn create_vertex_buffer<'a>(
    context: &'a Context<'a>,
    data: &[f32],
    extra_size: vk::DeviceSize,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(data) as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size + extra_size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

fn binding_description(
    binding: u32,
    stride: u32,
    input_rate: vk::VertexInputRate,
) -> vk::VertexInputBindingDescription {
    vk::VertexInputBindingDescription {
        binding,
        stride,
        input_rate,
    }
}

fn attribute_description(
    location: u32,
    binding: u32,
    format: vk::Format,
    offset: u32,
) -> vk::VertexInputAttributeDescription {
    vk::VertexInputAttributeDescription {
        location,
        binding,
        format,
        offset,
    }
}

/// What `GraphicsPipelineWrapper::setDefaultRasterizationState` sets.
fn default_wrapper_rasterization() -> vk::PipelineRasterizationStateCreateInfo {
    let mut rasterization = crate::vkt::tests::draw::util::default_rasterization_state();
    rasterization.depth_bias_enable = vk::FALSE;
    rasterization
}

/// The binding of one `cmdBindVertexBuffers2` call, as `BindBuffers2Instance`/`BindBuffers2MismatchInstance` build it.
struct BindBuffers2Draw {
    params: TestParams,
    attributes: Vec<vk::VertexInputAttributeDescription>,
    bindings: Vec<vk::VertexInputBindingDescription>,
    buffers: Vec<vk::Buffer>,
    offsets: Vec<vk::DeviceSize>,
    sizes: Vec<vk::DeviceSize>,
    strides: Vec<vk::DeviceSize>,
    single_bind: bool,
}

impl BindBuffers2Draw {
    /// The body both instances share after the buffers are set up: build the pipeline, draw four instances, check the quadrants.
    fn render_and_verify(&self, context: &Context<'_>) -> TestOutcome {
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let format = vk::Format::R32G32B32A32_SFLOAT;
        const EXTENT: u32 = 32;
        let instance_count = 4u32;

        let color_image = ImageWithBuffer::new(
            context,
            EXTENT,
            EXTENT,
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            16,
        )?;
        let render_pass = make_color_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_image.view], EXTENT, EXTENT, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // The strides given here are ignored: they are dynamic state.
        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(EXTENT, EXTENT);
        state.bindings = self.bindings.clone();
        state.attributes = self.attributes.clone();
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE];
        state.rasterization = default_wrapper_rasterization();
        let shader_objects = make_shader_objects_stages(
            context,
            &[
                (vk::ShaderStageFlags::VERTEX, "vert"),
                (vk::ShaderStageFlags::FRAGMENT, "frag"),
            ],
            &[],
            &[],
        )?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color([0.39, 0.58, 0.93, 1.0])];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(EXTENT, EXTENT),
            &clear_values,
            &[(color_image.image.get(), *color_image.view)],
        );
        unsafe {
            if self.single_bind {
                device.cmd_bind_vertex_buffers2_ext(cmd, 0, &self.buffers, &self.offsets, &self.sizes, &self.strides);
            } else {
                for i in 0..self.buffers.len() {
                    device.cmd_bind_vertex_buffers2_ext(
                        cmd,
                        i as u32,
                        &self.buffers[i..=i],
                        &self.offsets[i..=i],
                        &self.sizes[i..=i],
                        &self.strides[i..=i],
                    );
                }
            }
            device.cmd_draw(cmd, 4, instance_count, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());
        copy_image_to_buffer(
            device,
            cmd,
            color_image.image.get(),
            color_image.buffer.get(),
            EXTENT,
            EXTENT,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let result = color_image.read_bytes(device)?;
        let color_stride_is_zero = self.params.color_stride == 0;
        let expected_color = |index: usize| COLORS[if color_stride_is_zero { 0 } else { index }];

        let (w, h) = (EXTENT, EXTENT);
        for y in 0..h {
            for x in 0..w {
                let pix = read_pixel(result, w, x, y);

                let expected = match (x >= w / 2, y >= h / 2) {
                    (true, true) => COLORS[0],
                    (false, true) => expected_color(1),
                    (true, false) => expected_color(2),
                    (false, false) => expected_color(3),
                };
                if pix != expected {
                    return Ok(TestStatus::fail(format!(
                        "Fail: color at ({x}, {y}) was {pix:?}, but expected color was {expected:?}"
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct BindBuffers2Case {
    name: &'static str,
    params: TestParams,
    single_bind: bool,
    count: u32,
}

impl TestCase for BindBuffers2Case {
    fn name(&self) -> &str {
        self.name
    }

    /// `BindBuffers2Case::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_extended_dynamic_state")
    }

    fn programs(&self) -> BinaryCollection {
        match self.count {
            2 => BIND_BUFFERS2_COUNT_2.programs,
            3 => BIND_BUFFERS2_COUNT_3.programs,
            4 => BIND_BUFFERS2_COUNT_4.programs,
            _ => BIND_BUFFERS2_COUNT_1.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BindBuffers2Instance {
            context,
            params: self.params,
            single_bind: self.single_bind,
            count: self.count,
        })
    }
}

struct BindBuffers2Instance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    single_bind: bool,
    count: u32,
}

impl TestInstance for BindBuffers2Instance<'_> {
    /// `BindBuffers2Instance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let count = self.count;
        let params = self.params;
        let f32_format = |components: u32| match components {
            1 => vk::Format::R32_SFLOAT,
            2 => vk::Format::R32G32_SFLOAT,
            _ => vk::Format::R32G32B32A32_SFLOAT,
        };

        // One attribute per binding; the component count of each depends on how many bindings the colour and position are split over.
        let attribute_formats: Vec<vk::Format> = match count {
            2 => vec![f32_format(2); 4],
            3 => vec![
                f32_format(2),
                f32_format(2),
                f32_format(1),
                f32_format(1),
                f32_format(1),
                f32_format(1),
            ],
            4 => vec![f32_format(1); 8],
            _ => vec![f32_format(4); 2],
        };
        let attributes: Vec<vk::VertexInputAttributeDescription> = attribute_formats
            .iter()
            .enumerate()
            .map(|(i, &format)| attribute_description(i as u32, i as u32, format, 0))
            .collect();

        let mut bindings = Vec::new();
        for i in 0..count {
            bindings.push(binding_description(
                i * 2,
                99, /* ignored */
                vk::VertexInputRate::INSTANCE,
            ));
            bindings.push(binding_description(
                i * 2 + 1,
                99, /* ignored */
                vk::VertexInputRate::VERTEX,
            ));
        }

        let color_stride = (params.color_stride * FLOAT_SIZE) as vk::DeviceSize;
        let color_offset = (params.color_offset * FLOAT_SIZE) as vk::DeviceSize;
        let vertex_stride = (params.vertex_stride * FLOAT_SIZE) as vk::DeviceSize;
        let vertex_offset = (params.vertex_offset * FLOAT_SIZE) as vk::DeviceSize;
        let float_size = FLOAT_SIZE as vk::DeviceSize;

        let color_data = build_attribute_data(&COLORS, params.color_offset, params.color_stride);
        let vertex_data = build_attribute_data(&VERTICES, params.vertex_offset, params.vertex_stride);
        let color_data_size = std::mem::size_of_val(color_data.as_slice()) as vk::DeviceSize;
        let vertex_data_size = std::mem::size_of_val(vertex_data.as_slice()) as vk::DeviceSize;

        let mut offsets: Vec<vk::DeviceSize> = vec![color_offset, vertex_offset];
        match count {
            2 => {
                offsets.push(color_offset + float_size * 2);
                offsets.push(vertex_offset + float_size * 2);
            }
            3 => {
                offsets.push(color_offset + float_size * 2);
                offsets.push(vertex_offset + float_size * 2);
                offsets.push(color_offset + float_size * 3);
                offsets.push(vertex_offset + float_size * 3);
            }
            4 => {
                for k in 1..=3 {
                    offsets.push(color_offset + float_size * k);
                    offsets.push(vertex_offset + float_size * k);
                }
            }
            _ => {}
        }

        let mut owned_buffers = Vec::new();
        for i in 0..count as usize {
            owned_buffers.push(create_vertex_buffer(context, &color_data, offsets[i * 2])?);
            owned_buffers.push(create_vertex_buffer(context, &vertex_data, offsets[i * 2 + 1])?);
        }
        let buffers: Vec<vk::Buffer> = owned_buffers.iter().map(BufferWithMemory::get).collect();

        let sizes: Vec<vk::DeviceSize> = (0..count).flat_map(|_| [color_data_size, vertex_data_size]).collect();
        let strides: Vec<vk::DeviceSize> = (0..count).flat_map(|_| [color_stride, vertex_stride]).collect();

        BindBuffers2Draw {
            params,
            attributes,
            bindings,
            buffers,
            offsets,
            sizes,
            strides,
            single_bind: self.single_bind,
        }
        .render_and_verify(context)
    }
}

/// `BindBuffers2MismatchCase`
struct BindBuffers2MismatchCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for BindBuffers2MismatchCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `BindBuffers2MismatchCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_extended_dynamic_state")
    }

    fn programs(&self) -> BinaryCollection {
        BIND_BUFFERS2_COUNT_1.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BindBuffers2MismatchInstance {
            context,
            params: self.params,
        })
    }
}

struct BindBuffers2MismatchInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for BindBuffers2MismatchInstance<'_> {
    /// `BindBuffers2MismatchInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;

        // Bindings at 0 and 2, skipping 1: the array index (0, 1) and the binding index (0, 2) differ.
        let attributes = vec![
            attribute_description(0, 0, vk::Format::R32G32B32A32_SFLOAT, 0), // Color
            attribute_description(1, 2, vk::Format::R32G32B32A32_SFLOAT, 0), // Position
        ];
        let bindings = vec![
            binding_description(0, 99 /* dynamic */, vk::VertexInputRate::INSTANCE),
            binding_description(2, 99 /* dynamic */, vk::VertexInputRate::VERTEX),
        ];

        let color_stride = (params.color_stride * FLOAT_SIZE) as vk::DeviceSize;
        let color_offset = (params.color_offset * FLOAT_SIZE) as vk::DeviceSize;
        let vertex_stride = (params.vertex_stride * FLOAT_SIZE) as vk::DeviceSize;
        let vertex_offset = (params.vertex_offset * FLOAT_SIZE) as vk::DeviceSize;

        let color_data = build_attribute_data(&COLORS, params.color_offset, params.color_stride);
        let vertex_data = build_attribute_data(&VERTICES, params.vertex_offset, params.vertex_stride);
        let color_data_size = std::mem::size_of_val(color_data.as_slice()) as vk::DeviceSize;
        let vertex_data_size = std::mem::size_of_val(vertex_data.as_slice()) as vk::DeviceSize;

        // Three offsets: binding 0, binding 1 (the gap) and binding 2.
        let offsets = vec![color_offset, 0, vertex_offset];

        let color_buffer = create_vertex_buffer(context, &color_data, offsets[0])?;
        let vertex_buffer = create_vertex_buffer(context, &vertex_data, offsets[2])?;
        // The gap reuses the colour buffer handle.
        let buffers = vec![color_buffer.get(), color_buffer.get(), vertex_buffer.get()];

        let sizes = vec![color_data_size, 0, vertex_data_size];
        // The stride of the gap is the trap: if the implementation indexes by array position it is used for binding 2.
        let strides = vec![color_stride, 0, vertex_stride];

        BindBuffers2Draw {
            params,
            attributes,
            bindings,
            buffers,
            offsets,
            sizes,
            strides,
            single_bind: true,
        }
        .render_and_verify(context)
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BeyondType {
    Buffer,
    Size,
}

/// `TestParamsMaint5`
#[derive(Clone, Copy)]
struct TestParamsMaint5 {
    topology: vk::PrimitiveTopology,
    width: u32,
    height: u32,
    buffer_count: u32,
    rnd_seed: u32,
    whole_size: bool,
    beyond_type: BeyondType,
}

/// `BindVertexBuffers2Case`
struct BindVertexBuffers2Case {
    name: &'static str,
    params: TestParamsMaint5,
    robustness2: bool,
}

impl TestCase for BindVertexBuffers2Case {
    fn name(&self) -> &str {
        self.name
    }

    /// `BindVertexBuffers2Case::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        context.require_device_functionality("VK_KHR_maintenance5")?;

        if self.robustness2 {
            let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
            let robust_buffer_access;
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
                robust_buffer_access = features2.features.robust_buffer_access;
            }
            if robust_buffer_access == vk::FALSE {
                return Err(TestError::NotSupported(
                    "robustBufferAccess not supported by this implementation".to_string(),
                ));
            }
            if !context.is_device_functionality_supported("VK_KHR_robustness2")
                && !context.is_device_functionality_supported("VK_EXT_robustness2")
            {
                return Err(TestError::NotSupported(
                    "VK_KHR_robustness2 and VK_EXT_robustness2 are not supported".to_string(),
                ));
            }
            if robustness2_features.robust_buffer_access2 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "robustBufferAccess2 not supported by this implementation".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_BIND_VERTEX_BUFFERS2_PROGRAMS
            .iter()
            .find(|p| p.count == self.params.buffer_count)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BindVertexBuffers2Instance {
            context,
            params: self.params,
            robustness2: self.robustness2,
        })
    }
}

struct BindVertexBuffers2Instance<'a> {
    context: &'a Context<'a>,
    params: TestParamsMaint5,
    robustness2: bool,
}

/// The buffers `BindVertexBuffers2Instance::createBuffers` returns, with the offsets, strides and sizes to bind them with.
struct Maint5Buffers<'a> {
    buffers: Vec<BufferWithMemory<'a>>,
    offsets: Vec<vk::DeviceSize>,
    strides: Vec<vk::DeviceSize>,
    sizes: Vec<vk::DeviceSize>,
}

impl<'a> BindVertexBuffers2Instance<'a> {
    /// `BindVertexBuffers2Instance::createBuffers`, for a device without robustBufferAccess2.
    fn create_buffers(&self) -> Result<Maint5Buffers<'a>, TestError> {
        let context = self.context;
        let params = self.params;
        let mut rnd = Random::new(params.rnd_seed);
        let p = 1.0f32 / (params.buffer_count - 1) as f32;
        let comp_count = 2u32; // sizeof(tcu::Vec2) / sizeof(float)

        // Beyonds do not matter without robustness: every size is the number of points.
        let (point_template, size): (Vec<f32>, u32) = match params.topology {
            vk::PrimitiveTopology::TRIANGLE_STRIP => (vec![-p, -p, 0.0, -p, -p, 0.0, 0.0, 0.0], 4),
            vk::PrimitiveTopology::TRIANGLE_LIST => (vec![-p, 0.0, -p, -p, 0.0, -p, -p, 0.0, 0.0, -p, 0.0, 0.0], 6),
            _ => return Err(TestError::InternalError("Unsupported topology".to_string())),
        };
        let (source_size, alloc_size, return_size) = (size, size, size);

        let color_template: Vec<[f32; 3]> = (1..=7u32)
            .map(|i| {
                [
                    if i & 1 != 0 { 1.0 } else { 0.6 },
                    if i & 2 != 0 { 1.0 } else { 0.6 },
                    if i & 4 != 0 { 1.0 } else { 0.6 },
                ]
            })
            .collect();
        let mut colors = vec![0.0f32; source_size as usize * 3];
        for i in 0..source_size as usize {
            let c = color_template[i % color_template.len()];
            colors[3 * i..3 * i + 3].copy_from_slice(&c);
        }
        let clr_size = (alloc_size * 3 * FLOAT_SIZE) as vk::DeviceSize;
        let clr_buffer = BufferWithMemory::new(
            context.get_device(),
            context.get_default_allocator(),
            make_buffer_create_info(clr_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                colors.as_ptr().cast::<u8>(),
                clr_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(colors.as_slice()),
            )
        };
        flush_alloc(context.get_device(), clr_buffer.get_allocation())?;

        let buffer_count = params.buffer_count as usize;
        let mut buffers = vec![clr_buffer];
        let mut sizes = vec![0 as vk::DeviceSize; buffer_count];
        sizes[0] = if params.whole_size {
            vk::WHOLE_SIZE
        } else {
            (return_size * 3 * FLOAT_SIZE) as vk::DeviceSize
        };

        // Random offsets multiplied by 4 later, the special value 0 for no offset.
        let mut offsets = vec![0 as vk::DeviceSize; buffer_count];
        for offset in offsets.iter_mut().skip(1) {
            *offset = if params.rnd_seed == 0 {
                0
            } else {
                let mut next = rnd.get_uint64() % 30;
                while next == 0 {
                    next = rnd.get_uint64() % 30;
                }
                next
            };
        }

        // Random strides multiplied by 4 later, the special value for the attributes stride.
        let mut strides = vec![0 as vk::DeviceSize; buffer_count];
        strides[0] = std::mem::size_of::<[f32; 3]>() as vk::DeviceSize;
        for stride in strides.iter_mut().skip(1) {
            *stride = if params.rnd_seed == 0 {
                0
            } else {
                let mut next = rnd.get_uint64() % 30;
                while next == 0 {
                    next = rnd.get_uint64() % 30;
                }
                next
            };
        }

        for i in 1..buffer_count {
            let stride = strides[i] as u32;
            let offset = offsets[i] as u32;
            let element = comp_count + stride;
            let mut points = vec![0.0f32; (offset + source_size * element) as usize];

            for point in points.iter_mut().take(offset as usize) {
                *point = (i * 13) as f32 + 0.234;
            }
            for j in 0..source_size {
                let k = (offset + j * element) as usize;
                points[k] = point_template[(j * comp_count) as usize];
                points[k + 1] = point_template[(j * comp_count + 1) as usize];
                for s in 0..stride as usize {
                    points[k + comp_count as usize + s] = (i * 19) as f32 + 0.543;
                }
            }

            let byte_size = ((offset + alloc_size * element) * FLOAT_SIZE) as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                context.get_device(),
                context.get_default_allocator(),
                make_buffer_create_info(byte_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    points.as_ptr().cast::<u8>(),
                    buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(points.as_slice()),
                )
            };
            flush_alloc(context.get_device(), buffer.get_allocation())?;

            sizes[i] = if params.whole_size {
                vk::WHOLE_SIZE
            } else {
                (element * return_size * FLOAT_SIZE) as vk::DeviceSize
            };
            strides[i] = (element * FLOAT_SIZE) as vk::DeviceSize;
            offsets[i] = (offset * FLOAT_SIZE) as vk::DeviceSize;
            buffers.push(buffer);
        }

        Ok(Maint5Buffers {
            buffers,
            offsets,
            strides,
            sizes,
        })
    }
}

impl TestInstance for BindVertexBuffers2Instance<'_> {
    /// `BindVertexBuffers2Instance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        if self.robustness2 {
            return Err(TestError::NotPorted(
                "a device created with robustBufferAccess2".to_string(),
            ));
        }

        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let format = vk::Format::R32G32B32A32_SFLOAT;

        let color_image = ImageWithBuffer::new(
            context,
            params.width,
            params.height,
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            16,
        )?;
        let render_pass = make_color_render_pass(
            device,
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_image.view],
            params.width,
            params.height,
            1,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let clear_color = [0.5f32; 4];
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let created = self.create_buffers()?;
        let vk_buffers: Vec<vk::Buffer> = created.buffers.iter().map(BufferWithMemory::get).collect();
        let vertex_count = match params.topology {
            vk::PrimitiveTopology::TRIANGLE_STRIP => 4u32,
            _ => 6u32,
        };

        // The pipeline: one colour binding, then `bufferCount - 1` position attributes that all read binding 1.
        let max_stride = context.get_device_properties().limits.max_vertex_input_binding_stride;
        let mut bindings = vec![binding_description(
            0,
            max_stride, /* ignored */
            vk::VertexInputRate::VERTEX,
        )];
        for b in 1..params.buffer_count {
            bindings.push(binding_description(
                b,
                max_stride, /* ignored */
                vk::VertexInputRate::VERTEX,
            ));
        }
        let mut attributes = vec![attribute_description(0, 0, vk::Format::R32G32B32_SFLOAT, 0)];
        for lb in 1..params.buffer_count {
            attributes.push(attribute_description(lb, 1, vk::Format::R32G32_SFLOAT, 0));
        }

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut state = DrawPipelineState::new(params.topology).with_full_viewport(params.width, params.height);
        state.bindings = bindings;
        state.attributes = attributes;
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE];
        state.rasterization = default_wrapper_rasterization();
        state.rasterization.cull_mode = vk::CullModeFlags::NONE;
        state.rasterization.front_face = vk::FrontFace::CLOCKWISE;
        let shader_objects = make_shader_objects_stages(
            context,
            &[
                (vk::ShaderStageFlags::VERTEX, "vert"),
                (vk::ShaderStageFlags::FRAGMENT, "frag"),
            ],
            &[],
            &[],
        )?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        };

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color(clear_color)];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(params.width, params.height),
            &clear_values,
            &[(color_image.image.get(), *color_image.view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers2_ext(
                cmd,
                0,
                &vk_buffers,
                &created.offsets,
                &created.sizes,
                &created.strides,
            );
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());
        copy_image_to_buffer(
            device,
            cmd,
            color_image.image.get(),
            color_image.buffer.get(),
            params.width,
            params.height,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let result = color_image.read_bytes(device)?;

        let half_width = params.width / 2;
        let half_height = params.height / 2;
        let mut equal_clear_count = 0u32;
        for y in 0..half_height {
            for x in 0..half_width {
                let px = read_pixel(result, params.width, x, y);
                if px[0] == clear_color[0] && px[1] == clear_color[1] && px[2] == clear_color[2] {
                    equal_clear_count += 1;
                }
            }
        }
        let mismatch = f64::from(equal_clear_count) / f64::from(half_width * half_height);
        let mismatch_text = format!("Mismatch: {}%", (mismatch * 100.9) as u32);

        let eps = 0.2f32;
        let middle = read_pixel(result, params.width, half_width - 1, half_height - 1);
        let below_threshold = middle[..3].iter().all(|&c| c < eps);

        // Without robustness the whole upper left quarter has to be drawn over.
        let expected_mismatch = 0.0;
        let test_passes = !below_threshold && mismatch == expected_mismatch;
        if !test_passes {
            return Ok(TestStatus::fail(format!(
                "{mismatch_text}; FAILURE: no robustness; pixel at ({}, {}) is {:?} (should be >= {eps}); mismatch in upper left quarter {mismatch} (should be {expected_mismatch}); offsets {:?}, sizes {:?}, strides {:?}",
                half_width - 1,
                half_height - 1,
                &middle[..3],
                created.offsets,
                created.sizes,
                created.strides,
            )));
        }
        Ok(TestStatus::pass(mismatch_text))
    }
}

/// `createCmdBindBuffers2Tests`
pub fn create_cmd_bind_buffers2_tests() -> TestCaseGroup {
    create_cmd_bind_buffers2_tests_for(false)
}

/// `createCmdBindBuffers2Tests`; the shader object construction types leave out the `dynamic_stride` mismatch case.
pub fn create_cmd_bind_buffers2_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut cmd_bind_buffers2_group = TestCaseGroup::new("bind_buffers_2");

    // Values are multiplied by sizeof(float) in the test.
    let stride_tests = [
        (
            TestParams {
                color_stride: 0,
                vertex_stride: 4,
                color_offset: 0,
                vertex_offset: 0,
            },
            "stride_0_4_offset_0_0",
        ),
        (
            TestParams {
                color_stride: 0,
                vertex_stride: 4,
                color_offset: 1,
                vertex_offset: 0,
            },
            "stride_0_4_offset_1_0",
        ),
        (
            TestParams {
                color_stride: 4,
                vertex_stride: 4,
                color_offset: 0,
                vertex_offset: 0,
            },
            "stride_4_4_offset_0_0",
        ),
        (
            TestParams {
                color_stride: 5,
                vertex_stride: 5,
                color_offset: 0,
                vertex_offset: 7,
            },
            "stride_5_5_offset_0_7",
        ),
        (
            TestParams {
                color_stride: 5,
                vertex_stride: 8,
                color_offset: 15,
                vertex_offset: 22,
            },
            "stride_5_8_offset_15_22",
        ),
        (
            TestParams {
                color_stride: 7,
                vertex_stride: 22,
                color_offset: 100,
                vertex_offset: 0,
            },
            "stride_7_22_offset_100_0",
        ),
        (
            TestParams {
                color_stride: 40,
                vertex_stride: 28,
                color_offset: 0,
                vertex_offset: 0,
            },
            "stride_40_28_offset_0_0",
        ),
    ];
    let bind_tests = [(true, "single"), (false, "separate")];
    let count_tests = [(1u32, "count_1"), (2, "count_2"), (3, "count_3"), (4, "count_4")];

    for (single_bind, bind_name) in bind_tests {
        let mut bind_group = TestCaseGroup::new(bind_name);
        for &(params, stride_name) in &stride_tests {
            let mut type_group = TestCaseGroup::new(stride_name);
            for (count, count_name) in count_tests {
                type_group.add_child(Box::new(BindBuffers2Case {
                    name: count_name,
                    params,
                    single_bind,
                    count,
                }) as Box<dyn TestCase>);
            }
            bind_group.add_child(type_group);
        }
        cmd_bind_buffers2_group.add_child(bind_group);
    }

    if !shader_object {
        // Subgroup for the dynamic stride mismatch tests.
        let mut dynamic_stride_group = TestCaseGroup::new("dynamic_stride");
        let mismatch_params = TestParams {
            color_stride: 4,
            vertex_stride: 4,
            color_offset: 0,
            vertex_offset: 0,
        };
        dynamic_stride_group.add_child(Box::new(BindBuffers2MismatchCase {
            name: "binding_stride_index_mismatch",
            params: mismatch_params,
        }) as Box<dyn TestCase>);
        cmd_bind_buffers2_group.add_child(dynamic_stride_group);
    }

    cmd_bind_buffers2_group.add_child(create_cmd_bind_vertex_buffers2_tests());
    cmd_bind_buffers2_group
}

/// `createCmdBindVertexBuffers2Tests`
fn create_cmd_bind_vertex_buffers2_tests() -> TestCaseGroup {
    let counts = [5u32, 9];
    let randoms = [321u32, 432];
    let robust_randoms = [543u32, 654];
    let sizes = [(true, "whole_size"), (false, "true_size")];
    let beyond_types = [(BeyondType::Buffer, "beyond_buffer"), (BeyondType::Size, "beyond_size")];
    let topos = [
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
        (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
    ];

    let default_width = 32;
    let default_height = 32;

    let mut root_group = TestCaseGroup::new("maintenance5");

    for (topology, topo_name) in topos {
        let mut topo_group = TestCaseGroup::new(topo_name);

        for count in counts {
            let mut count_group = TestCaseGroup::new(format!("buffers{count}"));

            for random in randoms {
                let mut random_group = TestCaseGroup::new(format!("stride_offset_rnd{random}"));

                for (whole_size, size_name) in sizes {
                    let params = TestParamsMaint5 {
                        topology,
                        width: default_width,
                        height: default_height,
                        buffer_count: count,
                        rnd_seed: random,
                        whole_size,
                        beyond_type: BeyondType::Buffer,
                    };
                    random_group.add_child(Box::new(BindVertexBuffers2Case {
                        name: size_name,
                        params,
                        robustness2: false,
                    }) as Box<dyn TestCase>);
                }
                count_group.add_child(random_group);
            }
            topo_group.add_child(count_group);
        }
        root_group.add_child(topo_group);
    }

    let mut robust_group = TestCaseGroup::new("robustness2");
    for (topology, topo_name) in topos {
        let mut topo_group = TestCaseGroup::new(topo_name);

        for count in counts {
            let mut count_group = TestCaseGroup::new(format!("buffers{count}"));

            for random in robust_randoms {
                let mut random_group = TestCaseGroup::new(format!("stride_offset_rnd{random}"));

                for (whole_size, size_name) in sizes {
                    let mut size_group = TestCaseGroup::new(size_name);
                    let mut params = TestParamsMaint5 {
                        topology,
                        width: default_width,
                        height: default_height,
                        buffer_count: count,
                        rnd_seed: random,
                        whole_size,
                        beyond_type: BeyondType::Buffer,
                    };

                    if params.whole_size {
                        params.beyond_type = BeyondType::Buffer;
                        let name = beyond_types
                            .iter()
                            .find(|b| b.0 == params.beyond_type)
                            .map_or("beyond_buffer", |b| b.1);
                        size_group.add_child(Box::new(BindVertexBuffers2Case {
                            name,
                            params,
                            robustness2: true,
                        }) as Box<dyn TestCase>);
                    } else {
                        for (beyond_type, beyond_name) in beyond_types {
                            params.beyond_type = beyond_type;
                            size_group.add_child(Box::new(BindVertexBuffers2Case {
                                name: beyond_name,
                                params,
                                robustness2: true,
                            }) as Box<dyn TestCase>);
                        }
                    }
                    random_group.add_child(size_group);
                }
                count_group.add_child(random_group);
            }
            topo_group.add_child(count_group);
        }
        robust_group.add_child(topo_group);
    }
    root_group.add_child(robust_group);

    root_group
}
