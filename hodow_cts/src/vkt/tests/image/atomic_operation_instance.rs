// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageAtomicOperationTests.cpp (BinaryAtomicInstanceBase, BinaryAtomicEndResultInstance, BinaryAtomicIntermValuesInstance)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two instance classes and the base they share are one struct here, told apart by `CheckType`
// (`prepareResources`, `prepareDescriptors`, `commandsBeforeCompute`, `commandsAfterCompute` and `verifyResult` are the same functions with a branch
// on it). The templated reference (`computeBinaryAtomicOperationResult<T>`, `getAtomicFuncArgument<T>`) is the trait `AtomicNum`; `Half` is `Half`
// and the `F16Vec2`/`F16Vec4` of the verification are one scalar check per channel, which is what the vector comparison reduces to because all the
// channels of an atomic argument and of an initial value are equal. A sparse backed image is bound on the universal queue
// (`allocate_and_bind_sparse_image`) and the submission waits on its bind semaphore, as upstream does with `Context::getSparseQueue`.

use vulkanalia::prelude::v1_0::*;

use super::atomic_operation_tests::{
    AtomicCaseParams, AtomicFormat, AtomicOperation, ImageBackingType, ShaderReadType,
};
use super::tests_util::{
    ImageType, get_layer_size, get_num_layers, get_num_pixels, get_shader_grid_size, map_image_type,
    map_image_view_type,
};
use crate::tcu::float::Float16;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::create_shader_module;
use crate::vk::ref_util::Unique;
use crate::vk::sparse_util::allocate_and_bind_sparse_image;
use crate::vkt::{Context, TestInstance};

const NUM_INVOCATIONS_PER_PIXEL: u32 = 5;

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum CheckType {
    EndResult,
    IntermediateValues,
}

fn operation_is_order_independent(op: AtomicOperation) -> bool {
    !matches!(op, AtomicOperation::Exchange | AtomicOperation::CompareExchange)
}

/// `getOperationInitialValue<int32_t>`; 18 is just an arbitrary small nonzero value
fn initial_value_i32(op: AtomicOperation) -> i32 {
    match op {
        AtomicOperation::Sub | AtomicOperation::Dec => (1 << 24) - 1,
        AtomicOperation::Min | AtomicOperation::And => (1 << 15) - 1,
        _ => 18,
    }
}

/// `getOperationInitialValue<int64_t>`; 0x000000BEFFFFFF18 is just an arbitrary nonzero value
fn initial_value_i64(op: AtomicOperation) -> i64 {
    match op {
        AtomicOperation::Sub | AtomicOperation::Dec => (1i64 << 56) - 1,
        AtomicOperation::Min | AtomicOperation::And => (1i64 << 47) - 1,
        _ => 0x0000_00BE_FFFF_FF18,
    }
}

/// The element types of the reference computation
trait AtomicNum: Copy + PartialEq {
    fn from_int(value: i32) -> Self;
    fn initial(op: AtomicOperation) -> Self;
    fn apply(op: AtomicOperation, a: Self, b: Self) -> Self;
    fn read(bytes: &[u8]) -> Self;
}

macro_rules! impl_atomic_num_32 {
    ($ty:ty) => {
        impl AtomicNum for $ty {
            fn from_int(value: i32) -> Self {
                value as $ty
            }

            fn initial(op: AtomicOperation) -> Self {
                initial_value_i32(op) as $ty
            }

            fn apply(op: AtomicOperation, a: Self, b: Self) -> Self {
                match op {
                    AtomicOperation::Inc | AtomicOperation::Add => a.wrapping_add(b),
                    AtomicOperation::Dec | AtomicOperation::Sub => a.wrapping_sub(b),
                    AtomicOperation::Min => a.min(b),
                    AtomicOperation::Max => a.max(b),
                    AtomicOperation::And => a & b,
                    AtomicOperation::Or => a | b,
                    AtomicOperation::Xor => a ^ b,
                    AtomicOperation::Exchange => b,
                    AtomicOperation::CompareExchange => {
                        if a == 18 as $ty {
                            b
                        } else {
                            a
                        }
                    }
                }
            }

            fn read(bytes: &[u8]) -> Self {
                <$ty>::from_ne_bytes(bytes[..4].try_into().expect("four bytes"))
            }
        }
    };
}

macro_rules! impl_atomic_num_64 {
    ($ty:ty) => {
        impl AtomicNum for $ty {
            fn from_int(value: i32) -> Self {
                i64::from(value) as $ty
            }

            fn initial(op: AtomicOperation) -> Self {
                initial_value_i64(op) as $ty
            }

            fn apply(op: AtomicOperation, a: Self, b: Self) -> Self {
                match op {
                    AtomicOperation::Inc | AtomicOperation::Add => a.wrapping_add(b),
                    AtomicOperation::Dec | AtomicOperation::Sub => a.wrapping_sub(b),
                    AtomicOperation::Min => a.min(b),
                    AtomicOperation::Max => a.max(b),
                    AtomicOperation::And => a & b,
                    AtomicOperation::Or => a | b,
                    AtomicOperation::Xor => a ^ b,
                    AtomicOperation::Exchange => b,
                    AtomicOperation::CompareExchange => {
                        if a == 0xBE_FFFF_FF18u64 as $ty {
                            b
                        } else {
                            a
                        }
                    }
                }
            }

            fn read(bytes: &[u8]) -> Self {
                <$ty>::from_ne_bytes(bytes[..8].try_into().expect("eight bytes"))
            }
        }
    };
}

impl_atomic_num_32!(u32);
impl_atomic_num_32!(i32);
impl_atomic_num_64!(u64);
impl_atomic_num_64!(i64);

/// `Half`, equal when the bits are
#[derive(Clone, Copy, PartialEq, Eq)]
struct Half(u16);

impl Half {
    fn create(value: f32) -> Self {
        Self(Float16::new(value).bits())
    }

    fn as_float(self) -> f32 {
        Float16::from_bits(self.0).as_float()
    }
}

impl AtomicNum for Half {
    fn from_int(value: i32) -> Self {
        Self::create(value as f32)
    }

    fn initial(op: AtomicOperation) -> Self {
        Self::from_int(initial_value_i32(op))
    }

    fn apply(op: AtomicOperation, a: Self, b: Self) -> Self {
        match op {
            AtomicOperation::Inc | AtomicOperation::Add => Self::create(a.as_float() + b.as_float()),
            AtomicOperation::Dec | AtomicOperation::Sub => Self::create(a.as_float() - b.as_float()),
            AtomicOperation::Min => {
                if a.as_float() <= b.as_float() {
                    a
                } else {
                    b
                }
            }
            AtomicOperation::Max => {
                if a.as_float() >= b.as_float() {
                    a
                } else {
                    b
                }
            }
            AtomicOperation::Exchange => b,
            _ => a,
        }
    }

    fn read(bytes: &[u8]) -> Self {
        Self(u16::from_ne_bytes(bytes[..2].try_into().expect("two bytes")))
    }
}

/// `getAtomicFuncArgument<T>`
fn atomic_func_argument<T: AtomicNum>(format: AtomicFormat, op: AtomicOperation, gid: [i32; 3], grid: [i32; 3]) -> T {
    let [x, y, z] = gid;
    let half = format.is_half();

    let ret = match op {
        AtomicOperation::Add
        | AtomicOperation::Sub
        | AtomicOperation::And
        | AtomicOperation::Or
        | AtomicOperation::Xor => {
            if half {
                x + 2 * y + 3 * z
            } else {
                x * x + y * y + z * z
            }
        }
        AtomicOperation::Inc | AtomicOperation::Dec => 1,
        AtomicOperation::Min | AtomicOperation::Max => {
            // multiply half of the data by -1
            if half {
                (1 - 2 * (x % 2)) * (x + 2 * y + 3 * z)
            } else {
                (1 - 2 * (x % 2)) * (x * x + y * y + z * z)
            }
        }
        AtomicOperation::Exchange | AtomicOperation::CompareExchange => {
            if half {
                // Only use values exactly representable with 10-bit mantissa.
                ((z * grid[0] + x) * grid[1] + y) % 1024
            } else {
                (z * grid[0] + x) * grid[1] + y
            }
        }
    };
    T::from_int(ret)
}

impl AtomicFormat {
    fn pixel_size(self) -> u32 {
        match self {
            Self::R32Uint | Self::R32Sint | Self::R32Float | Self::Rg16Float => 4,
            Self::R64Uint | Self::R64Sint | Self::Rgba16Float => 8,
        }
    }

    fn is_half(self) -> bool {
        matches!(self, Self::Rg16Float | Self::Rgba16Float)
    }

    fn is_64bit(self) -> bool {
        matches!(self, Self::R64Uint | Self::R64Sint)
    }

    fn half_channels(self) -> usize {
        if self == Self::Rg16Float { 2 } else { 4 }
    }
}

/// `getUsageFlags`
fn usage_flags(use_transfer: bool) -> vk::ImageUsageFlags {
    let mut usage = vk::ImageUsageFlags::STORAGE;
    if use_transfer {
        usage |= vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    }
    usage
}

/// The dispatch size of the `readShader` runs: `factor` times the layer width, the layers where the type has them
fn read_dispatch_size(image_type: ImageType, layer_size: [u32; 3], layer_count: u32, factor: u32) -> [u32; 3] {
    match image_type {
        ImageType::OneDArray => [factor * layer_size[0], layer_count, layer_size[2]],
        ImageType::TwoDArray | ImageType::Cube | ImageType::CubeArray => {
            [factor * layer_size[0], layer_size[1], layer_count]
        }
        _ => [factor * layer_size[0], layer_size[1], layer_size[2]],
    }
}

fn compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0");
    let info = vk::ComputePipelineCreateInfo::builder().stage(*stage).layout(layout);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn buffer_memory_barrier_whole(
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    buffer: vk::Buffer,
    size: vk::DeviceSize,
) -> vk::BufferMemoryBarrier {
    make_buffer_memory_barrier(src_access, dst_access, buffer, 0, size)
}

/// The image of `createImageAndView`: a plain one, or a sparse one whose memory is bound by `allocate_and_bind_sparse_image`
enum AtomicImage<'a> {
    Normal(ImageWithMemory<'a>),
    // The image is declared first so it is destroyed before its memory is freed.
    Sparse {
        image: Unique<'a, vk::Image>,
        _allocations: Vec<Allocation<'a>>,
    },
}

impl AtomicImage<'_> {
    fn get(&self) -> vk::Image {
        match self {
            Self::Normal(image) => image.get(),
            Self::Sparse { image, .. } => **image,
        }
    }
}

/// An image of the case with its view (`createImageAndView`); a sparse image also has the semaphore its bind signals
struct ImageAndView<'a> {
    image: AtomicImage<'a>,
    view: Unique<'a, vk::ImageView>,
    bind_semaphore: Option<Unique<'a, vk::Semaphore>>,
}

pub(super) struct BinaryAtomicInstance<'a> {
    pub(super) context: &'a Context<'a>,
    pub(super) params: AtomicCaseParams,
    pub(super) check: CheckType,
}

impl<'a> BinaryAtomicInstance<'a> {
    fn num_layers(&self) -> u32 {
        get_num_layers(self.params.image_type, self.params.image_size)
    }

    fn create_image_and_view(&self, image_extent: [u32; 3], use_transfer: bool) -> Result<ImageAndView<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let p = &self.params;
        let mut create_flags = vk::ImageCreateFlags::empty();
        if p.image_type == ImageType::Cube || p.image_type == ImageType::CubeArray {
            create_flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }
        let num_layers = self.num_layers();

        let info = vk::ImageCreateInfo::builder()
            .flags(create_flags)
            .image_type(map_image_type(p.image_type))
            .format(p.format.vk())
            .extent(vk::Extent3D {
                width: image_extent[0],
                height: image_extent[1],
                depth: image_extent[2],
            })
            .mip_levels(1)
            .array_layers(num_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(p.tiling)
            .usage(usage_flags(use_transfer))
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let (image, bind_semaphore) = if p.backing_type == ImageBackingType::Sparse {
            let mut sparse_info = info;
            sparse_info.flags |= vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY;
            let image = Unique::new(
                device,
                unsafe { device.create_image(&sparse_info, None) }.vk_check("vkCreateImage")?,
            );
            let semaphore = Unique::new(
                device,
                unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                    .vk_check("vkCreateSemaphore")?,
            );
            let tcu_format = map_vk_format(p.format.vk())
                .ok_or_else(|| TestError::NotPorted(format!("tcu format of {:?}", p.format.vk())))?;
            let mut allocations = Vec::new();
            allocate_and_bind_sparse_image(
                device,
                context.get_instance(),
                context.get_physical_device(),
                &sparse_info,
                *semaphore,
                context.get_universal_queue(),
                context.get_default_allocator(),
                &mut allocations,
                tcu_format,
                *image,
                vk::Fence::null(),
            )?;
            (
                AtomicImage::Sparse {
                    image,
                    _allocations: allocations,
                },
                Some(semaphore),
            )
        } else {
            (
                AtomicImage::Normal(ImageWithMemory::new(
                    device,
                    context.get_default_allocator(),
                    info,
                    MemoryRequirement::ANY,
                )?),
                None,
            )
        };

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
        let view_type = map_image_view_type(p.image_type)
            .ok_or_else(|| TestError::InternalError("an image view of a texel buffer case".to_string()))?;
        let view = make_image_view(device, image.get(), view_type, p.format.vk(), subresource_range)?;
        Ok(ImageAndView {
            image,
            view,
            bind_semaphore,
        })
    }

    /// `initDataForImage`
    fn init_data_for_image(&self, grid_size: [u32; 3], buffer: &BufferWithMemory<'_>) -> Result<(), TestError> {
        let device = self.context.get_device();
        let allocation = buffer.get_allocation();
        let host_ptr = allocation.get_host_ptr();
        let op = self.params.operation;
        let format = self.params.format;

        let texel: Vec<u8> = match format {
            AtomicFormat::R64Uint | AtomicFormat::R64Sint => initial_value_i64(op).to_ne_bytes().to_vec(),
            AtomicFormat::R32Uint => (initial_value_i32(op) as u32).to_ne_bytes().to_vec(),
            AtomicFormat::R32Sint => initial_value_i32(op).to_ne_bytes().to_vec(),
            AtomicFormat::R32Float => (initial_value_i32(op) as f32).to_ne_bytes().to_vec(),
            AtomicFormat::Rg16Float | AtomicFormat::Rgba16Float => {
                let channel = Float16::new(initial_value_i32(op) as f32).bits().to_ne_bytes();
                (0..format.half_channels()).flat_map(|_| channel).collect()
            }
        };

        let texel_count = (grid_size[0] * grid_size[1] * grid_size[2]) as usize;
        for i in 0..texel_count {
            unsafe { std::ptr::copy_nonoverlapping(texel.as_ptr(), host_ptr.add(i * texel.len()), texel.len()) };
        }

        flush_alloc(device, allocation)
    }

    fn output_buffer_size(&self) -> u32 {
        let p = &self.params;
        let size = p.format.pixel_size() * get_num_pixels(p.image_type, p.image_size);
        match self.check {
            CheckType::EndResult => size,
            CheckType::IntermediateValues => NUM_INVOCATIONS_PER_PIXEL * size,
        }
    }

    /// `copyBufferToImage` of vktImageTestsUtil with the image left in GENERAL
    fn copy_buffer_to_image(&self, cmd_buffer: vk::CommandBuffer, buffer: vk::Buffer, image: vk::Image) {
        let device = self.context.get_device();
        let p = &self.params;
        let num_layers = self.num_layers();
        let layer_size = get_layer_size(p.image_type, p.image_size);
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
        let pre_copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image,
            range,
        );
        let post_copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            image,
            range,
        );
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: layer_size[0],
                height: layer_size[1],
                depth: layer_size[2],
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_layers),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_copy_barrier],
            );
            device.cmd_copy_buffer_to_image(
                cmd_buffer,
                buffer,
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[region],
            );
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_copy_barrier],
            );
        }
    }

    /// The two descriptor writes of a fill or read run: a storage image at binding 0 and a storage buffer at binding 1
    fn write_image_and_buffer(
        &self,
        set: vk::DescriptorSet,
        image_view: vk::ImageView,
        buffer: vk::Buffer,
        range: vk::DeviceSize,
    ) {
        let image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let buffer_info = [make_descriptor_buffer_info(buffer, 0, range)];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&image_info),
            vk::WriteDescriptorSet::builder()
                .dst_set(set)
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_info),
        ];
        unsafe {
            self.context
                .get_device()
                .update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet])
        };
    }

    /// `shaderFillImage`
    #[allow(clippy::too_many_arguments)]
    fn shader_fill_image(
        &self,
        cmd_buffer: vk::CommandBuffer,
        result_image: &ImageAndView<'_>,
        buffer: vk::Buffer,
        pipeline: vk::Pipeline,
        pipeline_layout: vk::PipelineLayout,
        descriptor_set: vk::DescriptorSet,
        range: vk::DeviceSize,
        grid_size: [u32; 3],
    ) {
        let device = self.context.get_device();
        self.write_image_and_buffer(descriptor_set, *result_image.view, buffer, range);

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, self.num_layers());
        let image_barrier_pre = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            result_image.image.get(),
            subresource_range,
        );
        let image_barrier_post = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            result_image.image.get(),
            subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier_pre],
            );
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                pipeline_layout,
                0,
                &[descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd_buffer, grid_size[0], grid_size[1], grid_size[2]);
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier_post],
            );
        }
    }

    /// `commandsAfterCompute` for an image: copy it to the output buffer or read it with the `readShader`.
    /// `image` is the result image of an end result check and the intermediate values image of the other.
    #[allow(clippy::too_many_arguments)]
    fn commands_after_compute_image(
        &self,
        cmd_buffer: vk::CommandBuffer,
        image: &ImageAndView<'_>,
        output_buffer: vk::Buffer,
        pipeline: vk::Pipeline,
        pipeline_layout: vk::PipelineLayout,
        descriptor_set: vk::DescriptorSet,
        range: vk::DeviceSize,
        use_transfer: bool,
    ) {
        let device = self.context.get_device();
        let p = &self.params;
        let num_layers = self.num_layers();
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
        let layer_size = get_layer_size(p.image_type, p.image_size);
        let factor = match self.check {
            CheckType::EndResult => 1,
            CheckType::IntermediateValues => NUM_INVOCATIONS_PER_PIXEL,
        };

        if use_transfer {
            let post_dispatch_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.image.get(),
                subresource_range,
            );
            let copy_extent = vk::Extent3D {
                width: factor * layer_size[0],
                height: layer_size[1],
                depth: layer_size[2],
            };
            let region = make_buffer_image_copy(
                copy_extent,
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_layers),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_dispatch_barrier],
                );
                device.cmd_copy_image_to_buffer(
                    cmd_buffer,
                    image.image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    output_buffer,
                    &[region],
                );
            }
        } else {
            self.write_image_and_buffer(descriptor_set, *image.view, output_buffer, range);

            let post_dispatch_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                image.image.get(),
                subresource_range,
            );
            let size = read_dispatch_size(p.image_type, layer_size, num_layers, factor);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_dispatch_barrier],
                );
                device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    pipeline_layout,
                    0,
                    &[descriptor_set],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd_buffer, size[0], size[1], size[2]);
            }
        }
    }

    /// `verifyResult` of `BinaryAtomicEndResultInstance`
    fn verify_end_result(&self, data: &[u8]) -> bool {
        let p = &self.params;
        let grid = get_shader_grid_size(p.image_type, p.image_size);
        let grid_i = [grid[0] as i32, grid[1] as i32, grid[2] as i32];
        let extended = [NUM_INVOCATIONS_PER_PIXEL as i32 * grid_i[0], grid_i[1], grid_i[2]];
        let pixel_size = p.format.pixel_size() as usize;

        for z in 0..grid_i[2] {
            for y in 0..grid_i[1] {
                for x in 0..grid_i[0] {
                    let offset = (((z * grid_i[1] + y) * grid_i[0] + x) as usize) * pixel_size;
                    let texel = &data[offset..offset + pixel_size];
                    let ok = if operation_is_order_independent(p.operation) {
                        match p.format {
                            AtomicFormat::R32Uint => {
                                self.is_value_correct(u32::read(texel), [x, y, z], grid_i, extended)
                            }
                            AtomicFormat::R32Sint => {
                                self.is_value_correct(i32::read(texel), [x, y, z], grid_i, extended)
                            }
                            AtomicFormat::R64Uint => {
                                self.is_value_correct(u64::read(texel), [x, y, z], grid_i, extended)
                            }
                            AtomicFormat::R64Sint => {
                                self.is_value_correct(i64::read(texel), [x, y, z], grid_i, extended)
                            }
                            AtomicFormat::R32Float => {
                                let as_int = f32::from_bits(u32::read(texel)) as i32;
                                self.is_value_correct(as_int, [x, y, z], grid_i, extended)
                            }
                            AtomicFormat::Rg16Float | AtomicFormat::Rgba16Float => {
                                (0..p.format.half_channels()).all(|c| {
                                    self.is_value_correct(Half::read(&texel[2 * c..]), [x, y, z], grid_i, extended)
                                })
                            }
                        }
                    } else {
                        self.exchange_matches(texel, [x, y, z], grid_i, extended)
                    };
                    if !ok {
                        return false;
                    }
                }
            }
        }
        true
    }

    /// The exchange and compare exchange branches of `verifyResult`: the end result has to equal one of the atomic arguments
    fn exchange_matches(&self, texel: &[u8], at: [i32; 3], grid: [i32; 3], extended: [i32; 3]) -> bool {
        let p = &self.params;
        let gids: Vec<[i32; 3]> = (0..NUM_INVOCATIONS_PER_PIXEL as i32)
            .map(|i| [at[0] + i * grid[0], at[1], at[2]])
            .collect();

        if p.format.is_half() {
            return (0..p.format.half_channels()).all(|c| {
                let result = Half::read(&texel[2 * c..]);
                gids.iter()
                    .any(|&gid| result == atomic_func_argument::<Half>(p.format, p.operation, gid, extended))
            });
        }

        gids.iter().any(|&gid| {
            if p.format.is_64bit() {
                i64::read(texel) == atomic_func_argument::<i64>(p.format, p.operation, gid, extended)
            } else if p.format == AtomicFormat::R32Float {
                let as_int = f32::from_bits(u32::read(texel)) as i32;
                as_int == atomic_func_argument::<i32>(p.format, p.operation, gid, extended)
            } else {
                i32::read(texel) == atomic_func_argument::<i32>(p.format, p.operation, gid, extended)
            }
        })
    }

    /// `BinaryAtomicEndResultInstance::isValueCorrect`
    fn is_value_correct<T: AtomicNum>(
        &self,
        result_value: T,
        at: [i32; 3],
        grid: [i32; 3],
        extended: [i32; 3],
    ) -> bool {
        let p = &self.params;
        let mut reference = T::initial(p.operation);
        for i in 0..NUM_INVOCATIONS_PER_PIXEL as i32 {
            let gid = [at[0] + i * grid[0], at[1], at[2]];
            let arg: T = atomic_func_argument(p.format, p.operation, gid, extended);
            reference = T::apply(p.operation, reference, arg);
        }
        result_value == reference
    }

    /// `verifyResult` of `BinaryAtomicIntermValuesInstance`
    fn verify_intermediate_values(&self, data: &[u8]) -> bool {
        let p = &self.params;
        let grid = get_shader_grid_size(p.image_type, p.image_size);
        let grid_i = [grid[0] as i32, grid[1] as i32, grid[2] as i32];
        let extended = [NUM_INVOCATIONS_PER_PIXEL as i32 * grid_i[0], grid_i[1], grid_i[2]];

        for z in 0..extended[2] {
            for y in 0..extended[1] {
                for x in 0..grid_i[0] {
                    let ok = match p.format {
                        AtomicFormat::R32Uint => {
                            self.are_values_correct::<u32>(data, false, [x, y, z], grid_i, extended)
                        }
                        AtomicFormat::R32Sint => {
                            self.are_values_correct::<i32>(data, false, [x, y, z], grid_i, extended)
                        }
                        AtomicFormat::R64Uint => {
                            self.are_values_correct::<u64>(data, false, [x, y, z], grid_i, extended)
                        }
                        AtomicFormat::R64Sint => {
                            self.are_values_correct::<i64>(data, false, [x, y, z], grid_i, extended)
                        }
                        AtomicFormat::R32Float => {
                            self.are_values_correct::<i32>(data, true, [x, y, z], grid_i, extended)
                        }
                        AtomicFormat::Rg16Float | AtomicFormat::Rgba16Float => {
                            self.are_values_correct_vector(data, [x, y, z], grid_i, extended)
                        }
                    };
                    if !ok {
                        return false;
                    }
                }
            }
        }
        true
    }

    fn texel_at<'d>(&self, data: &'d [u8], gid: [i32; 3], extended: [i32; 3]) -> &'d [u8] {
        let pixel_size = self.params.format.pixel_size() as usize;
        let offset = (((gid[2] * extended[1] + gid[1]) * extended[0] + gid[0]) as usize) * pixel_size;
        &data[offset..offset + pixel_size]
    }

    /// `areValuesCorrect<T>`
    fn are_values_correct<T: AtomicNum>(
        &self,
        data: &[u8],
        is_floating_point: bool,
        at: [i32; 3],
        grid: [i32; 3],
        extended: [i32; 3],
    ) -> bool {
        let p = &self.params;
        let mut result_values = [T::from_int(0); NUM_INVOCATIONS_PER_PIXEL as usize];
        let mut atomic_args = result_values;

        for i in 0..NUM_INVOCATIONS_PER_PIXEL as usize {
            let gid = [at[0] + i as i32 * grid[0], at[1], at[2]];
            let texel = self.texel_at(data, gid, extended);
            result_values[i] = if is_floating_point {
                let as_float = f32::from_bits(u32::read(texel));
                T::from_int(as_float as i32)
            } else {
                T::read(texel)
            };
            atomic_args[i] = atomic_func_argument(p.format, p.operation, gid, extended);
        }

        let mut args_used = [false; NUM_INVOCATIONS_PER_PIXEL as usize];
        self.verify_recursive(0, T::initial(p.operation), &mut args_used, &atomic_args, &result_values)
    }

    /// `areValuesCorrectVector<F16Vec2/F16Vec4>`
    fn are_values_correct_vector(&self, data: &[u8], at: [i32; 3], grid: [i32; 3], extended: [i32; 3]) -> bool {
        let p = &self.params;
        let mut all_match = true;

        for c in 0..p.format.half_channels() {
            let mut result_values = [Half(0); NUM_INVOCATIONS_PER_PIXEL as usize];
            let mut atomic_args = result_values;
            for i in 0..NUM_INVOCATIONS_PER_PIXEL as usize {
                let gid = [at[0] + i as i32 * grid[0], at[1], at[2]];
                let texel = self.texel_at(data, gid, extended);
                result_values[i] = Half::read(&texel[2 * c..]);
                atomic_args[i] = atomic_func_argument(p.format, p.operation, gid, extended);
            }

            let mut args_used = [false; NUM_INVOCATIONS_PER_PIXEL as usize];
            all_match = all_match
                && self.verify_recursive(
                    0,
                    Half::initial(p.operation),
                    &mut args_used,
                    &atomic_args,
                    &result_values,
                );
        }
        all_match
    }

    /// `verifyRecursive`
    fn verify_recursive<T: AtomicNum>(
        &self,
        index: usize,
        value_so_far: T,
        args_used: &mut [bool; NUM_INVOCATIONS_PER_PIXEL as usize],
        atomic_args: &[T; NUM_INVOCATIONS_PER_PIXEL as usize],
        result_values: &[T; NUM_INVOCATIONS_PER_PIXEL as usize],
    ) -> bool {
        if index >= NUM_INVOCATIONS_PER_PIXEL as usize {
            return true;
        }

        for i in 0..NUM_INVOCATIONS_PER_PIXEL as usize {
            if !args_used[i] && result_values[i] == value_so_far {
                args_used[i] = true;

                if self.verify_recursive(
                    index + 1,
                    T::apply(self.params.operation, value_so_far, atomic_args[i]),
                    args_used,
                    atomic_args,
                    result_values,
                ) {
                    return true;
                }

                args_used[i] = false;
            }
        }

        false
    }
}

impl TestInstance for BinaryAtomicInstance<'_> {
    /// `BinaryAtomicInstanceBase::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();
        let p = self.params;

        let image_size_in_bytes =
            vk::DeviceSize::from(p.format.pixel_size() * get_num_pixels(p.image_type, p.image_size));
        let out_buff_size_in_bytes = vk::DeviceSize::from(self.output_buffer_size());
        let is_texel_buffer = p.image_type == ImageType::Buffer;
        let layer_size = get_layer_size(p.image_type, p.image_size);
        let grid_size = get_shader_grid_size(p.image_type, p.image_size);
        let num_layers = self.num_layers();
        let is_intermediate = self.check == CheckType::IntermediateValues;

        let result_image = if is_texel_buffer {
            None
        } else {
            Some(self.create_image_and_view(layer_size, p.use_transfer)?)
        };

        let texel_usage = if is_texel_buffer {
            vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
        } else {
            vk::BufferUsageFlags::empty()
        };

        // Prepare the buffer with the initial data for the image
        let input_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                image_size_in_bytes,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::STORAGE_BUFFER | texel_usage,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        self.init_data_for_image(grid_size, &input_buffer)?;

        // A buffer to store shader output copied from the result image
        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                out_buff_size_in_bytes,
                vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::STORAGE_BUFFER | texel_usage,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // prepareResources: the intermediate values image
        let interm_image = if !is_texel_buffer && is_intermediate {
            let is_cube_based = p.image_type == ImageType::Cube || p.image_type == ImageType::CubeArray;
            let extended_layer_size = if is_cube_based {
                [
                    NUM_INVOCATIONS_PER_PIXEL * layer_size[0],
                    NUM_INVOCATIONS_PER_PIXEL * layer_size[1],
                    layer_size[2],
                ]
            } else {
                [NUM_INVOCATIONS_PER_PIXEL * layer_size[0], layer_size[1], layer_size[2]]
            };
            Some(self.create_image_and_view(extended_layer_size, p.use_transfer)?)
        } else {
            None
        };

        // prepareDescriptors
        let descriptor_type = if is_texel_buffer {
            vk::DescriptorType::STORAGE_TEXEL_BUFFER
        } else {
            vk::DescriptorType::STORAGE_IMAGE
        };
        let comp_stage = vk::ShaderStageFlags::COMPUTE;
        let binding_count = if is_intermediate { 2 } else { 1 };
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..binding_count {
            layout_builder = layout_builder.add_single_binding(descriptor_type, comp_stage);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(descriptor_type, binding_count)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let make_buffer_view = |buffer: &BufferWithMemory<'_>| -> Result<Unique<'_, vk::BufferView>, TestError> {
            let info = vk::BufferViewCreateInfo::builder()
                .buffer(buffer.get())
                .format(p.format.vk())
                .offset(0)
                .range(vk::WHOLE_SIZE);
            Ok(Unique::new(
                device,
                unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?,
            ))
        };
        let result_buffer_view;
        let interm_buffer_view;
        if is_texel_buffer {
            result_buffer_view = Some(make_buffer_view(&input_buffer)?);
            let views = [result_buffer_view.as_ref().map(|view| **view).unwrap_or_default()];
            let mut writes = vec![
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(0)
                    .descriptor_type(descriptor_type)
                    .texel_buffer_view(&views),
            ];
            let interm_views;
            if is_intermediate {
                interm_buffer_view = Some(make_buffer_view(&output_buffer)?);
                interm_views = [interm_buffer_view.as_ref().map(|view| **view).unwrap_or_default()];
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(*descriptor_set)
                        .dst_binding(1)
                        .descriptor_type(descriptor_type)
                        .texel_buffer_view(&interm_views),
                );
            }
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        } else if let Some(result_image) = &result_image {
            let mut infos = vec![vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *result_image.view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            if let Some(interm_image) = &interm_image {
                infos.push(vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: *interm_image.view,
                    image_layout: vk::ImageLayout::GENERAL,
                });
            }
            let writes: Vec<_> = (0..infos.len())
                .map(|i| {
                    vk::WriteDescriptorSet::builder()
                        .dst_set(*descriptor_set)
                        .dst_binding(i as u32)
                        .descriptor_type(descriptor_type)
                        .image_info(&infos[i..=i])
                })
                .collect();
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // The fill and read shaders of the cases that go through the shader instead of the transfer queue
        let no_transfer_layout;
        let no_transfer_pool;
        let mut descriptor_set_fill = None;
        let mut descriptor_set_read = None;
        let mut fill_pipeline_layout = None;
        let mut fill_pipeline = None;
        let mut read_pipeline = None;
        let fill_module;
        let read_module;
        if !p.use_transfer {
            no_transfer_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(descriptor_type, comp_stage)
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, comp_stage)
                .build(device)?;
            no_transfer_pool = DescriptorPoolBuilder::new()
                .add_type(descriptor_type, 2)
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
            descriptor_set_fill = Some(make_descriptor_set(device, *no_transfer_pool, *no_transfer_layout)?);
            descriptor_set_read = Some(make_descriptor_set(device, *no_transfer_pool, *no_transfer_layout)?);

            fill_module = create_shader_module(device, context.get_binary_collection().get("fillShader")?)?;
            let layout = make_pipeline_layout(device, &[*no_transfer_layout])?;
            fill_pipeline = Some(compute_pipeline(device, *layout, *fill_module)?);

            let read_name = if p.read_type == ShaderReadType::Sparse {
                "readShaderResidency"
            } else {
                "readShader"
            };
            read_module = create_shader_module(device, context.get_binary_collection().get(read_name)?)?;
            read_pipeline = Some(compute_pipeline(device, *layout, *read_module)?);
            fill_pipeline_layout = Some(layout);
        }

        // Create pipeline
        let test_shader_name = if is_intermediate {
            "intermediate_values"
        } else {
            "end_result"
        };
        let shader_module = create_shader_module(device, context.get_binary_collection().get(test_shader_name)?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = compute_pipeline(device, *pipeline_layout, *shader_module)?;

        // Create command buffer
        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *command_buffer;

        begin_command_buffer(device, cmd_buffer)?;

        if let Some(result_image) = &result_image {
            if p.use_transfer {
                self.copy_buffer_to_image(cmd_buffer, input_buffer.get(), result_image.image.get());
            } else if let (Some(set), Some(layout), Some(fill)) =
                (&descriptor_set_fill, &fill_pipeline_layout, &fill_pipeline)
            {
                self.shader_fill_image(
                    cmd_buffer,
                    result_image,
                    input_buffer.get(),
                    **fill,
                    **layout,
                    **set,
                    image_size_in_bytes,
                    grid_size,
                );
            }

            // commandsBeforeCompute
            if let Some(interm_image) = &interm_image {
                let barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    interm_image.image.get(),
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[barrier],
                    );
                }
            }
        }

        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(
                cmd_buffer,
                NUM_INVOCATIONS_PER_PIXEL * grid_size[0],
                grid_size[1],
                grid_size[2],
            );
        }

        // commandsAfterCompute. A texel buffer of an end result check is read back from the buffer the shader wrote.
        let end_result_in_input = is_texel_buffer && !is_intermediate;
        if !is_texel_buffer {
            let image = if is_intermediate {
                interm_image.as_ref()
            } else {
                result_image.as_ref()
            };
            if let (Some(image), Some(layout), Some(read), Some(set)) =
                (image, &fill_pipeline_layout, &read_pipeline, &descriptor_set_read)
            {
                self.commands_after_compute_image(
                    cmd_buffer,
                    image,
                    output_buffer.get(),
                    **read,
                    **layout,
                    **set,
                    out_buff_size_in_bytes,
                    false,
                );
            } else if let Some(image) = image {
                self.commands_after_compute_image(
                    cmd_buffer,
                    image,
                    output_buffer.get(),
                    vk::Pipeline::null(),
                    vk::PipelineLayout::null(),
                    vk::DescriptorSet::null(),
                    out_buff_size_in_bytes,
                    true,
                );
            }
        }

        let (host_read_buffer, host_read_size) = if end_result_in_input {
            (&input_buffer, image_size_in_bytes)
        } else {
            (&output_buffer, out_buff_size_in_bytes)
        };
        let transfer_like = p.use_transfer || is_texel_buffer;
        let output_buffer_pre_host_read_barrier = buffer_memory_barrier_whole(
            if transfer_like {
                vk::AccessFlags::TRANSFER_WRITE
            } else {
                vk::AccessFlags::SHADER_WRITE
            },
            vk::AccessFlags::HOST_READ,
            host_read_buffer.get(),
            host_read_size,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                if transfer_like {
                    vk::PipelineStageFlags::TRANSFER
                } else {
                    vk::PipelineStageFlags::COMPUTE_SHADER
                },
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[output_buffer_pre_host_read_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd_buffer)?;
        let wait_semaphores: Vec<vk::Semaphore> = result_image
            .iter()
            .chain(interm_image.iter())
            .filter_map(|image| image.bind_semaphore.as_ref().map(|semaphore| **semaphore))
            .collect();
        if wait_semaphores.is_empty() {
            submit_commands_and_wait(device, queue, cmd_buffer)?;
        } else {
            let wait_stages = vec![vk::PipelineStageFlags::TOP_OF_PIPE; wait_semaphores.len()];
            let cmd_buffers = [cmd_buffer];
            let fence = Unique::new(
                device,
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            let submit_info = vk::SubmitInfo::builder()
                .wait_semaphores(&wait_semaphores)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(&cmd_buffers);
            unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
            unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        }

        let output_allocation = host_read_buffer.get_allocation();
        invalidate_alloc(device, output_allocation)?;
        let data = unsafe {
            std::slice::from_raw_parts(output_allocation.get_host_ptr().cast_const(), host_read_size as usize)
        };

        let correct = match self.check {
            CheckType::EndResult => self.verify_end_result(data),
            CheckType::IntermediateValues => self.verify_intermediate_values(data),
        };
        if correct {
            Ok(TestStatus::pass("Comparison succeeded"))
        } else {
            Ok(TestStatus::fail("Comparison failed"))
        }
    }
}
