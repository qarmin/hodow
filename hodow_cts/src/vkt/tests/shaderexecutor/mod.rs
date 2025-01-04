// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderExecutor.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream builds the GLSL of a `ShaderSpec` at run time (`generateSources`); here
// `scripts/gen_shader_executor_programs.py` does that ahead of time (`shaders/manifest/shader_executor.toml`, one `SharedProgram` named
// `se_<spec>__<shader type>` per pair), so `ShaderSpec` keeps only the host half: the symbols that decide the buffer and attribute layouts. The
// executors are functions instead of a class tree (`execute_fragment_out` is `FragmentOutExecutor::executeCommon`, `execute_compute` is
// `ComputeShaderExecutor::execute`, `execute_tess` is `TessControlExecutor`/`TessEvaluationExecutor::execute` over `renderTess`, `execute_mesh_task` is
// `MeshTaskShaderExecutor::execute`). Not ported: the descriptor buffer (other than the fragment executor) and descriptor heap modes,
// float16/double/bool/matrix symbols, `packFloat16Bit`, the SPIR-V cases and user queues.

pub mod atomic_operation_tests;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtDescriptorBufferExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::shader_executor::ALL_SHARED_PROGRAM;
use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::Context;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};

const DEFAULT_RENDER_WIDTH: u32 = 100;
const DEFAULT_RENDER_HEIGHT: u32 = 100;
const INPUT_BUFFER_BINDING: u32 = 0;
const OUTPUT_BUFFER_BINDING: u32 = 1;

/// `glu::ShaderType`, in upstream's order.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ShaderType {
    Vertex,
    Fragment,
    Geometry,
    TessellationControl,
    TessellationEvaluation,
    Compute,
    Task,
    Mesh,
}

impl ShaderType {
    pub const ALL: [ShaderType; 8] = [
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::Geometry,
        ShaderType::TessellationControl,
        ShaderType::TessellationEvaluation,
        ShaderType::Compute,
        ShaderType::Task,
        ShaderType::Mesh,
    ];

    /// `glu::getShaderTypeName`
    pub fn name(self) -> &'static str {
        match self {
            Self::Vertex => "vertex",
            Self::Fragment => "fragment",
            Self::Geometry => "geometry",
            Self::TessellationControl => "tessellation_control",
            Self::TessellationEvaluation => "tessellation_evaluation",
            Self::Compute => "compute",
            Self::Task => "task",
            Self::Mesh => "mesh",
        }
    }

    /// The real `glu::getShaderTypeName` (the group and case names of the mustpass), which `name` does not match for the tessellation stages.
    pub fn case_name(self) -> &'static str {
        match self {
            Self::TessellationControl => "tess_control",
            Self::TessellationEvaluation => "tess_eval",
            other => other.name(),
        }
    }
}

/// `ExecutorDescriptorMode`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ExecutorDescriptorMode {
    DescriptorSet,
    DescriptorBuffer,
    DescriptorHeap,
}

/// `executorSupported`
pub fn executor_supported(shader_type: ShaderType, descriptor_mode: ExecutorDescriptorMode) -> bool {
    if descriptor_mode != ExecutorDescriptorMode::DescriptorSet {
        return shader_type == ShaderType::Fragment;
    }
    true
}

/// The scalar type of a `Symbol`.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ScalarKind {
    Float,
    Int,
    Uint,
    /// Only in the buffers of the compute and tessellation executors, where a `bool` takes 32 bits; the fragment-out executors do not take it.
    Bool,
    /// 64 bit float: 8 bytes per component, std430 alignments of 8, 16 and 32. Only the compute executor takes it.
    Double,
}

/// `Symbol` of a `ShaderSpec`: a highp scalar or vector (`size` 1 to 4) named in the GLSL the generator wrote.
#[derive(Clone, Copy, Debug)]
pub struct Symbol {
    pub name: &'static str,
    pub kind: ScalarKind,
    pub size: u32,
}

impl Symbol {
    pub const fn new(name: &'static str, kind: ScalarKind, size: u32) -> Self {
        Self { name, kind, size }
    }

    fn byte_size(&self) -> usize {
        self.size as usize * if self.kind == ScalarKind::Double { 8 } else { 4 }
    }
}

/// The host half of `ShaderSpec`.
#[derive(Clone, Copy, Debug)]
pub struct ShaderSpec {
    pub inputs: &'static [Symbol],
    pub outputs: &'static [Symbol],
}

/// The programs `gen_shader_executor_programs.py` wrote for `key` (a spec) and `shader_type`, as the case's `programs()`.
pub fn executor_programs(key: &str, shader_type: ShaderType) -> BinaryCollection {
    let name = format!("se_{key}__{}", shader_type.name());
    ALL_SHARED_PROGRAM
        .iter()
        .find(|program| program.name == name)
        .map_or(BinaryCollection::new(&[]), |program| program.programs)
}

/// The `usesVec5Types` check of the checkSupport functions: `getShaderLongVectorFeaturesEXT().longVector`
pub fn check_support_long_vector(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_shader_long_vector")?;
    let mut long_vector_features = vk::PhysicalDeviceShaderLongVectorFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut long_vector_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if long_vector_features.long_vector == vk::FALSE {
        return Err(TestError::NotSupported("longVector not supported".to_string()));
    }
    Ok(())
}

/// `checkSupportShader`, for the shader types that are ported.
pub fn check_support_shader(context: &Context<'_>, shader_type: ShaderType) -> Result<(), TestError> {
    let features = context.get_device_features();
    let not_supported = |feature: &str| Err(TestError::NotSupported(format!("{feature} not supported")));

    match shader_type {
        ShaderType::TessellationControl | ShaderType::TessellationEvaluation => {
            if features.tessellation_shader == vk::FALSE {
                return not_supported("tessellationShader");
            }
        }
        ShaderType::Geometry => {
            if features.geometry_shader == vk::FALSE {
                return not_supported("geometryShader");
            }
        }
        ShaderType::Task | ShaderType::Mesh => {
            context.require_device_functionality("VK_EXT_mesh_shader")?;

            if shader_type == ShaderType::Task {
                let mut mesh_features = vk::PhysicalDeviceMeshShaderFeaturesEXT::default();
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut mesh_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
                if mesh_features.task_shader == vk::FALSE {
                    return not_supported("taskShader");
                }
            }
        }
        _ => {}
    }

    match shader_type {
        ShaderType::Vertex
        | ShaderType::TessellationControl
        | ShaderType::TessellationEvaluation
        | ShaderType::Geometry
        | ShaderType::Task
        | ShaderType::Mesh => {
            if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
                return not_supported("vertexPipelineStoresAndAtomics");
            }
        }
        ShaderType::Fragment => {
            if features.fragment_stores_and_atomics == vk::FALSE {
                return not_supported("fragmentStoresAndAtomics");
            }
        }
        _ => {}
    }

    Ok(())
}

#[allow(clippy::too_many_arguments)]
/// `ShaderExecutor::execute` of the executor `createExecutor` makes for `shader_type`. `inputs[i]` holds `num_values` tightly packed
/// elements of `spec.inputs[i]`, `outputs[i]` gets the same for `spec.outputs[i]`.
pub fn execute(
    context: &Context<'_>,
    shader_type: ShaderType,
    spec: &ShaderSpec,
    extra_resources_layout: Option<vk::DescriptorSetLayout>,
    num_values: usize,
    inputs: &[&[u8]],
    outputs: &mut [&mut [u8]],
    extra_resources: Option<vk::DescriptorSet>,
) -> Result<(), TestError> {
    assert_eq!(extra_resources_layout.is_some(), extra_resources.is_some());
    assert_eq!(inputs.len(), spec.inputs.len());
    assert_eq!(outputs.len(), spec.outputs.len());

    match shader_type {
        ShaderType::Vertex | ShaderType::Geometry | ShaderType::Fragment => {
            if shader_type == ShaderType::Geometry && context.get_device_features().geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Geometry shader type not supported by device".to_string(),
                ));
            }
            execute_fragment_out(
                context,
                shader_type,
                spec,
                extra_resources_layout,
                num_values,
                inputs,
                outputs,
                extra_resources,
                None,
            )
        }
        ShaderType::Compute => execute_compute(
            context,
            spec,
            extra_resources_layout,
            num_values,
            inputs,
            outputs,
            extra_resources,
        ),
        ShaderType::TessellationControl | ShaderType::TessellationEvaluation => execute_tess(
            context,
            shader_type,
            spec,
            extra_resources_layout,
            num_values,
            inputs,
            outputs,
            extra_resources,
        ),
        ShaderType::Task | ShaderType::Mesh => execute_mesh_task(
            context,
            spec,
            extra_resources_layout,
            num_values,
            inputs,
            outputs,
            extra_resources,
        ),
    }
}

/// `DescriptorData::BufferDescriptor`: one combined image sampler of the extra resources set, written into the descriptor buffer.
#[derive(Clone, Copy)]
pub struct BufferDescriptor {
    pub image_info: vk::DescriptorImageInfo,
    pub buffer_offset: vk::DeviceSize,
    pub combined_sampler_descriptor_count: u32,
}

/// `ShaderExecutor::executeBuffer`: the extra resources are the descriptors of a descriptor buffer made for
/// `extra_resources_layout` (which has to be created with `DESCRIPTOR_BUFFER_EXT`). Only the fragment executor has this mode.
pub fn execute_buffer(
    context: &Context<'_>,
    shader_type: ShaderType,
    spec: &ShaderSpec,
    extra_resources_layout: vk::DescriptorSetLayout,
    num_values: usize,
    inputs: &[&[u8]],
    outputs: &mut [&mut [u8]],
    buffer_descriptors: &[BufferDescriptor],
) -> Result<(), TestError> {
    assert_eq!(inputs.len(), spec.inputs.len());
    assert_eq!(outputs.len(), spec.outputs.len());
    if shader_type != ShaderType::Fragment {
        return Err(TestError::NotPorted(
            "the descriptor buffer mode of the executors other than the fragment one".to_string(),
        ));
    }
    execute_fragment_out(
        context,
        shader_type,
        spec,
        Some(extra_resources_layout),
        num_values,
        inputs,
        outputs,
        None,
        Some(buffer_descriptors),
    )
}

/// The descriptor buffer of `execute_fragment_out`: sized for the layout, one descriptor written per `BufferDescriptor`.
fn create_descriptor_buffer<'a>(
    context: &'a Context<'a>,
    layout: vk::DescriptorSetLayout,
    descriptors: &[BufferDescriptor],
) -> Result<(BufferWithMemory<'a>, vk::DeviceAddress), TestError> {
    let device = context.get_device();
    let mut properties = vk::PhysicalDeviceDescriptorBufferPropertiesEXT::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }

    let layout_size = unsafe { device.get_descriptor_set_layout_size_ext(layout) };
    let alignment = properties.descriptor_buffer_offset_alignment.max(1);
    let size = layout_size.div_ceil(alignment) * alignment;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT
                | vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT
                | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    let host_ptr = buffer.get_allocation().get_host_ptr();

    for descriptor in descriptors {
        let get_info = vk::DescriptorGetInfoEXT {
            type_: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            data: vk::DescriptorDataEXT {
                combined_image_sampler: &descriptor.image_info,
            },
            ..Default::default()
        };
        let descriptor_size =
            properties.combined_image_sampler_descriptor_size * descriptor.combined_sampler_descriptor_count as usize;
        unsafe {
            device.get_descriptor_ext(
                &get_info,
                std::slice::from_raw_parts_mut(host_ptr.add(descriptor.buffer_offset as usize), descriptor_size),
            )
        };
    }
    flush_alloc(device, buffer.get_allocation())?;

    let address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
    let address = unsafe { device.get_buffer_device_address(&address_info) };
    Ok((buffer, address))
}

/// `getAttributeFormat`
fn attribute_format(symbol: &Symbol) -> vk::Format {
    match (symbol.kind, symbol.size) {
        (ScalarKind::Float, 1) => vk::Format::R32_SFLOAT,
        (ScalarKind::Float, 2) => vk::Format::R32G32_SFLOAT,
        (ScalarKind::Float, 3) => vk::Format::R32G32B32_SFLOAT,
        (ScalarKind::Float, 4) => vk::Format::R32G32B32A32_SFLOAT,
        (ScalarKind::Int, 1) => vk::Format::R32_SINT,
        (ScalarKind::Int, 2) => vk::Format::R32G32_SINT,
        (ScalarKind::Int, 3) => vk::Format::R32G32B32_SINT,
        (ScalarKind::Int, 4) => vk::Format::R32G32B32A32_SINT,
        (ScalarKind::Uint, 1) => vk::Format::R32_UINT,
        (ScalarKind::Uint, 2) => vk::Format::R32G32_UINT,
        (ScalarKind::Uint, 3) => vk::Format::R32G32B32_UINT,
        (ScalarKind::Uint, 4) => vk::Format::R32G32B32A32_UINT,
        _ => panic!("no attribute format for {symbol:?}"),
    }
}

/// The colour attachment format of an output: a float output goes to a float target, an integer one to an integer target.
fn output_format(symbol: &Symbol) -> vk::Format {
    match symbol.kind {
        ScalarKind::Float => vk::Format::R32G32B32A32_SFLOAT,
        ScalarKind::Int => vk::Format::R32G32B32A32_SINT,
        ScalarKind::Uint | ScalarKind::Bool => vk::Format::R32G32B32A32_UINT,
        ScalarKind::Double => panic!("no colour target for a 64 bit float output: {symbol:?}"),
    }
}

fn default_clear_color() -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.125, 0.25, 0.5, 1.0],
        },
    }
}

fn host_buffer<'a>(
    context: &'a Context<'_>,
    size: usize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size.max(1) as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

fn upload_bytes(context: &Context<'_>, buffer: &BufferWithMemory<'_>, bytes: &[u8]) -> Result<(), TestError> {
    if bytes.is_empty() {
        return Ok(());
    }
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(context.get_device(), buffer.get_allocation())
}

fn download_bytes<'b>(
    context: &Context<'_>,
    buffer: &'b BufferWithMemory<'_>,
    size: usize,
) -> Result<&'b [u8], TestError> {
    invalidate_alloc(context.get_device(), buffer.get_allocation())?;
    Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), size) })
}

/// `computeVertexPositions`
fn compute_vertex_positions(num_values: usize, render_size: (u32, u32)) -> Vec<[f32; 2]> {
    (0..num_values)
        .map(|val_ndx| {
            let ix = val_ndx as u32 % render_size.0;
            let iy = val_ndx as u32 / render_size.0;
            let fx = -1.0 + 2.0 * ((ix as f32 + 0.5) / render_size.0 as f32);
            let fy = -1.0 + 2.0 * ((iy as f32 + 0.5) / render_size.1 as f32);
            [fx, fy]
        })
        .collect()
}

/// `FragmentOutExecutor::executeCommon`, descriptor set mode: every element is one point whose vertex, geometry or fragment shader writes the
/// outputs, one colour attachment per output, read back pixel by pixel.
#[allow(clippy::too_many_arguments)]
fn execute_fragment_out(
    context: &Context<'_>,
    shader_type: ShaderType,
    spec: &ShaderSpec,
    extra_resources_layout: Option<vk::DescriptorSetLayout>,
    num_values: usize,
    inputs: &[&[u8]],
    outputs: &mut [&mut [u8]],
    extra_resources: Option<vk::DescriptorSet>,
    buffer_descriptors: Option<&[BufferDescriptor]>,
) -> Result<(), TestError> {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let binaries = context.get_binary_collection();

    for symbol in spec.inputs {
        let format = attribute_format(symbol);
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if !properties
            .buffer_features
            .contains(vk::FormatFeatureFlags::VERTEX_BUFFER)
        {
            return Err(TestError::NotSupported(
                "format not supported by device as vertex buffer attribute format".to_string(),
            ));
        }
    }

    let render_size_x = 128.min(num_values as u32);
    let render_size_y = (num_values as u32 / render_size_x) + u32::from(num_values as u32 % render_size_x != 0);
    let render_size = (render_size_x, render_size_y);
    let use_geometry_shader = shader_type == ShaderType::Geometry;

    // The empty set at index 0 is there so the extra resources can sit at set 1.
    let use_descriptor_buffer = buffer_descriptors.is_some();
    let empty_set_layout = DescriptorSetLayoutBuilder::new().build_with_flags(
        device,
        if use_descriptor_buffer {
            vk::DescriptorSetLayoutCreateFlags::DESCRIPTOR_BUFFER_EXT
        } else {
            vk::DescriptorSetLayoutCreateFlags::empty()
        },
    )?;
    let empty_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let empty_set = if use_descriptor_buffer {
        None
    } else {
        Some(make_descriptor_set(device, *empty_pool, *empty_set_layout)?)
    };

    let positions = compute_vertex_positions(num_values, render_size);
    let position_bytes: Vec<u8> = positions
        .iter()
        .flatten()
        .flat_map(|value| value.to_ne_bytes())
        .collect();

    let mut bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: 8,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let mut attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32_SFLOAT,
        offset: 0,
    }];
    let mut vertex_buffers = Vec::new();
    let position_buffer = host_buffer(context, position_bytes.len(), vk::BufferUsageFlags::VERTEX_BUFFER)?;
    upload_bytes(context, &position_buffer, &position_bytes)?;
    vertex_buffers.push(position_buffer);
    for (input_ndx, symbol) in spec.inputs.iter().enumerate() {
        let binding = bindings.len() as u32;
        bindings.push(vk::VertexInputBindingDescription {
            binding,
            stride: symbol.byte_size() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        });
        attributes.push(vk::VertexInputAttributeDescription {
            location: binding,
            binding,
            format: attribute_format(symbol),
            offset: 0,
        });
        let buffer = host_buffer(
            context,
            symbol.byte_size() * num_values,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        )?;
        upload_bytes(context, &buffer, &inputs[input_ndx][..symbol.byte_size() * num_values])?;
        vertex_buffers.push(buffer);
    }

    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let mut color_images = Vec::new();
    let mut color_views = Vec::new();
    let mut attachments = Vec::new();
    let mut attachment_refs = Vec::new();
    let mut clear_values = Vec::new();
    for (out_ndx, symbol) in spec.outputs.iter().enumerate() {
        let color_format = output_format(symbol);
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), color_format)
        };
        if !properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
        {
            return Err(TestError::NotSupported(
                "Image format doesn't support COLOR_ATTACHMENT_BIT".to_string(),
            ));
        }

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk::Extent3D {
                width: render_size.0,
                height: render_size.1,
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
        color_views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_srr,
        )?);
        color_images.push(image);
        clear_values.push(default_clear_color());
        attachments.push(vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: color_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        });
        attachment_refs.push(vk::AttachmentReference {
            attachment: out_ndx as u32,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        });
    }

    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&attachment_refs)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let view_handles: Vec<vk::ImageView> = color_views.iter().map(|view| view.get()).collect();
    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .attachments(&view_handles)
        .width(render_size.0)
        .height(render_size.1)
        .layers(1);
    let framebuffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    let set_layouts: Vec<vk::DescriptorSetLayout> = match extra_resources_layout {
        Some(extra) => vec![*empty_set_layout, extra],
        None => vec![],
    };
    let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
    let geometry_module = if use_geometry_shader {
        let name = if context
            .get_device_features()
            .shader_tessellation_and_geometry_point_size
            != vk::FALSE
        {
            "geom_point_size"
        } else {
            "geom"
        };
        Some(create_shader_module(device, binaries.get(name)?)?)
    } else {
        None
    };

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST).with_full_viewport(render_size.0, render_size.1);
    state.bindings = bindings;
    state.attributes = attributes;
    state.color_attachment_count = spec.outputs.len() as u32;
    if use_descriptor_buffer {
        state.create_flags |= vk::PipelineCreateFlags::DESCRIPTOR_BUFFER_EXT;
    }
    let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vertex_module)];
    if let Some(geometry_module) = &geometry_module {
        stages.push((vk::ShaderStageFlags::GEOMETRY, **geometry_module));
    }
    stages.push((vk::ShaderStageFlags::FRAGMENT, *fragment_module));
    let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

    let descriptor_buffer = match (buffer_descriptors, extra_resources_layout) {
        (Some(descriptors), Some(layout)) => Some(create_descriptor_buffer(context, layout, descriptors)?),
        _ => None,
    };

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        let pre_render_barriers: Vec<vk::ImageMemoryBarrier> = color_images
            .iter()
            .map(|image| {
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    image.get(),
                    color_srr,
                )
            })
            .collect();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &pre_render_barriers,
        );

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(render_size.0, render_size.1))
            .clear_values(&clear_values);
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        if let (Some(extra_resources), Some(empty_set)) = (extra_resources, &empty_set) {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[empty_set.get(), extra_resources],
                &[] as &[u32],
            );
        }
        if let Some((_, address)) = &descriptor_buffer {
            let binding_info = vk::DescriptorBufferBindingInfoEXT {
                address: *address,
                usage: vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT
                    | vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT,
                ..Default::default()
            };
            device.cmd_bind_descriptor_buffers_ext(cmd, &[binding_info]);
            device.cmd_set_descriptor_buffer_offsets_ext(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                1,
                &[0u32],
                &[0 as vk::DeviceSize],
            );
        }
        let buffer_handles: Vec<vk::Buffer> = vertex_buffers.iter().map(|buffer| buffer.get()).collect();
        let offsets = vec![0 as vk::DeviceSize; buffer_handles.len()];
        device.cmd_bind_vertex_buffers(cmd, 0, &buffer_handles, &offsets);
        device.cmd_draw(cmd, positions.len() as u32, 1, 0, 0);
        device.cmd_end_render_pass(cmd);

        let post_render_barriers: Vec<vk::ImageMemoryBarrier> = color_images
            .iter()
            .map(|image| {
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image.get(),
                    color_srr,
                )
            })
            .collect();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &post_render_barriers,
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Read every output back: the image to a buffer, then the first `size` components of the pixel of each element.
    let image_size_bytes = 4 * 4 * render_size.0 as usize * render_size.1 as usize;
    let copy_cmd_pool = make_command_pool(device, queue_family_index)?;
    for (out_ndx, symbol) in spec.outputs.iter().enumerate() {
        let read_buffer = host_buffer(context, image_size_bytes, vk::BufferUsageFlags::TRANSFER_DST)?;
        let copy_cmd_buffer = allocate_command_buffer(device, *copy_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let copy_cmd = *copy_cmd_buffer;
        begin_command_buffer(device, copy_cmd)?;
        unsafe {
            let copy_params = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: render_size.0,
                buffer_image_height: render_size.1,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: render_size.0,
                    height: render_size.1,
                    depth: 1,
                },
            };
            device.cmd_copy_image_to_buffer(
                copy_cmd,
                color_images[out_ndx].get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                read_buffer.get(),
                &[copy_params],
            );
            let barrier = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(read_buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            device.cmd_pipeline_barrier(
                copy_cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, copy_cmd)?;
        submit_commands_and_wait(device, queue, copy_cmd)?;

        let pixels = download_bytes(context, &read_buffer, image_size_bytes)?;
        let out_bytes = symbol.byte_size();
        for val_ndx in 0..num_values {
            let src = &pixels[val_ndx * 16..val_ndx * 16 + out_bytes];
            outputs[out_ndx][val_ndx * out_bytes..(val_ndx + 1) * out_bytes].copy_from_slice(src);
        }
    }

    Ok(())
}

/// `BufferIoExecutor::VarLayout` of every symbol, and the stride shared by all of them (`computeVarLayout`, scalar and vector symbols only).
fn compute_var_layout(symbols: &[Symbol]) -> (Vec<usize>, usize) {
    let std430_alignment = |symbol: &Symbol| {
        let component = if symbol.kind == ScalarKind::Double { 8 } else { 4 };
        match symbol.size {
            1 => component,
            2 => component * 2,
            _ => component * 4,
        }
    };
    let mut max_alignment = 0;
    let mut cur_offset: usize = 0;
    let mut offsets = Vec::new();
    for symbol in symbols {
        let alignment = std430_alignment(symbol);
        cur_offset = cur_offset.next_multiple_of(alignment);
        max_alignment = max_alignment.max(alignment);
        offsets.push(cur_offset);
        cur_offset += symbol.byte_size();
    }
    let stride = if symbols.is_empty() {
        0
    } else {
        cur_offset.next_multiple_of(max_alignment)
    };
    (offsets, stride)
}

/// `BufferIoExecutor::copyToBuffer` for every input
fn pack_inputs(spec: &ShaderSpec, offsets: &[usize], stride: usize, num_values: usize, inputs: &[&[u8]]) -> Vec<u8> {
    let mut bytes = vec![0u8; stride * num_values];
    for (input_ndx, symbol) in spec.inputs.iter().enumerate() {
        let size = symbol.byte_size();
        for elem_ndx in 0..num_values {
            let dst = offsets[input_ndx] + stride * elem_ndx;
            bytes[dst..dst + size].copy_from_slice(&inputs[input_ndx][elem_ndx * size..(elem_ndx + 1) * size]);
        }
    }
    bytes
}

/// `BufferIoExecutor::copyFromBuffer` for every output
fn unpack_outputs(
    spec: &ShaderSpec,
    offsets: &[usize],
    stride: usize,
    num_values: usize,
    buffer: &[u8],
    outputs: &mut [&mut [u8]],
) {
    for (output_ndx, symbol) in spec.outputs.iter().enumerate() {
        let size = symbol.byte_size();
        for elem_ndx in 0..num_values {
            let src = offsets[output_ndx] + stride * elem_ndx;
            outputs[output_ndx][elem_ndx * size..(elem_ndx + 1) * size].copy_from_slice(&buffer[src..src + size]);
        }
    }
}

/// `ComputeShaderExecutor::execute`
fn execute_compute(
    context: &Context<'_>,
    spec: &ShaderSpec,
    extra_resources_layout: Option<vk::DescriptorSetLayout>,
    num_values: usize,
    inputs: &[&[u8]],
    outputs: &mut [&mut [u8]],
    extra_resources: Option<vk::DescriptorSet>,
) -> Result<(), TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let binaries = context.get_binary_collection();

    let (input_offsets, input_stride) = compute_var_layout(spec.inputs);
    let (output_offsets, output_stride) = compute_var_layout(spec.outputs);
    let input_buffer = host_buffer(context, input_stride * num_values, vk::BufferUsageFlags::STORAGE_BUFFER)?;
    let output_buffer = host_buffer(
        context,
        output_stride * num_values,
        vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;
    upload_bytes(
        context,
        &input_buffer,
        &pack_inputs(spec, &input_offsets, input_stride, num_values, inputs),
    )?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let mut set_layouts = vec![*descriptor_set_layout];
    set_layouts.extend(extra_resources_layout);
    let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

    let compute_module = create_shader_module(device, binaries.get("compute")?)?;
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

    let max_values_per_invocation = context.get_device_properties().limits.max_compute_work_group_size[0] as usize;
    let mut cur_offset = 0;
    while cur_offset < num_values {
        let num_to_exec = max_values_per_invocation.min(num_values - cur_offset);

        let output_info = vk::DescriptorBufferInfo {
            buffer: output_buffer.get(),
            offset: (cur_offset * output_stride) as vk::DeviceSize,
            range: (num_to_exec * output_stride) as vk::DeviceSize,
        };
        let input_info = vk::DescriptorBufferInfo {
            buffer: input_buffer.get(),
            offset: (cur_offset * input_stride) as vk::DeviceSize,
            range: (num_to_exec * input_stride) as vk::DeviceSize,
        };
        let mut update = DescriptorSetUpdateBuilder::new().write_single(
            descriptor_set.get(),
            Location::binding(OUTPUT_BUFFER_BINDING),
            vk::DescriptorType::STORAGE_BUFFER,
            &output_info,
        );
        if input_stride != 0 {
            update = update.write_single(
                descriptor_set.get(),
                Location::binding(INPUT_BUFFER_BINDING),
                vk::DescriptorType::STORAGE_BUFFER,
                &input_info,
            );
        }
        update.update(device);

        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            let mut sets = vec![descriptor_set.get()];
            sets.extend(extra_resources);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &sets,
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, num_to_exec as u32, 1, 1);

            let buffer_barrier = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(output_buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;

        cur_offset += num_to_exec;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    let result = download_bytes(context, &output_buffer, output_stride * num_values)?;
    unpack_outputs(spec, &output_offsets, output_stride, num_values, result, outputs);
    Ok(())
}

/// `MeshTaskShaderExecutor::execute`: one mesh (or task, which launches an empty mesh shader) workgroup per value, drawn into a render pass without attachments.
fn execute_mesh_task(
    context: &Context<'_>,
    spec: &ShaderSpec,
    extra_resources_layout: Option<vk::DescriptorSetLayout>,
    num_values: usize,
    inputs: &[&[u8]],
    outputs: &mut [&mut [u8]],
    extra_resources: Option<vk::DescriptorSet>,
) -> Result<(), TestError> {
    use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, InstanceV1_1};

    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let binaries = context.get_binary_collection();
    let use_task = binaries.contains("task");
    let shader_stage = if use_task {
        vk::ShaderStageFlags::TASK_EXT
    } else {
        vk::ShaderStageFlags::MESH_EXT
    };
    let pipeline_stage = if use_task {
        vk::PipelineStageFlags::TASK_SHADER_EXT
    } else {
        vk::PipelineStageFlags::MESH_SHADER_EXT
    };

    let (input_offsets, input_stride) = compute_var_layout(spec.inputs);
    let (output_offsets, output_stride) = compute_var_layout(spec.outputs);
    let input_buffer = host_buffer(context, input_stride * num_values, vk::BufferUsageFlags::STORAGE_BUFFER)?;
    let output_buffer = host_buffer(
        context,
        output_stride * num_values,
        vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;
    upload_bytes(
        context,
        &input_buffer,
        &pack_inputs(spec, &input_offsets, input_stride, num_values, inputs),
    )?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, shader_stage)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, shader_stage)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let mut set_layouts = vec![*descriptor_set_layout];
    set_layouts.extend(extra_resources_layout);
    let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

    let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
    let task_module = if use_task {
        Some(create_shader_module(device, binaries.get("task")?)?)
    } else {
        None
    };

    // `makeRenderPass(vk, device)` and a framebuffer without attachments
    let render_pass = {
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .build()];
        let info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
        Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        )
    };
    let framebuffer = make_framebuffer(device, *render_pass, &[], 1, 1, 1)?;
    let render_area = rect_2d(1, 1);

    let mut shader_stages = Vec::new();
    if let Some(task_module) = &task_module {
        shader_stages.push(
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::TASK_EXT)
                .module(**task_module)
                .name(b"main\0")
                .build(),
        );
    }
    shader_stages.push(
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::MESH_EXT)
            .module(*mesh_module)
            .name(b"main\0")
            .build(),
    );
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: 1.0,
        height: 1.0,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [render_area];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0);
    let multisample_state =
        vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder();
    let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&shader_stages)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .color_blend_state(&color_blend_state)
        .layout(*pipeline_layout)
        .render_pass(*render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipeline = Unique::new(
        device,
        unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?
            .0[0],
    );

    let mut mesh_properties = vk::PhysicalDeviceMeshShaderPropertiesEXT::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut mesh_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    let max_values_per_invocation = (mesh_properties.max_mesh_work_group_size[0] as usize).max(1);

    let mut cur_offset = 0;
    while cur_offset < num_values {
        let num_to_exec = max_values_per_invocation.min(num_values - cur_offset);

        let output_info = vk::DescriptorBufferInfo {
            buffer: output_buffer.get(),
            offset: (cur_offset * output_stride) as vk::DeviceSize,
            range: (num_to_exec * output_stride) as vk::DeviceSize,
        };
        let input_info = vk::DescriptorBufferInfo {
            buffer: input_buffer.get(),
            offset: (cur_offset * input_stride) as vk::DeviceSize,
            range: (num_to_exec * input_stride) as vk::DeviceSize,
        };
        let mut update = DescriptorSetUpdateBuilder::new().write_single(
            descriptor_set.get(),
            Location::binding(OUTPUT_BUFFER_BINDING),
            vk::DescriptorType::STORAGE_BUFFER,
            &output_info,
        );
        if input_stride != 0 {
            update = update.write_single(
                descriptor_set.get(),
                Location::binding(INPUT_BUFFER_BINDING),
                vk::DescriptorType::STORAGE_BUFFER,
                &input_info,
            );
        }
        update.update(device);

        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            render_area,
            default_clear_color(),
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            let mut sets = vec![descriptor_set.get()];
            sets.extend(extra_resources);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &sets,
                &[] as &[u32],
            );
            device.cmd_draw_mesh_tasks_ext(cmd, num_to_exec as u32, 1, 1);
        }
        end_render_pass(device, cmd);
        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(output_buffer.get())
            .offset(0)
            .size(vk::WHOLE_SIZE)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                pipeline_stage,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;

        cur_offset += num_to_exec;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    let result = download_bytes(context, &output_buffer, output_stride * num_values)?;
    unpack_outputs(spec, &output_offsets, output_stride, num_values, result, outputs);
    Ok(())
}

/// `TessControlExecutor::execute` and `TessEvaluationExecutor::execute`: patches of 3 control points (one element each) or of 2 isoline
/// vertices (two elements each) through `TessellationExecutor::renderTess`.
#[allow(clippy::too_many_arguments)]
fn execute_tess(
    context: &Context<'_>,
    shader_type: ShaderType,
    spec: &ShaderSpec,
    extra_resources_layout: Option<vk::DescriptorSetLayout>,
    num_values: usize,
    inputs: &[&[u8]],
    outputs: &mut [&mut [u8]],
    extra_resources: Option<vk::DescriptorSet>,
) -> Result<(), TestError> {
    if context.get_device_features().tessellation_shader == vk::FALSE {
        return Err(TestError::NotSupported(
            "Tessellation shader is not supported by device".to_string(),
        ));
    }

    let (patch_size, aligned_values, vertex_count) = if shader_type == ShaderType::TessellationControl {
        (3usize, num_values, 3 * num_values)
    } else {
        let patch_size = 2usize;
        let aligned_values = num_values.next_multiple_of(patch_size);
        (patch_size, aligned_values, aligned_values)
    };

    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let binaries = context.get_binary_collection();

    let (input_offsets, input_stride) = compute_var_layout(spec.inputs);
    let (output_offsets, output_stride) = compute_var_layout(spec.outputs);
    let input_buffer = host_buffer(
        context,
        input_stride * aligned_values,
        vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;
    let output_buffer = host_buffer(
        context,
        output_stride * aligned_values,
        vk::BufferUsageFlags::STORAGE_BUFFER,
    )?;
    upload_bytes(
        context,
        &input_buffer,
        &pack_inputs(spec, &input_offsets, input_stride, num_values, inputs),
    )?;

    let render_size = (DEFAULT_RENDER_WIDTH, DEFAULT_RENDER_HEIGHT);
    let color_format = vk::Format::R8G8B8A8_UNORM;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(color_format)
        .extent(vk::Extent3D {
            width: render_size.0,
            height: render_size.1,
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
    let color_image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;

    let attachments = [vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format: color_format,
        samples: vk::SampleCountFlags::_1,
        load_op: vk::AttachmentLoadOp::CLEAR,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let color_refs = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let view_handles = [color_view.get()];
    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .attachments(&view_handles)
        .width(render_size.0)
        .height(render_size.1)
        .layers(1);
    let framebuffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    {
        let output_info = vk::DescriptorBufferInfo {
            buffer: output_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };
        let input_info = vk::DescriptorBufferInfo {
            buffer: input_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };
        let mut update = DescriptorSetUpdateBuilder::new().write_single(
            descriptor_set.get(),
            Location::binding(OUTPUT_BUFFER_BINDING),
            vk::DescriptorType::STORAGE_BUFFER,
            &output_info,
        );
        if input_stride * aligned_values > 0 {
            update = update.write_single(
                descriptor_set.get(),
                Location::binding(INPUT_BUFFER_BINDING),
                vk::DescriptorType::STORAGE_BUFFER,
                &input_info,
            );
        }
        update.update(device);
    }

    let mut set_layouts = vec![*descriptor_set_layout];
    set_layouts.extend(extra_resources_layout);
    let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let tess_control_module = create_shader_module(device, binaries.get("tess_control")?)?;
    let tess_eval_module = create_shader_module(device, binaries.get("tess_eval")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(render_size.0, render_size.1);
    state.patch_control_points = Some(patch_size as u32);
    state.color_attachment_count = 1;
    let stages = [
        (vk::ShaderStageFlags::VERTEX, *vertex_module),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tess_control_module),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tess_eval_module),
        (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
    ];
    let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    unsafe {
        let clear_values = [default_clear_color()];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(render_size.0, render_size.1))
            .clear_values(&clear_values);
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        let mut sets = vec![descriptor_set.get()];
        sets.extend(extra_resources);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &sets,
            &[] as &[u32],
        );
        device.cmd_draw(cmd, vertex_count as u32, 1, 0, 0);
        device.cmd_end_render_pass(cmd);

        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(output_buffer.get())
            .offset(0)
            .size(vk::WHOLE_SIZE)
            .build();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TESSELLATION_EVALUATION_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let result = download_bytes(context, &output_buffer, output_stride * aligned_values)?;
    unpack_outputs(spec, &output_offsets, output_stride, num_values, result, outputs);
    Ok(())
}
