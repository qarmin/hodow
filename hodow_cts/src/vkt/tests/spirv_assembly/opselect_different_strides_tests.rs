// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmOpSelectDifferentStridesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly (with the EXT and the KHR spelling of the physical storage buffer extension) is in
// `shaders/manifest/spirv_assembly_opselect_different_strides.toml`, written by `scripts/gen_spirv_assembly_opselect_different_strides_manifest.py`.
// The case runs once on the universal queue instead of through `MultiQueueRunnerTestInstance`, and the device capabilities are checked in `check_support`
// against the device the context already created with these features chained.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::spirv_assembly_opselect_different_strides::ALL_OP_SELECT_DIFFERENT_STRIDES_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: `OpSelectDifferentStridesCase`.
#[derive(Clone, Copy)]
pub struct OpSelectDifferentStridesCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

fn query_features<T: Default>(context: &Context<'_>) -> T {
    let mut features = T::default();
    let mut features2 = vk::PhysicalDeviceFeatures2 {
        next: std::ptr::from_mut(&mut features).cast(),
        ..Default::default()
    };
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features
}

fn not_supported(what: &str) -> TestError {
    TestError::NotSupported(format!("{what} not supported by device"))
}

impl TestCase for OpSelectDifferentStridesCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `OpSelectDifferentStridesCase::initDeviceCapabilities`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let vulkan12: vk::PhysicalDeviceVulkan12Features = query_features(context);
        if vulkan12.buffer_device_address == vk::FALSE {
            return Err(not_supported("bufferDeviceAddress"));
        }
        if vulkan12.scalar_block_layout == vk::FALSE {
            return Err(not_supported("scalarBlockLayout"));
        }
        let buffer_device_address_extension = if context.api_version() < (1, 2, 0) {
            "VK_EXT_buffer_device_address"
        } else {
            "VK_KHR_buffer_device_address"
        };
        context
            .require_device_functionality(buffer_device_address_extension)
            .map_err(|_| not_supported(buffer_device_address_extension))?;

        let mutable: vk::PhysicalDeviceMutableDescriptorTypeFeaturesEXT = query_features(context);
        if mutable.mutable_descriptor_type == vk::FALSE {
            return Err(not_supported("mutableDescriptorType"));
        }
        for extension in [
            "VK_EXT_mutable_descriptor_type",
            "VK_EXT_scalar_block_layout",
            "VK_KHR_variable_pointers",
        ] {
            context
                .require_device_functionality(extension)
                .map_err(|_| not_supported(extension))?;
        }

        let vulkan11: vk::PhysicalDeviceVulkan11Features = query_features(context);
        if vulkan11.variable_pointers == vk::FALSE {
            return Err(not_supported("variablePointers"));
        }
        if vulkan11.variable_pointers_storage_buffer == vk::FALSE {
            return Err(not_supported("variablePointersStorageBuffer"));
        }

        if context.get_device_features().shader_int64 == vk::FALSE {
            return Err(not_supported("shaderInt64"));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OpSelectDifferentStridesInstance { context })
    }
}

struct OpSelectDifferentStridesInstance<'a> {
    context: &'a Context<'a>,
}

#[derive(Clone, Copy)]
struct PushConstant {
    x: u32,
    y: u32,
    z: u32,
    w: u32,
}

impl PushConstant {
    fn bytes(&self) -> Vec<u8> {
        [self.x, self.y, self.z, self.w]
            .iter()
            .flat_map(|v| v.to_ne_bytes())
            .collect()
    }
}

fn buffer_address(context: &Context<'_>, buffer: &BufferWithMemory<'_>) -> vk::DeviceAddress {
    unsafe {
        context
            .get_device()
            .get_buffer_device_address(&vk::BufferDeviceAddressInfo::builder().buffer(buffer.get()))
    }
}

/// `makeStdBeginEnd` plus the copy: `count` elements of `components` u32 each at the start of `data`.
fn read_elements(data: &[u8], components: usize, count: usize) -> Vec<Vec<u32>> {
    (0..count)
        .map(|i| {
            (0..components)
                .map(|c| {
                    let offset = (i * components + c) * 4;
                    u32::from_ne_bytes(data[offset..offset + 4].try_into().expect("four bytes"))
                })
                .collect()
        })
        .collect()
}

impl TestInstance for OpSelectDifferentStridesInstance<'_> {
    /// `OpSelectDifferentStridesInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let pc0set = [0u32, 3, 7, 5];
        let pc1set = [1u32, 8, 5, 11];
        let element_count = (pc0set[1].max(pc1set[1]) + 10).div_ceil(16) * 16;

        let buffer_size = (8 + 8 + element_count * 16) as vk::DeviceSize;
        let usage = vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        let requirement =
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT | MemoryRequirement::DEVICE_ADDRESS;
        let foo_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, usage),
            requirement,
        )?;
        let bar_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, usage),
            requirement,
        )?;
        let foo_address = buffer_address(context, &foo_buffer);
        let bar_address = buffer_address(context, &bar_buffer);

        // two sets of two mutable bindings that can hold storage buffers
        let mutable_types = [vk::DescriptorType::STORAGE_BUFFER];
        let mutable_lists = [
            vk::MutableDescriptorTypeListEXT::builder()
                .descriptor_types(&mutable_types)
                .build(),
            vk::MutableDescriptorTypeListEXT::builder()
                .descriptor_types(&mutable_types)
                .build(),
        ];
        let mut mutable_info =
            vk::MutableDescriptorTypeCreateInfoEXT::builder().mutable_descriptor_type_lists(&mutable_lists);

        let pool_sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::MUTABLE_EXT,
            descriptor_count: 2,
        }];
        let pool_mutable_lists = [vk::MutableDescriptorTypeListEXT::builder()
            .descriptor_types(&mutable_types)
            .build()];
        let mut pool_mutable_info =
            vk::MutableDescriptorTypeCreateInfoEXT::builder().mutable_descriptor_type_lists(&pool_mutable_lists);
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(1)
            .pool_sizes(&pool_sizes)
            .push_next(&mut pool_mutable_info);
        let make_pool = || -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
            Ok(Unique::new(
                device,
                unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
            ))
        };
        let ds_foo_pool = make_pool()?;
        let ds_bar_pool = make_pool()?;

        let bindings: Vec<vk::DescriptorSetLayoutBinding> = (0..2)
            .map(|binding| vk::DescriptorSetLayoutBinding {
                binding,
                descriptor_type: vk::DescriptorType::MUTABLE_EXT,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            })
            .collect();
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder()
            .bindings(&bindings)
            .push_next(&mut mutable_info);
        let make_layout = || -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
            Ok(Unique::new(
                device,
                unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                    .vk_check("vkCreateDescriptorSetLayout")?,
            ))
        };
        let ds_foo_layout = make_layout()?;
        let ds_bar_layout = make_layout()?;

        let desc_set_foo = make_descriptor_set(device, *ds_foo_pool, *ds_foo_layout)?;
        let desc_set_bar = make_descriptor_set(device, *ds_bar_pool, *ds_bar_layout)?;

        let foo_buffer_info = make_descriptor_buffer_info(foo_buffer.get(), 0, buffer_size);
        let bar_buffer_info = make_descriptor_buffer_info(bar_buffer.get(), 0, buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                desc_set_foo.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &foo_buffer_info,
            )
            .write_single(
                desc_set_foo.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &bar_buffer_info,
            )
            .write_single(
                desc_set_bar.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &bar_buffer_info,
            )
            .write_single(
                desc_set_bar.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &foo_buffer_info,
            )
            .update(device);

        let pc_range = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: 16,
        }];
        let make_pipeline_layout =
            |layout: vk::DescriptorSetLayout| -> Result<Unique<'_, vk::PipelineLayout>, TestError> {
                let set_layouts = [layout];
                let info = vk::PipelineLayoutCreateInfo::builder()
                    .set_layouts(&set_layouts)
                    .push_constant_ranges(&pc_range);
                Ok(Unique::new(
                    device,
                    unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
                ))
            };
        let pl_foo = make_pipeline_layout(*ds_foo_layout)?;
        let pl_bar = make_pipeline_layout(*ds_bar_layout)?;

        let module_name = if context.api_version() < (1, 2, 0) {
            "compute_ext"
        } else {
            "compute_khr"
        };
        let comp_shader_module = create_shader_module(device, context.get_binary_collection().get(module_name)?)?;

        let make_pipeline = |layout: vk::PipelineLayout| -> Result<Unique<'_, vk::Pipeline>, TestError> {
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*comp_shader_module)
                .name(b"main\0")
                .build();
            let info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(layout)
                .base_pipeline_index(0)
                .build();
            Ok(Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            ))
        };
        let pipeline_foo = make_pipeline(*pl_foo)?;
        let pipeline_bar = make_pipeline(*pl_bar)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let barriers = [
            make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                foo_buffer.get(),
                0,
                buffer_size,
            ),
            make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                bar_buffer.get(),
                0,
                buffer_size,
            ),
        ];

        let pc_foo = PushConstant {
            x: pc0set[0],
            y: pc0set[1],
            z: pc0set[2],
            w: pc0set[3],
        };
        let pc_bar = PushConstant {
            x: pc1set[0],
            y: pc1set[1],
            z: pc1set[2],
            w: pc1set[3],
        };

        for (buffer, address) in [(&foo_buffer, foo_address), (&bar_buffer, bar_address)] {
            unsafe {
                std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, buffer_size as usize);
                std::ptr::copy_nonoverlapping(
                    address.to_ne_bytes().as_ptr(),
                    buffer.get_allocation().get_host_ptr(),
                    8,
                );
            }
            flush_alloc(device, buffer.get_allocation())?;
        }

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline_foo);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pl_foo,
                0,
                &[desc_set_foo.get()],
                &[] as &[u32],
            );
            device.cmd_push_constants(cmd, *pl_foo, vk::ShaderStageFlags::COMPUTE, 0, &pc_foo.bytes());
            device.cmd_dispatch(cmd, 1, 1, 1);

            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::BY_REGION,
                &[] as &[vk::MemoryBarrier],
                &barriers,
                &[] as &[vk::ImageMemoryBarrier],
            );

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline_bar);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pl_bar,
                0,
                &[desc_set_bar.get()],
                &[] as &[u32],
            );
            device.cmd_push_constants(cmd, *pl_bar, vk::ShaderStageFlags::COMPUTE, 0, &pc_bar.bytes());
            device.cmd_dispatch(cmd, 1, 1, 1);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, foo_buffer.get_allocation())?;
        invalidate_alloc(device, bar_buffer.get_allocation())?;

        // `verifyResult`
        let sum_foo = pc_foo.x + pc_foo.y + pc_foo.z + pc_foo.w;
        let sum_bar = pc_bar.x + pc_bar.y + pc_bar.z + pc_bar.w;
        let count = (pc_foo.y.max(pc_bar.y) + 1).min(element_count) as usize;
        let read = |buffer: &BufferWithMemory<'_>, components: usize| {
            let data = unsafe {
                std::slice::from_raw_parts(
                    buffer.get_allocation().get_host_ptr().cast_const().add(8 + 8),
                    count * components * 4,
                )
            };
            read_elements(data, components, count)
        };

        let foo = read(&foo_buffer, 4);
        let cmp0 = vec![sum_foo, pc_foo.y, pc_foo.z, pc_foo.w];
        let cmp1 = vec![sum_bar, pc_bar.y, pc_bar.z, pc_bar.w];
        let cond_foo = foo[pc_foo.y as usize] == cmp0 && foo[pc_bar.y as usize] == cmp1;
        if !cond_foo {
            log::error!("Result Foo buffer: {foo:?}");
        }

        let bar = read(&bar_buffer, 3);
        let cmp0 = vec![sum_foo, pc_foo.y, pc_foo.z];
        let cmp1 = vec![sum_bar, pc_bar.y, pc_bar.z];
        let cond_bar = bar[pc_foo.y as usize] == cmp0 && bar[pc_bar.y as usize] == cmp1;
        if !cond_bar {
            log::error!("Result Bar buffer: {bar:?}");
        }

        Ok(if cond_foo && cond_bar {
            TestStatus::pass("")
        } else {
            TestStatus::fail("")
        })
    }
}

/// `addOpSelectDifferentStridesTest`: the groups below `compute` of the case, then the case.
pub fn create_opselect_different_strides_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_OP_SELECT_DIFFERENT_STRIDES_CASE
        .iter()
        .map(|case| {
            (
                vec!["variable_pointers", "compute"],
                Box::new(**case) as Box<dyn TestCase>,
            )
        })
        .collect()
}
