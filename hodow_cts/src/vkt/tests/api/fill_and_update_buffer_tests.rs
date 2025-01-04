// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFillBufferTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiBufferAndImageAllocationUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Samsung Electronics Co., Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Two deliberate differences from upstream's structure:
//  - the buffer, pool and memory are created in `iterate` rather than in the instance
//    constructor, because `create_instance` cannot fail here;
//  - the `_device_address` cases (VK_KHR_device_address_commands) go through `vk::device_address_commands`.
//
// The R8G8B8A8_UINT texture upstream fills with `(x, 0, 0, 255)` per texel is written
// directly as bytes: `setPixel(UVec4(x, y, z, 255))` into an 8-bit channel saturates.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrSynchronization2ExtensionDeviceCommands};

use super::case_util::add_case;
use super::copies_buffer_tests::{
    AllocationKind, QueueSelection, bind_buffer_memory, bind_device_address_buffer_memory, select_queue,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::device_address_commands::{
    self, ADDRESS_COMMAND_FULLY_BOUND, ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE, DeviceAddressRange,
    MemoryRangeBarrier, MemoryRangeBarriersInfo,
};
use crate::vk::mem_util::{Allocation, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `TestParams::TEST_DATA_SIZE`
const TEST_DATA_SIZE: usize = 256;

/// `TestParams`
#[derive(Clone)]
struct TestParams {
    dst_size: vk::DeviceSize,
    dst_offset: vk::DeviceSize,
    size: vk::DeviceSize,
    test_data: [u32; TEST_DATA_SIZE],
    allocation_kind: AllocationKind,
    queue_type: QueueSelection,
    use_device_address_commands: bool,
    nonzero_bind_offset: bool,
}

impl TestParams {
    fn test_data_bytes(&self) -> Vec<u8> {
        self.test_data.iter().flat_map(|w| w.to_ne_bytes()).collect()
    }
}

fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 { a } else { gcd(b, a % b) }
}

/// `de::lcm`
fn lcm(a: u64, b: u64) -> u64 {
    if a == 0 || b == 0 { 0 } else { a / gcd(a, b) * b }
}

/// `de::roundUp`
fn round_up(value: u64, multiple: u64) -> u64 {
    if multiple == 0 {
        value
    } else {
        value.div_ceil(multiple) * multiple
    }
}

/// What `SimpleAllocator` with `OffsetParams{nonCoherentAtomSize, dstSize}` hands back: the
/// memory is `offset` bytes larger than the requirement and the buffer is bound `offset`
/// bytes into it. The shared allocator has no offset support, so this one exists for the
/// `suballocation_bind_offset` group alone.
struct OffsetAllocation<'a> {
    device: &'a Device,
    memory: vk::DeviceMemory,
    offset: vk::DeviceSize,
    host_ptr: *mut u8,
}

impl Drop for OffsetAllocation<'_> {
    fn drop(&mut self) {
        unsafe {
            self.device.unmap_memory(self.memory);
            self.device.free_memory(self.memory, None);
        }
    }
}

fn allocate_with_bind_offset<'a>(
    context: &'a Context<'a>,
    buffer: vk::Buffer,
    dst_size: vk::DeviceSize,
) -> Result<OffsetAllocation<'a>, TestError> {
    let device = context.get_device();
    let mem_reqs = unsafe { device.get_buffer_memory_requirements(buffer) };
    let non_coherent_atom_size = context.get_device_properties().limits.non_coherent_atom_size;

    let required_alignment = lcm(non_coherent_atom_size, mem_reqs.alignment);
    let offset = round_up(dst_size, required_alignment);

    let memory_properties = context.get_default_allocator().memory_properties();
    let memory_type_index = (0..memory_properties.memory_type_count)
        .find(|&i| {
            (mem_reqs.memory_type_bits & (1 << i)) != 0
                && memory_properties.memory_types[i as usize]
                    .property_flags
                    .contains(vk::MemoryPropertyFlags::HOST_VISIBLE)
        })
        .ok_or_else(|| TestError::NotSupported("No compatible memory type found".to_string()))?;

    let info = vk::MemoryAllocateInfo::builder()
        .allocation_size(mem_reqs.size + offset)
        .memory_type_index(memory_type_index);
    let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;

    let host_ptr = match unsafe { device.map_memory(memory, offset, mem_reqs.size, vk::MemoryMapFlags::empty()) } {
        Ok(p) => p.cast::<u8>(),
        Err(e) => {
            unsafe { device.free_memory(memory, None) };
            return Err(TestError::ResourceError(format!("vkMapMemory failed: {e}")));
        }
    };

    Ok(OffsetAllocation {
        device,
        memory,
        offset,
        host_ptr,
    })
}

/// The destination's backing memory, with or without a bind offset.
enum DestinationMemory<'a> {
    Plain(Allocation<'a>),
    Offset(OffsetAllocation<'a>),
}

impl DestinationMemory<'_> {
    fn host_ptr(&self) -> *mut u8 {
        match self {
            Self::Plain(a) => a.get_host_ptr(),
            Self::Offset(a) => a.host_ptr,
        }
    }

    fn flush(&self, device: &Device) -> Result<(), TestError> {
        match self {
            Self::Plain(a) => flush_alloc(device, a),
            Self::Offset(a) => {
                let range = vk::MappedMemoryRange::builder()
                    .memory(a.memory)
                    .offset(a.offset)
                    .size(vk::WHOLE_SIZE);
                unsafe { device.flush_mapped_memory_ranges(&[range]) }.vk_check("vkFlushMappedMemoryRanges")
            }
        }
    }

    fn invalidate(&self, device: &Device) -> Result<(), TestError> {
        match self {
            Self::Plain(a) => invalidate_alloc(device, a),
            Self::Offset(a) => {
                let range = vk::MappedMemoryRange::builder()
                    .memory(a.memory)
                    .offset(a.offset)
                    .size(vk::WHOLE_SIZE);
                unsafe { device.invalidate_mapped_memory_ranges(&[range]) }.vk_check("vkInvalidateMappedMemoryRanges")
            }
        }
    }
}

/// `BufferSuballocation::createTestBuffer` / `BufferDedicatedAllocation::createTestBuffer`
fn create_test_buffer<'a>(
    context: &'a Context<'a>,
    params: &TestParams,
    usage: vk::BufferUsageFlags,
) -> Result<(Unique<'a, vk::Buffer>, DestinationMemory<'a>), TestError> {
    let device = context.get_device();
    let buffer = Unique::new(
        device,
        unsafe { device.create_buffer(&make_buffer_create_info(params.dst_size, usage), None) }
            .vk_check("vkCreateBuffer")?,
    );

    let memory = if params.nonzero_bind_offset {
        let allocation = allocate_with_bind_offset(context, *buffer, params.dst_size)?;
        unsafe { device.bind_buffer_memory(*buffer, allocation.memory, allocation.offset) }
            .vk_check("vkBindBufferMemory")?;
        DestinationMemory::Offset(allocation)
    } else if params.use_device_address_commands {
        DestinationMemory::Plain(bind_device_address_buffer_memory(
            context,
            *buffer,
            params.allocation_kind,
        )?)
    } else {
        DestinationMemory::Plain(bind_buffer_memory(context, *buffer, params.allocation_kind)?)
    };

    Ok((buffer, memory))
}

fn check_support_common(
    context: &Context<'_>,
    params: &TestParams,
    need_sync2_with_device_address: bool,
) -> Result<(), TestError> {
    if params.use_device_address_commands {
        device_address_commands::check_support(context)?;
        if need_sync2_with_device_address {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }
    }

    if params.allocation_kind == AllocationKind::Dedicated {
        context.require_device_functionality("VK_KHR_dedicated_allocation")?;
    }

    // These methods will throw if the queues are not available.
    if matches!(
        params.queue_type,
        QueueSelection::ComputeOnly | QueueSelection::TransferOnly
    ) {
        select_queue(context, params.queue_type)?;
    }
    Ok(())
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    FillWhole,
    Fill,
    Update,
}

struct FillAndUpdateCase {
    name: String,
    params: TestParams,
    kind: Kind,
}

impl TestCase for FillAndUpdateCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_common(context, &self.params, self.kind == Kind::FillWhole)
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FillAndUpdateInstance {
            context,
            params: &self.params,
            kind: self.kind,
        })
    }
}

struct FillAndUpdateInstance<'a> {
    context: &'a Context<'a>,
    params: &'a TestParams,
    kind: Kind,
}

impl TestInstance for FillAndUpdateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::FillWhole => fill_whole_buffer(self.context, self.params),
            Kind::Fill => fill_or_update_buffer(self.context, self.params, false),
            Kind::Update => fill_or_update_buffer(self.context, self.params, true),
        }
    }
}

/// `FillWholeBufferTestInstance::iterate`
fn fill_whole_buffer(context: &Context<'_>, params: &TestParams) -> TestOutcome {
    let vk = context.get_device();
    let (queue, queue_family_index) = select_queue(context, params.queue_type)?;

    let mut usage = vk::BufferUsageFlags::TRANSFER_DST;
    if params.use_device_address_commands {
        usage |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
    }

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let (destination, destination_alloc) = create_test_buffer(context, params, usage)?;

    // use synchronization2 when testing transfer only queue or device address commands
    let mut use_synchronization2 = false;
    if context.is_device_functionality_supported("VK_KHR_synchronization2") {
        use_synchronization2 = params.queue_type == QueueSelection::TransferOnly || params.use_device_address_commands;
    }

    // Make sure some stuff below will work.
    assert!(params.dst_size >= std::mem::size_of::<u32>() as u64);
    assert!(params.dst_offset < params.dst_size);

    // Fill buffer from the host and flush buffer memory.
    let bytes = destination_alloc.host_ptr();
    unsafe { std::ptr::write_bytes(bytes, 0xff, params.dst_size as usize) };
    destination_alloc.flush(vk)?;

    let gpu_to_host_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        *destination,
        0,
        vk::WHOLE_SIZE,
    );

    let gpu_to_host_barrier2 = [vk::BufferMemoryBarrier2::builder()
        .src_stage_mask(vk::PipelineStageFlags2::ALL_TRANSFER)
        .src_access_mask(vk::AccessFlags2::TRANSFER_WRITE)
        .dst_stage_mask(vk::PipelineStageFlags2::HOST)
        .dst_access_mask(vk::AccessFlags2::HOST_READ)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .buffer(*destination)
        .offset(0)
        .size(vk::WHOLE_SIZE)
        .build()];

    // With device address commands the barrier is a memory range barrier chained to an otherwise empty dependency info.
    let memory_range_barriers = [MemoryRangeBarrier::new(
        gpu_to_host_barrier2[0].src_stage_mask,
        gpu_to_host_barrier2[0].src_access_mask,
        gpu_to_host_barrier2[0].dst_stage_mask,
        gpu_to_host_barrier2[0].dst_access_mask,
        DeviceAddressRange {
            address: if params.use_device_address_commands {
                device_address_commands::buffer_device_address(vk, *destination)
            } else {
                0
            },
            size: params.dst_size,
        },
    )];
    let memory_range_barriers_info = MemoryRangeBarriersInfo::new(&memory_range_barriers);
    let dep_info = if params.use_device_address_commands {
        let mut dep_info = vk::DependencyInfo::default();
        dep_info.next = std::ptr::addr_of!(memory_range_barriers_info).cast();
        dep_info
    } else {
        vk::DependencyInfo::builder()
            .buffer_memory_barriers(&gpu_to_host_barrier2)
            .build()
    };

    // The KHR entry points are only exported by a driver that advertises the extension; one
    // that merely reports 1.3 exports the core names.
    let has_khr_sync2 = context
        .get_device_extensions()
        .iter()
        .any(|e| e == "VK_KHR_synchronization2");

    // Fill buffer using VK_WHOLE_SIZE.
    begin_command_buffer(vk, *cmd_buffer)?;
    unsafe {
        vk.cmd_fill_buffer(
            *cmd_buffer,
            *destination,
            params.dst_offset,
            vk::WHOLE_SIZE,
            0x0101_0101u32,
        );

        if use_synchronization2 {
            if has_khr_sync2 {
                vk.cmd_pipeline_barrier2_khr(*cmd_buffer, &dep_info);
            } else {
                vk.cmd_pipeline_barrier2(*cmd_buffer, &dep_info);
            }
        } else {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[gpu_to_host_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
    end_command_buffer(vk, *cmd_buffer)?;

    let fence = Unique::new(
        vk,
        unsafe { vk.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    if use_synchronization2 {
        let command_buffer_infos = [vk::CommandBufferSubmitInfo::builder()
            .command_buffer(*cmd_buffer)
            .build()];
        let submit_info2 = [vk::SubmitInfo2::builder().command_buffer_infos(&command_buffer_infos)];

        if has_khr_sync2 {
            unsafe { vk.queue_submit2_khr(queue, &submit_info2, *fence) }.vk_check("vkQueueSubmit2KHR")?;
        } else {
            unsafe { vk.queue_submit2(queue, &submit_info2, *fence) }.vk_check("vkQueueSubmit2")?;
        }
    } else {
        let command_buffers = [*cmd_buffer];
        let submit_info = [vk::SubmitInfo::builder().command_buffers(&command_buffers)];
        unsafe { vk.queue_submit(queue, &submit_info, *fence) }.vk_check("vkQueueSubmit")?;
    }
    unsafe { vk.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    // Invalidate buffer memory and check the buffer contains the expected results.
    destination_alloc.invalidate(vk)?;

    let start_of_extra = (params.dst_size / std::mem::size_of::<u32>() as u64) * std::mem::size_of::<u32>() as u64;
    let result = unsafe { std::slice::from_raw_parts(bytes, params.dst_size as usize) };
    for i in 0..params.dst_size {
        let expected_byte: u8 = if i >= params.dst_offset && i < start_of_extra {
            0x01
        } else {
            0xff
        };
        if result[i as usize] != expected_byte {
            return Ok(TestStatus::fail(format!(
                "Invalid byte at position {i} in the buffer (found 0x{:x} but expected 0x{:x})",
                result[i as usize] as i32, expected_byte as i32
            )));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `FillBufferTestInstance::generateBuffer` for the 1-row R8G8B8A8_UINT level
/// `(x, y, z, 255)`, in bytes.
fn generate_destination_buffer(width: usize) -> Vec<u8> {
    let mut out = Vec::with_capacity(width * 4);
    for x in 0..width {
        out.extend_from_slice(&[x.min(255) as u8, 0, 0, 255]);
    }
    out
}

/// `FillBufferTestInstance::iterate` and `UpdateBufferTestInstance::iterate`, which differ
/// only in the recorded command and the expected result.
fn fill_or_update_buffer(context: &Context<'_>, params: &TestParams, update: bool) -> TestOutcome {
    let vk = context.get_device();
    let (queue, queue_family_index) = select_queue(context, params.queue_type)?;

    let mut usage = vk::BufferUsageFlags::TRANSFER_DST;
    if params.use_device_address_commands {
        usage |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
    }

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let (destination, destination_alloc) = create_test_buffer(context, params, usage)?;

    let dst_level_width = (params.dst_size / 4) as usize;
    let destination_data = generate_destination_buffer(dst_level_width);

    // generateExpectedResult
    let mut expected = destination_data.clone();
    let test_data_bytes = params.test_data_bytes();
    let first_byte = (params.dst_offset / 4 * 4) as usize;
    if update {
        expected[first_byte..first_byte + params.size as usize]
            .copy_from_slice(&test_data_bytes[..params.size as usize]);
    } else {
        let word = params.test_data[0].to_ne_bytes();
        let end = first_byte + (params.size / 4 * 4) as usize;
        for chunk in expected[first_byte..end].chunks_exact_mut(4) {
            chunk.copy_from_slice(&word);
        }
    }

    // uploadBuffer
    unsafe {
        std::ptr::copy_nonoverlapping(
            destination_data.as_ptr(),
            destination_alloc.host_ptr(),
            destination_data.len(),
        )
    };
    destination_alloc.flush(vk)?;

    let dst_buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        *destination,
        params.dst_offset,
        vk::WHOLE_SIZE,
    );

    begin_command_buffer(vk, *cmd_buffer)?;
    unsafe {
        if params.use_device_address_commands {
            let commands = device_address_commands::load_commands(context)?;
            let dst_address = device_address_commands::buffer_device_address(vk, *destination);
            let dst_range = DeviceAddressRange {
                address: dst_address + params.dst_offset,
                size: params.size,
            };
            // Different valid address flags in some cases to test them.
            if update {
                let mut dst_flags = ADDRESS_COMMAND_FULLY_BOUND;
                if params.size < TEST_DATA_SIZE as u64 {
                    dst_flags |= ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE;
                }
                if params.queue_type == QueueSelection::TransferOnly {
                    dst_flags = 0;
                }
                (commands.update_memory)(
                    *cmd_buffer,
                    &dst_range,
                    dst_flags,
                    params.size,
                    test_data_bytes.as_ptr().cast(),
                );
            } else {
                let mut dst_flags = 0;
                if params.dst_offset != 0 {
                    dst_flags |= ADDRESS_COMMAND_FULLY_BOUND;
                }
                if params.size < vk::WHOLE_SIZE {
                    dst_flags |= ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE;
                }
                (commands.fill_memory)(*cmd_buffer, &dst_range, dst_flags, params.test_data[0]);
            }
        } else if update {
            vk.cmd_update_buffer(
                *cmd_buffer,
                *destination,
                params.dst_offset,
                &test_data_bytes[..params.size as usize],
            );
        } else {
            vk.cmd_fill_buffer(
                *cmd_buffer,
                *destination,
                params.dst_offset,
                params.size,
                params.test_data[0],
            );
        }

        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[dst_buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(vk, *cmd_buffer)?;

    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    // Read buffer data
    destination_alloc.invalidate(vk)?;
    let result = unsafe { std::slice::from_raw_parts(destination_alloc.host_ptr(), destination_data.len()) };

    // checkTestResult: threshold 0.
    if result != expected.as_slice() {
        return Ok(TestStatus::fail("Fill and Update Buffer test"));
    }

    Ok(TestStatus::pass("Fill and Update Buffer test"))
}

/// `TestGroupData`
struct TestGroupData {
    name: &'static str,
    use_dedicated_allocation: bool,
    nonzero_bind_offset: bool,
    queue_type: QueueSelection,
}

fn add_fill_and_update(group: &mut TestCaseGroup, test_name: &str, params: &TestParams) {
    add_case(
        group,
        FillAndUpdateCase {
            name: format!("fill_{test_name}"),
            params: params.clone(),
            kind: Kind::Fill,
        },
    );
    add_case(
        group,
        FillAndUpdateCase {
            name: format!("update_{test_name}"),
            params: params.clone(),
            kind: Kind::Update,
        },
    );
}

/// `populateTestSubgroup`
fn populate_test_subgroup(current_tests_group: &mut TestCaseGroup, group_data: &TestGroupData) {
    let mut params = TestParams {
        dst_size: TEST_DATA_SIZE as u64,
        dst_offset: 0,
        size: 0,
        test_data: [0; TEST_DATA_SIZE],
        allocation_kind: if group_data.use_dedicated_allocation {
            AllocationKind::Dedicated
        } else {
            AllocationKind::Suballocated
        },
        queue_type: group_data.queue_type,
        use_device_address_commands: false,
        nonzero_bind_offset: group_data.nonzero_bind_offset,
    };

    // `data[b] = (uint8_t)(b % 255)` for b in 0..dstSize * sizeof(testData[0])
    let mut data = vec![0u8; TEST_DATA_SIZE * std::mem::size_of::<u32>()];
    for (b, byte) in data
        .iter_mut()
        .enumerate()
        .take(params.dst_size as usize * std::mem::size_of::<u32>())
    {
        *byte = (b % 255) as u8;
    }
    for (word, chunk) in params.test_data.iter_mut().zip(data.chunks_exact(4)) {
        *word = u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]);
    }

    {
        params.dst_offset = 0;
        params.size = params.dst_size;
        add_fill_and_update(current_tests_group, "buffer_whole", &params);
    }

    // limit number of tests repeated for device_address_commands
    if group_data.use_dedicated_allocation {
        params.dst_offset = 0;
        params.size = params.dst_size;
        params.use_device_address_commands = true;
        add_fill_and_update(current_tests_group, "buffer_whole_device_address", &params);
        params.use_device_address_commands = false;
    }

    {
        params.dst_offset = 0;
        params.size = 4;
        add_fill_and_update(current_tests_group, "buffer_first_one", &params);
    }

    {
        params.dst_offset = 4;
        params.size = 4;
        add_fill_and_update(current_tests_group, "buffer_second_one", &params);
    }

    {
        params.dst_offset = params.dst_size / 2;
        params.size = params.dst_size / 2;
        add_fill_and_update(current_tests_group, "buffer_second_part", &params);
    }

    {
        params.dst_offset = params.dst_size / 2;
        params.size = params.dst_size / 2;
        params.use_device_address_commands = true;
        add_fill_and_update(current_tests_group, "buffer_second_part_device_address", &params);
        params.use_device_address_commands = false;
    }

    // VK_WHOLE_SIZE tests.
    {
        params.use_device_address_commands = false;
        for i in 0..std::mem::size_of::<u32>() as u64 {
            for j in 0..std::mem::size_of::<u32>() as u64 {
                params.dst_size = TEST_DATA_SIZE as u64 + i;
                params.dst_offset = j * std::mem::size_of::<u32>() as u64;
                params.size = vk::WHOLE_SIZE;

                let extra_bytes = params.dst_size % std::mem::size_of::<u32>() as u64;
                let name = format!(
                    "fill_buffer_vk_whole_size_{extra_bytes}_extra_bytes_offset_{}",
                    params.dst_offset
                );

                add_case(
                    current_tests_group,
                    FillAndUpdateCase {
                        name,
                        params: params.clone(),
                        kind: Kind::FillWhole,
                    },
                );
            }
        }

        params.dst_size = TEST_DATA_SIZE as u64;
        params.dst_offset = std::mem::size_of::<u32>() as u64;
        params.size = vk::WHOLE_SIZE;
        params.use_device_address_commands = true;

        // when using dedicated allocation test also compute only queue
        if group_data.use_dedicated_allocation {
            params.queue_type = QueueSelection::ComputeOnly;
        }

        add_case(
            current_tests_group,
            FillAndUpdateCase {
                name: "fill_buffer_vk_whole_size_device_address".to_string(),
                params: params.clone(),
                kind: Kind::FillWhole,
            },
        );
    }
}

/// `populateFillAndUpdateBufferTests`
fn populate_fill_and_update_buffer_tests(fill_and_update_buffer_tests: &mut TestCaseGroup) {
    let test_group_data = [
        // BufferView Fill and Update Tests for Suballocated Objects
        TestGroupData {
            name: "suballocation",
            use_dedicated_allocation: false,
            nonzero_bind_offset: false,
            queue_type: QueueSelection::Universal,
        },
        // BufferView Fill and Update Tests for Suballocated Objects using a memory bind offset
        TestGroupData {
            name: "suballocation_bind_offset",
            use_dedicated_allocation: false,
            nonzero_bind_offset: true,
            queue_type: QueueSelection::Universal,
        },
        // BufferView Fill and Update Tests for Suballocated Objects on transfer only queue
        TestGroupData {
            name: "suballocation_transfer_queue",
            use_dedicated_allocation: false,
            nonzero_bind_offset: false,
            queue_type: QueueSelection::TransferOnly,
        },
        // BufferView Fill and Update Tests for Dedicatedly Allocated Objects
        TestGroupData {
            name: "dedicated_alloc",
            use_dedicated_allocation: true,
            nonzero_bind_offset: false,
            queue_type: QueueSelection::Universal,
        },
    ];

    for group_data in &test_group_data {
        let mut group = TestCaseGroup::new(group_data.name);
        populate_test_subgroup(&mut group, group_data);
        fill_and_update_buffer_tests.add_child(group);
    }
}

/// `createFillAndUpdateBufferTests`
pub fn create_fill_and_update_buffer_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fill_and_update_buffer");
    populate_fill_and_update_buffer_tests(&mut group);
    group
}
