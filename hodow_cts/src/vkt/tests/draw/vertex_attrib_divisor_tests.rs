// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawVertexAttribDivisorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `shader_objects` pipeline type creates two VkShaderEXT objects and binds them with the
// default shader object dynamic states of the shader_object utilities; `TestVertShader`, `TestFragShader` and `VertexPositionAndColor` are the ones of the instanced tests,
// which define the same shaders for the reference renderer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtMultiDrawExtensionDeviceCommands, ExtTransformFeedbackExtensionDeviceCommands,
    ExtVertexInputDynamicStateExtensionDeviceCommands, Handle, InstanceV1_1,
    KhrDrawIndirectCountExtensionDeviceCommands,
};

use crate::generated::shaders::draw_vertex_attrib_divisor::VERTEX_ATTRIB_DIVISOR;
use crate::rr::defs::IndexType;
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState};
use crate::rr::renderer::{
    DrawCommand, DrawIndices, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view,
};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::submit_commands_and_wait;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::instanced_tests::{
    TestFragShader, TestVertShader, VertexPositionAndColor, pre_render_commands,
};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, DrawRecorder, ImageWithBuffer, clear_value_color, copy_general_image_to_buffer,
    create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::shader_object::util::{
    ShaderObject, bind_graphics_shaders, bind_null_task_mesh_shaders, create_shader, get_mesh_shader_features,
    set_default_shader_object_dynamic_states, shader_create_info,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Extension {
    Ext,
    Khr,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PipelineType {
    StaticPipeline,
    DynamicPipeline,
    ShaderObjects,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawFunction {
    Draw,
    DrawIndexed,
    DrawIndirect,
    DrawIndexedIndirect,
    DrawMultiExt,
    DrawMultiIndexedExt,
    DrawIndirectByteCountExt,
    DrawIndirectCount,
    DrawIndexedIndirectCount,
}

impl DrawFunction {
    /// `isIndirectDraw`
    fn is_indirect_draw(self) -> bool {
        matches!(
            self,
            DrawFunction::DrawIndirect
                | DrawFunction::DrawIndexedIndirect
                | DrawFunction::DrawIndirectByteCountExt
                | DrawFunction::DrawIndirectCount
                | DrawFunction::DrawIndexedIndirectCount
        )
    }

    /// `isIndexedDraw`
    fn is_indexed_draw(self) -> bool {
        matches!(
            self,
            DrawFunction::DrawIndexed
                | DrawFunction::DrawIndexedIndirect
                | DrawFunction::DrawMultiIndexedExt
                | DrawFunction::DrawIndexedIndirectCount
        )
    }

    /// `isCountDraw`
    fn is_count_draw(self) -> bool {
        matches!(
            self,
            DrawFunction::DrawIndirectCount | DrawFunction::DrawIndexedIndirectCount
        )
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    extension: Extension,
    pipeline_type: PipelineType,
    function: DrawFunction,
    group_params: GroupParams,
    first_instance_zero: bool,
    attrib_divisor: u32,
}

const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const WIDTH: u32 = 128;
const HEIGHT: u32 = 128;
const QUAD_GRID_SIZE: u32 = 8;

struct VertexAttributeDivisorCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for VertexAttributeDivisorCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `VertexAttributeDivisorCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        let mut attribute_divisor_features = vk::PhysicalDeviceVertexAttributeDivisorFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut attribute_divisor_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };

        let supports_non_zero_first_instance = || {
            let mut properties = vk::PhysicalDeviceVertexAttributeDivisorProperties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            properties.supports_non_zero_first_instance != vk::FALSE
        };
        // Only the KHR (or core 1.4) properties struct carries supportsNonZeroFirstInstance.
        let has_properties_struct = context.is_device_functionality_supported("VK_KHR_vertex_attribute_divisor")
            || context.get_device_properties().api_version >= vk::make_version(1, 4, 0);

        match params.extension {
            Extension::Ext => {
                context.require_device_functionality("VK_EXT_vertex_attribute_divisor")?;
                // VUID-vkCmdDraw-pNext-09461
                if has_properties_struct && !params.first_instance_zero && !supports_non_zero_first_instance() {
                    return Err(TestError::NotSupported(
                        "supportsNonZeroFirstInstance not supported".to_string(),
                    ));
                }
            }
            Extension::Khr => {
                context.require_device_functionality("VK_KHR_vertex_attribute_divisor")?;
                if !params.first_instance_zero && !supports_non_zero_first_instance() {
                    return Err(TestError::NotSupported(
                        "supportsNonZeroFirstInstance not supported".to_string(),
                    ));
                }
            }
        }
        if !params.first_instance_zero
            && params.function.is_indirect_draw()
            && context.get_device_features().draw_indirect_first_instance == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "drawIndirectFirstInstancenot supported".to_string(),
            ));
        }
        if params.attrib_divisor == 1 && attribute_divisor_features.vertex_attribute_instance_rate_divisor == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "vertexAttributeInstanceRateDivisor not supported".to_string(),
            ));
        }
        if params.attrib_divisor == 0
            && attribute_divisor_features.vertex_attribute_instance_rate_zero_divisor == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "vertexAttributeInstanceRateZeroDivisor not supported".to_string(),
            ));
        }

        if params.pipeline_type == PipelineType::DynamicPipeline {
            context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
        }
        if params.pipeline_type == PipelineType::ShaderObjects {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }

        if params.function == DrawFunction::DrawMultiExt || params.function == DrawFunction::DrawMultiIndexedExt {
            context.require_device_functionality("VK_EXT_multi_draw")?;
        }
        if params.function.is_indirect_draw() {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }

        if params.function == DrawFunction::DrawIndirectByteCountExt {
            let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if xfb_features.transform_feedback == vk::FALSE {
                return Err(TestError::NotSupported("transformFeedback not supported".to_string()));
            }

            let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if xfb_properties.transform_feedback_draw == vk::FALSE {
                return Err(TestError::NotSupported(
                    "transformFeedbackDraw not supported".to_string(),
                ));
            }
        }

        if params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        VERTEX_ATTRIB_DIVISOR.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VertexAttributeDivisorInstance {
            context,
            params: self.params,
        })
    }
}

struct VertexAttributeDivisorInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// What `prepareVertexData` fills in.
struct VertexData {
    data: Vec<VertexPositionAndColor>,
    indexes: Vec<u32>,
    instanced_color: Vec<[f32; 4]>,
}

/// `VertexAttributeDivisorInstance::prepareVertexData`
fn prepare_vertex_data(
    function: DrawFunction,
    instance_count: i32,
    first_instance: i32,
    instance_divisor: i32,
) -> VertexData {
    let blue = [0.0f32, 0.0, 1.0, 1.0];
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let grid = QUAD_GRID_SIZE as f32;
    let mut data = Vec::new();
    let mut indexes = Vec::new();
    let mut instanced_color = Vec::new();

    if !function.is_indexed_draw() {
        for y in 0..QUAD_GRID_SIZE {
            for x in 0..QUAD_GRID_SIZE {
                let fx0 = -1.0 + (x as f32) / grid * 2.0 / instance_count as f32;
                let fx1 = -1.0 + ((x + 1) as f32) / grid * 2.0 / instance_count as f32;
                let fy0 = -1.0 + (y as f32) / grid * 2.0;
                let fy1 = -1.0 + ((y + 1) as f32) / grid * 2.0;

                // Vertices of a quad's lower-left triangle: (fx0, fy0), (fx1, fy0) and (fx0, fy1)
                data.push(VertexPositionAndColor {
                    position: [fx0, fy0, 1.0, 1.0],
                    color: blue,
                });
                data.push(VertexPositionAndColor {
                    position: [fx1, fy0, 1.0, 1.0],
                    color: blue,
                });
                data.push(VertexPositionAndColor {
                    position: [fx0, fy1, 1.0, 1.0],
                    color: green,
                });

                // Vertices of a quad's upper-right triangle: (fx1, fy1), (fx0, fy1) and (fx1, fy0)
                data.push(VertexPositionAndColor {
                    position: [fx1, fy1, 1.0, 1.0],
                    color: green,
                });
                data.push(VertexPositionAndColor {
                    position: [fx0, fy1, 1.0, 1.0],
                    color: green,
                });
                data.push(VertexPositionAndColor {
                    position: [fx1, fy0, 1.0, 1.0],
                    color: blue,
                });
            }
        }
    } else {
        for y in 0..QUAD_GRID_SIZE + 1 {
            for x in 0..QUAD_GRID_SIZE + 1 {
                let fx = -1.0 + (x as f32) / grid * 2.0 / instance_count as f32;
                let fy = -1.0 + (y as f32) / grid * 2.0;

                data.push(VertexPositionAndColor {
                    position: [fx, fy, 1.0, 1.0],
                    color: if y % 2 != 0 { blue } else { green },
                });
            }
        }

        for y in 0..QUAD_GRID_SIZE {
            for x in 0..QUAD_GRID_SIZE {
                let ndx00 = y * (QUAD_GRID_SIZE + 1) + x;
                let ndx10 = y * (QUAD_GRID_SIZE + 1) + x + 1;
                let ndx01 = (y + 1) * (QUAD_GRID_SIZE + 1) + x;
                let ndx11 = (y + 1) * (QUAD_GRID_SIZE + 1) + x + 1;

                // Lower-left triangle of a quad.
                indexes.push(ndx00);
                indexes.push(ndx10);
                indexes.push(ndx01);

                // Upper-right triangle of a quad.
                indexes.push(ndx11);
                indexes.push(ndx01);
                indexes.push(ndx10);
            }
        }
    }

    let color_count = if instance_divisor == 0 {
        1
    } else {
        (instance_count + first_instance + instance_divisor - 1) / instance_divisor
    };
    for i in 0..instance_count + first_instance {
        instanced_color.push([
            0.0,
            ((1.0 - i as f64 * 1.0 / color_count as f64) as f32) / 2.0,
            0.0,
            1.0,
        ]);
    }

    VertexData {
        data,
        indexes,
        instanced_color,
    }
}

/// The buffers and counts one draw uses.
struct DrawData {
    vertex_buffer: vk::Buffer,
    instanced_vertex_buffer: vk::Buffer,
    index_buffer: Option<vk::Buffer>,
    indirect_buffer: Option<vk::Buffer>,
    count_buffer: Option<vk::Buffer>,
    vertex_count: u32,
    index_count: u32,
    first_instance: u32,
    instance_count: u32,
}

impl VertexAttributeDivisorInstance<'_> {
    /// `VertexAttributeDivisorInstance::draw`
    fn draw(
        &self,
        cmd_buffer: vk::CommandBuffer,
        pipeline_layout: vk::PipelineLayout,
        pipeline: vk::Pipeline,
        shaders: Option<(vk::ShaderEXT, vk::ShaderEXT)>,
        draw_data: &DrawData,
    ) {
        let device = self.context.get_device();
        let params = &self.params;

        if let Some((vertex_shader, fragment_shader)) = shaders {
            let mesh_features = get_mesh_shader_features(self.context);
            bind_graphics_shaders(
                device,
                cmd_buffer,
                vertex_shader,
                vk::ShaderEXT::null(),
                vk::ShaderEXT::null(),
                vk::ShaderEXT::null(),
                fragment_shader,
                mesh_features.task_shader != vk::FALSE,
                mesh_features.mesh_shader != vk::FALSE,
            );
            set_default_shader_object_dynamic_states(
                device,
                cmd_buffer,
                self.context.get_device_extensions(),
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                false,
                false,
                WIDTH,
                HEIGHT,
            );
            bind_null_task_mesh_shaders(device, cmd_buffer, &mesh_features);
        }

        unsafe {
            if shaders.is_none() {
                device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
            }

            if params.function.is_indexed_draw() {
                device.cmd_bind_index_buffer(
                    cmd_buffer,
                    draw_data.index_buffer.expect("index buffer"),
                    0,
                    vk::IndexType::UINT32,
                );
            }

            device.cmd_bind_vertex_buffers(
                cmd_buffer,
                0,
                &[draw_data.vertex_buffer, draw_data.instanced_vertex_buffer],
                &[0, 0],
            );

            let mut push_constants = [0u8; 8];
            push_constants[..4].copy_from_slice(&(draw_data.first_instance as f32).to_ne_bytes());
            push_constants[4..].copy_from_slice(&(draw_data.instance_count as f32).to_ne_bytes());
            device.cmd_push_constants(
                cmd_buffer,
                pipeline_layout,
                vk::ShaderStageFlags::VERTEX,
                0,
                &push_constants,
            );

            if params.pipeline_type != PipelineType::StaticPipeline {
                let vertex_binding_descriptions = [
                    vk::VertexInputBindingDescription2EXT {
                        binding: 0,
                        stride: std::mem::size_of::<VertexPositionAndColor>() as u32,
                        input_rate: vk::VertexInputRate::VERTEX,
                        divisor: 1,
                        ..Default::default()
                    },
                    vk::VertexInputBindingDescription2EXT {
                        binding: 1,
                        stride: 16,
                        input_rate: vk::VertexInputRate::INSTANCE,
                        divisor: params.attrib_divisor,
                        ..Default::default()
                    },
                ];
                let vertex_attribute_descriptions = [
                    vk::VertexInputAttributeDescription2EXT {
                        location: 0,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                        ..Default::default()
                    },
                    vk::VertexInputAttributeDescription2EXT {
                        location: 1,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 16,
                        ..Default::default()
                    },
                    vk::VertexInputAttributeDescription2EXT {
                        location: 2,
                        binding: 1,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                        ..Default::default()
                    },
                ];
                device.cmd_set_vertex_input_ext(
                    cmd_buffer,
                    &vertex_binding_descriptions,
                    &vertex_attribute_descriptions,
                );
            }

            let multi_draw_info = [vk::MultiDrawInfoEXT {
                first_vertex: 0,
                vertex_count: draw_data.vertex_count,
            }];
            let multi_draw_indexed_info = [vk::MultiDrawIndexedInfoEXT {
                first_index: 0,
                index_count: draw_data.index_count,
                vertex_offset: 0,
            }];
            let vertex_offset = 0i32;

            match params.function {
                DrawFunction::Draw => device.cmd_draw(
                    cmd_buffer,
                    draw_data.vertex_count,
                    draw_data.instance_count,
                    0,
                    draw_data.first_instance,
                ),
                DrawFunction::DrawIndexed => device.cmd_draw_indexed(
                    cmd_buffer,
                    draw_data.index_count,
                    draw_data.instance_count,
                    0,
                    0,
                    draw_data.first_instance,
                ),
                DrawFunction::DrawIndexedIndirect => device.cmd_draw_indexed_indirect(
                    cmd_buffer,
                    draw_data.indirect_buffer.expect("indirect buffer"),
                    0,
                    1,
                    0,
                ),
                DrawFunction::DrawIndexedIndirectCount => device.cmd_draw_indexed_indirect_count_khr(
                    cmd_buffer,
                    draw_data.indirect_buffer.expect("indirect buffer"),
                    0,
                    draw_data.count_buffer.expect("count buffer"),
                    0,
                    1,
                    std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32,
                ),
                DrawFunction::DrawIndirect => {
                    device.cmd_draw_indirect(cmd_buffer, draw_data.indirect_buffer.expect("indirect buffer"), 0, 1, 0)
                }
                DrawFunction::DrawIndirectCount => device.cmd_draw_indirect_count_khr(
                    cmd_buffer,
                    draw_data.indirect_buffer.expect("indirect buffer"),
                    0,
                    draw_data.count_buffer.expect("count buffer"),
                    0,
                    1,
                    std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
                ),
                DrawFunction::DrawIndirectByteCountExt => device.cmd_draw_indirect_byte_count_ext(
                    cmd_buffer,
                    draw_data.instance_count,
                    draw_data.first_instance,
                    draw_data.count_buffer.expect("count buffer"),
                    0,
                    0,
                    std::mem::size_of::<VertexPositionAndColor>() as u32,
                ),
                DrawFunction::DrawMultiExt => device.cmd_draw_multi_ext(
                    cmd_buffer,
                    &multi_draw_info,
                    draw_data.instance_count,
                    draw_data.first_instance,
                    std::mem::size_of::<vk::MultiDrawInfoEXT>() as u32,
                ),
                DrawFunction::DrawMultiIndexedExt => device.cmd_draw_multi_indexed_ext(
                    cmd_buffer,
                    &multi_draw_indexed_info,
                    draw_data.instance_count,
                    draw_data.first_instance,
                    std::mem::size_of::<vk::MultiDrawIndexedInfoEXT>() as u32,
                    Some(&vertex_offset),
                ),
            }
        }
    }

    /// The reference rendering of `iterate`.
    fn reference_image(
        &self,
        vertex_data: &VertexData,
        instance_count: u32,
        first_instance: u32,
    ) -> Result<TextureLevel, TestError> {
        let params = &self.params;

        let vertices: Vec<[f32; 4]> = vertex_data.data.iter().map(|vertex| vertex.position).collect();
        let colors: Vec<[f32; 4]> = vertex_data.data.iter().map(|vertex| vertex.color).collect();

        let mut ref_image = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            WIDTH,
            HEIGHT,
            1,
        )?;
        {
            let mut access = ref_image.get_access();
            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
        }

        let vert_shader = TestVertShader::new(instance_count as i32, first_instance as i32);
        let frag_shader = TestFragShader::new();
        let program = Program {
            vertex_shader: &vert_shader,
            fragment_shader: &frag_shader,
            geometry_shader: None,
        };
        let mut render_target = RenderTarget::new(as_multisample_view(ref_image.get_access()), None, None);
        let render_state = RenderState::new(
            ViewportState::from_target_size(WIDTH as i32, HEIGHT as i32),
            self.context.get_device_properties().limits.sub_pixel_precision_bits as i32,
        );
        let renderer = Renderer::new();

        // The reference renderer treats a divisor of 0 as meaning per-vertex. Use i32::MAX instead; it should work just as well.
        let instance_divisor = if params.attrib_divisor == 0 {
            i32::MAX
        } else {
            params.attrib_divisor as i32
        };
        let vertex_attribs = [
            VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, vertices.as_ptr().cast::<u8>()),
            VertexAttrib::from_pointer(VertexAttribType::Float, 4, 16, 0, colors.as_ptr().cast::<u8>()),
            VertexAttrib::from_pointer(
                VertexAttribType::Float,
                4,
                16,
                instance_divisor,
                vertex_data.instanced_color.as_ptr().cast::<u8>(),
            ),
        ];

        let primitives = if !params.function.is_indexed_draw() {
            PrimitiveList::from_arrays(PrimitiveType::TriangleStrip, vertices.len(), 0)
        } else {
            PrimitiveList::from_indices(
                PrimitiveType::TriangleStrip,
                vertex_data.indexes.len(),
                DrawIndices::U32(&vertex_data.indexes, 0),
                IndexType::Uint32,
            )
        };
        let command = DrawCommand {
            state: &render_state,
            program: &program,
            vertex_attribs: &vertex_attribs,
            primitives: &primitives,
        };
        renderer.draw_instanced(&command, &mut render_target, instance_count as i32);
        Ok(ref_image)
    }
}

impl TestInstance for VertexAttributeDivisorInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let dynamic_rendering = params.group_params.use_dynamic_rendering;
        let instance_counts = [0u32, 1, 2, 4, 20];
        let render_area = rect_2d(WIDTH, HEIGHT);
        let tcu_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let mut fail = false;

        // `VertexAttributeDivisorInstance::VertexAttributeDivisorInstance`
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: 8,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let target = ImageWithBuffer::new(context, WIDTH, HEIGHT, COLOR_ATTACHMENT_FORMAT, usage, 4)?;

        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_color_render_pass(
                device,
                COLOR_ATTACHMENT_FORMAT,
                vk::AttachmentLoadOp::LOAD,
                vk::AttachmentStoreOp::STORE,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
            )?;
            let framebuffer = make_framebuffer(device, *render_pass, &[*target.view], WIDTH, HEIGHT, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let sec_cmd_buffer = if params.group_params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(WIDTH, HEIGHT);
        if params.pipeline_type == PipelineType::DynamicPipeline {
            state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_EXT];
        } else {
            state.bindings = vec![
                vk::VertexInputBindingDescription {
                    binding: 0,
                    stride: std::mem::size_of::<VertexPositionAndColor>() as u32,
                    input_rate: vk::VertexInputRate::VERTEX,
                },
                vk::VertexInputBindingDescription {
                    binding: 1,
                    stride: 16,
                    input_rate: vk::VertexInputRate::INSTANCE,
                },
            ];
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
                vk::VertexInputAttributeDescription {
                    location: 2,
                    binding: 1,
                    format: vk::Format::R32G32B32A32_SFLOAT,
                    offset: 0,
                },
            ];
            state.vertex_divisors = vec![vk::VertexInputBindingDivisorDescription {
                binding: 1,
                divisor: params.attrib_divisor,
            }];
        }
        if dynamic_rendering {
            state.rendering_format = Some(COLOR_ATTACHMENT_FORMAT);
        }
        let pipeline = if params.pipeline_type == PipelineType::ShaderObjects {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                render_pass_handle,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vs),
                    (vk::ShaderStageFlags::FRAGMENT, *fs),
                ],
                &state,
            )?)
        };

        let (vertex_shader, fragment_shader): (Option<ShaderObject<'_>>, Option<ShaderObject<'_>>) =
            if params.pipeline_type == PipelineType::ShaderObjects {
                let vert_binary = binaries.get("vert")?;
                let frag_binary = binaries.get("frag")?;
                let vertex_create_info = shader_create_info(
                    vk::ShaderCreateFlagsEXT::empty(),
                    vk::ShaderStageFlags::VERTEX,
                    vk::ShaderStageFlags::FRAGMENT,
                    vk::ShaderCodeTypeEXT::SPIRV,
                    std::mem::size_of_val(vert_binary.spirv),
                    vert_binary.spirv.as_ptr().cast(),
                    &[],
                    &push_constant_ranges,
                );
                let fragment_create_info = shader_create_info(
                    vk::ShaderCreateFlagsEXT::empty(),
                    vk::ShaderStageFlags::FRAGMENT,
                    vk::ShaderStageFlags::empty(),
                    vk::ShaderCodeTypeEXT::SPIRV,
                    std::mem::size_of_val(frag_binary.spirv),
                    frag_binary.spirv.as_ptr().cast(),
                    &[],
                    &push_constant_ranges,
                );
                (
                    Some(create_shader(device, &vertex_create_info)?),
                    Some(create_shader(device, &fragment_create_info)?),
                )
            } else {
                (None, None)
            };
        let pipeline_handle = pipeline.as_ref().map_or_else(vk::Pipeline::null, |pipeline| **pipeline);
        let shader_objects = match (&vertex_shader, &fragment_shader) {
            (Some(vertex), Some(fragment)) => Some((vertex.get(), fragment.get())),
            _ => None,
        };

        let recorder = DrawRecorder {
            device,
            group_params: params.group_params,
            format: COLOR_ATTACHMENT_FORMAT,
            image_view: *target.view,
            render_area,
            clear_value: clear_value_color([0.0, 0.0, 0.0, 1.0]),
            image_layout: vk::ImageLayout::GENERAL,
            load_op: vk::AttachmentLoadOp::LOAD,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            layer_count: 1,
            view_mask: 0,
        };

        let first_instance_indices: &[u32] = if params.first_instance_zero {
            &[0]
        } else {
            &[1, 3, 4, 20]
        };

        for instance_count in instance_counts {
            for &first_instance in first_instance_indices {
                // Prepare vertex data for at least one instance
                let prepare_count = instance_count.max(1);

                let vertex_data = prepare_vertex_data(
                    params.function,
                    prepare_count as i32,
                    first_instance as i32,
                    params.attrib_divisor as i32,
                );
                let vertex_buffer =
                    create_host_buffer(context, &vertex_data.data, vk::BufferUsageFlags::VERTEX_BUFFER)?;
                let instanced_vertex_buffer = create_host_buffer(
                    context,
                    &vertex_data.instanced_color,
                    vk::BufferUsageFlags::VERTEX_BUFFER,
                )?;

                let index_buffer = if params.function.is_indexed_draw() {
                    Some(create_host_buffer(
                        context,
                        &vertex_data.indexes,
                        vk::BufferUsageFlags::INDEX_BUFFER,
                    )?)
                } else {
                    None
                };

                let indirect_buffer = if params.function.is_indirect_draw() {
                    if !params.function.is_indexed_draw() {
                        let draw_commands = [vk::DrawIndirectCommand {
                            vertex_count: vertex_data.data.len() as u32,
                            instance_count,
                            first_vertex: 0,
                            first_instance,
                        }];
                        Some(create_host_buffer(
                            context,
                            &draw_commands,
                            vk::BufferUsageFlags::INDIRECT_BUFFER,
                        )?)
                    } else {
                        let draw_commands = [vk::DrawIndexedIndirectCommand {
                            index_count: vertex_data.indexes.len() as u32,
                            instance_count,
                            first_index: 0,
                            vertex_offset: 0,
                            first_instance,
                        }];
                        Some(create_host_buffer(
                            context,
                            &draw_commands,
                            vk::BufferUsageFlags::INDIRECT_BUFFER,
                        )?)
                    }
                } else {
                    None
                };

                let count_buffer = if params.function.is_count_draw() {
                    Some(create_host_buffer(
                        context,
                        &[1u32],
                        vk::BufferUsageFlags::INDIRECT_BUFFER,
                    )?)
                } else if params.function == DrawFunction::DrawIndirectByteCountExt {
                    let count = [(vertex_data.data.len() * std::mem::size_of::<VertexPositionAndColor>()) as u32];
                    Some(create_host_buffer(
                        context,
                        &count,
                        vk::BufferUsageFlags::INDIRECT_BUFFER,
                    )?)
                } else {
                    None
                };

                let draw_data = DrawData {
                    vertex_buffer: vertex_buffer.get(),
                    instanced_vertex_buffer: instanced_vertex_buffer.get(),
                    index_buffer: index_buffer.as_ref().map(|buffer| buffer.get()),
                    indirect_buffer: indirect_buffer.as_ref().map(|buffer| buffer.get()),
                    count_buffer: count_buffer.as_ref().map(|buffer| buffer.get()),
                    vertex_count: vertex_data.data.len() as u32,
                    index_count: vertex_data.indexes.len() as u32,
                    first_instance,
                    instance_count,
                };

                let image = target.image.get();
                recorder.record(
                    *cmd_buffer,
                    sec_cmd_buffer.as_ref().map(|buffer| **buffer),
                    |cmd| pre_render_commands(device, cmd, image, 1),
                    |cmd| {
                        self.draw(cmd, *pipeline_layout, pipeline_handle, shader_objects, &draw_data);
                        Ok(())
                    },
                    |cmd| copy_general_image_to_buffer(device, cmd, image, target.buffer.get(), WIDTH, HEIGHT),
                )?;
                submit_commands_and_wait(device, queue, *cmd_buffer)?;

                // Reference rendering
                let ref_image = self.reference_image(&vertex_data, instance_count, first_instance)?;

                let rendered_bytes = target.read_bytes(device)?;
                let rendered_frame = ConstPixelBufferAccess::new(tcu_format, [WIDTH, HEIGHT, 1], rendered_bytes);

                if fuzzy_compare_ok(&ref_image.get_const_access(), &rendered_frame, 0.05) != Some(true) {
                    fail = true;
                }
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected results in output buffers; check log for details --",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createVertexAttributeDivisorTests`
pub fn create_vertex_attribute_divisor_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_attribute_divisor");

    let extension_tests = [(Extension::Ext, "ext"), (Extension::Khr, "khr")];
    let mut pipeline_tests = vec![
        (PipelineType::StaticPipeline, "static_pipeline"),
        (PipelineType::DynamicPipeline, "dynamic_pipeline"),
    ];
    if group_params.use_dynamic_rendering {
        pipeline_tests.push((PipelineType::ShaderObjects, "shader_objects"));
    }
    let draw_tests = [
        (DrawFunction::Draw, "draw"),
        (DrawFunction::DrawIndexed, "draw_indexed"),
        (DrawFunction::DrawIndirect, "draw_indirect"),
        (DrawFunction::DrawIndexedIndirect, "draw_indexed_indirect"),
        (DrawFunction::DrawMultiExt, "draw_multi_ext"),
        (DrawFunction::DrawMultiIndexedExt, "draw_multi_indexed_ext"),
        (DrawFunction::DrawIndirectByteCountExt, "draw_indirect_byte_count"),
        (DrawFunction::DrawIndirectCount, "draw_indirect_count"),
        (DrawFunction::DrawIndexedIndirectCount, "draw_indexed_indirect_count"),
    ];
    let first_instance_tests = [(true, "zero"), (false, "non_zero")];
    let vertex_attribute_divisor_tests = [(0u32, "0"), (1, "1"), (2, "2"), (16, "16")];

    for (extension, extension_name) in extension_tests {
        let mut extension_group = TestCaseGroup::new(extension_name);

        for &(pipeline_type, pipeline_name) in &pipeline_tests {
            let mut pipeline_group = TestCaseGroup::new(pipeline_name);

            for (function, draw_name) in draw_tests {
                let mut draw_group = TestCaseGroup::new(draw_name);

                for (first_instance_zero, first_instance_name) in first_instance_tests {
                    let mut first_instance_group = TestCaseGroup::new(first_instance_name);

                    for (attrib_divisor, divisor_name) in vertex_attribute_divisor_tests {
                        let params = TestParams {
                            extension,
                            pipeline_type,
                            function,
                            group_params,
                            first_instance_zero,
                            attrib_divisor,
                        };
                        first_instance_group.add_child(Box::new(VertexAttributeDivisorCase {
                            name: divisor_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }

                    draw_group.add_child(first_instance_group);
                }

                pipeline_group.add_child(draw_group);
            }

            extension_group.add_child(pipeline_group);
        }

        group.add_child(extension_group);
    }
    group
}
