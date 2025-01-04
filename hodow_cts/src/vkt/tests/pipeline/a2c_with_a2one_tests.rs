// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleTests.cpp (A2CplusA2One*, the `a2c_with_a2one` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The result is compared byte by byte (the colours
// are 0 and 1 only, so the comparison is exact, as the zero threshold of upstream says).
//
// Alpha to one with alpha to coverage. If an implementation doesn't do the operations in the right order, it will fail a
// trivial test: color all samples with a value that has alpha 0.0, and alpha to one will replace the alpha with 1.0. Then,
// alpha to coverage will result in the samples being covered. When using the right order, no samples should have coverage
// because the alpha to coverage tests should happen first, and there will be no samples to modify to set the alpha to 1.0.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, ExtExtendedDynamicState3ExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_a2c_with_a2one::{A2C_A2ONE, A2C_A2ONE_DEPTH};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{end_dynamic_rendering, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `A2CplusA2OneParams`, without the construction type
#[derive(Clone, Copy)]
struct A2cPlusA2OneParams {
    dynamic_a2c: bool,
    dynamic_a2one: bool,
    export_frag_depth: bool,
    sample_shading_enable: bool,
}

struct A2cPlusA2OneCase {
    name: String,
    params: A2cPlusA2OneParams,
}

impl TestCase for A2cPlusA2OneCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `A2CplusA2OneSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.alpha_to_one == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::alphaToOne".to_string(),
            ));
        }

        if self.params.sample_shading_enable && features.sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::sampleRateShading".to_string(),
            ));
        }

        if self.params.dynamic_a2c || self.params.dynamic_a2one {
            context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;

            let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds3_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };

            if self.params.dynamic_a2c && eds3_features.extended_dynamic_state3_alpha_to_coverage_enable == vk::FALSE {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3AlphaToCoverageEnable not supported".to_string(),
                ));
            }

            if self.params.dynamic_a2one && eds3_features.extended_dynamic_state3_alpha_to_one_enable == vk::FALSE {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3AlphaToOneEnable not supported".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.export_frag_depth {
            A2C_A2ONE_DEPTH.programs
        } else {
            A2C_A2ONE.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(A2cPlusA2OneInstance {
            context,
            params: self.params,
        })
    }
}

struct A2cPlusA2OneInstance<'a> {
    context: &'a Context<'a>,
    params: A2cPlusA2OneParams,
}

impl TestInstance for A2cPlusA2OneInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        a2c_plus_a2one_run(self.context, &self.params)
    }
}

fn make_image<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: 1,
            height: 1,
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

/// `A2CplusA2OneRun`
fn a2c_plus_a2one_run<'a>(context: &'a Context<'a>, params: &A2cPlusA2OneParams) -> TestOutcome {
    let device = context.get_device();
    let color_format = vk::Format::R8G8B8A8_UNORM;
    let depth_format = vk::Format::D16_UNORM;
    let sample_count = vk::SampleCountFlags::_4;
    let clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let geom_color = [1.0f32, 1.0, 1.0, 0.0]; // Note geometry color has alpha 0.0.
    let clear_depth = 1.0f32;
    let geom_depth = 0.0f32;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

    // Color buffer and resolve attachment with verification buffer.
    let color_buffer = make_image(
        context,
        color_format,
        sample_count,
        vk::ImageUsageFlags::COLOR_ATTACHMENT,
    )?;
    let color_view = make_image_view(
        device,
        color_buffer.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;

    let depth_buffer = if params.export_frag_depth {
        Some(make_image(
            context,
            depth_format,
            sample_count,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
        )?)
    } else {
        None
    };
    let depth_view = match &depth_buffer {
        Some(buffer) => Some(make_image_view(
            device,
            buffer.get(),
            vk::ImageViewType::_2D,
            depth_format,
            depth_srr,
        )?),
        None => None,
    };

    // Resolve buffer, single sample.
    let resolve_buffer = make_image(
        context,
        color_format,
        vk::SampleCountFlags::_1,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
    )?;
    let resolve_view = make_image_view(
        device,
        resolve_buffer.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;
    let verification_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Push constants: the structure has to match the shader push constant declaration.
    let pc_data: Vec<u8> = geom_color
        .iter()
        .chain(std::iter::once(&geom_depth))
        .flat_map(|value| value.to_ne_bytes())
        .collect();
    let pc_stages = vk::ShaderStageFlags::FRAGMENT;
    let pc_ranges = [vk::PushConstantRange {
        stage_flags: pc_stages,
        offset: 0,
        size: pc_data.len() as u32,
    }];
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&pc_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let mut att_descs = vec![
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: color_format,
            samples: sample_count,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::DONT_CARE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        },
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: color_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::DONT_CARE,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        },
    ];

    let color_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let resolve_ref = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let depth_ref = vk::AttachmentReference {
        attachment: 2,
        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };

    if params.export_frag_depth {
        att_descs.push(vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: depth_format,
            samples: sample_count,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        });
    }

    let mut subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_ref)
        .resolve_attachments(&resolve_ref);
    if params.export_frag_depth {
        subpass = subpass.depth_stencil_attachment(&depth_ref);
    }
    let subpasses = [subpass.build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&att_descs)
        .subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let mut fb_views = vec![*color_view, *resolve_view];
    if let Some(view) = &depth_view {
        fb_views.push(**view);
    }
    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .attachments(&fb_views)
        .width(1)
        .height(1)
        .layers(1);
    let framebuffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    // Modules.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(1, 1);
    state.samples = sample_count;
    state.sample_shading = params.sample_shading_enable;
    state.min_sample_shading = 1.0;
    state.alpha_to_coverage_enable = !params.dynamic_a2c;
    state.alpha_to_one_enable = !params.dynamic_a2one;
    if params.dynamic_a2c {
        state
            .dynamic_states
            .push(vk::DynamicState::ALPHA_TO_COVERAGE_ENABLE_EXT);
    }
    if params.dynamic_a2one {
        state.dynamic_states.push(vk::DynamicState::ALPHA_TO_ONE_ENABLE_EXT);
    }
    if params.export_frag_depth {
        let stencil_state = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::KEEP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::NEVER,
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        };
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_state)
            .back(stencil_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(0.0)
            .build();
    }
    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &pc_ranges)?;
    let pipeline = if shader_objects.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?)
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let mut clear_values = vec![clear_value_color(clear_color)];
    if params.export_frag_depth {
        // We need this extra clear color value because clear values are indexed by attachment index.
        clear_values.push(clear_value_color(clear_color));
        clear_values.push(vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: clear_depth,
                stencil: 0,
            },
        });
    }
    if let Some(objects) = &shader_objects {
        let mut to_attachment = vec![
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.get(),
                color_srr,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                resolve_buffer.get(),
                color_srr,
            ),
        ];
        if let Some(buffer) = &depth_buffer {
            to_attachment.push(make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                buffer.get(),
                depth_srr,
            ));
        }
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
        let color_rendering = [vk::RenderingAttachmentInfo::builder()
            .image_view(*color_view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::AVERAGE)
            .resolve_image_view(*resolve_view)
            .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .clear_value(clear_values[0])
            .build()];
        let depth_rendering = depth_view.as_ref().map(|view| {
            vk::RenderingAttachmentInfo::builder()
                .image_view(**view)
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_values[2])
                .build()
        });
        let mut rendering_info = vk::RenderingInfo::builder()
            .render_area(rect_2d(1, 1))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_rendering);
        if let Some(depth_rendering) = &depth_rendering {
            rendering_info = rendering_info.depth_attachment(depth_rendering);
        }
        unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        objects.bind(cmd, &state);
        unsafe {
            device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, &pc_data);
            if params.dynamic_a2c {
                device.cmd_set_alpha_to_coverage_enable_ext(cmd, true);
            }
            if params.dynamic_a2one {
                device.cmd_set_alpha_to_one_enable_ext(cmd, true);
            }
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_dynamic_rendering(device, cmd);
    } else if let Some(pipeline) = &pipeline {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(1, 1))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);
            device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, &pc_data);
            if params.dynamic_a2c {
                device.cmd_set_alpha_to_coverage_enable_ext(cmd, true);
            }
            if params.dynamic_a2one {
                device.cmd_set_alpha_to_one_enable_ext(cmd, true);
            }
            device.cmd_draw(cmd, 3, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }
    copy_image_to_buffer(device, cmd, resolve_buffer.get(), verification_buffer.get(), 1, 1);
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // Verify color output.
    invalidate_alloc(device, verification_buffer.get_allocation())?;
    let result =
        unsafe { std::slice::from_raw_parts(verification_buffer.get_allocation().get_host_ptr().cast_const(), 4) };
    let reference = clear_color.map(|channel| (channel * 255.0).round() as u8);
    if result != reference {
        return Err(TestError::Fail(
            "Unexpected color in result buffer; check log for details".to_string(),
        ));
    }

    drop((depth_buffer, depth_view));
    Ok(TestStatus::pass("Pass"))
}

/// The `a2c_with_a2one` child of upstream's `multisample` group.
pub(super) fn add_a2c_with_a2one_tests(multisample_tests: &mut TestCaseGroup) {
    let mut a2c_with_a2one_group = TestCaseGroup::new("a2c_with_a2one");
    for dynamic_a2c in [false, true] {
        for dynamic_a2one in [false, true] {
            for export_frag_depth in [false, true] {
                for sample_rate_shading_enable in [false, true] {
                    let params = A2cPlusA2OneParams {
                        dynamic_a2c,
                        dynamic_a2one,
                        export_frag_depth,
                        sample_shading_enable: sample_rate_shading_enable,
                    };

                    let mut test_name = String::new();
                    if dynamic_a2c {
                        test_name += "dynamic_a2c";
                    }
                    if dynamic_a2one {
                        test_name += &format!("{}dynamic_a2one", if test_name.is_empty() { "" } else { "_" });
                    }
                    if test_name.is_empty() {
                        test_name = "static".to_string();
                    }

                    if params.export_frag_depth {
                        test_name += "_export_frag_depth";
                    }

                    if params.sample_shading_enable {
                        test_name += "_with_sample_rate_shading";
                    }

                    a2c_with_a2one_group.add_child(Box::new(A2cPlusA2OneCase {
                        name: test_name,
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }

    multisample_tests.add_child(a2c_with_a2one_group);
}
