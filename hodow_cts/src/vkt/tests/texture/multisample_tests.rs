// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/texture/multisample/{atomic,invalidsampleindex}/*.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber compute pipeline does for these scripts is done directly: the multisampled `texture` at binding 0 and
// the 8 bit `result` image at binding 1 as storage images in the general layout, one dispatch, and the check that every pixel of `result` is green. The scripts
// are read by `scripts/gen_texture_multisample_amber.py`, which writes the shaders and `multisample_cases.rs`; the r64 cases (`shaderImageInt64Atomics`) run on a `RobustnessDevice` with it enabled.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::multisample_cases::MULTISAMPLE_CASES;
use crate::generated::shaders::texture_multisample::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// One Amber script of `texture.multisample`
pub struct MultisampleCase {
    pub group: &'static str,
    pub name: &'static str,
    pub key: &'static str,
    pub format: vk::Format,
    pub size: (u32, u32),
    pub samples: u32,
    pub dispatch: (u32, u32, u32),
    /// The atomic cases need the format's atomic storage image feature
    pub atomic: bool,
    pub stub: Option<&'static str>,
}

struct MultisampleTestCase {
    data: &'static MultisampleCase,
}

impl TestCase for MultisampleTestCase {
    fn name(&self) -> &str {
        self.data.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let data = self.data;
        if context.get_device_features().shader_storage_image_multisample == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderStorageImageMultisample not supported".to_string(),
            ));
        }
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        if is_r64(data.format) {
            if context.get_device_features().shader_int64 == vk::FALSE {
                return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
            }
            let mut image_atomic_int64_features = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut image_atomic_int64_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if image_atomic_int64_features.shader_image_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderImageInt64Atomics is not supported".to_string(),
                ));
            }
        }
        let properties = unsafe { instance.get_physical_device_format_properties(physical_device, data.format) };
        let mut required = vk::FormatFeatureFlags::STORAGE_IMAGE;
        if data.atomic {
            required |= vk::FormatFeatureFlags::STORAGE_IMAGE_ATOMIC;
        }
        if !properties.optimal_tiling_features.contains(required) {
            return Err(TestError::NotSupported(format!(
                "{:?} does not support {required:?}",
                data.format
            )));
        }
        let image_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                data.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::STORAGE,
                vk::ImageCreateFlags::empty(),
            )
        };
        match image_properties {
            Ok(properties) if properties.sample_counts.bits() & data.samples != 0 => Ok(()),
            _ => Err(TestError::NotSupported(format!(
                "{} samples not supported for {:?} storage images",
                data.samples, data.format
            ))),
        }
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.data.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleInstance {
            context,
            data: self.data,
        })
    }

    fn is_stub(&self) -> bool {
        self.data.stub.is_some()
    }
}

struct MultisampleInstance<'a> {
    context: &'a Context<'a>,
    data: &'static MultisampleCase,
}

fn is_r64(format: vk::Format) -> bool {
    format == vk::Format::R64_SINT || format == vk::Format::R64_UINT
}

fn storage_image<'a>(
    context: &'a Context<'_>,
    device: &'a Device,
    format: vk::Format,
    size: (u32, u32),
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(device, context.get_default_allocator(), info, MemoryRequirement::ANY)
}

impl TestInstance for MultisampleInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let data = self.data;
        if let Some(reason) = data.stub {
            return Err(TestError::NotPorted(reason.to_string()));
        }
        let context = self.context;
        let robust_device = if is_r64(data.format) {
            Some(RobustnessDevice::new(
                context.get_instance(),
                context.get_physical_device(),
                context.get_universal_queue_family_index(),
                RobustnessFeatures {
                    shader_image_int64_atomics: true,
                    ..Default::default()
                },
            )?)
        } else {
            None
        };
        let device = robust_device
            .as_ref()
            .map_or_else(|| context.get_device(), RobustnessDevice::device);
        let queue = robust_device
            .as_ref()
            .map_or_else(|| context.get_universal_queue(), RobustnessDevice::queue);
        let (width, height) = data.size;
        let samples = vk::SampleCountFlags::from_bits_truncate(data.samples);
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let texture = storage_image(
            context,
            device,
            data.format,
            data.size,
            samples,
            vk::ImageUsageFlags::STORAGE,
        )?;
        let texture_view = make_image_view(device, texture.get(), vk::ImageViewType::_2D, data.format, range)?;
        let result = storage_image(
            context,
            device,
            vk::Format::R8G8B8A8_UNORM,
            data.size,
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let result_view = make_image_view(
            device,
            result.get(),
            vk::ImageViewType::_2D,
            vk::Format::R8G8B8A8_UNORM,
            range,
        )?;
        let result_size = (width * height * 4) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(result_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 1, 1)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_infos = [
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *texture_view,
                image_layout: vk::ImageLayout::GENERAL,
            },
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *result_view,
                image_layout: vk::ImageLayout::GENERAL,
            },
        ];
        let writes: Vec<vk::WriteDescriptorSet> = image_infos
            .iter()
            .enumerate()
            .map(|(binding, info)| vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: binding as u32,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                image_info: info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            let to_general = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    texture.get(),
                    range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    result.get(),
                    range,
                ),
            ];
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &to_general,
            );

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, data.dispatch.0, data.dispatch.1, data.dispatch.2);

            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                result.get(),
                range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            let copy = vk::BufferImageCopy {
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
                image_extent: vk::Extent3D {
                    width,
                    height,
                    depth: 1,
                },
            };
            device.cmd_copy_image_to_buffer(
                cmd,
                result.get(),
                vk::ImageLayout::GENERAL,
                result_buffer.get(),
                &[copy],
            );
            let to_host = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                result_buffer.get(),
                0,
                vk::WHOLE_SIZE,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[to_host],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr().cast_const(),
                result_size as usize,
            )
        };
        // EXPECT result IDX 0 0 SIZE w h EQ_RGBA 0 255 0 255
        for (ndx, pixel) in pixels.chunks_exact(4).enumerate() {
            if pixel != [0, 255, 0, 255] {
                log::error!(
                    "Probe failed at ({}, {}): expected [0, 255, 0, 255], got {pixel:?}",
                    ndx as u32 % width,
                    ndx as u32 / width
                );
                return Ok(TestStatus::fail("Probe failed"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `dEQP-VK.texture.multisample`
pub fn create_multisample_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample");
    for group_name in ["atomic", "invalid_sample_index"] {
        let mut sub_group = TestCaseGroup::new(group_name);
        for data in MULTISAMPLE_CASES.iter().filter(|data| data.group == group_name) {
            sub_group.add_child(Box::new(MultisampleTestCase { data }) as Box<dyn TestCase>);
        }
        group.add_child(sub_group);
    }
    group
}
