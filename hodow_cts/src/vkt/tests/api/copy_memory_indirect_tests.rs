// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyMemoryIndirectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the buffer to buffer matrix (`copy_size`/`copy_offset`/`copy_count`/stride/queue)
// and the `mandatory_formats` case are ported; the image to buffer, memory to image and use-after-transfer groups, which build on
// `CopiesAndBlittingTestInstance`, are not. `vulkan/data/copy_memory_indirect/sample_text.txt` is embedded from `data/`.
//
// `copy_memory_indirect`: `vkCmdCopyMemoryIndirectKHR` over a table of copy commands in a device-addressed buffer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1, KhrCopyMemoryIndirectExtensionDeviceCommands};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SAMPLE_TEXT: &[u8] = include_bytes!("../../../../data/copy_memory_indirect/sample_text.txt");

#[derive(Clone, Copy, PartialEq, Eq)]
enum QueueSelection {
    Universal,
    TransferOnly,
    ComputeOnly,
}

#[derive(Clone, Copy)]
struct CopyParams {
    copy_count: u32,
    stride: u32,
    copy_offset: u32,
    copy_size: u32,
    queue: QueueSelection,
}

/// `IndirectParams`: the command followed by padding that makes the stride longer.
#[repr(C)]
#[derive(Clone, Copy, Default)]
struct IndirectParams {
    cmd: [u64; 3],
    dummyparam1: u32,
    dummyparam2: u32,
    dummyparam3: u32,
}

const NORMAL_STRIDE: u32 = std::mem::size_of::<vk::CopyMemoryIndirectCommandKHR>() as u32;
const LONG_STRIDE: u32 = std::mem::size_of::<IndirectParams>() as u32;

/// `getQueueInfo`; the error is what upstream's `getQueueInfo` throws when the queue is not available.
fn get_queue_info(context: &Context<'_>, queue: QueueSelection) -> Result<(vk::Queue, u32), TestError> {
    match queue {
        QueueSelection::ComputeOnly => context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("Compute queue not available".to_string())),
        QueueSelection::TransferOnly => context
            .get_transfer_queue()
            .ok_or_else(|| TestError::NotSupported("Transfer queue not available".to_string())),
        QueueSelection::Universal => Ok((
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        )),
    }
}

/// `CopyMemoryIndirectTestInstance::iterate`
fn run_copy_memory_indirect(context: &Context<'_>, params: &CopyParams) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let (queue, qf_index) = get_queue_info(context, params.queue)?;

    let mut copy_data = SAMPLE_TEXT.to_vec();
    // 64-aligned
    while copy_data.len() & 0x63 != 0 {
        copy_data.push(b'.');
    }

    let buffer_size = copy_data.len();
    if params.copy_size == 0 {
        debug_assert!(buffer_size > params.copy_offset as usize);
    }

    let copy_size = (if params.copy_size != 0 {
        params.copy_size as usize
    } else {
        buffer_size
    }) - params.copy_offset as usize;

    let mem_reqs = MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS | MemoryRequirement::ANY;

    // Buffers
    let mut usage = vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
    let src_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size as vk::DeviceSize, usage),
        mem_reqs,
    )?;
    let dst_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            (params.copy_count.max(1) as usize * buffer_size) as vk::DeviceSize,
            usage,
        ),
        mem_reqs,
    )?;

    usage |= vk::BufferUsageFlags::INDIRECT_BUFFER;
    let indirect_buffer_size = params.copy_count.max(1) as vk::DeviceSize * params.stride as vk::DeviceSize;
    let indirect_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(indirect_buffer_size, usage),
        mem_reqs,
    )?;

    // Buffer Information
    let address_of = |buffer: &BufferWithMemory<'_>| {
        let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
        unsafe { device.get_buffer_device_address(&info) }
    };
    let src_buffer_address = address_of(&src_buffer);
    let dst_buffer_address = address_of(&dst_buffer);
    let indirect_buffer_address = address_of(&indirect_buffer);

    // Create CMI Parameters
    let cmi_regions: Vec<vk::CopyMemoryIndirectCommandKHR> = (0..params.copy_count)
        .map(|i| vk::CopyMemoryIndirectCommandKHR {
            src_address: src_buffer_address + params.copy_offset as u64,
            dst_address: dst_buffer_address + params.copy_offset as u64 + (i as usize * copy_size) as u64,
            size: copy_size as vk::DeviceSize,
        })
        .collect();

    // Copy Data -> srcBuffer
    {
        let allocation = src_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        unsafe { std::ptr::copy_nonoverlapping(copy_data.as_ptr(), allocation.get_host_ptr(), buffer_size) };
        flush_alloc(device, allocation)?;
    }

    // Copy Commands -> indirectBuffer
    {
        let allocation = indirect_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        let host_ptr = allocation.get_host_ptr();

        if params.stride == NORMAL_STRIDE {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    cmi_regions.as_ptr().cast::<u8>(),
                    host_ptr,
                    params.stride as usize * params.copy_count as usize,
                )
            };
        } else if params.stride == LONG_STRIDE {
            // Create other indirect parameters
            let cmi_long_regions: Vec<IndirectParams> = cmi_regions
                .iter()
                .map(|region| IndirectParams {
                    cmd: [region.src_address, region.dst_address, region.size],
                    ..Default::default()
                })
                .collect();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    cmi_long_regions.as_ptr().cast::<u8>(),
                    host_ptr,
                    params.stride as usize * params.copy_count as usize,
                )
            };
        } else {
            return Err(TestError::InternalError("Unexpected stride".to_string()));
        }
        flush_alloc(device, allocation)?;
    }

    // dstBuffer
    {
        let allocation = dst_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        unsafe {
            std::ptr::write_bytes(
                allocation.get_host_ptr(),
                0xFF,
                params.copy_count.max(1) as usize * buffer_size,
            )
        };
        flush_alloc(device, allocation)?;
    }

    let cmd_pool = make_command_pool(device, qf_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;

    let copy_memory_indirect_info = vk::CopyMemoryIndirectInfoKHR {
        copy_address_range: vk::StridedDeviceAddressRangeKHR {
            address: indirect_buffer_address,
            size: indirect_buffer_size,
            stride: params.stride as vk::DeviceSize,
        },
        src_copy_flags: vk::AddressCopyFlagsKHR::DEVICE_LOCAL,
        dst_copy_flags: vk::AddressCopyFlagsKHR::DEVICE_LOCAL,
        copy_count: params.copy_count,
        ..Default::default()
    };
    unsafe { device.cmd_copy_memory_indirect_khr(cmd, &copy_memory_indirect_info) };

    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        dst_buffer.get(),
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Validate
    let mut fail = false;
    let allocation = dst_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;

    let host = unsafe {
        std::slice::from_raw_parts(
            allocation.get_host_ptr(),
            params.copy_count.max(1) as usize * buffer_size,
        )
    };
    let copy_offset = params.copy_offset as usize;
    let mut copied_data = vec![0u8; copy_size];

    for copy_num in 0..params.copy_count as usize {
        let src_offset = copy_offset;
        let dst_offset = copy_offset + copy_num * copy_size;
        let src = &copy_data[src_offset..src_offset + copy_size];

        copied_data.copy_from_slice(&host[dst_offset..dst_offset + copy_size]);
        if copied_data != src {
            fail = true;

            // Log the error.
            log::info!("Copy {copy_num} failed: source offset {src_offset} and destination offset {dst_offset}");
            log::info!("Source Data:      {}", hex_dump(src));
            log::info!("Destination data: {}", hex_dump(&copied_data));
        }
    }

    if params.copy_count == 0 && copied_data[0] == copy_data[0] {
        fail = true;
        log::info!("No copies but first char in source data is '\\0', which should not happen");
    }

    if fail {
        return Err(TestError::Fail("Check log for details".to_string()));
    }

    Ok(TestStatus::pass("Pass"))
}

fn hex_dump(data: &[u8]) -> String {
    data.iter()
        .map(|byte| format!("{byte:02x}"))
        .collect::<Vec<_>>()
        .join(" ")
}

/// `MandatoryFormats::addIndirectCopyMandatoryFormatSupportTests`
fn mandatory_formats(context: &Context<'_>) -> TestOutcome {
    let mandatory_formats = [
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::A2B10G10R10_UINT_PACK32,
        vk::Format::R16_UNORM,
        vk::Format::R16_SNORM,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UNORM,
        vk::Format::R16G16_SNORM,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16B16A16_SNORM,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::B10G11R11_UFLOAT_PACK32,
    ];

    let mut passed = true;
    for format in mandatory_formats {
        let mut format_props3 = vk::FormatProperties3::default();
        let mut format_props2 = vk::FormatProperties2::builder().push_next(&mut format_props3);
        unsafe {
            context.get_instance().get_physical_device_format_properties2(
                context.get_physical_device(),
                format,
                &mut format_props2,
            )
        };

        if !format_props3
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags2::COPY_IMAGE_INDIRECT_DST_KHR)
        {
            log::info!(
                "Format {format:?} missing VK_FORMAT_FEATURE_2_COPY_IMAGE_INDIRECT_DST_BIT_KHR in optimalTilingFeatures"
            );
            passed = false;
        }
    }

    Ok(if passed {
        TestStatus::pass("All mandatory formats support indirect copy DST bit")
    } else {
        TestStatus::fail("One or more formats missing mandatory indirect copy feature bit")
    })
}

#[derive(Clone, Copy)]
enum Kind {
    Copy(CopyParams),
    MandatoryFormats,
}

struct CopyMemoryIndirectCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for CopyMemoryIndirectCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_copy_memory_indirect")?;

        let mut features = vk::PhysicalDeviceCopyMemoryIndirectFeaturesKHR::default();
        let mut properties = vk::PhysicalDeviceCopyMemoryIndirectPropertiesKHR::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2);
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2);
        }

        match self.kind {
            Kind::Copy(params) => {
                if features.indirect_memory_copy == vk::FALSE {
                    return Err(TestError::NotSupported("indirectMemoryCopy not supported".to_string()));
                }

                // Check whether current queue type is supported
                if (params.queue == QueueSelection::Universal
                    && !properties.supported_queues.contains(vk::QueueFlags::GRAPHICS))
                    || (params.queue == QueueSelection::TransferOnly
                        && !properties.supported_queues.contains(vk::QueueFlags::TRANSFER))
                    || (params.queue == QueueSelection::ComputeOnly
                        && !properties.supported_queues.contains(vk::QueueFlags::COMPUTE))
                {
                    return Err(TestError::NotSupported(
                        "Indirect memory copy not supported on the target queue".to_string(),
                    ));
                }

                // getQueueInfo will throw if the requested queue is not available.
                get_queue_info(context, params.queue)?;
            }
            Kind::MandatoryFormats => {
                context.require_device_functionality("VK_KHR_format_feature_flags2")?;

                if features.indirect_memory_to_image_copy == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "indirectMemoryToImageCopy feature not supported".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyMemoryIndirectInstance {
            context,
            kind: self.kind,
        })
    }
}

struct CopyMemoryIndirectInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for CopyMemoryIndirectInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::Copy(params) => run_copy_memory_indirect(self.context, &params),
            Kind::MandatoryFormats => mandatory_formats(self.context),
        }
    }
}

/// `createCopyMemoryIndirectTests`
pub fn create_copy_memory_indirect_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("copy_memory_indirect");

    let copy_counts: [(u32, &str); 4] = [(0, "count_0"), (1, "count_1"), (2, "count_2"), (63, "count_63")];
    let copy_sizes: [(u32, &str); 3] = [(4, "size_4"), (12, "size_12"), (0, "size_full")];
    let copy_offsets: [(u32, &str); 2] = [(0, "offset_0"), (4, "offset_4")];
    let strides: [(u32, &str); 2] = [(NORMAL_STRIDE, "normal_stride"), (LONG_STRIDE, "long_stride")];
    let queues: [(QueueSelection, &str); 3] = [
        (QueueSelection::Universal, "graphics"),
        (QueueSelection::TransferOnly, "transfer"),
        (QueueSelection::ComputeOnly, "compute"),
    ];

    for (copy_size, copy_size_name) in copy_sizes {
        let mut copy_size_group = TestCaseGroup::new(copy_size_name);
        for (copy_offset, copy_offset_name) in copy_offsets {
            let mut copy_offset_group = TestCaseGroup::new(copy_offset_name);
            for (copy_count, copy_count_name) in copy_counts {
                let mut copy_count_group = TestCaseGroup::new(copy_count_name);
                for (stride, stride_name) in strides {
                    let mut stride_group = TestCaseGroup::new(stride_name);
                    for (queue, queue_name) in queues {
                        if copy_size > 0 && copy_offset >= copy_size {
                            continue;
                        }

                        let params = CopyParams {
                            copy_count,
                            stride,
                            copy_offset,
                            copy_size,
                            queue,
                        };
                        stride_group.add_child(Box::new(CopyMemoryIndirectCase {
                            name: queue_name,
                            kind: Kind::Copy(params),
                        }) as Box<dyn TestCase>);
                    }
                    copy_count_group.add_child(stride_group);
                }
                copy_offset_group.add_child(copy_count_group);
            }
            copy_size_group.add_child(copy_offset_group);
        }
        group.add_child(copy_size_group);
    }

    // Create test that checks if all mandatory formats support indirect copy
    let mut mandatory_formats_group = TestCaseGroup::new("mandatory_formats");
    mandatory_formats_group.add_child(Box::new(CopyMemoryIndirectCase {
        name: "memory_to_image",
        kind: Kind::MandatoryFormats,
    }) as Box<dyn TestCase>);
    group.add_child(mandatory_formats_group);
    group.add_child(super::use_after_copy_tests::create_use_after_xfer_group(true));

    group
}
