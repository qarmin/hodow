// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorUpdateAfterBind.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader is `genShaderTensorAccess(4, format, WRITE_TO_BUFFER)`, which is program `r4_read` of the
// `tensor_basic_access` manifest. `DescriptorSetLayoutBuilder` has no binding flags, so the layout is made here. The cases are returned keyed by their dotted
// path so `tensor::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;

use super::required_tests::get_tensor_physical_device_features;
use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, TensorWithMemory,
    compare_strided_memory, create_descriptor_pool, device_supports_shader_stages_tensor_access,
    device_supports_shader_tensor_access, download_from_tensor, format_support_tensor_flags, make_compute_pipeline,
    params_to_string, pool_size, require_tensor_shape_supported, single_dimension_workgroup_count,
    tensor_descriptor_write, tensor_format_short_name, upload_to_tensor,
};
use crate::generated::shaders::tensor_basic_access::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

const SHADER_TENSOR_ACCESS_WORKGROUP_SIZE: u32 = 128;

struct UpdateAfterBindTestCase {
    name: String,
    parameters: TensorParameters,
    empty_descriptor_set: bool,
}

impl TestCase for UpdateAfterBindTestCase {
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

        if get_tensor_physical_device_features(context).descriptor_binding_storage_tensor_update_after_bind == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Device does not support updating storage tensor descriptors after a set is bound".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!("ba_{}", tensor_format_short_name(self.parameters.format));
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UpdateAfterBindTestInstance {
            context,
            parameters: &self.parameters,
            empty_descriptor_set: self.empty_descriptor_set,
        })
    }
}

struct UpdateAfterBindTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: &'a TensorParameters,
    empty_descriptor_set: bool,
}

impl UpdateAfterBindTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let parameters = self.parameters;
        let kind = ElementKind::for_format(parameters.format);

        let tensor_count = if self.empty_descriptor_set { 1 } else { 2 };

        let mut tensors = Vec::new();
        let mut tensor_views = Vec::new();
        for i in 0..tensor_count {
            let tensor_desc = TensorDescription::new(
                parameters.tiling,
                parameters.format,
                &parameters.dimensions,
                &parameters.strides,
                vk::TensorUsageFlagsARM::SHADER,
            );
            let tensor = TensorWithMemory::new(context, &tensor_desc, MemoryRequirement::ANY)?;
            tensor_views.push(TensorView::new(device, tensor.get(), parameters.format)?);

            // Single 4D shape is tested
            let mut tensor_data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
            tensor_data.fill_from(i);
            upload_to_tensor(context, &tensor, tensor_data.data())?;
            tensors.push(tensor);
        }

        let element_count = parameters.elements() as u32;
        let buffer_size = u64::from(element_count) * kind.size() as u64;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, buffer_size as usize) };
        flush_alloc(device, buffer.get_allocation())?;

        let bindings = [
            vk::DescriptorSetLayoutBinding {
                binding: 0,
                descriptor_type: vk::DescriptorType::TENSOR_ARM,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            },
        ];
        let binding_flags = [
            vk::DescriptorBindingFlags::UPDATE_AFTER_BIND,
            vk::DescriptorBindingFlags::empty(),
        ];
        let mut binding_flags_info =
            vk::DescriptorSetLayoutBindingFlagsCreateInfo::builder().binding_flags(&binding_flags);
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder()
            .flags(vk::DescriptorSetLayoutCreateFlags::UPDATE_AFTER_BIND_POOL)
            .bindings(&bindings)
            .push_next(&mut binding_flags_info);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );

        let descriptor_pool = create_descriptor_pool(
            device,
            &[
                pool_size(vk::DescriptorType::TENSOR_ARM, 1),
                pool_size(vk::DescriptorType::STORAGE_BUFFER, 1),
            ],
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET | vk::DescriptorPoolCreateFlags::UPDATE_AFTER_BIND,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_descriptor_info = [make_descriptor_buffer_info(buffer.get(), 0, buffer_size)];

        if !self.empty_descriptor_set {
            let views = [tensor_views[1].get()];
            let tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
                tensor_view_count: 1,
                tensor_views: views.as_ptr(),
                ..Default::default()
            };
            let write = tensor_descriptor_write(descriptor_set.get(), 0, 0, &tensor_descriptor_info);
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }

        let buffer_write = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(1)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&buffer_descriptor_info)
            .build();
        unsafe { device.update_descriptor_sets(&[buffer_write], &[] as &[vk::CopyDescriptorSet]) };

        {
            let binary = context.get_binary_collection().get("r4_read")?;
            let shader_module = create_shader_module(device, binary)?;

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, cmd_buffer.get())?;

            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                buffer.get(),
                0,
                buffer_size,
            );

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

            let dispatch_count = single_dimension_workgroup_count(element_count, SHADER_TENSOR_ACCESS_WORKGROUP_SIZE);
            assert!(dispatch_count <= 65535);
            unsafe {
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

            // Update descriptor set with new tensor descriptor
            {
                let views = [tensor_views[0].get()];
                let new_tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
                    tensor_view_count: 1,
                    tensor_views: views.as_ptr(),
                    ..Default::default()
                };
                let write = tensor_descriptor_write(descriptor_set.get(), 0, 0, &new_tensor_descriptor_info);
                unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            }

            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut buffer_memory = StridedMemory::new(&[i64::from(element_count)], &[], kind);
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer.get_allocation().get_host_ptr(),
                buffer_memory.data_mut().as_mut_ptr(),
                buffer_size as usize,
            );
        }

        let mut tensor_data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
        let downloaded = download_from_tensor(context, &tensors[0], tensor_data.memory_size())?;
        tensor_data.data_mut().copy_from_slice(&downloaded);

        Ok(compare_strided_memory(&tensor_data, &buffer_memory))
    }
}

impl TestInstance for UpdateAfterBindTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `createUpdateAfterBindTests`: the cases keyed by their dotted path (`update_after_bind.<name>`)
pub fn create_update_after_bind_cases() -> HashMap<String, Box<dyn TestCase>> {
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
        // Implicitly packed linear
        let parameters = TensorParameters::new(format, vk::TensorTilingARM::LINEAR, &shape_4d, &[]);
        // an empty descriptor set, then a descriptor set with one tensor binding
        for empty_descriptor_set in [true, false] {
            let name = format!(
                "single_update_{}_binding_{}",
                if empty_descriptor_set { "empty" } else { "single" },
                params_to_string(&parameters)
            );
            cases.insert(
                format!("update_after_bind.{name}"),
                Box::new(UpdateAfterBindTestCase {
                    name,
                    parameters: parameters.clone(),
                    empty_descriptor_set,
                }),
            );
        }
    }
    cases
}
