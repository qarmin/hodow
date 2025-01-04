// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineRenderToImageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The device without VK_KHR_maintenance9 that upstream
// keeps in a singleton is created per case here, and the result image is compared through a small texel codec for the eight colour
// formats of the group instead of `tcu::TextureLevel` + `tcu::floatThresholdCompare`/`tcu::intThresholdCompare` (same thresholds:
// 0.01 for the normalised and float formats, 2 for the integer ones; the image is not logged).
//
// `render_to_image`: rendering to every layer/slice of an image (and to every mip level of one) through its own subpass.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_render_to_image::{RTI_IVEC2, RTI_UINT, RTI_UVEC4, RTI_VEC3, RTI_VEC4};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::context::create_device_without_extensions;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering, end_dynamic_rendering, make_shader_objects,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NUM_CUBE_FACES: i32 = 6;
const REFERENCE_COLOR_VALUE: u32 = 125;
const REFERENCE_STENCIL_VALUE: u32 = 42;
const REFERENCE_DEPTH_VALUE: f32 = 1.0;
/// `MAX_SIZE`: a size component to be queried at run time and replaced with the largest possible value.
const MAX_SIZE: i32 = -1;
const MAX_VERIFICATION_REGION_SIZE: i32 = 32;
const MAX_VERIFICATION_REGION_DEPTH: i32 = 8;

const MASK_W: u32 = 1;
const MASK_W_LAYERS: u32 = 1 | 8;
const MASK_WH: u32 = 1 | 2;
const MASK_WH_LAYERS: u32 = 1 | 2 | 8;
const MASK_WHD: u32 = 1 | 2 | 4;

/// `tcu::PlatformMemoryLimits::totalSystemMemory` as `tcu::Platform::getMemoryLimits` defaults it.
const TOTAL_SYSTEM_MEMORY: vk::DeviceSize = 256 * 1024 * 1024;

const COLOR_TABLE: [[f32; 4]; 8] = [
    [0.9, 0.0, 0.0, 1.0],
    [0.6, 1.0, 0.0, 1.0],
    [0.3, 0.0, 1.0, 1.0],
    [0.1, 1.0, 1.0, 1.0],
    [0.8, 1.0, 0.0, 1.0],
    [0.5, 0.0, 1.0, 1.0],
    [0.2, 0.0, 0.0, 1.0],
    [1.0, 1.0, 0.0, 1.0],
];

const NO_DEPTH_STENCIL: vk::Format = vk::Format::UNDEFINED;
const DEPTH_STENCIL_FORMATS: [(vk::Format, &str); 5] = [
    (NO_DEPTH_STENCIL, ""),
    (vk::Format::D16_UNORM, "d16_unorm"),
    (vk::Format::S8_UINT, "s8_uint"),
    (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
    (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum AllocationKind {
    Suballocated,
    Dedicated,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ViewKind {
    OneD,
    OneDArray,
    TwoD,
    TwoDArray,
    ThreeD,
    Cube,
    CubeArray,
}

impl ViewKind {
    /// `isCube`
    fn is_cube(self) -> bool {
        matches!(self, ViewKind::Cube | ViewKind::CubeArray)
    }

    /// `getImageType`
    fn image_type(self) -> vk::ImageType {
        match self {
            ViewKind::OneD | ViewKind::OneDArray => vk::ImageType::_1D,
            ViewKind::TwoD | ViewKind::TwoDArray | ViewKind::Cube | ViewKind::CubeArray => vk::ImageType::_2D,
            ViewKind::ThreeD => vk::ImageType::_3D,
        }
    }

    /// `getImageViewSliceType`: the view type for accessing a single layer/slice of an image.
    fn slice_view_type(self) -> vk::ImageViewType {
        match self {
            ViewKind::OneD | ViewKind::OneDArray => vk::ImageViewType::_1D,
            _ => vk::ImageViewType::_2D,
        }
    }

    /// `getImageCreateFlags`
    fn create_flags(self) -> vk::ImageCreateFlags {
        let mut flags = vk::ImageCreateFlags::empty();
        if self == ViewKind::ThreeD {
            flags |= vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE;
        }
        if self.is_cube() {
            flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }
        flags
    }

    /// `getShortImageViewTypeName`
    fn short_name(self) -> &'static str {
        match self {
            ViewKind::OneD => "1d",
            ViewKind::OneDArray => "1d_array",
            ViewKind::TwoD => "2d",
            ViewKind::TwoDArray => "2d_array",
            ViewKind::ThreeD => "3d",
            ViewKind::Cube => "cube",
            ViewKind::CubeArray => "cube_array",
        }
    }
}

struct Channel {
    /// 0..3 for r, g, b, a.
    index: usize,
    shift: u32,
    bits: u32,
}

const RGBA8_CHANNELS: [Channel; 4] = [
    Channel {
        index: 0,
        shift: 0,
        bits: 8,
    },
    Channel {
        index: 1,
        shift: 8,
        bits: 8,
    },
    Channel {
        index: 2,
        shift: 16,
        bits: 8,
    },
    Channel {
        index: 3,
        shift: 24,
        bits: 8,
    },
];
const R32_CHANNELS: [Channel; 1] = [Channel {
    index: 0,
    shift: 0,
    bits: 32,
}];
const RG16_CHANNELS: [Channel; 2] = [
    Channel {
        index: 0,
        shift: 0,
        bits: 16,
    },
    Channel {
        index: 1,
        shift: 16,
        bits: 16,
    },
];
const A1R5G5B5_CHANNELS: [Channel; 4] = [
    Channel {
        index: 3,
        shift: 15,
        bits: 1,
    },
    Channel {
        index: 0,
        shift: 10,
        bits: 5,
    },
    Channel {
        index: 1,
        shift: 5,
        bits: 5,
    },
    Channel {
        index: 2,
        shift: 0,
        bits: 5,
    },
];
const R5G6B5_CHANNELS: [Channel; 3] = [
    Channel {
        index: 0,
        shift: 11,
        bits: 5,
    },
    Channel {
        index: 1,
        shift: 5,
        bits: 6,
    },
    Channel {
        index: 2,
        shift: 0,
        bits: 5,
    },
];
const A2B10G10R10_CHANNELS: [Channel; 4] = [
    Channel {
        index: 3,
        shift: 30,
        bits: 2,
    },
    Channel {
        index: 2,
        shift: 20,
        bits: 10,
    },
    Channel {
        index: 1,
        shift: 10,
        bits: 10,
    },
    Channel {
        index: 0,
        shift: 0,
        bits: 10,
    },
];
const RGBA32F_CHANNELS: [Channel; 4] = [
    Channel {
        index: 0,
        shift: 0,
        bits: 32,
    },
    Channel {
        index: 1,
        shift: 32,
        bits: 32,
    },
    Channel {
        index: 2,
        shift: 64,
        bits: 32,
    },
    Channel {
        index: 3,
        shift: 96,
        bits: 32,
    },
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum ColorFormat {
    R8g8b8a8Unorm,
    R32Uint,
    R16g16Sint,
    R32g32b32a32Sfloat,
    A1r5g5b5UnormPack16,
    R5g6b5UnormPack16,
    A2b10g10r10UintPack32,
    A2b10g10r10UnormPack32,
}

impl ColorFormat {
    const ALL: [ColorFormat; 8] = [
        ColorFormat::R8g8b8a8Unorm,
        ColorFormat::R32Uint,
        ColorFormat::R16g16Sint,
        ColorFormat::R32g32b32a32Sfloat,
        ColorFormat::A1r5g5b5UnormPack16,
        ColorFormat::R5g6b5UnormPack16,
        ColorFormat::A2b10g10r10UintPack32,
        ColorFormat::A2b10g10r10UnormPack32,
    ];

    fn vk_format(self) -> vk::Format {
        match self {
            ColorFormat::R8g8b8a8Unorm => vk::Format::R8G8B8A8_UNORM,
            ColorFormat::R32Uint => vk::Format::R32_UINT,
            ColorFormat::R16g16Sint => vk::Format::R16G16_SINT,
            ColorFormat::R32g32b32a32Sfloat => vk::Format::R32G32B32A32_SFLOAT,
            ColorFormat::A1r5g5b5UnormPack16 => vk::Format::A1R5G5B5_UNORM_PACK16,
            ColorFormat::R5g6b5UnormPack16 => vk::Format::R5G6B5_UNORM_PACK16,
            ColorFormat::A2b10g10r10UintPack32 => vk::Format::A2B10G10R10_UINT_PACK32,
            ColorFormat::A2b10g10r10UnormPack32 => vk::Format::A2B10G10R10_UNORM_PACK32,
        }
    }

    /// `getFormatString`
    fn name(self) -> &'static str {
        match self {
            ColorFormat::R8g8b8a8Unorm => "r8g8b8a8_unorm",
            ColorFormat::R32Uint => "r32_uint",
            ColorFormat::R16g16Sint => "r16g16_sint",
            ColorFormat::R32g32b32a32Sfloat => "r32g32b32a32_sfloat",
            ColorFormat::A1r5g5b5UnormPack16 => "a1r5g5b5_unorm_pack16",
            ColorFormat::R5g6b5UnormPack16 => "r5g6b5_unorm_pack16",
            ColorFormat::A2b10g10r10UintPack32 => "a2b10g10r10_uint_pack32",
            ColorFormat::A2b10g10r10UnormPack32 => "a2b10g10r10_unorm_pack32",
        }
    }

    fn is_uint(self) -> bool {
        matches!(self, ColorFormat::R32Uint | ColorFormat::A2b10g10r10UintPack32)
    }

    fn is_sint(self) -> bool {
        self == ColorFormat::R16g16Sint
    }

    fn is_integer(self) -> bool {
        self.is_uint() || self.is_sint()
    }

    fn is_float32(self) -> bool {
        self == ColorFormat::R32g32b32a32Sfloat
    }

    fn pixel_size(self) -> usize {
        match self {
            ColorFormat::R8g8b8a8Unorm
            | ColorFormat::R32Uint
            | ColorFormat::R16g16Sint
            | ColorFormat::A2b10g10r10UintPack32
            | ColorFormat::A2b10g10r10UnormPack32 => 4,
            ColorFormat::R32g32b32a32Sfloat => 16,
            ColorFormat::A1r5g5b5UnormPack16 | ColorFormat::R5g6b5UnormPack16 => 2,
        }
    }

    fn channels(self) -> &'static [Channel] {
        match self {
            ColorFormat::R8g8b8a8Unorm => &RGBA8_CHANNELS,
            ColorFormat::R32Uint => &R32_CHANNELS,
            ColorFormat::R16g16Sint => &RG16_CHANNELS,
            ColorFormat::R32g32b32a32Sfloat => &RGBA32F_CHANNELS,
            ColorFormat::A1r5g5b5UnormPack16 => &A1R5G5B5_CHANNELS,
            ColorFormat::R5g6b5UnormPack16 => &R5G6B5_CHANNELS,
            ColorFormat::A2b10g10r10UintPack32 | ColorFormat::A2b10g10r10UnormPack32 => &A2B10G10R10_CHANNELS,
        }
    }

    /// The shader whose output type is the one `initPrograms` derives from the format.
    fn programs(self) -> BinaryCollection {
        match self {
            ColorFormat::R8g8b8a8Unorm
            | ColorFormat::R32g32b32a32Sfloat
            | ColorFormat::A1r5g5b5UnormPack16
            | ColorFormat::A2b10g10r10UnormPack32 => RTI_VEC4.programs,
            ColorFormat::R5g6b5UnormPack16 => RTI_VEC3.programs,
            ColorFormat::R32Uint => RTI_UINT.programs,
            ColorFormat::R16g16Sint => RTI_IVEC2.programs,
            ColorFormat::A2b10g10r10UintPack32 => RTI_UVEC4.programs,
        }
    }

    /// `getClearValue`
    fn clear_value(self) -> vk::ClearValue {
        if self.is_integer() {
            vk::ClearValue {
                color: vk::ClearColorValue {
                    uint32: [REFERENCE_COLOR_VALUE; 4],
                },
            }
        } else {
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [1.0; 4] },
            }
        }
    }

    /// The texel as it reads back after `tcu::clear`/`setPixel` stored the reference value in this format; `None` is the clear value.
    fn expected_texel(self, color: Option<[f32; 4]>) -> [f64; 4] {
        let mut out = [0.0, 0.0, 0.0, 1.0];
        for channel in self.channels() {
            let max = ((1u64 << channel.bits) - 1) as f64;
            let value = if self.is_float32() {
                color.map_or(1.0, |c| c[channel.index]) as f64
            } else if self.is_integer() {
                let source = color.map_or(REFERENCE_COLOR_VALUE as i32, |c| {
                    (REFERENCE_COLOR_VALUE as f32 * c[channel.index]) as i32
                });
                if self.is_sint() {
                    let range = (1i64 << (channel.bits - 1)) as f64;
                    (source as f64).clamp(-range, range - 1.0)
                } else {
                    (source as f64).min(max)
                }
            } else {
                let source = color.map_or(1.0, |c| c[channel.index]);
                ((source * max as f32).round_ties_even() as f64).clamp(0.0, max) / max
            };
            out[channel.index] = value;
        }
        out
    }

    /// One texel read back from the buffer.
    fn decode(self, bytes: &[u8]) -> [f64; 4] {
        let mut out = [0.0, 0.0, 0.0, 1.0];
        if self.is_float32() {
            for (i, value) in out.iter_mut().enumerate() {
                *value =
                    f32::from_le_bytes([bytes[i * 4], bytes[i * 4 + 1], bytes[i * 4 + 2], bytes[i * 4 + 3]]) as f64;
            }
            return out;
        }

        let word = bytes[..self.pixel_size()]
            .iter()
            .rev()
            .fold(0u64, |word, &byte| (word << 8) | byte as u64);
        for channel in self.channels() {
            let raw = (word >> channel.shift) & ((1u64 << channel.bits) - 1);
            let max = ((1u64 << channel.bits) - 1) as f64;
            out[channel.index] = if self.is_sint() {
                let sign_bit = 1u64 << (channel.bits - 1);
                if raw & sign_bit != 0 {
                    raw as f64 - (1u64 << channel.bits) as f64
                } else {
                    raw as f64
                }
            } else if self.is_uint() {
                raw as f64
            } else {
                raw as f64 / max
            };
        }
        out
    }

    fn texel_matches(self, got: [f64; 4], want: [f64; 4]) -> bool {
        let threshold = if self.is_integer() { 2.0 } else { 0.01f32 as f64 };
        self.channels()
            .iter()
            .all(|channel| (got[channel.index] - want[channel.index]).abs() <= threshold)
    }
}

/// `CaseDef`
#[derive(Clone, Copy)]
struct CaseDef {
    view_type: ViewKind,
    /// (w, h, d, layers), a component may have the symbolic value `MAX_SIZE`.
    image_size_hint: [i32; 4],
    color_format: ColorFormat,
    /// A depth/stencil format, or UNDEFINED if not used.
    depth_stencil_format: vk::Format,
    allocation_kind: AllocationKind,
    maintenance9: bool,
}

/// `maxLayersOrDepth`
fn max_layers_or_depth(size: [i32; 4]) -> i32 {
    size[2].max(size[3])
}

/// `product`
fn product(size: [i32; 4]) -> vk::DeviceSize {
    size.iter().map(|&v| v as vk::DeviceSize).product()
}

fn extent_of(size: [i32; 4]) -> vk::Extent3D {
    vk::Extent3D {
        width: size[0] as u32,
        height: size[1] as u32,
        depth: size[2] as u32,
    }
}

/// `findIndexOfMaxComponent`
fn find_index_of_max_component(vec: [i32; 4]) -> usize {
    let mut index = 0;
    let mut value = vec[0];
    for (i, &v) in vec.iter().enumerate().skip(1) {
        if v > value {
            index = i;
            value = v;
        }
    }
    index
}

/// The default device of the context, or one created without VK_KHR_maintenance9 for the cases that must not run with it.
struct CustomDevice {
    device: Device,
    allocator: SimpleAllocator,
    queue: vk::Queue,
}

impl Drop for CustomDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

struct DeviceHelper<'a> {
    context: &'a Context<'a>,
    custom: Option<CustomDevice>,
}

impl<'a> DeviceHelper<'a> {
    fn new(context: &'a Context<'a>, need_custom_device: bool) -> Result<Self, TestError> {
        if !need_custom_device {
            return Ok(Self { context, custom: None });
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let device =
            create_device_without_extensions(instance, physical_device, queue_family_index, &["VK_KHR_maintenance9"])?;
        let queue = unsafe { device.get_device_queue(queue_family_index, 0) };
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        Ok(Self {
            context,
            custom: Some(CustomDevice {
                device,
                allocator: SimpleAllocator::new(memory_properties),
                queue,
            }),
        })
    }

    fn device(&self) -> &Device {
        match &self.custom {
            Some(custom) => &custom.device,
            None => self.context.get_device(),
        }
    }

    fn queue(&self) -> vk::Queue {
        match &self.custom {
            Some(custom) => custom.queue,
            None => self.context.get_universal_queue(),
        }
    }

    fn allocator(&self) -> &SimpleAllocator {
        match &self.custom {
            Some(custom) => &custom.allocator,
            None => self.context.get_default_allocator(),
        }
    }
}

/// `bindBuffer` + `makeBuffer`
fn make_buffer_with_memory<'a>(
    device: &'a Device,
    allocator: &SimpleAllocator,
    kind: AllocationKind,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    requirement: MemoryRequirement,
) -> Result<BufferWithMemory<'a>, TestError> {
    let info = make_buffer_create_info(size, usage);
    match kind {
        AllocationKind::Suballocated => BufferWithMemory::new(device, allocator, info, requirement),
        AllocationKind::Dedicated => BufferWithMemory::new_dedicated(device, allocator, info, requirement),
    }
}

/// `bindImage` + `makeImage`
fn make_image_with_memory<'a>(
    device: &'a Device,
    allocator: &SimpleAllocator,
    kind: AllocationKind,
    info: vk::ImageCreateInfo,
) -> Result<ImageWithMemory<'a>, TestError> {
    match kind {
        AllocationKind::Suballocated => ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY),
        AllocationKind::Dedicated => ImageWithMemory::new_dedicated(device, allocator, info, MemoryRequirement::ANY),
    }
}

/// `makeImage`
fn make_image_create_info(
    flags: vk::ImageCreateFlags,
    image_type: vk::ImageType,
    format: vk::Format,
    size: [i32; 3],
    num_mip_levels: u32,
    num_layers: u32,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .flags(flags)
        .image_type(image_type)
        .format(format)
        .extent(vk::Extent3D {
            width: size[0] as u32,
            height: size[1] as u32,
            depth: size[2] as u32,
        })
        .mip_levels(num_mip_levels)
        .array_layers(num_layers)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// `makeColorSubresourceRange`
fn make_color_subresource_range(base_array_layer: i32, layer_count: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, base_array_layer as u32, layer_count)
}

/// `getFormatAspectFlags`
fn get_format_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::UNDEFINED => vk::ImageAspectFlags::empty(),
        vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT => {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        }
        vk::Format::D16_UNORM => vk::ImageAspectFlags::DEPTH,
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        _ => vk::ImageAspectFlags::COLOR,
    }
}

/// A vertex of `Vertex4RGBA`: a position and a colour.
type Vertex4Rgba = [f32; 8];

/// `genFullQuadVertices`: a half-viewport quad per subpass, for TRIANGLE_STRIP.
fn gen_full_quad_vertices(subpass_count: i32) -> Vec<Vertex4Rgba> {
    let mut vertices = Vec::new();
    for subpass_ndx in 0..subpass_count as usize {
        let color = COLOR_TABLE[subpass_ndx % COLOR_TABLE.len()];
        for position in [[0.0, -1.0], [0.0, 1.0], [1.0, -1.0], [1.0, 1.0]] {
            vertices.push([
                position[0],
                position[1],
                0.0,
                1.0,
                color[0],
                color[1],
                color[2],
                color[3],
            ]);
        }
    }
    vertices
}

fn make_vertex_buffer<'a>(
    device: &'a Device,
    allocator: &SimpleAllocator,
    kind: AllocationKind,
    vertices: &[Vertex4Rgba],
) -> Result<BufferWithMemory<'a>, TestError> {
    let size = std::mem::size_of_val(vertices) as vk::DeviceSize;
    let buffer = make_buffer_with_memory(
        device,
        allocator,
        kind,
        size,
        vk::BufferUsageFlags::VERTEX_BUFFER,
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            vertices.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// `makeRenderPass`: a render pass with one subpass per color attachment and depth/stencil attachment (if used).
fn make_render_pass(
    device: &Device,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    num_layers: u32,
    initial_color_image_layout: vk::ImageLayout,
    initial_depth_stencil_image_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let color_attachment_description = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(initial_color_image_layout)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let mut attachment_descriptions = vec![color_attachment_description; num_layers as usize];

    let use_depth_stencil = depth_stencil_format != vk::Format::UNDEFINED;
    let depth_stencil_attachment_description = vk::AttachmentDescription::builder()
        .format(depth_stencil_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::DONT_CARE)
        .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(initial_depth_stencil_image_layout)
        .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .build();
    if use_depth_stencil {
        attachment_descriptions.extend(std::iter::repeat_n(
            depth_stencil_attachment_description,
            num_layers as usize,
        ));
    }

    // Create a subpass for each attachment (each attachment is a layer of an arrayed image).
    let color_attachment_references: Vec<vk::AttachmentReference> = (0..num_layers)
        .map(|i| vk::AttachmentReference {
            attachment: i,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        })
        .collect();
    let depth_stencil_attachment_references: Vec<vk::AttachmentReference> = (0..num_layers)
        .map(|i| vk::AttachmentReference {
            attachment: i + num_layers,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        })
        .collect();

    // Ordering here must match the framebuffer attachments
    let subpasses: Vec<vk::SubpassDescription> = (0..num_layers as usize)
        .map(|i| {
            let mut subpass = vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachment_references[i..=i]);
            if use_depth_stencil {
                subpass = subpass.depth_stencil_attachment(&depth_stencil_attachment_references[i]);
            }
            subpass.build()
        })
        .collect();

    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// The state `preparePipelineWrapper` gives every pipeline of a case, which a shader object draw sets as dynamic states.
fn slice_draw_state(render_size: [i32; 2], use_depth: bool, use_stencil: bool) -> DrawPipelineState {
    let stencil_op_state = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::EQUAL)
        .compare_mask(!0)
        .write_mask(!0)
        .reference(REFERENCE_STENCIL_VALUE)
        .build();

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .with_full_viewport(render_size[0] as u32, render_size[1] as u32);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<Vertex4Rgba>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![
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
    state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(use_depth)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::LESS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(use_stencil)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build();
    state
}

/// `preparePipelineWrapper`, for the monolithic construction type; `base_pipeline` is the first pipeline of the render pass for the
/// derivatives.
#[allow(clippy::too_many_arguments)]
fn prepare_pipeline<'a>(
    device: &'a Device,
    base_pipeline: Option<vk::Pipeline>,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    render_size: [i32; 2],
    subpass: u32,
    use_depth: bool,
    use_stencil: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut state = slice_draw_state(render_size, use_depth, use_stencil);
    state.subpass = subpass;
    state.create_flags = if base_pipeline.is_none() {
        vk::PipelineCreateFlags::ALLOW_DERIVATIVES
    } else {
        vk::PipelineCreateFlags::DERIVATIVE
    };
    state.base_pipeline = base_pipeline.map(|pipeline| (pipeline, -1));

    create_draw_pipeline(
        device,
        layout,
        render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, fragment_module),
        ],
        &state,
    )
}

/// `generateExpectedImage` folded into the comparison: the right half of every slice holds that slice's colour, the rest the clear value.
fn verify_image(
    format: ColorFormat,
    data: &[u8],
    size: [usize; 3],
    render_size: [i32; 2],
    color_depth_offset: i32,
) -> bool {
    let [width, height, depth] = size;
    let pixel_size = format.pixel_size();
    let clear = format.expected_texel(None);

    for z in 0..depth {
        let set_color = format.expected_texel(Some(COLOR_TABLE[(z + color_depth_offset as usize) % COLOR_TABLE.len()]));
        for y in 0..height {
            for x in 0..width {
                let in_quad =
                    (y as i32) < render_size[1] && (x as i32) >= render_size[0] / 2 && (x as i32) < render_size[0];
                let want = if in_quad { set_color } else { clear };
                let offset = ((z * height + y) * width + x) * pixel_size;
                if !format.texel_matches(format.decode(&data[offset..offset + pixel_size]), want) {
                    return false;
                }
            }
        }
    }
    true
}

/// `getMaxImageSize`: limits have been taken from the Vulkan specification.
fn get_max_image_size(view_type: ViewKind, size_hint: [i32; 4]) -> [i32; 4] {
    let mut size = [
        if size_hint[0] != MAX_SIZE { size_hint[0] } else { 4096 },
        if size_hint[1] != MAX_SIZE { size_hint[1] } else { 4096 },
        if size_hint[2] != MAX_SIZE { size_hint[2] } else { 256 },
        if size_hint[3] != MAX_SIZE { size_hint[3] } else { 256 },
    ];

    match view_type {
        ViewKind::OneD | ViewKind::OneDArray => size[0] = size[0].min(4096),
        ViewKind::TwoD | ViewKind::TwoDArray => {
            size[0] = size[0].min(4096);
            size[1] = size[1].min(4096);
        }
        ViewKind::ThreeD => {
            size[0] = size[0].min(256);
            size[1] = size[1].min(256);
        }
        ViewKind::Cube | ViewKind::CubeArray => {
            size[0] = size[0].min(4096);
            size[1] = size[1].min(4096);
            size[3] = size[3].min(252);
            size[3] = NUM_CUBE_FACES * (size[3] / NUM_CUBE_FACES); // round down to 6 faces
        }
    }

    size
}

/// `getReducedImageSize`: a smaller image size, or `None` if it can't be reduced more.
fn get_reduced_image_size(view_type: ViewKind, mut size: [i32; 4]) -> Option<[i32; 4]> {
    let max_index = find_index_of_max_component(size);
    let reduced_size = size[max_index] >> 1;

    match view_type {
        ViewKind::Cube | ViewKind::CubeArray => {
            if max_index < 2 {
                size[0] = reduced_size;
                size[1] = reduced_size;
            } else if max_index == 3 && reduced_size >= NUM_CUBE_FACES {
                size[3] = NUM_CUBE_FACES * (reduced_size / NUM_CUBE_FACES); // round down to a multiple of 6
            } else {
                size = [0; 4];
            }
        }
        _ => size[max_index] = reduced_size,
    }

    if reduced_size == 0 {
        size = [0; 4];
    }

    if size == [0; 4] { None } else { Some(size) }
}

/// `getSupportedImageMemoryRequirements`: the requirements of an image of the size under test, `None` if its creation failed for
/// lack of memory (vkCreateImage may return an out-of-memory error if the requirements exceed maxResourceSize).
fn get_supported_image_memory_requirements(
    context: &Context<'_>,
    case_def: &CaseDef,
    format: vk::Format,
    size: [i32; 4],
    usage: vk::ImageUsageFlags,
) -> Result<Option<vk::MemoryRequirements>, TestError> {
    let device = context.get_device();
    let info = make_image_create_info(
        case_def.view_type.create_flags(),
        case_def.view_type.image_type(),
        format,
        [size[0], size[1], size[2]],
        1,
        size[3] as u32,
        usage,
    );
    match unsafe { device.create_image(&info, None) } {
        Ok(image) => {
            let image = Unique::new(device, image);
            Ok(Some(unsafe { device.get_image_memory_requirements(*image) }))
        }
        Err(vk::ErrorCode::OUT_OF_HOST_MEMORY | vk::ErrorCode::OUT_OF_DEVICE_MEMORY) => Ok(None),
        Err(error) => Err(TestError::Fail(format!("vkCreateImage failed: {error:?}"))),
    }
}

/// `isDepthStencilFormatSupported`
fn is_depth_stencil_format_supported(context: &Context<'_>, format: vk::Format) -> bool {
    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    properties
        .optimal_tiling_features
        .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
}

/// `checkImageViewTypeRequirements`
fn check_image_view_type_requirements(context: &Context<'_>, view_type: ViewKind) -> Result<(), TestError> {
    if view_type == ViewKind::ThreeD {
        if context.is_device_functionality_supported("VK_KHR_portability_subset") {
            return Err(TestError::NotSupported(
                "VK_KHR_portability_subset: 2D image view on a 3D image is not checked".to_string(),
            ));
        }
        context.require_device_functionality("VK_KHR_maintenance1")?;
    }

    if view_type == ViewKind::CubeArray && context.get_device_features().image_cube_array == vk::FALSE {
        return Err(TestError::NotSupported(
            "Core feature imageCubeArray not supported".to_string(),
        ));
    }
    Ok(())
}

/// `checkSupportAttachmentSize`
fn check_support_attachment_size(context: &Context<'_>, case_def: &CaseDef) -> Result<(), TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    check_image_view_type_requirements(context, case_def.view_type)?;

    if case_def.allocation_kind == AllocationKind::Dedicated {
        context.require_device_functionality("VK_KHR_dedicated_allocation")?;
    }

    let color_result = unsafe {
        instance.get_physical_device_image_format_properties(
            physical_device,
            case_def.color_format.vk_format(),
            case_def.view_type.image_type(),
            vk::ImageTiling::OPTIMAL,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            case_def.view_type.create_flags(),
        )
    };
    if color_result.is_err() {
        return Err(TestError::NotSupported(
            "Unsupported color attachment format".to_string(),
        ));
    }

    if case_def.depth_stencil_format != vk::Format::UNDEFINED {
        let depth_stencil_result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                case_def.depth_stencil_format,
                case_def.view_type.image_type(),
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
                case_def.view_type.create_flags(),
            )
        };
        if depth_stencil_result.is_err() {
            return Err(TestError::NotSupported(
                "Unsupported depth/stencil attachment format".to_string(),
            ));
        }
    }

    if case_def.maintenance9 {
        context.require_device_functionality("VK_KHR_maintenance9")?;
    }
    Ok(())
}

/// `checkSupportRenderToMipMaps`
fn check_support_render_to_mip_maps(context: &Context<'_>, case_def: &CaseDef) -> Result<(), TestError> {
    check_image_view_type_requirements(context, case_def.view_type)?;

    if case_def.allocation_kind == AllocationKind::Dedicated {
        context.require_device_functionality("VK_KHR_dedicated_allocation")?;
    }

    if case_def.depth_stencil_format != vk::Format::UNDEFINED
        && !is_depth_stencil_format_supported(context, case_def.depth_stencil_format)
    {
        return Err(TestError::NotSupported("Unsupported depth/stencil format".to_string()));
    }
    Ok(())
}

/// The first memory type `selectMatchingMemoryType` finds for `MemoryRequirement::Any`.
fn select_any_memory_type(
    memory_properties: &vk::PhysicalDeviceMemoryProperties,
    memory_type_bits: u32,
) -> Result<usize, TestError> {
    (0..memory_properties.memory_type_count as usize)
        .find(|&i| memory_type_bits & (1 << i) != 0)
        .ok_or_else(|| TestError::InternalError("No compatible memory type found".to_string()))
}

/// Records one render pass with a subpass (and a draw of its own quad) per slice.
#[allow(clippy::too_many_arguments)]
fn record_slice_draws(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    render_size: [i32; 2],
    clear_values: &[vk::ClearValue],
    vertex_buffer: vk::Buffer,
    pipelines: &[Unique<'_, vk::Pipeline>],
) {
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(rect_2d(render_size[0] as u32, render_size[1] as u32))
        .clear_values(clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
        for (subpass_ndx, pipeline) in pipelines.iter().enumerate() {
            if subpass_ndx != 0 {
                device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
            }

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw(cmd, 4, 1, subpass_ndx as u32 * 4, 0);
        }
        device.cmd_end_render_pass(cmd);
    }
}

/// `record_slice_draws` for shader objects: one dynamic rendering per slice (the subpasses of the render pass), the clear values
/// laid out as the render pass attachments were (the colour ones, then the depth/stencil ones).
#[allow(clippy::too_many_arguments)]
fn record_slice_draws_shader_objects(
    device: &Device,
    cmd: vk::CommandBuffer,
    shader_objects: &ShaderObjectDraw<'_>,
    state: &DrawPipelineState,
    render_size: [i32; 2],
    clear_values: &[vk::ClearValue],
    vertex_buffer: vk::Buffer,
    color_views: &[vk::ImageView],
    depth_stencil_views: &[vk::ImageView],
    use_depth: bool,
    use_stencil: bool,
) {
    unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]) };
    for (slice, color_view) in color_views.iter().enumerate() {
        let color = RenderingAttachment {
            view: *color_view,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            clear_value: clear_values[slice],
        };
        let depth_stencil = depth_stencil_views.get(slice).map(|view| RenderingAttachment {
            view: *view,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            clear_value: clear_values[color_views.len() + slice],
        });
        begin_dynamic_rendering(
            device,
            cmd,
            rect_2d(render_size[0] as u32, render_size[1] as u32),
            &[color],
            depth_stencil.filter(|_| use_depth),
            depth_stencil.filter(|_| use_stencil),
        );
        shader_objects.bind(cmd, state);
        unsafe { device.cmd_draw(cmd, 4, 1, slice as u32 * 4, 0) };
        end_dynamic_rendering(device, cmd);
    }
}

fn clear_values_for(case_def: &CaseDef, num_slices: i32, use_depth_stencil: bool) -> Vec<vk::ClearValue> {
    let mut clear_values = vec![case_def.color_format.clear_value(); num_slices as usize];
    if use_depth_stencil {
        let depth_stencil = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: REFERENCE_DEPTH_VALUE,
                stencil: REFERENCE_STENCIL_VALUE,
            },
        };
        clear_values.extend(std::iter::repeat_n(depth_stencil, num_slices as usize));
    }
    clear_values
}

/// `testWithSizeReduction`
fn test_with_size_reduction<'a>(context: &'a Context<'a>, case_def: CaseDef) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;
    let need_custom_device = !case_def.maintenance9
        && shader_objects.is_none()
        && context.is_device_functionality_supported("VK_KHR_maintenance9");
    let helper = DeviceHelper::new(context, need_custom_device)?;
    let device = helper.device();
    let queue = helper.queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = helper.allocator();

    let mut image_size = get_max_image_size(case_def.view_type, case_def.image_size_hint);

    let color_image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let depth_stencil_image_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
    let color_format = case_def.color_format.vk_format();
    let use_depth_stencil = case_def.depth_stencil_format != vk::Format::UNDEFINED;

    for (format, usage) in [
        (color_format, color_image_usage),
        (case_def.depth_stencil_format, depth_stencil_image_usage),
    ] {
        if format == vk::Format::UNDEFINED {
            continue;
        }

        let properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                format,
                case_def.view_type.image_type(),
                vk::ImageTiling::OPTIMAL,
                usage,
                case_def.view_type.create_flags(),
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;

        image_size[0] = (image_size[0] as u32).min(properties.max_extent.width) as i32;
        image_size[1] = (image_size[1] as u32).min(properties.max_extent.height) as i32;
        image_size[2] = (image_size[2] as u32).min(properties.max_extent.depth) as i32;
        image_size[3] = (image_size[3] as u32).min(properties.max_array_layers) as i32;
    }

    macro_rules! reduce_image_size {
        () => {
            match get_reduced_image_size(case_def.view_type, image_size) {
                Some(size) => image_size = size,
                None => return Ok(TestStatus::fail("Couldn't create an image with required size")),
            }
        };
    }

    let mut allocation_possible = false;
    while !allocation_possible {
        // Get the image memory requirements
        let Some(color_image_mem_reqs) =
            get_supported_image_memory_requirements(context, &case_def, color_format, image_size, color_image_usage)?
        else {
            // Try again with reduced image size
            reduce_image_size!();
            continue;
        };

        let mut needed_memory = color_image_mem_reqs.size;

        if use_depth_stencil {
            let Some(depth_stencil_image_mem_reqs) = get_supported_image_memory_requirements(
                context,
                &case_def,
                case_def.depth_stencil_format,
                image_size,
                depth_stencil_image_usage,
            )?
            else {
                reduce_image_size!();
                continue;
            };

            needed_memory += depth_stencil_image_mem_reqs.size;
        }

        // Reserve an additional 15% device memory, plus the 512KB for checking results
        const RESERVE_FOR_CHECKING: vk::DeviceSize = 500 * 1024;
        const ADDITIONAL_MEMORY: f32 = 1.15;
        needed_memory = (needed_memory as f32 * ADDITIONAL_MEMORY) as vk::DeviceSize + RESERVE_FOR_CHECKING;

        // Query the available memory in the corresponding memory heap
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        // Use the color image memory requirements, assume depth stencil uses the same memory type
        let memory_type_ndx = select_any_memory_type(&memory_properties, color_image_mem_reqs.memory_type_bits)?;
        let heap_size =
            memory_properties.memory_heaps[memory_properties.memory_types[memory_type_ndx].heap_index as usize].size;
        let max_memory = heap_size.min(TOTAL_SYSTEM_MEMORY);

        if needed_memory > max_memory {
            reduce_image_size!();
            continue;
        }

        // Attempt a memory allocation
        let allocate_info = vk::MemoryAllocateInfo::builder()
            .allocation_size(needed_memory)
            .memory_type_index(memory_type_ndx as u32);
        match unsafe { device.allocate_memory(&allocate_info, None) } {
            Err(vk::ErrorCode::OUT_OF_DEVICE_MEMORY | vk::ErrorCode::OUT_OF_HOST_MEMORY) => reduce_image_size!(),
            Err(_) => return Ok(TestStatus::fail("Couldn't allocate memory")),
            Ok(memory) => {
                unsafe { device.free_memory(memory, None) };
                allocation_possible = true;
            }
        }
    }

    log::info!(
        "Using an image with size (width, height, depth, layers) = ({}, {}, {}, {})",
        image_size[0],
        image_size[1],
        image_size[2],
        image_size[3]
    );

    // "Slices" is either the depth of a 3D image, or the number of layers of an arrayed image
    let num_slices = max_layers_or_depth(image_size);

    // Determine the verification bounds. The checked region will be in the center of the rendered image
    let check_size = [
        image_size[0].min(MAX_VERIFICATION_REGION_SIZE),
        image_size[1].min(MAX_VERIFICATION_REGION_SIZE),
        image_size[2].min(MAX_VERIFICATION_REGION_DEPTH),
        image_size[3].min(MAX_VERIFICATION_REGION_DEPTH),
    ];
    let check_offset = [
        (image_size[0] - check_size[0]) / 2,
        (image_size[1] - check_size[1]) / 2,
        (image_size[2] - check_size[2]) / 2,
        (image_size[3] - check_size[3]) / 2,
    ];

    // Only make enough space for the check region
    let color_buffer_size = product(check_size) * case_def.color_format.pixel_size() as vk::DeviceSize;
    let color_buffer = make_buffer_with_memory(
        device,
        allocator,
        case_def.allocation_kind,
        color_buffer_size,
        vk::BufferUsageFlags::TRANSFER_DST,
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::write_bytes(
            color_buffer.get_allocation().get_host_ptr(),
            0,
            color_buffer_size as usize,
        )
    };
    flush_alloc(device, color_buffer.get_allocation())?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
    let initial_layout = if case_def.view_type == ViewKind::ThreeD && !case_def.maintenance9 {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    } else {
        vk::ImageLayout::UNDEFINED
    };
    let render_pass = if shader_objects.is_none() {
        Some(make_render_pass(
            device,
            color_format,
            case_def.depth_stencil_format,
            num_slices as u32,
            initial_layout,
            vk::ImageLayout::UNDEFINED,
        )?)
    } else {
        None
    };
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    // Create a color image
    let color_image = make_image_with_memory(
        device,
        allocator,
        case_def.allocation_kind,
        make_image_create_info(
            case_def.view_type.create_flags(),
            case_def.view_type.image_type(),
            color_format,
            [image_size[0], image_size[1], image_size[2]],
            1,
            image_size[3] as u32,
            color_image_usage,
        ),
    )?;

    // Create a depth/stencil image (always a 2D image, optionally layered)
    let depth_stencil_image = if use_depth_stencil {
        Some(make_image_with_memory(
            device,
            allocator,
            case_def.allocation_kind,
            make_image_create_info(
                vk::ImageCreateFlags::empty(),
                vk::ImageType::_2D,
                case_def.depth_stencil_format,
                [image_size[0], image_size[1], 1],
                1,
                num_slices as u32,
                depth_stencil_image_usage,
            ),
        )?)
    } else {
        None
    };

    // Create a vertex buffer
    let vertex_buffer = make_vertex_buffer(
        device,
        allocator,
        case_def.allocation_kind,
        &gen_full_quad_vertices(num_slices),
    )?;

    // Prepare color image upfront for rendering to individual slices. 3D slices aren't separate subresources, so they shouldn't be
    // transitioned during each subpass like array layers.
    if case_def.view_type == ViewKind::ThreeD && !case_def.maintenance9 && shader_objects.is_none() {
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_image.get(),
            make_color_subresource_range(0, image_size[3] as u32),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    // For each image layer or slice (3D), create an attachment and a pipeline
    let depth_stencil_aspect = get_format_aspect_flags(case_def.depth_stencil_format);
    let use_depth = depth_stencil_aspect.contains(vk::ImageAspectFlags::DEPTH);
    let use_stencil = depth_stencil_aspect.contains(vk::ImageAspectFlags::STENCIL);

    let mut color_attachments = Vec::new();
    let mut depth_stencil_attachments = Vec::new();
    let mut pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
    let mut attachment_handles = Vec::new(); // all attachments (color and d/s)

    // Color attachments are first in the framebuffer
    for subpass_ndx in 0..num_slices {
        color_attachments.push(make_image_view(
            device,
            color_image.get(),
            case_def.view_type.slice_view_type(),
            color_format,
            make_color_subresource_range(subpass_ndx, 1),
        )?);
        attachment_handles.push(*color_attachments[subpass_ndx as usize]);

        // We also have to create pipelines for each subpass
        if let Some(render_pass) = &render_pass {
            let base_pipeline = pipelines.first().map(|pipeline| pipeline.get());
            pipelines.push(prepare_pipeline(
                device,
                base_pipeline,
                *pipeline_layout,
                **render_pass,
                *vertex_module,
                *fragment_module,
                [image_size[0], image_size[1]],
                subpass_ndx as u32,
                use_depth,
                use_stencil,
            )?);
        }
    }

    // Then D/S attachments, if any
    if let Some(depth_stencil_image) = &depth_stencil_image {
        for subpass_ndx in 0..num_slices {
            depth_stencil_attachments.push(make_image_view(
                device,
                depth_stencil_image.get(),
                vk::ImageViewType::_2D,
                case_def.depth_stencil_format,
                make_image_subresource_range(depth_stencil_aspect, 0, 1, subpass_ndx as u32, 1),
            )?);
            attachment_handles.push(*depth_stencil_attachments[subpass_ndx as usize]);
        }
    }

    let framebuffer = match &render_pass {
        Some(render_pass) => Some(make_framebuffer(
            device,
            **render_pass,
            &attachment_handles,
            image_size[0] as u32,
            image_size[1] as u32,
            1,
        )?),
        None => None,
    };

    {
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let clear_values = clear_values_for(&case_def, num_slices, use_depth_stencil);
        if let (Some(shader_objects), None) = (&shader_objects, &render_pass) {
            let color_layers = (if case_def.maintenance9 {
                image_size[2]
            } else {
                image_size[3]
            }) as u32;
            let mut prepare_barriers = vec![make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                make_color_subresource_range(0, color_layers),
            )];
            if let Some(depth_stencil_image) = &depth_stencil_image {
                prepare_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_stencil_image.get(),
                    make_image_subresource_range(depth_stencil_aspect, 0, 1, 0, num_slices as u32),
                ));
            }
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &prepare_barriers,
                );
            }
            let color_views: Vec<vk::ImageView> = color_attachments.iter().map(|view| **view).collect();
            let depth_stencil_views: Vec<vk::ImageView> = depth_stencil_attachments.iter().map(|view| **view).collect();
            record_slice_draws_shader_objects(
                device,
                cmd,
                shader_objects,
                &slice_draw_state([image_size[0], image_size[1]], use_depth, use_stencil),
                [image_size[0], image_size[1]],
                &clear_values,
                vertex_buffer.get(),
                &color_views,
                &depth_stencil_views,
                use_depth,
                use_stencil,
            );
        } else if let (Some(render_pass), Some(framebuffer)) = (&render_pass, &framebuffer) {
            record_slice_draws(
                device,
                cmd,
                **render_pass,
                **framebuffer,
                [image_size[0], image_size[1]],
                &clear_values,
                vertex_buffer.get(),
                &pipelines,
            );
        }

        // Copy colorImage -> host visible colorBuffer
        {
            let layers = (if case_def.maintenance9 {
                image_size[2]
            } else {
                image_size[3]
            }) as u32;

            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_image.get(),
                make_color_subresource_range(0, layers),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
            }

            // Copy the checked region rather than the whole image
            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(
                    vk::ImageAspectFlags::COLOR,
                    0,
                    check_offset[3] as u32,
                    check_size[3] as u32,
                ),
                image_offset: vk::Offset3D {
                    x: check_offset[0],
                    y: check_offset[1],
                    z: check_offset[2],
                },
                image_extent: extent_of(check_size),
            };
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.get(),
                    &[region],
                )
            };

            let buffer_barrier = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(color_buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    // Verify results
    invalidate_alloc(device, color_buffer.get_allocation())?;

    let check_depth = max_layers_or_depth(check_size);
    let depth_offset = max_layers_or_depth(check_offset);
    let pixel_size = case_def.color_format.pixel_size();
    let result = unsafe {
        std::slice::from_raw_parts(
            color_buffer.get_allocation().get_host_ptr(),
            check_size[0] as usize * check_size[1] as usize * check_depth as usize * pixel_size,
        )
    };

    let ok = verify_image(
        case_def.color_format,
        result,
        [check_size[0] as usize, check_size[1] as usize, check_depth as usize],
        [check_size[0], check_size[1]],
        depth_offset,
    );
    Ok(if ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `testAttachmentSize`: a test that can exercise very big color and depth/stencil attachment sizes. If the total memory consumed by
/// images is too large, or if the implementation returns OUT_OF_MEMORY error somewhere, the test can be retried with a next increment
/// of size reduction index, making the attachments smaller.
fn test_attachment_size<'a>(context: &'a Context<'a>, case_def: CaseDef) -> TestOutcome {
    test_with_size_reduction(context, case_def)
}

/// `getMipLevelSizes`
fn get_mip_level_sizes(mut base_size: [i32; 4]) -> Vec<[i32; 4]> {
    let mut levels = vec![base_size];

    while base_size[0] != 1 || base_size[1] != 1 || base_size[2] != 1 {
        base_size[0] = (base_size[0] >> 1).max(1);
        base_size[1] = (base_size[1] >> 1).max(1);
        base_size[2] = (base_size[2] >> 1).max(1);
        levels.push(base_size);
    }

    levels
}

/// `getPerMipLevelStorageSize`: memory consumed by each mip level, including all layers. Sizes include a padding for alignment.
fn get_per_mip_level_storage_size(mip_level_sizes: &[[i32; 4]], pixel_size: vk::DeviceSize) -> Vec<vk::DeviceSize> {
    const LEVEL_ALIGNMENT: vk::DeviceSize = 16;
    mip_level_sizes
        .iter()
        .map(|&size| (pixel_size * product(size)).div_ceil(LEVEL_ALIGNMENT) * LEVEL_ALIGNMENT)
        .collect()
}

/// `drawToMipLevel`
#[allow(clippy::too_many_arguments)]
fn draw_to_mip_level(
    context: &Context<'_>,
    shader_objects: Option<&ShaderObjectDraw<'_>>,
    case_def: &CaseDef,
    mip_level: u32,
    mip_size: [i32; 4],
    num_slices: i32,
    color_image: vk::Image,
    depth_stencil_image: Option<vk::Image>,
    vertex_buffer: vk::Buffer,
    pipeline_layout: vk::PipelineLayout,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
) -> Result<(), TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let color_format = case_def.color_format.vk_format();
    let depth_stencil_aspect = get_format_aspect_flags(case_def.depth_stencil_format);
    let use_depth = depth_stencil_aspect.contains(vk::ImageAspectFlags::DEPTH);
    let use_stencil = depth_stencil_aspect.contains(vk::ImageAspectFlags::STENCIL);
    let use_depth_stencil = use_depth || use_stencil;

    let render_pass = if shader_objects.is_none() {
        Some(make_render_pass(
            device,
            color_format,
            case_def.depth_stencil_format,
            num_slices as u32,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?)
    } else {
        None
    };

    let mut color_attachments = Vec::new();
    let mut depth_stencil_attachments = Vec::new();
    let mut pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
    let mut attachment_handles = Vec::new(); // all attachments (color and d/s)

    // For each image layer or slice (3D), create an attachment and a pipeline. Color attachments are first in the framebuffer
    for subpass_ndx in 0..num_slices {
        color_attachments.push(make_image_view(
            device,
            color_image,
            case_def.view_type.slice_view_type(),
            color_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, mip_level, 1, subpass_ndx as u32, 1),
        )?);
        attachment_handles.push(*color_attachments[subpass_ndx as usize]);

        // We also have to create pipelines for each subpass
        if let Some(render_pass) = &render_pass {
            let base_pipeline = pipelines.first().map(|pipeline| pipeline.get());
            pipelines.push(prepare_pipeline(
                device,
                base_pipeline,
                pipeline_layout,
                **render_pass,
                vertex_module,
                fragment_module,
                [mip_size[0], mip_size[1]],
                subpass_ndx as u32,
                use_depth,
                use_stencil,
            )?);
        }
    }

    // Then D/S attachments, if any
    if let (true, Some(depth_stencil_image)) = (use_depth_stencil, depth_stencil_image) {
        for subpass_ndx in 0..num_slices {
            depth_stencil_attachments.push(make_image_view(
                device,
                depth_stencil_image,
                vk::ImageViewType::_2D,
                case_def.depth_stencil_format,
                make_image_subresource_range(depth_stencil_aspect, mip_level, 1, subpass_ndx as u32, 1),
            )?);
            attachment_handles.push(*depth_stencil_attachments[subpass_ndx as usize]);
        }
    }

    let framebuffer = match &render_pass {
        Some(render_pass) => Some(make_framebuffer(
            device,
            **render_pass,
            &attachment_handles,
            mip_size[0] as u32,
            mip_size[1] as u32,
            1,
        )?),
        None => None,
    };

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    let clear_values = clear_values_for(case_def, num_slices, use_depth_stencil);
    if let Some(shader_objects) = shader_objects {
        let color_views: Vec<vk::ImageView> = color_attachments.iter().map(|view| **view).collect();
        let depth_stencil_views: Vec<vk::ImageView> = depth_stencil_attachments.iter().map(|view| **view).collect();
        record_slice_draws_shader_objects(
            device,
            cmd,
            shader_objects,
            &slice_draw_state([mip_size[0], mip_size[1]], use_depth, use_stencil),
            [mip_size[0], mip_size[1]],
            &clear_values,
            vertex_buffer,
            &color_views,
            &depth_stencil_views,
            use_depth,
            use_stencil,
        );
    } else if let (Some(render_pass), Some(framebuffer)) = (&render_pass, &framebuffer) {
        record_slice_draws(
            device,
            cmd,
            **render_pass,
            **framebuffer,
            [mip_size[0], mip_size[1]],
            &clear_values,
            vertex_buffer,
            &pipelines,
        );
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)
}

/// `testRenderToMipMaps`: use image mip levels as attachments.
fn test_render_to_mip_maps<'a>(context: &'a Context<'a>, case_def: CaseDef) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();

    let image_size = case_def.image_size_hint; // MAX_SIZE is not used in this test
    let num_slices = max_layers_or_depth(image_size);
    let mip_level_sizes = get_mip_level_sizes(image_size);
    let pixel_size = case_def.color_format.pixel_size();
    let mip_level_storage_sizes = get_per_mip_level_storage_size(&mip_level_sizes, pixel_size as vk::DeviceSize);
    let num_mip_levels = mip_level_sizes.len() as i32;
    let use_depth_stencil = case_def.depth_stencil_format != vk::Format::UNDEFINED;
    let color_format = case_def.color_format.vk_format();

    // Create a color buffer big enough to hold all layers and mip levels
    let color_buffer_size: vk::DeviceSize = mip_level_storage_sizes.iter().sum();
    let color_buffer = make_buffer_with_memory(
        device,
        allocator,
        case_def.allocation_kind,
        color_buffer_size,
        vk::BufferUsageFlags::TRANSFER_DST,
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::write_bytes(
            color_buffer.get_allocation().get_host_ptr(),
            0,
            color_buffer_size as usize,
        )
    };
    flush_alloc(device, color_buffer.get_allocation())?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;

    // Create a color image
    let color_image = make_image_with_memory(
        device,
        allocator,
        case_def.allocation_kind,
        make_image_create_info(
            case_def.view_type.create_flags(),
            case_def.view_type.image_type(),
            color_format,
            [image_size[0], image_size[1], image_size[2]],
            num_mip_levels as u32,
            image_size[3] as u32,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        ),
    )?;

    // Create a depth/stencil image (always a 2D image, optionally layered)
    let depth_stencil_image = if use_depth_stencil {
        Some(make_image_with_memory(
            device,
            allocator,
            case_def.allocation_kind,
            make_image_create_info(
                vk::ImageCreateFlags::empty(),
                vk::ImageType::_2D,
                case_def.depth_stencil_format,
                [image_size[0], image_size[1], 1],
                num_mip_levels as u32,
                num_slices as u32,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            ),
        )?)
    } else {
        None
    };

    // Create a vertex buffer
    let vertex_buffer = make_vertex_buffer(
        device,
        allocator,
        case_def.allocation_kind,
        &gen_full_quad_vertices(num_slices),
    )?;

    // Prepare images
    {
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let mut image_barriers = vec![make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_image.get(),
            make_image_subresource_range(
                vk::ImageAspectFlags::COLOR,
                0,
                num_mip_levels as u32,
                0,
                vk::REMAINING_ARRAY_LAYERS,
            ),
        )];
        if let Some(depth_stencil_image) = &depth_stencil_image {
            image_barriers.push(make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                depth_stencil_image.get(),
                make_image_subresource_range(
                    get_format_aspect_flags(case_def.depth_stencil_format),
                    0,
                    num_mip_levels as u32,
                    0,
                    vk::REMAINING_ARRAY_LAYERS,
                ),
            ));
        }

        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    // Draw
    for (mip_level, mip_size) in mip_level_sizes.iter().enumerate() {
        let level_slices = max_layers_or_depth(*mip_size);

        draw_to_mip_level(
            context,
            shader_objects.as_ref(),
            &case_def,
            mip_level as u32,
            *mip_size,
            level_slices,
            color_image.get(),
            depth_stencil_image.as_ref().map(|image| image.get()),
            vertex_buffer.get(),
            *pipeline_layout,
            *vertex_module,
            *fragment_module,
        )?;
    }

    // Copy results: colorImage -> host visible colorBuffer
    {
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            make_image_subresource_range(
                vk::ImageAspectFlags::COLOR,
                0,
                num_mip_levels as u32,
                0,
                vk::REMAINING_ARRAY_LAYERS,
            ),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
        }

        let mut regions = Vec::new();
        let mut level_offset: vk::DeviceSize = 0;
        for (mip_level, mip_size) in mip_level_sizes.iter().enumerate() {
            regions.push(vk::BufferImageCopy {
                buffer_offset: level_offset,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(
                    vk::ImageAspectFlags::COLOR,
                    mip_level as u32,
                    0,
                    image_size[3] as u32,
                ),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: extent_of(*mip_size),
            });

            level_offset += mip_level_storage_sizes[mip_level];
        }
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                &regions,
            )
        };

        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(color_buffer.get())
            .offset(0)
            .size(vk::WHOLE_SIZE)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    // Verify results (per mip level)
    invalidate_alloc(device, color_buffer.get_allocation())?;

    let mut level_offset: vk::DeviceSize = 0;
    let mut all_ok = true;
    for (mip_level, mip_size) in mip_level_sizes.iter().enumerate() {
        let level_depth = max_layers_or_depth(*mip_size) as usize;
        let level_bytes = mip_size[0] as usize * mip_size[1] as usize * level_depth * pixel_size;
        let level_data = unsafe {
            std::slice::from_raw_parts(
                color_buffer.get_allocation().get_host_ptr().add(level_offset as usize),
                level_bytes,
            )
        };

        let ok = verify_image(
            case_def.color_format,
            level_data,
            [mip_size[0] as usize, mip_size[1] as usize, level_depth],
            [mip_size[0], mip_size[1]],
            0,
        );

        all_ok = all_ok && ok; // keep testing all levels, even if we know it's a fail overall
        level_offset += mip_level_storage_sizes[mip_level];
    }

    Ok(if all_ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

#[derive(Clone, Copy)]
enum Kind {
    AttachmentSize,
    RenderToMipMaps,
}

struct RenderToImageCase {
    name: String,
    kind: Kind,
    case_def: CaseDef,
}

impl TestCase for RenderToImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            Kind::AttachmentSize => check_support_attachment_size(context, &self.case_def),
            Kind::RenderToMipMaps => check_support_render_to_mip_maps(context, &self.case_def),
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.case_def.color_format.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RenderToImageInstance {
            context,
            kind: self.kind,
            case_def: self.case_def,
        })
    }
}

struct RenderToImageInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    case_def: CaseDef,
}

impl TestInstance for RenderToImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::AttachmentSize => test_attachment_size(self.context, self.case_def),
            Kind::RenderToMipMaps => test_render_to_mip_maps(self.context, self.case_def),
        }
    }
}

/// `getSizeDescription`
fn get_size_description(size: [i32; 4]) -> String {
    const DESCRIPTION: [&str; 4] = ["width", "height", "depth", "layers"];

    let max_components: Vec<&str> = (0..4)
        .filter(|&i| size[i] == MAX_SIZE)
        .map(|i| DESCRIPTION[i])
        .collect();
    if max_components.is_empty() {
        "small".to_string()
    } else {
        max_components.join("_")
    }
}

/// `getFormatString(colorFormat, depthStencilFormat)`
fn get_format_string(color_format: ColorFormat, depth_stencil_format: (vk::Format, &str)) -> String {
    if depth_stencil_format.0 == vk::Format::UNDEFINED {
        color_format.name().to_string()
    } else {
        format!("{}_{}", color_format.name(), depth_stencil_format.1)
    }
}

/// `genSizeCombinations`
fn gen_size_combinations(baseline_size: [i32; 4], size_mask: u32, view_type: ViewKind) -> Vec<[i32; 4]> {
    let mut masks = std::collections::BTreeSet::new();

    let mut i = 0u32;
    while i < (1 << 4) {
        // Cube images have square faces
        if view_type.is_cube() && (i & MASK_WH) != 0 {
            i |= MASK_WH;
        }

        masks.insert(i & size_mask);
        i += 1;
    }

    masks
        .iter()
        .map(|&mask| {
            std::array::from_fn(|component| {
                if (mask >> component) & 1 != 0 {
                    MAX_SIZE
                } else {
                    baseline_size[component]
                }
            })
        })
        .collect()
}

fn add_case(group: &mut TestCaseGroup, name: String, kind: Kind, case_def: CaseDef) {
    group.add_child(Box::new(RenderToImageCase { name, kind, case_def }) as Box<dyn TestCase>);
}

/// `addTestCasesWithFunctions`
fn add_test_cases_with_functions(group: &mut TestCaseGroup, allocation_kind: AllocationKind) {
    struct ViewCase {
        view_type: ViewKind,
        /// image size: (dimX, dimY, dimZ, arraySize)
        baseline_size: [i32; 4],
        /// if a dimension is masked, generate a huge size case for it
        size_mask: u32,
    }
    const TEST_CASES: [ViewCase; 7] = [
        ViewCase {
            view_type: ViewKind::OneD,
            baseline_size: [54, 1, 1, 1],
            size_mask: MASK_W,
        },
        ViewCase {
            view_type: ViewKind::OneDArray,
            baseline_size: [54, 1, 1, 4],
            size_mask: MASK_W_LAYERS,
        },
        ViewCase {
            view_type: ViewKind::TwoD,
            baseline_size: [44, 23, 1, 1],
            size_mask: MASK_WH,
        },
        ViewCase {
            view_type: ViewKind::TwoDArray,
            baseline_size: [44, 23, 1, 4],
            size_mask: MASK_WH_LAYERS,
        },
        ViewCase {
            view_type: ViewKind::ThreeD,
            baseline_size: [22, 31, 7, 1],
            size_mask: MASK_WHD,
        },
        ViewCase {
            view_type: ViewKind::Cube,
            baseline_size: [35, 35, 1, 6],
            size_mask: MASK_WH,
        },
        ViewCase {
            view_type: ViewKind::CubeArray,
            baseline_size: [35, 35, 1, 2 * 6],
            size_mask: MASK_WH_LAYERS,
        },
    ];

    for test_case in &TEST_CASES {
        let mut image_group = TestCaseGroup::new(test_case.view_type.short_name());

        // Generate attachment size cases
        {
            let sizes = gen_size_combinations(test_case.baseline_size, test_case.size_mask, test_case.view_type);

            let mut small_group = TestCaseGroup::new("small");
            let mut huge_group = TestCaseGroup::new("huge");

            for (size_ndx, size) in sizes.iter().enumerate() {
                // The first size is the baseline size, put it in a dedicated group
                if size_ndx == 0 {
                    for depth_stencil_format in DEPTH_STENCIL_FORMATS {
                        for color_format in ColorFormat::ALL {
                            let mut case_def = CaseDef {
                                view_type: test_case.view_type,
                                image_size_hint: *size,
                                color_format,
                                depth_stencil_format: depth_stencil_format.0,
                                allocation_kind,
                                maintenance9: false,
                            };
                            add_case(
                                &mut small_group,
                                get_format_string(color_format, depth_stencil_format),
                                Kind::AttachmentSize,
                                case_def,
                            );

                            if test_case.view_type == ViewKind::ThreeD {
                                case_def.maintenance9 = true;

                                add_case(
                                    &mut small_group,
                                    format!(
                                        "{}_2d_compatible",
                                        get_format_string(color_format, depth_stencil_format)
                                    ),
                                    Kind::AttachmentSize,
                                    case_def,
                                );
                            }
                        }
                    }
                } else if allocation_kind != AllocationKind::Dedicated {
                    // All huge cases go into a separate group
                    let mut size_group = TestCaseGroup::new(get_size_description(*size));
                    let color_format = ColorFormat::R8g8b8a8Unorm;

                    // Use the same color format for all cases, to reduce the number of permutations
                    for depth_stencil_format in DEPTH_STENCIL_FORMATS {
                        let case_def = CaseDef {
                            view_type: test_case.view_type,
                            image_size_hint: *size,
                            color_format,
                            depth_stencil_format: depth_stencil_format.0,
                            allocation_kind,
                            maintenance9: false,
                        };
                        add_case(
                            &mut size_group,
                            get_format_string(color_format, depth_stencil_format),
                            Kind::AttachmentSize,
                            case_def,
                        );
                    }
                    huge_group.add_child(size_group);
                }
            }

            image_group.add_child(small_group);
            image_group.add_child(huge_group);
        }

        // Generate mip map cases
        {
            let mut mipmap_group = TestCaseGroup::new("mipmap");

            for depth_stencil_format in DEPTH_STENCIL_FORMATS {
                for color_format in ColorFormat::ALL {
                    let case_def = CaseDef {
                        view_type: test_case.view_type,
                        image_size_hint: test_case.baseline_size,
                        color_format,
                        depth_stencil_format: depth_stencil_format.0,
                        allocation_kind,
                        maintenance9: false,
                    };
                    add_case(
                        &mut mipmap_group,
                        get_format_string(color_format, depth_stencil_format),
                        Kind::RenderToMipMaps,
                        case_def,
                    );
                }
            }
            image_group.add_child(mipmap_group);
        }

        group.add_child(image_group);
    }
}

/// `createRenderToImageTests`
pub fn create_render_to_image_tests() -> TestCaseGroup {
    let mut render_to_image_tests = TestCaseGroup::new("render_to_image");

    // Core render to image tests
    let mut core = TestCaseGroup::new("core");
    add_test_cases_with_functions(&mut core, AllocationKind::Suballocated);
    render_to_image_tests.add_child(core);

    // Render to image tests for dedicated memory allocation
    let mut dedicated_allocation = TestCaseGroup::new("dedicated_allocation");
    add_test_cases_with_functions(&mut dedicated_allocation, AllocationKind::Dedicated);
    render_to_image_tests.add_child(dedicated_allocation);

    render_to_image_tests
}
