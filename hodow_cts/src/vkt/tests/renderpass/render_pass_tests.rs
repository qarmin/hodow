// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The verification here is not a pixel comparison against a rendered reference. Every
// value the test ever writes - clear values, the fragment shader's output - is either
// 0 or 1 in each channel, so the reference is a per-channel tri-state: true, false, or
// undefined. `PixelValue` is that tri-state, `render_reference_values` replays the
// render pass over it (image clear, load op, subpass clears, draw), and the comparison
// only checks the channels the replay left defined. That is what makes DONT_CARE
// testable at all: it marks the region undefined rather than predicting a value.
//
// Ported so far: the `formats` colour cases - one colour attachment, one subpass, no
// input attachments. Everything else in the group is absent rather than skipped.

// The channel loops index a `[_; 4]` by the component number the C++ names, and the
// argument lists mirror `pushRenderPassCommands`; the iterator forms clippy suggests
// would lose that correspondence.
#![allow(clippy::needless_range_loop, clippy::too_many_arguments)]

use vulkanalia::prelude::v1_0::*;

use super::super::api::copies_buffer_tests::AllocationKind;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, get_texture_format_channel_mask};
use crate::tcu::random::Random;
use crate::tcu::texture::{ChannelOrder, TextureChannelClass, TextureFormat};
use crate::tcu::{self, TestError, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, get_depth_copy_format, get_stencil_copy_format, make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set, make_framebuffer, make_pipeline_layout};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::{Context, TestCase, TestInstance};

// ---------------------------------------------------------------------------------
// Render pass description
// ---------------------------------------------------------------------------------

/// `AttachmentReference`
#[derive(Clone, Copy)]
pub struct AttachmentReference {
    attachment: u32,
    layout: vk::ImageLayout,
    aspect_mask: vk::ImageAspectFlags,
}

impl AttachmentReference {
    pub const fn new(attachment: u32, layout: vk::ImageLayout) -> Self {
        Self {
            attachment,
            layout,
            aspect_mask: vk::ImageAspectFlags::empty(),
        }
    }

    pub const fn with_aspect(attachment: u32, layout: vk::ImageLayout, aspect_mask: vk::ImageAspectFlags) -> Self {
        Self { attachment, layout, aspect_mask }
    }
}

/// `SubpassDependency`
#[derive(Clone, Copy)]
pub struct SubpassDependency {
    src_pass: u32,
    dst_pass: u32,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    flags: vk::DependencyFlags,
}

/// `VK_ATTACHMENT_UNUSED`
const ATTACHMENT_UNUSED: u32 = u32::MAX;

/// `Attachment`
#[derive(Clone, Copy)]
pub struct Attachment {
    format: vk::Format,
    samples: vk::SampleCountFlags,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    initial_layout: vk::ImageLayout,
    final_layout: vk::ImageLayout,
}

/// `Subpass`
#[derive(Clone)]
pub struct Subpass {
    input_attachments: Vec<AttachmentReference>,
    color_attachments: Vec<AttachmentReference>,
    depth_stencil_attachment: AttachmentReference,
}

/// `RenderPass`
#[derive(Clone)]
pub struct RenderPassDesc {
    attachments: Vec<Attachment>,
    subpasses: Vec<Subpass>,
    dependencies: Vec<SubpassDependency>,
    /// `VkInputAttachmentAspectReference` - the `use_input_aspect` variants declare
    /// the aspect through `VkRenderPassInputAttachmentAspectCreateInfo` instead of on
    /// the reference, which only the legacy entry point has.
    input_aspects: Vec<vk::InputAttachmentAspectReference>,
}

/// `TestConfig::RenderTypes`
#[derive(Clone, Copy, PartialEq, Eq)]
pub struct RenderTypes(u32);

impl RenderTypes {
    pub const CLEAR: Self = Self(1 << 1);
    pub const DRAW: Self = Self(1 << 2);

    const fn or(self, other: Self) -> Self {
        Self(self.0 | other.0)
    }

    fn contains(self, other: Self) -> bool {
        self.0 & other.0 != 0
    }
}

/// `DEPTH_VALUES`, shuffled per case by `TestConfig`'s constructor. Only the two the
/// constructor keeps are ever used, and no ported case has a depth attachment yet, but
/// the shuffle consumes the rng in the order upstream does and the clear values that
/// follow depend on that.
const DEPTH_VALUES: [u8; 3] = [0u8, 255u8, 128u8];

/// `TestConfig`
pub struct TestConfig {
    render_pass: RenderPassDesc,
    render_types: RenderTypes,
    target_size: [u32; 2],
    render_pos: [u32; 2],
    render_size: [u32; 2],
    /// Always false in the ported group; the `attachment` cases set it.
    #[allow(dead_code)]
    use_format_comp_count: bool,
    seed: u32,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
    /// Read by the depth/stencil paths, which are not ported; the shuffle that picks
    /// them still has to run, because the clear values drawn after it depend on where
    /// it left the rng.
    #[allow(dead_code)]
    depth_values: [u8; 2],
}

/// `RenderingType`, narrowed to the two the port registers.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum RenderPassType {
    /// `RENDERING_TYPE_RENDERPASS_LEGACY`
    Legacy,
    /// `RENDERING_TYPE_RENDERPASS2`
    RenderPass2,
}

impl TestConfig {
    #[allow(clippy::too_many_arguments)]
    fn new(
        render_pass: RenderPassDesc,
        render_types: RenderTypes,
        target_size: [u32; 2],
        render_pos: [u32; 2],
        render_size: [u32; 2],
        use_format_comp_count: bool,
        seed: u32,
        allocation_kind: AllocationKind,
        render_pass_type: RenderPassType,
    ) -> Self {
        let mut shuffled = DEPTH_VALUES;
        let mut rng = Random::new(seed + 1);
        rng.shuffle(&mut shuffled);

        Self {
            render_pass,
            render_types,
            target_size,
            render_pos,
            render_size,
            use_format_comp_count,
            seed,
            allocation_kind,
            render_pass_type,
            depth_values: [shuffled[0], shuffled[1]],
        }
    }
}

// ---------------------------------------------------------------------------------
// Shader helpers, shared with the manifest
// ---------------------------------------------------------------------------------

/// The manifest declares its cases with this, so the GLSL type the shader was built
/// for is carried next to the binaries and can be checked against what the host
/// computes for the attachment.
pub struct GridProgram {
    pub name: &'static str,
    pub attachment_type: &'static str,
    pub programs: BinaryCollection,
}

/// Every entry the shader generator emitted, so the lookup is a search over what
/// exists rather than a second list that has to be kept in step with it.
static ALL_INPUT_PROGRAMS: &[&InputProgram] = &[
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_FLOAT1,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_FLOAT2,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_FLOAT3,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_FLOAT4,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_SINT1,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_SINT2,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_SINT4,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_UINT1,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_UINT2,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_INPUT_UINT4,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT1,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT1_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT2,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT2_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT3,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT3_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT4,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_FLOAT4_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_SINT1,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_SINT1_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_SINT2,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_SINT2_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_SINT4,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_SINT4_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_UINT1,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_UINT1_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_UINT2,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_UINT2_MS,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_UINT4,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_SELF_DEP_UINT4_MS,
];

/// Every depth/stencil `input` entry the generator emitted.
static ALL_DEPTH_INPUT_PROGRAMS: &[&DepthInputProgram] = &[
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_COLOR_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_COLOR_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_COLOR_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_COLOR_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_COLOR_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_COLOR_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_DEPTH_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_DEPTH_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_DEPTH_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_DEPTH_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_DEPTH_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_DEPTH_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_NONE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_NONE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_NONE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_NONE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_NONE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_0_NONE_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_COLOR_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_COLOR_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_COLOR_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_COLOR_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_COLOR_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_COLOR_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_DEPTH_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_DEPTH_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_DEPTH_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_DEPTH_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_DEPTH_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_DEPTH_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_NONE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_NONE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_NONE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_NONE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_NONE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_16_NONE_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_COLOR_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_COLOR_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_COLOR_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_COLOR_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_COLOR_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_COLOR_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_DEPTH_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_DEPTH_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_DEPTH_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_DEPTH_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_DEPTH_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_DEPTH_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_NONE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_NONE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_NONE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_NONE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_NONE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_10_24_NONE_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_COLOR_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_COLOR_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_COLOR_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_COLOR_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_COLOR_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_COLOR_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_DEPTH_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_DEPTH_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_DEPTH_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_DEPTH_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_DEPTH_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_DEPTH_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_NONE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_NONE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_NONE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_NONE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_NONE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_01_0_NONE_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_COLOR_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_COLOR_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_COLOR_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_COLOR_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_COLOR_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_COLOR_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_DEPTH_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_DEPTH_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_DEPTH_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_DEPTH_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_DEPTH_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_DEPTH_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_NONE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_NONE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_NONE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_NONE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_NONE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_0_NONE_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_COLOR_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_COLOR_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_COLOR_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_COLOR_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_COLOR_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_COLOR_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_DEPTH_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_DEPTH_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_DEPTH_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_DEPTH_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_DEPTH_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_DEPTH_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_NONE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_NONE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_NONE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_NONE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_NONE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_16_NONE_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_COLOR_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_COLOR_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_COLOR_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_COLOR_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_COLOR_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_COLOR_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_DEPTH_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_DEPTH_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_DEPTH_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_DEPTH_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_DEPTH_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_DEPTH_128_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_NONE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_NONE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_NONE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_NONE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_NONE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_IN_11_24_NONE_128_255,
];

/// Every depth/stencil entry the generator emitted.
static ALL_DEPTH_PROGRAMS: &[&DepthProgram] = &[
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_NO_WRITE,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_WRITE_0_255,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_WRITE_0_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_WRITE_255_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_WRITE_255_128,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_WRITE_128_0,
    &crate::generated::shaders::renderpass_render_pass_input::RENDER_PASS_DS_WRITE_128_255,
];

/// The manifest declares the depth/stencil `input` cases with this. `ds_output` is
/// what the reading subpass writes: "color" for the two-subpass form, "depth" for the
/// self-dependency one, or "none" where the layout leaves nothing writable.
pub struct DepthInputProgram {
    pub name: &'static str,
    pub depth_input: bool,
    pub stencil_input: bool,
    pub epsilon_bits: u32,
    pub ds_output: &'static str,
    pub ds_depth_true: u32,
    pub ds_depth_false: u32,
    pub programs: BinaryCollection,
}

/// The manifest declares the depth/stencil cases with this. `write_depth` is false
/// for the `_depth_read_only` layouts, where the subpass may not write depth at all.
pub struct DepthProgram {
    pub name: &'static str,
    pub write_depth: bool,
    pub depth_true: u32,
    pub depth_false: u32,
    pub programs: BinaryCollection,
}

/// The manifest declares the input-attachment cases with this: the subpass-0 and
/// subpass-1 shaders together, plus what the generator built them for.
pub struct InputProgram {
    pub name: &'static str,
    pub attachment_type: &'static str,
    pub input_channel_class: &'static str,
    pub input_component_count: u32,
    pub output_component_count: u32,
    /// Which attachment the reading subpass writes. It is part of the key because it
    /// feeds `index`, and a self-dependency case can otherwise be indistinguishable
    /// from a two-subpass one on every other field.
    pub output_attachment_index: u32,
    pub multisample: bool,
    pub programs: BinaryCollection,
}

/// `getShaderNumChannels`
fn get_shader_num_channels(order: ChannelOrder) -> usize {
    if order == ChannelOrder::A { 4 } else { order.num_used_channels() as usize }
}

/// `getAttachmentType`, for `useFormatCompCount == false`.
fn attachment_type_name(format: TextureFormat) -> &'static str {
    match format.channel_class() {
        TextureChannelClass::SignedInteger => "ivec4",
        TextureChannelClass::UnsignedInteger => "uvec4",
        _ => "vec4",
    }
}

/// `BoolOp`
#[derive(Clone, Copy)]
enum BoolOp {
    And,
    Or,
    Eq,
    Neq,
}

/// `boolOpFromIndex`
fn bool_op_from_index(index: usize) -> BoolOp {
    const OPS: [BoolOp; 4] = [BoolOp::Or, BoolOp::And, BoolOp::Eq, BoolOp::Neq];
    OPS[index % 4]
}

/// `performBoolOp`
fn perform_bool_op(op: BoolOp, a: bool, b: bool) -> bool {
    match op {
        BoolOp::Or => a || b,
        BoolOp::And => a && b,
        BoolOp::Eq => a == b,
        BoolOp::Neq => a != b,
    }
}

// ---------------------------------------------------------------------------------
// The reference model
// ---------------------------------------------------------------------------------

/// `PixelValue` - four channels of "true", "false" or "undefined", packed two bits
/// each exactly as upstream packs them.
#[derive(Clone, Copy, Default)]
struct PixelValue {
    status: u16,
}

impl PixelValue {
    fn set_undefined(&mut self, ndx: usize) {
        self.status &= !(0x1u16 << (ndx * 2));
    }

    fn set_value(&mut self, ndx: usize, value: bool) {
        self.status |= 0x1u16 << (ndx * 2);
        if value {
            self.status |= 0x1u16 << (ndx * 2 + 1);
        } else {
            self.status &= !(0x1u16 << (ndx * 2 + 1));
        }
    }

    fn get_value(&self, ndx: usize) -> Option<bool> {
        if self.status & (0x1u16 << (ndx * 2)) == 0 {
            None
        } else {
            Some(self.status & (0x1u16 << (ndx * 2 + 1)) != 0)
        }
    }
}

/// A colour clear value in the only form this test ever produces: one bool per
/// channel, or `None` for a channel the format does not have.
#[derive(Clone, Copy)]
struct ClearValue {
    channels: [Option<bool>; 4],
}

impl ClearValue {
    /// `randomClearValue`.
    ///
    /// For a colour format upstream writes a per-format "unused" filler into the
    /// channels the format does not have - INT_MIN, UINT_MAX or NaN - and the
    /// reference ignores them, so only which channels are used and what the rng said
    /// is kept. For depth/stencil the two channels are depth and stencil, in that
    /// order in the value but *stencil first* in the rng, which is the order upstream
    /// draws them and therefore the order everything after it depends on.
    fn random(format: TextureFormat, rng: &mut Random) -> Self {
        if format.order.has_depth() || format.order.has_stencil() {
            let stencil = format.order.has_stencil().then(|| rng.get_bool());
            let depth = format.order.has_depth().then(|| rng.get_bool());
            return Self {
                channels: [depth, stencil, None, None],
            };
        }
        let mask = get_texture_format_channel_mask(format);
        let channels = std::array::from_fn(|i| if mask[i] { Some(rng.get_bool()) } else { None });
        Self { channels }
    }

    /// The `VkClearDepthStencilValue` this stands for.
    fn to_vk_depth_stencil(self, depth_values: [u8; 2]) -> vk::ClearDepthStencilValue {
        vk::ClearDepthStencilValue {
            depth: f32::from(depth_values[usize::from(self.channels[0].unwrap_or(false))]) / 255.0,
            stencil: if self.channels[1].unwrap_or(false) { 0xFF } else { 0x0 },
        }
    }

    /// `clearValueToPixelValue`
    fn to_pixel_value(self) -> PixelValue {
        let mut value = PixelValue::default();
        for (i, channel) in self.channels.iter().enumerate() {
            match channel {
                Some(v) => value.set_value(i, *v),
                None => value.set_undefined(i),
            }
        }
        value
    }

    /// The `VkClearColorValue` this stands for, in the union member the format's
    /// channel class selects.
    fn to_vk(self, format: TextureFormat) -> vk::ClearColorValue {
        let bits: [u32; 4] = std::array::from_fn(|i| u32::from(self.channels[i].unwrap_or(false)));
        match format.channel_class() {
            TextureChannelClass::SignedInteger => vk::ClearColorValue { int32: bits.map(|b| b as i32) },
            TextureChannelClass::UnsignedInteger => vk::ClearColorValue { uint32: bits },
            _ => vk::ClearColorValue { float32: bits.map(|b| b as f32) },
        }
    }
}

/// `clearReferenceValues`
fn clear_reference_values(reference: &mut [PixelValue], target_size: [u32; 2], offset: [u32; 2], size: [u32; 2], value: PixelValue) {
    for y in offset[1]..offset[1] + size[1] {
        for x in offset[0]..offset[0] + size[0] {
            let at = (x + y * target_size[0]) as usize;
            for ndx in 0..4 {
                match value.get_value(ndx) {
                    Some(v) => reference[at].set_value(ndx, v),
                    None => reference[at].set_undefined(ndx),
                }
            }
        }
    }
}

/// `markUndefined`
fn mark_undefined(reference: &mut [PixelValue], target_size: [u32; 2], offset: [u32; 2], size: [u32; 2]) {
    for y in offset[1]..offset[1] + size[1] {
        for x in offset[0]..offset[0] + size[0] {
            let at = (x + y * target_size[0]) as usize;
            for ndx in 0..4 {
                reference[at].set_undefined(ndx);
            }
        }
    }
}

/// `roundToViewport`
fn round_to_viewport(x: f32, offset: u32, size: u32) -> f32 {
    let origin = offset as f32 + (size as f32 / 2.0);
    let p = size as f32 / 2.0;
    let xi = (origin + p * x).round() as i32;
    (xi as f32 - origin) / p
}

/// `RenderQuad`, reduced to the two corners the rest of the test reads.
#[derive(Clone, Copy)]
struct RenderQuad {
    corner_a: [f32; 2],
    corner_b: [f32; 2],
}

impl RenderQuad {
    /// The six vertices `getVertexPointer` hands to the vertex buffer.
    fn vertices(&self) -> [[f32; 2]; 6] {
        let (a, b) = (self.corner_a, self.corner_b);
        [a, [a[0], b[1]], b, b, [b[0], a[1]], a]
    }
}

/// `ColorClear`
#[derive(Clone, Copy)]
struct ColorClear {
    offset: [u32; 2],
    size: [u32; 2],
    color: ClearValue,
}

/// `DepthStencilClear` - where the clear applies, and the value in the same tri-state
/// form the colour clears use.
struct DepthStencilClear {
    offset: [u32; 2],
    size: [u32; 2],
    value: ClearValue,
}

/// `SubpassRenderInfo`
struct SubpassRenderInfo {
    viewport_offset: [u32; 2],
    viewport_size: [u32; 2],
    color_clears: Vec<ColorClear>,
    depth_stencil_clear: Option<DepthStencilClear>,
    render_quad: Option<RenderQuad>,
}

/// `initializeSubpassRenderInfo`, for one subpass with `COMMANDBUFFERTYPES_INLINE`.
fn initialize_subpass_render_info(rng: &mut Random, render_pass: &RenderPassDesc, config: &TestConfig) -> Vec<SubpassRenderInfo> {
    let mut infos = Vec::new();

    for (subpass_ndx, subpass) in render_pass.subpasses.iter().enumerate() {
        let viewport_size = [config.render_size[0] * 2 / 3, config.render_size[1] * 2 / 3];
        let viewport_offset = [
            config.render_pos[0] + (subpass_ndx as u32 % 2) * (config.render_size[0] / 3),
            config.render_pos[1] + ((subpass_ndx as u32 / 2) % 2) * (config.render_size[1] / 3),
        ];

        let mut color_clears = Vec::new();
        let mut depth_stencil_clear = None;
        let mut render_quad = None;

        if config.render_types.contains(RenderTypes::CLEAR) {
            for (attachment_ref_ndx, attachment_ref) in subpass.color_attachments.iter().enumerate() {
                let attachment = render_pass.attachments[attachment_ref.attachment as usize];
                let size = [viewport_size[0] * 2 / 3, viewport_size[1] * 2 / 3];
                let offset = [
                    viewport_offset[0] + (attachment_ref_ndx as u32 % 2) * (viewport_size[0] / 3),
                    viewport_offset[1] + ((attachment_ref_ndx as u32 / 2) % 2) * (viewport_size[1] / 3),
                ];
                let format = map_vk_format(attachment.format).expect("a colour attachment format maps");
                color_clears.push(ColorClear {
                    offset,
                    size,
                    color: ClearValue::random(format, rng),
                });
            }

            if subpass.depth_stencil_attachment.attachment != ATTACHMENT_UNUSED {
                let attachment = render_pass.attachments[subpass.depth_stencil_attachment.attachment as usize];
                let size = [viewport_size[0] * 2 / 3, viewport_size[1] * 2 / 3];
                let count = subpass.color_attachments.len() as u32;
                let offset = [
                    viewport_offset[0] + (count % 2) * (viewport_size[0] / 3),
                    viewport_offset[1] + ((count / 2) % 2) * (viewport_size[1] / 3),
                ];
                let format = map_vk_format(attachment.format).expect("a depth/stencil attachment format maps");
                depth_stencil_clear = Some(DepthStencilClear {
                    offset,
                    size,
                    value: ClearValue::random(format, rng),
                });
            }
        }

        if config.render_types.contains(RenderTypes::DRAW) {
            let w = if subpass_ndx % 2 == 0 { 1.0 } else { 1.25 };
            let h = if subpass_ndx % 2 == 0 { 1.25 } else { 1.0 };

            // The y pair keys off `(subpassNdx / 2) % 2`, not `subpassNdx % 2` - the
            // same index that placed the viewport, so consecutive subpasses step in x
            // first and only then in y.
            let x_low = subpass_ndx % 2 == 0;
            let y_low = (subpass_ndx / 2) % 2 == 0;
            let x0 = round_to_viewport(if x_low { 1.0 - w } else { -1.0 }, viewport_offset[0], viewport_size[0]);
            let x1 = round_to_viewport(if x_low { 1.0 } else { -1.0 + w }, viewport_offset[0], viewport_size[0]);
            let y0 = round_to_viewport(if y_low { 1.0 - h } else { -1.0 }, viewport_offset[1], viewport_size[1]);
            let y1 = round_to_viewport(if y_low { 1.0 } else { -1.0 + h }, viewport_offset[1], viewport_size[1]);

            render_quad = Some(RenderQuad {
                corner_a: [x0, y0],
                corner_b: [x1, y1],
            });
        }

        infos.push(SubpassRenderInfo {
            viewport_offset,
            viewport_size,
            color_clears,
            depth_stencil_clear,
            render_quad,
        });
    }

    infos
}

/// `renderReferenceValues`, for colour attachments with no input attachments.
fn render_reference_values(
    render_pass: &RenderPassDesc,
    target_size: [u32; 2],
    image_clear_values: &[Option<ClearValue>],
    render_pass_clear_values: &[Option<ClearValue>],
    subpass_render_info: &[SubpassRenderInfo],
    render_pos: [u32; 2],
    render_size: [u32; 2],
) -> Vec<Vec<PixelValue>> {
    let mut reference_attachments: Vec<Vec<PixelValue>> = Vec::new();
    let mut attachment_used = vec![false; render_pass.attachments.len()];

    for (attachment_ndx, _) in render_pass.attachments.iter().enumerate() {
        let mut reference = vec![PixelValue::default(); (target_size[0] * target_size[1]) as usize];

        if let Some(clear) = image_clear_values[attachment_ndx] {
            clear_reference_values(&mut reference, target_size, [0, 0], target_size, clear.to_pixel_value());
        }
        reference_attachments.push(reference);
    }

    for (subpass_ndx, subpass) in render_pass.subpasses.iter().enumerate() {
        let render_info = &subpass_render_info[subpass_ndx];

        // Apply load op if attachment was used for the first time
        for attachment_ref in &subpass.color_attachments {
            let attachment_index = attachment_ref.attachment;
            if attachment_index == ATTACHMENT_UNUSED {
                continue;
            }
            let attachment_index = attachment_index as usize;
            if attachment_used[attachment_index] {
                continue;
            }

            let attachment = render_pass.attachments[attachment_index];
            let reference = &mut reference_attachments[attachment_index];

            if attachment.load_op == vk::AttachmentLoadOp::CLEAR {
                let clear = render_pass_clear_values[attachment_index].expect("a CLEAR load op has a clear value");
                clear_reference_values(reference, target_size, render_pos, render_size, clear.to_pixel_value());
            } else if attachment.load_op == vk::AttachmentLoadOp::DONT_CARE {
                mark_undefined(reference, target_size, render_pos, render_size);
            }

            attachment_used[attachment_index] = true;
        }

        // Apply load op to the depth/stencil attachment if it was used for the first
        // time. Depth and stencil have their own load ops and their own channel.
        if subpass.depth_stencil_attachment.attachment != ATTACHMENT_UNUSED {
            let attachment_index = subpass.depth_stencil_attachment.attachment as usize;

            if !attachment_used[attachment_index] {
                let attachment = render_pass.attachments[attachment_index];
                let format = map_vk_format(attachment.format).expect("a depth/stencil attachment format maps");
                let reference = &mut reference_attachments[attachment_index];

                if format.order.has_depth() {
                    if attachment.load_op == vk::AttachmentLoadOp::CLEAR {
                        let clear = render_pass_clear_values[attachment_index].expect("a CLEAR load op has a clear value");
                        clear_reference_channel(reference, target_size, render_pos, render_size, 0, clear.channels[0]);
                    } else if attachment.load_op == vk::AttachmentLoadOp::DONT_CARE {
                        clear_reference_channel(reference, target_size, render_pos, render_size, 0, None);
                    }
                }

                if format.order.has_stencil() {
                    if attachment.stencil_load_op == vk::AttachmentLoadOp::CLEAR {
                        let clear = render_pass_clear_values[attachment_index].expect("a CLEAR stencil load op has a clear value");
                        clear_reference_channel(reference, target_size, render_pos, render_size, 1, clear.channels[1]);
                    } else if attachment.stencil_load_op == vk::AttachmentLoadOp::DONT_CARE {
                        clear_reference_channel(reference, target_size, render_pos, render_size, 1, None);
                    }
                }

                attachment_used[attachment_index] = true;
            }
        }

        for (color_clear_ndx, color_clear) in render_info.color_clears.iter().enumerate() {
            let attachment_index = subpass.color_attachments[color_clear_ndx].attachment as usize;
            let reference = &mut reference_attachments[attachment_index];
            clear_reference_values(reference, target_size, color_clear.offset, color_clear.size, color_clear.color.to_pixel_value());
        }

        if let Some(DepthStencilClear { offset, size, value: clear }) = render_info.depth_stencil_clear {
            let attachment_index = subpass.depth_stencil_attachment.attachment as usize;
            let attachment = render_pass.attachments[attachment_index];
            let format = map_vk_format(attachment.format).expect("a depth/stencil attachment format maps");
            let layout = subpass.depth_stencil_attachment.layout;
            let reference = &mut reference_attachments[attachment_index];

            if format.order.has_depth() && layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL {
                clear_reference_channel(reference, target_size, offset, size, 0, clear.channels[0]);
            }
            if format.order.has_stencil() && layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && layout != vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL {
                clear_reference_channel(reference, target_size, offset, size, 1, clear.channels[1]);
            }
        }

        if let Some(render_quad) = render_info.render_quad {
            let origin = [
                render_info.viewport_offset[0] as f32 + render_info.viewport_size[0] as f32 / 2.0,
                render_info.viewport_offset[1] as f32 + render_info.viewport_size[1] as f32 / 2.0,
            ];
            let p = [render_info.viewport_size[0] as f32 / 2.0, render_info.viewport_size[1] as f32 / 2.0];
            let pos_a = [
                (origin[0] + p[0] * render_quad.corner_a[0]).round() as i32,
                (origin[1] + p[1] * render_quad.corner_a[1]).round() as i32,
            ];
            let pos_b = [
                (origin[0] + p[0] * render_quad.corner_b[0]).round() as i32,
                (origin[1] + p[1] * render_quad.corner_b[1]).round() as i32,
            ];

            if subpass.input_attachments.is_empty() {
                for attachment_ref in &subpass.color_attachments {
                    let attachment_index = attachment_ref.attachment;
                    if attachment_index == ATTACHMENT_UNUSED {
                        continue;
                    }
                    let attachment_index = attachment_index as usize;
                    let attachment = render_pass.attachments[attachment_index];
                    let format = map_vk_format(attachment.format).expect("a colour attachment format maps");
                    let channel_mask = get_texture_format_channel_mask(format);
                    let reference = &mut reference_attachments[attachment_index];

                    for y in pos_a[1]..pos_b[1] {
                        for x in pos_a[0]..pos_b[0] {
                            for comp_ndx in 0..4 {
                                let index = subpass_ndx + attachment_index + comp_ndx;
                                let op = bool_op_from_index(index);
                                let bool_x = x % 2 == (index % 2) as i32;
                                let bool_y = y % 2 == ((index / 2) % 2) as i32;

                                if channel_mask[comp_ndx] {
                                    let at = (x + y * target_size[0] as i32) as usize;
                                    reference[at].set_value(comp_ndx, perform_bool_op(op, bool_x, bool_y));
                                }
                            }
                        }
                    }
                }
                // The draw writes depth from the shader and stencil from the pipeline's
                // stencil reference, each only where the layout allows it.
                if subpass.depth_stencil_attachment.attachment != ATTACHMENT_UNUSED {
                    let attachment_index = subpass.depth_stencil_attachment.attachment as usize;
                    let layout = subpass.depth_stencil_attachment.layout;
                    let attachment = render_pass.attachments[attachment_index];
                    let format = map_vk_format(attachment.format).expect("a depth/stencil attachment format maps");
                    let reference = &mut reference_attachments[attachment_index];

                    for y in pos_a[1]..pos_b[1] {
                        for x in pos_a[0]..pos_b[0] {
                            let at = (x + y * target_size[0] as i32) as usize;

                            if format.order.has_depth()
                                && layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL
                                && layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL
                            {
                                let index = subpass_ndx + 1;
                                let op = bool_op_from_index(index);
                                let bool_x = x % 2 == (index % 2) as i32;
                                let bool_y = y % 2 == ((index / 2) % 2) as i32;
                                reference[at].set_value(0, perform_bool_op(op, bool_x, bool_y));
                            }

                            if format.order.has_stencil()
                                && layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL
                                && layout != vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL
                            {
                                reference[at].set_value(1, subpass_ndx % 2 == 0);
                            }
                        }
                    }
                }
            } else {
                // With input attachments each output channel is the grid value
                // compared against one input channel, so an undefined input makes the
                // output undefined rather than wrong.
                let mut output_component_count: usize = subpass
                    .color_attachments
                    .iter()
                    .map(|r| {
                        let format = map_vk_format(render_pass.attachments[r.attachment as usize].format).expect("a colour attachment format maps");
                        get_shader_num_channels(format.order)
                    })
                    .sum();

                // A writable depth aspect is one more output; stencil is not, because
                // it does not come from the shader.
                let ds_ref = subpass.depth_stencil_attachment;
                let writes_depth = ds_ref.attachment != ATTACHMENT_UNUSED
                    && ds_ref.layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL
                    && ds_ref.layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL
                    && map_vk_format(render_pass.attachments[ds_ref.attachment as usize].format).is_some_and(|f| f.order.has_depth());
                if writes_depth {
                    output_component_count += 1;
                }

                if output_component_count > 0 {
                    for y in pos_a[1]..pos_b[1] {
                        for x in pos_a[0]..pos_b[0] {
                            let at = (x + y * target_size[0] as i32) as usize;

                            let mut inputs: Vec<Option<bool>> = Vec::new();
                            for input_ref in &subpass.input_attachments {
                                let attachment_index = input_ref.attachment as usize;
                                let format = map_vk_format(render_pass.attachments[attachment_index].format).expect("an input attachment format maps");

                                if format.order.has_depth() || format.order.has_stencil() {
                                    // Depth is channel 0 and stencil channel 1, and a
                                    // read-only layout drops its aspect from the list.
                                    let (depth, stencil) = readable_aspects(format, input_ref.layout);
                                    if depth {
                                        inputs.push(reference_attachments[attachment_index][at].get_value(0));
                                    }
                                    if stencil {
                                        inputs.push(reference_attachments[attachment_index][at].get_value(1));
                                    }
                                } else {
                                    for comp_ndx in 0..get_shader_num_channels(format.order) {
                                        inputs.push(reference_attachments[attachment_index][at].get_value(comp_ndx));
                                    }
                                }
                            }

                            let inputs_per_output = if inputs.len() >= output_component_count {
                                inputs.len() / output_component_count + usize::from(!inputs.len().is_multiple_of(output_component_count))
                            } else {
                                1
                            };

                            let mut output_value_ndx = 0usize;
                            for attachment_ref in &subpass.color_attachments {
                                let attachment_index = attachment_ref.attachment as usize;
                                let format = map_vk_format(render_pass.attachments[attachment_index].format).expect("a colour attachment format maps");
                                let component_count = get_shader_num_channels(format.order);

                                for comp_ndx in 0..component_count {
                                    let index = subpass_ndx + attachment_index + output_value_ndx;
                                    let op = bool_op_from_index(index);
                                    let bool_x = x % 2 == (index % 2) as i32;
                                    let bool_y = y % 2 == ((index / 2) % 2) as i32;
                                    let mut output = Some(perform_bool_op(op, bool_x, bool_y));

                                    for i in 0..inputs_per_output {
                                        let Some(current) = output else { break };
                                        match inputs[((output_value_ndx + comp_ndx) * inputs_per_output + i) % inputs.len()] {
                                            Some(input) => output = Some(current == input),
                                            None => output = None,
                                        }
                                    }

                                    let reference = &mut reference_attachments[attachment_index];
                                    match output {
                                        Some(value) => reference[at].set_value(comp_ndx, value),
                                        None => reference[at].set_undefined(comp_ndx),
                                    }
                                }

                                output_value_ndx += component_count;
                            }

                            if writes_depth {
                                let attachment_index = ds_ref.attachment as usize;
                                let index = subpass_ndx + attachment_index;
                                let op = bool_op_from_index(index);
                                let bool_x = x % 2 == (index % 2) as i32;
                                let bool_y = y % 2 == ((index / 2) % 2) as i32;
                                let mut output = Some(perform_bool_op(op, bool_x, bool_y));

                                for i in 0..inputs_per_output {
                                    let Some(current) = output else { break };
                                    match inputs[(output_value_ndx * inputs_per_output + i) % inputs.len()] {
                                        Some(input) => output = Some(current == input),
                                        None => output = None,
                                    }
                                }

                                let reference = &mut reference_attachments[attachment_index];
                                match output {
                                    Some(value) => reference[at].set_value(0, value),
                                    None => reference[at].set_undefined(0),
                                }
                            }
                        }
                    }
                }

                // Stencil is written by the pipeline, not the shader, so it does not
                // take part in the input/output pairing above.
                let ds_ref = subpass.depth_stencil_attachment;
                if ds_ref.attachment != ATTACHMENT_UNUSED
                    && ds_ref.layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL
                    && ds_ref.layout != vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL
                    && map_vk_format(render_pass.attachments[ds_ref.attachment as usize].format).is_some_and(|f| f.order.has_stencil())
                {
                    let attachment_index = ds_ref.attachment as usize;
                    let reference = &mut reference_attachments[attachment_index];
                    for y in pos_a[1]..pos_b[1] {
                        for x in pos_a[0]..pos_b[0] {
                            let at = (x + y * target_size[0] as i32) as usize;
                            reference[at].set_value(1, subpass_ndx % 2 == 0);
                        }
                    }
                }
            }
        }
    }

    reference_attachments
}

/// `verifyColorAttachment`, for `useFormatCompCount == false`.
fn verify_color_attachment(reference: &[PixelValue], result: &ConstPixelBufferAccess<'_>) -> bool {
    let [width, height, _] = result.size();
    let mut ok = true;

    for y in 0..height {
        for x in 0..width {
            let result_color = result.get_pixel(x, y, 0);
            let reference_value = reference[(x + y * width) as usize];

            for comp_ndx in 0..4 {
                if let Some(value) = reference_value.get_value(comp_ndx)
                    && ((value && result_color[comp_ndx] != 1.0) || (!value && result_color[comp_ndx] != 0.0))
                {
                    ok = false;
                }
            }
        }
    }

    ok
}

// ---------------------------------------------------------------------------------
// The test
// ---------------------------------------------------------------------------------

/// `AttachmentResources` - the image, its view, and the buffer its contents are read
/// back into.
struct AttachmentResources<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
    buffer: BufferWithMemory<'a>,
    /// A multisampled attachment cannot be copied to a buffer, so it is resolved into
    /// this single-sampled image first.
    resolve_image: Option<ImageWithMemory<'a>>,
    /// A combined depth/stencil attachment is read back one aspect at a time, so the
    /// stencil aspect gets a buffer of its own.
    secondary_buffer: Option<BufferWithMemory<'a>>,
    aspect: vk::ImageAspectFlags,
    /// `getInputAttachmentViews` - a subpassInput can only read one aspect, so a
    /// combined attachment is bound through two single-aspect views. For everything
    /// else the attachment's own view is the input view.
    depth_input_view: Option<Unique<'a, vk::ImageView>>,
    stencil_input_view: Option<Unique<'a, vk::ImageView>>,
}

/// `RenderPassTestCase`
pub struct RenderPassTestCase {
    name: String,
    config: TestConfig,
}

impl TestCase for RenderPassTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let render_pass_info = &self.config.render_pass;

        if render_pass_info.attachments.iter().any(|a| a.format == vk::Format::A8_UNORM) {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if self.config.render_pass_type == RenderPassType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }

        if self.config.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }

        // `VkRenderPassInputAttachmentAspectCreateInfo` is a maintenance2 structure.
        if !render_pass_info.input_aspects.is_empty() {
            context.require_device_functionality("VK_KHR_maintenance2")?;
        }

        // A multisampled attachment is only usable if the format supports the count.
        let instance = context.get_instance();
        for attachment in &render_pass_info.attachments {
            if attachment.samples == vk::SampleCountFlags::_1 {
                continue;
            }
            let properties = unsafe {
                instance.get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    attachment.format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT,
                    vk::ImageCreateFlags::empty(),
                )
            };
            match properties {
                Ok(props) if props.sample_counts.contains(attachment.samples) => {}
                _ => return Err(TestError::NotSupported("MSAA sample count not supported for format".to_string())),
            }
        }

        // `RenderPassTestCase::checkTextureFormatSupport` - every attachment has to be
        // usable as the kind of attachment the subpasses reference it as.
        for attachment in &render_pass_info.attachments {
            let properties = unsafe { instance.get_physical_device_format_properties(context.get_physical_device(), attachment.format) };
            let format = map_vk_format(attachment.format).ok_or_else(|| TestError::NotPorted(format!("no tcu format for {:?}", attachment.format)))?;

            let required = if format.order.has_depth() || format.order.has_stencil() {
                vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT
            } else {
                vk::FormatFeatureFlags::COLOR_ATTACHMENT
            };

            if !properties.optimal_tiling_features.contains(required) {
                return Err(TestError::NotSupported(format!("format {:?} not supported as an attachment", attachment.format)));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        collection_for(&self.config)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RenderPassTestInstance { context, config: &self.config })
    }
}

/// `RenderPassTestInstance`
struct RenderPassTestInstance<'a> {
    context: &'a Context<'a>,
    config: &'a TestConfig,
}

impl TestInstance for RenderPassTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let config = self.config;
        let render_pass_info = &config.render_pass;
        let mut rng = Random::new(config.seed);

        // `initializeAttachmentIsLazy` with IMAGEMEMORY_STRICT: never lazy.
        let attachment_is_lazy = vec![false; render_pass_info.attachments.len()];

        // `initializeImageClearValues`
        let image_clear_values: Vec<Option<ClearValue>> = render_pass_info
            .attachments
            .iter()
            .zip(&attachment_is_lazy)
            .map(|(attachment, is_lazy)| {
                if *is_lazy {
                    None
                } else {
                    let format = map_vk_format(attachment.format).expect("checked in check_support");
                    Some(ClearValue::random(format, &mut rng))
                }
            })
            .collect();

        let attachment_image_usage = self.initialize_attachment_image_usage(&image_clear_values)?;

        // `initializeRenderPassClearValues`
        let render_pass_clear_values: Vec<Option<ClearValue>> = render_pass_info
            .attachments
            .iter()
            .map(|attachment| {
                if attachment.load_op == vk::AttachmentLoadOp::CLEAR || attachment.stencil_load_op == vk::AttachmentLoadOp::CLEAR {
                    let format = map_vk_format(attachment.format).expect("checked in check_support");
                    Some(ClearValue::random(format, &mut rng))
                } else {
                    None
                }
            })
            .collect();

        let subpass_render_info = initialize_subpass_render_info(&mut rng, render_pass_info, config);

        let device = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        let command_pool = make_command_pool(device, queue_index)?;
        let render_pass = self.create_render_pass()?;

        let mut resources = Vec::new();
        for (attachment_ndx, attachment) in render_pass_info.attachments.iter().enumerate() {
            resources.push(self.create_attachment_resources(attachment, attachment_image_usage[attachment_ndx])?);
        }

        let attachment_views: Vec<vk::ImageView> = resources.iter().map(|r| *r.view).collect();
        let framebuffer = make_framebuffer(device, *render_pass, &attachment_views, config.target_size[0], config.target_size[1], 1)?;

        // One vertex buffer per subpass: each subpass draws its own quad.
        let vertex_buffers: Vec<Option<BufferWithMemory<'_>>> = subpass_render_info
            .iter()
            .map(|info| info.render_quad.map(|quad| self.create_vertex_buffer(quad)).transpose())
            .collect::<Result<_, TestError>>()?;

        // `SubpassRenderer`, one per subpass: its own shaders, descriptor set for any
        // input attachments, pipeline layout and pipeline.
        let mut renderers = Vec::new();
        for (subpass_ndx, subpass) in render_pass_info.subpasses.iter().enumerate() {
            renderers.push(self.create_subpass_renderer(subpass_ndx, subpass, *render_pass, &resources, &subpass_render_info[subpass_ndx])?);
        }

        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *command_buffer)?;
        self.push_image_initialization_commands(*command_buffer, &resources, &image_clear_values);
        self.push_render_pass_commands(
            *command_buffer,
            *render_pass,
            *framebuffer,
            &renderers,
            &vertex_buffers,
            &render_pass_clear_values,
            &subpass_render_info,
        );
        self.push_read_images_to_buffers(*command_buffer, &resources, queue_index);
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        let reference_values = render_reference_values(
            render_pass_info,
            config.target_size,
            &image_clear_values,
            &render_pass_clear_values,
            &subpass_render_info,
            config.render_pos,
            config.render_size,
        );

        let read_back = |buffer: &BufferWithMemory<'_>, format: TextureFormat| -> Result<TextureLevel, TestError> {
            invalidate_alloc(device, buffer.get_allocation())?;
            let mut level = TextureLevel::new(format, config.target_size[0], config.target_size[1], 1)?;
            let len = level.data().len();
            unsafe { std::ptr::copy_nonoverlapping(buffer.get_allocation().get_host_ptr().cast_const(), level.data_mut().as_mut_ptr(), len) };
            Ok(level)
        };

        for (attachment_ndx, attachment) in render_pass_info.attachments.iter().enumerate() {
            let format = map_vk_format(attachment.format).expect("checked in check_support");
            let resource = &resources[attachment_ndx];
            let reference = &reference_values[attachment_ndx];

            if format.order.has_depth() || format.order.has_stencil() {
                // Depth and stencil have their own store ops, so each aspect is
                // verified only if its own said STORE, and a combined format reads
                // each out of its own buffer in its own copy format.
                if format.order.has_depth() && attachment.store_op == vk::AttachmentStoreOp::STORE {
                    let depth_format = if resource.secondary_buffer.is_some() {
                        get_depth_copy_format(attachment.format).expect("checked at creation")
                    } else {
                        format
                    };
                    let level = read_back(&resource.buffer, depth_format)?;
                    if !verify_depth_attachment(reference, &level.get_const_access(), config.depth_values, required_depth_epsilon(attachment.format)) {
                        return Ok(TestStatus::fail("Result verification failed"));
                    }
                }

                if format.order.has_stencil() && attachment.stencil_store_op == vk::AttachmentStoreOp::STORE {
                    let (buffer, stencil_format) = match &resource.secondary_buffer {
                        Some(secondary) => (secondary, get_stencil_copy_format(attachment.format).expect("checked at creation")),
                        None => (&resource.buffer, format),
                    };
                    let level = read_back(buffer, stencil_format)?;
                    if !verify_stencil_attachment(reference, &level.get_const_access()) {
                        return Ok(TestStatus::fail("Result verification failed"));
                    }
                }
            } else if attachment.store_op == vk::AttachmentStoreOp::STORE {
                let level = read_back(&resource.buffer, format)?;
                if !verify_color_attachment(reference, &level.get_const_access()) {
                    return Ok(TestStatus::fail("Result verification failed"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl RenderPassTestInstance<'_> {
    /// `initializeAttachmentImageUsage`
    fn initialize_attachment_image_usage(&self, clear_values: &[Option<ClearValue>]) -> Result<Vec<vk::ImageUsageFlags>, TestError> {
        let render_pass_info = &self.config.render_pass;
        let mut usage = vec![vk::ImageUsageFlags::empty(); render_pass_info.attachments.len()];

        for subpass in &render_pass_info.subpasses {
            for reference in &subpass.color_attachments {
                if reference.attachment != ATTACHMENT_UNUSED {
                    usage[reference.attachment as usize] |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
                }
            }
            if subpass.depth_stencil_attachment.attachment != ATTACHMENT_UNUSED {
                usage[subpass.depth_stencil_attachment.attachment as usize] |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
            }
            for reference in &subpass.input_attachments {
                if reference.attachment != ATTACHMENT_UNUSED {
                    usage[reference.attachment as usize] |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
                }
            }
        }

        let instance = self.context.get_instance();
        let features = self.context.get_device_features();

        for (attachment_ndx, attachment) in render_pass_info.attachments.iter().enumerate() {
            let properties = unsafe { instance.get_physical_device_format_properties(self.context.get_physical_device(), attachment.format) };
            let supported = properties.optimal_tiling_features;

            if supported.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE) {
                usage[attachment_ndx] |= vk::ImageUsageFlags::SAMPLED;
            }

            if supported.contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
                && (attachment.samples == vk::SampleCountFlags::_1 || features.shader_storage_image_multisample == vk::TRUE)
            {
                usage[attachment_ndx] |= vk::ImageUsageFlags::STORAGE;
            }

            usage[attachment_ndx] |= get_image_usage_from_layout(attachment.initial_layout);
            usage[attachment_ndx] |= get_image_usage_from_layout(attachment.final_layout);

            // IMAGEMEMORY_STRICT only, so no attachment is lazy.
            if clear_values[attachment_ndx].is_some() {
                usage[attachment_ndx] |= vk::ImageUsageFlags::TRANSFER_DST;
            }
            usage[attachment_ndx] |= vk::ImageUsageFlags::TRANSFER_SRC;
        }

        Ok(usage)
    }

    /// `createRenderPass`, for the legacy and `VK_KHR_create_renderpass2` entry points.
    ///
    /// Only the legacy structures are filled: `vkCreateRenderPass2` takes the same
    /// description through wider structs, and building both would double this for no
    /// difference in what is tested. The renderpass2 cases go through
    /// `vkCreateRenderPass2` with the same description translated.
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let render_pass_info = &self.config.render_pass;

        let attachments: Vec<vk::AttachmentDescription> = render_pass_info
            .attachments
            .iter()
            .map(|a| vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: a.format,
                samples: a.samples,
                load_op: a.load_op,
                store_op: a.store_op,
                stencil_load_op: a.stencil_load_op,
                stencil_store_op: a.stencil_store_op,
                initial_layout: a.initial_layout,
                final_layout: a.final_layout,
            })
            .collect();

        // The reference arrays have to outlive the subpass descriptions that point at
        // them, so they are built first and borrowed second.
        let to_reference = |r: &AttachmentReference| vk::AttachmentReference {
            attachment: r.attachment,
            layout: r.layout,
        };
        let color_references: Vec<Vec<vk::AttachmentReference>> = render_pass_info.subpasses.iter().map(|s| s.color_attachments.iter().map(to_reference).collect()).collect();
        let input_references: Vec<Vec<vk::AttachmentReference>> = render_pass_info.subpasses.iter().map(|s| s.input_attachments.iter().map(to_reference).collect()).collect();
        let ds_references: Vec<vk::AttachmentReference> = render_pass_info.subpasses.iter().map(|s| to_reference(&s.depth_stencil_attachment)).collect();

        let subpasses: Vec<vk::SubpassDescription> = render_pass_info
            .subpasses
            .iter()
            .enumerate()
            .map(|(ndx, _)| vk::SubpassDescription {
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                input_attachment_count: input_references[ndx].len() as u32,
                input_attachments: input_references[ndx].as_ptr(),
                color_attachment_count: color_references[ndx].len() as u32,
                color_attachments: color_references[ndx].as_ptr(),
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: if render_pass_info.subpasses[ndx].depth_stencil_attachment.attachment == ATTACHMENT_UNUSED {
                    std::ptr::null()
                } else {
                    &ds_references[ndx]
                },
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            })
            .collect();

        let dependencies: Vec<vk::SubpassDependency> = render_pass_info
            .dependencies
            .iter()
            .map(|d| vk::SubpassDependency {
                src_subpass: d.src_pass,
                dst_subpass: d.dst_pass,
                src_stage_mask: d.src_stage_mask,
                dst_stage_mask: d.dst_stage_mask,
                src_access_mask: d.src_access_mask,
                dst_access_mask: d.dst_access_mask,
                dependency_flags: d.flags,
            })
            .collect();

        let aspect_info = vk::RenderPassInputAttachmentAspectCreateInfo {
            s_type: vk::StructureType::RENDER_PASS_INPUT_ATTACHMENT_ASPECT_CREATE_INFO,
            next: std::ptr::null(),
            aspect_reference_count: render_pass_info.input_aspects.len() as u32,
            aspect_references: render_pass_info.input_aspects.as_ptr(),
        };

        let info = vk::RenderPassCreateInfo {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO,
            next: if render_pass_info.input_aspects.is_empty() {
                std::ptr::null()
            } else {
                std::ptr::addr_of!(aspect_info).cast()
            },
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachments.len() as u32,
            attachments: attachments.as_ptr(),
            subpass_count: subpasses.len() as u32,
            subpasses: subpasses.as_ptr(),
            dependency_count: dependencies.len() as u32,
            dependencies: dependencies.as_ptr(),
        };

        let handle = if self.config.render_pass_type == RenderPassType::RenderPass2 {
            self.create_render_pass2(&attachments)?
        } else {
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?
        };

        Ok(Unique::new(device, handle))
    }

    /// The `vkCreateRenderPass2` half of `createRenderPass`.
    fn create_render_pass2(&self, attachments: &[vk::AttachmentDescription]) -> Result<vk::RenderPass, TestError> {
        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let device = self.context.get_device();

        let attachments2: Vec<vk::AttachmentDescription2> = attachments
            .iter()
            .map(|a| vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: a.flags,
                format: a.format,
                samples: a.samples,
                load_op: a.load_op,
                store_op: a.store_op,
                stencil_load_op: a.stencil_load_op,
                stencil_store_op: a.stencil_store_op,
                initial_layout: a.initial_layout,
                final_layout: a.final_layout,
            })
            .collect();

        // `vkCreateRenderPass2` carries the aspect mask on the reference itself, which
        // is why the `use_input_aspect` variants only exist for the legacy path.
        let to_reference2 = |r: &AttachmentReference| vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: r.attachment,
            layout: r.layout,
            aspect_mask: r.aspect_mask,
        };
        let render_pass_info = &self.config.render_pass;
        let color_references2: Vec<Vec<vk::AttachmentReference2>> = render_pass_info.subpasses.iter().map(|s| s.color_attachments.iter().map(to_reference2).collect()).collect();
        let input_references2: Vec<Vec<vk::AttachmentReference2>> = render_pass_info.subpasses.iter().map(|s| s.input_attachments.iter().map(to_reference2).collect()).collect();
        let ds_references2: Vec<vk::AttachmentReference2> = render_pass_info.subpasses.iter().map(|s| to_reference2(&s.depth_stencil_attachment)).collect();

        let subpasses2: Vec<vk::SubpassDescription2> = (0..render_pass_info.subpasses.len())
            .map(|ndx| vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: input_references2[ndx].len() as u32,
                input_attachments: input_references2[ndx].as_ptr(),
                color_attachment_count: color_references2[ndx].len() as u32,
                color_attachments: color_references2[ndx].as_ptr(),
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: if render_pass_info.subpasses[ndx].depth_stencil_attachment.attachment == ATTACHMENT_UNUSED {
                    std::ptr::null()
                } else {
                    &ds_references2[ndx]
                },
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            })
            .collect();

        let dependencies2: Vec<vk::SubpassDependency2> = render_pass_info
            .dependencies
            .iter()
            .map(|d| vk::SubpassDependency2 {
                s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                next: std::ptr::null(),
                src_subpass: d.src_pass,
                dst_subpass: d.dst_pass,
                src_stage_mask: d.src_stage_mask,
                dst_stage_mask: d.dst_stage_mask,
                src_access_mask: d.src_access_mask,
                dst_access_mask: d.dst_access_mask,
                dependency_flags: d.flags,
                view_offset: 0,
            })
            .collect();

        let info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachments2.len() as u32,
            attachments: attachments2.as_ptr(),
            subpass_count: subpasses2.len() as u32,
            subpasses: subpasses2.as_ptr(),
            dependency_count: dependencies2.len() as u32,
            dependencies: dependencies2.as_ptr(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };

        unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")
    }

    /// `AttachmentResources`
    fn create_attachment_resources(&self, attachment: &Attachment, usage: vk::ImageUsageFlags) -> Result<AttachmentResources<'_>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let target_size = self.config.target_size;
        let format = map_vk_format(attachment.format).expect("checked in check_support");
        let aspect = attachment_aspect(format);

        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: attachment.format,
            extent: vk::Extent3D {
                width: target_size[0],
                height: target_size[1],
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: attachment.samples,
            tiling: vk::ImageTiling::OPTIMAL,
            usage,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        let image = if self.config.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?
        };

        let view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            attachment.format,
            make_image_subresource_range(aspect, 0, 1, 0, 1),
        )?;

        // The readback format is not always the attachment's: a combined depth/stencil
        // attachment is copied out one aspect at a time, and each aspect has its own.
        let make_buffer = |format: TextureFormat| -> Result<BufferWithMemory<'_>, TestError> {
            let pixel_size = format.pixel_size().ok_or_else(|| TestError::NotPorted(format!("no pixel size for {format:?}")))? as u64;
            let buffer_size = pixel_size * u64::from(target_size[0]) * u64::from(target_size[1]);
            BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )
        };

        let (buffer, secondary_buffer) = if format.order.has_depth() && format.order.has_stencil() {
            let depth_format = get_depth_copy_format(attachment.format).ok_or_else(|| TestError::NotPorted("no depth copy format".to_string()))?;
            let stencil_format = get_stencil_copy_format(attachment.format).ok_or_else(|| TestError::NotPorted("no stencil copy format".to_string()))?;
            (make_buffer(depth_format)?, Some(make_buffer(stencil_format)?))
        } else {
            (make_buffer(format)?, None)
        };

        let (depth_input_view, stencil_input_view) = if format.order.has_depth() && format.order.has_stencil() {
            (
                Some(make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    attachment.format,
                    make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
                )?),
                Some(make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    attachment.format,
                    make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1),
                )?),
            )
        } else {
            (None, None)
        };

        let resolve_image = if attachment.samples == vk::SampleCountFlags::_1 {
            None
        } else {
            let info = vk::ImageCreateInfo {
                samples: vk::SampleCountFlags::_1,
                ..image_info
            };
            Some(if self.config.allocation_kind == AllocationKind::Dedicated {
                ImageWithMemory::new_dedicated(device, allocator, info, MemoryRequirement::ANY)?
            } else {
                ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?
            })
        };

        Ok(AttachmentResources {
            image,
            view,
            buffer,
            resolve_image,
            secondary_buffer,
            aspect,
            depth_input_view,
            stencil_input_view,
        })
    }

    fn create_vertex_buffer(&self, quad: RenderQuad) -> Result<BufferWithMemory<'_>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let vertices = quad.vertices();
        let bytes: Vec<u8> = vertices.iter().flat_map(|v| v.iter().flat_map(|f| f.to_ne_bytes())).collect();

        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(bytes.len() as u64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
        crate::vk::mem_util::flush_alloc(device, buffer.get_allocation())?;
        Ok(buffer)
    }
}

/// `getImageUsageFromLayout`
fn get_image_usage_from_layout(layout: vk::ImageLayout) -> vk::ImageUsageFlags {
    match layout {
        vk::ImageLayout::GENERAL | vk::ImageLayout::PREINITIALIZED => vk::ImageUsageFlags::empty(),
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL => vk::ImageUsageFlags::COLOR_ATTACHMENT,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL | vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL => vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL => vk::ImageUsageFlags::SAMPLED,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL => vk::ImageUsageFlags::TRANSFER_SRC,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL => vk::ImageUsageFlags::TRANSFER_DST,
        _ => vk::ImageUsageFlags::empty(),
    }
}

impl RenderPassTestInstance<'_> {
    /// `SubpassRenderer`'s pipeline. One vertex attribute, no blending, a viewport
    /// covering the whole target and a scissor covering the subpass's viewport.
    fn create_pipeline(
        &self,
        layout: vk::PipelineLayout,
        vertex_module: vk::ShaderModule,
        fragment_module: vk::ShaderModule,
        render_pass: vk::RenderPass,
        subpass_ndx: usize,
        subpass: &Subpass,
        render_info: &SubpassRenderInfo,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let entry = c"main";

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vertex_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(fragment_module)
                .name(entry.to_bytes_with_nul())
                .build(),
        ];

        let binding = vk::VertexInputBindingDescription::builder()
            .binding(0)
            .stride(std::mem::size_of::<[f32; 2]>() as u32)
            .input_rate(vk::VertexInputRate::VERTEX)
            .build();
        let attribute = vk::VertexInputAttributeDescription::builder()
            .location(0)
            .binding(0)
            .format(vk::Format::R32G32_SFLOAT)
            .offset(0)
            .build();
        let bindings = [binding];
        let attributes = [attribute];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);

        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);

        let viewports = [vk::Viewport {
            x: render_info.viewport_offset[0] as f32,
            y: render_info.viewport_offset[1] as f32,
            width: render_info.viewport_size[0] as f32,
            height: render_info.viewport_size[1] as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D {
                x: render_info.viewport_offset[0] as i32,
                y: render_info.viewport_offset[1] as i32,
            },
            extent: vk::Extent2D {
                width: render_info.viewport_size[0],
                height: render_info.viewport_size[1],
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);

        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);

        // Every colour attachment a subpass writes has the same sample count here, so
        // the first one settles the rasterisation sample count.
        let samples = subpass
            .color_attachments
            .first()
            .map_or(vk::SampleCountFlags::_1, |r| self.config.render_pass.attachments[r.attachment as usize].samples);
        let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(samples);

        let blend_attachments = vec![vk::PipelineColorBlendAttachmentState::builder().color_write_mask(vk::ColorComponentFlags::all()).build(); subpass.color_attachments.len()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        // `writeDepth` / `writeStencil` - the read-only layouts turn each off.
        let ds_layout = (subpass.depth_stencil_attachment.attachment != ATTACHMENT_UNUSED).then_some(subpass.depth_stencil_attachment.layout);
        let write_depth = ds_layout.is_some_and(|l| l != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && l != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL);
        let write_stencil = ds_layout.is_some_and(|l| l != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && l != vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL);
        let stencil_op = if write_stencil { vk::StencilOp::REPLACE } else { vk::StencilOp::KEEP };
        let stencil_state = vk::StencilOpState {
            fail_op: stencil_op,
            pass_op: stencil_op,
            depth_fail_op: stencil_op,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: !0,
            write_mask: !0,
            reference: if subpass_ndx.is_multiple_of(2) { !0 } else { 0 },
        };
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(write_depth)
            .depth_write_enable(write_depth)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(write_stencil)
            .front(stencil_state)
            .back(stencil_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(subpass_ndx as u32);

        let pipeline = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?
            .0[0];
        Ok(Unique::new(device, pipeline))
    }

    /// `pushImageInitializationCommands`
    fn push_image_initialization_commands(&self, command_buffer: vk::CommandBuffer, resources: &[AttachmentResources<'_>], clear_values: &[Option<ClearValue>]) {
        let device = self.context.get_device();
        let render_pass_info = &self.config.render_pass;

        let to_transfer_dst: Vec<vk::ImageMemoryBarrier> = resources
            .iter()
            .zip(clear_values)
            .filter(|(_, clear)| clear.is_some())
            .map(|(resource, _)| {
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    resource.image.get(),
                    make_image_subresource_range(resource.aspect, 0, 1, 0, 1),
                )
            })
            .collect();

        if !to_transfer_dst.is_empty() {
            unsafe {
                device.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &to_transfer_dst,
                );
            }
        }

        for (attachment_ndx, (resource, clear)) in resources.iter().zip(clear_values).enumerate() {
            let Some(clear) = clear else { continue };
            let format = map_vk_format(render_pass_info.attachments[attachment_ndx].format).expect("checked in check_support");
            let range = make_image_subresource_range(resource.aspect, 0, 1, 0, 1);
            unsafe {
                if format.order.has_depth() || format.order.has_stencil() {
                    let value = clear.to_vk_depth_stencil(self.config.depth_values);
                    device.cmd_clear_depth_stencil_image(command_buffer, resource.image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &value, &[range]);
                } else {
                    device.cmd_clear_color_image(command_buffer, resource.image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &clear.to_vk(format), &[range]);
                }
            }
        }

        // Every attachment ends up in its initial layout, whether it was cleared or not.
        let to_initial: Vec<vk::ImageMemoryBarrier> = resources
            .iter()
            .zip(clear_values)
            .enumerate()
            .map(|(attachment_ndx, (resource, clear))| {
                let (src_access, old_layout) = if clear.is_some() {
                    (vk::AccessFlags::TRANSFER_WRITE, vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                } else {
                    (vk::AccessFlags::empty(), vk::ImageLayout::UNDEFINED)
                };
                make_image_memory_barrier(
                    src_access,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ
                        | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
                        | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    old_layout,
                    render_pass_info.attachments[attachment_ndx].initial_layout,
                    resource.image.get(),
                    make_image_subresource_range(resource.aspect, 0, 1, 0, 1),
                )
            })
            .collect();

        unsafe {
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &to_initial,
            );
        }
    }

    /// `pushRenderPassCommands`, inline contents only.
    fn push_render_pass_commands(
        &self,
        command_buffer: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
        renderers: &[SubpassRenderer<'_>],
        vertex_buffers: &[Option<BufferWithMemory<'_>>],
        render_pass_clear_values: &[Option<ClearValue>],
        subpass_render_info: &[SubpassRenderInfo],
    ) {
        let device = self.context.get_device();
        let config = self.config;
        let render_pass_info = &config.render_pass;

        let clear_values: Vec<vk::ClearValue> = render_pass_info
            .attachments
            .iter()
            .enumerate()
            .map(|(ndx, attachment)| match render_pass_clear_values[ndx] {
                Some(clear) => {
                    let format = map_vk_format(attachment.format).expect("checked in check_support");
                    if format.order.has_depth() || format.order.has_stencil() {
                        vk::ClearValue {
                            depth_stencil: clear.to_vk_depth_stencil(config.depth_values),
                        }
                    } else {
                        vk::ClearValue { color: clear.to_vk(format) }
                    }
                }
                None => vk::ClearValue {
                    color: vk::ClearColorValue { float32: [0.0; 4] },
                },
            })
            .collect();

        let render_area = vk::Rect2D {
            offset: vk::Offset2D {
                x: config.render_pos[0] as i32,
                y: config.render_pos[1] as i32,
            },
            extent: vk::Extent2D {
                width: config.render_size[0],
                height: config.render_size[1],
            },
        };

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(render_area)
            .clear_values(&clear_values);

        unsafe {
            device.cmd_begin_render_pass(command_buffer, &begin_info, vk::SubpassContents::INLINE);
        }

        for (subpass_ndx, render_info) in subpass_render_info.iter().enumerate() {
            if subpass_ndx > 0 {
                unsafe { device.cmd_next_subpass(command_buffer, vk::SubpassContents::INLINE) };
            }

            let subpass = &render_pass_info.subpasses[subpass_ndx];

            if !render_info.color_clears.is_empty() {
                let attachments: Vec<vk::ClearAttachment> = render_info
                    .color_clears
                    .iter()
                    .enumerate()
                    .map(|(ndx, clear)| {
                        let attachment_index = subpass.color_attachments[ndx].attachment as usize;
                        let format = map_vk_format(render_pass_info.attachments[attachment_index].format).expect("checked in check_support");
                        vk::ClearAttachment {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            color_attachment: ndx as u32,
                            clear_value: vk::ClearValue { color: clear.color.to_vk(format) },
                        }
                    })
                    .collect();
                let rects: Vec<vk::ClearRect> = render_info
                    .color_clears
                    .iter()
                    .map(|clear| vk::ClearRect {
                        rect: vk::Rect2D {
                            offset: vk::Offset2D {
                                x: clear.offset[0] as i32,
                                y: clear.offset[1] as i32,
                            },
                            extent: vk::Extent2D {
                                width: clear.size[0],
                                height: clear.size[1],
                            },
                        },
                        base_array_layer: 0,
                        layer_count: 1,
                    })
                    .collect();
                unsafe { device.cmd_clear_attachments(command_buffer, &attachments, &rects) };
            }

            if let Some(DepthStencilClear { offset, size, value: clear }) = render_info.depth_stencil_clear {
                let attachment_index = subpass.depth_stencil_attachment.attachment as usize;
                let format = map_vk_format(render_pass_info.attachments[attachment_index].format).expect("checked in check_support");
                let layout = subpass.depth_stencil_attachment.layout;

                let mut aspect_mask = vk::ImageAspectFlags::empty();
                if format.order.has_depth() && layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL {
                    aspect_mask |= vk::ImageAspectFlags::DEPTH;
                }
                if format.order.has_stencil() && layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && layout != vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL
                {
                    aspect_mask |= vk::ImageAspectFlags::STENCIL;
                }

                if !aspect_mask.is_empty() {
                    let attachments = [vk::ClearAttachment {
                        aspect_mask,
                        color_attachment: 0,
                        clear_value: vk::ClearValue {
                            depth_stencil: clear.to_vk_depth_stencil(config.depth_values),
                        },
                    }];
                    let rects = [vk::ClearRect {
                        rect: vk::Rect2D {
                            offset: vk::Offset2D {
                                x: offset[0] as i32,
                                y: offset[1] as i32,
                            },
                            extent: vk::Extent2D { width: size[0], height: size[1] },
                        },
                        base_array_layer: 0,
                        layer_count: 1,
                    }];
                    unsafe { device.cmd_clear_attachments(command_buffer, &attachments, &rects) };
                }
            }

            if render_info.render_quad.is_some()
                && let Some(vertex_buffer) = vertex_buffers[subpass_ndx].as_ref()
            {
                let renderer = &renderers[subpass_ndx];
                unsafe {
                    device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, *renderer.pipeline);
                    if let Some(set) = &renderer.descriptor_set {
                        device.cmd_bind_descriptor_sets(command_buffer, vk::PipelineBindPoint::GRAPHICS, *renderer.pipeline_layout, 0, &[**set], &[]);
                    }
                    device.cmd_bind_vertex_buffers(command_buffer, 0, &[vertex_buffer.get()], &[0]);
                    device.cmd_draw(command_buffer, 6, 1, 0, 0);
                }
            }
        }

        unsafe { device.cmd_end_render_pass(command_buffer) };
    }

    /// `pushReadImagesToBuffers`
    fn push_read_images_to_buffers(&self, command_buffer: vk::CommandBuffer, resources: &[AttachmentResources<'_>], queue_index: u32) {
        let device = self.context.get_device();
        let render_pass_info = &self.config.render_pass;
        let target_size = self.config.target_size;

        let to_transfer_src: Vec<vk::ImageMemoryBarrier> = resources
            .iter()
            .enumerate()
            .map(|(attachment_ndx, resource)| {
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    render_pass_info.attachments[attachment_ndx].final_layout,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    resource.image.get(),
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                )
            })
            .collect();

        unsafe {
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &to_transfer_src,
            );
        }

        for resource in resources {
            let source = match &resource.resolve_image {
                Some(resolve) => {
                    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
                    let pre = make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        resolve.get(),
                        range,
                    );
                    let layers = vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level: 0,
                        base_array_layer: 0,
                        layer_count: 1,
                    };
                    let resolve_region = vk::ImageResolve {
                        src_subresource: layers,
                        src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        dst_subresource: layers,
                        dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        extent: vk::Extent3D {
                            width: target_size[0],
                            height: target_size[1],
                            depth: 1,
                        },
                    };
                    let post = make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        resolve.get(),
                        range,
                    );
                    unsafe {
                        device.cmd_pipeline_barrier(
                            command_buffer,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[pre],
                        );
                        device.cmd_resolve_image(
                            command_buffer,
                            resource.image.get(),
                            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                            resolve.get(),
                            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                            &[resolve_region],
                        );
                        device.cmd_pipeline_barrier(
                            command_buffer,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[post],
                        );
                    }
                    resolve.get()
                }
                None => resource.image.get(),
            };
            // A combined depth/stencil attachment is copied one aspect at a time, into
            // its own buffer; everything else is one copy of its single aspect.
            let copies: Vec<(vk::ImageAspectFlags, vk::Buffer)> = match &resource.secondary_buffer {
                Some(secondary) => vec![(vk::ImageAspectFlags::DEPTH, resource.buffer.get()), (vk::ImageAspectFlags::STENCIL, secondary.get())],
                None => vec![(resource.aspect, resource.buffer.get())],
            };

            for (aspect_mask, buffer) in copies {
                let region = vk::BufferImageCopy {
                    buffer_offset: 0,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask,
                        mip_level: 0,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width: target_size[0],
                        height: target_size[1],
                        depth: 1,
                    },
                };
                unsafe {
                    device.cmd_copy_image_to_buffer(command_buffer, source, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]);
                }
            }
        }

        let to_host: Vec<vk::BufferMemoryBarrier> = resources
            .iter()
            .flat_map(|resource| {
                std::iter::once(resource.buffer.get())
                    .chain(resource.secondary_buffer.as_ref().map(|b| b.get()))
                    .map(move |buffer| {
                        vk::BufferMemoryBarrier::builder()
                            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                            .dst_access_mask(vk::AccessFlags::HOST_READ)
                            .src_queue_family_index(queue_index)
                            .dst_queue_family_index(queue_index)
                            .buffer(buffer)
                            .offset(0)
                            .size(vk::WHOLE_SIZE)
                            .build()
                    })
            })
            .collect();

        unsafe {
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &to_host,
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
}

/// `s_coreColorFormats`, paired with `formatToName`.
pub static CORE_COLOR_FORMATS: &[(vk::Format, &str)] = &[
    (vk::Format::R5G6B5_UNORM_PACK16, "r5g6b5_unorm_pack16"),
    (vk::Format::R8_UNORM, "r8_unorm"),
    (vk::Format::R8_SNORM, "r8_snorm"),
    (vk::Format::R8_UINT, "r8_uint"),
    (vk::Format::R8_SINT, "r8_sint"),
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
    // `colorFormatsToTest.push_back(VK_FORMAT_A8_UNORM_KHR)` - appended to the core
    // list rather than part of it, and absent under VulkanSC.
    (vk::Format::A8_UNORM, "a8_unorm"),
];

/// `addFormatTests`, colour formats only - the `input` branch needs input attachments
/// and is not ported.
fn add_format_tests(group: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind, render_pass_type: RenderPassType) {
    const TARGET_SIZE: [u32; 2] = [64, 64];
    const RENDER_POS: [u32; 2] = [0, 0];
    const RENDER_SIZE: [u32; 2] = [64, 64];

    let load_ops = [
        ("clear", vk::AttachmentLoadOp::CLEAR),
        ("load", vk::AttachmentLoadOp::LOAD),
        ("dont_care", vk::AttachmentLoadOp::DONT_CARE),
    ];
    let render_types = [
        ("clear", RenderTypes::CLEAR),
        ("draw", RenderTypes::DRAW),
        ("clear_draw", RenderTypes::CLEAR.or(RenderTypes::DRAW)),
    ];

    for &(format, format_name) in CORE_COLOR_FORMATS {
        let mut format_group = tcu::TestCaseGroup::new(format_name);

        for (load_op_name, load_op) in load_ops {
            let mut load_op_group = tcu::TestCaseGroup::new(load_op_name);

            for (render_type_name, render_type) in render_types {
                let render_pass = RenderPassDesc {
                    attachments: vec![Attachment {
                        format,
                        samples: vk::SampleCountFlags::_1,
                        load_op,
                        store_op: vk::AttachmentStoreOp::STORE,
                        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                        initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    }],
                    subpasses: vec![Subpass {
                        input_attachments: Vec::new(),
                        color_attachments: vec![AttachmentReference::new(0, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)],
                        depth_stencil_attachment: AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
                    }],
                    dependencies: Vec::new(),
                    input_aspects: Vec::new(),
                };

                let config = TestConfig::new(
                    render_pass,
                    render_type,
                    TARGET_SIZE,
                    RENDER_POS,
                    RENDER_SIZE,
                    false,
                    90239,
                    allocation_kind,
                    render_pass_type,
                );

                load_op_group.add_child(Box::new(RenderPassTestCase {
                    name: render_type_name.to_string(),
                    config,
                }) as Box<dyn TestCase>);
            }

            format_group.add_child(load_op_group);
        }

        add_format_input_tests(&mut format_group, format, allocation_kind, render_pass_type);

        group.add_child(format_group);
    }
}

/// The `input` branch of `addFormatTests`, without the `self_dep_*` variants: two
/// subpasses, the second reading the first's attachment back and writing what it found
/// into a second, always-R8G8B8A8_UNORM attachment.
fn add_format_input_tests(format_group: &mut tcu::TestCaseGroup, format: vk::Format, allocation_kind: AllocationKind, render_pass_type: RenderPassType) {
    const TARGET_SIZE: [u32; 2] = [64, 64];
    const RENDER_POS: [u32; 2] = [0, 0];
    const RENDER_SIZE: [u32; 2] = [64, 64];

    let load_ops = [
        ("clear", vk::AttachmentLoadOp::CLEAR),
        ("load", vk::AttachmentLoadOp::LOAD),
        ("dont_care", vk::AttachmentLoadOp::DONT_CARE),
    ];
    let store_ops = [("store", vk::AttachmentStoreOp::STORE), ("dont_care", vk::AttachmentStoreOp::DONT_CARE)];
    let render_types = [
        ("clear", RenderTypes::CLEAR),
        ("draw", RenderTypes::DRAW),
        ("clear_draw", RenderTypes::CLEAR.or(RenderTypes::DRAW)),
    ];

    // renderpass2 puts the aspect on the reference itself, so it has no separate
    // COLOR aspect mask to set and no `_use_input_aspect` variants.
    let input_attachment_aspect_mask = if render_pass_type == RenderPassType::RenderPass2 {
        vk::ImageAspectFlags::COLOR
    } else {
        vk::ImageAspectFlags::empty()
    };

    let mut input_group = tcu::TestCaseGroup::new("input");

    for (load_op_name, load_op) in load_ops {
        let mut load_op_group = tcu::TestCaseGroup::new(load_op_name);

        for (store_op_name, store_op) in store_ops {
            let mut store_op_group = tcu::TestCaseGroup::new(store_op_name);

            for use_input_aspect in [false, true] {
                if render_pass_type != RenderPassType::Legacy && use_input_aspect {
                    continue;
                }

                for (render_type_name, render_type) in render_types {
                    add_self_dep_cases(
                        &mut store_op_group,
                        format,
                        load_op,
                        store_op,
                        render_type,
                        render_type_name,
                        use_input_aspect,
                        input_attachment_aspect_mask,
                        allocation_kind,
                        render_pass_type,
                    );

                    let attachments = vec![
                        Attachment {
                            format,
                            samples: vk::SampleCountFlags::_1,
                            load_op,
                            store_op,
                            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                            initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        },
                        Attachment {
                            format: vk::Format::R8G8B8A8_UNORM,
                            samples: vk::SampleCountFlags::_1,
                            load_op: vk::AttachmentLoadOp::DONT_CARE,
                            store_op: vk::AttachmentStoreOp::STORE,
                            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                            initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        },
                    ];

                    let subpasses = vec![
                        Subpass {
                            input_attachments: Vec::new(),
                            color_attachments: vec![AttachmentReference::new(0, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)],
                            depth_stencil_attachment: AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
                        },
                        Subpass {
                            input_attachments: vec![AttachmentReference::with_aspect(0, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL, input_attachment_aspect_mask)],
                            color_attachments: vec![AttachmentReference::new(1, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)],
                            depth_stencil_attachment: AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
                        },
                    ];

                    let dependencies = vec![SubpassDependency {
                        src_pass: 0,
                        dst_pass: 1,
                        src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                        src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                        flags: vk::DependencyFlags::BY_REGION,
                    }];

                    let input_aspects = if use_input_aspect {
                        vec![vk::InputAttachmentAspectReference {
                            subpass: 1,
                            input_attachment_index: 0,
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                        }]
                    } else {
                        Vec::new()
                    };

                    let render_pass = RenderPassDesc {
                        attachments,
                        subpasses,
                        dependencies,
                        input_aspects,
                    };

                    let config = TestConfig::new(
                        render_pass,
                        render_type,
                        TARGET_SIZE,
                        RENDER_POS,
                        RENDER_SIZE,
                        false,
                        89246,
                        allocation_kind,
                        render_pass_type,
                    );

                    let name = format!("{render_type_name}{}", if use_input_aspect { "_use_input_aspect" } else { "" });
                    store_op_group.add_child(Box::new(RenderPassTestCase { name, config }) as Box<dyn TestCase>);
                }
            }

            load_op_group.add_child(store_op_group);
        }

        input_group.add_child(load_op_group);
    }

    format_group.add_child(input_group);
}

/// `createRenderPassTests`, restricted to the `formats` colour cases.
///
/// One group per rendering type, which is how upstream splits `renderpass1` from
/// `renderpass2`: the same descriptions built through `vkCreateRenderPass` and
/// `vkCreateRenderPass2KHR`.
pub fn create_render_pass_groups() -> Vec<tcu::TestCaseGroup> {
    [("renderpass1", RenderPassType::Legacy), ("renderpass2", RenderPassType::RenderPass2)]
        .into_iter()
        .map(|(name, render_pass_type)| {
            let mut group = tcu::TestCaseGroup::new(name);
            for (kind_name, allocation_kind) in [("suballocation", AllocationKind::Suballocated), ("dedicated_allocation", AllocationKind::Dedicated)] {
                let mut kind_group = tcu::TestCaseGroup::new(kind_name);
                let mut formats = tcu::TestCaseGroup::new("formats");
                add_format_tests(&mut formats, allocation_kind, render_pass_type);
                add_depth_stencil_format_tests(&mut formats, allocation_kind, render_pass_type);
                kind_group.add_child(formats);
                // Upstream registers this once per rendering type, under the
                // suballocation group; it does not vary with the allocation kind.
                if allocation_kind == AllocationKind::Suballocated {
                    kind_group.add_child(super::unused_clear_attachment_tests::create_unused_clear_attachment_tests(render_pass_type));
                }
                group.add_child(kind_group);
            }
            group
        })
        .collect()
}

/// `SubpassRenderer` - the per-subpass pipeline and the descriptor set that binds its
/// input attachments.
struct SubpassRenderer<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    descriptor_set: Option<UniqueDescriptorSet<'a>>,
    // Kept alive for as long as the pipeline and set that reference them.
    _descriptor_set_layout: Option<Unique<'a, vk::DescriptorSetLayout>>,
    _descriptor_pool: Option<Unique<'a, vk::DescriptorPool>>,
    _vertex_module: Unique<'a, vk::ShaderModule>,
    _fragment_module: Unique<'a, vk::ShaderModule>,
}

/// The depth/stencil family, for a subpass whose only attachment is depth/stencil.
/// `None` when the case has a colour attachment and therefore uses the other family.
fn depth_programs_for(config: &TestConfig) -> Option<&'static DepthProgram> {
    let subpass = config.render_pass.subpasses.first()?;
    if !subpass.color_attachments.is_empty() || subpass.depth_stencil_attachment.attachment == ATTACHMENT_UNUSED {
        return None;
    }

    let layout = subpass.depth_stencil_attachment.layout;
    let write_depth = layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL;

    // The two depth values the shader bakes in are whichever pair the config's shuffle
    // produced, so the lookup is by value rather than by reproducing the shuffle.
    let (depth_true, depth_false) = if write_depth {
        (u32::from(config.depth_values[1]), u32::from(config.depth_values[0]))
    } else {
        (0, 0)
    };

    ALL_DEPTH_PROGRAMS
        .iter()
        .copied()
        .find(|p| p.write_depth == write_depth && p.depth_true == depth_true && p.depth_false == depth_false)
}

/// `createSubpassShaders` for the colour families, keyed off the description.
fn programs_for_config(config: &TestConfig) -> &'static InputProgram {
    {
        let render_pass_info = &config.render_pass;
        let format = map_vk_format(render_pass_info.attachments[0].format).expect("checked in check_support");
        let class = match format.channel_class() {
            TextureChannelClass::SignedInteger => "sint",
            TextureChannelClass::UnsignedInteger => "uint",
            _ => "float",
        };
        let input_count = get_shader_num_channels(format.order) as u32;

        // A self-dependency subpass writes the attachment it reads, so its output is
        // the source format; the two-subpass form always writes R8G8B8A8_UNORM.
        let reading_subpass = render_pass_info.subpasses.iter().find(|s| !s.input_attachments.is_empty());
        let (output_count, output_attachment_index, multisample) = match reading_subpass {
            Some(subpass) => {
                let output_index = subpass.color_attachments[0].attachment;
                let output_format = map_vk_format(render_pass_info.attachments[output_index as usize].format).expect("checked in check_support");
                let input_index = subpass.input_attachments[0].attachment as usize;
                (
                    get_shader_num_channels(output_format.order) as u32,
                    output_index,
                    render_pass_info.attachments[input_index].samples != vk::SampleCountFlags::_1,
                )
            }
            // No subpass reads anything; any entry carries the grid shader this needs.
            None => (4, 1, false),
        };

        let program = ALL_INPUT_PROGRAMS
            .iter()
            .copied()
            .find(|p| {
                p.input_channel_class == class
                    && p.input_component_count == input_count
                    && p.output_component_count == output_count
                    && p.output_attachment_index == output_attachment_index
                    && p.multisample == multisample
            })
            .expect("the generator covers every format in CORE_COLOR_FORMATS");

        debug_assert_eq!(program.attachment_type, attachment_type_name(format));
        program
    }
}

impl<'a> RenderPassTestInstance<'a> {
    fn create_subpass_renderer(
        &'a self,
        subpass_ndx: usize,
        subpass: &Subpass,
        render_pass: vk::RenderPass,
        resources: &[AttachmentResources<'_>],
        render_info: &SubpassRenderInfo,
    ) -> Result<SubpassRenderer<'a>, TestError> {
        let device = self.context.get_device();

        // A depth/stencil-only subpass takes its shaders from the other family: no
        // colour output, and gl_FragDepth instead.
        let collection = collection_for(self.config);
        let vertex_module = create_shader_module(device, collection.get(&format!("{subpass_ndx}-vert"))?)?;
        let fragment_module = create_shader_module(device, collection.get(&format!("{subpass_ndx}-frag"))?)?;

        let (descriptor_set_layout, descriptor_pool, descriptor_set) = if subpass.input_attachments.is_empty() {
            (None, None, None)
        } else {
            // A depth/stencil attachment can contribute two bindings - one per aspect
            // the layout leaves readable - where a colour attachment contributes one.
            let image_infos: Vec<vk::DescriptorImageInfo> = subpass
                .input_attachments
                .iter()
                .flat_map(|r| {
                    let resource = &resources[r.attachment as usize];
                    let format = map_vk_format(self.config.render_pass.attachments[r.attachment as usize].format).expect("checked in check_support");
                    let mut views = Vec::new();

                    if format.order.has_depth() || format.order.has_stencil() {
                        if format.order.has_depth() && r.layout != vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL {
                            views.push(resource.depth_input_view.as_ref().map_or(*resource.view, |v| **v));
                        }
                        if format.order.has_stencil() && r.layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL {
                            views.push(resource.stencil_input_view.as_ref().map_or(*resource.view, |v| **v));
                        }
                    } else {
                        views.push(*resource.view);
                    }

                    views.into_iter().map(move |image_view| vk::DescriptorImageInfo {
                        sampler: vk::Sampler::null(),
                        image_view,
                        image_layout: r.layout,
                    })
                })
                .collect();

            let mut builder = DescriptorSetLayoutBuilder::new();
            for _ in &image_infos {
                builder = builder.add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
            }
            let layout = builder.build(device)?;
            let pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::INPUT_ATTACHMENT, image_infos.len() as u32)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set = make_descriptor_set(device, *pool, *layout)?;
            let writes: Vec<vk::WriteDescriptorSet> = image_infos
                .iter()
                .enumerate()
                .map(|(binding, info)| {
                    vk::WriteDescriptorSet::builder()
                        .dst_set(*set)
                        .dst_binding(binding as u32)
                        .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                        .image_info(std::slice::from_ref(info))
                        .build()
                })
                .collect();
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

            (Some(layout), Some(pool), Some(set))
        };

        let set_layouts: Vec<vk::DescriptorSetLayout> = descriptor_set_layout.iter().map(|l| **l).collect();
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;
        let pipeline = self.create_pipeline(*pipeline_layout, *vertex_module, *fragment_module, render_pass, subpass_ndx, subpass, render_info)?;

        Ok(SubpassRenderer {
            pipeline,
            pipeline_layout,
            descriptor_set,
            _descriptor_set_layout: descriptor_set_layout,
            _descriptor_pool: descriptor_pool,
            _vertex_module: vertex_module,
            _fragment_module: fragment_module,
        })
    }
}

/// The `self_dep_*` half of the `input` branch: one attachment, read and written by
/// the same subpass through a self-dependency, in both sample counts.
#[allow(clippy::too_many_arguments)]
fn add_self_dep_cases(
    store_op_group: &mut tcu::TestCaseGroup,
    format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    render_type: RenderTypes,
    render_type_name: &str,
    use_input_aspect: bool,
    input_attachment_aspect_mask: vk::ImageAspectFlags,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
) {
    const TARGET_SIZE: [u32; 2] = [64, 64];
    const RENDER_POS: [u32; 2] = [0, 0];
    const RENDER_SIZE: [u32; 2] = [64, 64];

    let sample_counts = [("", vk::SampleCountFlags::_1), ("_ms", vk::SampleCountFlags::_4)];

    for (sample_suffix, sample_count) in sample_counts {
        let attachments = vec![Attachment {
            format,
            samples: sample_count,
            load_op,
            store_op,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];

        let subpasses = vec![
            Subpass {
                input_attachments: Vec::new(),
                color_attachments: vec![AttachmentReference::new(0, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)],
                depth_stencil_attachment: AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
            },
            // Reads and writes the same attachment, which is why both references are
            // GENERAL and why the dependency below is 1 -> 1.
            Subpass {
                input_attachments: vec![AttachmentReference::with_aspect(0, vk::ImageLayout::GENERAL, input_attachment_aspect_mask)],
                color_attachments: vec![AttachmentReference::new(0, vk::ImageLayout::GENERAL)],
                depth_stencil_attachment: AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
            },
        ];

        let dependency = |src_pass, dst_pass| SubpassDependency {
            src_pass,
            dst_pass,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
            flags: vk::DependencyFlags::BY_REGION,
        };
        let dependencies = vec![dependency(0, 1), dependency(1, 1)];

        let input_aspects = if use_input_aspect {
            vec![vk::InputAttachmentAspectReference {
                subpass: 1,
                input_attachment_index: 0,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            }]
        } else {
            Vec::new()
        };

        let render_pass = RenderPassDesc {
            attachments,
            subpasses,
            dependencies,
            input_aspects,
        };

        let config = TestConfig::new(
            render_pass,
            render_type,
            TARGET_SIZE,
            RENDER_POS,
            RENDER_SIZE,
            false,
            89246,
            allocation_kind,
            render_pass_type,
        );

        let name = format!("self_dep_{render_type_name}{}{sample_suffix}", if use_input_aspect { "_use_input_aspect" } else { "" });
        store_op_group.add_child(Box::new(RenderPassTestCase { name, config }) as Box<dyn TestCase>);
    }
}

/// `clearReferenceValues` / `markUndefined` restricted to one channel, which is what
/// the depth/stencil paths need: depth and stencil have separate load ops and separate
/// read-only layouts, so they are set independently.
fn clear_reference_channel(reference: &mut [PixelValue], target_size: [u32; 2], offset: [u32; 2], size: [u32; 2], channel: usize, value: Option<bool>) {
    for y in offset[1]..offset[1] + size[1] {
        for x in offset[0]..offset[0] + size[0] {
            let at = (x + y * target_size[0]) as usize;
            match value {
                Some(v) => reference[at].set_value(channel, v),
                None => reference[at].set_undefined(channel),
            }
        }
    }
}

/// `getImageAspectFlags` - which aspects an attachment of this format has.
fn attachment_aspect(format: TextureFormat) -> vk::ImageAspectFlags {
    let mut aspect = vk::ImageAspectFlags::empty();
    if format.order.has_depth() {
        aspect |= vk::ImageAspectFlags::DEPTH;
    }
    if format.order.has_stencil() {
        aspect |= vk::ImageAspectFlags::STENCIL;
    }
    if aspect.is_empty() { vk::ImageAspectFlags::COLOR } else { aspect }
}

/// `requiredDepthEpsilon` - a unorm depth value that goes into the buffer and back can
/// lose precision, so the comparison needs slack rather than an exact match.
fn required_depth_epsilon(format: vk::Format) -> f32 {
    let unorm_bits = match format {
        vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => 16,
        vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D24_UNORM_S8_UINT => 24,
        _ => 0,
    };

    if unorm_bits > 0 {
        1.0 / ((1u32 << unorm_bits) - 1) as f32
    } else {
        // A float depth format keeps the value exactly.
        0.0
    }
}

fn depths_equal(a: f32, b: f32, epsilon: f32) -> bool {
    (a - b).abs() <= epsilon
}

/// `verifyDepthAttachment`
fn verify_depth_attachment(reference: &[PixelValue], result: &ConstPixelBufferAccess<'_>, depth_values: [u8; 2], epsilon: f32) -> bool {
    let [width, height, _] = result.size();
    let mut ok = true;

    for y in 0..height {
        for x in 0..width {
            let result_depth = result.get_pix_depth(x, y, 0);
            if let Some(value) = reference[(x + y * width) as usize].get_value(0) {
                let expected = f32::from(depth_values[usize::from(value)]) / 255.0;
                if !depths_equal(result_depth, expected, epsilon) {
                    ok = false;
                }
            }
        }
    }

    ok
}

/// `verifyStencilAttachment`
fn verify_stencil_attachment(reference: &[PixelValue], result: &ConstPixelBufferAccess<'_>) -> bool {
    let [width, height, _] = result.size();
    let mut ok = true;

    for y in 0..height {
        for x in 0..width {
            let result_stencil = result.get_pix_stencil(x, y, 0);
            if let Some(value) = reference[(x + y * width) as usize].get_value(1)
                && ((value && result_stencil != 0xFF) || (!value && result_stencil != 0x0))
            {
                ok = false;
            }
        }
    }

    ok
}

/// `s_coreDepthStencilFormats`, paired with `formatToName`.
pub static CORE_DEPTH_STENCIL_FORMATS: &[(vk::Format, &str)] = &[
    (vk::Format::D16_UNORM, "d16_unorm"),
    (vk::Format::X8_D24_UNORM_PACK32, "x8_d24_unorm_pack32"),
    (vk::Format::D32_SFLOAT, "d32_sfloat"),
    (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
    (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
];

/// The depth/stencil half of `addFormatTests`, without its `input` branch: one
/// attachment used as the subpass's depth/stencil attachment and nothing else.
///
/// A combined format also gets the two read-only layouts, where the subpass may write
/// only one of the two aspects. Upstream skips those for a CLEAR load op, because the
/// render pass would then clear an aspect the subpass cannot write.
fn add_depth_stencil_format_tests(group: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind, render_pass_type: RenderPassType) {
    const TARGET_SIZE: [u32; 2] = [64, 64];
    const RENDER_POS: [u32; 2] = [0, 0];
    const RENDER_SIZE: [u32; 2] = [64, 64];

    let load_ops = [
        ("clear", vk::AttachmentLoadOp::CLEAR),
        ("load", vk::AttachmentLoadOp::LOAD),
        ("dont_care", vk::AttachmentLoadOp::DONT_CARE),
    ];
    let render_types = [
        ("clear", RenderTypes::CLEAR),
        ("draw", RenderTypes::DRAW),
        ("clear_draw", RenderTypes::CLEAR.or(RenderTypes::DRAW)),
    ];

    for &(vk_format, format_name) in CORE_DEPTH_STENCIL_FORMATS {
        let format = map_vk_format(vk_format).expect("a core depth/stencil format maps");
        let is_depth_attachment = format.order.has_depth();
        let is_stencil_attachment = format.order.has_stencil();
        let mut format_group = tcu::TestCaseGroup::new(format_name);

        for (load_op_name, load_op) in load_ops {
            let mut load_op_group = tcu::TestCaseGroup::new(load_op_name);

            for (render_type_name, render_type) in render_types {
                let make_attachment = || Attachment {
                    format: vk_format,
                    samples: vk::SampleCountFlags::_1,
                    load_op: if is_depth_attachment { load_op } else { vk::AttachmentLoadOp::DONT_CARE },
                    store_op: if is_depth_attachment {
                        vk::AttachmentStoreOp::STORE
                    } else {
                        vk::AttachmentStoreOp::DONT_CARE
                    },
                    stencil_load_op: if is_stencil_attachment { load_op } else { vk::AttachmentLoadOp::DONT_CARE },
                    stencil_store_op: if is_stencil_attachment {
                        vk::AttachmentStoreOp::STORE
                    } else {
                        vk::AttachmentStoreOp::DONT_CARE
                    },
                    initial_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                };

                let mut add = |name: String, ds_layout: vk::ImageLayout| {
                    let render_pass = RenderPassDesc {
                        attachments: vec![make_attachment()],
                        subpasses: vec![Subpass {
                            input_attachments: Vec::new(),
                            color_attachments: Vec::new(),
                            depth_stencil_attachment: AttachmentReference::new(0, ds_layout),
                        }],
                        dependencies: Vec::new(),
                        input_aspects: Vec::new(),
                    };
                    let config = TestConfig::new(
                        render_pass,
                        render_type,
                        TARGET_SIZE,
                        RENDER_POS,
                        RENDER_SIZE,
                        false,
                        90239,
                        allocation_kind,
                        render_pass_type,
                    );
                    load_op_group.add_child(Box::new(RenderPassTestCase { name, config }) as Box<dyn TestCase>);
                };

                add(render_type_name.to_string(), vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL);

                if is_stencil_attachment && is_depth_attachment && load_op != vk::AttachmentLoadOp::CLEAR {
                    add(format!("{render_type_name}_depth_read_only"), vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL);
                    add(format!("{render_type_name}_stencil_read_only"), vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL);
                }
            }

            format_group.add_child(load_op_group);
        }

        add_depth_stencil_input_tests(&mut format_group, vk_format, format, allocation_kind, render_pass_type);

        group.add_child(format_group);
    }
}

/// Which aspects of a depth/stencil input attachment the layout leaves readable.
///
/// A read-only layout removes its aspect from *both* the shader's inputs and the
/// subpass's outputs, so the same two flags drive the shader, the descriptor bindings
/// and the reference.
fn readable_aspects(format: TextureFormat, layout: vk::ImageLayout) -> (bool, bool) {
    (
        format.order.has_depth() && layout != vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL,
        format.order.has_stencil() && layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL,
    )
}

/// `requiredDepthEpsilon`'s only input: how many unorm bits the depth aspect has, or
/// zero for a float format, which is exact.
fn depth_epsilon_bits(format: vk::Format) -> u32 {
    match format {
        vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => 16,
        vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D24_UNORM_S8_UINT => 24,
        _ => 0,
    }
}

/// The depth/stencil `input` family: a subpass that reads a depth/stencil attachment.
/// `None` when the case is not of that shape.
fn depth_input_programs_for(config: &TestConfig) -> Option<&'static DepthInputProgram> {
    let render_pass_info = &config.render_pass;
    let subpass = render_pass_info.subpasses.iter().find(|s| !s.input_attachments.is_empty())?;

    let input_ref = subpass.input_attachments[0];
    let input_format = map_vk_format(render_pass_info.attachments[input_ref.attachment as usize].format)?;
    if !input_format.order.has_depth() && !input_format.order.has_stencil() {
        return None;
    }

    let (depth_input, stencil_input) = readable_aspects(input_format, input_ref.layout);
    let epsilon_bits = if depth_input {
        depth_epsilon_bits(render_pass_info.attachments[input_ref.attachment as usize].format)
    } else {
        0
    };

    // What the reading subpass writes.
    let ds_output = if !subpass.color_attachments.is_empty() {
        "color"
    } else if subpass.depth_stencil_attachment.attachment != ATTACHMENT_UNUSED {
        let ds_format = map_vk_format(render_pass_info.attachments[subpass.depth_stencil_attachment.attachment as usize].format)?;
        let layout = subpass.depth_stencil_attachment.layout;
        if ds_format.order.has_depth() && layout != vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL && layout != vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL {
            "depth"
        } else {
            "none"
        }
    } else {
        "none"
    };

    ALL_DEPTH_INPUT_PROGRAMS.iter().copied().find(|p| {
        p.depth_input == depth_input
            && p.stencil_input == stencil_input
            && p.epsilon_bits == epsilon_bits
            && p.ds_output == ds_output
            && p.ds_depth_true == u32::from(config.depth_values[1])
            && p.ds_depth_false == u32::from(config.depth_values[0])
    })
}

/// The shaders a case uses. Three families, in the order that decides which applies:
/// a subpass reading a depth/stencil attachment, a depth/stencil-only subpass, and
/// everything with a colour attachment.
fn collection_for(config: &TestConfig) -> BinaryCollection {
    if let Some(program) = depth_input_programs_for(config) {
        return program.programs;
    }
    if let Some(program) = depth_programs_for(config) {
        return program.programs;
    }
    programs_for_config(config).programs
}

/// The `input` branch of the depth/stencil half of `addFormatTests`.
///
/// Subpass 0 writes the depth/stencil attachment; subpass 1 reads it back. Two shapes,
/// each optionally restricted to one aspect: the two-subpass form writes what it found
/// into a second R8G8B8A8_UNORM attachment, and the self-dependency form writes it
/// back into the depth aspect it just read.
fn add_depth_stencil_input_tests(
    format_group: &mut tcu::TestCaseGroup,
    vk_format: vk::Format,
    format: TextureFormat,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
) {
    const TARGET_SIZE: [u32; 2] = [64, 64];
    const RENDER_POS: [u32; 2] = [0, 0];
    const RENDER_SIZE: [u32; 2] = [64, 64];

    let is_depth = format.order.has_depth();
    let is_stencil = format.order.has_stencil();
    let format_aspect_flags = attachment_aspect(format);

    let load_ops = [
        ("clear", vk::AttachmentLoadOp::CLEAR),
        ("load", vk::AttachmentLoadOp::LOAD),
        ("dont_care", vk::AttachmentLoadOp::DONT_CARE),
    ];
    let store_ops = [("store", vk::AttachmentStoreOp::STORE), ("dont_care", vk::AttachmentStoreOp::DONT_CARE)];
    let render_types = [
        ("clear", RenderTypes::CLEAR),
        ("draw", RenderTypes::DRAW),
        ("clear_draw", RenderTypes::CLEAR.or(RenderTypes::DRAW)),
    ];

    let input_attachment_aspect_mask = if render_pass_type == RenderPassType::RenderPass2 {
        format_aspect_flags
    } else {
        vk::ImageAspectFlags::empty()
    };

    // The read-only layouts only exist where there are two aspects to split.
    let mut read_only_layouts: Vec<(&str, vk::ImageLayout, vk::ImageLayout)> = Vec::new();
    if is_depth && is_stencil {
        read_only_layouts.push((
            "_depth_read_only",
            vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL,
        ));
        read_only_layouts.push((
            "_stencil_read_only",
            vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL,
            vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL,
        ));
    }

    let mut input_group = tcu::TestCaseGroup::new("input");

    for (load_op_name, load_op) in load_ops {
        let mut load_op_group = tcu::TestCaseGroup::new(load_op_name);

        for (store_op_name, store_op) in store_ops {
            let mut store_op_group = tcu::TestCaseGroup::new(store_op_name);

            for use_input_aspect in [false, true] {
                if render_pass_type != RenderPassType::Legacy && use_input_aspect {
                    continue;
                }

                let input_aspects = || {
                    if use_input_aspect {
                        vec![vk::InputAttachmentAspectReference {
                            subpass: 1,
                            input_attachment_index: 0,
                            aspect_mask: format_aspect_flags,
                        }]
                    } else {
                        Vec::new()
                    }
                };
                let aspect_suffix = if use_input_aspect { "_use_input_aspect" } else { "" };

                let ds_attachment = |depth_op: (vk::AttachmentLoadOp, vk::AttachmentStoreOp), stencil_op: (vk::AttachmentLoadOp, vk::AttachmentStoreOp)| Attachment {
                    format: vk_format,
                    samples: vk::SampleCountFlags::_1,
                    load_op: depth_op.0,
                    store_op: depth_op.1,
                    stencil_load_op: stencil_op.0,
                    stencil_store_op: stencil_op.1,
                    initial_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                };
                let color_attachment = Attachment {
                    format: vk::Format::R8G8B8A8_UNORM,
                    samples: vk::SampleCountFlags::_1,
                    load_op: vk::AttachmentLoadOp::DONT_CARE,
                    store_op: vk::AttachmentStoreOp::STORE,
                    stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                    stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                    initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                };

                let ds_dependency = |src_pass, dst_pass, flags| SubpassDependency {
                    src_pass,
                    dst_pass,
                    src_stage_mask: vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                    src_access_mask: vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
                    flags,
                };

                for (render_type_name, render_type) in render_types {
                    // Two subpasses, reading into a colour attachment. The
                    // full-aspect case first, then one per read-only layout.
                    let mut two_subpass_layouts: Vec<(&str, vk::ImageLayout)> = vec![("", vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)];
                    two_subpass_layouts.extend(read_only_layouts.iter().map(|&(name, input_layout, _)| (name, input_layout)));

                    for (layout_suffix, input_layout) in two_subpass_layouts {
                        let render_pass = RenderPassDesc {
                            attachments: vec![ds_attachment((load_op, store_op), (load_op, store_op)), color_attachment],
                            subpasses: vec![
                                Subpass {
                                    input_attachments: Vec::new(),
                                    color_attachments: Vec::new(),
                                    depth_stencil_attachment: AttachmentReference::new(0, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL),
                                },
                                Subpass {
                                    input_attachments: vec![AttachmentReference::with_aspect(0, input_layout, input_attachment_aspect_mask)],
                                    color_attachments: vec![AttachmentReference::new(1, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)],
                                    depth_stencil_attachment: AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
                                },
                            ],
                            dependencies: vec![ds_dependency(0, 1, vk::DependencyFlags::empty())],
                            input_aspects: input_aspects(),
                        };
                        let config = TestConfig::new(
                            render_pass,
                            render_type,
                            TARGET_SIZE,
                            RENDER_POS,
                            RENDER_SIZE,
                            false,
                            89246,
                            allocation_kind,
                            render_pass_type,
                        );
                        store_op_group.add_child(Box::new(RenderPassTestCase {
                            name: format!("{render_type_name}{aspect_suffix}{layout_suffix}"),
                            config,
                        }) as Box<dyn TestCase>);
                    }

                    // One subpass reading and writing the same attachment. Its
                    // stencil ops are DONT_CARE in the full-aspect case, because the
                    // subpass writes only depth.
                    let mut self_dep_layouts: Vec<(&str, vk::ImageLayout)> = vec![("", vk::ImageLayout::GENERAL)];
                    self_dep_layouts.extend(read_only_layouts.iter().map(|&(name, _, ds_layout)| (name, ds_layout)));

                    for (layout_suffix, ds_layout) in self_dep_layouts {
                        let stencil_op = if layout_suffix.is_empty() {
                            (vk::AttachmentLoadOp::DONT_CARE, vk::AttachmentStoreOp::DONT_CARE)
                        } else {
                            (load_op, store_op)
                        };
                        let render_pass = RenderPassDesc {
                            attachments: vec![ds_attachment((load_op, store_op), stencil_op)],
                            subpasses: vec![
                                Subpass {
                                    input_attachments: Vec::new(),
                                    color_attachments: Vec::new(),
                                    depth_stencil_attachment: AttachmentReference::new(0, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL),
                                },
                                Subpass {
                                    input_attachments: vec![AttachmentReference::with_aspect(0, ds_layout, input_attachment_aspect_mask)],
                                    color_attachments: Vec::new(),
                                    depth_stencil_attachment: AttachmentReference::new(0, ds_layout),
                                },
                            ],
                            dependencies: vec![ds_dependency(0, 1, vk::DependencyFlags::BY_REGION), ds_dependency(1, 1, vk::DependencyFlags::BY_REGION)],
                            input_aspects: input_aspects(),
                        };
                        let config = TestConfig::new(
                            render_pass,
                            render_type,
                            TARGET_SIZE,
                            RENDER_POS,
                            RENDER_SIZE,
                            false,
                            89246,
                            allocation_kind,
                            render_pass_type,
                        );
                        store_op_group.add_child(Box::new(RenderPassTestCase {
                            name: format!("self_dep_{render_type_name}{aspect_suffix}{layout_suffix}"),
                            config,
                        }) as Box<dyn TestCase>);
                    }
                }
            }

            load_op_group.add_child(store_op_group);
        }

        input_group.add_child(load_op_group);
    }

    format_group.add_child(input_group);
}
