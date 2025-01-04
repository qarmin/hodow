// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorInlineUniformTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2019 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream writes each case's fragment
// shader from its operation list at run time; here the nine shaders are committed
// (see shaders/manifest/binding_model_inline_uniform.toml), which is why the per-word
// update status and verification data that only fed that shader are not kept on the
// host side. Changing an operation list below means regenerating its shader to match.

use std::collections::BTreeMap;

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The generated case: its name and its two shaders.
#[derive(Clone, Copy)]
pub struct InlineUniformCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `renderSize`
const RENDER_SIZE: (u32, u32) = (1, 16);

/// `inlineUniformBlockMinimumSize`
const INLINE_UNIFORM_BLOCK_MINIMUM_SIZE: u32 = 4;

/// `InlineUniformBlockDescriptor`
struct InlineUniformBlockDescriptor {
    set: u32,
    binding: u32,
    /// Must be multiple of 4 in input.
    size: u32,
    data_to_write: Vec<u32>,
}

impl InlineUniformBlockDescriptor {
    fn new(set: u32, binding: u32, size: u32, id: &mut u32) -> Self {
        let array_size = size / INLINE_UNIFORM_BLOCK_MINIMUM_SIZE;
        let mut data_to_write = Vec::with_capacity(array_size as usize);
        for _ in 0..array_size {
            data_to_write.push(*id);
            *id += 1;
        }
        Self {
            set,
            binding,
            size,
            data_to_write,
        }
    }
}

/// `InlineUniformBlockWrite`
struct InlineUniformBlockWrite {
    descriptor: usize,
    /// Must be multiple of 4 in input.
    write_offset: u32,
    write_index: u32,
    /// Must be multiple of 4 in input.
    write_size: u32,
}

/// `InlineUniformBlockCopy`
struct InlineUniformBlockCopy {
    src_descriptor: usize,
    dest_descriptor: usize,
    src_offset: u32,
    dest_offset: u32,
    copy_size: u32,
}

/// `DescriptorOps`. Descriptors are referred to by their index in `all_descriptors`.
#[derive(Default)]
struct DescriptorOps {
    writes: Vec<InlineUniformBlockWrite>,
    copies: Vec<InlineUniformBlockCopy>,
    all_descriptors: Vec<InlineUniformBlockDescriptor>,
    /// Descriptor indices per set.
    sets: BTreeMap<u32, Vec<usize>>,
}

impl DescriptorOps {
    fn add_descriptor(&mut self, set: u32, binding: u32, size: u32, id: &mut u32) -> usize {
        let new_iub = InlineUniformBlockDescriptor::new(set, binding, size, id);
        self.all_descriptors.push(new_iub);
        let index = self.all_descriptors.len() - 1;

        // assuming binding id will be unique
        self.sets.entry(set).or_default().push(index);

        index
    }

    fn write_descriptor(&mut self, desc: usize, offset: u32, size: u32) {
        self.writes.push(InlineUniformBlockWrite {
            descriptor: desc,
            write_offset: offset,
            write_index: offset / INLINE_UNIFORM_BLOCK_MINIMUM_SIZE,
            write_size: size,
        });
    }

    fn copy_descriptor(&mut self, from_desc: usize, to_desc: usize, src_offset: u32, dest_offset: u32, size: u32) {
        // those descriptors that have to be copied have to be written first
        self.write_descriptor(from_desc, src_offset, size);
        self.write_descriptor(to_desc, dest_offset, size);

        self.copies.push(InlineUniformBlockCopy {
            src_descriptor: from_desc,
            dest_descriptor: to_desc,
            src_offset,
            dest_offset,
            copy_size: size,
        });
    }
}

/// `createInlineUniformWriteTests`
fn inline_uniform_write_ops() -> Vec<(&'static str, DescriptorOps)> {
    let mut cases = Vec::new();
    let mut unique_id = 1u32;
    {
        let mut ops = DescriptorOps::default();
        let desc1 = ops.add_descriptor(0, 0, 4, &mut unique_id);
        ops.write_descriptor(desc1, 0, 4);
        cases.push(("write_size_4", ops));
    }
    {
        let mut ops = DescriptorOps::default();
        let desc1 = ops.add_descriptor(0, 0, 8, &mut unique_id);
        ops.write_descriptor(desc1, 0, 8);
        cases.push(("write_size_8", ops));
    }
    {
        let mut ops = DescriptorOps::default();
        let desc1 = ops.add_descriptor(0, 0, 16, &mut unique_id);
        ops.write_descriptor(desc1, 0, 16);
        cases.push(("write_size_16", ops));
    }
    {
        let mut ops = DescriptorOps::default();
        let desc1 = ops.add_descriptor(0, 0, 16, &mut unique_id);
        ops.write_descriptor(desc1, 4, 8);
        cases.push(("write_offset_nonzero", ops));
    }
    cases
}

/// `createInlineUniformCopyTests`
fn inline_uniform_copy_ops() -> Vec<(&'static str, DescriptorOps)> {
    let mut cases = Vec::new();
    let mut unique_id = 1u32;
    {
        let mut ops = DescriptorOps::default();
        let from_desc1 = ops.add_descriptor(0, 0, 4, &mut unique_id);
        let to_desc1 = ops.add_descriptor(0, 1, 4, &mut unique_id);
        ops.copy_descriptor(from_desc1, to_desc1, 0, 0, 4);
        cases.push(("copy_size_4", ops));
    }
    {
        let mut ops = DescriptorOps::default();
        let from_desc1 = ops.add_descriptor(0, 0, 8, &mut unique_id);
        let to_desc1 = ops.add_descriptor(0, 1, 8, &mut unique_id);
        ops.copy_descriptor(from_desc1, to_desc1, 0, 0, 8);
        cases.push(("copy_size_8", ops));
    }
    {
        let mut ops = DescriptorOps::default();
        let from_desc1 = ops.add_descriptor(0, 0, 16, &mut unique_id);
        let to_desc1 = ops.add_descriptor(0, 1, 16, &mut unique_id);
        ops.copy_descriptor(from_desc1, to_desc1, 0, 0, 16);
        cases.push(("copy_size_16", ops));
    }
    {
        let mut ops = DescriptorOps::default();
        let from_desc1 = ops.add_descriptor(0, 0, 16, &mut unique_id);
        let to_desc1 = ops.add_descriptor(0, 1, 16, &mut unique_id);
        ops.copy_descriptor(from_desc1, to_desc1, 0, 4, 8);
        cases.push(("copy_at_offset_nonzero", ops));
    }
    {
        let mut ops = DescriptorOps::default();
        let from_desc1 = ops.add_descriptor(0, 0, 16, &mut unique_id);
        let to_desc1 = ops.add_descriptor(0, 1, 16, &mut unique_id);
        ops.copy_descriptor(from_desc1, to_desc1, 4, 0, 8);
        cases.push(("copy_from_offset_nonzero", ops));
    }
    cases
}

impl TestCase for InlineUniformCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_inline_uniform_block")
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let ops = inline_uniform_write_ops()
            .into_iter()
            .chain(inline_uniform_copy_ops())
            .find(|(name, _)| *name == self.name)
            .map(|(_, ops)| ops)
            .expect("every registered inline uniform case has an operation list");
        Box::new(DescriptorInlineUniformTestInstance { context, ops })
    }
}

struct DescriptorInlineUniformTestInstance<'a> {
    context: &'a Context<'a>,
    ops: DescriptorOps,
}

impl DescriptorInlineUniformTestInstance<'_> {
    /// `verifyResultImage` - every pixel must be exactly green; the threshold is zero.
    fn verify_result_image(&self, result: &[u8]) -> bool {
        let correct_color = [0u8, 255, 0, 255];
        let mut test_ok = true;
        for y in 0..RENDER_SIZE.1 as usize {
            for x in 0..RENDER_SIZE.0 as usize {
                let offset = (y * RENDER_SIZE.0 as usize + x) * 4;
                let pixel = &result[offset..offset + 4];
                if pixel != correct_color {
                    log::info!("Result pixel ({x}, {y}) is {pixel:?}, reference is {correct_color:?}");
                    test_ok = false;
                }
            }
        }
        test_ok
    }
}

impl TestInstance for DescriptorInlineUniformTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let num_descs = self.ops.all_descriptors.len() as u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let num_sets = self.ops.sets.len();

        // Create descriptor pool
        let desc_pool = {
            let total_iub_size: u32 = self.ops.all_descriptors.iter().map(|d| d.size).sum();

            let mut iub_pool_create_info = vk::DescriptorPoolInlineUniformBlockCreateInfo {
                s_type: vk::StructureType::DESCRIPTOR_POOL_INLINE_UNIFORM_BLOCK_CREATE_INFO,
                next: std::ptr::null(),
                max_inline_uniform_block_bindings: num_descs,
            };
            let pool_sizes = [vk::DescriptorPoolSize {
                type_: vk::DescriptorType::INLINE_UNIFORM_BLOCK,
                descriptor_count: total_iub_size,
            }];
            let info = vk::DescriptorPoolCreateInfo::builder()
                .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
                .max_sets(num_sets as u32)
                .pool_sizes(&pool_sizes)
                .push_next(&mut iub_pool_create_info);
            Unique::new(
                vk,
                unsafe { vk.create_descriptor_pool(&info, None) }.vk_check("vkCreateDescriptorPool")?,
            )
        };

        // Create descriptor set layouts for each set and allocate the set
        let mut desc_set_layouts: Vec<Option<Unique<'_, vk::DescriptorSetLayout>>> =
            (0..num_sets).map(|_| None).collect();
        let mut desc_set_ptrs: Vec<Option<UniqueDescriptorSet<'_>>> = (0..num_sets).map(|_| None).collect();
        let mut desc_sets: Vec<vk::DescriptorSet> = vec![vk::DescriptorSet::null(); num_sets];
        for (&set_id, bindings) in &self.ops.sets {
            // create layout of each binding within the set
            let layout_bindings: Vec<vk::DescriptorSetLayoutBinding> = bindings
                .iter()
                .map(|&idx| {
                    let desc = &self.ops.all_descriptors[idx];
                    vk::DescriptorSetLayoutBinding {
                        binding: desc.binding,
                        descriptor_type: vk::DescriptorType::INLINE_UNIFORM_BLOCK,
                        descriptor_count: desc.size,
                        stage_flags: vk::ShaderStageFlags::FRAGMENT,
                        immutable_samplers: std::ptr::null(),
                    }
                })
                .collect();

            // create layout of the descriptor set
            let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&layout_bindings);
            let layout = Unique::new(
                vk,
                unsafe { vk.create_descriptor_set_layout(&layout_info, None) }
                    .vk_check("vkCreateDescriptorSetLayout")?,
            );

            // allocate the descriptor set
            let set = make_descriptor_set(vk, *desc_pool, *layout)?;
            desc_sets[set_id as usize] = set.get();
            desc_set_layouts[set_id as usize] = Some(layout);
            desc_set_ptrs[set_id as usize] = Some(set);
        }

        // Descriptor update
        {
            let iub_writes: Vec<vk::WriteDescriptorSetInlineUniformBlock> = self
                .ops
                .writes
                .iter()
                .map(|write_op| {
                    let desc = &self.ops.all_descriptors[write_op.descriptor];
                    vk::WriteDescriptorSetInlineUniformBlock {
                        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET_INLINE_UNIFORM_BLOCK,
                        next: std::ptr::null(),
                        data_size: write_op.write_size,
                        data: (&desc.data_to_write[write_op.write_index as usize] as *const u32).cast(),
                    }
                })
                .collect();

            let writes: Vec<vk::WriteDescriptorSet> = self
                .ops
                .writes
                .iter()
                .zip(iub_writes.iter())
                .map(|(write_op, iub_write)| {
                    let desc = &self.ops.all_descriptors[write_op.descriptor];
                    vk::WriteDescriptorSet {
                        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                        next: (iub_write as *const vk::WriteDescriptorSetInlineUniformBlock).cast(),
                        dst_set: desc_sets[desc.set as usize],
                        dst_binding: desc.binding,
                        dst_array_element: write_op.write_offset,
                        descriptor_count: write_op.write_size,
                        descriptor_type: vk::DescriptorType::INLINE_UNIFORM_BLOCK,
                        image_info: std::ptr::null(),
                        buffer_info: std::ptr::null(),
                        texel_buffer_view: std::ptr::null(),
                    }
                })
                .collect();

            let copies: Vec<vk::CopyDescriptorSet> = self
                .ops
                .copies
                .iter()
                .map(|copy_op| {
                    let src = &self.ops.all_descriptors[copy_op.src_descriptor];
                    let dest = &self.ops.all_descriptors[copy_op.dest_descriptor];
                    vk::CopyDescriptorSet {
                        s_type: vk::StructureType::COPY_DESCRIPTOR_SET,
                        next: std::ptr::null(),
                        src_set: desc_sets[src.set as usize],
                        src_binding: src.binding,
                        src_array_element: copy_op.src_offset,
                        dst_set: desc_sets[dest.set as usize],
                        dst_binding: dest.binding,
                        dst_array_element: copy_op.dest_offset,
                        descriptor_count: copy_op.copy_size,
                    }
                })
                .collect();

            unsafe { vk.update_descriptor_sets(&writes, &copies) };
        }

        // create pipeline and bind desc layout
        let desc_set_layout_handles: Vec<vk::DescriptorSetLayout> = desc_set_layouts
            .iter()
            .map(|l| **l.as_ref().expect("every set has a layout"))
            .collect();
        let pipeline_layout = make_pipeline_layout(vk, &desc_set_layout_handles)?;

        // create image and image view that will hold rendered frame
        let color_image_create_info = make_image_create_info(
            IVec2::new(RENDER_SIZE.0 as i32, RENDER_SIZE.1 as i32),
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        );
        let color_image = ImageWithMemory::new(vk, allocator, color_image_create_info, MemoryRequirement::ANY)?;
        let color_image_view = make_image_view(
            vk,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // create renderpass and framebuffer
        let render_pass = make_render_pass(vk, color_format)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_image_view], RENDER_SIZE.0, RENDER_SIZE.1, 1)?;

        // create output buffer for verification
        let output_buffer_data_size = (RENDER_SIZE.0 * RENDER_SIZE.1 * 4) as vk::DeviceSize;
        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(output_buffer_data_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create graphics pipeline
        let pipeline = {
            let vertex_shader_module = create_shader_module(vk, self.context.get_binary_collection().get("vert")?)?;
            let fragment_shader_module = create_shader_module(vk, self.context.get_binary_collection().get("frag")?)?;

            make_graphics_pipeline(
                vk,
                *pipeline_layout,
                *vertex_shader_module,
                *fragment_shader_module,
                *render_pass,
                RENDER_SIZE,
                vk::PrimitiveTopology::TRIANGLE_LIST,
            )?
        };

        // Run verification shader
        {
            let cmd_pool = make_command_pool(vk, queue_family_index)?;
            let command_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let command_buffer = command_buffer.get();
            begin_command_buffer(vk, command_buffer)?;

            let render_area = make_rect_2d(0, 0, RENDER_SIZE.0, RENDER_SIZE.1);
            begin_render_pass(
                vk,
                command_buffer,
                *render_pass,
                *framebuffer,
                render_area,
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [1.0, 0.0, 0.0, 1.0],
                    },
                },
            );

            unsafe {
                vk.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                vk.cmd_bind_descriptor_sets(
                    command_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &desc_sets,
                    &[],
                );

                vk.cmd_draw(command_buffer, 6, 1, 0, 0);
            }
            end_render_pass(vk, command_buffer);

            // `copyImageToBuffer`
            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: RENDER_SIZE.0,
                    height: RENDER_SIZE.1,
                    depth: 1,
                },
            };
            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                output_buffer_data_size,
            );
            unsafe {
                vk.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
                vk.cmd_copy_image_to_buffer(
                    command_buffer,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    output_buffer.get(),
                    &[copy_region],
                );
                vk.cmd_pipeline_barrier(
                    command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(vk, command_buffer)?;
            submit_commands_and_wait(vk, queue, command_buffer)?;
        }

        invalidate_alloc(vk, output_buffer.get_allocation())?;

        let result = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                output_buffer_data_size as usize,
            )
        };
        let test_ok = self.verify_result_image(result);

        Ok(if test_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Rendered image(s) are incorrect")
        })
    }
}

/// `createDescriptorInlineUniformTests`
pub fn create_descriptor_inline_uniform_tests() -> TestCaseGroup {
    use crate::generated::shaders::binding_model_inline_uniform as g;

    let mut iub_group = TestCaseGroup::new("inline_uniform_blocks");

    // createInlineUniformWriteTests
    for case in [
        g::IUB_WRITE_SIZE_4,
        g::IUB_WRITE_SIZE_8,
        g::IUB_WRITE_SIZE_16,
        g::IUB_WRITE_OFFSET_NONZERO,
    ] {
        iub_group.add_child(Box::new(case) as Box<dyn TestCase>);
    }

    // createInlineUniformCopyTests
    for case in [
        g::IUB_COPY_SIZE_4,
        g::IUB_COPY_SIZE_8,
        g::IUB_COPY_SIZE_16,
        g::IUB_COPY_AT_OFFSET_NONZERO,
        g::IUB_COPY_FROM_OFFSET_NONZERO,
    ] {
        iub_group.add_child(Box::new(case) as Box<dyn TestCase>);
    }

    iub_group
}
