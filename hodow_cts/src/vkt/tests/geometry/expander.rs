// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/geometry/vktGeometryBasicClass.cpp / .hpp (`GeometryExpanderRenderTestInstance`)
//   external/vulkancts/modules/vulkan/geometry/vktGeometryTestsUtil.cpp (`compareWithFileImage`, `calcOutputVertices`)
//   the instance classes of vktGeometry{Input,Varying,Emit,Basic,BuiltinVariable}GeometryShaderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `GeometryExpanderRenderTestInstance` is a base class the five test files derive from, each overriding the vertex data
// and, for the varying output count cases, the pipeline layout and the descriptor binding. Here `ExpanderKind` names which
// derived class a case is, `vertex_data` builds its `m_vertexPosData` / `m_vertexAttrData` / `m_numDrawVertices`, and
// `run_expander` is `iterate` with the descriptor and index buffer hooks folded in.
//
// The shaders of every case are generated (`scripts/gen_geometry_programs.py`, `shaders/manifest/geometry_expander.toml`) and
// found by name in `ALL_SHARED_PROGRAM`; the reference images they are compared to are embedded from `data/geometry/`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::geometry_expander::ALL_SHARED_PROGRAM;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::png::load_png;
use crate::tcu::vector::UVec4;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
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
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::geometry::GraphicsPipelineBuilder;
use crate::vkt::tests::geometry::reference_images::reference_png;
use crate::vkt::{Context, TestCase, TestInstance};

const TEST_CANVAS_SIZE: u32 = 256;

/// `VaryingSource`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum VaryingSource {
    ReadAttribute,
    ReadUniform,
    ReadTexture,
}

/// `VariableTest`; `Position` has an HLSL geometry shader (stage `hlsl_geom` of compile_shaders.py)
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum VariableTest {
    PointSize,
    PrimitiveIdIn,
    PrimitiveId,
    Position,
}

/// Which derived class of `GeometryExpanderRenderTestInstance` a case is.
#[derive(Clone, Copy)]
pub enum ExpanderKind {
    /// `GeometryInputTestInstance`, with the draw vertex count `TriangleStripAdjacencyVertexCountTest` overrides.
    Input {
        primitive_type: vk::PrimitiveTopology,
        num_draw_vertices: Option<i32>,
    },
    /// `GeometryVaryingTestInstance`
    Varying,
    /// `GeometryEmitTestInstance`
    Emit,
    /// `GeometryOutputCountTestInstance`
    OutputCount { primitive_count: i32 },
    /// `VaryingOutputCountTestInstance`
    VaryingOutputCount { test: VaryingSource, instanced: bool },
    /// `BuiltinVariableRenderTestInstance`
    BuiltinVariable { test: VariableTest, indices: bool },
}

/// `m_primitiveType`, `m_numDrawVertices`, `m_vertexPosData`, `m_vertexAttrData` and the index buffer contents.
struct VertexData {
    primitive_type: vk::PrimitiveTopology,
    num_draw_vertices: i32,
    positions: Vec<[f32; 4]>,
    attributes: Vec<[f32; 4]>,
    indices: Option<Vec<u16>>,
}

/// The programs of the generated case of the given name.
pub fn expander_programs(name: &str) -> BinaryCollection {
    ALL_SHARED_PROGRAM
        .iter()
        .find(|program| program.name == name)
        .unwrap_or_else(|| panic!("scripts/gen_geometry_programs.py generated no case named {name}"))
        .programs
}

/// `GeometryInputTestInstance::genVertexAttribData`
fn input_vertex_data(primitive_type: vk::PrimitiveTopology, num_draw_vertices: Option<i32>) -> VertexData {
    // Create 1 X 2 grid in triangle strip adjacent - order
    let scale = 0.3f32;
    let offset = [-0.5f32, -0.2, 0.0, 1.0];
    let base: [[f32; 2]; 12] = [
        [0.0, 0.0],
        [-1.0, -1.0],
        [0.0, -1.0],
        [1.0, 1.0],
        [1.0, 0.0],
        [0.0, -2.0],
        [1.0, -1.0],
        [2.0, 1.0],
        [2.0, 0.0],
        [1.0, -2.0],
        [2.0, -1.0],
        [3.0, 0.0],
    ];
    let positions: Vec<[f32; 4]> = base
        .iter()
        .map(|b| {
            [
                b[0] * scale + offset[0],
                b[1] * scale + offset[1],
                0.0 * scale + offset[2],
                0.0 * scale + offset[3],
            ]
        })
        .collect();

    // Red and white
    let attributes = (0..12)
        .map(|i| {
            if i % 2 == 0 {
                [1.0, 1.0, 1.0, 1.0]
            } else {
                [1.0, 0.0, 0.0, 1.0]
            }
        })
        .collect();

    VertexData {
        primitive_type,
        num_draw_vertices: num_draw_vertices.unwrap_or(12),
        positions,
        attributes,
        indices: None,
    }
}

/// `GeometryVaryingTestInstance::genVertexAttribData`
fn varying_vertex_data() -> VertexData {
    VertexData {
        primitive_type: vk::PrimitiveTopology::TRIANGLE_STRIP,
        num_draw_vertices: 3,
        positions: vec![[0.5, 0.0, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0], [0.1, 0.0, 0.0, 1.0]],
        attributes: vec![[0.7, 0.4, 0.6, 1.0], [0.9, 0.2, 0.5, 1.0], [0.1, 0.8, 0.3, 1.0]],
        indices: None,
    }
}

/// `GeometryEmitTestInstance::genVertexAttribData`
fn emit_vertex_data() -> VertexData {
    VertexData {
        primitive_type: vk::PrimitiveTopology::POINT_LIST,
        num_draw_vertices: 1,
        positions: vec![[0.0, 0.0, 0.0, 1.0]],
        attributes: vec![[1.0, 1.0, 1.0, 1.0]],
        indices: None,
    }
}

/// `GeometryOutputCountTestInstance::genVertexAttribData`
fn output_count_vertex_data(primitive_count: i32) -> VertexData {
    let positions = (0..primitive_count)
        .map(|ndx| [-1.0, ndx as f32 / primitive_count as f32 * 2.0 - 1.0, 0.0, 1.0])
        .collect();
    let attributes = (0..primitive_count)
        .map(|ndx| {
            if ndx % 2 == 0 {
                [1.0, 1.0, 1.0, 1.0]
            } else {
                [1.0, 0.0, 0.0, 1.0]
            }
        })
        .collect();
    VertexData {
        primitive_type: vk::PrimitiveTopology::POINT_LIST,
        num_draw_vertices: primitive_count,
        positions,
        attributes,
        indices: None,
    }
}

const MAX_EMIT_COUNT: i32 = 128;
const EMIT_COUNT_VERTEX: [i32; 4] = [6, 0, -1, 10];

/// `VaryingOutputCountTestInstance::genVertexDataWithoutInstancing` / `genVertexDataWithInstancing`
fn varying_output_count_vertex_data(test: VaryingSource, instanced: bool) -> VertexData {
    let emit_count = |ndx: usize| {
        (if EMIT_COUNT_VERTEX[ndx] == -1 {
            MAX_EMIT_COUNT
        } else {
            EMIT_COUNT_VERTEX[ndx]
        }) as f32
    };

    if !instanced {
        let positions = vec![
            [0.5, 0.0, 0.0, 1.0],
            [0.0, 0.5, 0.0, 1.0],
            [-0.7, -0.1, 0.0, 1.0],
            [-0.1, -0.7, 0.0, 1.0],
        ];
        let attributes = if test == VaryingSource::ReadAttribute {
            (0..4).map(|ndx| [emit_count(ndx), 0.0, 0.0, 0.0]).collect()
        } else {
            vec![
                [0.0, 0.0, 0.0, 0.0],
                [1.0, 0.0, 0.0, 0.0],
                [2.0, 0.0, 0.0, 0.0],
                [3.0, 0.0, 0.0, 0.0],
            ]
        };
        VertexData {
            primitive_type: vk::PrimitiveTopology::POINT_LIST,
            num_draw_vertices: 4,
            positions,
            attributes,
            indices: None,
        }
    } else {
        let attribute = if test == VaryingSource::ReadAttribute {
            [emit_count(0), emit_count(1), emit_count(2), emit_count(3)]
        } else {
            [0.0; 4]
        };
        VertexData {
            primitive_type: vk::PrimitiveTopology::POINT_LIST,
            num_draw_vertices: 1,
            positions: vec![[0.0, 0.0, 0.0, 1.0]],
            attributes: vec![attribute],
            indices: None,
        }
    }
}

/// `BuiltinVariableRenderTestInstance::genVertexAttribData`
fn builtin_variable_vertex_data(test: VariableTest, indices_test: bool) -> VertexData {
    let primitive_type = match test {
        VariableTest::PrimitiveIdIn => vk::PrimitiveTopology::LINE_STRIP,
        VariableTest::Position => vk::PrimitiveTopology::TRIANGLE_STRIP,
        VariableTest::PointSize | VariableTest::PrimitiveId => vk::PrimitiveTopology::POINT_LIST,
    };
    VertexData {
        primitive_type,
        num_draw_vertices: 5,
        positions: vec![
            [0.5, 0.0, 0.0, 1.0],
            [0.0, 0.5, 0.0, 1.0],
            [-0.7, -0.1, 0.0, 1.0],
            [-0.1, -0.7, 0.0, 1.0],
            [0.5, 0.0, 0.0, 1.0],
        ],
        attributes: vec![
            [0.0; 4],
            [1.0, 0.0, 0.0, 0.0],
            [2.0, 0.0, 0.0, 0.0],
            [3.0, 0.0, 0.0, 0.0],
            [0.0; 4],
        ],
        // Only used by primitive ID restart test
        indices: if indices_test {
            Some(vec![1, 4, 0xFFFF /* restart */, 2, 1])
        } else {
            None
        },
    }
}

fn vertex_data(kind: ExpanderKind) -> VertexData {
    match kind {
        ExpanderKind::Input {
            primitive_type,
            num_draw_vertices,
        } => input_vertex_data(primitive_type, num_draw_vertices),
        ExpanderKind::Varying => varying_vertex_data(),
        ExpanderKind::Emit => emit_vertex_data(),
        ExpanderKind::OutputCount { primitive_count } => output_count_vertex_data(primitive_count),
        ExpanderKind::VaryingOutputCount { test, instanced } => varying_output_count_vertex_data(test, instanced),
        ExpanderKind::BuiltinVariable { test, indices } => builtin_variable_vertex_data(test, indices),
    }
}

/// `compareWithFileImage`
fn compare_with_file_image(result: &TextureLevel, test_name: &str) -> Result<bool, TestError> {
    let png = reference_png(test_name)
        .ok_or_else(|| TestError::NotPorted(format!("no reference image embedded for {test_name}")))?;
    let reference =
        load_png(png).map_err(|e| TestError::InternalError(format!("data/geometry/{test_name}.png: {e}")))?;

    if fuzzy_compare_ok(&reference.get_const_access(), &result.get_const_access(), 0.0015) == Some(true) {
        return Ok(int_threshold_position_deviation_compare(
            &reference.get_const_access(),
            &result.get_const_access(),
            UVec4::new(1, 1, 1, 1),
            [2, 2, 2],
            false,
        ));
    }
    Ok(false)
}

/// What a varying output count case binds to its geometry shader.
struct DescriptorResources<'a> {
    set: vk::DescriptorSet,
    _pool: Unique<'a, vk::DescriptorPool>,
    set_layout: Unique<'a, vk::DescriptorSetLayout>,
    // Referenced by the descriptor set for as long as it is bound.
    _buffer: Option<BufferWithMemory<'a>>,
    _sampler: Option<Unique<'a, vk::Sampler>>,
    _image_view: Option<Unique<'a, vk::ImageView>>,
    _image: Option<ImageWithMemory<'a>>,
}

/// `VaryingOutputCountTestInstance::createPipelineLayout` and `bindDescriptorSets`, minus the command: the set layout, the
/// pool, the set with its contents written.
fn create_descriptor_resources<'a>(
    context: &'a Context<'a>,
    test: VaryingSource,
) -> Result<DescriptorResources<'a>, TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();
    let descriptor_type = if test == VaryingSource::ReadUniform {
        vk::DescriptorType::UNIFORM_BUFFER
    } else {
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER
    };

    let binding = [vk::DescriptorSetLayoutBinding::builder()
        .binding(0)
        .descriptor_type(descriptor_type)
        .descriptor_count(1)
        .stage_flags(vk::ShaderStageFlags::GEOMETRY)
        .build()];
    let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&binding);
    let set_layout = Unique::new(
        device,
        unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
            .vk_check("vkCreateDescriptorSetLayout")?,
    );
    let pool_sizes = [vk::DescriptorPoolSize {
        type_: descriptor_type,
        descriptor_count: 1,
    }];
    let pool_info = vk::DescriptorPoolCreateInfo::builder()
        .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
        .max_sets(1)
        .pool_sizes(&pool_sizes);
    let pool = Unique::new(
        device,
        unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
    );
    let set_layouts = [*set_layout];
    let allocate_info = vk::DescriptorSetAllocateInfo::builder()
        .descriptor_pool(*pool)
        .set_layouts(&set_layouts);
    let set = unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?[0];

    if test == VaryingSource::ReadUniform {
        let emit_count: [i32; 4] = [6, 0, MAX_EMIT_COUNT, 10];
        let size = std::mem::size_of_val(&emit_count);
        let buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                emit_count.as_ptr().cast::<u8>(),
                buffer.get_allocation().get_host_ptr(),
                size,
            )
        };
        flush_alloc(device, buffer.get_allocation())?;

        let buffer_info = [vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: size as vk::DeviceSize,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(set)
            .dst_binding(0)
            .descriptor_type(descriptor_type)
            .buffer_info(&buffer_info);
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        return Ok(DescriptorResources {
            set,
            _pool: pool,
            set_layout,
            _buffer: Some(buffer),
            _sampler: None,
            _image_view: None,
            _image: None,
        });
    }

    // READ_TEXTURE: a 4x1 RGBA8 image holding one channel at full value per texel
    let texel_data: [u8; 16] = [255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255];
    let format = vk::Format::R8G8B8A8_UNORM;
    let image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: 4,
            height: 1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;

    // uploadImage
    {
        let staging = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(texel_data.len() as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                texel_data.as_ptr(),
                staging.get_allocation().get_host_ptr(),
                texel_data.len(),
            )
        };
        flush_alloc(device, staging.get_allocation())?;

        let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let upload_cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *upload_cmd;
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image.get(),
            range,
        );
        let to_shader = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            image.get(),
            range,
        );
        let mut copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: 4,
                height: 1,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        copy_region.buffer_row_length = 4;
        copy_region.buffer_image_height = 1;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            device.cmd_copy_buffer_to_image(
                cmd,
                staging.get(),
                image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_shader],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    }

    let sampler_info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::NEVER)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
    );
    let image_view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        format,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let descriptor_image_info = [vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *image_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(set)
        .dst_binding(0)
        .descriptor_type(descriptor_type)
        .image_info(&descriptor_image_info);
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    Ok(DescriptorResources {
        set,
        _pool: pool,
        set_layout,
        _buffer: None,
        _sampler: Some(sampler),
        _image_view: Some(image_view),
        _image: Some(image),
    })
}

/// `GeometryExpanderRenderTestInstance::iterate`
fn run_expander<'a>(context: &'a Context<'a>, name: &str, kind: ExpanderKind) -> TestOutcome {
    let device = context.get_device();
    let alloc = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let resolution = (TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
    let color_format = vk::Format::R8G8B8A8_UNORM;
    let data = vertex_data(kind);

    let color_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(color_format)
        .extent(vk::Extent3D {
            width: resolution.0,
            height: resolution.1,
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
    let color_attachment_image = ImageWithMemory::new(device, alloc, color_image_info, MemoryRequirement::ANY)?;
    let render_pass = make_render_pass(device, color_format)?;

    // createPipelineLayout
    let descriptors = match kind {
        ExpanderKind::VaryingOutputCount { test, .. } if test != VaryingSource::ReadAttribute => {
            Some(create_descriptor_resources(context, test)?)
        }
        _ => None,
    };
    let set_layouts: Vec<vk::DescriptorSetLayout> = descriptors.iter().map(|resources| *resources.set_layout).collect();
    let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(device, &set_layouts)?;

    let color_sub_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_attachment_view = make_image_view(
        device,
        color_attachment_image.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_sub_range,
    )?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_attachment_view],
        resolution.0,
        resolution.1,
        1,
    )?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let vertex_data_size_bytes = (data.positions.len() + data.attributes.len()) * std::mem::size_of::<[f32; 4]>();
    let vertex_attr_offset = std::mem::size_of::<[f32; 4]>() as u32;
    let binaries = context.get_binary_collection();
    let geometry_shader_name = if binaries.contains("geometry_pointsize")
        && context
            .get_device_features()
            .shader_tessellation_and_geometry_point_size
            != vk::FALSE
    {
        "geometry_pointsize"
    } else {
        "geometry"
    };

    let vertex_module = create_shader_module(device, binaries.get("vertex")?)?;
    let geometry_module = create_shader_module(device, binaries.get(geometry_shader_name)?)?;
    let fragment_module = create_shader_module(device, binaries.get("fragment")?)?;
    let pipeline = GraphicsPipelineBuilder::new(resolution)
        .set_shader(vk::ShaderStageFlags::VERTEX, *vertex_module)
        .set_shader(vk::ShaderStageFlags::GEOMETRY, *geometry_module)
        .set_shader(vk::ShaderStageFlags::FRAGMENT, *fragment_module)
        .add_vertex_binding(vk::VertexInputBindingDescription {
            binding: 0,
            stride: 2 * vertex_attr_offset,
            input_rate: vk::VertexInputRate::VERTEX,
        })
        .add_vertex_attribute(vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        })
        .add_vertex_attribute(vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: vertex_attr_offset,
        })
        .set_primitive_topology(data.primitive_type)
        .build(device, *pipeline_layout, *render_pass)?;

    let color_buffer_size_bytes = (resolution.0 * resolution.1 * 4) as usize;
    let color_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(
            color_buffer_size_bytes as vk::DeviceSize,
            vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let vertex_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(
            vertex_data_size_bytes as vk::DeviceSize,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let vertex_count = data.num_draw_vertices as usize;
        let mut interleaved: Vec<[f32; 8]> = Vec::with_capacity(vertex_count);
        for ndx in 0..vertex_count {
            let (pos, attr) = (data.positions[ndx], data.attributes[ndx]);
            interleaved.push([pos[0], pos[1], pos[2], pos[3], attr[0], attr[1], attr[2], attr[3]]);
        }
        unsafe {
            std::ptr::copy_nonoverlapping(
                interleaved.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                interleaved.len() * 32,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;
        // No barrier needed, flushed memory is automatically visible
    }

    // BuiltinVariableRenderTestInstance::createIndicesBuffer
    let index_buffer = match &data.indices {
        Some(indices) => {
            let size = indices.len() * std::mem::size_of::<u16>();
            let buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::INDEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indices.as_ptr().cast::<u8>(),
                    buffer.get_allocation().get_host_ptr(),
                    size,
                )
            };
            flush_alloc(device, buffer.get_allocation())?;
            Some(buffer)
        }
        None => None,
    };

    // Draw commands
    begin_command_buffer(device, cmd)?;

    // Change color attachment image layout
    let color_attachment_layout_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        color_attachment_image.get(),
        color_sub_range,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[color_attachment_layout_barrier],
        );
    }

    // Begin render pass
    begin_render_pass(
        device,
        cmd,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, resolution.0, resolution.1),
        vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        },
    );

    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
    }

    // bindDescriptorSets
    if let Some(resources) = &descriptors {
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[resources.set],
                &[],
            )
        };
    }

    // drawCommand
    match (&index_buffer, &data.indices) {
        (Some(buffer), Some(indices)) => unsafe {
            device.cmd_bind_index_buffer(cmd, buffer.get(), 0, vk::IndexType::UINT16);
            device.cmd_draw_indexed(cmd, indices.len() as u32, 1, 0, 0, 0);
        },
        _ => unsafe { device.cmd_draw(cmd, data.num_draw_vertices as u32, 1, 0, 0) },
    }
    end_render_pass(device, cmd);

    // Copy render result to a host-visible buffer
    copy_image_to_buffer(
        device,
        cmd,
        color_attachment_image.get(),
        color_buffer.get(),
        resolution.0,
        resolution.1,
    );

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, color_buffer.get_allocation())?;
    let mut image = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        resolution.0,
        resolution.1,
        1,
    )?;
    let bytes =
        unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size_bytes) };
    image.data_mut().copy_from_slice(bytes);

    if !compare_with_file_image(&image, name)? {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// The tests of the five files that derive from `GeometryExpanderRenderTestInstance`: `GeometryExpanderRenderTest`,
/// `VaryingTest`, `EmitTest`, `GeometryOutputCountTest`, `VaryingOutputCountCase` and `BuiltinVariableRenderTest`.
pub struct ExpanderCase {
    name: String,
    programs: BinaryCollection,
    kind: ExpanderKind,
    /// The name of the reference image, which `compareWithFileImage` is given the test name for.
    image_name: String,
}

impl ExpanderCase {
    /// `programs_key` is the name of the generated case, `name` both the test's and its reference image's.
    pub fn new(name: &str, programs_key: &str, kind: ExpanderKind) -> Self {
        Self {
            name: name.to_string(),
            programs: expander_programs(programs_key),
            kind,
            image_name: name.to_string(),
        }
    }
}

impl TestCase for ExpanderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Feature not supported: geometryShader".to_string(),
            ));
        }

        if let ExpanderKind::Input { primitive_type, .. } = self.kind
            && primitive_type == vk::PrimitiveTopology::TRIANGLE_FAN
            && context.is_device_functionality_supported("VK_KHR_portability_subset")
        {
            let mut portability = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut portability);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if portability.triangle_fans == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VK_KHR_portability_subset: Triangle fans are not supported by this implementation".to_string(),
                ));
            }
        }

        if let ExpanderKind::BuiltinVariable {
            test: VariableTest::PointSize,
            ..
        } = self.kind
            && features.shader_tessellation_and_geometry_point_size == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Feature not supported: shaderTessellationAndGeometryPointSize".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExpanderInstance { context, case: self })
    }
}

struct ExpanderInstance<'a> {
    context: &'a Context<'a>,
    case: &'a ExpanderCase,
}

impl TestInstance for ExpanderInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_expander(self.context, &self.case.image_name, self.case.kind)
    }
}
