// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleResolveMaint10Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic pipeline path is ported: the render pass (and the CMD method's
// render pass) is created with `vkCreateRenderPass2` and begun directly instead of through `RenderPassWrapper`, and the dynamic render
// method calls `vkCmdBeginRendering` itself, so the shader object construction types are not repeated.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, DeviceV1_3, InstanceV1_1};

use crate::generated::shaders::pipeline_m10_resolve::*;
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, get_texture_format_bit_depth, get_texture_format_mantissa_bit_depth, linear_to_srgb,
};
use crate::tcu::random::Random;
use crate::tcu::texture::{TextureChannelClass, TextureFormat};
use crate::tcu::{TestError, TestOutcome, TestStatus, UVec4, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, get_depth_copy_format, get_stencil_copy_format, make_buffer_image_copy, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::image_util::{
    format_case_name, get_image_aspect_flags, is_depth_stencil_format, is_int_format, is_uint_format,
};
use crate::vkt::tests::pipeline::shader_object_draw::make_shader_objects;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum ResolveMethod {
    Cmd,
    RenderPass,
    DynamicRender,
}

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum ResolveArea {
    Full,
    FullMultilayer,
    FullMultilayerRem,
    FullMultilayerRemSingle,
    Full3d,
    Region,
    RegionsMultilayer,
    RegionsMultilayerRem,
}

fn is_multi_slice(area: ResolveArea) -> bool {
    area != ResolveArea::Full && area != ResolveArea::Region
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SrgbFlags {
    None,
    Skip,
    Enable,
}

#[derive(Clone, Copy)]
struct TestParams {
    resolve_method: ResolveMethod,
    image_format: vk::Format,
    resolve_aspects: vk::ImageAspectFlags,
    resolve_mode: vk::ResolveModeFlags,
    resolve_area: ResolveArea,
    srgb_flags: SrgbFlags,
}

const WIDTH: u32 = 16;
const HEIGHT: u32 = 16;
const SAMPLE_COUNT: u32 = 4;

impl TestParams {
    fn get_random_seed(&self) -> u32 {
        ((self.image_format.as_raw() as u32) << 24)
            | ((self.resolve_method as u32) << 22)
            | (self.resolve_aspects.bits() << 16)
            | (self.resolve_mode.bits() << 12)
            | ((self.srgb_flags as u32) << 10)
    }

    fn get_extent(&self) -> [u32; 3] {
        [WIDTH, HEIGHT, if is_multi_slice(self.resolve_area) { 2 } else { 1 }]
    }

    fn is_3d_single_sample(&self) -> bool {
        self.resolve_area == ResolveArea::Full3d
    }

    fn get_multi_sample_layers(&self) -> u32 {
        self.get_extent()[2]
    }

    fn get_single_sample_layers(&self) -> u32 {
        if self.is_3d_single_sample() {
            1
        } else {
            self.get_extent()[2]
        }
    }

    fn is_depth_stencil(&self) -> bool {
        self.resolve_aspects
            .intersects(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL)
    }

    fn glsl_frag_out_kind(&self) -> OutKind {
        if self.is_depth_stencil() {
            OutKind::None
        } else if is_uint_format(self.image_format) {
            OutKind::Uint
        } else if is_int_format(self.image_format) {
            OutKind::Int
        } else {
            OutKind::Float
        }
    }

    fn get_image_usage(&self) -> vk::ImageUsageFlags {
        let mut usage = if self.is_depth_stencil() {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        } else {
            vk::ImageUsageFlags::COLOR_ATTACHMENT
        };
        if self.resolve_method == ResolveMethod::Cmd {
            usage |= vk::ImageUsageFlags::TRANSFER_SRC;
        }
        usage
    }

    fn get_multi_sample_create_info(&self) -> vk::ImageCreateInfo {
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(self.image_format)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(self.get_multi_sample_layers())
            .samples(vk::SampleCountFlags::_4)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(self.get_image_usage())
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build()
    }

    fn get_single_sample_create_info(&self) -> vk::ImageCreateInfo {
        let mut info = self.get_multi_sample_create_info();
        info.samples = vk::SampleCountFlags::_1;
        if self.is_3d_single_sample() {
            info.image_type = vk::ImageType::_3D;
            info.extent = vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: self.get_extent()[2],
            };
        }
        info.array_layers = self.get_single_sample_layers();
        info.usage |= vk::ImageUsageFlags::TRANSFER_SRC;
        if self.resolve_method == ResolveMethod::Cmd {
            info.usage |= vk::ImageUsageFlags::TRANSFER_DST;
        }
        info
    }

    fn get_multi_sample_view_type(&self) -> vk::ImageViewType {
        if self.get_multi_sample_layers() > 1 {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        }
    }

    fn get_single_sample_view_type(&self) -> vk::ImageViewType {
        if self.is_3d_single_sample() {
            vk::ImageViewType::_3D
        } else if self.get_single_sample_layers() > 1 {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum OutKind {
    None,
    Uint,
    Int,
    Float,
}

fn shared_program(multi_layer: bool, out: OutKind, depth: bool, stencil: bool) -> &'static SharedProgram {
    match (multi_layer, out, depth, stencil) {
        (false, OutKind::Uint, _, _) => &M10_ML0_UVEC4_D0_S0,
        (false, OutKind::Int, _, _) => &M10_ML0_IVEC4_D0_S0,
        (false, OutKind::Float, _, _) => &M10_ML0_VEC4_D0_S0,
        (false, OutKind::None, true, false) => &M10_ML0_NONE_D1_S0,
        (false, OutKind::None, false, true) => &M10_ML0_NONE_D0_S1,
        (false, OutKind::None, _, _) => &M10_ML0_NONE_D1_S1,
        (true, OutKind::Uint, _, _) => &M10_ML1_UVEC4_D0_S0,
        (true, OutKind::Int, _, _) => &M10_ML1_IVEC4_D0_S0,
        (true, OutKind::Float, _, _) => &M10_ML1_VEC4_D0_S0,
        (true, OutKind::None, true, false) => &M10_ML1_NONE_D1_S0,
        (true, OutKind::None, false, true) => &M10_ML1_NONE_D0_S1,
        (true, OutKind::None, _, _) => &M10_ML1_NONE_D1_S1,
    }
}

struct Maint10ResolveCase {
    name: String,
    params: TestParams,
}

fn vulkan12_features(context: &Context<'_>) -> vk::PhysicalDeviceVulkan12Features {
    let mut features = vk::PhysicalDeviceVulkan12Features::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

fn maintenance10_properties(context: &Context<'_>) -> vk::PhysicalDeviceMaintenance10PropertiesKHR {
    let mut properties = vk::PhysicalDeviceMaintenance10PropertiesKHR::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties
}

impl TestCase for Maint10ResolveCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `Maint10ResolveCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let p = &self.params;
        context.require_device_functionality("VK_KHR_maintenance10")?;

        match p.resolve_method {
            ResolveMethod::Cmd => context.require_device_functionality("VK_KHR_copy_commands2")?,
            ResolveMethod::DynamicRender => context.require_device_functionality("VK_KHR_dynamic_rendering")?,
            ResolveMethod::RenderPass => context.require_device_functionality("VK_KHR_create_renderpass2")?,
        }

        if p.get_multi_sample_layers() > 1 {
            if context.api_version() < (1, 2, 0) {
                return Err(TestError::NotSupported("Vulkan 1.2 required".to_string()));
            }
            if vulkan12_features(context).shader_output_layer == vk::FALSE {
                return Err(TestError::NotSupported("shaderOutputLayer not supported".to_string()));
            }
        }

        let resolve_depth = p.resolve_aspects.contains(vk::ImageAspectFlags::DEPTH);
        let resolve_stencil = p.resolve_aspects.contains(vk::ImageAspectFlags::STENCIL);
        let tcu_format = map_vk_format(p.image_format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", p.image_format)))?;

        if resolve_depth || resolve_stencil {
            context.require_device_functionality("VK_KHR_depth_stencil_resolve")?;
            let mut ds_resolve_properties = vk::PhysicalDeviceDepthStencilResolveProperties::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut ds_resolve_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }

            if resolve_depth
                && !ds_resolve_properties
                    .supported_depth_resolve_modes
                    .contains(p.resolve_mode)
            {
                return Err(TestError::NotSupported(
                    "Required depth resolve mode not supported".to_string(),
                ));
            }

            if resolve_stencil {
                if !ds_resolve_properties
                    .supported_stencil_resolve_modes
                    .contains(p.resolve_mode)
                {
                    return Err(TestError::NotSupported(
                        "Required stencil resolve mode not supported".to_string(),
                    ));
                }
                context.require_device_functionality("VK_EXT_shader_stencil_export")?;
            }

            if ((tcu_format.order.has_depth() && !resolve_depth)
                || (tcu_format.order.has_stencil() && !resolve_stencil))
                && ds_resolve_properties.independent_resolve_none == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "independentResolveNone not supported".to_string(),
                ));
            }
        }

        if tcu_format.order.is_srgb()
            && p.srgb_flags != SrgbFlags::None
            && maintenance10_properties(context).resolve_srgb_format_supports_transfer_function_control == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "resolveSrgbFormatSupportsTransferFunctionControl not supported".to_string(),
            ));
        }

        for image_info in [p.get_multi_sample_create_info(), p.get_single_sample_create_info()] {
            let result = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    image_info.format,
                    image_info.image_type,
                    image_info.tiling,
                    image_info.usage,
                    image_info.flags,
                )
            };
            if matches!(result, Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED)) {
                return Err(TestError::NotSupported("Format not supported".to_string()));
            }
            let format_properties = result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
            if !format_properties.sample_counts.contains(image_info.samples) {
                return Err(TestError::NotSupported(
                    "Required sample count not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let p = &self.params;
        shared_program(
            p.get_multi_sample_layers() > 1,
            p.glsl_frag_out_kind(),
            p.resolve_aspects.contains(vk::ImageAspectFlags::DEPTH),
            p.resolve_aspects.contains(vk::ImageAspectFlags::STENCIL),
        )
        .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Maint10ResolveInstance {
            context,
            params: self.params,
        })
    }
}

#[derive(Clone, Copy)]
struct ResolveRegion {
    src_offset: vk::Offset2D,
    dst_offset: vk::Offset2D,
    extent: vk::Extent2D,
    src_slice: u32,
    dst_slice: u32,
    slice_count: u32,
}

fn offset_2d(x: i32, y: i32) -> vk::Offset2D {
    vk::Offset2D { x, y }
}

fn extent_2d(width: u32, height: u32) -> vk::Extent2D {
    vk::Extent2D { width, height }
}

/// `getSrcRegionCoords`
fn get_src_region_coords(coords: [u32; 3], region: &ResolveRegion) -> Option<[u32; 3]> {
    if coords[2] < region.dst_slice
        || (region.slice_count != vk::REMAINING_ARRAY_LAYERS && coords[2] >= region.dst_slice + region.slice_count)
    {
        return None;
    }

    let offset_x = region.dst_offset.x as u32;
    let offset_y = region.dst_offset.y as u32;

    if coords[0] < offset_x || coords[0] >= offset_x + region.extent.width {
        return None;
    }
    if coords[1] < offset_y || coords[1] >= offset_y + region.extent.height {
        return None;
    }

    let diff_x = region.src_offset.x - region.dst_offset.x;
    let diff_y = region.src_offset.y - region.dst_offset.y;
    let new_x = coords[0] as i32 + diff_x;
    let new_y = coords[1] as i32 + diff_y;
    let new_slice = coords[2] - region.dst_slice + region.src_slice;
    Some([new_x as u32, new_y as u32, new_slice])
}

/// `getFirstSrcRegionCoords`
fn get_first_src_region_coords(x: u32, y: u32, z: u32, regions: &[ResolveRegion]) -> Option<[u32; 3]> {
    regions
        .iter()
        .find_map(|region| get_src_region_coords([x, y, z], region))
}

/// `bitWidthToThreshold`
fn bit_width_to_threshold(bit_width: [i32; 4]) -> [f32; 4] {
    let mut threshold = [0.0f32; 4];
    for (value, width) in threshold.iter_mut().zip(bit_width) {
        if width > 0 {
            *value = 1.0 / ((1u64 << width) as f32 - 1.0);
        }
        *value *= 1.25;
    }
    threshold
}

/// `getColorFormatThreshold`
fn get_color_format_threshold(format: TextureFormat) -> [f32; 4] {
    match format.channel_class() {
        TextureChannelClass::UnsignedFixedPoint => {
            let mut threshold = bit_width_to_threshold(get_texture_format_bit_depth(format));
            if format.order.is_srgb() {
                for value in &mut threshold {
                    *value *= 2.0;
                }
            }
            threshold
        }
        TextureChannelClass::FloatingPoint => bit_width_to_threshold(get_texture_format_mantissa_bit_depth(format)),
        _ => unreachable!("only UNORM and SFLOAT color formats are compared with a threshold"),
    }
}

/// The frag shader's `PixelData`.
#[repr(C)]
#[derive(Clone, Copy, Default)]
struct PixelData {
    color: [u32; 4],
    depth_stencil: [f32; 4],
}

struct Maint10ResolveInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

fn pipeline_image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        )
    };
}

impl Maint10ResolveInstance<'_> {
    fn resolve_regions(&self) -> Vec<ResolveRegion> {
        let p = &self.params;
        let full_extent = p.get_extent();
        let mut regions = Vec::new();
        if matches!(
            p.resolve_area,
            ResolveArea::Full
                | ResolveArea::FullMultilayer
                | ResolveArea::FullMultilayerRem
                | ResolveArea::FullMultilayerRemSingle
                | ResolveArea::Full3d
        ) {
            let src_slice = u32::from(matches!(
                p.resolve_area,
                ResolveArea::FullMultilayerRemSingle | ResolveArea::Full3d
            ));
            let dst_slice = src_slice;
            let slice_count = match p.resolve_area {
                ResolveArea::FullMultilayerRem | ResolveArea::FullMultilayerRemSingle => vk::REMAINING_ARRAY_LAYERS,
                ResolveArea::Full3d => 1,
                _ => full_extent[2],
            };
            let common_offset = offset_2d(0, 0);
            regions.push(ResolveRegion {
                src_offset: common_offset,
                dst_offset: common_offset,
                extent: extent_2d(WIDTH, HEIGHT),
                src_slice,
                dst_slice,
                slice_count,
            });
        } else {
            let qx = (WIDTH / 2) as i32;
            let qy = (HEIGHT / 2) as i32;
            let quadrant = extent_2d(WIDTH / 2, HEIGHT / 2);
            let region = |src: vk::Offset2D, dst: vk::Offset2D, src_slice, dst_slice, slice_count| ResolveRegion {
                src_offset: src,
                dst_offset: dst,
                extent: quadrant,
                src_slice,
                dst_slice,
                slice_count,
            };
            match p.resolve_area {
                ResolveArea::Region => {
                    regions.push(region(offset_2d(0, 0), offset_2d(qx, qy), 0, 0, 1));
                }
                ResolveArea::RegionsMultilayer => {
                    regions.push(region(offset_2d(0, 0), offset_2d(qx, qy), 0, 1, 1));
                    regions.push(region(offset_2d(qx, 0), offset_2d(0, qy), 1, 0, 1));
                    regions.push(region(offset_2d(0, qy), offset_2d(qx, 0), 1, 0, 1));
                }
                ResolveArea::RegionsMultilayerRem => {
                    regions.push(region(
                        offset_2d(0, 0),
                        offset_2d(0, qy),
                        1,
                        1,
                        vk::REMAINING_ARRAY_LAYERS,
                    ));
                    regions.push(region(
                        offset_2d(0, qy),
                        offset_2d(0, 0),
                        1,
                        1,
                        vk::REMAINING_ARRAY_LAYERS,
                    ));
                    regions.push(region(
                        offset_2d(qx, 0),
                        offset_2d(qx, qy),
                        0,
                        0,
                        vk::REMAINING_ARRAY_LAYERS,
                    ));
                }
                _ => unreachable!("sub-area resolves only apply to the resolve command"),
            }
        }
        regions
    }

    fn fill_pixel_data(
        &self,
        tcu_format: TextureFormat,
        regions: &[ResolveRegion],
    ) -> Result<Vec<PixelData>, TestError> {
        let p = &self.params;
        let ms_layers = p.get_multi_sample_layers();
        let slice_pixel_count = WIDTH * HEIGHT;
        let total_samples = slice_pixel_count * SAMPLE_COUNT * ms_layers;
        let mut pixel_data = vec![PixelData::default(); total_samples as usize];
        let mut rnd = Random::new(p.get_random_seed());

        let is_int = is_int_format(p.image_format);
        let is_uint = is_uint_format(p.image_format);
        let resolve_depth = p.resolve_aspects.contains(vk::ImageAspectFlags::DEPTH);
        let resolve_stencil = p.resolve_aspects.contains(vk::ImageAspectFlags::STENCIL);
        let resolve_color = p.resolve_aspects.contains(vk::ImageAspectFlags::COLOR);
        let bit_depth = get_texture_format_bit_depth(tcu_format);

        for region in regions {
            let slice_begin = region.src_slice;
            let slice_end = region.src_slice
                + if region.slice_count == vk::REMAINING_ARRAY_LAYERS {
                    ms_layers - slice_begin
                } else {
                    region.slice_count
                };

            for z in slice_begin..slice_end {
                for y in 0..region.extent.height {
                    let y_coord = y + region.src_offset.y as u32;
                    for x in 0..region.extent.width {
                        let x_coord = x + region.src_offset.x as u32;
                        for s in 0..SAMPLE_COUNT {
                            let pixel_idx = (y_coord * WIDTH + x_coord) + (slice_pixel_count * z);
                            let sample_idx = pixel_idx * SAMPLE_COUNT + s;
                            let data = &mut pixel_data[sample_idx as usize];

                            if resolve_depth {
                                data.depth_stencil[0] = rnd.get_float();
                            }
                            if resolve_stencil {
                                data.depth_stencil[1] = rnd.get_int(0, 255) as f32;
                            }
                            if resolve_color {
                                for i in 0..4 {
                                    if bit_depth[i] == 0 {
                                        continue;
                                    }
                                    if is_int {
                                        data.color[i] = match bit_depth[i] {
                                            8 => rnd.get_int(-127, 127) as u32,
                                            16 => rnd.get_int(-32767, 32767) as u32,
                                            32 => rnd.get_int(-2147483647, 2147483647) as u32,
                                            width => {
                                                return Err(TestError::NotPorted(format!(
                                                    "integer channel of {width} bits"
                                                )));
                                            }
                                        };
                                    } else if is_uint {
                                        data.color[i] = match bit_depth[i] {
                                            8 => u32::from(rnd.get_uint8()),
                                            16 => u32::from(rnd.get_uint16()),
                                            32 => rnd.get_uint32(),
                                            width => {
                                                return Err(TestError::NotPorted(format!(
                                                    "integer channel of {width} bits"
                                                )));
                                            }
                                        };
                                    } else {
                                        data.color[i] = rnd.get_float().to_bits();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        Ok(pixel_data)
    }

    fn make_render_pass<'d>(
        &self,
        device: &'d Device,
        ss_in_rp: bool,
        ss_final_rp_layout: vk::ImageLayout,
        ms_aspect: vk::ImageAspectFlags,
    ) -> Result<Unique<'d, vk::RenderPass>, TestError> {
        let p = &self.params;
        let is_ds = is_depth_stencil_format(p.image_format);
        let ms_store_op = if ss_in_rp {
            vk::AttachmentStoreOp::DONT_CARE
        } else {
            vk::AttachmentStoreOp::STORE
        };

        let mut attachment_descriptions = vec![
            vk::AttachmentDescription2::builder()
                .format(p.image_format)
                .samples(vk::SampleCountFlags::_4)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(ms_store_op)
                .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                .stencil_store_op(ms_store_op)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(ss_final_rp_layout)
                .build(),
        ];

        if ss_in_rp {
            let mut flags = vk::AttachmentDescriptionFlags::empty();
            match p.srgb_flags {
                SrgbFlags::Enable => flags |= vk::AttachmentDescriptionFlags::RESOLVE_ENABLE_TRANSFER_FUNCTION_KHR,
                SrgbFlags::Skip => flags |= vk::AttachmentDescriptionFlags::RESOLVE_SKIP_TRANSFER_FUNCTION_KHR,
                SrgbFlags::None => {}
            }
            attachment_descriptions.push(
                vk::AttachmentDescription2::builder()
                    .flags(flags)
                    .format(p.image_format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::STORE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(ss_final_rp_layout)
                    .build(),
            );
        }

        let ms_att_ref = vk::AttachmentReference2::builder()
            .attachment(0)
            .layout(ss_final_rp_layout)
            .aspect_mask(ms_aspect)
            .build();
        let ss_att_ref = vk::AttachmentReference2::builder()
            .attachment(1)
            .layout(ss_final_rp_layout)
            .aspect_mask(ms_aspect)
            .build();

        let resolve_depth = p.resolve_aspects.contains(vk::ImageAspectFlags::DEPTH);
        let resolve_stencil = p.resolve_aspects.contains(vk::ImageAspectFlags::STENCIL);
        let depth_resolve_mode = if resolve_depth {
            p.resolve_mode
        } else {
            vk::ResolveModeFlags::NONE
        };
        let stencil_resolve_mode = if resolve_stencil {
            p.resolve_mode
        } else {
            vk::ResolveModeFlags::NONE
        };

        let mut ds_resolve = vk::SubpassDescriptionDepthStencilResolve::builder()
            .depth_resolve_mode(depth_resolve_mode)
            .stencil_resolve_mode(stencil_resolve_mode)
            .depth_stencil_resolve_attachment(&ss_att_ref);

        let color_att_refs = [ms_att_ref];
        let resolve_att_refs = [ss_att_ref];
        let mut subpass = vk::SubpassDescription2::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
        if is_ds {
            subpass = subpass.depth_stencil_attachment(&ms_att_ref);
            if ss_in_rp {
                subpass = subpass.push_next(&mut ds_resolve);
            }
        } else {
            subpass = subpass.color_attachments(&color_att_refs);
            if ss_in_rp {
                subpass = subpass.resolve_attachments(&resolve_att_refs);
            }
        }
        let subpasses = [subpass.build()];

        let info = vk::RenderPassCreateInfo2::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass = unsafe { device.create_render_pass2(&info, None) }.vk_check("vkCreateRenderPass2")?;
        Ok(Unique::new(device, render_pass))
    }
}

impl TestInstance for Maint10ResolveInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let tcu_format = map_vk_format(p.image_format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", p.image_format)))?;
        let ms_layer_count = p.get_multi_sample_layers();
        let ss_layer_count = p.get_single_sample_layers();
        let full_extent = p.get_extent();
        let is_srgb = tcu_format.order.is_srgb();
        let is_3d_ss = p.is_3d_single_sample();
        let is_ds = is_depth_stencil_format(p.image_format);
        let is_int = is_int_format(p.image_format);
        let is_uint = is_uint_format(p.image_format);
        let is_float = !(is_int || is_uint);
        let resolve_depth = p.resolve_aspects.contains(vk::ImageAspectFlags::DEPTH);
        let resolve_stencil = p.resolve_aspects.contains(vk::ImageAspectFlags::STENCIL);
        let resolve_color = p.resolve_aspects.contains(vk::ImageAspectFlags::COLOR);

        let ms_create_info = p.get_multi_sample_create_info();
        let ms_image = ImageWithMemory::new(device, allocator, ms_create_info, MemoryRequirement::ANY)?;
        let ms_srr =
            make_image_subresource_range(get_image_aspect_flags(tcu_format), 0, 1, 0, ms_create_info.array_layers);
        let ms_image_view = make_image_view(
            device,
            ms_image.get(),
            p.get_multi_sample_view_type(),
            p.image_format,
            ms_srr,
        )?;

        let ss_create_info = p.get_single_sample_create_info();
        let ss_image = ImageWithMemory::new(device, allocator, ss_create_info, MemoryRequirement::ANY)?;
        let ss_srr =
            make_image_subresource_range(get_image_aspect_flags(tcu_format), 0, 1, 0, ss_create_info.array_layers);
        let ss_image_view = make_image_view(
            device,
            ss_image.get(),
            p.get_single_sample_view_type(),
            p.image_format,
            ss_srr,
        )?;

        let resolve_regions = self.resolve_regions();
        let pixel_data_vec = self.fill_pixel_data(tcu_format, &resolve_regions)?;

        let pixels_buffer_size = std::mem::size_of_val(pixel_data_vec.as_slice()) as vk::DeviceSize;
        let pixels_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(pixels_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = pixels_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    pixel_data_vec.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    pixels_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let slice_pixel_count = WIDTH * HEIGHT;
        let make_verif_buffer = |pixel_bytes: u32| {
            let layer_bytes = slice_pixel_count * pixel_bytes;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    vk::DeviceSize::from(layer_bytes * ms_layer_count),
                    vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            Ok::<_, TestError>((buffer, layer_bytes))
        };

        let not_ported = |what: &str| TestError::NotPorted(format!("{what} of {:?}", p.image_format));
        let pixel_size = |format: TextureFormat| {
            format
                .pixel_size()
                .ok_or_else(|| TestError::NotPorted(format!("pixel size of {format:?}")))
        };

        let color_verif = if resolve_color {
            Some(make_verif_buffer(pixel_size(tcu_format)?)?)
        } else {
            None
        };
        let depth_copy_format = if resolve_depth {
            Some(get_depth_copy_format(p.image_format).ok_or_else(|| not_ported("depth copy format"))?)
        } else {
            None
        };
        let depth_verif = match depth_copy_format {
            Some(format) => Some(make_verif_buffer(pixel_size(format)?)?),
            None => None,
        };
        let stencil_copy_format = if resolve_stencil {
            Some(get_stencil_copy_format(p.image_format).ok_or_else(|| not_ported("stencil copy format"))?)
        } else {
            None
        };
        let stencil_verif = match stencil_copy_format {
            Some(format) => Some(make_verif_buffer(pixel_size(format)?)?),
            None => None,
        };

        let data_stages = vk::ShaderStageFlags::FRAGMENT;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let bindings = [vk::DescriptorSetLayoutBinding::builder()
            .binding(0)
            .descriptor_type(desc_type)
            .descriptor_count(1)
            .stage_flags(data_stages)
            .build()];
        let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );

        let pc_range = vk::PushConstantRange {
            stage_flags: data_stages,
            offset: 0,
            size: 8,
        };
        let mut pc_data = Vec::with_capacity(8);
        pc_data.extend_from_slice(&(full_extent[0] as f32).to_ne_bytes());
        pc_data.extend_from_slice(&(full_extent[1] as f32).to_ne_bytes());
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let pool_sizes = [vk::DescriptorPoolSize {
            type_: desc_type,
            descriptor_count: 1,
        }];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .max_sets(1)
            .pool_sizes(&pool_sizes);
        let desc_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let layouts = [*set_layout];
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*desc_pool)
            .set_layouts(&layouts);
        let desc_set =
            unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?[0];
        let buffer_infos = [vk::DescriptorBufferInfo {
            buffer: pixels_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(desc_set)
            .dst_binding(0)
            .descriptor_type(desc_type)
            .buffer_info(&buffer_infos)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[*set_layout], &[pc_range])?;
        let ss_in_rp = p.resolve_method != ResolveMethod::Cmd;
        let is_dynamic_rendering = p.resolve_method == ResolveMethod::DynamicRender || shader_objects.is_some();
        let ss_final_rp_layout = if is_ds {
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };

        let depth_resolve_mode = if resolve_depth {
            p.resolve_mode
        } else {
            vk::ResolveModeFlags::NONE
        };
        let stencil_resolve_mode = if resolve_stencil {
            p.resolve_mode
        } else {
            vk::ResolveModeFlags::NONE
        };

        let render_pass = if is_dynamic_rendering {
            None
        } else {
            Some(self.make_render_pass(device, ss_in_rp, ss_final_rp_layout, ms_srr.aspect_mask)?)
        };
        let framebuffer = match &render_pass {
            Some(render_pass) => {
                let mut views = vec![*ms_image_view];
                if ss_in_rp {
                    views.push(*ss_image_view);
                }
                Some(make_framebuffer(
                    device,
                    **render_pass,
                    &views,
                    WIDTH,
                    HEIGHT,
                    ms_create_info.array_layers,
                )?)
            }
            None => None,
        };

        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::REPLACE)
            .pass_op(vk::StencilOp::REPLACE)
            .depth_fail_op(vk::StencilOp::REPLACE)
            .compare_op(vk::CompareOp::ALWAYS)
            .compare_mask(0xff)
            .write_mask(0xff)
            .reference(0)
            .build();
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(WIDTH, HEIGHT);
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(resolve_depth)
            .depth_write_enable(resolve_depth)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(resolve_stencil)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();
        state.samples = vk::SampleCountFlags::_4;
        state.sample_shading = true;
        state.min_sample_shading = 1.0;
        state.color_attachment_count = u32::from(!is_ds);
        if is_dynamic_rendering {
            state.rendering_format = Some(if is_ds { vk::Format::UNDEFINED } else { p.image_format });
            if resolve_depth {
                state.depth_rendering_format = p.image_format;
            }
            if resolve_stencil {
                state.stencil_rendering_format = p.image_format;
            }
        }
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                render_pass
                    .as_ref()
                    .map_or(vk::RenderPass::null(), |render_pass| **render_pass),
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let render_area = rect_2d(WIDTH, HEIGHT);
        let mut ss_layout = vk::ImageLayout::UNDEFINED;

        begin_command_buffer(device, cmd)?;

        if let (Some(render_pass), Some(framebuffer)) = (&render_pass, &framebuffer) {
            let clear_values = [clear_value_color([0.0; 4]), clear_value_color([0.0; 4])];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**render_pass)
                .framebuffer(**framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
        } else {
            let attachment_stage = if is_ds {
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
            } else {
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
            };
            let attachment_access = if is_ds {
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
            } else {
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            };
            let attachment_images = [(ms_image.get(), ms_srr), (ss_image.get(), ss_srr)];
            for (image, srr) in attachment_images.into_iter().take(if ss_in_rp { 2 } else { 1 }) {
                let barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    attachment_access,
                    vk::ImageLayout::UNDEFINED,
                    ss_final_rp_layout,
                    image,
                    srr,
                );
                pipeline_image_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    attachment_stage,
                    barrier,
                );
            }

            let mut flags_info = vk::RenderingAttachmentFlagsInfoKHR::default();
            match p.srgb_flags {
                SrgbFlags::Enable => {
                    flags_info.flags = vk::RenderingAttachmentFlagsKHR::RESOLVE_ENABLE_TRANSFER_FUNCTION
                }
                SrgbFlags::Skip => flags_info.flags = vk::RenderingAttachmentFlagsKHR::RESOLVE_SKIP_TRANSFER_FUNCTION,
                SrgbFlags::None => {}
            }
            let attachment = |resolve_mode: vk::ResolveModeFlags| vk::RenderingAttachmentInfo {
                image_view: *ms_image_view,
                image_layout: ss_final_rp_layout,
                resolve_mode: if ss_in_rp {
                    resolve_mode
                } else {
                    vk::ResolveModeFlags::NONE
                },
                resolve_image_view: if ss_in_rp {
                    *ss_image_view
                } else {
                    vk::ImageView::null()
                },
                resolve_image_layout: if ss_in_rp {
                    ss_final_rp_layout
                } else {
                    vk::ImageLayout::UNDEFINED
                },
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: if ss_in_rp {
                    vk::AttachmentStoreOp::DONT_CARE
                } else {
                    vk::AttachmentStoreOp::STORE
                },
                clear_value: clear_value_color([0.0; 4]),
                ..Default::default()
            };

            let mut color_attachments = Vec::new();
            let depth_attachment = attachment(depth_resolve_mode);
            let stencil_attachment = attachment(stencil_resolve_mode);
            if !is_ds {
                let mut color_attachment = attachment(p.resolve_mode);
                color_attachment.next = (&raw const flags_info).cast();
                color_attachments.push(color_attachment);
            }
            let has_depth = tcu_format.order.has_depth();
            let has_stencil = tcu_format.order.has_stencil();
            let mut rendering_info = vk::RenderingInfo::builder()
                .render_area(render_area)
                .layer_count(ms_layer_count)
                .color_attachments(&color_attachments);
            if has_depth {
                rendering_info = rendering_info.depth_attachment(&depth_attachment);
            }
            if has_stencil {
                rendering_info = rendering_info.stencil_attachment(&stencil_attachment);
            }
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
            if let Some(shader_objects) = &shader_objects {
                shader_objects.bind(cmd, &state);
            }
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[desc_set],
                &[] as &[u32],
            );
            device.cmd_push_constants(cmd, *pipeline_layout, data_stages, 0, &pc_data);
            if let Some(pipeline) = &pipeline {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            }
            device.cmd_draw(cmd, 3, ms_create_info.array_layers, 0, 0);
            if is_dynamic_rendering {
                device.cmd_end_rendering(cmd);
            } else {
                device.cmd_end_render_pass(cmd);
            }
        }

        if p.resolve_method == ResolveMethod::Cmd {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                ss_layout,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                ss_image.get(),
                ss_srr,
            );
            pipeline_image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                barrier,
            );
            ss_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;

            if is_ds {
                let clear_value = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
                unsafe {
                    device.cmd_clear_depth_stencil_image(cmd, ss_image.get(), ss_layout, &clear_value, &[ss_srr])
                };
            } else {
                let clear_value = vk::ClearColorValue { float32: [0.0; 4] };
                unsafe { device.cmd_clear_color_image(cmd, ss_image.get(), ss_layout, &clear_value, &[ss_srr]) };
            }

            let barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                ss_layout,
                ss_layout,
                ss_image.get(),
                ss_srr,
            );
            pipeline_image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                barrier,
            );

            let (src_access, src_stages) = if is_ds {
                (
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                )
            } else {
                (
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                )
            };
            let barrier = make_image_memory_barrier(
                src_access,
                vk::AccessFlags::TRANSFER_READ,
                ss_final_rp_layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                ms_image.get(),
                ms_srr,
            );
            pipeline_image_barrier(device, cmd, src_stages, vk::PipelineStageFlags::TRANSFER, barrier);

            let image_resolve_regions: Vec<vk::ImageResolve2> = resolve_regions
                .iter()
                .map(|region| {
                    let ss_base_layer = if is_3d_ss { 0 } else { region.dst_slice };
                    let ss_layer_count = if is_3d_ss { 1 } else { region.slice_count };
                    let ss_z_offset = if is_3d_ss { region.dst_slice as i32 } else { 0 };
                    vk::ImageResolve2::builder()
                        .src_subresource(make_image_subresource_layers(
                            p.resolve_aspects,
                            0,
                            region.src_slice,
                            region.slice_count,
                        ))
                        .src_offset(vk::Offset3D {
                            x: region.src_offset.x,
                            y: region.src_offset.y,
                            z: 0,
                        })
                        .dst_subresource(make_image_subresource_layers(
                            p.resolve_aspects,
                            0,
                            ss_base_layer,
                            ss_layer_count,
                        ))
                        .dst_offset(vk::Offset3D {
                            x: region.dst_offset.x,
                            y: region.dst_offset.y,
                            z: ss_z_offset,
                        })
                        .extent(vk::Extent3D {
                            width: region.extent.width,
                            height: region.extent.height,
                            depth: 1,
                        })
                        .build()
                })
                .collect();

            let mut resolve_mode_flags = vk::ResolveImageFlagsKHR::empty();
            match p.srgb_flags {
                SrgbFlags::Enable => resolve_mode_flags |= vk::ResolveImageFlagsKHR::ENABLE_TRANSFER_FUNCTION,
                SrgbFlags::Skip => resolve_mode_flags |= vk::ResolveImageFlagsKHR::SKIP_TRANSFER_FUNCTION,
                SrgbFlags::None => {}
            }
            let resolve_mode_info = vk::ResolveImageModeInfoKHR {
                flags: resolve_mode_flags,
                resolve_mode: if is_ds { depth_resolve_mode } else { p.resolve_mode },
                stencil_resolve_mode: if is_ds {
                    stencil_resolve_mode
                } else {
                    vk::ResolveModeFlags::NONE
                },
                ..Default::default()
            };
            let mut resolve_image_info = vk::ResolveImageInfo2::builder()
                .src_image(ms_image.get())
                .src_image_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .dst_image(ss_image.get())
                .dst_image_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                .regions(&image_resolve_regions)
                .build();
            resolve_image_info.next = (&raw const resolve_mode_info).cast();
            unsafe { device.cmd_resolve_image2(cmd, &resolve_image_info) };
        } else {
            ss_layout = ss_final_rp_layout;
        }

        {
            let (src_access, src_stage) = if ss_layout == vk::ImageLayout::TRANSFER_DST_OPTIMAL {
                (vk::AccessFlags::TRANSFER_WRITE, vk::PipelineStageFlags::TRANSFER)
            } else {
                (
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                )
            };
            let barrier = make_image_memory_barrier(
                src_access,
                vk::AccessFlags::TRANSFER_READ,
                ss_layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                ss_image.get(),
                ss_srr,
            );
            pipeline_image_barrier(device, cmd, src_stage, vk::PipelineStageFlags::TRANSFER, barrier);
            ss_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;

            let copy = |aspect: vk::ImageAspectFlags, buffer: &BufferWithMemory<'_>| {
                let layers = make_image_subresource_layers(aspect, 0, 0, ss_layer_count);
                let region = make_buffer_image_copy(ss_create_info.extent, layers);
                unsafe { device.cmd_copy_image_to_buffer(cmd, ss_image.get(), ss_layout, buffer.get(), &[region]) };
            };
            if let Some((buffer, _)) = &color_verif {
                copy(vk::ImageAspectFlags::COLOR, buffer);
            }
            if let Some((buffer, _)) = &depth_verif {
                copy(vk::ImageAspectFlags::DEPTH, buffer);
            }
            if let Some((buffer, _)) = &stencil_verif {
                copy(vk::ImageAspectFlags::STENCIL, buffer);
            }
        }

        let host_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let read_buffer = |buffer: &BufferWithMemory<'_>, size: usize| -> Result<Vec<u8>, TestError> {
            let alloc = buffer.get_allocation();
            invalidate_alloc(device, alloc)?;
            Ok(unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), size) }.to_vec())
        };
        let full_size = [full_extent[0], full_extent[1], full_extent[2]];
        let layer_total = |layer_bytes: u32| (layer_bytes * ms_layer_count) as usize;

        let color_bytes = match &color_verif {
            Some((buffer, layer_bytes)) => Some(read_buffer(buffer, layer_total(*layer_bytes))?),
            None => None,
        };
        let depth_bytes = match &depth_verif {
            Some((buffer, layer_bytes)) => Some(read_buffer(buffer, layer_total(*layer_bytes))?),
            None => None,
        };
        let stencil_bytes = match &stencil_verif {
            Some((buffer, layer_bytes)) => Some(read_buffer(buffer, layer_total(*layer_bytes))?),
            None => None,
        };

        let get_sample_index = |x: u32, y: u32, z: u32, s: u32| {
            let pixel_in_layer = y * full_extent[0] + x;
            let pixel_idx = z * full_extent[0] * full_extent[1] + pixel_in_layer;
            (pixel_idx * SAMPLE_COUNT + s) as usize
        };
        let gather = |coords: [u32; 3]| {
            (0..SAMPLE_COUNT)
                .map(|s| &pixel_data_vec[get_sample_index(coords[0], coords[1], coords[2], s)])
                .collect::<Vec<&PixelData>>()
        };

        let averaged_in_linear_default =
            maintenance10_properties(context).resolve_srgb_format_applies_transfer_function != vk::FALSE;
        let sample_count_div = SAMPLE_COUNT as f32;
        let mut pass = true;

        if let Some(color_bytes) = &color_bytes {
            let mut reference =
                crate::tcu::pixel::TextureLevel::new(tcu_format, full_size[0], full_size[1], full_size[2])?;
            {
                let mut access = reference.get_access();
                for z in 0..full_size[2] {
                    for y in 0..full_size[1] {
                        for x in 0..full_size[0] {
                            let Some(src_coords) = get_first_src_region_coords(x, y, z, &resolve_regions) else {
                                continue;
                            };
                            let samples = gather(src_coords);
                            if is_int || is_uint {
                                if p.resolve_mode != vk::ResolveModeFlags::SAMPLE_ZERO {
                                    return Err(TestError::NotPorted("integer resolve mode".to_string()));
                                }
                                let color = samples[0].color.map(|value| value as i32);
                                if !access.set_pixel_int(color, x, y, z) {
                                    return Err(not_ported("writing integer texels"));
                                }
                            } else if is_float {
                                if p.resolve_mode != vk::ResolveModeFlags::AVERAGE {
                                    return Err(TestError::NotPorted("float resolve mode".to_string()));
                                }
                                let average_in_non_linear = is_srgb
                                    && (p.srgb_flags == SrgbFlags::Skip
                                        || (p.srgb_flags == SrgbFlags::None && !averaged_in_linear_default));
                                let mut average = [0.0f32; 4];
                                for sample in &samples {
                                    let color = sample.color.map(f32::from_bits);
                                    let color = if average_in_non_linear {
                                        linear_to_srgb(color)
                                    } else {
                                        color
                                    };
                                    for (sum, value) in average.iter_mut().zip(color) {
                                        *sum += value;
                                    }
                                }
                                let mut average = average.map(|value| value / sample_count_div);
                                if is_srgb && !average_in_non_linear {
                                    average = linear_to_srgb(average);
                                }
                                access.set_pixel(average, x, y, z);
                            }
                        }
                    }
                }
            }
            let reference_access = reference.get_const_access();
            let result_access = ConstPixelBufferAccess::new(tcu_format, full_size, color_bytes);
            if is_int || is_uint {
                if !int_threshold_compare(&reference_access, &result_access, UVec4::from_array([0; 4])).ok {
                    log::error!("Color comparison failed");
                    pass = false;
                }
            } else {
                let threshold = get_color_format_threshold(tcu_format);
                if !float_threshold_compare(&reference_access, &result_access, threshold).ok {
                    log::error!("Color comparison failed");
                    pass = false;
                }
            }
        }

        if let (Some(depth_bytes), Some(depth_format)) = (&depth_bytes, depth_copy_format) {
            let mut reference =
                crate::tcu::pixel::TextureLevel::new(depth_format, full_size[0], full_size[1], full_size[2])?;
            {
                let mut access = reference.get_access();
                crate::tcu::pixel::clear_depth(&mut access, 0.0);
                for z in 0..full_size[2] {
                    for y in 0..full_size[1] {
                        for x in 0..full_size[0] {
                            let Some(src_coords) = get_first_src_region_coords(x, y, z, &resolve_regions) else {
                                continue;
                            };
                            let depths: Vec<f32> = gather(src_coords)
                                .iter()
                                .map(|sample| sample.depth_stencil[0])
                                .collect();
                            let depth = match p.resolve_mode {
                                vk::ResolveModeFlags::SAMPLE_ZERO => depths[0],
                                vk::ResolveModeFlags::MIN => depths.iter().copied().fold(1000.0f32, f32::min),
                                vk::ResolveModeFlags::MAX => depths.iter().copied().fold(-1000.0f32, f32::max),
                                vk::ResolveModeFlags::AVERAGE => depths.iter().sum::<f32>() / sample_count_div,
                                _ => return Err(TestError::NotPorted("depth resolve mode".to_string())),
                            };
                            access.set_pix_depth(depth, x, y, z);
                        }
                    }
                }
            }
            let reference_access = reference.get_const_access();
            let result_access = ConstPixelBufferAccess::new(depth_format, full_size, depth_bytes);
            let depth_threshold = match p.image_format {
                vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => 0.000025f32,
                _ => 0.000000125f32,
            };
            for z in 0..full_size[2] {
                for y in 0..full_size[1] {
                    for x in 0..full_size[0] {
                        let expected = reference_access.get_pix_depth(x, y, z);
                        let result = result_access.get_pix_depth(x, y, z);
                        if (expected - result).abs() > depth_threshold {
                            log::error!("Depth ({x}, {y}, {z}): expected {expected}, got {result}");
                            pass = false;
                        }
                    }
                }
            }
        }

        if let (Some(stencil_bytes), Some(stencil_format)) = (&stencil_bytes, stencil_copy_format) {
            let mut reference =
                crate::tcu::pixel::TextureLevel::new(stencil_format, full_size[0], full_size[1], full_size[2])?;
            {
                let mut access = reference.get_access();
                crate::tcu::pixel::clear_stencil(&mut access, 0);
                for z in 0..full_size[2] {
                    for y in 0..full_size[1] {
                        for x in 0..full_size[0] {
                            let Some(src_coords) = get_first_src_region_coords(x, y, z, &resolve_regions) else {
                                continue;
                            };
                            let stencils: Vec<i32> = gather(src_coords)
                                .iter()
                                .map(|sample| sample.depth_stencil[1] as i32)
                                .collect();
                            let stencil = match p.resolve_mode {
                                vk::ResolveModeFlags::SAMPLE_ZERO => stencils[0],
                                vk::ResolveModeFlags::MIN => stencils.iter().copied().min().unwrap_or(0),
                                vk::ResolveModeFlags::MAX => stencils.iter().copied().max().unwrap_or(0),
                                _ => return Err(TestError::NotPorted("stencil resolve mode".to_string())),
                            };
                            access.set_pix_stencil(stencil as u32, x, y, z);
                        }
                    }
                }
            }
            let reference_access = reference.get_const_access();
            let result_access = ConstPixelBufferAccess::new(stencil_format, full_size, stencil_bytes);
            for z in 0..full_size[2] {
                for y in 0..full_size[1] {
                    for x in 0..full_size[0] {
                        let expected = reference_access.get_pix_stencil(x, y, z);
                        let result = result_access.get_pix_stencil(x, y, z);
                        if expected != result {
                            log::error!("Stencil ({x}, {y}, {z}): expected {expected}, got {result}");
                            pass = false;
                        }
                    }
                }
            }
        }

        if !pass {
            return Ok(TestStatus::fail(
                "Unexpected results found in some buffers; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMultisampleResolveMaint10Tests`
pub fn create_multisample_resolve_maint10_tests(shader_object: bool) -> TestCaseGroup {
    let resolve_methods = [
        (ResolveMethod::Cmd, "resolve_cmd"),
        (ResolveMethod::RenderPass, "render_pass_resolve"),
        (ResolveMethod::DynamicRender, "dynamic_render_resolve"),
    ];

    let format_list = [
        vk::Format::R8_UNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8_SRGB,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8_SRGB,
        vk::Format::R8G8B8_UNORM,
        vk::Format::R8G8B8_UINT,
        vk::Format::R8G8B8_SINT,
        vk::Format::R8G8B8_SRGB,
        vk::Format::B8G8R8_UNORM,
        vk::Format::B8G8R8_UINT,
        vk::Format::B8G8R8_SINT,
        vk::Format::B8G8R8_SRGB,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::R8G8B8A8_SRGB,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::B8G8R8A8_UINT,
        vk::Format::B8G8R8A8_SINT,
        vk::Format::B8G8R8A8_SRGB,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A8B8G8R8_SINT_PACK32,
        vk::Format::A8B8G8R8_SRGB_PACK32,
        vk::Format::R16_UNORM,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UNORM,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16_UNORM,
        vk::Format::R16G16B16_UINT,
        vk::Format::R16G16B16_SINT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::D16_UNORM,
        vk::Format::D32_SFLOAT,
        vk::Format::S8_UINT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];

    let aspects = [
        (vk::ImageAspectFlags::COLOR, "color"),
        (vk::ImageAspectFlags::DEPTH, "depth"),
        (vk::ImageAspectFlags::STENCIL, "stencil"),
        (
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
            "depth_stencil",
        ),
    ];

    let modes = [
        (vk::ResolveModeFlags::AVERAGE, "average"),
        (vk::ResolveModeFlags::SAMPLE_ZERO, "sample_zero"),
        (vk::ResolveModeFlags::MIN, "min"),
        (vk::ResolveModeFlags::MAX, "max"),
    ];

    let areas = [
        (ResolveArea::Full, "full"),
        (ResolveArea::FullMultilayer, "full_multilayer"),
        (ResolveArea::FullMultilayerRem, "full_multilayer_rem"),
        (ResolveArea::FullMultilayerRemSingle, "full_multilayer_rem_single"),
        (ResolveArea::Full3d, "full_3d"),
        (ResolveArea::Region, "region"),
        (ResolveArea::RegionsMultilayer, "regions_multilayer"),
        (ResolveArea::RegionsMultilayerRem, "regions_multilayer_rem"),
    ];

    let srgb_cases = [
        (SrgbFlags::None, "no_flags"),
        (SrgbFlags::Enable, "enable_transfer"),
        (SrgbFlags::Skip, "skip_transfer"),
    ];

    let mut main_group = TestCaseGroup::new("m10_resolve");

    for (resolve_method, method_name) in resolve_methods {
        if shader_object && resolve_method == ResolveMethod::RenderPass {
            continue;
        }
        let mut method_group = TestCaseGroup::new(method_name);

        for format in format_list {
            let Some(tcu_format) = map_vk_format(format) else {
                continue;
            };
            let is_srgb = tcu_format.order.is_srgb();

            if matches!(resolve_method, ResolveMethod::DynamicRender | ResolveMethod::RenderPass) && !is_srgb {
                continue;
            }

            let mut format_group = TestCaseGroup::new(&format_case_name(format));

            for (resolve_aspects, aspect_name) in aspects {
                let resolve_color = resolve_aspects.contains(vk::ImageAspectFlags::COLOR);
                let resolve_depth = resolve_aspects.contains(vk::ImageAspectFlags::DEPTH);
                let resolve_stencil = resolve_aspects.contains(vk::ImageAspectFlags::STENCIL);

                if is_depth_stencil_format(format) {
                    if resolve_color {
                        continue;
                    }
                    if resolve_depth && !tcu_format.order.has_depth() {
                        continue;
                    }
                    if resolve_stencil && !tcu_format.order.has_stencil() {
                        continue;
                    }
                } else if resolve_depth || resolve_stencil {
                    continue;
                }

                let mut aspect_group = TestCaseGroup::new(aspect_name);

                for (resolve_mode, mode_name) in modes {
                    if is_depth_stencil_format(format) {
                        if resolve_stencil && resolve_mode == vk::ResolveModeFlags::AVERAGE {
                            continue;
                        }
                    } else if is_int_format(format) || is_uint_format(format) {
                        if resolve_mode != vk::ResolveModeFlags::SAMPLE_ZERO {
                            continue;
                        }
                    } else if resolve_mode != vk::ResolveModeFlags::AVERAGE {
                        continue;
                    }

                    let mut mode_group = TestCaseGroup::new(mode_name);

                    for (resolve_area, area_name) in areas {
                        if resolve_area >= ResolveArea::Full3d && resolve_method != ResolveMethod::Cmd {
                            continue;
                        }

                        let mut area_group = TestCaseGroup::new(area_name);

                        for (srgb_flags, srgb_name) in srgb_cases {
                            if srgb_flags != SrgbFlags::None && resolve_mode != vk::ResolveModeFlags::AVERAGE {
                                continue;
                            }
                            if srgb_flags != SrgbFlags::None && !is_srgb {
                                continue;
                            }

                            area_group.add_child(Box::new(Maint10ResolveCase {
                                name: srgb_name.to_string(),
                                params: TestParams {
                                    resolve_method,
                                    image_format: format,
                                    resolve_aspects,
                                    resolve_mode,
                                    resolve_area,
                                    srgb_flags,
                                },
                            }) as Box<dyn TestCase>);
                        }

                        mode_group.add_child(area_group);
                    }

                    aspect_group.add_child(mode_group);
                }

                format_group.add_child(aspect_group);
            }

            method_group.add_child(format_group);
        }

        main_group.add_child(method_group);
    }

    main_group
}
