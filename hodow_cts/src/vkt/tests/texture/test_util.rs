// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureTestUtil.cpp / .hpp (TextureBinding, TextureRenderer, RenderBackend, GraphicsBackend, ComputeBackend,
//   `initializePrograms`' 2D programs)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's TextureRenderer is a long-lived object (bindings added one at a time, then `renderQuad` called any number of times);
// every user ported so far renders one quad of one 2D texture, so this is one function that builds the texture binding and the graphics or compute backend, draws the quad
// and returns the RGBA8 result, everything living until it returns. The shaders come from the `texture_swizzle` manifest (scripts/gen_texture_swizzle_manifest.py).

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vk::sparse_util::{check_sparse_image_format_support_for, universal_queue_supports_sparse_binding};
use crate::vkt::Context;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::image_util::{
    TestTexture, is_depth_stencil_format, upload_test_texture, upload_test_texture_sparse,
};

/// `texture::util::Program`, the 2D ones
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Program {
    Float2D,
    FloatBias2D,
    Int2D,
    IntBias2D,
    Uint2D,
    Shadow2D,
    Float3D,
    FloatBias3D,
    Uint3D,
    Float2DArray,
    Uint2DArray,
    FloatCube,
    FloatBiasCube,
    UintCube,
    Shadow2DArray,
    ShadowCube,
    ShadowCubeArray,
    ShadowD1,
    ShadowD1Array,
    /// `texelFetch` of a fixed texel at `u_lod` (the integer texel coordinate image view min lod cases)
    Fetch2D,
    Fetch3D,
}

impl Program {
    /// `getProgramName`
    pub fn name(self) -> &'static str {
        match self {
            Program::Float2D => "2D_FLOAT",
            Program::FloatBias2D => "2D_FLOAT_BIAS",
            Program::Int2D => "2D_INT",
            Program::IntBias2D => "2D_INT_BIAS",
            Program::Uint2D => "2D_UINT",
            Program::Shadow2D => "2D_SHADOW",
            Program::Float3D => "3D_FLOAT",
            Program::FloatBias3D => "3D_FLOAT_BIAS",
            Program::Uint3D => "3D_UINT",
            Program::Float2DArray => "2D_ARRAY_FLOAT",
            Program::Uint2DArray => "2D_ARRAY_UINT",
            Program::FloatCube => "CUBE_FLOAT",
            Program::FloatBiasCube => "CUBE_FLOAT_BIAS",
            Program::UintCube => "CUBE_UINT",
            Program::Shadow2DArray => "2D_ARRAY_SHADOW",
            Program::ShadowCube => "CUBE_SHADOW",
            Program::ShadowCubeArray => "CUBE_ARRAY_SHADOW",
            Program::ShadowD1 => "1D_SHADOW",
            Program::ShadowD1Array => "1D_ARRAY_SHADOW",
            Program::Fetch2D => "2D_FETCH_LOD",
            Program::Fetch3D => "3D_FETCH_LOD",
        }
    }
}

/// `ShaderParameters` apart from the padding the compute backend fills with the view size
#[derive(Clone, Copy, Debug)]
pub struct ShaderParameters {
    pub bias: f32,
    pub reference: f32,
    pub color_scale: [f32; 4],
    pub color_bias: [f32; 4],
    pub lod: i32,
}

/// What `vk::mapSampler` turns a `tcu::Sampler` and the lod range of the reference parameters into.
#[derive(Clone, Copy, Debug)]
pub struct SamplerParams {
    pub wrap_u: vk::SamplerAddressMode,
    pub wrap_v: vk::SamplerAddressMode,
    pub wrap_w: vk::SamplerAddressMode,
    pub min_filter: vk::Filter,
    pub mag_filter: vk::Filter,
    pub mipmap_mode: vk::SamplerMipmapMode,
    pub min_lod: f32,
    pub max_lod: f32,
    pub border_color: vk::BorderColor,
    /// `Some` turns the depth comparison on
    pub compare_op: Option<vk::CompareOp>,
    pub unnormalized: bool,
    /// VK_EXT_non_seamless_cube_map
    pub non_seamless: bool,
    /// `Some` turns anisotropic filtering on with this maximum
    pub max_anisotropy: Option<f32>,
}

impl SamplerParams {
    /// `createSampler(REPEAT_GL, REPEAT_GL, NEAREST, NEAREST)`: no mipmapping, so the filter mode alone selects level 0 (`maxLod` 0.25)
    pub fn nearest_repeat() -> Self {
        Self {
            wrap_u: vk::SamplerAddressMode::REPEAT,
            wrap_v: vk::SamplerAddressMode::REPEAT,
            wrap_w: vk::SamplerAddressMode::REPEAT,
            min_filter: vk::Filter::NEAREST,
            mag_filter: vk::Filter::NEAREST,
            mipmap_mode: vk::SamplerMipmapMode::NEAREST,
            min_lod: 0.0,
            max_lod: 0.25,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        }
    }
}

/// The kind of texture a request renders from
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum TexKind {
    /// a 1D image, `tex_height` is 1
    D1,
    /// `tex_depth` is the number of layers, `tex_height` is 1
    D1Array,
    D2,
    D3,
    /// `tex_depth` is the number of layers
    D2Array,
    /// `tex_depth` is 6
    Cube,
    /// `tex_depth` is six times the number of cube layers
    CubeArray,
}

/// Everything `renderQuad` of a 2D or 3D texture needs: what `TextureRenderer`'s constructor, `add2DTexture` and the `ReferenceParams` carry.
pub struct RenderRequest<'t> {
    pub texture: &'t TestTexture,
    pub format: vk::Format,
    pub aspect_mask: vk::ImageAspectFlags,
    pub component_mapping: vk::ComponentMapping,
    pub use_compute: bool,
    /// `TextureBinding::IMAGE_BACKING_MODE_SPARSE`
    pub sparse: bool,
    /// the render target
    pub width: u32,
    pub height: u32,
    /// the texture
    pub tex_width: u32,
    pub tex_height: u32,
    pub tex_depth: u32,
    pub kind: TexKind,
    pub sampler: SamplerParams,
    /// four vertices of two (2D) or three (3D) components
    pub tex_coord: &'t [f32],
    /// the four vertex positions, `w` included
    pub positions: [f32; 16],
    /// `Some((base, max))` restricts the view to those mip levels (`updateTextureViewMipLevels`)
    pub view_levels: Option<(u32, u32)>,
    /// `Some(minLod)` chains a `VkImageViewMinLodCreateInfoEXT` into the view (`updateTextureViewMipLevels`'s third argument)
    pub view_min_lod: Option<f32>,
    /// the format of the render target: RGBA8 or R32G32B32A32_SFLOAT
    pub output_format: vk::Format,
    pub program: Program,
    pub parameters: ShaderParameters,
}

pub const QUAD_POSITIONS: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];
const VERTEX_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const UNIFORM_BUFFER_SIZE: u64 = 52;

/// The sampled image; a sparse one is destroyed before the memory blocks bound to it.
enum TextureImage<'d> {
    Normal(ImageWithMemory<'d>),
    Sparse {
        image: Unique<'d, vk::Image>,
        _allocations: Vec<Allocation<'d>>,
    },
}

impl TextureImage<'_> {
    fn get(&self) -> vk::Image {
        match self {
            Self::Normal(image) => image.get(),
            Self::Sparse { image, .. } => **image,
        }
    }
}

/// The `DEVICE_CORE_FEATURE_SPARSE_BINDING` and `..._SPARSE_RESIDENCY_IMAGE2D` requirements of a sparse 2D texture
pub fn require_sparse_image_2d(context: &Context<'_>) -> Result<(), TestError> {
    let features = context.get_device_features();
    if features.sparse_binding == vk::FALSE {
        return Err(TestError::NotSupported(
            "Requested core feature is not supported: sparseBinding".to_string(),
        ));
    }
    if features.sparse_residency_image_2d == vk::FALSE {
        return Err(TestError::NotSupported(
            "Requested core feature is not supported: sparseResidencyImage2D".to_string(),
        ));
    }
    Ok(())
}

/// What both backends share; fields drop in this order, so a view goes before its image.
struct Common<'d> {
    sampler: Unique<'d, vk::Sampler>,
    texture_view: Unique<'d, vk::ImageView>,
    texture_image: TextureImage<'d>,
    color_view: Unique<'d, vk::ImageView>,
    color_image: ImageWithMemory<'d>,
    uniform_buffer: BufferWithMemory<'d>,
    result_buffer: BufferWithMemory<'d>,
    queue: vk::Queue,
    queue_family_index: u32,
}

/// The size of a pixel of a supported render target format
fn output_pixel_size(format: vk::Format) -> u64 {
    if format == vk::Format::R32G32B32A32_SFLOAT {
        16
    } else {
        4
    }
}

fn uniform_bytes(parameters: &ShaderParameters, padding: [f32; 2]) -> Vec<u8> {
    let mut floats = vec![parameters.bias, parameters.reference, padding[0], padding[1]];
    floats.extend_from_slice(&parameters.color_scale);
    floats.extend_from_slice(&parameters.color_bias);
    let mut bytes: Vec<u8> = floats.iter().flat_map(|value| value.to_ne_bytes()).collect();
    bytes.extend_from_slice(&parameters.lod.to_ne_bytes());
    bytes
}

fn write_host(buffer: &BufferWithMemory<'_>, device: &Device, bytes: &[u8]) -> Result<(), TestError> {
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(device, buffer.get_allocation())
}

fn prepare<'d>(context: &'d Context<'d>, request: &RenderRequest<'_>) -> Result<Common<'d>, TestError> {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let (queue, queue_family_index) = if request.use_compute {
        context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("Exclusive compute queue not supported.".to_string()))?
    } else {
        (
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        )
    };
    if request.use_compute && is_depth_stencil_format(request.format) {
        return Err(TestError::NotSupported(format!(
            "Format: {:?} not supported with compute renderer",
            request.format
        )));
    }

    // TextureBinding::updateTextureData
    let (texture_image_type, texture_view_type) = match request.kind {
        TexKind::D1 => (vk::ImageType::_1D, vk::ImageViewType::_1D),
        TexKind::D1Array => (vk::ImageType::_1D, vk::ImageViewType::_1D_ARRAY),
        TexKind::D2 => (vk::ImageType::_2D, vk::ImageViewType::_2D),
        TexKind::D3 => (vk::ImageType::_3D, vk::ImageViewType::_3D),
        TexKind::D2Array => (vk::ImageType::_2D, vk::ImageViewType::_2D_ARRAY),
        TexKind::Cube => (vk::ImageType::_2D, vk::ImageViewType::CUBE),
        TexKind::CubeArray => (vk::ImageType::_2D, vk::ImageViewType::CUBE_ARRAY),
    };
    let (texture_depth, texture_layers) = match request.kind {
        TexKind::D1 | TexKind::D2 => (1, 1),
        TexKind::D1Array => (1, request.tex_depth),
        TexKind::D3 => (request.tex_depth, 1),
        TexKind::D2Array | TexKind::Cube | TexKind::CubeArray => (1, request.tex_depth),
    };
    let mut texture_flags = if matches!(request.kind, TexKind::Cube | TexKind::CubeArray) {
        vk::ImageCreateFlags::CUBE_COMPATIBLE
    } else {
        vk::ImageCreateFlags::empty()
    };
    if request.sparse {
        require_sparse_image_2d(context)?;
        if request.kind == TexKind::D3 && context.get_device_features().sparse_residency_image_3d == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: sparseResidencyImage3D".to_string(),
            ));
        }
        texture_flags |= vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY;
    }
    let universal_family_index = context.get_universal_queue_family_index();
    let queue_family_indices = [queue_family_index, universal_family_index];
    let concurrent = request.sparse && queue_family_index != universal_family_index;
    let texture_usage = vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST;
    let properties = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            request.format,
            texture_image_type,
            vk::ImageTiling::OPTIMAL,
            texture_usage,
            texture_flags,
        )
    };
    let properties = match properties {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
            return Err(TestError::NotSupported(format!(
                "Format not supported: {:?}",
                request.format
            )));
        }
        other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties")?,
    };
    if request.sparse
        && !check_sparse_image_format_support_for(
            context.get_instance(),
            context.get_physical_device(),
            request.format,
            texture_image_type,
            vk::SampleCountFlags::_1,
            texture_usage,
            vk::ImageTiling::OPTIMAL,
        )
    {
        return Err(TestError::NotSupported(format!(
            "Sparse format not supported: {:?}",
            request.format
        )));
    }
    let mip_levels = request.texture.get_num_levels() as u32;
    if properties.max_mip_levels < mip_levels {
        return Err(TestError::NotSupported(
            "Maximum mimap level number for this format is not enough for this test.".to_string(),
        ));
    }
    if properties.max_extent.width < request.tex_width
        || properties.max_extent.height < request.tex_height
        || properties.max_extent.depth < texture_depth
    {
        return Err(TestError::NotSupported(
            "Maximum image dimension for this format is not enough for this test.".to_string(),
        ));
    }
    if properties.max_array_layers < texture_layers {
        return Err(TestError::NotSupported(
            "Maximum array layers number for this format is not enough for this test.".to_string(),
        ));
    }

    let texture_info = vk::ImageCreateInfo::builder()
        .flags(texture_flags)
        .image_type(texture_image_type)
        .format(request.format)
        .extent(vk::Extent3D {
            width: request.tex_width,
            height: request.tex_height,
            depth: texture_depth,
        })
        .mip_levels(mip_levels)
        .array_layers(texture_layers)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(texture_usage)
        .sharing_mode(if concurrent {
            vk::SharingMode::CONCURRENT
        } else {
            vk::SharingMode::EXCLUSIVE
        })
        .queue_family_indices(if concurrent { &queue_family_indices[..] } else { &[] })
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let stage = if request.use_compute {
        vk::PipelineStageFlags::COMPUTE_SHADER
    } else {
        vk::PipelineStageFlags::FRAGMENT_SHADER
    };
    let texture_image = if request.sparse {
        if !universal_queue_supports_sparse_binding(
            context.get_instance(),
            context.get_physical_device(),
            universal_family_index,
        ) {
            return Err(TestError::NotSupported(
                "The universal queue does not support sparse binding".to_string(),
            ));
        }
        let mut allocations = Vec::new();
        let image = Unique::new(
            device,
            unsafe { device.create_image(&texture_info, None) }.vk_check("vkCreateImage")?,
        );
        upload_test_texture_sparse(
            context,
            &texture_info,
            queue,
            queue_family_index,
            context.get_universal_queue(),
            &mut allocations,
            request.texture,
            *image,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            stage,
        )?;
        TextureImage::Sparse {
            image,
            _allocations: allocations,
        }
    } else {
        let image = ImageWithMemory::new(device, allocator, texture_info, MemoryRequirement::ANY)?;
        upload_test_texture(
            context,
            queue,
            queue_family_index,
            request.texture,
            image.get(),
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            stage,
        )?;
        TextureImage::Normal(image)
    };

    let (view_base_level, view_level_count) = request
        .view_levels
        .map_or((0, mip_levels), |(base, max)| (base, max - base + 1));
    let mut view_min_lod_info =
        vk::ImageViewMinLodCreateInfoEXT::builder().min_lod(request.view_min_lod.unwrap_or(0.0));
    let mut view_info = vk::ImageViewCreateInfo::builder()
        .image(texture_image.get())
        .view_type(texture_view_type)
        .format(request.format)
        .components(request.component_mapping)
        .subresource_range(make_image_subresource_range(
            request.aspect_mask,
            view_base_level,
            view_level_count,
            0,
            texture_layers,
        ));
    if request.view_min_lod.is_some() {
        view_info = view_info.push_next(&mut view_min_lod_info);
    }
    let texture_view = Unique::new(
        device,
        unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
    );

    // RenderBackend: the image rendered to, the uniform and result buffers
    let color_format = request.output_format;
    let color_usage = vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | if request.use_compute {
            vk::ImageUsageFlags::STORAGE
        } else {
            vk::ImageUsageFlags::COLOR_ATTACHMENT
        };
    match unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            color_format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            color_usage,
            vk::ImageCreateFlags::empty(),
        )
    } {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }
        other => {
            other.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        }
    }
    let color_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(color_format)
        .extent(vk::Extent3D {
            width: request.width,
            height: request.height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(color_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(device, allocator, color_info, MemoryRequirement::ANY)?;
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        color_format,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;

    let uniform_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(UNIFORM_BUFFER_SIZE, vk::BufferUsageFlags::UNIFORM_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let result_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            u64::from(request.width) * u64::from(request.height) * output_pixel_size(request.output_format),
            vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let sampler_params = request.sampler;
    let sampler_info = vk::SamplerCreateInfo::builder()
        .mag_filter(sampler_params.mag_filter)
        .min_filter(sampler_params.min_filter)
        .mipmap_mode(sampler_params.mipmap_mode)
        .address_mode_u(sampler_params.wrap_u)
        .address_mode_v(sampler_params.wrap_v)
        .address_mode_w(sampler_params.wrap_w)
        .mip_lod_bias(0.0)
        .anisotropy_enable(sampler_params.max_anisotropy.is_some())
        .max_anisotropy(sampler_params.max_anisotropy.unwrap_or(1.0))
        .compare_enable(sampler_params.compare_op.is_some())
        .compare_op(sampler_params.compare_op.unwrap_or(vk::CompareOp::ALWAYS))
        .min_lod(sampler_params.min_lod)
        .max_lod(sampler_params.max_lod)
        .border_color(sampler_params.border_color)
        .flags(if sampler_params.non_seamless {
            vk::SamplerCreateFlags::NON_SEAMLESS_CUBE_MAP_EXT
        } else {
            vk::SamplerCreateFlags::empty()
        })
        .unnormalized_coordinates(sampler_params.unnormalized);
    let sampler = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
    );

    Ok(Common {
        sampler,
        texture_view,
        texture_image,
        color_view,
        color_image,
        uniform_buffer,
        result_buffer,
        queue,
        queue_family_index,
    })
}

fn read_result(context: &Context<'_>, common: &Common<'_>, request: &RenderRequest<'_>) -> Result<Vec<u8>, TestError> {
    invalidate_alloc(context.get_device(), common.result_buffer.get_allocation())?;
    let size = request.width as usize * request.height as usize * output_pixel_size(request.output_format) as usize;
    Ok(unsafe { std::slice::from_raw_parts(common.result_buffer.get_allocation().get_host_ptr(), size) }.to_vec())
}

/// `TextureRenderer::renderQuad` for a 2D texture: the RGBA8 pixels of the quad, `width * height * 4` bytes.
pub fn render_quad_2d<'a>(
    context: &'a Context<'a>,
    request: &RenderRequest<'_>,
    binaries: BinaryCollection,
) -> Result<Vec<u8>, TestError> {
    let common = prepare(context, request)?;
    let outcome = if request.use_compute {
        render_compute(context, request, &common, binaries)
    } else {
        render_graphics(context, request, &common, binaries)
    };
    outcome?;
    read_result(context, &common, request)
}

fn render_graphics(
    context: &Context<'_>,
    request: &RenderRequest<'_>,
    common: &Common<'_>,
    binaries: BinaryCollection,
) -> Result<(), TestError> {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let (width, height) = (request.width, request.height);
    let name = request.program.name();

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
    let set_layout0 = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let set_layout1 = DescriptorSetLayoutBuilder::new()
        .add_single_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::FRAGMENT,
        )
        .build(device)?;
    let set0 = make_descriptor_set(device, *descriptor_pool, *set_layout0)?;
    let set1 = make_descriptor_set(device, *descriptor_pool, *set_layout1)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout0, *set_layout1])?;
    let render_pass = make_render_pass(device, request.output_format)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*common.color_view], width, height, 1)?;

    // Vertex index buffer and vertex buffer: four positions, then four texture coordinates, padded to a stride multiple
    let index_bytes: Vec<u8> = VERTEX_INDICES.iter().flat_map(|index| index.to_ne_bytes()).collect();
    let index_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(index_bytes.len() as u64, vk::BufferUsageFlags::INDEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    write_host(&index_buffer, device, &index_bytes)?;

    let position_data_size = (QUAD_POSITIONS.len() * 4) as u32;
    let tex_coord_components = (request.tex_coord.len() / 4) as u32;
    let texture_stride = tex_coord_components * 4;
    let tex_coord_format = if tex_coord_components == 1 {
        vk::Format::R32_SFLOAT
    } else if tex_coord_components == 4 {
        vk::Format::R32G32B32A32_SFLOAT
    } else if tex_coord_components == 3 {
        vk::Format::R32G32B32_SFLOAT
    } else {
        vk::Format::R32G32_SFLOAT
    };
    let mut vertex_bytes: Vec<u8> = request
        .positions
        .iter()
        .chain(request.tex_coord.iter())
        .flat_map(|value| value.to_ne_bytes())
        .collect();
    let padded_size = vertex_bytes.len() as u32 + texture_stride - (vertex_bytes.len() as u32 % texture_stride);
    vertex_bytes.resize(padded_size as usize, 0);
    let vertex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(vertex_bytes.len() as u64, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    write_host(&vertex_buffer, device, &vertex_bytes)?;

    write_host(
        &common.uniform_buffer,
        device,
        &uniform_bytes(&request.parameters, [0.0, 0.0]),
    )?;

    let uniform_info = make_descriptor_buffer_info(common.uniform_buffer.get(), 0, vk::WHOLE_SIZE);
    let image_info = vk::DescriptorImageInfo {
        sampler: *common.sampler,
        image_view: *common.texture_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    };
    let writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(*set0)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
            .buffer_info(std::slice::from_ref(&uniform_info))
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(*set1)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(std::slice::from_ref(&image_info))
            .build(),
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    let vertex_module = create_shader_module(device, binaries.get(&format!("vertex_{name}"))?)?;
    let fragment_module = create_shader_module(device, binaries.get(&format!("fragment_{name}"))?)?;
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
    state.bindings = vec![
        vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        },
        vk::VertexInputBindingDescription {
            binding: 1,
            stride: texture_stride,
            input_rate: vk::VertexInputRate::VERTEX,
        },
    ];
    state.attributes = vec![
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 1,
            format: tex_coord_format,
            offset: position_data_size,
        },
    ];
    state.viewports = vec![vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: width as f32,
        height: height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    state.scissors = vec![make_rect_2d(0, 0, width, height)];
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ],
        &state,
    )?;

    let command_pool = make_command_pool(device, common.queue_family_index)?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *command_buffer;
    begin_command_buffer(device, cmd)?;
    let initialize_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        common.color_image.get(),
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[initialize_barrier],
        );
    }
    begin_render_pass(
        device,
        cmd,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, width, height),
        clear_value_color([0.0, 0.0, 0.0, 1.0]),
    );
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[*set0, *set1],
            &[] as &[u32],
        );
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get(), vertex_buffer.get()], &[0, 0]);
        device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT16);
        device.cmd_draw_indexed(cmd, VERTEX_INDICES.len() as u32, 1, 0, 0, 0);
    }
    end_render_pass(device, cmd);
    copy_image_to_buffer(
        device,
        cmd,
        common.color_image.get(),
        common.result_buffer.get(),
        width,
        height,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, common.queue, cmd)
}

fn render_compute(
    context: &Context<'_>,
    request: &RenderRequest<'_>,
    common: &Common<'_>,
    binaries: BinaryCollection,
) -> Result<(), TestError> {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let (width, height) = (request.width, request.height);
    let name = request.program.name();

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::COMPUTE,
        )
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

    let set_layouts = [*set_layout];
    let push_range = [vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::COMPUTE,
        offset: 0,
        size: 8,
    }];
    let layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&push_range);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    // Geometry: four texture coordinates as vec4 (zero padded), then the four positions
    let mut geometry: Vec<f32> = Vec::with_capacity(32);
    let components = request.tex_coord.len() / 4;
    for vertex in 0..4 {
        for component in 0..4 {
            geometry.push(if component < components {
                request.tex_coord[vertex * components + component]
            } else {
                0.0
            });
        }
    }
    geometry.extend_from_slice(&request.positions);
    let geometry_bytes: Vec<u8> = geometry.iter().flat_map(|value| value.to_ne_bytes()).collect();
    let geometry_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(geometry_bytes.len() as u64, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    write_host(&geometry_buffer, device, &geometry_bytes)?;

    write_host(
        &common.uniform_buffer,
        device,
        &uniform_bytes(&request.parameters, [width as f32, height as f32]),
    )?;

    let uniform_info = make_descriptor_buffer_info(common.uniform_buffer.get(), 0, vk::WHOLE_SIZE);
    let sampler_info = vk::DescriptorImageInfo {
        sampler: *common.sampler,
        image_view: *common.texture_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    };
    let output_info = vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: *common.color_view,
        image_layout: vk::ImageLayout::GENERAL,
    };
    let geometry_info = make_descriptor_buffer_info(geometry_buffer.get(), 0, vk::WHOLE_SIZE);
    let writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
            .buffer_info(std::slice::from_ref(&uniform_info))
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(1)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(std::slice::from_ref(&sampler_info))
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(2)
            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
            .image_info(std::slice::from_ref(&output_info))
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(3)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(std::slice::from_ref(&geometry_info))
            .build(),
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    let compute_module = create_shader_module(device, binaries.get(&format!("compute_{name}"))?)?;
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*compute_module)
        .name(b"main\0");
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(*stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(0);
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    let command_pool = make_command_pool(device, common.queue_family_index)?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *command_buffer;
    begin_command_buffer(device, cmd)?;

    let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let initialize_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::SHADER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        common.color_image.get(),
        color_range,
    );
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        common.color_image.get(),
        color_range,
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    let offset = [0i32, 0i32];
    let offset_bytes: Vec<u8> = offset.iter().flat_map(|value| value.to_ne_bytes()).collect();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[initialize_barrier],
        );
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[*set],
            &[] as &[u32],
        );
        device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::COMPUTE, 0, &offset_bytes);
        device.cmd_dispatch(cmd, width.div_ceil(16), height.div_ceil(16), 1);
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            common.color_image.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            common.result_buffer.get(),
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, common.queue, cmd)
}

/// The RGBA8 pixels `render_quad_2d` returns as a `tcu::Surface`.
pub fn pixels_to_surface(pixels: &[u8], width: u32, height: u32) -> crate::tcu::Surface {
    let mut surface = crate::tcu::Surface::new(width as i32, height as i32);
    for y in 0..height {
        for x in 0..width {
            let offset = ((y * width + x) * 4) as usize;
            surface.set_pixel(
                x as i32,
                y as i32,
                crate::tcu::RGBA::new(
                    i32::from(pixels[offset]),
                    i32::from(pixels[offset + 1]),
                    i32::from(pixels[offset + 2]),
                    i32::from(pixels[offset + 3]),
                ),
            );
        }
    }
    surface
}

/// The `tcu::Texture2DView` of a test texture's levels, as the reference sampler wants it.
pub fn reference_texture_2d(texture: &TestTexture, width: u32, height: u32) -> crate::tcu::texture_2d::Texture2D {
    let mut reference = crate::tcu::texture_2d::Texture2D::new(texture.get_texture_format(), width, height);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        let source = texture.get_level(level, 0);
        let size = source.size();
        reference
            .level_mut(level)
            .copy_region_from(&source, (0, 0, 0), (0, 0, 0), (size[0], size[1], size[2]));
    }
    reference
}

/// The `tcu::Texture3DView` of a 3D test texture's levels, as the reference sampler wants it.
pub fn reference_texture_3d(
    texture: &TestTexture,
    width: u32,
    height: u32,
    depth: u32,
) -> crate::tcu::texture_3d::Texture3D {
    let mut reference = crate::tcu::texture_3d::Texture3D::new(texture.get_texture_format(), width, height, depth);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        let source = texture.get_level(level, 0);
        let size = source.size();
        reference
            .level_mut(level)
            .copy_region_from(&source, (0, 0, 0), (0, 0, 0), (size[0], size[1], size[2]));
    }
    reference
}

/// The `tcu::Texture2DArrayView` of a 2D array test texture's levels (all layers of a level are its depth), as the reference sampler wants it.
pub fn reference_texture_2d_array(
    texture: &TestTexture,
    width: u32,
    height: u32,
    layers: u32,
) -> crate::tcu::texture_2d_array::Texture2DArray {
    let mut reference =
        crate::tcu::texture_2d_array::Texture2DArray::new(texture.get_texture_format(), width, height, layers);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        let source = texture.level_all_layers(level);
        let size = source.size();
        reference
            .level_mut(level)
            .copy_region_from(&source, (0, 0, 0), (0, 0, 0), (size[0], size[1], size[2]));
    }
    reference
}

/// The `tcu::Texture1DView` of a 1D test texture, held as a `width x 1` 2D texture (the 2D lookups and verifiers see the same texels).
pub fn reference_texture_1d(texture: &TestTexture, width: u32) -> crate::tcu::texture_2d::Texture2D {
    reference_texture_2d(texture, width, 1)
}

/// The `tcu::Texture1DArrayView` of a 1D array test texture, held as a `width x 1 x layers` 2D array texture.
pub fn reference_texture_1d_array(
    texture: &TestTexture,
    width: u32,
    layers: u32,
) -> crate::tcu::texture_2d_array::Texture2DArray {
    let mut reference =
        crate::tcu::texture_2d_array::Texture2DArray::new(texture.get_texture_format(), width, 1, layers);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        let source = texture.level_as_layers(level);
        let size = source.size();
        reference
            .level_mut(level)
            .copy_region_from(&source, (0, 0, 0), (0, 0, 0), (size[0], size[1], size[2]));
    }
    reference
}

/// The `tcu::TextureCubeArrayView` of a cube array test texture (six depth slices per cube layer), held as a 2D array of `6 * cube_layers` layers.
pub fn reference_texture_cube_array(
    texture: &TestTexture,
    size: u32,
    cube_layers: u32,
) -> crate::tcu::texture_2d_array::Texture2DArray {
    reference_texture_2d_array(texture, size, size, cube_layers * 6)
}

/// The `tcu::TextureCubeView` of a cube test texture's levels (the six faces of a level are its depth), as the reference sampler wants it.
pub fn reference_texture_cube(texture: &TestTexture, size: u32) -> crate::tcu::texture_cube::TextureCube {
    let mut reference = crate::tcu::texture_cube::TextureCube::new(texture.get_texture_format(), size);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        let source = texture.level_all_layers(level);
        let sz = source.size();
        reference
            .level_mut(level)
            .copy_region_from(&source, (0, 0, 0), (0, 0, 0), (sz[0], sz[1], sz[2]));
    }
    reference
}

/// The stencil-only `TextureFormat` the reference textures of a stencil aspect lookup use (`getEffectiveDepthStencilAccess(.., MODE_STENCIL)`)
fn stencil_texture_format() -> crate::tcu::TextureFormat {
    crate::tcu::TextureFormat::new(crate::tcu::ChannelOrder::S, crate::tcu::ChannelType::UNSIGNED_INT8)
}

/// Copies the stencil aspect of a combined depth/stencil level texel by texel (the two layouts share no pitch, so no raw copy)
fn copy_stencil_level(
    source: &crate::tcu::pixel::ConstPixelBufferAccess<'_>,
    dest: &mut crate::tcu::pixel::PixelBufferAccess<'_>,
) {
    let [width, height, depth] = source.size();
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                dest.set_pix_stencil(source.get_pix_stencil(x, y, z), x, y, z);
            }
        }
    }
}

/// `reference_texture_2d` of the stencil aspect of a combined depth/stencil test texture
pub fn reference_texture_2d_stencil(
    texture: &TestTexture,
    width: u32,
    height: u32,
) -> crate::tcu::texture_2d::Texture2D {
    let mut reference = crate::tcu::texture_2d::Texture2D::new(stencil_texture_format(), width, height);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        copy_stencil_level(&texture.get_level(level, 0), &mut reference.level_mut(level));
    }
    reference
}

/// `reference_texture_3d` of the stencil aspect of a combined depth/stencil test texture
pub fn reference_texture_3d_stencil(
    texture: &TestTexture,
    width: u32,
    height: u32,
    depth: u32,
) -> crate::tcu::texture_3d::Texture3D {
    let mut reference = crate::tcu::texture_3d::Texture3D::new(stencil_texture_format(), width, height, depth);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        copy_stencil_level(&texture.get_level(level, 0), &mut reference.level_mut(level));
    }
    reference
}

/// `reference_texture_2d_array` of the stencil aspect of a combined depth/stencil test texture
pub fn reference_texture_2d_array_stencil(
    texture: &TestTexture,
    width: u32,
    height: u32,
    layers: u32,
) -> crate::tcu::texture_2d_array::Texture2DArray {
    let mut reference =
        crate::tcu::texture_2d_array::Texture2DArray::new(stencil_texture_format(), width, height, layers);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        copy_stencil_level(&texture.level_all_layers(level), &mut reference.level_mut(level));
    }
    reference
}

/// `reference_texture_cube` of the stencil aspect of a combined depth/stencil test texture
pub fn reference_texture_cube_stencil(texture: &TestTexture, size: u32) -> crate::tcu::texture_cube::TextureCube {
    let mut reference = crate::tcu::texture_cube::TextureCube::new(stencil_texture_format(), size);
    for level in 0..texture.get_num_levels() {
        reference.alloc_level(level);
        copy_stencil_level(&texture.level_all_layers(level), &mut reference.level_mut(level));
    }
    reference
}
