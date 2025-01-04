// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmPhysicalStorageBufferPointerTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2016 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the four cases is in `shaders/manifest/spirv_assembly_physical_storage_buffer.toml`
// (written by `scripts/gen_spirv_assembly_physical_storage_buffer_manifest.py`); the `spec` of a case is its `PassMethod`.
// `ut::TypedBuffer` is a `Vec<u8>` view over a `BufferWithMemory` here.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::spirv_assembly_physical_storage_buffer::ALL_PHYSICAL_STORAGE_BUFFER_CASE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
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

const ELEMENTS: u32 = 64;

/// The `rust_type` of the manifest entries: one `SpvAsmPhysicalStorageBufferTestCase`.
#[derive(Clone, Copy)]
pub struct PhysicalStorageBufferCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PassMethod {
    PushConstants,
    PushConstantsFunction,
    AddressesInSsbo,
    PtrAccessChainFromUbo,
}

impl PhysicalStorageBufferCase {
    fn method(&self) -> PassMethod {
        match self.spec.strip_prefix("method=") {
            Some("push_constants") => PassMethod::PushConstants,
            Some("push_constants_function") => PassMethod::PushConstantsFunction,
            Some("addrs_in_ssbo") => PassMethod::AddressesInSsbo,
            Some("ptr_access_chain_from_ubo") => PassMethod::PtrAccessChainFromUbo,
            _ => panic!("physical storage buffer spec {}", self.spec),
        }
    }
}

fn query_vulkan12_features(context: &Context<'_>) -> vk::PhysicalDeviceVulkan12Features {
    let mut features = vk::PhysicalDeviceVulkan12Features::default();
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

impl TestCase for PhysicalStorageBufferCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `SpvAsmPhysicalStorageBufferTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if query_vulkan12_features(context).buffer_device_address == vk::FALSE {
            return Err(TestError::NotSupported(
                "Request physical storage buffer feature not supported".to_string(),
            ));
        }

        if self.method() == PassMethod::AddressesInSsbo && context.get_device_features().shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported("Int64 not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PhysicalStorageBufferInstance {
            context,
            method: self.method(),
        })
    }
}

struct PhysicalStorageBufferInstance<'a> {
    context: &'a Context<'a>,
    method: PassMethod,
}

/// `ut::Buffer`: a coherent host visible buffer, with a device address when asked for one.
fn make_buffer<'c>(
    context: &'c Context<'_>,
    usage: vk::BufferUsageFlags,
    size: usize,
    address: bool,
) -> Result<BufferWithMemory<'c>, TestError> {
    let (usage, requirement) = if address {
        (
            usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            MemoryRequirement::COHERENT | MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )
    } else {
        (usage, MemoryRequirement::COHERENT | MemoryRequirement::HOST_VISIBLE)
    };
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size as vk::DeviceSize, usage),
        requirement,
    )
}

fn buffer_address(context: &Context<'_>, buffer: &BufferWithMemory) -> u64 {
    unsafe {
        context
            .get_device()
            .get_buffer_device_address(&vk::BufferDeviceAddressInfo::builder().buffer(buffer.get()))
    }
}

fn write_bytes(context: &Context<'_>, buffer: &BufferWithMemory, bytes: &[u8]) -> Result<(), TestError> {
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(context.get_device(), buffer.get_allocation())
}

fn read_bytes(context: &Context<'_>, buffer: &BufferWithMemory, size: usize) -> Result<Vec<u8>, TestError> {
    invalidate_alloc(context.get_device(), buffer.get_allocation())?;
    Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast_const(), size) }.to_vec())
}

fn iota_bytes(start: u32, count: u32) -> Vec<u8> {
    (0..count).flat_map(|i| (start + i).to_ne_bytes()).collect()
}

struct Compute<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
}

fn make_compute<'c>(
    context: &'c Context<'_>,
    set_layouts: &[vk::DescriptorSetLayout],
    push_constant_size: u32,
) -> Result<Compute<'c>, TestError> {
    let device = context.get_device();
    let binary = context.get_binary_collection().get("comp")?;
    let module = create_shader_module(device, binary)?;
    let push_constant_ranges = [vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::COMPUTE,
        offset: 0,
        size: push_constant_size,
    }];
    let ranges: &[vk::PushConstantRange] = if push_constant_size == 0 {
        &[]
    } else {
        &push_constant_ranges
    };
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(set_layouts)
        .push_constant_ranges(ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*module)
        .name(b"main\0")
        .build();
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(0)
        .build();
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );
    Ok(Compute {
        pipeline,
        pipeline_layout,
    })
}

impl PhysicalStorageBufferInstance<'_> {
    /// Records `bind` and a dispatch of `groups`, submits, and (for the host read) adds the shader write to host read barrier.
    fn run(&self, compute: &Compute<'_>, groups: u32, record: impl FnOnce(vk::CommandBuffer)) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute.pipeline) };
        record(cmd);
        unsafe {
            device.cmd_dispatch(cmd, groups, 1, 1);
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
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)
    }

    /// `SpvAsmPhysicalStorageBufferPushConstantsTestInstance::iterate`
    fn push_constants(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let compute = make_compute(context, &[], 24)?;

        let size = ELEMENTS as usize * 4;
        let src = make_buffer(context, vk::BufferUsageFlags::STORAGE_BUFFER, size, true)?;
        let dst = make_buffer(context, vk::BufferUsageFlags::STORAGE_BUFFER, size, true)?;
        let expected = iota_bytes(ELEMENTS, ELEMENTS);
        write_bytes(context, &src, &expected)?;
        write_bytes(context, &dst, &vec![0u8; size])?;

        // struct PushConstant { uint64_t src; uint64_t dst; int32_t cnt; bool use_fun; }
        let mut push_constants = Vec::with_capacity(24);
        push_constants.extend_from_slice(&buffer_address(context, &src).to_ne_bytes());
        push_constants.extend_from_slice(&buffer_address(context, &dst).to_ne_bytes());
        push_constants.extend_from_slice(&(ELEMENTS as i32).to_ne_bytes());
        push_constants.push(u8::from(self.method == PassMethod::PushConstantsFunction));
        push_constants.resize(24, 0);

        self.run(&compute, 1, |cmd| unsafe {
            device.cmd_push_constants(
                cmd,
                *compute.pipeline_layout,
                vk::ShaderStageFlags::COMPUTE,
                0,
                &push_constants,
            );
        })?;

        let result = read_bytes(context, &dst, size)?;
        Ok(if result == expected {
            TestStatus::pass("")
        } else {
            TestStatus::fail("")
        })
    }

    /// `SpvAsmPhysicalStorageBufferAddrsInSSBOTestInstance::iterate`
    fn addresses_in_ssbo(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let set_layouts = [*descriptor_set_layout];
        let compute = make_compute(context, &set_layouts, 0)?;

        let size = ELEMENTS as usize * 4;
        let src = make_buffer(context, vk::BufferUsageFlags::STORAGE_BUFFER, size, true)?;
        let dst = make_buffer(context, vk::BufferUsageFlags::STORAGE_BUFFER, size, true)?;

        // struct SSBO { uint64_t srcAsBuff; uint64_t srcAsUint; uint64_t dstAsBuff; uint64_t dstAsUint; }
        let src_address = buffer_address(context, &src);
        let dst_address = buffer_address(context, &dst);
        let ssbo_bytes: Vec<u8> = [src_address, src_address, dst_address, dst_address]
            .iter()
            .flat_map(|address| address.to_ne_bytes())
            .collect();
        let ssbo = make_buffer(context, vk::BufferUsageFlags::STORAGE_BUFFER, ssbo_bytes.len(), false)?;
        write_bytes(context, &ssbo, &ssbo_bytes)?;
        let ssbo_info = make_descriptor_buffer_info(ssbo.get(), 0, ssbo_bytes.len() as vk::DeviceSize);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &ssbo_info,
            )
            .update(device);

        let expected = iota_bytes(ELEMENTS, ELEMENTS);
        write_bytes(context, &src, &expected)?;
        write_bytes(context, &dst, &vec![0u8; size])?;

        self.run(&compute, ELEMENTS, |cmd| unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *compute.pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
        })?;

        let result = read_bytes(context, &dst, size)?;
        Ok(if result == expected {
            TestStatus::pass("")
        } else {
            TestStatus::fail("")
        })
    }

    /// `SpvAsmPhysicalStorageBufferPtrAccessChainTestInstance::iterate`
    fn ptr_access_chain(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let set_layouts = [*descriptor_set_layout];
        let compute = make_compute(context, &set_layouts, 0)?;

        let ssbo = make_buffer(context, vk::BufferUsageFlags::STORAGE_BUFFER, 4, true)?;
        let ubo_bytes = buffer_address(context, &ssbo).to_ne_bytes();
        let ubo = make_buffer(context, vk::BufferUsageFlags::UNIFORM_BUFFER, ubo_bytes.len(), false)?;

        write_bytes(context, &ssbo, &[0u8; 4])?;
        write_bytes(context, &ubo, &ubo_bytes)?;

        let buffer_info = make_descriptor_buffer_info(ubo.get(), 0, ubo_bytes.len() as vk::DeviceSize);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::UNIFORM_BUFFER,
                &buffer_info,
            )
            .update(device);

        self.run(&compute, 1, |cmd| unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *compute.pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
        })?;

        let result = read_bytes(context, &ssbo, 4)?;
        let value = u32::from_ne_bytes([result[0], result[1], result[2], result[3]]);
        if value != 42 {
            log::error!("Expected result 42, but got {value}");
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for PhysicalStorageBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.method {
            PassMethod::PushConstants | PassMethod::PushConstantsFunction => self.push_constants(),
            PassMethod::AddressesInSsbo => self.addresses_in_ssbo(),
            PassMethod::PtrAccessChainFromUbo => self.ptr_access_chain(),
        }
    }
}

/// `createPhysicalStorageBufferTestGroup`: the group `physical_storage_buffer` below `compute`, then the case.
pub fn create_physical_storage_buffer_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_PHYSICAL_STORAGE_BUFFER_CASE
        .iter()
        .map(|case| (vec!["physical_storage_buffer"], Box::new(**case) as Box<dyn TestCase>))
        .collect()
}
