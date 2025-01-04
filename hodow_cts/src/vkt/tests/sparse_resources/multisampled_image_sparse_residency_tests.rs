// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesMultisampledImageSparseResidency.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader depends on the format and the sample count, so the manifest holds one
// program per pair and `programs()` looks it up.
//
// A partially resident multisampled storage image (every tile but the last row of tiles bound) has sample 0 written and read back with
// sparseImageLoadARB in a compute shader, the value being copied into a single-sample result image that must be zero where
// nothing is resident.

use vulkanalia::prelude::v1_0::*;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    ImageType, NO_MATCH_FOUND, aligned_divide, check_sparse_support_for_image_format, find_matching_memory_type,
    get_image_format_id, get_plane_extent, is_image_size_supported, make_sparse_image_memory_bind,
    submit_commands_and_wait,
};
use crate::generated::shaders::sparse_resources_multisampled_residency::ALL_MULTISAMPLED_RESIDENCY_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::ycbcr::util::format_description;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct MultisampledResidencyProgram {
    pub name: &'static str,
    pub format_id: &'static str,
    pub samples: u32,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy)]
struct TestParams {
    format: vk::Format,
    sample_count: u32,
    img_size: [u32; 3],
}

fn get_elem_count(img_size: [u32; 3]) -> u32 {
    img_size[0] * img_size[1] * img_size[2]
}

/// `calculateBufferSize` - the format is R32_UINT.
fn calculate_buffer_size(img_size: [u32; 3]) -> u32 {
    get_elem_count(img_size) * 4
}

fn extent_of(img_size: [u32; 3]) -> vk::Extent3D {
    vk::Extent3D {
        width: img_size[0],
        height: img_size[1],
        depth: img_size[2],
    }
}

fn image_srr() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

struct MultisampledImageSparseResidencyCase {
    name: String,
    params: TestParams,
}

impl TestCase for MultisampledImageSparseResidencyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }
        if features.sparse_residency_image_2d == vk::FALSE {
            return Err(TestError::NotSupported(
                "sparseResidencyImage2D not supported".to_string(),
            ));
        }
        let sparse_samples_supported = match self.params.sample_count {
            2 => features.sparse_residency2_samples,
            4 => features.sparse_residency4_samples,
            8 => features.sparse_residency8_samples,
            16 => features.sparse_residency16_samples,
            _ => features.sparse_residency_image_2d,
        };
        if sparse_samples_supported == vk::FALSE {
            return Err(TestError::NotSupported(
                "sparseResidency for the sample count not supported".to_string(),
            ));
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        if context
            .get_device_properties()
            .sparse_properties
            .residency_non_resident_strict
            == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Operations on non resident part of sparse image are not supported".to_string(),
            ));
        }

        if !is_image_size_supported(instance, physical_device, ImageType::TwoD, self.params.img_size) {
            return Err(TestError::NotSupported(
                "Image size not supported for device".to_string(),
            ));
        }

        // Check multisample storage images support.
        if context.get_device_features().shader_storage_image_multisample == vk::FALSE {
            return Err(TestError::NotSupported(
                "Using multisample images as storage is not supported".to_string(),
            ));
        }

        let image_format_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                self.params.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::STORAGE,
                vk::ImageCreateFlags::empty(),
            )
        };
        match image_format_properties {
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                return Err(TestError::NotSupported("Format is not supported".to_string()));
            }
            Ok(properties) => {
                let requested = vk::SampleCountFlags::from_bits_truncate(self.params.sample_count);
                if !properties.sample_counts.contains(requested) {
                    return Err(TestError::NotSupported(
                        "Requested sample count is not supported".to_string(),
                    ));
                }
            }
            Err(_) => {}
        }

        if context.get_device_features().shader_resource_residency == vk::FALSE {
            return Err(TestError::NotSupported(
                "SparseResidency Capability Not Supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let format_id = get_image_format_id(self.params.format);
        ALL_MULTISAMPLED_RESIDENCY_PROGRAM
            .iter()
            .find(|p| p.format_id == format_id && p.samples == self.params.sample_count)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampledImageSparseResidencyInstance {
            context,
            params: self.params,
        })
    }
}

struct MultisampledImageSparseResidencyInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for MultisampledImageSparseResidencyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;

        // Create logical device supporting both sparse and compute queues
        let sparse_device = SparseDevice::new(
            context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::COMPUTE, 1),
            ],
            false,
        )?;
        let device = sparse_device.device();
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);

        // Sparse multisampled image create info
        let image_sparse_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_RESIDENCY | vk::ImageCreateFlags::SPARSE_BINDING)
            .image_type(vk::ImageType::_2D)
            .format(params.format)
            .extent(extent_of(params.img_size))
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::from_bits_truncate(params.sample_count))
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        // Check if device supports sparse operations for image format
        if !check_sparse_support_for_image_format(instance, physical_device, &image_sparse_info) {
            return Err(TestError::NotSupported(
                "The image format does not support sparse operations".to_string(),
            ));
        }

        let format_description = format_description(params.format);

        // Create sparse image
        let ms_sparse_image = Unique::new(
            device,
            unsafe { device.create_image(&image_sparse_info, None) }.vk_check("vkCreateImage")?,
        );

        // Sparse binding semaphore
        let sparse_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        // Get sparse Memory requirements
        let sparse_mem_requirements = unsafe { device.get_image_memory_requirements(*ms_sparse_image) };

        // Check if required image memory size does not exceed device limits
        if sparse_mem_requirements.size
            > unsafe { instance.get_physical_device_properties(physical_device) }
                .limits
                .sparse_address_space_size
        {
            return Err(TestError::NotSupported(
                "Required memory size for sparse resource exceeds device limits".to_string(),
            ));
        }

        assert!(sparse_mem_requirements.size % sparse_mem_requirements.alignment == 0);

        // Get sparse image memory requirements
        let sparse_image_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(*ms_sparse_image) };
        assert!(sparse_image_memory_requirements.len() == 1);

        let img_granularity = sparse_image_memory_requirements[0].format_properties.image_granularity;
        let plane_extent = get_plane_extent(&format_description, image_sparse_info.extent, 0, 0);
        let full_num_sparse_binds = aligned_divide(plane_extent, img_granularity);
        // We do not bind lowest row of tiles
        let num_sparse_binds = [
            full_num_sparse_binds[0],
            full_num_sparse_binds[1] - 1,
            full_num_sparse_binds[2],
        ];

        // Binding partially resident sparse image
        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();
        {
            let memory_type = find_matching_memory_type(
                instance,
                physical_device,
                &sparse_mem_requirements,
                MemoryRequirement::ANY,
            );

            if memory_type == NO_MATCH_FOUND {
                return Ok(TestStatus::fail("No matching memory type found"));
            }

            let mut image_residency_memory_binds = Vec::new();
            for z in 0..num_sparse_binds[2] {
                for y in 0..num_sparse_binds[1] {
                    for x in 0..num_sparse_binds[0] {
                        let extent = img_granularity;
                        let offset = vk::Offset3D {
                            x: (x * extent.width) as i32,
                            y: (y * extent.height) as i32,
                            z: (z * extent.depth) as i32,
                        };

                        let image_memory_bind = make_sparse_image_memory_bind(
                            device,
                            sparse_mem_requirements.alignment,
                            memory_type,
                            vk::ImageSubresource {
                                aspect_mask: vk::ImageAspectFlags::COLOR,
                                mip_level: 0,
                                array_layer: 0,
                            },
                            offset,
                            extent,
                        )?;
                        device_memory.push(Unique::new(device, image_memory_bind.memory));
                        image_residency_memory_binds.push(image_memory_bind);
                    }
                }
            }

            let sparse_image_memory_bind_info = [vk::SparseImageMemoryBindInfo::builder()
                .image(*ms_sparse_image)
                .binds(&image_residency_memory_binds)
                .build()];
            let signal_semaphores = [*sparse_bind_semaphore];
            let bind_sparse_info = vk::BindSparseInfo::builder()
                .image_binds(&sparse_image_memory_bind_info)
                .signal_semaphores(&signal_semaphores);

            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;

            // Create sparse command pool and command buffer for empty submission
            let sparse_cmd_pool = make_command_pool(device, sparse_queue.family_index)?;
            let sparse_cmd_buffer = allocate_command_buffer(device, *sparse_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            // Empty cmd buffer for submission
            begin_command_buffer(device, *sparse_cmd_buffer)?;
            end_command_buffer(device, *sparse_cmd_buffer)?;
            submit_commands_and_wait(
                device,
                sparse_queue.handle,
                *sparse_cmd_buffer,
                &[*sparse_bind_semaphore],
                &[vk::PipelineStageFlags::BOTTOM_OF_PIPE],
                &[],
            )?;
            unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;
        }

        // Create sparse image view
        let ms_sparse_image_view = make_image_view(
            device,
            *ms_sparse_image,
            vk::ImageViewType::_2D,
            params.format,
            image_srr(),
        )?;

        // Create "resolve" image
        let result_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(vk::Format::R32_UINT)
            .extent(extent_of(params.img_size))
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let result_image = ImageWithMemory::new(
            device,
            sparse_device.allocator(),
            result_image_info,
            MemoryRequirement::ANY,
        )?;

        // Create result image view
        let result_image_view = make_image_view(
            device,
            result_image.get(),
            vk::ImageViewType::_2D,
            vk::Format::R32_UINT,
            image_srr(),
        )?;

        // Create result buffer
        let result_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                calculate_buffer_size(params.img_size) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create descriptor set layout
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // Create descriptor pool
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        // Create and write descriptor set
        let ms_img_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *ms_sparse_image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let result_img_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *result_image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&ms_img_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&result_img_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Create compute pipeline
        let mut pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("compute")?,
        );
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.build_pipeline()?;

        // Create command pool and command buffer
        let cmd_pool = make_command_pool(device, compute_queue.family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Recording commands
        begin_command_buffer(device, cmd)?;

        let barrier = |src_stage: vk::PipelineStageFlags,
                       dst_stage: vk::PipelineStageFlags,
                       image_barrier: vk::ImageMemoryBarrier| unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
        };

        // Pre clear barriers
        barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                result_image.get(),
                image_srr(),
            ),
        );

        // Clearing images
        let init_one_value = vk::ClearColorValue { uint32: [1, 1, 1, 1] };
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                result_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &init_one_value,
                &[image_srr()],
            )
        };

        // Pre read barrier
        barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                *ms_sparse_image,
                image_srr(),
            ),
        );

        // Pre write barrier
        barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                result_image.get(),
                image_srr(),
            ),
        );

        // Binding pipeline and resources
        pipeline.bind(cmd);
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        // Dispatch
        unsafe { device.cmd_dispatch(cmd, params.img_size[0], params.img_size[1], params.img_size[2]) };

        // Post write barrier
        barrier(
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_image.get(),
                image_srr(),
            ),
        );

        // Copy result image to buffer
        let cpy_info = [vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: extent_of(params.img_size),
        }];
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                result_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_buffer.get(),
                &cpy_info,
            )
        };

        end_command_buffer(device, cmd)?;

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(device, compute_queue.handle, cmd, &[], &[], &[])?;

        // Retrieve data from buffer to host memory
        invalidate_alloc(device, result_buffer.get_allocation())?;

        // Wait for compute queue to become idle
        unsafe { device.queue_wait_idle(compute_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        let elem_cnt = get_elem_count(params.img_size) as usize;
        let out = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                elem_cnt,
            )
        };

        let non_zero_elem_cnt = (num_sparse_binds[0] * img_granularity.width)
            * (num_sparse_binds[1] * img_granularity.height)
            * (num_sparse_binds[2] * img_granularity.depth);

        let passed = out.iter().enumerate().all(|(ndx, &value)| {
            if (ndx as u32) < non_zero_elem_cnt {
                value == params.sample_count
            } else {
                value == 0
            }
        });

        drop(device_memory);
        Ok(if passed {
            TestStatus::pass("Passed")
        } else {
            TestStatus::fail("Failed")
        })
    }
}

/// `createSparseResourcesMultisampledImageSparseResidencyTests`
pub fn create_multisampled_image_sparse_residency_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("multisampled_image_sparse_residency");

    use vk::Format as F;
    const FORMATS: [vk::Format; 11] = [
        F::R32G32B32A32_SFLOAT,
        F::R16G16B16A16_SFLOAT,
        F::R32_SFLOAT,
        F::R32G32B32A32_UINT,
        F::R16G16B16A16_UINT,
        F::R8G8B8A8_UINT,
        F::R32_UINT,
        F::R32G32B32A32_SINT,
        F::R16G16B16A16_SINT,
        F::R8G8B8A8_SINT,
        F::R32_SINT,
    ];
    const SAMPLES: [u32; 4] = [2, 4, 8, 16];

    for format in FORMATS {
        let mut format_group = TestCaseGroup::new(get_image_format_id(format));

        for sample_count in SAMPLES {
            let samples_case_name = format!("samples_{sample_count}");

            let params = TestParams {
                format,
                sample_count,
                img_size: [256, 512, 1],
            };

            format_group.add_child(Box::new(MultisampledImageSparseResidencyCase {
                name: samples_case_name,
                params,
            }) as Box<dyn TestCase>);
        }

        test_group.add_child(format_group);
    }

    test_group
}
