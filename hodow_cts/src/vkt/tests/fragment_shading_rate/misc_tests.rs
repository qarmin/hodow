// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_rate/vktFragmentShadingRateMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/fragment_shading_rate_misc.toml.
// `tcu::floatThresholdCompare` over an RGBA8 image is written out per channel on the reference quantised to unorm8, and
// `tcu::dsThresholdCompare` over D16 as a per-pixel loop. The robust device of `test_oob_attachment` is created on the
// context's own instance with the context's own device extensions, as `createRobustDevice` does through `InstanceWrapper`.

use std::ffi::CString;
use std::mem::size_of;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, InstanceV1_1, KhrCreateRenderpass2ExtensionDeviceCommands};

use super::{GroupParams, fragment_shading_rate_features, fragment_shading_rate_properties};
use crate::generated::shaders::fragment_shading_rate_misc::{FSR_MISC_NO_FRAG, FSR_MISC_OOB, FSR_MISC_VERT_FRAG};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, begin_rendering, clear_value_color, create_draw_pipeline, end_rendering,
    rect_2d,
};
use crate::vkt::tests::pipeline::cache_tests::make_render_pass;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FSR_FORMAT: vk::Format = vk::Format::R8_UINT;
/// 2x2: (gl_ShadingRateFlag2HorizontalPixelsEXT | gl_ShadingRateFlag2VerticalPixelsEXT)
const CLEAR_ATT_RATE: u8 = 5;

#[repr(C)]
#[derive(Clone, Copy)]
struct PositionColor {
    position: [f32; 4],
    color: [f32; 4],
}

#[derive(Clone, Copy)]
struct TestParams {
    use_robustness2: bool,
    use_base_mip_level1: bool,
}

#[derive(Clone, Copy)]
enum Kind {
    EnableDisable,
    NoFrag,
    Oob(TestParams),
    ExplicitImplicitEnable,
}

fn default_extent() -> vk::Extent3D {
    vk::Extent3D {
        width: 8,
        height: 8,
        depth: 1,
    }
}

/// `checkShadingRateSupport`
fn check_shading_rate_support(
    context: &Context<'_>,
    pipeline: bool,
    primitive: bool,
    attachment: bool,
) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
    let fsr_features = fragment_shading_rate_features(context);

    if pipeline && fsr_features.pipeline_fragment_shading_rate == vk::FALSE {
        return Err(TestError::NotSupported(
            "pipelineFragmentShadingRate not supported".to_string(),
        ));
    }

    if primitive && fsr_features.primitive_fragment_shading_rate == vk::FALSE {
        return Err(TestError::NotSupported(
            "primitiveFragmentShadingRate not supported".to_string(),
        ));
    }

    if attachment && fsr_features.attachment_fragment_shading_rate == vk::FALSE {
        return Err(TestError::NotSupported(
            "attachmentFragmentShadingRate not supported".to_string(),
        ));
    }

    Ok(())
}

/// `checkOobSupport`
fn check_oob_support(context: &Context<'_>, param: TestParams) -> Result<(), TestError> {
    check_shading_rate_support(context, true, false, true)?;

    let mut maintenance7_properties = vk::PhysicalDeviceMaintenance7PropertiesKHR::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance7_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    if maintenance7_properties.robust_fragment_shading_rate_attachment_access == vk::FALSE {
        return Err(TestError::NotSupported(
            "Fragment shading rate attachment size must match render area size".to_string(),
        ));
    }

    if param.use_robustness2 {
        if !context.is_device_functionality_supported("VK_KHR_robustness2")
            && !context.is_device_functionality_supported("VK_EXT_robustness2")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_robustness2 and VK_EXT_robustness2 are not supported".to_string(),
            ));
        }

        let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if robustness2_features.robust_image_access2 == vk::FALSE {
            return Err(TestError::NotSupported(
                "robustImageAccess2 feature not supported".to_string(),
            ));
        }
    } else {
        context.require_device_functionality("VK_EXT_image_robustness")?;
    }

    Ok(())
}

struct MiscCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for MiscCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            // `checkEnableDisableSupport`
            Kind::EnableDisable => check_shading_rate_support(context, true, false, true),
            // `checkNoFragSupport`
            Kind::NoFrag => check_shading_rate_support(context, true, false, false),
            Kind::Oob(params) => check_oob_support(context, params),
            // `checkExplicitImplicitEnableSupport`
            Kind::ExplicitImplicitEnable => {
                check_shading_rate_support(context, true, false, true)?;
                context.require_device_functionality("VK_KHR_dynamic_rendering")
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::EnableDisable | Kind::ExplicitImplicitEnable => FSR_MISC_VERT_FRAG.programs,
            Kind::NoFrag => FSR_MISC_NO_FRAG.programs,
            Kind::Oob(_) => FSR_MISC_OOB.programs,
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
    kind: Kind,
}

impl TestInstance for MiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::EnableDisable => test_enable_disable(self.context),
            Kind::NoFrag => test_no_frag(self.context),
            Kind::Oob(params) => test_oob(self.context, params),
            Kind::ExplicitImplicitEnable => test_explicit_implicit_enable(self.context),
        }
    }
}

/// The vertex input of `getDefaultVertexInputStateCreateInfo`.
fn with_default_vertex_input(mut state: DrawPipelineState) -> DrawPipelineState {
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: size_of::<PositionColor>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: std::mem::offset_of!(PositionColor, position) as u32,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: std::mem::offset_of!(PositionColor, color) as u32,
        },
    ];
    state
}

/// `makeFragmentShadingRateStateCreateInfo`
fn make_fragment_shading_rate_state_create_info(
    width: u32,
    height: u32,
    combiner0: vk::FragmentShadingRateCombinerOpKHR,
    combiner1: vk::FragmentShadingRateCombinerOpKHR,
) -> vk::PipelineFragmentShadingRateStateCreateInfoKHR {
    vk::PipelineFragmentShadingRateStateCreateInfoKHR {
        s_type: vk::StructureType::PIPELINE_FRAGMENT_SHADING_RATE_STATE_CREATE_INFO_KHR,
        next: std::ptr::null(),
        fragment_size: vk::Extent2D { width, height },
        combiner_ops: [combiner0, combiner1],
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

fn memory_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::MemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };
}

fn color_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn buffer_image_copy(extent: vk::Extent3D, aspect: vk::ImageAspectFlags) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(aspect, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: extent,
    }
}

/// Copies the colour image to its verification buffer and makes the buffer readable by the host.
fn copy_color_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    color_image: vk::Image,
    color_buffer: vk::Buffer,
    extent: vk::Extent3D,
) {
    let pre_transfer_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        color_image,
        color_range(),
    );
    image_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        &[pre_transfer_barrier],
    );
    let copy_region = buffer_image_copy(extent, vk::ImageAspectFlags::COLOR);
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd,
            color_image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_buffer,
            &[copy_region],
        )
    };
    let pre_host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    memory_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::HOST,
        pre_host_barrier,
    );
}

/// The reference of the tests that end on the second draw: red goes from 0 to 1 on the X axis, blue from 0 to 1 on the Y axis.
fn red_blue_reference(x: usize, y: usize, width: usize, height: usize) -> [f32; 4] {
    [
        (y as f32 + 0.5) / height as f32,
        0.0,
        (x as f32 + 0.5) / width as f32,
        1.0,
    ]
}

/// `tcu::floatThresholdCompare` of an RGBA8 `width` x `height` readback against `reference`, quantised to unorm8 like the
/// `tcu::TextureLevel` upstream sets it into.
fn compare_color(
    result: &[u8],
    width: usize,
    height: usize,
    threshold: f32,
    reference: impl Fn(usize, usize) -> [f32; 4],
) -> bool {
    for y in 0..height {
        for x in 0..width {
            let want = reference(x, y);
            let offset = (y * width + x) * 4;
            for channel in 0..4 {
                let want = (want[channel].clamp(0.0, 1.0) * 255.0).round() / 255.0;
                let got = f32::from(result[offset + channel]) / 255.0;
                if (got - want).abs() > threshold {
                    return false;
                }
            }
        }
    }
    true
}

/// The `vertices` and `colors` of the tests that draw twice, mixed with the colour order reversed for the first draw.
fn vrs_and_no_vrs_vertices() -> (Vec<PositionColor>, Vec<PositionColor>) {
    let vertices = [
        [-1.0f32, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ];
    let colors = [
        [0.0f32, 0.0, 0.0, 1.0],
        [1.0, 0.0, 0.0, 1.0],
        [0.0, 0.0, 1.0, 1.0],
        [1.0, 0.0, 1.0, 1.0],
    ];

    let mut vrs_vertices = Vec::new();
    let mut no_vrs_vertices = Vec::new();
    for i in 0..vertices.len() {
        vrs_vertices.push(PositionColor {
            position: vertices[i],
            color: colors[colors.len() - 1 - i],
        });
        no_vrs_vertices.push(PositionColor {
            position: vertices[i],
            color: colors[i],
        });
    }
    (vrs_vertices, no_vrs_vertices)
}

fn fsr_attachment_create_info(extent: vk::Extent3D, mip_levels: u32) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(FSR_FORMAT)
        .extent(extent)
        .mip_levels(mip_levels)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// The render pass of the two tests that use a render pass object: a colour attachment and a fragment shading rate attachment.
fn make_fsr_render_pass(
    device: &Device,
    fsr_initial_layout: vk::ImageLayout,
    shading_rate_attachment_texel_size: vk::Extent2D,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let sample_count = vk::SampleCountFlags::_1;
    let attachment_descriptions = [
        // Color attachment.
        vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: COLOR_FORMAT,
            samples: sample_count,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::UNDEFINED,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        },
        // FSR attachment.
        vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: FSR_FORMAT,
            samples: sample_count,
            load_op: vk::AttachmentLoadOp::LOAD,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: fsr_initial_layout,
            final_layout: vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
        },
    ];

    let color_att_ref = vk::AttachmentReference2 {
        s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
        next: std::ptr::null(),
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        aspect_mask: vk::ImageAspectFlags::COLOR,
    };

    let fsr_att_ref = vk::AttachmentReference2 {
        s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
        next: std::ptr::null(),
        attachment: 1,
        layout: vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
        aspect_mask: vk::ImageAspectFlags::COLOR,
    };

    let fsr_att_info = vk::FragmentShadingRateAttachmentInfoKHR {
        s_type: vk::StructureType::FRAGMENT_SHADING_RATE_ATTACHMENT_INFO_KHR,
        next: std::ptr::null(),
        fragment_shading_rate_attachment: &fsr_att_ref,
        shading_rate_attachment_texel_size,
    };

    let subpass_description = vk::SubpassDescription2 {
        s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
        next: std::ptr::addr_of!(fsr_att_info).cast(),
        flags: vk::SubpassDescriptionFlags::empty(),
        pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
        view_mask: 0,
        input_attachment_count: 0,
        input_attachments: std::ptr::null(),
        color_attachment_count: 1,
        color_attachments: &color_att_ref,
        resolve_attachments: std::ptr::null(),
        depth_stencil_attachment: std::ptr::null(),
        preserve_attachment_count: 0,
        preserve_attachments: std::ptr::null(),
    };

    let render_pass_create_info = vk::RenderPassCreateInfo2 {
        s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
        next: std::ptr::null(),
        flags: vk::RenderPassCreateFlags::empty(),
        attachment_count: attachment_descriptions.len() as u32,
        attachments: attachment_descriptions.as_ptr(),
        subpass_count: 1,
        subpasses: &subpass_description,
        dependency_count: 0,
        dependencies: std::ptr::null(),
        correlated_view_mask_count: 0,
        correlated_view_masks: std::ptr::null(),
    };

    let handle =
        unsafe { device.create_render_pass2_khr(&render_pass_create_info, None) }.vk_check("vkCreateRenderPass2KHR")?;
    Ok(Unique::new(device, handle))
}

/// A one byte host-visible buffer filled with `value`, the source of the 1x1 FSR attachment.
fn make_fsr_fill_buffer<'a>(context: &'a Context<'a>, value: u8) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let fill_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(1, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::write_bytes(fill_buffer.get_allocation().get_host_ptr(), value, 1) };
    flush_alloc(device, fill_buffer.get_allocation())?;
    Ok(fill_buffer)
}

/// Initializes the 1x1 FSR attachment from `fill_buffer` and moves it to the fragment shading rate attachment layout.
fn initialize_fsr_attachment(
    device: &Device,
    cmd: vk::CommandBuffer,
    fsr_attachment: vk::Image,
    fill_buffer: vk::Buffer,
) {
    let pre_transfer_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        fsr_attachment,
        color_range(),
    );
    image_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::TRANSFER,
        &[pre_transfer_barrier],
    );
    let copy_region = buffer_image_copy(
        vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        },
        vk::ImageAspectFlags::COLOR,
    );
    unsafe {
        device.cmd_copy_buffer_to_image(
            cmd,
            fill_buffer,
            fsr_attachment,
            vk::ImageLayout::GENERAL,
            &[copy_region],
        )
    };
    let post_transfer_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
        fsr_attachment,
        color_range(),
    );
    image_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
        &[post_transfer_barrier],
    );
}

/// The framebuffer extent shared by the tests that use a one pixel FSR attachment: the default extent clamped to the range of
/// attachment texel sizes, so it is covered by a single FSR attachment pixel.
fn attachment_covered_extent(context: &Context<'_>) -> vk::Extent3D {
    let fsr_properties = fragment_shading_rate_properties(context);
    let min_size = fsr_properties.min_fragment_shading_rate_attachment_texel_size;
    let max_size = fsr_properties.max_fragment_shading_rate_attachment_texel_size;
    let mut vk_extent = default_extent();
    vk_extent.width = vk_extent.width.max(min_size.width).min(max_size.width);
    vk_extent.height = vk_extent.height.max(min_size.height).min(max_size.height);
    vk_extent
}

/// Test idea: draw with VRS enabled by a fragment shading rate attachment, then bind a pipeline with VRS disabled and draw again.
/// This was being incorrectly handled in RADV. Ref: https://gitlab.freedesktop.org/mesa/mesa/-/issues/9005
fn test_enable_disable(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let bind_point = vk::PipelineBindPoint::GRAPHICS;
    let fsr_extent = vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    }; // 1 pixel for the whole image.

    // Adjust image extent to an acceptable range so it's covered by a single FSR attachment pixel.
    let vk_extent = attachment_covered_extent(context);
    let fb_width = vk_extent.width as usize;
    let fb_height = vk_extent.height as usize;

    let color_buffer = ImageWithBuffer::new(context, vk_extent.width, vk_extent.height, COLOR_FORMAT, color_usage, 4)?;

    // Fragment shading rate attachment.
    let fsr_attachment = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        fsr_attachment_create_info(fsr_extent, 1),
        MemoryRequirement::ANY,
    )?;
    let fsr_att_view = make_image_view(
        device,
        fsr_attachment.get(),
        vk::ImageViewType::_2D,
        FSR_FORMAT,
        color_range(),
    )?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let render_pass = make_fsr_render_pass(
        device,
        vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
        vk::Extent2D {
            width: vk_extent.width,
            height: vk_extent.height,
        },
    )?;

    let attachment_views = [*color_buffer.view, *fsr_att_view];
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &attachment_views,
        vk_extent.width,
        vk_extent.height,
        1,
    )?;

    // Use the rate according to the attachment.
    let fragment_shading_rate_state_create_info = make_fragment_shading_rate_state_create_info(
        1,
        1,
        vk::FragmentShadingRateCombinerOpKHR::KEEP,
        vk::FragmentShadingRateCombinerOpKHR::REPLACE,
    );

    // We mix them reversing the color order for the first draw.
    let (vrs_vertices, no_vrs_vertices) = vrs_and_no_vrs_vertices();
    let vrs_vertices_buffer = create_host_buffer(context, &vrs_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    let no_vrs_vertices_buffer = create_host_buffer(context, &no_vrs_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let stages = [
        (vk::ShaderStageFlags::VERTEX, *vert_module),
        (vk::ShaderStageFlags::FRAGMENT, *frag_module),
    ];

    // Pipeline with and without VRS.
    let mut vrs_state = with_default_vertex_input(
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .with_full_viewport(vk_extent.width, vk_extent.height),
    );
    vrs_state.fragment_shading_rate_state = Some(fragment_shading_rate_state_create_info);
    let pipeline_vrs = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &vrs_state)?;

    let no_vrs_state = with_default_vertex_input(
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .with_full_viewport(vk_extent.width, vk_extent.height),
    );
    let pipeline_no_vrs = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &no_vrs_state)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
    let color_comp_threshold = 0.005; // between 1/255 and 2/255.
    let vertex_count = vrs_vertices.len() as u32;

    let fsr_fill_buffer = make_fsr_fill_buffer(context, CLEAR_ATT_RATE)?;

    let iterations = [
        (vrs_vertices_buffer.get(), pipeline_vrs.get()),
        (no_vrs_vertices_buffer.get(), pipeline_no_vrs.get()),
    ];

    begin_command_buffer(device, cmd)?;
    // Initialize the FSR attachment.
    initialize_fsr_attachment(device, cmd, fsr_attachment.get(), fsr_fill_buffer.get());
    {
        // Render pass.
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(vk_extent.width, vk_extent.height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            for (vertex_buffer, pipeline) in iterations {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
                device.cmd_bind_pipeline(cmd, bind_point, pipeline);
                device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            }
            device.cmd_end_render_pass(cmd);
        }
    }
    // Copy image to verification buffer after rendering.
    copy_color_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        vk_extent,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;
    let result = color_buffer.read_bytes(device)?;

    // The reference must match the vertex+color combination for the second draw.
    if !compare_color(result, fb_width, fb_height, color_comp_threshold, |x, y| {
        red_blue_reference(x, y, fb_width, fb_height)
    }) {
        return Ok(TestStatus::fail(
            "Unexpected color buffer contents -- check log for details",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

fn test_no_frag(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let depth_format = vk::Format::D16_UNORM;
    let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
    let bind_point = vk::PipelineBindPoint::GRAPHICS;
    let vk_extent = vk::Extent3D {
        width: 8,
        height: 1,
        depth: 1,
    };
    let tile_size = [2u32, 2];

    let color_buffer = ImageWithBuffer::new(context, vk_extent.width, vk_extent.height, COLOR_FORMAT, color_usage, 4)?;

    // The depth image, its depth-aspect view and the buffer its depth aspect is copied to.
    let depth_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(depth_format)
        .extent(vk_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let depth_image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        depth_image_info,
        MemoryRequirement::ANY,
    )?;
    let depth_view = make_image_view(
        device,
        depth_image.get(),
        vk::ImageViewType::_2D,
        depth_format,
        depth_srr,
    )?;
    let depth_buffer_size = (vk_extent.width * vk_extent.height) as vk::DeviceSize * 2;
    let depth_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(depth_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let vert_module = create_shader_module(device, context.get_binary_collection().get("vert")?)?;
    let render_pass = make_render_pass(device, vk::ImageLayout::UNDEFINED)?;

    let attachment_views = [*color_buffer.view, *depth_view];
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &attachment_views,
        vk_extent.width,
        vk_extent.height,
        1,
    )?;

    // Use the rate from the pipeline.
    let fragment_shading_rate_state_create_info = make_fragment_shading_rate_state_create_info(
        tile_size[0],
        tile_size[1], // This has mandatory support.
        vk::FragmentShadingRateCombinerOpKHR::KEEP,
        vk::FragmentShadingRateCombinerOpKHR::KEEP,
    );

    // Colors (second member) are irrelevant due to the lack of a frag shader. In the first member depth increases from left to right.
    let vertices = [
        PositionColor {
            position: [-1.0, -1.0, 0.0, 1.0],
            color: [0.0, 0.0, 0.0, 1.0],
        },
        PositionColor {
            position: [-1.0, 1.0, 0.0, 1.0],
            color: [1.0, 0.0, 0.0, 1.0],
        },
        PositionColor {
            position: [1.0, -1.0, 1.0, 1.0],
            color: [0.0, 0.0, 1.0, 1.0],
        },
        PositionColor {
            position: [1.0, 1.0, 1.0, 1.0],
            color: [1.0, 0.0, 1.0, 1.0],
        },
    ];
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let mut pipeline_state = with_default_vertex_input(
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .with_full_viewport(vk_extent.width, vk_extent.height),
    );
    pipeline_state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(true)
        .depth_write_enable(true)
        .depth_compare_op(vk::CompareOp::ALWAYS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(vk::StencilOpState::default())
        .back(vk::StencilOpState::default())
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build();
    // Rasterization is forced on, as it would otherwise be disabled for the lack of a fragment shader.
    pipeline_state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .depth_bias_constant_factor(0.0)
        .depth_bias_clamp(0.0)
        .depth_bias_slope_factor(0.0)
        .line_width(1.0)
        .build();
    pipeline_state.fragment_shading_rate_state = Some(fragment_shading_rate_state_create_info);

    // Pipeline.
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[(vk::ShaderStageFlags::VERTEX, *vert_module)],
        &pipeline_state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_color = [0.0f32; 4];
    let clear_values = [
        clear_value_color(clear_color),
        vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
        },
    ];
    let depth_threshold = 0.000025; // Between 1/65535 and 2/65535.
    let vertex_count = vertices.len() as u32;

    begin_command_buffer(device, cmd)?;
    {
        // Render pass.
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(vk_extent.width, vk_extent.height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, bind_point, pipeline.get());
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }
    {
        // Copy images to verification buffers after rendering.
        let pre_transfer_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.image.get(),
                color_range(),
            ),
            make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth_image.get(),
                depth_srr,
            ),
        ];
        let pre_transfer_stages = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
            | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
        image_barrier(
            device,
            cmd,
            pre_transfer_stages,
            vk::PipelineStageFlags::TRANSFER,
            &pre_transfer_barriers,
        );

        let copy_color_region = buffer_image_copy(vk_extent, vk::ImageAspectFlags::COLOR);
        let copy_depth_region = buffer_image_copy(vk_extent, vk::ImageAspectFlags::DEPTH);
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                color_buffer.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.buffer.get(),
                &[copy_color_region],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                depth_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth_buffer.get(),
                &[copy_depth_region],
            );
        }

        let pre_host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            pre_host_barrier,
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;
    invalidate_alloc(device, depth_buffer.get_allocation())?;

    // Check results:
    // - Color image shouldn't have been touched.
    // - Depth buffer should have values in pairs of 2, within the accepted range.
    let color_result = color_buffer.read_bytes(device)?;
    if !compare_color(
        color_result,
        vk_extent.width as usize,
        vk_extent.height as usize,
        0.0,
        |_, _| clear_color,
    ) {
        return Ok(TestStatus::fail(
            "Unexpected color buffer contents (expected transparent black) -- check log for details",
        ));
    }

    // Note fragment shading rate does not affect the depth buffer, only frag shader invocations. When verifying the depth buffer,
    // the reference values are generated normally.
    let depth_bytes =
        unsafe { std::slice::from_raw_parts(depth_buffer.get_allocation().get_host_ptr(), depth_buffer_size as usize) };
    let f_width = vk_extent.width as f32;
    for y in 0..vk_extent.height as usize {
        for x in 0..vk_extent.width as usize {
            // This needs to match vertex depths.
            let reference_depth = (x as f32 + 0.5) / f_width;
            let index = (y * vk_extent.width as usize + x) * 2;
            let result_depth = f32::from(u16::from_le_bytes([depth_bytes[index], depth_bytes[index + 1]])) / 65535.0;
            if (result_depth - reference_depth).abs() > depth_threshold {
                return Ok(TestStatus::fail(
                    "Unexpected depth buffer contents -- check log for details",
                ));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// A device that is not the context's own.
struct RobustDevice {
    device: Device,
    allocator: SimpleAllocator,
    queue: vk::Queue,
}

impl Drop for RobustDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

/// `createRobustDevice`
fn create_robust_device(context: &Context<'_>, robustness2: bool) -> Result<RobustDevice, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue_priorities = [1.0f32];
    // A universal queue that supports graphics and compute.
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priorities)
        .build()];

    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

    // Choose between robustness2 and image robustness. Feature support is checked in the support check functions.
    let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
    robustness2_features.robust_image_access2 = vk::TRUE;

    let mut img_robustness_features = vk::PhysicalDeviceImageRobustnessFeatures::default();
    img_robustness_features.robust_image_access = vk::TRUE;

    let mut fsr_features = vk::PhysicalDeviceFragmentShadingRateFeaturesKHR::default();
    fsr_features.attachment_fragment_shading_rate = vk::TRUE;
    fsr_features.pipeline_fragment_shading_rate = vk::TRUE;

    let mut m7_features = vk::PhysicalDeviceMaintenance7FeaturesKHR::default();
    m7_features.maintenance7 = vk::TRUE;

    let extension_names: Vec<CString> = context
        .get_device_extensions()
        .iter()
        .map(|name| CString::new(name.as_str()).expect("extension names have no NUL"))
        .collect();
    let extension_ptrs: Vec<*const std::ffi::c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();

    let mut device_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extension_ptrs)
        .push_next(&mut features2)
        .push_next(&mut fsr_features);
    if robustness2 {
        device_info = device_info.push_next(&mut robustness2_features);
    } else {
        device_info = device_info.push_next(&mut img_robustness_features);
    }
    if context.is_device_functionality_supported("VK_KHR_maintenance7") {
        device_info = device_info.push_next(&mut m7_features);
    }

    let device = unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?;
    let queue = unsafe { device.get_device_queue(queue_family_index, 0) };
    let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };

    Ok(RobustDevice {
        device,
        allocator: SimpleAllocator::new(memory_properties),
        queue,
    })
}

fn test_oob(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let fsr_properties = fragment_shading_rate_properties(context);
    let fsr_attachment_texel_size = fsr_properties.min_fragment_shading_rate_attachment_texel_size;
    let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let bind_point = vk::PipelineBindPoint::GRAPHICS;
    let sample_count = vk::SampleCountFlags::_1;
    let robust = create_robust_device(context, params.use_robustness2)?;
    let device = &robust.device;
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = robust.queue;
    let allocator = &robust.allocator;

    // minW and minH of the shader's buffer.
    let dimensions = [fsr_attachment_texel_size.width, fsr_attachment_texel_size.height];

    let buffer_size = size_of::<[u32; 2]>() as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            dimensions.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            buffer_size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;

    let output_size = vk::Extent3D {
        width: fsr_attachment_texel_size.width * 4,
        height: fsr_attachment_texel_size.height * 4,
        depth: 1,
    };

    // `vk::ImageWithBuffer` on the robust device.
    let color_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(output_size)
        .mip_levels(1)
        .array_layers(1)
        .samples(sample_count)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(color_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(device, allocator, color_image_info, MemoryRequirement::ANY)?;
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_range(),
    )?;
    let color_buffer_size = (output_size.width * output_size.height * 4) as vk::DeviceSize;
    let color_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let fsr_extent = vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    }; // 1 pixel for the whole image.
    let mip_level_scale_factor = 2;
    let fsr_extent_scaled = vk::Extent3D {
        width: mip_level_scale_factor,
        height: mip_level_scale_factor,
        depth: 1,
    };
    let fsr_img_creation_extent = if params.use_base_mip_level1 {
        fsr_extent_scaled
    } else {
        fsr_extent
    };

    let fsr_mip_count = if params.use_base_mip_level1 { 2 } else { 1 };
    let fsr_base_mip_level = if params.use_base_mip_level1 { 1 } else { 0 };

    let fsr_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, fsr_base_mip_level, 1, 0, 1);
    // Fragment shading rate attachment.
    let fsr_attachment = ImageWithMemory::new(
        device,
        allocator,
        fsr_attachment_create_info(fsr_img_creation_extent, fsr_mip_count),
        MemoryRequirement::ANY,
    )?;
    let fsr_att_view = make_image_view(
        device,
        fsr_attachment.get(),
        vk::ImageViewType::_2D,
        FSR_FORMAT,
        fsr_srr,
    )?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let render_pass = make_fsr_render_pass(
        device,
        vk::ImageLayout::GENERAL,
        vk::Extent2D {
            width: fsr_attachment_texel_size.width,
            height: fsr_attachment_texel_size.height,
        },
    )?;

    let attachment_views = [*color_view, *fsr_att_view];
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &attachment_views,
        output_size.width,
        output_size.height,
        1,
    )?;

    // Use the rate according to the attachment.
    let fragment_shading_rate_state_create_info = make_fragment_shading_rate_state_create_info(
        1,
        1,
        vk::FragmentShadingRateCombinerOpKHR::KEEP,
        vk::FragmentShadingRateCombinerOpKHR::REPLACE,
    );

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let graphics_pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    // No vertex input: the vertex shader generates the full-screen triangle.
    let mut pipeline_state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .with_full_viewport(output_size.width, output_size.height);
    pipeline_state.fragment_shading_rate_state = Some(fragment_shading_rate_state_create_info);
    let pipeline_vrs = create_draw_pipeline(
        device,
        *graphics_pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &pipeline_state,
    )?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set_buffer = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    // Update descriptor sets.
    let buffer_info = [vk::DescriptorBufferInfo {
        buffer: buffer.get(),
        offset: 0,
        range: buffer_size,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set_buffer.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    begin_command_buffer(device, cmd)?;
    let img_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, fsr_mip_count, 0, 1);
    let barrier1 = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        fsr_attachment.get(),
        img_srr,
    );
    image_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::BOTTOM_OF_PIPE,
        vk::PipelineStageFlags::TRANSFER,
        &[barrier1],
    );
    let fsr_color = vk::ClearColorValue {
        uint32: [u32::from(CLEAR_ATT_RATE), 0, 0, 0],
    };
    unsafe {
        device.cmd_clear_color_image(
            cmd,
            fsr_attachment.get(),
            vk::ImageLayout::GENERAL,
            &fsr_color,
            &[img_srr],
        )
    };
    let barrier2 = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::GENERAL,
        fsr_attachment.get(),
        img_srr,
    );
    image_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
        &[barrier2],
    );
    {
        // Render pass.
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(output_size.width, output_size.height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *graphics_pipeline_layout,
                0,
                &[descriptor_set_buffer.get()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, bind_point, pipeline_vrs.get());
            device.cmd_draw(cmd, 3, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }
    // Copy image to verification buffer after rendering.
    copy_color_to_buffer(device, cmd, color_image.get(), color_buffer.get(), output_size);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;
    invalidate_alloc(device, color_buffer.get_allocation())?;

    let color_bytes =
        unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size as usize) };
    if !compare_color(
        color_bytes,
        output_size.width as usize,
        output_size.height as usize,
        0.0,
        |_, _| [0.0, 1.0, 0.0, 1.0],
    ) {
        return Ok(TestStatus::fail(
            "Color output does not match reference, image added to log",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// Test idea: draw with an FSR attachment and then without it, binding the pipeline only once (dynamic rendering). The pipeline has
/// FSR 2x2 and combiner ops KEEP,REPLACE, so the attachment rate should prevail. The resulting rate should *always* be 1x1. In the
/// first draw, it's explicit. In the second draw, the absence of an attachment means its rate should also be 1x1, and it should
/// apply due to the combiner ops despite the pipeline having a rate of 2x2.
///
/// This was being incorrectly handled in RADV. Ref: https://gitlab.freedesktop.org/mesa/mesa/-/issues/11693
fn test_explicit_implicit_enable(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let bind_point = vk::PipelineBindPoint::GRAPHICS;
    let fsr_extent = vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    }; // 1 pixel for the whole image.

    // Adjust image extent to an acceptable range so it's covered by a single FSR attachment pixel.
    let vk_extent = attachment_covered_extent(context);
    let fb_width = vk_extent.width as usize;
    let fb_height = vk_extent.height as usize;

    // Color attachment.
    let color_buffer = ImageWithBuffer::new(context, vk_extent.width, vk_extent.height, COLOR_FORMAT, color_usage, 4)?;

    // Fragment shading rate attachment.
    let fsr_attachment = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        fsr_attachment_create_info(fsr_extent, 1),
        MemoryRequirement::ANY,
    )?;
    let fsr_att_view = make_image_view(
        device,
        fsr_attachment.get(),
        vk::ImageViewType::_2D,
        FSR_FORMAT,
        color_range(),
    )?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    // Pipeline FSR is 2x2 (support for this rate is mandatory).
    let fragment_shading_rate_state_create_info = make_fragment_shading_rate_state_create_info(
        2,
        2,
        vk::FragmentShadingRateCombinerOpKHR::KEEP,
        vk::FragmentShadingRateCombinerOpKHR::REPLACE,
    );

    // We mix them reversing the color order for the first draw.
    let (vrs_vertices, no_vrs_vertices) = vrs_and_no_vrs_vertices();
    let vrs_vertices_buffer = create_host_buffer(context, &vrs_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    let no_vrs_vertices_buffer = create_host_buffer(context, &no_vrs_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;

    // Pipeline with dynamic rendering and optionally using FSR.
    let mut pipeline_state = with_default_vertex_input(
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .with_full_viewport(vk_extent.width, vk_extent.height),
    );
    pipeline_state.rendering_format = Some(COLOR_FORMAT);
    pipeline_state.fragment_shading_rate_state = Some(fragment_shading_rate_state_create_info);
    pipeline_state.create_flags = vk::PipelineCreateFlags::RENDERING_FRAGMENT_SHADING_RATE_ATTACHMENT_KHR;
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        vk::RenderPass::null(),
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &pipeline_state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_att_rate = 0u8; // 1x1 on the attachment.
    let clear_color = [0.0f32; 4];

    let color_comp_threshold = 0.005; // between 1/255 and 2/255.
    let vertex_count = vrs_vertices.len() as u32;

    let fsr_fill_buffer = make_fsr_fill_buffer(context, clear_att_rate)?;

    begin_command_buffer(device, cmd)?;
    // Initialize the FSR attachment.
    initialize_fsr_attachment(device, cmd, fsr_attachment.get(), fsr_fill_buffer.get());
    {
        // Move color attachment to the right layout.
        let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        let color_layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            dst_access,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_buffer.image.get(),
            color_range(),
        );
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[color_layout_barrier],
        );
    }
    // Bind pipeline first and only once.
    unsafe { device.cmd_bind_pipeline(cmd, bind_point, pipeline.get()) };
    {
        // First render pass, with FSR attachment.
        let color_att_info = [vk::RenderingAttachmentInfo::builder()
            .image_view(*color_buffer.view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_value_color(clear_color))
            .build()];

        let mut fsr_att_info = vk::RenderingFragmentShadingRateAttachmentInfoKHR {
            s_type: vk::StructureType::RENDERING_FRAGMENT_SHADING_RATE_ATTACHMENT_INFO_KHR,
            next: std::ptr::null(),
            image_view: *fsr_att_view,
            image_layout: vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
            shading_rate_attachment_texel_size: vk::Extent2D {
                width: vk_extent.width,
                height: vk_extent.height,
            },
        };

        let rendering_info = vk::RenderingInfo::builder()
            .render_area(rect_2d(vk_extent.width, vk_extent.height))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_att_info)
            .push_next(&mut fsr_att_info);

        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vrs_vertices_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_rendering(device, cmd);
    }
    {
        // Sync first and second render pass writes.
        let src_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ;
        let barrier = make_memory_barrier(src_access, dst_access);
        memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            barrier,
        );
    }
    {
        // Second render pass, without FSR attachment, but the rate should still be 1x1 due to the combiner ops.
        begin_rendering(
            device,
            cmd,
            *color_buffer.view,
            rect_2d(vk_extent.width, vk_extent.height),
            clear_value_color(clear_color), // Unused
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::AttachmentLoadOp::LOAD,
            vk::RenderingFlags::empty(),
            1,
            0,
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[no_vrs_vertices_buffer.get()], &[0]);
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_rendering(device, cmd);
    }
    // Copy image to verification buffer after rendering.
    copy_color_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        vk_extent,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;
    let result = color_buffer.read_bytes(device)?;

    // The reference must match the vertex+color combination for the second draw and a rate of 1x1.
    if !compare_color(result, fb_width, fb_height, color_comp_threshold, |x, y| {
        red_blue_reference(x, y, fb_width, fb_height)
    }) {
        return Err(TestError::Fail(
            "Unexpected color buffer contents -- check log for details".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `createFragmentShadingRateMiscTests`
pub fn create_fragment_shading_rate_misc_tests(group: &mut TestCaseGroup, group_params: GroupParams) {
    if !group_params.use_dynamic_rendering {
        // Test drawing with VRS enabled by an attachment and then disabled
        group.add_child(Box::new(MiscCase {
            name: "enable_disable_attachment",
            kind: Kind::EnableDisable,
        }) as Box<dyn TestCase>);
        // Test drawing with VRS enabled and no frag shader
        group.add_child(Box::new(MiscCase {
            name: "no_frag_shader",
            kind: Kind::NoFrag,
        }) as Box<dyn TestCase>);
        let mut params = TestParams {
            use_robustness2: false,
            use_base_mip_level1: false,
        };
        group.add_child(Box::new(MiscCase {
            name: "test_oob_attachment",
            kind: Kind::Oob(params),
        }) as Box<dyn TestCase>);
        params.use_robustness2 = true;
        group.add_child(Box::new(MiscCase {
            name: "test_oob_attachment_robustness2",
            kind: Kind::Oob(params),
        }) as Box<dyn TestCase>);
    } else {
        // Test drawing with FSR enabled both explicitly and implicitly by attachment absence, single pipeline.
        group.add_child(Box::new(MiscCase {
            name: "explicit_and_implicit_enable",
            kind: Kind::ExplicitImplicitEnable,
        }) as Box<dyn TestCase>);
    }
}
