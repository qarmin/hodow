// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeBasicComputeShaderTests.cpp
//   (ConcurrentCompute, BufferToBufferInvertTest with doBoundsCheck, ReadUnboundSSBOTest,
//    ImageAtomicOpTest, ImageBarrierTest, UndefinedValues, SequentialDispatchTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Split out of
// basic_compute_shader_tests.rs / basic_compute_image_tests.rs because these are the
// remaining non-Amber cases of the same upstream group, and each of them needs
// something the plain path does not have: a partially bound SSBO, a robustness2
// device, VK_KHR_device_group, a second queue, or Vulkan 1.2. Upstream keeps them all
// in the one file.
//
// The image helpers (`copy_image_to_buffer`, `write_storage_image`,
// `make_descriptor_image_info`) are duplicated from basic_compute_image_tests.rs
// rather than imported, to keep the two modules independent.

use std::ffi::c_char;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use crate::tcu::{self, IVec2, IVec3, Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{
    ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::{BinaryCollection, ProgramBinary, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The format both image-backed cases here use for their storage image.
const IMAGE_FORMAT: vk::Format = vk::Format::R32_UINT;

/// `tcu::multiplyComponents` for a 2-component vector.
fn multiply_components2(v: IVec2) -> i32 {
    v.x() * v.y()
}

/// `vk::makeDescriptorImageInfo` for a storage image bound in the GENERAL layout.
fn make_descriptor_image_info(image_view: vk::ImageView, image_layout: vk::ImageLayout) -> vk::DescriptorImageInfo {
    vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view,
        image_layout,
    }
}

/// Adds a storage-image descriptor write. `DescriptorSetUpdateBuilder` only carries
/// buffer infos, so image writes go through their own call.
fn write_storage_image(
    device: &Device,
    descriptor_set: vk::DescriptorSet,
    binding: u32,
    image_info: &vk::DescriptorImageInfo,
) {
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: descriptor_set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
        image_info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

/// `vk::copyImageToBuffer`, narrowed to the single-region, single-layer 2D colour case.
///
/// Keeps the image in GENERAL for the transfer when it is already in GENERAL, which is
/// what upstream does - the copy does not need TRANSFER_SRC_OPTIMAL and an extra
/// transition would be a divergence.
fn copy_image_to_buffer(
    vk: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: IVec2,
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
) {
    let transfer_layout = if old_layout == vk::ImageLayout::GENERAL {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };

    let image_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        transfer_layout,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );

        let subresource = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: size.x() as u32,
                height: size.y() as u32,
                depth: 1,
            },
            subresource,
        );
        vk.cmd_copy_image_to_buffer(cmd_buffer, image, transfer_layout, buffer, &[region]);

        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer,
            0,
            vk::WHOLE_SIZE,
        );
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// A `VkDevice` the test creates for itself instead of taking the Context's.
///
/// Upstream calls this `CustomDevice`/`DeviceWrapper`. Two cases here need a device
/// the shared Context cannot give them: `copy_ssbo_bounds` needs robustBufferAccess2
/// on, and `concurrent_compute` needs two queues.
struct CustomDevice {
    device: Device,
}

impl CustomDevice {
    fn get(&self) -> &Device {
        &self.device
    }
}

impl Drop for CustomDevice {
    fn drop(&mut self) {
        unsafe {
            // A device that is already lost cannot be waited on; ignore the result so
            // teardown after a device-lost test does not itself become an error.
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

// ---------------------------------------------------------------------------------
// ConcurrentCompute
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct ConcurrentComputeCase {
    pub name: &'static str,
    pub num_values: u32,
    pub random_seed: u32,
    pub programs: BinaryCollection,
}

impl TestCase for ConcurrentComputeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConcurrentComputeInstance {
            context,
            num_values: self.num_values,
            random_seed: self.random_seed,
        })
    }
}

struct ConcurrentComputeInstance<'a> {
    context: &'a Context<'a>,
    num_values: u32,
    random_seed: u32,
}

/// `ConcurrentComputeInstance::iterate`'s local `struct Queues`.
#[derive(Clone, Copy)]
struct Queues {
    queue: vk::Queue,
    queue_family_index: u32,
}

impl TestInstance for ConcurrentComputeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        const NO_MATCH_FOUND: u32 = u32::MAX;
        const ERROR_NONE: i32 = 0;
        const ERROR_WAIT: i32 = 1;
        const ERROR_ORDER: i32 = 2;

        let num_values = self.num_values;
        let instance_driver = self.context.get_instance();
        let physical_device = self.context.get_physical_device();
        let queue_priorities = [1.0f32, 0.0f32];
        let mut queues = [
            Queues {
                queue: vk::Queue::null(),
                queue_family_index: NO_MATCH_FOUND,
            },
            Queues {
                queue: vk::Queue::null(),
                queue_family_index: NO_MATCH_FOUND,
            },
        ];

        let queue_family_properties =
            unsafe { instance_driver.get_physical_device_queue_family_properties(physical_device) };

        for queue_ndx in 0..queue_family_properties.len() as u32 {
            if queue_family_properties[queue_ndx as usize]
                .queue_flags
                .contains(vk::QueueFlags::COMPUTE)
            {
                if NO_MATCH_FOUND == queues[0].queue_family_index {
                    queues[0].queue_family_index = queue_ndx;
                }

                if queues[0].queue_family_index != queue_ndx
                    || queue_family_properties[queue_ndx as usize].queue_count > 1
                {
                    queues[1].queue_family_index = queue_ndx;
                    break;
                }
            }
        }

        if queues[0].queue_family_index == NO_MATCH_FOUND || queues[1].queue_family_index == NO_MATCH_FOUND {
            return Err(TestError::NotSupported("Queues couldn't be created".to_string()));
        }

        let same_family = queues[0].queue_family_index == queues[1].queue_family_index;

        let mut queue_infos: Vec<vk::DeviceQueueCreateInfo> = Vec::new();
        for queue_ndx in 0..2usize {
            let queue_count = if same_family { 2 } else { 1 };
            let priorities: &[f32] = if queue_count == 2 {
                &queue_priorities
            } else {
                &queue_priorities[queue_ndx..=queue_ndx]
            };

            queue_infos.push(vk::DeviceQueueCreateInfo {
                s_type: vk::StructureType::DEVICE_QUEUE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::DeviceQueueCreateFlags::empty(),
                queue_family_index: queues[queue_ndx].queue_family_index,
                queue_count,
                queue_priorities: priorities.as_ptr(),
            });

            if same_family {
                break;
            }
        }

        let device_features = unsafe { instance_driver.get_physical_device_features(physical_device) };

        // The shader-object branch of the upstream device setup belongs to the
        // construction types that are not ported, so no extensions are enabled here.
        let device_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_features(&device_features);

        let logical_device = CustomDevice {
            device: unsafe { instance_driver.create_device(physical_device, &device_info, None) }
                .vk_check("vkCreateDevice")?,
        };
        let vk = logical_device.get();

        for (queue_req_ndx, queue) in queues.iter_mut().enumerate() {
            queue.queue = if same_family {
                unsafe { vk.get_device_queue(queue.queue_family_index, queue_req_ndx as u32) }
            } else {
                unsafe { vk.get_device_queue(queue.queue_family_index, 0) }
            };
        }

        let allocator = SimpleAllocator::new(*self.context.get_default_allocator().memory_properties());

        // Create an input/output buffers
        let buffer_size_bytes = std::mem::size_of::<u32>() as u64 * num_values as u64;
        let buffer1 = BufferWithMemory::new(
            vk,
            &allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer2 = BufferWithMemory::new(
            vk,
            &allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the buffers with data

        let mut input_data: Vec<u32> = Vec::with_capacity(num_values as usize);
        {
            let mut rnd = Random::new(self.random_seed);
            let buffer_allocation1 = buffer1.get_allocation();
            let buffer_allocation2 = buffer2.get_allocation();
            let buffer_ptr1 = buffer_allocation1.get_host_ptr().cast::<u32>();
            let buffer_ptr2 = buffer_allocation2.get_host_ptr().cast::<u32>();

            for i in 0..num_values {
                let val = rnd.get_uint32();
                input_data.push(val);
                unsafe {
                    *buffer_ptr1.add(i as usize) = val;
                    *buffer_ptr2.add(i as usize) = val;
                }
            }

            flush_alloc(vk, buffer_allocation1)?;
            flush_alloc(vk, buffer_allocation2)?;
        }

        // Create descriptor sets

        let descriptor_set_layout1 = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool1 = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set1 = make_descriptor_set(vk, *descriptor_pool1, *descriptor_set_layout1)?;

        let buffer_descriptor_info1 = make_descriptor_buffer_info(buffer1.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set1,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_descriptor_info1,
            )
            .update(vk);

        let descriptor_set_layout2 = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool2 = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set2 = make_descriptor_set(vk, *descriptor_pool2, *descriptor_set_layout2)?;

        let buffer_descriptor_info2 = make_descriptor_buffer_info(buffer2.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set2,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_descriptor_info2,
            )
            .update(vk);

        // Perform the computation

        let mut pipeline1 = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline1.set_descriptor_set_layout(*descriptor_set_layout1);
        pipeline1.build_pipeline()?;
        let host_write_barrier1 = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_READ,
            buffer1.get(),
            0,
            buffer_size_bytes,
        );
        let shader_write_barrier1 = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer1.get(),
            0,
            buffer_size_bytes,
        );
        let cmd_pool1 = make_command_pool(vk, queues[0].queue_family_index)?;
        let cmd_buffer1 = allocate_command_buffer(vk, *cmd_pool1, vk::CommandBufferLevel::PRIMARY)?;

        let mut pipeline2 = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline2.set_descriptor_set_layout(*descriptor_set_layout2);
        pipeline2.build_pipeline()?;
        let host_write_barrier2 = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_READ,
            buffer2.get(),
            0,
            buffer_size_bytes,
        );
        let shader_write_barrier2 = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer2.get(),
            0,
            buffer_size_bytes,
        );
        let cmd_pool2 = make_command_pool(vk, queues[1].queue_family_index)?;
        let cmd_buffer2 = allocate_command_buffer(vk, *cmd_pool2, vk::CommandBufferLevel::PRIMARY)?;

        // Command buffer 1

        begin_command_buffer(vk, *cmd_buffer1)?;
        pipeline1.bind(*cmd_buffer1);
        unsafe {
            vk.cmd_bind_descriptor_sets(
                *cmd_buffer1,
                vk::PipelineBindPoint::COMPUTE,
                pipeline1.get_pipeline_layout(),
                0,
                &[*descriptor_set1],
                &[],
            );
            vk.cmd_pipeline_barrier(
                *cmd_buffer1,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier1],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_dispatch(*cmd_buffer1, 1, 1, 1);
            vk.cmd_pipeline_barrier(
                *cmd_buffer1,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier1],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer1)?;

        // Command buffer 2

        begin_command_buffer(vk, *cmd_buffer2)?;
        pipeline2.bind(*cmd_buffer2);
        unsafe {
            vk.cmd_bind_descriptor_sets(
                *cmd_buffer2,
                vk::PipelineBindPoint::COMPUTE,
                pipeline2.get_pipeline_layout(),
                0,
                &[*descriptor_set2],
                &[],
            );
            vk.cmd_pipeline_barrier(
                *cmd_buffer2,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier2],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_dispatch(*cmd_buffer2, 1, 1, 1);
            vk.cmd_pipeline_barrier(
                *cmd_buffer2,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier2],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer2)?;

        let cmd_buffers1 = [*cmd_buffer1];
        let cmd_buffers2 = [*cmd_buffer2];
        let submit_info1 = vk::SubmitInfo::builder().command_buffers(&cmd_buffers1);
        let submit_info2 = vk::SubmitInfo::builder().command_buffers(&cmd_buffers2);

        // Wait for completion
        let fence_info = vk::FenceCreateInfo::builder();
        let fence1 = Unique::new(
            vk,
            unsafe { vk.create_fence(&fence_info, None) }.vk_check("vkCreateFence")?,
        );
        let fence2 = Unique::new(
            vk,
            unsafe { vk.create_fence(&fence_info, None) }.vk_check("vkCreateFence")?,
        );

        unsafe { vk.queue_submit(queues[0].queue, &[submit_info1], *fence1) }.vk_check("vkQueueSubmit")?;
        unsafe { vk.queue_submit(queues[1].queue, &[submit_info2], *fence2) }.vk_check("vkQueueSubmit")?;

        let mut err = ERROR_NONE;

        // First wait for the low-priority queue
        if !matches!(unsafe { vk.wait_for_fences(&[*fence2], true, u64::MAX) }, Ok(code) if code == vk::SuccessCode::SUCCESS)
        {
            err = ERROR_WAIT;
        }

        // If the high-priority queue hasn't finished, we have a problem.
        if !matches!(unsafe { vk.get_fence_status(*fence1) }, Ok(code) if code == vk::SuccessCode::SUCCESS)
            && err == ERROR_NONE
        {
            err = ERROR_ORDER;
        }

        // Wait for the high-priority fence so we don't get errors on teardown.
        let _ = unsafe { vk.wait_for_fences(&[*fence1], true, u64::MAX) };

        // If we fail() before waiting for all of the fences, error will come from
        // teardown instead of the error we want.

        if err == ERROR_WAIT {
            return Ok(TestStatus::fail("Failed waiting for low-priority queue fence."));
        }

        // Validate the results

        let buffer_allocation1 = buffer1.get_allocation();
        invalidate_alloc(vk, buffer_allocation1)?;
        let buffer_ptr1 = buffer_allocation1.get_host_ptr().cast::<u32>();

        let buffer_allocation2 = buffer2.get_allocation();
        invalidate_alloc(vk, buffer_allocation2)?;
        let buffer_ptr2 = buffer_allocation2.get_host_ptr().cast::<u32>();

        for ndx in 0..num_values {
            let res1 = unsafe { *buffer_ptr1.add(ndx as usize) };
            let res2 = unsafe { *buffer_ptr2.add(ndx as usize) };
            let inp = input_data[ndx as usize];
            let reference = !inp;

            if res1 != reference || res1 != res2 {
                return Ok(TestStatus::fail(format!(
                    "Comparison failed for InOut.values[{ndx}] ref:{reference} res1:{res1} res2:{res2} inp:{inp}"
                )));
            }
        }

        if err == ERROR_ORDER {
            log::info!(
                "Note: Low-priority queue was faster than high-priority one. This is not an error, but priorities may be inverted."
            );
        }

        Ok(TestStatus::pass("Test passed"))
    }
}

// ---------------------------------------------------------------------------------
// BufferToBufferInvertTest (CopyInvertSSBOCase with doBoundsCheck)
// ---------------------------------------------------------------------------------

/// `BufferToBufferInvertTest::CopyInvertSSBOCase(..., doBoundsCheck = true)`.
///
/// A separate type from the `BufferToBufferInvertCase` in basic_compute_shader_tests
/// only because the bounds-checking branch is what needs a robustness2 device; the
/// shader and the parameters are the SSBO-to-SSBO ones.
#[derive(Clone, Copy)]
pub struct CopySsboBoundsCase {
    pub name: &'static str,
    pub num_values: u32,
    pub local_size: IVec3,
    pub work_size: IVec3,
    pub random_seed: u32,
    pub programs: BinaryCollection,
}

impl TestCase for CopySsboBoundsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;

        // m_numValues is 512 here, far below the 1 << (32 - 4) that would bring the
        // shader64BitIndexing branch of the upstream checkSupport into play.

        context.require_device_functionality("VK_EXT_robustness2")?;

        let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut robustness2_features)
            .build();
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };

        if robustness2_features.robust_buffer_access2 == vk::FALSE {
            return Err(TestError::NotSupported(
                "robustBufferAccess2 not supported by this implementation".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopySsboBoundsInstance {
            context,
            num_values: self.num_values,
            work_size: self.work_size,
            random_seed: self.random_seed,
        })
    }
}

struct CopySsboBoundsInstance<'a> {
    context: &'a Context<'a>,
    num_values: u32,
    work_size: IVec3,
    random_seed: u32,
}

/// `createRobustDevice` - a device with robustBufferAccess2 turned on, which is what
/// makes an access past the bound descriptor range return zero instead of being
/// undefined.
fn create_robust_device(context: &Context<'_>) -> Result<CustomDevice, TestError> {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();
    let queue_priority = [1.0f32];

    // Create a universal queue that supports graphics and compute
    let queue_params = [vk::DeviceQueueCreateInfo {
        s_type: vk::StructureType::DEVICE_QUEUE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::DeviceQueueCreateFlags::empty(),
        queue_family_index: context.get_universal_queue_family_index(),
        queue_count: 1,
        queue_priorities: queue_priority.as_ptr(),
    }];

    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    unsafe { vki.get_physical_device_features2(physical_device, &mut features2) };
    let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT {
        robust_buffer_access2: vk::TRUE,
        ..Default::default()
    };

    let extension_names: Vec<std::ffi::CString> = context
        .get_device_extensions()
        .iter()
        .filter_map(|n| std::ffi::CString::new(n.as_str()).ok())
        .collect();
    let extension_ptrs: Vec<*const c_char> = extension_names.iter().map(|n| n.as_ptr()).collect();

    let device_params = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_params)
        .enabled_extension_names(&extension_ptrs)
        .push_next(&mut robustness2_features)
        .push_next(&mut features2);

    let device = unsafe { vki.create_device(physical_device, &device_params, None) }.vk_check("vkCreateDevice")?;
    Ok(CustomDevice { device })
}

impl TestInstance for CopySsboBoundsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // The buffer holds a UVec4 per value even though only .x is used - upstream
        // does the same, and it is what makes the std140 array stride 16.
        let buffer_size_bytes = (std::mem::size_of::<tcu::UVec4>() as u64) * self.num_values as u64;

        let logical_device = create_robust_device(self.context)?;
        let vk = logical_device.get();

        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = unsafe { vk.get_device_queue(queue_family_index, 0) };
        let allocator = SimpleAllocator::new(*self.context.get_default_allocator().memory_properties());

        // Customize the test based on buffer type

        let input_buffer_usage_flags = vk::BufferUsageFlags::STORAGE_BUFFER;
        let input_buffer_descriptor_type = vk::DescriptorType::STORAGE_BUFFER;

        // Create an input buffer

        let input_buffer = BufferWithMemory::new(
            vk,
            &allocator,
            make_buffer_create_info(buffer_size_bytes, input_buffer_usage_flags),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the input buffer with data
        let mut input_values: Vec<tcu::UVec4> = Vec::with_capacity(self.num_values as usize);
        {
            let mut rnd = Random::new(self.random_seed);
            for _ in 0..self.num_values {
                input_values.push(tcu::UVec4::new(rnd.get_uint32(), 0, 0, 0));
            }

            let input_buffer_allocation = input_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    input_values.as_ptr().cast::<u8>(),
                    input_buffer_allocation.get_host_ptr(),
                    std::mem::size_of_val(input_values.as_slice()),
                );
            }
            flush_alloc(vk, input_buffer_allocation)?;
        }

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Create an output buffer

        let output_buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER
            | vk::BufferUsageFlags::TRANSFER_SRC
            | vk::BufferUsageFlags::TRANSFER_DST;
        let output_buffer = BufferWithMemory::new(
            vk,
            &allocator,
            make_buffer_create_info(buffer_size_bytes, output_buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Prefill with a pattern the shader must overwrite. Here it is also the
        // expected value for every element past the bound output range.
        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe { vk.cmd_fill_buffer(*cmd_buffer, output_buffer.get(), 0, buffer_size_bytes, 0xBEBEBEBE) };
        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Upstream also creates a readback buffer here; it is only read on the
        // m_deviceLocal path, which this case does not take.

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(input_buffer_descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(input_buffer_descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let input_range = buffer_size_bytes * 3 / 4;
        let output_range = buffer_size_bytes * 7 / 8;

        let input_buffer_descriptor_info = make_descriptor_buffer_info(input_buffer.get(), 0, input_range);
        let output_buffer_descriptor_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_range);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                input_buffer_descriptor_type,
                &input_buffer_descriptor_info,
            )
            .write_single(
                *descriptor_set,
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &output_buffer_descriptor_info,
            )
            .update(vk);

        // Perform the computation

        let mut pipeline = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let host_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_READ,
            input_buffer.get(),
            0,
            buffer_size_bytes,
        );

        let shader_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            0,
            buffer_size_bytes,
        );

        // Start recording commands
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

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vk.cmd_dispatch(
                *cmd_buffer,
                self.work_size.x() as u32,
                self.work_size.y() as u32,
                self.work_size.z() as u32,
            );
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results
        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(vk, output_buffer_allocation)?;

        let buffer_ptr = output_buffer_allocation.get_host_ptr().cast::<tcu::UVec4>();

        let value_size = std::mem::size_of::<tcu::UVec4>() as u64;
        for ndx in 0..self.num_values {
            let input_in_range = u64::from(ndx) * value_size < input_range;
            let output_in_range = u64::from(ndx) * value_size < output_range;
            let res = unsafe { (*buffer_ptr.add(ndx as usize)).x() };
            let reference = if output_in_range {
                !(if input_in_range {
                    input_values[ndx as usize].x()
                } else {
                    0
                })
            } else {
                0xBEBEBEBE
            };

            if res != reference {
                return Ok(TestStatus::fail(format!("Comparison failed for Output.values[{ndx}]")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// ReadUnboundSSBOTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct ReadUnboundSsboCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for ReadUnboundSsboCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ReadUnboundSsboInstance { context })
    }
}

struct ReadUnboundSsboInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for ReadUnboundSsboInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Create an output buffer
        let buffer_size_bytes = std::mem::size_of::<u32>() as u64; // 4 bytes
        let buffer0 = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create second buffer partially unbound
        let buffer_size_bytes1 = std::mem::size_of::<tcu::Vec4>() as u64; // 16 bytes for vec4
        let buffer1 = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes1, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Writing to buffer1
        let buffer1_allocation = buffer1.get_allocation();
        let bound_array_values = buffer1_allocation.get_host_ptr().cast::<f32>();

        // Random values for data
        unsafe {
            *bound_array_values.add(0) = 4.0;
            *bound_array_values.add(1) = 3.0;
            *bound_array_values.add(2) = 2.0;
            *bound_array_values.add(3) = 1.0;
        }

        flush_alloc(vk, buffer1_allocation)?;

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let buffer0_descriptor_info = make_descriptor_buffer_info(buffer0.get(), 0, buffer_size_bytes);
        let buffer1_descriptor_info = make_descriptor_buffer_info(buffer1.get(), 0, buffer_size_bytes1);

        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer0_descriptor_info,
            )
            .write_single(
                *descriptor_set,
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer1_descriptor_info,
            )
            .update(vk);

        // Perform the computation
        let mut pipeline = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let shader_write_barriers = [make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer0.get(),
            0,
            buffer_size_bytes,
        )];

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands
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

            let group_count_xyz = 1;
            vk.cmd_dispatch(*cmd_buffer, group_count_xyz, group_count_xyz, group_count_xyz);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &shader_write_barriers,
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results for SSBO0
        {
            let buffer0_allocation = buffer0.get_allocation();
            invalidate_alloc(vk, buffer0_allocation)?;
            let buffer0_ptr = buffer0_allocation.get_host_ptr().cast::<u32>();

            let res = unsafe { *buffer0_ptr };

            if res != 0 {
                return Ok(TestStatus::fail(format!(
                    "Comparison failed for not_set.length(). Expected: 0, Got: {res}"
                )));
            }
        }

        // Validate the results for SSBO1
        {
            let buffer1_output_allocation = buffer1.get_allocation();
            invalidate_alloc(vk, buffer1_output_allocation)?;

            let output_values = buffer1_output_allocation.get_host_ptr().cast::<f32>();

            // Compare output values. They should be * 2 times the input if test is working correctly
            let ok = unsafe {
                *output_values.add(0) == 8.0
                    && *output_values.add(1) == 6.0
                    && *output_values.add(2) == 4.0
                    && *output_values.add(3) == 2.0
            };
            if !ok {
                return Ok(TestStatus::fail("Comparison failed for data values."));
            }
        }

        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// ImageAtomicOpTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct ImageAtomicOpCase {
    pub name: &'static str,
    pub local_size: u32,
    pub image_size: IVec2,
    pub programs: BinaryCollection,
}

impl TestCase for ImageAtomicOpCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageAtomicOpInstance {
            context,
            local_size: self.local_size,
            image_size: self.image_size,
        })
    }
}

struct ImageAtomicOpInstance<'a> {
    context: &'a Context<'a>,
    local_size: u32,
    image_size: IVec2,
}

impl TestInstance for ImageAtomicOpInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Create an image

        let image_params = make_image_create_info(
            self.image_size,
            IMAGE_FORMAT,
            vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE,
        );
        let image = ImageWithMemory::new(vk, allocator, image_params, MemoryRequirement::ANY)?;

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_view = make_image_view(vk, image.get(), vk::ImageViewType::_2D, IMAGE_FORMAT, subresource_range)?;

        // Input buffer

        let num_input_values = multiply_components2(self.image_size) as u32 * self.local_size;
        let input_buffer_size_bytes = std::mem::size_of::<u32>() as u64 * num_input_values as u64;

        let input_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(input_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Populate the input buffer with test data
        {
            let mut rnd = Random::new(0x77238ac2);
            let input_buffer_allocation = input_buffer.get_allocation();
            let buffer_ptr = input_buffer_allocation.get_host_ptr().cast::<u32>();
            for i in 0..num_input_values {
                unsafe { *buffer_ptr.add(i as usize) = rnd.get_uint32() };
            }

            flush_alloc(vk, input_buffer_allocation)?;
        }

        // Create a buffer to store shader output (copied from image data)

        let image_area = multiply_components2(self.image_size) as u32;
        let output_buffer_size_bytes = std::mem::size_of::<u32>() as u64 * image_area as u64;
        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(output_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        // Set the bindings

        let image_descriptor_info = make_descriptor_image_info(*image_view, vk::ImageLayout::GENERAL);
        let buffer_descriptor_info = make_descriptor_buffer_info(input_buffer.get(), 0, input_buffer_size_bytes);

        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_descriptor_info,
            )
            .update(vk);
        write_storage_image(vk, *descriptor_set, 1, &image_descriptor_info);

        // Perform the computation
        {
            let mut pipeline = ComputePipelineWrapper::new(
                vk,
                ComputePipelineConstructionType::Pipeline,
                self.context.get_binary_collection().get("comp")?,
            );
            pipeline.set_descriptor_set_layout(*descriptor_set_layout);
            pipeline.build_pipeline()?;

            let input_buffer_post_host_write_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::SHADER_READ,
                input_buffer.get(),
                0,
                input_buffer_size_bytes,
            );

            let image_layout_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                image.get(),
                subresource_range,
            );

            // Prepare the command buffer

            let cmd_pool = make_command_pool(vk, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

            // Start recording commands

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

                vk.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[input_buffer_post_host_write_barrier],
                    &[image_layout_barrier],
                );
                vk.cmd_dispatch(*cmd_buffer, self.image_size.x() as u32, self.image_size.y() as u32, 1);
            }

            copy_image_to_buffer(
                vk,
                *cmd_buffer,
                image.get(),
                output_buffer.get(),
                self.image_size,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::GENERAL,
            );

            end_command_buffer(vk, *cmd_buffer)?;

            // Wait for completion

            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        }

        // Validate the results

        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(vk, output_buffer_allocation)?;

        let buffer_ptr = output_buffer_allocation.get_host_ptr().cast::<u32>();
        let ref_buffer_ptr = input_buffer.get_allocation().get_host_ptr().cast::<u32>();

        for pixel_ndx in 0..image_area {
            let res = unsafe { *buffer_ptr.add(pixel_ndx as usize) };
            let mut reference: u32 = 0;

            for offs in 0..self.local_size {
                reference = reference
                    .wrapping_add(unsafe { *ref_buffer_ptr.add((pixel_ndx * self.local_size + offs) as usize) });
            }

            if res != reference {
                return Ok(TestStatus::fail(format!("Comparison failed for pixel {pixel_ndx}")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// ImageBarrierTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct ImageBarrierCase {
    pub name: &'static str,
    pub image_size: IVec2,
    pub base_value: u32,
    pub programs: BinaryCollection,
}

impl TestCase for ImageBarrierCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageBarrierInstance {
            context,
            image_size: self.image_size,
            base_value: self.base_value,
        })
    }
}

struct ImageBarrierInstance<'a> {
    context: &'a Context<'a>,
    image_size: IVec2,
    base_value: u32,
}

impl TestInstance for ImageBarrierInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Create an image used by both shaders

        let image_params = make_image_create_info(self.image_size, IMAGE_FORMAT, vk::ImageUsageFlags::STORAGE);
        let image = ImageWithMemory::new(vk, allocator, image_params, MemoryRequirement::ANY)?;

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_view = make_image_view(vk, image.get(), vk::ImageViewType::_2D, IMAGE_FORMAT, subresource_range)?;

        // Create an output buffer

        let output_buffer_size_bytes = std::mem::size_of::<u32>() as u64;
        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(output_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Initialize atomic counter value to zero
        {
            let output_buffer_allocation = output_buffer.get_allocation();
            unsafe { *output_buffer_allocation.get_host_ptr().cast::<u32>() = 0 };
            flush_alloc(vk, output_buffer_allocation)?;
        }

        // Create a uniform buffer (to pass uniform constants)

        let uniform_buffer_size_bytes = std::mem::size_of::<u32>() as u64;
        let uniform_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(uniform_buffer_size_bytes, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Set the constants in the uniform buffer

        let base_value = self.base_value;
        {
            let uniform_buffer_allocation = uniform_buffer.get_allocation();
            unsafe { *uniform_buffer_allocation.get_host_ptr().cast::<u32>() = base_value };

            flush_alloc(vk, uniform_buffer_allocation)?;
        }

        // Create descriptor set

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let image_descriptor_info = make_descriptor_image_info(*image_view, vk::ImageLayout::GENERAL);
        let output_buffer_descriptor_info =
            make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size_bytes);
        let uniform_buffer_descriptor_info =
            make_descriptor_buffer_info(uniform_buffer.get(), 0, uniform_buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &output_buffer_descriptor_info,
            )
            .write_single(
                *descriptor_set,
                Location::binding(2),
                vk::DescriptorType::UNIFORM_BUFFER,
                &uniform_buffer_descriptor_info,
            )
            .update(vk);
        write_storage_image(vk, *descriptor_set, 1, &image_descriptor_info);

        // Perform the computation

        let mut pipeline0 = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp0")?,
        );
        pipeline0.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline0.build_pipeline()?;
        let mut pipeline1 = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp1")?,
        );
        pipeline1.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline1.build_pipeline()?;

        let write_uniform_constants_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::UNIFORM_READ,
            uniform_buffer.get(),
            0,
            uniform_buffer_size_bytes,
        );

        let image_layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::empty(),
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            subresource_range,
        );

        let image_barrier_between_shaders = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            image.get(),
            subresource_range,
        );

        let after_compute_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            0,
            output_buffer_size_bytes,
        );

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Start recording commands

        begin_command_buffer(vk, *cmd_buffer)?;

        pipeline0.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                pipeline0.get_pipeline_layout(),
                0,
                &[*descriptor_set],
                &[],
            );

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[write_uniform_constants_barrier],
                &[image_layout_barrier],
            );

            vk.cmd_dispatch(*cmd_buffer, self.image_size.x() as u32, self.image_size.y() as u32, 1);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier_between_shaders],
            );
        }

        // Switch to the second shader program
        pipeline1.bind(*cmd_buffer);

        unsafe {
            vk.cmd_dispatch(*cmd_buffer, self.image_size.x() as u32, self.image_size.y() as u32, 1);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[after_compute_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        // Wait for completion

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Validate the results

        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(vk, output_buffer_allocation)?;

        let num_values = multiply_components2(self.image_size);
        let res = unsafe { *output_buffer_allocation.get_host_ptr().cast::<u32>() };
        let mut reference: u32 = 0;

        for ndx in 0..num_values {
            reference += base_value + ndx as u32;
        }

        if res != reference {
            return Ok(TestStatus::fail(format!(
                "ERROR: comparison failed, expected {reference}, got {res}"
            )));
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// SequentialDispatchTest
// ---------------------------------------------------------------------------------

/// A compute pipeline built with explicit `VkPipelineCreateFlags`.
///
/// `ComputePipelineWrapper` has no `setPipelineCreateFlags`, and
/// `VK_PIPELINE_CREATE_DISPATCH_BASE` is precisely what this case is about, so the
/// pipeline is built here instead of going through the wrapper.
struct DispatchBasePipeline<'a> {
    device: &'a Device,
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
}

impl<'a> DispatchBasePipeline<'a> {
    fn new(
        device: &'a Device,
        binary: ProgramBinary,
        descriptor_set_layout: vk::DescriptorSetLayout,
        flags: vk::PipelineCreateFlags,
    ) -> Result<Self, TestError> {
        let set_layouts = [descriptor_set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout =
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?;
        let pipeline_layout = Unique::new(device, pipeline_layout);

        let shader_module = create_shader_module(device, binary)?;

        let entry_point = b"main\0";
        let stage = vk::PipelineShaderStageCreateInfo {
            s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::PipelineShaderStageCreateFlags::empty(),
            stage: vk::ShaderStageFlags::COMPUTE,
            module: *shader_module,
            name: entry_point.as_ptr().cast(),
            specialization_info: std::ptr::null(),
        };

        let create_info = vk::ComputePipelineCreateInfo {
            s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
            next: std::ptr::null(),
            flags,
            stage,
            layout: *pipeline_layout,
            base_pipeline_handle: vk::Pipeline::null(),
            base_pipeline_index: -1,
        };

        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
            .map_err(|e| TestError::InternalError(format!("vkCreateComputePipelines returned {e:?}")))?;

        Ok(Self {
            device,
            pipeline: Unique::new(device, pipelines.0[0]),
            pipeline_layout,
        })
    }

    /// `ComputePipelineWrapper::getPipelineLayout`
    fn get_pipeline_layout(&self) -> vk::PipelineLayout {
        *self.pipeline_layout
    }

    /// `ComputePipelineWrapper::bind`
    fn bind(&self, cmd_buffer: vk::CommandBuffer) {
        unsafe {
            self.device
                .cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *self.pipeline);
        }
    }
}

#[derive(Clone, Copy)]
pub struct SequentialDispatchCase {
    pub name: &'static str,
    pub base_group_x: u32,
    pub base_group_y: u32,
    pub base_group_z: u32,
    pub first_group_count_xyz: u32,
    pub second_group_count_x: u32,
    pub second_group_count_y: u32,
    pub second_group_count_z: u32,
    pub programs: BinaryCollection,
}

impl TestCase for SequentialDispatchCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // `Context::requireDeviceFunctionality` also accepts an extension that has been
        // promoted into the core version the device reports; VK_KHR_device_group is
        // core since 1.1, and a driver need not still advertise the extension string.
        let (major, minor, _) = context.api_version();
        if (major, minor) < (1, 1) {
            context.require_device_functionality("VK_KHR_device_group")?;
        }
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SequentialDispatchInstance { context, params: *self })
    }
}

struct SequentialDispatchInstance<'a> {
    context: &'a Context<'a>,
    params: SequentialDispatchCase,
}

impl TestInstance for SequentialDispatchInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Indirect dispatch buffer.
        let buffer_size_bytes = std::mem::size_of::<vk::DispatchIndirectCommand>() as u64;
        let indirect_dispatch_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::INDIRECT_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Counter buffer to read count from shader.
        let counter_buffer_size_bytes = std::mem::size_of::<u32>() as u64;
        let counter_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                counter_buffer_size_bytes,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the parameters in indirect dispatch buffer.
        let indirect_dispatch_buffer_allocation = indirect_dispatch_buffer.get_allocation();
        let dispatch_data_values = indirect_dispatch_buffer_allocation
            .get_host_ptr()
            .cast::<vk::DispatchIndirectCommand>();

        let second_group_count_x = self.params.second_group_count_x;
        let second_group_count_y = self.params.second_group_count_y;
        let second_group_count_z = self.params.second_group_count_z;

        unsafe {
            (*dispatch_data_values).x = second_group_count_x; // groupCountX
            (*dispatch_data_values).y = second_group_count_y; // groupCountY
            (*dispatch_data_values).z = second_group_count_z; // groupCountZ
        }

        flush_alloc(vk, indirect_dispatch_buffer_allocation)?;

        // Initialize the atomic counter to 0.
        let counter_buffer_allocation = counter_buffer.get_allocation();
        unsafe { *counter_buffer_allocation.get_host_ptr().cast::<u32>() = 0 };

        flush_alloc(vk, counter_buffer_allocation)?;

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_descriptor_info = make_descriptor_buffer_info(counter_buffer.get(), 0, counter_buffer_size_bytes);

        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_descriptor_info,
            )
            .update(vk);

        // Create compute pipeline.
        let pipeline = DispatchBasePipeline::new(
            vk,
            self.context.get_binary_collection().get("comp")?,
            *descriptor_set_layout,
            vk::PipelineCreateFlags::DISPATCH_BASE,
        )?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let shader_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            counter_buffer.get(),
            0,
            counter_buffer_size_bytes,
        );

        // Perform the computation.
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
        }

        // First issue the dispatch base command.
        let base_group_x = self.params.base_group_x;
        let base_group_y = self.params.base_group_y;
        let base_group_z = self.params.base_group_z;
        let first_group_count_xyz = self.params.first_group_count_xyz;

        unsafe {
            vk.cmd_dispatch_base(
                *cmd_buffer,
                base_group_x,
                base_group_y,
                base_group_z,
                first_group_count_xyz,
                first_group_count_xyz,
                first_group_count_xyz,
            );

            // Secondly, issue the dispatch indirect command.
            {
                let buffer_offset = 0; // Offset where dispatch data is stored
                vk.cmd_dispatch_indirect(*cmd_buffer, indirect_dispatch_buffer.get(), buffer_offset);
            }

            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, *cmd_buffer)?;

        submit_commands_and_wait(vk, queue, *cmd_buffer)?;

        // Read results
        let result_counter_buffer_allocation = counter_buffer.get_allocation();
        invalidate_alloc(vk, result_counter_buffer_allocation)?;
        let result_counter_value = unsafe { *result_counter_buffer_allocation.get_host_ptr().cast::<u32>() };

        // CmdDispatchBase invocations = 1x1x1 = 1
        // CmdDispatchIndirect invocations = 3x3x1 = 9
        // Total invocations = 10
        let expected_counter_value = (first_group_count_xyz * first_group_count_xyz * first_group_count_xyz)
            + (second_group_count_x * second_group_count_y * second_group_count_z);

        if result_counter_value != expected_counter_value {
            return Ok(TestStatus::fail(format!(
                "Comparison failed for counter value. Got: {result_counter_value}. Expected: {expected_counter_value}"
            )));
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// UndefinedValues
// ---------------------------------------------------------------------------------

/// `UndefinedValues::Bar` - must match the structure in the shader.
#[repr(C)]
#[derive(Clone, Copy, Default)]
struct Bar {
    x: u32,
    y: u32,
    z: [u32; 2],
}

/// `UndefinedValues::StorageBufferWithBar` - must match the structure in the shader.
#[repr(C)]
#[derive(Clone, Copy, Default)]
struct StorageBufferWithBar {
    a: [u32; 4],
    b: Bar,
    c: u32,
}

#[derive(Clone, Copy)]
pub struct UndefinedValuesCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for UndefinedValuesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;
        // `Context::contextSupports(VK_API_VERSION_1_2)`
        let (major, minor, _) = context.api_version();
        if (major, minor) < (1, 2) {
            return Err(TestError::NotSupported("Vulkan 1.2 is not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UndefinedValuesInstance { context })
    }
}

struct UndefinedValuesInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for UndefinedValuesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vkd = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let qf_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let stages = vk::ShaderStageFlags::COMPUTE;

        let mut buffer_data = StorageBufferWithBar::default();

        let buffer_size = std::mem::size_of::<StorageBufferWithBar>() as u64;
        let buffer_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER);
        let buffer = BufferWithMemory::new(vkd, allocator, buffer_info, MemoryRequirement::HOST_VISIBLE)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stages)
            .build(vkd)?;

        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            vkd,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(vkd, *descriptor_pool, *set_layout)?;

        let buffer_desc_info = make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), desc_type, &buffer_desc_info)
            .update(vkd);

        let mut pipeline = ComputePipelineWrapper::new(
            vkd,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.build_pipeline()?;
        let pipeline_layout = pipeline.get_pipeline_layout();

        let cmd_pool = make_command_pool(vkd, qf_index)?;
        let cmd_buffer = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Dispatch work and verify defined data.
        begin_command_buffer(vkd, *cmd_buffer)?;
        unsafe {
            vkd.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                pipeline_layout,
                0,
                &[*descriptor_set],
                &[],
            );
        }
        pipeline.bind(*cmd_buffer);
        unsafe {
            vkd.cmd_dispatch(*cmd_buffer, 1, 1, 1);

            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            vkd.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vkd, *cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, *cmd_buffer)?;

        let buffer_alloc = buffer.get_allocation();
        let buffer_ptr = buffer_alloc.get_host_ptr();

        invalidate_alloc(vkd, buffer_alloc)?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer_ptr,
                std::ptr::from_mut(&mut buffer_data).cast::<u8>(),
                std::mem::size_of::<StorageBufferWithBar>(),
            );
        }

        // These must match the shader.
        let res_a = buffer_data.a;
        if res_a != [1, 2, 3, 4] || buffer_data.c != 5 {
            return Ok(TestStatus::fail(format!(
                "Unexpected values in output structure: a={res_a:?} c={}",
                buffer_data.c
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------
// createBasicComputeShaderTests (the remaining non-Amber cases)
// ---------------------------------------------------------------------------------

/// Adds the cases of `createBasicComputeShaderTests` that neither
/// basic_compute_shader_tests nor basic_compute_image_tests registers.
///
/// Registration order is the upstream relative order, so a diff of the two result
/// files stays readable once the caller splices this block into the "basic" group.
pub fn add_basic_compute_extra_tests(group: &mut TestCaseGroup) {
    use crate::generated::shaders::compute_basic_extra as g;

    // Concurrent compute test
    group.add_child(Box::new(g::CONCURRENT_COMPUTE) as Box<dyn TestCase>);

    // Copy SSBO to SSBO with a descriptor range shorter than the buffer
    group.add_child(Box::new(g::COPY_SSBO_BOUNDS) as Box<dyn TestCase>);

    // Read from SSBO thats not fully bound
    group.add_child(Box::new(g::READ_UNBOUND_SSBO) as Box<dyn TestCase>);

    // Atomic operation with image
    group.add_child(Box::new(g::IMAGE_ATOMIC_OP_LOCAL_SIZE_1) as Box<dyn TestCase>);
    group.add_child(Box::new(g::IMAGE_ATOMIC_OP_LOCAL_SIZE_8) as Box<dyn TestCase>);

    // Image barrier
    group.add_child(Box::new(g::IMAGE_BARRIER_SINGLE) as Box<dyn TestCase>);
    group.add_child(Box::new(g::IMAGE_BARRIER_MULTIPLE) as Box<dyn TestCase>);

    group.add_child(Box::new(g::UNDEFINED_VALUES) as Box<dyn TestCase>);

    group.add_child(Box::new(g::INDIRECT_AFTER_BASE_DISPATCH) as Box<dyn TestCase>);
}
