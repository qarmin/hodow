// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageAtomicOperationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `createImageAtomicOperationTests` (the case tree, 6209 cases), `commonCheckSupport` and the
// instances (atomic_operation_instance.rs) are ported. A sparse backed image is bound on the universal queue (the case is NotSupported when that
// queue cannot bind sparse memory, where upstream uses `Context::getSparseQueue`).
// `Context::getShaderAtomicFloat*` and friends return zeros when the extension is not enabled, which `query_features!` does too.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::atomic_operation_instance::{BinaryAtomicInstance, CheckType};
use super::tests_util::{ImageType, get_image_type_name, get_num_layers, map_image_type};
use crate::generated::shaders::image_atomic_operations::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vk::sparse_util::{check_sparse_image_format_support_for, universal_queue_supports_sparse_binding};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum AtomicOperation {
    Add,
    Sub,
    Inc,
    Dec,
    Min,
    Max,
    And,
    Or,
    Xor,
    Exchange,
    CompareExchange,
}

const ATOMIC_OPERATIONS: [AtomicOperation; 11] = [
    AtomicOperation::Add,
    AtomicOperation::Sub,
    AtomicOperation::Inc,
    AtomicOperation::Dec,
    AtomicOperation::Min,
    AtomicOperation::Max,
    AtomicOperation::And,
    AtomicOperation::Or,
    AtomicOperation::Xor,
    AtomicOperation::Exchange,
    AtomicOperation::CompareExchange,
];

/// `getAtomicOperationCaseName`
fn get_atomic_operation_case_name(op: AtomicOperation) -> &'static str {
    match op {
        AtomicOperation::Add => "add",
        AtomicOperation::Sub => "sub",
        AtomicOperation::Inc => "inc",
        AtomicOperation::Dec => "dec",
        AtomicOperation::Min => "min",
        AtomicOperation::Max => "max",
        AtomicOperation::And => "and",
        AtomicOperation::Or => "or",
        AtomicOperation::Xor => "xor",
        AtomicOperation::Exchange => "exchange",
        AtomicOperation::CompareExchange => "compare_exchange",
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ShaderReadType {
    Normal,
    Sparse,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ImageBackingType {
    Normal,
    Sparse,
}

/// The `tcu::TextureFormat`s of the case tree
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum AtomicFormat {
    R32Uint,
    R32Sint,
    R32Float,
    R64Uint,
    R64Sint,
    Rg16Float,
    Rgba16Float,
}

impl AtomicFormat {
    /// `getShaderImageFormatQualifier`
    pub(super) fn qualifier(self) -> &'static str {
        match self {
            Self::R32Uint => "r32ui",
            Self::R32Sint => "r32i",
            Self::R32Float => "r32f",
            Self::R64Uint => "r64ui",
            Self::R64Sint => "r64i",
            Self::Rg16Float => "rg16f",
            Self::Rgba16Float => "rgba16f",
        }
    }

    /// `mapTextureFormat`
    pub(super) fn vk(self) -> vk::Format {
        match self {
            Self::R32Uint => vk::Format::R32_UINT,
            Self::R32Sint => vk::Format::R32_SINT,
            Self::R32Float => vk::Format::R32_SFLOAT,
            Self::R64Uint => vk::Format::R64_UINT,
            Self::R64Sint => vk::Format::R64_SINT,
            Self::Rg16Float => vk::Format::R16G16_SFLOAT,
            Self::Rgba16Float => vk::Format::R16G16B16A16_SFLOAT,
        }
    }

    /// `format.type == FLOAT || format.type == HALF_FLOAT`
    pub(super) fn is_float(self) -> bool {
        matches!(self, Self::R32Float | Self::Rg16Float | Self::Rgba16Float)
    }
}

const ATOMIC_FORMATS: [AtomicFormat; 7] = [
    AtomicFormat::R32Uint,
    AtomicFormat::R32Sint,
    AtomicFormat::R32Float,
    AtomicFormat::R64Uint,
    AtomicFormat::R64Sint,
    AtomicFormat::Rg16Float,
    AtomicFormat::Rgba16Float,
];

#[derive(Clone, Copy)]
pub(super) struct AtomicCaseParams {
    pub(super) image_type: ImageType,
    pub(super) image_size: [u32; 3],
    pub(super) format: AtomicFormat,
    pub(super) tiling: vk::ImageTiling,
    pub(super) operation: AtomicOperation,
    pub(super) use_transfer: bool,
    pub(super) read_type: ShaderReadType,
    pub(super) backing_type: ImageBackingType,
}

struct BinaryAtomicCase {
    name: String,
    params: AtomicCaseParams,
    check: CheckType,
}

impl BinaryAtomicCase {
    fn key(&self) -> String {
        format!(
            "{}_{}_{}",
            get_atomic_operation_case_name(self.params.operation),
            get_image_type_name(self.params.image_type),
            self.params.format.qualifier()
        )
    }
}

impl TestCase for BinaryAtomicCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BinaryAtomicInstance {
            context,
            params: self.params,
            check: self.check,
        })
    }
}

/// `StorageTexelBufferAtomic32BitIndexCase`; the shader comes from shaders/manifest/image_atomic_texel_buffer_index.toml
#[derive(Clone, Copy)]
pub struct StorageTexelBufferAtomic32BitIndexCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for StorageTexelBufferAtomic32BitIndexCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_properties().limits.max_texel_buffer_elements < 131072 {
            return not_supported("maxTexelBufferElements is less than 131072");
        }

        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), vk::Format::R32_UINT)
        };
        if !properties
            .buffer_features
            .contains(vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER)
        {
            return not_supported("VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT not supported for VK_FORMAT_R32_UINT");
        }
        if !properties
            .buffer_features
            .contains(vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER_ATOMIC)
        {
            return not_supported(
                "VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_ATOMIC_BIT not supported for VK_FORMAT_R32_UINT",
            );
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StorageTexelBufferAtomic32BitIndexInstance { context })
    }
}

/// `StorageTexelBufferAtomic32BitIndexInstance`
struct StorageTexelBufferAtomic32BitIndexInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for StorageTexelBufferAtomic32BitIndexInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // 131072 elements so that index 65536 is in bounds, beyond the 16-bit boundary
        let buffer_elements: u64 = 131072;
        let buffer_size = buffer_elements * std::mem::size_of::<u32>() as u64;
        let test_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                buffer_size,
                vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let view_info = vk::BufferViewCreateInfo::builder()
            .buffer(test_buffer.get())
            .format(vk::Format::R32_UINT)
            .offset(0)
            .range(buffer_size);
        let test_buffer_view = Unique::new(
            vk,
            unsafe { vk.create_buffer_view(&view_info, None) }.vk_check("vkCreateBufferView")?,
        );

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_TEXEL_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_TEXEL_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_views = [*test_buffer_view];
        let write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_TEXEL_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: std::ptr::null(),
            texel_buffer_view: buffer_views.as_ptr(),
        };
        unsafe { vk.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
        let shader_module = create_shader_module(vk, self.context.get_binary_collection().get("comp")?)?;
        let entry_point = b"main\0";
        let pipeline_create_info = vk::ComputePipelineCreateInfo {
            s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::PipelineCreateFlags::empty(),
            stage: vk::PipelineShaderStageCreateInfo {
                s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::PipelineShaderStageCreateFlags::empty(),
                stage: vk::ShaderStageFlags::COMPUTE,
                module: *shader_module,
                name: entry_point.as_ptr().cast(),
                specialization_info: std::ptr::null(),
            },
            layout: *pipeline_layout,
            base_pipeline_handle: vk::Pipeline::null(),
            base_pipeline_index: -1,
        };
        let pipelines =
            unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_create_info], None) }
                .map_err(|e| TestError::InternalError(format!("vkCreateComputePipelines returned {e:?}")))?;
        let pipeline = Unique::new(vk, pipelines.0[0]);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        begin_command_buffer(vk, cmd_buffer)?;

        let barrier_before = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            test_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        let barrier_after = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            test_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            vk.cmd_fill_buffer(cmd_buffer, test_buffer.get(), 0, vk::WHOLE_SIZE, 0);
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier_before],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
            vk.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            vk.cmd_dispatch(cmd_buffer, 1, 1, 1);
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier_after],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        invalidate_alloc(vk, test_buffer.get_allocation())?;
        let res_data = test_buffer.get_allocation().get_host_ptr().cast::<u32>();
        let (first, wrapped) = unsafe { (*res_data, *res_data.add(65536)) };

        if first != 0 {
            return Ok(TestStatus::fail(
                "Atomic operation wrote to index 0 (wrapped from index 65536)!",
            ));
        }
        if wrapped != 1 {
            return Ok(TestStatus::fail(
                "Atomic operation did not write successfully to index 65536!",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `Context::getShader*Features*` for a struct vulkanalia has: all false when the extension is not enabled on the device
macro_rules! query_features {
    ($context:expr, $extension:expr, $ty:ty) => {{
        let mut features = <$ty>::default();
        if $context.is_device_functionality_supported($extension) {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                $context
                    .get_instance()
                    .get_physical_device_features2($context.get_physical_device(), &mut features2)
            };
        }
        features
    }};
}

fn not_supported(message: &str) -> Result<(), TestError> {
    Err(TestError::NotSupported(message.to_string()))
}

/// `getUsageFlags`
fn get_usage_flags(use_transfer: bool) -> vk::ImageUsageFlags {
    let mut usage_flags = vk::ImageUsageFlags::STORAGE;

    if use_transfer {
        usage_flags |= vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    }

    usage_flags
}

/// `commonCheckSupport`
fn common_check_support(context: &Context<'_>, p: &AtomicCaseParams) -> Result<(), TestError> {
    let format = p.format.vk();
    let vk_img_type = map_image_type(p.image_type);
    let texel_buffer_support =
        vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER | vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER_ATOMIC;

    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let usage_flags = get_usage_flags(p.use_transfer);

    let result = unsafe {
        instance.get_physical_device_image_format_properties(
            physical_device,
            format,
            vk_img_type,
            p.tiling,
            usage_flags,
            vk::ImageCreateFlags::empty(),
        )
    };
    let image_format_properties = match result {
        Ok(properties) => properties,
        Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
            return not_supported("Format unsupported for tiling");
        }
        Err(_) => {
            return Err(TestError::Fail(
                "vkGetPhysicalDeviceImageFormatProperties returned unexpected error".to_string(),
            ));
        }
    };

    if image_format_properties.max_array_layers < get_num_layers(p.image_type, p.image_size) {
        return not_supported("This format and tiling combination does not support this number of aray layers");
    }

    let format_properties = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
    if p.image_type == ImageType::Buffer && !format_properties.buffer_features.contains(texel_buffer_support) {
        return not_supported("Atomic storage texel buffers not supported");
    }

    let required_features_linear = vk::FormatFeatureFlags::STORAGE_IMAGE | vk::FormatFeatureFlags::STORAGE_IMAGE_ATOMIC;
    if p.tiling == vk::ImageTiling::LINEAR
        && !format_properties
            .linear_tiling_features
            .contains(required_features_linear)
    {
        return not_supported("Format doesn't support atomic storage with linear tiling");
    }

    let device_features = context.get_device_features();
    if p.image_type == ImageType::CubeArray && device_features.image_cube_array == vk::FALSE {
        return not_supported("imageCubeArray not supported");
    }

    if p.backing_type == ImageBackingType::Sparse {
        if device_features.sparse_binding == vk::FALSE {
            return not_supported("sparseBinding not supported");
        }

        if !universal_queue_supports_sparse_binding(
            instance,
            physical_device,
            context.get_universal_queue_family_index(),
        ) {
            return not_supported("The universal queue does not support sparse binding");
        }

        match vk_img_type {
            vk::ImageType::_2D => {
                if device_features.sparse_residency_image_2d == vk::FALSE {
                    return not_supported("sparseResidencyImage2D not supported");
                }
            }
            vk::ImageType::_3D => {
                if device_features.sparse_residency_image_3d == vk::FALSE {
                    return not_supported("sparseResidencyImage3D not supported");
                }
            }
            _ => unreachable!("sparse backing is only registered for 2D and 3D images"),
        }

        if !check_sparse_image_format_support_for(
            instance,
            physical_device,
            format,
            vk_img_type,
            vk::SampleCountFlags::_1,
            usage_flags,
            p.tiling,
        ) {
            return not_supported("Format does not support sparse images");
        }
    }

    let required_features = vk::FormatFeatureFlags::STORAGE_IMAGE | vk::FormatFeatureFlags::STORAGE_IMAGE_ATOMIC;

    if format == vk::Format::R16G16_SFLOAT || format == vk::Format::R16G16B16A16_SFLOAT {
        context.require_device_functionality("VK_NV_shader_atomic_float16_vector")?;

        let features = query_features!(
            context,
            "VK_NV_shader_atomic_float16_vector",
            vk::PhysicalDeviceShaderAtomicFloat16VectorFeaturesNV
        );
        if features.shader_float16_vector_atomics == vk::FALSE {
            return not_supported("shaderFloat16VectorAtomics not supported");
        }

        if !format_properties.optimal_tiling_features.contains(required_features) {
            return Err(TestError::Fail("Mandatory format features not supported".to_string()));
        }
    } else if p.format == AtomicFormat::R32Float {
        context.require_device_functionality("VK_EXT_shader_atomic_float")?;

        let atomic_float_features = query_features!(
            context,
            "VK_EXT_shader_atomic_float",
            vk::PhysicalDeviceShaderAtomicFloatFeaturesEXT
        );

        if atomic_float_features.shader_image_float32_atomics == vk::FALSE {
            return not_supported("shaderImageFloat32Atomics not supported");
        }

        if p.operation == AtomicOperation::Add && atomic_float_features.shader_image_float32_atomic_add == vk::FALSE {
            return not_supported("shaderImageFloat32AtomicAdd not supported");
        }

        if p.operation == AtomicOperation::Min || p.operation == AtomicOperation::Max {
            context.require_device_functionality("VK_EXT_shader_atomic_float2")?;
            let atomic_float2_features = query_features!(
                context,
                "VK_EXT_shader_atomic_float2",
                vk::PhysicalDeviceShaderAtomicFloat2FeaturesEXT
            );
            if atomic_float2_features.shader_image_float32_atomic_min_max == vk::FALSE {
                return not_supported("shaderImageFloat32AtomicMinMax not supported");
            }
        }

        if !format_properties.optimal_tiling_features.contains(required_features) {
            return Err(TestError::Fail(
                "Required format feature bits not supported".to_string(),
            ));
        }

        if p.backing_type == ImageBackingType::Sparse {
            if atomic_float_features.sparse_image_float32_atomics == vk::FALSE {
                return not_supported("sparseImageFloat32Atomics not supported");
            }

            if p.operation == AtomicOperation::Add && atomic_float_features.sparse_image_float32_atomic_add == vk::FALSE
            {
                return not_supported("sparseImageFloat32AtomicAdd not supported");
            }
        }
    } else if format == vk::Format::R64_UINT || format == vk::Format::R64_SINT {
        context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

        let atomic_int64_features = query_features!(
            context,
            "VK_EXT_shader_image_atomic_int64",
            vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT
        );

        if atomic_int64_features.shader_image_int64_atomics == vk::FALSE {
            return not_supported("shaderImageInt64Atomics not supported");
        }

        if p.backing_type == ImageBackingType::Sparse && atomic_int64_features.sparse_image_int64_atomics == vk::FALSE {
            return not_supported("sparseImageInt64Atomics not supported");
        }

        if !format_properties.optimal_tiling_features.contains(required_features) {
            return Err(TestError::Fail("Mandatory format features not supported".to_string()));
        }
    }

    if p.use_transfer {
        let transfer_features = vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST;
        if !format_properties.optimal_tiling_features.contains(transfer_features) {
            return not_supported("Transfer features not supported for this format");
        }
    }

    if p.read_type == ShaderReadType::Sparse && device_features.shader_resource_residency == vk::FALSE {
        return not_supported("shaderResourceResidency not supported");
    }

    Ok(())
}

/// `createImageAtomicOperationTests`
pub fn create_image_atomic_operation_tests() -> TestCaseGroup {
    let mut image_atomic_operations_tests = TestCaseGroup::new("atomic_operations");

    let image_params_array: [(ImageType, [u32; 3]); 8] = [
        (ImageType::OneD, [64, 1, 1]),
        (ImageType::OneDArray, [64, 1, 8]),
        (ImageType::TwoD, [64, 64, 1]),
        (ImageType::TwoDArray, [64, 64, 8]),
        (ImageType::ThreeD, [48, 48, 8]),
        (ImageType::Cube, [64, 64, 1]),
        (ImageType::CubeArray, [64, 64, 2]),
        (ImageType::Buffer, [64, 1, 1]),
    ];

    let tilings = [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR];
    let read_types = [
        (ShaderReadType::Normal, "normal_read"),
        (ShaderReadType::Sparse, "sparse_read"),
    ];
    let backing_types = [
        (ImageBackingType::Normal, "normal_img"),
        (ImageBackingType::Sparse, "sparse_img"),
    ];

    for operation in ATOMIC_OPERATIONS {
        let mut operation_group = TestCaseGroup::new(get_atomic_operation_case_name(operation));

        for (image_type, image_size) in image_params_array {
            let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

            for use_transfer in [false, true] {
                let group_name = format!("{}transfer", if use_transfer { "" } else { "no" });

                let mut transfer_group = TestCaseGroup::new(group_name);

                for (read_type, read_type_name) in read_types {
                    let mut read_type_group = TestCaseGroup::new(read_type_name);

                    for (backing_type, backing_type_name) in backing_types {
                        let mut backing_type_group = TestCaseGroup::new(backing_type_name);

                        for format in ATOMIC_FORMATS {
                            for tiling in tilings {
                                let format_name = format.qualifier();
                                let suffix = if tiling == vk::ImageTiling::OPTIMAL {
                                    ""
                                } else {
                                    "_linear"
                                };

                                // Need SPIRV programs in vktImageAtomicSpirvShaders.cpp for linear tiling case
                                if image_type == ImageType::Buffer
                                    && !format.is_float()
                                    && tiling == vk::ImageTiling::LINEAR
                                {
                                    continue;
                                }

                                // Only 2D and 3D images may support sparse residency.
                                // VK_IMAGE_TILING_LINEAR does not support sparse residency
                                let vk_image_type = map_image_type(image_type);
                                if backing_type == ImageBackingType::Sparse
                                    && ((vk_image_type != vk::ImageType::_2D && vk_image_type != vk::ImageType::_3D)
                                        || tiling == vk::ImageTiling::LINEAR)
                                {
                                    continue;
                                }

                                // Only some operations are supported on floating-point
                                if format.is_float()
                                    && operation != AtomicOperation::Add
                                    && operation != AtomicOperation::Min
                                    && operation != AtomicOperation::Max
                                    && operation != AtomicOperation::Exchange
                                {
                                    continue;
                                }

                                if read_type == ShaderReadType::Sparse {
                                    // When using transfer, shader reads will not be used, so avoid creating two identical cases.
                                    if use_transfer {
                                        continue;
                                    }

                                    // Sparse reads are not supported for all types of images.
                                    if image_type == ImageType::OneD
                                        || image_type == ImageType::OneDArray
                                        || image_type == ImageType::Buffer
                                    {
                                        continue;
                                    }
                                }

                                let params = AtomicCaseParams {
                                    image_type,
                                    image_size,
                                    format,
                                    tiling,
                                    operation,
                                    use_transfer,
                                    read_type,
                                    backing_type,
                                };

                                // Atomic case checks the end result of the operations, and not the intermediate return values
                                backing_type_group.add_child(Box::new(BinaryAtomicCase {
                                    name: format!("{format_name}_end_result{suffix}"),
                                    params,
                                    check: CheckType::EndResult,
                                }) as Box<dyn TestCase>);

                                // Atomic case checks the return values of the atomic function and not the end result.
                                backing_type_group.add_child(Box::new(BinaryAtomicCase {
                                    name: format!("{format_name}_intermediate_values{suffix}"),
                                    params,
                                    check: CheckType::IntermediateValues,
                                }) as Box<dyn TestCase>);
                            }
                        }

                        if !backing_type_group.children().is_empty() {
                            read_type_group.add_child(backing_type_group);
                        }
                    }

                    if !read_type_group.children().is_empty() {
                        transfer_group.add_child(read_type_group);
                    }
                }

                if !transfer_group.children().is_empty() {
                    image_type_group.add_child(transfer_group);
                }
            }

            if !image_type_group.children().is_empty() {
                operation_group.add_child(image_type_group);
            }
        }

        if !operation_group.children().is_empty() {
            image_atomic_operations_tests.add_child(operation_group);
        }
    }

    let mut indexing_group = TestCaseGroup::new("indexing");
    indexing_group.add_child(Box::new(
        crate::generated::shaders::image_atomic_texel_buffer_index::STORAGE_TEXEL_BUFFER_ATOMIC_32BIT_INDEX,
    ) as Box<dyn TestCase>);
    image_atomic_operations_tests.add_child(indexing_group);

    image_atomic_operations_tests
}
