// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryDecompressionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders. The `vulkan/data/gdeflate/*.gdef` files the instance loads
// from the test archive are embedded from `data/gdeflate/`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, DeviceV1_3, ExtMemoryDecompressionExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestModeType {
    Direct,
    Indirect,
}

#[derive(Clone, Copy)]
struct DecompressionParams {
    decompression_count: u32,
    executed_decompression_count: u32,
    stride: u32,
    name: &'static str,
}

const REGION_SIZE: u32 = std::mem::size_of::<vk::DecompressMemoryRegionEXT>() as u32;

/// `vulkan/data/gdeflate/compressed_<name>_level_<level>.gdef`
fn compressed_data(decompressed_filename: &str, compression_level: u32) -> Option<&'static [u8]> {
    match (decompressed_filename, compression_level) {
        ("17k", 0) => Some(include_bytes!("../../../../data/gdeflate/compressed_17k_level_0.gdef")),
        ("17k", 6) => Some(include_bytes!("../../../../data/gdeflate/compressed_17k_level_6.gdef")),
        ("17k", 12) => Some(include_bytes!("../../../../data/gdeflate/compressed_17k_level_12.gdef")),
        ("64k", 0) => Some(include_bytes!("../../../../data/gdeflate/compressed_64k_level_0.gdef")),
        ("64k", 6) => Some(include_bytes!("../../../../data/gdeflate/compressed_64k_level_6.gdef")),
        ("64k", 12) => Some(include_bytes!("../../../../data/gdeflate/compressed_64k_level_12.gdef")),
        _ => None,
    }
}

/// `vulkan/data/gdeflate/decompressed_<name>.gdef`
fn decompressed_data(decompressed_filename: &str) -> Option<&'static [u8]> {
    match decompressed_filename {
        "17k" => Some(include_bytes!("../../../../data/gdeflate/decompressed_17k.gdef")),
        "64k" => Some(include_bytes!("../../../../data/gdeflate/decompressed_64k.gdef")),
        _ => None,
    }
}

/// `MemoryDecompressionTestInstance::replaceCRLFInPlace`
fn replace_crlf(data: &[u8]) -> Vec<u8> {
    let mut out = Vec::with_capacity(data.len());
    let mut read = 0;
    while read < data.len() {
        if data[read] == b'\r' && read + 1 < data.len() && data[read + 1] == b'\n' {
            out.push(b'\n');
            read += 2;
        } else {
            out.push(data[read]);
            read += 1;
        }
    }
    out
}

/// A buffer create info whose usage lives in a `VkBufferUsageFlags2CreateInfo` rather than in `usage`.
fn buffer_info_with_usage2(size: vk::DeviceSize, usage2: &vk::BufferUsageFlags2CreateInfo) -> vk::BufferCreateInfo {
    let mut info = make_buffer_create_info(size, vk::BufferUsageFlags::empty());
    info.next = std::ptr::from_ref(usage2).cast();
    info
}

#[derive(Clone, Copy)]
struct TestConfig {
    mode: TestModeType,
    compression_level: u32,
    params: DecompressionParams,
    decompressed_filename: &'static str,
}

fn run_decompression(context: &Context<'_>, config: TestConfig) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();

    // `init()`
    let compressed_data = compressed_data(config.decompressed_filename, config.compression_level)
        .ok_or_else(|| TestError::NotSupported("Could not read compressed/decompressed file".to_string()))?;
    let decompressed_data = decompressed_data(config.decompressed_filename)
        .map(replace_crlf)
        .ok_or_else(|| TestError::NotSupported("Could not read compressed/decompressed file".to_string()))?;
    let params = config.params;

    // Number of executed decompressions must be <= total decompressions
    debug_assert!(params.decompression_count >= params.executed_decompression_count);

    let stride = params.stride;
    let compressed_size = compressed_data.len() as vk::DeviceSize;
    let decompressed_size = decompressed_data.len();
    let decompressed_size_aligned64 = 64 * decompressed_size.div_ceil(64);
    let total_decompressed_size = (params.decompression_count as usize * decompressed_size_aligned64) as vk::DeviceSize;

    // Create buffers for compression/decompression/copy
    let src_usage2 = vk::BufferUsageFlags2CreateInfo {
        s_type: vk::StructureType::BUFFER_USAGE_FLAGS_2_CREATE_INFO,
        next: std::ptr::null(),
        usage: vk::BufferUsageFlags2::MEMORY_DECOMPRESSION_EXT | vk::BufferUsageFlags2::SHADER_DEVICE_ADDRESS,
    };
    let src_buffer = BufferWithMemory::new(
        device,
        allocator,
        buffer_info_with_usage2(compressed_size, &src_usage2),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;

    let decompress_usage2 = vk::BufferUsageFlags2CreateInfo {
        s_type: vk::StructureType::BUFFER_USAGE_FLAGS_2_CREATE_INFO,
        next: std::ptr::null(),
        usage: vk::BufferUsageFlags2::TRANSFER_SRC
            | vk::BufferUsageFlags2::MEMORY_DECOMPRESSION_EXT
            | vk::BufferUsageFlags2::SHADER_DEVICE_ADDRESS,
    };
    let decompress_buffer = BufferWithMemory::new(
        device,
        allocator,
        buffer_info_with_usage2(total_decompressed_size, &decompress_usage2),
        MemoryRequirement::DEVICE_ADDRESS,
    )?;

    let dst_usage2 = vk::BufferUsageFlags2CreateInfo {
        s_type: vk::StructureType::BUFFER_USAGE_FLAGS_2_CREATE_INFO,
        next: std::ptr::null(),
        usage: vk::BufferUsageFlags2::TRANSFER_DST,
    };
    let dst_buffer = BufferWithMemory::new(
        device,
        allocator,
        buffer_info_with_usage2(total_decompressed_size, &dst_usage2),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let indirect_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            vk::DeviceSize::from(params.decompression_count * stride),
            vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;

    let count_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            std::mem::size_of::<u32>() as vk::DeviceSize,
            vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;

    let address_of = |buffer: &BufferWithMemory<'_>| {
        let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
        unsafe { device.get_buffer_device_address(&info) }
    };
    let src_buffer_address = address_of(&src_buffer);
    let decompress_buffer_address = address_of(&decompress_buffer);
    let indirect_buffer_address = address_of(&indirect_buffer);
    let count_buffer_address = address_of(&count_buffer);

    // Create decompression parameters
    let decompress_regions: Vec<vk::DecompressMemoryRegionEXT> = (0..params.decompression_count)
        .map(|t| vk::DecompressMemoryRegionEXT {
            src_address: src_buffer_address,
            dst_address: decompress_buffer_address + (t as usize * decompressed_size_aligned64) as u64,
            compressed_size,
            decompressed_size: decompressed_size as vk::DeviceSize,
        })
        .collect();

    {
        let buffer_allocation = src_buffer.get_allocation();
        invalidate_alloc(device, buffer_allocation)?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                compressed_data.as_ptr(),
                buffer_allocation.get_host_ptr(),
                compressed_data.len(),
            )
        };
    }

    {
        let buffer_allocation = dst_buffer.get_allocation();
        invalidate_alloc(device, buffer_allocation)?;
        unsafe { std::ptr::write_bytes(buffer_allocation.get_host_ptr(), 0xFF, total_decompressed_size as usize) };
    }

    {
        let buffer_allocation = indirect_buffer.get_allocation();
        invalidate_alloc(device, buffer_allocation)?;
        let host_ptr = buffer_allocation.get_host_ptr();
        for (t, region) in decompress_regions.iter().enumerate() {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    std::ptr::from_ref(region).cast::<u8>(),
                    host_ptr.add(t * stride as usize),
                    REGION_SIZE as usize,
                )
            };
        }
    }

    {
        let buffer_allocation = count_buffer.get_allocation();
        invalidate_alloc(device, buffer_allocation)?;
        unsafe {
            buffer_allocation
                .get_host_ptr()
                .cast::<u32>()
                .write_unaligned(params.executed_decompression_count)
        };
    }

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    // Decompress
    if config.mode == TestModeType::Direct {
        let decompression_info = vk::DecompressMemoryInfoEXT {
            s_type: vk::StructureType::DECOMPRESS_MEMORY_INFO_EXT,
            next: std::ptr::null(),
            decompression_method: vk::MemoryDecompressionMethodFlagsEXT::GDEFLATE_1_0,
            region_count: params.executed_decompression_count,
            regions: decompress_regions.as_ptr(),
        };
        unsafe { device.cmd_decompress_memory_ext(cmd, &decompression_info) };
    } else {
        unsafe {
            device.cmd_decompress_memory_indirect_count_ext(
                cmd,
                vk::MemoryDecompressionMethodFlagsEXT::GDEFLATE_1_0,
                indirect_buffer_address,
                count_buffer_address,
                params.decompression_count,
                stride,
            );
        }
    }

    // Add barrier after decompression
    {
        let barrier = vk::MemoryBarrier2 {
            s_type: vk::StructureType::MEMORY_BARRIER_2,
            next: std::ptr::null(),
            src_stage_mask: vk::PipelineStageFlags2::MEMORY_DECOMPRESSION_EXT,
            src_access_mask: vk::AccessFlags2::MEMORY_DECOMPRESSION_WRITE_EXT,
            dst_stage_mask: vk::PipelineStageFlags2::MEMORY_DECOMPRESSION_EXT,
            dst_access_mask: vk::AccessFlags2::MEMORY_DECOMPRESSION_READ_EXT,
        };
        let barriers = [barrier];
        let dep_info = vk::DependencyInfo::builder().memory_barriers(&barriers);
        unsafe { device.cmd_pipeline_barrier2(cmd, &dep_info) };
    }

    // Copy decompressed data to dstBuffer
    {
        let buffer_region = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: total_decompressed_size,
        };
        unsafe { device.cmd_copy_buffer(cmd, decompress_buffer.get(), dst_buffer.get(), &[buffer_region]) };
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Validate results
    let mut passed = true;
    {
        let buffer_allocation = dst_buffer.get_allocation();
        invalidate_alloc(device, buffer_allocation)?;
        let buffer = unsafe {
            std::slice::from_raw_parts(
                buffer_allocation.get_host_ptr().cast_const(),
                total_decompressed_size as usize,
            )
        };
        let region_at = |t: u32| {
            &buffer
                [t as usize * decompressed_size_aligned64..t as usize * decompressed_size_aligned64 + decompressed_size]
        };
        for t in 0..params.executed_decompression_count {
            passed &= region_at(t) == decompressed_data.as_slice();
        }
        for t in params.executed_decompression_count..params.decompression_count {
            passed &= region_at(t) != decompressed_data.as_slice();
        }
    }
    if passed {
        return Ok(TestStatus::pass("Test passed"));
    }
    Ok(TestStatus::fail("Test failed"))
}

struct DecompressionTestCase {
    name: String,
    config: TestConfig,
}

impl TestCase for DecompressionTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_memory_decompression")?;

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut decompression_features = vk::PhysicalDeviceMemoryDecompressionFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut decompression_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
        }
        if decompression_features.memory_decompression != vk::TRUE {
            return Err(TestError::NotSupported(
                "memory decompression feature not supported".to_string(),
            ));
        }

        let mut decompression_properties = vk::PhysicalDeviceMemoryDecompressionPropertiesEXT::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut decompression_properties);
            unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
        }
        if !decompression_properties
            .decompression_methods
            .contains(vk::MemoryDecompressionMethodFlagsEXT::GDEFLATE_1_0)
        {
            return Err(TestError::NotSupported(
                "Gdeflate 1.0 decompression format not supported".to_string(),
            ));
        }

        if decompression_properties.max_decompression_indirect_count < u64::from(self.config.params.decompression_count)
        {
            return Err(TestError::NotSupported("Too many decompressions requested".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DecompressionTestInstance {
            context,
            config: self.config,
        })
    }
}

struct DecompressionTestInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl TestInstance for DecompressionTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_decompression(self.context, self.config)
    }
}

/// `createMemoryDecompressionTests`
pub fn create_memory_decompression_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("decompression");

    let test_modes = [(TestModeType::Direct, "direct"), (TestModeType::Indirect, "indirect")];
    let levels = [
        (0u32, "compression_level_0"),
        (6, "compression_level_6"),
        (12, "compression_level_12"),
    ];
    let decompressed_sizes = ["17k", "64k"];

    let decompression_params = [
        DecompressionParams {
            decompression_count: 1,
            executed_decompression_count: 1,
            stride: REGION_SIZE,
            name: "count_1_1",
        },
        DecompressionParams {
            decompression_count: 20,
            executed_decompression_count: 12,
            stride: REGION_SIZE,
            name: "count_20_12",
        },
        DecompressionParams {
            decompression_count: 30,
            executed_decompression_count: 30,
            stride: REGION_SIZE + 64,
            name: "count_30_30_longstride",
        },
        DecompressionParams {
            decompression_count: 32,
            executed_decompression_count: 32,
            stride: REGION_SIZE,
            name: "count_32_32",
        },
        DecompressionParams {
            decompression_count: 64,
            executed_decompression_count: 64,
            stride: REGION_SIZE,
            name: "count_64_64",
        },
        DecompressionParams {
            decompression_count: 128,
            executed_decompression_count: 128,
            stride: REGION_SIZE,
            name: "count_128_128",
        },
    ];

    for (mode, mode_name) in test_modes {
        let mut mode_group = TestCaseGroup::new(mode_name);
        for (compression_level, level_name) in levels {
            let mut level_group = TestCaseGroup::new(level_name);
            for params in decompression_params {
                let mut count_group = TestCaseGroup::new(params.name);
                for decompressed_filename in decompressed_sizes {
                    let config = TestConfig {
                        mode,
                        compression_level,
                        params,
                        decompressed_filename,
                    };
                    count_group.add_child(Box::new(DecompressionTestCase {
                        name: format!("decompressed_size_{decompressed_filename}"),
                        config,
                    }) as Box<dyn TestCase>);
                }
                level_group.add_child(count_group);
            }
            mode_group.add_child(level_group);
        }
        group.add_child(mode_group);
    }

    group
}
