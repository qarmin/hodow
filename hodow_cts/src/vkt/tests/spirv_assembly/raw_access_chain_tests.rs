// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmRawAccessChainTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the 6160 cases is in `shaders/manifest/spirv_assembly_raw_access_chain_{load,store}.toml`
// (written by `scripts/gen_spirv_assembly_raw_access_chain_manifest.py`, which replays `addTests` and `CodeGen`); upstream's `Parameters` ride along as the
// `spec` string, and the input, output and expected output are drawn from `de::Random(434)` here exactly the way `addTest` draws them.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::spirv_assembly_raw_access_chain_load::ALL_RAW_ACCESS_CHAIN_CASE as ALL_LOAD_CASE;
use crate::generated::shaders::spirv_assembly_raw_access_chain_store::ALL_RAW_ACCESS_CHAIN_CASE as ALL_STORE_CASE;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

const LOCAL_SIZE: usize = 32;
const NUM_DESCRIPTORS_ELEMENTS: u32 = 8;

/// The `rust_type` of the manifest entries: one `SpvAsmRawAccessChainTestCase`.
#[derive(Clone, Copy)]
pub struct RawAccessChainCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// The part of upstream's `Parameters` the host needs.
#[derive(Clone, Copy)]
struct Params {
    input_size: usize,
    input_components: usize,
    input_pre: usize,
    input_post: usize,
    output_size: usize,
    output_components: usize,
    output_pre: usize,
    output_post: usize,
    variable_pointers: bool,
    descriptor_indexing: bool,
    physical_buffers: bool,
    uses_64bit_indexing: bool,
    input_bounds_check: u32,
    output_bounds_check: u32,
    input_range: u64,
    output_range: u64,
}

const BOUNDS_CHECK_PER_COMPONENT: u32 = 1;
const BOUNDS_CHECK_PER_ELEMENT: u32 = 2;

fn parse(spec: &str) -> Params {
    let number = |key: &str| -> i64 {
        spec.split(';')
            .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
            .unwrap_or_else(|| panic!("raw access chain spec without {key}"))
            .parse()
            .unwrap_or_else(|_| panic!("raw access chain spec with a bad {key}"))
    };
    Params {
        input_size: number("is") as usize,
        input_components: number("ic") as usize,
        input_pre: number("ipre") as usize,
        input_post: number("ipost") as usize,
        output_size: number("os") as usize,
        output_components: number("oc") as usize,
        output_pre: number("opre") as usize,
        output_post: number("opost") as usize,
        variable_pointers: number("vp") != 0,
        descriptor_indexing: number("di") != 0,
        physical_buffers: number("pb") != 0,
        uses_64bit_indexing: number("b64") != 0,
        input_bounds_check: number("ibc") as u32,
        output_bounds_check: number("obc") as u32,
        input_range: number("ir") as u64,
        output_range: number("or") as u64,
    }
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

impl TestCase for RawAccessChainCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `SpvAsmRawAccessChainTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = parse(self.spec);
        context.require_device_functionality("VK_NV_raw_access_chains")?;

        let raw_access_chains: vk::PhysicalDeviceRawAccessChainsFeaturesNV = query_features(context);
        if raw_access_chains.shader_raw_access_chains == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderRawAccessChains feature is not supported".to_string(),
            ));
        }

        if params.variable_pointers {
            context.require_device_functionality("VK_KHR_variable_pointers")?;
            let features: vk::PhysicalDeviceVulkan11Features = query_features(context);
            if features.variable_pointers == vk::FALSE {
                return Err(TestError::NotSupported(
                    "variablePointers feature is not supported".to_string(),
                ));
            }
            if features.variable_pointers_storage_buffer == vk::FALSE {
                return Err(TestError::NotSupported(
                    "variablePointersStorageBuffer feature is not supported".to_string(),
                ));
            }
        }

        if params.physical_buffers {
            context.require_device_functionality("VK_KHR_buffer_device_address")?;
            let features: vk::PhysicalDeviceVulkan12Features = query_features(context);
            if features.buffer_device_address == vk::FALSE {
                return Err(TestError::NotSupported(
                    "bufferDeviceAddress feature is not supported".to_string(),
                ));
            }
        }

        if params.input_size == 1 || params.output_size == 1 {
            context.require_device_functionality("VK_KHR_shader_float16_int8")?;
            let features: vk::PhysicalDeviceVulkan12Features = query_features(context);
            if features.shader_int8 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderInt8 feature is not supported".to_string(),
                ));
            }
        }

        if (params.input_size == 2 || params.output_size == 2)
            && context.get_device_features().shader_int16 == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "shaderInt16 feature is not supported".to_string(),
            ));
        }

        if (params.input_size == 8 || params.output_size == 8)
            && context.get_device_features().shader_int64 == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "shaderInt64 feature is not supported".to_string(),
            ));
        }

        if params.uses_64bit_indexing {
            let supported = context.is_device_functionality_supported("VK_EXT_shader_64bit_indexing") && {
                let features: vk::PhysicalDeviceShader64BitIndexingFeaturesEXT = query_features(context);
                features.shader_64bit_indexing != vk::FALSE
            };
            if !supported {
                return Err(TestError::NotSupported(
                    "shader64BitIndexing not supported by this implementation".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RawAccessChainInstance {
            context,
            params: parse(self.spec),
        })
    }
}

struct RawAccessChainInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// What `addTest` computes before it writes the shader: the data of the two buffers and what the output must hold.
struct Data {
    input: Vec<u8>,
    output: Vec<u8>,
    expected: Vec<u8>,
}

fn build_data(p: &Params) -> Data {
    let input_stride = p.input_components * p.input_size + p.input_pre + p.input_post;
    let output_stride = p.output_components * p.output_size + p.output_pre + p.output_post;

    let mut random = Random::new(434);
    let mut input = vec![0xccu8; input_stride * LOCAL_SIZE];
    let output = vec![0xccu8; output_stride * LOCAL_SIZE];
    let mut expected = output.clone();

    for byte in input.iter_mut() {
        *byte = random.get_uint8();
    }

    for i in 0..LOCAL_SIZE {
        let values = [
            random.get_uint64(),
            random.get_uint64(),
            random.get_uint64(),
            random.get_uint64(),
        ];
        let value_bytes: Vec<u8> = values.iter().flat_map(|value| value.to_le_bytes()).collect();
        let mut expected_result = 0u64;
        for j in 0..p.input_components {
            let mut bytes = [0u8; 8];
            bytes[..p.input_size].copy_from_slice(&value_bytes[j * p.input_size..(j + 1) * p.input_size]);
            let mut value = u64::from_le_bytes(bytes);

            if p.input_bounds_check == BOUNDS_CHECK_PER_ELEMENT && (i * input_stride) as u64 >= p.input_range {
                value = 0;
            }
            if p.input_bounds_check == BOUNDS_CHECK_PER_COMPONENT
                && (i * input_stride + j * p.input_size + p.input_pre) as u64 >= p.input_range
            {
                value = 0;
            }

            expected_result = expected_result.wrapping_add(value);
        }

        // The shader operates with the input type, so the expected result is truncated to it.
        let mut result_bytes = [0u8; 8];
        result_bytes[..p.input_size].copy_from_slice(&expected_result.to_le_bytes()[..p.input_size]);
        let mut result = u64::from_le_bytes(result_bytes);

        let input_offset = i * input_stride + p.input_pre;
        input[input_offset..input_offset + p.input_components * p.input_size]
            .copy_from_slice(&value_bytes[..p.input_components * p.input_size]);

        for j in 0..p.output_components {
            let mut checked = false;

            if p.output_bounds_check == BOUNDS_CHECK_PER_ELEMENT {
                checked = (i * output_stride) as u64 >= p.output_range;
            }
            if p.output_bounds_check == BOUNDS_CHECK_PER_COMPONENT {
                checked = (i * output_stride + j * p.output_size + p.output_pre) as u64 >= p.output_range;
            }

            if !checked {
                let offset = i * output_stride + p.output_pre + j * p.output_size;
                expected[offset..offset + p.output_size].copy_from_slice(&result.to_le_bytes()[..p.output_size]);
            }
            result = result.wrapping_add(1);
        }
    }

    Data {
        input,
        output,
        expected,
    }
}

impl TestInstance for RawAccessChainInstance<'_> {
    /// `SpvAsmRawAccessChainInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let p = &self.params;
        let data = build_data(p);

        let descriptor_index: u32 = if p.descriptor_indexing { 6 } else { 0 };
        let num_descriptors = if p.descriptor_indexing {
            NUM_DESCRIPTORS_ELEMENTS
        } else {
            1
        };

        let queue_family_index = context.get_universal_queue_family_index();
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let requirement =
            MemoryRequirement::COHERENT | MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS;
        let usage = vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        let input_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(data.input.len() as vk::DeviceSize, usage),
            requirement,
        )?;
        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(data.output.len() as vk::DeviceSize, usage),
            requirement,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                data.input.as_ptr(),
                input_buffer.get_allocation().get_host_ptr(),
                data.input.len(),
            );
            std::ptr::copy_nonoverlapping(
                data.output.as_ptr(),
                output_buffer.get_allocation().get_host_ptr(),
                data.output.len(),
            );
        }
        flush_alloc(device, input_buffer.get_allocation())?;
        flush_alloc(device, output_buffer.get_allocation())?;

        let input_address = unsafe {
            device.get_buffer_device_address(&vk::BufferDeviceAddressInfo::builder().buffer(input_buffer.get()))
        };
        let output_address = unsafe {
            device.get_buffer_device_address(&vk::BufferDeviceAddressInfo::builder().buffer(output_buffer.get()))
        };

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::COMPUTE,
                0,
                num_descriptors,
            )
            .build(device)?;
        let set_layouts = [*descriptor_set_layout, *descriptor_set_layout];
        let push_constant_size = if p.physical_buffers {
            4 * std::mem::size_of::<i32>()
        } else {
            std::mem::size_of::<i32>()
        } as u32;
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: push_constant_size,
        }];
        let layout_set_layouts: &[vk::DescriptorSetLayout] = if p.physical_buffers { &[] } else { &set_layouts };
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(layout_set_layouts)
            .push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, num_descriptors)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let descriptor_set1 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_set2 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let input_info = make_descriptor_buffer_info(input_buffer.get(), 0, p.input_range);
        let output_info = make_descriptor_buffer_info(output_buffer.get(), 0, p.output_range);
        let location = Location::binding_array_element(0, descriptor_index);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set1.get(),
                location,
                vk::DescriptorType::STORAGE_BUFFER,
                &input_info,
            )
            .write_single(
                descriptor_set2.get(),
                location,
                vk::DescriptorType::STORAGE_BUFFER,
                &output_info,
            )
            .update(device);

        let binary = context.get_binary_collection().get("compute")?;
        let module = create_shader_module(device, binary)?;

        let mut pipeline_flags2 = vk::PipelineCreateFlags2CreateInfo {
            flags: vk::PipelineCreateFlags2::_64_BIT_INDEXING_EXT,
            ..Default::default()
        };
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*module)
            .name(b"main\0")
            .build();
        let mut pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        if p.uses_64bit_indexing {
            pipeline_info = pipeline_info.push_next(&mut pipeline_flags2);
        }
        let pipeline_info = pipeline_info.build();
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            if p.physical_buffers {
                let addresses: Vec<u8> = [input_address, output_address]
                    .iter()
                    .flat_map(|address| address.to_ne_bytes())
                    .collect();
                device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::COMPUTE, 0, &addresses);
            } else {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set1.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    1,
                    &[descriptor_set2.get()],
                    &[] as &[u32],
                );
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout,
                    vk::ShaderStageFlags::COMPUTE,
                    0,
                    &descriptor_index.to_ne_bytes(),
                );
            }
            device.cmd_dispatch(cmd, 1, 1, 1);

            let memory_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, output_buffer.get_allocation())?;
        let result = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                data.expected.len(),
            )
        };
        if result != data.expected.as_slice() {
            return Ok(TestStatus::new(TestResult::Fail, "Output doesn't match with expected"));
        }

        Ok(TestStatus::pass("OK"))
    }
}

/// `createRawAccessChainGroup`: the groups of the case path below `compute`, then the case.
pub fn create_raw_access_chain_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_LOAD_CASE
        .iter()
        .chain(ALL_STORE_CASE.iter())
        .map(|case| (vec!["raw_access_chain"], Box::new(**case) as Box<dyn TestCase>))
        .collect()
}
