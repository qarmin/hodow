// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingUnusedAttachmentsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The fragment shader depends on which outputs the pipeline leaves undefined, so the
// manifest holds one program set per (output count, written mask, layer mode, extra outputs) and `programs()` looks it up. Monolithic
// pipelines only. The depth/stencil comparison is done by decoding the copied bytes instead of `tcu::dsThresholdCompare`.
//
// VK_EXT_dynamic_rendering_unused_attachments: attachments whose format is VK_FORMAT_UNDEFINED in the pipeline or whose view is
// VK_NULL_HANDLE in the rendering info must simply not be written, whatever the other of the two says.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::renderpass_unused_attachments::ALL_UNUSED_ATTACHMENTS_PROGRAMS;
use crate::generated::shaders::renderpass_unused_attachments_misc::USED_THEN_UNUSED;
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
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::util::{rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct UnusedAttachmentsPrograms {
    pub name: &'static str,
    pub frag_att: u32,
    pub used_mask: u32,
    pub mode: &'static str,
    pub large_render: bool,
    pub programs: BinaryCollection,
}

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UINT;
const BAD_COLOR_FORMAT: vk::Format = vk::Format::R32G32B32A32_UINT;
/// color format for extra render attachments
const COLOR_FORMAT_EXTRA_RENDER_ATTS: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// The spec mandates support for one of these two formats.
const DS_FORMAT_LIST: [vk::Format; 2] = [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT];

/// `chooseDepthStencilFormat`
fn choose_depth_stencil_format(context: &Context<'_>) -> Result<vk::Format, TestError> {
    for format in DS_FORMAT_LIST {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Ok(format);
        }
    }

    Err(TestError::Fail("No suitable depth/stencil format found".to_string()))
}

/// `chooseAltDSFormat` - a different depth/stencil format from the one chosen.
fn choose_alt_ds_format(chosen_format: vk::Format) -> vk::Format {
    DS_FORMAT_LIST
        .into_iter()
        .find(|format| *format != chosen_format)
        .unwrap_or(DS_FORMAT_LIST[0])
}

#[derive(Clone, Copy)]
struct TestParams {
    /// Number of attachments specified in the pipeline and framebuffer (VUID-vkCmdDraw-colorAttachmentCount-06179).
    pipe_fb_attachment_count: u32,
    /// Frag shader outputs. Needs to be >= pipe_fb_attachment_count.
    frag_attachment_count: u32,

    /// Image layers.
    layer_count: u32,
    /// Which layers are going to be written to, either using viewMask or manual calls.
    layer_mask: u32,
    /// Manual or "automatic" layer handling.
    multi_view: bool,

    /// Which attachments will have VK_FORMAT_UNDEFINED in the pipeline (0 for undefined, 1 for defined).
    format_mask: u32,
    /// Which attachments will be VK_NULL_HANDLE in the framebuffer (0 for null, 1 for valid handle).
    framebuffer_mask: u32,

    /// Create the pipeline with a depth attachment or not.
    depth_present: bool,
    /// Make the depth attachment have VK_FORMAT_UNDEFINED in the pipeline or not.
    depth_defined: bool,
    /// Make the depth attachment be VK_NULL_HANDLE in the framebuffer or not.
    depth_valid_handle: bool,

    stencil_present: bool,
    stencil_defined: bool,
    stencil_valid_handle: bool,

    /// Use secondary command buffers inside the render pass.
    use_secondaries: bool,
    /// Use the wrong format value if the image view handle is VK_NULL_HANDLE.
    wrong_format_with_null_views: bool,
    /// Ignore VUID-vkCmdDraw-colorAttachmentCount-06179 and make VkPipelineRenderingCreateInfo::colorAttachmentCount larger than
    /// VkRenderingInfo::colorAttachmentCount.
    large_pipe_att_count: bool,
    /// make VkRenderingInfo::colorAttachmentCount larger than VkPipelineRenderingCreateInfo::colorAttachmentCount.
    large_render_att_count: bool,
    extra_att_is_unused: bool,
}

const MAX_FRAG_ATTACHMENTS: u32 = 8; // Based on real-world maxFragmentOutputAttachments values.
const MAX_FRAMEBUFFER_ATTACHMENTS: u32 = 2 * MAX_FRAG_ATTACHMENTS; // Slightly arbitrary, based on the previous number.
const EXTRA_PIPELINE_ATT_COUNT: u32 = 4; // Used when large_pipe_att_count is true.
const EXTRA_RENDER_ATT_COUNT: u32 = 4; // Used when large_render_att_count is true.

impl TestParams {
    #[allow(clippy::too_many_arguments)]
    fn new(
        pipe_fb_attachment_count: u32,
        frag_attachment_count: u32,
        layer_count: u32,
        layer_mask: u32,
        multi_view: bool,
        format_mask: u32,
        framebuffer_mask: u32,
        depth_present: bool,
        depth_defined: bool,
        depth_valid_handle: bool,
        stencil_present: bool,
        stencil_defined: bool,
        stencil_valid_handle: bool,
        use_secondaries: bool,
        wrong_format_with_null_views: bool,
        large_pipe_att_count: bool,
        large_render_att_count: bool,
        extra_att_is_unused: bool,
    ) -> Self {
        assert!(frag_attachment_count <= MAX_FRAG_ATTACHMENTS);
        assert!(pipe_fb_attachment_count <= MAX_FRAMEBUFFER_ATTACHMENTS);
        assert!(frag_attachment_count >= pipe_fb_attachment_count);
        assert!(layer_count >= 1);
        Self {
            pipe_fb_attachment_count,
            frag_attachment_count,
            layer_count,
            layer_mask,
            multi_view,
            format_mask,
            framebuffer_mask,
            depth_present,
            depth_defined,
            depth_valid_handle,
            stencil_present,
            stencil_defined,
            stencil_valid_handle,
            use_secondaries,
            wrong_format_with_null_views,
            large_pipe_att_count,
            large_render_att_count,
            extra_att_is_unused,
        }
    }

    /// `getTestName` - yes, this is an awfully long string.
    fn get_test_name(&self) -> String {
        let present = |flag: bool| if flag { "yes" } else { "no" };
        let defined = |flag: bool| if flag { "def" } else { "undef" };
        let valid = |flag: bool| if flag { "valid" } else { "null" };

        format!(
            "pipe_{}_frag_{}_layers_{}_mask_0x{:02x}_formats_0x{:08x}_handles_0x{:08x}_depth_{}_{}_{}_stencil_{}_{}_{}{}{}{}",
            self.pipe_fb_attachment_count,
            self.frag_attachment_count,
            self.layer_count,
            self.layer_mask,
            self.format_mask,
            self.framebuffer_mask,
            present(self.depth_present),
            defined(self.depth_defined),
            valid(self.depth_valid_handle),
            present(self.stencil_present),
            defined(self.stencil_defined),
            valid(self.stencil_valid_handle),
            if self.multi_view { "_multiview" } else { "" },
            if self.large_pipe_att_count && self.extra_att_is_unused {
                "_extra_undef"
            } else {
                ""
            },
            if self.large_render_att_count && self.extra_att_is_unused {
                "_extra_null"
            } else {
                ""
            },
        )
    }

    fn depth_stencil_needed(&self) -> bool {
        self.depth_present || self.stencil_present
    }

    /// Returns true if the vertex shader has to write to the Layer built-in.
    fn vert_exports_layer(&self) -> bool {
        !self.multi_view && self.layer_count > 1
    }

    /// `getFormatVectorForMask`
    fn get_format_vector_for_mask(color_format: vk::Format, bit_mask: u32, attachment_count: u32) -> Vec<vk::Format> {
        (0..attachment_count)
            .map(|att_idx| {
                if (bit_mask >> att_idx) & 1 != 0 {
                    color_format
                } else {
                    vk::Format::UNDEFINED
                }
            })
            .collect()
    }

    fn get_pipeline_format_vector(&self, color_format: vk::Format) -> Vec<vk::Format> {
        Self::get_format_vector_for_mask(color_format, self.format_mask, self.pipe_fb_attachment_count)
    }

    fn get_inheritance_format_vector(&self, color_format: vk::Format) -> Vec<vk::Format> {
        Self::get_format_vector_for_mask(color_format, self.framebuffer_mask, self.pipe_fb_attachment_count)
    }

    fn get_pipeline_depth_format(&self, ds_format: vk::Format) -> vk::Format {
        if self.depth_present && self.depth_defined {
            ds_format
        } else {
            vk::Format::UNDEFINED
        }
    }

    fn get_inheritance_depth_format(&self, ds_format: vk::Format) -> vk::Format {
        if self.depth_present && self.depth_valid_handle {
            ds_format
        } else {
            vk::Format::UNDEFINED
        }
    }

    fn get_pipeline_stencil_format(&self, ds_format: vk::Format) -> vk::Format {
        if self.stencil_present && self.stencil_defined {
            ds_format
        } else {
            vk::Format::UNDEFINED
        }
    }

    fn get_inheritance_stencil_format(&self, ds_format: vk::Format) -> vk::Format {
        if self.stencil_present && self.stencil_valid_handle {
            ds_format
        } else {
            vk::Format::UNDEFINED
        }
    }

    /// `getClearValue` - all zero.
    fn get_clear_value() -> vk::ClearValue {
        vk::ClearValue {
            color: vk::ClearColorValue { uint32: [0; 4] },
        }
    }

    /// The fragment outputs the shader writes: every one except those the pipeline gives an undefined format.
    fn frag_used_mask(&self) -> u32 {
        let pipeline_formats = self.get_pipeline_format_vector(COLOR_FORMAT);
        (0..self.frag_attachment_count)
            .filter(|&i| !(i < pipeline_formats.len() as u32 && pipeline_formats[i as usize] == vk::Format::UNDEFINED))
            .fold(0u32, |mask, i| mask | (1 << i))
    }

    fn layer_mode(&self) -> &'static str {
        if self.multi_view {
            "mv"
        } else if self.vert_exports_layer() {
            "layer"
        } else {
            "plain"
        }
    }
}

fn rendering_attachment_info(image_view: vk::ImageView, image_layout: vk::ImageLayout) -> vk::RenderingAttachmentInfo {
    vk::RenderingAttachmentInfo::builder()
        .image_view(image_view)
        .image_layout(image_layout)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .resolve_image_view(vk::ImageView::null())
        .resolve_image_layout(vk::ImageLayout::UNDEFINED)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(TestParams::get_clear_value())
        .build()
}

/// `vk::ImageWithBuffer` - an image with `layers` layers, its view and a host-visible verification buffer holding every layer.
struct ImageWithBufferLayers<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
    buffer: BufferWithMemory<'a>,
}

impl<'a> ImageWithBufferLayers<'a> {
    fn new(
        context: &'a Context<'a>,
        format: vk::Format,
        pixel_size: u32,
        usage: vk::ImageUsageFlags,
        subresource_range: vk::ImageSubresourceRange,
        layers: u32,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: 1,
                height: 1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;

        let view_type = if layers == 1 {
            vk::ImageViewType::_2D
        } else {
            vk::ImageViewType::_2D_ARRAY
        };
        let view = make_image_view(device, image.get(), view_type, format, subresource_range)?;

        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (pixel_size * layers) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        Ok(Self { image, view, buffer })
    }
}

fn barrier_color(
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
        );
    }
}

fn host_read_barrier(device: &Device, cmd: vk::CommandBuffer) {
    let barrier = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

fn rendering_stages() -> vk::PipelineStageFlags {
    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
}

fn find_program(params: &TestParams) -> Option<UnusedAttachmentsPrograms> {
    let used_mask = params.frag_used_mask();
    let mode = params.layer_mode();
    ALL_UNUSED_ATTACHMENTS_PROGRAMS
        .iter()
        .copied()
        .find(|p| {
            p.frag_att == params.frag_attachment_count
                && p.used_mask == used_mask
                && p.mode == mode
                && p.large_render == params.large_render_att_count
        })
        .copied()
}

struct DynamicUnusedAttachmentsCase {
    name: String,
    params: TestParams,
}

impl TestCase for DynamicUnusedAttachmentsCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_basic_ext_support(context)?;

        let properties = context.get_device_properties();
        let params = &self.params;

        if params.frag_attachment_count > properties.limits.max_fragment_output_attachments {
            return Err(TestError::NotSupported(
                "Unsupported number of fragment output attachments".to_string(),
            ));
        }

        if params.pipe_fb_attachment_count > properties.limits.max_color_attachments {
            return Err(TestError::NotSupported(
                "Unsupported number of color attachments".to_string(),
            ));
        }

        if params.large_pipe_att_count {
            // In theory, there's no limit to the amount of attachments in the pipeline.
            // In practice, many implementations limit these to maxFragmentOutputAttachments, so we check the limit here.
            let pipeline_att_count = params.pipe_fb_attachment_count + EXTRA_PIPELINE_ATT_COUNT;
            if pipeline_att_count > properties.limits.max_fragment_output_attachments {
                return Err(TestError::NotSupported(
                    "Unsupported number of extra attachments".to_string(),
                ));
            }
        }

        if params.large_render_att_count {
            let render_att_count = params.frag_attachment_count + EXTRA_RENDER_ATT_COUNT;
            if render_att_count > properties.limits.max_fragment_output_attachments {
                return Err(TestError::NotSupported(
                    "Unsupported number of extra attachments".to_string(),
                ));
            }
        }

        if params.vert_exports_layer() {
            // This will check the right extension or Vulkan 1.2 features automatically.
            context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;

            // We also need geometry shader support to be able to use gl_Layer from frag shaders.
            if context.get_device_features().geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported("geometryShader not supported".to_string()));
            }
        }

        if params.multi_view {
            context.require_device_functionality("VK_KHR_multiview")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        find_program(&self.params).map_or_else(|| BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicUnusedAttachmentsInstance {
            context,
            params: self.params,
        })
    }
}

fn check_basic_ext_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_dynamic_rendering")?;
    context.require_device_functionality("VK_EXT_dynamic_rendering_unused_attachments")
}

struct DynamicUnusedAttachmentsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for DynamicUnusedAttachmentsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        use vulkanalia::vk::DeviceV1_3;

        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let fb_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let ds_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, params.layer_count);
        let ds_srr = make_image_subresource_range(
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
            0,
            1,
            0,
            params.layer_count,
        );
        let layers_of = |aspect| vk::ImageSubresourceLayers {
            aspect_mask: aspect,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: params.layer_count,
        };
        let color_srl = layers_of(vk::ImageAspectFlags::COLOR);
        let depth_srl = layers_of(vk::ImageAspectFlags::DEPTH);
        let stencil_srl = layers_of(vk::ImageAspectFlags::STENCIL);
        let ds_needed = params.depth_stencil_needed();

        // Allocate color attachments.
        let mut color_images: Vec<ImageWithBufferLayers<'_>> = Vec::new();
        for _ in 0..params.pipe_fb_attachment_count {
            color_images.push(ImageWithBufferLayers::new(
                context,
                COLOR_FORMAT,
                4,
                color_usage,
                color_srr,
                params.layer_count,
            )?);
        }

        if params.large_render_att_count {
            // Make VkRenderingInfo::colorAttachmentCount larger than VkPipelineRenderingCreateInfo::colorAttachmentCount
            for _ in 0..EXTRA_RENDER_ATT_COUNT {
                color_images.push(ImageWithBufferLayers::new(
                    context,
                    COLOR_FORMAT_EXTRA_RENDER_ATTS,
                    4,
                    color_usage,
                    color_srr,
                    params.layer_count,
                )?);
            }
        }

        let mut ds_format = vk::Format::UNDEFINED;
        let mut ds_image: Option<ImageWithMemory<'_>> = None;
        let mut ds_image_view: Option<Unique<'_, vk::ImageView>> = None;
        let mut depth_verification_buffer: Option<BufferWithMemory<'_>> = None;
        let mut stencil_verification_buffer: Option<BufferWithMemory<'_>> = None;

        if ds_needed {
            ds_format = choose_depth_stencil_format(context)?;

            let ds_create_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(ds_format)
                .extent(fb_extent)
                .mip_levels(1)
                .array_layers(params.layer_count)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(ds_usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(
                device,
                context.get_default_allocator(),
                ds_create_info,
                MemoryRequirement::ANY,
            )?;

            let ds_image_view_type = if params.layer_count > 1 {
                vk::ImageViewType::_2D_ARRAY
            } else {
                vk::ImageViewType::_2D
            };
            ds_image_view = Some(make_image_view(
                device,
                image.get(),
                ds_image_view_type,
                ds_format,
                ds_srr,
            )?);
            ds_image = Some(image);

            // The depth copy of D32S8 is a 4 byte float, of D24S8 a 4 byte X8_D24 word; the stencil copy is one byte.
            let depth_verification_buffer_size = 4 * params.layer_count as vk::DeviceSize;
            depth_verification_buffer = Some(BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(depth_verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?);

            let stencil_verification_buffer_size = params.layer_count as vk::DeviceSize;
            stencil_verification_buffer = Some(BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(stencil_verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        let binaries = context.get_binary_collection();
        let vk12_support = context.api_version() >= (1, 2, 0);
        let vert_module = create_shader_module(
            device,
            binaries.get(if vk12_support { "vert-spv15" } else { "vert-spv10" })?,
        )?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let pc_size = std::mem::size_of::<i32>() as u32;
        let pc_stages = vk::ShaderStageFlags::VERTEX;
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        }];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // If the depth or stencil test is enabled and the image view is not VK_NULL_HANDLE, the format cannot be UNDEFINED.
        let depth_enabled = params.depth_present && !(!params.depth_defined && params.depth_valid_handle);
        let stencil_enabled = params.stencil_present && !(!params.stencil_defined && params.stencil_valid_handle);
        let stencil_op_state = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::REPLACE,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::GREATER_OR_EQUAL,
            compare_mask: 0xFF,
            write_mask: 0xFF,
            reference: 0xFF,
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(depth_enabled)
            .depth_write_enable(depth_enabled)
            .depth_compare_op(vk::CompareOp::GREATER_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(stencil_enabled)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let mut color_pipeline_formats = params.get_pipeline_format_vector(COLOR_FORMAT);
        let mut depth_pipeline_format = params.get_pipeline_depth_format(ds_format);
        let mut stencil_pipeline_format = params.get_pipeline_stencil_format(ds_format);
        let view_mask = if params.multi_view { params.layer_mask } else { 0 };

        let raw_color_views: Vec<vk::ImageView> = color_images.iter().map(|image| *image.view).collect();

        // `getRenderingAttachmentInfos`
        let mut rendering_att_infos: Vec<vk::RenderingAttachmentInfo> = (0..params.pipe_fb_attachment_count)
            .map(|att_idx| {
                let image_view = if (params.framebuffer_mask >> att_idx) & 1 != 0 {
                    raw_color_views[att_idx as usize]
                } else {
                    vk::ImageView::null()
                };
                rendering_attachment_info(image_view, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            })
            .collect();

        let mut color_images_formats = vec![vk::Format::UNDEFINED; params.pipe_fb_attachment_count as usize];

        if params.large_render_att_count {
            // Mask not considered for extra attachments
            for att_idx in 0..EXTRA_RENDER_ATT_COUNT {
                let img_view_idx = (att_idx + params.pipe_fb_attachment_count) as usize;
                let img_view = if params.extra_att_is_unused {
                    vk::ImageView::null()
                } else {
                    raw_color_views[img_view_idx]
                };
                rendering_att_infos.push(rendering_attachment_info(
                    img_view,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                ));
            }

            let larger_att_count = params.pipe_fb_attachment_count + EXTRA_RENDER_ATT_COUNT;

            for att_idx in 0..params.pipe_fb_attachment_count as usize {
                color_images_formats[att_idx] = if rendering_att_infos[att_idx].image_view == vk::ImageView::null() {
                    vk::Format::UNDEFINED
                } else {
                    COLOR_FORMAT
                };
            }

            color_images_formats.resize(
                larger_att_count as usize,
                if params.extra_att_is_unused {
                    vk::Format::UNDEFINED
                } else {
                    COLOR_FORMAT_EXTRA_RENDER_ATTS
                },
            );
        }

        let mut depth_attachment: Option<vk::RenderingAttachmentInfo> = None;
        let mut stencil_attachment: Option<vk::RenderingAttachmentInfo> = None;

        if ds_needed {
            let img_view = **ds_image_view.as_ref().expect("a depth/stencil view was created");
            let depth_view = if params.depth_present && params.depth_valid_handle {
                img_view
            } else {
                vk::ImageView::null()
            };
            let stencil_view = if params.stencil_present && params.stencil_valid_handle {
                img_view
            } else {
                vk::ImageView::null()
            };
            depth_attachment = Some(rendering_attachment_info(
                depth_view,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ));
            stencil_attachment = Some(rendering_attachment_info(
                stencil_view,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ));
        }

        if params.wrong_format_with_null_views {
            assert!(rendering_att_infos.len() == color_pipeline_formats.len());

            // Use wrong formats when the image view is VK_NULL_HANDLE.
            for (info, format) in rendering_att_infos.iter().zip(color_pipeline_formats.iter_mut()) {
                if info.image_view == vk::ImageView::null() {
                    *format = BAD_COLOR_FORMAT;
                }
            }

            let bad_ds_format = choose_alt_ds_format(ds_format);

            if depth_attachment
                .as_ref()
                .is_some_and(|info| info.image_view == vk::ImageView::null())
            {
                depth_pipeline_format = bad_ds_format;
            }

            if stencil_attachment
                .as_ref()
                .is_some_and(|info| info.image_view == vk::ImageView::null())
            {
                stencil_pipeline_format = bad_ds_format;
            }
        }

        if params.large_pipe_att_count {
            // Make VkPipelineRenderingCreateInfo::colorAttachmentCount larger than VkRenderingInfo::colorAttachmentCount
            for _ in 0..EXTRA_PIPELINE_ATT_COUNT {
                color_pipeline_formats.push(if params.extra_att_is_unused {
                    vk::Format::UNDEFINED
                } else {
                    BAD_COLOR_FORMAT
                });
            }
        }

        let mut pipeline_rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(view_mask)
            .color_attachment_formats(&color_pipeline_formats)
            .depth_attachment_format(depth_pipeline_format)
            .stencil_attachment_format(stencil_pipeline_format);

        let color_blend_att_state = vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build();
        let color_blend_state_vec = vec![color_blend_att_state; color_pipeline_formats.len()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&color_blend_state_vec)
            .blend_constants([0.0; 4]);

        let pipeline = create_pipeline(
            device,
            *pipeline_layout,
            *vert_module,
            *frag_module,
            vk::PrimitiveTopology::TRIANGLE_LIST,
            &depth_stencil_state,
            &color_blend_state,
            None,
            &mut pipeline_rendering_create_info,
        )?;

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        let secondary_command_buffer: Option<UniqueCommandBuffer<'_>> = if params.use_secondaries {
            Some(allocate_command_buffer(
                device,
                *command_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        let rp_cmd_buffer = secondary_command_buffer.as_ref().map_or(cmd, |secondary| **secondary);

        let rendering_flags = if params.use_secondaries {
            vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
        } else {
            vk::RenderingFlags::empty()
        };

        let mut rendering_info = vk::RenderingInfo::builder()
            .flags(rendering_flags)
            .render_area(rect_2d(1, 1))
            .layer_count(if params.multi_view { 1 } else { params.layer_count })
            .view_mask(view_mask)
            .color_attachments(&rendering_att_infos);
        if let Some(depth) = &depth_attachment {
            rendering_info = rendering_info.depth_attachment(depth);
        }
        if let Some(stencil) = &stencil_attachment {
            rendering_info = rendering_info.stencil_attachment(stencil);
        }

        begin_command_buffer(device, cmd)?;

        // Transition the layout of every image.
        {
            let mut initial_layout_barriers: Vec<vk::ImageMemoryBarrier> = color_images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        image.image.get(),
                        color_srr,
                    )
                })
                .collect();
            if let Some(image) = &ds_image {
                initial_layout_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image.get(),
                    ds_srr,
                ));
            }

            barrier_color(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                &initial_layout_barriers,
            );
        }

        // Clear images.
        {
            let clear_color = vk::ClearColorValue { uint32: [0; 4] };
            for image in &color_images {
                unsafe {
                    device.cmd_clear_color_image(
                        cmd,
                        image.image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_color,
                        &[color_srr],
                    )
                };
            }
            if let Some(image) = &ds_image {
                let clear_depth_stencil = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
                unsafe {
                    device.cmd_clear_depth_stencil_image(
                        cmd,
                        image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_depth_stencil,
                        &[ds_srr],
                    )
                };
            }
        }

        // Transition the layout of every image.
        {
            let mut layout_barriers: Vec<vk::ImageMemoryBarrier> = color_images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        image.image.get(),
                        color_srr,
                    )
                })
                .collect();
            if let Some(image) = &ds_image {
                layout_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    image.get(),
                    ds_srr,
                ));
            }

            barrier_color(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                rendering_stages(),
                &layout_barriers,
            );
        }

        unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };

        if let Some(secondary) = &secondary_command_buffer {
            // The inheritance info and framebuffer attachments must match (null handle -> undefined format, non-null handle -> valid format).
            // The pipeline rendering info will later be able to selectively disable an attachment.
            let inheritance_color_formats = if params.large_render_att_count {
                color_images_formats.clone()
            } else {
                params.get_inheritance_format_vector(COLOR_FORMAT)
            };
            let inheritance_depth_format = params.get_inheritance_depth_format(ds_format);
            let inheritance_stencil_format = params.get_inheritance_stencil_format(ds_format);

            let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                .flags(vk::RenderingFlags::empty())
                .view_mask(view_mask)
                .color_attachment_formats(&inheritance_color_formats)
                .depth_attachment_format(inheritance_depth_format)
                .stencil_attachment_format(inheritance_stencil_format)
                .rasterization_samples(vk::SampleCountFlags::_1);
            let inheritance_info =
                vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);

            unsafe { device.begin_command_buffer(**secondary, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        }

        unsafe { device.cmd_bind_pipeline(rp_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline) };
        {
            let iter_count = if params.multi_view { 1 } else { params.layer_count };
            for i in 0..iter_count {
                // In non-multiview mode, we have to skip some layers manually.
                if !params.multi_view && params.layer_mask & (1 << i) == 0 {
                    continue;
                }

                unsafe {
                    device.cmd_push_constants(rp_cmd_buffer, *pipeline_layout, pc_stages, 0, &(i as i32).to_ne_bytes());
                    device.cmd_draw(rp_cmd_buffer, 3, 1, 0, 0);
                }
            }
        }

        if let Some(secondary) = &secondary_command_buffer {
            end_command_buffer(device, **secondary)?;
            unsafe { device.cmd_execute_commands(cmd, &[**secondary]) };
        }

        unsafe { device.cmd_end_rendering(cmd) };

        // Transition the layout of all images again for verification.
        {
            let mut pre_copy_layout_barriers: Vec<vk::ImageMemoryBarrier> = color_images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        image.image.get(),
                        color_srr,
                    )
                })
                .collect();
            if let Some(image) = &ds_image {
                pre_copy_layout_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image.get(),
                    ds_srr,
                ));
            }

            barrier_color(
                device,
                cmd,
                rendering_stages(),
                vk::PipelineStageFlags::TRANSFER,
                &pre_copy_layout_barriers,
            );
        }

        // Copy all image contents to their verification buffers (note depth/stencil uses two buffers).
        let copy_region = |layers: vk::ImageSubresourceLayers| vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: layers,
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: fb_extent,
        };
        for image in &color_images {
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image.buffer.get(),
                    &[copy_region(color_srl)],
                )
            };
        }
        if let (Some(image), Some(depth_buffer), Some(stencil_buffer)) =
            (&ds_image, &depth_verification_buffer, &stencil_verification_buffer)
        {
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_buffer.get(),
                    &[copy_region(depth_srl)],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    stencil_buffer.get(),
                    &[copy_region(stencil_srl)],
                );
            }
        }

        // Global barrier to synchronize verification buffers to host reads.
        host_read_barrier(device, cmd);

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Invalidate all allocations.
        for image in &color_images {
            invalidate_alloc(device, image.buffer.get_allocation())?;
        }
        if let (Some(depth_buffer), Some(stencil_buffer)) = (&depth_verification_buffer, &stencil_verification_buffer) {
            invalidate_alloc(device, depth_buffer.get_allocation())?;
            invalidate_alloc(device, stencil_buffer.get_allocation())?;
        }

        // Verify all layers in all images. We expect exact results.
        let color_pixel_size = 4usize;
        let color_layer_size = color_pixel_size;
        let mut failure = false;

        for (color_img_idx, color_img) in color_images.iter().enumerate() {
            let data = unsafe {
                std::slice::from_raw_parts(
                    color_img.buffer.get_allocation().get_host_ptr().cast_const(),
                    color_pixel_size * params.layer_count as usize,
                )
            };
            let img_written = color_img_idx < color_pipeline_formats.len()
                && color_pipeline_formats[color_img_idx] != vk::Format::UNDEFINED
                && color_img_idx < rendering_att_infos.len()
                && rendering_att_infos[color_img_idx].image_view != vk::ImageView::null();

            for layer_idx in 0..params.layer_count {
                let layer_written = img_written && params.layer_mask & (1 << layer_idx) != 0;

                if color_img_idx >= params.pipe_fb_attachment_count as usize {
                    // largeRenderAttCount: the extra attachments are R8G8B8A8_UNORM and only layer 0 is looked at.
                    let layer_data = &data[..color_layer_size];
                    let expected: [u8; 4] = if layer_written {
                        [255, 255, color_img_idx as u8, 255]
                    } else {
                        [0, 0, 0, 0]
                    };
                    if layer_data != expected {
                        failure = true;
                    }
                } else {
                    let offset = color_layer_size * layer_idx as usize;
                    let layer_data = &data[offset..offset + color_layer_size];
                    // Needs to match frag shader.
                    let expected: [u8; 4] = if layer_written {
                        [layer_idx as u8, 255, color_img_idx as u8, 255]
                    } else {
                        [0, 0, 0, 0]
                    };
                    if layer_data != expected {
                        failure = true;
                    }
                }
            }
        }

        if let (Some(depth_buffer), Some(stencil_buffer)) = (&depth_verification_buffer, &stencil_verification_buffer) {
            let depth_written = params.depth_present && params.depth_defined && params.depth_valid_handle;
            let stencil_written = params.stencil_present && params.stencil_defined && params.stencil_valid_handle;

            // Depth.
            {
                let data = unsafe {
                    std::slice::from_raw_parts(
                        depth_buffer.get_allocation().get_host_ptr().cast_const(),
                        4 * params.layer_count as usize,
                    )
                };

                for layer_idx in 0..params.layer_count as usize {
                    let layer_written = depth_written && params.layer_mask & (1 << layer_idx) != 0;
                    let word = u32::from_ne_bytes([
                        data[layer_idx * 4],
                        data[layer_idx * 4 + 1],
                        data[layer_idx * 4 + 2],
                        data[layer_idx * 4 + 3],
                    ]);
                    // Needs to match the vertex shader and depth/stencil config: 1.0 where written, the 0.0 clear elsewhere.
                    let matches = if ds_format == vk::Format::D32_SFLOAT_S8_UINT {
                        f32::from_bits(word) == if layer_written { 1.0 } else { 0.0 }
                    } else {
                        (word & 0x00FF_FFFF) == if layer_written { 0x00FF_FFFF } else { 0 }
                    };
                    if !matches {
                        failure = true;
                    }
                }
            }

            // Stencil.
            {
                let data = unsafe {
                    std::slice::from_raw_parts(
                        stencil_buffer.get_allocation().get_host_ptr().cast_const(),
                        params.layer_count as usize,
                    )
                };

                for layer_idx in 0..params.layer_count as usize {
                    let layer_written = stencil_written && params.layer_mask & (1 << layer_idx) != 0;
                    let expected_stencil = if layer_written { 0xFF } else { 0 }; // Needs to match the stencil op config.
                    if data[layer_idx] != expected_stencil {
                        failure = true;
                    }
                }
            }
        }

        if failure {
            return Ok(TestStatus::fail(
                "Invalid value found in verification buffers; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// A graphics pipeline over `PipelineRenderingCreateInfo`, with no vertex input; `dynamic_states` may be left out.
#[allow(clippy::too_many_arguments)]
fn create_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    vert_module: vk::ShaderModule,
    frag_module: vk::ShaderModule,
    topology: vk::PrimitiveTopology,
    depth_stencil_state: &vk::PipelineDepthStencilStateCreateInfoBuilder,
    color_blend_state: &vk::PipelineColorBlendStateCreateInfoBuilder,
    dynamic_states: Option<&[vk::DynamicState]>,
    rendering_create_info: &mut vk::PipelineRenderingCreateInfoBuilder,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vert_module)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(frag_module)
            .name(b"main\0")
            .build(),
    ];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);
    let viewports = [viewport(0.0, 0.0, 1.0, 1.0, 0.0, 1.0)];
    let scissors = [rect_2d(1, 1)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state =
        vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(dynamic_states.unwrap_or(&[]));

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(depth_stencil_state)
        .color_blend_state(color_blend_state)
        .dynamic_state(&dynamic_state)
        .layout(layout)
        .render_pass(vk::RenderPass::null())
        .subpass(0)
        .base_pipeline_index(0)
        .push_next(rendering_create_info);

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

#[derive(Clone, Copy)]
struct UsedThenUnusedParams {
    use_secondaries: bool,
    dynamic_depth_enable: bool,
}

struct UsedThenUnusedCase {
    name: String,
    params: UsedThenUnusedParams,
}

impl TestCase for UsedThenUnusedCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `usedThenUnusedCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_basic_ext_support(context)?;

        if self.params.dynamic_depth_enable {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        USED_THEN_UNUSED.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UsedThenUnusedInstance {
            context,
            params: self.params,
        })
    }
}

struct UsedThenUnusedInstance<'a> {
    context: &'a Context<'a>,
    params: UsedThenUnusedParams,
}

impl TestInstance for UsedThenUnusedInstance<'_> {
    /// `usedThenUnusedRun`
    fn iterate(&mut self) -> TestOutcome {
        use vulkanalia::vk::{DeviceV1_3, ExtExtendedDynamicStateExtensionDeviceCommands};

        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let depth_format = vk::Format::D16_UNORM;
        let depth_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_srl = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let depth_srl = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::DEPTH,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };

        let color_buffer = ImageWithBufferLayers::new(context, color_format, 4, color_usage, color_srr, 1)?;
        let depth_buffer = ImageWithBufferLayers::new(context, depth_format, 2, depth_usage, depth_srr, 1)?;

        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let pc_stages = vk::ShaderStageFlags::FRAGMENT;
        let pc_size = 16u32;
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        }];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let topology = vk::PrimitiveTopology::TRIANGLE_STRIP;
        let color_formats = [color_format];

        // Will be unused in the first render pass.
        let mut initial_rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(depth_format)
            .stencil_attachment_format(vk::Format::UNDEFINED);
        // One colour format pointer with a count of zero, as upstream has it.
        let mut depth_rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .depth_attachment_format(depth_format)
            .stencil_attachment_format(vk::Format::UNDEFINED);

        // Depth state with depth test and writes enabled.
        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::KEEP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::NEVER,
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(0.0);

        // Depth state like the previous one but with the depth test disabled.
        let depth_disabled_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(false)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(0.0);

        let dynamic_states: Vec<vk::DynamicState> = if params.dynamic_depth_enable {
            vec![vk::DynamicState::DEPTH_TEST_ENABLE]
        } else {
            Vec::new()
        };

        // The default colour blend state `makeGraphicsPipeline` builds when none is given: one attachment writing every channel.
        let blend_attachment_states = [vk::PipelineColorBlendAttachmentState::builder()
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachment_states);

        // The initial pipeline, which only uses a color attachment, has the depth state disabled, but may use a dynamic state.
        let initial_pipeline = create_pipeline(
            device,
            *pipeline_layout,
            *vert_shader,
            *frag_shader,
            topology,
            &depth_disabled_state,
            &color_blend_state,
            Some(&dynamic_states),
            &mut initial_rendering_create_info,
        )?;

        // The depth-enabled pipeline, if needed, does not have dynamic state, and has the depth test enabled.
        let depth_pipeline = if !params.dynamic_depth_enable {
            Some(create_pipeline(
                device,
                *pipeline_layout,
                *vert_shader,
                *frag_shader,
                topology,
                &depth_stencil_state,
                &color_blend_state,
                None,
                &mut depth_rendering_create_info,
            )?)
        } else {
            None
        };

        // Rendering information for both render passes.
        let color_att_info = vk::RenderingAttachmentInfo::builder()
            .image_view(*color_buffer.view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .resolve_image_view(vk::ImageView::null())
            .resolve_image_layout(vk::ImageLayout::UNDEFINED)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            }) // Not used, see load op.
            .build();
        let depth_att_info = vk::RenderingAttachmentInfo::builder()
            .image_view(*depth_buffer.view)
            .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .resolve_image_view(vk::ImageView::null())
            .resolve_image_layout(vk::ImageLayout::UNDEFINED)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            }) // Not used, see load op.
            .build();

        let rendering_flags = if params.use_secondaries {
            vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
        } else {
            vk::RenderingFlags::empty()
        };

        let color_attachments = [color_att_info];
        let color_only_render_info = vk::RenderingInfo::builder()
            .flags(rendering_flags)
            .render_area(rect_2d(1, 1))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_attachments);

        let no_color_attachments: [vk::RenderingAttachmentInfo; 0] = [];
        let mut depth_only_render_info = vk::RenderingInfo::builder()
            .flags(rendering_flags)
            .render_area(rect_2d(1, 1))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&no_color_attachments)
            .depth_attachment(&depth_att_info);
        // Upstream passes the colour attachment pointer with a count of zero.
        depth_only_render_info.color_attachment_count = 0;

        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let good_color = [0.0f32, 0.0, 1.0, 1.0];
        let bad_color = [1.0f32, 0.0, 0.0, 1.0];
        let color_bytes = |color: [f32; 4]| -> Vec<u8> { color.iter().flat_map(|c| c.to_ne_bytes()).collect() };

        let initial_pipeline_handle = *initial_pipeline;
        let depth_pipeline_handle = depth_pipeline.as_ref().map(|pipeline| **pipeline);
        let layout_handle = *pipeline_layout;

        let record_initial_rp = |cmd_buffer: vk::CommandBuffer| unsafe {
            // The first render pass always binds the initial pipeline.
            device.cmd_bind_pipeline(cmd_buffer, bind_point, initial_pipeline_handle);
            if params.dynamic_depth_enable {
                device.cmd_set_depth_test_enable_ext(cmd_buffer, false);
            }
            device.cmd_push_constants(cmd_buffer, layout_handle, pc_stages, 0, &color_bytes(good_color));
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);
        };

        let record_depth_only_rp = |cmd_buffer: vk::CommandBuffer, secondary: bool| unsafe {
            // The second RP needs to bind the pipeline sometimes.
            if params.dynamic_depth_enable {
                // We are forced to rebind when using secondaries.
                if secondary {
                    device.cmd_bind_pipeline(cmd_buffer, bind_point, initial_pipeline_handle);
                }
                device.cmd_set_depth_test_enable_ext(cmd_buffer, true);
            } else {
                device.cmd_bind_pipeline(
                    cmd_buffer,
                    bind_point,
                    depth_pipeline_handle.expect("a depth pipeline exists without dynamic depth enable"),
                );
            }
            device.cmd_push_constants(cmd_buffer, layout_handle, pc_stages, 0, &color_bytes(bad_color));
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);
        };

        let command_pool = make_command_pool(device, queue_family_index)?;
        let primary_cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let mut initial_secondary: Option<UniqueCommandBuffer<'_>> = None;
        let mut depth_only_secondary: Option<UniqueCommandBuffer<'_>> = None;

        if params.use_secondaries {
            // The only difference between both secondaries could be the color attachment count in the inheritance rendering
            // info. However, the rendering info also has to match the inheritance rendering info regarding the depth
            // attachment, with NULL views matching undefined formats. See VUID-vkCmdExecuteCommands-pDepthAttachment-06774.
            let begin_secondary_command_buffer = |cmd_buffer: vk::CommandBuffer,
                                                  color_attachment_count: u32,
                                                  rendering_depth_format: vk::Format|
             -> Result<(), TestError> {
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(vk::RenderingFlags::empty())
                    .view_mask(0)
                    .color_attachment_formats(&color_formats)
                    .depth_attachment_format(rendering_depth_format)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(vk::SampleCountFlags::_1);
                inheritance_rendering_info.color_attachment_count = color_attachment_count;
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                    .inheritance_info(&inheritance_info);

                unsafe { device.begin_command_buffer(cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")
            };

            let initial = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::SECONDARY)?;
            let depth_only = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::SECONDARY)?;

            begin_secondary_command_buffer(*initial, 1, vk::Format::UNDEFINED)?;
            record_initial_rp(*initial);
            end_command_buffer(device, *initial)?;

            begin_secondary_command_buffer(*depth_only, 0, depth_format)?;
            record_depth_only_rp(*depth_only, true);
            end_command_buffer(device, *depth_only)?;

            initial_secondary = Some(initial);
            depth_only_secondary = Some(depth_only);
        }

        let cmd = *primary_cmd;
        begin_command_buffer(device, cmd)?;

        // Move images to the clear layouts.
        {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    color_buffer.image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    depth_buffer.image.get(),
                    depth_srr,
                ),
            ];
            barrier_color(
                device,
                cmd,
                vk::PipelineStageFlags::empty(),
                vk::PipelineStageFlags::TRANSFER,
                &barriers,
            );
        }

        let clear_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        };
        let clear_depth = vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 }; // Different from the one in the vertex shader.

        unsafe {
            device.cmd_clear_color_image(
                cmd,
                color_buffer.image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color,
                &[color_srr],
            );
            device.cmd_clear_depth_stencil_image(
                cmd,
                depth_buffer.image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_depth,
                &[depth_srr],
            );
        }

        // Move images to the rendering layouts.
        {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_buffer.image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_buffer.image.get(),
                    depth_srr,
                ),
            ];
            barrier_color(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                rendering_stages(),
                &barriers,
            );
        }

        unsafe { device.cmd_begin_rendering(cmd, &color_only_render_info) };
        if let Some(secondary) = &initial_secondary {
            unsafe { device.cmd_execute_commands(cmd, &[**secondary]) };
        } else {
            record_initial_rp(cmd);
        }
        unsafe { device.cmd_end_rendering(cmd) };

        unsafe { device.cmd_begin_rendering(cmd, &depth_only_render_info) };
        if let Some(secondary) = &depth_only_secondary {
            unsafe { device.cmd_execute_commands(cmd, &[**secondary]) };
        } else {
            record_depth_only_rp(cmd, false);
        }
        unsafe { device.cmd_end_rendering(cmd) };

        {
            // Move images to the transfer layouts.
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_buffer.image.get(),
                    depth_srr,
                ),
            ];
            barrier_color(
                device,
                cmd,
                rendering_stages(),
                vk::PipelineStageFlags::TRANSFER,
                &barriers,
            );
        }
        {
            // Copy images to their buffers.
            let region = |layers: vk::ImageSubresourceLayers| vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: layers,
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: extent,
            };
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    color_buffer.image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.buffer.get(),
                    &[region(color_srl)],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    depth_buffer.image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_buffer.buffer.get(),
                    &[region(depth_srl)],
                );
            }

            // Barrier to the host.
            host_read_barrier(device, cmd);
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, color_buffer.buffer.get_allocation())?;
        invalidate_alloc(device, depth_buffer.buffer.get_allocation())?;

        // Both results are exact: the colour is the good colour, the depth the 0.0 the vertex shader writes (not the 1.0 clear).
        let color_result =
            unsafe { std::slice::from_raw_parts(color_buffer.buffer.get_allocation().get_host_ptr().cast_const(), 4) };
        let depth_result =
            unsafe { std::slice::from_raw_parts(depth_buffer.buffer.get_allocation().get_host_ptr().cast_const(), 2) };

        let color_matches = color_result == [0, 0, 255, 255];
        let depth_matches = u16::from_ne_bytes([depth_result[0], depth_result[1]]) == 0;

        if !color_matches || !depth_matches {
            return Ok(TestStatus::fail(
                "Unexpected results in color or depth buffers; check log for details --",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDynamicRenderingUnusedAttachmentsTests`
pub fn create_dynamic_rendering_unused_attachments_tests(use_secondaries: bool) -> TestCaseGroup {
    // Tests for VK_EXT_dynamic_rendering_unused_attachments
    let mut group = TestCaseGroup::new("unused_attachments");

    // Add a combination subgroup just in case we want to add more test cases later to another subgroup.
    let mut comb_group = TestCaseGroup::new("comb");
    let mut color_group = TestCaseGroup::new("color");
    let mut ds_group = TestCaseGroup::new("depth_stencil");
    let mut bad_fmt_grp = TestCaseGroup::new("bad_formats");
    let mut more_att_grp = TestCaseGroup::new("extra_att");
    let mut ex_pipe_att_grp = TestCaseGroup::new("extra_pipe_att");
    let mut ex_render_att_grp = TestCaseGroup::new("extra_render_att");

    const ATTACHMENT_COUNTS: [u32; 3] = [1, 4, 8];
    const LAYER_COUNTS: [u32; 2] = [1, 4];
    const MASKS_TO_TEST: [u32; 4] = [0xFFFF_FFFF, 0x0, 0x5555_5555, 0xAAAA_AAAA];

    let add_case = |group: &mut TestCaseGroup, params: TestParams| {
        group.add_child(Box::new(DynamicUnusedAttachmentsCase {
            name: params.get_test_name(),
            params,
        }) as Box<dyn TestCase>);
    };

    {
        // Combinations of color attachment counts, no depth/stencil.
        for pipe_att in ATTACHMENT_COUNTS {
            for frag_att in ATTACHMENT_COUNTS {
                if frag_att < pipe_att {
                    continue;
                }

                for layer_count in LAYER_COUNTS {
                    for layer_mask in MASKS_TO_TEST {
                        // Avoid duplicate cases.
                        if layer_count == 1 && layer_mask != MASKS_TO_TEST[0] && layer_mask != MASKS_TO_TEST[1] {
                            continue;
                        }

                        for format_mask in MASKS_TO_TEST {
                            for handle_mask in MASKS_TO_TEST {
                                for multiview in [false, true] {
                                    let view_mask = ((1u32 << layer_count) - 1) & layer_mask;

                                    if multiview && view_mask == 0 {
                                        continue;
                                    }

                                    let params = TestParams::new(
                                        pipe_att,
                                        frag_att,
                                        layer_count,
                                        view_mask,
                                        multiview,
                                        format_mask,
                                        handle_mask,
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                        use_secondaries,
                                        false,
                                        false,
                                        false,
                                        false,
                                    );
                                    add_case(&mut color_group, params);
                                }
                            }
                        }
                    }
                }
            }
        }

        // Combinations of depth/stencil parameters, single color attachment.
        for depth_present in [false, true] {
            for depth_defined in [false, true] {
                for depth_valid_handle in [false, true] {
                    if !depth_present && (depth_defined || depth_valid_handle) {
                        continue;
                    }

                    for stencil_present in [false, true] {
                        for stencil_defined in [false, true] {
                            for stencil_valid_handle in [false, true] {
                                if !stencil_present && (stencil_defined || stencil_valid_handle) {
                                    continue;
                                }

                                // Either both or none according to VUID-VkRenderingInfo-pDepthAttachment-06085
                                if depth_valid_handle != stencil_valid_handle {
                                    continue;
                                }

                                // So far there is no VU that prevents only one of the depth/stencil formats from being
                                // VK_FORMAT_UNDEFINED while the other one is not. However, that would mean disabling the
                                // depth/stencil test (or at least make that aspect read-only, it's not clear) through a second
                                // mechanism in the pipeline configuration.
                                //
                                // We can still test the VK_NULL_HANDLE/VK_FORMAT_UNDEFINED inconsistency, just not separately for
                                // depth and stencil, which is one of the focus of these tests.
                                if depth_defined != stencil_defined {
                                    continue;
                                }

                                for layer_count in LAYER_COUNTS {
                                    for layer_mask in MASKS_TO_TEST {
                                        // Avoid duplicate cases.
                                        if layer_count == 1
                                            && layer_mask != MASKS_TO_TEST[0]
                                            && layer_mask != MASKS_TO_TEST[1]
                                        {
                                            continue;
                                        }

                                        for multiview in [false, true] {
                                            let view_mask = ((1u32 << layer_count) - 1) & layer_mask;

                                            if multiview && view_mask == 0 {
                                                continue;
                                            }

                                            let params = TestParams::new(
                                                1,
                                                1,
                                                layer_count,
                                                view_mask,
                                                multiview,
                                                0xFFFF_FFFF,
                                                0xFFFF_FFFF,
                                                depth_present,
                                                depth_defined,
                                                depth_valid_handle,
                                                stencil_present,
                                                stencil_defined,
                                                stencil_valid_handle,
                                                use_secondaries,
                                                false,
                                                false,
                                                false,
                                                false,
                                            );
                                            add_case(&mut ds_group, params);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        comb_group.add_child(color_group);
        comb_group.add_child(ds_group);
    }
    group.add_child(comb_group);

    // Bad format tests.
    {
        for format_mask in MASKS_TO_TEST {
            for handle_mask in MASKS_TO_TEST {
                if handle_mask == 0xFFFF_FFFF || format_mask == handle_mask {
                    continue;
                }

                let params = TestParams::new(
                    4,
                    4,
                    1,
                    1,
                    false,
                    format_mask,
                    handle_mask,
                    true,
                    true,
                    false,
                    true,
                    true,
                    false,
                    use_secondaries,
                    true,
                    false,
                    false,
                    false,
                );
                add_case(&mut bad_fmt_grp, params);
            }
        }
    }
    group.add_child(bad_fmt_grp);

    // Extra attachments tests.
    {
        for att_count in ATTACHMENT_COUNTS {
            for format_mask in MASKS_TO_TEST {
                for handle_mask in MASKS_TO_TEST {
                    if handle_mask == 0xFFFF_FFFF || format_mask == handle_mask {
                        continue;
                    }

                    let params = TestParams::new(
                        att_count,
                        att_count,
                        1,
                        1,
                        false,
                        format_mask,
                        handle_mask,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        use_secondaries,
                        false,
                        true,
                        false,
                        false,
                    );
                    add_case(&mut more_att_grp, params);
                }
            }
        }
        group.add_child(more_att_grp);

        {
            let extra_att_is_unused = true;

            for att_count in ATTACHMENT_COUNTS {
                for format_mask in MASKS_TO_TEST {
                    for handle_mask in MASKS_TO_TEST {
                        if format_mask == handle_mask {
                            continue;
                        }

                        let params = TestParams::new(
                            att_count,
                            att_count,
                            1,
                            1,
                            false,
                            format_mask,
                            handle_mask,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            use_secondaries,
                            false,
                            true,
                            false,
                            extra_att_is_unused,
                        );
                        add_case(&mut ex_pipe_att_grp, params);
                    }
                }
            }
        }
        group.add_child(ex_pipe_att_grp);

        for att_count in ATTACHMENT_COUNTS {
            for format_mask in MASKS_TO_TEST {
                for handle_mask in MASKS_TO_TEST {
                    for extra_att_is_unused in [false, true] {
                        let params = TestParams::new(
                            att_count,
                            att_count,
                            1,
                            1,
                            false,
                            format_mask,
                            handle_mask,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            use_secondaries,
                            false,
                            false,
                            true,
                            extra_att_is_unused,
                        );
                        add_case(&mut ex_render_att_grp, params);
                    }
                }
            }
        }
        group.add_child(ex_render_att_grp);
    }

    // Misc tests.
    {
        let mut misc_group = TestCaseGroup::new("misc");

        for dynamic_depth_enable in [false, true] {
            let params = UsedThenUnusedParams {
                use_secondaries,
                dynamic_depth_enable,
            };
            let test_name = format!(
                "color_used_then_unused{}",
                if dynamic_depth_enable {
                    "_dynamic_depth_enable"
                } else {
                    ""
                }
            );
            misc_group.add_child(Box::new(UsedThenUnusedCase {
                name: test_name,
                params,
            }) as Box<dyn TestCase>);
        }

        group.add_child(misc_group);
    }

    group
}
