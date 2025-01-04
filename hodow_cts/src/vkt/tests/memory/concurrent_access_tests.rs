// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryConcurrentAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The three compute shaders are in
// shaders/manifest/memory_concurrent_access.toml; `comp_1`/`comp_2`/`comp_4` are named
// after the integer width in bytes the test reads and writes.

use std::sync::Mutex;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest's single case.
#[derive(Clone, Copy)]
pub struct ConcurrentAccessCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `ResultType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ResultType {
    Success = 0,
    WrongInitialValueDuringComputeShader,
    WrongInitialValueAfterComputeShader,
    WrongShaderValueAfterComputeShader,
}

/// `ResultInfo`
#[derive(Clone, Copy)]
struct ResultInfo {
    result_type: ResultType,
    item_index: u32,
    item_value: u32,
}

/// The mapped pointer travels to the second thread; the buffer it points into outlives the
/// thread scope.
struct SendPtr(*mut u8);

unsafe impl Send for SendPtr {}

/// `secondThreadFunction<DataType>`
fn second_thread_function<T: Copy + PartialEq + Into<u32>>(
    buffer_host_ptr: SendPtr,
    items_count: u32,
    initial_value: T,
    shader_value: T,
    mtx: &Mutex<()>,
) -> ResultInfo {
    let buffer_host_ptr = buffer_host_ptr.0.cast::<T>();

    // create helper arrays that will simplify final validation code
    let expectel_values = [shader_value, initial_value];
    let after_compute_errors = [
        ResultType::WrongShaderValueAfterComputeShader,
        ResultType::WrongInitialValueAfterComputeShader,
    ];

    // read every value that is not currently accessed by the compute shader
    // and check that it matches the original bit pattern
    let mut item_index = 1;
    while item_index < items_count {
        let value = unsafe { std::ptr::read_volatile(buffer_host_ptr.add(item_index as usize)) };
        if value != initial_value {
            return ResultInfo {
                result_type: ResultType::WrongInitialValueDuringComputeShader,
                item_index,
                item_value: value.into(),
            };
        }
        item_index += 2;
    }

    // wait for singnal from main thread before starting final validation
    let _lock = mtx.lock().unwrap_or_else(|e| e.into_inner());

    // validate whole buffer
    for item_index in 0..items_count {
        // we alternately compare between the initial value and the value that was written in the shader
        let expected_value_index = (item_index % 2) as usize;
        let value = unsafe { std::ptr::read_volatile(buffer_host_ptr.add(item_index as usize)) };
        if value != expectel_values[expected_value_index] {
            return ResultInfo {
                result_type: after_compute_errors[expected_value_index],
                item_index,
                item_value: value.into(),
            };
        }
    }

    ResultInfo {
        result_type: ResultType::Success,
        item_index: 0,
        item_value: 0,
    }
}

/// `Context::get16BitStorageFeatures().uniformAndStorageBuffer16BitAccess` and the 8-bit twin,
/// both false when the device cannot say.
fn uniform_and_storage_buffer_access(context: &Context<'_>) -> (bool, bool) {
    let mut features_16bit = vk::PhysicalDevice16BitStorageFeatures::default();
    let mut features_8bit = vk::PhysicalDevice8BitStorageFeatures::default();
    let has_16bit = context.is_device_functionality_supported("VK_KHR_16bit_storage");
    let has_8bit = context.is_device_functionality_supported("VK_KHR_8bit_storage");

    let mut features2 = vk::PhysicalDeviceFeatures2::builder();
    if has_16bit {
        features2 = features2.push_next(&mut features_16bit);
    }
    if has_8bit {
        features2 = features2.push_next(&mut features_8bit);
    }
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    (
        has_16bit && features_16bit.uniform_and_storage_buffer_16bit_access != vk::FALSE,
        has_8bit && features_8bit.uniform_and_storage_buffer_8bit_access != vk::FALSE,
    )
}

/// `testShaderAndHostAccess`
fn test_shader_and_host_access(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();

    // define byte patterns used by test; for uint32 type pattern is just repeated 4 times, and for uin16 2 times
    let initial_byte_pattern: u8 = 0b01011011;
    let shader_byte_pattern: u8 = 0b11001010;

    // create buffer with shader access usage, at least 500 bytes in size, odd size value preferred
    let buffer_size: vk::DeviceSize = 501;
    let buffer_usage =
        vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
    let buffer_create_info = make_buffer_create_info(buffer_size, buffer_usage);
    let buffer = BufferWithMemory::new(
        vk,
        allocator,
        buffer_create_info,
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
    )?;
    let buffer_allocation = buffer.get_allocation();
    let buffer_host_ptr = buffer_allocation.get_host_ptr();

    // VUID-RuntimeSpirv-uniformAndStorageBuffer16BitAccess-06332
    // VUID-RuntimeSpirv-uniformAndStorageBuffer8BitAccess-06329
    let (uniform_and_storage_16bit, uniform_and_storage_8bit) = uniform_and_storage_buffer_access(context);
    let mut smallest_int_bytes: vk::DeviceSize = 4;
    if uniform_and_storage_16bit {
        smallest_int_bytes = 2;
    }
    if uniform_and_storage_8bit {
        smallest_int_bytes = 1;
    }

    // clear the buffer to a known bit pattern in each byte (not 0)
    for b in 0..buffer_size {
        unsafe { *buffer_host_ptr.add(b as usize) = initial_byte_pattern };
    }

    // create descriptor set
    let desc_type = vk::DescriptorType::STORAGE_BUFFER;
    let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
        vk,
        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
        1,
    )?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(desc_type, vk::ShaderStageFlags::COMPUTE)
        .build(vk)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;
    let buffer_descriptor_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            *descriptor_set,
            Location::binding(0),
            desc_type,
            &buffer_descriptor_info,
        )
        .update(vk);

    // create a compute pipeline in which we read smallest supported integer
    // from buffer and replace it with different pattern when the read value is correct
    let binary_collection = context.get_binary_collection();
    let shader_name = format!("comp_{smallest_int_bytes}");
    let mut pipeline = ComputePipelineWrapper::new(
        vk,
        ComputePipelineConstructionType::Pipeline,
        binary_collection.get(&shader_name)?,
    );
    pipeline.set_descriptor_set_layout(*descriptor_set_layout);
    pipeline.build_pipeline()?;
    let memory_barrier = make_memory_barrier(
        vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::SHADER_READ,
        vk::AccessFlags::HOST_READ,
    );
    let cmd_pool = make_command_pool(vk, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // we leave a gap of one integer that is unread between each invocation
    let invocations_count = ((buffer_size / smallest_int_bytes) as f32 / 2.0f32).ceil() as u32;

    begin_command_buffer(vk, *cmd_buffer)?;

    pipeline.bind(*cmd_buffer);
    unsafe {
        vk.cmd_bind_descriptor_sets(
            *cmd_buffer,
            vk::PipelineBindPoint::COMPUTE,
            pipeline.get_pipeline_layout(),
            0,
            &[*descriptor_set],
            &[],
        );
        vk.cmd_dispatch(*cmd_buffer, invocations_count, 1, 1);

        // include a pipeline barrier from SHADER ACCESS to HOST ACCESS
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[memory_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    end_command_buffer(vk, *cmd_buffer)?;

    let mtx = Mutex::new(());
    let items_count = (buffer_size / smallest_int_bytes) as u32;

    let result_info = std::thread::scope(|scope| -> Result<ResultInfo, TestError> {
        // make sure second thread does not start final validation befre submit
        let validation_lock = mtx.lock().unwrap_or_else(|e| e.into_inner());

        // launch the second thread
        let ptr = SendPtr(buffer_host_ptr);
        let mtx_ref = &mtx;
        let second_thread = if smallest_int_bytes == 1 {
            scope.spawn(move || {
                second_thread_function::<u8>(ptr, items_count, initial_byte_pattern, shader_byte_pattern, mtx_ref)
            })
        } else if smallest_int_bytes == 2 {
            scope.spawn(move || second_thread_function::<u16>(ptr, items_count, 23387u16, 51914u16, mtx_ref))
        } else {
            scope.spawn(move || second_thread_function::<u32>(ptr, items_count, 1532713819u32, 3402287818u32, mtx_ref))
        };

        // submit and wait for all commands; the lock is released on every path out of here,
        // otherwise the second thread would never finish and the scope never end
        let submitted = submit_commands_and_wait(vk, context.get_universal_queue(), *cmd_buffer);

        // signal the second thread so that it can validate whole buffer
        drop(validation_lock);

        // wait till validation finishes on the second thread
        let result_info = second_thread
            .join()
            .map_err(|_| TestError::InternalError("second thread panicked".to_string()))?;

        submitted?;
        Ok(result_info)
    })?;

    match result_info.result_type {
        ResultType::Success => Ok(TestStatus::pass("Pass")),
        ResultType::WrongInitialValueDuringComputeShader => {
            log::info!(
                "Compute shader should not change initial value at index {}, got {}",
                result_info.item_index,
                result_info.item_value
            );
            Ok(TestStatus::fail("Wrong initial value in compute shader"))
        }
        ResultType::WrongInitialValueAfterComputeShader => {
            log::info!(
                "After execution of compute shader finished at index {} there should be initial value, got {}",
                result_info.item_index,
                result_info.item_value
            );
            Ok(TestStatus::fail("Wrong initial value after compute shader"))
        }
        ResultType::WrongShaderValueAfterComputeShader => {
            log::info!(
                "After execution of compute shader finished at index {} there should be shader written value, got {}",
                result_info.item_index,
                result_info.item_value
            );
            Ok(TestStatus::fail("Wrong shader written value"))
        }
    }
}

impl TestCase for ConcurrentAccessCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConcurrentAccessInstance { context })
    }
}

struct ConcurrentAccessInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for ConcurrentAccessInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_shader_and_host_access(self.context)
    }
}

/// `createConcurrentAccessTests`
pub fn create_concurrent_access_tests() -> TestCaseGroup {
    use crate::generated::shaders::memory_concurrent_access as g;

    let mut group = TestCaseGroup::new("concurrent_access");

    group.add_child(Box::new(g::SHADER_AND_HOST) as Box<dyn TestCase>);

    group
}
