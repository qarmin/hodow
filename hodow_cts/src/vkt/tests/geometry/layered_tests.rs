// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/geometry/vktGeometryLayeredRenderingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/geometry_layered.toml (one program set
// per distinct test type and layer count, the layer count being the depth for a 3D image). The verifiers log a line on failure
// instead of the image sets, and read the layers straight off the readback buffer.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::geometry_layered::ALL_LAYERED_PROGRAMS;
use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel};
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, begin_secondary_command_buffer, end_command_buffer, end_render_pass,
    make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    /// draw to default layer
    DefaultLayer,
    /// draw to single layer
    SingleLayer,
    /// draw all layers
    AllLayers,
    /// draw different content to different layers
    DifferentContent,
    /// draw to all layers, verify gl_Layer fragment input
    LayerId,
    /// draw to all layers, one invocation per layer
    InvocationPerLayer,
    /// draw to all layers, multiple invocations write to multiple layers
    MultipleLayersPerInvocation,
    /// draw to two layers multiple times
    LayeredReadback,
    /// layered rendering using secondary command buffer
    SecondaryCmdBuffer,
}

#[derive(Clone, Copy)]
struct ImageParams {
    view_type: vk::ImageViewType,
    size: vk::Extent3D,
    num_layers: u32,
}

#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    image: ImageParams,
    inherit_framebuffer: bool,
}

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct LayeredPrograms {
    pub name: &'static str,
    pub test_type: &'static str,
    pub num_layers: u32,
    pub target_layer: u32,
    pub view: &'static str,
    pub programs: BinaryCollection,
}

const S_COLORS: [[f32; 4]; 6] = [
    [1.0, 1.0, 1.0, 1.0], // white
    [1.0, 0.0, 0.0, 1.0], // red
    [0.0, 1.0, 0.0, 1.0], // green
    [0.0, 0.0, 1.0, 1.0], // blue
    [1.0, 1.0, 0.0, 1.0], // yellow
    [1.0, 0.0, 1.0, 1.0], // magenta
];

const SECONDARY_CMD_BUF_CLEAR_COLORS: [[f32; 4]; 6] = [
    [1.0, 0.0, 0.0, 1.0],
    [0.0, 1.0, 0.0, 1.0],
    [0.0, 0.0, 1.0, 1.0],
    [1.0, 1.0, 0.0, 1.0],
    [0.0, 1.0, 1.0, 1.0],
    [1.0, 0.0, 1.0, 1.0],
];

fn scale_color(color: [f32; 4], factor: f32) -> [f32; 4] {
    [color[0] * factor, color[1] * factor, color[2] * factor, color[3]]
}

fn get_target_layer(image_params: &ImageParams) -> u32 {
    if image_params.view_type == vk::ImageViewType::_3D {
        image_params.size.depth / 2
    } else {
        image_params.num_layers / 2
    }
}

/// `getShortImageViewTypeName`
fn get_short_image_view_type_name(image_view_type: vk::ImageViewType) -> &'static str {
    match image_view_type {
        vk::ImageViewType::_1D_ARRAY => "1d_array",
        vk::ImageViewType::_2D_ARRAY => "2d_array",
        vk::ImageViewType::CUBE => "cube",
        vk::ImageViewType::CUBE_ARRAY => "cube_array",
        _ => "3d",
    }
}

/// `getImageType`
fn get_image_type(view_type: vk::ImageViewType) -> vk::ImageType {
    match view_type {
        vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => vk::ImageType::_1D,
        vk::ImageViewType::_2D
        | vk::ImageViewType::_2D_ARRAY
        | vk::ImageViewType::CUBE
        | vk::ImageViewType::CUBE_ARRAY => vk::ImageType::_2D,
        _ => vk::ImageType::_3D,
    }
}

fn is_cube_image_view_type(view_type: vk::ImageViewType) -> bool {
    view_type == vk::ImageViewType::CUBE || view_type == vk::ImageViewType::CUBE_ARRAY
}

/// The number of layers the framebuffer has: slices for a 3D image.
fn framebuffer_layers(image: &ImageParams) -> u32 {
    if image.view_type == vk::ImageViewType::_3D {
        image.size.depth
    } else {
        image.num_layers
    }
}

fn image_create_flags(view_type: vk::ImageViewType) -> vk::ImageCreateFlags {
    let cube = if is_cube_image_view_type(view_type) {
        vk::ImageCreateFlags::CUBE_COMPATIBLE
    } else {
        vk::ImageCreateFlags::empty()
    };
    let array_2d = if view_type == vk::ImageViewType::_3D {
        vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE
    } else {
        vk::ImageCreateFlags::empty()
    };
    cube | array_2d
}

fn attachment_view_type(view_type: vk::ImageViewType) -> vk::ImageViewType {
    if view_type == vk::ImageViewType::_3D {
        vk::ImageViewType::_2D_ARRAY
    } else {
        view_type
    }
}

fn align_size(size: u64, alignment: u64) -> u64 {
    size.div_ceil(alignment) * alignment
}

/// `std::max<VkDeviceSize>(nonCoherentAtomSize, 4u)`
fn alignment_size(context: &Context<'_>) -> u64 {
    context.get_device_properties().limits.non_coherent_atom_size.max(4)
}

/// `colorBufferSize` and its siblings: a layer's pixels aligned to `alignment`, for every layer and slice.
fn layered_buffer_size(image: &ImageParams, pixel_size: u64, alignment: u64) -> u64 {
    align_size(
        u64::from(image.size.width) * u64::from(image.size.height) * pixel_size,
        alignment,
    ) * u64::from(image.size.depth)
        * u64::from(image.num_layers)
}

/// `checkImageFormatProperties`
#[allow(clippy::too_many_arguments)]
fn check_image_format_properties(
    context: &Context<'_>,
    image_type: vk::ImageType,
    image_tiling: vk::ImageTiling,
    image_usage_flags: vk::ImageUsageFlags,
    image_create_flags: vk::ImageCreateFlags,
    format: vk::Format,
    required_size: vk::Extent3D,
    required_layers: u32,
) -> Result<(), TestError> {
    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            image_type,
            image_tiling,
            image_usage_flags,
            image_create_flags,
        )
    };

    match result {
        Ok(properties)
            if properties.max_array_layers >= required_layers
                && properties.max_extent.height >= required_size.height
                && properties.max_extent.width >= required_size.width
                && properties.max_extent.depth >= required_size.depth =>
        {
            Ok(())
        }
        _ => Err(TestError::NotSupported(
            "Depth/stencil format is not supported".to_string(),
        )),
    }
}

/// `makeImageCreateInfo`
fn make_image_create_info(
    flags: vk::ImageCreateFlags,
    image_type: vk::ImageType,
    format: vk::Format,
    size: vk::Extent3D,
    num_layers: u32,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        image_type,
        format,
        extent: size,
        mip_levels: 1,
        array_layers: num_layers,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `vk::makeRenderPass(vk, device, colorFormat, depthStencilFormat, loadOperation)` with the default layouts.
fn make_render_pass(
    device: &Device,
    color_format: vk::Format,
    ds_format: vk::Format,
    load_op: vk::AttachmentLoadOp,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let has_color = color_format != vk::Format::UNDEFINED;
    let has_depth_stencil = ds_format != vk::Format::UNDEFINED;
    let initial_layout_color = if load_op == vk::AttachmentLoadOp::LOAD {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::UNDEFINED
    };
    let initial_layout_depth_stencil = if load_op == vk::AttachmentLoadOp::LOAD {
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::UNDEFINED
    };

    let color_attachment_description = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(initial_layout_color)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let depth_stencil_attachment_description = vk::AttachmentDescription::builder()
        .format(ds_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(load_op)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(initial_layout_depth_stencil)
        .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();

    let mut attachment_descriptions = Vec::new();
    if has_color {
        attachment_descriptions.push(color_attachment_description);
    }
    if has_depth_stencil {
        attachment_descriptions.push(depth_stencil_attachment_description);
    }

    let color_attachment_ref = vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };
    let depth_stencil_attachment_ref = vk::AttachmentReference {
        attachment: if has_color { 1 } else { 0 },
        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };

    let subpass_description = vk::SubpassDescription {
        flags: vk::SubpassDescriptionFlags::empty(),
        pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
        input_attachment_count: 0,
        input_attachments: std::ptr::null(),
        color_attachment_count: u32::from(has_color),
        color_attachments: if has_color {
            &color_attachment_ref
        } else {
            std::ptr::null()
        },
        resolve_attachments: std::ptr::null(),
        depth_stencil_attachment: if has_depth_stencil {
            &depth_stencil_attachment_ref
        } else {
            std::ptr::null()
        },
        preserve_attachment_count: 0,
        preserve_attachments: std::ptr::null(),
    };

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(std::slice::from_ref(&subpass_description));
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `makeRenderPassWithSelfDependency`
fn make_render_pass_with_self_dependency(
    device: &Device,
    color_format: vk::Format,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_description = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();

    let color_attachment_ref = vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    };

    let subpass_description = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(std::slice::from_ref(&color_attachment_ref))
        .build();

    let subpass_dependency = vk::SubpassDependency {
        src_subpass: 0,
        dst_subpass: 0,
        src_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
        dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
        src_access_mask: vk::AccessFlags::SHADER_WRITE,
        dst_access_mask: vk::AccessFlags::SHADER_READ,
        dependency_flags: vk::DependencyFlags::BY_REGION,
    };

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(std::slice::from_ref(&attachment_description))
        .subpasses(std::slice::from_ref(&subpass_description))
        .dependencies(std::slice::from_ref(&subpass_dependency));
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `makeGraphicsPipeline` of this file: points, no vertex input, a geometry shader, and a depth/stencil state that counts
/// stencil increments when `use_depth_stencil` is set.
#[allow(clippy::too_many_arguments)]
fn make_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    geometry_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    render_size: (u32, u32),
    use_depth_stencil: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stencil_op_state = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::INCREMENT_AND_CLAMP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::ALWAYS)
        .compare_mask(!0)
        .write_mask(!0)
        .reference(0)
        .build();
    let pipeline_depth_stencil_state_info = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(use_depth_stencil)
        .depth_write_enable(use_depth_stencil)
        .depth_compare_op(vk::CompareOp::LESS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(use_depth_stencil)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build();

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST).with_full_viewport(render_size.0, render_size.1);
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0)
        .build();
    state.depth_stencil = pipeline_depth_stencil_state_info;

    create_draw_pipeline(
        device,
        pipeline_layout,
        render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, vertex_module),
            (vk::ShaderStageFlags::GEOMETRY, geometry_module),
            (vk::ShaderStageFlags::FRAGMENT, fragment_module),
        ],
        &state,
    )
}

/// `copyLayeredImageToBuffer`
fn copy_layered_image_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    image_params: &ImageParams,
) {
    // Image read barrier
    {
        // VUID-VkImageMemoryBarrier-subresourceRange-01725
        let num_layers = if image_params.view_type == vk::ImageViewType::_3D {
            vk::REMAINING_ARRAY_LAYERS
        } else {
            image_params.num_layers
        };
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image,
            color_subresource_range,
        );

        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
    }
    // Color image -> host buffer
    {
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(
                vk::ImageAspectFlags::COLOR,
                0,
                0,
                image_params.num_layers,
            ),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: image_params.size,
        };

        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd_buffer,
                image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer,
                &[region],
            )
        };
    }
    // Buffer write barrier
    {
        let barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer,
            0,
            vk::WHOLE_SIZE,
        );

        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
}

/// `LayeredImageAccess` - a convenience wrapper to access 1D, 2D, and 3D image layers/slices in a uniform way.
struct LayeredImageAccess<'a> {
    width: u32,
    height: u32,
    one_d_modifier: u32,
    layers: u32,
    whole_image: ConstPixelBufferAccess<'a>,
}

impl<'a> LayeredImageAccess<'a> {
    fn create(
        image_type: vk::ImageType,
        format: vk::Format,
        size: vk::Extent3D,
        num_layers: u32,
        data: &'a [u8],
    ) -> Result<Self, TestError> {
        let tex_format = map_vk_format(format)
            .ok_or_else(|| TestError::InternalError(format!("no texture format for {format:?}")))?;
        if image_type == vk::ImageType::_1D {
            // Specialized for 1D images
            Ok(Self {
                width: size.width,
                height: 1,
                one_d_modifier: 1,
                layers: num_layers,
                whole_image: ConstPixelBufferAccess::new(tex_format, [size.width, num_layers, 1], data),
            })
        } else {
            let layers = if image_type == vk::ImageType::_3D {
                size.depth
            } else {
                num_layers
            };
            Ok(Self {
                width: size.width,
                height: size.height,
                one_d_modifier: 0,
                layers,
                whole_image: ConstPixelBufferAccess::new(tex_format, [size.width, size.height, layers], data),
            })
        }
    }

    fn get_layer(&self, layer: u32) -> ConstPixelBufferAccess<'_> {
        self.whole_image.get_subregion(
            0,
            self.one_d_modifier * layer,
            (!self.one_d_modifier & 1) * layer,
            self.width,
            self.height,
            1,
        )
    }

    fn get_num_layers_or_slices(&self) -> u32 {
        self.layers
    }
}

/// `compareColors`
fn compare_colors(color_a: [f32; 4], color_b: [f32; 4], threshold: [f32; 4]) -> bool {
    (0..4).all(|c| (color_a[c] - color_b[c]).abs() < threshold[c])
}

/// `verifyImageSingleColoredRow`
fn verify_image_single_colored_row(
    image: &ConstPixelBufferAccess<'_>,
    row_width_ratio: f32,
    bar_color: [f32; 4],
    top_right_cleared: bool,
    bottom_right_cleared: bool,
) -> bool {
    debug_assert!(row_width_ratio > 0.0);

    let [width, height, _] = image.size();
    let black = [0.0, 0.0, 0.0, 1.0];
    let brown = [0.5, 0.25, 0.0, 1.0];
    let threshold = [0.02; 4];
    let bar_length = (row_width_ratio * width as f32) as i32;
    let bar_length_threshold = 1;

    let mut all_pixels_ok = true;

    for y in 0..height {
        for x in 0..width {
            let color = image.get_pixel(x, y, 0);
            let is_black = compare_colors(color, black, threshold);
            let is_brown = compare_colors(color, brown, threshold);
            let is_color = compare_colors(color, bar_color, threshold);
            let is_outside_color = if (top_right_cleared && y < height / 2) || (bottom_right_cleared && y >= height / 2)
            {
                is_brown
            } else {
                is_black
            };

            let is_ok = if x as i32 <= bar_length - bar_length_threshold {
                is_color
            } else if x as i32 >= bar_length + bar_length_threshold {
                is_outside_color
            } else {
                is_color || is_outside_color
            };

            if !is_ok {
                all_pixels_ok = false;
            }
        }
    }

    if !all_pixels_ok {
        log::info!(
            "Image verification failed. Got unexpected pixels (expected a bar of {bar_color:?} about {bar_length} pixels wide)."
        );
    }
    all_pixels_ok
}

/// `verifyImageMultipleBars` - `pixel` reads the (possibly converted) image.
fn verify_image_multiple_bars(
    width: u32,
    height: u32,
    pixel: impl Fn(u32, u32) -> [f32; 4],
    bar_width_ratios: &[f32],
    bar_values: &[[f32; 4]],
    num_used_channels: u32,
    image_type_name: &str,
) -> bool {
    let threshold = [0.02f32; 4];
    let mut all_pixels_ok = true;

    debug_assert!(!bar_values.is_empty());

    for x in 0..width {
        let mut expected_value = bar_values[0];

        for bar_ndx in 0..bar_values.len() {
            let right_border = (bar_width_ratios[bar_ndx] * width as f32) as i32;

            if (x as i32) < right_border {
                expected_value = bar_values[bar_ndx];

                break;
            }
        }

        for y in 0..height {
            let real_value = pixel(x, y);
            let is_ok = match num_used_channels {
                1 => (real_value[0] - expected_value[0]).abs() < threshold[0],
                _ => compare_colors(real_value, expected_value, threshold),
            };

            all_pixels_ok = all_pixels_ok && is_ok;
        }
    }

    if !all_pixels_ok {
        log::info!("{image_type_name} image verification failed. Got unexpected pixels.");
    }

    all_pixels_ok
}

/// `verifyEmptyImage`
fn verify_empty_image(image: &ConstPixelBufferAccess<'_>) -> bool {
    let black = [0.0, 0.0, 0.0, 1.0];
    let threshold = [0.02; 4];
    let [width, height, _] = image.size();

    for y in 0..height {
        for x in 0..width {
            let color = image.get_pixel(x, y, 0);

            if !compare_colors(color, black, threshold) {
                log::info!("Found (at least) one bad pixel at {x},{y}. Pixel color is not background color.");
                return false;
            }
        }
    }

    true
}

/// `verifyLayerContent`
fn verify_layer_content(
    test_type: TestType,
    image: &ConstPixelBufferAccess<'_>,
    layer_ndx: i32,
    num_layers: i32,
    depth_check: bool,
    stencil_check: bool,
) -> bool {
    let white = [1.0, 1.0, 1.0, 1.0];
    let target_layer = num_layers / 2;
    let variable_bar_ratio = layer_ndx as f32 / num_layers as f32;

    match test_type {
        TestType::DefaultLayer => {
            if layer_ndx == 0 {
                verify_image_single_colored_row(image, 0.5, white, false, false)
            } else {
                verify_empty_image(image)
            }
        }

        TestType::SingleLayer => {
            if layer_ndx == target_layer {
                verify_image_single_colored_row(image, 0.5, white, false, false)
            } else {
                verify_empty_image(image)
            }
        }

        TestType::AllLayers | TestType::InvocationPerLayer => {
            verify_image_single_colored_row(image, 0.5, S_COLORS[layer_ndx as usize % S_COLORS.len()], false, false)
        }

        TestType::DifferentContent | TestType::MultipleLayersPerInvocation => {
            if layer_ndx == 0 {
                verify_empty_image(image)
            } else {
                verify_image_single_colored_row(image, variable_bar_ratio, white, false, false)
            }
        }

        TestType::LayerId => {
            // This code must be in sync with the fragment shader
            let layer_color = [
                if layer_ndx % 2 == 1 { 1.0 } else { 0.5 },
                if (layer_ndx / 2) % 2 == 1 { 1.0 } else { 0.5 },
                if layer_ndx == 0 { 1.0 } else { 0.0 },
                1.0,
            ];
            verify_image_single_colored_row(image, 0.5, layer_color, false, false)
        }

        TestType::LayeredReadback => {
            let bar_width_ratios = [0.25f32, 0.5, 1.0];
            let [width, height, _] = image.size();

            if depth_check {
                let pass0_depth = (layer_ndx + 1) as f32 / (2 * num_layers) as f32;
                let pass1_depth = layer_ndx as f32 / (2 * num_layers) as f32;
                let bar_depths = [[pass1_depth; 4], [pass0_depth; 4], [1.0; 4]];

                verify_image_multiple_bars(
                    width,
                    height,
                    |x, y| {
                        let depth = image.get_pix_depth(x, y, 0);
                        [depth, 0.0, 0.0, 1.0]
                    },
                    &bar_width_ratios,
                    &bar_depths,
                    1,
                    "Depth",
                )
            } else if stencil_check {
                let max_stencil_value = 4;
                let pass0_stencil = 1.0 / max_stencil_value as f32;
                let pass1_stencil = 2.0 / max_stencil_value as f32;
                let bar_stencils = [[pass1_stencil; 4], [pass0_stencil; 4], [0.0; 4]];

                verify_image_multiple_bars(
                    width,
                    height,
                    |x, y| {
                        let stencil_int = image.get_pix_stencil(x, y, 0) as i32;
                        let stencil = if stencil_int < max_stencil_value {
                            stencil_int as f32 / max_stencil_value as f32
                        } else {
                            1.0
                        };
                        [stencil, 0.0, 0.0, 1.0]
                    },
                    &bar_width_ratios,
                    &bar_stencils,
                    1,
                    "Stencil",
                )
            } else {
                let base_color = S_COLORS[layer_ndx as usize % S_COLORS.len()];
                let bar_colors = [
                    scale_color(base_color, 1.00),
                    scale_color(base_color, 0.50),
                    scale_color(base_color, 0.25),
                ];

                verify_image_multiple_bars(
                    width,
                    height,
                    |x, y| image.get_pixel(x, y, 0),
                    &bar_width_ratios,
                    &bar_colors,
                    4,
                    "Color",
                )
            }
        }

        TestType::SecondaryCmdBuffer => {
            let clear_color = SECONDARY_CMD_BUF_CLEAR_COLORS[layer_ndx as usize % SECONDARY_CMD_BUF_CLEAR_COLORS.len()];
            let quad_color = S_COLORS[layer_ndx as usize % S_COLORS.len()];
            // The first draw: blend clearColor and quadColor
            let first_draw: [f32; 4] = std::array::from_fn(|c| (clear_color[c] + quad_color[c]) * 0.5);
            // The second draw: blend previous result and quadColor
            let second_draw: [f32; 4] = std::array::from_fn(|c| (first_draw[c] + quad_color[c]) * 0.5);

            verify_image_single_colored_row(
                image,
                0.5,
                second_draw,
                layer_ndx < num_layers / 2,
                layer_ndx >= num_layers / 2,
            )
        }
    }
}

/// `getLayerDescription`
fn get_layer_description(view_type: vk::ImageViewType, layer: i32) -> String {
    let num_cube_faces = 6;

    if is_cube_image_view_type(view_type) {
        format!("cube {}, face {}", layer / num_cube_faces, layer % num_cube_faces)
    } else if view_type == vk::ImageViewType::_3D {
        format!("slice z = {layer}")
    } else {
        format!("layer {layer}")
    }
}

/// `verifyResults`
fn verify_results(
    params: &TestParams,
    image_format: vk::Format,
    result_data: &[u8],
    depth_check: bool,
    stencil_check: bool,
) -> Result<bool, TestError> {
    let image = LayeredImageAccess::create(
        get_image_type(params.image.view_type),
        image_format,
        params.image.size,
        params.image.num_layers,
        result_data,
    )?;

    let mut num_good_layers = 0;

    for layer_ndx in 0..image.get_num_layers_or_slices() {
        let layer_image = image.get_layer(layer_ndx);

        log::info!(
            "Verifying {}",
            get_layer_description(params.image.view_type, layer_ndx as i32)
        );

        if verify_layer_content(
            params.test_type,
            &layer_image,
            layer_ndx as i32,
            image.get_num_layers_or_slices() as i32,
            depth_check,
            stencil_check,
        ) {
            num_good_layers += 1;
        }
    }

    Ok(num_good_layers == image.get_num_layers_or_slices())
}

/// `zeroBuffer`
fn zero_buffer(device: &Device, buffer: &BufferWithMemory<'_>, size: vk::DeviceSize) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, size as usize) };
    flush_alloc(device, alloc)
}

/// `fillBuffer` - repeats one pixel over `size` bytes of the buffer, starting at `offset`; `write_pixel` sets the pixel.
fn fill_buffer(
    device: &Device,
    buffer: &BufferWithMemory<'_>,
    offset: vk::DeviceSize,
    size: vk::DeviceSize,
    format: vk::Format,
    write_pixel: impl FnOnce(&mut PixelBufferAccess<'_>),
) -> Result<(), TestError> {
    let texture_format =
        map_vk_format(format).ok_or_else(|| TestError::InternalError(format!("no texture format for {format:?}")))?;
    let color_pixel_size = texture_format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError(format!("no pixel size for {format:?}")))?
        as usize;
    let mut color_pixel_buffer = TextureLevel::new(texture_format, 1, 1, 1)?;
    {
        let mut color_pixel = color_pixel_buffer.get_access();
        write_pixel(&mut color_pixel);
    }

    let src = &color_pixel_buffer.data()[..color_pixel_size];
    let alloc = buffer.get_allocation();
    let dst = unsafe { alloc.get_host_ptr().add(offset as usize) };

    let mut pixel_pos = 0usize;
    while pixel_pos < size as usize {
        unsafe { std::ptr::copy_nonoverlapping(src.as_ptr(), dst.add(pixel_pos), color_pixel_size) };
        pixel_pos += color_pixel_size;
    }

    flush_alloc(device, alloc)
}

fn host_slice<'a>(buffer: &'a BufferWithMemory<'_>, size: vk::DeviceSize) -> &'a [u8] {
    unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), size as usize) }
}

/// What the three tests create in the same way: the layered colour image, its attachment view and the host readback buffer.
struct ColorTarget<'a> {
    image: ImageWithMemory<'a>,
    attachment: Unique<'a, vk::ImageView>,
    buffer: BufferWithMemory<'a>,
    buffer_size: vk::DeviceSize,
}

fn make_color_target<'a>(
    device: &'a Device,
    allocator: &SimpleAllocator,
    params: &TestParams,
    image_usage: vk::ImageUsageFlags,
    buffer_usage: vk::BufferUsageFlags,
    alignment: u64,
) -> Result<ColorTarget<'a>, TestError> {
    let num_layers = framebuffer_layers(&params.image);
    let image = ImageWithMemory::new(
        device,
        allocator,
        make_image_create_info(
            image_create_flags(params.image.view_type),
            get_image_type(params.image.view_type),
            COLOR_FORMAT,
            params.image.size,
            params.image.num_layers,
            image_usage,
        ),
        MemoryRequirement::ANY,
    )?;
    let attachment = make_image_view(
        device,
        image.get(),
        attachment_view_type(params.image.view_type),
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers),
    )?;
    let buffer_size = layered_buffer_size(&params.image, 4, alignment);
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, buffer_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    Ok(ColorTarget {
        image,
        attachment,
        buffer,
        buffer_size,
    })
}

/// `test` - one draw, then a readback of every layer.
fn test(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let alignment = alignment_size(context);

    let num_layers = framebuffer_layers(&params.image);
    let clear_color = vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    };
    let render_size = (params.image.size.width, params.image.size.height);

    let target = make_color_target(
        vk,
        allocator,
        &params,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        vk::BufferUsageFlags::TRANSFER_DST,
        alignment,
    )?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(vk, binaries.get("vert")?)?;
    let geometry_module = create_shader_module(vk, binaries.get("geom")?)?;
    let fragment_module = create_shader_module(vk, binaries.get("frag")?)?;

    let render_pass = make_render_pass(vk, COLOR_FORMAT, vk::Format::UNDEFINED, vk::AttachmentLoadOp::CLEAR)?;
    let framebuffer = make_framebuffer(
        vk,
        *render_pass,
        &[*target.attachment],
        render_size.0,
        render_size.1,
        num_layers,
    )?;
    let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(vk, &[])?;
    let pipeline = make_graphics_pipeline(
        vk,
        *pipeline_layout,
        *render_pass,
        *vertex_module,
        *geometry_module,
        *fragment_module,
        render_size,
        false,
    )?;
    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    zero_buffer(vk, &target.buffer, target.buffer_size)?;

    begin_command_buffer(vk, cmd)?;

    begin_render_pass(
        vk,
        cmd,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, render_size.0, render_size.1),
        clear_color,
    );

    unsafe {
        vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        vk.cmd_draw(cmd, 1, 1, 0, 0);
    }
    end_render_pass(vk, cmd);

    // Copy color image to buffer
    copy_layered_image_to_buffer(vk, cmd, target.image.get(), target.buffer.get(), &params.image);

    end_command_buffer(vk, cmd)?;
    submit_commands_and_wait(vk, queue, cmd)?;

    invalidate_alloc(vk, target.buffer.get_allocation())?;

    if !verify_results(
        &params,
        COLOR_FORMAT,
        host_slice(&target.buffer, target.buffer_size),
        false,
        false,
    )? {
        return Ok(TestStatus::fail("Rendered images are incorrect"));
    }
    Ok(TestStatus::pass("OK"))
}

/// `testLayeredReadBack` - two passes over the same attachments with LOAD ops, checking colour, depth and stencil.
fn test_layered_read_back(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let alignment = alignment_size(context);

    let pass_count = 2usize;
    let num_layers = framebuffer_layers(&params.image);
    let create_flags = image_create_flags(params.image.view_type);
    let view_type = attachment_view_type(params.image.view_type);
    let image_type = get_image_type(params.image.view_type);
    let image_extent_2d = (params.image.size.width, params.image.size.height);

    let color_image_pixel_size = 4u64;
    let color_image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

    let ds_format = vk::Format::D24_UNORM_S8_UINT;
    // Depth/stencil 2D_ARRAY attachments cannot be taken from a 3D image, use a 2D_ARRAY image instead
    let ds_image_type = if image_type == vk::ImageType::_3D {
        vk::ImageType::_2D
    } else {
        image_type
    };
    let ds_image_size = vk::Extent3D {
        width: params.image.size.width,
        height: params.image.size.height,
        depth: 1,
    };
    let ds_image_create_flags = if is_cube_image_view_type(params.image.view_type) {
        vk::ImageCreateFlags::CUBE_COMPATIBLE
    } else {
        vk::ImageCreateFlags::empty()
    };
    let ds_image_pixel_size = 4u64;
    let ds_image_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST;
    let ds_aspect_flags = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
    let depth_buffer_size = layered_buffer_size(&params.image, ds_image_pixel_size, alignment);

    let stencil_buffer_format = vk::Format::S8_UINT;
    let stencil_pixel_size = 1u64;
    let stencil_buffer_size = layered_buffer_size(&params.image, stencil_pixel_size, alignment);

    check_image_format_properties(
        context,
        image_type,
        vk::ImageTiling::OPTIMAL,
        ds_image_usage,
        create_flags,
        ds_format,
        params.image.size,
        params.image.num_layers,
    )?;

    let color = make_color_target(
        vk,
        allocator,
        &params,
        color_image_usage,
        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        alignment,
    )?;
    let color_buffer_size = color.buffer_size;

    let ds_image = ImageWithMemory::new(
        vk,
        allocator,
        make_image_create_info(
            ds_image_create_flags,
            ds_image_type,
            ds_format,
            ds_image_size,
            num_layers,
            ds_image_usage,
        ),
        MemoryRequirement::ANY,
    )?;
    let ds_attachment = make_image_view(
        vk,
        ds_image.get(),
        view_type,
        ds_format,
        make_image_subresource_range(ds_aspect_flags, 0, 1, 0, num_layers),
    )?;
    let depth_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            depth_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let stencil_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            stencil_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(vk, binaries.get("vert")?)?;
    let geometry_module = create_shader_module(vk, binaries.get("geom")?)?;
    let fragment_module = create_shader_module(vk, binaries.get("frag")?)?;

    let render_pass = make_render_pass(vk, COLOR_FORMAT, ds_format, vk::AttachmentLoadOp::LOAD)?;
    let framebuffer = make_framebuffer(
        vk,
        *render_pass,
        &[*color.attachment, *ds_attachment],
        image_extent_2d.0,
        image_extent_2d.1,
        num_layers,
    )?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, pass_count as u32)
        .build(
            vk,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            pass_count as u32,
        )?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::GEOMETRY)
        .build(vk)?;
    let descriptor_sets = [
        make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?,
        make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?,
    ];

    let uniform_buf_size = std::mem::size_of::<u32>() as vk::DeviceSize;
    let uniform_bufs = [
        BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(uniform_buf_size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?,
        BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(uniform_buf_size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?,
    ];

    let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(vk, &[*descriptor_set_layout])?;
    let pipeline = make_graphics_pipeline(
        vk,
        *pipeline_layout,
        *render_pass,
        *vertex_module,
        *geometry_module,
        *fragment_module,
        image_extent_2d,
        true,
    )?;
    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    let color_subres_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
    let ds_subres_range = make_image_subresource_range(ds_aspect_flags, 0, 1, 0, num_layers);
    let mut result = String::new();
    let no_clear = vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    };

    begin_command_buffer(vk, cmd)?;
    {
        // Transition the images to new layouts
        let color_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            color.image.get(),
            color_subres_range,
        );
        let ds_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            ds_image.get(),
            ds_subres_range,
        );

        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[color_barrier],
            );
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[ds_barrier],
            );
        }

        for layer_ndx in 0..num_layers {
            let image_extent = vk::Extent3D {
                width: params.image.size.width,
                height: params.image.size.height,
                depth: 1,
            };

            // Clear color image with initial value
            {
                let layer = if params.image.view_type == vk::ImageViewType::_3D {
                    0
                } else {
                    layer_ndx
                };
                let image_depth = if params.image.view_type == vk::ImageViewType::_3D {
                    layer_ndx
                } else {
                    0
                };
                let image_offset = vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: image_depth as i32,
                };

                let clear_color = scale_color(S_COLORS[layer_ndx as usize % S_COLORS.len()], 0.25);
                let buffer_slice_size = align_size(
                    u64::from(params.image.size.width) * u64::from(params.image.size.height) * color_image_pixel_size,
                    alignment,
                );
                let buffer_offset = u64::from(layer_ndx) * buffer_slice_size;
                let image_subresource = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, layer, 1);
                let buffer_image_copy_region = vk::BufferImageCopy {
                    buffer_offset,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource,
                    image_offset,
                    image_extent,
                };

                fill_buffer(
                    vk,
                    &color.buffer,
                    buffer_offset,
                    buffer_slice_size,
                    COLOR_FORMAT,
                    |pixel| pixel.set_pixel(clear_color, 0, 0, 0),
                )?;
                unsafe {
                    vk.cmd_copy_buffer_to_image(
                        cmd,
                        color.buffer.get(),
                        color.image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[buffer_image_copy_region],
                    )
                };
            }

            // Clear depth image with initial value
            {
                let depth_value = 1.0f32;
                let buffer_slice_size = align_size(
                    u64::from(params.image.size.width) * u64::from(params.image.size.height) * ds_image_pixel_size,
                    alignment,
                );
                let buffer_offset = u64::from(layer_ndx) * buffer_slice_size;
                let image_subresource = make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, layer_ndx, 1);
                let buffer_image_copy_region = vk::BufferImageCopy {
                    buffer_offset,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource,
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent,
                };

                fill_buffer(
                    vk,
                    &depth_buffer,
                    buffer_offset,
                    buffer_slice_size,
                    ds_format,
                    |pixel| pixel.set_pix_depth(depth_value, 0, 0, 0),
                )?;
                unsafe {
                    vk.cmd_copy_buffer_to_image(
                        cmd,
                        depth_buffer.get(),
                        ds_image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[buffer_image_copy_region],
                    )
                };
            }

            // Clear stencil image with initial value
            {
                let stencil_value = 0u8;
                let buffer_slice_size = align_size(
                    u64::from(params.image.size.width) * u64::from(params.image.size.height) * stencil_pixel_size,
                    alignment,
                );
                let buffer_offset = u64::from(layer_ndx) * buffer_slice_size;
                let image_subresource = make_image_subresource_layers(vk::ImageAspectFlags::STENCIL, 0, layer_ndx, 1);
                let buffer_image_copy_region = vk::BufferImageCopy {
                    buffer_offset,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource,
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent,
                };

                unsafe {
                    std::ptr::write_bytes(
                        stencil_buffer
                            .get_allocation()
                            .get_host_ptr()
                            .add(buffer_offset as usize),
                        stencil_value,
                        buffer_slice_size as usize,
                    )
                };
                flush_alloc(vk, stencil_buffer.get_allocation())?;
                unsafe {
                    vk.cmd_copy_buffer_to_image(
                        cmd,
                        stencil_buffer.get(),
                        ds_image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[buffer_image_copy_region],
                    )
                };
            }
        }

        // VK_ATTACHMENT_LOAD_OP_LOAD is used for both color and D/S attachments. Thus, VK_ACCESS_COLOR_ATTACHMENT_READ_BIT
        // and VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_READ_BIT bits must be included in the destination access mask of the color
        // and depth barriers respectively.
        let color_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color.image.get(),
            color_subres_range,
        );
        let ds_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ds_image.get(),
            ds_subres_range,
        );

        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[color_barrier],
            );
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[ds_barrier],
            );
        }
    }

    {
        // These barriers are inserted between each pair of renderpasses in the following loop. Note that
        // VK_ATTACHMENT_LOAD_OP_LOAD is used for color and D/S attachments hence VK_ACCESS_COLOR_ATTACHMENT_READ_BIT and
        // VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_READ_BIT bits are included in src and dst access mask of the color and depth
        // barriers.
        let color_pass_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color.image.get(),
            color_subres_range,
        );
        let ds_pass_barrier = make_image_memory_barrier(
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ds_image.get(),
            ds_subres_range,
        );
        for pass in 0..pass_count {
            let pass_value = pass as u32;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    pass_value.to_ne_bytes().as_ptr(),
                    uniform_bufs[pass].get_allocation().get_host_ptr(),
                    std::mem::size_of::<u32>(),
                )
            };
            flush_alloc(vk, uniform_bufs[pass].get_allocation())?;

            let uniform_buf_desc = make_descriptor_buffer_info(uniform_bufs[pass].get(), 0, uniform_buf_size);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    descriptor_sets[pass].get(),
                    Location::binding(0),
                    vk::DescriptorType::UNIFORM_BUFFER,
                    &uniform_buf_desc,
                )
                .update(vk);

            unsafe {
                vk.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_sets[pass].get()],
                    &[],
                )
            };
            begin_render_pass(
                vk,
                cmd,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, image_extent_2d.0, image_extent_2d.1),
                no_clear,
            );
            unsafe {
                vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                vk.cmd_draw(cmd, 1, 1, 0, 0);
            }
            end_render_pass(vk, cmd);

            // Don't add the barrier after the last renderpass
            if pass < pass_count - 1 {
                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[color_pass_barrier],
                    );
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                        vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[ds_pass_barrier],
                    );
                }
            }
        }
    }
    end_command_buffer(vk, cmd)?;
    submit_commands_and_wait(vk, queue, cmd)?;

    zero_buffer(vk, &color.buffer, color_buffer_size)?;
    zero_buffer(vk, &depth_buffer, depth_buffer_size)?;
    zero_buffer(vk, &stencil_buffer, stencil_buffer_size)?;

    begin_command_buffer(vk, cmd)?;
    {
        // Copy color image
        {
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color.image.get(),
                color_subres_range,
            );
            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(
                    vk::ImageAspectFlags::COLOR,
                    0,
                    0,
                    params.image.num_layers,
                ),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: params.image.size,
            };
            let post_copy_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                color.buffer.get(),
                0,
                vk::WHOLE_SIZE,
            );

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_copy_barrier],
                );
                vk.cmd_copy_image_to_buffer(
                    cmd,
                    color.image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color.buffer.get(),
                    &[region],
                );
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[post_copy_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        // Depth/Stencil image copy
        {
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                ds_image.get(),
                ds_subres_range,
            );
            let depth_copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, num_layers),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: ds_image_size,
            };
            let stencil_copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::STENCIL, 0, 0, num_layers),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: ds_image_size,
            };
            let post_copy_barriers = [
                make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    depth_buffer.get(),
                    0,
                    vk::WHOLE_SIZE,
                ),
                make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    stencil_buffer.get(),
                    0,
                    vk::WHOLE_SIZE,
                ),
            ];

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_copy_barrier],
                );
                vk.cmd_copy_image_to_buffer(
                    cmd,
                    ds_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_buffer.get(),
                    &[depth_copy_region],
                );
                vk.cmd_copy_image_to_buffer(
                    cmd,
                    ds_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    stencil_buffer.get(),
                    &[stencil_copy_region],
                );
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &post_copy_barriers,
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
    }
    end_command_buffer(vk, cmd)?;
    submit_commands_and_wait(vk, queue, cmd)?;

    invalidate_alloc(vk, color.buffer.get_allocation())?;
    invalidate_alloc(vk, depth_buffer.get_allocation())?;
    invalidate_alloc(vk, stencil_buffer.get_allocation())?;

    if !verify_results(
        &params,
        COLOR_FORMAT,
        host_slice(&color.buffer, color_buffer_size),
        false,
        false,
    )? {
        result.push_str(" Color");
    }

    if !verify_results(
        &params,
        ds_format,
        host_slice(&depth_buffer, depth_buffer_size),
        true,
        false,
    )? {
        result.push_str(" Depth");
    }

    if !verify_results(
        &params,
        stencil_buffer_format,
        host_slice(&stencil_buffer, stencil_buffer_size),
        false,
        true,
    )? {
        result.push_str(" Stencil");
    }

    if result.is_empty() {
        Ok(TestStatus::pass("OK"))
    } else {
        Ok(TestStatus::fail(format!(
            "Following parts of image are incorrect:{result}"
        )))
    }
}

/// `testSecondaryCmdBuffer` - layered rendering recorded into a secondary command buffer, blending against a storage image.
fn test_secondary_cmd_buffer(context: &Context<'_>, params: TestParams) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let alignment = alignment_size(context);

    let num_layers = framebuffer_layers(&params.image);
    let clear_color = vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    };
    let color_image_pixel_size = 4u64;
    let render_size = (params.image.size.width, params.image.size.height);

    let target = make_color_target(
        vk,
        allocator,
        &params,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        alignment,
    )?;

    let offscreen_image = ImageWithMemory::new(
        vk,
        allocator,
        make_image_create_info(
            image_create_flags(params.image.view_type),
            get_image_type(params.image.view_type),
            COLOR_FORMAT,
            params.image.size,
            params.image.num_layers,
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::ANY,
    )?;
    let offscreen_image_view = make_image_view(
        vk,
        offscreen_image.get(),
        params.image.view_type,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, params.image.num_layers),
    )?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
        .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
        .build(vk)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(vk, binaries.get("vert")?)?;
    let geometry_module = create_shader_module(vk, binaries.get("geom")?)?;
    let fragment_module = create_shader_module(vk, binaries.get("frag")?)?;

    let render_pass = make_render_pass_with_self_dependency(vk, COLOR_FORMAT)?;
    let framebuffer = make_framebuffer(
        vk,
        *render_pass,
        &[*target.attachment],
        render_size.0,
        render_size.1,
        num_layers,
    )?;
    let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(vk, &[*descriptor_set_layout])?;
    let pipeline = make_graphics_pipeline(
        vk,
        *pipeline_layout,
        *render_pass,
        *vertex_module,
        *geometry_module,
        *fragment_module,
        render_size,
        false,
    )?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let secondary_cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
    let cmd = *cmd_buffer;
    let secondary = *secondary_cmd_buffer;

    zero_buffer(vk, &target.buffer, target.buffer_size)?;

    let image_descriptor_info = [vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: *offscreen_image_view,
        image_layout: vk::ImageLayout::GENERAL,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(*descriptor_set)
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
        .image_info(&image_descriptor_info)
        .build();
    unsafe { vk.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    // Clear each layer of the storage image
    {
        let clear_cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let clear_cmd = *clear_cmd_buffer;
        begin_command_buffer(vk, clear_cmd)?;

        // VUID-VkImageMemoryBarrier-subresourceRange-01725
        let barrier_layer_count = if params.image.view_type == vk::ImageViewType::_3D {
            vk::REMAINING_ARRAY_LAYERS
        } else {
            num_layers
        };
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, barrier_layer_count);

        let pre_image_barrier = vk::ImageMemoryBarrier {
            s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::empty(),
            dst_access_mask: vk::AccessFlags::TRANSFER_WRITE,
            old_layout: vk::ImageLayout::UNDEFINED,
            new_layout: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            src_queue_family_index: queue_family_index,
            dst_queue_family_index: queue_family_index,
            image: offscreen_image.get(),
            subresource_range,
        };
        let post_image_barrier = vk::ImageMemoryBarrier {
            s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_WRITE,
            old_layout: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            new_layout: vk::ImageLayout::GENERAL,
            src_queue_family_index: queue_family_index,
            dst_queue_family_index: queue_family_index,
            image: offscreen_image.get(),
            subresource_range,
        };

        unsafe {
            vk.cmd_pipeline_barrier(
                clear_cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_image_barrier],
            );
        }

        for layer_ndx in 0..num_layers {
            let image_depth = if params.image.view_type == vk::ImageViewType::_3D {
                layer_ndx
            } else {
                0
            };
            let layer = if params.image.view_type == vk::ImageViewType::_3D {
                0
            } else {
                layer_ndx
            };
            let image_offset = vk::Offset3D {
                x: 0,
                y: 0,
                z: image_depth as i32,
            };
            let image_extent = vk::Extent3D {
                width: params.image.size.width,
                height: params.image.size.height,
                depth: 1,
            };

            let storage_image_clear_color =
                SECONDARY_CMD_BUF_CLEAR_COLORS[layer_ndx as usize % SECONDARY_CMD_BUF_CLEAR_COLORS.len()];
            let buffer_slice_size = align_size(
                u64::from(params.image.size.width) * u64::from(params.image.size.height) * color_image_pixel_size,
                alignment,
            );
            let buffer_offset = u64::from(layer_ndx) * buffer_slice_size;
            let image_subresource = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, layer, 1);
            let buffer_image_copy_region = vk::BufferImageCopy {
                buffer_offset,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource,
                image_offset,
                image_extent,
            };

            fill_buffer(
                vk,
                &target.buffer,
                buffer_offset,
                buffer_slice_size,
                COLOR_FORMAT,
                |pixel| pixel.set_pixel(storage_image_clear_color, 0, 0, 0),
            )?;
            unsafe {
                vk.cmd_copy_buffer_to_image(
                    clear_cmd,
                    target.buffer.get(),
                    offscreen_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[buffer_image_copy_region],
                )
            };
        }

        unsafe {
            vk.cmd_pipeline_barrier(
                clear_cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_image_barrier],
            );
        }

        end_command_buffer(vk, clear_cmd)?;

        submit_commands_and_wait(vk, queue, clear_cmd)?;
    }

    // Begin secondary command buffer
    begin_secondary_command_buffer(
        vk,
        secondary,
        *render_pass,
        0,
        if params.inherit_framebuffer {
            *framebuffer
        } else {
            vk::Framebuffer::null()
        },
    )?;

    unsafe {
        vk.cmd_bind_descriptor_sets(
            secondary,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[*descriptor_set],
            &[],
        )
    };

    // Clear framebuffer: upper right corner for half of the layers and bottom right for the others
    {
        let clear_attachment = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.5, 0.25, 0.0, 1.0],
                },
            },
        };

        let offset_top = vk::Offset2D {
            x: (params.image.size.width / 2) as i32,
            y: 0,
        };
        let offset_bottom = vk::Offset2D {
            x: (params.image.size.width / 2) as i32,
            y: (params.image.size.height / 2) as i32,
        };
        let extent_top = vk::Extent2D {
            width: params.image.size.width / 2,
            height: params.image.size.height / 2,
        };
        let extent_bottom = vk::Extent2D {
            width: params.image.size.width / 2,
            height: (params.image.size.height / 2).max(1),
        };
        let rect_right_top = vk::Rect2D {
            offset: offset_top,
            extent: extent_top,
        };
        let rect_right_bottom = vk::Rect2D {
            offset: offset_bottom,
            extent: extent_bottom,
        };

        let rects = [
            vk::ClearRect {
                rect: rect_right_bottom,
                base_array_layer: num_layers / 2,
                layer_count: num_layers / 2,
            },
            vk::ClearRect {
                rect: rect_right_top,
                base_array_layer: 0,
                layer_count: num_layers / 2,
            },
        ];

        let rect_count = if extent_top.height > 0 { 2 } else { 1 };
        unsafe { vk.cmd_clear_attachments(secondary, &[clear_attachment], &rects[..rect_count]) };
    }

    unsafe {
        vk.cmd_bind_pipeline(secondary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        vk.cmd_draw(secondary, 1, 1, 0, 0);
    }
    // Barrier between draws
    {
        let barrier = vk::MemoryBarrier {
            s_type: vk::StructureType::MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::SHADER_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_READ,
        };

        unsafe {
            vk.cmd_pipeline_barrier(
                secondary,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::BY_REGION,
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
    unsafe { vk.cmd_draw(secondary, 1, 1, 0, 0) };
    end_command_buffer(vk, secondary)?;

    begin_command_buffer(vk, cmd)?;
    {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, render_size.0, render_size.1))
            .clear_values(std::slice::from_ref(&clear_color));
        unsafe { vk.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::SECONDARY_COMMAND_BUFFERS) };
    }
    unsafe { vk.cmd_execute_commands(cmd, &[secondary]) };
    end_render_pass(vk, cmd);

    copy_layered_image_to_buffer(vk, cmd, target.image.get(), target.buffer.get(), &params.image);

    end_command_buffer(vk, cmd)?;
    submit_commands_and_wait(vk, queue, cmd)?;

    invalidate_alloc(vk, target.buffer.get_allocation())?;

    if !verify_results(
        &params,
        COLOR_FORMAT,
        host_slice(&target.buffer, target.buffer_size),
        false,
        false,
    )? {
        return Ok(TestStatus::fail("Rendered images are incorrect"));
    }
    Ok(TestStatus::pass("OK"))
}

struct LayeredCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for LayeredCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("geometryShader not supported".to_string()));
        }

        if self.params.image.view_type == vk::ImageViewType::_3D {
            context.require_device_functionality("VK_KHR_maintenance1")?;
        }

        if self.params.test_type == TestType::SecondaryCmdBuffer
            && context.get_device_features().fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        let num_layers = framebuffer_layers(&params.image);
        let (test_type, layers, target_layer, view) = match params.test_type {
            TestType::DefaultLayer => ("default", 0, 0, "none"),
            TestType::SingleLayer => ("single", 0, get_target_layer(&params.image), "none"),
            TestType::AllLayers => ("all", num_layers, 0, "none"),
            TestType::DifferentContent => ("different", num_layers, 0, "none"),
            TestType::LayerId => ("layer_id", num_layers, 0, "none"),
            TestType::InvocationPerLayer => ("invocation", num_layers, 0, "none"),
            TestType::MultipleLayersPerInvocation => ("multiple", num_layers, 0, "none"),
            TestType::LayeredReadback => ("readback", num_layers, 0, "none"),
            TestType::SecondaryCmdBuffer => (
                "secondary",
                num_layers,
                0,
                get_short_image_view_type_name(params.image.view_type),
            ),
        };

        ALL_LAYERED_PROGRAMS
            .iter()
            .find(|p| {
                p.test_type == test_type && p.num_layers == layers && p.target_layer == target_layer && p.view == view
            })
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LayeredInstance {
            context,
            params: self.params,
        })
    }
}

struct LayeredInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for LayeredInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.params.test_type {
            TestType::LayeredReadback => test_layered_read_back(self.context, self.params),
            TestType::SecondaryCmdBuffer => test_secondary_cmd_buffer(self.context, self.params),
            _ => test(self.context, self.params),
        }
    }
}

/// `createLayeredRenderingTests`
pub fn create_layered_rendering_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("layered");

    let test_types = [
        // Render to the default layer
        (TestType::DefaultLayer, "render_to_default_layer"),
        // Render to one layer
        (TestType::SingleLayer, "render_to_one"),
        // Render to all layers
        (TestType::AllLayers, "render_to_all"),
        // Render different data to different layers
        (TestType::DifferentContent, "render_different_content"),
        // Read gl_Layer in fragment shader
        (TestType::LayerId, "fragment_layer"),
        // Render to multiple layers with multiple invocations, one invocation per layer
        (TestType::InvocationPerLayer, "invocation_per_layer"),
        // Render to multiple layers with multiple invocations, multiple layers per invocation
        (TestType::MultipleLayersPerInvocation, "multiple_layers_per_invocation"),
        // Render to multiple layers with two passes to check LOAD_OP_LOAD capability
        (TestType::LayeredReadback, "readback"),
        // Layered rendering using secondary command buffer
        (TestType::SecondaryCmdBuffer, "secondary_cmd_buffer"),
    ];

    let image = |view_type, width, height, depth, num_layers| ImageParams {
        view_type,
        size: vk::Extent3D { width, height, depth },
        num_layers,
    };
    let image_param_groups: [(vk::ImageViewType, [ImageParams; 2]); 5] = [
        (
            vk::ImageViewType::_1D_ARRAY,
            [
                image(vk::ImageViewType::_1D_ARRAY, 64, 1, 1, 4),
                image(vk::ImageViewType::_1D_ARRAY, 12, 1, 1, 6),
            ],
        ),
        (
            vk::ImageViewType::_2D_ARRAY,
            [
                image(vk::ImageViewType::_2D_ARRAY, 64, 64, 1, 4),
                image(vk::ImageViewType::_2D_ARRAY, 12, 36, 1, 6),
            ],
        ),
        (
            vk::ImageViewType::CUBE,
            [
                image(vk::ImageViewType::CUBE, 64, 64, 1, 6),
                image(vk::ImageViewType::CUBE, 36, 36, 1, 6),
            ],
        ),
        (
            vk::ImageViewType::CUBE_ARRAY,
            [
                image(vk::ImageViewType::CUBE_ARRAY, 64, 64, 1, 2 * 6),
                image(vk::ImageViewType::CUBE_ARRAY, 36, 36, 1, 2 * 6),
            ],
        ),
        (
            vk::ImageViewType::_3D,
            [
                image(vk::ImageViewType::_3D, 64, 64, 8, 1),
                image(vk::ImageViewType::_3D, 12, 36, 6, 1),
            ],
        ),
    ];

    for (view_type, image_params) in image_param_groups {
        let mut view_type_main_group = TestCaseGroup::new(get_short_image_view_type_name(view_type));

        for image_param in image_params {
            let depth_or_layers = if image_param.view_type == vk::ImageViewType::_3D {
                image_param.size.depth
            } else {
                image_param.num_layers
            };
            let view_type_group_name = format!(
                "{}_{}_{}",
                image_param.size.width, image_param.size.height, depth_or_layers
            );
            let mut view_type_group = TestCaseGroup::new(view_type_group_name);

            for (test_type, name) in test_types {
                let mut params = TestParams {
                    test_type,
                    image: image_param,
                    inherit_framebuffer: false,
                };

                if test_type == TestType::SecondaryCmdBuffer {
                    view_type_group.add_child(Box::new(LayeredCase {
                        name: "secondary_cmd_buffer",
                        params,
                    }) as Box<dyn TestCase>);
                    params.inherit_framebuffer = true;
                    view_type_group.add_child(Box::new(LayeredCase {
                        name: "secondary_cmd_buffer_inherit_framebuffer",
                        params,
                    }) as Box<dyn TestCase>);
                } else {
                    view_type_group.add_child(Box::new(LayeredCase { name, params }) as Box<dyn TestCase>);
                }
            }
            view_type_main_group.add_child(view_type_group);
        }
        group.add_child(view_type_main_group);
    }

    group
}
