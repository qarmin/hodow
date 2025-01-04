// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopiesAndBlittingReinterpretTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The base class of upstream's instance is not carried over; the case copies a whole image, then samples the source
// through a view of another format of the same texel size and checks both. The shaders are written by scripts/gen_reinterpret_manifest.py. Compressed images are filled
// and verified by compute shaders over their extent in 4x4 blocks, as upstream's `getSizeInBlocks` of the texel-counted extent does.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::copies_image_tests::{
    FillMode, ImageParms, generate_buffer, get_size_compatible_tcu_texture_format, read_image, upload_image,
};
use crate::generated::shaders::api_copy_reinterpret::{
    REINTERPRET_1D_B10G11R11, REINTERPRET_1D_BC1, REINTERPRET_1D_BC3, REINTERPRET_2D_B10G11R11, REINTERPRET_2D_BC1,
    REINTERPRET_2D_BC3,
};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::compressed_formats::is_compressed_format;
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const DEFAULT_SIZE: u32 = 64;

#[derive(Clone, Copy)]
struct Params {
    image_type: vk::ImageType,
    format: vk::Format,
    view_format: vk::Format,
}

impl Params {
    fn compressed(&self) -> bool {
        is_compressed_format(self.format)
    }

    /// The extent as `ImageParms` holds it: blocks for a compressed format.
    fn extent(&self) -> [u32; 3] {
        [
            DEFAULT_SIZE,
            if self.image_type == vk::ImageType::_1D {
                1
            } else {
                DEFAULT_SIZE
            },
            1,
        ]
    }

    fn image_parms(&self, fill_mode: FillMode) -> ImageParms {
        ImageParms {
            image_type: self.image_type,
            format: self.format,
            extent: self.extent(),
            tiling: vk::ImageTiling::OPTIMAL,
            fill_mode,
            create_flags: None,
        }
    }

    /// `getSizeInBlocks` of the extent: what the sampling pass renders and the compute shaders fill and verify.
    fn size_in_blocks(&self) -> [u32; 2] {
        let [width, height, _] = self.extent();
        if self.compressed() {
            [
                width / 4,
                if self.image_type == vk::ImageType::_1D {
                    1
                } else {
                    height / 4
                },
            ]
        } else {
            [width, height]
        }
    }

    fn view_type(&self) -> vk::ImageViewType {
        if self.image_type == vk::ImageType::_1D {
            vk::ImageViewType::_1D
        } else {
            vk::ImageViewType::_2D
        }
    }
}

fn create_image<'a>(
    context: &'a Context<'a>,
    image_type: vk::ImageType,
    format: vk::Format,
    extent: vk::Extent3D,
    flags: vk::ImageCreateFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        image_type,
        format,
        extent,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

fn color_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn stage(stage: vk::ShaderStageFlags, module: vk::ShaderModule) -> vk::PipelineShaderStageCreateInfo {
    vk::PipelineShaderStageCreateInfo::builder()
        .stage(stage)
        .module(module)
        .name(b"main\0")
        .build()
}

fn storage_image_set<'a>(
    context: &'a Context<'a>,
    views: [vk::ImageView; 2],
) -> Result<
    (
        Unique<'a, vk::DescriptorSetLayout>,
        Unique<'a, vk::DescriptorPool>,
        crate::vk::ref_util::UniqueDescriptorSet<'a>,
    ),
    TestError,
> {
    let device = context.get_device();
    let layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set = make_descriptor_set(device, *pool, *layout)?;
    let infos = [
        vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: views[0],
            image_layout: vk::ImageLayout::GENERAL,
        },
        vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: views[1],
            image_layout: vk::ImageLayout::GENERAL,
        },
    ];
    let writes = [
        vk::WriteDescriptorSet {
            dst_set: *set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
            image_info: &infos[0],
            ..Default::default()
        },
        vk::WriteDescriptorSet {
            dst_set: *set,
            dst_binding: 1,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
            image_info: &infos[1],
            ..Default::default()
        },
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
    Ok((layout, pool, set))
}

fn image_barriers(
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

/// `fillCompressedImages`
fn fill_compressed_images(
    context: &Context<'_>,
    params: &Params,
    source: vk::Image,
    destination: vk::Image,
) -> Result<(), TestError> {
    let device = context.get_device();
    let range = color_range();
    let src_view = make_image_view(device, source, params.view_type(), params.view_format, range)?;
    let dst_view = make_image_view(device, destination, params.view_type(), params.view_format, range)?;
    let (set_layout, _pool, set) = storage_image_set(context, [*src_view, *dst_view])?;
    let module = create_shader_module(device, context.get_binary_collection().get("compFill")?)?;
    let layout = make_pipeline_layout(device, &[*set_layout])?;
    let stage_info = stage(vk::ShaderStageFlags::COMPUTE, *module);
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage_info)
        .layout(*layout)
        .base_pipeline_index(0);
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );
    let [width, height] = params.size_in_blocks();

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        &[
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                source,
                range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                destination,
                range,
            ),
        ],
    );
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_bind_descriptor_sets(cmd, vk::PipelineBindPoint::COMPUTE, *layout, 0, &[*set], &[] as &[u32]);
        device.cmd_dispatch(cmd, width, height, 1);
    }
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        vk::PipelineStageFlags::TRANSFER,
        &[
            make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                source,
                range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                destination,
                range,
            ),
        ],
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)
}

/// `checkTestResult(testImage, ...)`: a compute shader compares the image with the blue it should hold and writes green or red.
fn verify_compressed(
    context: &Context<'_>,
    params: &Params,
    test_image: vk::Image,
    last_access: vk::AccessFlags,
    last_layout: vk::ImageLayout,
    last_stage: vk::PipelineStageFlags,
) -> TestOutcome {
    let device = context.get_device();
    let range = color_range();
    let [width, height] = params.size_in_blocks();
    let output_format = vk::Format::R8G8B8A8_UNORM;
    let output_image = create_image(
        context,
        params.image_type,
        output_format,
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        vk::ImageCreateFlags::empty(),
        vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
    )?;
    let test_view = make_image_view(device, test_image, params.view_type(), params.view_format, range)?;
    let output_view = make_image_view(device, output_image.get(), params.view_type(), output_format, range)?;
    let (set_layout, _pool, set) = storage_image_set(context, [*test_view, *output_view])?;
    let module = create_shader_module(device, context.get_binary_collection().get("compVerify")?)?;
    let layout = make_pipeline_layout(device, &[*set_layout])?;
    let stage_info = stage(vk::ShaderStageFlags::COMPUTE, *module);
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage_info)
        .layout(*layout)
        .base_pipeline_index(0);
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    let result_size = u64::from(width * height * 4);
    let result_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(result_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::TRANSFER,
        &[make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            output_image.get(),
            range,
        )],
    );
    let black = vk::ClearColorValue {
        float32: [0.0, 0.0, 0.0, 1.0],
    };
    unsafe {
        device.cmd_clear_color_image(
            cmd,
            output_image.get(),
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &black,
            &[range],
        )
    };
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        &[make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            output_image.get(),
            range,
        )],
    );
    image_barriers(
        device,
        cmd,
        last_stage,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        &[make_image_memory_barrier(
            last_access,
            vk::AccessFlags::SHADER_WRITE,
            last_layout,
            vk::ImageLayout::GENERAL,
            test_image,
            range,
        )],
    );
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_bind_descriptor_sets(cmd, vk::PipelineBindPoint::COMPUTE, *layout, 0, &[*set], &[] as &[u32]);
        device.cmd_dispatch(cmd, width, height, 1);
    }
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        vk::PipelineStageFlags::TRANSFER,
        &[make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            output_image.get(),
            range,
        )],
    );
    copy_to_buffer(
        device,
        cmd,
        output_image.get(),
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        result_buffer.get(),
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, result_buffer.get_allocation())?;
    let pixels = unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr().cast_const(),
            result_size as usize,
        )
    };
    let expected = [0.0f32, 1.0, 0.0, 1.0];
    for pixel in pixels.chunks_exact(4) {
        if (0..4).any(|c| (f32::from(pixel[c]) / 255.0 - expected[c]).abs() > 0.01) {
            return Ok(TestStatus::fail("Fail"));
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `copyImageToBuffer` of an image already in TRANSFER_SRC_OPTIMAL, followed by the host read barrier.
fn copy_to_buffer(device: &Device, cmd: vk::CommandBuffer, image: vk::Image, extent: vk::Extent3D, buffer: vk::Buffer) {
    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        },
        image_offset: vk::Offset3D::default(),
        image_extent: extent,
    };
    let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_copy_image_to_buffer(cmd, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]);
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[host_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

struct ReinterpretCase {
    name: String,
    params: Params,
    programs: fn() -> BinaryCollection,
}

impl TestCase for ReinterpretCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let p = &self.params;
        let usage = vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::SAMPLED
            | vk::ImageUsageFlags::STORAGE;
        let mut flags = vk::ImageCreateFlags::MUTABLE_FORMAT;
        if p.compressed() {
            flags |= vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE | vk::ImageCreateFlags::EXTENDED_USAGE;
            if !context.is_device_functionality_supported("VK_KHR_maintenance2") {
                return Err(TestError::NotSupported(
                    "Device does not support extended image usage flags nor overriding implicit usage flags"
                        .to_string(),
                ));
            }
        }
        if unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                p.format,
                p.image_type,
                vk::ImageTiling::OPTIMAL,
                usage,
                flags,
            )
        }
        .is_err()
        {
            return Err(TestError::NotSupported("Image format not supported".to_string()));
        }
        let output_usage =
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE;
        if unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                p.view_format,
                p.image_type,
                vk::ImageTiling::OPTIMAL,
                output_usage,
                vk::ImageCreateFlags::empty(),
            )
        }
        .is_err()
        {
            return Err(TestError::NotSupported("Image format not supported".to_string()));
        }
        let limits = unsafe { instance.get_physical_device_properties(physical_device) }.limits;
        let [width, height, _] = p.extent();
        if p.image_type == vk::ImageType::_1D && width > limits.max_image_dimension_1d {
            return Err(TestError::NotSupported(
                "Requested 1D src image dimensions not supported".to_string(),
            ));
        }
        if p.image_type == vk::ImageType::_2D
            && (width > limits.max_image_dimension_2d || height > limits.max_image_dimension_2d)
        {
            return Err(TestError::NotSupported(
                "Requested 2D src image dimensions not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        (self.programs)()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ReinterpretInstance {
            context,
            params: self.params,
        })
    }
}

struct ReinterpretInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for ReinterpretInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let families = [queue_family_index];
        let p = self.params;
        let compressed = p.compressed();
        let range = color_range();
        let src_parms = p.image_parms(FillMode::Red);
        let dst_parms = p.image_parms(FillMode::Red);
        let [out_width, out_height] = p.size_in_blocks();
        let output_extent = vk::Extent3D {
            width: out_width,
            height: out_height,
            depth: 1,
        };

        let mut src_flags = vk::ImageCreateFlags::MUTABLE_FORMAT;
        if compressed {
            src_flags |= vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE | vk::ImageCreateFlags::EXTENDED_USAGE;
        }
        let source = create_image(
            context,
            p.image_type,
            p.format,
            src_parms.extent_3d(),
            src_flags,
            vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST
                | vk::ImageUsageFlags::SAMPLED
                | vk::ImageUsageFlags::STORAGE,
        )?;
        let destination = create_image(
            context,
            p.image_type,
            p.format,
            dst_parms.extent_3d(),
            src_flags,
            vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::STORAGE,
        )?;

        // Initialize the source and destination images.
        let size_compatible = get_size_compatible_tcu_texture_format(p.format)
            .ok_or_else(|| TestError::NotSupported("format has no texture format".to_string()))?;
        let output_tcu_format = get_size_compatible_tcu_texture_format(p.view_format)
            .ok_or_else(|| TestError::NotSupported("view format has no texture format".to_string()))?;
        let [width, height, depth] = p.extent();
        let mut source_level = TextureLevel::new(size_compatible, width, height, depth)?;
        if compressed {
            fill_compressed_images(context, &p, source.get(), destination.get())?;
        } else {
            generate_buffer(
                &mut source_level.get_access(),
                width,
                height,
                depth,
                FillMode::Red,
                false,
            );
            let mut destination_level = TextureLevel::new(size_compatible, width, height, depth)?;
            destination_level.data_mut().fill(0);
            upload_image(
                context,
                &source_level.get_const_access(),
                source.get(),
                &src_parms,
                false,
                &families,
                false,
            )?;
            upload_image(
                context,
                &destination_level.get_const_access(),
                destination.get(),
                &dst_parms,
                false,
                &families,
                false,
            )?;
        }

        // The copy areas: the whole image, in texels.
        let extent = src_parms.extent_3d();
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };
        let region = vk::ImageCopy {
            src_subresource: layers,
            src_offset: vk::Offset3D::default(),
            dst_subresource: layers,
            dst_offset: vk::Offset3D::default(),
            extent,
        };

        // The view of the source in the view format, sampled by the fragment shader.
        let source_view = make_image_view(device, source.get(), p.view_type(), p.view_format, range)?;
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .max_lod(1.0);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        let image_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *source_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let write = vk::WriteDescriptorSet {
            dst_set: *set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            image_info: &image_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // The image the sampling pass renders to.
        let output_image = create_image(
            context,
            p.image_type,
            p.view_format,
            output_extent,
            vk::ImageCreateFlags::empty(),
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE,
        )?;
        let render_pass = make_render_pass(device, p.view_format)?;
        let output_view = make_image_view(device, output_image.get(), p.view_type(), p.view_format, range)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*output_view], out_width, out_height, 1)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
        let stages = [
            stage(vk::ShaderStageFlags::VERTEX, *vert_module),
            stage(vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: out_width as f32,
            height: out_height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, out_width, out_height)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder();
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipeline = crate::vk::pipeline_construction::create_graphics_pipeline(device, &pipeline_info)?;

        let result_size = u64::from(out_width * out_height * output_tcu_format.pixel_size().unwrap_or(4));
        let result_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(result_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Copy, then sample the source image.
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        let (copy_src_access, copy_src_stage) = if compressed {
            (vk::AccessFlags::SHADER_WRITE, vk::PipelineStageFlags::COMPUTE_SHADER)
        } else {
            (vk::AccessFlags::TRANSFER_WRITE, vk::PipelineStageFlags::TRANSFER)
        };
        image_barriers(
            device,
            cmd,
            copy_src_stage,
            vk::PipelineStageFlags::TRANSFER,
            &[
                make_image_memory_barrier(
                    copy_src_access,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    source.get(),
                    range,
                ),
                make_image_memory_barrier(
                    copy_src_access,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    destination.get(),
                    range,
                ),
            ],
        );
        unsafe {
            device.cmd_copy_image(
                cmd,
                source.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                destination.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[region],
            )
        };

        // The barrier omits SHADER_READ on purpose, as upstream's.
        image_barriers(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            &[make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_READ,
                vk::AccessFlags::empty(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                source.get(),
                range,
            )],
        );
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [1.0, 1.0, 1.0, 1.0],
            },
        };
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, out_width, out_height),
            clear_value,
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*set],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 6, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        if !compressed {
            image_barriers(
                device,
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                &[make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    output_image.get(),
                    range,
                )],
            );
            copy_to_buffer(device, cmd, output_image.get(), output_extent, result_buffer.get());
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Check the copy.
        if !compressed {
            let mut result_level = TextureLevel::new(size_compatible, width, height, depth)?;
            read_image(
                context,
                destination.get(),
                &dst_parms,
                &mut result_level,
                false,
                &families,
            )?;
            if !float_threshold_compare(
                &source_level.get_const_access(),
                &result_level.get_const_access(),
                [0.01; 4],
            )
            .ok
            {
                return Ok(TestStatus::fail("Copy test"));
            }
        } else {
            let status = verify_compressed(
                context,
                &p,
                destination.get(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::PipelineStageFlags::TRANSFER,
            )?;
            if status.is_fail() {
                return Ok(TestStatus::fail("Copy test"));
            }
        }

        // Check the sampling: the source bytes read as the view format.
        if !compressed {
            invalidate_alloc(device, result_buffer.get_allocation())?;
            let result_bytes = unsafe {
                std::slice::from_raw_parts(
                    result_buffer.get_allocation().get_host_ptr().cast_const(),
                    result_size as usize,
                )
            };
            let result_pixels =
                ConstPixelBufferAccess::new(output_tcu_format, [out_width, out_height, 1], result_bytes);
            let expected_pixels =
                ConstPixelBufferAccess::new(output_tcu_format, [width, height, depth], source_level.data());
            if !float_threshold_compare(&expected_pixels, &result_pixels, [0.01; 4]).ok {
                return Ok(TestStatus::fail("Sampling test"));
            }
        } else {
            let status = verify_compressed(
                context,
                &p,
                output_image.get(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
            )?;
            if status.is_fail() {
                return Ok(TestStatus::fail("Sampling test"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createReinterpretationTests`
pub fn create_reinterpretation_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("reinterpret");
    type Programs = fn() -> BinaryCollection;
    let cases: [(&str, vk::ImageType, [(&str, vk::Format, vk::Format, Programs); 3]); 2] = [
        (
            "1d",
            vk::ImageType::_1D,
            [
                (
                    "b10g11r11_ufloat_pack32_sample_r16g16_sfloat",
                    vk::Format::B10G11R11_UFLOAT_PACK32,
                    vk::Format::R16G16_SFLOAT,
                    || REINTERPRET_1D_B10G11R11.programs,
                ),
                (
                    "bc1_rgb_unorm_block_sample_r32g32_uint",
                    vk::Format::BC1_RGB_UNORM_BLOCK,
                    vk::Format::R32G32_UINT,
                    || REINTERPRET_1D_BC1.programs,
                ),
                (
                    "bc3_unorm_block_sample_r32g32b32a32_uint",
                    vk::Format::BC3_UNORM_BLOCK,
                    vk::Format::R32G32B32A32_UINT,
                    || REINTERPRET_1D_BC3.programs,
                ),
            ],
        ),
        (
            "2d",
            vk::ImageType::_2D,
            [
                (
                    "b10g11r11_ufloat_pack32_sample_r16g16_sfloat",
                    vk::Format::B10G11R11_UFLOAT_PACK32,
                    vk::Format::R16G16_SFLOAT,
                    || REINTERPRET_2D_B10G11R11.programs,
                ),
                (
                    "bc1_rgb_unorm_block_sample_r32g32_uint",
                    vk::Format::BC1_RGB_UNORM_BLOCK,
                    vk::Format::R32G32_UINT,
                    || REINTERPRET_2D_BC1.programs,
                ),
                (
                    "bc3_unorm_block_sample_r32g32b32a32_uint",
                    vk::Format::BC3_UNORM_BLOCK,
                    vk::Format::R32G32B32A32_UINT,
                    || REINTERPRET_2D_BC3.programs,
                ),
            ],
        ),
    ];
    for (dim_name, image_type, pairs) in cases {
        let mut dim_group = TestCaseGroup::new(dim_name);
        for (name, format, view_format, programs) in pairs {
            dim_group.add_child(Box::new(ReinterpretCase {
                name: format!("copy_{name}"),
                params: Params {
                    image_type,
                    format,
                    view_format,
                },
                programs,
            }) as Box<dyn TestCase>);
        }
        group.add_child(dim_group);
    }
    group
}
