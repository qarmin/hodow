// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineLegacyAttrTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Tests for VK_EXT_legacy_vertex_attributes. The `_dac` cases (VK_KHR_device_address_commands) are registered so the
// case list matches upstream, are NotSupported where the extension is absent and report NotPorted where it is present.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtVertexInputDynamicStateExtensionDeviceCommands;

use crate::generated::shaders::pipeline_legacy_vertex_attributes::ALL_LEGACY_ATTR_PROGRAMS;
use crate::tcu::float::Float32;
use crate::tcu::pixel::{ConstPixelBufferAccess, get_texture_format_bit_depth};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus, TextureChannelClass, TextureFormat, map_vk_format};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, OffsetParams, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::api::object_tests::format_name;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const K32_BITS_IN_BYTES: usize = 4;

/// The `rust_type` of the manifest entries: one vertex and one fragment shader per list of binding types.
#[derive(Clone, Copy)]
pub struct LegacyAttrPrograms {
    pub name: &'static str,
    pub t0: &'static str,
    pub t1: &'static str,
    pub t2: &'static str,
    pub layout: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderFormat {
    Float,
    SignedInt,
    UnsignedInt,
}

/// `BindingParams`
#[derive(Clone, Copy)]
struct BindingParams {
    format: vk::Format,
    shader_format: ShaderFormat,
    binding_stride: u32,
    attribute_offset: u32,
    memory_offset: u32,
}

fn tcu_format_of(format: vk::Format) -> TextureFormat {
    map_vk_format(format).expect("a vertex format maps to a tcu format")
}

impl BindingParams {
    /// `BindingParams::getRandomSeed`
    fn random_seed(&self) -> u32 {
        ((self.format.as_raw() as u32) << 17)
            | (self.binding_stride << 10)
            | (self.attribute_offset << 5)
            | self.memory_offset
    }

    /// `BindingParams::getShaderType`
    fn shader_type(&self) -> String {
        let channel_count = tcu_format_of(self.format).order.num_used_channels();

        if channel_count == 1 {
            return match self.shader_format {
                ShaderFormat::SignedInt => "int",
                ShaderFormat::UnsignedInt => "uint",
                ShaderFormat::Float => "float",
            }
            .to_string();
        }

        let prefix = match self.shader_format {
            ShaderFormat::SignedInt => "i",
            ShaderFormat::UnsignedInt => "u",
            ShaderFormat::Float => "",
        };
        format!("{prefix}vec{channel_count}")
    }

    /// `BindingParams::useScalarLayout`
    fn use_scalar_layout(&self) -> bool {
        tcu_format_of(self.format).order.num_used_channels() == 3
    }
}

/// `LegacyVertexAttributesParams`
#[derive(Clone)]
struct LegacyVertexAttributesParams {
    use_device_address_commands: bool,
    #[allow(dead_code)]
    set_stride_with_dac: bool,
    bindings: Vec<BindingParams>,
}

impl LegacyVertexAttributesParams {
    /// `LegacyVertexAttributesParams::getRandomSeed`
    fn random_seed(&self) -> u32 {
        let seed = self
            .bindings
            .iter()
            .fold(0u32, |seed, binding| seed ^ binding.random_seed());
        0x80000000 | seed
    }

    fn use_scalar_layout(&self) -> bool {
        self.bindings.iter().any(BindingParams::use_scalar_layout)
    }
}

fn read_pixel_bytes(
    access: &ConstPixelBufferAccess<'_>,
    class: TextureChannelClass,
    x: u32,
    channel_count: usize,
    out: &mut Vec<u8>,
) {
    match class {
        TextureChannelClass::SignedFixedPoint
        | TextureChannelClass::UnsignedFixedPoint
        | TextureChannelClass::FloatingPoint => {
            let pixel = access.get_pixel(x, 0, 0);
            out.extend(pixel[..channel_count].iter().flat_map(|v| v.to_ne_bytes()));
        }
        TextureChannelClass::SignedInteger => {
            let pixel = access.get_pixel_int(x, 0, 0);
            out.extend(pixel[..channel_count].iter().flat_map(|v| v.to_ne_bytes()));
        }
        TextureChannelClass::UnsignedInteger => {
            let pixel = access.get_pixel_uint(x, 0, 0);
            out.extend(pixel[..channel_count].iter().flat_map(|v| v.to_ne_bytes()));
        }
        TextureChannelClass::Last => {}
    }
}

/// `getOutputData`: reinterprets an input vector expanding the components to 32 bits as the shader sees them.
fn get_output_data(input_data: &[u8], params: &BindingParams, num_points: u32) -> Vec<u8> {
    let tcu_format = tcu_format_of(params.format);
    let channel_class = tcu_format.channel_class();
    let channel_count = tcu_format.order.num_used_channels() as usize;

    // The pitch is what makes the access step by the binding stride; the attribute offset moves the start of every pixel.
    let memory_access = ConstPixelBufferAccess::new_with_pitch(
        tcu_format,
        [num_points, 1, 1],
        [params.binding_stride as usize, 1, 1],
        &input_data[params.attribute_offset as usize..],
    );

    let mut output_data = Vec::with_capacity(num_points as usize * channel_count * K32_BITS_IN_BYTES);
    for i in 0..num_points {
        read_pixel_bytes(&memory_access, channel_class, i, channel_count, &mut output_data);
    }
    output_data
}

/// `genInputData`
fn gen_input_data(params: &BindingParams, num_points: u32, rnd: &mut Random) -> Vec<u8> {
    let tcu_format = tcu_format_of(params.format);
    let channel_class = tcu_format.channel_class();
    let floats_used =
        channel_class == TextureChannelClass::FloatingPoint || params.shader_format == ShaderFormat::Float;
    let pixel_size_bytes = tcu_format.pixel_size().expect("a vertex format has a pixel size");
    let total_bytes = (params.binding_stride * (num_points - 1) + params.attribute_offset + pixel_size_bytes) as usize;

    let mut input_data: Vec<u8> = Vec::with_capacity(total_bytes);

    loop {
        input_data.clear();
        for _ in 0..total_bytes {
            input_data.push(rnd.get_uint8());
        }

        // Floats: avoid infs, zeros, nans and denorms to make sure we get identical values back.
        let mut bad_input_data = false;
        if floats_used {
            let output_data = get_output_data(&input_data, params, num_points);
            for chunk in output_data.chunks_exact(K32_BITS_IN_BYTES) {
                let value = Float32::from_bits(u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]));
                if value.is_nan() || value.is_inf() || value.is_denorm() || value.is_zero() {
                    bad_input_data = true;
                    break;
                }
            }
        }

        if !bad_input_data {
            break;
        }
    }

    input_data
}

struct LegacyVertexAttributesCase {
    name: String,
    params: LegacyVertexAttributesParams,
}

impl TestCase for LegacyVertexAttributesCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `LegacyVertexAttributesCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
        context.require_device_functionality("VK_EXT_legacy_vertex_attributes")?;

        // The scalar layout avoids the padding bytes std430 puts after a vec3 in the verification buffer.
        if self.params.use_scalar_layout() {
            context.require_device_functionality("VK_EXT_scalar_block_layout")?;
        }

        if self.params.use_device_address_commands {
            context.require_device_functionality("VK_KHR_device_address_commands")?;
        }

        for binding in &self.params.bindings {
            let format_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), binding.format)
            };
            if !format_properties
                .buffer_features
                .contains(vk::FormatFeatureFlags::VERTEX_BUFFER)
            {
                return Err(TestError::NotSupported(
                    "Format does not support VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let types: Vec<String> = self.params.bindings.iter().map(BindingParams::shader_type).collect();
        let type_at = |i: usize| types.get(i).map_or("", String::as_str);
        ALL_LEGACY_ATTR_PROGRAMS
            .iter()
            .find(|p| p.t0 == type_at(0) && p.t1 == type_at(1) && p.t2 == type_at(2))
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LegacyVertexAttributesInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct LegacyVertexAttributesInstance<'a> {
    context: &'a Context<'a>,
    params: LegacyVertexAttributesParams,
}

impl TestInstance for LegacyVertexAttributesInstance<'_> {
    /// `LegacyVertexAttributesInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        if self.params.use_device_address_commands {
            return Err(TestError::NotPorted(
                "VK_KHR_device_address_commands (vkCmdBindVertexBuffers3KHR)".to_string(),
            ));
        }

        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        const PIXEL_COUNT: u32 = 16;
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        // Must match the fragment shader; the values are 0 and 1 only, so the comparison is exact.
        let geom_color_bytes = [0u8, 0, 255, 255];
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;

        // Color buffer with verification buffer.
        let color_buffer = ImageWithBuffer::new(context, PIXEL_COUNT, 1, fb_format, fb_usage, 4)?;

        // Vertices.
        let vertices: Vec<[f32; 4]> = (0..PIXEL_COUNT)
            .map(|i| {
                let x_coord = ((i as f32 + 0.5) / PIXEL_COUNT as f32 * 2.0) - 1.0;
                [x_coord, 0.0, 0.0, 1.0]
            })
            .collect();

        let mut rnd = Random::new(params.random_seed());
        let byte_inputs: Vec<Vec<u8>> = params
            .bindings
            .iter()
            .map(|binding| gen_input_data(binding, PIXEL_COUNT, &mut rnd))
            .collect();

        // Vertex buffers: the positions first, then one per binding.
        let vb_usage = vk::BufferUsageFlags::VERTEX_BUFFER;
        let mut vertex_buffers: Vec<BufferWithMemory<'_>> = Vec::with_capacity(params.bindings.len() + 1);

        {
            let vb_size = std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(vb_size, vb_usage),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    buffer.get_allocation().get_host_ptr(),
                    vb_size as usize,
                )
            };
            flush_alloc(device, buffer.get_allocation())?;
            vertex_buffers.push(buffer);
        }

        // Extra data. A dedicated allocator for each buffer applies the memory offset.
        let atom_size = context.get_device_properties().limits.non_coherent_atom_size;
        for (binding, input_data) in params.bindings.iter().zip(&byte_inputs) {
            let offset_allocator = SimpleAllocator::with_offset(
                *context.get_default_allocator().memory_properties(),
                OffsetParams {
                    non_coherent_atom_size: atom_size,
                    offset: binding.memory_offset as vk::DeviceSize,
                },
            );

            let vb_size = input_data.len() as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                device,
                &offset_allocator,
                make_buffer_create_info(vb_size, vb_usage),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    input_data.as_ptr(),
                    buffer.get_allocation().get_host_ptr(),
                    input_data.len(),
                )
            };
            flush_alloc(device, buffer.get_allocation())?;
            vertex_buffers.push(buffer);
        }

        // Data buffers for verification.
        let mut verif_buffers: Vec<BufferWithMemory<'_>> = Vec::with_capacity(byte_inputs.len());
        let mut reference_vecs: Vec<Vec<u8>> = Vec::with_capacity(byte_inputs.len());
        for (binding, input_data) in params.bindings.iter().zip(&byte_inputs) {
            let ref_data = get_output_data(input_data, binding, PIXEL_COUNT);
            let buffer_size = ref_data.len() as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, ref_data.len()) };
            flush_alloc(device, buffer.get_allocation())?;
            verif_buffers.push(buffer);
            reference_vecs.push(ref_data);
        }

        // Descriptor pool, set, layout.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(desc_type, verif_buffers.len() as u32)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..verif_buffers.len() {
            layout_builder = layout_builder.add_single_binding(desc_type, vk::ShaderStageFlags::FRAGMENT);
        }
        let set_layout = layout_builder.build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let mut update_builder = DescriptorSetUpdateBuilder::new();
        for (i, (buffer, ref_data)) in verif_buffers.iter().zip(&reference_vecs).enumerate() {
            let info = vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: ref_data.len() as vk::DeviceSize,
            };
            update_builder =
                update_builder.write_single(descriptor_set.get(), Location::binding(i as u32), desc_type, &info);
        }
        update_builder.update(device);

        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
        let render_pass = make_color_render_pass(
            device,
            fb_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], PIXEL_COUNT, 1, 1)?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // The vertex input state is dynamic and empty in the pipeline.
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST).with_full_viewport(PIXEL_COUNT, 1);
        state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_EXT];
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Positions binding, then the extra data bindings.
        let mut binding_descriptions = vec![vk::VertexInputBindingDescription2EXT {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
            divisor: 0,
            ..Default::default()
        }];
        let mut attribute_descriptions = vec![vk::VertexInputAttributeDescription2EXT {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
            ..Default::default()
        }];
        for (i, binding) in params.bindings.iter().enumerate() {
            let idx = i as u32 + 1;
            binding_descriptions.push(vk::VertexInputBindingDescription2EXT {
                binding: idx,
                stride: binding.binding_stride,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 0,
                ..Default::default()
            });
            attribute_descriptions.push(vk::VertexInputAttributeDescription2EXT {
                location: idx,
                binding: idx,
                format: binding.format,
                offset: binding.attribute_offset,
                ..Default::default()
            });
        }

        let raw_vertex_buffers: Vec<vk::Buffer> = vertex_buffers.iter().map(BufferWithMemory::get).collect();
        let raw_vertex_buffer_offsets = vec![0 as vk::DeviceSize; raw_vertex_buffers.len()];

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color(clear_color)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(PIXEL_COUNT, 1))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &raw_vertex_buffers, &raw_vertex_buffer_offsets);
            // Recorded last so it is the vertex input state, strides included, that the draw uses.
            device.cmd_set_vertex_input_ext(cmd, &binding_descriptions, &attribute_descriptions);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            PIXEL_COUNT,
            1,
        );
        {
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify color output.
        let result = color_buffer.read_bytes(device)?;
        if !result.chunks_exact(4).all(|pixel| pixel == geom_color_bytes) {
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }

        // Check storage buffers.
        for (idx, binding) in params.bindings.iter().enumerate() {
            let tcu_vertex_format = tcu_format_of(binding.format);
            let vertex_bit_width = get_texture_format_bit_depth(tcu_vertex_format);
            let channel_class = tcu_vertex_format.channel_class();
            let channel_count = tcu_vertex_format.order.num_used_channels() as usize;

            let buffer = &verif_buffers[idx];
            invalidate_alloc(device, buffer.get_allocation())?;

            let ref_data = &reference_vecs[idx];
            let result_data = unsafe {
                std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), ref_data.len())
            };

            // The fixed point conversions are allowed far more slack than the spec's floating-point format conversion rules require.
            let mut vertex_thres = [0.0f32; 4];
            match channel_class {
                TextureChannelClass::UnsignedFixedPoint => {
                    for (thres, &bits) in vertex_thres.iter_mut().zip(&vertex_bit_width).take(channel_count) {
                        *thres = 1.0 / (((1i64 << (bits + 1)) - 1) as f32);
                    }
                }
                TextureChannelClass::SignedFixedPoint => {
                    for (thres, &bits) in vertex_thres.iter_mut().zip(&vertex_bit_width).take(channel_count) {
                        *thres = 1.0 / (((1i64 << bits) - 1) as f32);
                    }
                }
                _ => {}
            }

            let word = |data: &[u8], scalar_idx: usize| -> [u8; 4] {
                let start = scalar_idx * K32_BITS_IN_BYTES;
                [data[start], data[start + 1], data[start + 2], data[start + 3]]
            };

            let mut failure = None;
            for point_idx in 0..PIXEL_COUNT as usize {
                for ch_idx in 0..channel_count {
                    let scalar_idx = point_idx * channel_count + ch_idx;
                    let (res, reference) = (word(result_data, scalar_idx), word(ref_data, scalar_idx));

                    let message = match channel_class {
                        TextureChannelClass::SignedFixedPoint
                        | TextureChannelClass::UnsignedFixedPoint
                        | TextureChannelClass::FloatingPoint => {
                            let (res, reference) = (f32::from_ne_bytes(res), f32::from_ne_bytes(reference));
                            let thr = vertex_thres[ch_idx];
                            ((res - reference).abs() > thr)
                                .then(|| format!("found {res} but expected {reference} (threshold {thr})"))
                        }
                        TextureChannelClass::SignedInteger => {
                            let (res, reference) = (i32::from_ne_bytes(res), i32::from_ne_bytes(reference));
                            (res != reference).then(|| format!("found {res} but expected {reference}"))
                        }
                        TextureChannelClass::UnsignedInteger => {
                            let (res, reference) = (u32::from_ne_bytes(res), u32::from_ne_bytes(reference));
                            (res != reference).then(|| format!("found {res} but expected {reference}"))
                        }
                        TextureChannelClass::Last => None,
                    };
                    if let Some(message) = message
                        && failure.is_none()
                    {
                        failure = Some(format!(
                            "Unexpected result in output buffer for binding {idx}, point {point_idx} channel {ch_idx}: {message}"
                        ));
                    }
                }
            }
            if let Some(failure) = failure {
                return Ok(TestStatus::fail(failure));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn format_class_is_float(class: TextureChannelClass) -> bool {
    matches!(
        class,
        TextureChannelClass::FloatingPoint
            | TextureChannelClass::UnsignedFixedPoint
            | TextureChannelClass::SignedFixedPoint
    )
}

/// `checkAny`
fn check_any(values: [i32; 4], channel_count: usize, condition: impl Fn(i32) -> bool) -> bool {
    values.iter().take(channel_count.min(4)).any(|&v| condition(v))
}

fn less_than_32_bits(width: i32) -> bool {
    width < 32
}

fn suffix_with_value(prefix: &str, value: u32) -> String {
    if value > 0 {
        format!("{prefix}{value}")
    } else {
        String::new()
    }
}

/// The `useDAC` x `setStrideWithDAC` repetition both populate functions share: `(use_dac, set_stride_with_dac, name suffix)`.
fn dac_variants() -> [(bool, bool, &'static str); 3] {
    [
        (false, false, ""),
        (true, false, "_dac"),
        (true, true, "_dac_with_stride"),
    ]
}

/// `populateSingleBindingFormatGroup`
fn single_binding_format_group(format: vk::Format) -> TestCaseGroup {
    let mut format_group = TestCaseGroup::new(format_name(format));

    let shader_formats = [
        (ShaderFormat::SignedInt, "shader_int"),
        (ShaderFormat::UnsignedInt, "shader_uint"),
        (ShaderFormat::Float, "shader_float"),
    ];

    let tcu_format = tcu_format_of(format);
    let format_size = tcu_format.pixel_size().expect("a vertex format has a pixel size");
    let fmt_class = tcu_format.channel_class();
    let vertex_bit_width = get_texture_format_bit_depth(tcu_format);
    let channel_count = tcu_format.order.num_used_channels() as usize;

    let strides: std::collections::BTreeSet<u32> =
        [0, 1, format_size, format_size + format_size - 1].into_iter().collect();

    for &stride in &strides {
        for &(shader_format, desc) in &shader_formats {
            let is_float_format = format_class_is_float(fmt_class);
            let is_integer_format = !is_float_format;

            // Float-like formats need to be reinterpreted as only one of the signed and unsigned integers in the shader.
            if is_float_format {
                let fmt_mod = format.as_raw() % 2;
                if fmt_mod == 0 && shader_format == ShaderFormat::SignedInt {
                    continue;
                }
                if fmt_mod == 1 && shader_format == ShaderFormat::UnsignedInt {
                    continue;
                }
            }

            // Small integer channels expand to denormals when read as floats, which genInputData rejects.
            if is_integer_format
                && shader_format == ShaderFormat::Float
                && check_any(vertex_bit_width, channel_count, less_than_32_bits)
            {
                continue;
            }

            for attribute_offset in [0u32, 1] {
                for memory_offset in [0u32, 1] {
                    if (attribute_offset != 0 || memory_offset != 0)
                        && !check_any(vertex_bit_width, channel_count, |width| width > 8)
                    {
                        // No unaligned access despite the offsets.
                        continue;
                    }

                    let ao_suffix = suffix_with_value("_attribute_offset_", attribute_offset);
                    let mo_suffix = suffix_with_value("_memory_offset_", memory_offset);
                    let binding_params = BindingParams {
                        format,
                        shader_format,
                        binding_stride: stride,
                        attribute_offset,
                        memory_offset,
                    };

                    for (use_dac, set_stride_with_dac, dac_suffix) in dac_variants() {
                        let params = LegacyVertexAttributesParams {
                            use_device_address_commands: use_dac,
                            set_stride_with_dac,
                            bindings: vec![binding_params],
                        };
                        let name = format!("{desc}_stride_{stride}{ao_suffix}{mo_suffix}{dac_suffix}");
                        format_group
                            .add_child(Box::new(LegacyVertexAttributesCase { name, params }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    format_group
}

/// `populateSingleBindingGroup`
fn single_binding_group() -> TestCaseGroup {
    let formats_to_test = [
        // Formats with mandatory vertex input support.
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_SNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A8B8G8R8_SINT_PACK32,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::R16_UNORM,
        vk::Format::R16_SNORM,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UNORM,
        vk::Format::R16G16_SNORM,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16B16A16_SNORM,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32_UINT,
        vk::Format::R32G32B32_SINT,
        vk::Format::R32G32B32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        // 3-component formats do not have that feature as mandatory, but they are tried anyway.
        vk::Format::R8G8B8_UNORM,
        vk::Format::R8G8B8_SNORM,
        vk::Format::R8G8B8_UINT,
        vk::Format::R8G8B8_SINT,
        vk::Format::R16G16B16_UNORM,
        vk::Format::R16G16B16_SNORM,
        vk::Format::R16G16B16_UINT,
        vk::Format::R16G16B16_SINT,
        vk::Format::R16G16B16_SFLOAT,
    ];

    let mut single_group = TestCaseGroup::new("single_binding");
    for format in formats_to_test {
        single_group.add_child(single_binding_format_group(format));
    }
    single_group
}

/// The shader format `populateMultipleBindingsFormatGroup` picks for a format.
fn multi_binding_shader_format(format: vk::Format) -> ShaderFormat {
    let tcu_format = tcu_format_of(format);
    let fmt_class = tcu_format.channel_class();
    let vertex_bit_width = get_texture_format_bit_depth(tcu_format);
    let channel_count = tcu_format.order.num_used_channels() as usize;

    if format_class_is_float(fmt_class) {
        // Use a signed or unsigned format in the shader.
        return if format.as_raw() % 2 == 0 {
            ShaderFormat::SignedInt
        } else {
            ShaderFormat::UnsignedInt
        };
    }

    // For integer formats use floats if possible in the shader, or the alternative signed/unsigned variant if not.
    let integer_alternative = if fmt_class == TextureChannelClass::SignedInteger {
        ShaderFormat::UnsignedInt
    } else {
        ShaderFormat::SignedInt
    };
    if check_any(vertex_bit_width, channel_count, less_than_32_bits) {
        integer_alternative
    } else {
        ShaderFormat::Float
    }
}

/// `populateMultipleBindingsFormatGroup`
fn multiple_bindings_format_group(tuple: &[vk::Format]) -> TestCaseGroup {
    let group_name = tuple
        .iter()
        .map(|&format| format_name(format))
        .collect::<Vec<_>>()
        .join("_");
    let mut format_group = TestCaseGroup::new(group_name);

    for single_byte_stride in [false, true] {
        for attribute_offset in [0u32, 1] {
            for memory_offset in [0u32, 1] {
                let binding_params: Vec<BindingParams> = tuple
                    .iter()
                    .map(|&format| {
                        let format_size = tcu_format_of(format)
                            .pixel_size()
                            .expect("a vertex format has a pixel size");
                        let stride = if single_byte_stride { 1 } else { format_size };
                        BindingParams {
                            format,
                            shader_format: multi_binding_shader_format(format),
                            binding_stride: stride,
                            attribute_offset,
                            memory_offset,
                        }
                    })
                    .collect();

                for (use_dac, set_stride_with_dac, dac_suffix) in dac_variants() {
                    let params = LegacyVertexAttributesParams {
                        use_device_address_commands: use_dac,
                        set_stride_with_dac,
                        bindings: binding_params.clone(),
                    };

                    let stride_suffix = if single_byte_stride {
                        "stride_1_byte"
                    } else {
                        "stride_normal"
                    };
                    let ao_suffix = suffix_with_value("_attribute_offset_", attribute_offset);
                    let mo_suffix = suffix_with_value("_memory_offset_", memory_offset);
                    let name = format!("{stride_suffix}{ao_suffix}{mo_suffix}{dac_suffix}");
                    format_group.add_child(Box::new(LegacyVertexAttributesCase { name, params }) as Box<dyn TestCase>);
                }
            }
        }
    }

    format_group
}

/// `populateMultipleBindingsGroup`
fn multiple_bindings_group() -> TestCaseGroup {
    // A mix of components, numeric formats and bit widths.
    let format_tuples = [
        [
            vk::Format::R8_UNORM,
            vk::Format::R16G16_UINT,
            vk::Format::R32G32B32A32_SINT,
        ],
        [
            vk::Format::R32_SFLOAT,
            vk::Format::R16G16B16_SNORM,
            vk::Format::R8G8_UINT,
        ],
        [
            vk::Format::R32G32B32A32_SFLOAT,
            vk::Format::R16_SINT,
            vk::Format::R8G8_UNORM,
        ],
    ];

    let mut multi_group = TestCaseGroup::new("multi_binding");
    for tuple in &format_tuples {
        multi_group.add_child(multiple_bindings_format_group(tuple));
    }
    multi_group
}

/// `createLegacyVertexAttributesTests`
pub fn create_legacy_vertex_attributes_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("legacy_vertex_attributes");
    group.add_child(single_binding_group());
    group.add_child(multiple_bindings_group());
    group
}
