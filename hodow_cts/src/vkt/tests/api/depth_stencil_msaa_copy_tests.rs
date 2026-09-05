// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyDepthStencilMSAATests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A multisampled depth/stencil image cannot be read back to the host: there is no
// buffer copy for individual samples. So the check is done on the device. A second
// render pass takes both images as multisampled subpass inputs - one attachment for
// the source and one per destination layer - and a full-screen quad writes every
// sample of both to a pair of SSBOs, which the host then compares region by region.

use vulkanalia::prelude::v1_0::*;

use super::copies_buffer_tests::AllocationKind;
use super::copies_image_tests::get_aspect_flags;
use crate::tcu::pixel::{has_depth_component, has_stencil_component};
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set, make_framebuffer};
use crate::vk::programs::{BinaryCollection, create_shader_module};
// Re-exported so the generated shader module, which imports this one wholesale, can
// name the type its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `defaultExtent` / `defaultHalfSize`
const DEFAULT_SIZE: u32 = 64;
const DEFAULT_HALF_SIZE: u32 = DEFAULT_SIZE / 2;
/// `samples[]`
const SAMPLES: [vk::SampleCountFlags; 6] = [
    vk::SampleCountFlags::_2,
    vk::SampleCountFlags::_4,
    vk::SampleCountFlags::_8,
    vk::SampleCountFlags::_16,
    vk::SampleCountFlags::_32,
    vk::SampleCountFlags::_64,
];
/// `m_clearValue` - what the destination starts as, and what the layers the copy does
/// not touch must still hold.
const CLEAR_VALUE: f32 = 0.0;

/// `DepthStencilMSAA::CopyOptions`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum CopyOptions {
    WholeImage,
    ArrayToArray,
    Partial,
}

/// One `VkImageCopy` of the ported shape: a single aspect, single layer per side.
#[derive(Clone, Copy)]
struct Region {
    aspect: vk::ImageAspectFlags,
    src_offset: [i32; 3],
    dst_offset: [i32; 3],
    extent: [u32; 3],
    src_base_layer: u32,
    dst_base_layer: u32,
}

impl Region {
    fn to_vk(self) -> vk::ImageCopy {
        let layers = |base: u32| vk::ImageSubresourceLayers {
            aspect_mask: self.aspect,
            mip_level: 0,
            base_array_layer: base,
            layer_count: 1,
        };
        vk::ImageCopy {
            src_subresource: layers(self.src_base_layer),
            src_offset: vk::Offset3D {
                x: self.src_offset[0],
                y: self.src_offset[1],
                z: self.src_offset[2],
            },
            dst_subresource: layers(self.dst_base_layer),
            dst_offset: vk::Offset3D {
                x: self.dst_offset[0],
                y: self.dst_offset[1],
                z: self.dst_offset[2],
            },
            extent: vk::Extent3D {
                width: self.extent[0],
                height: self.extent[1],
                depth: self.extent[2],
            },
        }
    }
}

/// `DepthStencilMSAATestCase`
pub struct DepthStencilMsaaCase {
    name: String,
    copy_options: CopyOptions,
    samples: vk::SampleCountFlags,
    src_image_layout: vk::ImageLayout,
    dst_image_layout: vk::ImageLayout,
    image_format: vk::Format,
    copy_aspect: vk::ImageAspectFlags,
    image_offset: bool,
    allocation_kind: AllocationKind,
}

impl DepthStencilMsaaCase {
    /// `getArrayLayerCount`
    fn array_layer_count(&self) -> u32 {
        if self.copy_options == CopyOptions::ArrayToArray { 5 } else { 1 }
    }

    /// The manifest entry the verification pass runs, chosen by the aspect being
    /// checked and how many destination layers there are.
    fn verify_program(&self, aspect: vk::ImageAspectFlags) -> &'static SharedProgram {
        use crate::generated::shaders::api_ds_msaa_copy as sh;
        let stencil = aspect == vk::ImageAspectFlags::STENCIL;
        match (stencil, self.copy_options == CopyOptions::ArrayToArray) {
            (false, false) => &sh::DS_MSAA_VERIFY_DEPTH_SINGLE,
            (true, false) => &sh::DS_MSAA_VERIFY_STENCIL_SINGLE,
            (false, true) => &sh::DS_MSAA_VERIFY_DEPTH_ARRAY,
            (true, true) => &sh::DS_MSAA_VERIFY_STENCIL_ARRAY,
        }
    }

    /// The copy regions, which follow the option and the aspects being copied.
    fn regions(&self) -> Vec<Region> {
        let (src_base, dst_base) = if self.copy_options == CopyOptions::ArrayToArray { (2, 3) } else { (0, 0) };
        let mut out = Vec::new();
        for aspect in [vk::ImageAspectFlags::DEPTH, vk::ImageAspectFlags::STENCIL] {
            if !self.copy_aspect.contains(aspect) {
                continue;
            }
            if self.copy_options == CopyOptions::Partial {
                // Bottom right to bottom left, then top right to bottom right.
                for (src_offset, dst_offset) in [
                    ([DEFAULT_HALF_SIZE as i32, DEFAULT_HALF_SIZE as i32, 0], [0, DEFAULT_HALF_SIZE as i32, 0]),
                    ([DEFAULT_HALF_SIZE as i32, 0, 0], [DEFAULT_HALF_SIZE as i32, DEFAULT_HALF_SIZE as i32, 0]),
                ] {
                    out.push(Region {
                        aspect,
                        src_offset,
                        dst_offset,
                        extent: [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1],
                        src_base_layer: src_base,
                        dst_base_layer: dst_base,
                    });
                }
            } else {
                out.push(Region {
                    aspect,
                    src_offset: [0, 0, 0],
                    dst_offset: [0, 0, 0],
                    extent: [DEFAULT_SIZE, DEFAULT_SIZE, 1],
                    src_base_layer: src_base,
                    dst_base_layer: dst_base,
                });
            }
        }
        out
    }
}

impl TestCase for DepthStencilMsaaCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        if context.get_device_features().fragment_stores_and_atomics == 0 {
            return Err(TestError::NotSupported("fragmentStoresAndAtomics not supported".to_string()));
        }

        // Upstream checks framebufferDepthSampleCounts for both aspects; the stencil
        // branch reads the same limit, which is why there is only one check here.
        let limits = context.get_device_properties().limits;
        if !limits.framebuffer_depth_sample_counts.contains(self.samples) {
            return Err(TestError::NotSupported("Unsupported number of depth samples".to_string()));
        }

        let usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::INPUT_ATTACHMENT;
        unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.image_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::api_ds_msaa_copy::DS_MSAA_FILL.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthStencilMsaaInstance { context, params: self })
    }
}

struct DepthStencilMsaaInstance<'a> {
    context: &'a Context<'a>,
    params: &'a DepthStencilMsaaCase,
}

impl DepthStencilMsaaInstance<'_> {
    fn make_ds_image(&self, layers: u32, offset_bind: bool) -> Result<ImageWithMemory<'_>, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: p.image_format,
            extent: vk::Extent3D {
                width: DEFAULT_SIZE,
                height: DEFAULT_SIZE,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: layers,
            samples: p.samples,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::INPUT_ATTACHMENT,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(device, allocator, info, MemoryRequirement::ANY)
        } else if offset_bind {
            ImageWithMemory::new_at_alignment_offset(device, allocator, info, MemoryRequirement::ANY)
        } else {
            ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)
        }
    }
}

impl TestInstance for DepthStencilMsaaInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let tcu_format = map_vk_format(p.image_format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let full_aspect = get_aspect_flags(p.image_format);
        let src_layers = p.array_layer_count();
        let dst_layers = p.array_layer_count();

        let src_image = self.make_ds_image(src_layers, false)?;
        let dst_image = self.make_ds_image(dst_layers, p.image_offset)?;

        // 1. Fill the source with a draw. The vertex shader forces z to 1.0, so the
        // depth written is the far plane wherever the triangle covers, and the stencil
        // op replaces with 0xFF.
        let programs = p.programs();
        let vert = create_shader_module(device, programs.get("vert")?)?;
        let frag = create_shader_module(device, programs.get("frag")?)?;
        let render_pass = make_ds_render_pass(device, p.image_format, p.samples)?;
        let src_view = make_image_view(
            device,
            src_image.get(),
            vk::ImageViewType::_2D,
            p.image_format,
            make_image_subresource_range(full_aspect, 0, 1, if p.copy_options == CopyOptions::ArrayToArray { 2 } else { 0 }, 1),
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*src_view], DEFAULT_SIZE, DEFAULT_SIZE, 1)?;
        let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(device, &[])?;
        let fill_pipeline = make_ds_fill_pipeline(device, *pipeline_layout, *vert, *frag, *render_pass, p.samples, p.copy_aspect)?;

        // The same triangle upstream draws: the upper-right half of the target.
        let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0]];
        let vertex_buffer = upload_vertices(device, allocator, &vertices)?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let src_range = make_image_subresource_range(full_aspect, 0, 1, 0, src_layers);
        let dst_range = make_image_subresource_range(full_aspect, 0, 1, 0, dst_layers);

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            // Both images start UNDEFINED; clear them to their starting values.
            let to_dst = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    src_image.get(),
                    src_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    dst_image.get(),
                    dst_range,
                ),
            ];
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &to_dst,
            );

            let src_clear = vk::ClearDepthStencilValue { depth: 0.1, stencil: 0x10 };
            let dst_clear = vk::ClearDepthStencilValue {
                depth: CLEAR_VALUE,
                stencil: CLEAR_VALUE as u32,
            };
            device.cmd_clear_depth_stencil_image(*cmd_buffer, src_image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &src_clear, &[src_range]);
            device.cmd_clear_depth_stencil_image(*cmd_buffer, dst_image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &dst_clear, &[dst_range]);

            let to_attachment = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                src_image.get(),
                src_range,
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_attachment],
            );

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: DEFAULT_SIZE,
                        height: DEFAULT_SIZE,
                    },
                });
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *fill_pipeline);
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);

            // 2. Copy, then leave both images in the layouts the case asked for.
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    p.src_image_layout,
                    src_image.get(),
                    src_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    p.dst_image_layout,
                    dst_image.get(),
                    dst_range,
                ),
            ];
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &barriers,
            );

            let copies: Vec<vk::ImageCopy> = p.regions().iter().map(|r| r.to_vk()).collect();
            device.cmd_copy_image(*cmd_buffer, src_image.get(), p.src_image_layout, dst_image.get(), p.dst_image_layout, &copies);
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // 3. Verify each aspect that was copied.
        for aspect in [vk::ImageAspectFlags::DEPTH, vk::ImageAspectFlags::STENCIL] {
            if !p.copy_aspect.contains(aspect) {
                continue;
            }
            let ok = self.check_copy_results(aspect, &src_image, &dst_image, tcu_format)?;
            if !ok {
                return Ok(TestStatus::fail("Intermediate verification failed"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl DepthStencilMsaaInstance<'_> {
    /// `DepthStencilMSAA::checkCopyResults`
    fn check_copy_results(
        &self,
        aspect: vk::ImageAspectFlags,
        src_image: &ImageWithMemory<'_>,
        dst_image: &ImageWithMemory<'_>,
        _tcu_format: tcu::TextureFormat,
    ) -> Result<bool, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let dst_layers = p.array_layer_count();
        let num_input_attachments = 1 + dst_layers;
        let sample_count = sample_count_value(p.samples);
        let buffer_count = (DEFAULT_SIZE * DEFAULT_SIZE * sample_count) as usize;
        let buffer_size = (buffer_count * std::mem::size_of::<f32>()) as vk::DeviceSize;

        let make_ssbo = || {
            BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let buffer_original = make_ssbo()?;
        let buffer_copied = make_ssbo()?;

        let output_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let mut attachments_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..num_input_attachments {
            attachments_builder = attachments_builder.add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
        }
        let input_set_layout = attachments_builder.build(device)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, num_input_attachments)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let set_buffers = make_descriptor_set(device, *descriptor_pool, *output_set_layout)?;
        let set_attachments = make_descriptor_set(device, *descriptor_pool, *input_set_layout)?;

        // Attachment 0 is the source layer that was copied from; the rest are the
        // destination's layers, so the shader can check the untouched ones too.
        let mut views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
        views.push(make_image_view(
            device,
            src_image.get(),
            vk::ImageViewType::_2D,
            p.image_format,
            make_image_subresource_range(aspect, 0, 1, if p.copy_options == CopyOptions::ArrayToArray { 2 } else { 0 }, 1),
        )?);
        for layer in 0..dst_layers {
            views.push(make_image_view(
                device,
                dst_image.get(),
                vk::ImageViewType::_2D,
                p.image_format,
                make_image_subresource_range(aspect, 0, 1, layer, 1),
            )?);
        }
        let raw_views: Vec<vk::ImageView> = views.iter().map(|v| **v).collect();

        unsafe {
            let buffer_infos = [
                vk::DescriptorBufferInfo {
                    buffer: buffer_original.get(),
                    offset: 0,
                    range: buffer_size,
                },
                vk::DescriptorBufferInfo {
                    buffer: buffer_copied.get(),
                    offset: 0,
                    range: buffer_size,
                },
            ];
            let image_infos: Vec<vk::DescriptorImageInfo> = raw_views
                .iter()
                .map(|v| vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: *v,
                    image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                })
                .collect();

            let mut writes: Vec<vk::WriteDescriptorSet> = Vec::new();
            for (i, info) in buffer_infos.iter().enumerate() {
                writes.push(vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: *set_buffers,
                    dst_binding: i as u32,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                    image_info: std::ptr::null(),
                    buffer_info: info,
                    texel_buffer_view: std::ptr::null(),
                });
            }
            for (i, info) in image_infos.iter().enumerate() {
                writes.push(vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: *set_attachments,
                    dst_binding: i as u32,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
                    image_info: info,
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: std::ptr::null(),
                });
            }
            device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]);
        }

        let render_pass = make_input_attachment_render_pass(device, p.image_format, p.samples, num_input_attachments, p.src_image_layout, p.dst_image_layout)?;
        let framebuffer = make_framebuffer(device, *render_pass, &raw_views, DEFAULT_SIZE, DEFAULT_SIZE, 1)?;

        let push_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 12,
        };
        let set_layouts = [*output_set_layout, *input_set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(std::slice::from_ref(&push_range));
        let pipeline_layout = Unique::new(device, unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?);

        let programs = p.verify_program(aspect).programs;
        let vert = create_shader_module(device, programs.get("vert")?)?;
        let frag = create_shader_module(device, programs.get("frag")?)?;
        let pipeline = crate::vk::obj_util::make_graphics_pipeline_with_samples(
            device,
            *pipeline_layout,
            *vert,
            *frag,
            *render_pass,
            (DEFAULT_SIZE, DEFAULT_SIZE),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            p.samples,
        )?;

        // `fullScreenQuad` - every pixel and sample location gets verified.
        let quad: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
        ];
        let vertex_buffer = upload_vertices(device, allocator, &quad)?;

        let push_data: [i32; 3] = [DEFAULT_SIZE as i32, DEFAULT_SIZE as i32, sample_count as i32];
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: DEFAULT_SIZE,
                        height: DEFAULT_SIZE,
                    },
                });
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline_layout, 0, &[*set_buffers, *set_attachments], &[]);
            let bytes = std::slice::from_raw_parts(push_data.as_ptr().cast::<u8>(), std::mem::size_of_val(&push_data));
            device.cmd_push_constants(*cmd_buffer, *pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, bytes);
            device.cmd_draw(*cmd_buffer, quad.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        invalidate_alloc(device, buffer_original.get_allocation())?;
        invalidate_alloc(device, buffer_copied.get_allocation())?;
        let mut original = vec![0.0f32; buffer_count];
        let mut copied = vec![0.0f32; buffer_count];
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer_original.get_allocation().get_host_ptr().cast_const().cast::<f32>(),
                original.as_mut_ptr(),
                buffer_count,
            );
            std::ptr::copy_nonoverlapping(buffer_copied.get_allocation().get_host_ptr().cast_const().cast::<f32>(), copied.as_mut_ptr(), buffer_count);
        }

        let index = |x: u32, y: u32, s: u32| ((y * DEFAULT_SIZE + x) * sample_count + s) as usize;
        for region in p.regions().iter().filter(|r| r.aspect == aspect) {
            for x in 0..region.extent[0] {
                for y in 0..region.extent[1] {
                    for s in 0..sample_count {
                        let src = index(x + region.src_offset[0] as u32, y + region.src_offset[1] as u32, s);
                        let dst = index(x + region.dst_offset[0] as u32, y + region.dst_offset[1] as u32, s);
                        if original[src] != copied[dst] {
                            return Ok(false);
                        }
                    }
                }
            }
        }

        // Whatever the copy did not touch must still hold the clear value.
        if p.copy_options == CopyOptions::Partial {
            for x in 0..DEFAULT_HALF_SIZE {
                for y in 0..DEFAULT_HALF_SIZE {
                    for s in 0..sample_count {
                        if copied[index(x, y, s)] != CLEAR_VALUE {
                            return Ok(false);
                        }
                    }
                }
            }
        }

        Ok(true)
    }
}

/// `VkSampleCountFlagBits` as the number it stands for.
fn sample_count_value(samples: vk::SampleCountFlags) -> u32 {
    samples.bits()
}

fn upload_vertices<'a>(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, vertices: &[[f32; 4]]) -> Result<BufferWithMemory<'a>, TestError> {
    let size = std::mem::size_of_val(vertices) as u64;
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(vertices.as_ptr().cast::<u8>(), buffer.get_allocation().get_host_ptr(), size as usize) };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// A render pass with one depth/stencil attachment and no colour attachment.
fn make_ds_render_pass(device: &Device, format: vk::Format, samples: vk::SampleCountFlags) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment = vk::AttachmentDescription::builder()
        .format(format)
        .samples(samples)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::LOAD)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL);
    let attachments = [attachment];

    let ds_ref = vk::AttachmentReference::builder().attachment(0).layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL);
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .depth_stencil_attachment(&ds_ref);
    let subpasses = [subpass];

    let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
    Ok(Unique::new(device, unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?))
}

/// The verification pass: N multisampled input attachments, no colour and no
/// depth/stencil attachment - the shader only reads and writes buffers.
fn make_input_attachment_render_pass(
    device: &Device,
    format: vk::Format,
    samples: vk::SampleCountFlags,
    count: u32,
    src_layout: vk::ImageLayout,
    dst_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments: Vec<vk::AttachmentDescription> = (0..count)
        .map(|i| {
            // The first attachment is the source, which the copy left in its own
            // layout; the rest are destination layers.
            let initial = if i == 0 { src_layout } else { dst_layout };
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(samples)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::LOAD)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(initial)
                .final_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
                .build()
        })
        .collect();

    let refs: Vec<vk::AttachmentReference> = (0..count)
        .map(|i| vk::AttachmentReference::builder().attachment(i).layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL).build())
        .collect();
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .input_attachments(&refs);
    let subpasses = [subpass];

    let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
    Ok(Unique::new(device, unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?))
}

/// The fill pipeline: depth and stencil writes enabled for whichever aspects the case
/// copies, stencil replacing with 0xFF.
fn make_ds_fill_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    render_pass: vk::RenderPass,
    samples: vk::SampleCountFlags,
    aspects: vk::ImageAspectFlags,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::REPLACE)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::ALWAYS)
        .compare_mask(0)
        .write_mask(0xFF)
        .reference(0xFF)
        .build();
    let has_depth = aspects.contains(vk::ImageAspectFlags::DEPTH);
    let has_stencil = aspects.contains(vk::ImageAspectFlags::STENCIL);
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(has_depth)
        .depth_write_enable(has_depth)
        .depth_compare_op(vk::CompareOp::ALWAYS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(has_stencil)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    crate::vk::obj_util::make_graphics_pipeline_full(
        device,
        pipeline_layout,
        vert,
        frag,
        render_pass,
        (DEFAULT_SIZE, DEFAULT_SIZE),
        vk::PrimitiveTopology::TRIANGLE_LIST,
        samples,
        Some(&depth_stencil),
        0,
    )
}

/// `getSampleCountCaseName`
fn sample_count_case_name(samples: vk::SampleCountFlags) -> &'static str {
    match samples {
        vk::SampleCountFlags::_2 => "2_bit",
        vk::SampleCountFlags::_4 => "4_bit",
        vk::SampleCountFlags::_8 => "8_bit",
        vk::SampleCountFlags::_16 => "16_bit",
        vk::SampleCountFlags::_32 => "32_bit",
        _ => "64_bit",
    }
}

fn image_layout_case_name(layout: vk::ImageLayout) -> &'static str {
    if layout == vk::ImageLayout::GENERAL { "general" } else { "optimal" }
}

/// `addDepthStencilCopyMSAATest`
fn add_depth_stencil_copy_msaa_test(group: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind, copy_options: CopyOptions) {
    const DS_FORMATS: [(&str, vk::Format); 4] = [
        ("d32_sfloat", vk::Format::D32_SFLOAT),
        ("s8_uint", vk::Format::S8_UINT),
        ("d16_unorm_s8_uint", vk::Format::D16_UNORM_S8_UINT),
        ("d24_unorm_s8_uint", vk::Format::D24_UNORM_S8_UINT),
    ];

    for src_layout in [vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::ImageLayout::GENERAL] {
        for dst_layout in [vk::ImageLayout::TRANSFER_DST_OPTIMAL, vk::ImageLayout::GENERAL] {
            for (format_name, format) in DS_FORMATS {
                let Some(tcu_format) = map_vk_format(format) else { continue };
                let has_depth = has_depth_component(tcu_format.order);
                let has_stencil = has_stencil_component(tcu_format.order);
                // Both layouts are only crossed for the whole-image group, to keep the
                // case count down; the others use the layouts they were given once.
                let base = if copy_options == CopyOptions::WholeImage {
                    format!("{format_name}_{}_{}_", image_layout_case_name(src_layout), image_layout_case_name(dst_layout))
                } else {
                    format!("{format_name}_")
                };

                for (present, aspect, suffix) in [(has_depth, vk::ImageAspectFlags::DEPTH, "D"), (has_stencil, vk::ImageAspectFlags::STENCIL, "S")] {
                    if !present {
                        continue;
                    }
                    for samples in SAMPLES {
                        let make = |image_offset: bool| DepthStencilMsaaCase {
                            name: String::new(),
                            copy_options,
                            samples,
                            src_image_layout: src_layout,
                            dst_image_layout: dst_layout,
                            image_format: format,
                            copy_aspect: aspect,
                            image_offset,
                            allocation_kind,
                        };
                        let stem = format!("{base}{suffix}_{}", sample_count_case_name(samples));
                        group.add_child(Box::new(DepthStencilMsaaCase {
                            name: stem.clone(),
                            ..make(false)
                        }) as Box<dyn TestCase>);
                        if allocation_kind != AllocationKind::Dedicated {
                            group.add_child(Box::new(DepthStencilMsaaCase {
                                name: format!("{stem}_bind_offset"),
                                ..make(true)
                            }) as Box<dyn TestCase>);
                        }
                    }
                }
            }
            if copy_options != CopyOptions::WholeImage {
                // Only the whole-image group varies the layouts.
                break;
            }
        }
        if copy_options != CopyOptions::WholeImage {
            break;
        }
    }
}

/// `addCopyDepthStencilMSAATests`
pub fn add_depth_stencil_msaa_tests(parent: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind) {
    let mut group = tcu::TestCaseGroup::new("depth_stencil_msaa_copy");
    for (name, options) in [
        ("whole", CopyOptions::WholeImage),
        ("array_to_array", CopyOptions::ArrayToArray),
        ("partial", CopyOptions::Partial),
    ] {
        let mut sub = tcu::TestCaseGroup::new(name);
        add_depth_stencil_copy_msaa_test(&mut sub, allocation_kind, options);
        group.add_child(sub);
    }
    parent.add_child(group);
}
