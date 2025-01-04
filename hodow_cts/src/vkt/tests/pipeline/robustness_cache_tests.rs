// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineRobustnessCacheTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only (no graphics pipeline library and no shader object
// construction types), so the pipelines are created directly rather than through the construction wrappers. The shaders are in
// shaders/manifest/pipeline_robustness_cache.toml, one set per tested descriptor type and per graphics/compute variant.
//
// Creates a pipeline without and a second one with VK_EXT_pipeline_robustness enabled for the tested resource (storage buffer,
// uniform buffer, vertex input or storage image) from the same pipeline cache, reads index 0 through the plain pipeline and an
// out-of-bounds index through the robust one. The robustness2 variants expect zeros for the out-of-bounds read.

use std::mem::size_of;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_robustness_cache::{
    RC_IMAGE, RC_IMAGE_COMPUTE, RC_STORAGE, RC_STORAGE_COMPUTE, RC_UNIFORM, RC_UNIFORM_COMPUTE, RC_VERTEX_INPUT,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;

#[derive(Clone, Copy, PartialEq, Eq)]
enum RobustnessBehaviour {
    Robustness,
    Robustness2,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum RobustnessType {
    Storage,
    Uniform,
    VertexInput,
    Image,
}

struct PipelineCacheCase {
    name: String,
    robustness_buffer_behaviour: RobustnessBehaviour,
    type_: RobustnessType,
    use_compute: bool,
}

impl TestCase for PipelineCacheCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_pipeline_robustness")?;
        if self.robustness_buffer_behaviour == RobustnessBehaviour::Robustness2
            && !context.is_device_functionality_supported("VK_KHR_robustness2")
            && !context.is_device_functionality_supported("VK_EXT_robustness2")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_robustness2 and VK_EXT_robustness2 are not supported".to_string(),
            ));
        }

        let mut pipeline_robustness_features = vk::PhysicalDevicePipelineRobustnessFeatures::default();
        let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut robustness2_features)
                .push_next(&mut pipeline_robustness_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if pipeline_robustness_features.pipeline_robustness == vk::FALSE {
            return Err(TestError::NotSupported(
                "VkPhysicalDevicePipelineRobustnessFeaturesEXT::pipelineRobustness feature not supported".to_string(),
            ));
        }

        if self.robustness_buffer_behaviour == RobustnessBehaviour::Robustness2 {
            if self.type_ == RobustnessType::Image {
                if robustness2_features.robust_image_access2 == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "VkPhysicalDeviceRobustness2FeaturesEXT::robustImageAccess2 feature not supported".to_string(),
                    ));
                }
            } else if robustness2_features.robust_buffer_access2 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VkPhysicalDeviceRobustness2FeaturesEXT::robustBufferAccess2 feature not supported".to_string(),
                ));
            }
        }

        if self.use_compute && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("Compute queue required".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.type_, self.use_compute) {
            (RobustnessType::Storage, false) => RC_STORAGE.programs,
            (RobustnessType::Storage, true) => RC_STORAGE_COMPUTE.programs,
            (RobustnessType::Uniform, false) => RC_UNIFORM.programs,
            (RobustnessType::Uniform, true) => RC_UNIFORM_COMPUTE.programs,
            (RobustnessType::Image, false) => RC_IMAGE.programs,
            (RobustnessType::Image, true) => RC_IMAGE_COMPUTE.programs,
            (RobustnessType::VertexInput, _) => RC_VERTEX_INPUT.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PipelineCacheInstance {
            context,
            robustness_buffer_behaviour: self.robustness_buffer_behaviour,
            type_: self.type_,
            use_compute: self.use_compute,
        })
    }
}

struct PipelineCacheInstance<'a> {
    context: &'a Context<'a>,
    robustness_buffer_behaviour: RobustnessBehaviour,
    type_: RobustnessType,
    use_compute: bool,
}

/// What `PipelineCacheTestInstance`'s members hold, so `draw`, `dispatch` and `verify_image` can be methods of one value.
struct Resources {
    cmd_buffer: vk::CommandBuffer,
    descriptor_set: vk::DescriptorSet,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    render_target: vk::Image,
    out_buffer: vk::Buffer,
    vertex_buffer: vk::Buffer,
}

/// `makeImageCreateInfo`
fn make_image_create_info(format: vk::Format, extent: vk::Extent3D, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

fn image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        )
    };
}

/// The compute pipeline of `PipelineCacheTestInstance::iterate`, optionally with the pipeline robustness state chained in.
fn make_compute_pipeline<'a>(
    device: &'a Device,
    module: vk::ShaderModule,
    layout: vk::PipelineLayout,
    cache: vk::PipelineCache,
    robustness: Option<&mut vk::PipelineRobustnessCreateInfo>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let mut info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(0);
    if let Some(robustness) = robustness {
        info = info.push_next(robustness);
    }
    let created =
        unsafe { device.create_compute_pipelines(cache, &[info], None) }.vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, created.0[0]))
}

impl PipelineCacheInstance<'_> {
    /// `PipelineCacheTestInstance::draw`
    fn draw(&self, resources: &Resources, pipeline: vk::Pipeline, extent: vk::Extent2D) -> Result<(), TestError> {
        let device = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let cmd = resources.cmd_buffer;

        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];

        begin_command_buffer(device, cmd)?;
        if self.type_ == RobustnessType::VertexInput {
            unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[resources.vertex_buffer], &[0]) };
        }
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(resources.render_pass)
            .framebuffer(resources.framebuffer)
            .render_area(rect_2d(extent.width, extent.height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                resources.pipeline_layout,
                0,
                &[resources.descriptor_set],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, queue, cmd)?;

        begin_command_buffer(device, cmd)?;
        copy_image_to_buffer(
            device,
            cmd,
            resources.render_target,
            resources.out_buffer,
            extent.width,
            extent.height,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)
    }

    /// `PipelineCacheTestInstance::dispatch`
    fn dispatch(&self, resources: &Resources, pipeline: vk::Pipeline, extent: vk::Extent2D) -> Result<(), TestError> {
        let device = self.context.get_device();
        let (queue, _) = self
            .context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("Compute queue required".to_string()))?;
        let cmd = resources.cmd_buffer;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        begin_command_buffer(device, cmd)?;

        // Predispatch image transition
        let pre_dispatch_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            resources.render_target,
            color_range,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            &[pre_dispatch_barrier],
        );

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                resources.pipeline_layout,
                0,
                &[resources.descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, extent.width / 8, extent.height / 8, 1);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        begin_command_buffer(device, cmd)?;
        // `vk::copyImageToBuffer` with the shader write access and the general layout.
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            resources.render_target,
            color_range,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::TRANSFER,
            &[to_transfer],
        );
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: extent.width,
                height: extent.height,
                depth: 1,
            },
        };
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                resources.render_target,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resources.out_buffer,
                &[copy_region],
            )
        };
        let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
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
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)
    }

    /// `PipelineCacheTestInstance::verifyImage`
    fn verify_image(
        &self,
        out_buffer: &BufferWithMemory<'_>,
        extent: vk::Extent2D,
        value: [f32; 4],
        oob: bool,
    ) -> Result<bool, TestError> {
        let device = self.context.get_device();
        invalidate_alloc(device, out_buffer.get_allocation())?;

        let pixel_count = (extent.width * extent.height) as usize;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                out_buffer.get_allocation().get_host_ptr().cast_const().cast::<f32>(),
                pixel_count * 4,
            )
        };

        for pix in pixels.chunks_exact(4) {
            if oob && self.type_ == RobustnessType::Image {
                if pix.iter().any(|&component| component != 0.0 && component != 1.0) {
                    return Ok(false);
                }
            } else if pix != value {
                return Ok(false);
            }
        }
        Ok(true)
    }
}

impl TestInstance for PipelineCacheInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let binaries = context.get_binary_collection();

        let (queue, queue_family_index) = if self.use_compute {
            context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("Compute queue required".to_string()))?
        } else {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        };

        let extent = vk::Extent2D { width: 32, height: 32 };
        let buffer_size = size_of::<[f32; 4]>() as vk::DeviceSize;
        let index_buffer_size = size_of::<u32>() as vk::DeviceSize;

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let mut buffer_usage = vk::BufferUsageFlags::TRANSFER_SRC
            | vk::BufferUsageFlags::TRANSFER_DST
            | vk::BufferUsageFlags::STORAGE_BUFFER
            | vk::BufferUsageFlags::UNIFORM_BUFFER;
        if self.type_ == RobustnessType::VertexInput {
            buffer_usage |= vk::BufferUsageFlags::VERTEX_BUFFER;
        }
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let index_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                index_buffer_size,
                vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                RENDER_FORMAT,
                vk::Extent3D {
                    width: 1,
                    height: 1,
                    depth: 1,
                },
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let image_view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            RENDER_FORMAT,
            subresource_range,
        )?;
        let sampler_info = vk::SamplerCreateInfo::builder()
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
            .max_lod(1.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let rt_usage =
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC;
        let render_target = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                RENDER_FORMAT,
                vk::Extent3D {
                    width: extent.width,
                    height: extent.height,
                    depth: 1,
                },
                rt_usage,
            ),
            MemoryRequirement::ANY,
        )?;

        let render_target_view = make_image_view(
            device,
            render_target.get(),
            vk::ImageViewType::_2D,
            RENDER_FORMAT,
            subresource_range,
        )?;

        let values = [0.5f32; 4];
        unsafe {
            std::ptr::copy_nonoverlapping(
                values.as_ptr().cast::<u8>(),
                buffer.get_allocation().get_host_ptr(),
                size_of::<[f32; 4]>(),
            )
        };
        flush_alloc(device, buffer.get_allocation())?;
        let index = 0u32;
        unsafe {
            std::ptr::copy_nonoverlapping(
                std::ptr::addr_of!(index).cast::<u8>(),
                index_buffer.get_allocation().get_host_ptr(),
                size_of::<u32>(),
            )
        };
        flush_alloc(device, index_buffer.get_allocation())?;

        let descriptor_buffer_info = [vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: buffer_size,
        }];
        let descriptor_image_info = [vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let index_buffer_info = [vk::DescriptorBufferInfo {
            buffer: index_buffer.get(),
            offset: 0,
            range: index_buffer_size,
        }];

        // Building descriptor set layout
        let descriptor_type = match self.type_ {
            RobustnessType::Storage => vk::DescriptorType::STORAGE_BUFFER,
            RobustnessType::Uniform => vk::DescriptorType::UNIFORM_BUFFER,
            RobustnessType::Image => vk::DescriptorType::STORAGE_IMAGE,
            RobustnessType::VertexInput => vk::DescriptorType::STORAGE_BUFFER,
        };
        let stage = if self.use_compute {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::FRAGMENT
        };
        let index_stage = if self.use_compute {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT
        };

        // binding 0 (input buffer or image), binding 1 (index buffer), binding 2 (output image, compute only)
        let mut layout_builder = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, stage)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, index_stage);
        if self.use_compute {
            layout_builder =
                layout_builder.add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE);
        }
        let descriptor_set_layout = layout_builder.build(device)?;

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, u32::from(self.use_compute))
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let output_image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *render_target_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let mut writes = Vec::new();
        if self.type_ == RobustnessType::Storage || self.type_ == RobustnessType::Uniform {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(descriptor_type)
                    .buffer_info(&descriptor_buffer_info)
                    .build(),
            );
        }
        if self.type_ == RobustnessType::Image {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(descriptor_type)
                    .image_info(&descriptor_image_info)
                    .build(),
            );
        }
        writes.push(
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&index_buffer_info)
                .build(),
        );
        if self.use_compute {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(2)
                    .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                    .image_info(&output_image_info)
                    .build(),
            );
        }
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // buffer to read the output image
        let out_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (size_of::<[f32; 4]>() as u32 * extent.width * extent.height) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Setup RenderPass
        let render_pass = make_render_pass(device, RENDER_FORMAT)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*render_target_view],
            extent.width,
            extent.height,
            1,
        )?;

        let cache_info = vk::PipelineCacheCreateInfo::builder();
        let pipeline_cache = Unique::new(
            device,
            unsafe { device.create_pipeline_cache(&cache_info, None) }.vk_check("vkCreatePipelineCache")?,
        );

        let mut pipeline_robustness_info = vk::PipelineRobustnessCreateInfo::default();
        let (buffer_behavior, image_behavior) = if self.robustness_buffer_behaviour == RobustnessBehaviour::Robustness {
            (
                vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS,
                vk::PipelineRobustnessImageBehavior::ROBUST_IMAGE_ACCESS,
            )
        } else {
            (
                vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS_2,
                vk::PipelineRobustnessImageBehavior::ROBUST_IMAGE_ACCESS_2,
            )
        };
        match self.type_ {
            RobustnessType::Storage => pipeline_robustness_info.storage_buffers = buffer_behavior,
            RobustnessType::Uniform => pipeline_robustness_info.uniform_buffers = buffer_behavior,
            RobustnessType::VertexInput => pipeline_robustness_info.vertex_inputs = buffer_behavior,
            RobustnessType::Image => pipeline_robustness_info.images = image_behavior,
        }

        // Create pipelines
        let compute_module;
        let vert_module;
        let frag_module;
        let (pipeline, robust_pipeline) = if self.use_compute {
            compute_module = create_shader_module(device, binaries.get("comp")?)?;

            (
                make_compute_pipeline(device, *compute_module, *pipeline_layout, *pipeline_cache, None)?,
                make_compute_pipeline(
                    device,
                    *compute_module,
                    *pipeline_layout,
                    *pipeline_cache,
                    Some(&mut pipeline_robustness_info),
                )?,
            )
        } else {
            vert_module = create_shader_module(device, binaries.get("vert")?)?;
            frag_module = create_shader_module(device, binaries.get("frag")?)?;

            // Vertex input state: one binding per instance with sixteen overlapping float attributes
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
                .with_full_viewport(extent.width, extent.height);
            if self.type_ == RobustnessType::VertexInput {
                state.bindings = vec![vk::VertexInputBindingDescription {
                    binding: 0,
                    stride: size_of::<f32>() as u32,
                    input_rate: vk::VertexInputRate::INSTANCE,
                }];
                state.attributes = (0..16u32)
                    .map(|i| vk::VertexInputAttributeDescription {
                        location: i,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: (size_of::<f32>() as u32) * i,
                    })
                    .collect();
            }
            state.rasterization.depth_bias_enable = vk::FALSE;
            state.pipeline_cache = *pipeline_cache;

            let stages = [
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ];
            let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

            state.pipeline_robustness = Some(pipeline_robustness_info);
            let robust_pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;
            (pipeline, robust_pipeline)
        };

        if self.type_ == RobustnessType::Image {
            // Initialize image
            let pre_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                subresource_range,
            );
            let post_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                image.get(),
                subresource_range,
            );
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: 1,
                    height: 1,
                    depth: 1,
                },
            };

            begin_command_buffer(device, *cmd_buffer)?;
            image_barrier(
                device,
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                &[pre_image_barrier],
            );
            unsafe {
                device.cmd_copy_buffer_to_image(
                    *cmd_buffer,
                    buffer.get(),
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[copy_region],
                )
            };
            let dst_stage = if self.use_compute {
                vk::PipelineStageFlags::COMPUTE_SHADER
            } else {
                vk::PipelineStageFlags::FRAGMENT_SHADER
            };
            image_barrier(
                device,
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                dst_stage,
                &[post_image_barrier],
            );
            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;
        }

        let resources = Resources {
            cmd_buffer: *cmd_buffer,
            descriptor_set: descriptor_set.get(),
            pipeline_layout: *pipeline_layout,
            render_pass: *render_pass,
            framebuffer: *framebuffer,
            render_target: render_target.get(),
            out_buffer: out_buffer.get(),
            vertex_buffer: buffer.get(),
        };

        if self.use_compute {
            self.dispatch(&resources, *pipeline, extent)?;
        } else {
            self.draw(&resources, *pipeline, extent)?;
        }

        if !self.verify_image(&out_buffer, extent, [values[0]; 4], false)? {
            return Ok(TestStatus::fail("Fail"));
        }

        let invalid_index = if self.type_ == RobustnessType::VertexInput {
            15u32
        } else {
            999u32
        };
        unsafe {
            std::ptr::copy_nonoverlapping(
                std::ptr::addr_of!(invalid_index).cast::<u8>(),
                index_buffer.get_allocation().get_host_ptr(),
                size_of::<u32>(),
            )
        };
        flush_alloc(device, index_buffer.get_allocation())?;

        if self.use_compute {
            self.dispatch(&resources, *robust_pipeline, extent)?;
        } else {
            self.draw(&resources, *robust_pipeline, extent)?;
        }

        if self.robustness_buffer_behaviour == RobustnessBehaviour::Robustness2
            && !self.verify_image(&out_buffer, extent, [0.0; 4], true)?
        {
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createPipelineRobustnessCacheTests` for the monolithic construction type.
pub fn create_pipeline_robustness_cache_tests() -> TestCaseGroup {
    // Test pipeline cache with different robustness enabled
    let mut test_group = TestCaseGroup::new("pipeline_cache");

    let robustness_tests = [
        (RobustnessBehaviour::Robustness, "robustness"),
        (RobustnessBehaviour::Robustness2, "robustness2"),
    ];
    let type_tests = [
        (RobustnessType::Storage, "storage"),
        (RobustnessType::Uniform, "uniform"),
        (RobustnessType::VertexInput, "vertex_input"),
        (RobustnessType::Image, "image"),
    ];

    for (robustness_behaviour, robustness_name) in robustness_tests {
        let mut robustness_group = TestCaseGroup::new(robustness_name);
        for (type_, type_name) in type_tests {
            robustness_group.add_child(Box::new(PipelineCacheCase {
                name: type_name.to_string(),
                robustness_buffer_behaviour: robustness_behaviour,
                type_,
                use_compute: false,
            }) as Box<dyn TestCase>);

            // Compute variant
            if type_ != RobustnessType::VertexInput {
                robustness_group.add_child(Box::new(PipelineCacheCase {
                    name: format!("{type_name}_compute"),
                    robustness_buffer_behaviour: robustness_behaviour,
                    type_,
                    use_compute: true,
                }) as Box<dyn TestCase>);
            }
        }
        test_group.add_child(robustness_group);
    }

    test_group
}
