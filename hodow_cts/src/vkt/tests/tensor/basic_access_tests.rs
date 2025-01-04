// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorBasicShaderAccess.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `genShaderTensorAccess` is `scripts/gen_tensor_manifests.py` (per format one case with a shader per rank 1..=8 and
// variant, `r<rank>_read|write`); the `max_rank` cases compile for the device's maximum dimension count, which a precompiled shader cannot know, so they use at most
// rank 8. The tensor memory is never host mapped here, so the `forced_staging` cases take the same path as the others. The `dma_heap_buffer` cases
// use `SimpleAllocator::dma_heap`. The cases are returned keyed by their dotted path so `tensor::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;

use super::required_tests::get_tensor_physical_device_properties;
use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, TensorWithMemory, clear_tensor,
    cmd_tensor_memory_barrier, compare_strided_memory, create_descriptor_pool, device_supports_non_packed_tensors,
    device_supports_shader_stages_tensor_access, device_supports_shader_tensor_access, download_from_tensor,
    format_support_tensor_flags, get_format_size, get_tensor_strides, make_compute_pipeline,
    make_tensor_memory_barrier, params_to_string, pool_size, require_format_extensions, require_tensor_shape_supported,
    single_dimension_workgroup_count, tensor_descriptor_write, tensor_format_short_name,
    tensor_supports_dma_buf_import, upload_to_tensor,
};
use crate::generated::shaders::tensor_basic_access::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{
    MemoryRequirement, OffsetParams, SimpleAllocator, dma_heap_available, flush_alloc, invalidate_alloc,
};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestInstance};

const SHADER_TENSOR_ACCESS_WORKGROUP_SIZE: u32 = 128;
const DISPATCH_WORKGROUP_COUNT_LIMIT: u32 = 65535;
const MAX_COMPILED_RANK: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum AccessVariant {
    /// `WRITE_TO_BUFFER`: the shader reads the tensor and writes the buffer ("shader_read")
    WriteToBuffer,
    /// `READ_FROM_BUFFER`: the shader reads the buffer and writes the tensor ("shader_write")
    ReadFromBuffer,
}

impl AccessVariant {
    fn name(self) -> &'static str {
        match self {
            Self::WriteToBuffer => "shader_read",
            Self::ReadFromBuffer => "shader_write",
        }
    }

    fn shader_suffix(self) -> &'static str {
        match self {
            Self::WriteToBuffer => "read",
            Self::ReadFromBuffer => "write",
        }
    }
}

/// `calculateMaxDimensionCountParameters`, with the rank limited to the ranks a shader was compiled for
fn calculate_max_dimension_count_parameters(
    context: &Context<'_>,
    base_parameters: &TensorParameters,
) -> TensorParameters {
    let rank = get_tensor_physical_device_properties(context)
        .max_tensor_dimension_count
        .min(MAX_COMPILED_RANK) as usize;

    let mut max_rank_parameters = base_parameters.clone();
    max_rank_parameters.dimensions = vec![1; rank];
    max_rank_parameters.dimensions[0] = 151;
    if rank >= 2 {
        max_rank_parameters.dimensions[rank - 2] = 3;
    }
    max_rank_parameters.dimensions[rank - 1] = 157;
    max_rank_parameters
}

fn shader_programs(parameters: &TensorParameters) -> BinaryCollection {
    let key = format!("ba_{}", tensor_format_short_name(parameters.format));
    ALL_SHARED_PROGRAM
        .iter()
        .find(|p| p.name == key)
        .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
}

fn check_shader_access_support(context: &Context<'_>, parameters: &TensorParameters) -> Result<(), TestError> {
    context.require_device_functionality("VK_ARM_tensors")?;
    require_format_extensions(context, &[parameters.format])?;

    require_tensor_shape_supported(context, parameters)?;

    if !format_support_tensor_flags(
        context,
        parameters.format,
        parameters.tiling,
        vk::FormatFeatureFlags2::TENSOR_SHADER_ARM,
    ) {
        return Err(TestError::NotSupported("Format not supported".to_string()));
    }

    if !device_supports_shader_tensor_access(context) {
        return Err(TestError::NotSupported(
            "Device does not support shader tensor access".to_string(),
        ));
    }

    if !device_supports_shader_stages_tensor_access(context, vk::ShaderStageFlags::COMPUTE) {
        return Err(TestError::NotSupported(
            "Device does not support shader tensor access in compute shader stage".to_string(),
        ));
    }
    Ok(())
}

fn tensor_allocator(context: &Context<'_>, tensor_offset: u64, use_dma_heap_allocator: bool) -> SimpleAllocator {
    let memory_properties = *context.get_default_allocator().memory_properties();
    let offset_params = (tensor_offset != 0).then(|| OffsetParams {
        non_coherent_atom_size: context.get_device_properties().limits.non_coherent_atom_size,
        offset: tensor_offset,
    });
    match (use_dma_heap_allocator, offset_params) {
        (true, offset_params) => SimpleAllocator::dma_heap(memory_properties, offset_params),
        (false, Some(offset_params)) => SimpleAllocator::with_offset(memory_properties, offset_params),
        (false, None) => SimpleAllocator::new(memory_properties),
    }
}

/// The part of `checkSupport` both kinds of case run for `m_useDmaHeapAllocator`
fn check_dma_heap_support(context: &Context<'_>, parameters: &TensorParameters) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_external_memory_dma_buf")?;
    if !dma_heap_available() {
        return Err(TestError::NotSupported(
            "Target does not support DMA heap allocator".to_string(),
        ));
    }

    let tensor_description = TensorDescription::new(
        parameters.tiling,
        parameters.format,
        &parameters.dimensions,
        &parameters.strides,
        vk::TensorUsageFlagsARM::SHADER,
    );
    if !tensor_supports_dma_buf_import(context, &tensor_description) {
        return Err(TestError::NotSupported(
            "Target tensor description does not support DMA BUF imported memory".to_string(),
        ));
    }
    Ok(())
}

struct LinearTensorAccessTestCase {
    name: String,
    parameters: TensorParameters,
    variant: AccessVariant,
    tensor_offset: u64,
    use_dma_heap_allocator: bool,
}

impl TestCase for LinearTensorAccessTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shader_access_support(context, &self.parameters)?;

        if self.use_dma_heap_allocator {
            check_dma_heap_support(context, &self.parameters)?;
        }

        if !self.parameters.packed() && !device_supports_non_packed_tensors(context) {
            return Err(TestError::NotSupported("Non-packed tensors not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        shader_programs(&self.parameters)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        // If no tensor shape was provided, it is a test of the maximum dimension count
        let parameters = if self.parameters.dimensions.is_empty() {
            calculate_max_dimension_count_parameters(context, &self.parameters)
        } else {
            self.parameters.clone()
        };

        Box::new(LinearTensorAccessTestInstance {
            context,
            parameters,
            variant: self.variant,
            tensor_offset: self.tensor_offset,
            use_dma_heap_allocator: self.use_dma_heap_allocator,
        })
    }
}

struct LinearTensorAccessTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TensorParameters,
    variant: AccessVariant,
    tensor_offset: u64,
    use_dma_heap_allocator: bool,
}

impl LinearTensorAccessTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let parameters = &self.parameters;
        let kind = ElementKind::for_format(parameters.format);

        let allocator = tensor_allocator(context, self.tensor_offset, self.use_dma_heap_allocator);

        let elements = parameters.elements() as u32;

        let tensor_desc = TensorDescription::new(
            parameters.tiling,
            parameters.format,
            &parameters.dimensions,
            &parameters.strides,
            vk::TensorUsageFlagsARM::SHADER,
        );
        let tensor = TensorWithMemory::new_with_allocator_external(
            context,
            &allocator,
            &tensor_desc,
            MemoryRequirement::ANY,
            self.use_dma_heap_allocator,
        )?;
        let tensor_view = TensorView::new(device, tensor.get(), parameters.format)?;

        let buffer_size = u64::from(elements) * kind.size() as u64;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut tensor_data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
        let mut buffer_memory = StridedMemory::new(&[i64::from(elements)], &[], kind);

        if self.variant == AccessVariant::WriteToBuffer {
            tensor_data.fill();
            upload_to_tensor(context, &tensor, tensor_data.data())?;
            buffer_memory.clear();
        } else {
            tensor_data.clear();
            buffer_memory.fill();
            clear_tensor(context, &tensor)?;
        }
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer_memory.data().as_ptr(),
                buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            );
        }
        flush_alloc(device, buffer.get_allocation())?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::TENSOR_ARM, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = create_descriptor_pool(
            device,
            &[
                pool_size(vk::DescriptorType::TENSOR_ARM, 1),
                pool_size(vk::DescriptorType::STORAGE_BUFFER, 1),
            ],
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_descriptor_info = [make_descriptor_buffer_info(buffer.get(), 0, buffer_size)];
        let tensor_views = [tensor_view.get()];
        let tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
            tensor_view_count: 1,
            tensor_views: tensor_views.as_ptr(),
            ..Default::default()
        };
        let writes = [
            tensor_descriptor_write(descriptor_set.get(), 0, 0, &tensor_descriptor_info),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_descriptor_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        {
            let binary = context.get_binary_collection().get(&format!(
                "r{}_{}",
                parameters.dimensions.len(),
                self.variant.shader_suffix()
            ))?;
            let shader_module = create_shader_module(device, binary)?;

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, cmd_buffer.get())?;

            unsafe {
                device.cmd_bind_pipeline(cmd_buffer.get(), vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd_buffer.get(),
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
            }

            let dispatch_count = single_dimension_workgroup_count(elements, SHADER_TENSOR_ACCESS_WORKGROUP_SIZE);
            assert!(dispatch_count <= DISPATCH_WORKGROUP_COUNT_LIMIT);
            unsafe { device.cmd_dispatch(cmd_buffer.get(), dispatch_count, 1, 1) };

            if self.variant == AccessVariant::WriteToBuffer {
                let buffer_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    buffer.get(),
                    0,
                    buffer_size,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer.get(),
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    )
                };
            }

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        invalidate_alloc(device, buffer.get_allocation())?;

        if self.variant == AccessVariant::ReadFromBuffer {
            let downloaded = download_from_tensor(context, &tensor, tensor_data.memory_size())?;
            tensor_data.data_mut().copy_from_slice(&downloaded);
        }

        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer.get_allocation().get_host_ptr(),
                buffer_memory.data_mut().as_mut_ptr(),
                buffer_size as usize,
            );
        }

        Ok(compare_strided_memory(&tensor_data, &buffer_memory))
    }
}

impl TestInstance for LinearTensorAccessTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

struct OptimalTensorAccessTestCase {
    name: String,
    parameters: TensorParameters,
    tensor_offset: u64,
    use_dma_heap_allocator: bool,
}

impl TestCase for OptimalTensorAccessTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shader_access_support(context, &self.parameters)?;

        if self.use_dma_heap_allocator {
            check_dma_heap_support(context, &self.parameters)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        shader_programs(&self.parameters)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let parameters = if self.parameters.dimensions.is_empty() {
            calculate_max_dimension_count_parameters(context, &self.parameters)
        } else {
            self.parameters.clone()
        };

        Box::new(OptimalTensorAccessTestInstance {
            context,
            parameters,
            tensor_offset: self.tensor_offset,
            use_dma_heap_allocator: self.use_dma_heap_allocator,
        })
    }
}

struct OptimalTensorAccessTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TensorParameters,
    tensor_offset: u64,
    use_dma_heap_allocator: bool,
}

impl OptimalTensorAccessTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let parameters = &self.parameters;
        let kind = ElementKind::for_format(parameters.format);

        let elements = parameters.elements() as u32;

        let tensor_desc = TensorDescription::new(
            parameters.tiling,
            parameters.format,
            &parameters.dimensions,
            &parameters.strides,
            vk::TensorUsageFlagsARM::SHADER,
        );
        let allocator = tensor_allocator(context, self.tensor_offset, self.use_dma_heap_allocator);
        let tensor = TensorWithMemory::new_with_allocator_external(
            context,
            &allocator,
            &tensor_desc,
            MemoryRequirement::ANY,
            self.use_dma_heap_allocator,
        )?;
        let tensor_view = TensorView::new(device, tensor.get(), parameters.format)?;

        let buffer_size = u64::from(elements) * kind.size() as u64;
        let make_buffer = || {
            BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let src_buffer = make_buffer()?;
        let dst_buffer = make_buffer()?;

        let mut src_buffer_memory = StridedMemory::new(&[i64::from(elements)], &[], kind);
        let mut dst_buffer_memory = StridedMemory::new(&[i64::from(elements)], &[], kind);
        src_buffer_memory.fill();
        dst_buffer_memory.clear();
        for (memory, buffer) in [(&src_buffer_memory, &src_buffer), (&dst_buffer_memory, &dst_buffer)] {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    memory.data().as_ptr(),
                    buffer.get_allocation().get_host_ptr(),
                    buffer_size as usize,
                );
            }
            flush_alloc(device, buffer.get_allocation())?;
        }

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::TENSOR_ARM, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let make_pool = || {
            create_descriptor_pool(
                device,
                &[
                    pool_size(vk::DescriptorType::TENSOR_ARM, 1),
                    pool_size(vk::DescriptorType::STORAGE_BUFFER, 1),
                ],
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                1,
            )
        };
        let buffer_to_tensor_descriptor_pool = make_pool()?;
        let tensor_to_buffer_descriptor_pool = make_pool()?;
        let buffer_to_tensor_descriptor_set =
            make_descriptor_set(device, *buffer_to_tensor_descriptor_pool, *descriptor_set_layout)?;
        let tensor_to_buffer_descriptor_set =
            make_descriptor_set(device, *tensor_to_buffer_descriptor_pool, *descriptor_set_layout)?;

        let src_buffer_descriptor_info = [make_descriptor_buffer_info(src_buffer.get(), 0, buffer_size)];
        let dst_buffer_descriptor_info = [make_descriptor_buffer_info(dst_buffer.get(), 0, buffer_size)];
        let tensor_views = [tensor_view.get()];
        let tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
            tensor_view_count: 1,
            tensor_views: tensor_views.as_ptr(),
            ..Default::default()
        };
        let writes = [
            tensor_descriptor_write(buffer_to_tensor_descriptor_set.get(), 0, 0, &tensor_descriptor_info),
            vk::WriteDescriptorSet::builder()
                .dst_set(buffer_to_tensor_descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&src_buffer_descriptor_info)
                .build(),
            tensor_descriptor_write(tensor_to_buffer_descriptor_set.get(), 0, 0, &tensor_descriptor_info),
            vk::WriteDescriptorSet::builder()
                .dst_set(tensor_to_buffer_descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&dst_buffer_descriptor_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        {
            let rank = parameters.dimensions.len();
            let binaries = context.get_binary_collection();
            let buffer_to_tensor_binary = binaries.get(&format!("r{rank}_write"))?;
            let tensor_to_buffer_binary = binaries.get(&format!("r{rank}_read"))?;

            let buffer_to_tensor_shader_module = create_shader_module(device, buffer_to_tensor_binary)?;
            let tensor_to_buffer_shader_module = create_shader_module(device, tensor_to_buffer_binary)?;

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let buffer_to_tensor_pipeline =
                make_compute_pipeline(device, *pipeline_layout, *buffer_to_tensor_shader_module)?;
            let tensor_to_buffer_pipeline =
                make_compute_pipeline(device, *pipeline_layout, *tensor_to_buffer_shader_module)?;

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, cmd_buffer.get())?;

            let tensor_barrier = make_tensor_memory_barrier(
                vk::PipelineStageFlags2::COMPUTE_SHADER,
                vk::AccessFlags2::SHADER_WRITE,
                vk::PipelineStageFlags2::COMPUTE_SHADER,
                vk::AccessFlags2::SHADER_READ,
                0,
                0,
                tensor.get(),
            );
            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                dst_buffer.get(),
                0,
                buffer_size,
            );

            let dispatch_count = single_dimension_workgroup_count(elements, SHADER_TENSOR_ACCESS_WORKGROUP_SIZE);
            assert!(dispatch_count <= DISPATCH_WORKGROUP_COUNT_LIMIT);

            unsafe {
                device.cmd_bind_pipeline(
                    cmd_buffer.get(),
                    vk::PipelineBindPoint::COMPUTE,
                    *buffer_to_tensor_pipeline,
                );
                device.cmd_bind_descriptor_sets(
                    cmd_buffer.get(),
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[buffer_to_tensor_descriptor_set.get()],
                    &[],
                );
                device.cmd_dispatch(cmd_buffer.get(), dispatch_count, 1, 1);
            }

            cmd_tensor_memory_barrier(device, cmd_buffer.get(), &tensor_barrier);

            unsafe {
                device.cmd_bind_pipeline(
                    cmd_buffer.get(),
                    vk::PipelineBindPoint::COMPUTE,
                    *tensor_to_buffer_pipeline,
                );
                device.cmd_bind_descriptor_sets(
                    cmd_buffer.get(),
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[tensor_to_buffer_descriptor_set.get()],
                    &[],
                );
                device.cmd_dispatch(cmd_buffer.get(), dispatch_count, 1, 1);
                device.cmd_pipeline_barrier(
                    cmd_buffer.get(),
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        invalidate_alloc(device, src_buffer.get_allocation())?;
        invalidate_alloc(device, dst_buffer.get_allocation())?;
        for (memory, buffer) in [
            (&mut src_buffer_memory, &src_buffer),
            (&mut dst_buffer_memory, &dst_buffer),
        ] {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    buffer.get_allocation().get_host_ptr(),
                    memory.data_mut().as_mut_ptr(),
                    buffer_size as usize,
                );
            }
        }

        let result: TestStatus = compare_strided_memory(&src_buffer_memory, &dst_buffer_memory);
        Ok(result)
    }
}

impl TestInstance for OptimalTensorAccessTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

fn add_linear(
    cases: &mut HashMap<String, Box<dyn TestCase>>,
    parameters: &TensorParameters,
    variant: AccessVariant,
    tensor_offset: u64,
    forced_staging: bool,
    use_dma_heap_allocator: bool,
) {
    let mut name = format!("{}_{}", params_to_string(parameters), variant.name());
    if tensor_offset != 0 {
        name.push_str(&format!("_offset_{tensor_offset}"));
    }
    if forced_staging {
        name.push_str("_forced_staging");
    }
    if use_dma_heap_allocator {
        name.push_str("_dma_heap_buffer");
    }
    cases.insert(
        format!("basic_access.{name}"),
        Box::new(LinearTensorAccessTestCase {
            name,
            parameters: parameters.clone(),
            variant,
            tensor_offset,
            use_dma_heap_allocator,
        }),
    );
}

fn add_optimal(
    cases: &mut HashMap<String, Box<dyn TestCase>>,
    parameters: &TensorParameters,
    tensor_offset: u64,
    use_dma_heap_allocator: bool,
) {
    let mut name = params_to_string(parameters);
    if tensor_offset != 0 {
        name.push_str(&format!("_offset_{tensor_offset}"));
    }
    if use_dma_heap_allocator {
        name.push_str("_dma_heap_buffer");
    }
    cases.insert(
        format!("basic_access.{name}"),
        Box::new(OptimalTensorAccessTestCase {
            name,
            parameters: parameters.clone(),
            tensor_offset,
            use_dma_heap_allocator,
        }),
    );
}

/// `addShaderAccessTests<Format>`
fn add_shader_access_tests(cases: &mut HashMap<String, Box<dyn TestCase>>, format: vk::Format) {
    const SHAPES: [&[i64]; 5] = [
        &[71693],
        &[263, 269],
        &[37, 43, 47],
        &[13, 17, 19, 23],
        &[7, 11, 13, 17, 19, 23],
    ];
    let shape_4d = SHAPES[3];
    let shape_6d = SHAPES[4];
    let element_size = get_format_size(format);
    let both = [AccessVariant::ReadFromBuffer, AccessVariant::WriteToBuffer];

    for shape in SHAPES {
        let rank = shape.len();

        // Implicitly packed linear
        let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &[]);
        for variant in both {
            add_linear(cases, &params, variant, 0, false, false);
        }

        // Explicit non-packed strides, not applicable to rank 1 tensors
        if rank > 1 {
            let mut padded_strides = vec![0i64; rank];
            padded_strides[rank - 1] = element_size as i64;
            for i in 2..=rank {
                padded_strides[rank - i] =
                    padded_strides[rank - i + 1] * shape[rank - i + 1] + 13 * element_size as i64;
            }
            let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &padded_strides);
            for variant in both {
                add_linear(cases, &params, variant, 0, false, false);
            }
        }

        // Explicit packed strides
        let packed_strides = get_tensor_strides(shape, element_size, 1);
        let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &packed_strides);
        for variant in both {
            add_linear(cases, &params, variant, 0, false, false);
        }

        // Optimal
        add_optimal(
            cases,
            &TensorParameters::new(format, vk::TensorTilingARM::OPTIMAL, shape, &[]),
            0,
            false,
        );
    }

    // Tests to force use of staging buffer even when tensor memory is host visible, then tests binding tensor to offset within allocation
    for (tensor_offset, forced_staging) in [(0u64, true), (2000, false)] {
        for shape in [shape_4d, shape_6d] {
            let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &[]);
            for variant in [AccessVariant::WriteToBuffer, AccessVariant::ReadFromBuffer] {
                add_linear(cases, &params, variant, tensor_offset, forced_staging, false);
            }
        }
    }

    // Test max dimension count supported by implementation
    let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, &[], &[]);
    for variant in [AccessVariant::WriteToBuffer, AccessVariant::ReadFromBuffer] {
        add_linear(cases, &params, variant, 0, false, false);
    }
    add_optimal(
        cases,
        &TensorParameters::new(format, vk::TensorTilingARM::OPTIMAL, &[], &[]),
        0,
        false,
    );
}

/// `addDmaHeapBufferAccessTests<Format>`
fn add_dma_heap_buffer_access_tests(cases: &mut HashMap<String, Box<dyn TestCase>>, format: vk::Format) {
    const SHAPES: [&[i64]; 2] = [&[13, 17, 19, 23], &[7, 11, 13, 17, 19, 23]];
    let both = [AccessVariant::ReadFromBuffer, AccessVariant::WriteToBuffer];

    for shape in SHAPES {
        let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &[]);
        for variant in both {
            add_linear(cases, &params, variant, 0, false, true);
        }

        let params = TensorParameters::new(format, vk::TensorTilingARM::OPTIMAL, shape, &[]);
        add_optimal(cases, &params, 0, true);
        add_optimal(cases, &params, 2000, true);
    }

    for shape in SHAPES {
        let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &[]);
        for variant in both {
            add_linear(cases, &params, variant, 0, true, true);
        }
    }

    for shape in SHAPES {
        let params = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &[]);
        for variant in both {
            add_linear(cases, &params, variant, 2000, false, true);
        }
    }
}

/// `createBasicAccessTests`: the cases keyed by their dotted path (`basic_access.<name>`)
pub fn create_basic_access_cases() -> HashMap<String, Box<dyn TestCase>> {
    let mut cases = HashMap::new();
    for format in [
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R64_UINT,
        vk::Format::R64_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R32_SFLOAT,
        vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM,
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM,
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM,
    ] {
        add_shader_access_tests(&mut cases, format);
    }
    for format in [
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R64_UINT,
        vk::Format::R64_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R32_SFLOAT,
    ] {
        add_dma_heap_buffer_access_tests(&mut cases, format);
    }
    cases
}
