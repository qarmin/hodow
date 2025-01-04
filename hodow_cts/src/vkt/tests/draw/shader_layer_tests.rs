// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawShaderLayerTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_shader_layer::{SHADER_LAYER_TESSELLATION, SHADER_LAYER_VERTEX};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::initial_transition_color_2d_image;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Minimum number of framebuffer layers.
const MIN_MAX_FRAMEBUFFER_LAYERS: u32 = 256;
/// Minimum number of viewports for an implementation supporting multiViewport.
const MIN_MAX_VIEWPORTS: u32 = 16;

#[derive(Clone, Copy)]
struct TestParams {
    num_layers: u32,
    require_tessellation_shader: bool,
    group_params: GroupParams,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Shader {
    Vertex,
    Tessellation,
}

struct ShaderLayerCase {
    name: String,
    params: TestParams,
    shader: Shader,
}

impl TestCase for ShaderLayerCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkRequirements`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().multi_viewport == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: multiViewport".to_string(),
            ));
        }
        context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;

        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if self.params.require_tessellation_shader && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Required feature is not supported: tessellationShader".to_string(),
            ));
        }

        let limits = &context.get_device_properties().limits;

        if limits.max_framebuffer_layers < MIN_MAX_FRAMEBUFFER_LAYERS {
            return Err(TestError::Fail(
                "maxFramebuffersLayers is less than the minimum required".to_string(),
            ));
        }

        if limits.max_viewports < MIN_MAX_VIEWPORTS {
            return Err(TestError::Fail(
                "multiViewport supported but maxViewports is less than the minimum required".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.shader {
            Shader::Vertex => SHADER_LAYER_VERTEX.programs,
            Shader::Tessellation => SHADER_LAYER_TESSELLATION.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderLayerInstance {
            context,
            params: self.params,
            shader: self.shader,
        })
    }
}

/// `generateGrid`
pub fn generate_grid(num_cells: u32, render_size: (u32, u32)) -> Vec<[u32; 4]> {
    let num_cols = (num_cells as f32).sqrt().ceil() as u32;
    let num_rows = (num_cells as f32 / num_cols as f32).ceil() as u32;
    let rect_width = render_size.0 / num_cols;
    let rect_height = render_size.1 / num_rows;

    let mut cells = Vec::with_capacity(num_cells as usize);

    let mut x = 0;
    let mut y = 0;

    for cell_ndx in 0..num_cells {
        let next_row = cell_ndx != 0 && cell_ndx % num_cols == 0;
        if next_row {
            x = 0;
            y += rect_height;
        }

        cells.push([x, y, rect_width, rect_height]);

        x += rect_width;
    }

    cells
}

/// `generateColors`
pub fn generate_colors(num_colors: u32) -> Vec<[f32; 4]> {
    const COLORS: [[f32; 4]; 16] = [
        [0.18, 0.42, 0.17, 1.0],
        [0.29, 0.62, 0.28, 1.0],
        [0.59, 0.84, 0.44, 1.0],
        [0.96, 0.95, 0.72, 1.0],
        [0.94, 0.55, 0.39, 1.0],
        [0.82, 0.19, 0.12, 1.0],
        [0.46, 0.15, 0.26, 1.0],
        [0.24, 0.14, 0.24, 1.0],
        [0.49, 0.31, 0.26, 1.0],
        [0.78, 0.52, 0.33, 1.0],
        [0.94, 0.82, 0.31, 1.0],
        [0.98, 0.65, 0.30, 1.0],
        [0.22, 0.65, 0.53, 1.0],
        [0.67, 0.81, 0.91, 1.0],
        [0.43, 0.44, 0.75, 1.0],
        [0.26, 0.24, 0.48, 1.0],
    ];

    (0..num_colors as usize).map(|i| COLORS[i % COLORS.len()]).collect()
}

/// `generateVertices` - a `PositionColorVertex` is a position and a colour, 32 bytes.
fn generate_vertices(grid: &[[u32; 4]], colors: &[[f32; 4]], render_size: (u32, u32)) -> Vec<[f32; 8]> {
    debug_assert!(colors.len() == grid.len());

    // Two triangles for each cell. Each cell correspond to a layer.
    let total = grid.len() * 6;
    let mut result = Vec::with_capacity(total);

    for i in 0..total {
        let cell = grid[i / 6].map(|v| v as f32 * 2.0);
        let x = cell[0] / render_size.0 as f32 - 1.0;
        let y = cell[1] / render_size.1 as f32 - 1.0;
        let width = cell[2] / render_size.0 as f32;
        let height = cell[3] / render_size.1 as f32;

        let (px, py) = match i % 6 {
            0 => (x, y + height),
            1 => (x + width, y + height),
            2 => (x, y),
            3 => (x + width, y),
            4 => (x + width, y + height),
            _ => (x, y),
        };

        let color = colors[i / 6];
        result.push([px, py, 0.0, 1.0, color[0], color[1], color[2], color[3]]);
    }

    result
}

/// `generateReferenceImage` - renders a colorful grid of rectangles.
pub fn generate_reference_image(
    format: TextureFormat,
    render_size: (u32, u32),
    clear_color: [f32; 4],
    cell: [u32; 4],
    cell_color: [f32; 4],
) -> Result<TextureLevel, TestError> {
    let mut image = TextureLevel::new(format, render_size.0, render_size.1, 1)?;
    {
        let mut access = image.get_access();
        for y in 0..render_size.1 {
            for x in 0..render_size.0 {
                access.set_pixel(clear_color, x, y, 0);
            }
        }
        for y in cell[1]..cell[1] + cell[3] {
            for x in cell[0]..cell[0] + cell[2] {
                access.set_pixel(cell_color, x, y, 0);
            }
        }
    }
    Ok(image)
}

/// `vk::copyImageToBuffer` for every layer of a colour image left in COLOR_ATTACHMENT_OPTIMAL.
fn copy_layers_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
    layers: u32,
) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layers),
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

struct ShaderLayerInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    shader: Shader,
}

impl ShaderLayerInstance<'_> {
    /// `Renderer` generates two triangles per layer, each pair using a different color and a different position,
    /// and `Renderer::draw`; the result is copied to `color_buffer`.
    fn render(
        &self,
        render_size: (u32, u32),
        color_format: vk::Format,
        clear_color: [f32; 4],
        vertices: &[[f32; 8]],
        color_buffer: vk::Buffer,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
        let num_layers = params.num_layers;
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let api_1_2 = context.get_device_properties().api_version >= vk::make_version(1, 2, 0);

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk::Extent3D {
                width: render_size.0,
                height: render_size.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(num_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let color_attachment = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D_ARRAY,
            color_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers),
        )?;

        let vertex_buffer = create_host_buffer(context, vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get(if api_1_2 { "vert_1_2" } else { "vert" })?)?;
        let tessellation_modules = if self.shader == Shader::Tessellation {
            let control = create_shader_module(device, binaries.get("tesc")?)?;
            let evaluation = create_shader_module(device, binaries.get(if api_1_2 { "tese_1_2" } else { "tese" })?)?;
            Some((control, evaluation))
        } else {
            None
        };
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_render_pass(device, color_format)?;
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[*color_attachment],
                render_size.0,
                render_size.1,
                num_layers,
            )?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // `makeGraphicsPipeline`
        let mut state = DrawPipelineState::new(if tessellation_modules.is_some() {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        })
        .with_full_viewport(render_size.0, render_size.1);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        if tessellation_modules.is_some() {
            state.patch_control_points = Some(3);
        }
        // when pipeline is created without render pass we are using dynamic rendering
        if dynamic_rendering {
            state.rendering_format = Some(vk::Format::R8G8B8A8_UNORM);
        }
        let mut stages = vec![
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];
        if let Some((control, evaluation)) = &tessellation_modules {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **control));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **evaluation));
        }
        let pipeline = create_draw_pipeline(device, *pipeline_layout, render_pass_handle, &stages, &state)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let sec_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: color_format,
            image_view: *color_attachment,
            render_area: rect_2d(render_size.0, render_size.1),
            clear_value: clear_value_color(clear_color),
            image_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            load_op: vk::AttachmentLoadOp::CLEAR,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            layer_count: num_layers,
            view_mask: 0,
        };
        recorder.record(
            *cmd_buffer,
            if params.group_params.use_secondary_cmd_buffer {
                Some(*sec_cmd_buffer)
            } else {
                None
            },
            |cmd| {
                // `preRenderCommands`
                if dynamic_rendering {
                    initial_transition_color_2d_image(
                        device,
                        cmd,
                        color_image.get(),
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::PipelineStageFlags::TRANSFER,
                        num_layers,
                    );
                }
            },
            |cmd| {
                // `drawCommands`
                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    device.cmd_draw(cmd, num_layers * 6, 1, 0, 0); // two triangles per layer
                }
                Ok(())
            },
            |cmd| {
                copy_layers_to_buffer(
                    device,
                    cmd,
                    color_image.get(),
                    color_buffer,
                    render_size.0,
                    render_size.1,
                    num_layers,
                )
            },
        )?;

        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)
    }
}

impl TestInstance for ShaderLayerInstance<'_> {
    /// `testVertexShader` / `testTessellationShader`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = self.params;

        let render_size = (256u32, 256u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let clear_color = [0.5f32, 0.5, 0.5, 1.0];
        let grid = generate_grid(params.num_layers, render_size);
        let colors = generate_colors(params.num_layers);
        let vertices = generate_vertices(&grid, &colors, render_size);

        let color_buffer_size = (render_size.0 * render_size.1 * 4 * params.num_layers) as vk::DeviceSize;

        let color_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Zero buffer.
        unsafe {
            std::ptr::write_bytes(
                color_buffer.get_allocation().get_host_ptr(),
                0,
                color_buffer_size as usize,
            )
        };
        flush_alloc(device, color_buffer.get_allocation())?;

        // Draw.
        self.render(render_size, color_format, clear_color, &vertices, color_buffer.get())?;

        // Verify layers.
        invalidate_alloc(device, color_buffer.get_allocation())?;
        let result_mem = unsafe {
            std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size as usize)
        };
        let layer_size = color_buffer_size as usize / params.num_layers as usize;
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);

        for i in 0..params.num_layers as usize {
            let result_image = ConstPixelBufferAccess::new(
                format,
                [render_size.0, render_size.1, 1],
                &result_mem[layer_size * i..layer_size * (i + 1)],
            );
            let reference_image = generate_reference_image(format, render_size, clear_color, grid[i], colors[i])?;
            if !float_threshold_compare(&reference_image.get_const_access(), &result_image, [0.02; 4]).ok {
                return Ok(TestStatus::fail("Rendered image is not correct"));
            }
        }

        Ok(TestStatus::pass("OK"))
    }
}

/// `createShaderLayerTests`
pub fn create_shader_layer_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_layer");

    let num_layers_to_test = [1u32, 2, 3, 4, 5, 6, 7, 8, MIN_MAX_FRAMEBUFFER_LAYERS];

    for (shader, require_tessellation_shader, prefix) in [
        (Shader::Vertex, false, "vertex_shader_"),
        (Shader::Tessellation, true, "tessellation_shader_"),
    ] {
        for (i, &num_layers) in num_layers_to_test.iter().enumerate() {
            // reduce number of tests for dynamic rendering cases where secondary command buffer is used
            if group_params.use_secondary_cmd_buffer && i % 2 != 0 {
                continue;
            }

            let params = TestParams {
                num_layers,
                require_tessellation_shader,
                group_params,
            };
            group.add_child(Box::new(ShaderLayerCase {
                name: format!("{prefix}{num_layers}"),
                params,
                shader,
            }) as Box<dyn TestCase>);
        }
    }
    group
}
