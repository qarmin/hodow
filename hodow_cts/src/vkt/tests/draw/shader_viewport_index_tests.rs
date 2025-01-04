// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawShaderViewportIndexTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The layout of this file follows `shader_layer_tests`: the same
// renderer, with viewports in place of layers.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_shader_viewport_index::{
    SHADER_VIEWPORT_INDEX_FRAGMENT_IMPLICIT, SHADER_VIEWPORT_INDEX_FRAGMENT_WRITE, SHADER_VIEWPORT_INDEX_TESSELLATION,
    SHADER_VIEWPORT_INDEX_VERTEX,
};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::initial_transition_color_2d_image;
use crate::vkt::tests::draw::shader_layer_tests::{generate_colors, generate_grid};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Minimum number of viewports for an implementation supporting multiViewport.
const MIN_MAX_VIEWPORTS: u32 = 16;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Shader {
    Vertex,
    Tessellation,
    FragmentWrite,
    FragmentImplicit,
}

impl Shader {
    fn is_fragment(self) -> bool {
        matches!(self, Shader::FragmentWrite | Shader::FragmentImplicit)
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    num_viewports: u32,
    group_params: GroupParams,
    use_tessellation_shader: bool,
}

struct ShaderViewportIndexCase {
    name: String,
    params: TestParams,
    shader: Shader,
}

impl TestCase for ShaderViewportIndexCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().multi_viewport == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: multiViewport".to_string(),
            ));
        }
        context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;

        if context.get_device_properties().limits.max_viewports < MIN_MAX_VIEWPORTS {
            return Err(TestError::Fail(
                "multiViewport supported but maxViewports is less than the minimum required".to_string(),
            ));
        }

        if self.params.use_tessellation_shader && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: tessellationShader".to_string(),
            ));
        }

        if self.params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.shader {
            Shader::Vertex => SHADER_VIEWPORT_INDEX_VERTEX.programs,
            Shader::Tessellation => SHADER_VIEWPORT_INDEX_TESSELLATION.programs,
            Shader::FragmentWrite => SHADER_VIEWPORT_INDEX_FRAGMENT_WRITE.programs,
            Shader::FragmentImplicit => SHADER_VIEWPORT_INDEX_FRAGMENT_IMPLICIT.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderViewportIndexInstance {
            context,
            params: self.params,
            shader: self.shader,
        })
    }
}

/// `generateVertices` - two triangles for each color (viewport), each covering the whole viewport.
fn generate_vertices(colors: &[[f32; 4]]) -> Vec<[f32; 8]> {
    let total = colors.len() * 6;
    let mut result = Vec::with_capacity(total);

    for i in 0..total {
        let (x, y) = match i % 6 {
            0 => (-1.0, 1.0),
            1 => (1.0, 1.0),
            2 => (-1.0, -1.0),
            3 => (1.0, -1.0),
            4 => (1.0, 1.0),
            _ => (-1.0, -1.0),
        };

        let color = colors[i / 6];
        result.push([x, y, 0.0, 1.0, color[0], color[1], color[2], color[3]]);
    }

    result
}

/// `generateReferenceImage` - renders a colorful grid of rectangles.
fn generate_reference_image(
    format: TextureFormat,
    render_size: (u32, u32),
    clear_color: [f32; 4],
    cells: &[[u32; 4]],
    cell_colors: &[[f32; 4]],
) -> Result<TextureLevel, TestError> {
    debug_assert!(cells.len() == cell_colors.len());

    let mut image = TextureLevel::new(format, render_size.0, render_size.1, 1)?;
    {
        let mut access = image.get_access();
        for y in 0..render_size.1 {
            for x in 0..render_size.0 {
                access.set_pixel(clear_color, x, y, 0);
            }
        }

        for (cell, color) in cells.iter().zip(cell_colors) {
            for y in cell[1]..cell[1] + cell[3] {
                for x in cell[0]..cell[0] + cell[2] {
                    access.set_pixel(*color, x, y, 0);
                }
            }
        }
    }
    Ok(image)
}

struct ShaderViewportIndexInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    shader: Shader,
}

impl ShaderViewportIndexInstance<'_> {
    /// `Renderer` generates two triangles per viewport, each pair using a different color. The numViewports are
    /// positioned to form a grid. `Renderer::draw`'s result is copied to `color_buffer`.
    fn render(
        &self,
        render_size: (u32, u32),
        color_format: vk::Format,
        clear_color: [f32; 4],
        cells: &[[u32; 4]],
        colors: &[[f32; 4]],
        color_buffer: vk::Buffer,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let params = self.params;
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
            .array_layers(1)
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
            vk::ImageViewType::_2D,
            color_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let vertices = generate_vertices(colors);
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get(if api_1_2 { "vert_1_2" } else { "vert" })?)?;
        let tessellation_modules = if self.shader == Shader::Tessellation {
            let control = create_shader_module(device, binaries.get("tesc")?)?;
            let evaluation = create_shader_module(device, binaries.get(if api_1_2 { "tese_1_2" } else { "tese" })?)?;
            Some((control, evaluation))
        } else {
            None
        };
        let fragment_name = if self.shader.is_fragment() {
            format!("frag_{}", params.num_viewports)
        } else {
            "frag".to_string()
        };
        let fragment_module = create_shader_module(device, binaries.get(fragment_name.as_str())?)?;

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
                1,
            )?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        let descriptor_set_layout = if self.shader == Shader::FragmentWrite || self.shader == Shader::FragmentImplicit {
            Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
                    .build(device)?,
            )
        } else {
            None
        };
        let set_layouts: Vec<vk::DescriptorSetLayout> = descriptor_set_layout.iter().map(|layout| **layout).collect();
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

        // `makeGraphicsPipeline`
        let mut state = DrawPipelineState::new(if tessellation_modules.is_some() {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        });
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
        state.viewports = cells
            .iter()
            .map(|cell| vk::Viewport {
                x: cell[0] as f32,
                y: cell[1] as f32,
                width: cell[2] as f32,
                height: cell[3] as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            })
            .collect();
        state.scissors = cells.iter().map(|_| rect_2d(render_size.0, render_size.1)).collect();
        state.viewport_count = params.num_viewports;
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        if tessellation_modules.is_some() {
            state.patch_control_points = Some(3);
        }
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

        // The fragment tests read their colours from a uniform buffer bound by `drawCommands`.
        let colors_buffer = if descriptor_set_layout.is_some() {
            Some(create_host_buffer(
                context,
                colors,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
            )?)
        } else {
            None
        };
        let descriptor_pool = if descriptor_set_layout.is_some() {
            Some(
                DescriptorPoolBuilder::new()
                    .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                    .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
            )
        } else {
            None
        };
        let descriptor_set = match (&descriptor_pool, &descriptor_set_layout) {
            (Some(pool), Some(layout)) => Some(make_descriptor_set(device, **pool, **layout)?),
            _ => None,
        };
        if let (Some(set), Some(buffer)) = (&descriptor_set, &colors_buffer) {
            let colors_buffer_descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    **set,
                    Location::binding(0),
                    vk::DescriptorType::UNIFORM_BUFFER,
                    &colors_buffer_descriptor_info,
                )
                .update(device);
            flush_alloc(device, buffer.get_allocation())?;
        }

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
            layer_count: 1,
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
                        1,
                    );
                }
            },
            |cmd| {
                // `drawCommands`
                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    if let Some(set) = &descriptor_set {
                        device.cmd_bind_descriptor_sets(
                            cmd,
                            vk::PipelineBindPoint::GRAPHICS,
                            *pipeline_layout,
                            0,
                            &[**set],
                            &[],
                        );
                    }
                    device.cmd_draw(cmd, params.num_viewports * 6, 1, 0, 0); // two triangles per viewport
                }
                Ok(())
            },
            |cmd| {
                copy_image_to_buffer(
                    device,
                    cmd,
                    color_image.get(),
                    color_buffer,
                    render_size.0,
                    render_size.1,
                )
            },
        )?;

        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *cmd_buffer)
    }
}

impl TestInstance for ShaderViewportIndexInstance<'_> {
    /// `testVertexFragmentShader` / `testTessellationShader`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = self.params;

        let render_size = (128u32, 128u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let clear_color = [0.5f32, 0.5, 0.5, 1.0];
        let colors = generate_colors(params.num_viewports);
        let cells = generate_grid(params.num_viewports, render_size);

        let color_buffer_size = (render_size.0 * render_size.1 * 4) as vk::DeviceSize;
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

        // Draw
        self.render(
            render_size,
            color_format,
            clear_color,
            &cells,
            &colors,
            color_buffer.get(),
        )?;

        // Log image
        invalidate_alloc(device, color_buffer.get_allocation())?;
        let result_mem = unsafe {
            std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size as usize)
        };
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let result_image = ConstPixelBufferAccess::new(format, [render_size.0, render_size.1, 1], result_mem);
        let reference_image = generate_reference_image(format, render_size, clear_color, &cells, &colors)?;

        // Images should now match.
        if !float_threshold_compare(&reference_image.get_const_access(), &result_image, [0.02; 4]).ok {
            return Ok(TestStatus::fail("Rendered image is not correct"));
        }

        Ok(TestStatus::pass("OK"))
    }
}

/// `createShaderViewportIndexTests`
pub fn create_shader_viewport_index_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_viewport_index");

    let mut add = |name: String, num_viewports: u32, shader: Shader, use_tessellation_shader: bool| {
        let params = TestParams {
            num_viewports,
            group_params,
            use_tessellation_shader,
        };
        group.add_child(Box::new(ShaderViewportIndexCase { name, params, shader }) as Box<dyn TestCase>);
    };

    for num_viewports in 1..=MIN_MAX_VIEWPORTS {
        add(
            format!("vertex_shader_{num_viewports}"),
            num_viewports,
            Shader::Vertex,
            false,
        );
    }

    add(
        "fragment_shader_implicit".to_string(),
        1,
        Shader::FragmentImplicit,
        false,
    );
    for num_viewports in 1..=MIN_MAX_VIEWPORTS {
        add(
            format!("fragment_shader_{num_viewports}"),
            num_viewports,
            Shader::FragmentWrite,
            false,
        );
    }

    for num_viewports in 1..=MIN_MAX_VIEWPORTS {
        add(
            format!("tessellation_shader_{num_viewports}"),
            num_viewports,
            Shader::Tessellation,
            true,
        );
    }

    group
}
