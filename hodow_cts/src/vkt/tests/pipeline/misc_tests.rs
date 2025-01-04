// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Not ported: the three Amber scripts, and everything upstream only
// builds for pipeline libraries (`compatible_render_pass`, `interpolate_at_sample_no_sample_shading`,
// `frag_lib_varying_samples_*`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, DeviceV1_3, InstanceV1_1};

use crate::generated::shaders::pipeline_misc::{
    MISC_ARRAY_OF_STRUCTS_INTERFACE, MISC_COLOR_WRITE_MASK_NONE, MISC_DESCRIPTOR_BIND, MISC_DESCRIPTOR_BIND_HOLES,
    MISC_IDENTICALLY_DEFINED_LAYOUT, MISC_IMPLICIT_PRIMITIVE_ID, MISC_IMPLICIT_PRIMITIVE_ID_WITH_TESSELLATION,
    MISC_NO_RENDERING,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{
    ShaderObjectDraw, begin_draw, end_draw, make_shader_objects_stages,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum MiscKind {
    ImplicitPrimitiveId { with_tessellation: bool },
    ArrayOfStructsInterface,
    DescriptorBind { backwards_binding: bool, holes: bool },
    IdenticallyDefinedLayout,
    NoRendering { unused_attachment: bool },
    ColorWriteMaskNone,
}

struct MiscCase {
    name: &'static str,
    kind: MiscKind,
}

impl TestCase for MiscCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        match self.kind {
            MiscKind::ImplicitPrimitiveId { with_tessellation } => {
                if with_tessellation && features.tessellation_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
                }
                if features.geometry_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
                }
            }
            MiscKind::IdenticallyDefinedLayout => {
                context.require_device_functionality("VK_KHR_maintenance4")?;
                context.require_device_functionality("VK_KHR_maintenance5")?;
            }
            MiscKind::NoRendering { unused_attachment } => {
                context.require_device_functionality("VK_KHR_dynamic_rendering")?;
                if unused_attachment {
                    let mut unused_features = vk::PhysicalDeviceDynamicRenderingUnusedAttachmentsFeaturesEXT::default();
                    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut unused_features);
                    unsafe {
                        context
                            .get_instance()
                            .get_physical_device_features2(context.get_physical_device(), &mut features2)
                    };
                    if unused_features.dynamic_rendering_unused_attachments == vk::FALSE {
                        return Err(TestError::NotSupported("dynamicRenderingUnusedAttachments".to_string()));
                    }
                }
            }
            MiscKind::ColorWriteMaskNone => {
                context.require_device_functionality("VK_KHR_buffer_device_address")?;
                context.require_device_functionality("VK_EXT_scalar_block_layout")?;
                if features.fragment_stores_and_atomics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "fragmentStoresAndAtomics not supported".to_string(),
                    ));
                }
            }
            MiscKind::ArrayOfStructsInterface | MiscKind::DescriptorBind { .. } => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            MiscKind::ImplicitPrimitiveId {
                with_tessellation: false,
            } => MISC_IMPLICIT_PRIMITIVE_ID.programs,
            MiscKind::ImplicitPrimitiveId {
                with_tessellation: true,
            } => MISC_IMPLICIT_PRIMITIVE_ID_WITH_TESSELLATION.programs,
            MiscKind::ArrayOfStructsInterface => MISC_ARRAY_OF_STRUCTS_INTERFACE.programs,
            MiscKind::DescriptorBind { holes: false, .. } => MISC_DESCRIPTOR_BIND.programs,
            MiscKind::DescriptorBind { holes: true, .. } => MISC_DESCRIPTOR_BIND_HOLES.programs,
            MiscKind::IdenticallyDefinedLayout => MISC_IDENTICALLY_DEFINED_LAYOUT.programs,
            MiscKind::NoRendering { .. } => MISC_NO_RENDERING.programs,
            MiscKind::ColorWriteMaskNone => MISC_COLOR_WRITE_MASK_NONE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscInstance {
            context,
            kind: self.kind,
        })
    }
}

struct MiscInstance<'a> {
    context: &'a Context<'a>,
    kind: MiscKind,
}

impl TestInstance for MiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            MiscKind::ImplicitPrimitiveId { with_tessellation } => {
                implicit_primitive_id_test(self.context, with_tessellation)
            }
            MiscKind::ArrayOfStructsInterface => array_of_structs_interface_test(self.context),
            MiscKind::DescriptorBind {
                backwards_binding,
                holes,
            } => descriptor_bind_test(self.context, backwards_binding, holes),
            MiscKind::IdenticallyDefinedLayout => identically_defined_layout_test(self.context),
            MiscKind::NoRendering { unused_attachment } => no_rendering_test(self.context, unused_attachment),
            MiscKind::ColorWriteMaskNone => color_write_mask_none_test(self.context),
        }
    }
}

fn rasterization_state_cw() -> vk::PipelineRasterizationStateCreateInfo {
    vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::CLOCKWISE)
        .line_width(1.0)
        .build()
}

/// What the tests of a render target of `size` x `size` have in common: the target, its render pass and framebuffer, and a
/// pipeline layout over `set_layouts`.
struct Target<'a> {
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    color_buffer: ImageWithBuffer<'a>,
}

impl<'a> Target<'a> {
    fn new(context: &'a Context<'a>, size: u32, format: vk::Format) -> Result<Self, TestError> {
        let device = context.get_device();
        let color_buffer = ImageWithBuffer::new(
            context,
            size,
            size,
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
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
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], size, size, 1)?;
        Ok(Self {
            framebuffer,
            render_pass,
            color_buffer,
        })
    }
}

/// Begins the render pass of `target`, records `record` and ends it, then copies the image to the buffer and submits.
fn render_and_read<'a>(
    context: &'a Context<'a>,
    target: &Target<'a>,
    size: u32,
    shader_objects: Option<&ShaderObjectDraw<'_>>,
    state: &DrawPipelineState,
    pipeline: Option<vk::Pipeline>,
    record: impl FnOnce(vk::CommandBuffer),
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
    begin_draw(
        device,
        cmd,
        shader_objects,
        state,
        pipeline,
        *target.render_pass,
        *target.framebuffer,
        rect_2d(size, size),
        &clear_values,
        &[(target.color_buffer.image.get(), *target.color_buffer.view)],
    );
    record(cmd);
    end_draw(device, cmd, shader_objects.is_some());
    copy_image_to_buffer(
        device,
        cmd,
        target.color_buffer.image.get(),
        target.color_buffer.buffer.get(),
        size,
        size,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    Ok(target.color_buffer.read_bytes(device)?.to_vec())
}

/// `ImplicitPrimitiveIDPassthroughInstance::iterate`
fn implicit_primitive_id_test<'a>(context: &'a Context<'a>, with_tessellation: bool) -> TestOutcome {
    let device = context.get_device();
    let size = 2;
    let target = Target::new(context, size, FORMAT)?;

    // Shader modules.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let tess_modules = if with_tessellation {
        Some((
            create_shader_module(device, binaries.get("tsc")?)?,
            create_shader_module(device, binaries.get("tse")?)?,
        ))
    } else {
        None
    };
    let mut stages = vec![
        (vk::ShaderStageFlags::VERTEX, *vert_module),
        (vk::ShaderStageFlags::FRAGMENT, *frag_module),
    ];
    if let Some((tsc_module, tse_module)) = &tess_modules {
        stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tsc_module));
        stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tse_module));
    }

    // Pipeline layout and graphics pipeline.
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let topology = if with_tessellation {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_LIST
    };
    let mut state = DrawPipelineState::new(topology).with_full_viewport(size, size);
    state.rasterization = rasterization_state_cw();
    if with_tessellation {
        state.patch_control_points = Some(3);
    }
    let mut eso_stages = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
    if with_tessellation {
        eso_stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tsc"));
        eso_stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tse"));
    }
    eso_stages.push((vk::ShaderStageFlags::FRAGMENT, "frag"));
    let shader_objects = make_shader_objects_stages(context, &eso_stages, &[], &[])?;
    let pipeline = if shader_objects.is_none() {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *target.render_pass,
            &stages,
            &state,
        )?)
    } else {
        None
    };

    let result = render_and_read(
        context,
        &target,
        size,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| pipeline.get()),
        |cmd| unsafe {
            device.cmd_draw(cmd, 6, 1, 0, 0);
        },
    )?;

    // Expected a vertically split framebuffer, filled with red on the left and green the right.
    for y in 0..size {
        for x in 0..size {
            let offset = ((y * size + x) * 4) as usize;
            let expected: [u8; 4] = if x < size / 2 {
                [255, 0, 0, 255]
            } else {
                [0, 255, 0, 255]
            };
            if result[offset..offset + 4] != expected {
                return Ok(TestStatus::fail(
                    "Expected a vertically split framebuffer, filled with red on the left and green the right",
                ));
            }
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `arrayOfStructsInterfaceTest`
fn array_of_structs_interface_test<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();
    let size = 4;
    let expected_color = [0.30f32, 0.90, 0.60, 1.0];
    let threshold = [0.02f32, 0.02, 0.02, 0.0];

    let target = Target::new(context, size, FORMAT)?;
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(size, size);
    state.rasterization = rasterization_state_cw();
    let shader_objects = make_shader_objects_stages(
        context,
        &[
            (vk::ShaderStageFlags::VERTEX, "vert"),
            (vk::ShaderStageFlags::FRAGMENT, "frag"),
        ],
        &[],
        &[],
    )?;
    let pipeline = if shader_objects.is_none() {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *target.render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?)
    } else {
        None
    };

    let result = render_and_read(
        context,
        &target,
        size,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| pipeline.get()),
        |cmd| unsafe {
            device.cmd_draw(cmd, 4, 1, 0, 0);
        },
    )?;

    let ok = result
        .chunks_exact(4)
        .all(|pixel| (0..4).all(|c| (pixel[c] as f32 / 255.0 - expected_color[c]).abs() <= threshold[c]));
    Ok(if ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Unexpected color in result buffer; check log for details")
    })
}

/// `PipelineLayoutBindingTestInstance::iterate`
fn descriptor_bind_test<'a>(context: &'a Context<'a>, backwards_binding: bool, holes: bool) -> TestOutcome {
    let device = context.get_device();
    let size = 2;
    let target = Target::new(context, size, FORMAT)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let indices: [usize; 4] = if backwards_binding { [3, 2, 1, 0] } else { [0, 1, 2, 3] };

    let mut descriptor_set_layouts = Vec::new();
    for _ in 0..indices.len() {
        descriptor_set_layouts.push(
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?,
        );
    }
    let layout_handles: Vec<vk::DescriptorSetLayout> =
        descriptor_set_layouts.iter().map(|layout| layout.get()).collect();
    let pipeline_layout = make_pipeline_layout(device, &layout_handles)?;

    let set_and_descriptor_count = indices.len() as u32;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, set_and_descriptor_count)
        .build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            set_and_descriptor_count,
        )?;
    let mut descriptor_sets = Vec::new();
    for layout in &descriptor_set_layouts {
        descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, layout.get())?);
    }

    // Create uniform buffers
    let buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
    let mut buffers = Vec::new();
    for i in 0..indices.len() {
        buffers.push(create_host_buffer(
            context,
            &[i as u32],
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?);
    }

    for &i in &indices {
        let buffer_info = make_descriptor_buffer_info(buffers[i].get(), 0, buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_sets[i].get(),
                Location::binding(0),
                vk::DescriptorType::UNIFORM_BUFFER,
                &buffer_info,
            )
            .update(device);
    }

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(size, size);
    state.rasterization = rasterization_state_cw();
    let shader_objects = make_shader_objects_stages(
        context,
        &[
            (vk::ShaderStageFlags::VERTEX, "vert"),
            (vk::ShaderStageFlags::FRAGMENT, "frag"),
        ],
        &layout_handles,
        &[],
    )?;
    let pipeline = if shader_objects.is_none() {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *target.render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?)
    } else {
        None
    };

    let result = render_and_read(
        context,
        &target,
        size,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| pipeline.get()),
        |cmd| unsafe {
            for &i in &indices {
                if holes && (i == 1 || i == 2) {
                    continue;
                }
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    i as u32,
                    &[descriptor_sets[i].get()],
                    &[] as &[u32],
                );
            }
            device.cmd_draw(cmd, 3, 1, 0, 0);
        },
    )?;

    Ok(if result.chunks_exact(4).all(|pixel| pixel == [0, 255, 0, 255]) {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Image comparison failed")
    })
}

/// `IdenticallyDefinedLayoutTestInstance::iterate`
fn identically_defined_layout_test<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let subresource_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let (width, height) = (4u32, 4u32);

    let image_info = |usage: vk::ImageUsageFlags| {
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width,
                height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build()
    };
    let sampled_image = ImageWithMemory::new(
        device,
        allocator,
        image_info(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED),
        MemoryRequirement::ANY,
    )?;
    let sampled_image_view = make_image_view(
        device,
        sampled_image.get(),
        vk::ImageViewType::_2D,
        FORMAT,
        subresource_range,
    )?;
    let color_image = ImageWithMemory::new(
        device,
        allocator,
        image_info(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC),
        MemoryRequirement::ANY,
    )?;
    let color_image_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        FORMAT,
        subresource_range,
    )?;

    let buffer_size = (width * height * 4) as usize;
    let src_data: Vec<u8> = (0..buffer_size).map(|i| (i % 256) as u8).collect();
    let src_buffer = create_host_buffer(context, &src_data, vk::BufferUsageFlags::TRANSFER_SRC)?;
    let dst_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let render_pass = make_color_render_pass(
        device,
        FORMAT,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_image_view], width, height, 1)?;

    // The pipeline is made with a layout holding one immutable sampler, and used with another layout that is identically defined.
    let sampler_params = vk::SamplerCreateInfo::builder();
    let sampler1 = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_params, None) }.vk_check("vkCreateSampler")?,
    );
    let sampler2 = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_params, None) }.vk_check("vkCreateSampler")?,
    );
    let descriptor_set_layout1 = DescriptorSetLayoutBuilder::new()
        .add_indexed_sampler_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::FRAGMENT,
            0,
            &[*sampler1],
        )
        .build(device)?;
    let descriptor_set_layout2 = DescriptorSetLayoutBuilder::new()
        .add_indexed_sampler_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::FRAGMENT,
            0,
            &[*sampler2],
        )
        .build(device)?;
    let pipeline_layout1 = make_pipeline_layout(device, &[*descriptor_set_layout1])?;
    let pipeline_layout2 = make_pipeline_layout(device, &[*descriptor_set_layout2])?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(width, height);
    // `VkPipelineCreateFlags2CreateInfo` with no flags is chained, which makes the ignored `flags` field irrelevant.
    state.create_flags2 = Some(vk::PipelineCreateFlags2::empty());
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout1,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 3)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout2)?;
    let descriptor_info = [vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: *sampled_image_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
        .image_info(&descriptor_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    {
        let pre_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            sampled_image.get(),
            subresource_range,
        );
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width,
                height,
                depth: 1,
            },
            subresource_layers,
        );
        let post_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            sampled_image.get(),
            subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_barrier],
            );
            device.cmd_copy_buffer_to_image(
                cmd,
                src_buffer.get(),
                sampled_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_barrier],
            );
        }
    }
    let clear_values = [clear_value_color([0.0; 4])];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(width, height))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout2,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_draw(cmd, 4, 1, 0, 0);
        device.cmd_end_render_pass(cmd);
    }
    {
        let pre_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            subresource_range,
        );
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width,
                height,
                depth: 1,
            },
            subresource_layers,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                dst_buffer.get(),
                &[region],
            );
        }
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, dst_buffer.get_allocation())?;
    let dst_data = unsafe { std::slice::from_raw_parts(dst_buffer.get_allocation().get_host_ptr(), buffer_size) };
    Ok(if src_data == dst_data {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `PipelineNoRenderingTestInstance::iterate`
fn no_rendering_test<'a>(context: &'a Context<'a>, unused_attachment: bool) -> TestOutcome {
    let device = context.get_device();
    let size = 32;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    // A pipeline with no render pass and no attachments at all.
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(size, size);
    state.rasterization = rasterization_state_cw();
    state.color_attachment_count = 0;
    state.rendering_format = Some(vk::Format::UNDEFINED);
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

    let color_attachment = ImageWithBuffer::new(
        context,
        size,
        size,
        FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;
    let color_attachments = [vk::RenderingAttachmentInfo::builder()
        .image_view(*color_attachment.view)
        .image_layout(vk::ImageLayout::ATTACHMENT_OPTIMAL)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(clear_value_color([1.0, 1.0, 1.0, 1.0]))
        .build()];
    let attachment_count = if unused_attachment { 1 } else { 0 };
    let render_info = vk::RenderingInfo::builder()
        .render_area(rect_2d(size, size))
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments[..attachment_count]);

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_begin_rendering(cmd, &render_info);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_draw(cmd, 4, 1, 0, 0);
        device.cmd_end_rendering(cmd);
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    Ok(TestStatus::pass("Pass"))
}

/// `PipelineColorWriteMaskNoneTestInstance::iterate`
fn color_write_mask_none_test<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let render_size = 16u32;
    let format = vk::Format::B8G8R8A8_UNORM;

    let payload_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            64,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;
    let ssbo_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(64, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let buffer_device_address_info = vk::BufferDeviceAddressInfo::builder().buffer(payload_buffer.get());
    let payload_address = unsafe { device.get_buffer_device_address(&buffer_device_address_info) };
    unsafe {
        ssbo_buffer
            .get_allocation()
            .get_host_ptr()
            .cast::<u64>()
            .write_unaligned(payload_address)
    };
    flush_alloc(device, ssbo_buffer.get_allocation())?;

    let color_image = ImageWithMemory::new(
        device,
        allocator,
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: render_size,
                height: render_size,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build(),
        MemoryRequirement::ANY,
    )?;
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_image_view = make_image_view(device, color_image.get(), vk::ImageViewType::_2D, format, range)?;
    let image = ImageWithMemory::new(
        device,
        allocator,
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: render_size,
                height: render_size,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::SAMPLED)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build(),
        MemoryRequirement::ANY,
    )?;
    let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D, format, range)?;

    let sampler_create_info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::ALWAYS)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
    );

    let descriptor_set_layout0 = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, vk::ShaderStageFlags::ALL)
        .build(device)?;
    let descriptor_set_layout1 = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, vk::ShaderStageFlags::ALL)
        .build(device)?;
    let descriptor_set_layout2 = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(
        device,
        &[
            *descriptor_set_layout0,
            *descriptor_set_layout1,
            *descriptor_set_layout2,
        ],
    )?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
    let descriptor_set0 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout0)?;
    let descriptor_set2 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout2)?;

    let image_info = [vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *image_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }];
    let image_write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set0.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
        .image_info(&image_info)
        .build();
    unsafe { device.update_descriptor_sets(&[image_write], &[] as &[vk::CopyDescriptorSet]) };
    let buffer_info = make_descriptor_buffer_info(ssbo_buffer.get(), 0, 64);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set2.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_info,
        )
        .update(device);

    let render_pass = make_color_render_pass(
        device,
        format,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_image_view], render_size, render_size, 1)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(render_size, render_size);
    state.color_blend_attachment = Some(
        vk::PipelineColorBlendAttachmentState::builder()
            .color_write_mask(vk::ColorComponentFlags::empty())
            .build(),
    );
    let shader_objects = make_shader_objects_stages(
        context,
        &[
            (vk::ShaderStageFlags::VERTEX, "vert"),
            (vk::ShaderStageFlags::FRAGMENT, "frag"),
        ],
        &[
            *descriptor_set_layout0,
            *descriptor_set_layout1,
            *descriptor_set_layout2,
        ],
        &[],
    )?;
    let pipeline = if shader_objects.is_none() {
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
    } else {
        None
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    let image_memory_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::SHADER_READ,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        image.get(),
        range,
    );
    let clear_values = [clear_value_color([0.0; 4])];
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_memory_barrier],
        );
    }
    begin_draw(
        device,
        cmd,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| pipeline.get()),
        *render_pass,
        *framebuffer,
        rect_2d(render_size, render_size),
        &clear_values,
        &[(color_image.get(), *color_image_view)],
    );
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set0.get()],
            &[] as &[u32],
        );
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            2,
            &[descriptor_set2.get()],
            &[] as &[u32],
        );
        device.cmd_draw(cmd, 3, 1, 0, 0);
    }
    end_draw(device, cmd, shader_objects.is_some());
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, payload_buffer.get_allocation())?;
    let payload =
        unsafe { std::slice::from_raw_parts(payload_buffer.get_allocation().get_host_ptr().cast::<u32>(), 3) };
    if payload != [2, 3, 4] {
        log::error!(
            "Data: {}, {}, {}, expected: 2, 3, 4",
            payload[0],
            payload[1],
            payload[2]
        );
        return Ok(TestStatus::fail("Fail"));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `createMiscTests`, for monolithic pipelines and without the Amber scripts.
pub fn create_misc_tests(shader_object: bool) -> TestCaseGroup {
    let mut misc_tests = TestCaseGroup::new("misc");

    // Verify implicit access to gl_PrimtiveID works
    misc_tests.add_child(Box::new(MiscCase {
        name: "implicit_primitive_id",
        kind: MiscKind::ImplicitPrimitiveId {
            with_tessellation: false,
        },
    }) as Box<dyn TestCase>);
    // Verify implicit access to gl_PrimtiveID works with a tessellation shader
    misc_tests.add_child(Box::new(MiscCase {
        name: "implicit_primitive_id_with_tessellation",
        kind: MiscKind::ImplicitPrimitiveId {
            with_tessellation: true,
        },
    }) as Box<dyn TestCase>);

    misc_tests.add_child(Box::new(MiscCase {
        name: "array_of_structs_interface",
        kind: MiscKind::ArrayOfStructsInterface,
    }) as Box<dyn TestCase>);

    misc_tests.add_child(Box::new(MiscCase {
        name: "descriptor_bind_test_backwards",
        kind: MiscKind::DescriptorBind {
            backwards_binding: true,
            holes: false,
        },
    }) as Box<dyn TestCase>);
    misc_tests.add_child(Box::new(MiscCase {
        name: "descriptor_bind_test_holes",
        kind: MiscKind::DescriptorBind {
            backwards_binding: false,
            holes: true,
        },
    }) as Box<dyn TestCase>);
    misc_tests.add_child(Box::new(MiscCase {
        name: "descriptor_bind_test_backwards_holes",
        kind: MiscKind::DescriptorBind {
            backwards_binding: true,
            holes: true,
        },
    }) as Box<dyn TestCase>);

    // Verify maintenance4 identically defined pipeline layout
    if !shader_object {
        misc_tests.add_child(Box::new(MiscCase {
            name: "identically_defined_layout",
            kind: MiscKind::IdenticallyDefinedLayout,
        }) as Box<dyn TestCase>);

        misc_tests.add_child(Box::new(MiscCase {
            name: "no_rendering",
            kind: MiscKind::NoRendering {
                unused_attachment: false,
            },
        }) as Box<dyn TestCase>);
        misc_tests.add_child(Box::new(MiscCase {
            name: "no_rendering_unused_attachment",
            kind: MiscKind::NoRendering {
                unused_attachment: true,
            },
        }) as Box<dyn TestCase>);
    }

    misc_tests.add_child(Box::new(MiscCase {
        name: "color_write_mask_none",
        kind: MiscKind::ColorWriteMaskNone,
    }) as Box<dyn TestCase>);

    misc_tests
}
