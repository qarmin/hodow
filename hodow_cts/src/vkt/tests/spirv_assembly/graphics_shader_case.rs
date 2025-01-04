// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmGraphicsShaderTestUtil.{hpp,cpp} (runAndVerifyDefaultPipeline)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the part of `runAndVerifyDefaultPipeline` the vertex plus fragment groups use is here: storage buffers
// as inputs (bindings 0..) and outputs (the bindings after them, filled with 0xff) visible to every graphics stage, the 12 vertices of the four corner
// triangles with the default colours, one 256x256 R8G8B8A8 colour attachment, the four corner pixels compared with a threshold of one and the output
// buffers compared with `verifyIO`. The colour arrays of the groups here are equal, so upstream's shuffle of them (the same permutation for both) is left out.
// Tessellation (patch lists of three) and geometry stages are there when the case has `tessc`/`tesse`/`geom` programs. Images, samplers, push constants, interfaces, specialization constants are not. `splitRenderArea` is: 16 passes of a 64x64 scissored area, each its own submission, in a render pass that keeps the contents of the others. The requirements
// of a case (features, extensions, SPIR-V version, float controls) are a `ComputeShaderSpec`, checked by the compute case's `check_support`.

use vulkanalia::prelude::v1_0::*;

use super::compute_shader_case::{ComputeShaderSpec, SpvAsmComputeShaderCase};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestInstance};

const RENDER_SIZE: u32 = 256;
const QUARTER_RENDER_SIZE: u32 = 64;
const CLEAR_COLOR: [f32; 4] = [0.125, 0.25, 0.75, 1.0];
/// `getDefaultColors`: white, red, green and blue.
const DEFAULT_COLORS: [[u8; 4]; 4] = [
    [255, 255, 255, 255],
    [255, 0, 0, 255],
    [0, 255, 0, 255],
    [0, 0, 255, 255],
];

/// `SpvAsmGraphicsShaderCase`: the programs are `vert` and `frag`.
pub struct SpvAsmGraphicsShaderCase {
    pub name: String,
    pub spec: ComputeShaderSpec,
    pub programs: BinaryCollection,
}

impl TestCase for SpvAsmGraphicsShaderCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `defaultCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let requirements = SpvAsmComputeShaderCase {
            name: self.name.clone(),
            spec: self.spec.clone(),
            programs: self.programs,
        };
        requirements.check_support(context)?;
        let features = context.get_device_features();
        if self.programs.contains("geom") && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry not supported".to_string()));
        }
        if (self.programs.contains("tessc") || self.programs.contains("tesse"))
            && features.tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported("Tessellation not supported".to_string()));
        }
        if !self.spec.outputs.is_empty() && features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "vertexPipelineStoresAndAtomics not supported".to_string(),
            ));
        }
        if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SpvAsmGraphicsShaderInstance {
            context,
            spec: &self.spec,
        })
    }
}

pub(super) struct SpvAsmGraphicsShaderInstance<'a> {
    pub(super) context: &'a Context<'a>,
    pub(super) spec: &'a ComputeShaderSpec,
}

/// The render pass of the split render area: it keeps what an earlier pass drew, which `make_render_pass` (initial layout undefined) is free to discard;
/// the first pass moves the image to the attachment layout by a barrier.
fn make_split_render_pass(device: &Device, color_format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    let attachments = [attachment];
    let color_ref = vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    let color_refs = [color_ref];
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs);
    let subpasses = [subpass];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

fn colors_match(pixel: [u8; 4], expected: [u8; 4]) -> bool {
    (0..4).all(|channel| pixel[channel].abs_diff(expected[channel]) <= 1)
}

impl TestInstance for SpvAsmGraphicsShaderInstance<'_> {
    /// `runAndVerifyDefaultPipeline`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let spec = self.spec;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue_family_index = context.get_universal_queue_family_index();
        let num_inputs = spec.inputs.len();

        let host_buffer = |bytes: usize, usage: vk::BufferUsageFlags| {
            BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(bytes as vk::DeviceSize, usage),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let fill = |buffer: &BufferWithMemory<'_>, bytes: &[u8]| -> Result<(), TestError> {
            unsafe {
                std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len())
            };
            flush_alloc(device, buffer.get_allocation())
        };

        // The twelve vertices: a position and a colour each, in the corner triangles of the render area.
        let corners: [[[f32; 2]; 3]; 4] = [
            [[-1.0, -1.0], [-0.5, -1.0], [-1.0, -0.5]],
            [[0.5, -1.0], [1.0, -1.0], [1.0, -0.5]],
            [[-1.0, 0.5], [-0.5, 1.0], [-1.0, 1.0]],
            [[1.0, 0.5], [1.0, 1.0], [0.5, 1.0]],
        ];
        let (input_colors, output_colors) = spec.graphics_colors.unwrap_or((DEFAULT_COLORS, DEFAULT_COLORS));
        let mut vertex_bytes = Vec::new();
        for (corner, positions) in corners.iter().enumerate() {
            let color = input_colors[corner].map(|channel| f32::from(channel) / 255.0);
            for position in positions {
                for value in [position[0], position[1], 0.0, 1.0].into_iter().chain(color) {
                    vertex_bytes.extend_from_slice(&value.to_ne_bytes());
                }
            }
        }
        let vertex_buffer = host_buffer(vertex_bytes.len(), vk::BufferUsageFlags::VERTEX_BUFFER)?;
        fill(&vertex_buffer, &vertex_bytes)?;

        let input_usage = if spec.uniform_inputs {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };
        let input_descriptor_type = if spec.uniform_inputs {
            vk::DescriptorType::UNIFORM_BUFFER
        } else {
            vk::DescriptorType::STORAGE_BUFFER
        };
        let mut input_buffers = Vec::new();
        for input in &spec.inputs {
            let buffer = host_buffer(input.len(), input_usage)?;
            fill(&buffer, input)?;
            input_buffers.push(buffer);
        }
        let mut output_buffers = Vec::new();
        for output in &spec.outputs {
            let buffer = host_buffer(output.len(), vk::BufferUsageFlags::STORAGE_BUFFER)?;
            fill(&buffer, &vec![0xffu8; output.len()])?;
            output_buffers.push(buffer);
        }

        let image_size_bytes = u64::from(RENDER_SIZE * RENDER_SIZE * 4);
        let read_buffer = host_buffer(image_size_bytes as usize, vk::BufferUsageFlags::TRANSFER_DST)?;

        let color_format = vk::Format::R8G8B8A8_UNORM;
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: color_format,
            extent: vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
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
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, color_format, range)?;
        let split = spec.split_render_area;
        let render_pass = if split {
            make_split_render_pass(device, color_format)?
        } else {
            make_render_pass(device, color_format)?
        };
        let framebuffer = make_framebuffer(device, *render_pass, &[*view], RENDER_SIZE, RENDER_SIZE, 1)?;

        // One binding per input, then one per output, every one a storage buffer.
        let num_resources = num_inputs + spec.outputs.len();
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        let mut pool_builder = DescriptorPoolBuilder::new();
        for binding in 0..num_resources {
            let descriptor_type = if binding < num_inputs {
                input_descriptor_type
            } else {
                vk::DescriptorType::STORAGE_BUFFER
            };
            layout_builder = layout_builder.add_single_binding(descriptor_type, vk::ShaderStageFlags::ALL_GRAPHICS);
            pool_builder = pool_builder.add_type(descriptor_type, 1);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let infos: Vec<vk::DescriptorBufferInfo> = input_buffers
            .iter()
            .zip(&spec.inputs)
            .chain(output_buffers.iter().zip(&spec.outputs))
            .map(|(buffer, bytes)| vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: bytes.len() as vk::DeviceSize,
            })
            .collect();
        let writes: Vec<vk::WriteDescriptorSet> = infos
            .iter()
            .enumerate()
            .map(|(binding, info)| vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: binding as u32,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: if binding < num_inputs {
                    input_descriptor_type
                } else {
                    vk::DescriptorType::STORAGE_BUFFER
                },
                image_info: std::ptr::null(),
                buffer_info: std::ptr::from_ref(info),
                texel_buffer_view: std::ptr::null(),
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let set_layouts = [*descriptor_set_layout];
        let push_constant_ranges: Vec<vk::PushConstantRange> = if spec.push_constants.is_empty() {
            Vec::new()
        } else {
            vec![vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::ALL_GRAPHICS,
                offset: 0,
                size: spec.push_constants.len() as u32,
            }]
        };
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        if let (true, Some(minor)) = (spec.check_graphics_versions, spec.spirv_version_minor) {
            for name in ["vert", "tessc", "tesse", "geom", "frag"] {
                if binaries.contains(name)
                    && binaries.get(name)?.spirv.get(1).copied() != Some(0x0001_0000 | (minor << 8))
                {
                    return Ok(TestStatus::fail("Binary SPIR-V version is different from requested"));
                }
            }
        }
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let has_tessellation = binaries.contains("tessc") && binaries.contains("tesse");
        let tessc_module = if has_tessellation {
            Some(create_shader_module(device, binaries.get("tessc")?)?)
        } else {
            None
        };
        let tesse_module = if has_tessellation {
            Some(create_shader_module(device, binaries.get("tesse")?)?)
        } else {
            None
        };
        let geom_module = if binaries.contains("geom") {
            Some(create_shader_module(device, binaries.get("geom")?)?)
        } else {
            None
        };
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let (Some(tessc), Some(tesse)) = (&tessc_module, &tesse_module) {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tessc));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tesse));
        }
        if let Some(geom) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geom));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        let topology = if has_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let mut state = DrawPipelineState::new(topology).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        if has_tessellation {
            state.patch_control_points = Some(3);
        }
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        state.rasterization.depth_bias_enable = vk::FALSE;
        if split {
            state.dynamic_states = vec![vk::DynamicState::SCISSOR];
        }
        if spec.uses_64bit_indexing {
            state.create_flags2 = Some(vk::PipelineCreateFlags2::_64_BIT_INDEXING_EXT);
        }
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let num_render_segments: i32 = if split { 4 } else { 1 };
        let render_dimension: u32 = if split { QUARTER_RENDER_SIZE } else { RENDER_SIZE };
        let mut first_pass = true;
        for segment_x in 0..num_render_segments {
            for segment_y in 0..num_render_segments {
                begin_command_buffer(device, cmd)?;
                if split && first_pass {
                    let vert_flush_barrier = vk::MemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::HOST_WRITE)
                        .dst_access_mask(vk::AccessFlags::VERTEX_ATTRIBUTE_READ)
                        .build();
                    let to_attachment = make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        image.get(),
                        range,
                    );
                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd,
                            vk::PipelineStageFlags::HOST,
                            vk::PipelineStageFlags::ALL_GRAPHICS,
                            vk::DependencyFlags::empty(),
                            &[vert_flush_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[to_attachment],
                        );
                    }
                }
                let render_area = make_rect_2d(
                    segment_x * render_dimension as i32,
                    segment_y * render_dimension as i32,
                    render_dimension,
                    render_dimension,
                );
                if split {
                    unsafe { device.cmd_set_scissor(cmd, 0, &[render_area]) };
                }
                begin_render_pass(
                    device,
                    cmd,
                    *render_pass,
                    *framebuffer,
                    render_area,
                    clear_value_color(CLEAR_COLOR),
                );
                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    if !spec.push_constants.is_empty() {
                        device.cmd_push_constants(
                            cmd,
                            *pipeline_layout,
                            vk::ShaderStageFlags::ALL_GRAPHICS,
                            0,
                            &spec.push_constants,
                        );
                    }
                    if num_resources != 0 {
                        device.cmd_bind_descriptor_sets(
                            cmd,
                            vk::PipelineBindPoint::GRAPHICS,
                            *pipeline_layout,
                            0,
                            &[descriptor_set.get()],
                            &[] as &[u32],
                        );
                    }
                    device.cmd_draw(cmd, 12, 1, 0, 0);
                }
                end_render_pass(device, cmd);

                if segment_x == num_render_segments - 1 && segment_y == num_render_segments - 1 {
                    let to_transfer = make_image_memory_barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        image.get(),
                        range,
                    );
                    let copy_region = make_buffer_image_copy(
                        vk::Extent3D {
                            width: RENDER_SIZE,
                            height: RENDER_SIZE,
                            depth: 1,
                        },
                        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                    );
                    let to_host = make_buffer_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::HOST_READ,
                        read_buffer.get(),
                        0,
                        image_size_bytes,
                    );
                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd,
                            vk::PipelineStageFlags::ALL_GRAPHICS,
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
                            read_buffer.get(),
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
                }
                end_command_buffer(device, cmd)?;
                submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
                first_pass = false;
            }
        }

        invalidate_alloc(device, read_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                read_buffer.get_allocation().get_host_ptr().cast_const(),
                image_size_bytes as usize,
            )
        };
        let pixel = |x: u32, y: u32| -> [u8; 4] {
            let offset = ((y * RENDER_SIZE + x) * 4) as usize;
            [
                pixels[offset],
                pixels[offset + 1],
                pixels[offset + 2],
                pixels[offset + 3],
            ]
        };
        let fail = |message: &str| -> TestOutcome { Ok(TestStatus::new(spec.fail_result, message)) };
        let checks = [
            (pixel(1, 1), output_colors[0], "Upper left corner mismatch"),
            (
                pixel(RENDER_SIZE - 1, 1),
                output_colors[1],
                "Upper right corner mismatch",
            ),
            (
                pixel(1, RENDER_SIZE - 1),
                output_colors[2],
                "Lower left corner mismatch",
            ),
            (
                pixel(RENDER_SIZE - 1, RENDER_SIZE - 1),
                output_colors[3],
                "Lower right corner mismatch",
            ),
        ];
        for (got, expected, message) in checks {
            if !colors_match(got, expected) {
                return fail(message);
            }
        }

        let mut results = Vec::new();
        for (output, expected) in output_buffers.iter().zip(&spec.outputs) {
            invalidate_alloc(device, output.get_allocation())?;
            results.push(
                unsafe {
                    std::slice::from_raw_parts(output.get_allocation().get_host_ptr().cast_const(), expected.len())
                }
                .to_vec(),
            );
        }
        let matches = match spec.verify_io {
            Some(verify) => verify(&spec.inputs, &results, &spec.outputs),
            None => results
                .iter()
                .zip(&spec.outputs)
                .enumerate()
                .all(
                    |(output_ndx, (result, expected))| match spec.output_masks.get(output_ndx) {
                        Some(mask) if !mask.is_empty() => result
                            .iter()
                            .zip(expected)
                            .zip(mask)
                            .all(|((result, expected), mask)| result & mask == expected & mask),
                        _ => result == expected,
                    },
                ),
        };
        if !matches {
            return fail(spec.fail_message);
        }
        Ok(TestStatus::pass("Output matches expected"))
    }
}
