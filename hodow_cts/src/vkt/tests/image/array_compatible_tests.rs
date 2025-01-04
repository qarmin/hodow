// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImage2dArrayCompatibleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. vulkanalia has no bindings for VkImageCreateFlags2CreateInfoKHR /
// VkImageUsageFlags2CreateInfoKHR (the `extended_*` cases), so both are declared here. The per-byte mismatch log is reduced to
// the verdict.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::image_2d_array_compatible::ALL_ARRAY_COMPATIBLE_PROGRAMS;
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::image::concurrent_copy_tests::fill_random_no_nan;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const STRUCTURE_TYPE_IMAGE_CREATE_FLAGS_2_CREATE_INFO_KHR: i32 = 1_000_668_001;
const STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR: i32 = 1_000_668_002;

#[repr(C)]
#[derive(Clone, Copy)]
struct ImageCreateFlags2CreateInfoKHR {
    s_type: vk::StructureType,
    next: *const std::ffi::c_void,
    flags: u64,
}

#[repr(C)]
#[derive(Clone, Copy)]
struct ImageUsageFlags2CreateInfoKHR {
    s_type: vk::StructureType,
    next: *const std::ffi::c_void,
    usage: u64,
}

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const WIDTH: u32 = 32;
const HEIGHT: u32 = 32;

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct ArrayCompatiblePrograms {
    pub name: &'static str,
    pub view: &'static str,
    pub second: u32,
    pub total: u32,
    pub programs: BinaryCollection,
}

/// `TestParameters`
#[derive(Clone, Copy)]
struct TestParameters {
    first_layer: u32,
    second_layer: u32,
    total_layers: u32,
    tiling: vk::ImageTiling,
    image_view_type: vk::ImageViewType,
    extended_create_flags: bool,
    extended_usage_flags: bool,
}

impl TestParameters {
    fn extended_flags(&self) -> bool {
        self.extended_create_flags || self.extended_usage_flags
    }
}

/// The usage flags the image is created with and queried for.
fn image_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED
}

struct ArrayCompatibleTestCase {
    name: String,
    params: TestParameters,
}

impl TestCase for ArrayCompatibleTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_maintenance9")?;

        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                FORMAT,
                vk::ImageType::_3D,
                self.params.tiling,
                image_usage(),
                vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE,
            )
        };
        if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
            return Err(TestError::NotSupported("Image format not supported.".to_string()));
        }

        if self.params.image_view_type == vk::ImageViewType::_2D {
            context.require_device_functionality("VK_EXT_image_2d_view_of_3d")?;

            let mut view_features = vk::PhysicalDeviceImage2DViewOf3DFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut view_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if view_features.sampler_2d_view_of_3d == vk::FALSE {
                return Err(TestError::NotSupported("sampler2DViewOf3D not supported.".to_string()));
            }
        }

        if self.params.extended_flags() {
            context.require_device_functionality("VK_KHR_extended_flags")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        let is_3d = params.image_view_type == vk::ImageViewType::_3D;
        let (view, second, total) = if is_3d {
            ("3d", params.second_layer, params.total_layers)
        } else {
            ("2d", 0, 0)
        };
        ALL_ARRAY_COMPATIBLE_PROGRAMS
            .iter()
            .find(|p| p.view == view && p.second == second && p.total == total)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ArrayCompatibleTestInstance {
            context,
            params: self.params,
        })
    }
}

struct ArrayCompatibleTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

fn make_subresource_range(base: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, base, 1)
}

fn make_subresource_layers(base: u32) -> vk::ImageSubresourceLayers {
    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, base, 1)
}

fn image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        )
    };
}

impl ArrayCompatibleTestInstance<'_> {
    /// `transitionUnusedLayers`
    fn transition_unused_layers(&self, device: &Device, cmd: vk::CommandBuffer, image: vk::Image) {
        for i in 0..self.params.total_layers {
            if i != self.params.first_layer && i != self.params.second_layer {
                let barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image,
                    make_subresource_range(i),
                );
                image_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    &[barrier],
                );
            }
        }
    }

    /// `transitionAllLayers`
    fn transition_all_layers(
        &self,
        device: &Device,
        cmd: vk::CommandBuffer,
        image: vk::Image,
        layout: vk::ImageLayout,
    ) {
        for i in 0..self.params.total_layers {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                layout,
                image,
                make_subresource_range(i),
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                &[barrier],
            );
        }
    }

    fn run(&self) -> TestOutcome {
        let params = &self.params;
        let context = self.context;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        let extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: params.total_layers,
        };
        let copy_extent = vk::Extent3D {
            width: extent.width,
            height: extent.height,
            depth: 1,
        };

        let mut create_flags = vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE;
        if params.image_view_type == vk::ImageViewType::_2D {
            create_flags |= vk::ImageCreateFlags::_2D_VIEW_COMPATIBLE_EXT;
        }

        let mut usage_flags = image_usage();
        let mut next: *const std::ffi::c_void = std::ptr::null();
        let create_flags2 = ImageCreateFlags2CreateInfoKHR {
            s_type: vk::StructureType::from_raw(STRUCTURE_TYPE_IMAGE_CREATE_FLAGS_2_CREATE_INFO_KHR),
            next: std::ptr::null(),
            flags: u64::from(create_flags.bits()),
        };
        let usage_flags2 = ImageUsageFlags2CreateInfoKHR {
            s_type: vk::StructureType::from_raw(STRUCTURE_TYPE_IMAGE_USAGE_FLAGS_2_CREATE_INFO_KHR),
            next: std::ptr::null(),
            usage: u64::from(usage_flags.bits()),
        };
        let mut create_flags2_chained = create_flags2;
        let mut usage_flags2_chained = usage_flags2;
        if params.extended_create_flags {
            create_flags2_chained.next = next;
            next = std::ptr::addr_of!(create_flags2_chained).cast();
            create_flags = vk::ImageCreateFlags::empty();
        }
        if params.extended_usage_flags {
            usage_flags2_chained.next = next;
            next = std::ptr::addr_of!(usage_flags2_chained).cast();
            usage_flags = vk::ImageUsageFlags::empty();
        }

        let mut image_create_info = vk::ImageCreateInfo::builder()
            .flags(create_flags)
            .image_type(vk::ImageType::_3D)
            .format(FORMAT)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(params.tiling)
            .usage(usage_flags)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        image_create_info.next = next;
        let image = ImageWithMemory::new(device, alloc, image_create_info, MemoryRequirement::ANY)?;
        let image_handle = image.get();

        let image_view_subresource_range = if params.image_view_type == vk::ImageViewType::_3D {
            make_subresource_range(0)
        } else {
            make_subresource_range(params.second_layer)
        };
        let image_view_create_info = vk::ImageViewCreateInfo::builder()
            .image(image_handle)
            .view_type(params.image_view_type)
            .format(FORMAT)
            .components(vk::ComponentMapping {
                r: vk::ComponentSwizzle::R,
                g: vk::ComponentSwizzle::G,
                b: vk::ComponentSwizzle::B,
                a: vk::ComponentSwizzle::A,
            })
            .subresource_range(image_view_subresource_range);
        let sampled_image_view = Unique::new(
            device,
            unsafe { device.create_image_view(&image_view_create_info, None) }.vk_check("vkCreateImageView")?,
        );

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let pixel_size = 4u32;
        let layer_size = extent.width * extent.height * pixel_size;
        let ssbo_size = layer_size * 4;
        let src_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(layer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let dst_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                layer_size as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let ssbo = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(ssbo_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut test_data = vec![0u8; layer_size as usize];
        let mut random_gen = Random::new(de_int32_hash(params.tiling.as_raw()));
        fill_random_no_nan(&mut random_gen, &mut test_data, FORMAT);

        let src_buffer_alloc = src_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(test_data.as_ptr(), src_buffer_alloc.get_host_ptr(), layer_size as usize)
        };
        flush_alloc(device, src_buffer_alloc)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::COMPUTE,
            )
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let sampler_params = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(0.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(1000.0) // VK_LOD_CLAMP_NONE
            .border_color(vk::BorderColor::FLOAT_OPAQUE_WHITE)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_params, None) }.vk_check("vkCreateSampler")?,
        );

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_image_info = [vk::DescriptorImageInfo::builder()
            .sampler(*sampler)
            .image_view(*sampled_image_view)
            .image_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
            .build()];
        let descriptor_buffer_info = [vk::DescriptorBufferInfo::builder()
            .buffer(ssbo.get())
            .offset(0)
            .range(vk::WHOLE_SIZE)
            .build()];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&descriptor_image_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&descriptor_buffer_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let binaries = context.get_binary_collection();
        let cs = create_shader_module(device, binaries.get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*cs)
            .name(b"main\0")
            .build();
        let pipeline_create_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let compute_pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_create_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let is_3d_view = params.image_view_type == vk::ImageViewType::_3D;

        begin_command_buffer(device, cmd)?;
        {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image_handle,
                make_subresource_range(params.first_layer),
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                &[barrier],
            );

            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_subresource_layers(0),
                image_offset: vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: params.first_layer as i32,
                },
                image_extent: copy_extent,
            };
            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd,
                    src_buffer.get(),
                    image_handle,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[region],
                )
            };
        }
        self.transition_unused_layers(device, cmd, image_handle);
        {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    image_handle,
                    make_subresource_range(params.first_layer),
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    image_handle,
                    make_subresource_range(params.second_layer),
                ),
            ];
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                &barriers,
            );

            let region = vk::ImageCopy {
                src_subresource: make_subresource_layers(0),
                src_offset: vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: params.first_layer as i32,
                },
                dst_subresource: make_subresource_layers(0),
                dst_offset: vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: params.second_layer as i32,
                },
                extent: copy_extent,
            };
            unsafe {
                device.cmd_copy_image(
                    cmd,
                    image_handle,
                    vk::ImageLayout::GENERAL,
                    image_handle,
                    vk::ImageLayout::GENERAL,
                    &[region],
                )
            };
        }
        self.transition_unused_layers(device, cmd, image_handle);
        if is_3d_view {
            self.transition_all_layers(device, cmd, image_handle, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL);
        }

        {
            let previous_layout = if is_3d_view {
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
            } else {
                vk::ImageLayout::GENERAL
            };

            let barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                previous_layout,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                image_handle,
                make_subresource_range(params.second_layer),
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                &[barrier],
            );

            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, compute_pipeline.get());
                device.cmd_dispatch(cmd, extent.width, extent.height, 1);
            }
        }
        self.transition_unused_layers(device, cmd, image_handle);
        {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image_handle,
                make_subresource_range(params.second_layer),
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                &[barrier],
            );

            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_subresource_layers(0),
                image_offset: vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: params.second_layer as i32,
                },
                image_extent: vk::Extent3D {
                    width: extent.width,
                    height: extent.height,
                    depth: 1,
                },
            };
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image_handle,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    dst_buffer.get(),
                    &[region],
                )
            };
        }
        self.transition_unused_layers(device, cmd, image_handle);

        let buffer_memory_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            dst_buffer.get(),
            0,
            layer_size as vk::DeviceSize,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER | vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_memory_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let dst_buffer_alloc = dst_buffer.get_allocation();
        let ssbo_alloc = ssbo.get_allocation();
        invalidate_alloc(device, dst_buffer_alloc)?;
        invalidate_alloc(device, ssbo_alloc)?;
        let src = unsafe { std::slice::from_raw_parts(src_buffer_alloc.get_host_ptr(), layer_size as usize) };
        let dst = unsafe { std::slice::from_raw_parts(dst_buffer_alloc.get_host_ptr(), layer_size as usize) };
        if src != dst {
            return Ok(TestStatus::fail("Fail"));
        }

        let ssbo_values =
            unsafe { std::slice::from_raw_parts(ssbo_alloc.get_host_ptr().cast::<f32>(), layer_size as usize) };
        for (&src_byte, &ssbo_value) in src.iter().zip(ssbo_values) {
            let src_value = src_byte as f32;
            let ssbo_value = ssbo_value * 256.0;
            let epsilon = 1.0f32;
            if (src_value - ssbo_value).abs() > epsilon {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for ArrayCompatibleTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `createImage2dArrayCompatibleTests`
pub fn create_image_2d_array_compatible_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("2d_array_compatible");

    // (first, second, total, extended create flags, extended usage flags, name)
    let tests = [
        (0u32, 1u32, 8u32, false, false, "0_1_8"),
        (3, 7, 16, false, false, "3_7_16"),
        (3, 4, 5, false, false, "3_4_5"),
        (0, 1, 8, true, false, "extended_create"),
        (0, 1, 8, false, true, "extended_usage"),
        (0, 1, 8, true, true, "extended_create_usage"),
    ];
    let tiling_tests = [
        (vk::ImageTiling::LINEAR, "linear"),
        (vk::ImageTiling::OPTIMAL, "optimal"),
    ];
    let image_view_type_tests = [(vk::ImageViewType::_2D, "2d"), (vk::ImageViewType::_3D, "3d")];

    for (first, second, total, extended_create_flags, extended_usage_flags, test_name) in tests {
        let mut test_layer_group = TestCaseGroup::new(test_name);
        for (tiling, tiling_name) in tiling_tests {
            let mut tiling_group = TestCaseGroup::new(tiling_name);
            for (image_view_type, view_name) in image_view_type_tests {
                let params = TestParameters {
                    first_layer: first,
                    second_layer: second,
                    total_layers: total,
                    tiling,
                    image_view_type,
                    extended_create_flags,
                    extended_usage_flags,
                };
                tiling_group.add_child(Box::new(ArrayCompatibleTestCase {
                    name: view_name.to_string(),
                    params,
                }) as Box<dyn TestCase>);
            }
            test_layer_group.add_child(tiling_group);
        }
        test_group.add_child(test_layer_group);
    }

    test_group
}
