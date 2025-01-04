// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorTestsUtil.cpp
//   external/vulkancts/framework/vulkan/vkTensorUtil.cpp
//   external/vulkancts/framework/vulkan/vkTensorMemoryUtil.hpp
//   external/vulkancts/framework/vulkan/vkTensorWithMemory.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `StridedMemoryUtils<T>` is byte based with an `ElementKind` instead of a template parameter, and the tensor
// memory is never host mapped (the allocator is asked for `MemoryRequirement::ANY`), so upload, download and clear always take upstream's staging buffer path.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ArmTensorsExtensionDeviceCommands, ArmTensorsExtensionInstanceCommands, DeviceV1_3};

use super::required_formats_tests::get_tensor_format_properties;
use super::required_tests::{get_tensor_physical_device_features, get_tensor_physical_device_properties};
use crate::tcu::{TestError, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier,
};
use crate::vk::{Unique, VkResultExt};
use crate::vkt::Context;

#[derive(Clone, Debug)]
pub(super) struct TensorParameters {
    pub format: vk::Format,
    pub tiling: vk::TensorTilingARM,
    pub dimensions: Vec<i64>,
    pub strides: Vec<i64>,
}

impl TensorParameters {
    pub fn new(format: vk::Format, tiling: vk::TensorTilingARM, dimensions: &[i64], strides: &[i64]) -> Self {
        Self {
            format,
            tiling,
            dimensions: dimensions.to_vec(),
            strides: strides.to_vec(),
        }
    }

    pub fn rank(&self) -> u32 {
        self.dimensions.len() as u32
    }

    pub fn elements(&self) -> u64 {
        self.dimensions.iter().product::<i64>() as u64
    }

    /// The size required to store all the tensor elements
    pub fn host_data_size(&self) -> u64 {
        self.elements() * get_format_size(self.format)
    }

    pub fn packed(&self) -> bool {
        if self.tiling == vk::TensorTilingARM::LINEAR && !self.strides.is_empty() {
            let packed_strides = get_tensor_strides(&self.dimensions, get_format_size(self.format), 1);
            return self.strides == packed_strides;
        }
        true
    }
}

/// `getFormatSize`
pub(super) fn get_format_size(format: vk::Format) -> u64 {
    match format {
        vk::Format::R64_UINT | vk::Format::R64_SINT | vk::Format::R64_SFLOAT => 8,
        vk::Format::R32_SFLOAT | vk::Format::R32_UINT | vk::Format::R32_SINT => 4,
        vk::Format::R16_UNORM
        | vk::Format::R16_SNORM
        | vk::Format::R16_USCALED
        | vk::Format::R16_SSCALED
        | vk::Format::R16_UINT
        | vk::Format::R16_SINT
        | vk::Format::R16_SFLOAT
        | vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM => 2,
        vk::Format::R8_UNORM
        | vk::Format::R8_SNORM
        | vk::Format::R8_USCALED
        | vk::Format::R8_SSCALED
        | vk::Format::R8_UINT
        | vk::Format::R8_SINT
        | vk::Format::R8_SRGB
        | vk::Format::R8_BOOL_ARM
        | vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM
        | vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM => 1,
        _ => panic!("unsupported tensor format {format:?}"),
    }
}

/// `vk::getTensorStrides`
pub(super) fn get_tensor_strides(dimensions: &[i64], format_size: u64, multiplier: i64) -> Vec<i64> {
    assert!(!dimensions.is_empty());
    let mut strides = Vec::new();
    for dim_idx in 0..dimensions.len() - 1 {
        strides.push(
            multiplier
                * dimensions[dim_idx + 1..]
                    .iter()
                    .fold(format_size as i64, |acc, &d| acc * d),
        );
    }
    strides.push(format_size as i64);
    strides
}

/// `tensorFormatShortName`
pub(super) fn tensor_format_short_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R64_UINT => "R64_UINT",
        vk::Format::R64_SINT => "R64_SINT",
        vk::Format::R64_SFLOAT => "R64_SFLOAT",
        vk::Format::R32_UINT => "R32_UINT",
        vk::Format::R32_SINT => "R32_SINT",
        vk::Format::R32_SFLOAT => "R32_SFLOAT",
        vk::Format::R16_UINT => "R16_UINT",
        vk::Format::R16_SINT => "R16_SINT",
        vk::Format::R16_SFLOAT => "R16_SFLOAT",
        vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM => "R16_SFLOAT_FPENCODING_BFLOAT16",
        vk::Format::R8_UINT => "R8_UINT",
        vk::Format::R8_SINT => "R8_SINT",
        vk::Format::R8_BOOL_ARM => "R8_BOOL",
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM => "R8_SFLOAT_FPENCODING_FLOAT8E5M2",
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM => "R8_SFLOAT_FPENCODING_FLOAT8E4M3",
        _ => panic!("unsupported tensor format {format:?}"),
    }
}

/// `tensorTilingShortName`
pub(super) fn tensor_tiling_short_name(tiling: vk::TensorTilingARM) -> &'static str {
    if tiling == vk::TensorTilingARM::LINEAR {
        "linear"
    } else {
        "optimal"
    }
}

fn print_list(list: &[i64]) -> String {
    list.iter().map(i64::to_string).collect::<Vec<_>>().join("_")
}

/// `paramsToString(const TensorParameters &)`
pub(super) fn params_to_string(params: &TensorParameters) -> String {
    let mut name = format!(
        "{}_{}",
        tensor_format_short_name(params.format),
        tensor_tiling_short_name(params.tiling)
    );
    if !params.dimensions.is_empty() {
        name.push_str("_shape_");
        name.push_str(&print_list(&params.dimensions));
        if !params.strides.is_empty() {
            name.push_str("_strides_");
            name.push_str(&print_list(&params.strides));
        }
    } else {
        name.push_str("_max_rank");
    }
    name
}

/// `formatSupportTensorFlags`
pub(super) fn format_support_tensor_flags(
    context: &Context<'_>,
    format: vk::Format,
    tiling: vk::TensorTilingARM,
    flags: vk::FormatFeatureFlags2,
) -> bool {
    let props = get_tensor_format_properties(context, format);
    if tiling == vk::TensorTilingARM::OPTIMAL {
        props.optimal_tiling_tensor_features & flags == flags
    } else {
        props.linear_tiling_tensor_features & flags == flags
    }
}

/// `requireTensorShapeSupported`
pub(super) fn require_tensor_shape_supported(
    context: &Context<'_>,
    parameters: &TensorParameters,
) -> Result<(), TestError> {
    let props = get_tensor_physical_device_properties(context);

    if parameters.rank() > props.max_tensor_dimension_count {
        return Err(TestError::NotSupported(
            "Tensor dimension count is higher than device limit".to_string(),
        ));
    }

    for &dimension_size in &parameters.dimensions {
        if dimension_size as u64 > u64::from(props.max_per_dimension_tensor_elements) {
            return Err(TestError::NotSupported(
                "Tensor dimension element count is higher than device limit".to_string(),
            ));
        }
    }

    if parameters.elements() > props.max_tensor_elements {
        return Err(TestError::NotSupported(
            "Tensor element count is higher than device limit".to_string(),
        ));
    }

    if parameters.strides.is_empty() {
        if parameters.host_data_size() > props.max_tensor_size {
            return Err(TestError::NotSupported(
                "Tensor size in bytes is higher than device limit".to_string(),
            ));
        }
    } else {
        assert!(parameters.strides[0] > 0 && parameters.dimensions[0] > 0);
        if (parameters.strides[0] * parameters.dimensions[0]) as u64 > props.max_tensor_size {
            return Err(TestError::NotSupported(
                "Tensor size in bytes is higher than device limit".to_string(),
            ));
        }
    }

    for &stride_size in &parameters.strides {
        if stride_size > props.max_tensor_stride {
            return Err(TestError::NotSupported(
                "Tensor stride is higher than device limit".to_string(),
            ));
        }
    }

    Ok(())
}

/// `deviceSupportsNonPackedTensors`
pub(super) fn device_supports_non_packed_tensors(context: &Context<'_>) -> bool {
    get_tensor_physical_device_features(context).tensor_non_packed != vk::FALSE
}

/// `makeTensorDescription` + `makeTensorCreateInfo`: the description owns the dimension and stride arrays the create info points to.
pub(super) struct TensorDescription {
    dimensions: Vec<i64>,
    strides: Vec<i64>,
    tiling: vk::TensorTilingARM,
    format: vk::Format,
    usage: vk::TensorUsageFlagsARM,
}

impl TensorDescription {
    pub fn new(
        tiling: vk::TensorTilingARM,
        format: vk::Format,
        dimensions: &[i64],
        strides: &[i64],
        usage: vk::TensorUsageFlagsARM,
    ) -> Self {
        Self {
            dimensions: dimensions.to_vec(),
            strides: strides.to_vec(),
            tiling,
            format,
            usage,
        }
    }

    pub fn description(&self) -> vk::TensorDescriptionARM {
        vk::TensorDescriptionARM {
            tiling: self.tiling,
            format: self.format,
            dimension_count: self.dimensions.len() as u32,
            dimensions: self.dimensions.as_ptr(),
            strides: if self.strides.is_empty() {
                std::ptr::null()
            } else {
                self.strides.as_ptr()
            },
            usage: self.usage,
            ..Default::default()
        }
    }
}

/// `vk::TensorWithMemory`
pub(super) struct TensorWithMemory<'a> {
    device: &'a Device,
    tensor: vk::TensorARM,
    allocation: Allocation<'a>,
    allocation_size: u64,
}

impl<'a> TensorWithMemory<'a> {
    pub fn new(
        context: &'a Context<'a>,
        description: &TensorDescription,
        requirement: MemoryRequirement,
    ) -> Result<Self, TestError> {
        Self::new_with_allocator(context, context.get_default_allocator(), description, requirement)
    }

    /// The same, allocating from `allocator` (the basic access cases bind the tensor at an offset within its allocation)
    pub fn new_with_allocator(
        context: &'a Context<'a>,
        allocator: &SimpleAllocator,
        description: &TensorDescription,
        requirement: MemoryRequirement,
    ) -> Result<Self, TestError> {
        Self::new_with_allocator_external(context, allocator, description, requirement, false)
    }

    /// The same, chaining `VkExternalMemoryTensorCreateInfoARM` for DMA_BUF when `dma_buf` is set (tensors bound to dma heap memory)
    pub fn new_with_allocator_external(
        context: &'a Context<'a>,
        allocator: &SimpleAllocator,
        description: &TensorDescription,
        requirement: MemoryRequirement,
        dma_buf: bool,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let desc = description.description();
        let external_create_info = vk::ExternalMemoryTensorCreateInfoARM {
            handle_types: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
            ..Default::default()
        };
        let create_info = vk::TensorCreateInfoARM {
            next: if dma_buf {
                (&external_create_info as *const vk::ExternalMemoryTensorCreateInfoARM).cast()
            } else {
                std::ptr::null()
            },
            description: &desc,
            ..Default::default()
        };
        let tensor = unsafe { device.create_tensor_arm(&create_info, None) }.vk_check("vkCreateTensorARM")?;

        let requirements_info = vk::TensorMemoryRequirementsInfoARM {
            tensor,
            ..Default::default()
        };
        let mut requirements = vk::MemoryRequirements2::default();
        unsafe { device.get_tensor_memory_requirements_arm(&requirements_info, &mut requirements) };
        let requirements = requirements.memory_requirements;

        let allocation = match allocator.allocate(device, requirements, requirement) {
            Ok(allocation) => allocation,
            Err(e) => {
                unsafe { device.destroy_tensor_arm(tensor, None) };
                return Err(e);
            }
        };

        let bind_info = vk::BindTensorMemoryInfoARM {
            tensor,
            memory: allocation.get_memory(),
            memory_offset: allocation.get_offset(),
            ..Default::default()
        };
        if let Err(e) = unsafe { device.bind_tensor_memory_arm(&[bind_info]) }.vk_check("vkBindTensorMemoryARM") {
            unsafe { device.destroy_tensor_arm(tensor, None) };
            return Err(e);
        }

        Ok(Self {
            device,
            tensor,
            allocation,
            allocation_size: requirements.size,
        })
    }

    pub fn get(&self) -> vk::TensorARM {
        self.tensor
    }

    pub fn get_allocation(&self) -> &Allocation<'a> {
        &self.allocation
    }

    pub fn get_allocation_size(&self) -> u64 {
        self.allocation_size
    }
}

impl Drop for TensorWithMemory<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_tensor_arm(self.tensor, None) };
    }
}

fn aliasing_buffer<'a>(
    context: &'a Context<'a>,
    tensor: &TensorWithMemory<'a>,
    size: u64,
    usage: vk::BufferUsageFlags,
) -> Result<Unique<'a, vk::Buffer>, TestError> {
    let device = context.get_device();
    let info = make_buffer_create_info(size, usage);
    let buffer = Unique::new(
        device,
        unsafe { device.create_buffer(&info, None) }.vk_check("vkCreateBuffer")?,
    );
    unsafe {
        device.bind_buffer_memory(
            *buffer,
            tensor.get_allocation().get_memory(),
            tensor.get_allocation().get_offset(),
        )
    }
    .vk_check("vkBindBufferMemory")?;
    Ok(buffer)
}

/// `vk::uploadToTensor`
pub(super) fn upload_to_tensor<'a>(
    context: &'a Context<'a>,
    tensor: &TensorWithMemory<'a>,
    host_buffer: &[u8],
) -> Result<(), TestError> {
    let device = context.get_device();
    let host_buffer_size = host_buffer.len() as u64;
    assert!(tensor.get_allocation_size() >= host_buffer_size);

    let src_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(host_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            host_buffer.as_ptr(),
            src_buffer.get_allocation().get_host_ptr(),
            host_buffer.len(),
        );
    }
    flush_alloc(device, src_buffer.get_allocation())?;

    let dst_buffer = aliasing_buffer(context, tensor, host_buffer_size, vk::BufferUsageFlags::TRANSFER_DST)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, cmd_buffer.get())?;

    let copy_region = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: host_buffer_size,
    };
    unsafe { device.cmd_copy_buffer(cmd_buffer.get(), src_buffer.get(), *dst_buffer, &[copy_region]) };

    let post_transfer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::MEMORY_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer.get(),
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::DependencyFlags::empty(),
            &[post_transfer_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    end_command_buffer(device, cmd_buffer.get())?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())
}

/// `vk::downloadFromTensor`
pub(super) fn download_from_tensor<'a>(
    context: &'a Context<'a>,
    tensor: &TensorWithMemory<'a>,
    host_buffer_size: u64,
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    assert!(tensor.get_allocation_size() >= host_buffer_size);

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

    let src_buffer = aliasing_buffer(context, tensor, host_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC)?;
    let dst_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(host_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    begin_command_buffer(device, cmd_buffer.get())?;

    let pre_transfer_barrier = make_memory_barrier(vk::AccessFlags::MEMORY_WRITE, vk::AccessFlags::TRANSFER_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer.get(),
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[pre_transfer_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    let copy_region = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: host_buffer_size,
    };
    unsafe { device.cmd_copy_buffer(cmd_buffer.get(), *src_buffer, dst_buffer.get(), &[copy_region]) };

    let post_transfer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer.get(),
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[post_transfer_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    end_command_buffer(device, cmd_buffer.get())?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;

    invalidate_alloc(device, dst_buffer.get_allocation())?;

    let mut result = vec![0u8; host_buffer_size as usize];
    unsafe {
        std::ptr::copy_nonoverlapping(
            dst_buffer.get_allocation().get_host_ptr(),
            result.as_mut_ptr(),
            result.len(),
        );
    }
    Ok(result)
}

/// `vk::clearTensor`
pub(super) fn clear_tensor<'a>(context: &'a Context<'a>, tensor: &TensorWithMemory<'a>) -> Result<(), TestError> {
    let data = vec![0u8; tensor.get_allocation_size() as usize];
    upload_to_tensor(context, tensor, &data)
}

/// The float host types (`tcu::Float16`, `tcu::Float32`, `tcu::BrainFloat16`, `tcu::FloatE5M2`, `tcu::FloatE4M3`)
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum FloatFormat {
    F16,
    F32,
    Bf16,
    E5M2,
    E4M3,
}

impl FloatFormat {
    fn size(self) -> usize {
        match self {
            Self::F16 | Self::Bf16 => 2,
            Self::F32 => 4,
            Self::E5M2 | Self::E4M3 => 1,
        }
    }

    /// `T::MANTISSA_BITS`
    fn mantissa_bits(self) -> u64 {
        match self {
            Self::F16 => 10,
            Self::F32 => 23,
            Self::Bf16 => 7,
            Self::E5M2 => 2,
            Self::E4M3 => 3,
        }
    }

    /// `T::EXPONENT_BITS`
    fn exponent_bits(self) -> u64 {
        match self {
            Self::F16 | Self::E5M2 => 5,
            Self::F32 | Self::Bf16 => 8,
            Self::E4M3 => 4,
        }
    }

    /// `T::EXPONENT_BIAS`
    fn exponent_bias(self) -> u64 {
        match self {
            Self::F16 | Self::E5M2 => 15,
            Self::F32 | Self::Bf16 => 127,
            Self::E4M3 => 7,
        }
    }

    /// E4M3 has no infinities: the all-ones exponent is a normal one and only the all-ones mantissa with it is NaN
    fn is_e4m3(self) -> bool {
        self == Self::E4M3
    }

    /// The bits of a non-negative finite value in the normal range of the format, rounded to nearest even like the host float types do
    fn encode(self, value: f64) -> u64 {
        if value == 0.0 {
            return 0;
        }
        let mantissa_scale = (1u64 << self.mantissa_bits()) as f64;
        let mut exponent = value.log2().floor() as i64;
        let scaled = (value / 2f64.powi(exponent as i32) - 1.0) * mantissa_scale;
        let mut mantissa = scaled.floor() as u64;
        let remainder = scaled - scaled.floor();
        if remainder > 0.5 || (remainder == 0.5 && mantissa % 2 == 1) {
            mantissa += 1;
        }
        if mantissa == 1u64 << self.mantissa_bits() {
            mantissa = 0;
            exponent += 1;
        }
        (((exponent + self.exponent_bias() as i64) as u64) << self.mantissa_bits()) | mantissa
    }

    fn fields(self, bits: u64) -> (bool, u64, u64) {
        let mantissa = bits & ((1u64 << self.mantissa_bits()) - 1);
        let exponent = (bits >> self.mantissa_bits()) & ((1u64 << self.exponent_bits()) - 1);
        let negative = (bits >> (self.mantissa_bits() + self.exponent_bits())) & 1 == 1;
        (negative, exponent, mantissa)
    }

    fn is_nan(self, bits: u64) -> bool {
        let (_, exponent, mantissa) = self.fields(bits);
        let all_ones_exponent = (1u64 << self.exponent_bits()) - 1;
        if self.is_e4m3() {
            exponent == all_ones_exponent && mantissa == (1u64 << self.mantissa_bits()) - 1
        } else {
            exponent == all_ones_exponent && mantissa != 0
        }
    }

    fn decode(self, bits: u64) -> f64 {
        let (negative, exponent, mantissa) = self.fields(bits);
        let all_ones_exponent = (1u64 << self.exponent_bits()) - 1;
        let magnitude = if self.is_nan(bits) {
            f64::NAN
        } else if exponent == all_ones_exponent && !self.is_e4m3() {
            f64::INFINITY
        } else if exponent == 0 {
            mantissa as f64 / (1u64 << self.mantissa_bits()) as f64 * 2f64.powi(1 - self.exponent_bias() as i32)
        } else {
            (1.0 + mantissa as f64 / (1u64 << self.mantissa_bits()) as f64)
                * 2f64.powi(exponent as i32 - self.exponent_bias() as i32)
        };
        if negative { -magnitude } else { magnitude }
    }
}

/// The host type behind a `StridedMemoryUtils<T>`
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum ElementKind {
    UInt(usize),
    SInt(usize),
    Float(FloatFormat),
}

impl ElementKind {
    /// `VkFormatToHostType`
    pub fn for_format(format: vk::Format) -> Self {
        match format {
            vk::Format::R8_UINT | vk::Format::R8_BOOL_ARM => Self::UInt(1),
            vk::Format::R8_SINT => Self::SInt(1),
            vk::Format::R16_UINT => Self::UInt(2),
            vk::Format::R16_SINT => Self::SInt(2),
            vk::Format::R32_UINT => Self::UInt(4),
            vk::Format::R32_SINT => Self::SInt(4),
            vk::Format::R64_UINT => Self::UInt(8),
            vk::Format::R64_SINT => Self::SInt(8),
            vk::Format::R16_SFLOAT => Self::Float(FloatFormat::F16),
            vk::Format::R32_SFLOAT => Self::Float(FloatFormat::F32),
            vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM => Self::Float(FloatFormat::Bf16),
            vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM => Self::Float(FloatFormat::E5M2),
            vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM => Self::Float(FloatFormat::E4M3),
            _ => panic!("no host type for tensor format {format:?}"),
        }
    }

    pub fn size(self) -> usize {
        match self {
            Self::UInt(size) | Self::SInt(size) => size,
            Self::Float(float) => float.size(),
        }
    }

    /// `T(static_cast<double>(value))`
    pub fn bits_of_integer_value(self, value: u64) -> u64 {
        match self {
            Self::Float(float) => float.encode(value as f64),
            _ => value,
        }
    }

    fn float_format(self) -> Option<FloatFormat> {
        match self {
            Self::Float(float) => Some(float),
            _ => None,
        }
    }

    fn int_value(self, bits: u64) -> i128 {
        match self {
            Self::SInt(size) => {
                let shift = 64 - 8 * size as u32;
                i128::from(((bits << shift) as i64) >> shift)
            }
            _ => i128::from(bits),
        }
    }
}

/// `vk::StridedMemoryUtils<T>` owning its host memory
pub(super) struct StridedMemory {
    strides: Vec<i64>,
    packed_strides_in_elements: Vec<i64>,
    kind: ElementKind,
    element_count: usize,
    data: Vec<u8>,
}

impl StridedMemory {
    pub fn new(dimensions: &[i64], strides: &[i64], kind: ElementKind) -> Self {
        let element_size = kind.size() as u64;
        let strides = if strides.is_empty() {
            get_tensor_strides(dimensions, element_size, 1)
        } else {
            strides.to_vec()
        };

        let dimension_count = dimensions.len();
        let mut memory_size = 0u64;
        for dimension in 0..dimension_count - 1 {
            memory_size += strides[dimension] as u64 * (dimensions[dimension] - 1) as u64;
        }
        memory_size += strides[dimension_count - 1] as u64 * dimensions[dimension_count - 1] as u64;

        Self {
            strides,
            packed_strides_in_elements: get_tensor_strides(dimensions, 1, 1),
            kind,
            element_count: dimensions.iter().product::<i64>() as usize,
            data: vec![0u8; memory_size as usize],
        }
    }

    pub fn kind(&self) -> ElementKind {
        self.kind
    }

    pub fn memory_size(&self) -> u64 {
        self.data.len() as u64
    }

    pub fn data(&self) -> &[u8] {
        &self.data
    }

    pub fn data_mut(&mut self) -> &mut [u8] {
        &mut self.data
    }

    pub fn element_count(&self) -> usize {
        self.element_count
    }

    fn element_offset(&self, index: u64) -> usize {
        let mut index = index;
        let mut byte_offset = 0u64;
        for (dim_idx, &packed_stride) in self.packed_strides_in_elements.iter().enumerate() {
            let coordinate = index / packed_stride as u64;
            index %= packed_stride as u64;
            byte_offset += coordinate * self.strides[dim_idx] as u64;
        }
        byte_offset as usize
    }

    pub fn read_bits(&self, index: u64) -> u64 {
        let offset = self.element_offset(index);
        let mut bytes = [0u8; 8];
        bytes[..self.kind.size()].copy_from_slice(&self.data[offset..offset + self.kind.size()]);
        u64::from_le_bytes(bytes)
    }

    /// The first byte of the element at `index`, for the one-byte host types
    pub fn get_u8(&self, index: u64) -> u8 {
        self.data[self.element_offset(index)]
    }

    fn write_bits(&mut self, index: u64, bits: u64) {
        let offset = self.element_offset(index);
        let size = self.kind.size();
        self.data[offset..offset + size].copy_from_slice(&bits.to_le_bytes()[..size]);
    }

    /// `StridedMemoryUtils::at(coordinates)`
    pub fn read_bits_at(&self, coordinates: &[u64]) -> u64 {
        let offset: u64 = coordinates
            .iter()
            .zip(&self.strides)
            .map(|(&c, &stride)| c * stride as u64)
            .sum();
        let mut bytes = [0u8; 8];
        let size = self.kind.size();
        bytes[..size].copy_from_slice(&self.data[offset as usize..offset as usize + size]);
        u64::from_le_bytes(bytes)
    }

    /// `StridedMemoryUtils::clear()`
    pub fn clear(&mut self) {
        self.data.fill(0);
    }

    /// `StridedMemoryUtils::fill(T startingValue)` for the integer host types
    pub fn fill_from(&mut self, starting_value: u64) {
        assert!(self.kind.float_format().is_none());
        for element_idx in 0..self.element_count as u64 {
            self.write_bits(element_idx, starting_value.wrapping_add(element_idx));
        }
    }

    /// `StridedMemoryUtils::fill()`
    pub fn fill(&mut self) {
        if let Some(float) = self.kind.float_format() {
            let mantissa_bits = float.mantissa_bits();
            let half_values_precision_limit = 1u64 << mantissa_bits;
            let element_idx_half_value_limit = half_values_precision_limit * 2;
            let upper_base = (mantissa_bits + float.exponent_bias()) << mantissa_bits;
            let max_normal_exponent_bit_pattern = (1u64 << float.exponent_bits()) - if float.is_e4m3() { 1 } else { 2 };
            let max_normal_mantissa_bit_pattern = (1u64 << mantissa_bits) - if float.is_e4m3() { 2 } else { 1 };
            let max_normal_bit_pattern =
                (max_normal_exponent_bit_pattern << mantissa_bits) | max_normal_mantissa_bit_pattern;
            let wrap = element_idx_half_value_limit + max_normal_bit_pattern - upper_base + 1;

            for element_idx in 0..self.element_count as u64 {
                let wrapped = element_idx % wrap;
                let bits = if wrapped < element_idx_half_value_limit {
                    float.encode(wrapped as f64 * 0.5)
                } else {
                    wrapped - element_idx_half_value_limit + upper_base
                };
                self.write_bits(element_idx, bits);
            }
        } else {
            for element_idx in 0..self.element_count as u64 {
                self.write_bits(element_idx, element_idx);
            }
        }
    }
}

/// `vk::compareStridedMemory`
pub(super) fn compare_strided_memory(first: &StridedMemory, second: &StridedMemory) -> TestStatus {
    const EPS: f64 = 0.01;
    let kind = first.kind;
    assert_eq!(first.element_count(), second.element_count());

    for i in 0..first.element_count() as u64 {
        let first_bits = first.read_bits(i);
        let second_bits = second.read_bits(i);

        if let Some(float) = kind.float_format() {
            let value = float.decode(first_bits);
            let expected = float.decode(second_bits);

            if float.is_nan(first_bits) != float.is_nan(second_bits) {
                return TestStatus::fail(format!(
                    "Only one of the values are NaN at index {i}: first = {value}, second = {expected}"
                ));
            }

            let error = (value - expected).abs();
            if error > EPS {
                return TestStatus::fail(format!(
                    "Error between first and second buffer is too large at index {i}: Error: {error} > {EPS}, first = {value}, second = {expected}"
                ));
            }
        } else if first_bits != second_bits {
            return TestStatus::fail(format!(
                "Comparison failed at index {i}: tensor = {}, buffer = {}",
                kind.int_value(first_bits),
                kind.int_value(second_bits)
            ));
        }
    }

    TestStatus::pass("Pass")
}

/// The extension checks every tensor case makes for the formats it uses
pub(super) fn require_format_extensions(context: &Context<'_>, formats: &[vk::Format]) -> Result<(), TestError> {
    for &format in formats {
        if format == vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM {
            context.require_device_functionality("VK_KHR_shader_bfloat16")?;
        }

        if format == vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM
            || format == vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM
        {
            context.require_device_functionality("VK_EXT_shader_float8")?;
        }
    }
    Ok(())
}

/// `deviceSupportsShaderTensorAccess`
pub(super) fn device_supports_shader_tensor_access(context: &Context<'_>) -> bool {
    get_tensor_physical_device_features(context).shader_tensor_access != vk::FALSE
}

/// `deviceSupportsShaderStagesTensorAccess`
pub(super) fn device_supports_shader_stages_tensor_access(context: &Context<'_>, stages: vk::ShaderStageFlags) -> bool {
    get_tensor_physical_device_properties(context)
        .shader_tensor_supported_stages
        .contains(stages)
}

/// `makeTensorView`
pub(super) struct TensorView<'a> {
    device: &'a Device,
    view: vk::TensorViewARM,
}

impl<'a> TensorView<'a> {
    pub fn new(device: &'a Device, tensor: vk::TensorARM, format: vk::Format) -> Result<Self, TestError> {
        let info = vk::TensorViewCreateInfoARM {
            tensor,
            format,
            ..Default::default()
        };
        let view = unsafe { device.create_tensor_view_arm(&info, None) }.vk_check("vkCreateTensorViewARM")?;
        Ok(Self { device, view })
    }

    pub fn get(&self) -> vk::TensorViewARM {
        self.view
    }
}

impl Drop for TensorView<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_tensor_view_arm(self.view, None) };
    }
}

/// A descriptor pool made without `DescriptorPoolBuilder`, whose per-type table is indexed by the raw type value and so cannot hold `TENSOR_ARM`.
pub(super) fn create_descriptor_pool<'a>(
    device: &'a Device,
    sizes: &[vk::DescriptorPoolSize],
    flags: vk::DescriptorPoolCreateFlags,
    max_sets: u32,
) -> Result<Unique<'a, vk::DescriptorPool>, TestError> {
    let info = vk::DescriptorPoolCreateInfo::builder()
        .flags(flags)
        .max_sets(max_sets)
        .pool_sizes(sizes);
    let pool = unsafe { device.create_descriptor_pool(&info, None) }.vk_check("vkCreateDescriptorPool")?;
    Ok(Unique::new(device, pool))
}

pub(super) fn pool_size(descriptor_type: vk::DescriptorType, descriptor_count: u32) -> vk::DescriptorPoolSize {
    vk::DescriptorPoolSize {
        type_: descriptor_type,
        descriptor_count,
    }
}

/// A `VK_DESCRIPTOR_TYPE_TENSOR_ARM` write of `views` starting at `dst_array_element`; `tensor_write` is the chained struct and has to outlive the write.
pub(super) fn tensor_descriptor_write(
    dst_set: vk::DescriptorSet,
    dst_binding: u32,
    dst_array_element: u32,
    tensor_write: &vk::WriteDescriptorSetTensorARM,
) -> vk::WriteDescriptorSet {
    vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: (tensor_write as *const vk::WriteDescriptorSetTensorARM).cast(),
        dst_set,
        dst_binding,
        dst_array_element,
        descriptor_count: tensor_write.tensor_view_count,
        descriptor_type: vk::DescriptorType::TENSOR_ARM,
        image_info: std::ptr::null(),
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    }
}

pub(super) fn make_compute_pipeline<'a>(
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

/// `makeTensorMemoryBarrier`
pub(super) fn make_tensor_memory_barrier(
    src_stage_mask: vk::PipelineStageFlags2,
    src_access_mask: vk::AccessFlags2,
    dst_stage_mask: vk::PipelineStageFlags2,
    dst_access_mask: vk::AccessFlags2,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    tensor: vk::TensorARM,
) -> vk::TensorMemoryBarrierARM {
    vk::TensorMemoryBarrierARM {
        src_stage_mask,
        src_access_mask,
        dst_stage_mask,
        dst_access_mask,
        src_queue_family_index,
        dst_queue_family_index,
        tensor,
        ..Default::default()
    }
}

/// `vkCmdPipelineBarrier2` with the tensor barrier as the `pNext` of the dependency info, as upstream does.
pub(super) fn cmd_tensor_memory_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    barrier: &vk::TensorMemoryBarrierARM,
) {
    let dependency_info = vk::DependencyInfo {
        next: (barrier as *const vk::TensorMemoryBarrierARM).cast(),
        ..Default::default()
    };
    unsafe { device.cmd_pipeline_barrier2(cmd_buffer, &dependency_info) };
}

/// `singleDimensionWorkgroupCount`
pub(super) fn single_dimension_workgroup_count(elements: u32, workgroup_size: u32) -> u32 {
    elements.div_ceil(workgroup_size)
}

/// The coordinates of element `index` in a packed tensor of `shape` (`StridedMemoryUtils::getCoordinates`)
pub(super) fn coordinates_of(shape: &[i64], index: u64) -> Vec<u64> {
    let mut index = index;
    get_tensor_strides(shape, 1, 1)
        .into_iter()
        .map(|stride| {
            let coordinate = index / stride as u64;
            index %= stride as u64;
            coordinate
        })
        .collect()
}

/// Why `value_bits` is not `expected_bits` for the element kind (`None` when it is), as the OoB access checks of upstream compare them
pub(super) fn describe_mismatch(kind: ElementKind, expected_bits: u64, value_bits: u64) -> Option<String> {
    const EPS: f64 = 0.01;
    if let Some(float) = kind.float_format() {
        let expected = float.decode(expected_bits);
        let value = float.decode(value_bits);
        if float.is_nan(expected_bits) != float.is_nan(value_bits) {
            return Some(format!(
                "Only one of the values are NaN: expected = {expected}, read = {value}"
            ));
        }
        let error = (value - expected).abs();
        if error > EPS {
            return Some(format!(
                "Error between read value and expected is too large: Error {error} > {EPS}, expected = {expected}, read = {value}"
            ));
        }
        None
    } else if expected_bits != value_bits {
        Some(format!(
            "expected = {}, read = {}",
            kind.int_value(expected_bits),
            kind.int_value(value_bits)
        ))
    } else {
        None
    }
}

/// `tensorSupportsDmaBufImport`
pub(super) fn tensor_supports_dma_buf_import(context: &Context<'_>, description: &TensorDescription) -> bool {
    let desc = description.description();
    let tensor_info = vk::PhysicalDeviceExternalTensorInfoARM {
        description: &desc,
        handle_type: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        ..Default::default()
    };
    let mut external_properties = vk::ExternalTensorPropertiesARM::default();
    unsafe {
        context
            .get_instance()
            .get_physical_device_external_tensor_properties_arm(
                context.get_physical_device(),
                &tensor_info,
                &mut external_properties,
            )
    };

    let properties = external_properties.external_memory_properties;
    properties
        .external_memory_features
        .contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE)
        && !properties
            .external_memory_features
            .contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY)
        && properties
            .compatible_handle_types
            .contains(vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT)
}
