// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageCompressionTranscodingSupport.cpp (GraphicsAttachmentsTestInstance,
//   GraphicsTextureTestInstance)
//   external/vulkancts/modules/vulkan/image/vktImageTestsUtil.cpp (makeRenderPass, makeGraphicsPipeline, makeBufferImageCopy)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two upstream classes (the texture one derives from the attachments one) are a single
// struct with a `texture` flag, and `transcodeRead` / `transcodeWrite` are one function whose differences are selected by the operation. The
// source and destination buffers of the read variant are created per layer like those of the write variant (upstream creates them per level).
// The failure-only image logging is reduced to the verdict.

use vulkanalia::prelude::v1_0::*;

use super::texel_view_compatible_tests::{
    BasicTranscoding, BinaryCompareMode, BinaryCompareResult, Operation, SINGLE_LAYER, SINGLE_LEVEL, TestParameters,
    binary_compare, get_compressed_image_size_in_bytes, make_descriptor_image_info, make_extent_3d, make_view,
    pipeline_barrier, test_status_astc_quality_warning, write_image_descriptor,
};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, end_command_buffer, end_render_pass, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::compressed_formats::{get_block_height, get_block_width};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::create_shader_module;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::image::tests_util::{get_image_size_bytes, get_layer_size, map_image_type, map_image_view_type};
use crate::vkt::{Context, TestInstance};

/// `isCompressedFormat` - the BC, ETC2/EAC and ASTC formats are contiguous in the format enumeration.
fn is_compressed_format(format: vk::Format) -> bool {
    (vk::Format::BC1_RGB_UNORM_BLOCK.as_raw()..=vk::Format::ASTC_12X12_SRGB_BLOCK.as_raw()).contains(&format.as_raw())
}

/// `getCompressedImageResolutionBlockCeil`
fn get_compressed_image_resolution_block_ceil(format: vk::Format, size: [u32; 3]) -> [u32; 3] {
    let block_width = get_block_width(format);
    let block_height = get_block_height(format);
    debug_assert!(size[2] == 1);
    let width_in_blocks = size[0].div_ceil(block_width);
    let height_in_blocks = size[1].div_ceil(block_height);
    [block_width * width_in_blocks, block_height * height_in_blocks, 1]
}

/// `makeBufferImageCopy` with the buffer row length and image height given
fn make_buffer_image_copy_with_rows(
    image_width: u32,
    image_height: u32,
    mip_level: u32,
    layer: u32,
    buffer_row_length: u32,
    buffer_image_height: u32,
) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length,
        buffer_image_height,
        image_subresource: vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level,
            base_array_layer: layer,
            layer_count: 1,
        },
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: image_width,
            height: image_height,
            depth: 1,
        },
    }
}

/// `makeBufferImageCopy` with the buffer layout equal to the image size
fn make_buffer_image_copy(image_width: u32, image_height: u32, mip_level: u32, layer: u32) -> vk::BufferImageCopy {
    make_buffer_image_copy_with_rows(image_width, image_height, mip_level, layer, image_width, image_height)
}

/// `makeSamplerCreateInfo`
fn make_sampler_create_info() -> vk::SamplerCreateInfo {
    vk::SamplerCreateInfo::builder()
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
        .compare_op(vk::CompareOp::NEVER)
        .min_lod(0.0)
        .max_lod(0.25)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false)
        .build()
}

/// `vkt::image::makeRenderPass(vk, device, inputFormat, colorFormat)`
fn make_input_color_render_pass(
    device: &Device,
    input_format: vk::Format,
    color_format: vk::Format,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let input_attachment_refs = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::GENERAL,
    }];
    let color_attachment_refs = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .input_attachments(&input_attachment_refs)
        .color_attachments(&color_attachment_refs)
        .build()];
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(input_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::GENERAL)
            .final_layout(vk::ImageLayout::GENERAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::GENERAL)
            .build(),
    ];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `vk::makeRenderPass(vk, device)` - one subpass, no attachments
fn make_empty_render_pass(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `vkt::image::makeGraphicsPipeline`
#[allow(clippy::too_many_arguments)]
fn make_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    render_size: (u32, u32),
    color_attachment_count: u32,
    dynamic_size: bool,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
    if dynamic_size {
        state.dynamic_states = vec![vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR];
    } else {
        state = state.with_full_viewport(render_size.0, render_size.1);
    }
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0)
        .build();
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: 16,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    state.color_attachment_count = color_attachment_count;
    create_draw_pipeline(
        device,
        pipeline_layout,
        render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, fragment_module),
        ],
        &state,
    )
}

/// `createFullscreenQuad`
fn create_fullscreen_quad() -> [[f32; 4]; 6] {
    let lower_left = [-1.0, -1.0, 0.0, 1.0];
    let upper_left = [-1.0, 1.0, 0.0, 1.0];
    let lower_right = [1.0, -1.0, 0.0, 1.0];
    let upper_right = [1.0, 1.0, 0.0, 1.0];
    [
        lower_left,
        lower_right,
        upper_left,
        upper_left,
        lower_right,
        upper_right,
    ]
}

/// `beginRenderPass` of vktImageTestsUtil: a clear value for the colour attachment (index 1 of the input/colour pass) and one for depth/stencil.
fn begin_render_pass(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    render_area: vk::Rect2D,
) {
    let clear_values = [
        vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        },
        vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
        },
    ];
    let info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(render_area)
        .clear_values(&clear_values);
    unsafe { device.cmd_begin_render_pass(cmd, &info, vk::SubpassContents::INLINE) };
}

/// `GraphicsAttachmentsTestInstance` and, with `texture`, `GraphicsTextureTestInstance`
pub(super) struct GraphicsTestInstance<'a> {
    context: &'a Context<'a>,
    base: BasicTranscoding,
    texture: bool,
    src_data: Vec<Vec<Vec<u8>>>,
    dst_data: Vec<Vec<Vec<u8>>>,
    compressed_image: Option<ImageWithMemory<'a>>,
    compressed_image_res_vec: Vec<[u32; 3]>,
    uncompressed_image_res_vec: Vec<[u32; 3]>,
    src_view_usage: Option<vk::ImageUsageFlags>,
    dst_view_usage: Option<vk::ImageUsageFlags>,
    src_format: vk::Format,
    dst_format: vk::Format,
    src_image_usage_flags: vk::ImageUsageFlags,
    dst_image_usage_flags: vk::ImageUsageFlags,
    src_image_resolutions: Vec<[u32; 3]>,
    dst_image_resolutions: Vec<[u32; 3]>,
    vertex_buffer: Option<BufferWithMemory<'a>>,
    vertex_count: u32,
}

impl<'a> GraphicsTestInstance<'a> {
    pub fn new(context: &'a Context<'a>, parameters: TestParameters) -> Self {
        let texture = matches!(parameters.operation, Operation::TextureRead | Operation::TextureWrite);
        Self {
            context,
            base: BasicTranscoding::new(parameters),
            texture,
            src_data: Vec::new(),
            dst_data: Vec::new(),
            compressed_image: None,
            compressed_image_res_vec: Vec::new(),
            uncompressed_image_res_vec: Vec::new(),
            src_view_usage: None,
            dst_view_usage: None,
            src_format: vk::Format::UNDEFINED,
            dst_format: vk::Format::UNDEFINED,
            src_image_usage_flags: vk::ImageUsageFlags::empty(),
            dst_image_usage_flags: vk::ImageUsageFlags::empty(),
            src_image_resolutions: Vec::new(),
            dst_image_resolutions: Vec::new(),
            vertex_buffer: None,
            vertex_count: 0,
        }
    }

    /// `isWriteToCompressedOperation`
    fn is_write_to_compressed_operation(&self) -> bool {
        let operation = self.base.parameters.operation;
        if self.texture {
            operation == Operation::TextureWrite
        } else {
            operation == Operation::AttachmentWrite
        }
    }

    fn run(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        self.prepare_data();
        self.prepare_vertex_buffer()?;

        let level_count = self.base.get_level_count() as usize;
        let layer_count = self.base.get_layer_count() as usize;
        for level_ndx in 0..level_count {
            for layer_ndx in 0..layer_count {
                debug_assert!(self.src_data[level_ndx][layer_ndx].len() == self.dst_data[level_ndx][layer_ndx].len());
            }
        }

        self.transcode(cmd)?;

        let write = self.is_write_to_compressed_operation();
        let compressed_image = self
            .compressed_image
            .as_ref()
            .map(|image| image.get())
            .expect("transcode creates the compressed image");
        let mut pass = true;
        for level_ndx in 0..level_count {
            for layer_ndx in 0..layer_count {
                let reference = if write {
                    &self.src_data[level_ndx][layer_ndx]
                } else {
                    &self.dst_data[level_ndx][layer_ndx]
                };
                let (ok, astc_warning) = self.verify_decompression(
                    cmd,
                    reference,
                    compressed_image,
                    level_ndx as u32,
                    layer_ndx as u32,
                    self.compressed_image_res_vec[level_ndx],
                )?;
                if !ok {
                    pass = false;
                }
                if astc_warning {
                    self.base.astc_error_colour_mismatch = true;
                }
            }
        }

        if !pass {
            return Ok(TestStatus::fail("Images difference detected"));
        }
        if self.base.astc_error_colour_mismatch {
            debug_assert!(self.base.parameters.format_is_astc());
            return Ok(test_status_astc_quality_warning());
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `getCompressedImageData` / `getUncompressedImageData`
    fn image_data(&self, compressed: bool, format: vk::Format, size: [u32; 3], layer: u32, level: u32) -> Vec<u8> {
        let size_bytes = if compressed {
            get_compressed_image_size_in_bytes(format, size)
        } else {
            get_image_size_bytes([size[0] as i32, size[1] as i32, size[2] as i32], format).unwrap_or(0)
        };
        let mut data = vec![0u8; size_bytes as usize];
        self.base.generate_data(&mut data, format, layer, level);
        data
    }

    fn uncompressed_image_size_in_bytes(format: vk::Format, size: [u32; 3]) -> usize {
        get_image_size_bytes([size[0] as i32, size[1] as i32, size[2] as i32], format).unwrap_or(0) as usize
    }

    /// `prepareData`
    fn prepare_data(&mut self) {
        let parameters = self.base.parameters;
        let write = self.is_write_to_compressed_operation();
        let view_usage = Some(parameters.compressed_image_view_usage);

        self.src_view_usage = if write { None } else { view_usage };
        self.dst_view_usage = if write { view_usage } else { None };

        self.src_format = if write {
            parameters.format_uncompressed
        } else {
            parameters.format_compressed
        };
        self.dst_format = if write {
            parameters.format_compressed
        } else {
            parameters.format_uncompressed
        };

        self.src_image_usage_flags = if write {
            parameters.uncompressed_image_usage
        } else {
            parameters.compressed_image_usage
        };
        self.dst_image_usage_flags = if write {
            parameters.compressed_image_usage
        } else {
            parameters.uncompressed_image_usage
        };

        self.compressed_image_res_vec = self.base.get_mip_level_sizes(self.base.get_layer_dims());
        self.uncompressed_image_res_vec = self
            .base
            .get_compressed_mip_level_sizes(parameters.format_compressed, &self.compressed_image_res_vec);

        self.src_image_resolutions = if write {
            self.uncompressed_image_res_vec.clone()
        } else {
            self.compressed_image_res_vec.clone()
        };
        self.dst_image_resolutions = if write {
            self.compressed_image_res_vec.clone()
        } else {
            self.uncompressed_image_res_vec.clone()
        };

        let level_count = self.base.get_level_count() as usize;
        let layer_count = self.base.get_layer_count() as usize;
        self.src_data = vec![vec![Vec::new(); layer_count]; level_count];
        self.dst_data = vec![vec![Vec::new(); layer_count]; level_count];

        for level_ndx in 0..level_count {
            for layer_ndx in 0..layer_count {
                if write {
                    self.src_data[level_ndx][layer_ndx] = self.image_data(
                        false,
                        self.src_format,
                        self.src_image_resolutions[level_ndx],
                        layer_ndx as u32,
                        level_ndx as u32,
                    );
                    self.dst_data[level_ndx][layer_ndx] = vec![
                        0u8;
                        get_compressed_image_size_in_bytes(self.dst_format, self.dst_image_resolutions[level_ndx])
                            as usize
                    ];
                } else {
                    self.src_data[level_ndx][layer_ndx] = self.image_data(
                        true,
                        self.src_format,
                        self.src_image_resolutions[level_ndx],
                        layer_ndx as u32,
                        level_ndx as u32,
                    );
                    self.dst_data[level_ndx][layer_ndx] = vec![
                        0u8;
                        Self::uncompressed_image_size_in_bytes(
                            self.dst_format,
                            self.dst_image_resolutions[level_ndx]
                        )
                    ];
                }
                debug_assert!(self.src_data[level_ndx][layer_ndx].len() == self.dst_data[level_ndx][layer_ndx].len());
            }
        }
    }

    /// `prepareVertexBuffer`
    fn prepare_vertex_buffer(&mut self) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let vertex_array = create_fullscreen_quad();
        let size_in_bytes = std::mem::size_of_val(&vertex_array);

        self.vertex_count = vertex_array.len() as u32;
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(size_in_bytes as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let vertex_buffer_alloc = vertex_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertex_array.as_ptr().cast::<u8>(),
                    vertex_buffer_alloc.get_host_ptr(),
                    size_in_bytes,
                )
            };
            flush_alloc(device, vertex_buffer_alloc)?;
        }
        self.vertex_buffer = Some(vertex_buffer);
        Ok(())
    }

    /// `makeCreateImageInfo`
    fn make_create_image_info(
        &self,
        format: vk::Format,
        size: [u32; 3],
        usage: vk::ImageUsageFlags,
        create_flags: Option<vk::ImageCreateFlags>,
        levels: u32,
        layers: u32,
    ) -> Result<vk::ImageCreateInfo, TestError> {
        let parameters = self.base.parameters;
        let image_create_flags_base = vk::ImageCreateFlags::MUTABLE_FORMAT;
        let image_create_flags_add_on = if is_compressed_format(format) {
            vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE | vk::ImageCreateFlags::EXTENDED_USAGE
        } else {
            vk::ImageCreateFlags::empty()
        };
        let image_create_flags = create_flags.unwrap_or(image_create_flags_base | image_create_flags_add_on);

        let properties = unsafe {
            self.context
                .get_instance()
                .get_physical_device_format_properties(self.context.get_physical_device(), format)
        };
        let features = properties.optimal_tiling_features;
        if usage.contains(vk::ImageUsageFlags::STORAGE) && !features.contains(vk::FormatFeatureFlags::STORAGE_IMAGE) {
            return Err(TestError::NotSupported(
                "Format storage feature not supported".to_string(),
            ));
        }
        if usage.contains(vk::ImageUsageFlags::COLOR_ATTACHMENT)
            && !features.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
        {
            return Err(TestError::NotSupported(
                "Format color attachment feature not supported".to_string(),
            ));
        }
        if usage.contains(vk::ImageUsageFlags::INPUT_ATTACHMENT)
            && !features.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
            && !features.contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Err(TestError::NotSupported(
                "Format color/depth/stencil attachment feature not supported for input attachment usage".to_string(),
            ));
        }

        Ok(vk::ImageCreateInfo::builder()
            .flags(image_create_flags)
            .image_type(map_image_type(parameters.image_type))
            .format(format)
            .extent(make_extent_3d(get_layer_size(parameters.image_type, size)))
            .mip_levels(levels)
            .array_layers(layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build())
    }

    /// `transcodeRead` and `transcodeWrite`, of the attachment and the texture instance
    fn transcode(&mut self, cmd: vk::CommandBuffer) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let parameters = self.base.parameters;
        let write = self.is_write_to_compressed_operation();
        let texture = self.texture;
        let view_type = map_image_view_type(parameters.image_type).expect("image type has a view type");
        let level_count = self.base.get_level_count();
        let layer_count = self.base.get_layer_count();

        // The mipmapped, layered image is the destination when writing and the source when reading.
        let compressed_image_create_info = if write {
            self.make_create_image_info(
                self.dst_format,
                self.dst_image_resolutions[0],
                self.dst_image_usage_flags,
                None,
                level_count,
                layer_count,
            )?
        } else {
            self.make_create_image_info(
                self.src_format,
                self.src_image_resolutions[0],
                self.src_image_usage_flags,
                None,
                level_count,
                layer_count,
            )?
        };
        let compressed_image =
            ImageWithMemory::new(device, alloc, compressed_image_create_info, MemoryRequirement::ANY)?;
        let compressed_handle = compressed_image.get();

        let binaries = context.get_binary_collection();
        let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader_module = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = if texture {
            make_empty_render_pass(device)?
        } else {
            make_input_color_render_pass(device, parameters.format_uncompressed, parameters.format_uncompressed)?
        };

        let descriptor_set_layout = if texture {
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    vk::ShaderStageFlags::FRAGMENT,
                )
                .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?
        } else {
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?
        };
        let descriptor_pool = if texture {
            DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?
        } else {
            DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?
        };
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_shader_module,
            *frag_shader_module,
            (1, 1),
            if texture { 0 } else { 1 },
            true,
        )?;

        let single_range = |level: u32, layer: u32| {
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, level, SINGLE_LEVEL, layer, SINGLE_LAYER)
        };
        let vertex_buffer = self.vertex_buffer.as_ref().expect("prepare_vertex_buffer ran").get();

        for level_ndx in 0..level_count {
            let uncompressed_image_res = self.uncompressed_image_res_vec[level_ndx as usize];
            let src_image_resolution = self.src_image_resolutions[level_ndx as usize];
            let dst_image_resolution = self.dst_image_resolutions[level_ndx as usize];
            let src_image_size_in_bytes = self.src_data[level_ndx as usize][0].len();
            let dst_image_size_in_bytes = self.dst_data[level_ndx as usize][0].len();
            let src_image_res_blocked =
                get_compressed_image_resolution_block_ceil(parameters.format_compressed, src_image_resolution);
            let dst_image_res_blocked =
                get_compressed_image_resolution_block_ceil(parameters.format_compressed, dst_image_resolution);

            let render_size = (uncompressed_image_res[0], uncompressed_image_res[1]);
            let viewport = vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: render_size.0 as f32,
                height: render_size.1 as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            };
            let scissor = make_rect_2d(0, 0, render_size.0, render_size.1);

            // The single-layer image: the destination of a read, the source of a write.
            let single_image_create_info = if write {
                self.make_create_image_info(
                    self.src_format,
                    src_image_resolution,
                    self.src_image_usage_flags,
                    None,
                    SINGLE_LEVEL,
                    SINGLE_LAYER,
                )?
            } else {
                self.make_create_image_info(
                    self.dst_format,
                    dst_image_resolution,
                    self.dst_image_usage_flags,
                    None,
                    SINGLE_LEVEL,
                    SINGLE_LAYER,
                )?
            };

            for layer_ndx in 0..layer_count {
                let src_image_buffer = BufferWithMemory::new(
                    device,
                    alloc,
                    make_buffer_create_info(
                        src_image_size_in_bytes as vk::DeviceSize,
                        vk::BufferUsageFlags::TRANSFER_SRC,
                    ),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                let dst_image_buffer = BufferWithMemory::new(
                    device,
                    alloc,
                    make_buffer_create_info(
                        dst_image_size_in_bytes as vk::DeviceSize,
                        vk::BufferUsageFlags::TRANSFER_DST,
                    ),
                    MemoryRequirement::HOST_VISIBLE,
                )?;

                let single_image =
                    ImageWithMemory::new(device, alloc, single_image_create_info, MemoryRequirement::ANY)?;
                let (src_image, dst_image) = if write {
                    (single_image.get(), compressed_handle)
                } else {
                    (compressed_handle, single_image.get())
                };

                let (src_subresource_range, dst_subresource_range) = if write {
                    (single_range(0, 0), single_range(level_ndx, layer_ndx))
                } else {
                    (single_range(level_ndx, layer_ndx), single_range(0, 0))
                };

                let src_image_view = make_view(
                    device,
                    src_image,
                    view_type,
                    parameters.format_uncompressed,
                    src_subresource_range,
                    self.src_view_usage,
                )?;
                let dst_image_view = make_view(
                    device,
                    dst_image,
                    view_type,
                    parameters.format_uncompressed,
                    dst_subresource_range,
                    self.dst_view_usage,
                )?;

                let src_copy_region = if write {
                    make_buffer_image_copy(src_image_resolution[0], src_image_resolution[1], 0, 0)
                } else {
                    make_buffer_image_copy_with_rows(
                        src_image_resolution[0],
                        src_image_resolution[1],
                        level_ndx,
                        layer_ndx,
                        src_image_res_blocked[0],
                        src_image_res_blocked[1],
                    )
                };
                let dst_copy_region = if write {
                    make_buffer_image_copy_with_rows(
                        dst_image_resolution[0],
                        dst_image_resolution[1],
                        level_ndx,
                        layer_ndx,
                        dst_image_res_blocked[0],
                        dst_image_res_blocked[1],
                    )
                } else {
                    make_buffer_image_copy(dst_image_resolution[0], dst_image_resolution[1], 0, 0)
                };

                let src_copy_buffer_barrier_pre = make_buffer_memory_barrier(
                    vk::AccessFlags::HOST_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    src_image_buffer.get(),
                    0,
                    src_image_size_in_bytes as vk::DeviceSize,
                );
                let src_copy_image_barrier_pre = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    src_image,
                    src_subresource_range,
                );
                let src_read_access = if !texture && write {
                    vk::AccessFlags::INPUT_ATTACHMENT_READ
                } else {
                    vk::AccessFlags::SHADER_READ
                };
                let src_copy_image_barrier_post = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    src_read_access,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    src_image,
                    src_subresource_range,
                );
                let (dst_init_access, dst_init_layout, dst_init_stage) = match (texture, write) {
                    (false, false) => (
                        vk::AccessFlags::SHADER_READ,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                    ),
                    (false, true) => (
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::GENERAL,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    ),
                    (true, false) => (
                        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                        vk::ImageLayout::GENERAL,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                    ),
                    (true, true) => (
                        vk::AccessFlags::SHADER_READ,
                        vk::ImageLayout::GENERAL,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                    ),
                };
                let dst_init_image_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    dst_init_access,
                    vk::ImageLayout::UNDEFINED,
                    dst_init_layout,
                    dst_image,
                    dst_subresource_range,
                );

                let framebuffer_size = if !texture && write {
                    render_size
                } else {
                    (dst_image_resolution[0], dst_image_resolution[1])
                };
                let attachment_bind_infos = [*src_image_view, *dst_image_view];
                let framebuffer = make_framebuffer(
                    device,
                    *render_pass,
                    if texture {
                        &attachment_bind_infos[..0]
                    } else {
                        &attachment_bind_infos[..]
                    },
                    framebuffer_size.0,
                    framebuffer_size.1,
                    SINGLE_LAYER,
                )?;

                // Upload source image data
                {
                    let buffer_alloc = src_image_buffer.get_allocation();
                    unsafe {
                        std::ptr::copy_nonoverlapping(
                            self.src_data[level_ndx as usize][layer_ndx as usize].as_ptr(),
                            buffer_alloc.get_host_ptr(),
                            src_image_size_in_bytes,
                        )
                    };
                    flush_alloc(device, buffer_alloc)?;
                }

                begin_command_buffer(device, cmd)?;
                unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline) };

                // Copy buffer to image
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    &[src_copy_buffer_barrier_pre],
                    &[src_copy_image_barrier_pre],
                );
                unsafe {
                    device.cmd_copy_buffer_to_image(
                        cmd,
                        src_image_buffer.get(),
                        src_image,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[src_copy_region],
                    )
                };
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    &[],
                    &[src_copy_image_barrier_post],
                );

                // Define destination image layout
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    dst_init_stage,
                    &[],
                    &[dst_init_image_barrier],
                );

                begin_render_pass(
                    device,
                    cmd,
                    *render_pass,
                    *framebuffer,
                    make_rect_2d(0, 0, render_size.0, render_size.1),
                );

                let set = descriptor_set.get();
                // The sampler has to outlive the submission below.
                let sampler_info = make_sampler_create_info();
                let src_sampler = if texture {
                    Some(Unique::new(
                        device,
                        unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
                    ))
                } else {
                    None
                };
                if let Some(sampler) = &src_sampler {
                    let descriptor_src_image =
                        make_descriptor_image_info(**sampler, *src_image_view, vk::ImageLayout::GENERAL);
                    let descriptor_dst_image =
                        make_descriptor_image_info(vk::Sampler::null(), *dst_image_view, vk::ImageLayout::GENERAL);
                    write_image_descriptor(
                        device,
                        set,
                        0,
                        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                        &descriptor_src_image,
                    );
                    write_image_descriptor(device, set, 1, vk::DescriptorType::STORAGE_IMAGE, &descriptor_dst_image);
                } else {
                    let descriptor_src_image =
                        make_descriptor_image_info(vk::Sampler::null(), *src_image_view, vk::ImageLayout::GENERAL);
                    write_image_descriptor(
                        device,
                        set,
                        0,
                        vk::DescriptorType::INPUT_ATTACHMENT,
                        &descriptor_src_image,
                    );
                }

                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout,
                        0,
                        &[set],
                        &[] as &[u32],
                    );
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
                    device.cmd_set_viewport(cmd, 0, &[viewport]);
                    device.cmd_set_scissor(cmd, 0, &[scissor]);
                    device.cmd_draw(cmd, self.vertex_count, 1, 0, 0);
                }

                end_render_pass(device, cmd);

                let (transfer_src_access, transfer_src_stage) = if texture {
                    (vk::AccessFlags::SHADER_WRITE, vk::PipelineStageFlags::FRAGMENT_SHADER)
                } else {
                    (
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    )
                };
                let prepare_for_transfer_barrier = make_image_memory_barrier(
                    transfer_src_access,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::GENERAL,
                    dst_image,
                    dst_subresource_range,
                );
                let copy_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    dst_image_buffer.get(),
                    0,
                    dst_image_size_in_bytes as vk::DeviceSize,
                );

                pipeline_barrier(
                    device,
                    cmd,
                    transfer_src_stage,
                    vk::PipelineStageFlags::TRANSFER,
                    &[],
                    &[prepare_for_transfer_barrier],
                );
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        dst_image,
                        vk::ImageLayout::GENERAL,
                        dst_image_buffer.get(),
                        &[dst_copy_region],
                    )
                };
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    &[copy_barrier],
                    &[],
                );

                end_command_buffer(device, cmd)?;
                submit_commands_and_wait(device, queue, cmd)?;

                let dst_image_buffer_alloc = dst_image_buffer.get_allocation();
                invalidate_alloc(device, dst_image_buffer_alloc)?;
                let result = unsafe {
                    std::slice::from_raw_parts(dst_image_buffer_alloc.get_host_ptr(), dst_image_size_in_bytes)
                };
                self.dst_data[level_ndx as usize][layer_ndx as usize].copy_from_slice(result);
            }
        }

        self.compressed_image = Some(compressed_image);
        Ok(())
    }

    /// `verifyDecompression`. Returns whether the images agree, and whether an ASTC error colour mismatch was seen.
    fn verify_decompression(
        &self,
        cmd: vk::CommandBuffer,
        ref_compressed_data: &[u8],
        res_compressed_image: vk::Image,
        level: u32,
        layer: u32,
        mipmap_dims: [u32; 3],
    ) -> Result<(bool, bool), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let parameters = self.base.parameters;
        let view_type = map_image_view_type(parameters.image_type).expect("image type has a view type");

        let layout_shader_read_only = layer % 2 == 1;
        let sampled_layout = if layout_shader_read_only {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        } else {
            vk::ImageLayout::GENERAL
        };
        let mipmap_dims_blocked = get_compressed_image_resolution_block_ceil(parameters.format_compressed, mipmap_dims);

        let subresource_range =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, SINGLE_LEVEL, 0, SINGLE_LAYER);
        let res_subresource_range =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, level, SINGLE_LEVEL, layer, SINGLE_LAYER);

        let dst_buffer_size = Self::uncompressed_image_size_in_bytes(parameters.format_for_verify, mipmap_dims);
        let ref_src_image_usage_flags =
            vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

        let ref_src_image_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                ref_compressed_data.len() as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let ref_src_image_create_info = self.make_create_image_info(
            parameters.format_compressed,
            mipmap_dims_blocked,
            ref_src_image_usage_flags,
            Some(vk::ImageCreateFlags::empty()),
            SINGLE_LEVEL,
            SINGLE_LAYER,
        )?;
        let ref_src_image = ImageWithMemory::new(device, alloc, ref_src_image_create_info, MemoryRequirement::ANY)?;
        let ref_src_image_view = make_view(
            device,
            ref_src_image.get(),
            view_type,
            parameters.format_compressed,
            subresource_range,
            None,
        )?;

        let res_src_image_view = make_view(
            device,
            res_compressed_image,
            view_type,
            parameters.format_compressed,
            res_subresource_range,
            Some(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST),
        )?;

        let dst_image_usage_flags =
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC;
        let ref_dst_image_create_info = self.make_create_image_info(
            parameters.format_for_verify,
            mipmap_dims,
            dst_image_usage_flags,
            Some(vk::ImageCreateFlags::empty()),
            SINGLE_LEVEL,
            SINGLE_LAYER,
        )?;
        let ref_dst_image = ImageWithMemory::new(device, alloc, ref_dst_image_create_info, MemoryRequirement::ANY)?;
        let ref_dst_image_view = make_view(
            device,
            ref_dst_image.get(),
            view_type,
            parameters.format_for_verify,
            subresource_range,
            None,
        )?;
        let ref_dst_init_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            ref_dst_image.get(),
            subresource_range,
        );
        let ref_dst_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(dst_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let res_dst_image_create_info = self.make_create_image_info(
            parameters.format_for_verify,
            mipmap_dims,
            dst_image_usage_flags,
            Some(vk::ImageCreateFlags::empty()),
            SINGLE_LEVEL,
            SINGLE_LAYER,
        )?;
        let res_dst_image = ImageWithMemory::new(device, alloc, res_dst_image_create_info, MemoryRequirement::ANY)?;
        let res_dst_image_view = make_view(
            device,
            res_dst_image.get(),
            view_type,
            parameters.format_for_verify,
            subresource_range,
            None,
        )?;
        let res_dst_init_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            res_dst_image.get(),
            subresource_range,
        );
        let res_dst_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(dst_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let binaries = context.get_binary_collection();
        let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader_module = create_shader_module(device, binaries.get("frag_verify")?)?;

        let render_pass = make_empty_render_pass(device)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let sampler_info = make_sampler_create_info();
        let ref_src_sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let res_src_sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let descriptor_ref_src_image =
            make_descriptor_image_info(*ref_src_sampler, *ref_src_image_view, sampled_layout);
        let descriptor_res_src_image =
            make_descriptor_image_info(*res_src_sampler, *res_src_image_view, sampled_layout);
        let descriptor_ref_dst_image =
            make_descriptor_image_info(vk::Sampler::null(), *ref_dst_image_view, vk::ImageLayout::GENERAL);
        let descriptor_res_dst_image =
            make_descriptor_image_info(vk::Sampler::null(), *res_dst_image_view, vk::ImageLayout::GENERAL);

        let render_size = (mipmap_dims[0], mipmap_dims[1]);
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            *vert_shader_module,
            *frag_shader_module,
            render_size,
            0,
            false,
        )?;

        // VUID-vkCmdCopyBufferToImage-dstImage-00207, VUID-vkCmdCopyBufferToImage-bufferImageHeight-09107
        let copy_buffer_to_image_dims = get_layer_size(parameters.image_type, mipmap_dims_blocked);
        let copy_buffer_to_image_region = if parameters.image_type == super::tests_util::ImageType::OneD {
            make_buffer_image_copy_with_rows(copy_buffer_to_image_dims[0], copy_buffer_to_image_dims[1], 0, 0, 0, 0)
        } else {
            make_buffer_image_copy_with_rows(
                mipmap_dims_blocked[0],
                mipmap_dims_blocked[1],
                0,
                0,
                mipmap_dims_blocked[0],
                mipmap_dims_blocked[1],
            )
        };
        let copy_region = make_buffer_image_copy(mipmap_dims[0], mipmap_dims[1], 0, 0);
        let ref_src_copy_buffer_barrier_pre = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            ref_src_image_buffer.get(),
            0,
            ref_compressed_data.len() as vk::DeviceSize,
        );
        let ref_src_copy_image_barrier_pre = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            ref_src_image.get(),
            subresource_range,
        );
        let ref_src_copy_image_barrier_post = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::GENERAL,
            sampled_layout,
            ref_src_image.get(),
            subresource_range,
        );
        let res_compressed_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::GENERAL,
            sampled_layout,
            res_compressed_image,
            res_subresource_range,
        );

        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[],
            render_size.0,
            render_size.1,
            self.base.get_layer_count(),
        )?;

        // Upload source image data
        {
            let buffer_alloc = ref_src_image_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    ref_compressed_data.as_ptr(),
                    buffer_alloc.get_host_ptr(),
                    ref_compressed_data.len(),
                )
            };
            flush_alloc(device, buffer_alloc)?;
        }

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline) };

        // Copy buffer to image
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            &[ref_src_copy_buffer_barrier_pre],
            &[ref_src_copy_image_barrier_pre],
        );
        unsafe {
            device.cmd_copy_buffer_to_image(
                cmd,
                ref_src_image_buffer.get(),
                ref_src_image.get(),
                vk::ImageLayout::GENERAL,
                &[copy_buffer_to_image_region],
            )
        };
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            &[],
            &[ref_src_copy_image_barrier_post],
        );

        // Make reference and result images readable
        for barrier in [
            ref_dst_init_image_barrier,
            res_dst_init_image_barrier,
            res_compressed_image_barrier,
        ] {
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                &[],
                &[barrier],
            );
        }

        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, render_size.0, render_size.1),
        );
        {
            let set = descriptor_set.get();
            write_image_descriptor(
                device,
                set,
                0,
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                &descriptor_ref_src_image,
            );
            write_image_descriptor(
                device,
                set,
                1,
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                &descriptor_res_src_image,
            );
            write_image_descriptor(
                device,
                set,
                2,
                vk::DescriptorType::STORAGE_IMAGE,
                &descriptor_ref_dst_image,
            );
            write_image_descriptor(
                device,
                set,
                3,
                vk::DescriptorType::STORAGE_IMAGE,
                &descriptor_res_dst_image,
            );

            let vertex_buffer = self.vertex_buffer.as_ref().expect("prepare_vertex_buffer ran").get();
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[set],
                    &[] as &[u32],
                );
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
                device.cmd_draw(cmd, self.vertex_count, 1, 0, 0);
            }
        }
        end_render_pass(device, cmd);

        // Decompress reference image, then result image
        for (dst_image, dst_buffer) in [
            (ref_dst_image.get(), ref_dst_buffer.get()),
            (res_dst_image.get(), res_dst_buffer.get()),
        ] {
            let dst_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                dst_image,
                subresource_range,
            );
            let dst_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                dst_buffer,
                0,
                dst_buffer_size as vk::DeviceSize,
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                &[],
                &[dst_image_barrier],
            );
            unsafe {
                device.cmd_copy_image_to_buffer(cmd, dst_image, vk::ImageLayout::GENERAL, dst_buffer, &[copy_region])
            };
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                &[dst_buffer_barrier],
                &[],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Compare decompressed pixel data in reference and result images
        let ref_dst_buffer_alloc = ref_dst_buffer.get_allocation();
        invalidate_alloc(device, ref_dst_buffer_alloc)?;
        let res_dst_buffer_alloc = res_dst_buffer.get_allocation();
        invalidate_alloc(device, res_dst_buffer_alloc)?;
        let ref_bytes = unsafe { std::slice::from_raw_parts(ref_dst_buffer_alloc.get_host_ptr(), dst_buffer_size) };
        let res_bytes = unsafe { std::slice::from_raw_parts(res_dst_buffer_alloc.get_host_ptr(), dst_buffer_size) };

        let compare_mode = if parameters.format_is_astc() {
            BinaryCompareMode::AllowAstcErrorColourWarning
        } else {
            BinaryCompareMode::Normal
        };
        match binary_compare(ref_bytes, res_bytes, compare_mode) {
            BinaryCompareResult::Failed => {
                let format = map_vk_format(parameters.format_for_verify).expect("the verify format has a tcu format");
                let size = [render_size.0, render_size.1, 1];
                let res_pixels = ConstPixelBufferAccess::new(format, size, res_bytes);
                let ref_pixels = ConstPixelBufferAccess::new(format, size, ref_bytes);
                // Only the verdict is kept; upstream logs the error mask of the fuzzy comparison here.
                let _ = fuzzy_compare_ok(&ref_pixels, &res_pixels, 0.001);
                Ok((false, false))
            }
            BinaryCompareResult::AstcQualityWarning => Ok((true, true)),
            BinaryCompareResult::Ok => Ok((true, false)),
        }
    }
}

impl TestInstance for GraphicsTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}
