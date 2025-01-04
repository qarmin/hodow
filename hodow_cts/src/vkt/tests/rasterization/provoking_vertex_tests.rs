// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationProvokingVertexTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Primitives are flat shaded and the image is cleared to red, so the colour of every drawn vertex that is not the
// provoking one must never show: the result has to stay solid red. The transform feedback cases also check that the
// captured stream keeps the position of the provoking vertex. The shaders are in
// `shaders/manifest/rasterization_provoking_vertex.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::rasterization_provoking_vertex::{PROVOKING_VERTEX_DRAW, PROVOKING_VERTEX_XFB};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: just the shader pair.
pub struct ProvokingVertexProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ProvokingVertexMode {
    Default,
    First,
    Last,
    PerPipeline,
}

#[derive(Clone, Copy)]
struct Params {
    format: vk::Format,
    size: (u32, u32),
    primitive_topology: vk::PrimitiveTopology,
    require_geometry_shader: bool,
    transform_feedback: bool,
    provoking_vertex_mode: ProvokingVertexMode,
}

const VEC4_SIZE: usize = std::mem::size_of::<[f32; 4]>();

/// `getXfbBufferSize`
fn get_xfb_buffer_size(vertex_count: u32, topology: vk::PrimitiveTopology) -> vk::DeviceSize {
    let vertex_count = vertex_count as usize;
    let vec4s = match topology {
        vk::PrimitiveTopology::LINE_LIST | vk::PrimitiveTopology::TRIANGLE_LIST => vertex_count,
        vk::PrimitiveTopology::LINE_STRIP => (vertex_count - 1) * 2,
        vk::PrimitiveTopology::TRIANGLE_STRIP | vk::PrimitiveTopology::TRIANGLE_FAN => (vertex_count - 2) * 3,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
            vertex_count / 2
        }
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => (vertex_count - 3) * 2,
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => (vertex_count / 2 - 2) * 3,
        _ => unreachable!("Unknown primitive topology"),
    };
    (vec4s * VEC4_SIZE) as vk::DeviceSize
}

/// `verifyXfbBuffer`
fn verify_xfb_buffer(
    xfb_results: &[[f32; 4]],
    vertices: &[[f32; 4]],
    provoking: &[usize],
    count: u32,
    topology: vk::PrimitiveTopology,
    mode: ProvokingVertexMode,
) -> Result<(), String> {
    let primitive_size: u32 = if matches!(
        topology,
        vk::PrimitiveTopology::LINE_LIST
            | vk::PrimitiveTopology::LINE_STRIP
            | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
            | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
    ) {
        2
    } else {
        3
    };

    let start = if mode == ProvokingVertexMode::Last {
        primitive_size - 1
    } else {
        0
    };
    let prov_start = if mode == ProvokingVertexMode::Last {
        if matches!(
            topology,
            vk::PrimitiveTopology::LINE_LIST
                | vk::PrimitiveTopology::TRIANGLE_LIST
                | vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
        ) {
            2
        } else {
            3
        }
    } else {
        0
    };

    debug_assert!(count.is_multiple_of(primitive_size));

    let mut i = 0usize;
    let mut ndx = start;
    while ndx < count {
        let expected = vertices[provoking[i + prov_start]];
        let got = xfb_results[ndx as usize];
        if got != expected {
            return Err(format!("Vertex {ndx}: Expected {expected:?}, got {got:?}"));
        }
        i += 1;
        ndx += primitive_size;
    }
    Ok(())
}

const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
const BLUE: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
const YELLOW: [f32; 4] = [1.0, 1.0, 0.0, 1.0];
const WHITE: [f32; 4] = [1.0, 1.0, 1.0, 1.0];

/// Vertex data as the vertex buffer holds it: a position followed by a colour. `provoking` holds the index of the
/// position of every vertex whose colour has to win.
#[derive(Default)]
struct VertexData {
    vertices: Vec<[f32; 4]>,
    provoking: Vec<usize>,
}

impl VertexData {
    fn add(&mut self, x: f32, y: f32, color: [f32; 4], is_provoking: bool) {
        self.vertices.push([x, y, 0.0, 1.0]);
        self.vertices.push(color);
        if is_provoking {
            self.provoking.push(self.vertices.len() - 2);
        }
    }

    /// A vertex that only supplies adjacency information, which upstream writes as `(0, 0)` in white.
    fn add_adjacent(&mut self) {
        self.add(0.0, 0.0, WHITE, false);
    }
}

/// The vertex list of one topology: the first half is drawn for PROVOKING_VERTEX_FIRST, the reversed second half
/// for PROVOKING_VERTEX_LAST.
fn make_vertex_data(topology: vk::PrimitiveTopology) -> VertexData {
    let mut d = VertexData::default();
    match topology {
        vk::PrimitiveTopology::LINE_LIST => {
            d.add(-1.0, -0.5, RED, true); // line 0
            d.add(1.0, -0.5, BLUE, false);
            d.add(-1.0, 0.5, RED, true); // line 1
            d.add(1.0, 0.5, BLUE, false);

            d.add(-0.5, -1.0, BLUE, false); // line 1 reverse
            d.add(-0.5, 1.0, RED, true);
            d.add(0.5, -1.0, BLUE, false); // line 0 reverse
            d.add(0.5, 1.0, RED, true);
        }
        vk::PrimitiveTopology::LINE_STRIP => {
            d.add(-1.0, -0.5, RED, true); // line strip
            d.add(1.0, -0.5, RED, true);
            d.add(-1.0, 0.5, RED, true);
            d.add(1.0, 0.5, GREEN, false);

            d.add(-0.5, -1.0, GREEN, false); // line strip reverse
            d.add(-0.5, 1.0, RED, true);
            d.add(0.5, -1.0, RED, true);
            d.add(0.5, 1.0, RED, true);
        }
        vk::PrimitiveTopology::TRIANGLE_LIST => {
            d.add(1.0, 1.0, RED, true); // triangle 0
            d.add(-0.6, -1.0, GREEN, false);
            d.add(-0.2, 1.0, BLUE, false);
            d.add(0.2, 1.0, RED, true); // triangle 1
            d.add(0.6, -1.0, GREEN, false);
            d.add(1.0, 1.0, BLUE, false);

            d.add(-1.0, -1.0, BLUE, false); // triangle 1 reverse
            d.add(-0.6, 1.0, GREEN, false);
            d.add(-0.2, -1.0, RED, true);
            d.add(0.2, -1.0, BLUE, false); // triangle 0 reverse
            d.add(0.6, 1.0, GREEN, false);
            d.add(-1.0, -1.0, RED, true);
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP => {
            d.add(-1.0, 1.0, RED, true); // triangle strip
            d.add(-0.5, -1.0, RED, true);
            d.add(0.0, 1.0, RED, true);
            d.add(0.5, -1.0, GREEN, false);
            d.add(1.0, 1.0, BLUE, false);

            d.add(-1.0, -1.0, BLUE, false); // triangle strip reverse
            d.add(-0.5, 1.0, GREEN, false);
            d.add(0.0, -1.0, RED, true);
            d.add(0.5, 1.0, RED, true);
            d.add(1.0, -1.0, RED, true);
        }
        vk::PrimitiveTopology::TRIANGLE_FAN => {
            d.add(0.0, 1.0, GREEN, false); // triangle fan
            d.add(-1.0, 1.0, RED, true);
            d.add(-0.5, -1.0, RED, true);
            d.add(0.5, -1.0, RED, true);
            d.add(1.0, 1.0, BLUE, false);

            d.add(0.0, -1.0, GREEN, false); // triangle fan reverse
            d.add(-1.0, -1.0, BLUE, false);
            d.add(-0.5, 1.0, RED, true);
            d.add(0.5, 1.0, RED, true);
            d.add(1.0, -1.0, RED, true);
        }
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
            d.add(-1.0, -0.5, GREEN, false); // line 0
            d.add(-0.5, -0.5, RED, true);
            d.add(0.5, -0.5, BLUE, false);
            d.add(1.0, -0.5, YELLOW, false);
            d.add(-1.0, 0.5, GREEN, false); // line 1
            d.add(-0.5, 0.5, RED, true);
            d.add(0.5, 0.5, BLUE, false);
            d.add(1.0, 0.5, YELLOW, false);

            d.add(-0.5, -1.0, YELLOW, false); // line 1 reverse
            d.add(-0.5, -0.5, BLUE, false);
            d.add(-0.5, 0.5, RED, true);
            d.add(-0.5, 1.0, GREEN, false);
            d.add(0.5, -1.0, YELLOW, false); // line 0 reverse
            d.add(0.5, -0.5, BLUE, false);
            d.add(0.5, 0.5, RED, true);
            d.add(0.5, 1.0, GREEN, false);
        }
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
            d.add(-1.0, -0.5, GREEN, false); // line strip
            d.add(-0.5, -0.5, RED, true);
            d.add(0.5, -0.5, RED, true);
            d.add(-0.5, 0.5, RED, true);
            d.add(0.5, 0.5, BLUE, false);
            d.add(1.0, 0.5, YELLOW, false);

            d.add(-0.5, -1.0, YELLOW, false); // line strip reverse
            d.add(-0.5, -0.5, BLUE, false);
            d.add(-0.5, 0.5, RED, true);
            d.add(0.5, -0.5, RED, true);
            d.add(0.5, 0.5, RED, true);
            d.add(0.5, 1.0, GREEN, false);
        }
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
            d.add(-1.0, 1.0, RED, true); // triangle 0
            d.add_adjacent();
            d.add(-0.6, -1.0, GREEN, false);
            d.add_adjacent();
            d.add(-0.2, 1.0, BLUE, false);
            d.add_adjacent();
            d.add(0.2, 1.0, RED, true); // triangle 1
            d.add_adjacent();
            d.add(0.6, -1.0, GREEN, false);
            d.add_adjacent();
            d.add(1.0, 1.0, BLUE, false);
            d.add_adjacent();

            d.add(-1.0, -1.0, BLUE, false); // triangle 1 reverse
            d.add_adjacent();
            d.add(-0.6, 1.0, GREEN, false);
            d.add_adjacent();
            d.add(-0.2, -1.0, RED, true);
            d.add_adjacent();
            d.add(0.2, -1.0, BLUE, false); // triangle 0 reverse
            d.add_adjacent();
            d.add(0.6, 1.0, GREEN, false);
            d.add_adjacent();
            d.add(1.0, -1.0, RED, true);
            d.add_adjacent();
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
            d.add(-1.0, 1.0, RED, true); // triangle strip
            d.add_adjacent();
            d.add(-0.5, -1.0, RED, true);
            d.add_adjacent();
            d.add(0.0, 1.0, RED, true);
            d.add_adjacent();
            d.add(0.5, -1.0, GREEN, false);
            d.add_adjacent();
            d.add(1.0, 1.0, BLUE, false);
            d.add_adjacent();

            d.add(-1.0, -1.0, BLUE, false); // triangle strip reverse
            d.add_adjacent();
            d.add(-0.5, 1.0, GREEN, false);
            d.add_adjacent();
            d.add(0.0, -1.0, RED, true);
            d.add_adjacent();
            d.add(0.5, 1.0, RED, true);
            d.add_adjacent();
            d.add(1.0, -1.0, RED, true);
            d.add_adjacent();
        }
        _ => unreachable!("Unknown primitive topology"),
    }
    d
}

struct ProvokingVertexTestCase {
    name: &'static str,
    params: Params,
}

impl TestCase for ProvokingVertexTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `ProvokingVertexTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if params.require_geometry_shader && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature geometryShader not supported".to_string(),
            ));
        }

        if params.transform_feedback {
            context.require_device_functionality("VK_EXT_transform_feedback")?;
        }

        if params.provoking_vertex_mode != ProvokingVertexMode::Default {
            context.require_device_functionality("VK_EXT_provoking_vertex")?;

            let mut features = vk::PhysicalDeviceProvokingVertexFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            let mut properties = vk::PhysicalDeviceProvokingVertexPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };

            if params.transform_feedback && features.transform_feedback_preserves_provoking_vertex != vk::TRUE {
                return Err(TestError::NotSupported(
                    "transformFeedbackPreservesProvokingVertex not supported".to_string(),
                ));
            }

            if params.transform_feedback
                && params.primitive_topology == vk::PrimitiveTopology::TRIANGLE_FAN
                && properties.transform_feedback_preserves_triangle_fan_provoking_vertex != vk::TRUE
            {
                return Err(TestError::NotSupported(
                    "transformFeedbackPreservesTriangleFanProvokingVertex not supported".to_string(),
                ));
            }

            if params.provoking_vertex_mode != ProvokingVertexMode::First {
                if features.provoking_vertex_last != vk::TRUE {
                    return Err(TestError::NotSupported(
                        "VK_PROVOKING_VERTEX_MODE_LAST_VERTEX_EXT not supported".to_string(),
                    ));
                }

                if params.provoking_vertex_mode == ProvokingVertexMode::PerPipeline
                    && properties.provoking_vertex_mode_per_pipeline != vk::TRUE
                {
                    return Err(TestError::NotSupported(
                        "provokingVertexModePerPipeline not supported".to_string(),
                    ));
                }
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.transform_feedback {
            PROVOKING_VERTEX_XFB.programs
        } else {
            PROVOKING_VERTEX_DRAW.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ProvokingVertexTestInstance {
            context,
            params: self.params,
        })
    }
}

struct ProvokingVertexTestInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl ProvokingVertexTestInstance<'_> {
    /// `ProvokingVertexTestInstance::makeRenderPass` - copied from vkObjUtil.cpp upstream with a self dependency.
    fn make_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();

        let color_attachment_description = [vk::AttachmentDescription::builder()
            .format(self.params.format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_attachment_ref = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let subpass_description = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_ref)
            .build()];
        let self_dependency = [vk::SubpassDependency::builder()
            .src_subpass(0)
            .dst_subpass(0)
            .src_stage_mask(vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT)
            .dst_stage_mask(vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT)
            .src_access_mask(vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT)
            .dst_access_mask(vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT)
            .dependency_flags(vk::DependencyFlags::empty())
            .build()];

        let xfb_per_pipeline =
            self.params.transform_feedback && self.params.provoking_vertex_mode == ProvokingVertexMode::PerPipeline;

        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&color_attachment_description)
            .subpasses(&subpass_description);
        let render_pass_info = if xfb_per_pipeline {
            render_pass_info.dependencies(&self_dependency)
        } else {
            render_pass_info
        };
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, render_pass))
    }
}

impl TestInstance for ProvokingVertexTestInstance<'_> {
    /// `ProvokingVertexTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let use_provoking_vertex_ext = params.provoking_vertex_mode != ProvokingVertexMode::Default;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();
        let counter_buffer_offset: vk::DeviceSize = 0;
        let (width, height) = params.size;

        // Image and image view.
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(params.format)
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
        let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let image_view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            params.format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // Result buffer.
        let result_buffer_size = (width * height * 4) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Render pass, framebuffer and pipelines.
        let binaries = context.get_binary_collection();
        let vertex_shader = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: (VEC4_SIZE * 2) as u32,
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
                offset: VEC4_SIZE as u32,
            },
        ];
        let render_pass = self.make_render_pass()?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*image_view], width, height, 1)?;

        let create_pipeline =
            |provoking_vertex_mode: Option<vk::ProvokingVertexModeEXT>| -> Result<Unique<'_, vk::Pipeline>, TestError> {
                let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
                    .vertex_binding_descriptions(&vertex_bindings)
                    .vertex_attribute_descriptions(&vertex_attributes);
                let mut provoking_vertex_create_info = vk::PipelineRasterizationProvokingVertexStateCreateInfoEXT {
                    provoking_vertex_mode: provoking_vertex_mode.unwrap_or(vk::ProvokingVertexModeEXT::FIRST_VERTEX),
                    ..Default::default()
                };
                let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
                    .depth_clamp_enable(false)
                    .rasterizer_discard_enable(false)
                    .polygon_mode(vk::PolygonMode::FILL)
                    .cull_mode(vk::CullModeFlags::NONE)
                    .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                    .depth_bias_enable(false)
                    .line_width(1.0);
                let rasterization_state = if provoking_vertex_mode.is_some() {
                    rasterization_state.push_next(&mut provoking_vertex_create_info)
                } else {
                    rasterization_state
                };
                let stages = [
                    vk::PipelineShaderStageCreateInfo::builder()
                        .stage(vk::ShaderStageFlags::VERTEX)
                        .module(*vertex_shader)
                        .name(b"main\0")
                        .build(),
                    vk::PipelineShaderStageCreateInfo::builder()
                        .stage(vk::ShaderStageFlags::FRAGMENT)
                        .module(*fragment_shader)
                        .name(b"main\0")
                        .build(),
                ];
                let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                    .topology(params.primitive_topology)
                    .primitive_restart_enable(false);
                let viewports = [vk::Viewport {
                    x: 0.0,
                    y: 0.0,
                    width: width as f32,
                    height: height as f32,
                    min_depth: 0.0,
                    max_depth: 1.0,
                }];
                let scissors = [vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D { width, height },
                }];
                let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                    .viewports(&viewports)
                    .scissors(&scissors);
                let multisample_state =
                    vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
                let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
                    .blend_enable(false)
                    .color_write_mask(vk::ColorComponentFlags::all())
                    .build()];
                let color_blend_state =
                    vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
                let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
                    .stages(&stages)
                    .vertex_input_state(&vertex_input_state)
                    .input_assembly_state(&input_assembly_state)
                    .viewport_state(&viewport_state)
                    .rasterization_state(&rasterization_state)
                    .multisample_state(&multisample_state)
                    .color_blend_state(&color_blend_state)
                    .layout(*pipeline_layout)
                    .render_pass(*render_pass)
                    .subpass(0)
                    .base_pipeline_index(0);
                let pipelines =
                    unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                        .vk_check("vkCreateGraphicsPipelines")?;
                Ok(Unique::new(device, pipelines.0[0]))
            };

        let provoking_vertex_mode = if params.provoking_vertex_mode == ProvokingVertexMode::Last {
            vk::ProvokingVertexModeEXT::LAST_VERTEX
        } else {
            vk::ProvokingVertexModeEXT::FIRST_VERTEX
        };
        let pipeline = create_pipeline(use_provoking_vertex_ext.then_some(provoking_vertex_mode))?;
        let alt_pipeline = if params.provoking_vertex_mode == ProvokingVertexMode::PerPipeline {
            Some(create_pipeline(Some(vk::ProvokingVertexModeEXT::LAST_VERTEX))?)
        } else {
            None
        };

        // Vertex buffer.
        let vertex_data = make_vertex_data(params.primitive_topology);
        let vertices = &vertex_data.vertices;
        let provoking = &vertex_data.provoking;
        let vertex_buffer_size = (vertices.len() * VEC4_SIZE) as vk::DeviceSize;
        let vertex_count = (vertices.len() / 4) as u32;
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

        // Transform feedback and counter buffers.
        let mut xfb_buffer_size: vk::DeviceSize = 0;
        let mut xfb_buffers = None;
        if params.transform_feedback {
            xfb_buffer_size = get_xfb_buffer_size(vertex_count, params.primitive_topology);

            if params.provoking_vertex_mode == ProvokingVertexMode::PerPipeline {
                xfb_buffer_size *= 2;
            }

            let counter_buffer_size = (16 * std::mem::size_of::<u32>()) as vk::DeviceSize;
            let xfb_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    xfb_buffer_size,
                    vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let counter_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    counter_buffer_size,
                    vk::BufferUsageFlags::TRANSFORM_FEEDBACK_COUNTER_BUFFER_EXT,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            // Make sure uninitialized values are not read when starting XFB for the first time.
            unsafe {
                std::ptr::write_bytes(
                    counter_buffer.get_allocation().get_host_ptr(),
                    0,
                    counter_buffer_size as usize,
                )
            };
            flush_alloc(device, counter_buffer.get_allocation())?;
            xfb_buffers = Some((xfb_buffer, counter_buffer));
        }

        // Clear the color buffer to red and check the drawing doesn't add any other colors from non-provoking vertices.
        {
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D { width, height },
            };
            let clear_values = [vk::ClearValue {
                color: vk::ClearColorValue { float32: RED },
            }];

            let image_barrier = crate::vk::image_util::make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            let xfb_memory_barrier = make_memory_barrier(
                vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
                vk::AccessFlags::HOST_READ,
            );
            let counter_barrier = make_memory_barrier(
                vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT,
                vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT,
            );

            // The first half of the vertex buffer is for PROVOKING_VERTEX_FIRST, the second half for PROVOKING_VERTEX_LAST.
            let first_vertex = if params.provoking_vertex_mode == ProvokingVertexMode::Last {
                vertex_count
            } else {
                0
            };

            let command_pool = make_command_pool(device, queue_family_index)?;
            let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *command_buffer;

            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );

                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(render_area)
                    .clear_values(&clear_values);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                if let Some((xfb_buffer, counter_buffer)) = &xfb_buffers {
                    device.cmd_bind_transform_feedback_buffers_ext(
                        cmd,
                        0,
                        &[xfb_buffer.get()],
                        &[0],
                        &[xfb_buffer_size],
                    );
                    device.cmd_begin_transform_feedback_ext(cmd, 0, &[counter_buffer.get()], &[counter_buffer_offset]);
                }

                device.cmd_draw(cmd, vertex_count, 1, first_vertex, 0);

                if let Some(alt_pipeline) = &alt_pipeline {
                    // vkCmdBindPipeline must not be recorded when transform feedback is active.
                    if let Some((_, counter_buffer)) = &xfb_buffers {
                        device.cmd_end_transform_feedback_ext(
                            cmd,
                            0,
                            &[counter_buffer.get()],
                            &[counter_buffer_offset],
                        );
                        device.cmd_pipeline_barrier(
                            cmd,
                            vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                            vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                            vk::DependencyFlags::empty(),
                            &[counter_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                    }

                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **alt_pipeline);

                    if let Some((_, counter_buffer)) = &xfb_buffers {
                        device.cmd_begin_transform_feedback_ext(
                            cmd,
                            0,
                            &[counter_buffer.get()],
                            &[counter_buffer_offset],
                        );
                    }

                    device.cmd_draw(cmd, vertex_count, 1, vertex_count, 0);
                }

                if let Some((_, counter_buffer)) = &xfb_buffers {
                    device.cmd_end_transform_feedback_ext(cmd, 0, &[counter_buffer.get()], &[counter_buffer_offset]);
                }
                device.cmd_end_render_pass(cmd);

                if xfb_buffers.is_some() {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[xfb_memory_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }
            copy_image_to_buffer(device, cmd, image.get(), result_buffer.get(), width, height);
            end_command_buffer(device, cmd)?;

            submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
            invalidate_alloc(device, result_buffer.get_allocation())?;

            if let Some((xfb_buffer, _)) = &xfb_buffers {
                invalidate_alloc(device, xfb_buffer.get_allocation())?;
            }
        }

        // Verify result.
        // Verify transform feedback buffer.
        if let Some((xfb_buffer, _)) = &xfb_buffers {
            let count = (xfb_buffer_size as usize / VEC4_SIZE) as u32;
            let xfb_results = unsafe {
                std::slice::from_raw_parts(
                    xfb_buffer.get_allocation().get_host_ptr() as *const [f32; 4],
                    count as usize,
                )
            };

            for (i, result) in xfb_results.iter().enumerate() {
                log::debug!("[{i}]\t{result:?}");
            }

            if params.provoking_vertex_mode != ProvokingVertexMode::PerPipeline {
                if let Err(error_message) = verify_xfb_buffer(
                    xfb_results,
                    vertices,
                    provoking,
                    count,
                    params.primitive_topology,
                    params.provoking_vertex_mode,
                ) {
                    return Ok(TestStatus::fail(error_message));
                }
            } else {
                let half_count = count / 2;

                if let Err(error_message) = verify_xfb_buffer(
                    xfb_results,
                    vertices,
                    provoking,
                    half_count,
                    params.primitive_topology,
                    ProvokingVertexMode::First,
                ) {
                    return Ok(TestStatus::fail(error_message));
                }

                if let Err(error_message) = verify_xfb_buffer(
                    &xfb_results[half_count as usize..],
                    vertices,
                    provoking,
                    half_count,
                    params.primitive_topology,
                    ProvokingVertexMode::Last,
                ) {
                    return Ok(TestStatus::fail(error_message));
                }
            }
        }

        // Compare against the solid red reference.
        let result = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr(),
                result_buffer_size as usize,
            )
        };
        if !result.chunks_exact(4).all(|texel| texel == [255, 0, 0, 255]) {
            return Ok(TestStatus::fail("Incorrect rendering"));
        }

        Ok(TestStatus::pass("Solid red"))
    }
}

/// `createTests` - the `provoking_vertex` group.
pub fn create_provoking_vertex_tests() -> TestCaseGroup {
    let provoking_vertex_modes = [
        ("default", ProvokingVertexMode::Default),
        ("first", ProvokingVertexMode::First),
        ("last", ProvokingVertexMode::Last),
        // Pipelines with different provokingVertexModes
        ("per_pipeline", ProvokingVertexMode::PerPipeline),
    ];

    let topologies = [
        ("line_list", vk::PrimitiveTopology::LINE_LIST, false),
        ("line_strip", vk::PrimitiveTopology::LINE_STRIP, false),
        ("triangle_list", vk::PrimitiveTopology::TRIANGLE_LIST, false),
        ("triangle_strip", vk::PrimitiveTopology::TRIANGLE_STRIP, false),
        ("triangle_fan", vk::PrimitiveTopology::TRIANGLE_FAN, false),
        (
            "line_list_with_adjacency",
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
            true,
        ),
        (
            "line_strip_with_adjacency",
            vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
            true,
        ),
        (
            "triangle_list_with_adjacency",
            vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
            true,
        ),
        (
            "triangle_strip_with_adjacency",
            vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
            true,
        ),
    ];

    // Test that primitives are flat shaded with the provoking vertex color, and that transform feedback preserves
    // the position of the provoking vertex.
    let test_types = [("draw", false), ("transform_feedback", true)];

    let mut group = TestCaseGroup::new("provoking_vertex");

    for (type_name, transform_feedback) in test_types {
        let mut type_group = TestCaseGroup::new(type_name);

        for (provoking_name, mode) in provoking_vertex_modes {
            // Only test transformFeedbackPreservesProvokingVertex with VK_EXT_provoking_vertex
            if transform_feedback && mode == ProvokingVertexMode::Default {
                continue;
            }

            let mut provoking_group = TestCaseGroup::new(provoking_name);

            for (name, primitive_topology, require_geometry_shader) in topologies {
                let params = Params {
                    format: vk::Format::R8G8B8A8_UNORM,
                    size: (32, 32),
                    primitive_topology,
                    require_geometry_shader,
                    transform_feedback,
                    provoking_vertex_mode: mode,
                };
                provoking_group.add_child(Box::new(ProvokingVertexTestCase { name, params }) as Box<dyn TestCase>);
            }

            type_group.add_child(provoking_group);
        }

        group.add_child(type_group);
    }

    group
}
