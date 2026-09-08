// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyBufferToBufferTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiCopiesAndBlittingTests.cpp   (the dispatcher)
//   external/vulkancts/modules/vulkan/api/vktApiCopiesAndBlittingUtil.cpp/.hpp
//   framework/common/tcuTextureUtil.cpp                                      (gradient fill)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// This is the buffer-to-buffer slice of dEQP-VK.api.copy_and_blit. No shaders are
// involved anywhere in this group, so every case hands back an empty
// BinaryCollection and nothing here has a manifest entry.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrCopyCommands2ExtensionDeviceCommands};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{Allocation, MemoryRequirement};
use crate::vk::obj_util::{allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `defaultSize` / `defaultQuarterSize` / `defaultLargeSize` from
/// vktApiCopiesAndBlittingUtil.hpp.
const DEFAULT_SIZE: u64 = 64;
const DEFAULT_QUARTER_SIZE: u64 = DEFAULT_SIZE / 4;
const DEFAULT_LARGE_SIZE: u64 = 4096;

/// `AllocationKind`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AllocationKind {
    Suballocated,
    Dedicated,
}

/// `QueueSelectionOptions`, narrowed to the two the buffer copies use.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum QueueSelection {
    Universal,
    TransferOnly,
    ComputeOnly,
}

/// The extension flag that picks `vkCmdCopyBuffer2` over `vkCmdCopyBuffer`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum CopyCommandVariant {
    Core,
    CopyCommands2,
}

/// `VkBufferCopy`, as the test table declares it.
#[derive(Clone, Copy)]
pub struct BufferCopyRegion {
    pub src_offset: u64,
    pub dst_offset: u64,
    pub size: u64,
}

// ---------------------------------------------------------------------------------
// Buffer fill - the R32_UINT slice of tcu
// ---------------------------------------------------------------------------------

/// `linearInterpolate`
fn linear_interpolate(t: f32, min_val: f32, max_val: f32) -> f32 {
    min_val + (max_val - min_val) * t
}

/// `tcu::PixelBufferAccess::setPixel` for an UNSIGNED_INT32 channel: round to nearest,
/// saturate. Only the R channel exists in R32_UINT, which is the format
/// `generateFilledBuffer` uses for every buffer-to-buffer case.
fn set_pixel_r32_uint(value: f32) -> u32 {
    if value <= 0.0 {
        0
    } else if value >= u32::MAX as f32 {
        u32::MAX
    } else {
        // rte, as tcu's convertSatRte does.
        let rounded = value.round_ties_even();
        rounded as u32
    }
}

/// `generateBuffer(.., FILL_MODE_GRADIENT)` on the R32_UINT texture that
/// `CopyBufferToBuffer::generateFilledBuffer` builds: width = size/4, height = 1.
///
/// The `maxValue` for R32_UINT comes from `generateBuffer`'s integer branch: 32 bits,
/// unsigned, so `(1 << 32) - 1`. The other three channels have zero bits and keep the
/// default 1.0, but R32_UINT has no other channels to write.
///
/// This pattern does not decide the verdict for buffer-to-buffer - both the expected
/// image and the device's result derive from it - but it is reproduced faithfully
/// because the image-copy tests that share this helper do compare against upstream's
/// exact values.
fn generate_filled_buffer(size: u64) -> Vec<u8> {
    let level_width = (size / 4) as usize;
    let max_r = ((1u64 << 32) - 1) as f32;

    let mut out = Vec::with_capacity(level_width * 4);
    // height is 1, so t is fixed at 0.5.
    let t = 0.5f32;
    for x in 0..level_width {
        let s = (x as f32 + 0.5) / level_width as f32;
        let r = linear_interpolate((s + t) * 0.5, 0.0, max_r);
        out.extend_from_slice(&set_pixel_r32_uint(r).to_ne_bytes());
    }
    // The texture covers floor(size/4) texels; a size that is not a multiple of 4
    // leaves a tail that upstream never writes and never reads.
    out.resize(size as usize, 0);
    out
}

// ---------------------------------------------------------------------------------
// Shared plumbing
// ---------------------------------------------------------------------------------

/// Picks the queue family a case wants. Upstream builds a custom device for the
/// transfer-only variants; hodow_cts has one device, so a driver with no
/// transfer-only family reports NotSupported - which is the same verdict upstream
/// gives, since it cannot create that device either.
/// The queue a case runs its copy on, with its family index.
///
/// It has to come from the Context rather than a fresh `vkGetDeviceQueue`: a queue may
/// only be fetched from a family the device was *created* with, and asking for one from
/// any other family is undefined behaviour that segfaults in practice rather than
/// returning an error.
pub(crate) fn select_queue(context: &Context<'_>, selection: QueueSelection) -> Result<(vk::Queue, u32), TestError> {
    match selection {
        QueueSelection::Universal => Ok((context.get_universal_queue(), context.get_universal_queue_family_index())),
        QueueSelection::TransferOnly => context
            .get_transfer_queue()
            .ok_or_else(|| TestError::NotSupported("No transfer-only queue family".to_string())),
        QueueSelection::ComputeOnly => context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("No compute-only queue family".to_string())),
    }
}

/// Allocates and binds host-visible memory for `buffer`, honouring the allocation
/// kind: DEDICATED chains a VkMemoryDedicatedAllocateInfo, which is the whole point of
/// the `dedicated_allocation` group.
pub(crate) fn bind_buffer_memory<'a>(context: &'a Context<'a>, buffer: vk::Buffer, allocation_kind: AllocationKind) -> Result<Allocation<'a>, TestError> {
    let vk_device = context.get_device();
    let req = unsafe { vk_device.get_buffer_memory_requirements(buffer) };

    let allocation = match allocation_kind {
        AllocationKind::Suballocated => context.get_default_allocator().allocate(vk_device, req, MemoryRequirement::HOST_VISIBLE)?,
        AllocationKind::Dedicated => context
            .get_default_allocator()
            .allocate_dedicated_buffer(vk_device, req, MemoryRequirement::HOST_VISIBLE, buffer)?,
    };

    unsafe { vk_device.bind_buffer_memory(buffer, allocation.get_memory(), allocation.get_offset()) }.vk_check("vkBindBufferMemory")?;
    Ok(allocation)
}

// ---------------------------------------------------------------------------------
// CopyBufferToBuffer
// ---------------------------------------------------------------------------------

pub struct BufferToBufferCase {
    name: &'static str,
    src_size: u64,
    dst_size: u64,
    regions: &'static [BufferCopyRegion],
    allocation_kind: AllocationKind,
    queue_selection: QueueSelection,
    command_variant: CopyCommandVariant,
}

impl TestCase for BufferToBufferCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        select_queue(context, self.queue_selection)?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferToBufferInstance { context, params: self })
    }
}

struct BufferToBufferInstance<'a> {
    context: &'a Context<'a>,
    params: &'a BufferToBufferCase,
}

impl TestInstance for BufferToBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk_device = self.context.get_device();
        let (queue, queue_family_index) = select_queue(self.context, self.params.queue_selection)?;

        // Create source buffer
        let source = unsafe { vk_device.create_buffer(&make_buffer_create_info(self.params.src_size, vk::BufferUsageFlags::TRANSFER_SRC), None) }.vk_check("vkCreateBuffer")?;
        let source = Unique::new(vk_device, source);
        let source_alloc = bind_buffer_memory(self.context, *source, self.params.allocation_kind)?;

        // Create destination buffer
        let destination =
            unsafe { vk_device.create_buffer(&make_buffer_create_info(self.params.dst_size, vk::BufferUsageFlags::TRANSFER_DST), None) }.vk_check("vkCreateBuffer")?;
        let destination = Unique::new(vk_device, destination);
        let destination_alloc = bind_buffer_memory(self.context, *destination, self.params.allocation_kind)?;

        // Fill the source, and give the destination a known starting content so that a
        // copy that writes too much is caught rather than blending into leftovers.
        let src_data = generate_filled_buffer(self.params.src_size);
        let dst_data = generate_filled_buffer(self.params.dst_size);
        unsafe {
            std::ptr::copy_nonoverlapping(src_data.as_ptr(), source_alloc.get_host_ptr(), src_data.len());
            std::ptr::copy_nonoverlapping(dst_data.as_ptr(), destination_alloc.get_host_ptr(), dst_data.len());
        }
        crate::vk::mem_util::flush_alloc(vk_device, &source_alloc)?;
        crate::vk::mem_util::flush_alloc(vk_device, &destination_alloc)?;

        // `copyRegionToTextureLevel`: the expected image is the destination's initial
        // content with each region memcpy'd over it, in order.
        let mut expected = dst_data.clone();
        for region in self.params.regions {
            let src = region.src_offset as usize;
            let dst = region.dst_offset as usize;
            let len = region.size as usize;
            expected[dst..dst + len].copy_from_slice(&src_data[src..src + len]);
        }

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let src_buffer_barrier = crate::vk::obj_util::make_buffer_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::TRANSFER_READ, *source, 0, self.params.src_size);
        let dst_buffer_barrier =
            crate::vk::obj_util::make_buffer_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ, *destination, 0, self.params.dst_size);

        let copies: Vec<vk::BufferCopy> = self
            .params
            .regions
            .iter()
            .map(|r| vk::BufferCopy {
                src_offset: r.src_offset,
                dst_offset: r.dst_offset,
                size: r.size,
            })
            .collect();

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[src_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // The copy_commands2 group exists to exercise vkCmdCopyBuffer2 - calling
            // vkCmdCopyBuffer here would produce an identical result and an identical
            // verdict, so the differential comparison could never catch the mistake.
            match self.params.command_variant {
                CopyCommandVariant::Core => {
                    vk_device.cmd_copy_buffer(*cmd_buffer, *source, *destination, &copies);
                }
                CopyCommandVariant::CopyCommands2 => {
                    let regions2: Vec<vk::BufferCopy2> = copies
                        .iter()
                        .map(|c| vk::BufferCopy2::builder().src_offset(c.src_offset).dst_offset(c.dst_offset).size(c.size).build())
                        .collect();
                    let info = vk::CopyBufferInfo2::builder().src_buffer(*source).dst_buffer(*destination).regions(&regions2);
                    // VK_KHR_copy_commands2 was promoted into core 1.3. A driver that
                    // advertises the extension exports the KHR alias; one that only
                    // reports 1.3 exports the core name. Picking by what is actually
                    // advertised avoids a null entry point, which vulkanalia turns
                    // into a process-aborting stub.
                    if self.context.get_device_extensions().iter().any(|e| e == "VK_KHR_copy_commands2") {
                        vk_device.cmd_copy_buffer2_khr(*cmd_buffer, &info);
                    } else {
                        vk_device.cmd_copy_buffer2(*cmd_buffer, &info);
                    }
                }
            }

            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[dst_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        crate::vk::mem_util::invalidate_alloc(vk_device, &destination_alloc)?;

        // `checkTestResult`: exact comparison, threshold 0.
        let result = unsafe { std::slice::from_raw_parts(destination_alloc.get_host_ptr(), self.params.dst_size as usize) };
        for (i, (&got, &want)) in result.iter().zip(expected.iter()).enumerate() {
            if got != want {
                return Ok(TestStatus::fail(format!("CopiesAndBlitting test: byte {i} is {got}, expected {want}")));
            }
        }

        Ok(TestStatus::pass("CopiesAndBlitting test"))
    }
}

// ---------------------------------------------------------------------------------
// bufferOffsetTest
// ---------------------------------------------------------------------------------

/// `BufferOffsetParams::kMaxOffset`
const K_MAX_OFFSET: u32 = 8;
const K_BLOCK_SIZE: u32 = K_MAX_OFFSET * 2;
const K_BUFFER_SIZE: u32 = K_MAX_OFFSET * K_BLOCK_SIZE;

pub struct BufferOffsetCase {
    name: String,
    src_offset: u32,
    dst_offset: u32,
}

impl TestCase for BufferOffsetCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferOffsetInstance {
            context,
            src_offset: self.src_offset,
            dst_offset: self.dst_offset,
        })
    }
}

struct BufferOffsetInstance<'a> {
    context: &'a Context<'a>,
    src_offset: u32,
    dst_offset: u32,
}

impl TestInstance for BufferOffsetInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vkd = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let q_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();

        let src_buffer = crate::vk::obj_util::BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(u64::from(K_BUFFER_SIZE), vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let dst_buffer = crate::vk::obj_util::BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(u64::from(K_BUFFER_SIZE), vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Zero-out destination buffer.
        unsafe { std::ptr::write_bytes(dst_buffer.get_allocation().get_host_ptr(), 0, K_BUFFER_SIZE as usize) };
        crate::vk::mem_util::flush_alloc(vkd, dst_buffer.get_allocation())?;

        // Fill source buffer with nonzero bytes.
        let src_data: Vec<u8> = (0..K_BUFFER_SIZE).map(|i| (100u32 + i) as u8).collect();
        unsafe {
            std::ptr::copy_nonoverlapping(src_data.as_ptr(), src_buffer.get_allocation().get_host_ptr(), src_data.len());
        }
        crate::vk::mem_util::flush_alloc(vkd, src_buffer.get_allocation())?;

        // Copy regions.
        let copies: Vec<vk::BufferCopy> = (0..K_MAX_OFFSET)
            .map(|i| {
                let block_start = K_BLOCK_SIZE * i;
                vk::BufferCopy {
                    src_offset: u64::from(self.src_offset + block_start),
                    dst_offset: u64::from(self.dst_offset + block_start),
                    size: u64::from(i + 1),
                }
            })
            .collect();

        let cmd_pool = make_command_pool(vkd, q_index)?;
        let cmd_buffer = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vkd, *cmd_buffer)?;
        unsafe {
            vkd.cmd_copy_buffer(*cmd_buffer, src_buffer.get(), dst_buffer.get(), &copies);
            let barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            vkd.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vkd, *cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, *cmd_buffer)?;

        crate::vk::mem_util::invalidate_alloc(vkd, dst_buffer.get_allocation())?;

        // Verify destination buffer data.
        let dst_data = unsafe { std::slice::from_raw_parts(dst_buffer.get_allocation().get_host_ptr(), K_BUFFER_SIZE as usize) };

        let check_zeros_at = |start: u32, count: u32| -> Option<u32> { (start..start + count).find(|&i| dst_data[i as usize] != 0) };

        for block_idx in 0..K_MAX_OFFSET {
            let block_start = K_BLOCK_SIZE * block_idx;
            let copy_size = block_idx + 1;

            // Verify no data has been written before dstOffset.
            if let Some(pos) = check_zeros_at(block_start, self.dst_offset) {
                return Ok(TestStatus::fail(format!("Non-zero byte found at position {pos} before the copied block")));
            }

            // Verify copied block.
            for i in 0..copy_size {
                let dst_val = dst_data[(block_start + self.dst_offset + i) as usize];
                let src_val = src_data[(block_start + self.src_offset + i) as usize];
                if dst_val != src_val {
                    return Ok(TestStatus::fail(format!(
                        "Unexpected value found at position {}: expected {} but found {}",
                        block_start + self.dst_offset + i,
                        src_val,
                        dst_val
                    )));
                }
            }

            // Verify no data has been written after copy block.
            let after = block_start + self.dst_offset + copy_size;
            if let Some(pos) = check_zeros_at(after, K_BLOCK_SIZE - (self.dst_offset + copy_size)) {
                return Ok(TestStatus::fail(format!("Non-zero byte found at position {pos} after the copied block")));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// addCopyBufferToBufferTests
// ---------------------------------------------------------------------------------

// The region tables, in upstream's registration order.
static WHOLE: &[BufferCopyRegion] = &[BufferCopyRegion {
    src_offset: 0,
    dst_offset: 0,
    size: DEFAULT_SIZE,
}];
static PARTIAL: &[BufferCopyRegion] = &[BufferCopyRegion {
    src_offset: 12,
    dst_offset: 4,
    size: 1,
}];
static WHOLE_LARGE: &[BufferCopyRegion] = &[BufferCopyRegion {
    src_offset: 0,
    dst_offset: 0,
    size: DEFAULT_LARGE_SIZE,
}];
static PARTIAL_LARGE: &[BufferCopyRegion] = &[BufferCopyRegion {
    src_offset: 1024,
    dst_offset: DEFAULT_LARGE_SIZE / 2,
    size: DEFAULT_LARGE_SIZE / 2,
}];
static PARTIAL_LARGE_UNALIGNED: &[BufferCopyRegion] = &[BufferCopyRegion {
    src_offset: 1024,
    dst_offset: DEFAULT_LARGE_SIZE / 2,
    size: 1 + DEFAULT_LARGE_SIZE,
}];

/// `regions`: copy regions with size 1..=16, each into its own slot.
static REGIONS: &[BufferCopyRegion] = &{
    let mut out = [BufferCopyRegion {
        src_offset: 0,
        dst_offset: 0,
        size: 0,
    }; 16];
    let mut i = 1;
    while i <= 16 {
        out[i - 1] = BufferCopyRegion {
            src_offset: 0,
            dst_offset: (i * 16) as u64,
            size: i as u64,
        };
        i += 1;
    }
    out
};

/// `unaligned_regions`: four regions at deliberately unaligned offsets.
static UNALIGNED_REGIONS: &[BufferCopyRegion] = &{
    let mut out = [BufferCopyRegion {
        src_offset: 0,
        dst_offset: 0,
        size: 0,
    }; 4];
    let mut i = 0;
    while i < 4 {
        out[i] = BufferCopyRegion {
            src_offset: (3 + i * 3) as u64,
            dst_offset: (1 + i * 5) as u64,
            size: (2 + i) as u64,
        };
        i += 1;
    }
    out
};

/// `unaligned_regions_large`
static UNALIGNED_REGIONS_LARGE: &[BufferCopyRegion] = &{
    let mut out = [BufferCopyRegion {
        src_offset: 0,
        dst_offset: 0,
        size: 0,
    }; 5];
    let mut i = 0;
    while i < 5 {
        out[i] = BufferCopyRegion {
            src_offset: (3 + i * 512) as u64,
            dst_offset: (1 + i * 1024) as u64,
            size: (2 + i * 256) as u64,
        };
        i += 1;
    }
    out
};

/// `addCopyBufferToBufferTests`
fn add_copy_buffer_to_buffer_tests(group: &mut TestCaseGroup, allocation_kind: AllocationKind, queue_selection: QueueSelection, command_variant: CopyCommandVariant) {
    let mut add = |name: &'static str, src_size: u64, dst_size: u64, regions: &'static [BufferCopyRegion]| {
        group.add_child(Box::new(BufferToBufferCase {
            name,
            src_size,
            dst_size,
            regions,
            allocation_kind,
            queue_selection,
            command_variant,
        }) as Box<dyn TestCase>);
    };

    add("whole", DEFAULT_SIZE, DEFAULT_SIZE, WHOLE);
    add("partial", DEFAULT_QUARTER_SIZE, DEFAULT_QUARTER_SIZE, PARTIAL);
    add("regions", 16, 16 * 17, REGIONS);
    add("unaligned_regions", 32, 32, UNALIGNED_REGIONS);
    add("whole_large", DEFAULT_LARGE_SIZE, DEFAULT_LARGE_SIZE, WHOLE_LARGE);
    add("partial_large", DEFAULT_LARGE_SIZE, DEFAULT_LARGE_SIZE, PARTIAL_LARGE);
    add("partial_large_unaligned_size", 2 * DEFAULT_LARGE_SIZE, 2 * DEFAULT_LARGE_SIZE, PARTIAL_LARGE_UNALIGNED);
    add("unaligned_regions_large", 2 * DEFAULT_LARGE_SIZE, 2 * DEFAULT_LARGE_SIZE, UNALIGNED_REGIONS_LARGE);
}

/// `addCopyBufferToBufferOffsetTests`
fn add_copy_buffer_to_buffer_offset_tests(group: &mut TestCaseGroup) {
    let mut sub_group = TestCaseGroup::new("buffer_to_buffer_with_offset");
    for src_offset in 0..K_MAX_OFFSET {
        for dst_offset in 0..K_MAX_OFFSET {
            sub_group.add_child(Box::new(BufferOffsetCase {
                name: format!("{src_offset}_{dst_offset}"),
                src_offset,
                dst_offset,
            }) as Box<dyn TestCase>);
        }
    }
    group.add_child(sub_group);
}

/// The buffer-to-buffer slice of `createCopiesAndBlittingTests`.
///
/// Only the sub-groups that are actually ported are registered; the rest are absent
/// rather than present-and-skipped, so a comparison against `deqp-vk` reports them as
/// missing instead of as passing.
pub fn create_buffer_copy_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("copy_and_blit");

    for (kind_name, allocation_kind, command_variant) in [
        ("core", AllocationKind::Suballocated, CopyCommandVariant::Core),
        ("dedicated_allocation", AllocationKind::Dedicated, CopyCommandVariant::Core),
        ("copy_commands2", AllocationKind::Dedicated, CopyCommandVariant::CopyCommands2),
    ] {
        let mut kind_group = TestCaseGroup::new(kind_name);

        let mut b2b = TestCaseGroup::new("buffer_to_buffer");
        add_copy_buffer_to_buffer_tests(&mut b2b, allocation_kind, QueueSelection::Universal, command_variant);
        kind_group.add_child(b2b);

        let mut b2b_transfer = TestCaseGroup::new("buffer_to_buffer_transfer_queue");
        add_copy_buffer_to_buffer_tests(&mut b2b_transfer, allocation_kind, QueueSelection::TransferOnly, command_variant);
        kind_group.add_child(b2b_transfer);

        for (suffix, queue_selection, general_layout) in [
            ("", QueueSelection::Universal, false),
            ("_transfer_queue", QueueSelection::TransferOnly, false),
            ("_compute_queue", QueueSelection::ComputeOnly, false),
            ("_general_layout", QueueSelection::Universal, true),
        ] {
            // Upstream registers general_layout under `core` only.
            if general_layout && kind_name != "core" {
                continue;
            }
            super::copies_image_tests::add_buffer_to_image_groups(
                &mut kind_group,
                &format!("buffer_to_image{suffix}"),
                allocation_kind,
                command_variant,
                queue_selection,
                general_layout,
            );
            // No general_layout variants of these two upstream.
            if !general_layout {
                super::copies_image_tests::add_depth_stencil_to_buffer_groups(
                    &mut kind_group,
                    &format!("depthstencil_to_buffer{suffix}"),
                    allocation_kind,
                    command_variant,
                    queue_selection,
                    general_layout,
                );
                super::copies_image_tests::add_buffer_to_depth_stencil_groups(
                    &mut kind_group,
                    &format!("buffer_to_depthstencil{suffix}"),
                    allocation_kind,
                    command_variant,
                    queue_selection,
                    general_layout,
                );
            }
            super::copies_image_tests::add_image_to_buffer_groups(
                &mut kind_group,
                &format!("image_to_buffer{suffix}"),
                allocation_kind,
                command_variant,
                queue_selection,
                general_layout,
            );
        }

        // image_to_image does not get the same queue matrix as the buffer/image
        // groups: upstream registers general_layout under core only, and the
        // transfer queue only under copy_commands2.
        for (suffix, queue_selection, general_layout) in [
            ("", QueueSelection::Universal, false),
            ("_general_layout", QueueSelection::Universal, true),
            ("_transfer_queue", QueueSelection::TransferOnly, false),
        ] {
            let registered = matches!(
                (kind_name, suffix),
                ("core", "" | "_general_layout") | ("dedicated_allocation", "") | ("copy_commands2", "" | "_transfer_queue")
            );
            if registered {
                super::copies_image_tests::add_image_to_image_groups(
                    &mut kind_group,
                    &format!("image_to_image{suffix}"),
                    allocation_kind,
                    command_variant,
                    queue_selection,
                    general_layout,
                );
            }
        }

        super::blitting_tests::add_blitting_image_groups(&mut kind_group, "blit_image", allocation_kind, command_variant);
        super::resolve_image_tests::add_resolve_image_tests(&mut kind_group, allocation_kind, command_variant);
        super::depth_stencil_msaa_copy_tests::add_depth_stencil_msaa_tests(&mut kind_group, allocation_kind, command_variant);

        // buffer_to_buffer_with_offset exists only under `core` upstream.
        if kind_name == "core" {
            add_copy_buffer_to_buffer_offset_tests(&mut kind_group);
        }

        tests.add_child(kind_group);
    }

    tests
}
