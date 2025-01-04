// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageDepthStencilDescriptorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The GLSL `initPrograms` writes depends only on the list of descriptor kinds
// per aspect and on compute vs graphics, so shaders/manifest/image_depth_stencil_descriptor.toml holds one program set per
// combination and `programs` picks it. The comparisons (`floatThresholdCompare` and friends) are written out as per-pixel
// loops. A device without a compute-only queue family runs the compute variants on the universal queue.
//
// Samples and loads a depth/stencil image through descriptors (sampled image, input attachment) in the layouts that allow
// one aspect to be read-only while the other is an attachment, and checks what the shader copied into storage images.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrCreateRenderpass2ExtensionDeviceCommands};

use crate::generated::shaders::image_depth_stencil_descriptor::{
    DSD_C_N_N, DSD_C_N_S, DSD_C_S_N, DSD_C_S_S, DSD_G_IA_IA, DSD_G_IA_IA_S, DSD_G_IA_N, DSD_G_IA_S, DSD_G_IA_S_IA,
    DSD_G_IA_S_IA_S, DSD_G_IA_S_N, DSD_G_IA_S_S, DSD_G_N_IA, DSD_G_N_IA_S, DSD_G_N_N, DSD_G_N_S, DSD_G_S_IA,
    DSD_G_S_IA_S, DSD_G_S_N, DSD_G_S_S,
};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear_depth, clear_stencil};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, get_depth_copy_format, get_stencil_copy_format, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, default_depth_stencil_state, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXTENT: vk::Extent3D = vk::Extent3D {
    width: 8,
    height: 8,
    depth: 1,
};
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FLOAT_STORAGE_FORMAT: vk::Format = vk::Format::R32_SFLOAT;
const UINT_STORAGE_FORMAT: vk::Format = vk::Format::R32_UINT;

fn layout_extension(layout: vk::ImageLayout) -> &'static str {
    match layout {
        vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL
        | vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL => "VK_KHR_maintenance2",
        // Separate depth/stencil layouts are not used here; there is a separate group of tests for that.
        _ => "VK_KHR_separate_depth_stencil_layouts",
    }
}

/// Types of access for an image aspect.
#[derive(Clone, Copy, PartialEq, Eq)]
enum AspectAccess {
    None,
    /// Different subtypes, see `ReadOnlyAccess`.
    Ro,
    /// Always a normal read/write depth/stencil attachment (NOT a storage image).
    Rw,
}

impl AspectAccess {
    fn name(self) -> &'static str {
        match self {
            AspectAccess::None => "none",
            AspectAccess::Ro => "ro",
            AspectAccess::Rw => "rw",
        }
    }
}

/// Types of read-only accesses.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ReadOnlyAccess {
    /// Depth/stencil attachment but read-only (writes not enabled).
    DsAttachment,
    /// Input attachment in the set.
    InputAttachment,
    /// Sampled image.
    Sampled,
}

impl ReadOnlyAccess {
    fn name(self) -> &'static str {
        match self {
            ReadOnlyAccess::DsAttachment => "att",
            ReadOnlyAccess::InputAttachment => "ia",
            ReadOnlyAccess::Sampled => "sampled",
        }
    }
}

type RoAccesses = &'static [ReadOnlyAccess];

fn ro_accesses_name(accesses: RoAccesses) -> String {
    accesses
        .iter()
        .map(|access| access.name())
        .collect::<Vec<_>>()
        .join("_")
}

fn has_access(accesses: Option<RoAccesses>, wanted: ReadOnlyAccess) -> bool {
    accesses.is_some_and(|list| list.contains(&wanted))
}

/// A given layout gives different accesses to each aspect.
fn get_legal_access(layout: vk::ImageLayout, aspect: vk::ImageAspectFlags) -> AspectAccess {
    debug_assert!(aspect == vk::ImageAspectFlags::DEPTH || aspect == vk::ImageAspectFlags::STENCIL);
    let stencil = aspect == vk::ImageAspectFlags::STENCIL;

    match layout {
        vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL => {
            if stencil {
                AspectAccess::Rw
            } else {
                AspectAccess::Ro
            }
        }
        vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL => {
            if !stencil {
                AspectAccess::Rw
            } else {
                AspectAccess::Ro
            }
        }
        vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL => {
            if !stencil {
                AspectAccess::Ro
            } else {
                AspectAccess::None
            }
        }
        vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL => {
            if stencil {
                AspectAccess::Ro
            } else {
                AspectAccess::None
            }
        }
        _ => AspectAccess::None,
    }
}

/// Depth/stencil images with both aspects cannot be accessed both as a depth/stencil attachment and an input attachment at
/// the same time, because input attachments can only have one aspect.
fn incompatible_input_attachment_access(
    depth_access: AspectAccess,
    depth_ro: Option<RoAccesses>,
    stencil_access: AspectAccess,
    stencil_ro: Option<RoAccesses>,
) -> bool {
    let depth_as_ds_attachment = depth_access == AspectAccess::Rw
        || (depth_access == AspectAccess::Ro && has_access(depth_ro, ReadOnlyAccess::DsAttachment));
    let stencil_as_ds_attachment = stencil_access == AspectAccess::Rw
        || (stencil_access == AspectAccess::Ro && has_access(stencil_ro, ReadOnlyAccess::DsAttachment));
    let depth_as_input_attachment =
        depth_access == AspectAccess::Ro && has_access(depth_ro, ReadOnlyAccess::InputAttachment);
    let stencil_as_input_attachment =
        stencil_access == AspectAccess::Ro && has_access(stencil_ro, ReadOnlyAccess::InputAttachment);

    (depth_as_ds_attachment && stencil_as_input_attachment) || (stencil_as_ds_attachment && depth_as_input_attachment)
}

fn get_read_only_usage_flags(accesses: RoAccesses) -> vk::ImageUsageFlags {
    let mut usage = vk::ImageUsageFlags::empty();

    for access in accesses {
        match access {
            ReadOnlyAccess::DsAttachment => usage |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            ReadOnlyAccess::InputAttachment => {
                usage |= vk::ImageUsageFlags::INPUT_ATTACHMENT | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            }
            ReadOnlyAccess::Sampled => usage |= vk::ImageUsageFlags::SAMPLED,
        }
    }

    usage
}

/// `InputOutputDescriptor` - resources needed for an aspect that will be used as a descriptor in shaders.
#[derive(Clone, Copy)]
struct InputOutputDescriptor {
    binding: u32,
    input_attachment_index: Option<u32>,
    aspect: vk::ImageAspectFlags,
}

/// Which of the two descriptor kinds an aspect has, which is all the shader source depends on.
#[derive(Clone, Copy)]
enum Kinds {
    None,
    Ia,
    S,
    IaS,
}

fn kinds_of(accesses: Option<RoAccesses>) -> Kinds {
    match (
        has_access(accesses, ReadOnlyAccess::InputAttachment),
        has_access(accesses, ReadOnlyAccess::Sampled),
    ) {
        (false, false) => Kinds::None,
        (true, false) => Kinds::Ia,
        (false, true) => Kinds::S,
        (true, true) => Kinds::IaS,
    }
}

/// Test parameters.
#[derive(Clone, Copy)]
struct TestParams {
    format: vk::Format,
    /// Layout being tested.
    layout: vk::ImageLayout,
    /// Type of access that will be used for depth (must be legal).
    depth_access: AspectAccess,
    /// Type of access that will be used for stencil (must be legal).
    stencil_access: AspectAccess,
    /// Types of read-only accesses for depth (used when `depth_access` is Ro).
    depth_ro_accesses: Option<RoAccesses>,
    /// Types of read-only accesses for stencil (used when `stencil_access` is Ro).
    stencil_ro_accesses: Option<RoAccesses>,
    /// Run with compute pipeline on compute queue.
    use_compute: bool,
}

fn format_has_depth(format: vk::Format) -> bool {
    !matches!(format, vk::Format::S8_UINT)
}

fn format_has_stencil(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::S8_UINT
            | vk::Format::D16_UNORM_S8_UINT
            | vk::Format::D24_UNORM_S8_UINT
            | vk::Format::D32_SFLOAT_S8_UINT
    )
}

fn format_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    let mut aspects = vk::ImageAspectFlags::empty();
    if format_has_depth(format) {
        aspects |= vk::ImageAspectFlags::DEPTH;
    }
    if format_has_stencil(format) {
        aspects |= vk::ImageAspectFlags::STENCIL;
    }
    aspects
}

impl TestParams {
    fn usage_flags(&self) -> vk::ImageUsageFlags {
        let mut usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

        if self.depth_access == AspectAccess::Rw || self.stencil_access == AspectAccess::Rw {
            usage |= vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
        }

        if self.depth_access == AspectAccess::Ro {
            usage |= get_read_only_usage_flags(self.depth_ro_accesses.expect("depth is read-only"));
        }

        if self.stencil_access == AspectAccess::Ro {
            usage |= get_read_only_usage_flags(self.stencil_ro_accesses.expect("stencil is read-only"));
        }

        usage
    }

    /// Get a list of descriptors needed according to the given test parameters.
    fn descriptors(&self) -> Vec<InputOutputDescriptor> {
        let mut descriptors = Vec::new();
        let mut input_attachment_count = 0u32;

        let mut add_descriptors = |accesses: RoAccesses, aspect: vk::ImageAspectFlags| {
            for access in accesses {
                // Get a new binding number and a new input attachment index if needed, then append the new descriptor to the
                // list if appropriate.
                let mut descriptor = InputOutputDescriptor {
                    binding: descriptors.len() as u32,
                    input_attachment_index: None,
                    aspect,
                };

                if *access == ReadOnlyAccess::InputAttachment {
                    descriptor.input_attachment_index = Some(input_attachment_count);
                    input_attachment_count += 1;
                }

                if *access == ReadOnlyAccess::InputAttachment || *access == ReadOnlyAccess::Sampled {
                    descriptors.push(descriptor);
                }
            }
        };

        if let Some(accesses) = self.depth_ro_accesses {
            add_descriptors(accesses, vk::ImageAspectFlags::DEPTH);
        }

        if let Some(accesses) = self.stencil_ro_accesses {
            add_descriptors(accesses, vk::ImageAspectFlags::STENCIL);
        }

        descriptors
    }

    /// Does this case need a depth/stencil attachment?
    fn ds_attachment_needed(&self) -> bool {
        // It is needed if the image is going to be used as a depth/stencil attachment or an input attachment.
        self.input_attachment_needed() || self.depth_buffer_needed()
    }

    fn depth_as_input_attachment(&self) -> bool {
        self.depth_access == AspectAccess::Ro && has_access(self.depth_ro_accesses, ReadOnlyAccess::InputAttachment)
    }

    fn stencil_as_input_attachment(&self) -> bool {
        self.stencil_access == AspectAccess::Ro && has_access(self.stencil_ro_accesses, ReadOnlyAccess::InputAttachment)
    }

    /// An input attachment is needed if any of the aspects include a read-only access as an input attachment.
    fn input_attachment_needed(&self) -> bool {
        self.depth_as_input_attachment() || self.stencil_as_input_attachment()
    }

    /// The depth buffer is needed if any of the aspects include a read-write or read-only DS access.
    fn depth_buffer_needed(&self) -> bool {
        self.needs_depth_test() || self.needs_stencil_test()
    }

    fn needs_depth_test(&self) -> bool {
        self.depth_access == AspectAccess::Rw
            || (self.depth_access == AspectAccess::Ro
                && has_access(self.depth_ro_accesses, ReadOnlyAccess::DsAttachment))
    }

    fn needs_stencil_test(&self) -> bool {
        self.stencil_access == AspectAccess::Rw
            || (self.stencil_access == AspectAccess::Ro
                && has_access(self.stencil_ro_accesses, ReadOnlyAccess::DsAttachment))
    }

    fn is_compute_compatible(&self) -> bool {
        // Compute shaders cannot have input attachments.
        if self.input_attachment_needed() {
            return false;
        }

        // Compute shaders cannot use the pipeline depth/stencil tests (no render pass), so there can be no RW access (which
        // implies attachment write) and no DS_ATTACHMENT usage (attachment read). Only SAMPLED access is supported there.
        if self.depth_access == AspectAccess::Rw || self.stencil_access == AspectAccess::Rw {
            return false;
        }

        if self.depth_access == AspectAccess::Ro && has_access(self.depth_ro_accesses, ReadOnlyAccess::DsAttachment) {
            return false;
        }

        if self.stencil_access == AspectAccess::Ro && has_access(self.stencil_ro_accesses, ReadOnlyAccess::DsAttachment)
        {
            return false;
        }

        true
    }
}

/// Must match the shaders.
#[repr(C)]
#[derive(Clone, Copy, Default)]
struct PushConstantData {
    color_r: f32,
    color_g: f32,
    color_b: f32,
    color_a: f32,
    depth: f32,
}

impl PushConstantData {
    fn new(color: [f32; 4], depth: f32) -> Self {
        Self {
            color_r: color[0],
            color_g: color[1],
            color_b: color[2],
            color_a: color[3],
            depth,
        }
    }

    fn as_bytes(&self) -> &[u8] {
        unsafe { std::slice::from_raw_parts(std::ptr::from_ref(self).cast::<u8>(), std::mem::size_of::<Self>()) }
    }
}

fn aspect_storage_format(aspect: vk::ImageAspectFlags) -> vk::Format {
    if aspect == vk::ImageAspectFlags::DEPTH {
        FLOAT_STORAGE_FORMAT
    } else {
        UINT_STORAGE_FORMAT
    }
}

fn copy_buffer_size(format: crate::tcu::TextureFormat) -> Result<vk::DeviceSize, TestError> {
    let pixel_size = format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError("format without a pixel size".to_string()))?;
    Ok(vk::DeviceSize::from(
        pixel_size * EXTENT.width * EXTENT.height * EXTENT.depth,
    ))
}

struct DepthStencilDescriptorCase {
    name: String,
    params: TestParams,
}

impl TestCase for DepthStencilDescriptorCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if !params.use_compute {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        } else {
            // Compute tests use vkCmdCopyBufferToImage on the compute queue to clear the DS image, which requires
            // VK_KHR_maintenance10 and specific format features to be legal on a compute queue.
            context.require_device_functionality("VK_KHR_maintenance10")?;
            context.require_device_functionality("VK_KHR_format_feature_flags2")?;
        }

        context.require_device_functionality(layout_extension(params.layout))?;

        // Check format support.
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        match unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                params.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                params.usage_flags(),
                vk::ImageCreateFlags::empty(),
            )
        } {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(
                    "Format does not support required properties".to_string(),
                ));
            }
            Err(error) => {
                return Err(TestError::Fail(format!(
                    "vkGetPhysicalDeviceImageFormatProperties returned {error:?}"
                )));
            }
            Ok(_) => {}
        }

        if params.use_compute {
            let mut format_properties3 = vk::FormatProperties3::default();
            {
                let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut format_properties3);
                unsafe {
                    instance.get_physical_device_format_properties2(
                        physical_device,
                        params.format,
                        &mut format_properties2,
                    )
                };
            }

            if format_has_depth(params.format)
                && !format_properties3
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags2::DEPTH_COPY_ON_COMPUTE_QUEUE_KHR)
            {
                return Err(TestError::NotSupported(
                    "Format does not support VK_FORMAT_FEATURE_2_DEPTH_COPY_ON_COMPUTE_QUEUE_BIT_KHR".to_string(),
                ));
            }

            if format_has_stencil(params.format)
                && !format_properties3
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags2::STENCIL_COPY_ON_COMPUTE_QUEUE_KHR)
            {
                return Err(TestError::NotSupported(
                    "Format does not support VK_FORMAT_FEATURE_2_STENCIL_COPY_ON_COMPUTE_QUEUE_BIT_KHR".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        let depth = kinds_of(params.depth_ro_accesses);
        let stencil = kinds_of(params.stencil_ro_accesses);

        use Kinds::{Ia, IaS, None as N, S};
        if params.use_compute {
            match (depth, stencil) {
                (N, N) => DSD_C_N_N.programs,
                (N, S) => DSD_C_N_S.programs,
                (S, N) => DSD_C_S_N.programs,
                (S, S) => DSD_C_S_S.programs,
                _ => unreachable!("compute cases have no input attachments"),
            }
        } else {
            match (depth, stencil) {
                (N, N) => DSD_G_N_N.programs,
                (N, Ia) => DSD_G_N_IA.programs,
                (N, S) => DSD_G_N_S.programs,
                (N, IaS) => DSD_G_N_IA_S.programs,
                (Ia, N) => DSD_G_IA_N.programs,
                (Ia, Ia) => DSD_G_IA_IA.programs,
                (Ia, S) => DSD_G_IA_S.programs,
                (Ia, IaS) => DSD_G_IA_IA_S.programs,
                (S, N) => DSD_G_S_N.programs,
                (S, Ia) => DSD_G_S_IA.programs,
                (S, S) => DSD_G_S_S.programs,
                (S, IaS) => DSD_G_S_IA_S.programs,
                (IaS, N) => DSD_G_IA_S_N.programs,
                (IaS, Ia) => DSD_G_IA_S_IA.programs,
                (IaS, S) => DSD_G_IA_S_S.programs,
                (IaS, IaS) => DSD_G_IA_S_IA_S.programs,
            }
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthStencilDescriptorInstance {
            context,
            params: self.params,
        })
    }
}

fn make_image_create_info(format: vk::Format, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(EXTENT)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

fn make_buffer_image_copy(aspect: vk::ImageAspectFlags) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(aspect, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: EXTENT,
    }
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

struct DepthStencilDescriptorInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl DepthStencilDescriptorInstance<'_> {
    /// The render pass of the graphics variants: a colour attachment and, when needed, the depth/stencil image as a
    /// depth/stencil and/or input attachment in the layout under test.
    fn make_render_pass(
        &self,
        has_depth: bool,
        has_stencil: bool,
        depth_writes: bool,
        stencil_writes: bool,
    ) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let params = &self.params;
        let device = self.context.get_device();
        let color_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;

        let mut attachment_descriptions: Vec<vk::AttachmentDescription2> = Vec::new();
        let mut attachment_references: Vec<vk::AttachmentReference2> = Vec::new();

        attachment_descriptions.push(vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: COLOR_FORMAT,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::LOAD,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: color_layout,
            final_layout: color_layout,
        });

        attachment_references.push(vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: 0,
            layout: color_layout,
            aspect_mask: vk::ImageAspectFlags::COLOR,
        });

        let needs_ia = params.input_attachment_needed();
        let needs_depth_buffer = params.depth_buffer_needed();
        debug_assert!(!(needs_ia && needs_depth_buffer));

        if params.ds_attachment_needed() {
            attachment_descriptions.push(vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: params.format,
                samples: vk::SampleCountFlags::_1,
                load_op: if has_depth {
                    vk::AttachmentLoadOp::LOAD
                } else {
                    vk::AttachmentLoadOp::DONT_CARE
                },
                store_op: if has_depth && depth_writes {
                    vk::AttachmentStoreOp::STORE
                } else {
                    vk::AttachmentStoreOp::DONT_CARE
                },
                stencil_load_op: if has_stencil {
                    vk::AttachmentLoadOp::LOAD
                } else {
                    vk::AttachmentLoadOp::DONT_CARE
                },
                stencil_store_op: if has_stencil && stencil_writes {
                    vk::AttachmentStoreOp::STORE
                } else {
                    vk::AttachmentStoreOp::DONT_CARE
                },
                initial_layout: params.layout,
                final_layout: params.layout,
            });

            let mut aspect_mask = vk::ImageAspectFlags::empty();
            if params.depth_as_input_attachment() {
                aspect_mask |= vk::ImageAspectFlags::DEPTH;
            }
            if params.stencil_as_input_attachment() {
                aspect_mask |= vk::ImageAspectFlags::STENCIL;
            }

            attachment_references.push(vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: 1,
                layout: params.layout,
                aspect_mask,
            });
        }

        let subpass = vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: u32::from(needs_ia),
            input_attachments: if needs_ia {
                &attachment_references[1]
            } else {
                std::ptr::null()
            },
            color_attachment_count: 1,
            color_attachments: &attachment_references[0],
            resolve_attachments: std::ptr::null(),
            depth_stencil_attachment: if needs_depth_buffer {
                &attachment_references[1]
            } else {
                std::ptr::null()
            },
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
        };

        let create_info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachment_descriptions.len() as u32,
            attachments: attachment_descriptions.as_ptr(),
            subpass_count: 1,
            subpasses: &subpass,
            dependency_count: 0,
            dependencies: std::ptr::null(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };

        let handle =
            unsafe { device.create_render_pass2_khr(&create_info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        Ok(Unique::new(device, handle))
    }
}

impl TestInstance for DepthStencilDescriptorInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let (queue, q_index) = if params.use_compute {
            context.get_compute_queue().unwrap_or((
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            ))
        } else {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        };
        let usage = params.usage_flags();
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let tcu_color_format = crate::tcu::texture::map_vk_format(COLOR_FORMAT).expect("RGBA8 has a texture format");
        let storage_usage =
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let stage_flags = if params.use_compute {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::FRAGMENT
        };
        let has_depth = format_has_depth(params.format);
        let has_stencil = format_has_stencil(params.format);
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let output_img_layout = vk::ImageLayout::GENERAL;
        let color_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;

        // Copy formats.
        let tcu_depth_format = if has_depth {
            get_depth_copy_format(params.format)
        } else {
            None
        };
        let tcu_stencil_format = if has_stencil {
            get_stencil_copy_format(params.format)
        } else {
            None
        };

        // These must match the depth test configuration when enabled.
        let depth_clear_value = 0.5f32;
        let depth_fail_value = 1.0f32;
        let depth_pass_value = 0.0f32;

        // These must match the stencil test configuration when enabled.
        let stencil_clear_val = 100u32;
        let stencil_fail_val = 200u32;
        let stencil_pass_val = 10u32;

        // For the color buffer.
        let color_clear_val = [0.0f32, 0.0, 0.0, 1.0];
        let color_fail_val = [1.0f32, 0.0, 0.0, 1.0];
        let color_pass_val = [0.0f32, 1.0, 0.0, 1.0];

        // Will the test update the depth/stencil buffer?
        let stencil_writes = params.stencil_access == AspectAccess::Rw;
        let depth_writes = params.depth_access == AspectAccess::Rw;

        // Create color attachment (only needed for graphics).
        let mut color_buffer: Option<ImageWithMemory<'_>> = None;
        let mut color_view: Option<Unique<'_, vk::ImageView>> = None;
        if !params.use_compute {
            let image = ImageWithMemory::new(
                device,
                alloc,
                make_image_create_info(COLOR_FORMAT, color_usage),
                MemoryRequirement::ANY,
            )?;
            color_view = Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                COLOR_FORMAT,
                color_srr,
            )?);
            color_buffer = Some(image);
        }

        // Create depth/stencil image.
        let ds_image = ImageWithMemory::new(
            device,
            alloc,
            make_image_create_info(params.format, usage),
            MemoryRequirement::ANY,
        )?;
        let depth_stencil_srr = make_image_subresource_range(format_aspect_flags(params.format), 0, 1, 0, 1);
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let stencil_srr = make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
        let ds_image_view = make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            params.format,
            depth_stencil_srr,
        )?;

        let depth_only_view = if has_depth {
            Some(make_image_view(
                device,
                ds_image.get(),
                vk::ImageViewType::_2D,
                params.format,
                depth_srr,
            )?)
        } else {
            None
        };
        let stencil_only_view = if has_stencil {
            Some(make_image_view(
                device,
                ds_image.get(),
                vk::ImageViewType::_2D,
                params.format,
                stencil_srr,
            )?)
        } else {
            None
        };

        // Get expected descriptors and create output images for them.
        let descriptors = params.descriptors();

        let mut output_images: Vec<ImageWithMemory<'_>> = Vec::with_capacity(descriptors.len());
        let mut output_image_views: Vec<Unique<'_, vk::ImageView>> = Vec::with_capacity(descriptors.len());

        for desc in &descriptors {
            // Floating point images to copy the depth aspect and unsigned int images to copy the stencil aspect.
            let image_format = aspect_storage_format(desc.aspect);
            let image = ImageWithMemory::new(
                device,
                alloc,
                make_image_create_info(image_format, storage_usage),
                MemoryRequirement::ANY,
            )?;
            output_image_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                image_format,
                color_srr,
            )?);
            output_images.push(image);
        }

        // Create samplers.
        let mut sampler_create_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(0.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_OPAQUE_BLACK)
            .unnormalized_coordinates(true);
        // Note the samplers are created with unnormalizedCoordinates as per how they are used in shader code.
        let sampler_float = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );
        sampler_create_info = sampler_create_info.border_color(vk::BorderColor::INT_OPAQUE_BLACK);
        let sampler_int = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        // Create input and output descriptor set layouts.
        let mut input_layout_builder = DescriptorSetLayoutBuilder::new();
        for desc in &descriptors {
            input_layout_builder = input_layout_builder.add_single_binding(
                if desc.input_attachment_index.is_some() {
                    vk::DescriptorType::INPUT_ATTACHMENT
                } else {
                    vk::DescriptorType::SAMPLED_IMAGE
                },
                stage_flags,
            );
        }
        let input_set_layout = input_layout_builder.build(device)?;

        let mut output_layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in &descriptors {
            output_layout_builder =
                output_layout_builder.add_single_binding(vk::DescriptorType::STORAGE_IMAGE, stage_flags);
        }
        let output_set_layout = output_layout_builder.build(device)?;

        let sampler_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::SAMPLER, stage_flags)
            .add_single_binding(vk::DescriptorType::SAMPLER, stage_flags)
            .build(device)?;

        let set_layouts = [*input_set_layout, *output_set_layout, *sampler_set_layout];

        // Descriptor pool and descriptor sets.
        let mut pool_builder = DescriptorPoolBuilder::new();
        for desc in &descriptors {
            pool_builder = pool_builder.add_type(
                if desc.input_attachment_index.is_some() {
                    vk::DescriptorType::INPUT_ATTACHMENT
                } else {
                    vk::DescriptorType::SAMPLED_IMAGE
                },
                1,
            );
        }
        pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_IMAGE, descriptors.len() as u32);
        pool_builder = pool_builder.add_type(vk::DescriptorType::SAMPLER, 2);
        let descriptor_pool = pool_builder.build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            set_layouts.len() as u32,
        )?;

        let input_set = make_descriptor_set(device, *descriptor_pool, *input_set_layout)?;
        let output_set = make_descriptor_set(device, *descriptor_pool, *output_set_layout)?;
        let sampler_set = make_descriptor_set(device, *descriptor_pool, *sampler_set_layout)?;

        let descriptor_sets = [*input_set, *output_set, *sampler_set];

        // Update descriptor sets.
        {
            let mut input_img_infos: Vec<vk::DescriptorImageInfo> = Vec::with_capacity(descriptors.len());
            let mut output_img_infos: Vec<vk::DescriptorImageInfo> = Vec::with_capacity(descriptors.len());

            for (descriptor_idx, desc) in descriptors.iter().enumerate() {
                let view = if desc.aspect == vk::ImageAspectFlags::DEPTH {
                    depth_only_view.as_ref()
                } else {
                    stencil_only_view.as_ref()
                }
                .expect("view of the aspect read by the descriptor");
                input_img_infos.push(vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: **view,
                    image_layout: params.layout,
                });
                output_img_infos.push(vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: *output_image_views[descriptor_idx],
                    image_layout: output_img_layout,
                });
            }

            let sampler_img_infos = [
                vk::DescriptorImageInfo {
                    sampler: *sampler_float,
                    image_view: vk::ImageView::null(),
                    image_layout: vk::ImageLayout::UNDEFINED,
                },
                vk::DescriptorImageInfo {
                    sampler: *sampler_int,
                    image_view: vk::ImageView::null(),
                    image_layout: vk::ImageLayout::UNDEFINED,
                },
            ];

            let mut writes: Vec<vk::WriteDescriptorSet> = Vec::new();
            for (desc, info) in descriptors.iter().zip(&input_img_infos) {
                let descriptor_type = if desc.input_attachment_index.is_some() {
                    vk::DescriptorType::INPUT_ATTACHMENT
                } else {
                    vk::DescriptorType::SAMPLED_IMAGE
                };
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(*input_set)
                        .dst_binding(desc.binding)
                        .descriptor_type(descriptor_type)
                        .image_info(std::slice::from_ref(info))
                        .build(),
                );
            }
            for (desc, info) in descriptors.iter().zip(&output_img_infos) {
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(*output_set)
                        .dst_binding(desc.binding)
                        .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                        .image_info(std::slice::from_ref(info))
                        .build(),
                );
            }
            for (binding, info) in sampler_img_infos.iter().enumerate() {
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(*sampler_set)
                        .dst_binding(binding as u32)
                        .descriptor_type(vk::DescriptorType::SAMPLER)
                        .image_info(std::slice::from_ref(info))
                        .build(),
                );
            }

            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let pc_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE;
        let pc_size = std::mem::size_of::<PushConstantData>() as u32;
        let pc_range = vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        };

        // Pipeline layout.
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(std::slice::from_ref(&pc_range));
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Render pass, frame buffer and graphics pipelines are only for graphics; the compute pipeline only for compute.
        let binaries = context.get_binary_collection();
        let mut render_pass: Option<Unique<'_, vk::RenderPass>> = None;
        let mut framebuffer = None;
        let mut graphics_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        let mut compute_pipeline: Option<Unique<'_, vk::Pipeline>> = None;

        if params.use_compute {
            let comp_module = create_shader_module(device, binaries.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*comp_module)
                .name(b"main\0")
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(-1)
                .build();
            compute_pipeline = Some(Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            ));
        } else {
            let pass = self.make_render_pass(has_depth, has_stencil, depth_writes, stencil_writes)?;

            let mut framebuffer_views = vec![**color_view.as_ref().expect("graphics color view")];
            if params.ds_attachment_needed() {
                framebuffer_views.push(*ds_image_view);
            }
            framebuffer = Some(make_framebuffer(
                device,
                *pass,
                &framebuffer_views,
                EXTENT.width,
                EXTENT.height,
                1,
            )?);

            let vert_module = create_shader_module(device, binaries.get("vert")?)?;
            let frag_module = create_shader_module(device, binaries.get("frag")?)?;

            // Depth/stencil state. This depends on the test parameters.
            let mut ds_state = default_depth_stencil_state();
            ds_state.depth_test_enable = u32::from(params.needs_depth_test());
            ds_state.depth_write_enable = u32::from(depth_writes);
            ds_state.depth_compare_op = vk::CompareOp::LESS;
            ds_state.depth_bounds_test_enable = vk::FALSE;
            ds_state.min_depth_bounds = 0.0;
            ds_state.max_depth_bounds = 0.0;
            ds_state.stencil_test_enable = u32::from(params.needs_stencil_test());

            let stencil_op_state = vk::StencilOpState {
                fail_op: vk::StencilOp::KEEP,
                pass_op: if stencil_writes {
                    vk::StencilOp::REPLACE
                } else {
                    vk::StencilOp::KEEP
                },
                depth_fail_op: vk::StencilOp::KEEP,
                compare_op: vk::CompareOp::LESS,
                compare_mask: 0xFF,
                write_mask: if stencil_writes { 0xFF } else { 0 },
                reference: stencil_fail_val,
            };
            ds_state.front = stencil_op_state;
            ds_state.back = stencil_op_state;

            let mut pipeline_state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_full_viewport(EXTENT.width, EXTENT.height);
            pipeline_state.rasterization.depth_bias_enable = vk::FALSE;
            pipeline_state.depth_stencil = ds_state;

            let stages = [
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ];
            graphics_pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                *pass,
                &stages,
                &pipeline_state,
            )?);

            // When the stencil test is enabled, a second pipeline changes the reference value so the stencil test passes the second time.
            if params.needs_stencil_test() {
                pipeline_state.depth_stencil.front.reference = stencil_pass_val;
                pipeline_state.depth_stencil.back.reference = stencil_pass_val;
                graphics_pipelines.push(create_draw_pipeline(
                    device,
                    *pipeline_layout,
                    *pass,
                    &stages,
                    &pipeline_state,
                )?);
            }

            render_pass = Some(pass);
        }

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, q_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Output buffers to check the color attachment, depth/stencil attachment and output storage images.
        let color_verif_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(copy_buffer_size(tcu_color_format)?, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let depth_verif_buffer = match tcu_depth_format {
            Some(format) => Some(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(copy_buffer_size(format)?, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?),
            None => None,
        };

        let stencil_verif_buffer = match tcu_stencil_format {
            Some(format) => Some(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(copy_buffer_size(format)?, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?),
            None => None,
        };

        let mut storage_verif_buffers: Vec<BufferWithMemory<'_>> = Vec::with_capacity(descriptors.len());
        for desc in &descriptors {
            let tcu_storage_format = crate::tcu::texture::map_vk_format(aspect_storage_format(desc.aspect))
                .expect("the storage formats have texture formats");
            storage_verif_buffers.push(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(
                    copy_buffer_size(tcu_storage_format)?,
                    vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        // Buffers storing the clear value of the depth/stencil image (compute only).
        let mut depth_clear_buf = None;
        let mut stencil_clear_buf = None;
        if params.use_compute {
            if let Some(format) = tcu_depth_format {
                let mut clear_level = TextureLevel::new(format, EXTENT.width, EXTENT.height, EXTENT.depth)?;
                clear_depth(&mut clear_level.get_access(), depth_clear_value);
                depth_clear_buf = Some(create_host_buffer(
                    context,
                    clear_level.data(),
                    vk::BufferUsageFlags::TRANSFER_SRC,
                )?);
            }
            if let Some(format) = tcu_stencil_format {
                let mut clear_level = TextureLevel::new(format, EXTENT.width, EXTENT.height, EXTENT.depth)?;
                clear_stencil(&mut clear_level.get_access(), stencil_clear_val);
                stencil_clear_buf = Some(create_host_buffer(
                    context,
                    clear_level.data(),
                    vk::BufferUsageFlags::TRANSFER_SRC,
                )?);
            }
        }

        begin_command_buffer(device, cmd)?;

        // Transition layout for output images.
        let shader_stage = if params.use_compute {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            vk::PipelineStageFlags::FRAGMENT_SHADER
        };
        let output_img_barriers: Vec<vk::ImageMemoryBarrier> = output_images
            .iter()
            .map(|output_img| {
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    output_img.get(),
                    color_srr,
                )
            })
            .collect();
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            shader_stage,
            &output_img_barriers,
        );

        // Clear color and depth/stencil buffer.
        let mut pre_transfer_barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
        if let Some(color) = &color_buffer {
            pre_transfer_barriers.push(make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                color.get(),
                color_srr,
            ));
        }
        pre_transfer_barriers.push(make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            ds_image.get(),
            depth_stencil_srr,
        ));
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &pre_transfer_barriers,
        );

        if let Some(color) = &color_buffer {
            let color_clear_value = vk::ClearColorValue {
                float32: color_clear_val,
            };
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    color.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &color_clear_value,
                    &[color_srr],
                )
            };
        }

        if params.use_compute {
            // vkCmdClearDepthStencilImage is not supported on compute queues, so vkCmdCopyBufferToImage clears instead.
            if let Some(buffer) = &depth_clear_buf {
                unsafe {
                    device.cmd_copy_buffer_to_image(
                        cmd,
                        buffer.get(),
                        ds_image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[make_buffer_image_copy(vk::ImageAspectFlags::DEPTH)],
                    )
                };
            }
            if let Some(buffer) = &stencil_clear_buf {
                unsafe {
                    device.cmd_copy_buffer_to_image(
                        cmd,
                        buffer.get(),
                        ds_image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[make_buffer_image_copy(vk::ImageAspectFlags::STENCIL)],
                    )
                };
            }
        } else {
            let ds_clear_value = vk::ClearDepthStencilValue {
                depth: depth_clear_value,
                stencil: stencil_clear_val,
            };
            unsafe {
                device.cmd_clear_depth_stencil_image(
                    cmd,
                    ds_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &ds_clear_value,
                    &[depth_stencil_srr],
                )
            };
        }

        // Transitions after clear.
        let graphics_accesses = vk::AccessFlags::COLOR_ATTACHMENT_READ
            | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            | vk::AccessFlags::INPUT_ATTACHMENT_READ
            | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
            | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
        let compute_accesses = vk::AccessFlags::SHADER_READ;

        let dst_accesses = if params.use_compute {
            compute_accesses
        } else {
            graphics_accesses
        };
        let dst_stage = if params.use_compute {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            vk::PipelineStageFlags::ALL_GRAPHICS
        };

        let mut post_transfer_barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
        if let Some(color) = &color_buffer {
            post_transfer_barriers.push(make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                graphics_accesses,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                color_layout,
                color.get(),
                color_srr,
            ));
        }
        post_transfer_barriers.push(make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            dst_accesses,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            params.layout,
            ds_image.get(),
            depth_stencil_srr,
        ));
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage,
            &post_transfer_barriers,
        );

        let bind_point = if params.use_compute {
            vk::PipelineBindPoint::COMPUTE
        } else {
            vk::PipelineBindPoint::GRAPHICS
        };
        unsafe {
            device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &descriptor_sets, &[] as &[u32])
        };

        if let Some(pipeline) = &compute_pipeline {
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, **pipeline);
                device.cmd_dispatch(cmd, EXTENT.width, EXTENT.height, 1);
            }
        } else {
            let render_pass = render_pass.as_ref().expect("graphics render pass");
            let framebuffer = framebuffer.as_ref().expect("graphics framebuffer");

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**render_pass)
                .framebuffer(**framebuffer)
                .render_area(rect_2d(EXTENT.width, EXTENT.height));
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

            let use_second_draw = params.depth_buffer_needed();

            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[0]) };
            {
                let pc_data = if use_second_draw {
                    // Two draws: the first draw will use the red color.
                    PushConstantData::new(
                        color_fail_val,
                        if params.needs_depth_test() {
                            depth_fail_value
                        } else {
                            depth_pass_value
                        },
                    )
                } else {
                    // If there will be no more draws, the first one needs to pass and use the right color.
                    PushConstantData::new(color_pass_val, depth_pass_value)
                };

                unsafe {
                    device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, pc_data.as_bytes());
                    device.cmd_draw(cmd, 3, 1, 0, 0);
                }
            }
            if use_second_draw {
                // The second draw, if used, always needs to pass and use the right color.
                if params.needs_stencil_test() {
                    // Pipeline with a good stencil reference value.
                    debug_assert!(graphics_pipelines.len() > 1);
                    unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipelines[1]) };
                }
                let pc_data = PushConstantData::new(color_pass_val, depth_pass_value);

                unsafe {
                    device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, pc_data.as_bytes());
                    device.cmd_draw(cmd, 3, 1, 0, 0);
                }
            }

            unsafe { device.cmd_end_render_pass(cmd) };
        }

        // Copy color attachment.
        if let Some(color) = &color_buffer {
            let copy_region = make_buffer_image_copy(vk::ImageAspectFlags::COLOR);
            let color_post_write_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                color_layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color.get(),
                color_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                &[color_post_write_barrier],
            );
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    color.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_verif_buffer.get(),
                    &[copy_region],
                )
            };
        }

        // Copy aspects of DS attachment.
        {
            let (src_access_mask, src_stage_mask) = if params.use_compute {
                (vk::AccessFlags::SHADER_READ, vk::PipelineStageFlags::COMPUTE_SHADER)
            } else {
                (
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                )
            };

            let ds_post_write_barrier = make_image_memory_barrier(
                src_access_mask,
                vk::AccessFlags::TRANSFER_READ,
                params.layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                ds_image.get(),
                depth_stencil_srr,
            );
            image_barrier(
                device,
                cmd,
                src_stage_mask,
                vk::PipelineStageFlags::TRANSFER,
                &[ds_post_write_barrier],
            );

            if let Some(buffer) = &depth_verif_buffer {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        ds_image.get(),
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        buffer.get(),
                        &[make_buffer_image_copy(vk::ImageAspectFlags::DEPTH)],
                    )
                };
            }

            if let Some(buffer) = &stencil_verif_buffer {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        ds_image.get(),
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        buffer.get(),
                        &[make_buffer_image_copy(vk::ImageAspectFlags::STENCIL)],
                    )
                };
            }
        }

        // Copy storage images.
        {
            let storage_post_barriers: Vec<vk::ImageMemoryBarrier> = output_images
                .iter()
                .map(|out_img| {
                    make_image_memory_barrier(
                        vk::AccessFlags::SHADER_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::GENERAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        out_img.get(),
                        color_srr,
                    )
                })
                .collect();
            image_barrier(
                device,
                cmd,
                shader_stage,
                vk::PipelineStageFlags::TRANSFER,
                &storage_post_barriers,
            );

            let copy_region = make_buffer_image_copy(vk::ImageAspectFlags::COLOR);
            debug_assert_eq!(output_images.len(), storage_verif_buffers.len());
            for (image, buffer) in output_images.iter().zip(&storage_verif_buffers) {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        image.get(),
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        buffer.get(),
                        &[copy_region],
                    )
                };
            }
        }

        // Transfer to host barrier for buffers.
        let transfer_to_host_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[transfer_to_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify the different buffers.
        let size = [EXTENT.width, EXTENT.height, EXTENT.depth];
        let pixels = |buffer: &BufferWithMemory<'_>, format: crate::tcu::TextureFormat| -> Result<Vec<u8>, TestError> {
            invalidate_alloc(device, buffer.get_allocation())?;
            let byte_count = copy_buffer_size(format)? as usize;
            Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), byte_count) }.to_vec())
        };

        // Verify color buffer contents.
        if !params.use_compute {
            let bytes = pixels(&color_verif_buffer, tcu_color_format)?;
            let color_pixels = ConstPixelBufferAccess::new(tcu_color_format, size, &bytes);
            let mut color_ok = true;
            for y in 0..EXTENT.height {
                for x in 0..EXTENT.width {
                    let pixel = color_pixels.get_pixel(x, y, 0);
                    if (0..4).any(|c| pixel[c] != color_pass_val[c]) {
                        color_ok = false;
                    }
                }
            }
            if !color_ok {
                log::info!("ColorResult: comparison failed");
                return Ok(TestStatus::fail(
                    "Unexpected color buffer contents; check log for details",
                ));
            }
        }

        // Verify depth buffer contents.
        if let (Some(format), Some(buffer)) = (tcu_depth_format, &depth_verif_buffer) {
            let bytes = pixels(buffer, format)?;
            let depth_pixels = ConstPixelBufferAccess::new(format, size, &bytes);
            let ref_depth_val = if depth_writes {
                depth_pass_value
            } else {
                depth_clear_value
            };

            let mut depth_ok = true;
            for y in 0..EXTENT.height {
                for x in 0..EXTENT.width {
                    if (depth_pixels.get_pix_depth(x, y, 0) - ref_depth_val).abs() > 0.1 {
                        depth_ok = false;
                    }
                }
            }
            if !depth_ok {
                log::info!("DepthResult: comparison failed");
                return Ok(TestStatus::fail(
                    "Unexpected value in depth buffer; check log for details",
                ));
            }
        }

        // Verify stencil buffer contents.
        if let (Some(format), Some(buffer)) = (tcu_stencil_format, &stencil_verif_buffer) {
            let bytes = pixels(buffer, format)?;
            let stencil_pixels = ConstPixelBufferAccess::new(format, size, &bytes);
            let ref_stencil_val = if stencil_writes {
                stencil_pass_val
            } else {
                stencil_clear_val
            };

            let mut stencil_ok = true;
            for y in 0..EXTENT.height {
                for x in 0..EXTENT.width {
                    if stencil_pixels.get_pix_stencil(x, y, 0) != ref_stencil_val {
                        stencil_ok = false;
                    }
                }
            }
            if !stencil_ok {
                log::info!("StencilResult: comparison failed");
                return Ok(TestStatus::fail(
                    "Unexpected value in stencil buffer; check log for details",
                ));
            }
        }

        // Verify output images.
        for (buffer_idx, (buffer, desc)) in storage_verif_buffers.iter().zip(&descriptors).enumerate() {
            let buffer_format = crate::tcu::texture::map_vk_format(aspect_storage_format(desc.aspect))
                .expect("the storage formats have texture formats");
            let bytes = pixels(buffer, buffer_format)?;
            let storage_pixels = ConstPixelBufferAccess::new(buffer_format, size, &bytes);

            let mut storage_ok = true;
            for y in 0..EXTENT.height {
                for x in 0..EXTENT.width {
                    if desc.aspect == vk::ImageAspectFlags::DEPTH {
                        let pixel = storage_pixels.get_pixel(x, y, 0);
                        let expected = [depth_clear_value, 0.0, 0.0, 1.0];
                        let thresholds = [0.1f32, 0.0, 0.0, 0.0];
                        if (0..4).any(|c| (pixel[c] - expected[c]).abs() > thresholds[c]) {
                            storage_ok = false;
                        }
                    } else if storage_pixels.get_pixel_uint(x, y, 0)[0] != stencil_clear_val {
                        storage_ok = false;
                    }
                }
            }

            if !storage_ok {
                let aspect_name = if desc.aspect == vk::ImageAspectFlags::DEPTH {
                    "depth"
                } else {
                    "stencil"
                };
                log::info!("Storage{buffer_idx}: comparison failed");
                return Ok(TestStatus::fail(format!(
                    "Unexpected value in {aspect_name} storage buffer {buffer_idx}; check log for details"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn layout_group_name(layout: vk::ImageLayout) -> &'static str {
    match layout {
        vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL => "depth_read_only_stencil_attachment_optimal",
        vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL => "depth_attachment_stencil_read_only_optimal",
        vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL => "depth_read_only_optimal",
        _ => "stencil_read_only_optimal",
    }
}

fn format_group_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::D16_UNORM => "d16_unorm",
        vk::Format::X8_D24_UNORM_PACK32 => "x8_d24_unorm_pack32",
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::S8_UINT => "s8_uint",
        vk::Format::D16_UNORM_S8_UINT => "d16_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d32_sfloat_s8_uint",
    }
}

/// `addTest` - the compute twin is registered next to the graphics case when the case can run in compute.
fn add_test(format_group: &mut TestCaseGroup, name: String, params: TestParams) {
    if params.is_compute_compatible() {
        let compute_params = TestParams {
            use_compute: true,
            ..params
        };
        format_group.add_child(Box::new(DepthStencilDescriptorCase {
            name: name.clone(),
            params,
        }) as Box<dyn TestCase>);
        format_group.add_child(Box::new(DepthStencilDescriptorCase {
            name: format!("{name}_compute"),
            params: compute_params,
        }) as Box<dyn TestCase>);
    } else {
        format_group.add_child(Box::new(DepthStencilDescriptorCase { name, params }) as Box<dyn TestCase>);
    }
}

const RO_DS_ATTACHMENT: RoAccesses = &[ReadOnlyAccess::DsAttachment];
const RO_INPUT_ATTACHMENT: RoAccesses = &[ReadOnlyAccess::InputAttachment];
const RO_SAMPLED: RoAccesses = &[ReadOnlyAccess::Sampled];
const RO_DS_SAMPLED: RoAccesses = &[ReadOnlyAccess::DsAttachment, ReadOnlyAccess::Sampled];
const RO_INPUT_SAMPLED: RoAccesses = &[ReadOnlyAccess::InputAttachment, ReadOnlyAccess::Sampled];

/// `createImageDepthStencilDescriptorTests`
pub fn create_image_depth_stencil_descriptor_tests() -> TestCaseGroup {
    let depth_stencil_formats = [
        vk::Format::D16_UNORM,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
        vk::Format::S8_UINT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];

    // Layouts used in these tests as VkDescriptorImageInfo::imageLayout.
    let tested_layouts = [
        vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL,
        vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL,
        vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL,
    ];

    // Types of read-only combinations to test.
    let ro_access_cases: [RoAccesses; 5] = [
        RO_DS_ATTACHMENT,
        RO_INPUT_ATTACHMENT,
        RO_SAMPLED,
        RO_DS_SAMPLED,
        RO_INPUT_SAMPLED,
    ];

    // Tests using depth/stencil images as descriptors.
    let mut main_group = TestCaseGroup::new("depth_stencil_descriptor");

    for layout in tested_layouts {
        let mut layout_group = TestCaseGroup::new(layout_group_name(layout));

        for format in depth_stencil_formats {
            let mut format_group = TestCaseGroup::new(format_group_name(format));

            let depth_access = get_legal_access(layout, vk::ImageAspectFlags::DEPTH);
            let stencil_access = get_legal_access(layout, vk::ImageAspectFlags::STENCIL);

            let has_depth_access = depth_access != AspectAccess::None;
            let has_stencil_access = stencil_access != AspectAccess::None;

            // Upstream `continue`s before the format group is added to its parent.
            if has_depth_access != format_has_depth(format) {
                continue;
            }
            if has_stencil_access != format_has_stencil(format) {
                continue;
            }

            let params_for =
                |depth_ro_accesses: Option<RoAccesses>, stencil_ro_accesses: Option<RoAccesses>| TestParams {
                    format,
                    layout,
                    depth_access,
                    stencil_access,
                    depth_ro_accesses,
                    stencil_ro_accesses,
                    use_compute: false,
                };

            if depth_access == AspectAccess::Ro {
                for depth_ro_case in ro_access_cases {
                    let depth_part = format!("depth_{}", ro_accesses_name(depth_ro_case));
                    if stencil_access == AspectAccess::Ro {
                        for stencil_ro_case in ro_access_cases {
                            if incompatible_input_attachment_access(
                                depth_access,
                                Some(depth_ro_case),
                                stencil_access,
                                Some(stencil_ro_case),
                            ) {
                                continue;
                            }

                            let stencil_part = format!("_stencil_{}", ro_accesses_name(stencil_ro_case));
                            add_test(
                                &mut format_group,
                                format!("{depth_part}{stencil_part}"),
                                params_for(Some(depth_ro_case), Some(stencil_ro_case)),
                            );
                        }
                    } else {
                        if incompatible_input_attachment_access(depth_access, Some(depth_ro_case), stencil_access, None)
                        {
                            continue;
                        }

                        let stencil_part = format!("_stencil_{}", stencil_access.name());
                        add_test(
                            &mut format_group,
                            format!("{depth_part}{stencil_part}"),
                            params_for(Some(depth_ro_case), None),
                        );
                    }
                }
            } else {
                let depth_part = format!("depth_{}", depth_access.name());

                if stencil_access == AspectAccess::Ro {
                    for stencil_ro_case in ro_access_cases {
                        if incompatible_input_attachment_access(
                            depth_access,
                            None,
                            stencil_access,
                            Some(stencil_ro_case),
                        ) {
                            continue;
                        }

                        let stencil_part = format!("_stencil_{}", ro_accesses_name(stencil_ro_case));
                        add_test(
                            &mut format_group,
                            format!("{depth_part}{stencil_part}"),
                            params_for(None, Some(stencil_ro_case)),
                        );
                    }
                } else {
                    if incompatible_input_attachment_access(depth_access, None, stencil_access, None) {
                        continue;
                    }

                    let stencil_part = format!("_stencil_{}", stencil_access.name());
                    add_test(
                        &mut format_group,
                        format!("{depth_part}{stencil_part}"),
                        params_for(None, None),
                    );
                }
            }

            layout_group.add_child(format_group);
        }

        main_group.add_child(layout_group);
    }

    main_group
}
