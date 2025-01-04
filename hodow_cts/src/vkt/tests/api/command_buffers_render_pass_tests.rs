// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp (`CommandBufferRenderPassTestEnvironment`, `renderPassContinue*Test`,
//   `recordBufferQuery*Test`, `inheritedOcclusionQueryWithoutPrimaryQueryTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The inherited occlusion query shaders are in shaders/manifest/api_command_buffers.toml.
// Not carried over: the `VK_KHR_maintenance7` shortcut in `checkNestedCommandBufferRenderPassContinueSupport` (the Context has no such feature query),
// so the nested variant always requires nestedCommandBuffer and nestedCommandBufferRendering.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::api_command_buffers::INHERITED_OCCLUSION;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_graphics_pipeline, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UINT;
const IMAGE_WIDTH: u32 = 255;
const IMAGE_HEIGHT: u32 = 255;

/// `CommandBufferRenderPassTestEnvironment`
struct RenderPassEnvironment<'a> {
    device: &'a Device,
    queue: vk::Queue,
    allocator_context: &'a Context<'a>,
    render_pass: Unique<'a, vk::RenderPass>,
    color_image: ImageWithMemory<'a>,
    _color_view: Unique<'a, vk::ImageView>,
    frame_buffer: Unique<'a, vk::Framebuffer>,
    _command_pool: Unique<'a, vk::CommandPool>,
    _secondary_pool: Unique<'a, vk::CommandPool>,
    primary: UniqueCommandBuffer<'a>,
    secondary: UniqueCommandBuffer<'a>,
    nested: UniqueCommandBuffer<'a>,
}

impl<'a> RenderPassEnvironment<'a> {
    fn new(context: &'a Context<'a>) -> Result<Self, TestError> {
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let command_pool = make_command_pool(device, queue_family_index)?;
        let primary = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let render_pass = make_render_pass(device, IMAGE_FORMAT)?;
        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let image_info = make_image_create_info(
            crate::tcu::IVec2::new(IMAGE_WIDTH as i32, IMAGE_HEIGHT as i32),
            IMAGE_FORMAT,
            usage,
        );
        let color_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let frame_buffer = make_framebuffer(device, *render_pass, &[*color_view], IMAGE_WIDTH, IMAGE_HEIGHT, 1)?;

        let secondary_pool = make_command_pool(device, queue_family_index)?;
        let secondary = allocate_command_buffer(device, *secondary_pool, vk::CommandBufferLevel::SECONDARY)?;
        let nested = allocate_command_buffer(device, *secondary_pool, vk::CommandBufferLevel::SECONDARY)?;

        Ok(Self {
            device,
            queue: context.get_universal_queue(),
            allocator_context: context,
            render_pass,
            color_image,
            _color_view: color_view,
            frame_buffer,
            _command_pool: command_pool,
            _secondary_pool: secondary_pool,
            primary,
            secondary,
            nested,
        })
    }

    fn image_area() -> vk::Rect2D {
        make_rect_2d(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT)
    }

    fn begin_inheriting(
        &self,
        cmd: vk::CommandBuffer,
        usage_flags: vk::CommandBufferUsageFlags,
        framebuffer_hint: bool,
    ) -> Result<(), TestError> {
        let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
            .render_pass(*self.render_pass)
            .subpass(0)
            .framebuffer(if framebuffer_hint {
                *self.frame_buffer
            } else {
                vk::Framebuffer::null()
            })
            .occlusion_query_enable(false)
            .query_flags(vk::QueryControlFlags::empty())
            .pipeline_statistics(vk::QueryPipelineStatisticFlags::empty());
        let begin_info = vk::CommandBufferBeginInfo::builder()
            .flags(usage_flags)
            .inheritance_info(&inheritance_info);
        unsafe { self.device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
    }

    fn begin_secondary_command_buffer(
        &self,
        usage_flags: vk::CommandBufferUsageFlags,
        framebuffer_hint: bool,
    ) -> Result<(), TestError> {
        self.begin_inheriting(*self.secondary, usage_flags, framebuffer_hint)
    }

    fn begin_nested_command_buffer(
        &self,
        usage_flags: vk::CommandBufferUsageFlags,
        framebuffer_hint: bool,
    ) -> Result<(), TestError> {
        self.begin_inheriting(*self.nested, usage_flags, framebuffer_hint)
    }

    fn begin_primary_command_buffer(&self, usage_flags: vk::CommandBufferUsageFlags) -> Result<(), TestError> {
        let begin_info = vk::CommandBufferBeginInfo::builder().flags(usage_flags);
        unsafe { self.device.begin_command_buffer(*self.primary, &begin_info) }.vk_check("vkBeginCommandBuffer")
    }

    fn begin_render_pass(&self, contents: vk::SubpassContents) {
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                uint32: [17, 59, 163, 251],
            },
        }];
        let info = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.render_pass)
            .framebuffer(*self.frame_buffer)
            .render_area(Self::image_area())
            .clear_values(&clear_values);
        unsafe { self.device.cmd_begin_render_pass(*self.primary, &info, contents) };
    }

    fn submit_primary_command_buffer(&self) -> Result<(), TestError> {
        submit_commands_and_wait(self.device, self.queue, *self.primary)
    }

    fn read_color_attachment(&self) -> Result<Vec<u8>, TestError> {
        let device = self.device;
        let pixel_data_size = u64::from(IMAGE_HEIGHT * IMAGE_HEIGHT * 4);
        let buffer = BufferWithMemory::new(
            device,
            self.allocator_context.get_default_allocator(),
            make_buffer_create_info(pixel_data_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        self.begin_primary_command_buffer(vk::CommandBufferUsageFlags::empty())?;
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            self.color_image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                *self.primary,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            device.cmd_copy_image_to_buffer(
                *self.primary,
                self.color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[region],
            );
            device.cmd_pipeline_barrier(
                *self.primary,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *self.primary)?;
        self.submit_primary_command_buffer()?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut data = vec![0u8; pixel_data_size as usize];
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer.get_allocation().get_host_ptr() as *const u8,
                data.as_mut_ptr(),
                data.len(),
            )
        };
        Ok(data)
    }
}

fn clear_attachment(color: [u32; 4]) -> vk::ClearAttachment {
    vk::ClearAttachment {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        color_attachment: 0,
        clear_value: vk::ClearValue {
            color: vk::ClearColorValue { uint32: color },
        },
    }
}

fn clear_rect(rect: vk::Rect2D) -> vk::ClearRect {
    vk::ClearRect {
        rect,
        base_array_layer: 0,
        layer_count: 1,
    }
}

fn check_all_pixels(data: &[u8], clear_color: [u32; 4]) -> bool {
    (0..(IMAGE_WIDTH * IMAGE_HEIGHT) as usize).all(|i| (0..4).all(|c| u32::from(data[i * 4 + c]) == clear_color[c]))
}

/// `renderPassContinueTest`
fn render_pass_continue_test(context: &Context<'_>, framebuffer_hint: bool) -> TestOutcome {
    let env = RenderPassEnvironment::new(context)?;
    let vkd = env.device;
    let clear_color = [2u32, 47, 131, 211];
    let attachment = clear_attachment(clear_color);
    let rect = clear_rect(RenderPassEnvironment::image_area());

    env.begin_secondary_command_buffer(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE, framebuffer_hint)?;
    unsafe { vkd.cmd_clear_attachments(*env.secondary, &[attachment], &[rect]) };
    end_command_buffer(vkd, *env.secondary)?;

    env.begin_primary_command_buffer(vk::CommandBufferUsageFlags::empty())?;
    env.begin_render_pass(vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
    unsafe {
        vkd.cmd_execute_commands(*env.primary, &[*env.secondary]);
        vkd.cmd_end_render_pass(*env.primary);
    }
    end_command_buffer(vkd, *env.primary)?;
    env.submit_primary_command_buffer()?;

    let result = env.read_color_attachment()?;
    if !check_all_pixels(&result, clear_color) {
        return Ok(TestStatus::fail("clear value mismatch"));
    }
    Ok(TestStatus::pass("render pass continue test passed"))
}

/// `renderPassContinueNestedTest`
fn render_pass_continue_nested_test(context: &Context<'_>, framebuffer_hint: bool) -> TestOutcome {
    let env = RenderPassEnvironment::new(context)?;
    let vkd = env.device;
    let clear_color = [2u32, 47, 131, 211];
    let attachment = clear_attachment(clear_color);

    let clear_rect_width = IMAGE_WIDTH / 2;
    let clear_rect_height = IMAGE_HEIGHT / 2;
    let offset_x = clear_rect_width as i32;
    let offset_y = clear_rect_height as i32;
    let rects = [
        clear_rect(make_rect_2d(0, 0, clear_rect_width, clear_rect_height)),
        clear_rect(make_rect_2d(0, offset_y, clear_rect_width, clear_rect_height + 1)),
        clear_rect(make_rect_2d(offset_x, 0, clear_rect_width + 1, clear_rect_height)),
        clear_rect(make_rect_2d(
            offset_x,
            offset_y,
            clear_rect_width + 1,
            clear_rect_height + 1,
        )),
    ];

    env.begin_secondary_command_buffer(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE, framebuffer_hint)?;
    unsafe { vkd.cmd_clear_attachments(*env.secondary, &[attachment], &[rects[0]]) };
    end_command_buffer(vkd, *env.secondary)?;

    env.begin_nested_command_buffer(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE, framebuffer_hint)?;
    unsafe {
        vkd.cmd_execute_commands(*env.nested, &[*env.secondary]);
        vkd.cmd_clear_attachments(*env.nested, &[attachment], &[rects[1]]);
    }
    end_command_buffer(vkd, *env.nested)?;

    env.begin_primary_command_buffer(vk::CommandBufferUsageFlags::empty())?;
    env.begin_render_pass(vk::SubpassContents::INLINE_AND_SECONDARY_COMMAND_BUFFERS_KHR);
    unsafe {
        vkd.cmd_clear_attachments(*env.primary, &[attachment], &[rects[2]]);
        vkd.cmd_execute_commands(*env.primary, &[*env.nested]);
        vkd.cmd_clear_attachments(*env.primary, &[attachment], &[rects[3]]);
        vkd.cmd_end_render_pass(*env.primary);
    }
    end_command_buffer(vkd, *env.primary)?;
    env.submit_primary_command_buffer()?;

    let result = env.read_color_attachment()?;
    if !check_all_pixels(&result, clear_color) {
        return Ok(TestStatus::fail("clear value mismatch"));
    }
    Ok(TestStatus::pass(
        "render pass continue in nested command buffer test passed",
    ))
}

/// The three `recordBufferQuery*Test`: record a primary command buffer that runs a secondary one inside an occlusion query; nothing is submitted.
fn record_buffer_query_test(
    context: &Context<'_>,
    secondary_query_flags: vk::QueryControlFlags,
    begin_query_flags: vk::QueryControlFlags,
    message: &'static str,
) -> TestOutcome {
    let device = context.get_device();
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let prim_cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let sec_cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
        .occlusion_query_enable(true)
        .query_flags(secondary_query_flags)
        .pipeline_statistics(vk::QueryPipelineStatisticFlags::empty());
    let sec_begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::empty())
        .inheritance_info(&inheritance_info);
    let prim_begin_info = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::empty());

    let query_pool_info = vk::QueryPoolCreateInfo::builder()
        .query_type(vk::QueryType::OCCLUSION)
        .query_count(1);
    let query_pool = Unique::new(
        device,
        unsafe { device.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
    );

    unsafe { device.begin_command_buffer(*sec_cmd_buf, &sec_begin_info) }.vk_check("vkBeginCommandBuffer")?;
    end_command_buffer(device, *sec_cmd_buf)?;

    unsafe { device.begin_command_buffer(*prim_cmd_buf, &prim_begin_info) }.vk_check("vkBeginCommandBuffer")?;
    unsafe {
        device.cmd_reset_query_pool(*prim_cmd_buf, *query_pool, 0, 1);
        device.cmd_begin_query(*prim_cmd_buf, *query_pool, 0, begin_query_flags);
        device.cmd_execute_commands(*prim_cmd_buf, &[*sec_cmd_buf]);
        device.cmd_end_query(*prim_cmd_buf, *query_pool, 0);
    }
    end_command_buffer(device, *prim_cmd_buf)?;

    Ok(TestStatus::pass(message))
}

fn record_buffer_query_precise_with_flag_test(context: &Context<'_>) -> TestOutcome {
    record_buffer_query_test(
        context,
        vk::QueryControlFlags::PRECISE,
        vk::QueryControlFlags::PRECISE,
        "Successfully recorded a secondary command buffer allowing a precise occlusion query.",
    )
}

fn record_buffer_query_imprecise_with_flag_test(context: &Context<'_>) -> TestOutcome {
    record_buffer_query_test(
        context,
        vk::QueryControlFlags::PRECISE,
        vk::QueryControlFlags::empty(),
        "Successfully recorded an imprecise query with a secondary command buffer allowing a precise occlusion query.",
    )
}

fn record_buffer_query_imprecise_without_flag_test(context: &Context<'_>) -> TestOutcome {
    record_buffer_query_test(
        context,
        vk::QueryControlFlags::empty(),
        vk::QueryControlFlags::empty(),
        "Successfully recorded an imprecise query with a secondary command buffer not allowing a precise occlusion query.",
    )
}

/// `inheritedOcclusionQueryWithoutPrimaryQueryTest`
fn inherited_occlusion_query_without_primary_query_test(context: &Context<'_>, precise_query: bool) -> TestOutcome {
    let env = RenderPassEnvironment::new(context)?;
    let device = env.device;
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let pipeline = make_graphics_pipeline(
        device,
        *pipeline_layout,
        *vert_module,
        *frag_module,
        *env.render_pass,
        (IMAGE_WIDTH, IMAGE_HEIGHT),
        vk::PrimitiveTopology::TRIANGLE_LIST,
    )?;

    // The issue tested is occlusionQueryEnable = TRUE with no active query in the primary; the precise flag does not change that.
    let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
        .render_pass(*env.render_pass)
        .subpass(0)
        .framebuffer(*env.frame_buffer)
        .occlusion_query_enable(true)
        .query_flags(if precise_query {
            vk::QueryControlFlags::PRECISE
        } else {
            vk::QueryControlFlags::empty()
        })
        .pipeline_statistics(vk::QueryPipelineStatisticFlags::empty());
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
        .inheritance_info(&inheritance_info);
    unsafe { device.begin_command_buffer(*env.secondary, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
    unsafe {
        device.cmd_bind_pipeline(*env.secondary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_draw(*env.secondary, 3, 1, 0, 0);
    }
    end_command_buffer(device, *env.secondary)?;

    env.begin_primary_command_buffer(vk::CommandBufferUsageFlags::empty())?;
    env.begin_render_pass(vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
    unsafe {
        device.cmd_execute_commands(*env.primary, &[*env.secondary]);
        device.cmd_end_render_pass(*env.primary);
    }
    end_command_buffer(device, *env.primary)?;
    env.submit_primary_command_buffer()?;

    Ok(TestStatus::pass(
        "Successfully executed secondary command buffer with occlusionQueryEnable flag without an active primary query.",
    ))
}

fn check_inherited_queries_support(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_device_features().inherited_queries == vk::FALSE {
        return Err(TestError::NotSupported(
            "Inherited queries feature is not supported".to_string(),
        ));
    }
    Ok(())
}

fn check_inherited_occlusion_query_support(context: &Context<'_>, precise_query: bool) -> Result<(), TestError> {
    check_inherited_queries_support(context)?;
    if precise_query && context.get_device_features().occlusion_query_precise == vk::FALSE {
        return Err(TestError::NotSupported(
            "Precise occlusion queries are not supported".to_string(),
        ));
    }
    Ok(())
}

fn check_nested_render_pass_continue_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_nested_command_buffer")?;
    let mut features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if features.nested_command_buffer == vk::FALSE {
        return Err(TestError::NotSupported(
            "nestedCommandBuffer is not supported".to_string(),
        ));
    }
    if features.nested_command_buffer_rendering == vk::FALSE {
        return Err(TestError::NotSupported(
            "nestedCommandBufferRendering is not supported".to_string(),
        ));
    }
    Ok(())
}

#[derive(Clone, Copy)]
enum Kind {
    RenderPassContinue(bool),
    NestedRenderPassContinue(bool),
    RecordQueryPrecise,
    RecordQueryImpreciseWithFlag,
    RecordQueryImpreciseWithoutFlag,
    InheritedOcclusion(bool),
}

struct RenderPassCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for RenderPassCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            Kind::NestedRenderPassContinue(_) => check_nested_render_pass_continue_support(context),
            Kind::RecordQueryImpreciseWithFlag | Kind::RecordQueryImpreciseWithoutFlag => {
                check_inherited_queries_support(context)
            }
            Kind::InheritedOcclusion(precise) => check_inherited_occlusion_query_support(context, precise),
            _ => Ok(()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::InheritedOcclusion(_) => INHERITED_OCCLUSION.programs,
            _ => BinaryCollection::new(&[] as &'static [crate::vk::programs::ProgramBinary]),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RenderPassInstance {
            context,
            kind: self.kind,
        })
    }
}

struct RenderPassInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for RenderPassInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        match self.kind {
            Kind::RenderPassContinue(hint) => render_pass_continue_test(context, hint),
            Kind::NestedRenderPassContinue(hint) => render_pass_continue_nested_test(context, hint),
            Kind::RecordQueryPrecise => record_buffer_query_precise_with_flag_test(context),
            Kind::RecordQueryImpreciseWithFlag => record_buffer_query_imprecise_with_flag_test(context),
            Kind::RecordQueryImpreciseWithoutFlag => record_buffer_query_imprecise_without_flag_test(context),
            Kind::InheritedOcclusion(precise) => inherited_occlusion_query_without_primary_query_test(context, precise),
        }
    }
}

/// `render_pass_continue*`, `nested_render_pass_continue`, `record_query_*` and `inherited_occlusion_query_without_primary_query_*`.
pub fn add_render_pass_continue_tests(group: &mut TestCaseGroup) {
    for (name, kind) in [
        ("render_pass_continue", Kind::RenderPassContinue(true)),
        ("nested_render_pass_continue", Kind::NestedRenderPassContinue(true)),
        ("render_pass_continue_no_fb", Kind::RenderPassContinue(false)),
        ("record_query_precise_w_flag", Kind::RecordQueryPrecise),
        ("record_query_imprecise_w_flag", Kind::RecordQueryImpreciseWithFlag),
        ("record_query_imprecise_wo_flag", Kind::RecordQueryImpreciseWithoutFlag),
        (
            "inherited_occlusion_query_without_primary_query_imprecise",
            Kind::InheritedOcclusion(false),
        ),
        (
            "inherited_occlusion_query_without_primary_query_precise",
            Kind::InheritedOcclusion(true),
        ),
    ] {
        group.add_child(Box::new(RenderPassCase { name, kind }) as Box<dyn TestCase>);
    }
}
