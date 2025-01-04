// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineImageSlicedViewOf3DTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders depend on the parameters of each case, so the manifest holds
// one program set per distinct combination and `programs()` looks the right one up.

use std::collections::BTreeSet;

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_sliced_view::ALL_SLICED_VIEW_PROGRAMS;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 8;
const HEIGHT: u32 = 8;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UINT;
const VERTEX_COUNT: u32 = 3;
const USAGE_LAYOUT: vk::ImageLayout = vk::ImageLayout::GENERAL;
const REMAINING_3D_SLICES_EXT: u32 = u32::MAX;

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct SlicedViewPrograms {
    pub name: &'static str,
    pub test_type: &'static str,
    pub stage: &'static str,
    pub range: u32,
    pub width: u32,
    pub height: u32,
    pub sample_depth: u32,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Load,
    Store,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    /// Compute or fragment.
    stage: vk::ShaderStageFlags,
    width: u32,
    height: u32,
    depth: u32,
    offset: u32,
    // We want to test both normal ranges and VK_REMAINING_3D_SLICES_EXT, but in the latter case we cannot blindly use the range
    // value for some operations. See actual_range() and sliced_view_range().
    range: u32,
    mip_level: Option<u32>,
    sample_img: bool,
}

impl TestParams {
    #[allow(clippy::too_many_arguments)]
    fn new(
        test_type: TestType,
        stage: vk::ShaderStageFlags,
        width: u32,
        height: u32,
        depth: u32,
        offset: u32,
        range: u32,
        mip_level: Option<u32>,
        sample_img: bool,
    ) -> Self {
        Self {
            test_type,
            stage,
            width,
            height,
            depth,
            offset,
            range,
            mip_level,
            sample_img,
        }
    }

    fn use_mip_maps(&self) -> bool {
        self.mip_level.is_some()
    }

    fn use_remaining_slices(&self) -> bool {
        self.range == REMAINING_3D_SLICES_EXT
    }

    fn selected_level(&self) -> u32 {
        self.mip_level.unwrap_or(0)
    }

    fn full_image_levels(&self) -> u32 {
        if self.use_mip_maps() {
            Self::max_mip_level_count_for_size(self.depth)
        } else {
            1
        }
    }

    fn actual_range(&self) -> u32 {
        let level_depth = self.depth >> self.selected_level();
        if self.use_remaining_slices() {
            level_depth - self.offset
        } else {
            self.range
        }
    }

    fn sliced_view_range(&self) -> u32 {
        self.range
    }

    fn slice_extent(&self) -> vk::Extent3D {
        let selected_level = self.selected_level();
        vk::Extent3D {
            width: self.width >> selected_level,
            height: self.height >> selected_level,
            depth: self.actual_range(),
        }
    }

    fn full_level_extent(&self) -> vk::Extent3D {
        let selected_level = self.selected_level();
        vk::Extent3D {
            width: self.width >> selected_level,
            height: self.height >> selected_level,
            depth: self.depth >> selected_level,
        }
    }

    /// `deLog2Floor32(size) + 1`
    fn max_mip_level_count_for_size(size: u32) -> u32 {
        32 - size.leading_zeros()
    }

    fn stage_name(&self) -> &'static str {
        if self.stage == vk::ShaderStageFlags::COMPUTE {
            "comp"
        } else {
            "frag"
        }
    }

    fn pipeline_stage(&self) -> vk::PipelineStageFlags {
        if self.stage == vk::ShaderStageFlags::FRAGMENT {
            vk::PipelineStageFlags::FRAGMENT_SHADER
        } else {
            vk::PipelineStageFlags::COMPUTE_SHADER
        }
    }
}

struct SlicedViewTestCase {
    name: String,
    params: TestParams,
}

impl TestCase for SlicedViewTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `SlicedViewTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_image_sliced_view_of_3d")?;

        if self.params.stage == vk::ShaderStageFlags::FRAGMENT
            && context.get_device_features().fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        let test_type = if params.test_type == TestType::Load {
            "load"
        } else {
            "store"
        };
        let sample_depth = if params.sample_img {
            params.depth >> params.selected_level()
        } else {
            0
        };
        ALL_SLICED_VIEW_PROGRAMS
            .iter()
            .find(|p| {
                p.test_type == test_type
                    && p.stage == params.stage_name()
                    && p.range == params.actual_range()
                    && p.width == params.slice_extent().width
                    && p.sample_depth == sample_depth
            })
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SlicedViewTestInstance {
            context,
            params: self.params,
        })
    }
}

struct SlicedViewTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `makeTransferBuffer`
fn make_transfer_buffer<'a>(context: &'a Context<'a>, extent: vk::Extent3D) -> Result<BufferWithMemory<'a>, TestError> {
    let pixel_size_bytes = 4;
    let pixel_count = extent.width * extent.height * extent.depth;
    let buffer_size = pixel_count as vk::DeviceSize * pixel_size_bytes;
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(
            buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// `makeAndFillTransferBuffer`: a predefined pattern of RGBA8 unsigned integer pixels.
fn make_and_fill_transfer_buffer<'a>(
    context: &'a Context<'a>,
    extent: vk::Extent3D,
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = make_transfer_buffer(context, extent)?;
    let alloc = buffer.get_allocation();
    let size = (extent.width * extent.height * extent.depth * 4) as usize;
    let bytes = unsafe { std::slice::from_raw_parts_mut(alloc.get_host_ptr(), size) };

    let mut offset = 0;
    for z in 0..extent.depth {
        for y in 0..extent.height {
            for x in 0..extent.width {
                bytes[offset..offset + 4].copy_from_slice(&[(0x80 | x) as u8, (0x80 | y) as u8, (0x80 | z) as u8, 1]);
                offset += 4;
            }
        }
    }

    flush_alloc(context.get_device(), alloc)?;
    Ok(buffer)
}

/// `make3DImage`
fn make_3d_image<'a>(
    context: &'a Context<'a>,
    extent: vk::Extent3D,
    mip_levels: u32,
    sampling: bool,
) -> Result<ImageWithMemory<'a>, TestError> {
    let mut image_usage =
        vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC;
    if sampling {
        image_usage |= vk::ImageUsageFlags::SAMPLED;
    }

    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_3D)
        .format(FORMAT)
        .extent(extent)
        .mip_levels(mip_levels)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(image_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

fn make_common_image_subresource_range(base_level: u32, level_count: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, base_level, level_count, 0, 1)
}

fn make_common_image_subresource_layers(mip_level: u32) -> vk::ImageSubresourceLayers {
    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, mip_level, 0, 1)
}

/// `make3DImageView`; `slices` is (offset, range) of the sliced view.
fn make_3d_image_view<'a>(
    device: &'a Device,
    image: vk::Image,
    slices: Option<(u32, u32)>,
    mip_level: u32,
    level_count: u32,
) -> Result<Unique<'a, vk::ImageView>, TestError> {
    let (slice_offset, slice_count) = slices.unwrap_or((0, 0));
    let mut slice_create_info = vk::ImageViewSlicedCreateInfoEXT::builder()
        .slice_offset(slice_offset)
        .slice_count(slice_count);

    let mut info = vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(vk::ImageViewType::_3D)
        .format(FORMAT)
        .components(vk::ComponentMapping {
            r: vk::ComponentSwizzle::R,
            g: vk::ComponentSwizzle::G,
            b: vk::ComponentSwizzle::B,
            a: vk::ComponentSwizzle::A,
        })
        .subresource_range(make_common_image_subresource_range(mip_level, level_count));
    if slices.is_some() {
        info = info.push_next(&mut slice_create_info);
    }
    let view = unsafe { device.create_image_view(&info, None) }.vk_check("vkCreateImageView")?;
    Ok(Unique::new(device, view))
}

fn pipeline_image_memory_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

fn pipeline_memory_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::MemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// The objects `runPipeline` creates, which have to outlive the submission.
struct PipelineObjects<'a> {
    _set_layout: Unique<'a, vk::DescriptorSetLayout>,
    _descriptor_set: UniqueDescriptorSet<'a>,
    _descriptor_pool: Unique<'a, vk::DescriptorPool>,
    _pipeline_layout: Unique<'a, vk::PipelineLayout>,
    _render_pass: Option<Unique<'a, vk::RenderPass>>,
    _framebuffer: Option<Unique<'a, vk::Framebuffer>>,
    _pipeline: Unique<'a, vk::Pipeline>,
    _modules: Vec<Unique<'a, vk::ShaderModule>>,
}

impl<'a> SlicedViewTestInstance<'a> {
    /// `runPipeline`, `runGraphicsPipeline` and `runComputePipeline`
    fn run_pipeline(
        &self,
        cmd: vk::CommandBuffer,
        sliced_image: vk::ImageView,
        auxiliar_image: vk::ImageView,
    ) -> Result<PipelineObjects<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let params = &self.params;

        // The layouts created and used here must match the shaders.
        let descriptor_type = vk::DescriptorType::STORAGE_IMAGE;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, params.stage)
            .add_single_binding(descriptor_type, params.stage)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 2).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let sliced_image_info = [vk::DescriptorImageInfo::builder()
            .sampler(vk::Sampler::null())
            .image_view(sliced_image)
            .image_layout(USAGE_LAYOUT)
            .build()];
        let auxiliar_image_info = [vk::DescriptorImageInfo::builder()
            .sampler(vk::Sampler::null())
            .image_view(auxiliar_image)
            .image_layout(USAGE_LAYOUT)
            .build()];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(descriptor_type)
                .image_info(&sliced_image_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(descriptor_type)
                .image_info(&auxiliar_image_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let binaries = context.get_binary_collection();
        if params.stage == vk::ShaderStageFlags::FRAGMENT {
            let slice_extent = params.slice_extent();
            let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
            let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let framebuffer = make_framebuffer(device, *render_pass, &[], slice_extent.width, slice_extent.height, 1)?;

            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_full_viewport(slice_extent.width, slice_extent.height);
            state.color_attachment_count = 0;
            let pipeline = create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_shader),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
                ],
                &state,
            )?;

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(slice_extent.width, slice_extent.height));
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_draw(cmd, VERTEX_COUNT, slice_extent.depth, 0, 0);
                device.cmd_end_render_pass(cmd);
            }

            Ok(PipelineObjects {
                _set_layout: set_layout,
                _descriptor_pool: descriptor_pool,
                _descriptor_set: descriptor_set,
                _pipeline_layout: pipeline_layout,
                _render_pass: Some(render_pass),
                _framebuffer: Some(framebuffer),
                _pipeline: pipeline,
                _modules: vec![vert_shader, frag_shader],
            })
        } else {
            let comp_shader = create_shader_module(device, binaries.get("comp")?)?;
            let pipeline = create_compute_pipeline(device, *pipeline_layout, *comp_shader)?;

            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get());
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd, params.actual_range(), 1, 1);
            }

            Ok(PipelineObjects {
                _set_layout: set_layout,
                _descriptor_pool: descriptor_pool,
                _descriptor_set: descriptor_set,
                _pipeline_layout: pipeline_layout,
                _render_pass: None,
                _framebuffer: None,
                _pipeline: pipeline,
                _modules: vec![comp_shader],
            })
        }
    }

    /// `runSamplingPipeline`: samples the whole level through the sliced view to verify it is available.
    fn run_sampling_pipeline(
        &self,
        full_image: vk::Image,
        sliced_view: vk::ImageView,
        level_extent: vk::Extent3D,
    ) -> Result<bool, TestError> {
        let context = self.context;
        let device = context.get_device();

        let pipeline_stage = vk::PipelineStageFlags::COMPUTE_SHADER;
        let shader_stage = vk::ShaderStageFlags::COMPUTE;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Descriptor set layout and pipeline layout.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, shader_stage)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, shader_stage)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        // Pipeline.
        let binaries = context.get_binary_collection();
        let comp_shader = create_shader_module(device, binaries.get("compSample")?)?;
        let pipeline = create_compute_pipeline(device, *pipeline_layout, *comp_shader)?;

        // Descriptor pool and set.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        // Update descriptor set.
        let sampler_create_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::INT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        // This will be used as a storage image to verify the sampling results. It has the same size as the full level extent, but
        // only a single level and not sliced.
        let auxiliar_image = make_3d_image(context, level_extent, 1, false)?;
        let auxiliar_view = make_3d_image_view(device, auxiliar_image.get(), None, 0, 1)?;

        let sampled_image_info = [vk::DescriptorImageInfo::builder()
            .sampler(*sampler)
            .image_view(sliced_view)
            .image_layout(USAGE_LAYOUT)
            .build()];
        let storage_image_info = [vk::DescriptorImageInfo::builder()
            .sampler(vk::Sampler::null())
            .image_view(*auxiliar_view)
            .image_layout(USAGE_LAYOUT)
            .build()];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&sampled_image_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&storage_image_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let verif_buffer = make_transfer_buffer(context, level_extent)?;
        let ref_buffer = make_transfer_buffer(context, level_extent)?;

        begin_command_buffer(device, cmd)?;

        // Move auxiliar image to the proper layout.
        let shader_access = vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::SHADER_READ;
        let color_srr = make_common_image_subresource_range(0, 1);
        let pre_dispatch_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            shader_access,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            auxiliar_image.get(),
            color_srr,
        );
        pipeline_image_memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            pipeline_stage,
            pre_dispatch_barrier,
        );

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
        }

        // Sync shader writes before copying to verification buffer.
        let pre_copy_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::TRANSFER_READ);
        pipeline_memory_barrier(
            device,
            cmd,
            pipeline_stage,
            vk::PipelineStageFlags::TRANSFER,
            pre_copy_barrier,
        );

        // Copy storage image to verification buffer.
        let color_srl = make_common_image_subresource_layers(0);
        let copy_region = make_buffer_image_copy(level_extent, color_srl);
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                auxiliar_image.get(),
                USAGE_LAYOUT,
                verif_buffer.get(),
                &[copy_region],
            )
        };

        // Copy full level from the original full image to the reference buffer to compare them.
        let ref_srl = make_common_image_subresource_layers(self.params.selected_level());
        let ref_copy = make_buffer_image_copy(level_extent, ref_srl);
        unsafe { device.cmd_copy_image_to_buffer(cmd, full_image, USAGE_LAYOUT, ref_buffer.get(), &[ref_copy]) };

        // Sync copies to host.
        let post_copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        pipeline_memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            post_copy_barrier,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Compare both buffers.
        let verif_alloc = verif_buffer.get_allocation();
        let ref_alloc = ref_buffer.get_allocation();
        invalidate_alloc(device, verif_alloc)?;
        invalidate_alloc(device, ref_alloc)?;

        let size = (level_extent.width * level_extent.height * level_extent.depth * 4) as usize;
        let verif = unsafe { std::slice::from_raw_parts(verif_alloc.get_host_ptr(), size) };
        let reference = unsafe { std::slice::from_raw_parts(ref_alloc.get_host_ptr(), size) };
        Ok(verif == reference)
    }

    /// `SlicedViewLoadTestInstance::iterate` and `SlicedViewStoreTestInstance::iterate`
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = &self.params;
        let load = params.test_type == TestType::Load;

        let mip_level = params.selected_level();
        let full_extent = vk::Extent3D {
            width: params.width,
            height: params.height,
            depth: params.depth,
        };
        let slice_extent = params.slice_extent();
        let auxiliar_buffer = make_and_fill_transfer_buffer(context, slice_extent)?;
        let verif_buffer = make_transfer_buffer(context, slice_extent)?;
        let full_image = make_3d_image(context, full_extent, params.full_image_levels(), params.sample_img)?;
        let full_srr = make_common_image_subresource_range(0, vk::REMAINING_MIP_LEVELS);
        let single_srr = make_common_image_subresource_range(0, 1);
        let target_level_srl = make_common_image_subresource_layers(mip_level);
        let base_level_srl = make_common_image_subresource_layers(0);
        let clear_color = vk::ClearColorValue { uint32: [0, 0, 0, 0] };
        let pipeline_stage = params.pipeline_stage();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        // Zero-out full image.
        let pre_clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            full_image.get(),
            full_srr,
        );
        pipeline_image_memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            pre_clear_barrier,
        );
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                full_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color,
                &[full_srr],
            )
        };

        let slice_copy_to_full = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: target_level_srl,
            image_offset: vk::Offset3D {
                x: 0,
                y: 0,
                z: params.offset as i32,
            },
            image_extent: slice_extent,
        };

        // Sliced view of the full image, and the auxiliar image and view with reduced size.
        let sliced_view = make_3d_image_view(
            device,
            full_image.get(),
            Some((params.offset, params.sliced_view_range())),
            mip_level,
            1,
        )?;
        let auxiliar_image = make_3d_image(context, slice_extent, 1, false)?;
        let auxiliar_view = make_3d_image_view(device, auxiliar_image.get(), None, 0, 1)?;

        if load {
            // Copy reference buffer to full image at the right offset.
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                full_image.get(),
                full_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                pre_copy_barrier,
            );
            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd,
                    auxiliar_buffer.get(),
                    full_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[slice_copy_to_full],
                )
            };

            // Move full image to the general layout to be able to read from or write to it from the shader.
            // Note: read-only optimal is not a valid layout for this.
            let post_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                USAGE_LAYOUT,
                full_image.get(),
                full_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                pipeline_stage,
                post_copy_barrier,
            );

            // Move the auxiliar image to the general layout for writing.
            let pre_write_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                USAGE_LAYOUT,
                auxiliar_image.get(),
                single_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                pipeline_stage,
                pre_write_barrier,
            );
        } else {
            // Copy reference buffer into auxiliar image.
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                auxiliar_image.get(),
                single_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                pre_copy_barrier,
            );
            let slice_copy = make_buffer_image_copy(slice_extent, base_level_srl);
            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd,
                    auxiliar_buffer.get(),
                    auxiliar_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[slice_copy],
                )
            };

            // Move both images to the general layout for reading and writing.
            // Note: read-only optimal is not a valid layout for the read image.
            let pre_shader_barrier_aux = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                USAGE_LAYOUT,
                auxiliar_image.get(),
                single_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                pipeline_stage,
                pre_shader_barrier_aux,
            );
            let pre_shader_barrier_full = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                USAGE_LAYOUT,
                full_image.get(),
                full_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                pipeline_stage,
                pre_shader_barrier_full,
            );
        }

        // Run the load or store operation.
        let _pipeline_objects = self.run_pipeline(cmd, *sliced_view, *auxiliar_view)?;

        // Copy the result to the verification buffer: the auxiliar image for loads, the right section of the full image for stores.
        let pre_verif_copy_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::TRANSFER_READ);
        pipeline_memory_barrier(
            device,
            cmd,
            pipeline_stage,
            vk::PipelineStageFlags::TRANSFER,
            pre_verif_copy_barrier,
        );
        if load {
            let verif_copy_region = make_buffer_image_copy(slice_extent, base_level_srl);
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    auxiliar_image.get(),
                    USAGE_LAYOUT,
                    verif_buffer.get(),
                    &[verif_copy_region],
                )
            };
        } else {
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    full_image.get(),
                    USAGE_LAYOUT,
                    verif_buffer.get(),
                    &[slice_copy_to_full],
                )
            };
        }

        // Sync verification buffer with host reads.
        let pre_host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        pipeline_memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            pre_host_barrier,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Invalidate verification buffer allocation.
        let verif_alloc = verif_buffer.get_allocation();
        invalidate_alloc(device, verif_alloc)?;

        // Compare auxiliar buffer and verification buffer.
        let size = (slice_extent.width * slice_extent.height * slice_extent.depth * 4) as usize;
        let initial_image =
            unsafe { std::slice::from_raw_parts(auxiliar_buffer.get_allocation().get_host_ptr(), size) };
        let final_image = unsafe { std::slice::from_raw_parts(verif_alloc.get_host_ptr(), size) };
        if initial_image != final_image {
            return Ok(TestStatus::fail("Image comparison failed; check log for details"));
        }

        if params.sample_img
            && !self.run_sampling_pipeline(full_image.get(), *sliced_view, params.full_level_extent())?
        {
            return Ok(TestStatus::fail("Sampling full level failed; check log for details"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for SlicedViewTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// Picks `offset` and `range` the way both pseudorandom groups do, retrying until the case is one `generated_cases` has not seen.
/// `depth_bound` is the depth the offset and range are drawn against.
fn draw_offset_and_range(
    rnd: &mut Random,
    depth_bound: u32,
    mut already_generated: impl FnMut(u32, u32) -> bool,
) -> (u32, u32) {
    loop {
        let offset = rnd.get_int(0, depth_bound as i32 - 1) as u32;
        let mut range = rnd.get_int(0, (depth_bound - offset) as i32) as u32;

        // 0 is interpreted as VK_REMAINING_3D_SLICES_EXT.
        if range == 0 {
            range = REMAINING_3D_SLICES_EXT;
        }

        if !already_generated(offset, range) {
            return (offset, range);
        }
    }
}

fn range_string(range: u32) -> String {
    if range == REMAINING_3D_SLICES_EXT {
        "remaining_3d_slices".to_string()
    } else {
        range.to_string()
    }
}

/// `createImageSlicedViewOf3DTests`
pub fn create_sliced_view_of_3d_tests() -> TestCaseGroup {
    let mut image_tests = TestCaseGroup::new("sliced_view_of_3d_image");

    let stage_cases = [
        (vk::ShaderStageFlags::COMPUTE, "comp"),
        (vk::ShaderStageFlags::FRAGMENT, "frag"),
    ];
    let test_type_cases = [(TestType::Load, "load"), (TestType::Store, "store")];
    let sampling_cases = [(false, ""), (true, "_with_sampling")];

    let seed = 1667817299u32;
    let mut rnd = Random::new(seed);

    // Basic tests with 2 slices and a view of the first or second slice.
    {
        let basic_depth = 2;
        let basic_range = 1;

        let mut basic_tests = TestCaseGroup::new("basic");
        for (test_type, test_type_name) in test_type_cases {
            let mut test_type_group = TestCaseGroup::new(test_type_name);
            for (stage, stage_name) in stage_cases {
                let mut stage_group = TestCaseGroup::new(stage_name);
                for offset in 0..basic_depth {
                    for (sample_img, suffix) in sampling_cases {
                        let test_name = format!("offset_{offset}{suffix}");
                        let params = TestParams::new(
                            test_type,
                            stage,
                            WIDTH,
                            HEIGHT,
                            basic_depth,
                            offset,
                            basic_range,
                            None,
                            sample_img,
                        );
                        stage_group.add_child(Box::new(SlicedViewTestCase {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
                test_type_group.add_child(stage_group);
            }
            basic_tests.add_child(test_type_group);
        }
        image_tests.add_child(basic_tests);
    }

    // Full slice tests.
    {
        let full_depth = 4;

        let mut full_slice_tests = TestCaseGroup::new("full_slice");
        for (test_type, test_type_name) in test_type_cases {
            let mut test_type_group = TestCaseGroup::new(test_type_name);
            for (stage, stage_name) in stage_cases {
                for (sample_img, suffix) in sampling_cases {
                    let test_name = format!("{stage_name}{suffix}");
                    let params = TestParams::new(
                        test_type, stage, WIDTH, HEIGHT, full_depth, 0, full_depth, None, sample_img,
                    );
                    test_type_group.add_child(Box::new(SlicedViewTestCase {
                        name: test_name,
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
            full_slice_tests.add_child(test_type_group);
        }
        image_tests.add_child(full_slice_tests);
    }

    // Pseudorandom test cases.
    {
        let depth_cases = 5;
        let range_cases = 5;
        let min_depth = 10;
        let max_depth = 32;

        let mut random_tests = TestCaseGroup::new("random");
        for (test_type, test_type_name) in test_type_cases {
            let mut test_type_group = TestCaseGroup::new(test_type_name);
            for (stage, stage_name) in stage_cases {
                let mut stage_group = TestCaseGroup::new(stage_name);

                // depth, offset, range
                let mut generated_cases: BTreeSet<(u32, u32, u32)> = BTreeSet::new();

                for _ in 0..depth_cases {
                    let depth = rnd.get_int(min_depth, max_depth) as u32;

                    for _ in 0..range_cases {
                        // The current seed may generate duplicate cases with non-unique names, so those are filtered out.
                        let (offset, range) = draw_offset_and_range(&mut rnd, depth, |offset, range| {
                            !generated_cases.insert((depth, offset, range))
                        });

                        let test_name = format!("depth_{depth}_offset_{offset}_range_{}", range_string(range));
                        let params =
                            TestParams::new(test_type, stage, WIDTH, HEIGHT, depth, offset, range, None, false);
                        stage_group.add_child(Box::new(SlicedViewTestCase {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
                test_type_group.add_child(stage_group);
            }
            random_tests.add_child(test_type_group);
        }
        image_tests.add_child(random_tests);
    }

    // Mip level test cases.
    {
        let cases_per_level = 2;
        let (width, height, depth) = (WIDTH, WIDTH, WIDTH);
        let max_levels = TestParams::max_mip_level_count_for_size(WIDTH);

        let mut mip_level_tests = TestCaseGroup::new("mip_level");
        for (test_type, test_type_name) in test_type_cases {
            let mut test_type_group = TestCaseGroup::new(test_type_name);
            for (stage, stage_name) in stage_cases {
                let mut stage_group = TestCaseGroup::new(stage_name);

                for level in 0..max_levels {
                    let level_size = depth >> level;
                    let mut level_group = TestCaseGroup::new(format!("level_{level}"));

                    // offset, range
                    let mut generated_cases: BTreeSet<(u32, u32)> = BTreeSet::new();

                    // Generate a few pseudorandom cases per mip level.
                    for _ in 0..cases_per_level {
                        let (offset, range) = draw_offset_and_range(&mut rnd, level_size, |offset, range| {
                            !generated_cases.insert((offset, range))
                        });

                        let test_name = format!("offset_{offset}_range_{}", range_string(range));
                        let params = TestParams::new(
                            test_type,
                            stage,
                            width,
                            height,
                            depth,
                            offset,
                            range,
                            Some(level),
                            false,
                        );
                        level_group.add_child(Box::new(SlicedViewTestCase {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                    stage_group.add_child(level_group);
                }
                test_type_group.add_child(stage_group);
            }
            mip_level_tests.add_child(test_type_group);
        }
        image_tests.add_child(mip_level_tests);
    }

    image_tests
}
