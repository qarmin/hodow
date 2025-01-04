// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineEarlyDestroyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The pipeline layout a pipeline was created with is destroyed
// before the pipeline is used; `Option<Unique<..>>` is what lets that happen in the middle of a scope.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_early_destroy::{EARLY_DESTROY_COMPUTE, EARLY_DESTROY_GRAPHICS};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
use crate::vk::pipeline_construction::PipelineConstructionType;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, copy_general_image_to_buffer, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::make_shader_objects_stages;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct TestParams {
    use_pipeline_cache: bool,
    use_maintenance5: bool,
    destroy_layout: bool,
    use_compute: bool,
}

struct EarlyDestroyTestCase {
    name: String,
    params: TestParams,
}

impl TestCase for EarlyDestroyTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `EarlyDestroyTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.use_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.use_compute {
            EARLY_DESTROY_COMPUTE.programs
        } else {
            EARLY_DESTROY_GRAPHICS.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EarlyDestroyTestInstance {
            context,
            params: self.params,
        })
    }
}

struct EarlyDestroyTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for EarlyDestroyTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();

        let (queue, qf_ndx) = if params.use_compute {
            context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("Exclusive compute queue not supported.".to_string()))?
        } else {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        };

        // Cmd buffer and pool
        let cmd_pool = make_command_pool(device, qf_ndx)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Render target setup
        const WIDTH: u32 = 32;
        const HEIGHT: u32 = 32;
        let format = vk::Format::R8G8B8A8_UNORM;
        let image_size = (WIDTH * HEIGHT * 4) as vk::DeviceSize;
        let mut image_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        if params.use_compute {
            image_usage |= vk::ImageUsageFlags::STORAGE;
        } else {
            image_usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
        }

        let image_create_info = vk::ImageCreateInfo::builder()
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
            .usage(image_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        // Render target image and view
        let image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_create_info,
            MemoryRequirement::ANY,
        )?;
        let image_view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // Readback buffer
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(image_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Descriptors
        let descriptors = if params.use_compute {
            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
                .build(device)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

            let desc_image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&desc_image_info);
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            // Field order is drop order: the set has to go before the pool it was allocated from.
            Some((descriptor_set, descriptor_pool, descriptor_set_layout))
        } else {
            None
        };

        // Pipeline cache
        let pipeline_cache = Unique::new(
            device,
            unsafe { device.create_pipeline_cache(&vk::PipelineCacheCreateInfo::builder(), None) }
                .vk_check("vkCreatePipelineCache")?,
        );
        let valid_cache = if params.use_pipeline_cache {
            *pipeline_cache
        } else {
            vk::PipelineCache::null()
        };

        let binaries = context.get_binary_collection();
        let num_tests = if params.destroy_layout { 3 } else { 1 };
        for _ in 0..num_tests {
            // Pipeline layout
            let set_layouts: Vec<vk::DescriptorSetLayout> = descriptors
                .as_ref()
                .map(|(_, _, layout)| vec![**layout])
                .unwrap_or_default();
            let mut pipeline_layout = Some(make_pipeline_layout(device, &set_layouts)?);

            // Scope for the pipelines
            {
                // Objects needed for Graphics construction
                let mut render_pass = None;
                let mut framebuffer = None;
                let mut _graphics_pipeline = None;
                let mut _shader_objects = None;
                let mut _vertex_shader_module = None;

                // Objects needed for Compute construction
                let mut _compute_pipeline = None;
                let mut _compute_shader_module = None;

                if params.use_compute {
                    let shader_module = create_shader_module(device, binaries.get("comp")?)?;
                    let stage = vk::PipelineShaderStageCreateInfo::builder()
                        .stage(vk::ShaderStageFlags::COMPUTE)
                        .module(*shader_module)
                        .name(b"main\0")
                        .build();
                    let layout = **pipeline_layout.as_ref().expect("pipeline layout");
                    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                        .stage(stage)
                        .layout(layout)
                        .base_pipeline_index(-1)
                        .build();
                    let pipelines = unsafe { device.create_compute_pipelines(valid_cache, &[pipeline_info], None) }
                        .vk_check("vkCreateComputePipelines")?;
                    _compute_pipeline = Some(Unique::new(device, pipelines.0[0]));
                    _compute_shader_module = Some(shader_module);
                } else {
                    let pass = make_color_render_pass(
                        device,
                        format,
                        vk::AttachmentLoadOp::CLEAR,
                        vk::AttachmentStoreOp::STORE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    )?;
                    framebuffer = Some(make_framebuffer(device, *pass, &[*image_view], WIDTH, HEIGHT, 1)?);

                    let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;

                    // Viewport state is not needed with rasterizer discard enabled, and there is no fragment shader:
                    // that avoids VUID-VkGraphicsPipelineCreateInfo-pStages-06894.
                    let mut state =
                        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(WIDTH, HEIGHT);
                    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
                        .depth_clamp_enable(false)
                        .rasterizer_discard_enable(true)
                        .polygon_mode(vk::PolygonMode::FILL)
                        .cull_mode(vk::CullModeFlags::BACK)
                        .front_face(vk::FrontFace::CLOCKWISE)
                        .depth_bias_enable(false)
                        .line_width(1.0)
                        .build();
                    if params.use_maintenance5 {
                        state.create_flags2 = Some(vk::PipelineCreateFlags2::DISABLE_OPTIMIZATION);
                    } else {
                        state.create_flags = vk::PipelineCreateFlags::DISABLE_OPTIMIZATION;
                    }
                    state.pipeline_cache = valid_cache;
                    let layout = **pipeline_layout.as_ref().expect("pipeline layout");
                    _shader_objects = make_shader_objects_stages(
                        context,
                        &[(vk::ShaderStageFlags::VERTEX, "color_vert")],
                        &set_layouts,
                        &[],
                    )?;
                    if _shader_objects.is_none() {
                        _graphics_pipeline = Some(create_draw_pipeline(
                            device,
                            layout,
                            *pass,
                            &[(vk::ShaderStageFlags::VERTEX, *vertex_shader_module)],
                            &state,
                        )?);
                    }
                    _vertex_shader_module = Some(vertex_shader_module);
                    render_pass = Some(pass);
                }

                if params.destroy_layout {
                    // The pipeline outlives the layout it was created with.
                    pipeline_layout.take();
                }

                if !params.destroy_layout {
                    begin_command_buffer(device, *cmd_buffer)?;
                    end_command_buffer(device, *cmd_buffer)?;
                } else {
                    begin_command_buffer(device, *cmd_buffer)?;
                    let clear_color = [0.2f32, 0.6, 0.8, 1.0];

                    if !params.use_compute {
                        let render_pass = render_pass.as_ref().expect("render pass");
                        let framebuffer = framebuffer.as_ref().expect("framebuffer");
                        let attachment = vk::ClearAttachment {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            color_attachment: 0,
                            clear_value: vk::ClearValue {
                                color: vk::ClearColorValue { float32: clear_color },
                            },
                        };
                        let render_area = rect_2d(WIDTH, HEIGHT);
                        let rect = vk::ClearRect {
                            rect: render_area,
                            base_array_layer: 0,
                            layer_count: 1,
                        };
                        let clear_values = [attachment.clear_value];
                        let begin_info = vk::RenderPassBeginInfo::builder()
                            .render_pass(**render_pass)
                            .framebuffer(**framebuffer)
                            .render_area(render_area)
                            .clear_values(&clear_values);
                        unsafe {
                            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
                            device.cmd_clear_attachments(*cmd_buffer, &[attachment], &[rect]);
                            device.cmd_end_render_pass(*cmd_buffer);
                        }
                        copy_image_to_buffer(device, *cmd_buffer, image.get(), buffer.get(), WIDTH, HEIGHT);
                    } else {
                        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
                        let pre_barrier = make_image_memory_barrier(
                            vk::AccessFlags::empty(),
                            vk::AccessFlags::TRANSFER_WRITE,
                            vk::ImageLayout::UNDEFINED,
                            vk::ImageLayout::GENERAL,
                            image.get(),
                            range,
                        );
                        let clear_value = vk::ClearColorValue { float32: clear_color };
                        unsafe {
                            device.cmd_pipeline_barrier(
                                *cmd_buffer,
                                vk::PipelineStageFlags::TOP_OF_PIPE,
                                vk::PipelineStageFlags::TRANSFER,
                                vk::DependencyFlags::empty(),
                                &[] as &[vk::MemoryBarrier],
                                &[] as &[vk::BufferMemoryBarrier],
                                &[pre_barrier],
                            );
                            device.cmd_clear_color_image(
                                *cmd_buffer,
                                image.get(),
                                vk::ImageLayout::GENERAL,
                                &clear_value,
                                &[range],
                            );
                        }
                        copy_general_image_to_buffer(device, *cmd_buffer, image.get(), buffer.get(), WIDTH, HEIGHT);
                    }
                    end_command_buffer(device, *cmd_buffer)?;

                    submit_commands_and_wait(device, queue, *cmd_buffer)?;
                    unsafe { device.reset_command_buffer(*cmd_buffer, vk::CommandBufferResetFlags::RELEASE_RESOURCES) }
                        .vk_check("vkResetCommandBuffer")?;
                    invalidate_alloc(device, buffer.get_allocation())?;

                    let image_pixels = unsafe {
                        std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), image_size as usize)
                    };
                    let expected = [51u8, 153, 204, 255];

                    for (ndx, pixel) in image_pixels.chunks_exact(4).enumerate() {
                        if pixel != expected {
                            return Ok(TestStatus::fail(format!(
                                "Pixel value mismatch after clear. diff: {pixel:?} vs {expected:?} at pixel {ndx}"
                            )));
                        }
                    }
                }
            } // End of pipeline scope
        }

        // Passes as long as no crash occurred.
        Ok(TestStatus::pass("Pass"))
    }
}

/// `addEarlyDestroyTests`
fn add_early_destroy_tests(group: &mut TestCaseGroup, construction: PipelineConstructionType) {
    let comp_compatible = matches!(
        construction,
        PipelineConstructionType::Monolithic | PipelineConstructionType::ShaderObjectUnlinkedSpirv
    );
    for use_compute in [false, true] {
        if use_compute && !comp_compatible {
            continue;
        }
        let compute_postfix = if use_compute { "_compute" } else { "" };
        for destroy_layout in [false, true] {
            for use_cache in [false, true] {
                let mut name = String::from(if use_cache { "cache" } else { "no_cache" });

                if destroy_layout {
                    name.push_str("_destroy_layout");
                }
                name.push_str(compute_postfix);

                let params = TestParams {
                    use_pipeline_cache: use_cache,
                    use_maintenance5: false,
                    destroy_layout,
                    use_compute,
                };
                group.add_child(Box::new(EarlyDestroyTestCase { name, params }) as Box<dyn TestCase>);
            }
        }
    }

    let params = TestParams {
        use_pipeline_cache: false,
        use_maintenance5: true,
        destroy_layout: true,
        use_compute: false,
    };
    group.add_child(Box::new(EarlyDestroyTestCase {
        name: "no_cache_destroy_layout_maintenance5".to_string(),
        params,
    }) as Box<dyn TestCase>);
}

/// `createEarlyDestroyTests`
pub fn create_early_destroy_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("early_destroy");
    add_early_destroy_tests(&mut group, construction);
    group
}
