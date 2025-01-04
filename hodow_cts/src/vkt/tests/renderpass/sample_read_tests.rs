// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassSampleReadTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The dynamic rendering half (`iterateInternalDynamicRendering`) runs for the primary and the completely contained secondary command buffer variants with
// monolithic pipelines; the `graphics_pipeline_library` variant is not registered, `create_graphics_pipeline` does not carry the attachment location and
// input attachment index infos to the libraries.

use vulkanalia::vk::{self, HasBuilder};

use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{TestError, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::renderpass::render_pass_tests::RenderPassType;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SRC_FORMAT: vk::Format = vk::Format::R32_UINT;
const DST_FORMAT: vk::Format = vk::Format::R8_UNORM;
/// `m_width` / `m_height`
const WIDTH: u32 = 32;
const HEIGHT: u32 = 32;

/// `TestMode`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TestMode {
    Add,
    Select,
}

/// `TestConfig`
#[derive(Clone, Copy)]
pub struct TestConfig {
    pub sample_count: u32,
    pub test_mode: TestMode,
    pub selected_sample: u32,
    pub render_pass_type: RenderPassType,
}

/// The program set every case shares. Which of its shaders a case uses follows from
/// its test mode and sample count, exactly as upstream's `initPrograms` decides it.
pub struct SampleReadPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `sampleCountBitFromSampleCount`
fn sample_count_bit_from_sample_count(count: u32) -> vk::SampleCountFlags {
    match count {
        1 => vk::SampleCountFlags::_1,
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        16 => vk::SampleCountFlags::_16,
        32 => vk::SampleCountFlags::_32,
        64 => vk::SampleCountFlags::_64,
        other => panic!("Invalid sample count: {other}"),
    }
}

fn is_dynamic_rendering(render_pass_type: RenderPassType) -> bool {
    matches!(
        render_pass_type,
        RenderPassType::DynamicRendering | RenderPassType::DynamicRenderingCompleteSecondary
    )
}

/// `chooseSrcInputImageLayout`
fn choose_src_input_image_layout(render_pass_type: RenderPassType) -> vk::ImageLayout {
    match render_pass_type {
        // use general layout for local reads for some tests
        RenderPassType::DynamicRenderingCompleteSecondary => vk::ImageLayout::GENERAL,
        RenderPassType::DynamicRendering => vk::ImageLayout::RENDERING_LOCAL_READ,
        _ => vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }
}

struct SampleReadTestCase {
    name: String,
    config: TestConfig,
}

/// `isFormatSupported`
fn is_format_supported(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    sample_count: u32,
) -> Result<bool, TestError> {
    use vulkanalia::vk::InstanceV1_0;

    let properties = match unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    } {
        Ok(properties) => properties,
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => return Ok(false),
        Err(error) => {
            return Err(TestError::InternalError(format!(
                "vkGetPhysicalDeviceImageFormatProperties: {error}"
            )));
        }
    };

    Ok(properties.max_extent.width >= 32
        && properties.max_extent.height >= 32
        && properties
            .sample_counts
            .contains(sample_count_bit_from_sample_count(sample_count)))
}

impl TestCase for SampleReadTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let c = &self.config;

        if context.get_device_features().sample_rate_shading != vk::TRUE {
            return Err(TestError::NotSupported("sampleRateShading not supported".into()));
        }

        if c.render_pass_type == RenderPassType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        } else if is_dynamic_rendering(c.render_pass_type) {
            use vulkanalia::vk::InstanceV1_1;

            context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;

            let (major, minor, _) = context.api_version();
            if major > 1 || minor > 3 {
                let mut properties14 = vk::PhysicalDeviceVulkan14Properties::default();
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties14);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
                if properties14.dynamic_rendering_local_read_multisampled_attachments == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "dynamicRenderingLocalReadMultisampledAttachments not supported".into(),
                    ));
                }
            }
        }

        let src_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT;
        let dst_multisample_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let dst_singlesample_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

        if !is_format_supported(context, SRC_FORMAT, src_image_usage, c.sample_count)?
            || !is_format_supported(context, DST_FORMAT, dst_multisample_usage, c.sample_count)?
            || !is_format_supported(context, DST_FORMAT, dst_singlesample_usage, 1)?
        {
            return Err(TestError::NotSupported("Format not supported".into()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::renderpass_sampleread::SAMPLE_READ_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleReadTestInstance {
            context,
            config: self.config,
        })
    }
}

struct SampleReadTestInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl SampleReadTestInstance<'_> {
    /// `createImage`
    fn create_image(
        &self,
        format: vk::Format,
        sample_count_bit: vk::SampleCountFlags,
        usage: vk::ImageUsageFlags,
    ) -> Result<ImageWithMemory<'_>, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(sample_count_bit)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        ImageWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            info,
            MemoryRequirement::ANY,
        )
    }

    /// `createImageView`
    fn create_image_view(&self, image: vk::Image, format: vk::Format) -> Result<Unique<'_, vk::ImageView>, TestError> {
        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        make_image_view(self.context.get_device(), image, vk::ImageViewType::_2D, format, range)
    }

    /// `createBuffer`
    fn create_buffer(&self) -> Result<BufferWithMemory<'_>, TestError> {
        let pixel_size = vk::DeviceSize::from(
            map_vk_format(DST_FORMAT)
                .and_then(|f| f.pixel_size())
                .expect("R8_UNORM maps"),
        );
        let info = make_buffer_create_info(
            vk::DeviceSize::from(WIDTH * HEIGHT) * pixel_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        );
        BufferWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            info,
            MemoryRequirement::HOST_VISIBLE,
        )
    }

    /// `createRenderPass` for both traits, plus `createRenderPassSwitch`.
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let samples = sample_count_bit_from_sample_count(c.sample_count);
        let aspect_flag = if c.render_pass_type == RenderPassType::RenderPass2 {
            vk::ImageAspectFlags::COLOR
        } else {
            vk::ImageAspectFlags::empty()
        };

        let src_attachment_ref = (
            0u32,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::empty(),
        );
        let src_attachment_input_ref = (0u32, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL, aspect_flag);
        let dst_attachment_ref = (
            1u32,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::empty(),
        );
        let dst_resolve_attachment_ref = (
            2u32,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::empty(),
        );

        let attachments = [
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: SRC_FORMAT,
                samples,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::DONT_CARE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::GENERAL,
            },
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: DST_FORMAT,
                samples,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::DONT_CARE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            },
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: DST_FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::STORE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            },
        ];

        let handle = if c.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

            let attachments2: Vec<vk::AttachmentDescription2> =
                attachments.iter().map(to_attachment_description2).collect();
            let src_ref2 = to_attachment_reference2(&src_attachment_ref);
            let src_input_ref2 = to_attachment_reference2(&src_attachment_input_ref);
            let dst_ref2 = to_attachment_reference2(&dst_attachment_ref);
            let dst_resolve_ref2 = to_attachment_reference2(&dst_resolve_attachment_ref);
            let subpasses = [
                vk::SubpassDescription2::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .view_mask(0)
                    .color_attachments(std::slice::from_ref(&src_ref2))
                    .build(),
                vk::SubpassDescription2::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .view_mask(0)
                    .input_attachments(std::slice::from_ref(&src_input_ref2))
                    .color_attachments(std::slice::from_ref(&dst_ref2))
                    .resolve_attachments(std::slice::from_ref(&dst_resolve_ref2))
                    .build(),
            ];
            let dependencies = [vk::SubpassDependency2::builder()
                .src_subpass(0)
                .dst_subpass(1)
                .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
                .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                .dependency_flags(vk::DependencyFlags::BY_REGION)
                .view_offset(0)
                .build()];
            let info = vk::RenderPassCreateInfo2::builder()
                .attachments(&attachments2)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?
        } else {
            let src_ref = to_attachment_reference(&src_attachment_ref);
            let src_input_ref = to_attachment_reference(&src_attachment_input_ref);
            let dst_ref = to_attachment_reference(&dst_attachment_ref);
            let dst_resolve_ref = to_attachment_reference(&dst_resolve_attachment_ref);
            let subpasses = [
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(std::slice::from_ref(&src_ref))
                    .build(),
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .input_attachments(std::slice::from_ref(&src_input_ref))
                    .color_attachments(std::slice::from_ref(&dst_ref))
                    .resolve_attachments(std::slice::from_ref(&dst_resolve_ref))
                    .build(),
            ];
            let dependencies = [vk::SubpassDependency::builder()
                .src_subpass(0)
                .dst_subpass(1)
                .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
                .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                .dependency_flags(vk::DependencyFlags::BY_REGION)
                .build()];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?
        };

        Ok(Unique::new(device, handle))
    }

    /// `createSubpassDescriptorSetLayout` - two bindings are declared, one is used.
    fn create_subpass_descriptor_set_layout(&self) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let bindings = [vk::DescriptorSetLayoutBinding {
            binding: 0,
            descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            immutable_samplers: std::ptr::null(),
        }];
        let info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let handle =
            unsafe { device.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?;
        Ok(Unique::new(device, handle))
    }

    /// `createSubpassDescriptorPool`
    fn create_subpass_descriptor_pool(&self) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::INPUT_ATTACHMENT,
            descriptor_count: 2,
        }];
        let info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(2)
            .pool_sizes(&sizes);
        let handle = unsafe { device.create_descriptor_pool(&info, None) }.vk_check("vkCreateDescriptorPool")?;
        Ok(Unique::new(device, handle))
    }

    /// `createSubpassDescriptorSet`
    fn create_subpass_descriptor_set<'b>(
        &'b self,
        pool: vk::DescriptorPool,
        layout: vk::DescriptorSetLayout,
        image_view: vk::ImageView,
        image_layout: vk::ImageLayout,
    ) -> Result<UniqueDescriptorSet<'b>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let descriptor_set = make_descriptor_set(device, pool, layout)?;
        let image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::default(),
            image_view,
            image_layout,
        }];
        let writes = [vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .dst_array_element(0)
            .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
            .image_info(&image_info)
            .build()];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        Ok(descriptor_set)
    }

    /// `createRenderPipeline` and `createSubpassPipeline` - the two differ only in the
    /// subpass index, the shader and whether sample shading is on.
    fn create_pipeline(
        &self,
        render_pass: Option<vk::RenderPass>,
        pipeline_layout: vk::PipelineLayout,
        subpass: u32,
        vert: vk::ShaderModule,
        frag: vk::ShaderModule,
        sample_shading: bool,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let stages = [
            stage(vk::ShaderStageFlags::VERTEX, vert),
            stage(vk::ShaderStageFlags::FRAGMENT, frag),
        ];

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: WIDTH as f32,
            height: HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        // `setDefaultRasterizationState`
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        // `setDefaultDepthStencilState`
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .max_depth_bounds(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(sample_count_bit_from_sample_count(self.config.sample_count))
            .sample_shading_enable(sample_shading)
            .min_sample_shading(if sample_shading { 1.0 } else { 0.0 });
        let blend_attachments = vec![
            vk::PipelineColorBlendAttachmentState {
                color_write_mask: vk::ColorComponentFlags::R
                    | vk::ColorComponentFlags::G
                    | vk::ColorComponentFlags::B
                    | vk::ColorComponentFlags::A,
                ..Default::default()
            };
            usize::from(render_pass.is_none()) + 1
        ];
        let blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        let color_attachment_formats = [SRC_FORMAT, DST_FORMAT];
        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_attachment_formats)
            .depth_attachment_format(vk::Format::UNDEFINED)
            .stencil_attachment_format(vk::Format::UNDEFINED);
        let color_attachment_locations = [vk::ATTACHMENT_UNUSED, 0u32];
        let mut rendering_attachment_location_info = vk::RenderingAttachmentLocationInfo {
            s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
            next: std::ptr::null(),
            color_attachment_count: 2,
            color_attachment_locations: color_attachment_locations.as_ptr(),
        };
        let color_attachment_input_indices = [0u32, vk::ATTACHMENT_UNUSED];
        let mut rendering_input_attachment_index_info = vk::RenderingInputAttachmentIndexInfo {
            s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
            next: std::ptr::null(),
            color_attachment_count: 2,
            color_attachment_input_indices: color_attachment_input_indices.as_ptr(),
            depth_input_attachment_index: std::ptr::null(),
            stencil_input_attachment_index: std::ptr::null(),
        };

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&blend_state)
            .layout(pipeline_layout)
            .render_pass(render_pass.unwrap_or_default())
            .subpass(subpass);
        if render_pass.is_none() {
            info = info.push_next(&mut rendering_create_info);
            if subpass == 1 {
                info = info
                    .push_next(&mut rendering_attachment_location_info)
                    .push_next(&mut rendering_input_attachment_index_info);
            }
        }
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `postRenderCommands` - upstream's `copyImageToBuffer`.
    fn post_render_commands(
        &self,
        command_buffer: vk::CommandBuffer,
        image: &ImageWithMemory<'_>,
        buffer: &BufferWithMemory<'_>,
        old_layout: vk::ImageLayout,
    ) {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            old_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image.get(),
            subresource_range,
        );
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
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
                command_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            device.cmd_copy_image_to_buffer(
                command_buffer,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[region],
            );
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `verifyResult`
    fn verify_result(&self, buffer: &BufferWithMemory<'_>) -> Result<TestStatus, TestError> {
        let device = self.context.get_device();
        invalidate_alloc(device, buffer.get_allocation())?;

        let format = map_vk_format(DST_FORMAT).expect("R8_UNORM maps");
        let pixel_size = format.pixel_size().expect("R8_UNORM maps") as usize;
        let bytes = unsafe {
            std::slice::from_raw_parts(
                buffer.get_allocation().get_host_ptr(),
                WIDTH as usize * HEIGHT as usize * pixel_size,
            )
        };
        let access = ConstPixelBufferAccess::new(format, [WIDTH, HEIGHT, 1], bytes);
        let mut reference = TextureLevel::new(format, WIDTH, HEIGHT, 1)?;

        // Check we got the 1.0f we expected
        {
            let mut reference = reference.get_access();
            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    reference.set_pixel([1.0, 0.0, 0.0, 1.0], x, y, 0);
                }
            }
        }

        let reference = reference.get_const_access();
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                if reference.get_pixel(x, y, 0) != access.get_pixel(x, y, 0) {
                    return Ok(TestStatus::fail("Compare failed."));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for SampleReadTestInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::DeviceV1_0;

        let c = self.config;
        let device = self.context.get_device();

        let src_image = self.create_image(
            SRC_FORMAT,
            sample_count_bit_from_sample_count(c.sample_count),
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT,
        )?;
        let src_image_view = self.create_image_view(src_image.get(), SRC_FORMAT)?;
        let src_input_image_view = self.create_image_view(src_image.get(), SRC_FORMAT)?;

        let dst_multisample_image = self.create_image(
            DST_FORMAT,
            sample_count_bit_from_sample_count(c.sample_count),
            vk::ImageUsageFlags::COLOR_ATTACHMENT,
        )?;
        let dst_multisample_image_view = self.create_image_view(dst_multisample_image.get(), DST_FORMAT)?;

        let dst_singlesample_image = self.create_image(
            DST_FORMAT,
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let dst_singlesample_image_view = self.create_image_view(dst_singlesample_image.get(), DST_FORMAT)?;

        let dst_buffer = self.create_buffer()?;

        let dynamic = is_dynamic_rendering(c.render_pass_type);
        let src_input_image_read_layout = choose_src_input_image_layout(c.render_pass_type);

        let render_pass = if dynamic {
            None
        } else {
            Some(self.create_render_pass()?)
        };
        let attachments = [
            *src_image_view,
            *dst_multisample_image_view,
            *dst_singlesample_image_view,
        ];
        let framebuffer = match &render_pass {
            Some(render_pass) => Some(make_framebuffer(device, **render_pass, &attachments, WIDTH, HEIGHT, 1)?),
            None => None,
        };

        let render_pipeline_layout = make_pipeline_layout(device, &[])?;
        let subpass_descriptor_set_layout = self.create_subpass_descriptor_set_layout()?;
        let subpass_pipeline_layout = make_pipeline_layout(device, &[*subpass_descriptor_set_layout])?;
        let subpass_descriptor_pool = self.create_subpass_descriptor_pool()?;
        let subpass_descriptor_set = self.create_subpass_descriptor_set(
            *subpass_descriptor_pool,
            *subpass_descriptor_set_layout,
            *src_input_image_view,
            src_input_image_read_layout,
        )?;

        let programs = self.context.get_binary_collection();
        let vert = create_shader_module(device, programs.get("quad_vert")?)?;
        let frag = create_shader_module(device, programs.get("quad_frag")?)?;
        let subpass_frag_name = match c.test_mode {
            TestMode::Add => format!("quad_subpass_frag_add_{}", c.sample_count),
            TestMode::Select => format!("quad_subpass_frag_select_{}", c.selected_sample),
        };
        let subpass_frag = create_shader_module(device, programs.get(&subpass_frag_name)?)?;

        let render_pass_handle = render_pass.as_ref().map(|render_pass| **render_pass);
        let render_pipeline =
            self.create_pipeline(render_pass_handle, *render_pipeline_layout, 0, *vert, *frag, true)?;
        let subpass_pipeline = self.create_pipeline(
            render_pass_handle,
            *subpass_pipeline_layout,
            1,
            *vert,
            *subpass_frag,
            false,
        )?;

        let command_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;

        // `drawFirstSubpass`
        let draw_first_subpass = |command_buffer: vk::CommandBuffer| unsafe {
            device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, *render_pipeline);
            device.cmd_draw(command_buffer, 6, 1, 0, 0);
        };
        // `drawSecondSubpass`
        let draw_second_subpass = |command_buffer: vk::CommandBuffer| unsafe {
            device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, *subpass_pipeline);
            device.cmd_bind_descriptor_sets(
                command_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *subpass_pipeline_layout,
                0,
                &[*subpass_descriptor_set],
                &[],
            );
            device.cmd_draw(command_buffer, 6, 1, 0, 0);
        };

        if dynamic {
            use vulkanalia::vk::{DeviceV1_3, KhrDynamicRenderingLocalReadExtensionDeviceCommands};

            // `iterateInternalDynamicRendering`
            let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

            let clear_value = vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            };
            let color_attachment_locations = [vk::ATTACHMENT_UNUSED, 0u32];
            let rendering_attachment_location_info = vk::RenderingAttachmentLocationInfo {
                s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
                next: std::ptr::null(),
                color_attachment_count: 2,
                color_attachment_locations: color_attachment_locations.as_ptr(),
            };
            let color_attachment_input_indices = [0u32, vk::ATTACHMENT_UNUSED];
            let rendering_input_attachment_index_info = vk::RenderingInputAttachmentIndexInfo {
                s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
                next: std::ptr::null(),
                color_attachment_count: 2,
                color_attachment_input_indices: color_attachment_input_indices.as_ptr(),
                depth_input_attachment_index: std::ptr::null(),
                stencil_input_attachment_index: std::ptr::null(),
            };

            let color_attachment = |image_view: vk::ImageView| {
                vk::RenderingAttachmentInfo::builder()
                    .image_view(image_view)
                    .image_layout(src_input_image_read_layout)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .resolve_image_view(vk::ImageView::default())
                    .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .clear_value(clear_value)
                    .build()
            };
            let mut color_attachments = [color_attachment(*src_image_view), color_attachment(*src_image_view)];
            color_attachments[1].image_view = *dst_multisample_image_view;
            color_attachments[1].resolve_mode = vk::ResolveModeFlags::AVERAGE;
            color_attachments[1].resolve_image_view = *dst_singlesample_image_view;

            let rendering_info = vk::RenderingInfo::builder()
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: WIDTH,
                        height: HEIGHT,
                    },
                })
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments);

            let subresource_range = vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            };
            // `preRenderCommands`
            let pre_render_commands = |command_buffer: vk::CommandBuffer| {
                let image_barriers = [
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        src_input_image_read_layout,
                        src_image.get(),
                        subresource_range,
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        dst_multisample_image.get(),
                        subresource_range,
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        dst_singlesample_image.get(),
                        subresource_range,
                    ),
                ];
                unsafe {
                    device.cmd_pipeline_barrier(
                        command_buffer,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &image_barriers,
                    )
                };
            };
            // `inbetweenRenderCommands`
            let inbetween_render_commands = |command_buffer: vk::CommandBuffer| {
                let image_barrier = make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    src_input_image_read_layout,
                    src_input_image_read_layout,
                    src_image.get(),
                    subresource_range,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        command_buffer,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::BY_REGION,
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[image_barrier],
                    )
                };
            };
            let record_rendering = |command_buffer: vk::CommandBuffer| unsafe {
                device.cmd_begin_rendering(command_buffer, &rendering_info);
                draw_first_subpass(command_buffer);
                inbetween_render_commands(command_buffer);
                device.cmd_set_rendering_attachment_locations_khr(command_buffer, &rendering_attachment_location_info);
                device.cmd_set_rendering_input_attachment_indices_khr(
                    command_buffer,
                    &rendering_input_attachment_index_info,
                );
                draw_second_subpass(command_buffer);
                device.cmd_end_rendering(command_buffer);
            };

            if c.render_pass_type == RenderPassType::DynamicRenderingCompleteSecondary {
                let sec_command_buffer =
                    allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::SECONDARY)?;

                // record secondary command buffer
                let colour_formats = [SRC_FORMAT, DST_FORMAT];
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(vk::RenderingFlags::empty())
                    .view_mask(0)
                    .color_attachment_formats(&colour_formats)
                    .depth_attachment_format(vk::Format::UNDEFINED)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(vk::SampleCountFlags::_1);
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
                    .inheritance_info(&inheritance_info);
                unsafe { device.begin_command_buffer(*sec_command_buffer, &begin_info) }
                    .vk_check("vkBeginCommandBuffer")?;
                record_rendering(*sec_command_buffer);
                end_command_buffer(device, *sec_command_buffer)?;

                // record primary command buffer
                begin_command_buffer(device, *command_buffer)?;
                pre_render_commands(*command_buffer);
                unsafe { device.cmd_execute_commands(*command_buffer, &[*sec_command_buffer]) };
                self.post_render_commands(
                    *command_buffer,
                    &dst_singlesample_image,
                    &dst_buffer,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                );
                end_command_buffer(device, *command_buffer)?;
            } else {
                begin_command_buffer(device, *command_buffer)?;
                pre_render_commands(*command_buffer);
                record_rendering(*command_buffer);
                self.post_render_commands(
                    *command_buffer,
                    &dst_singlesample_image,
                    &dst_buffer,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                );
                end_command_buffer(device, *command_buffer)?;
            }

            submit_commands_and_wait(device, self.context.get_universal_queue(), *command_buffer)?;
            return self.verify_result(&dst_buffer);
        }

        // `iterateInternal`
        let render_pass = render_pass.expect("a render pass outside dynamic rendering");
        let framebuffer = framebuffer.expect("a framebuffer outside dynamic rendering");
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *command_buffer)?;

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: WIDTH,
                    height: HEIGHT,
                },
            });
        let render_pass2 = c.render_pass_type == RenderPassType::RenderPass2;

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(*command_buffer, &begin_info, &subpass_begin_info) };
        } else {
            unsafe { device.cmd_begin_render_pass(*command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }

        draw_first_subpass(*command_buffer);

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_next_subpass2_khr(*command_buffer, &subpass_begin_info, &subpass_end_info) };
        } else {
            unsafe { device.cmd_next_subpass(*command_buffer, vk::SubpassContents::INLINE) };
        }

        draw_second_subpass(*command_buffer);

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(*command_buffer, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(*command_buffer) };
        }

        self.post_render_commands(
            *command_buffer,
            &dst_singlesample_image,
            &dst_buffer,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        );

        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), *command_buffer)?;

        self.verify_result(&dst_buffer)
    }
}

fn to_attachment_description2(a: &vk::AttachmentDescription) -> vk::AttachmentDescription2 {
    vk::AttachmentDescription2::builder()
        .flags(a.flags)
        .format(a.format)
        .samples(a.samples)
        .load_op(a.load_op)
        .store_op(a.store_op)
        .stencil_load_op(a.stencil_load_op)
        .stencil_store_op(a.stencil_store_op)
        .initial_layout(a.initial_layout)
        .final_layout(a.final_layout)
        .build()
}

fn to_attachment_reference(
    &(attachment, layout, _): &(u32, vk::ImageLayout, vk::ImageAspectFlags),
) -> vk::AttachmentReference {
    vk::AttachmentReference { attachment, layout }
}

fn to_attachment_reference2(
    &(attachment, layout, aspect_mask): &(u32, vk::ImageLayout, vk::ImageAspectFlags),
) -> vk::AttachmentReference2 {
    vk::AttachmentReference2::builder()
        .attachment(attachment)
        .layout(layout)
        .aspect_mask(aspect_mask)
        .build()
}

const SAMPLE_COUNTS: [u32; 5] = [2, 4, 8, 16, 32];

/// `initTests`
pub fn create_sample_read_tests(render_pass_type: RenderPassType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sampleread");

    for sample_count in SAMPLE_COUNTS {
        group.add_child(Box::new(SampleReadTestCase {
            name: format!("numsamples_{sample_count}_add"),
            config: TestConfig {
                sample_count,
                test_mode: TestMode::Add,
                selected_sample: 0,
                render_pass_type,
            },
        }) as Box<dyn TestCase>);

        for sample in 0..sample_count {
            group.add_child(Box::new(SampleReadTestCase {
                name: format!("numsamples_{sample_count}_selected_sample_{sample}"),
                config: TestConfig {
                    sample_count,
                    test_mode: TestMode::Select,
                    selected_sample: sample,
                    render_pass_type,
                },
            }) as Box<dyn TestCase>);
        }
    }

    group
}
