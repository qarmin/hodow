// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/descriptor_indexing/vktDescriptorIndexingMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/descriptor_indexing_misc.toml. The reference of the
// non-uniform index cases is computed from the known texel values rather than read back from the colour buffers: every texel of one
// image holds the same value, which is what `getColor` returns for any coordinate.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::descriptor_indexing_misc::{
    ALL_NON_UNIFORM_PROGRAMS, NON_UNIFORM_ATOMICS, VARIABLE_COUNT,
};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NUM_ARRAYS: u32 = 3;

/// The `rust_type` of the non-uniform index manifest entries: the compute shader of one (array size, coordinate) pair.
#[derive(Clone, Copy)]
pub struct NonUniformPrograms {
    pub name: &'static str,
    pub array_size: u32,
    pub coord: &'static str,
    pub programs: BinaryCollection,
}

/// `makeSampler`
fn make_sampler(device: &Device) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::ALWAYS)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

/// `vk::copyBufferToImage`, narrowed to one region of the whole image: UNDEFINED -> TRANSFER_DST, copy, then TRANSFER_DST -> `final_layout`.
fn copy_buffer_to_image(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    buffer: vk::Buffer,
    image: vk::Image,
    extent: vk::Extent3D,
    final_layout: vk::ImageLayout,
    dst_stage: vk::PipelineStageFlags,
) {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let pre_copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        range,
    );
    let post_copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::SHADER_READ,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        final_layout,
        image,
        range,
    );
    let region = make_buffer_image_copy(
        extent,
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );
        device.cmd_copy_buffer_to_image(
            cmd_buffer,
            buffer,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[region],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_copy_barrier],
        );
    }
}

/// `CommonNonUniformDescriptorIndexTestCase`
struct CommonNonUniformDescriptorIndexTestCase {
    name: String,
    format: vk::Format,
    num_elements_per_array: u32,
    coordinate: &'static str,
}

impl TestCase for CommonNonUniformDescriptorIndexTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        context.require_device_functionality("VK_EXT_descriptor_indexing")?;

        let mut indexing_features = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
        }
        if indexing_features.runtime_descriptor_array == vk::FALSE {
            return Err(TestError::NotSupported(
                "runtimeDescriptorArray is not supported.".to_string(),
            ));
        }
        if indexing_features.shader_sampled_image_array_non_uniform_indexing == vk::FALSE {
            return Err(TestError::NotSupported(
                "Non-uniform indexing over sampled image descriptor arrays is not supported.".to_string(),
            ));
        }

        let max_per_stage_descriptor_sampled_images = context
            .get_device_properties()
            .limits
            .max_per_stage_descriptor_sampled_images;
        let num_sampled_images = NUM_ARRAYS * self.num_elements_per_array;
        if num_sampled_images > max_per_stage_descriptor_sampled_images {
            return Err(TestError::NotSupported("Too many per stage descriptors.".to_string()));
        }

        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                self.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED,
                vk::ImageCreateFlags::empty(),
            )
        };
        if let Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) = result {
            return Err(TestError::NotSupported(
                "Image format is not supported for required usage".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_NON_UNIFORM_PROGRAMS
            .iter()
            .find(|p| p.array_size == self.num_elements_per_array && p.coord == self.coordinate)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CommonNonUniformDescriptorIndexTestInstance {
            context,
            num_elements_per_array: self.num_elements_per_array,
            format: self.format,
        })
    }
}

struct CommonNonUniformDescriptorIndexTestInstance<'a> {
    context: &'a Context<'a>,
    num_elements_per_array: u32,
    format: vk::Format,
}

impl TestInstance for CommonNonUniformDescriptorIndexTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();

        let format = self.format;
        let num_arrays = NUM_ARRAYS as usize;
        let num_elements_per_array = self.num_elements_per_array;
        let elements = num_elements_per_array as usize;
        let num_elements_total = num_arrays * elements;

        let sampled_image_usage = vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED;
        let sampled_image_size = num_elements_per_array;
        let sampled_image_layout = vk::ImageLayout::GENERAL;
        let pixel_count = (sampled_image_size * sampled_image_size) as usize;

        // Create sampled images, one per element of every array.
        let mut sampled_images = Vec::with_capacity(num_elements_total);
        for _ in 0..num_elements_total {
            let create_info = make_image_create_info(
                IVec2::new(sampled_image_size as i32, sampled_image_size as i32),
                format,
                sampled_image_usage,
            );
            sampled_images.push(ImageWithMemory::new(
                device,
                allocator,
                create_info,
                MemoryRequirement::ANY,
            )?);
        }

        // Initialize the colour buffers for the sampled images: every texel of buffer `i` is (128 + i, 128, 128, 255).
        let mut color_buffers = Vec::with_capacity(num_elements_total);
        for elem_idx in 0..num_elements_total {
            let mut data: Vec<u32> = Vec::with_capacity(pixel_count * 4);
            for _ in 0..pixel_count {
                data.extend_from_slice(&[128 + elem_idx as u32, 128, 128, 255]);
            }
            color_buffers.push(create_host_buffer(
                context,
                &data,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
            )?);
        }

        // Output data buffer, initialized with 0xFF.
        let out_buffer_size_bytes = (std::mem::size_of::<[u32; 4]>() * elements) as vk::DeviceSize;
        let out_buffer = create_host_buffer(
            context,
            &vec![0xFFu8; out_buffer_size_bytes as usize],
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
        )?;

        // Corresponding image views.
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let mut sampled_image_views = Vec::with_capacity(num_elements_total);
        for image in &sampled_images {
            sampled_image_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                format,
                color_subresource_range,
            )?);
        }

        // Create the single sampler.
        let sampler = make_sampler(device)?;

        // Descriptor set layout for each input sampled image array.
        let desc_stage_mask = vk::ShaderStageFlags::COMPUTE;
        let num_desc_sets = num_arrays + 1;
        let mut input_layouts = Vec::with_capacity(num_arrays);
        for _ in 0..num_arrays {
            input_layouts.push(
                DescriptorSetLayoutBuilder::new()
                    .add_indexed_binding(
                        vk::DescriptorType::SAMPLED_IMAGE,
                        desc_stage_mask,
                        0,
                        num_elements_per_array,
                    )
                    .build(device)?,
            );
        }
        let other_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, desc_stage_mask)
            .add_indexed_sampler_binding(vk::DescriptorType::SAMPLER, desc_stage_mask, 1, &[*sampler])
            .build(device)?;

        // Descriptor pool.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::SAMPLED_IMAGE, num_elements_total as u32)
            .add_type(vk::DescriptorType::SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                num_desc_sets as u32,
            )?;

        // Descriptor sets.
        let mut descriptor_set_ptrs: Vec<UniqueDescriptorSet<'_>> = Vec::with_capacity(num_desc_sets);
        for layout in &input_layouts {
            descriptor_set_ptrs.push(make_descriptor_set(device, *descriptor_pool, layout.get())?);
        }
        descriptor_set_ptrs.push(make_descriptor_set(device, *descriptor_pool, other_layout.get())?);

        // Register and write the descriptors.
        let sampled_image_array_desc_infos: Vec<vk::DescriptorImageInfo> = sampled_image_views
            .iter()
            .map(|view| vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: view.get(),
                image_layout: sampled_image_layout,
            })
            .collect();
        let out_descriptor_info = make_descriptor_buffer_info(out_buffer.get(), 0, out_buffer_size_bytes);

        let mut writes = Vec::with_capacity(num_desc_sets);
        for array_idx in 0..num_arrays {
            let offset = array_idx * elements;
            writes.push(vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set_ptrs[array_idx].get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: num_elements_per_array,
                descriptor_type: vk::DescriptorType::SAMPLED_IMAGE,
                image_info: sampled_image_array_desc_infos[offset..].as_ptr(),
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            });
        }
        writes.push(vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set_ptrs[num_desc_sets - 1].get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: &out_descriptor_info,
            texel_buffer_view: std::ptr::null(),
        });
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Command pool and command buffer.
        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer_ptr = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let command_buffer = command_buffer_ptr.get();

        // Combine all descriptor set layouts and sets.
        let mut descriptor_set_layouts: Vec<vk::DescriptorSetLayout> =
            input_layouts.iter().map(|layout| layout.get()).collect();
        descriptor_set_layouts.push(other_layout.get());
        let descriptor_sets: Vec<vk::DescriptorSet> = descriptor_set_ptrs.iter().map(|set| set.get()).collect();

        let pipeline_layout = make_pipeline_layout(device, &descriptor_set_layouts)?;

        // Compute pipeline.
        let compute_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_module)
            .name(c"main".to_bytes_with_nul());
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        begin_command_buffer(device, command_buffer)?;
        unsafe { device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline) };

        // Copy all buffers to images to initialize them.
        let extent = vk::Extent3D {
            width: sampled_image_size,
            height: sampled_image_size,
            depth: 1,
        };
        for idx in 0..num_elements_total {
            copy_buffer_to_image(
                device,
                command_buffer,
                color_buffers[idx].get(),
                sampled_images[idx].get(),
                extent,
                sampled_image_layout,
                vk::PipelineStageFlags::COMPUTE_SHADER,
            );
        }

        // Output buffer barrier (pre).
        let out_buffer_pre_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_WRITE,
            out_buffer.get(),
            0,
            out_buffer_size_bytes,
        );
        let out_buffer_post_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            out_buffer.get(),
            0,
            out_buffer_size_bytes,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[out_buffer_pre_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_bind_descriptor_sets(
                command_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &descriptor_sets,
                &[] as &[u32],
            );
            device.cmd_dispatch(command_buffer, 1, 1, 1);
            // Output buffer barrier (post).
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[out_buffer_post_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, command_buffer)?;
        submit_commands_and_wait(device, queue, command_buffer)?;

        let out_buffer_alloc = out_buffer.get_allocation();
        invalidate_alloc(device, out_buffer_alloc)?;

        // Validate results: `a * b + c` over the three arrays, per component.
        let out_buffer_ptr = out_buffer_alloc.get_host_ptr().cast::<[u32; 4]>();
        for data_idx in 0..elements {
            let color_of =
                |array_idx: usize| -> [u32; 4] { [128 + (array_idx * elements + data_idx) as u32, 128, 128, 255] };
            let (a, b, c) = (color_of(0), color_of(1), color_of(2));
            let reference: [u32; 4] = std::array::from_fn(|i| a[i].wrapping_mul(b[i]).wrapping_add(c[i]));
            let result = unsafe { out_buffer_ptr.add(data_idx).read_unaligned() };
            if reference != result {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `MiscVariableCountTestCase`
struct MiscVariableCountTestCase {
    name: &'static str,
}

impl TestCase for MiscVariableCountTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_descriptor_indexing")?;

        let mut indexing_features = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if indexing_features.descriptor_binding_partially_bound == vk::FALSE {
            return Err(TestError::NotSupported(
                "descriptorBindingPartiallyBound not supported".to_string(),
            ));
        }
        if indexing_features.descriptor_binding_variable_descriptor_count == vk::FALSE {
            return Err(TestError::NotSupported(
                "descriptorBindingVariableDescriptorCount not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        VARIABLE_COUNT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscVariableCountTestInstance { context })
    }
}

struct MiscVariableCountTestInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MiscVariableCountTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();

        let combined_image_sampler_count = 8u32;
        let allocated_descriptor_count = 2u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let render_size = 16u32;
        let texture_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, combined_image_sampler_count)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let variable_descriptor_binding_flags =
            vk::DescriptorBindingFlags::PARTIALLY_BOUND | vk::DescriptorBindingFlags::VARIABLE_DESCRIPTOR_COUNT;
        let bindings = [
            vk::DescriptorSetLayoutBinding {
                binding: 0,
                descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::ALL,
                immutable_samplers: std::ptr::null(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 1,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                descriptor_count: combined_image_sampler_count,
                stage_flags: vk::ShaderStageFlags::ALL,
                immutable_samplers: std::ptr::null(),
            },
        ];
        let binding_flags = [vk::DescriptorBindingFlags::empty(), variable_descriptor_binding_flags];
        let mut binding_flags_info =
            vk::DescriptorSetLayoutBindingFlagsCreateInfo::builder().binding_flags(&binding_flags);
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder()
            .bindings(&bindings)
            .push_next(&mut binding_flags_info);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );

        let set_layouts = [*descriptor_set_layout];
        let allocated_counts = [allocated_descriptor_count];
        let mut variable_count_info =
            vk::DescriptorSetVariableDescriptorCountAllocateInfo::builder().descriptor_counts(&allocated_counts);
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*descriptor_pool)
            .set_layouts(&set_layouts)
            .push_next(&mut variable_count_info);
        let sets = unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?;
        let descriptor_set = UniqueDescriptorSet::new(device, *descriptor_pool, sets[0]);

        let color_data: [u8; 8] = [255, 255, 0, 255, 0, 255, 255, 255];
        let src_buffer = create_host_buffer(context, &color_data[..], vk::BufferUsageFlags::TRANSFER_SRC)?;
        let texture_usage = vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED;
        let texture1 = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(IVec2::new(1, 1), color_format, texture_usage),
            MemoryRequirement::ANY,
        )?;
        let texture2 = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(IVec2::new(1, 1), color_format, texture_usage),
            MemoryRequirement::ANY,
        )?;
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let view1 = make_image_view(
            device,
            texture1.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range,
        )?;
        let view2 = make_image_view(
            device,
            texture2.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range,
        )?;

        let sampler = make_sampler(device)?;

        let image_infos = [
            vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: view1.get(),
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            },
            vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: view2.get(),
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            },
        ];
        let write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 1,
            dst_array_element: 0,
            descriptor_count: 2,
            descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            image_info: image_infos.as_ptr(),
            buffer_info: std::ptr::null(),
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let color_image = ImageWithBuffer::new(
            context,
            render_size,
            render_size,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_image.view], render_size, render_size, 1)?;

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(render_size, render_size);
        let graphics_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let command_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buf = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buf.get();

        begin_command_buffer(device, cmd)?;
        copy_buffer_to_image(
            device,
            cmd,
            src_buffer.get(),
            texture1.get(),
            texture_extent,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
        );
        // The second texture takes the second texel of the buffer, as `bufferOffset = sizeof(colorData) / 2` does upstream.
        {
            let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                texture2.get(),
                range,
            );
            let post_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                texture2.get(),
                range,
            );
            let mut region = make_buffer_image_copy(
                texture_extent,
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            region.buffer_offset = (color_data.len() / 2) as vk::DeviceSize;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_copy_barrier],
                );
                device.cmd_copy_buffer_to_image(
                    cmd,
                    src_buffer.get(),
                    texture2.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_copy_barrier],
                );
            }
        }

        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(render_size, render_size))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color_image.image.get(),
            color_image.buffer.get(),
            render_size,
            render_size,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let result = color_image.read_bytes(device)?;
        for y in 0..render_size {
            for x in 0..render_size {
                let offset = ((y * render_size + x) * 4) as usize;
                let pixel = &result[offset..offset + 4];
                if pixel != [0, 255, 0, 255] {
                    return Ok(TestStatus::fail(format!(
                        "Unexpected pixel at ({x}, {y}). Expected (0, 255, 0, 255), but got ({}, {}, {}, {})",
                        pixel[0], pixel[1], pixel[2], pixel[3]
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `nonUniformAtomicsCheckSupport` and `nonUniformAtomicsRun`
struct NonUniformAtomicsTestCase;

const NON_UNIFORM_ATOMICS_BUFFERS_PER_SET: u32 = 128;
const NON_UNIFORM_ATOMICS_SET_COUNT: u32 = 2;
const NON_UNIFORM_ATOMICS_TOTAL_BUFFERS: u32 = NON_UNIFORM_ATOMICS_BUFFERS_PER_SET * NON_UNIFORM_ATOMICS_SET_COUNT;

impl TestCase for NonUniformAtomicsTestCase {
    fn name(&self) -> &str {
        "non_uniform_atomics"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_descriptor_indexing")?;

        let mut indexing_features = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if indexing_features.runtime_descriptor_array == vk::FALSE {
            return Err(TestError::NotSupported(
                "runtimeDescriptorArray not supported".to_string(),
            ));
        }
        if indexing_features.shader_storage_buffer_array_non_uniform_indexing == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderStorageBufferArrayNonUniformIndexing not supported".to_string(),
            ));
        }

        let limits = &context.get_device_properties().limits;
        if limits.max_per_stage_resources < NON_UNIFORM_ATOMICS_TOTAL_BUFFERS {
            return Err(TestError::NotSupported(
                "maxPerStageResources too low for this test".to_string(),
            ));
        }
        if limits.max_per_stage_descriptor_storage_buffers < NON_UNIFORM_ATOMICS_TOTAL_BUFFERS {
            return Err(TestError::NotSupported(
                "maxPerStageDescriptorStorageBuffers too low for this test".to_string(),
            ));
        }
        if limits.max_descriptor_set_storage_buffers < NON_UNIFORM_ATOMICS_BUFFERS_PER_SET {
            return Err(TestError::NotSupported(
                "maxDescriptorSetStorageBuffers too low for this test".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NON_UNIFORM_ATOMICS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NonUniformAtomicsTestInstance { context })
    }
}

struct NonUniformAtomicsTestInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for NonUniformAtomicsTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let buffers_per_set = NON_UNIFORM_ATOMICS_BUFFERS_PER_SET as usize;
        let buffer_size = std::mem::size_of::<u32>();
        // Must match the work group size of the compute shader.
        let work_group_size = 64u32;
        let invocation_count = 1024u32;
        let group_count = invocation_count / work_group_size;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(
                vk::DescriptorType::STORAGE_BUFFER,
                NON_UNIFORM_ATOMICS_BUFFERS_PER_SET * NON_UNIFORM_ATOMICS_SET_COUNT,
            )
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                NON_UNIFORM_ATOMICS_SET_COUNT,
            )?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::COMPUTE,
                0,
                NON_UNIFORM_ATOMICS_BUFFERS_PER_SET,
            )
            .build(device)?;
        let indices_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let counter_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let mut index_buffers = Vec::with_capacity(buffers_per_set);
        let mut counter_buffers = Vec::with_capacity(buffers_per_set);
        for _ in 0..buffers_per_set {
            index_buffers.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?);
            counter_buffers.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        // Zero-out the counter buffers.
        for buffer in &counter_buffers {
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, buffer_size) };
            flush_alloc(device, buffer.get_allocation())?;
        }

        let infos = |buffers: &[BufferWithMemory<'_>]| -> Vec<vk::DescriptorBufferInfo> {
            buffers
                .iter()
                .map(|buffer| make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE))
                .collect()
        };
        let index_infos = infos(&index_buffers);
        let counter_infos = infos(&counter_buffers);
        let write = |set: vk::DescriptorSet, buffer_infos: &[vk::DescriptorBufferInfo]| vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: set,
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: buffer_infos.len() as u32,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: buffer_infos.as_ptr(),
            texel_buffer_view: std::ptr::null(),
        };
        unsafe {
            device.update_descriptor_sets(
                &[write(*indices_set, &index_infos), write(*counter_set, &counter_infos)],
                &[] as &[vk::CopyDescriptorSet],
            )
        };

        let pipeline_layout = make_pipeline_layout(device, &[*set_layout, *set_layout])?;
        let comp_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
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

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buf = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buf.get();

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*indices_set, *counter_set],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_dispatch(cmd, group_count, 1, 1);
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        for (index_buffer, counter_buffer) in index_buffers.iter().zip(&counter_buffers) {
            invalidate_alloc(device, index_buffer.get_allocation())?;
            invalidate_alloc(device, counter_buffer.get_allocation())?;
        }

        let mut reference_counters = vec![0u32; buffers_per_set];
        for index in 0..buffers_per_set {
            reference_counters[index & 0x7FFFFC] += 1;
        }

        let read = |buffer: &BufferWithMemory<'_>| unsafe {
            buffer.get_allocation().get_host_ptr().cast::<u32>().read_unaligned()
        };
        let mut failed = false;
        for index in 0..buffers_per_set {
            let (result_index, result_counter) = (read(&index_buffers[index]), read(&counter_buffers[index]));
            if result_index != index as u32 + 1 || result_counter != reference_counters[index] {
                failed = true;
            }
        }

        if failed {
            return Ok(TestStatus::fail("Unexpected results found in output buffers"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDescriptorIndexingMiscTests`
pub fn create_descriptor_indexing_misc_tests(main_group: &mut TestCaseGroup) {
    let test_coords: [(&'static str, &'static str); 2] = [("0.0", "0"), ("0.5", "mid")];

    for array_size in [8u32, 64] {
        for (coordinate, coordinate_name) in test_coords {
            let test_name = format!("misc_common_nonuniform_index_arraysize_{array_size}_at_{coordinate_name}");
            main_group.add_child(Box::new(CommonNonUniformDescriptorIndexTestCase {
                name: test_name,
                format: vk::Format::R32G32B32A32_UINT,
                num_elements_per_array: array_size,
                coordinate,
            }) as Box<dyn TestCase>);
        }
    }

    main_group.add_child(Box::new(MiscVariableCountTestCase {
        name: "misc_variable_count",
    }) as Box<dyn TestCase>);
    main_group.add_child(Box::new(NonUniformAtomicsTestCase) as Box<dyn TestCase>);
}
