// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineBlendTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `blend.dynamic_dual_disable`: attachments that alternate between a dual source blend
// equation with blending disabled and a plain one, set as dynamic state with a pipeline whose static blend state is dual source on every
// attachment. The fragment shaders are in `shaders/manifest/pipeline_blend_dynamic.toml`, one per attachment count.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtColorWriteEnableExtensionDeviceCommands, ExtExtendedDynamicState3ExtensionDeviceCommands,
    InstanceV1_1, KhrDynamicRenderingLocalReadExtensionDeviceCommands,
};

use crate::generated::shaders::pipeline_blend_dynamic::{
    DUAL_DISABLE_1, DUAL_DISABLE_2, DUAL_DISABLE_3, DUAL_DISABLE_8, DUAL_DISABLE_9, REMAP,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `DynamicDualBlendDisableParams`
#[derive(Clone, Copy)]
struct DynamicDualBlendDisableParams {
    construction: PipelineConstructionType,
    attachment_count: u32,
    /// Used to have more dual blend attachments.
    extra_attachment: bool,
}

impl DynamicDualBlendDisableParams {
    fn actual_attachment_count(&self) -> u32 {
        self.attachment_count + u32::from(self.extra_attachment)
    }

    fn out_colors(&self) -> [[u8; 4]; 9] {
        [
            [0, 0, 255, 255],
            [0, 255, 255, 255],
            [255, 255, 0, 255],
            [255, 255, 255, 255],
            [0, 0, 255, 255],
            [0, 255, 255, 255],
            [255, 255, 0, 255],
            [255, 255, 255, 255],
            [0, 0, 255, 255],
        ]
    }
}

struct DynamicDualBlendDisableCase {
    name: String,
    params: DynamicDualBlendDisableParams,
}

impl TestCase for DynamicDualBlendDisableCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DynamicDualBlendDisableCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds3_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if eds3_features.extended_dynamic_state3_color_blend_enable == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState3ColorBlendEnable not supported".to_string(),
            ));
        }
        if eds3_features.extended_dynamic_state3_color_blend_equation == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState3ColorBlendEquation not supported".to_string(),
            ));
        }
        if eds3_features.extended_dynamic_state3_color_write_mask == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState3ColorWriteMask not supported".to_string(),
            ));
        }

        check_pipeline_construction_requirements(context, self.params.construction)?;

        if context.get_device_features().dual_src_blend == vk::FALSE {
            return Err(TestError::NotSupported("dualSrcBlend not supported".to_string()));
        }

        let limits = &context.get_device_properties().limits;
        if limits.max_fragment_dual_src_attachments < self.params.attachment_count {
            return Err(TestError::NotSupported(
                "maxFragmentDualSrcAttachments too low".to_string(),
            ));
        }
        if limits.max_color_attachments < self.params.actual_attachment_count() {
            return Err(TestError::NotSupported("maxColorAttachments too low".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.actual_attachment_count() {
            1 => DUAL_DISABLE_1.programs,
            2 => DUAL_DISABLE_2.programs,
            3 => DUAL_DISABLE_3.programs,
            8 => DUAL_DISABLE_8.programs,
            _ => DUAL_DISABLE_9.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicDualBlendDisableInstance {
            context,
            params: self.params,
        })
    }
}

struct DynamicDualBlendDisableInstance<'a> {
    context: &'a Context<'a>,
    params: DynamicDualBlendDisableParams,
}

impl TestInstance for DynamicDualBlendDisableInstance<'_> {
    /// `DynamicDualBlendDisableInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = self.params;
        let attachment_count = params.actual_attachment_count();
        let extent = 1u32;

        let mut color_buffers = Vec::new();
        for _ in 0..attachment_count {
            color_buffers.push(ImageWithBuffer::new(
                context,
                extent,
                extent,
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                4,
            )?);
        }

        // Render pass and framebuffer. All attachments will be identical.
        let attachment_description = vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build();
        let attachment_descriptions = vec![attachment_description; attachment_count as usize];
        let attachment_references: Vec<vk::AttachmentReference> = (0..attachment_count)
            .map(|i| vk::AttachmentReference {
                attachment: i,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            })
            .collect();
        let subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&attachment_references);
        let subpasses = [subpass.build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let views: Vec<vk::ImageView> = color_buffers.iter().map(|color_buffer| *color_buffer.view).collect();
        let framebuffer = make_framebuffer(device, *render_pass, &views, extent, extent, 1)?;

        // Static values: dual source blending on every attachment, with no color written.
        let static_attachment = vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::TRUE,
            src_color_blend_factor: vk::BlendFactor::SRC1_ALPHA,
            dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::SRC_ALPHA,
            dst_alpha_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::empty(),
        };

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(extent, extent);
        state.color_attachment_count = attachment_count;
        state.color_blend_attachments = vec![static_attachment; attachment_count as usize];
        state.dynamic_states = vec![
            vk::DynamicState::COLOR_BLEND_ENABLE_EXT,
            vk::DynamicState::COLOR_BLEND_EQUATION_EXT,
            vk::DynamicState::COLOR_WRITE_MASK_EXT,
        ];
        state.construction = params.construction;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let clear_values = vec![clear_value_color([0.0, 0.0, 0.0, 1.0]); attachment_count as usize];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(extent, extent))
            .clear_values(&clear_values);

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

        let dual_color_blend_equation = vk::ColorBlendEquationEXT {
            src_color_blend_factor: vk::BlendFactor::SRC1_ALPHA,
            dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC1_ALPHA,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::SRC1_ALPHA,
            dst_alpha_blend_factor: vk::BlendFactor::ONE_MINUS_SRC1_ALPHA,
            alpha_blend_op: vk::BlendOp::ADD,
        };
        let normal_color_blend_equation = vk::ColorBlendEquationEXT {
            src_color_blend_factor: vk::BlendFactor::ONE,
            dst_color_blend_factor: vk::BlendFactor::ZERO,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::SRC_ALPHA,
            dst_alpha_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
            alpha_blend_op: vk::BlendOp::ADD,
        };

        let mut blend_enables = Vec::new();
        for i in 0..attachment_count {
            // When using an extra attachment, the last one can never have dual blending enabled.
            let use_dual_blend_eq = i % 2 == 0 && (!params.extra_attachment || i != attachment_count - 1);
            // Disable blending for those attachments that use the dual eq.
            blend_enables.push(if use_dual_blend_eq { vk::FALSE } else { vk::TRUE });
            let equation = if use_dual_blend_eq {
                dual_color_blend_equation
            } else {
                normal_color_blend_equation
            };
            unsafe { device.cmd_set_color_blend_equation_ext(cmd, i, &[equation]) };
        }

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());

            // Disable blending for those attachments that use dual color blend equations.
            device.cmd_set_color_blend_enable_ext(cmd, 0, &blend_enables);

            // Enable color writes.
            let color_write_masks = vec![
                vk::ColorComponentFlags::R
                    | vk::ColorComponentFlags::G
                    | vk::ColorComponentFlags::B
                    | vk::ColorComponentFlags::A;
                attachment_count as usize
            ];
            device.cmd_set_color_write_mask_ext(cmd, 0, &color_write_masks);

            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }

        // Copy color attachments to each buffer.
        for color_buffer in &color_buffers {
            copy_image_to_buffer(
                device,
                cmd,
                color_buffer.image.get(),
                color_buffer.buffer.get(),
                extent,
                extent,
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify colors.
        let out_colors = params.out_colors();
        let mut fail = false;
        for (i, color_buffer) in color_buffers.iter().enumerate() {
            let result = color_buffer.read_bytes(device)?;
            if result[..4] != out_colors[i] {
                fail = true;
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

/// The `dynamic_dual_disable` group of `createBlendTests`.
pub fn create_dynamic_dual_disable_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("dynamic_dual_disable");
    for attachment_count in [1u32, 2, 8] {
        for extra_attachment in [false, true] {
            let params = DynamicDualBlendDisableParams {
                construction,
                attachment_count,
                extra_attachment,
            };
            let name = format!(
                "att_count_{attachment_count}{}",
                if extra_attachment { "_plus_1" } else { "" }
            );
            group.add_child(Box::new(DynamicDualBlendDisableCase { name, params }) as Box<dyn TestCase>);
        }
    }
    group
}

/// `RemapParams`
#[derive(Clone)]
struct RemapParams {
    construction: PipelineConstructionType,
    color_locations: Vec<u32>,
    write_enables: Vec<bool>,
    dynamic_blend: bool,
    dynamic_write_enables: bool,
}

impl RemapParams {
    #[expect(dead_code, reason = "ported with upstream's helpers, no caller yet")]
    fn attachment_count(&self) -> u32 {
        2
    }

    /// Different colors, but in both the blue component is 1.0, which is masked out in one of the attachments.
    fn location_colors(&self) -> [[u8; 4]; 2] {
        [[255, 0, 255, 255], [0, 255, 255, 255]]
    }

    fn clear_color(&self) -> [f32; 4] {
        [0.0, 0.0, 0.0, 1.0]
    }

    fn color_blend_equations(&self) -> [vk::ColorBlendEquationEXT; 2] {
        [
            // With the chosen colors and the right constants, some components are zeroed out.
            vk::ColorBlendEquationEXT {
                src_color_blend_factor: vk::BlendFactor::CONSTANT_COLOR,
                dst_color_blend_factor: vk::BlendFactor::ZERO,
                color_blend_op: vk::BlendOp::ADD,
                src_alpha_blend_factor: vk::BlendFactor::CONSTANT_COLOR,
                dst_alpha_blend_factor: vk::BlendFactor::ZERO,
                alpha_blend_op: vk::BlendOp::ADD,
            },
            // The second one should result in the fragment color.
            vk::ColorBlendEquationEXT {
                src_color_blend_factor: vk::BlendFactor::SRC_ALPHA,
                dst_color_blend_factor: vk::BlendFactor::ZERO,
                color_blend_op: vk::BlendOp::ADD,
                src_alpha_blend_factor: vk::BlendFactor::SRC_ALPHA,
                dst_alpha_blend_factor: vk::BlendFactor::ZERO,
                alpha_blend_op: vk::BlendOp::ADD,
            },
        ]
    }

    /// Masks out the blue component when using VK_BLEND_FACTOR_CONSTANT_*
    fn blend_constants(&self) -> [f32; 4] {
        [1.0, 1.0, 0.0, 1.0]
    }

    fn expected_colors(&self) -> Vec<[u8; 4]> {
        let location_colors = self.location_colors();
        let mut expected: Vec<[u8; 4]> = self
            .color_locations
            .iter()
            .map(|&location| location_colors[location as usize])
            .collect();
        // Mask out the blue component for the first attachment (see the equation).
        expected[0][2] = 0;
        expected
    }

    fn some_writes_disabled(&self) -> bool {
        self.write_enables.iter().any(|&enabled| !enabled)
    }
}

struct RemapCase {
    name: String,
    params: RemapParams,
}

impl TestCase for RemapCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `RemapCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_pipeline_construction_requirements(context, self.params.construction)?;

        let mut local_read_features = vk::PhysicalDeviceDynamicRenderingLocalReadFeatures::default();
        let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
        let mut color_write_features = vk::PhysicalDeviceColorWriteEnableFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut local_read_features)
                .push_next(&mut eds3_features)
                .push_next(&mut color_write_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if local_read_features.dynamic_rendering_local_read == vk::FALSE {
            return Err(TestError::NotSupported(
                "dynamicRenderingLocalRead not supported".to_string(),
            ));
        }
        if self.params.dynamic_blend && eds3_features.extended_dynamic_state3_color_blend_equation == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState3ColorBlendEquation not supported".to_string(),
            ));
        }
        if (self.params.dynamic_write_enables || self.params.some_writes_disabled())
            && color_write_features.color_write_enable == vk::FALSE
        {
            return Err(TestError::NotSupported("colorWriteEnable not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        REMAP.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RemapInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct RemapInstance<'a> {
    context: &'a Context<'a>,
    params: RemapParams,
}

impl TestInstance for RemapInstance<'_> {
    /// `RemapInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = &self.params;
        let color_attachment_count = params.color_locations.len();
        let extent = 1u32;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::TRANSFER_SRC;

        let mut color_buffers = Vec::new();
        for _ in 0..color_attachment_count {
            color_buffers.push(ImageWithBuffer::new(
                context,
                extent,
                extent,
                COLOR_FORMAT,
                color_usage,
                4,
            )?);
        }

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let equations = params.color_blend_equations();
        let color_write_mask = vk::ColorComponentFlags::R
            | vk::ColorComponentFlags::G
            | vk::ColorComponentFlags::B
            | vk::ColorComponentFlags::A;
        let bad_equation = vk::ColorBlendEquationEXT {
            src_color_blend_factor: vk::BlendFactor::ZERO,
            dst_color_blend_factor: vk::BlendFactor::ZERO,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ZERO,
            dst_alpha_blend_factor: vk::BlendFactor::ZERO,
            alpha_blend_op: vk::BlendOp::ADD,
        };
        let color_blend_attachment_states: Vec<vk::PipelineColorBlendAttachmentState> = equations
            .iter()
            .map(|equation| {
                let eq = if params.dynamic_blend { bad_equation } else { *equation };
                vk::PipelineColorBlendAttachmentState {
                    blend_enable: vk::TRUE,
                    src_color_blend_factor: eq.src_color_blend_factor,
                    dst_color_blend_factor: eq.dst_color_blend_factor,
                    color_blend_op: eq.color_blend_op,
                    src_alpha_blend_factor: eq.src_alpha_blend_factor,
                    dst_alpha_blend_factor: eq.dst_alpha_blend_factor,
                    alpha_blend_op: eq.alpha_blend_op,
                    color_write_mask,
                }
            })
            .collect();

        let color_write_enables: Vec<vk::Bool32> = params
            .write_enables
            .iter()
            .map(|&enabled| if enabled { vk::TRUE } else { vk::FALSE })
            .collect();

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(extent, extent);
        state.color_attachment_count = color_attachment_count as u32;
        state.color_blend_attachments = color_blend_attachment_states;
        state.blend_constants = params.blend_constants();
        if !params.dynamic_write_enables && params.some_writes_disabled() {
            state.color_write_enables = Some(color_write_enables.clone());
        }
        if params.dynamic_blend {
            state.dynamic_states.push(vk::DynamicState::COLOR_BLEND_EQUATION_EXT);
        }
        if params.dynamic_write_enables {
            state.dynamic_states.push(vk::DynamicState::COLOR_WRITE_ENABLE_EXT);
        }
        state.rendering_format = Some(COLOR_FORMAT);
        state.rendering_formats = vec![COLOR_FORMAT; color_attachment_count];
        state.rendering_attachment_locations = Some(params.color_locations.clone());
        state.construction = params.construction;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            vk::RenderPass::null(),
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let clear_color = params.clear_color();
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let location_info =
            vk::RenderingAttachmentLocationInfo::builder().color_attachment_locations(&params.color_locations);

        begin_command_buffer(device, cmd)?;

        // Transition images to the right layouts.
        let to_attachment_barriers: Vec<vk::ImageMemoryBarrier> = color_buffers
            .iter()
            .map(|color_buffer| {
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_buffer.image.get(),
                    color_srr,
                )
            })
            .collect();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &to_attachment_barriers,
            );
        }

        // Begin rendering.
        let rendering_attachment_infos: Vec<vk::RenderingAttachmentInfo> = color_buffers
            .iter()
            .map(|color_buffer| {
                vk::RenderingAttachmentInfo::builder()
                    .image_view(*color_buffer.view)
                    .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(clear_value_color(clear_color))
                    .build()
            })
            .collect();
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(rect_2d(extent, extent))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&rendering_attachment_infos);

        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());

            // Dynamic states.
            if params.dynamic_blend {
                device.cmd_set_color_blend_equation_ext(cmd, 0, &equations);
            }
            if params.dynamic_write_enables {
                device.cmd_set_color_write_enable_ext(cmd, &color_write_enables);
            }

            // Attachment locations, identical to the ones in the pipeline.
            device.cmd_set_rendering_attachment_locations_khr(cmd, &location_info);

            device.cmd_draw(cmd, 4, 1, 0, 0); // 4 vertices for the full-screen quad triangle strip.
            device.cmd_end_rendering(cmd);
        }

        // Copy each image to its corresponding buffer.
        for color_buffer in &color_buffers {
            copy_image_to_buffer(
                device,
                cmd,
                color_buffer.image.get(),
                color_buffer.buffer.get(),
                extent,
                extent,
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Check attachment contents.
        let expected_colors = params.expected_colors();
        let clear_bytes = clear_color.map(|channel| (channel * 255.0).round() as u8);
        let mut fail = false;
        for (i, color_buffer) in color_buffers.iter().enumerate() {
            let result = color_buffer.read_bytes(device)?;
            let reference = if color_write_enables[i] == vk::TRUE {
                expected_colors[i]
            } else {
                clear_bytes
            };
            if result[..4] != reference {
                fail = true;
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffers; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `drlr_remap` group of `createBlendTests`.
pub fn create_drlr_remap_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("drlr_remap");

    let we_cases = [vec![true, true], vec![true, false], vec![false, true]];

    for we_case in &we_cases {
        for dynamic_blend in [false, true] {
            for dynamic_write_enables in [false, true] {
                // Swapped locations.
                let params = RemapParams {
                    construction,
                    color_locations: vec![1, 0],
                    write_enables: we_case.clone(),
                    dynamic_blend,
                    dynamic_write_enables,
                };

                let mut name = "locations".to_string();
                for location in &params.color_locations {
                    name.push_str(&format!("_{location}"));
                }
                if params.some_writes_disabled() {
                    name.push_str("_we_");
                    name.extend(
                        params
                            .write_enables
                            .iter()
                            .map(|&enabled| if enabled { 'Y' } else { 'N' }),
                    );
                }
                if dynamic_blend {
                    name.push_str("_dyn_blend");
                }
                if dynamic_write_enables {
                    name.push_str("_dyn_we");
                }

                group.add_child(Box::new(RemapCase { name, params }) as Box<dyn TestCase>);
            }
        }
    }
    group
}
