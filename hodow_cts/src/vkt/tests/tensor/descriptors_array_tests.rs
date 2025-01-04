// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorDescriptorsArray.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `genShaderTensorDescriptorsArrayAccess` is `scripts/gen_tensor_manifests.py` (per format one case with a shader
// per descriptor count, `comp<count>`); `DescriptorSetLayoutBuilder::add_indexed_binding` and `DescriptorPoolBuilder` cannot hold an array of `TENSOR_ARM`
// descriptors, so the layout and pool are made here. The cases are returned keyed by their dotted path so `tensor::create_tests` can swap them in for the
// gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;

use super::required_tests::get_tensor_physical_device_features;
use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, TensorWithMemory,
    compare_strided_memory, create_descriptor_pool, device_supports_shader_stages_tensor_access,
    device_supports_shader_tensor_access, format_support_tensor_flags, make_compute_pipeline, params_to_string,
    pool_size, require_tensor_shape_supported, single_dimension_workgroup_count, tensor_descriptor_write,
    tensor_format_short_name, upload_to_tensor,
};
use crate::generated::shaders::tensor_descriptors_array::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

const RANGE_START: u32 = 0x1;
const RANGE_MID: u32 = 0x2;
const RANGE_END: u32 = 0x4;

struct DescriptorsArrayTestCase {
    name: String,
    parameters: TensorParameters,
    descriptor_count: u32,
    update_range: u32,
}

impl TestCase for DescriptorsArrayTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;

        require_tensor_shape_supported(context, &self.parameters)?;

        if !format_support_tensor_flags(
            context,
            self.parameters.format,
            self.parameters.tiling,
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

        if get_tensor_physical_device_features(context).shader_storage_tensor_array_dynamic_indexing == vk::FALSE {
            return Err(TestError::NotSupported(
                "Device does not support indexing arrays of storage tensors using dynamically uniform integer expressions in shader code"
                    .to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!("da_{}", tensor_format_short_name(self.parameters.format));
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DescriptorsArrayTestInstance {
            context,
            parameters: &self.parameters,
            descriptor_count: self.descriptor_count,
            update_range: self.update_range,
        })
    }
}

struct DescriptorsArrayTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: &'a TensorParameters,
    descriptor_count: u32,
    update_range: u32,
}

impl DescriptorsArrayTestInstance<'_> {
    fn initialise_descriptor_update_mask(&self, descriptor_update_mask: &mut [bool]) {
        let b0 = self.descriptor_count / 3;
        let b1 = (2 * self.descriptor_count) / 3;

        if self.update_range & RANGE_START != 0 {
            descriptor_update_mask[..b0 as usize].fill(true);
        }
        if self.update_range & RANGE_MID != 0 {
            descriptor_update_mask[b0 as usize..b1 as usize].fill(true);
        }
        if self.update_range & RANGE_END != 0 {
            descriptor_update_mask[b1 as usize..self.descriptor_count as usize].fill(true);
        }
    }

    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let parameters = self.parameters;
        let kind = ElementKind::for_format(parameters.format);
        let descriptor_count = self.descriptor_count as usize;

        let mut descriptor_update_mask = vec![false; descriptor_count];
        self.initialise_descriptor_update_mask(&mut descriptor_update_mask);

        let make_tensor = || {
            let tensor_desc = TensorDescription::new(
                parameters.tiling,
                parameters.format,
                &parameters.dimensions,
                &parameters.strides,
                vk::TensorUsageFlagsARM::SHADER,
            );
            TensorWithMemory::new(context, &tensor_desc, MemoryRequirement::ANY)
        };

        let mut tensors = Vec::new();
        let mut tensor_views = Vec::new();
        let mut expected_tensor_data = Vec::new();

        for desc_idx in 0..descriptor_count {
            let tensor = make_tensor()?;
            tensor_views.push(TensorView::new(device, tensor.get(), parameters.format)?);

            // Tensors marked for update start fill with host-type max/2 + descriptor index, all other tensors start fill at descriptor index
            let desc_value = desc_idx as u64;
            let update_value = max_value(kind) / 2 + desc_value;
            let fill_value = if descriptor_update_mask[desc_idx] {
                update_value
            } else {
                desc_value
            };
            let mut data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
            data.fill_from(fill_value);

            upload_to_tensor(context, &tensor, data.data())?;
            tensors.push(tensor);
            expected_tensor_data.push(data);
        }

        // Tensors, views and expected elements of the descriptors marked for update, filled using the descriptor index as the start value
        let mut update_tensors = Vec::new();
        let mut update_tensor_views = Vec::new();
        let mut update_tensor_data = Vec::new();
        for desc_idx in (0..descriptor_count).filter(|&i| descriptor_update_mask[i]) {
            let tensor = make_tensor()?;
            update_tensor_views.push(TensorView::new(device, tensor.get(), parameters.format)?);

            let mut data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
            data.fill_from(desc_idx as u64);
            upload_to_tensor(context, &tensor, data.data())?;
            update_tensors.push(tensor);
            update_tensor_data.push(data);
        }

        let tensor_element_count = parameters.elements() as u32;
        let total_element_count = tensor_element_count as usize * descriptor_count;
        let buffer_size = (total_element_count * kind.size()) as u64;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, buffer_size as usize) };
        flush_alloc(device, buffer.get_allocation())?;
        let buffer_descriptor_info = [make_descriptor_buffer_info(buffer.get(), 0, buffer_size)];

        // Uniform buffer of the descriptor indices for indexing the array of tensors
        let u_buffer_size = (descriptor_count * std::mem::size_of::<u32>()) as u64;
        let u_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(u_buffer_size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let indices: Vec<u32> = (0..descriptor_count as u32).collect();
        unsafe {
            std::ptr::copy_nonoverlapping(
                indices.as_ptr().cast::<u8>(),
                u_buffer.get_allocation().get_host_ptr(),
                u_buffer_size as usize,
            );
        }
        flush_alloc(device, u_buffer.get_allocation())?;
        let u_buffer_descriptor_info = [make_descriptor_buffer_info(u_buffer.get(), 0, u_buffer_size)];

        let bindings = [
            vk::DescriptorSetLayoutBinding {
                binding: 0,
                descriptor_type: vk::DescriptorType::TENSOR_ARM,
                descriptor_count: self.descriptor_count,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 1,
                descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 2,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
        ];
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );

        let descriptor_pool = create_descriptor_pool(
            device,
            &[
                pool_size(vk::DescriptorType::TENSOR_ARM, self.descriptor_count),
                pool_size(vk::DescriptorType::UNIFORM_BUFFER, 1),
                pool_size(vk::DescriptorType::STORAGE_BUFFER, 1),
            ],
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        {
            let tensor_view_handles: Vec<vk::TensorViewARM> = tensor_views.iter().map(TensorView::get).collect();
            let tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
                tensor_view_count: self.descriptor_count,
                tensor_views: tensor_view_handles.as_ptr(),
                ..Default::default()
            };
            let writes = [
                tensor_descriptor_write(descriptor_set.get(), 0, 0, &tensor_descriptor_info),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                    .buffer_info(&u_buffer_descriptor_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(2)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&buffer_descriptor_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let binary = context
            .get_binary_collection()
            .get(&format!("comp{}", self.descriptor_count))?;
        let shader_module = create_shader_module(device, binary)?;

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

        let mut update_idx = 0;
        for desc_idx in 0..descriptor_count {
            if !descriptor_update_mask[desc_idx] {
                continue;
            }

            let views = [update_tensor_views[update_idx].get()];
            let update_tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
                tensor_view_count: 1,
                tensor_views: views.as_ptr(),
                ..Default::default()
            };
            let write =
                tensor_descriptor_write(descriptor_set.get(), 0, desc_idx as u32, &update_tensor_descriptor_info);
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            // Update expected tensor elements for tensor by index
            std::mem::swap(&mut expected_tensor_data[desc_idx], &mut update_tensor_data[update_idx]);
            descriptor_update_mask[desc_idx] = false;
            update_idx += 1;

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

            let dispatch_count_x = single_dimension_workgroup_count(tensor_element_count, 128);
            assert!(dispatch_count_x <= 65535);
            let dispatch_count_y = self.descriptor_count;
            unsafe { device.cmd_dispatch(cmd_buffer.get(), dispatch_count_x, dispatch_count_y, 1) };

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

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;

            unsafe { device.reset_command_buffer(cmd_buffer.get(), vk::CommandBufferResetFlags::empty()) }
                .vk_check("vkResetCommandBuffer")?;

            // Every element written to the buffer for a descriptor must match the expected tensor element
            invalidate_alloc(device, buffer.get_allocation())?;
            for (i, expected) in expected_tensor_data.iter().enumerate() {
                let mut buffer_memory_view = StridedMemory::new(&[i64::from(tensor_element_count)], &[], kind);
                let slice_size = tensor_element_count as usize * kind.size();
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        buffer.get_allocation().get_host_ptr().add(slice_size * i),
                        buffer_memory_view.data_mut().as_mut_ptr(),
                        slice_size,
                    );
                }

                let status = compare_strided_memory(expected, &buffer_memory_view);
                if status.is_fail() {
                    return Ok(status);
                }
            }
        }

        drop(update_tensors);
        drop(tensors);
        Ok(TestStatus::pass("Tensor test succeeded"))
    }
}

impl TestInstance for DescriptorsArrayTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `std::numeric_limits<T>::max()` of an integer host type
fn max_value(kind: ElementKind) -> u64 {
    match kind {
        ElementKind::UInt(size) => {
            if size >= 8 {
                u64::MAX
            } else {
                (1u64 << (8 * size)) - 1
            }
        }
        ElementKind::SInt(size) => (1u64 << (8 * size - 1)) - 1,
        ElementKind::Float(_) => unreachable!("only the integer formats are tested"),
    }
}

/// `createTensorDescriptorsArrayTests`: the cases keyed by their dotted path (`descriptors_array_update.<name>`)
pub fn create_descriptors_array_cases() -> HashMap<String, Box<dyn TestCase>> {
    let shape_4d = [16i64, 8, 12, 4];
    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for format in [
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R64_UINT,
        vk::Format::R64_SINT,
    ] {
        // Implicitly packed linear, dynamic uniform indexing
        let parameters = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, &shape_4d, &[]);
        for (descriptor_count, update_range, range_name) in
            [(8u32, RANGE_START | RANGE_END, "start_end_"), (6, RANGE_MID, "mid_")]
        {
            let name = format!(
                "range_{range_name}dynamic_uniform_indexing_{}",
                params_to_string(&parameters)
            );
            cases.insert(
                format!("descriptors_array_update.{name}"),
                Box::new(DescriptorsArrayTestCase {
                    name,
                    parameters: parameters.clone(),
                    descriptor_count,
                    update_range,
                }),
            );
        }
    }
    cases
}
