// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsScissorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The same primitives are drawn with a full-size scissor and with the case's scissor; the first image,
// with the scissor applied by hand, must equal the second. The shaders are in
// `shaders/manifest/fragment_ops_scissor.toml`. Upstream's `de::Random(1234)` is replaced by a small
// xorshift generator: the reference image is rendered by the same run, so the exact positions do not matter.

use vulkanalia::prelude::v1_0::*;

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

/// The manifest declares its cases with this: the shader pair plus whether the vertex shader writes gl_PointSize.
pub struct ScissorProgram {
    pub name: &'static str,
    pub point_size: bool,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::fragment_ops_scissor::{SCISSOR_NO_POINT_SIZE, SCISSOR_POINT_SIZE};

/// `TestPrimitive`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestPrimitive {
    Points,
    Lines,
    Triangles,
    BigLine,
    BigTriangle,
}

/// `CaseDef`: `render_area` and `scissor_area` are (ox, oy, w, h) in [0, 1].
#[derive(Clone, Copy)]
struct CaseDef {
    render_area: [f32; 4],
    scissor_area: [f32; 4],
    primitive: TestPrimitive,
}

/// `VertexData`
#[repr(C)]
#[derive(Clone, Copy)]
struct VertexData {
    position: [f32; 4],
    color: [f32; 4],
}

const RENDER_SIZE: u32 = 128;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

struct XorShift(u64);

impl XorShift {
    fn get_float(&mut self, min: f32, max: f32) -> f32 {
        self.0 ^= self.0 << 13;
        self.0 ^= self.0 >> 7;
        self.0 ^= self.0 << 17;
        min + (max - min) * ((self.0 >> 40) as f32 / (1u64 << 24) as f32)
    }
}

fn make_vertex(x: f32, y: f32, color: [f32; 4]) -> VertexData {
    VertexData {
        position: [x, y, 0.0, 1.0],
        color,
    }
}

/// `genVertices`
fn gen_vertices(primitive: TestPrimitive, render_area: [f32; 4], primitive_color: [f32; 4]) -> Vec<VertexData> {
    let mut vertices = Vec::new();
    let mut rng = XorShift(0x9E37_79B9_7F4A_7C15 ^ 1234);

    let x0 = 2.0 * render_area[0] - 1.0;
    let y0 = 2.0 * render_area[1] - 1.0;
    let rx = 2.0 * render_area[2];
    let ry = 2.0 * render_area[3];
    let size = 0.2f32;

    match primitive {
        TestPrimitive::Points => {
            for _ in 0..50 {
                let x = x0 + rng.get_float(0.0, rx);
                let y = y0 + rng.get_float(0.0, ry);
                vertices.push(make_vertex(x, y, primitive_color));
            }
        }
        TestPrimitive::Lines => {
            for _ in 0..30 {
                let x = x0 + rng.get_float(0.0, rx - size);
                let y = y0 + rng.get_float(0.0, ry - size);
                vertices.push(make_vertex(x, y, primitive_color));
                vertices.push(make_vertex(x + size, y + size, primitive_color));
            }
        }
        TestPrimitive::Triangles => {
            for _ in 0..20 {
                let x = x0 + rng.get_float(0.0, rx - size);
                let y = y0 + rng.get_float(0.0, ry - size);
                vertices.push(make_vertex(x, y, primitive_color));
                vertices.push(make_vertex(x + size / 2.0, y + size, primitive_color));
                vertices.push(make_vertex(x + size, y, primitive_color));
            }
        }
        TestPrimitive::BigLine => {
            vertices.push(make_vertex(x0, y0, primitive_color));
            vertices.push(make_vertex(x0 + rx, y0 + ry, primitive_color));
        }
        TestPrimitive::BigTriangle => {
            vertices.push(make_vertex(x0, y0, primitive_color));
            vertices.push(make_vertex(x0 + rx / 2.0, y0 + ry, primitive_color));
            vertices.push(make_vertex(x0 + rx, y0, primitive_color));
        }
    }
    vertices
}

/// `getTopology`
fn get_topology(primitive: TestPrimitive) -> vk::PrimitiveTopology {
    match primitive {
        TestPrimitive::Points => vk::PrimitiveTopology::POINT_LIST,
        TestPrimitive::Lines | TestPrimitive::BigLine => vk::PrimitiveTopology::LINE_LIST,
        TestPrimitive::Triangles | TestPrimitive::BigTriangle => vk::PrimitiveTopology::TRIANGLE_LIST,
    }
}

/// `getAreaRect`: normalised coordinates to framebuffer space.
fn get_area_rect(area: [f32; 4], width: u32, height: u32) -> [i32; 4] {
    [
        (width as f32 * area[0]) as i32,
        (height as f32 * area[1]) as i32,
        (width as f32 * area[2]) as i32,
        (height as f32 * area[3]) as i32,
    ]
}

/// `applyScissor`: fragments outside the scissor fail the test and keep the clear colour.
fn apply_scissor(image: &mut [u8], scissor_area: [f32; 4], clear_color: [u8; 4]) {
    let rect = get_area_rect(scissor_area, RENDER_SIZE, RENDER_SIZE);
    let (sx0, sx1, sy0, sy1) = (rect[0], rect[0] + rect[2], rect[1], rect[1] + rect[3]);

    for y in 0..RENDER_SIZE as i32 {
        for x in 0..RENDER_SIZE as i32 {
            if x < sx0 || x >= sx1 || y < sy0 || y >= sy1 {
                let offset = ((y as u32 * RENDER_SIZE + x as u32) * 4) as usize;
                image[offset..offset + 4].copy_from_slice(&clear_color);
            }
        }
    }
}

struct ScissorCase {
    name: &'static str,
    case_def: CaseDef,
}

impl ScissorCase {
    fn program(&self) -> &'static ScissorProgram {
        if self.case_def.primitive == TestPrimitive::Points {
            &SCISSOR_POINT_SIZE
        } else {
            &SCISSOR_NO_POINT_SIZE
        }
    }
}

impl TestCase for ScissorCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ScissorInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct ScissorInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDef,
}

/// `ScissorRenderer`
struct ScissorRenderer<'a> {
    context: &'a Context<'a>,
    topology: vk::PrimitiveTopology,
    vertex_count: u32,
    clear_color: [f32; 4],
    // Declared so that fields drop in dependency order: users of an object before the object.
    cmd_buffer: crate::vk::ref_util::UniqueCommandBuffer<'a>,
    _cmd_pool: Unique<'a, vk::CommandPool>,
    _pipeline_layout: Unique<'a, vk::PipelineLayout>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    vertex_module: Unique<'a, vk::ShaderModule>,
    fragment_module: Unique<'a, vk::ShaderModule>,
    vertex_buffer: BufferWithMemory<'a>,
    _color_view: Unique<'a, vk::ImageView>,
    color_image: ImageWithMemory<'a>,
}

impl<'a> ScissorRenderer<'a> {
    fn new(
        context: &'a Context<'a>,
        case_def: CaseDef,
        primitive_color: [f32; 4],
        clear_color: [f32; 4],
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let vertices = gen_vertices(case_def.primitive, case_def.render_area, primitive_color);

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
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
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let vertex_buffer_size = (vertices.len() * std::mem::size_of::<VertexData>()) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let binaries = context.get_binary_collection();
        let program_names = ("vert", "frag");
        let vertex_module = create_shader_module(device, binaries.get(program_names.0)?)?;
        let fragment_module = create_shader_module(device, binaries.get(program_names.1)?)?;
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        Ok(Self {
            context,
            topology: get_topology(case_def.primitive),
            vertex_count: vertices.len() as u32,
            clear_color,
            cmd_buffer,
            _cmd_pool: cmd_pool,
            _pipeline_layout: pipeline_layout,
            framebuffer,
            render_pass,
            vertex_module,
            fragment_module,
            vertex_buffer,
            _color_view: color_view,
            color_image,
        })
    }

    /// `draw`: a new pipeline each time, because the scissor changes (no dynamic state).
    fn draw(&self, scissor_area_float: [f32; 4], color_buffer: vk::Buffer) -> Result<(), TestError> {
        let device = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let scissor_area = get_area_rect(scissor_area_float, RENDER_SIZE, RENDER_SIZE);

        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<VertexData>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [
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
                offset: std::mem::size_of::<[f32; 4]>() as u32,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*self.vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*self.fragment_module)
                .name(b"main\0")
                .build(),
        ];
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(self.topology)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: RENDER_SIZE as f32,
            height: RENDER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D {
                x: scissor_area[0],
                y: scissor_area[1],
            },
            extent: vk::Extent2D {
                width: scissor_area[2] as u32,
                height: scissor_area[3] as u32,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*self._pipeline_layout)
            .render_pass(*self.render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd = *self.cmd_buffer;
        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *self.render_pass,
            *self.framebuffer,
            vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            },
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: self.clear_color,
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[self.vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, self.vertex_count, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        copy_image_to_buffer(
            device,
            cmd,
            self.color_image.get(),
            color_buffer,
            RENDER_SIZE,
            RENDER_SIZE,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)
    }
}

impl TestInstance for ScissorInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let case_def = self.case_def;

        let scissor_full_area = [0.0f32, 0.0, 1.0, 1.0];
        let primitive_color = [1.0f32; 4];
        let clear_color = [0.5f32, 0.5, 1.0, 1.0];

        let color_buffer_size = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let make_buffer = || {
            BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let color_buffer_full = make_buffer()?;
        let color_buffer_scissored = make_buffer()?;

        // zeroBuffer
        for buffer in [&color_buffer_full, &color_buffer_scissored] {
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, color_buffer_size as usize) };
            flush_alloc(device, buffer.get_allocation())?;
        }

        // Draw
        {
            let renderer = ScissorRenderer::new(context, case_def, primitive_color, clear_color)?;
            renderer.draw(scissor_full_area, color_buffer_full.get())?;
            renderer.draw(case_def.scissor_area, color_buffer_scissored.get())?;
        }

        invalidate_alloc(device, color_buffer_full.get_allocation())?;
        invalidate_alloc(device, color_buffer_scissored.get_allocation())?;

        let result_image = unsafe {
            std::slice::from_raw_parts(
                color_buffer_scissored.get_allocation().get_host_ptr(),
                color_buffer_size as usize,
            )
        };
        let mut reference_image = unsafe {
            std::slice::from_raw_parts(
                color_buffer_full.get_allocation().get_host_ptr(),
                color_buffer_size as usize,
            )
        }
        .to_vec();

        // Apply scissor to the full image, so we can compare it with the result image.
        let clear_bytes: [u8; 4] = clear_color.map(|channel| (channel * 255.0 + 0.5) as u8);
        apply_scissor(&mut reference_image, case_def.scissor_area, clear_bytes);

        // Images should now match, within 0.02 of a channel.
        let threshold = 0.02f32 * 255.0;
        let matches = reference_image
            .iter()
            .zip(result_image)
            .all(|(&reference, &result)| (f32::from(reference) - f32::from(result)).abs() <= threshold);
        if !matches {
            return Ok(TestStatus::fail("Rendered image is not correct"));
        }

        Ok(TestStatus::pass("OK"))
    }
}

/// `createTestsInGroup` of the `scissor` group, less the multi-viewport subgroup upstream adds last.
pub fn create_scissor_tests() -> TestCaseGroup {
    let mut scissor_group = TestCaseGroup::new("scissor");

    let area_full = [0.0f32, 0.0, 1.0, 1.0];
    let area_cropped = [0.2f32, 0.2, 0.6, 0.6];
    let area_cropped_more = [0.4f32, 0.4, 0.2, 0.2];
    let area_left_half = [0.0f32, 0.0, 0.5, 1.0];
    let area_right_half = [0.5f32, 0.0, 0.5, 1.0];

    let groups: [(&str, Vec<(&'static str, CaseDef)>); 3] = [
        (
            "points",
            vec![
                (
                    "inside",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_full,
                        primitive: TestPrimitive::Points,
                    },
                ),
                (
                    "partially_inside",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_cropped,
                        primitive: TestPrimitive::Points,
                    },
                ),
                (
                    "outside",
                    CaseDef {
                        render_area: area_left_half,
                        scissor_area: area_right_half,
                        primitive: TestPrimitive::Points,
                    },
                ),
            ],
        ),
        (
            "lines",
            vec![
                (
                    "inside",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_full,
                        primitive: TestPrimitive::Lines,
                    },
                ),
                (
                    "partially_inside",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_cropped,
                        primitive: TestPrimitive::Lines,
                    },
                ),
                (
                    "outside",
                    CaseDef {
                        render_area: area_left_half,
                        scissor_area: area_right_half,
                        primitive: TestPrimitive::Lines,
                    },
                ),
                (
                    "crossing",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_cropped_more,
                        primitive: TestPrimitive::BigLine,
                    },
                ),
            ],
        ),
        (
            "triangles",
            vec![
                (
                    "inside",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_full,
                        primitive: TestPrimitive::Triangles,
                    },
                ),
                (
                    "partially_inside",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_cropped,
                        primitive: TestPrimitive::Triangles,
                    },
                ),
                (
                    "outside",
                    CaseDef {
                        render_area: area_left_half,
                        scissor_area: area_right_half,
                        primitive: TestPrimitive::Triangles,
                    },
                ),
                (
                    "crossing",
                    CaseDef {
                        render_area: area_full,
                        scissor_area: area_cropped_more,
                        primitive: TestPrimitive::BigTriangle,
                    },
                ),
            ],
        ),
    ];

    for (group_name, cases) in groups {
        let mut primitive_group = TestCaseGroup::new(group_name);
        for (name, case_def) in cases {
            primitive_group.add_child(Box::new(ScissorCase { name, case_def }) as Box<dyn TestCase>);
        }
        scissor_group.add_child(primitive_group);
    }

    // Multi-viewport scissor
    scissor_group.add_child(super::scissor_multi_viewport_tests::create_scissor_multi_viewport_tests());

    scissor_group
}
