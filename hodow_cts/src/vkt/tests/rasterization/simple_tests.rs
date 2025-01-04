// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationTests.cpp
//   (`StrideZeroCase`/`StrideZeroInstance` and `CullAndPrimitiveIdCase`/`CullAndPrimitiveIdInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Two self-contained cases of the rasterization group: points drawn from a vertex binding with stride zero (only the
// first point of the buffer may ever be used), and one triangle per pixel where half of them are back-face culled while
// `gl_PrimitiveID` still has to count every one of them. The shaders are in `shaders/manifest/rasterization_simple.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::rasterization_simple::{CULL_PRIMITIVE_ID, STRIDE_ZERO};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: just the shader pair.
pub struct SimpleProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

pub(super) const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: [u8; 4] = [0, 0, 0, 255];
const DRAW_COLOR: [u8; 4] = [255, 255, 255, 255];

/// What `makeGraphicsPipeline` builds from the arguments these two cases pass: one pipeline over a fixed image size.
#[allow(clippy::too_many_arguments)]
fn create_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    size: (u32, u32),
    topology: vk::PrimitiveTopology,
    vertex_bindings: &[vk::VertexInputBindingDescription],
    vertex_attributes: &[vk::VertexInputAttributeDescription],
    cull_mode: vk::CullModeFlags,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(vertex_bindings)
        .vertex_attribute_descriptions(vertex_attributes);
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: size.0 as f32,
        height: size.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: size.0,
            height: size.1,
        },
    }];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(cull_mode)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state =
        vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vert)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(frag)
            .name(b"main\0")
            .build(),
    ];
    let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .color_blend_state(&color_blend_state)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// The colour attachment, its view and the buffer it is copied to.
pub(super) struct ColorTarget<'a> {
    pub(super) image: ImageWithMemory<'a>,
    pub(super) view: Unique<'a, vk::ImageView>,
    pub(super) buffer: BufferWithMemory<'a>,
}

impl<'a> ColorTarget<'a> {
    pub(super) fn new(context: &'a Context<'a>, width: u32, height: u32) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width,
                height,
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
        let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
        let view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (width * height * 4) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        Ok(Self { image, view, buffer })
    }

    /// The copied texels, `width * height` of them.
    pub(super) fn read(&self, context: &Context<'_>, texel_count: usize) -> Result<&[u8], TestError> {
        invalidate_alloc(context.get_device(), self.buffer.get_allocation())?;
        Ok(unsafe { std::slice::from_raw_parts(self.buffer.get_allocation().get_host_ptr(), texel_count * 4) })
    }
}

// ---------------------------------------------------------------------------------
// stride_zero
// ---------------------------------------------------------------------------------

const STRIDE_ZERO_IMAGE_DIM: u32 = 2;
const CORNER_DELTA: f32 = 0.5;

#[derive(Clone)]
struct StrideZeroParams {
    buffer_data: Vec<[f32; 2]>,
    draw_vertex_count: u32,
}

struct StrideZeroCase {
    name: &'static str,
    params: StrideZeroParams,
}

impl TestCase for StrideZeroCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), COLOR_FORMAT)
        };
        let color_features = vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
        if !properties.optimal_tiling_features.contains(color_features) {
            return Err(TestError::NotSupported(
                "Required image format not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        STRIDE_ZERO.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StrideZeroInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct StrideZeroInstance<'a> {
    context: &'a Context<'a>,
    params: StrideZeroParams,
}

impl TestInstance for StrideZeroInstance<'_> {
    /// Creates a vertex buffer with the given data but uses zero as the binding stride. Then, tries to draw the requested
    /// number of points. Only the first point should ever be used.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let image_dim = STRIDE_ZERO_IMAGE_DIM;

        // Prepare vertex buffer.
        let vertex_buffer_size = std::mem::size_of_val(self.params.buffer_data.as_slice()) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                self.params.buffer_data.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Prepare render image.
        let target = ColorTarget::new(context, image_dim, image_dim)?;

        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            // [IMPORTANT]
            stride: 0,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: image_dim,
                height: image_dim,
            },
        };
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vertex_shader = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let graphics_pipeline = create_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vertex_shader,
            *fragment_shader,
            (image_dim, image_dim),
            vk::PrimitiveTopology::POINT_LIST,
            &vertex_bindings,
            &vertex_attributes,
            vk::CullModeFlags::NONE,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target.view], image_dim, image_dim, 1)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            render_area,
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_draw(cmd, self.params.draw_vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        copy_image_to_buffer(
            device,
            cmd,
            target.image.get(),
            target.buffer.get(),
            image_dim,
            image_dim,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Check buffer.
        let pixels = target.read(context, (image_dim * image_dim) as usize)?;
        let mut test_status = TestStatus::pass("Pass");

        for x in 0..image_dim {
            for y in 0..image_dim {
                // Only the top-left corner should have draw data.
                let expected_color = if x == 0 && y == 0 { DRAW_COLOR } else { CLEAR_COLOR };
                let offset = ((y * image_dim + x) * 4) as usize;
                let image_color = &pixels[offset..offset + 4];

                if image_color != expected_color {
                    log::info!(
                        "Unexpected color found in pixel ({x}, {y}): expected {expected_color:?} and found {image_color:?}"
                    );
                    test_status = TestStatus::fail("Failed; Check log for details");
                }
            }
        }

        Ok(test_status)
    }
}

/// The `stride_zero` group of `createRasterizationTests`.
pub fn create_stride_zero_tests() -> TestCaseGroup {
    let mut stride_zero_tests = TestCaseGroup::new("stride_zero");
    let delta = CORNER_DELTA;
    let cases = [
        // Attempt to draw 1 point with stride 0
        (
            "single_point",
            StrideZeroParams {
                buffer_data: vec![[-delta, -delta]],
                draw_vertex_count: 1,
            },
        ),
        // Attempt to draw 4 points with stride 0 and 4 points in the buffer
        (
            "four_points",
            StrideZeroParams {
                buffer_data: vec![[-delta, -delta], [delta, -delta], [-delta, delta], [delta, delta]],
                draw_vertex_count: 4,
            },
        ),
        // Attempt to draw many points with stride 0 with one point in the buffer
        (
            "many_points",
            StrideZeroParams {
                buffer_data: vec![[-delta, -delta]],
                draw_vertex_count: 100000,
            },
        ),
    ];
    for (name, params) in cases {
        stride_zero_tests.add_child(Box::new(StrideZeroCase { name, params }) as Box<dyn TestCase>);
    }
    stride_zero_tests
}

// ---------------------------------------------------------------------------------
// culling.primitive_id
// ---------------------------------------------------------------------------------

const CULL_AND_PRIMITIVE_ID_WIDTH: u32 = 64;
const CULL_AND_PRIMITIVE_ID_HEIGHT: u32 = 64;

struct CullAndPrimitiveIdCase;

impl TestCase for CullAndPrimitiveIdCase {
    fn name(&self) -> &str {
        "primitive_id"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature geometryShader not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        CULL_PRIMITIVE_ID.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CullAndPrimitiveIdInstance { context })
    }
}

struct CullAndPrimitiveIdInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for CullAndPrimitiveIdInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let (width, height) = (CULL_AND_PRIMITIVE_ID_WIDTH, CULL_AND_PRIMITIVE_ID_HEIGHT);
        let triangle_count = width * height;
        let vertex_count = triangle_count * 3;

        // Color attachment and verification buffer.
        let target = ColorTarget::new(context, width, height)?;

        // Render pass and framebuffer.
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*target.view], width, height, 1)?;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Pipeline layout and graphics pipeline, culling the back faces.
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = create_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_module,
            *frag_module,
            (width, height),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            &[],
            &[],
            vk::CullModeFlags::BACK,
        )?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        // Draw.
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width, height },
        };
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            render_area,
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        // Copy to verification buffer.
        copy_image_to_buffer(device, cmd, target.image.get(), target.buffer.get(), width, height);
        end_command_buffer(device, cmd)?;

        // Submit and validate result.
        submit_commands_and_wait(device, queue, cmd)?;
        let pixels = target.read(context, triangle_count as usize)?;

        // Compose the reference image: the colour rotates every three pixels, and every odd one was culled.
        let color_palette: [[u8; 4]; 3] = [[255, 0, 0, 255], [0, 255, 0, 255], [0, 0, 255, 255]];
        for y in 0..height {
            for x in 0..width {
                let pixel_id = (y * width + x) as usize;
                let culled = pixel_id % 2 == 1;
                let expected = if culled {
                    CLEAR_COLOR
                } else {
                    color_palette[pixel_id % 3]
                };
                if pixels[pixel_id * 4..pixel_id * 4 + 4] != expected {
                    return Err(TestError::Fail("Failed; check log for details".to_string()));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `primitive_id` case of the `culling` group.
pub fn create_cull_and_primitive_id_test() -> Box<dyn TestCase> {
    Box::new(CullAndPrimitiveIdCase)
}
