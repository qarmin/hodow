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
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_misc.toml`
// (`scripts/gen_dgc_graphics_misc_manifest.py`). The pipelines are made by `build_draw_pipeline` of the draw tests (its depth test is
// GREATER_OR_EQUAL where upstream uses GREATER; every pixel is written once, so the result is the same).
//
// Here: `early_fragment_tests[_preprocess]` and `indexed_draws_with_draw_index_base_instance[_count]` of `dgc.ext.graphics.misc`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDescriptorHeapExtensionDeviceCommands, ExtDeviceGeneratedCommandsExtensionDeviceCommands};

use crate::generated::shaders::dgc_graphics_misc::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
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
    make_memory_barrier, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, ExtraState, PipelineOptions, StageModules, build_draw_pipeline, build_draw_pipeline_with_input,
    copy_image_to_buffer, create_empty_resource_heap, float_threshold_compare, make_address_buffer,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, device_generated_commands_properties, preprocess_to_execute_barrier_ext,
    submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

#[derive(Clone, Copy)]
enum Variant {
    /// preprocess
    EarlyFragmentTests(bool),
    /// count token
    DrawIndexBaseInstance(bool),
    /// descriptor heap
    SequenceIndexToken(bool),
}

struct MiscCase {
    name: String,
    variant: Variant,
}

impl TestCase for MiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `EarlyFragmentTestsSupport` / `drawIndexBaseInstanceCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        match self.variant {
            Variant::EarlyFragmentTests(_) => check_dgc_ext_support(
                context,
                stages,
                stages,
                vk::ShaderStageFlags::empty(),
                vk::IndirectCommandsInputModeFlagsEXT::empty(),
                false,
            ),
            Variant::SequenceIndexToken(descriptor_heap) => {
                check_dgc_ext_support(
                    context,
                    stages,
                    vk::ShaderStageFlags::empty(),
                    vk::ShaderStageFlags::empty(),
                    vk::IndirectCommandsInputModeFlagsEXT::empty(),
                    false,
                )?;
                if descriptor_heap {
                    context.require_device_functionality("VK_EXT_descriptor_heap")?;
                }
                Ok(())
            }
            Variant::DrawIndexBaseInstance(count_token) => {
                check_dgc_ext_support(
                    context,
                    stages,
                    vk::ShaderStageFlags::empty(),
                    vk::ShaderStageFlags::empty(),
                    vk::IndirectCommandsInputModeFlagsEXT::empty(),
                    false,
                )?;
                if count_token
                    && device_generated_commands_properties(context).device_generated_commands_multi_draw_indirect_count
                        == vk::FALSE
                {
                    return Err(TestError::NotSupported(
                        "deviceGeneratedCommandsMultiDrawIndirectCount not supported".to_string(),
                    ));
                }
                Ok(())
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = match self.variant {
            Variant::EarlyFragmentTests(_) => "early_fragment_tests",
            Variant::DrawIndexBaseInstance(_) => "draw_index_base_instance",
            Variant::SequenceIndexToken(_) => "sequence_index_token",
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscInstance {
            context,
            variant: self.variant,
        })
    }
}

struct MiscInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

impl TestInstance for MiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::EarlyFragmentTests(preprocess) => self.early_fragment_tests_run(preprocess),
            Variant::DrawIndexBaseInstance(count_token) => self.draw_index_base_instance_run(count_token),
            Variant::SequenceIndexToken(descriptor_heap) => self.sequence_index_run(descriptor_heap),
        }
    }
}

pub(super) fn write_buffer_bytes(
    device: &Device,
    alloc: &crate::vk::mem_util::Allocation<'_>,
    bytes: &[u8],
) -> Result<(), TestError> {
    // SAFETY: the buffer was created with at least `bytes.len()` bytes.
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), alloc.get_host_ptr(), bytes.len()) };
    flush_alloc(device, alloc)
}

/// A depth image with a host-visible buffer to read it back.
pub(super) struct DepthTarget<'a> {
    pub image: ImageWithMemory<'a>,
    pub view: Unique<'a, vk::ImageView>,
    buffer: BufferWithMemory<'a>,
    width: u32,
    height: u32,
}

impl<'a> DepthTarget<'a> {
    pub(super) fn new(
        context: &'a Context<'a>,
        width: u32,
        height: u32,
        format: vk::Format,
        usage: vk::ImageUsageFlags,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width,
                height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
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
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                (width * height * 2) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        Ok(Self {
            image,
            view,
            buffer,
            width,
            height,
        })
    }

    fn read_bytes(&self, device: &Device) -> Result<&[u8], TestError> {
        let alloc = self.buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let size = (self.width * self.height * 2) as usize;
        // SAFETY: the buffer holds the whole D16 image the device wrote.
        Ok(unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), size) })
    }

    /// `vk::copyImageToBuffer` for the depth aspect of an image left in DEPTH_STENCIL_ATTACHMENT_OPTIMAL.
    fn record_copy(&self, device: &Device, cmd: vk::CommandBuffer) {
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            self.image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        );
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: self.width,
                height: self.height,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
        );
        let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                self.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.buffer.get(),
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
}

/// `makeRenderPass(vkd, device, colorFormat, depthFormat)`: both attachments cleared and stored.
pub(super) fn make_color_depth_render_pass<'a>(
    device: &'a Device,
    color_format: vk::Format,
    depth_format: vk::Format,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(depth_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
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
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

impl MiscInstance<'_> {
    /// `EarlyFragmentTestsRun`
    fn early_fragment_tests_run(&self, preprocess: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let depth_format = vk::Format::D16_UNORM;
        let extent = 32u32; // Small but varied selection of depths.
        let seed = 1722500430u32;

        // This range is different from what the fragment shaders store as gl_FragDepth, so we can tell apart the fragment-shader depth
        // and the real geometry depth.
        let min_depth = 0.5f32;
        let max_depth = 1.0f32;
        let pixel_count = extent * extent;

        // One point per pixel.
        let mut vertices: Vec<Vec4> = Vec::with_capacity(pixel_count as usize);
        let mut rnd = Random::new(seed);
        for y in 0..extent {
            for x in 0..extent {
                let x_center = (x as f32 + 0.5) / extent as f32 * 2.0 - 1.0;
                let y_center = (y as f32 + 0.5) / extent as f32 * 2.0 - 1.0;
                let depth = rnd.get_float_range(min_depth, max_depth);
                vertices.push([x_center, y_center, depth, 1.0]);
            }
        }

        let (vertex_buffer, _) = make_address_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Color and depth buffers.
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let depth_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_buffer = ImageWithBuffer::new(context, extent, extent, color_format, color_usage, 4)?;
        let depth_buffer = DepthTarget::new(context, extent, extent, depth_format, depth_usage)?;

        // Render pass and framebuffer.
        let render_pass = make_color_depth_render_pass(device, color_format, depth_format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer.view, *depth_buffer.view],
            extent,
            extent,
            1,
        )?;

        // Pipelines.
        const FRAG_SHADER_COUNT: u32 = 2; // Must match the programs.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let mut frag_modules = Vec::new();
        for i in 0..FRAG_SHADER_COUNT {
            frag_modules.push(create_shader_module(device, binaries.get(&format!("frag{i}"))?)?);
        }

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;

        let mut pipelines = Vec::new();
        for frag_module in &frag_modules {
            pipelines.push(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_module,
                    tesc: None,
                    tese: None,
                    geom: None,
                    frag: **frag_module,
                },
                &PipelineOptions {
                    extent: (extent, extent),
                    topology: vk::PrimitiveTopology::POINT_LIST,
                    patch_control_points: 0,
                    dynamic_stride: false,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable: true,
                    construction: Construction::Monolithic,
                    depth_test: true,
                    rendering: None,
                },
            )?);
        }

        // IES.
        let last_pipeline = **pipelines.last().expect("two pipelines");
        let mut ies_manager = ExecutionSetManagerExt::new_pipeline(device, last_pipeline, FRAG_SHADER_COUNT)?;
        for (i, pipeline) in pipelines.iter().enumerate() {
            ies_manager.add_pipeline(i as u32, **pipeline);
        }
        ies_manager.update();

        // DGC Layout.
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let layout_flags = if preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(layout_flags, shader_stages, vk::PipelineLayout::null());
        cmds_layout_builder.add_execution_set_token(0, vk::IndirectExecutionSetInfoTypeEXT::PIPELINES, shader_stages);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC sequences.
        let points_per_draw = pixel_count / FRAG_SHADER_COUNT;
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..FRAG_SHADER_COUNT {
            dgc_data.push(i); // Pipeline index.
            dgc_data.push(points_per_draw); // Vertex count.
            dgc_data.push(1); // Instance count.
            dgc_data.push(points_per_draw * i); // First vertex.
            dgc_data.push(0); // First instance.
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: a u32 slice viewed as bytes.
        let dgc_bytes = unsafe { std::slice::from_raw_parts(dgc_data.as_ptr().cast::<u8>(), dgc_buffer_size as usize) };
        write_buffer_bytes(device, dgc_buffer.get_allocation(), dgc_bytes)?;

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies_manager.get(),
            cmds_layout.get(),
            FRAG_SHADER_COUNT,
            0,
            vk::Pipeline::null(),
            0,
        )?;

        // Generated commands info.
        let cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            ies_manager.get(),
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            FRAG_SHADER_COUNT,
            0,
            0,
            vk::Pipeline::null(),
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let preprocess_cmd_buffer = if preprocess {
            let owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, owner.get())?;
            Some(owner)
        } else {
            None
        };

        let clear_color: Vec4 = [0.0, 0.0, 0.0, 1.0];
        let clear_depth = 0.0f32;
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: clear_depth,
                    stencil: 0,
                },
            },
        ];

        begin_command_buffer(device, cmd_buffer)?;
        unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]) };
        {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(make_rect_2d(0, 0, extent, extent))
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }
        unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, last_pipeline) };
        if let Some(preprocess_cmd_buffer) = &preprocess_cmd_buffer {
            unsafe {
                device.cmd_preprocess_generated_commands_ext(preprocess_cmd_buffer.get(), cmds_info.get(), cmd_buffer)
            };
            preprocess_to_execute_barrier_ext(device, preprocess_cmd_buffer.get());
        }
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, preprocess, cmds_info.get()) };
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            extent,
            extent,
            1,
        );
        depth_buffer.record_copy(device, cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        if let Some(preprocess_cmd_buffer) = &preprocess_cmd_buffer {
            end_command_buffer(device, preprocess_cmd_buffer.get())?;
        }
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |owner| owner.get()),
        )?;

        let geom_colors: [Vec4; 2] = [[0.0, 0.0, 1.0, 1.0], [1.0, 0.0, 1.0, 1.0]];

        // We must iterate in the same order we generated the points.
        let color_result = color_buffer.read_bytes(device)?;
        let depth_result = depth_buffer.read_bytes(device)?;
        let color_reference: Vec<Vec4> = (0..pixel_count)
            .map(|point_idx| geom_colors[(point_idx / points_per_draw) as usize])
            .collect();
        if !float_threshold_compare(color_result, &color_reference, [0.0; 4]) {
            return Ok(TestStatus::fail("Error in color buffer; check log for details"));
        }

        let depth_threshold = 0.000025f32; // 1/65535 < 0.000025 < 2/65535
        let mut depth_ok = true;
        for (pixel, vertex) in vertices.iter().enumerate() {
            let raw = u16::from_ne_bytes([depth_result[pixel * 2], depth_result[pixel * 2 + 1]]);
            let depth = f32::from(raw) / 65535.0;
            if (depth - vertex[2]).abs() > depth_threshold {
                log::error!("DepthResult pixel {pixel}: got {depth} expected {}", vertex[2]);
                depth_ok = false;
            }
        }
        if !depth_ok {
            return Ok(TestStatus::fail("Error in depth buffer; check log for details"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `SequenceIndexRun`
    fn sequence_index_run(&self, descriptor_heap: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_width = 256u32;
        let pixel_count = fb_width;
        let color_format = vk::Format::R8G8B8A8_UINT;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let sequence_count = pixel_count; // One draw per pixel.

        let color_buffer = ImageWithBuffer::new(context, fb_width, 1, color_format, color_usage, 4)?;

        // One point per pixel, left to right.
        let vertices: Vec<Vec4> = (0..fb_width)
            .map(|x| [(x as f32 + 0.5) / fb_width as f32 * 2.0 - 1.0, 0.0, 0.0, 1.0])
            .collect();
        let (vertex_buffer, _) = make_address_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let render_pass = crate::vk::obj_util::make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_width, 1, 1)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let pc_range = vk::PushConstantRange {
            stage_flags: if descriptor_heap {
                vk::ShaderStageFlags::ALL
            } else {
                vk::ShaderStageFlags::FRAGMENT
            },
            offset: 0,
            size: std::mem::size_of::<u32>() as u32,
        };
        let pipeline_layout = if descriptor_heap {
            None
        } else {
            Some(make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?)
        };
        let pipeline_layout_handle = pipeline_layout
            .as_ref()
            .map_or(vk::PipelineLayout::null(), |layout| **layout);

        // The empty resource heap of the descriptor heap variant.
        let resource_heap = if descriptor_heap {
            create_empty_resource_heap(context)?
        } else {
            None
        };

        let pipeline = build_draw_pipeline_with_input(
            device,
            pipeline_layout_handle,
            *render_pass,
            &StageModules {
                vert: *vert_module,
                tesc: None,
                tese: None,
                geom: None,
                frag: *frag_module,
            },
            &PipelineOptions {
                extent: (fb_width, 1),
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
            None,
            ExtraState {
                descriptor_heap,
                ..Default::default()
            },
        )?;

        // DGC commands layout, sequences and preprocess buffer.
        let shader_stages = vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::VERTEX;
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stages,
            pipeline_layout_handle,
        );
        if descriptor_heap {
            cmds_layout_builder.add_push_data_sequence_index_token(0, pc_range);
        } else {
            cmds_layout_builder.add_sequence_index_token(0, pc_range);
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..sequence_count {
            dgc_data.push(!0u32); // Sequence index placeholder.
            dgc_data.push(1); // vertexCount
            dgc_data.push(1); // instanceCount
            dgc_data.push(i); // firstVertex
            dgc_data.push(0); // firstInstance
        }
        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: a u32 slice viewed as bytes.
        let dgc_bytes = unsafe { std::slice::from_raw_parts(dgc_data.as_ptr().cast::<u8>(), dgc_buffer_size as usize) };
        write_buffer_bytes(device, dgc_buffer.get_allocation(), dgc_bytes)?;

        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            sequence_count,
            0,
            *pipeline,
            0,
        )?;
        let cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            sequence_count,
            0,
            0,
            *pipeline,
        );

        // Commands.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        if let Some((_, bind_heap_info)) = &resource_heap {
            unsafe { device.cmd_bind_resource_heap_ext(cmd_buffer, bind_heap_info) };
        }
        unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]) };
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_width, 1),
            vk::ClearValue {
                color: vk::ClearColorValue { uint32: [0; 4] },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get());
        }
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_width,
            1,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Result. Must match the fragment shader, using the sequence index for the red component.
        let result = color_buffer.read_bytes(device)?;
        let mut ok = true;
        for x in 0..fb_width as usize {
            let expected = [x as u32 as u8, 0u8, 255u8, 255u8];
            if result[x * 4..x * 4 + 4] != expected {
                log::error!("pixel {x}: got {:?} expected {expected:?}", &result[x * 4..x * 4 + 4]);
                ok = false;
            }
        }
        if !ok {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `drawIndexBaseInstanceRun`
    fn draw_index_base_instance_run(&self, count_token: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = 2u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        // Different from all quad colors below because red is zero.
        let clear_color: Vec4 = [0.0, 0.0, 0.0, 1.0];
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;

        // 9 vertices which are the quadrant corners mixing values -1, 0 and 1 for each XY coord.
        let vertices: Vec<Vec4> = vec![
            [-1.0, -1.0, 0.0, 1.0], // 0
            [-1.0, 0.0, 0.0, 1.0],  // 1
            [-1.0, 1.0, 0.0, 1.0],  // 2
            [0.0, -1.0, 0.0, 1.0],  // 3
            [0.0, 0.0, 0.0, 1.0],   // 4
            [0.0, 1.0, 0.0, 1.0],   // 5
            [1.0, -1.0, 0.0, 1.0],  // 6
            [1.0, 0.0, 0.0, 1.0],   // 7
            [1.0, 1.0, 0.0, 1.0],   // 8
        ];
        let indices: Vec<u32> = vec![
            0, 1, 3, 4, // NW
            3, 4, 6, 7, // NE
            1, 2, 4, 5, // SW
            4, 5, 7, 8, // SE
        ];
        let (vertex_buffer, _) = make_address_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let (index_buffer, _) = make_address_buffer(context, &indices, vk::BufferUsageFlags::INDEX_BUFFER)?;

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = crate::vk::obj_util::make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        let pipeline = build_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &StageModules {
                vert: *vert_module,
                tesc: None,
                tese: None,
                geom: None,
                frag: *frag_module,
            },
            &PipelineOptions {
                extent: (fb_extent, fb_extent),
                topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
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

        // Commands layout.
        let sequence_count: u32 = if count_token { 2 } else { 4 };
        let draws_per_sequence: u32 = if count_token { 2 } else { 1 };
        let vertices_per_draw = 4u32;
        let max_draw_count = draws_per_sequence;

        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        if count_token {
            cmds_layout_builder.add_draw_indexed_count_token(0);
        } else {
            cmds_layout_builder.add_draw_indexed_token(0);
        }
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Draw commands. Each of these draws 4 vertices and 1 instance, but the base vertex and instance varies per draw.
        let draw_cmds: Vec<vk::DrawIndexedIndirectCommand> = [(0u32, 0u32), (1, 0), (2, 1), (3, 1)]
            .iter()
            .map(|&(quad, first_instance)| vk::DrawIndexedIndirectCommand {
                index_count: vertices_per_draw,
                instance_count: 1,
                first_index: vertices_per_draw * quad,
                vertex_offset: 0,
                first_instance,
            })
            .collect();

        // Store them in a DGC buffer (indirect + device address).
        let draw_cmds_buffer_size = std::mem::size_of_val(draw_cmds.as_slice()) as vk::DeviceSize;
        let draw_cmds_buffer = DgcBuffer::new(
            context,
            draw_cmds_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: plain-old-data viewed as bytes.
        let draw_cmds_bytes =
            unsafe { std::slice::from_raw_parts(draw_cmds.as_ptr().cast::<u8>(), draw_cmds_buffer_size as usize) };
        write_buffer_bytes(device, draw_cmds_buffer.get_allocation(), draw_cmds_bytes)?;

        let draw_cmds_address = draw_cmds_buffer.get_device_address();
        let draw_cmd_size = std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32;

        // Indirect draw commands. Each of these dispatches 2 of the draws above.
        let indirect_draw_cmds: Vec<vk::DrawIndirectCountIndirectCommandEXT> = (0..2u32)
            .map(|i| vk::DrawIndirectCountIndirectCommandEXT {
                buffer_address: draw_cmds_address + (draw_cmd_size * draws_per_sequence * i) as vk::DeviceAddress,
                stride: draw_cmd_size,
                command_count: draws_per_sequence,
            })
            .collect();
        let dgc_buffer_size = std::mem::size_of_val(indirect_draw_cmds.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        // SAFETY: plain-old-data viewed as bytes.
        let dgc_bytes =
            unsafe { std::slice::from_raw_parts(indirect_draw_cmds.as_ptr().cast::<u8>(), dgc_buffer_size as usize) };
        write_buffer_bytes(device, dgc_buffer.get_allocation(), dgc_bytes)?;

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            sequence_count,
            max_draw_count,
            *pipeline,
            0,
        )?;

        // Commands.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent, fb_extent),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT32);
        }
        {
            let (dgc_address, dgc_size) = if count_token {
                (dgc_buffer.get_device_address(), dgc_buffer.get_size())
            } else {
                (draw_cmds_address, draw_cmds_buffer.get_size())
            };
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                dgc_address,
                dgc_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                sequence_count,
                0,
                max_draw_count,
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
            fb_extent,
            fb_extent,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let result = color_buffer.read_bytes(device)?;
        let alt_green = if count_token { 1.0f32 } else { 0.0 }; // For non-count tokens, draw id is always zero.
        // Pixel order: (0,0), (1,0), (0,1), (1,1).
        let reference: [Vec4; 4] = [
            [1.0, 0.0, 0.0, 1.0],
            [1.0, alt_green, 0.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [1.0, alt_green, 1.0, 1.0],
        ];
        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The small `misc` cases of `dgc.ext.graphics`, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for preprocess in [false, true] {
        let name = format!("early_fragment_tests{}", if preprocess { "_preprocess" } else { "" });
        cases.push((
            format!("ext.graphics.misc.{name}"),
            Box::new(MiscCase {
                name,
                variant: Variant::EarlyFragmentTests(preprocess),
            }) as Box<dyn TestCase>,
        ));
    }
    for count_token in [true, false] {
        let name = format!(
            "indexed_draws_with_draw_index_base_instance{}",
            if count_token { "_count" } else { "" }
        );
        cases.push((
            format!("ext.graphics.misc.{name}"),
            Box::new(MiscCase {
                name,
                variant: Variant::DrawIndexBaseInstance(count_token),
            }) as Box<dyn TestCase>,
        ));
    }
    for descriptor_heap in [false, true] {
        let name = format!(
            "sequence_index_token{}",
            if descriptor_heap { "_descriptor_heap" } else { "" }
        );
        cases.push((
            format!("ext.graphics.misc.{name}"),
            Box::new(MiscCase {
                name,
                variant: Variant::SequenceIndexToken(descriptor_heap),
            }) as Box<dyn TestCase>,
        ));
    }
    cases
}
