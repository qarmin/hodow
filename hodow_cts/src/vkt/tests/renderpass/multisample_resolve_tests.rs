// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/renderpass/
// vktRenderPassMultisampleResolveTests.cpp

use vulkanalia::vk::{self, HasBuilder};

use crate::tcu::pixel::{ConstPixelBufferAccess, get_texture_format_bit_depth, srgb_to_linear};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass};
use crate::tcu::{TestCaseGroup, TestError, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::renderpass::render_pass_tests::RenderPassType;
use crate::vkt::{Context, TestCase, TestInstance};

/// `TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TestType {
    Resolve,
    MaxAttachments,
    Compatibility,
}

/// `TestConfig`
#[derive(Clone, Copy)]
pub struct TestConfig {
    pub test_type: TestType,
    pub format: vk::Format,
    pub sample_count: u32,
    pub layer_count: u32,
    pub base_layer: u32,
    pub attachment_count: u32,
    pub width: u32,
    pub height: u32,
    pub render_pass_type: RenderPassType,
    /// `TestConfig2::resolveLevel` - the mip level the resolve target is taken at.
    /// `None` is the plain `TestConfig` the other two instances take.
    pub resolve_level: Option<u32>,
}

/// The program set every case shares. Which of its shaders a case uses follows from
/// the layer count, the channel class and the attachment count, so one collection
/// covers the whole group.
pub struct MsResolvePrograms {
    pub name: &'static str,
    pub programs: crate::vk::programs::BinaryCollection,
}

struct MultisampleResolveTestCase {
    name: String,
    config: TestConfig,
}

impl TestCase for MultisampleResolveTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        use vulkanalia::vk::InstanceV1_0;

        let c = &self.config;

        if c.format == vk::Format::A8_UNORM {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if c.layer_count > 1 && context.get_device_features().geometry_shader != vk::TRUE {
            return Err(TestError::NotSupported("geometryShader not supported".into()));
        }

        if c.render_pass_type == RenderPassType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }

        let properties = context.get_device_properties();

        if context.is_device_functionality_supported("VK_KHR_portability_subset") {
            use vulkanalia::vk::InstanceV1_1;
            let mut portability = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
            let mut features = vk::PhysicalDeviceFeatures2::builder().push_next(&mut portability);
            unsafe { context.get_instance().get_physical_device_features2(context.get_physical_device(), &mut features) };
            if portability.multisample_array_image != vk::TRUE && c.sample_count != 1 && c.layer_count != 1 {
                return Err(TestError::NotSupported(
                    "VK_KHR_portability_subset: Implementation does not support image array with multiple samples per texel".into(),
                ));
            }
        }

        if c.attachment_count > properties.limits.max_color_attachments {
            return Err(TestError::NotSupported("Required number of color attachments not supported".into()));
        }

        if c.test_type == TestType::MaxAttachments && c.attachment_count > properties.limits.max_per_stage_descriptor_input_attachments {
            return Err(TestError::NotSupported("Required number of per stage descriptor input attachments not supported".into()));
        }

        let mut usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        if c.test_type == TestType::MaxAttachments {
            usage |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
        }

        let format_properties = unsafe { context.get_instance().get_physical_device_format_properties(context.get_physical_device(), c.format) };
        let image_format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                c.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .map_err(|_| TestError::NotSupported("Image format not supported".into()))?;

        if !format_properties.optimal_tiling_features.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT) {
            return Err(TestError::NotSupported("Format can't be used as color attachment".into()));
        }

        if image_format_properties.max_extent.width < c.width
            || image_format_properties.max_extent.height < c.height
            || !image_format_properties.sample_counts.contains(sample_count_bit(c.sample_count))
            || image_format_properties.max_array_layers < c.layer_count
        {
            return Err(TestError::NotSupported("Image type not supported".into()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::renderpass_ms_resolve::MS_RESOLVE_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let base = MultisampleRenderPassTestBase { context, config: self.config };
        if self.config.test_type == TestType::MaxAttachments {
            Box::new(MaxAttachmenstsRenderPassTestInstance { base })
        } else {
            Box::new(MultisampleRenderPassTestInstance { base })
        }
    }
}

/// `sampleCountBitFromSampleCount`
fn sample_count_bit(count: u32) -> vk::SampleCountFlags {
    match count {
        1 => vk::SampleCountFlags::_1,
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        16 => vk::SampleCountFlags::_16,
        32 => vk::SampleCountFlags::_32,
        64 => vk::SampleCountFlags::_64,
        other => panic!("not a sample count: {other}"),
    }
}

/// `isAlphaOnlyFormat`
fn is_alpha_only_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| f.order == ChannelOrder::A)
}

/// `getFormatComponentWidth`
fn get_format_component_width(format: vk::Format, component_ndx: u32) -> u32 {
    use ChannelType::*;

    let tcu_format = map_vk_format(format).expect("multisample_resolve formats all map");
    match tcu_format.type_ {
        UNORM_INT8 | SNORM_INT8 | UNSIGNED_INT8 | SIGNED_INT8 => 8,
        UNORM_SHORT_10 => 10,
        UNORM_SHORT_12 => 12,
        UNORM_INT16 | SNORM_INT16 | UNSIGNED_INT16 | SIGNED_INT16 | HALF_FLOAT => 16,
        UNORM_INT24 | UNSIGNED_INT24 => 24,
        UNORM_INT32 | SNORM_INT32 | UNSIGNED_INT32 | SIGNED_INT32 | FLOAT => 32,
        FLOAT64 | UNSIGNED_INT64 | SIGNED_INT64 => 64,
        UNORM_SHORT_4444 | UNSIGNED_SHORT_4444 => 4,
        UNORM_SHORT_565 | UNSIGNED_SHORT_565 => {
            if component_ndx == 1 {
                6
            } else {
                5
            }
        }
        UNSIGNED_INT_24_8 | UNSIGNED_INT_24_8_REV | FLOAT_UNSIGNED_INT_24_8_REV => {
            if component_ndx == 0 {
                24
            } else {
                8
            }
        }
        UNORM_SHORT_1555 => {
            if component_ndx == 0 {
                1
            } else {
                5
            }
        }
        UNORM_INT_1010102_REV | SNORM_INT_1010102_REV | UNSIGNED_INT_1010102_REV | SIGNED_INT_1010102_REV => {
            if component_ndx == 3 {
                2
            } else {
                10
            }
        }
        _ => 0,
    }
}

/// `getRepresentableDiffUnorm`
fn get_representable_diff_unorm(format: vk::Format, component_ndx: u32) -> f32 {
    let size = get_format_component_width(format, component_ndx);
    1.0 / ((1u64 << size) - 1) as f32
}

/// `getRepresentableDiffSnorm`
fn get_representable_diff_snorm(format: vk::Format, component_ndx: u32) -> f32 {
    let size = get_format_component_width(format, component_ndx);
    1.0 / ((1u64 << (size - 1)) - 1) as f32
}

/// `MultisampleRenderPassTestBase::getFormatThreshold`
fn get_format_threshold(format: vk::Format) -> [f32; 4] {
    let tcu_format = map_vk_format(format).expect("multisample_resolve formats all map");
    let is_alpha_only = is_alpha_only_format(format);
    let component_count = if is_alpha_only { 4 } else { tcu_format.order.num_used_channels() };

    match tcu_format.channel_class() {
        TextureChannelClass::SignedFixedPoint => [
            if component_count >= 1 { 1.5 * get_representable_diff_snorm(format, 0) } else { 0.0 },
            if component_count >= 2 { 1.5 * get_representable_diff_snorm(format, 1) } else { 0.0 },
            if component_count >= 3 { 1.5 * get_representable_diff_snorm(format, 2) } else { 0.0 },
            if component_count == 4 { 1.5 * get_representable_diff_snorm(format, 3) } else { 0.0 },
        ],
        TextureChannelClass::UnsignedFixedPoint => [
            if component_count >= 1 && !is_alpha_only {
                1.5 * get_representable_diff_unorm(format, 0)
            } else {
                0.0
            },
            if component_count >= 2 && !is_alpha_only {
                1.5 * get_representable_diff_unorm(format, 1)
            } else {
                0.0
            },
            if component_count >= 3 && !is_alpha_only {
                1.5 * get_representable_diff_unorm(format, 2)
            } else {
                0.0
            },
            if component_count == 4 { 1.5 * get_representable_diff_unorm(format, 3) } else { 0.0 },
        ],
        TextureChannelClass::FloatingPoint => {
            if tcu_format.type_ == ChannelType::HALF_FLOAT {
                [0.005; 4]
            } else {
                [0.00001; 4]
            }
        }
        _ => [0.001; 4],
    }
}

// ---------------------------------------------------------------------------------
// `MultisampleRenderPassTestBase` + `MultisampleRenderPassTestInstance`
// ---------------------------------------------------------------------------------

/// `MultisampleRenderPassTestBase` - the state and helpers upstream's two instances
/// inherit. Composed rather than inherited, and reached through `Deref` so a call
/// still reads like the C++ member call it was.
struct MultisampleRenderPassTestBase<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

/// `MultisampleRenderPassTestInstance`, which also covers
/// `MultisampleRenderPassResolveLevelTestInstance` - upstream's subclass only forwards
/// `TestConfig2::resolveLevel` as the render level, which `TestConfig::resolve_level`
/// already carries.
struct MultisampleRenderPassTestInstance<'a> {
    base: MultisampleRenderPassTestBase<'a>,
}

impl<'a> std::ops::Deref for MultisampleRenderPassTestInstance<'a> {
    type Target = MultisampleRenderPassTestBase<'a>;

    fn deref(&self) -> &Self::Target {
        &self.base
    }
}

/// What upstream keeps as instance state across its many `iterate()` calls. This port
/// runs the sample-mask loop inside a single `iterate()`, so it lives in a local.
///
/// `m_sum`/`m_sumSrgb` are `tcu::TextureLevel`s upstream only because they get logged
/// as images at the end; nothing samples them, so a flat accumulator is enough here.
struct ResolveState {
    sum: Vec<[f32; 4]>,
    sum_srgb: Vec<[f32; 4]>,
    sample_mask: u32,
    /// `m_resultCollector` - the first failure, kept so the run continues over the
    /// remaining sample masks exactly as upstream's does.
    failure: Option<String>,
}

impl MultisampleRenderPassTestBase<'_> {
    /// `m_testCompatibility`
    fn test_compatibility(&self) -> bool {
        self.config.test_type == TestType::Compatibility
    }

    /// `totalLayers`
    fn total_layers(&self) -> u32 {
        self.config.layer_count + self.config.base_layer
    }

    /// `createImages`
    fn create_images(
        &self,
        sample_count_bit: vk::SampleCountFlags,
        usage: vk::ImageUsageFlags,
        width: u32,
        height: u32,
        mip_levels: u32,
    ) -> Result<Vec<ImageWithMemory<'_>>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(self.config.format)
            .extent(vk::Extent3D { width, height, depth: 1 })
            .mip_levels(mip_levels)
            .array_layers(self.total_layers())
            .samples(sample_count_bit)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        (0..self.config.attachment_count)
            .map(|_| ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY))
            .collect()
    }

    /// `createImageViews`
    fn create_image_views(&self, images: &[ImageWithMemory<'_>], mip_level: u32, base_layer: u32) -> Result<Vec<Unique<'_, vk::ImageView>>, TestError> {
        let device = self.context.get_device();
        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: mip_level,
            level_count: 1,
            base_array_layer: base_layer,
            layer_count: self.config.layer_count,
        };
        images
            .iter()
            .map(|image| make_image_view(device, image.get(), vk::ImageViewType::_2D_ARRAY, self.config.format, range))
            .collect()
    }

    /// `createBuffers`
    fn create_buffers(&self, width: u32, height: u32, mip_levels: u32) -> Result<Vec<BufferWithMemory<'_>>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let mut size: vk::DeviceSize = 0;
        let (mut w, mut h) = (width, height);
        for _ in 0..mip_levels {
            size += vk::DeviceSize::from(w * h);
            h /= 2;
            w /= 2;
        }

        let info = make_buffer_create_info(
            size * vk::DeviceSize::from(self.total_layers()) * vk::DeviceSize::from(self.get_pixel_size()),
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        );
        (0..self.config.attachment_count)
            .map(|_| BufferWithMemory::new(device, allocator, info, MemoryRequirement::HOST_VISIBLE))
            .collect()
    }

    /// `getPixelSize`
    fn get_pixel_size(&self) -> u32 {
        map_vk_format(self.config.format).and_then(|f| f.pixel_size()).expect("multisample_resolve formats all map")
    }

    /// `getClearValue`
    fn get_clear_value(&self) -> vk::ClearValue {
        let tcu_format = map_vk_format(self.config.format).expect("multisample_resolve formats all map");
        match tcu_format.channel_class() {
            TextureChannelClass::FloatingPoint | TextureChannelClass::SignedFixedPoint => vk::ClearValue {
                color: vk::ClearColorValue { float32: [-1.0; 4] },
            },
            TextureChannelClass::UnsignedFixedPoint => vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
            TextureChannelClass::SignedInteger => vk::ClearValue {
                color: vk::ClearColorValue { int32: [-128; 4] },
            },
            _ => vk::ClearValue {
                color: vk::ClearColorValue { uint32: [0; 4] },
            },
        }
    }

    /// `clearAttachments`
    fn clear_attachments(&self, command_buffer: vk::CommandBuffer) {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let value = self.get_clear_value();
        let colors: Vec<vk::ClearAttachment> = (0..self.config.attachment_count)
            .map(|attachment_ndx| vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                color_attachment: attachment_ndx,
                clear_value: value,
            })
            .collect();
        let rect = vk::ClearRect {
            rect: vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: self.config.width,
                    height: self.config.height,
                },
            },
            base_array_layer: 0,
            layer_count: self.config.layer_count,
        };
        unsafe { device.cmd_clear_attachments(command_buffer, &colors, &[rect]) };
    }
}

impl MultisampleRenderPassTestInstance<'_> {
    /// `m_renderLevel`
    fn render_level(&self) -> u32 {
        self.config.resolve_level.unwrap_or(0)
    }

    /// `createRenderPass` for both traits, plus `createRenderPassSwitch`.
    fn create_render_pass(&self, used_resolve_attachment: bool) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let mut attachments = Vec::with_capacity(2 * c.attachment_count as usize);
        let mut color_attachment_refs = Vec::with_capacity(c.attachment_count as usize);
        let mut resolve_attachment_refs = Vec::with_capacity(c.attachment_count as usize);

        for _ in 0..c.attachment_count {
            color_attachment_refs.push((attachments.len() as u32, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL));
            attachments.push(vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: c.format,
                samples: sample_count_bit(c.sample_count),
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::DONT_CARE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            });

            let attachment_id = if used_resolve_attachment { attachments.len() as u32 } else { vk::ATTACHMENT_UNUSED };
            resolve_attachment_refs.push((attachment_id, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL));
            attachments.push(vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: c.format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            });
        }

        let handle = if c.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

            let attachments2: Vec<vk::AttachmentDescription2> = attachments
                .iter()
                .map(|a| {
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
                })
                .collect();
            let to_ref2 = |&(attachment, layout): &(u32, vk::ImageLayout)| vk::AttachmentReference2::builder().attachment(attachment).layout(layout).build();
            let color_refs2: Vec<vk::AttachmentReference2> = color_attachment_refs.iter().map(to_ref2).collect();
            let resolve_refs2: Vec<vk::AttachmentReference2> = resolve_attachment_refs.iter().map(to_ref2).collect();
            let subpasses = [vk::SubpassDescription2::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .view_mask(0)
                .color_attachments(&color_refs2)
                .resolve_attachments(&resolve_refs2)
                .build()];
            let info = vk::RenderPassCreateInfo2::builder().attachments(&attachments2).subpasses(&subpasses);
            unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?
        } else {
            let to_ref = |&(attachment, layout): &(u32, vk::ImageLayout)| vk::AttachmentReference { attachment, layout };
            let color_refs: Vec<vk::AttachmentReference> = color_attachment_refs.iter().map(to_ref).collect();
            let resolve_refs: Vec<vk::AttachmentReference> = resolve_attachment_refs.iter().map(to_ref).collect();
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_refs)
                .resolve_attachments(&resolve_refs)
                .build()];
            let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?
        };

        Ok(Unique::new(device, handle))
    }

    /// `createRenderPipelineLayout`
    fn create_render_pipeline_layout(&self) -> Result<Unique<'_, vk::PipelineLayout>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let push_constant = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 4,
        };
        let info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(std::slice::from_ref(&push_constant));
        let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
        Ok(Unique::new(device, handle))
    }

    /// `Programs::init`, reduced to picking the compiled shader a case needs - the
    /// GLSL parameters upstream substitutes are baked into the committed SPIR-V.
    fn fragment_shader_name(&self) -> String {
        let tcu_format = map_vk_format(self.config.format).expect("multisample_resolve formats all map");
        let type_prefix = match tcu_format.channel_class() {
            TextureChannelClass::UnsignedInteger => "u",
            TextureChannelClass::SignedInteger => "i",
            _ => "f",
        };
        format!("quad_frag_{type_prefix}_{}", self.config.attachment_count)
    }

    /// `createRenderPipeline`
    fn create_render_pipeline(
        &self,
        render_pass: vk::RenderPass,
        pipeline_layout: vk::PipelineLayout,
        vert: vk::ShaderModule,
        geom: Option<vk::ShaderModule>,
        frag: vk::ShaderModule,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();

        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let mut stages = vec![stage(vk::ShaderStageFlags::VERTEX, vert)];
        if let Some(module) = geom {
            stages.push(stage(vk::ShaderStageFlags::GEOMETRY, module));
        }
        stages.push(stage(vk::ShaderStageFlags::FRAGMENT, frag));

        // Disable blending
        let attachment_blend_state = vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::SRC_ALPHA,
            dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ONE,
            dst_alpha_blend_factor: vk::BlendFactor::ONE,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::R | vk::ColorComponentFlags::G | vk::ColorComponentFlags::B | vk::ColorComponentFlags::A,
        };
        let attachment_blend_states = vec![attachment_blend_state; c.attachment_count as usize];

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: c.width as f32,
            height: c.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: c.width, height: c.height },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(sample_count_bit(c.sample_count));

        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::INCREMENT_AND_WRAP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: !0u32,
            write_mask: !0u32,
            reference: 0xFF / (c.sample_count + 1),
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(false)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .stencil_test_enable(true)
            .front(stencil_op)
            .back(stencil_op)
            .max_depth_bounds(1.0);
        let blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op(vk::LogicOp::COPY)
            .attachments(&attachment_blend_states);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&blend_state)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `drawCommands`
    fn draw_commands(&self, cmd_buffer: vk::CommandBuffer, pipeline: vk::Pipeline, pipeline_layout: vk::PipelineLayout, sample_mask: u32) {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();

        // Clear everything to black
        self.clear_attachments(cmd_buffer);

        // Render black samples
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_push_constants(cmd_buffer, pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &sample_mask.to_ne_bytes());
            device.cmd_draw(cmd_buffer, 6, 1, 0, 0);
        }
    }

    /// `submit`
    #[allow(clippy::too_many_arguments)]
    fn submit(
        &self,
        command_pool: vk::CommandPool,
        render_pass: vk::RenderPass,
        render_pass_compatible: Option<vk::RenderPass>,
        framebuffer: vk::Framebuffer,
        pipeline: vk::Pipeline,
        pipeline_layout: vk::PipelineLayout,
        singlesample_images: &[ImageWithMemory<'_>],
        buffers: &[BufferWithMemory<'_>],
        sample_mask: u32,
    ) -> Result<(), TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let render_level = self.render_level();
        let command_buffer = allocate_command_buffer(device, command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *command_buffer)?;

        // Memory barriers between previous copies and rendering
        {
            let barriers: Vec<vk::ImageMemoryBarrier> = singlesample_images
                .iter()
                .map(|image| {
                    vk::ImageMemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::TRANSFER_READ)
                        .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                        .old_layout(vk::ImageLayout::UNDEFINED)
                        .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .image(image.get())
                        .subresource_range(vk::ImageSubresourceRange {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            base_mip_level: render_level,
                            level_count: 1,
                            base_array_layer: c.base_layer,
                            layer_count: c.layer_count,
                        })
                        .build()
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
            }
        }

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(if self.test_compatibility() {
                render_pass_compatible.expect("the compatibility cases build a second render pass")
            } else {
                render_pass
            })
            .framebuffer(framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D { width: c.width, height: c.height },
            });

        if c.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(*command_buffer, &begin_info, &subpass_begin_info) };
        } else {
            unsafe { device.cmd_begin_render_pass(*command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }

        self.draw_commands(*command_buffer, pipeline, pipeline_layout, sample_mask);

        if c.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(*command_buffer, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(*command_buffer) };
        }

        // Memory barriers between rendering and copying image to buffer.
        // The layers below the base layer are never rendered to, so nothing has moved
        // them out of UNDEFINED; the copy still reads them.
        if c.base_layer > 0 {
            let barriers: Vec<vk::ImageMemoryBarrier> = singlesample_images
                .iter()
                .map(|image| {
                    vk::ImageMemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                        .old_layout(vk::ImageLayout::UNDEFINED)
                        .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .image(image.get())
                        .subresource_range(vk::ImageSubresourceRange {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            base_mip_level: render_level,
                            level_count: 1,
                            base_array_layer: 0,
                            layer_count: c.base_layer,
                        })
                        .build()
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
            }
        }

        for (image, buffer) in singlesample_images.iter().zip(buffers) {
            // assume that buffer(s) have enough memory to store desired amount of mipmaps
            self.copy_image_to_buffer(*command_buffer, image.get(), buffer.get());
        }

        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), *command_buffer)?;

        for buffer in buffers {
            invalidate_alloc(device, buffer.get_allocation())?;
        }
        Ok(())
    }

    /// `vk::copyImageToBuffer`, the mip-level overload. Only the level being rendered
    /// to is copied, at the byte offset the levels below it would occupy.
    fn copy_image_to_buffer(&self, command_buffer: vk::CommandBuffer, image: vk::Image, buffer: vk::Buffer) {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let mip_level = self.render_level();

        let barrier = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
            .old_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(image)
            .subresource_range(vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: mip_level,
                level_count: 1,
                base_array_layer: 0,
                layer_count: self.total_layers(),
            });
        unsafe {
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        let (offset, width, height) = self.buffer_level_offset();
        let region = vk::BufferImageCopy::builder()
            .buffer_offset(offset)
            .buffer_row_length(0)
            .buffer_image_height(0)
            .image_subresource(vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level,
                base_array_layer: 0,
                layer_count: self.total_layers(),
            })
            .image_offset(vk::Offset3D { x: 0, y: 0, z: 0 })
            .image_extent(vk::Extent3D { width, height, depth: 1 });
        unsafe {
            device.cmd_copy_image_to_buffer(command_buffer, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]);

            let buffer_barrier = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(buffer)
                .offset(offset)
                .size(vk::WHOLE_SIZE);
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

    /// The byte offset of the rendered mip level inside the readback buffer, and that
    /// level's extent. `copyImageToBuffer` and `verify` compute this the same way, and
    /// neither multiplies by the layer count - the layers sit contiguously after it.
    fn buffer_level_offset(&self) -> (vk::DeviceSize, u32, u32) {
        let render_level = self.render_level();
        let pixel_size = self.get_pixel_size();
        let mut offset: vk::DeviceSize = 0;
        let mut width = (1 << render_level) * self.config.width;
        let mut height = (1 << render_level) * self.config.height;
        for _ in 0..render_level {
            offset += vk::DeviceSize::from(width * height * pixel_size);
            height /= 2;
            width /= 2;
        }
        (offset, width, height)
    }

    /// `verify`
    fn verify(&self, state: &mut ResolveState, accesses: &[ConstPixelBufferAccess<'_>]) {
        let c = &self.config;
        let format = map_vk_format(c.format).expect("multisample_resolve formats all map");
        let channel_class = format.channel_class();
        let total_layers = self.total_layers();
        let full_mask = (0x1u32 << c.sample_count) - 1;
        let index = |x: u32, y: u32, z: u32| (z * c.height * c.width + y * c.width + x) as usize;

        match channel_class {
            TextureChannelClass::FloatingPoint | TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
                let is_alpha_only = is_alpha_only_format(c.format);
                let component_count = if is_alpha_only { 4 } else { format.order.num_used_channels() };
                let mut is_ok = true;
                let (clear_value, render_value) = match channel_class {
                    TextureChannelClass::UnsignedFixedPoint => (0.0f32, 1.0f32),
                    _ => (-1.0f32, 1.0f32),
                };

                let uniform = |value: f32| {
                    [
                        if is_alpha_only { 0.0 } else { value },
                        if component_count > 1 && !is_alpha_only { value } else { 0.0 },
                        if component_count > 2 && !is_alpha_only { value } else { 0.0 },
                        if component_count > 3 { value } else { 1.0 },
                    ]
                };

                for z in c.base_layer..total_layers {
                    for y in 0..c.height {
                        for x in 0..c.width {
                            // Color has to be black if no samples were covered, white if all samples were covered or same in every attachment
                            let first_color = accesses[0].get_pixel(x, y, z);
                            let ref_color = if state.sample_mask == 0 {
                                uniform(clear_value)
                            } else if state.sample_mask == full_mask {
                                uniform(render_value)
                            } else {
                                first_color
                            };

                            for access in accesses {
                                if access.get_pixel(x, y, z) != ref_color {
                                    is_ok = false;
                                    break;
                                }
                            }

                            let i = index(x, y, z);
                            let linear = if format.order.is_srgb() { srgb_to_linear(first_color) } else { first_color };
                            for ch in 0..4 {
                                state.sum[i][ch] += linear[ch];
                                state.sum_srgb[i][ch] += first_color[ch];
                            }
                        }
                    }
                }

                if !is_ok {
                    if state.sample_mask == 0 {
                        state.fail("Empty sample mask didn't produce correct pixel values");
                    } else if state.sample_mask == full_mask {
                        state.fail("Full sample mask didn't produce correct pixel values");
                    } else {
                        state.fail("Resolve is inconsistent between attachments");
                    }
                }
            }

            TextureChannelClass::UnsignedInteger => {
                let component_count = format.order.num_used_channels();
                let bit_depth = get_texture_format_bit_depth(format);
                let render_value: [u32; 4] = std::array::from_fn(|i| {
                    if (i as u32) < component_count {
                        (1u32 << bit_depth[i].min(8)) - 1
                    } else {
                        [0u32, 0, 0, 1][i]
                    }
                });
                let clear_value: [u32; 4] = std::array::from_fn(|i| if (i as u32) < component_count { 0 } else { [0u32, 0, 0, 1][i] });
                let mut unexpected_values = false;
                let mut inconsistent_components = false;
                let mut inconsistent_attachments = false;

                for z in c.base_layer..total_layers {
                    for y in 0..c.height {
                        for x in 0..c.width {
                            // Color has to be all zeros if no samples were covered, all 255 if all samples were covered or consistent across all attachments
                            let ref_color: [u32; 4] = if state.sample_mask == 0 {
                                clear_value
                            } else if state.sample_mask == full_mask {
                                render_value
                            } else {
                                accesses[0].get_pixel_uint64(x, y, z).map(|v| v as u32)
                            };

                            // If reference value was taken from first attachment, check that it is valid value i.e. clear or render value
                            if state.sample_mask != 0 && state.sample_mask != full_mask {
                                // Each component must be resolved same way
                                let is_render_value: [bool; 4] = std::array::from_fn(|i| ref_color[i] == render_value[i]);
                                let is_clear_value: [bool; 4] = std::array::from_fn(|i| ref_color[i] == clear_value[i]);
                                unexpected_values |= (0..4).any(|i| !(is_render_value[i] || is_clear_value[i]));
                                inconsistent_components |= !(is_render_value.iter().all(|&v| v) || is_clear_value.iter().all(|&v| v));
                            }

                            for access in accesses {
                                if access.get_pixel_uint64(x, y, z).map(|v| v as u32) != ref_color {
                                    inconsistent_attachments = true;
                                    break;
                                }
                            }
                        }
                    }
                }

                self.report_integer_failures(state, unexpected_values, inconsistent_components, inconsistent_attachments);
            }

            TextureChannelClass::SignedInteger => {
                let component_count = format.order.num_used_channels();
                let bit_depth = get_texture_format_bit_depth(format);
                let render_value: [i32; 4] = std::array::from_fn(|i| {
                    if (i as u32) < component_count {
                        (1i32 << (bit_depth[i].min(8) - 1)) - 1
                    } else {
                        [0i32, 0, 0, 1][i]
                    }
                });
                let clear_value: [i32; 4] = std::array::from_fn(|i| {
                    if (i as u32) < component_count {
                        -(1i32 << (bit_depth[i].min(8) - 1))
                    } else {
                        [0i32, 0, 0, 1][i]
                    }
                });
                let mut unexpected_values = false;
                let mut inconsistent_components = false;
                let mut inconsistent_attachments = false;

                for z in c.base_layer..total_layers {
                    for y in 0..c.height {
                        for x in 0..c.width {
                            let ref_color: [i32; 4] = if state.sample_mask == 0 {
                                clear_value
                            } else if state.sample_mask == full_mask {
                                render_value
                            } else {
                                accesses[0].get_pixel_int(x, y, z)
                            };

                            if state.sample_mask != 0 && state.sample_mask != full_mask {
                                let is_render_value: [bool; 4] = std::array::from_fn(|i| ref_color[i] == render_value[i]);
                                let is_clear_value: [bool; 4] = std::array::from_fn(|i| ref_color[i] == clear_value[i]);
                                unexpected_values |= (0..4).any(|i| !(is_render_value[i] || is_clear_value[i]));
                                inconsistent_components |= !(is_render_value.iter().all(|&v| v) || is_clear_value.iter().all(|&v| v));
                            }

                            for access in accesses {
                                if access.get_pixel_int(x, y, z) != ref_color {
                                    inconsistent_attachments = true;
                                    break;
                                }
                            }
                        }
                    }
                }

                self.report_integer_failures(state, unexpected_values, inconsistent_components, inconsistent_attachments);
            }

            TextureChannelClass::Last => unreachable!("no colour format maps to the combined depth/stencil class"),
        }
    }

    /// The failure branch the two integer classes share verbatim upstream.
    fn report_integer_failures(&self, state: &mut ResolveState, unexpected_values: bool, inconsistent_components: bool, inconsistent_attachments: bool) {
        if !(unexpected_values || inconsistent_components || inconsistent_attachments) {
            return;
        }

        let full_mask = (0x1u32 << self.config.sample_count) - 1;
        if state.sample_mask == 0 {
            state.fail("Empty sample mask didn't produce correct pixels");
        } else if state.sample_mask == full_mask {
            state.fail("Full sample mask didn't produce correct pixels");
        } else {
            if unexpected_values {
                state.fail("Resolve produced unexpected values");
            }
            if inconsistent_components {
                state.fail("Different components of attachment were resolved to different values.");
            }
            if inconsistent_attachments {
                state.fail("Different attachments were resolved to different values.");
            }
        }
    }

    /// The average check `iterate` runs once, after the last sample mask.
    fn verify_average(&self, state: &ResolveState) -> Option<String> {
        let c = &self.config;
        let format = map_vk_format(c.format).expect("multisample_resolve formats all map");
        let channel_class = format.channel_class();
        if !matches!(
            channel_class,
            TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint | TextureChannelClass::FloatingPoint
        ) {
            return None;
        }

        let threshold = get_format_threshold(c.format);
        let is_alpha_only = is_alpha_only_format(c.format);
        let component_count = if is_alpha_only { 4 } else { format.order.num_used_channels() };
        let expected_average = match channel_class {
            TextureChannelClass::UnsignedFixedPoint => [
                if is_alpha_only { 0.0 } else { 0.5 },
                if component_count > 1 && !is_alpha_only { 0.5 } else { 0.0 },
                if component_count > 2 && !is_alpha_only { 0.5 } else { 0.0 },
                if component_count > 3 { 0.5 } else { 1.0 },
            ],
            _ => [0.0, 0.0, 0.0, if component_count > 3 { 0.0 } else { 1.0 }],
        };

        let divisor = (0x1u32 << c.sample_count) as f32;
        let mut is_ok = true;
        for z in c.base_layer..self.total_layers() {
            for y in 0..c.height {
                for x in 0..c.width {
                    let i = (z * c.height * c.width + y * c.width + x) as usize;
                    let average: [f32; 4] = std::array::from_fn(|ch| state.sum[i][ch] / divisor);
                    let diff: [f32; 4] = std::array::from_fn(|ch| (average[ch] - expected_average[ch]).abs());

                    let over = |d: [f32; 4]| (0..4).any(|ch| d[ch] > threshold[ch]);
                    let fail_threshold = if !format.order.is_srgb() {
                        over(diff)
                    } else {
                        // Spec doesn't restrict implementation to downsample in linear color space. So, comparing both non linear and
                        // linear diff's in case of srgb formats.
                        let average_srgb: [f32; 4] = std::array::from_fn(|ch| state.sum_srgb[i][ch] / divisor);
                        let diff_srgb: [f32; 4] = std::array::from_fn(|ch| (average_srgb[ch] - expected_average[ch]).abs());
                        over(diff) && over(diff_srgb)
                    };

                    if fail_threshold {
                        is_ok = false;
                    }
                }
            }
        }

        (!is_ok).then(|| "Average resolved values differ from expected average values".to_owned())
    }
}

impl ResolveState {
    fn fail(&mut self, message: &str) {
        if self.failure.is_none() {
            self.failure = Some(message.to_owned());
        }
    }
}

impl TestInstance for MultisampleRenderPassTestInstance<'_> {
    /// The constructor and `iterate` together: upstream re-enters `iterate` once per
    /// sample mask and keeps everything else alive in the instance, which this port
    /// cannot do because `iterate` is called exactly once.
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        let c = self.config;
        let device = self.context.get_device();
        let render_level = self.render_level();

        let multisample_images = self.create_images(sample_count_bit(c.sample_count), vk::ImageUsageFlags::COLOR_ATTACHMENT, c.width, c.height, 1)?;
        let multisample_image_views = self.create_image_views(&multisample_images, 0, 0)?;

        let singlesample_images = self.create_images(
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            (1 << render_level) * c.width,
            (1 << render_level) * c.height,
            render_level + 1,
        )?;
        let singlesample_image_views = self.create_image_views(&singlesample_images, render_level, c.base_layer)?;

        // The "normal" render pass has an unused resolve attachment when testing compatibility.
        let render_pass = self.create_render_pass(!self.test_compatibility())?;
        // The compatible render pass is always created with a used resolve attachment.
        let render_pass_compatible = self.test_compatibility().then(|| self.create_render_pass(true)).transpose()?;

        let attachments: Vec<vk::ImageView> = multisample_image_views.iter().zip(&singlesample_image_views).flat_map(|(ms, ss)| [**ms, **ss]).collect();
        let framebuffer = make_framebuffer(device, *render_pass, &attachments, c.width, c.height, c.layer_count)?;

        let render_pipeline_layout = self.create_render_pipeline_layout()?;
        let programs = self.context.get_binary_collection();
        let vert = create_shader_module(device, programs.get("quad_vert")?)?;
        let geom = (c.layer_count != 1)
            .then(|| programs.get(&format!("geom_{}", c.layer_count)))
            .transpose()?
            .map(|b| create_shader_module(device, b))
            .transpose()?;
        let frag = create_shader_module(device, programs.get(&self.fragment_shader_name())?)?;
        let render_pipeline = self.create_render_pipeline(*render_pass, *render_pipeline_layout, *vert, geom.as_deref().copied(), *frag)?;

        let buffers = self.create_buffers((1 << render_level) * c.width, (1 << render_level) * c.height, render_level + 1)?;
        let command_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;

        let pixel_count = (c.width * c.height * self.total_layers()) as usize;
        let mut state = ResolveState {
            sum: vec![[0.0; 4]; pixel_count],
            sum_srgb: vec![[0.0; 4]; pixel_count],
            sample_mask: 0,
            failure: None,
        };

        let tcu_format = map_vk_format(c.format).expect("multisample_resolve formats all map");
        let (offset, _, _) = self.buffer_level_offset();
        let level_size = (c.width * c.height * self.total_layers() * self.get_pixel_size()) as usize;
        let full_mask = (0x1u32 << c.sample_count) - 1;

        loop {
            self.submit(
                *command_pool,
                *render_pass,
                render_pass_compatible.as_deref().copied(),
                *framebuffer,
                *render_pipeline,
                *render_pipeline_layout,
                &singlesample_images,
                &buffers,
                state.sample_mask,
            )?;

            let bytes: Vec<&[u8]> = buffers
                .iter()
                .map(|buffer| unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().add(offset as usize), level_size) })
                .collect();
            let accesses: Vec<ConstPixelBufferAccess<'_>> = bytes
                .iter()
                .map(|data| ConstPixelBufferAccess::new(tcu_format, [c.width, c.height, self.total_layers()], data))
                .collect();
            self.verify(&mut state, &accesses);

            if state.sample_mask == full_mask {
                break;
            }
            state.sample_mask += 1;
        }

        if let Some(message) = self.verify_average(&state) {
            state.fail(&message);
        }

        Ok(match state.failure {
            Some(message) => TestStatus::fail(message),
            None => TestStatus::pass("Pass"),
        })
    }
}

// ---------------------------------------------------------------------------------
// `MaxAttachmenstsRenderPassTestInstance`
// ---------------------------------------------------------------------------------

/// `MaxAttachmenstsRenderPassTestInstance` (upstream's spelling). Two subpasses: the
/// first resolves every multisample attachment, the second reads all of them back as
/// input attachments and merges them pairwise into the first half.
struct MaxAttachmenstsRenderPassTestInstance<'a> {
    base: MultisampleRenderPassTestBase<'a>,
}

impl<'a> std::ops::Deref for MaxAttachmenstsRenderPassTestInstance<'a> {
    type Target = MultisampleRenderPassTestBase<'a>;

    fn deref(&self) -> &Self::Target {
        &self.base
    }
}

/// `chooseInputImageLayout` - GENERAL for everything that is not dynamic rendering.
const INPUT_IMAGE_READ_LAYOUT: vk::ImageLayout = vk::ImageLayout::GENERAL;

impl MaxAttachmenstsRenderPassTestInstance<'_> {
    /// `createDescriptorSetLayout`
    fn create_descriptor_set_layout(&self) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let bindings: Vec<vk::DescriptorSetLayoutBinding> = (0..self.config.attachment_count)
            .map(|binding| vk::DescriptorSetLayoutBinding {
                binding,
                descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                immutable_samplers: std::ptr::null(),
            })
            .collect();
        let info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let handle = unsafe { device.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?;
        Ok(Unique::new(device, handle))
    }

    /// `createDescriptorPool`
    fn create_descriptor_pool(&self) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::INPUT_ATTACHMENT,
            descriptor_count: self.config.attachment_count,
        }];
        let info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(1)
            .pool_sizes(&sizes);
        let handle = unsafe { device.create_descriptor_pool(&info, None) }.vk_check("vkCreateDescriptorPool")?;
        Ok(Unique::new(device, handle))
    }

    /// `createDescriptorSet`
    fn create_descriptor_set<'b>(
        &'b self,
        pool: vk::DescriptorPool,
        layout: vk::DescriptorSetLayout,
        singlesample_image_views: &[Unique<'_, vk::ImageView>],
    ) -> Result<UniqueDescriptorSet<'b>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let device = self.context.get_device();
        let descriptor_set = make_descriptor_set(device, pool, layout)?;

        let image_infos: Vec<vk::DescriptorImageInfo> = singlesample_image_views
            .iter()
            .map(|view| vk::DescriptorImageInfo {
                sampler: vk::Sampler::default(),
                image_view: **view,
                image_layout: INPUT_IMAGE_READ_LAYOUT,
            })
            .collect();
        let writes: Vec<vk::WriteDescriptorSet> = image_infos
            .iter()
            .enumerate()
            .map(|(idx, info)| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(idx as u32)
                    .dst_array_element(0)
                    .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                    .image_info(std::slice::from_ref(info))
                    .build()
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        Ok(descriptor_set)
    }

    /// `createRenderPass` for both traits, plus `createRenderPassSwitch`.
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let mut attachments = Vec::with_capacity(2 * c.attachment_count as usize);
        let mut sp0_color_refs = Vec::with_capacity(c.attachment_count as usize);
        let mut sp0_resolve_refs = Vec::with_capacity(c.attachment_count as usize);
        let mut sp1_in_refs = Vec::with_capacity(c.attachment_count as usize);
        let mut sp1_color_refs = Vec::with_capacity(c.attachment_count as usize / 2);

        for attachment_ndx in 0..c.attachment_count {
            // define first subpass outputs
            sp0_color_refs.push((attachments.len() as u32, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, vk::ImageAspectFlags::empty()));
            attachments.push(vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: c.format,
                samples: sample_count_bit(c.sample_count),
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            });

            // define first subpass resolve attachments
            sp0_resolve_refs.push((attachments.len() as u32, vk::ImageLayout::GENERAL, vk::ImageAspectFlags::empty()));
            attachments.push(vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: c.format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::GENERAL,
            });

            // define second subpass inputs
            sp1_in_refs.push((attachments.len() as u32 - 1, vk::ImageLayout::GENERAL, vk::ImageAspectFlags::COLOR));

            // define second subpass outputs - it merges pairs of
            // results that were produced by the first subpass
            if attachment_ndx < c.attachment_count / 2 {
                sp1_color_refs.push((attachments.len() as u32 - 1, vk::ImageLayout::GENERAL, vk::ImageAspectFlags::empty()));
            }
        }

        let handle = if c.render_pass_type == RenderPassType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

            let attachments2: Vec<vk::AttachmentDescription2> = attachments.iter().map(to_attachment_description2).collect();
            let sp0_color2: Vec<vk::AttachmentReference2> = sp0_color_refs.iter().map(to_attachment_reference2).collect();
            let sp0_resolve2: Vec<vk::AttachmentReference2> = sp0_resolve_refs.iter().map(to_attachment_reference2).collect();
            let sp1_in2: Vec<vk::AttachmentReference2> = sp1_in_refs.iter().map(to_attachment_reference2).collect();
            let sp1_color2: Vec<vk::AttachmentReference2> = sp1_color_refs.iter().map(to_attachment_reference2).collect();
            let subpasses = [
                vk::SubpassDescription2::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .view_mask(0)
                    .color_attachments(&sp0_color2)
                    .resolve_attachments(&sp0_resolve2)
                    .build(),
                vk::SubpassDescription2::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .view_mask(0)
                    .input_attachments(&sp1_in2)
                    .color_attachments(&sp1_color2)
                    .build(),
            ];
            let dependencies = [vk::SubpassDependency2::builder()
                .src_subpass(0)
                .dst_subpass(1)
                .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
                .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                .view_offset(0)
                .build()];
            let info = vk::RenderPassCreateInfo2::builder()
                .attachments(&attachments2)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?
        } else {
            let sp0_color: Vec<vk::AttachmentReference> = sp0_color_refs.iter().map(to_attachment_reference).collect();
            let sp0_resolve: Vec<vk::AttachmentReference> = sp0_resolve_refs.iter().map(to_attachment_reference).collect();
            let sp1_in: Vec<vk::AttachmentReference> = sp1_in_refs.iter().map(to_attachment_reference).collect();
            let sp1_color: Vec<vk::AttachmentReference> = sp1_color_refs.iter().map(to_attachment_reference).collect();
            let subpasses = [
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .color_attachments(&sp0_color)
                    .resolve_attachments(&sp0_resolve)
                    .build(),
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .input_attachments(&sp1_in)
                    .color_attachments(&sp1_color)
                    .build(),
            ];
            let dependencies = [vk::SubpassDependency::builder()
                .src_subpass(0)
                .dst_subpass(1)
                .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
                .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                .build()];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses)
                .dependencies(&dependencies);
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?
        };

        Ok(Unique::new(device, handle))
    }

    /// `Programs::init` for `MAX_ATTACMENTS`, again reduced to a shader lookup.
    fn fragment_shader_name(&self, second_subpass: bool) -> String {
        let tcu_format = map_vk_format(self.config.format).expect("multisample_resolve formats all map");
        let type_prefix = match tcu_format.channel_class() {
            TextureChannelClass::UnsignedInteger => "u",
            TextureChannelClass::SignedInteger => "i",
            _ => "f",
        };
        format!("quad_frag_sp{}_{type_prefix}_{}", u32::from(second_subpass), self.config.attachment_count)
    }

    /// `createRenderPipeline`
    fn create_render_pipeline(
        &self,
        render_pass: vk::RenderPass,
        pipeline_layout: vk::PipelineLayout,
        second_subpass: bool,
        vert: vk::ShaderModule,
        geom: Option<vk::ShaderModule>,
        frag: vk::ShaderModule,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let sample_count = if second_subpass { vk::SampleCountFlags::_1 } else { sample_count_bit(c.sample_count) };
        let blend_states_count = if second_subpass { c.attachment_count / 2 } else { c.attachment_count };

        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let mut stages = vec![stage(vk::ShaderStageFlags::VERTEX, vert)];
        if let Some(module) = geom {
            stages.push(stage(vk::ShaderStageFlags::GEOMETRY, module));
        }
        stages.push(stage(vk::ShaderStageFlags::FRAGMENT, frag));

        // Disable blending
        let attachment_blend_states = vec![
            vk::PipelineColorBlendAttachmentState {
                blend_enable: vk::FALSE,
                src_color_blend_factor: vk::BlendFactor::SRC_ALPHA,
                dst_color_blend_factor: vk::BlendFactor::ONE_MINUS_SRC_ALPHA,
                color_blend_op: vk::BlendOp::ADD,
                src_alpha_blend_factor: vk::BlendFactor::ONE,
                dst_alpha_blend_factor: vk::BlendFactor::ONE,
                alpha_blend_op: vk::BlendOp::ADD,
                color_write_mask: vk::ColorComponentFlags::R | vk::ColorComponentFlags::G | vk::ColorComponentFlags::B | vk::ColorComponentFlags::A,
            };
            blend_states_count as usize
        ];

        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: c.width as f32,
            height: c.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: c.width, height: c.height },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(sample_count);

        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::INCREMENT_AND_WRAP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: !0u32,
            write_mask: !0u32,
            reference: 0xFF / (c.sample_count + 1),
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(false)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .stencil_test_enable(true)
            .front(stencil_op)
            .back(stencil_op)
            .max_depth_bounds(1.0);
        let blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op(vk::LogicOp::COPY)
            .attachments(&attachment_blend_states);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&blend_state)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(u32::from(second_subpass));
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `submit`, including `postRenderCommands`
    #[allow(clippy::too_many_arguments)]
    fn submit(
        &self,
        command_pool: vk::CommandPool,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
        pipeline_pass0: vk::Pipeline,
        pipeline_layout_pass1: vk::PipelineLayout,
        pipeline_pass1: vk::Pipeline,
        descriptor_set: vk::DescriptorSet,
        singlesample_images: &[ImageWithMemory<'_>],
        buffers: &[BufferWithMemory<'_>],
    ) -> Result<(), TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let c = &self.config;
        let device = self.context.get_device();
        let command_buffer = allocate_command_buffer(device, command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *command_buffer)?;

        // Memory barriers between previous copies and rendering
        {
            let barriers: Vec<vk::ImageMemoryBarrier> = singlesample_images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_READ,
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        image.get(),
                        vk::ImageSubresourceRange {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            base_mip_level: 0,
                            level_count: 1,
                            base_array_layer: c.base_layer,
                            layer_count: c.layer_count,
                        },
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
            }
        }

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D { width: c.width, height: c.height },
            });
        let render_pass2 = c.render_pass_type == RenderPassType::RenderPass2;

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(*command_buffer, &begin_info, &subpass_begin_info) };
        } else {
            unsafe { device.cmd_begin_render_pass(*command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }

        // Clear everything to black
        self.clear_attachments(*command_buffer);

        // First subpass - render black samples
        unsafe {
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_pass0);
            device.cmd_draw(*command_buffer, 6, 1, 0, 0);
        }

        // Second subpasss - merge attachments
        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_next_subpass2_khr(*command_buffer, &subpass_begin_info, &subpass_end_info) };
        } else {
            unsafe { device.cmd_next_subpass(*command_buffer, vk::SubpassContents::INLINE) };
        }
        unsafe {
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_pass1);
            device.cmd_bind_descriptor_sets(*command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_layout_pass1, 0, &[descriptor_set], &[]);
            device.cmd_draw(*command_buffer, 6, 1, 0, 0);
        }

        if render_pass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(*command_buffer, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(*command_buffer) };
        }

        // `postRenderCommands` - memory barriers between rendering and copies
        {
            let subresource_range = vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: c.layer_count,
            };
            let image_barriers: Vec<vk::ImageMemoryBarrier> = singlesample_images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        INPUT_IMAGE_READ_LAYOUT,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        image.get(),
                        subresource_range,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &image_barriers,
                );
            }

            // Copy image memory to buffers
            let region = make_buffer_image_copy(
                vk::Extent3D {
                    width: c.width,
                    height: c.height,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, c.layer_count),
            );
            for (image, buffer) in singlesample_images.iter().zip(buffers) {
                unsafe {
                    device.cmd_copy_image_to_buffer(*command_buffer, image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer.get(), &[region]);
                }
            }

            // Memory barriers between copies and host access
            let buffer_barriers: Vec<vk::BufferMemoryBarrier> = buffers
                .iter()
                .map(|buffer| make_buffer_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ, buffer.get(), 0, vk::WHOLE_SIZE))
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &buffer_barriers,
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), *command_buffer)?;

        for buffer in buffers {
            invalidate_alloc(device, buffer.get_allocation())?;
        }
        Ok(())
    }

    /// `verify`
    fn verify(&self, accesses: &[ConstPixelBufferAccess<'_>]) -> bool {
        let c = &self.config;
        let format = map_vk_format(c.format).expect("multisample_resolve formats all map");
        let component_count = format.order.num_used_channels() as usize;
        let mut is_ok = true;

        match format.channel_class() {
            TextureChannelClass::FloatingPoint | TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
                let ref_color = [0.0f32, 0.3, 0.6, 0.75];
                let threshold = get_format_threshold(c.format);
                let is_srgb_format = format.order.is_srgb();

                for access in accesses {
                    for y in 0..c.height {
                        for x in 0..c.width {
                            let mut color = access.get_pixel(x, y, 0);
                            if is_srgb_format {
                                color = srgb_to_linear(color);
                            }
                            let diff: [f32; 4] = std::array::from_fn(|i| (color[i] - ref_color[i]).abs());
                            if (0..component_count).any(|i| diff[i] > threshold[i]) {
                                is_ok = false;
                                break;
                            }
                        }
                    }
                }
            }

            TextureChannelClass::UnsignedInteger => {
                let ref_color = [0i64, 48, 144, 189];
                let mut threshold = [1i64; 4];
                if c.format == vk::Format::A2B10G10R10_UINT_PACK32 {
                    threshold[3] = 200;
                }

                for access in accesses {
                    for y in 0..c.height {
                        for x in 0..c.width {
                            let color = access.get_pixel_uint64(x, y, 0);
                            let diff: [i64; 4] = std::array::from_fn(|i| (color[i] as i32 as i64 - ref_color[i]).abs());
                            if (0..component_count).any(|i| diff[i] > threshold[i]) {
                                is_ok = false;
                                break;
                            }
                        }
                    }
                }
            }

            TextureChannelClass::SignedInteger => {
                let ref_color = [0i64, 24, 75, 93];
                let threshold = [1i64; 4];

                for access in accesses {
                    for y in 0..c.height {
                        for x in 0..c.width {
                            let color = access.get_pixel_int(x, y, 0);
                            let diff: [i64; 4] = std::array::from_fn(|i| (i64::from(color[i]) - ref_color[i]).abs());
                            if (0..component_count).any(|i| diff[i] > threshold[i]) {
                                is_ok = false;
                                break;
                            }
                        }
                    }
                }
            }

            TextureChannelClass::Last => unreachable!("no colour format maps to the combined depth/stencil class"),
        }

        is_ok
    }
}

impl TestInstance for MaxAttachmenstsRenderPassTestInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::DeviceV1_0;

        let c = self.config;
        let device = self.context.get_device();

        let multisample_images = self.create_images(sample_count_bit(c.sample_count), vk::ImageUsageFlags::COLOR_ATTACHMENT, c.width, c.height, 1)?;
        let multisample_image_views = self.create_image_views(&multisample_images, 0, 0)?;

        let singlesample_images = self.create_images(
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            c.width,
            c.height,
            1,
        )?;
        // Upstream passes `m_baseLayer` into the *mipLevel* parameter here; these cases
        // are always single-layer with base layer 0, so it names level 0 either way.
        let singlesample_image_views = self.create_image_views(&singlesample_images, c.base_layer, 0)?;

        let descriptor_set_layout = self.create_descriptor_set_layout()?;
        let descriptor_pool = self.create_descriptor_pool()?;
        let descriptor_set = self.create_descriptor_set(*descriptor_pool, *descriptor_set_layout, &singlesample_image_views)?;

        let render_pass = self.create_render_pass()?;
        let attachments: Vec<vk::ImageView> = multisample_image_views.iter().zip(&singlesample_image_views).flat_map(|(ms, ss)| [**ms, **ss]).collect();
        let framebuffer = make_framebuffer(device, *render_pass, &attachments, c.width, c.height, c.layer_count)?;

        let pipeline_layout_pass0 = {
            let info = vk::PipelineLayoutCreateInfo::builder();
            let handle = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
            Unique::new(device, handle)
        };
        let pipeline_layout_pass1 = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let programs = self.context.get_binary_collection();
        let vert = create_shader_module(device, programs.get("quad_vert")?)?;
        let geom = (c.layer_count != 1)
            .then(|| programs.get(&format!("geom_{}", c.layer_count)))
            .transpose()?
            .map(|b| create_shader_module(device, b))
            .transpose()?;
        let frag_pass0 = create_shader_module(device, programs.get(&self.fragment_shader_name(false))?)?;
        let frag_pass1 = create_shader_module(device, programs.get(&self.fragment_shader_name(true))?)?;

        let pipeline_pass0 = self.create_render_pipeline(*render_pass, *pipeline_layout_pass0, false, *vert, geom.as_deref().copied(), *frag_pass0)?;
        let pipeline_pass1 = self.create_render_pipeline(*render_pass, *pipeline_layout_pass1, true, *vert, geom.as_deref().copied(), *frag_pass1)?;

        let buffers = self.create_buffers(c.width, c.height, 1)?;
        let command_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;

        self.submit(
            *command_pool,
            *render_pass,
            *framebuffer,
            *pipeline_pass0,
            *pipeline_layout_pass1,
            *pipeline_pass1,
            *descriptor_set,
            &singlesample_images,
            &buffers,
        )?;

        // The second subpass merges pairs of attachments, so only the first half hold a
        // result to check.
        let outputs_count = (c.attachment_count / 2) as usize;
        let tcu_format = map_vk_format(c.format).expect("multisample_resolve formats all map");
        let level_size = (c.width * c.height * self.get_pixel_size()) as usize;
        let bytes: Vec<&[u8]> = buffers[..outputs_count]
            .iter()
            .map(|buffer| unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), level_size) })
            .collect();
        let accesses: Vec<ConstPixelBufferAccess<'_>> = bytes.iter().map(|data| ConstPixelBufferAccess::new(tcu_format, [c.width, c.height, 1], data)).collect();

        Ok(if self.verify(&accesses) { TestStatus::pass("Pass") } else { TestStatus::fail("Fail") })
    }
}

/// `AttachmentDescription1` -> `AttachmentDescription2`, and the same for references -
/// the two render-pass traits differ only in which struct they fill in.
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

fn to_attachment_reference(&(attachment, layout, _): &(u32, vk::ImageLayout, vk::ImageAspectFlags)) -> vk::AttachmentReference {
    vk::AttachmentReference { attachment, layout }
}

fn to_attachment_reference2(&(attachment, layout, aspect_mask): &(u32, vk::ImageLayout, vk::ImageAspectFlags)) -> vk::AttachmentReference2 {
    vk::AttachmentReference2::builder().attachment(attachment).layout(layout).aspect_mask(aspect_mask).build()
}

/// `formats`, paired with `formatToName`.
const FORMATS: [(vk::Format, &str); 50] = [
    (vk::Format::R5G6B5_UNORM_PACK16, "r5g6b5_unorm_pack16"),
    (vk::Format::R8_UNORM, "r8_unorm"),
    (vk::Format::R8_SNORM, "r8_snorm"),
    (vk::Format::R8_UINT, "r8_uint"),
    (vk::Format::R8_SINT, "r8_sint"),
    (vk::Format::A8_UNORM, "a8_unorm"),
    (vk::Format::R8G8_UNORM, "r8g8_unorm"),
    (vk::Format::R8G8_SNORM, "r8g8_snorm"),
    (vk::Format::R8G8_UINT, "r8g8_uint"),
    (vk::Format::R8G8_SINT, "r8g8_sint"),
    (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
    (vk::Format::R8G8B8A8_SNORM, "r8g8b8a8_snorm"),
    (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
    (vk::Format::R8G8B8A8_SINT, "r8g8b8a8_sint"),
    (vk::Format::R8G8B8A8_SRGB, "r8g8b8a8_srgb"),
    (vk::Format::A8B8G8R8_UNORM_PACK32, "a8b8g8r8_unorm_pack32"),
    (vk::Format::A8B8G8R8_SNORM_PACK32, "a8b8g8r8_snorm_pack32"),
    (vk::Format::A8B8G8R8_UINT_PACK32, "a8b8g8r8_uint_pack32"),
    (vk::Format::A8B8G8R8_SINT_PACK32, "a8b8g8r8_sint_pack32"),
    (vk::Format::A8B8G8R8_SRGB_PACK32, "a8b8g8r8_srgb_pack32"),
    (vk::Format::B8G8R8A8_UNORM, "b8g8r8a8_unorm"),
    (vk::Format::B8G8R8A8_SRGB, "b8g8r8a8_srgb"),
    (vk::Format::A2R10G10B10_UNORM_PACK32, "a2r10g10b10_unorm_pack32"),
    (vk::Format::A2B10G10R10_UNORM_PACK32, "a2b10g10r10_unorm_pack32"),
    (vk::Format::A2B10G10R10_UINT_PACK32, "a2b10g10r10_uint_pack32"),
    (vk::Format::R16_UNORM, "r16_unorm"),
    (vk::Format::R16_SNORM, "r16_snorm"),
    (vk::Format::R16_UINT, "r16_uint"),
    (vk::Format::R16_SINT, "r16_sint"),
    (vk::Format::R16_SFLOAT, "r16_sfloat"),
    (vk::Format::R16G16_UNORM, "r16g16_unorm"),
    (vk::Format::R16G16_SNORM, "r16g16_snorm"),
    (vk::Format::R16G16_UINT, "r16g16_uint"),
    (vk::Format::R16G16_SINT, "r16g16_sint"),
    (vk::Format::R16G16_SFLOAT, "r16g16_sfloat"),
    (vk::Format::R16G16B16A16_UNORM, "r16g16b16a16_unorm"),
    (vk::Format::R16G16B16A16_SNORM, "r16g16b16a16_snorm"),
    (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
    (vk::Format::R16G16B16A16_SINT, "r16g16b16a16_sint"),
    (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
    (vk::Format::R32_UINT, "r32_uint"),
    (vk::Format::R32_SINT, "r32_sint"),
    (vk::Format::R32_SFLOAT, "r32_sfloat"),
    (vk::Format::R32G32_UINT, "r32g32_uint"),
    (vk::Format::R32G32_SINT, "r32g32_sint"),
    (vk::Format::R32G32_SFLOAT, "r32g32_sfloat"),
    (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
    (vk::Format::R32G32B32A32_SINT, "r32g32b32a32_sint"),
    (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
    (vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16, "r10x6g10x6b10x6a10x6_unorm_4pack16"),
];

const SAMPLE_COUNTS: [u32; 3] = [2, 4, 8];
const LAYER_COUNTS: [u32; 3] = [1, 3, 6];
const RESOLVE_LEVELS: [u32; 3] = [2, 3, 4];

/// `initTests`. Single-layer cases sit directly under `multisample_resolve`; the
/// layered ones get a `layers_N` level of their own.
pub fn create_multisample_resolve_tests(render_pass_type: RenderPassType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample_resolve");

    for layer_count in LAYER_COUNTS {
        let mut layer_group = TestCaseGroup::new(format!("layers_{layer_count}"));

        for (format, format_name) in FORMATS {
            let mut format_group = TestCaseGroup::new(format_name);

            for sample_count in SAMPLE_COUNTS {
                // Skip this test as it is rather slow
                if layer_count == 6 && sample_count == 8 {
                    continue;
                }

                let test_name = format!("samples_{sample_count}");
                let test_config = TestConfig {
                    test_type: TestType::Resolve,
                    format,
                    sample_count,
                    layer_count,
                    base_layer: 0,
                    attachment_count: 4,
                    width: 32,
                    height: 32,
                    render_pass_type,
                    resolve_level: None,
                };

                let mut add = |name: String, config: TestConfig| {
                    format_group.add_child(Box::new(MultisampleResolveTestCase { name, config }) as Box<dyn crate::vkt::TestCase>);
                };

                add(test_name.clone(), test_config);
                add(format!("{test_name}_baseLayer1"), TestConfig { base_layer: 1, ..test_config });
                for resolve_level in RESOLVE_LEVELS {
                    add(
                        format!("{test_name}_resolve_level_{resolve_level}"),
                        TestConfig {
                            resolve_level: Some(resolve_level),
                            ..test_config
                        },
                    );
                }

                // `MaxAttachmenstsRenderPassTest` is meant to test extreme cases where
                // applications might consume all available on-chip memory. The maximal
                // attachment count is not known when the shaders are built, so every
                // power-of-two count up to the limit gets its own case.
                if layer_count == 1 {
                    for power in 2..5 {
                        let attachment_count = 1 << power;
                        add(
                            format!("max_attachments_{attachment_count}_{test_name}"),
                            TestConfig {
                                test_type: TestType::MaxAttachments,
                                attachment_count,
                                ..test_config
                            },
                        );
                    }

                    add(
                        format!("compatibility_{test_name}"),
                        TestConfig {
                            test_type: TestType::Compatibility,
                            attachment_count: 1,
                            ..test_config
                        },
                    );
                }
            }

            if layer_count == 1 {
                group.add_child(format_group);
            } else {
                layer_group.add_child(format_group);
            }
        }

        if layer_count != 1 {
            group.add_child(layer_group);
        }
    }

    group
}
