// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineLogicOpTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic pipeline construction type is ported (see
// pipeline/mod.rs). The command buffer is recorded and submitted in `iterate`, not in the instance constructor.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_logic_op::{LOGIC_OP, LOGIC_OP_NA_FORMATS};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, linear_to_srgb};
use crate::tcu::{TestError, TestOutcome, TestStatus, TextureFormat, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::invalidate_alloc;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;

/// `isSupportedColorAttachmentFormat`
fn is_supported_color_attachment_format(context: &Context<'_>, format: vk::Format) -> bool {
    let format_props = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };

    // Format also needs to be INT, UINT, or SINT but as we are the ones setting the
    // color attachment format we only need to check that it is a valid color attachment
    // format here.
    format_props
        .optimal_tiling_features
        .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
}

fn tcu_format_of(format: vk::Format) -> Result<TextureFormat, TestError> {
    map_vk_format(format).ok_or_else(|| TestError::NotSupported(format!("Format {format:?} has no tcu mapping")))
}

/// `calcOpResult`
fn calc_op_result(op: vk::LogicOp, src: u32, dst: u32) -> u32 {
    // See section 29.2 "Logical Operations" in the spec.
    match op {
        vk::LogicOp::CLEAR => 0,
        vk::LogicOp::AND => src & dst,
        vk::LogicOp::AND_REVERSE => src & !dst,
        vk::LogicOp::COPY => src,
        vk::LogicOp::AND_INVERTED => !src & dst,
        vk::LogicOp::NO_OP => dst,
        vk::LogicOp::XOR => src ^ dst,
        vk::LogicOp::OR => src | dst,
        vk::LogicOp::NOR => !(src | dst),
        vk::LogicOp::EQUIVALENT => !(src ^ dst),
        vk::LogicOp::INVERT => !dst,
        vk::LogicOp::OR_REVERSE => src | !dst,
        vk::LogicOp::COPY_INVERTED => !src,
        vk::LogicOp::OR_INVERTED => !src | dst,
        vk::LogicOp::NAND => !(src & dst),
        vk::LogicOp::SET => u32::MAX,
        _ => unreachable!("invalid logic op"),
    }
}

/// `getChannelMask` - a bitmask to filter out unused bits according to the channel size in bytes (e.g. 0xFFu for 8-bit channels).
fn get_channel_mask(channel_size: u32) -> u32 {
    debug_assert!((1..=4).contains(&channel_size));

    let mut mask = 1u64;
    mask <<= channel_size * 8;
    mask -= 1;

    mask as u32
}

const LOGIC_OPS: [(vk::LogicOp, &str); 16] = [
    (vk::LogicOp::CLEAR, "clear"),
    (vk::LogicOp::AND, "and"),
    (vk::LogicOp::AND_REVERSE, "and_reverse"),
    (vk::LogicOp::COPY, "copy"),
    (vk::LogicOp::AND_INVERTED, "and_inverted"),
    (vk::LogicOp::NO_OP, "no_op"),
    (vk::LogicOp::XOR, "xor"),
    (vk::LogicOp::OR, "or"),
    (vk::LogicOp::NOR, "nor"),
    (vk::LogicOp::EQUIVALENT, "equivalent"),
    (vk::LogicOp::INVERT, "invert"),
    (vk::LogicOp::OR_REVERSE, "or_reverse"),
    (vk::LogicOp::COPY_INVERTED, "copy_inverted"),
    (vk::LogicOp::OR_INVERTED, "or_inverted"),
    (vk::LogicOp::NAND, "nand"),
    (vk::LogicOp::SET, "set"),
];

/// What `render` draws: one cleared target and one quad covering it, with the logic operation enabled.
struct RenderParams<'a> {
    format: vk::Format,
    logic_op: vk::LogicOp,
    do_blending: bool,
    clear_value: vk::ClearValue,
    quad_color_bytes: [u8; 16],
    frag_name: &'a str,
}

/// The common part of both test instances: builds the pipeline, records and submits the draw and returns the image bytes.
fn render(context: &Context<'_>, params: &RenderParams<'_>) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let format = params.format;
    let pixel_size = tcu_format_of(format)?
        .pixel_size()
        .ok_or_else(|| TestError::NotSupported("Format has no pixel size".to_string()))?;

    // create color image
    let color_target = ImageWithBuffer::new(
        context,
        RENDER_SIZE,
        RENDER_SIZE,
        format,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        pixel_size,
    )?;

    let render_pass = make_color_render_pass(
        device,
        format,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_target.view], RENDER_SIZE, RENDER_SIZE, 1)?;

    // create pipeline layout
    let push_constant_ranges = [vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::FRAGMENT,
        offset: 0,
        size: 16,
    }];
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("color_vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get(params.frag_name)?)?;

    // create pipeline
    let mut blend_attachment_state = vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::FALSE,
        src_color_blend_factor: vk::BlendFactor::ZERO,
        dst_color_blend_factor: vk::BlendFactor::ZERO,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ZERO,
        dst_alpha_blend_factor: vk::BlendFactor::ZERO,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::R
            | vk::ColorComponentFlags::G
            | vk::ColorComponentFlags::B
            | vk::ColorComponentFlags::A,
    };

    // With logicOp enabled, blendEnable is ignored
    if params.do_blending {
        blend_attachment_state.blend_enable = vk::TRUE;
        blend_attachment_state.src_color_blend_factor = vk::BlendFactor::ZERO;
        blend_attachment_state.dst_color_blend_factor = vk::BlendFactor::ONE;
        blend_attachment_state.color_blend_op = vk::BlendOp::ADD;
        blend_attachment_state.src_alpha_blend_factor = vk::BlendFactor::ZERO;
        blend_attachment_state.dst_alpha_blend_factor = vk::BlendFactor::ONE;
        blend_attachment_state.alpha_blend_op = vk::BlendOp::ADD;
    }

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
    state.logic_op = Some(params.logic_op);
    state.color_blend_attachment = Some(blend_attachment_state);
    let shader_objects = make_shader_objects(
        context,
        "color_vert",
        Some(params.frag_name),
        &[],
        &push_constant_ranges,
    )?;
    let pipeline = if shader_objects.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?)
    };

    // allocate and record command buffer
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let clear_values = [params.clear_value];

    begin_command_buffer(device, *cmd_buffer)?;
    begin_draw(
        device,
        *cmd_buffer,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| **pipeline),
        *render_pass,
        *framebuffer,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        &clear_values,
        &[(color_target.image.get(), *color_target.view)],
    );
    unsafe {
        // Update push constant values
        device.cmd_push_constants(
            *cmd_buffer,
            *pipeline_layout,
            vk::ShaderStageFlags::FRAGMENT,
            0,
            &params.quad_color_bytes,
        );

        device.cmd_draw(*cmd_buffer, 4, 1, 0, 0);
    }
    end_draw(device, *cmd_buffer, shader_objects.is_some());
    copy_image_to_buffer(
        device,
        *cmd_buffer,
        color_target.image.get(),
        color_target.buffer.get(),
        RENDER_SIZE,
        RENDER_SIZE,
    );
    end_command_buffer(device, *cmd_buffer)?;

    submit_commands_and_wait(device, queue, *cmd_buffer)?;

    let alloc = color_target.buffer.get_allocation();
    invalidate_alloc(device, alloc)?;
    let size = (RENDER_SIZE * RENDER_SIZE * pixel_size) as usize;
    Ok(unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), size) }.to_vec())
}

fn u32x4_bytes(color: [u32; 4]) -> [u8; 16] {
    let mut bytes = [0u8; 16];
    for (chunk, value) in bytes.chunks_exact_mut(4).zip(color) {
        chunk.copy_from_slice(&value.to_ne_bytes());
    }
    bytes
}

fn f32x4_bytes(color: [f32; 4]) -> [u8; 16] {
    let mut bytes = [0u8; 16];
    for (chunk, value) in bytes.chunks_exact_mut(4).zip(color) {
        chunk.copy_from_slice(&value.to_ne_bytes());
    }
    bytes
}

#[derive(Clone, Copy)]
struct TestParams {
    logic_op: vk::LogicOp,
    fb_color: [u32; 4],   // Framebuffer color.
    quad_color: [u32; 4], // Geometry color.
    format: vk::Format,   // Framebuffer format.
}

struct LogicOpTest {
    name: &'static str,
    params: TestParams,
}

impl TestCase for LogicOpTest {
    fn name(&self) -> &str {
        self.name
    }

    /// `LogicOpTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().logic_op == vk::FALSE {
            return Err(TestError::NotSupported("Logic operations not supported".to_string()));
        }

        if !is_supported_color_attachment_format(context, self.params.format) {
            return Err(TestError::NotSupported(format!(
                "Unsupported color attachment format: {:?}",
                self.params.format
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        LOGIC_OP.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LogicOpTestInstance {
            context,
            params: self.params,
        })
    }
}

struct LogicOpTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for LogicOpTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let tcu_format = tcu_format_of(params.format)?;
        let num_channels = tcu_format.order.num_used_channels() as usize;
        let channel_size = tcu_format
            .type_
            .channel_size()
            .ok_or_else(|| TestError::NotSupported("Format has no channel size".to_string()))?;
        let channel_mask = get_channel_mask(channel_size);

        // Prepare clear color value and quad color taking into account the channel mask.
        let mut attachment_clear_color = [0u32; 4];
        let mut quad_color = [0u32; 4];

        for c in 0..num_channels {
            attachment_clear_color[c] = params.fb_color[c] & channel_mask;
        }

        for c in 0..num_channels {
            quad_color[c] = params.quad_color[c] & channel_mask;
        }

        let result_bytes = render(
            self.context,
            &RenderParams {
                format: params.format,
                logic_op: params.logic_op,
                do_blending: false,
                clear_value: vk::ClearValue {
                    color: vk::ClearColorValue {
                        uint32: attachment_clear_color,
                    },
                },
                quad_color_bytes: u32x4_bytes(quad_color),
                frag_name: "color_frag",
            },
        )?;

        // Verify the image
        let result_access = ConstPixelBufferAccess::new(tcu_format, [RENDER_SIZE, RENDER_SIZE, 1], &result_bytes);
        let mut expected_color = [0u32; 4]; // Overwritten below.

        // Calculate proper expected color values.
        for c in 0..num_channels {
            expected_color[c] = calc_op_result(params.logic_op, params.quad_color[c], params.fb_color[c]);
            expected_color[c] &= channel_mask;
        }

        // Exact results.
        for y in 0..RENDER_SIZE {
            for x in 0..RENDER_SIZE {
                let pixel = result_access.get_pixel_uint(x, y, 0);
                if pixel[..num_channels] != expected_color[..num_channels] {
                    return Ok(TestStatus::fail(
                        "Result does not match expected values; check log for details",
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

#[derive(Clone, Copy)]
struct TestParamsMisc {
    logic_op: vk::LogicOp,
    fb_color: [f32; 4],   // Framebuffer color.
    quad_color: [f32; 4], // Geometry color.
    format: vk::Format,   // Framebuffer format.
    do_blending: bool,    // Enable blending
}

struct LogicOpInapplicableFormatsTest {
    name: String,
    params: TestParamsMisc,
}

impl TestCase for LogicOpInapplicableFormatsTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `LogicOpInapplicableFormatsTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().logic_op == vk::FALSE {
            return Err(TestError::NotSupported("Logic operations not supported".to_string()));
        }

        if !is_supported_color_attachment_format(context, self.params.format) {
            return Err(TestError::NotSupported(format!(
                "Unsupported color attachment format: {:?}",
                self.params.format
            )));
        }

        if self.params.do_blending {
            let format_props = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), self.params.format)
            };

            if !format_props
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT_BLEND)
            {
                return Err(TestError::NotSupported("Format does not support blending".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        LOGIC_OP_NA_FORMATS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LogicOpInapplicableFormatsTestInstance {
            context,
            params: self.params,
        })
    }
}

struct LogicOpInapplicableFormatsTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParamsMisc,
}

impl TestInstance for LogicOpInapplicableFormatsTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let tcu_format = tcu_format_of(params.format)?;
        let num_components = tcu_format.order.num_used_channels();
        let frag_name = format!("color_frag_{num_components}");

        let result_bytes = render(
            self.context,
            &RenderParams {
                format: params.format,
                logic_op: params.logic_op,
                do_blending: params.do_blending,
                clear_value: vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: params.fb_color,
                    },
                },
                quad_color_bytes: f32x4_bytes(params.quad_color),
                frag_name: &frag_name,
            },
        )?;

        // Verify the image
        let result_access = ConstPixelBufferAccess::new(tcu_format, [RENDER_SIZE, RENDER_SIZE, 1], &result_bytes);
        let expected_color = if tcu_format.order.is_srgb() {
            linear_to_srgb(params.quad_color)
        } else {
            params.quad_color
        };
        let mut reference_texture = TextureLevel::new(tcu_format, RENDER_SIZE, RENDER_SIZE, 1)?;
        {
            let mut reference_access = reference_texture.get_access();
            for y in 0..RENDER_SIZE {
                for x in 0..RENDER_SIZE {
                    reference_access.set_pixel(expected_color, x, y, 0);
                }
            }
        }

        if !float_threshold_compare(&reference_texture.get_const_access(), &result_access, [0.01; 4]).ok {
            return Ok(TestStatus::fail(
                "Result does not match expected values; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createLogicOpTests`
pub fn create_logic_op_tests() -> TestCaseGroup {
    let mut logic_op_tests = TestCaseGroup::new("logic_op");

    // 4 bits are enough to check all possible combinations of logical operation inputs at once, for example s AND d:
    //
    //        1 0 1 0
    //    AND    1 1 0 0
    //    ------------
    //        1 0 0 0
    //
    // However, we will choose color values such that both higher bits and lower bits are used, and the implementation will not be
    // able to mix channels by mistake.
    //
    //    0011 0101 1010 1100
    //    3    5    a    c
    //    0101 0011 1100 1010
    //    5    3    c    a
    let quad_color = [0x35acu32, 0x5ac3, 0xac35, 0xc35a];
    let fb_color = [0x53cau32, 0x3ca5, 0xca53, 0xa53c];

    let format_list = [
        (vk::Format::R8_UINT, "r8_uint"),
        (vk::Format::R8G8_UINT, "r8g8_uint"),
        (vk::Format::R8G8B8_UINT, "r8g8b8_uint"),
        (vk::Format::B8G8R8_UINT, "b8g8r8_uint"),
        (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
        (vk::Format::B8G8R8A8_UINT, "b8g8r8a8_uint"),
        (vk::Format::R16_UINT, "r16_uint"),
        (vk::Format::R16G16_UINT, "r16g16_uint"),
        (vk::Format::R16G16B16_UINT, "r16g16b16_uint"),
        (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
        (vk::Format::R32_UINT, "r32_uint"),
        (vk::Format::R32G32_UINT, "r32g32_uint"),
        (vk::Format::R32G32B32_UINT, "r32g32b32_uint"),
        (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
    ];

    for (format, format_name) in format_list {
        let mut format_group = TestCaseGroup::new(format_name);

        for (logic_op, name) in LOGIC_OPS {
            let params = TestParams {
                logic_op,
                fb_color,
                quad_color,
                format,
            };
            format_group.add_child(Box::new(LogicOpTest { name, params }) as Box<dyn TestCase>);
        }

        logic_op_tests.add_child(format_group);
    }

    logic_op_tests
}

/// `createLogicOpInapplicableFormatsTests`
pub fn create_logic_op_inapplicable_formats_tests() -> TestCaseGroup {
    let mut logic_op_tests = TestCaseGroup::new("logic_op_na_formats");

    let quad_color = [0.00f32, 0.40, 0.80, 0.10];
    let fb_color = [0.50f32, 0.10, 0.90, 0.20];

    let format_list = [
        // Float
        (vk::Format::R16_SFLOAT, "r16_sfloat"),
        (vk::Format::R16G16_SFLOAT, "r16g16_sfloat"),
        (vk::Format::R16G16B16_SFLOAT, "r16g16b16_sfloat"),
        (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
        (vk::Format::R32_SFLOAT, "r32_sfloat"),
        (vk::Format::R32G32_SFLOAT, "r32g32_sfloat"),
        (vk::Format::R32G32B32_SFLOAT, "r32g32b32_sfloat"),
        (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
        (vk::Format::R64_SFLOAT, "r64_sfloat"),
        (vk::Format::R64G64_SFLOAT, "r64g64_sfloat"),
        (vk::Format::R64G64B64_SFLOAT, "r64g64b64_sfloat"),
        (vk::Format::R64G64B64A64_SFLOAT, "r64g64b64a64_sfloat"),
        // sRGB
        (vk::Format::R8_SRGB, "r8_srgb"),
        (vk::Format::R8G8_SRGB, "r8g8_srgb"),
        (vk::Format::R8G8B8_SRGB, "r8g8b8_srgb"),
        (vk::Format::B8G8R8_SRGB, "b8g8r8_srgb"),
        (vk::Format::R8G8B8A8_SRGB, "r8g8b8a8_srgb"),
        (vk::Format::B8G8R8A8_SRGB, "b8g8r8a8_srgb"),
    ];

    for (format, format_name) in format_list {
        let mut format_group = TestCaseGroup::new(format_name);

        for (logic_op, name) in LOGIC_OPS {
            for do_blending in [false, true] {
                let params = TestParamsMisc {
                    logic_op,
                    fb_color,
                    quad_color,
                    format,
                    do_blending,
                };
                let test_name = format!("{name}{}", if do_blending { "_blend" } else { "_noblend" });
                format_group.add_child(Box::new(LogicOpInapplicableFormatsTest {
                    name: test_name,
                    params,
                }) as Box<dyn TestCase>);
            }
        }

        logic_op_tests.add_child(format_group);
    }

    logic_op_tests
}
