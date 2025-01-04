// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassLoadStoreOpNoneTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic pipeline construction type is registered.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::renderpass_load_store_op_none::LOAD_STORE_OP_NONE;
use crate::tcu::pixel::{has_depth_component, has_stencil_component};
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{clear_value_color, rect_2d, viewport};
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const ATTACHMENT_INIT_PRE: u32 = 1;
const ATTACHMENT_INIT_CMD_CLEAR: u32 = 2;

const USAGE_UNDEFINED: u32 = 0;
const USAGE_COLOR: u32 = 1;
const USAGE_DEPTH: u32 = 2;
const USAGE_STENCIL: u32 = 4;
const USAGE_DEPTH_STENCIL: u32 = USAGE_DEPTH | USAGE_STENCIL;
const USAGE_INPUT: u32 = 8;
const USAGE_COLOR_WRITE_OFF: u32 = 16;
const USAGE_DEPTH_WRITE_OFF: u32 = 32;
const USAGE_STENCIL_WRITE_OFF: u32 = 64;
const USAGE_DEPTH_TEST_OFF: u32 = 128;
const USAGE_STENCIL_TEST_OFF: u32 = 256;
const USAGE_MULTISAMPLE: u32 = 512;
const USAGE_RESOLVE_TARGET: u32 = 1024;
const USAGE_INTEGER: u32 = 2048;

const IMAGE_SIZE: u32 = 32;
const RENDER_WIDTH: u32 = 27;
const RENDER_HEIGHT: u32 = 19;
const ATTACHMENT_UNUSED: u32 = u32::MAX;

const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
const MAGENTA: [f32; 4] = [1.0, 0.0, 1.0, 1.0];
const DARK_BLUE: [f32; 4] = [0.0, 0.0, 0.5, 1.0];
const BLEND: [f32; 4] = [0.5, 0.0, 0.25, 0.5];
const DEPTH_INIT: [f32; 4] = [0.5, 0.0, 0.0, 1.0];
const DEPTH_FULL: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const STENCIL_INIT: [f32; 4] = [128.0, 0.0, 0.0, 1.0];
const STENCIL_FULL: [f32; 4] = [255.0, 0.0, 0.0, 1.0];
const RED_UINT: [f32; 4] = [255.0, 0.0, 0.0, 255.0];
const GREEN_UINT: [f32; 4] = [0.0, 255.0, 0.0, 255.0];

/// `VerifyAspect`
#[derive(Clone)]
struct VerifyAspect {
    aspect: vk::ImageAspectFlags,
    verify_inner: bool,
    inner_ref: [f32; 4],
    verify_outer: bool,
    outer_ref: [f32; 4],
}

/// `AttachmentParams`
#[derive(Clone)]
struct AttachmentParams {
    usage: u32,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    init: u32,
    verify_aspects: Vec<VerifyAspect>,
}

/// `AttachmentRef`
#[derive(Clone, Copy)]
struct AttachmentRef {
    idx: u32,
    usage: u32,
}

/// `SubpassParams`
#[derive(Clone)]
struct SubpassParams {
    attachment_refs: Vec<AttachmentRef>,
    num_draws: u32,
}

/// `ExtensionPreference`: both VK_EXT_load_store_op_none and VK_KHR_load_store_op_none are tested, KHR by default and EXT for
/// some tests. Either way, if one extension is not available, the other is always used.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ExtensionPreference {
    Ext,
    Khr,
}

/// `TestParams`
#[derive(Clone)]
struct TestParams {
    attachments: Vec<AttachmentParams>,
    subpasses: Vec<SubpassParams>,
    group_params: GroupParams,
    depth_stencil_format: vk::Format,
    alpha_blend: bool,
    ext_preference: ExtensionPreference,
}

fn attachment(
    usage: u32,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    init: u32,
    verify_aspects: Vec<VerifyAspect>,
) -> AttachmentParams {
    AttachmentParams {
        usage,
        load_op,
        store_op,
        stencil_load_op,
        stencil_store_op,
        init,
        verify_aspects,
    }
}

fn verify(
    aspect: vk::ImageAspectFlags,
    verify_inner: bool,
    inner_ref: [f32; 4],
    verify_outer: bool,
    outer_ref: [f32; 4],
) -> VerifyAspect {
    VerifyAspect {
        aspect,
        verify_inner,
        inner_ref,
        verify_outer,
        outer_ref,
    }
}

fn subpass(refs: &[(u32, u32)], num_draws: u32) -> SubpassParams {
    SubpassParams {
        attachment_refs: refs.iter().map(|&(idx, usage)| AttachmentRef { idx, usage }).collect(),
        num_draws,
    }
}

/// `getFirstUsage`
fn get_first_usage(attachment_idx: u32, subpasses: &[SubpassParams]) -> u32 {
    for subpass in subpasses {
        for r in &subpass.attachment_refs {
            if r.idx == attachment_idx {
                return r.usage;
            }
        }
    }
    USAGE_UNDEFINED
}

/// `getFormatCaseName`
fn format_case_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::D16_UNORM => "d16_unorm",
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::D16_UNORM_S8_UINT => "d16_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        vk::Format::D32_SFLOAT_S8_UINT => "d32_sfloat_s8_uint",
        vk::Format::S8_UINT => "s8_uint",
        _ => "unknown",
    }
}

/// `getFormat`: selects an image format based on the usage flags.
fn get_format(usage: u32, depth_stencil_format: vk::Format) -> vk::Format {
    if usage & USAGE_DEPTH_STENCIL != 0 {
        return depth_stencil_format;
    }
    if usage & USAGE_INTEGER != 0 {
        // Color attachment using integer format.
        return vk::Format::R8G8B8A8_UINT;
    }
    vk::Format::R8G8B8A8_UNORM
}

/// `getImageAspectFlags(mapVkFormat(format))`
fn image_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    let Some(tcu_format) = map_vk_format(format) else {
        return vk::ImageAspectFlags::COLOR;
    };
    let mut mask = vk::ImageAspectFlags::empty();
    if has_depth_component(tcu_format.order) {
        mask |= vk::ImageAspectFlags::DEPTH;
    }
    if has_stencil_component(tcu_format.order) {
        mask |= vk::ImageAspectFlags::STENCIL;
    }
    if mask.is_empty() {
        mask |= vk::ImageAspectFlags::COLOR;
    }
    mask
}

struct LoadStoreOpNoneTest {
    name: String,
    params: TestParams,
}

impl TestCase for LoadStoreOpNoneTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `LoadStoreOpNoneTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let p = &self.params;

        // Check for renderpass2 extension if used.
        if p.group_params.rendering_type == RenderingType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }

        // Check for dynamic_rendering extension if used
        if p.group_params.rendering_type == RenderingType::DynamicRendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
            if p.subpasses.len() > 1 {
                context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;
            }
        }

        let supports_ext = context.is_device_functionality_supported("VK_EXT_load_store_op_none");
        let supports_khr = context.is_device_functionality_supported("VK_KHR_load_store_op_none");
        // Prefer VK_EXT_load_store_op_none if supported, and either explicitly preferred or KHR is not supported. Otherwise
        // require VK_KHR_load_store_op_none. The tests are skipped if neither extension is supported.
        if supports_ext && (p.ext_preference == ExtensionPreference::Ext || !supports_khr) {
            context.require_device_functionality("VK_EXT_load_store_op_none")?;
        } else {
            context.require_device_functionality("VK_KHR_load_store_op_none")?;
        }

        // Check depth/stencil format support.
        for att in &p.attachments {
            if att.usage & USAGE_DEPTH_STENCIL != 0 {
                let format = get_format(att.usage, p.depth_stencil_format);
                let mut usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
                if !att.verify_aspects.is_empty() {
                    usage |= vk::ImageUsageFlags::TRANSFER_SRC;
                }
                if att.init & ATTACHMENT_INIT_PRE != 0 {
                    usage |= vk::ImageUsageFlags::TRANSFER_DST;
                }

                let result = unsafe {
                    context.get_instance().get_physical_device_image_format_properties(
                        context.get_physical_device(),
                        format,
                        vk::ImageType::_2D,
                        vk::ImageTiling::OPTIMAL,
                        usage,
                        vk::ImageCreateFlags::empty(),
                    )
                };
                if result.is_err() {
                    return Err(TestError::NotSupported(
                        "Depth-stencil format not supported".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        LOAD_STORE_OP_NONE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LoadStoreOpNoneInstance {
            context,
            params: &self.params,
        })
    }
}

struct LoadStoreOpNoneInstance<'a> {
    context: &'a Context<'a>,
    params: &'a TestParams,
}

/// An attachment image and the view of it.
struct AttachmentImage<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
}

/// What `createRenderPass` collects per subpass: (attachment, layout, aspect mask).
#[derive(Default)]
struct SubpassRefs {
    color: Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>,
    resolve: Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>,
    depth_stencil: Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>,
    input: Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>,
}

/// The objects one subpass's pipeline needs besides the pipeline itself.
struct PipelineSpec<'a> {
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    subpass_idx: usize,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    num_input_attachments: u32,
    no_color_write: bool,
    depth_test: bool,
    stencil_test: bool,
    depth_write: bool,
    stencil_write: bool,
    multisample: bool,
    depth_compare_op: vk::CompareOp,
    stencil_compare_op: vk::CompareOp,
    subpass: &'a SubpassParams,
}

impl<'a> LoadStoreOpNoneInstance<'a> {
    fn is_dynamic_rendering(&self) -> bool {
        self.params.group_params.rendering_type == RenderingType::DynamicRendering
    }

    /// `clearColorImage` (vktRenderPassTestsUtil): clears `image` and leaves it in `new_layout`, in a submission of its own.
    #[allow(clippy::too_many_arguments)]
    fn clear_color_image(
        &self,
        image: vk::Image,
        color: vk::ClearColorValue,
        old_layout: vk::ImageLayout,
        new_layout: vk::ImageLayout,
        dst_access: vk::AccessFlags,
        dst_stage: vk::PipelineStageFlags,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let pre_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            old_layout,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image,
            range,
        );
        let post_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            dst_access,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            new_layout,
            image,
            range,
        );

        begin_command_buffer(device, *cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_barrier],
            );
            device.cmd_clear_color_image(*cmd, image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &color, &[range]);
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TRANSFER,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_barrier],
            );
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)
    }

    /// `clearDepthStencilImage` (vktRenderPassTestsUtil)
    #[allow(clippy::too_many_arguments)]
    fn clear_depth_stencil_image(
        &self,
        image: vk::Image,
        format: vk::Format,
        depth: f32,
        stencil: u32,
        old_layout: vk::ImageLayout,
        new_layout: vk::ImageLayout,
        dst_access: vk::AccessFlags,
        dst_stage: vk::PipelineStageFlags,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
        let range = make_image_subresource_range(image_aspect_flags(format), 0, 1, 0, 1);

        let pre_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            old_layout,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image,
            range,
        );
        let post_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            dst_access,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            new_layout,
            image,
            range,
        );
        let clear_value = vk::ClearDepthStencilValue { depth, stencil };

        begin_command_buffer(device, *cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_barrier],
            );
            device.cmd_clear_depth_stencil_image(
                *cmd,
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_value,
                &[range],
            );
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TRANSFER,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_barrier],
            );
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)
    }

    /// `copyImageToBuffer` plus the buffer read back by `pipeline::readColorAttachment` and its depth and stencil siblings.
    fn read_image_bytes(
        &self,
        image: vk::Image,
        barrier_aspect: vk::ImageAspectFlags,
        copy_aspect: vk::ImageAspectFlags,
        src_access: vk::AccessFlags,
        old_layout: vk::ImageLayout,
        buffer_size: usize,
    ) -> Result<Vec<u8>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;

        let transfer_layout = if old_layout == vk::ImageLayout::GENERAL {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };
        let image_barrier = make_image_memory_barrier(
            src_access,
            vk::AccessFlags::TRANSFER_READ,
            old_layout,
            transfer_layout,
            image,
            make_image_subresource_range(barrier_aspect, 0, 1, 0, 1),
        );
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: copy_aspect,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: IMAGE_SIZE,
                height: IMAGE_SIZE,
                depth: 1,
            },
        };
        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(buffer.get())
            .offset(0)
            .size(vk::WHOLE_SIZE)
            .build();

        begin_command_buffer(device, *cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            device.cmd_copy_image_to_buffer(*cmd, image, transfer_layout, buffer.get(), &[region]);
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut out = vec![0u8; buffer_size];
        unsafe { std::ptr::copy_nonoverlapping(buffer.get_allocation().get_host_ptr(), out.as_mut_ptr(), buffer_size) };
        Ok(out)
    }

    /// `pipeline::readColorAttachment`: pixels as `tcu::Vec4`, which for an integer format are the raw values.
    fn read_color_attachment(
        &self,
        image: vk::Image,
        format: vk::Format,
        layout: vk::ImageLayout,
    ) -> Result<Vec<[f32; 4]>, TestError> {
        let bytes = self.read_image_bytes(
            image,
            vk::ImageAspectFlags::COLOR,
            vk::ImageAspectFlags::COLOR,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            layout,
            (IMAGE_SIZE * IMAGE_SIZE * 4) as usize,
        )?;
        let normalized = format != vk::Format::R8G8B8A8_UINT;
        Ok(bytes
            .chunks_exact(4)
            .map(|pixel| {
                let channel = |c: usize| {
                    if normalized {
                        pixel[c] as f32 / 255.0
                    } else {
                        pixel[c] as f32
                    }
                };
                [channel(0), channel(1), channel(2), channel(3)]
            })
            .collect())
    }

    /// `pipeline::readDepthAttachment`
    fn read_depth_attachment(&self, image: vk::Image, layout: vk::ImageLayout) -> Result<Vec<[f32; 4]>, TestError> {
        let format = self.params.depth_stencil_format;
        let barrier_aspect = vk::ImageAspectFlags::DEPTH
            | if image_aspect_flags(format).contains(vk::ImageAspectFlags::STENCIL) {
                vk::ImageAspectFlags::STENCIL
            } else {
                vk::ImageAspectFlags::empty()
            };
        let texel_size = match format {
            vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => 2,
            vk::Format::D24_UNORM_S8_UINT
            | vk::Format::X8_D24_UNORM_PACK32
            | vk::Format::D32_SFLOAT
            | vk::Format::D32_SFLOAT_S8_UINT => 4,
            _ => return Err(TestError::Fail("unrecognized format".to_string())),
        };
        let bytes = self.read_image_bytes(
            image,
            barrier_aspect,
            vk::ImageAspectFlags::DEPTH,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            layout,
            (IMAGE_SIZE * IMAGE_SIZE) as usize * texel_size,
        )?;
        Ok(bytes
            .chunks_exact(texel_size)
            .map(|texel| {
                let depth = match format {
                    vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => {
                        u16::from_le_bytes([texel[0], texel[1]]) as f32 / 65535.0
                    }
                    vk::Format::D24_UNORM_S8_UINT | vk::Format::X8_D24_UNORM_PACK32 => {
                        (u32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]]) & 0x00ff_ffff) as f32
                            / 16_777_215.0
                    }
                    _ => f32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]]),
                };
                [depth, 0.0, 0.0, 1.0]
            })
            .collect())
    }

    /// `pipeline::readStencilAttachment`
    fn read_stencil_attachment(&self, image: vk::Image, layout: vk::ImageLayout) -> Result<Vec<[f32; 4]>, TestError> {
        let format = self.params.depth_stencil_format;
        let barrier_aspect = vk::ImageAspectFlags::STENCIL
            | if image_aspect_flags(format).contains(vk::ImageAspectFlags::DEPTH) {
                vk::ImageAspectFlags::DEPTH
            } else {
                vk::ImageAspectFlags::empty()
            };
        let bytes = self.read_image_bytes(
            image,
            barrier_aspect,
            vk::ImageAspectFlags::STENCIL,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            layout,
            (IMAGE_SIZE * IMAGE_SIZE) as usize,
        )?;
        Ok(bytes.iter().map(|&stencil| [stencil as f32, 0.0, 0.0, 1.0]).collect())
    }

    /// `createRenderPass`, for the legacy and the `VkRenderPassCreateInfo2` flavours.
    fn create_render_pass(&self) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let legacy = p.group_params.rendering_type == RenderingType::Legacy;
        let aspect_mask = if legacy {
            vk::ImageAspectFlags::empty()
        } else {
            vk::ImageAspectFlags::COLOR
        };

        let mut attachment_descriptions = Vec::new();
        for (i, att) in p.attachments.iter().enumerate() {
            let format = get_format(att.usage, p.depth_stencil_format);

            // Search for the first reference to determine the initial layout.
            let mut first_usage = get_first_usage(i as u32, &p.subpasses);

            // No subpasses using this attachment. Use the usage flags of the attachment.
            if first_usage == USAGE_UNDEFINED {
                first_usage = att.usage;
            }

            let initial_layout = if first_usage & USAGE_COLOR != 0 {
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
            } else if first_usage & USAGE_DEPTH_STENCIL != 0 {
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
            } else {
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
            };

            // Set final layout to transfer src if it's being verified. Otherwise just use the initial layout as it's known to be
            // supported by the usage flags.
            let final_layout = if !att.verify_aspects.is_empty() {
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL
            } else {
                initial_layout
            };

            let sample_count = if att.usage & USAGE_MULTISAMPLE != 0 {
                vk::SampleCountFlags::_4
            } else {
                vk::SampleCountFlags::_1
            };

            attachment_descriptions.push(
                vk::AttachmentDescription::builder()
                    .format(format)
                    .samples(sample_count)
                    .load_op(att.load_op)
                    .store_op(att.store_op)
                    .stencil_load_op(att.stencil_load_op)
                    .stencil_store_op(att.stencil_store_op)
                    .initial_layout(initial_layout)
                    .final_layout(final_layout)
                    .build(),
            );
        }

        let mut subpass_refs: Vec<SubpassRefs> = Vec::new();
        let mut has_input_attachment = false;
        for subpass in &p.subpasses {
            let mut refs = SubpassRefs::default();
            for r in &subpass.attachment_refs {
                if r.usage & USAGE_RESOLVE_TARGET != 0 {
                    refs.resolve
                        .push((r.idx, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, aspect_mask));
                } else if r.usage & USAGE_COLOR != 0 {
                    refs.color
                        .push((r.idx, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL, aspect_mask));
                } else if r.usage & USAGE_DEPTH_STENCIL != 0 {
                    let depth_stencil_aspect_mask = if legacy {
                        vk::ImageAspectFlags::empty()
                    } else {
                        image_aspect_flags(p.depth_stencil_format)
                    };
                    refs.depth_stencil.push((
                        r.idx,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        depth_stencil_aspect_mask,
                    ));
                } else {
                    refs.input
                        .push((r.idx, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL, aspect_mask));
                    has_input_attachment = true;
                }
            }
            subpass_refs.push(refs);
        }

        if legacy {
            let to_refs = |list: &[(u32, vk::ImageLayout, vk::ImageAspectFlags)]| -> Vec<vk::AttachmentReference> {
                list.iter()
                    .map(|&(attachment, layout, _)| vk::AttachmentReference { attachment, layout })
                    .collect()
            };
            let legacy_refs: Vec<[Vec<vk::AttachmentReference>; 4]> = subpass_refs
                .iter()
                .map(|r| {
                    [
                        to_refs(&r.input),
                        to_refs(&r.color),
                        to_refs(&r.resolve),
                        to_refs(&r.depth_stencil),
                    ]
                })
                .collect();
            let subpass_descriptions: Vec<vk::SubpassDescription> = legacy_refs
                .iter()
                .map(|refs| {
                    let mut builder = vk::SubpassDescription::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .input_attachments(&refs[0])
                        .color_attachments(&refs[1]);
                    if !refs[2].is_empty() {
                        builder = builder.resolve_attachments(&refs[2]);
                    }
                    if let Some(depth_stencil) = refs[3].first() {
                        builder = builder.depth_stencil_attachment(depth_stencil);
                    }
                    builder.build()
                })
                .collect();

            // Dependency of color attachment of subpass 0 to input attachment of subpass 1. Determined later if it's being used.
            let dependencies = [vk::SubpassDependency {
                src_subpass: 0,
                dst_subpass: 1,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            }];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descriptions)
                .subpasses(&subpass_descriptions)
                .dependencies(if has_input_attachment {
                    &dependencies[..]
                } else {
                    &dependencies[..0]
                });
            let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
            return Ok(Unique::new(device, render_pass));
        }

        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let attachment_descriptions2: Vec<vk::AttachmentDescription2> = attachment_descriptions
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
        let to_refs2 = |list: &[(u32, vk::ImageLayout, vk::ImageAspectFlags)]| -> Vec<vk::AttachmentReference2> {
            list.iter()
                .map(|&(attachment, layout, aspect)| {
                    vk::AttachmentReference2::builder()
                        .attachment(attachment)
                        .layout(layout)
                        .aspect_mask(aspect)
                        .build()
                })
                .collect()
        };
        let refs2: Vec<[Vec<vk::AttachmentReference2>; 4]> = subpass_refs
            .iter()
            .map(|r| {
                [
                    to_refs2(&r.input),
                    to_refs2(&r.color),
                    to_refs2(&r.resolve),
                    to_refs2(&r.depth_stencil),
                ]
            })
            .collect();
        let subpass_descriptions2: Vec<vk::SubpassDescription2> = refs2
            .iter()
            .map(|refs| {
                let mut builder = vk::SubpassDescription2::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .view_mask(0)
                    .input_attachments(&refs[0])
                    .color_attachments(&refs[1]);
                if !refs[2].is_empty() {
                    builder = builder.resolve_attachments(&refs[2]);
                }
                if let Some(depth_stencil) = refs[3].first() {
                    builder = builder.depth_stencil_attachment(depth_stencil);
                }
                builder.build()
            })
            .collect();
        let dependencies2 = [vk::SubpassDependency2::builder()
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
            .attachments(&attachment_descriptions2)
            .subpasses(&subpass_descriptions2)
            .dependencies(if has_input_attachment {
                &dependencies2[..]
            } else {
                &dependencies2[..0]
            });
        let render_pass = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        Ok(Unique::new(device, render_pass))
    }

    /// The colour attachment locations and input attachment indices a subpass with input attachments remaps to, in the
    /// order of its references.
    fn remap_locations(&self, subpass: &SubpassParams, count: usize) -> (Vec<u32>, Vec<u32>) {
        let mut locations = vec![ATTACHMENT_UNUSED; count];
        let mut inputs = vec![ATTACHMENT_UNUSED; count];
        let mut location_index = 0u32;
        let mut input_index = 0u32;
        for (i, r) in subpass.attachment_refs.iter().enumerate() {
            if r.usage == USAGE_COLOR {
                locations[i] = location_index;
                location_index += 1;
            } else if r.usage == USAGE_INPUT {
                inputs[i] = input_index;
                input_index += 1;
            }
        }
        (locations, inputs)
    }

    /// The pipeline part of the per-subpass loop of `iterate`.
    fn create_pipeline(
        &self,
        spec: &PipelineSpec<'_>,
        pipelines_so_far: usize,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let is_dynamic = self.is_dynamic_rendering();

        let vertex_input_binding = vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
            input_rate: vk::VertexInputRate::VERTEX,
        };
        let vertex_input_attributes = [
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        let bindings = [vertex_input_binding];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&vertex_input_attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);

        let write_mask = if spec.no_color_write {
            vk::ColorComponentFlags::empty()
        } else {
            vk::ColorComponentFlags::all()
        };

        let mut depth_attachment_format = vk::Format::UNDEFINED;
        let mut stencil_attachment_format = vk::Format::UNDEFINED;
        let mut color_vector: Vec<vk::Format> = Vec::new();
        for att in &p.attachments {
            let format = get_format(att.usage, p.depth_stencil_format);
            if att.usage & USAGE_DEPTH_STENCIL != 0 {
                let tcu_format = map_vk_format(format);
                let has_depth = tcu_format.is_some_and(|f| has_depth_component(f.order));
                let has_stencil = tcu_format.is_some_and(|f| has_stencil_component(f.order));
                let use_depth = att.usage & USAGE_DEPTH != 0;
                let use_stencil = att.usage & USAGE_STENCIL != 0;
                depth_attachment_format = if has_depth && use_depth {
                    format
                } else {
                    vk::Format::UNDEFINED
                };
                stencil_attachment_format = if has_stencil && use_stencil {
                    format
                } else {
                    vk::Format::UNDEFINED
                };
            } else if att.usage & USAGE_RESOLVE_TARGET == 0 {
                color_vector.push(format);
            }
        }

        let render_pass_is_null = spec.render_pass == vk::RenderPass::null();
        let attachment_count = if render_pass_is_null { color_vector.len() } else { 1 };
        let mut color_blend_attachment_states = vec![
            vk::PipelineColorBlendAttachmentState::builder()
                .blend_enable(false)
                .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
                .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
                .color_blend_op(vk::BlendOp::ADD)
                .src_alpha_blend_factor(vk::BlendFactor::ONE)
                .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
                .alpha_blend_op(vk::BlendOp::ADD)
                .color_write_mask(write_mask)
                .build();
            attachment_count
        ];
        if p.alpha_blend {
            let attachment_index = if render_pass_is_null { pipelines_so_far } else { 0 };
            color_blend_attachment_states[attachment_index].blend_enable = vk::TRUE;
        }
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&color_blend_attachment_states);

        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(if spec.stencil_write {
                vk::StencilOp::REPLACE
            } else {
                vk::StencilOp::KEEP
            })
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(spec.stencil_compare_op)
            .compare_mask(0xff)
            .write_mask(0xff)
            .reference(0xff)
            .build();
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(spec.depth_test)
            .depth_write_enable(spec.depth_write)
            .depth_compare_op(spec.depth_compare_op)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(spec.stencil_test)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(if spec.multisample {
                vk::SampleCountFlags::_4
            } else {
                vk::SampleCountFlags::_1
            })
            .sample_shading_enable(false)
            .min_sample_shading(1.0)
            .alpha_to_coverage_enable(false)
            .alpha_to_one_enable(false);

        let viewports = [viewport(0.0, 0.0, IMAGE_SIZE as f32, IMAGE_SIZE as f32, 0.0, 1.0)];
        let scissors = [rect_2d(RENDER_WIDTH, RENDER_HEIGHT)];
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

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(spec.vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(spec.fragment_module)
                .name(b"main\0")
                .build(),
        ];

        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_vector)
            .depth_attachment_format(depth_attachment_format)
            .stencil_attachment_format(stencil_attachment_format);
        let (color_attachment_locations, color_attachment_inputs) =
            self.remap_locations(spec.subpass, color_vector.len());
        let mut rendering_attachment_location_info =
            vk::RenderingAttachmentLocationInfo::builder().color_attachment_locations(&color_attachment_locations);
        let mut rendering_input_attachment_index_info =
            vk::RenderingInputAttachmentIndexInfo::builder().color_attachment_input_indices(&color_attachment_inputs);

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(spec.layout)
            .render_pass(spec.render_pass)
            .subpass(spec.subpass_idx as u32)
            .base_pipeline_index(0);
        if is_dynamic {
            info = info.push_next(&mut rendering_create_info);
            if spec.num_input_attachments > 0 {
                info = info
                    .push_next(&mut rendering_attachment_location_info)
                    .push_next(&mut rendering_input_attachment_index_info);
            }
        }

        crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
    }

    /// `drawCommands`
    fn draw_commands(
        &self,
        cmd: vk::CommandBuffer,
        vertex_buffer: vk::Buffer,
        descriptor_sets: &[UniqueDescriptorSet<'_>],
        pipeline_layouts: &[Unique<'_, vk::PipelineLayout>],
        pipelines: &[Unique<'_, vk::Pipeline>],
    ) {
        use vulkanalia::vk::KhrDynamicRenderingLocalReadExtensionDeviceCommands;

        let p = self.params;
        let device = self.context.get_device();
        let rect = vk::ClearRect {
            rect: rect_2d(RENDER_WIDTH, RENDER_HEIGHT),
            base_array_layer: 0,
            layer_count: 1,
        };

        // Add clear commands for selected attachments
        let mut clear_attachments: Vec<vk::ClearAttachment> = Vec::new();
        let mut color_att_idx = 0u32;
        for att in &p.attachments {
            if att.init & ATTACHMENT_INIT_CMD_CLEAR != 0 {
                if att.usage & USAGE_DEPTH_STENCIL != 0 {
                    let mut aspect_mask = vk::ImageAspectFlags::empty();
                    if att.usage & USAGE_DEPTH != 0 {
                        aspect_mask |= vk::ImageAspectFlags::DEPTH;
                    }
                    if att.usage & USAGE_STENCIL != 0 {
                        aspect_mask |= vk::ImageAspectFlags::STENCIL;
                    }
                    clear_attachments.push(vk::ClearAttachment {
                        aspect_mask,
                        color_attachment: 0,
                        clear_value: vk::ClearValue {
                            depth_stencil: vk::ClearDepthStencilValue {
                                depth: 0.25,
                                stencil: 64,
                            },
                        },
                    });
                } else {
                    clear_attachments.push(vk::ClearAttachment {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        color_attachment: color_att_idx,
                        clear_value: clear_value_color([0.0, 0.0, 0.5, 1.0]),
                    });
                    color_att_idx += 1;
                }
            }
        }
        if !clear_attachments.is_empty() {
            unsafe { device.cmd_clear_attachments(cmd, &clear_attachments, &[rect]) };
        }

        unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]) };

        let mut descriptor_set_idx = 0;
        let mut vertex_offset = 0u32;
        for (i, subpass) in p.subpasses.iter().enumerate() {
            if i != 0 {
                if self.is_dynamic_rendering() {
                    // barrier before next subpass
                    let memory_barrier = make_memory_barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    );
                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd,
                            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                            vk::PipelineStageFlags::FRAGMENT_SHADER,
                            vk::DependencyFlags::BY_REGION,
                            &[memory_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                    }

                    // remap color attachment locations and input attachment indices
                    let (color_attachment_locations, color_attachment_inputs) =
                        self.remap_locations(&p.subpasses[1], p.attachments.len());
                    let rendering_attachment_location_info = vk::RenderingAttachmentLocationInfo::builder()
                        .color_attachment_locations(&color_attachment_locations);
                    let rendering_input_attachment_index_info = vk::RenderingInputAttachmentIndexInfo::builder()
                        .color_attachment_input_indices(&color_attachment_inputs);
                    unsafe {
                        device.cmd_set_rendering_attachment_locations_khr(cmd, &rendering_attachment_location_info);
                        device.cmd_set_rendering_input_attachment_indices_khr(
                            cmd,
                            &rendering_input_attachment_index_info,
                        );
                    }
                } else {
                    unsafe { device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE) };
                }
            }

            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipelines[i].get()) };

            let has_input = subpass.attachment_refs.iter().any(|r| r.usage & USAGE_INPUT != 0);
            if has_input {
                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layouts[i],
                        0,
                        &[descriptor_sets[descriptor_set_idx].get()],
                        &[] as &[u32],
                    )
                };
                descriptor_set_idx += 1;
            }

            for _ in 0..subpass.num_draws {
                unsafe { device.cmd_draw(cmd, 6, 1, vertex_offset, 0) };
                vertex_offset += 6;
            }
        }
    }

    /// `createCommandBuffer<RenderpassSubpass>`: records into `cmd` between a render pass begin and end.
    #[allow(clippy::too_many_arguments)]
    fn record_render_pass(
        &self,
        cmd: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
        vertex_buffer: vk::Buffer,
        descriptor_sets: &[UniqueDescriptorSet<'_>],
        pipeline_layouts: &[Unique<'_, vk::PipelineLayout>],
        pipelines: &[Unique<'_, vk::Pipeline>],
    ) -> Result<(), TestError> {
        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

        let device = self.context.get_device();
        begin_command_buffer(device, cmd)?;
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(rect_2d(RENDER_WIDTH, RENDER_HEIGHT));
        let renderpass2 = self.params.group_params.rendering_type == RenderingType::RenderPass2;
        if renderpass2 {
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(cmd, &begin_info, &subpass_begin_info) };
        } else {
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
        }

        self.draw_commands(cmd, vertex_buffer, descriptor_sets, pipeline_layouts, pipelines);

        if renderpass2 {
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(cmd, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(cmd) };
        }
        end_command_buffer(device, cmd)
    }

    /// `createCommandBuffer` for dynamic rendering. Returns the secondary command buffer, which has to outlive the submission.
    #[allow(clippy::too_many_arguments)]
    fn record_dynamic_rendering(
        &self,
        command_pool: vk::CommandPool,
        cmd: vk::CommandBuffer,
        attachments: &[AttachmentImage<'_>],
        vertex_buffer: vk::Buffer,
        descriptor_sets: &[UniqueDescriptorSet<'_>],
        pipeline_layouts: &[Unique<'_, vk::PipelineLayout>],
        pipelines: &[Unique<'_, vk::Pipeline>],
    ) -> Result<Option<crate::vk::ref_util::UniqueCommandBuffer<'a>>, TestError> {
        use vulkanalia::vk::DeviceV1_3;

        let p = self.params;
        let device = self.context.get_device();

        let mut color_attachments: Vec<vk::RenderingAttachmentInfo> = Vec::new();
        let ds_attachment_info = || {
            vk::RenderingAttachmentInfo::builder()
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
                })
                .build()
        };
        let mut depth_attachment = ds_attachment_info();
        let mut stencil_attachment = ds_attachment_info();

        let mut use_depth = false;
        let mut use_stencil = false;
        let mut sample_count = vk::SampleCountFlags::_1;
        let mut color_attachment_formats: Vec<vk::Format> = Vec::new();

        let mut i = 0;
        while i < attachments.len() {
            let att = &p.attachments[i];
            if att.usage & USAGE_MULTISAMPLE != 0 {
                let resolve_mode = if att.usage & USAGE_INTEGER != 0 {
                    vk::ResolveModeFlags::SAMPLE_ZERO
                } else {
                    vk::ResolveModeFlags::AVERAGE
                };
                color_attachments.push(
                    vk::RenderingAttachmentInfo::builder()
                        .image_view(*attachments[i].view)
                        .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .resolve_mode(resolve_mode)
                        .resolve_image_view(*attachments[i + 1].view)
                        .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .load_op(att.load_op)
                        .store_op(att.store_op)
                        .clear_value(clear_value_color([0.0, 0.0, 0.0, 0.0]))
                        .build(),
                );
                color_attachment_formats.push(get_format(att.usage, p.depth_stencil_format));
                sample_count = vk::SampleCountFlags::_4;
                i += 1;
            } else if att.usage & (USAGE_COLOR | USAGE_INPUT) != 0 {
                let image_layout = if att.usage & USAGE_INPUT != 0 {
                    vk::ImageLayout::RENDERING_LOCAL_READ
                } else {
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
                };
                color_attachments.push(
                    vk::RenderingAttachmentInfo::builder()
                        .image_view(*attachments[i].view)
                        .image_layout(image_layout)
                        .resolve_mode(vk::ResolveModeFlags::NONE)
                        .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                        .load_op(att.load_op)
                        .store_op(att.store_op)
                        .clear_value(clear_value_color([0.0, 0.0, 0.0, 0.0]))
                        .build(),
                );
                color_attachment_formats.push(get_format(att.usage, p.depth_stencil_format));
            } else {
                use_depth = att.usage & USAGE_DEPTH != 0;
                use_stencil = att.usage & USAGE_STENCIL != 0;

                depth_attachment.image_view = *attachments[i].view;
                depth_attachment.load_op = att.load_op;
                depth_attachment.store_op = att.store_op;
                stencil_attachment.image_view = *attachments[i].view;
                stencil_attachment.load_op = att.stencil_load_op;
                stencil_attachment.store_op = att.stencil_store_op;
            }
            i += 1;
        }

        let make_rendering_info = |flags: vk::RenderingFlags| {
            let mut info = vk::RenderingInfo::builder()
                .flags(flags)
                .render_area(rect_2d(RENDER_WIDTH, RENDER_HEIGHT))
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments);
            if use_depth {
                info = info.depth_attachment(&depth_attachment);
            }
            if use_stencil {
                info = info.stencil_attachment(&stencil_attachment);
            }
            info
        };

        let group = p.group_params;
        if group.use_secondary_cmd_buffer {
            let sec_cmd = allocate_command_buffer(device, command_pool, vk::CommandBufferLevel::SECONDARY)?;

            // record secondary command buffer
            let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                .flags(if group.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                } else {
                    vk::RenderingFlags::empty()
                })
                .view_mask(0)
                .color_attachment_formats(&color_attachment_formats)
                .depth_attachment_format(if use_depth {
                    p.depth_stencil_format
                } else {
                    vk::Format::UNDEFINED
                })
                .stencil_attachment_format(if use_stencil {
                    p.depth_stencil_format
                } else {
                    vk::Format::UNDEFINED
                })
                .rasterization_samples(sample_count);
            let buffer_inheritance_info =
                vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
            let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
            if !group.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
                usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
            }
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(usage_flags)
                .inheritance_info(&buffer_inheritance_info);
            unsafe { device.begin_command_buffer(*sec_cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
            if group.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
                unsafe { device.cmd_begin_rendering(*sec_cmd, &make_rendering_info(vk::RenderingFlags::empty())) };
            }

            self.draw_commands(*sec_cmd, vertex_buffer, descriptor_sets, pipeline_layouts, pipelines);

            if group.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
                unsafe { device.cmd_end_rendering(*sec_cmd) };
            }
            end_command_buffer(device, *sec_cmd)?;

            // record primary command buffer
            begin_command_buffer(device, cmd)?;
            if !group.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
                unsafe {
                    device.cmd_begin_rendering(
                        cmd,
                        &make_rendering_info(vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS),
                    )
                };
            }
            unsafe { device.cmd_execute_commands(cmd, &[*sec_cmd]) };
            if !group.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
                unsafe { device.cmd_end_rendering(cmd) };
            }
            end_command_buffer(device, cmd)?;
            Ok(Some(sec_cmd))
        } else {
            begin_command_buffer(device, cmd)?;
            unsafe { device.cmd_begin_rendering(cmd, &make_rendering_info(vk::RenderingFlags::empty())) };

            self.draw_commands(cmd, vertex_buffer, descriptor_sets, pipeline_layouts, pipelines);

            unsafe { device.cmd_end_rendering(cmd) };
            end_command_buffer(device, cmd)?;
            Ok(None)
        }
    }
}

impl TestInstance for LoadStoreOpNoneInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let p = self.params;
        let is_dynamic_rendering = self.is_dynamic_rendering();
        let mut depth_is_undefined = false;
        let mut stencil_is_undefined = false;

        let mut attachments: Vec<AttachmentImage<'_>> = Vec::new();
        for att in &p.attachments {
            let format = get_format(att.usage, p.depth_stencil_format);
            let mut usage = vk::ImageUsageFlags::empty();

            if !att.verify_aspects.is_empty() {
                usage |= vk::ImageUsageFlags::TRANSFER_SRC;
            }
            if att.init & ATTACHMENT_INIT_PRE != 0 {
                usage |= vk::ImageUsageFlags::TRANSFER_DST;
            }

            let aspect_flags;
            if att.usage & USAGE_DEPTH_STENCIL != 0 {
                aspect_flags = image_aspect_flags(format);
                usage |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;

                // If depth or stencil load op is NONE, "the previous contents of the image will be undefined inside the render
                // pass. No access type is used as the image is not accessed."
                if att.load_op == vk::AttachmentLoadOp::NONE {
                    depth_is_undefined = true;
                }
                if att.stencil_load_op == vk::AttachmentLoadOp::NONE {
                    stencil_is_undefined = true;
                }
            } else {
                // Color and input attachments.
                aspect_flags = vk::ImageAspectFlags::COLOR;
                if att.usage & USAGE_COLOR != 0 {
                    usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
                }
                if att.usage & USAGE_INPUT != 0 {
                    usage |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
                }
            }

            let sample_count = if att.usage & USAGE_MULTISAMPLE != 0 {
                vk::SampleCountFlags::_4
            } else {
                vk::SampleCountFlags::_1
            };
            let image_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: IMAGE_SIZE,
                    height: IMAGE_SIZE,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(sample_count)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                format,
                make_image_subresource_range(aspect_flags, 0, 1, 0, 1),
            )?;

            if att.init & ATTACHMENT_INIT_PRE != 0 {
                // Preinitialize image
                let attachment_idx = attachments.len() as u32;
                let mut first_usage = get_first_usage(attachment_idx, &p.subpasses);
                if first_usage == USAGE_UNDEFINED {
                    first_usage = att.usage;
                }

                if first_usage & USAGE_DEPTH_STENCIL != 0 {
                    let dst_access = vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
                    let dst_stage =
                        vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
                    self.clear_depth_stencil_image(
                        image.get(),
                        format,
                        0.5,
                        128,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        dst_access,
                        dst_stage,
                    )?;
                } else {
                    let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_READ
                        | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                        | vk::AccessFlags::SHADER_READ
                        | vk::AccessFlags::SHADER_WRITE;
                    let dst_stage =
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::FRAGMENT_SHADER;
                    let clear_color = if att.usage & USAGE_INTEGER != 0 {
                        vk::ClearColorValue {
                            uint32: [0, 255, 0, 255],
                        }
                    } else {
                        vk::ClearColorValue {
                            float32: [0.0, 1.0, 0.0, 1.0],
                        }
                    };
                    let mut layout = if first_usage & USAGE_COLOR != 0 {
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
                    } else {
                        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
                    };

                    if is_dynamic_rendering && p.attachments[attachment_idx as usize].usage & USAGE_INPUT != 0 {
                        layout = vk::ImageLayout::RENDERING_LOCAL_READ;
                    }

                    self.clear_color_image(
                        image.get(),
                        clear_color,
                        vk::ImageLayout::UNDEFINED,
                        layout,
                        dst_access,
                        dst_stage,
                    )?;
                }
            }

            attachments.push(AttachmentImage { image, view });
        }

        let mut render_pass: Option<Unique<'_, vk::RenderPass>> = None;
        let mut framebuffer: Option<Unique<'_, vk::Framebuffer>> = None;
        if !is_dynamic_rendering {
            // Create render pass.
            let created = self.create_render_pass()?;

            // Create framebuffer.
            let views: Vec<vk::ImageView> = attachments.iter().map(|a| *a.view).collect();
            framebuffer = Some(crate::vk::obj_util::make_framebuffer(
                device, *created, &views, IMAGE_SIZE, IMAGE_SIZE, 1,
            )?);
            render_pass = Some(created);
        }
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |rp| **rp);

        // Create shader modules
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("color_frag")?)?;
        let fragment_shader_module_uint = create_shader_module(device, binaries.get("color_frag_uint")?)?;
        let fragment_shader_module_blend = create_shader_module(device, binaries.get("color_frag_blend")?)?;
        let fragment_shader_module_input = create_shader_module(device, binaries.get("color_frag_input")?)?;

        // Create descriptor pool. Prepare for using one input attachment at most.
        let descriptor_pool = crate::vk::builder_util::DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let mut descriptor_set_layouts: Vec<Unique<'_, vk::DescriptorSetLayout>> = Vec::new();
        let mut descriptor_sets: Vec<UniqueDescriptorSet<'_>> = Vec::new();
        let mut pipeline_layouts: Vec<Unique<'_, vk::PipelineLayout>> = Vec::new();
        let mut pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();

        for (subpass_idx, subpass) in p.subpasses.iter().enumerate() {
            let mut num_input_attachments = 0u32;
            let mut no_color_write = false;
            let mut depth_test = false;
            let mut stencil_test = false;
            let mut depth_write = true;
            let mut stencil_write = true;
            let mut multisample = false;
            let mut uint_color_buffer = false;
            let mut depth_compare_op = vk::CompareOp::GREATER;
            let mut stencil_compare_op = vk::CompareOp::GREATER;

            // Create pipeline layout.
            {
                let mut layout_builder = crate::vk::builder_util::DescriptorSetLayoutBuilder::new();

                for r in &subpass.attachment_refs {
                    if r.usage & USAGE_INPUT != 0 {
                        layout_builder = layout_builder
                            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
                        num_input_attachments += 1;
                    }
                    if r.usage & USAGE_COLOR != 0 && r.usage & USAGE_COLOR_WRITE_OFF != 0 {
                        no_color_write = true;
                    }
                    if r.usage & USAGE_DEPTH != 0 {
                        if r.usage & USAGE_DEPTH_TEST_OFF == 0 {
                            depth_test = true;
                        }
                        if r.usage & USAGE_DEPTH_WRITE_OFF != 0 {
                            depth_write = false;
                        }

                        // Enabling depth testing with undefined depth buffer contents. Let's make sure all samples pass the depth test.
                        if depth_is_undefined && depth_test {
                            depth_compare_op = vk::CompareOp::ALWAYS;
                        }
                    }
                    if r.usage & USAGE_STENCIL != 0 {
                        if r.usage & USAGE_STENCIL_TEST_OFF == 0 {
                            stencil_test = true;
                        }
                        if r.usage & USAGE_STENCIL_WRITE_OFF != 0 {
                            stencil_write = false;
                        }

                        if stencil_is_undefined && stencil_test {
                            stencil_compare_op = vk::CompareOp::ALWAYS;
                        }
                    }
                    if r.usage & USAGE_MULTISAMPLE != 0 {
                        multisample = true;
                    }
                    if r.usage & USAGE_INTEGER != 0 {
                        uint_color_buffer = true;
                    }
                }

                let set_layout = layout_builder.build(device)?;
                pipeline_layouts.push(make_pipeline_layout(device, &[*set_layout])?);
                descriptor_set_layouts.push(set_layout);
            }

            // Update descriptor set if needed.
            if num_input_attachments > 0 {
                let input_image_layout = if is_dynamic_rendering {
                    vk::ImageLayout::RENDERING_LOCAL_READ
                } else {
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
                };

                // Assuming there's only one input attachment at most.
                debug_assert_eq!(num_input_attachments, 1);

                let set = crate::vk::obj_util::make_descriptor_set(
                    device,
                    *descriptor_pool,
                    **descriptor_set_layouts.last().unwrap(),
                )?;
                for (i, att) in p.attachments.iter().enumerate() {
                    if att.usage & USAGE_INPUT != 0 {
                        let input_image_info = [vk::DescriptorImageInfo::builder()
                            .sampler(vk::Sampler::null())
                            .image_view(*attachments[i].view)
                            .image_layout(input_image_layout)
                            .build()];
                        let descriptor_write = vk::WriteDescriptorSet::builder()
                            .dst_set(set.get())
                            .dst_binding(0)
                            .dst_array_element(0)
                            .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                            .image_info(&input_image_info);
                        unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };
                    }
                }
                descriptor_sets.push(set);
            }

            // Create pipeline.
            let fragment_module = if num_input_attachments > 0 {
                *fragment_shader_module_input
            } else if uint_color_buffer {
                *fragment_shader_module_uint
            } else if p.alpha_blend {
                *fragment_shader_module_blend
            } else {
                *fragment_shader_module
            };
            let spec = PipelineSpec {
                layout: *pipeline_layouts[subpass_idx],
                render_pass: render_pass_handle,
                subpass_idx,
                vertex_module: *vertex_shader_module,
                fragment_module,
                num_input_attachments,
                no_color_write,
                depth_test,
                stencil_test,
                depth_write,
                stencil_write,
                multisample,
                depth_compare_op,
                stencil_compare_op,
                subpass,
            };
            let pipeline = self.create_pipeline(&spec, pipelines.len())?;
            pipelines.push(pipeline);
        }

        // Create vertex buffer.
        let vertices = create_quad();
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create command pool.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        // Create command buffer.
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let _secondary_cmd_buffer = if is_dynamic_rendering {
            self.record_dynamic_rendering(
                *cmd_pool,
                *cmd_buffer,
                &attachments,
                vertex_buffer.get(),
                &descriptor_sets,
                &pipeline_layouts,
                &pipelines,
            )?
        } else {
            self.record_render_pass(
                *cmd_buffer,
                render_pass_handle,
                framebuffer.as_ref().map_or_else(vk::Framebuffer::null, |fb| **fb),
                vertex_buffer.get(),
                &descriptor_sets,
                &pipeline_layouts,
                &pipelines,
            )?;
            None
        };

        // Submit commands.
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        let mut pass = true;

        // Verify selected attachments.
        for (i, att) in p.attachments.iter().enumerate() {
            let mut transitioned = false;
            for verify in &att.verify_aspects {
                let format = get_format(att.usage, p.depth_stencil_format);
                let image = attachments[i].image.get();

                let access = if verify.aspect == vk::ImageAspectFlags::DEPTH {
                    let layout = if is_dynamic_rendering && !transitioned {
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
                    } else {
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
                    };
                    transitioned = true;
                    self.read_depth_attachment(image, layout)?
                } else if verify.aspect == vk::ImageAspectFlags::STENCIL {
                    let layout = if is_dynamic_rendering && !transitioned {
                        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
                    } else {
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
                    };
                    transitioned = true;
                    self.read_stencil_attachment(image, layout)?
                } else {
                    let mut layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
                    if is_dynamic_rendering && !transitioned {
                        layout = if att.usage & USAGE_INPUT != 0 {
                            vk::ImageLayout::RENDERING_LOCAL_READ
                        } else {
                            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
                        };
                    }
                    transitioned = true;
                    self.read_color_attachment(image, format, layout)?
                };

                for y in 0..IMAGE_SIZE {
                    for x in 0..IMAGE_SIZE {
                        let inner = x < RENDER_WIDTH && y < RENDER_HEIGHT;

                        if inner && !verify.verify_inner {
                            continue;
                        }
                        if !inner && !verify.verify_outer {
                            continue;
                        }

                        let reference = if inner { verify.inner_ref } else { verify.outer_ref };
                        let pixel = access[(y * IMAGE_SIZE + x) as usize];

                        for c in 0..4 {
                            if (pixel[c] - reference[c]).abs() > 0.01 {
                                pass = false;
                            }
                        }
                    }
                }
            }
        }

        if pass {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// `createQuad`: two quads covering the whole target, the first one red and the second one blue, as position and colour.
fn create_quad() -> Vec<[f32; 8]> {
    let size = 1.0f32;
    let red = [1.0f32, 0.0, 0.0, 1.0];
    let blue = [0.0f32, 0.0, 1.0, 1.0];
    let vertex = |x: f32, y: f32, color: [f32; 4]| [x, y, 0.0, 1.0, color[0], color[1], color[2], color[3]];

    let mut vertices = Vec::new();
    for color in [red, blue] {
        let lower_left = vertex(-size, -size, color);
        let lower_right = vertex(size, -size, color);
        let upper_left = vertex(-size, size, color);
        let upper_right = vertex(size, size, color);
        vertices.extend_from_slice(&[
            lower_left,
            lower_right,
            upper_left,
            upper_left,
            lower_right,
            upper_right,
        ]);
    }
    vertices
}

/// `createRenderPassLoadStoreOpNoneTests`
pub fn create_render_pass_load_store_op_none_tests(group_params: GroupParams) -> TestCaseGroup {
    use vk::{AttachmentLoadOp as Load, AttachmentStoreOp as Store};

    let mut op_none_tests = TestCaseGroup::new("load_store_op_none");
    let mut add = |name: &str, params: TestParams| {
        op_none_tests.add_child(Box::new(LoadStoreOpNoneTest {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>);
    };
    let color = vk::ImageAspectFlags::COLOR;
    let depth = vk::ImageAspectFlags::DEPTH;
    let stencil = vk::ImageAspectFlags::STENCIL;

    // Preinitialize attachments 0 and 1 to green.
    // Subpass 0: draw a red rectangle inside attachment 0.
    // Subpass 1: use the attachment 0 as input and add blue channel to it resulting in magenta. Write the results to attachment 1.
    // After the render pass attachment 0 has undefined values inside the render area because of the shader writes with store op
    // 'none', but outside should still have the preinitialized value of green. Attachment 1 should have the preinitialized green
    // outside the render area and magenta inside.
    if !group_params.use_secondary_cmd_buffer {
        add(
            "color_load_op_load_store_op_none",
            TestParams {
                attachments: vec![
                    attachment(
                        USAGE_COLOR | USAGE_INPUT,
                        Load::LOAD,
                        Store::NONE,
                        Load::DONT_CARE,
                        Store::DONT_CARE,
                        ATTACHMENT_INIT_PRE,
                        vec![verify(color, false, GREEN, true, GREEN)],
                    ),
                    attachment(
                        USAGE_COLOR,
                        Load::DONT_CARE,
                        Store::STORE,
                        Load::DONT_CARE,
                        Store::DONT_CARE,
                        ATTACHMENT_INIT_PRE,
                        vec![verify(color, true, MAGENTA, true, GREEN)],
                    ),
                ],
                subpasses: vec![
                    subpass(&[(0, USAGE_COLOR)], 1),
                    subpass(&[(0, USAGE_INPUT), (1, USAGE_COLOR)], 1),
                ],
                group_params,
                depth_stencil_format: vk::Format::UNDEFINED,
                alpha_blend: false,
                ext_preference: ExtensionPreference::Khr,
            },
        );
    }

    // Preinitialize color attachment to green. Use a render pass with load and store ops none, but disable color writes using an
    // empty color mask. The color attachment image should have the original preinitialized value after the render pass.
    add(
        "color_load_op_none_store_op_none_write_off",
        TestParams {
            attachments: vec![attachment(
                USAGE_COLOR,
                Load::NONE,
                Store::NONE,
                Load::DONT_CARE,
                Store::DONT_CARE,
                ATTACHMENT_INIT_PRE,
                vec![verify(color, true, GREEN, true, GREEN)],
            )],
            subpasses: vec![subpass(&[(0, USAGE_COLOR | USAGE_COLOR_WRITE_OFF)], 1)],
            group_params,
            depth_stencil_format: vk::Format::UNDEFINED,
            alpha_blend: false,
            ext_preference: ExtensionPreference::Ext,
        },
    );

    // Preinitialize color attachment to green. Use a render pass with load and store ops none, and write a rectangle to the color
    // buffer. The render area is undefined, but the outside area should still have the preinitialized color.
    add(
        "color_load_op_none_store_op_none",
        TestParams {
            attachments: vec![attachment(
                USAGE_COLOR,
                Load::NONE,
                Store::NONE,
                Load::DONT_CARE,
                Store::DONT_CARE,
                ATTACHMENT_INIT_PRE,
                vec![verify(color, false, GREEN, true, GREEN)],
            )],
            subpasses: vec![subpass(&[(0, USAGE_COLOR)], 1)],
            group_params,
            depth_stencil_format: vk::Format::UNDEFINED,
            alpha_blend: false,
            ext_preference: ExtensionPreference::Khr,
        },
    );

    // Preinitialize color attachment to green. Use a subpass with no draw calls but instead do an attachment clear command using
    // dark blue color. Using load op none preserves the preinitialized data and store op store causes the cleared blue render area
    // to be present after the render pass.
    add(
        "color_load_op_none_store_op_store",
        TestParams {
            attachments: vec![attachment(
                USAGE_COLOR,
                Load::NONE,
                Store::STORE,
                Load::DONT_CARE,
                Store::DONT_CARE,
                ATTACHMENT_INIT_PRE | ATTACHMENT_INIT_CMD_CLEAR,
                vec![verify(color, true, DARK_BLUE, true, GREEN)],
            )],
            subpasses: vec![subpass(&[(0, USAGE_COLOR)], 0)],
            group_params,
            depth_stencil_format: vk::Format::UNDEFINED,
            alpha_blend: false,
            ext_preference: ExtensionPreference::Ext,
        },
    );

    // Preinitialize color attachment to green. Use a subpass with a dark blue attachment clear followed by an alpha blender draw.
    // Load op none preserves the preinitialized data and store op store keeps the blended color inside the render area after the
    // render pass.
    add(
        "color_load_op_none_store_op_store_alphablend",
        TestParams {
            attachments: vec![attachment(
                USAGE_COLOR,
                Load::NONE,
                Store::STORE,
                Load::DONT_CARE,
                Store::DONT_CARE,
                ATTACHMENT_INIT_PRE | ATTACHMENT_INIT_CMD_CLEAR,
                vec![verify(color, true, BLEND, true, GREEN)],
            )],
            subpasses: vec![subpass(&[(0, USAGE_COLOR)], 1)],
            group_params,
            depth_stencil_format: vk::Format::UNDEFINED,
            alpha_blend: true,
            ext_preference: ExtensionPreference::Khr,
        },
    );

    // Preinitialize attachments 0 and 1 to green. Attachment 0 contents inside render area is undefined because load op 'none'.
    // Subpass 0: draw a red rectangle inside attachment 0 overwriting all undefined values.
    // Subpass 1: use the attachment 0 as input and add blue to it resulting in magenta. Write the results to attachment 1.
    // After the render pass attachment 0 contents inside the render area are undefined because of store op 'don't care', but the
    // outside area should still have the preinitialized content. Attachment 1 should have the preinitialized green outside render
    // area and magenta inside.
    if !group_params.use_secondary_cmd_buffer {
        add(
            "color_load_op_none_store_op_dontcare",
            TestParams {
                attachments: vec![
                    attachment(
                        USAGE_COLOR | USAGE_INPUT,
                        Load::NONE,
                        Store::DONT_CARE,
                        Load::DONT_CARE,
                        Store::DONT_CARE,
                        ATTACHMENT_INIT_PRE,
                        vec![verify(color, false, GREEN, true, GREEN)],
                    ),
                    attachment(
                        USAGE_COLOR,
                        Load::LOAD,
                        Store::STORE,
                        Load::DONT_CARE,
                        Store::DONT_CARE,
                        ATTACHMENT_INIT_PRE,
                        vec![verify(color, true, MAGENTA, true, GREEN)],
                    ),
                ],
                subpasses: vec![
                    subpass(&[(0, USAGE_COLOR)], 1),
                    subpass(&[(0, USAGE_INPUT), (1, USAGE_COLOR)], 1),
                ],
                group_params,
                depth_stencil_format: vk::Format::UNDEFINED,
                alpha_blend: false,
                ext_preference: ExtensionPreference::Ext,
            },
        );
    }

    // Preinitialize color attachment to green. Use a render pass with load and store ops none for a multisample color target. Write a
    // red rectangle and check it ends up in the resolved buffer even though the multisample attachment doesn't store the results.
    add(
        "color_load_op_none_store_op_none_resolve",
        TestParams {
            attachments: vec![
                attachment(
                    USAGE_COLOR | USAGE_MULTISAMPLE | USAGE_INTEGER,
                    Load::NONE,
                    Store::NONE,
                    Load::DONT_CARE,
                    Store::DONT_CARE,
                    ATTACHMENT_INIT_PRE,
                    vec![],
                ),
                attachment(
                    USAGE_COLOR | USAGE_RESOLVE_TARGET | USAGE_INTEGER,
                    Load::LOAD,
                    Store::STORE,
                    Load::DONT_CARE,
                    Store::DONT_CARE,
                    ATTACHMENT_INIT_PRE,
                    vec![verify(color, true, RED_UINT, true, GREEN_UINT)],
                ),
            ],
            subpasses: vec![subpass(
                &[
                    (0, USAGE_COLOR | USAGE_MULTISAMPLE | USAGE_INTEGER),
                    (1, USAGE_COLOR | USAGE_RESOLVE_TARGET),
                ],
                1,
            )],
            group_params,
            depth_stencil_format: vk::Format::UNDEFINED,
            alpha_blend: false,
            ext_preference: ExtensionPreference::Khr,
        },
    );

    let formats = [
        vk::Format::D16_UNORM,
        vk::Format::D32_SFLOAT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
        vk::Format::S8_UINT,
    ];

    for (f, &format) in formats.iter().enumerate() {
        let tcu_format = map_vk_format(format);
        let has_depth = tcu_format.is_some_and(|t| has_depth_component(t.order));
        let has_stencil = tcu_format.is_some_and(|t| has_stencil_component(t.order));
        let format_name = format_case_name(format);
        let ext_a = if f % 2 == 0 {
            ExtensionPreference::Ext
        } else {
            ExtensionPreference::Khr
        };
        let ext_b = if f % 2 == 0 {
            ExtensionPreference::Khr
        } else {
            ExtensionPreference::Ext
        };

        let color_attachment = || {
            attachment(
                USAGE_COLOR,
                Load::LOAD,
                Store::STORE,
                Load::DONT_CARE,
                Store::DONT_CARE,
                ATTACHMENT_INIT_PRE,
                vec![verify(color, true, RED, true, GREEN)],
            )
        };
        let ds_params = |attachments: Vec<AttachmentParams>,
                         subpasses: Vec<SubpassParams>,
                         ext_preference: ExtensionPreference| TestParams {
            attachments,
            subpasses,
            group_params,
            depth_stencil_format: format,
            alpha_blend: false,
            ext_preference,
        };

        // Preinitialize attachment 0 (color) to green and attachment 1 (depth) to 0.5. Draw a red rectangle using depth 1.0 and depth
        // op 'greater'. Depth test will pass and update depth buffer to 1.0. This is followed by another draw with a blue rectangle
        // using the same depth of 1.0. This time the depth test fails and nothing is written. After the renderpass the red color
        // should remain inside the render area of the color buffer. Store op 'none' for depth buffer makes the written values
        // undefined, but the pixels outside render area should still contain the original value of 0.5.
        if has_depth {
            add(
                &format!("depth_{format_name}_load_op_load_store_op_none"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH,
                            Load::LOAD,
                            Store::NONE,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            ATTACHMENT_INIT_PRE,
                            vec![verify(depth, false, DEPTH_INIT, true, DEPTH_INIT)],
                        ),
                    ],
                    vec![subpass(&[(0, USAGE_COLOR), (1, USAGE_DEPTH)], 2)],
                    ext_a,
                ),
            );
        }

        // Preinitialize depth attachment to 0.5. Use a render pass with load and store ops none for the depth, but disable depth test
        // which also disables depth writes. The depth attachment should have the original preinitialized value after the render pass.
        if has_depth {
            add(
                &format!("depth_{format_name}_load_op_none_store_op_none_write_off"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH,
                            Load::NONE,
                            Store::NONE,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            ATTACHMENT_INIT_PRE,
                            vec![verify(depth, true, DEPTH_INIT, true, DEPTH_INIT)],
                        ),
                    ],
                    vec![subpass(&[(0, USAGE_COLOR), (1, USAGE_DEPTH | USAGE_DEPTH_TEST_OFF)], 1)],
                    ext_b,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and depth buffer to 0.5. During the render pass initialize attachment 1 (depth)
        // to 0.25 using cmdClearAttachments. Draw a red rectangle using depth 1.0 and depth op 'greater'. Depth test will pass and
        // update depth buffer to 1.0. After the renderpass the color buffer should have red inside the render area and depth should
        // have the shader updated value of 1.0.
        if has_depth {
            add(
                &format!("depth_{format_name}_load_op_none_store_op_store"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH,
                            Load::NONE,
                            Store::STORE,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            ATTACHMENT_INIT_PRE | ATTACHMENT_INIT_CMD_CLEAR,
                            vec![verify(depth, true, DEPTH_FULL, true, DEPTH_INIT)],
                        ),
                    ],
                    vec![subpass(&[(0, USAGE_COLOR), (1, USAGE_DEPTH)], 1)],
                    ext_a,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and depth buffer to 0.5. During the render pass initialize attachment 1 (depth)
        // to 0.25 using cmdClearAttachments. Draw a red rectangle using depth 1.0 and depth op 'greater' which will pass. After the
        // renderpass the color buffer should have red inside the render area. Depth buffer contents inside render area is undefined
        // because of store op 'don't care', but the outside should have the original value of 0.5.
        if has_depth {
            add(
                &format!("depth_{format_name}_load_op_none_store_op_dontcare"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH,
                            Load::NONE,
                            Store::DONT_CARE,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            ATTACHMENT_INIT_PRE | ATTACHMENT_INIT_CMD_CLEAR,
                            vec![verify(depth, false, DEPTH_FULL, true, DEPTH_INIT)],
                        ),
                    ],
                    vec![subpass(&[(0, USAGE_COLOR), (1, USAGE_DEPTH)], 1)],
                    ext_b,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and attachment 1 (stencil) to 128. Draw a red rectangle using stencil testing
        // with compare op 'greater' and reference of 255. The stencil test will pass. This is followed by another draw with a blue
        // rectangle using the same stencil settings. This time the stencil test fails and nothing is written. After the renderpass the
        // red color should remain inside the render area of the color buffer. Store op 'none' for stencil buffer makes the written
        // values undefined, but the pixels outside render area should still contain the original value of 128.
        if has_stencil {
            add(
                &format!("stencil_{format_name}_load_op_load_store_op_none"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_STENCIL,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            Load::LOAD,
                            Store::NONE,
                            ATTACHMENT_INIT_PRE,
                            vec![verify(stencil, false, STENCIL_INIT, true, STENCIL_INIT)],
                        ),
                    ],
                    vec![subpass(&[(0, USAGE_COLOR), (1, USAGE_STENCIL)], 2)],
                    ext_a,
                ),
            );
        }

        // Preinitialize stencil attachment to 128. Use a render pass with load and store ops none for the stencil, but disable stencil
        // test which also disables stencil writes. The stencil attachment should have the original preinitialized value after the
        // render pass.
        if has_stencil {
            add(
                &format!("stencil_{format_name}_load_op_none_store_op_none_write_off"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_STENCIL,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            Load::NONE,
                            Store::NONE,
                            ATTACHMENT_INIT_PRE,
                            vec![verify(stencil, true, STENCIL_INIT, true, STENCIL_INIT)],
                        ),
                    ],
                    vec![subpass(
                        &[
                            (0, USAGE_COLOR),
                            (1, USAGE_STENCIL | USAGE_STENCIL_TEST_OFF | USAGE_DEPTH_TEST_OFF),
                        ],
                        1,
                    )],
                    ext_b,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and stencil buffer to 128. During the render pass initialize attachment 1
        // (stencil) to 64 using cmdClearAttachments. Draw a red rectangle using stencil reference of 255 and stencil op 'greater'.
        // Stencil test will pass and update stencil buffer to 255. After the renderpass the color buffer should have red inside the
        // render area and stencil should have the shader updated value of 255.
        if has_stencil {
            add(
                &format!("stencil_{format_name}_load_op_none_store_op_store"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_STENCIL,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            Load::NONE,
                            Store::STORE,
                            ATTACHMENT_INIT_PRE | ATTACHMENT_INIT_CMD_CLEAR,
                            vec![verify(stencil, true, STENCIL_FULL, true, STENCIL_INIT)],
                        ),
                    ],
                    vec![subpass(&[(0, USAGE_COLOR), (1, USAGE_STENCIL)], 1)],
                    ext_a,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and stencil buffer to 128. During the render pass initialize attachment 1
        // (stencil) to 64 using cmdClearAttachments. Draw a red rectangle using stencil reference 255 and stencil op 'greater' which
        // will pass. After the renderpass the color buffer should have red inside the render area. Stencil buffer contents inside
        // render are is undefined because of store op 'don't care', but the outside should have the original value of 128.
        if has_stencil {
            add(
                &format!("stencil_{format_name}_load_op_none_store_op_dontcare"),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_STENCIL,
                            Load::DONT_CARE,
                            Store::DONT_CARE,
                            Load::NONE,
                            Store::DONT_CARE,
                            ATTACHMENT_INIT_PRE | ATTACHMENT_INIT_CMD_CLEAR,
                            vec![verify(stencil, false, STENCIL_FULL, true, STENCIL_INIT)],
                        ),
                    ],
                    vec![subpass(&[(0, USAGE_COLOR), (1, USAGE_STENCIL)], 1)],
                    ext_b,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and depth stencil buffer depth aspect to 0.5 and stencil aspect to 128. Draw a
        // red rectangle using depth 1.0 and depth op 'greater'. Depth test will pass and update depth buffer to 1.0. After the
        // renderpass the color buffer should have red inside the render area and depth should have the shader updated value of 1.0.
        // Stencil has load and store ops none, and stencil writes are disabled by disabling stencil test. Therefore, stencil should not
        // be modified even when the depth aspect is written.
        if has_depth && has_stencil {
            add(
                &format!(
                    "depthstencil_{format_name}_load_op_depth_load_stencil_none_store_op_depth_store_stencil_none_stencil_test_off"
                ),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH_STENCIL,
                            Load::LOAD,
                            Store::STORE,
                            Load::NONE,
                            Store::NONE,
                            ATTACHMENT_INIT_PRE,
                            vec![
                                verify(depth, true, DEPTH_FULL, true, DEPTH_INIT),
                                verify(stencil, true, STENCIL_INIT, true, STENCIL_INIT),
                            ],
                        ),
                    ],
                    vec![subpass(
                        &[(0, USAGE_COLOR), (1, USAGE_DEPTH_STENCIL | USAGE_STENCIL_TEST_OFF)],
                        1,
                    )],
                    ext_a,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and depth stencil buffer stencil aspect to 128 and depth aspect to 0.5. Draw a
        // red rectangle using stencil reference of 255 and stencil op 'greater'. Stencil test will pass and update stencil buffer to
        // 255. After the renderpass the color buffer should have red inside the render area and stencil should have the shader updated
        // value of 255. Depth has load and store ops none, and depth writes are disabled by having depth test off. Therefore, depth
        // should not be modified even when the stencil aspect is written.
        if has_depth && has_stencil {
            add(
                &format!(
                    "depthstencil_{format_name}_load_op_depth_none_stencil_load_store_op_depth_none_stencil_store_depth_test_off"
                ),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH_STENCIL,
                            Load::NONE,
                            Store::NONE,
                            Load::LOAD,
                            Store::STORE,
                            ATTACHMENT_INIT_PRE,
                            vec![
                                verify(depth, true, DEPTH_INIT, true, DEPTH_INIT),
                                verify(stencil, true, STENCIL_FULL, true, STENCIL_INIT),
                            ],
                        ),
                    ],
                    vec![subpass(
                        &[(0, USAGE_COLOR), (1, USAGE_DEPTH_STENCIL | USAGE_DEPTH_TEST_OFF)],
                        1,
                    )],
                    ext_b,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and depth stencil buffer depth aspect to 0.5 and stencil aspect to 128. Draw a
        // red rectangle using depth 1.0 and depth op 'greater'. Depth test will pass and update depth buffer to 1.0. After the
        // renderpass the color buffer should have red inside the render area and depth should have the shader updated value of 1.0.
        // Stencil has load and store ops none, and stencil writes are disabled. Therefore, stencil should not be modified even when
        // the depth aspect is written.
        if has_depth && has_stencil {
            add(
                &format!(
                    "depthstencil_{format_name}_load_op_depth_load_stencil_none_store_op_depth_store_stencil_none_stencil_write_off"
                ),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH_STENCIL,
                            Load::LOAD,
                            Store::STORE,
                            Load::NONE,
                            Store::NONE,
                            ATTACHMENT_INIT_PRE,
                            vec![
                                verify(depth, true, DEPTH_FULL, true, DEPTH_INIT),
                                verify(stencil, true, STENCIL_INIT, true, STENCIL_INIT),
                            ],
                        ),
                    ],
                    vec![subpass(
                        &[(0, USAGE_COLOR), (1, USAGE_DEPTH_STENCIL | USAGE_STENCIL_WRITE_OFF)],
                        1,
                    )],
                    ext_a,
                ),
            );
        }

        // Preinitialize attachment 0 (color) to green and depth stencil buffer stencil aspect to 128 and depth aspect to 0.5. Draw a
        // red rectangle using stencil reference of 255 and stencil op 'greater'. Stencil test will pass and update stencil buffer to
        // 255. After the renderpass the color buffer should have red inside the render area and stencil should have the shader updated
        // value of 255. Depth has load and store ops none, the depth buffer contents will be undefined and depth test is enabled but
        // op will be 'always' so depth testing will pass. Depth writes are disabled, so depth should not be modified even when the
        // stencil aspect is written.
        if has_depth && has_stencil {
            add(
                &format!(
                    "depthstencil_{format_name}_load_op_depth_none_stencil_load_store_op_depth_none_stencil_store_depth_write_off"
                ),
                ds_params(
                    vec![
                        color_attachment(),
                        attachment(
                            USAGE_DEPTH_STENCIL,
                            Load::NONE,
                            Store::NONE,
                            Load::LOAD,
                            Store::STORE,
                            ATTACHMENT_INIT_PRE,
                            vec![
                                verify(depth, true, DEPTH_INIT, true, DEPTH_INIT),
                                verify(stencil, true, STENCIL_FULL, true, STENCIL_INIT),
                            ],
                        ),
                    ],
                    vec![subpass(
                        &[(0, USAGE_COLOR), (1, USAGE_DEPTH_STENCIL | USAGE_DEPTH_WRITE_OFF)],
                        1,
                    )],
                    ext_b,
                ),
            );
        }
    }

    op_none_tests
}
