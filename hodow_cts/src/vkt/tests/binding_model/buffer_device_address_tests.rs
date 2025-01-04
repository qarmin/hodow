// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingBufferDeviceAddressTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2018-2019 NVIDIA Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are pre-expanded by hodow_cts/scripts/gen_binding_model_bda.py into
// shaders/manifest/binding_model_buffer_device_address.toml and looked up by the case's parameters. Not ported: `op_access_chain`
// and `misc.multiple_access_chain`, which are hand-written SPIR-V assembly the shader pipeline has no way to assemble.

use std::ffi::{CString, c_char};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::binding_model_buffer_device_address::{ALL_BUFFER_ADDRESS_PROGRAMS, BDA_COPY_STRUCT};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const DIM: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Base {
    Ubo = 0,
    Ssbo = 1,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Compute = 0,
    Vertex = 1,
    Fragment = 2,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BufType {
    Single = 0,
    Multi = 1,
    Replay = 2,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Layout {
    Std140 = 0,
    Scalar = 1,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Convert {
    None = 0,
    Uint64 = 1,
    Uvec2 = 2,
    U64Cmp = 3,
    Uvec2Cmp = 4,
    Uvec2ToU64 = 5,
    U64ToUvec2 = 6,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum MemoryOffset {
    Zero,
    NonZero,
}

#[derive(Clone, Copy)]
struct CaseDef {
    set: u32,
    depth: u32,
    base: Base,
    stage: Stage,
    convert_u_to_ptr: Convert,
    store_in_local: bool,
    buf_type: BufType,
    layout: Layout,
    memory_offset: MemoryOffset,
}

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct BufferAddressPrograms {
    pub name: &'static str,
    pub set: u32,
    pub depth: u32,
    pub base: u32,
    pub stage: u32,
    pub convert: u32,
    pub store: bool,
    pub layout: u32,
    pub programs: BinaryCollection,
}

fn all_shader_stages() -> vk::ShaderStageFlags {
    vk::ShaderStageFlags::COMPUTE | vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT
}

/// `Context::isBufferDeviceAddressSupported`, `getBufferDeviceAddressFeatures` and the EXT twin, in one query.
struct BdaSupport {
    supported: bool,
    capture_replay: bool,
}

fn query_bda_support(context: &Context<'_>) -> BdaSupport {
    let mut khr_features = vk::PhysicalDeviceBufferDeviceAddressFeatures::default();
    let mut ext_features = vk::PhysicalDeviceBufferDeviceAddressFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder()
        .push_next(&mut khr_features)
        .push_next(&mut ext_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    let khr = context.is_device_functionality_supported("VK_KHR_buffer_device_address");
    let ext = context.is_device_functionality_supported("VK_EXT_buffer_device_address");
    BdaSupport {
        supported: (khr && khr_features.buffer_device_address != vk::FALSE)
            || (ext && ext_features.buffer_device_address != vk::FALSE),
        capture_replay: (khr && khr_features.buffer_device_address_capture_replay != vk::FALSE)
            || (ext && ext_features.buffer_device_address_capture_replay != vk::FALSE),
    }
}

/// A buffer with the memory it is bound to; the buffer goes first so it is destroyed before its memory is freed.
struct BdaBuffer<'d> {
    #[allow(dead_code)]
    buffer: Unique<'d, vk::Buffer>,
    alloc: Allocation<'d>,
}

/// What a buffer's `pNext` carries when it is created to replay a captured address.
#[derive(Clone, Copy)]
enum BufferChain {
    None,
    OpaqueCapture(u64),
    DeviceAddressExt(u64),
}

fn make_bda_buffer<'d>(
    device: &'d Device,
    size: vk::DeviceSize,
    create_flags: vk::BufferCreateFlags,
    chain: BufferChain,
) -> Result<Unique<'d, vk::Buffer>, TestError> {
    let mut opaque_info = vk::BufferOpaqueCaptureAddressCreateInfo::builder().opaque_capture_address(
        if let BufferChain::OpaqueCapture(a) = chain {
            a
        } else {
            0
        },
    );
    let mut ext_info = vk::BufferDeviceAddressCreateInfoEXT::builder().device_address(
        if let BufferChain::DeviceAddressExt(a) = chain {
            a
        } else {
            0
        },
    );
    let mut info = vk::BufferCreateInfo::builder()
        .size(size)
        .usage(
            vk::BufferUsageFlags::STORAGE_BUFFER
                | vk::BufferUsageFlags::UNIFORM_BUFFER
                | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        )
        .flags(create_flags)
        .sharing_mode(vk::SharingMode::EXCLUSIVE);
    match chain {
        BufferChain::None => {}
        BufferChain::OpaqueCapture(_) => info = info.push_next(&mut opaque_info),
        BufferChain::DeviceAddressExt(_) => info = info.push_next(&mut ext_info),
    }
    let buffer = unsafe { device.create_buffer(&info, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(device, buffer))
}

/// Allocates host visible memory for `buffer` (`offset_non_zero` makes the allocation one alignment larger and binds at that
/// offset), binds it, and returns the allocation with the offset the buffer was bound at.
fn allocate_and_bind<'d>(
    device: &'d Device,
    allocator: &SimpleAllocator,
    buffer: vk::Buffer,
    offset_non_zero: bool,
    alloc_flags: vk::MemoryAllocateFlags,
    opaque_memory_address: Option<u64>,
) -> Result<(Allocation<'d>, vk::DeviceSize), TestError> {
    let mut mem_req = unsafe { device.get_buffer_memory_requirements(buffer) };
    let mut memory_offset = 0;
    if offset_non_zero {
        memory_offset = mem_req.alignment;
        mem_req.size += memory_offset;
    }

    let alloc = allocator.allocate_with_flags(
        device,
        mem_req,
        MemoryRequirement::HOST_VISIBLE,
        alloc_flags,
        opaque_memory_address,
    )?;
    unsafe { device.bind_buffer_memory(buffer, alloc.get_memory(), memory_offset) }.vk_check("vkBindBufferMemory")?;
    Ok((alloc, memory_offset))
}

fn get_address(device: &Device, buffer: vk::Buffer) -> u64 {
    let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer);
    unsafe { device.get_buffer_device_address(&info) }
}

/// `createBufferDeviceAddressCaptureDevice`: a second device the buffers are first created on, with capture/replay enabled.
struct CaptureDevice {
    device: Device,
}

impl CaptureDevice {
    fn new(context: &Context<'_>) -> Result<Self, TestError> {
        // Any queue family will do for our purposes as we will only allocate memory and buffers on this device
        let queue_priority = [1.0f32];
        let queue_infos = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(0)
            .queue_priorities(&queue_priority)
            .build()];

        // Replicate default device extension list.
        let extension_names: Vec<CString> = context
            .get_device_extensions()
            .iter()
            .filter_map(|n| CString::new(n.as_str()).ok())
            .collect();
        let extension_ptrs: Vec<*const c_char> = extension_names.iter().map(|n| n.as_ptr()).collect();

        // Enable BDA and BDA capture/replay, and the test cases also rely on uniformBufferStandardLayout
        let mut bda_features = vk::PhysicalDeviceBufferDeviceAddressFeatures::builder()
            .buffer_device_address(true)
            .buffer_device_address_capture_replay(true);
        let mut uniform_buffer_standard_layout =
            vk::PhysicalDeviceUniformBufferStandardLayoutFeatures::builder().uniform_buffer_standard_layout(true);
        let info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&extension_ptrs)
            .push_next(&mut bda_features)
            .push_next(&mut uniform_buffer_standard_layout);

        let device = unsafe {
            context
                .get_instance()
                .create_device(context.get_physical_device(), &info, None)
        }
        .vk_check("vkCreateDevice")?;
        Ok(Self { device })
    }
}

impl Drop for CaptureDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

/// The flags every buffer's memory is allocated with: device address when the KHR extension is there, plus capture/replay.
fn memory_allocate_flags(use_khr: bool, replay: bool) -> vk::MemoryAllocateFlags {
    let mut flags = vk::MemoryAllocateFlags::empty();
    if use_khr {
        flags |= vk::MemoryAllocateFlags::DEVICE_ADDRESS;
        if replay {
            flags |= vk::MemoryAllocateFlags::DEVICE_ADDRESS_CAPTURE_REPLAY;
        }
    }
    flags
}

/// What the capture phase of a replay learns about the buffers it created.
struct CapturedAddresses {
    gpu_addrs: Vec<u64>,
    opaque_buffer_addrs: Vec<u64>,
    opaque_memory_addrs: Vec<u64>,
}

/// Creates `sizes.len()` buffers on a separate capture device and records their addresses; the device and the buffers are gone when
/// this returns, which is what frees the addresses for the replay.
fn capture_addresses(
    context: &Context<'_>,
    sizes: &[vk::DeviceSize],
    use_khr: bool,
) -> Result<CapturedAddresses, TestError> {
    let capture_device = CaptureDevice::new(context)?;
    let device = &capture_device.device;
    let memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    let allocator = SimpleAllocator::new(memory_properties);
    let alloc_flags = memory_allocate_flags(use_khr, true);

    let mut captured = CapturedAddresses {
        gpu_addrs: vec![0; sizes.len()],
        opaque_buffer_addrs: vec![0; sizes.len()],
        opaque_memory_addrs: vec![0; sizes.len()],
    };
    let mut buffers = Vec::new();

    for (i, &size) in sizes.iter().enumerate() {
        let buffer = make_bda_buffer(
            device,
            size,
            vk::BufferCreateFlags::DEVICE_ADDRESS_CAPTURE_REPLAY,
            BufferChain::None,
        )?;

        // query opaque capture address before binding memory
        if use_khr {
            let info = vk::BufferDeviceAddressInfo::builder().buffer(*buffer);
            captured.opaque_buffer_addrs[i] = unsafe { device.get_buffer_opaque_capture_address(&info) };
        }

        let (alloc, _) = allocate_and_bind(device, &allocator, *buffer, false, alloc_flags, None)?;

        if use_khr {
            let info = vk::DeviceMemoryOpaqueCaptureAddressInfo::builder().memory(alloc.get_memory());
            captured.opaque_memory_addrs[i] = unsafe { device.get_device_memory_opaque_capture_address(&info) };
        }

        buffers.push(BdaBuffer { buffer, alloc });
    }

    for (i, buffer) in buffers.iter().enumerate() {
        captured.gpu_addrs[i] = get_address(device, *buffer.buffer);
    }

    Ok(captured)
}

/// Recreates the captured buffers on the default device, last to first, and checks each comes back at its captured address.
/// `None` when they do; the failing verdict otherwise.
fn replay_buffers<'d>(
    device: &'d Device,
    allocator: &SimpleAllocator,
    sizes: &[vk::DeviceSize],
    captured: &CapturedAddresses,
    use_khr: bool,
    buffers: &mut [Option<BdaBuffer<'d>>],
) -> Result<Option<TestStatus>, TestError> {
    let alloc_flags = memory_allocate_flags(use_khr, true);

    for i in (0..sizes.len()).rev() {
        let chain = if use_khr {
            BufferChain::OpaqueCapture(captured.opaque_buffer_addrs[i])
        } else {
            BufferChain::DeviceAddressExt(captured.gpu_addrs[i])
        };
        let buffer = make_bda_buffer(
            device,
            sizes[i],
            vk::BufferCreateFlags::DEVICE_ADDRESS_CAPTURE_REPLAY,
            chain,
        )?;
        let (alloc, _) = allocate_and_bind(
            device,
            allocator,
            *buffer,
            false,
            alloc_flags,
            if use_khr {
                Some(captured.opaque_memory_addrs[i])
            } else {
                None
            },
        )?;

        let new_addr = get_address(device, *buffer);
        buffers[i] = Some(BdaBuffer { buffer, alloc });

        if new_addr != captured.gpu_addrs[i] {
            return Ok(Some(TestStatus::fail("address mismatch")));
        }
    }
    Ok(None)
}

/// `BufferAddressTestInstance::fillBuffer`
fn fill_buffer(data: &CaseDef, cpu_addrs: &[*mut u8], gpu_addrs: &[u64], buf_num: u32, cur_depth: u32) {
    let buf = cpu_addrs[buf_num as usize];
    let scalar = data.layout == Layout::Scalar;

    let a_stride = if scalar { 1 } else { 4 }; // (in uint32_ts)
    let c_stride = if scalar { 1 } else { 2 }; // (in uint64_ts)
    let mat_stride = if scalar { 2 } else { 4 }; // (in floats)

    unsafe {
        // a
        buf.cast::<u32>().write_unaligned(buf_num * 3);
        buf.cast::<u32>().add(a_stride).write_unaligned(buf_num * 3 + 1);
        // b
        buf.add(32).cast::<u32>().write_unaligned(buf_num * 3 + 2);
        if scalar {
            // f
            let f = buf.add(36).cast::<u32>();
            f.write_unaligned(buf_num * 3 + 7);
            f.add(1).write_unaligned(buf_num * 3 + 8);
            f.add(2).write_unaligned(buf_num * 3 + 9);
        }
        // e
        let e = buf.add(96).cast::<f32>();
        e.write_unaligned((buf_num * 3 + 3) as f32);
        e.add(1).write_unaligned((buf_num * 3 + 4) as f32);
        e.add(mat_stride).write_unaligned((buf_num * 3 + 5) as f32);
        e.add(mat_stride + 1).write_unaligned((buf_num * 3 + 6) as f32);

        let c = buf.add(48).cast::<u64>();
        let d = buf.add(80).cast::<u64>();
        if cur_depth != data.depth {
            // c
            c.write_unaligned(gpu_addrs[(buf_num * 3 + 1) as usize]);
            c.add(c_stride).write_unaligned(gpu_addrs[(buf_num * 3 + 2) as usize]);
            // d
            d.write_unaligned(gpu_addrs[(buf_num * 3 + 3) as usize]);
        } else {
            // c
            c.write_unaligned(0);
            c.add(c_stride).write_unaligned(0);
            // d
            d.write_unaligned(0);
        }
    }

    if cur_depth != data.depth {
        fill_buffer(data, cpu_addrs, gpu_addrs, buf_num * 3 + 1, cur_depth + 1);
        fill_buffer(data, cpu_addrs, gpu_addrs, buf_num * 3 + 2, cur_depth + 1);
        fill_buffer(data, cpu_addrs, gpu_addrs, buf_num * 3 + 3, cur_depth + 1);
    }
}

struct BufferAddressTestCase {
    name: String,
    data: CaseDef,
}

impl TestCase for BufferAddressTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let data = &self.data;
        let bda = query_bda_support(context);
        if !bda.supported {
            return Err(TestError::NotSupported(
                "Physical storage buffer pointers not supported".to_string(),
            ));
        }

        if data.stage == Stage::Vertex && context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Vertex pipeline stores and atomics not supported".to_string(),
            ));
        }

        if data.set >= context.get_device_properties().limits.max_bound_descriptor_sets {
            return Err(TestError::NotSupported(
                "descriptor set number not supported".to_string(),
            ));
        }

        if data.buf_type == BufType::Replay && !bda.capture_replay {
            return Err(TestError::NotSupported(
                "Capture/replay of physical storage buffer pointers not supported".to_string(),
            ));
        }

        if data.layout == Layout::Scalar {
            let mut scalar_block_layout = vk::PhysicalDeviceScalarBlockLayoutFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut scalar_block_layout);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if scalar_block_layout.scalar_block_layout == vk::FALSE {
                return Err(TestError::NotSupported("Scalar block layout not supported".to_string()));
            }
        }

        let needs_int64 = matches!(
            data.convert_u_to_ptr,
            Convert::Uint64 | Convert::U64Cmp | Convert::U64ToUvec2 | Convert::Uvec2ToU64
        );
        let needs_khr = matches!(
            data.convert_u_to_ptr,
            Convert::Uvec2 | Convert::Uvec2Cmp | Convert::U64ToUvec2 | Convert::Uvec2ToU64
        );

        if needs_int64 && context.get_device_features().shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported("Int64 not supported".to_string()));
        }
        if needs_khr && !context.is_device_functionality_supported("VK_KHR_buffer_device_address") {
            return Err(TestError::NotSupported(
                "VK_KHR_buffer_device_address not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let data = &self.data;
        ALL_BUFFER_ADDRESS_PROGRAMS
            .iter()
            .find(|p| {
                p.set == data.set
                    && p.depth == data.depth
                    && p.base == data.base as u32
                    && p.stage == data.stage as u32
                    && p.convert == data.convert_u_to_ptr as u32
                    && p.store == data.store_in_local
                    && p.layout == data.layout as u32
            })
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferAddressTestInstance {
            context,
            data: self.data,
        })
    }
}

struct BufferAddressTestInstance<'a> {
    context: &'a Context<'a>,
    data: CaseDef,
}

impl BufferAddressTestInstance<'_> {
    /// `BufferAddressTestInstance::queuePass`
    fn queue_pass(&self, queue: vk::Queue, family_index: u32) -> TestOutcome {
        let context = self.context;
        let data = &self.data;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let use_khr = context.is_device_functionality_supported("VK_KHR_buffer_device_address");

        let shader_stages = all_shader_stages();
        let all_pipeline_stages = vk::PipelineStageFlags::COMPUTE_SHADER
            | vk::PipelineStageFlags::VERTEX_SHADER
            | vk::PipelineStageFlags::FRAGMENT_SHADER;
        let barrier_pipeline_stages = if data.stage == Stage::Compute {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            all_pipeline_stages
        };

        let limits = &context.get_device_properties().limits;

        let bind_point = if data.stage == Stage::Compute {
            vk::PipelineBindPoint::COMPUTE
        } else {
            vk::PipelineBindPoint::GRAPHICS
        };

        let base_descriptor_type = if data.base == Base::Ubo {
            vk::DescriptorType::UNIFORM_BUFFER
        } else {
            vk::DescriptorType::STORAGE_BUFFER
        };

        // Create a layout and allocate a descriptor set for it.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, shader_stages)
            .add_single_binding(base_descriptor_type, shader_stages)
            .build(device)?;
        let empty_descriptor_set_layout = DescriptorSetLayoutBuilder::new().build(device)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(base_descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let align = limits
            .min_uniform_buffer_offset_alignment
            .max(limits.min_storage_buffer_offset_alignment)
            .max(128 /*sizeof(T1)*/);

        let mut num_bindings = 1u32;
        for _d in 0..data.depth {
            num_bindings = num_bindings * 3 + 1;
        }

        let multi_buffer = data.buf_type != BufType::Single;
        let offset_non_zero = data.memory_offset == MemoryOffset::NonZero;
        let num_buffers = if multi_buffer { num_bindings } else { 1 };
        let buffer_size = if multi_buffer {
            align
        } else {
            align * num_bindings as vk::DeviceSize
        };
        let mut memory_offset: vk::DeviceSize = 0;

        let mut buffers: Vec<Option<BdaBuffer<'_>>> = (0..num_buffers).map(|_| None).collect();

        // If this is a capture/replay test, then we have to allocate the buffer and memory objects on another device and then try to
        // recreate them on the default device with the captured addresses
        if data.buf_type == BufType::Replay {
            let sizes = vec![buffer_size; num_buffers as usize];
            let captured = capture_addresses(context, &sizes, use_khr)?;
            if let Some(failure) = replay_buffers(device, allocator, &sizes, &captured, use_khr, &mut buffers)? {
                return Ok(failure);
            }
        } else {
            let alloc_flags = memory_allocate_flags(use_khr, false);
            for slot in buffers.iter_mut() {
                let buffer = make_bda_buffer(device, buffer_size, vk::BufferCreateFlags::empty(), BufferChain::None)?;
                let (alloc, offset) =
                    allocate_and_bind(device, allocator, *buffer, offset_non_zero, alloc_flags, None)?;
                memory_offset = offset;
                *slot = Some(BdaBuffer { buffer, alloc });
            }
        }

        // Create a buffer and compute the address for each "align" bytes.
        let mut cpu_addrs: Vec<*mut u8> = Vec::with_capacity(num_bindings as usize);
        let mut gpu_addrs: Vec<u64> = Vec::with_capacity(num_bindings as usize);
        for i in 0..num_bindings {
            let slot = if multi_buffer { i as usize } else { 0 };
            let bda_buffer = buffers[slot]
                .as_ref()
                .ok_or_else(|| TestError::InternalError("buffer missing".to_string()))?;
            let mut gpu_addr = get_address(device, *bda_buffer.buffer);
            let mut cpu_addr = unsafe { bda_buffer.alloc.get_host_ptr().add(memory_offset as usize) };
            if !multi_buffer {
                cpu_addr = unsafe { cpu_addr.add((align * i as vk::DeviceSize) as usize) };
                gpu_addr += align * i as vk::DeviceSize;
            }
            cpu_addrs.push(cpu_addr);
            gpu_addrs.push(gpu_addr);
        }

        fill_buffer(data, &cpu_addrs, &gpu_addrs, 0, 0);

        for bda_buffer in buffers.iter().flatten() {
            flush_alloc(device, &bda_buffer.alloc)?;
        }

        let cmd_pool = {
            let info = vk::CommandPoolCreateInfo::builder().queue_family_index(family_index);
            Unique::new(
                device,
                unsafe { device.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?,
            )
        };
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_ptr.get();

        begin_command_buffer(device, cmd_buffer)?;

        // Push constants are used for dynamic indexing. PushConstant[i] = i.
        let push_const_range = vk::PushConstantRange {
            stage_flags: shader_stages,
            offset: 0,
            size: 128,
        };

        let mut non_empty_set_limit = if data.base == Base::Ubo {
            limits.max_per_stage_descriptor_uniform_buffers
        } else {
            limits.max_per_stage_descriptor_storage_buffers
        };
        non_empty_set_limit = non_empty_set_limit.min(limits.max_per_stage_descriptor_storage_images);

        let descriptor_set_layouts_raw: Vec<vk::DescriptorSetLayout> = (0..=data.set)
            .map(|i| {
                // use nonempty descriptor sets to consume resources until we run out of descriptors
                if i < non_empty_set_limit.saturating_sub(1) || i == data.set {
                    *descriptor_set_layout
                } else {
                    *empty_descriptor_set_layout
                }
            })
            .collect();

        let push_const_ranges = [push_const_range];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&descriptor_set_layouts_raw)
            .push_constant_ranges(&push_const_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // PushConstant[i] = i
        for i in 0..(128 / std::mem::size_of::<u32>()) as u32 {
            unsafe {
                device.cmd_push_constants(
                    cmd_buffer,
                    *pipeline_layout,
                    shader_stages,
                    i * std::mem::size_of::<u32>() as u32,
                    &i.to_ne_bytes(),
                )
            };
        }

        let copy_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (DIM * DIM) as vk::DeviceSize * std::mem::size_of::<u32>() as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let image_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(vk::Format::R32_UINT)
            .extent(vk::Extent3D {
                width: DIM,
                height: DIM,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, allocator, image_create_info, MemoryRequirement::ANY)?;
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D, vk::Format::R32_UINT, range)?;

        let image_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view,
            image_layout: vk::ImageLayout::GENERAL,
        };
        let first_buffer = buffers[0]
            .as_ref()
            .ok_or_else(|| TestError::InternalError("buffer missing".to_string()))?;
        let buffer_info = make_descriptor_buffer_info(*first_buffer.buffer, 0, align);

        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(std::slice::from_ref(&image_info))
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(base_descriptor_type)
                .buffer_info(std::slice::from_ref(&buffer_info))
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                data.set,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        let binaries = context.get_binary_collection();
        let render_pass;
        let framebuffer;
        let pipeline;

        if data.stage == Stage::Compute {
            let shader = create_shader_module(device, binaries.get("test")?)?;
            let stage_info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*shader)
                .name(b"main\0")
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage_info)
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .build();
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            pipeline = Unique::new(device, pipelines.0[0]);
            render_pass = None;
            framebuffer = None;
        } else {
            let subpass_desc = vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .build();
            let subpasses = [subpass_desc];
            let render_pass_params = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
            let pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_params, None) }.vk_check("vkCreateRenderPass")?,
            );

            let framebuffer_params = vk::FramebufferCreateInfo::builder()
                .render_pass(*pass)
                .width(DIM)
                .height(DIM)
                .layers(1);
            let fb = Unique::new(
                device,
                unsafe { device.create_framebuffer(&framebuffer_params, None) }.vk_check("vkCreateFramebuffer")?,
            );

            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(if data.stage == Stage::Vertex {
                    vk::PrimitiveTopology::POINT_LIST
                } else {
                    vk::PrimitiveTopology::TRIANGLE_STRIP
                })
                .primitive_restart_enable(false);
            let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
                .depth_clamp_enable(false)
                .rasterizer_discard_enable(data.stage == Stage::Vertex)
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::CLOCKWISE)
                .depth_bias_enable(false)
                .line_width(1.0);
            let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
                .rasterization_samples(vk::SampleCountFlags::_1)
                .sample_shading_enable(false)
                .min_sample_shading(1.0);
            let viewports = [vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: DIM as f32,
                height: DIM as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            }];
            let scissors = [make_rect_2d(0, 0, DIM, DIM)];
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);

            let (vs, fs, num_stages) = if data.stage == Stage::Vertex {
                // the fragment module is bogus, as upstream's
                (
                    create_shader_module(device, binaries.get("test")?)?,
                    create_shader_module(device, binaries.get("test")?)?,
                    1usize,
                )
            } else {
                (
                    create_shader_module(device, binaries.get("vert")?)?,
                    create_shader_module(device, binaries.get("test")?)?,
                    2usize,
                )
            };
            let shader_create_info = [
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*vs)
                    .name(b"main\0")
                    .build(),
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(*fs)
                    .name(b"main\0")
                    .build(),
            ];

            let graphics_pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&shader_create_info[..num_stages])
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .multisample_state(&multisample_state)
                .layout(*pipeline_layout)
                .render_pass(*pass)
                .subpass(0)
                .base_pipeline_index(0);
            let pipelines =
                unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[graphics_pipeline_info], None) }
                    .vk_check("vkCreateGraphicsPipelines")?;
            pipeline = Unique::new(device, pipelines.0[0]);
            render_pass = Some(pass);
            framebuffer = Some(fb);
        }

        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );

            device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);

            let clear_color = vk::ClearColorValue { uint32: [0, 0, 0, 0] };
            device.cmd_clear_color_image(
                cmd_buffer,
                image.get(),
                vk::ImageLayout::GENERAL,
                &clear_color,
                &[range],
            );

            let mem_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE)
                .build();
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                barrier_pipeline_stages,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        if data.stage == Stage::Compute {
            unsafe { device.cmd_dispatch(cmd_buffer, DIM, DIM, 1) };
        } else {
            let (Some(pass), Some(fb)) = (render_pass.as_ref(), framebuffer.as_ref()) else {
                return Err(TestError::InternalError(
                    "render pass or framebuffer missing".to_string(),
                ));
            };
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**pass)
                .framebuffer(**fb)
                .render_area(make_rect_2d(0, 0, DIM, DIM));
            unsafe {
                device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
                // Draw a point cloud for vertex shader testing, and a single quad for fragment shader testing
                if data.stage == Stage::Vertex {
                    device.cmd_draw(cmd_buffer, DIM * DIM, 1, 0, 0);
                } else {
                    device.cmd_draw(cmd_buffer, 4, 1, 0, 0);
                }
                device.cmd_end_render_pass(cmd_buffer);
            }
        }

        let mem_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE)
            .build();
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: DIM,
                height: DIM,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                barrier_pipeline_stages,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            device.cmd_copy_image_to_buffer(
                cmd_buffer,
                image.get(),
                vk::ImageLayout::GENERAL,
                copy_buffer.get(),
                &[copy_region],
            );
        }

        end_command_buffer(device, cmd_buffer)?;

        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let copy_alloc = copy_buffer.get_allocation();
        invalidate_alloc(device, copy_alloc)?;
        let results =
            unsafe { std::slice::from_raw_parts(copy_alloc.get_host_ptr().cast::<u32>(), (DIM * DIM) as usize) };

        if results.iter().any(|&r| r != 1) {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `MultiQueueRunnerTestInstance(context, data.stage == STAGE_COMPUTE ? COMPUTE_QUEUE : GRAPHICS_QUEUE)`
    fn queues(&self) -> Vec<(vk::Queue, u32)> {
        let mut queues = vec![(
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )];
        if self.data.stage == Stage::Compute
            && let Some((queue, family)) = self.context.get_compute_queue()
            && family != self.context.get_universal_queue_family_index()
        {
            queues.push((queue, family));
        }
        queues
    }
}

impl TestInstance for BufferAddressTestInstance<'_> {
    /// `MultiQueueRunnerTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        for (queue, family_index) in self.queues() {
            let status = self.queue_pass(queue, family_index)?;
            if status.is_fail() {
                return Ok(status);
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// capture_replay_stress
// ---------------------------------------------------------------------------------

struct CaptureReplayTestCase {
    name: String,
    seed: u32,
}

impl TestCase for CaptureReplayTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let bda = query_bda_support(context);
        if !bda.supported {
            return Err(TestError::NotSupported(
                "Physical storage buffer pointers not supported".to_string(),
            ));
        }
        if !bda.capture_replay {
            return Err(TestError::NotSupported(
                "Capture/replay of physical storage buffer pointers not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CaptureReplayTestInstance {
            context,
            seed: self.seed,
        })
    }
}

struct CaptureReplayTestInstance<'a> {
    context: &'a Context<'a>,
    seed: u32,
}

impl TestInstance for CaptureReplayTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let use_khr = context.is_device_functionality_supported("VK_KHR_buffer_device_address");
        let mut rng = Random::new(self.seed);

        const NUM_BUFFERS: usize = 100;
        // random sizes, powers of two [4K, 4MB]
        let buffer_sizes: Vec<vk::DeviceSize> = (0..NUM_BUFFERS).map(|_| 4096u64 << (rng.get_uint32() % 11)).collect();

        // Use a separate device for the capture than the replay
        let captured = capture_addresses(context, &buffer_sizes, use_khr)?;

        let mut buffers: Vec<Option<BdaBuffer<'_>>> = (0..NUM_BUFFERS).map(|_| None).collect();
        if let Some(failure) = replay_buffers(
            device,
            context.get_default_allocator(),
            &buffer_sizes,
            &captured,
            use_khr,
            &mut buffers,
        )? {
            return Ok(failure);
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// misc.copy_struct
// ---------------------------------------------------------------------------------

struct CopyStructTestCase;

impl TestCase for CopyStructTestCase {
    fn name(&self) -> &str {
        "copy_struct"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_buffer_device_address")
    }

    fn programs(&self) -> BinaryCollection {
        BDA_COPY_STRUCT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyStructTestInstance { context })
    }
}

struct CopyStructTestInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for CopyStructTestInstance<'_> {
    /// `BufferDeviceAddressMiscTestInstance::iterate` for `COPY_STRUCT`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_ptr.get();

        let buffer_size = (std::mem::size_of::<u32>() * 17) as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                buffer_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            ),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )?;

        let descriptor_type = vk::DescriptorType::STORAGE_BUFFER;

        let storage_buffer_size = 16 as vk::DeviceSize;
        let storage_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                storage_buffer_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::UNIFORM_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let address = get_address(device, buffer.get());

        {
            let storage_buffer_ptr = storage_buffer.get_allocation().get_host_ptr();
            unsafe {
                std::ptr::write_bytes(storage_buffer_ptr, 0, storage_buffer_size as usize);
                storage_buffer_ptr
                    .add(std::mem::size_of::<u32>() * 2)
                    .cast::<u64>()
                    .write_unaligned(address);

                // COPY_STRUCT stores the address at offset 8 again
                storage_buffer_ptr
                    .add(std::mem::size_of::<u32>() * 2)
                    .cast::<u64>()
                    .write_unaligned(address);
            }
            flush_alloc(device, storage_buffer.get_allocation())?;
        }

        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;

        let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let stage_info = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage_info)
            .layout(*pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_info = make_descriptor_buffer_info(storage_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                descriptor_type,
                &buffer_info,
            )
            .update(device);

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd_buffer, 1, 1, 1);
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;

        invalidate_alloc(device, buffer.get_allocation())?;

        let result = unsafe { buffer.get_allocation().get_host_ptr().cast::<i32>().read_unaligned() };
        let expected_value = 2;
        if result != expected_value {
            return Err(TestError::Fail("Unexpected result".to_string()));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// the group
// ---------------------------------------------------------------------------------

/// `createBufferDeviceAddressTests`
pub fn create_buffer_device_address_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer_device_address");

    let set_cases = [(0u32, "set0"), (3, "set3"), (7, "set7"), (15, "set15"), (31, "set31")];
    let depth_cases = [(1u32, "depth1"), (2, "depth2"), (3, "depth3")];
    let base_cases = [(Base::Ubo, "baseubo"), (Base::Ssbo, "basessbo")];
    let cvt_cases = [
        // load reference
        (Convert::None, "load"),
        // load and convert reference
        (Convert::Uint64, "convert"),
        // load and convert reference to uvec2
        (Convert::Uvec2, "convertuvec2"),
        // load, convert and compare references as uint64_t
        (Convert::U64Cmp, "convertchecku64"),
        // load, convert and compare references as uvec2
        (Convert::Uvec2Cmp, "convertcheckuv2"),
        // load reference as uint64_t and convert it to uvec2
        (Convert::Uvec2ToU64, "crossconvertu2p"),
        // load reference as uvec2 and convert it to uint64_t
        (Convert::U64ToUvec2, "crossconvertp2u"),
    ];
    let store_cases = [
        // don't store intermediate reference
        (false, "nostore"),
        // store intermediate reference
        (true, "store"),
    ];
    let bt_cases = [
        // single buffer
        (BufType::Single, "single"),
        // multiple buffers
        (BufType::Multi, "multi"),
        // multiple buffers and VK_BUFFER_CREATE_DEVICE_ADDRESS_CAPTURE_REPLAY_BIT_EXT
        (BufType::Replay, "replay"),
    ];
    let layout_cases = [(Layout::Std140, "std140"), (Layout::Scalar, "scalar")];
    let stage_cases = [
        (Stage::Compute, "comp"),
        (Stage::Fragment, "frag"),
        (Stage::Vertex, "vert"),
    ];
    let offset_cases = [
        (MemoryOffset::Zero, "offset_zero"),
        (MemoryOffset::NonZero, "offset_nonzero"),
    ];

    for (set, set_name) in set_cases {
        let mut set_group = TestCaseGroup::new(set_name);
        for (depth, depth_name) in depth_cases {
            let mut depth_group = TestCaseGroup::new(depth_name);
            for (base, base_name) in base_cases {
                let mut base_group = TestCaseGroup::new(base_name);
                for (convert_u_to_ptr, cvt_name) in cvt_cases {
                    let mut cvt_group = TestCaseGroup::new(cvt_name);
                    for (store_in_local, store_name) in store_cases {
                        let mut store_group = TestCaseGroup::new(store_name);
                        for (buf_type, bt_name) in bt_cases {
                            let mut bt_group = TestCaseGroup::new(bt_name);
                            for (layout, layout_name) in layout_cases {
                                let mut layout_group = TestCaseGroup::new(layout_name);
                                for (stage, stage_name) in stage_cases {
                                    for (memory_offset, _offset_name) in offset_cases {
                                        let c = CaseDef {
                                            set,
                                            depth,
                                            base,
                                            stage,
                                            convert_u_to_ptr,
                                            store_in_local,
                                            buf_type,
                                            layout,
                                            memory_offset,
                                        };

                                        // Skip more complex test cases for most descriptor sets, to reduce runtime.
                                        if c.set != 3 && (c.depth == 3 || c.layout != Layout::Std140) {
                                            continue;
                                        }

                                        // Memory offset tests are only for single buffer test cases.
                                        if c.memory_offset == MemoryOffset::NonZero && c.buf_type != BufType::Single {
                                            continue;
                                        }

                                        let mut case_name = stage_name.to_string();
                                        if c.memory_offset == MemoryOffset::NonZero {
                                            case_name += "_offset_nonzero";
                                        }

                                        layout_group.add_child(Box::new(BufferAddressTestCase {
                                            name: case_name,
                                            data: c,
                                        })
                                            as Box<dyn TestCase>);
                                    }
                                }
                                bt_group.add_child(layout_group);
                            }
                            store_group.add_child(bt_group);
                        }
                        cvt_group.add_child(store_group);
                    }
                    base_group.add_child(cvt_group);
                }
                depth_group.add_child(base_group);
            }
            set_group.add_child(depth_group);
        }
        group.add_child(set_group);
    }

    let mut cap_group = TestCaseGroup::new("capture_replay_stress");
    for i in 0..10u32 {
        cap_group.add_child(Box::new(CaptureReplayTestCase {
            name: format!("seed_{i}"),
            seed: i,
        }) as Box<dyn TestCase>);
    }
    group.add_child(cap_group);

    let mut misc_group = TestCaseGroup::new("misc");
    misc_group.add_child(Box::new(CopyStructTestCase) as Box<dyn TestCase>);
    group.add_child(misc_group);

    group
}
