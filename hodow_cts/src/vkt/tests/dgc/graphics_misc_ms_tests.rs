// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_ms.toml` (`scripts/gen_dgc_ms_manifest.py`;
// the debugPrintfEXT call of the fragment shaders is left out). The pipelines (monolithic, fast linked and link time optimized libraries,
// never shader objects: those are already fully dynamic) are made by `build_ms_pipeline` here, as the draw tests' builder has no way to
// pass the multisample and fragment shading rate states of a case.
//
// Here: `*_dynamic_a2c_*` (DynamicA2CInstance) and `*_dynamic_fsr_sample_shading_*` (DynamicFSRInstance) of `dgc.ext.graphics.misc`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtExtendedDynamicState3ExtensionDeviceCommands, InstanceV1_1,
    KhrFragmentShadingRateExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_ms::ALL_SHARED_PROGRAM;
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
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout_with_push_constants, make_render_pass_with_samples,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{Construction, float_threshold_compare};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const PER_DRAW_VERTS: u32 = 4;
const DRAW_COUNT: u32 = 4;

const CONSTRUCTIONS: [(Construction, &str); 3] = [
    (Construction::Monolithic, "monolithic"),
    (Construction::FastLinked, "fast_lib"),
    (Construction::LinkTimeOptimized, "optimized_lib"),
];

/// A pipeline and the libraries it was linked from (they must outlive it).
pub(super) struct MsPipeline<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    _libraries: Vec<Unique<'a, vk::Pipeline>>,
}

impl std::ops::Deref for MsPipeline<'_> {
    type Target = vk::Pipeline;

    fn deref(&self) -> &vk::Pipeline {
        &self.pipeline
    }
}

pub(super) struct MsPipelineOptions<'b> {
    pub extent: (u32, u32),
    pub sample_count: vk::SampleCountFlags,
    pub alpha_to_coverage: bool,
    pub dynamic_states: &'b [vk::DynamicState],
    /// The static fragment shading rate state: 1x1 and the KEEP combiner operations.
    pub fragment_shading_rate: bool,
    pub indirect_bindable: bool,
    pub construction: Construction,
}

/// A pipeline with a vertex and a fragment shader, a vec4 position at binding 0, a triangle strip and the multisample state of the case,
/// built like `GraphicsPipelineWrapper::buildPipeline` does for each construction type.
pub(super) fn build_ms_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    options: &MsPipelineOptions<'_>,
) -> Result<MsPipeline<'a>, TestError> {
    let entry = c"main";
    let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(stage)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build()
    };
    let pre_rasterization_stages = [make_stage(vk::ShaderStageFlags::VERTEX, vert)];
    let fragment_stages = [make_stage(vk::ShaderStageFlags::FRAGMENT, frag)];
    let stages = [pre_rasterization_stages[0], fragment_stages[0]];

    let bindings = [vk::VertexInputBindingDescription::builder()
        .binding(0)
        .stride(std::mem::size_of::<Vec4>() as u32)
        .input_rate(vk::VertexInputRate::VERTEX)
        .build()];
    let attributes = [vk::VertexInputAttributeDescription::builder()
        .location(0)
        .binding(0)
        .format(vk::Format::R32G32B32A32_SFLOAT)
        .offset(0)
        .build()];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: options.extent.0 as f32,
        height: options.extent.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, options.extent.0, options.extent.1)];
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
        .rasterization_samples(options.sample_count)
        .sample_shading_enable(false)
        .min_sample_shading(0.0)
        .alpha_to_coverage_enable(options.alpha_to_coverage)
        .alpha_to_one_enable(false);
    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .build();
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
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
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(options.dynamic_states);

    let flags2_template = vk::PipelineCreateFlags2CreateInfo {
        flags: vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT,
        ..Default::default()
    };
    let shading_rate_template = vk::PipelineFragmentShadingRateStateCreateInfoKHR {
        fragment_size: vk::Extent2D { width: 1, height: 1 },
        combiner_ops: [
            vk::FragmentShadingRateCombinerOpKHR::KEEP,
            vk::FragmentShadingRateCombinerOpKHR::KEEP,
        ],
        ..Default::default()
    };

    if options.construction != Construction::Monolithic {
        let link_time_optimized = options.construction == Construction::LinkTimeOptimized;
        let mut library_flags = vk::PipelineCreateFlags::LIBRARY_KHR;
        if link_time_optimized {
            library_flags |= vk::PipelineCreateFlags::RETAIN_LINK_TIME_OPTIMIZATION_INFO_EXT;
        }

        let create_library =
            |library: vk::GraphicsPipelineLibraryFlagsEXT| -> Result<Unique<'a, vk::Pipeline>, TestError> {
                let mut library_info = vk::GraphicsPipelineLibraryCreateInfoEXT::builder().flags(library);
                let mut flags2 = flags2_template;
                let mut shading_rate = shading_rate_template;

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
                    if options.fragment_shading_rate {
                        info = info.push_next(&mut shading_rate);
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
                if !options.dynamic_states.is_empty() {
                    info = info.dynamic_state(&dynamic_state);
                }
                if options.indirect_bindable {
                    info = info.push_next(&mut flags2);
                }
                let info = info.push_next(&mut library_info);

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
        let mut link_info = vk::PipelineLibraryCreateInfoKHR::builder().libraries(&handles);
        let mut flags2_link = flags2_template;
        let link_flags = if link_time_optimized {
            vk::PipelineCreateFlags::LINK_TIME_OPTIMIZATION_EXT
        } else {
            vk::PipelineCreateFlags::empty()
        };
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .flags(link_flags)
            .layout(pipeline_layout)
            .base_pipeline_index(0);
        if options.indirect_bindable {
            info = info.push_next(&mut flags2_link);
        }
        let info = info.push_next(&mut link_info);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        return Ok(MsPipeline {
            pipeline: Unique::new(device, pipelines.0[0]),
            _libraries: libraries,
        });
    }

    let mut flags2 = flags2_template;
    let mut shading_rate = shading_rate_template;
    let mut info = vk::GraphicsPipelineCreateInfo::builder()
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
    if !options.dynamic_states.is_empty() {
        info = info.dynamic_state(&dynamic_state);
    }
    if options.fragment_shading_rate {
        info = info.push_next(&mut shading_rate);
    }
    if options.indirect_bindable {
        info = info.push_next(&mut flags2);
    }
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(MsPipeline {
        pipeline: Unique::new(device, pipelines.0[0]),
        _libraries: Vec::new(),
    })
}

/// `getPhysicalDeviceImageFormatProperties` check shared by both `checkSupport`s: the format with the usage and the sample count.
pub(super) fn check_image_support(
    context: &Context<'_>,
    usage: vk::ImageUsageFlags,
    sample_count: vk::SampleCountFlags,
) -> Result<(), TestError> {
    let properties = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            FORMAT,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };
    match properties {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => Err(TestError::NotSupported(
            "R8G8B8A8_UNORM does not support the required usage flags".to_string(),
        )),
        Err(error) => Err(TestError::Fail(format!(
            "vkGetPhysicalDeviceImageFormatProperties: {error:?}"
        ))),
        Ok(properties) if !properties.sample_counts.contains(sample_count) => Err(TestError::NotSupported(
            "R8G8B8A8_UNORM does not support the required sample count".to_string(),
        )),
        Ok(_) => Ok(()),
    }
}

/// `copyImageToBuffer` of a colour image left in GENERAL by a shader write in the given stage.
pub(super) fn copy_general_image_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    extent: (u32, u32),
    src_stage: vk::PipelineStageFlags,
) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: extent.0,
            height: extent.1,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// The 2D image of the cases, with the given sample count and a full view.
fn make_color_image<'a>(
    context: &'a Context<'a>,
    extent: (u32, u32),
    sample_count: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<(ImageWithMemory<'a>, Unique<'a, vk::ImageView>), TestError> {
    let device = context.get_device();
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(FORMAT)
        .extent(vk::Extent3D {
            width: extent.0,
            height: extent.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(sample_count)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(device, context.get_default_allocator(), info, MemoryRequirement::ANY)?;
    let view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    Ok((image, view))
}

fn make_nearest_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::REPEAT)
        .address_mode_v(vk::SamplerAddressMode::REPEAT)
        .address_mode_w(vk::SamplerAddressMode::REPEAT)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(0.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::NEVER)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

fn make_compute_pipeline(
    device: &Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'_, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0");
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(*stage)
        .layout(layout)
        .base_pipeline_index(0);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// The vertex buffer of a case: the positions, host visible.
pub(super) fn make_position_buffer<'a>(
    context: &'a Context<'a>,
    positions: &[Vec4],
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(positions);
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer was created with `size` bytes.
        unsafe { std::ptr::copy_nonoverlapping(positions.as_ptr().cast::<u8>(), alloc.get_host_ptr(), size) };
        flush_alloc(device, alloc)?;
    }
    Ok(buffer)
}

/// What the DGC part of both instances records: the commands layout (with an execution set token when `use_ies`), the execution set,
/// the DGC data and the preprocess buffer.
struct DgcSetup<'a> {
    _cmds_layout: crate::vkt::tests::dgc::util_ext::IndirectCommandsLayoutExt<'a>,
    cmds_layout: vk::IndirectCommandsLayoutEXT,
    _ies_manager: Option<ExecutionSetManagerExt<'a>>,
    ies_handle: vk::IndirectExecutionSetEXT,
    dgc_buffer: DgcBuffer<'a>,
    preprocess_buffer: PreprocessBufferExt<'a>,
    preprocess_pipeline: vk::Pipeline,
}

fn make_dgc_setup<'a>(
    context: &'a Context<'a>,
    pipeline_layout: vk::PipelineLayout,
    pipelines: &[MsPipeline<'a>],
    use_ies: bool,
    preprocess: bool,
    first_vertex_per_draw: bool,
) -> Result<DgcSetup<'a>, TestError> {
    let device = context.get_device();
    let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
    let layout_flags = if preprocess {
        vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
    } else {
        vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
    };
    let mut builder = IndirectCommandsLayoutBuilderExt::new(layout_flags, shader_stages, pipeline_layout);
    if use_ies {
        builder.add_execution_set_token(0, vk::IndirectExecutionSetInfoTypeEXT::PIPELINES, shader_stages);
    }
    let offset = builder.get_stream_range();
    builder.add_draw_token(offset);
    let cmds_layout = builder.build(device)?;

    let mut ies_manager = None;
    let mut ies_handle = vk::IndirectExecutionSetEXT::null();
    if use_ies {
        let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], pipelines.len() as u32)?;
        for (i, pipeline) in pipelines.iter().enumerate() {
            manager.add_pipeline(i as u32, **pipeline);
        }
        manager.update();
        ies_handle = manager.get();
        ies_manager = Some(manager);
    }

    let sequence_count = DRAW_COUNT;
    let mut dgc_data: Vec<u32> = Vec::new();
    for i in 0..sequence_count {
        if use_ies {
            dgc_data.push(i % pipelines.len() as u32);
        }
        dgc_data.push(PER_DRAW_VERTS); // vertexCount
        dgc_data.push(1); // instanceCount
        dgc_data.push(if first_vertex_per_draw { i * PER_DRAW_VERTS } else { 0 }); // firstVertex
        dgc_data.push(0); // firstInstance
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

    let preprocess_pipeline = if ies_handle != vk::IndirectExecutionSetEXT::null() {
        vk::Pipeline::null()
    } else {
        *pipelines[0]
    };
    let preprocess_buffer = PreprocessBufferExt::new(
        context,
        ies_handle,
        cmds_layout.get(),
        sequence_count,
        0,
        preprocess_pipeline,
        0,
    )?;
    Ok(DgcSetup {
        cmds_layout: cmds_layout.get(),
        _cmds_layout: cmds_layout,
        _ies_manager: ies_manager,
        ies_handle,
        dgc_buffer,
        preprocess_buffer,
        preprocess_pipeline,
    })
}

/// Records the generated commands into the command buffer being recorded and, when `preprocess`, the separate preprocess command buffer
/// that is returned (already ended).
fn record_generated_commands<'a>(
    device: &'a Device,
    cmd_pool: vk::CommandPool,
    cmd_buffer: vk::CommandBuffer,
    setup: &DgcSetup<'_>,
    preprocess: bool,
) -> Result<Option<crate::vk::ref_util::UniqueCommandBuffer<'a>>, TestError> {
    let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
    let cmds_info = DgcGenCmdsInfo::new(
        shader_stages,
        setup.ies_handle,
        setup.cmds_layout,
        setup.dgc_buffer.get_device_address(),
        setup.dgc_buffer.get_size(),
        setup.preprocess_buffer.get_device_address(),
        setup.preprocess_buffer.get_size(),
        DRAW_COUNT,
        0,
        0,
        setup.preprocess_pipeline,
    );
    let mut preprocess_cmd_buffer = None;
    if preprocess {
        let owner = allocate_command_buffer(device, cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let handle = owner.get();
        begin_command_buffer(device, handle)?;
        unsafe { device.cmd_preprocess_generated_commands_ext(handle, cmds_info.get(), cmd_buffer) };
        preprocess_to_execute_barrier_ext(device, handle);
        end_command_buffer(device, handle)?;
        preprocess_cmd_buffer = Some(owner);
    }
    unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, preprocess, cmds_info.get()) };
    Ok(preprocess_cmd_buffer)
}

fn find_programs(wanted: &str) -> BinaryCollection {
    ALL_SHARED_PROGRAM
        .iter()
        .find(|program| program.name == wanted)
        .map_or(BinaryCollection::new(&[]), |program| program.programs)
}

fn dgc_support(context: &Context<'_>, use_ies: bool) -> Result<(), TestError> {
    let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
    let bind_stages = if use_ies { stages } else { vk::ShaderStageFlags::empty() };
    check_dgc_ext_support(
        context,
        stages,
        bind_stages,
        vk::ShaderStageFlags::empty(),
        vk::IndirectCommandsInputModeFlagsEXT::empty(),
        false,
    )
}

pub(super) fn require_library_construction(context: &Context<'_>, construction: Construction) -> Result<(), TestError> {
    if construction != Construction::Monolithic {
        context.require_device_functionality("VK_EXT_graphics_pipeline_library")?;
    }
    Ok(())
}

// ---------------------------------------------------------------------------------------------------------------------
// DynamicA2C
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct A2cParams {
    construction: Construction,
    alpha_to_coverage: bool,
    use_ies: bool,
    use_preprocess: bool,
    use_sample_mask: bool,
}

impl A2cParams {
    const EXTENT: (u32, u32) = (2, 2);
    const SAMPLE_COUNT: vk::SampleCountFlags = vk::SampleCountFlags::_4;

    fn image_usage() -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::SAMPLED
    }

    fn frag_count(&self) -> usize {
        if self.use_ies { DRAW_COUNT as usize } else { 1 }
    }
}

struct DynamicA2cCase {
    name: String,
    params: A2cParams,
}

impl TestCase for DynamicA2cCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        dgc_support(context, self.params.use_ies)?;
        require_library_construction(context, self.params.construction)?;
        check_image_support(context, A2cParams::image_usage(), A2cParams::SAMPLE_COUNT)?;

        context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;
        let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds3_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if eds3_features.extended_dynamic_state3_alpha_to_coverage_enable == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState3AlphaToCoverageEnable not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        find_programs(if self.params.use_sample_mask {
            "a2c_mask"
        } else {
            "a2c_nomask"
        })
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicA2cInstance {
            context,
            params: self.params,
        })
    }
}

struct DynamicA2cInstance<'a> {
    context: &'a Context<'a>,
    params: A2cParams,
}

impl TestInstance for DynamicA2cInstance<'_> {
    /// `DynamicA2CInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = A2cParams::EXTENT;
        let sample_count = A2cParams::SAMPLE_COUNT;
        let sample_count_int = 4u32;
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let pixel_count = fb_extent.0 * fb_extent.1;
        let total_flags = (pixel_count * sample_count_int) as usize;

        // Vertices, in 4 triangle strips with a 0.25 pixels margin from the edges of the image.
        let pix_width = 2.0 / fb_extent.0 as f32;
        let pix_height = 2.0 / fb_extent.1 as f32;
        let hor_margin = pix_width * 0.25;
        let vert_margin = pix_height * 0.25;
        let top_left: Vec4 = [-1.0 + hor_margin, -1.0 + vert_margin, 0.0, 1.0];
        let top_right: Vec4 = [1.0 - hor_margin, -1.0 + vert_margin, 0.0, 1.0];
        let bottom_left: Vec4 = [-1.0 + hor_margin, 1.0 - vert_margin, 0.0, 1.0];
        let bottom_right: Vec4 = [1.0 - hor_margin, 1.0 - vert_margin, 0.0, 1.0];
        let center: Vec4 = [0.0, 0.0, 0.0, 1.0];
        let positions: [Vec4; 16] = [
            // Strip covering the top-left quadrant with some margin.
            top_left,
            [top_left[0], 0.0, 0.0, 1.0],
            [0.0, top_left[1], 0.0, 1.0],
            center,
            // Strip covering the top-right quadrant with some margin.
            [0.0, top_right[1], 0.0, 1.0],
            center,
            top_right,
            [top_right[0], 0.0, 0.0, 1.0],
            // Strip covering the bottom-left quadrant with some margin.
            [bottom_left[0], 0.0, 0.0, 1.0],
            bottom_left,
            center,
            [0.0, bottom_left[1], 0.0, 1.0],
            // Strip covering the bottom-right quadrant with some margin.
            center,
            [0.0, bottom_right[1], 0.0, 1.0],
            [bottom_right[0], 0.0, 0.0, 1.0],
            bottom_right,
        ];
        let vertex_buffer = make_position_buffer(context, &positions)?;
        let vb_offset: vk::DeviceSize = 0;

        // Color buffers for the result and reference images.
        let (color_buffer_res, color_buffer_res_view) =
            make_color_image(context, fb_extent, sample_count, A2cParams::image_usage())?;
        let (color_buffer_ref, color_buffer_ref_view) =
            make_color_image(context, fb_extent, sample_count, A2cParams::image_usage())?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;
        let render_pass = make_render_pass_with_samples(device, FORMAT, sample_count)?;
        let framebuffer_res = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer_res_view],
            fb_extent.0,
            fb_extent.1,
            1,
        )?;
        let framebuffer_ref = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer_ref_view],
            fb_extent.0,
            fb_extent.1,
            1,
        )?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let mut frag_shaders = Vec::new();
        for i in 0..params.frag_count() {
            frag_shaders.push(create_shader_module(device, binaries.get(&format!("frag{i}"))?)?);
        }

        let good_a2c = params.alpha_to_coverage;
        let bad_a2c = !good_a2c;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let res_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let ref_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let comp_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Result pipelines, using dynamic state.
        let dynamic_states = [vk::DynamicState::ALPHA_TO_COVERAGE_ENABLE_EXT];
        let mut res_pipelines = Vec::new();
        for frag in &frag_shaders {
            res_pipelines.push(build_ms_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                *vert_shader,
                **frag,
                &MsPipelineOptions {
                    extent: fb_extent,
                    sample_count,
                    alpha_to_coverage: bad_a2c,
                    dynamic_states: &dynamic_states,
                    fragment_shading_rate: false,
                    indirect_bindable: params.use_ies,
                    construction: params.construction,
                },
            )?);
        }

        let setup = make_dgc_setup(
            context,
            *pipeline_layout,
            &res_pipelines,
            params.use_ies,
            params.use_preprocess,
            false,
        )?;

        let render_area = make_rect_2d(0, 0, fb_extent.0, fb_extent.1);
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: clear_color },
        };

        let cmd_buffer = res_cmd_buffer.get();
        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer_res,
            render_area,
            clear_value,
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vb_offset]);
            device.cmd_set_alpha_to_coverage_enable_ext(cmd_buffer, good_a2c);
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *res_pipelines[0]);
        }
        let preprocess_cmd_buffer =
            record_generated_commands(device, *cmd_pool, cmd_buffer, &setup, params.use_preprocess)?;
        end_render_pass(device, cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |owner| owner.get()),
        )?;

        // Reference pipelines. These use the right A2C value without dynamic state.
        let mut ref_pipelines = Vec::new();
        for frag in &frag_shaders {
            ref_pipelines.push(build_ms_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                *vert_shader,
                **frag,
                &MsPipelineOptions {
                    extent: fb_extent,
                    sample_count,
                    alpha_to_coverage: good_a2c,
                    dynamic_states: &[],
                    fragment_shading_rate: false,
                    indirect_bindable: false,
                    construction: params.construction,
                },
            )?);
        }

        // Generate reference image.
        let cmd_buffer = ref_cmd_buffer.get();
        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer_ref,
            render_area,
            clear_value,
        );
        unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vb_offset]) };
        for i in 0..DRAW_COUNT as usize {
            let pipeline_idx = if i >= ref_pipelines.len() { 0 } else { i };
            unsafe {
                device.cmd_bind_pipeline(
                    cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *ref_pipelines[pipeline_idx],
                );
                device.cmd_draw(cmd_buffer, PER_DRAW_VERTS, 1, 0, 0);
            }
        }
        end_render_pass(device, cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Compare both images match using the compute shader.
        let flags_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                (total_flags * 4) as vk::DeviceSize,
                vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = flags_buffer.get_allocation();
            // SAFETY: the buffer was created with `total_flags` words.
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, total_flags * 4) };
            flush_alloc(device, alloc)?;
        }

        let sampler = make_nearest_sampler(device)?;
        let image_desc_type = vk::DescriptorType::COMBINED_IMAGE_SAMPLER;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(image_desc_type, 2) // Reference and result images.
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1) // Flags buffer.
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(image_desc_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(image_desc_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let comp_pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[])?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        {
            let res_image_info = [vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *color_buffer_res_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let ref_image_info = [vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *color_buffer_ref_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let flags_buffer_info = [vk::DescriptorBufferInfo {
                buffer: flags_buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            }];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(image_desc_type)
                    .image_info(&res_image_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(1)
                    .descriptor_type(image_desc_type)
                    .image_info(&ref_image_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(2)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&flags_buffer_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let comp_shader = create_shader_module(device, binaries.get("comp")?)?;
        let comp_pipeline = make_compute_pipeline(device, *comp_pipeline_layout, *comp_shader)?;

        let cmd_buffer = comp_cmd_buffer.get();
        begin_command_buffer(device, cmd_buffer)?;
        {
            let pre_usage_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    color_buffer_res.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    color_buffer_ref.get(),
                    color_srr,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_usage_barriers,
                );
            }
        }
        unsafe {
            // We dispatch as many groups as pixels in the image. See shader code for details.
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *comp_pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *comp_pipeline);
            device.cmd_dispatch(cmd_buffer, fb_extent.0, fb_extent.1, 1);
            let pre_copy_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[pre_copy_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Extract updated flags from the buffer and verify them.
        let flag_values: Vec<u32> = {
            let alloc = flags_buffer.get_allocation();
            invalidate_alloc(device, alloc)?;
            // SAFETY: the buffer holds `total_flags` words the shader wrote.
            unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast::<u32>(), total_flags) }.to_vec()
        };

        let mut failed = false;
        let row_samples = fb_extent.0 * sample_count_int;
        for s in 0..sample_count_int {
            for y in 0..fb_extent.1 {
                for x in 0..fb_extent.0 {
                    let idx = (y * row_samples + x * sample_count_int + s) as usize;
                    if flag_values[idx] != 1 {
                        failed = true;
                        log::error!("Wrong value at ({x}, {y}) sample {s}");
                    }
                }
            }
        }
        if failed {
            return Err(TestError::Fail(
                "Multisample color buffer verification failed; check log for details --".to_string(),
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// DynamicFSR
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct FsrParams {
    construction: Construction,
    multi_sample: bool,
    sample_shading_first: bool,
    use_ies: bool,
    preprocess: bool,
    dynamic_sample_count: bool,
}

impl FsrParams {
    const EXTENT: (u32, u32) = (16, 16);

    fn sample_count(&self) -> vk::SampleCountFlags {
        if self.multi_sample {
            vk::SampleCountFlags::_4
        } else {
            vk::SampleCountFlags::_1
        }
    }

    fn sample_count_int(&self) -> u32 {
        if self.multi_sample { 4 } else { 1 }
    }

    fn bad_sample_count(&self) -> vk::SampleCountFlags {
        if self.multi_sample {
            vk::SampleCountFlags::_1
        } else {
            vk::SampleCountFlags::_4
        }
    }

    fn framebuffer_usage() -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::SAMPLED
    }

    fn verification_usage() -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
    }

    fn pipeline_count(&self) -> usize {
        if self.use_ies { 2 } else { 1 }
    }
}

struct DynamicFsrCase {
    name: String,
    params: FsrParams,
}

impl TestCase for DynamicFsrCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        dgc_support(context, self.params.use_ies)?;
        require_library_construction(context, self.params.construction)?;
        context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
        check_image_support(context, FsrParams::framebuffer_usage(), self.params.sample_count())?;
        if self.params.dynamic_sample_count {
            context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        find_programs(if self.params.multi_sample { "fsr_ms" } else { "fsr_ss" })
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicFsrInstance {
            context,
            params: self.params,
        })
    }
}

struct DynamicFsrInstance<'a> {
    context: &'a Context<'a>,
    params: FsrParams,
}

impl TestInstance for DynamicFsrInstance<'_> {
    /// `DynamicFSRInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = FsrParams::EXTENT;
        let sample_count = params.sample_count();
        let sample_count_int = params.sample_count_int();
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];

        // Vertices, in 4 triangle strips covering each quadrant.
        let top_left: Vec4 = [-1.0, -1.0, 0.0, 1.0];
        let top_right: Vec4 = [1.0, -1.0, 0.0, 1.0];
        let bottom_left: Vec4 = [-1.0, 1.0, 0.0, 1.0];
        let bottom_right: Vec4 = [1.0, 1.0, 0.0, 1.0];
        let center: Vec4 = [0.0, 0.0, 0.0, 1.0];
        let center_left: Vec4 = [-1.0, 0.0, 0.0, 1.0];
        let center_right: Vec4 = [1.0, 0.0, 0.0, 1.0];
        let center_top: Vec4 = [0.0, -1.0, 0.0, 1.0];
        let center_bottom: Vec4 = [0.0, 1.0, 0.0, 1.0];
        let positions: [Vec4; 16] = [
            top_left,
            center_left,
            center_top,
            center, // Strip covering the top-left quadrant.
            center_top,
            center,
            top_right,
            center_right, // Strip covering the top-right quadrant.
            center_left,
            bottom_left,
            center,
            center_bottom, // Strip covering the bottom-left quadrant.
            center,
            center_bottom,
            center_right,
            bottom_right, // Strip covering the bottom-right quadrant.
        ];
        let vertex_buffer = make_position_buffer(context, &positions)?;
        let vb_offset: vk::DeviceSize = 0;

        // Color buffer, and the expanded one that uses multiple pixels horizontally, one for each sample.
        let (color_buffer, color_view) =
            make_color_image(context, fb_extent, sample_count, FsrParams::framebuffer_usage())?;
        let expanded_extent = (fb_extent.0 * sample_count_int, fb_extent.1);
        let verif_buffer = ImageWithBuffer::new(
            context,
            expanded_extent.0,
            expanded_extent.1,
            FORMAT,
            FsrParams::verification_usage(),
            4,
        )?;

        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_n_shader = create_shader_module(device, binaries.get("fragN")?)?;
        let frag_y_shader = create_shader_module(device, binaries.get("fragY")?)?;

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;
        let render_pass = make_render_pass_with_samples(device, FORMAT, sample_count)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], fb_extent.0, fb_extent.1, 1)?;

        let dynamic_fragment_size = vk::Extent2D { width: 2, height: 2 };
        let combiner_ops = [
            vk::FragmentShadingRateCombinerOpKHR::KEEP,
            vk::FragmentShadingRateCombinerOpKHR::KEEP,
        ];

        let static_sample_count = if params.dynamic_sample_count {
            params.bad_sample_count()
        } else {
            sample_count
        };
        let mut dynamic_states = vec![vk::DynamicState::FRAGMENT_SHADING_RATE_KHR];
        if params.dynamic_sample_count {
            dynamic_states.push(vk::DynamicState::RASTERIZATION_SAMPLES_EXT);
        }

        let mut pipelines = Vec::new();
        for i in 0..params.pipeline_count() {
            let sample_shading = i == (1 - usize::from(params.sample_shading_first));
            let frag = if sample_shading { *frag_y_shader } else { *frag_n_shader };
            pipelines.push(build_ms_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                *vert_shader,
                frag,
                &MsPipelineOptions {
                    extent: fb_extent,
                    sample_count: static_sample_count,
                    alpha_to_coverage: false,
                    dynamic_states: &dynamic_states,
                    fragment_shading_rate: true,
                    indirect_bindable: true,
                    construction: params.construction,
                },
            )?);
        }

        // Compute pipeline that expands the multisample attachment.
        let sampler = make_nearest_sampler(device)?;
        let verif_stages = vk::ShaderStageFlags::COMPUTE;
        let expanded_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, verif_stages)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, verif_stages)
            .build(device)?;
        let expanded_desc_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let expanded_desc_set = make_descriptor_set(device, *expanded_desc_pool, *expanded_set_layout)?;
        {
            let src_image_info = [vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *color_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let dst_image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *verif_buffer.view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(expanded_desc_set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                    .image_info(&src_image_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(expanded_desc_set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                    .image_info(&dst_image_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }
        let comp_pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*expanded_set_layout], &[])?;
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;
        let comp_pipeline = make_compute_pipeline(device, *comp_pipeline_layout, *comp_module)?;

        let setup = make_dgc_setup(
            context,
            *pipeline_layout,
            &pipelines,
            params.use_ies,
            params.preprocess,
            true,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vb_offset]);
            device.cmd_set_fragment_shading_rate_khr(cmd_buffer, &dynamic_fragment_size, combiner_ops);
            if params.dynamic_sample_count {
                device.cmd_set_rasterization_samples_ext(cmd_buffer, sample_count);
            }
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
        unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[0]) };
        let preprocess_cmd_buffer =
            record_generated_commands(device, *cmd_pool, cmd_buffer, &setup, params.preprocess)?;
        end_render_pass(device, cmd_buffer);
        {
            // Layout transitions and barrier for the compute pipeline.
            let src_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
            let dst_access = vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE;
            let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let pre_compute_barriers = [
                make_image_memory_barrier(
                    src_access,
                    dst_access,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    color_buffer.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    src_access,
                    dst_access,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    verif_buffer.image.get(),
                    color_srr,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_compute_barriers,
                );
            }
        }
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *comp_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *comp_pipeline_layout,
                0,
                &[expanded_desc_set.get()],
                &[],
            );
            device.cmd_dispatch(cmd_buffer, fb_extent.0, fb_extent.1, 1);
        }
        copy_general_image_to_buffer(
            device,
            cmd_buffer,
            verif_buffer.image.get(),
            verif_buffer.buffer.get(),
            expanded_extent,
            vk::PipelineStageFlags::COMPUTE_SHADER,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |owner| owner.get()),
        )?;

        let result = verif_buffer.read_bytes(device)?;

        let pipeline_count = params.pipeline_count() as u32;
        let mut reference: Vec<Vec4> = Vec::with_capacity((expanded_extent.0 * expanded_extent.1) as usize);
        for y in 0..expanded_extent.1 {
            for x in 0..expanded_extent.0 {
                let is_left = x < expanded_extent.0 / 2;
                let is_top = y < expanded_extent.1 / 2;
                let draw_idx = if is_top {
                    if is_left { 0 } else { 1 }
                } else if is_left {
                    2
                } else {
                    3
                };
                let sample_shading = draw_idx % pipeline_count == 1 - u32::from(params.sample_shading_first);
                let sample_id = x % sample_count_int;

                // These have to match the frag shader logic. Note when sample shading is enabled, the shading rate has to be 1x1
                // according to the spec.
                let red = if sample_shading { 0.5 } else { 1.0 };
                let green = if sample_shading { 0.5 } else { 1.0 };
                let blue = if sample_shading {
                    (sample_id + 1) as f32 / sample_count_int as f32
                } else {
                    0.0
                };
                reference.push([red, green, blue, 1.0]);
            }
        }

        let comp_threshold = 0.005f32; // 1/255 < 0.005 < 2/255
        if !float_threshold_compare(
            result,
            &reference,
            [comp_threshold, comp_threshold, comp_threshold, 0.0],
        ) {
            return Err(TestError::Fail(
                "Unexpected results in expanded color buffer; check log for details --".to_string(),
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `*_dynamic_a2c_*` and `*_dynamic_fsr_sample_shading_*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_ms_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (construction, suffix) in CONSTRUCTIONS {
        for use_ies in [false, true] {
            for use_preprocess in [false, true] {
                for alpha_to_coverage in [false, true] {
                    for use_sample_mask in [false, true] {
                        let name = format!(
                            "{suffix}_dynamic_a2c{}{}{}{}",
                            if alpha_to_coverage { "_enabled" } else { "_disabled" },
                            if use_ies { "_ies" } else { "" },
                            if use_preprocess { "_preprocess" } else { "" },
                            if use_sample_mask { "_sample_mask" } else { "" },
                        );
                        cases.push((
                            format!("ext.graphics.misc.{name}"),
                            Box::new(DynamicA2cCase {
                                name,
                                params: A2cParams {
                                    construction,
                                    alpha_to_coverage,
                                    use_ies,
                                    use_preprocess,
                                    use_sample_mask,
                                },
                            }),
                        ));
                    }
                }
            }
        }
    }
    for (construction, suffix) in CONSTRUCTIONS {
        for multi_sample in [false, true] {
            for sample_shading_first in [false, true] {
                for use_ies in [false, true] {
                    for preprocess in [false, true] {
                        for dynamic_sample_count in [false, true] {
                            let name = format!(
                                "{suffix}_dynamic_fsr_sample_shading{}{}{}{}{}",
                                if sample_shading_first { "_first" } else { "_second" },
                                if use_ies { "_ies" } else { "" },
                                if preprocess { "_preprocess" } else { "" },
                                if multi_sample { "_multisample" } else { "" },
                                if dynamic_sample_count {
                                    "_dynamic_sample_count"
                                } else {
                                    ""
                                },
                            );
                            cases.push((
                                format!("ext.graphics.misc.{name}"),
                                Box::new(DynamicFsrCase {
                                    name,
                                    params: FsrParams {
                                        construction,
                                        multi_sample,
                                        sample_shading_first,
                                        use_ies,
                                        preprocess,
                                        dynamic_sample_count,
                                    },
                                }),
                            ));
                        }
                    }
                }
            }
        }
    }
    cases
}
