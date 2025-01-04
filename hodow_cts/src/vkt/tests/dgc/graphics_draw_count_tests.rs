// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsDrawCountTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are pre-expanded in `shaders/manifest/dgc_graphics_draw_count.toml`
// (`scripts/gen_dgc_graphics_draw_count_manifest.py`), one set per (execution set, checkDrawParams). Pipelines (`pipelines*`) and shader objects
// (`shader_objects*`) are ported. When only the fragment set is needed (no execution set)
// the vertex descriptor set is still allocated (empty layout) and bound, where upstream binds a null handle for it.
//
// Mechanism (see the long comment upstream): 1024 triangles, one per pixel of a 32x32 framebuffer, divided in 16 pseudorandom chunks
// drawn by 4 sequences with draw count tokens, with execution sets switching shader variants that read different storage buffers and pass
// a different amount of IO variables.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_graphics_draw_count::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout_with_push_constants, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, DrawPipeline, PipelineOptions, StageModules, bind_shader_object_state, bind_shaders_with_nulls,
    build_draw_pipeline, copy_image_to_buffer, float_threshold_compare, push_back_element, write_host_buffer,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, create_dgc_shader, device_generated_commands_properties, preprocess_to_execute_barrier_ext,
};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, end_rendering};
use crate::vkt::tests::shader_object::util::{ShaderObject, create_shader, shader_create_info};
use crate::vkt::{Context, TestCase, TestInstance};

const SEQUENCE_COUNT: u32 = 4;
const PER_TRIANGLE_VERTICES: u32 = 3;
const MAX_INSTANCE_INDEX: u32 = 255;
const VERTEX_CHUNK_OFFSET: u32 = 1000;
const CHUNK_COUNT: u32 = 16;
const FB_SIZE: u32 = 32;
/// Each "pipeline" of shader objects contains a vertex and a fragment shader.
const SHADER_SET_STAGES: u32 = 2;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    DrawCount,
    DrawIndexedCount,
    /// Same as the previous one, but using an index buffer token.
    DrawIndexedCountIndexToken,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PreprocessType {
    None,
    SameStateCmdBuffer,
    OtherStateCmdBuffer,
}

#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    preprocess_type: PreprocessType,
    check_draw_params: bool,
    use_execution_set: bool,
    shader_objects: bool,
    unordered_sequences: bool,
    draw_count_is_zero: bool,
}

impl TestParams {
    fn random_seed(&self) -> u32 {
        // Other members not used because we want to make sure results don't change if we use the same pseudorandom sequence.
        ((self.test_type as u32) << 26)
            | (u32::from(self.use_execution_set) << 25)
            | (u32::from(self.shader_objects) << 24)
            | u32::from(self.check_draw_params)
    }

    fn do_preprocess(&self) -> bool {
        self.preprocess_type != PreprocessType::None
    }

    fn indexed_draws(&self) -> bool {
        matches!(
            self.test_type,
            TestType::DrawIndexedCount | TestType::DrawIndexedCountIndexToken
        )
    }

    fn index_buffer_token(&self) -> bool {
        self.test_type == TestType::DrawIndexedCountIndexToken
    }

    fn program_key(&self) -> String {
        format!(
            "draw_count_{}_{}",
            if self.use_execution_set { "es" } else { "noes" },
            if self.check_draw_params { "dp" } else { "nodp" }
        )
    }
}

struct DrawCountCase {
    name: String,
    params: TestParams,
}

impl TestCase for DrawCountCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkDrawCountSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let bind_stages = if params.use_execution_set {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };

        let (bind_stages_pipeline, bind_stages_shader_object) = if params.shader_objects {
            (vk::ShaderStageFlags::empty(), bind_stages)
        } else {
            (bind_stages, vk::ShaderStageFlags::empty())
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_stages_pipeline,
            bind_stages_shader_object,
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;

        let dgc_properties = device_generated_commands_properties(context);
        if dgc_properties.device_generated_commands_multi_draw_indirect_count == vk::FALSE {
            return Err(TestError::NotSupported(
                "deviceGeneratedCommandsMultiDrawIndirectCount not supported".to_string(),
            ));
        }

        if params.shader_objects {
            context.require_device_functionality("VK_EXT_shader_object")?;
            if params.use_execution_set && dgc_properties.max_indirect_shader_object_count == 0 {
                return Err(TestError::NotSupported(
                    "maxIndirectShaderObjectCount is zero".to_string(),
                ));
            }
        }

        let features = context.get_device_features();
        if features.shader_clip_distance == vk::FALSE || features.shader_cull_distance == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderClipDistance or shaderCullDistance not supported".to_string(),
            ));
        }

        if params.check_draw_params {
            context.require_device_functionality("VK_KHR_shader_draw_parameters")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.params.program_key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawCountInstance {
            context,
            params: self.params,
        })
    }
}

/// `getInputBuffers`: 8 odd positive numbers, 12 even positive, 16 odd negative and 20 even negative ones.
fn get_input_buffers() -> Vec<Vec<i32>> {
    let buffer_sizes = [8usize, 12, 16, 20];
    let range_starts = [0i32, 1, -2, -1];
    let range_steps = [2i32, 2, -2, -2];
    (0..SEQUENCE_COUNT as usize)
        .map(|i| {
            (0..buffer_sizes[i])
                .map(|j| range_starts[i] + range_steps[i] * j as i32)
                .collect()
        })
        .collect()
}

fn struct_bytes<T: Copy>(value: &T) -> &[u8] {
    // SAFETY: `value` is a live value of `size_of::<T>()` bytes; the Vulkan command structures have no padding.
    unsafe { std::slice::from_raw_parts((value as *const T).cast::<u8>(), std::mem::size_of::<T>()) }
}

struct SequenceInfo<'a> {
    buffer: DgcBuffer<'a>,
    chunk_count: u32,
    stride: u32,
    vertex_count: u32,
}

/// The descriptor sets of the execution set and draw parameters checks.
struct Descriptors<'a> {
    vert_set: UniqueDescriptorSet<'a>,
    frag_set: UniqueDescriptorSet<'a>,
    _pool: Unique<'a, vk::DescriptorPool>,
    vert_layout: Unique<'a, vk::DescriptorSetLayout>,
    frag_layout: Unique<'a, vk::DescriptorSetLayout>,
    _buffers: Vec<BufferWithMemory<'a>>,
}

fn make_descriptors<'a>(
    context: &'a Context<'a>,
    params: &TestParams,
    input_buffers: &[Vec<i32>],
    frag_data: &[Vec<u8>],
) -> Result<Descriptors<'a>, TestError> {
    let device = context.get_device();
    let desc_type = vk::DescriptorType::STORAGE_BUFFER;
    let input_buffer_count = input_buffers.len() as u32;

    // Frag shader will always use set 1, so set 0 can be empty.
    let mut vert_layout_builder = DescriptorSetLayoutBuilder::new();
    if params.use_execution_set {
        for _ in 0..input_buffer_count {
            vert_layout_builder = vert_layout_builder.add_single_binding(desc_type, vk::ShaderStageFlags::VERTEX);
        }
    }
    let vert_layout = vert_layout_builder.build(device)?;

    let mut frag_layout_builder = DescriptorSetLayoutBuilder::new();
    for _ in frag_data {
        frag_layout_builder = frag_layout_builder.add_single_binding(desc_type, vk::ShaderStageFlags::FRAGMENT);
    }
    let frag_layout = frag_layout_builder.build(device)?;

    let pool = DescriptorPoolBuilder::new()
        .add_type(desc_type, input_buffer_count + frag_data.len() as u32)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
    let vert_set = make_descriptor_set(device, *pool, *vert_layout)?;
    let frag_set = make_descriptor_set(device, *pool, *frag_layout)?;

    let mut buffers = Vec::new();
    for input_buffer in input_buffers {
        buffers.push(create_host_buffer(
            context,
            input_buffer,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        )?);
    }
    let vert_buffer_count = buffers.len();
    for data in frag_data {
        buffers.push(create_host_buffer(context, data, vk::BufferUsageFlags::STORAGE_BUFFER)?);
    }

    // Update descriptors with each buffer.
    let mut update_builder = DescriptorSetUpdateBuilder::new();
    for (i, buffer) in buffers.iter().enumerate() {
        let buffer_info = make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE);
        if i < vert_buffer_count {
            update_builder =
                update_builder.write_single(vert_set.get(), Location::binding(i as u32), desc_type, &buffer_info);
        } else {
            update_builder = update_builder.write_single(
                frag_set.get(),
                Location::binding((i - vert_buffer_count) as u32),
                desc_type,
                &buffer_info,
            );
        }
    }
    update_builder.update(device);

    Ok(Descriptors {
        vert_set,
        frag_set,
        _pool: pool,
        vert_layout,
        frag_layout,
        _buffers: buffers,
    })
}

struct DrawCountInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for DrawCountInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let pixel_count = FB_SIZE * FB_SIZE;
        let chunk_max_pixels = (pixel_count / CHUNK_COUNT) as i32; // Does not apply to the last chunk.
        let max_indirect_draws = (CHUNK_COUNT / SEQUENCE_COUNT) as i32; // Per draw count dispatch. Doesn't apply to last.
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let indexed = params.indexed_draws();
        let non_indexed_draws = params.test_type == TestType::DrawCount;

        // Pseudorandom number generator.
        let mut rnd = Random::new(params.random_seed());

        // Generate one triangle around the center of each pixel.
        let pixel_width = 2.0f32 / FB_SIZE as f32;
        let pixel_height = 2.0f32 / FB_SIZE as f32;
        let hor_margin = pixel_width / 4.0;
        let ver_margin = pixel_height / 4.0;

        // Converts to framebuffer range [-1,1]
        let normalize = |v: u32, total: u32| ((v as f32 + 0.5) / total as f32) * 2.0 - 1.0;

        // These will be chosen pseudorandomly for each pixel.
        let clip_distances = [0.75f32, 0.0, -0.5, 1.25, 20.0, 2.0, 0.25, 1.0];
        let cull_distances = [0.75f32, 0.0, 0.5, 1.25, 20.0, 2.0, -0.25, 1.0];
        let last_clip = clip_distances.len() as i32 - 1;
        let last_cull = cull_distances.len() as i32 - 1;

        // Vertex buffer data: position and extra data (clip distance, cull distance).
        let mut vertices: Vec<[f32; 8]> = Vec::with_capacity((pixel_count * PER_TRIANGLE_VERTICES) as usize);
        for y in 0..FB_SIZE {
            for x in 0..FB_SIZE {
                let x_center = normalize(x, FB_SIZE);
                let y_center = normalize(y, FB_SIZE);

                let clip = clip_distances[rnd.get_int(0, last_clip) as usize];
                let cull = cull_distances[rnd.get_int(0, last_cull) as usize];
                let extra = [clip, cull, 0.0, 0.0];

                for position in [
                    [x_center - hor_margin, y_center + ver_margin, 0.0, 1.0],
                    [x_center + hor_margin, y_center + ver_margin, 0.0, 1.0],
                    [x_center, y_center - ver_margin, 0.0, 1.0],
                ] {
                    vertices.push([
                        position[0],
                        position[1],
                        position[2],
                        position[3],
                        extra[0],
                        extra[1],
                        extra[2],
                        extra[3],
                    ]);
                }
            }
        }

        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Divide pixels in chunks of pseudorandom sizes.
        let mut chunk_sizes = vec![0u32; CHUNK_COUNT as usize];
        {
            let mut total = 0u32;
            for chunk in chunk_sizes.iter_mut().take(CHUNK_COUNT as usize - 1) {
                let chunk_size = rnd.get_int(1, chunk_max_pixels) as u32;
                *chunk = chunk_size;
                total += chunk_size;
            }
            // Last chunk contains the remaining pixels.
            chunk_sizes[CHUNK_COUNT as usize - 1] = pixel_count - total;
        }

        // Draw operation per chunk.
        let mut chunk_draws: Vec<vk::DrawIndirectCommand> = Vec::new();
        let mut chunk_indexed_draws: Vec<vk::DrawIndexedIndirectCommand> = Vec::new();
        {
            let max_instance_count = 16;
            let first_instances: Vec<u32> = (0..16u32).map(|i| i * 16).collect();

            let mut prev_pixels = 0u32;
            for i in 0..CHUNK_COUNT {
                let chunk_size = chunk_sizes[i as usize];

                let vertex_count = chunk_size * PER_TRIANGLE_VERTICES;
                let instance_count = rnd.get_int(1, max_instance_count) as u32;
                let first_vertex = prev_pixels * PER_TRIANGLE_VERTICES;
                let first_instance = first_instances[rnd.get_int(0, first_instances.len() as i32 - 1) as usize];
                let chunk_offset = VERTEX_CHUNK_OFFSET + i;

                if non_indexed_draws {
                    chunk_draws.push(vk::DrawIndirectCommand {
                        vertex_count,
                        instance_count,
                        first_vertex,
                        first_instance,
                    });
                } else {
                    chunk_indexed_draws.push(vk::DrawIndexedIndirectCommand {
                        index_count: vertex_count,
                        instance_count,
                        first_index: first_vertex,
                        vertex_offset: -(chunk_offset as i32),
                        first_instance,
                    });
                }

                prev_pixels += chunk_size;
            }
        }

        // Create indirect buffers for the sequences.
        let mut sequence_infos: Vec<SequenceInfo<'_>> = Vec::with_capacity(SEQUENCE_COUNT as usize);
        {
            let mut prev_chunks = 0u32;
            for i in 0..SEQUENCE_COUNT {
                let seq_chunks = if i < SEQUENCE_COUNT - 1 {
                    rnd.get_int(1, max_indirect_draws) as u32
                } else {
                    CHUNK_COUNT - prev_chunks
                };
                let extra_padding = rnd.get_int(0, 7) as u32;
                let total_structs = extra_padding + 1;
                let struct_size = if non_indexed_draws {
                    std::mem::size_of::<vk::DrawIndirectCommand>() as u32
                } else {
                    std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32
                };
                let stride = total_structs * struct_size;
                let buffer_size = stride * seq_chunks;

                let buffer = DgcBuffer::new(
                    context,
                    vk::DeviceSize::from(buffer_size),
                    vk::BufferUsageFlags::empty(),
                    MemoryRequirement::HOST_VISIBLE,
                )?;

                // Copy indirect commands to the buffer.
                let mut buffer_data = vec![0u8; buffer_size as usize];
                let mut vertex_count = 0u32;
                for j in 0..seq_chunks {
                    let chunk_idx = (prev_chunks + j) as usize;
                    let dst = (stride * j) as usize;
                    let (src, chunk_vertex_count) = if non_indexed_draws {
                        (
                            struct_bytes(&chunk_draws[chunk_idx]),
                            chunk_draws[chunk_idx].vertex_count,
                        )
                    } else {
                        (
                            struct_bytes(&chunk_indexed_draws[chunk_idx]),
                            chunk_indexed_draws[chunk_idx].index_count,
                        )
                    };
                    buffer_data[dst..dst + struct_size as usize].copy_from_slice(src);
                    vertex_count += chunk_vertex_count;
                }
                {
                    let alloc = buffer.get_allocation();
                    // SAFETY: the buffer was created with `buffer_size` bytes.
                    unsafe {
                        std::ptr::copy_nonoverlapping(buffer_data.as_ptr(), alloc.get_host_ptr(), buffer_data.len())
                    };
                    flush_alloc(device, alloc)?;
                }

                sequence_infos.push(SequenceInfo {
                    buffer,
                    chunk_count: seq_chunks,
                    stride,
                    vertex_count,
                });
                prev_chunks += seq_chunks;
            }
        }

        // Index buffer if needed. For indexed draws, we're going to draw vertices in reverse order, which means storing indices in
        // reverse order in the index buffer. In addition, to check that vertexOffset is correctly read per draw, we're going to apply an
        // offset to the index values stored in each chunk, with the offset being slightly different in each chunk.
        let mut indices: Vec<u32> = Vec::new();
        let mut index_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        if indexed {
            let extra_usage = if params.index_buffer_token() {
                vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
            } else {
                vk::BufferUsageFlags::empty()
            };
            let extra_mem = if params.index_buffer_token() {
                MemoryRequirement::DEVICE_ADDRESS
            } else {
                MemoryRequirement::ANY
            };

            // Indices in reverse order.
            let mut processed_count = 0u32;
            for (i, &chunk_size) in chunk_sizes.iter().enumerate() {
                let chunk_vertex_count = chunk_size * PER_TRIANGLE_VERTICES;
                let chunk_vertex_offset = VERTEX_CHUNK_OFFSET + i as u32; // Varies a bit per chunk.
                for j in 0..chunk_vertex_count {
                    let forward_index = processed_count + j;
                    let reverse_index = vertices.len() as u32 - 1 - forward_index;
                    indices.push(reverse_index + chunk_vertex_offset);
                }
                processed_count += chunk_vertex_count;
            }
            debug_assert_eq!(vertices.len(), indices.len());

            let index_buffer_size = std::mem::size_of_val(indices.as_slice()) as vk::DeviceSize;

            // Store indices in one or more index buffers. When using index buffers, all buffers will be the same size but each buffer
            // will only contain the appropriate chunks of real data and the rest will be zero-ed out.
            let index_chunks: Vec<u32> = if params.test_type == TestType::DrawIndexedCount {
                vec![pixel_count * PER_TRIANGLE_VERTICES]
            } else {
                sequence_infos.iter().map(|seq| seq.vertex_count).collect()
            };

            processed_count = 0;
            for &chunk_index_count in &index_chunks {
                let index_buffer = BufferWithMemory::new(
                    device,
                    context.get_default_allocator(),
                    make_buffer_create_info(index_buffer_size, vk::BufferUsageFlags::INDEX_BUFFER | extra_usage),
                    MemoryRequirement::HOST_VISIBLE | extra_mem,
                )?;

                // Zero-out the whole buffer first, then copy the chunk to its own index buffer.
                let mut data = vec![0u32; indices.len()];
                let begin = processed_count as usize;
                let end = begin + chunk_index_count as usize;
                data[begin..end].copy_from_slice(&indices[begin..end]);
                write_host_buffer(device, &index_buffer, &data)?;
                index_buffers.push(index_buffer);

                processed_count += chunk_index_count;
            }
        }

        // Create token data for the draw count tokens.
        let mut draw_token_data: Vec<vk::DrawIndirectCountIndirectCommandEXT> = Vec::new();
        let mut max_draw_count = 0u32;
        for seq_info in &sequence_infos {
            draw_token_data.push(vk::DrawIndirectCountIndirectCommandEXT {
                buffer_address: seq_info.buffer.get_device_address(),
                stride: seq_info.stride,
                command_count: if params.draw_count_is_zero {
                    0
                } else {
                    seq_info.chunk_count
                },
            });
            max_draw_count = max_draw_count.max(seq_info.chunk_count);
        }
        if rnd.get_bool() {
            max_draw_count *= 2;
        }

        // Create token data for the index buffer tokens, if used.
        let mut index_buffer_token_data: Vec<vk::BindIndexBufferIndirectCommandEXT> = Vec::new();
        if params.index_buffer_token() {
            for index_buffer in index_buffers.iter().take(SEQUENCE_COUNT as usize) {
                index_buffer_token_data.push(vk::BindIndexBufferIndirectCommandEXT {
                    buffer_address: buffer_device_address(device, index_buffer.get()),
                    size: std::mem::size_of_val(indices.as_slice()) as u32,
                    index_type: vk::IndexType::UINT32,
                });
            }
        }

        // Color framebuffer.
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_buffer = ImageWithBuffer::new(context, FB_SIZE, FB_SIZE, color_format, color_usage, 4)?;

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], FB_SIZE, FB_SIZE, 1)?;

        // Input buffers and descriptor sets. Used with execution sets and draw parameters checks.
        let input_buffers = if params.use_execution_set {
            get_input_buffers()
        } else {
            Vec::new()
        };

        // Only used with execution sets.
        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 8,
        };
        let pc_data: [u32; 2] = [FB_SIZE, FB_SIZE];

        let use_sets = params.use_execution_set || params.check_draw_params;
        let descriptors = if use_sets {
            let mut frag_data: Vec<Vec<u8>> = Vec::new();

            if params.use_execution_set {
                // Calculate expected accumulated values.
                let mut expected_accums = vec![0i32; pixel_count as usize]; // Accumulated values for each pixel.
                let mut seq_sizes_in_pixels = vec![0u32; input_buffers.len()]; // Number of pixels in each sequence.

                let mut prev_chunks = 0u32;
                for (seq_idx, seq_info) in sequence_infos.iter().enumerate() {
                    let mut seq_pixels = 0u32;
                    for i in 0..seq_info.chunk_count {
                        seq_pixels += chunk_sizes[(prev_chunks + i) as usize];
                    }
                    seq_sizes_in_pixels[seq_idx] = seq_pixels;
                    prev_chunks += seq_info.chunk_count;
                }

                // Using the accumulated values for each input buffer and the number of pixels in each sequence, set the expected
                // accumulated value in each pixel.
                let buffer_accums: Vec<i32> = input_buffers.iter().map(|buffer| buffer.iter().sum()).collect();
                let mut prev_pixels = 0u32;
                for (i, &seq_pixels) in seq_sizes_in_pixels.iter().enumerate() {
                    for j in 0..seq_pixels {
                        expected_accums[(prev_pixels + j) as usize] = buffer_accums[i];
                    }
                    prev_pixels += seq_pixels;
                }

                // Indexed draws happen in reverse order.
                if indexed {
                    expected_accums.reverse();
                }
                frag_data.push(
                    expected_accums
                        .iter()
                        .flat_map(|value| value.to_ne_bytes())
                        .collect::<Vec<u8>>(),
                );
            }

            if params.check_draw_params {
                let mut expected_draw_indices: Vec<[i32; 4]> = Vec::with_capacity(pixel_count as usize);

                let mut prev_chunks = 0u32;
                for seq_info in &sequence_infos {
                    let mut draw_idx = 0i32; // Resets at the start of each sequence.
                    for j in 0..seq_info.chunk_count {
                        let chunk_idx = (prev_chunks + j) as usize;
                        let chunk_size = chunk_sizes[chunk_idx];
                        let (base_vertex, base_instance) = if non_indexed_draws {
                            (
                                chunk_draws[chunk_idx].first_vertex as i32,
                                chunk_draws[chunk_idx].first_instance as i32,
                            )
                        } else {
                            (
                                chunk_indexed_draws[chunk_idx].vertex_offset,
                                chunk_indexed_draws[chunk_idx].first_instance as i32,
                            )
                        };
                        for _ in 0..chunk_size {
                            expected_draw_indices.push([draw_idx, base_vertex, base_instance, 0]);
                        }
                        draw_idx += 1; // Increases with each draw.
                    }
                    prev_chunks += seq_info.chunk_count;
                }

                // Indexed draws happen in reverse order.
                if indexed {
                    expected_draw_indices.reverse();
                }
                frag_data.push(
                    expected_draw_indices
                        .iter()
                        .flat_map(|value| value.iter().flat_map(|component| component.to_ne_bytes()))
                        .collect::<Vec<u8>>(),
                );
            }

            Some(make_descriptors(context, &params, &input_buffers, &frag_data)?)
        } else {
            None
        };

        let set_layouts: Vec<vk::DescriptorSetLayout> = descriptors
            .as_ref()
            .map(|descriptors| vec![*descriptors.vert_layout, *descriptors.frag_layout])
            .unwrap_or_default();
        let pc_ranges: Vec<vk::PushConstantRange> = if use_sets { vec![pc_range] } else { Vec::new() };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &set_layouts, &pc_ranges)?;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let shader_set_count = if params.use_execution_set { SEQUENCE_COUNT } else { 1 };
        let mut vert_modules = Vec::new();
        let mut frag_modules = Vec::new();
        for i in 0..shader_set_count {
            let suffix = if params.use_execution_set {
                i.to_string()
            } else {
                String::new()
            };
            vert_modules.push(create_shader_module(device, binaries.get(&format!("vert{suffix}"))?)?);
            frag_modules.push(create_shader_module(device, binaries.get(&format!("frag{suffix}"))?)?);
        }

        let mut pipelines: Vec<DrawPipeline<'_>> = Vec::new();
        for i in 0..(if params.shader_objects {
            0
        } else {
            shader_set_count as usize
        }) {
            pipelines.push(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_modules[i],
                    tesc: None,
                    tese: None,
                    geom: None,
                    frag: *frag_modules[i],
                },
                &PipelineOptions {
                    extent: (FB_SIZE, FB_SIZE),
                    topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                    patch_control_points: 0,
                    dynamic_stride: false,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: true,
                    indirect_bindable: params.use_execution_set,
                    construction: Construction::Monolithic,
                    depth_test: false,
                    rendering: None,
                },
            )?);
        }

        // Shader objects instead of pipelines: one vertex and fragment shader pair per set. Those of an execution set are DGC shaders.
        let tessellation_feature = context.get_device_features().tessellation_shader != vk::FALSE;
        let geometry_feature = context.get_device_features().geometry_shader != vk::FALSE;
        let mut shader_pairs: Vec<(ShaderObject<'_>, ShaderObject<'_>)> = Vec::new();
        if params.shader_objects {
            for i in 0..shader_set_count {
                let suffix = if params.use_execution_set {
                    i.to_string()
                } else {
                    String::new()
                };
                let mut make = |stage: vk::ShaderStageFlags, name: String| -> Result<ShaderObject<'_>, TestError> {
                    let binary = binaries.get(&name)?;
                    if params.use_execution_set {
                        create_dgc_shader(
                            device,
                            stage,
                            &binary,
                            &set_layouts,
                            &pc_ranges,
                            tessellation_feature,
                            geometry_feature,
                        )
                    } else {
                        let next_stage = if stage == vk::ShaderStageFlags::VERTEX {
                            vk::ShaderStageFlags::FRAGMENT
                        } else {
                            vk::ShaderStageFlags::empty()
                        };
                        let create_info = shader_create_info(
                            vk::ShaderCreateFlagsEXT::empty(),
                            stage,
                            next_stage,
                            vk::ShaderCodeTypeEXT::SPIRV,
                            std::mem::size_of_val(binary.spirv),
                            binary.spirv.as_ptr().cast(),
                            &set_layouts,
                            &pc_ranges,
                        );
                        create_shader(device, &create_info)
                    }
                };
                let vert = make(vk::ShaderStageFlags::VERTEX, format!("vert{suffix}"))?;
                let frag = make(vk::ShaderStageFlags::FRAGMENT, format!("frag{suffix}"))?;
                shader_pairs.push((vert, frag));
            }
        }

        // Indirect commands layout.
        let mut cmds_layout_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.do_preprocess() {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }
        if params.unordered_sequences {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::UNORDERED_SEQUENCES;
        }

        // We do not pass the pipeline layout because we don't have push constants or sequence index tokens.
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, stage_flags, vk::PipelineLayout::null());
        if params.use_execution_set {
            let offset = cmds_layout_builder.get_stream_range();
            let set_type = if params.shader_objects {
                vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
            } else {
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
            };
            cmds_layout_builder.add_execution_set_token(offset, set_type, stage_flags);
        }
        if params.index_buffer_token() {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder
                .add_index_buffer_token(offset, vk::IndirectCommandsInputModeFlagsEXT::VULKAN_INDEX_BUFFER);
        }
        let offset = cmds_layout_builder.get_stream_range();
        if non_indexed_draws {
            cmds_layout_builder.add_draw_count_token(offset);
        } else {
            cmds_layout_builder.add_draw_indexed_count_token(offset);
        }
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Indirect execution set, if needed.
        let mut execution_set_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if params.use_execution_set && params.shader_objects {
            let vert_set_layouts: Vec<vk::DescriptorSetLayout> = set_layouts.iter().take(1).copied().collect();
            // The fragment shader uses set 1, so set 0 is a null layout.
            let frag_set_layouts: Vec<vk::DescriptorSetLayout> = vec![
                vk::DescriptorSetLayout::null(),
                set_layouts.get(1).copied().unwrap_or_default(),
            ];
            let stage_infos = [
                (shader_pairs[0].0.get(), vert_set_layouts),
                (shader_pairs[0].1.get(), frag_set_layouts),
            ];
            let mut manager = ExecutionSetManagerExt::new_shader(
                device,
                &stage_infos,
                &pc_ranges,
                SHADER_SET_STAGES * SEQUENCE_COUNT,
            )?;
            // Note we start at 1 and rely on the initial entry set above.
            for (i, (vert, frag)) in shader_pairs.iter().enumerate().skip(1) {
                manager.add_shader(i as u32 * SHADER_SET_STAGES, vert.get());
                manager.add_shader(i as u32 * SHADER_SET_STAGES + 1, frag.get());
            }
            manager.update();
            execution_set_manager = Some(manager);
        } else if params.use_execution_set {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], SEQUENCE_COUNT)?;
            for (i, pipeline) in pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager.update();
            execution_set_manager = Some(manager);
        }
        let indirect_execution_set = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // DGC buffer contents.
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..SEQUENCE_COUNT as usize {
            if params.use_execution_set {
                if params.shader_objects {
                    push_back_element(&mut dgc_data, &(i as u32 * SHADER_SET_STAGES));
                    push_back_element(&mut dgc_data, &(i as u32 * SHADER_SET_STAGES + 1));
                } else {
                    push_back_element(&mut dgc_data, &(i as u32));
                }
            }
            if params.index_buffer_token() {
                push_back_element(&mut dgc_data, &index_buffer_token_data[i]);
            }
            push_back_element(&mut dgc_data, &draw_token_data[i]);
        }

        // DGC buffer with those contents.
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
        let prep_pipeline = if indirect_execution_set == vk::IndirectExecutionSetEXT::null() && !params.shader_objects {
            *pipelines[0]
        } else {
            vk::Pipeline::null()
        };
        let mut prep_shaders: Vec<vk::ShaderEXT> = Vec::new();
        if indirect_execution_set == vk::IndirectExecutionSetEXT::null() && params.shader_objects {
            prep_shaders.push(shader_pairs[0].0.get());
            prep_shaders.push(shader_pairs[0].1.get());
        }
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            indirect_execution_set,
            cmds_layout.get(),
            SEQUENCE_COUNT,
            max_draw_count,
            prep_pipeline,
            &prep_shaders,
            0,
        )?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let fb_clear_color = [0.0f32, 0.0, 0.0, 1.0];

        // Generated commands info.
        let cmds_info = if prep_shaders.is_empty() {
            DgcGenCmdsInfo::new(
                stage_flags,
                indirect_execution_set,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                SEQUENCE_COUNT,
                0,
                pixel_count,
                prep_pipeline,
            )
        } else {
            DgcGenCmdsInfo::new_with_shaders(
                stage_flags,
                indirect_execution_set,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                SEQUENCE_COUNT,
                0,
                pixel_count,
                &prep_shaders,
            )
        };

        // When preprocessing, we need to use a command buffer to record state. The preprocessing step needs to happen outside the
        // render pass. Each entry is the command buffer to record state into and, if not null, the state command buffer of a
        // preprocess command recorded into it.
        let null_cmd_buffer = vk::CommandBuffer::null();
        let mut separate_state_cmd_buffer: Option<UniqueCommandBuffer<'_>> = None;
        let mut state_cmd_buffers: Vec<(vk::CommandBuffer, vk::CommandBuffer)> = Vec::new();
        match params.preprocess_type {
            PreprocessType::None => state_cmd_buffers.push((cmd_buffer, null_cmd_buffer)),
            PreprocessType::SameStateCmdBuffer => {
                state_cmd_buffers.push((cmd_buffer, null_cmd_buffer));
                state_cmd_buffers.push((cmd_buffer, cmd_buffer));
            }
            PreprocessType::OtherStateCmdBuffer => {
                let separate = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                let separate_handle = separate.get();
                separate_state_cmd_buffer = Some(separate);
                state_cmd_buffers.push((separate_handle, null_cmd_buffer));
                state_cmd_buffers.push((cmd_buffer, separate_handle));
            }
        }

        // Record pre-execution state to all needed command buffers.
        let mut prev_cmd_buffer = vk::CommandBuffer::null();
        for &(rec_cmd_buffer, state_cmd_buffer) in &state_cmd_buffers {
            // Only begin each command buffer once.
            if rec_cmd_buffer != prev_cmd_buffer {
                begin_command_buffer(device, rec_cmd_buffer)?;
                prev_cmd_buffer = rec_cmd_buffer;
            }

            if state_cmd_buffer != null_cmd_buffer {
                unsafe {
                    device.cmd_preprocess_generated_commands_ext(rec_cmd_buffer, cmds_info.get(), state_cmd_buffer)
                };
                // Delete separate state command buffer right away.
                separate_state_cmd_buffer = None;

                preprocess_to_execute_barrier_ext(device, rec_cmd_buffer);

                // Break for iteration 1 of PreprocessType::SameStateCmdBuffer. See above.
                if rec_cmd_buffer == state_cmd_buffer {
                    break;
                }
            }

            if let Some(descriptors) = &descriptors {
                unsafe {
                    device.cmd_bind_descriptor_sets(
                        rec_cmd_buffer,
                        bind_point,
                        *pipeline_layout,
                        0,
                        &[descriptors.vert_set.get(), descriptors.frag_set.get()],
                        &[] as &[u32],
                    );
                    let pc_bytes: Vec<u8> = pc_data.iter().flat_map(|value| value.to_ne_bytes()).collect();
                    device.cmd_push_constants(
                        rec_cmd_buffer,
                        *pipeline_layout,
                        vk::ShaderStageFlags::FRAGMENT,
                        0,
                        &pc_bytes,
                    );
                }
            }

            unsafe { device.cmd_bind_vertex_buffers(rec_cmd_buffer, 0, &[vertex_buffer.get()], &[0]) };
            if params.test_type == TestType::DrawIndexedCount {
                unsafe {
                    device.cmd_bind_index_buffer(rec_cmd_buffer, index_buffers[0].get(), 0, vk::IndexType::UINT32)
                };
            }

            // Execution set or not.
            if params.shader_objects {
                bind_shaders_with_nulls(
                    context,
                    rec_cmd_buffer,
                    &[
                        (vk::ShaderStageFlags::VERTEX, shader_pairs[0].0.get()),
                        (vk::ShaderStageFlags::FRAGMENT, shader_pairs[0].1.get()),
                    ],
                );
                let vertex_bindings = [vk::VertexInputBindingDescription2EXT {
                    binding: 0,
                    stride: std::mem::size_of::<[f32; 8]>() as u32,
                    input_rate: vk::VertexInputRate::VERTEX,
                    divisor: 1,
                    ..Default::default()
                }];
                let vertex_attributes = [
                    vk::VertexInputAttributeDescription2EXT {
                        location: 0,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                        ..Default::default()
                    },
                    vk::VertexInputAttributeDescription2EXT {
                        location: 1,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 16,
                        ..Default::default()
                    },
                ];
                bind_shader_object_state(
                    context,
                    rec_cmd_buffer,
                    vk::PrimitiveTopology::TRIANGLE_LIST,
                    0,
                    (FB_SIZE, FB_SIZE),
                    Some((&vertex_bindings[..], &vertex_attributes[..])),
                );
            } else {
                unsafe { device.cmd_bind_pipeline(rec_cmd_buffer, bind_point, *pipelines[0]) };
            }
        }
        drop(separate_state_cmd_buffer);

        if params.shader_objects {
            // The render pass of shader objects: a transition and dynamic rendering clearing the image.
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
                make_rect_2d(0, 0, FB_SIZE, FB_SIZE),
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: fb_clear_color,
                    },
                },
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
        } else {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, FB_SIZE, FB_SIZE),
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: fb_clear_color,
                    },
                },
            );
        }
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.do_preprocess(), cmds_info.get()) };
        if params.shader_objects {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            FB_SIZE,
            FB_SIZE,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Generate reference image.
        let mut reference: Vec<[f32; 4]> = vec![fb_clear_color; pixel_count as usize];

        let max_instance_index = MAX_INSTANCE_INDEX as f32;
        let total_draws = if indexed {
            chunk_indexed_draws.len()
        } else {
            chunk_draws.len()
        };
        let mut prev_pixels = 0u32;

        for draw_idx in 0..total_draws {
            let (vertex_count, first_instance, instance_count) = if indexed {
                (
                    chunk_indexed_draws[draw_idx].index_count,
                    chunk_indexed_draws[draw_idx].first_instance,
                    chunk_indexed_draws[draw_idx].instance_count,
                )
            } else {
                (
                    chunk_draws[draw_idx].vertex_count,
                    chunk_draws[draw_idx].first_instance,
                    chunk_draws[draw_idx].instance_count,
                )
            };

            debug_assert_eq!(vertex_count % PER_TRIANGLE_VERTICES, 0);
            let chunk_pixels = vertex_count / PER_TRIANGLE_VERTICES;

            for i in 0..chunk_pixels {
                let cur_pixel = prev_pixels + i;
                let pixel_idx = if indexed {
                    pixel_count - 1 - cur_pixel
                } else {
                    cur_pixel
                }; // Reversed for indexed draws.
                let red_value = (first_instance + (instance_count - 1)) as f32 / max_instance_index;
                let extra_data = &vertices[(pixel_idx * PER_TRIANGLE_VERTICES) as usize];
                // Filtered by clip or cull distance.
                let blank = params.draw_count_is_zero || (extra_data[4] < 0.0 || extra_data[5] < 0.0);

                let color = [red_value, 0.0, 1.0, 1.0];
                reference[pixel_idx as usize] = if blank { fb_clear_color } else { color };
            }
            prev_pixels += chunk_pixels;
        }

        let result = color_buffer.read_bytes(device)?;

        // 1/255 < 0.005 < 2/255
        let color_threshold = 0.005f32;
        if !float_threshold_compare(
            result,
            &reference,
            [color_threshold, color_threshold, color_threshold, color_threshold],
        ) {
            return Ok(TestStatus::fail(
                "Unexpected result found in color buffer; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCGraphicsDrawCountTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_graphics_draw_count_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let preprocess_cases = [
        (PreprocessType::None, ""),
        (PreprocessType::SameStateCmdBuffer, "_preprocess_same_state_cmd_buffer"),
        (
            PreprocessType::OtherStateCmdBuffer,
            "_preprocess_separate_state_cmd_buffer",
        ),
    ];
    let test_type_cases = [
        (TestType::DrawCount, ""),
        (TestType::DrawIndexedCount, ""), // Also no suffix but will go into a different test group.
        (TestType::DrawIndexedCountIndexToken, "_with_index_buffer_token"),
    ];

    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (test_type, test_type_suffix) in test_type_cases {
        for execution_sets in [false, true] {
            for shader_objects in [false, true] {
                for (preprocess_type, preprocess_suffix) in preprocess_cases {
                    for unordered in [false, true] {
                        for check_draw_params in [false, true] {
                            let mut params = TestParams {
                                test_type,
                                preprocess_type,
                                check_draw_params,
                                use_execution_set: execution_sets,
                                shader_objects,
                                unordered_sequences: unordered,
                                draw_count_is_zero: false,
                            };
                            let name = format!(
                                "{}{}{preprocess_suffix}{}{}{test_type_suffix}",
                                if shader_objects { "shader_objects" } else { "pipelines" },
                                if execution_sets { "_execution_set" } else { "" },
                                if unordered { "_unordered" } else { "" },
                                if check_draw_params { "_check_draw_params" } else { "" },
                            );
                            let group = if params.indexed_draws() {
                                "token_draw_indexed_count"
                            } else {
                                "token_draw_count"
                            };
                            cases.push((
                                format!("ext.graphics.draw_count.{group}.{name}"),
                                Box::new(DrawCountCase { name, params }) as Box<dyn TestCase>,
                            ));

                            // Test drawCount = 0
                            if preprocess_type == PreprocessType::None
                                && !check_draw_params
                                && !execution_sets
                                && !shader_objects
                                && !unordered
                            {
                                let case_name = format!("draw_count_0{test_type_suffix}");
                                params.draw_count_is_zero = true;
                                cases.push((
                                    format!("ext.graphics.draw_count.{group}.{case_name}"),
                                    Box::new(DrawCountCase {
                                        name: case_name,
                                        params,
                                    }) as Box<dyn TestCase>,
                                ));
                            }
                        }
                    }
                }
            }
        }
    }
    cases
}
