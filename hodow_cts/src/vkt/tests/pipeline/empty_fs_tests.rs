// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineEmptyFSTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `tcu::dsThresholdCompare` is a per-pixel depth comparison here.
//
// The `geom` cases pass `VK_SHADER_STAGE_VERTEX_BIT` as the last vertex stage upstream, so they build exactly the
// pipeline of the `vert` cases under another name; that is kept.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_empty_fs::{
    EMPTY_FS_MASKED_SAMPLES, EMPTY_FS_PRIMITIVE_DISCARD, EMPTY_FS_TESS_EMPTY_FS, EMPTY_FS_TESS_NO_FS,
    EMPTY_FS_VERT_EMPTY_FS, EMPTY_FS_VERT_NO_FS,
};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_dynamic_rendering, end_dynamic_rendering, make_shader_objects_stages,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Basic,
    PrimitiveDiscard,
    MaskedSamples,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    /// Last vertex shader stage: vertex or tessellation.
    last_vertex_stage: vk::ShaderStageFlags,
    /// True: empty FS; False: do not include a fragment shader at all.
    empty_fs: bool,
}

impl TestParams {
    fn last_is_tessellation(&self) -> bool {
        self.last_vertex_stage == vk::ShaderStageFlags::TESSELLATION_CONTROL
            || self.last_vertex_stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION
    }
}

struct EmptyFsCase {
    name: String,
    params: TestParams,
}

impl TestCase for EmptyFsCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `EmptyFSCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();

        if self.params.last_is_tessellation() {
            if features.tessellation_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requires VkPhysicalDeviceFeatures::tessellationShader".to_string(),
                ));
            }
            if features.shader_tessellation_and_geometry_point_size == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requires VkPhysicalDeviceFeatures::shaderTessellationAndGeometryPointSize".to_string(),
                ));
            }
        }

        if self.params.test_type == TestType::PrimitiveDiscard && features.shader_cull_distance == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::shaderCullDistance".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (
            self.params.test_type,
            self.params.last_is_tessellation(),
            self.params.empty_fs,
        ) {
            (TestType::PrimitiveDiscard, _, _) => EMPTY_FS_PRIMITIVE_DISCARD.programs,
            (TestType::MaskedSamples, _, _) => EMPTY_FS_MASKED_SAMPLES.programs,
            (TestType::Basic, false, false) => EMPTY_FS_VERT_NO_FS.programs,
            (TestType::Basic, false, true) => EMPTY_FS_VERT_EMPTY_FS.programs,
            (TestType::Basic, true, false) => EMPTY_FS_TESS_NO_FS.programs,
            (TestType::Basic, true, true) => EMPTY_FS_TESS_EMPTY_FS.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EmptyFsInstance {
            context,
            params: self.params,
        })
    }
}

/// `EmptyFSInstance` and `EmptyFSSelectiveDSUpdateInstance`
struct EmptyFsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

fn create_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    extent: u32,
    usage: vk::ImageUsageFlags,
    samples: vk::SampleCountFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: extent,
            height: extent,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// The two barriers and the copy of `copyImageToBuffer` for the depth aspect of an extent x extent image.
fn copy_depth_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    extent: u32,
    old_layout: vk::ImageLayout,
    src_stage: vk::PipelineStageFlags,
) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: extent,
            height: extent,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
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

fn depth_clear_value(depth: f32) -> vk::ClearValue {
    vk::ClearValue {
        depth_stencil: vk::ClearDepthStencilValue { depth, stencil: 0 },
    }
}

fn depth_stencil_always() -> vk::PipelineDepthStencilStateCreateInfo {
    vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(true)
        .depth_write_enable(true)
        .depth_compare_op(vk::CompareOp::ALWAYS)
        .build()
}

impl EmptyFsInstance<'_> {
    /// `EmptyFSInstance::iterate`
    fn iterate_basic(&self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        const EXTENT: u32 = 2;
        let pixel_count = EXTENT * EXTENT;
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let ds_format = vk::Format::D16_UNORM;
        let tcu_format = crate::tcu::map_vk_format(ds_format)
            .ok_or_else(|| TestError::InternalError("no tcu format for D16_UNORM".to_string()))?;
        let depth_thres = 0.000025f32; // 1/65535 < depthThres < 2/65535
        let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let ds_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

        // Color buffer.
        let color_buffer = ImageWithBuffer::new(context, EXTENT, EXTENT, fb_format, fb_usage, 4)?;

        // Depth/stencil buffer.
        let ds_image = create_image(context, ds_format, EXTENT, ds_usage, vk::SampleCountFlags::_1)?;
        let ds_view = make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            ds_format,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;
        let ds_buffer_size = (EXTENT * EXTENT * 2) as vk::DeviceSize;
        let ds_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(ds_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Vertices.
        let pixel_width = 2.0 / EXTENT as f32;
        let pixel_height = 2.0 / EXTENT as f32;
        let hor_margin = pixel_width / 4.0;
        let vert_margin = pixel_height / 4.0;

        let calc_center = |i: u32, size: u32| (i as f32 + 0.5) / size as f32 * 2.0 - 1.0;

        // One triangle per pixel with varying depth.
        let mut vertices: Vec<[f32; 4]> = Vec::new();
        for y in 0..EXTENT {
            for x in 0..EXTENT {
                let x_center = calc_center(x, EXTENT);
                let y_center = calc_center(y, EXTENT);
                let pixel_id = y * EXTENT + x;
                let depth = pixel_id as f32 / pixel_count as f32;

                // Triangle around the center.
                vertices.push([x_center, y_center - vert_margin, depth, 1.0]);
                vertices.push([x_center - hor_margin, y_center + vert_margin, depth, 1.0]);
                vertices.push([x_center + hor_margin, y_center + vert_margin, depth, 1.0]);
            }
        }

        // Vertex buffer
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Pipeline layout and render pass
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(fb_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(ds_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_ref = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_ref)
            .depth_stencil_attachment(&depth_ref)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view, *ds_view], EXTENT, EXTENT, 1)?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tess_modules = if params.last_is_tessellation() {
            Some((
                create_shader_module(device, binaries.get("tesc")?)?,
                create_shader_module(device, binaries.get("tese")?)?,
            ))
        } else {
            None
        };
        let frag_module = if params.empty_fs {
            Some(create_shader_module(device, binaries.get("frag")?)?)
        } else {
            None
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let Some((tesc_module, tese_module)) = &tess_modules {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc_module));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese_module));
        }
        if let Some(frag_module) = &frag_module {
            stages.push((vk::ShaderStageFlags::FRAGMENT, **frag_module));
        }

        let topology = if params.last_is_tessellation() {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let mut state = DrawPipelineState::new(topology)
            .with_position_input()
            .with_full_viewport(EXTENT, EXTENT);
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .line_width(1.0)
            .build();
        state.depth_stencil = depth_stencil_always();
        if params.last_is_tessellation() {
            state.patch_control_points = Some(3);
        }
        let mut stage_names = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
        if params.last_is_tessellation() {
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"));
        }
        if params.empty_fs {
            stage_names.push((vk::ShaderStageFlags::FRAGMENT, "frag"));
        }
        let shader_objects = make_shader_objects_stages(context, &stage_names, &[], &[])?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?)
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0]), depth_clear_value(0.0)];
        begin_command_buffer(device, *cmd_buffer)?;
        if let Some(objects) = &shader_objects {
            let to_attachment = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_buffer.image.get(),
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    ds_image.get(),
                    make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &to_attachment,
                );
            }
            begin_dynamic_rendering(
                device,
                *cmd_buffer,
                rect_2d(EXTENT, EXTENT),
                &[RenderingAttachment {
                    view: *color_buffer.view,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    clear_value: clear_values[0],
                }],
                Some(RenderingAttachment {
                    view: *ds_view,
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    clear_value: clear_values[1],
                }),
                None,
            );
            objects.bind(*cmd_buffer, &state);
            unsafe {
                device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0);
            }
            end_dynamic_rendering(device, *cmd_buffer);
        } else if let Some(pipeline) = &pipeline {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(EXTENT, EXTENT))
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                device.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0);
                device.cmd_end_render_pass(*cmd_buffer);
            }
        }
        copy_depth_to_buffer(
            device,
            *cmd_buffer,
            ds_image.get(),
            ds_buffer.get(),
            EXTENT,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        );
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verify depth output.
        invalidate_alloc(device, ds_buffer.get_allocation())?;
        let result_bytes =
            unsafe { std::slice::from_raw_parts(ds_buffer.get_allocation().get_host_ptr(), ds_buffer_size as usize) };
        let result_access = ConstPixelBufferAccess::new(tcu_format, [EXTENT, EXTENT, 1], result_bytes);

        for y in 0..EXTENT {
            for x in 0..EXTENT {
                let pixel_id = y * EXTENT + x;
                let depth = pixel_id as f32 / pixel_count as f32;

                if (result_access.get_pix_depth(x, y, 0) - depth).abs() > depth_thres {
                    return Ok(TestStatus::fail(
                        "Unexpected color in result buffer; check log for details",
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `EmptyFSSelectiveDSUpdateInstance::iterate`
    fn iterate_selective(&self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        let test_primitive_discard = params.test_type == TestType::PrimitiveDiscard;

        // pick depth stencil format (one of those two has to be supported)
        const EXTENT: u32 = 8;
        let mut ds_format = vk::Format::D24_UNORM_S8_UINT;
        let mut d_read_format = vk::Format::D24_UNORM_S8_UINT;
        let ds_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::SAMPLED;
        let ds_format_check = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                ds_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                ds_usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if ds_format_check.is_err() {
            ds_format = vk::Format::D32_SFLOAT_S8_UINT;

            // when copying depth attachment data we read just depth component
            d_read_format = vk::Format::D32_SFLOAT;
        }

        // depth/stencil image with buffer
        let samples = if test_primitive_discard {
            vk::SampleCountFlags::_1
        } else {
            vk::SampleCountFlags::_4
        };
        let ds_image = create_image(context, ds_format, EXTENT, ds_usage, samples)?;
        let image_view = make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            ds_format,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;
        let ds_buffer_size = (EXTENT * EXTENT * 4) as vk::DeviceSize;
        let ds_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(ds_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // create renderpass
        let attachments = [vk::AttachmentDescription::builder()
            .format(ds_format)
            .samples(samples)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::GENERAL)
            .build()];
        let depth_stencil_attachment = vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .depth_stencil_attachment(&depth_stencil_attachment)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // create framebuffer
        let framebuffer = make_framebuffer(device, *render_pass, &[*image_view], EXTENT, EXTENT, 1)?;

        // for TestType::PrimitiveDiscard vertex shader is writing to gl_CullDistance, discarding some primitives but not others;
        // for TestType::MaskedSamples vertex shader just outputs vartex position;
        // there is no fragment shader in the pipeline for both test types
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;

        let graphics_pipeline_layout = make_pipeline_layout(device, &[])?;

        // create vertex buffer (just xy components)
        let size = 3.0f32;
        let vertices: [f32; 14] = [
            0.0, 0.0, // 0 - center
            0.0, size, // 1 - top
            -size, 0.0, // 2 - left
            0.0, -size, // 3 - bottom
            size, 0.0, // 4 - right
            -size, 0.0, // 5 - left duplicated to prevent from culling in VS (for TestType::PrimitiveDiscard)
            size, 0.0, // 6 - right duplicated to prevent triangle from cull in VS
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // create index buffer for four triangles, each big enough to fill quarter of framebuffer
        let mut vertices_index: [u32; 12] = [
            0, 1, 2, // top-left triangle
            0, 2, 3, // bottom-left triangle
            0, 3, 4, // bottom-right triangle
            0, 4, 1, // top-right triangle
        ];

        if test_primitive_discard {
            // when primitive discard is tested VS will cull all triangles
            // that have vertex with gl_VertexIndex smaller then 5;
            // we need to prevent two triangles from beeing culled
            vertices_index[2] = 5; // last vertex of first triangle
            vertices_index[8] = 6; // last vertex of third triangle
        }

        let index_buffer = create_host_buffer(context, &vertices_index, vk::BufferUsageFlags::INDEX_BUFFER)?;

        // create ssbo buffer; used only for TestType::MaskedSamples
        let ssbo_size = (EXTENT * EXTENT) as vk::DeviceSize * std::mem::size_of::<f32>() as vk::DeviceSize;
        let ssbo_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // define custom pipeline state
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(EXTENT, EXTENT);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        state.depth_stencil = depth_stencil_always();
        state.color_attachment_count = 0;

        // 0x5 is 0101b so we write to 3 samples out of 4 in TestType::MaskedSamples;
        // this will affect occlusion query result
        state.samples = samples;
        state.min_sample_shading = 1.0;
        state.sample_mask = Some(0x5);

        // create pipeline
        let shader_objects = make_shader_objects_stages(context, &[(vk::ShaderStageFlags::VERTEX, "vert")], &[], &[])?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *graphics_pipeline_layout,
                *render_pass,
                &[(vk::ShaderStageFlags::VERTEX, *vert_module)],
                &state,
            )?)
        };

        // create descriptor set and the compute pipeline that reads each sample
        let compute_objects = if !test_primitive_discard {
            let compute_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::SAMPLED_IMAGE, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .build(device)?;

            let compute_descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::SAMPLED_IMAGE, 1)
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

            let compute_descriptor_set =
                make_descriptor_set(device, *compute_descriptor_pool, *compute_descriptor_set_layout)?;

            let image_descriptor_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let buffer_descriptor_info = [vk::DescriptorBufferInfo {
                buffer: ssbo_buffer.get(),
                offset: 0,
                range: ssbo_size,
            }];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(compute_descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::SAMPLED_IMAGE)
                    .image_info(&image_descriptor_info),
                vk::WriteDescriptorSet::builder()
                    .dst_set(compute_descriptor_set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&buffer_descriptor_info),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

            let compute_pipeline_layout = make_pipeline_layout(device, &[*compute_descriptor_set_layout])?;

            let comp_module = create_shader_module(device, binaries.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*comp_module)
                .name(b"main\0")
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*compute_pipeline_layout)
                .base_pipeline_index(-1)
                .build();
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            let compute_pipeline = Unique::new(device, pipelines.0[0]);

            // Field order is drop order: the set has to go before the pool it was allocated from.
            Some((
                compute_pipeline,
                compute_pipeline_layout,
                compute_descriptor_set,
                compute_descriptor_pool,
                compute_descriptor_set_layout,
                comp_module,
            ))
        } else {
            None
        };

        // create query object
        let use_precise_occlusion_query = context.get_device_features().occlusion_query_precise != vk::FALSE;
        let query_pool_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::OCCLUSION)
            .query_count(1);
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;

        let clear_values = [depth_clear_value(0.0)];
        let query_flags = if use_precise_occlusion_query {
            vk::QueryControlFlags::PRECISE
        } else {
            vk::QueryControlFlags::empty()
        };
        unsafe { device.cmd_reset_query_pool(*cmd_buffer, *query_pool, 0, 1) };
        if let Some(objects) = &shader_objects {
            let ds_range =
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
            let barrier_to_attachment = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ds_image.get(),
                ds_range,
            );
            // The render pass left the image in GENERAL, the later commands rely on it.
            let barrier_to_general = make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::GENERAL,
                ds_image.get(),
                ds_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier_to_attachment],
                );
            }
            begin_dynamic_rendering(
                device,
                *cmd_buffer,
                rect_2d(EXTENT, EXTENT),
                &[],
                Some(RenderingAttachment {
                    view: *image_view,
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    clear_value: clear_values[0],
                }),
                None,
            );
            objects.bind(*cmd_buffer, &state);
            unsafe {
                device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_index_buffer(*cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT32);
                device.cmd_begin_query(*cmd_buffer, *query_pool, 0, query_flags);
                device.cmd_draw_indexed(*cmd_buffer, vertices_index.len() as u32, 1, 0, 0, 0);
                device.cmd_end_query(*cmd_buffer, *query_pool, 0);
            }
            end_dynamic_rendering(device, *cmd_buffer);
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier_to_general],
                );
            }
        } else if let Some(pipeline) = &pipeline {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(EXTENT, EXTENT))
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_index_buffer(*cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT32);
                device.cmd_begin_query(*cmd_buffer, *query_pool, 0, query_flags);
                device.cmd_draw_indexed(*cmd_buffer, vertices_index.len() as u32, 1, 0, 0, 0);
                device.cmd_end_query(*cmd_buffer, *query_pool, 0);
                device.cmd_end_render_pass(*cmd_buffer);
            }
        }

        if test_primitive_discard {
            // copy single sampled depth to buffer
            copy_depth_to_buffer(
                device,
                *cmd_buffer,
                ds_image.get(),
                ds_buffer.get(),
                EXTENT,
                vk::ImageLayout::GENERAL,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            );
        } else if let Some((compute_pipeline, compute_pipeline_layout, compute_descriptor_set, _, _, _)) =
            &compute_objects
        {
            // wait for multisampled depth
            let barrier = make_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::SHADER_READ,
            );
            let ssbo_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );

                // read each sample using compute shader
                device.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    **compute_pipeline_layout,
                    0,
                    &[compute_descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, **compute_pipeline);
                device.cmd_dispatch(*cmd_buffer, 1, 1, 1);

                // wait for ssbo
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[ssbo_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // get occlusion query result
        let mut query_bytes = [0u8; 8];
        unsafe {
            device.get_query_pool_results(
                *query_pool,
                0,
                1,
                &mut query_bytes,
                8,
                vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
            )
        }
        .vk_check("vkGetQueryPoolResults")?;
        let query_result = u64::from_ne_bytes(query_bytes);

        let mut pass;

        if test_primitive_discard {
            // get depth data from buffer
            invalidate_alloc(device, ds_buffer.get_allocation())?;
            let tcu_format = crate::tcu::map_vk_format(d_read_format)
                .ok_or_else(|| TestError::InternalError("no tcu format for the depth read format".to_string()))?;
            let result_bytes = unsafe {
                std::slice::from_raw_parts(ds_buffer.get_allocation().get_host_ptr(), ds_buffer_size as usize)
            };
            let result_access = ConstPixelBufferAccess::new(tcu_format, [EXTENT, EXTENT, 1], result_bytes);

            // drawing should update the depth/stencil buffer only for primitives that were not discarded by cull distance;
            // checking just centers of each quarters
            pass = result_access.get_pix_depth(3, 3, 0) < 0.01
                && result_access.get_pix_depth(7, 3, 0) > 0.99
                && result_access.get_pix_depth(3, 7, 0) > 0.99
                && result_access.get_pix_depth(7, 7, 0) < 0.01;

            // occlusion queries should only be incremented for primitives that are not discarded
            // 8 * 8 / 2 = 32
            pass &= if use_precise_occlusion_query {
                query_result == 32
            } else {
                query_result > 0
            };
        } else {
            // get ssbo buffer
            invalidate_alloc(device, ssbo_buffer.get_allocation())?;
            let data = unsafe {
                std::slice::from_raw_parts(
                    ssbo_buffer.get_allocation().get_host_ptr().cast::<f32>(),
                    (EXTENT * EXTENT) as usize,
                )
            };

            // part of verification is done in compute shader, we just need to check if all elements have value of 2.0
            pass = !data.iter().any(|&f| !(1.99..=2.01).contains(&f));

            // 8 * 8 * 2 samples = 128
            pass &= if use_precise_occlusion_query {
                query_result == 128
            } else {
                query_result > 0
            };
        }

        if pass {
            return Ok(TestStatus::pass("Pass"));
        }

        Ok(TestStatus::fail(format!("Fail (query result: {query_result})")))
    }
}

impl TestInstance for EmptyFsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.params.test_type == TestType::PrimitiveDiscard || self.params.test_type == TestType::MaskedSamples {
            self.iterate_selective()
        } else {
            self.iterate_basic()
        }
    }
}

/// `createEmptyFSTests`
pub fn create_empty_fs_tests() -> TestCaseGroup {
    let mut empty_fs_tests = TestCaseGroup::new("empty_fs");

    let vertex_stages = [
        (vk::ShaderStageFlags::VERTEX, "vert"),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tess"),
        // Upstream's own choice of stage for `geom`, see the file header.
        (vk::ShaderStageFlags::VERTEX, "geom"),
    ];

    for (shader_stage, stage_name) in vertex_stages {
        for empty_fs in [false, true] {
            let suffix = if empty_fs { "_empty_fs" } else { "_no_fs" };
            let test_name = format!("{stage_name}{suffix}");
            let params = TestParams {
                test_type: TestType::Basic,
                last_vertex_stage: shader_stage,
                empty_fs,
            };

            empty_fs_tests.add_child(Box::new(EmptyFsCase {
                name: test_name,
                params,
            }) as Box<dyn TestCase>);
        }
    }

    let mut params = TestParams {
        test_type: TestType::PrimitiveDiscard,
        last_vertex_stage: vk::ShaderStageFlags::VERTEX,
        empty_fs: false,
    };
    empty_fs_tests.add_child(Box::new(EmptyFsCase {
        name: "primitive_discard".to_string(),
        params,
    }) as Box<dyn TestCase>);
    params.test_type = TestType::MaskedSamples;
    empty_fs_tests.add_child(Box::new(EmptyFsCase {
        name: "masked_samples".to_string(),
        params,
    }) as Box<dyn TestCase>);

    empty_fs_tests
}
