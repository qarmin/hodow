// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMultiviewTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_multiview.toml`
// (`scripts/gen_dgc_graphics_multiview_manifest.py`). The pipelines are made by `build_draw_pipeline` of the draw tests (the GPL variants
// are fast linked libraries, dynamic rendering variants have a `VkPipelineRenderingCreateInfo` with the view mask instead of a render pass).
// Execution sets are never combined with multiview (banned by the spec), so only the `no_ies_*` groups exist.
//
// A 2x2 framebuffer with 2 layers, four sequences each drawing a triangle strip over one quadrant of each view, with depth test, optionally
// with vertex and index buffer tokens pointing at the part of the buffers of each quadrant.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, ExtDeviceGeneratedCommandsExtensionDeviceCommands};

use crate::generated::shaders::dgc_graphics_multiview::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout_with_push_constants,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, PipelineOptions, RenderingFormats, StageModules, build_draw_pipeline, copy_image_to_buffer,
    make_address_buffer, push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt, check_dgc_ext_support,
    preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const QUADRANT_COUNT: u32 = 4;
const QUADRANT_VERTICES: u32 = 4;
const QUADRANT_VERTEX_BUFFER_BYTES: u32 = QUADRANT_VERTICES * 16;
const QUADRANT_INDEX_BUFFER_BYTES: u32 = QUADRANT_VERTICES * 4;
const LAYER_COUNT: u32 = 2;
const EXTENT: u32 = 2;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;

#[derive(Clone, Copy)]
struct Params {
    /// Subpass view mask.
    view_mask: u32,
    /// Graphics pipeline libraries.
    use_gpl: bool,
    /// Indexed draws.
    use_indices: bool,
    /// Set the vertex and maybe index buffers from tokens, varying offsets.
    buffer_tokens: bool,
    preprocess: bool,
    dynamic_rendering: bool,
}

impl Params {
    fn quadrant_base_colors(&self) -> [Vec4; 4] {
        [
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
        ]
    }

    fn quadrant_depths(&self) -> [f32; 4] {
        [0.25, 0.50, 0.75, 1.00]
    }

    fn clear_color(&self) -> Vec4 {
        [0.0; 4]
    }

    fn clear_depth(&self) -> f32 {
        0.0
    }

    fn shader_stages(&self) -> vk::ShaderStageFlags {
        vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT
    }
}

struct MultiviewCase {
    name: String,
    params: Params,
}

impl TestCase for MultiviewCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let stages = params.shader_stages();
        let input_mode_flags = if params.use_indices && params.buffer_tokens {
            vk::IndirectCommandsInputModeFlagsEXT::VULKAN_INDEX_BUFFER
        } else {
            vk::IndirectCommandsInputModeFlagsEXT::empty()
        };
        check_dgc_ext_support(
            context,
            stages,
            vk::ShaderStageFlags::empty(),
            vk::ShaderStageFlags::empty(),
            input_mode_flags,
            false,
        )?;

        if params.use_gpl {
            context.require_device_functionality("VK_EXT_graphics_pipeline_library")?;
            check_pipeline_construction_requirements(context, PipelineConstructionType::FastLinkedLibrary)?;
        }
        if params.buffer_tokens {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }
        if params.dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        context.require_device_functionality("VK_KHR_multiview")
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "multiview")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiviewInstance {
            context,
            params: self.params,
        })
    }
}

/// A 2x2 image with two layers, its 2D array view and a host-visible buffer holding both layers.
struct LayeredTarget<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
    buffer: BufferWithMemory<'a>,
    texel_size: usize,
}

impl<'a> LayeredTarget<'a> {
    fn new(
        context: &'a Context<'a>,
        format: vk::Format,
        usage: vk::ImageUsageFlags,
        aspect: vk::ImageAspectFlags,
        texel_size: usize,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: EXTENT,
                height: EXTENT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(LAYER_COUNT)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, context.get_default_allocator(), info, MemoryRequirement::ANY)?;
        let view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D_ARRAY,
            format,
            make_image_subresource_range(aspect, 0, 1, 0, LAYER_COUNT),
        )?;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                (EXTENT as usize * EXTENT as usize * LAYER_COUNT as usize * texel_size) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        Ok(Self {
            image,
            view,
            buffer,
            texel_size,
        })
    }

    fn read_bytes(&self, device: &Device) -> Result<&[u8], TestError> {
        let alloc = self.buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let size = EXTENT as usize * EXTENT as usize * LAYER_COUNT as usize * self.texel_size;
        // SAFETY: the buffer holds both layers that the device wrote.
        Ok(unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), size) })
    }
}

/// `makeRenderPass` of the test: colour and depth attachments that are loaded and stored, one subpass with a view mask.
fn make_multiview_render_pass(device: &Device, view_mask: u32) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(DEPTH_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let color_refs = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let depth_ref = vk::AttachmentReference::builder()
        .attachment(1)
        .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .depth_stencil_attachment(&depth_ref)
        .build()];
    let view_masks = [view_mask];
    let multiview_info = vk::RenderPassMultiviewCreateInfo {
        subpass_count: 1,
        view_masks: view_masks.as_ptr(),
        ..Default::default()
    };
    let mut info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses)
        .build();
    info.next = (&multiview_info as *const vk::RenderPassMultiviewCreateInfo).cast();
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `vk::copyImageToBuffer` for the depth aspect of an image left in DEPTH_STENCIL_ATTACHMENT_OPTIMAL.
fn copy_depth_image_to_buffer(device: &Device, cmd: vk::CommandBuffer, image: vk::Image, buffer: vk::Buffer) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, LAYER_COUNT),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: EXTENT,
            height: EXTENT,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, LAYER_COUNT),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
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

struct MultiviewInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for MultiviewInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let pc_value: Vec4 = [EXTENT as f32, EXTENT as f32, LAYER_COUNT as f32, 0.0];

        // Vertices.
        let std_vertices: [Vec4; 4] = [
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let quadrant_depths = params.quadrant_depths();
        // To apply to the 0-1 standard coordinates.
        let quadrant_offsets: [Vec4; 4] = [
            [-1.0, -1.0, 0.0, 0.0],
            [-1.0, 0.0, 0.0, 0.0],
            [0.0, -1.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
        ];

        let mut vertices: Vec<Vec4> = Vec::with_capacity((QUADRANT_VERTICES * QUADRANT_COUNT) as usize);
        for i in 0..QUADRANT_COUNT as usize {
            for std_vertex in &std_vertices {
                let mut vert = *std_vertex;
                for (component, offset) in vert.iter_mut().zip(quadrant_offsets[i]) {
                    *component += offset;
                }
                vert[2] = quadrant_depths[i];
                vertices.push(vert);
            }
        }

        let (vertex_buffer, vertex_buffer_address) =
            make_address_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Indices.
        let index_buffer_and_address = if params.use_indices {
            let indices: Vec<u32> = (0..vertices.len() as u32).collect();
            Some(make_address_buffer(
                context,
                &indices,
                vk::BufferUsageFlags::INDEX_BUFFER,
            )?)
        } else {
            None
        };

        // Color and depth buffers.
        let common_img_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let color_buffer = LayeredTarget::new(
            context,
            COLOR_FORMAT,
            common_img_usage | vk::ImageUsageFlags::COLOR_ATTACHMENT,
            vk::ImageAspectFlags::COLOR,
            4,
        )?;
        let depth_buffer = LayeredTarget::new(
            context,
            DEPTH_FORMAT,
            common_img_usage | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            vk::ImageAspectFlags::DEPTH,
            2,
        )?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, LAYER_COUNT);
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, LAYER_COUNT);

        let construction = if params.use_gpl {
            Construction::FastLinked
        } else {
            Construction::Monolithic
        };

        // Render pass and framebuffer (unused with dynamic rendering).
        let render_pass = make_multiview_render_pass(device, params.view_mask)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer.view, *depth_buffer.view],
            EXTENT,
            EXTENT,
            1,
        )?;

        // Shaders and pipeline.
        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag0")?)?;

        let shader_stages = params.shader_stages();
        let pc_range = vk::PushConstantRange {
            stage_flags: shader_stages,
            offset: 0,
            size: 16,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;

        let pipeline = build_draw_pipeline(
            device,
            *pipeline_layout,
            if params.dynamic_rendering {
                vk::RenderPass::null()
            } else {
                *render_pass
            },
            &StageModules {
                vert: *vert_shader,
                tesc: None,
                tese: None,
                geom: None,
                frag: *frag_shader,
            },
            &PipelineOptions {
                extent: (EXTENT, EXTENT),
                topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                patch_control_points: 0,
                dynamic_stride: params.buffer_tokens,
                dynamic_patch_control_points: false,
                no_vertex_input: false,
                extra_attribute: false,
                indirect_bindable: false,
                construction,
                depth_test: true,
                rendering: params.dynamic_rendering.then_some(RenderingFormats {
                    view_mask: params.view_mask,
                    color_format: COLOR_FORMAT,
                    depth_format: DEPTH_FORMAT,
                }),
            },
        )?;

        // Indirect commands layout.
        let layout_flags = if params.preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(layout_flags, shader_stages, *pipeline_layout);
        if params.buffer_tokens {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_vertex_buffer_token(offset, 0);
            if params.use_indices {
                let offset = cmds_layout_builder.get_stream_range();
                cmds_layout_builder
                    .add_index_buffer_token(offset, vk::IndirectCommandsInputModeFlagsEXT::VULKAN_INDEX_BUFFER);
            }
        }
        let offset = cmds_layout_builder.get_stream_range();
        if params.use_indices {
            cmds_layout_builder.add_draw_indexed_token(offset);
        } else {
            cmds_layout_builder.add_draw_token(offset);
        }
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC buffer with the command data.
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..QUADRANT_COUNT {
            // Bind vertex/index buffers: bind only the subsection of the buffer that corresponds to the current quadrant.
            if params.buffer_tokens {
                let vb_cmd = vk::BindVertexBufferIndirectCommandEXT {
                    buffer_address: vertex_buffer_address + u64::from(QUADRANT_VERTEX_BUFFER_BYTES * i),
                    size: QUADRANT_VERTEX_BUFFER_BYTES,
                    stride: 16,
                };
                push_back_element(&mut dgc_data, &vb_cmd);

                if let Some((_, index_buffer_address)) = &index_buffer_and_address {
                    let ib_cmd = vk::BindIndexBufferIndirectCommandEXT {
                        buffer_address: *index_buffer_address + u64::from(QUADRANT_INDEX_BUFFER_BYTES * i),
                        size: QUADRANT_INDEX_BUFFER_BYTES,
                        index_type: vk::IndexType::UINT32,
                    };
                    push_back_element(&mut dgc_data, &ib_cmd);
                }
            }

            // Draw command. When using buffer tokens, the buffers are bound at the start of the data of each quadrant, so the first
            // index is 0 and the vertex offset undoes the index values; otherwise the full buffers are bound once.
            let abs_offset = (i * QUADRANT_VERTICES) as i32;
            if params.use_indices {
                let draw_cmd = vk::DrawIndexedIndirectCommand {
                    index_count: QUADRANT_VERTICES,
                    instance_count: 1,
                    first_index: if params.buffer_tokens { 0 } else { abs_offset as u32 },
                    vertex_offset: if params.buffer_tokens { -abs_offset } else { 0 },
                    first_instance: 0,
                };
                push_back_element(&mut dgc_data, &draw_cmd);
            } else {
                let draw_cmd = vk::DrawIndirectCommand {
                    vertex_count: QUADRANT_VERTICES,
                    instance_count: 1,
                    first_vertex: if params.buffer_tokens { 0 } else { abs_offset as u32 },
                    first_instance: 0,
                };
                push_back_element(&mut dgc_data, &draw_cmd);
            }
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
            QUADRANT_COUNT,
            0,
            *pipeline,
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        {
            // Clear both images. This is done outside the render pass to make sure the full image is cleared.
            let pre_clear_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    color_buffer.image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    depth_buffer.image.get(),
                    depth_srr,
                ),
            ];
            let color_clear_value = vk::ClearColorValue {
                float32: params.clear_color(),
            };
            let depth_clear_value = vk::ClearDepthStencilValue {
                depth: params.clear_depth(),
                stencil: 0,
            };
            let post_clear_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_buffer.image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_buffer.image.get(),
                    depth_srr,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_clear_barriers,
                );
                device.cmd_clear_color_image(
                    cmd_buffer,
                    color_buffer.image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &color_clear_value,
                    &[color_srr],
                );
                device.cmd_clear_depth_stencil_image(
                    cmd_buffer,
                    depth_buffer.image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &depth_clear_value,
                    &[depth_srr],
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &post_clear_barriers,
                );
            }
        }

        let render_area = make_rect_2d(0, 0, EXTENT, EXTENT);
        if params.dynamic_rendering {
            let color_attachments = [vk::RenderingAttachmentInfo::builder()
                .image_view(*color_buffer.view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .build()];
            let depth_attachment = vk::RenderingAttachmentInfo::builder()
                .image_view(*depth_buffer.view)
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .build();
            let rendering_info = vk::RenderingInfo::builder()
                .render_area(render_area)
                .layer_count(1)
                .view_mask(params.view_mask)
                .color_attachments(&color_attachments)
                .depth_attachment(&depth_attachment);
            unsafe { device.cmd_begin_rendering(cmd_buffer, &rendering_info) };
        } else {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                render_area,
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: [0.0; 4] },
                },
            );
        }

        if !params.buffer_tokens {
            unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]) };
            if let Some((index_buffer, _)) = &index_buffer_and_address {
                unsafe { device.cmd_bind_index_buffer(cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT32) };
            }
        }

        // We always need to bind an initial pipeline state.
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            let pc_bytes: Vec<u8> = pc_value.iter().flat_map(|value| value.to_ne_bytes()).collect();
            device.cmd_push_constants(cmd_buffer, *pipeline_layout, shader_stages, 0, &pc_bytes);
        }

        let gen_cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            QUADRANT_COUNT,
            0,
            0,
            *pipeline,
        );
        let preprocess_cmd_buffer = if params.preprocess {
            let preprocess = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, preprocess.get())?;
            unsafe { device.cmd_preprocess_generated_commands_ext(preprocess.get(), gen_cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, preprocess.get());
            end_command_buffer(device, preprocess.get())?;
            Some(preprocess)
        } else {
            None
        };
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, gen_cmds_info.get()) };
        if params.dynamic_rendering {
            unsafe { device.cmd_end_rendering(cmd_buffer) };
        } else {
            end_render_pass(device, cmd_buffer);
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            EXTENT,
            EXTENT,
            LAYER_COUNT,
        );
        copy_depth_image_to_buffer(device, cmd_buffer, depth_buffer.image.get(), depth_buffer.buffer.get());
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |preprocess| preprocess.get()),
        )?;

        // Result images.
        let color_result = color_buffer.read_bytes(device)?;
        let depth_result = depth_buffer.read_bytes(device)?;

        // Reference images and comparison, layer by layer (easier to see in the logs).
        let base_colors = params.quadrant_base_colors();
        let mut reverse_colors = base_colors;
        reverse_colors.reverse();
        let _ = reverse_colors; // Only used with execution sets, which multiview does not combine with.

        let layer_pixels = (EXTENT * EXTENT) as usize;
        let depth_threshold = 0.00002f32; // A bit over 1 unit for VK_FORMAT_D16_UNORM.
        let mut fail = false;

        for layer in 0..LAYER_COUNT as usize {
            let mut color_reference = vec![params.clear_color(); layer_pixels];
            let mut depth_reference = vec![params.clear_depth(); layer_pixels];

            if params.view_mask & (1 << layer) != 0 {
                for j in 0..QUADRANT_COUNT as usize {
                    // Find the quadrant coordinates using the quadrant index. Each quadrant is one pixel.
                    let x = (j >> 1) & 1;
                    let y = j & 1;
                    let mut quadrant_color = base_colors[j];
                    quadrant_color[0] = layer as f32; // Red reflects the layer (view).
                    color_reference[y * EXTENT as usize + x] = quadrant_color;
                    depth_reference[y * EXTENT as usize + x] = quadrant_depths[j];
                }
            }

            for pixel in 0..layer_pixels {
                let color_offset = (layer * layer_pixels + pixel) * 4;
                for channel in 0..4 {
                    let got = f32::from(color_result[color_offset + channel]) / 255.0;
                    if got != color_reference[pixel][channel] {
                        log::error!(
                            "ColorLayer{layer} pixel {pixel} channel {channel}: got {got} expected {}",
                            color_reference[pixel][channel]
                        );
                        fail = true;
                    }
                }

                let depth_offset = (layer * layer_pixels + pixel) * 2;
                let raw = u16::from_ne_bytes([depth_result[depth_offset], depth_result[depth_offset + 1]]);
                let depth = f32::from(raw) / 65535.0;
                if (depth - depth_reference[pixel]).abs() > depth_threshold {
                    log::error!(
                        "DepthLayer{layer} pixel {pixel}: got {depth} expected {}",
                        depth_reference[pixel]
                    );
                    fail = true;
                }
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected results in color or depth buffers; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCGraphicsMultiviewTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_graphics_multiview_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for view_mask in [3u32, 1, 2] {
        for use_gpl in [false, true] {
            let group_name = format!("no_ies{}", if use_gpl { "_gpl" } else { "_monolithic" });
            for use_indices in [false, true] {
                for buffer_tokens in [false, true] {
                    for dynamic_rendering in [false, true] {
                        for preprocess in [false, true] {
                            let name = format!(
                                "{}{}{}{}",
                                if use_indices { "indexed_draw" } else { "regular_draw" },
                                if buffer_tokens { "_buffer_tokens" } else { "" },
                                if preprocess { "_preprocess" } else { "" },
                                if dynamic_rendering { "_dynamic_rendering" } else { "" },
                            );
                            cases.push((
                                format!("ext.graphics.multiview.view_mask_{view_mask}.{group_name}.{name}"),
                                Box::new(MultiviewCase {
                                    name,
                                    params: Params {
                                        view_mask,
                                        use_gpl,
                                        use_indices,
                                        buffer_tokens,
                                        preprocess,
                                        dynamic_rendering,
                                    },
                                }) as Box<dyn TestCase>,
                            ));
                        }
                    }
                }
            }
        }
    }
    cases
}
