// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ubo/vktUniformBlockCase.cpp (UniformBlockCaseInstance, UniformBlockCase::checkSupport)
//   external/vulkancts/modules/vulkan/ubo/vktUniformBlockTests.cpp (createTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Samsung Electronics Co., Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The block layouts, the case tree and the shaders (which `UniformBlockCase::delayedInit` builds from the case's
// interface at run time) are produced by scripts/ubo_cases.py and listed in `ubo_cases.rs`; upstream's `generateValues` draws nothing (`UniformLayoutEntry::size` is
// never set), so every block is uploaded as zeros and the shaders compare against literal zeros, which is all this file has to do.

pub mod ubo_cases;

use std::collections::BTreeMap;

use ubo_cases::{REQ_8BIT_STORAGE, REQ_16BIT_STORAGE, REQ_DESCRIPTOR_INDEXING, REQ_SCALAR, REQ_STD430, UBO_CASES};
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::clear_value_color;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_WIDTH: u32 = 100;
const RENDER_HEIGHT: u32 = 100;

/// One uniform block instance of a case: the `BlockLayoutEntry` the reference layout computed for it.
pub struct BlockDef {
    pub binding: u32,
    pub instance: u32,
    pub size: u32,
}

/// One case of `ubo_cases.rs`.
pub struct UboCaseDef {
    /// the dotted path below `ubo`
    pub name: &'static str,
    pub per_block_buffer: bool,
    pub compute: bool,
    pub requirements: u32,
    pub unsized_array: bool,
    pub blocks: &'static [BlockDef],
    pub programs: &'static SharedProgram,
}

struct UboCase {
    name: &'static str,
    def: &'static UboCaseDef,
}

impl TestCase for UboCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `UniformBlockCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let requirements = self.def.requirements;
        let not_supported = |message: &str| Err(TestError::NotSupported(message.to_string()));

        let mut storage16 = vk::PhysicalDevice16BitStorageFeatures::default();
        let mut storage8 = vk::PhysicalDevice8BitStorageFeatures::default();
        let mut scalar_layout = vk::PhysicalDeviceScalarBlockLayoutFeatures::default();
        let mut standard_layout = vk::PhysicalDeviceUniformBufferStandardLayoutFeatures::default();
        let mut indexing = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
        let mut unsized_array = vk::PhysicalDeviceShaderUniformBufferUnsizedArrayFeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut storage16)
                .push_next(&mut storage8)
                .push_next(&mut scalar_layout)
                .push_next(&mut standard_layout)
                .push_next(&mut indexing);
            if self.def.unsized_array
                && context.is_device_functionality_supported("VK_EXT_shader_uniform_buffer_unsized_array")
            {
                features2 = features2.push_next(&mut unsized_array);
            }
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if storage16.uniform_and_storage_buffer_16bit_access == vk::FALSE && requirements & REQ_16BIT_STORAGE != 0 {
            return not_supported("uniformAndStorageBuffer16BitAccess not supported");
        }
        if storage8.uniform_and_storage_buffer_8bit_access == vk::FALSE && requirements & REQ_8BIT_STORAGE != 0 {
            return not_supported("uniformAndStorageBuffer8BitAccess not supported");
        }
        if scalar_layout.scalar_block_layout == vk::FALSE
            && standard_layout.uniform_buffer_standard_layout == vk::FALSE
            && requirements & REQ_STD430 != 0
        {
            return not_supported("std430 not supported");
        }
        if scalar_layout.scalar_block_layout == vk::FALSE && requirements & REQ_SCALAR != 0 {
            return not_supported("scalarBlockLayout not supported");
        }
        if requirements & REQ_DESCRIPTOR_INDEXING != 0
            && (indexing.shader_uniform_buffer_array_non_uniform_indexing == vk::FALSE
                || indexing.runtime_descriptor_array == vk::FALSE)
        {
            return not_supported("Descriptor indexing over uniform buffer not supported");
        }
        if self.def.unsized_array && unsized_array.shader_uniform_buffer_unsized_array == vk::FALSE {
            return not_supported("shaderUniformBufferUnsizedArray not supported");
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.def.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UboInstance { context, def: self.def })
    }
}

struct UboInstance<'a> {
    context: &'a Context<'a>,
    def: &'static UboCaseDef,
}

impl UboInstance<'_> {
    /// `addUniformData`: a host visible uniform buffer of `size` zero bytes.
    fn add_uniform_data<'d>(&self, device: &'d Device, size: u64) -> Result<BufferWithMemory<'d>, TestError> {
        let buffer = BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, size as usize) };
        flush_alloc(device, buffer.get_allocation())?;
        Ok(buffer)
    }
}

impl TestInstance for UboInstance<'_> {
    /// `UniformBlockCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let def = self.def;
        let device = context.get_device();
        let is_compute = def.compute;
        let (queue, queue_family_index) = if is_compute {
            context.get_compute_queue().unwrap_or((
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            ))
        } else {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        };
        let allocator = context.get_default_allocator();
        let color_format = vk::Format::R8G8B8A8_UNORM;

        // Create output image
        let image_usage = vk::ImageUsageFlags::TRANSFER_SRC
            | if is_compute {
                vk::ImageUsageFlags::STORAGE
            } else {
                vk::ImageUsageFlags::COLOR_ATTACHMENT
            };
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk::Extent3D {
                width: RENDER_WIDTH,
                height: RENDER_HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(image_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_range,
        )?;

        // Create result buffer
        let result_buffer_size = u64::from(RENDER_WIDTH * RENDER_HEIGHT * 4);
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create descriptor pool and set
        let min_uniform_buffer_offset_alignment = context
            .get_device_properties()
            .limits
            .min_uniform_buffer_offset_alignment as u32;

        let ubo_stages = if is_compute {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::ALL
        };
        let mut binding_counts: BTreeMap<u32, u32> = BTreeMap::new();
        let mut max_binding: i64 = -1;
        for block in def.blocks {
            *binding_counts.entry(block.binding).or_insert(0) += 1;
            max_binding = max_binding.max(i64::from(block.binding));
        }
        let image_binding = (max_binding + 1) as u32;

        let mut bindings: Vec<vk::DescriptorSetLayoutBinding> = binding_counts
            .iter()
            .map(|(&binding, &count)| vk::DescriptorSetLayoutBinding {
                binding,
                descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
                descriptor_count: count,
                stage_flags: ubo_stages,
                immutable_samplers: std::ptr::null(),
            })
            .collect();
        if is_compute {
            bindings.push(vk::DescriptorSetLayoutBinding {
                binding: image_binding,
                descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            });
        }
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );

        let mut pool_builder =
            DescriptorPoolBuilder::new().add_type(vk::DescriptorType::UNIFORM_BUFFER, def.blocks.len() as u32);
        if is_compute {
            pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_IMAGE, 1);
        }
        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        // Upload uniform data
        let mut uniform_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        let mut descriptors: Vec<vk::DescriptorBufferInfo> = Vec::with_capacity(def.blocks.len());
        if def.per_block_buffer {
            for block in def.blocks {
                let buffer = self.add_uniform_data(device, u64::from(block.size))?;
                descriptors.push(make_descriptor_buffer_info(buffer.get(), 0, u64::from(block.size)));
                uniform_buffers.push(buffer);
            }
        } else {
            let mut current_offset = 0u32;
            let mut offsets: Vec<u32> = Vec::with_capacity(def.blocks.len());
            for block in def.blocks {
                if min_uniform_buffer_offset_alignment > 0 {
                    current_offset = current_offset.next_multiple_of(min_uniform_buffer_offset_alignment);
                }
                offsets.push(current_offset);
                current_offset += block.size;
            }

            let total_size = current_offset;
            // The copy of the data that satisfies the device's min uniform buffer alignment
            let buffer = self.add_uniform_data(device, u64::from(total_size))?;
            for (block, &offset) in def.blocks.iter().zip(&offsets) {
                descriptors.push(make_descriptor_buffer_info(
                    buffer.get(),
                    u64::from(offset),
                    u64::from(block.size),
                ));
            }
            uniform_buffers.push(buffer);
        }

        let mut writes: Vec<vk::WriteDescriptorSet> = def
            .blocks
            .iter()
            .zip(&descriptors)
            .map(|(block, info)| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(block.binding)
                    .dst_array_element(block.instance)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                    .buffer_info(std::slice::from_ref(info))
                    .build()
            })
            .collect();

        // Update storage image descriptor for compute shader
        let image_infos = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *color_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        if is_compute {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(image_binding)
                    .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                    .image_info(&image_infos)
                    .build(),
            );
        }
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Command buffer
        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;

        let binaries = context.get_binary_collection();

        // Both paths keep what they build alive until the submission has finished
        let mut keep_alive: (Option<BufferWithMemory<'_>>, Option<BufferWithMemory<'_>>) = (None, None);
        let render_pass;
        let framebuffer;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let vertex_module;
        let fragment_module;
        let compute_module;
        let pipeline;

        if !is_compute {
            // Graphics path
            let positions: [f32; 16] = [
                -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
            ];
            let indices: [u32; 6] = [0, 1, 2, 2, 1, 3];

            let positions_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    std::mem::size_of_val(&positions) as u64,
                    vk::BufferUsageFlags::VERTEX_BUFFER,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let indices_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    std::mem::size_of_val(&indices) as u64,
                    vk::BufferUsageFlags::INDEX_BUFFER | vk::BufferUsageFlags::VERTEX_BUFFER,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            // Upload attributes data
            unsafe {
                std::ptr::copy_nonoverlapping(
                    positions.as_ptr().cast::<u8>(),
                    positions_buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(&positions),
                );
                std::ptr::copy_nonoverlapping(
                    indices.as_ptr().cast::<u8>(),
                    indices_buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(&indices),
                );
            }
            flush_alloc(device, positions_buffer.get_allocation())?;
            flush_alloc(device, indices_buffer.get_allocation())?;

            render_pass = make_render_pass(device, color_format)?;
            framebuffer = make_framebuffer(device, *render_pass, &[*color_view], RENDER_WIDTH, RENDER_HEIGHT, 1)?;
            vertex_module = create_shader_module(device, binaries.get("vert")?)?;
            fragment_module = create_shader_module(device, binaries.get("frag")?)?;
            pipeline = make_graphics_pipeline(
                device,
                *pipeline_layout,
                *vertex_module,
                *fragment_module,
                *render_pass,
                (RENDER_WIDTH, RENDER_HEIGHT),
                vk::PrimitiveTopology::TRIANGLE_LIST,
            )?;

            // Add barrier for initializing image state
            let initialize_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[initialize_barrier],
                );
            }

            begin_render_pass(
                device,
                cmd,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, RENDER_WIDTH, RENDER_HEIGHT),
                clear_value_color([0.125, 0.25, 0.75, 1.0]),
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[] as &[u32],
                );
                device.cmd_bind_vertex_buffers(cmd, 0, &[positions_buffer.get()], &[0]);
                device.cmd_bind_index_buffer(cmd, indices_buffer.get(), 0, vk::IndexType::UINT32);
                device.cmd_draw_indexed(cmd, indices.len() as u32, 1, 0, 0, 0);
            }
            end_render_pass(device, cmd);

            copy_image_to_buffer(
                device,
                cmd,
                color_image.get(),
                result_buffer.get(),
                RENDER_WIDTH,
                RENDER_HEIGHT,
            );
            keep_alive = (Some(positions_buffer), Some(indices_buffer));
        } else {
            // Compute path
            compute_module = create_shader_module(device, binaries.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*compute_module)
                .name(b"main\0");
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(*stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0);
            pipeline = Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            );

            // Add barrier for initializing image state
            let initialize_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                color_image.get(),
                color_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[initialize_barrier],
                );

                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[] as &[u32],
                );

                // Dispatch width x height as workgroups are 1x1
                device.cmd_dispatch(cmd, RENDER_WIDTH, RENDER_HEIGHT, 1);
            }

            // copyImageToBuffer of a storage image left in GENERAL by a compute shader
            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_image.get(),
                color_range,
            );
            let copy_region = make_buffer_image_copy(
                vk::Extent3D {
                    width: RENDER_WIDTH,
                    height: RENDER_HEIGHT,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            let to_host = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    result_buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[*to_host],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;

        // Submit the command buffer
        submit_commands_and_wait(device, queue, cmd)?;

        // Read back the results
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr(),
                result_buffer_size as usize,
            )
        };

        // Check if the result image is all white
        let num_failed_pixels = pixels
            .chunks_exact(4)
            .filter(|pixel| *pixel != [255u8, 255, 255, 255])
            .count();

        drop(keep_alive);
        drop(uniform_buffers);

        if num_failed_pixels > 0 {
            log::info!("Image comparison failed, got {num_failed_pixels} non-white pixels");
            for (block_ndx, block) in def.blocks.iter().enumerate() {
                log::info!(
                    "Block index: {block_ndx} binding {} instance {} size {}",
                    block.binding,
                    block.instance,
                    block.size
                );
            }
            return Ok(TestStatus::fail("Detected non-white pixels"));
        }
        Ok(TestStatus::pass("Full white image ok"))
    }
}

/// A group under construction. Cases only sit in the innermost group, as upstream's `vertex`/`fragment` ones do.
struct Node {
    name: String,
    groups: Vec<Node>,
    cases: Vec<UboCase>,
}

impl Node {
    fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),
            groups: Vec::new(),
            cases: Vec::new(),
        }
    }

    /// Adds a case below `path`, reusing the last group when it has the name: upstream registers every group's cases back to back.
    fn insert(&mut self, path: &[&'static str], case: UboCase) {
        let Some((first, rest)) = path.split_first() else {
            self.cases.push(case);
            return;
        };
        if self.groups.last().is_none_or(|g| g.name != *first) {
            self.groups.push(Node::new(first));
        }
        self.groups.last_mut().expect("just pushed").insert(rest, case);
    }

    fn into_group(self) -> TestCaseGroup {
        let mut group = TestCaseGroup::new(self.name);
        for child in self.groups {
            group.add_child(child.into_group());
        }
        for case in self.cases {
            group.add_child(Box::new(case) as Box<dyn TestCase>);
        }
        group
    }
}

/// `createTests` (`ubo`)
pub fn create_tests() -> TestCaseGroup {
    let mut root = Node::new("ubo");
    for def in UBO_CASES {
        let mut path: Vec<&'static str> = def.name.split('.').collect();
        let name = path.pop().expect("a case has a name");
        root.insert(&path, UboCase { name, def });
    }
    root.into_group()
}
