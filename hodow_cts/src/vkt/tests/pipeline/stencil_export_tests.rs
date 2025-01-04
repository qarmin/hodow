// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineStencilExportTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `op_replace_early_and_late` (VK_AMD_shader_early_and_late_fragment_tests) has six hand
// written SPIR-V assembly fragment shaders, in `pipeline_stencil_export_early_late.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_stencil_export::STENCIL_EXPORT;
use crate::generated::shaders::pipeline_stencil_export_early_late::STENCIL_EXPORT_EARLY_LATE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_dynamic_rendering, begin_dynamic_rendering_with_load_ops, end_dynamic_rendering,
    make_shader_objects,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 128;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.5, 0.5, 0.5, 1.0];
const PATTERN_SIZE: u32 = 1 << 4;

/// The number of `ExecutionModeEarlyAndLate` values: the six stencil reference modes of VK_AMD_shader_early_and_late_fragment_tests.
const MODE_COUNT_AMD: u32 = 6;

const EXECUTION_MODE_STENCIL: [&str; MODE_COUNT_AMD as usize] = [
    "StencilRefGreaterFrontAMD",
    "StencilRefLessFrontAMD",
    "StencilRefGreaterBackAMD",
    "StencilRefLessBackAMD",
    "StencilRefUnchangedFrontAMD",
    "StencilRefUnchangedBackAMD",
];

struct StencilExportCase {
    name: &'static str,
    stencil_format: vk::Format,
    early_and_late: bool,
}

impl TestCase for StencilExportCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_stencil_export")?;

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.stencil_format)
        };
        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Err(TestError::NotSupported("Image format not supported".to_string()));
        }

        if self.early_and_late {
            context.require_device_functionality("VK_AMD_shader_early_and_late_fragment_tests")?;
            let mut early_late_features = vk::PhysicalDeviceShaderEarlyAndLateFragmentTestsFeaturesAMD::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut early_late_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if early_late_features.shader_early_and_late_fragment_tests == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderEarlyAndLateFragmentTests is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.early_and_late {
            STENCIL_EXPORT_EARLY_LATE.programs
        } else {
            STENCIL_EXPORT.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StencilExportInstance {
            context,
            stencil_format: self.stencil_format,
            early_and_late: self.early_and_late,
        })
    }
}

struct StencilExportInstance<'a> {
    context: &'a Context<'a>,
    stencil_format: vk::Format,
    early_and_late: bool,
}

/// `makeTestRenderPass`: subpass 0 writes the stencil only, subpass 1 writes the colour while testing against it.
fn make_test_render_pass<'a>(
    device: &'a Device,
    color_format: vk::Format,
    stencil_format: vk::Format,
) -> Result<crate::vk::ref_util::Unique<'a, vk::RenderPass>, TestError> {
    let attachment_descriptions = [
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
            .format(stencil_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build(),
    ];

    let color_attachment_references = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let stencil_attachment_reference = vk::AttachmentReference::builder()
        .attachment(1)
        .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();

    let subpasses = [
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .depth_stencil_attachment(&stencil_attachment_reference)
            .build(),
        vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_references)
            .depth_stencil_attachment(&stencil_attachment_reference)
            .build(),
    ];

    let dependencies = [vk::SubpassDependency::builder()
        .src_subpass(0)
        .dst_subpass(1)
        .src_stage_mask(vk::PipelineStageFlags::LATE_FRAGMENT_TESTS)
        .dst_stage_mask(vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS)
        .src_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
        .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ)
        .dependency_flags(vk::DependencyFlags::empty())
        .build()];

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses)
        .dependencies(&dependencies);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(crate::vk::ref_util::Unique::new(device, render_pass))
}

/// The state `preparePipelineWrapper` gives the pipeline of one subpass.
fn pipeline_state(subpass: u32, use_color: bool, early_late: bool) -> DrawPipelineState {
    let stencil_op_state = if use_color {
        vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::EQUAL)
            .compare_mask(0xff)
            .write_mask(0)
            .reference(0)
            .build()
    } else {
        vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::REPLACE)
            .pass_op(if early_late {
                vk::StencilOp::KEEP
            } else {
                vk::StencilOp::REPLACE
            })
            .depth_fail_op(if early_late {
                vk::StencilOp::KEEP
            } else {
                vk::StencilOp::REPLACE
            })
            .compare_op(if early_late {
                vk::CompareOp::EQUAL
            } else {
                vk::CompareOp::NEVER
            })
            .compare_mask(0xff)
            .write_mask(0xff)
            .reference(1)
            .build()
    };

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
    state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::NEVER)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(true)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build();
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0)
        .build();
    state.subpass = subpass;
    state.color_attachment_count = if use_color { 1 } else { 0 };
    state
}

/// `preparePipelineWrapper` for a monolithic pipeline.
fn prepare_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    subpass: u32,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    use_color: bool,
    early_late: bool,
) -> Result<crate::vk::ref_util::Unique<'a, vk::Pipeline>, TestError> {
    let state = pipeline_state(subpass, use_color, early_late);
    create_draw_pipeline(
        device,
        layout,
        render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, fragment_module),
        ],
        &state,
    )
}

/// `generateReferenceImage`: a checkerboard of `PATTERN_SIZE` squares, `color` where `(i + j)` is even. Returns RGBA8 bytes.
fn generate_reference_image() -> Vec<u8> {
    let to_byte = |value: f32| (value * 255.0).round() as u8;
    let clear = [
        to_byte(CLEAR_COLOR[0]),
        to_byte(CLEAR_COLOR[1]),
        to_byte(CLEAR_COLOR[2]),
        to_byte(CLEAR_COLOR[3]),
    ];
    let color = [0u8, 0, 255, 255];
    let mut image = Vec::with_capacity((RENDER_SIZE * RENDER_SIZE * 4) as usize);
    for y in 0..RENDER_SIZE {
        for x in 0..RENDER_SIZE {
            let (i, j) = (y / PATTERN_SIZE, x / PATTERN_SIZE);
            image.extend_from_slice(if (i + j) % 2 == 0 { &color } else { &clear });
        }
    }
    image
}

impl TestInstance for StencilExportInstance<'_> {
    /// `testStencilExportReplace`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        // Draw two subpasses: first write the stencil data, then use that data when writing color. The first pass produces a
        // checkerboard stencil by having the shader fill gl_FragStencilRefARB with 0 or 1 and using OP_REPLACE to write those
        // values; the second pass uses the stencil with a compare operation EQUAL with reference value 0.
        let stencil_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(self.stencil_format)
            .extent(vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let stencil_image = ImageWithMemory::new(device, allocator, stencil_info, MemoryRequirement::ANY)?;
        let stencil_attachment = make_image_view(
            device,
            stencil_image.get(),
            vk::ImageViewType::_2D,
            self.stencil_format,
            make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1),
        )?;

        let color = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_color_module = create_shader_module(device, binaries.get("frag-color")?)?;

        let render_pass = make_test_render_pass(device, COLOR_FORMAT, self.stencil_format)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let color_objects = make_shader_objects(context, "vert", Some("frag-color"), &[], &[])?;
        let color_state = pipeline_state(1, true, false);
        let color_pipeline = if color_objects.is_some() {
            None
        } else {
            Some(prepare_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                1,
                *vertex_module,
                *fragment_color_module,
                true,
                false,
            )?)
        };
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color.view, *stencil_attachment],
            RENDER_SIZE,
            RENDER_SIZE,
            1,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let reference = generate_reference_image();

        let stencil_mode_count = if self.early_and_late { MODE_COUNT_AMD } else { 1 };
        for stencil_mode_ndx in 0..stencil_mode_count {
            let fragment_stencil_module =
                create_shader_module(device, binaries.get(&format!("frag-stencil{stencil_mode_ndx}"))?)?;
            let stencil_program = format!("frag-stencil{stencil_mode_ndx}");
            let stencil_objects = make_shader_objects(context, "vert", Some(stencil_program.as_str()), &[], &[])?;
            let stencil_state = pipeline_state(0, false, self.early_and_late);
            let stencil_pipeline = if stencil_objects.is_some() {
                None
            } else {
                Some(prepare_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    0,
                    *vertex_module,
                    *fragment_stencil_module,
                    false,
                    self.early_and_late,
                )?)
            };

            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;

            begin_command_buffer(device, cmd)?;
            // With the early and late tests the stencil is cleared to 1, which the modes' EQUAL compare then keeps or replaces.
            let stencil_clear = if self.early_and_late { 1 } else { 0 };
            let clear_values = [
                clear_value_color(CLEAR_COLOR),
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: 0.0,
                        stencil: stencil_clear,
                    },
                },
            ];
            if let (Some(stencil_objects), Some(color_objects)) = (&stencil_objects, &color_objects) {
                // The two subpasses become two renderings with the dependency between them as a barrier.
                let to_attachment = [
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        color.image.get(),
                        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        stencil_image.get(),
                        make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1),
                    ),
                ];
                let stencil_attachment_info = RenderingAttachment {
                    view: *stencil_attachment,
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    clear_value: clear_values[1],
                };
                let subpass_dependency = make_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
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
                    cmd,
                    rect_2d(RENDER_SIZE, RENDER_SIZE),
                    &[],
                    None,
                    Some(stencil_attachment_info),
                );
                stencil_objects.bind(cmd, &stencil_state);
                unsafe { device.cmd_draw(cmd, 6, 1, 0, 0) };
                end_dynamic_rendering(device, cmd);
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                        vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                        vk::DependencyFlags::empty(),
                        &[subpass_dependency],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
                begin_dynamic_rendering_with_load_ops(
                    device,
                    cmd,
                    rect_2d(RENDER_SIZE, RENDER_SIZE),
                    &[RenderingAttachment {
                        view: *color.view,
                        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        clear_value: clear_values[0],
                    }],
                    None,
                    Some(stencil_attachment_info),
                    vk::AttachmentLoadOp::CLEAR,
                    vk::AttachmentLoadOp::LOAD,
                );
                color_objects.bind(cmd, &color_state);
                unsafe { device.cmd_draw(cmd, 6, 1, 0, 0) };
                end_dynamic_rendering(device, cmd);
            } else if let (Some(stencil_pipeline), Some(color_pipeline)) = (&stencil_pipeline, &color_pipeline) {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                    .clear_values(&clear_values);
                unsafe {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, stencil_pipeline.get());
                    device.cmd_draw(cmd, 6, 1, 0, 0);
                    device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, color_pipeline.get());
                    device.cmd_draw(cmd, 6, 1, 0, 0);
                    device.cmd_end_render_pass(cmd);
                }
            }
            copy_image_to_buffer(
                device,
                cmd,
                color.image.get(),
                color.buffer.get(),
                RENDER_SIZE,
                RENDER_SIZE,
            );
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

            // Compare the resulting color buffer.
            let result = color.read_bytes(device)?;
            let threshold = 0.02f32;
            let matches = result
                .iter()
                .zip(reference.iter())
                .all(|(&got, &expected)| (got as f32 / 255.0 - expected as f32 / 255.0).abs() <= threshold);
            if !matches {
                let suffix = if self.early_and_late {
                    format!(
                        " for OpExecutionMode: {}",
                        EXECUTION_MODE_STENCIL[stencil_mode_ndx as usize]
                    )
                } else {
                    String::new()
                };
                return Err(TestError::Fail(format!("Rendered image is not correct{suffix}")));
            }
        }
        Ok(TestStatus::pass("OK"))
    }
}

/// `createStencilExportTests`
pub fn create_stencil_export_tests() -> TestCaseGroup {
    let formats = [
        (vk::Format::S8_UINT, "s8_uint"),
        (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
        (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
    ];

    let mut group = TestCaseGroup::new("shader_stencil_export");
    for (stencil_format, name) in formats {
        let mut format_group = TestCaseGroup::new(name);
        format_group.add_child(Box::new(StencilExportCase {
            name: "op_replace",
            stencil_format,
            early_and_late: false,
        }) as Box<dyn TestCase>);
        format_group.add_child(Box::new(StencilExportCase {
            name: "op_replace_early_and_late",
            stencil_format,
            early_and_late: true,
        }) as Box<dyn TestCase>);
        group.add_child(format_group);
    }
    group
}
