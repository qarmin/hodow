// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawDepthClampTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The depth aspect is copied to a buffer in the primary command
// buffer and decoded per format, where upstream calls `Image::readDepth`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, ExtDepthClampControlExtensionDeviceCommands};

use crate::generated::shaders::draw_depth_clamp::DEPTH_CLAMP;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::transition_2d_image;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, end_rendering, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 256;
const HEIGHT: u32 = 256;

#[derive(Clone, Copy)]
struct ViewportData {
    min_depth: f32,
    max_depth: f32,
    depth_value: f32,
    expected_value: f32,
}

#[derive(Clone, Copy, Default)]
struct DepthClampData {
    enabled: bool,
    min_depth_clamp: f32,
    max_depth_clamp: f32,
}

#[derive(Clone)]
struct TestParams {
    test_name_suffix: &'static str,
    viewport_data: Vec<ViewportData>,
    depth_clamp_control: DepthClampData,
    enable_depth_bias: bool,
    depth_bias_constant_factor: f32,
    /// Upstream's skipUNorm and skipSNorm are equal in every entry, and no depth format is SNORM.
    skip_unorm: bool,
    required_extensions: Vec<&'static str>,
}

const DEPTH_STENCIL_IMAGE_FORMATS_TO_TEST: [(vk::Format, &str, f32); 6] = [
    (vk::Format::D16_UNORM, "d16_unorm", 1e-5),
    (vk::Format::X8_D24_UNORM_PACK32, "x8_d24_unorm_pack32", f32::EPSILON),
    (vk::Format::D32_SFLOAT, "d32_sfloat", f32::EPSILON),
    (vk::Format::D16_UNORM_S8_UINT, "d16_unorm_s8_uint", 1e-5),
    (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint", f32::EPSILON),
    (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint", f32::EPSILON),
];

const INITIAL_CLEAR_DEPTH: f32 = 0.5;

const UNRESTRICTED: &str = "VK_EXT_depth_range_unrestricted";
const CLAMP_CONTROL: &str = "VK_EXT_depth_clamp_control";

/// One entry of `depthClearValuesToTest` with a single viewport.
fn single(
    test_name_suffix: &'static str,
    viewport: (f32, f32, f32, f32),
    clamp_range: Option<(f32, f32)>,
    depth_bias_constant_factor: Option<f32>,
    skip_unorm: bool,
    required_extensions: &[&'static str],
) -> TestParams {
    TestParams {
        test_name_suffix,
        viewport_data: vec![ViewportData {
            min_depth: viewport.0,
            max_depth: viewport.1,
            depth_value: viewport.2,
            expected_value: viewport.3,
        }],
        depth_clamp_control: clamp_range.map_or_else(DepthClampData::default, |(min_depth_clamp, max_depth_clamp)| {
            DepthClampData {
                enabled: true,
                min_depth_clamp,
                max_depth_clamp,
            }
        }),
        enable_depth_bias: depth_bias_constant_factor.is_some(),
        depth_bias_constant_factor: depth_bias_constant_factor.unwrap_or(0.0),
        skip_unorm,
        required_extensions: required_extensions.to_vec(),
    }
}

/// `depthClearValuesToTest`
fn depth_clear_values_to_test() -> Vec<TestParams> {
    vec![
        single("", (0.0, 1.0, 0.3, 0.3), None, None, false, &[]),
        single("_clamp_input_negative", (0.0, 1.0, -1e6, 0.0), None, None, false, &[]),
        single("_clamp_input_positive", (0.0, 1.0, 1.0e6, 1.0), None, None, false, &[]),
        single(
            "_depth_bias_clamp_input_negative",
            (0.0, 1.0, 0.3, 0.0),
            None,
            Some(-2e11),
            false,
            &[],
        ),
        single(
            "_depth_bias_clamp_input_positive",
            (0.0, 1.0, 0.7, 1.0),
            None,
            Some(2e11),
            false,
            &[],
        ),
        single(
            "_depth_range_unrestricted_negative",
            (-1.5, 1.0, -1.5, -1.5),
            None,
            None,
            true,
            &[UNRESTRICTED],
        ),
        single(
            "_depth_range_unrestricted_positive",
            (0.0, 1.5, 1.5, 1.5),
            None,
            None,
            true,
            &[UNRESTRICTED],
        ),
        TestParams {
            test_name_suffix: "_clamp_four_viewports",
            viewport_data: vec![
                ViewportData {
                    min_depth: 0.0,
                    max_depth: 0.5,
                    depth_value: 0.7,
                    expected_value: 0.35,
                }, // 0.7 * 0.5 + (1.0 - 0.7) * 0.0) = 0.35
                ViewportData {
                    min_depth: 0.9,
                    max_depth: 1.0,
                    depth_value: 1.0,
                    expected_value: 1.0,
                }, // 1.0 * 1.0 + (1.0 - 1.0) * 0.9 = 1.0
                ViewportData {
                    min_depth: 0.5,
                    max_depth: 1.0,
                    depth_value: 0.9,
                    expected_value: 0.95,
                }, // 0.9 * 1.0 + (1.0 - 0.9) * 0.5 = 0.95
                ViewportData {
                    min_depth: 0.5,
                    max_depth: 0.9,
                    depth_value: 0.4,
                    expected_value: 0.66,
                }, // 0.4 * 0.9 + (1.0 - 0.4) * 0.5 = 0.66
            ],
            depth_clamp_control: DepthClampData::default(),
            enable_depth_bias: false,
            depth_bias_constant_factor: 0.0,
            skip_unorm: true,
            required_extensions: Vec::new(),
        },
        single(
            "_clamp_control_viewport_range",
            (0.0, 1.0, 0.3, 0.3),
            None,
            None,
            false,
            &[CLAMP_CONTROL],
        ),
        single(
            "_clamp_control_half_viewport_range",
            (0.0, 0.5, 0.4, 0.2),
            Some((0.1, 0.9)),
            None,
            false,
            &[CLAMP_CONTROL],
        ),
        single(
            "_clamp_control_input_negative",
            (0.0, 1.0, -1e6, 0.1),
            Some((0.1, 0.9)),
            None,
            false,
            &[CLAMP_CONTROL],
        ),
        single(
            "_clamp_control_input_positive",
            (0.0, 1.0, 1.0e6, 0.9),
            Some((0.1, 0.9)),
            None,
            false,
            &[CLAMP_CONTROL],
        ),
        single(
            "_depth_bias_clamp_control_input_negative",
            (0.3, 1.0, 0.3, 0.1),
            Some((0.1, 0.9)),
            Some(-2e11),
            false,
            &[CLAMP_CONTROL],
        ),
        single(
            "_depth_bias_clamp_control_input_positive",
            (0.0, 0.7, 0.7, 0.9),
            Some((0.1, 0.9)),
            Some(2e11),
            false,
            &[CLAMP_CONTROL],
        ),
        single(
            "_unrestricted_clamp_control_negative",
            (-1.5, 1.0, -1.5, -1.4),
            Some((-1.4, 0.9)),
            None,
            true,
            &[CLAMP_CONTROL, UNRESTRICTED],
        ),
        single(
            "_unrestricted_clamp_control_positive",
            (0.0, 1.5, 1.5, 1.4),
            Some((0.1, 1.4)),
            None,
            true,
            &[CLAMP_CONTROL, UNRESTRICTED],
        ),
        single(
            "_unrestricted_bias_clamp_control_negative",
            (0.0, 1.0, 0.3, -1.4),
            Some((-1.4, 0.9)),
            Some(-2e11),
            true,
            &[CLAMP_CONTROL, UNRESTRICTED],
        ),
        single(
            "_unrestricted_bias_clamp_control_positive",
            (0.0, 1.0, 0.7, 1.4),
            Some((0.1, 1.4)),
            Some(2e11),
            true,
            &[CLAMP_CONTROL, UNRESTRICTED],
        ),
    ]
}

/// `isUnormDepthFormat`
fn is_unorm_depth_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::D24_UNORM_S8_UINT
            | vk::Format::X8_D24_UNORM_PACK32
            | vk::Format::D16_UNORM_S8_UINT
            | vk::Format::D16_UNORM
    )
}

fn is_combined_depth_stencil(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::D16_UNORM_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT
    )
}

/// Bytes per texel of the depth aspect of `format` in a buffer copy.
fn depth_texel_size(format: vk::Format) -> usize {
    match format {
        vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => 2,
        _ => 4,
    }
}

fn decode_depth(format: vk::Format, texel: &[u8]) -> f32 {
    match format {
        vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => {
            u16::from_le_bytes([texel[0], texel[1]]) as f32 / 65535.0
        }
        vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D24_UNORM_S8_UINT => {
            (u32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]]) & 0x00ff_ffff) as f32 / 16777215.0
        }
        _ => f32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]]),
    }
}

/// `tcu::isCombinedDepthStencilType(...) && format != VK_FORMAT_X8_D24_UNORM_PACK32` selects the aspects the image is used with.
fn aspect_bits_of(format: vk::Format) -> vk::ImageAspectFlags {
    if is_combined_depth_stencil(format) {
        vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
    } else {
        vk::ImageAspectFlags::DEPTH
    }
}

struct DepthClampTest {
    name: String,
    params: TestParams,
    format: vk::Format,
    epsilon: f32,
    group_params: GroupParams,
    dynamic: bool,
}

impl TestCase for DepthClampTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DepthClampTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().depth_clamp == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: depthClamp".to_string(),
            ));
        }
        for extension_name in &self.params.required_extensions {
            context.require_device_functionality(extension_name)?;
        }

        if self.params.viewport_data.len() > 1 {
            if context.get_device_features().multi_viewport == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: multiViewport".to_string(),
                ));
            }
            if context.get_device_features().geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported("Geometry shader is not supported".to_string()));
            }
        }

        let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if let Err(error) = format_properties
            && error == vk::ErrorCode::FORMAT_NOT_SUPPORTED
        {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        if self.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DEPTH_CLAMP.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthClampTestInstance {
            context,
            params: self.params.clone(),
            format: self.format,
            epsilon: self.epsilon,
            group_params: self.group_params,
            dynamic: self.dynamic,
        })
    }
}

struct DepthClampTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    format: vk::Format,
    epsilon: f32,
    group_params: GroupParams,
    dynamic: bool,
}

impl TestInstance for DepthClampTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let format = self.format;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc = context.get_default_allocator();
        let dynamic_rendering = self.group_params.use_dynamic_rendering;
        let viewport_count = params.viewport_data.len() as u32;
        let render_area = rect_2d(WIDTH, HEIGHT);

        // create viewport grid
        let column_count = (viewport_count as f32).sqrt().ceil() as u32;
        let row_count = (viewport_count as f32 / column_count as f32).ceil() as u32;
        let rect_width = WIDTH / column_count;
        let rect_height = HEIGHT / row_count;
        let mut viewport_vect: Vec<vk::Viewport> = Vec::new();
        let mut scissor_vect: Vec<vk::Rect2D> = Vec::new();
        {
            let mut pos = vk::Offset2D { x: 0, y: 0 };

            for (viewport_index, data) in params.viewport_data.iter().enumerate() {
                // move to next row
                if viewport_index != 0 && (viewport_index as u32).is_multiple_of(column_count) {
                    pos.x = 0;
                    pos.y += rect_height as i32;
                }

                viewport_vect.push(vk::Viewport {
                    x: pos.x as f32,
                    y: pos.y as f32,
                    width: rect_width as f32,
                    height: rect_height as f32,
                    min_depth: data.min_depth,
                    max_depth: data.max_depth,
                });
                scissor_vect.push(vk::Rect2D {
                    offset: pos,
                    extent: vk::Extent2D {
                        width: rect_width,
                        height: rect_height,
                    },
                });

                pos.x += rect_width as i32;
            }
        }

        // Vertex data
        let vertices: [[f32; 4]; 4] = [
            [-1.0, -1.0, params.viewport_data[0].depth_value, 1.0], // 0 -- 2
            [-1.0, 1.0, params.viewport_data[0].depth_value, 1.0],  // |  / |
            [1.0, -1.0, params.viewport_data[0].depth_value, 1.0],  // | /  |
            [1.0, 1.0, params.viewport_data[0].depth_value, 1.0],   // 1 -- 3
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Depth target
        let aspect_bits = aspect_bits_of(format);
        let target_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let depth_target_image = ImageWithMemory::new(device, alloc, target_image_info, MemoryRequirement::ANY)?;
        let depth_target_view = make_image_view(
            device,
            depth_target_image.get(),
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(aspect_bits, 0, 1, 0, 1),
        )?;
        let depth_buffer_size = (WIDTH * HEIGHT) as usize * depth_texel_size(format);
        let depth_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(depth_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Render pass and framebuffer
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let attachments = [vk::AttachmentDescription::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build()];
            let depth_attachment_reference = vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            };
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .depth_stencil_attachment(&depth_attachment_reference)
                .build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let framebuffer = make_framebuffer(device, *render_pass, &[*depth_target_view], WIDTH, HEIGHT, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Depth clamp control
        let depth_clamp_range = vk::DepthClampRangeEXT {
            min_depth_clamp: params.depth_clamp_control.min_depth_clamp,
            max_depth_clamp: params.depth_clamp_control.max_depth_clamp,
        };
        let use_user_range = params.depth_clamp_control.enabled && !self.dynamic;

        // Graphics pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let geometry_module = if viewport_count > 1 {
            Some(create_shader_module(device, binaries.get("geom")?)?)
        } else {
            None
        };
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_position_input();
        state.viewport_count = viewport_count;
        state.viewports = viewport_vect.clone();
        state.scissors = scissor_vect.clone();
        state.dynamic_states = vec![vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR];
        if self.dynamic && params.depth_clamp_control.enabled {
            state.dynamic_states.push(vk::DynamicState::DEPTH_CLAMP_RANGE_EXT);
        }
        if params.depth_clamp_control.enabled {
            state.depth_clamp_control = Some(if use_user_range {
                (vk::DepthClampModeEXT::USER_DEFINED_RANGE, Some(depth_clamp_range))
            } else {
                (vk::DepthClampModeEXT::VIEWPORT_RANGE, None)
            });
        }
        state.depth_stencil.depth_test_enable = vk::TRUE;
        state.depth_stencil.depth_write_enable = vk::TRUE;
        state.rasterization.depth_clamp_enable = vk::TRUE;
        state.rasterization.front_face = vk::FrontFace::CLOCKWISE;
        state.rasterization.depth_bias_enable = if params.enable_depth_bias { vk::TRUE } else { vk::FALSE };
        state.rasterization.depth_bias_constant_factor = params.depth_bias_constant_factor;
        state.rasterization.depth_bias_clamp = 0.0;
        state.rasterization.depth_bias_slope_factor = 0.0;
        state.color_attachment_count = 0;
        if dynamic_rendering {
            state.rendering_format = Some(vk::Format::UNDEFINED);
            state.depth_rendering_format = format;
        }
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vertex_module)];
        if let Some(geometry_module) = &geometry_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geometry_module));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *fragment_module));
        let pipeline = create_draw_pipeline(device, *pipeline_layout, render_pass_handle, &stages, &state)?;

        // Command buffers
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let clear_depth = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: INITIAL_CLEAR_DEPTH,
                stencil: 0,
            },
        };

        // `preRenderCommands`
        let pre_render_commands = |cmd: vk::CommandBuffer| {
            transition_2d_image(
                device,
                cmd,
                depth_target_image.get(),
                aspect_bits,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );

            let subresource_range = make_image_subresource_range(aspect_bits, 0, 1, 0, 1);
            unsafe {
                device.cmd_clear_depth_stencil_image(
                    cmd,
                    depth_target_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &vk::ClearDepthStencilValue {
                        depth: INITIAL_CLEAR_DEPTH,
                        stencil: 0,
                    },
                    &[subresource_range],
                );
            }

            transition_2d_image(
                device,
                cmd,
                depth_target_image.get(),
                aspect_bits,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                1,
            );

            let mem_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[mem_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        };

        // `drawCommands`
        let draw_commands = |cmd: vk::CommandBuffer| unsafe {
            if self.dynamic {
                device.cmd_set_depth_clamp_range_ext(
                    cmd,
                    if params.depth_clamp_control.enabled {
                        vk::DepthClampModeEXT::USER_DEFINED_RANGE
                    } else {
                        vk::DepthClampModeEXT::VIEWPORT_RANGE
                    },
                    if params.depth_clamp_control.enabled {
                        Some(&depth_clamp_range)
                    } else {
                        None
                    },
                );
            }

            // if there is more then one viewport we are also checking
            // proper behaviour of cmdSetViewport/Scissor - there was
            // a driver bug that caused invalid behaviour of those
            // functions when firstViewport/Scissor had a non 0 value
            for (index, (viewport, scissor)) in viewport_vect.iter().zip(&scissor_vect).enumerate() {
                device.cmd_set_viewport(cmd, index as u32, &[*viewport]);
                device.cmd_set_scissor(cmd, index as u32, &[*scissor]);
            }

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
        };

        // `beginDynamicRender`
        let begin_dynamic_render = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags| {
            let depth_attachment = vk::RenderingAttachmentInfo::builder()
                .image_view(*depth_target_view)
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_depth)
                .build();
            let rendering_info = vk::RenderingInfo::builder()
                .flags(flags)
                .render_area(render_area)
                .layer_count(1)
                .view_mask(0)
                .depth_attachment(&depth_attachment);
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        };

        // `beginSecondaryCmdBuffer`
        let begin_secondary_cmd_buffer =
            |cmd: vk::CommandBuffer, rendering_flags: vk::RenderingFlags| -> Result<(), TestError> {
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(rendering_flags)
                    .view_mask(0)
                    .depth_attachment_format(format)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(vk::SampleCountFlags::_1);
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

                let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
                if !self
                    .group_params
                    .secondary_cmd_buffer_completely_contains_dynamic_renderpass
                {
                    usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
                }
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(usage_flags)
                    .inheritance_info(&inheritance_info);
                unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
            };

        let mut sec_cmd_buffers = Vec::new();
        if self.group_params.use_secondary_cmd_buffer {
            let sec_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let sec = *sec_cmd_buffer;
            sec_cmd_buffers.push(sec_cmd_buffer);
            let contains = self
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

            // record secondary command buffer
            if contains {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)?;
                begin_dynamic_render(sec, vk::RenderingFlags::empty());
            } else {
                begin_secondary_cmd_buffer(sec, vk::RenderingFlags::empty())?;
            }

            draw_commands(sec);

            if contains {
                end_rendering(device, sec);
            }
            end_command_buffer(device, sec)?;

            // record primary command buffer
            begin_command_buffer(device, *cmd_buffer)?;
            pre_render_commands(*cmd_buffer);

            if !contains {
                begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            unsafe { device.cmd_execute_commands(*cmd_buffer, &[sec]) };

            if !contains {
                end_rendering(device, *cmd_buffer);
            }
            Self::finish_and_copy(
                device,
                *cmd_buffer,
                depth_target_image.get(),
                depth_buffer.get(),
                aspect_bits,
            );
            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;
        } else {
            begin_command_buffer(device, *cmd_buffer)?;
            pre_render_commands(*cmd_buffer);

            if dynamic_rendering {
                begin_dynamic_render(*cmd_buffer, vk::RenderingFlags::empty());
                draw_commands(*cmd_buffer);
                end_rendering(device, *cmd_buffer);
            } else {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass_handle)
                    .framebuffer(framebuffer_handle)
                    .render_area(render_area);
                unsafe { device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
                draw_commands(*cmd_buffer);
                unsafe { device.cmd_end_render_pass(*cmd_buffer) };
            }

            Self::finish_and_copy(
                device,
                *cmd_buffer,
                depth_target_image.get(),
                depth_buffer.get(),
                aspect_bits,
            );
            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;
        }

        unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;

        // Get result
        invalidate_alloc(device, depth_buffer.get_allocation())?;
        let depth_bytes =
            unsafe { std::slice::from_raw_parts(depth_buffer.get_allocation().get_host_ptr(), depth_buffer_size) };
        let texel_size = depth_texel_size(format);

        debug_assert!(
            !is_unorm_depth_format(format)
                || (params.viewport_data[0].expected_value >= 0.0 && params.viewport_data[0].expected_value <= 1.0)
        );

        for (viewport_index, viewport_data) in params.viewport_data.iter().enumerate() {
            let expected_value = viewport_data.expected_value;
            let view_rect = scissor_vect[viewport_index];

            let x_start = view_rect.offset.x as u32;
            let x_end = x_start + view_rect.extent.width;
            let y_start = view_rect.offset.y as u32;
            let y_end = y_start + view_rect.extent.height;

            for y in y_start..y_end {
                for x in x_start..x_end {
                    let offset = (y * WIDTH + x) as usize * texel_size;
                    let value = decode_depth(format, &depth_bytes[offset..offset + texel_size]);
                    if (expected_value - value).abs() >= self.epsilon {
                        return Ok(TestStatus::fail(format!(
                            "Depth value mismatch, expected: {expected_value}, got: {value} at ({x}, {y}, 0)"
                        )));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

impl DepthClampTestInstance<'_> {
    /// The transition of the depth image to TRANSFER_SRC and the copy of its depth aspect into `buffer` that `draw` ends with.
    fn finish_and_copy(
        device: &Device,
        cmd: vk::CommandBuffer,
        image: vk::Image,
        buffer: vk::Buffer,
        aspect_bits: vk::ImageAspectFlags,
    ) {
        transition_2d_image(
            device,
            cmd,
            image,
            aspect_bits,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::PipelineStageFlags::TRANSFER,
            1,
        );

        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
        );
        let to_host = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
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
}

/// `createDepthClampTests`
pub fn create_depth_clamp_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth_clamp");
    let depth_clear_values = depth_clear_values_to_test();

    for (format, format_case_name, epsilon) in DEPTH_STENCIL_IMAGE_FORMATS_TO_TEST {
        // reduce number of tests for dynamic rendering cases where secondary command buffer is used
        if group_params.use_secondary_cmd_buffer && format != vk::Format::D16_UNORM {
            continue;
        }

        for params in &depth_clear_values {
            if params.skip_unorm && is_unorm_depth_format(format) {
                continue;
            }
            let mut test_case_name = format!("{format_case_name}{}", params.test_name_suffix);
            group.add_child(Box::new(DepthClampTest {
                name: test_case_name.clone(),
                params: params.clone(),
                format,
                epsilon,
                group_params,
                dynamic: false,
            }) as Box<dyn TestCase>);
            if !params.depth_clamp_control.enabled {
                continue;
            }
            test_case_name.push_str("_dynamic");
            group.add_child(Box::new(DepthClampTest {
                name: test_case_name,
                params: params.clone(),
                format,
                epsilon,
                group_params,
                dynamic: true,
            }) as Box<dyn TestCase>);
        }
    }
    group
}
