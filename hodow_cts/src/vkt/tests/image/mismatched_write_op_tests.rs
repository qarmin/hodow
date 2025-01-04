// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageMismatchedWriteOpTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The SPIR-V assembly of `initPrograms` is specialized by
// scripts/gen_image_mismatched_write_op_manifest.py into shaders/manifest/image_mismatched_write_op.toml, one program per
// (kind, SPIR-V format, variant). The variant is the width of the vector written, or for the signedness cases the position
// of the compared format in its channel class, which decides the image height. The sparse image flavour of `StorageImage2D`
// is not used by any case upstream and is left out.

use std::cell::Cell;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::image_mismatched_write_op::ALL_MISMATCHED_WRITE_OP_PROGRAMS;
use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, clear, clear_int, get_texture_format_bit_depth};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EPSILON_FLOAT: f32 = 0.0005;

/// `MismatchedWriteOpPrograms` - the `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct MismatchedWriteOpPrograms {
    pub name: &'static str,
    pub kind: &'static str,
    pub spirv_format: &'static str,
    pub variant: u32,
    pub programs: BinaryCollection,
}

/// `allFormats`, each with its `getSpirvFormat`
const ALL_FORMATS: [(vk::Format, &str); 41] = [
    (vk::Format::R32G32B32A32_SFLOAT, "Rgba32f"),
    (vk::Format::R32G32_SFLOAT, "Rg32f"),
    (vk::Format::R32_SFLOAT, "R32f"),
    (vk::Format::R16G16B16A16_SFLOAT, "Rgba16f"),
    (vk::Format::R16G16_SFLOAT, "Rg16f"),
    (vk::Format::R16_SFLOAT, "R16f"),
    (vk::Format::R16G16B16A16_UNORM, "Rgba16"),
    (vk::Format::R16G16_UNORM, "Rg16"),
    (vk::Format::R16_UNORM, "R16"),
    (vk::Format::R16G16B16A16_SNORM, "Rgba16Snorm"),
    (vk::Format::R16G16_SNORM, "Rg16Snorm"),
    (vk::Format::R16_SNORM, "R16Snorm"),
    (vk::Format::A2B10G10R10_UNORM_PACK32, "Rgb10A2"),
    (vk::Format::B10G11R11_UFLOAT_PACK32, "R11fG11fB10f"),
    (vk::Format::R8G8B8A8_UNORM, "Rgba8"),
    (vk::Format::R8G8_UNORM, "Rg8"),
    (vk::Format::R8_UNORM, "R8"),
    (vk::Format::R8G8B8A8_SNORM, "Rgba8Snorm"),
    (vk::Format::R8G8_SNORM, "Rg8Snorm"),
    (vk::Format::R8_SNORM, "R8Snorm"),
    (vk::Format::R32G32B32A32_SINT, "Rgba32i"),
    (vk::Format::R32G32_SINT, "Rg32i"),
    (vk::Format::R32_SINT, "R32i"),
    (vk::Format::R16G16B16A16_SINT, "Rgba16i"),
    (vk::Format::R16G16_SINT, "Rg16i"),
    (vk::Format::R16_SINT, "R16i"),
    (vk::Format::R8G8B8A8_SINT, "Rgba8i"),
    (vk::Format::R8G8_SINT, "Rg8i"),
    (vk::Format::R8_SINT, "R8i"),
    (vk::Format::R32G32B32A32_UINT, "Rgba32ui"),
    (vk::Format::R32G32_UINT, "Rg32ui"),
    (vk::Format::R32_UINT, "R32ui"),
    (vk::Format::R16G16B16A16_UINT, "Rgba16ui"),
    (vk::Format::R16G16_UINT, "Rg16ui"),
    (vk::Format::R16_UINT, "R16ui"),
    (vk::Format::A2B10G10R10_UINT_PACK32, "Rgb10a2ui"),
    (vk::Format::R8G8B8A8_UINT, "Rgba8ui"),
    (vk::Format::R8G8_UINT, "Rg8ui"),
    (vk::Format::R8_UINT, "R8ui"),
    (vk::Format::R64_SINT, "R64i"),
    (vk::Format::R64_UINT, "R64ui"),
];

const LARGEST_WIDTH: u32 = 5;

/// `getSpirvFormat`
fn get_spirv_format(format: vk::Format) -> &'static str {
    ALL_FORMATS
        .iter()
        .find(|(f, _)| *f == format)
        .map(|(_, name)| *name)
        .expect("format of allFormats")
}

fn tex_format(format: vk::Format) -> TextureFormat {
    map_vk_format(format).expect("format of allFormats has a tcu format")
}

/// `is64BitIntegerFormat`
fn is_64_bit_integer_format(format: vk::Format) -> bool {
    matches!(
        tex_format(format).type_,
        ChannelType::UNSIGNED_INT64 | ChannelType::SIGNED_INT64
    )
}

/// `findFormatsByChannelClass`
fn find_formats_by_channel_class(channel_class: TextureChannelClass) -> Vec<vk::Format> {
    let result: Vec<vk::Format> = ALL_FORMATS
        .iter()
        .map(|(f, _)| *f)
        .filter(|f| tex_format(*f).channel_class() == channel_class)
        .collect();
    assert!(!result.is_empty());
    result
}

/// `getChannelStr` of `makeBufferFormat(channelClass, doubled).type`
fn buffer_channel_type(channel_class: TextureChannelClass, doubled: bool) -> ChannelType {
    match channel_class {
        TextureChannelClass::SignedInteger => {
            if doubled {
                ChannelType::SIGNED_INT64
            } else {
                ChannelType::SIGNED_INT32
            }
        }
        TextureChannelClass::UnsignedInteger => {
            if doubled {
                ChannelType::UNSIGNED_INT64
            } else {
                ChannelType::UNSIGNED_INT32
            }
        }
        _ => {
            if doubled {
                ChannelType::FLOAT64
            } else {
                ChannelType::FLOAT
            }
        }
    }
}

/// `makeBufferFormat`
fn make_buffer_format(channel_class: TextureChannelClass, doubled: bool) -> TextureFormat {
    TextureFormat::new(ChannelOrder::RGBA, buffer_channel_type(channel_class, doubled))
}

fn int_min_value32(num_bits: i32) -> i32 {
    if num_bits >= 32 {
        i32::MIN
    } else {
        -(1i32 << (num_bits - 1))
    }
}

fn int_max_value32(num_bits: i32) -> i32 {
    if num_bits >= 32 {
        i32::MAX
    } else {
        (1i32 << (num_bits - 1)) - 1
    }
}

fn uint_max_value32(num_bits: i32) -> u32 {
    if num_bits >= 32 {
        u32::MAX
    } else {
        (1u32 << num_bits) - 1
    }
}

/// `ut::StorageBuffer2D`
struct StorageBuffer2D<'a> {
    format: TextureFormat,
    width: u32,
    height: u32,
    buffer_size: vk::DeviceSize,
    buffer: BufferWithMemory<'a>,
    context: &'a Context<'a>,
}

impl<'a> StorageBuffer2D<'a> {
    fn new(context: &'a Context<'a>, format: TextureFormat, width: u32, height: u32) -> Result<Self, TestError> {
        let pixel_size = format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {format:?}")))?;
        let buffer_size = vk::DeviceSize::from(width) * vk::DeviceSize::from(height) * vk::DeviceSize::from(pixel_size);
        let buffer_usage_flags = vk::BufferUsageFlags::STORAGE_BUFFER
            | vk::BufferUsageFlags::TRANSFER_SRC
            | vk::BufferUsageFlags::TRANSFER_DST;

        let buffer = BufferWithMemory::new(
            context.get_device(),
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, buffer_usage_flags),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        Ok(Self {
            format,
            width,
            height,
            buffer_size,
            buffer,
            context,
        })
    }

    fn get_buffer(&self) -> vk::Buffer {
        self.buffer.get()
    }

    fn get_size(&self) -> vk::DeviceSize {
        self.buffer_size
    }

    /// `getPixelAccess` - a view over the mapped memory of the buffer
    fn get_pixel_access(&self) -> PixelBufferAccess<'_> {
        let data = unsafe {
            std::slice::from_raw_parts_mut(self.buffer.get_allocation().get_host_ptr(), self.buffer_size as usize)
        };
        PixelBufferAccess::new(self.format, [self.width, self.height, 1], data)
    }

    fn flush(&self) -> Result<(), TestError> {
        flush_alloc(self.context.get_device(), self.buffer.get_allocation())
    }

    fn invalidate(&self) -> Result<(), TestError> {
        invalidate_alloc(self.context.get_device(), self.buffer.get_allocation())
    }
}

/// `ut::StorageImage2D`
struct StorageImage2D<'a> {
    context: &'a Context<'a>,
    width: u32,
    height: u32,
    buffer: StorageBuffer2D<'a>,
    layout: Cell<vk::ImageLayout>,
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
}

impl<'a> StorageImage2D<'a> {
    fn new(context: &'a Context<'a>, vk_format: vk::Format, width: u32, height: u32) -> Result<Self, TestError> {
        let vki = context.get_device();
        let tex = tex_format(vk_format);
        let buffer = StorageBuffer2D::new(context, tex, width, height)?;

        // Create an image
        let image_usage_flags =
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

        let image_create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: vk_format,
            extent: vk::Extent3D {
                width,
                height,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: image_usage_flags,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        let image = ImageWithMemory::new(
            vki,
            context.get_default_allocator(),
            image_create_info,
            MemoryRequirement::ANY,
        )?;

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let view = make_image_view(vki, image.get(), vk::ImageViewType::_2D, vk_format, subresource_range)?;

        Ok(Self {
            context,
            width,
            height,
            buffer,
            layout: Cell::new(vk::ImageLayout::UNDEFINED),
            image,
            view,
        })
    }

    fn get_view(&self) -> vk::ImageView {
        *self.view
    }

    fn get_pixel_access(&self) -> PixelBufferAccess<'_> {
        self.buffer.get_pixel_access()
    }

    fn flush(&self) -> Result<(), TestError> {
        self.buffer.flush()
    }

    fn invalidate(&self) -> Result<(), TestError> {
        self.buffer.invalidate()
    }

    fn upload(&self, cmd_buffer: vk::CommandBuffer) {
        let vki = self.context.get_device();
        let full_image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: self.width,
                height: self.height,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );

        {
            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                self.buffer.get_buffer(),
                0,
                self.buffer.get_size(),
            );

            let before_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                self.layout.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.image.get(),
                full_image_subresource_range,
            );

            unsafe {
                vki.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[before_copy_barrier],
                );
            }
        }

        unsafe {
            vki.cmd_copy_buffer_to_image(
                cmd_buffer,
                self.buffer.get_buffer(),
                self.image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy_region],
            )
        };

        {
            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_READ,
                vk::AccessFlags::empty(),
                self.buffer.get_buffer(),
                0,
                self.buffer.get_size(),
            );

            self.layout.set(vk::ImageLayout::GENERAL);
            let after_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.layout.get(),
                self.image.get(),
                full_image_subresource_range,
            );

            unsafe {
                vki.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[after_copy_barrier],
                );
            }
        }
    }

    fn download(&self, cmd_buffer: vk::CommandBuffer) {
        let vki = self.context.get_device();
        let full_image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: self.width,
                height: self.height,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );

        {
            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                self.buffer.get_buffer(),
                0,
                self.buffer.get_size(),
            );

            let before_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                self.layout.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.image.get(),
                full_image_subresource_range,
            );

            unsafe {
                vki.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[before_copy_barrier],
                );
            }
        }

        unsafe {
            vki.cmd_copy_image_to_buffer(
                cmd_buffer,
                self.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.buffer.get_buffer(),
                &[copy_region],
            )
        };

        {
            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                self.buffer.get_buffer(),
                0,
                self.buffer.get_size(),
            );

            let after_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_READ,
                vk::AccessFlags::empty(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.layout.get(),
                self.image.get(),
                full_image_subresource_range,
            );

            unsafe {
                vki.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[after_copy_barrier],
                );
            }
        }
    }
}

/// `ut::gluePixels`
fn glue_pixels(a: [f32; 4], b: [f32; 4], pivot: usize) -> [f32; 4] {
    let mut result = [0.0f32; 4];
    result[..pivot].copy_from_slice(&a[..pivot]);
    result[pivot..].copy_from_slice(&b[pivot..]);
    result
}

/// `ut::comparePixels` over integer vectors, whose epsilon is zero
fn compare_pixels_exact<T: PartialEq + Copy>(res: [T; 4], reference: [T; 4], target_width: usize) -> bool {
    (0..target_width).all(|i| res[i] == reference[i])
}

/// `ut::comparePixels` over `tcu::Vec4`
fn compare_pixels_float(res: [f32; 4], reference: [f32; 4], target_width: usize, eps: f32) -> bool {
    (0..target_width).all(|i| (res[i].max(reference[i]) - res[i].min(reference[i])) <= eps)
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestKind {
    /// `MismatchedVectorSizesTest`, with the width of the vector written
    VectorSizes { source_width: u32 },
    /// `MismatchedSignednessAndTypeTest`, with the position of the compared format in its channel class
    SignednessAndType { index: u32 },
}

/// `MismatchedWriteOpTest::Params`
#[derive(Clone, Copy)]
struct Params {
    vk_format: vk::Format,
    texture_width: u32,
    texture_height: u32,
    #[allow(dead_code)]
    spirv_format: vk::Format,
}

struct MismatchedWriteOpTest {
    name: String,
    params: Params,
    kind: TestKind,
}

impl MismatchedWriteOpTest {
    /// `getBufferFormat`
    fn get_buffer_format(&self) -> TextureFormat {
        let tex = tex_format(self.params.vk_format);
        make_buffer_format(tex.channel_class(), is_64_bit_integer_format(self.params.vk_format))
    }
}

impl TestCase for MismatchedWriteOpTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // capabilities that may be used in the shader
        if is_64_bit_integer_format(self.params.vk_format) {
            if context.get_device_features().shader_int64 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Device feature shaderInt64 is not supported".to_string(),
                ));
            }
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;
        }

        // extensions used statically in the shader
        context.require_device_functionality("VK_KHR_variable_pointers")?;
        context.require_device_functionality("VK_KHR_storage_buffer_storage_class")?;

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.params.vk_format)
        };

        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Creating storage image with this format is not supported".to_string(),
            ));
        }

        if !format_properties
            .optimal_tiling_features
            .intersects(vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST)
        {
            return Err(TestError::NotSupported(
                "Format is not supported for transfer".to_string(),
            ));
        }

        if let TestKind::VectorSizes { source_width: 5 } = self.kind {
            let mut long_vector = vk::PhysicalDeviceShaderLongVectorFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut long_vector);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if long_vector.long_vector == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Device feature longVector is not supported".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let (kind, variant) = match self.kind {
            TestKind::VectorSizes { source_width } => ("vector_sizes", source_width),
            TestKind::SignednessAndType { index } => ("signedness", index),
        };
        let spirv_format = get_spirv_format(self.params.vk_format);
        ALL_MISMATCHED_WRITE_OP_PROGRAMS
            .iter()
            .find(|p| p.kind == kind && p.spirv_format == spirv_format && p.variant == variant)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MismatchedWriteOpTestInstance { context, test: self })
    }
}

struct MismatchedWriteOpTestInstance<'a> {
    context: &'a Context<'a>,
    test: &'a MismatchedWriteOpTest,
}

impl MismatchedWriteOpTestInstance<'_> {
    /// `clear`
    fn clear(&self, pixels: &mut PixelBufferAccess<'_>) -> Result<(), TestError> {
        let channel_class = tex_format(self.test.params.vk_format).channel_class();
        match channel_class {
            TextureChannelClass::SignedInteger => {
                if !clear_int(pixels, [-1, -2, -3, -4]) {
                    return Err(TestError::NotPorted(
                        "tcu::clear on this signed integer format".to_string(),
                    ));
                }
            }
            TextureChannelClass::UnsignedInteger => {
                if !clear_int(pixels, [1, 2, 3, 4]) {
                    return Err(TestError::NotPorted(
                        "tcu::clear on this unsigned integer format".to_string(),
                    ));
                }
            }
            _ => clear(pixels, [0.2, 0.3, 0.4, 0.5]),
        }
        Ok(())
    }

    /// `populate`
    fn populate(&self, pixels: &mut PixelBufferAccess<'_>) -> Result<(), TestError> {
        let params = &self.test.params;
        let tex = tex_format(params.vk_format);
        let bit_depth = get_texture_format_bit_depth(tex);
        let channel_class = tex.channel_class();
        let num_used_channels = tex.order.num_used_channels() as usize;

        let signed_min_values: [i32; 4] = std::array::from_fn(|i| {
            if bit_depth[i] != 0 {
                int_min_value32(bit_depth[i].min(32))
            } else {
                -1
            }
        });
        let signed_max_values: [i32; 4] = std::array::from_fn(|i| {
            if bit_depth[i] != 0 {
                int_max_value32(bit_depth[i].min(32))
            } else {
                1
            }
        });
        let unsigned_min_values = [0u32; 4];
        let unsigned_max_values: [u32; 4] = std::array::from_fn(|i| {
            if bit_depth[i] != 0 {
                uint_max_value32(bit_depth[i].min(32))
            } else {
                1
            }
        });

        const STEPS: [i64; 4] = [2, 3, 5, 7];
        let next_signed = |color: &mut [i32; 4]| {
            for i in 0..4 {
                color[i] = if i64::from(color[i]) + STEPS[i] < i64::from(signed_max_values[i]) {
                    color[i].wrapping_add(STEPS[i] as i32)
                } else {
                    signed_min_values[i]
                };
            }
        };
        let next_unsigned = |color: &mut [u32; 4]| {
            for i in 0..4 {
                color[i] = if u64::from(color[i].wrapping_add(STEPS[i] as u32)) < u64::from(unsigned_max_values[i]) {
                    color[i].wrapping_add(STEPS[i] as u32)
                } else {
                    unsigned_min_values[i]
                };
            }
        };

        let mut floats_data = [0u8; 32];
        let mut floats_access = PixelBufferAccess::new(tex, [1, 1, 1], &mut floats_data);

        let divider = params.texture_height as f32;
        let ufloat_step = [
            1.0 / (divider * 1.0),
            1.0 / (divider * 2.0),
            1.0 / (divider * 3.0),
            1.0 / (divider * 5.0),
        ];
        let sfloat_step = [
            2.0 / (divider * 1.0),
            2.0 / (divider * 2.0),
            2.0 / (divider * 3.0),
            2.0 / (divider * 5.0),
        ];

        let mut signed_color = [0i32; 4];
        let mut unsigned_color = [0u32; 4];
        let mut ufloat_color = [0.0f32; 4];
        let mut sfloat_color = [-1.0f32; 4];

        for y in 0..params.texture_height {
            for x in 0..params.texture_width {
                match channel_class {
                    TextureChannelClass::SignedInteger => {
                        if !pixels.set_pixel_int(signed_color, x, y, 0) {
                            return Err(TestError::NotPorted(
                                "setPixel(IVec4) on this signed integer format".to_string(),
                            ));
                        }
                    }
                    TextureChannelClass::UnsignedInteger => {
                        if !pixels.set_pixel_int(unsigned_color.map(|v| v as i32), x, y, 0) {
                            return Err(TestError::NotPorted(
                                "setPixel(UVec4) on this unsigned integer format".to_string(),
                            ));
                        }
                    }
                    TextureChannelClass::SignedFixedPoint => {
                        floats_access.set_pixel(sfloat_color, 0, 0, 0);
                        let tmp_floats = glue_pixels(
                            floats_access.as_const().get_pixel(0, 0, 0),
                            sfloat_color,
                            num_used_channels,
                        );
                        pixels.set_pixel(tmp_floats, x, y, 0);
                    }
                    // TEXTURECHANNELCLASS_FLOATING_POINT or TEXTURECHANNELCLASS_UNSIGNED_FIXED_POINT
                    _ => {
                        floats_access.set_pixel(ufloat_color, 0, 0, 0);
                        let tmp_floats = glue_pixels(
                            floats_access.as_const().get_pixel(0, 0, 0),
                            ufloat_color,
                            num_used_channels,
                        );
                        pixels.set_pixel(tmp_floats, x, y, 0);
                    }
                }
            }

            next_signed(&mut signed_color);
            next_unsigned(&mut unsigned_color);
            for i in 0..4 {
                sfloat_color[i] += sfloat_step[i];
                ufloat_color[i] += ufloat_step[i];
            }
        }

        Ok(())
    }

    /// `MismatchedVectorSizesTestInstance::compare` and `MismatchedSignednessAndTypeTestInstance::compare`
    fn compare(&self, result: &ConstPixelBufferAccess<'_>, reference: &ConstPixelBufferAccess<'_>) -> bool {
        match self.test.kind {
            TestKind::SignednessAndType { .. } => true,
            TestKind::VectorSizes { .. } => {
                let params = &self.test.params;
                let tex = tex_format(params.vk_format);
                let channel_class = tex.channel_class();
                let target_width = tex.order.num_used_channels() as usize;

                for y in 0..params.texture_height {
                    for x in 0..params.texture_width {
                        let ok = match channel_class {
                            TextureChannelClass::SignedInteger => compare_pixels_exact(
                                result.get_pixel_int(x, y, 0),
                                reference.get_pixel_int(x, y, 0),
                                target_width,
                            ),
                            TextureChannelClass::UnsignedInteger => compare_pixels_exact(
                                result.get_pixel_uint(x, y, 0),
                                reference.get_pixel_uint(x, y, 0),
                                target_width,
                            ),
                            _ => compare_pixels_float(
                                result.get_pixel(x, y, 0),
                                reference.get_pixel(x, y, 0),
                                target_width,
                                EPSILON_FLOAT,
                            ),
                        };
                        if !ok {
                            return false;
                        }
                    }
                }

                true
            }
        }
    }
}

impl TestInstance for MismatchedWriteOpTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vki = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let params = self.test.params;

        let cmd_pool = make_command_pool(vki, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vki, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vki)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vki, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vki, *descriptor_pool, *descriptor_set_layout)?;

        let mut pipeline = ComputePipelineWrapper::new(
            vki,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let image = StorageImage2D::new(
            self.context,
            params.vk_format,
            params.texture_width,
            params.texture_height,
        )?;
        let buffer = StorageBuffer2D::new(
            self.context,
            self.test.get_buffer_format(),
            params.texture_width,
            params.texture_height,
        )?;

        let input_image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: image.get_view(),
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let output_buffer_info = [make_descriptor_buffer_info(buffer.get_buffer(), 0, buffer.get_size())];

        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&input_image_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&output_buffer_info)
                .build(),
        ];
        unsafe { vki.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        self.populate(&mut buffer.get_pixel_access())?;
        self.clear(&mut image.get_pixel_access())?;

        begin_command_buffer(vki, cmd)?;
        image.upload(cmd);
        pipeline.bind(cmd);
        unsafe {
            vki.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[*descriptor_set],
                &[],
            );
            vki.cmd_dispatch(cmd, params.texture_width, params.texture_height, 1);
        }
        image.download(cmd);
        end_command_buffer(vki, cmd)?;

        image.flush()?;
        buffer.flush()?;

        submit_commands_and_wait(vki, queue, cmd)?;

        image.invalidate()?;
        buffer.invalidate()?;

        let result_access = image.get_pixel_access();
        let reference_access = buffer.get_pixel_access();
        if self.compare(&result_access.as_const(), &reference_access.as_const()) {
            Ok(TestStatus::pass(""))
        } else {
            Ok(TestStatus::fail("Pixel comparison failed"))
        }
    }
}

/// `createImageWriteOpTests`
pub fn create_image_write_op_tests() -> TestCaseGroup {
    let gen_vector_sizes_test_name = |f: vk::Format, source_width: u32| -> String {
        let mut name = format!("{}_from", get_spirv_format(f).to_lowercase());
        if source_width > 1 {
            name.push_str(&format!("_vec{source_width}"));
        } else {
            name.push_str("_scalar");
        }
        name
    };

    // Test image OpImageWrite operation in various aspects.
    let mut test_group = TestCaseGroup::new("mismatched_write_op");
    // Case OpImageWrite operation on mismatched vector sizes.
    let mut test_group_mismatched_vector_sizes = TestCaseGroup::new("mismatched_vector_sizes");
    let mut test_group_mismatched_signedness = TestCaseGroup::new("mismatched_signedness_and_type");

    for &(f, spirv_f) in &ALL_FORMATS {
        let switch_class = tex_format(f).channel_class();
        let compatible_formats = find_formats_by_channel_class(switch_class);

        for (index, &i) in compatible_formats.iter().enumerate() {
            if is_64_bit_integer_format(i) || is_64_bit_integer_format(f) {
                continue;
            }

            let test_name = format!("{}_from_{}", get_spirv_format(i).to_lowercase(), spirv_f.to_lowercase());
            let params = Params {
                vk_format: f,
                texture_width: 12,
                texture_height: 8 * (index as u32 + 1),
                spirv_format: i,
            };
            test_group_mismatched_signedness.add_child(Box::new(MismatchedWriteOpTest {
                name: test_name,
                params,
                kind: TestKind::SignednessAndType { index: index as u32 },
            }) as Box<dyn TestCase>);
        }

        for source_width in (1..=LARGEST_WIDTH).rev() {
            if source_width >= tex_format(f).order.num_used_channels() {
                let params = Params {
                    vk_format: f,
                    texture_width: 12 * source_width,
                    texture_height: 8 * (6 - source_width + 1),
                    spirv_format: f,
                };
                test_group_mismatched_vector_sizes.add_child(Box::new(MismatchedWriteOpTest {
                    name: gen_vector_sizes_test_name(f, source_width),
                    params,
                    kind: TestKind::VectorSizes { source_width },
                }) as Box<dyn TestCase>);
            }
        }
    }

    test_group.add_child(test_group_mismatched_vector_sizes);
    test_group.add_child(test_group_mismatched_signedness);

    test_group
}
