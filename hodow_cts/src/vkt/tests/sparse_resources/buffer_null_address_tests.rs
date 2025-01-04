// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferTests.cpp (NullAddressCase, NullAddressInstance, the `misc` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device address and descriptor set access types are ported (the shaders are
// `shaders/manifest/sparse_resources_null_address.toml`, written by scripts/gen_sparse_null_address_manifest.py); the descriptor heap ones
// (VK_EXT_descriptor_heap) are registered and report NotPorted. The device is the sparse device of `base.rs`, whose compute queue runs the work.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use super::base::{QueueRequirements, SparseDevice};
use super::null_address_programs::programs_for;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum ResourceAccessType {
    DeviceAddress,
    DescriptorSet,
    DescriptorHeap,
}

/// `NullAddressInstance::Params`
#[derive(Clone, Copy)]
struct Params {
    /// Storage buffer, uniform buffer, or storage/uniform texel buffer.
    descriptor_type: vk::DescriptorType,
    /// Device addresses with push constants, classic sets or heaps.
    access_type: ResourceAccessType,
    /// This may affect the implementation/compiler.
    use_local_invocation_index: bool,
    /// Do an initial map, and unmap later.
    map_first: bool,
    /// Check writes. If false, check reads.
    write: bool,
    /// Run the test in capture-replay mode for the sparse buffer.
    capture_replay: bool,
}

impl Params {
    fn value_count(&self) -> u32 {
        64
    }

    fn work_group_count(&self) -> u32 {
        if self.use_local_invocation_index {
            1
        } else {
            self.value_count()
        }
    }

    fn src_buffer_desc_type(&self) -> vk::DescriptorType {
        if self.write {
            vk::DescriptorType::STORAGE_BUFFER
        } else {
            self.descriptor_type
        }
    }

    fn dst_buffer_desc_type(&self) -> vk::DescriptorType {
        if self.write {
            self.descriptor_type
        } else {
            vk::DescriptorType::STORAGE_BUFFER
        }
    }

    /// The name of the manifest case, `key_name` in the generator
    fn program_name(&self) -> String {
        let desc_type = match self.descriptor_type {
            vk::DescriptorType::UNIFORM_BUFFER => "uniform_buffer",
            vk::DescriptorType::STORAGE_TEXEL_BUFFER => "storage_texel_buffer",
            vk::DescriptorType::UNIFORM_TEXEL_BUFFER => "uniform_texel_buffer",
            _ => "storage_buffer",
        };
        format!(
            "{desc_type}_{}_{}_{}",
            if self.access_type == ResourceAccessType::DeviceAddress {
                "address"
            } else {
                "set"
            },
            if self.use_local_invocation_index {
                "local"
            } else {
                "group"
            },
            if self.write { "write" } else { "read" }
        )
    }
}

struct NullAddressCase {
    name: String,
    params: Params,
}

impl TestCase for NullAddressCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `NullAddressCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let p = &self.params;
        let features = context.get_device_features();
        if features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseBinding not supported".to_string(),
            ));
        }
        if features.sparse_residency_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseResidencyBuffer not supported".to_string(),
            ));
        }

        match p.access_type {
            ResourceAccessType::DeviceAddress => {
                context.require_device_functionality("VK_KHR_buffer_device_address")?
            }
            ResourceAccessType::DescriptorHeap => context.require_device_functionality("VK_EXT_descriptor_heap")?,
            ResourceAccessType::DescriptorSet => {}
        }

        if p.capture_replay {
            let mut bda_features = vk::PhysicalDeviceBufferDeviceAddressFeatures::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut bda_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if bda_features.buffer_device_address_capture_replay == vk::FALSE {
                return Err(TestError::NotSupported(
                    "bufferDeviceAddressCaptureReplay not supported".to_string(),
                ));
            }
        }

        if context
            .get_device_properties()
            .sparse_properties
            .residency_non_resident_strict
            == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "residencyNonResidentStrict not supported".to_string(),
            ));
        }

        if p.descriptor_type == vk::DescriptorType::UNIFORM_BUFFER {
            context.require_device_functionality("VK_KHR_uniform_buffer_standard_layout")?;
        }

        if p.access_type == ResourceAccessType::DescriptorHeap {
            return Err(TestError::NotPorted("the descriptor heap access type".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.access_type == ResourceAccessType::DescriptorHeap {
            return BinaryCollection::new(&[]);
        }
        programs_for(&self.params.program_name()).unwrap_or_else(|| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NullAddressInstance {
            context,
            params: self.params,
        })
    }

    fn is_stub(&self) -> bool {
        self.params.access_type == ResourceAccessType::DescriptorHeap
    }
}

struct NullAddressInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

#[derive(Default)]
struct ReplayParams {
    /// If false, the addresses are going to be captured here.
    have_params: bool,
    buffer_opaque_address: u64,
    memory_opaque_address: u64,
    buffer_device_address: u64,
}

impl TestInstance for NullAddressInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let mut replay_params = ReplayParams::default();
        let first_status = run_test(self.context, &self.params, &mut replay_params)?;
        if !self.params.capture_replay || first_status.code() != crate::tcu::defs::TestResult::Pass {
            return Ok(first_status);
        }

        // There is capture replay and the first run passed.
        replay_params.have_params = true;
        run_test(self.context, &self.params, &mut replay_params)
    }
}

fn buffer_device_address(device: &Device, buffer: vk::Buffer) -> u64 {
    let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer);
    unsafe { device.get_buffer_device_address(&info) }
}

fn write_values(device: &Device, buffer: &BufferWithMemory<'_>, values: &[u32]) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            values.as_ptr().cast::<u8>(),
            alloc.get_host_ptr(),
            std::mem::size_of_val(values),
        )
    };
    flush_alloc(device, alloc)
}

fn read_values(device: &Device, alloc: &crate::vk::mem_util::Allocation<'_>, out: &mut [u32]) -> Result<(), TestError> {
    invalidate_alloc(device, alloc)?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            alloc.get_host_ptr().cast_const(),
            out.as_mut_ptr().cast::<u8>(),
            std::mem::size_of_val(out),
        )
    };
    Ok(())
}

/// `checkValuesMatch`
fn check_values_match(error_prefix: &str, result: &[u32], reference: &[u32]) -> bool {
    let mut matches = true;
    for (i, (&res, &expected)) in result.iter().zip(reference).enumerate() {
        if res != expected {
            log::info!("{error_prefix} Value mismatch at position {i}: expected {expected} but found {res}");
            matches = false;
        }
    }
    matches
}

fn make_buffer_view<'a>(
    device: &'a Device,
    buffer: vk::Buffer,
    size: vk::DeviceSize,
) -> Result<Unique<'a, vk::BufferView>, TestError> {
    let info = vk::BufferViewCreateInfo::builder()
        .buffer(buffer)
        .format(vk::Format::R32_UINT)
        .offset(0)
        .range(size);
    Ok(Unique::new(
        device,
        unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?,
    ))
}

fn is_texel_buffer(descriptor_type: vk::DescriptorType) -> bool {
    descriptor_type == vk::DescriptorType::UNIFORM_TEXEL_BUFFER
        || descriptor_type == vk::DescriptorType::STORAGE_TEXEL_BUFFER
}

fn write_buffer_descriptor(
    device: &Device,
    set: vk::DescriptorSet,
    binding: u32,
    descriptor_type: vk::DescriptorType,
    buffer: vk::Buffer,
    view: vk::BufferView,
) {
    let buffer_info = vk::DescriptorBufferInfo {
        buffer,
        offset: 0,
        range: vk::WHOLE_SIZE,
    };
    let texel = is_texel_buffer(descriptor_type);
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type,
        image_info: std::ptr::null(),
        buffer_info: if texel { std::ptr::null() } else { &buffer_info },
        texel_buffer_view: if texel { &view } else { std::ptr::null() },
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

/// `NullAddressInstance::runTest`
fn run_test(context: &Context<'_>, p: &Params, replay_params: &mut ReplayParams) -> TestOutcome {
    // Decide first if we capture, replay or none.
    let capture = p.capture_replay && !replay_params.have_params;
    let replay = p.capture_replay && replay_params.have_params;

    let sparse_device = SparseDevice::new(
        context,
        &[
            QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
            QueueRequirements::new(vk::QueueFlags::COMPUTE, 1),
        ],
        false,
    )?;
    let device = sparse_device.device();
    let allocator = sparse_device.allocator();
    let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
    let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);

    let value_count = p.value_count() as usize;

    // Staging contents.
    let zero_values = vec![0u32; value_count];
    let non_zero_values = vec![0xF0F0_F0F0u32; value_count];
    let alt_non_zero_values = vec![0xFFFF_FFFFu32; value_count];
    let buffer_size = (value_count * 4) as vk::DeviceSize;

    // Regular buffer data will be copied to or from.
    let extra_usage_flag = if p.access_type != ResourceAccessType::DescriptorSet {
        vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
    } else {
        vk::BufferUsageFlags::empty()
    };

    // Sparse buffer.
    let sparse_buffer_main_usage = match p.descriptor_type {
        vk::DescriptorType::STORAGE_BUFFER => vk::BufferUsageFlags::STORAGE_BUFFER,
        vk::DescriptorType::UNIFORM_BUFFER => vk::BufferUsageFlags::UNIFORM_BUFFER,
        vk::DescriptorType::STORAGE_TEXEL_BUFFER => vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER,
        _ => vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER,
    };
    let sparse_buffer_usage = extra_usage_flag | sparse_buffer_main_usage | vk::BufferUsageFlags::TRANSFER_SRC;
    let mut sparse_buffer_flags = vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY;
    if p.capture_replay {
        sparse_buffer_flags |= vk::BufferCreateFlags::DEVICE_ADDRESS_CAPTURE_REPLAY;
    }

    let opaque_capture_address_info = vk::BufferOpaqueCaptureAddressCreateInfo {
        s_type: vk::StructureType::BUFFER_OPAQUE_CAPTURE_ADDRESS_CREATE_INFO,
        next: std::ptr::null(),
        opaque_capture_address: replay_params.buffer_opaque_address,
    };
    let queue_family_indices = [sparse_queue.family_index, compute_queue.family_index];
    let concurrent = sparse_queue.family_index != compute_queue.family_index;
    let sparse_buffer_info = vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: if replay {
            (&raw const opaque_capture_address_info).cast()
        } else {
            std::ptr::null()
        },
        flags: sparse_buffer_flags,
        size: buffer_size,
        usage: sparse_buffer_usage,
        sharing_mode: if concurrent {
            vk::SharingMode::CONCURRENT
        } else {
            vk::SharingMode::EXCLUSIVE
        },
        queue_family_index_count: if concurrent { 2 } else { 0 },
        queue_family_indices: if concurrent {
            queue_family_indices.as_ptr()
        } else {
            std::ptr::null()
        },
    };
    let sparse_buffer = Unique::new(
        device,
        unsafe { device.create_buffer(&sparse_buffer_info, None) }.vk_check("vkCreateBuffer")?,
    );

    if capture {
        let info = vk::BufferDeviceAddressInfo::builder().buffer(*sparse_buffer);
        replay_params.buffer_opaque_address = unsafe { device.get_buffer_opaque_capture_address(&info) };
    }

    if p.capture_replay {
        let sparse_bda = buffer_device_address(device, *sparse_buffer);
        if capture {
            replay_params.buffer_device_address = sparse_bda;
        } else if replay && sparse_bda != replay_params.buffer_device_address {
            return Err(TestError::Fail(
                "Sparse buffer replay device address does not match capture device address".to_string(),
            ));
        }
    }

    let regular_buffer_usage = extra_usage_flag
        | vk::BufferUsageFlags::STORAGE_BUFFER
        | vk::BufferUsageFlags::TRANSFER_SRC
        | vk::BufferUsageFlags::TRANSFER_DST;
    let regular_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, regular_buffer_usage),
        MemoryRequirement::DEVICE_ADDRESS,
    )?;

    // Staging host-visible buffer to be used with the regular one.
    let staging_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Decide which buffer will be the source and the destination in the shader, depending on test parameters.
    let src_buffer = if p.write { regular_buffer.get() } else { *sparse_buffer };
    let dst_buffer = if p.write { *sparse_buffer } else { regular_buffer.get() };

    let shader_stages = vk::ShaderStageFlags::COMPUTE;
    let src_desc_type = p.src_buffer_desc_type();
    let dst_desc_type = p.dst_buffer_desc_type();

    let src_buffer_view = if is_texel_buffer(src_desc_type) {
        Some(make_buffer_view(device, src_buffer, buffer_size)?)
    } else {
        None
    };
    let dst_buffer_view = if is_texel_buffer(dst_desc_type) {
        Some(make_buffer_view(device, dst_buffer, buffer_size)?)
    } else {
        None
    };

    // Pipeline, passing buffer addresses as push constants, or using descriptors.
    let (src_buffer_address, dst_buffer_address) = if p.access_type != ResourceAccessType::DescriptorSet {
        (
            buffer_device_address(device, src_buffer),
            buffer_device_address(device, dst_buffer),
        )
    } else {
        (0, 0)
    };

    let mut push_constants = [0u8; 16];
    for (chunk, value) in push_constants.chunks_exact_mut(4).zip([
        (src_buffer_address & 0xFFFF_FFFF) as u32,
        ((src_buffer_address >> 32) & 0xFFFF_FFFF) as u32,
        (dst_buffer_address & 0xFFFF_FFFF) as u32,
        ((dst_buffer_address >> 32) & 0xFFFF_FFFF) as u32,
    ]) {
        chunk.copy_from_slice(&value.to_ne_bytes());
    }
    let pc_ranges = [vk::PushConstantRange {
        stage_flags: shader_stages,
        offset: 0,
        size: 16,
    }];

    let use_descriptor_set = p.access_type == ResourceAccessType::DescriptorSet;
    let mut set_layout_builder = DescriptorSetLayoutBuilder::new();
    if use_descriptor_set {
        set_layout_builder = set_layout_builder
            .add_single_binding(src_desc_type, shader_stages)
            .add_single_binding(dst_desc_type, shader_stages);
    }
    let set_layout = set_layout_builder.build(device)?;
    let pipeline_layout = if use_descriptor_set {
        make_pipeline_layout_with_push_constants(device, &[*set_layout], &[])?
    } else {
        make_pipeline_layout_with_push_constants(device, &[], &pc_ranges)?
    };

    let comp_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let shader_stage_info = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*comp_module)
        .name(b"main\0")
        .build();
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(shader_stage_info)
        .layout(*pipeline_layout)
        .base_pipeline_index(-1)
        .build();
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    let mut pool_builder = DescriptorPoolBuilder::new();
    if use_descriptor_set {
        pool_builder = pool_builder.add_type(src_desc_type, 1).add_type(dst_desc_type, 1);
    }
    let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = if use_descriptor_set {
        Some(make_descriptor_set(device, *descriptor_pool, *set_layout)?)
    } else {
        None
    };

    if let Some(set) = &descriptor_set {
        write_buffer_descriptor(
            device,
            set.get(),
            0,
            src_desc_type,
            src_buffer,
            src_buffer_view.as_ref().map_or(vk::BufferView::null(), |view| **view),
        );
        write_buffer_descriptor(
            device,
            set.get(),
            1,
            dst_desc_type,
            dst_buffer,
            dst_buffer_view.as_ref().map_or(vk::BufferView::null(), |view| **view),
        );
    }

    let buffer_copy = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: buffer_size,
    };
    let cmd_pool = make_command_pool(device, compute_queue.family_index)?;

    // Run the expected pipeline work.
    let execute_work = |result: &mut [u32], regular_buffer_init: &[u32]| -> Result<(), TestError> {
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        {
            // Prepare the source or destination buffer with non-zero contents.
            write_values(device, &staging_buffer, regular_buffer_init)?;
            unsafe {
                device.cmd_copy_buffer(cmd, staging_buffer.get(), regular_buffer.get(), &[buffer_copy]);
            }

            // Transfer before other writes in the shader.
            let barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::SHADER_WRITE);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                )
            };
        }
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get());
            match &descriptor_set {
                Some(set) => device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[set.get()],
                    &[] as &[u32],
                ),
                None => device.cmd_push_constants(cmd, *pipeline_layout, shader_stages, 0, &push_constants),
            }
            device.cmd_dispatch(cmd, p.work_group_count(), 1, 1);
        }
        {
            // Copy values back to the staging buffer.
            let pre_copy = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::TRANSFER_READ);
            let post_copy = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[pre_copy],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                device.cmd_copy_buffer(cmd, dst_buffer, staging_buffer.get(), &[buffer_copy]);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[post_copy],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, compute_queue.handle, cmd)?;
        read_values(device, staging_buffer.get_allocation(), result)
    };

    let mut mapped_values = vec![0u32; value_count];
    let mut unmapped_values = vec![0u32; value_count];

    let mut sparse_memory = None;
    if p.map_first {
        let mut sparse_memory_flags = vk::MemoryAllocateFlags::empty();
        let mut memory_opaque_capture_addr = None;

        if p.access_type != ResourceAccessType::DescriptorSet {
            sparse_memory_flags |= vk::MemoryAllocateFlags::DEVICE_ADDRESS;
            if p.capture_replay {
                sparse_memory_flags |= vk::MemoryAllocateFlags::DEVICE_ADDRESS_CAPTURE_REPLAY;
                if replay {
                    memory_opaque_capture_addr = Some(replay_params.memory_opaque_address);
                }
            }
        }

        let mem_reqs = unsafe { device.get_buffer_memory_requirements(*sparse_buffer) };
        let memory = allocator.allocate_with_flags(
            device,
            mem_reqs,
            MemoryRequirement::HOST_VISIBLE,
            sparse_memory_flags,
            memory_opaque_capture_addr,
        )?;

        if capture {
            let info = vk::DeviceMemoryOpaqueCaptureAddressInfo::builder().memory(memory.get_memory());
            replay_params.memory_opaque_address = unsafe { device.get_device_memory_opaque_capture_address(&info) };
        }

        let bind_sparse_and_wait = |bind_memory: vk::DeviceMemory| -> Result<(), TestError> {
            let memory_binds = [vk::SparseMemoryBind {
                resource_offset: 0,
                size: mem_reqs.size,
                memory: bind_memory,
                memory_offset: 0,
                flags: vk::SparseMemoryBindFlags::empty(),
            }];
            let buffer_binds = [vk::SparseBufferMemoryBindInfo::builder()
                .buffer(*sparse_buffer)
                .binds(&memory_binds)
                .build()];
            let bind_info = vk::BindSparseInfo::builder().buffer_binds(&buffer_binds);
            let fence = Unique::new(
                device,
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_info], *fence) }
                .vk_check("vkQueueBindSparse")?;
            unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
            Ok(())
        };

        // Bind memory.
        bind_sparse_and_wait(memory.get_memory())?;

        let values = if p.write { &zero_values } else { &alt_non_zero_values };
        unsafe {
            std::ptr::copy_nonoverlapping(
                values.as_ptr().cast::<u8>(),
                memory.get_host_ptr(),
                std::mem::size_of_val(values.as_slice()),
            )
        };
        flush_alloc(device, &memory)?;

        execute_work(&mut mapped_values, &non_zero_values)?;

        // Unbind memory and wait.
        bind_sparse_and_wait(vk::DeviceMemory::null())?;
        sparse_memory = Some(memory);
    }

    execute_work(
        &mut unmapped_values,
        if p.write {
            &alt_non_zero_values
        } else {
            &non_zero_values
        },
    )?;

    let mut fail = false;

    if let Some(memory) = &sparse_memory {
        let expected = if p.write {
            &non_zero_values
        } else {
            &alt_non_zero_values
        };
        if !check_values_match("[MAPPED]", &mapped_values, expected) {
            fail = true;
        }

        if p.write {
            // Verify the initially written values are still in the now unmapped memory. mappedValues was copied while the memory was still
            // mapped; the second work should not have overwritten those values by mistake.
            let mut memory_values = vec![0u32; value_count];
            read_values(device, memory, &mut memory_values)?;
            if !check_values_match("[WAS-MAPPED]", &memory_values, &non_zero_values) {
                fail = true;
            }
        }
    }

    // Unmapped values should always been zero.
    if !check_values_match("[UNMAPPED]", &unmapped_values, &zero_values) {
        fail = true;
    }

    if fail {
        return Err(TestError::Fail(
            "Invalid values found in output buffer; check log for details --".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// The `misc` group of `createSparseBufferTests`
pub fn create_sparse_buffer_misc_tests() -> TestCaseGroup {
    let mut misc_group = TestCaseGroup::new("misc");

    for descriptor_type in [
        vk::DescriptorType::STORAGE_BUFFER,
        vk::DescriptorType::UNIFORM_BUFFER,
        vk::DescriptorType::STORAGE_TEXEL_BUFFER,
        vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
    ] {
        let is_storage_buffer = descriptor_type == vk::DescriptorType::STORAGE_BUFFER;
        let is_uniform_buffer = descriptor_type == vk::DescriptorType::UNIFORM_BUFFER;
        let is_uniform_texel_buffer = descriptor_type == vk::DescriptorType::UNIFORM_TEXEL_BUFFER;
        let is_storage_texel_buffer = descriptor_type == vk::DescriptorType::STORAGE_TEXEL_BUFFER;
        let read_only_descriptor = is_uniform_buffer || is_uniform_texel_buffer;

        for use_local_invocation_index in [false, true] {
            for access_type in [
                ResourceAccessType::DeviceAddress,
                ResourceAccessType::DescriptorSet,
                ResourceAccessType::DescriptorHeap,
            ] {
                if !(is_storage_buffer || access_type != ResourceAccessType::DeviceAddress) {
                    continue;
                }

                for map_first in [false, true] {
                    for write in [false, true] {
                        for capture_replay in [false, true] {
                            if capture_replay && access_type == ResourceAccessType::DescriptorSet {
                                continue;
                            }

                            if write && read_only_descriptor {
                                continue;
                            }

                            let params = Params {
                                descriptor_type,
                                access_type,
                                use_local_invocation_index,
                                map_first,
                                write,
                                capture_replay,
                            };

                            let access_suffix = match access_type {
                                ResourceAccessType::DescriptorSet => "_descriptors",
                                ResourceAccessType::DescriptorHeap => "_descriptor_heap",
                                ResourceAccessType::DeviceAddress => "",
                            };

                            let desc_type_suffix = if is_uniform_buffer {
                                "_uniform_buffer"
                            } else if is_uniform_texel_buffer {
                                "_uniform_texel_buffer"
                            } else if is_storage_texel_buffer {
                                "_storage_texel_buffer"
                            } else {
                                ""
                            };

                            let test_name = format!(
                                "null_address_{}{}{}{}{}{}",
                                if write { "write" } else { "read" },
                                if use_local_invocation_index {
                                    "_local_inv_idx"
                                } else {
                                    ""
                                },
                                access_suffix,
                                if map_first { "_map_first" } else { "" },
                                desc_type_suffix,
                                if capture_replay { "_capture_replay" } else { "" },
                            );

                            misc_group.add_child(Box::new(NullAddressCase {
                                name: test_name,
                                params,
                            }) as Box<dyn TestCase>);
                        }
                    }
                }
            }
        }
    }

    misc_group
}
