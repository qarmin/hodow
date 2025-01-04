// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsDrawTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are pre-expanded in `shaders/manifest/dgc_graphics_draw.toml`
// (`scripts/gen_dgc_graphics_draw_manifest.py`), one set per (extra stages, checkDrawParams, execution set / flipped triangles).
// The monolithic and the four `gpl_*` flavours are ported (the libraries are built by `build_draw_pipeline` itself); `shader_objects`
// needs the shader object plumbing of `DGCShaderExt` and stays a NotPorted stub.
//
// Test mechanism (upstream comments): a 2x2 framebuffer, three sequences drawing triangles over the pixels 0 1 / 1 2, with a push constant
// for the red channel, a vertex or index buffer token (or none), a draw token and optionally an execution set token whose pipelines flip
// the first triangle(s) horizontally and use another fragment shader for the blue channel.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtExtendedDynamicStateExtensionDeviceCommands,
    ExtShaderObjectExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::dgc_graphics_draw::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::image_util::{
    make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout_with_push_constants, make_render_pass,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndexBufferViewD3D12, IndirectCommandsLayoutBuilderExt,
    PreprocessBufferExt, check_dgc_ext_support, create_dgc_shader, device_generated_commands_properties,
    preprocess_to_execute_barrier_ext,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::tests::shader_object::util::ShaderObject;
use crate::vkt::{Context, TestCase, TestInstance};

const PER_TRIANGLE_VERTICES: u32 = 3;
const VERT_NORMAL_RED_OFFSET: f32 = 0.125;
const VERT_FLIP_RED_OFFSET: f32 = 0.25;

type Vec4 = [f32; 4];

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Draw,
    /// No vertex or index buffer tokens.
    DrawSimple,
    DrawIndexed,
    /// Using VK_INDIRECT_COMMANDS_INPUT_MODE_DXGI_INDEX_BUFFER_EXT.
    DrawIndexedDx,
}

fn is_indexed(test_type: TestType) -> bool {
    matches!(test_type, TestType::DrawIndexed | TestType::DrawIndexedDx)
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ExtraStages {
    None,
    Tessellation,
    Geometry,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PreprocessType {
    None,
    SameStateCmdBuffer,
    OtherStateCmdBuffer,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PipelineType {
    Monolithic,
    ShaderObjects,
    GplFast,
    GplOptimized,
    GplMixBaseFast,
    GplMixBaseOpt,
}

impl PipelineType {
    fn is_gpl(self) -> bool {
        !matches!(self, PipelineType::Monolithic | PipelineType::ShaderObjects)
    }

    fn is_shader_objects(self) -> bool {
        self == PipelineType::ShaderObjects
    }

    /// `getGeneralConstructionType`
    fn general_construction(self) -> Construction {
        match self {
            PipelineType::Monolithic | PipelineType::ShaderObjects => Construction::Monolithic,
            PipelineType::GplFast | PipelineType::GplMixBaseFast => Construction::FastLinked,
            PipelineType::GplOptimized | PipelineType::GplMixBaseOpt => Construction::LinkTimeOptimized,
        }
    }

    /// The construction type of each of the three sequences' pipelines.
    fn construction_types(self) -> [Construction; 3] {
        let mut types = [self.general_construction(); 3];
        match self {
            PipelineType::GplMixBaseOpt => types[1] = Construction::FastLinked,
            PipelineType::GplMixBaseFast => types[1] = Construction::LinkTimeOptimized,
            _ => {}
        }
        types
    }

    fn name(self) -> &'static str {
        match self {
            PipelineType::Monolithic => "monolithic",
            PipelineType::ShaderObjects => "shader_objects",
            PipelineType::GplFast => "gpl_fast",
            PipelineType::GplOptimized => "gpl_optimized",
            PipelineType::GplMixBaseFast => "gpl_mix_base_fast",
            PipelineType::GplMixBaseOpt => "gpl_mix_base_opt",
        }
    }
}

#[derive(Clone, Copy)]
struct DrawTestParams {
    test_type: TestType,
    pipeline_type: PipelineType,
    extra_stages: ExtraStages,
    preprocess_type: PreprocessType,
    check_draw_params: bool,
    use_execution_set: bool,
    unordered_sequences: bool,
}

impl DrawTestParams {
    #[expect(dead_code, reason = "ported with upstream's helpers, no caller yet")]
    fn has_extra_stages(&self) -> bool {
        self.extra_stages != ExtraStages::None
    }

    fn stage_flags(&self) -> vk::ShaderStageFlags {
        let mut stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        match self.extra_stages {
            ExtraStages::Tessellation => {
                stages |= vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION;
            }
            ExtraStages::Geometry => stages |= vk::ShaderStageFlags::GEOMETRY,
            ExtraStages::None => {}
        }
        stages
    }

    fn input_mode_flags(&self) -> vk::IndirectCommandsInputModeFlagsEXT {
        match self.test_type {
            TestType::DrawIndexed => vk::IndirectCommandsInputModeFlagsEXT::VULKAN_INDEX_BUFFER,
            TestType::DrawIndexedDx => vk::IndirectCommandsInputModeFlagsEXT::DXGI_INDEX_BUFFER,
            _ => vk::IndirectCommandsInputModeFlagsEXT::empty(),
        }
    }

    fn do_preprocess(&self) -> bool {
        self.preprocess_type != PreprocessType::None
    }

    /// The key of the shader set in the manifest (`gen_dgc_graphics_draw_manifest.py`).
    fn program_key(&self) -> String {
        let extra = match self.extra_stages {
            ExtraStages::None => "none",
            ExtraStages::Tessellation => "tess",
            ExtraStages::Geometry => "geom",
        };
        let execution_set = if !self.use_execution_set {
            "noes"
        } else if self.test_type == TestType::Draw {
            "es1"
        } else {
            "es2"
        };
        format!(
            "draw_{extra}_{}_{execution_set}",
            if self.check_draw_params { "dp" } else { "nodp" }
        )
    }
}

struct DrawCase {
    name: String,
    params: DrawTestParams,
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let stages = params.stage_flags();
        let bind_stages = if params.use_execution_set {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        let use_eso = params.pipeline_type.is_shader_objects();
        let (bind_stages_pipeline, bind_stages_shader_object) = if use_eso {
            (vk::ShaderStageFlags::empty(), bind_stages)
        } else {
            (bind_stages, vk::ShaderStageFlags::empty())
        };

        check_dgc_ext_support(
            context,
            stages,
            bind_stages_pipeline,
            bind_stages_shader_object,
            params.input_mode_flags(),
            false,
        )?;

        if params.extra_stages == ExtraStages::Tessellation
            && context.get_device_features().tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported("tessellationShader not supported".to_string()));
        }
        if params.extra_stages == ExtraStages::Geometry && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("geometryShader not supported".to_string()));
        }
        if params.check_draw_params {
            context.require_device_functionality("VK_KHR_shader_draw_parameters")?;
        }
        if use_eso {
            context.require_device_functionality("VK_EXT_shader_object")?;
            if params.use_execution_set
                && device_generated_commands_properties(context).max_indirect_shader_object_count == 0
            {
                return Err(TestError::NotSupported(
                    "maxIndirectShaderObjectCount is zero".to_string(),
                ));
            }
        }
        if params.pipeline_type.is_gpl() {
            // The code is not prepared otherwise: the libraries are only used with an execution set.
            context.require_device_functionality("VK_EXT_graphics_pipeline_library")?;
            check_pipeline_construction_requirements(context, PipelineConstructionType::FastLinkedLibrary)?;
            if matches!(
                params.pipeline_type,
                PipelineType::GplOptimized | PipelineType::GplMixBaseFast
            ) {
                check_pipeline_construction_requirements(context, PipelineConstructionType::LinkTimeOptimizedLibrary)?;
            }
        }
        require_dynamic_vertex_stride(context)
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.params.program_key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawInstance {
            context,
            params: self.params,
        })
    }
}

/// VK_DYNAMIC_STATE_VERTEX_INPUT_BINDING_STRIDE and `vkCmdBindVertexBuffers2` are core in 1.3 and VK_EXT_extended_dynamic_state before.
fn require_dynamic_vertex_stride(context: &Context<'_>) -> Result<(), TestError> {
    if context.api_version() >= (1, 3, 0) {
        return Ok(());
    }
    context.require_device_functionality("VK_EXT_extended_dynamic_state")
}

fn bind_vertex_buffers2(
    context: &Context<'_>,
    cmd_buffer: vk::CommandBuffer,
    buffer: vk::Buffer,
    size: vk::DeviceSize,
    stride: vk::DeviceSize,
) {
    let device = context.get_device();
    let (major, minor, _) = context.api_version();
    unsafe {
        if (major, minor) >= (1, 3) {
            device.cmd_bind_vertex_buffers2(cmd_buffer, 0, &[buffer], &[0], &[size], &[stride]);
        } else {
            // Named through the trait: the shader object trait provides the same command.
            ExtExtendedDynamicStateExtensionDeviceCommands::cmd_bind_vertex_buffers2_ext(
                device,
                cmd_buffer,
                0,
                &[buffer],
                &[0],
                &[size],
                &[stride],
            );
        }
    }
}

/// `pushBackElement`: the words of `element` appended to the indirect commands.
pub(super) fn push_back_element<T: Copy>(data: &mut Vec<u32>, element: &T) {
    let size = std::mem::size_of::<T>();
    debug_assert_eq!(size % 4, 0);
    // SAFETY: `element` is a live value of `size` bytes; the types used here have no padding.
    let bytes = unsafe { std::slice::from_raw_parts((element as *const T).cast::<u8>(), size) };
    data.extend(
        bytes
            .chunks_exact(4)
            .map(|word| u32::from_ne_bytes([word[0], word[1], word[2], word[3]])),
    );
}

pub(super) fn write_host_buffer<T: Copy>(
    device: &Device,
    buffer: &BufferWithMemory<'_>,
    data: &[T],
) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    // SAFETY: the buffer was created with the size of `data`.
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr().cast::<u8>(),
            alloc.get_host_ptr(),
            std::mem::size_of_val(data),
        )
    };
    flush_alloc(device, alloc)
}

/// A host-visible buffer with a device address, filled with `data`.
pub(super) fn make_address_buffer<'a, T: Copy>(
    context: &'a Context<'a>,
    data: &[T],
    usage: vk::BufferUsageFlags,
) -> Result<(BufferWithMemory<'a>, vk::DeviceAddress), TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            std::mem::size_of_val(data) as vk::DeviceSize,
            usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    write_host_buffer(device, &buffer, data)?;
    let address = buffer_device_address(device, buffer.get());
    Ok((buffer, address))
}

struct VertexBufferInfo<'a> {
    buffer: BufferWithMemory<'a>,
    address: vk::DeviceAddress,
    size: u32,
    stride: u32,
}

/// `makeVertexBuffers`
fn make_vertex_buffers<'a>(
    context: &'a Context<'a>,
    vertices: &[Vec4],
    sequence_count: u32,
    pixel_count: u32,
) -> Result<Vec<VertexBufferInfo<'a>>, TestError> {
    let usage = vk::BufferUsageFlags::VERTEX_BUFFER;
    let vertex_size = std::mem::size_of::<Vec4>() as u32;
    let mut ret = Vec::new();

    if sequence_count == 1 {
        // Flat buffer containing all vertices.
        let (buffer, address) = make_address_buffer(context, vertices, usage)?;
        ret.push(VertexBufferInfo {
            buffer,
            address,
            size: std::mem::size_of_val(vertices) as u32,
            stride: vertex_size,
        });
        return Ok(ret);
    }

    // Vertex buffers: one per sequence, with the first one containing the first triangle and the last one containing the last triangle.
    let zeroed_vertex: Vec4 = [0.0; 4];
    let stride_normal = vertex_size;
    let stride_wide = stride_normal * 2;
    let tri = PER_TRIANGLE_VERTICES as usize;

    let mut next_vertex = 0usize;

    // First vertex buffer.
    let mut first = Vec::new();
    for _ in 0..tri {
        first.push(vertices[next_vertex]);
        next_vertex += 1;
    }

    // Second vertex buffer.
    let mut second = Vec::new();
    for _ in 0..(pixel_count - 2) as usize {
        for _ in 0..tri {
            second.push(vertices[next_vertex]);
            next_vertex += 1;
            // Padding between vertices for the wider stride.
            second.push(zeroed_vertex);
        }
    }

    // Third vertex buffer.
    let mut third = vec![zeroed_vertex; next_vertex];
    for _ in 0..tri {
        third.push(vertices[next_vertex]);
        next_vertex += 1;
    }

    let strides = [stride_normal, stride_wide, stride_normal];
    for (data, stride) in [first, second, third].into_iter().zip(strides) {
        let (buffer, address) = make_address_buffer(context, &data, usage)?;
        ret.push(VertexBufferInfo {
            buffer,
            address,
            size: std::mem::size_of_val(data.as_slice()) as u32,
            stride,
        });
    }
    Ok(ret)
}

struct IndexBufferInfo<'a> {
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    buffer: BufferWithMemory<'a>,
    address: vk::DeviceAddress,
    size: u32,
    index_type: vk::IndexType,
    vertex_offset: i32,
}

/// `makeIndexBuffers`
fn make_index_buffers<'a>(
    context: &'a Context<'a>,
    sequence_count: u32,
    pixel_count: u32,
) -> Result<Vec<IndexBufferInfo<'a>>, TestError> {
    let mut ret = Vec::new();
    if sequence_count == 0 {
        return Ok(ret);
    }

    let usage = vk::BufferUsageFlags::INDEX_BUFFER;
    const INVALID_INDEX_16: u16 = u16::MAX / 2;
    let index_count_middle = (pixel_count - 2) * PER_TRIANGLE_VERTICES;

    let first: Vec<u32> = (0..PER_TRIANGLE_VERTICES).collect();
    let second: Vec<u32> = (0..index_count_middle).map(|i| i + PER_TRIANGLE_VERTICES).collect();

    let prev_vertex_count = (pixel_count - 1) * PER_TRIANGLE_VERTICES;
    let vertex_offset: u16 = 20;
    let mut third: Vec<u16> = vec![INVALID_INDEX_16; prev_vertex_count as usize];
    for i in 0..PER_TRIANGLE_VERTICES {
        third.push((i + prev_vertex_count) as u16 + vertex_offset);
    }

    let vertex_offsets = [0i32, 0, -i32::from(vertex_offset)];

    let (buffer, address) = make_address_buffer(context, &first, usage)?;
    ret.push(IndexBufferInfo {
        buffer,
        address,
        size: std::mem::size_of_val(first.as_slice()) as u32,
        index_type: vk::IndexType::UINT32,
        vertex_offset: vertex_offsets[0],
    });
    let (buffer, address) = make_address_buffer(context, &second, usage)?;
    ret.push(IndexBufferInfo {
        buffer,
        address,
        size: std::mem::size_of_val(second.as_slice()) as u32,
        index_type: vk::IndexType::UINT32,
        vertex_offset: vertex_offsets[1],
    });
    let (buffer, address) = make_address_buffer(context, &third, usage)?;
    ret.push(IndexBufferInfo {
        buffer,
        address,
        size: std::mem::size_of_val(third.as_slice()) as u32,
        index_type: vk::IndexType::UINT16,
        vertex_offset: vertex_offsets[2],
    });
    Ok(ret)
}

/// `maybeCreateModule`
pub(super) fn maybe_create_module<'a>(
    device: &'a Device,
    binaries: &BinaryCollection,
    name: &str,
) -> Result<Option<Unique<'a, vk::ShaderModule>>, TestError> {
    if binaries.contains(name) {
        Ok(Some(create_shader_module(device, binaries.get(name)?)?))
    } else {
        Ok(None)
    }
}

pub(super) fn module_handle(module: &Option<Unique<'_, vk::ShaderModule>>) -> Option<vk::ShaderModule> {
    module.as_ref().map(|module| **module)
}

#[derive(Clone, Copy)]
pub(super) struct StageModules {
    pub vert: vk::ShaderModule,
    pub tesc: Option<vk::ShaderModule>,
    pub tese: Option<vk::ShaderModule>,
    pub geom: Option<vk::ShaderModule>,
    pub frag: vk::ShaderModule,
}

/// `PipelineConstructionType` of the DGC tests: a monolithic pipeline or the four graphics pipeline libraries linked.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Construction {
    Monolithic,
    FastLinked,
    LinkTimeOptimized,
}

/// A pipeline and the libraries it was linked from (they must outlive it).
pub(super) struct DrawPipeline<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    _libraries: Vec<Unique<'a, vk::Pipeline>>,
}

impl std::ops::Deref for DrawPipeline<'_> {
    type Target = vk::Pipeline;

    fn deref(&self) -> &vk::Pipeline {
        &self.pipeline
    }
}

/// What `build_draw_pipeline` varies.
#[derive(Clone, Copy)]
pub(super) struct PipelineOptions {
    pub extent: (u32, u32),
    pub topology: vk::PrimitiveTopology,
    pub patch_control_points: u32,
    /// The stride of the binding is dynamic state (the DGC vertex buffer token or `vkCmdBindVertexBuffers2` give it).
    pub dynamic_stride: bool,
    pub dynamic_patch_control_points: bool,
    /// No vertex binding at all.
    pub no_vertex_input: bool,
    /// A second attribute (location 1, offset 16) and a 32 byte vertex.
    pub extra_attribute: bool,
    pub indirect_bindable: bool,
    pub construction: Construction,
    /// Depth test and write enabled, compare op GREATER_OR_EQUAL.
    pub depth_test: bool,
    /// Dynamic rendering: the pipeline is created without a render pass with these formats (and `render_pass` null).
    pub rendering: Option<RenderingFormats>,
}

/// The `VkPipelineRenderingCreateInfo` of a pipeline for dynamic rendering with one colour attachment and a depth attachment.
#[derive(Clone, Copy)]
pub(super) struct RenderingFormats {
    pub view_mask: u32,
    pub color_format: vk::Format,
    pub depth_format: vk::Format,
}

/// A monolithic graphics pipeline with the defaults of `makeGraphicsPipeline` and, unless `no_vertex_input`, one vertex binding at
/// location 0.
pub(super) fn build_draw_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    modules: &StageModules,
    options: &PipelineOptions,
) -> Result<DrawPipeline<'a>, TestError> {
    build_draw_pipeline_with_input(
        device,
        pipeline_layout,
        render_pass,
        modules,
        options,
        None,
        ExtraState::default(),
    )
}

/// What `build_draw_pipeline_with_input` can change beyond `PipelineOptions`.
#[derive(Clone, Copy, Default)]
pub(super) struct ExtraState {
    /// The descriptor heap pipeline flag (monolithic pipelines only; the layout is then usually null).
    pub descriptor_heap: bool,
    /// The compare op of the depth test, when `PipelineOptions::depth_test` is set (GREATER_OR_EQUAL otherwise).
    pub depth_compare_op: Option<vk::CompareOp>,
}

/// The vertex bindings and attributes of a pipeline that `build_draw_pipeline` cannot express.
pub(super) type CustomVertexInput<'b> = (
    &'b [vk::VertexInputBindingDescription],
    &'b [vk::VertexInputAttributeDescription],
);

/// `build_draw_pipeline` with the vertex input state replaced by `custom_input` when given and the `ExtraState`.
pub(super) fn build_draw_pipeline_with_input<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    modules: &StageModules,
    options: &PipelineOptions,
    custom_input: Option<CustomVertexInput<'_>>,
    extra_state: ExtraState,
) -> Result<DrawPipeline<'a>, TestError> {
    let ExtraState {
        descriptor_heap,
        depth_compare_op,
    } = extra_state;
    let PipelineOptions {
        extent,
        topology,
        patch_control_points,
        dynamic_stride,
        dynamic_patch_control_points,
        no_vertex_input,
        extra_attribute,
        indirect_bindable,
        construction,
        depth_test,
        rendering,
    } = *options;
    let entry = c"main";
    let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(stage)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build()
    };
    let mut stages = vec![make_stage(vk::ShaderStageFlags::VERTEX, modules.vert)];
    if let Some(module) = modules.tesc {
        stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, module));
    }
    if let Some(module) = modules.tese {
        stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, module));
    }
    if let Some(module) = modules.geom {
        stages.push(make_stage(vk::ShaderStageFlags::GEOMETRY, module));
    }
    stages.push(make_stage(vk::ShaderStageFlags::FRAGMENT, modules.frag));
    let has_tessellation = modules.tesc.is_some() && modules.tese.is_some();
    let tessellation = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(patch_control_points);

    let bindings = [vk::VertexInputBindingDescription::builder()
        .binding(0)
        .stride(if extra_attribute {
            2 * std::mem::size_of::<Vec4>() as u32
        } else if dynamic_stride {
            0
        } else {
            std::mem::size_of::<Vec4>() as u32
        })
        .input_rate(vk::VertexInputRate::VERTEX)
        .build()];
    let mut attributes = vec![
        vk::VertexInputAttributeDescription::builder()
            .location(0)
            .binding(0)
            .format(vk::Format::R32G32B32A32_SFLOAT)
            .offset(0)
            .build(),
    ];
    if extra_attribute {
        attributes.push(
            vk::VertexInputAttributeDescription::builder()
                .location(1)
                .binding(0)
                .format(vk::Format::R32G32B32A32_SFLOAT)
                .offset(std::mem::size_of::<Vec4>() as u32)
                .build(),
        );
    }
    let vertex_input = if let Some((custom_bindings, custom_attributes)) = custom_input {
        vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(custom_bindings)
            .vertex_attribute_descriptions(custom_attributes)
    } else if no_vertex_input {
        vk::PipelineVertexInputStateCreateInfo::builder()
    } else {
        vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes)
    };
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: extent.0 as f32,
        height: extent.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, extent.0, extent.1)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);

    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);
    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .build();
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(depth_test)
        .depth_write_enable(depth_test)
        .depth_compare_op(if depth_test {
            depth_compare_op.unwrap_or(vk::CompareOp::GREATER_OR_EQUAL)
        } else {
            vk::CompareOp::LESS_OR_EQUAL
        })
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::ZERO)
        .dst_color_blend_factor(vk::BlendFactor::ZERO)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ZERO)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(
            vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A,
        )
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachments)
        .blend_constants([0.0; 4]);

    let mut dynamic_states = Vec::new();
    if dynamic_stride {
        dynamic_states.push(vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE);
    }
    if dynamic_patch_control_points {
        dynamic_states.push(vk::DynamicState::PATCH_CONTROL_POINTS_EXT);
    }
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let flags2_info = vk::PipelineCreateFlags2CreateInfo {
        flags: vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT,
        ..Default::default()
    };

    let color_formats = [rendering.map_or(vk::Format::UNDEFINED, |formats| formats.color_format)];
    let rendering_info = vk::PipelineRenderingCreateInfo {
        view_mask: rendering.map_or(0, |formats| formats.view_mask),
        color_attachment_count: 1,
        color_attachment_formats: color_formats.as_ptr(),
        depth_attachment_format: rendering.map_or(vk::Format::UNDEFINED, |formats| formats.depth_format),
        stencil_attachment_format: vk::Format::UNDEFINED,
        ..Default::default()
    };

    if construction != Construction::Monolithic {
        // What `GraphicsPipelineWrapper::buildPipeline` does for the library construction types: the four parts as library pipelines,
        // then one pipeline linking them.
        let link_time_optimized = construction == Construction::LinkTimeOptimized;
        let mut library_flags = vk::PipelineCreateFlags::LIBRARY_KHR;
        if link_time_optimized {
            library_flags |= vk::PipelineCreateFlags::RETAIN_LINK_TIME_OPTIMIZATION_INFO_EXT;
        }
        let pre_rasterization_stages: Vec<vk::PipelineShaderStageCreateInfo> = stages
            .iter()
            .filter(|stage| stage.stage != vk::ShaderStageFlags::FRAGMENT)
            .copied()
            .collect();
        let fragment_stages: Vec<vk::PipelineShaderStageCreateInfo> = stages
            .iter()
            .filter(|stage| stage.stage == vk::ShaderStageFlags::FRAGMENT)
            .copied()
            .collect();

        let create_library =
            |library: vk::GraphicsPipelineLibraryFlagsEXT| -> Result<Unique<'a, vk::Pipeline>, TestError> {
                let library_info = vk::GraphicsPipelineLibraryCreateInfoEXT {
                    flags: library,
                    ..Default::default()
                };
                let mut flags2 = flags2_info;
                flags2.next = (&library_info as *const vk::GraphicsPipelineLibraryCreateInfoEXT).cast();
                // The rendering info goes to the libraries that need the attachment formats; it chains to the library info.
                let mut rendering_copy = rendering_info;
                rendering_copy.next = (&library_info as *const vk::GraphicsPipelineLibraryCreateInfoEXT).cast();
                let uses_rendering =
                    rendering.is_some() && library != vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE;
                if uses_rendering {
                    flags2.next = (&rendering_copy as *const vk::PipelineRenderingCreateInfo).cast();
                }

                let mut info = vk::GraphicsPipelineCreateInfo::builder()
                    .flags(library_flags)
                    .layout(pipeline_layout)
                    .base_pipeline_index(0);
                if library == vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE {
                    info = info
                        .vertex_input_state(&vertex_input)
                        .input_assembly_state(&input_assembly);
                } else if library == vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS {
                    info = info
                        .stages(&pre_rasterization_stages)
                        .viewport_state(&viewport_state)
                        .rasterization_state(&rasterization)
                        .render_pass(render_pass)
                        .subpass(0);
                    if has_tessellation {
                        info = info.tessellation_state(&tessellation);
                    }
                } else if library == vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER {
                    info = info
                        .stages(&fragment_stages)
                        .depth_stencil_state(&depth_stencil)
                        .multisample_state(&multisample)
                        .render_pass(render_pass)
                        .subpass(0);
                } else {
                    info = info
                        .multisample_state(&multisample)
                        .color_blend_state(&color_blend)
                        .render_pass(render_pass)
                        .subpass(0);
                }
                if !dynamic_states.is_empty() {
                    info = info.dynamic_state(&dynamic_state);
                }
                let mut info = info.build();
                info.next = if indirect_bindable {
                    (&flags2 as *const vk::PipelineCreateFlags2CreateInfo).cast()
                } else if uses_rendering {
                    (&rendering_copy as *const vk::PipelineRenderingCreateInfo).cast()
                } else {
                    (&library_info as *const vk::GraphicsPipelineLibraryCreateInfoEXT).cast()
                };

                let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
                    .vk_check("vkCreateGraphicsPipelines")?;
                Ok(Unique::new(device, pipelines.0[0]))
            };

        let libraries = vec![
            create_library(vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE)?,
            create_library(vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS)?,
            create_library(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER)?,
            create_library(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_OUTPUT_INTERFACE)?,
        ];
        let handles: Vec<vk::Pipeline> = libraries.iter().map(|library| **library).collect();
        let link_info = vk::PipelineLibraryCreateInfoKHR::builder().libraries(&handles).build();
        let mut flags2_link = flags2_info;
        flags2_link.next = (&link_info as *const vk::PipelineLibraryCreateInfoKHR).cast();

        let link_flags = if link_time_optimized {
            vk::PipelineCreateFlags::LINK_TIME_OPTIMIZATION_EXT
        } else {
            vk::PipelineCreateFlags::empty()
        };
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .flags(link_flags)
            .layout(pipeline_layout)
            .base_pipeline_index(0)
            .build();
        info.next = if indirect_bindable {
            (&flags2_link as *const vk::PipelineCreateFlags2CreateInfo).cast()
        } else {
            (&link_info as *const vk::PipelineLibraryCreateInfoKHR).cast()
        };
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        return Ok(DrawPipeline {
            pipeline: Unique::new(device, pipelines.0[0]),
            _libraries: libraries,
        });
    }

    let mut builder = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);
    if has_tessellation {
        builder = builder.tessellation_state(&tessellation);
    }
    if !dynamic_states.is_empty() {
        builder = builder.dynamic_state(&dynamic_state);
    }
    let mut info = builder.build();
    let chain_rendering = rendering_info;
    let mut chain_flags2 = flags2_info;
    chain_flags2.flags = vk::PipelineCreateFlags2::empty();
    if indirect_bindable {
        chain_flags2.flags |= vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT;
    }
    if descriptor_heap {
        chain_flags2.flags |= vk::PipelineCreateFlags2::DESCRIPTOR_HEAP_EXT;
    }
    let chain_needed = indirect_bindable || descriptor_heap;
    if rendering.is_some() {
        info.next = (&chain_rendering as *const vk::PipelineRenderingCreateInfo).cast();
        if chain_needed {
            chain_flags2.next = info.next;
            info.next = (&chain_flags2 as *const vk::PipelineCreateFlags2CreateInfo).cast();
        }
    } else if chain_needed {
        info.next = (&chain_flags2 as *const vk::PipelineCreateFlags2CreateInfo).cast();
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(DrawPipeline {
        pipeline: Unique::new(device, pipelines.0[0]),
        _libraries: Vec::new(),
    })
}

/// `CreateEmptyResourceHeap`: a resource heap made of the reserved range only and the info to bind it; None when the implementation needs no
/// reserved range (the upstream helper then returns an empty pair and the caller skips the bind).
pub(super) fn create_empty_resource_heap<'a>(
    context: &'a Context<'a>,
) -> Result<
    Option<(
        crate::vkt::tests::robustness::robustness_util::HostBuffer<'a>,
        vk::BindHeapInfoEXT,
    )>,
    TestError,
> {
    let device = context.get_device();
    let mut heap_props = vk::PhysicalDeviceDescriptorHeapPropertiesEXT::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut heap_props);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    let resource_heap_size = heap_props.min_resource_heap_reserved_range;
    if resource_heap_size == 0 {
        return Ok(None);
    }
    let heap = crate::vkt::tests::robustness::robustness_util::HostBuffer::new_resource_heap(
        device,
        context,
        resource_heap_size,
    )?;
    let bind_info = vk::BindHeapInfoEXT {
        heap_range: vk::DeviceAddressRangeEXT {
            address: heap.device_address(device),
            size: resource_heap_size,
        },
        reserved_range_offset: 0,
        reserved_range_size: heap_props.min_resource_heap_reserved_range,
        ..Default::default()
    };
    Ok(Some((heap, bind_info)))
}

/// `vkt::shaderobjutil::bindShaderObjectState` for what the DGC tests set: the shader object utility's defaults for every state, then the
/// vertex input (when given) and the patch control points (when not zero). Rasterization, multisample, depth/stencil and color blend states are
/// the defaults of the utility, as the upstream tests pass null for them.
pub(super) fn bind_shader_object_state(
    context: &Context<'_>,
    cmd_buffer: vk::CommandBuffer,
    topology: vk::PrimitiveTopology,
    patch_control_points: u32,
    extent: (u32, u32),
    vertex_input: Option<(
        &[vk::VertexInputBindingDescription2EXT],
        &[vk::VertexInputAttributeDescription2EXT],
    )>,
) {
    bind_shader_object_state_on(
        context.get_device(),
        context,
        cmd_buffer,
        topology,
        patch_control_points,
        extent,
        vertex_input,
    );
}

/// `bind_shader_object_state` on a device other than the Context's, such as a `RobustnessDevice`'s.
pub(super) fn bind_shader_object_state_on(
    device: &Device,
    context: &Context<'_>,
    cmd_buffer: vk::CommandBuffer,
    topology: vk::PrimitiveTopology,
    patch_control_points: u32,
    extent: (u32, u32),
    vertex_input: Option<(
        &[vk::VertexInputBindingDescription2EXT],
        &[vk::VertexInputAttributeDescription2EXT],
    )>,
) {
    crate::vkt::tests::shader_object::util::set_default_shader_object_dynamic_states(
        device,
        cmd_buffer,
        context.get_device_extensions(),
        topology,
        false,
        true,
        extent.0,
        extent.1,
    );
    unsafe {
        if let Some((bindings, attributes)) = vertex_input {
            device.cmd_set_vertex_input_ext(cmd_buffer, bindings, attributes);
        }
        if patch_control_points > 0 {
            device.cmd_set_patch_control_points_ext(cmd_buffer, patch_control_points);
        }
    }
}

/// Binds the given shader objects and a null shader for every other stage the device supports (one `vkCmdBindShadersEXT`).
pub(super) fn bind_shaders_with_nulls(
    context: &Context<'_>,
    cmd_buffer: vk::CommandBuffer,
    given: &[(vk::ShaderStageFlags, vk::ShaderEXT)],
) {
    bind_shaders_with_nulls_on(context.get_device(), context, cmd_buffer, given);
}

/// `bind_shaders_with_nulls` on a device other than the Context's, such as a `RobustnessDevice`'s.
pub(super) fn bind_shaders_with_nulls_on(
    device: &Device,
    context: &Context<'_>,
    cmd_buffer: vk::CommandBuffer,
    given: &[(vk::ShaderStageFlags, vk::ShaderEXT)],
) {
    let features = context.get_device_features();
    let mesh_supported = context.is_device_functionality_supported("VK_EXT_mesh_shader");
    let mesh_features = if mesh_supported {
        crate::vkt::tests::shader_object::util::get_mesh_shader_features(context)
    } else {
        vk::PhysicalDeviceMeshShaderFeaturesEXT::default()
    };

    let mut candidates = vec![vk::ShaderStageFlags::VERTEX, vk::ShaderStageFlags::FRAGMENT];
    if features.tessellation_shader != vk::FALSE {
        candidates.push(vk::ShaderStageFlags::TESSELLATION_CONTROL);
        candidates.push(vk::ShaderStageFlags::TESSELLATION_EVALUATION);
    }
    if features.geometry_shader != vk::FALSE {
        candidates.push(vk::ShaderStageFlags::GEOMETRY);
    }
    if mesh_features.mesh_shader != vk::FALSE {
        candidates.push(vk::ShaderStageFlags::MESH_EXT);
    }
    if mesh_features.task_shader != vk::FALSE {
        candidates.push(vk::ShaderStageFlags::TASK_EXT);
    }

    let shaders: Vec<vk::ShaderEXT> = candidates
        .iter()
        .map(|stage| {
            given
                .iter()
                .find(|(given_stage, _)| given_stage == stage)
                .map_or(vk::ShaderEXT::null(), |(_, shader)| *shader)
        })
        .collect();
    unsafe { device.cmd_bind_shaders_ext(cmd_buffer, &candidates, &shaders) };
}

/// `vk::copyImageToBuffer` for a colour image left in COLOR_ATTACHMENT_OPTIMAL by a render pass.
pub(super) fn copy_image_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
    layer_count: u32,
) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layer_count),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `tcu::floatThresholdCompare` over R8G8B8A8_UNORM bytes against float references (row-major pixels).
pub(super) fn float_threshold_compare(result: &[u8], reference: &[Vec4], threshold: Vec4) -> bool {
    let mut ok = true;
    for (pixel, expected) in reference.iter().enumerate() {
        for channel in 0..4 {
            let got = f32::from(result[pixel * 4 + channel]) / 255.0;
            if (got - expected[channel]).abs() > threshold[channel] {
                ok = false;
                log::error!(
                    "pixel {pixel} channel {channel}: got {got} expected {} (threshold {})",
                    expected[channel],
                    threshold[channel]
                );
            }
        }
    }
    ok
}

/// Pushes the push constant token data of sequence `i`.
fn push_push_constants(
    dgc_data: &mut Vec<u32>,
    i: usize,
    params: &DrawTestParams,
    red_values: &[f32],
    draw_cmds: &[vk::DrawIndirectCommand],
    draw_indexed_cmds: &[vk::DrawIndexedIndirectCommand],
) {
    push_back_element(dgc_data, &red_values[i]);
    if params.check_draw_params {
        push_back_element(dgc_data, &0i32); // For non-count commands, DrawIndex stays at 0.
        if matches!(params.test_type, TestType::Draw | TestType::DrawSimple) {
            push_back_element(dgc_data, &draw_cmds[i].first_vertex);
            push_back_element(dgc_data, &draw_cmds[i].first_instance);
        } else {
            push_back_element(dgc_data, &draw_indexed_cmds[i].vertex_offset);
            push_back_element(dgc_data, &draw_indexed_cmds[i].first_instance);
        }
    }
}

struct DrawInstance<'a> {
    context: &'a Context<'a>,
    params: DrawTestParams,
}

impl TestInstance for DrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = (2u32, 2u32);
        let pixel_count = fb_extent.0 * fb_extent.1;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let sequence_count = 3u32;
        let stage_flags = params.stage_flags();
        let bind_point = vk::PipelineBindPoint::GRAPHICS;

        // Color buffer.
        let color_buffer = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, color_format, color_usage, 4)?;

        // Vertex data: 1 triangle per pixel.
        let mut vertices: Vec<Vec4> = Vec::with_capacity((pixel_count * PER_TRIANGLE_VERTICES) as usize);
        let pix_width = 2.0 / fb_extent.0 as f32;
        let pix_height = 2.0 / fb_extent.1 as f32;
        let hor_margin = pix_width / 4.0;
        let ver_margin = pix_height / 4.0;
        for y in 0..fb_extent.1 {
            for x in 0..fb_extent.0 {
                let x_center = ((x as f32 + 0.5) / fb_extent.0 as f32 * 2.0) - 1.0;
                let y_center = ((y as f32 + 0.5) / fb_extent.1 as f32 * 2.0) - 1.0;
                vertices.push([x_center - hor_margin, y_center + ver_margin, 0.0, 1.0]);
                vertices.push([x_center + hor_margin, y_center + ver_margin, 0.0, 1.0]);
                vertices.push([x_center, y_center - ver_margin, 0.0, 1.0]);
            }
        }

        // Create vertex and index buffers.
        let vert_seq_count = if params.test_type == TestType::Draw {
            sequence_count
        } else {
            1
        };
        let index_seq_count = if is_indexed(params.test_type) {
            sequence_count
        } else {
            0
        };
        let vertex_buffers = make_vertex_buffers(context, &vertices, vert_seq_count, pixel_count)?;
        let index_buffers = make_index_buffers(context, index_seq_count, pixel_count)?;

        // Push constants.
        let draw_params_count = if params.check_draw_params { 3u32 } else { 0 };
        let pc_size = 4 + draw_params_count * 4; // Must match the fragment shader.
        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: pc_size,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;

        let random_seed = ((params.extra_stages as u32) << 24)
            | (u32::from(params.check_draw_params) << 16)
            | (u32::from(params.use_execution_set) << 15);
        let mut rnd = Random::new(random_seed);

        // Indirect commands layout.
        let mut layout_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.do_preprocess() {
            layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }
        if params.unordered_sequences {
            layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::UNORDERED_SEQUENCES;
        }

        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(layout_flags, stage_flags, *pipeline_layout);
        if params.use_execution_set {
            let set_type = if params.pipeline_type.is_shader_objects() {
                vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
            } else {
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
            };
            cmds_layout_builder.add_execution_set_token(0, set_type, stage_flags);
        }

        let pc_first = rnd.get_bool();
        if pc_first {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_push_constant_token(offset, pc_range);
        }

        if params.test_type == TestType::Draw {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_vertex_buffer_token(offset, 0);
        } else if is_indexed(params.test_type) {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_index_buffer_token(offset, params.input_mode_flags());
        }

        if !pc_first {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_push_constant_token(offset, pc_range);
        }

        let offset = cmds_layout_builder.get_stream_range();
        if matches!(params.test_type, TestType::Draw | TestType::DrawSimple) {
            cmds_layout_builder.add_draw_token(offset);
        } else {
            cmds_layout_builder.add_draw_indexed_token(offset);
        }

        let cmds_layout = cmds_layout_builder.build(device)?;

        // Device-generated commands data.
        let mut dgc_data: Vec<u32> = Vec::new();

        // Red color values.
        let red_values: Vec<f32> = (0..sequence_count).map(|i| (128 + 5 * i) as f32 / 255.0).collect();

        // Draw commands.
        let middle_vertex_count = (pixel_count - 2) * PER_TRIANGLE_VERTICES; // For the second sequence.
        let first_vertex_at_end = vertices.len() as u32 - PER_TRIANGLE_VERTICES; // First vertex for the final sequence.

        let mut draw_cmds: Vec<vk::DrawIndirectCommand> = Vec::new();
        let mut draw_indexed_cmds: Vec<vk::DrawIndexedIndirectCommand> = Vec::new();

        match params.test_type {
            TestType::Draw => {
                // The idea is to vary every number.
                draw_cmds.push(vk::DrawIndirectCommand {
                    vertex_count: PER_TRIANGLE_VERTICES,
                    instance_count: 1,
                    first_vertex: 0,
                    first_instance: 0,
                });
                draw_cmds.push(vk::DrawIndirectCommand {
                    vertex_count: middle_vertex_count,
                    instance_count: 1,
                    first_vertex: 0,
                    first_instance: 1,
                });
                draw_cmds.push(vk::DrawIndirectCommand {
                    vertex_count: PER_TRIANGLE_VERTICES,
                    instance_count: 2,
                    first_vertex: first_vertex_at_end,
                    first_instance: 0,
                });
            }
            TestType::DrawSimple => {
                // Alternative to the one above with a single vertex buffer, so the middle draw uses a different firstVertex.
                draw_cmds.push(vk::DrawIndirectCommand {
                    vertex_count: PER_TRIANGLE_VERTICES,
                    instance_count: 1,
                    first_vertex: 0,
                    first_instance: 0,
                });
                draw_cmds.push(vk::DrawIndirectCommand {
                    vertex_count: middle_vertex_count,
                    instance_count: 1,
                    first_vertex: PER_TRIANGLE_VERTICES,
                    first_instance: 1,
                });
                draw_cmds.push(vk::DrawIndirectCommand {
                    vertex_count: PER_TRIANGLE_VERTICES,
                    instance_count: 2,
                    first_vertex: first_vertex_at_end,
                    first_instance: 0,
                });
            }
            TestType::DrawIndexed | TestType::DrawIndexedDx => {
                draw_indexed_cmds.push(vk::DrawIndexedIndirectCommand {
                    index_count: PER_TRIANGLE_VERTICES,
                    instance_count: 1,
                    first_index: 0,
                    vertex_offset: index_buffers[0].vertex_offset,
                    first_instance: 0,
                });
                draw_indexed_cmds.push(vk::DrawIndexedIndirectCommand {
                    index_count: middle_vertex_count,
                    instance_count: 1,
                    first_index: 0,
                    vertex_offset: index_buffers[1].vertex_offset,
                    first_instance: 1,
                });
                draw_indexed_cmds.push(vk::DrawIndexedIndirectCommand {
                    index_count: PER_TRIANGLE_VERTICES,
                    instance_count: 2,
                    first_index: first_vertex_at_end,
                    vertex_offset: index_buffers[2].vertex_offset,
                    first_instance: 0,
                });
            }
        }

        for i in 0..sequence_count as usize {
            if params.use_execution_set {
                if params.pipeline_type.is_shader_objects() {
                    // In the order of the stages of the pipeline; see the rationale below.
                    let (vert_base, fragment_base, tesc_base, tese_base, geom_base) = (0u32, 2u32, 4u32, 6u32, 4u32);
                    push_back_element(&mut dgc_data, &([1u32, 1, 0][i] + vert_base));
                    if params.extra_stages == ExtraStages::Tessellation {
                        push_back_element(&mut dgc_data, &([1u32, 1, 0][i] + tesc_base));
                        push_back_element(&mut dgc_data, &tese_base);
                    }
                    if params.extra_stages == ExtraStages::Geometry {
                        push_back_element(&mut dgc_data, &([1u32, 1, 0][i] + geom_base));
                    }
                    push_back_element(&mut dgc_data, &([0u32, 1, 1][i] + fragment_base));
                } else {
                    push_back_element(&mut dgc_data, &(i as u32));
                }
            }

            if pc_first {
                push_push_constants(&mut dgc_data, i, &params, &red_values, &draw_cmds, &draw_indexed_cmds);
            }

            match params.test_type {
                TestType::Draw => push_back_element(
                    &mut dgc_data,
                    &vk::BindVertexBufferIndirectCommandEXT {
                        buffer_address: vertex_buffers[i].address,
                        size: vertex_buffers[i].size,
                        stride: vertex_buffers[i].stride,
                    },
                ),
                TestType::DrawIndexed => push_back_element(
                    &mut dgc_data,
                    &vk::BindIndexBufferIndirectCommandEXT {
                        buffer_address: index_buffers[i].address,
                        size: index_buffers[i].size,
                        index_type: index_buffers[i].index_type,
                    },
                ),
                TestType::DrawIndexedDx => push_back_element(
                    &mut dgc_data,
                    &IndexBufferViewD3D12::new(
                        index_buffers[i].address,
                        index_buffers[i].size,
                        index_buffers[i].index_type,
                    ),
                ),
                TestType::DrawSimple => {}
            }

            if !pc_first {
                push_push_constants(&mut dgc_data, i, &params, &red_values, &draw_cmds, &draw_indexed_cmds);
            }

            if matches!(params.test_type, TestType::Draw | TestType::DrawSimple) {
                push_back_element(&mut dgc_data, &draw_cmds[i]);
            } else {
                push_back_element(&mut dgc_data, &draw_indexed_cmds[i]);
            }
        }

        // Buffer holding the device-generated commands.
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

        // Shader modules.
        let binaries = context.get_binary_collection();
        let vert_normal = maybe_create_module(device, &binaries, "vert_normal")?;
        let vert_flip = maybe_create_module(device, &binaries, "vert_flip")?;
        let tesc_normal = maybe_create_module(device, &binaries, "tesc_normal")?;
        let tesc_flip = maybe_create_module(device, &binaries, "tesc_flip")?;
        let tese = maybe_create_module(device, &binaries, "tese")?;
        let geom_normal = maybe_create_module(device, &binaries, "geom_normal")?;
        let geom_flip = maybe_create_module(device, &binaries, "geom_flip")?;
        let frag_normal = maybe_create_module(device, &binaries, "frag_normal")?;
        let frag_alt = maybe_create_module(device, &binaries, "frag_alt")?;

        let missing =
            |name: &str| TestError::InternalError(format!("the shader {name} is missing from the collection"));
        let normal_modules = StageModules {
            vert: module_handle(&vert_normal).ok_or_else(|| missing("vert_normal"))?,
            tesc: module_handle(&tesc_normal),
            tese: module_handle(&tese),
            geom: module_handle(&geom_normal),
            frag: module_handle(&frag_normal).ok_or_else(|| missing("frag_normal"))?,
        };

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent.0, fb_extent.1, 1)?;

        let has_tessellation = params.extra_stages == ExtraStages::Tessellation;
        let primitive_topology = if has_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let patch_control_points = if has_tessellation { 3 } else { 0 };

        let mut normal_pipeline: Option<DrawPipeline<'_>> = None;
        let mut dgc_pipelines: Vec<DrawPipeline<'_>> = Vec::new();
        let mut execution_set_manager: Option<ExecutionSetManagerExt<'_>> = None;

        // Shader objects instead of pipelines.
        let use_eso = params.pipeline_type.is_shader_objects();
        let tessellation_feature = context.get_device_features().tessellation_shader != vk::FALSE;
        let geometry_feature = context.get_device_features().geometry_shader != vk::FALSE;
        let make_shader = |stage: vk::ShaderStageFlags, name: &str| -> Result<Option<ShaderObject<'_>>, TestError> {
            if use_eso && binaries.contains(name) {
                Ok(Some(create_dgc_shader(
                    device,
                    stage,
                    &binaries.get(name)?,
                    &[],
                    &[pc_range],
                    tessellation_feature,
                    geometry_feature,
                )?))
            } else {
                Ok(None)
            }
        };
        let vert_normal_shader = make_shader(vk::ShaderStageFlags::VERTEX, "vert_normal")?;
        let vert_flip_shader = make_shader(vk::ShaderStageFlags::VERTEX, "vert_flip")?;
        let tesc_normal_shader = make_shader(vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc_normal")?;
        let tesc_flip_shader = make_shader(vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc_flip")?;
        let tese_shader = make_shader(vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese")?;
        let geom_normal_shader = make_shader(vk::ShaderStageFlags::GEOMETRY, "geom_normal")?;
        let geom_flip_shader = make_shader(vk::ShaderStageFlags::GEOMETRY, "geom_flip")?;
        let frag_normal_shader = make_shader(vk::ShaderStageFlags::FRAGMENT, "frag_normal")?;
        let frag_alt_shader = make_shader(vk::ShaderStageFlags::FRAGMENT, "frag_alt")?;
        let shader_handle = |shader: &Option<ShaderObject<'_>>| shader.as_ref().map(ShaderObject::get);
        let required_handle = |shader: &Option<ShaderObject<'_>>, name: &str| {
            shader_handle(shader).ok_or_else(|| TestError::InternalError(format!("the shader {name} is missing")))
        };

        if use_eso {
            if params.use_execution_set {
                // Execution set for shader objects. The normal shader of each stage is stored with the first index of its pair and
                // the alternative with the second one, which matches the contents of the indirect commands buffer (vert: flip flip
                // normal, tesc and geom the same, tese: only one, frag: normal alt alt).
                let no_layouts: Vec<vk::DescriptorSetLayout> = Vec::new();
                let mut stage_infos = vec![
                    (required_handle(&vert_normal_shader, "vert_normal")?, no_layouts.clone()),
                    (required_handle(&frag_normal_shader, "frag_normal")?, no_layouts.clone()),
                ];
                let mut max_shader_count = 4u32;
                if params.extra_stages == ExtraStages::Tessellation {
                    stage_infos.push((required_handle(&tesc_normal_shader, "tesc_normal")?, no_layouts.clone()));
                    stage_infos.push((required_handle(&tese_shader, "tese")?, no_layouts.clone()));
                    max_shader_count += 3;
                }
                if params.extra_stages == ExtraStages::Geometry {
                    stage_infos.push((required_handle(&geom_normal_shader, "geom_normal")?, no_layouts.clone()));
                    max_shader_count += 2;
                }

                let mut manager =
                    ExecutionSetManagerExt::new_shader(device, &stage_infos, &[pc_range], max_shader_count)?;
                manager.add_shader(0, required_handle(&vert_normal_shader, "vert_normal")?);
                manager.add_shader(1, required_handle(&vert_flip_shader, "vert_flip")?);
                manager.add_shader(2, required_handle(&frag_normal_shader, "frag_normal")?);
                manager.add_shader(3, required_handle(&frag_alt_shader, "frag_alt")?);
                if params.extra_stages == ExtraStages::Tessellation {
                    manager.add_shader(4, required_handle(&tesc_normal_shader, "tesc_normal")?);
                    manager.add_shader(5, required_handle(&tesc_flip_shader, "tesc_flip")?);
                    manager.add_shader(6, required_handle(&tese_shader, "tese")?);
                }
                if params.extra_stages == ExtraStages::Geometry {
                    manager.add_shader(4, required_handle(&geom_normal_shader, "geom_normal")?);
                    manager.add_shader(5, required_handle(&geom_flip_shader, "geom_flip")?);
                }
                manager.update();
                execution_set_manager = Some(manager);
            }
        } else if params.use_execution_set {
            let flip_modules = StageModules {
                vert: module_handle(&vert_flip).ok_or_else(|| missing("vert_flip"))?,
                tesc: module_handle(&tesc_flip),
                tese: module_handle(&tese),
                geom: module_handle(&geom_flip),
                frag: normal_modules.frag,
            };
            let alt = module_handle(&frag_alt).ok_or_else(|| missing("frag_alt"))?;
            let sequence_modules = [
                flip_modules,
                StageModules {
                    frag: alt,
                    ..flip_modules
                },
                StageModules {
                    frag: alt,
                    ..normal_modules
                },
            ];
            let construction_types = params.pipeline_type.construction_types();
            for (modules, construction) in sequence_modules.iter().zip(construction_types) {
                dgc_pipelines.push(build_draw_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    modules,
                    &PipelineOptions {
                        extent: fb_extent,
                        topology: primitive_topology,
                        patch_control_points,
                        dynamic_stride: true,
                        dynamic_patch_control_points: false,
                        no_vertex_input: false,
                        extra_attribute: false,
                        indirect_bindable: true,
                        construction,
                        depth_test: false,
                        rendering: None,
                    },
                )?);
            }

            let mut manager = ExecutionSetManagerExt::new_pipeline(device, *dgc_pipelines[0], sequence_count)?;
            for (i, pipeline) in dgc_pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager.update();
            execution_set_manager = Some(manager);
        } else if !use_eso {
            normal_pipeline = Some(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &normal_modules,
                &PipelineOptions {
                    extent: fb_extent,
                    topology: primitive_topology,
                    patch_control_points,
                    dynamic_stride: true,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable: false,
                    construction: Construction::Monolithic,
                    depth_test: false,
                    rendering: None,
                },
            )?);
        }

        let indirect_execution_set = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let normal_pipeline_handle = normal_pipeline
            .as_ref()
            .map_or(vk::Pipeline::null(), |pipeline| **pipeline);

        // The shader objects of the draw without an execution set.
        let mut prep_shaders: Vec<vk::ShaderEXT> = Vec::new();
        if use_eso && !params.use_execution_set {
            prep_shaders.extend(shader_handle(&vert_normal_shader));
            prep_shaders.extend(shader_handle(&tesc_normal_shader));
            prep_shaders.extend(shader_handle(&tese_shader));
            prep_shaders.extend(shader_handle(&geom_normal_shader));
            prep_shaders.extend(shader_handle(&frag_normal_shader));
        }

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            indirect_execution_set,
            cmds_layout.get(),
            sequence_count,
            0,
            normal_pipeline_handle,
            &prep_shaders,
            0,
        )?;

        // Record commands.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let clear_color = [0.0f32; 4];

        // Will be used for both preprocessing and execution.
        let generated_commands_info = if prep_shaders.is_empty() {
            DgcGenCmdsInfo::new(
                stage_flags,
                indirect_execution_set,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                sequence_count,
                0,
                0,
                normal_pipeline_handle,
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
                sequence_count,
                0,
                0,
                &prep_shaders,
            )
        };

        // When preprocessing, we need to use a separate command buffer to record state. The preprocessing step needs to happen outside
        // the render pass. Each entry is the command buffer to record state into and, if not null, the state command buffer of a
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
                    device.cmd_preprocess_generated_commands_ext(
                        rec_cmd_buffer,
                        generated_commands_info.get(),
                        state_cmd_buffer,
                    )
                };
                // Delete the state command buffer right away as allowed by the spec.
                separate_state_cmd_buffer = None;

                preprocess_to_execute_barrier_ext(device, rec_cmd_buffer);

                if rec_cmd_buffer == state_cmd_buffer {
                    break;
                }
            }

            if use_eso {
                // Bind shaders and the state they need.
                let mut given = vec![
                    (
                        vk::ShaderStageFlags::VERTEX,
                        required_handle(&vert_normal_shader, "vert_normal")?,
                    ),
                    (
                        vk::ShaderStageFlags::FRAGMENT,
                        required_handle(&frag_normal_shader, "frag_normal")?,
                    ),
                ];
                if params.extra_stages == ExtraStages::Tessellation {
                    given.push((
                        vk::ShaderStageFlags::TESSELLATION_CONTROL,
                        required_handle(&tesc_normal_shader, "tesc_normal")?,
                    ));
                    given.push((
                        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                        required_handle(&tese_shader, "tese")?,
                    ));
                }
                if params.extra_stages == ExtraStages::Geometry {
                    given.push((
                        vk::ShaderStageFlags::GEOMETRY,
                        required_handle(&geom_normal_shader, "geom_normal")?,
                    ));
                }
                bind_shaders_with_nulls(context, rec_cmd_buffer, &given);

                let vertex_bindings = [vk::VertexInputBindingDescription2EXT {
                    binding: 0,
                    stride: 0, // The stride comes from the DGC token or the vertex buffer binding.
                    input_rate: vk::VertexInputRate::VERTEX,
                    divisor: 1,
                    ..Default::default()
                }];
                let vertex_attributes = [vk::VertexInputAttributeDescription2EXT {
                    location: 0,
                    binding: 0,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 0,
                    ..Default::default()
                }];
                bind_shader_object_state(
                    context,
                    rec_cmd_buffer,
                    primitive_topology,
                    patch_control_points,
                    fb_extent,
                    Some((&vertex_bindings[..], &vertex_attributes[..])),
                );
            } else {
                let pipeline_to_bind = if params.use_execution_set {
                    *dgc_pipelines[0]
                } else {
                    normal_pipeline_handle
                };
                unsafe { device.cmd_bind_pipeline(rec_cmd_buffer, bind_point, pipeline_to_bind) };
            }

            if is_indexed(params.test_type) || params.test_type == TestType::DrawSimple {
                let vertex_buffer = &vertex_buffers[0];
                bind_vertex_buffers2(
                    context,
                    rec_cmd_buffer,
                    vertex_buffer.buffer.get(),
                    vk::DeviceSize::from(vertex_buffer.size),
                    vk::DeviceSize::from(vertex_buffer.stride),
                );
            }
        }
        drop(separate_state_cmd_buffer);

        if use_eso {
            // The render pass wrapper of shader objects: a transition and dynamic rendering clearing the image.
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
            crate::vkt::tests::draw::util::begin_rendering(
                device,
                cmd_buffer,
                *color_buffer.view,
                make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: clear_color },
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
                make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: clear_color },
                },
            );
        }
        unsafe {
            device.cmd_execute_generated_commands_ext(cmd_buffer, params.do_preprocess(), generated_commands_info.get())
        };
        if use_eso {
            crate::vkt::tests::draw::util::end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }

        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent.0,
            fb_extent.1,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify results.
        let result = color_buffer.read_bytes(device)?;

        // The first and second triangles will have their pixels swapped when using execution sets, because of the X coordinate flip. The
        // last two sequences should have blue 1 when using execution sets. Except for the first pixel, all others have green 1, either
        // because of the instance count or because of the first instance value.
        let (first_x, second_x) = if params.use_execution_set {
            (1usize, 0usize)
        } else {
            (0, 1)
        };
        let blue_alt = if params.use_execution_set { 1.0 } else { 0.0 };
        let red_offset_alt = if params.use_execution_set {
            VERT_FLIP_RED_OFFSET
        } else {
            VERT_NORMAL_RED_OFFSET
        };

        let width = fb_extent.0 as usize;
        let mut reference: Vec<Vec4> = vec![[0.0; 4]; pixel_count as usize];
        reference[first_x] = [red_values[0] + red_offset_alt, 0.0, 0.0, 1.0];
        reference[second_x] = [red_values[1] + red_offset_alt, 1.0, blue_alt, 1.0];
        reference[width] = [red_values[1] + red_offset_alt, 1.0, blue_alt, 1.0];
        reference[width + 1] = [red_values[2] + VERT_NORMAL_RED_OFFSET, 1.0, blue_alt, 1.0];

        // 1/255 < 0.005 < 2/255
        let threshold = [0.005, 0.0, 0.0, 0.0];
        if !float_threshold_compare(result, &reference, threshold) {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `indexedDrawWithoutIndexTokenRun` case: indexed draws without an index buffer token.
struct IndexedDrawWithoutIndexTokenCase {
    name: String,
    pc_token: bool,
}

impl TestCase for IndexedDrawWithoutIndexTokenCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkBasicDGCGraphicsSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        check_dgc_ext_support(
            context,
            stages,
            vk::ShaderStageFlags::empty(),
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )
    }

    fn programs(&self) -> BinaryCollection {
        let key = if self.pc_token {
            "draw_basic_pc"
        } else {
            "draw_basic_nopc"
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IndexedDrawWithoutIndexTokenInstance {
            context,
            pc_token: self.pc_token,
        })
    }
}

struct IndexedDrawWithoutIndexTokenInstance<'a> {
    context: &'a Context<'a>,
    pc_token: bool,
}

impl TestInstance for IndexedDrawWithoutIndexTokenInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let pc_token = self.pc_token;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = (4u32, 4u32);
        let pixel_count = fb_extent.0 * fb_extent.1;
        let pixel_count_f = pixel_count as f32;
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let clear_color: Vec4 = [0.0, 0.0, 0.0, 1.0];
        let geom_color: Vec4 = [0.0, 0.0, 1.0, 1.0];
        // When using 0 and 1 only, we expect exact results.
        let solid_threshold: Vec4 = [0.0; 4];
        // Allow a small mistake in the blue component.
        let gradient_threshold: Vec4 = [0.0, 0.0, 0.005, 0.0];
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        // Color buffer with verification buffer.
        let color_buffer = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, fb_format, fb_usage, 4)?;

        // Vertices.
        let mut vertices: Vec<Vec4> = Vec::with_capacity(pixel_count as usize);
        for y in 0..fb_extent.1 {
            for x in 0..fb_extent.0 {
                let x_center = (x as f32 + 0.5) / fb_extent.0 as f32 * 2.0 - 1.0;
                let y_center = (y as f32 + 0.5) / fb_extent.1 as f32 * 2.0 - 1.0;
                vertices.push([x_center, y_center, 0.0, 1.0]);
            }
        }

        // Vertex buffer.
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        write_host_buffer(device, &vertex_buffer, &vertices)?;

        // Indices. To make sure these are used we're going duplicate every even index and skip odd indices. And, on top of that, we're
        // going to apply an offset to each point.
        let offsets: Vec<i32> = (0..pixel_count).map(|i| 100 + i as i32).collect();
        let indices: Vec<u32> = (0..pixel_count)
            .map(|i| ((i / 2) * 2).wrapping_add(offsets[i as usize] as u32))
            .collect();

        let index_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of_val(indices.as_slice()) as vk::DeviceSize,
                vk::BufferUsageFlags::INDEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        write_host_buffer(device, &index_buffer, &indices)?;

        // Pipeline, render pass, framebuffer...
        let mut pc_ranges: Vec<vk::PushConstantRange> = Vec::new();
        if pc_token {
            pc_ranges.push(vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::VERTEX,
                offset: 16,
                size: 4,
            });
        }
        pc_ranges.push(vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 16,
        });

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &pc_ranges)?;
        let render_pass = make_render_pass(device, fb_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent.0, fb_extent.1, 1)?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // The default values works for the current setup, including the vertex input data format.
        let modules = StageModules {
            vert: *vert_module,
            tesc: None,
            tese: None,
            geom: None,
            frag: *frag_module,
        };
        let pipeline = build_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &modules,
            &PipelineOptions {
                extent: fb_extent,
                topology: vk::PrimitiveTopology::POINT_LIST,
                patch_control_points: 0,
                dynamic_stride: false,
                dynamic_patch_control_points: false,
                no_vertex_input: false,
                extra_attribute: false,
                indirect_bindable: false,
                construction: Construction::Monolithic,
                depth_test: false,
                rendering: None,
            },
        )?;

        // Indirect commands layout.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        if pc_token {
            // The color will be provided with a push constant token.
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_push_constant_token(offset, pc_ranges[pc_ranges.len() - 1]);
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_indexed_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC Buffer.
        let draw_cmds: Vec<vk::DrawIndexedIndirectCommand> = (0..pixel_count as usize)
            .map(|i| vk::DrawIndexedIndirectCommand {
                index_count: 1,
                instance_count: 1,
                first_index: i as u32,
                vertex_offset: -offsets[i],
                first_instance: 0,
            })
            .collect();

        let mut dgc_data: Vec<u32> = Vec::new();
        for (i, draw_cmd) in draw_cmds.iter().enumerate() {
            if pc_token {
                // Color pc token, making a gradient.
                let blue_comp = i as f32 / pixel_count_f;
                let color: Vec4 = [0.0, 0.0, blue_comp, 1.0];
                push_back_element(&mut dgc_data, &color);
            }
            push_back_element(&mut dgc_data, draw_cmd);
        }

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
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            pixel_count,
            0,
            *pipeline,
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT32);
            device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
        }
        if pc_token {
            // The fixed push constant will contain the point size for the vertex shader.
            let pc_range = pc_ranges[0];
            let pt_sz = 1.0f32;
            unsafe {
                device.cmd_push_constants(
                    cmd_buffer,
                    *pipeline_layout,
                    pc_range.stage_flags,
                    pc_range.offset,
                    &pt_sz.to_ne_bytes(),
                )
            };
        } else {
            // A fixed geometry color in this case, for the fragment shader.
            let pc_range = pc_ranges[pc_ranges.len() - 1];
            let mut bytes = Vec::with_capacity(16);
            for component in geom_color {
                bytes.extend_from_slice(&component.to_ne_bytes());
            }
            unsafe {
                device.cmd_push_constants(
                    cmd_buffer,
                    *pipeline_layout,
                    pc_range.stage_flags,
                    pc_range.offset,
                    &bytes,
                )
            };
        }
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
        );
        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                pixel_count,
                0,
                0,
                *pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent.0,
            fb_extent.1,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify color output.
        let result = color_buffer.read_bytes(device)?;

        let mut reference: Vec<Vec4> = Vec::with_capacity(pixel_count as usize);
        for pixel_idx in 0..pixel_count {
            let drawn_over = pixel_idx % 2 == 0; // Only even pixels are drawn into.
            let color = if pc_token {
                // The passed color will be in the pc token and will change with each draw, forming a gradient. See above.
                if drawn_over {
                    // The +1 in the pixelIdx is because even points are drawn twice and the second color prevails.
                    let blue_comp = (pixel_idx + 1) as f32 / pixel_count_f;
                    [0.0, 0.0, blue_comp, 1.0]
                } else {
                    clear_color
                }
            } else if drawn_over {
                geom_color
            } else {
                clear_color
            };
            reference.push(color);
        }

        let threshold = if pc_token { gradient_threshold } else { solid_threshold };
        if !float_threshold_compare(result, &reference, threshold) {
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCGraphicsDrawTestsExt`: the cases by their full dotted path in `dgc`. The monolithic and `gpl_*` flavours are registered; the
/// `shader_objects` names stay gated stubs.
pub fn create_dgc_graphics_draw_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let extra_stage_cases = [
        (ExtraStages::None, ""),
        (ExtraStages::Tessellation, "_with_tess"),
        (ExtraStages::Geometry, "_with_geom"),
    ];
    let pipeline_types = [
        PipelineType::Monolithic,
        PipelineType::ShaderObjects,
        PipelineType::GplFast,
        PipelineType::GplOptimized,
        PipelineType::GplMixBaseFast,
        PipelineType::GplMixBaseOpt,
    ];
    let preprocess_cases = [
        (PreprocessType::None, ""),
        (PreprocessType::SameStateCmdBuffer, "_preprocess_same_state_cmd_buffer"),
        (
            PreprocessType::OtherStateCmdBuffer,
            "_preprocess_separate_state_cmd_buffer",
        ),
    ];

    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for test_type in [
        TestType::DrawSimple,
        TestType::Draw,
        TestType::DrawIndexed,
        TestType::DrawIndexedDx,
    ] {
        for pipeline_type in pipeline_types {
            for use_execution_set in [false, true] {
                if pipeline_type.is_gpl() && !use_execution_set {
                    continue;
                }
                for (extra_stages, extra_name) in extra_stage_cases {
                    for check_draw_params in [false, true] {
                        for (preprocess_type, preprocess_suffix) in preprocess_cases {
                            for unordered in [false, true] {
                                let params = DrawTestParams {
                                    test_type,
                                    pipeline_type,
                                    extra_stages,
                                    preprocess_type,
                                    check_draw_params,
                                    use_execution_set,
                                    unordered_sequences: unordered,
                                };
                                let name = format!(
                                    "{}{extra_name}{}{}{preprocess_suffix}{}{}{}",
                                    pipeline_type.name(),
                                    if use_execution_set { "_with_execution_set" } else { "" },
                                    if check_draw_params { "_check_draw_params" } else { "" },
                                    if unordered { "_unordered" } else { "" },
                                    if test_type == TestType::DrawSimple {
                                        "_simple"
                                    } else {
                                        ""
                                    },
                                    if test_type == TestType::DrawIndexedDx {
                                        "_dx_index"
                                    } else {
                                        ""
                                    },
                                );
                                let group = if is_indexed(test_type) {
                                    "token_draw_indexed"
                                } else {
                                    "token_draw"
                                };
                                cases.push((
                                    format!("ext.graphics.draw.{group}.{name}"),
                                    Box::new(DrawCase { name, params }) as Box<dyn TestCase>,
                                ));
                            }
                        }
                    }
                }
            }
        }
    }

    for pc_token in [false, true] {
        let name = format!(
            "indexed_draw_without_index_buffer_token{}",
            if pc_token { "_with_pc_token" } else { "" }
        );
        cases.push((
            format!("ext.graphics.draw.token_draw_indexed.{name}"),
            Box::new(IndexedDrawWithoutIndexTokenCase { name, pc_token }) as Box<dyn TestCase>,
        ));
    }
    cases
}
