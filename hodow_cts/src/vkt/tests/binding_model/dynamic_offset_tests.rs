// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDynamicOffsetTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two Amber cases of the group
// (`shader_reuse_differing_layout_compute`/`_graphics`) are not ported: there is no Amber
// runner here.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Size of one `vec4`.
const ITEM_SIZE: u32 = 16;

/// `DynamicOffsetPCParams::getPCItemCount` - large push constants are interesting for some implementations.
const PC_ITEM_COUNT: u32 = 8;

/// `de::roundUp`
fn round_up(value: u32, multiple: u32) -> u32 {
    value.div_ceil(multiple) * multiple
}

/// The generated case: the four flags of `DynamicOffsetPCParams` plus the shaders.
#[derive(Clone, Copy)]
pub struct DynamicOffsetPcCase {
    pub name: &'static str,
    /// Both pipelines use different offsets.
    pub separate_offsets: bool,
    /// Set push constants right at the start, before binding sets.
    pub pc_first: bool,
    /// Both pipelines use push constants and share pipeline layouts.
    pub single_layout: bool,
    /// Assumes `single_layout` is false. Pipelines use different sets.
    pub different_sets: bool,
    pub programs: BinaryCollection,
}

impl TestCase for DynamicOffsetPcCase {
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
        Box::new(DynamicOffsetPcInstance { context, params: *self })
    }
}

struct DynamicOffsetPcInstance<'a> {
    context: &'a Context<'a>,
    params: DynamicOffsetPcCase,
}

impl TestInstance for DynamicOffsetPcInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let qf_index = self.context.get_universal_queue_family_index();

        let item_size = ITEM_SIZE;
        let item_count = 3u32; // 1st item: not used, 2nd item: first run, 3rd item (maybe): second run.

        // Due to minUniformBufferOffsetAlignment and minStorageBufferOffsetAlignment, we may need to adjust the buffer size
        // so that each item is properly aligned.
        let limits = &self.context.get_device_properties().limits;
        let min_uniform_buffer_offset_alignment = limits.min_uniform_buffer_offset_alignment as u32;
        let min_storage_buffer_offset_alignment = limits.min_storage_buffer_offset_alignment as u32;

        let item_size_uniform = round_up(item_size, min_uniform_buffer_offset_alignment);
        let item_size_storage = round_up(item_size, min_storage_buffer_offset_alignment);

        let data_size_uniform = item_size_uniform * item_count;
        let data_size_storage = item_size_storage * item_count;

        let pc_item_count = PC_ITEM_COUNT;
        let pc_size = item_size * pc_item_count;

        let input_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(data_size_uniform as u64, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let input_buffer_data: [[f32; 4]; 3] = [[0.0, 0.0, 0.0, 0.0], [1.0, 2.0, 3.0, 4.0], [5.0, 6.0, 7.0, 8.0]];
        {
            let alloc = input_buffer.get_allocation();
            debug_assert_eq!(input_buffer_data.len() as u32, item_count);
            let buffer_bytes = alloc.get_host_ptr();

            unsafe {
                std::ptr::write_bytes(buffer_bytes, 0, data_size_uniform as usize);
                for (i, item) in input_buffer_data.iter().enumerate() {
                    let item_ptr = buffer_bytes.add(item_size_uniform as usize * i);
                    std::ptr::copy_nonoverlapping(item.as_ptr().cast::<u8>(), item_ptr, item_size as usize);
                }
            }

            flush_alloc(vk, alloc)?;
        }

        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(data_size_storage as u64, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, data_size_storage as usize) };
            flush_alloc(vk, alloc)?;
        }

        let binaries = self.context.get_binary_collection();
        let comp_shader0 = create_shader_module(vk, binaries.get("comp0")?)?;
        let comp_shader1 = create_shader_module(vk, binaries.get("comp1")?)?;

        let stage_flags = vk::ShaderStageFlags::COMPUTE;

        let set_layout0 = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, stage_flags)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, stage_flags)
            .build(vk)?;
        let set_layout_handle0 = *set_layout0;

        let mut set_layout1: Option<Unique<'_, vk::DescriptorSetLayout>> = None;
        // To simplify, when using separate sets the second pipeline will reuse the layout of the first set, despite the
        // fact that it only uses binding 0, and the output buffer will be available in set 1 in addition to set 0.
        if params.different_sets {
            set_layout1 = Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, stage_flags)
                    .build(vk)?,
            );
        }
        let set_layout_handle1 = set_layout1.as_ref().map_or(set_layout_handle0, |l| **l);

        let pc_range = vk::PushConstantRange::builder()
            .stage_flags(stage_flags)
            .offset(0)
            .size(pc_size)
            .build();
        let mut pc_items_vec: Vec<[f32; 4]> = vec![[0.0; 4]; pc_item_count as usize];
        pc_items_vec[0] = [100.0, 200.0, 300.0, 400.0];
        // The push constant bytes, as `cmdPushConstants` takes them.
        let pc_values: Vec<u8> = pc_items_vec
            .iter()
            .flat_map(|v| v.iter().flat_map(|f| f.to_ne_bytes()))
            .collect();

        let layouts0 = [set_layout_handle0];
        let layout_info0 = vk::PipelineLayoutCreateInfo::builder().set_layouts(&layouts0);
        let pipeline_layout0 = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&layout_info0, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Reuse set layout 0 despite the fact that we don't use all bindings.
        let mut set_layout_handles1 = vec![set_layout_handle0];
        if params.different_sets {
            set_layout_handles1.push(set_layout_handle1);
        }
        let pc_ranges = [pc_range];
        let layout_info1 = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layout_handles1)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout1 = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&layout_info1, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let pipeline_layout_handle0 = if params.single_layout {
            *pipeline_layout1
        } else {
            *pipeline_layout0
        };
        let pipeline_layout_handle1 = *pipeline_layout1;

        let pipeline0 = make_compute_pipeline(vk, pipeline_layout_handle0, *comp_shader0)?;
        let pipeline1 = make_compute_pipeline(vk, pipeline_layout_handle1, *comp_shader1)?;

        // Prepare descriptor sets.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, 2)
            .add_type(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, 2)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let descriptor_set0 = make_descriptor_set(vk, *descriptor_pool, set_layout_handle0)?;

        let descriptor_set1 = if params.different_sets {
            Some(make_descriptor_set(vk, *descriptor_pool, set_layout_handle1)?)
        } else {
            None
        };

        let input_buffer_desc_info = make_descriptor_buffer_info(input_buffer.get(), 0, item_size as u64);
        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, item_size as u64);
        let mut update_builder = DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set0.get(),
                Location::binding(0),
                vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC,
                &input_buffer_desc_info,
            )
            .write_single(
                descriptor_set0.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER_DYNAMIC,
                &output_buffer_desc_info,
            );
        if let Some(set1) = descriptor_set1.as_ref() {
            // Make output buffer also available on binding 0 of the second set.
            update_builder = update_builder.write_single(
                set1.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER_DYNAMIC,
                &output_buffer_desc_info,
            );
        }
        update_builder.update(vk);

        let mut all_descriptor_sets = vec![descriptor_set0.get()];
        if let Some(set1) = descriptor_set1.as_ref() {
            all_descriptor_sets.push(set1.get());
        }

        let cmd_pool = make_command_pool(vk, qf_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let dynamic_offsets: Vec<u32> = vec![item_size_uniform, item_size_storage];

        let dynamic_offsets0 = dynamic_offsets.clone();
        let mut dynamic_offsets1 = dynamic_offsets;

        if params.separate_offsets {
            for offset in dynamic_offsets1.iter_mut() {
                *offset *= 2;
            }
        }

        // With different sets, we actually have 3 descriptors and the last offset (output buffer) needs to appear twice.
        if params.different_sets {
            let last = *dynamic_offsets1.last().unwrap();
            dynamic_offsets1.push(last);
        }

        begin_command_buffer(vk, cmd_buffer)?;
        unsafe {
            if params.pc_first {
                vk.cmd_push_constants(cmd_buffer, pipeline_layout_handle1, stage_flags, 0, &pc_values);
            }
            vk.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                pipeline_layout_handle0,
                0,
                &[descriptor_set0.get()],
                &dynamic_offsets0,
            );
            vk.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline0);
            if params.single_layout && !params.pc_first {
                vk.cmd_push_constants(cmd_buffer, pipeline_layout_handle0, stage_flags, 0, &pc_values);
            }
            vk.cmd_dispatch(cmd_buffer, 1, 1, 1);
            {
                let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::SHADER_WRITE);
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            if !params.single_layout || params.separate_offsets {
                vk.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout_handle1,
                    0,
                    &all_descriptor_sets,
                    &dynamic_offsets1,
                );
            }
            vk.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline1);
            if !params.pc_first && !params.single_layout {
                vk.cmd_push_constants(cmd_buffer, pipeline_layout_handle1, stage_flags, 0, &pc_values);
            }
            vk.cmd_dispatch(cmd_buffer, 1, 1, 1);
            {
                let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(vk, output_alloc)?;

        let float_count = data_size_storage as usize / std::mem::size_of::<f32>();
        let mut expected = vec![0.0f32; float_count];
        let mut result = vec![0.0f32; float_count];

        unsafe {
            std::ptr::copy_nonoverlapping(
                output_alloc.get_host_ptr().cast_const(),
                result.as_mut_ptr().cast::<u8>(),
                data_size_storage as usize,
            );

            let input_buffer_bytes = input_buffer.get_allocation().get_host_ptr().cast_const();
            let dst_bytes = expected.as_mut_ptr().cast::<u8>();

            // Copy data from input buffer at the first input offset into the first output offset.
            std::ptr::copy_nonoverlapping(
                input_buffer_bytes.add(*dynamic_offsets0.first().unwrap() as usize),
                dst_bytes.add(*dynamic_offsets0.last().unwrap() as usize),
                item_size as usize,
            );

            // Copy data from push constants into the second output offset.
            std::ptr::copy_nonoverlapping(
                pc_values.as_ptr(),
                dst_bytes.add(*dynamic_offsets1.last().unwrap() as usize),
                item_size as usize,
            );
        }

        debug_assert_eq!(expected.len(), result.len());
        let mut fail = false;

        for (i, (exp_item, res_item)) in expected.iter().zip(result.iter()).enumerate() {
            if exp_item != res_item {
                fail = true;
                log::info!("Mismatch at item {i}: expected {exp_item} but got {res_item}");
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected results in output buffer; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `vk::makeComputePipeline`
pub(super) fn make_compute_pipeline<'a>(
    vk: &'a Device,
    layout: vk::PipelineLayout,
    shader_module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry_point = b"main\0";
    let stage = vk::PipelineShaderStageCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::PipelineShaderStageCreateFlags::empty(),
        stage: vk::ShaderStageFlags::COMPUTE,
        module: shader_module,
        name: entry_point.as_ptr().cast(),
        specialization_info: std::ptr::null(),
    };
    let create_info = vk::ComputePipelineCreateInfo {
        s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::PipelineCreateFlags::empty(),
        stage,
        layout,
        base_pipeline_handle: vk::Pipeline::null(),
        base_pipeline_index: -1,
    };
    let pipelines = unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
        .map_err(|e| TestError::InternalError(format!("vkCreateComputePipelines returned {e:?}")))?;
    Ok(Unique::new(vk, pipelines.0[0]))
}

/// `createDynamicOffsetTests` / `populateDynamicOffsetTests`
pub fn create_dynamic_offset_tests() -> TestCaseGroup {
    use crate::generated::shaders::binding_model_dynamic_offset as g;

    let mut group = TestCaseGroup::new("dynamic_offset");

    // The two Amber cases (`shader_reuse_differing_layout_{compute,graphics}`) are not ported.

    for case in [
        g::TWO_PIPELINES,
        g::TWO_PIPELINES_DIFFERENT_SETS,
        g::TWO_PIPELINES_SINGLE_LAYOUT,
        g::TWO_PIPELINES_PC_FIRST,
        g::TWO_PIPELINES_PC_FIRST_DIFFERENT_SETS,
        g::TWO_PIPELINES_PC_FIRST_SINGLE_LAYOUT,
        g::TWO_PIPELINES_SEPARATE_OFFSETS,
        g::TWO_PIPELINES_SEPARATE_OFFSETS_DIFFERENT_SETS,
        g::TWO_PIPELINES_SEPARATE_OFFSETS_SINGLE_LAYOUT,
        g::TWO_PIPELINES_SEPARATE_OFFSETS_PC_FIRST,
        g::TWO_PIPELINES_SEPARATE_OFFSETS_PC_FIRST_DIFFERENT_SETS,
        g::TWO_PIPELINES_SEPARATE_OFFSETS_PC_FIRST_SINGLE_LAYOUT,
    ] {
        group.add_child(Box::new(case) as Box<dyn TestCase>);
    }

    group
}
