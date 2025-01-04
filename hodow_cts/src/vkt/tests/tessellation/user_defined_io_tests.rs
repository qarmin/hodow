// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationUserDefinedIO.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every case's programs are pre-expanded in the manifest
// (`shaders/manifest/tessellation_user_defined_io.toml`) instead of being built from `glu::VarType`s at run time, and the
// reference PNGs are embedded from `data/tessellation/`. The names of the failed inputs upstream logs are reduced to their
// index.
//
// These tests correspond roughly to dEQP-GLES31.functional.tessellation.user_defined_io.*

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_user_defined_io::*;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::png::load_png;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::tessellation::util::{SpacingMode, TessPrimitiveType, reference_vertex_count};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NUM_PER_PATCH_BLOCKS: u32 = 2;
const NUM_PER_PATCH_ARRAY_ELEMS: u32 = 3;
const NUM_OUTPUT_VERTICES: u32 = 5;
const NUM_TESS_LEVELS: usize = 6;
const RENDER_SIZE: u32 = 256;

/// `IOType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum IoType {
    PerPatch,
    PerPatchArray,
    PerPatchBlock,
    PerPatchBlockArray,
    PerVertex,
    PerVertexBlock,
}

/// `VertexIOArraySize`
#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexIoArraySize {
    Implicit,
    ExplicitShaderBuiltin,
    ExplicitSpecMin,
}

impl IoType {
    /// The number of top-level array elements the evaluation shader reads, `topLevelArraySize`.
    fn top_level_array_size(self) -> u32 {
        match self {
            IoType::PerPatch => 1,
            IoType::PerPatchArray => NUM_PER_PATCH_ARRAY_ELEMS,
            IoType::PerPatchBlock => 1,
            IoType::PerPatchBlockArray => NUM_PER_PATCH_BLOCKS,
            IoType::PerVertex | IoType::PerVertexBlock => NUM_OUTPUT_VERTICES,
        }
    }

    /// `numBasicSubobjectsInElementType` summed over the evaluation shader's inputs: the struct `S` is an int and a vec4
    /// (and a float[2] inside a block), the full block adds `blockS`, a float[3], a `S[2]` and a float, and the
    /// per-patch block array leaves `blockS` out.
    fn num_basic_subobjects_in_element_type(self) -> u32 {
        match self {
            IoType::PerPatch | IoType::PerVertex => 2 + 1,
            IoType::PerPatchArray => 1,
            IoType::PerPatchBlock | IoType::PerVertexBlock => 4 + 3 + 2 * 4 + 1,
            IoType::PerPatchBlockArray => 3 + 2 * 4 + 1,
        }
    }
}

/// The reference PNG of a primitive type, `vulkan/data/tessellation/user_defined_io_<primitive>_ref.png`.
fn reference_png(primitive_type: TessPrimitiveType) -> &'static [u8] {
    match primitive_type {
        TessPrimitiveType::Triangles => {
            include_bytes!("../../../../data/tessellation/user_defined_io_triangles_ref.png")
        }
        TessPrimitiveType::Quads => include_bytes!("../../../../data/tessellation/user_defined_io_quads_ref.png"),
        TessPrimitiveType::Isolines => include_bytes!("../../../../data/tessellation/user_defined_io_isolines_ref.png"),
    }
}

/// `CaseDefinition`
#[derive(Clone, Copy)]
struct CaseDefinition {
    primitive_type: TessPrimitiveType,
    io_type: IoType,
    vertex_io_array_size: VertexIoArraySize,
}

struct UserDefinedIoTest {
    name: String,
    case_def: CaseDefinition,
}

impl TestCase for UserDefinedIoTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupportCase` and the `requireFeatures` of `iterate`.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "SSBO and image writes not supported in vertex pipeline".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (
            self.case_def.io_type,
            self.case_def.vertex_io_array_size,
            self.case_def.primitive_type,
        ) {
            (IoType::PerPatch, VertexIoArraySize::Implicit, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_IMPLICIT_TRIANGLES.programs
            }
            (IoType::PerPatch, VertexIoArraySize::Implicit, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_IMPLICIT_QUADS.programs
            }
            (IoType::PerPatch, VertexIoArraySize::Implicit, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_IMPLICIT_ISOLINES.programs
            }
            (IoType::PerPatch, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_SHADER_BUILTIN_TRIANGLES.programs
            }
            (IoType::PerPatch, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_SHADER_BUILTIN_QUADS.programs
            }
            (IoType::PerPatch, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_SHADER_BUILTIN_ISOLINES.programs
            }
            (IoType::PerPatch, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_SPEC_MIN_TRIANGLES.programs
            }
            (IoType::PerPatch, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_SPEC_MIN_QUADS.programs
            }
            (IoType::PerPatch, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_SPEC_MIN_ISOLINES.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::Implicit, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_ARRAY_IMPLICIT_TRIANGLES.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::Implicit, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_ARRAY_IMPLICIT_QUADS.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::Implicit, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_ARRAY_IMPLICIT_ISOLINES.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_ARRAY_SHADER_BUILTIN_TRIANGLES.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_ARRAY_SHADER_BUILTIN_QUADS.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_ARRAY_SHADER_BUILTIN_ISOLINES.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_ARRAY_SPEC_MIN_TRIANGLES.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_ARRAY_SPEC_MIN_QUADS.programs
            }
            (IoType::PerPatchArray, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_ARRAY_SPEC_MIN_ISOLINES.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::Implicit, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_BLOCK_IMPLICIT_TRIANGLES.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::Implicit, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_BLOCK_IMPLICIT_QUADS.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::Implicit, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_BLOCK_IMPLICIT_ISOLINES.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_BLOCK_SHADER_BUILTIN_TRIANGLES.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_BLOCK_SHADER_BUILTIN_QUADS.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_BLOCK_SHADER_BUILTIN_ISOLINES.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_BLOCK_SPEC_MIN_TRIANGLES.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_BLOCK_SPEC_MIN_QUADS.programs
            }
            (IoType::PerPatchBlock, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_BLOCK_SPEC_MIN_ISOLINES.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::Implicit, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_IMPLICIT_TRIANGLES.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::Implicit, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_IMPLICIT_QUADS.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::Implicit, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_IMPLICIT_ISOLINES.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_SHADER_BUILTIN_TRIANGLES.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_SHADER_BUILTIN_QUADS.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_SHADER_BUILTIN_ISOLINES.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Triangles) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_SPEC_MIN_TRIANGLES.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Quads) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_SPEC_MIN_QUADS.programs
            }
            (IoType::PerPatchBlockArray, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Isolines) => {
                UDIO_PER_PATCH_BLOCK_ARRAY_SPEC_MIN_ISOLINES.programs
            }
            (IoType::PerVertex, VertexIoArraySize::Implicit, TessPrimitiveType::Triangles) => {
                UDIO_PER_VERTEX_IMPLICIT_TRIANGLES.programs
            }
            (IoType::PerVertex, VertexIoArraySize::Implicit, TessPrimitiveType::Quads) => {
                UDIO_PER_VERTEX_IMPLICIT_QUADS.programs
            }
            (IoType::PerVertex, VertexIoArraySize::Implicit, TessPrimitiveType::Isolines) => {
                UDIO_PER_VERTEX_IMPLICIT_ISOLINES.programs
            }
            (IoType::PerVertex, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Triangles) => {
                UDIO_PER_VERTEX_SHADER_BUILTIN_TRIANGLES.programs
            }
            (IoType::PerVertex, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Quads) => {
                UDIO_PER_VERTEX_SHADER_BUILTIN_QUADS.programs
            }
            (IoType::PerVertex, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Isolines) => {
                UDIO_PER_VERTEX_SHADER_BUILTIN_ISOLINES.programs
            }
            (IoType::PerVertex, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Triangles) => {
                UDIO_PER_VERTEX_SPEC_MIN_TRIANGLES.programs
            }
            (IoType::PerVertex, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Quads) => {
                UDIO_PER_VERTEX_SPEC_MIN_QUADS.programs
            }
            (IoType::PerVertex, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Isolines) => {
                UDIO_PER_VERTEX_SPEC_MIN_ISOLINES.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::Implicit, TessPrimitiveType::Triangles) => {
                UDIO_PER_VERTEX_BLOCK_IMPLICIT_TRIANGLES.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::Implicit, TessPrimitiveType::Quads) => {
                UDIO_PER_VERTEX_BLOCK_IMPLICIT_QUADS.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::Implicit, TessPrimitiveType::Isolines) => {
                UDIO_PER_VERTEX_BLOCK_IMPLICIT_ISOLINES.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Triangles) => {
                UDIO_PER_VERTEX_BLOCK_SHADER_BUILTIN_TRIANGLES.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Quads) => {
                UDIO_PER_VERTEX_BLOCK_SHADER_BUILTIN_QUADS.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::ExplicitShaderBuiltin, TessPrimitiveType::Isolines) => {
                UDIO_PER_VERTEX_BLOCK_SHADER_BUILTIN_ISOLINES.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Triangles) => {
                UDIO_PER_VERTEX_BLOCK_SPEC_MIN_TRIANGLES.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Quads) => {
                UDIO_PER_VERTEX_BLOCK_SPEC_MIN_QUADS.programs
            }
            (IoType::PerVertexBlock, VertexIoArraySize::ExplicitSpecMin, TessPrimitiveType::Isolines) => {
                UDIO_PER_VERTEX_BLOCK_SPEC_MIN_ISOLINES.programs
            }
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UserDefinedIoTestInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct UserDefinedIoTestInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDefinition,
}

impl TestInstance for UserDefinedIoTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc = context.get_default_allocator();

        // Tessellation levels (inner, outer), the position scale and offset: all as vertex attributes
        const NUM_ATTRIBUTES: usize = NUM_TESS_LEVELS + 2 + 2;
        let attributes: [f32; NUM_ATTRIBUTES] = [
            /* inner */ 3.0, 4.0, /* outer */ 5.0, 6.0, 7.0, 8.0, /* pos. scale */ 1.2, 1.3,
            /* pos. offset */ -0.3, -0.4,
        ];
        let primitive_type = self.case_def.primitive_type;
        let ref_num_vertices = reference_vertex_count(
            primitive_type,
            SpacingMode::Equal,
            false,
            &attributes[0..],
            &attributes[2..],
        );
        let ref_num_unique_vertices = reference_vertex_count(
            primitive_type,
            SpacingMode::Equal,
            true,
            &attributes[0..],
            &attributes[2..],
        );

        // Vertex input attributes buffer: to pass tessellation levels
        let vertex_format = vk::Format::R32_SFLOAT;
        let vertex_stride = 4u32;
        let vertex_buffer = create_host_buffer(context, &attributes, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Output buffer: number of invocations and verification indices
        let result_buffer_max_vertices = ref_num_vertices.max(0) as usize;
        let result_buffer_size_bytes =
            (std::mem::size_of::<i32>() + result_buffer_max_vertices * std::mem::size_of::<u32>()) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let result_alloc = result_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(result_alloc.get_host_ptr(), 0, result_buffer_size_bytes as usize) };
            flush_alloc(device, result_alloc)?;
        }

        // Color attachment, and the buffer its image is copied to for verification
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_target = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Descriptors
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let result_buffer_info = vk::DescriptorBufferInfo {
            buffer: result_buffer.get(),
            offset: 0,
            range: result_buffer_size_bytes,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_buffer_info,
            )
            .update(device);

        // Pipeline
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_target.view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_module = create_shader_module(device, binaries.get("tese")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: vertex_stride,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vertex_format,
            offset: 0,
        }];
        state.patch_control_points = Some(NUM_ATTRIBUTES as u32);
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // Begin draw
        begin_command_buffer(device, *cmd_buffer)?;

        // Change color attachment image layout
        {
            let color_attachment_layout_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_target.image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_attachment_layout_barrier],
                );
            }
        }

        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);

            device.cmd_draw(*cmd_buffer, NUM_ATTRIBUTES as u32, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }

        // Copy render result to a host-visible buffer
        copy_image_to_buffer(
            device,
            *cmd_buffer,
            color_target.image.get(),
            color_target.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verification
        let result_bytes = color_target.read_bytes(device)?;
        let result_image = ConstPixelBufferAccess::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            [RENDER_SIZE, RENDER_SIZE, 1],
            result_bytes,
        );
        let reference = load_png(reference_png(primitive_type)).map_err(|e| {
            TestError::InternalError(format!(
                "data/tessellation/user_defined_io_{}_ref.png: {e}",
                primitive_type.shader_name()
            ))
        })?;
        let is_image_compare_ok = fuzzy_compare_ok(&reference.get_const_access(), &result_image, 0.02) == Some(true);

        {
            let result_alloc = result_buffer.get_allocation();
            invalidate_alloc(device, result_alloc)?;

            let host_ptr = result_alloc.get_host_ptr();
            let num_vertices = unsafe { std::ptr::read_unaligned(host_ptr.cast::<i32>()) };

            // If this fails then we didn't read all vertices from shader and test must be changed to allow more.
            debug_assert!(num_vertices <= ref_num_vertices);

            if num_vertices < ref_num_unique_vertices {
                return Ok(TestStatus::fail("Wrong number of vertices"));
            }

            let top_level_array_size = self.case_def.io_type.top_level_array_size();
            let num_te_inputs = self.case_def.io_type.num_basic_subobjects_in_element_type() * top_level_array_size;

            // A count beyond the buffer would mean the shader wrote past its end; only what fits can be read back.
            let readable_vertices = (num_vertices.max(0) as usize).min(result_buffer_max_vertices);
            for vertex_ndx in 0..readable_vertices {
                let first_failed_input_index = unsafe {
                    std::ptr::read_unaligned(
                        host_ptr
                            .add(std::mem::size_of::<i32>() + vertex_ndx * std::mem::size_of::<u32>())
                            .cast::<u32>(),
                    )
                };
                if first_failed_input_index > num_te_inputs {
                    return Ok(TestStatus::fail("Invalid values returned from shader"));
                } else if first_failed_input_index != num_te_inputs {
                    return Ok(TestStatus::fail(
                        "Invalid input value in tessellation evaluation shader",
                    ));
                }
            }
        }

        Ok(if is_image_compare_ok {
            TestStatus::pass("OK")
        } else {
            TestStatus::fail("Image comparison failed")
        })
    }
}

/// `createUserDefinedIOTests`
pub fn create_user_defined_io_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("user_defined_io");

    let io_cases = [
        // Per-patch TCS outputs
        ("per_patch", IoType::PerPatch),
        // Per-patch array TCS outputs
        ("per_patch_array", IoType::PerPatchArray),
        // Per-patch TCS outputs in IO block
        ("per_patch_block", IoType::PerPatchBlock),
        // Per-patch TCS outputs in IO block array
        ("per_patch_block_array", IoType::PerPatchBlockArray),
        // Per-vertex TCS outputs
        ("per_vertex", IoType::PerVertex),
        // Per-vertex TCS outputs in IO block
        ("per_vertex_block", IoType::PerVertexBlock),
    ];

    let vertex_array_size_cases = [
        ("vertex_io_array_size_implicit", VertexIoArraySize::Implicit),
        (
            "vertex_io_array_size_shader_builtin",
            VertexIoArraySize::ExplicitShaderBuiltin,
        ),
        ("vertex_io_array_size_spec_min", VertexIoArraySize::ExplicitSpecMin),
    ];

    for (io_name, io_type) in io_cases {
        let mut io_type_group = TestCaseGroup::new(io_name);
        for (array_size_name, vertex_io_array_size) in vertex_array_size_cases {
            let mut vertex_array_size_group = TestCaseGroup::new(array_size_name);
            for primitive_type in TessPrimitiveType::ALL {
                let case_def = CaseDefinition {
                    primitive_type,
                    io_type,
                    vertex_io_array_size,
                };
                vertex_array_size_group.add_child(Box::new(UserDefinedIoTest {
                    name: primitive_type.shader_name().to_string(),
                    case_def,
                }) as Box<dyn TestCase>);
            }
            io_type_group.add_child(vertex_array_size_group);
        }
        group.add_child(io_type_group);
    }

    group
}
