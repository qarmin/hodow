// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktShaderLibrary.cpp
//   framework/opengl/gluShaderLibrary.cpp (the case specification)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream parses the `.test` files and builds each case's GLSL at run time; here
// `scripts/gen_vk_shader_library.py` does both ahead of time. The GLSL is in the manifests `shaders/manifest/glsl_*.toml` (compiled to
// SPIR-V by compile_shaders.py), and the case tree with its value blocks is in `src/generated/vk_shader_library/`, built from the types
// below, each case pointing at its manifest constant. The pass runs on the universal queue of the default device where upstream's
// `MultiQueueRunnerTestInstance` runs it on every queue of the kind; value dumps on a failure are dropped. Only the vertex and fragment
// stages of a complete case are supported, which is all the ported files use.

use vulkanalia::prelude::v1_0::*;

use crate::generated::vk_shader_library::FILES;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const REFERENCE_UNIFORM_BINDING: u32 = 0;
const USER_UNIFORM_BINDING: u32 = 1;
const INPUT_STORAGE_BINDING: u32 = 2;
const RESULT_STORAGE_BINDING: u32 = 3;

const RENDER_WIDTH: u32 = 64;
const RENDER_HEIGHT: u32 = 64;
const POSITIONS_SIZE: usize = 4 * 8;
const INDICES_OFFSET: usize = POSITIONS_SIZE;
const INDICES_SIZE: usize = 6 * 2;
const TOTAL_POS_NDX_SIZE: usize = POSITIONS_SIZE + INDICES_SIZE;

const STAGE_VERTEX: u32 = 1;
const STAGE_FRAGMENT: u32 = 2;

/// The scalar type of a value.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Kind {
    Float,
    Int,
    Uint,
    Bool,
}

/// `glu::DataType` of a value: a scalar (1x1), a vector (1 column of `rows` components) or a matrix.
#[derive(Clone, Copy, Debug)]
pub struct Ty {
    pub kind: Kind,
    pub columns: u8,
    pub rows: u8,
}

impl Ty {
    pub const fn new(kind: Kind, columns: u8, rows: u8) -> Self {
        Self { kind, columns, rows }
    }

    /// `getDataTypeScalarSize`
    pub fn scalar_size(&self) -> usize {
        self.columns as usize * self.rows as usize
    }

    /// `isDataTypeMatrix`
    pub fn is_matrix(&self) -> bool {
        self.columns > 1
    }

    fn num_vecs(&self) -> usize {
        self.columns as usize
    }

    /// The components of one vector of the value: the rows of a matrix, the whole of anything else.
    fn num_comps(&self) -> usize {
        self.rows as usize
    }
}

/// `glu::sl::Value` - the elements are the raw 32 bit words: float bits, integers, or 0/1 for a bool.
#[derive(Clone, Copy, Debug)]
pub struct Value {
    pub ty: Ty,
    pub name: &'static str,
    pub words: &'static [u32],
}

/// `glu::sl::CaseType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum CaseKind {
    Complete,
    VertexOnly,
    FragmentOnly,
    ComputeOnly,
}

/// `glu::sl::ShaderCaseSpecification`, with the GLSL left to the manifest.
pub struct CaseData {
    pub path: &'static [&'static str],
    pub name: &'static str,
    pub kind: CaseKind,
    /// `OUTPUT_COLOR` with its format; `None` is `OUTPUT_RESULT`.
    pub output_color: Option<Ty>,
    /// The `glu::ShaderType` bits the program has.
    pub stages: u32,
    pub inputs: &'static [Value],
    pub outputs: &'static [Value],
    pub uniforms: &'static [Value],
    pub programs: &'static SharedProgram,
}

/// One `.test` file and the group it is registered under.
pub struct FileData {
    pub group: &'static [&'static str],
    pub name: &'static str,
    pub cases: &'static [CaseData],
}

struct ValueBufferLayout {
    /// Offset and the stride between the vectors of a matrix, per value.
    entries: Vec<(usize, usize)>,
    size: usize,
}

fn align(value: usize, alignment: usize) -> usize {
    value.div_ceil(alignment) * alignment
}

/// `computeStd140Layout` (`std140` true) and `computeStd430Layout`
fn compute_layout(values: &[Value], std140: bool) -> ValueBufferLayout {
    let mut layout = ValueBufferLayout {
        entries: Vec::with_capacity(values.len()),
        size: 0,
    };

    for value in values {
        let ty = value.ty;
        let num_vecs = ty.num_vecs();
        let vec_size = ty.num_comps();
        let rounded = if (std140 && ty.is_matrix()) || vec_size == 3 {
            4
        } else {
            vec_size
        };
        let alignment = rounded * 4;

        layout.size = align(layout.size, alignment);
        layout.entries.push((layout.size, alignment));
        layout.size += alignment * (num_vecs - 1) + vec_size * 4;
    }

    layout
}

/// `copyToLayout` - the `array_ndx`th sub-case of every value into the buffer.
fn copy_to_layout(dst: &mut [u8], layout: &ValueBufferLayout, values: &[Value], array_ndx: usize) {
    for (value, &(offset, vec_stride)) in values.iter().zip(&layout.entries) {
        let ty = value.ty;
        let scalar_size = ty.scalar_size();
        let num_vecs = ty.num_vecs();
        let num_comps = ty.num_comps();

        for vec_ndx in 0..num_vecs {
            for comp_ndx in 0..num_comps {
                let word = value.words[array_ndx * scalar_size + vec_ndx * num_comps + comp_ndx];
                let word = if ty.kind == Kind::Bool {
                    if word != 0 { !0u32 } else { 0 }
                } else {
                    word
                };
                let at = offset + vec_ndx * vec_stride + comp_ndx * 4;
                dst[at..at + 4].copy_from_slice(&word.to_ne_bytes());
            }
        }
    }
}

/// `getNumSubCases`
fn num_sub_cases(data: &CaseData) -> usize {
    match data.outputs.first() {
        Some(output) => output.words.len() / output.ty.scalar_size(),
        None => 1,
    }
}

/// `getRenderTargetFormat`
fn render_target_format(output_color: Option<Ty>) -> vk::Format {
    match output_color.map(|ty| (ty.kind, ty.columns, ty.rows)) {
        Some((Kind::Float, 1, 2)) => vk::Format::R8G8_UNORM,
        Some((Kind::Float, 1, 3)) => vk::Format::R5G6B5_UNORM_PACK16,
        Some((Kind::Float, 1, 4)) => vk::Format::R8G8B8A8_UNORM,
        Some((Kind::Int, 1, 2)) => vk::Format::R8G8_SINT,
        Some((Kind::Int, 1, 4)) => vk::Format::R8G8B8A8_SINT,
        _ => vk::Format::R8G8B8A8_UNORM,
    }
}

/// `getVecFormat`
fn vec_format(kind: Kind, size: usize) -> vk::Format {
    let formats = match kind {
        Kind::Float => [
            vk::Format::R32_SFLOAT,
            vk::Format::R32G32_SFLOAT,
            vk::Format::R32G32B32_SFLOAT,
            vk::Format::R32G32B32A32_SFLOAT,
        ],
        Kind::Int => [
            vk::Format::R32_SINT,
            vk::Format::R32G32_SINT,
            vk::Format::R32G32B32_SINT,
            vk::Format::R32G32B32A32_SINT,
        ],
        Kind::Uint | Kind::Bool => [
            vk::Format::R32_UINT,
            vk::Format::R32G32_UINT,
            vk::Format::R32G32B32_UINT,
            vk::Format::R32G32B32A32_UINT,
        ],
    };
    formats[size - 1]
}

/// `getVertexAttributeDescriptions`
fn vertex_attribute_descriptions(
    inputs: &[Value],
    layout: &ValueBufferLayout,
) -> Vec<vk::VertexInputAttributeDescription> {
    let mut attribs = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32_SFLOAT,
        offset: 0,
    }];

    for (input, &(offset, vec_stride)) in inputs.iter().zip(&layout.entries) {
        let format = vec_format(input.ty.kind, input.ty.num_comps());

        for vec_ndx in 0..input.ty.num_vecs() {
            attribs.push(vk::VertexInputAttributeDescription {
                location: attribs.len() as u32,
                binding: 1,
                format,
                offset: (offset + vec_stride * vec_ndx) as u32,
            });
        }
    }

    attribs
}

fn create_host_buffer<'a>(
    context: &'a Context<'a>,
    size: usize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

fn write_values(
    context: &Context<'_>,
    buffer: &BufferWithMemory<'_>,
    layout: &ValueBufferLayout,
    values: &[Value],
    array_ndx: usize,
) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    let dst = unsafe { std::slice::from_raw_parts_mut(alloc.get_host_ptr(), layout.size) };
    copy_to_layout(dst, layout, values, array_ndx);

    // Buffers are not allocated with coherency, so the host write caches are flushed by hand.
    flush_alloc(context.get_device(), alloc)
}

struct ShaderCase {
    name: &'static str,
    data: &'static CaseData,
}

impl TestCase for ShaderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.data.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderCaseInstance {
            context,
            data: self.data,
        })
    }
}

struct ShaderCaseInstance<'a> {
    context: &'a Context<'a>,
    data: &'static CaseData,
}

impl TestInstance for ShaderCaseInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.data.kind == CaseKind::ComputeOnly {
            compute_pass(self.context, self.data)
        } else {
            graphics_pass(self.context, self.data)
        }
    }
}

/// The bytes the device wrote to a read back buffer, after invalidating the host cache.
fn read_pixels<'b>(device: &Device, buffer: &'b BufferWithMemory<'_>, size: usize) -> Result<&'b [u8], TestError> {
    invalidate_alloc(device, buffer.get_allocation())?;
    Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), size) })
}

/// `checkResultImageWithReference` over raw pixel values.
fn check_result_image_with_reference(result: &ConstPixelBufferAccess<'_>, reference: [i32; 4]) -> bool {
    let [width, height, _] = result.size();
    (0..height).all(|y| (0..width).all(|x| result.get_pixel_int(x, y, 0) == reference))
}

/// `ShaderCaseInstance::graphicsPass` and the construction that precedes it.
fn graphics_pass<'a>(context: &'a Context<'a>, data: &'static CaseData) -> TestOutcome {
    if data.stages & !(STAGE_VERTEX | STAGE_FRAGMENT) != 0 {
        return Err(TestError::NotSupported(
            "Only the vertex and fragment stages of a complete case are supported".to_string(),
        ));
    }

    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let binaries = context.get_binary_collection();

    let input_layout = compute_layout(data.inputs, false);
    let reference_layout = compute_layout(data.outputs, true);
    let uniform_layout = compute_layout(data.uniforms, true);

    let pos_ndx_buffer = create_host_buffer(
        context,
        TOTAL_POS_NDX_SIZE,
        vk::BufferUsageFlags::INDEX_BUFFER | vk::BufferUsageFlags::VERTEX_BUFFER,
    )?;
    let input_buffer = if input_layout.size > 0 {
        Some(create_host_buffer(
            context,
            input_layout.size,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        )?)
    } else {
        None
    };
    let reference_buffer = if reference_layout.size > 0 {
        Some(create_host_buffer(
            context,
            reference_layout.size,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?)
    } else {
        None
    };
    let uniform_buffer = if uniform_layout.size > 0 {
        Some(create_host_buffer(
            context,
            uniform_layout.size,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?)
    } else {
        None
    };

    let rt_format = render_target_format(data.output_color);
    let tcu_format =
        map_vk_format(rt_format).ok_or_else(|| TestError::Fail("Unmapped render target format".to_string()))?;
    let pixel_size = tcu_format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError("no pixel size for the render target".to_string()))?
        as usize;
    let output_count = if data.outputs.is_empty() || data.output_color.is_none() {
        1
    } else {
        data.outputs.len()
    };
    assert!(output_count <= 4, "more outputs than render targets");
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

    let mut rt_images = Vec::new();
    let mut rt_views = Vec::new();
    let mut read_buffers = Vec::new();
    for _ in 0..output_count {
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(rt_format)
            .extent(vk::Extent3D {
                width: RENDER_WIDTH,
                height: RENDER_HEIGHT,
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
        let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        rt_views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            rt_format,
            color_srr,
        )?);
        rt_images.push(image);
        read_buffers.push(create_host_buffer(
            context,
            RENDER_WIDTH as usize * RENDER_HEIGHT as usize * pixel_size,
            vk::BufferUsageFlags::TRANSFER_DST,
        )?);
    }

    // The render pass and the framebuffer: every output is a colour attachment, left in COLOR_ATTACHMENT_OPTIMAL.
    let attachments: Vec<vk::AttachmentDescription> = (0..output_count)
        .map(|_| vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: rt_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();
    let color_refs: Vec<vk::AttachmentReference> = (0..output_count as u32)
        .map(|attachment| vk::AttachmentReference {
            attachment,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();
    let ds_ref = vk::AttachmentReference {
        attachment: vk::ATTACHMENT_UNUSED,
        layout: vk::ImageLayout::GENERAL,
    };
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .depth_stencil_attachment(&ds_ref)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let view_handles: Vec<vk::ImageView> = rt_views.iter().map(|view| **view).collect();
    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .attachments(&view_handles)
        .width(RENDER_WIDTH)
        .height(RENDER_HEIGHT)
        .layers(1);
    let framebuffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    // The program and the layouts.
    let vertex_module = create_shader_module(device, binaries.get("vertex")?)?;
    let fragment_module = create_shader_module(device, binaries.get("fragment")?)?;
    let mut shader_stage_flags = vk::ShaderStageFlags::empty();
    if data.stages & STAGE_VERTEX != 0 {
        shader_stage_flags |= vk::ShaderStageFlags::VERTEX;
    }
    if data.stages & STAGE_FRAGMENT != 0 {
        shader_stage_flags |= vk::ShaderStageFlags::FRAGMENT;
    }
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, shader_stage_flags)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(RENDER_WIDTH, RENDER_HEIGHT);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: 8,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    if !data.inputs.is_empty() {
        state.bindings.push(vk::VertexInputBindingDescription {
            binding: 1,
            stride: 0,
            input_rate: vk::VertexInputRate::INSTANCE,
        });
    }
    state.attributes = vertex_attribute_descriptions(data.inputs, &input_layout);
    state.color_attachment_count = output_count as u32;
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ],
        &state,
    )?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    if let Some(uniform_buffer) = &uniform_buffer {
        let info = vk::DescriptorBufferInfo {
            buffer: uniform_buffer.get(),
            offset: 0,
            range: uniform_layout.size as vk::DeviceSize,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(USER_UNIFORM_BINDING),
                vk::DescriptorType::UNIFORM_BUFFER,
                &info,
            )
            .update(device);
    }
    if let Some(reference_buffer) = &reference_buffer {
        let info = vk::DescriptorBufferInfo {
            buffer: reference_buffer.get(),
            offset: 0,
            range: reference_layout.size as vk::DeviceSize,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(REFERENCE_UNIFORM_BINDING),
                vk::DescriptorType::UNIFORM_BUFFER,
                &info,
            )
            .update(device);
    }

    {
        let positions: [[f32; 2]; 4] = [[-1.0, -1.0], [-1.0, 1.0], [1.0, -1.0], [1.0, 1.0]];
        let indices: [u16; 6] = [0, 1, 2, 1, 3, 2];
        let mut bytes = Vec::with_capacity(TOTAL_POS_NDX_SIZE);
        bytes.extend(positions.iter().flatten().flat_map(|value| value.to_ne_bytes()));
        bytes.extend(indices.iter().flat_map(|value| value.to_ne_bytes()));
        debug_assert_eq!(bytes.len(), TOTAL_POS_NDX_SIZE);
        unsafe {
            std::ptr::copy_nonoverlapping(
                bytes.as_ptr(),
                pos_ndx_buffer.get_allocation().get_host_ptr(),
                bytes.len(),
            )
        };
        flush_alloc(device, pos_ndx_buffer.get_allocation())?;
    }

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    let queue_family_index = context.get_universal_queue_family_index();

    begin_command_buffer(device, cmd)?;
    unsafe {
        let vert_flush_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::HOST_WRITE)
            .dst_access_mask(vk::AccessFlags::VERTEX_ATTRIBUTE_READ | vk::AccessFlags::UNIFORM_READ)
            .build();
        let color_att_barriers: Vec<vk::ImageMemoryBarrier> = rt_images
            .iter()
            .map(|image| {
                vk::ImageMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::empty())
                    .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                    .old_layout(vk::ImageLayout::UNDEFINED)
                    .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .src_queue_family_index(queue_family_index)
                    .dst_queue_family_index(queue_family_index)
                    .image(image.get())
                    .subresource_range(color_srr)
                    .build()
            })
            .collect();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::DependencyFlags::empty(),
            &[vert_flush_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &color_att_barriers,
        );

        let clear_values = vec![
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.125, 0.25, 0.75, 1.0]
                }
            };
            output_count
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_WIDTH, RENDER_HEIGHT))
            .clear_values(&clear_values);
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);

        if !data.uniforms.is_empty() || !data.outputs.is_empty() {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
        }

        match &input_buffer {
            Some(input_buffer) => {
                device.cmd_bind_vertex_buffers(cmd, 0, &[pos_ndx_buffer.get(), input_buffer.get()], &[0, 0])
            }
            None => device.cmd_bind_vertex_buffers(cmd, 0, &[pos_ndx_buffer.get()], &[0]),
        }
        device.cmd_bind_index_buffer(
            cmd,
            pos_ndx_buffer.get(),
            INDICES_OFFSET as vk::DeviceSize,
            vk::IndexType::UINT16,
        );
        device.cmd_draw_indexed(cmd, 6, 1, 0, 0, 0);
        device.cmd_end_render_pass(cmd);

        let render_finish_barriers: Vec<vk::ImageMemoryBarrier> = rt_images
            .iter()
            .map(|image| {
                vk::ImageMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                    .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                    .old_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                    .src_queue_family_index(queue_family_index)
                    .dst_queue_family_index(queue_family_index)
                    .image(image.get())
                    .subresource_range(color_srr)
                    .build()
            })
            .collect();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &render_finish_barriers,
        );

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: RENDER_WIDTH,
            buffer_image_height: RENDER_HEIGHT,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: RENDER_WIDTH,
                height: RENDER_HEIGHT,
                depth: 1,
            },
        };
        for (image, buffer) in rt_images.iter().zip(&read_buffers) {
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[copy_region],
            );
        }

        let copy_finish_barriers: Vec<vk::BufferMemoryBarrier> = read_buffers
            .iter()
            .map(|buffer| {
                vk::BufferMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .src_queue_family_index(queue_family_index)
                    .dst_queue_family_index(queue_family_index)
                    .buffer(buffer.get())
                    .offset(0)
                    .size((RENDER_WIDTH as usize * RENDER_HEIGHT as usize * pixel_size) as vk::DeviceSize)
                    .build()
            })
            .collect();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &copy_finish_barriers,
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;

    for sub_case_ndx in 0..num_sub_cases(data) {
        if let Some(input_buffer) = &input_buffer {
            write_values(context, input_buffer, &input_layout, data.inputs, sub_case_ndx)?;
        }
        if let Some(reference_buffer) = &reference_buffer {
            write_values(context, reference_buffer, &reference_layout, data.outputs, sub_case_ndx)?;
        }
        if let Some(uniform_buffer) = &uniform_buffer {
            write_values(context, uniform_buffer, &uniform_layout, data.uniforms, sub_case_ndx)?;
        }

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        if data.output_color.is_none() {
            // OUTPUT_RESULT: every pixel of the single target has to be white.
            let image = ConstPixelBufferAccess::new(
                tcu_format,
                [RENDER_WIDTH, RENDER_HEIGHT, 1],
                read_pixels(
                    device,
                    &read_buffers[0],
                    RENDER_WIDTH as usize * RENDER_HEIGHT as usize * pixel_size,
                )?,
            );
            if !check_result_image_with_reference(&image, [255, 255, 255, 255]) {
                return Ok(TestStatus::fail(format!(
                    "Got invalid pixels at sub-case {sub_case_ndx}"
                )));
            }
        } else {
            for (out_ndx, output) in data.outputs.iter().enumerate().take(output_count) {
                let image = ConstPixelBufferAccess::new(
                    tcu_format,
                    [RENDER_WIDTH, RENDER_HEIGHT, 1],
                    read_pixels(
                        device,
                        &read_buffers[out_ndx],
                        RENDER_WIDTH as usize * RENDER_HEIGHT as usize * pixel_size,
                    )?,
                );
                let num_components = output.ty.scalar_size();
                let mut reference = [0i32, 0, 0, 1];

                for (ref_ndx, slot) in reference.iter_mut().enumerate().take(num_components) {
                    let word = output.words[sub_case_ndx * num_components + ref_ndx];
                    *slot = match output.ty.kind {
                        Kind::Float => f32::from_bits(word) as i32,
                        Kind::Int => word as i32,
                        Kind::Uint | Kind::Bool => {
                            return Err(TestError::InternalError("Unknown data type".to_string()));
                        }
                    };
                }

                if !check_result_image_with_reference(&image, reference) {
                    return Ok(TestStatus::fail(format!(
                        "Got invalid pixels at sub-case {sub_case_ndx}"
                    )));
                }
            }
        }
    }

    Ok(TestStatus::pass("All sub-cases passed"))
}

/// `ShaderCaseInstance::computePass`
fn compute_pass<'a>(context: &'a Context<'a>, data: &'static CaseData) -> TestOutcome {
    let device = context.get_device();
    let binaries = context.get_binary_collection();

    let input_layout = compute_layout(data.inputs, false);
    let reference_layout = compute_layout(data.outputs, true);
    let uniform_layout = compute_layout(data.uniforms, true);

    let compute_module = create_shader_module(device, binaries.get("compute_0")?)?;
    let input_buffer = if input_layout.size > 0 {
        Some(create_host_buffer(
            context,
            input_layout.size,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        )?)
    } else {
        None
    };
    let reference_buffer = if reference_layout.size > 0 {
        Some(create_host_buffer(
            context,
            reference_layout.size,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?)
    } else {
        None
    };
    let uniform_buffer = if uniform_layout.size > 0 {
        Some(create_host_buffer(
            context,
            uniform_layout.size,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?)
    } else {
        None
    };
    let result_buffer = create_host_buffer(context, 4, vk::BufferUsageFlags::STORAGE_BUFFER)?;

    let ds_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*ds_layout])?;

    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*compute_module)
        .name(b"main\0")
        .build();
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(0)
        .build();
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    let ds_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 2)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let ds_set = make_descriptor_set(device, *ds_pool, *ds_layout)?;

    {
        let mut update = DescriptorSetUpdateBuilder::new();
        let info = |buffer: &BufferWithMemory<'_>, size: usize| vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: size as vk::DeviceSize,
        };

        if let Some(input_buffer) = &input_buffer {
            update = update.write_single(
                ds_set.get(),
                Location::binding(INPUT_STORAGE_BINDING),
                vk::DescriptorType::STORAGE_BUFFER,
                &info(input_buffer, input_layout.size),
            );
        }
        if let Some(reference_buffer) = &reference_buffer {
            update = update.write_single(
                ds_set.get(),
                Location::binding(REFERENCE_UNIFORM_BINDING),
                vk::DescriptorType::UNIFORM_BUFFER,
                &info(reference_buffer, reference_layout.size),
            );
        }
        if let Some(uniform_buffer) = &uniform_buffer {
            update = update.write_single(
                ds_set.get(),
                Location::binding(USER_UNIFORM_BINDING),
                vk::DescriptorType::UNIFORM_BUFFER,
                &info(uniform_buffer, uniform_layout.size),
            );
        }
        update = update.write_single(
            ds_set.get(),
            Location::binding(RESULT_STORAGE_BINDING),
            vk::DescriptorType::STORAGE_BUFFER,
            &info(&result_buffer, 4),
        );
        update.update(device);
    }

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        let host_write_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::HOST_WRITE)
            .dst_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::UNIFORM_READ)
            .build();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::DependencyFlags::empty(),
            &[host_write_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[ds_set.get()],
            &[] as &[u32],
        );
        device.cmd_dispatch(cmd, 1, 1, 1);
        let shader_write_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[shader_write_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;

    for sub_case_ndx in 0..num_sub_cases(data) {
        if let Some(input_buffer) = &input_buffer {
            write_values(context, input_buffer, &input_layout, data.inputs, sub_case_ndx)?;
        }
        if let Some(reference_buffer) = &reference_buffer {
            write_values(context, reference_buffer, &reference_layout, data.outputs, sub_case_ndx)?;
        }
        if let Some(uniform_buffer) = &uniform_buffer {
            write_values(context, uniform_buffer, &uniform_layout, data.uniforms, sub_case_ndx)?;
        }

        unsafe { std::ptr::write_bytes(result_buffer.get_allocation().get_host_ptr(), 0, 4) };
        flush_alloc(device, result_buffer.get_allocation())?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let result = unsafe {
            std::ptr::read_unaligned(result_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>())
        };

        if result != 1 {
            return Ok(TestStatus::fail(format!(
                "Compute test failed at sub-case {sub_case_ndx}"
            )));
        }
    }

    Ok(TestStatus::pass("All sub-cases passed"))
}

enum Node {
    Group(String, Vec<Node>),
    Case(Box<dyn TestCase>),
}

/// Puts `case` under the groups of `path`, creating the ones that are not there yet in the order they are first met.
fn insert(children: &mut Vec<Node>, path: &[&str], case: Box<dyn TestCase>) {
    let Some((first, rest)) = path.split_first() else {
        children.push(Node::Case(case));
        return;
    };

    let existing = children
        .iter()
        .position(|node| matches!(node, Node::Group(name, _) if name == first));
    let index = existing.unwrap_or_else(|| {
        children.push(Node::Group(first.to_string(), Vec::new()));
        children.len() - 1
    });

    if let Node::Group(_, grandchildren) = &mut children[index] {
        insert(grandchildren, rest, case);
    }
}

fn build_group(name: &str, nodes: Vec<Node>) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for node in nodes {
        match node {
            Node::Group(child_name, children) => {
                group.add_child(build_group(&child_name, children));
            }
            Node::Case(case) => {
                group.add_child(case);
            }
        }
    }
    group
}

/// `createShaderLibraryGroup` for every file of `createGlslTests`: `es310/*` as children of the root, `440/linkage` under `440`.
pub fn create_shader_library_groups(name: &str) -> TestCaseGroup {
    let mut root = Vec::new();

    for file in FILES.iter() {
        for data in file.cases {
            let mut path: Vec<&str> = file.group.to_vec();
            path.push(file.name);
            path.extend_from_slice(data.path);
            insert(
                &mut root,
                &path,
                Box::new(ShaderCase { name: data.name, data }) as Box<dyn TestCase>,
            );
        }
    }

    build_group(name, root)
}
