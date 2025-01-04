// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktShaderTileImageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of every case (`addVS`, the five fragment shader writers and `addCS`) are written out
// by `scripts/gen_shader_tile_image_programs.py` with the template parameters filled in, and found by the name `tile_<case path>`; the host side is
// the test case and instance below. The format table carries what `tcu::getTextureChannelClass`, `getTextureFormatBitDepth` and
// `getNumUsedChannels` answer for the formats of the group.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, InstanceV1_1, KhrSynchronization2ExtensionDeviceCommands};

use crate::generated::shaders::shader_tile_image::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const K_IMAGE_SIZE: u32 = 4; // power of 2 for helper test
const K_MULTI_DRAW_ELEMENT_COUNT: u32 = 3;
const K_MULTI_PATCH_ELEMENT_COUNT: u32 = 3;
const K_MRT_COUNT: u32 = 2;
const K_DERIVATIVE0: u32 = 1; // derivative 0 + offset 1
const K_DERIVATIVE1: u32 = 2; // derivative 1 + offset 1

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum TestType {
    Color,
    MultiRenderTarget,
    MultiRenderTargetDynamicIndex,
    MsaaSampleMask,
    HelperClassColor,
    HelperClassDepth,
    HelperClassStencil,
    Depth,
    Stencil,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum ChannelClass {
    UnsignedFixedPoint,
    SignedFixedPoint,
    UnsignedInteger,
    SignedInteger,
    FloatingPoint,
}

#[derive(Clone, Copy)]
struct FormatEntry {
    format: vk::Format,
    class: ChannelClass,
    /// `getTextureFormatBitDepth(...).y()`
    bits_y: u32,
    has_depth: bool,
    has_stencil: bool,
}

const fn color(format: vk::Format, class: ChannelClass, bits_y: u32) -> FormatEntry {
    FormatEntry {
        format,
        class,
        bits_y,
        has_depth: false,
        has_stencil: false,
    }
}

const fn depth_stencil(format: vk::Format, has_depth: bool, has_stencil: bool) -> FormatEntry {
    FormatEntry {
        format,
        class: ChannelClass::FloatingPoint,
        bits_y: 0,
        has_depth,
        has_stencil,
    }
}

use ChannelClass::{
    FloatingPoint as Float, SignedFixedPoint as Snorm, SignedInteger as Sint, UnsignedFixedPoint as Unorm,
    UnsignedInteger as Uint,
};

/// The `formats` of `createShaderTileImageTestVariations`, in its order.
static FORMATS: [FormatEntry; 44] = [
    color(vk::Format::R5G6B5_UNORM_PACK16, Unorm, 6),
    color(vk::Format::R8G8_UNORM, Unorm, 8),
    color(vk::Format::R8G8_SNORM, Snorm, 8),
    color(vk::Format::R8G8_UINT, Uint, 8),
    color(vk::Format::R8G8_SINT, Sint, 8),
    color(vk::Format::R8G8B8A8_UNORM, Unorm, 8),
    color(vk::Format::R8G8B8A8_SNORM, Snorm, 8),
    color(vk::Format::R8G8B8A8_UINT, Uint, 8),
    color(vk::Format::R8G8B8A8_SINT, Sint, 8),
    color(vk::Format::R8G8B8A8_SRGB, Unorm, 8),
    color(vk::Format::A8B8G8R8_UNORM_PACK32, Unorm, 8),
    color(vk::Format::A8B8G8R8_SNORM_PACK32, Snorm, 8),
    color(vk::Format::A8B8G8R8_UINT_PACK32, Uint, 8),
    color(vk::Format::A8B8G8R8_SINT_PACK32, Sint, 8),
    color(vk::Format::A8B8G8R8_SRGB_PACK32, Unorm, 8),
    color(vk::Format::B8G8R8A8_UNORM, Unorm, 8),
    color(vk::Format::B8G8R8A8_SRGB, Unorm, 8),
    color(vk::Format::A2R10G10B10_UNORM_PACK32, Unorm, 10),
    color(vk::Format::A2B10G10R10_UNORM_PACK32, Unorm, 10),
    color(vk::Format::A2B10G10R10_UINT_PACK32, Uint, 10),
    color(vk::Format::R16G16_UNORM, Unorm, 16),
    color(vk::Format::R16G16_SNORM, Snorm, 16),
    color(vk::Format::R16G16_UINT, Uint, 16),
    color(vk::Format::R16G16_SINT, Sint, 16),
    color(vk::Format::R16G16_SFLOAT, Float, 16),
    color(vk::Format::R16G16B16A16_UNORM, Unorm, 16),
    color(vk::Format::R16G16B16A16_SNORM, Snorm, 16),
    color(vk::Format::R16G16B16A16_UINT, Uint, 16),
    color(vk::Format::R16G16B16A16_SINT, Sint, 16),
    color(vk::Format::R16G16B16A16_SFLOAT, Float, 16),
    color(vk::Format::R32G32_UINT, Uint, 32),
    color(vk::Format::R32G32_SINT, Sint, 32),
    color(vk::Format::R32G32_SFLOAT, Float, 32),
    color(vk::Format::R32G32B32A32_UINT, Uint, 32),
    color(vk::Format::R32G32B32A32_SINT, Sint, 32),
    color(vk::Format::R32G32B32A32_SFLOAT, Float, 32),
    color(vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16, Unorm, 10),
    depth_stencil(vk::Format::D16_UNORM, true, false),
    depth_stencil(vk::Format::X8_D24_UNORM_PACK32, true, false),
    depth_stencil(vk::Format::D32_SFLOAT, true, false),
    depth_stencil(vk::Format::S8_UINT, false, true),
    depth_stencil(vk::Format::D16_UNORM_S8_UINT, true, true),
    depth_stencil(vk::Format::D24_UNORM_S8_UINT, true, true),
    depth_stencil(vk::Format::D32_SFLOAT_S8_UINT, true, true),
];

fn format_entry(format: vk::Format) -> FormatEntry {
    FORMATS
        .iter()
        .copied()
        .find(|entry| entry.format == format)
        .expect("a format of the table")
}

#[derive(Clone, Copy)]
struct TestParam {
    coherent: bool,
    test_type: TestType,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    sample_count: u32,
    multiple_draw_calls: bool,
    multiple_patches_per_draw: bool,
    frame_buffer_size: u32,
}

fn is_helper_class_test(test_type: TestType) -> bool {
    matches!(
        test_type,
        TestType::HelperClassColor | TestType::HelperClassDepth | TestType::HelperClassStencil
    )
}

fn sample_count_flags(sample_count: u32) -> vk::SampleCountFlags {
    match sample_count {
        1 => vk::SampleCountFlags::_1,
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        16 => vk::SampleCountFlags::_16,
        32 => vk::SampleCountFlags::_32,
        _ => panic!("no sample count {sample_count}"),
    }
}

fn get_sample_mask(test_type: TestType) -> u32 {
    if test_type == TestType::MsaaSampleMask {
        0xaaaaaaaa
    } else {
        0
    }
}

fn get_color_attachment_count(test_type: TestType) -> u32 {
    match test_type {
        TestType::MultiRenderTargetDynamicIndex
        | TestType::MultiRenderTarget
        | TestType::HelperClassColor
        | TestType::HelperClassDepth
        | TestType::HelperClassStencil => K_MRT_COUNT,
        _ => 1,
    }
}

fn get_vertex_count_per_patch(param: &TestParam) -> u32 {
    if param.test_type == TestType::MsaaSampleMask {
        3
    } else {
        6
    }
}

fn get_patches_per_draw_count(multiple_patches_per_draw: bool) -> u32 {
    if multiple_patches_per_draw {
        K_MULTI_PATCH_ELEMENT_COUNT
    } else {
        1
    }
}

fn get_draw_call_count(param: &TestParam) -> u32 {
    if is_helper_class_test(param.test_type) {
        // helper class use two draw calls, but it is similar to single draw call
        assert!(!param.multiple_draw_calls);
        return 2;
    }
    if param.multiple_draw_calls {
        K_MULTI_DRAW_ELEMENT_COUNT
    } else {
        1
    }
}

fn is_normalized_color_format(format: vk::Format) -> bool {
    matches!(
        format_entry(format).class,
        ChannelClass::SignedFixedPoint | ChannelClass::UnsignedFixedPoint
    )
}

struct ShaderTileImageTestCase {
    name: String,
    key: String,
    param: TestParam,
}

impl TestCase for ShaderTileImageTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let param = &self.param;
        context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        context.require_device_functionality("VK_EXT_shader_tile_image")?;
        let not_supported = |message: &str| Err(TestError::NotSupported(message.to_string()));

        // sampleRateShading must be enabled to call fragment shader for all the samples in multisampling
        let mut tile_image_features = vk::PhysicalDeviceShaderTileImageFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut tile_image_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        let features = context.get_device_features();

        if tile_image_features.shader_tile_image_color_read_access == vk::FALSE {
            return not_supported("color read access of VK_EXT_shader_tile_image is not supported");
        }

        match param.test_type {
            TestType::Depth | TestType::HelperClassDepth => {
                if tile_image_features.shader_tile_image_depth_read_access == vk::FALSE {
                    return not_supported("depth read access of VK_EXT_shader_tile_image is not supported");
                }
            }
            TestType::Stencil | TestType::HelperClassStencil
                if tile_image_features.shader_tile_image_stencil_read_access == vk::FALSE =>
            {
                return not_supported("stencil read access of VK_EXT_shader_tile_image is not supported");
            }
            _ => {}
        }

        let mut vulkan12_properties = vk::PhysicalDeviceVulkan12Properties::default();
        let mut tile_image_properties = vk::PhysicalDeviceShaderTileImagePropertiesEXT::default();
        let mut properties = vk::PhysicalDeviceProperties2::builder()
            .push_next(&mut tile_image_properties)
            .push_next(&mut vulkan12_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties)
        };
        let limits = context.get_device_properties().limits;

        if tile_image_properties.shader_tile_image_read_sample_from_pixel_rate_invocation == vk::FALSE
            && param.test_type == TestType::MsaaSampleMask
        {
            return not_supported("multi-samples pixel access of VK_EXT_shader_tile_image is not supported");
        }
        if tile_image_properties.shader_tile_image_read_from_helper_invocation == vk::FALSE
            && is_helper_class_test(param.test_type)
        {
            return not_supported("helper class fragments access of VK_EXT_shader_tile_image is not supported");
        }

        let sample_flag = sample_count_flags(param.sample_count);
        let class = format_entry(param.color_format).class;
        if matches!(class, ChannelClass::UnsignedInteger | ChannelClass::SignedInteger) {
            if !vulkan12_properties
                .framebuffer_integer_color_sample_counts
                .contains(sample_flag)
                || !limits.sampled_image_integer_sample_counts.contains(sample_flag)
            {
                return not_supported("Sample count not supported");
            }
        } else if !limits.framebuffer_color_sample_counts.contains(sample_flag)
            || !limits.sampled_image_color_sample_counts.contains(sample_flag)
        {
            return not_supported("Sample count not supported");
        }

        if param.sample_count != 1
            && param.test_type != TestType::MsaaSampleMask
            && features.sample_rate_shading == vk::FALSE
        {
            return not_supported("sampleRateShading feature not supported");
        }

        let attachment_count = get_color_attachment_count(param.test_type);
        if limits.max_fragment_output_attachments < attachment_count
            || limits.max_per_stage_descriptor_input_attachments < attachment_count
        {
            return not_supported("attachment number not supported");
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let color_format_properties =
            unsafe { instance.get_physical_device_format_properties(physical_device, param.color_format) };
        let ds_format_properties =
            unsafe { instance.get_physical_device_format_properties(physical_device, param.depth_stencil_format) };
        if !color_format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
        {
            return not_supported("Format can't be used as color attachment");
        }
        if !ds_format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return not_supported("Format can't be used as depth stencil attachment");
        }

        Ok(())
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderTileImageTestInstance {
            context,
            param: self.param,
        })
    }
}

struct ShaderTileImageTestInstance<'a> {
    context: &'a Context<'a>,
    param: TestParam,
}

/// `transition2DImage`
#[allow(clippy::too_many_arguments)]
fn transition_2d_image(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    aspect_mask: vk::ImageAspectFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
) {
    let barrier = make_image_memory_barrier(
        src_access_mask,
        dst_access_mask,
        old_layout,
        new_layout,
        image,
        make_image_subresource_range(aspect_mask, 0, 1, 0, 1),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage_mask,
            dst_stage_mask,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

impl ShaderTileImageTestInstance<'_> {
    /// `generateGraphicsPipeline`
    fn graphics_pipeline_state(
        &self,
        disable_color0_write: bool,
        disable_depth_write: bool,
        disable_stencil_write: bool,
    ) -> DrawPipelineState {
        let param = &self.param;
        let attachment_count = get_color_attachment_count(param.test_type);

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(param.frame_buffer_size, param.frame_buffer_size);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];

        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
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

        state.samples = sample_count_flags(param.sample_count);
        state.sample_shading = param.test_type != TestType::MsaaSampleMask;
        state.min_sample_shading = 1.0;
        if param.test_type == TestType::MsaaSampleMask {
            state.sample_mask = Some(get_sample_mask(param.test_type));
        }

        let blend_attachment = vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::ONE,
            dst_color_blend_factor: vk::BlendFactor::ONE,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::ONE,
            dst_alpha_blend_factor: vk::BlendFactor::ONE,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::R | vk::ColorComponentFlags::G,
        };
        let mut blend_attachments = vec![blend_attachment; attachment_count as usize];
        if disable_color0_write {
            blend_attachments[0].color_write_mask = vk::ColorComponentFlags::empty();
        }
        state.color_blend_attachments = blend_attachments;
        state.color_attachment_count = attachment_count;

        let mut stencil_op_state = vk::StencilOpState {
            fail_op: vk::StencilOp::ZERO,
            pass_op: vk::StencilOp::INCREMENT_AND_WRAP,
            depth_fail_op: vk::StencilOp::INCREMENT_AND_WRAP,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0xff,
            write_mask: 0xff,
            reference: 0,
        };
        if disable_stencil_write {
            stencil_op_state.fail_op = vk::StencilOp::KEEP;
            stencil_op_state.pass_op = vk::StencilOp::KEEP;
            stencil_op_state.depth_fail_op = vk::StencilOp::KEEP;
        }
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(!disable_depth_write)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(true)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();

        let ds_entry = format_entry(param.depth_stencil_format);
        state.rendering_format = Some(param.color_format);
        state.rendering_formats = vec![param.color_format; attachment_count as usize];
        state.depth_rendering_format = if ds_entry.has_depth {
            param.depth_stencil_format
        } else {
            vk::Format::UNDEFINED
        };
        state.stencil_rendering_format = if ds_entry.has_stencil {
            param.depth_stencil_format
        } else {
            vk::Format::UNDEFINED
        };
        state
    }

    /// `simulate`
    fn simulate(&self, fx: u32, fy: u32, fs: u32, render_target_id: u32) -> u32 {
        let param = &self.param;
        let total_layer_count =
            get_draw_call_count(param) * get_patches_per_draw_count(param.multiple_patches_per_draw);

        if param.test_type == TestType::MsaaSampleMask {
            return if (get_sample_mask(param.test_type) >> fs) & 0x1 == 0x1 {
                total_layer_count + render_target_id
            } else {
                0
            };
        }
        if param.test_type == TestType::Stencil {
            return total_layer_count + render_target_id;
        }
        if is_helper_class_test(param.test_type) {
            // derivative is 1 because of coverage, 0 fills all or none of the quad; (+1) for differentiating the clear value
            return if fx == fy { K_DERIVATIVE1 } else { K_DERIVATIVE0 };
        }
        total_layer_count + render_target_id + fs
    }
}

impl TestInstance for ShaderTileImageTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let param = self.param;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let binaries = context.get_binary_collection();

        let frame_buffer_size = param.frame_buffer_size;
        let sample_count = param.sample_count;
        let attachment_count = get_color_attachment_count(param.test_type);
        let drawn_vertices_per_draw =
            get_vertex_count_per_patch(&param) * get_patches_per_draw_count(param.multiple_patches_per_draw);

        // generateAttachments
        let make_image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: frame_buffer_size,
                    height: frame_buffer_size,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(sample_count_flags(sample_count))
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        let color_usage =
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC;
        let image_buffer_size = (frame_buffer_size * frame_buffer_size) as usize * 8 * sample_count as usize;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let mut color_images = Vec::new();
        let mut color_views = Vec::new();
        let mut image_buffers = Vec::new();
        for _ in 0..attachment_count {
            let image = ImageWithMemory::new(
                device,
                allocator,
                make_image_info(param.color_format, color_usage),
                MemoryRequirement::ANY,
            )?;
            color_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                param.color_format,
                color_srr,
            )?);
            color_images.push(image);
            image_buffers.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    image_buffer_size as vk::DeviceSize,
                    vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        let ds_entry = format_entry(param.depth_stencil_format);
        let mut ds_aspect = vk::ImageAspectFlags::empty();
        if ds_entry.has_depth {
            ds_aspect |= vk::ImageAspectFlags::DEPTH;
        }
        if ds_entry.has_stencil {
            ds_aspect |= vk::ImageAspectFlags::STENCIL;
        }
        let ds_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_info(
                param.depth_stencil_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let ds_view = make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            param.depth_stencil_format,
            make_image_subresource_range(ds_aspect, 0, 1, 0, 1),
        )?;

        // generateVertexBuffer
        let draw_count = get_draw_call_count(&param);
        let patch_count_per_draw = get_patches_per_draw_count(param.multiple_patches_per_draw);
        let mut vbo: Vec<[f32; 2]> = Vec::new();
        for patch_index in 0..patch_count_per_draw * draw_count {
            vbo.push([-1.0, -1.0]);
            vbo.push([1.0, 1.0]);
            vbo.push([-1.0, 1.0]);
            if get_vertex_count_per_patch(&param) == 6 {
                if is_helper_class_test(param.test_type) && patch_index == 0 {
                    vbo.push([-1.0, -1.0]);
                    vbo.push([-1.0, -1.0]);
                    vbo.push([-1.0, -1.0]);
                } else {
                    vbo.push([-1.0, -1.0]);
                    vbo.push([1.0, -1.0]);
                    vbo.push([1.0, 1.0]);
                }
            }
        }
        let vertex_bytes: Vec<u8> = vbo.iter().flatten().flat_map(|value| value.to_ne_bytes()).collect();
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                vertex_bytes.len() as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_bytes.as_ptr(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_bytes.len(),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // The graphics pipelines: one for the draws, one that writes nothing for the second draw of the helper class cases.
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 4,
        }];
        let graphics_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let graphics_pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&graphics_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];
        let graphics_pipeline = create_draw_pipeline(
            device,
            *graphics_pipeline_layout,
            vk::RenderPass::null(),
            &stages,
            &self.graphics_pipeline_state(false, false, false),
        )?;
        let graphics_pipeline_for_helper_class = create_draw_pipeline(
            device,
            *graphics_pipeline_layout,
            vk::RenderPass::null(),
            &stages,
            &self.graphics_pipeline_state(true, true, true),
        )?;

        // generateComputePipeline: copies the colour image to a buffer in linear layout
        let compute_module = create_shader_module(device, binaries.get("comp")?)?;
        let compute_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::SAMPLED_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let compute_pipeline_layout = make_pipeline_layout(device, &[*compute_set_layout])?;
        let compute_stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_module)
            .name(b"main\0")
            .build();
        let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(compute_stage)
            .layout(*compute_pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let compute_pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::SAMPLED_IMAGE, attachment_count)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, attachment_count)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                attachment_count,
            )?;
        let mut descriptor_sets = Vec::new();
        for i in 0..attachment_count as usize {
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *compute_set_layout)?;
            let image_info = vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: color_views[i].get(),
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            };
            let buffer_info = vk::DescriptorBufferInfo {
                buffer: image_buffers[i].get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            let image_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::SAMPLED_IMAGE,
                image_info: &image_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            };
            let buffer_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: 1,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &buffer_info,
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[image_write, buffer_write], &[] as &[vk::CopyDescriptorSet]) };
            descriptor_sets.push(descriptor_set);
        }

        // rendering
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        };
        let ds_clear_value = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
        };
        let render_area = rect_2d(frame_buffer_size, frame_buffer_size);

        let color_attachments: Vec<vk::RenderingAttachmentInfo> = color_views
            .iter()
            .map(|view| {
                vk::RenderingAttachmentInfo::builder()
                    .image_view(view.get())
                    .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(clear_value)
                    .build()
            })
            .collect();

        let ds_layout = match (ds_entry.has_depth, ds_entry.has_stencil) {
            (true, true) => vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            (true, false) => vk::ImageLayout::DEPTH_ATTACHMENT_OPTIMAL,
            _ => vk::ImageLayout::STENCIL_ATTACHMENT_OPTIMAL,
        };
        let ds_attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(ds_view.get())
            .image_layout(ds_layout)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(ds_clear_value)
            .build();
        let mut rendering_info = vk::RenderingInfo::builder()
            .render_area(render_area)
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_attachments);
        if ds_entry.has_depth {
            rendering_info = rendering_info.depth_attachment(&ds_attachment);
        }
        if ds_entry.has_stencil {
            rendering_info = rendering_info.stencil_attachment(&ds_attachment);
        }

        for image in &color_images {
            transition_2d_image(
                device,
                cmd,
                image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            );
        }
        transition_2d_image(
            device,
            cmd,
            ds_image.get(),
            ds_aspect,
            vk::ImageLayout::UNDEFINED,
            ds_layout,
            vk::AccessFlags::empty(),
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        );

        let has_khr_sync2 = context
            .get_device_extensions()
            .iter()
            .any(|e| e == "VK_KHR_synchronization2");
        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);

            for draw_index in 0..draw_count {
                let pipeline = if draw_index == 1 && is_helper_class_test(param.test_type) {
                    &graphics_pipeline_for_helper_class
                } else {
                    &graphics_pipeline
                };
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);

                device.cmd_push_constants(
                    cmd,
                    *graphics_pipeline_layout,
                    vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT,
                    0,
                    &draw_index.to_ne_bytes(),
                );
                let vertex_buffer_offset = (drawn_vertices_per_draw * draw_index) as vk::DeviceSize * 8;
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);

                if !param.coherent {
                    let depth_stencil_type = matches!(param.test_type, TestType::Depth | TestType::Stencil);
                    let memory_barrier = if depth_stencil_type {
                        vk::MemoryBarrier2::builder()
                            .src_stage_mask(
                                vk::PipelineStageFlags2::EARLY_FRAGMENT_TESTS
                                    | vk::PipelineStageFlags2::LATE_FRAGMENT_TESTS,
                            )
                            .src_access_mask(vk::AccessFlags2::DEPTH_STENCIL_ATTACHMENT_WRITE)
                            .dst_stage_mask(
                                vk::PipelineStageFlags2::EARLY_FRAGMENT_TESTS
                                    | vk::PipelineStageFlags2::LATE_FRAGMENT_TESTS,
                            )
                            .dst_access_mask(vk::AccessFlags2::DEPTH_STENCIL_ATTACHMENT_READ)
                            .build()
                    } else {
                        vk::MemoryBarrier2::builder()
                            .src_stage_mask(vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT)
                            .src_access_mask(vk::AccessFlags2::COLOR_ATTACHMENT_WRITE)
                            .dst_stage_mask(vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT)
                            .dst_access_mask(vk::AccessFlags2::COLOR_ATTACHMENT_READ)
                            .build()
                    };
                    let memory_barriers = [memory_barrier];
                    let dependency_info = vk::DependencyInfo::builder()
                        .dependency_flags(vk::DependencyFlags::BY_REGION)
                        .memory_barriers(&memory_barriers);
                    if has_khr_sync2 {
                        device.cmd_pipeline_barrier2_khr(cmd, &dependency_info);
                    } else {
                        device.cmd_pipeline_barrier2(cmd, &dependency_info);
                    }
                }

                device.cmd_draw(cmd, drawn_vertices_per_draw, 1, 0, 0);
            }
            device.cmd_end_rendering(cmd);
        }

        for image in &color_images {
            transition_2d_image(
                device,
                cmd,
                image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::COMPUTE_SHADER,
            );
        }
        unsafe {
            let mem_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                )
                .dst_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);

            // Copy color images to buffer memory
            for descriptor_set in &descriptor_sets {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *compute_pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd, frame_buffer_size, frame_buffer_size, 1);
            }

            let host_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // checkResult
        let vertex_count_per_patch = get_vertex_count_per_patch(&param);
        for rt in 0..attachment_count {
            invalidate_alloc(device, image_buffers[rt as usize].get_allocation())?;
            if rt != 1 && is_helper_class_test(param.test_type) {
                continue;
            }
            let result_data = unsafe {
                std::slice::from_raw_parts(
                    image_buffers[rt as usize]
                        .get_allocation()
                        .get_host_ptr()
                        .cast_const()
                        .cast::<u32>(),
                    image_buffer_size / 4,
                )
            };

            for fy in 0..frame_buffer_size {
                for fx in 0..frame_buffer_size {
                    for fs in 0..sample_count {
                        let expected_value = self.simulate(fx, fy, fs, rt);
                        // getResultValue
                        let index = (((fy * frame_buffer_size) + fx) * sample_count + fs) as usize * 2;
                        let result_value = if result_data[index] != 0 {
                            0xFFFF_FFFF
                        } else {
                            result_data[index + 1]
                        };

                        let failed = if is_helper_class_test(param.test_type) {
                            expected_value != result_value
                                && ((fx as i32 - fy as i32).abs() != 1 || result_value != K_DERIVATIVE1)
                        } else if vertex_count_per_patch == 6 {
                            // Fill full quad to the framebuffer
                            expected_value != result_value
                        } else if fy > fx {
                            // Fill a triangle to the framebuffer, check half of framebuffer: inside of triangle
                            expected_value != result_value
                        } else {
                            // outside of filling triangle or triangle edge, can be not filling
                            result_value != 0 && result_value != expected_value
                        };
                        if failed {
                            return Ok(TestStatus::fail("Fail"));
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn format_to_name(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

/// `createShaderTileImageTestVariations` and `createShaderTileImageTests`
pub fn create_shader_tile_image_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_tile_image");

    let test_types = [
        (TestType::Color, "color"),
        (TestType::MultiRenderTarget, "mrt"),
        (TestType::MultiRenderTargetDynamicIndex, "mrt_dynamic_index"),
        (TestType::MsaaSampleMask, "msaa_sample_mask"),
        (TestType::HelperClassColor, "helper_class_color"),
        (TestType::HelperClassDepth, "helper_class_depth"),
        (TestType::HelperClassStencil, "helper_class_stencil"),
        (TestType::Depth, "depth"),
        (TestType::Stencil, "stencil"),
    ];
    let sample_counts = [1u32, 2, 4, 8, 16, 32];

    for (coherent, coherent_name) in [(true, "coherent"), (false, "non_coherent")] {
        let mut coherent_group = TestCaseGroup::new(coherent_name);
        for (test_type, type_name) in test_types {
            let mut type_group = TestCaseGroup::new(type_name);
            for samples in sample_counts {
                if test_type == TestType::MsaaSampleMask && samples == 1 {
                    // SampleMask test requires MSAA
                    continue;
                }
                if is_helper_class_test(test_type) && samples != 1 {
                    // HelperClass test designed for non msaa case
                    continue;
                }
                let sample_group_name = format!("samples_{samples}");
                let mut sample_group = TestCaseGroup::new(sample_group_name.as_str());
                for (multi_draw, draw_name) in [(false, "single_draw"), (true, "multi_draws")] {
                    if is_helper_class_test(test_type) && multi_draw {
                        // helper class 2 draws but works like single draw call
                        continue;
                    }
                    let mut draw_group = TestCaseGroup::new(draw_name);
                    for (multi_patch, patch_name) in [(false, "single_patch"), (true, "multi_patches")] {
                        if !coherent && multi_patch {
                            // cannot guarantee
                            continue;
                        }
                        if is_helper_class_test(test_type) && multi_patch {
                            // helper class works on single patch cases
                            continue;
                        }
                        let mut patch_group = TestCaseGroup::new(patch_name);
                        for entry in &FORMATS {
                            let name = format_to_name(entry.format);
                            let mut param = TestParam {
                                coherent,
                                test_type,
                                color_format: vk::Format::R32G32B32A32_UINT,
                                depth_stencil_format: vk::Format::D32_SFLOAT_S8_UINT,
                                sample_count: samples,
                                multiple_draw_calls: multi_draw,
                                multiple_patches_per_draw: multi_patch,
                                frame_buffer_size: K_IMAGE_SIZE,
                            };
                            let mut add = false;
                            if matches!(test_type, TestType::Depth | TestType::HelperClassDepth) {
                                if entry.has_depth {
                                    param.depth_stencil_format = entry.format;
                                    add = true;
                                }
                            } else if matches!(test_type, TestType::Stencil | TestType::HelperClassStencil) {
                                if entry.has_stencil {
                                    param.depth_stencil_format = entry.format;
                                    add = true;
                                }
                            } else if !entry.has_stencil && !entry.has_depth {
                                if is_helper_class_test(test_type) && is_normalized_color_format(entry.format) {
                                    // reduce helper class test cases and complexities
                                    continue;
                                }
                                let max_result_value = get_draw_call_count(&param)
                                    * get_patches_per_draw_count(param.multiple_patches_per_draw)
                                    * get_color_attachment_count(param.test_type)
                                    + param.sample_count;
                                // color output precision is less than test case: ban the overflow problem
                                if (1u64 << (entry.bits_y - 1)) > u64::from(max_result_value) {
                                    param.color_format = entry.format;
                                    add = true;
                                }
                            }
                            if add {
                                let key = format!(
                                    "tile_{coherent_name}_{type_name}_samples_{samples}_{draw_name}_{patch_name}_{name}"
                                );
                                patch_group.add_child(
                                    Box::new(ShaderTileImageTestCase { name, key, param }) as Box<dyn TestCase>
                                );
                            }
                        }
                        draw_group.add_child(patch_group);
                    }
                    sample_group.add_child(draw_group);
                }
                type_group.add_child(sample_group);
            }
            coherent_group.add_child(type_group);
        }
        group.add_child(coherent_group);
    }

    group
}
