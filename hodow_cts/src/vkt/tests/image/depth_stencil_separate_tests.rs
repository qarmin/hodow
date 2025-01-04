// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageDepthStencilSeparateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Shaders are in shaders/manifest/image_depth_stencil_separate.toml (the read
// aspect and the dynamic stencil reference pick one of three programs). The reference images are computed values compared
// against the readback with the same thresholds, rather than being quantised through a `tcu::TextureLevel` first.
// `tcu::dsThresholdCompare` is written out as a per-pixel loop. `requireInstanceFunctionality` for
// VK_KHR_get_physical_device_properties2 is left out, the Context always has Vulkan 1.1.
//
// Writes one aspect of a combined depth/stencil image (render pass clear, don't care, or through the fragment test, with or
// without a multisample resolve) while the fragment shader samples the other aspect of the same image in the same render pass.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrCreateRenderpass2ExtensionDeviceCommands};

use crate::generated::shaders::image_depth_stencil_separate::{
    DSS_READ_DEPTH, DSS_READ_DEPTH_STENCIL_REF, DSS_READ_STENCIL,
};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear_depth, clear_stencil};
use crate::tcu::random::Random;
use crate::tcu::texture::ChannelType;
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
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, default_depth_stencil_state, rect_2d,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
/// 1/255 < 0.005 < 2/255
const COLOR_THRESHOLD: f32 = 0.005;
const FRAMEBUFFER_DIM: u32 = 16;
const SINGLE_SAMPLE: vk::SampleCountFlags = vk::SampleCountFlags::_1;
const MULTI_SAMPLE: vk::SampleCountFlags = vk::SampleCountFlags::_4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum WriteMechanism {
    /// Write to the aspect as a render pass clear.
    RpClear = 0,
    /// Write to the aspect implicitly as a don't care (may produce writes).
    RpDontCare,
    /// Write to the aspect running the corresponding depth or stencil test.
    TestStore,
    /// Write to the aspect running the corresponding test and then resolving the attachment.
    TestResolve,
}

fn writes_with_test(m: WriteMechanism) -> bool {
    m == WriteMechanism::TestStore || m == WriteMechanism::TestResolve
}

fn writes_with_resolve(m: WriteMechanism) -> bool {
    m == WriteMechanism::TestResolve
}

#[derive(Clone, Copy)]
struct TestParams {
    /// In the [D16_UNORM_S8_UINT, D32_SFLOAT_S8_UINT] range.
    image_format: vk::Format,
    /// Either depth or stencil, and the other one will be the sample aspect.
    write_aspect: vk::ImageAspectFlags,
    write_mechanism: WriteMechanism,
    /// True if we should always use the general layout for the image.
    general_layout: bool,
    /// Use separate layouts for depth and stencil.
    separate_layouts: bool,
    /// Set StencilRefEXT from the shader; used when writing stencil through a test.
    dynamic_stencil_ref: bool,
}

impl TestParams {
    fn read_aspect(&self) -> vk::ImageAspectFlags {
        if self.write_aspect == vk::ImageAspectFlags::DEPTH {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        }
    }

    fn writes_depth(&self) -> bool {
        self.write_aspect == vk::ImageAspectFlags::DEPTH
    }

    fn writes_stencil(&self) -> bool {
        self.write_aspect == vk::ImageAspectFlags::STENCIL
    }

    fn reads_depth(&self) -> bool {
        self.read_aspect() == vk::ImageAspectFlags::DEPTH
    }

    fn reads_stencil(&self) -> bool {
        self.read_aspect() == vk::ImageAspectFlags::STENCIL
    }

    /// Value based on the test parameter values, usable with `de::Random`.
    fn random_seed(&self) -> u32 {
        ((self.image_format.as_raw() as u32) << 16)
            | (self.write_aspect.bits() << 8)
            | ((self.write_mechanism as u32) << 4)
            | (u32::from(self.general_layout) << 3)
            | u32::from(self.dynamic_stencil_ref)
    }

    /// The image layout that should be used during shader execution.
    fn image_layout(&self) -> vk::ImageLayout {
        if self.general_layout {
            return vk::ImageLayout::GENERAL;
        }

        if self.reads_depth() {
            vk::ImageLayout::DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL
        } else {
            vk::ImageLayout::DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL
        }
    }

    fn depth_image_layout(&self) -> vk::ImageLayout {
        if self.general_layout {
            return vk::ImageLayout::GENERAL;
        }

        if self.reads_depth() {
            vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL
        } else {
            vk::ImageLayout::DEPTH_ATTACHMENT_OPTIMAL
        }
    }

    fn stencil_image_layout(&self) -> vk::ImageLayout {
        if self.general_layout {
            return vk::ImageLayout::GENERAL;
        }

        if self.reads_stencil() {
            vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL
        } else {
            vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL
        }
    }

    /// True if the writes will happen through the corresponding fragment test.
    fn writes_in_frag_test(&self) -> bool {
        writes_with_test(self.write_mechanism)
    }

    fn is_multisample(&self) -> bool {
        self.write_mechanism == WriteMechanism::TestResolve
    }

    fn sample_count(&self) -> vk::SampleCountFlags {
        if self.is_multisample() {
            MULTI_SAMPLE
        } else {
            SINGLE_SAMPLE
        }
    }

    /// The format that stores the sampling results (see the fragment shader); both can hold any depth or stencil value and
    /// have guaranteed storage image support.
    fn storage_image_format(&self) -> vk::Format {
        if self.reads_depth() {
            vk::Format::R32_SFLOAT
        } else {
            vk::Format::R32_UINT
        }
    }
}

/// `VertexData`
#[repr(C)]
#[derive(Clone, Copy)]
struct VertexData {
    coords: [f32; 4],
    color: [f32; 4],
    /// `.x` is the stencil ref value for the vertex, the rest is unused.
    extra: [i32; 4],
}

impl VertexData {
    fn binding_descriptions() -> Vec<vk::VertexInputBindingDescription> {
        vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<VertexData>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }]
    }

    fn attribute_descriptions() -> Vec<vk::VertexInputAttributeDescription> {
        vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: std::mem::offset_of!(VertexData, coords) as u32,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: std::mem::offset_of!(VertexData, color) as u32,
            },
            vk::VertexInputAttributeDescription {
                location: 2,
                binding: 0,
                format: vk::Format::R32G32B32A32_SINT,
                offset: std::mem::offset_of!(VertexData, extra) as u32,
            },
        ]
    }
}

fn framebuffer_extent() -> vk::Extent3D {
    vk::Extent3D {
        width: FRAMEBUFFER_DIM,
        height: FRAMEBUFFER_DIM,
        depth: 1,
    }
}

/// Usages for the depth/stencil image.
fn depth_stencil_usage(multisample: bool) -> vk::ImageUsageFlags {
    let mut usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::SAMPLED;
    if !multisample {
        usage |= vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    }
    usage
}

/// Usage for the storage image.
fn storage_image_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC
}

/// `makeImageCreateInfo`
fn make_image_create_info(
    format: vk::Format,
    extent: vk::Extent3D,
    sample_count: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(sample_count)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

struct DepthStencilSeparateCase {
    name: String,
    params: TestParams,
}

impl TestCase for DepthStencilSeparateCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        context.require_device_functionality("VK_KHR_maintenance7")?;
        context.require_device_functionality("VK_KHR_format_feature_flags2")?;

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut m7_properties = vk::PhysicalDeviceMaintenance7PropertiesKHR::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut m7_properties);
            unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
        }
        if m7_properties.separate_depth_stencil_attachment_access == vk::FALSE {
            return Err(TestError::NotSupported(
                "separateDepthStencilAttachmentAccess not supported".to_string(),
            ));
        }

        // Single-sample and multi-sample usages differ slightly, so both are checked.
        let mut usage_cases = vec![(SINGLE_SAMPLE, depth_stencil_usage(false))];
        if params.is_multisample() {
            usage_cases.push((params.sample_count(), depth_stencil_usage(true)));
        }

        for (sample_count, ds_usage) in usage_cases {
            let ds_create_info =
                make_image_create_info(params.image_format, framebuffer_extent(), sample_count, ds_usage);

            let img_format_info = vk::PhysicalDeviceImageFormatInfo2 {
                format: ds_create_info.format,
                type_: ds_create_info.image_type,
                tiling: ds_create_info.tiling,
                usage: ds_create_info.usage,
                flags: ds_create_info.flags,
                ..Default::default()
            };
            let mut img_format_properties = vk::ImageFormatProperties2::default();

            match unsafe {
                instance.get_physical_device_image_format_properties2(
                    physical_device,
                    &img_format_info,
                    &mut img_format_properties,
                )
            } {
                Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) | Err(vk::ErrorCode::IMAGE_USAGE_NOT_SUPPORTED_KHR) => {
                    return Err(TestError::NotSupported(format!(
                        "Format not supported or usage not supported for this format with sample count {}",
                        sample_count.bits()
                    )));
                }
                result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
            }

            if !img_format_properties
                .image_format_properties
                .sample_counts
                .contains(ds_create_info.samples)
            {
                return Err(TestError::NotSupported(format!(
                    "Sample count {} not supported for this format",
                    sample_count.bits()
                )));
            }
        }

        let mut fp3 = vk::FormatProperties3::default();
        {
            let mut fp2 = vk::FormatProperties2::builder().push_next(&mut fp3);
            unsafe { instance.get_physical_device_format_properties2(physical_device, params.image_format, &mut fp2) };
        }

        let required_features = vk::FormatFeatureFlags2::DEPTH_STENCIL_ATTACHMENT
            | vk::FormatFeatureFlags2::SAMPLED_IMAGE
            | vk::FormatFeatureFlags2::TRANSFER_SRC
            | vk::FormatFeatureFlags2::TRANSFER_DST;
        if !fp3.optimal_tiling_features.contains(required_features) {
            return Err(TestError::NotSupported(
                "Required features not supported for this format".to_string(),
            ));
        }

        if params.dynamic_stencil_ref {
            context.require_device_functionality("VK_EXT_shader_stencil_export")?;
        }

        if params.is_multisample() {
            context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;
        }

        if params.separate_layouts {
            context.require_device_functionality("VK_KHR_separate_depth_stencil_layouts")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.reads_stencil() {
            DSS_READ_STENCIL.programs
        } else if self.params.dynamic_stencil_ref {
            DSS_READ_DEPTH_STENCIL_REF.programs
        } else {
            DSS_READ_DEPTH.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthStencilSeparateInstance {
            context,
            params: self.params,
        })
    }
}

/// `AttachmentDescription` - an attachment description with the stencil layouts render pass 2 can chain to it.
#[derive(Clone, Copy)]
struct AttachmentDescription {
    format: vk::Format,
    samples: vk::SampleCountFlags,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    initial_layout: vk::ImageLayout,
    final_layout: vk::ImageLayout,
    initial_stencil_layout: vk::ImageLayout,
    final_stencil_layout: vk::ImageLayout,
}

impl AttachmentDescription {
    #[allow(clippy::too_many_arguments)]
    fn new(
        format: vk::Format,
        samples: vk::SampleCountFlags,
        load_op: vk::AttachmentLoadOp,
        store_op: vk::AttachmentStoreOp,
        stencil_load_op: vk::AttachmentLoadOp,
        stencil_store_op: vk::AttachmentStoreOp,
        initial_layout: vk::ImageLayout,
        final_layout: vk::ImageLayout,
    ) -> Self {
        Self {
            format,
            samples,
            load_op,
            store_op,
            stencil_load_op,
            stencil_store_op,
            initial_layout,
            final_layout,
            initial_stencil_layout: vk::ImageLayout::UNDEFINED,
            final_stencil_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn with_stencil_layouts(mut self, initial: vk::ImageLayout, final_layout: vk::ImageLayout) -> Self {
        self.initial_stencil_layout = initial;
        self.final_stencil_layout = final_layout;
        self
    }

    fn to_description(self) -> vk::AttachmentDescription {
        vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: self.format,
            samples: self.samples,
            load_op: self.load_op,
            store_op: self.store_op,
            stencil_load_op: self.stencil_load_op,
            stencil_store_op: self.stencil_store_op,
            initial_layout: self.initial_layout,
            final_layout: self.final_layout,
        }
    }

    fn to_description2(self) -> vk::AttachmentDescription2 {
        vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: self.format,
            samples: self.samples,
            load_op: self.load_op,
            store_op: self.store_op,
            stencil_load_op: self.stencil_load_op,
            stencil_store_op: self.stencil_store_op,
            initial_layout: self.initial_layout,
            final_layout: self.final_layout,
        }
    }
}

/// `AttachmentReference`
#[derive(Clone, Copy)]
struct AttachmentReference {
    attachment: u32,
    layout: vk::ImageLayout,
    stencil_layout: vk::ImageLayout,
}

impl AttachmentReference {
    fn new(attachment: u32, layout: vk::ImageLayout) -> Self {
        Self {
            attachment,
            layout,
            stencil_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn with_stencil_layout(mut self, stencil_layout: vk::ImageLayout) -> Self {
        self.stencil_layout = stencil_layout;
        self
    }

    fn to_reference(self) -> vk::AttachmentReference {
        vk::AttachmentReference {
            attachment: self.attachment,
            layout: self.layout,
        }
    }

    fn to_reference2(self) -> vk::AttachmentReference2 {
        // No input attachments are used here, so no aspect mask.
        vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: self.attachment,
            layout: self.layout,
            aspect_mask: vk::ImageAspectFlags::empty(),
        }
    }
}

/// `makeSeparateRenderPass`
fn make_separate_render_pass<'a>(
    device: &'a Device,
    params: &TestParams,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let main_sample_count = params.sample_count();
    let is_multisample = params.is_multisample();
    let separate_layouts = params.separate_layouts;

    let mut att_descs: Vec<AttachmentDescription> = Vec::with_capacity(4);

    // Color attachment.
    att_descs.push(AttachmentDescription::new(
        COLOR_FORMAT,
        main_sample_count,
        vk::AttachmentLoadOp::CLEAR,
        if is_multisample {
            vk::AttachmentStoreOp::DONT_CARE
        } else {
            vk::AttachmentStoreOp::STORE
        },
        vk::AttachmentLoadOp::DONT_CARE,
        vk::AttachmentStoreOp::DONT_CARE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    ));

    let initial_ds_layout = if separate_layouts {
        params.depth_image_layout()
    } else {
        params.image_layout()
    };
    let final_ds_layout = initial_ds_layout;
    let initial_stencil_layout = if separate_layouts {
        params.stencil_image_layout()
    } else {
        vk::ImageLayout::UNDEFINED
    };
    let final_stencil_layout = initial_stencil_layout;

    // One of the aspects is read by the fragment shader and has its test disabled, the other has its test enabled and is
    // written with the selected write mechanism. The read-only one is pre-loaded and preserves its values through the store
    // op; that store will likely result in SYNC-HAZARD-WRITE-AFTER-READ, but the fragment shader reads the same pixel it is
    // working with, so there is no real data race.
    let read_only = (vk::AttachmentLoadOp::LOAD, vk::AttachmentStoreOp::STORE);

    let read_write = match params.write_mechanism {
        WriteMechanism::RpClear => (vk::AttachmentLoadOp::CLEAR, vk::AttachmentStoreOp::STORE),
        WriteMechanism::RpDontCare => (vk::AttachmentLoadOp::DONT_CARE, vk::AttachmentStoreOp::DONT_CARE),
        WriteMechanism::TestStore | WriteMechanism::TestResolve => {
            (vk::AttachmentLoadOp::LOAD, vk::AttachmentStoreOp::STORE)
        }
    };

    let ((depth_load_op, depth_store_op), (stencil_load_op, stencil_store_op)) = if params.reads_stencil() {
        (read_write, read_only)
    } else {
        (read_only, read_write)
    };

    // Depth/stencil attachment.
    att_descs.push(
        AttachmentDescription::new(
            params.image_format,
            main_sample_count,
            depth_load_op,
            if is_multisample {
                vk::AttachmentStoreOp::DONT_CARE
            } else {
                depth_store_op
            },
            stencil_load_op,
            if is_multisample {
                vk::AttachmentStoreOp::DONT_CARE
            } else {
                stencil_store_op
            },
            initial_ds_layout,
            final_ds_layout,
        )
        .with_stencil_layouts(initial_stencil_layout, final_stencil_layout),
    );

    if is_multisample {
        // Color resolve attachment.
        att_descs.push(AttachmentDescription::new(
            COLOR_FORMAT,
            SINGLE_SAMPLE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::STORE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        ));

        // Depth/stencil resolve attachment. Data may be loaded into it because the resolve attachment is sampled during the
        // render pass, so it needs the right data from the start.
        att_descs.push(
            AttachmentDescription::new(
                params.image_format,
                SINGLE_SAMPLE,
                depth_load_op,
                depth_store_op,
                stencil_load_op,
                stencil_store_op,
                initial_ds_layout,
                final_ds_layout,
            )
            .with_stencil_layouts(initial_stencil_layout, final_stencil_layout),
        );
    }

    let mut att_refs: Vec<AttachmentReference> = Vec::with_capacity(4);

    att_refs.push(AttachmentReference::new(0, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL));
    att_refs.push(AttachmentReference::new(1, final_ds_layout).with_stencil_layout(final_stencil_layout));

    if is_multisample {
        // Resolve attachment references.
        att_refs.push(AttachmentReference::new(2, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL));
        att_refs.push(AttachmentReference::new(3, final_ds_layout).with_stencil_layout(final_stencil_layout));
    }

    if is_multisample || separate_layouts {
        let mut descriptions: Vec<vk::AttachmentDescription2> =
            att_descs.iter().map(|desc| desc.to_description2()).collect();
        let stencil_description = vk::AttachmentDescriptionStencilLayout {
            stencil_initial_layout: att_descs[1].initial_stencil_layout,
            stencil_final_layout: att_descs[1].final_stencil_layout,
            ..Default::default()
        };

        let mut references: Vec<vk::AttachmentReference2> =
            att_refs.iter().map(|reference| reference.to_reference2()).collect();
        let stencil_reference = vk::AttachmentReferenceStencilLayout {
            stencil_layout: att_refs[1].stencil_layout,
            ..Default::default()
        };

        if separate_layouts {
            descriptions[1].next = std::ptr::addr_of!(stencil_description).cast();
            references[1].next = std::ptr::addr_of!(stencil_reference).cast();
        }

        let ds_resolve = vk::SubpassDescriptionDepthStencilResolve {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_DEPTH_STENCIL_RESOLVE,
            next: std::ptr::null(),
            depth_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
            stencil_resolve_mode: vk::ResolveModeFlags::SAMPLE_ZERO,
            depth_stencil_resolve_attachment: if is_multisample {
                &references[3]
            } else {
                std::ptr::null()
            },
        };

        let subpass = vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: if is_multisample {
                std::ptr::addr_of!(ds_resolve).cast()
            } else {
                std::ptr::null()
            },
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: 0,
            input_attachments: std::ptr::null(),
            color_attachment_count: 1,
            color_attachments: &references[0],
            resolve_attachments: if is_multisample {
                &references[2]
            } else {
                std::ptr::null()
            },
            depth_stencil_attachment: &references[1],
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
        };

        let create_info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: descriptions.len() as u32,
            attachments: descriptions.as_ptr(),
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
    } else {
        debug_assert_eq!(att_descs.len(), 2);
        debug_assert_eq!(att_refs.len(), 2);

        let descriptions: Vec<vk::AttachmentDescription> = att_descs.iter().map(|desc| desc.to_description()).collect();
        let references: Vec<vk::AttachmentReference> =
            att_refs.iter().map(|reference| reference.to_reference()).collect();

        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&references[0..1])
            .depth_stencil_attachment(&references[1])
            .build()];

        let create_info = vk::RenderPassCreateInfo::builder()
            .attachments(&descriptions)
            .subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass(&create_info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }
}

/// `getDepthThreshold`
fn get_depth_threshold(channel_type: ChannelType) -> Result<f32, TestError> {
    match channel_type {
        ChannelType::UNORM_INT16 => Ok(1.5 / 65535.0),
        ChannelType::UNSIGNED_INT_24_8_REV => Ok((1.5 / 16_777_215.0) as f32),
        // This could be exact, but it is simply made a bit stricter than 24 bits.
        ChannelType::FLOAT => Ok((1.0 / 33_554_431.0) as f32),
        other => Err(TestError::InternalError(format!(
            "unexpected depth channel type {other:?}"
        ))),
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

fn make_buffer_image_copy(aspect: vk::ImageAspectFlags) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(aspect, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: framebuffer_extent(),
    }
}

struct DepthStencilSeparateInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for DepthStencilSeparateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let mut rnd = Random::new(params.random_seed());
        let read_layout = if params.separate_layouts {
            if params.reads_depth() {
                params.depth_image_layout()
            } else {
                params.stencil_image_layout()
            }
        } else {
            params.image_layout()
        };
        let main_sample_count = params.sample_count();
        let storage_img_layout = vk::ImageLayout::GENERAL;
        let view_type = vk::ImageViewType::_2D;
        let shader_accesses = vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE;

        // One point per pixel, drawn in the middle.
        let fb_extent = framebuffer_extent();
        let pixel_count = (FRAMEBUFFER_DIM * FRAMEBUFFER_DIM) as usize;

        let get_framebuffer_coord = |c: u32, total: u32| (c as f32 + 0.5) / total as f32 * 2.0 - 1.0;

        // The vertices array always contains pseudorandom data for depth, stencil and color.
        let mut vertices: Vec<VertexData> = Vec::with_capacity(pixel_count);
        for y in 0..FRAMEBUFFER_DIM {
            for x in 0..FRAMEBUFFER_DIM {
                let x_coord = get_framebuffer_coord(x, fb_extent.width);
                let y_coord = get_framebuffer_coord(y, fb_extent.height);
                // Restrict depth values to [0.5, 1) to avoid denormals.
                let depth = rnd.get_float() * 0.5 + 0.5;
                // Avoid value zero as that may be used for clears.
                let stencil = rnd.get_int(1, 255);

                let r = rnd.get_float();
                let g = rnd.get_float();
                let b = rnd.get_float();
                let a = 1.0;

                vertices.push(VertexData {
                    coords: [x_coord, y_coord, depth, 1.0],
                    color: [r, g, b, a],
                    extra: [stencil, 0, 0, 0],
                });
            }
        }

        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Color attachment (will be verified).
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let color_buffer =
            ImageWithBuffer::new(context, FRAMEBUFFER_DIM, FRAMEBUFFER_DIM, COLOR_FORMAT, color_usage, 4)?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Depth/stencil buffer.
        let ds_srr =
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let stencil_srr = make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
        let ds_create_info = make_image_create_info(
            params.image_format,
            fb_extent,
            SINGLE_SAMPLE,
            depth_stencil_usage(false),
        );
        let ds_buffer = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            ds_create_info,
            MemoryRequirement::ANY,
        )?;

        // Image view for both aspects, to be used as the depth/stencil attachment or resolve attachment.
        let ds_image_view = make_image_view(device, ds_buffer.get(), view_type, params.image_format, ds_srr)?;

        // Multisample images, used in some variants.
        let mut _color_ms_buffer: Option<ImageWithMemory<'_>> = None;
        let mut ds_ms_buffer: Option<ImageWithMemory<'_>> = None;
        let mut color_ms_view: Option<Unique<'_, vk::ImageView>> = None;
        let mut ds_ms_view: Option<Unique<'_, vk::ImageView>> = None;

        if params.is_multisample() {
            let color_ms_create_info = make_image_create_info(
                COLOR_FORMAT,
                fb_extent,
                main_sample_count,
                vk::ImageUsageFlags::COLOR_ATTACHMENT,
            );
            let color_ms = ImageWithMemory::new(
                device,
                context.get_default_allocator(),
                color_ms_create_info,
                MemoryRequirement::ANY,
            )?;
            color_ms_view = Some(make_image_view(
                device,
                color_ms.get(),
                view_type,
                COLOR_FORMAT,
                color_srr,
            )?);
            _color_ms_buffer = Some(color_ms);

            let ds_ms_create_info = make_image_create_info(
                params.image_format,
                fb_extent,
                main_sample_count,
                depth_stencil_usage(true),
            );
            let ds_ms = ImageWithMemory::new(
                device,
                context.get_default_allocator(),
                ds_ms_create_info,
                MemoryRequirement::ANY,
            )?;
            ds_ms_view = Some(make_image_view(
                device,
                ds_ms.get(),
                view_type,
                params.image_format,
                ds_srr,
            )?);
            ds_ms_buffer = Some(ds_ms);
        }

        // Image view of the read aspect to be used for sampling. The single-sample image is always sampled.
        let read_srr = make_image_subresource_range(params.read_aspect(), 0, 1, 0, 1);
        let read_view = make_image_view(device, ds_buffer.get(), view_type, params.image_format, read_srr)?;

        // The depth/stencil buffer is sampled with unnormalized coordinates (see the shader code).
        let border_color = if params.reads_depth() {
            vk::BorderColor::FLOAT_OPAQUE_WHITE
        } else {
            vk::BorderColor::INT_OPAQUE_WHITE
        };
        let sampler_create_info = vk::SamplerCreateInfo::builder()
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
            .border_color(border_color)
            .unnormalized_coordinates(true);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        // Storage image to store sampling results and verify them.
        let storage_img_format = params.storage_image_format();
        let storage_img = ImageWithBuffer::new(
            context,
            FRAMEBUFFER_DIM,
            FRAMEBUFFER_DIM,
            storage_img_format,
            storage_image_usage(),
            4,
        )?;

        // Descriptor set layout, pool and descriptor set.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let sampled_img_info = [vk::DescriptorImageInfo::builder()
            .sampler(*sampler)
            .image_view(*read_view)
            .image_layout(read_layout)
            .build()];
        let storage_img_info = [vk::DescriptorImageInfo::builder()
            .sampler(vk::Sampler::null())
            .image_view(*storage_img.view)
            .image_layout(storage_img_layout)
            .build()];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&sampled_img_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&storage_img_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Render pass and framebuffer.
        let mut attachments: Vec<vk::ImageView> = Vec::with_capacity(4);
        if let (Some(color_ms), Some(ds_ms)) = (&color_ms_view, &ds_ms_view) {
            attachments.push(**color_ms);
            attachments.push(**ds_ms);
        }
        attachments.push(*color_buffer.view);
        attachments.push(*ds_image_view);

        let render_pass = make_separate_render_pass(device, params)?;
        let framebuffer = make_framebuffer(device, *render_pass, &attachments, fb_extent.width, fb_extent.height, 1)?;

        // Pipeline.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let depth_test_enabled = params.writes_depth() && params.writes_in_frag_test();
        let stencil_test_enabled = params.writes_stencil() && params.writes_in_frag_test();
        // VUID-vkCmdDraw-None-06887
        let stencil_pass_op = if stencil_test_enabled {
            vk::StencilOp::REPLACE
        } else {
            vk::StencilOp::KEEP
        };
        let stencil_state = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: stencil_pass_op,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0xFF,
            write_mask: 0xFF,
            reference: 0,
        };

        let mut depth_stencil_state = default_depth_stencil_state();
        depth_stencil_state.depth_test_enable = u32::from(depth_test_enabled);
        depth_stencil_state.depth_write_enable = u32::from(depth_test_enabled);
        depth_stencil_state.depth_compare_op = vk::CompareOp::ALWAYS;
        depth_stencil_state.depth_bounds_test_enable = vk::FALSE;
        depth_stencil_state.stencil_test_enable = u32::from(stencil_test_enabled);
        depth_stencil_state.front = stencil_state;
        depth_stencil_state.back = stencil_state;
        depth_stencil_state.min_depth_bounds = 0.0;
        depth_stencil_state.max_depth_bounds = 0.0;

        // To use the pseudorandom stencil values per point when the reference is not set from the shader, the reference is
        // dynamic state, changed before each draw, with a single point per draw call.
        let single_point_draws = stencil_test_enabled && !params.dynamic_stencil_ref;

        let mut pipeline_state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST)
            .with_full_viewport(fb_extent.width, fb_extent.height);
        pipeline_state.bindings = VertexData::binding_descriptions();
        pipeline_state.attributes = VertexData::attribute_descriptions();
        pipeline_state.depth_stencil = depth_stencil_state;
        pipeline_state.rasterization.depth_bias_enable = vk::FALSE;
        pipeline_state.samples = main_sample_count;
        if single_point_draws {
            pipeline_state.dynamic_states.push(vk::DynamicState::STENCIL_REFERENCE);
        }

        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &pipeline_state,
        )?;

        // Buffers used to pre-fill the depth/stencil image before the render pass (for LOAD_OP_LOAD and other interesting cases).
        let depth_copy_format = get_depth_copy_format(params.image_format)
            .ok_or_else(|| TestError::InternalError("no depth copy format".to_string()))?;
        let stencil_copy_format = get_stencil_copy_format(params.image_format)
            .ok_or_else(|| TestError::InternalError("no stencil copy format".to_string()))?;

        let mut pre_fill_depth_level = TextureLevel::new(depth_copy_format, fb_extent.width, fb_extent.height, 1)?;
        let mut pre_fill_stencil_level = TextureLevel::new(stencil_copy_format, fb_extent.width, fb_extent.height, 1)?;

        {
            let mut access = pre_fill_depth_level.get_access();
            if depth_test_enabled {
                clear_depth(&mut access, 0.0);
            } else {
                let mut point_idx = 0usize;
                for y in 0..FRAMEBUFFER_DIM {
                    for x in 0..FRAMEBUFFER_DIM {
                        access.set_pix_depth(vertices[point_idx].coords[2], x, y, 0);
                        point_idx += 1;
                    }
                }
            }
        }

        {
            let mut access = pre_fill_stencil_level.get_access();
            if stencil_test_enabled {
                clear_stencil(&mut access, 0);
            } else {
                let mut point_idx = 0usize;
                for y in 0..FRAMEBUFFER_DIM {
                    for x in 0..FRAMEBUFFER_DIM {
                        access.set_pix_stencil(vertices[point_idx].extra[0] as u32, x, y, 0);
                        point_idx += 1;
                    }
                }
            }
        }

        let pre_fill_depth_buffer =
            create_host_buffer(context, pre_fill_depth_level.data(), vk::BufferUsageFlags::TRANSFER_SRC)?;
        let pre_fill_stencil_buffer = create_host_buffer(
            context,
            pre_fill_stencil_level.data(),
            vk::BufferUsageFlags::TRANSFER_SRC,
        )?;

        // Buffers used to verify depth/stencil values.
        let depth_buffer_size = pre_fill_depth_level.data().len() as vk::DeviceSize;
        let stencil_buffer_size = pre_fill_stencil_level.data().len() as vk::DeviceSize;
        let depth_verif_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(depth_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let stencil_verif_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(stencil_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Command buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let mut ds_layout = vk::ImageLayout::UNDEFINED;
        let depth_copy_region = make_buffer_image_copy(vk::ImageAspectFlags::DEPTH);
        let stencil_copy_region = make_buffer_image_copy(vk::ImageAspectFlags::STENCIL);
        let color_copy_region = make_buffer_image_copy(vk::ImageAspectFlags::COLOR);

        // Transfer pre-fill contents to the depth/stencil image.
        let pre_copy_layout = if params.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let pre_fill_prepare_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            ds_layout,
            pre_copy_layout,
            ds_buffer.get(),
            ds_srr,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[pre_fill_prepare_barrier],
        );
        ds_layout = pre_copy_layout;

        unsafe {
            device.cmd_copy_buffer_to_image(
                cmd,
                pre_fill_depth_buffer.get(),
                ds_buffer.get(),
                ds_layout,
                &[depth_copy_region],
            );
            device.cmd_copy_buffer_to_image(
                cmd,
                pre_fill_stencil_buffer.get(),
                ds_buffer.get(),
                ds_layout,
                &[stencil_copy_region],
            );
        }

        // Transition image to the layout used in the render pass. The depth/stencil resolve operations happen as part of
        // COLOR_ATTACHMENT_OUTPUT using COLOR_ATTACHMENT_WRITE access, despite the names.
        let fragment_and_tests_stages = vk::PipelineStageFlags::FRAGMENT_SHADER
            | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
            | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
        let tests_stages = vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
        let ds_read_write_access =
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;

        if params.separate_layouts {
            let depth_access = if params.reads_depth() {
                shader_accesses | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ /* load_op_load */
            } else {
                ds_read_write_access
            };
            let depth_stages = if params.reads_depth() {
                fragment_and_tests_stages
            } else {
                tests_stages
            };

            let stencil_access = if params.reads_stencil() {
                shader_accesses | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ /* load_op_load */
            } else {
                ds_read_write_access
            };
            let stencil_stages = if params.reads_stencil() {
                fragment_and_tests_stages
            } else {
                tests_stages
            };

            let depth_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                depth_access,
                ds_layout,
                params.depth_image_layout(),
                ds_buffer.get(),
                depth_srr,
            );
            let stencil_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                stencil_access,
                ds_layout,
                params.stencil_image_layout(),
                ds_buffer.get(),
                stencil_srr,
            );

            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                depth_stages | stencil_stages,
                &[depth_barrier, stencil_barrier],
            );
            // There is no single dsLayout for now.
            ds_layout = vk::ImageLayout::UNDEFINED;
        } else {
            let rp_accesses = if params.is_multisample() {
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | shader_accesses
            } else {
                ds_read_write_access | shader_accesses
            };
            let rp_stages = if params.is_multisample() {
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::FRAGMENT_SHADER
            } else {
                tests_stages | vk::PipelineStageFlags::FRAGMENT_SHADER
            };
            let rp_prepare_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                rp_accesses,
                ds_layout,
                read_layout,
                ds_buffer.get(),
                ds_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                rp_stages,
                &[rp_prepare_barrier],
            );
            ds_layout = read_layout;
        }

        if let Some(ds_ms) = &ds_ms_buffer {
            // Transfer the multisample image to the layout used in the render pass.
            let ms_accesses = ds_read_write_access | shader_accesses;
            let ms_stages = tests_stages | vk::PipelineStageFlags::FRAGMENT_SHADER;
            let ms_prepare_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                ms_accesses,
                vk::ImageLayout::UNDEFINED,
                read_layout,
                ds_ms.get(),
                ds_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                ms_stages,
                &[ms_prepare_barrier],
            );
        }

        // Transition storage image to the general layout to be used in the frag shader.
        let storage_prepare_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            shader_accesses,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            storage_img.image.get(),
            color_srr,
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            &[storage_prepare_barrier],
        );

        // Clear values for those images that need it.
        let mut clear_values = vec![clear_value_color([0.0, 0.0, 0.0, 0.0])];
        if params.write_mechanism == WriteMechanism::RpClear {
            clear_values.push(vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            });
        }

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(fb_extent.width, fb_extent.height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            if single_point_draws {
                for (i, vertex) in vertices.iter().enumerate() {
                    device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, vertex.extra[0] as u32);
                    device.cmd_draw(cmd, 1, 1, i as u32, 0);
                }
            } else {
                device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            }
            device.cmd_end_render_pass(cmd);
        }

        // Prepare images for verification copy.
        let mut pre_copy_barriers: Vec<vk::ImageMemoryBarrier> = Vec::with_capacity(4);

        let pre_verif_layout = if params.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };

        // Color and storage preparation.
        pre_copy_barriers.push(make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_buffer.image.get(),
            color_srr,
        ));
        pre_copy_barriers.push(make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            storage_img.image.get(),
            color_srr,
        ));

        // Depth/stencil preparation.
        if params.separate_layouts {
            let depth_access = if params.reads_depth() {
                shader_accesses | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE /* store_op_store */
            } else {
                ds_read_write_access
            };
            let stencil_access = if params.reads_stencil() {
                shader_accesses | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE /* store_op_store */
            } else {
                ds_read_write_access
            };

            pre_copy_barriers.push(make_image_memory_barrier(
                depth_access,
                vk::AccessFlags::TRANSFER_READ,
                params.depth_image_layout(),
                pre_verif_layout,
                ds_buffer.get(),
                depth_srr,
            ));
            pre_copy_barriers.push(make_image_memory_barrier(
                stencil_access,
                vk::AccessFlags::TRANSFER_READ,
                params.stencil_image_layout(),
                pre_verif_layout,
                ds_buffer.get(),
                stencil_srr,
            ));
        } else {
            // Depth/stencil resolve happens with COLOR_ATTACHMENT_WRITE access.
            let prev_access = if params.is_multisample() {
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            } else {
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            };

            pre_copy_barriers.push(make_image_memory_barrier(
                prev_access,
                vk::AccessFlags::TRANSFER_READ,
                ds_layout,
                pre_verif_layout,
                ds_buffer.get(),
                ds_srr,
            ));
        }

        let write_stages =
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | tests_stages | vk::PipelineStageFlags::FRAGMENT_SHADER;
        image_barrier(
            device,
            cmd,
            write_stages,
            vk::PipelineStageFlags::TRANSFER,
            &pre_copy_barriers,
        );
        ds_layout = pre_verif_layout;

        // Copy images for verification.
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                color_buffer.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.buffer.get(),
                &[color_copy_region],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                storage_img.image.get(),
                vk::ImageLayout::GENERAL,
                storage_img.buffer.get(),
                &[color_copy_region],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                ds_buffer.get(),
                ds_layout,
                depth_verif_buffer.get(),
                &[depth_copy_region],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                ds_buffer.get(),
                ds_layout,
                stencil_verif_buffer.get(),
                &[stencil_copy_region],
            );
        }

        // Sync to host reads.
        let pre_host_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[pre_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify color and depth/stencil buffers.
        invalidate_alloc(device, color_buffer.buffer.get_allocation())?;
        invalidate_alloc(device, storage_img.buffer.get_allocation())?;
        invalidate_alloc(device, depth_verif_buffer.get_allocation())?;
        invalidate_alloc(device, stencil_verif_buffer.get_allocation())?;

        let color_bytes =
            unsafe { std::slice::from_raw_parts(color_buffer.buffer.get_allocation().get_host_ptr(), pixel_count * 4) };
        let storage_bytes =
            unsafe { std::slice::from_raw_parts(storage_img.buffer.get_allocation().get_host_ptr(), pixel_count * 4) };
        let depth_bytes = unsafe {
            std::slice::from_raw_parts(
                depth_verif_buffer.get_allocation().get_host_ptr(),
                depth_buffer_size as usize,
            )
        };
        let stencil_bytes = unsafe {
            std::slice::from_raw_parts(
                stencil_verif_buffer.get_allocation().get_host_ptr(),
                stencil_buffer_size as usize,
            )
        };

        let size = [fb_extent.width, fb_extent.height, 1];
        let color_access = ConstPixelBufferAccess::new(
            crate::tcu::texture::map_vk_format(COLOR_FORMAT).expect("RGBA8 has a texture format"),
            size,
            color_bytes,
        );
        let storage_access = ConstPixelBufferAccess::new(
            crate::tcu::texture::map_vk_format(storage_img_format).expect("the storage formats have texture formats"),
            size,
            storage_bytes,
        );
        let depth_access = ConstPixelBufferAccess::new(depth_copy_format, size, depth_bytes);
        let stencil_access = ConstPixelBufferAccess::new(stencil_copy_format, size, stencil_bytes);

        let depth_threshold = get_depth_threshold(depth_copy_format.type_)?;

        // Compare against the reference values pixel by pixel.
        let mut color_ok = true;
        let mut storage_ok = true;
        let mut depth_ok = true;
        let mut stencil_ok = true;
        // A read aspect is verified through the storage image instead, and a don't care write has nothing to verify.
        let check_depth =
            !(params.reads_depth() || (params.writes_depth() && params.write_mechanism == WriteMechanism::RpDontCare));
        let check_stencil = !(params.reads_stencil()
            || (params.writes_stencil() && params.write_mechanism == WriteMechanism::RpDontCare));

        let mut pixel_idx = 0usize;
        for y in 0..FRAMEBUFFER_DIM {
            for x in 0..FRAMEBUFFER_DIM {
                let vertex = &vertices[pixel_idx];
                pixel_idx += 1;

                let color = color_access.get_pixel(x, y, 0);
                let color_thresholds = [COLOR_THRESHOLD, COLOR_THRESHOLD, COLOR_THRESHOLD, 0.0];
                if (0..4).any(|c| (color[c] - vertex.color[c]).abs() > color_thresholds[c]) {
                    color_ok = false;
                }

                if params.reads_depth() {
                    let stored = storage_access.get_pixel(x, y, 0)[0];
                    if (stored - vertex.coords[2]).abs() > depth_threshold {
                        storage_ok = false;
                    }
                } else if storage_access.get_pixel_uint(x, y, 0)[0] != vertex.extra[0] as u32 {
                    storage_ok = false;
                }

                if check_depth {
                    let expected = if params.writes_depth() && params.write_mechanism == WriteMechanism::RpClear {
                        0.0
                    } else {
                        vertex.coords[2]
                    };
                    if (depth_access.get_pix_depth(x, y, 0) - expected).abs() > depth_threshold {
                        depth_ok = false;
                    }
                }

                if check_stencil {
                    let expected = if params.writes_stencil() && params.write_mechanism == WriteMechanism::RpClear {
                        0
                    } else {
                        vertex.extra[0] as u32
                    };
                    if stencil_access.get_pix_stencil(x, y, 0) != expected {
                        stencil_ok = false;
                    }
                }
            }
        }

        if !color_ok {
            log::info!("ColorBuffer: comparison failed");
        }
        if !storage_ok {
            log::info!("StorageBuffer: comparison failed");
        }
        if !depth_ok {
            log::info!("DepthBuffer: comparison failed");
        }
        if !stencil_ok {
            log::info!("StencilBuffer: comparison failed");
        }

        if color_ok && storage_ok && depth_ok && stencil_ok {
            return Ok(TestStatus::pass("Pass"));
        }
        Ok(TestStatus::fail(
            "Unexpected contents in one or more output buffers; check log for details",
        ))
    }
}

/// `getFormatShortString` for the combined depth/stencil formats.
fn format_short_string(format: vk::Format) -> &'static str {
    match format {
        vk::Format::D16_UNORM_S8_UINT => "d16_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d32_sfloat_s8_uint",
    }
}

/// `createImageDepthStencilSeparateTests`
pub fn create_image_depth_stencil_separate_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("depth_stencil_separate_access");

    let ds_formats = [
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];

    let write_aspects = [
        (vk::ImageAspectFlags::DEPTH, "write_depth"),
        (vk::ImageAspectFlags::STENCIL, "write_stencil"),
    ];

    let write_mechanisms = [
        (WriteMechanism::RpClear, "render_pass_clears"),
        (WriteMechanism::RpDontCare, "render_pass_dont_care"),
        (WriteMechanism::TestStore, "test_and_store"),
        (WriteMechanism::TestResolve, "test_and_resolve"),
    ];

    for format in ds_formats {
        let mut format_group = TestCaseGroup::new(format_short_string(format));

        for (write_aspect, aspect_name) in write_aspects {
            for (write_mechanism, mechanism_name) in write_mechanisms {
                for general_layout in [false, true] {
                    for separate_layouts in [false, true] {
                        for dynamic_stencil_ref in [false, true] {
                            if dynamic_stencil_ref
                                && (write_aspect != vk::ImageAspectFlags::STENCIL || !writes_with_test(write_mechanism))
                            {
                                continue;
                            }

                            // Would not make sense.
                            if general_layout && separate_layouts {
                                continue;
                            }

                            // Avoid combinatory explosion.
                            if writes_with_resolve(write_mechanism) && separate_layouts {
                                continue;
                            }

                            let layout_suffix = if general_layout { "_general_layout" } else { "" };
                            let sl_suffix = if separate_layouts { "_separate_layouts" } else { "" };
                            let stencil_suffix = if dynamic_stencil_ref {
                                "_dynamic_stencil_ref"
                            } else {
                                ""
                            };
                            let test_name =
                                format!("{aspect_name}_{mechanism_name}{layout_suffix}{sl_suffix}{stencil_suffix}");

                            let params = TestParams {
                                image_format: format,
                                write_aspect,
                                write_mechanism,
                                general_layout,
                                separate_layouts,
                                dynamic_stencil_ref,
                            };

                            format_group.add_child(Box::new(DepthStencilSeparateCase {
                                name: test_name,
                                params,
                            }) as Box<dyn TestCase>);
                        }
                    }
                }
            }
        }

        main_group.add_child(format_group);
    }

    main_group
}
