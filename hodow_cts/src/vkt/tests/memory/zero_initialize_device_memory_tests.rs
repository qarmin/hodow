// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryZeroInitializeDeviceMemoryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
// Vendored original: hodow_cts/upstream/modules/vulkan/memory/
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported so far: the `clear_buffer` group (64 cases). Upstream's `image_transition`
// group needs GLSL, which in this project may only come from `shaders/manifest/*.toml`,
// so it is absent rather than stubbed - a comparison against `deqp-vk` reports those
// cases as missing instead of as passing.
//
// Every case here needs `VK_EXT_zero_initialize_device_memory`, which almost no driver
// implements yet. A NotSupported verdict is the expected outcome on such a driver, not
// a failure.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{self, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};
use crate::{tcu_fail, tcu_throw_not_supported};

/// The extension every case in this group needs.
const EXTENSION: &str = "VK_EXT_zero_initialize_device_memory";

/// `checkZeroInitializeDeviceMemorySupport`
fn check_zero_initialize_device_memory_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality(EXTENSION)
}

/// `BufferAllocationParams`
#[derive(Clone, Copy)]
struct BufferAllocationParams {
    buffer_size: vk::DeviceSize,
    buffer_usage_flags: vk::BufferUsageFlags,
    host_visible: bool,
}

/// `clearBufferAllocationCheckSupport`
fn clear_buffer_allocation_check_support(context: &Context<'_>, _params: BufferAllocationParams) -> Result<(), TestError> {
    check_zero_initialize_device_memory_support(context)
}

/// `MemoryRequirement::matchesHeap`, which is private in `vk::mem_util`, copied here
/// rather than making it public - `getMemoryTypeList` is the only caller outside the
/// allocator itself.
///
/// Upstream's `MemoryRequirement::ZeroInitialize` is deliberately not modelled: it has
/// no effect on heap matching, it only makes the allocator add
/// `VK_MEMORY_ALLOCATE_ZERO_INITIALIZE_BIT_EXT`, which `allocate_zero_init_memory`
/// always sets.
fn matches_heap(requirement: MemoryRequirement, heap_flags: vk::MemoryPropertyFlags) -> bool {
    if requirement.contains(MemoryRequirement::HOST_VISIBLE) && !heap_flags.contains(vk::MemoryPropertyFlags::HOST_VISIBLE) {
        return false;
    }
    if requirement.contains(MemoryRequirement::COHERENT) && !heap_flags.contains(vk::MemoryPropertyFlags::HOST_COHERENT) {
        return false;
    }
    if requirement.contains(MemoryRequirement::LOCAL) && !heap_flags.contains(vk::MemoryPropertyFlags::DEVICE_LOCAL) {
        return false;
    }
    if requirement.contains(MemoryRequirement::CACHED) && !heap_flags.contains(vk::MemoryPropertyFlags::HOST_CACHED) {
        return false;
    }
    if requirement.contains(MemoryRequirement::NON_LOCAL) && heap_flags.contains(vk::MemoryPropertyFlags::DEVICE_LOCAL) {
        return false;
    }
    true
}

/// `getMemoryTypeList`
fn get_memory_type_list(mem_properties: &vk::PhysicalDeviceMemoryProperties, usable_mem_types: u32, requirement: MemoryRequirement, forbidden: vk::MemoryPropertyFlags) -> u32 {
    let mut tested_types = 0u32;

    for i in 0..mem_properties.memory_type_count {
        let mem_flags = mem_properties.memory_types[i as usize].property_flags;

        if mem_flags.intersects(forbidden) {
            continue;
        }

        let mask = 1u32 << i;
        if (usable_mem_types & mask) == 0 {
            continue;
        }

        if !matches_heap(requirement, mem_flags) {
            continue;
        }

        tested_types |= mask;
    }

    tested_types
}

/// `getTestedMemoryTypes`
fn get_tested_memory_types(mem_properties: &vk::PhysicalDeviceMemoryProperties, usable_mem_types: u32, requirement: MemoryRequirement) -> u32 {
    // We want to skip protected memory types, and device coherent AMD memory types because the extension is not enabled
    // by default.
    let forbidden = vk::MemoryPropertyFlags::PROTECTED | vk::MemoryPropertyFlags::DEVICE_COHERENT_AMD;
    get_memory_type_list(mem_properties, usable_mem_types, requirement, forbidden)
}

/// `vk::isHostVisibleMemory`
fn is_host_visible_memory(mem_properties: &vk::PhysicalDeviceMemoryProperties, mem_type_idx: u32) -> bool {
    mem_properties.memory_types[mem_type_idx as usize]
        .property_flags
        .contains(vk::MemoryPropertyFlags::HOST_VISIBLE)
}

/// One zero-initialized `VkDeviceMemory`, plus its host mapping when the memory type
/// has one - `vk::Allocation` as produced by upstream's
/// `SimpleAllocator::allocate(const VkMemoryAllocateInfo&, VkDeviceSize)`.
///
/// The port's `SimpleAllocator` cannot produce it: it has no way to pass a
/// `VkMemoryAllocateFlagsInfo`, which is the whole point of this group.
struct ZeroInitAllocation<'a> {
    device: &'a Device,
    memory: vk::DeviceMemory,
    offset: vk::DeviceSize,
    host_ptr: *mut u8,
}

impl ZeroInitAllocation<'_> {
    /// `Allocation::getMemory`
    fn get_memory(&self) -> vk::DeviceMemory {
        self.memory
    }

    /// `Allocation::getOffset`
    fn get_offset(&self) -> vk::DeviceSize {
        self.offset
    }

    /// `Allocation::getHostPtr`. Only valid for a host-visible memory type.
    fn get_host_ptr(&self) -> *mut u8 {
        assert!(!self.host_ptr.is_null(), "getHostPtr on a non-host-visible allocation");
        self.host_ptr
    }
}

impl Drop for ZeroInitAllocation<'_> {
    fn drop(&mut self) {
        unsafe {
            if !self.host_ptr.is_null() {
                self.device.unmap_memory(self.memory);
            }
            self.device.free_memory(self.memory, None);
        }
    }
}

/// `allocateZeroInitMemory`
///
/// This function allocates memory for the buffers and images being tested, so it always
/// adds the flag. The mapping is done under the same condition upstream's allocator
/// applies - whenever the chosen memory type is host-visible, not whenever the caller
/// asked for one.
fn allocate_zero_init_memory<'a>(
    vk: &'a Device,
    mem_properties: &vk::PhysicalDeviceMemoryProperties,
    reqs: &vk::MemoryRequirements,
    mem_type_idx: u32,
) -> Result<ZeroInitAllocation<'a>, TestError> {
    let mem_type_mask = 1u32 << mem_type_idx;
    debug_assert!((reqs.memory_type_bits & mem_type_mask) != 0);

    let mut flags_info = vk::MemoryAllocateFlagsInfo::builder().flags(vk::MemoryAllocateFlags::ZERO_INITIALIZE_EXT).device_mask(0);

    let allocate_info = vk::MemoryAllocateInfo::builder()
        .allocation_size(reqs.size)
        .memory_type_index(mem_type_idx)
        .push_next(&mut flags_info);

    let memory = unsafe { vk.allocate_memory(&allocate_info, None) }.vk_check("vkAllocateMemory")?;

    let host_ptr = if is_host_visible_memory(mem_properties, mem_type_idx) {
        match unsafe { vk.map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty()) } {
            Ok(p) => p.cast::<u8>(),
            Err(e) => {
                unsafe { vk.free_memory(memory, None) };
                return Err(TestError::ResourceError(format!("vkMapMemory failed: {e}")));
            }
        }
    } else {
        std::ptr::null_mut()
    };

    Ok(ZeroInitAllocation {
        device: vk,
        memory,
        offset: 0,
        host_ptr,
    })
}

/// The device this group runs on.
///
/// Upstream uses `ctx.device`, because its `DefaultDevice` turns on every feature the
/// physical device reports. The port's `Context` enables every advertised device
/// extension but only a fixed set of feature structs, and
/// `VkPhysicalDeviceZeroInitializeDeviceMemoryFeaturesEXT::zeroInitializeDeviceMemory`
/// is not one of them - passing `VK_MEMORY_ALLOCATE_ZERO_INITIALIZE_BIT_EXT` without it
/// enabled is invalid usage, so this group builds its own device instead.
struct ZeroInitDevice {
    device: Device,
    queue: vk::Queue,
}

impl ZeroInitDevice {
    fn new(context: &Context<'_>) -> Result<Self, TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let queue_family_index = context.get_universal_queue_family_index();

        let priorities = [1.0f32];
        let queue_infos = [vk::DeviceQueueCreateInfo::builder().queue_family_index(queue_family_index).queue_priorities(&priorities)];

        let mut zero_init_features = vk::PhysicalDeviceZeroInitializeDeviceMemoryFeaturesEXT::builder().zero_initialize_device_memory(true);

        let extension_ptrs = [vk::EXT_ZERO_INITIALIZE_DEVICE_MEMORY_EXTENSION.name.as_ptr()];
        let info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&extension_ptrs)
            .push_next(&mut zero_init_features);

        let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;
        let queue = unsafe { device.get_device_queue(queue_family_index, 0) };

        Ok(Self { device, queue })
    }
}

impl Drop for ZeroInitDevice {
    fn drop(&mut self) {
        unsafe {
            // A device that is already lost cannot be waited on; ignore the result so
            // teardown after a device-lost test does not itself become an error.
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

/// Upstream's `testedBuffer` and `testedBufferAlloc` locals, bound together.
///
/// They are one struct rather than two locals because Rust drops locals in reverse
/// declaration order: an allocation declared after its buffer would be freed while the
/// buffer was still bound to it. Struct fields drop in declaration order, so the handle
/// dies before its memory.
struct TestedBuffer<'a> {
    buffer: Unique<'a, vk::Buffer>,
    allocation: ZeroInitAllocation<'a>,
}

impl<'a> TestedBuffer<'a> {
    fn new(
        vk: &'a Device,
        buffer_create_info: &vk::BufferCreateInfo,
        buffer_mem_reqs: &vk::MemoryRequirements,
        mem_properties: &vk::PhysicalDeviceMemoryProperties,
        mem_type_idx: u32,
    ) -> Result<Self, TestError> {
        let buffer = create_buffer(vk, buffer_create_info)?;
        let allocation = allocate_zero_init_memory(vk, mem_properties, buffer_mem_reqs, mem_type_idx)?;

        // Assembled before the bind so that a failing bind still tears down in field
        // order, not in reverse local order.
        let tested_buffer = Self { buffer, allocation };
        unsafe { vk.bind_buffer_memory(*tested_buffer.buffer, tested_buffer.allocation.get_memory(), tested_buffer.allocation.get_offset()) }.vk_check("vkBindBufferMemory")?;

        Ok(tested_buffer)
    }
}

/// `vk::createBuffer`
fn create_buffer<'a>(vk: &'a Device, create_info: &vk::BufferCreateInfo) -> Result<Unique<'a, vk::Buffer>, TestError> {
    let buffer = unsafe { vk.create_buffer(create_info, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(vk, buffer))
}

/// `clearBufferAllocation`
fn clear_buffer_allocation(context: &Context<'_>, params: BufferAllocationParams) -> TestOutcome {
    // Declared first so it is destroyed last: everything below is allocated from it.
    let zero_init_device = ZeroInitDevice::new(context)?;
    let vk = &zero_init_device.device;
    let queue = zero_init_device.queue;
    let qf_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();

    // Allocate buffer memory clearing it to zero.
    let usage_flags = params.buffer_usage_flags
        | if params.host_visible {
            vk::BufferUsageFlags::empty()
        } else {
            vk::BufferUsageFlags::TRANSFER_SRC
        };
    let buffer_create_info = make_buffer_create_info(params.buffer_size, usage_flags);
    // Upstream's `MemoryRequirement::ZeroInitialize | ...`; see `matches_heap` for why
    // the ZeroInitialize half is not modelled here.
    let mem_reqs = if params.host_visible { MemoryRequirement::HOST_VISIBLE } else { MemoryRequirement::ANY };

    let template_buffer = create_buffer(vk, &buffer_create_info)?;
    let buffer_mem_reqs = unsafe { vk.get_buffer_memory_requirements(*template_buffer) };

    let mem_properties = unsafe { context.get_instance().get_physical_device_memory_properties(context.get_physical_device()) };

    let tested_mem_types = get_tested_memory_types(&mem_properties, buffer_mem_reqs.memory_type_bits, mem_reqs);
    if tested_mem_types == 0 {
        tcu_throw_not_supported!("No compatible memory types found");
    }

    let dst_buffer = if params.host_visible {
        None
    } else {
        let dst_buffer_usage = vk::BufferUsageFlags::TRANSFER_DST;
        let dst_buffer_create_info = make_buffer_create_info(params.buffer_size, dst_buffer_usage);
        Some(BufferWithMemory::new(vk, allocator, dst_buffer_create_info, MemoryRequirement::HOST_VISIBLE)?)
    };

    // Upstream's `fail` flag plus the per-type line it writes to `tcu::TestLog`. There
    // is no log in this port, so the indices go into the final Fail description.
    let mut failed_mem_types = Vec::<u32>::new();

    for mem_type_idx in 0..mem_properties.memory_type_count {
        let mem_type_mask = 1u32 << mem_type_idx;
        if (tested_mem_types & mem_type_mask) == 0 {
            continue;
        }

        let tested_buffer = TestedBuffer::new(vk, &buffer_create_info, &buffer_mem_reqs, &mem_properties, mem_type_idx)?;

        // `if (!params.hostVisible)`: the staging buffer exists exactly then.
        if let Some(dst_buffer) = dst_buffer.as_ref() {
            let cmd_pool = make_command_pool(vk, qf_index)?;
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(vk, *cmd_buffer)?;

            let region = vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: params.buffer_size,
            };
            unsafe { vk.cmd_copy_buffer(*cmd_buffer, *tested_buffer.buffer, dst_buffer.get(), &[region]) };

            let barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                vk.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;

            let dst_buffer_alloc = dst_buffer.get_allocation();
            invalidate_alloc(vk, dst_buffer_alloc)?;
        }

        let verified_buffer_data = match dst_buffer.as_ref() {
            Some(dst_buffer) => dst_buffer.get_allocation().get_host_ptr(),
            None => tested_buffer.allocation.get_host_ptr(),
        };

        let buffer_size_sz = params.buffer_size as usize;
        let ref_buffer = vec![0u8; buffer_size_sz];
        let ret = unsafe { std::slice::from_raw_parts(verified_buffer_data, buffer_size_sz) } != ref_buffer.as_slice();

        if ret {
            failed_mem_types.push(mem_type_idx);
        }

        // `context.getTestContext().touchWatchdog()` has no equivalent here: the
        // runner's watchdog lives outside the case.
    }

    if !failed_mem_types.is_empty() {
        tcu_fail!("Some memory types failed; failing memory types: {failed_mem_types:?}");
    }

    Ok(TestStatus::pass("Pass"))
}

/// One of the 64 `clear_buffer.*` cases. Upstream registers them with
/// `addFunctionCase`, which has no counterpart here, so the check-support and iterate
/// functions it would pair up are wired through this TestCase/TestInstance pair
/// instead.
struct ClearBufferAllocationCase {
    name: String,
    params: BufferAllocationParams,
}

impl TestCase for ClearBufferAllocationCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        clear_buffer_allocation_check_support(context, self.params)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ClearBufferAllocationInstance { context, params: self.params })
    }
}

struct ClearBufferAllocationInstance<'a> {
    context: &'a Context<'a>,
    params: BufferAllocationParams,
}

impl TestInstance for ClearBufferAllocationInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        clear_buffer_allocation(self.context, self.params)
    }
}

/// `createClearedAllocationControlTests` - upstream's entry point, which is registered
/// under the name `zero_initialize_device_memory`.
///
/// Only the `clear_buffer` group is built. `image_transition` is not ported: its cases
/// need GLSL, and shaders in this project may only come from `shaders/manifest/*.toml`.
pub fn create_zero_initialize_device_memory_tests() -> tcu::TestCaseGroup {
    let mut main_group = tcu::TestCaseGroup::new("zero_initialize_device_memory");
    let mut buffer_group = tcu::TestCaseGroup::new("clear_buffer");

    let buffer_size_cases: [vk::DeviceSize; 4] = [1, 4, 4096, 4194304];
    struct BufferUsageFlagName {
        usage_bit: vk::BufferUsageFlags,
        name: &'static str,
    }
    let buffer_usage_cases = [
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::TRANSFER_DST,
            name: "transfer_dst",
        },
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER,
            name: "uniform_texel_buffer",
        },
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER,
            name: "storage_texel_buffer",
        },
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::UNIFORM_BUFFER,
            name: "uniform_buffer",
        },
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::STORAGE_BUFFER,
            name: "storage_buffer",
        },
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::INDEX_BUFFER,
            name: "index_buffer",
        },
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::VERTEX_BUFFER,
            name: "vertex_buffer",
        },
        BufferUsageFlagName {
            usage_bit: vk::BufferUsageFlags::INDIRECT_BUFFER,
            name: "indirect_buffer",
        },
    ];

    for usage in &buffer_usage_cases {
        for size in buffer_size_cases {
            for host_visible in [false, true] {
                let params = BufferAllocationParams {
                    buffer_size: size,
                    buffer_usage_flags: usage.usage_bit,
                    host_visible,
                };

                let test_name = format!("{}_{}{}", usage.name, size, if host_visible { "_host_visible" } else { "" });

                buffer_group.add_child(Box::new(ClearBufferAllocationCase { name: test_name, params }) as Box<dyn TestCase>);
            }
        }
    }

    main_group.add_child(buffer_group);

    main_group
}
